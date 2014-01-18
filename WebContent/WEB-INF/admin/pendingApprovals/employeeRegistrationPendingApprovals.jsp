<%@page import="com.lch.general.enums.DOCTypes"%>
<%@page import="com.lch.general.enums.TimeSheetStatus"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<%@page import="java.util.Map"%><style>
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
-->
</style>

<script>

function approveOrRejectAll(xAction)
{
	elements = document.getElementsByTagName('input');
	var allElements = '';
	var count =0;
	var userIdArray = new Array();
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
					userIdArray[count] = x;
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
	actiontoTake+='parameter=approveOrRejectRegistrationApprovals&userId='+allElements;

	for(i=1;i<=count;++i)
	{
		removeCheckBox="selectAllCheckBoxSpan"+userIdArray[i];
		document.getElementById(removeCheckBox).innerHTML="";
		document.getElementById(userIdArray[i]).innerHTML="<img border=\"0\" src=\"images/small-ajax-loader.gif\"></img>";
		document.getElementById("statusSpan"+userIdArray[i]).innerHTML=" -- ";
	}
	raiseRequest4NotDisplayUpdate("approveOrRejectAllSpan",actiontoTake, xAction, userIdArray);
		
}
function approveOrReject(x,userId)
{
	if(x=='<%=TimeSheetStatus.APPROVED.name()%>')
	{
		dataAlert('Approving the user :'+userId);
		updateAndSubmitForm(userId,x);
	}
	else if(x=='<%=TimeSheetStatus.REJECTED.name()%>') {
		    dataAlert('Rejecting the user :' + userId);
		    updateAndSubmitForm(userId, x);
	    } else {
		    dataAlert('No Action Defined');
	    }
    }

    function updateAndSubmitForm(userId, action) {
	    actiontoTake = 'adminFunctImpl.do?';
	    actiontoTake += 'parameter=approveOrRejectRegistrationApprovals&userId=' + userId;
	    removeCheckBox = "selectAllCheckBoxSpan" + userId;
	    removeChkBox = "selectAllCheckBoxSpan" + userId;
	    document.getElementById(removeCheckBox).innerHTML = "";
	    document.getElementById(removeChkBox).innerHTML = "";
	    document.getElementById("statusSpan" + userId).innerHTML = " -- ";
	    raiseRequest(userId, actiontoTake, action);
	    //document.forms[0].submit();
    }

    function selectOrDeSelectAll() {
	    x = document.getElementById('selectAllCheckBox').value;
	    //alert(x);
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
</script>
<div align="center">
	<span> Registration Approvals</span>
	<hr/>
	<br> <font size="3"> <span id="message"></span></font>
	<table border="0" cellspacing="1" width="100%" id="approvalTable" style="font-family: Tahoma; font-size: 10pt" id="pendingApprovals">
		<tr>
			<td nowrap="nowrap" class="approvalsTdHeader">Name</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Client working for</td>
			<td nowrap="nowrap" class="approvalsTdHeader">DOB</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Registered Date</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Email</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Mobile</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Status</td>
			<td nowrap="nowrap" class="approvalsTdHeader">Profile</td>
			<td nowrap="nowrap" align="center" bgcolor="#808080"><input type="checkbox" id="selectAllCheckBox" name="selectAllCheckBox" value="selectAll" onclick="selectOrDeSelectAll(this.value)"></td>
			<td nowrap="nowrap" width="183" class="approvalsTdHeader">Action</td>
		</tr>
		<%
			String userId = "";
			int count = 0;
		%>
		<logic:iterate id="employeeRegistrationPendingApprovalsId" name="employeeRegistrationPendingApprovals">
			<%
				userId = String
							.valueOf(((Map) employeeRegistrationPendingApprovalsId)
									.get("idUser"));
			%>
			<tr>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeRegistrationPendingApprovalsId" property="firstName" />&nbsp;<bean:write name="employeeRegistrationPendingApprovalsId" property="middleName" />&nbsp;<bean:write
						name="employeeRegistrationPendingApprovalsId" property="lastName" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeRegistrationPendingApprovalsId" property="clientName" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeRegistrationPendingApprovalsId" property="dob" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeRegistrationPendingApprovalsId" property="registeredDate" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeRegistrationPendingApprovalsId" property="contactEmail" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><bean:write name="employeeRegistrationPendingApprovalsId" property="emergencyPhoneNumber" /></td>
				<td nowrap="nowrap" class="approvalsTdBody"><span id='statusSpan<%=userId%>'>Pending</span></td>
				<td nowrap="nowrap" class="approvalsTdBody"><a href="javascript:openILCHWindow('downloadAFile.do?userId=<%=userId%>&action=<%=DOCTypes.UserProfile.name()%>','Profile Viewer')" style="">View Profile</a></td>
				<td nowrap="nowrap" class="approvalsTdBody"><span id='selectAllCheckBoxSpan<%=userId%>'> <input type="checkbox" name='selectAllCheckBox<%=userId%>' value='select<%=userId%>' onclick="updateTopCheckBox(this)"></span></td>
				<td nowrap="nowrap" class="approvalsTdBody"><span id='<%=userId%>'>
				<input type="button" value="Approve" name="approve" class="ApproveRejectButtonStyle" onclick='approveOrReject("<%=TimeSheetStatus.APPROVED.name()%>","<%=userId%>")'>
				<input type="button" value="Reject" name="reject" class="ApproveRejectButtonStyle" onclick='approveOrReject("<%=TimeSheetStatus.REJECTED.name()%>","<%=userId%>")'></span>
				</td>
			</tr>
			<%
				count++;
			%>
		</logic:iterate>
		<tr>
			<td nowrap="nowrap" colspan="10" bgcolor="#808080">
				<p align="right">
					<input type="button" value="Approve All" id="approveAll" class="ApproveRejectButtonStyle" onclick="approveOrRejectAll('ApproveAll')"> <input type="button" value="Reject All" id="rejectAll" class="ApproveRejectButtonStyle" onclick="approveOrRejectAll('RejectAll')">
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
	<input name="parameter" value="approveOrRejectPendingApprovals" type="hidden"> <input name="userId" value="" type="hidden"> 
	<input name="month" value="" type="hidden"> <input name="year" value="" type="hidden"> <input
		name="status" value="" type="hidden">
</form>
<script>
if (document.getElementsByTagName) {
    var table = document.getElementById("pendingApprovals");
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