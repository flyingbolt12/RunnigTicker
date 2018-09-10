<%@ include file="jspSuper.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.lch.general.generalBeans.UserProfile"%><style>
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
<script type="text/javascript">
function submitForm(requestFor){
		document.forms[0].Next.disabled=true;
		document.forms[0].requestFor.value=requestFor;
		document.forms[0].submit();
}
</script>
<% System.out.println(request.getAttribute("isTimeSheetSubmitted")); %>
<c:if test="${not empty isTimeSheetSubmitted}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"TimeSheet Submitted" });
	</script>
</c:if>
<c:if test="${not empty hasErrorSubmitTimeSheet}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"Error Processing TimeSheet" });
	</script>
</c:if>
<c:if test="${not empty saveAsDraft}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"TimeSheet Saved as a DRAFT" });
	</script>
</c:if>
Attach Proof documents : 
<hr />
<center>
	
	<p>You can attach multiple files. <br>Drag-and-drop is supported in FF, Chrome.</p> <br>
	
	<div id="file-uploader-demo1">		
		<noscript>			
			<p>Please enable JavaScript to use file uploader.</p>
			<!-- or put a simple form for upload here -->
		</noscript>         
	</div>

	<div class="qq-upload-extra-drop-area">Drop files here too</div>
  
</center>
<br>
<hr />
<br>
<div align="center">
<%
com.lch.general.generalBeans.UserProfile up = (com.lch.general.generalBeans.UserProfile) session
.getAttribute("userProfile"); 
	String disabled = "none";
					System.out.println(request.getAttribute("saveAsDraft"));
	if((String)request.getAttribute("saveAsDraft")!=null && ((String)request.getAttribute("saveAsDraft")).equals("YES")){
		disabled = "disabled";
	}
	boolean attachImmigrationDocs = false;
	if((String)request.getAttribute("attachImmigrationDocs")!=null && ((String)request.getAttribute("attachImmigrationDocs")).equals("yes")){
		attachImmigrationDocs = true;
	}
	boolean attachOtherDocs = false;
	if((String)request.getAttribute("attachOtherDocs")!=null && ((String)request.getAttribute("attachOtherDocs")).equals("yes")){
		attachOtherDocs = true;
	}
%>
<form action="memberFunctImpl.do">
	<input type="hidden" name="userId" value="<%=((Long) request.getAttribute("userId")).intValue()%>">
	<input type="hidden" name="businessId" value="<%=((Long) request.getAttribute("businessId")).intValue()%>">
	<input type="hidden" name="parameter" value="notifyEmployer">
	<input type="hidden" name="requestFor" value="">
	<% if(attachImmigrationDocs || attachOtherDocs) {%>
		<input type="button" value=" Proceed Next " size="60" name="Next" class="ButtonStyle" onclick="submitForm('')" >
	<%} else { %>
	<% if(disabled.equals("disabled")) {%>
		<input type="button" value=" Done! Go to DashBoard " size="60" name="Next" class="ButtonStyle" onclick="submitForm('Skip')">
	<%} else { %>
	<%if(!userProfile.isHideSkipNotifyEmployerButton())  {%>
		<input type="button" value=" Notify My Employer " size="60" name="Next" class="ButtonStyle" onclick="submitForm('')" >
		<input type="button" value=" Skip Notifying Employer " size="60" name="Next" class="ButtonStyle" onclick="submitForm('Skip')">
	<% } else {%>
		<input type="button" value=" Proceed Next " size="60" name="Next" class="ButtonStyle" onclick="submitForm('')" >
	<% } %>
	<% } 
		} %>
		<%! private String buildParams(HttpServletRequest request){
		
				StringBuilder params = new StringBuilder();
				if(request.getAttribute("weeklyHrsSummaryId")!=null){
					params.append("weeklyHrsSummaryId:").append(((Long) request.getAttribute("weeklyHrsSummaryId")).intValue()).append(",");
				}
				if(request.getAttribute("userId")!=null){
					params.append("userId:").append(((Long) request.getAttribute("userId")).intValue()).append(",");
				}
				if(request.getAttribute("saveAsDraft")!=null){
					params.append("saveAsDraft:").append(((Long) request.getAttribute("saveAsDraft")).intValue()).append(",");
				}
				if(request.getAttribute("businessId")!=null){
					params.append("businessId:").append(((Long) request.getAttribute("businessId")).intValue()).append(",");
				}
				if(request.getAttribute("attachImmigrationDocs")!=null && ((String)request.getAttribute("attachImmigrationDocs")).equals("yes")){
					params.append("attachImmigrationDocs:'").append(((String) request.getAttribute("attachImmigrationDocs"))).append("',");
				}
				if(request.getAttribute("attachOtherDocs")!=null && ((String)request.getAttribute("attachOtherDocs")).equals("yes")){
					params.append("attachOtherDocs:'").append(((String) request.getAttribute("attachOtherDocs"))).append("',");
				}
				System.out.println(params.toString());
				return params.toString();
			
			}	
		%>
		
</form>
</div>
<hr />
<script src="fileUpload/fileuploader.js" type="text/javascript"></script>
 <script>        
        function createUploader(){            
            var uploader = new qq.FileUploader({
                element: document.getElementById('file-uploader-demo1'),
                action: 'fileUpload.do',
                params : {<%= buildParams(request)%>},
                debug: false,
                extraDropzones: [qq.getByClass(document, 'qq-upload-extra-drop-area')[0]]
            });           
        }
        
        // in your app create uploader as soon as the DOM is ready
        // don't wait for the window to load  
        window.onload = createUploader;     
    </script>   