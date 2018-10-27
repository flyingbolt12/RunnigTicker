<%@page import="com.lch.general.enums.DOCTypes"%>
<%@page import="com.lch.general.enums.AdminSearchFunction"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<%@page import="java.util.Map"%>

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

.HTMLLINKHDR {
	text-decoration: none;
	font-family: Tahoma;
	font-size: 10pt;
	color: #FFFFFF;
	padding-left: 4px;
	padding-right: 4px;
	padding-top: 1px;
	padding-bottom: 1px
}
</style>

<script lang="javascript">

function processResponse(id, str, userId, action, email){
	var btnVal = "";
	var btnAction = "";
	if(str.trim() == "Active")
	{
		btnVal = "De Activate";
		btnAction = 2;
		str = "<font color=\"green\"> <B>"+str+"</B></font><BR>";
	}
	else if (str.trim() == "Not Active")
	{
		btnVal = "Activate";
		btnAction = 1;
		str = "<font color=\"red\"> <B>"+str+"</B></font><BR>";
	}
     var nextRequest = "raiseRequestWithParamsAndProcessFunction('"+id+"','"+action+"',"+userId+","+btnAction+",'"+email+"',processResponse"+")";
     
     var actionStr = "<input type='submit' value='"+btnVal+"' class='ButtonStyle' onclick=\""+nextRequest+"\">";
     
     if(btnAction == 0 || btnAction == 1 )
	 	document.getElementById(id).innerHTML = str +actionStr;
     else
    	 document.getElementById(id).innerHTML = str;
}
function processPasswdRestResponse(id, str, userId, action, email){
	document.getElementById(id).innerHTML = str;
}

</script>
<%
	String order = (String) request.getAttribute("order");
	String actionParameter = (String) request.getAttribute("actionParameter");
	if (actionParameter != null && actionParameter.equalsIgnoreCase("doSearch")) {
		actionParameter = "doSearch";
	} else {
		actionParameter = "listAllEmployees";
	}
%>

<%
	int count = 0;
	String feature = (String) session.getAttribute(AdminSearchFunction.featureRequest.name());

	//System.out.println("feature --> " + feature);

	String header = "Client Location";
	if (feature != null && feature.equals(AdminSearchFunction.ACTIVATE_DEACTIVATE.name()))
		header = "CurrentStatus";
	if (feature != null && feature.equals(AdminSearchFunction.EMP_UPDATE.name()))
		header = "Update Empoyee Profile Request";
	if (feature != null && feature.equals(AdminSearchFunction.EMP_PASSWORD_RESET.name()))
		header = "Reset Password";
	if (feature != null && feature.equals(AdminSearchFunction.EMP_TIMESHEET.name()))
		header = "Download TimeSheets";
	if (feature != null && feature.equals(AdminSearchFunction.LIST_TIMESHEETS_FOR_ADMIN.name()))
		header = "List TimeSheets";
	if (feature != null && feature.equals(AdminSearchFunction.SET_EMPLOYEE_RATE.name()))
		header = "Set Billing Rate";
	if (feature != null && feature.equals(AdminSearchFunction.IMMIGRATION_DETAILS.name()))
		header = "Immigration Details";
	if (feature != null && feature.equals(AdminSearchFunction.REGENERATE_VALIDATION_EMAIL.name()))
		header = "Regenerate Registration Validation Email";
	if (feature != null && feature.equals(AdminSearchFunction.SEND_EMAIL_TO_EMPLOYEE.name()))
		header = "Send Email";
	if (feature != null && feature.equals(AdminSearchFunction.EMPLOYEE_SKILLS.name()))
		header = "Skills";
