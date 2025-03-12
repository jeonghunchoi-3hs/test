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

	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in hide"><span class="spinner"></span></div>
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
				<div class="formType01">
					<div class="tblWrap clearfix">
						<input type="hidden" id="noticeNo" value="${noticeNo}">
						<table>
							<colgroup>
								 <col width="140px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>제목</strong></th>
									<td><input maxlength="30" type="text" style="width:100%" name="title" id="title"></td>
								</tr>
								<tr>
									<th scope="row"><strong>분류</strong></th>
									<td>
										<div class="selectBox" style="width:160px;">
											<label class="selectText" for="noticeType" id="noticeTypelabel"></label>
											<select class="search-sel" id="noticeType">
												<c:forEach items="${code}" var="codelist" varStatus="status" >
													<option value="${codelist.codeId}">${codelist.codeName}</option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>게시일</strong></th>
									<td>
										<input type="text" class="applyDate fontVdn" placeholder="날짜선택" id="dispSdate" name="dispSdate" style="width:120px;" />
								  		<span class="m5"> ~ </span>
										<input type="text" class="applyDate" placeholder="날짜선택" id="dispEdate" style="width: 120px"/>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>내용</strong></th>
									<td><div id="editorArea"></div></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="row tac m-t-60">
					<c:if test="${noticeNo eq 0}">
			 			<a type='button' class="rbton bton_blue" id="noticeModify" name="noticeModify" onclick="noticeBbsInsert()"><i class="fa fa-upload"></i> 등록</a>
			 			<a type='button' class="rbton bton_dgrey"  id="noticeList" onclick="moveListPage();"><i class="fa fa-close"></i> 취소</a>
					</c:if>
					<c:if test="${noticeNo ne 0}">
			 			<a type='button' class="rbton bton_blue" id="noticeModify" name="noticeModify" onclick="noticeBbsInsert()"><i class="fa fa-floppy-o"></i> 저장</a>
			 			<a type='button' class="rbton bton_dgrey"  id="noticeList" onclick="moveDetailPage();"><i class="fa fa-close"></i> 취소</a>
	 				</c:if>

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
<script type='text/javascript' src="<%=request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script>
<script type='text/javascript' src="<%=request.getContextPath()%>/resources/ckeditor/ckedtor_sample.js"></script>

<script type="text/javascript">

	// 상세정보 가져오기
	function bbsDetail(noticeNo) {
		$.ajax({
			url : "${contextPath}/mng/bbs/notice/detail",
			dataType : "JSON",
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
		})

	}


	function validationCheck(){
		var title = $("#title").val();
		var content = CKEDITOR.instances.editorArea.getData();
		var dispSdate = $("#dispSdate").val();
		var dispEdate = $("#dispEdate").val();

		if(title==""){
			alertBox("제목을 입력해주세요");
			$("#title").focus();
			return false;
		}
		if(dispSdate==""){
			alertBox("게시 시작일을 선택해주세요");
			return false;
		}
		if(dispEdate==""){
			alertBox("게시 종료일을 선택해주세요");
			return false;
		}
		if(content==""){
			alertBox("내용을 입력해주세요.");
			$("#_content").focus();
			return false;
		}

		return true;
	}

	// 등록/수정
	function noticeBbsInsert() {
		if(!validationCheck()){
			return;
		}

		var jsonData = setJsonData();

	 	$.ajax({
			url : "${contextPath}/mng/bbs/notice/insert",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(data==1){
					if($("#noticeNo").val() != 0 ){
						alertBox("저장되었습니다.", moveListPage);
					} else {
						alertBox("등록되었습니다.", moveListPage);
					}
				}else{
					if($("#noticeNo").val() != 0 ){
						alertBox3("저장 실패");
					} else {
						alertBox3("등록 실패");
					}
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}


	// json 데이터 세팅
	function setJsonData(){

		var jsonData = {
				"noticeNo" : $("#noticeNo").val()
				, "noticeType": $("#noticeType > option:selected").val()
				, "title": $("#title").val()
				//, "content": $("#_content").val()
				, "content": CKEDITOR.instances.editorArea.getData()
				, "dispSdate":$("#dispSdate").val().replace(/-/gi, "")
				, "dispEdate":$("#dispEdate").val().replace(/-/gi, "")
				, "regUserId":"${userId}"
				, "modUserId":"${userId}"
			};

		return jsonData;
	}

	// 상세정보 세팅
	function setData(result){


		$("#title").val(result.title);
		$("#noticeType").val(result.noticeType);
		$("#noticeTypelabel").text(result.codeName);
		$("#regDatetime").text(result.regDatetime);
		$("#regUserId").text(result.regUserId);
		$("#hitCount").text(result.hitCount);
		$("#editorArea").html(result.content);

		//var sDate = getDateChangeStr(result.dispSdate);
		//var eDate = getDateChangeStr(result.dispEdate);
		//$("#dispSdate").val(sDate);
		//$("#dispEdate").val(eDate);
		var sDate = result.dispSdate;
		var eDate = result.dispEdate;
		if (sDate.length == 8) {
			sDate = sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2);
		}
		if (eDate.length == 8) {
			eDate = eDate.substr(0, 4) + "-" + eDate.substr(4, 2) + "-" + eDate.substr(6, 2);
		}
		$("#dispSdate").val(sDate);
		$("#dispEdate").val(eDate);

	}

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/bbs/notice/";
	}

	// 상세 페이지이동
	function moveDetailPage(){
		location.href = "${contextPath}/mng/bbs/notice/view?noticeNo="+$("#noticeNo").val();
 	}

	// 달력
	function calendar(){

		var dayName = ['일','월','화','수','목','금','토'];
		var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

		$("#dispSdate").datepicker({
			showOn:"both",
			buttonImage:"/resources/mng/assets/img/ico_datepicker_cal.png",
			buttonImageOnly:true,
			buttonText : '',
			dateFormat : "yy-mm-dd",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});

		$("#dispEdate").datepicker({
			showOn:"both",
			buttonImage:"/resources/mng/assets/img/ico_datepicker_cal.png",
			buttonImageOnly:true,
			buttonText : '',
			dateFormat:"yy-mm-dd",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});

		$("img.ui-datepicker-trigger").attr("style", "vertical-align:top;");
	}


	$(document).ready(function() {
		App.init();
		calendar();
		ckEditorInit('editorArea');

		$("#noticeType").siblings(".selectText").text($("#noticeType").children('option:selected').text());
		if($("#noticeNo").val() != 0 ){
			bbsDetail($("#noticeNo").val());
		}

		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsNotice").addClass("active");
	});

</script>

</body>
</html>