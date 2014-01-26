package com.lch.struts.actions.admin;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.lch.general.generalBeans.UserProfile;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.actions.members.ConfirmMemberRegistrationAction;
import com.lch.struts.formBeans.admin.AdminRegistrationBean;

public class ConfirmRegistrationAction extends BaseAction {

	private static Logger log = LoggerFactory
			.getLogger(BusinessRegistrationAction.class);

	public static AdminRegistrationBean getRegistrationBean()
	{
		AdminRegistrationBean bean = new AdminRegistrationBean();
		bean.setApprovalStatus(1);
		bean.setBusinessName("ALLIBILLI");
		bean.setClientWorkingFor("ADESA");
		bean.setContactEmail("ilchadm123@gmail.com");
		bean.setCountryCitizenship("USA");
		bean.setFatherName("FATHER");
		bean.setFirstName("FIRSTNAME");
		bean.setGendar("MALE");
		bean.setApprovalStatus(1);
		bean.setWebsiteURL("www.allibilli.com");
		bean.setTimeSheetConfiguredTo(TimeSheetTypes.BIWEEKLY.name());
		bean.setStartDate("01/01/2012");
		SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy");
		format.format(Calendar.getInstance().getTime());
		bean.setDob(format.format(Calendar.getInstance().getTime()));
		bean.setRole("ADMIN");
		bean.setPassword("allibilli");
		bean.setPhoneNumber("1231231233");
		bean.setMiddleName("Middle Name");
		bean.setLogin("admin");
		bean.setLastName("Last Name");
		bean.setIsEmailValidated(1);
		Address a = new Address();
		a.setAddress1("411 Buckingham Rd");
		a.setAddress2("Apt 212");
		a.setCity("Richardson");
		a.setState("TX");
		a.setZip("75081");
		a.setCountry("USA");
		
		ArrayList<Address> listAddress = new ArrayList<Address>();
		listAddress.add(a);
		listAddress.add(a);
		listAddress.add(a);
		
		bean.setListAddress(listAddress);
		
		return bean;
	}
	
	private boolean isTestAdminAvailable(String email, String login)
	{
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		int cnt = doTransaction.isTestUserAvailable( email,  login);
		if(cnt > 0)
			return Boolean.TRUE;
		else
			return Boolean.FALSE;
	}
	private boolean isSuperAdminAvailable()
	{
		log.debug("Looking for existing super admin...");
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		int cnt = doTransaction.isSuperAdminAvailable();
		if(cnt > 0)
			return Boolean.TRUE;
		else
			return Boolean.FALSE;
	}
	private boolean isDemoEmployerAvailable()
	{
		log.debug("Looking for existing demo employer...");
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		int cnt = doTransaction.isDemoEmployerAvailable();
		if(cnt > 0)
			return Boolean.TRUE;
		else
			return Boolean.FALSE;
	}
	
