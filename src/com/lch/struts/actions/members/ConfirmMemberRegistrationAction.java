package com.lch.struts.actions.members;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.GenericXmlApplicationContext;

import com.lch.general.constants.VMConstants;
import com.lch.general.dbBeans.Address;
import com.lch.general.email.EmailDetails;
import com.lch.general.enums.DOCTypes;
import com.lch.general.enums.TimeSheetTypes;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.actions.admin.ConfirmRegistrationAction;
import com.lch.struts.formBeans.admin.AdminRegistrationBean;
import com.lch.struts.formBeans.members.EmployeeRegistrationBean;

public class ConfirmMemberRegistrationAction extends BaseAction {
	
	private static Logger log = LoggerFactory
	.getLogger(ConfirmMemberRegistrationAction.class);

	private static HashMap<String, String> testMembers = new HashMap<String, String>();
	
	static{
		testMembers.put("monthly.member","ilchmonthly@gmail.com");//gopikrishna
		testMembers.put("weekly.member","ilchweekly@gmail.com");//gopikrishna
		testMembers.put("biweekly.member","ilchbiweekly@gmail.com");//gopikrishna
		testMembers.put("days15.member","ilchdays15@gmail.com");//gopikrishna
	}
	public ActionForward addAnEmployee(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-addAnEmployee-TEST EXECUTED");
		
		ActionForward forward = new ActionForward();
		
		
		String cancel = request.getParameter("cancel");
		String confirm = request.getParameter("confirm");
		String message="";
		if (cancel != null) {
			return mapping.findForward("startRegistrtationProcess");
		}
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		AdminRegistrationBean adminRegistrationBean = new AdminRegistrationBean();
		EmployeeRegistrationBean employeeRegistrationBean = (EmployeeRegistrationBean) form;

		try {
			// Step 1: Inserting the Current Address
			Address address = employeeRegistrationBean.getListAddress(0);
			long employeeCurrentAddressId = doTransaction
					.insertADDRESSINFO(address);
			log.info("EmployeeCurrent AddressId got:"
					+ employeeCurrentAddressId);
			employeeRegistrationBean.setMyAddressId(employeeCurrentAddressId);

			// Step 2: Inserting the Home Country Address
			address = employeeRegistrationBean.getListAddress(1);
			long employeeHomeCountryAddressId = doTransaction
					.insertADDRESSINFO(address);
			log.info("EmployeeHomeCountry AddressId got :"
					+ employeeHomeCountryAddressId);
			employeeRegistrationBean
					.setHomeCountryAddressId(employeeHomeCountryAddressId);
			
			// Step 3: Inserting the Client Address
			address = employeeRegistrationBean.getListAddress(2);
			long clientAddressId = doTransaction.insertADDRESSINFO(address);
			log.info("Client AddressId got :" + clientAddressId);
			employeeRegistrationBean.setClientAddressId(clientAddressId);
			describeInstance(employeeRegistrationBean);
			
			// Step 4: Copy the  employeeRegistrationBean --> adminRegistrationBean - flexible to insert into database.
			BeanUtils.copyProperties(adminRegistrationBean,
					employeeRegistrationBean);
			long personalDetailsId = doTransaction.insertUSERPERSONALDATA(
					adminRegistrationBean, getUserProfile(request));
			log.info("UserPersonalDataId :" + personalDetailsId);
			adminRegistrationBean.setPersonalDetailsId(personalDetailsId);
			
			// Step 5: Inserting the Client Details - client Name and Work Start Date - get the Client Id and update this in
			long clientId = doTransaction.insert_USER_CLIENTS_LIST(employeeRegistrationBean);
			adminRegistrationBean.setClientId(clientId);
			
			// Step 6: Inserting the Users - credentials
			adminRegistrationBean.setApprovalStatus(1);
			long userId = doTransaction.insertUSERS(adminRegistrationBean,
					getUserProfile(request));
			log.info("UserId :" + userId);
			adminRegistrationBean.setUserId(userId);

			String aFilePath = "";
			String rFilePath = "";
			if(adminRegistrationBean.getProfilePath()!=null && adminRegistrationBean.getProfilePath().getFileName()!=null && adminRegistrationBean.getProfilePath().getFileSize() < 1024*1024*2 )
			{
				aFilePath = getApplicationPathToOneUP() + "profiles";
				rFilePath = "/profiles/";
				doTransaction.handleFileAndUpdateCorrespondingTable(adminRegistrationBean.getBusinessId(), userId, DOCTypes.UserProfile, adminRegistrationBean.getBusinessProfile(), aFilePath, rFilePath);
			}
			else
			{
				message = "Unable to upload profile as more than 2 MB file is not allowed";
			}
			
		} catch (Exception e) {
				e.printStackTrace();
				doTransaction.rollback();
			}
			doTransaction.commit();
			
//			notifyBusinessForMemberLoginApprovalPending(adminRegistrationBean);
			
			VMInputBean bean = new VMInputBean();
			bean.setText("validate");
		
			StringBuffer sb = getValidateUserEmail(request, adminRegistrationBean, bean);

			EmailDetails emailDetails = new EmailDetails();
			ArrayList<String> to = new ArrayList<String>();
			String emailId = adminRegistrationBean.getContactEmail();
			if(emailId!=null && emailId.length()>0)
			{
				to.add(emailId);
				emailDetails.setTo(to);
				emailDetails.setSubject("RunningTicker  - Validate your email - "+adminRegistrationBean.getFirstName());
				emailDetails.setEmailContent(sb);
				sendEmail(emailDetails);
			}
			
			putStatusObjInRequest(request, "Employee added and notified successfully. They still need to validate their email them self."+message);
			forward = mapping.findForward("status");
			return (forward);
			
	}
	private boolean isDemoEmployeesAvailable()
	{
		
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		int cnt = doTransaction.isDemoEmployeesAvailable();
		log.debug("Looking for existing demo employer... {}", cnt);
		if(cnt > 4)
			return Boolean.TRUE;
		else
			return Boolean.FALSE;
	}
	private boolean isTestMemberAvailable(String emailId, String logonName)
	{
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		int cnt = doTransaction.isTestUserAvailable(emailId,logonName);
		if(cnt > 0)
			return Boolean.TRUE;
		else
			return Boolean.FALSE;
	}

