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
			<h1 class="page-header fc66 fb"> <i class="fa fa-dot-circle-o fcb"> </i> 카탈로그 정보수정<span class="root">자원&서비스 > 카탈로그 관리 > 카탈로그 정보수정</span></h1>
			<!-- end page-header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<!-- begin col-12 -->
				<div class="col-md-12">
					<!-- begin panel -->
						<!-- begin normal input table---------->
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
												<div class="input-group date dpin">
													<input type="text" class="form-control dpin width-100" placeholder="날짜선택" id="applyDate" readonly="readonly"/>
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
					<div class="col-md-12 tac">
						<input type="button" id="catalogInsert" value="저장" class="btn btn-primary width-80" onclick="saveCheck()">
				        <input type="button" id="catalogList" value="목록" class="btn btn-grey width-80" onclick="moveListPage()">
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
		$("#applyDate").val(result.applyDate);
		$("#catalogName").val(result.catalogName);
	}
	
	function saveCheck(){
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
		confirmBox("저장하시겠습니까?", catalogUpdate);
	}

	// 수정
	function catalogUpdate() {
		var jsonData = setJsonData();
		$.ajax({
			url : "${contextPath}/mng/bss/catalog/catalogUpdate",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("저장되었습니다.", moveListPage);
				}else{
					alertBox("저장에 실패하였습니다.", moveListPage);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
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
		if($("#catalogSeq").val() != 0 ){
			catalogDetail($("#catalogSeq").val());
		}
		//메뉴활성화
		$("#productAservice").addClass("active");
		$("#catalog").addClass("active");
	});
	
</script>
</body>
</html>