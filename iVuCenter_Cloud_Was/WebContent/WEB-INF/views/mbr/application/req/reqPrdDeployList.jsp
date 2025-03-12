<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname" />
</sec:authorize>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container"
		class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->

		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->

		<!-- begin #content -->
		<div id="content" class="content">

			<p class="page_title">	배포현황(운영) <span class="root f14">Home
			<span class="arrow_ab">&#8227; </span>
				<a href="${wasPath}/mbr/main"> 콘솔</a>
			<span	class="arrow_ab"> &#8227; </span> 개발환경
			<span class="arrow_ab">	&#8227; </span>
			<b><a href="${wasPath}/mbr/application/req/">배포현황(운영)</a>
			</b>
				</span>
			</p>

			<!-- begin body row -->
			<div class="row p20 bgwh br10">
				<!-- search begin -->
				<div class="col-md-12 br5 p30 mb20 bgee">
					<div class="selectBoxAr">
						<label class="selectText" for="searchKind">전체</label>
						<select 	class="search-sel" id="searchKind">
							<option value="searchAll">전체</option>
							<option value="projectAlias">프로젝트명</option>
							<option value="projectName">프로젝트ID</option>
							<option value="envName">개발환경명</option>
							<option value="appName">어플리케이션명</option>
						</select>
					</div>
					<div class="search-box">
						<input type="text" class="search-text" placeholder="검색어를 입력하세요"	id="keyword" onkeypress="if(event.keyCode==13)gridList();" />
						<button type="button" class="btn_search2" onclick="gridList()">
							<span></span>
						</button>
					</div>
				</div>
				<!-- search end -->

				<table id="table-list-env" class="tableV">
					<colgroup>
						<col width="240px">
						<col width="140px">
						<col width="160px">
						<col width="*">
						<col width="160px">
						<col width="100px">
						<col width="140px">
						<col width="90px">
						<col width="80px">
					</colgroup>
					<thead>
						<tr>
							<th>프로젝트 명</th>
							<th>프로젝트 ID</th>
							<th>개발환경 명</th>
							<th>개발환경 경로</th>
							<th>어플리케이션명</th>
							<th>어플리케이션 버전</th>
							<th>실행시간</th>
							<th>최종상태</th>
							<th>상세</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>

				<div class="clear"></div>

			</div>
			<!-- end body row -->
			<!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->
		<!-- end #content -->
	</div>
	<!-- end page container -->

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

		function gridList() {

			$("#table-list-env").dataTable({
					"processing" : true,
					"autoWidth" : false,
					"serverSide" : true,
					"ordering" : false,
					"destroy" : true,
					"ajax" : {
						"url" : "${contextPath}/mbr/application/env/mbrPrdCicdPipelineList",
						"type" : "GET",
						"data" : function(d) {
							//	d.searchKind = $("#searchKind option:selected").val();
							d.searchKind = $("#searchKind").val();
							d.keyword = $("#keyword").val();
							d.customerId = "";
						}
					},
					"columns" : [
						  {	"data" : "projectAlias", "class" : "overflow-path"}
						, {	"data" : "projectName"}
						, {	"data" : "envName", "class" : "overflow-path"}
						, {	"data" : "url", "class" : "overflow-path"}
						, {	"data" : "appName"}
						, {	"data" : "redeployDevAppVersion"}
// 						, {	"data" : "envApplicationVersion"}
						, {	"data" : "regDatetime"}
						, {	"class" : "tac"}
						, {	"class" : "tac"}
					],
					"columnDefs" : [
							{	"defaultContent" : "", 	targets : "_all"},
							{	"targets" : [3],	"render" : function(data, type, full)
								{	return full.url + '.git';	}
							},
							{"targets":[7], "render": function(data,type,full){
									var statusHtml = '<ul class="status-line">';
									var deploySt;
									var productSt;

									if(full.deployStatus == "SYNC_APP_SUCCESS"){
										deploySt = "success";
									}else if(full.deployStatus == "SYNC_APP_FAIL"){
										deploySt = "fail";
									}else if(full.deployStatus == null){
										deploySt = "before";
									}

									if(full.productionStatus == "SYNC_APP_SUCCESS"){
										productSt = "success";
									}else if(full.productionStatus == "SYNC_APP_FAIL"){
										productSt = "fail";
									}else if(full.productionStatus == null){
										productSt = "before";
									}

									statusHtml += '<li><i class="cleanup '+ deploySt +'"></i></li>';
									statusHtml += '<li><i class="production '+ productSt +'"></i></li></ul>';
									return statusHtml;
								}
							},
							{	"targets" : [8],	"render" : function(data, type,	full) {
									return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='movePageDetail(\""	+ full.cicdProjectId	+ "\",\""+ full.pipelineId	+ "\",\""+ full.orderProductSeq + "\",\""+ full.projectBoxId + "\",\""+ full.appName + "\")'><i class='fa fa-search'></i></a>";
								}
							}
					],
					"order" : [[0, "asc"]],
					"lengthMenu" : [ [ 10, 15 ], [ 10, 15 ] ],
					"language" : {
						"zeroRecords" : "<p align='center'>검색결과가 없습니다.</p>",
						"processing" : "<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					},
					"sDom" : '<"top"i>rt<"bottom"p>'
				});
		}

		function moveCataloguePage() {

			var params = "?";
			location.href = "mbr/application/req/catalogueDevList" + params;
		}

		function movePageDetail(cicdProjectId, pipelineId, orderProductSeq, projectBoxId, appName) {

			var params = "?cicdProjectId=" + cicdProjectId;
			params += "&pipelineId=" + pipelineId;
			params += "&orderProductSeq=" + orderProductSeq;
			params += "&projectBoxId=" + projectBoxId;
			params += "&appName=" + appName;
			location.href = "${contextPath}/mbr/application/req/cataloguePrdExportDetail"+ params;
		}

		$(document).ready(function() {
			App.init();
			gridList();

			//메뉴활성화
			$("#reqDev").addClass("active");
			$("#reqPrdDeployList").addClass("active");
		});
	</script>
</body>
</html>