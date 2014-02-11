<%@page import="java.util.List"%>

<script>

$(document).ready(function () {
	var t=setInterval(function(){newsAnimation();},3000);
});
	
var newsCount=-1;
var news=new Array();


<%

List<String> news = (List<String>)application.getAttribute("news");
int index = 0;
if(news!=null)
for(String msg : news)
{
%>
news[<%=index%>]='<%=msg%>';

<%++index;}%>

 function newsAnimation()
{
	 ++newsCount;
 		if(newsCount==news.length)
 			newsCount = 0;

 		$('#newsText').fadeOut('slow', function(){
 				document.getElementById('newsText').innerHTML = news[newsCount];
 	  		$('#newsText').slideDown('slow');
 		});
}


</script>
<table border="0" cellspacing="1" width="100%" height="29" style="font-family: Tahoma; font-size: 8pt; color: #1F3B08; font-weight: bold">
	<tr>
		<td height="23" width="80%">
		<div class="newsPane">
			<div style="margin-left: 20px;float: left; width: auto">
				NEWS :&nbsp;&nbsp; </div>
				<div style="margin-left: 70px;" id="newsText">We don't share your data. Period.</div>
				</div>
			</div>
		</div>
		
		</td>
		<td height="23" width="20%">
		<div style="float: right; padding-right: 10px">
		<a href="http://www.facebook.com/RunningTicker" target="_blank" title="Connect with us for updates"><img alt="facebook" src="images/f_logo.png" width="18" height="18"></a>
		</div>
		</td>
	</tr>
</table>
