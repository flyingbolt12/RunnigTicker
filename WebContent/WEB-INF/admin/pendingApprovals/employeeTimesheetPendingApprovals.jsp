<%@page import="com.lch.general.generalBeans.UserProfile"%>
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
<script>

function approveOrRejectAll(xAction)
{
	elements = document.getElementsByTagName('input');
	var allElements = '';
	var count =0;
	var idArr = new Array();
	dataAlert(xAction);
	for(i=0;i<elements.length;++i)
	{
		if(elements[i].type=='checkbox')
		{
			if(elements[i].checked)
			{
				x = elements[i].value;
				if(x != 'selectAll' && x != 'deSelectAll')
				{
					++count;
					x = x.substring(6,x.length);
					idArr[count] = x;
					if(count>1)
						allElements += ","+x;
					else
						allElements += x;
				}
			}
		}
	}
	if(allElements.length ==0)
	{
		//dhtmlx.confirm({ title: "Invalid Action", text:"OOPs! select some users"});
		dhtmlx.message({type:"error", expire:6000, text:"OOPs! select some users" });
		return;
	}
	actiontoTake = 'adminFunctImpl.do?';
	actiontoTake+='parameter=approveOrRejectAllPendingTimeSheets&weeklyHrsSummaryIds='+allElements;

	for(i=1;i<=count;++i)
	{
		removeCheckBox="selectAllCheckBoxSpn"+idArr[i];
		document.getElementById(removeCheckBox).innerHTML="";
		document.getElementById("btnSpn"+idArr[i]).innerHTML="<img border=\"0\" src=\"images/small-ajax-loader.gif\"></img>";
		document.getElementById("statusSpan"+idArr[i]).innerHTML=" -- ";
	}
	var statusArr = new Array();
	for(i=1;i<=count;++i)
	{
		statusArr[i] = "btnSpn"+idArr[i];
	}
	
	raiseRequest4NotDisplayUpdate("approveOrRejectAllSpan",actiontoTake, xAction, statusArr);
}
function approveOrReject(x,userId,month,year,submissionFor,weeklyHrsSummaryId, name, client)
{
	if(x=='Approve')
	{
		var box = dhtmlx.modalbox({ 
			title:"Approve", 
			text:name+" working for "+client+"<br><div id='form_in_box'><div><label> Comments if any : <br><textarea id='commentsForm' class='inform' rows='5' cols='30'></textarea></label><div><div><div>"
			+"<br><span class='dhtmlx_button'><input type='button' value='Approve' onclick=\"save_approve_callback(this,"+userId+","+month+","+year+",'"+submissionFor+"',"+weeklyHrsSummaryId+")\" style='width:100px;'></span>"
			+"<span class='dhtmlx_button'><input type='button' value='Cancel' onclick='cancel_callback(this)' style='width:100px;'></span>",
			width:"300px",
			height : "255px"
		});
	}
	if(x=='Reject')
	{
		var box = dhtmlx.modalbox({ 
			title:"Reject", 
			text:name+" working for "+client+"<br><div id='form_in_box'><div><label> Comments if any : <br><textarea id='commentsForm' class='inform' rows='5' cols='30'></textarea></label><div><div><div>"
			+"<br><span class='dhtmlx_button'><input type='button' value='Reject' onclick=\"save_reject_callback(this,"+userId+","+month+","+year+",'"+submissionFor+"',"+weeklyHrsSummaryId+")\" style='width:100px;'></span>"
			+"<span class='dhtmlx_button'><input type='button' value='Cancel' onclick='cancel_callback(this)' style='width:100px;'></span>",
			width:"300px",
			height : "255px"
		});
	}
}
function save_approve_callback(box, userId,month,year,submissionFor, weeklyHrsSummaryId){
	var comments = document.getElementById('commentsForm').value;
	dhtmlx.modalbox.hide(box);
	updateAndSubmitForm(userId,month,year,'<%=TimeSheetStatus.APPROVED.name()%>', submissionFor, weeklyHrsSummaryId,comments);
}   
function save_reject_callback(box, userId,month,year,submissionFor, weeklyHrsSummaryId){
	var comments = document.getElementById('commentsForm').value;
	dhtmlx.modalbox.hide(box);
	updateAndSubmitForm(userId,month,year,'<%=TimeSheetStatus.REJECTED.name()%>', submissionFor, weeklyHrsSummaryId,comments);
}
function cancel_callback(box){
	dhtmlx.message("Operation Cancelled...");
	dhtmlx.modalbox.hide(box);
}
    function selectOrDeSelectAll() {
	    x = document.getElementById('selectAllCheckBox').value;
	    if (x == 'selectAll') {
		    document.getElementById('selectAllCheckBox').value = 'deSelectAll';
		    toSelectOrDeselect(true);
		    
	    }
	    if (x == 'deSelectAll') {
		    document.getElementById('selectAllCheckBox').value = 'selectAll';
		    toSelectOrDeselect(false);
	    }
    }
    function toSelectOrDeselect(v) {
	    
	    elements = document.getElementsByTagName('input');
	    for (i = 0; i < elements.length; ++i) {
		    if (elements[i].type == 'checkbox') {
			    elements[i].checked = v;
		    }
	    }
    }
    function updateTopCheckBox(object) {
	    if (object.checked == false) {
		    document.getElementById('selectAllCheckBox').checked = false;
		    document.getElementById('selectAllCheckBox').value = 'selectAll';
	    }
    }
    function updateAndSubmitForm(userId, month, year, action, submissionFor, weeklyHrsSummaryId, comments) {
	    actiontoTake = document.forms[0].action;
	    actiontoTake += '?parameter=' + document.forms[0].parameter.value + '&userId=' + userId + '&status=' + action + '&weeklyHrsSummaryId='
	            + weeklyHrsSummaryId + '&comments=' + comments;
	    removeCheckBox = "selectAllCheckBox" + weeklyHrsSummaryId;
	    var topRootDiv = document.getElementById("selectAllCheckBoxSpn" + weeklyHrsSummaryId);
	    topRootDiv.removeChild(document.getElementById(removeCheckBox));
	    raiseRequest("btnSpn" + weeklyHrsSummaryId, actiontoTake, action);
    }
