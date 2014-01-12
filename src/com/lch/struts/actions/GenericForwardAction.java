package com.lch.struts.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.tiles.TilesUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.filter.LogFilter;
import com.lch.general.generalBeans.UserProfile;

/**
 * @version 1.0
 * @author
 */
public class GenericForwardAction extends BaseAction 
{
	private static Logger log = LoggerFactory.getLogger(GenericForwardAction.class);
	
	public ActionForward execute(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("forwardTo");
		String forwardTo = request.getParameter("forwardTo");
		if(forwardTo.indexOf(".")==-1)
		{
			forwardTo+=".jsp";
		}
		
		
		forwardTo= "/WEB-INF/"+forwardTo;
		log.info("Forwarding to: "+forwardTo);
		
		UserProfile userProfile = getUserProfile(request);
		boolean isToFilter = Boolean.FALSE;
		
		for (String action : LogFilter.actionsToIgnore) {
			if (forwardTo.endsWith(action) || forwardTo.indexOf(action)!=-1) {
				isToFilter = Boolean.TRUE;
				break;
			}
		}
		if(isToFilter)
		{
			TilesUtil.getDefinitionsFactory(request, getServlet().getServletContext()).getDefinition("generalForwardDef", request, getServlet().getServletContext()).put("body", forwardTo);
			return forward;
		}
		else if(userProfile.isAdmin()) {
			if(forwardTo.indexOf("admin")==-1)
			request.getSession().getServletContext().getRequestDispatcher("/signoutAction.do").forward(request, response);
		}
		else if (userProfile.isMember()){
			if(forwardTo.indexOf("member")==-1){
				request.getSession().getServletContext().getRequestDispatcher("/signoutAction.do").forward(request, response);
			}
		}
		TilesUtil.getDefinitionsFactory(request, getServlet().getServletContext()).getDefinition("generalForwardDef", request, getServlet().getServletContext()).put("body", forwardTo);
		return forward;
	}
	
}