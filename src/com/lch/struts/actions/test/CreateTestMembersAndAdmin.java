package com.lch.struts.actions.test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.lch.general.enums.TimeSheetTypes;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.formBeans.admin.AdminRegistrationBean;

public class CreateTestMembersAndAdmin extends BaseAction{

	private boolean isTestAdminAvailable()
	{
		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		int cnt = doTransaction.isTestUserAvailable("ilchadm123@gmail.com","admin");
		if(cnt > 0)
			return Boolean.TRUE;
		else
			return Boolean.FALSE;
	}
	private boolean isTestMembersAvailable()
	{

		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		
		int cnt = doTransaction.isTestUserAvailable("ilch.monthly.member@gmail.com","mem_monthly");
		if(cnt > 0)
			return Boolean.TRUE;
		else
			return Boolean.FALSE;
		
		
	}
	
	public ActionForward execute(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ActionForward forward = new ActionForward("status");
		if(isTestAdminAvailable() && isTestMembersAvailable())
		{
			putObjInRequest("status", request, "Test Users were alreday available");
		
		}
		else
		{
			putObjInRequest("status", request, "Test Users creation triggered Successfully, you need to validate them accordingly");
			// CREATE ADMIN
			AdminRegistrationBean bean = new AdminRegistrationBean();
			bean.setApprovalStatus(1);
			bean.setBusinessName("ALLIBILLI");
			bean.setClientWorkingFor("ADESA");
			bean.setContactEmail("ilchadm123@gmail.com");
			bean.setCountryCitizenship("USA");
			bean.setPhoneNumber("1231231233");
			bean.setFatherName("FATHER");
			bean.setFirstName("FIRSTNAME");
			bean.setGendar("MALE");
			bean.setWebsiteURL("www.allibilli.com");
			bean.setTimeSheetConfiguredTo(TimeSheetTypes.BIWEEKLY.name());
			bean.setStartDate("01/01/2012");
			bean.setDob("12-12-2012");
			bean.setRole("ADMIN");
			bean.setPassword("allibilli");
			bean.setMiddleName("Middle Name");
			bean.setLogin("admin");
			bean.setLastName("Last Name");
			putObjInSession("form", request,bean);
			
			request.getRequestDispatcher("/confirmRegistration.do").forward(request, response);
			
		}
		return forward;
	}
}
