<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@page import="java.util.Map"%><style>
<!--
.BusinessTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }

-->
</style>

<script>
function cancelTrigger()
{
	var action = "";	
	<%
	com.lch.general.generalBeans.UserProfile userProfile = (com.lch.general.generalBeans.UserProfile) session
			.getAttribute("userProfile");
	String userName = "Guest";
	if (userProfile != null && userProfile.isLoginStatus()) {
		if (userProfile.isAdmin()) {
%>

	action = "adminFunctImpl.do";
	document.forms[0].parameter.value="cancelResetPassword";
<%
	} else {
%>

	action = "memberFunctImpl.do";
	document.forms[0].parameter.value="onClickingCancel";
<%
	}
	}
%>

document.forms[0].action=action;
document.forms[0].submit();
}
</script>
<%
Map m=(Map)request.getAttribute("passwordData");
String oldPassword="";
String contactEmail="";
if(m!=null)
{
	oldPassword =((String) m.get("password")!=null) ? ((String) m.get("password")) : ("");
	contactEmail =((String) m.get("contactEmail")!=null) ? ((String) m.get("contactEmail")) : ("");
}
%>
<%
	String errMsg = "";
%> 

<div align="center"> 
<form action="resetPassword.do" onsubmit="return checkPwdAndCnfrmPwd()">
<input type="hidden" name="parameter" value="resetAccountPassword" >
<input type="hidden" name="contactEmail" value="<%=contactEmail %>">
<table border="0" width="60%" height="129" style="font-family: Tahoma; font-size: 10pt">
	<tr>
		<td height="25"  colspan="2" bgcolor="#808080">
		<p align="center"><font color="#FFFFFF" face="Tahoma" size="2"><b>Reset Password</b></font></td>
	</tr>
	<tr>
		<td >
		<p align="right">Existing Password :</td>
		<td>
		<p align="left">
		<!--  Don;t remove this even I mistakenly asked you to remove this. -->
		<input type="password" name="existingPassword" value="ITSDUMMY-CLIENT NOT LOADED WITH THIS PASSWORD" size="20" class="BusinessTextBox" readonly="readonly"></td>
	</tr>
	<tr>
		<td bgcolor="#F4F4F4">
		<p align="right">New Password :</td>
		<td bgcolor="#F4F4F4">
		<p align="left">
		<html:messages id="err_name" property="password">
			<% errMsg = err_name; %>
		</html:messages>
		<input type="password"" name="password" size="20" class="BusinessTextBox"><%=errMsg %><%errMsg=""; %><font color="#FF0000"><span id="pwdErr"></span></font></td>
	</tr>
	<tr>
		<td  width="182">
		<p align="right">Retype Password :</td>
		<td  width="213">
		<p align="left">
		<html:messages id="err_name" property="password">
			<% errMsg = err_name; %>
		</html:messages>
		<input type="password" name="confirmPassword" size="20" class="BusinessTextBox"><%=errMsg %><%errMsg=""; %><font color="#FF0000"><span id="cnfrmPwdErr"></span></font></td>
	</tr>
	<tr>
		<td height="20"  colspan="2" bgcolor="#F4F4F4">
		<p align="center">
		<input type="submit" value="Update" name="update" class="ButtonStyle">&nbsp;
		<input type="submit" value="Cancel" name="cancel" onclick="cancelTrigger()" class="ButtonStyle">&nbsp;
		<input type="reset" value="Reset" name="reset" class="ButtonStyle"></td>
	</tr>
</table>
</form>
</div>
