<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

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

<div align="center">
	<%
		boolean isRreadOnly = true;
		String errMsg = "";
	%>
	<html:form action="/confirmMemberRegistration.do?parameter=confirmRegistration" enctype="multipart/form-data" onsubmit="return checkPwdAndCnfrmPwd()">

		<input type="hidden" name="parameter" value="">
		<table border="0" width="100%" cellspacing="1" style="font-family: Tahoma; font-size: 10pt" class="registration" id="validPending">
			<tr>
				<td class="regHeader" colspan="3"><b>Employee Registration - Confirmation Details - Screen 3/3</b></td>
			</tr>
			<tr>
				<td height="4" colspan="3" bgcolor="#FFFFFF"></td>
			</tr>
			<tr>
				<td align="left" colspan="3" bgcolor="#CDCCCD"><span class="spanStyle">User Details</span></td>

			</tr>
			<tr>
				<td rowspan="11" bgcolor="white"></td>
				<td><span class="spanStyle"> First Name<font color="#FF0000">*</font></span></td>
				<td><html:messages id="err_name" property="firstName">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="firstName" styleClass="EmployeeTextBox" size="20" tabindex="4" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="firstName" styleClass="EmployeeTextBox" size="20" tabindex="4"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Middle Name</span></td>
				<td bgcolor=#F4F4F4><html:messages id="err_name" property="middleName">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="middleName" styleClass="EmployeeTextBox" size="20" tabindex="5" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="middleName" styleClass="EmployeeTextBox" size="20" tabindex="5"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Last Name<font color="#FF0000">*</font></span></td>
				<td><html:messages id="err_name" property="lastName">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="lastName" styleClass="EmployeeTextBox" size="20" tabindex="6" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="lastName" styleClass="EmployeeTextBox" size="20" tabindex="6"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td height="24">Gender</td>
				<td height="24"><html:select property="gendar" styleClass="EmployeeTextBox" size="1" tabindex="7">
						<html:option value="MALE"></html:option>
						<html:option value="FEMALE"></html:option>
					</html:select></td>
			</tr>

			<tr>
				<td><span class="spanStyle">Email-Id<font color="#FF0000">*</font></span></td>
				<td><html:messages id="err_name" property="contactEmail">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="contactEmail" styleClass="EmployeeTextBox" size="20" tabindex="9" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="contactEmail" styleClass="EmployeeTextBox" size="20" tabindex="9"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>

			<tr>
				<td><span class="spanStyle">Phone Number<font color="#FF0000">*</font></span></td>
				<td><html:messages id="err_name" property="phoneNumber">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="phoneNumber" styleClass="EmployeeTextBox" size="20" tabindex="10" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="phoneNumber" styleClass="EmployeeTextBox" size="20" tabindex="10"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Father Name</span></td>
				<td><html:messages id="err_name" property="fatherName">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="fatherName" styleClass="EmployeeTextBox" size="20" tabindex="11" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="fatherName" styleClass="EmployeeTextBox" size="20" tabindex="11"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Country Citizenship</span></td>
				<td><html:messages id="err_name" property="countryCitizenship">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="countryCitizenship" styleClass="EmployeeTextBox" size="20" tabindex="13" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="countryCitizenship" styleClass="EmployeeTextBox" size="20" tabindex="13"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Submit TimeSheets</span></td>
				<td><html:messages id="err_name" property="timeSheetConfiguredTo">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="timeSheetConfiguredTo" styleClass="EmployeeTextBox" size="20" tabindex="13" readonly="true" disabled="true"></html:text> <%
 	} else {
 %> <html:text property="timeSheetConfiguredTo" styleClass="EmployeeTextBox" size="20" tabindex="13" disabled="true"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>

			<tr>
				<td><span class="spanStyle">Date of Birth<font color="#FF0000">*</font></span></td>
				<td><html:messages id="err_name" property="dob">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="dob" styleClass="EmployeeTextBox" size="20" tabindex="14" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="dob" styleClass="EmployeeTextBox" size="20" tabindex="14" styleId="dob"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %> <img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector" style="border: 1px solid green; cursor: pointer;" id="f_trigger_c" src="jscalendar-1.0/img.gif" /> <font size="2"><span
						style="font-family: Tahoma">MM/DD/YYYY</span></font></td>
			</tr>

			<tr>
				<td><span class="spanStyle">Profile Path</span></td>
				<td><bean:write name="employeeRegistrationBean" property="profilePath"></bean:write></td>
			</tr>
			<tr>
				<td colspan="3" align="left" bgcolor="#CDCCCD"><span class="spanStyle">Employee Current Address<font color="#FF0000">*</font></span></td>
			</tr>

			<tr>
				<td rowspan="6" bgcolor="white"></td>
				<td align="left"><span class="spanStyle">Address 1:</span></td>
				<td align="left"><html:messages id="err_name" property="listAddress[0].address1">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[0].address1" styleClass="EmployeeTextBox" size="45" tabindex="17" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[0].address1" styleClass="EmployeeTextBox" size="45" tabindex="17"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>

			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Address 2:</span></td>
				<td width="480" align="left"><html:messages id="err_name" property="listAddress[0].address2">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[0].address2" styleClass="EmployeeTextBox" size="45" tabindex="18" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[0].address2" styleClass="EmployeeTextBox" size="45" tabindex="18"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">City</span></td>
				<td><html:messages id="err_name" property="listAddress[0].city">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[0].city" styleClass="EmployeeTextBox" size="20" tabindex="19" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[0].city" styleClass="EmployeeTextBox" size="20" tabindex="19"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">State</span></td>
				<td><font face="Tahoma"> <html:messages id="err_name" property="listAddress[0].state">
							<%
								errMsg = err_name;
										isRreadOnly = false;
							%>
						</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[0].state" styleClass="EmployeeTextBox" size="20" tabindex="20" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[0].state" styleClass="EmployeeTextBox" size="20" tabindex="20"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %>
				</font></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Country</span></td>
				<td><html:messages id="err_name" property="listAddress[0].country">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[0].country" styleClass="EmployeeTextBox" size="20" tabindex="21" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[0].country" styleClass="EmployeeTextBox" size="20" tabindex="21"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Zip</span></td>
				<td><font face="Tahoma"> <html:messages id="err_name" property="listAddress[0].zip">
							<%
								errMsg = err_name;
										isRreadOnly = false;
							%>
						</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[0].zip" styleClass="EmployeeTextBox" size="20" tabindex="22" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[0].zip" styleClass="EmployeeTextBox" size="20" tabindex="22"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %>
				</font></td>
			</tr>

			<tr>
				<td colspan="3" align="left" bgcolor="#CDCCCD"><span class="spanStyle">Employee Home Country Address<font color="#FF0000">*</font></span></td>
			</tr>
			<tr>
				<td rowspan="6" bgcolor="white"></td>
				<td align="left"><span class="spanStyle">Address 1:</span></td>
				<td align="left"><html:messages id="err_name" property="listAddress[1].address1">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[1].address1" styleClass="EmployeeTextBox" size="45" tabindex="23" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[1].address1" styleClass="EmployeeTextBox" size="45" tabindex="23"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>

			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Address 2:</span></td>
				<td width="480" align="left"><html:messages id="err_name" property="listAddress[1].address2">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[1].address2" styleClass="EmployeeTextBox" size="45" tabindex="24" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[1].address2" styleClass="EmployeeTextBox" size="45" tabindex="24"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">City</span></td>
				<td><html:messages id="err_name" property="listAddress[1].city">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[1].city" styleClass="EmployeeTextBox" size="20" tabindex="25" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[1].city" styleClass="EmployeeTextBox" size="20" tabindex="25"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">State</span></td>
				<td><font face="Tahoma"> <html:messages id="err_name" property="listAddress[1].state">
							<%
								errMsg = err_name;
										isRreadOnly = false;
							%>
						</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[1].state" styleClass="EmployeeTextBox" size="20" tabindex="26" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[1].state" styleClass="EmployeeTextBox" size="20" tabindex="26"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %>
				</font></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Country</span></td>
				<td><html:messages id="err_name" property="listAddress[1].country">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[1].country" styleClass="EmployeeTextBox" size="20" tabindex="27" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[1].country" styleClass="EmployeeTextBox" size="20" tabindex="27"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Zip</span></td>
				<td><font face="Tahoma"> <html:messages id="err_name" property="listAddress[1].zip">
							<%
								errMsg = err_name;
										isRreadOnly = false;
							%>
						</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[1].zip" styleClass="EmployeeTextBox" size="20" tabindex="28" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[1].zip" styleClass="EmployeeTextBox" size="20" tabindex="28"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %>
				</font></td>
			</tr>

			<tr>
				<td bgcolor="#CDCCCD" align="left" colspan="3">Employer Details<font color="#FF0000">*</font>
				</td>

			</tr>
			<tr>
				<td bgcolor="white"></td>
				<td><span class="spanStyle">Employer Code</span></td>
				<td><html:messages id="err_name" property="businessId">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="businessId" styleClass="EmployeeTextBox" size="20" tabindex="29" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="businessId" styleClass="EmployeeTextBox" size="20" tabindex="29"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td bgcolor="#CDCCCD" align="left" colspan="3">Client Details<font color="#FF0000">*</font>
				</td>
			</tr>

			<tr>
				<td bgcolor="white"></td>
				<td><span class="spanStyle">Client Working For</span></td>
				<td><html:messages id="err_name" property="clientName">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="clientName" styleClass="EmployeeTextBox" size="20" tabindex="30" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="clientName" styleClass="EmployeeTextBox" size="20" tabindex="30"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td align="left" colspan="3" bgcolor="#CDCCCD">Client Address<font color="#FF0000">*</font>
				</td>
			</tr>
			<tr>
				<td rowspan="7" bgcolor="white"></td>
				<td><span class="spanStyle">Address1</span></td>
				<td><html:messages id="err_name" property="listAddress[2].address1">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[2].address1" styleClass="EmployeeTextBox" size="20" tabindex="31" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[2].address1" styleClass="EmployeeTextBox" size="20" tabindex="31"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Address2</span></td>
				<td align="left"><html:messages id="err_name" property="listAddress[2].address2">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[2].address2" styleClass="EmployeeTextBox" size="20" tabindex="32" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[2].address2" styleClass="EmployeeTextBox" size="20" tabindex="32"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">City</span></td>
				<td><html:messages id="err_name" property="listAddress[2].city">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[2].city" styleClass="EmployeeTextBox" size="20" tabindex="33" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[2].city" styleClass="EmployeeTextBox" size="20" tabindex="33"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>

			<tr>
				<td><span class="spanStyle">State</span></td>
				<td><html:messages id="err_name" property="listAddress[2].state">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[2].state" styleClass="EmployeeTextBox" size="20" tabindex="34" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[2].state" styleClass="EmployeeTextBox" size="20" tabindex="34"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Country</span></td>
				<td><html:messages id="err_name" property="listAddress[2].country">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[2].country" styleClass="EmployeeTextBox" size="20" tabindex="35" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[2].country" styleClass="EmployeeTextBox" size="20" tabindex="35"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Zip</span></td>
				<td><html:messages id="err_name" property="listAddress[2].zip">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="listAddress[2].zip" styleClass="EmployeeTextBox" size="20" tabindex="36" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="listAddress[2].zip" styleClass="EmployeeTextBox" size="20" tabindex="36"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Work Start Date</span></td>
				<td><html:messages id="err_name" property="startDate">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="startDate" styleClass="EmployeeTextBox" size="20" tabindex="37" readonly="true"></html:text> &nbsp; <%
 	} else {
 %> <html:text property="startDate" styleClass="EmployeeTextBox" size="20" tabindex="37" styleId="startDate"></html:text> &nbsp; <%=errMsg%> <%
 	errMsg = "";isRreadOnly = true;	}
 %><img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector" style="border: 1px solid green; cursor: pointer;" id="f_trigger_c1" src="jscalendar-1.0/img.gif" /> <font size="2"><span
						style="font-family: Tahoma">MM/DD/YYYY</span></font></td>
			</tr>

			<tr>
				<td align="left" bgcolor="#CDCCCD" colspan="3">Login Credentials<font color="#FF0000">*</font>
				</td>
			</tr>

			<tr>
				<td rowspan="4" bgcolor="white"></td>
				<td><span class="spanStyle">User Id</span></td>
				<td><html:messages id="err_name" property="login">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:text property="login" styleClass="EmployeeTextBox" size="20" tabindex="43" readonly="true"></html:text> <%
 	} else {
 %> <html:text property="login" styleClass="EmployeeTextBox" size="20" tabindex="43"></html:text> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %> <span id="ajaxTestMessage"></span></td>

			</tr>
			<tr>
				<td>Password</td>
				<td><html:messages id="err_name" property="password">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:password property="password" styleClass="EmployeeTextBox" size="20" tabindex="44" readonly="true"></html:password> <%
 	} else {
 %> <html:password property="password" styleClass="EmployeeTextBox" size="20" tabindex="44"></html:password><span id="pwdErr"></span> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Confirm Password</span></td>
				<td><html:messages id="err_name" property="confirmPassword">
						<%
							errMsg = err_name;
									isRreadOnly = false;
						%>
					</html:messages> <%
 	if (isRreadOnly) {
 %> <html:password property="confirmPassword" styleClass="EmployeeTextBox" size="20" tabindex="45" readonly="true"></html:password> <%
 	} else {
 %> <html:password property="confirmPassword" styleClass="EmployeeTextBox" size="20" tabindex="45"></html:password><span id="cnfrmPwdErr"></span> <%=errMsg%> <%
 	errMsg = "";
 			isRreadOnly = true;
 		}
 %></td>
			</tr>
			<tr>
				<td align="left"></td>
				<td align="left"><font face="Tahoma"> <html:checkbox property="termsConditions" value="true" tabindex="46" disabled="true"></html:checkbox>
				</font> <a href="#" onclick="openTermAndConditions()">I Agree the terms &amp; conditions</a></td>

			</tr>
			<tr>
				<td width="90px"></td>
				<td height="3" width="245" colspan="2"></td>
			</tr>
			<tr>
				<td colspan="3" class="regHeader"><html:submit value="Finish" property="confirm" styleClass="ButtonStyle" tabindex="47"></html:submit> <html:submit value="Cancel" property="cancel" onclick="empRegCanclation()" styleClass="ButtonStyle"
						tabindex="48"></html:submit></td>
			</tr>
		</table>
	</html:form>
</div>

<script>
    function empRegCanclation() {
	    document.forms[0].action = "employeeRegistration.do";
	    document.forms[0].parameter.value = "empRegCanclation";
	    document.forms[0].submit();
    }

    function openTermAndConditions() {
	    var reg = window.open("http://centermanager.allibilli.com/showUserRegistrationForm.allibilli", "popup", 'width=1500,height=1500');
	    reg.document.write("Conditions of Use");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document
	            .writeln("Welcome to our Service! AlliBilli and its associates provide their services to you subject to the following conditions.If you visit or shop within this website, you accept these conditions. Please read them carefully");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document.writeln("PRIVACY");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document.writeln("Please review our Privacy Notice, which also governs your visit to our website, to understand our practices.");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document.writeln("ELECTRONIC COMMUNICATIONS");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document
	            .write("When you visit AlliBilli or send e-mails to us, you are communicating with us electronically. You consent to receive communications from us electronically. We will communicate with you by e-mail or by posting notices on this site. You agree that all agreements, notices, disclosures and other communications that we provide to you electronically satisfy any legal requirement that such communications be in writing");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document.writeln("COPYRIGHT");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document
	            .write("All content included on this site, such as text, graphics, logos, button icons, images, audio clips, digital downloads, data compilations, and software, is the property of AlliBilli or its content suppliers and protected by international copyright laws. The compilation of all content on this site is the exclusive property of AlliBilli, with copyright authorship for this collection by AlliBilli, and protected by international copyright laws. There are few images that are copied and used from the web which are freeware by the time we used. If you have any issues please contact us and we will be removing those immediately");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document.writeln("TRADE MARKS");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document
	            .write("AlliBillis trademarks and trade dress may not be used in connection with any product or service that is not AlliBillis, in any manner that is likely to cause confusion among customers, or in any manner that disparages or discredits AlliBilli. All other trademarks not owned by AlliBilli or its subsidiaries that appear on this site are the property of their respective owners, who may or may not be affiliated with, connected to, or sponsored by AlliBilli or its subsidiaries");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document.write("LICENSE AND SITE ACCESS");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document
	            .write("AlliBilli grants you a limited license to access and make personal use of this site and not to download ,(other than page caching, your inventory, your students) or modify it, or any portion of it, except with express written consent of AlliBilli. This license does not include any resale or commercial use of this site or its contents: any collection and use of any product listings, descriptions, or prices: any derivative use of this site or its contents: any downloading or copying of account information for the benefit of another merchant: or any use of data mining, robots, or similar data gathering and extraction tools. This site or any portion of this site may not be reproduced, duplicated, copied, sold, resold, visited, or otherwise exploited for any commercial purpose without express written consent of AlliBilli. You may not frame or utilize framing techniques to enclose any trademark, logo, or other proprietary information (including images, text, page layout, or form) of AlliBilli and our associates without express written consent. You may not use any meta tags or any other hidden text utilizing AlliBillis name or trademarks without the express written consent of AlliBilli. Any unauthorized use terminates the permission or license granted by AlliBilli. You are granted a limited, revocable, and nonexclusive right to create a hyperlink to the home page of AlliBilli so long as the link does not portray AlliBilli, its associates, or their products or services in a false, misleading, derogatory, or otherwise offensive matter. You may not use any AlliBilli logo or other proprietary graphic or trademark as part of the link without express written permission. AlliBilli provide its source code from sourceforge.net. This is an open source product.");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document.write("YOUR MEMBERSHIP ACCOUNT");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document
	            .write("If you use this site, you are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer, and you agree to accept responsibility for all activities that occur under your account or password. If you are under 18, you may use our website only with involvement of a parent or guardian. AlliBilli and its associates reserve the right to refuse service, terminate accounts, remove or edit content, or cancel orders in their sole discretion.");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document.write("REVIEWS ,COMMENTS ,EMAILS,  AND OTHER CONTENT");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document
	            .write("Visitors may post reviews, comments, and other content, and submit suggestions, ideas, comments, questions, or other information, so long as the content is not illegal, obscene, threatening, defamatory, invasive of privacy, infringing of intellectual property rights, or otherwise injurious to third parties or objectionable and does not consist of or contain software viruses, political campaigning, commercial solicitation, chain letters, mass mailings, or any form of spam.You may not use a false e-mail address, impersonate any person or entity, or otherwise mislead as to the origin of a card or other content. AlliBilli reserves the right (but not the obligation) to remove or edit such content, but does not regularly review posted content. If you do post content or submit material, and unless we indicate otherwise, you grant AlliBilli and its associates a nonexclusive, royalty-free, perpetual, irrevocable, and fully sublicensable right to use, reproduce, modify, adapt, publish, translate, create derivative works from, distribute, and display such content throughout the world in any media. You grant AlliBilli and its associates and sublicensees the right to use the name that you submit in connection with such content, if they choose. You represent and warrant that you own or otherwise control all of the rights to the content that you post: that the content is accurate: that use of the content you supply does not violate this policy and will not cause injury to any person or entity: and that you will indemnify AlliBilli or its associates for all claims resulting from content you supply. AlliBilli has the right but not the obligation to monitor and edit or remove any activity or content. AlliBilli takes no responsibility and assumes no liability for any content posted by you or any third party.");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document.write("RISK OF LOSS");
	    reg.document.write("</br>");
	    reg.document.write("</br>");
	    reg.document.write("AlliBilli is not responsible for any kind of loss for all the products.");
	    
    }
</script>

<script type="text/javascript">
	Calendar.setup({
    inputField : "dob",
    ifFormat : "%m/%e/%Y",
    button : "f_trigger_c",
    align : "Tl",
    singleClick : false
    });
	
	Calendar.setup({
	    inputField : "startDate",
	    ifFormat : "%m/%e/%Y",
	    button : "f_trigger_c1",
	    align : "Tl",
	    singleClick : false
	    });
</script>

<script>
	if (document.getElementsByTagName) {
	    var table = document.getElementById("validPending");
	    var rows = table.getElementsByTagName("tr");
	    for (i = 0; i < rows.length; i++) {
		    if (i % 2 == 0) {
			    rows[i].className = "even";
		    } else {
			    rows[i].className = "odd";
		    }
	    }
    }

    </script>