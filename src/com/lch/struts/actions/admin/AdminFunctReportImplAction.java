package com.lch.struts.actions.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.generalBeans.UserProfile;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.formBeans.SearchOptions;

/**
 * @version 1.0
 * @author
 */
@SuppressWarnings("rawtypes")
public class AdminFunctReportImplAction extends BaseAction
{
	private static Logger log = LoggerFactory.getLogger(AdminFunctImplAction.class);
	public ActionForward doSearch(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("searchResult");
		SearchOptions searchOptions = (SearchOptions)form;
		ActionErrors messages = new ActionErrors();
		
		String SQL = prepareSQLQuery(searchOptions);
		if(SQL.equals("") || SQL.length() ==0)
		{
			messages.add("msg", new ActionMessage("invlaid.search.selection"));
			saveMessages(request, messages);
			forward = mapping.findForward("searchUsers");
		}
		
		log.info(SQL);
		return forward;
	}
	String prepareSQLQuery(SearchOptions searchOptions)
	{
		
		String lastName = searchOptions.getLastName();
		String lastNameRadio=searchOptions.getLastNameRadio();
		String firstNameRadio=searchOptions.getFirstNameRadio();
		String emailRadio=searchOptions.getEmailRadio();
		String zipCodeRadio=searchOptions.getZipCodeRadio();
		String firstName = searchOptions.getFirstName();
		String email = searchOptions.getEmail();
		String zipCode = searchOptions.getZipCode();
		String[] stateList = searchOptions.getStateList();
		String[]countryList = searchOptions.getCountryList();
		String[]cityList = searchOptions.getCityList();
		String[]clientWorkingForList = searchOptions.getClientWorkingForList();
		
		StringBuffer SQL=new StringBuffer("select * from userpersonaldata u where ");
		
		boolean isAddressCheck=false;
		if((clientWorkingForList ==null || clientWorkingForList.length ==0 ) && (stateList==null  || stateList.length==0) && (countryList==null || countryList.length==0) && (cityList==null || cityList.length==0))
		{
			if((lastName==null || lastName.length()==0 || lastName.equals(""))&&(firstName==null || firstName.length()==0 || firstName.equals(""))&&(email==null || email.length()==0 || email.equals(""))&&(zipCode==null || zipCode.length()==0 || zipCode.equals("")))
			{
				SQL=new StringBuffer();
				return SQL.toString();
			}
		}
		
		if((zipCode!=null && (zipCode.length()>0 && !zipCode.equals(""))) || (stateList!=null  && stateList.length>0)|| (countryList!=null && countryList.length>0) || (cityList!=null && cityList.length>0))
		{
			SQL=new StringBuffer("select * from userpersonaldata u, addressinfo a where ");
			isAddressCheck = true;
		}
		boolean isAndPlace=false;
		String AND =" and ";
		
		if(lastName!=null && !lastName.equals("") && lastName.length()>0 )
		{
			if(lastNameRadio.equals("like"))
			{
				
				SQL.append("u.lastname like '%"+lastName+"%"+"'");
			}
			else
			{
				SQL.append("u.lastname = '"+lastName+"'");
			}
			isAndPlace = true;
		}
		if(firstName!=null && !firstName.equals("") && firstName.length()>0 )
		{
			if(isAndPlace)
			{
				SQL.append(AND);
			}
			else
			{
				isAndPlace=true;
			}
			if(firstNameRadio.equals("like"))
			{
				SQL.append("u.firstName like '%"+firstName+"%"+"'");
			}
			else
			{
				SQL.append("u.firstName = '"+firstName+"'");
			}
		}
		if(email!=null && !email.equals("") && email.length()>0 )
		{
			if(isAndPlace)
			{
				SQL.append(AND);
			}
			else
			{
				isAndPlace=true;
			}
			if(emailRadio.equals("like"))
			{
				SQL.append("u.contactemail like '%"+firstName+"%"+"'");
			}
			else
			{
				SQL.append("u.contactemail = '"+firstName+"'");
			}
		}
		
		if(zipCode!=null && !zipCode.equals("") && zipCode.length()>0 )
		{
			if(isAndPlace)
			{
				SQL.append(AND);
			}
			else
			{
				isAndPlace=true;
			}
			if(zipCodeRadio.equals("like"))
			{
				SQL.append("a.zipCode like '%"+zipCode+"%"+"'");
			}
			else
			{
				SQL.append("a.zipCode = '"+zipCode+"'");
			}
		}
		
		if(clientWorkingForList!=null && clientWorkingForList.length>0 )
		{
			if(isAndPlace)
			{
				SQL.append(AND);
			}
			else
			{
				isAndPlace=true;
			}
			SQL.append(" u.clientWorkingFor in");
			SQL.append(getINString(clientWorkingForList));
		}
		if(cityList!=null && cityList.length>0 )
		{
			if(isAndPlace)
			{
				SQL.append(AND);
			}
			else
			{
				isAndPlace=true;
			}
			SQL.append(" a.city in");
			SQL.append(getINString(cityList));
		}
		if(stateList!=null && stateList.length>0 )
		{
			if(isAndPlace)
			{
				SQL.append(AND);
			}
			else
			{
				isAndPlace=true;
			}
			SQL.append(" a.state in");
			SQL.append(getINString(stateList));
		}
		if(isAddressCheck)
		{
			SQL.append(AND);
			SQL.append("u.myAddressId=a.idAddressInfo");
		}
		
		return SQL.toString();
	}
	String getINString(String[] list)
	{
		StringBuffer inString=new StringBuffer();
		int size= list.length;
		
		if(size>0)
		{
			inString.append("(");
			for(int i=0;i<size;++i)
			{
				inString.append("'");
				inString.append((String)list[i]);
				inString.append("'");
				if(!(i==size-1))
				{
					inString.append(",");
				}
			}
			inString.append(")");
			
		}
		return inString.toString();
	}
	
