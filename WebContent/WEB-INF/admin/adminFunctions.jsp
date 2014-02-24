<%@page import="com.lch.general.Roles"%>
<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<script>
	var notAdmin = false;
	</script>
<c:if test="${isEmployerNotified == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Employer Notified." });
	</script>
</c:if>
<c:if test="${isNotified == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"<%= request.getAttribute("status")%>" });
	</script>
</c:if>
<c:if test="${passwordUpdated == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Password Updated Successfully" });
	</script>
</c:if>
<c:if test="${isAdminSettingsUpdated == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"<%= request.getAttribute("status")%>" });
	</script>
</c:if>
<c:if test="${not empty showStatus}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"<%= request.getAttribute("showStatus")%>" });
	</script>
</c:if>


<%
	com.lch.general.generalBeans.UserProfile up = (com.lch.general.generalBeans.UserProfile) session
			.getAttribute("userProfile");
	int approvalStatus = up.getApprovalStatus();
	
	if(!up.getUserRole().equals(Roles.ADMIN.name()) && !up.getUserRole().equals(Roles.CHILDADMIN.name()))
	{
		%> 
		<script>			notAdmin = true;		</script>
		Our security tools suspected invalid activity and you are not allowed to view this page.
		<%	return;
	} %>
	
<style>


.accordianContentStyle{
	max-width: 500px;
	margin-left:26%;
	margin-top: 10px;
	margin-bottom: 10px;
}

.accordinaStyle{
	color : #1F3B08;
font-size:9pt;
font-weight : bold;
background: rgb(255,255,255); /* Old browsers */
background: -moz-linear-gradient(top,  rgba(255,255,255,1) 0%, rgba(241,241,241,1) 50%, rgba(225,225,225,1) 51%, rgba(246,246,246,1) 100%); /* FF3.6+ */
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(255,255,255,1)), color-stop(50%,rgba(241,241,241,1)), color-stop(51%,rgba(225,225,225,1)), color-stop(100%,rgba(246,246,246,1))); /* Chrome,Safari4+ */
background: -webkit-linear-gradient(top,  rgba(255,255,255,1) 0%,rgba(241,241,241,1) 50%,rgba(225,225,225,1) 51%,rgba(246,246,246,1) 100%); /* Chrome10+,Safari5.1+ */
background: -o-linear-gradient(top,  rgba(255,255,255,1) 0%,rgba(241,241,241,1) 50%,rgba(225,225,225,1) 51%,rgba(246,246,246,1) 100%); /* Opera 11.10+ */
background: -ms-linear-gradient(top,  rgba(255,255,255,1) 0%,rgba(241,241,241,1) 50%,rgba(225,225,225,1) 51%,rgba(246,246,246,1) 100%); /* IE10+ */
background: linear-gradient(to bottom,  rgba(255,255,255,1) 0%,rgba(241,241,241,1) 50%,rgba(225,225,225,1) 51%,rgba(246,246,246,1) 100%); /* W3C */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#f6f6f6',GradientType=0 ); /* IE6-9 */

}
.accordinaStyle:hover{
	color : #FFF;
background: rgb(207,207,231); /* Old browsers */
background: -moz-linear-gradient(top,  rgba(207,207,231,1) 0%, rgba(90,92,114,1) 100%); /* FF3.6+ */
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(207,207,231,1)), color-stop(100%,rgba(90,92,114,1))); /* Chrome,Safari4+ */
background: -webkit-linear-gradient(top,  rgba(207,207,231,1) 0%,rgba(90,92,114,1) 100%); /* Chrome10+,Safari5.1+ */
background: -o-linear-gradient(top,  rgba(207,207,231,1) 0%,rgba(90,92,114,1) 100%); /* Opera 11.10+ */
background: -ms-linear-gradient(top,  rgba(207,207,231,1) 0%,rgba(90,92,114,1) 100%); /* IE10+ */
background: linear-gradient(to bottom,  rgba(207,207,231,1) 0%,rgba(90,92,114,1) 100%); /* W3C */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#cfcfe7', endColorstr='#5a5c72',GradientType=0 ); /* IE6-9 */

	
}

