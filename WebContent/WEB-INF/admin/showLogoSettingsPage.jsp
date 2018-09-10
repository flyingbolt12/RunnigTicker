
<%@page import="com.lch.general.generalBeans.UserProfile"%>
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
<%
						UserProfile userProfile = (UserProfile) session.getAttribute("userProfile");
%>
<script>

function showMyAppURL() {
	dhtmlx.message({type:"error", expire:6000, text:"Did you see the prompt? Copy that URL." });
	window.prompt("Press Ctrl+C, Enter", "http://www.RunningTicker.com?businessId=<%= userProfile.getBusinessId()%>");
}

</script>

<div align="center">
<html:form action="/adminFunctImpl.do"
	enctype="multipart/form-data">
<input type="hidden" name="parameter">
	<table border="0" cellspacing="1" width="60%" 
		style="font-family: Tahoma; font-size: 10pt">
    <tr>
		<td height="18" width="453" bgcolor="#808080" colspan="2">
		<p align="center"><b><font color="#FFFFFF" style="font-size: 10.0pt; font-family: Tahoma">Choose an option as below </font></b></td>
	</tr>

		<tr>
			<td align="center">
			<div style="padding-left: 5em;">
   			<html:link styleClass="memberLinks" action="/adminFunctImpl.do?parameter=showLogoUpdatePage">
				<div class="squareAdmin" title="Updates your Logo"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Upload A New Logo</span></div>
			</html:link>
			
			
   			<html:link styleClass="memberLinks" onclick="confirmlink()" href="#">
				<div class="squareAdmin" title="Updates your Logo"><span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Restore To Default Logo</span></div>
			</html:link>
			
			
			<html:link styleId="sendlink" href="#" styleClass="memberLinks" onclick="showMyAppURL()">
				<div class="squareAdmin" title="Sends an email with comapny unique id to the listed emails(not neccessarily the employees)."><span class="spanStyle"><img style="max-width: 32; max-height: 32" src="images/time.png" ></span><span class="spanStyle">MyLogo ApplicationURL</span></div>
			</html:link>
			
			</div>
			</td>
		</tr>
		
	</table>
</html:form>

</div>

<script>
function confirmlink() {

	var msg = "Are You Sure?";
	
	dhtmlx.confirm({ title: "Logo Reset?", text:msg, ok:"Yes", cancel:"No", callback:function(result){ 
		if (result == true) {
			document.forms[0].parameter.value="restoreLogo";
			document.forms[0].submit();
		}
	 }});

}
</script>