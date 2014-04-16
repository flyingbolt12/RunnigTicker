package com.lch.struts.actions;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.constants.GeneralConstants;
import com.lch.general.enums.TimeSheetTypes;
import com.lch.general.generalBeans.UserProfile;
import com.lch.general.genericUtils.DateUtils;
import com.lch.spring.BusinessComponents.LoginCheck;
import com.lch.struts.formBeans.Login;

/**
 * @version 1.0
 * @author
 */
@SuppressWarnings({ "rawtypes", "unchecked" })
public class LoginAction extends BaseAction

{
	private static final Logger log = LoggerFactory.getLogger(LoginAction.class);

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionErrors errors = new ActionErrors();
		ActionForward forward = new ActionForward();
		Login login = (Login) form;
		// This sets the app path
		getApplicationPath();
		getApplicationPathToOneUP();
		try {
			LoginCheck loginCheck = (LoginCheck) getSpringCTX().getBean("loginCheck");
			UserProfile userProfile = loginCheck.isLogin(login);
			HttpSession session = request.getSession();
			session.setAttribute("userProfile", userProfile);
			// ADMINS OR CHILDADMINS
			if (userProfile.isLoginStatus()) {
				if (userProfile.isSuperAdmin()) {
					forward = mapping.findForward("superAdminFunctions");
				} else if (userProfile.isAdmin() || userProfile.isChildAdmin()) {
					Calendar cal = Calendar.getInstance();
					int year = cal.get(1);
					int month = cal.get(2);
					log.info("Year : " + year + " Month : " + month);
					DateUtils du = new DateUtils(year, month);
					userProfile.setDu(du);
					
					forward = mapping.findForward("employeeRegistrationPendingApprovals");
					List<ListOrderedMap> employeeRegistrationPendingApprovals = getSpringCtxDoTransactionBean().listEmployeeRegistrationPendingApprovals(userProfile);
					List<Map> employeeTimesheetPendingApprovals = getSpringCtxDoTransactionBean().listEmployeeTimesheetPendingApprovals(getUserProfile(request));

					if (!employeeRegistrationPendingApprovals.isEmpty()) {
						log.info("forwarding to pending approvals sheet");
						putObjInRequest("employeeRegistrationPendingApprovals", request, employeeRegistrationPendingApprovals);
						forward = mapping.findForward("employeeRegistrationPendingApprovals");
					} else if (!employeeTimesheetPendingApprovals.isEmpty()) {
						putObjInRequest("employeeTimesheetPendingApprovals", request, employeeTimesheetPendingApprovals);
						forward = mapping.findForward("employeeTimesheetPendingApprovals");
					} else {
						forward = mapping.findForward("adminFunctions");
					}
					// MEMBERS OR EMPLOYEES
				} else {
					Calendar cal = Calendar.getInstance();
					int year = cal.get(1);
					int month = cal.get(2);
					log.info("Year : " + year + " Month : " + month);
					DateUtils du = new DateUtils(year, month);
					userProfile.setDu(du);

					if (userProfile.getApprovalStatus()==2 || userProfile.getApprovalStatus()==3 )
						return mapping.findForward("memberFunctions");
					
					if (userProfile.getTimeSheetConfiguredTo().equals(TimeSheetTypes.DAYS15.name())) {

						forward = days15(request, forward, mapping);

					} else if (userProfile.getTimeSheetConfiguredTo().equals(TimeSheetTypes.MONTHLY.name())) {

						forward = monthly(userProfile, request, forward, mapping);

					} else if (userProfile.getTimeSheetConfiguredTo().equals(TimeSheetTypes.WEEKLY.name())) {

						forward = weekly(userProfile, request, forward, mapping);

					} else if (userProfile.getTimeSheetConfiguredTo().equals(TimeSheetTypes.BIWEEKLY.name())) {

						forward = biWeekly(userProfile, request, forward, mapping);

					} else {
						mapping.findForward("memberFunctions");
					}

				}
			} else {
				log.info("Login Failed {}", userProfile.getLoginFailReason());
				errors.add("loginFail", new ActionMessage(userProfile.getLoginFailReason()));
				forward = mapping.findForward("failure");
			}

		} catch (Exception e) {
			e.printStackTrace();
			errors.add("name", new ActionMessage("id"));
		}

