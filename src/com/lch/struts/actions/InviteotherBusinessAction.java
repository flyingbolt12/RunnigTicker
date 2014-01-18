package com.lch.struts.actions;

import java.util.ArrayList;
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
import com.lch.general.generalBeans.UserProfile;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.struts.formBeans.InviteotherBusinessBean;

public class InviteotherBusinessAction extends BaseAction{

	private static Logger log = LoggerFactory.getLogger(InviteotherBusinessAction.class);
	
	public ActionForward inviteOtherBusiness(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-inviteOtherBusiness-");
		ActionForward forward = new ActionForward();
		InviteotherBusinessBean bean=(InviteotherBusinessBean)form;
		UserProfile userProfile = getUserProfile(request);
		long personalId = userProfile.getPersonalDetailsId();
		long businessId = userProfile.getBusinessId();
		Map<String,Object> personalData = getSpringCtxDoTransactionBean().getUserDetails(personalId);
		String emailList=bean.getEmailsList();
		VMInputBean vmbean = new VMInputBean();
		String businessName = getSpringCtxDoTransactionBean().getEmployerName(businessId);
		String firstName = (String)personalData.get("firstName");
		String lastName = (String)personalData.get("lastName");
		String fullName = firstName + " " + lastName;
		vmbean.setName(fullName);
		vmbean.setBusinessName(businessName);
		//String emailList = getStrAsRequestParameter("emailsList", request);
		log.info("emails List :"+emailList);
		String[] emails = emailList.split(",");
		
		//ActionForward forward = new ActionForward();
		EmailDetails emailDetails = new EmailDetails();
		ArrayList<String> l = new ArrayList<String>();
		for(int i =0; i<emails.length;++i)
		l.add(emails[i]);
		emailDetails.setTo(l);
		emailDetails.setSubject(" You are invited by to use ILCH");
		String sb = getEmailTemplate(vmbean, VMConstants.VM_INVITE_BUSINESS);
		emailDetails.setEmailContent(new StringBuffer(sb));
		sendEmail(emailDetails);
		forward = mapping.findForward("inviteOtherBusinessResult");
		return (forward);
	}
}
