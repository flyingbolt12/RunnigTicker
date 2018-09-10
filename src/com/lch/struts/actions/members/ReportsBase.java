package com.lch.struts.actions.members;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.DefaultJasperReportsContext;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRPropertiesUtil;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.commons.lang3.StringUtils;
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
		memberjrxmlPath = getApplicationPath().substring(0, getApplicationPath().length() - 1) + "WEB-INF" + seperator + "jrxml"
				+ seperator + "member" + seperator + "allTimeSheets.jrxml";

		adminjrxmlPath = getApplicationPath().substring(0, getApplicationPath().length() - 1) + "WEB-INF" + seperator + "jrxml"
				+ seperator + "admin" + seperator;
	}

	public void processReports(List<?> list, HttpServletResponse response, String jrxmlPath, Map parameters) throws Exception {

		log.info("Using JRXML {} {}", jrxmlPath, list.size());

		if (parameters == null) {
			parameters = new HashMap<String, Object>();
		}
		JasperReport jasperReport = null;
		JasperPrint jasperPrint = null;
		JRBeanCollectionDataSource ds = null;

		ServletOutputStream out1 = null;
		DefaultJasperReportsContext context = DefaultJasperReportsContext.getInstance();
		JRPropertiesUtil.getInstance(context).setProperty("net.sf.jasperreports.awt.ignore.missing.font", "true");
		ds = new JRBeanCollectionDataSource(list);
		jasperReport = JasperCompileManager.compileReport(jrxmlPath);
		jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, ds);

		response.setContentType("application/pdf");
		response.setHeader("Content-disposition", "inline;filename=Reports.pdf");
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

	public ActionForward downloadEmpTimeSheets(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		log.info("-downloadEmployeeTimeSheetStatusPdf-");
		ActionForward forward = new ActionForward();
		long userId = -1;
		UserProfile userProfile = getUserProfile(request);

		// For sake of admins
		userId = getLongAsRequestParameter("userId", request);

		// for sake of members
		if (userId <= 0)
			userId = userProfile.getUserId();

		List<Map<String, Object>> employeeTimesheets = getSpringCtxDoTransactionBean().listEmployeeTimesheets(userId);
		if (employeeTimesheets.size() == 0) {
			return getStatusPage(mapping, request);
		}
		
		String allKeys = "";
		// read all records and retrieve all ids
		for (Map<String, Object> map : employeeTimesheets) {
			allKeys = allKeys + map.get("supportingDocIds") + ",";
		}
		if (allKeys.lastIndexOf(",") != -1) {
			allKeys = allKeys.substring(0, allKeys.lastIndexOf(","));
			log.info(allKeys);

			// query
			Map<String, Map<String, Object>> idMap = new HashMap<String, Map<String, Object>>();
			List<Map<String, Object>> allpaths = getSpringCtxDoTransactionBean().listFilePaths(allKeys);

			for (Map<String, Object> k : allpaths) {
				k.get("idattacheddocs");
				idMap.put(k.get("idattacheddocs") + "", k);
			}

			// now attach them
			for (Map<String, Object> map : employeeTimesheets) {
				String key = (String) map.get("supportingDocIds");
				List<String> allDocs = new ArrayList<String>();
				String missingAttachments = null;
				if (key.contains(",")) {
					String[] keys = key.split(",");
					for (String k : keys) {
						if (k != null && idMap.get(k) != null && (String) (idMap.get(k).get("docAPath")) != null) {
							String path = ((String) idMap.get(k).get("docAPath"));
							if (StringUtils.endsWithIgnoreCase(path, "JPEG") || StringUtils.endsWithIgnoreCase(path, "jpg")
									|| StringUtils.endsWithIgnoreCase(path, "gif") || StringUtils.endsWithIgnoreCase(path, "PNG")) {
								allDocs.add((String) idMap.get(k).get("docAPath"));
							} else {
								missingAttachments = "Few attachments related to this timesheet were unable to show inside this pdf.";
							}
						}
					}
				}
				map.put("allDocs", allDocs);
				map.put("missingAttachments", missingAttachments);
			}
		}
		

		try {
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("employeeName", getSpringCtxDoTransactionBean().getUserDisplayName(userId));
			parameters.put("employerName", userProfile.getEmployerName());
			processReports(employeeTimesheets, response, memberjrxmlPath, parameters);
		} catch (JRException e) {
			log.error(e.getMessage(), e);
			return forwardToExceptionPage(mapping, request, e);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return forwardToExceptionPage(mapping, request, e);
		}

		return null;
	}

	protected ActionForward forwardToExceptionPage(ActionMapping mapping, HttpServletRequest request, Throwable e) {
		e.printStackTrace();
		// generalAJAXMsg
		String HTML = "<B> An error occured </b>. Please contact Support. </b> <br>Error Message : " + e.getMessage();
		putAjaxStatusObjInRequest(request, HTML);
		return mapping.findForward("/exception");
	}

	protected ActionForward getStatusPage(ActionMapping mapping, HttpServletRequest request) {
		ActionForward forward = new ActionForward();
		putObjInRequest("status", request, "No Data Found to generate this report");
		forward = mapping.findForward("status");
		return forward;
	}

}
