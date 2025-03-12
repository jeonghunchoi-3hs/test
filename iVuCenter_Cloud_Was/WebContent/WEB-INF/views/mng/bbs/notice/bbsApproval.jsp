<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>

<!-- jQuery -->
<script type='text/javascript' src="${contextPath}/resources/js/plugins/jquery.js"></script>
<!--     Bootstrap Core CSS	 -->
<link type='text/css' rel="stylesheet"
	href="${contextPath}/resources/css/bootstrap.min.css" />


<!--     MetisMenu CSS	 -->
<link type='text/css' rel="stylesheet"
	href="${contextPath}/resources/css/plugins/metisMenu.min.css" />

<!--     DataTables CSS	 -->
<link type='text/css' rel="stylesheet"
	href="${contextPath}/resources/css/plugins/dataTables.bootstrap.css" />
<link type='text/css' rel="stylesheet"
	href="${contextPath}/resources/css/plugins/dataTables.tableTools.css" />

<!-- 	DateTimePicker CSS -->
<link type='text/css' rel="stylesheet"
	href="${contextPath}/resources/css/plugins/datepicker.css" />

<!--     Custom CSS -->
<link type='text/css' rel="stylesheet"
	href="${contextPath}/resources/css/sb-admin-2.css" />

<!--     Custom Fonts -->
<link type='text/css' rel="stylesheet"
	href="${contextPath}/resources/assets/plugins/font-awesome/css/font-awesome.min.css" />

<!-- 	Bootstrap Core JavaScript -->
<script type='text/javascript'
	src="${contextPath}/resources/js/plugins/bootstrap.min.js"></script>
<script type='text/javascript' src="${contextPath}/resources/js/plugins/respond.js"></script>

<!--     Plugins -->
<script type='text/javascript'
	src="${contextPath}/resources/js/plugins/metisMenu.min.js"></script>
<script type='text/javascript'
	src="${contextPath}/resources/js/plugins/jquery.dataTables.js"></script>
<script type='text/javascript'
	src="${contextPath}/resources/js/plugins/dataTables.bootstrap.js"></script>
<script type='text/javascript'
	src="${contextPath}/resources/js/plugins/dataTables.tableTools.js"></script>
<script type='text/javascript'
	src="${contextPath}/resources/js/plugins/bootstrapValidator.min.js"></script>
<script type='text/javascript'
	src="${contextPath}/resources/js/plugins/jquery.placeholder.js"></script>
<script type='text/javascript'
	src="${contextPath}/resources/js/plugins/bootstrap-datepicker.js"></script>
