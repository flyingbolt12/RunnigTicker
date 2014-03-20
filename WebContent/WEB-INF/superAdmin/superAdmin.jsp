<%@page import="com.lch.general.enums.DOCTypes"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${demoUsres == 'yes'}">
	<script>
		dhtmlx.message({
        type : "error",
        expire : 6000,
        text : "Demo Users Available"
        });
	</script>
</c:if>

<style>
.HTMLLINK {
	text-decoration: none;
	font-family: Tahoma;
	font-size: 10pt;
	color: #008080;
	padding-left: 4px;
	padding-right: 4px;
	padding-top: 1px;
	padding-bottom: 1px
}

.HTMLHIDDENLINK {
	display: none;
}
</style>

<div align="center">
	<br>
	<br>
	<br>
	<table border="0" width="513" height="142" style="font-family: Tahoma; font-size: 10pt">
		<tr>
			<td height="8" width="48" align="right"></td>
			<td height="8" width="154" align="left"></td>
			<td height="8" width="48" align="right"></td>
			<td height="8" width="235" align="left"></td>
		</tr>
		<tr>
			<td height="18" width="48" align="right"><font face="Times New Roman">»</font></td>
			<td height="18" width="154" align="left">&nbsp;<html:link action="/superAdminFunctImpl.do?parameter=showOutagePage" styleClass="HTMLLINK" title="Set Outage Date Time">Set Outage Notification</html:link></td>
			<td height="18" width="48" align="right"><font face="Times New Roman">»</font></td>
			<td height="18" width="235" align="left">&nbsp;<html:link action="/superAdminFunctImpl.do?parameter=showDisableBusinessPage" styleClass="HTMLLINK" title="Enable or Disable a Client">Enable or Disable Business</html:link>
			</td>
		<tr>
			<td height="18" width="48" align="right"><font face="Times New Roman">»</font></td>
			<td height="18" align="left" nowrap>&nbsp;<html:link action="/superAdminFunctImpl.do?parameter=createDemoUsers" styleClass="HTMLLINK" title="Create Demo users" onclick="showAjaxLoader('ajaxImg')">Create Demo users</html:link><span
				id="ajaxImg" /></td>
			<td height="18" width="48" align="right"><font face="Times New Roman">»</font></td>
			<td height="18" width="235" align="left">&nbsp;<html:link action="/superAdminFunctImpl.do?parameter=removeOutage" styleClass="HTMLLINK" title="Remove Outage">Remove Outage Notification</html:link>

			</td>
		</tr>

		<tr>
			<td height="18" width="48" align="right"><font face="Times New Roman">»</font></td>
			<td height="18" align="left" nowrap>&nbsp;<html:link action="/superAdminFunctImpl.do?parameter=enbleBusinessForTestingPurpose" styleClass="HTMLLINK" title="enbleBusinessForTestingPurpose - not for regular use">EnbleBusinessForTestingPurpose</html:link></td>
			<td height="18" width="48" align="right"><font face="Times New Roman">»</font></td>
			<td height="18" width="235" align="left">&nbsp;<html:link action="/superAdminFunctImpl.do?parameter=triggerBdayJobs" styleClass="HTMLLINK" title="Remove Outage">Trigger B'day Job</html:link></td>
		</tr>

		<tr>
			<td height="18" width="48" align="right"><font face="Times New Roman">»</font></td>
			<td height="18" align="left" nowrap><html:link action="/superAdminFunctImpl.do?parameter=showInvitationEmailPage" styleClass="HTMLLINK" title="Send Invitation Email">Send Invitation Email</html:link></td>
			<td height="18" width="48" align="right"><font face="Times New Roman">»</font></td>
			<td height="18" width="235" align="left">&nbsp;<html:link action="/superAdminFunctImpl.do?parameter=triggerImmigrationJobs" styleClass="HTMLLINK" title="Remove Outage">Trigger Immigration Job</html:link></td>
		</tr>
	</table>
	<br>
	<br>
	<br>
</div>