%>
<table border="0" cellspacing="1" width="100%" id="allEmployees"
	style="font-family: Tahoma; font-size: 10pt">
	<tr style="vertical-align: middle;">
		<td class="approvalsTdHeader">Employee Id</td>
		<td class="approvalsTdHeader"><a
			href="adminFunctImpl.do?parameter=<%=actionParameter%>&orderby=firstName&order=<%=order%>&isReqForSort=true"
			class="HTMLLINKHDR">Name »</a></td>
		<td class="approvalsTdHeader"><a
			href="adminFunctImpl.do?parameter=<%=actionParameter%>&orderby=clientName&order=<%=order%>&isReqForSort=true"
			class="HTMLLINKHDR">Client Working For »</a></td>
		<td class="approvalsTdHeader"><%=header%></td>
		<td class="approvalsTdHeader">Recent Claimed Hrs</td>
		<td class="approvalsTdHeader">TimeSheet Submission Type</td>
		<%
			if (header.equalsIgnoreCase("Client Location")) {
		%>
		<td class="approvalsTdHeader">Current Status</td>
		<%
			} else if (header.equalsIgnoreCase("Client Location")) {
		%>
		<td class="approvalsTdHeader">Reset</td>
		<%
			} else
		%>
		<td class="approvalsTdHeader">Profile/Resume</td>
		<td class="approvalsTdHeader" colspan="2">Contact Info</td>
	</tr>

	<logic:iterate id="listAllMyEmployeesId" name="listAllMyEmployees">
		<%
			String userId = String.valueOf(((Map) listAllMyEmployeesId).get("iduser"));

				String contactEmail = String.valueOf(((Map) listAllMyEmployeesId).get("contactEmail"));

				String employeeName = String.valueOf(((Map) listAllMyEmployeesId).get("firstName"));
				String clientName = String.valueOf(((Map) listAllMyEmployeesId).get("clientName"));
				String clientId = String.valueOf(((Map) listAllMyEmployeesId).get("actualClientId"));
				Object skills = ((Map) listAllMyEmployeesId).get("tags");
				Object iduserrate = ((Map) listAllMyEmployeesId).get("iduserrate");
				Object rate = ((Map) listAllMyEmployeesId).get("rate");
				Object recentHrs = ((Map) listAllMyEmployeesId).get("recentHrs");
				Object timeSheetConfiguredTo = ((Map) listAllMyEmployeesId).get("timeSheetConfiguredTo");

				System.out.println(timeSheetConfiguredTo + "-->" + recentHrs);

				boolean isImmigrationDetalsAvalable = false;

				boolean isRateDetailsAvailable = false;
				if (iduserrate != null) {
					isRateDetailsAvailable = true;
				}

				String selenuimSakeId = "btn_" + userId;
		%>
		<tr>
			<td rowspan="3" class="listEmployeesTdBody"><bean:write
					name="listAllMyEmployeesId" property="iduser"></bean:write></td>
			<td rowspan="3" class="listEmployeesTdBodyMinWidth"><bean:write
					name="listAllMyEmployeesId" property="firstName"></bean:write> <bean:write
					name="listAllMyEmployeesId" property="middleName"></bean:write> <bean:write
					name="listAllMyEmployeesId" property="lastName"></bean:write></td>
			<td rowspan="3" class="listEmployeesTdBody"><bean:write
					name="listAllMyEmployeesId" property="clientName"></bean:write></td>

			<td rowspan="3" class="listEmployeesTdBody">
				<%
					String ajaxAction = "adminFunctImpl.do?parameter=activateOrDeActivateUser";
						String status = String.valueOf(((Map) listAllMyEmployeesId).get("approvalStatus"));
				%> <%
 	if (feature != null && feature.equals(AdminSearchFunction.ACTIVATE_DEACTIVATE.name())) {
 			ajaxAction = "adminFunctImpl.do?parameter=activateOrDeActivateUser";
 			if (status != null && status.equals("1")) {
 %> <span id="span_<%=userId%>"> <font color="green"> <B>Active
					</B><BR>
				</font> <input type="button" value="DeActivate" name="deActive"
					class="ButtonStyle"
					onclick="raiseRequestWithParamsAndProcessFunction('span_<%=userId%>','<%=ajaxAction%>',<%=userId%>,2,'<%=contactEmail%>', processResponse)">
			</span> <%
 	} else {
 %> <span id="span_<%=userId%>"> <font color="red"> <B>Not
							Active </B> <BR>
				</font> <input type="button" value="Activate" name="active"
					class="ButtonStyle"
					onclick="raiseRequestWithParamsAndProcessFunction('span_<%=userId%>','<%=ajaxAction%>',<%=userId%>,1,'<%=contactEmail%>', processResponse)">
			</span> <%
 	}
 		} else if (feature != null && feature.equals(AdminSearchFunction.EMP_UPDATE.name())) {
 %> <span id="updateBtn_<%=userId%>"><input type="button"
					id="<%=selenuimSakeId%>" value="Update Profile Request"
					class="ButtonStyle" onclick="sendUpdateRequest(<%=userId%>)">
			</span> <%
 	} else if (feature != null && feature.equals(AdminSearchFunction.REGENERATE_VALIDATION_EMAIL.name())) {
 			ajaxAction = "adminFunctImpl.do?parameter=regenerateValidationEmail";
 %> <span id="span_<%=userId%>"> <input type="button"
					id="btn_<%=userId%>" value="Regenerate Validation Email"
					class="ButtonStyle"
					onclick="regenerateValidationEmail('<%=userId%>', 'span_<%=userId%>')">
			</span> <%
 	} else if (feature != null && feature.equals(AdminSearchFunction.SEND_EMAIL_TO_EMPLOYEE.name())) {
 			ajaxAction = "adminFunctImpl.do?parameter=showSendGenericEmailToSingleEmployee";
 %> <span id="span_<%=userId%>"> <input type="button"
					id="btn_<%=userId%>" value="Send Email" class="ButtonStyle"
					onclick="sendGenericEmailToSingleEmployee('<%=userId%>', '<%=ajaxAction%>')">
			</span> <%
 	} else if (feature != null && feature.equals(AdminSearchFunction.EMP_PASSWORD_RESET.name())) {
 			ajaxAction = "adminFunctImpl.do?parameter=resetPasswordByAdmin";
 %> <span id="span_<%=userId%>"> <input type="button"
					id="btn_<%=userId%>" value="Regenerate " class="ButtonStyle"
					onclick="raiseRequestWithParamsAndProcessFunction('span_<%=userId%>','<%=ajaxAction%>',<%=userId%>,1,'<%=contactEmail%>', processPasswdRestResponse)">
			</span> <%
 	} else if (feature != null && feature.equals(AdminSearchFunction.LIST_TIMESHEETS_FOR_ADMIN.name())) {
 %> <span id="span_<%=userId%>"> <input type="button"
					id="<%=selenuimSakeId%>" value="List Time Sheets"
					class="ButtonStyle" onclick="listTimeSheets('<%=userId%>')">
			</span> <%
 	} else if (feature != null && feature.equals(AdminSearchFunction.EMP_TIMESHEET.name())) {
 %> <span id="span_<%=userId%>"> <input type="button"
					id="<%=selenuimSakeId%>" value="Download Time Sheets"
					class="ButtonStyle" onclick="downloadTimeSheets('<%=userId%>')">
			</span> <%
 	} else if (feature != null && feature.equals(AdminSearchFunction.SET_EMPLOYEE_RATE.name())) {
 %> <%
 	if (isRateDetailsAvailable) {
 %> <a href="javascript:showUserRate(<%=rate.toString()%>)"
				style="text-decoration: none">Click to See Billing Rate!</a> <BR>
				<%
					}
				%> <span id="span_<%=userId%>"> <input type="button"
					id="<%=selenuimSakeId%>" value="Set Rate" class="ButtonStyle"
					onclick="setRate('<%=employeeName%>','<%=clientName%>','<%=userId%>','<%=clientId%>')">
			</span> <%
 	} else if (feature != null && feature.equals(AdminSearchFunction.IMMIGRATION_DETAILS.name())) {
 %> <%
 	if (isImmigrationDetalsAvalable) {
 %> Details Already Available! <a
				href="memberFunctImpl.do?parameter=showUpdateImmigrationDetailsPage&isFromAdmin=true&userId=<%=userId%>"
				style="text-decoration: none">Click here to see.</a> <BR> <%
 	}
 %> <span id="span_<%=userId%>"> <input type="button"
					id="<%=selenuimSakeId%>" value="Update ImmigrationDetails Request"
					class="ButtonStyle"
					onclick="sendImmigrationUpdateRequest(<%=userId%>)">
			</span> <%
 	} else if (feature != null && feature.equals(AdminSearchFunction.EMPLOYEE_SKILLS.name())) {
 %> <span id="span_<%=userId%>"> <%
 	if (skills == null) {
 %> <input type="button" id="<%=selenuimSakeId%>"
					value="Ask Update Skills" class="ButtonStyle"
					onclick="askUpdateSkills(<%=userId%>)"> <%
 	} else {
 %> <%=skills%> <%
 	}
 %>
			</span> <%
 	} else {
 %> <bean:write name="listAllMyEmployeesId" property="cleintAddress"></bean:write>
				<%
					}
				%>
			</td>

			<td rowspan="3" class="listEmployeesTdBody"><logic:present
					name="listAllMyEmployeesId" property="recentHrs">
					<bean:write name="listAllMyEmployeesId" property="recentHrs" />
				</logic:present> <logic:notPresent name="listAllMyEmployeesId" property="recentHrs"> N/A </logic:notPresent></td>
			<td rowspan="3" class="listEmployeesTdBody"><bean:write
					name="listAllMyEmployeesId" property="timeSheetConfiguredTo"></bean:write></td>
			<%
				if (header.equalsIgnoreCase("Client Location")) {
			%>

			<td rowspan="3" class="listEmployeesTdBody">
				<%
					if (status != null && status.equals("1")) {
				%> <font color="green"> <B>Active </B> <%
 	} else {
 %> <font color="red"> <B>Not Active </B>
				</font> <%
 	}
 %>
			</td>
			<%
				}
			%>


			<td rowspan="3" class="listEmployeesTdBody"><a
				href="javascript:openILCHWindow('downloadAFile.do?userId=<%=userId%>&action=<%=DOCTypes.UserProfile.name()%>','Profile Viewer')"
				style="">View Profile</a></td>

			<td align="left" class="listEmployeesTdBody">Address</td>
			<td class="listEmployeesTdBody"><bean:write
					name="listAllMyEmployeesId" property="personalAddress"></bean:write></td>
		<tr>
			<td align="left" class="listEmployeesTdBody">Email</td>
			<td class="listEmployeesTdBody"><bean:write
					name="listAllMyEmployeesId" property="contactEmail"></bean:write></td>
		</tr>
		<tr>
			<td align="left" class="listEmployeesTdBody">Phone</td>
			<td class="listEmployeesTdBody"><bean:write
					name="listAllMyEmployeesId" property="phoneNumber"></bean:write></td>
		</tr>



	</logic:iterate>

	<tr>
		<td align="right" bgcolor="#E2E2E2" colspan="10" height="10px"><b>
				<font size="1">Hint : » Represents Sortable Columns | Recent
					Claimed Hrs Format : T-TotalHrs, R-Regualar, O-Overtime, H-Holiday
					-- Start Week : End Week </font>
		</b></td>
	</tr>
