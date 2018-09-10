<%@page import="java.util.List"%>
<%@page import="com.lch.spring.BusinessComponents.DoTransaction"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>

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
	<html:form action="/employeeRegistration.do?parameter=registrationProcess" onsubmit="return checkPwdAndCnfrmPwd()" focus="businessId">

		<table border="0" cellspacing="1" width="100%" style="font-family: Tahoma; font-size: 10pt" id="regEmp">
			<tr>
				<td colspan="3" class="regHeader"><b>Employee Registration - User Details - Screen 2/3</b></td>
			</tr>
			<tr>
				<td align="left" colspan="3" bgcolor="#CDCCCD">Employer Details<font color="#FF0000">*</font></td>
			</tr>
			<tr>
				<td align="left" width="20%"></td>
				<td><span class="spanStyle">Employer Code</span></td>
				<td nowrap="nowrap"><html:text property="businessId" styleId="empBUsID" styleClass="EmployeeTextBox" size="20" tabindex="4" onblur="verifyEmpId(this.value)"></html:text>
					<div id="ajaxMsg"></div></td>
			</tr>
			<tr>
				<td align="left" bgcolor="#CDCCCD" colspan="3">Client Details<font color="#FF0000">*</font></td>
			</tr>
			<tr>
				<td align="left" width="20%"></td>
				<td nowrap="nowrap"><span class="spanStyle">Client Working For</span> </td>
				<td><html:text property="clientName" styleClass="EmployeeTextBox" size="20" tabindex="5" styleId="clientName"></html:text> 
				<input type="checkbox" onclick="hideClient(this)" name="isSameAsBusinessAddress" value="Y"> Check if, Your Employer is your Client or When no Client</td>
			</tr>
			<tr>
				<td colspan="3" width="100%">
				
				<table border="0" cellspacing="1" width="100%" style="font-family: Tahoma; font-size: 10pt" id="regEmp1">
				
				<tr>
				<td align="left" colspan="3" bgcolor="#CDCCCD">Client Address<font color="#FF0000">*</font></td>
			</tr>
			<tr>
				<td align="left" rowspan="7" width="20%"></td>
				<td><span class="spanStyle">Address1</span></td>
				<td><html:text property="listAddress[2].address1" styleClass="EmployeeTextBox" size="40" tabindex="6"></html:text></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Address2</span></td>
				<td align="left"><html:text property="listAddress[2].address2" styleClass="EmployeeTextBox" size="30" tabindex="7"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">City</span></td>
				<td><html:text property="listAddress[2].city" styleClass="EmployeeTextBox" size="20" tabindex="8"></html:text></td>
			</tr>

			<tr>
				<td><span class="spanStyle">State</span></td>
				<td><html:text property="listAddress[2].state" styleClass="EmployeeTextBox" size="20" tabindex="9" onblur="verifyState(this)"></html:text> <span id="state"></span></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Country</span></td>
				<td><html:select property="listAddress[2].country" styleClass="EmployeeTextBox" tabindex="10">
				
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
				<td><span class="spanStyle">Zip</span></td>
				<td><html:text property="listAddress[2].zip" styleClass="EmployeeTextBox" size="20" tabindex="11"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Work Start Date</span></td>
				<td><html:text property="startDate" styleClass="EmployeeTextBox" size="20" tabindex="12" styleId="start_date"></html:text> <img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector"
					style="border: 1px solid green; cursor: pointer;" id="f_trigger_c" src="jscalendar-1.0/img.gif" /> <font size="2"><span style="font-family: Tahoma">MM/DD/YYYY</span></font></td>
			</tr>
				
				</table>
				
				</td>
			</tr>

			<tr>
				<td align="left" colspan="3" bgcolor="#CDCCCD">Login Credentials<font color="#FF0000">*</font>
				</td>
			</tr>

			<tr>
				<td rowspan="3"></td>
				<td><span class="spanStyle">User Email Id (Same is used as UserName)</span></td>
				<td><html:text property="login" styleClass="EmployeeTextBox" styleId="userName" size="20" tabindex="18" onblur="verifyUserId(this.value)"></html:text> <span id="usrAvailabilityCheckMsg"></span></td>
			</tr>
			<tr>
				<td> &nbsp;&nbsp;Password</td>
				<td><html:password property="password" styleClass="EmployeeTextBox" size="20" tabindex="19"></html:password> <span id="pwdErr"></span></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Confirm Password</span></td>
				<td><html:password property="confirmPassword" styleClass="EmployeeTextBox" size="20" tabindex="20"></html:password> <span id="cnfrmPwdErr"></span></td>
			</tr>

			<tr>
				<td height="2"></td>
				<td height="2"></td>
				<td height="2"></td>
			</tr>

			<tr>
				<td colspan="3" class="regHeader"><html:submit property="Next" value="Next Page" styleClass="ButtonStyleDisabled" tabindex="21" styleId="cNextEmp" disabled="true"></html:submit> <html:submit property="cancel" value="Cancel"
						styleClass="ButtonStyle" tabindex="22"></html:submit> <html:submit property="previous" value="Previous" styleClass="ButtonStyle" tabindex="23"></html:submit></td>
			</tr>
		</table>
	</html:form>
