<%@page import="com.lch.general.genericUtils.Days15TimeSheetHours"%>
<%@page import="com.lch.general.genericUtils.SubMissionType"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.lch.general.enums.SubmissionFor"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@page import="com.lch.general.constants.GeneralConstants"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.slf4j.Logger"%>

<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@page import="com.lch.spring.BusinessComponents.DoTransaction"%>

<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<%!
public void log(String s) {
	//System.out.println("MonthlyHrsSubmissionNew.jsp --> "+s);
}
%>

<%
	com.lch.general.generalBeans.UserProfile userProfile = (com.lch.general.generalBeans.UserProfile) session
			.getAttribute("userProfile");

	com.lch.general.genericUtils.DateUtils du = userProfile.getDu();	
	GenericXmlApplicationContext ctx = (GenericXmlApplicationContext)getServletContext().getAttribute("ctx");
	DoTransaction doTransaction = (DoTransaction)ctx.getBean("doTransaction");
	
	if(du==null)
		return;
	int noOfWeeks = 3;
	int startDay = 16;
	int endDay = du.getIntLastDayOfMonth();
	int printStartDay = du.getDayOfWeekMidDayOfMonth();
	int startWithWeekNo = 1;
	
	if(printStartDay == 1)
		startWithWeekNo = 4;
	else
		startWithWeekNo = 3;
	
	int daysRemaining = endDay - (startDay - 1);
	
	if ( daysRemaining % 7 > 0){
		noOfWeeks = ((endDay - startDay) / 7) + 1;
		if(printStartDay == 7)
			++noOfWeeks;
	}
	else
	{
		noOfWeeks = (daysRemaining) / 7;
		if(printStartDay > 1)
			++noOfWeeks;
	}
	
	long nUserId = userProfile.getUserId();
	int nYear =du.getYear();
	int nMonth = du.getMonth();
	

Days15TimeSheetHours hrs = doTransaction.getHalfOfMonthHrs(nUserId, nYear, nMonth, startWithWeekNo, 6, SubmissionFor.SECOND);

double regularHrs[] = { 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00 };
double overTimeHrs[] = { 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00 };
double holidayHrs[] = { 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00 };
	
%>

<script type="text/javascript">
var rA =[];
var hA = [];
var oA= [];
var fIndex =-1; 
function reload(pageTo)
{
	var isDisableLink = '<%= (String)request.getAttribute("isDisableLink")%>';
	if(isDisableLink == 'TRUE')
	{
		alert('You alreday submitted. You can\'t modify again.');
		return;	
	}
	var url = "memberFunctImpl.do";
	document.forms[1].month.value= document.forms[0].months.value;
	document.forms[1].year.value= document.forms[0].years.value;
	if(pageTo != null)
	{
		document.forms[1].pageTo.value= pageTo;
		document.forms[1].parameter.value = 'reload15DaysHrsSubmissionFromTimeSheetPage';
	}
	else
	{
		document.forms[1].parameter.value = 'reload15DaysHrsSubmissionForMonthAndYear';
	}
	document.forms[1].action = url;
	document.forms[1].submit();
	
}

function reCalculate()
{
	overLoadedReCalculate('REGULARWEEK');
	overLoadedReCalculate('OVERTIMEWEEK');
	overLoadedReCalculate('HOLIDAYWEEK');
}

