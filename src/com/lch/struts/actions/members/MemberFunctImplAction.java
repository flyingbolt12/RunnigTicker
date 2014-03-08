package com.lch.struts.actions.members;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.support.JdbcUtils;

import com.lch.general.Roles;
import com.lch.general.constants.GeneralConstants;
import com.lch.general.constants.VMConstants;
import com.lch.general.dbBeans.Address;
import com.lch.general.dbBeans.DBConstants;
import com.lch.general.dbBeans.LCH_BUSINESS;
import com.lch.general.email.EmailDetails;
import com.lch.general.enums.DOCTypes;
import com.lch.general.enums.SubmissionFor;
import com.lch.general.enums.TimeSheetStatus;
import com.lch.general.enums.TimeSheetTypes;
import com.lch.general.generalBeans.ImmigrationDetailsBean;
import com.lch.general.generalBeans.UserProfile;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.general.genericUtils.DateUtils;
import com.lch.general.genericUtils.WeekToWeekDates;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.spring.BusinessComponents.UpdateUserSession;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.formBeans.admin.AdminRegistrationBean;
import com.lch.struts.formBeans.members.EmployeeRegistrationBean;
import com.lch.struts.formBeans.members.TimeSheetSupportingDocBean;

/**
 * @version 1.0
 * @author
 */
@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
public class MemberFunctImplAction extends BaseAction {
	private static Logger log = LoggerFactory.getLogger(MemberFunctImplAction.class);

	public ActionForward submitMyHrs(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("collectYearAndMonth");

		UserProfile userProfile = getUserProfile(request);
		// update the UserProfile for all remaining details.
		if (userProfile.getClientId() != 0) {
			getSpringCtxDoTransactionBean().updateRequiredDetails(userProfile);
		} else {
			if (userProfile.getClientId() == 0) {
				log.info("Diverting to Update client Details..");
				request.setAttribute("clientErrMsg",
						"You are not having any client associated. Please update your Client Details");
				forward = mapping.findForward("updateMyClient");
			}
		}
		setTimeSheetReloadMethodInRequest(request);
		log.info("submitMyHrs - Strat working");
		return forward;
	}

	private void setTimeSheetReloadMethodInRequest(HttpServletRequest request) {
		UserProfile userProfile = getUserProfile(request);
		TimeSheetTypes types = TimeSheetTypes.valueOf(userProfile
				.getTimeSheetConfiguredTo());
		String methodName = "reloadMonthlyHrsSubmission";
		switch (types) {
		case BIWEEKLY: {
			methodName = "reloadBiWeeklyHrsSubmission";
			break;
		}
		case WEEKLY: {
			methodName = "reloadWeeklyHrsSubmission";
			break;
		}
		case MONTHLY: {
			methodName = "reloadMonthlyHrsSubmission";
			break;
		}
		case DAYS15: {
			methodName = "reload15DaysHrsSubmissionForMonthAndYear";
			break;
		}
		}
		putObjInRequest("methodName", request, methodName);

	}

	public ActionForward checkClientDetailsBeforeSubmitMyHrs(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();

		forward = mapping.findForward("checkClientDetailsBeforeSubmitMyHrs");
		log.info("submitMyHrs - Strat working");
		return forward;
	}

	public ActionForward intimateVacation(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("intimateVacation");
		log.info("intimateVacation - Strat working");
		return forward;
	}

	public ActionForward notifyEmployer(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info(" -- notifyEmployer -- Start working");

		ActionForward forward = new ActionForward();
		long userId = getLongAsRequestParameter("userId", request);
		String requestFor = request.getParameter("requestFor");
		System.out.println(requestFor);
		if (requestFor != null && !requestFor.trim().equalsIgnoreCase("Skip")) {
			sendEmailToEmployer(getUserProfile(request));
			putObjInRequest("isEmployerNotified", request, "yes");
		}
		// List<ListOrderedMap> details =
		// getSpringCtxDoTransactionBean().listBusinessAndUserDetails(userId);
		forward = mapping.findForward("memberFunctions");
		return forward;
	}

	private void sendEmailToEmployer(UserProfile prof) {
		String employeeEmail = prof.getEmployeeEmail();

		ArrayList to = new ArrayList();
		ArrayList cc = new ArrayList();

		cc.add(employeeEmail);
		to.add(prof.getEmployerEmail());
		EmailDetails emailDetails = new EmailDetails();

		emailDetails.setFrom("contact@allibilli.com");
		emailDetails.setTo(to);
		//emailDetails.setCc(cc);
		emailDetails.setSubject("ILCH - Need Action - Time Sheets");
		emailDetails.setEmailContent(getEmailContent(prof));
		sendEmail(emailDetails);
	}

