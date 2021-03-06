package com.lch.struts.actions.superAdmin;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.validator.routines.EmailValidator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.constants.VMConstants;
import com.lch.general.email.EmailDetails;
import com.lch.general.enums.TimerStatus;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.spring.services.BDayService;
import com.lch.spring.services.ImmigrationExpirationService;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.actions.admin.AdminFunctImplAction;
import com.lch.struts.actions.admin.ConfirmRegistrationAction;
import com.lch.struts.formBeans.SuperAdminBean;

public class SuperAdminFunctlImpl extends BaseAction {
	private static Logger log = LoggerFactory
			.getLogger(AdminFunctImplAction.class);

	enum type {
		OUTAGE
	};

	private StringBuffer getValidateBusinessEmail(HttpServletRequest request,
			long businessId, VMInputBean bean) {

		int min = 11;
		int max = 35;
		
		String url = getApplicationURL(request);
		log.info("Business Id --> {}", businessId);
		UUID uuid = UUID.randomUUID();
		String key = String.valueOf(businessId);
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
	
	public ActionForward regenerateValidationEmail(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-regenerateValidationEmail-");

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("generalJSP4AJAXMsg");

		long userId = getLongAsRequestParameter("userId", request);
		long businessId = getLongAsRequestParameter("businessId", request);
		String usrEmail = getSpringCtxDoTransactionBean().getUserEmail(userId);
		String role = getStrAsRequestParameter("role", request);
		String status = getSpringCtxDoTransactionBean().getEmilVerificationStatus(userId);
		
		if (!status.equals("1")) {
			List<String> to = new ArrayList<String>();

			EmailDetails emailDetails = new EmailDetails();
			VMInputBean bean = new VMInputBean();
			
			if(usrEmail!=null && usrEmail.length()>0 && EmailValidator.getInstance().isValid(usrEmail))
			{
			to.add(usrEmail);
			emailDetails.setTo(to);
			emailDetails.setSubject("Business Registration - Email Validation");
			bean.setText("activate");
			StringBuffer sb = getValidateBusinessEmail(request,businessId, bean);
			emailDetails.setEmailContent(sb);
			sendEmail(emailDetails);
			
			putAjaxStatusObjInRequest(request, "Notified");
			}
			else{
				putAjaxStatusObjInRequest(request, "invalidEmail");
			}
		} else {
			putAjaxStatusObjInRequest(request, "alreadyValidated");
		}
		return (forward);
	}
	
	public ActionForward createDemoUsers(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ConfirmRegistrationAction action = new ConfirmRegistrationAction();
		action.createDemoEmployer(mapping, form, request, response,
				getSpringCTX());
		putObjInRequest("demoUsres", request, "yes");
		return mapping.findForward("superAdminFunctions");
	}

	public ActionForward createPerformaceTestUsers(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ConfirmRegistrationAction action = new ConfirmRegistrationAction();
		action.useExistingDemoEmployer(mapping, form, request, response,
				getSpringCTX());
		getSpringCtxDoTransactionBean().setAllPerformanceUsersToValid();
		
		putObjInRequest("demoUsres", request, "yes");
		return mapping.findForward("superAdminFunctions");
	}
	
	public ActionForward showOutagePage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return mapping.findForward("showOutagePage");
	}

