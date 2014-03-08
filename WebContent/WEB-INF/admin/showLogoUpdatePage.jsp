
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
<html:form action="/adminFunctImpl.do?parameter=uploadLogo"
	enctype="multipart/form-data">

	<table border="0" cellspacing="1" width="60%" 
		style="font-family: Tahoma; font-size: 10pt">
    <tr>
		<td height="18" width="453" bgcolor="#808080" colspan="2">
		<p align="center"><b><font color="#FFFFFF" style="font-size: 10.0pt; font-family: Tahoma">Update Business Logo.</font></b></td>
	</tr>

		<tr>
			<td height="18" width="208" bgcolor="#FFFFFF"><span
				style="font-size: 10.0pt; font-family: Tahoma">Logo Path&nbsp;:</span></td>
			<td height="18" width="396" bgcolor="#FFFFFF"><html:file
				property="logo" styleClass="EmployeeTextBox" size="20"
				tabindex="14"></html:file> <BR>This image shouldn't be more than 500 KB</td>
		</tr>
		<tr>
			<td height="18" width="453" bgcolor="#F4F4F4" colspan="2" align="center" ><html:submit
				property="submit" value="Submit" styleClass="ButtonStyle"
				tabindex="12"></html:submit> <html:submit
				property="submit" value="Restore to default logo" styleClass="ButtonStyle"
				tabindex="12"></html:submit> </td>
		</tr>
		
		
	</table>
</html:form>

</div>