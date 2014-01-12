package com.lch.struts.actions.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.dbBeans.Address;
import com.lch.general.email.EmailDetails;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.formBeans.admin.AdminRegistrationBean;

public class BusinessRegistrationAction extends BaseAction {
	private static Logger log = LoggerFactory
			.getLogger(BusinessRegistrationAction.class);
	
	public ActionForward srartRegistration(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String cancel = request.getParameter("cancel");
		
		if(cancel!=null) {
			return mapping.findForward("cancel"); 
		}
		log.info("Business Registration Process Starting");
		AdminRegistrationBean adminRegistrationBean = (AdminRegistrationBean) form;
		
		describeInstance(adminRegistrationBean);
		return mapping.findForward("registrtationProcess1");
	}

	public ActionForward createAnotherAdmin(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		
		String cancel = request.getParameter("cancel");
		String confirm = request.getParameter("confirm");
		log.info("--->" + cancel);
		log.info("--->" + confirm);
		if(cancel!=null) {
			return mapping.findForward("cancelCreation"); 
		}
			log.info("Finishing Business Registration Process");
			AdminRegistrationBean adminRegistrationBean = (AdminRegistrationBean) form;
			DoTransaction doTransaction = getSpringCtxDoTransactionBean();

			Address address = adminRegistrationBean.getListAddress(0);
			long businessAddressId = doTransaction.insertADDRESSINFO(address);
			log.info("Business AddressId got :" + businessAddressId);
			adminRegistrationBean.setBusinessAddressId(businessAddressId);

			address = adminRegistrationBean.getListAddress(1);
			long personalAddressId = doTransaction.insertADDRESSINFO(address);
			log.info("Personal AddressId got :" + personalAddressId);
			adminRegistrationBean.setPersonalAddressId(personalAddressId);
			long businessId= getUserProfile(request).getBusinessId();
			log.info(" businessId --> "+businessId);
			long personalDetailsId = doTransaction.insertUSERPERSONALDATA(
					adminRegistrationBean, getUserProfile(request));
			adminRegistrationBean.setPersonalDetailsId(personalDetailsId);
			log.info("Personal DetailsId Id :" + personalDetailsId);

			adminRegistrationBean.setBusinessId(businessId);
			long userId = doTransaction.insertUSERS(adminRegistrationBean,
					getUserProfile(request));
			log.info("UserId :" + userId);
			adminRegistrationBean.setUserId(userId);
			EmailDetails emailDetails = new EmailDetails();
			ArrayList<String> to = new ArrayList<String> ();
			ArrayList<String> cc = new ArrayList<String> ();
			to.add(adminRegistrationBean.getContactEmail());
			cc.add(getUserProfile(request).getEmployerEmail());
			log.info(adminRegistrationBean.getContactEmail() + getUserProfile(request).getEmployerEmail());
			emailDetails.setTo(to);
			emailDetails.setCc(cc);
			emailDetails.setSubject("Another Admin Business Registered");
			emailDetails.setEmailContent(new StringBuffer("Another Admin Created Successfully."));
			sendEmail(emailDetails);
			return mapping.findForward("processBusiness");

	}
//	private StringBuffer getEmailContent(AdminRegistrationBean adminRegistrationBean){
//		StringBuffer sb = new StringBuffer();
//		
//		sb.append(EMAIL_LINK_ACTION_CONTENT_PATH+"busEMailValidation.do?bid="+RandomInteger.getRandomNumber()+"~"+RandomInteger.getRandomNumber()+"__~__"+adminRegistrationBean.getUserId()+"__~__"+RandomInteger.getRandomNumber()+"~"+RandomInteger.getRandomNumber());
//		return sb;
//	}
	public ActionForward registrtationProcess1(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String cancel = request.getParameter("cancel");
		log.info("--->" + cancel);
		
		
		// Fill the details as needed for personal address if same as business address
		String isSameAsBusinessAddress = getStrAsRequestParameter("isSameAsBusinessAddress", request);
		
		if(isSameAsBusinessAddress!=null && isSameAsBusinessAddress.equals("Y")){
			
			AdminRegistrationBean bean = (AdminRegistrationBean)form;
			bean.copyBusinessAddressToPersonalAddress();
		}
		
		
		if(cancel!=null) {
			return mapping.findForward("startRegistrtationProcess"); 
		}
		return mapping.findForward("businessRegistrationValidationPending");
	}

	
	
	public ActionForward adminCancelReg(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward= mapping.findForward("cancelCreation");
		return(forward);
	}

	public ActionForward cancelBusinessCreation(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("cancelBusinessCreation Process Starting");
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("cancel");
		return (forward);
	}

}
