
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<c:if test="${UserprofileUploadStatus == 'no'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"<%= request.getAttribute("generalAJAXMsg")%>"});
	</script>
</c:if>
<div align="center">
<html:form action="/memberFunctImpl.do?parameter=updateMyResume"
	enctype="multipart/form-data">

	<table border="0" cellspacing="1" width="60%" 
		style="font-family: Tahoma; font-size: 10pt">
    <tr>
		<td height="18" width="453" bgcolor="#808080" colspan="2">
		<p align="center"><b><font color="#FFFFFF" style="font-size: 10.0pt; font-family: Tahoma">Update my Resume, Previous one will be replaced with this if any.</font></b></td>
	</tr>

		<tr>
			<td height="18" width="208" bgcolor="#FFFFFF"><span
				style="font-size: 10.0pt; font-family: Tahoma">Profile Path&nbsp;:</span></td>
			<td height="18" width="396" bgcolor="#FFFFFF"><html:file
				property="profilePath" styleClass="EmployeeTextBox" size="20"
				tabindex="14"></html:file></td>
		</tr>
		<tr>
			<td height="6" width="352" bgcolor="#FFFFFF" align="left" colspan="2">
			<p class="MsoNormal" align="center"><font color="#808080"><b>&nbsp;you can attach file up to 2 megabytes (MB) in size.</b></font></td>
		</tr>
		<tr>
			<td height="18" width="453" bgcolor="#F4F4F4" colspan="2" align="center" ><html:submit
				property="submit" value="Submit" styleClass="ButtonStyle"
				tabindex="12"></html:submit> </td>
		</tr>
	</table>
</html:form>

</div>