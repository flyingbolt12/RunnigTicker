package com.lch.struts.actions;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.generalBeans.UserProfile;
import com.lch.struts.actions.admin.AdminFunctImplAction;
import com.lch.struts.formBeans.ContactBean;

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
		
		UserProfile profile = getUserProfile(request);
		
		if(profile.getUserName()!=null && profile.getUserName().length()>1 && !profile.getUserRole().equals("SUPERADMIN")){
			// load user details based on login name;
			Map<String, Object> info = getSpringCtxDoTransactionBean().loadUserDetailsByLoginName(profile.getBusinessId(), profile.getUserName());
			ContactBean bean = new ContactBean();
			bean.setFirstName((String)info.get("firstName"));
			bean.setLastName((String)info.get("lastName"));
			bean.setCompany((String)info.get("businessName"));
			bean.setAddress((String)info.get("address1") +" "+ (String)info.get("address2"));
			bean.setCity((String)info.get("city"));
			bean.setState((String)info.get("state"));
			bean.setZip((String)info.get("zipcode"));
			bean.setPhone((String)info.get("phoneNumber"));
			bean.setEmail((String)info.get("contactEmail"));
			bean.setEmployerEmail((String)info.get("employerEmail"));			

			putObjInRequest("contactBean", request, bean);
			
		}
		
		
		forward = mapping.findForward("contactInformationDL");
		return (forward);
	}

}
