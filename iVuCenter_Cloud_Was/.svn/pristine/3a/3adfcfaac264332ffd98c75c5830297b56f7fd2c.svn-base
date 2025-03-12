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
				<h1>사용자 상세</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책관리</a><a href="#" class="on">사용자 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
			
				
				<div class="client_DetailBg">
					<div class="client_DetailArea">
						<input type="hidden" id="_userId" value="${_userId}">
						<input type="hidden" id="_role" value="${role}">
						
						<h2 class="customer_Id dpin">${_userId}</h2>
						<p class="customer_Name dpin"><span class="company_Name" id="userName"></span> <span class="customer_Name" id="deptName"></span></p> 
						<p class="company_Info">
							<span class="company_labelf">SMS 수신여부 :</span><span class="company_cont" id="smsRecvFlag"></span>
							<span class="company_label">이메일 수신여부 :</span><span class="company_cont" id="mailRecvFlag">수신</span>
						</p>
							
							
						<div class="manager_Info">
							<h2>사용자정보</h2>
							<div id="adminArea">
							<div class="mt15"> 
								<span class="manager_Name fontN" id="userName"></span>
								<input type="hidden" name="managerName" id="managerName" value="" data-original-title="" title="">
							</div>
							<div class="mt10"> 
								<span class="m_tel"></span><span class="ml10 dpin vm mt-12"  id="userTel"></span>
								<span class="m_mobile ml20"></span><span class="ml10 dpin vm mt-12" id="userPhone"></span>
								<span class="m_email ml20"></span><span class="ml10 dpin vm mt-12" id="userMail"></span> 
							</div>
							</div>
						</div>

					</div> 
				</div>
				
				<div class="row tac m-t-60">
					<a type="button" class="rbton bton_blue" onClick="moveInsertPage()"><i class="fa fa-pencil"></i> 수정</a>
		 			<a type="button" class="rbton bton_dgrey" onClick ="moveListPage()"><i class="fa fa-list"></i>  목록</a>
                </div>
            	
			
		</div>
		<!-- end page-body -->
		
		
		<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">탈퇴신청</h4>
	                       </div>
	                       <div class="modal-body">
	                          <h5 id="resMsg"></h5>
	                       	</div>
	                       	<div class="modal-footer tac">
	                       		<div id="exitEnable" style="display: none;">
		                        	<a type='button' class="btn width-100 btn-primary" onclick="userInfoDelete();">확인</a>
									<a type='button' class="btn width-100 btn-default" data-dismiss="modal" onclick="initModal();">닫기</a>
	                           	</div>
<!-- 								<div id="exitUnable" style="display: block;"> -->
<!-- 									<a type='button' class="btn width-100 btn-default" data-dismiss="modal" onclick="initModal();">닫기</a> -->
<!-- 								</div> -->

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
	

	function userInfoDetail(){
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
				alert("code:" + request.status + "\n" + "error:" + error);
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
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function setData(data){
		delete data.length; 
		$.each(data, function(key, val){
			if(val != null){
				if(key=="smsRecvFlag" || key=="mailRecvFlag" || key=="nhwithRecvFlag"){
					var msg = (val == "Y") ? "수신":"미수신";					
					$("#"+key).text(msg);					
				}else{
					$("#"+key).text(val);
				}
			}
		});
	}
	
	function moveInsertPage(){
		var userId = $("#_userId").val();
		location.href = "${contextPath}/mng/cmm/user/updatePage?userId="+userId;
	}
	
	function moveListPage(){
		location.href = "${contextPath}/mng/cmm/user/";
	}

	//modal팝업 open
	function openModal(){
		$("#modal-dialog").modal();
	}

	$(document).ready(function(){		
		 App.init();
		 userInfoDetail();
		 
		//메뉴활성화
		$("#operation").addClass("active");
		$("#cmmUser").addClass("active");
		
	});

</script>
</body>
</html>
