package com.lch.struts.actions.members;

import java.util.ArrayList;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.validator.GenericValidator;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.apache.struts.validator.ValidatorForm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.constants.VMConstants;
import com.lch.general.dbBeans.Address;
import com.lch.general.dbBeans.USER_ROLES;
import com.lch.general.email.EmailDetails;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.formBeans.admin.AdminRegistrationBean;
import com.lch.struts.formBeans.members.AddAnEmployeeBean;

public class ConfirmAddAnEmployeeRegistrationAction extends BaseAction {

	private static Logger log = LoggerFactory.getLogger(ConfirmMemberRegistrationAction.class);

	
	public ActionForward addAnEmployee(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("-addAnEmployee-TEST EXECUTED");

		ActionForward forward = new ActionForward();

		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		AdminRegistrationBean adminRegistrationBean = new AdminRegistrationBean();
		AddAnEmployeeBean addAnEmployeeBean = (AddAnEmployeeBean) form;
		adminRegistrationBean.setBusinessId(getUserProfile(request).getBusinessId());
		try {
			// Step 1: Inserting the Current Address
			Address address = addAnEmployeeBean.getListAddress(0);
			long employeeCurrentAddressId = doTransaction.insertADDRESSINFO(address);
			log.info("EmployeeCurrent AddressId got:" + employeeCurrentAddressId);
			addAnEmployeeBean.setMyAddressId(employeeCurrentAddressId);

			// Step 2: Inserting the Home Country Address

			String isSameAsBusinessAddress = getStrAsRequestParameter("isSameAsCurrentAddress", request);
			if (isSameAsBusinessAddress != null && isSameAsBusinessAddress.equals("Y")) {
				long employeeHomeCountryAddressId = doTransaction.insertADDRESSINFO(addAnEmployeeBean.getListAddress(0));
				log.info("EmployeeHomeCountry AddressId got :" + employeeHomeCountryAddressId);
				addAnEmployeeBean.setHomeCountryAddressId(employeeHomeCountryAddressId);
			} else {
				long employeeHomeCountryAddressId = doTransaction.insertADDRESSINFO(addAnEmployeeBean.getListAddress(1));
				log.info("EmployeeHomeCountry AddressId got :" + employeeHomeCountryAddressId);
				addAnEmployeeBean.setHomeCountryAddressId(employeeHomeCountryAddressId);
			}

			// Step 3: Inserting the Client Address
			isSameAsBusinessAddress = getStrAsRequestParameter("isSameAsBusinessAddress", request);
			if (isSameAsBusinessAddress != null && isSameAsBusinessAddress.equals("Y")) {
				// Get the Buiness Address
				Address businessAddress = doTransaction.getBusinessAddress(getBusinessId(request));
				long clientAddressId = doTransaction.insertADDRESSINFO(businessAddress);
				log.info("Client AddressId got :" + clientAddressId);
				addAnEmployeeBean.setClientAddressId(clientAddressId);
			} else {
				long clientAddressId = doTransaction.insertADDRESSINFO(addAnEmployeeBean.getListAddress(2));
				log.info("Client AddressId got :" + clientAddressId);
				addAnEmployeeBean.setClientAddressId(clientAddressId);
			}

			
			// Do Validation
		
			describeInstance(addAnEmployeeBean);
			BeanUtils.copyProperties(adminRegistrationBean, addAnEmployeeBean);
			long businessId = getUserProfile(request).getBusinessId();
			adminRegistrationBean.setBusinessId(businessId);
			long personalDetailsId = doTransaction.insertUSERPERSONALDATA(adminRegistrationBean, getUserProfile(request));
			log.info("UserPersonalDataId :" + personalDetailsId);
			adminRegistrationBean.setPersonalDetailsId(personalDetailsId);

			// Step 5: Inserting the Client Details - client Name and Work Start
			// Date - get the Client Id and update this in
			long clientId = doTransaction.insert_USER_CLIENTS_LIST(addAnEmployeeBean);
			adminRegistrationBean.setClientId(clientId);

			// Step 6: Inserting the Users - credentials
			adminRegistrationBean.setRole("MEMBER");
			adminRegistrationBean.setApprovalStatus(1);
			adminRegistrationBean.setIsEmailValidated(0);
			long userId = doTransaction.insertUSERS(adminRegistrationBean, getUserProfile(request));
			log.info("UserId :" + userId);
			adminRegistrationBean.setUserId(userId);

			// Step 7: Inserting the UserProfile which was uploaded.
			/*
			 * String docIds =
			 * getSpringCtxDoTransactionBean().uploadSingleFileToDB
			 * (adminRegistrationBean.getProfilePath(),1); DOCSFORSUPPORTING
			 * docsforsupporting = new DOCSFORSUPPORTING();
			 * docsforsupporting.setBusinessId
			 * (adminRegistrationBean.getBusinessId());
			 * docsforsupporting.setUserId(userId);
			 * docsforsupporting.setDocIds(docIds);
			 * docsforsupporting.setDocTypeId(1);
			 * describeInstance(docsforsupporting); int supportingDocId =
			 * getSpringCtxDoTransactionBean
			 * ().insert_DOCS_FOR_SUPPORTING(docsforsupporting);
			 * log.info("supportingDocId-->"+supportingDocId); int i =
			 * getSpringCtxDoTransactionBean
			 * ().update_USRPERSONALDATA_USR_PROFILE_ATTACHED_DOC_IDS(
			 * adminRegistrationBean.getPersonalDetailsId(), supportingDocId);
			 */
		} catch (Exception e) {
			e.printStackTrace();
			doTransaction.rollback();
		}
		doTransaction.commit();

		VMInputBean bean = new VMInputBean();
		bean.setText("validate");
		StringBuffer sb = getValidateUserEmail(request, adminRegistrationBean, bean);

		EmailDetails emailDetails = new EmailDetails();
		ArrayList<String> to = new ArrayList<String>();
		String emailId = adminRegistrationBean.getContactEmail();
		if(emailId!=null && emailId.length()>0)
		{
			to.add(emailId);
			emailDetails.setTo(to);
			emailDetails.setSubject("ILCH - Validate your email - "+adminRegistrationBean.getFirstName());
			emailDetails.setEmailContent(sb);
			sendEmail(emailDetails);
		}

		
		// notifyBusinessForMemberLoginApprovalPending(adminRegistrationBean);

//		EmailDetails emailDetails = new EmailDetails();
//		ArrayList<String> to = new ArrayList<String>();
//		String emailId = adminRegistrationBean.getContactEmail();
//		if (emailId != null && emailId.length() > 0) {
//			to.add(emailId);
//			emailDetails.setTo(to);
//			emailDetails.setSubject("Registration Status of " + adminRegistrationBean.getFirstName());
//			StringBuffer sb = getEmailContent(addAnEmployeeBean);
//			emailDetails.setEmailContent(sb);
//			sendEmail(emailDetails);
//		}
		request.setAttribute("generalAJAXMsg", "Employee Added Successfully. Employee must validate his/her email.");
		forward = mapping.findForward("generalJsp");
		return (forward);

	}