	public ActionForward reloadBiWeeklyHrsSubmission(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = mapping.findForward("biWeeklyDef");
		String pageTo = getStrAsRequestParameter("pageTo", request);
		UserProfile userProfile = getUserProfile(request);
		int totalRecords = 0;
		int month = getIntAsRequestParameter("month", request);
		int year = getIntAsRequestParameter("year", request);
		long startDay, endDay;
		Calendar startCal, endCal, requestedDate;
		putObjInRequest("year", request, year);
		putObjInRequest("month", request, month);
		Calendar custom = Calendar.getInstance();
		String weekStartDate = "";

		if (month >= 0 && year != 0) {
			custom.set(Calendar.MONTH, month);
			custom.set(Calendar.YEAR, year);
			custom.set(Calendar.DAY_OF_MONTH,
					Calendar.getInstance().get(Calendar.DAY_OF_MONTH));
			getUserProfile(request).getDu().setCustomDay(custom);
		}
		startDay = getLongAsRequestParameter("startDate", request);
		endDay = getLongAsRequestParameter("endDate", request);

		startCal = Calendar.getInstance();
		endCal = Calendar.getInstance();

		if (startDay != 0 && endDay != 0) {
			startCal.setTimeInMillis(startDay);
			endCal.setTimeInMillis(endDay);
		}
		if (pageTo != null && pageTo.equalsIgnoreCase("next")) {
			endCal.add(Calendar.DAY_OF_MONTH, 1);
			getUserProfile(request).getDu().setPastSundayCal(endCal);
		} else if (pageTo != null && pageTo.equalsIgnoreCase("previous")) {
			startCal.add(Calendar.DAY_OF_MONTH, -14);
			getUserProfile(request).getDu().setPastSundayCal(startCal);
		} else {
			getUserProfile(request).getDu().setPastSundayCal(custom);
		}
		requestedDate = getUserProfile(request).getDu().getPastSundayCal();

		if (startDay == 0 && endDay == 0) {
			startDay = requestedDate.getTimeInMillis();
			requestedDate.add(Calendar.DAY_OF_MONTH, 14);
			endDay = requestedDate.getTimeInMillis();
		}

		DateUtils dtUtil = getUserProfile(request).getDu();
		String weekDates[] = WeekToWeekDates.getBiWeeklyDates(getUserProfile(request));
		if (weekDates != null && weekDates.length > 1)
			weekStartDate = weekDates[0];

		List hrsList = getSpringCtxDoTransactionBean().getSummaryHrs(userProfile,
				TimeSheetTypes.BIWEEKLY, weekStartDate);
		totalRecords = hrsList.size();
		setTimeSheetReloadMethodInRequest(request);

		if (totalRecords > 0) {
			Map<String, Object> m = (Map<String, Object>) hrsList.get(0);

			TimeSheetStatus timeSheetStatus = TimeSheetStatus.valueOf((String) m
					.get("status"));
			saveTimeSheetSubmittedErrors(timeSheetStatus, request);

		}

		return forward;
	}

	public ActionForward reloadWeeklyHrsSubmission(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("weeklyDef");
		String pageTo = getStrAsRequestParameter("pageTo", request);
		UserProfile userProfile = getUserProfile(request);

		int totalRecords = 0;
		int month = getIntAsRequestParameter("month", request);
		int year = getIntAsRequestParameter("year", request);
		// long startDay;
		long endDay;
		// Calendar startCal;
		Calendar endCal;
		Calendar requestedDate;
		putObjInRequest("year", request, year);
		putObjInRequest("month", request, month);
		Calendar custom = Calendar.getInstance();
		String weekStartDate = "";

		month = getIntAsRequestParameter("month", request);
		year = getIntAsRequestParameter("year", request);
		putObjInRequest("year", request, year);
		putObjInRequest("month", request, month);

		if (month >= 0 && year != 0) {
			custom.set(Calendar.MONTH, month);
			custom.set(Calendar.YEAR, year);
			custom.set(Calendar.DAY_OF_MONTH, 1);
			getUserProfile(request).getDu().setCustomDay(custom);
		}
		// startDay = getLongAsRequestParameter("startDate", request);
		endDay = getLongAsRequestParameter("endDate", request);

		// startCal = Calendar.getInstance();
		endCal = Calendar.getInstance();

		// if (startDay != 0) {
		// startCal.setTimeInMillis(startDay);
		// }

		if (endDay != 0) {
			endCal.setTimeInMillis(endDay);
		}

		if (pageTo != null && pageTo.equalsIgnoreCase("next")) {
			endCal.add(Calendar.DAY_OF_MONTH, 1);
			getUserProfile(request).getDu().setPastSundayCal(endCal);
		} else if (pageTo != null && pageTo.equalsIgnoreCase("previous")) {
			endCal.add(Calendar.DAY_OF_MONTH, -14);
			getUserProfile(request).getDu().setPastSundayCal(endCal);
		} else {
			getUserProfile(request).getDu().setPastSundayCal(custom);
		}

		requestedDate = getUserProfile(request).getDu().getPastSundayCal();
		log.info("requested page Start Date {}", requestedDate.getTime());
		DateUtils dtUtil = getUserProfile(request).getDu();

		if (endDay == 0) {
			// startDay = requestedDate.getTimeInMillis();
			// log.info("Start Date {}", requestedDate.getTime());
			requestedDate.add(Calendar.DAY_OF_MONTH, 6);
			endDay = requestedDate.getTimeInMillis();
			log.info("End Date {}", requestedDate.getTime());
		} else {
			// log.info("Start Date {}", startCal.getTime());
			log.info("End Date {}", endCal.getTime());
		}
		String weekDates[] = WeekToWeekDates.getWeeklyDates(getUserProfile(request));

		weekStartDate = "";
		if (weekDates != null && weekDates.length > 1)
			weekStartDate = weekDates[0];

		List lResult = getSpringCtxDoTransactionBean().getSummaryHrs(userProfile,
				TimeSheetTypes.WEEKLY, weekStartDate);
		totalRecords = lResult.size();
		setTimeSheetReloadMethodInRequest(request);

		if (totalRecords > 0) {
			Map<String, Object> m = (Map<String, Object>) lResult.get(0);

			TimeSheetStatus timeSheetStatus = TimeSheetStatus.valueOf((String) m
					.get("status"));
			saveTimeSheetSubmittedErrors(timeSheetStatus, request);

		}

		return forward;
	}

