var today = new Date(); 
var nowYear = today.getFullYear(); // 로컬 컴퓨터의 년(year)을 구함
var nowMonth = today.getMonth()+1; // 로컬 컴퓨터의 월(month)을 구함
nowMonth = nowMonth<10 ? "0"+nowMonth: nowMonth;
var nowDate = today.getDate(); // 로컬 컴퓨터의 일(day)을 구함  
nowDate = nowDate<10 ? "0"+nowDate: nowDate;
var nowToday = nowYear.toString()+ nowMonth.toString() +nowDate.toString();
	
/**
 * 콤보박스를 생성해서 div에 삽입한다.
 * @param ary	: option에 삽입할 배열 값
 * 					배열 [0] : text
 * 					배열 [1] : value
 * @param div	: 화면에 출력할 div 이름
 * @param id	: 필드 이름
 * @param width : 콤보박스 가로 길이
 * @param event	: 자바스크립트 이벤트
 */
function setComboBox(ary, div, id, width, event){   
	var ret = "";
	var aLen = getFieldLenVal(ary);
	var css = "";
	if(width != "") { css = "style='width:"+width+";' "; }	
	ret = "<select id='" + id + "' name='" + id + "' " + css + " " + event + " >";
	for(var i=0; i<aLen; i++) {
		if(ary[i][0] == ""){
			ret += "<option value='' >  : : 선택 : :  </option>";			
		}else{
			ret += "<option value='" + ary[i][1] + "' >" + ary[i][0] + "</option>";	
		}
	}	
	ret += "</select>" ;
	$('#'+div).html( ret );
}
 
function setComboBox2(ary, div, id, width, event, text){   
	var ret = "";
	var aLen = getFieldLenVal(ary);
	var css = "";
	if(width != "") { css = "style='width:"+width+";' "; }	
	ret = "<select id='" + id + "' name='" + id + "' " + css + " " + event + " >";
	ret += "<option value='' >" + text + "</option>";			
	for(var i=0; i<aLen; i++) {
		ret += "<option value='" + ary[i][1] + "' >" + ary[i][0] + "</option>";	
	}	
	ret += "</select>" ;
	$('#'+div).html( ret );
}

/**
 * DB 값으로 selectBox 생성
 * @param1 act
 * @param2 div
 * @param3 id
 * @param4 width
 * @param5 event
 * @param6 actSub
 * @param7 val
 * @param8 text
 */
function setComboBoxDb(act, div, id, width, event, actSub, val, text){   
	 $.ajax({
        url: act,
        data:{
        	id: id,
        	width: width,
        	event: event,
        	actSub: actSub,
        	text: text
        },
        dataType: "html",
        type: "GET",
        success: function( ret ) {
              $("#"+div).html(ret);        
              $("#"+id).val(val);        
        },
        error: function(e) { alert(e.responseText); }
  });
}

/**
 * code.js 의 value 값을 text로 변경
 * @param data
 * @param ary
 * @returns
 */
function getValue(data, ary){
	for(var i=0;i<getFieldLenVal(ary);i++){
		if(ary[i][1]== data){
			data = ary[i][0];
			return data;
		}
	}
	return data;
}

/**
 * input 생성
 * @param div
 * @param id
 * @param val
 * @param text
 * @param width
 * @param event
 */

function setText(div, id, val, text, width, event){   
	var ret = "";
	var css = "";
	if(width != "") { css = "style='width:"+width+";' "; }	
	ret = "<input type='text' id='" + id + "' name='" + id + "' " + css + " " + event + " value='"+val+"' placeholder='"+text+"' />";
	$('#'+div).html( ret );
}

/**
 * Radio 생성(css 수정 해야됨)
 * @param ary
 * @param div
 * @param id
 * @param width
 * @param event
 */
function setRadio(ary, div, id){
	var ret = "";
	var aLen = getFieldLenVal(ary);
	var css = "";
	 // ret = "<div class='radio'>";
	for(var i=0; i<aLen; i++) {
		ret += "<label style='padding-left:10px;'><input type='radio' style='min-height:10px;margin-top:2px;margin-bottom:2px;vertical-align:middle;' name='" + id + "' id='"+id+i+"' value='"+ary[i][1]+"'>" + ary[i][0] + "</label>";	
	}
	 // ret += "</div>";
	$('#'+div).html( ret );	
}

/**
 * 날짜 형식 변환 
 * @param ret
 * @returns
 */
