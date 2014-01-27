package com.lch.struts.actions.admin;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.upload.FormFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.constants.VMConstants;
import com.lch.general.dbBeans.LCH_BUSINESS;
import com.lch.general.email.EmailConstants;
import com.lch.general.email.EmailDetails;
import com.lch.general.enums.AdminSearchFunction;
import com.lch.general.enums.DOCTypes;
import com.lch.general.enums.TimeSheetStatus;
import com.lch.general.generalBeans.UserProfile;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.general.genericUtils.EmailsReport;
import com.lch.general.genericUtils.FormFile2File;
import com.lch.general.genericUtils.GeneratePassword;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.formBeans.NotifyEmployeesBean;
import com.lch.struts.formBeans.SearchOptions;

/**
 * @version 1.0
 * @author
 * @param
 */
@SuppressWarnings({ "rawtypes", "unchecked" })
public class AdminFunctImplAction extends BaseAction {

	private static Logger log = LoggerFactory.getLogger(AdminFunctImplAction.class);

	public ActionForward manageMyAdmins(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		log.info("-manageMyAdmins-");
		List listAllMyAdmins = getSpringCtxDoTransactionBean().listMyAdmins(getUserProfile(request));
		putObjInRequest("listAllMyAdmins", request, listAllMyAdmins);
		forward = mapping.findForward("manageMyAdmins");
		return forward;
	}
	/**
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward activateOrDeActivateUser(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		log.info("-Activate DeActivate Member-");

		long userId = getLongAsRequestParameter("userId", request);
		int approvalStatus = getIntAsRequestParameter("approvalStatus", request);
		//long businessId = getUserProfile(request).getBusinessId();
		String status = "";
		int recordEffectedCount = 0;
		if( approvalStatus == 2 )
			recordEffectedCount = getSpringCtxDoTransactionBean().updateUserStatus(approvalStatus, userId, getUserProfile(request).getBusinessId());
		else
			recordEffectedCount = getSpringCtxDoTransactionBean().updateUserStatus(approvalStatus, userId);

		if (recordEffectedCount <= 0) {
			status = "No Action Performed";
		}else
		{
			if(approvalStatus == 1)
				status = "Active";
			else if (approvalStatus > 1 || approvalStatus == 0)
				status = "Not Active";		
		}

		putAjaxStatusObjInRequest(request,status);
		forward = mapping.findForward("generalJSP4AJAXMsg");

		String email = getStrAsRequestParameter("email", request);
		EmailDetails emailDetails = new EmailDetails();
		ArrayList l = new ArrayList();
		l.add(email);
		emailDetails.setTo(l);
		emailDetails.setEmailContent(new StringBuffer().append("Admin Action : " + status));
		sendEmail(emailDetails);

		return forward;
	}
	
	public ActionForward notifyToUploadProfile(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		putStatusObjInRequest(request, "Notified, keeping you in CC. <BR> Note that, you still need to approve your employee inorder to provide a login facility to upload a profile, if he/she is not yet approved.");
		
		int userId = getIntAsRequestParameter("userId", request);
		String businessEmail = getUserProfile(request).getEmployerEmail();
		String userEmail = getSpringCtxDoTransactionBean().getUserEmail(userId);
		VMInputBean bean = new VMInputBean();
		bean.setText("Your Employer sent a request to upload your profile in their ILCH system. Please login and upload the profile.");
		EmailDetails emailDetails = new EmailDetails();
		ArrayList<String> to = new ArrayList<String>();
		to.add(userEmail);
		emailDetails.setTo(to);
		emailDetails.setSubject("Request to upload your profile");
		String sb = getEmailTemplate(bean, VMConstants.VM_RESUME_UPLOAD_NOTIFY);
		emailDetails.setEmailContent(new StringBuffer(sb));
		sendEmail(emailDetails);
		return mapping.findForward("ajaxStatus");
	}
	public ActionForward eanableDisableAdmin(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		int approvalStatus = getIntAsRequestParameter("approvalStatus", request);
		long userId = getLongAsRequestParameter("userId", request);
		if(approvalStatus!=1 && getSpringCtxDoTransactionBean().getAdminCount(getUserProfile(request).getBusinessId()) <= 1)
		{
			long activeUserId = getSpringCtxDoTransactionBean().getActiveAdminUserId(getUserProfile(request).getBusinessId());
			if(userId == activeUserId)
			{
				putAjaxStatusObjInRequest(request, "Opeartion Not Allowed. One admin should be present atleast");
				return mapping.findForward("generalJSP4AJAXMsg");
			}
			else
			{
				return updateUserStatus(mapping, form, request, response);
			}
		}
		else
		{
			return updateUserStatus(mapping, form, request, response);
		}
	}
	
	public ActionForward updateUserStatus(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		log.info("-updateUserStatus-");

		long userId = getLongAsRequestParameter("userId", request);
		int approvalStatus = getIntAsRequestParameter("approvalStatus", request);
		String status = "";
		switch (approvalStatus) {
		case 1: {
			status = TimeSheetStatus.APPROVED.name();
			break;
		}
		case 2: {
			status = "DISABLED";
			break;
		}
		case 3: {
			status = "DELETED";
			break;
		}
		case 0: {
			status = "PENDING";
			break;
		}
		default: {
			status = "No Action Had been taken";
			break;
		}
		}
		int recordEffectedCount = getSpringCtxDoTransactionBean().updateUserStatus(approvalStatus, userId);
		putAjaxStatusObjInRequest(request, status);
		forward = mapping.findForward("generalJSP4AJAXMsg");

		if (recordEffectedCount <= 0) {
			status = "No action had been taken";
		}
//		else if(approvalStatus == 3)
//		{
//			forward = mapping.findForward("manageMyAdmins");
//		}

		
		String email = getStrAsRequestParameter("email", request);
		EmailDetails emailDetails = new EmailDetails();
		ArrayList l = new ArrayList();
		l.add(email);
		emailDetails.setTo(l);
		emailDetails.setEmailContent(new StringBuffer().append("Admin Action : " + status));
		sendEmail(emailDetails);

		return forward;
	}

	public ActionForward approveOrRejectRegistrationApprovals(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		log.info("-approveOrRejectPendingApprovals -");

		String ajaxParam = request.getParameter("ajaxParam");
		List emails ;
		String successStatus = "Congratulation, You was granted the access to login and submit time sheets online by your employer";
		String rejectStatus = "You have to register again as your request of registration was denied by your employer. Contact your employer for more information.";
		String status = "";
		if (ajaxParam.equalsIgnoreCase("ApproveAll") || ajaxParam.equalsIgnoreCase("RejectAll")) {
			
			String userIds = getStrAsRequestParameter("userId", request);
			log.info("Action To {} Users {}",  ajaxParam, userIds);
			
			String action = "";
			String result = "Action "+ajaxParam+" Completed"; 
			
			if (ajaxParam.equalsIgnoreCase("ApproveAll")) {
				status =successStatus;
				action = TimeSheetStatus.APPROVED.name();
			}
			else
			{
				status = rejectStatus;
				action = TimeSheetStatus.REJECTED.name();
			}
			
			emails = getSpringCtxDoTransactionBean().listUserEmails(userIds);
			String userIdArr[] = userIds.split(",");
			
			for (int i = 0; i < userIdArr.length; ++i) {
				long userId = Integer.valueOf(userIdArr[i]);
				getSpringCtxDoTransactionBean().approveOrRejectEmployeeRegistrationPendingApprovals(action,userId);
			}
			
			putAjaxStatusObjInRequest(request, result);
			sendStatusEmail(emails, status, "Your Registration Status");
			
		}  else if (ajaxParam.equalsIgnoreCase(TimeSheetStatus.APPROVED.name()) || ajaxParam.equalsIgnoreCase(TimeSheetStatus.REJECTED.name())) {
			long userId = getLongAsRequestParameter("userId", request);
			log.info(" Action To {} Users {}",  ajaxParam, userId);
			emails = getSpringCtxDoTransactionBean().listUserEmails(String.valueOf(userId));
			status = getSpringCtxDoTransactionBean().approveOrRejectEmployeeRegistrationPendingApprovals(ajaxParam,
					userId);
			
			putAjaxStatusObjInRequest(request, status);
			if(ajaxParam.equalsIgnoreCase(TimeSheetStatus.APPROVED.name()))
					status = successStatus;
			else
				status = rejectStatus;
			sendStatusEmail(emails, status,"Your Registration Status");
		} 

		// Now delete Rejected Users
		getSpringCtxDoTransactionBean().deleteRejectedUser(getUserProfile(request).getBusinessId());
		
		forward = mapping.findForward("generalJSP4AJAXMsg");
		return forward;
	}
	public ActionForward approveOrRejectAllPendingTimeSheets(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		log.info("-approveOrRejectPendingApprovals -");

		String ajaxParam = request.getParameter("ajaxParam");
		List emails ;
		String status = "";
		if (ajaxParam.equalsIgnoreCase("ApproveAll")) {
			log.info("-ApproveAll-" + ajaxParam);
			status = "Your approval request submitted for time sheet is now approved by your employer.";
			String weeklyHrsSummaryIds = getStrAsRequestParameter("weeklyHrsSummaryIds", request);
			emails = getSpringCtxDoTransactionBean().listUserEmailsByWeeklyIds(weeklyHrsSummaryIds);
			String idArr[] = weeklyHrsSummaryIds.split(",");
			for (int i = 0; i < idArr.length; ++i) {
				getSpringCtxDoTransactionBean().approveOrRejectEmployeeTimeSheets(TimeSheetStatus.APPROVED.name(),
						idArr[i]);
			}
			putAjaxStatusObjInRequest(request, "Action Approve-All Completed");
			sendStatusEmail(emails, status, "Your TimeSheet Status");
		} else if (ajaxParam.equalsIgnoreCase("RejectAll")) {
			log.info("-RejectAll-" + ajaxParam);
			status = "Your approval request submitted for time sheet is rejected by your employer. Please edit and re submit accordingly. If you have any issues please contact your employer.";
			String weeklyHrsSummaryIds = getStrAsRequestParameter("weeklyHrsSummaryIds", request);
			emails = getSpringCtxDoTransactionBean().listUserEmailsByWeeklyIds(weeklyHrsSummaryIds);
			String userIdArr[] = weeklyHrsSummaryIds.split(",");
			for (int i = 0; i < userIdArr.length; ++i) {
				getSpringCtxDoTransactionBean().approveOrRejectEmployeeTimeSheets(TimeSheetStatus.REJECTED.name(),
						userIdArr[i]);
			}
			putAjaxStatusObjInRequest(request, "Action Reject-All Completed");
			sendStatusEmail(emails, status, "Your TimeSheet Status");
		}

		forward = mapping.findForward("generalJSP4AJAXMsg");
		return forward;
	}

	private void sendStatusEmail(List emails, String status, String subject) {
		if(emails == null)
		{
			log.error("Invalid emails list");
			return;
		}
		emails = processEmails(emails);
		VMInputBean bean = new VMInputBean();
		
		bean.setText(status);

		EmailDetails emailDetails = new EmailDetails();
		emailDetails.setBcc(emails);
		emailDetails.setSubject(subject);
	//	StringBuffer sb = new StringBuffer(status);
		String sb = getEmailTemplate(bean, VMConstants.VM_APPROVAL_STATUS);
		emailDetails.setEmailContent(new StringBuffer(sb));
		sendEmail(emailDetails);

	}
	
	private List<String> processEmails(List<Map<String, String>> emailsMap)
	{
		List<String> emails = new ArrayList<String>();
		
		for (Map<String, String> m : emailsMap)
			emails.add(m.get("contactEmail"));
		
		return emails;
	}

	public ActionForward doSearch(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		log.info("-doSearch-");
		forward = mapping.findForward("searchResult");
		SearchOptions searchOptions = (SearchOptions) form;
		ActionErrors messages = new ActionErrors();

		String SQL = AdminFunctSprt.prepareSQLQuery(searchOptions);
		log.info("Search Query : {}", SQL);
		if (SQL.equals("") || SQL.length() == 0) {
			String prevQryExcuted = (String) getObjFrmSession("prevQryExcuted", request);
			log.info(prevQryExcuted + ":");

			if (prevQryExcuted != null && prevQryExcuted.length() != 0
					&& getStrAsRequestParameter("isReqForSort", request) != null
					&& getStrAsRequestParameter("isReqForSort", request).equalsIgnoreCase("true")) {
				SQL = prevQryExcuted;

			} else {
				messages.add("msg", new ActionMessage("invlaid.search.selection"));
				saveMessages(request, messages);
				forward = mapping.findForward("searchUsers");
				return forward;
			}
		}
		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		String order = (getStrAsRequestParameter("order", request) == null) ? ("asc") : (getStrAsRequestParameter(
				"order", request));
		String orderBy = (String) getStrAsRequestParameter("orderby", request);
		if (orderBy == null)
			orderBy = "firstName";
		log.info(orderBy + " : " + order);
		List<Map<String, Object>> listAllMyEmployees = getSpringCtxDoTransactionBean().getAllMySearchEmployeesList(
				businessId, orderBy, order, SQL);
		
		int i = 0;
		String recentHrs = "";
		while (i < listAllMyEmployees.size()) {
			Map m = listAllMyEmployees.get(i);
			if (m.containsKey("recentHrs")) {
				Object objHours = m.get("recentHrs");
				if(objHours!=null && objHours instanceof byte[])
					recentHrs = new String((byte[])objHours);
				else if(objHours!=null && objHours instanceof String)
					recentHrs = objHours.toString();
				log.info("Recent Hours {}", recentHrs);
				if (!recentHrs.equalsIgnoreCase("null")) {
					m.put("recentHrs", recentHrs);
				}
			}
			i++;
		}
		
		if (order != null && order.equalsIgnoreCase("desc")) {
			log.warn("Making ASC");
			order = "asc";
		} else {
			log.warn("Making DESC");
			order = "desc";
		}
		putObjInRequest("listAllMyEmployees", request, listAllMyEmployees);
		putObjInRequest("order", request, order);
		putObjInRequest("actionParameter", request, "doSearch");
		putObjInSession("prevQryExcuted", request, SQL);
		// log.info(SQL);
		return forward;
	}

	public ActionForward searchOptions(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		UserProfile userProfile = getUserProfile(request);
		if (userProfile == null) {
			return (mapping.findForward("needAuthentication"));
		}

		long businessId = userProfile.getBusinessId();

		try {
			Object[] param = new Object[1];
			param[0] = businessId;
			List clientWorkingFor = getJDBCTemplate().queryForList(CLIENTWORKINGFORLIST, param);
			List city = getJDBCTemplate().queryForList(CITYLIST, param);
			List country = getJDBCTemplate().queryForList(COUNTRYLIST, param);
			List stateList = getJDBCTemplate().queryForList(STATELIST, param);

			// SearchOptions searchOptions = new SearchOptions();
			SearchOptions searchOptions = (SearchOptions) form;
			searchOptions.setCountryList2Display(country);
			searchOptions.setCityList2Display(city);
			searchOptions.setClientWorkingForList2Display(clientWorkingFor);
			searchOptions.setStateList2Display(stateList);
			getSession(request).setAttribute("searchOptions", searchOptions);
			
			resetSessionObjects(request);

			String featureRequest = request.getParameter(AdminSearchFunction.featureRequest.name());
			log.info("Feature Requested {}", featureRequest);
			putObjInSession(AdminSearchFunction.featureRequest.name(), request, featureRequest);

		} catch (Exception e) {
			e.printStackTrace();
		}

		forward = mapping.findForward("searchUsers");
		return (forward);
	}

	private void resetSessionObjects(HttpServletRequest request)
	{
		removeObjFrmSession(AdminSearchFunction.featureRequest.name(), request);
	}
	public ActionForward listAllEmployees(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("listAllEmployees");
		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		String order = (getStrAsRequestParameter("order", request) == null) ? ("asc") : (getStrAsRequestParameter(
				"order", request));
		String orderBy = (String) getStrAsRequestParameter("orderby", request);
		log.info(orderBy + " : " + order);
		List<Map<String, Object>> listAllMyEmployees = getSpringCtxDoTransactionBean().getAllMyEmployeesList(businessId,
				orderBy, order);

		resetSessionObjects(request);

		if (order != null && order.equalsIgnoreCase("desc")) {
			log.info("Making ASC");
			order = "asc";
		} else {
			log.info("Making DESC");
			order = "desc";
		}
		putObjInRequest("listAllMyEmployees", request, listAllMyEmployees);
		putObjInRequest("order", request, order);
		return (forward);
	}

	public ActionForward seeEmployeeHistory(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("seeEmployeeHistory");
		log.info("-seeEmployeeHistory-");
		return (forward);
	}

	public ActionForward calculateThisMonthRevenue(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-calculateThisMonthRevenue-");
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("calculateThisMonthRevenue");
		return (forward);

	}

	public ActionForward reports(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("reports");
		return (forward);
	}
	public ActionForward cancelRequest(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)throws Exception{
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("adminFunctions");
		return (forward);
	}

	public ActionForward createAnotherAdmin(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("createAnotherAdmin");
		return (forward);
	}

	/*
	 * public ActionForward updateEmployeeDetails(ActionMapping mapping,
	 * ActionForm form, HttpServletRequest request, HttpServletResponse
	 * response) throws Exception {
	 * log.info("-updateEmployeeDetails-");
	 * isSignedIn(mapping,request,response); ActionForward forward = new
	 * ActionForward();
	 * 
	 * UserProfile userProfile = getUserProfile(request); if(userProfile==null)
	 * { return(mapping.findForward("needAuthentication")); }
	 * 
	 * long businessId = userProfile.getBusinessId();
	 * 
	 * try{ Object[] param = new Object[1]; param[0]=businessId; List
	 * clientWorkingFor =
	 * getJDBCTemplate().queryForList(CLIENTWORKINGFORLIST,param); List city =
	 * getJDBCTemplate().queryForList(CITYLIST,param); List country =
	 * getJDBCTemplate().queryForList(COUNTRYLIST,param); List
	 * stateList=getJDBCTemplate().queryForList(STATELIST,param);
	 * 
	 * //SearchOptions searchOptions = new SearchOptions(); SearchOptions
	 * searchOptions = (SearchOptions)form;
	 * searchOptions.setCountryList2Display(country);
	 * searchOptions.setCityList2Display(city);
	 * searchOptions.setClientWorkingForList2Display(clientWorkingFor);
	 * searchOptions.setStateList2Display(stateList);
	 * getSession(request).setAttribute("searchOptions",searchOptions);
	 * 
	 * getSession(request).setAttribute("updateEmp","updateEmployeeDetails"); }
	 * catch (Exception e) { e.printStackTrace(); } forward =
	 * mapping.findForward("searchUsers"); return (forward);
	 * 
	 * }
	 */

//	public ActionForward updateEmployeeDetailsNext(ActionMapping mapping, ActionForm form, HttpServletRequest request,
//			HttpServletResponse response) throws Exception {
//		ActionForward forward = new ActionForward();
//		forward = mapping.findForward("updateEmployeeDetails");
//		String userId = request.getParameter("userId");
//		log.info("userId =" + userId);
//		Map userRateDetailsMap = getSpringCtxDoTransactionBean().getUserRateDetails(getUserProfile(request), userId);
//		if (userRateDetailsMap == null) {
//			userRateDetailsMap = new HashMap();
//		}
//		List userRateTypes = getSpringCtxDoTransactionBean().listUserRateTypes();
//		if (userRateTypes != null) {
//			userRateDetailsMap.put("userRateTypes", userRateTypes);
//		}
//		putObjInSession("userRateDetails", request, userRateDetailsMap);
//		log.info("userRateDetailsMap : Size " + userRateDetailsMap.size() + userRateDetailsMap);
//		log.info("-updateEmployeeDetails-");
//		return (forward);
//
//	}

