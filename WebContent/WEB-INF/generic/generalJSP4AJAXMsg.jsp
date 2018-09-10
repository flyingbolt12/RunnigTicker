<% System.out.println("generalAJAXMsg - JSP receieved the request with the message availale:" + request.getAttribute("generalAJAXMsg"));%>
<%= request.getAttribute("generalAJAXMsg")%> 
<%= (request.getAttribute("disableSubmitRequired")!=null)?request.getAttribute("disableSubmitRequired"):""%>