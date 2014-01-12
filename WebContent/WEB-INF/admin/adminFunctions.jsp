<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${isEmployerNotified == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Employer Notified." });
	</script>
</c:if>
<c:if test="${isNotified == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"<%= request.getAttribute("status")%>" });
	</script>
</c:if>
<c:if test="${passwordUpdated == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Password Updated Successfully" });
	</script>
</c:if>
<c:if test="${isAdminSettingsUpdated == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"<%= request.getAttribute("status")%>" });
	</script>
</c:if>

<%
	String status = (String) request.getAttribute("adminAdded");
	if (status != null && status.length() > 0) {
%>
<script>
	dhtmlx.message({type:"error", expire:6000, text:"Admin Created." });</script>
<%
	}
%>

<style>

.HTMLLINK {
	text-decoration: none;
	font-family: Tahoma;
	font-size: 10pt;
	padding-left: 10px;
	padding-right: 10px;
	padding-top: 1px;
	padding-bottom: 1px;
}

.HTMLHIDDENLINK {
	display: none;
}

.tdHeader {
	background: rgb(181, 189, 200); /* Old browsers */
	/* IE9 SVG, needs conditional override of 'filter' to 'none' */
	background:
		url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2I1YmRjOCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjAlIiBzdG9wLWNvbG9yPSIjODI4Yzk1IiBzdG9wLW9wYWNpdHk9IjEiLz4KICAgIDxzdG9wIG9mZnNldD0iMTAwJSIgc3RvcC1jb2xvcj0iIzI4MzQzYiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgPC9saW5lYXJHcmFkaWVudD4KICA8cmVjdCB4PSIwIiB5PSIwIiB3aWR0aD0iMSIgaGVpZ2h0PSIxIiBmaWxsPSJ1cmwoI2dyYWQtdWNnZy1nZW5lcmF0ZWQpIiAvPgo8L3N2Zz4=);
	background: -moz-linear-gradient(top, rgba(181, 189, 200, 1) 0%, rgba(130, 140, 149, 1) 0%, rgba(40, 52, 59, 1) 100% ); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, rgba(181,189, 200, 1) ), color-stop(0%, rgba(130, 140, 149, 1) ),
		color-stop(100%, rgba(40, 52, 59, 1) ) ); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top, rgba(181, 189, 200, 1) 0%,rgba(130, 140, 149, 1) 0%, rgba(40, 52, 59, 1) 100% );
	/* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top, rgba(181, 189, 200, 1) 0%,rgba(130, 140, 149, 1) 0%, rgba(40, 52, 59, 1) 100% );
	/* Opera 11.10+ */
	background: -ms-linear-gradient(top, rgba(181, 189, 200, 1) 0%,	rgba(130, 140, 149, 1) 0%, rgba(40, 52, 59, 1) 100% ); /* IE10+ */
	background: linear-gradient(to bottom, rgba(181, 189, 200, 1) 0%,rgba(130, 140, 149, 1) 0%, rgba(40, 52, 59, 1) 100% ); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient(  startColorstr='#b5bdc8',endColorstr='#28343b', GradientType=0 ); /* IE6-8 */
	color: #FFFFFF;
	font-size: 10pt;
	font-weight: bold;
}
</style>