.accContentBack{
background: -moz-radial-gradient(center, ellipse cover,  rgba(255,255,255,1) 1%, rgba(255,255,255,0.77) 76%, rgba(90,114,97,0.69) 100%); /* FF3.6+ */
background: -webkit-gradient(radial, center center, 0px, center center, 100%, color-stop(1%,rgba(255,255,255,1)), color-stop(76%,rgba(255,255,255,0.77)), color-stop(100%,rgba(90,114,97,0.69))); /* Chrome,Safari4+ */
background: -webkit-radial-gradient(center, ellipse cover,  rgba(255,255,255,1) 1%,rgba(255,255,255,0.77) 76%,rgba(90,114,97,0.69) 100%); /* Chrome10+,Safari5.1+ */
background: -o-radial-gradient(center, ellipse cover,  rgba(255,255,255,1) 1%,rgba(255,255,255,0.77) 76%,rgba(90,114,97,0.69) 100%); /* Opera 12+ */
background: -ms-radial-gradient(center, ellipse cover,  rgba(255,255,255,1) 1%,rgba(255,255,255,0.77) 76%,rgba(90,114,97,0.69) 100%); /* IE10+ */
background: radial-gradient(ellipse at center,  rgba(255,255,255,1) 1%,rgba(255,255,255,0.77) 76%,rgba(90,114,97,0.69) 100%); /* W3C */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#b05a7261',GradientType=1 ); /* IE6-9 fallback on horizontal gradient */

}

#accordion .ui-accordion-header.ui-state-active { 
color : white;
background: rgb(169,3,41); /* Old browsers */
background: -moz-linear-gradient(top,  rgba(169,3,41,1) 0%, rgba(143,2,34,1) 44%, rgba(109,0,25,1) 100%); /* FF3.6+ */
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(169,3,41,1)), color-stop(44%,rgba(143,2,34,1)), color-stop(100%,rgba(109,0,25,1))); /* Chrome,Safari4+ */
background: -webkit-linear-gradient(top,  rgba(169,3,41,1) 0%,rgba(143,2,34,1) 44%,rgba(109,0,25,1) 100%); /* Chrome10+,Safari5.1+ */
background: -o-linear-gradient(top,  rgba(169,3,41,1) 0%,rgba(143,2,34,1) 44%,rgba(109,0,25,1) 100%); /* Opera 11.10+ */
background: -ms-linear-gradient(top,  rgba(169,3,41,1) 0%,rgba(143,2,34,1) 44%,rgba(109,0,25,1) 100%); /* IE10+ */
background: linear-gradient(to bottom,  rgba(169,3,41,1) 0%,rgba(143,2,34,1) 44%,rgba(109,0,25,1) 100%); /* W3C */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#a90329', endColorstr='#6d0019',GradientType=0 ); /* IE6-9 */ }


