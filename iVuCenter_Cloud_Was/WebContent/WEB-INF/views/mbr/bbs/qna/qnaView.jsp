<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
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
<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
		
			<!-- begin header -->
			<h1 class="page-header"><img src="<%=request.getContextPath()%>/resources/images/title_icon/Q&A.png"/>  Q&A  <span class="root"> <img src="/resources/assets/img/root_icon.png"/> 콘솔 > 사용문의 > Q&A  </span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
	         	<!-- begin col-12 -->
	         	<div class="col-md-12">
	                	
	                	<!-- begin panel -->
							<!-- begin normal input table---------->
							<div class="tableC">
								<input type="hidden" id="qnaNo" value="${qnaNo}">
								<table>
									<colgroup>
										<col width="100px">
										<col width="200px">
										<col width="100px">
										<col width="200px">
										<col width="100px">
										<col width="278px">
									</colgroup>
									<tbody>
										<tr>
											<td class="left-b">제목</td>
											<td colspan="5"  id="title">
											</td>
										</tr>
										<tr>
											<td class="left-b">유형</td>
											<td id="codeName"></td>
											<td class="left-b">작성자</td>
											<td id="userName"></td>
										  	<td class="left-b">작성일시</td>
										  	<td id="regDatetime"></td>
										</tr>
										<tr>
											<td class="left-b">내용</td>
											<td colspan="5" id="_content" style="white-space: pre-wrap; word-break:break-all; vertical-align: top; width:278px !important; " class="height-200">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- end normal input table---------->
						<!-- end panel -->
						
						<!-- begin button-->
						<div class="col-md-12 tac mt20">
							<c:choose>
								<c:when test="${userId eq regUserId}">
<!-- 									<input type="button" value="수정" class="btn btn-primary" onclick="moveInsertPage()"> -->
									<!-- <button type="button" class="btn btn-primary" onclick="moveInsertPage()"><i class="fa fa-edit"></i> 수정</button> -->
<!-- 							        <input type="button" value="삭제" class="btn btn-danger" onclick="deleteBbs('qna')"> -->
							        <!-- <button type="button" class="btn btn-danger" onclick="deleteBbs('qna')"><i class="fa fa-trash"></i> 삭제</button> -->
<!-- 							        <input type="button" value="목록" class="btn btn-grey" onclick="moveListPage()"> -->
							         <!-- <button type="button" class="btn btn-grey" onclick="moveListPage()"><i class="fa fa-reorder"></i> 목록</button> -->
<!-- 							         <input type="button" id="bbsReply" value="답글" class="btn btn-lime" onclick="toggleReplyDiv();"> -->
<!-- 							         <button type="button" class="btn btn-lime"  id="bbsReply" onclick="toggleReplyDiv();"><i class="fa fa-reply"></i> 답글</button> -->

									<a href="#"><img src="/resources/assets/img/btn_edit.png" onclick="moveInsertPage()"/></a>
									<a href="#"><img src="/resources/assets/img/btn_trash.png" onclick="deleteBbs('qna')" class="ml10"/></a>
									<a href="#"><img src="/resources/assets/img/btn_list.png" onclick="moveListPage()" class="ml10"/></a>
									
									
								</c:when>
								<c:when test="${userId ne regUserId}">
<!-- 							        <input type="button" value="목록" class="btn btn-grey" onclick="moveListPage()"> -->
							        <button type="button" class="btn btn-grey" onclick="moveListPage()"><i class="fa fa-reorder"></i> 목록</button>
							        
