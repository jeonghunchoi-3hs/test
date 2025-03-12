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
		
			<!-- begin page-header -->
			<h1 class="page-header fc66 fb"> <i class="fa fa-dot-circle-o fcb"> </i> 배치관리 등록<span class="root">관리자포털 > 운영관리 > 배치관리 </span></h1>
			<!-- end page-header -->

			<!-- begin page-body -->
			<div class="row mb50">
			
			<!-- begin section-container -->		  
			<div class="section-container inbox100">

				<!-- begin normal input table---------->		
				<div class="tableC">
					<input type="hidden" id="h_userId" value="${userId}">
					 <table>
					 	<colgroup>
					 		<col width="200px">
					 		<col width="*">
					 	</colgroup>
						<tbody>
							<tr>
							  	<td class="left-b height-40 pl22">Job name</td>
							  	<td>
							  	<input class="form-control width-300" type="text" id="jobName" value=""/>
							  	</td>
							</tr>
							<tr>
							  	<td class="left-b height-40 pl22">Job class name</td>
							  	<td>
							  	<input class="form-control width-300" type="text" id="jobClassName" value="" />
							  	</td>
							</tr>
							<tr>
							  	<td class="left-b height-40 pl22">Cron Expression</td>
							  	<td>
							  	<input class="form-control width-300" type="text" id="cronExpression" value="" data-html="true" title="<div class='tal'>예) 0 0/5 14 * * ? <br/> 매일 오후 2시부터 2시55분까지 매 5분마다 실행</div>" data-toggle="tooltip"/>
							  	</td>
							</tr>							
						</tbody>
					</table>
				</div>
				<!-- end normal input table---------->
				
			</div>
		    <!-- end section-container -->	   
		    
		    <!-- begin button-->
			<div class="row tac mt20">
				<button type="button" class="btn btn-lime" onclick="batchInsert();"><i class="fa fa-floppy-o"></i> 저장</button>
				<button type="button" class="btn btn-grey" onclick="movePage();"><i class="fa fa-times"></i> 취소</button>
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
	
	function batchInsertChk() {
		if($("#jobName").val()==""){
			alertBox3("Job name를 입력하세요");
			$("#jobName").focus();
			return false;
		}
		if($("#jobClassName").val()==""){
			alertBox3("Job class name를 입력하세요");
			$("#jobClassName").focus();
			return false;
		}
		if($("#cronExpression").val()==""){
			alertBox3("Cron Expression를 입력하세요");
			$("#cronExpression").focus();
			return false;
		}
		confirmBox("등록하시겠습니까? ", batchInsert);
	}
	// 배치수정
	function batchInsert(){
		$.ajax({
// 			url : "${contextPath}/mng/bss/batch/write",
			url : "${contextPath}/mng/batch/registerJob.do",
			dataType : "JSON",
			data : {
				    "userId" : "${userId}"
					, "jobName" : $("#jobName").val()
					, "jobClassName" : $("#jobClassName").val()
					, "cronExpression" : $("#cronExpression").val()
			},
			success : function(data) {
				alertBox("등록되었습니다.", movePage);
			},
			error : function(request) {
				alertBox3("code:" + request.status + "\n" + "error:" + request.text);
			}
		});
	}
	
	// 리스트페이지 이동
	function movePage(){
		location.href = "${contextPath}/mng/bss/batch/";
	}
	
	$(document).ready(function(){
		App.init();
		//메뉴활성화
		$("#operation").addClass("active");	
		$("#batch").addClass("active");	
		
	});

</script>
</body>
</html>