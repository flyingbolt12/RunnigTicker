<%@page import="com.lch.general.generalBeans.ImmigrationDetailsBean"%>
<%@page import="java.util.Map"%>
<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@page import="java.util.List"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="org.apache.commons.collections.map.ListOrderedMap"%><style>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
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

.SpanStyle {
	font-family: Tahoma;
	font-size: 10pt;
}
-->
</style>

<c:if test="${not empty status}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"${status}" });
	</script>
</c:if>
<%
	long idimmigrationdetails=0;
	String visaType = "";
	String passportExpiryDate = "";
	String visaIssuedDate = "";
	String visaExpiryDate = "";
	String passportIssueDate = "";
	String passportNumber = "";
	long  businessId = 0;
	long userId = 0;

	UserProfile userProfile = (UserProfile) session.getAttribute("userProfile");
	businessId = userProfile.getBusinessId();
	userId = userProfile.getUserId();

	ImmigrationDetailsBean immigrationDetails= (ImmigrationDetailsBean) request.getAttribute("immigrationDetails");
	
	if (immigrationDetails != null) {
		idimmigrationdetails = immigrationDetails.getIdimmigrationdetails();
		passportExpiryDate = immigrationDetails.getPassportExpiryDate().toString();
		visaType = immigrationDetails.getVisaType();
		visaIssuedDate = immigrationDetails.getVisaIssuedDate().toString();
		visaExpiryDate = immigrationDetails.getVisaExpiryDate().toString();
		passportIssueDate = immigrationDetails.getPassportIssueDate().toString();
		passportNumber = immigrationDetails.getPassportNumber().toString();
	}
	else{
		immigrationDetails = new ImmigrationDetailsBean();
	}
%>
<div align="center">

<form action="memberFunctImpl.do" method="post">
<input type="hidden" name="idimmigrationdetails" value="<%=idimmigrationdetails%>">
<input type="hidden" name="userId" value="<%=userId%>">
<input type="hidden" name="parameter" value="saveOrUpdateImmigrationDetails">
<table border="0" cellspacing="1" style="font-family: Tahoma; font-size: 10pt" id="table1">

	<tr>
		<td   bgcolor="#808080" colspan="3">
		<p align="center"><font size="2" color="#FFFFFF"><b>Add or Update Immigration Details</b></font>
		</td>
	</tr>
	
	<tr>
		<td   align="left" rowspan="2"><span class="SpanStyle">Passport Number</span></td>
	</tr>
	<tr>
		<td  ></td>
		<td  ><input type="text" name="passportNumber" value="<%=passportNumber%>" size="20" tabindex="2" class="EmployeeTextBox" ></td>
	</tr>

	<tr>
		<td   align="left" rowspan="2"><span class="SpanStyle">Passport Issue Date</span></td>
	</tr>
	<tr>
		<td  ></td>
		<td  ><input type="text" name="passportIssueDate" value="<%=passportIssueDate%>" size="20" tabindex="2" class="EmployeeTextBox" id="passportIssueDate">
		<img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector" style="border: 1px solid green; cursor: pointer;" id="f_passportIssueDate_c" src="jscalendar-1.0/img.gif"/> 
		<font size="2"><span style="font-family: Tahoma">YYYY-MM-DD</span></font></td>
	</tr>


	<tr>
		<td   align="left" rowspan="2"><span class="SpanStyle">Passport Expiry Date</span></td>
	</tr>
	<tr>
		<td  ></td>
		<td  ><input type="text" name="passportExpiryDate" value="<%=passportExpiryDate%>" size="20" tabindex="2" class="EmployeeTextBox" id="passportExpiryDate">
		<img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector" style="border: 1px solid green; cursor: pointer;" id="f_passportExpiryDate_c" src="jscalendar-1.0/img.gif"/> 
		<font size="2"><span style="font-family: Tahoma">YYYY-MM-DD</span></font></td>
	</tr>

	<tr>
		<td   align="left" rowspan="2"><span class="SpanStyle">Visa Type</span></td>
	</tr>
	<tr>
		<td  ></td>
		<td  ><input type="text" name="visaType" value="<%=visaType%>" size="20" tabindex="2" class="EmployeeTextBox" ></td>
	</tr>


	<tr>
		<td   align="left" rowspan="2"><span class="SpanStyle">Visa Issued Date</span></td>
	</tr>
	<tr>
		<td  ></td>
		<td  ><input type="text" name="visaIssuedDate" value="<%=visaIssuedDate%>" size="20" tabindex="2" class="EmployeeTextBox" id="visaIssuedDate">
		<img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector" style="border: 1px solid green; cursor: pointer;" id="f_visaIssuedDate_c" src="jscalendar-1.0/img.gif"/> 
		<font size="2"><span style="font-family: Tahoma">YYYY-MM-DD</span></font></td>
	</tr>

	<tr>
		<td   align="left" rowspan="2"><span class="SpanStyle">Visa Expiry Date</span></td>
	</tr>
	<tr>
		<td  ></td>
		<td  ><input type="text" name="visaExpiryDate" value="<%=visaExpiryDate%>" size="20" tabindex="2" class="EmployeeTextBox" id="visaExpiryDate">
		<img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector" style="border: 1px solid green; cursor: pointer;" id="f_visaExpiryDate_c" src="jscalendar-1.0/img.gif"/> 
		<font size="2"><span style="font-family: Tahoma">YYYY-MM-DD</span></font>
		</td>
	</tr>


	<tr>
		<td  bgcolor="#F4F4F4" colspan="2"></td>
		<td   colspan="1" bgcolor="#F4F4F4">
		<p>
			<font size="1"> 
				<input type="submit" value="Add or Update" name="update" class="ButtonStyle" tabindex="10">
				<input type="submit" value="Cancel " onclick="redirectOnClickCancel()" name="cancel" class="ButtonStyle" tabindex="10">
				<input type="button" value="Attach Files" onclick="attachFiles()" name="attachFilesBtn" class="ButtonStyle" tabindex="11">
			</font>
		</td>
	</tr>
