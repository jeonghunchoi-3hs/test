<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">

		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
		
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
		
		        <p class="page_title">내정보
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> <b><a href="${wasPath}/mbr/cmm/user/userInfo">내정보</a> </b>
			    </span>
				</p>

			<!-- begin page-body -->
			<div class="row p20 bgwh br10">
			     <div class="userone">
				 <div class="col-md-12">
				     <div class="col-md-2"><p class="user_icon"><i class="fa fa-user-o f80"></i></p></div>
				     <div class="col-md-10">
					     <table class="myinfo">
					     <colgroup>
					     <col width="80px">
					     <col width="*">
					     </colgroup>
					       <tbody>
					       <tr><th>사번</th><td><span id="userId"></span></td></tr>
					       <tr><th>회원사</th><td><span id="customerName"></span></td></tr>
					       <tr><th>소속조직</th><td><span id="deptName"></span></td></tr>
					       <tr><th>직급</th><td><span id="userLevel"></span></td></tr>
					       </tbody>
					     </table>
				     </div>
				 </div>
				 </div>
				 <div class="userone mt10">
				    <div class="col-md-12 tac">
				       <div class="w17 dpin br1-dd">
				       		<div class="info_left"><p class="navy_c"><img src="${apachePath}/resources/assets/img/icon_call.svg" height="18px" /></p></div>
				       		<div class="info_right"><li class="fb fc33">전화번호(사선)</li><li id="userTelEx"></li></div>
				       </div>
				       <div class="w17 dpin br1-dd">
				            <div class="info_left"><p class="navy_c"><img src="${apachePath}/resources/assets/img/icon_call.svg" height="18px" /></p></div>
				       		<div class="info_right"><li class="fb fc33">전화번호(국선)</li><li id="userTel"></li></div>
				       </div>
				       <div class="w30 dpin br1-dd">
				       		<div class="info_left"><p class="navy_c"><img src="${apachePath}/resources/assets/img/icon_email.svg" height="18px" /></p></div>
				       		<div class="info_right"><li class="fb fc33">이메일</li><li id="userMail"></li></div>
				       </div>
				       <div class="w17 dpin br1-dd">
				       		<div class="info_left"><p class="navy_c"><img src="${apachePath}/resources/assets/img/icon_exclamation.svg" height="18px" /></p></div>
				       		<div class="info_right"><li class="fb fc33">SMS 수신여부</li><li id="smsN">SMS 수신하지 않습니다. </li><li id="smsY">SMS 수신합니다. </li></div>
				       </div>
				       <div class="w17 dpin">
				       		<div class="info_left"><p class="navy_c"><img src="${apachePath}/resources/assets/img/icon_exclamation.svg" height="18px" /></p></div>
				       		<div class="info_right"><li class="fb fc33">메일 수신여부</li><li id="mailY">메일 수신합니다.</li> <li id="mailN">메일 수신하지 않습니다.</li></div>
				       </div>
				    </div>
				 </div>
				  <div class="tac mt80 mb100"> 
				        <a href="#" onclick="moveInsertPage();" class="btn_line55"> 수정 </a>
						<a href="#modal-dialog_out" data-toggle="modal" type='button' class="btn_lgrey ml10"> 탈퇴 </a>
				   </div>
	
				<!-- 내 정보 수정 -->
				<%-- <div class="userInfoArea">				    					
					<div class="myinfo">
						<div class="myPic">
					<!--<c:if test="${file.size() eq 0}">
							<img src="${apachePath}/resources/assets/img/userInfo_mypic_noImage.png" >
						</c:if>
						<c:if test="${file.size() ne 0}">
							<img src="${wasPath}/mbr/cmm/file/download/${file.get(0).fileId}"  style="width: 146px; height: 146px;"/>
						</c:if>  -->	
						<img src="${apachePath}/resources/assets/img/userInfo_mypic_noImage.png" >
						</div>
					<!-- 	<dl>
							<dt id="userName" class="mt20"></dt>
							<dd class="dpin"><span>사번 : </span><strong ></strong></dd>
							<dd class="dpin ml50"><span>회원사 : </span><strong id="customerName"></strong></dd>
							<dd class="dpin ml50"><span>소속조직(부서) :  </span><strong id="deptName">ICT 인프라팀</strong></dd>
							<dd class="dpin ml50"><span>직급 :  </span><strong id="userLevel">책임</strong></dd>
						</dl> -->
					</div>
					<div class="myContact">
						<ul>
							<li class="mobile"><div class="ml80"></div><p class="ml160 f16 fc11 mt-50">핸드폰</p><strong class="nanumR" id="userPhone"></strong></li>
							<li class="tel"><div class="ml80"></div><p class="ml160 f16 fc11 mt-50">전화번호(사선)</p><strong class="nanumR" id="userTelEx"></strong></li>
							<li class="telK"><div class="ml80"></div><p class="ml160 f16 fc11 mt-50">전화국선(국선)</p><strong class="nanumR" id="userTel"></strong></li>
							<li class="email"><div class="ml80"></div><p class="ml160 f16 fc11 mt-50">이메일</p><strong class="nanumR" id="userMail"></strong></li>
						</ul>
					</div>
					<div class="notific">
						<div class="box">
							<strong>SMS 수신여부</strong>
							 
							<div class="noticeBox off f16" id="smsN">
								<i class="fa fa-exclamation-circle f20 fc00 vm"></i>SMS 수신하지 않습니다.
							</div>
							
							<div class="noticeBox on f16" id="smsY">
								<i class="fa fa-exclamation-circle f20 fc_red vm"></i>SMS 수신합니다.
							</div>
						</div>
						<div class="box">
							<strong>메일 수신여부</strong>
							<div class="noticeBox on f16" id="mailY">
								<i class="fa fa-exclamation-circle f20 fc_red vm"></i>메일  수신합니다.
							</div>
							
							<div class="noticeBox off f16" id="mailN">
								<i class="fa fa-exclamation-circle f20 fc00 vm"></i>메일 수신하지 않습니다.
							</div>

						</div>
					</div>
					
					<div class="tac mt50">
						<a href="#" onclick="moveInsertPage();" class="bbton bton_blue"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-pencil"></i></span><span class="dpin ml16">수정</span></a>
						<a href="#modal-dialog_out" data-toggle="modal" type='button' class="bbton bton_dgrey"><span class="dpin dd bton_ddgrey ml-1"><i class="fa fa-ban"></i></span> <span class="dpin ml16"> 탈퇴</span> </a>
						<!-- <a href="#" onclick="infoChk();" class="bbton bton_dgrey"><span class="dpin dd bton_ddgrey ml-1"><i class="fa fa-ban"></i></span> <span class="dpin ml16">탈퇴</span></a>  -->
					</div>
				</div> --%>
			
		</div>
		<!-- end page-body -->
			
		<!-- begin #footer -->
		<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #footer -->

	</div>
	<!-- end #content -->	
