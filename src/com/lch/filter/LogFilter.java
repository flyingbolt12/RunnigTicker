package com.lch.filter;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.generalBeans.UserProfile;

public class LogFilter implements Filter {

	private FilterConfig config;

	private final static String SIGNOUTACTION_PATH = "/signoutAction.do";
	private static Logger log = LoggerFactory.getLogger(LogFilter.class);
	public static ArrayList<String> actionsToIgnore = new ArrayList<String>();
	static {
		actionsToIgnore.add("login.do");
		actionsToIgnore.add("footerFunct.do");
		actionsToIgnore.add("forgotPassword.do");
		actionsToIgnore.add("adminRegistration.do");
		actionsToIgnore.add("employeeRegistration.do");
		actionsToIgnore.add("confirmRegistration.do");
		actionsToIgnore.add("confirmMemberRegistration.do");
		actionsToIgnore.add("validateBusinessEmail.do");
		actionsToIgnore.add("validateUserEmail.do");
		actionsToIgnore.add("approveUserByAdmin.do");
		actionsToIgnore.add("adminEmailApproval.do");
		actionsToIgnore.add("createTestAdmin.do");
		actionsToIgnore.add("createTestMembers.do");
		actionsToIgnore.add("contactUs.jsp");
		actionsToIgnore.add("aboutUs.jsp");
		actionsToIgnore.add("demo.jsp");
		actionsToIgnore.add("membersDemo.jsp");
		actionsToIgnore.add("adminRegistration.jsp");
		actionsToIgnore.add("employeeRegistration.jsp");
		actionsToIgnore.add("adminAndroidLogin.do");
		actionsToIgnore.add("adminAndroidPendingApprovals.do");
		actionsToIgnore.add("confirmDetails.do");
		actionsToIgnore.add("adminAndroidLogin.do");
		
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		this.config = config;
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
			ServletException {

		HttpSession session = ((HttpServletRequest) request).getSession();
		String url = ((HttpServletRequest) request).getRequestURL().toString();
		String queryString = ((HttpServletRequest) request).getQueryString();
		ServletContext context = config.getServletContext();
		boolean isToFilter = Boolean.FALSE;
		// log.info("Checking the Sign in of User...");
		
			UserProfile userProfile = (UserProfile) session.getAttribute("userProfile");
			if (userProfile == null) {
				for (String action : actionsToIgnore) {
					if (url.endsWith(action) || url.indexOf(action)!=-1 || (queryString!=null && queryString.indexOf(action)!= -1)) {
						isToFilter = Boolean.TRUE;
						break;
					}
				}
				if (isToFilter) {
					chain.doFilter(request, response);
				} else {
					context.getRequestDispatcher(SIGNOUTACTION_PATH).forward(request, response);
				}
			} else {
				chain.doFilter(request, response);
			}
	}

	@Override
	public void destroy() {

		log.info("Destroying the Filter");

	}
}
