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


</style>
  
  <script src="js/ilchcommon.js"></script>
  <script>
  var isSearchDone = false;
  var userId_send;
  // function name -- text -- image
  var dynaBtns = [
                 ['downloadTimeSheets','Download TimeSheet History', 'download.png'],
                 ['sendUpdateRequest','Request Profile Update', 'profile.png'],
                 ['sendImmigrationUpdateRequest','Request Immigration Details Update', 'immigration.png'],
                 ['sendPasswordResetRequest','Reset Employee Password?', 'reset.png'],
                 ['activateUser','Activate This Employee', 'active.png'],
                 ['deActivateUser','DeActivate This Employee', 'active.png'],
                 ['sendGenericEmail','Send an Instant Email', 'email.png'],
                 ['regenerateValidationEmail','Regenerate Registration Validation Email', 'redo.png'],
                 ['notifyBusinessId','Notify Company Id', 'busId.png'],
                 ['browseUploads','Browse Uploads', 'browse.png'],
                 ['listSimilarSkills','Browse Similar Skills', 'browse.png'],
                 ['listAllSkills','Browse All Skills', 'browse.png']
             ];
  

  $(function() {
 	
 		$("#tags").autocomplete({
 			minLength: 2,
 			source : "adminFunctImpl.do?parameter=quickSearch",
 			search: function( event, ui ) {document.getElementById("searching").style.visibility='visible'; },
 			select: function (event, ui) {
 				
 				if(ui.item.label == "None Found"){
 					return;
 				}
 				
 				// delete the elements first 
 				$("#del1").remove();
 				$("#del2").remove();
 				 $("#accordion").accordion("refresh");
 				 
 				 
 			    isSearchDone = true;
 			    
 			    $("#tags").val(ui.item.label);
 			    //alert(ui.item.label);
 			    var newDiv = "<h3 class=\"searchaccordinaStyle\" id =\"del1\"> <font color =\"white\">What do you want to do with this employee</font> <font color =\"yellow\">" + ui.item.label + "?</font> </h3> <div id=\"del2\" class=\"searchaccContentBack\"><div id= \"addEmployeeOps\" class=\"accordianContentStyle\"></div></div>";
 			    $("#toAppendSearchresult").before(newDiv);
 			    $("#accordion").accordion("refresh");

 			    $("#accordion").accordion({
 			        active: 0
 			    });
 			    userId_send = ui.item.value;
 			    for (var i = 0; i<dynaBtns.length; ++i)
 			    	{
 			    	var img = "<img src=\"images/"+dynaBtns[i][2]+"\" style=\"max-width: 32; max-height: 32\">"; 
 			    	var ajaxId = "btSpan_"+dynaBtns[i][0]+ui.item.value;
 			    	var ele = "<a href=\"#\" onclick=\"javascript:"+dynaBtns[i][0]+"('"+userId_send+"','"+ajaxId+"') \" class=\"memberLinks\"><div class=\"quickSearch\"><span class=\"spanStyle\" id=\""+ajaxId+"\">"+img+"</span><span class=\"spanStyle\">"+dynaBtns[i][1]+"</span></div></a>";
 			    	$("#addEmployeeOps").append(ele);
 			    	}
 			    //<a href="adminFunctImpl.do?parameter=searchOptions&amp;featureRequest=EMP_TIMESHEET" class="memberLinks"><div class="squareAdmin"><span class="spanStyle"><img src="images/pdf.png"></span><span class="spanStyle">Download an Employee TimeSheet History</span></div></a>

 			    return false;
 			},
 			focus: function (event, ui) {
 			    $("#tags").val(ui.item.label);
 			    return false;
 			}
 			}).data("ui-autocomplete")._renderItem = function (
 			    ul, item) {
 			
 			 document.getElementById("searching").style.visibility='hidden';
 			    return $("<li class='resultStyle'>").append(
 			            "<a class='resultStyle'>" + item.label + "</a>")
 			        .appendTo(ul);
 			};
});

  
 $(function() {
	
		$("#skillTags").autocomplete({
			minLength: 2,
			source : "adminFunctImpl.do?parameter=quickSkillsSearch",
			search: function( event, ui ) {document.getElementById("searchingSkills").style.visibility='visible'; },
			select: function (event, ui) {
				
				if(ui.item.label == "None Found"){
					return;
				}
				
				// delete the elements first 
				$("#del1").remove();
				$("#del2").remove();
				 $("#accordion").accordion("refresh");
				 
				 
			    isSearchDone = true;
			    
			    $("#skillTags").val(ui.item.label);
			    //alert(ui.item.label);
			    var newDiv = "<h3 class=\"searchaccordinaStyle\" id =\"del1\"> <font color =\"white\">What do you want to do with this employee</font> <font color =\"yellow\">" + ui.item.label + "?</font> </h3> <div id=\"del2\" class=\"searchaccContentBack\"><div id= \"addEmployeeOps\" class=\"accordianContentStyle\"></div></div>";
			    $("#toAppendSearchresult").before(newDiv);
			    $("#accordion").accordion("refresh");

			    $("#accordion").accordion({
			        active: 0
			    });
			    userId_send = ui.item.value;
			    for (var i = 0; i<dynaBtns.length; ++i)
			    	{
			    	var img = "<img src=\"images/"+dynaBtns[i][2]+"\" style=\"max-width: 32; max-height: 32\">"; 
			    	var ajaxId = "btSpan_"+dynaBtns[i][0]+ui.item.value;
			    	var ele = "<a href=\"#\" onclick=\"javascript:"+dynaBtns[i][0]+"('"+userId_send+"','"+ajaxId+"') \" class=\"memberLinks\"><div class=\"quickSearch\"><span class=\"spanStyle\" id=\""+ajaxId+"\">"+img+"</span><span class=\"spanStyle\">"+dynaBtns[i][1]+"</span></div></a>";
			    	$("#addEmployeeOps").append(ele);
			    	}
			    //<a href="adminFunctImpl.do?parameter=searchOptions&amp;featureRequest=EMP_TIMESHEET" class="memberLinks"><div class="squareAdmin"><span class="spanStyle"><img src="images/pdf.png"></span><span class="spanStyle">Download an Employee TimeSheet History</span></div></a>

			    return false;
			},
			focus: function (event, ui) {
			    $("#skillTags").val(ui.item.label);
			    return false;
			}
			}).data("ui-autocomplete")._renderItem = function (
			    ul, item) {
			
			 document.getElementById("searchingSkills").style.visibility='hidden';
			    return $("<li class='resultStyle'>").append(
			            "<a class='resultStyle'>" + item.label + "</a>")
			        .appendTo(ul);
			};
});

			// COOKIE FOR ACCORDIANS
			var cookieName = 'myHotCookie';
			$(function () {
			    $("#accordion")
			        .accordion({
			            active: ((isNaN(parseInt($.cookie(cookieName)))) ? 2 : parseInt($.cookie(cookieName))),
			            collapsible: true,
			            heightStyle: "content",
			            activate: function (event, ui) {
			                var accNumber = parseInt($(this)
			                    .accordion('option', 'active'));
			                if (isSearchDone) {
			                    accNumber = accNumber - 1;
			                }
			                $.cookie(cookieName, accNumber);
			            }
			        });
			});

		</script>
  <div class="searchstyle"> 
  Quick Skill Search :  <input type="text" id="skillTags" class="use" autocomplete="off" onblur="">
  <img id="searchingSkills" src="images/small-ajax-loader.gif" style="visibility: hidden;"/>
  
  Quick Employee Search :  <input type="text" id="tags" class="use" autocomplete="off" onblur="">
  <img id="searching" src="images/small-ajax-loader.gif" style="visibility: hidden;"/>
  </div> 
  <BR>
 <div id="accordion">
  <h3 class="accordinaStyle" id="toAppendSearchresult">Employee Operations Area</h3>
  <div class="accContentBack">
    <div class="accordianContentStyle">
    
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=listAllEmployees">
   			<div class="squareAdmin" title="Displays the list of all your employees in a single page"><span class="spanStyle"><img src="images/list.png" ></span><span class="spanStyle">List all my employees</span></div>
			</html:link>
   			
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=radialListing">
   			<div class="squareAdmin" title="Shows all employees"><span class="spanStyle"><img src="images/list.png" ></span><span class="spanStyle">Radial Listing</span></div>
			</html:link>
			
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=searchOptions">
   			<div class="squareAdmin" title="Performs a search"><span class="spanStyle"><img src="images/find.png" ></span><span class="spanStyle">Find employee(s)</span></div>
			</html:link>
			
			<html:link styleClass="memberLinks"  action="/adminFunctImpl.do?parameter=searchOptions&&featureRequest=EMP_PASSWORD_RESET">
				<div class="squareAdmin" title="Reset an Employee Password"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/reset.png" ></span><span class="spanStyle">Reset Employee Password</span></div>
			</html:link>
		
			<html:link styleClass="memberLinks"  action="/adminFunctImpl.do?parameter=addAnEmployeeOptions">
				<div class="squareAdmin" title="Register a new Employee."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/add.png" ></span><span class="spanStyle">Add an Employee</span></div>
			</html:link>
			
			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=ACTIVATE_DEACTIVATE">
				<div class="squareAdmin" title="Lets Active/Deactive stoping the employee to submit the Timesheets."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/active.png" ></span><span class="spanStyle">Activate/Deactivate an Employee</span></div>   		
			</html:link>
			
			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=browseUploads">
				<div class="squareAdmin" title="Browse the attachments that user attached."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/browse.png" ></span><span class="spanStyle">Browse Uploads</span></div>   		
			</html:link>
			
			<%
						UserProfile userProfile = (UserProfile) session.getAttribute("userProfile");
						String action = "";
						boolean isAdmin = userProfile.isAdmin();
						if(isAdmin) {
						%>
						
			<html:link styleClass="memberLinks"  action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=SET_EMPLOYEE_RATE">
				<div class="squareAdmin" title="Tells about invoice to bill clients - Not available for Child Admins"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/rate.png" ></span><span class="spanStyle">Set Rate - How much to bill?</span></div>
			</html:link>
		<% } %>
		
			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=listSimilarSkills&isFromSearch=false&featureRequest=EMPLOYEE_SKILLS&isSimilar=false">
				<div class="squareAdmin" title="Browse the attachments that user attached."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/browse.png" ></span><span class="spanStyle">Browse Skills</span></div>   		
			</html:link>
		
		
		</div>
  </div>
  <h3 class="accordinaStyle">Notifications Spot</h3>
   <div class="accContentBack">
   <div class="accordianContentStyle">
   			
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=makeGenericEmail">
   				<div class="squareAdmin" title="Send message to employees(based on their timesheet type"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Notify Group Of Employees By TimeSheet Type</span></div>
			</html:link>
   		
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=showNotifyGroupOfEmployeesbyCategory">
   				<div class="squareAdmin" title="Send message to employees(based on their category)."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Notify Group Of Employees by Category</span></div>
			</html:link>
			
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=EMP_UPDATE">
				<div class="squareAdmin" title="Sends an email to you with your comapny unique id"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Ask An Employee To Update Profile</span></div>
			</html:link>
   		
   	   		<html:link styleClass="memberLinks" href="#" onclick="confirmlinkForRequestAllEmployeesToUpdateTheirProfiles()">
				<div class="squareAdmin" title="Notifies all employees to update their profiles"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Ask All Employees To Update Profiles</span></div>
			</html:link>	
   		
   		   	<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=IMMIGRATION_DETAILS">
				<div class="squareAdmin" title="Notifies employee to update his/her immigration details"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Ask  *An* Employee To Update Immigration Details</span></div>
			</html:link>	
			
			<html:link styleClass="memberLinks" href="#" onclick="confirmlinkForRequestAllEmployeesToUpdateTheirImmigrationDetails()">
				<div class="squareAdmin" title="Notifies employees to update their immigration details"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Ask Employees To Update Immigration Details</span></div>
			</html:link>	
			
   		   	<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=SEND_EMAIL_TO_EMPLOYEE">
				<div class="squareAdmin" title="Notifies all employees to update their immigration details who don't updated their details yet"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Send an Email to Employee</span></div>
			</html:link>	
			
		</div>
  </div>
  <h3 class="accordinaStyle">Approvals Area</h3>
   <div class="accContentBack">
    <div class="accordianContentStyle">
		
			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=employeeTimesheetPendingApprovals">
				<div class="squareAdmin" title="Approve or Reject Submitted TimeSheets by your Employees"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Employee Time Sheet Pending Approvals</span></div>   		
			</html:link>

			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=employeeRegistrationPendingApprovals">
				<div class="squareAdmin" title="Approve or Reject employees who waiting to get the access into this application"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Employee Registration Pending Approvals</span></div>   		
			</html:link>
			
			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=LIST_TIMESHEETS_FOR_ADMIN">
				<div class="squareAdmin" title="Manage the approved timesheets."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Manage Approved TimeSheets</span></div>   		
			</html:link>
		
			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=REGENERATE_VALIDATION_EMAIL">
				<div class="squareAdmin" title=""><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/redo.png" ></span><span class="spanStyle">ReGenerate Validation Email</span></div>   		
			</html:link>
		
		</div>
  </div>
  <%if(isAdmin) {%>
  <h3 class="accordinaStyle">Child Admins + Tracking System Area</h3>
   <div class="accContentBack">
    <div class="accordianContentStyle">
   			
	   		<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=createAnotherAdmin">
				<div class="squareAdmin" title="Create new Admin."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Create Another Admin</span></div>   		
			</html:link>

	   		<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=manageMyAdmins">
				<div class="squareAdmin" title="Helps in managing the Admins."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Manage My Admins</span></div>   		
			</html:link>

	   		<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=createTask">
				<div class="squareAdmin" title="Helps in managing the Admins."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Create Task</span></div>   		
			</html:link>
			
	   		<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=listTasks">
				<div class="squareAdmin" title="Helps in managing the Admins."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">List+Track Task</span></div>   		
			</html:link>

	   		<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=deleteTask">
				<div class="squareAdmin" title="Helps in managing the Admins."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Delete Task</span></div>   		
			</html:link>
						
		</div>
  </div>
  <% } %>
  <h3 class="accordinaStyle">Timers &amp; Email Contents</h3>
   <div class="accContentBack">
    <div class="accordianContentStyle" >
   			
	   		<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=showTimerCreationPage">
				<div class="squareAdmin" title="Set the timer's to deliver the email listings automatically."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Set Regular Email Reminder</span></div>   		
			</html:link>
			
			<html:link styleClass="memberLinks"	action="/adminFunctImpl.do?parameter=showManageTimersPage">
				<div class="squareAdmin" title="Manage the reminders."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Manage Timers</span></div>   		
			</html:link>
	
			<html:link styleClass="memberLinks"	action="/adminTimer.do?parameter=showManageEmailContentsPage">
				<div class="squareAdmin" title="Manage the approved timesheets."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Manage Email Contents</span></div>   		
			</html:link>
				
		</div>
  </div>
  <h3 class="accordinaStyle">Settings Spot</h3>
  <div class="accContentBack">
   <div class="accordianContentStyle">
   			
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=manageMyCategories">
   				<div class="squareAdmin" title="Manage Employee Categories"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Employee Categories</span></div>
			</html:link>
			
