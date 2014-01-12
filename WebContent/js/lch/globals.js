var isDebug = false;
var errorWith;
function dataAlert(displayData)
{
	if(isDebug)
	{
		alert(displayData);
	}
}


function checkPwdAndCnfrmPwd()
{
	pwd = document.forms[0].password.value;
	cnfrmPwd = document.forms[0].confirmPassword.value;
	if(pwd!=null && pwd.trim().length > 0 && pwd == cnfrmPwd)
	{
		return true;
	}
	else {
		
		if (pwd==null || pwd.trim().length == 0){
			document.getElementById("pwdErr").innerHTML="Invalid Password";
			return false;
		}
		if (cnfrmPwd==null || cnfrmPwd.trim().length == 0){
			document.getElementById("cnfrmPwdErr").innerHTML="Invalid Password";
			return false;
		}
		if(pwd!=null && pwd.trim().length > 0 && cnfrmPwd!=null && pwd != cnfrmPwd)
		{
			var msg = "Password and ConfrimPassword should be same with a proper text";
			document.getElementById("pwdErr").innerHTML=msg;
			document.getElementById("cnfrmPwdErr").innerHTML=msg;
			return false;
		}
	}
			
}

function verifyState(state)
{
	document.getElementById("state").innerHTML="";
	if(state.value.length == 2)
	{
		return true;
	}
	else
	{
		state.value ="";
		var msg = "<font color=red> Only 2 letters allowed </font>";
		document.getElementById("state").innerHTML=msg;
		return false;
	}		
}

function sepearteTextBoxes()
{
	errorWith="";
	 var input = document.forms[0].getElementsByTagName('input');
	    var name;
	    var value;
	    var rIndex = 0;
	    var oIndex = 0;
	    var hIndex = 0;
	 for (var i = 0; i < input.length; i++) {
	        if (input[i].getAttribute('type') == 'text') {
	            name = input[i].getAttribute('name');
	            if(name.indexOf("TOTAL")!=-1)
	            	continue;
	            
	            var index = input[i].value.indexOf(".");
	        	if(index > -1)
	        		{
	        			var subStr = input[i].value.substring(index+1);
	        			if(subStr.length == 1)
	        				subStr=subStr+"0";
	        			if(eval(subStr) >= 60){
	        				errorWith =  input[i].value;
	        				return false;
	        			}
	        			
	        		}
	        	
	            if(name.indexOf("REGULARWEEK")!=-1 )
	            	{
	            		rA[rIndex]=input[i].value;
	            		++rIndex;
	            	}
	            else if(name.indexOf("HOLIDAYWEEK")!=-1 )
            	{
            	hA[hIndex]=input[i].value;
            		++hIndex;
            	}
	            else if(name.indexOf("OVERTIMEWEEK")!=-1 )
            	{
            		oA[oIndex]=input[i].value;
            		++oIndex;
            	};
	        };
	 };
	 return true;
}

function textValueValidate()
{
	fIndex =-1; 
	if(sepearteTextBoxes()){
    for (var i = 0; i < rA.length; i++) {
    	if(parseInt(rA[i])+parseInt(oA[i])+parseInt(hA[i]) > 24)
    		{
	    		fIndex = i; 	
    			return false;
    		};
    }}
	else
		{
		return false;
		}
    return true;
}

function redirectOnClickCancel(){
	document.forms[0].action="memberFunctImpl.do";  	
	document.forms[0].parameter.value="onClickingCancel";
	document.forms[0].submit();
}

function openILCHWindow(url,title)
{
	window.open(url,title,"menubar=1,resizable=1,width=350,height=250");
}

function showAjaxLoader(idEle)
{
	document.getElementById(idEle).innerHTML="<img border=\"0\" src=\"images/small-ajax-loader.gif\"></img>";
}
function resetField(){
	if(document.getElementById("contactEmail")!=null)
		document.getElementById("contactEmail").value="";
	if(document.getElementById("empContactEmail")!=null)
		document.getElementById("empContactEmail").value="";
	if(document.getElementById("userName")!=null)
		document.getElementById("userName").value="";
	return true;
}
