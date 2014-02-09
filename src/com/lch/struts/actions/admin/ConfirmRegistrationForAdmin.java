 package com.lch.struts.actions.admin;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.Roles;
import com.lch.general.constants.VMConstants;
import com.lch.general.dbBeans.Address;
import com.lch.general.email.EmailDetails;
import com.lch.general.generalBeans.UserProfile;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.formBeans.admin.CreateAnotherAdminBean;

public class ConfirmRegistrationForAdmin extends BaseAction {
	private static Logger log = LoggerFactory
	.getLogger(BusinessRegistrationAction.class);

	public ActionForward createAnotherAdmin(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
/*
		isSignedIn(mapping, request, response);
		String cancel = request.getParameter("cancel");
		String confirm = request.getParameter("confirm");
		
		log.info("--->" + cancel);
		log.info("--->" + confirm);
		if(cancel!=null) {
			return mapping.findForward("cancelCreation");
		}*/
			ActionForward forward = new ActionForward();
			log.info("Finishing Business Registration Process");
			CreateAnotherAdminBean adminRegistrationBean = (CreateAnotherAdminBean) form;
			adminRegistrationBean.setRole(Roles.CHILDADMIN.name());
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
			adminRegistrationBean.setApprovalStatus(1);
			long userId = doTransaction.insertUSERS(adminRegistrationBean,
					getUserProfile(request));
			log.info("UserId :" + userId);
			adminRegistrationBean.setUserId(userId);
			UserProfile userProfile = getUserProfile(request);
			long personalId = userProfile.getPersonalDetailsId();
			Map<String,Object> personalData = getSpringCtxDoTransactionBean().getUserDetails(personalId);
			VMInputBean vmbean = new VMInputBean();
			String password = getSpringCtxDoTransactionBean().getPassword(userProfile.getEmployeeEmail());
			String firstName = (String)personalData.get("firstName");
			String lastName = (String)personalData.get("lastName");
			String fullName = firstName + " " + lastName;
			vmbean.setName(fullName);
			vmbean.setUserId(userProfile.getUserName());
			vmbean.setPassword(password);
			EmailDetails emailDetails = new EmailDetails();
			ArrayList<String> to = new ArrayList<String> ();
			ArrayList<String> cc = new ArrayList<String> ();
			to.add(adminRegistrationBean.getContactEmail());
			cc.add(getUserProfile(request).getEmployerEmail());
			log.info(adminRegistrationBean.getContactEmail() + getUserProfile(request).getEmployerEmail());
			emailDetails.setTo(to);
			emailDetails.setCc(cc);
			emailDetails.setSubject("Another Admin Business Registered");
			String sb = getEmailTemplate(vmbean, VMConstants.VM_ANOTHER_ADMIN);
			emailDetails.setEmailContent(new StringBuffer(sb));
			sendEmail(emailDetails);
			putObjInRequest("adminAdded",request,"yes");
			forward=mapping.findForward("adminFunctions");
			return forward;
	}
}
