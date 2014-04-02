package com.lch.struts.actions.admin.adminAndroid;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.generalBeans.UserProfile;
import com.lch.spring.BusinessComponents.LoginCheck;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.actions.LoginAction;
import com.lch.struts.formBeans.Login;

public class AdminAndroidLogin extends BaseAction{
	private static final Logger log = LoggerFactory.getLogger(LoginAction.class);
	String user,password;

	public ActionForward execute(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		ActionErrors errors = new ActionErrors();
	
		user = request.getParameter("username");
		password = request.getParameter("password");

		System.out.println("Request from Android" + user + " : " + password);
		Login login = new Login();
		getApplicationPath();
		getApplicationPathToOneUP();

		
		login.setUserName(user);
		login.setPassword(password);
		System.out.println(login.getPassword());
		
		try {
			LoginCheck loginCheck = (LoginCheck) getSpringCTX().getBean("loginCheck");
			UserProfile userProfile = loginCheck.isLogin(login);
			HttpSession session = request.getSession();
			session.setAttribute("userProfile", userProfile);
		
			if (userProfile.isLoginStatus()) {
				if (userProfile.isAdmin()) {
					System.out.println("Admin logged in");
					forward = mapping.findForward("androidPage");
					session.setAttribute("loginStatus", "Success");
//					List<ListOrderedMap> employeeRegistrationPendingApprovals = getSpringCtxDoTransactionBean().listEmployeeRegistrationPendingApprovals(userProfile);
	//				List<Map> employeeTimesheetPendingApprovals = getSpringCtxDoTransactionBean().listEmployeeTimesheetPendingApprovals(getUserProfile(request));
//
//					if (!employeeRegistrationPendingApprovals.isEmpty()) {
//						log.info("forwarding to pending approvals sheet");
//						putObjInRequest("employeeRegistrationPendingApprovals", request, employeeRegistrationPendingApprovals);
//						forward = mapping.findForward("employeeRegistrationPendingApprovals");
//					} else if (!employeeTimesheetPendingApprovals.isEmpty()) {
//						putObjInRequest("employeeTimesheetPendingApprovals",request, employeeTimesheetPendingApprovals);
//						forward = mapping.findForward("employeeTimesheetPendingApprovals");
//					} else {
//						forward = mapping.findForward("adminFunctions");
//					}
				} else {
					

				}
			} else {
				log.info("Login Failed {}", userProfile.getLoginFailReason());
				session.setAttribute("loginStatus", "Failure");
				errors.add("loginFail", new ActionMessage(userProfile.getLoginFailReason()));
				forward = mapping.findForward("androidPage");
			}

		} catch (Exception e) {
			e.printStackTrace();
			errors.add("name", new ActionMessage("id"));
		}

		if (!errors.isEmpty()) {
			saveErrors(request, errors);
		}
		
		return forward;
	}

}
