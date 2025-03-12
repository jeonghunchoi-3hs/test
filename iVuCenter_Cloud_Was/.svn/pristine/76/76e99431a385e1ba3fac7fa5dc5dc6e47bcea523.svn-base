<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<div class="login_Logo">
        <img src="${apachePath}/resources/assets/img/login_logo.png"  class="tac" alt="로고" />
    </div> 
	<!-- begin #page-container -->
	<div class=""> 

	<div id="page-container" class="fade page-container"> 
		<!-- begin login-brand -->
        
	    <!-- begin login -->
		<div class="loginBgArea clearfix">
		    <h4 class="login-title">WELCOME</h4>
		    <!-- end login-brand -->
		    <!-- begin login-content -->
            <div class="login_InfoArea">
            	
                <h4 class="login-info"> 클라우드 사용자콘솔 입니다. </h4>
                	<div class="idpwArea">
                		<form action="${wasPath}/mbr/j_spring_security_check" method="post" id="login_form" name="login_form" class="form-input-flat">
                    	<input type="text" class="form-control loginInput" placeholder="사번을 입력해주세요"  name="j_username" id="username" onkeypress="onFocusPassword();" required style="ime-mode:inactive;" autocomplete=off>
                   	 	<input type="password" class="form-control loginInput" placeholder="비밀번호를 입력해주세요"   name="j_password" id="password" onkeypress="enterPassword();" required>
	                    <a class="loginbtn" type='button' onclick="actSubmit();"> <img src="${apachePath}/resources/assets/img/loin_button.png" alt="로그인" id="login_btn"/> </a>
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
		 <div class="BTArea">
		 	<img src="${apachePath}/resources/assets/img/member_join.png" alt="" />
		 	<div class="btn-Area">
			 	<span class="btComment">아직도 회원이 아니십니까?</span>
			 	<p>
				 	<a class="btnBT" href="${wasPath}/mbr/cmm/user/agreementList">
						회원가입
					</a>
				</p>
			</div>
		</div>
                   
                   
		<div class="BTArea">
			<img src="${apachePath}/resources/assets/img/id_pw_find.png" alt="" />
			<div class="btn-Area">
			 	<span class="btComment">사번과 비밀번호를 잊으셨나요?</span>
			 	<p>
				 	<%-- <a class="btnBT" href="${wasPath}/mbr/mbrinfo/mbrinfosearch.do"> --%>
				 	<a class="btnBT" type='button' onclick="openId();">
						사번
					</a>
					<a class="btnBT" type='button' onclick="openPw();">
						비밀번호
					</a>
				</p>
			</div>
			
		</div>
		
	</div>
	<div class="footerArea">
		 <!-- begin #footer --> 
		<c:import url="include/footer.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #footer --> 
	</div> 
	 
	 
	 <!-- #modal-dialog -->
		<div class="modal fade" id="modal-dialog">
              <div class="modal-dialog">
                  <div class="modal-content">
                      <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                          <h4 class="modal-title" id="searchTitle">사번/비밀번호 찾기</h4>
                      </div>
                      <div class="modal-body">
                      	<input type="hidden" id="h_searchGubun" value="">
                      	<ul class="tap nav-pills nav-pills-primary z-in" id="tabNav">
                            <li class="active" id="searchId" onclick="searchGubun('searchId');"><a href="#sabun-search" data-toggle="tab">사번찾기</a></li>                           
                            <li id="searchPw" id="searchPw" onclick="searchGubun('searchPw');"><a href="#pw-search" data-toggle="tab">비밀번호</a></li>
                        </ul>
                        <div class="bottomArea2  active" id="sabun-search"> 
                   			<p class="f18 fc11">사용자이름<input type="text" id="pop_userName" class="searchEdit" placeholder="이름을 입력하세요" data-original-title="" title=""></p>
                   			<p class="f18 fc11">이메일주소<input type="text" id="pop_userMail" class="searchEdit" placeholder="이메일 주소를 입력하세요" data-original-title="" title=""></p>
                   			<p class="f18 fc11 mt15">수신방법
                   				<span> 
	                   				<input class="ml30" type="radio" name="chk_accept" value="SMS" checked="checked">SMS
	                   				<input class="ml30" type="radio" name="chk_accept" value="NHWith">NHwith
	                   				<input class="ml30" type="radio" name="chk_accept" value="Mail">메일
                   				</span>
                   			</p>
                   			<div class="renameWarn"> 
								<img class="fl mr20 mt5" src="${apachePath}/resources/assets/img/renameWarn.png">
								<p class="f14 fc66"><span class="fc1d4766">등록한 이름</span>과 <span class="fc1d4766">이메일</span>로 사번를 찾으실 수 있습니다</p>
								<p class="f14 fc66"><span class="fcde4e4e">등록된 이메일 주소와 입력한 이메일 주소</span>가 동일해야</p> 
								<p class="f14 fc66 pl52">사번을 찾을 수 있습니다</p>
	                     	</div> 
                   		</div>
                   		<div class="bottomArea2" id="pw-search"> 
                   			<p class="f18 fc11">사번입력<input type="text" id="pop_userId" class="searchEdit ml27" placeholder="사번을 입력하세요" data-original-title="" title=""></p>
                   			<p class="f18 fc11">이메일주소<input type="text" id="pop_pwUserMail" class="searchEdit" placeholder="이메일 주소를 입력하세요" data-original-title="" title=""></p>
                   			<p class="f18 fc11 mt15">수신방법
                   				<span> 
	                   				<input class="ml30" type="radio" name="chk_accept2" value="SMS" checked="checked">SMS
	                   				<input class="ml30" type="radio" name="chk_accept2" value="NHWith">NHwith
	                   				<input class="ml30" type="radio" name="chk_accept2" value="Mail">메일
                   				</span>
                   			</p>
                   			<div class="renameWarn"> 
								<img class="fl mr20 mt5" src="${apachePath}/resources/assets/img/renameWarn.png">
								<p class="f14 fc66"><span class="fc1d4766">사번</span>과 <span class="fc1d4766">이메일</span>로 비밀번호 초기화를 하실수 있습니다.</p> 
								<p class="f14 fc66 pl52">가입시 <span class="fcde4e4e">등록된 SMS, Nhwith, 메일 중 하나로 초기화된 비밀번호가 발송</span>됩니다.</p>
	                     	</div> 
                   		</div> 
                     	</div> 
                      	<div class="modal-footer tac"> 
                   			<a type='button' class="lbtn" data-dismiss="modal" onclick="searchBtn();">찾기</a>	 
	                   		<a type='button' class="rbtn" data-dismiss="modal" onclick="initPopup()">닫기</a>
