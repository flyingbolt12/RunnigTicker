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
	String actionParameter = (String) request
			.getAttribute("actionParameter");
	if (actionParameter != null
			&& actionParameter.equalsIgnoreCase("doSearch")) {
		actionParameter = "doSearch";
	} else {
		actionParameter = "listAllEmployees";
	}
%>

<%
	String feature = (String) session
			.getAttribute(AdminSearchFunction.featureRequest.name());

	//System.out.println("feature --> " + feature);

	String header = "Client Location";
	if (feature != null
			&& feature.equals(AdminSearchFunction.ACTIVATE_DEACTIVATE
					.name()))
		header = "CurrentStatus";
	if (feature != null
			&& feature.equals(AdminSearchFunction.EMP_UPDATE.name()))
		header = "Update Empoyee Profile Request";
	if (feature != null
			&& feature.equals(AdminSearchFunction.EMP_PASSWORD_RESET
					.name()))
		header = "Reset Password";
	if (feature != null
			&& feature.equals(AdminSearchFunction.EMP_TIMESHEET.name()))
		header = "Download TimeSheets";
	if (feature != null
			&& feature
					.equals(AdminSearchFunction.LIST_TIMESHEETS_FOR_ADMIN
							.name()))
		header = "List TimeSheets";
%>
<table border="0" cellspacing="1" width="100%" id="allEmployees" style="font-family: Tahoma; font-size: 10pt">
	<tr style="vertical-align: middle;">
		<td  class="approvalsTdHeader">Employee Id</td>
		<td  class="approvalsTdHeader"><a href="adminFunctImpl.do?parameter=<%=actionParameter%>&orderby=firstName&order=<%=order%>&isReqForSort=true" class="HTMLLINKHDR">Name �</a></td>
		<td  class="approvalsTdHeader"><a href="adminFunctImpl.do?parameter=<%=actionParameter%>&orderby=clientName&order=<%=order%>&isReqForSort=true" class="HTMLLINKHDR">Client Working For �</a></td>
		<td  class="approvalsTdHeader"><%=header%></td>
		<td  class="approvalsTdHeader">Recent Claimed Hrs</td>
		<td  class="approvalsTdHeader">TimeSheet Submission Type</td>
		<%
			if (header.equalsIgnoreCase("Client Location")) {
		%>
		<td  class="approvalsTdHeader">Current Status</td>
		<%
			} else if (header.equalsIgnoreCase("Client Location")) {
		%>
		<td  class="approvalsTdHeader">Reset</td>
		<%
			} else
		%>
		<td  class="approvalsTdHeader">Profile/Resume</td>
		<td  class="approvalsTdHeader" colspan="2">Contact Info</td>
	</tr>

	<logic:iterate id="listAllMyEmployeesId" name="listAllMyEmployees">
		<%
			String userId = String.valueOf(((Map) listAllMyEmployeesId)
						.get("iduser"));

				String contactEmail = String
						.valueOf(((Map) listAllMyEmployeesId)
								.get("contactEmail"));
		%>
		<tr>
			<td rowspan="3" class="listEmployeesTdBody"><bean:write name="listAllMyEmployeesId" property="iduser"></bean:write></td>
			<td rowspan="3" class="listEmployeesTdBodyMinWidth"><bean:write name="listAllMyEmployeesId" property="firstName"></bean:write> <bean:write name="listAllMyEmployeesId" property="middleName"></bean:write> <bean:write name="listAllMyEmployeesId"
					property="lastName"></bean:write></td>
			<td rowspan="3" class="listEmployeesTdBody"><bean:write name="listAllMyEmployeesId" property="clientName"></bean:write></td>
			<td rowspan="3" class="listEmployeesTdBody">
				<%
					String ajaxAction = "adminFunctImpl.do?parameter=activateOrDeActivateUser";
						String status = String.valueOf(((Map) listAllMyEmployeesId)
								.get("approvalStatus"));
				%> <%
 	if (feature != null
 				&& feature
 						.equals(AdminSearchFunction.ACTIVATE_DEACTIVATE
 								.name())) {
 			ajaxAction = "adminFunctImpl.do?parameter=activateOrDeActivateUser";
 			if (status != null && status.equals("1")) {
 %> <span id="span_<%=userId%>"> <font color="green"> <B>Active </B><BR>
				</font> <input type="button" value="DeActivate" name="deActive" class="ButtonStyle" onclick="raiseRequestWithParamsAndProcessFunction('span_<%=userId%>','<%=ajaxAction%>',<%=userId%>,2,'<%=contactEmail%>', processResponse)">
			</span> <%
 	} else {
 %> <span id="span_<%=userId%>"> <font color="red"> <B>Not Active </B> <BR>
				</font> <input type="button" value="Activate" name="active" class="ButtonStyle" onclick="raiseRequestWithParamsAndProcessFunction('span_<%=userId%>','<%=ajaxAction%>',<%=userId%>,1,'<%=contactEmail%>', processResponse)">
			</span> <%
 	}
 		} else if (feature != null
 				&& feature
 						.equals(AdminSearchFunction.EMP_UPDATE.name())) {
 %> <span id="updateBtn_<%=userId%>"><input type="button" value="Send Update Profile Request" class="ButtonStyle" onclick="sendUpdateRequest(<%=userId%>)" > </span><%
 	} else if (feature != null
 				&& feature
 						.equals(AdminSearchFunction.EMP_PASSWORD_RESET
 								.name())) {
 			ajaxAction = "adminFunctImpl.do?parameter=resetPasswordByAdmin";
 %> <span id="span_<%=userId%>"> <input type="button" value="Reset" class="ButtonStyle" onclick="raiseRequestWithParamsAndProcessFunction('span_<%=userId%>','<%=ajaxAction%>',<%=userId%>,1,'<%=contactEmail%>', processPasswdRestResponse)">
			</span> <%
 	} else if (feature != null
 				&& feature
 						.equals(AdminSearchFunction.LIST_TIMESHEETS_FOR_ADMIN
 								.name())) {
 %> <span id="span_<%=userId%>"> <input type="button" value="List Time Sheets" class="ButtonStyle" onclick="listTimeSheets('<%=userId%>')">
			</span> <%
 	} else if (feature != null
 				&& feature.equals(AdminSearchFunction.EMP_TIMESHEET
 						.name())) {
 %> <span id="span_<%=userId%>"> <input type="button" value="Download Time Sheets" class="ButtonStyle" onclick="downloadTimeSheets('<%=userId%>')">
			</span> <%
 	} else {
 %> <bean:write name="listAllMyEmployeesId" property="cleintAddress"></bean:write> <%
 	}
 %>

			</td>

			<td rowspan="3" class="listEmployeesTdBody"><logic:present name="listAllMyEmployeesId" property="recentHrs">
					<bean:write name="listAllMyEmployeesId" property="recentHrs" />
				</logic:present> <logic:notPresent name="listAllMyEmployeesId" property="recentHrs"> N/A </logic:notPresent></td>
			<td rowspan="3" class="listEmployeesTdBody"><bean:write name="listAllMyEmployeesId" property="timeSheetConfiguredTo"></bean:write></td>
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


			<td rowspan="3" class="listEmployeesTdBody"><a href="javascript:openILCHWindow('downloadAFile.do?userId=<%=userId%>&action=<%=DOCTypes.UserProfile.name()%>','Profile Viewer')" style="">View Profile</a></td>

			<td align="left"  class="listEmployeesTdBody">Address</td>
			<td  class="listEmployeesTdBody"><bean:write name="listAllMyEmployeesId" property="personalAddress"></bean:write></td>
		<tr>
			<td align="left"  class="listEmployeesTdBody">Email</td>
			<td  class="listEmployeesTdBody"><bean:write name="listAllMyEmployeesId" property="contactEmail"></bean:write></td>
		</tr>
		<tr>
			<td align="left"  class="listEmployeesTdBody">Phone</td>
			<td  class="listEmployeesTdBody"><bean:write name="listAllMyEmployeesId" property="phoneNumber"></bean:write></td>
		</tr>



	</logic:iterate>

	<tr>
		<td align="right" bgcolor="#E2E2E2" colspan="10" height="10px"><b> <font size="1">Hint : � Represents Sortable Columns | Recent Claimed Hrs Format : T-TotalHrs, R-Regualar, O-Overtime, H-Holiday -- Start Week : End Week </font>
		</b></td>
	</tr>
</table>

<form method="post" action="adminFunctImpl.do?parameter=showManageTimeSheets">
	<input type="hidden" name="userId" />
</form>
<form method="post" action="downloadReports.do?parameter=downloadEmpTimeSheets" target="_blank">
	<input type="hidden" name="userId" />
</form>
<script lang="javascript">

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