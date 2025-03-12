var GblOpenChk = "";

/**
 * 주소검색을 수행할 팝업 페이지를 호출합니다.
 * 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
 */
function goPopImgMap(){
	var pop = window.open("imgUpload","pop","width=570 height=420 scrollbars=no resizable=no location=no menubar=no"); 
}

/**
 * 이미지 관련 처리
 * @param gbn : table 구분값
 */
function actImgMap(act){
	var dAry = "";
	var vId = "";

	try	{ dAry = $(':radio[name=modalImg]:checked').val().split("/%/"); }catch(e){}

	if(sGbn == "product") {
		GblOpenChk = sGbn;
		vId = $("#pid").val();
		if(vId == ""){ alert("제품 정보를 가져오는데, 실패하였습니다. \n\n화면을 새로고침 후 다시 시도 해주십시오."); return false; }
	}else{
		if(GblOpenChk == "maker") {
			vId = $("#mid").val();
			if(vId == ""){ alert("제조사 정보를 가져오는데, 실패하였습니다. \n\n화면을 새로고침 후 다시 시도 해주십시오."); return false; }
		}else if(GblOpenChk == "brand") {
			vId = $("#sub_mid").val();
			if(vId == ""){ alert("브랜드 정보를 가져오는데, 실패하였습니다. \n\n화면을 새로고침 후 다시 시도 해주십시오."); return false; }
		}
	}
	
	if(($('#img_name').val() == dAry[0]) && act == "imgMapDelete.do"){ alert("대표 이미지는 삭제 할수 없습니다."); return false; }

    $.ajax({
        type:"POST",
        url: act,
        data: {
        	store_id     	 			: vId,
            table_gbn       			: GblOpenChk,
            img_name       				: $('#img_name').val(),
            radio_img_name       		: dAry[0],
    		radio_img_path       		: dAry[1],
    		radio_img_Url       		: dAry[2]
        },
        success:function( ret ) {
        	// 이미지 리스트
        	if(act == "imgMapList.do"){
        		imgBtn("1");
        		if(GblOpenChk == "brand") {
        			$("#divModalsub_Img").show();
            		$("#divsub_Img").html(ret);
        		}else{
        			$("#divModalImg").show();
            		$("#divImg").html(ret);
        		}
        	}
        	// 대표 이미지 등록
        	else if(act == "imgMapUpdate.do"){
        		 if(ret == 1) {
        			 $('#img_name').val(dAry[0]);
        			 $('#img_path').val(dAry[1]);
        			 actImgMap("imgMapList.do");
        			 alert( "대표 이미지가 변경되었습니다. ") 
        		}else { 
        			alert("대표 이미지 변경이 실패하였습니다.") 
        		}
        	}
        	// 이미지 삭제
        	else if(act == "imgMapDelete.do"){
        		if(ret == 1) {
        			alert( "이미지 삭제가 성공하였습니다.")
        			actImgMap("imgMapList.do");
        		}else{
        			alert( "실패하였습니다.")
        		}
        	}
        },
        error:function(e) { alert(e.responseText); }
    });    
}


function insertImgMap(){
	if($("#imgCnt").val() == "2"){
		alert("이미지 등록은 2개까지 가능합니다.");
		return false;
	}
	/* 한글 검사 */
	var pattern =/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	if(pattern.test($('#fileName').val())){
		alert("파일 이름은 한글이 아닌 영문 또는 숫자로 입력 해주십시오.");
		return false;
	}
	
	if(sGbn == "product") {
		GblOpenChk = sGbn;
		vId = $("#pid").val();
		if(vId == ""){ alert("제품 정보를 가져오는데, 실패하였습니다. \n\n화면을 새로고침 후 다시 시도 해주십시오."); return false; }
	}else{
		if(GblOpenChk == "maker") {
			vId = $("#mid").val();
			if(vId == ""){ alert("제조사 정보를 가져오는데, 실패하였습니다. \n\n화면을 새로고침 후 다시 시도 해주십시오."); return false; }
		}else if(GblOpenChk == "brand") {
			vId = $("#sub_mid").val();
			if(vId == ""){ alert("브랜드 정보를 가져오는데, 실패하였습니다. \n\n화면을 새로고침 후 다시 시도 해주십시오."); return false; }
		}
	}
	
	var formData = new FormData();   
    formData.append('source', $('#source')[0].files[0]);
    formData.append('fileName', $('#fileName').val());
    formData.append('store_id', vId);
    formData.append('table_gbn', GblOpenChk);
    
	$.ajax({
        url: "imgMapInsert.do",
        type:"POST",
        processData:false,
        contentType:false,
        data: formData,
        success:function(responese) {
        	if(responese == "1"){
        		alert("등록되었습니다.");
        		actImgMap("imgMapList.do");
        	}else{
        		alert("실패하였습니다.");
        	}
        },
        error:function(e) { alert(e.responseText); }
    });
}


function imgBtn(e){
	var sHtml = "";
	if(e == "1"){
		sHtml = "<button type='button' id='btnUpdate_img' class='btn btn-default' style='float:right;margin-left:2px;' onclick='javascript:actImgMap(\"imgMapUpdate.do\");'>대표이미지</button>";
		sHtml +="<button type='button' id='btnDelete_img' class='btn btn-default' style='float:right;margin-left:2px;' onclick='javascript:actImgMap(\"imgMapDelete.do\");'>삭제</button>";
		sHtml +="<button type='button' id='btnInsert_img' class='btn btn-default' style='float:right;margin-left:2px;' onclick='javascript:imgBtn(\"2\");'>등록</button>";	
	}else if(e == "2"){
		sHtml = "<button type='button' id='btnBack_img' class='btn btn-default' style='float:right;margin-left:2px;' onclick='javascript:imgBtn(\"1\");'>이전으로</button>";
		sHtml +="<button type='button' id='btnSavs_img' class='btn btn-default' style='float:right;margin-left:2px;' onclick='javascript:insertImgMap();'>저장</button>";
		sHtml +="<form id='imgMap-form' name='imgMap-form'>";
		sHtml +="<div style='position:relative;overflow:hidden;float:right;margin-left:2px;'>";
		sHtml +="<button type='button' class='btn btn-default'>찾기</button>";
		sHtml +="<input type='file' id='source' name='source' style='font-size:23px;position:absolute;right:0px;top:0px;opacity:0;filter:alpha(opacity=0);-ms-filter:\"alpha(opacity=0)\";-khtml-opacity:0;-moz-opacity:0;' onchange=\"javascript:getFileName(this.value);\"/>";
		sHtml +="</div>";
		sHtml +="<input type='text' id='fileName' name='fileName' class='form-control' style='float:right;width:100px;'>";
		sHtml +="</form>";
	}
	if(GblOpenChk == "brand") {
		$("#divsub_Btn").html(sHtml);
	}else{
		$("#divBtn").html(sHtml);
	}

	if(e=="2"){ $("#source").click(); }
}

function getFileName(val){
	if(val.indexOf("\\") > -1){
		val = val.substring(val.lastIndexOf("\\")+1);
		/* 한글 검사 */
		var pattern =/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		if(pattern.test(val)){
			alert("파일 이름은 한글이 아닌 영문또는 숫자로 입력 해주십시오.");
		}
	}
//	$("#fileName").val(val.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, ''));
	$("#fileName").val(val);
}


