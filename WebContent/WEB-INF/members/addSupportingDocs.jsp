
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
<c:if test="${isTimeSheetSubmitted == 'yes'}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"TimeSheet Submitted" });
	</script>
</c:if>

Attach Proof documents : 
<hr />
<center>
	
	<p>To upload a file, click on the button below. <br>Drag-and-drop is supported in FF, Chrome.</p> <br>
	<p>Progress-bar is supported in FF3.6+, Chrome6+, Safari4+</p>
	
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
<form action="memberFunctImpl.do">
	<input type="hidden" name="userId" value="<%=((Long) request.getAttribute("userId")).intValue()%>">
	<input type="hidden" name="businessId" value="<%=((Long) request.getAttribute("businessId")).intValue()%>">
	<input type="hidden" name="parameter" value="notifyEmployer">
	<input type="hidden" name="requestFor" value="">
	<input type="button" value=" Notify My Employer " size="60" name="Next" class="ButtonStyle" onclick="submitForm('')">
	<input type="button" value=" Skip Notifying Employer " size="60" name="Next" class="ButtonStyle" onclick="submitForm('Skip')">
</form>
</div>
<hr />
<script src="fileUpload/fileuploader.js" type="text/javascript"></script>
 <script>        
        function createUploader(){            
            var uploader = new qq.FileUploader({
                element: document.getElementById('file-uploader-demo1'),
                action: 'fileUpload.do',
                params : {weeklyHrsSummaryId:<%=((Long) request.getAttribute("weeklyHrsSummaryId")).intValue()%>, userId:<%=((Long) request.getAttribute("userId")).intValue()%>, businessId:<%=((Long) request.getAttribute("businessId")).intValue()%>},
                debug: false,
                extraDropzones: [qq.getByClass(document, 'qq-upload-extra-drop-area')[0]]
            });           
        }
        
        // in your app create uploader as soon as the DOM is ready
        // don't wait for the window to load  
        window.onload = createUploader;     
    </script>   