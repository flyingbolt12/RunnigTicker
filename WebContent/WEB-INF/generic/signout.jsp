<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${isEmployerChangeRequestMade == 'yes'}">
	<script>
		dhtmlx.message({type: "error", expire:-1, text:"Your request sent to new employer.<br> Click on home link to login again."});
	</script>
</c:if>
<div align="center">
	<table border="0" cellspacing="20" cellpadding="10">
		<tr>
			<td>
				<p align="center">
					<span
						style="font-size: 10.0pt; font-family: Tahoma; font-weight: bold;">You
						are signed out because you signed out yourself or your session is expired.</span>
				</p>
				<p align="center">
					<font size="2"><span style="font-family: Tahoma">
							Business builds a relation with people, it is not just money.</span></font>
			</td>
		</tr>

		<tr>
			<td><span style="font-size: 8.0pt; font-family: Tahoma">
					Advertisement:</span>

				<center>
					<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
						codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"
						id="allibilli_ad" width="753" height="202">
						<param name="movie" value="allibilli_ad.swf">
						<param name="bgcolor" value="#FFFFFF">
						<param name="quality" value="high">
						<param name="seamlesstabbing" value="false">
						<param name="allowscriptaccess" value="samedomain">
						<embed type="application/x-shockwave-flash"
							pluginspage="http://www.adobe.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"
							name="allibilli_ad" width="753" height="202"
							src="images/allibilli_ad.swf" bgcolor="#FFFFFF" quality="high"
							seamlesstabbing="false" allowscriptaccess="samedomain">
							<noembed> </noembed>
						</embed>
					</object>
				</center></td>
		</tr>
		<tr>
			<td>
				<p align="center">
					<html:link
						action="footerFunct.do?parameter=contactInformation&subject=Feedback">
						<font face="Tahoma" size="2">Please report us your feed
							back.</font>
					</html:link>
			</td>
		</tr>
	</table>
</div>
