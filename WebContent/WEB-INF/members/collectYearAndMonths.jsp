<%@page import="com.lch.general.enums.TimeSheetTypes"%>
<style>
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

<%!public void log(String s) {
		//System.out.println("MonthlyHrsSubmissionNew.jsp --> "+s);
	}%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>

<%
	com.lch.general.generalBeans.UserProfile userProfile = (com.lch.general.generalBeans.UserProfile) session
			.getAttribute("userProfile");
	com.lch.general.genericUtils.DateUtils du = userProfile.getDu();

	int noOfWeeks = du.getIntLastDayOfMonth() / 6;
	int startDay = du.getInt1stDayOfMonth();
	int endDay = du.getIntLastDayOfMonth();

	int dividedDays = noOfWeeks * 6;
	if (endDay - dividedDays > 3 && (startDay == 6 || startDay == 7)) {
		noOfWeeks += 1;
	}
	log("year : " + du.getYear());
	log("month : " + du.getMonth() + " : " + du.getMonthName());
	log("du.getIntLastDayOfMonth() : " + du.getIntLastDayOfMonth());
	log("du.getInt1stDayOfMonth() : " + du.getInt1stDayOfMonth());
	log("noOfWeeks : " + noOfWeeks);
	log("startDay : " + startDay);
	log("endDay : " + endDay);
%>

<%@page import="java.util.Calendar"%>
<script type="text/javascript">
var Y="Y";
var N="N";
var isToEnterOnlyMonthlyHrs = "Y";
function boxC(){
	
	var box = dhtmlx.modalbox({ 
		title:"Enter only total monthly hours?", 
		text:"<div id='form_in_box'><div><span class='dhtmlx_button'><input type='button' value='Yes' onclick='save_callback(Y,this)' style='width:120px;'><input type='button' value='No' onclick='save_callback(N,this)' style='width:120px;'></span></label></div></div>",
		width:"300px"
	});
	//timeout is necessary only in IE
	setTimeout(function(){
		//box.getElementsByTagName("input")[0].focus();	
	},1);
	
	return;
}
function save_callback(data, form)
{
	dhtmlx.modalbox.hide(form);
	isToEnterOnlyMonthlyHrs = data;
	reload();	
	
}
function reload()
{

	var url = "memberFunctImpl.do";
	document.forms[1].month.value= document.forms[0].months.value;
	document.forms[1].year.value= document.forms[0].years.value;
	document.forms[1].isToEnterOnlyMonthlyHrs.value=isToEnterOnlyMonthlyHrs;
	document.forms[1].action = url;
	document.forms[1].submit();
	
}
function cancel()
{

	var url = "genericForwardAction.do?forwardTo=members/memberFunctions.jsp";
	document.forms[1].action = url;
	document.forms[1].submit();
	
}
</script>

<form>
<table border="0" cellspacing="1"
	style="font-family: Tahoma; font-size: 10pt" align="center" >
	<tr>
		<td height="23" align="center">Select month and year and click on
		submit</td>
	</tr>
	<tr>
		<td height="23" align="center"><select name="months"
			class="EmployeeTextBox">
			<%
				String monthNames[] = du.getMonthNames();
				for (int i = 0; i < monthNames.length - 1; ++i) {
					String select = ((monthNames[i]).startsWith(du.getMonthName())) ? ("selected")
							: ("");
			%>
			<option value="<%=i%>""<%=select%>"><%=monthNames[i]%></option>
			<%
				}
			%>

		</select> <select name="years" class="EmployeeTextBox">
			<%
				int selectedYear = du.getYear();
				int thisYear = Calendar.getInstance().get(Calendar.YEAR);
				int year1 = thisYear;
				int year2 = selectedYear;

				log("thisYear : " + thisYear);
				log("selectedYear : " + selectedYear);
				if (thisYear > selectedYear) {
					year1 = selectedYear;
					year2 = thisYear;
				}
				if (selectedYear == thisYear) {
					year1 = thisYear;
					year2 = thisYear - 1;
				}
			%>
			<option value="<%=year1%>" selected><%=year1%></option>
			<option value="<%=year2%>"><%=year2%></option>
		</select></td>
	</tr>
	<tr>
		<td height="23" align="right">
		<% if(userProfile.getTimeSheetConfiguredTo().equals(TimeSheetTypes.MONTHLY.name())) {%>
			<input type="button" value="Submit" class="ButtonStyle" onclick="boxC()" id="timeSheetSubmit">
			<%} else { %>
			<input type="button" value="Submit" class="ButtonStyle" onclick="reload()" id="timeSheetSubmit">
			<%} %>
			<input type="button" value="Cancel" class="ButtonStyle" onclick="cancel()" id="timeSheetSubmitCancel">
		</td>
	</tr>
</table>
</form>
<form name="reloadForm" action="" method="post">
<input type="hidden" value="" name="month">
<input type="hidden" value="" name="year">
<input type="hidden" value="" name="isToEnterOnlyMonthlyHrs">
<input type="hidden" value="<%= request.getAttribute("methodName")%>" name="parameter">
</form>




