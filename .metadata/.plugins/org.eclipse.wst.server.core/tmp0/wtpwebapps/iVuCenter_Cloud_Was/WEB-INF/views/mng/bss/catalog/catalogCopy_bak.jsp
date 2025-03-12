<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in hide"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

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
			<!-- begin page-header -->
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i>카탈로그 정보<span class="root">자원&서비스 > 카탈로그 관리 > 카탈로그 정보</span></h1>
			<!-- end page-header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<!-- begin col-12 -->
				<div class="col-md-12">
					<!-- begin panel -->
						<!-- begin normal input table---------->
						<h5 class="ml60">ㆍ기존 카탈로그</h5>	
						<div class="tableC mb20">
						<input type="hidden" id="catalogSeq" value="${catalogSeq}">
							<table>
								<colgroup>
									<col width="20%">
									<col width="80%">
								</colgroup>
								<tbody>
									<tr>
										<td class="left-b height-40">적용일자</td>
									  	<td colspan="3">
											<div class="col-md-5">
												<div class="input-group date">
													<input type="text" class="form-control" placeholder="날짜선택" id="oldApplyDate"/>
<!-- 													<span class="input-group-addon"><i class="fa fa-calendar"></i></span> -->
												</div>
										  	</div>
									  	</td>
									</tr>
									<tr>
										<td class="left-b height-40">카탈로그 이름</td>
									  	<td>
											<div class=col-md-12>
												<input type="text" class="form-control"  id="oldCatalogName"/>
										  	</div>
										</td>
								</tbody>
							</table>	
						</div>
						
						<h5 class="ml60">ㆍ복사할 카탈로그</h5>	
						<div class="tableC mb20">
							<table>
								<colgroup>
									<col width="20%">
									<col width="80%">
								</colgroup>
								<tbody>
									<tr>
										<td class="left-b height-40">적용일자</td>
									  	<td colspan="3">
											<div class="col-md-5">
												<div class="input-group date dpin">
													<input type="text" class="form-control dpin width-100" placeholder="날짜선택" id="applyDate"/>
<!-- 													<span class="input-group-addon"><i class="fa fa-calendar"></i></span> -->
												</div>
										  	</div>
									  	</td>
									</tr>
									<tr>
										<td class="left-b height-40">카탈로그 이름</td>
									  	<td>
											<div class=col-md-12>
												<input type="text" class="form-control"  id="catalogName"/>
										  	</div>
										</td>
								</tbody>
							</table>	
						</div>
						<!-- end normal input table---------->
					<!-- end panel -->
					
					<!-- begin button-->
					<div class="col-sm-12 tac mt20">
						<button type="button" id="catalogInsert"  class="btn btn-primary width-80" onclick="moveCatalogCopy()">복사</button>
				        <button type="button" id="catalogList"  class="btn btn-grey width-80" onclick="moveListPage()">목록</button>
					</div>
					<!-- end button -->
				
				</div>
                <!-- end col-12 -->	

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
	
	//자원 view상세 불러오기
	function catalogDetail(catalogSeq) {
		$.ajax({
			url : "${contextPath}/mng/bss/catalog/catalogDetail",
			dataType : "JSON",
				type : "POST",
			data : {
				"catalogSeq" : catalogSeq
			},
			success : function(data) {
				var result = data;
				catalogSetData(result);
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function catalogSetData(result){
		$("#catalogSeq").val(result.catalogSeq);
		$("#oldApplyDate").val(result.applyDate);
		$("#oldCatalogName").val(result.catalogName);
	}
	
	// 등록
	function moveCatalogCopy() {
		
		if($("#applyDate").val()==""){
			alertBox3("적용일자를 입력하세요");
			$("#applyDate").focus();
			return false;
		}
		if($("#catalogName").val()==""){
			alertBox3("카탈로그 이름을 입력하세요");
			$("#catalogName").focus();
			return false;
		}
		var jsonData = setJsonData();
		$.ajax({
			url : "${contextPath}/mng/bss/catalog/catalogInsert",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("복사 되었습니다.", moveListPage);
				}else if(data==0){
					alertBox3("정책일자가 중복되었습니다.");	
				}else{
					alertBox3("복사 실패");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		})
	}
	
	// json 데이터 세팅
	function setJsonData(){
		var jsonData = {
				"applyDate" : $("#applyDate").val()
				,"catalogName": $("#catalogName").val()
				,"catalogSeq": $("#catalogSeq").val()
			};
		return jsonData;
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/bss/catalog/";
	}
	
	// 달력
	function calendar(){
		var dayName = ['일','월','화','수','목','금','토'];
		var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

		$("#applyDate").datepicker({
			showOn:"both",
			buttonImage:"${contextPath}/resources/assets/img/calen.png",
			buttonImageOnly:true,
			dateFormat : "yy-mm-dd",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});
		
		$("#copyApplyDate").datepicker({
			showOn:"both",
			buttonImage:"${contextPath}/resources/assets/img/calen.png",
			buttonImageOnly:true,
			dateFormat : "yy-mm-dd",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});
		
/* 		$("#dispEdate").datepicker({
			showOn:"both",
			buttonImage:"${apachePath}/resources/assets/img/calen.png",
			buttonImageOnly:true,
			dateFormat:"yy-mm-dd",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		}); */
	}
	

	$(document).ready(function() {
		App.init();
		calendar();
		catalogDetail($("#catalogSeq").val());
//		if($("#noticeNo").val() != 0 ){
//			bbsDetail($("#noticeNo").val());
//		}
		//메뉴활성화
		$("#productAservice").addClass("active");
		$("#catalog").addClass("active");
	});
	
</script>
</body>
</html>