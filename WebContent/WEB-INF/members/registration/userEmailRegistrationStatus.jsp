
<%
	String emailValidateStatus = (String) request
			.getAttribute("emailValidateStatus");

	if (emailValidateStatus.equalsIgnoreCase("success")) {
%>


<p align="center"><font face="Tahoma" size="2">Your email validated successfully and  your Employer notified to grant the access to you.</font></p>

<%
	} else {
%>
	<p><font face="Tahoma" size="2">We are unable to validate
	your email successfully. Your IP was logged for security reasons. </font></p>
	<p><font face="Tahoma" size="2">Click on the </font> <font
		color="#ffff00" size="2" face="Tahoma"> <a class="headerLinks"
		href="genericForwardAction.do?forwardTo=generic/submitTicket.jsp">
	Report a problem</a> </font><font face="Tahoma" size="2">in the header to
	submit a ticket.</font></p>
<%
	}
%>