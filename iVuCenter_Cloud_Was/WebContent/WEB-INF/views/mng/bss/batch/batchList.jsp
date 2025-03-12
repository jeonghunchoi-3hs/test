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
		
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin header -->
			<h1 class="page-header fc66 fb"> <i class="fa fa-dot-circle-o fcb"> </i> 배치관리 목록 <span class="root">관리자포털 > 운영관리 > 배치관리</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
			
				
			<!-- 테이블시작 -->
			<div class="col-md-12">
				<div class="panel">
				    <div class="table-responsive">
				        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="batchList" summary="배치관리">
						<caption>게시판 목록 : Job name, 상태, CRON 표현식, 조작로 구성</caption> 
							<colgroup>
								<col width="*">
<%-- 								<col width="30%"> --%>
								<col width="15%">
								<col width="15%">
								<col width="30%">
							</colgroup>
							<thead>
							    <tr class="grey">
									<th class="tac">Job name</th>
<!-- 									<th class="tac">Job class path</th> -->
									<th class="tac">상태</th>
									<th class="tac">CRON 표현식</th>
									<th class="tac">조작</th>
							    </tr>
							</thead>
						</table>
					</div>
				</div>			
			</div>
			<!-- 테이블 끝 -->
			
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
	function gridList() {
		
		 $("#batchList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/batch/schedulerList.do"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					
				}
			}
			,"columns":[ 
	        	{"data":"jobName", "class":"tac"}
// 	        	, {"data":"jobClassName", "class":"tac"}
	        	, {"data":"triggerState", "class":"tac"}
	        	, {"data":"cronExpression", "class":"tac"}
	        	, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				,{"targets":[0], "render":function(data,type,full){
					return full.jobName
				}}
// 				, {"targets":[1], "render":function(data,type,full){
// 					return full.jobClassName
// 				}}
				, {"targets":[1], "render":function(data,type,full){
					return full.triggerState
				}}
				, {"targets":[2], "render":function(data,type,full){
					return full.cronExpression
				}}
				
				, {"targets":[3], "render": function(data,type,full){
					return "<button class='btn btn-danger_01 mr5' onclick='batchStop(\""+full.jobName+"\");'><i class='fa fa-stop'></i></button>" 
							+"<button class='btn btn-lime_01 mr5' onclick='batchStart(\""+full.jobName+"\");'><i class='fa fa-play'></i></button>"
							+"<button class='btn btn-grey_02 mr5' onclick='batchDelete(\""+full.jobName+"\");'>삭제</button>"
							+ "<button class='btn btn-primary_02' onclick='moveUpdatePage(\""+full.jobName+"\");'>수정</button>";
				}}
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top"T>rt<"bottom"pi>',"oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {
						moveInsertPage();
					}
				}]
			}
		});
		
	}

 	//등록페이지이동
 	function moveInsertPage(){                                                                                                  
 		location.href = "${contextPath}/mng/bss/batch/writePage";	
 	}
 	
 	//수정페이지이동
 	function moveUpdatePage(jobName){                                                                                                  
 		location.href = "${contextPath}/mng/bss/batch/updatePage?jobName="+jobName;	
 	}
 	
 	// 배치STOP
 	function batchStop(jobName){
 		$.ajax({
			url : "${contextPath}/mng/batch/stopJob.do",
			dataType : "JSON",
			data : {
				    "jobName" : jobName
			},
			success : function(data) {
				alertBox("Job이 중지되었습니다.", pageReload);
			},
			error : function(request) {
				alertBox3("code:" + request.status + "\n" + "error:" + request.text);
			}
		});
 	}
 	
 	// 배치START
 	function batchStart(jobName){
 		$.ajax({
			url : "${contextPath}/mng/batch/resumeJob.do",
			dataType : "JSON",
			data : {
				    "jobName" : jobName
			},
			success : function(data) {
				alertBox("Job이 시작되었습니다.", pageReload);
			},
			error : function(request) {
				alertBox3("code:" + request.status + "\n" + "error:" + request.text);
			}
		});
 	}
 	
 	//배치삭제
 	function batchDelete(jobName){                                                                                                  
 		$.ajax({
			url : "${contextPath}/mng/batch/deleteJob.do",
			dataType : "JSON",
			data : {
				    "jobName" : jobName
			},
			success : function(data) {
				alertBox("삭제되었습니다.", pageReload);
			},
			error : function(request) {
				alertBox3("code:" + request.status + "\n" + "error:" + request.text);
			}
		});
 	}
	
 	//페이지 새로고침
 	function pageReload(){
 		location.reload();
 	}
 	
	$(document).ready(function() {
		
		gridList();
		App.init();
		
		//메뉴활성화
		$("#operation").addClass("active");
		$("#batch").addClass("active");

	});
</script>
</body>
</html>