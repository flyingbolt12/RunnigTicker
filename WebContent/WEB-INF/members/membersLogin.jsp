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
<div align="center">
	<font color="#FF0000" face="Tahoma" size="2"><html:errors /></font>
</div>
<br>
<html:form action="/login">
	<table border="0" cellspacing="3" style="font-family: Tahoma; font-size: 10pt" align="center" cellspacing="0px" cellpadding="0px" width="90%" align="center">

		<tr>
			<td bgcolor="#808080" align="center" colspan="3" height="28px"><font color="#FFFFFF">Application Login : Enter Credentials</font></td>
		</tr>

		<tr>
			<td width="58"></td>
			<td align="left">User Name</td>
			<td align="left"><html:text property="userName" tabindex="1" styleClass="BusinessTextBox"></html:text></td>

		</tr>
		<tr>
		<td></td>
			<td align="left">Password</td>
			<td align="left"><html:password property="password" tabindex="2" styleClass="BusinessTextBox"></html:password></td>
		</tr>

		<tr>
			<td colspan="3" align="right"><html:submit value="Submit" property="lsubmit" styleClass="ButtonStyle" tabindex="3"></html:submit> <html:reset value="Reset" property="reset" styleClass="ButtonStyle" tabindex="4"></html:reset></td>
		</tr>

		<tr>
			<td colspan="3" align="right"><html:link href="#" onclick="confirmlink(this)" styleClass="HTMLLINK" title="Try our live demo " tabindex="6">Try Live Demo</html:link> | <html:link action="/forgotPassword?parameter=forgotPasswordOptionsPage"
					styleClass="HTMLLINK" title="Helps you to retrive your password" tabindex="6">Forgot Password?</html:link></td>
		</tr>
	</table>

</html:form>

<script>
	var optionSeletced = "employee";
    
    function updateSelectedOption(option) {
	    optionSeletced = option;
    }
    function confirmlink(thislink) {
	    optionSeletced = "employer";
	    var msg = '<input type="radio" value="Employer" checked name="R1" onclick="updateSelectedOption(this.value)"> Try as an Employer	<br>  <input type="radio" value="employee" name="R1" onclick="updateSelectedOption(this.value)"> Try as an Employee';
	    
	    dhtmlx.confirm({
	    title : "Choose an option",
	    text : msg,
	    ok : "Proceed",
	    cancel : "Cancel",
	    callback : function(result) {
		    
		    if (result == false)
			    return;
		    if (optionSeletced == 'employee') {
			    chooseEmployee(thislink);
		    } else {
			    document.forms[0].userName.value = "ilchemployer@gmail.com";
			    document.forms[0].password.value = "allibilli";
			    document.forms[0].submit();
		    }
		    
	    }
	    });
	    
    }
    function chooseEmployee(thislink) {
	    optionSeletced = "weekly";
	    var msg = '<input type="radio" value="weekly" name="R1" checked onclick="updateSelectedOption(this.value)"> Weekly Time sheet <br>'
	            + '<input type="radio" value="biweekly" name="R1" onclick="updateSelectedOption(this.value)">Bi-Weekly Time sheet <br>'
	            + '<input type="radio" value="monthly" name="R1" onclick="updateSelectedOption(this.value)"> Monthly Time sheet <br>'
	            + '<input type="radio" value="days15" name="R1" onclick="updateSelectedOption(this.value)"> 15 Days Time sheet <br>';
	    
	    dhtmlx.confirm({
	    title : "Choose an employee type",
	    text : msg,
	    ok : "Proceed",
	    cancel : "Cancel",
	    callback : function(result) {
		    
		    if (result == false)
			    return;
		    
		    document.forms[0].password.value = "allibilli";
		    
		    if (optionSeletced == 'weekly') {
			    document.forms[0].userName.value = "ilchweekly@gmail.com";
		    } else if (optionSeletced == 'biweekly') {
			    document.forms[0].userName.value = "ilchbiweekly@gmail.com";
		    } else if (optionSeletced == 'monthly') {
			    document.forms[0].userName.value = "ilchmonthly@gmail.com";
		    } else if (optionSeletced == 'days15') {
			    document.forms[0].userName.value = "ilchdays15@gmail.com";
		    } else {
			    alert("You must choose an option, try it again");
			    return false;
		    }
		    
		    document.forms[0].submit();
	    }
	    });
	    
    }
</script>
