	
	<script>
		function disableBusnessConfirmationDialog(thislink) {
			
			var msg = "Are you sure, do you want to disable business?";
			
			dhtmlx.confirm({ title: "Confirmation Needed", text:msg, ok:"Yes", cancel:"No", callback:function(result){ 
				if (result == true) {document.forms[1].submit(); } else {document.getElementById('business').checked = false;}
			 }});

		}
		
		function showTimeSheetConfiguration(thislink) {
			document.forms[0].parameter.value="showTimeSheetConfiguration";
			document.forms[0].submit();
		}
				
	</script>

<form method="POST" action="adminFunctImpl.do">
	<input type="hidden" name="parameter" value="resetPassword">
	<table align="center" cellspacing="4" cellpadding="3" style="font-family: Tahoma; font-size: 10pt">
		<tr>
		    <td></td>	
 			<td>	
 					<input type="radio" name="searchOptions" onclick="document.forms[0].submit()">&nbsp;Reset My Password
			</td>
		</tr>
		<tr>
		    <td></td>
			<td>
					<input type="radio" id="business" name="searchOptions" onclick="disableBusnessConfirmationDialog()">&nbsp;Disable My Business
			</td>
		</tr>
		<tr>
		    <td></td>
			<td>
					<input type="radio" id="business" name="searchOptions" onclick="showTimeSheetConfiguration()">&nbsp;Time Sheet Configuration
			</td>
		</tr>
	</table>
</form>
<form action="adminFunctImpl.do" method="POST"><input type="hidden" name="parameter" value="disableBusiness"></form>
	