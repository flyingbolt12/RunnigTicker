<table border="0" cellspacing="2" cellpadding="1" style="font-family: Tahoma; font-size: 8pt" >

<% boolean hasOnlyMonthlyHours = (Boolean)request.getAttribute("hasOnlyMonthlyHours"); 
if(hasOnlyMonthlyHours) {%>

	<tr>
		<td   align="right" bgcolor="#C5D8D8">TOTAL</td>
		<td   align="right" bgcolor="#C5D8D8"><%=request.getAttribute("TH") %></td>
		<td   align="right" bgcolor="#C5D8D8">X</td>
		<td   align="right" bgcolor="#C5D8D8"><%=request.getAttribute("RATE") %></td>
		<td   align="right" bgcolor="#C5D8D8">=</td>
		<td   align="right" bgcolor="#C5D8D8"><%= ((Double)request.getAttribute("TH")*(Double)request.getAttribute("RATE"))%> +</td>
	</tr>
<%} else {%>
	<tr>
		<td   align="right" bgcolor="#C5D8D8">RH</td>
		<td   align="right" bgcolor="#C5D8D8"><%=request.getAttribute("RH") %></td>
		<td   align="right" bgcolor="#C5D8D8">X</td>
		<td   align="right" bgcolor="#C5D8D8"><%=request.getAttribute("RATE") %></td>
		<td   align="right" bgcolor="#C5D8D8">=</td>
		<td   align="right" bgcolor="#C5D8D8"><%= ((Double)request.getAttribute("RH")*(Double)request.getAttribute("RATE"))%> +</td>
	</tr>
	<tr>
		<td   align="right" bgcolor="#C5D8D8">OT</td>
		<td   align="right" bgcolor="#C5D8D8"><%=request.getAttribute("OH") %></td>
		<td   align="right" bgcolor="#C5D8D8">X</td>
		<td   align="right" bgcolor="#C5D8D8"><%=request.getAttribute("RATE") %></td>
		<td   align="right" bgcolor="#C5D8D8">=</td>
		<td   align="right" bgcolor="#C5D8D8"><%= ((Double)request.getAttribute("OH")*(Double)request.getAttribute("RATE"))%> -</td>
	</tr>
	<tr>
		<td   align="right" bgcolor="#C5D8D8">HH</td>
		<td   align="right" bgcolor="#C5D8D8"><%=request.getAttribute("HH") %></td>
		<td   align="right" bgcolor="#C5D8D8">X</td>
		<td   align="right" bgcolor="#C5D8D8"><%=request.getAttribute("RATE") %></td>
		<td   align="right" bgcolor="#C5D8D8">=</td>
		<td   align="right" bgcolor="#C5D8D8"><%= ((Double)request.getAttribute("HH")*(Double)request.getAttribute("RATE"))%>&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td   align="right" bgcolor="#C5D8D8">INVOICE</td>
		<td   align="right" bgcolor="#C5D8D8">&nbsp;</td>
		<td   align="right" bgcolor="#C5D8D8">X</td>
		<td   align="right" bgcolor="#C5D8D8">&nbsp;</td>
		<td   align="right" bgcolor="#C5D8D8">=</td>
		<td   align="right" bgcolor="#C5D8D8"><%= ((Double)request.getAttribute("RH")*(Double)request.getAttribute("RATE")) + ((Double)request.getAttribute("OH")*(Double)request.getAttribute("RATE")) - ((Double)request.getAttribute("HH")*(Double)request.getAttribute("RATE"))%></td>
	</tr>
	<%} %>
</table>