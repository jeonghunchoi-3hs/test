<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<c:import url="/WEB-INF/views/mng/include/import.jsp"
	charEncoding="UTF-8"></c:import>
<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container"
		class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">

		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp"
			charEncoding="UTF-8"></c:import>
		<!-- end #header -->

		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp"
			charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->

		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>프로젝트 쿼터 관리</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#"
						class="on">자원배분 정책</a>
				</div>
			</div>
			<!-- end header -->
			<!-- begin page-body -->
			<div class="row">

				<!-- search begin -->
				<div class="page_searchBox">
					<div class="searchArea">
						<div class="selectBox">
							<label class="selectText" for="searchKind">전체</label> <select
								class="search-sel width-150" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="project_alias">프로젝트명</option>
								<option value="project_name">프로젝트ID</option>
							</select>
						</div>

						<input type="text" placeholder="검색어를 입력하세요" id="keyword"
							onkeypress="if(event.keyCode==13)gridList();"
							class="width-600 ml5">
						<button class="bton-s bton_blue" onclick="gridList()">
							<i class="fa fa-search"></i> 검색
						</button>

					</div>
				</div>
				<!-- search end -->
				<!-- 테이블시작 -->

				<!-- 상단 버튼  -->
				<div class="tar mb5">
					<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i
						class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a> <a
						type="button" class="bton-s bton_blue"
						onclick="QuotaSynchronize();"><i class="fa fa-refresh"></i><span>
							동기화</span></a>
				</div>
				<!-- //상단 버튼  -->
				<!-- 그리드 영역 -->

				<table id="table-list" class="tableWrap">
					<colgroup>
						<col width="140px">
						<col width="150px">
						<col width="140px">
						<col width="140px">
						<col width="*">
						<col width="120px">
						<col width="120px">
						<col width="120px">
						<col width="100px">
						<col width="80px">
					</colgroup>
					<thead>
						<tr>
							<th>본부</th>
							<th>처(실)</th>
							<th>부서</th>
							<th>프로젝트 ID</th>
							<th>프로젝트명</th>
							<th>가상서버 (EA)</th>
							<th>vCPU (Core)</th>
							<th>MEMORY (GB)</th>
							<th>볼륨 (EA)</th>
							<th>상세</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>


				<!-- 테이블 끝 -->

			</div>
			<!-- end page-body -->

			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp"
				charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->

	<c:import url="/WEB-INF/views/mng/include/script.jsp"
		charEncoding="UTF-8"></c:import>
	<script type="text/javascript">
		function gridList() {
			$("#table-list")
					.dataTable(
							{
								"processing" : true,
								"autoWidth" : false,
								"serverSide" : true,
								"ordering" : false,
								"destroy" : true,
								"ajax" : {
									"url" : "${contextPath}/mng/project/quota/list",
									"type" : "GET",
									"data" : function(d) {
										d.searchKind = $(
												"#searchKind option:selected")
												.val();
										d.keyword = $("#keyword").val();
										d.customerId = "";
									}
								},
								"columns" : [
										{
											"data" : "deptName"
										},
										{
											"data" : "deptName"
										},
										{
											"data" : "deptName"
										},
										{
											"data" : "projectName2",
											"class" : "tal name"
										},
										{
											"data" : "projectAlias",
											"class" : "tal"
										}

										,
										{
											"data" : "vmTotal",
											"render" : function(data, type,
													full, meta) {
												return addcomma(data);
											}
										},
										{
											"data" : "vcpuTotal",
											"render" : function(data, type,
													full, meta) {
												return addcomma(data);
											}
										},
										{
											"data" : "memTotal",
											"render" : function(data, type,
													full, meta) {
												return addcomma(data);
											}
										},
										{
											"data" : "diskTotal",
											"render" : function(data, type,
													full, meta) {
												return addcomma(data);
											}
										}, {
											"width" : "65px"
										} ],
								"columnDefs" : [
										{
											"defaultContent" : "",
											targets : "_all"
										},
										{
											"targets" : [ 0 ],
											"render" : function(data, type,
													full) {
												return full.deptName2
														.split("/")[1];
											}
										},
										{
											"targets" : [ 1 ],
											"render" : function(data, type,
													full) {
												return full.deptName2
														.split("/")[2];
											}
										},
										{
											"targets" : [ 2 ],
											"render" : function(data, type,
													full) {
												return full.deptName2
														.split("/")[3];
											}
										},
										{
											"targets" : [ 9 ],
											"render" : function(data, type,
													full) {
												return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='movePageDetail(\""
														+ full.projectBoxId
														+ "\",\""
														+ full.projectName2
														+ "\",\""
														+ full.reqProjectSeq
														+ "\")'><i class='fa fa-search'></i> </a>";
											}
										} ],
								"language" : {
									"zeroRecords" : "<p align='center'>검색결과가 없습니다.</p>",
									"processing" : "<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
								},
								"sDom" : '<"top">rt<"bottom"ip>'
							});
			//tblColorSet();
		}

		/*	function tblColorSet() {
		 $('.gridType01 .tableWrap table thead th').each(function(index, item){
		 $(item).addClass('th' + index);
		 });
		 }  */

		function movePageDetail(projectBoxId, projectName, reqProjectSeq) {

			var params = "?projectBoxId=" + projectBoxId;
			params += "&projectName=" + projectName;
			params += "&reqProjectSeq=" + reqProjectSeq;

			location.href = "${contextPath}/mng/project/quota/cloudView"
					+ encodeURI(params);
		}

		function moveInsertPage() {
			location.href = "${contextPath}/mng/project/quota/write";
		}

		function excelDown() {
			var params = "searchKind=" + $("#searchKind option:selected").val();
			params += "&keyword=" + $("#keyword").val();
			location.href = "${contextPath}/mng/project/quota/mngProjectQuotaListExcel?"
					+ encodeURI(params);
		}

		function QuotaSynchronize() {
			alertBox("처리중 입니다.<br>잠시만 기다려 주십시오.", waiting);
			$.ajax({
				url : "${contextPath}/mng/project/quota/QuotaSynchronize",
				dataType : "JSON",
				type : "POST",
				success : function(data) {
					var result = data;
					if (result == "1") {
						alertBox("동기화가 완료되었습니다.", moveViewPage);
					}
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:"
							+ error);
				}
			})
		}
		function waiting() {
			alertBox("처리중 입니다.<br>잠시만 기다려 주십시오.", waiting);
		}
		function moveViewPage() {
			location.reload();
		}

		$(document).ready(function() {
			App.init();
			gridList();
			//tblColorSet();

			//메뉴활성화
			$("#project").addClass("active");
			$("#projectQuota").addClass("active");

			//tab 첫번째 메뉴 활성화
			$(".nav-pills>li:first-child").addClass("active");
		});
	</script>
</body>
</html>