</div>
<script type="text/javascript">
	Calendar.setup({
    inputField : "start_date",
    ifFormat : "%m/%e/%Y",
    button : "f_trigger_c",
    align : "Tl",
    singleClick : false
    });
</script>

<script>
	if (document.getElementsByTagName) {
	    var table = document.getElementById("regEmp");
	    var rows = table.getElementsByTagName("tr");
	    for (i = 0; i < rows.length; i++) {
		    if (i % 2 == 0) {
			    rows[i].className = "even";
		    } else {
			    rows[i].className = "odd";
		    }
	    }
    }


    function verifyEmpEmail(email) {
	    var params = {
		    ajaxParam : email
	    };
	    var obj = {
	    id : "usrEmailAvailabilityCheckMsg",
	    url : "employeeRegistration.do?parameter=checkUserEmailAvailability",
	    params : params,
	    responseHandler : handleEmpEmailResponse
	    };
	    sendAjaxRequest(obj);
    }
    function handleEmpEmailResponse(obj, response) {
	    removeAjaxImg(obj.id);
	    
	    if (response.indexOf("disableSubmitRequired") == -1) {
		    document.getElementById("cNextEmp").disabled = false;
		    document.getElementById("cNextEmp").className = 'ButtonStyle';
	    } else {
		    document.getElementById("cNextEmp").disabled = true;
		    document.getElementById("cNextEmp").className = 'ButtonStyleDisabled';
	    }
	    if (response != null)
		    response = response.replace("disableSubmitRequired", "");
	    placeAjaxMessage(obj.id, response);
	    
    }
    
    function verifyEmpId(text) {
	    var params = {
		    ajaxParam : text
	    };
	    var obj = {
	    id : "ajaxMsg",
	    url : "employeeRegistration.do?parameter=getEmployerName",
	    params : params,
	    responseHandler : handleEmpNameResponse
	    };
	    sendAjaxRequest(obj);
	    
	    //var userName = document.getElementById('userName').value;
	   // if(userName.value!=null && userName.length > 0)
	    	//verifyUserId(userName);
    }
    function verifyUserId(text) {
    	//verifyEmpEmail(text);
	    var params = {
		    ajaxParam : text
	    };
	    var obj = {
	    id : "usrAvailabilityCheckMsg",
	    url : "employeeRegistration.do?parameter=checkUserNameAndEmailAvailability",
	    params : params,
	    responseHandler : handleEmpResponse
	    };
	    sendAjaxRequest(obj);
    }
    var isUserValid = false;
    var isEmployerValid = false;
    var employerName;
    
    function handleEmpNameResponse(obj, response) {
	    removeAjaxImg(obj.id);
	    
	    if (response.indexOf("disableSubmitRequired") == -1) {
		    if (obj.id == "usrAvailabilityCheckMsg") {
			    isEmployerValid = true;
		    } else {
			    isUserValid = true;
		    }
		    if (isUserValid && isEmployerValid) {
			    document.getElementById("cNextEmp").disabled = false;
			    document.getElementById("cNextEmp").className = 'ButtonStyle';
		    }
	    } else {
		    
		    document.getElementById("cNextEmp").disabled = true;
		    document.getElementById("cNextEmp").className = 'ButtonStyleDisabled';
	    }
	    if (response != null)
		    response = response.replace("disableSubmitRequired", "");
	    
	    employerName = response;
	    placeAjaxMessage(obj.id, response);
    }
    
    function handleEmpResponse(obj, response) {
	    removeAjaxImg(obj.id);
	    
	    if (response.indexOf("disableSubmitRequired") == -1) {
		    if (obj.id == "usrAvailabilityCheckMsg") {
			    isEmployerValid = true;
		    } else {
			    isUserValid = true;
		    }
		    if (isUserValid && isEmployerValid) {
			    document.getElementById("cNextEmp").disabled = false;
			    document.getElementById("cNextEmp").className = 'ButtonStyle';
		    }
	    } else {
		    
		    document.getElementById("cNextEmp").disabled = true;
		    document.getElementById("cNextEmp").className = 'ButtonStyleDisabled';
	    }
	    if (response != null)
		    response = response.replace("disableSubmitRequired", "");
	    
	    placeAjaxMessage(obj.id, response);
    }
    
    if (!document.getElementById("cNextEmp").disabled) {
    	document.getElementById("cNextEmp").className = 'ButtonStyle';
    }

 function hideClient(checkbox){
    	
    	var result_style = document.getElementById('regEmp1').style;
    	if (!checkbox.checked){
    		document.getElementById("clientName").readOnly = false;
    		document.getElementById("clientName").value = "";
    		result_style.display = 'table-cell';	
    	} else {
    		document.getElementById("clientName").value = employerName;
    		document.getElementById("clientName").readOnly = true;
    		
    		result_style.display = 'none';
    	}
    	
    	
    }
</script>