</table>

<form method="post"
	action="adminFunctImpl.do?parameter=showManageTimeSheets">
	<input type="hidden" name="userId" />
</form>
<form method="post"
	action="downloadReports.do?parameter=downloadEmpTimeSheets"
	target="_blank">
	<input type="hidden" name="userId" />
</form>
<script lang="javascript">

function regenrateRegistrationEmailValidationHandler(obj, response){
	//document.getElementById(id).innerHTML = str;
	   removeAjaxImg(obj.id);
	 if (response != null)
		    response = response.replace("disableSubmitRequired", "");
	 document.getElementById(obj.id).innerHTML = "Done!";
	    if (response.indexOf("alreadyValidated")!=-1){
	    	dhtmlx.message({type:"alert-error", expire:10000, text:"User Already Validated his/her email. So New Email is not Generated." });	
	    }
	    if (response.indexOf("invalidEmail")!=-1){
	    	dhtmlx.message({type:"alert-error", expire:10000, text:"Invalid Email." });	
	    }
	    
}


function regenerateValidationEmail(userId, ajaxId)
{
	dhtmlx.message({type:"error", expire:6000, text:"Wait, Processing..." });
	  var params = {
	    		    ajaxParam : userId
	    	    };
	    	    var obj = {
	    	    id : ajaxId,
	    	    url : "adminFunctImpl.do?parameter=regenerateValidationEmail",
	    	    params : params,
	    	    responseHandler : regenrateRegistrationEmailValidationHandler
	    	    };
	    	    sendAjaxRequest(obj);
}

