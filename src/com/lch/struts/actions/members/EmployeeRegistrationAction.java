package com.lch.struts.actions.members;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.validator.routines.EmailValidator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.dbBeans.Address;
import com.lch.general.genericUtils.DescribeInstance;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.formBeans.admin.AdminRegistrationBean;
import com.lch.struts.formBeans.members.EmployeeRegistrationBean;

@SuppressWarnings({ "rawtypes", "unchecked" })
public class EmployeeRegistrationAction extends BaseAction {
	private static Logger log = LoggerFactory.getLogger(EmployeeRegistrationAction.class);

	public ActionForward getEmployerName(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String businessId = request.getParameter("ajaxParam");
		int bid = 0;
		String businessName = "";
		try {
			bid = new Integer(businessId).intValue();
			businessName = getEmployerName(bid);
			log.info("Got the Employer Name - " + businessName);
			putObjInRequest("generalAJAXMsg", request, businessName);
		} catch (Exception e) {
			//e.printStackTrace();
			log.debug("Employer Not found");
			bid = 0;
			putObjInRequest("generalAJAXMsg", request, "Employer Not found. Try again.");
			putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
		}

		return mapping.findForward("generalJSP4AJAXMsg");
	}

	public ActionForward checkUserNameAvailability(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String userName = request.getParameter("ajaxParam");
		
		String ajaxMsg = "";
		int usrCount = 0;
		try {
			if(userName == null || userName.trim().length() == 0)
			{
				putObjInRequest("generalAJAXMsg", request, "Invalid UserName");
				putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
				return mapping.findForward("generalJSP4AJAXMsg");
			}
			usrCount = getSpringCtxDoTransactionBean().checkUsrAvailablity(userName);
			log.info("No of Users available for with this User Name - " + usrCount);
			if (usrCount == 0) {
				ajaxMsg = "";
				putObjInRequest("generalAJAXMsg", request, ajaxMsg);
			} else {
				ajaxMsg = "Sorry, This UserName is not available";
				putObjInRequest("generalAJAXMsg", request, ajaxMsg);
				putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
			}

		} catch (Exception e) {
			e.printStackTrace();
			putObjInRequest("generalAJAXMsg", request, "Unable to Identify. Please Contact Us");
		}

		return mapping.findForward("generalJSP4AJAXMsg");
	}

	public ActionForward checkUserEmailAvailability(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String userEmail = request.getParameter("ajaxParam");
		String ajaxMsg = "";
		int usrCount = 0;

		if (userEmail == null) {
			putObjInRequest("generalAJAXMsg", request, "Invalid Email");
			putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
		}
		else if (userEmail.length() == 0) {
			putObjInRequest("generalAJAXMsg", request, "Invalid Email");
			putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
		} else {
			try {
				if (!EmailValidator.getInstance().isValid(userEmail)){
					putObjInRequest("generalAJAXMsg", request, "Invalid Email");
					putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
					return mapping.findForward("generalJSP4AJAXMsg");
				}
				usrCount = getSpringCtxDoTransactionBean().checkUsrEmailAvailablity(userEmail);
				log.info("No Of Users available for with this Email - " + usrCount);
				boolean valid = EmailValidator.getInstance().isValid(userEmail);
				if (usrCount == 0 && valid) {
					ajaxMsg = "";
					putObjInRequest("generalAJAXMsg", request, ajaxMsg);
				} else {
					ajaxMsg = "Already choosen email by some one else";
					putObjInRequest("generalAJAXMsg", request, ajaxMsg);
					putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
				}

			} catch (Exception e) {
				e.printStackTrace();
				putObjInRequest("generalAJAXMsg", request, "Unable to Identify. Please proceed next");
			}
		}
		return mapping.findForward("generalJSP4AJAXMsg");
	}

	public ActionForward srartRegistration(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("Employee Registration Process Starting");
		String cancel = request.getParameter("cancel");
		log.debug("Is Cancel Button status --->" + cancel);
		if (cancel != null) {
			return mapping.findForward("cancel");
		}
		String isSameAsBusinessAddress =request.getParameter("isSameAsBusinessAddress");
		
		if(isSameAsBusinessAddress!=null && isSameAsBusinessAddress.equals("Y"))
		{
			EmployeeRegistrationBean bean = (EmployeeRegistrationBean)form;
			bean.copyCurrentAddressToHomeCountryAddress();
		}
		return mapping.findForward("registrtationProcess2");
	}

