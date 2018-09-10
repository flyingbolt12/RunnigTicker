<%@page import="com.lch.general.enums.DOCTypes"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<%@page import="java.util.Map"%>

<style>
.tdStyle {
	background: rgb(181, 189, 200); /* Old browsers */
	/* IE9 SVG, needs conditional override of 'filter' to 'none' */
	background:
		url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2I1YmRjOCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjAlIiBzdG9wLWNvbG9yPSIjODI4Yzk1IiBzdG9wLW9wYWNpdHk9IjEiLz4KICAgIDxzdG9wIG9mZnNldD0iMTAwJSIgc3RvcC1jb2xvcj0iIzI4MzQzYiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgPC9saW5lYXJHcmFkaWVudD4KICA8cmVjdCB4PSIwIiB5PSIwIiB3aWR0aD0iMSIgaGVpZ2h0PSIxIiBmaWxsPSJ1cmwoI2dyYWQtdWNnZy1nZW5lcmF0ZWQpIiAvPgo8L3N2Zz4=);
	background: -moz-linear-gradient(top, rgba(181, 189, 200, 1) 0%,
		rgba(130, 140, 149, 1) 0%, rgba(40, 52, 59, 1) 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, rgba(181,
		189, 200, 1)), color-stop(0%, rgba(130, 140, 149, 1)),
		color-stop(100%, rgba(40, 52, 59, 1))); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top, rgba(181, 189, 200, 1) 0%,
		rgba(130, 140, 149, 1) 0%, rgba(40, 52, 59, 1) 100%);
	/* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top, rgba(181, 189, 200, 1) 0%,
		rgba(130, 140, 149, 1) 0%, rgba(40, 52, 59, 1) 100%);
	/* Opera 11.10+ */
	background: -ms-linear-gradient(top, rgba(181, 189, 200, 1) 0%,
		rgba(130, 140, 149, 1) 0%, rgba(40, 52, 59, 1) 100%); /* IE10+ */
	background: linear-gradient(to bottom, rgba(181, 189, 200, 1) 0%,
		rgba(130, 140, 149, 1) 0%, rgba(40, 52, 59, 1) 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#b5bdc8',
		endColorstr='#28343b', GradientType=0); /* IE6-8 */
	color: #FFFFFF;
}

.HTMLLINK {
	text-decoration: none;
	font-family: Tahoma;
	font-size: 10pt;
	color: #008080;
	padding-left: 4px;
	padding-right: 4px;
	padding-top: 1px;
	padding-bottom: 1px
}

.pre {
	text-decoration: none;
	font-family: Tahoma;
	font-size: 9pt;
	font-weight: bold;
	padding-left: 6px;
	padding-right: 6px;
	padding-top: 8px;
	vertical-align: middle;
}

.HTMLLINKHDR {
	text-decoration: none;
	font-family: Tahoma;
	font-size: 10pt;
	color: #FFFFFF;
	padding-left: 4px;
	padding-right: 4px;
	padding-top: 1px;
	padding-bottom: 1px
}
</style>

<script lang="javascript">

function submitForm(userId, businessId, role){
	dhtmlx.message({type:"error", expire:6000, text:"...Please wait!!" });
	//document.forms[0].businessId.value = id;
	//document.forms[0].submit();
	
	  var params = {
			userId : userId,
			businessId : businessId,
  		    role : role
  	    };
  	    var obj = {
  	    id:'regenerateValidationEmail_'+role+"_"+userId,
  	    url : "superAdminFunctImpl.do?parameter=regenerateValidationEmail",
  	    params : params,
  	    responseHandler : regenrateRegistrationEmailValidationHandler
  	    };
  	    sendAjaxRequest(obj);
}

function regenrateRegistrationEmailValidationHandler(obj, response){
	
	 if (response != null)
		    response = response.replace("disableSubmitRequired", "");
	 document.getElementById(obj.id).innerHTML = "Done!";
	    if (response.indexOf("alreadyValidated")!=-1){
	    	dhtmlx.message({type:"alert-error", expire:10000, text:"User Already Validated his/her email. So New Email is not Generated." });	
	    }
	    if (response.indexOf("invalidEmail")!=-1){
	    	dhtmlx.message({type:"alert-error", expire:10000, text:"Invalid Email." });	
	    }
}


</script>
<form action="superAdminFunctImpl.do?parameter=regenerateValidationEmail" method = "post">
	<input type="hidden" name="businessId" value="">
</form>
<table border="0" cellspacing="1" width="100%"
	style="font-family: Tahoma; font-size: 10pt">
	<tr height="25" style="vertical-align: middle;">
		<td align="center" class="tdStyle"><pre class="pre">Business Id</pre></td>
		<td align="center" class="tdStyle"><pre class="pre">Business Name</pre></td>
		<td align="center" class="tdStyle"><pre class="pre">Contact Number</pre></td>
		<td align="center" class="tdStyle"><pre class="pre">Email</pre></td>
		<td align="center" class="tdStyle"><pre class="pre">No of Employees</pre></td>
		<td align="center" class="tdStyle"><pre class="pre">Current Status</pre></td>
		<td align="center" class="tdStyle"><pre class="pre">Current Role</pre></td>
		<td align="center" class="tdStyle"><pre class="pre">Regenerate Validation Email</pre></td>
	</tr>

	<logic:iterate id="listAllBusinessId" name="listAllBusiness">

		<%
			String businessId = String.valueOf(((Map) listAllBusinessId).get("businessId"));
		String iduser = String.valueOf(((Map) listAllBusinessId).get("iduser"));
				String contactEmail = String.valueOf(((Map) listAllBusinessId).get("contactEmail"));
				String role = String.valueOf(((Map) listAllBusinessId).get("role"));
				
		%>
		<tr>

			<td align="center" bgcolor="#EFEFEF"><bean:write
					name="listAllBusinessId" property="businessId"></bean:write></td>
			<td align="center" bgcolor="#EFEFEF"><bean:write
					name="listAllBusinessId" property="businessName"></bean:write></td>
			<td align="center" bgcolor="#EFEFEF"><bean:write
					name="listAllBusinessId" property="phoneNumber"></bean:write></td>
			<td align="center" bgcolor="#EFEFEF"><bean:write
					name="listAllBusinessId" property="contactEmail"></bean:write></td>
			<td align="center" bgcolor="#EFEFEF"><bean:write
					name="listAllBusinessId" property="noOfEmployees"></bean:write></td>
			<td align="center" bgcolor="#EFEFEF">
				<%
					String ajaxAction = "superAdminFunctImpl.do?parameter=downloadDoBackUpData";
						String status = String.valueOf(((Map) listAllBusinessId).get("approvalStatus"));
				%> <%=(status.equals("1") ? "ACTIVE" : " NOT ACTIVE")%>
			</td>
			<td align="center" bgcolor="#EFEFEF"><bean:write
					name="listAllBusinessId" property="role"></bean:write></td>
			<td align="center" bgcolor="#EFEFEF"  id="regenerateValidationEmail_<%= role%>_<%= iduser%>"><input type="button"
				value="Re Generate Validation Email" name="active" class="ButtonStyle"
				onclick="submitForm('<%=iduser%>','<%=businessId%>', '<%= role%>')"></td>
		</tr>
	</logic:iterate>

</table>
