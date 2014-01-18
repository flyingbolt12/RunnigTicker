package com.lch.struts.actions.members;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.generalBeans.UserProfile;
import com.lch.struts.actions.BaseAction;

public abstract class ReportsBase extends BaseAction {

	private static Logger log = LoggerFactory.getLogger(ReportsBase.class);
	protected static String seperator = null;
	protected static String memberjrxmlPath = null;
	protected static String adminjrxmlPath = null;

	public ReportsBase() {
		seperator = System.getProperty("file.separator");
		memberjrxmlPath = getApplicationPath().substring(0, getApplicationPath().length() - 1) + "WEB-INF" + seperator
				+ "jrxml" + seperator + "member"+seperator+"allTimeSheets.jrxml";
		
		adminjrxmlPath = getApplicationPath().substring(0, getApplicationPath().length() - 1) + "WEB-INF" + seperator + "jrxml" + seperator + "admin" +seperator;
	}

	public void processReports(List<?> list, HttpServletResponse response, String jrxmlPath) throws Exception {
		
		log.info("Using JRXML {} {}", jrxmlPath, list.size());
		
		JasperReport jasperReport = null;
		JasperPrint jasperPrint = null;
		JRBeanCollectionDataSource ds = null;

		ServletOutputStream out1 = null;

		ds = new JRBeanCollectionDataSource(list);
		jasperReport = JasperCompileManager.compileReport(jrxmlPath);
		jasperPrint = JasperFillManager.fillReport(jasperReport, new HashMap<String, Object>(), ds);

		response.setContentType("application/pdf");
		response.setHeader("Content-disposition", "inline;filename=MyActive Employees.pdf");
		response.setHeader("Cache-Control", "cache");
		response.addHeader("Cache-Control", "must-revalidate");
		response.setHeader("Pragma", "public");
		out1 = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint, out1);
		log.info("after jasperexportmanager-pdf downloaded");
		jasperPrint = null;
		jasperReport = null;
		ds = null;
		out1 = null;
		
	}
	public ActionForward downloadEmpTimeSheets(
			ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		log.info("-downloadEmployeeTimeSheetStatusPdf-");
		ActionForward forward = new ActionForward();
		long userId = -1;
		UserProfile userProfile = getUserProfile(request);
		
		// For sake of admins
		userId = getLongAsRequestParameter("userId", request);
		
		// for sake of members
		if(userId <= 0)
			userId = userProfile.getUserId();
		
		List<Map<String, Object>> employeeTimesheets = getSpringCtxDoTransactionBean().listEmployeeTimesheets(
				userId);
		
		if(employeeTimesheets.size() == 0)
		{
			return getStatusPage(mapping, request);
		}
		
		try {
			processReports(employeeTimesheets, response, memberjrxmlPath);
		} catch (JRException e) {
			e.printStackTrace();
			forward = mapping.findForward("exception");
			return forward;
		} catch (Exception e) {
			e.printStackTrace();
			forward = mapping.findForward("exception");
		}

		return null;
	}
	
	protected ActionForward getStatusPage(ActionMapping mapping, HttpServletRequest request)
	{
		ActionForward forward = new ActionForward();
		putObjInRequest("status", request, "No Data Found to generate this report");
		forward = mapping.findForward("status");
		return forward;
	}
	
}
