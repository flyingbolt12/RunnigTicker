package com.lch.struts.actions.admin;

import java.text.DateFormatSymbols;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.POI.ExportToExcel;
import com.lch.general.generalBeans.CategoriesAndEmployees;
import com.lch.general.generalBeans.UserProfile;
import com.lch.general.genericUtils.EmployeeTimeSheetsBasedOnTypes;
import com.lch.general.genericUtils.MonthlyExcelReportHelpr;
import com.lch.struts.actions.members.ReportsBase;
import com.lch.struts.formBeans.DownloadedEmployeeBean;

public class AdminReportsImpl extends ReportsBase {

	private static Logger log = LoggerFactory.getLogger(AdminFunctImplAction.class);

	public ActionForward collectYearAndMonths(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("collectYearAndMonth");
		return forward;
	}

	public ActionForward generateEmployeeMonthlyTimeSheetHours(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();

		int month = getIntAsRequestParameter("month", request);
		int year = getIntAsRequestParameter("year", request);

		String monthName = new DateFormatSymbols().getMonths()[month];
		String businessName = getUserProfile(request).getEmployerName();
		String fileName = "Confidential_" + monthName + "_" + businessName + ".xlsx";

		List<Map<String, Object>> listAllMyCategories = getSpringCtxDoTransactionBean().listCategories(getUserProfile(request));

		if (listAllMyCategories == null) {
			listAllMyCategories = new ArrayList<Map<String, Object>>();
		}

		int previousMonth = month;
		int previousYear = year;
		if (month - 1 < 0) {
			previousMonth = 12;
			previousYear = year - 1;
		}
		List<CategoriesAndEmployees> categoriesAndEmployeeTimeSheets = getSpringCtxDoTransactionBean().getCategorySpecificEmployees(month, previousMonth, year, previousYear, getBusinessId(request));

		if (categoriesAndEmployeeTimeSheets.size() > 0) {
			
			MonthlyExcelReportHelpr helper = new MonthlyExcelReportHelpr(getSpringCtxDoTransactionBean());
			Map<String, EmployeeTimeSheetsBasedOnTypes> independentEmployeeMonthlyTimeSheets = helper.startProcessing(categoriesAndEmployeeTimeSheets, previousMonth, year, getBusinessId(request));

			log.info("Before Exporting to Excel {}", independentEmployeeMonthlyTimeSheets);

			SXSSFWorkbook book = ExportToExcel.generateReport(listAllMyCategories, categoriesAndEmployeeTimeSheets, independentEmployeeMonthlyTimeSheets);

			ServletOutputStream out1 = null;
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-disposition", "attachment;filename=" + fileName);
			response.setHeader("Cache-Control", "cache");
			response.addHeader("Cache-Control", "must-revalidate");
			response.setHeader("Pragma", "public");
			out1 = response.getOutputStream();

			book.write(out1);
		} else {
			forward = mapping.findForward("collectYearAndMonth");
			putStatusObjInRequest(request, "No Data Available");
			return forward;
		}
		return null;
	}

	public ActionForward downloadCancelation(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("downloadCancelation");
		return (forward);
	}

	public ActionForward showAdminDownloadAllEmployeesSortOpetionPage(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("showAdminDownloadAllEmployeesSortOpetionPage");
		return (forward);
	}

	public ActionForward downloadedEmployeeStartingAndEndingWith(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		log.info("-downloadedEmployeeStartingAndEndingWith-TEST EXECUTED");

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("downloadedEmployeeStartingAndEndingWithOptions");
		return (forward);

	}

	public ActionForward downloadedEmployeeHistoryOptions(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("-downloadedEmployeeHistoryOptions- ");
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("downloadedEmployeeHistoryOptions");
		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		String order = (getStrAsRequestParameter("order", request) == null) ? ("asc") : (getStrAsRequestParameter("order", request));
		String orderBy = (String) getStrAsRequestParameter("orderby", request);
		log.info(orderBy + " : " + order);
		List<Map<String, Object>> listAllMyEmployees = getSpringCtxDoTransactionBean().getAllMyEmployeesList(businessId, orderBy, order);
		if (order != null && order.equalsIgnoreCase("desc")) {
			log.info("Making ASC");
			order = "asc";
		} else {
			log.info("Making DESC");
			order = "desc";
		}
		putObjInRequest("listAllMyEmployees", request, listAllMyEmployees);
		putObjInRequest("order", request, order);
		putObjInSession("downloadedEmployeeHistoryOptions", request, "downloadedEmployeeHistoryOptions");
		// This we need to remove -- If not user will get confuse in
		// listAllEmployees.jsp file.
		removeObjFrmSession("updateEmp", request);
		removeObjFrmSession("isRequestForDownloadMonthlyHrs", request);
		removeObjFrmSession("requestForEnableDisable", request);
		return (forward);
	}

