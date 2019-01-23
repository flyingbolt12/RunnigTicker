<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<style>
<!--
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
-->
</style>
<script type="text/javascript" src="js/tinyMCE/js/tinymce/tinymce.min.js"></script>
<script type="text/javascript">
	tinymce
      .init(
	      {
	      selector : "textarea",
	      theme : "modern",
	      plugins :
		      [
		      "autolink lists link image charmap print preview hr anchor pagebreak", "searchreplace wordcount visualblocks visualchars code fullscreen", "insertdatetime media nonbreaking save table contextmenu directionality", "paste textcolor"
		      ],
	      toolbar1 : "styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
	      toolbar2 : "preview media | forecolor backcolor"
	      });
</script>

	<%
		boolean isRreadOnly = true;
		String errMsg = "";
	%>
	
<html:form action="adminTask.do?parameter=createTask" enctype="multipart/form-data">
	<table border="0" cellspacing="1" width="100%" style="font-family: Tahoma; font-size: 10pt" height="102" align="center">
		<tr>
			<td bgcolor="#808080" colspan="2">

				<p align="center">
					<b><font color="#FFFFFF">Create Task</font></b>
			</td>
		<tr>
			<td bgcolor="#EEEEEE">Task Name</td>
			<td height="18" bgcolor="#EEEEEE">
				<html:text property="taskName" styleClass="BusinessTextBox" tabindex="1" size="53" styleId="contentName"
					onblur="verifyText(this.value)"></html:text> <font color="#000000"><span id="emailNameAvailabilityCheckMsg"></span></font>
			</td>
		</tr>

		<tr>
			<td bgcolor="#EEEEEE">Task Description</td>
			<td height="18" bgcolor="#EEEEEE">
				
				<html:messages id="err_name" property="taskDescription"> <%	errMsg = err_name;  isRreadOnly = false; %>  </html:messages> 
				
				<%  if (isRreadOnly) { %>				
					<html:text property="taskDescription" styleClass="BusinessTextBox" tabindex="2" size="53" /> 
				<% } else { %> 
					<html:text property="taskDescription" styleClass="BusinessTextBox" tabindex="2" size="53">
					</html:text> <%=errMsg%> 
				<%  errMsg = ""; isRreadOnly = true; }  %>
			</td>
		</tr>


		<tr>
			<td bgcolor="#F4F4F4" height="18">Task Content</td>
			<td bgcolor="#F4F4F4" height="18">
			
				<html:messages id="err_name" property="taskContent"> <%	errMsg = err_name;  isRreadOnly = false; %>  </html:messages> 
				
				<%  if (isRreadOnly) { %>
					<html:textarea property="taskContent" styleClass="BusinessTextBox" tabindex="3" cols="50" rows="2"></html:textarea>
				<% } else { %> 
					<html:textarea property="taskContent" styleClass="BusinessTextBox" tabindex="3" cols="50" rows="2"></html:textarea> <%=errMsg%> 
				<%  errMsg = ""; isRreadOnly = true; }  %>
				
				
			</td>
		</tr>
		<tr>
			<td bgcolor="#EEEEEE" height="18">Task Reference</td>
			<td bgcolor="#EEEEEE" height="18"><font color="#FFFFFF" face="Tahoma" size="2"></font> <c:choose>
					<c:when test="${isTaskContentToUpdate == 'yes'}">
			* Note : Attachments update not supported. Delete this content and create a new one if you need.
			</c:when>
					<c:otherwise>
						<html:file property="additionalDetails" styleClass="BusinessTextBox" tabindex="3" />
					</c:otherwise>
				</c:choose></td>
		</tr>

		<tr>
			<td bgcolor="#F4F4F4" height="18">Additional Details</td>
			<td bgcolor="#F4F4F4" height="18">
				<html:messages id="err_name" property="additionalDetails"> <%	errMsg = err_name;  isRreadOnly = false; %>  </html:messages> 
				<%  if (isRreadOnly) { %>				
					<html:textarea property="additionalDetails" styleClass="BusinessTextBox" tabindex="5" cols="50" rows="2"></html:textarea>
				<% } else { %> 
					<html:textarea property="additionalDetails" styleClass="BusinessTextBox" tabindex="5" cols="50" rows="2"></html:textarea> <%=errMsg%> 
				<%  errMsg = ""; isRreadOnly = true; }  %>				
			</td>
		</tr>

		<tr>
			<td bgcolor="#EEEEEE" height="24" colspan="2" align="center"><c:choose>
					<c:when test="${isTaskContentToUpdate == 'yes'}">
						<input type="hidden" name="id" value="<%= request.getAttribute("id")%>" />
						<html:submit value="Update" property="action" styleClass="ButtonStyle" />
					</c:when>
					<c:otherwise>
						<html:submit value="Create" property="action" styleClass="ButtonStyleDisabled" styleId="cNextEmp" disabled="true"/>
					</c:otherwise>
				</c:choose> <html:button value="Cancel" property="cancel" styleClass="ButtonStyle" onclick="javascript:history.go(-1)"/></td>
		</tr>
	</table>

</html:form>

<script>

	function checkForSubmitEnable(){
		if(document.getElementById("contentName").value!=null && document.getElementById("contentName").value.trim().length > 0)
			{
			if (document.getElementById("cNextEmp").disabled) {
			    document.getElementById("cNextEmp").className = 'ButtonStyle';
			    document.getElementById("cNextEmp").disabled = false;
			}
			}
	}
	checkForSubmitEnable();
	
    function verifyText(text) {
	    var params = {
		    ajaxParam : text
	    };
	    var obj = {
	    id : "emailNameAvailabilityCheckMsg",
	    url : "adminTimer.do?parameter=checkEmailNameAvailability",
	    params : params,
	    responseHandler : handleResponse
	    };
	    sendAjaxRequest(obj);
    }

    function handleResponse(obj, response) {
	    removeAjaxImg(obj.id);
	    if (response.trim() == "Good to go a head") {
		    document.getElementById("cNextEmp").disabled = false;
		    document.getElementById("cNextEmp").className = 'ButtonStyle';
	    } else {
	    	 if (response != null)
	    		 response = response.replace("disableSubmitRequired", "");
		    placeAjaxMessage(obj.id, response);
	    }
    }
</script>