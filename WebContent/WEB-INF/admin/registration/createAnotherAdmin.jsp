<%@page import="java.util.List"%>
<%@page import="com.lch.spring.BusinessComponents.DoTransaction"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<style>
<!--
.BusinessTextBox {
	font-family: Tahoma;
	font-size: 10pt;
	color: #008080;
	border: 1px solid #808080;
	padding-left: 4px;
	padding-right: 4px;
	padding-top: 1px;
	padding-bottom: 1px
}
-->
</style>

<div align="center">
	<%
		String errMsg = "";
	%>

	<html:form action="/createAnotherAdmin.do?parameter=createAnotherAdmin" enctype="multipart/form-data" onsubmit="return checkPwdAndCnfrmPwd()">
		<input type="hidden" name="parameter" value="">

		<table border="0" cellspacing="1" style="font-family: Tahoma; font-size: 10pt" id="regEmp" width="90%">
			<tr>
				<td colspan="3" class="tdHeader">Creating Another Child Administrator
				</td>
			</tr>
			
<!-- 			<tr> -->
<!-- 				<td>User Name<font color="#FF0000">*</font></td> -->
<!-- 				<td colspan="2"> -->
<%-- 					<html:text property="login" styleClass="BusinessTextBox" size="20" tabindex="16" onblur="verifyUser(this.value)" styleId="userName"></html:text>  --%>
<!-- 					<font color="#FF0000"><span id="usrAvailabilityCheckMsg"></span></font> -->
<!-- 				</td>					 -->
<!-- 			</tr> -->
			<tr>
				<td><span style="font-size: 10.0pt; font-family: Tahoma">Email-Id <br>(Same is used as UserName)<font color="#FF0000">*</font></span></td>
				
				<td colspan="2" align="left">
					<html:text property="contactEmail" styleClass="BusinessTextBox" size="20" tabindex="1" onblur="verifyEmail(this.value)" styleId="empContactEmail"></html:text> <font color="#000000"><span id="userEmailAvailabilityCheckMsg"></span></font>
				</td>
				
			</tr>
			<tr>
				<td width="20%"><span style="font-size: 10.0pt; font-family: Tahoma">First Name<font color="#FF0000">*</font></span></td>
				<td colspan="2"><html:messages id="err_name" property="firstName">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="firstName" styleClass="BusinessTextBox" size="20" tabindex="1"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td><span style="font-size: 10.0pt; font-family: Tahoma">Middle Name</span></td>
				<td colspan="2"><html:messages id="err_name" property="middleName">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="middleName" styleClass="BusinessTextBox" size="20" tabindex="2"></html:text><%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				<td><span style="font-size: 10.0pt; font-family: Tahoma">Last Name<font color="#FF0000">*</font></span></td>
				<td colspan="2"><html:messages id="err_name" property="lastName">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="lastName" styleClass="BusinessTextBox" size="20" tabindex="3"></html:text><%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			
			<tr>
				<td><span style="font-size: 10.0pt; font-family: Tahoma">Phone Number :<font color="#FF0000">*</font></span></td>
				<td colspan="2"><html:messages id="err_name" property="phoneNumber">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="phoneNumber" styleClass="BusinessTextBox" size="20" tabindex="6"></html:text><%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>

			<tr>
				<td><font face="Tahoma" size="2">Country Citizenship</font><font color="#FF0000">*</font></td>
				<td colspan="2"><html:messages id="err_name" property="countryCitizenship">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="countryCitizenship" styleClass="BusinessTextBox" size="20" tabindex="8"></html:text><%=errMsg%> <%
 	errMsg = "";
 %></td>
			</tr>
			<tr>
				
				<td colspan="3" align="center">Password will be generated and sent to the user automatically.</td>
			</tr>
			
			
			
			<tr>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td class="odd"></td>
				<td class="odd" colspan="2">
					<html:button property="confirm" value="Create Another Admin" styleClass="ButtonStyleDisabled" tabindex="19" styleId="cNext" disabled="true" onclick="sendData(this)"></html:button> 
					<html:button property="cancel" value="Cancel Creation" onclick="adminCancelReg()" styleClass="ButtonStyle" tabindex="20"></html:button>
				</td>
			</tr>
		</table>
	</html:form>
</div>

<script>
function sendData(btn) {
	btn.disabled=true; 
	btn.value='Sending...';
    document.forms[0].submit();    
}
	function adminCancelReg() {
	    document.forms[0].action = "adminRegistration.do";
	    document.forms[0].parameter.value = "adminCancelReg";
	    document.forms[0].submit();
	    
    }
</script>


<script>
	if (document.getElementsByTagName) {
	    var table = document.getElementById("regEmp");
	    var rows = table.getElementsByTagName("tr");
	    for (i = 0; i < rows.length; i++) {
		    if (i % 2 == 0) {
			    rows[i].className = "odd";
		    } else {
			    rows[i].className = "even";
		    }
	    }
    }
</script>

<script>
 
 /*   function verifyUser(userName) {
	    var params = {
		    ajaxParam : userName
	    };
	    var obj = {
	    id : "usrAvailabilityCheckMsg",
	    url : "employeeRegistration.do?parameter=checkUserNameAvailability",
	    params : params,
	    responseHandler : handleResponse
	    };
	    
	    sendAjaxRequest(obj);
    }*/

    function verifyEmail(email) {
	    var params = {
		    ajaxParam : email
	    };
	    var obj = {
	    id : "userEmailAvailabilityCheckMsg",
	    url : "employeeRegistration.do?parameter=checkUserNameAndEmailAvailability",
	    params : params,
	    responseHandler : handleResponse
	    };
	    
	    sendAjaxRequest(obj);
    }
 
    function handleResponse(obj, response) {
	    removeAjaxImg(obj.id);
	    
	    if (response.indexOf("disableSubmitRequired") == -1) 
	    {
			    document.getElementById("cNext").disabled = false;
			    document.getElementById("cNext").className = 'ButtonStyle';
	    }
	    else 
	    {
		    document.getElementById("cNext").disabled = true;
		    document.getElementById("cNext").className = 'ButtonStyleDisabled';
	    }
	    if (response != null)
		    response = response.replace("disableSubmitRequired", "");
	    placeAjaxMessage(obj.id, response);
	    
    }
    
    if (!document.getElementById("cNext").disabled) {
    	document.getElementById("cNext").className = 'ButtonStyle';
    }

    dhtmlx.message({type:"error", expire:20000, text:"Info : User Rate Feature will not be available for Child Amdins" });
    dhtmlx.message({type:"error", expire:20000, text:"Info : Do Data Backup Feature will not be available for Child Amdins" });
    
</script>
