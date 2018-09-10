<%@page import="com.lch.general.enums.TimeSheetStatus"%>
<%@page import="com.lch.general.genericUtils.SubMissionType"%>
<%@page import="com.lch.general.genericUtils.MonthlyTimeSheetHours"%>
<%@page import="com.lch.general.enums.SubmissionFor"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@page import="com.lch.spring.BusinessComponents.DoTransaction"%>

<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.slf4j.Logger"%>

<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@page import="com.lch.general.constants.GeneralConstants"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%!
public void log(String s) {
	//System.out.println("MonthlyHrsSubmissionNew.jsp --> "+s);
}
%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%> 
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<%  

com.lch.general.generalBeans.UserProfile userProfile = (com.lch.general.generalBeans.UserProfile)session.getAttribute("userProfile");

com.lch.general.genericUtils.DateUtils du = userProfile.getDu();

GenericXmlApplicationContext ctx = (GenericXmlApplicationContext)getServletContext().getAttribute("ctx");

DoTransaction doTransaction = (DoTransaction)ctx.getBean("doTransaction");



String submitType = "Submit TimeSheet";
String isTimeSheetEdit = (String)request.getAttribute("isTimsheetEdit");


int noOfWeeks = du.getIntLastDayOfMonth()/6;
int startDay = du.getInt1stDayOfMonth();
int endDay = du.getIntLastDayOfMonth();
int midDayOfMonth = 15;
int[] workingHrs = new int[endDay];

int dividedDays = noOfWeeks*6;
if(endDay-dividedDays>3 && (startDay==6 || startDay ==7))
{
	noOfWeeks+=1;
}
log("year : "+du.getYear());
log("month : "+du.getMonth()+" : " + du.getMonthName());
log("du.getIntLastDayOfMonth() : "+du.getIntLastDayOfMonth());
log("du.getInt1stDayOfMonth() : "+du.getInt1stDayOfMonth());
log("startDay : "+startDay);
log("endDay : "+endDay);

if(startDay==7 && endDay>29)
{
	noOfWeeks+=1;
}
if(startDay==6 && endDay>30)
{
	noOfWeeks+=1;
}

log("monthlyHrsSubmissionNew jsp noOfWeeks : "+noOfWeeks);

boolean isProceedFurther=false;

long nUserId = userProfile.getUserId();
int nYear =du.getYear();
int nMonth = du.getMonth();

if (request.getParameter("forAdmin")!=null && request.getParameter("forAdmin").equals("YES")){
	nUserId = new Long(request.getParameter("userId")).longValue();
}

MonthlyTimeSheetHours timeSheetHours =  doTransaction.getMonthlySubmittedHrs(nUserId, nYear, nMonth);
boolean hasOnlyMonthlyHours = false;
Map<String, Object> map = null;
//Check for weekly hours summary
if(timeSheetHours == null) {
	// get hasOnlyMonthlyHours
	//if null proceed as it is. else show the box with the value;
	String weeklyHrsSummaryId = request.getParameter("weeklyHrsSummaryId");
	System.out.println(weeklyHrsSummaryId);
	if(weeklyHrsSummaryId!=null) {
		map = doTransaction.getWeeklySummeryDetails(Long.valueOf(weeklyHrsSummaryId));
		hasOnlyMonthlyHours = (((Integer)map.get("hasOnlyMonthlyHours")) == 0) ? false : true;
	}
}

double regularHrs[] = { 0.00, 8.00, 8.00, 8.00, 8.00, 8.00, 0.00 };
if(userProfile.getDefaultTimeSheetValue().equals("8.0") || userProfile.getDefaultTimeSheetValue().equals("8.00"))
{
	for (int i =0 ; i<6; ++i)
	{
		regularHrs[i] = 8.00;
	}
	regularHrs[0] = 0.00;	
	regularHrs[6] = 0.00;
}
else
{
	for (int i =0 ; i<6; ++i)
	{
		regularHrs[i] = 0.00;
	}
}

double overTimeHrs[] = { 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00 };
double holidayHrs[] = { 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00 };

 %>


