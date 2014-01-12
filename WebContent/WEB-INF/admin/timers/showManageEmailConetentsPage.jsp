<%@page import="java.util.TimeZone"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.lch.general.enums.TimerStatus"%>
<%@page import="com.lch.general.enums.TimeSheetStatus"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>


<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>

<%
	String status = (String) request.getAttribute("status");
	if (status != null && status.length() > 0) {
%>
<script>
	dhtmlx.message({type:"error", expire:6000, text:"<%=status%>" });</script>
<%
	}
%>


<style>
#image:hover+#msg {
	display: block;
}
</style>
<script>
	function deleteConformation(id, name, action) {
	  dhtmlx.confirm(
		  {
		  title : "Not Recoverable - Are you sure? ",
		  text : "Deleting " + name,
		  ok : "Yes, Delete",
		  cancel : "No",
		  callback : function(result) {
			  if (result == true)
				  {
					  submitForm(id, name, action);
				  } else
				  {
					  return false;
				  }
		  }
		  });
	  
  }
  function showEmailContent(text) {
  	msg.innerHTML = text;
  	
  }
  function submitForm(id, name, action) {
	  document.forms[0].id.value = id;
	  document.forms[0].action.value = action;
	  document.forms[0].submit();
  }
</script>
<%
	String contentId = "";
	String contentName = "";
	Timestamp dateCreated;
	String isContentinUse = "";
	String emailContent = "";
	int count = 0;
	int count1 = 0;
	String userId = "";
%>
<div align="center">
	<hr class="regHeader" />
	<span>-- Manage "<strong>not in use</strong>" email contents --
	</span>
	<hr class="regHeader" />
	<br> <span id="message"> </span>

	<table border="0" style="font-family: Tahoma; font-size: 10pt" width="90%"
	
		id="customTable">

		<tr>
			<td class="tdHeader"><b>Content Name</b></td>
			<td class="tdHeader"><b>Date Created</b></td>
			<td class="tdHeader"><b>Actions</b></td>
			<td class="tdHeader"><b>Is in Use?</b></td>
		</tr>

		<logic:iterate id="accessId" name="list">
			<%
				contentId = String.valueOf(((Map) accessId).get("contentId"));
					System.out.println(contentId);
					contentName = String.valueOf(((Map) accessId)
							.get("contentName"));
					dateCreated = (Timestamp) (((Map) accessId).get("dateCreated"));
					emailContent = String.valueOf(((Map) accessId)
							.get("emailContent"));
			%>
			<tr>
				<td style="text-align: center; padding-left: 10px; padding-right: 10px;"
					onmouseover="showEmailContent('<bean:write
					name="accessId" property="emailContent"/>')"><bean:write
						name="accessId" property="contentName"></bean:write></td>
				<td style="text-align: center; padding-left: 10px; padding-right: 10px;"><bean:write name="accessId" property="dateCreated"
						formatKey="display.date.format"></bean:write> <%=TimeZone.getDefault().getDisplayName(true,
						TimeZone.SHORT)%></td>

				<td style="text-align: center; padding-left: 10px; padding-right: 10px;"><input type="submit" value="Edit" name="delete"
					class="ButtonStyle"
					onclick="submitForm('<%=contentId%>','<%=contentName%>','EDIT')">
					<input type="submit" value="Delete" name="delete"
					class="ButtonStyle"
					onclick="deleteConformation('<%=contentId%>', '<%=contentName%>', 'DELETE')">
				</td>
				<td style="text-align: center; padding-left: 10px; padding-right: 10px;">NO</td>
			</tr>
			<%
				count++;
			%>

		</logic:iterate>
		<tr height="8">
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>



	</table>
	<br> <br>
	<hr class="regHeader" />
	<span>-- Manage "<strong>in use</strong>" email contents --
	</span>
	<hr class="regHeader" />
	<br> <br> <span id="message1"> </span>
	<table border="0" width="90%"
		style="font-family: Tahoma; font-size: 10pt" id="customTable1">

		<tr>
			<td class="tdHeader"><b> Content Name</b></td>

			<td class="tdHeader"><b>Date Created</b></td>

			<td class="tdHeader"><b>Actions</b></td>
			<td class="tdHeader"><b>Is in Use?</b></td>
		</tr>

		<logic:iterate id="accessId" name="list1">
			<%
				contentId = String.valueOf(((Map) accessId).get("contentId"));
					contentName = String.valueOf(((Map) accessId)
							.get("contentName"));
					dateCreated = (Timestamp) (((Map) accessId).get("dateCreated"));
					emailContent = String.valueOf(((Map) accessId)
							.get("emailContent"));
					userId = String.valueOf(((Map) accessId).get("idUser"));
			%>
			<tr>
				<td style="text-align: center; padding-left: 10px; padding-right: 10px;">&nbsp;<bean:write name="accessId" property="contentName"></bean:write></td>
				<td style="text-align: center"><bean:write name="accessId"
						property="dateCreated" formatKey="display.date.format"></bean:write>
					<%=TimeZone.getDefault().getDisplayName(true,
						TimeZone.SHORT)%></td>

				<td style="text-align: center"><input
					type="submit" value="Edit" name="delete" class="ButtonStyle"
					onclick="submitForm('<%=contentId%>','<%=contentName%>','EDIT')">
				</td>
				<td style="text-align: center">YES</td>
			</tr>
			<%
				count1++;
			%>

		</logic:iterate>
		<tr height="8">
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>


	</table>
	<%
		if (count == 0) {
	%>
	<script>
	document.getElementById("message").innerHTML = "No contents found";
    document.getElementById("customTable").style.display = "none";
	</script>
	<%
		}
	%>
	<%
		if (count1 == 0) {
	%>
	<script>
	document.getElementById("message1").innerHTML = "No contents found";
    document.getElementById("customTable1").style.display = "none";
	</script>
	<%
		}
	%>
</div>
<form action="adminTimer.do">
	<input name="parameter" value="handleEmailContentDeleteEdit"
		type="hidden"> <input name="id" value="" type="hidden">
	<input name="action" value="" type="hidden">
</form>

<script>
if (document.getElementsByTagName) {
    var table = document.getElementById("customTable");
    var rows = table.getElementsByTagName("tr");
    for (i = 0; i < rows.length; i++) {
	    if (i % 2 == 0) {
		    rows[i].className = "even";
	    } else {
		    rows[i].className = "odd";
	    }
    }
}
if (document.getElementsByTagName) {
    var table = document.getElementById("customTable1");
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
