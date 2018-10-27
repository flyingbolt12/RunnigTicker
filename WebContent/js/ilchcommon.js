function downloadTimeSheets(userId, ajaxId)
{
	document.getElementsByName("customForm")[0].action="downloadReports.do?parameter=downloadEmpTimeSheets";
	document.getElementsByName("customForm")[0].target = "_blank";
	document.getElementsByName("customForm")[0].userId.value = userId;
	document.getElementsByName("customForm")[0].submit();
};
function sendGenericEmail(userId, ajaxId)
{
	document.getElementsByName("customForm")[0].action="adminFunctImpl.do?parameter=showSendGenericEmailToSingleEmployee";
	document.getElementsByName("customForm")[0].userId.value = userId;
	document.getElementsByName("customForm")[0].submit();
};
function browseUploads(userId, ajaxId)
{
	document.getElementsByName("customForm")[0].action="adminFunctImpl.do?parameter=browseUploads&isFromSearch=true";
	document.getElementsByName("customForm")[0].userId.value = userId;
	document.getElementsByName("customForm")[0].submit();
};

function listSkills(userId, ajaxId)
{
	document.getElementsByName("customForm")[0].action="adminFunctImpl.do?parameter=listSkills&isFromSearch=true&featureRequest=EMPLOYEE_SKILLS";
	document.getElementsByName("customForm")[0].userId.value = userId;
	document.getElementsByName("customForm")[0].submit();
};

function listSimilarSkills(userId, ajaxId)
{
	document.getElementsByName("customForm")[0].action="adminFunctImpl.do?parameter=listSimilarSkills&isFromSearch=true&featureRequest=EMPLOYEE_SKILLS";
	document.getElementsByName("customForm")[0].userId.value = userId;
	document.getElementsByName("customForm")[0].submit();
};

function notifyBusinessId(userId, ajaxId)
{
	dhtmlx.message({type:"error", expire:6000, text:"Wait, Processing..." });
	  var params = {
	    		    ajaxParam : userId
	    	    };
	    	    var obj = {
	    	    id : ajaxId,
	    	    url : "adminFunctImpl.do?parameter=sendMyBusinessUniqueIdentificationNumberToEmployee",
	    	    params : params,
	    	    responseHandler : handleResponse
	    	    };
	    	    sendAjaxRequest(obj);
}

function regenerateValidationEmail(userId, ajaxId)
{
	dhtmlx.message({type:"error", expire:6000, text:"Wait, Processing..." });
	  var params = {
	    		    ajaxParam : userId
	    	    };
	    	    var obj = {
	    	    id : ajaxId,
	    	    url : "adminFunctImpl.do?parameter=regenerateValidationEmail",
	    	    params : params,
	    	    responseHandler : handleSpecialResponse
	    	    };
	    	    sendAjaxRequest(obj);
}

function sendImmigrationUpdateRequest(userId, ajaxId)
{
	dhtmlx.message({type:"error", expire:6000, text:"Wait, Processing..." });
	  var params = {
	    		    ajaxParam : userId
	    	    };
	    	    var obj = {
	    	    id : ajaxId,
	    	    url : "adminFunctImpl.do?parameter=requestAnEmployeeToUpdateImmigrationDetails",
	    	    params : params,
	    	    responseHandler : handleResponse
	    	    };
	    	    sendAjaxRequest(obj);
}

function sendPasswordResetRequest(userId, ajaxId)
{
	dhtmlx.message({type:"error", expire:6000, text:"Wait, Processing..." });
	  var params = {
	    		    ajaxParam : userId
	    	    };
	    	    var obj = {
	    	    id : ajaxId,
	    	    url : "adminFunctImpl.do?parameter=requestAnEmployeeToUpdateImmigrationDetails",
	    	    params : params,
	    	    responseHandler : handleResponse
	    	    };
	    	    sendAjaxRequest(obj);
}

function sendUpdateRequest(userId, ajaxId)
{
	  var params = {
	    		    ajaxParam : userId
	    	    };
	    	    var obj = {
	    	    id : ajaxId,
	    	    url : "adminFunctImpl.do?parameter=requestAnEmployeeToUpdateProfile",
	    	    params : params,
	    	    responseHandler : handleResponse
	    	    };
	    	    sendAjaxRequest(obj);
}
function activateUser(userId, ajaxId)
{
	  var params = {
			  		userId : userId,
			  		approvalStatus : 1
	    	    };
	    	    var obj = {
	    	    id : ajaxId,
	    	    url : "adminFunctImpl.do?parameter=activateOrDeActivateUser",
	    	    params : params,
	    	    responseHandler : handleResponse
	    	    };
	    	    sendAjaxRequest(obj);
}
function deActivateUser(userId, ajaxId)
{
	  var params = {
			  		userId : userId,
			  		approvalStatus : 2
	    	    };
	    	    var obj = {
	    	    id : ajaxId,
	    	    url : "adminFunctImpl.do?parameter=activateOrDeActivateUser",
	    	    params : params,
	    	    responseHandler : handleResponse
	    	    };
	    	    sendAjaxRequest(obj);
}

function handleSpecialResponse(obj, response) {
    removeAjaxImg(obj.id);
 
    if (response != null)
	    response = response.replace("disableSubmitRequired", "");
    if (response.indexOf("alreadyValidated")!=-1){
    	dhtmlx.message({type:"alert-error", expire:10000, text:"User Already Validated his/her email. So New Email is not Generated." });	
    }
    else{
    	dhtmlx.message({type:"error", expire:6000, text:"Job Completed." });
    }
    var img = "<img src=\"images/done.png\" width=\"32\" height=\"32\">"; 
    document.getElementById(obj.id).innerHTML = img; 
}
function handleResponse(obj, response) {
    removeAjaxImg(obj.id);
 
    if (response != null)
	    response = response.replace("disableSubmitRequired", "");
    
    dhtmlx.message({type:"error", expire:6000, text:"Job Comleted." });
    var img = "<img src=\"images/done.png\" width=\"32\" height=\"32\">"; 
    document.getElementById(obj.id).innerHTML = img; 
}

