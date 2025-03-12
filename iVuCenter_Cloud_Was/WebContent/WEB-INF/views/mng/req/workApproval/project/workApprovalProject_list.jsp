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
					<h1>프로젝트 등록(신청) 현황</h1>
					<div class="pageNav">
						<a href="#" class="home"><i></i></a><a href="#">승인/작업 처리</a><a href="#" class="on">프로젝트 승인</a>
					</div>
				</div>
				<!-- end header -->
				<div class="row">

					<input type="hidden" id="myWorkYn" value="${myWorkYn}">
					<!-- search begin -->
					<div class="page_searchBox">
						<div class="optionBox mr10">
							<input type="hidden" id="h_cloudSearchId" value="${req.getCloudId() == null ? getCloudList[0].cloudId : req.getCloudId()}">
							<input type="hidden" id="h_cloudSearchName" value="${req.getCloudName() == null ? getCloudList[0].cloudName : req.getCloudName()}">
							<label><input type="radio" name="searchAll" value="my" checked="checked"><span>내작업</span></label>
							<label><input type="radio" name="searchAll" value="all"><span>전체</span></label>
						</div>
						<div class="searchArea">
							<div class="selectBox">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel width-150" id="searchKind">
									<option value="searchAll">전체</option>
									<option value="projectName">프로젝트명</option>
									<option value="deptName">담당조직(부서)</option>
									<option value="projectManager">담당자</option>
								</select>
							</div>

								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 450px">
								<a type="button" class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>

						</div>
					</div>
					<!-- search end -->

					<!-- 테이블시작 -->

						<!-- 그리드 영역 -->

							<!-- 상단 버튼  -->
							<div class="tar mb5">
								<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
							</div>
							<!-- //상단 버튼  -->
							<table id="mngProjectList" class="tableWrap">
								<colgroup>
									<col width="*">
									<col width="120px">
									<col width="120px">
									<col width="120px">
									<col width="100px">
									<col width="100px">
									<col width="120px">
									<col width="100px">
									<col width="100px">
									<col width="140px">
									<col width="80px">
								</colgroup>
								<thead>
								    <tr>
								    	<th>프로젝트명</th>
										<th>본부</th>
										<th>처(실)</th>
										<th>부서</th>
										<th>프로젝트비용<br>(천원)</th>
										<th>담당자</th>
										<th>전화번호(사선)</th>
										<th>상태</th>
										<th>구분</th>
										<th>신청일시</th>
										<th>상세</th>
								    </tr>
								</thead>
							</table>


					<!-- 테이블 끝 -->
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
			function cloudSearchId(cloudId){
				$("#h_cloudSearchId").val(cloudId);
	            gridList();
     		}

			function gridList() {
				$("#mngProjectList").dataTable({
					"processing":true
					,"ordering" : false
					,"destroy" : true
					,"autoWidth":false
					,"serverSide":true
					,"ajax": {
						"url":"${contextPath}/mng/req/project/workApprovalProjectList"
						,"type" : "GET"
						,"dateSrc" : ""
						,"data":function (d) {
							d.searchKind = $("#searchKind option:selected").val();
							d.keyword = $("#keyword").val();
							d.searchAll = $("input:radio[name='searchAll']:checked").val();
							d.cloudId = $("#h_cloudSearchId").val();
						}
					}
					,"columns":[
			        	{"data":"projectAlias", "class":"tal"}
			        	, {"data":"deptName","class":"tac"}
			        	, {"data":"deptName","class":"tac"}
			        	, {"data":"deptName","class":"tac"}
			        	, {"data":"projectPrice", "class":"tar"}
			        	, {"data":"projectManagerName", "class":"tac"}
			        	, {"data":"userTel", "class":"tac"}
			        	, {"data":"completeFlag", "class":"tac"}
			        	, {"data":"srApprovalStepHisCount", "class":"tac"}
			        	, {"data":"regDatetime2", "class":"tac"}
			        	, {"class":"tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[1], "render": function(data,type,full){
							return full.deptName2.split("/")[1];
							}
						}
						, {"targets":[2], "render": function(data,type,full){
							return full.deptName2.split("/")[2];
							}
						}
						, {"targets":[3], "render": function(data,type,full){
							return full.deptName2.split("/")[3];
							}
						}
						, {"targets":[4], "render": function(data,type,full) {
								return "<span>"+addcomma(full.projectPrice)+"</span>";
							}
						}
						, {"targets":[7], "render": function(data,type,full) {
								if(full.completeFlag == "완료") {
									return "<span class='comp'>"+full.completeFlag+"</span>";
								} else {
									if(full.apprvState == "APPRV_REJECTED"){
										return "<span class='reject' >반려</span>";
									} else if (full.apprvState == "APPRV_UNASSIGNED") {
										return "<span class='notarget'> 미지정 </span>";
									} else {
										return "<span class='ing' >"+full.completeFlag+"</span>";
									}
								}
							}
						}

						, {"targets":[8], "render": function(data,type,full) {

							if(full.srApprovalStepHisCount == 0) {
									return "<span class='comp' >신규</span>";
								} else {
									return "<span class='notarget'> 변경 </span>";
								}
							}
						}

						, {"targets":[10], "render": function(data,type,full) {
								return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='moveDetailPage(\""+full.reqProjectSeq+"\")'><i class='fa fa-search'></i></a>";
							}
						}
					]
					,"order": [[0,"desc"]]
					,"lengthMenu": [[11,17], [11, 17]]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					}
					,"sDom":'<"top">rt<"bottom"pi>',"oTableTools": {
						"aButtons":[{
							"sExtends":"text"
							,"sButtonText":"등록"
							,"fnClick":function(nButton,oConfig,oFlash) {
								//moveInsertPage();
							}
						}]
					}
				});

				tblColorSet();
			}

			function tblColorSet() {
				$('.gridType01 .tableWrap table thead th').each(function(index, item){
					$(item).addClass('th' + index);
				});
			}

			function moveDetailPage(reqProjectSeq) {
				location.href = "${contextPath}/mng/req/project/workApprovalProjectView?reqProjectSeq="+reqProjectSeq;
			}

			function moveInsertPage() {
				location.href = "${contextPath}/mng/bbs/notice/write";
			}

			function excelDown() {

				var params = "searchKind="+$("#searchKind option:selected").val();
				params += "&keyword="+$("#keyword").val();
				params += "&searchAll="+$("input:radio[name='searchAll']:checked").val();
				location.href = "${contextPath}/mng/req/project/workApprovalProjectExcel?"+params;
			}

			$(document).ready(function() {
				App.init();

				if($("#myWorkYn").val() == 'N'){
					$("input:radio[name=searchAll][value='all']").attr("checked",true);
				}else{
					$("input:radio[name=searchAll][value='my']").attr("checked",true);
				}

				gridList();

				//메뉴활성화
				$("#req").addClass("active");
				$("#projectManage").addClass("active");
			});
		</script>
	</body>
</html>