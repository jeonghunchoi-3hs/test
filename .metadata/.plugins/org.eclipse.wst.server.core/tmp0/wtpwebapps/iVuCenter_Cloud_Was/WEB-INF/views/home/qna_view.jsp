<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />

<c:import url="${contextPath}/WEB-INF/views/home/include/home_import.jsp" charEncoding="UTF-8"></c:import>

<title>KEPCO Cloud Service Platform</title>
</head>
<body>
	<div id="container">

	<!-- top menu start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_top.jsp" charEncoding="UTF-8"></c:import>	
	<!-- top menu end -->
		 
	 <div class="cimg"></div>
	  <div class="sub mb30">
	    <h3 class="subtitle"><i class="fa fa-cloud f18"></i> Q&A </h3>
		 

              	
              	<!-- begin panel -->
				<!-- begin normal input table---------->
				<div class="tableC">
					<input type="hidden" id="qnaNo" value="${fn:escapeXml(qnaNo)}">
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
				<button type="button" class="btn btn-grey" onclick="moveListPage()"><i class="fa fa-reorder"></i> 목록</button>
			</div>
			<!-- end button -->
			<div class="clear"></div>
			
			<!-- begin normal input table---------->
			<!-- reply insert start-->
			<div class="tableC mb20 panel-collapse collapse mt20" id="replyDiv" style="display: none;" >
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
		
	  
	 
	 
	<div class="clear"></div>
	
	<!-- footer start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
	<!-- footer end -->
	
	
	
	</div>
	

	
</body>

<script type="text/javascript">
	var qnaNo = "${fn:escapeXml(qnaNo)}";
	
	//qna 조회
	function bbsDetail() {
		var qnaNo = "${fn:escapeXml(qnaNo)}";
		$.ajax({
			url : "${contextPath}/homepage/qnaDetail",
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
	
	// 답글조회
	function bbsReplyDetail() {
		var rowSeq = $("#qnaNo").val();
		$.ajax({
			url : "${contextPath}/homepage/detailReply",
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
	
	// qna 글 세팅
	function setData(result){
		$("#title").text(result.title);
		$("#regDatetime").text(result.regDatetime2);
		$("#regUserId").text(result.regUserId);
		$("#qnaType").val(result.qnaType);
		$("#codeName").text(result.codeName);
		$("#_content").text(result.content);
		$("#userName").text(result.userName);
		
		if(result.secretFlag=="Y"){
			//alert(result.secretFlag);
			$("input:checkbox[name='secretFlag']").attr("checked",true);
		}
	}
	
	// 답글 세팅
	function replysetData(data){
		if(data!=undefined){
			$("#bbsReply").hide();
			$("#replyform").show();
			
			$("#replyform #replycontent").text(data.content);
			$("#replyregDatetime").text(data.regDatetime2);
			$("#replyregUserId").text(data.userName);
			$("#qnaRpyNo").val(data.qnaNo);
		}	
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/homepage/qna/";
	}
		
	$(document).ready(function() {
		bbsDetail();
		bbsReplyDetail();
		App.init();
			
	});
	
</script>
</html>