	public ActionForward createTestMembers(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response, GenericXmlApplicationContext ctx) throws Exception
	{
		_ctx = ctx;
				long businessId =  (Long)getObjFrmRequest("businessId", request);
		if (businessId == 0)
		{
			putObjInRequest("status", request, "No valid Business Id Found");
			return mapping.findForward("status");
		}
		if(isTestMemberAvailable("ilch.monthly.member@gmail.com","monthly.member") )
		{
			putObjInRequest("status", request, "Test Member was alreday available");
		}
		else
		{
			putObjInRequest("status", request, "Test Users creation triggered Successfully, you need to validate them accordingly");
			// CREATE MEMBERS
			
			AdminRegistrationBean bean = ConfirmRegistrationAction.getRegistrationBean();
			bean.setBusinessId(businessId);
			bean.setRole("MEMBER");
			getUserProfile(request).setBusinessId(businessId);
			StringBuilder builder = new StringBuilder();
			for (String id : testMembers.keySet())
			{
				bean.setContactEmail(testMembers.get(id));
				bean.setFirstName("First Name");
				bean.setLogin(id);
				putObjInSession("form", request,bean);
				
				if(id.indexOf("monthly")!=-1)
					bean.setTimeSheetConfiguredTo(TimeSheetTypes.MONTHLY.name());
				if(id.indexOf("weekly")!=-1)
					bean.setTimeSheetConfiguredTo(TimeSheetTypes.WEEKLY.name());
				if(id.indexOf("biweekly")!=-1)
					bean.setTimeSheetConfiguredTo(TimeSheetTypes.BIWEEKLY.name());
				if(id.indexOf("days15")!=-1)
					bean.setTimeSheetConfiguredTo(TimeSheetTypes.DAYS15.name());
				
				EmployeeRegistrationBean eBean = new EmployeeRegistrationBean();
				BeanUtils.copyProperties(eBean, bean);
				eBean.setListAddress(bean.getListAddress());
				eBean.setClientName("Adesa");
				eBean.setStartDate("12/12/2012");
				
				confirmRegistration(mapping,eBean,request,response);
				builder.append("UserId for user  : "+id+" is  : "+getObjFrmRequest("userId", request)+"<BR>");
			}
			putObjInRequest("userId", request, builder.toString());
		}
		
		return mapping.findForward("status");
		
	}
	int userNumber = 1;
	public ActionForward createDemoMember(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response, GenericXmlApplicationContext ctx, String memberType, String memberId) throws Exception
	{
		_ctx = ctx;
				long businessId =  (Long)getObjFrmRequest("businessId", request);
		if (businessId == 0)
		{
			
			putObjInRequest("status", request, "No valid Business Id Found");
			return mapping.findForward("status");
	
		}
		if(isDemoEmployeesAvailable() )
		{
			log.info("Demo emplyees alreday available.");
			putObjInRequest("status", request, "Demo Member was alreday available");
		}
		else
		{
			log.info("creating a new demo emplyee --> {}", memberType);
			putObjInRequest("status", request, "Demo Users creation triggered Successfully, you need to validate them accordingly");
			// CREATE MEMBERS
			
			AdminRegistrationBean bean = ConfirmRegistrationAction.getRegistrationBean();
			bean.setBusinessId(businessId);
			bean.setRole("MEMBER");
			getUserProfile(request).setBusinessId(businessId);
			StringBuilder builder = new StringBuilder();
			
			if(memberType.equals(TimeSheetTypes.MONTHLY.name())){
				bean.setContactEmail(testMembers.get("monthly.member"));
			}
			if(memberType.equals(TimeSheetTypes.WEEKLY.name())){
				bean.setContactEmail(testMembers.get("weekly.member"));
			}
			if(memberType.equals(TimeSheetTypes.BIWEEKLY.name())){
				bean.setContactEmail(testMembers.get("biweekly.member"));
			}
			if(memberType.equals(TimeSheetTypes.DAYS15.name())){
				bean.setContactEmail(testMembers.get("days15.member"));
			}
				bean.setFirstName("User ");
				bean.setLastName(userNumber + "");
				++userNumber;
				//bean.setLogin(memberId);
				bean.setLogin(bean.getContactEmail());
				putObjInSession("form", request,bean);
				bean.setTimeSheetConfiguredTo(memberType);
				EmployeeRegistrationBean eBean = new EmployeeRegistrationBean();
				BeanUtils.copyProperties(eBean, bean);
				eBean.setListAddress(bean.getListAddress());
				eBean.setClientName("Adesa");
				eBean.setStartDate("12/12/2012");
				
				confirmRegistration(mapping,eBean,request,response);
				builder.append("UserId for user  : "+memberId+" is  : "+getObjFrmRequest("userId", request)+"<BR>");
			
			putObjInRequest("userId", request, builder.toString());
		}
		
		return mapping.findForward("status");
		
	}
	