function overLoadedReCalculate(weekType)
{
	var noOfWeeks =<%=noOfWeeks%>;
	var startDay = <%=startDay%>;
	var endDay = <%=endDay%>;
	var printStartDay = <%= printStartDay%>;
	var startWithWeekNo = <%= startWithWeekNo%>;
	var isToProceed = false;
	
	totalDays=startDay-1;
	var monthlyTotal=0;
	for(weekNumber=startWithWeekNo;weekNumber<=(noOfWeeks+startWithWeekNo);++weekNumber)
	{
		var weekTotal = 0;
		for(regularDay=1;regularDay<=7;++regularDay)
		{
			
			if(printStartDay == regularDay)
			{
				isToProceed = true;
			}
			
			if(isToProceed)
			{
				++totalDays;
				
				if(weekNumber==1 && regularDay<printStartDay)
				{
					regularDay=printStartDay;
				}
				
				var x='document.forms[0].'+weekType+'_'+weekNumber+'_'+regularDay;
				x = eval(x);
				if(!x)
					continue;
				weekTotal +=eval(x.value);
				
				if(regularDay==7 || (totalDays == endDay))
				{
					var x='document.forms[0].'+weekType+'_TOTAL'+weekNumber;
					x = eval(x);
					x.value=parseFloat(weekTotal).toFixed(2);
					dataAlert(x.value);
						if(totalDays == endDay)
						{
							break;
						};
				};
			};
		}
		monthlyTotal+=weekTotal;
		x='document.forms[0].'+weekType+'_MONTHLY_TOTAL';
		x = eval(x);
		x.value=parseFloat(monthlyTotal).toFixed(2);
	}	
	document.forms[0].MONTHLY_TOTAL.value=parseFloat((eval(document.forms[0].REGULARWEEK_MONTHLY_TOTAL.value) + eval(document.forms[0].OVERTIMEWEEK_MONTHLY_TOTAL.value) + eval(document.forms[0].HOLIDAYWEEK_MONTHLY_TOTAL.value))).toFixed(2);
}
function doValidate()
{ 
	if(document.forms[0].MONTHLY_TOTAL.value == 0)
		dhtmlx.confirm({ title: "Information", text:"Nothing chnaged to Submit"});
	else if(textValueValidate()){
		document.forms[0].submitTimeSheet.disabled=true;
  		document.forms[0].submit();
	}
	else
		dhtmlx.confirm({ title: "Information", text:"You entered either more than 24hrs per day or more than 60 minutes per day along with your Hours. Please correct "+ errorWith});
}
function cancelHrs()
{ 
  document.forms[0].action="memberFunctImpl.do";
  document.forms[0].parameter.value="cancelSubmitHrs";
  document.forms[0].submit();
}
</script>

<style>
<!--
.TextBox        { font-family: Tahoma; font-size: 10pt; border: 1px solid #000080; 
               padding-left: 4px; padding-right: 4px; padding-top: 1px; 
               padding-bottom: 1px; text-align:center }
-->
</style>

<html:form action="monthlyHrsSave.do" method="post">
<input type=hidden name="noOfWeeks" value="<%=noOfWeeks%>">
<input type="hidden" name="parameter" value="">
<input type="hidden" name="submissionFor" value="<%= SubmissionFor.SECOND%>">
<%@include file="/WEB-INF/members/timSheetHint.jsp"  %>
<div align="center">
<table border="0" cellspacing="1" width="878" height="447" style="font-family: Tahoma; font-size: 10pt" bgcolor="#E6E6EC">
	<tr>
		<td colspan="6" align="left" bgcolor="#C0C0C0" title="Click here to change the Employer"><html:link action="/genericForwardAction.do?forwardTo=members/updateMyClientOptions" >Client Working For  <%=userProfile.getCurrentClientName()%></html:link></td>
		<td colspan="6" align="right" bgcolor="#C0C0C0"> <html:link href="javascript:reload('first15DaysOfMonthDef')">Move to First Half of Month</html:link> &nbsp;&nbsp;&nbsp;
		<html:select property="months" styleClass="TextBox" onchange="reload()">
		<%
			String monthNames[] = du.getMonthNames();
					for (int i = 0; i < monthNames.length - 1; ++i) {
						String select = ((monthNames[i]).startsWith(du.getMonthName())) ? ("selected=\"selected\""): ("");
		%>
				<option value="<%=i%>" <%=select%>><%=monthNames[i]%></option>
		<%
			}
		%>

		</html:select>
		<html:select property="years" styleClass="TextBox" onchange="reload()">
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
		<option value="<%=year2%>" ><%=year2%></option>
		</html:select></td>
	</tr>
	<tr>
		<td bgcolor="#F8F8F8" colspan="3" width="151">&nbsp;</td>
		<td bgcolor="#808080" align="center"><font color="#FFFFFF">Sun</font></td>
		<td bgcolor="#808080" align="center"><font color="#FFFFFF">Mon</font></td>
		<td bgcolor="#808080" align="center"><font color="#FFFFFF">Tue</font></td>
		<td bgcolor="#808080" align="center"><font color="#FFFFFF">Wed</font></td>
		<td bgcolor="#808080" align="center"><font color="#FFFFFF">Thu</font></td>
		<td bgcolor="#808080" align="center"><font color="#FFFFFF">Fri</font></td>
		<td bgcolor="#808080" align="center"><font color="#FFFFFF">Sat</font></td>
		<td height="8" bgcolor="#808080" align="center" width="5">&nbsp;</td>
		<td height="8" bgcolor="#808080" align="center" width="112">
		<font color="#FFFFFF">Weekly Total</font></td>
	</tr>

	<tr>
		<td bgcolor="#FFFFFF" colspan="12" height="12" width="868">&nbsp;</td>
		</tr>

