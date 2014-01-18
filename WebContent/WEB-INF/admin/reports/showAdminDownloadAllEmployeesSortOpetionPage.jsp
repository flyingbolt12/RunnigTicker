<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<style>
<!--
.BusinessTextBox {
	font-family: Tahoma;
	font-size: 10pt;
	color: #008080;
	border: 1px solid #808080;
	padding-left: 4px;
	padding-right: 4px;
	padding-top: 1px;
	padding-bottom: 1px
}

-->
</style>
<form action="downloadReports.do" target="_blank">
<input type="hidden" name="parameter" value="downloadAllEmployees">
<table border="0" height="44" align="center">
	<tbody>
		<tr>
			<td height="22" width="600" bgcolor="#808080" colspan="4"
				align="center"><font size="2" color="#FFFFFF">Download all my employees list
			</font></b></td>
		</tr>
		<tr>
			<td width="64" height="22"><font size="2"> Sort By: </font></td>
			<td width="180" height="22"><select size="1" name="orderBy_1"
				class="BusinessTextBox">
				<option selected="selected" value="firstName">First Name</option>
				<option value="lastName">Last Name</option>
				<option value="clientWorkingFor">Client Working For</option>
			</select></td>
			<td width="170" height="22"><select size="1" name="orderBy_2"
				class="BusinessTextBox">
				<option value="firstName">First Name</option>
				<option value="lastName" selected="selected" >Last Name</option>
				<option value="clientWorkingFor">Client Working For</option>
			</select></td>

			<td width="168" height="22"><select size="1" name="orderBy_3"
				class="BusinessTextBox">
				<option value="firstName">First Name</option>
				<option value="lastName">Last Name</option>
				<option value="clientWorkingFor" selected="selected">Client Working For</option>
			</select></td>
		</tr>
		<tr>
			<td colspan="4" bgcolor="#f4f4f4" width="600" height="22" align="center"> <input
				type="submit" name="download" value="DownLoad" class="ButtonStyle">
			<input type="submit" name="cancel" value="Cancel" class="ButtonStyle">
			</td>
		</tr>
	</tbody>
</table>
</form>




