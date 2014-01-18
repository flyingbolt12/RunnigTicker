<%@page import="com.lch.struts.formBeans.ContactBean"%>
<%@page import="java.util.Map"%>
<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>

<script lang="javascript">
function validateContactUsForm()
{
	
	if (document.forms[0].subject.value != "Choose a Subject") {
			return true;
		} else {
			dhtmlx.message({
				type : "error",
				expire : 6000,
				text : "Choose Subject"
			});
			return false;
		}
}
</script>
<style>
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

</style>
<div align="center">
<%
	String errMsg = "";
%> 
<br>
<br>
24x7 Email Support. Usually we will respond with in 2 hrs.
No Phone Support Needed for this application. 
<br>
<br>

<%
ContactBean bean = ((ContactBean)request.getAttribute("contactBean"));
if (bean== null) {bean = new ContactBean();}		
%>
<html:form onsubmit="return validateContactUsForm()" 
	action="/confirmDetails.do?parameter=contactUs">
	<table border="0" width="767" height="323"
		style="font-family: Tahoma; font-size: 10pt">

		<tr>
			<td height="18" width="745" bgcolor="#808080" colspan="4">

			<p align="center"><font face="Tahoma" size="2" color="#FFFFFF"><b>
			Support & Contact Us</b></font></p>

			</td>
		</tr>
		<tr>
			<td height="21" width="194" bgcolor="#F4F4F4" colspan="4"><font
				color="#FF0000">*</font> <font face="Tahoma" size="2">Denotes
			a required field</font></td>
			
		</tr>
		<tr>
			<td height="17" width="194">
			<div align="right"><font size="2" face="Tahoma">First
			Name <font color="#FF0000">*</font> : </font></div>
			</td>
			<td height="17" width="558" bgcolor="#FFFFFF" colspan="3"><html:messages
				id="err_name" property="firstName">
				<%
					errMsg = err_name;
				%>
			</html:messages> <html:text property="firstName" styleClass="BusinessTextBox" value="<%= bean.getFirstName()%>"
				maxlength="60" size="25" tabindex="1"></html:text> <%=errMsg%> <%	errMsg = ""; %>

			</td>
		</tr>
		<tr>
			<td height="18" width="194" bgcolor="#F4F4F4">
			<div align="right"><font size="2" face="Tahoma">Last
			Name <font color="#FF0000">*</font> : </font></div>
			</td>
			<td height="18" width="558" bgcolor="#F4F4F4" colspan="3"><html:messages
				id="err_name" property="lastName">
				<%
					errMsg = err_name;
				%>
			</html:messages> <html:text property="lastName" styleClass="BusinessTextBox" value="<%= bean.getLastName()%>"
				maxlength="60" size="25" tabindex="2"></html:text> <%=errMsg%> <% 	errMsg = ""; %>
			</td>
		</tr>
		<tr>
			<td height="21" width="194">
			<div align="right"><font face="Tahoma" size="2">Company
			: </font></div>
			</td>
			<td height="21" width="558" colspan="3">
			<html:messages
				id="err_name" property="company">
				<%
					errMsg = err_name;
				%>
			</html:messages>
			<html:text
				property="company" styleClass="BusinessTextBox" maxlength="60" value="<%= bean.getCompany()%>"
				size="25" tabindex="3"></html:text><%=errMsg%> <% 	errMsg = ""; %></td>
		</tr>
		<tr>
			<td height="21" width="194" bgcolor="#F4F4F4">
			<div align="right"><font face="Tahoma" size="2">Address
			: </font></div>
			</td>
			<td height="21" width="558" bgcolor="#F4F4F4" colspan="3"><html:messages
				id="err_name" property="address">
				<%
					errMsg = err_name;
				%>
			</html:messages><html:text
				property="address" styleClass="BusinessTextBox" maxlength="60" value="<%= bean.getAddress()%>"
				size="25" tabindex="4"></html:text><%=errMsg%> <% 	errMsg = ""; %></td>
		</tr>
		<tr>
			<td height="21" width="194">
			<div align="right"><font size="2" face="Tahoma">City: </font></div>
			</td>
			<td height="21" width="558" colspan="3"><html:messages
				id="err_name" property="city">
				<%
					errMsg = err_name;
				%>
			</html:messages><html:text
				property="city" styleClass="BusinessTextBox" maxlength="60" value="<%= bean.getCity()%>"
				size="25" tabindex="5"></html:text><%=errMsg%> <% 	errMsg = ""; %></td>
		</tr>
		<tr>
			<td height="21" width="194" bgcolor="#F4F4F4">
			<div align="right"><font size="2" face="Tahoma">State/Province
			: </font></div>
			</td>
			<td height="21" width="211" bgcolor="#F4F4F4"><html:messages
				id="err_name" property="state">
				<%
					errMsg = err_name;
				%>
			</html:messages><html:text
				property="state" styleClass="BusinessTextBox" maxlength="60" value="<%= bean.getState()%>"
				size="25" tabindex="6"></html:text><%=errMsg%> <% 	errMsg = ""; %></td>
			<td height="21" width="89" bgcolor="#F4F4F4">
			<p align="right"><font size="2" face="Tahoma"> Zip/Postal
			:</font>
			</td>
			<td height="21" width="255" bgcolor="#F4F4F4"><html:messages
				id="err_name" property="zip">
				<%
					errMsg = err_name;
				%>
			</html:messages><html:text value="<%= bean.getZip()%>"
				property="zip" styleClass="BusinessTextBox" maxlength="60" size="25"
				tabindex="7"></html:text><%=errMsg%> <% 	errMsg = ""; %></td>
		</tr>
		<tr>
			<td height="21" width="194">
			<div align="right"><font size="2" face="Tahoma">Phone :</font></div>
			</td>
			<td height="21" width="558" colspan="3"><html:messages
				id="err_name" property="phone">
				<%
					errMsg = err_name;
				%>
			</html:messages><html:text value="<%= bean.getPhone()%>"
				property="phone" styleClass="BusinessTextBox" maxlength="60"
				size="25" tabindex="8"></html:text><%=errMsg%> <% 	errMsg = ""; %></td>
		</tr>
		<tr>
			<td height="18" width="194" bgcolor="#F4F4F4">
			<div align="right"><font face="Tahoma" size="2">Email <font
				color="#FF0000">*</font>: </font></div>
			</td>
			<td height="18" width="558" bgcolor="#F4F4F4" colspan="3"><html:messages
				id="err_name" property="email">
				<%
					errMsg = err_name;
				%>
			</html:messages> <html:text property="email" styleClass="BusinessTextBox" value="<%= bean.getEmail()%>"
				maxlength="60" size="25" tabindex="9"></html:text> <%=errMsg%> <%
 	errMsg = "";
 %>
			</td>
		</tr>
		<tr>
			<td height="21" width="194">
			<div align="right"><font size="2" face="Tahoma">Subject
			<font color="#FF0000">*</font>: </font></div>
			</td>
			<td height="21" colspan="3"><html:messages id="err_name"
				property="subject">
				<%
					errMsg = err_name;
				%>
				
				
			</html:messages> <html:select property="subject" size="1" styleId="subject"
				styleClass="BusinessTextBox" tabindex="10">
				<option value="Choose a Subject">Choose a Subject</option><%=errMsg%>
				<option value="Log In Help">Log In Help</option>
				<option value="Registration">Registration</option>
				<option value="Web site">Web site</option>
				
				<%  
					String subject = request.getParameter("subject");
					if( (subject != null) && subject.equalsIgnoreCase("Feedback") ) { 
				%>
				<option selected value="Feedback">Feedback</option>	
				<% 
					}
					else 
					{
				%>
				<option value="Feedback">Feedback</option>
				<%
					}
				%>
				<option value="Other">Other</option>
			</html:select> <%=errMsg%> <%
 	errMsg = "";
 %>
			</td>
		</tr>
		<tr>
			<td height="56" width="194" bgcolor="#F4F4F4">
			<div align="right"><font size="2" face="Tahoma">Comment
			<font color="#FF0000">*</font>: </font></div>
			</td>
			<td height="56" bgcolor="#F4F4F4" colspan="3"><html:messages
				id="err_name" property="comment">
				<%
					errMsg = err_name;
				%>
			</html:messages> <html:textarea property="comment" cols="55" rows="5"
				styleClass="BusinessTextBox" tabindex="11"></html:textarea> <%=errMsg%>
			<%
				errMsg = "";
			%>
			</td>
		</tr>
		<tr>

			<td height="21" colspan="4" align="center"><html:submit
				property="submit" value="Submit" styleClass="ButtonStyle"
				tabindex="12"></html:submit></td>

		</tr>

	</table>
	<input type="hidden" value="<%= bean.getEmployerEmail() %>" name="employerEmail">
</html:form></div>