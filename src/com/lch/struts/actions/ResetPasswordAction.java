package com.lch.struts.actions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.constants.VMConstants;
import com.lch.general.email.EmailDetails;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.struts.actions.admin.AdminFunctImplAction;
import com.lch.struts.formBeans.ResetPasswordBean;
@SuppressWarnings({ "rawtypes", "unchecked" })
public class ResetPasswordAction extends BaseAction {
	private static Logger log = LoggerFactory.getLogger(AdminFunctImplAction.class);
	
	public ActionForward resetAccountPassword(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-resetAccountPassword-TEST EXECUTED");
		String contactEmail=getStrAsRequestParameter("contactEmail", request);
		ResetPasswordBean bean=(ResetPasswordBean)form;
		String password=bean.getPassword();
		log.info("From Action class , password :"+password +"; contactEmail :"+contactEmail);
		Map m=new HashMap();
		m.put("userId",Long.toString( getUserProfile(request).getUserId()));
		m.put("businessId",Long.toString( getUserProfile(request).getBusinessId()));
		m.put("password", password);
		log.info("map :"+m);
		getSpringCtxDoTransactionBean().updateResetedPassword(m);
		log.info("Password Updated");
		putObjInRequest("passwordUpdated", request, "yes");
		EmailDetails emailDetails = new EmailDetails();
		ArrayList<String> to = new ArrayList<String>();
		String emailId = contactEmail;
		VMInputBean vmBean = new VMInputBean();
		if(emailId!=null && emailId.length()>0)
		{
			to.add(emailId);
			emailDetails.setTo(to);
			emailDetails.setSubject("Recent Password Reset Request");
			//vmBean.setText("Your password had been reset. If you are not the one done this, please report us using contact us form.");
			vmBean.setText(password);
			String sb = getEmailTemplate(bean, VMConstants.VM_PASSWORD_RESET_NOTIFICATION);
			emailDetails.setEmailContent(new StringBuffer(sb));
			sendEmail(emailDetails);
		}
		
		if( getUserProfile(request).isAdmin() )
			return mapping.findForward("adminFunctions");
		else		
			return mapping.findForward("memberFunctions");
	}
	
}

