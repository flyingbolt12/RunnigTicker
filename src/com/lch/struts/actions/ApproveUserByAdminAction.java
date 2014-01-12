package com.lch.struts.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ApproveUserByAdminAction extends BaseAction {
	private static Logger logger = LoggerFactory
			.getLogger(ApproveUserByAdminAction.class);

	public ActionForward execute(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = mapping.findForward("status");
		
		String activationId = request.getParameter("p");
		logger.debug("activationId recieved --> " + activationId);

		String onlyId = activationId.substring(0, 2);
		int i = new Integer(onlyId).intValue();
		logger.info("integer --> " + i);
		i = i-2;
		int length = new Integer(activationId.substring(activationId.lastIndexOf("_")+1,
				activationId.length())).intValue();

		String id = activationId.substring(i, i+length);
		
		logger.info("Approving Users - userId : {}", id);
		
		int idToCheck = 0;
		try {
			idToCheck = new Integer(id).intValue();
			logger.info("User ID : "+idToCheck);
		} catch (Exception e) {
			logger.error("User ID : "+idToCheck);
			idToCheck = 0;
		}
		if(idToCheck!=0)
			{ 
				int rcdUpdCnt = getSpringCtxDoTransactionBean().approveUserByAdmin(idToCheck);
				logger.info("rcdUpdCnt : "+rcdUpdCnt);
				if(rcdUpdCnt>0){
					putObjInRequest("status", request, "Success");
				}
				else{
					putObjInRequest("status", request, "Fail");
				}
			} 
		return forward;
	}
}