<%
double weeklyTotalHrs = 0.00; 
double monthlyTotalHrs = 0.00;
double regularMonthlyTotalHrs = 0.00;
double overtimeMonthlyTotalHrs = 0.00; 
double holidayMonthlyTotalHrs = 0.00;
double value=0.00;
		int textBoxName = 15;
		int overtimeTextBoxName = 15;
		int holidayTextBoxName = 15;
		int dateCount = 0;
		boolean isDatePrint = false;
		boolean isTextBoxPrint = false;
		boolean isOvertimeTextBoxPrint = false;
		boolean isHolidayTextBoxPrint = false;
		int printDay = 15;

		DecimalFormat df = new DecimalFormat("#.##");		
		for (int i = startWithWeekNo; i < noOfWeeks+startWithWeekNo; ++i) {
			
			if(hrs!=null)
			{
				regularHrs = hrs.getHours(i, SubMissionType.REGULAR);
				overTimeHrs= hrs.getHours(i, SubMissionType.OVERTIME);
				holidayHrs= hrs.getHours(i, SubMissionType.HOLIDAY);
			}
%>

	<tr>
		<td rowspan="4" bgcolor="#C0C0C0" align="center">Week <%=i%></td>
		<td bgcolor="#C0C0C0" align="right" width="85">&nbsp;</td>
		<td bgcolor="#F8F8F8" align="center" width="7">&nbsp;</td>
<%
	for (int daysInWeek = 1; daysInWeek <= 7; ++daysInWeek) {
				weeklyTotalHrs = 0;
%>
		<td bgcolor="#808080" align="center"><font color="#FFFFFF">
		<%
			if (daysInWeek == printStartDay) {
							isDatePrint = true;
						}

						if (isDatePrint) {
							++printDay;
							if (printDay <= endDay) {
								String printStr = printDay + "-"
										+ du.getMonthName() + "-"
										+ du.getYear();
								
		%><%=printStr%><%
			}
						}
		%></font></td>
<%
	}
%>
		<td height="18" bgcolor="#F8F8F8" width="5">&nbsp;</td>
		<td height="18" bgcolor="#C0C0C0" width="112">&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#C0C0C0" align="right" width="85">Regular Hrs</td>
		<td bgcolor="#F8F8F8" align="center" width="7">&nbsp;</td>

	<%
		weeklyTotalHrs = 0;
	
		for (int daysInWeek = 1; daysInWeek <= 7; ++daysInWeek) {
			
			value = 0;
			if(hrs!=null) {
				value = regularHrs[daysInWeek-1];
			}else {
				 if( daysInWeek > 1 && daysInWeek < 7 ) {
						value = 8.00;
					}
			}

	%>
		<td bgcolor="#C0C0C0" align="center">
	<%
		if (daysInWeek == printStartDay) {
						isTextBoxPrint = true;
					}
					if (isTextBoxPrint) {
						++textBoxName;
						if (textBoxName <= endDay) {
								weeklyTotalHrs += value;
								monthlyTotalHrs += value;
								regularMonthlyTotalHrs += value;								
	%>
		<input type="text" name="REGULARWEEK_<%=i%>_<%=daysInWeek%>" size="5" value="<%= df.format(value)%>" class="TextBox" maxlength="5" onchange="reCalculate()"><%
			}
						}
		%></td>
<%
	}
%>
		
		<td height="22" bgcolor="#F8F8F8" align="center" width="5">
		&nbsp;</td>
		<td height="22" bgcolor="#C0C0C0" align="center" width="112">
		<input type="text" name="REGULARWEEK_TOTAL<%=i%>" size="5" value="<%= df.format(weeklyTotalHrs)%>" class="TextBox" readonly="readonly"></td>
	</tr>
	
	
	
	
	
		
	
	
		<tr>
		<td bgcolor="#C0C0C0" align="right" width="85">Holiday Hrs</td>
		<td bgcolor="#F8F8F8" align="center" width="7">&nbsp;</td>
<%
	weeklyTotalHrs = 0;
	for (int daysInWeek = 1; daysInWeek <= 7; ++daysInWeek) {
		
		value = 0;
		if(hrs!=null) {
			value = holidayHrs[daysInWeek-1];
		}else {
			 if( daysInWeek > 1 && daysInWeek < 7) {
					value = 0.00;
				}
		}
		
%>
		<td bgcolor="#C0C0C0" align="center">
		<%
			if (daysInWeek == printStartDay) {
							isHolidayTextBoxPrint = true;
						}
						if (isHolidayTextBoxPrint) {
							++holidayTextBoxName;
							if (holidayTextBoxName <= endDay) {
									weeklyTotalHrs += value;
									monthlyTotalHrs += value;
									holidayMonthlyTotalHrs += value;
		%>
		<input type="text" name="HOLIDAYWEEK_<%=i%>_<%=daysInWeek%>" size="5" value= <%=  df.format(value) %> class="TextBox" maxlength="5" onchange="reCalculate()"><%
			}
						}
		%></td>
<%
	}
%>
		<td height="22" bgcolor="#F8F8F8" align="center" width="5">
		&nbsp;</td>
		<td height="22" bgcolor="#C0C0C0" align="center" width="112">
		<input type="text" name="HOLIDAYWEEK_TOTAL<%=i%>" size="5" value=<%=  df.format(weeklyTotalHrs) %> class="TextBox" readonly="readonly"></td>
	</tr>
	
	
	
	
	
	
	
	
	
	
	
	
	<tr>
		<td bgcolor="#C0C0C0" align="right" width="85">Over Time Hrs </td>
		<td bgcolor="#F8F8F8" align="center" width="7">&nbsp;</td>
<%
	weeklyTotalHrs = 0;

	for (int daysInWeek = 1; daysInWeek <= 7; ++daysInWeek) {
		value = 0;
		if(hrs!=null) {
			value = overTimeHrs[daysInWeek-1];
		}else {
			 if( daysInWeek > 1 && daysInWeek < 7) {
					value = 0.00;
				}
		}		
%>
		<td bgcolor="#C0C0C0" align="center">
		<%
			if (daysInWeek == printStartDay) {
							isOvertimeTextBoxPrint = true;
						}
						if (isOvertimeTextBoxPrint) {
							++overtimeTextBoxName;
							if (overtimeTextBoxName <= endDay) {
								
									weeklyTotalHrs += value;
									monthlyTotalHrs += value;
									overtimeMonthlyTotalHrs += value;
								
		%>
		<input type="text" name="OVERTIMEWEEK_<%=i%>_<%=daysInWeek%>" size="5" value=<%=  df.format(value) %> class="TextBox" maxlength="5" onchange="reCalculate()"><%
			}
						}
		%></td>
<%
	}
%>
		<td height="22" bgcolor="#F8F8F8" align="center" width="5">
		&nbsp;</td>
		<td height="22" bgcolor="#C0C0C0" align="center" width="112">
		<input type="text" name="OVERTIMEWEEK_TOTAL<%=i%>" size="5" value=<%=  df.format(weeklyTotalHrs) %> class="TextBox" readonly="readonly"></td>
	</tr>
	
	
	
	<tr>
		<td bgcolor="#FFFFFF" align="center" colspan="2" height="18" width="144">&nbsp;</td>
		<td bgcolor="#FFFFFF" align="center" colspan="9" height="18" width="612">&nbsp;</td>
		<td bgcolor="#FFFFFF" align="center" height="18" width="112">&nbsp;</td>
		</tr>
<%
	}
