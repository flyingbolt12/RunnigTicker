
<%@page import="com.lch.general.enums.TimeSheetStatus"%>
<%
	String emailApprovalStatus = (String) request
			.getAttribute("approvalMsg");

	if (emailApprovalStatus.equalsIgnoreCase(TimeSheetStatus.APPROVED.name())) {
%>

<p align="center"><font face="Tahoma" size="2">All right, Your employee is now granted with access to login into the system. Also the same is notified.</font></p>

<%
	} else {
%>
	<p><font face="Tahoma" size="2">We are sorry, seems there is a system error.</font></p>
	<p><font face="Tahoma" size="2">Click on the </font> <font
		color="#0000FF" size="2" face="Tahoma"> <a href="genericForwardAction.do?forwardTo=generic/contactUs.jsp">
	Report a problem</a> </font><font face="Tahoma" size="2">in the header to
	submit a ticket.</font></p>

<%
	}
%>