	public ActionForward reload15DaysHrsSubmissionFromTimeSheetPage(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;

		log.info("reload15DaysHrsSubmissionFromTimeSheetPage - Strat working");

		String pageFrom = getStrAsRequestParameter("pageFrom", request);
		String pageTo = getStrAsRequestParameter("pageTo", request);

		setTimeSheetReloadMethodInRequest(request);

		if (pageFrom != null && (pageFrom == "" || pageFrom.equals("")))
			pageFrom = null;
		if (pageTo != null && (pageTo == "" || pageTo.equals("")))
			pageTo = null;

		if (pageTo != null) {
			if (pageTo.equals(GeneralConstants.FIRST_15_DAYS_OF_MONTH))
				forward = mapping.findForward(GeneralConstants.FIRST_15_DAYS_OF_MONTH);
			else if (pageTo.equals(GeneralConstants.SECOND_15_DAYS_OF_MONTH))
				forward = mapping.findForward(GeneralConstants.SECOND_15_DAYS_OF_MONTH);
		}

		List submitedTimeSheets = getSpringCtxDoTransactionBean().listSubmittedHrs(
				getUserProfile(request), TimeSheetTypes.DAYS15);
		TimeSheetStatus timeSheetStatus = TimeSheetStatus.NOTSUBMITTED;
		TimeSheetStatus timeSheetStatus2 = TimeSheetStatus.NOTSUBMITTED;

		if (submitedTimeSheets.size() >= 1) {
			Map<String, Object> m = (Map<String, Object>) submitedTimeSheets.get(0);
			timeSheetStatus = TimeSheetStatus.valueOf((String) m.get("status"));
			SubmissionFor submissionType = SubmissionFor.valueOf((String) m
					.get("submissionFor"));

			SubmissionFor submissionType2 = SubmissionFor.SECOND;

			if (submitedTimeSheets.size() >= 2) {
				Map<String, Object> m2 = (Map<String, Object>) submitedTimeSheets.get(1);
				timeSheetStatus2 = TimeSheetStatus.valueOf((String) m2.get("status"));
				submissionType2 = SubmissionFor.valueOf((String) m2.get("submissionFor"));
			}

			if (pageTo != null) {
				if (pageTo.equals(GeneralConstants.FIRST_15_DAYS_OF_MONTH) && submissionType == SubmissionFor.FIRST) {
					saveTimeSheetSubmittedErrors(timeSheetStatus, request);
				} else if (pageTo.equals(GeneralConstants.SECOND_15_DAYS_OF_MONTH) && submissionType == SubmissionFor.SECOND) {
					saveTimeSheetSubmittedErrors(timeSheetStatus, request);
				} else if (pageTo.equals(GeneralConstants.FIRST_15_DAYS_OF_MONTH) && submissionType2 == SubmissionFor.FIRST) {
					saveTimeSheetSubmittedErrors(timeSheetStatus2, request);
				} else if (pageTo.equals(GeneralConstants.SECOND_15_DAYS_OF_MONTH) && submissionType2 == SubmissionFor.SECOND) {
					saveTimeSheetSubmittedErrors(timeSheetStatus2, request);
				}
			}

		}
		return forward;
	}

	
	
	

	private void saveTimeSheetSubmittedErrors(TimeSheetStatus timeSheetStatus, HttpServletRequest request) {
		if ((timeSheetStatus == TimeSheetStatus.PENDING) || (timeSheetStatus == TimeSheetStatus.APPROVED)) {
			ActionErrors errors = new ActionErrors();
			ActionMessage message;
			if (timeSheetStatus == TimeSheetStatus.PENDING)
				message = new ActionMessage("user.alreday.submit.hours", new Object[] {});
			else
				message = new ActionMessage("timesheet.hours.alreday.approved",
						new Object[] {});
			errors.add("msg", message);
			saveErrors(request, errors);
		} else if (timeSheetStatus == TimeSheetStatus.REJECTED) {
			putObjInRequest("isTimsheetEdit", request, "TRUE");
		}
	}

	public ActionForward reload15DaysHrsSubmissionForMonthAndYear(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		log.info("reload15DaysHrsSubmissionForMonthAndYear - Strat working");
		TimeSheetStatus timeSheetStatus = TimeSheetStatus.NOTSUBMITTED;
		ActionForward forward = null;
		int nAvailableRows = 0;
		setTimeSheetReloadMethodInRequest(request);

		Calendar customDay = Calendar.getInstance();
		int month = customDay.get(Calendar.MONTH);
		int year = customDay.get(Calendar.YEAR);

		try {
			month = getIntAsRequestParameter("month", request);
			year = getIntAsRequestParameter("year", request);
		} catch (Exception e) {
			putAjaxStatusObjInRequest(request, e.getMessage());
			forward = mapping.findForward("exception");
			log.error(e.getMessage(), e);
			return forward;
		}

		DateUtils du = new DateUtils(year, month);
		UserProfile userProfile = getUserProfile(request);
		userProfile.setDu(du);

		List submitedTimeSheets = getSpringCtxDoTransactionBean().listSubmittedHrs(
				getUserProfile(request), TimeSheetTypes.DAYS15);

		if (submitedTimeSheets.size() == 0) {

			if ((Calendar.getInstance().get(Calendar.DAY_OF_MONTH) <= 15)) {
				forward = mapping.findForward(GeneralConstants.FIRST_15_DAYS_OF_MONTH);
			} else {
				forward = mapping.findForward(GeneralConstants.SECOND_15_DAYS_OF_MONTH);
			}

		} else if (submitedTimeSheets.size() >= 1) {

			forward = mapping.findForward(GeneralConstants.FIRST_15_DAYS_OF_MONTH);

			Map<String, Object> m = (Map<String, Object>) submitedTimeSheets.get(0);
			String status = (String) m.get("status");
			timeSheetStatus = TimeSheetStatus.valueOf(status);

			saveTimeSheetSubmittedErrors(timeSheetStatus, request);
		}

		return forward;
	}

