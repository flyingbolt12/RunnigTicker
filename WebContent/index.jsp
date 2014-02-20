<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<%
	com.lch.general.generalBeans.UserProfile userProfile = (com.lch.general.generalBeans.UserProfile) session
			.getAttribute("userProfile");
	if (userProfile != null && userProfile.isLoginStatus()) {
		request.getRequestDispatcher("login.do").forward(request, response);
	}
%>

<tiles:insert definition="templateDefinition"></tiles:insert>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-48072437-1', 'runningticker.com');
  ga('send', 'pageview');

</script>