function sendUpdateRequest(userId)
{
	  var params = {
	    		    ajaxParam : userId
	    	    };
	    	    var obj = {
	    	    id : "updateBtn_"+userId,
	    	    url : "adminFunctImpl.do?parameter=requestAnEmployeeToUpdateProfile",
	    	    params : params,
	    	    responseHandler : handleEmpResponse
	    	    };
	    	    sendAjaxRequest(obj);
}
function sendImmigrationUpdateRequest(userId)
{
	  var params = {
	    		    ajaxParam : userId
	    	    };
	    	    var obj = {
	    	    id : "span_"+userId,
	    	    url : "adminFunctImpl.do?parameter=requestAnEmployeeToUpdateImmigrationDetails",
	    	    params : params,
	    	    responseHandler : handleEmpResponse
	    	    };
	    	    sendAjaxRequest(obj);
}
function askUpdateSkills(userId)
{
	dhtmlx.message({type:"error", expire:6000, text:"Wait, Processing..." });
	  var params = {
	    		    ajaxParam : userId
	    	    };
	    	    var obj = {
	    	    id : "span_"+userId,
	    	    url : "adminFunctImpl.do?parameter=requestAnEmployeeToAddSkills",
	    	    params : params,
	    	    responseHandler : handleEmpResponse
	    	    };
	    	    sendAjaxRequest(obj);
}

