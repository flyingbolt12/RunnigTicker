<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<div align="center">
<form action="adminFunctImpl.do" name="businessId">
<input type="hidden" name="parameter" value="sendMyBusinessUniqueIdentificationNumber">
	<table border="0" cellspacing="0" width="60%" height="57" cellpadding="0" style="font-family: Tahoma; font-size: 10pt">
		<tr>
			<td height="19" width="450" bgcolor="#808080">
			<p align="center"><b><font color="#FFFFFF">Choose an Option Below</font></b></td>
		</tr>
		<tr>
			<td height="19" width="450" align="center"  bgcolor="#F4F4F4">
			<input type="radio" value="sms" checked name="R1" disabled="disabled">Send an SMS (Not available as of now)</td>
		</tr>
		<tr>
			<td height="16" width="450" align="center">
			<input type="radio" value="email" checked name="R1">Send as an Email</td>
		</tr>
		<tr>
			<td height="5" width="450"  bgcolor="#F4F4F4">
			<p align="center"><input type="submit" value="Submit" name="button" class="ButtonStyle"></td>
		</tr>
	</table>
</form>
</div>