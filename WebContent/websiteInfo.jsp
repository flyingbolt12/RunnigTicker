
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<% List<Map<String, Object>> superSettings = (List<Map<String, Object>>)application.getAttribute("superSettings");

Map<String, Object> messgeMap = superSettings.get(superSettings.size()-1);
String messge = (String)messgeMap.get("info");
%>
<table border="0" style="font-family: Tahoma; font-size: 8pt; color: #1F3B08; font-weight: bold" align="center">
	<tr>
		<td width="50" align="right" onclick="">
				<img alt="Stop And See" src="images/stopLook.png" width="48" height="48" align="right" style="margin-left: 70px;">
		</td>
		<td>
		<div  id="websiteIfnoTxt"><%= messge %></div></td>
	</tr>
</table>