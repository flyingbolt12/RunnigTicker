
var data;

function listStates(requestFor,disableButtonId,formFrom)
{
	document.getElementById(disableButtonId).disabled=true;
	if(requestFor == "listStates")
	{
		statusMsg = "Contacting AlliBilli for "+requestFor;
	}
	else
	{
		statusMsg = "Contacting AlliBilli...";
	}
	
	
}
/* use this when ever needed.
function raiseAjaxRequest(requestFor,statusMsg)
{  
	document.getElementById(disableButtonId).disabled=true;
	window.status = statusMsg;
    MakeRequest(requestFor);
}
function MakeRequest(requestFor)
{
	
	document.getElementById(requestFor+"_"+id).innerHTML="<span style='color:red'><img src='../images/ajax-loader.gif.gif' /> Updating...</span>";
    var xmlHttp = getXMLHttp();
    xmlHttp.onreadystatechange = function()
    {
      	if(xmlHttp.readyState == 4)
		{
        	var nums = xmlHttp.responseText.split(':');
    	    var statesList=nums[1];
		    HandleResponse(id,statesList);
      }
    }
var parameters="doaction=updatePrice&id="+pid+"&remarks="+x+"&oldRemarks="+y;
url="/geadmin/RemarksUpdateConfirm";
xmlHttp.open('POST', url, true);
xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
xmlHttp.setRequestHeader("Content-length", parameters.length);
xmlHttp.setRequestHeader("Connection", "close");
xmlHttp.send(parameters);
}
 
function HandleResponse(id,a,b)
{
	document.getElementById("response_"+id).innerHTML=a;
	document.getElementById("text_"+id).innerHTML=b;
	document.getElementById("oldRemarks_"+id).value=b;
	window.status="Thankyouforcontactingus."
}
*/