<script type="text/javascript">
var rA =[];
var hA = [];
var oA= [];
var fIndex =-1; 
function reload()
{

	var url = "memberFunctImpl.do";
	document.forms[1].month.value= document.forms[0].months.value;
	document.forms[1].year.value= document.forms[0].years.value;
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
	var noOfWeeks =<%= noOfWeeks%>;
	var startDay = <%= startDay%>
	var endDay = <%= endDay %>
	totalDays=0;
	var monthlyTotal=0;
	for(weekNumber=1;weekNumber<=noOfWeeks;++weekNumber)
	{
		var weekTotal = 0;
		for(regularDay=1;regularDay<=7;++regularDay)
		{
			
			++totalDays;
			
			if(weekNumber==1 && regularDay<startDay)
			{
				regularDay=startDay;
			}
			
			var x='document.forms[0].'+weekType+'_'+weekNumber+'_'+regularDay;
			x = eval(x);
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
					}
			}
		}
		monthlyTotal+=weekTotal;
		x='document.forms[0].'+weekType+'_MONTHLY_TOTAL';
		x = eval(x);
		x.value=parseFloat(monthlyTotal).toFixed(2);
	}	
	document.forms[0].MONTHLY_TOTAL.value=parseFloat((eval(document.forms[0].REGULARWEEK_MONTHLY_TOTAL.value) + eval(document.forms[0].OVERTIMEWEEK_MONTHLY_TOTAL.value) + eval(document.forms[0].HOLIDAYWEEK_MONTHLY_TOTAL.value))).toFixed(2);
}



function cancelHrs()
{ document.forms[0].action="memberFunctImpl.do";
  document.forms[0].parameter.value="cancelSubmitHrs";
  document.forms[0].submit();
}

var previousTimeSheetMode;
function saveAsDraftFun(){
	previousTimeSheetMode = document.getElementById('timeSheetMode').value;
	document.getElementById('timeSheetMode').value = "saveAsDraft";
	doValidate();
}
function doValidate()
{ 
	if(document.forms[0].MONTHLY_TOTAL.value == 0) {
		dhtmlx.confirm({ title: "Information", text:"Nothing changed to Submit"});
		document.getElementById('timeSheetMode').value = previousTimeSheetMode;
	}
	else if(textValueValidate()){
		document.forms[0].submitTimeSheet.disabled=true;
		document.forms[0].saveAsDraft.disabled=true;
  		document.forms[0].submit();
	}
	else {
		dhtmlx.confirm({ title: "Information", width:300, text:"You entered either more than 24hrs per day or more than 60 minutes per day along with your Hours. Please correct "+ errorWith});
		document.getElementById('timeSheetMode').value = previousTimeSheetMode;
	}
}
function showHoursSubmitted(status){
	dhtmlx.alert({
		type:"alert-warning",
		text:"Hours Submitted : "+status,
		callback:function(){
			window.history.back();
		}
	});
}
<% 
	if(map!=null && hasOnlyMonthlyHours) {
		double d = (Double)map.get("totalHrsSubmitted");
	
%>
$( document ).ready(function() {
	$('#timeSheetId').foggy({
		   blurRadius: 2,          // In pixels.
		   opacity: 0.8,           // Falls back to a filter for IE.
		   cssFilterSupport: true  // Use "-webkit-filter" where available.
		 });
	showHoursSubmitted(<%= d%>);
});
	
<% }%>

