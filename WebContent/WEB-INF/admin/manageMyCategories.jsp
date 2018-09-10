<%@page import="com.lch.general.enums.TimeSheetStatus"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>

.ui-dialog-osx {
    -moz-border-radius: 0 0 8px 8px;
    -webkit-border-radius: 0 0 8px 8px;
    border-radius: 0 0 8px 8px; border-width: 0 8px 8px 8px;
}

</style>

<%@page import="java.util.Map"%>
<c:if test="${not empty status}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"<%= request.getAttribute("status")%>" });
	</script>
</c:if>

<div align="center">

<hr class="regHeader" />
	<span>-- Manage "<strong>My Employee Categories</strong>" --
	</span>
	<hr class="regHeader" />
	
	<table border="0" width="100%" style="font-family: Tahoma; font-size: 10pt">
		
		<tr>
			<td class="tdHeader"><b>Sl., No</b></td>
			<td class="tdHeader"><b>Category Name</b></td>
			<td class="tdHeader"><b>Description</b></td>
			<td class="tdHeader"><b>Actions</b></td>
			<td class="tdHeader"><b>Associated Employees</b></td>
			<td class="tdHeader"><b>Association</b></td>
		</tr>
		<%
			String color = "red";
		%>
		<%
			int count = 0;
		%>
		<logic:iterate id="iterator" name="listAllMyCategories"
			indexId="id">

			<%
				if (id.intValue() % 2 == 0) {
						color = "#F4F4F4";
					} else {
						color = "#FFFFFF";
					}
			%>
			<%
				
					String idcategories = String.valueOf(((Map) iterator)
							.get("idcategories"));
			
					String catName = String.valueOf(((Map) iterator)
					.get("name"));
					
			%>
			<tr style="background-color: <%=color%>" >
				<td height="20" align="center">${id + 1}</td>
				<td height="20" align="center" nowrap="nowrap"><bean:write name="iterator" property="name"  ></bean:write></td>
				<td height="20" align="center" ><bean:write name="iterator" property="description"></bean:write></td>
				<td height="20" align="center" bordercolor="#F4F4F4" nowrap="nowrap">
				<% if(!catName.equalsIgnoreCase("SystemDefault")) {%>
				 <span id="span_<%=idcategories%>">
					<input type="button" value="Delete" class="ButtonStyle" onclick="buildRequestAndSend('<%=idcategories%>')">
					<input type="button" value="Edit" class="ButtonStyle" onclick="editCategory('<%=idcategories%>', '<bean:write name="iterator" property="name"></bean:write>', '<bean:write name="iterator" property="description"></bean:write>')">
				</span>
				<%} %>
				</td>
				<td  align="center"><bean:write
						name="iterator" property="numberOfEmployees"></bean:write></td>
				<td  align="center">
				<% if(!catName.equalsIgnoreCase("SystemDefault")) {%><span id="span_<%=idcategories%>_UpdateAssociation"><input type="button" value="Update Employee Association" class="ButtonStyle" onclick="association('<%=idcategories%>')"></span><% }%>
				</td>
			</tr>
			<%
				count++;
			%>

		</logic:iterate>
			<tr>
				<td  colspan="5" align="right">
				<input type="button" value="Add Category" class="ButtonStyle" onclick="addCategory()">
				<input type="button" value="Go Back" class="ButtonStyle" onclick="goToAdminFunctionsPage()">
				</td>
			</tr>
	</table>
	
</div>


<div id="dialog-message" title="Enter Name and Description" style="display: none;">

    <table border="0" cellspacing="1" style="font-family: Tahoma; font-size: 10pt" class="registration" width="100%">
			<tr>
				<td align="left"><span class="spanStyle">Name<font color="#FF0000">*</font></span></td>
				<td colspan="2" align="left"><input type="text" class="businessName" id="name"/></td>
			</tr>
			<tr>
				<td align="left"><span class="spanStyle">Description<font color="#FF0000">*</font></span></td>
				<td colspan="2" align="left"><textarea rows="3" cols="35" class="businessName" id="desc"></textarea> </td>
			</tr>
	</table>
	
</div>

<form action="adminFunctImpl.do" method="post">
<input type = "hidden" name="parameter" id="_parameter">
<input type = "hidden" name="_name" id="_name">
<input type = "hidden" name="_desc" id="_desc">
<input type = "hidden" name="_idcategories" id="_idcategories">
</form>

<form action="genericForwardAction.do?forwardTo=admin/adminFunctions.jsp" method="post" name="goToAdminFunctions">
</form>
<script>

function goToAdminFunctionsPage() {
	document.getElementsByName("goToAdminFunctions")[0].submit();
}
function confirmlink(titleHead, msg, id) {

	dhtmlx.confirm({ title: titleHead, text:msg, ok:"Yes", cancel:"No", callback:function(result){ 
		  		var params = {
				    idcategories : id
			    };
			    var obj = {
			    id : 'span_'+id,
			    url : "adminFunctImpl.do?parameter=deleteCategory",
			    params : params,
			    responseHandler : handleEmpResponse
			    };
			    sendAjaxRequest(obj);
	 }});
	
}

function association(idcategories){
	$("#_parameter").val("getAllEmployeesForAssociation");
	$("#_idcategories").val(idcategories);
	document.forms[0].submit();
}

function addCategory() {

	$("#name").val("");
	$("#desc").val("");
	
	$("#dialog-message").dialog({
	    modal: true,
	    draggable: false,
	    resizable: false,
	    position: ['center', 'top'],
	    show: 'blind',
	    hide: 'blind',
	    width: 400,
	    dialogClass: 'ui-dialog-osx',
	    buttons: {
	        "Add": function() {
	        	
	        	$("#_name").val($("#name").val());
	        	$("#_desc").val($("#desc").val());
	        	$("#_parameter").val("addCategory");
	        	
	        	$(this).dialog("close");
	        	
	        	document.forms[0].submit();
	            
	        },
	        "Cancel": function() {
	            $(this).dialog("close");
	        }
	    }
	});
}
function editCategory(id, name, description) {

	$("#dialog-message").dialog({
	    modal: true,
	    draggable: false,
	    resizable: false,
	    position: ['center', 'top'],
	    show: 'blind',
	    hide: 'blind',
	    width: 400,
	    dialogClass: 'ui-dialog-osx',
	    buttons: {
	        "Update": function() {
	        	
	        	$("#_name").val($("#name").val());
	        	$("#_desc").val($("#desc").val());
	        	$("#_parameter").val("updateCategory");
	        	$("#_idcategories").val(id);
				//($("#_name").val());
				
	        	$(this).dialog("close");
	        	
	        	document.forms[0].submit();
	            
	        },
	        "Cancel": function() {
	            $(this).dialog("close");
	        }
	    }
	});
	
	$("#name").val(name);
	$("#desc").val(description);
	
}

function buildRequestAndSend(id) {

	var msg = "Do you want to delete this category permanently? Employees and their timesheets will resets to default.";
	var title =  "Confirmation Needed";
	confirmlink(title,msg, id);
}

function handleEmpResponse(obj, response) {
    removeAjaxImg(obj.id);
    placeAjaxMessage(obj.id, response);
    placeAjaxMessage(obj.id+"_UpdateAssociation", response);
}



</script>
