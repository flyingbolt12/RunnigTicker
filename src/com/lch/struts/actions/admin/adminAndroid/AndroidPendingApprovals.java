package com.lch.struts.actions.admin.adminAndroid;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.struts.actions.BaseAction;
import com.lch.struts.actions.LoginAction;

public class AndroidPendingApprovals extends BaseAction {
	private static final Logger log = LoggerFactory
			.getLogger(LoginAction.class);

	public ActionForward timeSheetPendingApprovals(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();

		List<Map> employeeTimesheetPendingApprovals = getSpringCtxDoTransactionBean()
				.listEmployeeTimesheetPendingApprovals(getUserProfile(request));
		putObjInRequest("employeeTimesheetPendingApprovals", request,
				employeeTimesheetPendingApprovals);
		forward = mapping.findForward("mTimeSheetPendingApprovalsPage");

		return forward;

	}

	public ActionForward registrationPendingApprovals(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();

		List<ListOrderedMap> employeeRegistrationPendingApprovals = getSpringCtxDoTransactionBean()
				.listEmployeeRegistrationPendingApprovals(getUserProfile(request));
		putObjInRequest("employeeRegistrationPendingApprovals", request,
				employeeRegistrationPendingApprovals);
		forward = mapping.findForward("mRegistrationPendingApprovalsPage");

		return forward;

	}
}