	public ActionForward reloadMonthlyHrsSubmission(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		log.info("reloadMonthlyHrsSubmission - Strat working");
		setTimeSheetReloadMethodInRequest(request);

		ActionForward forward = mapping.findForward(GeneralConstants.MONTHLY);
		Calendar customDay = Calendar.getInstance();
		int month = customDay.get(Calendar.MONTH);
		int year = customDay.get(Calendar.YEAR);

		try {
			month = getIntAsRequestParameter("month", request);
			year = getIntAsRequestParameter("year", request);
		} catch (Exception e) {
			putAjaxStatusObjInRequest(request, e.getMessage());
			forward = mapping.findForward("exception");
			log.error(e.getMessage(), e);
			return forward;
		}

		DateUtils du = new DateUtils(year, month);
		UserProfile userProfile = getUserProfile(request);
		userProfile.setDu(du);
		TimeSheetStatus timeSheetStatus = TimeSheetStatus.NOTSUBMITTED;

		List submitedTimeSheets = getSpringCtxDoTransactionBean().listSubmittedHrs(
				getUserProfile(request), TimeSheetTypes.MONTHLY);

		if (submitedTimeSheets.size() >= 1) {
			Map<String, Object> m = (Map<String, Object>) submitedTimeSheets.get(0);
			timeSheetStatus = TimeSheetStatus.valueOf((String) m.get("status"));
		}

		saveTimeSheetSubmittedErrors(timeSheetStatus, request);
		return forward;
	}

	StringBuffer getEmailContent(UserProfile prof) {
		VMInputBean bean = new VMInputBean();
		StringBuffer sb = new StringBuffer();
		sb.append(prof.getFirstName()).append(" working for ").append(prof.getCurrentClientName());
		bean.setText(sb.toString());
		String content = getEmailTemplate(bean, VMConstants.VM_PENDING_TIMESHEET);
		
		return sb;
	}

	public ActionForward showManageDocs(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("showManageDocs");
		log.info("showManageDocs - Strat working");
		UserProfile userProfile = getUserProfile(request);
		Long clientId = userProfile.getClientId();

		Long weeklyHrsSummaryId = getLongAsRequestParameter("weeklyHrsSummaryId", request);
		String managingFor = getStrAsRequestParameter("managingFor", request);

		List<FileDetails> files = new ArrayList<FileDetails>();

		String sIds = getSpringCtxDoTransactionBean().getTimesheetSupportingDocId(
				weeklyHrsSummaryId);
		List<Map<String, String>> filePaths = new ArrayList<Map<String, String>>();

		if (!sIds.equals("0")) {
			filePaths = getSpringCtxDoTransactionBean().listFilePaths(sIds);
		}
		putObjInRequest("files", request, filePaths);
		putObjInRequest("managingFor", request, managingFor);
		putObjInRequest("weeklyHrsSummaryId", request, weeklyHrsSummaryId);
		return forward;
	}

	public ActionForward removeAttachedDoc(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		log.info("removeAttachedDoc - Strat working");
		UserProfile userProfile = getUserProfile(request);
		Long clientId = userProfile.getClientId();
		
		long weeklyHrsSummaryId = getLongAsRequestParameter("weeklyHrsSummaryId", request);
		long idattacheddocs = getLongAsRequestParameter("idattacheddocs", request);
		
		String values = getSpringCtxDoTransactionBean().getSupporting_DOCSIDS_WEEKLYHRS_SUMMARY(String.valueOf(weeklyHrsSummaryId));
		values = values.replaceAll(idattacheddocs+",", "");
		values = values.replaceAll(","+idattacheddocs, "");
		values= values.replaceAll(String.valueOf(idattacheddocs), "");
		
		getSpringCtxDoTransactionBean().update_DOCSIDS_WEEKLYHRS_SUMMARY(String.valueOf(weeklyHrsSummaryId), values);
		
		getSpringCtxDoTransactionBean().deleteSupportingDoc(idattacheddocs);
		
		putAjaxStatusObjInRequest(request, "Removed");
		return mapping.findForward("generalJSP4AJAXMsg");

	}

