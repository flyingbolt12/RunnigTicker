
<%@page import="java.util.List"%>
<%@page import="com.lch.spring.BusinessComponents.DoTransaction"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<style>
.EmployeeTextBox {
	font-family: Tahoma;
	font-size: 10pt;
	color: #008080;
	border: 1px solid #808080;
	padding-left: 4px;
	padding-right: 4px;
	padding-top: 1px;
	padding-bottom: 1px
}
</style>

<div align="center">
	<%
		String errMsg = "";
		UserProfile userProfile = (UserProfile) session
				.getAttribute("userProfile");
		String userName = "Employer";
		if (userProfile != null && userProfile.getFirstName().length() != 0) {
			userName = userProfile.getFirstName();
		}
		String employerName = ((UserProfile) session.getAttribute("userProfile"))
				.getEmployerName();
	%>
	<html:form action="confirmAddEmployeeResgistration.do?parameter=addAnEmployee" enctype="multipart/form-data" onsubmit="return checkPwdAndCnfrmPwd()">
		<input type="hidden" name="parameter" value="">
		<table border="0" cellspacing="1" style="font-family: Tahoma; font-size: 10pt" width="80%" id="validPending">
			<tr>
				<td colspan="3" class="regHeader">Add an Employee</td>
			</tr>
			<tr>
				<td colspan="3"></td>
			</tr>
			<tr>
				<td align="left" colspan="3" class="tdSideHeader">User Details</td>
			</tr>
			<tr>
				<td rowspan="10" width="12%"></td>
				<td>First Name<font color="#FF0000">*</font></td>
				<td><html:messages id="err_name" property="firstName">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="firstName" styleClass="EmployeeTextBox" size="20" tabindex="1"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td >Middle Name</td>
				<td ><html:messages id="err_name" property="middleName">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="middleName" styleClass="EmployeeTextBox" size="20" tabindex="2"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>Last Name<font color="#FF0000">*</font></td>
				<td><html:messages id="err_name" property="lastName">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="lastName" styleClass="EmployeeTextBox" size="20" tabindex="3"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>Gender</td>
				<td><html:select property="gendar" styleClass="EmployeeTextBox" size="1" tabindex="4">
						<html:option value="MALE"></html:option>
						<html:option value="FEMALE"></html:option>
					</html:select></td>
			</tr>

<tr>
				<td>Submit TimeSheets</td>
				<td><html:select property="timeSheetConfiguredTo" styleClass="EmployeeTextBox" size="1" tabindex="1028">
						<html:option value="MONTHLY"></html:option>
						<html:option value="BIWEEKLY"></html:option>
						<html:option value="DAYS15"></html:option>
						<html:option value="WEEKLY"></html:option>
					</html:select></td>
			</tr>
			<tr>
				<td>Phone Number<font color="#FF0000">*</font>
				</td>
				<td><html:messages id="err_name" property="phoneNumber">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="phoneNumber" styleClass="EmployeeTextBox" size="20" tabindex="7"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>Father Name</td>
				<td><html:messages id="err_name" property="fatherName">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="fatherName" styleClass="EmployeeTextBox" size="20" tabindex="8"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>Country Citizenship</td>
				<td><html:messages id="err_name" property="countryCitizenship">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="countryCitizenship" styleClass="EmployeeTextBox" size="20" tabindex="10"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>DOB<font color="#FF0000">*</font></td>
				<td><html:messages id="err_name" property="dob">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="dob" styleClass="EmployeeTextBox" size="20" tabindex="11"  styleId="dob"></html:text> <img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector"
					style="border: 1px solid green; cursor: pointer;" id="f_trigger_c" src="jscalendar-1.0/img.gif" /> <font size="2"><span style="font-family: Tahoma">MM/DD/YYYY</span></font><%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td>Profile Path</td> -->
