package com.lch.struts.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @version 1.0
 * @author
 */
public class SignOutAction extends BaseAction 
{

	public ActionForward execute(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("forwardTo");
		request.getSession().removeAttribute("userProfile");
//		request.getSession().invalidate();
		putObjInRequest("signedout", request, "1");
		return forward;
	}
	
}