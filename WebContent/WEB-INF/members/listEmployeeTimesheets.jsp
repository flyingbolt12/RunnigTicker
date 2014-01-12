<%@page import="java.util.Map"%>
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
			int count = 0;
		%>

<span> Status of Time Sheets  & Manage Attachments </span>
	<hr/>
	<br> <span id="message"></span>
	<table border="0" cellspacing="1" class="completeTable" id="manageTimeSheets">
		<tr>
			<td class="approvalsTdHeader">Client working for</td>
			<td class="approvalsTdHeader">Total over time Hrs</td>
			<td class="approvalsTdHeader">Total Holiday Hrs</td>
			<td class="approvalsTdHeader">Total Hours Submitted</td>
			<td class="approvalsTdHeader">Start Week Date</td>
			<td class="approvalsTdHeader">End Week Date</td>
			<td class="approvalsTdHeader">Submitted Date</td>
			<td class="approvalsTdHeader">TimeSheet Type</td>
			<td class="approvalsTdHeader">Attached Docs</td>
			<td class="approvalsTdHeader">Status</td>
			<td class="approvalsTdHeader">Comments</td>
			<td class="approvalsTdHeader">Action Date</td>
			<td class="approvalsTdHeader">Manage Attached Docs</td>
		</tr>
		<logic:iterate id="employeeTimesheetPendingApprovalsId" name="employeeTimesheetPendingApprovals">
			<tr>
				<td class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="clientName" /></td>
				<td class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="totalOvertimeHrs" /></td>
				<td class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="totalHolidayHrs" /></td>
				<td class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="totalHrsSubmitted" /></td>
				<td class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="startWeekDate" /></td>
				<td class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="endWeekDate" /></td>
				<td class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="submittedDate" /></td>
				<td class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="submissionConfiguredTo" /></td>
				<td class="tdDataForAlts">
				
					<%
						String id = (String) ((Map) employeeTimesheetPendingApprovalsId)
									.get("supportingDocIds");
							if (!id.equals("0")) {
					%> <a href=javascript:openNewWindow('downloadAFile.do?id=<bean:write name="employeeTimesheetPendingApprovalsId" property="weeklyHrsSummaryId"/>&action=timeSheets')>Click</a> <%
 	} else {
 %> N/A<%
 	}
 %>
				</td>
				<td class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="status" /></td>
				<td class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="comments" /></td>
				<td class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="actionDate" /></td>
				<td class="tdDataForAlts">
					<%
						String status = (String) ((Map) employeeTimesheetPendingApprovalsId)
									.get("status");
							if (!status.equals("APPROVED")) {
					%> <input type="button" value="Manage Attachments" class="ButtonStyle" name="enabledButton"
					onclick="manageAttachements(<bean:write name="employeeTimesheetPendingApprovalsId" property="weeklyHrsSummaryId"/>,'Hours Submitted : <bean:write name="employeeTimesheetPendingApprovalsId" property="recentHrs"/> <BR>TimeSheet Type : <bean:write name="employeeTimesheetPendingApprovalsId" property="submissionConfiguredTo" />, Client  : <bean:write name="employeeTimesheetPendingApprovalsId" property="clientName" />')">
					<%
						} else {
					%> <input type="button" value="Manage Attachments" onclick="showMsg()" class="ButtonStyleDisabled" name="disabledButton"> <%
 	}
 %>
				</td>
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
        document.getElementById("message").innerHTML = "No Timesheets found. No Action Needed.";
        document.getElementById("manageTimeSheets").style.display = "none";
	</script>
	<%
		}
	%>
</div>
<form action="memberFunctImpl.do" method="post">
	<input type="hidden" name="weeklyHrsSummaryId"> <input type="hidden" name="managingFor"> <input type="hidden" value="showManageDocs" name="parameter">
</form>
<script language="JavaScript">

if (document.getElementsByTagName) {
    var table = document.getElementById("manageTimeSheets");
    var rows = table.getElementsByTagName("tr");
    for (i = 0; i < rows.length; i++) {
	    if (i % 2 == 0) {
		    rows[i].className = "even";
	    } else {
		    rows[i].className = "odd";
	    }
    }
}

 
function manageAttachements(weeklyHrsSummaryId, managingFor) {
 document.forms[0].weeklyHrsSummaryId.value = weeklyHrsSummaryId;
 document.forms[0].managingFor.value = managingFor;
 document.forms[0].submit();
}
 
function openNewWindow(url) {
 popupWin = window.open(url, 'Attached Documents', ', , , , , scrollbars, resizable, dependent, width=740, height=500, left=200, top=200');
}

function showMsg() {
	dhtmlx.message({type:"error", expire:6000, text:"You can't manage already approved timesheets" });
}


 </script>