	public ActionForward uploadTimeSheetSupportingDoc(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		TimeSheetSupportingDocBean bean = (TimeSheetSupportingDocBean)form;
		String weeklyHrsSummaryId = bean.getWeeklyHrsSummaryId();
		UserProfile userProfile = getUserProfile(request);
		String aFilePath = "";
		String rFilePath = "";
		if(bean.getTimeSheetSupportingDoc()!=null && bean.getTimeSheetSupportingDoc().getFileName()!=null && bean.getTimeSheetSupportingDoc().getFileSize() < 1024*1024*2 && bean.getTimeSheetSupportingDoc().getFileSize() > 0)
		{
			aFilePath = getApplicationPathToOneUP() + "supportingDocs";
			rFilePath = "/supportingDocs/";
			String savedFileName = userProfile.getBusinessId() + "_" + userProfile.getUserId() + "_" + DOCTypes.TimeSheetSupportingDoc.name() + "_" + bean.getTimeSheetSupportingDoc().getFileName();
			int fileSavedId =  getSpringCtxDoTransactionBean().handleSupportingFile(userProfile.getBusinessId(), userProfile.getUserId(),DOCTypes.TimeSheetSupportingDoc.name(),bean.getTimeSheetSupportingDoc().getFileData(),aFilePath,rFilePath,String.valueOf(weeklyHrsSummaryId),savedFileName);
			String existingIds = getSpringCtxDoTransactionBean().getSupporting_DOCSIDS_WEEKLYHRS_SUMMARY(String.valueOf(weeklyHrsSummaryId));
			int i = getSpringCtxDoTransactionBean().update_DOCSIDS_WEEKLYHRS_SUMMARY(String.valueOf(weeklyHrsSummaryId), existingIds+","+fileSavedId);
			
			putObjInRequest("timeSheetSupportingDocStatus", request, "yes");
		}
		else
		{
			putObjInRequest("timeSheetSupportingDocStatus", request, "no");
		}
		
		return showManageDocs(mapping, form, request, response);
	}
	
	public ActionForward updateMyClient(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("updateMyClient");
		log.info("updateMyClient - Strat working");
		UserProfile userProfile = getUserProfile(request);
		Long clientId = userProfile.getClientId();

		String selectionOptions = getStrAsRequestParameter("selectionOptions", request);
		if (selectionOptions.equalsIgnoreCase("existingClient")) {
			if (clientId == 0) {
				request.setAttribute("errMsg", "No Client Available to update");
				forward = mapping.findForward("insertNewClient");
			} else {
				List editMyClientDetailsList = getSpringCtxDoTransactionBean()
						.getEditMyClientDetails(userProfile);
				log.info("Result List Details : " + editMyClientDetailsList);
				putObjInSession("editMyClientDetailsList", request,
						editMyClientDetailsList);
				forward = mapping.findForward("updateMyClient");
			}
		}

		if (selectionOptions.equalsIgnoreCase("newClient")) {
			List listOfAvailableClients = getSpringCtxDoTransactionBean()
					.getListOfAvailableClients(userProfile);
			System.out.println(listOfAvailableClients);
			//putObjInRequest("listOfAvailableClients", request, listOfAvailableClients);
			putObjInSession("listOfAvailableClients", request, listOfAvailableClients);
			forward = mapping.findForward("insertNewClient");
		}

		return forward;
	}

	public ActionForward updateMyClientNext(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String cancel = request.getParameter("cancle");
		log.debug("Is Cancel Button status --->" + cancel);
		if (cancel != null) {
			return mapping.findForward("memberFunctions");
		}
		EmployeeRegistrationBean employeeRegistrationBean = (EmployeeRegistrationBean) form;
		AdminRegistrationBean adminRegistrationBean = new AdminRegistrationBean();
		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		long userId = userProfile.getUserId();

		if (getStrAsRequestParameter("isInsert", request) != null && !(getStrAsRequestParameter(
				"isInsert", request).equals(""))) {
			try {
				
				removeObjFrmSession("listOfAvailableClients", request);
				
				// Step 3: Inserting the Client Address
				Address address = employeeRegistrationBean.getListAddress(2);
				long clientAddressId = getSpringCtxDoTransactionBean().insertADDRESSINFO(
						address);
				log.info("Client AddressId got :" + clientAddressId);
				employeeRegistrationBean.setClientAddressId(clientAddressId);
				describeInstance(employeeRegistrationBean);

				if (employeeRegistrationBean != null && employeeRegistrationBean
						.getClientName() != null && employeeRegistrationBean
						.getClientName().equalsIgnoreCase("other")) {
					employeeRegistrationBean.setClientName(employeeRegistrationBean
							.getOtherClientName());
				}
				long clientId = getSpringCtxDoTransactionBean().insert_USER_CLIENTS_LIST(
						employeeRegistrationBean);
				log.info("clientId is:" + clientId);
				adminRegistrationBean.setClientId(clientId);
				Map m = new HashMap();
				m.put("clientAddressId", clientAddressId);
				m.put("clientId", clientId);
				m.put("userId", userId);
				m.put("businessId", businessId);
				getSpringCtxDoTransactionBean().updateClientIdInUsersTable(m);

				putAjaxStatusObjInRequest(request,
						"You Inserted New Client Details Successfully...");

				UpdateUserSession userSession = (UpdateUserSession) getSpringCTX()
						.getBean("sessionUpdate");
				UserProfile up = getUserProfile(request);
				userSession.updateSession(up);
				putObjInRequest("insertClientStatus", request, "yes");
				return mapping.findForward("memberFunctions");
			} catch (Exception e) {
				log.error(e.getMessage(), e);
				return mapping.findForward("updateMyClientDetailsFailure");
			}
		} else {

			try {
				long clientAddressId = getLongAsRequestParameter("clientAddressId",
						request);
				log.info("clientAddressId :" + clientAddressId);
				Address listAddress3 = employeeRegistrationBean.getListAddress(2);
				listAddress3.setIdAddressInfo(clientAddressId);
				getSpringCtxDoTransactionBean().updateAddress(listAddress3);
				String startDate = employeeRegistrationBean.getStartDate();
				Map m = new HashMap();
				m.put("businessId", businessId);
				m.put("userId", userId);
				m.put("startDate", startDate);
				getSpringCtxDoTransactionBean().updateClientData(m);
				putAjaxStatusObjInRequest(request,
						"You Updated Client Details Successfully...");

				UpdateUserSession userSession = (UpdateUserSession) getSpringCTX()
						.getBean("sessionUpdate");
				UserProfile up = getUserProfile(request);
				userSession.updateSession(up);

				putObjInRequest("updateClientStatus", request, "yes");
				return mapping.findForward("memberFunctions");
			} catch (Exception e) {
				log.error(e.getMessage(), e);
				return mapping.findForward("updateMyClientDetailsFailure");
			}
		}

	}