</table>
</form>
</div>
<script type="text/javascript">
    Calendar.setup({
        inputField     :    "visaExpiryDate",
        ifFormat       :    "%Y-%m-%e",
        button         :    "f_visaExpiryDate_c",
        align          :    "Tl",
        singleClick    :    false
    });
    Calendar.setup({
        inputField     :    "visaIssuedDate",
        ifFormat       :    "%Y-%m-%e",
        button         :    "f_visaIssuedDate_c",
        align          :    "Tl",
        singleClick    :    false
    });
    Calendar.setup({
        inputField     :    "passportExpiryDate",
        ifFormat       :    "%Y-%m-%e",
        button         :    "f_passportExpiryDate_c",
        align          :    "Tl",
        singleClick    :    false
    });
    Calendar.setup({
        inputField     :    "passportIssueDate",
        ifFormat       :    "%Y-%m-%e",
        button         :    "f_passportIssueDate_c",
        align          :    "Tl",
        singleClick    :    false
    });
    function redirectOnClickCancel(){
    	document.forms[0].parameter.value="onClickingCancel";
    }
    function attachFiles() {
    	var x = document.forms[0].passportExpiryDate.value; 
    	if (x == null || x == "") {
    		boxC();
    		//alert("Are you Sure, You just want to attach the files with out filling the form?");
        }
    	
    }
    function boxC(){
    	
    	dhtmlx.confirm({title:"Are you Sure?", 
			ok:"Yes", cancel:"No",
			text:"You just want to attach the files with out filling the form?",
			callback: function(result){
				if(result) {
    				document.forms[0].parameter.value="attachImmigrationDocs";
    				document.forms[0].submit();
    			} else { return false;}
			}
	});
    	
    }
  
</script>