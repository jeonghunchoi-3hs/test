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
<body class="loginbg">
<%
if(request.getCookies() != null){
	Cookie[] cookies=request.getCookies();
	for(int i=0;i<cookies.length;i++){
		if(cookies[i].getName().equals("cookieName")){
			cookies[i].setMaxAge(0);
			cookies[i].setPath("0");
			response.addCookie(cookies[i]);
		}
	}
}
%>
	<div class="login_Logo clearfix">
        <img src="${apachePath}/resources/assets/img/logo_blue.png"  class="tac" alt="로고" />
    </div> 
	<!-- begin #page-container -->
	<div class=""> 

	<div id="page-container" class="fade page-container clearfix"> 
		<!-- begin login-brand -->
        
	    <!-- begin login -->
		<div class="loginBgArea clearfix">
		    <h4 class="login-title">Welcome</h4>
		    <!-- end login-brand -->
		    <!-- begin login-content -->
            <div class="login_InfoArea">
            	
                <h4 class="login-info">클라우드 사용자 포털 입니다.</h4>
                	<div class="idpwArea">
                		<form action="${wasPath}/mbr/j_spring_security_check" method="post" id="login_form" name="login_form" class="form-input-flat">
                    	<input type="text" class="form-control loginInput" placeholder="아이디를 입력해주세요"  name="j_username" id="username" required autofocus style="ime-mode:inactive;" autocomplete=off>
                   	 	<input type="password" class="form-control loginInput" placeholder="비밀번호를 입력해주세요" name="j_password" id="password" required>
	                    <a class="loginbtn" type='button' id="login_btn">
	                    	<i class="fa fa-sign-in f30"></i> <br/>로그인   </a>
		                <div class="checkboxArea">
		                <!-- <input type="checkbox" name="adchk" id="adchk" data-original-title="" title="">사번 저장 -->
		                </div>
		                </form>
                    </div>
					<div class="clear"></div>
					<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
					<div class='idpwArea mt0'>
						<div class="alert alert-danger" role="alert">
			                <a class="close" data-dismiss="alert" href="#">×</a>${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
			            </div>
			        </div>
	        		</c:if>
            </div>
          
		    <!-- end login-content -->
		</div>
		
		<!-- end login -->
	</div>
	
	<!-- end page container -->
	</div>
	
	<div class="loginBTArea clearfix">
		  <div class="BTArea mr10">
		 	<img src="${apachePath}/resources/assets/img/member_join.png" alt="" />
		 	<div class="btn-Area">
			 	<span class="btComment">회원가입을 통해 'K-Cloud'의  <br/>다양한  서비스를 이용하실 수 있습니다.</span>
			 	<p>
				 	<a class="btnBT" href="${wasPath}/mbr/req/user/agreementList">
						회원가입
					</a>
				</p>
			</div>
		</div> 
     <%--    <div class="BTArea mr10">
		 	<img src="${apachePath}/resources/assets/img/member_join.png" alt="" />
		 	<div class="btn-Area">
			 	<span class="btComment">'K-Cloud'의  <br/>다양한  서비스를 이용하실 수 있습니다.</span>
			 	<p>
				</p>
			</div>
		</div> --%>

		<div class="BTArea">
			<img src="${apachePath}/resources/assets/img/id_pw_find.png" alt="" />
			<div class="btn-Area">
			 	<span class="btComment">ID와 비밀번호를 잊으셨나요? </span>
			 	<p class="mt20">
				 	<%-- <a class="btnBT" href="${wasPath}/mbr/mbrinfo/mbrinfosearch.do"> --%>
				 	<a class="btnBT" type='button' id="openId">ID</a>
					<a class="btnBT" type='button' id="openPw">비밀번호</a>
				</p>
			</div>
		</div>
	</div>
	 
		<!-- #modal-dialog -->
		<div class="modal fade" id="modal-dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						<h4 class="modal-title" id="searchTitle">ID/비밀번호 찾기</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" id="h_searchGubun" value="" />     
						<ul class="tap nav-pills nav-pills-primary z-in" id="tabNav">
                            <li class="active" id="searchId"><a href="#sabun-search" data-toggle="tab">ID찾기</a></li>                           
                            <li id="searchPw"><a href="#pw-search" data-toggle="tab">비밀번호</a></li>
                        </ul>
                        
                        <div class="bottomArea3  active" id="sabun-search"> 
							<table class="tableL">
								<colgroup>
									<col width="20%">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
                				  		<td>수신방법</td> 
                				  		<td>
                				  			<input type="radio" name="chk_accept" value="SMS"  checked="checked"> SMS</input>
	                   				     	<input class="ml30" type="radio" name="chk_accept" value="Mail"> 메일 </input>
										</td>
                                  	</tr>
                                  	<tr>
                                  		<td>사용자 이름 </td> 
                                  		<td><input type="text" id="pop_userName" class="input_int" placeholder="이름을 입력하세요"/></td>
                                  	</tr>
                                  	<tr id="pop_userPhoneArea">
                				  		<td>핸드폰</td> 
										<td>
	                				  		<div class="searchBoxArea dpin width-100"> 
												<label class="selectBoxDrop pt4">선택</label>	                  		
												<select id="pop_userPhone_id_1" class="search-sel" >
													<option value="" selected="selected">선택</option>
													<option value="010">010</option>
													<option value="011">011</option>
													<option value="016">016</option>
													<option value="017">017</option>
													<option value="018">018</option>
													<option value="019">019</option>
												</select>
											</div>
											<input id="pop_userPhone_id_2" type="text" class="form-control width-100 dpin ml10"  maxlength="4" name="phoneNumber" />  <span class="f20 fc99"> - </span> 
											<input id="pop_userPhone_id_3" type="text" class="form-control width-100 dpin" maxlength="4" name="phoneNumber" />
			                  	       	</td>
                				  	</tr>
                				  	<tr id="pop_userMailArea">
										<td>이메일</td>
                				   		<td>
											<input type="text" class="width-120 form-control dpin" id="pop_userMailpw"> @ <input type="text" class="width-100 form-control dpin" id="pop_DomainCustompw" value="kepco.co.kr"> 
											<div class="searchBoxArea dpin width-140">
												<label class="selectBoxDrop" for="pop_DomainSelectpw">--직접입력--</label>
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
                                  		<td colspan="2">
											<i class="fa fa-exclamation-circle fc-red f24 vm"></i> <span class="fc1d4766">등록한 이름</span>과 <span class="fc1d4766">SMS/이메일</span>로 ID를 찾으실 수 있습니다<br/>
											<span class="fcde4e4e pl20">가입시 등록된 SMS, 메일과 입력한 값</span>이 동일해야 	ID를 찾을 수 있습니다<br/> 
                                  		</td>
                                  	</tr>
								</tbody>
							</table>
						</div>
						<div class="bottomArea3" id="pw-search">
							<table class="tableL">
								<colgroup>
									<col width="20%">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<td>수신방법 </td>
										<td>
											<input  type="radio" name="chk_accept2" value="SMS" checked="checked"> SMS
											<input class="ml30" type="radio" name="chk_accept2" value="Mail"> 메일
										</td>
									</tr>
									<tr>
										<td>ID </td>
										<td><input type="text" id="pop_userId" class="input_int" placeholder="ID를 입력하세요" ></td>
									</tr>
									<tr id="pop_userPhonepwArea">
										<td>핸드폰</td>
										<td>
											<div class="searchBoxArea dpin width-100"> 
												<label class="selectBoxDrop pt4">선택</label>	                  		
					                  			<select id="pop_userPhone_pw_1" class="search-sel" >
					                  				<option value="" selected="selected">선택</option>
						                  			<option value="010">010</option>
						                  			<option value="011">011</option>
						                  			<option value="016">016</option>
						                  			<option value="017">017</option>
						                  			<option value="018">018</option>
						                  			<option value="019">019</option>
						                  		</select>
					                  		</div>
											<input id="pop_userPhone_pw_2" type="text" class="form-control width-80 dpin ml20"  maxlength="4" name="phoneNumber" />
					                  		<span class="f20 fc99"> - </span> 
					                  		<input id="pop_userPhone_pw_3" type="text" class="form-control width-80 dpin" maxlength="4" name="phoneNumber" />
										</td>
									</tr>
									<tr id="pop_userMailpwArea">
										<td>이메일</td>
                                  		<td>
											<input type="text" class="width-120 form-control dpin" id="pop_userMailpw"> @ 
			               					<input type="text" class="width-100 form-control dpin" id="pop_DomainCustompw" value="kepco.co.kr"> 
											<div class="searchBoxArea dpin width-140">
												<label class="selectBoxDrop" for="pop_DomainSelectpw">--직접입력--</label>
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
										<td colspan="2">
											<i class="fa fa-exclamation-circle fc-red f24 vm"></i> <span class="fc1d4766">ID</span>와 <span class="fc1d4766">이메일</span>로 비밀번호 초기화를 하실수 있습니다.<br/> 
											<p class="f14 fc66 pl20">가입시 <span class="fcde4e4e">등록된 SMS, 메일 중 하나로 초기화된 비밀번호가 발송</span>됩니다.</p>
                                  		</td>
									</tr>
								</tbody>
							</table>
						</div>                  		
                    </div> 
					<div class="modal-footer tac"> 
						<a type='button' class="lbtn" data-dismiss="modal" id="searchBtn" >찾기</a>	 
						<a type='button' class="rbtn" data-dismiss="modal" id='resetBtn'>닫기</a>
					</div>
				</div>
			</div>
		</div>
		<!-- #modal-dialog -->
		
	</body>
	
	<c:import url="include/script.jsp" charEncoding="UTF-8"></c:import>
	<script type="text/javascript">		 
		$(document).ready(function(){
			App.init();
			
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
	 			$("#searchPw").removeClass("active");
	 			$("#searchId").removeClass("active");
	 			$("#searchId").addClass("active");
	 			$("#pw-search").removeClass("active");
	 			$("#sabun-search").removeClass("active");
	 			$("#sabun-search").addClass("active");
	 			$("#h_searchGubun").val("searchId");
	 			$("#searchTitle").text("");
	 			$("#searchTitle").text("ID 찾기");
				changeRecv();
			});
			$("#openPw").click(function() {
				$("#modal-dialog").modal();
	 			$("#searchId").removeClass("active");
	 			$("#searchPw").removeClass("active");
	 			$("#searchPw").addClass("active");
	 			$("#pw-search").removeClass("active");
	 			$("#sabun-search").removeClass("active");
	 			$("#pw-search").addClass("active");
	 			$("#h_searchGubun").val("searchPw");
	 			$("#searchTitle").text("");
	 			$("#searchTitle").text("비밀번호 찾기");
				changeRecv();
			}); 
			// modal 
			$("#searchId").click(function() { // 찾기 탭 구분
				$("#h_searchGubun").val('searchId');
				$("#searchTitle").text("");
				$("#searchTitle").text("ID 찾기");
				resetPopup();
			});
			$("#searchPw").click(function() { // 찾기 탭 구분
				$("#h_searchGubun").val('searchPw');
				$("#searchTitle").text("");
				$("#searchTitle").text("비밀번호 찾기");
				resetPopup();
			});
			$("input:text[name='phoneNumber']").bind('change keypress keydown keyup', function() {
				$(this).val( $(this).val().replace(/[^0-9]/gi,''));
// 				if( !( event.keyCode>=48 && event.keyCode<=57 ) ){
// 					event.returnValue=false;
// 			    }
			});
			$("input:radio[name='chk_accept']").bind('change', function() {
				changeRecv();				
			});
			$("input:radio[name='chk_accept2']").bind('change', function() {
				changeRecv();				
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
			$("#searchBtn").click(function() {
				var gubun = $("#h_searchGubun").val(); 
				if (gubun == "searchId"){ 
					idsearch(); 
				} else if (gubun == "searchPw") {
					pwsearch(); 
				}
			});
			// 취소
			$("#resetBtn").click(function(){
				resetPopup();
			});
		}); // end of document.ready()
	
		function resetPopup(){
			$("#pop_userName").val("");
			$("#pop_userId").val("");			
			$("#pop_userMail").val("");			
			$("#pop_userMailpw").val("");
			$("#pop_userPhone_id_1").val("");
			$("#pop_userPhone_id_2").val("");
			$("#pop_userPhone_id_3").val("");
			$("#pop_userPhone_pw_1").val("");
			$("#pop_userPhone_pw_2").val("");
			$("#pop_userPhone_pw_3").val("");
			$("input[name='chk_accept']:radio[value='SMS']").prop("checked", true);
			$("input[name='chk_accept2']:radio[value='SMS']").prop("checked", true);
			
			$("#pop_DomainSelect").val("customAddr");			
			$("#pop_DomainSelect").val("customAddr").attr("selected", "selected");
			$("#pop_DomainSelect").siblings(".selectBoxDrop").text($("#pop_DomainSelect").children('option:selected').text());
			$("#pop_DomainSelectpw").val("customAddr");
			$("#pop_DomainSelectpw").val("customAddr").attr("selected", "selected");
			$("#pop_DomainSelectpw").siblings(".selectBoxDrop").text($("#pop_DomainSelectpw").children('option:selected').text());
		}		
		function changeRecv() {
			var chk = $("input:radio[name='chk_accept']:checked").val()
			if(chk =='SMS') {
				$("#pop_userMailArea").hide();
				$("#pop_userPhoneArea").show();
			} else {				
				$("#pop_userPhoneArea").hide();
				$("#pop_userMailArea").show();
			}
			var chk2 = $("input:radio[name='chk_accept2']:checked").val()
			if(chk2 == 'SMS') {				
				$("#pop_userMailpwArea").hide();
				$("#pop_userPhonepwArea").show();
			} else {				
				$("#pop_userPhonepwArea").hide();
				$("#pop_userMailpwArea").show();
			}
		}		
		
		// 사용자 아이디 찾기
		function idsearch(){
			//alert("사용자 아이디 검색");
			if($("#pop_userName").val()==""){
				alertBox3(" 사용자 이름을 입력하세요");
				$("#pop_userName").focus();
				return false;
			}
			var chk = $("input:radio[name='chk_accept']:checked").val()
			if(chk == "SMS") {
				if($("#pop_userPhone_id_1 > option:selected").val() == ""){
					alertBox3(" 사용자 핸드폰을 입력하세요");
					$("#pop_userPhone_id_1").focus();
					return false;
				}				
				if($("#pop_userPhone_id_2").val() == "") {
					alertBox3(" 사용자 핸드폰을 입력하세요");
					$("#pop_userPhone_id_2").focus();
					return false;
				}
				if($("#pop_userPhone_id_3").val() == "") {
					alertBox3(" 사용자 핸드폰을 입력하세요");
					$("#pop_userPhone_id_3").focus();
					return false;
				}				
			} else {
				if($("#pop_userMail").val()==""){
					alertBox3(" 사용자 이메일주소을 입력하세요");
					$("#pop_userMail").focus();
					return false;
				}
				var domain = $("#pop_DomainSelect > option:selected").val();
				var custom = $("#pop_DomainCustom").val();
				if( (domain=="customAddr") && (custom=="") ) {
					alertBox3("사용자 이메일주소을 입력하세요");
					$("#pop_DomainCustom").focus();
					return false;
				}
			}
			
			var jsonData = setJsonData(chk);
			$.ajax({
				url : "${wasPath}/mbr/mbrinfo/useridSearch",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					if(data==0){
						alertBox3("입력된 정보와 일치 하는 <br>아이디가 없습니다.");
					}else{
						alertBox3("아이디 찾기 성공, <br>선택한 수신방법으로 발송");
					}
					resetPopup();
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		
		function setJsonData(chk){
			var phone1=$("#pop_userPhone_id_1 > option:selected").val();
			var phone2=$("#pop_userPhone_id_2").val();
			var phone3=$("#pop_userPhone_id_3").val();			
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
				alertBox3("사용자 아이디을 입력하세요");
				$("#pop_userId").focus();
				return false;
			}
			var chk = $("input:radio[name='chk_accept2']:checked").val()
			if(chk == "SMS") {
				if($("#pop_userPhone_pw_1").val()==""){
					alertBox3("사용자 핸드폰을 입력하세요");
					$("#pop_userPhone_pw_1").focus();
					return false;
				}
				if($("#pop_userPhone_pw_2").val()==""){
					alertBox3("사용자 핸드폰을 입력하세요");
					$("#pop_userPhone_pw_2").focus();
					return false;
				}
				if($("#pop_userPhone_pw_3").val()==""){
					alertBox3("사용자 핸드폰을 입력하세요");
					$("#pop_userPhone_pw_3").focus();
					return false;
				}
			} else {
				if($("#pop_userMailpw").val()==""){
					alertBox3("사용자 이메일주소을 입력하세요");
					$("#pop_userMailpw").focus();
					return false;
				}
				var domain = $("#pop_DomainSelectpw > option:selected").val();
				var custom = $("#pop_DomainCustompw").val();
				if( (domain=="customAddr") && (custom=="") ) {
					alertBox3("사용자 이메일주소을 입력하세요");
					$("#pop_DomainCustompw").focus();
					return false;
				}
			}
			var jsonData = setJsonDatapw(chk);
			$.ajax({
				url : "${wasPath}/mbr/mbrinfo/userpwSearch",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					if(data==0){
						alertBox3("입력된 정보와 일치 하는 <br>정보가 없습니다.");
					}else{
						alertBox3("비밀번호 찾기 성공<br/>선택한 수신방법으로 발송<br/>비밀번호 초기화");
					}
					resetPopup();
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		
		function setJsonDatapw(chk){
			var userPhone=$("#pop_userPhone_pw_1 > option:selected").val()+"-";
			userPhone+=$("#pop_userPhone_pw_2").val() +"-"+ $("#pop_userPhone_pw_3").val();
		
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
</html>