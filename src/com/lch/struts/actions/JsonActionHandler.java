package com.lch.struts.actions;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.struts.actions.admin.AdminFunctImplAction;

public class JsonActionHandler extends BaseAction {

	private static Logger log = LoggerFactory.getLogger(AdminFunctImplAction.class);

	class JSONBean{
		public String firstName;
		public List<Map<String, Object>>  children; 
	}

	public ActionForward radialListing(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		if(isEmployer(request))
		{
			List<Map<String, Object>>  list = getSpringCtxDoTransactionBean().getAllMyEmployees_id_name(getBusinessId(request));
			JSONBean bean = new JSONBean();
			bean.children = list;
			bean.firstName = getEmployerName(getBusinessId(request));
			String json = getJson(bean);
			//log.info("{} - \n {}", getBusinessId(request), json);
			putAjaxStatusObjInRequest(request, json);
		}
		else {
			putAjaxStatusObjInRequest(request, "Don't Fish us! We are your friends.");
		}
		
		forward = mapping.findForward("generalJSP4AJAXMsg");
		return (forward);
		
	}
	
}
