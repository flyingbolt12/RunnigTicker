<%@page import="java.util.Map"%>
<%@page import="com.lch.general.enums.TimeSheetStatus"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<% String timeSheetSupportingDocStatus = (String)request.getAttribute("timeSheetSupportingDocStatus"); %>
<% if(timeSheetSupportingDocStatus!=null && timeSheetSupportingDocStatus.equals("yes")) { %>
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"File Saved." });
	</script>
<%} %>
<% if(timeSheetSupportingDocStatus!=null && timeSheetSupportingDocStatus.equals("no")) { %>
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Invalid Document. Failed to Save." });
	</script>
<%} %>

<style>
input.inform{
			width:220px;
			margin-left:20px;
		}
		
		#form_in_box div{
			text-align:left;
		}
		.dhtmlx_button{
			margin-top:10px;
		}
.BusinessTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }


</style>

	<%
			int count = 0;
		%>
<div align="center" >
	<table border="0" cellspacing="1"  class="completeTable" id="listofDocs">
	<tr><td colspan="3" align="center"> -- Managing attachments for the type of TimeSheet -- <BR> <BR> <%=request.getAttribute("managingFor") %> <hr/></td>
	</tr>
		<tr>
			<td class="approvalsTdHeader"> File Name </td>
			<td class="approvalsTdHeader"> Attached Date </td>
			<td class="approvalsTdHeader"> Options </td>
		</tr>
<logic:iterate id="listTimeSheetsForAdmin" name="files">
		<tr>
			<td class="tdData"><bean:write name="listTimeSheetsForAdmin" property="docName"/>&nbsp;<bean:write name="listTimeSheetsForAdmin" property="middleName"/>&nbsp;<bean:write name="listTimeSheetsForAdmin" property="lastName"/></td>
			<td class="tdData"><bean:write name="listTimeSheetsForAdmin" property="attachedDate"/></td>
			<td class="tdData">
				<span id="removeAttachedDoc_<bean:write name="listTimeSheetsForAdmin" property="idattacheddocs"/>">
				<input type="button" value="Remove" class="ButtonStyle" onclick='deleteDoc(this, <bean:write name="listTimeSheetsForAdmin" property="idattacheddocs"/>)'>
				<input type="button" value="View" class="ButtonStyle" onclick='viewDoc(<bean:write name="listTimeSheetsForAdmin" property="idattacheddocs"/>)'> </span>
			</td>
		</tr>
		
		<%
				count++;
			%>
</logic:iterate>
	
	<%
		if (count == 0) {
	%>
	<tr><td class="tdData" colspan="3"><span id="message">No Attachments found, click on below button to add.</span></td></tr>
	
	<%
		}
	%>
	
	<tr><td colspan="3" class="tdData"><input type="button" name="addPoofDoc" value="Add New Proof of Document" class="ButtonStyle" onclick='uploadDoc()'> </td> </tr>
</table></div>


	
<script>
var weeklyHrsSummaryId = <%= request.getAttribute("weeklyHrsSummaryId")%>;
function deleteDoc(ele, idattacheddocs)
{
		ele.disabled = true;
		var params = {
				weeklyHrsSummaryId : weeklyHrsSummaryId,
				idattacheddocs : idattacheddocs
			    };
	    var obj = {
	    id : "removeAttachedDoc_"+idattacheddocs,
	    url : "memberFunctImpl.do?parameter=removeAttachedDoc",
	    params : params,
	    responseHandler : ajaxResponseProcess
	    };
			var result = false;    
		dhtmlx.confirm({ title: "Permanatly Delete?", text:"Not Recoverable!!", ok:"Yes", cancel:"No", callback:function(result){ 
			if (result == true) {
				//raiseRequestWithMultipleParamsAndProcessFunction("removeAttachedDoc_"+idattacheddocs,url, params,ajaxResponseProcess);
				sendAjaxRequest(obj);
			    } else {
				    return false;
			    }
		    }
		});
		result = false;
		ele.disabled = false;
}
function ajaxResponseProcess(obj, responseText)
{
	if(responseText.trim() == "Removed"){
		document.getElementById(obj.id).innerHTML = responseText;
	} else{
		document.getElementById(obj.id).innerHTML = "Something Wrong! Try again later.";
		dhtmlx.message({type:"error", expire:6000, text:"Something Wrong! Try again later." });
	}
}
function viewDoc(idattacheddocs)
{
	popupWin = window.open('downloadAFile.do?action=view&id='+idattacheddocs, 'View/Download Document', ', , , , , scrollbars, resizable, dependent, width=740, height=500, left=200, top=200');
}

function cancel_callback(box){
	dhtmlx.modalbox.hide(box);
}

function uploadDoc()
{
	var myform = dhtmlx.modalbox({ title: "Upload File", content:"form_in_box", hidden:true });
	dhtmlx.modalbox(myform);
}
</script>

<div id='form_in_box' style='display:none'>
<html:form method="post" action="timeSheetSupportingDoc.do?parameter=uploadTimeSheetSupportingDoc"  styleId="uploadDocForm" enctype="multipart/form-data">
	<input type="hidden" name="weeklyHrsSummaryId" value=<%= request.getAttribute("weeklyHrsSummaryId")%>>
	<input type="hidden" name="managingFor" value="<%= request.getAttribute("managingFor")%>">
	<input type="file" name="timeSheetSupportingDoc"/>
	<div style="width:240px">
		
		<span>
	<span class='dhtmlx_button' style="width: 100px; float: left">
	<input type="submit" value="save" style="width: 100px"/>
	</span>
		
	<span class='dhtmlx_button' style="width: 100px; float: right;">
	<input type="button" value="Cancel" onclick="cancel_callback()" style="width: 100px"/>
	</span>
	
	</span>
		
	</div>
</html:form>

	
</form>
</div>
