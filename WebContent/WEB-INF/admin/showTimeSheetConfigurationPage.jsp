<%@page import="com.lch.struts.actions.admin.AdminSettings"%>
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
	document.forms[0].parameter.value="cancelRequest";
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
Map m=(Map)request.getAttribute("adminSettings");
String currentSelection = "8.0";

if(m!=null)
{
	currentSelection =(String) m.get(AdminSettings.TIMSHEETCONFIGURATION.name());
}
%>

<div align="center"> 
<form action="adminFunctImpl.do">
<input type="hidden" name="parameter" value="updateTimeSheetConfiguration" >
<input type="hidden" name="name" value="<%= AdminSettings.TIMSHEETCONFIGURATION.name()%>" >
<table border="0" width="70%" style="font-family: Tahoma; font-size: 10pt" id="reg1">

	<tr>
		<td height="25"  colspan="2" bgcolor="#808080">
		<p align="center"><font color="#FFFFFF" face="Tahoma" size="2"><b>TimeSheet Configuration Page</b></font></td>
	</tr>
	
	<tr>
		<td height="25"  colspan="2" align="center">Hint : While your employee submits the Time Sheet the 
		values that defaults to the number of hours to display</td>
	</tr>
	<tr>
		<td height="8"  colspan="2" ></td>
	</tr>
	
	<tr>
		<td height="25"  colspan="2" align="center"> Current Selection Set to : <%=currentSelection %></td>
	</tr>
	
	<tr>
		<td height="8"  colspan="2" align="center"></td>
	</tr>
	
	<tr>
		<td height="25"  colspan="2" align="left"> Select an option to change to</td>
	</tr>
	
	<tr>
		<td >
		<p align="right"><input type="radio" value="0.0" name="timeSheetConfigValue"></td>
		<td>
		<p align="left"> : Set default values to 0.0</td>
	</tr>
	
	<tr>
		<td  width="282">
		<p align="right"><input type="radio" value="8.0" name="timeSheetConfigValue"></td>
		<td >
		<p align="left"> : Set default values to 8.0
		</td>
	</tr>
	
	<tr>
		<td height="20"  colspan="2" >
		<p align="center">
		<input type="submit" value="Update" name="update" class="ButtonStyle">&nbsp;
		<input type="submit" value="Cancel" name="cancel" onclick="cancelTrigger()" class="ButtonStyle">&nbsp;
		<input type="reset" value="Reset" name="reset" class="ButtonStyle"></td>
	</tr>
</table>
</form>
</div>
<script>
	if (document.getElementsByTagName) {
	    var table = document.getElementById("reg1");
	    var rows = table.getElementsByTagName("tr");
	    for (i = 0; i < rows.length; i++) {
		    if (i % 2 == 0) {
			    rows[i].className = "even";
		    } else {
			    rows[i].className = "odd";
		    }
	    }
    }
       
</script>
