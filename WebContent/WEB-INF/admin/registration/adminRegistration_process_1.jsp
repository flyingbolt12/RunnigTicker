<%@page import="java.util.List"%>
<%@page import="com.lch.spring.BusinessComponents.DoTransaction"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>

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

.spanStyle {
	font-family: Tahoma;
	font-size: 10pt;
}
</style>
<div align="center">
	<html:form action="/adminRegistration.do?parameter=registrtationProcess1" onsubmit="return checkPwdAndCnfrmPwd()" focus="firstName">
		
		<table border="0" cellspacing="1" style="font-family: Tahoma; font-size: 10pt" class="registration" id="reg2" width="100%">
			<tr>
				<td class="regHeader" colspan="3">
						<b>Business Registration - User Details - Screen 2/3</b>
				</td>
			</tr>
			<tr>
				<td height="4"  colspan="3">
			</tr>
			<tr>
				<td><span class="must">First Name<font color="#FF0000">*</font></span></td>
				<td colspan="2"><html:text property="firstName" styleClass="BusinessTextBox" size="20" tabindex="1"></html:text></td>
			</tr>
			<tr>
				<td><span class="must">Middle Name</span></td>
				<td colspan="2"><html:text property="middleName" styleClass="BusinessTextBox" size="20" tabindex="2"></html:text></td>
			</tr>
			<tr>
				<td><span class="must">Last Name<font color="#FF0000">*</font></span></td>
				<td colspan="2"><html:text property="lastName" styleClass="BusinessTextBox" size="20" tabindex="3"></html:text></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td nowrap="nowrap"><font face="Tahoma" size="2"> Country Citizenship<font color="#FF0000">*</font></font></td> -->
<%-- 				<td colspan="2"><html:text property="countryCitizenship" styleClass="BusinessTextBox" size="20" tabindex="8"></html:text></td> --%>
<!-- 			</tr> -->
			<tr>
				<td><span class="must">Personal Address </span></td>
				<td colspan="2"><input type="checkbox" name="isSameAsBusinessAddress" onclick="personalAddressVisible(this)" value="Y" checked="checked"> Same as business address</td>
			</tr>
			<tr id="result_tr" style="display:none">
				<td colspan="3">
					<table border="0" cellspacing="1" style="font-family: Tahoma; font-size: 10pt" width="100%">
						<tr>
							<td rowspan="7" width="10%" bgcolor="white"></td>
							<td><font face="Tahoma"><span class="must">Address 1:<font color="#FF0000">*</font></span></font></td>
							<td><html:text property="listAddress[1].address1" styleClass="BusinessTextBox" size="20" tabindex="9"></html:text></td>
						</tr>
						<tr>
							<td><span class="must">Address 2:</span></td>
							<td><html:text property="listAddress[1].address2" styleClass="BusinessTextBox" size="20" tabindex="10"></html:text></td>
						</tr>
						<tr>
							<td><span class="must">City<font color="#FF0000">*</font></span></td>
							<td><html:text property="listAddress[1].city" styleClass="BusinessTextBox" size="20" tabindex="11"></html:text></td>
						</tr>
						<tr>
							<td><span class="must">State<font color="#FF0000">*</font></span></td>
							<td><html:text property="listAddress[1].state" styleClass="BusinessTextBox" size="20" tabindex="12" onblur="verifyState(this)"></html:text><span id="state"></span></td>
						</tr>
						<tr>
							<td><span class="must">Country<font color="#FF0000">*</font></span></td>
							<td><html:select property="listAddress[1].country" styleClass="BusinessTextBox" tabindex="13">
							
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
				</html:select>
							
							
							</td>
						</tr>
						<tr>
							<td><span class="must">Zip<font color="#FF0000">*</font></span></td>
							<td><html:text property="listAddress[1].zip" styleClass="BusinessTextBox" size="20" tabindex="14"></html:text></td>
						</tr>
						<tr>
							<td><span class="must">Land Mark</span></td>
							<td><html:text property="listAddress[1].landMark" styleClass="BusinessTextBox" size="20" tabindex="15"></html:text></td>
						</tr>			
					 </table>			
				</td>
			</tr>
		
			
			<tr>
				<td>User Name<font color="#FF0000">*</font></td>
				<td colspan="2"><html:text property="login" styleClass="BusinessTextBox" size="20" tabindex="16" onblur="verifyUser(this.value)" styleId="userName"></html:text> <font color="#FF0000"><span id="usrAvailabilityCheckMsg"></span></font></td>
			</tr>
			<tr>
				<td><font face="Tahoma" size="2">Password<font color="#FF0000">*</font></font></td>
				<td colspan="2"><html:password property="password" styleClass="BusinessTextBox" size="20" tabindex="17"></html:password> <font color="#FF0000"><span id="pwdErr"></span></font></td>
			</tr>
			<tr>
				<td>Confirm Password<font color="#FF0000">*</font></td>
				<td colspan="2"><html:password property="confirmPassword" styleClass="BusinessTextBox" size="20" tabindex="18"></html:password> <font color="#FF0000"><span id="cnfrmPwdErr"></span></font></td>
			</tr>
			<tr>
				<td height="4" colspan="3" bgcolor="#FFFFFF"></td>
			</tr>
			<tr>
				
				<td colspan="3" class="regHeader"><html:submit property="Next" value="Create User &amp; Move Next" styleClass="ButtonStyleDisabled" tabindex="19" styleId="cNext" disabled="true"></html:submit> 
				<html:submit property="cancel" value="Cancel Business Creation"	styleClass="ButtonStyle" tabindex="20"></html:submit></td>
			</tr>
		</table>
	</html:form>
</div>

<script>

	if (document.getElementsByTagName) {
	    var table = document.getElementById("reg2");
	    var rows = table.getElementsByTagName("tr");
	    for (i = 0; i < rows.length; i++) {
		    if (i % 2 == 0) {
			    rows[i].className = "even";
		    } else {
			    rows[i].className = "odd";
		    }
	    }
    }

    var userName = document.getElementById('userName').value;
    if (userName.value != null && userName.length > 0)
	    verifyUser(userName);

    function verifyUser(userName) {
	    var params = {
		    ajaxParam : userName
	    };
	    var obj = {
	    id : "usrAvailabilityCheckMsg",
	    url : "employeeRegistration.do?parameter=checkUserNameAvailability",
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
    if (!document.getElementById("cNext").disabled) {
    	document.getElementById("cNext").className = 'ButtonStyle';
    }


    function personalAddressVisible(checkbox){
    	
    	var result_style = document.getElementById('result_tr').style;
    	if (!checkbox.checked){
    		result_style.display = 'table-row';	
    	} else {
    		result_style.display = 'none';
    	}
    	
    	
    }
    
</script>