<%-- 				<td><html:file property="profilePath" styleClass="EmployeeTextBox" size="20" tabindex="14"></html:file></td> --%>
<!-- 			</tr> -->

			<tr>
				<td colspan="3" class="tdSideHeader">Employee Current Address <font color="#FF0000">*</font>
				</td>
			</tr>

			<tr>
				<td rowspan="6" class="odd"></td>
				<td align="left">Address 1:</td>
				<td align="left"><html:messages id="err_name" property="listAddress[0].address1">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[0].address1" styleClass="EmployeeTextBox" size="45" tabindex="14"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>

			</tr>
			<tr>
				<td align="left">Address 2:</td>
				<td  align="left"><html:messages id="err_name" property="listAddress[0].address2">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[0].address2" styleClass="EmployeeTextBox" size="45" tabindex="15"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>City</td>
				<td><html:messages id="err_name" property="listAddress[0].city">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[0].city" styleClass="EmployeeTextBox" size="20" tabindex="16"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>State</td>
				<td><font face="Tahoma"> <html:messages id="err_name" property="listAddress[0].state">
							<%
								errMsg = err_name;
							%>
						</html:messages> <html:text property="listAddress[0].state" styleClass="EmployeeTextBox" size="20" tabindex="17"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %>
				</font></td>
			</tr>
			<tr>
				<td>Country</td>
				<td><html:messages id="err_name" property="listAddress[0].country">
						<%
							errMsg = err_name;
						%>
					</html:messages> 
					
					
					
					<html:select property="listAddress[0].country" styleClass="EmployeeTextBox" tabindex="18">
				<%
				
				GenericXmlApplicationContext ctx = null;
				try {
					ctx = (GenericXmlApplicationContext) application.getAttribute("ctx");
				} catch (Exception e) {
					
				}
				
				DoTransaction doTransaction = (DoTransaction) ctx.getBean("doTransaction");
				List<String> countires = (List<String>)doTransaction.listCountries();
				
				for (String country : countires)
				{
				%>
				<html:option value="<%= country%>"></html:option>
				<%} %>
				</html:select>
					
				<%=errMsg%> <% 	errMsg = ""; %></td>
			</tr>
			<tr>
				<td>Zip</td>
				<td><font face="Tahoma"> <html:messages id="err_name" property="listAddress[0].zip"><%errMsg = err_name;%></html:messages> 
							<html:text property="listAddress[0].zip" styleClass="EmployeeTextBox" size="20" tabindex="19"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %>
				</font></td>
			</tr>

			<tr>
				<td colspan="3" class="tdSideHeader">Employee Home Country Address<font color="#FF0000">*</font>
				<input type="checkbox"  name="isSameAsCurrentAddress" onclick="personalAddressVisible(this)" value="Y" checked="checked"> Same as current address
				</td>
			</tr>
			
			<tr id="result_tr" style="display:none">
			<td colspan="3">
			
			<table border="0" cellspacing="1" style="font-family: Tahoma; font-size: 10pt" width="100%">
			<tr>
				<td rowspan="6" width="12%" class="odd"></td>
				<td align="left"><span class="spanStyle">Address 1:</span></td>
				<td align="left">
				<html:messages id="err_name" property="listAddress[0].address1"><%errMsg = err_name;%></html:messages> 
				<html:text property="listAddress[1].address1" styleClass="EmployeeTextBox" size="45" tabindex="1036"></html:text> <%=errMsg%> <%errMsg = "";%></td>

			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Address 2:</span></td>
				<td align="left">
				<html:messages id="err_name" property="listAddress[0].address2"><%errMsg = err_name;%></html:messages> 
				<html:text property="listAddress[1].address2" styleClass="EmployeeTextBox" size="45" tabindex="1037"></html:text> <%=errMsg%> <%errMsg = "";%></td>
			</tr>
			<tr>
				<td><span class="spanStyle">City</span></td>
				<html:messages id="err_name" property="listAddress[0].city"><%errMsg = err_name;%></html:messages> 
				<td>
				<html:text property="listAddress[1].city" styleClass="EmployeeTextBox" size="20" tabindex="1038"></html:text> <%=errMsg%> <%errMsg = "";%></td>
			</tr>
			<tr>
				<td><span class="spanStyle">State</span></td>
				<td><font face="Tahoma"> 
				<html:messages id="err_name" property="listAddress[0].state"><%errMsg = err_name;%></html:messages> 
				<html:text property="listAddress[1].state" styleClass="EmployeeTextBox" size="20" tabindex="1039"></html:text></font> <%=errMsg%> <%errMsg = "";%></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Country</span></td>
				<td>
				<html:messages id="err_name" property="listAddress[0].country"><%errMsg = err_name;%></html:messages> 
				<html:select property="listAddress[1].country" styleClass="EmployeeTextBox" tabindex="1040">
				<%
				
				GenericXmlApplicationContext ctx = null;
				try {
					ctx = (GenericXmlApplicationContext) application.getAttribute("ctx");
				} catch (Exception e) {
					
				}
				
				DoTransaction doTransaction = (DoTransaction) ctx.getBean("doTransaction");
				List<String> countires = (List<String>)doTransaction.listCountries();
				
				for (String country : countires)
				{
				%>
				<html:option value="<%= country%>"></html:option>
				<%} %>
				</html:select> <%=errMsg%> <%errMsg = "";%></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Zip</span></td>
				<td><font face="Tahoma"> 
				<html:messages id="err_name" property="listAddress[0].zip"><%errMsg = err_name;%></html:messages> 
				<html:text property="listAddress[1].zip" styleClass="EmployeeTextBox" size="20" tabindex="1041"></html:text></font> <%=errMsg%> <%errMsg = "";%></td>
			</tr>
			
			</table>
			</td>
			
			</tr>

			<tr>
				<td class="tdSideHeader" colspan="3">Employer Details<font color="#FF0000">*</font>
				</td>

			</tr>
			<tr>
				<td rowspan="2" class="odd"></td>
			</tr>
			<tr>
				<td>Employer Name</td>
				<td><%= employerName%></td>
			</tr>
			
			<tr>
				<td align="left" colspan="3" class="tdSideHeader">Client Details<font color="#FF0000">*</font> 
				<input type="checkbox" onclick="hideClient(this)" name="isSameAsBusinessAddress" value="Y"> 
				Check if, Employee client is same as Employer or When No Client</td>
			</tr>
			
		<tr>
				<td  colspan="3" >
				
				<!-- ============ -->
				
				
				<table border="0" cellspacing="1" width="100%" style="font-family: Tahoma; font-size: 10pt" id="regEmp1">
			<tr>
			
				<td rowspan="8" width="12%"></td>
				<td><span class="spanStyle">Client Working For</span></td>
				<td><html:messages id="err_name" property="clientName"><%errMsg = err_name;%></html:messages><html:text property="clientName" styleId="clientName" styleClass="EmployeeTextBox" size="20" tabindex="6"></html:text><%=errMsg%> <%errMsg = "";%></td>
			</tr>
			
			<tr>
				<td><span class="spanStyle">Address1</span></td>
				<td>
				<html:messages id="err_name" property="listAddress[0].address1"><%errMsg = err_name;%></html:messages> 
				<html:text property="listAddress[2].address1" styleClass="EmployeeTextBox" size="40" tabindex="6"></html:text><%=errMsg%> <%errMsg = "";%></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Address2</span></td>
				<td align="left">
				<html:messages id="err_name" property="listAddress[0].address2"><%errMsg = err_name;%></html:messages> 
				<html:text property="listAddress[2].address2" styleClass="EmployeeTextBox" size="40" tabindex="7"></html:text><%=errMsg%> <%errMsg = "";%></td>
			</tr>
			<tr>
				<td><span class="spanStyle">City</span></td>
				<td>
					<html:messages id="err_name" property="listAddress[0].city"><%errMsg = err_name;%></html:messages> 
					<html:text property="listAddress[2].city" styleClass="EmployeeTextBox" size="20" tabindex="8"></html:text><%=errMsg%> <%errMsg = "";%></td>
			</tr>

			<tr>
				<td><span class="spanStyle">State</span></td>
				<td>
				<html:messages id="err_name" property="listAddress[0].state"><%errMsg = err_name;%></html:messages> 
				<html:text property="listAddress[2].state" styleClass="EmployeeTextBox" size="20" tabindex="9" onblur="verifyState(this)"></html:text> <span id="state"></span><%=errMsg%> <%errMsg = "";%></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Country</span></td>
				<td>
				<html:messages id="err_name" property="listAddress[0].country"><%errMsg = err_name;%></html:messages> 
				<html:select property="listAddress[2].country" styleClass="EmployeeTextBox" tabindex="10">
				
					<%
				
				GenericXmlApplicationContext ctx = null;
				try {
					ctx = (GenericXmlApplicationContext) application.getAttribute("ctx");
				} catch (Exception e) {
					
				}
				
				DoTransaction doTransaction = (DoTransaction) ctx.getBean("doTransaction");
				List<String> countires = (List<String>)doTransaction.listCountries();
				
				for (String country : countires)
				{
				%>
				<html:option value="<%= country%>"></html:option>
				<%} %>
				</html:select>
				
				<%=errMsg%> <%errMsg = "";%>
				</td>
			</tr>
			<tr>
				<td><span class="spanStyle">Zip</span></td>
				<td>
				<html:messages id="err_name" property="listAddress[0].zip"><%errMsg = err_name;%></html:messages> 
				<html:text property="listAddress[2].zip" styleClass="EmployeeTextBox" size="20" tabindex="11"></html:text><%=errMsg%> <%errMsg = "";%></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Work Start Date</span></td>
				<td>
				<html:messages id="err_name" property="startDate"><%errMsg = err_name;%></html:messages> 
				<html:text property="startDate" styleClass="EmployeeTextBox" size="20" tabindex="12" styleId="start_date"></html:text> <img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector"
					style="border: 1px solid green; cursor: pointer;" id="f_trigger_c1" src="jscalendar-1.0/img.gif" /> <font size="2"><span style="font-family: Tahoma">MM/DD/YYYY</span></font><%=errMsg%> <%errMsg = "";%></td>
			</tr>
				
				</table>
				
				
				<!-- ============ -->
				
				</td>


			</tr>
			
			
			<tr>
				<td class="tdSideHeader" colspan="3">Login Credentials<font color="#FF0000">*</font>
				</td>
			</tr>

			<tr>
				<td rowspan="4" class="odd"></td>

				<td>User Email Id (Same is used as UserName)</td>
				<td><html:messages id="err_name" property="login">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="login" styleClass="EmployeeTextBox" size="20" tabindex="40" onblur="verifyUserId(this.value)" value="" styleId="login"></html:text> <span
					id="usrAvailabilityCheckMsg"></span> <%=errMsg%> <%
 	errMsg = "";
 %></td>

			</tr>
			<tr>
				<td>Password</td>
				<td><html:messages id="err_name" property="password">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:password property="password" styleClass="EmployeeTextBox" size="20" tabindex="41"></html:password> <%=errMsg%> <%
 	errMsg = "";
 %> <span id="pwdErr"></span></td>
			</tr>
			<tr>
				<td>Confirm Password</td>
				<td><html:messages id="err_name" property="confirmPassword">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:password property="confirmPassword" styleClass="EmployeeTextBox" size="20" tabindex="42"></html:password> <%=errMsg%> <%
 	errMsg = "";
 %> <span id="cnfrmPwdErr"></span></td>
			</tr>

			<tr>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td colspan="3">
					<html:button value="Confirm" property="confirm" tabindex="44" styleId="cNextEmp" styleClass="ButtonStyleDisabled" disabled="true" onclick="validateAndSubmit()"></html:button>
					<html:submit value="Cancel" property="cancel" onclick="addAnEmployeeCanclation()" styleClass="ButtonStyle" tabindex="45"></html:submit>
				</td>
			</tr>
		</table>
	</html:form>