%>
	<tr>
		<td width="841" colspan="12">&nbsp;</td>
	</tr>

	<tr>
		<td bgcolor="#C0C0C0" colspan="11">
		<p align="right">Total Regular Hrs:&nbsp;&nbsp;&nbsp;&nbsp; </td>
		<td height="22" width="112" bgcolor="#C0C0C0" align="center">
		<input type="text" name="REGULARWEEK_MONTHLY_TOTAL" size="5" value="<%= df.format(regularMonthlyTotalHrs)%>" class="TextBox" readonly="readonly"></td>
	</tr>
	<tr>
		<td bgcolor="#C0C0C0" colspan="11">
		<p align="right">Total Holiday Hrs:&nbsp;&nbsp;&nbsp;&nbsp; </td>
		<td height="22" width="112" bgcolor="#C0C0C0" align="center">
		<input type="text" name="HOLIDAYWEEK_MONTHLY_TOTAL" size="5" value="<%= df.format(holidayMonthlyTotalHrs)%>" class="TextBox" readonly="readonly"></td>
	</tr>
	
	<tr>
		<td bgcolor="#C0C0C0" colspan="11">
		<p align="right">Total OverTime Hrs:&nbsp;&nbsp;&nbsp;&nbsp; </td>
		<td height="22" width="112" bgcolor="#C0C0C0" align="center">
		<input type="text" name="OVERTIMEWEEK_MONTHLY_TOTAL" size="5" value="<%= df.format(overtimeMonthlyTotalHrs)%>" class="TextBox" readonly="readonly"></td>
	</tr>
	<tr>
		<td bgcolor="#C0C0C0" colspan="11">
		<p align="right">Total Monthly Hrs:&nbsp;&nbsp;&nbsp;&nbsp; </td>
		<td height="22" width="112" bgcolor="#C0C0C0" align="center">
		<input type="text" name="MONTHLY_TOTAL" size="5" value="<%= df.format(monthlyTotalHrs)%>" class="TextBox" readonly="readonly"></td>
	</tr>
			<%String errMsg="";%>
		<html:messages id="err_name" property="msg">
			<% errMsg = err_name; %>
