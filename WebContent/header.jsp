<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%!public void log(String s) {
		//System.out.println("Header.jsp --> "+s);
	}%>

<%
	com.lch.general.generalBeans.UserProfile userProfile = (com.lch.general.generalBeans.UserProfile) session
			.getAttribute("userProfile");

	String userName = "Guest";
	if (userProfile != null && userProfile.getFirstName().length() != 0) {
		userName = userProfile.getFirstName();
	}

	String pageDecider = "";
	String pageURL = "javascript:alert('Login Required');";
	String title = "";
	String URL = "/genericForwardAction.do?forwardTo=";
	if (userProfile != null) {
		if (userProfile.isSuperAdmin()) {
			pageDecider = "Admin";
			pageURL = URL + "superAdmin/superAdmin.jsp";
			title = "This link will take you to Super Functional Area.";
		} else if (userProfile.isAdmin() || userProfile.isChildAdmin()) {
			pageDecider = "Admin";
			pageURL = URL + "admin/adminFunctions.jsp";
			title = "This link will take you to Admin Functional Area.";
		} else {
			pageDecider = "Member";
			pageURL = URL + "members/memberFunctions.jsp";
			title = "This link will take you to Member Functional Area.";
		}
	} else {
		pageDecider = "";
	}
	log(pageDecider);
%>
<div style="float: left;" class="headerLinks">
	&nbsp; &nbsp; Welcome &nbsp;<%=userName%>
	,
</div>
<div style="float: right;">


<%
		if (userProfile != null && userProfile.isLoginStatus()) {
	%>
<html:link href="javascript:setPrivacyMode()" styleClass="headerLinks" styleId="privaceModeOnOff"
		title="ShortCut : CTRL + ALT"> Privacy Mode : OFF</html:link>
		|
		<%} %>
	<%
		if (userProfile == null
				|| (userProfile != null && !userProfile.isLoginStatus())) {
	%>
	<html:link href="index.jsp" styleClass="headerLinks" styleId="homeLink"
		title="This link will take you to Login & Registration page"> <font color="#FFCC00"> Home </font></html:link>
	|

	<%
		}
	%>
	<html:link action="/genericForwardAction.do?forwardTo=generic/aboutUs.jsp" styleClass="headerLinks" title="Helps you to report problem.">About Us</html:link> |
	<%
		if (userProfile != null && userProfile.isLoginStatus()) {
	%>
	<html:link action="<%=pageURL%>" styleClass="headerLinks"
		title="<%=title%>">
		<font color="#CCFF00"> <%=pageDecider%>'s Dashboard		</font>
	</html:link>
	|
	<%
		}
	%>

	<html:link action="/genericForwardAction.do?forwardTo=demos/demo.jsp" styleClass="headerLinks">Screen Cast</html:link>
	<%		if (userProfile != null && userProfile.isLoginStatus()) {	%>
	
	|<html:link action="/signoutAction.do" styleClass="headerLinks">
		<font color="#CCFF00"> Signout</font>
	</html:link>
	<%		}	%>

	|
	<html:link action="/footerFunct.do?parameter=contactInformation" styleClass="headerLinks">Contact Us</html:link>
	&nbsp;&nbsp;
</div>

<script language="JavaScript">
	function openNewWindow(url) {
		popupWin = window.open(url, 'Features',', , , , , scrollbars, resizable, dependent')
	}
</script>