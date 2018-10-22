<%@page import="com.lch.general.generalBeans.SkillTagsBean"%>
<%@page import="java.util.Map"%>
<%@page import="com.lch.general.generalBeans.UserProfile"%>
<%@page import="java.util.List"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="org.apache.commons.collections.map.ListOrderedMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
<!--


#text {
	width:600px;
	overflow:hidden;
	background-color:#FFF;
	color:#222;
	font-family:Courier, monospace;
	font-weight:normal;
	font-size:18px;
	resize:none;
	line-height:40px;
	padding-left:100px;
	padding-right:100px;
	padding-top:45px;
	padding-bottom:34px;
	background-image:url(https://static.tumblr.com/maopbtg/E9Bmgtoht/lines.png), url(https://static.tumblr.com/maopbtg/nBUmgtogx/paper.png);
	background-repeat:repeat-y, repeat;
	-webkit-border-radius:12px;
	border-radius:12px;
	-webkit-box-shadow: 0px 2px 14px #000;
	box-shadow: 0px 2px 14px #000;
	border-top:1px solid #FFF;
	border-bottom:1px solid #FFF;
}

.SpanStyle {
	font-family: Tahoma;
	font-size: 10pt;
}
-->
</style>

<c:if test="${not empty status}">
	<script>
		dhtmlx.message({type:"error", expire:6000, text:"${status}" });
	</script>
</c:if>
<%
	long idskillTags=0;
	String skills = "";
	long  businessId = 0;
	long userId = 0;

	UserProfile userProfile = (UserProfile) session.getAttribute("userProfile");
	businessId = userProfile.getBusinessId();
	userId = userProfile.getUserId();

	SkillTagsBean skillTags= (SkillTagsBean) request.getAttribute("skillTags");
	
	if (skillTags != null) {
		idskillTags = skillTags.getIdskilltags();
		skills = skillTags.getTags();
	}
	else{
		skillTags = new SkillTagsBean();
	}
%>
<div align="center">

<form action="memberFunctImpl.do" method="post">
<input type="hidden" name="idskillTags" value="<%=idskillTags%>">
<input type="hidden" name="userId" value="<%=userId%>">
<input type="hidden" name="parameter" value="saveOrUpdateSkillTags">
<table border="0" cellspacing="1" style="font-family: Tahoma; font-size: 10pt;" id="table1" width= "100%">

	<tr>
		<td   bgcolor="#808080" colspan="3">
		<p align="center"><font size="2" color="#FFFFFF"><b>Add or Update Skills (Comma separated or line by line)</b></font>
		</td>
	</tr>
	
	<tr>		
		<td>
			<br>
		</td>
	</tr>
		
	<tr>
		
		<td align="right">
		
		<textarea placeholder="Enter Skills" id="text" name="tags" 
		rows="4" style="overflow: scroll; word-wrap: break-word; resize: none; height: 100%;"><%=skills%></textarea>  
		
		<%-- <input type="textarea" name="passportNumber" value="<%=skills%>" size="20" tabindex="2" class="EmployeeTextBox" > --%>
		
		</td>
	</tr>


	<tr>		
		<td>
			<br>
		</td>
	</tr>
	
	<tr>
		<td  bgcolor="#F4F4F4" colspan="2"></td>
		<td   colspan="1" bgcolor="#F4F4F4">
		<p>
			<font size="1"> 
				<input type="submit" value="Add or Update" name="update" class="ButtonStyle" tabindex="10">
				<input type="submit" value="Cancel " onclick="redirectOnClickCancel()" name="cancel" class="ButtonStyle" tabindex="10">
			</font>
		</td>
	</tr>
</table>
</form>
</div>
<script type="text/javascript">
$(document).ready(function(){
	  $('#text').focus();
	  $('#text').autosize();
});
</script>