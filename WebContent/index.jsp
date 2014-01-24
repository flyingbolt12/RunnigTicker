<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<%
	com.lch.general.generalBeans.UserProfile userProfile = (com.lch.general.generalBeans.UserProfile) session
			.getAttribute("userProfile");
	if (userProfile != null && userProfile.isLoginStatus()) {
		request.getRequestDispatcher("login.do").forward(request, response);
	}
%>

<tiles:insert definition="templateDefinition"></tiles:insert>
