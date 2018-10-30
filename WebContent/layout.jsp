<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<html>
<head>
<meta name="google-site-verification" content="T6xOf6cd8P5jcz3sJjWrqXQkuhquUFD2C0MPE3kVtSo" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Web TimeSheets & Communication System</title>
<meta name="description" content="Online timesheets and communication systems software. RunningTicker is the easiest and quickest way to track employee time and manage timesheets. Its your own Cloud Deployed and Looks like your product. For small & medium scale businesses. Its built on Cloud - Java Platform" />
<link rel="shortcut icon" href="http://www.runningticker.com/fav.ico" />
<meta name="keywords" content="timesheet software time tracking web time sheet timekeeping timesheets timesheet software, online timesheets, web based timsheets, punch clock, timesheet software, small business timekeeping, employee timeclock, employee time card, time sheet attendance, employee time tracking" />
<script src="js/browserVersionDector.js"></script>


<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/jquery.timer.js"></script>
<script type="text/javascript" src="js/foggy/jquery.foggy.min.js"></script>

<link href="css/lch.css" rel="stylesheet" type="text/css" />
<link href="css/adminFunctions.css" rel="stylesheet" type="text/css" />
<link href="js/tiptip/tipTip.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="js/jstree/dist/themes/default/style.min.css" />
<link rel="stylesheet" href="styles.css">

<script language="JavaScript" type="text/javascript" src="js/lch/globals.js"></script>
<script language="JavaScript" type="text/javascript" src="js/lch/ajax.js"></script>
<script language="JavaScript" src="js/lch/admin.js"></script>

<script language="JavaScript" type="text/javascript" src="js/tiptip/jquery.tipTip.minified.js"></script>
<script language="JavaScript" type="text/javascript" src="js/dhtmlx/codebase/message.js"></script>

<!-- BreadCrumb -->
<script language="JavaScript" type="text/javascript" src="js/jBreadCrumb/js/jquery.easing.1.3.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jBreadCrumb/js/jquery.jBreadCrumb.1.1.js"></script>
<link rel="stylesheet" href="js/jBreadCrumb/Styles/BreadCrumb.css" />


<!-- Parralox for home animation-->
<link rel="stylesheet" type="text/css" href="css/parralox/demo.css" />
<link rel="stylesheet" type="text/css" href="css/parralox/style.css" />
<script type="text/javascript" src="js/parralox/jquery.cslider.js"></script>
<link href='http://fonts.googleapis.com/css?family=Economica:700,400italic' rel='stylesheet' type='text/css'>

<noscript>
	<link rel="stylesheet" type="text/css" href="css/parralox/nojs.css" />
</noscript>
<!-- Parralox -->


<script type="text/javascript">
	
	$(function() {
	    
	    $('#da-slider').cslider({
	    autoplay : true,
	    bgincrement : 50,
	    interval : 10000
	    });
	    
    });
    
    $(function() {
	    $(".HTMLLINK").tipTip({
	    maxWidth : "auto",
	    edgeOffset : 10,
	    defaultPosition : 'right'
	    });
    });
    $(function() {
	    $(".square").tipTip({
	    maxWidth : "auto",
	    edgeOffset : 10,
	    defaultPosition : 'right'
	    });
    });
    $(function() {
	    $(".squareAdmin").tipTip({
	    maxWidth : "auto",
	    edgeOffset : 10,
	    defaultPosition : 'right'
	    });
    });
    
    $(function() {
	    $(".tiptip").tipTip({
	    maxWidth : "auto",
	    edgeOffset : 10,
	    defaultPosition : 'left'
	    });
    });
    
    $(document).ready(function() {
    
    	detectBrowserCompatability();
    	
    });

    var timer;
    var textUpdateTimer;
    function refresh(){
    	 document.getElementById("employeeTimesheetPendingApprovalsForm").submit();
    } 
    function stopTimerRefresh(obj){
    	timer.stop();
    	$(obj).attr("disabled", "disabled");
    	$('#startRefresh').removeAttr("disabled"); 
    	$('#startRefresh').prop('value', 'Enable Auto Refresh');
    	$.cookie('autoStartTimer','N');
    	textUpdateTimer.stop();
    }
    $(function() {
    	if ($.cookie('autoStartTimer')!=null && $.cookie('autoStartTimer') == 'Y'){
    		startTimerRefresh($('#startRefresh'));
    	}
    });
    
    function startTimerRefresh(obj){
    	
    	$.cookie('autoStartTimer','Y');
    	updateButtonValue(obj);
    	$('#stopRefresh').removeAttr("disabled"); 
    	$(obj).attr("disabled", "disabled");
    	$(obj).prop('value', 'Enable ');
    	timer = $.timer(function() {
    		refresh();
    	}, 15000);
    	
    	timer.play();
    } 

    function updateButtonValue(obj){
    	var count = 30;
    	textUpdateTimer = $.timer(function() {
    		$(obj).prop('value', 'Refreshing in '+ (--count) + ' Seconds');
    	}, 1000);
    	textUpdateTimer.play();
    }
    $( document ).ready(function() {
    	document.addEventListener('keydown', doc_keyUp, false);
    });
    function doc_keyUp(e) {

        // this would test for whichever key is 40 and the ctrl key at the same time
        // CTRL_ALT
        if (e.ctrlKey && e.keyCode == 18) {
            // call your function to do the thing
        	setPrivacyMode();
        }
    }
