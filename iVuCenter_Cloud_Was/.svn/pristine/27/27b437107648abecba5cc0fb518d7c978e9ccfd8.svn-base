<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<c:import url="include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body class="loginBody">

	<!-- begin #page-container -->
	<div id="page-container" class="">
		<!-- begin login-brand -->
		<div class="dpin w100 m-t-100 mb20">
        	<!--  <img src="<%=request.getContextPath()%>/resources/mng/assets/img/Logo.png" alt="로고" />-->
        	<img src="${apachePath}/resources/mng/assets/img/logo_blue.png" alt="로고"/>
        </div>
	    <!-- end login-brand -->
	    
	    <!-- begin login -->
		<div class="login">
		    
		    <!-- begin login-content -->
            <div class="leftLogin">
            	<p class="logintitle">로그인</p>
                <p class="loginsubtitle">K-Cloud 관리자 포털입니다 </p> 
                <form action="${contextPath}/mng/j_spring_security_check" method="post" id="login_form">
                    <div class="leftTotalGroup m-t-30 ">
	                    <div class="inputGroup fl">
	                        <input class="loginInput m-b-10" type="text" placeholder="아이디를 입력해주세요" required autofocus name="j_username" id="username" autocomplete=off>
	                        <input class="loginInput" type="password" placeholder="패스워드를 입력해주세요" required name="j_password" id="password">
	                    </div>
	                    <div class="btnGroup flr">
	                        <button class="loginbnt" type="button" id="login_btn" ></button>
	                    </div>
	                    <label class="check_lock fl m-t-18"><input type="checkbox" id="id_save"><span style="padding-left: 10px; vertical-align: top;">아이디 저장</span></label> 
	                    <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
							<div class="alert alert-danger" role="alert">
				                <a class="close" data-dismiss="alert" href="#"></a>${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
				            </div>
		        		</c:if>
                    </div> 
                </form>
            </div>
            <div class="rightLogin">
            	<p class="f16 fw">아이디와 비밀번호를 잊으셨나요?</p>
            	<a class="loginrightbtn m-t-20" type='button' id="openId">아이디 찾기</a>
            	<a class="loginrightbtn m-t-10" type='button' id="openPw">비밀번호 찾기</a> 
            </div>
		    <!-- end login-content -->
		</div>
		<!-- end login -->
	</div>
	<!-- end page container -->
	
	<div class="modal" id="modal-dialog"> 
		<div class="modal-dialog">
			<div class="modal-content width-570">
               	<div class="modal-header">
               	   <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
                   <h4 class="modal-title" id="searchTitle">ID/비밀번호  찾기</h4>
               	</div>
               	<div class="modal-body">
               		<div class="tabType01 mb30">
               			<input type="hidden" id="h_searchGubun" value="">
						<ul id="tabNavi">
							<li id="searchId"><a href="#sabun-search" data-toggle="tab"><span>ID</span></a></li>
							<li id="searchPw"><a  href="#pw-search" data-toggle="tab"><span>비밀번호</span></a></li>
						</ul>
					</div>
					
					<div class="formType01 bottomArea2 active" id="sabun-search">
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col width="150px">
									 <col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><strong>사용자 이름</strong></th>
										<td><input type="text" style="width:100%" id="pop_userName"  placeholder="이름을 입력하세요"></td>
									</tr>
									<tr>
										<th scope="row"><strong>핸드폰</strong></th>
										<td class="tal"><input type="text" class="width-60" maxlength="3" name="phoneNumber" id="pop_userPhone1"> - <input type="text" class="width-80" maxlength="4" name="phoneNumber" id="pop_userPhone2"> - <input type="text" class="width-80" maxlength="4" name="phoneNumber" id="pop_userPhone3"></td>
									</tr>
									<tr>
										<th scope="row"><strong>이메일</strong></th>
										<td class="tal"><input type="text" class="width-100" id="pop_userMail"> @ 
										                <input type="text" class="width-100" placeholder="직접입력" id="pop_DomainCustom"> 
												<div class="selectBox" style="width:130px;">
												<label class="selectText" for="pop_DomainSelect">--직접입력--</label>
												<select class="search-sel" id="pop_DomainSelect">
													<option value="customAddr">--직접입력--</option>
													<c:forEach items="${getEmailCode}" var="getEmailCode" varStatus="status" >	
													<option value="${getEmailCode.codeName}">${getEmailCode.codeName}</option>
													</c:forEach>
												</select>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>수신방법</strong></th>
										<td>
											<div class="fl optionBox ">
												<label><input type="radio" name="chk_accept" value="SMS" checked="checked"><span class="fontVdn" >SMS</span></label>
												<label><input type="radio" name="chk_accept" value="Mail"><span>메일</span></label>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="noticeCmt m-t-20" >
							<span class="txtBlue">등록한 이름</span>과 <span class="txtBlue">이메일</span>로 아이디를 찾을 수 있습니다.<br/>
							가입시 <span class="txtRed">등록된 SMS, 메일 중 하나로 초기화된 비밀번호가</span><br/>
							<span class="txtRed">발송</span>됩니다.						 
						</div>
					</div> 
					
					<div class="formType01 bottomArea2 " id="pw-search">
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col width="150px">
									 <col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><strong>ID</strong></th>
										<td><input type="text" style="width:100%" id="pop_userId"  placeholder="아이디를 입력하세요"></td>
									</tr>
									<tr>
										<th scope="row"><strong>핸드폰</strong></th>
										<td class="tal"><input type="text" class="width-60" maxlength="3" name="phoneNumber" id="pop_UserPhonepw1"> - <input type="text" class="width-80" maxlength="4" name="phoneNumber" id="pop_UserPhonepw2"> - <input type="text" class="width-80" maxlength="4" name="phoneNumber" id="pop_UserPhonepw3"></td>
									</tr>
									<tr>
										<th scope="row"><strong>이메일</strong></th>
										<td class="tal"><input type="text" class="width-100" id="pop_userMailpw"> @ <input type="text" class="width-100" placeholder="직접입력" id="pop_DomainCustompw"> 
												<div class="selectBox" style="width:130px;">
												<label class="selectText" for="pop_DomainSelectpw">--직접입력--</label>
												<select class="search-sel" id="pop_DomainSelectpw">
													<option value="customAddr">--직접입력--</option>
													<c:forEach items="${getEmailCode}" var="getEmailCode" varStatus="status" >	
													<option value="${getEmailCode.codeName}">${getEmailCode.codeName}</option>
													</c:forEach>
												</select>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>수신방법</strong></th>
										<td>
											<div class="fl optionBox ">
												<label><input type="radio" name="chk_accept2" value="SMS" checked="checked"><span class="fontVdn">SMS</span></label>
												<label><input type="radio" name="chk_accept2" value="Mail"><span>메일</span></label>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="noticeCmt m-t-20" id="">
							<span class="txtBlue">아이디</span>와 <span class="txtBlue">이메일</span>로 비밀번호 초기화를 하실수 있습니다.<br/>
							<span class="txtRed">등록된 이메일 주소와 입력한 이메일 주소</span>가 동일해야 아이디를<br/>
							찾을 수 있습니다.					 
						</div>
					</div> 
            	</div> 
            	
            	<div class="modal-footer tac">
               		<a type='button' class="bton-s bton_blue" data-dismiss="modal" id="searchBtn">찾기</a>	 
	                <a type='button' class="bton-s bton_dgrey" data-dismiss="modal" id="resetBtn">닫기</a>
               	</div>
			</div>
		</div>
    </div>	
   	
<c:import url="include/script.jsp" charEncoding="UTF-8"></c:import> 
	
<script type="text/javascript">
	$(document).ready(function(){
		
		App.init();
		
		/// login 
		window.history.forward();
		if ($.cookie('idSaveChecked') == 'Y') {
			$('input:checkbox[id="id_save"]').prop("checked",true);
 			if ($.cookie('saveLoginId') != '') {
 				$("#username").val($.cookie('saveLoginId'));
 				setTimeout($("#password").focus(),1000);
 			} else {
 				$("#username").focus();
 			}
		};
		
		$("#footer").addClass("tac");
		$('input:checkbox[id="id_save"]').click(function(){
			if ($('input:checkbox[id="id_save"]').is(":checked")) {
				$.cookie('idSaveChecked','Y',{path:'/'});
			} else {
				$.cookie('idSaveChecked','',{path:'/'});
			}
		});
		$("input:text[id='username']").bind('keypress', function(){
			if(event.keyCode==13) { $("#password").focus(); }
		});
		$("input[type='password']").bind('keypress', function(){
			if(event.keyCode==13) { $('#login_form').submit(); }	
		});
		$("#login_btn").click(function(){
			$('#login_form').submit();
		});
		$("#openId").click(function(){
			$("#modal-dialog").modal();
			$("#searchPw").removeClass("on");
			$("#searchId").removeClass("on");
			$("#searchId").addClass("on"); 
			$("#pw-search").removeClass("active");
			$("#sabun-search").removeClass("active");
			$("#sabun-search").addClass("active");
			$("#h_searchGubun").val("searchId");
			$("#searchTitle").text("");
			$("#searchTitle").text("아이디  찾기");
			changeRecv();
		});
		$("#openPw").click(function() {
			$("#modal-dialog").modal();
			$("#searchId").removeClass("on");
			$("#searchPw").removeClass("on");
			$("#searchPw").addClass("on");
			$("#pw-search").removeClass("active");
			$("#sabun-search").removeClass("active");
			$("#pw-search").addClass("active");
			$("#h_searchGubun").val("searchPw");
			$("#searchTitle").text("");
			$("#searchTitle").text("비밀번호 찾기");
			changeRecvpw();
		});
		/// modal 
		$("#searchId").click(function() { // 찾기 탭 구분
			$("#h_searchGubun").val('searchId');
			$("#searchTitle").text("");
			$("#searchTitle").text("아이디 찾기");
			$("#searchPw").removeClass("on");
			$("#searchId").removeClass("on");
			$("#searchId").addClass("on"); 
			initPopup();
			changeRecv();
		});
		$("#searchPw").click(function() { // 찾기 탭 구분
			$("#h_searchGubun").val('searchPw');
			$("#searchTitle").text("");
			$("#searchTitle").text("비밀번호 찾기");
			$("#searchId").removeClass("on");
			$("#searchPw").removeClass("on");
			$("#searchPw").addClass("on");
			initPopup();
			changeRecvpw();
		});
		$("input:text[name='phoneNumber']").bind('change keypress keydown keyup', function() {
			$(this).val( $(this).val().replace(/[^0-9]/gi,''));
// 			if( !( event.keyCode>=48 && event.keyCode<=57 ) ){
// 				event.returnValue=false;
// 		    }
		});
		$("input:radio[name='chk_accept']").bind('change', function() {
			changeRecv();				
		});
		$("input:radio[name='chk_accept2']").bind('change', function() {
			changeRecvpw();				
		});
		$("#pop_DomainSelect").bind('change', function() {
			var mailValue=$("#pop_DomainSelect > option:selected").val();
			if(mailValue == 'customAddr') {
				$("#pop_DomainCustom").attr("readonly", false);
			} else {
				$("#pop_DomainCustom").attr("readonly", true);
				$("#pop_DomainCustom").val("")
			}
		});
		$("#pop_DomainSelectpw").bind('change', function() {
			var mailValue = $("#pop_DomainSelectpw > option:selected").val();
			if(mailValue == 'customAddr') {
				$("#pop_DomainCustompw").attr("readonly", false);
			} else {
				$("#pop_DomainCustompw").attr("readonly", true);
				$("#pop_DomainCustompw").val("");				
			}
		});
		// ajax 요청
		$("#searchBtn").click(function(){
			var gubun = $("#h_searchGubun").val(); 
			if     (gubun == "searchId"){ idsearch(); }
			else if(gubun == "searchPw"){ pwsearch(); }
		});
		// 취소
		$("#resetBtn").click(function(){
			resetPopup();
		});
	}); // end of document
	
	// 알람 후 focus 이동 callback 함수
	function focusField(id) {
		$(id).focus();
	}
		
	// modal page
	function initPopup(){		
		$("#pop_userName").val("");
		$("#pop_userId").val("");
		$("#pop_userMail").val("");
		$("#pop_userMailpw").val("");		
		$("input[name='chk_accept']:radio[value='SMS']").prop("checked", true);
		$("input[name='chk_accept2']:radio[value='SMS']").prop("checked", true);
	}	
	
	function changeRecv() {
		var chk = $("input:radio[name='chk_accept']:checked").val()
		if(chk =='SMS') {
			$("#pop_userMail").val("");
			$("#pop_DomainCustom").val("");
			$("#pop_DomainSelect").val("customAddr");
			$("#pop_DomainSelect").val('customAddr').attr("selected", "selected");
			$("#pop_DomainSelect").siblings(".selectText").text($("#pop_DomainSelect").children('option:selected').text());
			
			$("#pop_userMail").attr("readonly", true);
			$("#pop_DomainCustom").attr("readonly", true);
			$("#pop_DomainSelect").attr("disabled", true);
			$("#pop_userPhone1").attr("readonly", false);
			$("#pop_userPhone2").attr("readonly", false);
			$("#pop_userPhone3").attr("readonly", false);
			
		} else {
			$("#pop_userPhone1").val("");
			$("#pop_userPhone2").val("");
			$("#pop_userPhone3").val("");
			
			$("#pop_userMail").attr("readonly", false);
			$("#pop_DomainCustom").attr("readonly", false);
			$("#pop_DomainSelect").attr("disabled", false);
			$("#pop_userPhone1").attr("readonly", true);
			$("#pop_userPhone2").attr("readonly", true);
			$("#pop_userPhone3").attr("readonly", true);			
		}
	}
	
	function changeRecvpw() {
		var chk = $("input:radio[name='chk_accept2']:checked").val()
		if(chk == 'SMS') {
			$("#pop_userMailpw").val("");
			$("#pop_DomainCustompw").val("");
			$("#pop_DomainSelectpw").val("customAddr");			
			$("#pop_DomainSelectpw").val("customAddr").attr("selected", "selected");
			$("#pop_DomainSelectpw").siblings(".selectText").text($("#pop_DomainSelectpw").children('option:selected').text());
			
			$("#pop_userMailpw").attr("readonly", true);
			$("#pop_DomainCustompw").attr("readonly", true);
			$("#pop_DomainSelectpw").attr("disabled", true);
			$("#pop_UserPhonepw1").attr("readonly", false);
			$("#pop_UserPhonepw2").attr("readonly", false);
			$("#pop_UserPhonepw3").attr("readonly", false);			
		} else {
			$("#pop_UserPhonepw1").val("");
			$("#pop_UserPhonepw2").val("");
			$("#pop_UserPhonepw3").val("");
			
			$("#pop_userMailpw").attr("readonly", false);
			$("#pop_DomainCustompw").attr("readonly", false);
			$("#pop_DomainSelectpw").attr("disabled", false);
			$("#pop_UserPhonepw1").attr("readonly", true);
			$("#pop_UserPhonepw2").attr("readonly", true);
			$("#pop_UserPhonepw3").attr("readonly", true);			
		}
	}
	
	// 사용자 아이디 찾기
	function idsearch(){
		//alert("사용자 아이디 검색");
		if($("#pop_userName").val()==""){
			alertBox2("사용자 이름을 입력하세요", focusField, "#pop_userName");
			return false;
		}
		var chk = $("input:radio[name='chk_accept']:checked").val()
		if(chk == "SMS") {
			if($("#pop_userPhone1").val()==""){
				alertBox2("사용자 핸드폰을 입력하세요", focusField, "#pop_userPhone1");
				return false;
			}				
			if($("#pop_userPhone2").val()==""){
				alertBox2(" 사용자 핸드폰을 입력하세요", focusField, "#pop_userPhone2");
				return false;
			}
			if($("#pop_userPhone3").val()==""){
				alertBox2(" 사용자 핸드폰을 입력하세요", focusField, "#pop_userPhone3");
				return false;
			}				
		} else {
			if($("#pop_userMail").val()==""){
				alertBox2("사용자 이메일주소을 입력하세요", focusField, "#pop_userMail");				
				return false;
			}
			var domain = $("#pop_DomainSelect > option:selected").val();
			var custom = $("#pop_DomainCustom").val();
			if( (domain=="customAddr") && (custom=="") ) {
				alertBox2("사용자 이메일주소을 입력하세요", focusField, "#pop_DomainCustom");				
				return false;
			}
		}
		var jsonData = setJsonData(chk);
		$.ajax({
			url : "${wasPath}/mng/mnginfo/useridSearch",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				if(data==0){
					alertBox3("입력된 정보와 일치 하는 아이디가 없습니다.");
				}else{
					alertBox3("아이디 찾기 성공, 선택한 수신방법으로 발송");
				}
				initPopup();
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function setJsonData(chk){	
		var phone1=$("#pop_userPhone1").val();
		var phone2=$("#pop_userPhone2").val();
		var phone3=$("#pop_userPhone3").val();			
		var userPhone = phone1+"-"+phone2+"-"+phone3;
	
		var domain = $("#pop_DomainSelect > option:selected").val();
		var userMail = $("#pop_userMail").val() + "@";						
		userMail += (domain == "customAddr") ? $("#pop_DomainCustom").val() : domain;
		
		var jsonData = {
				"userName" : $("#pop_userName").val()										
				, "recvFlag" : chk
				, "userPhone" : userPhone
				, "userMail" : userMail
			};
		return jsonData;
	}
	
	// 사용자 비밀번호 찾기
	function pwsearch(){		
		if($("#pop_userId").val()==""){
			alertBox2("사용자 아이디을 입력하세요", focusField, "#pop_userId");
			return false;
		}
		var chk = $("input:radio[name='chk_accept2']:checked").val()
		if(chk == "SMS") {
			if($("#pop_userPhonepw1").val()==""){
				alertBox2("사용자 핸드폰을 입력하세요", focusField, "#pop_userPhonepw1");
				return false;
			}
			if($("#pop_userPhonepw2").val()==""){
				alertBox2("사용자 핸드폰을 입력하세요", focusField, "#pop_userPhonepw2");
				return false;
			}
			if($("#pop_userPhonepw3").val()==""){
				alertBox2("사용자 핸드폰을 입력하세요", focusField, "#pop_userPhonepw3");
				return false;
			}
		} else {
			if($("#pop_userMailpw").val()==""){
				alertBox2("사용자 이메일주소을 입력하세요", focusField, "#pop_userMailpw");
				return false;
			}
			var domain = $("#pop_DomainSelectpw > option:selected").val();
			var custom = $("#pop_DomainCustompw").val();
			if( (domain=="customAddr") && (custom=="") ) {
				alertBox2("사용자 이메일주소을 입력하세요", focusField, "#pop_DomainCustompw");
				return false;
			}
		}
		var jsonData = setJsonDatapw(chk);
		$.ajax({
			url : "${wasPath}/mng/mnginfo/userpwSearch",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				if(data==0){
					alertBox3("입력된 정보와 일치 하는 정보가 없습니다.");
				}else{
					alertBox3("비밀번호 찾기 성공<br/>선택한 수신방법으로 발송<br/>비밀번호 초기화");
				}
				initPopup();
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function setJsonDatapw(chk){	
		var phone1=$("#pop_UserPhonepw1").val();
		var phone2=$("#pop_UserPhonepw2").val();
		var phone3=$("#pop_UserPhonepw3").val();			
		var userPhone = phone1+"-"+phone2+"-"+phone3;
	
		var domain = $("#pop_DomainSelectpw > option:selected").val();
		var userMail = $("#pop_userMailpw").val() + "@";
		userMail += (domain=="customAddr") ? $("#pop_DomainCustompw").val() : domain;
		
		var jsonData = {
				"userId"	: $("#pop_userId").val()					
				, "recvFlag": chk
				, "userPhone": userPhone
				, "userMail": userMail
			};
		return jsonData;
	}
</script>
	 
</body>
</html>