	public ActionForward userRateDetails(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-userRateDetails-");
		
		ActionForward forward = new ActionForward();

		forward = mapping.findForward("userRateDetails");
		return (forward);
	}

	public ActionForward viewMyUniqueNumberOptions(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-viewMyUniqueNumber-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("viewMyUniqueNumberOptions");
		return (forward);
	}

	public ActionForward sendMyBusinessUniqueIdentificationNumber(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("-viewMyUniqueNumber-");
		
		ActionForward forward = new ActionForward();
		String email = getUserProfile(request).getEmployerEmail();
		String displayEmail = "";
		log.info("Email : " + email);

		if (email != null) {
			displayEmail = email.substring(email.indexOf("@") + 1, email.length());
		} else {
			displayEmail = "";
		}

		long businessId = getUserProfile(request).getBusinessId();
		EmailDetails emailDetails = new EmailDetails();
		VMInputBean bean = new VMInputBean();
		bean.setText(String.valueOf(businessId));
		ArrayList l = new ArrayList();
		l.add(email);
		emailDetails.setTo(l);
		emailDetails.setSubject("Business ID");
		String sb = getEmailTemplate(bean, VMConstants.VM_BUSINESS_ID_MAIL);
		emailDetails.setEmailContent(new StringBuffer(sb));
		sendEmail(emailDetails);
		putAjaxStatusObjInRequest(request, "Thank you, Email was sent to your " + displayEmail);
		forward = mapping.findForward("generalJsp");
		return (forward);
	}

