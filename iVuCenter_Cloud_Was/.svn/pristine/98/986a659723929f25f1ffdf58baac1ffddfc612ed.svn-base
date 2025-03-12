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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">

		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->

		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->

		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)-->
		<div id="content" class="content">
			<!-- begin header -->
			<div class="page_header mb30">
				<h1><span class="fontVdn">Q&A</span> 상세</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">고객센터</a><a href="#" class="on fontVdn">Q&A</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<div class="client_DetailBg">
					<div class="client_DetailArea">
						<input type="hidden" id="qnaNo" value="${qnaNo}">
						<input type="hidden" id="qnaRpyNo" value="">
						<input type="hidden" id="replyregUserId" value="">
						<input type="hidden" id="qnaWriteRegUserId" value="">



						<input type="hidden" id="replyregDatetime"  value="">
						<span class="bbsLabel mb10" id="codeName">일반공지</span>
						<p class="company_Name2" name="projectAlias" id="title"></p>
						<p class="company_Info m-b-25">
							<span class="company_labelf">작성자 :</span><span class="company_cont" id="userName"></span>
							<span class="company_label">작성일시 :</span><span class="company_cont fontVdn" id="regDatetime2"></span>
						</p>
						<div class="msgAreaWrap">
							<div class="msgArea p-t-30 m-b-10">
								<div id="_content" class="f16 fc11"></div>
							</div>
						</div>
						<div class="m-l-20 m-r-20 mb30" id="replyDiv" style="display: none;">
							<div class="answerArea">
								<span class="aStitle">답변</span>
								<div class="flr">
									<a type='button' class="bton-ss bton_blue" onclick="qnaReplyInsert();"><i class="fa fa-upload"></i> <span>  등록</span></a>
									<a type='button' class="bton-ss bton_dgrey"  onclick="toggleReplyDiv();"><span class="txt"><i class="fa fa-close"></i>  취소</span></a>
								</div>
								<textarea class="m-t-15" rows="5" placeholder="답변을 입력하세요" id="rpyContent"></textarea>
							</div>
						</div>
						<div  id="replyform" name="replyform" style="display:none">
							<div class="answerArea">
								<span class="aStitle">답변</span>
								<div class="flr">
									<a type='button' class="bton-ss bton_blue" onclick="moveReplyInsertPage();"><i class="fa fa-pencil"></i> 수정</a>
									<a type='button' class="bton-ss bton_orange"  onclick="deleteBbs('reply');"><i class="fa fa-trash"></i> 삭제</a>
								</div>
								<div class="f16 fc11 m-t-15" id="replycontent"></div>
							</div>
						</div>
						<div id="replyModiDiv" style="display: none;">
							<div class="answerArea">
								<span class="aStitle">답변</span>
								<div class="flr">
									<a type='button' class="bton-ss bton_blue" onclick="qnaReplyModiInsert();"><i class="fa fa-floppy-o"></i> 저장</a>
									<a type='button' class="bton-ss bton_dgrey"  onclick="toggleReplyModiDiv();"><i class="fa fa-close"></i>  취소</a>
								</div>
								<textarea class="m-t-15" rows="5" placeholder="답변을 입력하세요" id="rpyModiContent"></textarea>
							</div>
						</div>
					</div>
				</div>
				<div class="row tac m-t-60">
			        <a type='button' class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i>  목록</a>
					<a type='button' id="answerBtn" class="rbton bton_blue ml10" onclick="toggleReplyDiv()"><i class="fa fa-reply"></i>  답변</a>
				</div>



			</div>

            <!-- begin #footer -->
            <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">
	var qnaNo = "${qnaNo}";

	function bbsDetail() {
		var qnaNo = "${qnaNo}";
		$.ajax({
			url : "${contextPath}/mng/bbs/qna/detail",
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
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}

	function bbsReplyDetail() {
		var rowSeq = $("#qnaNo").val();
		$.ajax({
			url : "${contextPath}/mng/bbs/qna/detailReply",
			dataType : "JSON",
			type : "POST",
			data : {
				"parentQnaNo" : rowSeq
			},
			success : function(data) {
				replysetData(data);
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function deleteBbs(gubun){
		confirmBox2("삭제하시겠습니까?", ajaxDeleteBbs, gubun)
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
				url : "${contextPath}/mng/bbs/qna/delete",
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
						alertBox3("답글이 있는 경우 삭제할수 없습니다.");
					}

				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});

		location.reload();
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
		$("#regDatetime2").text(result.regDatetime2);
		$("#qnaWriteRegUserId").val(result.regUserId);
		$("#qnaType").val(result.qnaType);


		if(result.codeName=="가상서버"){
			$("#codeName").addClass("virServer");
		}else if(result.codeName=="부가자원"){
			$("#codeName").addClass("addPrdt");
		}else if(result.codeName=="서비스"){
			$("#codeName").addClass("service");
		}else if(result.codeName=="사용요금"){
			$("#codeName").addClass("billT");
		}else{
			$("#codeName").addClass("etc");
		}
		$("#codeName").text(result.codeName);


		var content1 = result.content;
	    var content = content1.replace(/(?:\r\n|\r|\n)/g,"<br/>");


		$("#_content").html(content);
		$("#userName").text(result.userName);

		if(result.secretFlag=="Y"){
			//alert(result.secretFlag);
			$("input:checkbox[name='secretFlag']").attr("checked",true);
		}
	}

	function replysetData(data){

		if(data!=undefined){
			$("#bbsReply").hide();
			$("#answerBtn").hide();
			$("#replyform").show();



			rpyContent1 = data.content;
			rpyContent = rpyContent1.replace(/(?:\r\n|\r|\n)/g,"<br/>");

			$("#replyform #replycontent").html(rpyContent);

			$("#replyregDatetime").val(data.regDatetime);
			$("#replyregUserId").val(data.userName);
			$("#qnaRpyNo").val(data.qnaNo);

			var replyId = $("#replyregUserId").text();
			var userId = "${userName}";

			if(userId==replyId){
				$("#replyform #replyBtn").show();
			}else{
				$("#replyform #replyBtn").hide();
			}
		}
	}

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/bbs/qna/";
	}
	// 등록/수정 페이지이동
	function moveInsertPage(){
		var qnaNo = $("#qnaNo").val();
		location.href = "${contextPath}/mng/bbs/qna/write?qnaNo="+qnaNo;
	}
	// Reply 수정 로드
	function moveReplyInsertPage(){
		//var qnaNo = $("#qnaNo").val();
		//location.href = "${contextPath}/mng/bbs/qna/replywrite?parentQnaNo="+qnaNo;
		$("#rpyModiContent").val($("#replycontent").text());
		$("#replyform").toggle();
		$("#replyModiDiv").toggle();
	}

	//--> 답글 전용 start
	function toggleReplyDiv(){
		$("#replyDiv").toggle();
		$("#replyDiv #rpyContent").val("");
		$("#answerBtn").toggle();
		$("#rpyContent").focus();
	}
	function toggleReplyModiDiv(){
		$("#replyModiDiv").toggle();
		$("#replyform").toggle();
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
			url : "${contextPath}/mng/bbs/qna/insertReply",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(data==1){
					alertBox("등록되었습니다.", moveDetailPage);
				}else{
					alertBox3("등록 실패");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		})
	}


	function setJsonData(){
		var jsonData = {
				"parentQnaNo" : $("#qnaNo").val()
				, "content": $("#rpyContent").val()
				, "regUserId": "${userId}"
				, "qnaWriteRegUserId": $("#qnaWriteRegUserId").val()

				};
		return jsonData;
	}


	// 상세 페이지이동
	function moveDetailPage(){
		if($("#qnaNo").val() != 0 ){
			location.href = "${contextPath}/mng/bbs/qna/view?qnaNo="+$("#qnaNo").val();
		}else{
			location.href = "${contextPath}/mng/bbs/qna/";
		}
 	}

	function qnaReplyModiInsert() {

		var jsonData = setJsonData2();

		 $.ajax({
			url : "${contextPath}/mng/bbs/qna/insert",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(data==1){
					alertBox("저장되었습니다.", moveDetailPage);
				}else{
					alertBox3("저장실패.");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		})
	}

	function setJsonData2(){
		var jsonData = {
				"qnaNo" : $("#qnaRpyNo").val()
				, "content":$("#rpyModiContent").val()
				};
		return jsonData;
	}

	$(document).ready(function() {
		$("#faqType").siblings(".selectText").text($("#faqType").children('option:selected').text());
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