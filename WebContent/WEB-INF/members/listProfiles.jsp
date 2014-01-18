
<%@page import="java.util.List"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<%@page import="java.util.Map"%><style>
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

.HTMLLINK { text-decoration:none;font-family: Tahoma; font-size: 10pt; color: #008080; 
               padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }
-->
</style>


<div align="center">
<table border="0" cellspacing="1" width="1240" height="66"
	style="font-family: Tahoma; font-size: 10pt">
	<tr>
		<td height="20" width="156" align="center" bgcolor="#808080"><font
			color="#FFFFFF">Title</font></td>
		<td height="20" width="119" align="center" bgcolor="#808080"><font
			color="#FFFFFF">Uploaded Date</font></td>
		<td height="20" width="119" align="center" bgcolor="#808080"><font
			color="#FFFFFF">Download</font></td>
			
	</tr>
	<%
		String idattacheddocs = "";
	%>
	<logic:iterate id="profile"
		name="profilesList">
		<%
		idattacheddocs = String
							.valueOf(((Map) profile)
									.get("idattacheddocs"));
		%>
		<tr>
			<td height="20" width="119" align="center" bgcolor="#EBEBEB"><bean:write
				name="profile" property="docName" /></td>
			<td height="20" width="124" align="center" bgcolor="#EBEBEB"><bean:write
				name="profile" property="attachedDate" /></td>
			<td height="20" width="119" align="center" bgcolor="#EBEBEB"><html:link paramId ="idattacheddocs" paramName="profile" paramProperty="idattacheddocs"  action="memberFunctImpl.do?parameter=downloadProfile"> click here to download</html:link> </td>
		</tr>

	</logic:iterate>
</table>
</div>

