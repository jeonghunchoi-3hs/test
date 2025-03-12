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
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 메일 템플릿 수정 <span class="root">관리자포털 > 메일 > 메일 템플릿 </span></h1>
			<!-- end page-header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<!-- begin col-12 -->
				<div class="col-md-12">
					<!-- begin panel -->
						<!-- begin normal input table---------->
						<div class="tableB mb20">
							<input type="hidden" id="templateId" value="${templateId}">
							<table>
								<colgroup>
									<col width="10%">
									<col width="40%">
									<col width="10%">
									<col width="40%">
								</colgroup>
								
								<tbody>
									<tr>
										<td class="cen height-40 tal">제목</td>
									  	<td colspan="3">
										 	<div class="col-md-12">
										  		<input class="form-control" type="text" id="title"/>
										  </div>
									  	</td>
									</tr>
									<tr>
										<td class="cen height-40 tal">메시지</td>
									  	<td colspan="3">
										 	<div class="col-md-12">
										  		<div id="message" ></div>
										  </div>
									  	</td>									  	
									</tr>
									<tr>
										<td class="cen height-40 tal">예약어</td>
									  	<td colspan="3">
											<div class="col-md-12" id="div_reservedWord"></div>
									  	</td>
									</tr>										
									<!-- <tr>
										<td class="cen height-40 tal">삭제 여부</td>
									  	<td colspan="3">
										 	<div class="col-md-6">
												<select class="form-control" id="delFlag">
													<option value="Y">삭제</option>
													<option value="N">미삭제</option>
												</select>
										  </div>
									  	</td>
									</tr>	 -->								
								</tbody>
							</table>	
						</div>
						<!-- end normal input table---------->
					<!-- end panel -->

					
					<!-- begin button-->
					<div class="col-md-12 tac">
						<input type="button" id="btnModify" value="저장" class="btn btn-primary" onclick="actInsert()">
				        <input type="button" id="btnList" value="취소" class="btn btn-grey" onclick="moveListPage()">
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
<script type='text/javascript' src="${contextPath}/resources/ckeditor/ckeditor.js"></script>
<script type='text/javascript' src="${contextPath}/resources/ckeditor/ckedtor_sample.js"></script>

<script type="text/javascript">
	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/mail/template/detail",
			dataType : "JSON",
			data : {
				"templateId" : $("#templateId").val()
			},
			success : function(data) {
				var result = data;
				
				$("#title").val(result.title);
				$("#message").html(result.content);
				$("#delFlag").val(result.delFlag);
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function getDetailReservedWord() {
		$.ajax({
			url : "${contextPath}/mng/template/reserved/word/list",
			dataType : "JSON",
			data : {
				"templateId" : $("#templateId").val()
			},
			success : function(data) {
				delete data.length;
				for(var i=0;i<data.length;i++){
					delete data[i].length;
					$.each(data[i], function(key, val){
						if(val != null){
							if(key=="reservedWord"){
								$("#div_"+key).append(val);	
							}
						}
					});	
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	// 등록/수정
	function actInsert() {
		$.ajax({
			url : "${contextPath}/mng/mail/template/update",
			dataType : "JSON",
			type : "POST",
			data : {
				"templateId" : $("#templateId").val()
				, "title" : $("#title").val()
				, "content" : CKEDITOR.instances.message.getData()
				, "delFlag" : $("#delFlag").val()
				, "modUserId" : "${userId}"
			},
			success : function(data) {
				var result = data;
 				if(result==1){
 					moveListPage();
				}else{
					alertBox3("fail!!");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		})
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/mail/template/";
	}
	
	
	$(document).ready(function() {
		App.init();
		ckEditorInit('message');
		getDetail();
		getDetailReservedWord();
		
		//메뉴활성화
		$("#mail").addClass("active");
		$("#mailTemplate").addClass("active");
	});
	
</script>
</body>
</html>