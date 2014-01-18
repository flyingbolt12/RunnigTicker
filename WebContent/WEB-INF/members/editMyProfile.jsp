<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>

<style>
.EmployeeTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }
.EmployeeDisabledTextBox { font-family: Tahoma; font-size: 10pt; color: #CCCCCC; 
               border: 1px solid #C0C0C0; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }
               

</style>
<%-- <html:errors/> --%>
<% 
    Map m = (Map) session.getAttribute("myProfileDetails");
	Map  FETCH_EMPLOYEE_PERSONAL_ADDRESS = (Map)m.get("FETCH_EMPLOYEE_PERSONAL_ADDRESS");
    Map  FETCH_EMPLOYEE_PROFILE_DETAILS = (Map)m.get("FETCH_EMPLOYEE_PROFILE_DETAILS");
	Map  FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS=(Map)m.get("FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS");
	
	String firstName ="";
	String middleName="";
	String lastName="";
	String emailId="";
	String phoneNumber="";
	String fatherName="";
	String countryCitizenship="";
	String dob="";
	String timeSheetConfiguredTo="";
	String gendar="";
	String current_address1="";
	String current_address2="";
	String current_city="";
	String current_state="";
	String current_country="";
	String current_zipcode="";
	
	String home_country_address1="";
	String home_country_address2="";
	String home_country_city="";
	String home_country_state="";
	String home_country_country="";
	String home_country_zipcode="";
	String userId="";
	String businessId="";
	String myAddressId="";
	String homeCountryAddressId="";
	if(FETCH_EMPLOYEE_PROFILE_DETAILS!=null)
	{
		firstName = (String)FETCH_EMPLOYEE_PROFILE_DETAILS.get("firstName") ;
		middleName = (String)FETCH_EMPLOYEE_PROFILE_DETAILS.get("middleName");
		lastName = (String)FETCH_EMPLOYEE_PROFILE_DETAILS.get("lastName");
		emailId = (String)FETCH_EMPLOYEE_PROFILE_DETAILS.get("contactEmail");
		phoneNumber = (String)FETCH_EMPLOYEE_PROFILE_DETAILS.get("phoneNumber");
		fatherName = (String)FETCH_EMPLOYEE_PROFILE_DETAILS.get("fatherName");
		countryCitizenship = (String)FETCH_EMPLOYEE_PROFILE_DETAILS.get("countryCitizenship");
		dob = (String)FETCH_EMPLOYEE_PROFILE_DETAILS.get("dob")+""; ;
		timeSheetConfiguredTo = (String)FETCH_EMPLOYEE_PROFILE_DETAILS.get("timeSheetConfiguredTo") ;
		gendar=(String)FETCH_EMPLOYEE_PROFILE_DETAILS.get("gendar");
	}
	if(FETCH_EMPLOYEE_PERSONAL_ADDRESS!=null)
	{
		myAddressId=String.valueOf(FETCH_EMPLOYEE_PERSONAL_ADDRESS.get("idAddressInfo")) ;
		current_address1 = (String)FETCH_EMPLOYEE_PERSONAL_ADDRESS.get("address1") ;
		current_address2 = (String)FETCH_EMPLOYEE_PERSONAL_ADDRESS.get("address2") ;
		current_city = (String)FETCH_EMPLOYEE_PERSONAL_ADDRESS.get("city") ;
		current_state = (String)FETCH_EMPLOYEE_PERSONAL_ADDRESS.get("state") ;
		current_country = (String)FETCH_EMPLOYEE_PERSONAL_ADDRESS.get("country") ;
		current_zipcode = (String)FETCH_EMPLOYEE_PERSONAL_ADDRESS.get("zipcode") ;
	}
	if(FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS!=null)
	{
		homeCountryAddressId = String.valueOf(FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS.get("idAddressInfo")) ;
		home_country_address1 = (String)FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS.get("address1") ;
		home_country_address2 = (String)FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS.get("address2") ;
		home_country_city = (String)FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS.get("city") ;
		home_country_state = (String)FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS.get("state") ;
		home_country_country = (String)FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS.get("country") ;
		home_country_zipcode = (String)FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS.get("zipcode") ;
	}
	
	%>

<div align="center">

<% boolean isRreadOnly=true; String errMsg="";%>

<html:form action="confirmMemberUpdation.do?parameter=updateMemberProfileDetails"  enctype="multipart/form-data" >
<html:hidden property="myAddressId" value="<%=myAddressId %>"/>
<html:hidden property="businessId" value="<%=businessId%>"/>
<html:hidden property="homeCountryAddressId" value="<%=homeCountryAddressId %>"/>
<html:hidden property="userId" value="<%=userId%>"/>
<input type="hidden"  name="parameter" value="">
	
<table border="0" cellspacing="1" width="819" height="800" style="font-family: Tahoma; font-size: 10pt" class="registration">
		<%
if( request.getAttribute("errMsg")!=null)
{%>

	<tr>
		<td height="10" width="100%" bgcolor="#000000" colspan="3">
		<p align="center"><font color="red"><b><%=request.getAttribute("errMsg") %></b></font></td>
	</tr>
	<%	}else{
		
%>
	<tr>
		<td height="18" width="892" bgcolor="#ADADAD" colspan="3">

		<p align="center"><font color="#FFFFFF"><b>Edit my Profile</b></font></td>
	</tr>
	<tr>
		<td height="4" width="892"  colspan="3"></td>
	</tr>
	<tr>
		<td height="18" width="223"  align="left" colspan="3">
		<p><span style="font-size: 10.0pt">User Details</span></td>

		
	</tr>
	<tr>
		<td height="271" width="223" rowspan="9">&nbsp;</td>
		<td height="18" width="208">
		<span style="font-size: 10.0pt; font-family: Tahoma">First Name<font color="#FF0000">*</font></span></td>
		<td height="18" width="396">
		
		
		<font face="Tahoma">
		<html:messages id="err_name" property="firstName">
			<% errMsg = err_name; %>
		</html:messages>
	
	<html:text property="firstName" value="<%= (errMsg!=null && errMsg.length() > 0)?\"\":firstName%>"  styleClass="EmployeeTextBox"  size="20" tabindex="1" ></html:text><%=errMsg %>
	
		<%
		errMsg=""; 
		 %>
	</font></td>
	</tr>

	<tr>
	<td height="18" width="208" >
	<span style="font-size: 10.0pt; ">Middle Name</span></td>		
		<td height="18" width="396" >
		
		<font face="Tahoma">
		
		<html:text property="middleName" value="<%=middleName%>"  styleClass="EmployeeTextBox" size="20" tabindex="2"></html:text>
		 </font></td>
    </tr>
    <tr>
	    <td height="18" width="208">
		<span style="font-size: 10.0pt; font-family: Tahoma">Last Name<font color="#FF0000">*</font></span></td>

		<td height="18" width="396">
		
		<font face="Tahoma">
		<html:messages id="err_name" property="lastName">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="lastName" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":lastName%>"  styleClass="EmployeeTextBox" size="20" tabindex="3"></html:text><%=errMsg %><%
		errMsg=""; 
		 %></font></td>
    </tr>
    <tr>
	    <td height="24" width="208" >
		Gender</td>
		<td height="24" width="396" >
<font face="Tahoma">
		<html:select property="gendar" value="<%=gendar%>" size="0" tabindex="4" styleClass="EmployeeTextBox" >
			<option value="MALE" >MALE</option>
			<option value="FEMALE">FEMALE</option>
		</html:select></font>
	</td>
    </tr>

	<tr>
	    <td height="18" width="208" >
		<span style="font-size: 10.0pt; font-family: Tahoma">Email-Id<font color="#FF0000">*</font></span></td>
		<td height="18" width="396" >
		
		<font face="Tahoma">
		<html:messages id="err_name" property="contactEmail">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="contactEmail" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":emailId%>"  styleClass="EmployeeDisabledTextBox" size="20" tabindex="6" readonly="true"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td>

    </tr>
    
	<tr>

	    <td height="18" width="208">
	<span style="font-size: 10.0pt; ">Phone Number<font color="#FF0000">*</font></span></td>		
		<td height="18" width="396">
		
		<font face="Tahoma">
		
		<html:text property="phoneNumber" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":phoneNumber%>"  styleClass="EmployeeTextBox" size="20" tabindex="7"></html:text>
		 </font></td>

    </tr>
	<tr>
	    <td height="18" width="208" >
		<span style="font-size: 10.0pt; font-family: Tahoma">Father Name</span></td>

		<td height="18" width="396" >
		
		<font face="Tahoma">
		<html:messages id="err_name" property="fatherName">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="fatherName" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":fatherName%>"  styleClass="EmployeeTextBox" size="20" tabindex="8"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td>

    </tr>

	<tr>
	    <td height="18" width="208" >
		<span style="font-size: 10.0pt; font-family: Tahoma">Country Citizenship</span></td>
		<td height="18" width="396" >
		
		<font face="Tahoma">
		<html:messages id="err_name" property="countryCitizenship">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="countryCitizenship" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":countryCitizenship%>"  styleClass="EmployeeTextBox" size="20" tabindex="10"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td>

    </tr>
    <tr>

	    <td height="18" width="208">
		<span style="font-size: 10.0pt; font-family: Tahoma">Submit TimeSheets</span></td>
		<td height="18" width="396">
		
		<font face="Tahoma">
		<html:messages id="err_name" property="timeSheetConfiguredTo">
			<% errMsg = err_name; %>
		</html:messages>
		<html:select property="timeSheetConfiguredTo" styleClass="EmployeeTextBox" size="1" tabindex="14" value="<%=timeSheetConfiguredTo %>">
		<html:option value="MONTHLY"></html:option>
		<html:option value="BIWEEKLY"></html:option>
		<html:option value="DAYS15"></html:option>
		<html:option value="WEEKLY"></html:option>
		</html:select>
		<%=errMsg %>
		<%
		errMsg=""; 
		 %></font>

		 </td>

    </tr>

    <tr>
		<td height="18" width="223" colspan="3" align="left">
		<span style="font-size: 10.0pt">Employee Current&nbsp; Address<font color="#FF0000">*</font></span></td>

	</tr>
	
	<tr>
		<td height="113" width="223" rowspan="6"></td>		
		<td height="18" width="208"  align="left" >
		<p class="MsoNormal"><span style="font-size: 10.0pt">Address 1:</span></td>
		<td height="18" width="223" align="left" >
		
		<font face="Tahoma">
		<html:messages id="err_name" property="listAddress[0].address1">
			<% errMsg = err_name; %>
		</html:messages>
		
<html:text property="listAddress[0].address1" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":current_address1%>" styleClass="EmployeeTextBox" size="45" tabindex="20"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td>

	</tr>

	<tr>
		<td height="18" width="118" align="left">
		<p class="MsoNormal"><span style="font-size: 10.0pt">Address 2:</span></td>
		<td height="18" width="480" align="left">
		<font face="Tahoma">
			
	<html:text property="listAddress[0].address2" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":current_address2%>" styleClass="EmployeeTextBox" size="45" tabindex="21"></html:text></font></td>
	</tr>
	
	<tr>
		<td height="18" width="208" >

	<span style="font-size: 10.0pt; ">City</span></td>		
		<td height="18" width="396" >
		
		<font face="Tahoma">
		<html:messages id="err_name" property="listAddress[0].city">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="listAddress[0].city" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":current_city%>" styleClass="EmployeeTextBox" size="20" tabindex="21"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td></tr>
	<tr>
		<td height="18" width="208">
		<span style="font-size: 10.0pt; font-family: Tahoma">State</span></td>
		<td height="18" width="396">
		
		<font face="Tahoma">
		<html:messages id="err_name" property="listAddress[0].state">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="listAddress[0].state" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":current_state%>" styleClass="EmployeeTextBox" size="20" tabindex="21" onblur="verifyState(this)"></html:text><%=errMsg %><span id="state"></span>
		<%
		errMsg=""; 
		 %></font></td>
	</tr>
	<tr>
		<td height="18" width="208" >
	<span style="font-size: 10.0pt; ">Country</span></td>		
		<td height="18" width="396" >
		
		<font face="Tahoma">
		<html:messages id="err_name" property="listAddress[0].country">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="listAddress[0].country" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":current_country%>" styleClass="EmployeeTextBox" size="20" tabindex="21"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td>
	</tr>
	<tr>
		<td height="18" width="208">

		<span style="font-size: 10.0pt; font-family: Tahoma">Zip</span></td>
		<td height="18" width="396">
		<font face="Tahoma">
		<html:messages id="err_name" property="listAddress[0].zip">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="listAddress[0].zip" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":current_zipcode%>" styleClass="EmployeeTextBox" size="20" tabindex="21"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td>
	</tr>
	
	<tr>
		<td height="18" width="223" colspan="3" align="left" >
		<span style="font-size: 10.0pt">Employee Home Country Address<font color="#FF0000">*</font></span></td>

	</tr>
	<tr>
		<td height="113" width="223" rowspan="6" ></td>		
		<td height="18" width="208"  align="left">
		<p class="MsoNormal"><span style="font-size: 10.0pt">Address 1:</span></td>
		<td height="18" width="223" align="left">
		
		<font face="Tahoma">
		<html:messages id="err_name" property="listAddress[1].address1">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="listAddress[1].address1" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":home_country_address1%>" styleClass="EmployeeTextBox" size="45" tabindex="20"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td>
	</tr>

	<tr>
		<td height="18" width="118" align="left"  >
		<p class="MsoNormal"><span style="font-size: 10.0pt">Address 2:</span></td>
		<td height="18" width="480" align="left" >
		<font face="Tahoma">
		
		<html:text property="listAddress[1].address2" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":home_country_address2%>" styleClass="EmployeeTextBox" size="45" tabindex="20"></html:text></font></td>
	</tr>
	<tr>
		<td height="18" width="208">

	<span style="font-size: 10.0pt; ">City</span></td>		
		<td height="18" width="396">
		
		<font face="Tahoma">
		<html:messages id="err_name" property="listAddress[1].city">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="listAddress[1].city" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":home_country_city%>" styleClass="EmployeeTextBox" size="20" tabindex="20"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td></tr>
	<tr>
		<td height="18" width="208" >
		<span style="font-size: 10.0pt; font-family: Tahoma">State</span></td>
		<td height="18" width="396" >
		<font face="Tahoma">
		<html:messages id="err_name" property="listAddress[1].state">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="listAddress[1].state" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":home_country_state%>" styleClass="EmployeeTextBox" size="20" tabindex="20"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td>

	</tr>
	<tr>
		<td height="18" width="208">
	<span style="font-size: 10.0pt; ">Country</span></td>		
		<td height="18" width="396">
		
		<font face="Tahoma">
		<html:messages id="err_name" property="listAddress[1].country">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="listAddress[1].country" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":home_country_country%>" styleClass="EmployeeTextBox" size="20" tabindex="20"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td>

	</tr>
	<tr>
		<td height="18" width="208"  >

		<span style="font-size: 10.0pt; font-family: Tahoma">Zip</span></td>
		<td height="18" width="396" >
		
		<font face="Tahoma">
		<html:messages id="err_name" property="listAddress[1].zip">
			<% errMsg = err_name; %>
		</html:messages>
		<html:text property="listAddress[1].zip" value="<%= (errMsg!=null && errMsg.length()>0)?\"\":home_country_zipcode%>" styleClass="EmployeeTextBox" size="20" tabindex="20"></html:text><%=errMsg %>
		<%
		errMsg=""; 
		 %></font></td>

	</tr>
	
	<tr>
		<td height="2" width="245"  colspan="2" ></td>
	</tr>
	<tr>
	    <td height="18" width="165" ></td>
		<td height="18" width="208" ></td>
	<td height="18" width="769" >
		<font face="Tahoma">
		<html:submit   property="update" value="Update"  styleClass="ButtonStyle" tabindex="44"></html:submit></font>
		<font face="Tahoma">

		<html:submit property="cancel"  value="Cancel"  onclick="cancelUpdation()" styleClass="ButtonStyle" tabindex="45"></html:submit></font>
		</td>
	</tr>
		<%} %>
	</table>
	</html:form>
	</div>
	
	<script>
	function cancelUpdation()
	{  
      document.forms[0].action="memberFunctImpl.do";
      document.forms[0].parameter.value="memberUpdationForCacel";
      document.forms[0].submit();
		
	}
	
	</script>	
	
	