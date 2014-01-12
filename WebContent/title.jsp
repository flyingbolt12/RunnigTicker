
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@page import="com.lch.spring.BusinessComponents.DoTransaction"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<%
		com.lch.general.generalBeans.UserProfile userProfile = (com.lch.general.generalBeans.UserProfile) session.getAttribute("userProfile");
		String userName = "Guest";
		String logoPath = "images/ILC.jpg";
		String businessId = request.getParameter("businessId");
		// Avoid this execution for every page load
		if (userProfile != null && userProfile.getBusinessId()>0 && !userProfile.isLogoUpdated()) {
				GenericXmlApplicationContext ctx = (GenericXmlApplicationContext)getServletContext().getAttribute("ctx");
				DoTransaction doTransaction = (DoTransaction)ctx.getBean("doTransaction");
				try{
				logoPath = doTransaction.getLogoPath(userProfile.getBusinessId());
				if(logoPath!=null)
					userProfile.setLogoPath(logoPath);
				userProfile.setLogoUpdated(true);
				}
				catch(Exception e )
				{
				userProfile.setLogoPath(logoPath);
				userProfile.setLogoUpdated(true);}
		}else if(businessId!=null && businessId.length() > 0){
			int bid = Integer.valueOf(businessId);
			
			GenericXmlApplicationContext ctx = (GenericXmlApplicationContext)getServletContext().getAttribute("ctx");
			DoTransaction doTransaction = (DoTransaction)ctx.getBean("doTransaction");
			try{
			logoPath = doTransaction.getLogoPath(bid);
			}
			catch(Exception e )
			{
				logoPath = "images/ILC.jpg";		
			}
	
		} else if(userProfile != null){ logoPath = userProfile.getLogoPath();}
	
		
	%>

<table border="0" cellspacing="1" width="100%">
	<tr style="background-color: none;" valign="middle">
		<td height="49" width="100%" >
		<div style="float: left;height: 45; width: 100% "><img border="0" src="<%= logoPath%>" align="left" style="max-height: 45px;"></div><div id="links" style="float: right;" class="headerLinks"> <a href="mailto:contact@allibilli.com" style="text-decoration: none" title="We will respond quickly">sales : contact@allibilli.com</a></div>
		</td>
	</tr>
</table>
<% if(!logoPath.endsWith("ILC.jpg")) {%>
<script type="text/javascript">
document.getElementById("links").innerHTML="";
</script>
<% }%>