<%@page import="com.lch.general.enums.TimeSheetStatus"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<%@page import="java.util.Map"%>
<div align="center">

<hr class="regHeader" />
	<span>-- Manage "<strong>My Admins</strong>" --
	</span>
	<hr class="regHeader" />
	
	<table border="0" width="100%"
		style="font-family: Tahoma; font-size: 10pt">
		
		<tr>
			<td class="tdHeader"><b>Sl., No</b></td>
			<td class="tdHeader"><b>Name</b></td>
 			<td class="tdHeader"><b>Phone</b></td>
			<td class="tdHeader"><b>Email Id</b></td>
			<td class="tdHeader"><b>Actions</b></td>
			<td class="tdHeader"><b>Status</b></td>
		</tr>
		<%
			String color = "red";
		%>
		<%
			int count = 0;
		%>
		<logic:iterate id="listAllMyAdminsId" name="listAllMyAdmins"
			indexId="id">

			<%
				if (id.intValue() % 2 == 0) {
						color = "#F4F4F4";
					} else {
						color = "#FFFFFF";
					}
			%>
			<%
				Long approvalStatusObj = (Long) ((Map) listAllMyAdminsId)
							.get("approvalStatus");
					int approvalStatus = approvalStatusObj.intValue();
					String userId = String.valueOf(((Map) listAllMyAdminsId)
							.get("idUser"));
					String contactEmail = String.valueOf(((Map) listAllMyAdminsId)
							.get("contactEmail"));
					String status = "";
					switch (approvalStatus) {
						case 1 : {
							status = TimeSheetStatus.APPROVED.name();
							break;
						}
						case 2 : {
							status = "DISABLED";
							break;
						}
						case 3 : {
							status = "DELETED";
							break;
						}
						case 0 : {
							status = "PENDING";
							break;
						}
						default : {
							status = "Action Failed";
							break;
						}
					}
			%>

			<tr style="background-color: <%=color%>" >
				<td height="20" align="center">${id + 1}</td>
				<td height="20" align="center" width="35%"><bean:write
						name="listAllMyAdminsId" property="lastName"></bean:write>, <bean:write
						name="listAllMyAdminsId" property="firstName"></bean:write> <bean:write
						name="listAllMyAdminsId" property="middleName"></bean:write></td>
 				<td height="20" align="center"><bean:write
 						name="listAllMyAdminsId" property="phoneNumber"></bean:write></td>
				<td height="20" align="center"><bean:write
						name="listAllMyAdminsId" property="contactEmail"></bean:write></td>
				<td height="20" align="center" bordercolor="#F4F4F4" nowrap="nowrap"><input
					type="submit" value="Enable" id="enable" class="ButtonStyle"
<%-- 					onclick="raiseRequestWithParams('span_<%=userId%>','adminFunctImpl.do?parameter=eanableDisableAdmin',<%=userId%>,1,'<%=contactEmail%>')"> --%>
					onclick="buildRequestAndSend('<%=userId%>',this.value,'<%=contactEmail%>')">
					<input type="submit" value="Disable" id="disable"
					class="ButtonStyle"
					onclick="raiseRequestWithParams('span_<%=userId%>','adminFunctImpl.do?parameter=eanableDisableAdmin',<%=userId%>,2,'<%=contactEmail%>')">
					<input type="submit" value="Delete" id="delete" class="ButtonStyle"
					onclick="raiseRequestWithParams('span_<%=userId%>','adminFunctImpl.do?parameter=eanableDisableAdmin',<%=userId%>,3,'<%=contactEmail%>')">
				</td>

				<td height="20" align="center" nowrap="nowrap"><span
					id='span_<bean:write name="listAllMyAdminsId" property="idUser"></bean:write>'>
						<%=status%></span></td>
			</tr>
			<%
				count++;
			%>

		</logic:iterate>
	</table>
	
</div>

<script>

function buildRequestAndSend(userId, btnType, email) {
	
	var params = "userId=" + userId + "&approvalStatus=" + approvalStatus + "&email=" + email;
	var approvalStatus = 0;

	switch(btnType)
	{
		case 'Enable':
		{
			approvalStatus = 1;
	  		break;
		}
		case 'Disable': 
		{
			approvalStatus = 2;
		  	break;
		}
		case 'Delete':
		{
			approvalStatus = 3;
			 break;
		}
	}
	
		
    var params = {
	    userId : userId,
	    approvalStatus : approvalStatus,
	    email : email
    };
    var obj = {
    id : 'span_'+userId,
    url : "adminFunctImpl.do?parameter=eanableDisableAdmin",
    params : params,
    responseHandler : handleEmpResponse
    };
    sendAjaxRequest(obj);
}

function handleEmpResponse(obj, response) {
    removeAjaxImg(obj.id);
    placeAjaxMessage(obj.id, response);
}

</script>