	public ActionForward searchOptions(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		UserProfile userProfile = getUserProfile(request);
		if(userProfile==null)
		{
			return(mapping.findForward("needAuthentication"));
		}
		
		long businessId = userProfile.getBusinessId();
		
		try{
			Object[] param = new Object[1];
			param[0]=businessId;
			List clientWorkingFor = getJDBCTemplate().queryForList(CLIENTWORKINGFORLIST,param);
			List city = getJDBCTemplate().queryForList(CITYLIST,param);
			List country = getJDBCTemplate().queryForList(COUNTRYLIST,param);
			List stateList=getJDBCTemplate().queryForList(STATELIST,param);
			
			SearchOptions searchOptions = new SearchOptions();
			searchOptions.setCountryList2Display(country);
			searchOptions.setCityList2Display(city);
			searchOptions.setClientWorkingForList2Display(clientWorkingFor);
			searchOptions.setStateList2Display(stateList);
			getSession(request).setAttribute("searchOptions",searchOptions);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		forward = mapping.findForward("searchUsers");
		return (forward);

	}
	String[] makeStringArray(List l)
	{
		int size= l.size();
		String inString[] = new String[size];
		
		if(size>0)
		{
			for(int i=0;i<size;++i)
			{
				inString[i]=(String)l.get(i);
			}
			
		}
		return inString;
	}
	public ActionForward listAllEmployees(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("listAllEmployees");
		return (forward);

	}
	public ActionForward calculateThisMonthRevenue(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-calculateThisMonthRevenue-TEST EXECUTED");
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("calculateThisMonthRevenue");
		return (forward);

	}
	public ActionForward reports(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("-reports-TEST EXECUTED");
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("reports");
		return (forward);

	}
	
	/*
	public ActionForward listStates(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		SearchOptions searchOptions = (SearchOptions)getSession(request).getAttribute("searchOptions");
		
		Object[] param = new Object[2];
		param[0]=getUserProfile(request).getBusinessId();
		param[1]=request.getParameter("country");
		List stateList=getJDBCTemplate().queryForList(STATELIST,param);
		searchOptions.setStateList(stateList);
		getSession(request).setAttribute("searchOptions",searchOptions);
		forward = mapping.findForward("searchForAnEmployee");
		return forward;
	}*/
	
}