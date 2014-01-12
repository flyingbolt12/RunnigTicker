package com.lch.struts.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.struts.actions.admin.AdminFunctImplAction;

public class FooterAction extends BaseAction {
	private static Logger log = LoggerFactory.getLogger(AdminFunctImplAction.class);

	public ActionForward legalInformation(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-legal-TEST EXECUTED");
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("legalInformationDL");
		return (forward);
	}

	public ActionForward privacyInformation(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-privacy-TEST EXECUTED");
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("privacyInformationDL");
		return (forward);
	}

	public ActionForward contactInformation(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-contact-TEST EXECUTED");
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("contactInformationDL");
		return (forward);
	}

}