</style>
  
  
  <script>
  var cookieName = 'myHotCookie';
  $(function() {
		$("#accordion").accordion({active : ( (isNaN(parseInt($.cookie(cookieName))))? 2 : parseInt($.cookie(cookieName))), collapsible: true, heightStyle: "content",  activate: function(event, ui) {
			 $.cookie(cookieName,parseInt($(this).accordion('option','active')));
			}
		});});
  
  </script>
 <div id="accordion">
  <h3 class="accordinaStyle">Employee Operations Area</h3>
  <div class="accContentBack">
    <div class="accordianContentStyle">
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=listAllEmployees">
   			<div class="squareAdmin" title="Displays the list of all your employees in a single page"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">List all my employees</span></div>
			</html:link>
   			
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=searchOptions">
   			<div class="squareAdmin" title="Performs a search"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Find employee(s)</span></div>
			</html:link>
			
			<html:link styleClass="memberLinks"  action="/adminFunctImpl.do?parameter=searchOptions&&featureRequest=EMP_PASSWORD_RESET">
				<div class="squareAdmin" title="Reset an Employee Password"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Reset Employee Password</span></div>
			</html:link>
		
			<html:link styleClass="memberLinks"  action="/adminFunctImpl.do?parameter=addAnEmployeeOptions">
				<div class="squareAdmin" title="Register a new Employee."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Add an Employee</span></div>
			</html:link>
			
			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=ACTIVATE_DEACTIVATE">
				<div class="squareAdmin" title="Lets Active/Deactive stoping the employee to submit the Timesheets."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Activate/Deactivate an Employee</span></div>   		
			</html:link>
			
		
			<%
						UserProfile userProfile = (UserProfile) session.getAttribute("userProfile");
						String action = "";
						boolean isAdmin = userProfile.isAdmin();
						if(isAdmin) {
						%>
						
			<html:link styleClass="memberLinks"  action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=SET_EMPLOYEE_RATE">
				<div class="squareAdmin" title="Tells about invoice to bill clients - Not available for Child Admins"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Set Rate - How much to bill?</span></div>
			</html:link>
		<% } %>
		</div>
  </div>
  <h3 class="accordinaStyle">Notifications Spot</h3>
   <div class="accContentBack">
   <div class="accordianContentStyle">
   			
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=makeGenericEmail">
   				<div class="squareAdmin" title="Send message to employees(based on their category)."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Notify Group Of Employees</span></div>
			</html:link>
   		
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=EMP_UPDATE">
				<div class="squareAdmin" title="Sends an email to you with your comapny unique id"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Ask An Employee To Update Profile</span></div>
			</html:link>
   		
   	   		<html:link styleClass="memberLinks" href="#" onclick="confirmlinkForRequestAllEmployeesToUpdateTheirProfiles()">
				<div class="squareAdmin" title="Notifies all employees to update their profiles"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Ask All Employees To Update Profiles</span></div>
			</html:link>	
   		
   		   	<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=IMMIGRATION_DETAILS">
				<div class="squareAdmin" title="Notifies employee to update his/her immigration details"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Ask An Employee To Update Immigration Details</span></div>
			</html:link>	
		
   		   	<html:link styleClass="memberLinks" href="#" onclick="confirmlinkForRequestAllEmployeesToUpdateTheirImmigrationDetails()">
				<div class="squareAdmin" title="Notifies all employees to update their immigration details who don't updated their details yet"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Ask Employees To Update Immigration Details</span></div>
			</html:link>	
			
		</div>
  </div>
  <h3 class="accordinaStyle">Manage Approvals Area</h3>
   <div class="accContentBack">
    <div class="accordianContentStyle">
		
			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=employeeTimesheetPendingApprovals">
				<div class="squareAdmin" title="Approve or Reject Submitted TimeSheets by your Employees"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Employee Time Sheet Pending Approvals</span></div>   		
			</html:link>

			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=employeeRegistrationPendingApprovals">
				<div class="squareAdmin" title="Approve or Reject employees who waiting to get the access into this application"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Employee Registration Pending Approvals</span></div>   		
			</html:link>
			
			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=LIST_TIMESHEETS_FOR_ADMIN">
				<div class="squareAdmin" title="Manage the approved timesheets."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Manage Approved TimeSheets</span></div>   		
			</html:link>
		
		</div>
  </div>
  <h3 class="accordinaStyle">Manage Child Admins Area</h3>
   <div class="accContentBack">
    <div class="accordianContentStyle">
   			
	   		<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=createAnotherAdmin">
				<div class="squareAdmin" title="Create new Admin."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Create Another Admin</span></div>   		
			</html:link>

	   		<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=manageMyAdmins">
				<div class="squareAdmin" title="Helps in managing the Admins."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Manage My Admins</span></div>   		
			</html:link>
			
		</div>
  </div>
  <h3 class="accordinaStyle">Manage Timers &amp; Email Contents</h3>
   <div class="accContentBack">
    <div class="accordianContentStyle" >
   			
	   		<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=showTimerCreationPage">
				<div class="squareAdmin" title="Set the timer's to deliver the email listings automatically."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Set Regular Email Reminder</span></div>   		
			</html:link>
			
			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=showManageTimersPage">
				<div class="squareAdmin" title="Manage the reminders."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Manage Timers</span></div>   		
			</html:link>
	
			<html:link styleClass="memberLinks"	action="/adminTimer.do?parameter=showManageEmailContentsPage">
				<div class="squareAdmin" title="Manage the approved timesheets."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Manage Email Contents</span></div>   		
			</html:link>
				
		</div>
  </div>
  <h3 class="accordinaStyle">Settings Spot</h3>
  <div class="accContentBack">
   <div class="accordianContentStyle">
   			
   			<html:link href="#" styleClass="memberLinks" onclick="resetPassword()">
				<div class="squareAdmin" title="Reset Password"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle"> Reset My Password</span></div>
			</html:link>
			
			<html:link href="#" styleClass="memberLinks" onclick="disableBusnessConfirmationDialog()">
				<div class="squareAdmin" title="Disables your busiess"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle"> Disable My Business</span></div>
			</html:link>
			
			<html:link href="#" styleClass="memberLinks" onclick="showTimeSheetConfiguration()">
				<div class="squareAdmin" title="Set Timesheet default values"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle"> TimeSheet Configuration</span></div>
			</html:link>
			
   			<html:link href="#" styleClass="memberLinks" onclick="updateBusinessLogo()">
				<div class="squareAdmin" title="Updates your Logo"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Update Logo</span></div>
			</html:link>
			
			<html:link styleClass="memberLinks" title="Recommend ILCH" action="/adminFunctImpl.do?parameter=inviteOtherBusinessOptions">
				<div class="squareAdmin" title="Sends an email to you with your comapny unique id"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Recommend us</span></div>
			</html:link>
   			
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=viewMyUniqueNumberOptions">
				<div class="squareAdmin" title="Sends an email to you with your comapny unique id"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">My Company Unique Id</span></div>
			</html:link>
			
			<html:link styleId="sendlink" action="/adminFunctImpl.do?parameter=showNotifyEmailsPage" styleClass="memberLinks">
				<div class="squareAdmin" title="Sends an email with comapny unique id to the listed emails(not neccessarily the employees)."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Notify Company Id to Emails</span></div>
			</html:link>
			
			<html:link styleId="sendlink" href="#" styleClass="memberLinks" onclick="showMyAppURL()">
				<div class="squareAdmin" title="Sends an email with comapny unique id to the listed emails(not neccessarily the employees)."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">MyLogo ApplicationURL</span></div>
			</html:link>
			
		 <form method="POST" action="adminFunctImpl.do">
			<input type="hidden" name="parameter" value="resetPassword">
		</form>
		<form action="adminFunctImpl.do" method="POST"><input type="hidden" name="parameter" value="disableBusiness"></form> 
		</div>
  </div>
  <h3 class="accordinaStyle">Downloading Reports Area</h3>
   <div class="accContentBack">
    <div class="accordianContentStyle">
   			
			<html:link styleClass="memberLinks" action="/downloadReports.do?parameter=showAdminDownloadAllEmployeesSortOpetionPage">
				<div class="squareAdmin" title="A PDF will be downloaded having your employees list"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Download All Employees</span></div>
			</html:link>
						
			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=EMP_TIMESHEET">
				<div class="squareAdmin" title="Helps you to download total working hours of employee."><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Download an Employee TimeSheet History</span></div>
			</html:link>
			
			</div>
  </div>
