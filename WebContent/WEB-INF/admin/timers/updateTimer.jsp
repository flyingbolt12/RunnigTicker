<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@page import="com.lch.general.dbBeans.LCH_BUSINESS"%>

<%@page import="java.util.Map"%><style>
<!--
.BusinessTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }

-->
</style>

<script type="text/javascript">
function setParameter(x)
{
	/*
	list of parameters 
	3. update Timer
	4. cancelTimer 
	*/
	if(x==3)
	{
		document.forms[0].parameter.value='updateTimerDetails';
		//document.forms[0].contentId.value=
		//document.forms[0].timerId.value=
		document.forms[0].submit();
	}
	if(x==4)
	{
		document.forms[0].parameter.value='cancelTimer';
	}
	
}

function selectAndInvisble(){
	document.forms[0].contentId.value=document.forms[0].contentId.value;
}
</script>
<%
Map m=(Map)request.getAttribute("emailReminderData");
String timerTime="";
String timerStartDate="";
String timerEndDate="";
String timerName="";
String emailReminderType="";
String contentName="";
String timerId="";
if(m!=null)
{
	//not well coded jsp
	timerName=((String)m.get("timerName")!=null)?(String)m.get("timerName"):"";
	emailReminderType=((String)m.get("emailReminderType")!=null)?(String)m.get("emailReminderType"):"";
	timerTime=((String)m.get("timerTime")!=null)?(String)m.get("timerTime"):"";
	timerStartDate=((String)m.get("timerStartDate")!=null)?(String)m.get("timerStartDate"):"";
	timerEndDate=((String)m.get("timerEndDate")!=null)?(String)m.get("timerEndDate"):"";
	timerId=(String.valueOf( m.get("timerId"))!=null)?(String.valueOf(m.get("timerId"))):"";
}


%>
<% LCH_BUSINESS businessDetails = (LCH_BUSINESS)request.getAttribute("businessDetails"); %>
<html:form action="/adminTimer.do">
<html:hidden property="parameter" value=""/>
<html:hidden property="contentId" value=""/>
<html:hidden property="timerId" value=""/>
<div align="center">
	<table border="0" cellspacing="1" width="740" height="422" style="font-family: Tahoma; font-size: 10pt">
		<tr>
			<td height="23" width="736" bgcolor="#808080">
			<span style="letter-spacing: 1pt"><font color="#FFFFFF">
			<b>Mail Details:</b></font></span></td>
		</tr>
		<tr>
			<td height="250" width="736">
			<div align="center">

<table border="0" cellspacing="1" width="100%">
	<tr>
		<td height="23" width="58" bgcolor="#F2F2F2">
		<font face="Tahoma" size="2">from:</font></td>
		<td height="23" width="671" bgcolor="#F2F2F2">
		<html:select size="1" property="fromAddress" styleClass="BusinessTextBox">
		<option><%=businessDetails.getEmployerEmail() %></option>
		</html:select></td>
	</tr>
	<tr>
		<td height="23" width="58" bgcolor="#EBEBEB">
		<font face="Tahoma" size="2">cc:</font></td>
		<td height="23" width="671" bgcolor="#EBEBEB">
		<html:text property="emailCc" styleClass="BusinessTextBox" tabindex="4" /></td>
	</tr>
	<tr>
		<td height="160" width="58" bgcolor="#F2F2F2">
		<font face="Tahoma" size="2">bcc:</font></td>
		<td height="160" width="671" bgcolor="#F2F2F2">
		<table border="0" cellspacing="0" width="100%" cellpadding="0" style="font-family: Tahoma; font-size: 10pt">
			<tr>
				<td height="18" width="523" colspan="2">
		<font face="Tahoma" size="2">Select the check box to <b>exclude</b> users 
		whom you do not want to send emails if any.</font></td>
			</tr>
			<tr>
		<td height="115" width="145">
			<html:select property="excludeList" multiple="true" styleClass="BusinessTextBox" size="10">
				<logic:iterate id="listAllMyEmployeesId" name="listAllMyEmployees">
					<option value="<bean:write name="listAllMyEmployeesId" property="iduser"/>"><bean:write name="listAllMyEmployeesId" property="firstName"/> - <bean:write name="listAllMyEmployeesId" property="contactEmail"/> </option>
				</logic:iterate>
				<html:option value="None">None</html:option>
			</html:select>
		</td>
				<td height="35" width="365"><div id="result">
				<p align="center">Email Content:		
				<html:select size="1" property="contentId" styleClass="BusinessTextBox" >
			<html:options collection="listBusinessEmailContent" property="contentId" labelProperty="contentName" />
		</html:select>
				</div></td>
			</tr>
		</table>
		</td>
	</tr>	
	<tr>
		<td height="23" width="58" bgcolor="#EBEBEB">
		<font face="Tahoma" size="2"> Subject :</font></td>
		<td height="23" width="700" bgcolor="#EBEBEB">
		<html:text property="subject" styleClass="BusinessTextBox" tabindex="4" /></td>
	</tr>
