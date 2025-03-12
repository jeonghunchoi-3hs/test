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
	<div id="page-loader" class="page-loader fade in"><span class="spinner"></span></div>
	<!-- end #page-loader -->

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
				<h1>공지사항</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">사용문의</a><a href="#" class="on">공지사항</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<div class="client_DetailBg">
					<div class="client_DetailArea">
						<input type="hidden" id="noticeNo" value="${noticeNo}">
						<span class="bbsLabel mb10" id="codeName"></span>
						<p class="company_Name2" name="projectAlias" id="title"></p>
						<p class="company_Info m-b-25">
							<span class="company_labelf">작성자 :</span><span class="company_cont" id="userName"></span>
							<span class="company_label">작성일시 :</span><span class="company_cont fontVdn" id="regDatetime2"></span>
							<span class="company_label">조회수 :</span><span class="company_cont fontVdn" id="hitCount"></span>
							<span class="flr m-r-30"><span class="company_labelf">게시일 :</span><span class="company_cont fontVdn" id="dispDate"></span></span>
						</p>

						<div class="msgAreaWrap">
							<div class="msgArea p-t-30 m-b-10">
								<div id="_content"></div>
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
                   <!-- end col-12 -->

			</div>
			<!-- end page-body -->

            <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>

		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>


<script type="text/javascript">

	function bbsDetail(noticeNo) {
		$.ajax({
			url : "${contextPath}/mng/bbs/notice/detail",
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
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}
	/*
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
	 */

	function deleteNoticeBbs(){
		 confirmBox("삭제하시겠습니까?", ajaxDeleteNoticeBbs);
	}

	function ajaxDeleteNoticeBbs(){

		var rowSeq = $("#noticeNo").val();

		$.ajax({
			url : "${contextPath}/mng/bbs/notice/delete",
			dataType : "JSON",
			type : "POST",
			data : {
				"noticeNo" : rowSeq
			},
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("삭제되었습니다.", moveListPage);
				}else{
					alertBox3("삭제실패");
				}

			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}


	function setData(result){
		$("#title").text(result.title);

		if(result.codeName=="가상머신"){
			$("#codeName").addClass("virServer");
		}else{
			$("#codeName").addClass("notice");
		}

		$("#codeName").text(result.codeName);

		$("#regUserId").text(result.regUserId);
		$("#regDatetime2").text(result.regDatetime2);
		$("#hitCount").text(addcomma(result.hitCount));
		$("#regUserId").text(result.regUserId);
		$("#codeName").text(result.codeName);
		$("#_content").html(result.content);
		$("#userName").text(result.userName);


		var sDate = result.dispSdate;
		var eDate = result.dispEdate;
		if (sDate.length == 8) {
			sDate = sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2);
		}
		if (eDate.length == 8) {
			eDate = eDate.substr(0, 4) + "-" + eDate.substr(4, 2) + "-" + eDate.substr(6, 2);
		}
		$("#dispDate").text(sDate + ' ~ ' + eDate);

	}

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/bbs/notice/";
	}

	// 등록/수정 페이지이동
	function moveInsertPage(){
		var noticeNo = $("#noticeNo").val();
		location.href = "${contextPath}/mng/bbs/notice/write?noticeNo="+noticeNo;
	}

	$(document).ready(function() {
		App.init();
		bbsDetail("${noticeNo}");

		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsNotice").addClass("active");

	});

</script>

</body>
</html>