function boxC(status){
	$('#timeSheetId').foggy({
		   blurRadius: 2,          // In pixels.
		   opacity: 0.8,           // Falls back to a filter for IE.
		   cssFilterSupport: true  // Use "-webkit-filter" where available.
		 });
	
	if(status == "NOT SUBMITTED")
		{
	var box = dhtmlx.modalbox({ 
		title:"Enter total monthly hours", 
		text:"<div id='form_in_box'><div><label> <input class='inform' type='text' name='totalMonthlyHrs_dis'></label></div><br><div><span class='dhtmlx_button'><input type='button' value='Submit' onclick='save_callback(this)' style='width:120px;'><input type='button' value='Cancel' onclick='cancel_callback(this)' style='width:120px;'></span></label></div></div>",
		width:"300px"
	});
		}
	else
		{
		dhtmlx.alert({
			type:"alert-warning",
			text:"TimeSheet Status : "+status,
			callback:function(){
				window.history.back();
			}
		});
		}
	//timeout is necessary only in IE
	setTimeout(function(){
		box.getElementsByTagName("input")[0].focus();	
	},1);
	
	return;
}
function updateBoxC(status){
	
	if(status == "REJECTED")
		{
	var box = dhtmlx.modalbox({ 
		title:"Update total monthly hours", 
		text:"<div id='form_in_box'><div><label> <input class='inform' type='text' name='totalMonthlyHrs_dis'></label></div><br><div><span class='dhtmlx_button'><input type='button' value='Update' onclick='save_callback(this)' style='width:120px;'><input type='button' value='Cancel' onclick='cancel_callback(this)' style='width:120px;'></span></label></div></div>",
		width:"300px"
	});
		}
	else
		{
		dhtmlx.alert({
			type:"alert-warning",
			text:"TimeSheet Status : "+status,
			callback:function(){
				window.history.back();
			}
		});
		}
	//timeout is necessary only in IE
	setTimeout(function(){
		box.getElementsByTagName("input")[0].focus();	
	},1);
	
	return;
}

function cancel_callback(form)
{
	dhtmlx.modalbox.hide(form);
	window.history.back()
	}
