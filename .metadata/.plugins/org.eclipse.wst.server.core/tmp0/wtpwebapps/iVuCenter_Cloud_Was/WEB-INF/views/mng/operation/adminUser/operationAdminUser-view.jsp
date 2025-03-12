<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
			
			<input type="text" name="cloudAuthorities" id="cloudAuthorities" value="${cloudAuthorities}" />
			
			<!-- begin #content -->
			<div id="content" class="content">
				<!-- begin #content header -->
				<div class="page_header mb30">
					<h1>권한 변경</h1>
					<div class="pageNav">
						<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">정책관리</a><a href="#" class="on">권한 관리</a>
					</div>
				</div>
				<!-- end #content header -->
				
				<!-- begin page-body -->
				<div class="row pb50">
					<!-- 상단 사용자 정보 -->
					<!--  <div class="client_DetailBg m-b-40">
						<div class="client_DetailArea">
							
					    	<!-- 	<p class="customer_Name"><span id="companyName"></span><span class="company_Name" id="customerName"></span></p>  
					    	<h3 class="mt20">
					    	<span class="customer_Id">${req.userId}</span>
					    	<span class="f16 fc11 fb ml20"><span id="userName"></span> (3) </span> <span class="ml30">회원사  : 한국전력공사 </span> <span class="ml30">소속조직 (부서)  : IT 기획처 인프라 계획</span></h3>
							<p class="company_Info">
								<span class="company_labelf"> <i class="fa fa-envelope fc-blue2"></i> 이메일 수신여부 :</span> <span class="fb" >수신</span>
								<span class="company_label"> <i class="fa fa-commenting-o fc-blue2"></i> SMS 수신여부 :</span> <span class="fb" id="nhwithRecvFlag">미수신</span>
							</p>
							<div class="mt10"> 
											<span class="m_tel"></span><span class="ml10 dpin vm mt-12" id="userTel"></span>
											<span class="m_mobile ml20"></span><span class="ml10 dpin vm mt-12" id="userPhone"></span>
											<span class="m_email ml20"></span><span class="ml10 dpin vm mt-12" id="userMail"></span> 
							</div>

						<!-- 	<div class="p10">		
								<div class="manager_Info">
									<h2>사용자정보</h2>
									<div id="adminArea">
										<div class="mt15"> 
											<span class="manager_Name fontN" id="userName"></span>
											<input type="hidden" name="managerName" id="managerName">
										</div>
										<div class="mt10"> 
											<span class="m_tel"></span><span class="ml10 dpin vm mt-12" id="userTel"></span>
											<span class="m_mobile ml20"></span><span class="ml10 dpin vm mt-12" id="userPhone"></span>
											<span class="m_email ml20"></span><span class="ml10 dpin vm mt-12" id="userMail"></span> 
										</div>
									</div>
								</div>
							</div> 
							
						</div> 
					</div> -->
					
					
					<div class="userinfolineBg">
