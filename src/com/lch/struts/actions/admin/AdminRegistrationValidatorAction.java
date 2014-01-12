package com.lch.struts.actions.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.struts.actions.BaseAction;

public class AdminRegistrationValidatorAction extends BaseAction {
	private static Logger log = LoggerFactory
			.getLogger(AdminRegistrationValidatorAction.class);

	public ActionForward execute(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = mapping.findForward("businessEmailValidationStatus");
		String bid = request.getParameter("p");
		String onlyId = bid.substring(0, 2);
		int i = new Integer(onlyId).intValue();
		
		int length = new Integer(bid.substring(bid.lastIndexOf("_")+1,
				bid.length())).intValue();
		i = i-2;
		String id = bid.substring(i, i+length);
		log.info(id);
		
		log.info("Business Validation - BusinessId : " + id);
	
		long businessId = 0;
		try {
			businessId = new Integer(id).intValue();
			log.info("businessId : "+businessId);
		} catch (Exception e) {
			log.error("businessId : "+businessId);
			businessId = 0;
		}
		if(businessId!=0)
			{ 
				int rcdUpdCnt = getSpringCtxDoTransactionBean().validateBusinessEmail(businessId);
				log.info("rcdUpdCnt : "+rcdUpdCnt);
				if(rcdUpdCnt>0){
					putObjInRequest("emailValidateStatus", request, "Success");
				}
				else{
					putObjInRequest("emailValidateStatus", request, "Fail");
				}
			} 
		return forward;
	}
}