<%--    			<html:link href="#" styleClass="memberLinks" onclick="resetPassword()"> --%>
<!-- 				<div class="squareAdmin" title="Reset Password"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle"> Reset My Password</span></div> -->
<%-- 			</html:link> --%>
			
<%-- 			<html:link href="#" styleClass="memberLinks" onclick="disableBusnessConfirmationDialog()"> --%>
<!-- 				<div class="squareAdmin" title="Disables your busiess"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle"> Disable My Business</span></div> -->
<%-- 			</html:link> --%>
			
<%-- 			<html:link href="#" styleClass="memberLinks" onclick="showTimeSheetConfiguration()"> --%>
<!-- 				<div class="squareAdmin" title="Set Timesheet default values"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle"> TimeSheet Configuration</span></div> -->
<%-- 			</html:link> --%>
			
			<html:link href="#" styleClass="memberLinks" onclick="showSettings()">
				<div class="squareAdmin" title="Set default values"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle"> General Settings</span></div>
			</html:link>

			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=manageMyUploads">
				<div class="squareAdmin" title="Set default values"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle"> Manage Uploads</span></div>
			</html:link>
			
<%-- 			<html:link href="#" styleClass="memberLinks" onclick="showLogoSettings()"> --%>
<!-- 				<div class="squareAdmin" title="Configure Settings"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Settings</span></div> -->
<%-- 			</html:link> --%>
			