function getDateChangeStr( ret ){
	//console.log(ret);
	//console.log(checkDigitOnly( ret ));
	//console.log(getFieldLenVal(ret));
	if(checkDigitOnly( ret )){
		if(getFieldLenVal(ret) == 8){
				return ret.substring(0,4) + "-" + ret.substring(4,6) + "-"+ ret.substring(6,8);
		}
		else if(getFieldLenVal(ret) == 12){
				return ret.substring(0,4) + "-" + ret.substring(4,6) + "-"+ ret.substring(6,8) + ' '+ ret.substring(8,10) +':'+ret.substring(10,12);
		}
		else if(getFieldLenVal(ret) == 14){
				return ret.substring(0,4) + "-" + ret.substring(4,6) + "-"+ ret.substring(6,8) + ' '+ ret.substring(8,10) +':'+ret.substring(10,12)+':'+ret.substring(12,14);	
		}
	}else{
		var d = new Date(ret); 
		if(d != undefined){
			var vMonth = d.getMonth()+1<10 ? "0"+(d.getMonth()+1): d.getMonth()+1;
			var vDate = d.getDate()<10 ? "0"+d.getDate(): d.getDate();
			var vHours = d.getHours()<10 ? "0"+d.getHours(): d.getHours();
			var vMinutes = d.getMinutes()<10 ? "0"+d.getMinutes(): d.getMinutes();
			return d.getFullYear() +'/'+ vMonth +'/'+ vDate + ' '+ vHours +':'+vMinutes+'';	
		}else{
			return ret;
		}
	}
}

/**
 *  숫자만 입력 가능 
 */
function number_only(id){
	$(id).val( $(id).val().replace(/[^0-9]/gi,''));
	if( !( event.keyCode>=48 && event.keyCode<=57 ) ){
		event.returnValue=false;
    }
}

/**
 * 필드 value의 길이를 리턴
 * @param s
 * @returns
 */
function getFieldLenVal(s) {
	var v = 0;
	try{ v = s.length; }catch(e){ }
	return v;
}

/**
 * Function : removeSpeDel( str )
 * Comment  : 텍스트 필드의 분리자(특수문자)를 제거하는 함수, 컴마, 하이픈 등을 제거한다.
 * 사 용 예 : onFocus="removeSpeDel('2050-12-31')"
 * @param {Object} str
 */
function removeSpeDel( str ) {
	if(str!=undefined){
		var rxSplit = new RegExp('([\(\) ,/:-])');
		var i=0;
		do{ str = str.replace(rxSplit,''); }while( rxSplit.test( str ) )
	}
	return str;
}

/**
 * 숫자 이외의 캐릭터가 있을경우 false
 * @param {Object} digitChar
 */ 
function checkDigitOnly( digitChar ) {  
	if ( digitChar == null ) return false ;
	var strLen = getFieldLenVal(digitChar);
	for(var i=0;i<strLen;i++){          
		var c=digitChar.charCodeAt(i);       
		if( !(  0x30 <= c && c <= 0x39 ) ) { return false ; }
	}      
	return true ;
}

/**
 * 주민번호 및 사업자번호 입력시 자동으로 -(하이픈)을 입력한다.
 * @param {Object} str
 */
function getSsnChangeStr(str){
	var len = getFieldLenVal(str);
	var tmpStr1 = "";
	var tmpStr2 = "";
	var tmpStr3 = "";
	var ret = str;
	var flag = 0;

	if (len == 14) {
		if(str.indexOf("-")>-1) { str = str.replace("-", ""); }
		try{
			str = str.substring(0,13);
			len = getFieldLenVal(str);
		}catch(e){}
	}
	
	if(len == 13){
		try{
			tmpStr1 = str.substring(0,6);
			tmpStr2 = str.substring(6,13);
			flag = 1;
		}catch(e){}
		if(flag==1){ ret = tmpStr1 + "-" + tmpStr2; }
	}
	else if(len == 10){
		try{
			tmpStr1 = str.substring(0,3);
			tmpStr2 = str.substring(3,5);
			tmpStr3 = str.substring(5,10);
			flag = 1;
		}catch(e){}
		if(flag==1){ ret = tmpStr1 + "-" + tmpStr2 + "-" + tmpStr3; }
	}
	return ret;
}
/**
 * 우편번호 입력시 자동으로 -(하이픈)을 입력한다.
 * @param {Object} str
 */
function getZipChangeStr(str){
	var tmpStr1 = "";
	var tmpStr2 = "";
	var ret = "";
	var len = getFieldLenVal(str);	
	if(len == 6){
		try{
			tmpStr1 = str.substring(0,3);
			tmpStr2 = str.substring(3,6);
		}catch(e){}
		ret = tmpStr1 + "-" + tmpStr2;
	}
	return ret;
}
/**
 * 전화번호 입력시 자동으로 -(하이픈)을 입력한다.
 * @param {Object} tel
 */