</script>
<% UserProfile userProfile = (UserProfile) session.getAttribute("userProfile"); %>
<div align="center">

	<span>Time Sheets</span>
	<hr />
	<br> <span id="message"></span>

	<table border="0" cellspacing="1"  class="completeTable" id="approvalTable">
		<tr>
			<td  class="approvalsTdHeader">Name</td>
			<td  class="approvalsTdHeader">Client working for</td>
			<td  class="approvalsTdHeader">Time Sheet Type</td>
			<td  class="approvalsTdHeader">Total Hrs - RH/OT/HH : Start - End Weeks</td>
			<td  class="approvalsTdHeader">Status</td>
			<td  class="approvalsTdHeader">Attached Docs</td>
			<td  class="approvalsTdHeader"><input type="checkbox" id="selectAllCheckBox" name="selectAllCheckBox" value="selectAll" onclick="selectOrDeSelectAll(this.value)"></td>
			<td  class="approvalsTdHeader">Action</td>
			<% if(userProfile.isAdmin()) {%>
			<td  class="approvalsTdHeader" width="150px">Invoice</td>
			<%} %>
		</tr>
		<%
			int count = 0;
		%>
		<logic:iterate id="employeeTimesheetPendingApprovalsId" name="employeeTimesheetPendingApprovals">

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
					String clientWorkingFor = (String) ((Map) employeeTimesheetPendingApprovalsId).get("clientWorkingFor");
					String clientId = (Long) ((Map) employeeTimesheetPendingApprovalsId).get("clientId") + "";
			%>

			<tr>
				<td  class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="firstName" />&nbsp;<bean:write name="employeeTimesheetPendingApprovalsId" property="middleName" />&nbsp;<bean:write
						name="employeeTimesheetPendingApprovalsId" property="lastName" /></td>
				<td  class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="clientWorkingFor" /></td>
				<td  class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="timeSheetConfiguredTo" /></td>
				<td  class="tdDataForAlts"><bean:write name="employeeTimesheetPendingApprovalsId" property="submittedHrs" />&nbsp;-&nbsp;<bean:write name="employeeTimesheetPendingApprovalsId" property="totalRegularHrs" />/<bean:write
						name="employeeTimesheetPendingApprovalsId" property="totalOvertimeHrs" />/<bean:write name="employeeTimesheetPendingApprovalsId" property="totalHolidayHrs" /> : <bean:write name="employeeTimesheetPendingApprovalsId" property="startWeekDate" />&nbsp;-&nbsp;<bean:write
						name="employeeTimesheetPendingApprovalsId" property="endWeekDate" /></td>
				<td  class="tdDataForAlts"><span id='statusSpan<%=weeklyHrsSummaryId%>'><bean:write name="employeeTimesheetPendingApprovalsId" property="status" /></span></td>
				<td  class="tdDataForAlts">
					<%
						String id = (String) ((Map) employeeTimesheetPendingApprovalsId)
									.get("supportingDocIds");
							if (!id.equals("0")) {
								String url = "downloadAFile.do?id="+weeklyHrsSummaryId+"&action=timeSheets";
					%> <a href=javascript:openNewWindow('<%=url%>')>Click</a> <%
 	} else {
 %> N/A<%
 	}
 %>
				</td>

				<td  class="tdDataForAlts"><span id='selectAllCheckBoxSpn<%=weeklyHrsSummaryId%>'> <input type="checkbox" id="selectAllCheckBox<%=weeklyHrsSummaryId%>" value="select<%=weeklyHrsSummaryId%>"
						onclick="updateTopCheckBox(this)">
				</span></td>

				<td  class="tdDataForAlts"><span id='btnSpn<bean:write name="employeeTimesheetPendingApprovalsId" property="weeklyHrsSummaryId"/>'> <input type="button" value="Approve" name="approve" 
						class="ApproveRejectButtonStyle" onclick="approveOrReject(this.value,'<%=userId%>','<%=month%>','<%=year%>','<%=submissionFor%>','<%=weeklyHrsSummaryId%>','<%=firstName%>','<%=clientWorkingFor%>')"> <input type="button" value="Reject"
						name="reject"  class="ApproveRejectButtonStyle" onclick="approveOrReject(this.value,'<%=userId%>','<%=month%>','<%=year%>','<%=submissionFor%>','<%=weeklyHrsSummaryId%>','<%=firstName%>','<%=clientWorkingFor%>')">
				</span></td>

			<% if(userProfile.isAdmin()) {%>
				<td  class="tdDataForAlts"><span id="invoice_<%= weeklyHrsSummaryId%>"><a href="javascript:loadInvoiceDetails(<%= weeklyHrsSummaryId%>, <%=clientId%>, <%=userId%>)">Load Invoice</a></span></td>
			<%} %>
			
			</tr>
			<%
				count++;
			%>
		</logic:iterate>
		<tr>
			<td  class="approvalsTdHeader" colspan="<%= (userProfile.isAdmin()?9:8)%>">
				<p align="right">
					<input type="button" value="ApproveAll" id="approveAll"  class="ApproveRejectButtonStyle" onclick="approveOrRejectAll(this.value)"> <input type="button" value="RejectAll" id="rejectAll" 
						class="ApproveRejectButtonStyle" onclick="approveOrRejectAll(this.value)">
			</td>
			<span id="approveOrRejectAllSpan"></span>
		</tr>

	</table>

	<%
		if (count == 0) {
	%>
	<script>
		document.getElementById("rejectAll").disabled = true;
        document.getElementById("approveAll").disabled = true;
        document.getElementById("message").innerHTML = "No Pending approvals found. No Action Needed.";
        document.getElementById("approvalTable").style.display = "none";
	</script>
	<%
		}
	%>