	public ActionForward showInvitationEmailPage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return mapping.findForward("showInvitationEmailPage");
	}

	public ActionForward removeOutage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		log.info("Removing Outage..");

		String status = "Opeartion Success";
		putObj4generalAJAXMsg(request, status);

		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		doTransaction.removeOutage(type.OUTAGE.name());
		return mapping.findForward("generalJsp");
	}

	public ActionForward showDisableBusinessPage(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// List all business people from users and lch_business table and send
		// them to the jsp to show

		// Business and business admin user both should set to approvalstatus to
		// 2.
		log.info(" -- showDisableBusinessPage --");
		List<Map<String, Object>> listAllBusiness = getSpringCtxDoTransactionBean()
				.getAllBusinessList();
		putObjInRequest("listAllBusiness", request, listAllBusiness);
		return mapping.findForward("showDisableBusinessPage");
	}

	public ActionForward showListEmployersPage(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// List all business people from users and lch_business table and send
		// them to the jsp to show

		// Business and business admin user both should set to approvalstatus to
		// 2.
		log.info(" -- showListEmployersPage --");
		List<Map<String, Object>> listAllBusiness = getSpringCtxDoTransactionBean()
				.getAllBusinessList();
		putObjInRequest("listAllBusiness", request, listAllBusiness);
		return mapping.findForward("showListEmployersPage");
	}
	
	public ActionForward sendInvitationEmail(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		putAjaxStatusObjInRequest(request, "Email Sent");
		forward = mapping.findForward("generalJSP4AJAXMsg");

		String subject = "Your Employees & Time Sheets";
		String userSub = request.getParameter("subject");
		if (userSub != null && userSub.length() > 0)
			subject = userSub;

		String email = getStrAsRequestParameter("email", request);

		if (EmailValidator.getInstance().isValid(email)) {

			EmailDetails emailDetails = new EmailDetails();
			ArrayList<String> l = new ArrayList<String>();
			l.add(email);
			emailDetails.setTo(l);
			emailDetails.setSubject(subject);
			VMInputBean bean = new VMInputBean();

			String sb = getEmailTemplate(bean, VMConstants.VM_INVITATION_EMAIL);
			emailDetails.setEmailContent(new StringBuffer(sb));

			sendEmail(emailDetails);
		} else {
			putAjaxStatusObjInRequest(request, "In Valid Email");
		}
		return forward;
	}

	public ActionForward activateOrDeActivateBusiness(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();

		// here userId parameter is the BusinessId
		long businessId = getLongAsRequestParameter("userId", request);
		int approvalStatus = getIntAsRequestParameter("approvalStatus", request);

		String status = "";
		int recordEffectedCount = 0;
		if (approvalStatus == 2) {
			recordEffectedCount = getSpringCtxDoTransactionBean()
					.updateBusinessStatus(approvalStatus, businessId);
		} else if (approvalStatus == 3) {
			String iduser = getSpringCtxDoTransactionBean()
					.selectAdminIdUserByBusinessId(businessId);

			Map<String, String> map = new HashMap<String, String>();
			map.put("userid", iduser.toString());
			map.put("status", TimerStatus.DISABLE.name());
			getSpringCtxDoTransactionBean().updateTimerStatusByUser(map);
			recordEffectedCount = getSpringCtxDoTransactionBean()
					.updateBusinessStatus(approvalStatus, businessId);
		} else
			recordEffectedCount = getSpringCtxDoTransactionBean()
					.updateBusinessStatus(approvalStatus, businessId);

		if (recordEffectedCount <= 0) {
			status = "No Action Performed";
		} else {
			if (approvalStatus == 1)
				status = "Active";
			else if (approvalStatus > 1 || approvalStatus == 0)
				status = "Not Active";
		}
		putAjaxStatusObjInRequest(request, status);
		forward = mapping.findForward("generalJSP4AJAXMsg");

		String email = getStrAsRequestParameter("email", request);
		EmailDetails emailDetails = new EmailDetails();
		ArrayList<String> l = new ArrayList<String>();
		l.add(email);
		emailDetails.setTo(l);

		VMInputBean bean = new VMInputBean();
		bean.setText(status);
		String sb = getEmailTemplate(bean,
				VMConstants.VM_DISABLE_BUSINESS_NOTIFICATION);
		emailDetails.setEmailContent(new StringBuffer(sb));

		sendEmail(emailDetails);

		return forward;
	}

	public ActionForward triggerBdayJobs(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-triggerBdayJobs-");

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("generalJSP4AJAXMsg");

		BDayService service = (BDayService) getSpringCTX().getBean(
				"BDayService");
		service.notifyBdays();

		putAjaxStatusObjInRequest(request, "Job execution Started!!");
		return (forward);
	}

	public ActionForward triggerImmigrationJobs(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-triggerImmigrationJobs-");

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("generalJSP4AJAXMsg");

		ImmigrationExpirationService service = (ImmigrationExpirationService) getSpringCTX()
				.getBean("immigrationExpirationService");
		service.notifyExpirations();

		putAjaxStatusObjInRequest(request, "Job execution Started!!");
		return (forward);
	}

	public ActionForward enbleBusinessForTestingPurpose(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-enbleBusinessForTestingPurpose-");

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("generalJSP4AJAXMsg");
		getSpringCtxDoTransactionBean().enbleBusinessForTestingPurpose();
		putAjaxStatusObjInRequest(request, "Done!!");
		return (forward);
	}

	public ActionForward saveOutageDetails(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String status = "Opeartion Success";

		// Get Do Transaction and update database accordingly.

		putObj4generalAJAXMsg(request, status);

		SuperAdminBean superAdminBean = (SuperAdminBean) form;

		StringBuffer infoBuff = new StringBuffer(
				"RunningTicker  is about to have an upgrade and will be down during ");

		DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
		Date date = (Date) formatter.parse(superAdminBean.getOutageDate());
		String outageDate = date.toString();
		outageDate = outageDate.replaceAll(" 00:00:00", "");

		String dateDetails[] = outageDate.split(" ");
		infoBuff.append(dateDetails[0]);
		infoBuff.append(" ");
		infoBuff.append(dateDetails[1]);
		infoBuff.append(" ");
		infoBuff.append(dateDetails[2]);
		infoBuff.append(" ");
		infoBuff.append(dateDetails[4]);
		infoBuff.append(", ");
		infoBuff.append(superAdminBean.getStartTime());
		infoBuff.append(" to ");
		infoBuff.append(superAdminBean.getEndTime());
		infoBuff.append(" ");
		infoBuff.append(dateDetails[3]);
		infoBuff.append(".");

		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		doTransaction.insertSuperSettings(infoBuff.toString(),
				type.OUTAGE.name());
		return mapping.findForward("generalJsp");
	}
	
	public ActionForward downloadDoBackUpData(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		log.info("-downloadDoBackUpData-");
		
		long busId = getLongAsRequestParameter("businessId", request);
		downloadBusinessData(busId, response);
	
		return null;
	}
	public ActionForward showBusinessUsers(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		log.info(" -- showDoBackUpDataPage --");
		List<Map<String, Object>> listAllBusiness = getSpringCtxDoTransactionBean()
				.getAllBusinessList();
		putObjInRequest("listAllBusiness", request, listAllBusiness);
		return mapping.findForward("showBusinessUsersPage");
	}

}
