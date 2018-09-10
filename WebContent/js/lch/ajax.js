function xmlhttpPost(id, strURL) {
	var xmlHttpReq;
	dataAlert("Action : " + strURL);
	xmlHttpReq = getXMLHttp();
	xmlHttpReq.open('POST', strURL, true);
	xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlHttpReq.onreadystatechange = function() {
		if (xmlHttpReq.readyState == 4) {
			updatepage(id, xmlHttpReq.responseText);
		}
	};
	var params = getquerystring();
	dataAlert("Parameters : " + params);
	xmlHttpReq.send(params);
}

function raiseRequest4NotDisplayUpdate(id, strURL, xAction, userIdArray) {
	var xmlHttpReq;
	xmlHttpReq = getXMLHttp();
	xmlHttpReq.open('POST', strURL, true);
	xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlHttpReq.onreadystatechange = function() {
		if (xmlHttpReq.readyState == 4) {
			
			for (i = 1; i <= userIdArray.length; ++i) {
				if (xAction == 'Approve All' || xAction == 'ApproveAll' || xAction == 'Approve Selected') {
					updatepage(userIdArray[i], 'APPROVED');
				}
				
				if (xAction == 'Reject All' || xAction == 'RejectAll' ||  xAction == 'Reject Selected') {
					updatepage(userIdArray[i], 'REJECTED');
				}
			}
		}
	};
	var params = buildQueryString(xAction);
	xmlHttpReq.send(params);
}
// id - the element id which will be replaced with the element AJAX response.
// strURL - to where the request will be sent.
// formElementValue - the value of the form element required to send as an
// ajaxParam.
function raiseRequest(id, strURL, formElementValue) {
	placeAjaxImg(id);
	var xmlHttpReq;
	dataAlert("Action : " + strURL);
	xmlHttpReq = getXMLHttp();
	xmlHttpReq.open('POST', strURL, true);
	xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlHttpReq.onreadystatechange = function() {
		if (xmlHttpReq.readyState == 4) {
			dataAlert("Parameters : " + params);
			updatepage(id, xmlHttpReq.responseText);
		}
	};
	var params = 'ajaxParam=' + escape(formElementValue);
	dataAlert("Parameters : " + params);
	xmlHttpReq.send(params);
}

function raiseRequestWithParams(id, strURL, userId, approvalStatus, email) {
	placeAjaxImg(id);
	var xmlHttpReq;
	xmlHttpReq = getXMLHttp();
	xmlHttpReq.open('POST', strURL, true);
	xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlHttpReq.onreadystatechange = function() {
		if (xmlHttpReq.readyState == 4) {
			updatepage(id, xmlHttpReq.responseText);
		}
	};
	var params = "userId=" + userId + "&approvalStatus=" + approvalStatus + "&email=" + email;
	xmlHttpReq.send(params);
}

function raiseRequestWithParamsAndProcessFunction(id, strURL, userId, approvalStatus, email, processFn) {
	placeAjaxImg(id);
	var xmlHttpReq;
	xmlHttpReq = getXMLHttp();
	xmlHttpReq.open('POST', strURL, true);
	xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlHttpReq.onreadystatechange = function() {
		if (xmlHttpReq.readyState == 4) {
			processFn(id, xmlHttpReq.responseText, userId, strURL, email);
		}
	};
	var params = "userId=" + userId + "&approvalStatus=" + approvalStatus + "&email=" + email;
	xmlHttpReq.send(params);
}
function sendAjaxRequest(obj) {
	var id = obj.id;
	var params = obj.params;
	var url = obj.url;
	var processFn = obj.responseHandler;
	
	placeAjaxImg(id);
	var xmlHttpReq;
	xmlHttpReq = getXMLHttp();
	xmlHttpReq.open('POST', url, true);
	xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlHttpReq.onreadystatechange = function() {
		if (xmlHttpReq.readyState == 4) {
			if (processFn == null)
				document.getElementById(id).innerHTML = xmlHttpReq.responseText;
			else
				processFn(obj, xmlHttpReq.responseText);
		}
	};
	
	var paramsToSent = "";
	for (x in params) {
		if (params.hasOwnProperty(x))
			paramsToSent = paramsToSent + x + "=" + params[x] + "&";
	}
	// alert(paramsToSent);
	xmlHttpReq.send(paramsToSent);
}
function raiseRequestWithMultipleParamsAndProcessFunction(id, strURL, params, processFn) {
	placeAjaxImg(id);
	var xmlHttpReq;
	xmlHttpReq = getXMLHttp();
	xmlHttpReq.open('POST', strURL, true);
	xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlHttpReq.onreadystatechange = function() {
		if (xmlHttpReq.readyState == 4) {
			processFn(id, xmlHttpReq.responseText, params);
		}
	};
	var paramStr;
	for ( var i = 0; i < params.length; ++i) {
		paramStr = params[i] + "&";
	}
	xmlHttpReq.send(paramStr);
}
function removeAjaxImg(id) {
	document.getElementById(id).innerHTML = "";
}
function placeAjaxImg(id) {
	document.getElementById(id).innerHTML = "<img border=\"0\" src=\"images/small-ajax-loader.gif\"></img>";
}
function placeAjaxMessage(id, msg) {
	document.getElementById(id).innerHTML = msg;
}
function buildQueryString(formElementValue) {
	qstr = 'ajaxParam=' + escape(formElementValue); // NOTE: no '?' before
	// querystring
	return qstr;
}

function getquerystring() {
	var form = document.forms[0];
	var word = form.parameter.value;
	qstr = 'parameter=' + escape(word); // NOTE: no '?' before querystring
	return qstr;
}

function updatepage(id, str) {
	/*
	 * alert(id); alert(str); alert(str.indexOf("disableSubmitRequired"));
	 */
	if (str.indexOf("disableSubmitRequired") != -1) {
		if (document.forms[0] != null && document.forms[0].Next != null) {
			document.forms[0].Next.className = "ButtonStyleDisabled";
			document.forms[0].Next.disabled = true;
		}
	} else {
		if (document.forms[0] != null && document.forms[0].Next != null) {
			document.forms[0].Next.disabled = false;
		}
	}
	if (str.indexOf("disableSubmitRequired") != 1) {
		var string_to_display = str.replace("disableSubmitRequired", ".");
		document.getElementById(id).innerHTML = string_to_display;
	} else {
		document.getElementById(id).innerHTML = str;
	}
}
function getXMLHttp() {
	var xmlHttp;
	try {
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Sorry, Your browser does not support AJAX!");
				return false;
			}
		}
	}
	return xmlHttp;
}