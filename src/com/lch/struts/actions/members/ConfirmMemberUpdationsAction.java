package com.lch.struts.actions.members;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.dbBeans.Address;
import com.lch.general.generalBeans.UserProfile;
import com.lch.spring.BusinessComponents.UpdateUserSession;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.formBeans.members.UpdateMemberFormBean;

public class ConfirmMemberUpdationsAction extends BaseAction {

	private static Logger log = LoggerFactory
			.getLogger(EmployeeRegistrationAction.class);

	public ActionForward updateMemberProfileDetails(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		try{
		UpdateMemberFormBean bean = (UpdateMemberFormBean) form;
		// describeInstance(bean);

		// long userId = getIntAsRequestParameter("userId", request);
		// long businessId = getIntAsRequestParameter("businessId", request);
		long userId = getUserProfile(request).getUserId();
		long businessId = getUserProfile(request).getBusinessId();
		long myAddressId = getLongAsRequestParameter("myAddressId", request);
		// int myAddressId=bean.getMyAddressId();
		// int homeCountryAddressId=bean.getHomeCountryAddressId();
		long homeCountryAddressId = getLongAsRequestParameter(
				"homeCountryAddressId", request);
		Address listAddress1 = bean.getListAddress(0);
		Address listAddress2 = bean.getListAddress(1);

		listAddress1.setIdAddressInfo(myAddressId);
		getSpringCtxDoTransactionBean().updateAddress(listAddress1);

		listAddress2.setIdAddressInfo(homeCountryAddressId);
		getSpringCtxDoTransactionBean().updateAddress(listAddress2);

		Map<String, Object> data = new HashMap<String, Object>();
		data.put("firstName", bean.getFirstName());
		data.put("middleName", bean.getMiddleName());
		data.put("lastName", bean.getLastName());
		data.put("gendar", bean.getGendar());
		//data.put("contactEmail", bean.getContactEmail());
		data.put("phoneNumber", bean.getPhoneNumber());
		data.put("fatherName", bean.getFatherName());
		data.put("countryCitizenship", bean.getCountryCitizenship());
		data.put("dob", bean.getDob());
		data.put("timeSheetConfiguredTo", bean.getTimeSheetConfiguredTo());
		data.put("userId", userId);
		data.put("businessId", businessId);
		log.info("Personal data  :" + data);
		getSpringCtxDoTransactionBean().update_member_personal_data(data);

		UpdateUserSession userSession = (UpdateUserSession) getSpringCTX().getBean("sessionUpdate");
		UserProfile up = getUserProfile(request);
		userSession.updateSession(up);
		putObjInRequest("memberUpdationSuccessful", request, "yes");
		}
		catch(Exception e)
		{
			putObjInRequest("memberUpdationSuccessful", request, "no");
		}
		return mapping.findForward("memberFunctions");
	}

}
