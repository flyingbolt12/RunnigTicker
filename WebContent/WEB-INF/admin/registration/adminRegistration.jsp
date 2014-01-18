<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lch.spring.BusinessComponents.DoTransaction"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>

<div align="center">
	<html:form action="/adminRegistration.do?parameter=srartRegistration" enctype="multipart/form-data" >
		<table border="0" cellspacing="1" style="font-family: Tahoma; font-size: 10pt" class="registration" id="reg1" width="100%">
			<tr>
				<td class="regHeader" colspan="3"><b>Business Registration - Business Details - Screen 1/3</b></td>
			</tr>
			<tr>
				<td height="4" colspan="3">
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Business Name/Company Name<font color="#FF0000">*</font></span></td>
				<td colspan="2" align="left"><html:text property="businessName" styleClass="BusinessTextBox" size="65" tabindex="1000"></html:text></td>
			</tr>
			<tr>
				<td colspan="3" align="left"><span class="spanStyle">Main Business Address<font color="#FF0000">*</font></span></td>
			</tr>
			<tr>
				<td rowspan="7">&nbsp;</td>
				<td align="left"><span class="spanStyle">Address 1:<font color="#FF0000">*</font></span></td>
				<td align="left"><html:text property="listAddress[0].address1" styleClass="BusinessTextBox" size="45" tabindex="1001"></html:text></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Address 2:</span></td>
				<td align="left"><html:text property="listAddress[0].address2" styleClass="BusinessTextBox" size="45" tabindex="1002"></html:text></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">City<font color="#FF0000">*</font></span></td>
				<td align="left"><html:text property="listAddress[0].city" styleClass="BusinessTextBox" size="20" tabindex="1003"></html:text></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">State<font color="#FF0000">*</font></span></td>
				<td align="left"><html:text property="listAddress[0].state" styleClass="BusinessTextBox" size="20" tabindex="1004" onblur="verifyState(this)"></html:text><span id="state"></span></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Country<font color="#FF0000">*</font></span></td>
				<td align="left"><html:select property="listAddress[0].country" styleClass="BusinessTextBox" tabindex="1005" >
				
				<%
				
				GenericXmlApplicationContext ctx = null;
				try {
					ctx = (GenericXmlApplicationContext) application.getAttribute("ctx");
				} catch (Exception e) {
					
				}
				
				DoTransaction doTransaction = (DoTransaction) ctx.getBean("doTransaction");
				List<String> countires = (List<String>)doTransaction.listCountries();
				
				for (String country : countires)
				{
				%>
				<html:option value="<%= country%>"></html:option>
				<%} %>
				</html:select></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Zip<font color="#FF0000">*</font></span></td>
				<td align="left"><html:text property="listAddress[0].zip" styleClass="BusinessTextBox" size="20" tabindex="1006"></html:text></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Land Mark</span></td>
				<td align="left"><html:text property="listAddress[0].landMark" styleClass="BusinessTextBox" size="20" tabindex="1007"></html:text></td>
			</tr>

			<tr>
				<td align="left"><span class="spanStyle">Logo</span></td>
				<td colspan="2" align="left"><html:file property="logo" styleClass="BusinessTextBox" tabindex="1008"></html:file></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Land Phone<font color="#FF0000">*</font></span></td>
				<td colspan="2" align="left"><html:text property="phoneNumber" styleClass="BusinessTextBox" size="20" tabindex="1009"></html:text></td>
			</tr>

			<tr>
				<td align="left"><span class="spanStyle">Business e-mail id<font color="#FF0000">*</font></span></td>
				<td colspan="2" align="left">
				<html:text property="contactEmail" styleClass="BusinessTextBox" size="20" tabindex="1010" onblur="verifyEmail(this.value)" styleId="empContactEmail"></html:text> <font color="#000000"><span id="userEmailAvailabilityCheckMsg"></span></font></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Web Site URL</span></td>
				<td colspan="2" align="left"><html:text property="websiteURL" value="http://" styleClass="BusinessTextBox" size="20" tabindex="1011"></html:text></td>
			</tr>
			<tr>
				<td colspan="3" class="regHeader">
						<html:submit value="Create Business &amp; Move Next" property="create" styleClass="ButtonStyleDisabled" tabindex="1013" styleId="cNext" disabled="true"></html:submit>
						<html:submit value="Cancel Business Creation" property="cancel" styleClass="ButtonStyle" tabindex="1014"></html:submit>
				</td>
			</tr>
		</table>
	</html:form>
</div>


<script>
	if (document.getElementsByTagName) {
	    var table = document.getElementById("reg1");
	    var rows = table.getElementsByTagName("tr");
	    for (i = 0; i < rows.length; i++) {
		    if (i % 2 == 0) {
			    rows[i].className = "even";
		    } else {
			    rows[i].className = "odd";
		    }
	    }
    }
	
    function verifyEmail(email) {
	    var params = {
		    ajaxParam : email
	    };
	    var obj = {
	    id : "userEmailAvailabilityCheckMsg",
	    url : "employeeRegistration.do?parameter=checkUserEmailAvailability",
	    params : params,
	    responseHandler : handleResponse
	    };
	    
	    sendAjaxRequest(obj);
    }
    function handleResponse(obj, response) {
	    removeAjaxImg(obj.id);
	    
	    if (response.indexOf("disableSubmitRequired") == -1) {
		    document.getElementById("cNext").disabled = false;
		    document.getElementById("cNext").className = 'ButtonStyle';
	    } else {
		    document.getElementById("cNext").disabled = true;
		    document.getElementById("cNext").className = 'ButtonStyleDisabled';
	    }
	    if (response != null)
		    response = response.replace("disableSubmitRequired", "");
	    placeAjaxMessage(obj.id, response);
	    
    }
       
</script>
