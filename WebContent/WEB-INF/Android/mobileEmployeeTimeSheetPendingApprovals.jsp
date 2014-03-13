<%@page import="java.util.Map"%>
<%@page import="com.lch.general.enums.TimeSheetStatus"%>
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

<script type="text/javascript">
	function approveOrReject(x, userId, month, year, submissionFor,
			weeklyHrsSummaryId, name, client) {
		if (x == 'Approve') {
			alert('Approving the user :' + userId + ',' + month + ',' + year);
			actiontoTake = 'adminFunctImpl.do';
			actiontoTake += '?parameter=' + document.forms[0].parameter.value
					+ '&userId=' + userId + '&status=' + 'APPROVED'
					+ '&weeklyHrsSummaryId=' + weeklyHrsSummaryId;
			alert(actiontoTake);
			var xmlHttpReq = new XMLHttpRequest();
			var id = "btnSpn" + weeklyHrsSummaryId;
			xmlHttpReq.open('POST', actiontoTake, true);
			xmlHttpReq.setRequestHeader('Content-Type',
					'application/x-www-form-urlencoded');
			xmlHttpReq.setRequestHeader('Access-Control-Allow-Origin','*');
			xmlHttpReq.onreadystatechange = function() {
				if (xmlHttpReq.readyState == 4) {
					document.getElementById(id).innerHTML = xmlHttpReq.responseText;
				}
			};
			var params = 'ajaxParam=' + escape(x);
			xmlHttpReq.send(params);
			}
		if (x == 'Reject') {
			alert('Rejecting the user :' + userId + ',' + month + ',' + year);
			actiontoTake = document.forms[0].action;
			actiontoTake += '?parameter=' + document.forms[0].parameter.value
					+ '&userId=' + userId + '&status=' + 'REJECTED'
					+ '&weeklyHrsSummaryId=' + weeklyHrsSummaryId;
			raiseRequest("btnSpn" + weeklyHrsSummaryId, actiontoTake, action);
		}
	}
</script>
<head>
<meta name="viewport" content="user-scalable=no, width=device-width" />
</head>
<div align="center">

	<span style="font-style: bold;">Time Sheets</span>
	<hr />
	<br> <span id="message"></span>

	<table border="1" cellspacing="1" class="completeTable"
		id="approvalTable" style="border-color: black; border-style: solid;">
		<tr>
			<td class="approvalsTdHeader" style="font-style: bold">Name</td>
			<td class="approvalsTdHeader" style="font-style: bold">Total Hrs</td>
			<td class="approvalsTdHeader" style="font-style: bold">Action</td>
		</tr>
		<%
			int count = 0;
		%>
		<logic:iterate id="employeeTimesheetPendingApprovalsId"
			name="employeeTimesheetPendingApprovals">

			<%
				String userId = String
							.valueOf(((Long) ((Map) employeeTimesheetPendingApprovalsId)
									.get("userId")));
					String month = String
							.valueOf(((Long) ((Map) employeeTimesheetPendingApprovalsId)
									.get("month")));
					String year = String
							.valueOf(((Long) ((Map) employeeTimesheetPendingApprovalsId)
									.get("year")));
					String submissionFor = (String) ((Map) employeeTimesheetPendingApprovalsId)
							.get("submissionFor");
					String weeklyHrsSummaryId = String
							.valueOf(((Long) ((Map) employeeTimesheetPendingApprovalsId)
									.get("weeklyHrsSummaryId")));
					String firstName = (String) ((Map) employeeTimesheetPendingApprovalsId)
							.get("firstName");
					String clientWorkingFor = (String) ((Map) employeeTimesheetPendingApprovalsId)
							.get("clientWorkingFor");
			%>

			<tr>
				<td class="tdDataForAlts"><bean:write
						name="employeeTimesheetPendingApprovalsId" property="firstName" />&nbsp;<bean:write
						name="employeeTimesheetPendingApprovalsId" property="lastName" /></td>
				<td class="tdDataForAlts"><bean:write
						name="employeeTimesheetPendingApprovalsId" property="submittedHrs" />




					<td class="tdDataForAlts"><span
					id='btnSpn<bean:write name="employeeTimesheetPendingApprovalsId" property="weeklyHrsSummaryId"/>'> <input
						type="button" value="Approve" name="approve"
						class="ApproveRejectButtonStyle"
						onclick="approveOrReject(this.value,'<%=userId%>','<%=month%>','<%=year%>','<%=submissionFor%>','<%=weeklyHrsSummaryId%>','<%=firstName%>','<%=clientWorkingFor%>')"> <input
						type="button" value="Reject" name="reject"
						class="ApproveRejectButtonStyle"
						onclick="approveOrReject(this.value,'<%=userId%>','<%=month%>','<%=year%>','<%=submissionFor%>','<%=weeklyHrsSummaryId%>','<%=firstName%>','<%=clientWorkingFor%>')">
				</span></td>

			</tr>
			<%
				count++;
			%>
		</logic:iterate>
		

	</table>

	<%
		if (count == 0) {
	%>
	<script>
		document.getElementById("message").innerHTML = "No Pending approvals found. No Action Needed.";
		document.getElementById("approvalTable").style.display = "none";
	</script> <%
 	}
 %>

				</div>

<form action="adminFunctImpl.do" method="post">
	<input name="parameter" value="approveOrRejectUserHrs" type="hidden"> <input name="userId" value="" type="hidden"> <input name="status" value="" type="hidden"> <input name="weeklyHrsSummaryId" value="" type="hidden">

</form>
<script language="JavaScript">
	function openNewWindow(url) {
		popupWin = window
				.open(
						url,
						'Attached Documents',
						', , , , , scrollbars, resizable, dependent, width=740, height=500, left=200, top=200');
	}
</script>
<script>
	if (document.getElementsByTagName) {
		var table = document.getElementById("approvalTable");
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
