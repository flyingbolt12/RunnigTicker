<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<style>
.BussinessTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }

</style>
<div align="center">
<form action="adminFunctImpl.do">
<input type="hidden" name="parameter" value="sendBusinessIdToEmails">
<table border="0" width="783" height="88" style="font-family: Tahoma; font-size: 10pt">
	<tr>
		<td height="21" width="777" colspan="2" bgcolor="#808080">
		<p align="center"><font color="#FFFFFF" size="2" face="Tahoma"><b>Configure Emails</b></font></td>
	</tr>
	<tr>
		<td height="36" width="400"><font size="2" face="Tahoma">Enter Email Id (Separated by Comma (,))<br>
		eg: one@gmail.com,2@yahoo.com...Paste all your emails</font></td>
		<td height="36" width="400">
		<textarea rows="7" name="emailsList" cols="65" class="BussinessTextBox"  ></textarea><html:errors/></td>
	</tr>
	<tr>
		<td height="23" width="776"  bgcolor="#F4F4F4" colspan="2">
		<p align="center">
		<input type="submit" value="Submit" name="submit" class="ButtonStyle">
		<input type="submit" value="Cancel" name="cancel" class="ButtonStyle" onclick="cancelRequest()"></td>
	</tr>
</table>
</form>

</div><p>&nbsp;</p>
<script type="text/javascript">
function cancelRequest(){
	document.forms[0].parameter.value = "cancelRequest";
	document.forms[0].submit();
}
</script>
