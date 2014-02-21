<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>


<div style="max-width:500px;margin-left:31%;">
		    <html:link onclick="submitForm('editMemberProfileForUpdate')" href="#" styleClass="memberLinks"><div class = "square" title="You can edit your profile.">   
<span class="spanStyle"><img src="images/time.png" ></span><span class="spanStyle">Edit my Profile</span>
   			</div></html:link>
			<html:link action="/genericForwardAction.do?forwardTo=members/updateMyClientOptions" styleClass="memberLinks" style="text-decoration: none;"><div class = "square" title="You can update your existing client/provide service to another client.">
				<span class="spanStyle"><img src="images/time.png" ></span><span  class="spanStyle" >Update my Client</span>
			</div></html:link>
		</div>	

<script language="JavaScript">
	function openNewWindow(url) {
		popupWin = window.open(url, 'Features',', , , , , scrollbars, resizable, dependent')
	}
</script>