function getTelChangeStr(tel){
	var len = getFieldLenVal(tel);
	var ret = "";	
	var tmp = "";
	var tmpTel1 = "";
	var tmpTel2 = "";
	var tmpTel3 = "";
	ret = tel;

	if(len == 11){
		try{
			if(tel.substring(0,4) == "0505"){
				tmpTel1 = tel.substring(0,4);
				tmpTel2 = tel.substring(4,7);
				tmpTel3 = tel.substring(7,11);
			}else{
				tmpTel1 = tel.substring(0,3);
				tmpTel2 = tel.substring(3,7);
				tmpTel3 = tel.substring(7,11);
			}
		}catch(e){}
		ret = tmpTel1 + "-" + tmpTel2 + "-" + tmpTel3;
	}else if(len == 10){
		try{
			tmp = tel.substring(0,2);
		}catch(e){}

		if(tmp == 02){
			try{
				tmpTel1 = tel.substring(0,2);
				tmpTel2 = tel.substring(2,6);
				tmpTel3 = tel.substring(6,10);
			}catch(e){}
			ret = tmpTel1 + "-" + tmpTel2 + "-" + tmpTel3;
		}else{
			try{
				tmpTel1 = tel.substring(0,3);
				tmpTel2 = tel.substring(3,6);
				tmpTel3 = tel.substring(6,10);
			}catch(e){}
			ret = tmpTel1 + "-" + tmpTel2 + "-" + tmpTel3;
		}
	}else if(len == 9){
		try{
			tmp = tel.substring(0,2);
		}catch(e){}
		
		if(tmp == 02){
			try{
				tmpTel1 = tel.substring(0,2);
				tmpTel2 = tel.substring(2,5);
				tmpTel3 = tel.substring(5,9);
			}catch(e){}
			ret = tmpTel1 + "-" + tmpTel2 + "-" + tmpTel3;
		}
	}else if(len == 8){
		try{
			tmpTel1 = tel.substring(0,4);
			tmpTel2 = tel.substring(4,8);
		}catch(e){}
		ret = tmpTel1 + "-" + tmpTel2;
	}
	return ret;
}

/**
 * 주민번호, 날짜 형식등 특별하게 지정된 항목을 검증한다. 
 * @param id
 * @param fType
 * @returns
 */
function changeValue(id, fType) { 
	if(fType == "jumin") {
		$(id).val( getSsnChangeStr( $(id).val() ) );
	}
	else if(fType == "zip") {
		$(id).val( getZipChangeStr( $(id).val() ) );
	}
	else if(fType == "phone"){
		$(id).val( getTelChangeStr( $(id).val() ) );
	}
	else if(fType == "num") {
		$(id).val( removeSpeDel($(id).val()) );
	}
	else if(fType == "date"){
		$(id).val( getDateChangeStr( $(id).val() ) );
	}
}

// 이메일 여부 체크 
function chkEmail(id){
	var Ret = $(id).val();
   	if( Ret != "" && (Ret.indexOf("@")== -1 || Ret.indexOf(".")== -1)) {
        alert("이메일 형식으로만 가입이 가능합니다.");    
        $(id).focus();
    }
}

// 오른쪽에 자릿수만큼 0 추가
function getSpaceR(str, width){
	var retValue = str;
	var strR = "";
	var aLen = getFieldLenVal(str);
	if(aLen < width){
		for(var i=0;i<width;i++){ strR+="0";}
		retValue = str+strR;
		retValue = retValue.substring(0,width);
	}
	return retValue;
}


//금액에 콤마 추가
function addcomma(n){
	if(isNaN(n)){
		return 0;
	}else{
		var reg=/(^[+-]?\d+)(\d{3})/;
		n +='';
		
		if( n.indexOf(".") != -1){ 
			n = n.split(".")[0];
		}		
		
		while(reg.test(n)){
			n=n.replace(reg,'$1'+','+'$2');
		}				
	return n;
	}
}

function rtnnumber(n){
	n="" + n;
	n=n.replace(/,/g,"");
	if(isNaN(n)){
		return 0;
	}else{
		return n;
	}
}

function onlyEngNumDash(id){

//		$(id).val( $(id).val().replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g,''));
	$(id).val( $(id).val().replace(/[^a-zA-Z0-9_-]/g,''));
	if(
			!(event.keyCode == 45 
			|| event.keyCode == 95
			|| event.keyCode>=65 && event.keyCode<=90
			|| event.keyCode>=97 && event.keyCode<=122
			|| event.keyCode < 12592 
			|| event.keyCode > 12687
			)
		){
		event.returnValue=false;
	}else{
		event.returnValue=true;
	}
}

// 천단위 이상의 숫자에 콤마(,)를 삽입하는 함수
function inputNumberWithComma(id) {
	$(id).val( $(id).val().replace(/\,/g, "") );
	$(id).val( $(id).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,") );
}

var console = window.console || {log:function(){}};

