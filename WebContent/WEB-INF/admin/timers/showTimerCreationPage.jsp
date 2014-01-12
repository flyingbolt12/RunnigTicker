<%@page import="java.util.TimeZone"%>
<%@page import="com.lch.general.enums.TimeSheetTypes"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@page import="com.lch.general.dbBeans.LCH_BUSINESS"%>
<style>
<!--
.BusinessTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }
-->
</style>

<script type="text/javascript">

function getEmailContentsList(id, strURL) {
	var xmlHttpReq;
	dataAlert("Action : " + strURL);
	xmlHttpReq = getXMLHttp();
	xmlHttpReq.open('POST', strURL, true);
	xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlHttpReq.onreadystatechange = function() {
		if (xmlHttpReq.readyState == 4) {
			listOutEmailContents(id, xmlHttpReq.responseText);
		}
	};
	var params = getquerystring();
	dataAlert("Parameters : " + params);
	xmlHttpReq.send(params);
}

function listOutEmailContents(id, str) {
	/*
	 * alert(id); alert(str); alert(str.indexOf("disableSubmitRequired"));
	 */
	if (str.indexOf("disableSubmitRequired") != -1) 
	{
		if (document.forms[0] != null && document.forms[0].Next != null) 
		{
			document.forms[0].Next.className = "ButtonStyleDisabled";
			document.forms[0].Next.disabled = true;
		}
	} 
	else 
	{
		if (document.forms[0] != null && document.forms[0].Next != null) 
		{
			document.forms[0].Next.disabled = false;
		}
	}
	 
	 
	if( str == "null " )
	{
		dhtmlx.message({
	        type : "error",
	        expire : 6000,
	        text : "No email content is available. Create a new Email content."
	        });		 
		document.getElementById(id).innerHTML = "";
	}	 
	else if (str.indexOf("disableSubmitRequired") != 1) 
	{
		var string_to_display = str.replace("disableSubmitRequired", ".");
		document.getElementById(id).innerHTML = string_to_display;
	}
	else 
	{
		document.getElementById(id).innerHTML = str;
	}
}

function setParameter(x)
{
	document.getElementById("createTimerBtn").className = "";
	document.getElementById("createTimerBtn").disabled = true;
	/*
	list of parameters 
	1. selectExistingEmailContent
	2. showTimerContentCreationPage
	3. createTimer
	4. cancelTimer 
	*/
	if((x==3)&& (document.forms[0].actualContentId.value==null || document.forms[0].actualContentId.value.length==0))
	{
		 document.getElementById("result").innerHTML = "<font color=red> You must have to select an Email Content</font>";
		 x=-1;
		 return false;
	}
	
	if(x==1)
	{
		id = "result";
		var img= '<img border="0" src="images/ajax-loader.gif" width="100" height="100">';
		updatepage(id,img);
		document.forms[0].parameter.value='selectExistingEmailContent';
		var URL = "adminTimer.do";
		dataAlert("Raisisng the AJAX Request");
		getEmailContentsList(id, URL);
	}
	if(x==2)
	{
		document.forms[0].parameter.value='showTimerContentCreationPage';
	}
	if(x==3)
	{
		document.forms[0].parameter.value='createTimer';
		document.forms[0].submit();
	}
	if(x==4)
	{
		document.forms[0].parameter.value='cancelTimer';
	}
	
}

var isTimerNameValid = false;
var isTimerContentValid = false;    



var timerName = document.getElementById('timerName').value;
if (timerName != null && timerName.length > 0)
	verifyTimerName(timerName);

function verifyTimerName(timerName) {
    var params = {
	    ajaxParam : timerName
    };
    var obj = {
    id : "timerNameAvailabilityCheckMsg",
    url : "adminTimer.do?parameter=checkTimerNameAvailability",
    params : params,
    responseHandler : handleResponse
    };
    
    sendAjaxRequest(obj);
}

function handleResponse(obj, response) {
    removeAjaxImg(obj.id);
    
    if (response.indexOf("disableSubmitRequired") == -1) 
    {
	    isTimerNameValid = true;
	    
		if( isTimerNameValid && isTimerContentValid )
		{
			document.getElementById("createTimerBtn").className = "ButtonStyle";
			document.getElementById("createTimerBtn").disabled = false;
		}
		else 
		{
		    document.getElementById("createTimerBtn").disabled = true;
		    document.getElementById("createTimerBtn").className = 'ButtonStyleDisabled';
	    }		    
	    
	    
    } else {
	    document.getElementById("createTimerBtn").disabled = true;
	    document.getElementById("createTimerBtn").className = 'ButtonStyleDisabled';
    }
    if (response != null)
	    response = response.replace("disableSubmitRequired", "");
    placeAjaxMessage(obj.id, response);
}
if (!document.getElementById("createTimerBtn").disabled) {
	document.getElementById("createTimerBtn").className = 'ButtonStyle';
}





function selectAndInvisble()
{
	isTimerContentValid = true;
	
	if( isTimerNameValid && isTimerContentValid )
	{
		document.getElementById("createTimerBtn").className = "ButtonStyle";
		document.getElementById("createTimerBtn").disabled = false;
	}
	else 
	{
	    document.getElementById("createTimerBtn").disabled = true;
	    document.getElementById("createTimerBtn").className = 'ButtonStyleDisabled';
    }	
	var sbox = document.getElementById("contentId");
	var sboxValue = sbox.options[sbox.selectedIndex].text;
	document.forms[0].actualContentId.value= sbox.value;
    document.getElementById("result").innerHTML = "Selected Content : "+sboxValue+"<BR><BR><a href=\"javascript:setParameter(1)\">click here</a> to change again.";
}
</script>

