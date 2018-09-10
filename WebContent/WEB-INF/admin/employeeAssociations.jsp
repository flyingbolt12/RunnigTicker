<%@page import="com.lch.general.generalBeans.EmployeeAssociation"%>
<%@page import="java.util.List"%>
<%@page import="com.lch.general.enums.TimeSheetStatus"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.ui-dialog-osx {
	-moz-border-radius: 0 0 8px 8px;
	-webkit-border-radius: 0 0 8px 8px;
	border-radius: 0 0 8px 8px;
	border-width: 0 8px 8px 8px;
}
</style>
<c:if test="${not empty status}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"<%= request.getAttribute("status")%>" });
	</script>
</c:if>
<%@page import="java.util.Map"%>
<% String categoryId = (String)request.getAttribute("idcategories"); 
List<EmployeeAssociation> all = (List<EmployeeAssociation>)request.getAttribute("allEmployees");
String catName = (String)((Map)request.getAttribute("categoryDetails")).get("name");%>
<div align="center">

	<hr class="regHeader" />
	<span>-- Associating for Category "<strong><%= catName %></strong>" -- </span>
	<hr class="regHeader" />
<form method="post" action="adminFunctImpl.do?parameter=updateAssociatoins">

<!-- 	<table border="0" width="100%" style="font-family: Tahoma; font-size: 10pt">
	<tr>
		<td colspan="3" align=center> Associating Non Associated Employees <hr/></td>
	</tr>

	<tr>
		<td width="45%" align=center valign="middle">
		Non Associated Employees <br><hr/>
		<select name="sel1" size="20" multiple="multiple" class="BusinessTextBox">
			<% 
			for (EmployeeAssociation emp : all) {
				if (emp.getCategoryId().equals("0")){
					String displayStr = emp.getUserId() + ", "+emp.getFirstName() +" " +emp.getLastName();
			%>
			<option value="<%= emp.getPersonalDetailsId() %>"><%= displayStr %></option>
			<%} }%>
			</select>
		</td>
		<td width="10%" align=center valign="middle">
			<input type="button" value="--&gt;" onclick="moveOptions(this.form.sel1, this.form.sel2);" />
			<br/>
			<input type="button" value="&lt;--" onclick="moveOptions(this.form.sel2, this.form.sel1);" />
		</td>
		<td width="45%" align=center valign="middle">
				Associated Employees to <%= catName %><br><hr/>
				<select name="sel2" size="20" multiple="multiple" id="selc2">
				<% 
				for (EmployeeAssociation emp : all) {
					if (emp.getCategoryId().equals(categoryId)){
						String displayStr = emp.getUserId() + ", "+emp.getFirstName() +" " +emp.getLastName();
				%>
				<option value="<%= emp.getPersonalDetailsId() %>"><%= displayStr%></option>
				<%} }%>
				</select>
		</td>
	</tr>
	</table>
	
	<hr/> -->
	<table border="0" width="100%" style="font-family: Tahoma; font-size: 10pt">
	
	<tr>
		<td colspan="3" align=center> Modifying Already Associated Employees -- Moving from other categories to <%= catName %> <hr/></td>
		
	</tr>

	<tr>
		<td width="45%" align=center valign="middle">	
		Associated Employees to other categories<br><hr/>
			<select name="sel3" size="20" multiple="multiple">
			<%
			for (EmployeeAssociation emp : all) {
				if (!emp.getCategoryId().equals(categoryId)){
					String displayStr = emp.getUserId() + ", "+emp.getFirstName() +" " +emp.getLastName() + " -- " + emp.getCategoryName();
			%>
			<option value="<%= emp.getPersonalDetailsId() %>"><%= displayStr%></option>
			<%} }%>
			</select>
		</td>
		<td width="10%" align=center valign="middle">
			<input type="button" value="--&gt;" onclick="moveOptions(this.form.sel3, this.form.sel4);" /><br />
			<input type="button" value="&lt;--" onclick="moveOptions(this.form.sel4, this.form.sel3);" />
		</td>
		<td width="45%" align=center valign="middle">
		Associated Employees to <%= catName %><br><hr/>
			<select name="sel4" size="20" multiple="multiple" id="selc4">
			<% 
				for (EmployeeAssociation emp : all) {
					if (emp.getCategoryId().equals(categoryId)){
						String displayStr = emp.getUserId() + ", "+emp.getFirstName() +" " +emp.getLastName() + " -- " + emp.getCategoryName();;
				%>
				<option value="<%= emp.getPersonalDetailsId() %>"><%= displayStr%></option>
				<%} }%>
			</select>
		</td>
	</tr>
	</table>
	<input type="button" value="Save Changes" class="ButtonStyle" onclick="saveChanges()">
	<input type="button" value="Go Back" class="ButtonStyle" onclick="goToBackPage()" >
	<input type="hidden" name="ids" value=""/>
	<input type="hidden" name="_idcategories" value="<%= categoryId%>"/>
	</form>
	
	<form action="adminFunctImpl.do?parameter=manageMyCategories" method="post" name="goBack">
	</form>
</div>


<script language="JavaScript" type="text/javascript">

var NS4 = (navigator.appName == "Netscape" && parseInt(navigator.appVersion) < 5);


function goToBackPage() {
	document.getElementsByName("goBack")[0].submit();
}	

function saveChanges(){
	var ids = "";
	$("#selc4 option").each(function()
	{
	    ids= ids +$(this).val()+",";
	});
// 	$("#selc2 option").each(function()
// 	{
// 	    ids= ids + $(this).val()+",";
// 	});
	document.forms[0].ids.value = ids;
	document.forms[0].submit();
}

function addOption(theSel, theText, theValue)
{
  var newOpt = new Option(theText, theValue);
  var selLength = theSel.length;
  theSel.options[selLength] = newOpt;
}

function deleteOption(theSel, theIndex)
{ 
  var selLength = theSel.length;
  if(selLength>0)
  {
    theSel.options[theIndex] = null;
  }
}

function moveOptions(theSelFrom, theSelTo)
{
  
  var selLength = theSelFrom.length;
  var selectedText = new Array();
  var selectedValues = new Array();
  var selectedCount = 0;
  
  var i;
  
  // Find the selected Options in reverse order
  // and delete them from the 'from' Select.
  for(i=selLength-1; i>=0; i--)
  {
    if(theSelFrom.options[i].selected)
    {
      selectedText[selectedCount] = theSelFrom.options[i].text;
      selectedValues[selectedCount] = theSelFrom.options[i].value;
      deleteOption(theSelFrom, i);
      selectedCount++;
    }
  }
  
  // Add the selected text/values in reverse order.
  // This will add the Options to the 'to' Select
  // in the same order as they were in the 'from' Select.
  for(i=selectedCount-1; i>=0; i--)
  {
    addOption(theSelTo, selectedText[i], selectedValues[i]);
  }
  
  if(NS4) history.go(0);
}

</script>
