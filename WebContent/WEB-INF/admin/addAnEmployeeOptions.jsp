
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
				<td>Email-Id<font color="#FF0000">*</font></td>
				<td><html:messages id="err_name" property="contactEmail" >
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="contactEmail" styleClass="EmployeeTextBox" size="20" tabindex="6" onblur="verifyEmpEmail(this.value)" styleId="contactEmail"></html:text> <span id="usrEmailAvailabilityCheckMsg"></span><%=errMsg%> <%
 	errMsg = "";
 %></td>
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
				<td>DOB</td>
				<td><html:messages id="err_name" property="dob">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="dob" styleClass="EmployeeTextBox" size="20" tabindex="11"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>Profile Path</td>
				<td><html:file property="profilePath" styleClass="EmployeeTextBox" size="20" tabindex="14"></html:file></td>
			</tr>

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
					</html:messages> <html:text property="listAddress[0].country" styleClass="EmployeeTextBox" size="20" tabindex="18"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>Zip</td>
				<td><font face="Tahoma"> <html:messages id="err_name" property="listAddress[0].zip">
							<%
								errMsg = err_name;
							%>
						</html:messages> <html:text property="listAddress[0].zip" styleClass="EmployeeTextBox" size="20" tabindex="19"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %>
				</font></td>
			</tr>

			<tr>
				<td colspan="3" class="tdSideHeader">Employee Home Country Address<font color="#FF0000">*</font>
				</td>
			</tr>
			<tr>
				<td rowspan="6"></td>
				<td align="left">Address 1:</td>
				<td align="left"><html:messages id="err_name" property="listAddress[1].address1">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[1].address1" styleClass="EmployeeTextBox" size="45" tabindex="20"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>

			</tr>
			<tr>
				<td align="left">Address 2:</td>
				<td  align="left"><html:messages id="err_name" property="listAddress[1].address2">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[1].address2" styleClass="EmployeeTextBox" size="45" tabindex="21"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>City</td>
				<td><html:messages id="err_name" property="listAddress[1].city">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[1].city" styleClass="EmployeeTextBox" size="20" tabindex="22"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>State</td>
				<td><font face="Tahoma"> <html:messages id="err_name" property="listAddress[1].state">
							<%
								errMsg = err_name;
							%>
						</html:messages> <html:text property="listAddress[1].state" styleClass="EmployeeTextBox" size="20" tabindex="23"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %>
				</font></td>
			</tr>
			<tr>
				<td>Country</td>
				<td><html:messages id="err_name" property="listAddress[1].country">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[1].country" styleClass="EmployeeTextBox" size="20" tabindex="24"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>Zip</td>
				<td><font face="Tahoma"> <html:messages id="err_name" property="listAddress[1].zip">
							<%
								errMsg = err_name;
							%>
						</html:messages> <html:text property="listAddress[1].zip" styleClass="EmployeeTextBox" size="20" tabindex="25"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %>
				</font></td>
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
				<td><%=((UserProfile) session.getAttribute("userProfile"))
						.getEmployerName()%></td>
			</tr>
			<tr>
				<td class="tdSideHeader" colspan="3">Client Details<font color="#FF0000">*</font>
				</td>

			</tr>
			<tr>
				<td align="left" rowspan="10"></td>
			</tr>
			<tr>
				<td>Client Working For</td>
				<td><html:messages id="err_name" property="clientName">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="clientName" styleClass="EmployeeTextBox" size="20" tabindex="27"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td align="left" colspan="2">Client Address<font color="#FF0000">*</font>
				</td>
			</tr>
			<tr>
				<td>Address1</td>
				<td><html:messages id="err_name" property="listAddress[2].address1">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[2].address1" styleClass="EmployeeTextBox" size="20" tabindex="28"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td align="left">Address2</td>
				<td align="left"><html:messages id="err_name" property="listAddress[2].address2">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[2].address2" styleClass="EmployeeTextBox" size="20" tabindex="29"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>City</td>
				<td><html:messages id="err_name" property="listAddress[2].city">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[2].city" styleClass="EmployeeTextBox" size="20" tabindex="30"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>

			<tr>
				<td>State</td>
				<td><html:messages id="err_name" property="listAddress[2].state">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[2].state" styleClass="EmployeeTextBox" size="20" tabindex="31"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>Country</td>
				<td><html:messages id="err_name" property="listAddress[2].country">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[2].country" styleClass="EmployeeTextBox" size="20" tabindex="32"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>Zip</td>
				<td><html:messages id="err_name" property="listAddress[2].zip">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[2].zip" styleClass="EmployeeTextBox" size="20" tabindex="33"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td>Work Start Date</td>
				<td><html:messages id="err_name" property="startDate">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="startDate" styleClass="EmployeeTextBox" size="20" tabindex="34"></html:text> &nbsp; <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>

			<tr>
				<td class="tdSideHeader" colspan="3">Login Credentials<font color="#FF0000">*</font>
				</td>
			</tr>

			<tr>
				<td rowspan="4" class="odd"></td>

				<td>User Id</td>
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
				<td colspan="3"><html:submit value="Confirm" property="confirm" tabindex="44" styleId="cNextEmp" styleClass="ButtonStyleDisabled" disabled="true" ></html:submit> <html:submit value="Cancel" property="cancel" onclick="addAnEmployeeCanclation()" styleClass="ButtonStyle" tabindex="45"></html:submit>
					<!--<input type="submit" value="Cancel" name="cancel" onclick="cancel()" class="ButtonStyle" tabindex="45">--></td>
			</tr>
		</table>
	</html:form>
</div>

<script>

var isEmailValidated = false;
var isUserNameValidated = false;

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
    		verifyEmpEmail(document.getElementById("contactEmail").value);
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
		    url : "employeeRegistration.do?parameter=checkUserNameAvailability",
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
    </script>