</script>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-48072437-1', 'runningticker.com');
  ga('send', 'pageview');

</script>

<link href="js/dhtmlx/codebase/themes/message_default.css" rel="stylesheet" type="text/css">

<link href="fileUpload/fileuploader.css" rel="stylesheet" type="text/css">

<!-- calendar stylesheet -->
<link rel="stylesheet" type="text/css" media="all" href="jscalendar-1.0/calendar-brown.css" />

<!-- main calendar program -->
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>

<!-- language for the calendar -->
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>

<!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>


<style>
.TextBoxStyle {
	font-family: Tahoma;
	font-size: 10pt;
	border: 1px solid #808080;
	padding-left: 4px;
	padding-right: 4px;
	padding-top: 1px;
	padding-bottom: 1px
}

.button {
	font-family: Tahoma;
	font-size: 8pt;
	font-weight: bold;
	border: 1px ridge #808000
}

.dhtmlx-error {
	font-weight: bold;
	color: white;
	background-color: red;
}

rect {
  fill: none;
  pointer-events: all;
}

circle {
  fill: none;
  stroke-width: 2.5px;
}
</style>
<script src="http://d3js.org/d3.v3.min.js"></script>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" link="#088080" vlink="#004080" alink="#008080" onload="resetField()">

	<table border="0" height="100%" style="font-family: Tahoma; font-size: 10pt" align="center">
		<tr>
			<td height="8%" class="tdTitle"><tiles:insert attribute="title" /></td>
		</tr>
		<tr>
			<td height="30" class="tdLinks"><tiles:insert attribute="header" /></td>
		</tr>
		<tr>
			<td height="30" class="tdNews"><tiles:insert attribute="news" /></td>
		</tr>
		<% UserProfile up = (com.lch.general.generalBeans.UserProfile) session
				.getAttribute("userProfile"); if (up!=null && up.isAdmin()) {%>
		<tr>
			<td height="30" class="tdRadial"><tiles:insert attribute="breadCrumb" /></td>
		</tr>
	<%} %>
		<tr>
			<%
				if (request.getAttribute("signedout") == null) {
			%>
			<td class="tdRadial" id="customBody"><tiles:insert attribute="body" /></td>
			<%
				} else {
			%>
			<td><tiles:insert attribute="body" /></td>
			<%
				}
			%>
		</tr>
		<%
			List<Map<String, Object>> superSettings = (List<Map<String, Object>>) application.getAttribute("superSettings");
			if (superSettings != null && superSettings.size() > 0) {
		%>
		<tr>
			<td height="30" class="tdSiteDown"><tiles:insert attribute="websiteInfo" /></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td height="10" class="tdLinks"><tiles:insert attribute="footer" /></td>
		</tr>
	</table>

</body>