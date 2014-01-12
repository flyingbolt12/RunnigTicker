<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
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

.HTMLLINK {
	text-decoration: none;
	font-family: Tahoma;
	font-size: 8pt;
	color: #008080;
	padding-left: 4px;
	padding-right: 4px;
	padding-top: 1px;
	padding-bottom: 1px
}
</style>

<br>
<br>
<br>
<div align="center">
	<font color="#FF0000" face="Tahoma" size="2"><html:errors /></font>
</div>
<br>
<html:form action="memberFunctImpl.do">
	<html:hidden property="parameter" value="changeEmployer" />
	<table border="0" cellspacing="3" width="70%" style="font-family: Tahoma; font-size: 10pt" align="center">
		<tr>
			<td bgcolor="#808080" align="left" colspan="2">
				<p align="center">
					<font color="#FFFFFF"><b>&nbsp;Switching Employee</b></font>
			</td>
		</tr>
		<tr>
			<td bgcolor="#F4F4F4" align="right" nowrap="nowrap">Enter Employer Code</td>
			<td bgcolor="#F4F4F4" align="left"><html:text property="employerCode" onblur="verifyEmployerValidity()" styleId="employerCode" value="" tabindex="1" styleClass="BusinessTextBox"></html:text>
			<span id="employerValidity"></span>
			</td>
		</tr>
		<tr>
			<td bgcolor="#F4F4F4" align="right"></td>
			<td bgcolor="#F4F4F4"><input type="button" value="VerifyValidity" id="VerifyValidity" name="verify" class="ButtonStyle" tabindex="8" onclick="verifyEmployerValidity()">
			<input type="submit" disabled="disabled" value="Proceed to change" name="update" id="cNext" class="ButtonStyleDisabled" tabindex="8"><input type="Button" value="Cancel " onclick="redirectOnClickCancel()" name="cancel"
				class="ButtonStyle" tabindex="8"></td>
		</tr>


	</table>

</html:form>

<script>
	
    function verifyEmployerValidity() {
    	employerCode = document.getElementById("employerCode").value;
    	document.getElementById("VerifyValidity").style.visibility = "visible";
    	document.getElementById("cNext").disabled = true;
	    document.getElementById("cNext").className = 'ButtonStyleDisabled';
	    var params = {
		    ajaxParam : employerCode
	    };
	    var obj = {
	    id : "employerValidity",
	    url : "memberFunctImpl.do?parameter=verifyEmployerValidity",
	    params : params,
	    responseHandler : handleResponse
	    };
	    
	    sendAjaxRequest(obj);
    }
    function handleResponse(obj, response) {
	    removeAjaxImg(obj.id);
	    
	    if (response.indexOf("disableSubmitRequired") == -1) {
	    	document.getElementById("VerifyValidity").style.visibility = "hidden";
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