	public ActionForward showTimerCreationPage(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		long businessId = getUserProfile(request).getBusinessId();
		LCH_BUSINESS businessDetails = getSpringCtxDoTransactionBean().getBusinessDetails(businessId,getUserProfile(request).getUserId());
		List<Map<String, Object>>  listAllMyEmployees = getSpringCtxDoTransactionBean().getAllMyEmployeesList(businessId,
				null, null);
		List<ListOrderedMap> listTimerTypes = getSpringCtxDoTransactionBean().listTimerTypes();
		putObjInRequest("listAllMyEmployees", request, listAllMyEmployees);
		putObjInRequest("listTimerTypes", request, listTimerTypes);
		log.info(businessDetails.getEmployerEmail());
		putObjInRequest("businessDetails", request, businessDetails);
		forward = mapping.findForward("showTimerCreationPage");
		return (forward);

	}

	public ActionForward showLogoUpdatePage(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("showLogoUpdatePage");
		return (forward);
	}
	
	public ActionForward uploadLogo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		long userId = userProfile.getUserId();
		String msg = "";
		
		try {
			SearchOptions searchOptions = (SearchOptions) form;
			String submitFor = searchOptions.getSubmit();
			DoTransaction doTransaction = getSpringCtxDoTransactionBean();
			
			if(submitFor.contains("Reset"))
			{
				log.info("Resetting logo");
				doTransaction.resetLogo(businessId, userId, DOCTypes.BusinessLogo);
				msg = "Completed";
			}
			else{
			String aFilePath = "";
			String rFilePath = "";
			if(searchOptions.getLogo()!=null && searchOptions.getLogo().getFileName()!=null  && searchOptions.getLogo().getFileSize() < 1024*1024*1 && searchOptions.getLogo().getFileSize() > 100 )
			{
				String fileName = searchOptions.getLogo().getFileName();
				
				if (!fileName.equals("")
						&& (fileName.endsWith("jpg") || fileName.endsWith("png")
								|| fileName.endsWith("JPG") || fileName.endsWith("PNG")
								|| fileName.endsWith("gif") || fileName.endsWith("GIF"))) {}
				
				aFilePath = getApplicationPathToOneUP() + "logos";
				rFilePath = "/logos/";
				doTransaction.handleFileAndUpdateCorrespondingTable(businessId, userId, DOCTypes.BusinessLogo, searchOptions.getLogo(), aFilePath, rFilePath);
				msg = "Updated Successfully. You and your employees will see this logo after login";
			}
			else
			{
				msg = "Not a Valid image it seems.!! ";
			}
			}
			
		} catch (Exception e) {
			msg = "Sorry Couldn't able to update!! " + e.getMessage();
			e.printStackTrace();
		}
		putStatusObjInRequest(request, msg);