<% LCH_BUSINESS businessDetails = (LCH_BUSINESS)request.getAttribute("businessDetails"); %>
<html:form action="/adminTimer.do" >
<html:hidden property="parameter" value=""/>
<html:hidden property="actualContentId" value=""/>
<html:hidden property="isForTimerContentCreation" value="true"/>
<div align="center">

	<table border="0" cellspacing="1" width="100%" height="422" style="font-family: Tahoma; font-size: 10pt">
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
		<td height="23" width="58" bgcolor="#EBEBEB" colspan="2">
		<font face="Tahoma" size="2"> Choose Your Option to which type of employees need to be notified with this timer :</font></td>
		
	</tr>
	<tr>
		
		<td height="160" width="671" bgcolor="#F2F2F2" colspan="2">
		<table border="0" cellspacing="0" width="100%" cellpadding="0" style="font-family: Tahoma; font-size: 10pt">
		
			<tr>
		<td height="115" width="70%">
			
			
			<table border="0" width="90%"
				style="font-family: Tahoma; font-size: 10pt">
				
				<tr>
					<td height="20" align="left" width="41">&nbsp;</td>
					<td height="20" align="left"><input type="radio"
						value="all" name="employeeType" checked> Notify all
						enabled/active employees</td>
				</tr>
				<tr>
					<td height="20" align="left" width="41">&nbsp;</td>
					<td height="20" align="left"><input type="radio"
						value="<%=TimeSheetTypes.MONTHLY%>" name="employeeType">
						Notify only Monthly TimeSheet Configured Employees</td>
				</tr>
				<tr>
					<td height="20" align="left" width="41">&nbsp;</td>
					<td height="20" align="left"><input type="radio"
						value="<%=TimeSheetTypes.WEEKLY%>" name="employeeType">
						Notify only Weekly TimeSheet Configured Employees</td>
				</tr>
				<tr>
					<td height="20" align="left" width="41">&nbsp;</td>
					<td height="20" align="left"><input type="radio"
						value="<%=TimeSheetTypes.BIWEEKLY%>" name="employeeType">
						Notify only BI-WEEKLY TimeSheet Configured Employees</td>
				</tr>
				<tr>
					<td height="20" align="left" width="41">&nbsp;</td>
					<td height="20" align="left"><input type="radio"
						value="<%=TimeSheetTypes.DAYS15%>" name="employeeType">
						Notify only 15 Days TimeSheet Configured Employees</td>
				</tr>
			
			</table>
			
			
		</td>
				<td height="107" width="365"><div id="result"></div></td>
			</tr>
		</table>
		</td>
	</tr>
	
	<tr>
		<td height="14" width="732" colspan="2" bgcolor="#F2F3FF">
		<p align="center">
			<html:button property="1" value="Select Existing Email Content" styleClass="ButtonStyle" onclick="setParameter(1)"></html:button>
			<html:submit property="2" value="Create New Email Content" styleClass="ButtonStyle" onclick="setParameter(2)"></html:submit>
		</p>
		</td>
	</tr>
</table>
			</div>
			</td>
		</tr>
		<tr>
			<td height="23" width="736" bgcolor="#808080">
			<span style="letter-spacing: 1pt"><font color="#FFFFFF">
			<b>Timers will be created using Timezone : <%= TimeZone.getDefault().getDisplayName(true,TimeZone.SHORT) %> (<%= TimeZone.getDefault().getDisplayName() %>)</b></font></span></td>
		</tr>
		<tr>
			<td height="120" width="736">
			<div align="center">
<table border="0" cellspacing="1" width="100%" style="font-family: Tahoma; font-size: 10pt">
	<tr>
		<td height="12" width="100" bgcolor="#F2F2F2">Timer Name<font color="#FF0000">*</font></td>
		<td height="12" width="500" bgcolor="#F2F2F2">
			<html:text property="timerName" styleClass="BusinessTextBox" tabindex="4" onblur="verifyTimerName(this.value)" styleId="timerName"/>
			<font color="#FF0000"><span id="timerNameAvailabilityCheckMsg"></span></font>
		</td>
		
		
	</tr>
	<tr>
		<td height="22" width="100" bgcolor="#EBEBEB">Cron Expressions</td>
		<td height="22" width="500" bgcolor="#EBEBEB">
		<BR>
			1. In computer world, to schedule a job which can be executed by weekly, monthly, yearly etc., you need a cron expression.
			<BR>
			2. To build a cron expression <a href="javascript:openNewWindow();">click here</a><BR>
			3. Click on button <Strong>Generate Cron Expression</Strong>, then copy <Strong>Cron format</Strong> value from the result and paste that expression into this text box.<br> 
			<html:text property="cronExpression" styleClass="BusinessTextBox" tabindex="4" value="" /><BR>
<!-- 			</td>  -->
		</td>
	<tr>
		<td height="24" width="646" colspan="2" bgcolor="#F2F3FF">
		<p align="center">
			<html:button styleId="createTimerBtn" property="3" value="Create Timer" styleClass="ButtonStyleDisabled"  onclick="setParameter(3)" disabled="true"></html:button>
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

<script language="JavaScript">
 <!-- hide
 function openNewWindow() {
 popupWin = window.open('http://www.cronmaker.com', 'Create Your Cron Expression', ', , , , , scrollbars, resizable, dependent, width=740, height=500, left=200, top=200');
 }
 // done hiding -->
 </script>

 
 
 