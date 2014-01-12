<%@page import="java.util.Map"%>
<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@page import="org.apache.commons.collections.map.ListOrderedMap"%>
<%@page import="java.util.List"%>
<%@page import="com.lch.spring.BusinessComponents.DoTransaction"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
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
<script>
	function otherClientNameFun() {
		document.getElementById("otherClientName").innerHTML = 'Enter Client Name :  <input type="text" name="otherClientName" value="" size="20" tabindex="3"  class="EmployeeTextBox">';
	}
	function removeOtherClientNameFun() {
		document.getElementById("otherClientName").innerHTML = '';
	}
</script>
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
	
	com.lch.general.generalBeans.UserProfile userProfile = (com.lch.general.generalBeans.UserProfile)session.getAttribute("userProfile");
	GenericXmlApplicationContext ctx = (GenericXmlApplicationContext)getServletContext().getAttribute("ctx");
	DoTransaction doTransaction = (DoTransaction)ctx.getBean("doTransaction");
	List listOfAvailableClients = doTransaction.getListOfAvailableClients(userProfile);
	request.setAttribute("listOfAvailableClients", listOfAvailableClients);
	
%>
<div align="center">
	<html:form action="/insertNewClientAction.do"
		enctype="multipart/form-data">
		<input type="hidden" name="parameter" value="updateMyClientNext">
		<input type="hidden" name="isInsert" value="true">
		<table border="0" cellspacing="1" width="90%" height="180"
			style="font-family: Tahoma; font-size: 10pt" id="table1">
			<%
				if (errMsg != null && errMsg != "") {
			%>
			<tr>
				<td height="18" width="613" bgcolor="#000000" colspan="3">
					<p align="center">
						<font color="#FF0000"><%=errMsg%></font>
					</p>
				</td>

			</tr>
			<%
				}
			%>
			<tr>
				<td height="18" width="613" bgcolor="#808080" colspan="3">
					<p align="center">
						<font size="2" color="#FFFFFF"><b>Update my Current
								Client</b></font></b>
				</td>
			</tr>
			<tr>
				<td height="21" width="118" align="left" rowspan="2"><span
					class="SpanStyle">Client Working For </span></td>
			</tr>
			<tr>
				<td height="18" width="153"></td>
				<td height="18" width="336"><select name="clientName"
					tabindex="2" class="EmployeeTextBox">
												<logic:iterate id="myList" name="listOfAvailableClients">
													<option onclick="removeOtherClientNameFun()">
														<bean:write name="myList" property="clientName" />
													</option>
												</logic:iterate>
						<option onclick="otherClientNameFun()">Other</option>
				</select> <span id="otherClientName"> </span></td>
			</tr>
			<tr>
				<td height="16" width="610" align="left" bgcolor="#F4F4F4"
					colspan="3">Client Address</td>
			</tr>
			<tr>
				<td height="135" width="118" align="left" rowspan="6"></td>
				<td height="18" width="153"><span class="SpanStyle">Address1<font
						color="#FF0000">*</font></span></td>

				<td height="18" width="336"><html:messages id="err_name"
						property="listAddress[2].address1">
						<%
							errMsg = err_name;
						%>
					</html:messages> <html:text property="listAddress[2].address1"
						styleClass="EmployeeTextBox" size="20" tabindex="3"></html:text> <%=errMsg%><%errMsg = "";%>
				</td>
			</tr>
			<tr>
				<td height="18" width="153" bgcolor="#F4F4F4" align="left"><span
					class="SpanStyle">Address2</span></td>
				<td height="18" width="336" bgcolor="#F4F4F4" align="left"><html:text
						property="listAddress[2].address2" name="employeeRegistrationBean"
						styleClass="EmployeeTextBox" size="20" tabindex="4"></html:text></td>
			</tr>
			<tr>
				<td height="18" width="153"><html:messages id="err_name"
						property="listAddress[2].city">
						<%
							errMsg = err_name;
						%>
					</html:messages> <span class="SpanStyle">City<font color="#FF0000">*</font></span></td>
				<td height="18" width="336"><html:text
						property="listAddress[2].city" styleClass="EmployeeTextBox"
						size="20" tabindex="5"></html:text> <%=errMsg%><%errMsg = "";%></td>
			</tr>
			<tr>
				<td height="18" width="153" bgcolor="#F4F4F4"><html:messages
						id="err_name" property="listAddress[2].state">
						<%
							errMsg = err_name;
						%>
					</html:messages> <span class="SpanStyle">State<font color="#FF0000">*</font></span></td>
				<td height="18" width="336" bgcolor="#F4F4F4"><html:text
						property="listAddress[2].state" styleClass="EmployeeTextBox"
						size="20" tabindex="6"></html:text> <%=errMsg%><%errMsg = "";%></td>
			</tr>
			<tr>
				<td height="18" width="153"><html:messages id="err_name"
						property="listAddress[2].country">
						<%
							errMsg = err_name;
						%>
					</html:messages> <span class="SpanStyle">Country<font color="#FF0000">*</font></span></td>
				<td height="18" width="336"><html:text
						property="listAddress[2].country" styleClass="EmployeeTextBox"
						size="20" tabindex="7"></html:text> <%=errMsg%><%errMsg = "";%></td>
			</tr>
			<tr>
				<td height="18" width="153" bgcolor="#F4F4F4"><html:messages
						id="err_name" property="listAddress[2].zip">
						<%
							errMsg = err_name;
						%>
					</html:messages> <span class="SpanStyle">Zip<font color="#FF0000">*</font></span></td>
				<td height="18" width="336" bgcolor="#F4F4F4"><html:text
						property="listAddress[2].zip" styleClass="EmployeeTextBox"
						size="20" tabindex="8"></html:text> <%=errMsg%><%errMsg = "";%></td>
			</tr>

			<tr>
				<td height="20" width="271" align="left" colspan="2"><span class="SpanStyle">Work Start Date<font color="#FF0000">*</font></span> </td>
				<td height="18" width="509"><html:text property="startDate"  styleClass="EmployeeTextBox" size="20" tabindex="9" styleId="startDate"></html:text> 
				<html:messages id="err_name" property="startDate"> <% errMsg = err_name; %></html:messages>  
				<img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector" style="border: 1px solid green; cursor: pointer;" id="f_trigger_c" src="jscalendar-1.0/img.gif" /> 
				<font size="2"> <span style="font-family: Tahoma">MM/DD/YYYY</span></font><%=errMsg%></td>
			</tr>			
			
			<tr>
				<td height="18" width="274" bgcolor="#F4F4F4" colspan="2"></td>
				<td height="18" width="336" colspan="1" bgcolor="#F4F4F4">
					<p>
						<font size="1"> <input type="submit" value="Insert"
							name="update" class="ButtonStyle" tabindex="8"></font> <font
							size="1"> <input type="submit" value="Cancel "
							name="cancle" class="ButtonStyle" tabindex="8"></font>
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
</script>