<%@page import="com.lch.general.dbBeans.USERPERSONALDATA"%>
<%@page import="com.lch.general.generalBeans.UserProfile"%>
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

<% UserProfile userProfile = (UserProfile) session.getAttribute("userProfile"); 
USERPERSONALDATA user = (USERPERSONALDATA )request.getAttribute("USERPERSONALDATA"); 

%>
<span> History of all Approved & Rejected TimeSheets for <b><%= user.getFirstName() + ", " + user.getLastName() %> </b></span>
<hr/> <br>

	<table border="0" cellspacing="1" class="completeTable" width="100%">
		<tr>
<!-- 			<td class="tdHeader"> Name </td> -->
			<td class="tdHeader"> Client Worked For</td>
			<td class="tdHeader"> Time Sheet Type</td>
			<td class="tdHeader"> Total Hrs - RH/OT/HH : Start - End Weeks</td>
			<td class="tdHeader"> Status</td>
			<td class="tdHeader"> Attached Docs</td>
			<td class="tdHeader"> Action</td>
			<% if(userProfile.isAdmin()) { %>
			<td  class="approvalsTdHeader" width="150px">Invoice</td>
			<%} %>
			<td class="tdHeader">Look Insight</td>
		</tr>
<logic:iterate id="listTimeSheetsForAdmin" name="timeSheetsForAdminList">
	<% String id = (String)((Map)listTimeSheetsForAdmin).get("supportingDocIds");
			String status = (String)((Map)listTimeSheetsForAdmin).get("status");
			String name = (String)((Map)listTimeSheetsForAdmin).get("firstName");
			String clientWorkingFor = (String)((Map)listTimeSheetsForAdmin).get("clientWorkingFor");
			String weeklyHrsSummaryId = ((Map)listTimeSheetsForAdmin).get("weeklyHrsSummaryId").toString();
			String userId = ((Map)listTimeSheetsForAdmin).get("userId").toString();
			String month = ((Map)listTimeSheetsForAdmin).get("month").toString();
			String year = ((Map)listTimeSheetsForAdmin).get("year").toString();
			String submissionFor = (String)((Map)listTimeSheetsForAdmin).get("submissionFor");
			String clientId = (Long) ((Map) listTimeSheetsForAdmin).get("clientId") + "";
			String endWeekDate = (String) ((Map) listTimeSheetsForAdmin).get("endWeekDate");
			String startWeekDate = (String) ((Map) listTimeSheetsForAdmin).get("startWeekDate");
			Boolean hasOnlyMonthlyHours = ((((Integer) ((Map) listTimeSheetsForAdmin).get("hasOnlyMonthlyHours")) == 1) ? true : false);%>
			
		<tr>
<%-- 			<td class="tdData"><bean:write name="listTimeSheetsForAdmin" property="firstName"/>&nbsp;<bean:write name="listTimeSheetsForAdmin" property="middleName"/>&nbsp;<bean:write name="listTimeSheetsForAdmin" property="lastName"/></td> --%>
			<td class="tdData"><bean:write name="listTimeSheetsForAdmin" property="clientWorkingFor"/></td>
			<td class="tdData"><bean:write name="listTimeSheetsForAdmin" property="timeSheetConfiguredTo"/></td>

