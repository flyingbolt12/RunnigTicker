<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@page import="com.lch.general.enums.TimeSheetTypes"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
 <% String isFromSearch = request.getParameter("isFromSearch");
 	String userId ="-1";
  if (Boolean.parseBoolean(isFromSearch)) { userId = request.getParameter("userId"); %>
  
  <%} %>
<link href='http://fonts.googleapis.com/css?family=ABeeZee' rel='stylesheet' type='text/css'>
<style>
.font-style {
	font-family: ABeeZee;
	color: #000000;
	font-size: 15;
	padding: 50;
	line-height: 22px;
}
.myButton {
	-moz-box-shadow:inset 0px 0px 3px 0px #9c9190;
	-webkit-box-shadow:inset 0px 0px 3px 0px #9c9190;
	box-shadow:inset 0px 0px 3px 0px #9c9190;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #b5b0ac), color-stop(1, #615951));
	background:-moz-linear-gradient(top, #b5b0ac 5%, #615951 100%);
	background:-webkit-linear-gradient(top, #b5b0ac 5%, #615951 100%);
	background:-o-linear-gradient(top, #b5b0ac 5%, #615951 100%);
	background:-ms-linear-gradient(top, #b5b0ac 5%, #615951 100%);
	background:linear-gradient(to bottom, #b5b0ac 5%, #615951 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#b5b0ac', endColorstr='#615951',GradientType=0);
	background-color:#b5b0ac;
	-moz-border-radius:7px;
	-webkit-border-radius:7px;
	border-radius:7px;
	border:1px solid #857f79;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:arial;
	font-size:11px;
	font-weight:bold;
	padding:9px 10px;
	text-decoration:none;
	text-shadow:0px 1px 4px #a8a09f;
}
.myButtonVD {
		-moz-box-shadow: 0px 1px 0px 0px #fff6af;
	-webkit-box-shadow: 0px 1px 0px 0px #fff6af;
	box-shadow: 0px 1px 0px 0px #fff6af;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffec64), color-stop(1, #ffab23));
	background:-moz-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-webkit-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-o-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-ms-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:linear-gradient(to bottom, #ffec64 5%, #ffab23 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffec64', endColorstr='#ffab23',GradientType=0);
	background-color:#ffec64;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #ffaa22;
	display:inline-block;
	cursor:pointer;
	color:#333333;
	font-family:arial;
	font-size:15px;
	font-weight:bold;
	padding:4px 10px;
	text-decoration:none;
	text-shadow:0px 1px 0px #ffee66;
}
.myButtonVD:hover {
background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffab23), color-stop(1, #ffec64));
	background:-moz-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-webkit-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-o-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-ms-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:linear-gradient(to bottom, #ffab23 5%, #ffec64 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffab23', endColorstr='#ffec64',GradientType=0);
	background-color:#ffab23;
}
.myButtonVD:active {
	position:relative;
	top:1px;
}
.myButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #615951), color-stop(1, #b5b0ac));
	background:-moz-linear-gradient(top, #615951 5%, #b5b0ac 100%);
	background:-webkit-linear-gradient(top, #615951 5%, #b5b0ac 100%);
	background:-o-linear-gradient(top, #615951 5%, #b5b0ac 100%);
	background:-ms-linear-gradient(top, #615951 5%, #b5b0ac 100%);
	background:linear-gradient(to bottom, #615951 5%, #b5b0ac 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#615951', endColorstr='#b5b0ac',GradientType=0);
	background-color:#615951;
}
.myButton:active {
	position:relative;
	top:1px;
}

        
</style>
<script src="js/jstree/dist/jstree.min.js"></script>

<link href="js/igniteui/css/themes/infragistics/infragistics.theme.css" rel="stylesheet"></link>
<link href="js/igniteui/css/structure/infragistics.css" rel="stylesheet"></link>
<script src="js/igniteui/infragistics.js"></script>
    <script>
        	var downloadUrl = 'adminFunctImpl.do?parameter=downloadAllEmployeeAttachments&userId=';
        </script>
<style> .delete-button
        {
            width: 100%;
            font-size: 1em;
            border: solid 1px #777;
            font-family: 'Segoe UI', Arial, sans-serif;
            color: #444;
        }
        .delete-button:hover
        {
            background-color: #d0edfa;
        }
</style> 

<!-- END GRID -->
<table style="height:100% ; width: 100%;">
 
  
  	<tr>
        <td rowspan="2" style="font-size: 12px;" width="30%" id="treeTd">
        
        <div id="treeDiv">
			<div class="col-md-2 col-sm-4 col-xs-4" style="position:relative; text-align: right; height: auto;">
				Search : <input type="text" value="" style="box-shadow: inset 0 0 4px #eee; width: 120px; margin: 0; padding: 6px 12px; border-radius: 4px; border: 1px solid silver; font-size: 1.1em;" id="demo_q" placeholder="Search" />
			</div>
		
			<div id="emps" style="height:90%; width:100%; overflow:scroll; "></div>
		</div>
	
        </td>
        <td height="5%" align="right">
        	<a class="myButton" href="javascript:openILCHWindow(downloadUrl, 'Downloading All Files In Progress')" id="downloadLink">Download All Listed below Files</a>
        </td>
    </tr>
    <tr>
        <td id="gridV" width="70%" height="95%">
        	<table id="grid"></table>
        </td>
    </tr>
    
 
</table>

<script>
					var to = false;
					var userId = "";
					var url = "adminFunctImpl.do?parameter=listAllEmployeeAttachments";
					$( document ).ready(function() {
					$('#demo_q').keyup(function () {
						if(to) { clearTimeout(to); }
						to = setTimeout(function () {
							var v = $('#demo_q').val();
							$('#emps').jstree(true).search(v);
						}, 250);
					});
					
					$('#emps')
					.on("changed.jstree", function (e, data) {
						if(data.selected.length) {
							document.getElementById("gridV").innerHTML = "LOADING....";
							sendReq((data.selected[0]));
						}
					})
					.on("ready.jstree", function (e, data) {
						 var userToSelect = <%= userId %>;
							  if(userToSelect!=-1) {
							 	 var instance = $('#emps').jstree(true); 
								instance.deselect_all();
								instance.select_node(userToSelect);
							  }
					})
					.jstree({
						'core' : {
							"themes" : { "stripes" : true },
							"check_callback" : true,
							'data' :  [
								{ "text" : "<%= ((UserProfile) session.getAttribute("userProfile")).getEmployerName() %>", "state" : { "opened" : true },  "children" :<%=request.getAttribute("emps") %>}
							]
						},
						"plugins" : [ "search", "types" ]
						//"plugins" : [ "search", "types", "state" ]
					
					});
					
					$("#emps").css({'height': document.getElementById("treeTd").offsetHeight -60+ 'px'});
					});
					
					
					var ajaxObj = {id:"gridV", params:"",url:"",responseHandler:processResponse};

					function sendReq(uid){
						userId = uid;
						ajaxObj.url = url;
						 var params = {
					 		    userId : uid
					 	    };
						ajaxObj.params= params;
						sendAjaxRequest(ajaxObj);
					}
					function processResponse(obj, responseText){
						downloadUrl+=userId;
						mydata = jQuery.parseJSON(responseText);
						if(mydata.length == 0)
						{
							$('downloadLink').on("click", function (e) {
						        e.preventDefault();
						    });
							document.getElementById("gridV").innerHTML = "<p class='font-style'> No Documents found for this Employee, Maye be request to upload? Use the Notifications Area Features.</p>";
						}
						else {
							showGrid();
						}
					}
	</script>
	<script>
	var d = new Date();
	var month = new Array();
	month[0] = "January";
	month[1] = "February";
	month[2] = "March";
	month[3] = "April";
	month[4] = "May";
	month[5] = "June";
	month[6] = "July";
	month[7] = "August";
	month[8] = "September";
	month[9] = "October";
	month[10] = "November";
	month[11] = "December";
	
	 function formatImage() {
		 var imageHtml = "<div style='width:100%; text-align:center'><a onclick='javascript:downloadFile(this)' href='#' class='myButtonVD' title='Download'><img src='images/download_small.png' align='center' title='Download'/></a> &nbsp; <a onclick='javascript:viewFile(this)' href='#' class='myButtonVD' title='View'> <img align='center' src='images/view_small.png' title='View'/></div>";
	      	return imageHtml;
	 }
	 function getMonth(monthNum) {
		 return month[monthNum]; 
	 }
	 
	 function downloadFile(id){
		 var vURL = 'downloadAFile.do?id='+$(id).parent().parent().parent().attr("data-id")+'&action=download';
		 dhtmlx.message({type:"error", expire:6000, text:"Check New Window." });
		 openILCHWindow(vURL,'Profile Viewer');
	 }
	 function viewFile(id){
		 var vURL = 'downloadAFile.do?id='+$(id).parent().parent().parent().attr("data-id")+'&action=view';
		 dhtmlx.message({type:"error", expire:6000, text:"Check New Window." });
		 openILCHWindow(vURL,'Profile Viewer');
	 }
	 function shareFile(id){
	    	alert($(id).parent().parent().parent().attr("data-id"));
	 }
	 var mydata;
	 function showGrid() {
     	
		 if(document.getElementById("grid") != null) {
				document.getElementById("grid").parentElement.removeChild(this);
			}
			document.getElementById("gridV").innerHTML = "<table id=\"grid\" style=\"width:100%; overflow: scroll; font-size:11px;\"></table>";
			
         $("#grid").igGrid({
             autoGenerateColumns: false,
             width: document.getElementById("gridV").offsetWidth,
             height: document.getElementById("gridV").offsetHeight -30,
             columns: [
                 { headerText: "idattacheddocs", key: "idattacheddocs", dataType: "number" },
                 { headerText: "Name", key: "docName", dataType: "string", width: "20%" },
                 //{ headerText: "Attached Date", key: "attachedDate", dataType: "date", width: "25%", format: "(ddd) MMM d, yyyy : HH:mm" },
                 { headerText: "Month", key: "month", dataType: "string", width: "25%" , template: getMonth("${month}") },
                 { headerText: "DocType", key: "docType", dataType: "string", width: "15%" },
                 { headerText: "", key: "action", dataType: "string", width: "20%",  unbound: true, template: formatImage() },
                 { headerText: "Attached Date", key: "attachedDate", dataType: "date", width: "25%", format: "(ddd) MMM d, yyyy" },
             ],
             primaryKey: "idattacheddocs",
             dataSource: mydata,
             features: [
                 {
                     name: 'GroupBy',
                     columnSettings: [
                         {
                             columnKey: "docType",
                             isGroupBy: true
                         }
                     ]
                 },
                 {
                 	name: "Hiding",
                 	columnSettings: [
                     	{ columnKey: "idattacheddocs", allowHiding: false, hidden: true },
                     	{ columnKey: "docName", allowHiding: false },
                     	{ columnKey: "month", allowHiding: false },
                     	{ columnKey: "docType", allowHiding: false },
                     	{ columnKey: "action", allowHiding: false },
                     	{ columnKey: "attachedDate", allowHiding: false },
                 	]
             	}
             ]
         });
     }
	</script>	
 
 
   