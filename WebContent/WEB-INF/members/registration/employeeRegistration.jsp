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
	<html:form action="/employeeRegistration.do?parameter=srartRegistration" enctype="multipart/form-data">

		<table border="0" cellspacing="1" width="100%" id="regEmp" style="font-family: Tahoma; font-size: 10pt">
			<tr>
				<td class="regHeader" colspan="3"><b>Employee Registration - User Details - Screen 1/3</b></td>
			</tr>
			<tr>
				<td height="4" colspan="3"></td>
			</tr>
			<tr>
				<td align="left" colspan="3" bgcolor="#CDCCCD"><span class="spanStyle">User Details</span></td>
			</tr>

			<tr>
				<td rowspan="11" bgcolor="white" width="20%"></td>
				<td><span class="spanStyle">First Name<font color="#FF0000">*</font></span></td>
				<td><html:text property="firstName" styleClass="EmployeeTextBox" size="20" tabindex="1020"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Middle Name</span></td>
				<td><html:text property="middleName" styleClass="EmployeeTextBox" size="20" tabindex="1021"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Last Name<font color="#FF0000">*</font></span></td>
				<td><html:text property="lastName" styleClass="EmployeeTextBox" size="20" tabindex="1022"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Gender<font color="#FF0000">*</font></span></td>
				<td><html:select property="gendar" styleClass="EmployeeTextBox" size="1" tabindex="1023">
						<html:option value="MALE"></html:option>
						<html:option value="FEMALE"></html:option>
					</html:select></td>
			</tr>

			<tr>
				<td><span class="spanStyle">Email-Id<font color="#FF0000">*</font></span></td>
				<td><html:text property="contactEmail" styleId="contactEmail" styleClass="EmployeeTextBox" size="20" tabindex="1024" onblur="verifyEmpEmail(this.value)"></html:text> <font color="#000000"><span id="usrEmailAvailabilityCheckMsg"></span></font></td>
			</tr>

			<tr>
				<td><span class="spanStyle">Phone Number<font color="#FF0000">*</font></span></td>
				<td><html:text property="phoneNumber" styleClass="EmployeeTextBox" size="20" tabindex="1025"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Father Name</span></td>
				<td><html:text property="fatherName" styleClass="EmployeeTextBox" size="20" tabindex="1026"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Country Citizenship</span></td>
				<td><html:text property="countryCitizenship" styleClass="EmployeeTextBox" size="20" tabindex="1027"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Submit TimeSheets</span></td>
				<td><html:select property="timeSheetConfiguredTo" styleClass="EmployeeTextBox" size="1" tabindex="1028">
						<html:option value="MONTHLY"></html:option>
						<html:option value="BIWEEKLY"></html:option>
						<html:option value="DAYS15"></html:option>
						<html:option value="WEEKLY"></html:option>
					</html:select></td>
			</tr>

			<tr>
				<td><span class="spanStyle">Date of Birth<font color="#FF0000">*</font></span></td>
				<td><html:text property="dob" styleClass="EmployeeTextBox" size="20" tabindex="1028" styleId="dob"></html:text> <img onmouseout="this.style.background=''" onmouseover="this.style.background='pink';" title="Date selector"
					style="border: 1px solid green; cursor: pointer;" id="f_trigger_c" src="jscalendar-1.0/img.gif" /> <font size="2"><span style="font-family: Tahoma">MM/DD/YYYY</span></font></td>
			</tr>
			<tr>

				<td><span class="spanStyle">Profile Path</span></td>
				<td><html:file property="profilePath" styleClass="EmployeeTextBox" size="20" tabindex="1029"></html:file></td>
			</tr>

			<tr>
				<td colspan="3" align="left" bgcolor="#CDCCCD"><span class="spanStyle">Employee Current Address<font color="#FF0000">*</font>
				</span></td>
			</tr>

			<tr>
				<td rowspan="6" bgcolor="white" width="20%"></td>
				<td align="left"><span class="spanStyle">Address 1:</span></td>
				<td align="left"><html:text property="listAddress[0].address1" styleClass="EmployeeTextBox" size="45" tabindex="1030"></html:text></td>

			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Address 2:</span></td>
				<td align="left"><html:text property="listAddress[0].address2" styleClass="EmployeeTextBox" size="45" tabindex="1031"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">City</span></td>
				<td><html:text property="listAddress[0].city" styleClass="EmployeeTextBox" size="20" tabindex="1032"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">State</span></td>
				<td><font face="Tahoma"> <html:text property="listAddress[0].state" styleClass="EmployeeTextBox" size="20" tabindex="1033" onblur="verifyState(this)"></html:text></font> <span id="state"></span></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Country</span></td>
				<td><html:text property="listAddress[0].country" styleClass="EmployeeTextBox" size="20" tabindex="1034"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Zip</span></td>
				<td><font face="Tahoma"> <html:text property="listAddress[0].zip" styleClass="EmployeeTextBox" size="20" tabindex="1035"></html:text></font></td>
			</tr>
			<tr>
				<td colspan="2" align="left" bgcolor="#CDCCCD"><span class="spanStyle">Employee Home Country Address<font color="#FF0000">*</font>
				</span></td>
				<td bgcolor="#CDCCCD"><input type="checkbox"  name="isSameAsBusinessAddress" onclick="personalAddressVisible(this)" value="Y" checked="checked"> Same as personal address</td>
			</tr>
			
			<tr  id="result_tr" style="display:none"><td colspan="3">
			
			<table border="0" cellspacing="1" style="font-family: Tahoma; font-size: 10pt" width="100%">
			<tr>
				<td rowspan="6" width="20%" bgcolor="white"></td>
				<td align="left"><span class="spanStyle">Address 1:</span></td>
				<td align="left"><html:text property="listAddress[1].address1" styleClass="EmployeeTextBox" size="45" tabindex="1036"></html:text></td>

			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Address 2:</span></td>
				<td align="left"><html:text property="listAddress[1].address2" styleClass="EmployeeTextBox" size="45" tabindex="1037"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">City</span></td>
				<td><html:text property="listAddress[1].city" styleClass="EmployeeTextBox" size="20" tabindex="1038"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">State</span></td>
				<td><font face="Tahoma"> <html:text property="listAddress[1].state" styleClass="EmployeeTextBox" size="20" tabindex="1039"></html:text></font></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Country</span></td>
				<td><html:text property="listAddress[1].country" styleClass="EmployeeTextBox" size="20" tabindex="1040"></html:text></td>
			</tr>
			<tr>
				<td><span class="spanStyle">Zip</span></td>
				<td><font face="Tahoma"> <html:text property="listAddress[1].zip" styleClass="EmployeeTextBox" size="20" tabindex="1041"></html:text></font></td>
			</tr>
			
			</table>
			</td>
			</tr>
			
			<tr>
				<td height="4" colspan="3"></td>
			</tr>
			<tr>
				<td colspan="3" class="regHeader"><html:submit value="Next Page" property="create" styleClass="ButtonStyleDisabled" tabindex="1042" title="Take you to the next page if not disabled" styleId="cNextEmp" disabled="true"></html:submit> <html:submit
						value="Cancel" property="cancel" styleClass="ButtonStyle" tabindex="1042"></html:submit></td>
			</tr>
		</table>
	</html:form>
</div>
<script type="text/javascript">
	Calendar.setup({
    inputField : "dob",
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
	
    
    if (!document.getElementById("cNextEmp").disabled) {
    	document.getElementById("cNextEmp").className = 'ButtonStyle';
    }

    function verifyEmpEmail(email) {
	    var params = {
		    ajaxParam : email
	    };
	    var obj = {
	    id : "usrEmailAvailabilityCheckMsg",
	    url : "employeeRegistration.do?parameter=checkUserEmailAvailability",
	    params : params,
	    responseHandler : handleEmpResponse
	    };
	    sendAjaxRequest(obj);
    }
    function handleEmpResponse(obj, response) {
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
 function personalAddressVisible(checkbox){
    	
    	var result_style = document.getElementById('result_tr').style;
    	if (!checkbox.checked){
    		result_style.display = 'table-row';	
    	} else {
    		result_style.display = 'none';
    	}
    	
    	
    }
</script>