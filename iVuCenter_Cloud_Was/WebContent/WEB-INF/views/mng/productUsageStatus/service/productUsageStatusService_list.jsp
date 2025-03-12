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
			<!-- begin #page-container > header -->
			<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #page-container > header -->
			<!-- begin #page-container > sidebar -->
			<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #page-container > sidebar -->

			<!-- begin #page-container > content -->
			<div id="content" class="content">
				<!-- begin header -->
				<div class="page_header mb30">
					<h1>서비스자원</h1>
					<div class="pageNav">
						<a href="#" class="home"><i></i></a><a href="#">자원사용현황</a><a href="#" class="on">서비스</a>
					</div>
				</div>
				<!-- end header -->

				<!-- begin page-body -->
				<div class="row pb50">
					<!-- search begin -->
					<div class="page_searchBox">
						<div class="searchArea">
							<div class="selectBox">
								<label class="selectText" for="searchKind">전체</label>
								<select type="select" class="search-sel width-150" id="searchKind" title="전체">
									<option value="searchAll">전체</option>
									<option value="project_alias">프로젝트명</option>
									<option value="service_type_name">서비스 유형</option>
									<option value="service_name">서비스명</option>
									<option value="hostname_alias">가상서버</option>
								</select>
							</div>
								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
								<a type='button' class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>
						</div>
					</div>
					<!-- search end -->

					<!-- Usage Status -->
					<div class="usageStatusWrap mb20">
						<strong class="titleLabel">조회 건수 합계</strong>
						<dl>
						    <dt>총 합계</dt>
							<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>보안관제</span><span class="cnt" id="securityCnt"><em class="fc-blue">0</em>EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>계정관리</span><span class="cnt" id="accountCnt"><em class="fc-violet">0</em>EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>백업관리</span><span class="cnt" id="backupCnt"><em class="fc-green">0</em>EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>SW설치</span><span class="cnt" id="swCnt"><em class="fc-orange">0</em>EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-bluegreen mr10"></i>디스크관리</span><span class="cnt" id="diskMng"><em class="fc-bluegreen">0</em>EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-bluegreen mr10"></i>오토스케일</span><span class="cnt" id="autoscaleCnt"><em class="fc-bluegreen">0</em>EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-bluegreen mr10"></i>APP재배포</span><span class="cnt" id="applicationRedistributionCnt"><em class="fc-bluegreen">0</em>EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-bluegreen mr10"></i>컨테이너터미널</span><span class="cnt" id="containerTerminalCnt"><em class="fc-bluegreen">0</em>EA</span></dd>
						</dl>

					</div>
					<!-- Usage Status end-->

				<!-- 테이블시작 -->

					<!-- 그리드 영역 -->

						<!-- 상단 버튼  -->
						<div class="tar mb5">
							<a type='button' onclick="excelDown();" class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
						</div>
						<!-- //상단 버튼  -->
						<table id="table-list" class="tableWrap">
							<colgroup>
								<col width="180px">
								<col width="140px">
								<col width="240px">
								<col width="140px">
								<col width="*">
								<col width="200px">
								<col width="180px">
							</colgroup>
							<thead>
								<tr>
									<th>클라우드</th>
									<th>프로젝트ID</th>
									<th>프로젝트명</th>
									<th>서비스유형</th>
									<th>서비스명</th>
									<th>자원명</th>
									<th>자원승인일시</th>
								</tr>
							</thead>
						</table>

				<!-- 테이블 끝 -->

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

			function cloudSearchId(cloudId, cloudName) {
				$("#h_cloudSearchId").val(cloudId);
				$("#h_cloudSearchName").val(cloudName);

				gridList();
	        }


			function gridList() {
				$("#table-list").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${contextPath}/mng/productUsageStatus/service/list"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#searchKind option:selected").val();
							d.keyword = $("#keyword").val();
						}
					}
					,"initComplete" : function(setting, json){
						$("#accountCnt em").text(json.totalData.accountCnt);
						$("#securityCnt em").text(json.totalData.securityCnt);
						$("#backupCnt em").text(json.totalData.backupCnt);
						$("#swCnt em").text(json.totalData.swCnt);
						$("#diskCnt em").text(json.totalData.diskCnt);
						$("#autoscaleCnt em").text(json.totalData.autoscaleCnt);
						$("#applicationRedistributionCnt em").text(json.totalData.applicationRedistributionCnt);
						$("#containerTerminalCnt em").text(json.totalData.containerTerminalCnt);

					}
					,"columns":[
						{"data":"cloudName"}
						, {"data":"projectName" }
						, {"data":"projectAlias" , "class":"tal overflow-path"}
						, {"data":"serviceTypeName"}
						, {"data":"serviceName" , "class":"tal overflow-path"}
						, {"data":"resourceName" , "class":"tal overflow-path"}
						, {"data":"regDatetime"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
					]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					}
					,"sDom":'<"top">rt<"bottom"ip>'
				});

				//팝업 테이블 odd, even 스타일 세팅
				$('#table-list tr:odd').addClass('odd');
				$('#table-list tr:even').addClass('even');
			}

			function excelDown(){
				var params = "";
				params += "&searchKind="+$("#searchKind option:selected").val();
				params += "&keyword="+$("#keyword").val();

				location.href =  '${contextPath}/mng/productUsageStatus/service/excel?' + encodeURI(params);
			}

			$(document).ready(function() {
				App.init();
				gridList();

				//메뉴활성화
				$("#productUsageStatus").addClass("active");
				$("#productUsageStatusBack").addClass("active");

				//tab 첫번째 메뉴 활성화
				$(".nav-pills>li:first-child").addClass("active");
			});
		</script>
	</body>
</html>