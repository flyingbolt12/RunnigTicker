<%@page import="java.util.Map"%>
<%@page import="com.lch.general.enums.TimeSheetStatus"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<div align="center">
	<table border="0" cellspacing="1" width="100%" style="font-family: Tahoma; font-size: 10pt">
		<tr>
			<td nowrap="nowrap" class="approvalsTdHeader">Client working for</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Total over time Hrs</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Total Holiday Hrs</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Total Hours Submitted</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Start Week Date</td>
			<td nowrap="nowrap" class="approvalsTdHeader">End Week Date</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Submitted Date</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Status</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Action Date</td>
			<td nowrap="nowrap" class="approvalsTdHeader">BUZZ</td>
		</tr>
		<logic:iterate id="employeeTimesheetPendingApprovalsId" name="employeeTimesheetPendingApprovals">
			<tr>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeTimesheetPendingApprovalsId" property="clientName" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeTimesheetPendingApprovalsId" property="totalOvertimeHrs" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeTimesheetPendingApprovalsId" property="totalHolidayHrs" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeTimesheetPendingApprovalsId" property="totalHrsSubmitted" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeTimesheetPendingApprovalsId" property="startWeekDate" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeTimesheetPendingApprovalsId" property="endWeekDate" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeTimesheetPendingApprovalsId" property="submittedDate" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeTimesheetPendingApprovalsId" property="status" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeTimesheetPendingApprovalsId" property="actionDate" /></td>
				<td nowrap="nowrap" class="approvalsTdBody">
					<%
						String status = (String) ((Map) employeeTimesheetPendingApprovalsId).get("status");
							String weeklyHrsSummaryId = (Long) ((Map) employeeTimesheetPendingApprovalsId).get("weeklyHrsSummaryId") + "";
							String action = "memberFunctImpl.do?weeklyHrsSummaryId=" + weeklyHrsSummaryId + "&parameter=buzzForTimeSheetApproval";
							String spanId = "weeklyHrsSummaryId_" + weeklyHrsSummaryId;
							if (status.equals(TimeSheetStatus.PENDING.name()) || status.equals(TimeSheetStatus.REJECTED.name())) {
					%> <span id="<%=spanId%>"> <input type="button" name="buzz" class="ButtonStyle" value="BUZZ" onclick="raiseRequest('<%=spanId%>','<%=action%>', null);">
				</span> <%
 	} else {
 %>N/A<%
 	}
 %>
				</td>
			</tr>
		</logic:iterate>

	</table>
</div>
<br>
