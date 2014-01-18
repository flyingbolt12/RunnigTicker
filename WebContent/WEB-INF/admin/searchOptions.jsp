<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<%@page import="com.lch.struts.formBeans.SearchOptions"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<div align="center">

Search for emploee(s) for whom you want to do the selected operation if any :
 <BR>
<html:form method="POST" action="adminFunctImpl.do?parameter=doSearch">
	<p>&nbsp;</p>
<table border="0" cellspacing="1" width="100%" height="172"
	style="font-family: Tahoma; font-size: 10pt">

<html:messages id="msg" message="true">
<tr><td height="20" colspan="8" style="color: #FF0000; background-color: #000000">
<bean:write name="msg"/></td></tr>
</html:messages>

	<tr>
		<td height="20" colspan="8" style="color: #FFFFFF; background-color: #008080"><bean:message key="searchOption.message"/> </td>
	</tr>
	<tr>
		<td height="10" width="80"></td>
		<td height="10" width="113"></td>
		<td height="10" width="30"></td>
		<td height="10"></td>
		<td height="10">Client Name</td>
		<td height="10">Client Location</td>
		<td height="10">Country</td>
		<td height="10" width="181">State</td>
	</tr>
	<tr>
			<td height="26" width="80" align="left">LastName</td>
			<td height="26" width="113"><html:text property="lastName" size="20" styleClass="TextBoxStyle"/></td>
		<td height="26" width="43"><html:radio value="like" property="lastNameRadio"/>like</td>
		<td height="26"><html:radio value="exact" property="lastNameRadio"/>exact</td>
		<td height="116" rowspan="7">
		
		<html:select size="8" property="clientWorkingForList" multiple="true" styleClass="TextBoxStyle" >
			<logic:present name="searchOptions" property="clientWorkingForList2Display">
				<logic:iterate id="result" name="searchOptions"	property="clientWorkingForList2Display" indexId="index">
					<bean:define id="print" name="result" property="clientWorkingFor"/>
					<html:option value="<%=print.toString() %>"><bean:write name="result" property="clientWorkingFor"/></html:option>
				</logic:iterate>
			</logic:present>
		</html:select></td>
		<td height="116" rowspan="7"><html:select size="8" property="cityList" multiple="true" styleClass="TextBoxStyle">
			<logic:present name="searchOptions" property="cityList2Display">
				<logic:iterate id="result" name="searchOptions" property="cityList2Display"	indexId="index">
					<bean:define id="print" name="result" property="city"/>
					<html:option value="<%=print.toString() %>"><bean:write name="result" property="city"/></html:option>
				</logic:iterate>
			</logic:present>
		</html:select></td>
		<td height="116" rowspan="7"><html:select size="8" property="countryList" multiple="true" styleClass="TextBoxStyle">
			<logic:present name="searchOptions" property="countryList2Display">
				<logic:iterate id="result" name="searchOptions"	property="countryList2Display" indexId="index">
					<bean:define id="print" name="result" property="country"/>
					<html:option value="<%=print.toString() %>"><bean:write name="result" property="country"/></html:option>
				</logic:iterate>
			</logic:present>
		</html:select></td>
		<td height="116" rowspan="7" width="181"><html:select size="8" property="stateList" multiple="true" styleClass="TextBoxStyle">
			<logic:present name="searchOptions" property="stateList2Display">
				<logic:iterate id="result" name="searchOptions" property="stateList2Display" indexId="index">
					<bean:define id="print" name="result" property="state"/>
					<html:option value="<%=print.toString() %>"><bean:write name="result" property="state"/></html:option>
				</logic:iterate>
			</logic:present>
		</html:select></td>
	</tr>
	<tr>
			<td height="26" width="80" align="left">FirstName</td>
			<td height="26" width="113"><html:text property="firstName" size="20" styleClass="TextBoxStyle"/></td>
		<td height="26" width="30"><html:radio value="like" property="firstNameRadio"/>like</td>
		<td height="26"><html:radio value="exact" property="firstNameRadio"/>exact</td>
	</tr>
	<tr>
			<td height="26" width="80" align="left">ZipCode</td>
			<td height="26" width="113"><html:text property="zipCode" size="20" styleClass="TextBoxStyle"/></td>
		<td height="26" width="30"><html:radio value="like" property="zipCodeRadio"/>like</td>
		<td height="26"><html:radio value="exact" property="zipCodeRadio"/>exact</td>
	</tr>
	<tr>
		<td height="6" colspan="4"></td>
	</tr>
	<tr>
			<td height="22" width="80" align="left">Email</td>
			<td height="22" width="113"><html:text property="email" size="20" styleClass="TextBoxStyle"/></td>
		<td height="22" width="30"><html:radio value="like" property="emailRadio"/>like</td>
		<td height="22"><html:radio value="exact" property="emailRadio"/>exact</td>
	</tr>
	<tr>
		<td height="2" width="80"></td>
		<td height="2" colspan="3"></td>
	</tr>
	<tr>
		<td height="2" width="80"></td>
		<td height="2" colspan="3"></td>
	</tr>
	<tr>
		<td height="2" width="80"></td>
		<td height="2" colspan="3"></td>
		<td height="2"></td>
		<td height="2" colspan="3"></td>
	</tr>
</table>

<p align="center">
	<input type="submit" value="Search" name="Search" class="button">
	<input type="reset" value="Reset" name="B2" class="button"></p>
</html:form>
</div>