<%@page import="com.lch.general.enums.DOCTypes"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<style>

.BusinessTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }

.HTMLLINK { text-decoration:none;font-family: Tahoma; font-size: 8pt; color: #008080; 
               padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }
</style>
<form action="superAdminFunctImpl.do?parameter=sendInvitationEmail" method="post">
<div align="center">
	<table border="0" width="580" cellspacing="8" cellpadding="8" style="font-family: Tahoma; font-size: 10pt">
		<tr>
			<td colspan="2" align="center" style="background-color: #808080"><font color="#FFFFFF"><b>Send Email Invitation</b></font></td>
		</tr>
		<tr>
			<td align="right" width="101">Enter To Email</td>
			<td align="left" width="223">
			<input type="text" name="email" size="12" id="outageDate" class="BusinessTextBox">  </td>
		</tr>
		<tr>
			<td align="right" width="101">Subject</td>
			<td align="left" width="223">
			<input type="text" name="subject" size="33" class="BusinessTextBox" value="Your Employees &amp; Tracking System"> </td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="background-color: #808080">
			<input type="submit" value="Send Email" class="ButtonStyle"><input type="reset" value="Reset" class="ButtonStyle"></td>
		</tr>
	</table>
</div>
</form>