<!-- 							         <input type="button" id="bbsReply" value="답글" class="btn btn-lime" onclick="toggleReplyDiv();"> -->
							           <button type="button" class="btn btn-lime"  id="bbsReply" onclick="toggleReplyDiv();"><i class="fa fa-reply"></i> 답글</button>
								</c:when>
							</c:choose>
						</div>
						<!-- end button -->
						<div class="clear"></div>
						
						<!-- begin normal input table---------->
						<!-- reply insert start-->
						<div class="tableC2 mb20 panel-collapse collapse mt20" id="replyDiv" style="display: none;" >
							<table>
								<colgroup>
									<col width="100px;">
									<col width="878px">
								</colgroup>
								<tbody>
									<tr>
										<td class="left-b"><span style="color:red;">* </span>답글입력</td>
										<td><textarea class="form-control" rows="5" placeholder="답변내용을 입력하세요" id="rpyContent"></textarea>
										</td>
									</tr>
								</tbody>
							</table>
						
							<div class="col-md-12 tac mt20" id="insertBtn">
<!-- 								<input type="button" value="저장" class="btn btn-primary" onclick="qnaReplyInsert();"> -->
								<button type="button" class="btn btn-primary" onclick="qnaReplyInsert();"><i class="fa fa-floppy-o"></i> 저장</button>
<!-- 					        	<input type="button" value="취소" class="btn btn-grey" onclick="toggleReplyDiv();"> -->
					        	<button type="button" class="btn btn-grey" onclick="toggleReplyDiv();"><i class="fa fa-times"></i> 취소</button>
		       				</div>
		       				
						</div>
						<!-- reply insert end-->
						<!-- end normal input table---------->
						
						
						<!-- begin normal input table---------->
						<!-- reply detail start-->
						<div class="tableC2 mt20"  id="replyform" name="replyform" style="display:none">
							<input type="hidden" id="qnaRpyNo" value="">
							<table>
								<colgroup>
										<col width="100px">
										<col width="500px">
										<col width="100px">
										<col width="278px">
								</colgroup>
								<tbody>
								<tr><td class="left-b">작성자</td><td id="replyregUserId"> </td><td class="left-b">작성일시</td><td id="replyregDatetime"> </td></tr>
								<tr><td class="left-b">답변내용</td><td id="replycontent" colspan="3" style="width:878px;"></td></tr>								
								</tbody>
							</table>
							<!-- 
							<div class="col-md-12 tac mt20" id="replyBtn">
								<button type="button" class="btn btn-primary id="noticeModify"  onclick="moveReplyInsertPage()"><i class="fa fa-edit"></i> 수정</button>
					       		<button type="button" class="btn btn-danger" id="noticeDelete"  onclick="deleteBbs('reply');"><i class="fa fa-trash"></i> 삭제</button>
		       				</div>
		       				 -->
						</div>
						<!-- reply detail end-->
						<!-- end normal input table---------->
						
						
					</div>
                   <!-- end col-12 -->
	
			</div>
			<!-- end page-body -->
		
		
            <!-- begin #footer -->
               <c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>


