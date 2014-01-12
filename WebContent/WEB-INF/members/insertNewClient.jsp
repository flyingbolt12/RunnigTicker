<%@page import="java.util.Map"%>
<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@page import="org.apache.commons.collections.map.ListOrderedMap"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<style>
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
	String errMsg = "";
	try {
		if (request.getAttribute("clientErrMsg") != null) {
			errMsg = (String) request.getAttribute("clientErrMsg");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}

	ListOrderedMap map = null;
%>
<div align="center">
<html:form action="/insertNewClientAction.do" enctype="multipart/form-data" >
		<input type="hidden" name="isInsert" value="true">
		<input type="hidden" name="parameter" value="updateMyClientNext">
		<table border="0" cellspacing="1" width="90%"
			style="font-family: Tahoma; font-size: 10pt" id="table1">
			<%
				if (errMsg != null) {
			%>
			<tr>
				<td bgcolor="#000000" colspan="3">
					<p align="center">
						<font color="#FF0000"><%=errMsg%></font>
					</p>
				</td>

			</tr>
			<%
				}
			%>
			<tr>
				<td bgcolor="#808080" colspan="3">
					<p align="center">
						<font size="2" color="#FFFFFF"><b>Enter new client details</b></font></b>
				</td>
			</tr>
			
			<tr>
				<td align="left" ><span class="SpanStyle">Client
						Working For </span></td>
				<td colspan="2"><select name="clientName" tabindex="2" id="clients"
					class="EmployeeTextBox" onchange="otherClientNameFun(this)">

						<logic:iterate id="myList" name="listOfAvailableClients">
							<option>
								<bean:write name="myList" property="clientName" />
							</option>
						</logic:iterate>
						<option selected="selected">Other</option>
				</select> <span id="otherClientNameEle"> </span></td>
			</tr>
			<tr>
				<td align="left" colspan="3">Client Address</td>
			</tr>
			<tr>
				<td align="left" rowspan="6"></td>
				<td><span class="SpanStyle">Address1<font
						color="#FF0000">*</font></span></td>
				<td><html:messages id="err_name"
						property="listAddress[2].address1">
						<%
							errMsg = err_name;
						%>
					</html:messages><html:text property="listAddress[2].address1" name="employeeRegistrationBean"
						styleClass="EmployeeTextBox" size="20" tabindex="3"></html:text><%=errMsg%><%errMsg = "";%></td>
			</tr>
			<tr>
				<td align="left"><span class="SpanStyle">Address2</span></td>
				<td align="left"><html:text property="listAddress[2].address2"
						name="employeeRegistrationBean" styleClass="EmployeeTextBox"
						size="20" tabindex="4"></html:text></td>
			</tr>
			<tr>
				<td><span class="SpanStyle">City<font color="#FF0000">*</font></span></td>
				<td><html:messages id="err_name"
						property="listAddress[2].city">
						<%
							errMsg = err_name;
						%>
					</html:messages><html:text property="listAddress[2].city"
						styleClass="EmployeeTextBox" size="20" tabindex="5"></html:text><%=errMsg%><%errMsg = "";%></td>
			</tr>
			<tr>
				<td><span class="SpanStyle">State<font color="#FF0000">*</font></span></td>
				<td><html:messages
						id="err_name" property="listAddress[2].state">
						<%
							errMsg = err_name;
						%>
					</html:messages><html:text property="listAddress[2].state"
						styleClass="EmployeeTextBox" size="20" tabindex="6"></html:text><%=errMsg%><%errMsg = "";%></td>
			</tr>
			<tr>
				<td><span class="SpanStyle">Country<font
						color="#FF0000">*</font></span></td>
				<td><html:messages id="err_name"
						property="listAddress[2].country">
						<%
							errMsg = err_name;
						%>
					</html:messages><html:text property="listAddress[2].country"
						styleClass="EmployeeTextBox" size="20" tabindex="7"></html:text><%=errMsg%><%errMsg = "";%></td>
			</tr>
			<tr>
				<td><span class="SpanStyle">Zip<font color="#FF0000">*</font></span></td>
				<td><html:messages
						id="err_name" property="listAddress[2].zip">
						<%
							errMsg = err_name;
						%>
					</html:messages><html:text property="listAddress[2].zip"
						styleClass="EmployeeTextBox" size="20" tabindex="8"></html:text><%=errMsg%><%errMsg = "";%></td>
			</tr>



			<tr>
				<td align="left" colspan="2"><span class="SpanStyle">Work
						Start Date<font color="#FF0000">*</font>
				</span></td>
				<td><html:text property="startDate"
						styleClass="EmployeeTextBox" size="20" tabindex="9"
						styleId="startDate"></html:text> <html:messages id="err_name"
						property="startDate">
						<% errMsg = err_name; %>
					</html:messages> <img onmouseout="this.style.background=''"
					onmouseover="this.style.background='pink';" title="Date selector"
					style="border: 1px solid green; cursor: pointer;" id="f_trigger_c"
					src="jscalendar-1.0/img.gif" /> <font size="2"> <span
						style="font-family: Tahoma">MM/DD/YYYY</span></font><%=errMsg%></td>
			</tr>

			<tr>
				<td colspan="2"></td>
				<td colspan="1">
						<input type="submit" value="Insert" id="insertBtn" onclick="return validateCientName()"
							name="update" class="ButtonStyle" tabindex="10">
							<input type="Button" value="Cancel"
							onclick="redirectOnClickCancel()" name="cancle"
							class="ButtonStyle" tabindex="11">
				</td>
			</tr>
		</table>
	</html:form>
</div>
<script type="text/javascript">
	Calendar.setup({
		inputField : "startDate",
		ifFormat : "%m/%e/%Y",
		button : "f_trigger_c",
		align : "Tl",
		singleClick : false
	});
	
  
	if (document.getElementsByTagName) {
	    var table = document.getElementById("table1");
	    var rows = table.getElementsByTagName("tr");
	    for (var i = 0; i < rows.length; i++) {
		    if (i % 2 == 0) {
			    rows[i].className = "even";
		    } else {
			    rows[i].className = "odd";
		    }
	    }
    }

	
  
	function otherClientNameFun(obj) {
		
	
		
	  var optsLength = obj.options.length;
	  for(var i=0;i<optsLength;i++){
	    if(obj.options[i].selected) {
	    	if(obj.options[i].text == 'Other')
	    		{
	    		manageTextBoxes(false);
	    		document.getElementById("otherClientNameEle").innerHTML = 'Enter Client Name :  <html:text name="employeeRegistrationBean" property="otherClientName" styleId="otherClientName" styleClass="EmployeeTextBox" size="20" tabindex="1"></html:text>';
	    		document.getElementById("insertBtn").disabled=false;
	    		document.getElementById("insertBtn").className="ButtonStyle";
	    		}
	    	}
	    else
	    	{
	    		document.getElementById("insertBtn").className="ButtonStyleDisabled";
	    		document.getElementById("insertBtn").disabled=true;
	    		manageTextBoxes(true);
	    		document.getElementById("otherClientNameEle").innerHTML = '';		
	    	}
	  }
		
	}
	
	function validateCientName()
	{
		if(document.getElementById("otherClientName").value!=null && document.getElementById("otherClientName").value.trim().length > 0)
			return true;
		dhtmlx.message({type:"error", expire:6000, text:"Enter proper client name" });
		
		return false;
	}
	function manageTextBoxes(isToDisable){
	var boxes = table.getElementsByTagName("input");
		for (var i = 0; i < boxes.length; i++) {
			var box = boxes[i];
			if (box.type == "text") {
				box.disabled = isToDisable;
			}
		}
	}
	
	otherClientNameFun(document.getElementById("clients"));
	
</script>

	