	public ActionForward registrationProcess(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String cancel = request.getParameter("cancel");
		log.debug("Is Cancel Button status --->" + cancel);
		if (cancel != null) {
			return mapping.findForward("cancel");
		}
		String previous = request.getParameter("previous");
		if (previous != null) {
			return mapping.findForward("previous");
		}
		
		String isSameAsBusinessAddress =request.getParameter("isSameAsBusinessAddress");
		
		if(isSameAsBusinessAddress!=null && isSameAsBusinessAddress.equals("Y"))
		{
			EmployeeRegistrationBean bean = (EmployeeRegistrationBean)form;
			bean.copyBusinessAddressToClientAddress();
			DescribeInstance.describeInstance(bean.getClientAddress());
		}
		
		log.info("registrationProcess");
		return mapping.findForward("employeeRegistrationValidationPending");
	}

	public ActionForward getEmployeeDetailsForUpdate(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		putObjInRequest("isReqForEmpUpdate", request, "TRUE");
		forward = mapping.findForward("updateEmployeePersonalDetails");

		String userId = request.getParameter("userId");
		log.info("userId =" + userId);
		Map employeeDetailsMap = getSpringCtxDoTransactionBean().getEmployeeDetailsForUpdate(userId, String.valueOf(getUserProfile(request).getBusinessId()));
		if (employeeDetailsMap == null) {
			employeeDetailsMap = new HashMap();
			request.setAttribute("errMsg", "This operation is not allowed");
		}

		putObjInSession("employeeDetails", request, employeeDetailsMap);
		log.info("Result Map Details : " + employeeDetailsMap);

		return (forward);
	}

	public ActionForward updateEmployeePersonalDetails(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("Employee personl details updation Process Starting");
		String cancel = request.getParameter("cancel");
		log.debug("Is Cancel Button status --->" + cancel);
		if (cancel != null) {
			return mapping.findForward("cancel");
		}
		EmployeeRegistrationBean employeeRegistrationBean = (EmployeeRegistrationBean) form;
		long userId = getLongAsRequestParameter("userId", request);
		long businessId = getLongAsRequestParameter("businessId", request);
		long myAddressId = getLongAsRequestParameter("myAddressId", request);
		long clientAddressId = getLongAsRequestParameter("clientAddressId", request);
		long homeCountryAddressId = getLongAsRequestParameter("homeCountryAddressId", request);
		Address listAddress1 = employeeRegistrationBean.getListAddress(0);
		Address listAddress2 = employeeRegistrationBean.getListAddress(1);
		Address listAddress3 = employeeRegistrationBean.getListAddress(2);

		listAddress1.setIdAddressInfo(myAddressId);
		getSpringCtxDoTransactionBean().updateAddress(listAddress1);

		listAddress2.setIdAddressInfo(homeCountryAddressId);
		getSpringCtxDoTransactionBean().updateAddress(listAddress2);

		listAddress3.setIdAddressInfo(clientAddressId);
		getSpringCtxDoTransactionBean().updateAddress(listAddress3);

		Map data = new HashMap();
		data.put("firstName", employeeRegistrationBean.getFirstName());
		data.put("middleName", employeeRegistrationBean.getMiddleName());
		data.put("lastName", employeeRegistrationBean.getLastName());
		data.put("phoneNumber", employeeRegistrationBean.getPhoneNumber());
		data.put("contactEmail", employeeRegistrationBean.getContactEmail());
		data.put("fatherName", employeeRegistrationBean.getFatherName());
		data.put("countryCitizenship", employeeRegistrationBean.getCountryCitizenship());
		data.put("dob", employeeRegistrationBean.getDob());
		data.put("timeSheetConfiguredTo", employeeRegistrationBean.getTimeSheetConfiguredTo());
		data.put("dob", employeeRegistrationBean.getDob());
		data.put("clientName", employeeRegistrationBean.getClientName());
		data.put("startDate", employeeRegistrationBean.getStartDate());
		data.put("userId", userId);
		data.put("businessId", businessId);
		log.info("Personal data  :" + data);
		getSpringCtxDoTransactionBean().update_employee_personal_data(data);

		return mapping.findForward("employeeUpdationSuccessful");
	}

	public ActionForward empRegCanclation(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("empRegCanclation");
		return (forward);
	}
}