</div>

<script type="text/javascript">
	Calendar.setup({
    inputField : "start_date",
    ifFormat : "%m/%e/%Y",
    button : "f_trigger_c1",
    align : "Tl",
    singleClick : false
    });
</script>
<script type="text/javascript">
	Calendar.setup({
    inputField : "dob",
    ifFormat : "%m/%e/%Y",
    button : "f_trigger_c",
    align : "Tl",
    singleClick : false
    });
</script>
<script>

var isEmailValidated = true;
var isUserNameValidated = false;

function validateAndSubmit(){
	
	if (isClientCheked && !isPersonalAddressVisible){
		document.forms[0].submit();
		return;
	}
	var isToSubmit = false;
	if (!isClientCheked){
		isToSubmit = validateAddress(2, "city") && 
		validateAddress(2, "address1") &&
		validateAddress(2, "state") &&
		validateAddress(2, "zip") &&
		validateAddress(2, "country") ;
	}
	
	if (isPersonalAddressVisible){
		isToSubmit = validateAddress(1, "city")&& 
		validateAddress(1, "address1")&& 
		validateAddress(1, "state")&& 
		validateAddress(1, "zip")&& 
		validateAddress(1, "country");
	}
	
	if (isToSubmit) document.forms[0].submit();
}
function validateAddress(addNo, filedName){
	var val = 'document.getElementsByName(\'listAddress['+addNo+'].'+filedName+'\')[0].value';
	var value = eval(val);
	if(value == null || value == "" || value.trim().length == 0){
		var str = "Please Correct, Blank Value for filed : "+filedName+" is not allowed inside, "+ ( (addNo ==1)?"HomeCountry" : "Client")+" Address";
		alert(str);
		return false;
	}
	if(filedName == "state" && !value.trim().length == 2){
		var str = "Please Correct, State Must have only 2 letters inside "+ ((addNo ==1)?"HomeCountry" : "Client")+" Address";
		alert(str);
		return false;
	}
	
	return true;
}

	function checkPwdAndCnfrmPwd() {
	    pwd = document.forms[0].password.value;
	    cnfrmPwd = document.forms[0].confirmPassword.value;
	    if (pwd == cnfrmPwd) {
	    	return validateSubmit();
	    } else {
		    var msg = "Password and ConfrimPassword Should be Same";
		    document.getElementById("pwdErr").innerHTML = msg;
		    document.getElementById("cnfrmPwdErr").innerHTML = msg;
		    return false;
	    }
    }

    function addAnEmployeeCanclation() {
	    document.forms[0].action = "addAnEmployeeRegistration.do";
	    document.forms[0].parameter.value = "addAnEmployeeCanclation";
	    document.forms[0].submit();
	    
    }
    
    function validateSubmit() {
    	
    	if(isEmailValidated && isUserNameValidated)
    		return true;
    	else{
    		verifyUserId(document.getElementById("login").value);
    		//verifyEmpEmail(document.getElementById("contactEmail").value);
    		return true;
    	}
    }