	public ActionForward downloadEmployeeStratingAndEndingWithNamesPdf(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		log.info("-downloadEmployeeStratingAndEndingWithNamesPdf-");

		DownloadedEmployeeBean bean = (DownloadedEmployeeBean) form;
		String startingWithText = (String) bean.getStartingWithText();
		log.info(startingWithText);
		String endingWithText = (String) bean.getEndingWithText();
		log.info(endingWithText);
		String startingWith = (String) bean.getLastNameListBox();
		log.info(startingWith);
		String endingWith = (String) bean.getClientWorkingForListBox();
		log.info(endingWith);
		String jrxml = adminjrxmlPath + "allEmployeesStartingWith.jrxml";

		try {
			UserProfile userProfile = getUserProfile(request);
			List<Map<String, Object>> listAllMyEmployeeStartingWith = getSpringCtxDoTransactionBean().downloadAllMyEmployeesList1(startingWith, endingWith, startingWithText, endingWithText,
					userProfile.getBusinessId());
			if (listAllMyEmployeeStartingWith.size() == 0) {
				return getStatusPage(mapping, request);
			}
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("employerName", userProfile.getEmployerName());
			processReports(listAllMyEmployeeStartingWith, response, jrxml, parameters);
		} catch (Exception e) {
			e.printStackTrace();
			return forwardToExceptionPage(mapping, request, e);
		}
		return null;
	}

	public ActionForward downloadedEmployeeHistory(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String jrxml = adminjrxmlPath + "employeeHistory.jrxml";
		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		long userId = getLongAsRequestParameter("userId", request);
		List<Map<String, Object>> listEmployeeHistory = getSpringCtxDoTransactionBean().listEmployeeHistory(userId, businessId);
		log.info("listEmployeeHistory --> " + listEmployeeHistory);
		if (listEmployeeHistory.size() == 0) {
			return getStatusPage(mapping, request);
		}

		try {
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("employeeName", getSpringCtxDoTransactionBean().getUserDisplayName(userId));
			parameters.put("employerName", userProfile.getEmployerName());
			processReports(listEmployeeHistory, response, jrxml,parameters);
		} catch (Exception e) {
			e.printStackTrace();
			return forwardToExceptionPage(mapping, request, e);
		}
		return null;
	}

