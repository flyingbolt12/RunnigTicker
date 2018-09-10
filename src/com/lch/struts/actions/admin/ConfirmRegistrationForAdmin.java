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
import com.lch.general.genericUtils.GeneratePassword;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.formBeans.admin.CreateAnotherAdminBean;

public class ConfirmRegistrationForAdmin extends BaseAction {
	private static Logger log = LoggerFactory
	.getLogger(BusinessRegistrationAction.class);

	public ActionForward createAnotherAdmin(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

			ActionForward forward = new ActionForward();
			log.info("Creating a Child Admin");
			CreateAnotherAdminBean adminRegistrationBean = (CreateAnotherAdminBean) form;
			adminRegistrationBean.setLogin(adminRegistrationBean.getContactEmail());
			adminRegistrationBean.setRole(Roles.CHILDADMIN.name());
			DoTransaction doTransaction = getSpringCtxDoTransactionBean();
			String password;
			try{
			
			long businessId= getUserProfile(request).getBusinessId();
			log.info(" businessId --> "+businessId);
			long personalDetailsId = doTransaction.insertUSERPERSONALDATA(
					adminRegistrationBean, getUserProfile(request));
			adminRegistrationBean.setPersonalDetailsId(personalDetailsId);
			log.info("Personal DetailsId Id :" + personalDetailsId);
			
			adminRegistrationBean.setBusinessId(businessId);
			adminRegistrationBean.setApprovalStatus(1);
			adminRegistrationBean.setIsEmailValidated(1);
			password = GeneratePassword.getGeneratedPassword();
			adminRegistrationBean.setPassword(password);
			adminRegistrationBean.setTimeSheetConfiguredTo("");
			long userId = doTransaction.insertUSERS(adminRegistrationBean,
					getUserProfile(request));
			log.info("UserId :" + userId);
			adminRegistrationBean.setUserId(userId);
			
			}
			catch(Exception e)
			{
				e.printStackTrace();
				putObjInRequest("showStatus",request,"Child Admin Not Created");
				forward=mapping.findForward("adminFunctions");
				return forward;
			}
			
			UserProfile userProfile = getUserProfile(request);
			long personalId = userProfile.getPersonalDetailsId();
			Map<String,Object> personalData = getSpringCtxDoTransactionBean().getUserDetails(personalId);
			
			VMInputBean vmbean = new VMInputBean();
			String firstName = (String)personalData.get("firstName");
			String lastName = (String)personalData.get("lastName");
			String fullName = firstName + " " + lastName;
			
			vmbean.setName(fullName);
			vmbean.setUserId(adminRegistrationBean.getLogin());
			vmbean.setPassword(password);
			
			EmailDetails emailDetails = new EmailDetails();
			ArrayList<String> to = new ArrayList<String> ();
			
			
			to.add(adminRegistrationBean.getContactEmail());
			log.info(adminRegistrationBean.getContactEmail() + getUserProfile(request).getEmployerEmail());
			
			emailDetails.setTo(to);

			emailDetails.setSubject("RunningTicker-You are now a Child Admin");
			String sb = getEmailTemplate(vmbean, VMConstants.VM_ANOTHER_ADMIN);
			emailDetails.setEmailContent(new StringBuffer(sb));
			sendEmail(emailDetails);
			putObjInRequest("showStatus",request,"Child Admin Created");
			forward=mapping.findForward("adminFunctions");
			return forward;
	}
}
