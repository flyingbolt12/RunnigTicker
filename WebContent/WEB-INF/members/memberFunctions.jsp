<%@page import="com.lch.general.enums.DOCTypes"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${isEmployerNotified == 'yes'}">
	<script>
	
		dhtmlx.message({type:"error", expire:6000, text:"Employer Notified." });
	</script>
</c:if>
<c:if test="${sentApprovalReminder == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Approval reminder has been sent to employer" });
	</script>
</c:if>
<c:if test="${passwordUpdated == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Password Updated Successfully" });
	</script>
</c:if>
<c:if test="${insertClientStatus == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"New Client Associated Successfully" });
	</script>
</c:if>
<c:if test="${updateClientStatus == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Client Details Updated Successfully" });
	</script>
</c:if>
<c:if test="${memberUpdationSuccessful == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Profile Details Updated Successfully" });
	</script>
</c:if>
<c:if test="${memberUpdationSuccessful == 'no'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Profile Details Update Failed" });
	</script>
</c:if>
<c:if test="${UserprofileUploadStatus == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"User Profile Uploaded Successfully" });
	</script>
</c:if>

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

.HTMLHIDDENLINK {
	display: none;
}
</style>

<!--

//-->
</script>
<%
	com.lch.general.generalBeans.UserProfile up = (com.lch.general.generalBeans.UserProfile) session
			.getAttribute("userProfile");
	int approvalStatus = up.getApprovalStatus();
	
%>
<div align="center">
	<br> <br> <br>
	<table border="0" width="513" height="142"
		style="font-family: Tahoma; font-size: 10pt">
		<tr>
			<td height="8" width="48" align="right"></td>
			<td height="8" width="154" align="left"></td>
			<td height="8" width="48" align="right"></td>
			<td height="8" width="235" align="left"></td>
		</tr>
		<tr>
			<td height="18" width="48" align="right"><font
				face="Times New Roman">»</font></td>
			<td height="18" width="154" align="left">&nbsp;<html:link onclick="submitForm('editMemberProfileForUpdate')" href="#"
					styleClass="HTMLLINK" title="You can edit your profile.">Edit my Profile</html:link></td>
			<td height="18" width="48" align="right"><font
				face="Times New Roman">»</font></td>
			<td height="18" width="235" align="left">&nbsp;<html:link 
					action="/genericForwardAction.do?forwardTo=members/updateMyClientOptions"
					styleClass="HTMLLINK"
					title="You can update your existing client/provide service to another client.">Update my Client</html:link>
			</td>
		</tr>
		<tr>
			<td height="4" width="48" align="right"></td>
			<td height="4" width="154" align="left"></td>
			<td height="4" width="48" align="right"></td>
			<td height="4" width="235" align="left"></td>
		</tr>
		<tr>
			<td height="18" width="48" align="right"><font
				face="Times New Roman">»</font></td>
			<td height="18" width="154" align="left">&nbsp;<html:link onclick="submitForm('listEmployeeTimesheets')" href="#"
					styleClass="HTMLLINK" title="Your Time Sheet Status.">TimeSheet Status</html:link></td>
			<%
				if (approvalStatus == 1) {
			%>
			<td height="18" width="48" align="right"><font
				face="Times New Roman">»</font></td>
			<td height="18" width="235" align="left">&nbsp;<html:link onclick="submitForm('showTimeSheetApprovalReminderPage')" href="#"
					styleClass="HTMLLINK" title="It will send a reminder to employer.">Buzz to Approve TimeSheet</html:link></td>
			<%
				} else {
			%>
			<td height="18" width="48" align="right"><font
				face="Times New Roman">»</font></td>
			<td height="18" width="235" align="left">&nbsp;<html:link
					href="#" onclick="showAlert(this, 'You can not send any buzz requests until you associated with an employer')"
					styleClass="HTMLLINK" title="It will send a reminder to employer.">Buzz to Approve TimeSheet</html:link></td>
			<% }		%>
		</tr>
		<tr>
			<td height="4" width="48" align="right"></td>
			<td height="4" width="154" align="left"></td>
			<td height="4" width="48" align="right"></td>
			<td height="4" width="235" align="left"></td>
		</tr>
		<tr>
			<td height="18" width="48" align="right"><font
				face="Times New Roman">»</font></td>
			<td height="18" width="154" align="left">&nbsp;<html:link
					action="/genericForwardAction.do?forwardTo=members/reports"
					styleClass="HTMLLINK" title="List of several useful Reports.">Reports</html:link></td>
			<td height="18" width="48" align="right"><font
				face="Times New Roman">»</font></td>
			<td height="18" width="235" align="left">&nbsp;<html:link onclick="confirm1('updateResumeUploadScreen')"
					href="#"
					styleClass="HTMLLINK" title="Helps you to Update your resume">Upload new Resume</html:link></td>
		</tr>
		<tr>
			<td height="4" width="48" align="right"></td>
			<td height="4" width="154" align="left"></td>
			<td height="4" width="48" align="right"></td>
			<td height="4" width="235" align="left"></td>
		</tr>
		<tr>
			<%
				if (approvalStatus == 1) {
			%>
			<td height="18" width="48" align="right"><font
				face="Times New Roman">»</font></td>
			<td height="18" width="154" align="left">&nbsp;<html:link onclick="submitForm('submitMyHrs')" href="#"
					styleClass="HTMLLINK" title="Helps you to submit your time sheet">Submit My TimeSheet</html:link></td>

			<%
				} else {
			%>
			<td height="18" width="48" align="right"><font
				face="Times New Roman">»</font></td>
			<td height="18" width="154" align="left">&nbsp;<html:link href="#" onclick="showAlert(this, 'Until you associated with an employer you cant use this feature')"
					styleClass="HTMLLINK" title="Helps you to submit your time sheet">Submit My TimeSheet</html:link></td>

			<%} %>
			<td height="18" width="48" align="right"><font
				face="Times New Roman">»</font></td>
			<td height="18" width="154" align="left">&nbsp;<html:link onclick="submitForm('showMemberResetPassword')"
					href="#"
					styleClass="HTMLLINK" title="Helps to reset password">Reset Password</html:link></td>
		</tr>
		<tr>
			<td height="4" width="48" align="right"></td>
			<td height="4" width="154" align="left"></td>
			<td height="4" width="48" align="right"></td>
			<td height="4" width="235" align="left"></td>
		</tr>
		<tr>
			<td height="18" width="48" align="right"><font
				face="Times New Roman">»</font></td>
			<td height="18" width="154" align="left">&nbsp;<html:link
					href="javascript:dhtmlx.message({type:'error', expire:10000, text:'Did you see your pop-up window for this action?' });openNewWindow('downloadAFile.do?action=UserProfile')"
					styleClass="HTMLLINK" title="download your resume">Download my Resume(s)</html:link></td>
			<td height="18" width="48" align="right"><font face="Times New Roman">»</font></td>
			<td height="18" width="235" align="left"><!--<html:link action="/genericForwardAction.do?forwardTo=members/intimateVaction" styleClass="HTMLHIDDENLINK" title="Helps you to Intimate vacation.">Intimate Vacation</html:link> -->
				&nbsp;<html:link href="#"
					styleClass="HTMLLINK" title="Change My Employer" onclick="Confirm(this)">Change My Employer</html:link></td>
		</tr>
		<tr>
			<td height="4" width="48" align="right"></td>
			<td height="4" width="154" align="left"></td>
			<td height="4" width="48" align="right"></td>
			<td height="4" width="235" align="left"></td>
		</tr>
		<tr>
			<td height="18" width="48" align="right"><font
				class="HTMLHIDDENLINK" face="Times New Roman">»</font></td>
			<td class="HTMLHIDDENLINK" height="18" width="235" align="left">&nbsp;Edit/Update
				My Submitted Hrs</td>
			<td height="18" width="48" align="right"><font
				class="HTMLHIDDENLINK" face="Times New Roman">»</font></td>
			<td class="HTMLHIDDENLINK" height="18" width="235" align="left">&nbsp;Update
				my Banking Details</td>
		</tr>
	</table>
	<br> <br> <br>