	public ActionForward createPerformaceTestMembers(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response, GenericXmlApplicationContext ctx,long adminNo, long businessId) throws Exception
	{
		_ctx = ctx;
		int memberCnt = getIntAsRequestParameter("memberCnt", request);
		
		//long businessId =  (Long)getObjFrmRequest("businessId", request);
		if (businessId == 0)
		{
		
			putObjInRequest("status", request, "No valid Business Id Found");
			return mapping.findForward("status");
		
		}
		
			putObjInRequest("status", request, "Test Users creation triggered Successfully, you need to validate them accordingly");
			// CREATE MEMBERS
			AdminRegistrationBean bean = ConfirmRegistrationAction.getRegistrationBean();
			bean.setBusinessId(businessId);
			bean.setRole("MEMBER");
			getUserProfile(request).setBusinessId(businessId);
			
			for (int i =1 ; i<=memberCnt;++i)
			{

				bean.setContactEmail("member"+i+"@gmail.com");
				bean.setFirstName("FirstName");
				bean.setLogin("monthly_"+adminNo+"_"+i);
				putObjInSession("form", request,bean);
				
					bean.setTimeSheetConfiguredTo(TimeSheetTypes.MONTHLY.name());
				/*if(id.indexOf("weekly")!=-1)
					bean.setTimeSheetConfiguredTo(TimeSheetTypes.WEEKLY.name());
				if(id.indexOf("biweekly")!=-1)
					bean.setTimeSheetConfiguredTo(TimeSheetTypes.BIWEEKLY.name());
				if(id.indexOf("days15")!=-1)
					bean.setTimeSheetConfiguredTo(TimeSheetTypes.DAYS15.name());
				*/
				EmployeeRegistrationBean eBean = new EmployeeRegistrationBean();
				BeanUtils.copyProperties(eBean, bean);
				eBean.setListAddress(bean.getListAddress());
				eBean.setClientName("Adesa");
				eBean.setStartDate("12/12/2012");
				eBean.setApprovalStatus(1);
				eBean.setIsEmailValidated(1);
				
				confirmRegistration(mapping,eBean,request,response);
				log.info("Now at ==> {}", bean.getLogin());
			
			}
			
		
		return mapping.findForward("status");
	
		
	}
	