	public ActionForward downloadAllEmployees(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String cancel = request.getParameter("cancel");
		if (cancel != null) {
			return mapping.findForward("downloadCancelation");
		}
		// Method Level Data
		String jrxml = adminjrxmlPath + "allEmployees.jrxml";
		String orderby_1 = getStrAsRequestParameter("orderBy_1", request);
		String orderby_2 = getStrAsRequestParameter("orderBy_2", request);
		String orderby_3 = getStrAsRequestParameter("orderBy_3", request);

		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		String order = (getStrAsRequestParameter("order", request) == null) ? ("asc") : (getStrAsRequestParameter("order", request));
		String orderBy = orderby_1 + ", " + orderby_2 + ", " + orderby_3;

		log.info(orderBy + " : " + order);

		List<Map<String, Object>> listAllMyEmployees = getSpringCtxDoTransactionBean().downloadAllEmployees(businessId, orderby_1, order, orderby_2, order, orderby_3, order);

		if (listAllMyEmployees.size() == 0) {
			return getStatusPage(mapping, request);
		}

		try {
			
			int i = 0;
			while (i < listAllMyEmployees.size()) {
				String recentHrs = "";
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
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("employerName", userProfile.getEmployerName());
			processReports(listAllMyEmployees, response, jrxml, parameters);
		} catch (Exception e) {
			e.printStackTrace();
			return forwardToExceptionPage(mapping, request, e);
		}

		return null;
	}

	public ActionForward employeessubmittedHoursWeekly(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String jrxml = adminjrxmlPath + "employeeSubmittedHoursWeekly.jrxml";

		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		List<Map<String, Object>> listEmployeesubmittedHoursWeekly = getSpringCtxDoTransactionBean().listEmployeesubmittedHoursWeekly(businessId);
		log.info("listEmployeesubmittedHoursWeekly --> " + listEmployeesubmittedHoursWeekly);

		if (listEmployeesubmittedHoursWeekly.size() == 0) {
			return getStatusPage(mapping, request);
		}

		try {
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("employerName", userProfile.getEmployerName());
			processReports(listEmployeesubmittedHoursWeekly, response, jrxml, parameters);
		}

		catch (Exception e) {
			e.printStackTrace();
			return forwardToExceptionPage(mapping, request, e);
		}
		return null;
	}

	public ActionForward searchDownloadEmployeesSubmittedHoursMonthly(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String jrxml = adminjrxmlPath + "searchEmployeeSubmittedHoursMonthly.jrxml";
		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		long userId = getLongAsRequestParameter("userId", request);
		// long userId=userProfile.getUserId();
		List<Map<String, Object>> listEmployeeDownloadMonthlyHrs = getSpringCtxDoTransactionBean().listEmployeeDownloadMonthlyHrs(userId, businessId);
		log.info("listEmployeeDownloadMonthlyHrs --> " + listEmployeeDownloadMonthlyHrs);

		if (listEmployeeDownloadMonthlyHrs.size() == 0) {
			return getStatusPage(mapping, request);
		}

		try {
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("employeeName", getSpringCtxDoTransactionBean().getUserDisplayName(userId));
			parameters.put("employerName", userProfile.getEmployerName());
			processReports(listEmployeeDownloadMonthlyHrs, response, jrxml, parameters);
		} catch (Exception e) {
			e.printStackTrace();
			return forwardToExceptionPage(mapping, request, e);
		}
		return null;
	}

	public ActionForward downloadEmployeessubmittedHoursMonthly(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String jrxml = adminjrxmlPath + "EmployeeSubmittedHoursMonthly.jrxml";

		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		List<Map<String, Object>> listEmployeesubmittedHoursMonthly = getSpringCtxDoTransactionBean().listEmployeesubmittedHoursMonthly(businessId);
		log.info("listEmployeesubmittedHoursMonthly --> " + listEmployeesubmittedHoursMonthly);

		if (listEmployeesubmittedHoursMonthly.size() == 0) {
			return getStatusPage(mapping, request);
		}
		try {
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("employerName", userProfile.getEmployerName());
			processReports(listEmployeesubmittedHoursMonthly, response, jrxml, parameters);
		}

		catch (Exception e) {
			e.printStackTrace();
			return forwardToExceptionPage(mapping, request, e);
		}

		return null;
	}

	/*
	 * public ActionForward
	 * searchAndDloadedEmployeeSubmittedHrsMonthylyOptions(ActionMapping
	 * mapping, ActionForm form, HttpServletRequest request, HttpServletResponse
	 * response) throws Exception {
	 * log.info("-downloadedEmployeeHistoryOptions-TEST EXECUTED");
	 * (mapping,request,response); ActionForward forward = new ActionForward();
	 * forward =
	 * mapping.findForward("searchAndDloadedEmployeeSubmittedHrsMonthylyOptions"
	 * ); UserProfile userProfile = getUserProfile(request); long businessId =
	 * userProfile.getBusinessId(); String order =
	 * (getStrAsRequestParameter("order",
	 * request)==null)?("asc"):(getStrAsRequestParameter("order", request));
	 * String orderBy=(String)getStrAsRequestParameter("orderby", request);
	 * log.info(orderBy +" : "+order); List<ListOrderedMap> listAllMyEmployees =
	 * getSpringCtxDoTransactionBean
	 * ().getAllMyEmployeesList(businessId,orderBy,order);
	 * if(order!=null&&order.equalsIgnoreCase("desc")) { log.info("Making ASC");
	 * order = "asc"; } else { log.info("Making DESC"); order="desc"; }
	 * putObjInRequest("listAllMyEmployees", request, listAllMyEmployees);
	 * putObjInRequest("order", request, order);
	 * putObjInSession("searchAndDloadedEmployeeSubmittedHrsMonthylyOptions",
	 * request, "searchAndDloadedEmployeeSubmittedHrsMonthylyOptions"); //This
	 * we need to remove -- If not user will get confuse in listAllEmployees.jsp
	 * file. removeObjFrmSession("updateEmp", request); return (forward); }
	 */

}
