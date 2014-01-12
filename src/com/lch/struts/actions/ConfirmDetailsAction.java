package com.lch.struts.actions;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.email.EmailDetails;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.admin.AdminFunctImplAction;
import com.lch.struts.formBeans.ContactBean;

public class ConfirmDetailsAction extends BaseAction 
{
	private static Logger log = LoggerFactory.getLogger(AdminFunctImplAction.class);
	 public ActionForward contactUs(ActionMapping mapping,
				ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception {
	ContactBean bean=(ContactBean)form;
	DoTransaction doTransaction = getSpringCtxDoTransactionBean();
	long idusercontact = doTransaction.insertUSERCONTACTDATA(
			bean);
	bean.setUserId(idusercontact);
	log.info("USER Id :" + idusercontact);
	
	EmailDetails emailDetails = new EmailDetails();
	ArrayList<String>  to = new ArrayList<String> ();
	to.add(bean.getEmail());
	emailDetails.setTo(to);
	emailDetails.setSubject(bean.getSubject());
	StringBuffer sb = getEmailContent(bean);
	emailDetails.setEmailContent(sb);
	sendEmail(emailDetails);
	return mapping.findForward("contactUsResponse") ;
}
	private StringBuffer getEmailContent(ContactBean bean)
	{
		StringBuffer sb = new StringBuffer();

		sb.append("First Name" + ":" + bean.getFirstName() + "<BR>");
		sb.append("last Name" + ":" + bean.getLastName() + "<BR>");
		sb.append("Company" + ":" + bean.getCompany() + "<BR>");
		sb.append("Address" + ":" + bean.getAddress() + "<BR>");
		sb.append("City" + ":" + bean.getCity() + "<BR>");
		sb.append("Phone" + ":" + bean.getPhone() + "<BR>");
		sb.append("Comment" + ":" + bean.getComment() + "<BR>");
		sb.append("Zip" + ":" + bean.getZip() + "<BR>");
		sb.append("state" + ":" + bean.getState() + "<BR>");
		return sb;
	}
}
