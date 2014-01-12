<%@page import="java.util.Map"%>
<%@page import="com.lch.general.enums.TimeSheetStatus"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<style>
<!--
.BusinessTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }

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
		alert('Please select users');
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
		dhtmlx.confirm({ title: "Approving the timesheet for user", text:name+" working for "+client, ok:"Approve", cancel:"No", callback:function(result){ 
			if (result == true) {
				updateAndSubmitForm(userId,month,year,'<%= TimeSheetStatus.APPROVED.name()%>',submissionFor,weeklyHrsSummaryId);
			} else {return false;}
		 }});
	}
	if(x=='Reject')
	{
		dhtmlx.confirm({ title: "Rejecting timesheet for the user", text:name+" working for "+client, ok:"Reject", cancel:"No", callback:function(result){ 
			if (result == true) {
				updateAndSubmitForm(userId,month,year,'<%= TimeSheetStatus.REJECTED.name()%>',submissionFor,weeklyHrsSummaryId);
			} else {return false;}
		 }});
	}
}
function selectOrDeSelectAll()
{
	x = document.getElementById('selectAllCheckBox').value;
	if(x == 'selectAll')
	{
		document.getElementById('selectAllCheckBox').value='deSelectAll';
		toSelectOrDeselect(true);
		
	}
	if(x == 'deSelectAll')
	{
		document.getElementById('selectAllCheckBox').value='selectAll';
		toSelectOrDeselect(false);
	}
}
function toSelectOrDeselect(v)
{
	 
	elements = document.getElementsByTagName('input');
	for(i=0;i<elements.length;++i)
	{
		if(elements[i].type=='checkbox')
		{
			elements[i].checked=v;
		}
	}
}
function updateTopCheckBox(object)
{
	if(object.checked==false)
	{
		document.getElementById('selectAllCheckBox').checked=false;
		document.getElementById('selectAllCheckBox').value='selectAll';
	}
}
function updateAndSubmitForm(userId,month,year,action,submissionFor,weeklyHrsSummaryId)
{
	actiontoTake = document.forms[0].action;
	actiontoTake+= '?parameter='+document.forms[0].parameter.value+'&userId='+userId+'&status='+action+'&weeklyHrsSummaryId='+weeklyHrsSummaryId;
	//removeCheckBox="selectAllCheckBox"+weeklyHrsSummaryId;
	//var topRootDiv = document.getElementById("selectAllCheckBoxSpn"+weeklyHrsSummaryId);
	//topRootDiv.removeChild(document.getElementById(removeCheckBox));
	raiseRequest("btnSpn"+weeklyHrsSummaryId,actiontoTake, action);
}
</script>
<div align="center" >


<span>Approved/Rejected Time Sheets</span>
<hr/> <br>

	<table border="0" cellspacing="1" class="completeTable" width="100%">
		<tr>
			<td class="tdHeader"> Name </td>
			<td class="tdHeader"> Client working for</td>
			<td class="tdHeader"> Time Sheet Type</td>
			<td class="tdHeader"> Total Hrs - RH/OT/HH : Start - End Weeks</td>
			<td class="tdHeader"> Status</td>
			<td class="tdHeader"> Attached Docs</td>
			<td class="tdHeader"> Action</td>
		</tr>
<logic:iterate id="listTimeSheetsForAdmin" name="timeSheetsForAdminList">
		<tr>
			<td class="tdData"><bean:write name="listTimeSheetsForAdmin" property="firstName"/>&nbsp;<bean:write name="listTimeSheetsForAdmin" property="middleName"/>&nbsp;<bean:write name="listTimeSheetsForAdmin" property="lastName"/></td>
			<td class="tdData"><bean:write name="listTimeSheetsForAdmin" property="clientWorkingFor"/></td>
			<td class="tdData"><bean:write name="listTimeSheetsForAdmin" property="timeSheetConfiguredTo"/></td>
			<td class="tdData"><bean:write name="listTimeSheetsForAdmin" property="submittedHrs"/>&nbsp;-&nbsp;<bean:write name="listTimeSheetsForAdmin" property="totalRegularHrs"/>/<bean:write name="listTimeSheetsForAdmin" property="totalOvertimeHrs"/>/<bean:write name="listTimeSheetsForAdmin" property="totalHolidayHrs"/> : <bean:write name="listTimeSheetsForAdmin" property="startWeekDate"/>&nbsp;-&nbsp;<bean:write name="listTimeSheetsForAdmin" property="endWeekDate"/></td>
			<td class="tdData"><span
				id='statusSpan<bean:write name="listTimeSheetsForAdmin" property="weeklyHrsSummaryId"/>'><bean:write name="listTimeSheetsForAdmin" property="status"/></span></td>
			<td class="tdData">
			<% String id = (String)((Map)listTimeSheetsForAdmin).get("supportingDocIds");
			String status = (String)((Map)listTimeSheetsForAdmin).get("status");
			String name = (String)((Map)listTimeSheetsForAdmin).get("firstName");
			String clientWorkingFor = (String)((Map)listTimeSheetsForAdmin).get("clientWorkingFor");
			String weeklyHrsSummaryId = ((Map)listTimeSheetsForAdmin).get("weeklyHrsSummaryId").toString();
			String userId = ((Map)listTimeSheetsForAdmin).get("userId").toString();
			String month = ((Map)listTimeSheetsForAdmin).get("month").toString();
			String year = ((Map)listTimeSheetsForAdmin).get("year").toString();
			String submissionFor = (String)((Map)listTimeSheetsForAdmin).get("submissionFor");
									
			
			if(!id.equals("0")){
			%>
			<a href='downloadAFile.do?id=<bean:write name="listTimeSheetsForAdmin" property="weeklyHrsSummaryId"/>&action=timeSheets'>Click</a>
			<%}else{ %> N/A<%} %></td>
			<td class="tdData"><span id='btnSpn<bean:write name="listTimeSheetsForAdmin" property="weeklyHrsSummaryId"/>'>
			<% if (status.equalsIgnoreCase(TimeSheetStatus.REJECTED.name())) {%>
				<input type="button" value="Approve" name="approve" class="ButtonStyle" onclick="approveOrReject(this.value,'<%= userId%>','<%= month%>','<%= year%>','<%= submissionFor%>','<%= weeklyHrsSummaryId%>','<%= name%>','<%= clientWorkingFor%>')">
			<%} else { %>
				<input type="button" value="Reject" name="reject" class="ButtonStyle" onclick="approveOrReject(this.value,'<%= userId%>','<%= month%>','<%= year%>','<%= submissionFor%>','<%= weeklyHrsSummaryId%>','<%= name%>','<%= clientWorkingFor%>')">
			<%} %>
			</span>
			</td>
			 
		</tr>
</logic:iterate>
		<tr>
			<td colspan="8"  class="tdHeader">
		</tr> 

	</table>
</div>

<form action="adminFunctImpl.do" method="post">
<input name="parameter" value="approveOrRejectUserHrs" type="hidden">
<input name="userId" value="" type="hidden">
<input name="status" value="" type="hidden">
<input name="weeklyHrsSummaryId" value="" type="hidden">

</form>