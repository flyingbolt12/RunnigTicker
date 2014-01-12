<div class="TabbedPanels" id="adminLoginTabs">
	<ul class="TabbedPanelsTabGroup">
		<li class="TabbedPanelsTab" tabindex="0">What we will do?</li>
		<li class="TabbedPanelsTab" tabindex="1">How will you benifit?</li>
	</ul>
	<div class="TabbedPanelsContentGroup">
		<div class="TabbedPanelsContent"><%@ include file="/WEB-INF/generic/whatWeDo.jsp" %></div>
		<div class="TabbedPanelsContent"><%@ include file="/WEB-INF/generic/howWillYoUbenifit.jsp" %></div>
	</div>
</div>
<script language="JavaScript" type="text/javascript">
var tp1 = new Spry.Widget.TabbedPanels("adminLoginTabs", { defaultTab: 0 });
</script>