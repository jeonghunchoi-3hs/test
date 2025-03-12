<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
				<h1>회원가입 승인 진행</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">승인/작업처리</a><a href="#" class="on">회원가입 승인 진행</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
			<input type="hidden" id="h_reqUserSeq" value="${vo.reqUserSeq}">			
				
	
				
				<div class="row mb30 mt20">
					<div class="col-xs-6 request">
					 <h3 class="request_title">요청부서</h3>
					 	<div class="col-xs-12 clear mt50">
					 	 <div class="col-xs-3 tac pl0 pr0">
						 <ul class="step03">
						    <li class="fc11 f18 fb">담당</li>
						    <li id="req_deptName">전력경영 관리회계 </li>
						    <li class="mt-5" id="req_userName">홍길동 (4)</li>
						    <li class="mt5 mb5"><i class="fa fa-pencil-square-o f30 fc66"></i> </li>
						   <!--<li class="mt5 mb5"><span class="bg_green p414 br5 fb"><i class="fa fa-pencil-square-o"></i> 신청완료</span></li>
						    <li class="fc99"><span id="req_regDate">2019-09-10</span><br/><span id="req_regTime">18:28:30</span></li>  --> 
						 </ul>
						   <p class="ribbon_03 fw">신청완료 </p>
						   <p class="fc99 f12 tac mt5"><span id="req_regDate"></span><span id="req_regTime"></span></p>
						 </div>
						</div>
					</div>
				
					<div class="col-xs-6 approval flr">
					 <h3 class="approval_title">승인부서</h3>
					 	<div class="col-xs-12 clear mt50">
					 	 <div class="col-xs-3 tac pl0 pr0">
						 <ul class="step06" id="adminApprv">
						    <li class="fc11 f18 fb">담당</li>
						    <li id="adminDeptName">전력경영 관리회계 </li>
						    <li class="mt-5" id="adminUserName">홍길동 (4)</li>
						    <!-- <li class="mt5 mb5"><span class="bg_grey p414 br5 fb"><i class="fa fa-hourglass-half"></i> 대기</span></li> -->
						    <li class="mt5 mb5" id="adminApprv1"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i></li>   <!-- 진행 중 -->
						    <li class="mt5 mb5" id="adminApprv2"><i class="fa fa-bell-o f30 fc66"></i></li>  <!-- 승인완료   -->
						    <li class="mt5 mb5" id="adminApprv3"><i class="fa fa-reply f30 fc-orange"></i> </li> <!--  반려  -->
						   <!--  <li class="fc99">2019-09-10 <br/>18:28:30</li> -->
						 </ul>
						  <p class="ribbon_06 fw" id="adminApprvTxt"> 상태값  </p>
						 </div>
						<!--  <div class="col-xs-4 tac">
						 <ul class="circle02">
						    <li class="fc11 f18 fb">검토</li>
						    <li>전력경영 관리회계 </li>
						    <li class="mt-5">홍길동 (4)</li>
						    <!-- <li class="mt5 mb5"><span class="bg_grey p414 br5 fb"><i class="fa fa-hourglass-half"></i> 대기</span></li> -->
						    <!-- <li class="mt5 mb5"><span class="bg_grey p414 br5 fb"><i class="fa fa-ellipsis-h"></i> 진행중</span></li>-->
						    <!-- <li class="mt5 mb5"><span class="bg_blue p414 br5 fb"><i class="fa fa-gavel"></i> 승인완료</span></li> --> 
						    <!-- <li class="mt5 mb5"><span class="bg_orange p414 br5 fb"><i class="fa fa-reply"></i> 반려</span></li>-->
						    <!-- <li class="fc99">2019-09-10 <br/>18:28:30</li>
						 </ul>
						 </div> -->
						<!-- <div class="col-xs-4">
						 <ul class="circle03">
						    <li class="fc11 f18 fb">승인</li>
						    <li>전력경영 관리회계 </li>
						    <li class="mt-5">홍길동 (4)</li>
						   <!--   <li class="mt5 mb5"><span class="bg_grey p414 br5 fb"><i class="fa fa-hourglass-half"></i> 대기</span></li>-->
						   <!--  <li class="mt5 mb5"><span class="bg_grey p414 br5 fb"><i class="fa fa-ellipsis-h"></i> 진행중</span></li> --> 
						   <!--  <li class="mt5 mb5"><span class="bg_blue p414 br5 fb"><i class="fa fa-gavel"></i> 승인완료</span></li> --> 
						 <!--  <li class="mt5 mb5"><span class="bg_orange p414 br5 fb"><i class="fa fa-reply"></i> 반려</span></li>
						  <li class="fc99">2019-09-10 <br/>18:28:30</li>
						 </ul>
						 </div>-->
						</div>
					</div>
				</div>
				
				
				<div class="clear"></div>
			
				<div class="userinfolineBg">
					
					<div class="userinfoBg">
						<div class="usercompinfo">
            				<img class="userPic fl" alt="" src="/resources/mng/assets/img/defultPic.png"> 
							<div class="m-l-30 m-t-20 fl">
								<p class="f20 fc11 dpin" id="userName"> 홍길동  (3) </p> 
								
								<div class="selectBox width-200 flr dpin mt-10" id="apprvOperationDiv">
									<label class="selectText fontVdn" for="apprvOperation" > 권한선택  </label>
									<select id="apprvOperation" class="search-sel">
										<option value=""> 권한없음 </option>								
										<option value="WF1000A0"> 요청부서(검토) </option>
			                  			<option value="WF1000B0"> 요청부서(승인 ) </option>
									</select>
								</div>
								
								<div class="m-t-25">
								    <span class="fc11 f16">ID :</span><span class="company_cont fontVdn" id="userId">1234</span>
									<span class="company_label fc-blue2">  회원사 :</span><span class="company_cont" id="customerName">한국전력공사 </span>
									<span class="company_label fc-blue2">  소속조직(부서) :</span><span class="company_cont" id="deptName">IT기획처 인프라 계획</span>
									<span class="company_label fc-blue2">  직급 :</span><span class="company_cont" id="userLevel">IT기획처 인프라 계획</span>
								</div> 
							</div>
						</div>
						
						
						<ul class="userindiinfo">
						   <li class="userPhone width-80">
						   </li>
						   <li>
						     <ul class="dpin w90 mt10">
						  	 <li class="w100 f16 fc11">핸드폰</li>
						  	 <li class="w100 f16 pt10" id="userPhone">010-1111-1111</li>
						  	 </ul>
						   </li>
						   <li class="userTel width-80 ml30">
						   </li>
						   <li>
						     <ul class="dpin w70 mt10">
						  	 <li class="w100 f16 fc11">전화번호(사선)</li>
						  	 <li class="w100 f16 pt10" id="userTelEx">061-1234</li>
						  	 </ul>
						   </li>
						    <li class="userTelK width-80 ml30">
						   </li>
						   <li>
						     <ul class="dpin w70 mt10">
						  	 <li class="w100 f16 fc11">전화번호(국선)</li>
						  	 <li class="w100 f16 pt10" id="userTel">061-1234-2678</li>
						  	 </ul>
						   </li>
						    <li class="userEmail width-80  ml30">
						   </li>
						   <li>
						     <ul class="dpin w70 mt10">
						  	 <li class="w100 f16 fc11">이메일</li>
						  	 <li class="w100 f16 pt10" id="userMail">abcd@kepco.co.kr</li>
						  	 </ul>
						   </li>
							
						</ul>
					</div>  
					<div class="userReceiveInfo">
						<div class="receiveSMS">
							<span class="f16 fc11"><i class="fa fa-commenting-o fc-blue2"></i> SMS 수신여부</span>
							<span class="receive" id="smsRecvFlag">SMS 수신합니다.</span>
						</div>	
						<div class="receivemail">
							<span class="f16 fc11"> <i class="fa fa-envelope fc-blue2"></i> 메일 수신여부</span>
							<span class="receive" id="mailRecvFlag">메일을 수신하지 않습니다. </span>
						</div>	
					</div>
				</div>
								
								
				<c:if test="${userapprove.confirmAction eq 'Y'}">
					<div class="row tac m-t-60">
						<a type="button" class="rbton bton_blue" id="btnConfirm" onClick="userInfoConfirm('Y')"><i class="fa fa-gavel"></i> 승인 </a>
						<a href="#modal-dialog3"  data-toggle="modal" id="btnReject" type="button" class="rbton bton_orange"><i class="fa fa-reply"></i> 반려 </a>
			 			<a type="button" class="rbton bton_dgrey" onClick ="moveListPage()"><i class="fa fa-list"></i> 목록</a>
	                </div>
                </c:if>
                <c:if test="${userapprove.confirmAction eq 'N'}">
					<div class="row tac m-t-60">
			 			<a type="button" class="rbton bton_dgrey" onClick ="moveListPage()"><i class="fa fa-list"></i> 목록</a>
	                </div>
                </c:if>
                
            	
			
		</div>
		<!-- end page-body -->
		

		<!-- #modal-dialog 반려  20191022 추가  -->
				<div class="modal fade"  id="modal-dialog3">
	               <div class="modal-dialog">
	               	<input type='hidden' id='modal-alert-reload' value='N'>
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">반려사유</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="rejectInfo m-b-20">
									<i class="fa fa-commenting-o f20 fc99"></i> 반려 사유를 상세하게 입력하여 주십시오.
								</div>
	                       		<div><textarea  rows="3"  placeholder="반려사유를 입력하세요." name="apprvDescription"></textarea></div>
	                      	</div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="pbton bton_blue" onClick="userInfoReject('J')">확인  </a>
	                       		<a type='button' class="pbton bton_dgrey" data-dismiss="modal">취소 </a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
				
				
				
				<!-- #modal-dialog 반려확인   20191022 추가  -->
				<div class="modal fade"  id="modal-dialog4">
	               <div class="modal-dialog">
	               	<input type='hidden' id='modal-alert-reload' value='N'>
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">반려사유</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<h2 class="mb20">반려자  : <span class="fc-blue2">홍길동 (2) </span> <span class="pl50">반려일자 :</span> <span class="fc-blue2">219-09-10 12:00 00</span></h2>
	                       		<div><textarea  rows="3"  placeholder="반려사유를 입력하세요." readonly name="apprvDescription">귀하는 보안규정상 K-Cloud 회원이 될 수 없습니다. </textarea></div>

	                      	</div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="pbton bton_blue">확인  </a>
	                       		<a type='button' class="pbton bton_dgrey" data-dismiss="modal">취소 </a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
		
			
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
		 adminUserDetail();
		 
		//메뉴활성화
		$("#req").addClass("active");
		$("#userApprove").addClass("active");		
	});
	
	function moveListPage(){
		location.href = "${contextPath}/mng/req/user/userApproval";
	}

	function userInfoDetail(){
		$.ajax({
			url : "${contextPath}/mng/req/user/getUserView",
			dataType : "JSON",
			type : "POST",
			data : {
				"reqUserSeq" : $("#h_reqUserSeq").val()
			},
			success : function(data) {				
				setData(data);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function setData(data){
		delete data.length;
 		$.each(data, function(key, val){ 			
 			if(val != null){
 				if(key=="smsRecvFlag"){
 					if(val == "Y"){ $("#"+key).text("SMS를 수신합니다."); }
 					else          { $("#"+key).text("SMS를 수신하지 않습니다."); }
 				} else if (key == "mailRecvFlag" ){
 					if(val == "Y"){ $("#"+key).text("메일을 수신합니다."); }
 					else          { $("#"+key).text("메일을 수신하지 않습니다."); }
 				} else if (key=="regDatetime") {
 					var req_datetime = val.split(" "); 					
 					$("#req_regDate").text(req_datetime[0]);
 					$("#req_regTime").text(req_datetime[1].split(".")[0]);
 				} else if(key=="apprvFlag") {
 					if(val == "Y") { 	  // 신청완료
 						$("#adminApprv1").remove(); // 진행중
 						$("#adminApprv3").remove(); // 반려
 						$("#btnConfirm").remove(); 	// 승인버튼
 						$("#btnReject").remove(); 	// 반려버튼
 						$("#apprvOperationDiv").remove(); 	// 승인권한 선택
 						$("#adminApprvTxt").html("신청완료");
 					} else if(val == "J"){ // 반려
 						$("#adminApprv1").remove(); // 진행중
 						$("#adminApprv2").remove(); // 승인완료
 						$("#btnConfirm").remove(); 	// 승인버튼
 						$("#btnReject").remove(); 	// 반려버튼
 						$("#apprvOperationDiv").remove(); 	// 승인권한 선택
 						$("#adminApprvTxt").html("반려");
 					} else {			  // 진행중 "N" 
 						$("#adminApprv2").remove(); // 승인완료
 						$("#adminApprv3").remove(); // 반려
 						$("#adminApprvTxt").html("진행중");
 					} 					
 				} else if(key=="apprvOperation") {
 					// select 초기화 방지
 				} else {
 					$("#"+key).val(val);
 					$("#"+key).text(val); 					
 					$("#req_"+key).text(val);
 				}
 			}
 		});
	}
	
	function adminUserDetail() {
		$.ajax({
			url : "${contextPath}/mng/req/user/getloginAdminUser",
			dataType : "JSON",
			type : "POST",
			data : {				
			},
			success : function(data) {				
				delete data.length;
				for(var i=0;i<data.length;i++){
					delete data[i].length;
					$.each(data[i], function(key, val){ 	
			 			if(val != null){		 				
			 				if(key=="deptName") {
			 					$("#adminDeptName").text(val);
							} else if(key=="userName") {
								$("#adminUserName").text(val);
			 				}
			 			}
			 		});
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function userInfoConfirm(apprv_flag) {
		$.ajax({
			url : "${contextPath}/mng/req/user/reqUserConfirm",
			dataType : "JSON",
			type : "POST",
			data : {				
				"reqUserSeq" 	: $("#h_reqUserSeq").val()
				, "apprvUserId" : '${adminId}'   // 승인자 ID
				, "apprvFlag" 	: apprv_flag
				, "description"	: $("[name='apprvDescription']").val()
				, "apprvOperation": $("#apprvOperation > option:selected").val()
				, "userId"	   	: $("#userId").val()
			},
			success : function(data) {
				alertBox("승인 처리가 완료 되었습니다. <br>승인 처리 내용이 신청 담당자에게 <br>메일, SMS를 통해서 전달되었습니다.", moveListPage);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	} 

	function userInfoReject(apprv_flag) {
		$.ajax({
			url : "${contextPath}/mng/req/user/reqUserConfirm",
			dataType : "JSON",
			type : "POST",
			data : {				
				"reqUserSeq" 	: $("#h_reqUserSeq").val()
				, "apprvUserId" : '${adminId}'   // 승인자 ID
				, "apprvFlag" 	: apprv_flag
				, "description"	: $("[name='apprvDescription']").val()
				, "apprvOperation": $("#apprvOperation > option:selected").val()
				, "userId"	   	: $("#userId").val()
			},
			success : function(data) {
				alertBox("반려 처리가 완료 되었습니다. <br>반려 처리 내용이 신청 담당자에게 <br>메일, SMS를 통해서 전달되었습니다.", moveListPage);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	} 
	
// 	function userInfoDelete(){
// 		$.ajax({
// 			url : "${contextPath}/mng/req/user/delete",
// 			dataType : "JSON",
// 			type : "POST",
// 			data : {
// 				"userId" : $("#userId").val()
// 			},
// 			success : function(data) {
// 				setData(data);
// 			},
// 			error : function(request, status, error) {
// 				alert("code:" + request.status + "\n" + "error:" + error);
// 			}
// 		});
// 	}

</script>
</body>
</html>
