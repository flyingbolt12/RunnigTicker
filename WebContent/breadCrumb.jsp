<%@page import="java.util.Set"%>
<%@page import="com.lch.general.Action_Param"%>
<%@page import="com.lch.general.BreadCrumb"%>
<% BreadCrumb bc = (BreadCrumb) session.getAttribute("breadCrumb"); %>
<% if(bc!=null && bc.listActions().size() > 0) { %>
 <div id="breadCrumb0" class="breadCrumb module">
                    <ul>
                    <li>
                            <a href="genericForwardAction.do?forwardTo=admin/adminFunctions.jsp">HOME</a>
                        </li>
                    <% Set<Action_Param> ps = bc.listActions();
                    	for (Action_Param p : ps) {
                    %>
                    	<li>
                            <a href="<%=p.getURL()%>"><%=p.getName()%></a>
                        </li>
                    <% } %>
                        
                    </ul>
                </div>
 <%}%>
 
    <script type="text/javascript">
            jQuery(document).ready(function()
            {
                jQuery("#breadCrumb0").jBreadCrumb({easing:'swing'});
            })
        </script>