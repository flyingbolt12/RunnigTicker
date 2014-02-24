<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<style>
.HTMLLINK { text-decoration:none;font-family: Tahoma; font-size: 10pt; color: #008080; 
               padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }
</style>
<div align="center">
<br><br><br>
<table border="0">


<tr><td>
<font face="Times New Roman">»</font>
<html:link href="javascript:openNewWindow('downloadMemberReports.do?parameter=downloadEmpApprovedTimeSheets')" styleClass="HTMLLINK" title="You can download all my approved time sheets">Download all my Approved time sheets</html:link><td></tr>
<tr><td>
<font face="Times New Roman">»</font>
<html:link href="javascript:openNewWindow('downloadMemberReports.do?parameter=downloadEmpPndgTimeSheets')" styleClass="HTMLLINK" title="You can download all my pending time sheets">Download all my Pending time sheets</html:link></td></tr>
<tr><td>
<font face="Times New Roman">»</font>
<html:link href="javascript:openNewWindow('downloadMemberReports.do?parameter=downloadEmpRjctedTimeSheets')" styleClass="HTMLLINK" title="You can download all my rejected time sheets">Download all my Rejected time sheets</html:link></td></tr>
<tr><td>
<font face="Times New Roman">»</font>
<html:link href="javascript:openNewWindow('downloadMemberReports.do?parameter=downloadEmpTimeSheets')" styleClass="HTMLLINK" title="You can download all my submitted time sheets">Download all my time sheet submissions</html:link></td></tr>
</table>
<br><br><br>
</div>

<script language="JavaScript">
 
 function openNewWindow(url) {
 popupWin = window.open(url, 'Reports', ', , , , , scrollbars, resizable, dependent, width=740, height=500, left=200, top=200')
 }
 
 </script>