</div>
<!-- end page container -->

		<!-- #modal-dialog   -->
		<div class="modal fade"  id="modal-dialog_out">
              <div class="modal-dialog">
                  <div class="modal-content-s">
                      <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                          <h4 class="modal-title">탈퇴 확인 알림</h4>
                      </div>
                      <div class="modal-body">
                      		<h2 class="mb20 f16 fn tal mt0">한국전력 K-Cloud 회원을 <span class="f16 fb fc-dblue">탈퇴</span>하시겠습니까? </h2>
                      		<p class="f16 mt10 tal">탈퇴를 원하시면 아래에 <span class="fc-dblue fb">비밀번호를 입력 </span>하고 탈퇴버튼을 눌러주세요.</p>
                      		<input class="input_int mt40 mb20 width-300 br5" type="password" id="password" placeholder="비밀번호를 입력하세요"/>

                     	</div>
                      	<div class="modal-footer tac">
                  			<a type='button' class="m_btn_navy" id="withdrawal"> 탈퇴  </a>
                      		<a type='button' class="m_btn_white ml10" data-dismiss="modal">취소 </a>
                      	</div>
                  	</div>
              	</div>
          	</div>
		<!-- #modal-dialog -->

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

	$(document).ready(function(){
		 App.init();
		 userInfoDetail();

		 $("#withdrawal").click(function() {			 
			 userPasswordCheck();			 
		 });
	});

	// 사용자 상세 조회
	function userInfoDetail(){		
		$.ajax({
			url : "${contextPath}/mbr/cmm/user/userInfoDetail",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : "${userId}" 
			},
			success : function(data) {
				setData(data);				
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			}
		});		
	}
	
	function setData(data){
		delete data.length; 
		$.each(data, function(key, val){
			if(val != null){
				if(key=="smsRecvFlag"){
					if(val == "Y"){
						$("#smsY").show();
						$("#smsN").hide();
					}else{
						$("#smsY").hide();
						$("#smsN").show();
					}
				}else if(key=="mailRecvFlag"){
					if(val == "Y"){
						$("#mailY").show();
						$("#mailN").hide();
					}else{
						$("#mailY").hide();
						$("#mailN").show();
					}
				}else{
					$("#"+key).text(val);
				}
			}
		});
	}
	
	function userPasswordCheck() {
		 
		$.ajax({
			url : "${contextPath}/mbr/cmm/user/userPasswordCheck",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : "${userId}"
				, "userPassword": $("#password").val()
			},
			success : function(data) {
				
				if(data==1) {
					userInfoDelete();
				} else  {
					alertBox("패스워드를 확인해주십시오.", pwdFocus);					
				}
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			}
		});
	}
	
	// 사용자 탈퇴
	function userInfoDelete(){		
		$.ajax({
			url : "delete",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : "${userId}"
			},
			success : function(data) {				
				alertBox("탈퇴가 완료되었습니다.", logout);
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			}
		});
	}
	function pwdFocus() {
		$("#password").val("");
		$("#password").focus();
	}
	
	function logOut(){
		location.href="j_spring_security_logout";
	}
	
	function moveInsertPage(){		
		location.href = "${contextPath}/mbr/cmm/user/userInfoWrite?userId=${userId}";
	}	

</script>
</body>
</html>
