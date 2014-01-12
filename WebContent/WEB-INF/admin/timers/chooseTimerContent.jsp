<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<html:form  action="/adminTimer.do">
<table border="0" cellspacing="1" width="100%" style="font-family: Tahoma; font-size: 10pt">
	<tr>
		<td height="27" width="249">Select an email content below &gt;&gt;</td>
	</tr>
	<tr>
		<td width="249">
		<html:select size="1" property="contentId" styleClass="BusinessTextBox" styleId="contentId">
			<html:options collection="listBusinessEmailContent" property="contentId" labelProperty="contentName" />
		</html:select></td>
	</tr>
	<tr>
		<td>
			<input type="button" value="Select" class="ButtonStyle" onclick="selectAndInvisble()">
		</td>
	</tr>
</table>
</html:form>