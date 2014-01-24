package com.lch.struts.actions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.constants.VMConstants;
import com.lch.general.email.EmailDetails;
import com.lch.general.genericUtils.GeneratePassword;
import com.lch.spring.SQLQueries;

public class ForgotPasswordAction extends BaseAction {
 
	private static Logger log = LoggerFactory.getLogger(ForgotPasswordAction.class);
	public ActionForward forgotPasswordOptionsPage(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		log.info("-divertToForgotPasswordOptionsPage-TEST EXECUTED");
		forward = mapping.findForward("forgotPasswordOptionsPage");
		return forward;
	}
	public ActionForward forgotPassword(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		log.debug("-forgotPassword-");
		ActionErrors errors = new ActionErrors();
		
		String emailId = getStrAsRequestParameter("emailId", request);
		if(emailId!=null && emailId.length()!=0 && emailId.indexOf(".")!=-1 && emailId.indexOf("@")!=-1)
		{
			try{
				int users = getSpringCtxDoTransactionBean().getUserCount(emailId);
				
				if(users>1)
				{
					putStatusObjInRequest(request, "There is a System Error");
					mapping.findForward("status");
				}
				else
				{
					String password = GeneratePassword.getGeneratedPassword();
					putObj4generalAJAXMsg(request, "Check your Email. If you don't see any email from us shortly, please check your spam.");
					
					int count = getSpringCtxDoTransactionBean().updateResetForgotPassword(password, emailId);
					
					String sb;
					
					if(count <= 0)
					{
						Map<String, String> bean = new HashMap<String, String>();
						bean.put("action", "Forgot Password");
						bean.put("text", "Failed to process your request, Please contact us using contactus form in the website.");
						sb = getEmailTemplate(bean, VMConstants.VM_STATUS_TEMPLATE_MAIL);
					}
					else
					{
						Map<String, String> bean = new HashMap<String, String>();
						bean.put("text", password);
						sb = getEmailTemplate(bean, VMConstants.VM_FORGOT_PWD_MAIL);
					}
					
					EmailDetails emailDetails = new EmailDetails();
					ArrayList<String> l = new ArrayList<String>();
					l.add(emailId);
					
					ArrayList<String> bcc= new ArrayList<String>();
					l.add("contact@allibilli.com");
					
					emailDetails.setTo(l);
					emailDetails.setBcc(bcc);
					emailDetails.setSubject("Change Password");
					
					
					emailDetails.setEmailContent(new StringBuffer(sb));
					sendEmail(emailDetails);
					
					forward = mapping.findForward("forgotPasswordResponse");
				}
			
			}
			catch (Exception e) {
				e.printStackTrace();
				errors.add("emailRequired", new ActionMessage("forgotPassword.email.not.available"));
				saveErrors(request, errors);
				forward = mapping.findForward("forgotPasswordOptionsPage");
			}
			
		}
		else
		{
			errors.add("emailRequired", new ActionMessage("forgotPassword.email.required"));
			saveErrors(request, errors);
			forward = mapping.findForward("forgotPasswordOptionsPage");
		}
		
		return forward;
	}
	
}
