<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<style>
.EmployeeTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }

</style>

<% 
	Map m = (Map) session.getAttribute("employeeDetails");
	Map  FETCH_EMPLOYEE_PERSONAL_ADDRESS = (Map)m.get("FETCH_EMPLOYEE_PERSONAL_ADDRESS");
	Map  FETCH_EMPLOYEE_CLEINT_ADDRESS = (Map)m.get("FETCH_EMPLOYEE_CLIENT_ADDRESS");
	Map  FETCH_EMPLOYEE_PERSONAL_DETAILS = (Map)m.get("FETCH_EMPLOYEE_PERSONAL_DETAILS");
	Map  FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS=(Map)m.get("FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS");
	Map  FETCH_EMPLOYEE_CLIENT_DETAILS=(Map)m.get("FETCH_EMPLOYEE_CLIENT_DETAILS");
	Map  FETCH_BUSINESS_NAME=(Map)m.get("FETCH_BUSINESS_NAME");
	
	String firstName ="";
	String middleName="";
	String lastName="";
	String emailId="";
	String phoneNumber="";
	String fatherName="";
	String countryCitizenship="";
	String dob="";
	String profilePath="";
	String businessId="";
	String businessName="";
	String workingClientId="";
	
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
	
	String client_address1="";
	String client_address2="";
	String client_city="";
	String client_state="";
	String client_country="";
	String client_zipcode="";
	
	
	String client_name = "";
	String client_startDate= "";
	
	String myAddressId="";
	String clientAddressId="";
	String homeCountryAddressId="";
	
	if(FETCH_EMPLOYEE_PERSONAL_DETAILS!=null)
	{
		firstName = (String)FETCH_EMPLOYEE_PERSONAL_DETAILS.get("firstName") ;
		middleName = (String)FETCH_EMPLOYEE_PERSONAL_DETAILS.get("middleName");
		lastName = (String)FETCH_EMPLOYEE_PERSONAL_DETAILS.get("lastName");
		emailId = (String)FETCH_EMPLOYEE_PERSONAL_DETAILS.get("contactEmail");
		phoneNumber = (String)FETCH_EMPLOYEE_PERSONAL_DETAILS.get("emergencyPhoneNumber");
		fatherName = (String)FETCH_EMPLOYEE_PERSONAL_DETAILS.get("fatherName");
		countryCitizenship = (String)FETCH_EMPLOYEE_PERSONAL_DETAILS.get("countryCitizenship");
		dob = (String)FETCH_EMPLOYEE_PERSONAL_DETAILS.get("dob")+""; ;
		profilePath=(String)FETCH_EMPLOYEE_PERSONAL_DETAILS.get("profilePath");
		workingClientId = (String)FETCH_EMPLOYEE_PERSONAL_DETAILS.get("workingClientId")+""; ;
		businessId = FETCH_EMPLOYEE_PERSONAL_DETAILS.get("businessId")+"";	
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
	if(FETCH_EMPLOYEE_CLEINT_ADDRESS!=null)
	{
		clientAddressId=String.valueOf(FETCH_EMPLOYEE_CLEINT_ADDRESS.get("idAddressInfo")) ;
		client_address1 = (String)FETCH_EMPLOYEE_CLEINT_ADDRESS.get("address1") ;
		client_address2 = (String)FETCH_EMPLOYEE_CLEINT_ADDRESS.get("address2") ;
		client_city = (String)FETCH_EMPLOYEE_CLEINT_ADDRESS.get("city") ;
		client_state = (String)FETCH_EMPLOYEE_CLEINT_ADDRESS.get("state") ;
		client_country = (String)FETCH_EMPLOYEE_CLEINT_ADDRESS.get("country") ;
		client_zipcode = (String)FETCH_EMPLOYEE_CLEINT_ADDRESS.get("zipcode") ;
	}
	if(FETCH_EMPLOYEE_CLIENT_DETAILS!=null)
	{
		client_name = (String)FETCH_EMPLOYEE_CLIENT_DETAILS.get("clientName") ;
		client_startDate= (String)FETCH_EMPLOYEE_CLIENT_DETAILS.get("startDate") ;
	}
	if(FETCH_BUSINESS_NAME!=null)
	{
		businessName = (String)FETCH_BUSINESS_NAME.get("businessName") ;
	}
%>
<div align="center">
<html:form action="/employeeRegistration.do" enctype="multipart/form-data">

<html:hidden property="myAddressId" value="<%=myAddressId %>"/>
<html:hidden property="clientAddressId" value="<%=clientAddressId %>"/>
<html:hidden property="homeCountryAddressId" value="<%=homeCountryAddressId %>"/>
<html:hidden property="businessId" value="<%=businessId%>"/>
<html:hidden property="userId" value="<%=request.getParameter(\"userId\") %>"/>
<html:hidden property="parameter" value="updateEmployeePersonalDetails"/>

<table border="0" cellspacing="1" width="819" style="font-family: Tahoma; font-size: 10pt">
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
		<p align="center"><font color="#FFFFFF"><b>Update Employee Details</b></font></td>
	</tr>
	<tr>
		<td height="4" width="892"  colspan="3"></td>
	</tr>
	<tr>
		<td height="18" width="223" bgcolor="#F4F4F4" align="left" colspan="3">
		<p><span style="font-size: 10.0pt">User Details</span></td>
		
	</tr>
	<tr>
		<td height="322" width="223" rowspan="13">&nbsp;</td>
		<td height="22" width="208">
		<span style="font-size: 10.0pt; font-family: Tahoma">First Name<font color="#FF0000">*</font></span></td>
		<td height="22" width="396">
		
		<html:text property="firstName" value="<%=firstName%>"  styleClass="EmployeeTextBox" size="20" tabindex="1"></html:text></td>
	</tr>
	<tr>
	<td height="22" width="208" bgcolor=#F4F4F4>
	<span style="font-size: 10.0pt; ">Middle Name</span></td>		
		<td height="22" width="396" bgcolor=#F4F4F4>
		<html:text property="middleName" value="<%= middleName%>" styleClass="EmployeeTextBox" size="20" tabindex="2"></html:text></td>
    </tr>
    <tr>
	    <td height="22" width="208">
		<span style="font-size: 10.0pt; font-family: Tahoma">Last Name<font color="#FF0000">*</font></span></td>
		<td height="22" width="396">
		<html:text property="lastName" value="<%=lastName%>" styleClass="EmployeeTextBox" size="20" tabindex="3"></html:text></td>
    </tr>
	<tr>
	    <td height="22" width="208">
		<span style="font-size: 10.0pt; font-family: Tahoma">Email-Id<font color="#FF0000">*</font></span></td>
		<td height="22" width="396">
		<html:text property="contactEmail" value="<%=emailId%>" styleClass="EmployeeTextBox" size="20" tabindex="5"></html:text></td>
    </tr>
    
	<tr>
	    <td height="22" width="208" bgcolor=#F4F4F4>
	<span style="font-size: 10.0pt; ">Phone Number<font color="#FF0000">*</font></span></td>		
		<td height="22" width="396" bgcolor=#F4F4F4>
		<html:text property="phoneNumber" value="<%=phoneNumber%>" styleClass="EmployeeTextBox" size="20" tabindex="6"></html:text></td>
    </tr>
	<tr>
	    <td height="22" width="208">
		<span style="font-size: 10.0pt; font-family: Tahoma">Father Name</span></td>
		<td height="22" width="396">
		<html:text property="fatherName" value="<%=fatherName%>" styleClass="EmployeeTextBox" size="20" tabindex="7"></html:text></td>
    </tr>

	<tr>
	    <td height="22" width="208">
		<span style="font-size: 10.0pt; font-family: Tahoma">Country Citizenship</span></td>
		<td height="22" width="396">
		<html:text property="countryCitizenship" value="<%=countryCitizenship%>" styleClass="EmployeeTextBox" size="20" tabindex="9"></html:text></td>
    </tr>
    <tr>
	    <td height="22" width="208" bgcolor=#F4F4F4>
		<span style="font-size: 10.0pt; font-family: Tahoma">DOB</span></td>
		<td height="22" width="396" bgcolor=#F4F4F4>
		<html:text property="dob" value="<%=dob%>" styleClass="EmployeeTextBox" size="20" tabindex="10"></html:text></td>
    </tr>
	<tr>
		<td height="22" width="208" > 
		<span style="font-size: 10.0pt; font-family: Tahoma">Profile Path</span></td>
		<td height="22" width="396" >
		<bean:write name="employeeRegistrationBean"  property="profilePath"></bean:write></td>
	</tr>
    <tr>
		<td height="22" width="223" colspan="3" align="left" bgcolor=#F4F4F4>
		<span style="font-size: 10.0pt">Employee Current&nbsp; Address<font color="#FF0000">*</font></span></td>
	</tr>
	
	<tr>
		<td height="137" width="223" rowspan="6"></td>		
		<td height="22" width="208"  align="left">
		<p class="MsoNormal"><span style="font-size: 10.0pt">Address 1:</span></td>
		<td height="22" width="223" align="left">
		<html:text property="listAddress[0].address1" value="<%=current_address1%>" styleClass="EmployeeTextBox" size="45" tabindex="14"></html:text></td>

	</tr>
	<tr>
		<td height="22" width="118" align="left" bgcolor=#F4F4F4>
		<p class="MsoNormal"><span style="font-size: 10.0pt">Address 2:</span></td>
		<td height="22" width="480" align="left" bgcolor=#F4F4F4>
		<html:text property="listAddress[0].address2" value="<%=current_address2%>" styleClass="EmployeeTextBox" size="45" tabindex="15"></html:text></td>
	</tr>
	<tr>
		<td height="22" width="208">
	<span style="font-size: 10.0pt; ">City</span></td>		
		<td height="22" width="396">
		<html:text property="listAddress[0].city" value="<%=current_city%>" styleClass="EmployeeTextBox" size="20" tabindex="16"></html:text></td></tr>
	<tr>
		<td height="23" width="208" bgcolor=#F4F4F4>
		<span style="font-size: 10.0pt; font-family: Tahoma">State</span></td>
		<td height="23" width="396" bgcolor=#F4F4F4><font face="Tahoma">
		<html:text property="listAddress[0].state" value="<%=current_state%>" styleClass="EmployeeTextBox" size="20" tabindex="17"></html:text></font></td>
	</tr>
	<tr>
		<td height="22" width="208">
	<span style="font-size: 10.0pt; ">Country</span></td>		
		<td height="22" width="396">
		<html:text property="listAddress[0].country" value="<%=current_country%>" styleClass="EmployeeTextBox" size="20" tabindex="18"></html:text></td>
	</tr>
	<tr>
		<td height="23" width="208" bgcolor=#F4F4F4>
		<span style="font-size: 10.0pt; font-family: Tahoma">Zip</span></td>
		<td height="23" width="396" bgcolor=#F4F4F4><font face="Tahoma">
		<html:text property="listAddress[0].zip" value="<%=current_zipcode%>" styleClass="EmployeeTextBox" size="20" tabindex="19"></html:text></font></td>
	</tr>
	
	<tr>
		<td height="22" width="223" colspan="3" align="left">
		<span style="font-size: 10.0pt">Employee Home Country Address<font color="#FF0000">*</font></span></td>
	</tr>
	<tr>
		<td height="137" width="223" rowspan="6" ></td>		
		<td height="22" width="208"  align="left" bgcolor=#F4F4F4>
		<p class="MsoNormal"><span style="font-size: 10.0pt">Address 1:</span></td>
		<td height="22" width="223" align="left" bgcolor=#F4F4F4>
		<html:text property="listAddress[1].address1" value="<%=home_country_address1%>" styleClass="EmployeeTextBox" size="45" tabindex="20"></html:text></td>

	</tr>
	<tr>
		<td height="22" width="118" align="left" >
		<p class="MsoNormal"><span style="font-size: 10.0pt">Address 2:</span></td>
		<td height="22" width="480" align="left">
		<html:text property="listAddress[1].address2" value="<%=home_country_address2%>" styleClass="EmployeeTextBox" size="45" tabindex="21"></html:text></td>
	</tr>
	<tr>
		<td height="22" width="208" bgcolor=#F4F4F4>
	<span style="font-size: 10.0pt; ">City</span></td>		
		<td height="22" width="396" bgcolor=#F4F4F4>
		<html:text property="listAddress[1].city" value="<%=home_country_city%>" styleClass="EmployeeTextBox" size="20" tabindex="22"></html:text></td></tr>
	<tr>
		<td height="23" width="208">
		<span style="font-size: 10.0pt; font-family: Tahoma">State</span></td>
		<td height="23" width="396"><font face="Tahoma">
		<html:text property="listAddress[1].state" value="<%=home_country_state%>" styleClass="EmployeeTextBox" size="20" tabindex="23"></html:text></font></td>
	</tr>
	<tr>
		<td height="22" width="208" bgcolor=#F4F4F4>
	<span style="font-size: 10.0pt; ">Country</span></td>		
		<td height="22" width="396" bgcolor=#F4F4F4>
		<html:text property="listAddress[1].country" value="<%=home_country_country%>" styleClass="EmployeeTextBox" size="20" tabindex="24"></html:text></td>
	</tr>
	<tr>
		<td height="23" width="208" >
		<span style="font-size: 10.0pt; font-family: Tahoma">Zip</span></td>
		<td height="23" width="396"><font face="Tahoma">
		<html:text property="listAddress[1].zip" value="<%=home_country_zipcode%>" styleClass="EmployeeTextBox" size="20" tabindex="25"></html:text></font></td>
	</tr>
	
	<tr>
		<td height="22" width="820" bgcolor="#F4F4F4" align="left" colspan="3">
		<p class="MsoNormal">Employer Details<font color="#FF0000">*</font></td>
		
	</tr>
	<tr>
		<td height="22" width="146" rowspan="2"></td></tr>
		<tr>
		<td height="22" width="208">
		<span style="font-size: 10.0pt; font-family: Tahoma">Employer Name</span></td>
		<td height="22" width="396">
		<html:text property="businessName" value="<%=businessName%>" styleClass="EmployeeTextBox" size="20" tabindex="26" readonly="true" ></html:text></td>
	</tr>
	



<tr>
		<td height="9" width="1031" bgcolor="#F4F4F4" align="left" colspan="3">
		<p class="MsoNormal">Client Details<font color="#FF0000">*</font></td>
		
	</tr>
	<tr>
		<td height="144" width="181" align="left" rowspan="10">
		</td></tr>
		<tr>
		<td height="18" width="161">
		<span style="font-size: 10.0pt; font-family: Tahoma">Client Working For</span></td>
		<td height="18" width="683">
		<html:text property="clientName" value="<%=client_name%>" styleClass="EmployeeTextBox" size="20" tabindex="2"></html:text></td>
		</tr>
<tr>
		<td height="18" width="847" bgcolor="#F4F4F4" align="left" colspan="2">
        Client Address<font color="#FF0000">*</font></td>
		</tr>
<tr>
		<td height="18" width="161">
        <span style="font-size: 10.0pt; font-family: Tahoma">Address1</span>
		</td>
		<td height="18" width="683">
		<html:text property="listAddress[2].address1" value="<%=client_address1%>"  styleClass="EmployeeTextBox" size="20" tabindex="3"></html:text>
		</td>
		</tr>
<tr>
		<td height="18" width="161" bgcolor="#F4F4F4" align="left">
        <span style="font-size: 10.0pt; font-family: Tahoma">Address2</span>
		</td>
		<td height="18" width="683" bgcolor="#F4F4F4" align="left">
		<html:text property="listAddress[2].address2" value="<%=client_address2%>" styleClass="EmployeeTextBox" size="20" tabindex="4"></html:text>
		</td>
		</tr>
<tr>
		<td height="18" width="161">
		<span style="font-size: 10.0pt; font-family: Tahoma">City</span>
		</td>
		<td height="18" width="683">
		<html:text property="listAddress[2].city" value="<%=client_city%>" styleClass="EmployeeTextBox" size="20" tabindex="5"></html:text>
		</td>
		</tr>

<tr>
		<td height="18" width="161" bgcolor="#F4F4F4" >
		<span style="font-size: 10.0pt; font-family: Tahoma">State</span>
		</td>
		<td height="18" width="683" bgcolor="#F4F4F4" >
		<html:text property="listAddress[2].state" value="<%=client_state%>" styleClass="EmployeeTextBox" size="20" tabindex="6"></html:text>
		</td>
		</tr>
<tr>
		<td height="18" width="161" >
		<span style="font-size: 10.0pt; font-family: Tahoma">Country</span>
		</td>
		<td height="18" width="683" >
		<html:text property="listAddress[2].country" value="<%=client_country%>" styleClass="EmployeeTextBox" size="20" tabindex="7"></html:text>
		</td>
		</tr>
<tr>
		<td height="18" width="161" bgcolor="#F4F4F4">
		<span style="font-size: 10.0pt; font-family: Tahoma">Zip</span>
		</td>
		<td height="18" width="683" bgcolor="#F4F4F4">
        <html:text property="listAddress[2].zip" value="<%=client_zipcode%>" styleClass="EmployeeTextBox" size="20" tabindex="8"></html:text>
		</td>
		</tr>
<tr>
		<td height="18" width="161" >
	    <span style="font-size: 10.0pt; font-family: Tahoma">Work Start Date</span></td>
		<td height="18" width="683" >
		<html:text property="startDate" value="<%=client_startDate%>" styleClass="EmployeeTextBox" size="20" tabindex="9"></html:text>
		</td>
		</tr>

	<tr>
		<td height="22" width="223" bgcolor="#F4F4F4" align="left" colspan="3"> 
		<p class="MsoNormal">Bank Details</td>
	</tr>
	<tr>
		<td height="129" width="146" rowspan="6"></td>
	</tr>
	<tr>
		<td height="2" width="245" bgcolor="#F4F4F4"  colspan="3" ></td>
	</tr>
	<tr>
		<td height="3" width="165" ></td>
		<td height="3" width="208" ></td>
		<td height="3" width="396" >
		<font face="Tahoma">
		<html:submit value="Update" property="update" styleClass="ButtonStyle" tabindex="35"></html:submit></font>
		<font size="2"> 
		<html:submit value="Cancel" property="cancel" styleClass="ButtonStyle" tabindex="36"></html:submit>
		</font></td>
	</tr>
	<%} %>
	</table>
</html:form>
</div>

