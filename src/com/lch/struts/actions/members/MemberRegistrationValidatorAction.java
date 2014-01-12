package com.lch.struts.actions.members;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.dbBeans.LCH_BUSINESS;
import com.lch.general.email.EmailDetails;
import com.lch.struts.actions.BaseAction;

public class MemberRegistrationValidatorAction extends BaseAction {
	private static Logger log = LoggerFactory
			.getLogger(MemberRegistrationValidatorAction.class);
	
	public ActionForward execute(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = mapping.findForward("userEmailValidationStatus");
		url = getApplicationURL(request);
		String bid = request.getParameter("p");
		String onlyId = bid.substring(0, 2);
		int i = new Integer(onlyId).intValue();
		i = i-2;
		int length = new Integer(bid.substring(bid.lastIndexOf("_")+1,
				bid.length())).intValue();

		String id = bid.substring(i, i+length);
		log.info(id);
		
		log.info("User Validation - User Id : " + id);
	
		long userId = 0;
		try {
			userId = new Integer(id).intValue();
			log.info("User Id : {}", userId);
		} catch (Exception e) {
			userId = 0;
		}
		if(userId!=0)
			{ 
				int rcdUpdCnt = getSpringCtxDoTransactionBean().validateMemberEmail(userId);
				log.info("rcdUpdCnt : "+rcdUpdCnt);
				if(rcdUpdCnt>0){
					putObjInRequest("emailValidateStatus", request, "Success");
					notifyBusinessForMemberLoginApprovalPending(userId, request);
				}
				else{
					putObjInRequest("emailValidateStatus", request, "Fail");
				}
			} 
		return forward;
	}
	
	public void notifyBusinessForMemberLoginApprovalPending(long userId, HttpServletRequest request)
	{
		try{
		LCH_BUSINESS businessDetails = getSpringCtxDoTransactionBean().getBusinessDetailsByUser(userId);
		EmailDetails emailDetails = new EmailDetails();
		ArrayList<String> to = new ArrayList<String>();
		String businessEmailId = businessDetails.getEmployerEmail();
		
		if(businessEmailId!=null && businessEmailId.length() > 0)
		{
		to.add(businessEmailId);
		emailDetails.setTo(to);
		emailDetails.setSubject("Employee Registration - Approval Pending");
		StringBuffer sb = getEmailContent(userId,getSpringCtxDoTransactionBean(), request);
		emailDetails.setEmailContent(sb);
		sendEmail(emailDetails);
		}
		}
		catch (Exception e) {e.printStackTrace();
		}
	}
	
}
