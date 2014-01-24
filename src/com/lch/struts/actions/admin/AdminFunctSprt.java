package com.lch.struts.actions.admin;

import java.util.List;

import com.lch.struts.formBeans.SearchOptions;

public abstract class AdminFunctSprt {
	public static String prepareSQLQuery(SearchOptions searchOptions)
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
		
		StringBuffer SQL=new StringBuffer("select *, (SELECT concat('(T)',totalHrsSubmitted,' / ',' (R) ',totalRegularHrs,' / ', ' (O) ',totalOvertimeHrs,' / ','(H) ',totalHolidayHrs,' -- ',startWeekDate,' : ',endWeekDate) FROM weeklyhrssummary where weeklyHrsSummaryId=(select max(weeklyHrsSummaryId) from weeklyhrssummary where userId=users.idUser)) as recentHrs, (select concat(address1,', ',address2,', ',city,', ',state,', ',zipcode)  from addressinfo a where a.idAddressInfo=userpersonaldataTable.myAddressId) as personalAddress ,(select concat(address1,', ',address2,', ',city,', ',state,', ',zipcode)  from addressinfo a where a.idAddressInfo=userpersonaldataTable.clientAddressId) as cleintAddress from userpersonaldata userpersonaldataTable, users users, userclientslist clientsList where ");
		
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
			SQL=new StringBuffer("select * , (SELECT concat('(T)',totalHrsSubmitted,' / ',' (R) ',totalRegularHrs,' / ', ' (O) ',totalOvertimeHrs,' / ','(H) ',totalHolidayHrs,' -- ',startWeekDate,' : ',endWeekDate) FROM weeklyhrssummary where weeklyHrsSummaryId=(select max(weeklyHrsSummaryId) from weeklyhrssummary where userId=users.idUser)) as recentHrs, (select concat(address1,', ',address2,', ',city,', ',state,', ',zipcode)  from addressinfo a where a.idAddressInfo=userpersonaldataTable.myAddressId) as personalAddress ,(select concat(address1,', ',address2,', ',city,', ',state,', ',zipcode)  from addressinfo a where a.idAddressInfo=userpersonaldataTable.clientAddressId) as cleintAddress from userpersonaldata userpersonaldataTable, addressinfo a, users users, userclientslist clientsList where ");
			isAddressCheck = true;
		}
		boolean isAndPlace=false;
		String AND =" and ";
		
		if(lastName!=null && !lastName.equals("") && lastName.length()>0 )
		{
			if(lastNameRadio.equals("like"))
			{
				
				SQL.append("userpersonaldataTable.lastname like '%"+lastName+"%"+"'");
			}
			else
			{
				SQL.append("userpersonaldataTable.lastname = '"+lastName+"'");
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
				SQL.append("userpersonaldataTable.firstName like '%"+firstName+"%"+"'");
			}
			else
			{
				SQL.append("userpersonaldataTable.firstName = '"+firstName+"'");
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
				SQL.append("userpersonaldataTable.contactemail like '%"+email+"%"+"'");
			}
			else
			{
				SQL.append("userpersonaldataTable.contactemail = '"+email+"'");
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
			SQL.append(" clientsList.clientName in");
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
			if(isAndPlace)
			{
				SQL.append(AND);
			}
			else
			{
				isAndPlace=true;
			}
//			SQL.append(AND);
			SQL.append("userpersonaldataTable.myAddressId=a.idAddressInfo");
		}
		return SQL.toString();
	}
	 static String getINString(String[] list)
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
			inString.append(") ");
			
		}
		return inString.toString();
	}
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private static String[] makeStringArray(List l)
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
}
