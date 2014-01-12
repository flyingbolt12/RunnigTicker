<%@page import="com.lch.general.enums.TimerStatus"%>
<%@page import="com.lch.general.enums.TimeSheetStatus"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>


<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>

<script>
	function deleteConformation(timerId, timerName, action) {
		dhtmlx.confirm({
			title : "Not Recoverable - Are you sure? ",
			text : "Deleting " + timerName
					+ "! Jobs associated will also get deleted automatically.",
			ok : "Yes, Delete",
			cancel : "No",
			callback : function(result) {
				if (result == true) {
					submitForm(timerId, timerName, action);
				} else {
					return false;
				}
			}
		});

	}

	function submitForm(timerId, timerName, action) {

		document.forms[0].timerId.value = timerId;
		document.forms[0].status.value = action;
		document.forms[0].timerName.value = timerName;

		document.forms[0].submit();
	}
</script>

<div align="center">
	<span>-- Manage Reminders --</span>
	<hr />
	<br> <span id="message"> </span>
	<table border="0" width="100%" height="114"
		style="font-family: Tahoma; font-size: 10pt" id="customTable">

		<tr>
			<td class="approvalsTdHeader">Timer Name</td>
			<td class="approvalsTdHeader">Cron Expression</td>
			<td class="approvalsTdHeader">Email Content Name</td>
			<td class="approvalsTdHeader">Actions</td>
			<td class="approvalsTdHeader">Status</td>
		</tr>
		<%
			String timerId = "";
			String contentId = "";
			String status = "";
			String timerName = "";
			int count = 0;
		%>
		<logic:iterate id="listAllMyRemindersId" name="listAllMyReminders">
			<%
				timerId = String.valueOf(((Map) listAllMyRemindersId)
							.get("timerId"));
					contentId = String.valueOf(((Map) listAllMyRemindersId)
							.get("contentId"));
					status = String.valueOf(((Map) listAllMyRemindersId)
							.get("status"));
					timerName = String.valueOf(((Map) listAllMyRemindersId)
							.get("timerName"));
			%>
			<tr>
				<td class="tdDataForAlts">&nbsp;<bean:write
						name="listAllMyRemindersId" property="timerName"></bean:write></td>
				<td class="tdDataForAlts"><bean:write
						name="listAllMyRemindersId" property="cronExpression"></bean:write></td>

				<td class="tdDataForAlts"><bean:write
						name="listAllMyRemindersId" property="contentName"></bean:write></td>
				<td class="tdDataForAlts">
					<%
						if (status != null
									&& status.equalsIgnoreCase(TimerStatus.ACTIVE.name())) {
					%> <input type="submit" value="Disable" name="disable"
					class="ButtonStyle"
					onclick="submitForm('<%=timerId%>','<%=timerName%>','<%=TimerStatus.DISABLE.name()%>')">
					<%
						} else {
					%> <input type="submit" value="Enable" name="enable"
					class="ButtonStyle"
					onclick="submitForm('<%=timerId%>','<%=timerName%>','<%=TimerStatus.ACTIVE.name()%>')">
					<%
						}
					%> <input type="submit" value="Delete" name="delete"
					class="ButtonStyle"
					onclick="deleteConformation('<%=timerId%>','<%=timerName%>','<%=TimerStatus.DELETE.name()%>')">
				</td>
				<td class="tdDataForAlts"><bean:write
						name="listAllMyRemindersId" property="status"></bean:write></td>
			</tr>
			<%
				count++;
			%>

		</logic:iterate>
		<tr height="25">
			<td bgcolor="#F4F4F4"></td>
			<td align="center" bgcolor="#F4F4F4"></td>
			<td align="center" bgcolor="#F4F4F4"></td>
			<td align="center" bgcolor="#F4F4F4"></td>
			<td bgcolor="#F4F4F4" align="center"></td>
			<td bgcolor="#F4F4F4" align="center"></td>
		</tr>


	</table>
	<%
		if (count == 0) {
	%>
	<script>
		document.getElementById("message").innerHTML = "No Scheduled timers found. <BR><BR> <a styleClass=\"HTMLLINK\" title=\"Set the timer's to deliver the email listings automatically.\" href=\"adminFunctImpl.do?parameter=showTimerCreationPage\">Click here to create one</a>";
		document.getElementById("customTable").style.display = "none";
	</script>
	<%
		}
	%>
</div>
<form action="adminTimer.do">
	<input name="parameter" value="updateTimerStatus" type="hidden">
	<input name="timerId" value="" type="hidden"> <input
		name="status" value="" type="hidden"> <input name="timerName"
		value="" type="hidden">
</form>
<script>
if (document.getElementsByTagName) {
    var table = document.getElementById("customTable");
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