	private boolean validateUserBeforeRegistering(EmployeeRegistrationBean adminRegistrationBean)
	{
		log.debug("Final Validating before registring an employer...");
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		int cnt = doTransaction.isUserLoginAvailableForRegistration(adminRegistrationBean.getLogin(), adminRegistrationBean.getContactEmail());
		if(cnt > 0)
			return Boolean.TRUE;
		else
			return Boolean.FALSE;
	}
	
	public ActionForward confirmRegistration(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String cancel = request.getParameter("cancel");
		String confirm = request.getParameter("confirm");
		String message = "";
		long userId =-1;
		if (cancel != null) {
			return mapping.findForward("startRegistrtationProcess");
		}
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		AdminRegistrationBean adminRegistrationBean = new AdminRegistrationBean();
		EmployeeRegistrationBean employeeRegistrationBean = (EmployeeRegistrationBean) form;
		employeeRegistrationBean.setContactEmail(employeeRegistrationBean.getLogin());
		adminRegistrationBean.setBusinessId(getUserProfile(request).getBusinessId());
		
		if(validateUserBeforeRegistering(employeeRegistrationBean))
		{
			log.error("Failing Business Process Registration as either duplicate email or login exists...");
			return mapping.findForward("error");
		}
		
		try {
			// Step 1: Inserting the Current Address
			Address address = employeeRegistrationBean.getListAddress(0);
			long employeeCurrentAddressId = doTransaction
					.insertADDRESSINFO(address);
			log.info("EmployeeCurrent AddressId got:"
					+ employeeCurrentAddressId);
			employeeRegistrationBean.setMyAddressId(employeeCurrentAddressId);

			// Step 2: Inserting the Home Country Address
			address = employeeRegistrationBean.getListAddress(1);
			long employeeHomeCountryAddressId = doTransaction
					.insertADDRESSINFO(address);
			log.info("EmployeeHomeCountry AddressId got :"
					+ employeeHomeCountryAddressId);
			employeeRegistrationBean
					.setHomeCountryAddressId(employeeHomeCountryAddressId);
			
			// Step 3: Inserting the Client Address
			address = employeeRegistrationBean.getListAddress(2);
			long clientAddressId = doTransaction.insertADDRESSINFO(address);
			log.info("Client AddressId got :" + clientAddressId);
			employeeRegistrationBean.setClientAddressId(clientAddressId);
			//describeInstance(employeeRegistrationBean);
			
			// Step 4: Copy the  employeeRegistrationBean --> adminRegistrationBean - flexible to insert into database.
			BeanUtils.copyProperties(adminRegistrationBean,
					employeeRegistrationBean);
			//describeInstance(adminRegistrationBean);
			
			
			// Step 5: Inserting the Client Details - client Name and Work Start Date - get the Client Id and update this in
			long clientId = doTransaction.insert_USER_CLIENTS_LIST(employeeRegistrationBean);
			adminRegistrationBean.setClientId(clientId);
			
			
			
			long personalDetailsId = doTransaction.insertUSERPERSONALDATA(
					adminRegistrationBean, getUserProfile(request));
			log.info("UserPersonalDataId :" + personalDetailsId);
			adminRegistrationBean.setPersonalDetailsId(personalDetailsId);
			
		
			// Step 6: Inserting the Users - credentials
			
			userId = doTransaction.insertUSERS(adminRegistrationBean,
					getUserProfile(request));
			
			putObjInRequest("userId", request, userId);
			log.info("UserId :" + userId);
			adminRegistrationBean.setUserId(userId);
			
		} catch (Exception e) {
			e.printStackTrace();
			doTransaction.rollback();
		}
		String aFilePath = "";
		String rFilePath = "";
		if(adminRegistrationBean.getProfilePath()!=null && adminRegistrationBean.getProfilePath().getFileName()!=null && adminRegistrationBean.getProfilePath().getFileSize() < 1024*1024*2 && userId!=-1)
		{
			aFilePath = getApplicationPathToOneUP() + "profiles";
			rFilePath = "/profiles/";
			doTransaction.handleFileAndUpdateCorrespondingTable(adminRegistrationBean.getBusinessId(), userId, DOCTypes.UserProfile, adminRegistrationBean.getBusinessProfile(), aFilePath, rFilePath);
		}
		else
		{
			message = "Unable to upload profile as more than 2 MB file is not allowed";
		}
		
		doTransaction.commit();
		
		//notifyBusinessForMemberLoginApprovalPending(adminRegistrationBean);
		
		// Validate email 
		VMInputBean bean = new VMInputBean();
		bean.setText("validate");
	
		StringBuffer sb = getValidateUserEmail(request, adminRegistrationBean, bean);

		EmailDetails emailDetails = new EmailDetails();
		ArrayList<String> to = new ArrayList<String>();
		String emailId = adminRegistrationBean.getContactEmail();
		if(emailId!=null && emailId.length()>0)
		{
			to.add(emailId);
			emailDetails.setTo(to);
			emailDetails.setSubject("RunningTicker  - Validate your email - "+adminRegistrationBean.getFirstName());
			emailDetails.setEmailContent(sb);
			sendEmail(emailDetails);
		}
		putObjInRequest("message", request, message);
		if(mapping!=null)
			return mapping.findForward("confirmBusiness");
		else
			return null;

	}


	private StringBuffer getValidateUserEmail(HttpServletRequest request,
			AdminRegistrationBean adminRegistrationBean, VMInputBean bean) {

		int min = 11;
		int max = 35;
		
		String url = getApplicationURL(request);
		log.info("User Id --> {}", adminRegistrationBean.getUserId());
		UUID uuid = UUID.randomUUID();
		String key = String.valueOf(adminRegistrationBean.getUserId());
		Random randomGenerator = new Random();
		int randomInt = randomGenerator.nextInt(max - min + 1) + min;
		StringBuffer sb = new StringBuffer(randomInt + String.valueOf(uuid)
				+ "_" + String.valueOf((key)).length());
		sb.insert(randomInt - 2, key);

		url += "validateUserEmail.do?p=" + sb.toString();
		bean.setUrl(url);
		
		String emailBody = getEmailTemplate(bean,
				VMConstants.VM_ACTIVATE_REGISTRATION_NOTIFICATION);

		return new StringBuffer(emailBody);
	}
	
}
