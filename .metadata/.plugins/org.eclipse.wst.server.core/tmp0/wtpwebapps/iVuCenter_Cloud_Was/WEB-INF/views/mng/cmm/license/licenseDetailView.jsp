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
			<div class="page_header mb30">
				<h1>라이센스 관리</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책관리</a><a href="#" class="on">클라우드 관리</a>
					<input type="hidden" id="licenseId" value="${licenseDetailId}" />
				</div>
			</div>

			<div class="row pb50">
				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType01">
				<h2 class="titleBuType01 mb10 mt20">라이센스 등록정보 </h2>
				<table class="tableH">
					<colgroup>
						 <col width="*">
						 <col width="16%">
						 <col width="16%">
						 <col width="16%">
						 <col width="16%">
						 <col width="16%">
					</colgroup>
					<tr>
						<th>가상서버</th>
						<td colspan="5">
						${licenseInfo.hostname}
						</td>
					</tr>
					<tr>
						<th>등록자</th>
						<td colspan="5">
						${licenseInfo.userName}
						</td>
					</tr>
					<tr>
						<th>등록일</th>
						<td colspan="5">
						${licenseInfo.licenseDetailRegdate}
						</td>
					</tr>
				</table>
			</div>
			
			<div class="row tac m-t-60">
				<a type='button' id="noticeDelete" class="rbton bton_orange" onclick="deletelicenseInfo()"><i class="fa fa-trash"></i> 삭제</a>
				<a type='button' id="noticeModify" class="rbton bton_blue" onclick="moveFixPage('${licenseDetailId}')"><i class="fa fa-pencil"></i> 수정</a>
				<a type='button' id="noticeList" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
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
	function moveFixPage(licenseId){
		location.href = "${contextPath}/mng/cmm/license/detailWrite?licenseId="+${licenseInfo.licenseId}+"&licenseDetailId="+${licenseDetailId};
	}
	function moveListPage(){
		location.href = "${contextPath}/mng/cmm/license/view?licenseId="+${licenseInfo.licenseId};
	}

	$(document).ready(function() {
		App.init();
		$("#operation").addClass("active");
		$("#ossLicense").addClass("active");

	});

	function deletelicenseInfo(){
		confirmBox("삭제하시겠습니까?",deletelicense);
	}

	function deletelicense(){

		var licenseId = $("#licenseId").val();

		$.ajax({
			url : "${contextPath}/mng/cmm/license/detailDelete",
			dataType : "JSON",
			type : "POST",
			data : {
				"licenseDetailId" : ${licenseDetailId}
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
	
</script>
</body>
</html>