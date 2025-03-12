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

		<!-- begin #content -->
		<div id="content" class="content">


			<!-- begin header -->
			<div class="page_header mb30">
				<h1>FAQ 등록</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">사용문의</a><a href="#" class="on">FAQ</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
						<input type="hidden" id="faqNo" value="${faqNo}">
						<table class="tableH">
							<colgroup>
								 <col width="140px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th>제목</th>
									<td><input maxlength="30" type="text" class="w100" name="title" id="title"></td>
								</tr>
								<tr>
									<th>분류</th>
									<td>
										<div class="selectBox">
											<label class="selectText" for="faqType">일반사항</label>
											<select class="search-sel width-150" name="faqType" id="faqType">
											<c:forEach items="${code}" var="codelist" varStatus="status" >
													<option value="${codelist.codeId}">${codelist.codeName}</option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th>답변</th>
									<td>
										<textarea class="w100 height-300" id="_content"></textarea>
									</td>
								</tr>
							</tbody>
						</table>


				<div class="row tac m-t-60">
		 			<a type='button' class="rbton bton_blue" id="noticeModify" name="noticeModify" onclick="faqBbsInsert()"><i class="fa fa-upload"></i>   등록</a>
		 			<a type='button' class="rbton bton_dgrey"  id="noticeList" onclick="moveListPage();"><i class="fa fa-close"></i> 취소</a>
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
		})

	}


	function validationCheck(){
		var title = $("#title").val();
		var content = $("#_content").val();

		if(title==""){
			warningBox("제목을 입력해주세요");
			$("#title").focus();
			return false;
		}
		if(content==""){
			warningBox("내용을 입력해주세요.");
			$("#_content").focus();
			return false;
		}
		return true;
	}


	function faqBbsInsert() {

		if(!validationCheck()){
			return;
		}

		var jsonData = setJsonData();

		$.ajax({
			url : "${contextPath}/mng/bbs/faq/insert",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("등록되었습니다.", moveDetailPage);
				}else{
					errorBox("등록실패");
				}
			},
			error : function(request, status, error) {
				errorBox("code1:" + request.status + "\n" + "error:" + error);
			}
		})

	}

	function setJsonData(){

		var jsonData = {
				"faqNo" : $("#faqNo").val()
				, "faqType": $("#faqType > option:selected").val()
				, "title": $("#title").val()
				, "content":$("#_content").val()
				//, "regDatetime":$("#regDatetime").val()
				, "regUserId":"${userId}"
				, "modUserId":"${userId}"
				, "delFlag":""
				};
		return jsonData;
	}


	function setData(result){
		$("#title").val(result.title);
		$("#faqType").val(result.faqType);
		$("#regUserId").text(result.regUserId);
		$("#_content").val(result.content);
	}

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/bbs/faq/";
	}

	// 상세 페이지이동
	function moveDetailPage(){
		if($("#faqNo").val() != 0 ){
			location.href = "${contextPath}/mng/bbs/faq/view?faqNo="+$("#faqNo").val();
		}else{
			location.href = "${contextPath}/mng/bbs/faq/";
		}

 	}


	$(document).ready(function() {
		App.init();
		$("#faqType").siblings(".selectText").text($("#faqType").children('option:selected').text());
// 		Demo.init();
// 		PageDemo.init();

		if($("#faqNo").val() != 0 ){
			bbsDetail($("#faqNo").val());
		}

		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsFaq").addClass("active");

	});

</script>

</body>
</html>