<%-- 			<html:link styleClass="memberLinks" title="Recommend RunningTicker" action="/adminFunctImpl.do?parameter=inviteOtherBusinessOptions"> --%>
<!-- 				<div class="squareAdmin" title="Sends an email to you with your comapny unique id"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Recommend us</span></div> -->
<%-- 			</html:link> --%>
   			
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=viewMyUniqueNumberOptions">
				<div class="squareAdmin" title="Sends an email to you with your comapny unique id"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">My Company Unique Id</span></div>
			</html:link>
			
			<html:link styleId="sendlink" action="/adminFunctImpl.do?parameter=showNotifyEmailsPage" styleClass="memberLinks">
				<div class="squareAdmin" title="Sends an email with comapny unique id to the listed emails(not neccessarily the employees)."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Notify Company Id to Emails</span></div>
			</html:link>
			

<%-- 			<html:link styleId="sendlink" href="#" styleClass="memberLinks" onclick="showMyAppURL()"> --%>
<!-- 				<div class="squareAdmin" title="Sends an email with comapny unique id to the listed emails(not neccessarily the employees)."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">MyLogo ApplicationURL</span></div> -->
<%-- 			</html:link> --%>
			
			<% if(isAdmin) { %>
						
			<html:link styleId="sendlink" styleClass="memberLinks" action="/adminFunctImpl.do?parameter=downloadDoBackUpData">
				<div class="squareAdmin" title="Downloads All Business Data"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Do Backup Data</span></div>
			</html:link>
			
			<% } %>
			<form method="POST" action="adminFunctImpl.do">
				<input type="hidden" name="parameter" value="resetPassword">
			</form>
