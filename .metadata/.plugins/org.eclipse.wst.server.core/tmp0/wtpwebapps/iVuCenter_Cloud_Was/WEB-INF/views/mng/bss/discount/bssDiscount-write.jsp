<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>할인율 등록</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">요금 관리</a><a href="#" class="on">할인율</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<div class="client_DetailBg clearfix m-b-40">
					<div class="client_DetailArea clearfix">
						<h2 class="blueBoxTitle">작업 요청 내역</h2>
						<p class="company_Name2" id="projectAlias"></p>
						<p class="company_Info m-t-0 m-b-25 p-t-15"> 
							<span class="company_labelf">구분 :</span><span class="company_cont" id="upCompanyName">쓰리에이치에스</span>
							<span class="company_label">고객사 :</span><span class="company_cont" id="customerName">솔루션사업부</span>
						</p>
					</div> 
				</div>
				
				<div class="row">
					<h2 class="titleBuType01 m-b-15">할인율 등록</h2>						
					<div class="formType01">
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col width="200px">
									 <col width="772px">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><strong>적용년월</strong></th>
										<td><input type="text" class="applyDate fontVdn" name="applyDate" id="applyDate" style="width:120px;" /></td>
									</tr>
									<tr>
										<th scope="row"><strong>할인율(%)</strong></th>
										<td class="fontVdn"><input type="text" style="width:160px" name="discountRate" id="discountRate" class="tar fontVdn" value="0"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row tac m-t-60">
						<a type="button" class="btnType03 btnType03_prev" onclick="moveDetailPage();">이전</a>
						<a type="button" class="btnType03 btnType03_save m-l-15" onclick="actInsert();">저장</a>
						<a type="button" class="btnType03 btnType03_list m-l-15" onclick="moveListPage();">목록</a>         
					</div>
				</div>
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
	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/oss/project/detail",
			dataType : "JSON",
			data : {
				"projectId" : '${req.projectId}'
			},
			success : function(req) {
				$("#projectAlias").text(req.projectAlias);
				$("#upCompanyName").text(req.upCompanyName);
				$("#customerName").text(req.customerName); 
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	function calendar(){
		
		var dayName = ['일','월','화','수','목','금','토'];
		var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

		$(".applyDate").datepicker({
			showOn:"both",
			buttonImage:"${contextPath}/resources/mng/assets/img/ico_datepicker_cal.png",
			buttonImageOnly:true,
			dateFormat : "yy-mm",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});
		$("img.ui-datepicker-trigger").attr("style", "vertical-align:top;");
		$(".applyDate").val($.datepicker.formatDate('yy-mm', new Date()));
	}

	function moveDetailPage(){
		location.href = "${contextPath}/mng/bss/discount/view?projectId=${req.projectId}";
	}
	
	function moveListPage(){
		location.href = "${contextPath}/mng/bss/discount/";
	}
	
	function actInsert() {
		if($("#discountRate").val() <= 0 || $("#discountRate").val() >= 100){
			alertBox3("할인율을 확인하세요.");
			return false;
		}
		
		$.ajax({
			url : "${contextPath}/mng/bss/discount/insert",
			dataType : "JSON",
			type : "POST",
			data : {
				"projectId" : '${req.projectId}'
				, "applyDate"	: $("#applyDate").val()
				, "discountRate" : $("#discountRate").val()
				, "regUserId":	'${userId}' 
			},
			success : function(req) {
				if(req.errorMsg != 1){
					alertBox3(req.errorMsg);
				}else{
					alertBox("등록되었습니다.", moveDetailPage);
				}
				
				
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	$(document).ready(function() {
		App.init();
		calendar();
 		getDetail();
 		
 		$("#discountRate").keyup(function(){ 
 			if(isNaN($(this).val())){
 				$(this).val("0");
 				alertBox3("숫자만 입력이 가능합니다.")
 			}
 		});
 		
		//메뉴활성화
		$("#chargeManagement").addClass("active");
		$("#dcRateMenu").addClass("active");
	});
</script>
</body>
</html>