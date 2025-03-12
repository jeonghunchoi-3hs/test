function sanitizeHTML(str) {
	return str.replace(/&/g, "&amp;")
				 .replace(/</g, "&lt;")
				 .replace(/>/g, "&gt;")
				 .replace(/"/g, "&quot;")
				 .replace(/'/g, "&#039;")
				 .replace(/&lt;br\s*\/?&gt;/g, "<br>");
}

function alertBox(text, functionName){
	modal({
		type:"alert"
		, title : "알림"
		, text : sanitizeHTML(text)
		, callback :function(result){
			if(functionName){
				functionName();
			}
		}
	});
}

function alertBox2(text, functionName, object){
	modal({
		type:"alert"
		, title : "알림"
		, text : sanitizeHTML(text)
		, callback :function(result){
			if(functionName){
				functionName(object);
			}
		}
	});
}

function alertBox3(text){
	modal({
		type:"alert"
		, title : "알림"
		, text : sanitizeHTML(text)
	});
}

function confirmBox(text, functionName){
	modal({
		type:"confirm"
		, title : "알림"
		, text : sanitizeHTML(text)
		, callback :function(result){
			if(result){
				functionName();
			}
		}
	});
}

function confirmBox2(text, functionName, object){
	modal({
		type:"confirm"
		, title : "알림"
		, text : sanitizeHTML(text)
		, callback :function(result){
			if(result){
				functionName(object);
			}
		}
	});
}

function confirmBox4(text, functionName,functionName2, object){
	modal({
		type:"confirm"
		, title : "알림"
		, text : sanitizeHTML(text)
		, custom : "1"
		, callback :function(result){
			console.log(result);
			if(result == true){
				functionName(object);
			} else if(result == "second"){
				functionName2(object);
			}
		}
	});
}

function confirmBox3(text, functionName){
	modal({
		type:"confirm"
		, title : "알림"
		, text : sanitizeHTML(text)
		, callback :function(result){
			functionName(result);
		}
	});
}

function confirmBoxBasket(text, functionName){
	modal({
		type:"confirm"
		, title : "알림"
		, text : sanitizeHTML(text)
		, buttonText: {
			ok: "예",
			yes: "예",
			cancel: "아니오"
		}
		, callback :function(result){
			if(result){
				functionName();
			}
		}
	});
}


function successBox(text){
	modal({
		type:"success"
		, title : "Success"
		, text : sanitizeHTML(text)
	});
}

function warningBox(text){
	modal({
		//type:"warning"
		//, title : "Warning"
		type:"primary"
		, title : "알림"		
		, text : sanitizeHTML(text)
		, center : false
	});
}

function infoBox(text){
	modal({
		type:"info"
		, title : "Info"
		, text : sanitizeHTML(text)
		, autoclose : true
	});
}

function errorBox(text){
	modal({
		type:"error"
		, title : "Error"
		, text : sanitizeHTML(text)
	});
}