
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@page import="com.lch.spring.BusinessComponents.DoTransaction"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<%
		com.lch.general.generalBeans.UserProfile userProfile = (com.lch.general.generalBeans.UserProfile) session.getAttribute("userProfile");
		String userName = "Guest";
		String logoPath = "images/RunningTickerLogo.png";
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
				logoPath = "images/RunningTickerLogo.png";		
			}
	
		} else if(userProfile != null){ logoPath = userProfile.getLogoPath();}
	
		
	%>

<table border="0" cellspacing="1" width="100%">
	<tr style="background-color: none;" valign="middle">
		<td height="49" width="100%">

			<div style="float: left;">

<table id="myTable">
    <tr>
        <td style="vertical-align: top;"><html:link
						action="/genericForwardAction.do?forwardTo=generic/aboutUs.jsp"
						styleClass="headerLinks">
						<img border="0" id="appLogo" src="<%=logoPath%>" align="left"
							style="max-height: 55px;">
					</html:link></td>
       
    </tr>
    <tr>
        <td style="vertical-align: bottom;color: #000000" class="headerLinks"> An
					internet labor claiming hours and communication systems application</td>
    </tr>
</table>
</div>
				

			<div style="float: right; color: #000000" class="headerLinks">
				<a href="mailto:support@RunningTicker.com" style="text-decoration: none; "  
				title="We will respond quickly">Sales &amp; Support: Support@RunningTicker.com</a>
			</div>


		</td>
	</tr>
</table>
<% if(!logoPath.endsWith("RunningTickerLogo.png")) {%>
<script type="text/javascript">
document.getElementById("myTable").deleteRow(1);
</script>
<% }%>