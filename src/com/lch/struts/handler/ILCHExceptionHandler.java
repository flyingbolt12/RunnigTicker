package com.lch.struts.handler;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ExceptionHandler;
import org.apache.struts.config.ExceptionConfig;
import org.apache.velocity.app.VelocityEngine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.lch.general.constants.VMConstants;
import com.lch.general.email.EmailDetails;
import com.lch.general.email.EmailUtil;
import com.lch.general.generalBeans.UserProfile;
import com.lch.struts.actions.BaseAction;

public class ILCHExceptionHandler extends ExceptionHandler {

	private static Logger log = LoggerFactory.getLogger(ILCHExceptionHandler.class);

	private static ArrayList<String> devopers = new ArrayList<String>();
	static {
		devopers.add("haigopi@gmail.com");
		devopers.add("nithya.av@gmail.com");
		devopers.add("sridhar.thigulla@gmail.com");
		}

	@Override
	public ActionForward execute(Exception ex, ExceptionConfig ae, ActionMapping mapping, ActionForm formInstance,
			HttpServletRequest request, HttpServletResponse response) throws ServletException {

		log.error("An Error Occured and needs immediate attention :{}", ex);

		UserProfile userProfile = (UserProfile) (request.getSession().getAttribute("userProfile"));
		String customerdetails = "N/A";
		if (userProfile != null) {
			customerdetails = getCoustmerDetals(userProfile);
		}

		String stackTrace = stackTraceToString(ex);

		EmailDetails emailDetails = new EmailDetails();
		emailDetails.setSubject("ILCH - Need your action");
		emailDetails.setCc(devopers);
		emailDetails.setFrom("alertoalerts@gmail.com");
		try {
			emailDetails.setEmailContent(getEmailContent(request, stackTrace, customerdetails));
		} catch (Exception e) {
			emailDetails.setEmailContent(new StringBuffer().append(customerdetails).append("<BR>").append(stackTrace));
		}
		BaseAction action = new BaseAction();
		action.sendEmail(emailDetails, getSpringCtxEmailBean(request));

		return super.execute(ex, ae, mapping, formInstance, request, response);
	}

	private StringBuffer getEmailContent(HttpServletRequest request, String stackTrace, String customerdetails) {
		StringBuffer buffer = new StringBuffer();

		VelocityEngine engine = (VelocityEngine) ((getSprngCtx(request)).getBean("velocityEngine"));
		Map<String, String> bean = new HashMap<String, String>();
		bean.put("exceptionTrace", stackTrace);
		bean.put("customerDetails", customerdetails);
		String sb = getEmailTemplate(bean, VMConstants.VM_ERROR_NOTIFICATION, engine);

		buffer.append(sb);
		return buffer;
	}
	
	private GenericXmlApplicationContext getSprngCtx(HttpServletRequest request)
	{
		return (GenericXmlApplicationContext) request.getSession()
		.getServletContext().getAttribute("ctx");
	}
	public EmailUtil getSpringCtxEmailBean(HttpServletRequest request) {
		EmailUtil sendMail = (EmailUtil) getSprngCtx(request).getBean("sendEmail");
		return sendMail;
	}
	
	public String stackTraceToString(Throwable e) {
		String retValue = null;
		StringWriter sw = null;
		PrintWriter pw = null;
		try {
			sw = new StringWriter();
			pw = new PrintWriter(sw);
			e.printStackTrace(pw);
			retValue = sw.toString();
		    retValue = retValue.replace("\n", "<BR>       ");
		} finally {
			try {
				if (pw != null)
					pw.close();
			} catch (Exception ignore) {
			}
		}
		return retValue;
	}

	private String getCoustmerDetals(UserProfile up) {
		StringBuilder builder = new StringBuilder();
		builder.append("Business Email : ").append(up.getEmployerEmail()).append("<BR>").append("Business Id :")
				.append(up.getBusinessId()).append("<BR>").append("User Email Id : ").append(up.getEmployeeEmail())
				.append("<BR>").append("User Id : ").append(up.getUserId()).append("<BR>").append("FirstName : ")
				.append(up.getFirstName()).append("<BR>").append("UserName : ").append(up.getUserName()).append("<BR>")
				.append("User Role : ").append(up.getUserRole());
		return builder.toString();
	}

	@SuppressWarnings("deprecation")
	protected String getEmailTemplate(Object bean, String vmName, VelocityEngine engine) {
		String signature = "";

		Map<String, Object> model = new HashMap<String, Object>();
		model.put(VMConstants.VM_BEAN, bean);
		if (signature != null && signature.length() > 0)
			model.put(VMConstants.VM_SIGNATURE, signature);
		else
			model.put(VMConstants.VM_SIGNATURE, "Thank you");
		String emailBody = VelocityEngineUtils.mergeTemplateIntoString(engine, vmName, model);

		return emailBody;
	}

}