<tr><td align="center" colspan="2" height="40" style="vertical-align:middle; " class="stopTimeSheetSbmitErrorMsg"><img src="images/important.png" width=32 height=32/> </td><td align="center" colspan="10" height="40" style="vertical-align:middle; " class="stopTimeSheetSbmitErrorMsg">
	<%= errMsg %>
</td> </tr>
</html:messages>
<logic:messagesNotPresent>
	
	<tr>
		<td bgcolor="#C0C0C0" colspan="12">
		<%
			String submitType = "Submit";
			String isTimeSheetEdit2 = (String)request.getAttribute("isTimsheetEdit");
			
			if( (isTimeSheetEdit2 != null) && isTimeSheetEdit2.equalsIgnoreCase("TRUE"))
			{
				submitType = "Update";
			}			
		%>		
		<input type="hidden" value="<%=submitType %>" name="timeSheetMode">
		<p align="right">&nbsp;<input type="button" value=<%= submitType %> id="submitTimeSheet" onclick="doValidate()" class="ButtonStyle">
		<input type="reset" value="Reset" name="B2" class="ButtonStyle">
		<input type="button" value="Cancel" name="B3" onclick="cancelHrs()" class="ButtonStyle"></td>
		</tr>
</logic:messagesNotPresent>
</table>
</div>
</html:form>
<form name="reloadForm" action="">
<input type="hidden" value="" name="month">
<input type="hidden" value="" name="year">
<input type="hidden" value="<%= GeneralConstants.SECOND_15_DAYS_OF_MONTH %>" name="pageFrom">
<input type="hidden" value="" name="pageTo">
<input type="hidden" value="reload15DaysHrsSubmissionFromTimeSheetPage" name="parameter">
</form>