		return mapping.findForward("status");
	}
	
	public ActionForward makeGenericEmail(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-makeGenericEmail-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("makeGenericEmail");
		return (forward);

	}

	public ActionForward help(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-help-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("adminHelp");
		return (forward);
	}

	public ActionForward showManageTimersPage(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-manageTimers----");
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("showManageTimers");
		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		long userId = userProfile.getUserId();
		log.info("userId : " + userId + " businessId : " + businessId);
		List<ListOrderedMap> listAllMyReminders = getSpringCtxDoTransactionBean().listTimers(userId, businessId);
		log.info("listAllMyReminders" + listAllMyReminders);
		putObjInRequest("listAllMyReminders", request, listAllMyReminders);
		return (forward);
	}
	public ActionForward addAnEmployeeOptions(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-addAnEmployeeOptions-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("addAnEmployeeOptions");
		return (forward);
	}

	/*
	 * public ActionForward inviteOtherBusiness(ActionMapping mapping,
	 * ActionForm form, HttpServletRequest request, HttpServletResponse
	 * response) throws Exception {
	 * log.info("-inviteOtherBusiness-");
	 * isSignedIn(mapping,request,response);
	 * 
	 * String emailList = getStrAsRequestParameter("emailsList", request);
	 * log.info("emails List :"+emailList); String[] emails =
	 * emailList.split(",");
	 * 
	 * ActionForward forward = new ActionForward(); EmailDetails emailDetails =
	 * new EmailDetails(); ArrayList l = new ArrayList(); for(int i =0;
	 * i<emails.length;++i) l.add(emails[i]); emailDetails.setTo(l);
	 * emailDetails.setEmailContent(new StringBuffer().append(
	 * " USE THE WWW.ILC.ALLIBILLI.INFO FOR YOUR ONLINE TIMESHEET SUBMISSION "
	 * )); sendEmail(emailDetails);
	 * 
	 * forward = mapping.findForward("inviteOtherBusinessResult"); return
	 * (forward); }
	 */
	public ActionForward inviteOtherBusinessOptions(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-inviteOtherBusinessOptions-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("inviteOtherBusinessOptions");
		return (forward);
	}

	public ActionForward sendAnSMS(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-sendAnSMS-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("sendAnSMS");
		return (forward);
	}

	public ActionForward employeeRegistrationPendingApprovals(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("-employeeRegistrationPendingApprovals-");
		
		ActionForward forward = new ActionForward();

		List<ListOrderedMap> employeeRegistrationPendingApprovals = getSpringCtxDoTransactionBean()
				.listEmployeeRegistrationPendingApprovals(getUserProfile(request));
		putObjInRequest("employeeRegistrationPendingApprovals", request, employeeRegistrationPendingApprovals);

		forward = mapping.findForward("employeeRegistrationPendingApprovals");
		return (forward);
	}

	public ActionForward employeeTimesheetPendingApprovals(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("-employeeTimesheetPendingApprovals-");
		
		ActionForward forward = new ActionForward();

		List<Map> employeeTimesheetPendingApprovals = getSpringCtxDoTransactionBean()
				.listEmployeeTimesheetPendingApprovals(getUserProfile(request));
		putObjInRequest("employeeTimesheetPendingApprovals", request, employeeTimesheetPendingApprovals);

		forward = mapping.findForward("employeeTimesheetPendingApprovals");
		return (forward);
	}
	public ActionForward showManageTimeSheets(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("-showManageTimeSheets-");
		
		ActionForward forward = new ActionForward();

		List<Map> employeeTimesheetPendingApprovals = getSpringCtxDoTransactionBean()
				.listEmployeeTimesheetsForAdmin(getUserProfile(request), request.getParameter("userId"));
		putObjInRequest("timeSheetsForAdminList", request, employeeTimesheetPendingApprovals);

		forward = mapping.findForward("listTimeSheetsForAdmin");
		return (forward);
	}

	public ActionForward approveOrRejectUserHrs(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		
		ActionForward forward = mapping.findForward("status");
		List emails = null;
		try{
		log.info("-approveOrRejectUserHrs-");
		
		
		String businessId = getUserProfile(request).getBusinessId() + "";
		String status = request.getParameter("status");
		//Map reqParams = request.getParameterMap();
		Map<String, Object> params = new HashMap<String, Object>();
		//params.putAll(reqParams);
		params.put("status",  status);
		params.put("userId",  request.getParameter("userId"));
		
		params.put("businessId", businessId);
		params.put("actionDate", new Timestamp(Calendar.getInstance().getTimeInMillis()));
		params.put("weeklyHrsSummaryId", request.getParameter("weeklyHrsSummaryId"));
		params.put("comments", request.getParameter("comments"));
		
		if (status.equalsIgnoreCase(TimeSheetStatus.APPROVED.name())) {
			try
			{
			long userId = getLongAsRequestParameter("userId", request);
			log.info("-Approve-" + status);
			
			emails = getSpringCtxDoTransactionBean().listUserEmails(userId + "");
			getSpringCtxDoTransactionBean().updateMonthlySummaryHours(params);
			putAjaxStatusObjInRequest(request, status);
			status = "Your approval request submitted for time sheet is now approved by your employer.";
			sendStatusEmail(emails, status, "Your TimeSheet Status");
			}
			catch (Exception e) {
				putAjaxStatusObjInRequest(request, "Action Failed");
				sendStatusEmail(emails, status, "Error Proceesing TimeSheet");
			}
		} else if (status.equalsIgnoreCase(TimeSheetStatus.REJECTED.name())) {
			try
			{
			long userId = getLongAsRequestParameter("userId", request);
			log.info("-Reject-" + status);
			
			emails = getSpringCtxDoTransactionBean().listUserEmails(userId + "");
			getSpringCtxDoTransactionBean().updateMonthlySummaryHours(params);
			putAjaxStatusObjInRequest(request, status);
			status = "Your approval request submitted for time sheet is rejected by your employer. Please edit and re submit accordingly. If you have any issues please contact your employer.";
			sendStatusEmail(emails, status, "Your TimeSheet Status");
			}
			catch (Exception e) {
				putAjaxStatusObjInRequest(request, "Action Failed");
				sendStatusEmail(emails, status,  "Error Proceesing TimeSheet");
			}
		}
		else
		{
			putAjaxStatusObjInRequest(request, "No Action Taken");
		}
		}
		catch (Exception e) {
			putAjaxStatusObjInRequest(request, "Action Failed");
		}
		
		forward = mapping.findForward("generalJSP4AJAXMsg");
		return (forward);
	}

	public ActionForward totalHrsClaimed(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-totalHrsClaimed-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("totalHrsClaimed");
		return (forward);
	}

	public ActionForward investedAmountOnEmployee(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("InvestedAmountOnEmployee-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("investedAmountOnEmployee");
		List investmentTypes = getSpringCtxDoTransactionBean().listInvestmentTypes();
		log.info("investmentTypes :" + investmentTypes);
		putObjInSession("investmentTypes", request, investmentTypes);
		return (forward);
	}

	public ActionForward getInvestmentData(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("InvestedAmountOnEmployee-after reload-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("investedAmountOnEmployee");
		long investmentType = getLongAsRequestParameter("investmentType", request);
		log.info("investmentType:" + investmentType);
		UserProfile userProfile = getUserProfile(request);
		long userId = userProfile.getUserId();
		long businessId = userProfile.getBusinessId();
		Map investedDate_amount = getSpringCtxDoTransactionBean().get_investedDate_amount(investmentType, userId,
				businessId);
		log.info("investedDate_amount :" + investedDate_amount);
		putObjInRequest("investedDate_amount", request, investedDate_amount);
		putObjInRequest("investmentType", request, String.valueOf(investmentType));
		return (forward);
	}

//	public ActionForward updateInvestedAmountOnEmployee(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response) throws Exception {
//		log.info("InvestedAmountOnEmployee-going to update-");
//		
//		String cancel = request.getParameter("cancle");
//		log.debug("Is Cancel Button status --->" + cancel);
//		if (cancel != null) {
//			return mapping.findForward("adminFunctions");
//		}
//		UserProfile userProfile = getUserProfile(request);
//		long userId = userProfile.getUserId();
//		long businessId = userProfile.getBusinessId();
//		log.info("userId is:" + userProfile.getUserId() + "businessId is:" + userProfile.getBusinessId());
//		SearchOptions searchOptions = (SearchOptions) form;
//		String investmentType = searchOptions.getInvestmentType();
//		String investedDate = searchOptions.getInvestedDate();
//		Double amount = searchOptions.getAmount();
//		Map m = new HashMap();
//		m.put("investmentType", investmentType);
//		m.put("investedDate", investedDate);
//		m.put("amount", amount);
//		m.put("userId", userId);
//		m.put("businessId", businessId);
//		getSpringCtxDoTransactionBean().updateInvestedAmount(m);
//		putAjaxStatusObjInRequest(request, "You Updated Invested Amount On Employee Details Successfully...");
//		return mapping.findForward("generalJsp");
//	}

	// Enable or Disable an Employee based on userId and businessId
	public ActionForward enableOrDisableCheck(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-reports-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("generalJSP4AJAXMsg");
		String userId = request.getParameter("userId");
		String businessId = String.valueOf(getUserProfile(request).getBusinessId());
		String data = request.getParameter("ajaxParam");
		log.info("userId:" + userId + " : businessId : " + businessId);
		log.info("selected :" + data);
		Map m = new HashMap();
		m.put("userId", userId);
		m.put("businessId", businessId);
		if (data.equalsIgnoreCase("enable")) {
			getSpringCtxDoTransactionBean().enableAnEmployee(m);
			String ajaxMsg = "<font color='red'>Enabled</font>";
			putAjaxStatusObjInRequest(request, ajaxMsg);
		} else if (data.equalsIgnoreCase("disable")) {
			getSpringCtxDoTransactionBean().disableAnEmployee(m);
			String ajaxMsg = "<font color='red'>Disabled</font>";
			putAjaxStatusObjInRequest(request, ajaxMsg);
		}
		// removeObjFrmSession("disableEmp", request);
		return (forward);
	}

	public ActionForward resetPassword(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-Admin Account Settings-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("resetPasswordOfAnAccount");
		log.info("-resetPassword-");
		Map passwordData = getSpringCtxDoTransactionBean().getPasswordForAnAccount(getUserProfile(request).getUserId(),
				getUserProfile(request).getBusinessId());
		log.info("passwordData" + passwordData);
		putObjInRequest("passwordData", request, passwordData);
		putObjInRequest("passwordUpdated", request, "yes");
		
		return (forward);
	}

	public ActionForward showTimeSheetConfiguration(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-Admin Account Settings-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("showTimeSheetConfigurationPage");
		log.info("-showTimeSheetConfiguration-");
		List<Map<String, Object>> adminSettings= getSpringCtxDoTransactionBean().getAdminSettings(getUserProfile(request).getBusinessId());
		
		Map timeSheetConfig = new HashMap<String, String>();
		boolean isKeyFound = false;
		for(Map map : adminSettings)
		{
			if (map.containsValue(AdminSettings.TIMSHEETCONFIGURATION.name()))
			{
				isKeyFound = true;
				timeSheetConfig.put(AdminSettings.TIMSHEETCONFIGURATION.name(), map.get("value"));
				break;
			}
		}
		
		if(!isKeyFound)
		{
			getSpringCtxDoTransactionBean().createTimeSheetConfiguration(getUserProfile(request).getBusinessId(), AdminSettings.TIMSHEETCONFIGURATION.name(), AdminSettings.TIMSHEETCONFIGURATION.getDefautValue());
			timeSheetConfig.put(AdminSettings.TIMSHEETCONFIGURATION.name(), AdminSettings.TIMSHEETCONFIGURATION.getDefautValue());
		}
		putObjInRequest("adminSettings", request, timeSheetConfig);
		return (forward);
	}
	
	public ActionForward updateTimeSheetConfiguration(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-updateTimeSheetConfiguration -");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("adminFunctions");
		
		String name = request.getParameter("name");
		String value= request.getParameter("timeSheetConfigValue");
		
		long i = getSpringCtxDoTransactionBean().updateAdminSettings(getUserProfile(request).getBusinessId(), name, value);
		
		putObjInRequest("isAdminSettingsUpdated", request, "yes");
		
		if(i > 0)
			putObjInRequest("status", request, "TimeSheet Configuration Updated Sucessfully");
		else
			putObjInRequest("status", request, "Failed to Update TimeSheet Configuration");
		return (forward);
	}
	
	
	
	public ActionForward disableBusiness(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-Admin Account Settings-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("status");
		log.info("-disableBusiness-");
		 long count = getSpringCtxDoTransactionBean().disableBusiness(getUserProfile(request).getBusinessId());
		putStatusObjInRequest(request, "<div align=\"center\">Business and all employees related to business are now disabled <BR> Total Employees disabled including admins :" + count+"</div>");
		request.getSession().removeAttribute("userProfile");
		request.getSession().invalidate();
		return (forward);
	}
	
	public ActionForward killBusinessAccount(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-Admin Account Settings-");
		
		getSpringCtxDoTransactionBean().killBusinessAccount(getUserProfile(request).getUserId(),
				getUserProfile(request).getBusinessId());
		
		putAjaxStatusObjInRequest(request, "You Destroyed Account Details Successfully");
		return mapping.findForward("generalJsp");
	}

	public ActionForward cancelResetPassword(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-cancelTrigger...-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("accSettings");
		return (forward);
	}

	public ActionForward sendAnInstantEmail(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-sendAnInstantEmail-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("sendAnInstantEmail");
		long businessId = getUserProfile(request).getBusinessId();
		LCH_BUSINESS businessDetails = getSpringCtxDoTransactionBean().getBusinessDetails(businessId,getUserProfile(request).getUserId());
		List<Map<String, Object>>  listAllMyEmployees = getSpringCtxDoTransactionBean().getAllMyEmployeesList(businessId,
				null, null);
		putObjInRequest("listAllMyEmployees", request, listAllMyEmployees);
		log.info(businessDetails.getEmployerEmail());
		putObjInRequest("businessDetails", request, businessDetails);
		return (forward);
	}

	public ActionForward sendGenericEmailToEmployees(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-sendAnInstantEmail-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("adminFunctions");
		long businessId = getUserProfile(request).getBusinessId();
		NotifyEmployeesBean bean = (NotifyEmployeesBean)form;
		if(bean.getEmailContent()==null || bean.getEmailContent().trim().length() == 0)
		{
			putStatusObjInRequest(request, "Email Content was not found. No Employees were notified.");
		}
		else if(bean.getSubject()==null || bean.getSubject().trim().length() == 0)
		{
			putStatusObjInRequest(request, "Email Subject was not found. No Employees were notified.");
		}
		else
		{
			String msg = "Employees Notified as requested";
			List<String> cc = new ArrayList<String>();
			
			EmailDetails emailDetails = new EmailDetails();
			List<Map<String, String>> listAllMyEmployees;
			if(bean.getEmployeeType().equals("all"))
			{
				listAllMyEmployees = getSpringCtxDoTransactionBean().getAllMyEmployeesEmails(businessId);
			}
			else
			{
				listAllMyEmployees = getSpringCtxDoTransactionBean().getAllMyEmployeesEmailsByTimeSheetConfiguration(businessId, bean.getEmployeeType());
			}
			
			
			for(Map<String, String> email : listAllMyEmployees)
			{
				cc.add(email.get("contactEmail"));
			
				VMInputBean vmbean = new VMInputBean();
				vmbean.setText(bean.getEmailContent());
				emailDetails.setSubject(bean.getSubject());
				String sb = getEmailTemplate(vmbean, VMConstants.VM_NOTIFY_EMPLOYEES);
				emailDetails.setEmailContent(new StringBuffer(sb));
				emailDetails.setCc(cc);
				log.info("Size of file attached {} , 2MB : {}", bean.getAttachement().getFileSize() , 1024*1024*2);
				if(bean.getAttachement()!=null && bean.getAttachement().getFileSize() > 0 && bean.getAttachement().getFileSize() < 1024*1024*2)
				{
					log.info("Size of file attached {}", bean.getAttachement());
					emailDetails.setAttachment(FormFile2File.convertToFile(bean.getAttachement()));
				}
	
				emailDetails.setFrom(getUserProfile(request).getEmployerEmail());
				sendEmail(emailDetails);	
			}
			
			if(bean.getAttachement()!=null && bean.getAttachement().getFileSize() > 0 && bean.getAttachement().getFileSize() < 1024*1024*2)
			{
				msg = msg + " with file attachement";
			}
			else
			{
				msg = msg + " with no file attachement";
			}
			sendReportToEmployer(getUserProfile(request),cc, bean.getSubject(),bean.getAttachement());
			putStatusObjInRequest(request, msg);
			putObjInRequest("isNotified", request, "yes");
		}
		
		return (forward);
	}
	
	private void sendReportToEmployer(UserProfile profile, List<String> employees, String subject, FormFile attachment)
	{
		EmailDetails emailDetails = new EmailDetails();
		VMInputBean vmbean = new VMInputBean();
		int count = 1;
		StringBuffer text = new StringBuffer();
		for (String name : employees)
		{
			text.append(count).append(".").append(name).append("<BR>");
		}
		vmbean.setText(text.toString());
		emailDetails.setSubject("Status report  for :  " + subject);
		String sb = getEmailTemplate(vmbean, VMConstants.VM_GENERIC_EMAIL);
		emailDetails.setEmailContent(new StringBuffer(sb));
		ArrayList<String> cc= new ArrayList<String>();
		cc.add(profile.getEmployerEmail());
		emailDetails.setCc(cc);
		if(attachment!=null && attachment.getFileSize() > 0 && attachment.getFileSize() < 1024*1024*2)
		{
			log.info("Size of file attached {}", attachment);
			emailDetails.setAttachment(FormFile2File.convertToFile(attachment));
		}
		emailDetails.setFrom(profile.getEmployerEmail());
		sendEmail(emailDetails);
	}
	
	public ActionForward sendBusinessIdToAllMyEmployees(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-sendBusinessIdToAllMyEmployees-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("adminFunctions");
		long businessId = getUserProfile(request).getBusinessId();
		List<Map<String, String>> listAllMyEmployees = getSpringCtxDoTransactionBean().getAllMyEmployeesEmails(businessId);
		
		List<String> bcc = new ArrayList<String>();
		
		EmailDetails emailDetails = new EmailDetails();

		for(Map<String, String> email : listAllMyEmployees)
		{
			bcc.add(email.get("contactEmail"));
		}
		VMInputBean bean = new VMInputBean();
		bean.setText(String.valueOf(businessId));
		emailDetails.setSubject("Your Employer Id");
		String sb = getEmailTemplate(bean, VMConstants.VM_BUSINESS_ID_TOALL);
		emailDetails.setEmailContent(new StringBuffer(sb));
		emailDetails.setBcc(bcc);
		emailDetails.setFrom(getUserProfile(request).getEmployerEmail());
		sendEmail(emailDetails);
		putStatusObjInRequest(request, "All Your Employees Notified Successfully");
		putObjInRequest("isNotified", request, "yes");
		return (forward);
	}
	
	public ActionForward requestAllEmployeesToUpdateTheirProfiles(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-sendBusinessIdToAllMyEmployees-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("adminFunctions");
		long businessId = getUserProfile(request).getBusinessId();
		List<Map<String, String>> listAllMyEmployees = getSpringCtxDoTransactionBean().getAllMyEmployeesEmails(businessId);
		
		List<String> bcc = new ArrayList<String>();
		
		EmailDetails emailDetails = new EmailDetails();

		for(Map<String, String> email : listAllMyEmployees)
		{
			bcc.add(email.get("contactEmail"));
		}
		VMInputBean bean = new VMInputBean();
		bean.setText(String.valueOf(businessId));
		emailDetails.setSubject("Request from your employer : " + getUserProfile(request).getEmployerName());
		String sb = getEmailTemplate(bean, VMConstants.VM_REQUEST_TO_UPDATE_PROFILE);
		emailDetails.setEmailContent(new StringBuffer(sb));
		emailDetails.setBcc(bcc);
		emailDetails.setFrom(getUserProfile(request).getEmployerEmail());
		sendEmail(emailDetails);
		putStatusObjInRequest(request, "All Your Employees Notified Successfully");
		putObjInRequest("isNotified", request, "yes");
		return (forward);
	}
	
	public ActionForward requestAnEmployeeToUpdateProfile(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-sendBusinessIdToAllMyEmployees-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("generalJSP4AJAXMsg");
		
		long usrId = getLongAsRequestParameter("ajaxParam", request);
		String usrEmail = getSpringCtxDoTransactionBean().getUserEmail(usrId);
		
		List<String> bcc = new ArrayList<String>();
		
		EmailDetails emailDetails = new EmailDetails();
		bcc.add(usrEmail);
		VMInputBean bean = new VMInputBean();
		emailDetails.setSubject("Request from your employer : " + getUserProfile(request).getEmployerName());
		String sb = getEmailTemplate(bean, VMConstants.VM_REQUEST_TO_UPDATE_PROFILE);
		emailDetails.setEmailContent(new StringBuffer(sb));
		emailDetails.setTo(bcc);
		emailDetails.setFrom(getUserProfile(request).getEmployerEmail());
		sendEmail(emailDetails);
		putAjaxStatusObjInRequest(request, "Notified");
		return (forward);
	}
	
	public ActionForward cancelUserRateDetails(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-cancelTrigger...-");
		// isSignedIn(mapping,request,response);
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("adminFunctions");
		return (forward);
	}
	
	public ActionForward generateRandomPassword(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-generateRandomPassword...-");
		// isSignedIn(mapping,request,response);
		//RandomStringUtils utils = new RandomStringUtils();
		//String password = utils.random(8, true, true);
		
		// Fnd and send an email to employee
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("status");
		putStatusObjInRequest(request, "Employee notified to with the password");
		return (forward);
	}
	public ActionForward showNotifyEmailsPage(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-showNotifyEmailsPage...-");
		return mapping.findForward("showNotifyEmailsPage");
	}
	
	public ActionForward resetPasswordByAdmin(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		log.info("-resetPasswordByAdmin...-");
		
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("generalJSP4AJAXMsg");
		try{
		
		log.info("Generating Password ..");
		String password = GeneratePassword.getGeneratedPassword();
		
		log.info("Retrieving User Details...");
		long userId = getIntAsRequestParameter("userId", request);
		Map details = getSpringCtxDoTransactionBean().getUserDetailsByUserId(userId);

		log.info("Updating Password ..");
		
		Map m=new HashMap();
		m.put("userId",userId);
		m.put("businessId",getUserProfile(request).getBusinessId());
		m.put("password", password);
		getSpringCtxDoTransactionBean().updateResetedPassword(m);
		
		log.info("Sending email to employee..");
		
		String email = (String)details.get("contactEmail");
		ArrayList<String> to = new ArrayList<String>();
		to.add(email);
		VMInputBean vmbean = new VMInputBean();
		vmbean.setText("Your Password was reset by your employer.Your new passowrd :  " + password);
		EmailDetails emailDetails = new EmailDetails();
		emailDetails.setSubject("Your ILCH Password");
		String content = getEmailTemplate(vmbean,VMConstants.VM_PASSWORD_RESET_EMPLOYEE);
		emailDetails.setEmailContent(new StringBuffer(content));
		emailDetails.setTo(to);
		emailDetails.setFrom(getUserProfile(request).getEmployerEmail());
		sendEmail(emailDetails);
		putAjaxStatusObjInRequest(request,"Done!");
		
		log.info("Responding to admin..");
		}
		catch (Exception e) {
			log.error("Password Reset By admin for employee was failed", e);
			putAjaxStatusObjInRequest(request,"Unable to reset");
		}
		
		return forward;
	}
	
	public ActionForward sendBusinessIdToEmails(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-sendBusinessIdToEmails...-");
		
		String emails = getStrAsRequestParameter("emailsList", request);
		
		ArrayList report = EmailsReport.createReport(emails);
		
		if(report!=null && report.size() > 0)
		{
			ArrayList<String> validList = (ArrayList<String>)report.get(0);
			StringBuffer sb = (StringBuffer)report.get(1);
			
			VMInputBean bean = new VMInputBean();
			bean.setText(String.valueOf(getUserProfile(request).getBusinessId()));
			EmailDetails emailDetails = new EmailDetails();
			emailDetails.setSubject("Your Employer Id");
			String content = getEmailTemplate(bean, VMConstants.VM_BUSINESS_ID_TOALL);
			emailDetails.setEmailContent(new StringBuffer(content));
			emailDetails.setBcc(validList);
			emailDetails.setFrom(getUserProfile(request).getEmployerEmail());
			sendEmail(emailDetails);
			
			bean.setText(sb.toString());
			emailDetails.setSubject("ILCH - Status Report");
			String buffer = getEmailTemplate(bean,VMConstants.VM_GENERIC_EMAIL);
			emailDetails.setEmailContent(new StringBuffer(buffer));
			List<String> bcc = new ArrayList<String>();
			bcc.add(getUserProfile(request).getEmployerEmail());
			emailDetails.setFrom(EmailConstants.FROM_EMAIL);
			emailDetails.setTo(bcc);
			sendEmail(emailDetails);
			
			putStatusObjInRequest(request, "Processed, Please check your email for report, Please add this email to your safer list if you found in SPAM.");
		}
		else
		{
			putStatusObjInRequest(request, "Invalid Emails List");
		}
		
		return mapping.findForward("status");
	}
}