</div>
 	<script>
		function disableBusnessConfirmationDialog(thislink) {
			
			var msg = "Are you sure, do you want to disable business?";
			
			dhtmlx.confirm({ title: "Confirmation Needed", text:msg, ok:"Yes", cancel:"No", callback:function(result){ 
				if (result == true) {document.forms[1].submit(); } else {document.getElementById('business').checked = false;}
			 }});

		}
		
		function showTimeSheetConfiguration(thislink) {
			document.forms[0].parameter.value="showTimeSheetConfiguration";
			document.forms[0].submit();
		}
		
		function updateBusinessLogo(thislink) {
			document.forms[0].parameter.value="showLogoUpdatePage";
			document.forms[0].submit();
		}
		function resetPassword(thislink) {
			document.forms[0].parameter.value="resetPassword";
			document.forms[0].submit();
		}
	

	function showMyAppURL() {
			window.prompt("Press Ctrl+C, Enter", "http://www.RunningTicker.com?businessId=<%= userProfile.getBusinessId()%>");
	}

		
	function confirmlink() {

		var msg = "Do you want to send email with Business Id to all your employees?";
		
		dhtmlx.confirm({ title: "Confirmation Needed", text:msg, ok:"Yes", cancel:"No", callback:function(result){ 
			if (result == true) {
				document.forms[0].parameter.value="sendBusinessIdToAllMyEmployees";
				document.forms[0].submit();
			}
		 }});

	}
	
	function confirmlinkForRequestAllEmployeesToUpdateTheirProfiles() {

		var msg = "Do you want to Notify all your employees to update their profiles?";
		
		dhtmlx.confirm({ title: "Confirmation Needed", text:msg, ok:"Yes", cancel:"No", callback:function(result){ 
			if (result == true){
				document.forms[0].parameter.value="requestAllEmployeesToUpdateTheirProfiles";
				document.forms[0].submit();
			}
		 }});

	}
	function confirmlinkForRequestAllEmployeesToUpdateTheirImmigrationDetails() {

		var msg = "Do you want to Notify your employees to update their immigration details, Who not yet updated?";
		
		dhtmlx.confirm({ title: "Confirmation Needed", text:msg, ok:"Yes", cancel:"No", callback:function(result){ 
			if (result == true){
				document.forms[0].parameter.value="requestAllEmployeesToUpdateTheirImmigrrationDetails";
				document.forms[0].submit();
			}
		 }});

	}
	
	if(notAdmin){
		document.getElementById("adminFucntionsPage").parentNode.removeChild(document.getElementById("adminFucntionsPage"));
		document.getElementById("security").innerHTML="DUE TO SECURITY RESTRICTIONS, WE COULDN'T SHOW THIS PAGE NOW, CONTACT US TO KNOW WHY?";
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