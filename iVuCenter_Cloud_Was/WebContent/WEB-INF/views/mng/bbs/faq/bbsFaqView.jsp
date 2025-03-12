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
				<h1>FAQ 상세</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">사용문의</a><a href="#" class="on">FAQ</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<input type="hidden" id="faqNo" value="${faqNo}">
				<div class="client_DetailBg">
					<div class="client_DetailArea">
						<span class="bbsLabel cloud mb10" id="codeName"></span>
						<p class="company_Name2" name="projectAlias" id="title"></p>
						<p class="company_Info m-b-25">
							<span class="company_labelf">작성자 :</span><span class="company_cont" id="userName"></span>
							<span class="company_label">작성일시 :</span><span class="company_cont fontVdn" id="regDatetime2"></span>

						</p>

						<div class="networkDetailArea p-b-30">
							<div id="_content">
							</div>
						</div>
					</div>
				</div>

				<div class="row tac m-t-60">
					<a type='button' id="noticeDelete" class="rbton bton_orange" onclick="deleteNoticeBbs()"><i class="fa fa-trash"></i> 삭제</a>
					<a type='button' id="noticeModify" class="rbton bton_blue ml10" onclick="moveInsertPage()"><i class="fa fa-pencil"></i> 수정</a>
					<a type='button' id="noticeList" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
				</div>

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

	function bbsDetail(faqNo) {
		$.ajax({
			url : "${contextPath}/mng/bbs/faq/detail",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"faqNo" : faqNo
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

	function deleteNoticeBbs(){
		confirmBox("삭제하시겠습니까?",ajaxdeleteNoticeBbs);
	}

	function ajaxdeleteNoticeBbs(){
		var rowSeq = $("#faqNo").val();

		$.ajax({
			url : "${contextPath}/mng/bbs/faq/delete",
			dataType : "JSON",
			type : "POST",
			data : {
				"faqNo" : rowSeq
			},
			success : function(data) {
				var result = data.result;
				if(data==1){
					alertBox("삭제되었습니다.", moveListPage);
				}else{
					errorBox("failed!!");
				}
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}


	function setData(result){
		$("#title").text(result.title);
		$("#regDatetime2").text(result.regDatetime2);
		$("#regUserId").text(result.regUserId);
		//$("#hitCount").text(result.hitCount);
		$("#codeName").text(result.codeName);
		$("#faqType").val(result.faqType);


		var content1 = result.content;
		var content = content1.replace(/(?:\r\n|\r|\n)/g,"<br/>");

		$("#_content").html(content);



		$("#userName").text(result.userName)
	}

	// 목록 페이지이동
	function moveListPage(){
		//location.href = "/NHCloud/mng/bbs/notice/";
		location.href = "${contextPath}/mng/bbs/faq/";
	}
	// 등록/수정 페이지이동
	function moveInsertPage(){
		var faqNo = $("#faqNo").val();
		location.href = "${contextPath}/mng/bbs/faq/write?faqNo="+faqNo;
	}

	$(document).ready(function() {
		bbsDetail("${faqNo}");
		App.init();

		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsFaq").addClass("active");

	});

</script>
</body>
</html>