	private StringBuffer getEmailContent(AddAnEmployeeBean addAnEmployeeBean) {
		StringBuffer sb = new StringBuffer();

		sb.append("Thank you for registering in ILC. Your registration process is waiting for Approval from your employer. you can login, after you recieve an email confirmation of the registration approval.");
		return sb;
	}
	private StringBuffer getValidateUserEmail(HttpServletRequest request,
			AdminRegistrationBean adminRegistrationBean, VMInputBean bean) {

		int min = 11;
		int max = 35;
		
		String url = getApplicationURL(request);
		log.info("User Id --> {}", adminRegistrationBean.getUserId());
		UUID uuid = UUID.randomUUID();
		String key = String.valueOf(adminRegistrationBean.getUserId());
		Random randomGenerator = new Random();
		int randomInt = randomGenerator.nextInt(max - min + 1) + min;
		StringBuffer sb = new StringBuffer(randomInt + String.valueOf(uuid)
				+ "_" + String.valueOf((key)).length());
		sb.insert(randomInt - 2, key);

		url += "validateUserEmail.do?p=" + sb.toString();
		bean.setUrl(url);
		
		String emailBody = getEmailTemplate(bean,
				VMConstants.VM_ACTIVATE_REGISTRATION_NOTIFICATION);

		return new StringBuffer(emailBody);
	}
}
