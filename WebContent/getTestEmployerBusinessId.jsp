
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@page import="com.lch.spring.BusinessComponents.DoTransaction"%>

<%
				GenericXmlApplicationContext ctx = (GenericXmlApplicationContext)getServletContext().getAttribute("ctx");
				DoTransaction doTransaction = (DoTransaction)ctx.getBean("doTransaction");
				Long businessId = -1L;
				try{
					businessId = doTransaction.getTestEmployerBusinessId();
				}
				catch(Exception e )
				{
					businessId = -1L;
				}
		
	%>
<%= businessId %>