<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
							<h1>기본정보</h1>
							<div class="pageNav">
								<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">기본정보 관리</a>
							</div>
						</div>
						<!-- end header -->

						<!-- begin page-body -->
						<div class="row">

						<!-- search begin -->
						<div class="page_searchBox">
							<div class="searchArea">
								<div class="selectBox">
									<label class="selectText" for="searchKind">전체</label>
									<select class="search-sel width-150" id="searchKind">
										<option value="searchAll">전체</option>
										<option value="project_alias">프로젝트 설명</option>
										<option value="project_name">프로젝트명</option>
										<option value="manager_name">담당자 명</option>
									</select>
								</div>
								<input type="text" placeholder="검색어를 입력하세요" id="keyword"
									onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
								<button class="bton-s bton_blue" onclick="gridList()"> <i class="fa fa-search"></i>  검색</button>
							</div>
						</div>
						<!-- search end -->
						<!-- 테이블시작 -->

								<!-- 상단 버튼  -->
								<div class="tar mb5">
									<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
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
											<col width="100px">
											<col width="140px">
											<col width="140px">
											<col width="100px">
											<col width="80px">
										</colgroup>
										<thead>
											<tr>
												<th>본부</th>
												<th>처(실)</th>
												<th>부서</th>
												<th>프로젝트 ID</th>
												<th>프로젝트 명</th>
												<th>담당자</th>
												<th>전화번호(사선)</th>
												<th>핸드폰</th>
												<th>등록일</th>
												<th>상세</th>
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
							"url":"${contextPath}/mng/oss/project/list"
							,"type" : "GET"
							,"data":function (d) {
								d.searchKind = $("#searchKind option:selected").val();
								d.keyword = $("#keyword").val();
							}
						}
						,"columns":[
							{"data":"deptName"}
							, {"data":"deptName"}
							, {"data":"deptName"}
							, {"data":"projectName" , "class":"tal"}
							, {"data":"projectAlias" , "class":"tal name"}
							, {"data":"managerName"}
							, {"data":"managerTelEx"}
							, {"data":"managerPhone"}
							, {"data":"regDatetime" ,"render":function (data,type,full,meta){
								return '<span title ="'+data.substr(0,10)+'">'+data.substr(0,10)+'</span>';
							}}
							/* , {"data":"deleteFlag" , "class":"tac"}
							, {"data":"" , "class":"tac"}
					        , {"class":"tac", "width":"65px"}  */
						]
						,"columnDefs":[
							{"defaultContent" : "", targets:"_all" }
							, {"targets":[0], "render": function(data,type,full){
								return full.deptName2.split("/")[1];
								}
							}
							, {"targets":[1], "render": function(data,type,full){
								return full.deptName2.split("/")[2];
								}
							}
							, {"targets":[2], "render": function(data,type,full){
								return full.deptName2.split("/")[3];
								}
							}
							, {"targets":[8], "render": function(data,type,full){
								return '<span title ="'+data.substr(0,10)+'">'+data.substr(0,10)+'</span>';
								}
							}
							, {"targets":[9], "render": function(data,type,full){
								<!--return "<a href='javascript:void(0);' class='btn_viewDetail'  onclick='movePageDetail(\""+full.projectId+"\",\""+full.projectName+"\")'></a>";-->
								return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='movePageDetail(\""+full.projectBoxId+"\",\""+full.projectName+"\",\""+full.projectAlias+"\",\""+full.programSeq+"\")'><i class='fa fa-search'></i></a>";

								}
							}

						]
						,"language": {
							"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
							, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#888; font-weight:bold;'>검색중입니다.</p></div>"
						}
						,"sDom":'<"top">rt<"bottom"ip>'
					});
					tblColorSet();
				}

				function tblColorSet() {
					$('.gridType01 .tableWrap table thead th').each(function(index, item){
						$(item).addClass('th' + index);
					});
				}

				function movePageDetail(projectBoxId, projectName, projectAlias, programSeq){
					var params = "?reqProjectSeq="+programSeq;
					      params += "&projectBoxId="+projectBoxId;

					location.href = "${contextPath}/mng/project/info/view" + encodeURI(params);
				}

				function moveInsertPage(){
					location.href = "${contextPath}/mng/project/info/write";
				}

				function excelDown(){
					var params = "searchKind="+$("#searchKind option:selected").val();
					params += "&keyword="+$("#keyword").val();
					location.href = "${contextPath}/mng/oss/project/mngProjectInfoExcel?" + encodeURI(params);
				}

				$(document).ready(function() {
					App.init();
					gridList();

					//메뉴활성화
					$("#project").addClass("active");
					$("#projectInfo").addClass("active");

					//tab 첫번째 메뉴 활성화
					$(".nav-pills>li:first-child").addClass("active");
				});
			</script>
	</body>
</html>