<script type="text/javascript">
	var qnaNo = "${qnaNo}";
	
	function bbsDetail() {
		var qnaNo = "${qnaNo}";
		$.ajax({
			url : "${contextPath}/mbr/bbs/qna/detail",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"qnaNo" : qnaNo
			},
			success : function(data) {
				var result = data;
				setData(result);
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}
	
	function bbsReplyDetail() {
		var rowSeq = $("#qnaNo").val();
		$.ajax({
			url : "${contextPath}/mbr/bbs/qna/detailReply",
			dataType : "JSON",
			type : "POST",
			data : {
				"parentQnaNo" : rowSeq
			},
			success : function(data) {				
				replysetData(data);
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	//글삭제
	function deleteBbs(gubun){
		confirmBox2("삭제를 하시겠습니까?", ajaxDeleteBbs, gubun)
	}
	
	function ajaxDeleteBbs(gubun){
		var rowSeq="";
		var qnaNo = $("#qnaNo").val();
		
		//삭제 대상 구분
		if(gubun=="qna"){
			rowSeq = $("#qnaNo").val();
		}else if(gubun=="reply"){
			rowSeq = $("#qnaRpyNo").val();
		}
			$.ajax({
				url : "${contextPath}/mbr/bbs/qna/delete",
				dataType : "JSON",
				type : "POST",
				data : {
					"qnaNo" : rowSeq
				},
				success : function(data) {
					//var result = data.result;
					if(data==1){
						alertBox("삭제되었습니다.", actMovePage, gubun);
					}else{
						errorBox("답글이 있는 경우 삭제할수 없습니다.");
					}
				},
				error : function(request, status, error) {
					errorBox("code:" + request.status + "\n" + "error:" + error);
				}
			});
	}
	
	function actMovePage(gubun){
		if(gubun=="qna"){
			moveListPage();
		}else if(gubun=="reply"){
			moveDetailPage();
		}
	}
	
	function setData(result){
		$("#title").text(result.title);
		$("#regDatetime").text(result.regDatetime);
		$("#regUserId").text(result.regUserId);
		$("#userName").text(result.userName);
		$("#qnaType").val(result.qnaType);
		$("#codeName").text(result.codeName);
		$("#_content").text(result.content);
		if(result.secretFlag=="Y"){
			//alert(result.secretFlag);
			$("input:checkbox[name='secretFlag']").attr("checked",true);
		}
	}
	
	function replysetData(data){
		
		if(data!=undefined){
			$("#bbsReply").hide();
			$("#replyform").show();
			
			$("#replyform #replycontent").text(data.content);
			
			$("#replyregDatetime").text(data.regDatetime);
			$("#replyregUserId").text(data.userName);
			$("#qnaRpyNo").val(data.qnaNo);
			
			var replyId = $("#replyregUserId").text();
			var userId = "${userId}";
			if(userId==replyId){
				$("#replyform #replyBtn").show();
			}else{
				$("#replyform #replyBtn").hide();
			}
		}	
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mbr/bbs/qna/";
	}
	// 등록/수정 페이지이동
	function moveInsertPage(){
		var qnaNo = $("#qnaNo").val();
		location.href = "${contextPath}/mbr/bbs/qna/write?qnaNo="+qnaNo;
	}
	// Reply 수정 페이지이동
	function moveReplyInsertPage(){
		var qnaNo = $("#qnaNo").val();
		location.href = "${contextPath}/mbr/bbs/qna/replywrite?qnaNo="+qnaNo;
	}

	
	//--> 답글 전용 start
	function toggleReplyDiv(){
		$("#replyDiv").toggle();
		$("#replyDiv #rpyContent").val("");
	}
	
	function repValidationCheck(){
		var content = $("#rpyContent").val();
		if(content==""){
			warningBox("내용을 입력해주세요");
			$("#rpyContent").focus();
			return false;
		}
		return true;
	}
	
	function qnaReplyInsert() {
		
		if(!repValidationCheck()){
			return;
		}
		
		var jsonData = setJsonData();
		$.ajax({
			url : "${contextPath}/mbr/bbs/qna/insertReply",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(data==1){
					alertBox("등록되었습니다.", moveDetailPage);
				}else{
					errorBox("등록 실패");
				}
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		})
	}
	
	function qnaReplyUpdate() {
		var jsonData = setJsonData();
		$.ajax({
			url : "${contextPath}/mbr/bbs/qna/update",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(data==1){
					alertBox("등록되었습니다.", moveDetailPage);
				}else{
					errorBox("등록 실패");
				}
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		})

	}
	
	function setJsonData(){
		var jsonData = {
				"parentQnaNo" : $("#qnaNo").val()
// 				, "qnaType": $("#qnaType > option:selected").val()             
				, "content":$("#rpyContent").val()
				, "regUserId": "${userId}"
				};
		return jsonData;
	}
	
	// 상세 페이지이동
	function moveDetailPage(){
		if($("#qnaNo").val() != 0 ){
			location.href = "${contextPath}/mbr/bbs/qna/view?qnaNo="+$("#qnaNo").val();
		}else{
			location.href = "${contextPath}/mbr/bbs/qna/";
		}
		
 	}
	
	$(document).ready(function() {
		bbsDetail();
		bbsReplyDetail();
		App.init();
		
		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsQna").addClass("active");
		
	});
	
</script>

</body>
</html>