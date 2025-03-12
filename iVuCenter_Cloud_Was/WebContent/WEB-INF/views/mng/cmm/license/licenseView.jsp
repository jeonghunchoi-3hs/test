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
					<input type="hidden" id="licenseId" value="${licenseId}" />
				</div>
			</div>

			<div class="row pb50">
				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a type="button" class="bton-s bton_blue" onclick="moveInsertPage();"><i class="fa fa-upload"></i><span> 등록</span></a>
					</div>
				<h2 class="titleBuType01 mb10 mt20">라이센스 정보 </h2>
				<table class="tableH">
					<colgroup>
						 <col width="15%">
						 <col width="*">
					</colgroup>
					<tr>
						<th>라이센스 타입</th>
						<td>
							${licenseInfo.licenseType}
						</td>
					</tr>
					<tr>
						<th>라이센스 명</th>

						<td>
							${licenseInfo.licenseName}
						</td>
					</tr>
					<tr>
						<th>사용가능 수량</th>
						<td>
							${licenseInfo.licenseAvail}
						</td>
					</tr>
				</table>
				<h2 class="titleBuType01 mb10 mt20">라이센스 등록정보 </h2>
				<div class="tableWrap">
						<table id="licenseList">
							<colgroup>
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">가상서버</th>
									<th scope="col">등록자</th>
									<th scope="col">등록일</th>
									<th scope="col">상세</th>
                               </tr>
							</thead>
						</table>
					</div>
				</div>

			</div>

			<div class="row tac m-t-60">
				<a type='button' id="noticeDelete" class="rbton bton_orange" onclick="deletelicenseInfo()"><i class="fa fa-trash"></i> 삭제</a>
				<a type='button' id="noticeModify" class="rbton bton_blue ml10" onclick="moveFixPage('${licenseId}')"><i class="fa fa-pencil"></i> 수정</a>
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
	function moveDetailPage(licenseId){
		location.href = "${contextPath}/mng/cmm/license/detailView?licenseDetailId="+licenseId;
	}
	function moveFixPage(licenseId){
		location.href = "${contextPath}/mng/cmm/license/write?licenseId="+licenseId;
	}
	function moveInsertPage(){
		location.href = "${contextPath}/mng/cmm/license/detailWrite?licenseId="+${licenseId};
	}

	function moveListPage(){
		location.href = "${contextPath}/mng/cmm/license/";
	}

	$(document).ready(function() {
        //조회추가
		gridList();
		App.init();
		//메뉴활성화
		$("#operation").addClass("active");
		$("#ossLicense").addClass("active");

	});
	function gridList() {
		 $("#licenseList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/license/detailList"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.licenseId = $('#licenseId').val();
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[
	        	{"data":"hostname", "class":"tac name"}
	        	, {"data":"userName", "class":"tac name"}
	        	, {"data":"licenseDetailRegdate", "class":"tac name"}

			],"columnDefs":[
				{"targets":[3], "render": function(data,type,full){
					return "<a href='javascript:void(0);' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.licenseDetailId+"\")'><i class='fa fa-search'></i></a>";
					}
				}
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
		return false;
	}
	function deletelicenseInfo(){
		confirmBox("삭제하시겠습니까?",deletelicense);
	}

	function deletelicense(){

		var licenseId = $("#licenseId").val();

		$.ajax({
			url : "${contextPath}/mng/cmm/license/delete",
			dataType : "JSON",
			type : "POST",
			data : {
				"licenseId" : licenseId
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