<!-- 		<form action="adminFunctImpl.do" method="POST"><input type="hidden" name="parameter" value="disableBusiness"></form>  -->
		</div>
  </div>
  <h3 class="accordinaStyle">Reports Area</h3>
   <div class="accContentBack">
    <div class="accordianContentStyle">
   			
			<html:link styleClass="memberLinks" action="/downloadReports.do?parameter=showAdminDownloadAllEmployeesSortOpetionPage">
				<div class="squareAdmin" title="A PDF will be downloaded having your employees list"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/pdf.png" ></span><span class="spanStyle">Download All Employees</span></div>
			</html:link>
						
			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=searchOptions&featureRequest=EMP_TIMESHEET">
				<div class="squareAdmin" title="Helps you to download total working hours of employee."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/pdf.png" ></span><span class="spanStyle">Download an Employee TimeSheet History</span></div>
			</html:link>
			
			<html:link styleClass="memberLinks" action="/downloadReports.do?parameter=collectYearAndMonths">
				<div class="squareAdmin" title="Helps you to download total working hours of employee."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/excel.png" ></span><span class="spanStyle">Generate Monthly Submitted Hours TimeSheet Report</span></div>
			</html:link>
			
			</div>
  </div>
</div>
<form name="customForm" method="post">
	<input type="hidden" name="userId" />