	public void createSuperAdmin(GenericXmlApplicationContext ctx) throws Exception
	{
		
		_ctx = ctx;
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		UserProfile userProfile = new UserProfile();
		userProfile.setUserId(-1);
		if(!isSuperAdminAvailable())
		{
			log.info("Creating Super Admin");
			AdminRegistrationBean adminRegistrationBean = getRegistrationBean();
			adminRegistrationBean.setRole("SUPERADMIN");
			adminRegistrationBean.setClientWorkingFor("NONE");
			adminRegistrationBean.setContactEmail("haigopi@gmail.com");
			adminRegistrationBean.setFatherName("SUPERADMIN");
			adminRegistrationBean.setFirstName("SUPERADMIN");
			adminRegistrationBean.setLogin("superadmin");
			adminRegistrationBean.setTimeSheetConfiguredTo("");

			Address address = adminRegistrationBean.getListAddress(0);
			long businessAddressId = doTransaction.insertADDRESSINFO(address);
			adminRegistrationBean.setBusinessAddressId(businessAddressId);

			address = adminRegistrationBean.getListAddress(1);
			long personalAddressId = doTransaction.insertADDRESSINFO(address);
			// adminRegistrationBean.setPersonalAddressId(personalAddressId);
			adminRegistrationBean.setMyAddressId(personalAddressId);
			long businessId = doTransaction.insertLCH_BUSINESS(
					adminRegistrationBean, userProfile);
			adminRegistrationBean.setBusinessId(businessId);
			if(businessId == -1) {
				log.error("SUPER ADMIN Registration failed");
			}
			long personalDetailsId = doTransaction.insertUSERPERSONALDATA(
					adminRegistrationBean, userProfile);
			adminRegistrationBean.setPersonalDetailsId(personalDetailsId);
			adminRegistrationBean.setApprovalStatus(1);
			long userId = doTransaction.insertUSERS(adminRegistrationBean,userProfile);
			adminRegistrationBean.setUserId(userId);
			doTransaction.setAllUsersToValid();
			log.info("Super Admin Created : {}", userId);
		}else{
			log.info("Super Admin already avaialble");
		}
			
	}
	public void createDemoEmployer(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response, GenericXmlApplicationContext ctx) throws Exception
	{
		_ctx = ctx;
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		UserProfile userProfile = new UserProfile();
		userProfile.setUserId(-1);
		if(!isDemoEmployerAvailable())
		{
			log.info("Creating Demo Employer");
			AdminRegistrationBean adminRegistrationBean = getRegistrationBean();
			adminRegistrationBean.setRole("ADMIN");
			adminRegistrationBean.setClientWorkingFor("NONE");
			adminRegistrationBean.setContactEmail("ilchemployer@gmail.com");//gopikrishna
			adminRegistrationBean.setFatherName("EmployerFather");
			adminRegistrationBean.setFirstName("Employer FirstName");
			adminRegistrationBean.setLogin("employer");

			Address address = adminRegistrationBean.getListAddress(0);
			long businessAddressId = doTransaction.insertADDRESSINFO(address);
			adminRegistrationBean.setBusinessAddressId(businessAddressId);

			address = adminRegistrationBean.getListAddress(1);
			long personalAddressId = doTransaction.insertADDRESSINFO(address);
			// adminRegistrationBean.setPersonalAddressId(personalAddressId);
			adminRegistrationBean.setMyAddressId(personalAddressId);
			long businessId = doTransaction.insertLCH_BUSINESS(
					adminRegistrationBean, userProfile);
			adminRegistrationBean.setBusinessId(businessId);
			if(businessId == -1) {
				log.error("Demo Employer Registration failed");
			}
			long personalDetailsId = doTransaction.insertUSERPERSONALDATA(
					adminRegistrationBean, userProfile);
			adminRegistrationBean.setPersonalDetailsId(personalDetailsId);
			adminRegistrationBean.setApprovalStatus(1);
			long userId = doTransaction.insertUSERS(adminRegistrationBean,userProfile);
			adminRegistrationBean.setUserId(userId);
			
			putObjInRequest("businessId", request, businessId);
			ConfirmMemberRegistrationAction action = new ConfirmMemberRegistrationAction();
			action.createDemoMember(mapping, form, request, response, getSpringCTX(),TimeSheetTypes.BIWEEKLY.name(),"employeeBiWeekly");
			action.createDemoMember(mapping, form, request, response, getSpringCTX(),TimeSheetTypes.WEEKLY.name(),"employeeWeekly");
			action.createDemoMember(mapping, form, request, response, getSpringCTX(),TimeSheetTypes.MONTHLY.name(),"employeeMonthly");
			action.createDemoMember(mapping, form, request, response, getSpringCTX(),TimeSheetTypes.DAYS15.name(),"employeeDays15");
			
			doTransaction.setAllUsersToValid();
			log.info("Demo Employer Created : {}", userId);
		}else{
			log.info("Demo Employer already avaialble");
		}
			
	}
	public ActionForward createTestAdmins(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		int adminCnt = getIntAsRequestParameter("adminCnt", request);
		int memberCnt = getIntAsRequestParameter("memberCnt", request);
		if(adminCnt <=0 || memberCnt <=0)
		{
			putObjInRequest("status", request, "Not a valid input");
			return mapping.findForward("status");
		}
			
		
		if(isTestAdminAvailable("x_1@gmail.com","admin_1"))
		{
			putObjInRequest("status", request, "Test Admin was alreday available");
			return mapping.findForward("status");
		}
		
			putObjInRequest("status", request, "Test Users creation triggered Successfully, you need to validate them accordingly");
			// CREATE ADMIN
			AdminRegistrationBean bean = getRegistrationBean();
			putObjInSession("form", request,bean);

			putObjInRequest("isPerformanceTest", request,"YES");

			StringBuilder builder = new StringBuilder();
			
			for (int i =1 ; i <=adminCnt ; ++i)
			{
				bean.setLogin("admin_"+i);
				bean.setContactEmail("x_"+i+"@gmail.com");
				builder.append(i).append(" : ").append(bean.getLogin()).append("<BR>");
				confirmRegistration(mapping,bean,request,response);
				ConfirmMemberRegistrationAction action = new ConfirmMemberRegistrationAction();
				action.createPerformaceTestMembers(mapping, form, request, response, getSpringCTX(),i);
			}			
			
			getSpringCtxDoTransactionBean().setAllUsersToValid();
			
		return mapping.findForward("status");
	}

	
	public ActionForward createTestAdmin(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if(isTestAdminAvailable("ilchadm123@gmail.com","admin"))
		{
			putObjInRequest("status", request, "Test Admin was alreday available");
		
		}
		else
		{
			putObjInRequest("status", request, "Test Users creation triggered Successfully, you need to validate them accordingly");
			// CREATE ADMIN
			AdminRegistrationBean bean = getRegistrationBean();
			
			putObjInSession("form", request,bean);
			
			confirmRegistration(mapping,bean,request,response);
			
			ConfirmMemberRegistrationAction action = new ConfirmMemberRegistrationAction();
			action.createDemoMember(mapping, form, request, response, getSpringCTX(), TimeSheetTypes.DAYS15.name(), "demodays15");
			action.createDemoMember(mapping, form, request, response, getSpringCTX(), TimeSheetTypes.MONTHLY.name(), "demomonthly");
			action.createDemoMember(mapping, form, request, response, getSpringCTX(), TimeSheetTypes.WEEKLY.name(), "demoweekly");
			action.createDemoMember(mapping, form, request, response, getSpringCTX(), TimeSheetTypes.BIWEEKLY.name(), "demobiweekly");
			
			getSpringCtxDoTransactionBean().setAllUsersToValid();
			putStatusObjInRequest(request, "Business Id created for admin : "+getObjFrmRequest("businessId", request)+"<BR>"+"List of Users :"+getObjFrmRequest("userId", request));
		}
		return mapping.findForward("status");
	}
	
	
	private boolean validateUserBeforeRegistering(AdminRegistrationBean adminRegistrationBean)
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
			HttpServletResponse response)  {

		
		String cancel = request.getParameter("cancel");
		String confirm = request.getParameter("confirm");
		log.info("ConfirmRegistration--->" + cancel);
		log.info("ConfirmRegistration--->" + confirm);
		if (cancel != null) {
			return mapping.findForward("startRegistrtationProcess");
		}
		log.info("Finishing Business Registration Process");
		AdminRegistrationBean adminRegistrationBean = (AdminRegistrationBean) form;


		if(adminRegistrationBean.getDob()==null)
		{
			DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			adminRegistrationBean.setDob(formatter.format(new Date()));
		}
		
		describeInstance(adminRegistrationBean);
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();

		if(validateUserBeforeRegistering(adminRegistrationBean))
		{
			log.error("Failing Business Process Registration as either duplicate email or login exists...");
			return mapping.findForward("error");
		}
		
		try{
		Address address = adminRegistrationBean.getListAddress(0);
		long businessAddressId = doTransaction.insertADDRESSINFO(address);
		log.info("Business AddressId got :" + businessAddressId);
		adminRegistrationBean.setBusinessAddressId(businessAddressId);

		address = adminRegistrationBean.getListAddress(1);
		long personalAddressId = doTransaction.insertADDRESSINFO(address);
		log.info("Personal AddressId got :" + personalAddressId);
		// adminRegistrationBean.setPersonalAddressId(personalAddressId);
		adminRegistrationBean.setMyAddressId(personalAddressId);
		long businessId = doTransaction.insertLCH_BUSINESS(
				adminRegistrationBean, getUserProfile(request));
		adminRegistrationBean.setBusinessId(businessId);
		log.info("Business Id :" + businessId);
		putObjInRequest("businessId", request, businessId);
		
		if(businessId == -1)
		{
			log.error("Business Process Registration failed");
			return mapping.findForward("error");
		}
		
		long personalDetailsId = doTransaction.insertUSERPERSONALDATA(
				adminRegistrationBean, getUserProfile(request));
		adminRegistrationBean.setPersonalDetailsId(personalDetailsId);
		log.info("Personal DetailsId Id :" + personalDetailsId);
		adminRegistrationBean.setApprovalStatus(1);
		long userId = doTransaction.insertUSERS(adminRegistrationBean,
				getUserProfile(request));
		log.info("UserId :" + userId);
		adminRegistrationBean.setUserId(userId);
		
		String aFilePath = "";
		String rFilePath = "";
		if(adminRegistrationBean.getLogo()!=null && adminRegistrationBean.getLogo().getFileName()!=null  && adminRegistrationBean.getLogo().getFileSize() < 1024*1024*1)
		{
			String fileName = adminRegistrationBean.getLogo().getFileName();
			
			if (!fileName.equals("")
					&& (fileName.endsWith("jpg") || fileName.endsWith("png")
							|| fileName.endsWith("JPG") || fileName.endsWith("PNG")
							|| fileName.endsWith("gif") || fileName.endsWith("GIF"))) {}
			
			aFilePath = getApplicationPathToOneUP() + "logos";
			rFilePath = "/logos/";
			doTransaction.handleFileAndUpdateCorrespondingTable(businessId, userId, DOCTypes.BusinessLogo, adminRegistrationBean.getLogo(), aFilePath, rFilePath);
		}
		
		if(adminRegistrationBean.getBusinessProfile()!=null && adminRegistrationBean.getBusinessProfile().getFileName()!=null && adminRegistrationBean.getBusinessProfile().getFileSize() < 1024*1024*2 )
		{
			aFilePath = getApplicationPathToOneUP() + "profiles";
			rFilePath = "/profiles/";
			doTransaction.handleFileAndUpdateCorrespondingTable(businessId, userId, DOCTypes.BusinessProfile, adminRegistrationBean.getBusinessProfile(), aFilePath, rFilePath);
		}
		
		VMInputBean bean = new VMInputBean();
		bean.setText("validate");
			
		
		EmailDetails emailDetails = new EmailDetails();
		ArrayList<String> to = new ArrayList<String>();
		StringBuffer sb = new StringBuffer();
		
		// Notify ADMIN to APPROVE BUSINESS USER
		String toEmail = getProfileBean().getBusApprovalEmail();
		if(toEmail==null || toEmail.length() <= 0)
		{
			toEmail = adminRegistrationBean.getContactEmail();
		}
		
		emailDetails = new EmailDetails();
		to = new ArrayList<String>();
		to.add(toEmail);
		emailDetails.setTo(to);
		emailDetails.setSubject("New Employer Registered");

		bean.setText("activate");
		sb = getApproveBusinessUserByAdmin(request,adminRegistrationBean, bean);
		emailDetails.setEmailContent(sb);
		sendEmail(emailDetails);
		
		// Check Bus email & user email
		to.clear();
		
		to.add(adminRegistrationBean.getContactEmail());
		emailDetails.setTo(to);
		emailDetails.setSubject("Business Registration - Email Validation");
		
		sb = getValidateBusinessEmail(request,adminRegistrationBean, bean);
		emailDetails.setEmailContent(sb);
		sendEmail(emailDetails);
		}
		catch (Exception e) {
			log.error("Business Process Registration failure", e);
			return mapping.findForward("error");
		}
		return mapping.findForward("confirmBusiness");
	}

	
	private StringBuffer getApproveBusinessUserByAdmin(HttpServletRequest request,
			AdminRegistrationBean adminRegistrationBean, VMInputBean bean) {
		
		
		//int min = 11;
		//int max = 35;

		String url = getApplicationURL(request);
		
		//UUID uuid = UUID.randomUUID();
		//log.info("User Id --> {}", adminRegistrationBean.getUserId());
		//String key = String.valueOf(adminRegistrationBean.getUserId());
		//Random randomGenerator = new Random();
		//int randomInt = randomGenerator.nextInt(max - min + 1) + min;
		//StringBuffer sb = new StringBuffer(randomInt + String.valueOf(uuid)
			//	+ "_" + String.valueOf((key)).length());
		//sb.insert(randomInt - 2, key);

		//url += "approveUserByAdmin.do?p=" + sb.toString();
		
		//bean.setUrl(url);
		
		String text = "Name : "+adminRegistrationBean.getBusinessName() + "<BR>Contact Email : "+adminRegistrationBean.getContactEmail();
		bean.setText(text);
		
		String emailBody = getEmailTemplate(bean,
				VMConstants.VM_ACTIVATE_REGISTRATION_NOTIFICATION);

		return new StringBuffer(emailBody);
		
	}
	

	private StringBuffer getValidateBusinessEmail(HttpServletRequest request,
			AdminRegistrationBean adminRegistrationBean, VMInputBean bean) {

		int min = 11;
		int max = 35;
		
		String url = getApplicationURL(request);
		log.info("Business Id --> {}", adminRegistrationBean.getBusinessId());
		UUID uuid = UUID.randomUUID();
		String key = String.valueOf(adminRegistrationBean.getBusinessId());
		Random randomGenerator = new Random();
		int randomInt = randomGenerator.nextInt(max - min + 1) + min;
		StringBuffer sb = new StringBuffer(randomInt + String.valueOf(uuid)
				+ "_" + String.valueOf((key)).length());
		sb.insert(randomInt - 2, key);

		url += "validateBusinessEmail.do?p=" + sb.toString();
		bean.setUrl(url);
		
		String emailBody = getEmailTemplate(bean,
				VMConstants.VM_ACTIVATE_REGISTRATION_NOTIFICATION);

		return new StringBuffer(emailBody);
	}
}
