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
				<h1>라이센스 등록</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책관리</a><a href="#" class="on">라이센스관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">


						<input type="hidden" id="licenseId" value="${licenseInfo.licenseId}">
						<table class="tableH">
							<colgroup>
								 <col width="140px">
								 <col width="*">
								 <col width="140px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
								    <th scope="row">라이센스종류</th>
									<td colspan="3"><input maxlength="60" type="text" name="licenseType" id="licenseType" value="${licenseInfo.licenseType}" class="w100"></td>
								</tr>
								<tr>
 								    <th scope="row">라이센스명</th>
									<td><input maxlength="60" type="text" name="licenseName" id="licenseName" value="${licenseInfo.licenseName}" class="w100"></td>
									<th scope="row">등록가능 수량</th>
									<td><input maxlength="60" type="text" name="licenseAvail" id="licenseAvail" value="${licenseInfo.licenseAvail}" class="w100"></td>
								</tr>
							</tbody>
						</table>

				<div class="row tac mt60">
				    <c:if test="${licenseInfo.licenseId eq null}">
		 			<a type='button' class="rbton bton_blue" id="noticeModify" name="noticeModify" onclick="ossLicenseInsert()"><i class="fa fa-upload"></i>   등록</a>
                    </c:if>
		 			<c:if test="${licenseInfo.licenseId ne null}">
		 			<a type='button' id="noticeModify" class="rbton bton_blue" onclick="licenseUpdate()"><i class="fa fa-pencil"></i> 수정</a>
		 			</c:if>
		 			<a type='button' class="rbton bton_dgrey"  id="noticeList" onclick="moveListPage();"><i class="fa fa-close"></i> 취소</a>
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
	function validationCheck(){
		var licenseType = $("#licenseType").val();
		var licenseName = $("#licenseName").val();
		var licenseAvail = $("#licenseAvail").val();
		if(licenseType==""){
			warningBox("라이센스 종류를 입력해주세요");
			$("#licenseType").focus();
			return false;
		}
		if(licenseName==""){
			warningBox("라이센스명을 입력해주세요");
			$("#licenseName").focus();
			return false;
		}
		if(licenseAvail==""){
			warningBox("등록가능 수량을 입력해주세요");
			$("#licenseAvail").focus();
			return false;
		}
		return true;
	}


	function ossLicenseInsert() {

		if(!validationCheck()){
			return;
		}

		var jsonData = setJsonData();

		$.ajax({
			url : "${contextPath}/mng/cmm/license/insert",
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

	function licenseUpdate() {

		if(!validationCheck()){
			return;
		}

		var jsonData = setJsonData();

		$.ajax({
			url : "${contextPath}/mng/cmm/license/update",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("수정되었습니다.", moveDetailPage);
				}else{
					errorBox("수정실패");
				}
			},
			error : function(request, status, error) {
				errorBox("code1:" + request.status + "\n" + "error:" + error);
			}
		})

	}


	function setJsonData(){

		var jsonData = {

 				  "licenseType":$("#licenseType").val()
				, "licenseName":$("#licenseName").val()
				, "licenseAvail":$("#licenseAvail").val()
				, "licenseId":$("#licenseId").val()
				};
		console.log(jsonData);
		return jsonData;
	}


	function setData(result){

		$("#adminDomain").val(result.adminDomain);
		$("#adminProject").val(result.adminProject);
		$("#adminUsername").val(result.adminUsername);

	}

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/cmm/license/";
	}

	// 상세 페이지이동
	function moveDetailPage(){
			location.href = "${contextPath}/mng/cmm/license/";
 	}


	$(document).ready(function() {
		App.init();


		//메뉴활성화
		$("#operation").addClass("active");
		$("#ossLicense").addClass("active");

	});

</script>

</body>
</html>