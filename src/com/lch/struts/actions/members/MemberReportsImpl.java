package com.lch.struts.actions.members;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.generalBeans.UserProfile;

public class MemberReportsImpl extends ReportsBase {

	private static Logger log = LoggerFactory
			.getLogger(MemberReportsImpl.class);

	public ActionForward downloadEmpPndgTimeSheets(
			ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		log.info("-downloadEmployeeTimeSheetStatusPdf-");
		ActionForward forward = new ActionForward();

		UserProfile userProfile = getUserProfile(request);
		List<?> list = getSpringCtxDoTransactionBean().listEmployeePendingTimesheets(
				userProfile);
		if(list.size() == 0)
		{
			return getStatusPage(mapping, request);
		}
		try {
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("employerName", userProfile.getEmployerName());
			processReports(list, response, memberjrxmlPath, parameters);
		} catch (JRException e) {
			log.error(e.getMessage(), e);
			return forwardToExceptionPage(mapping, request, e);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return forwardToExceptionPage(mapping, request, e);
		}

		return null;
	}
	public ActionForward downloadEmpRjctedTimeSheets(
			ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		log.info("-downloadEmployeeTimeSheetStatusPdf-");
		ActionForward forward = new ActionForward();

		UserProfile userProfile = getUserProfile(request);
		List<?> list = getSpringCtxDoTransactionBean().listEmployeeRejectTimesheets(
				userProfile);
		
		if(list.size() == 0)
		{
			return getStatusPage(mapping, request);
		}
		try {
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("employerName", userProfile.getEmployerName());
			processReports(list, response, memberjrxmlPath, parameters);
		} catch (JRException e) {
			log.error(e.getMessage(), e);
			return forwardToExceptionPage(mapping, request, e);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return forwardToExceptionPage(mapping, request, e);
		}

		return null;
	}
	
	public ActionForward downloadEmpApprovedTimeSheets(
			ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		log.info("-downloadEmployeeTimeSheetStatusPdf-");
		ActionForward forward = new ActionForward();

		UserProfile userProfile = getUserProfile(request);
		List<?> list = getSpringCtxDoTransactionBean().listEmployeeApprovedTimesheets(
				userProfile);
		
		if(list.size() == 0)
		{
			return getStatusPage(mapping, request);
		}
		try {
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("employerName", userProfile.getEmployerName());
			processReports(list, response, memberjrxmlPath, parameters);
		} catch (JRException e) {
			log.error(e.getMessage(), e);
			return forwardToExceptionPage(mapping, request, e);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return forwardToExceptionPage(mapping, request, e);
		}

		return null;
	}
}
