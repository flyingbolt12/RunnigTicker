<%@page import="com.lch.general.enums.DOCTypes"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<style>

.BusinessTextBox { font-family: Tahoma; font-size: 10pt; color: #008080; 
               border: 1px solid #808080; padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }

.HTMLLINK { text-decoration:none;font-family: Tahoma; font-size: 8pt; color: #008080; 
               padding-left: 4px; padding-right: 
               4px; padding-top: 1px; padding-bottom: 1px }
</style>
<form action="superAdminFunctImpl.do?parameter=saveOutageDetails" method="post">
<input type="hidden" name="parameter" value="saveOutageDetails" >
<div align="center">
	<table border="0" width="580" cellspacing="8" cellpadding="8" style="font-family: Tahoma; font-size: 10pt">
		<tr>
			<td colspan="2" align="center" style="background-color: #808080"><font color="#FFFFFF"><b>Outage Details</b></font></td>
		</tr>
		<tr>
			<td align="right" width="101">Outage Date</td>
			<td align="left" width="223">
			<input type="text" name="outageDate" size="12" id="outageDate" class="BusinessTextBox"> <img
					onmouseout="this.style.background=''"
					onmouseover="this.style.background='pink';" title="Date selector"
					style="border: 1px solid green; cursor: pointer;" id="f_trigger_c"
					src="jscalendar-1.0/img.gif" /> </td>
		</tr>
		<tr>
			<td align="right" width="101">Start Time</td>
			<td align="left" width="223">
			<input type="text" name="startTime" size="12" maxlength="8" class="BusinessTextBox"> EX:  12:00 PM (24 HOUR Format)</td>
		</tr>
		<tr>
			<td align="right" width="101">End Time</td>
			<td align="left" width="223">
			<input type="text" name="endTime" size="12" maxlength="8" class="BusinessTextBox"> EX : 15:00 PM (24 HOUR Format)</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="background-color: #808080">
			<input type="submit" value="Submit" class="ButtonStyle"><input type="reset" value="Reset" class="ButtonStyle"></td>
		</tr>
	</table>
</div>
</form>
<script type="text/javascript">
    Calendar.setup({
        inputField     :    "outageDate",
        ifFormat       :    "%m-%e-%Y",
        button         :    "f_trigger_c",
        align          :    "Tl",
        singleClick    :    false
    });
    
</script>