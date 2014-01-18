
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<style>
.EmployeeTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }
</style>



<form action="forgotPassword.do" method="POST">
<input type="hidden" name="parameter" value="forgotPassword">
<div align="center">
<table border="0" cellspacing="1" width="73%" height="82" style="font-family: Tahoma; font-size: 10pt">
	<tr>
		<td height="23" width="98%" colspan="2" bgcolor="#808080">
		<p align="center"><b><font color="#FFFFFF" face="Tahoma" size="2">Retrieve the password</font></b></p></td>
	</tr>
	<tr>
		<td height="26" width="40%">
		<p align="right"><font size="2" face="Tahoma">Enter your email-id&nbsp; 
		</font>: &nbsp; </td>
		<td width="59%"><input type="text" name="emailId"> <html:errors/></td>
	</tr>
	<tr>
		<td height="29" width="98%" colspan="2" bgcolor="#F4F4F4">
		<p align="center">
		<input type="submit" value="Submit" name="submit" class="ButtonStyle">
		<input type="reset" value="Reset" name="reset" class="ButtonStyle"></p></td>
	</tr>
</table>
</div>
</form>