<script type='text/javascript'
	src="${contextPath}/resources/js/plugins/bootstrap-datepicker.kr.js"></script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<script type="text/javascript">

	function bbsDetail(noticeNo) {
		$.ajax({
			url : "detail",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"noticeNo" : noticeNo
			},
			success : function(data) {
				var result = data;
				setData(result);
				
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}
	
	function approvalDetail(noticeNo) {
		$.ajax({
			url : "detail",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"noticeNo" : noticeNo
			},
			success : function(data) {
				var result = data;
				setData(result);
				
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}
	
	function bbsDetailModify() {
		
		var rowSeq = $("#noticeNo").val();
		$.ajax({
			url : "noticeBbsDetail",
			dataType : "JSON",
			type : "POST",
			data : {
				"noticeNo" : rowSeq
			},
			success : function(data) {
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}
	
	
	
	
	function deleteNoticeBbs(){
		
		confirm("삭제하시겠습니까?");
		
		//alert($("#noticeNo").val());
		var rowSeq = $("#noticeNo").val();
		
		$.ajax({
			url : "delete",
			dataType : "JSON",
			type : "POST",
			data : {
				"noticeNo" : rowSeq
			},
			success : function(data) {
				var result = data;
				if(result==1){
					//alert("Deleted!!");
					moveListPage();
				}else{
					//alert("failed!!");
					moveListPage();
				}
				
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
		
	}
	
	
	function setData(result){
		$("#title").text(result.title);
		$("#noticeType").val(result.noticeType);
		$("#regDatetime").text(result.regDatetime);
		$("#regUserId").text(result.regUserId);
		 $("#hitCount").text(result.hitCount);
		$("#content").text(result.content);
	}
	
	// 목록 페이지이동
	function moveListPage(){
		//location.href = "/NHCloud/mng/bbs/notice/";
		location.href = "${contextPath}/mng/bbs/notice/";
	}
	// 등록/수정 페이지이동
	function moveInsertPage(){
		var noticeNo = $("#noticeNo").val();
		location.href = "${contextPath}/mng/bbs/notice/write?noticeNo="+noticeNo;
	}
	
	$(document).ready(function() {
		bbsDetail("${noticeNo}");
	
	});
	
</script>

<title>KEPCO Cloud Service Platform</title>
</head>
<body>
	<div id="wrapper">
		<h1>사용문의 - 공지사항</h1>

		<hr>
		<!-- <div id="page-wrapper"> -->
		<div class="container-fluid">

			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">
						<small>공지사항</small>
					</h1>
				</div>
			</div>

		</div>
		<!-- /.container-fluid -->
		
	</div>
	<div class="container-fluid">

		    <div class="col-lg-12">
               	<div class="panel panel-default">
					<div class="panel-body">
													
						<form id="noticeDetailForm" method="post" class="form-horizontal" >
		                    <div class="form-group">
		                    	<input type="hidden" id="noticeNo" value="${noticeNo}">
			                    <label class="col-lg-4 control-label">제목</label>
			                    <div class="col-lg-6">
			                        <p class="form-control-static" id="title"></p>
			                    </div>
			                </div>
			                
         			        <div class="form-group">
			                    <label class="col-lg-4 control-label">유형</label>
			                    <div class="col-lg-6">
            				            <select name="noticeType"  id="noticeType" >
											<c:forEach items="${code}" var="codelist" varStatus="status" >
												<option value="${codelist.codeId}">${codelist.codeName}</option>
											</c:forEach>
			                        	</select>
<!-- 			                        <input type="text" id="regDatetime"> -->
			                    </div>
			                </div>    
			                			                                   
			                <div class="form-group">
			                    <label class="col-lg-4 control-label">작성일</label>
			                    <div class="col-lg-6">
			                    	<p class="form-control-static" id="regDatetime"></p>
<!-- 			                        <input type="text" id="regDatetime"> -->
			                    </div>
			                </div>
			                <div class="form-group">
			                    <label class="col-lg-4 control-label">조회수</label>
			                    <div class="col-lg-6">
			                    	 <p class="form-control-static" id="hitCount"></p>
<!-- 			                        <input type="text" id="hitCount"> -->
			                    </div>
			                </div>
			                
			                <div class="form-group">
			                    <label class="col-lg-4 control-label">작성자</label>
			                    <div class="col-lg-6">
			                        <p class="form-control-static" id="regUserId"></p>
<!-- 			                        <input type="text" id="regUserId"> -->
			                    </div>
			                </div>
			
			                <div class="form-group">
			                    <label class="col-lg-4 control-label">내용</label>
			                    <div class="col-lg-6">
			                    	<div class="form-control-static" id="content"></div>
<!-- 									<textarea rows="" cols="" id="content" readonly="readonly"></textarea> -->
							    </div>
			                </div>
			
			                <div class="form-group">
			                    <div class="col-lg-9 col-lg-offset-5">
			                        <input type="button" id="noticeModify" value="수정" class="btn btn-success" onclick="moveInsertPage()">
			                        <input type="button" id="noticeDelete" value="삭제" class="btn btn-success" onclick="deleteNoticeBbs()">
			                        <input type="button" id="noticeList" value="목록" class="btn btn-success" onclick="moveListPage()">
			                    </div>
			                </div>
			            </form>
			            <table border="1"  width="130px"  align="center">
<!-- 			            <tr>
							<th>스텝아이디</th>
							<th>모델아이디</th>
							<th>스텝 이름</th>
							<th>스텝레벨</th>
							<th>왼쪽스텝아이디</th>
							<th>오른쪽스텝아이디</th>
			            </tr> -->
			            <c:forEach items="${approval}" var ="app" >
				            <tr>
<%-- 				            	<td>${app.stepId}</td>
				            	<td>${app.modeLid}</td>
				            	<td>${app.stepLevel}</td>
				            	<td>${app.leftStepId}</td>
				            	<td>${app.rightStepId}</td> --%>
				            	<td >${app.stepName}<input type="button" id="" value="승인하기" class="btn btn-success" onclick="()"></td>
				            </tr>
			            </c:forEach>
			            </table >
                 			<%-- <div class="form-group">
			                    <label class="col-lg-4 control-label">승인</label>
			                    <div class="col-lg-6">
            				            <select name="approval"  id="approval" >
											<c:forEach items="${approval}" var="applist" varStatus="status" >
												<option value="${applist.stepId}">${applist.stepName}</option>
											</c:forEach>
			                        	</select>
<!-- 			                        <input type="text" id="regDatetime"> -->
			                    </div>
			                </div>     --%>
					</div>
		    	</div>
		    </div>
		</div>
 
	
</body>
</html>