</div>
<form action="genericForwardAction.do" method="post">
<input type="hidden" name="forwardTo" value="members/changeEmployer">
</form>
<form action="memberFunctImpl.do" id="mem" method="post">
<input type="hidden" name="parameter" value="updateResumeUploadScreen">
</form>
<script language="JavaScript">
<!-- hide
	function openNewWindow(url) {
	  popupWin = window
	      .open(url, 'Dowload Resumes', ', , , , , scrollbars, resizable, dependent, width=740, height=500, left=200, top=200')
  }
  // done hiding -->
  function showAlert(thislink, text) {
	  
	  dhtmlx.alert(text);
  }
  
  function submitForm(param){
	var form1 = document.getElementById("mem");
	form1.parameter.value  = param;
	form1.submit();
  }
  function confirm1(param)
  {
  	dhtmlx.confirm({ title: "Confirm?", text:"Old Resume will be replaced", ok:"Yes, I know", cancel:"Cancel", callback:function(result){ 
 		if (result == false) {return result;}
 		submitForm(param);
	  return result;
  	 }});
  }
  
  function Confirm(thislink) {
	  
	  dhtmlx.confirm(
		  {
		  title : "Employer Switching",
		  text : "I want to change my employer",
		  ok : "Yes, I am sure",
		  cancel : "No...",
		  callback : function(result) {
			  if (result == false)
				  {
					  return false;
				  }
			  //document.forms[0].action = "genericForwardAction.do?forwardTo=members/changeMyEmployer";
			  document.forms[0].submit();
			  return true;
		  }
		  });
	  
  }
</script>