function save_callback(form)
{
	var totalMonthlyHrs = document.getElementsByName("totalMonthlyHrs_dis")[0].value;
	document.forms[0].totalMonthlyHrs.value=totalMonthlyHrs;
	document.forms[0].submit();
	dhtmlx.modalbox.hide(form);
	
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
<input type=hidden name="noOfWeeks" value="<%=noOfWeeks %>">
<input type="hidden" name="parameter" value="">
<input type="hidden" name="totalMonthlyHrs" value="">
<input type="hidden" name="submissionFor" value="<%= SubmissionFor.MONTHLY%>">
<%@include file="/WEB-INF/members/timSheetHint.jsp"  %>
<%! String timeSheetStatus = ""; %>
	<%
	boolean isRequestFromAdmin = (( request.getParameter("forAdmin")!=null && request.getParameter("forAdmin").equals("YES") )? true: false);
		
		TimeSheetStatus status = (TimeSheetStatus)request.getAttribute("timSheetStatus");
		if(status == null) {timeSheetStatus = "NOT SUBMITTED";} else {timeSheetStatus = status.getRep();}%>
		
		<input type="hidden" name="currentTimeSheetStatus" value="<%= timeSheetStatus%>">
<div align="center">
<table border="0" cellspacing="1" width="878" height="447" style="font-family: Tahoma; font-size: 10pt" bgcolor="#E6E6EC" id="timeSheetId" >


<%if(!isRequestFromAdmin){%>

<tr><td colspan="12" align="center" valign="middle" bgcolor="#FFFFF">TimeSheet Status : <%= timeSheetStatus %> </td></tr>
	<%} %>
	
	<tr>
		<%
 
		if(isRequestFromAdmin){
		%>
		<td colspan="6" align="left" bgcolor="#C0C0C0" title="Client Working for">Client Name : <%= request.getParameter("clientName") %></td>
		<%} else { %>
		<td colspan="6" align="left" bgcolor="#C0C0C0" title="Click here to change the Client Working for"><html:link action="/genericForwardAction.do?forwardTo=members/updateMyClientOptions">Client Working For  <%=userProfile.getCurrentClientName()%></html:link></td>
		<% } %>
		<td colspan="6" align="right" bgcolor="#C0C0C0">
		
		<html:select property="months" styleClass="TextBox" onchange="reload()" disabled="<%=isRequestFromAdmin?true:false %>">
		<% String monthNames[]= du.getMonthNames(); 
		for(int i=0; i<monthNames.length-1;++i){
			String select=((monthNames[i]).startsWith(du.getMonthName()))?("selected"):(""); 
		%>
				<option value="<%=i %>" <%=select %>><%= monthNames[i]%></option>
		<%} %>

		</html:select>
		<html:select property="years" styleClass="TextBox" onchange="reload()" disabled="<%=isRequestFromAdmin?true:false %>">
<% int selectedYear = du.getYear(); int thisYear = Calendar.getInstance().get(Calendar.YEAR);  int year1=thisYear; int year2 = selectedYear;

log("thisYear : "+thisYear);
log("selectedYear : "+selectedYear);
if(thisYear>selectedYear)
{
	year1=selectedYear;
	year2=thisYear;
}
if(selectedYear == thisYear)
{
	year1=thisYear;
	year2 = thisYear-1;
}

%>
		<option value="<%=year1 %>" selected><%=year1 %></option>
		<option value="<%=year2 %>" ><%= year2%></option>
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
double weeklyTotalHrs = 0; 
double monthlyTotalHrs = 0;
double regularMonthlyTotalHrs = 0;
double holidayMonthlyTotalHrs = 0;
double overtimeMonthlyTotalHrs = 0; 
double value=0;
int textBoxName=0;
int holidayTextBoxName=0;
int overtimeTextBoxName=0; 
int dateCount=0;
boolean isDatePrint=false; 
boolean isTextBoxPrint=false; 
boolean isOvertimeTextBoxPrint=false; 
boolean isHolidayTextBoxPrint=false;
int printDay=0;


for(int i=1; i<=noOfWeeks;++i) {
	if(timeSheetHours!=null)
	{
	regularHrs = timeSheetHours.getHours(i, SubMissionType.REGULAR);
	overTimeHrs= timeSheetHours.getHours(i, SubMissionType.OVERTIME);
	holidayHrs= timeSheetHours.getHours(i, SubMissionType.HOLIDAY);
	}
%>


	<tr>
		<td rowspan="4" bgcolor="#C0C0C0" align="center">Week <%=i %></td>
		<td bgcolor="#C0C0C0" align="right" width="85">&nbsp;</td>
		<td bgcolor="#F8F8F8" align="center" width="7">&nbsp;</td>
<% for(int daysInWeek=1;daysInWeek<=7;++daysInWeek)	{ weeklyTotalHrs = 0;%>
		<td bgcolor="#808080" align="center"><font color="#FFFFFF">
	<% if(daysInWeek==startDay){ isDatePrint=true;}if(isDatePrint){ ++printDay; if(printDay<=endDay){%><%=printDay%>-<%=du.getMonthName() %>-<%=du.getYear()%><%} }%></font></td>
<%} %>
		<td height="18" bgcolor="#F8F8F8" width="5">&nbsp;</td>
		<td height="18" bgcolor="#C0C0C0" width="112">&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#C0C0C0" align="right" width="85">Regular Hrs</td>
		<td bgcolor="#F8F8F8" align="center" width="7">&nbsp;</td>

	<% 
	for(int daysInWeek=1;daysInWeek<=7;++daysInWeek)	{  %>
		<td bgcolor="#C0C0C0" align="center">
		<% if(daysInWeek==startDay ){ 
			isTextBoxPrint=true;
			}
		if(isTextBoxPrint){
			++textBoxName;
			if(textBoxName<=endDay){
				if(daysInWeek==1 || daysInWeek ==7){
					value=0;
				}else{
					value=regularHrs[daysInWeek-1];
					weeklyTotalHrs+= value;
					//System.out.println(weeklyTotalHrs); 
					monthlyTotalHrs+=value;
					regularMonthlyTotalHrs+=value;
				}%>
	
		<input type="text" name="REGULARWEEK_<%=i %>_<%=daysInWeek  %>" size="5" value="<%= value %>" class="<%= (daysInWeek==1 || daysInWeek==7)?"TextBoxWeekEnd":"TextBox" %>" maxlength="5" onchange="reCalculate()"><%}} %></td>
<%  } %>
		
		<td height="22" bgcolor="#F8F8F8" align="center" width="5">
		&nbsp;</td>
		<td height="22" bgcolor='#C0C0C0' align="center" width="112">
		<input type="text" name="REGULARWEEK_TOTAL<%=i %>" size="5" value="<%=weeklyTotalHrs %>" class="TextBox" readonly="readonly"></td>
	</tr>






<tr>
		<td bgcolor="#C0C0C0" align="right" width="85">Holiday Hrs</td>
		<td bgcolor="#F8F8F8" align="center" width="7">&nbsp;</td>

	<% 
	weeklyTotalHrs = 0;
	for(int daysInWeek=1;daysInWeek<=7;++daysInWeek)	{  %>
		<td bgcolor="#C0C0C0" align="center">
		<% if(daysInWeek==startDay ){ 
			isHolidayTextBoxPrint=true; 
			}
		
			if(isHolidayTextBoxPrint) {
				++holidayTextBoxName;  
				if(holidayTextBoxName<=endDay) { 
					
					value=holidayHrs[daysInWeek-1];
					weeklyTotalHrs+= value;
					monthlyTotalHrs+=value;
					holidayMonthlyTotalHrs+=value;
				
		%>
		<input type="text"  color ="#CCCCCC" name="HOLIDAYWEEK_<%=i %>_<%=daysInWeek  %>" size="5" value=<%= value %> class="<%= (daysInWeek==1 || daysInWeek==7)?"TextBoxWeekEnd":"TextBox" %>" maxlength="5" onchange="reCalculate()"><%}} %></td>
		<%  } %>
		
		<td height="22" bgcolor="#F8F8F8" align="center" width="5">
		&nbsp;</td>
		<td height="22" bgcolor="#C0C0C0" align="center" width="112">
		<input type="text" name="HOLIDAYWEEK_TOTAL<%=i %>" size="5" value=<%= weeklyTotalHrs %> class="TextBox" readonly="readonly"></td>
	</tr>









	<tr>
		<td bgcolor="#C0C0C0" align="right" width="85">OT Hours</td>
		<td bgcolor="#F8F8F8" align="center" width="7">&nbsp;</td>
<% 
	weeklyTotalHrs = 0;
	for(int daysInWeek=1;daysInWeek<=7;++daysInWeek)	{  %>
		<td bgcolor="#C0C0C0" align="center">
		<% if(daysInWeek==startDay ){ isOvertimeTextBoxPrint=true;}if(isOvertimeTextBoxPrint){++overtimeTextBoxName; if(overtimeTextBoxName<=endDay){ if(daysInWeek==1 || daysInWeek ==7){value=overTimeHrs[daysInWeek-1];weeklyTotalHrs+= value;monthlyTotalHrs+=value;overtimeMonthlyTotalHrs+=value;}else{value=overTimeHrs[daysInWeek-1];weeklyTotalHrs+= value;monthlyTotalHrs+=value;overtimeMonthlyTotalHrs+=value;}%>
		<input type="text" name="OVERTIMEWEEK_<%=i %>_<%=daysInWeek %>" size="5" value=<%= value %> class="<%= (daysInWeek==1 || daysInWeek==7)?"TextBoxWeekEnd":"TextBox" %>" maxlength="5" onchange="reCalculate()"><%}} %></td>
<%} %>
		<td height="22" bgcolor="#F8F8F8" align="center" width="5">
		&nbsp;</td>
		<td height="22" bgcolor="#C0C0C0" align="center" width="112">
		<input type="text" name="OVERTIMEWEEK_TOTAL<%=i %>" size="5" value=<%= weeklyTotalHrs %> class="TextBox" readonly="readonly"></td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF" align="center" colspan="2" height="18" width="144">&nbsp;</td>
		<td bgcolor="#FFFFFF" align="center" colspan="9" height="18" width="612">&nbsp;</td>
		<td bgcolor="#FFFFFF" align="center" height="18" width="112">&nbsp;</td>
		</tr>
<% } %>
	<tr>
		<td width="841" colspan="12">&nbsp;</td>
	</tr>

	<tr>
		<td bgcolor="#C0C0C0" colspan="11">
		<p align="right">Total Regular Hrs:&nbsp;&nbsp;&nbsp;&nbsp; </td>
		<td height="22" width="112" bgcolor="#C0C0C0" align="center">
		<input type="text" name="REGULARWEEK_MONTHLY_TOTAL" size="5" value="<%=regularMonthlyTotalHrs %>" class="TextBox" readonly="readonly"></td>
	</tr>
	<tr>
		<td bgcolor="#C0C0C0" colspan="11">
		<p align="right">Total Holiday Hrs:&nbsp;&nbsp;&nbsp;&nbsp; </td>
		<td height="22" width="112" bgcolor="#C0C0C0" align="center">
		<input type="text" name="HOLIDAYWEEK_MONTHLY_TOTAL" size="5" value="<%=holidayMonthlyTotalHrs %>" class="TextBox" readonly="readonly"></td>
	</tr>
	<tr>
		<td bgcolor="#C0C0C0" colspan="11">
		<p align="right">Total OverTime Hrs:&nbsp;&nbsp;&nbsp;&nbsp; </td>
		<td height="22" width="112" bgcolor="#C0C0C0" align="center">
		<input type="text" name="OVERTIMEWEEK_MONTHLY_TOTAL" size="5" value="<%=overtimeMonthlyTotalHrs %>" class="TextBox" readonly="readonly"></td>
	</tr>
	<tr>
		<td bgcolor="#C0C0C0" colspan="11">
		<p align="right">Total Monthly Hrs:&nbsp;&nbsp;&nbsp;&nbsp; </td>
		<td height="22" width="112" bgcolor="#C0C0C0" align="center">
		<input type="text" name="MONTHLY_TOTAL" size="5" value="<%=monthlyTotalHrs %>" class="TextBox" readonly="readonly"></td>
	</tr>
	<%String errMsg="";%>
		<html:messages id="err_name" property="msg">
			<% errMsg = err_name; %>
<tr><td align="center" colspan="2" height="40" style="vertical-align:middle; " class="stopTimeSheetSbmitErrorMsg"><img src="images/important.png" width=32 height=32/> </td><td align="center" colspan="10" height="40" style="vertical-align:middle; " class="stopTimeSheetSbmitErrorMsg">
	<%= errMsg %>
</td> </tr>
<script>
boxC('<%= timeSheetStatus%>');
</script>
</html:messages>
<logic:messagesNotPresent>
	
	<tr>
		<td bgcolor="#C0C0C0" colspan="12">
		
		
		
		<%
			
			if( (isTimeSheetEdit != null) && isTimeSheetEdit.equalsIgnoreCase("TRUE"))
			{
				submitType = "Update TimeSheet";
			}
			if(!isRequestFromAdmin){
				
			
			
		%>
		<input type="hidden" value="<%=submitType %>" name="timeSheetMode" id ="timeSheetMode">
		<p align="right">&nbsp;
		<span class="tiptip" title="TimeSheet will be saved but not submitted to your employer, You can edit any time before submitting.">
		<input type="button" id="saveAsDraft" value="Save as Draft" onclick="saveAsDraftFun()" class="ButtonStyle" name="saveAsDraft">
		</span>
		<span class="tiptip" title="TimeSheet will be submitted to your employer, You can't edit this until rejected by your employer.">
		<input type="button" id="submitTimeSheet" value="<%=submitType %>" onclick="doValidate()" class="ButtonStyle"  >
		</span>
		<input type="reset" value="Reset" name="B2" class="ButtonStyle">
		<input type="button" value="Cancel" name="B3" onclick="cancelHrs()" class="ButtonStyle">
		<%} else { %>
				<p align="right">&nbsp;<input type="button" value="<< Go Back" name="B3" onclick="window.history.back()" class="ButtonStyle">
		<%} %>
		</td></tr>

</logic:messagesNotPresent>
</table>
</div>
</html:form>
<form name="reloadForm" action="">
<input type="hidden" value="" name="month">
<input type="hidden" value="" name="year">
<input type="hidden" value="<%= GeneralConstants.MONTHLY %>" name="pageFrom">
<input type="hidden" value="reloadMonthlyHrsSubmission" name="parameter">
</form>
<script>
<% if(request.getParameter("isToEnterOnlyMonthlyHrs")!=null && request.getParameter("isToEnterOnlyMonthlyHrs").equals("Y"))
{
	System.out.println(timeSheetStatus);
	if(timeSheetStatus.equals(TimeSheetStatus.PENDING.getRep()) || timeSheetStatus.equals(TimeSheetStatus.NOTSUBMITTED.getRep()))
	{ 
		System.out.println("PENDING || NOTSUBMITTED");
	%>
	   boxC('<%= timeSheetStatus%>');
	<%
	} else if (timeSheetStatus.equals(TimeSheetStatus.REJECTED.getRep())) {
	%>
	updateBoxC('<%= timeSheetStatus%>');
	<%
	}
} else if( (isTimeSheetEdit != null) && isTimeSheetEdit.equalsIgnoreCase("TRUE")){
	
}
%>
</script>
