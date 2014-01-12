
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Downloaad employee starting and ending with </title>
<style>
<!--
.BusinessTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }
-->
</style>
<div align="center">
<html:form action="downloadReports.do">
<input type="hidden" name="parameter" value="downloadEmployeeStratingAndEndingWithNamesPdf">

<table border="0" width="100%" style="font-family: Tahoma; font-size:10pt">
<tr><td height="22" width="600" bgcolor="#808080" colspan="4" >
	<p align="center"><font size="2" color="#FFFFFF"><b>Download employees starting and ending with Names</b></font></td>

</tr>
<tr><td height="22" colspan="2" bgcolor="#F4F4F4">
	<p align="left" >Select an Option for which Name Starting with : </td>

		<td height="22" bgcolor="#F4F4F4">
		<p align="right">
				<html:select size="1" property="lastNameListBox" styleClass="BusinessTextBox" style="font-family: Tahoma; font-size: 10pt">
		<option >firstName</option>

		<option selected>lastName</option>
<!-- 		<option>clientWorkingFor</option> -->
		
		</html:select></td>
		<td height="22" bgcolor="#F4F4F4">
		
		<html:text  property="startingWithText" size="19" styleClass="BusinessTextBox" tabindex="1"></html:text>
		</td>
		
		
	</tr>
	
	<tr><td height="22" colspan="2" bgcolor="#F4F4F4">
	<p align="left">Select an Option for which Name Ending with : </td>


		<td height="22" bgcolor="#F4F1F4">
		<p align="right">
				<html:select size="1" property="clientWorkingForListBox" styleClass="BusinessTextBox" style="font-family: Tahoma; font-size: 10pt">
		<option >firstName</option>
		<option >lastName</option>
<!-- 		<option selected>clientWorkingFor</option> -->
		</html:select></td>
		<td height="22" bgcolor="#F4F1F4">
		
		<html:text property="endingWithText" size="19" styleClass="BusinessTextBox" tabindex="2"></html:text>
		</td>
		</tr>

	<tr>
		<td height="22" colspan="4" bgcolor="#F4F4F4" align="center">
		
				<html:submit property="downLoad" value="DownLoad" styleClass="ButtonStyle" ></html:submit>
                <html:submit value="Cancel" property="cancel" onclick="cancelDownload()"  styleClass="ButtonStyle" ></html:submit>
		</td>
	</tr>
</table>
</html:form>
</div>

<script>
	function cancelDownload()
	{  
      document.forms[0].action="downloadReports.do";
      document.forms[0].parameter.value="downloadCancelation";
      document.forms[0].submit();
		
	}
	
	</script>	