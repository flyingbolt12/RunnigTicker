<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Web TimeSheets|Communication System</title>
<meta name="description" content="Online timesheets and communication systems software. RunningTicker is the easiest and quickest way to track employee time and manage timesheets. Its your own Cloud Deployed and Looks like your product. For small & medium scale businesses. Its built on Cloud - Java Platform" />
<link rel="shortcut icon" href="http://www.runningticker.com/fav.ico" />
<meta name="keywords" content="timesheet software time tracking web time sheet timekeeping timesheets timesheet software, online timesheets, web based timsheets, punch clock, timesheet software, small business timekeeping, employee timeclock, employee time card, time sheet attendance, employee time tracking" />


<link href="css/lch.css" rel="stylesheet" type="text/css" />
<link href="js/tiptip/tipTip.css" rel="stylesheet" type="text/css" />
<meta name="google-site-verification" content="T6xOf6cd8P5jcz3sJjWrqXQkuhquUFD2C0MPE3kVtSo" />
<script language="JavaScript" type="text/javascript" src="js/lch/globals.js"></script>
<script language="JavaScript" type="text/javascript" src="js/lch/ajax.js"></script>
<script language="JavaScript" src="js/lch/admin.js"></script>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script language="JavaScript" type="text/javascript" src="js/tiptip/jquery.tipTip.minified.js"></script>
<script language="JavaScript" type="text/javascript" src="js/dhtmlx/codebase/message.js"></script>

<!-- Parralox -->
<link rel="stylesheet" type="text/css" href="css/parralox/demo.css" />
<link rel="stylesheet" type="text/css" href="css/parralox/style.css" />
<script type="text/javascript" src="js/parralox/modernizr.custom.28468.js"></script>
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
</script>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-46699543-1', 'allibilli.com');
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
</style>
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


		<tr>
			<%
				if (request.getAttribute("signedout") == null) {
			%>
			<td class="tdRadial"><tiles:insert attribute="body" /></td>
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