	public ActionForward downloadProfile(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		List l = getSpringCtxDoTransactionBean().listProfileDetails(
				request.getParameter("idattacheddocs"));
		Map m = ((Map) l.get(0));
		if (m != null && m.size() > 0) {
			String docAPath = (String) m.get("docAPath");
			String docSavedName = (String) m.get("docSavedName");
			String docName = (String) m.get("docName");

			if (docAPath != null && docSavedName != null && docName != null) {
				StringBuffer attachment = new StringBuffer();
				attachment.append("attachment;filename=").append(docName);
				File file = new File(docAPath + "\\" + docSavedName);

				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition", attachment.toString());
				response.setContentLength((int) file.length());

				java.io.PrintWriter os = response.getWriter();
				BufferedReader reader = new BufferedReader(new FileReader(file));
				String line;

				char[] buffer = new char[4096];
				int read = 0;

				while ((read = reader.read(buffer)) > 0) {
					line = new String(buffer, 0, read);
					os.write(line);
				}

				os.flush();
				reader.close();
				os.close();
			}
		}

		// return an application file instead of html page

		return null;

	}

	public ActionForward listEmployeeTimesheets(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("-listEmployeeTimesheets-");
		ActionForward forward = new ActionForward();
		String submitted_date;
		String action_date;
		
		List<Map<String, Object>> employeeTimesheets = getSpringCtxDoTransactionBean()
				.listEmployeeTimesheets(getUserProfile(request).getUserId());
		int i = 0;
		while (i < employeeTimesheets.size()) {
			Map m = employeeTimesheets.get(i);
			submitted_date = String.valueOf(m.get("submittedDate"));
			submitted_date = submitted_date.substring(0, 10);
			m.put("submittedDate", submitted_date);
			String recentHrs="";
			if (m.containsKey("recentHrs")) {
				Object objHours = m.get("recentHrs");
				if(objHours!=null && objHours instanceof byte[])
					recentHrs = new String((byte[])objHours);
				if(objHours!=null && objHours instanceof String)
					recentHrs = objHours.toString();
				if (!recentHrs.equalsIgnoreCase("null")) {
					m.put("recentHrs", recentHrs);
				}
			}
			if (m.containsKey("actionDate")) {
				action_date = String.valueOf(m.get("actionDate"));
				if (!action_date.equalsIgnoreCase("null")) {
					action_date = action_date.substring(0, 10);
					m.put("actionDate", action_date);
				}
			}
			i++;
		}
		putObjInRequest("employeeTimesheetPendingApprovals", request, employeeTimesheets);
		log.debug("Size of time sheets {}", employeeTimesheets.size());
		forward = mapping.findForward("listEmployeeTimesheets");
		return (forward);
	}

