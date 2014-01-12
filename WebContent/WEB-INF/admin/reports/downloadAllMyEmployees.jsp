<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Sort By</title>
<style>
<!--
.BusinessTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }
-->
</style><div align="center">
<form action="downloadReports.do">
<table style="font-family: Tahoma;" border="0" width="600" height="44">
	<tbody>
   <tr>
		<td height="22" width="600" bgcolor="#808080" colspan="4" align="center">
		
		<font size="2" color="#FFFFFF"><b>All my Employees</b></font></td>
	</tr>
   <tr>
		<td width="64" height="22">
		<font size="2"> Sort By: </font></td>
		<td  width="180" height="22">
		<p align="center">
		<select size="1" name="D1" class="BusinessTextBox" style="font-family: Tahoma; font-size: 10pt;">
		<option selected="selected">firstName</option>
		<option>lastName</option>
		<option>clientWorkingFor</option>
		<option>total Years of Experience</option>

		</select></td>
		<td  width="170" height="22">
		<p>
		<select size="1" name="D2" class="BusinessTextBox" style="font-family: Tahoma; font-size: 10pt;">
		<option>firstName</option>
		<option selected="selected">lastName</option>
		<option>clientWorkingFor</option>
		<option>total Years of Experience</option>

		</select></td>
		
		<td  width="168" height="22">
		<p align="center">
		<select size="1" name="D1" class="BusinessTextBox" style="font-size: 10pt; font-family: Tahoma; vertical-align: middle; letter-spacing: 0pt;">
		<option>firstName</option>
		<option>lastName</option>
		<option selected="selected">clientWorkingFor</option>
		<option>total Years of Experience</option>

		</select></td>
	</tr>

	<tr><td colspan="4" bgcolor="#f4f4f4" width="600" height="22">
				<p align="center">
				<font bgcolor="#F4F4F4" size="2" face="Tahoma">
				
				<input type="submit" name="download" value="DownLoad" onclick="setParameter(1)" class="ButtonStyle" style="font-size: 8pt; font-family: Tahoma;" type="button">
					
				
					
				<input type="submit"  name="cancel" value="Cancel" onclick="setParameter(2)" class="ButtonStyle" style="font-family: Tahoma; font-size: 8pt;" type="button"></font></p></td>
	
	
			
	<input type="hidden" name="parameter" value="allMyEmployeesNext"> 
</tr></tbody></table>
</form></div>



