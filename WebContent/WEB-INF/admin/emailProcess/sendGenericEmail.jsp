<%@page import="com.lch.general.enums.TimeSheetTypes"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<style>
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
</style>
<script type="text/javascript" src="js/tinyMCE/js/tinymce/tinymce.min.js"></script>
<script type="text/javascript">
	tinymce
            .init({
            selector : "textarea",
            theme : "modern",
            plugins : [
            "autolink lists link image charmap print preview hr anchor pagebreak", "searchreplace wordcount visualblocks visualchars code fullscreen", "insertdatetime media nonbreaking save table contextmenu directionality", "paste textcolor"
            ],
            toolbar1 : "styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
            toolbar2 : "preview media | forecolor backcolor"
            });
</script>

<html:form action="notifyEmployees.do" method="POST" enctype="multipart/form-data">
<input type="hidden" name="parameter" value="sendGenericEmailToEmployees">
	<div align="center">
	<html:errors/>
		<table border="0" width="80%" style="font-family: Tahoma; font-size: 10pt" cellspacing="3" cellpadding="3">
			<tr>
				<td class="tdSideHeader" colspan="2">
					<p align="center">
						<b>Notify Employees</b>
				</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="radio" value="all" name="employeeType" checked> Notify all enabled/active employees</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="radio" value="<%=TimeSheetTypes.MONTHLY%>" name="employeeType"> Notify only Monthly TimeSheet Configured Employees</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="radio" value="<%=TimeSheetTypes.WEEKLY%>" name="employeeType"> Notify only Weekly TimeSheet Configured Employees</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="radio" value="<%=TimeSheetTypes.BIWEEKLY%>" name="employeeType"> Notify only BI-WEEKLY TimeSheet Configured Employees</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="radio" value="<%=TimeSheetTypes.DAYS15%>" name="employeeType"> Notify only 15 Days TimeSheet Configured Employees</td>
			</tr>
			<tr>
				<td class="tdSideHeader" colspan="2"> <b>Type Subject <font color="red">*</font></b></td>
			</tr>
			<tr>
				<td></td>
				<td><html:text property="subject" size="100%" styleClass="BusinessTextBox"></html:text> <html:messages id="err_name" property="subject"></html:messages></td>
			</tr>
			<tr>
				<td class="tdSideHeader" colspan="2"> <b>Attach If any</b></td>
			</tr>
			<tr>
				<td></td>
				<td><html:file property="attachement" styleClass="BusinessTextBox" size="100%"></html:file>File Size should be less that 2 MB. Executable files will be filtered by email providers.</td>
			</tr>
			<tr>
				<td class="tdSideHeader" colspan="2"><b>Type Message <font color="red">*</font></b></td>
			</tr>
			<tr>
				<td></td>
				<td><textarea name="emailContent" style="width: 100%"></textarea><html:messages id="err_name" property="emailContent"></html:messages></td>
			</tr>
			<tr>
				<td height="4" align="center" colspan="2">
				<html:submit property="Notify" value="Notify" styleClass="ButtonStyle"></html:submit>
				 <html:reset property="Reset" value="Reset" styleClass="ButtonStyle"></html:reset>
				 <html:button property="Cancel" value="Cancel" styleClass="ButtonStyle" onclick="cancelRequest()"></html:button></td>
			</tr>
		</table>
	</div>
</html:form>
<html:form action="adminFunctImpl.do">
<input type="hidden" name="parameter" value="cancelRequest">
</html:form>
<script type="text/javascript">
function cancelRequest(){
	document.forms[1].parameter.value = "cancelRequest";
	document.forms[1].submit();
}
</script>