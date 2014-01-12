<div class="TabbedPanels" id="loginTabs">
	<ul class="TabbedPanelsTabGroup">
		<li class="TabbedPanelsTab" tabindex="0" title="your login form">General Login</li>
		<li class="TabbedPanelsTab" tabindex="6" title="Employee Registration">Employee Registration</li>
		<li class="TabbedPanelsTab" tabindex="6" title="Bussiness Registration.">Business (Employer) Registration</li>
	</ul>
	<div class="TabbedPanelsContentGroup">
		<div class="TabbedPanelsContent"><%@ include file="/WEB-INF/members/membersLogin.jsp"%></div>
		<div class="TabbedPanelsContent"><%@ include file="/WEB-INF/members/registration/employeeRegistration.jsp"%></div>
		<div class="TabbedPanelsContent"><%@ include file="/WEB-INF/admin/registration/adminRegistration.jsp"%></div>
	</div>
	
</div>
<script language="JavaScript" type="text/javascript">
var tp1 = new Spry.Widget.TabbedPanels("loginTabs", { defaultTab: 0 });
</script>