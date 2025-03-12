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
			<h1 class="page-header fc66 fb"> <i class="fa fa-dot-circle-o fcb"> </i> 배치관리 수정<span class="root">관리자포털 > 운영관리 > 배치관리 </span></h1>
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
							  	<td id="jobName">
<!-- 							  	<input class="form-control width-300" type="text" id="jobName" value="" readonly="readonly"/> -->
							  	</td>
							</tr>
							<tr>
							  	<td class="left-b height-40 pl22">Job class path</td>
							  	<td id="jobClassName">
<!-- 							  	<input class="form-control width-300" type="text" id="jobClassName" value="" readonly="readonly"/> -->
							  	</td>
							</tr>
							<tr>
							  	<td class="left-b height-40 pl22">CRON</td>
							  	<td>
							  	<input class="form-control width-300" type="text" id="cronExpression" value=""/>
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
				<button type="button" class="btn btn-lime" onclick="batchUpdate();"><i class="fa fa-floppy-o"></i> 저장</button>
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
	
	// 배치수정
	function batchUpdate(){
		$.ajax({
			url : "${contextPath}/mng/batch/reScheduleJob.do",
			dataType : "JSON",
			data : {
					"jobName" : $("#jobName").text()
					, "cronExpression" : $("#cronExpression").val()
			},
			success : function(data) {
				alertBox("적용되었습니다.", movePage);
			},
			error : function(request) {
				alertBox3("code:" + request.status + "\n" + "error:" + request.text);
			}
		});
	}
	
	// 배치상세
	function batchDetail(){
		$.ajax({
			url : "${contextPath}/mng/batch/jobDetail.do",
			dataType : "JSON",
			data : {
				    "jobName" : "${jobName}"
			},
			success : function(data) {
				$("#jobName").text(data.jobName);
				$("#jobClassName").text(data.jobClassName);
				$("#cronExpression").val(data.cronExpression);
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
		batchDetail();
		//메뉴활성화
		$("#operation").addClass("active");	
		$("#batch").addClass("active");	
		
	});

</script>
</body>
</html>