<!-- 	                   		<a type='button' onclick="test()">닫기</a> -->
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
			$("#username").focus();
			
			alertBox3("동일한 ID로 접속정보가 확인되어 <br>로그아웃되었습니다.<br>계속 이용하시려면 재로그인을 해주십시오.");
			//window.history.forward();
		});
		
		//숫자만 입력
		function number_only(id){
			//alert(id);
			$(id).val( $(id).val().replace(/[^0-9]/gi,''));
			if( !( event.keyCode>=48 && event.keyCode<=57 ) ){
				event.returnValue=false;
		    }
		}
		
		
		function openId(){
			$("#modal-dialog").modal();
			$("#searchPw").removeClass("active");
			$("#searchId").removeClass("active");
			$("#searchId").addClass("active");
			$("#pw-search").removeClass("active");
			$("#sabun-search").removeClass("active");
			$("#sabun-search").addClass("active");
			$("#h_searchGubun").val("searchId");
			$("#searchTitle").text("");
			$("#searchTitle").text("사번 찾기");
		}
		function openPw(){
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
		}
		
		function onFocusPassword(){
			if(event.keyCode==13){
				$("#password").focus();
			}
		}
		function enterPassword(){
			if(event.keyCode==13){
				actSubmit()
			}			
		}
		function actSubmit(){
			$('#login_form').submit();
		}
		
		// 찾기 구분
		function searchGubun(gubun){
			$("#h_searchGubun").val(gubun);
			if(gubun=="searchId"){
				$("#searchTitle").text("");
				$("#searchTitle").text("사번 찾기");
			}else{
				$("#searchTitle").text("");
				$("#searchTitle").text("비밀번호 찾기");
			}
			initPopup();
		}
		
		// 찾기 구분
		function searchBtn(){
			if($("#h_searchGubun").val() == "searchId"){
				idsearch();
			}else if($("#h_searchGubun").val() == "searchPw"){
				pwsearch();
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
			if($("#pop_userMail").val()==""){
				alertBox3(" 사용자 이메일주소을 입력하세요");
				$("#pop_userMail").focus();
				return false;
			}
			var jsonData = setJsonData();
			$.ajax({
				url : "${wasPath}/mbr/mbrinfo/useridSearch",
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
		
		function setJsonData(){	
			var jsonData = {
					"userName" : $("#pop_userName").val()        
					, "userMail": $("#pop_userMail").val() 
					, "recvFlag" : $("input:radio[name='chk_accept']:checked").val()
					};
			return jsonData;
		}
		
		// 사용자 비밀번호 찾기
		function pwsearch(){
			//alert("사용자 패스워드 검색");
			if($("#pop_userId").val()==""){
				alertBox3("사용자 아이디을 입력하세요");
				$("#pop_userId").focus();
				return false;
			}
			if($("#pop_pwUserMail").val()==""){
				alertBox3("사용자 이메일주소을 입력하세요");
				$("#pop_pwUserMail").focus();
				return false;
			}
			var jsonData = setJsonDatapw();
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
					initPopup();
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		
		function setJsonDatapw(){	
			var jsonData = {
					"userName" : $("#pop_userName").val()        
					, "userMail": $("#pop_pwUserMail").val() 
					, "userId": $("#pop_userId").val()
					, "recvFlag" : $("input:radio[name='chk_accept2']:checked").val()
					};
			return jsonData;
		}
		
		function initPopup(){
			$("#pop_userId").val("");
			$("#pop_userName").val("");
			$("#pop_pwUserMail").val("");
			$("#pop_userMail").val("");
			$("input[name='chk_accept']:radio[value='SMS']").prop("checked", true);
			$("input[name='chk_accept2']:radio[value='SMS']").prop("checked", true);
		}
		
		
		
		
		
	</script> 
</html>