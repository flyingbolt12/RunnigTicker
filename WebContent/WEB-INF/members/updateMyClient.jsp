<%@page import="java.util.Map"%>
<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@page import="java.util.List"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="org.apache.commons.collections.map.ListOrderedMap"%><style>
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

<%
	String clientAddressId = "";
	String client_address1 = "";
	String client_address2 = "";
	String client_city = "";
	String client_state = "";
	String client_country = "";
	String client_zipcode = "";
	String client_working_for = "";
	String work_startDate = "";
	long  businessId = 0;
	long userId = 0;

	UserProfile userProfile = (UserProfile) session
			.getAttribute("userProfile");
	businessId = userProfile.getBusinessId();
	userId = userProfile.getUserId();

	List editMyClientDetailsList = (List) session
			.getAttribute("editMyClientDetailsList");
	Map map = null;
	if (editMyClientDetailsList != null) {
		map = (Map) editMyClientDetailsList.get(0);
		System.out.print(map);
	}
	if (map != null) {
		client_working_for = ((String) map.get("clientName") == null) ? ("")
				: ((String) map.get("clientName"));
		clientAddressId = ((Long) map.get("idAddressInfo") == null) ? ("")
				: ((Long) map.get("idAddressInfo") + "");
		client_address1 = ((String) map.get("address1") == null) ? ("")
				: ((String) map.get("address1"));
		client_address2 = ((String) map.get("address2") == null) ? ("")
				: ((String) map.get("address2"));
		client_city = ((String) map.get("city") == null) ? ("")
				: ((String) map.get("city"));
		client_state = ((String) map.get("state") == null) ? ("")
				: ((String) map.get("state"));
		client_country = ((String) map.get("country") == null) ? ("")
				: ((String) map.get("country"));
		client_zipcode = ((String) map.get("zipcode") == null) ? ("")
				: ((String) map.get("zipcode"));
		work_startDate = ((String) map.get("startDate") == null) ? ("")
				: ((String) map.get("startDate"));

	}
%>
<div align="center">

<form action="memberFunctImpl.do">
<input type="hidden" name="businessId" value="<%=businessId%>">
<input type="hidden" name="userId" value="<%=userId%>">
<input type="hidden" name="clientAddressId" value="<%=clientAddressId%>" />
<input type="hidden" name="parameter" value="updateMyClientNext">
<table border="0" cellspacing="1" width="617" height="180"
	style="font-family: Tahoma; font-size: 10pt" id="table1">

	<tr>
		<td height="18" width="613" bgcolor="#808080" colspan="3">
		<p align="center"><font size="2" color="#FFFFFF"><b>Update
		Client</b></font></b>
		</td>
	</tr>
	<tr>
		<td height="21" width="118" align="left" rowspan="2"><span
			class="SpanStyle">Client Working For </span></td>
	</tr>
	<tr>
		<td height="18" width="153"></td>
		<td height="18" width="336"><input type="text" name="clientName"
			value="<%=client_working_for%>" size="20" tabindex="2"
			class="EmployeeTextBox" disabled="disabled"></td>
	</tr>
	<tr>
		<td height="16" width="610" align="left" bgcolor="#F4F4F4" colspan="3">
		Client Address</td>
	</tr>
	<tr>
		<td height="135" width="118" align="left" rowspan="6"></td>
		<td height="18" width="153"><span class="SpanStyle">Address1</span>
		</td>
		<td height="18" width="336">
		<input type="text" name="listAddress[2].address1" value="<%=client_address1%>" size="20"
			tabindex="3" class="EmployeeTextBox"></td>
	</tr>
	<tr>
		<td height="18" width="153" bgcolor="#F4F4F4" align="left"><span
			class="SpanStyle">Address2</span></td>
		<td height="18" width="336" bgcolor="#F4F4F4" align="left"><input
			type="text" name="listAddress[2].address2"
			value="<%=client_address2%>" size="20" tabindex="4"
			class="EmployeeTextBox"></td>
	</tr>
	<tr>
		<td height="18" width="153"><span class="SpanStyle">City</span></td>
		<td height="18" width="336"><input type="text"
			name="listAddress[2].city" value="<%=client_city%>" size="20"
			tabindex="5" class="EmployeeTextBox"></td>
	</tr>
	<tr>
		<td height="18" width="153" bgcolor="#F4F4F4"><span
			class="SpanStyle">State</span></td>
		<td height="18" width="336" bgcolor="#F4F4F4"><input type="text"
			name="listAddress[2].state" value="<%=client_state%>" size="20"
			tabindex="6" class="EmployeeTextBox"></td>
	</tr>
	<tr>
		<td height="18" width="153"><span class="SpanStyle">Country</span>
		</td>
		<td height="18" width="336"><input type="text"
			name="listAddress[2].country" value="<%=client_country%>" size="20"
			tabindex="7" class="EmployeeTextBox"></td>
	</tr>
	<tr>
		<td height="18" width="153" bgcolor="#F4F4F4"><span
			class="SpanStyle">Zip</span></td>
		<td height="18" width="336" bgcolor="#F4F4F4"><input type="text"
			name="listAddress[2].zip" value="<%=client_zipcode%>" size="20"
			tabindex="8" class="EmployeeTextBox"></td>
	</tr>
	<tr>
		<td height="20" width="271" align="left" colspan="2"><span
			class="SpanStyle">Work Start Date</span></td>
		<td height="18" width="336"><input type="text" name="startDate"
			value="<%=work_startDate%>" size="20" tabindex="9"
			class="EmployeeTextBox" style="float: left" id="workStartDate">
			<img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector" style="border: 1px solid green; cursor: pointer;" id="f_trigger_c" src="jscalendar-1.0/img.gif"/> 
		<font size="2"><span style="font-family: Tahoma">MM/DD/YYYY</span></font></td>
	</tr>
	<tr>
		<td height="18" width="274" bgcolor="#F4F4F4" colspan="2"></td>
		<td height="18" width="336" colspan="1" bgcolor="#F4F4F4">
		<p><font size="1"> <input type="submit" value="Update"
			name="update" class="ButtonStyle" tabindex="10"></font> <font
			size="1"> <input type="submit" value="Cancel "  onclick="redirectOnClickCancel()" name="cancel"
			class="ButtonStyle" tabindex="10"></font>
		</td>
	</tr>
</table>
</form>
</div>
<script type="text/javascript">
    Calendar.setup({
        inputField     :    "workStartDate",
        ifFormat       :    "%m/%e/%Y",
        button         :    "f_trigger_c",
        align          :    "Tl",
        singleClick    :    false
    });
    
    function redirectOnClickCancel(){
    	
    	document.forms[0].parameter.value="onClickingCancel";
    	
    }
    
</script>