<div align="center">
	<table border="0" width="100%" id="table1" cellspacing="20"
		cellpadding="5">
		<tr>
			<td height="18" colspan="2" class="tdHeader"><font
				class="headerLinks">Listing &amp; Searching</font></td>
			<td colspan="2" class="tdHeader"><font class="headerLinks">Operations</font></td>
		</tr>
		<tr>
			<td width="25"><p>&nbsp;</td>
			<td width="235">
				<table border="0" id="table3">
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK" 
								title= "Displays the list of all your employees in a single page"
								action="/adminFunctImpl.do?parameter=listAllEmployees">
		List all my employees</html:link></td>
					</tr>
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Performs a search"
								action="/adminFunctImpl.do?parameter=searchOptions">
		Find employee(s)</html:link></td>	
					</tr>
				</table>
			</td>
			<td width="25">&nbsp;</td>
			<td width="235" rowspan="5">
				<table border="0" id="table6">
				
				<tr height="50">
						<td><b><font SIZE="2"> </font></b></td>
						<td><b><font SIZE="2"> Approval Management Links </font></b></td>
				</tr>					
				
				
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Shows employee requests that requires employer approval."
								action="/genericForwardAction.do?forwardTo=admin/pendingApprovals/pendingApprovals">
		Pending Approvals</html:link></td>
					</tr>
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Lets Active/Deactive stoping the employee to submit the Timesheets."
								action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=ACTIVATE_DEACTIVATE">
		Activate/Deactivate an Employee</html:link></td>
					</tr>
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK" title="Manage the approved timesheets."	
								action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=LIST_TIMESHEETS_FOR_ADMIN">
		Manage Approved TimeSheets</html:link></td>
					</tr>					
					<tr height="50">
						<td><b><font SIZE="2"> </font></b></td>
						<td><b><font SIZE="2"> Admin & Employee Management Links </font></b></td>
				</tr>	
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Create new Admin."
								action="/adminFunctImpl.do?parameter=createAnotherAdmin">
		Create Another Admin</html:link></td>
					</tr>
					<tr>
						<td><font SIZE="2"><b>»</b></font></td>
						<td><html:link styleClass="HTMLLINK"
								title="Helps in managing the Admins."
								action="/adminFunctImpl.do?parameter=manageMyAdmins">
		Manage my Admins</html:link></td>
					</tr>
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Register a new Employee."
								action="/adminFunctImpl.do?parameter=addAnEmployeeOptions">
		Add an Employee</html:link></td>
					</tr>
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Notifies employee to update his/her profile"
								action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=EMP_UPDATE">
		Request employee to update profile</html:link></td>
					</tr>
					
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Notifies all employees to update their profiles" onclick="confirmlinkForRequestAllEmployeesToUpdateTheirProfiles()"
								href="#">
		Request all employees to update their profiles</html:link></td>
					</tr>
				
					<tr height="50">
						<td><b><font SIZE="2"> </font></b></td>
						<td><b><font SIZE="2"> Timer Management Links </font></b></td>
					</tr>					
					
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Set the timer's to deliver the email listings automatically."
								action="/adminFunctImpl.do?parameter=showTimerCreationPage">
		Set Regular Email Reminder</html:link></td>
					</tr>
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Manage the reminders."
								action="/adminFunctImpl.do?parameter=showManageTimersPage">
		Manage Timers</html:link></td>
					</tr>

					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK" title="Manage the approved timesheets."	
								action="/adminTimer.do?parameter=showManageEmailContentsPage">
		Manage Email Contents</html:link></td>
					</tr>


				</table>
			</td>
		</tr>
		<tr>
			<td height="18" colspan="2" class="tdHeader"><font
				class="headerLinks">Notifications</font></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<table border="0" id="table4">

					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Send message to employees(based on their category)."
								action="/adminFunctImpl.do?parameter=makeGenericEmail">
		Notify employees</html:link></td>
					</tr>
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Sends an email to you with your comapny unique id"
								action="/adminFunctImpl.do?parameter=viewMyUniqueNumberOptions">
		Company Unique Id</html:link></td>
					</tr>
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleId="sendlink" onclick="confirmlink()"
								href="#" styleClass="HTMLLINK"
								title="Sends an email having comapny unique id to all employees, for their registration purpose">
		Notify Company Id to Employees</html:link></td>
					</tr>
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleId="sendlink"
								action="/adminFunctImpl.do?parameter=showNotifyEmailsPage"
								styleClass="HTMLLINK"
								title="Sends an email with comapny unique id to the listed emails(not neccessarily the employees).">
		Notify Company Id to Emails</html:link></td>
					</tr>
					<tr>
						<td><b><font SIZE="2">»</font></b></td>
						<td><html:link styleClass="HTMLLINK"
								title="Recommend ILCH"
								action="/adminFunctImpl.do?parameter=inviteOtherBusinessOptions">
		Recommend us</html:link></td>
					</tr>
				</table>
			</td>
			<td rowspan="3">&nbsp;</td>
		</tr>
		<tr>
			<td height="18" colspan="2" class="tdHeader"><font
				class="headerLinks">General</font></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<table border="0" id="table5">
					<tr>
						<td height="23"><b><font SIZE="2">»</font></b></td>
						<td height="23"><html:link styleClass="HTMLLINK"
								title="Lists out useful reports."
								action="/adminFunctImpl.do?parameter=reports">
		Reports</html:link></td>
					</tr>
					<tr>
						<td height="23"><b><font SIZE="2">»</font></b></td>
						<td height="23"><html:link styleClass="HTMLLINK"
								title="Account Settings"
								action="/genericForwardAction.do?forwardTo=admin/adminAccountSettings">
		Account Settings</html:link></td>
					</tr>
					<tr>
						<td height="23"><b><font SIZE="2">»</font></b></td>
						<td height="23"><html:link styleClass="HTMLLINK"
								title="Reset an Employee Password"
								action="/adminFunctImpl.do?parameter=searchOptions&&featureRequest=EMP_PASSWORD_RESET">
		Reset Employee Password</html:link></td>
					</tr>
					<tr>
						<td height="23"><b><font SIZE="2">»</font></b></td>
						<td height="23">
					<html:link styleClass="HTMLLINK"
					title="Update  Business Logo"
					action="/adminFunctImpl.do?parameter=showLogoUpdatePage">
		Update Logo</html:link></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>	
</div>

<form action="adminFunctImpl.do?parameter=sendBusinessIdToAllMyEmployees" method="POST">
<input type="hidden" name="parameter">
</form>
<script>
	function confirmlink() {

		var msg = "Do you want to send email with Business Id to all your employees?";
		
		dhtmlx.confirm({ title: "Confirmation Needed", text:msg, ok:"Yes", cancel:"No", callback:function(result){ 
			if (result == true) {
				document.forms[0].parameter.value="sendBusinessIdToAllMyEmployees";
				document.forms[0].submit();
			}
		 }});

	}
	
	function confirmlinkForRequestAllEmployeesToUpdateTheirProfiles() {

		var msg = "Do you want to Notify all your employees to update their profiles?";
		
		dhtmlx.confirm({ title: "Confirmation Needed", text:msg, ok:"Yes", cancel:"No", callback:function(result){ 
			if (result == true){
				document.forms[0].parameter.value="requestAllEmployeesToUpdateTheirProfiles";
				document.forms[0].submit();
			}
		 }});

	}
	
</script>