function handleEmpResponse(obj, response) {
    removeAjaxImg(obj.id);
 
    if (response != null)
	    response = response.replace("disableSubmitRequired", "");
    placeAjaxMessage(obj.id, response);
    
}
function listTimeSheets(userId)
{
	document.forms[0].userId.value = userId;
	document.forms[0].submit();
};
function downloadTimeSheets(userId)
{
	document.forms[1].userId.value = userId;
	document.forms[1].submit();
};
function sendGenericEmailToSingleEmployee(userId, ajaxAction)
{
	document.forms[1].userId.value = userId;
	document.forms[1].action = ajaxAction;
	document.forms[1].submit();
};

function setRate(name, clientName, userId, clientId)
{
	var box = dhtmlx.modalbox({ 
		title:"Helps Invoice!", 
		text:name+" working for "+clientName+"<br><div id='form_in_box'><div><font color='red' size='2'>If Rate already set for the same client then it will be updated.</font><BR> <BR><label> Enter Rate Per Hour : <br><input type=text id='commentsForm' class='inform' width=20></label><div><div><div>"
		+"<br><span class='dhtmlx_button'><input type='button' value='Set Rate' onclick=\"save_approve_callback(this,"+userId+","+clientId+")\" style='width:100px;'></span>"
		+"<span class='dhtmlx_button'><input type='button' value='Cancel' onclick='cancel_callback(this)' style='width:100px;'></span>",
		width:"300px",
		height : "255px"
	});

};

function save_approve_callback(box, userId, clientId){
	var rate = document.getElementById('commentsForm').value;
	dhtmlx.modalbox.hide(box);
	// Send AJAX Request userid , client id and rate.
	
	 var params = {
 		    userId : userId,
 		    clientId: clientId,
 		    rate : rate
 	    };
 	    var obj = {
 	    id : "span_"+userId,
 	    url : "adminFunctImpl.do?parameter=setUserRate",
 	    params : params,
 	    responseHandler : handleRateResponse
 	    };
 	    sendAjaxRequest(obj);
 	    
}   

function handleRateResponse(obj, response) {
    removeAjaxImg(obj.id);
 
    if (response != null)
	    response = response.replace("disableSubmitRequired", "");
    placeAjaxMessage(obj.id, response);
    
}

function cancel_callback(box){
	dhtmlx.message("Operation Cancelled...");
	dhtmlx.modalbox.hide(box);
}

function showUserRate(rate){
	dhtmlx.alert({
		type:"User Billing Rate",
		text:rate
	});
}

if (document.getElementsByTagName) {
    var table = document.getElementById("allEmployees");
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