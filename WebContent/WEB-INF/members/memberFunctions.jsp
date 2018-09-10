<%@page import="com.lch.general.Roles"%>
<%@page import="com.lch.general.enums.DOCTypes"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	com.lch.general.generalBeans.UserProfile up = (com.lch.general.generalBeans.UserProfile) session
			.getAttribute("userProfile");
	int approvalStatus = up.getApprovalStatus();
	
	System.out.println(up.getUserRole());
	if(!up.getUserRole().equals(Roles.MEMBER.name()))
	{
		System.out.println(up.getUserRole());
		return;
	}
	
%>
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
<c:if test="${ImmigrationDetails == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Immigration Details Operation is Success" });
	</script>
</c:if>

	<div style="max-width:500px;margin-left:31%;">
		    <html:link onclick="submitForm('editMemberProfileForUpdate')" href="#" styleClass="memberLinks"><div class = "square" title="You can edit your profile.">   
<span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Edit my Profile</span>
   			</div></html:link>
			<html:link action="/genericForwardAction.do?forwardTo=members/updateMyClientOptions" styleClass="memberLinks" style="text-decoration: none;"><div class = "square" title="You can update your existing client/provide service to another client.">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle" >Update my Client</span>
			</div></html:link>
		    <html:link onclick="submitForm('listEmployeeTimesheets')" href="#" styleClass="memberLinks" ><div class = "square" title="Your Time Sheet Status.">
		    	<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">TimeSheet Status</span>
		    </div></html:link>
			<%	if (approvalStatus == 1) { %>
			<html:link onclick="submitForm('showTimeSheetApprovalReminderPage')" href="#" styleClass="memberLinks" ><div class = "square" title="It will send a reminder to employer.">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">Buzz to Approve TimeSheet</span>
   			</div></html:link>
			<% } else {	%>
			<html:link href="#" onclick="showAlert(this, 'You can not send any buzz requests until you associated with an employer')" styleClass="memberLinks" ><div class = "square" title="It will send a reminder to employer.">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">Buzz to Approve TimeSheet</span>
   			</div></html:link>
			<% }%>
			<html:link action="/genericForwardAction.do?forwardTo=members/reports" styleClass="memberLinks" ><div class = "square" title="List of several useful Reports.">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">See Reports</span>
			</div></html:link>
			<html:link onclick="confirm1('updateResumeUploadScreen')" href="#" styleClass="memberLinks" ><div class = "square" title="Helps you to Update your resume">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">Upload new Resume</span>
			</div></html:link>
			<% if (approvalStatus == 1) { %>
			<html:link onclick="submitForm('submitMyHrs')" href="#" styleClass="memberLinks" ><div class = "square" title="Helps you to submit your time sheet">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">Submit My TimeSheet</span>
			</div></html:link>
			<% } else { %>
			<html:link href="#" onclick="showAlert(this, 'Until you associated with an employer you cant use this feature')" styleClass="memberLinks" ><div class = "square" title="Helps you to submit your time sheet">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">Submit My TimeSheet</span>
			</div></html:link>
			<%} %>
			<html:link onclick="submitForm('showMemberResetPassword')" href="#" styleClass="memberLinks" ><div class = "square" title="Helps to reset password">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">Reset Password</span>
			</div></html:link>
			<html:link href="javascript:dhtmlx.message({type:'error', expire:10000, text:'Did you see your pop-up window for this action?' });openNewWindow('downloadAFile.do?action=UserProfile')" styleClass="memberLinks" ><div class = "square" title="download your resume">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">Download my Resume(s)</span>
			</div></html:link>
			<html:link href="#" styleClass="memberLinks" onclick="Confirm(this)"><div class = "square"  title="Change My Employer">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">Change My Employer</span>
			</div></html:link>
			<html:link styleClass="memberLinks" action="memberFunctImpl.do?parameter=showUpdateImmigrationDetailsPage"><div class = "square" title="Update your immigration details">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">Update Immigration Details</span>
			</div></html:link>
			<html:link styleClass="memberLinks" action="memberFunctImpl.do?parameter=attachOtherDocs"><div class = "square" title="Attach Files">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle">Attach Other Documents</span>
			</div></html:link>
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
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-48072437-1', 'runningticker.com');
  ga('send', 'pageview');

</script>