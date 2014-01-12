<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<style>
.HTMLLINK { text-decoration:none;font-family: Tahoma; font-size: 10pt; color: #008080; 
               padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }
</style>


<div align="center">
	<table border="0" width="440" height="55">
		<tr>
			<td height="63" width="84" align="right"><img alt="" src="images/registration.png" width="26" height="26"></td>
			<td height="63" width="340" align="left"><html:link action="/adminFunctImpl.do?parameter=employeeRegistrationPendingApprovals" styleClass="HTMLLINK" title="Approve or Reject employees who waiting to get the access into this application">Employee Registration Pending Approvals</html:link></td>
		</tr>
		<tr>
			<td height="76" width="84" align="right"><img alt="" src="images/time.png" width="26" height="26"></td>
			<td height="76" width="340" align="left"><html:link action="/adminFunctImpl.do?parameter=employeeTimesheetPendingApprovals" styleClass="HTMLLINK" title="Approve or Reject Submitted TimeSheets by your Employees">Employee Time Sheet Pending Approvals</html:link></td>
		</tr>
	</table>
</div>