</div>

<form action="adminFunctImpl.do" method="post">
	<input name="parameter" value="approveOrRejectUserHrs" type="hidden"> <input name="userId" value="" type="hidden"> <input name="status" value="" type="hidden"> <input name="weeklyHrsSummaryId" value="" type="hidden">

</form>
<script language="JavaScript">
	function openNewWindow(url) {
	    popupWin = window.open(url, 'Attached Documents', ', , , , , scrollbars, resizable, dependent, width=740, height=500, left=200, top=200');
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

function loadInvoiceDetails(weeklyHrsSummaryId, clientId, userId){
	
	 var params = {
			 weeklyHrsSummaryId : weeklyHrsSummaryId,
			 clientId:clientId,
			 userId:userId,
			 loadFromUserRateTable:"yes"
	    };
	    var obj = {
	    id : "invoice_"+weeklyHrsSummaryId,
	    url : "adminFunctImpl.do?parameter=loadInvoiceDetails",
	    params : params,
	    responseHandler : handleInvoiceResponse
	    };
	    sendAjaxRequest(obj);
	    
}   

function handleInvoiceResponse(obj, response) {
   removeAjaxImg(obj.id);

   if (response != null)
	    response = response.replace("disableSubmitRequired", "");
   placeAjaxMessage(obj.id, response);
   
}
</script>