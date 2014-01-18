package com.lch.struts.actions.members;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.struts.actions.BaseAction;

public class AddAnEmployeeRegistration extends BaseAction{

	private static Logger log = LoggerFactory
	.getLogger(EmployeeRegistrationAction.class);

	
	
	public ActionForward addAnEmployeeCanclation(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward= mapping.findForward("cancelRegistration");
		return(forward);
	}
	
	public ActionForward checkUserNameAvailability(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String userName = request.getParameter("ajaxParam");
		String ajaxMsg = "";
		int usrCount =0;
		try {
			usrCount = getSpringCtxDoTransactionBean().checkUsrAvailablity(userName);
			log.info("No Of Users available for with this User Name - " + usrCount);
			if(usrCount ==0)
			{    log.info("message");
				ajaxMsg = "Congratulations, This UserName is availbale.";
				putObjInRequest("generalAJAXMsg", request, ajaxMsg);
				log.info("message");
			}
			else
			{    log.info("message");
				ajaxMsg = "Sorry, This UserName is not availbale.";
				putObjInRequest("generalAJAXMsg", request, ajaxMsg);
				putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			putObjInRequest("generalAJAXMsg", request,
					"Unable to Identify. Please proceed next");
		}

		return mapping.findForward("generalJSP4AJAXMsg");
	}
	


}