</form>
 	<script>
// 		function disableBusnessConfirmationDialog(thislink) {
			
// 			var msg = "Are you sure, do you want to disable business?";
			
// 			dhtmlx.confirm({ title: "Confirmation Needed", text:msg, ok:"Yes", cancel:"No", callback:function(result){ 
// 				if (result == true) {document.forms[1].submit(); } else {document.getElementById('business').checked = false;}
// 			 }});

// 		}
		
// 		function showTimeSheetConfiguration(thislink) {
// 			document.forms[0].parameter.value="showTimeSheetConfiguration";
// 			document.forms[0].submit();
// 		}
		
		function showLogoSettings(thislink) {
			document.forms[0].parameter.value="showLogoSettingsPage";
			document.forms[0].submit();
		}
		
		function showSettings(thislink) {
			document.forms[0].parameter.value="showSettingsPage";
			document.forms[0].submit();
		}
		
// 		function resetPassword(thislink) {
// 			document.forms[0].parameter.value="resetPassword";
// 			document.forms[0].submit();
// 		}
		
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
	var showSeacrAccr= "N"
	<% String showSeacrAccr =  request.getParameter("showSeacrAccr");  if (showSeacrAccr!=null && showSeacrAccr.equals("Y")) {showSeacrAccr = "Y";}%>
	showSeacrAccr = "<%=showSeacrAccr%>";
	
	$( document ).ready(function() {
	if(showSeacrAccr == "Y") {
		userId_send = <%= request.getParameter("iduser")%>;
		 var newDiv = "<h3 class=\"searchaccordinaStyle\" id =\"del1\"> <font color =\"white\">What do you want to do with this employee</font> <font color =\"yellow\">?</font> </h3> <div id=\"del2\" class=\"searchaccContentBack\"><div id= \"addEmployeeOps\" class=\"accordianContentStyle\"></div></div>";
		    $("#toAppendSearchresult").before(newDiv);
		$("#accordion").accordion("refresh");

	    $("#accordion").accordion({
	        active: 0
	    });
	    $("#accordion").accordion("refresh");
	    for (var i = 0; i<dynaBtns.length; ++i)
	    	{
	    	var img = "<img src=\"images/"+dynaBtns[i][2]+"\" style=\"max-width: 32; max-height: 32\">"; 
	    	var ajaxId = "btSpan_"+dynaBtns[i][0]+userId_send;
	    	var ele = "<a href=\"#\" onclick=\"javascript:"+dynaBtns[i][0]+"('"+userId_send+"','"+ajaxId+"') \" class=\"memberLinks\"><div class=\"quickSearch\"><span class=\"spanStyle\" id=\""+ajaxId+"\">"+img+"</span><span class=\"spanStyle\">"+dynaBtns[i][1]+"</span></div></a>";
	    	$("#addEmployeeOps").append(ele);
	    	}
	}
	 return false;
	});
</script>


<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-48072437-1', 'runningticker.com');
  ga('send', 'pageview');

</script>