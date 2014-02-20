/*
 * Created on Feb 23, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.lch.struts.actions;

import java.io.File;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.actions.DispatchAction;
import org.apache.velocity.app.VelocityEngine;
import org.quartz.Scheduler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.lch.general.constants.VMConstants;
import com.lch.general.email.EmailConstants;
import com.lch.general.email.EmailDetails;
import com.lch.general.email.EmailUtil;
import com.lch.general.generalBeans.ProfileBean;
import com.lch.general.generalBeans.UserProfile;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.general.genericUtils.BuildExceptionTrace;
import com.lch.spring.SQLQueries;
import com.lch.spring.BusinessComponents.DoTransaction;

/**
 * @author Gopi
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class BaseAction extends DispatchAction implements SQLQueries {
	final static String SIGNOUTACTION_PATH = "/signoutAction.do";
	private static Logger log = LoggerFactory.getLogger(BaseAction.class);
	protected GenericXmlApplicationContext _ctx = null;
	private static String appPath = null;
	private static String appPathOneUp = null;
	protected String url ="";
	public enum LOGTYPE{
		EMAIL
	}

	public JdbcTemplate getJDBCTemplate() {
		return (JdbcTemplate) (getSpringCTX().getBean("jdbcTemplate"));
	}

	public GenericXmlApplicationContext getSpringCTX() {
		GenericXmlApplicationContext ctx;
		try {
			ctx = (GenericXmlApplicationContext) getServlet().getServletContext().getAttribute("ctx");
		} catch (Exception e) {
			ctx = _ctx;
		}

		return ctx;
	}

	public ProfileBean getProfileBean() {
		return (ProfileBean) (getSpringCTX().getBean("profileBean"));
	}

	public HttpSession getSession(HttpServletRequest request) {
		if (request != null) {
			HttpSession session = request.getSession(false);
			if (session != null)
				return session;
			else
				return request.getSession();
		} else {
			log.error("There is no Request Object Available to get the Session");
			return null;
		}
	}

	public void putObjInSession(String objName, HttpServletRequest request, Object obj) {
		getSession(request).setAttribute(objName, obj);
	}

	public Object getObjFrmSession(String objName, HttpServletRequest request) {
		return getSession(request).getAttribute(objName);
	}

	public void putObjInRequest(String objName, HttpServletRequest request, Object obj) {
		request.setAttribute(objName, obj);
	}

	public void putAjaxStatusObjInRequest(HttpServletRequest request, Object obj) {
		request.setAttribute("generalAJAXMsg", obj);
	}

	public void putStatusObjInRequest(HttpServletRequest request, Object obj) {
		request.setAttribute("status", obj);
	}

	public void putObj4generalAJAXMsg(HttpServletRequest request, Object obj) {
		request.setAttribute("generalAJAXMsg", obj);
	}

	public void removeObjFrmSession(String objName, HttpServletRequest request) {
		getSession(request).removeAttribute(objName);
	}

	public Object getObjFrmRequest(String objName, HttpServletRequest request) {
		return request.getAttribute(objName);
	}

	public String getStrAsRequestParameter(String objName, HttpServletRequest request) {
		return request.getParameter(objName);
	}

	public int getIntAsRequestParameter(String objName, HttpServletRequest request) throws NumberFormatException {
		try {
			return Integer.parseInt(request.getParameter(objName));
		} catch (NumberFormatException e) {
			return 0;
		}
	}
	public Date getSQLDateAsRequestParameter(String objName, HttpServletRequest request) {
		try {
			return Date.valueOf(request.getParameter(objName));
		} catch (Exception e) {
			return null;
		}
	}
	public long getLongAsRequestParameter(String objName, HttpServletRequest request) {
		try {
			return Long.parseLong(request.getParameter(objName));
		} catch (NumberFormatException e) {
			return 0;
		} catch (NullPointerException e) {
			return 0;
		}
	}
	public double getDoubleAsRequestParameter(String objName, HttpServletRequest request) {
		try {
			return Double.parseDouble(request.getParameter(objName));
		} catch (NumberFormatException e) {
			return 0d;
		} catch (NullPointerException e) {
			return 0d;
		}
	}

	public UserProfile getUserProfile(HttpServletRequest request) {
		UserProfile userProfile = (UserProfile) getSession(request).getAttribute("userProfile");
		if (userProfile != null) {
			return userProfile;
		} else {
			log.warn("UserProfileNotFound - creating a new one.");
			return new UserProfile();
		}
	}

	/*
	 * public void isSignedIn(HttpServletRequest request, HttpServletResponse
	 * response) throws Exception { HttpSession session = request.getSession();
	 * // log.info("Checking the Sign in of User..."); if (session != null) {
	 * UserProfile userProfile = (UserProfile) session
	 * .getAttribute("userProfile"); if (userProfile == null) {
	 * log.warn("User Session might Expired...");
	 * getServlet().getServletContext()
	 * .getRequestDispatcher(SIGNOUTACTION_PATH) .forward(request, response); }
	 * // log.info("User Logged in and Session Not expired."); } else {
	 * log.warn("User Session might Expired...");
	 * getServlet().getServletContext()
	 * .getRequestDispatcher(SIGNOUTACTION_PATH) .forward(request, response); }
	 * }
	 */

	protected HashMap<String, Object> getEmailMap(String subject, Object to, Object cc, Object bcc, String emailBody, String replyTo, String from) {
		HashMap<String, Object> myMap = new HashMap<String, Object>();

		if (subject != null)
			myMap.put("subject", subject);
		else
			myMap.put(subject, "From ILCH");

		myMap.put(EmailConstants.TO, to);
		myMap.put(EmailConstants.BCC, bcc);
		myMap.put(EmailConstants.CC, cc);
		myMap.put(EmailConstants.REPLYTO, replyTo);
		myMap.put(EmailConstants.FROM, from);
		myMap.put(EmailConstants.EMAILBODY, emailBody);

		return myMap;
	}

	protected HashMap<String, Object> getEmailMap(String subject, Object to, Object cc, Object bcc, String emailBody, String replyTo, String from, File attachment) {
		HashMap<String, Object> myMap = new HashMap<String, Object>();

		if (subject != null)
			myMap.put("subject", subject);
		else
			myMap.put(subject, "From ILCH");

		myMap.put(EmailConstants.TO, to);
		myMap.put(EmailConstants.BCC, bcc);
		myMap.put(EmailConstants.CC, cc);
		myMap.put(EmailConstants.REPLYTO, replyTo);
		myMap.put(EmailConstants.FROM, from);
		myMap.put(EmailConstants.EMAILBODY, emailBody);
		myMap.put(EmailConstants.ATTACHMENT, attachment);

		return myMap;
	}

	/*
	 * public static HashMap<String, Object> constructEmailMap(Object to, Object
	 * cc, Object bcc, String subject, String emailBody, String replyTo) {
	 * HashMap<String, Object> map = new HashMap<String, Object>();
	 * 
	 * map.put(EmailConstants.TO, to); map.put(EmailConstants.CC, cc);
	 * map.put(EmailConstants.BCC, bcc); map.put(EmailConstants.SUBJECT,
	 * subject); map.put(EmailConstants.EMAILBODY, emailBody);
	 * map.put(EmailConstants.REPLYTO, replyTo); return map; }
	 */

	public void sendEmail(String toEmail, String ccEmail, String subject, String content) {
		
		ArrayList<String> to = new ArrayList<String>();
		to.add(toEmail);
		ArrayList<String> cc = new ArrayList<String>();
		cc.add(ccEmail);
		EmailDetails emailDetails = new EmailDetails();
		if(!ccEmail.equals(""))
			emailDetails.setCc(cc);
		emailDetails.setTo(to);
		emailDetails.setSubject("Requet to upload your profile");
		StringBuffer emailContent = new StringBuffer("Your Employer sent a requet to upload your profile in their ILCH system. Please login and upload the profile.");
		emailDetails.setEmailContent(emailContent);
		sendEmail(emailDetails);
	}

	
	
	private void logEmail(EmailDetails emailDetails)
	{
		StringBuffer buffer = new StringBuffer("From : ").append(emailDetails.getFrom()).append(" Subject :").append(emailDetails.getSubject());
		getSpringCtxDoTransactionBean().insertLog(buffer.toString(),LOGTYPE.EMAIL.name());
		
		// Set News
		List<String> news = getSpringCtxDoTransactionBean().listNews();
		if(getServlet()!=null)
		getServlet().getServletConfig().getServletContext().setAttribute("news", news);
	}

	
	public void sendEmail(EmailDetails emailDetails) {
		logEmail(emailDetails);
		// String emailBody = getEmailBody(bean, VM_SEND_EMAIL_NOTIFICATION);
		HashMap<String, Object> myMap = null;
		try {
			if (emailDetails.getAttachment() == null) {
				myMap = getEmailMap(emailDetails.getSubject(), emailDetails.getTo(), emailDetails.getCc(), emailDetails.getBcc(), emailDetails.getEmailContent().toString(), emailDetails.getFrom(),
						emailDetails.getFrom());
			}
			else {
				myMap = getEmailMap(emailDetails.getSubject(), emailDetails.getTo(), emailDetails.getCc(), emailDetails.getBcc(), emailDetails.getEmailContent().toString(), emailDetails.getFrom(),
						emailDetails.getFrom(), emailDetails.getAttachment());
			}
			if (myMap != null)
				getSpringCtxEmailBean().sendEmailWithMultipleRecipants(myMap);
			else
				log.error("Unable to Send Email as email Details were null");
		} catch (Exception e) {
			e.printStackTrace();
			getSpringCtxDoTransactionBean().saveExceptionTrace(BuildExceptionTrace.buildAndGiveExceptionTrace(e));
		}
	}

	public void sendEmail(EmailDetails emailDetails, EmailUtil u) {
		logEmail(emailDetails);
		// String emailBody = getEmailBody(bean, VM_SEND_EMAIL_NOTIFICATION);
		try {
			HashMap<String, Object> myMap = getEmailMap(emailDetails.getSubject(), emailDetails.getTo(), emailDetails.getCc(), emailDetails.getBcc(), emailDetails.getEmailContent().toString(),
					emailDetails.getFrom(), emailDetails.getFrom());
			u.sendEmailWithMultipleRecipants(myMap);
		} catch (Exception e) {
			e.printStackTrace();
			getSpringCtxDoTransactionBean().saveExceptionTrace(BuildExceptionTrace.buildAndGiveExceptionTrace(e));
		}
	}

	public void describeInstance(Object object) {
		// DescribeInstance.describeInstance(object);
	}

	public DoTransaction getSpringCtxDoTransactionBean() {
		DoTransaction doTransaction = (DoTransaction) getSpringCTX().getBean("doTransaction");
		return doTransaction;
	}

	public Scheduler getSpringCtxQuartzScheduler() {
		Scheduler schedulerFactoryBean = (Scheduler) getSpringCTX().getBean("ilchScheduler");
		return schedulerFactoryBean;
	}

	public EmailUtil getSpringCtxEmailBean() {
		EmailUtil sendMail = (EmailUtil) getSpringCTX().getBean("sendEmail");
		return sendMail;
	}

	public String getEmployerName(long businessId) {
		String employerName = "";
		employerName = getSpringCtxDoTransactionBean().getEmployerName(businessId);
		return employerName;
	}

	public int String2Int(String value) {
		return new Integer(value).intValue();
	}

	public long getBusinessId(HttpServletRequest request) {
		return getUserProfile(request).getBusinessId();
	}

	public long getLoginUsers_UserId(HttpServletRequest request) {
		return getUserProfile(request).getUserId();
	}

	@SuppressWarnings("rawtypes")
	public void analyzeRequest(HttpServletRequest request) {
		Map m = request.getParameterMap();
		if (m != null) {
			log.info("size of request params --> " + m.size());
			Iterator it = m.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry entry = (Map.Entry) it.next();
				log.info((String) entry.getKey() + " --> " + (String) entry.getValue());
			}
		}
	}

	public String getApplicationPath() {
		if (appPath != null)
			return appPath;
		appPath = getServlet().getServletContext().getRealPath(".");
		log.info("Application Context Path {}",appPath);
		return appPath;
	}

	public String getApplicationPathToOneUP() {
		if (appPathOneUp != null) {
			return appPathOneUp;
		}
		appPathOneUp = getServlet().getServletContext().getRealPath("/");

		String rPath = getServlet().getServletContext().getContextPath();
		if (rPath == null || (rPath != null && rPath.length() == 0))
			rPath = "/ROOT";
		log.info("Application ROOT path {}", rPath);
		String appName = rPath.substring(1, rPath.length());
		log.info("Application Name {}", appName);
		appPathOneUp = appPathOneUp.substring(0, appPathOneUp.indexOf(appName));
		log.info("App Path Set to One folder Up {}",appPathOneUp);
		return appPathOneUp;
	}

	public String getApplicationURL(HttpServletRequest request) {

		String scheme = request.getScheme(); // http
		String serverName = request.getServerName(); // hostname.com
		int serverPort = request.getServerPort(); // 80
		String contextPath = request.getContextPath(); // /mywebapp

		String url = scheme + "://" + serverName + ":" + serverPort + contextPath + "/";

		return url;
	}

	@SuppressWarnings("unused")
	public String getServerURL(HttpServletRequest request) {

		String scheme = request.getScheme(); // http
		String serverName = request.getServerName(); // hostname.com
		int serverPort = request.getServerPort(); // 80
		String contextPath = request.getContextPath(); // /mywebapp

		String url = scheme + "://" + serverName + ":" + serverPort + "/";

		return url;
	}

	public String getApplicationContextPath(HttpServletRequest request) {

		String scheme = request.getScheme(); // http
		String serverName = request.getServerName(); // hostname.com
		int serverPort = request.getServerPort(); // 80
		String contextPath = request.getContextPath(); // /mywebapp
		String url="";
		if(serverPort!=0)
			url = scheme + "://" + serverName + ":" + serverPort + contextPath + "/";
		else
			url = scheme + "://" + serverName + contextPath + "/";
		return url;
	}

	
	protected VelocityEngine getVMEngine() {
		return (VelocityEngine) getSpringCTX().getBean("velocityEngine");
	}

	@SuppressWarnings("deprecation")
	protected String getEmailTemplate(Object bean, String vmName) {
		String signature = "";

		Map<String, Object> model = new HashMap<String, Object>();
		model.put(VMConstants.VM_BEAN, bean);
		if (signature != null && signature.length() > 0)
			model.put(VMConstants.VM_SIGNATURE, signature);
		else
			model.put(VMConstants.VM_SIGNATURE, "Thank you");
		String emailBody = VelocityEngineUtils.mergeTemplateIntoString(getVMEngine(), vmName, model);

		return emailBody;
	}

	public StringBuffer getEmailContent(long userId, DoTransaction doTransaction, HttpServletRequest request) {
		int min = 11;
		int max = 35;
		VMInputBean bean = new VMInputBean();
		Map<String,Object> personalData = doTransaction.getUserDetailsByUserId(userId);
		Map<String,Object> clientData = doTransaction.getClientDetails(userId);
		String clientName = (String)clientData.get("clientName");
		String firstName = (String)personalData.get("firstName");
		String middleName = (String)personalData.get("middleName");
		String contactEmail = (String)personalData.get("contactEmail");
		bean.setName(firstName);
		bean.setClientName(clientName);
		bean.setMiddleName(middleName);
		bean.setEmailId(contactEmail);
		UUID uuid = UUID.randomUUID();
		Random randomGenerator = new Random();
		int randomInt = randomGenerator.nextInt(max - min + 1) + min;
		StringBuffer sb = new StringBuffer(randomInt + String.valueOf(uuid)
				+ "_" + String.valueOf((userId)).length());
		sb.insert(randomInt - 2, userId);

		url = getApplicationContextPath(request)+"adminEmailApproval.do?p=" + sb.toString();
		bean.setUrl(url);
		bean.setText("The following employee registration is in pending state. Click below button to approve. Alternatively, you can approve or reject upon logging into the application as well. You can also approve all pending list at a time with single click.");
		String body = getEmailTemplate(bean, VMConstants.VM_PENDING_APPROVAL);
		//StringBuffer sb = new StringBuffer();
		//sb.append("An Employee registration approval is pending");
		//sb.append("To Approve your users, please login into ILC, go to admin functional area and click on Pending Approvals.");
		return new StringBuffer(body);
	}	
}