document.getElementById("login").value="";
document.getElementById("contactEmail").value="";

	if (document.getElementsByTagName) {
	    var table = document.getElementById("validPending");
	    var rows = table.getElementsByTagName("tr");
	    for (i = 0; i < rows.length; i++) {
		    if (i % 2 == 0) {
			    rows[i].className = "even";
		    } else {
			    rows[i].className = "odd";
		    }
	    }
    }
	
	 function verifyUserId(text) {
		 isUserNameValidated = true;
		    var params = {
			    ajaxParam : text
		    };
		    var obj = {
		    id : "usrAvailabilityCheckMsg",
		    url : "employeeRegistration.do?parameter=checkUserNameAndEmailAvailability",
		    params : params,
		    responseHandler : handleEmpResponse
		    };
		    sendAjaxRequest(obj);
	    }
	 
	function verifyEmpEmail(email) {
		isEmailValidated = true;
	    var params = {
		    ajaxParam : email
	    };
	    var obj = {
	    id : "usrEmailAvailabilityCheckMsg",
	    url : "employeeRegistration.do?parameter=checkUserEmailAvailability",
	    params : params,
	    responseHandler : handleEmpResponse
	    };
	    sendAjaxRequest(obj);
    }
	  function handleEmpResponse(obj, response) {
		    removeAjaxImg(obj.id);
		    
		    if (response.indexOf("disableSubmitRequired") == -1) {
			    document.getElementById("cNextEmp").disabled = false;
			    document.getElementById("cNextEmp").className = 'ButtonStyle';
		    } else {
			    document.getElementById("cNextEmp").disabled = true;
			    document.getElementById("cNextEmp").className = 'ButtonStyleDisabled';
		    }
		    if (response != null)
			    response = response.replace("disableSubmitRequired", "");
		    placeAjaxMessage(obj.id, response);
		    
	    }
	  var employerName = '<%= employerName%>';
	  var isClientCheked = false;
	  function hideClient(checkbox){
	    	
	    	var result_style = document.getElementById('regEmp1').style;
	    	if (!checkbox.checked){
	    		document.getElementById("clientName").readOnly = false;
	    		document.getElementById("clientName").value = "";
	    		result_style.display = 'table-cell';	
	    		isClientCheked = false;
	    	} else {
	    		document.getElementById("clientName").value = employerName;
	    		document.getElementById("clientName").readOnly = true;
	    		isClientCheked = true;
	    		result_style.display = 'none';
	    	}
	    	
	    	
	    }
	  var isPersonalAddressVisible = true;
	  function personalAddressVisible(checkbox){
	    	
	    	var result_style = document.getElementById('result_tr').style;
	    	if (!checkbox.checked){
	    		isPersonalAddressVisible = true;
	    		result_style.display = 'table-row';	
	    	} else {
	    		isPersonalAddressVisible = false;
	    		result_style.display = 'none';
	    	}
	    	
	    	
	    }
    </script>