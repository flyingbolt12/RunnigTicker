


<script type="text/javascript">
function work()
{
	var theone;
	for (i=0;i<document.forms[0].R1.length;i++)
	{
		if (document.forms[0].R1[i].checked==true)
		{
		theone=i;
		}
	}
	document.forms[1].parameter.value=document.forms[0].R1[theone].value;
	document.forms[1].submit();
}
function onClickAction()
{
if(document.forms[0].R1[0].checked==true){
	document.forms[1].action ="employeeRegistration.do";
	document.forms[1].submit();
	}
else if (document.forms[0].R1[1].checked==true) {
	document.forms[1].action ="employeeRegistration.do";
	document.forms[1].submit();
    }
else if (document.forms[0].R1[2].checked==true) {
	document.forms[1].action ="employeeRegistration.do";
	document.forms[1].submit();
    }
else if (document.forms[0].R1[3].checked==true)
	{
	document.forms[1].action ="adminFunctImpl.do";
	document.forms[1].submit();
	}

}
</script>

 <form method="get" action="javascript:onClickAction()">
<p><input type="radio" value="getEmployeeDetailsForUpdate"  name="R1"  onclick="javascript:work()">Bank 
Details</p>
<p><input type="radio" value="getEmployeeDetailsForUpdate"  name="R1"  onclick="javascript:work()">Personal 
Details </p>
<p><input type="radio" value="getEmployeeDetailsForUpdate"  name="R1"  onclick="javascript:work()">Client 
Details</p>
<p><input type="radio" value="userRateDetails"  name="R1"  onclick="javascript:work()">User Rate 
Details</p>
 </form>

<form method="get" action="javascript:onClickAction()">
<input type="hidden" name="parameter">
<input type="hidden" name="userId" value="<%=request.getParameter("userId") %>">
</form>