		if (!errors.isEmpty()) {
			saveErrors(request, errors);
		}

		return (forward);

	}

	private ActionForward weekly(UserProfile userProfile, HttpServletRequest request, ActionForward forward, ActionMapping mapping) {

		List l = getSpringCtxDoTransactionBean().listSubmittedHrs(userProfile, TimeSheetTypes.WEEKLY);

		if (l.size() > 0) {
			forward = mapping.findForward("memberFunctions");
		} else {

			if (userProfile.getClientId() != 0) {

				getSpringCtxDoTransactionBean().updateRequiredDetails(userProfile);
				forward = mapping.findForward(GeneralConstants.WEEKLY);
			} else {
				if (userProfile.getClientId() == 0) {
					forward = mapping.findForward("memberFunctions");
				}
			}
		}

		return forward;

	}

	private ActionForward biWeekly(UserProfile userProfile, HttpServletRequest request, ActionForward forward, ActionMapping mapping) {

		List l = getSpringCtxDoTransactionBean().listSubmittedHrs(userProfile, TimeSheetTypes.BIWEEKLY);

		if (l.size() > 0) {
			forward = mapping.findForward("memberFunctions");
		} else {

			if (userProfile.getClientId() != 0) {
				getSpringCtxDoTransactionBean().updateRequiredDetails(userProfile);
				forward = mapping.findForward(GeneralConstants.BIWEEKLY);
			} else {
				if (userProfile.getClientId() == 0) {
					forward = mapping.findForward("memberFunctions");
				}
			}
		}

		return forward;

	}

	private ActionForward monthly(UserProfile userProfile, HttpServletRequest request, ActionForward forward, ActionMapping mapping) {

		List l = getSpringCtxDoTransactionBean().listSubmittedHrs(userProfile, TimeSheetTypes.MONTHLY);

		if (l.size() > 0) {
			forward = mapping.findForward("memberFunctions");
		} else {

			if (userProfile.getClientId() != 0) {

				getSpringCtxDoTransactionBean().updateRequiredDetails(userProfile);
				forward = mapping.findForward(GeneralConstants.MONTHLY);
			} else {
				if (userProfile.getClientId() == 0) {
					forward = mapping.findForward("memberFunctions");
				}
			}
		}

		return forward;
	}

	private ActionForward days15(HttpServletRequest request, ActionForward forward, ActionMapping mapping) {

		List l = getSpringCtxDoTransactionBean().listSubmittedHrs(getUserProfile(request), TimeSheetTypes.DAYS15);
		int nAvailableRows = l.size();
		boolean bSubmit = true;

		// No Submissions made yet
		if (l.size() == 0) {
			if (Calendar.getInstance().get(Calendar.DAY_OF_MONTH) <= 15)
				forward = mapping.findForward(GeneralConstants.FIRST_15_DAYS_OF_MONTH);
			else
				forward = mapping.findForward(GeneralConstants.SECOND_15_DAYS_OF_MONTH);

		}
		// Having submitted for two times in a month
		else if (l.size() == 2) {
			forward = mapping.findForward("memberFunctions");
		} else if (nAvailableRows == 1) {
			Map<String, Object> m = (Map<String, Object>) l.get(0);
			String status = (String) m.get("status");
			String submissionType = (String) m.get("submissionFor");

			if (status != null && submissionType != null) {
				if (status.equalsIgnoreCase("PENDING") || status.equalsIgnoreCase("APPROVED")) {
					bSubmit = true;

					if (submissionType.equalsIgnoreCase("FIRST")) {
						forward = mapping.findForward(GeneralConstants.SECOND_15_DAYS_OF_MONTH);
					} else {
						forward = mapping.findForward(GeneralConstants.FIRST_15_DAYS_OF_MONTH);
					}
				} else if (status.equalsIgnoreCase("REJECTED")) {
					bSubmit = false;
					if (submissionType.equalsIgnoreCase("FIRST")) {
						forward = mapping.findForward(GeneralConstants.FIRST_15_DAYS_OF_MONTH);
					} else {
						forward = mapping.findForward(GeneralConstants.SECOND_15_DAYS_OF_MONTH);
					}
				}
				if (!bSubmit)
					putObjInRequest("isTimsheetEdit", request, "TRUE");
			}
		} else {
			forward = mapping.findForward("memberFunctions");
		}
		return forward;
	}
}