	/**
	 * Action method to display pending timesheets on a page to send reminder to
	 * the employer to approve the timesheets
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward showTimeSheetApprovalReminderPage(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// find timesheets and add them to request attribute
		ActionForward af = listEmployeeTimesheets(mapping, form, request, response);
		return mapping.findForward("showTimeSheetApprovalReminderPage");
	}

	public ActionForward buzzForTimeSheetApproval(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info(" -- Buzz Employer -- Start working");

		ActionForward forward = new ActionForward();
		long weeklyHrsSummaryId = getLongAsRequestParameter("weeklyHrsSummaryId", request);

		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		Map<String, Object> summaryDetails = doTransaction
				.getWeeklySummeryDetails(weeklyHrsSummaryId);
		UserProfile profile = getUserProfile(request);
		Map details = new HashMap<String, String>();
		details.put("name", profile.getFirstName());
		details.put("client", profile.getCurrentClientName());
		details.put("TH", summaryDetails.get(DBConstants.TH));
		details.put("OT", summaryDetails.get(DBConstants.OT));
		details.put("RH", summaryDetails.get(DBConstants.RH));
		details.put("HH", summaryDetails.get(DBConstants.HH));
		details.put("SUBMISSION_FOR", summaryDetails.get(DBConstants.SUBMISSION_FOR));
		details.put("START_WEEK_DATE", summaryDetails.get(DBConstants.START_WEEK_DATE));
		details.put("END_WEEK_DATE", summaryDetails.get(DBConstants.END_WEEK_DATE));
		details.put("SUBMITTED_DATE", summaryDetails.get(DBConstants.SUBMITTED_DATE));

		String emailContent = getEmailTemplate(details, VMConstants.VM_BUZZ);

		ArrayList to = new ArrayList();
		to.add(profile.getEmployerEmail());
		EmailDetails emailDetails = new EmailDetails();

		emailDetails.setFrom(profile.getEmployeeEmail());
		emailDetails.setTo(to);
		emailDetails
				.setSubject("Buzz - Waiting for approval for a pending time sheet submitted");
		emailDetails.setEmailContent(new StringBuffer(emailContent));
		sendEmail(emailDetails);
		putAjaxStatusObjInRequest(request, "Notified");
		return mapping.findForward("generalJSP4AJAXMsg");
	}

	public ActionForward updateResumeUploadScreen(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		return mapping.findForward("updateResumeUploadScreen");
	}

	public ActionForward updateMyResume(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();

		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		long userId = userProfile.getUserId();
		String msg = "";

		// clean current resumes

		// get Id from userpersonal
		Map<String, Object> map = getSpringCtxDoTransactionBean().getUserDetailsByUserId(
				userId);
		String profileId = (String) map.get("profilePath");

		if (profileId != null && !profileId.equals("-1") && profileId.length() > 0) {
			// Get File path
			map = getSpringCtxDoTransactionBean().getAttachmentDetails(profileId);

			// remove file
			File file = new File((String) map.get("docAPath"));
			file.delete();

			// remove from attached docs.
			getSpringCtxDoTransactionBean().removeResumes(userId);
			
			// set userprofile to -1
			getSpringCtxDoTransactionBean().update_USRPERSONALDATA_USR_PROFILE_ATTACHED_DOC_IDS(userId, -1);
		}

		try {
			EmployeeRegistrationBean employeeRegistrationBean = (EmployeeRegistrationBean) form;

			String aFilePath = "";
			String rFilePath = "";
			String fileName = employeeRegistrationBean.getProfilePath().getFileName();
			if (fileName == null || fileName.length() <= 0)
				msg = "Invalid file name, upload failed.";
			else if (employeeRegistrationBean.getProfilePath() != null && employeeRegistrationBean
					.getProfilePath().getFileName() != null && employeeRegistrationBean
					.getProfilePath().getFileSize() < 1024 * 1024 * 2) {
				aFilePath = getApplicationPathToOneUP() + "profiles";
				rFilePath = "/profiles/";
				boolean bStatus = getSpringCtxDoTransactionBean()
						.handleFileAndUpdateCorrespondingTable(businessId, userId,
								DOCTypes.UserProfile,
								employeeRegistrationBean.getProfilePath(), aFilePath,
								rFilePath);
				if (bStatus == true)
					msg = "Successfully Uploaded";
				else
					msg = "Upload failed.";
			} else {

				if (employeeRegistrationBean.getProfilePath().getFileSize() > 1024 * 1024 * 2)
					msg = "Shouln't be more than 2 MB in size. Upload Failed";
				else
					msg = "Upload failed.";
			}

		} catch (Exception e) {
			msg = "Sorry Couldn't able to update!! " + e.getMessage();
			e.printStackTrace();
		}
		
		if (msg.equals("Successfully Uploaded")) {
			VMInputBean bean = new VMInputBean();
			bean.setText(getUserProfile(request).getFirstName());
			EmailDetails emailDetails = new EmailDetails();
			ArrayList<String> to = new ArrayList<String>();
			to.add(getUserProfile(request).getEmployerEmail());
			emailDetails.setTo(to);
			emailDetails.setSubject(getUserProfile(request).getFirstName() + " Uploaded a new Profile into ILCH & CCS Application.");
			String sb = getEmailTemplate(bean, VMConstants.VM_RESUME_UPLOAD_NOTIFY);
			emailDetails.setEmailContent(new StringBuffer(sb));
			sendEmail(emailDetails);
			putObjInRequest("UserprofileUploadStatus", request, "yes");
			return mapping.findForward("memberFunctions");
		}
		else
		{
			putObjInRequest("UserprofileUploadStatus", request, "no");
			putObj4generalAJAXMsg(request, msg);
			return mapping.findForward("updateResumeUploadScreen");
		}
		
	}

	public ActionForward editMemberProfileForUpdate(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		putObjInRequest("isReqForEmpUpdate", request, "TRUE");
		forward = mapping.findForward("editMemberProfileForUpdate");
		long userId = getUserProfile(request).getUserId();
		log.info("userId =" + userId);
		Map editMyprofileDetailsMap = getSpringCtxDoTransactionBean()
				.getMemberProfileForUpdate(String.valueOf(userId),
						String.valueOf(getUserProfile(request).getBusinessId()));
		if (editMyprofileDetailsMap == null) {
			editMyprofileDetailsMap = new HashMap();
			request.setAttribute("errMsg", "This operation is not allowed");
		}

		putObjInSession("myProfileDetails", request, editMyprofileDetailsMap);

		return (forward);

	}

	public ActionForward memberUpdationForCacel(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("cancelUpdation");
		return (forward);

	}

	public ActionForward cancelSubmitHrs(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("-cancelTrigger...-TEST EXECUTED");
		// isSignedIn(mapping,request,response);
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("memberFunctions");
		return (forward);
	}

	public ActionForward showMemberResetPassword(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("-showMemberResetPassword...");

		ActionForward forward = new ActionForward();

		Map passwordData = getSpringCtxDoTransactionBean().getPasswordForAnAccount(
				getUserProfile(request).getUserId(),
				getUserProfile(request).getBusinessId());
		log.info("passwordData" + passwordData);
		putObjInRequest("passwordData", request, passwordData);
		forward = mapping.findForward("resetPasswordOfAnAccount");

		return (forward);
	}

	public ActionForward onClickingCancel(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("memberFunctions");
		
		if (getUserProfile(request).getUserRole().equals(Roles.MEMBER.name()))
		{
			return mapping.findForward("memberFunctions");
		} else {
			return mapping.findForward("adminFunctions");
		}
		
	}

	public ActionForward verifyEmployerValidity(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionErrors errors = new ActionErrors();
		try
		{
			long businessId = getLongAsRequestParameter("ajaxParam", request);
			if(getUserProfile(request).getBusinessId() == businessId)
			{
				putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
				putAjaxStatusObjInRequest(request, " Mistake!! Changing to same Employer. Not allowed");
			}
			else{
				String employerName = getSpringCtxDoTransactionBean().getValidatedEmployerName(businessId);
				if(employerName != null)
				{				
					putAjaxStatusObjInRequest(request, "Employer Name found : " + employerName +". Identity Verified, Proceed Further" );
				}
				else
				{
					putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
					putAjaxStatusObjInRequest(request, "  OOps! Invalid Employer Code  ");
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			errors.add("businessIdInvalid", new ActionMessage("businessIdInvalid"));
			saveErrors(request, errors);
			putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
			putAjaxStatusObjInRequest(request, "  OOps! Invalid Employer Code  ");			
		}
		
		return mapping.findForward("generalJSP4AJAXMsg");
		
	}
	public ActionForward changeEmployer(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		long userId = getUserProfile(request).getUserId();
		long oldBusinessId = getUserProfile(request).getBusinessId();
		
		// Make an X Employee
		// getSpringCtxDoTransactionBean().makeXEmployee(userId, oldBusinessId);
		
		long businessId = getLongAsRequestParameter("employerCode", request);

		log.info("Start Changing employer for user {} to {}", userId, businessId);
		// Step 1 : update user approval status
		getSpringCtxDoTransactionBean().pendingUserEmployeeChange(userId, businessId);

		// Step 2 : Send an email to business
		notifyBusinessForEmployerChange(businessId, request, userId);
		forward = mapping.findForward("signout");
		putObjInRequest("isEmployerChangeRequestMade", request, "yes");
		getSession(request).invalidate();
		// Update user profile

		return (forward);
	}

	public void notifyBusinessForEmployerChange(long businessId, HttpServletRequest request, long userId) {
		try {
			LCH_BUSINESS businessDetails = getSpringCtxDoTransactionBean()
					.getBusinessDetailsByBusiness(businessId);
			EmailDetails emailDetails = new EmailDetails();
			ArrayList<String> to = new ArrayList<String>();
			String businessEmailId = businessDetails.getEmployerEmail();

			if (businessEmailId != null && businessEmailId.length() > 0) {
				to.add(businessEmailId);
				emailDetails.setTo(to);
				emailDetails.setSubject("Employee Registration - Approval Pending");
				StringBuffer sb = getEmailContent(userId,
						getSpringCtxDoTransactionBean(), request);
				emailDetails.setEmailContent(sb);
				sendEmail(emailDetails);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String buildHTML(String filePath, String fileName, HttpServletRequest request) {
		return "<img src=\"" + filePath + fileName + "\"/><BR>";
	}
	
	public ActionForward showUpdateImmigrationDetailsPage(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("showUpdateImmigrationDetailsPage");
		long userId = getUserProfile(request).getUserId();
		// To handel teh request from Admin page
		if(request.getParameter("isFromAdmin")!=null) {
			userId = getLongAsRequestParameter("userId", request);
		}
		
		ImmigrationDetailsBean immigrationDetails = getSpringCtxDoTransactionBean()
				.listImmigrationDetails(userId);
		putObjInRequest("immigrationDetails", request, immigrationDetails);
		return (forward);
	
	}

	public ActionForward saveOrUpdateImmigrationDetails(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("memberFunctions");
		log.info("saveOrUpdateImmigrationDetails - Strat working");
		UserProfile userProfile = getUserProfile(request);

		ImmigrationDetailsBean bean = new ImmigrationDetailsBean();
		bean.setIdimmigrationdetails(getLongAsRequestParameter("idimmigrationdetails", request));
		bean.setPassportExpiryDate(getSQLDateAsRequestParameter("passportExpiryDate", request));
		bean.setPassportIssueDate(getSQLDateAsRequestParameter("passportIssueDate", request));
		bean.setVisaExpiryDate(getSQLDateAsRequestParameter("visaExpiryDate", request));
		bean.setVisaIssuedDate(getSQLDateAsRequestParameter("visaIssuedDate", request));
		bean.setPassportNumber(request.getParameter("passportNumber"));
		bean.setVisaType(request.getParameter("visaType"));
		bean.setUserId(getLongAsRequestParameter("userId", request));;
		
		if(bean.getUserId() <= 0l || bean.getPassportExpiryDate() == null || bean.getPassportIssueDate() == null || bean.getVisaExpiryDate() == null || bean.getVisaIssuedDate() == null ) {
			putStatusObjInRequest(request,"Invalid Details Found");
			return  mapping.findForward("showUpdateImmigrationDetailsPage");
		}
		getSpringCtxDoTransactionBean().saveOrUpdateImmigrationDetails(bean);
		
		putObjInRequest("ImmigrationDetails", request, "yes");
		return forward;
	}

}

class FileDetails {
	String filePath;
	String fileName;
}