</table>
			</div>
			</td>
		</tr>
		<tr>
			<td height="23" width="736" bgcolor="#808080">
			<span style="letter-spacing: 1pt"><font color="#FFFFFF">
			<b>Timer Details:</b></font></span></td>
		</tr>
		<tr>
			<td height="120" width="736">
			<div align="center">
<table border="0" cellspacing="1" width="100%" style="font-family: Tahoma; font-size: 10pt">
	<tr>
		<td height="12" width="244" bgcolor="#F2F2F2">Timer Identification Name</td>
		<td height="12" width="397" bgcolor="#F2F2F2">
		<html:text property="timerName" value="<%=timerName%>" styleClass="BusinessTextBox" tabindex="4" /></td>
	</tr>
	<tr>
		<td height="22" width="244" bgcolor="#EBEBEB">Timer Type:</td>
		<td height="22" width="397" bgcolor="#EBEBEB">
			<html:select size="1" property="timerTypeId" value="<%=emailReminderType%>" styleClass="BusinessTextBox" >
				<html:options collection="listTimerTypes" property="emailReminderTypeId"  labelProperty="emailReminderType" />
			</html:select>
		</td>
	</tr>
	<tr>
		<td height="22" width="244" bgcolor="#F2F2F2">Time</td>
		<td height="22" width="397" bgcolor="#F2F2F2">
		<html:text property="timerTime" value="<%=timerTime%>" styleClass="BusinessTextBox" tabindex="4" /> 
		HH:MM:SS</td>
	</tr>
	<tr>
		<td height="22" width="244" bgcolor="#EBEBEB">Timer Start 
		Date</td>
		<td height="22" width="397" bgcolor="#EBEBEB">
		<html:text property="timerStartDate" value="<%=timerStartDate%>" styleClass="BusinessTextBox" tabindex="4" styleId="timerStartDate" />
		<img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector" style="border: 1px solid green; cursor: pointer;" id="f_trigger_c" src="jscalendar-1.0/img.gif"/> 
		MM-DD-YYYY</td>
	</tr>
	<tr>
		<td height="22" width="244" bgcolor="#F2F2F2">Timer End 
		Date</td>
		<td height="22" width="397" bgcolor="#F2F2F2">
		<html:text property="timerEndDate" value="<%=timerEndDate%>" styleClass="BusinessTextBox" tabindex="4" styleId="timerEndDate"/>
<img onmouseout="this.style.background=''" onmouseover="this.style.background='cyan';" title="Date selector" style="border: 1px solid blue; cursor: pointer;" id="f_trigger_cc" src="jscalendar-1.0/img.gif"/> 
		MM-DD-YYYY</td>
	</tr>
	<tr>
		<td height="24" width="646" colspan="2" bgcolor="#F2F3FF">
		<p align="center">
			<html:button property="3" value="Update Timer" styleClass="ButtonStyle" onclick="setParameter(3)" ></html:button>
			<html:submit property="4" value="Cancel Timer" styleClass="ButtonStyle" onclick="setParameter(4)"></html:submit>
		</p>
		</td>
	</tr>
</table>

			</div>
			</td>
		</tr>
	</table>
</div>
</html:form>
<script>
document.forms[0].contentId.value="";
</script>
<script type="text/javascript">
    Calendar.setup({
        inputField     :    "timerStartDate",
        ifFormat       :    "%m-%e-%Y",
        button         :    "f_trigger_c",
        align          :    "Tl",
        singleClick    :    false
    });
    Calendar.setup({
        inputField     :    "timerEndDate",
        ifFormat       :    "%m-%e-%Y",
        button         :    "f_trigger_cc",
        align          :    "Tl",
        singleClick    :    false
    });
</script>
