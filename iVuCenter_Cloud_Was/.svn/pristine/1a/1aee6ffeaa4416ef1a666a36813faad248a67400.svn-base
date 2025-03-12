<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="adminId" 		property="principal.username" />
	<sec:authentication var="adminName" 	property="principal.nickname"/>
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
	<c:import url="/WEB-INF/views/mng/include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
		
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
		
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>내정보</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#" class="on">내정보</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<div class="userinfolineBg">
					<input type="hidden" id="_userId" value="${userId}">
					
					<div class="userinfoBg">
						<div class="usercompinfo">
                       		<c:if test="${file.size() eq 0}">
								<img class="userPic fl" alt="" src="${contextPath}/resources/mng/assets/img/defultPic.png"> 
								<input type="hidden" id="h_fileId" value="">
							</c:if>								
							<c:if test="${file.size() ne 0}">
								<img class="userPic fl" name="popPic" src="${wasPath}/mng/cmm/file/download/${file.get(0).fileId}" alt="사진"/>
								<input type="hidden" id="h_fileId" value="${file.get(0).fileId}">
							</c:if>								
							 
							<div class="m-l-30 m-t-20 fl">
								<p class="f20 fc11" id="userName"></p> 
								<div class="m-t-25">
								<!-- 	<span class="company_labelf">사번 :</span><span class="company_cont fontVdn" id="userId"></span> -->
									<span class="company_labelf"> 회원사 :</span><span class="company_cont" id="customerName"></span>
									<span class="company_label"> 소속조직(부서) :</span><span class="company_cont" id="deptName"></span>
									<span class="company_label"> 직급 :</span><span class="company_cont" id="userLevel"></span>
									
								</div> 
							</div>
						</div>
						
						
						<ul class="userindiinfo">
						   <li class="userPhone width-80">
						   </li>
						   <li>
						     <ul class="dpin mt10">
						  	 <li class="w100 f16 fc11">핸드폰</li>
						  	 <li class="w100 f16 pt10" id="userPhone"></li>
						  	 </ul>
						   </li>
						   <li class="userTel width-80 ml30">
						   </li>
						   <li>
						     <ul class="dpin mt10">
						  	 <li class="w100 f16 fc11">전화번호(사선)</li>
						  	 <li class="w100 f16 pt10" id="userTelEx"></li>
						  	 </ul>
						   </li>
						    <li class="userTelK width-80 ml30">
						   </li>
						   <li>
						     <ul class="dpin mt10">
						  	 <li class="w100 f16 fc11">전화번호(국선)</li>
						  	 <li class="w100 f16 pt10" id="userTel"></li>
						  	 </ul>
						   </li>
						    <li class="userEmail width-80  ml30">
						   </li>
						   <li>
						     <ul class="dpin mt10">
						  	 <li class="w100 f16 fc11">이메일</li>
						  	 <li class="w100 f16 pt10" id="userMail"></li>
						  	 </ul>
						   </li>
							
						</ul>
					</div>  
					<div class="userReceiveInfo">
						<div class="receiveSMS">
							<span class="f16 fc11"><i class="fa fa-commenting-o fc-blue2"></i> SMS 수신여부</span>
							<span class="receive" id="smsRecvFlag"></span>
						</div>	
						<div class="receivemail">
							<span class="f16 fc11"> <i class="fa fa-envelope fc-blue2"></i> 메일 수신여부</span>
							<span class="receive" id="mailRecvFlag"></span>
						</div>	
					</div>
				</div>
				
				
		    
		    <!-- begin button-->
			<div class="row tac m-t-40">	
				<a type="button" class="rbton bton_blue" onclick="moveInsertPage();"><i class="fa fa-pencil"></i> 수정</a>	
			</div>
			<!-- end button -->
			
		</div>
		<!-- end page-body -->
		
		
			
		<!-- begin #footer -->
		<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #footer -->

	</div>
	<!-- end #content -->
	
</div>
<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

	$(document).ready(function(){		
		 App.init();
		 userInfoDetail();
		 
		 if('${pwd}'){ 
			 alertBox3("비밀번호를 변경한지<br>90일이 초과되었습니다.<br>비밀번호를 변경해주십시오.");
		 }
	});
	
	function userInfoDetail(){
		if($("#_userId").val() == ""){
			location.href = "${contextPath}/mng/cmm/user/userInfo"; 
			return false;
		}
		$.ajax({
			url : "${contextPath}/mng/cmm/user/userInfoDetail",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : $("#_userId").val()
			},
			success : function(data) {
				setData(data);
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function userInfoDelete(){
		
		$.ajax({
			url : "${contextPath}/mng/cmm/user/delete",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : $("#_userId").val()
			},
			success : function(data) {
				setData(data);
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	
	function setData(data){
		delete data.length; 
		$.each(data, function(key, val){
			if(val != null){
				if(key=="smsRecvFlag"){
					if(val == "Y"){
						$("#"+key).addClass("active");
						$("#"+key).text("SMS 수신합니다.");
					}else{
						$("#"+key).removeClass("active");
						$("#"+key).text("SMS 수신하지 않습니다.");
					}
				}else if(key=="mailRecvFlag"){
					if(val == "Y"){
						$("#"+key).addClass("active");
						$("#"+key).text("메일 수신합니다.");
					}else{
						$("#"+key).removeClass("active");
						$("#"+key).text("메일 수신하지 않습니다.");
					}
				}else{
					$("#"+key).text(val);
				}
			}
		});
	}
	
	function moveInsertPage(){	
		var userId = $("#_userId").val();		
		location.href = "${contextPath}/mng/cmm/user/userInfoWrite?userId="+userId;
	}

	//modal팝업 open
// 	function openModal(){
// 		$("#modal-dialog").modal();
// 	}	

</script>
</body>
</html>
