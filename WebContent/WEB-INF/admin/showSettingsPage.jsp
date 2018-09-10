<%@ include file="jspSuper.jsp" %> 
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<style>
.EmployeeTextBox { 
                    font-family: Tahoma;
                    font-size: 10pt; 
                    color: #008080; 
                    border: 1px solid #808080; 
                    padding-left: 4px; 
                    padding-right: 4px;
                    padding-top: 1px; 
                    padding-bottom: 1px 
                   }

</style>
<div align="center">
<html:form action="/adminFunctImpl.do"
	enctype="multipart/form-data">
<input type="hidden" name="parameter">
	<table border="0" cellspacing="1" width="60%"
		style="font-family: Tahoma; font-size: 10pt; max-width: 600px;">
    <tr>
		<td height="18" bgcolor="#808080" colspan="2">
		<p align="center"><b><font color="#FFFFFF" style="font-size: 10.0pt; font-family: Tahoma">Choose an option as below </font></b></td>
	</tr>

		<tr>
			<td align="center">
			<div style="padding-left: 5em;">
   			
   			<html:link styleClass="memberLinks"  action="/adminFunctImpl.do?parameter=showLogoSettingsPage">
				<div class="squareAdmin" title="Updates your Logo"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Logo Settings</span></div>
			</html:link>
   			
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=showTimeSheetConfiguration">
				<div class="squareAdmin" title="Set Timesheet default values"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle"> TimeSheet Configuration</span></div>
			</html:link>
			
			<html:link styleClass="memberLinks"  onclick="setHideOption()" href="#" styleId="hideOption">
				<div class="squareAdmin" title="Set Timesheet default values"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle"> Stop Showing Skip Notify Employer Button</span></div>
			</html:link>
			
			<html:link href="#" styleClass="memberLinks" onclick="resetPassword()">
				<div class="squareAdmin" title="Reset Password"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle"> Reset My Password</span></div>
			</html:link>
			
			<html:link href="#" styleClass="memberLinks" onclick="disableBusnessConfirmationDialog()">
				<div class="squareAdmin" title="Disables your busiess"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle"> Disable My Business</span></div>
			</html:link>
			
			<html:link styleClass="memberLinks" title="Recommend RunningTicker" action="/adminFunctImpl.do?parameter=inviteOtherBusinessOptions">
				<div class="squareAdmin" title="Sends an email to you with your comapny unique id"><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">Recommend us</span></div>
			</html:link>
			
			</div>
			</td>
		</tr>
		
	</table>
	<html:hidden property="result"/>
</html:form>
<form action="adminFunctImpl.do" method="POST"><input type="hidden" name="parameter" value="disableBusiness"></form>
</div>
	<% 
		
			String msg = "Current Status : "; 
			//com.lch.general.generalBeans.UserProfile up = (com.lch.general.generalBeans.UserProfile) session
				//.getAttribute("userProfile"); 
				if (userProfile.isHideSkipNotifyEmployerButton()) { 
					msg = msg + "Yes";
				}
				else {
					msg = msg + "No";
				}
				%>
<script type="text/javascript">
function resetPassword(thislink) {
	document.forms[0].parameter.value="resetPassword";
	document.forms[0].submit();
}
function disableBusnessConfirmationDialog(thislink) {
	
	var msg = "Are you sure, do you want to disable business?";
	
	dhtmlx.confirm({ title: "Confirmation Needed", text:msg, ok:"Yes", cancel:"No", callback:function(result){ 
		if (result == true) {document.forms[1].submit(); } else {document.getElementById('business').checked = false;}
	 }});

}
function setHideOption() {
		dhtmlx.confirm({title:"Hide This Option?", 
				ok:"Yes", cancel:"No",
				text:"<%= msg%>",
				callback: function(result){
					//alert(result);
					document.forms[0].parameter.value="showSkipNotifyEmployerButton";
					document.forms[0].result.value = result;
					document.forms[0].submit();
				}
		});
		
		}
	</script>	