<%-- 					<input type="hidden" id="_userId" value="${userId}"> --%>
					<div class="userinfoBg">
						<div class="usercompinfo">
							<div class="fl">
								<span class="pid" id="userId"></span> <span class="f20 fc11 ml20" id="userName"></span> <span class="f16 fc66">(3) <span>
								<div class="mt20">
									<span class="company_labelf"> 회원사 :</span><span class="company_cont" id="customerName">한국전력공사</span>
									<span class="company_label"> 소속조직(부서) :</span><span class="company_cont" id="deptName"> IT기획처 인프라 계획</span>
								</div> 
							</div>
						</div>
						
						
						<ul class="userindiinfo">
						   <li class="userPhone width-80">
						   </li>
						   <li>
						     <ul class="dpin mt10">
						  	 <li class="w100 f16 fc11" >핸드폰</li>
						  	 <li class="w100 f16 pt10" id="userPhone">000-0000-0000</li>
						  	 </ul>
						   </li>
						   <li class="userTel width-80 ml30">
						   </li>
						   <li>
						     <ul class="dpin mt10">
						  	 <li class="w100 f16 fc11">전화번호(사선)</li>
						  	 <li class="w100 f16 pt10" id="userTelEx">061-1234</li>
						  	 </ul>
						    <li class="userEmail width-80 ml30">
						   </li>
						   <li>
						     <ul class="dpin mt10">
						  	 <li class="w100 f16 fc11">이메일</li>
						  	 <li class="w100 f16 pt10" id="userMail">abcd@abcd.co.kr</li>
						  	 </ul>
						   </li>
						</ul>
					</div>  
					<div class="userReceiveInfo">
						<div class="receiveSMS">
							<span class="f16 fc11"><i class="fa fa-commenting-o fc-blue2"></i> SMS 수신여부</span>
							<span class="receive" id="smsRecvFlag">수신 or 미수신</span>
						</div>	
						<div class="receivemail">
							<span class="f16 fc11"> <i class="fa fa-envelope fc-blue2"></i> 메일 수신여부</span>
							<span class="receive" id="mailRecvFlag">수신 or 미수신</span>
						</div>	
					</div>
				</div>
					
					
					
					<!-- end 상단 사용자 정보 -->
					
					<!-- 하단 권한정보 -->
					<h2 class="titleBuType01 m-b-15 mt30">권한 정보</h2>
					<div class="formType01">
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col width="150px">
									 <col width="*">
								</colgroup>
								<tbody>								
									<tr>
										<th scope="row"><strong>승인</strong></th>
										<td>
											<div class="optionBox w114">
												<label><input type="checkbox" id="LOGIN" name='auth' value='Y'><span>회원가입승인</span></label>
												<label><input type="checkbox" id="WF4000A0" name='auth' value='Y'><span>한전결재라인</span></label>
												<label><input type="checkbox" id="APPRVPASS" name='auth' value='Y'><span>결재전결</span></label>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>작업</strong></th>
										<td>
											<div class="optionBox w114">
												<label><input type="checkbox" id="PORTALADMIN" name='auth' value='Y'><span>포털 담당자</span></label>
												<label><input type="checkbox" id="OPERATION" name='auth' value='Y'><span>작업담당</span></label>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- end 하단 권한정보 -->
					
					<!-- 버튼모음 -->
					<div class="row tac m-t-60">
						<!--<a type="button" class="rbton bton_orange" onClick="actDelete();"><i class="fa fa-trash"></i> 삭제</a>-->
						<a type="button" class="rbton bton_blue" onClick="actUpdate();"><i class="fa fa-floppy-o"></i> 저장</a>
			 			<a type="button" class="rbton bton_dgrey" onClick="moveListPage();"><i class="fa fa-list"></i> 목록</a>
	                </div>
	                <!-- end 버튼모음 -->
				
					<!-- begin #footer -->
					<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
					<!-- end #footer -->
				</div>
			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->
		
	<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>	
	<script type="text/javascript">
		$(document).ready(function() {

			App.init();
			userInfoDetail();
			userAuthDetail();
			document.getElementById('cloudCount');

			// 회원가입승인권한은 한명의 관리자만 존재
			$("input:checkbox[id='LOGIN']").click( function() {
 				if( $("input:checkbox[id='LOGIN']").is(":checked") ) {
 					checkLoginAuth();
 				}
 			});			
		
			//메뉴활성화
			$("#operation").addClass("active");
			$("#adminUser").addClass("active");
	
		}); // end of document.ready()



		function userInfoDetail(){
			$.ajax({
				url : "${contextPath}/mng/cmm/user/userInfoDetail",
				dataType : "JSON",
				type : "POST",
				data : {
					"userId" : '${req.userId}'
				},
				success : function(req) {
					delete req.length; 
					$.each(req, function(key, val){
						if(val != null){
							if(key=="smsRecvFlag" || key=="mailRecvFlag"){
								if(val == "Y"){
									$("#"+key).text("수신");
								}else{
									$("#"+key).text("미수신");
								}
							}else{
								$("#"+key).text(val);
							}
						}
					});
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		
		function userAuthDetail(){
			$.ajax({
				url : "${contextPath}/mng/operation/adminUser/auth",
				dataType : "JSON",
				type : "POST",
				data : {
					"userId" : '${req.userId}'
				},
				success : function(req) {
					delete req.length; 
					$.each(req, function(key, val){
						if(val == "Y"){
							console.log(key.toUpperCase());
							$("input:checkbox[id='"+key.toUpperCase()+"']").attr('checked', val);
						}
					});
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}	
		
		function checkLoginAuth() {
			$.ajax({
				url : "${contextPath}/mng/operation/adminUser/checkLoginAuth",
				dataType : "JSON",
				type : "POST",
				data : {					
				},
				success : function(req) {
					if(req != "0") {
						alertBox3("회원가입승인 권한을 가진 사용자가 이미 있습니다.");
						$("input:checkbox[id='LOGIN']").prop("checked", false);						
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		
		function moveListPage(){
			location.href = "${contextPath}/mng/operation/adminUser/";
		}
					
		function actUpdate(){

			var jsonData = setJsonData();
			$.ajax({
				url : "${contextPath}/mng/operation/adminUser/updateAdmin",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(req) {
					if(req == "1"){
						if($("input:checkbox[name='auth']:checked").length > 0){
							alertBox("수정되었습니다.", moveListPage)
						}else{
							alertBox("관리자 권한이 삭제 되었습니다.", moveListPage)
						}
					}else{
						alertBox3("오류");
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});		
		}

		function setJsonData(){
			
			var jsonData = {

					"userId" : "${req.userId}"
					, "portaladmin": $("input:checkbox[id='PORTALADMIN']").is(":checked")?"Y":"N" 
					, "operation": $("input:checkbox[id='OPERATION']").is(":checked")?"Y":"N" 
					, "confirmAction" :$("input:checkbox[id='CONFIRMACTION']").is(":checked")?"Y":"N" 
					, "login"    : $("input:checkbox[id='LOGIN']").is(":checked")?"Y":"N"
					, "WF1000A0" : $("input:checkbox[id='WF1000A0']").is(":checked")?"Y":"N"
					, "WF1000B0" : $("input:checkbox[id='WF1000B0']").is(":checked")?"Y":"N"
					, "WF1000C0" : $("input:checkbox[id='WF1000C0']").is(":checked")?"Y":"N"
					, "WF1000D0" : $("input:checkbox[id='WF1000D0']").is(":checked")?"Y":"N"
					, "WF1000E0" : $("input:checkbox[id='WF1000E0']").is(":checked")?"Y":"N"
					, "WF2000A0" : $("input:checkbox[id='WF2000A0']").is(":checked")?"Y":"N"
					, "WF2000B0" : $("input:checkbox[id='WF2000B0']").is(":checked")?"Y":"N"
					, "WF2000C0" : $("input:checkbox[id='WF2000C0']").is(":checked")?"Y":"N"
					, "WF2000D0" : $("input:checkbox[id='WF2000D0']").is(":checked")?"Y":"N"
					, "WF2000E0" : $("input:checkbox[id='WF2000E0']").is(":checked")?"Y":"N"
					, "WF4000A0" : $("input:checkbox[id='WF4000A0']").is(":checked")?"Y":"N"
					, "apprvPass" : $("input:checkbox[id='APPRVPASS']").is(":checked")?"Y":"N"
					, "length"	 : $("input:checkbox[name='auth']:checked").length
					};

			return jsonData;
		}
			
		function actDelete() {
			$.ajax({
				url : "${contextPath}/mng/operation/adminUser/updateAdmin",
				dataType : "JSON",
				type : "POST",
				data : {
					"userId" : '${req.userId}'
					, "portalAdmin" : "N"
					, "operation" : "N" 
					, "confirmAction" : "N" 
					, "login" : "N"
					, "WF1000A0" : "N"
					, "WF1000B0" : "N"
					, "WF1000C0" : "N"
					, "WF1000D0" : "N"
					, "WF1000E0" : "N"
					, "WF2000A0" : "N"
					, "WF2000B0" : "N"
					, "WF2000C0" : "N"
					, "WF2000D0" : "N"
					, "WF2000E0" : "N"
					, "length"	 : 0
				},
				success : function(req) {
					if(req == "1"){
						alertBox("관리자 권한이 삭제 되었습니다.", moveListPage)
					}else{
						alertBox3("오류");
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});			
		}			
			
	</script>
		
	</body>
</html>