<%
			if(hasOnlyMonthlyHours == false){
			%>
			<td class="tdData"><bean:write name="listTimeSheetsForAdmin" property="submittedHrs"/>&nbsp;-&nbsp;<bean:write name="listTimeSheetsForAdmin" property="totalRegularHrs"/>/<bean:write name="listTimeSheetsForAdmin" property="totalOvertimeHrs"/>/<bean:write name="listTimeSheetsForAdmin" property="totalHolidayHrs"/> : <bean:write name="listTimeSheetsForAdmin" property="startWeekDate"/>&nbsp;-&nbsp;<bean:write name="listTimeSheetsForAdmin" property="endWeekDate"/></td>
<%} else {%>
			<td class="tdData"><bean:write name="listTimeSheetsForAdmin" property="submittedHrs"/>&nbsp;-&nbsp;<bean:write name="listTimeSheetsForAdmin" property="totalRegularHrs"/>/-/- : <bean:write name="listTimeSheetsForAdmin" property="startWeekDate"/>&nbsp;-&nbsp;<bean:write name="listTimeSheetsForAdmin" property="endWeekDate"/></td>
<%} %>
			<td class="tdData"><span
				id='statusSpan<bean:write name="listTimeSheetsForAdmin" property="weeklyHrsSummaryId"/>'><bean:write name="listTimeSheetsForAdmin" property="status"/></span></td>
			<td class="tdData">
		
			<%
			if(!id.equals("0")){
			%>
			<a href=javascript:openNewWindow('downloadAFile.do?id=<bean:write name="listTimeSheetsForAdmin" property="weeklyHrsSummaryId"/>&action=timeSheets')>Click</a>
			<%}else{ %> N/A<%} %></td>
			<td class="tdData"><span id='btnSpn<bean:write name="listTimeSheetsForAdmin" property="weeklyHrsSummaryId"/>'>
			<% if (status.equalsIgnoreCase(TimeSheetStatus.REJECTED.name())) {%>
				<input type="button" value="Approve" name="approve" class="ButtonStyle" onclick="approveOrReject(this.value,'<%= userId%>','<%= month%>','<%= year%>','<%= submissionFor%>','<%= weeklyHrsSummaryId%>','<%= name%>','<%= clientWorkingFor%>')">
			<%} else { %>
				<input type="button" value="Reject" name="reject" class="ButtonStyle" onclick="approveOrReject(this.value,'<%= userId%>','<%= month%>','<%= year%>','<%= submissionFor%>','<%= weeklyHrsSummaryId%>','<%= name%>','<%= clientWorkingFor%>')">
			<%} %>
			</span>
			</td>
			 	<% if(userProfile.isAdmin()) {%>
				<td  class="tdDataForAlts"><span id="invoice_<%= weeklyHrsSummaryId%>"><a href="javascript:loadInvoiceDetails(<%= weeklyHrsSummaryId%>, <%=clientId%>, <%=userId%>)">Load Invoice</a></span></td>
			<%} %>
			<td class="tdData"><input type="button" value="Look Inside" name="lookInside" class="ButtonStyle" onclick="lookInside(this.value,'<%= userId%>','<%= month%>','<%= year%>','<%= submissionFor%>','<%= weeklyHrsSummaryId%>','<%= name%>','<%= clientWorkingFor%>', '<%= startWeekDate%>', '<%= endWeekDate%>')"></td>			
		</tr>
</logic:iterate>
		<tr>
			<td colspan="8"  class="tdHeader">
		</tr> 

	</table>
</div>


<form action="adminFunctImpl.do" method="post" name="commonUseForm">
	<input name="parameter" value="approveOrRejectUserHrs" type="hidden">
	<input name="userId" value="" type="hidden"> 
	<input name="status" value="" type="hidden">
	<input name="submissionFor" value="" type="hidden"> 
	<input name="month" value="" type="hidden">  
	<input name="year" value="" type="hidden">
	<input name="weeklyHrsSummaryId" value="" type="hidden">
	<input name="clientName" value="" type="hidden">
	<input name="startWeekdate" value="" type="hidden">
	<input name="endWeekdate" value="" type="hidden">
	<input name="forAdmin" value="YES" type="hidden">
</form>

<!-- <form action="adminFunctImpl.do" method="post"> -->
<!-- <input name="parameter" value="approveOrRejectUserHrs" type="hidden"> -->
<!-- <input name="userId" value="" type="hidden"> -->
<!-- <input name="status" value="" type="hidden"> -->
<!-- <input name="weeklyHrsSummaryId" value="" type="hidden"> -->
<!-- </form> -->


<script language="JavaScript">
 function openNewWindow(url) {
 popupWin = window.open(url, 'Downloading ...', ', , , , , scrollbars, resizable, dependent, width=740, height=500, left=200, top=200');
 }

 function lookInside(x,userId,month,year,submissionFor,weeklyHrsSummaryId, name, client, startWeekdate, endWeekdate){

	 var form = document.getElementsByName("commonUseForm")[0];
	 form.parameter.value = "loadTimeSheetForAdmin";
	 form.userId.value = userId;
	 form.weeklyHrsSummaryId.value = weeklyHrsSummaryId;
	 form.submissionFor.value = submissionFor;
	 form.month.value = month;
	 form.year.value = year;
	 form.clientName.value = client;
	 form.startWeekdate.value = startWeekdate;
	 form.endWeekdate.value = endWeekdate;
	 form.submit();
}
 function loadInvoiceDetails(weeklyHrsSummaryId, clientId, userId){
 	
 	 var params = {
 			 weeklyHrsSummaryId : weeklyHrsSummaryId,
 			 clientId:clientId,
 			 userId:userId
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
 