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
					<h1>어플리케이션</h1>
					<div class="pageNav">
						<a href="#" class="home"><i></i></a><a href="#">자원사용현황</a><a href="#" class="on">어플리케이션</a>
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
									<option value="searchAll" selected="selected">전체</option>
									<option value="project_name">프로젝트 ID</option>
									<option value="project_alias">프로젝트명</option>
									<option value="app_name">어플리케이션 ID</option>
									<option value="app_alias">어플리케이션 이름</option>
									<option value="template_name">이미지 템플릿</option>
								</select>
							</div>
								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
								<button class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</button>
						</div>
					</div>
					<!-- search end -->

					<!-- Usage Status -->
					<div class="usageStatusWrap mb20">
						<strong class="titleLabel">조회 건수 합계</strong>
						<dl>
						    <dt>총 합계</dt>
							<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>Deployment</span><span class="cnt" id='title_deployment'><em class="fc-violet">0</em> EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>Pod</span><span class="cnt" id='title_pod'><em class="fc-blue">0</em> EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>Service</span><span class="cnt" id='title_service'><em class="fc-green">0</em> EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>Route</span><span class="cnt" id='title_route'><em class="fc-violet">0</em> EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>Volume</span><span class="cnt" id='title_volume'><em class="fc-blue">0</em> EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>Build</span><span class="cnt" id='title_build'><em class="fc-green">0</em> EA</span></dd>
<!-- 							<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>MEMORY</span><span class="cnt" id='title_memGb'><em class="fc-blue">0</em>GB</span></dd> -->
<!-- 							<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>DISK</span><span class="cnt" id='title_diskGb'><em class="fc-green">0</em>GB</span></dd> -->
<!-- 							<dd class="total" id='title_length' style='text-align:center; padding-left:0px !important'><em>0</em>EA</dd> -->
						</dl>
					</div>
					<!-- //Usage Status -->

					<!-- 테이블시작 -->

						<!-- 그리드 영역 -->

							<!-- 상단 버튼  -->
							<div class="btnArea tar mb5">
								<a type='button' onclick="excelDown();" class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
							</div>
							<!-- //상단 버튼  -->
							<table id="table-list" class="tableWrap">

								<colgroup>
										<col width="10%">
										<col width="12%">
										<col width="12%">
										<col width="12%">
										<col width="12%">
										<col width="12%">
										<col width="12%">
										<col width="8%">
										<col width="8%">
										<col width="8%">
										<col width="8%">
										<col width="8%">
<%-- 										<col width="10%"> --%>
										<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th>클라우드</th>
										<th>프로젝트ID</th>
										<th>프로젝트명</th>
										<th>어플리케이션ID</th>
										<th>어플리케이션 이름</th>
										<th>이미지 템플릿</th>
										<th>Deployment</th>
										<th>POD(EA)</th>
										<th>Service</th>
										<th>Route</th>
										<th>Build</th>
										<th>PV(GB)</th>
<!-- 											<th>상태</th> -->
										<th>승인일시</th>
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

   function gridList() {

		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/productUsageStatus/app/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"initComplete" : function(setting, json){
				 $("#title_deployment").text(json.totalData.deploymentConfigCnt+ " EA");
				 $("#title_pod").text(json.totalData.pod + " EA");
				 $("#title_service").text(json.totalData.serviceCnt + " EA");
				 $("#title_route").text(json.totalData.routesCnt + " EA");
				 $("#title_volume").text(json.totalData.volume + " GB");
				 $("#title_build").text(json.totalData.buildsCnt + " EA");
			}
			,"columns":[
				{"data":"cloudName"}
				, {"data":"projectName"}
				, {"data":"projectAlias"}
				, {"data":"appName"}
				, {"data":"appAlias"}
				, {"data":"templateName"}
				, {"data":"deploymentConfigCnt"}
				, {"data":"pod"}
				, {"data":"serviceCnt"}
				, {"data":"routesCnt"}
				, {"data":"buildsCnt"}
				, {"data":"volume"}
				, {"data":"regDatetime"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
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

// 		location.href =  '${contextPath}/mng/productUsageStatus/vm/excel?' + encodeURI(params);
		location.href =  '${contextPath}/mng/productUsageStatus/app/excel?' + encodeURI(params);
	}

	$(document).ready(function() {
		App.init();
		gridList();

		//메뉴활성화
		$("#productUsageStatus").addClass("active");
		$("#productUsageStatusApp").addClass("active");

		//tab 첫번째 메뉴 활성화
		$(".nav-pills>li:first-child").addClass("active");
	});
		</script>
	</body>
</html>