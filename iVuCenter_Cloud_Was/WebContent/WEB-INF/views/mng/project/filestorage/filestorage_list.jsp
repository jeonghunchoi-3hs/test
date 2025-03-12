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
				<h1>파일스토리지 관리</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">파일스토리지 관리</a>
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
							<option value="project_alias">프로젝트명</option>
							<option value="project_name">프로젝트ID</option>
							<option value="manager_name">담당자 명</option>
						</select>
					</div>

						<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
						<button class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</button>
				</div>
			</div>
			<!-- search end -->
			<!-- 테이블시작 -->

					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->

						<table id="table-list" class="tableWrap">

							<colgroup>
								<col width="150px">
								<col width="150px">
								<col width="150px">
								<col width="13%">
								<col width="*">
								<col width="8%">
								<col width="8%">
								<col width="10%">
								<col width="5%">
							</colgroup>
							<thead>
								<tr>
									<th class="tac">본부</th>
									<th class="tac">처(실)</th>
									<th class="tac">부서</th>
									<th class="tac">프로젝트ID</th>
									<th class="tac">프로젝트명</th>
									<th class="tac">담당자</th>
									<th class="tac">전화번호(사선)</th>
									<th class="tac">FS(EA)</th>
									<th class="tac">상세</th>
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
				"url":"${contextPath}/mng/oss/project/mngFsList"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.customerId = "";
				}
			}

			,"columns":[
				{"data":"deptName" , "class":"tac"}
				, {"data":"deptName" , "class":"tac"}
				, {"data":"deptName" , "class":"taC"}
				, {"data":"projectName" , "class":"tac"}
				, {"data":"projectAlias" , "class":"tac name"}
				, {"data":"managerTelEx" , "class":"tac"}
				, {"data":"managerPhone" , "class":"tac"}
				, {"data":"FsCnt" , "class":"tac","render":function (data,type,full,meta){
					return addcomma(data);
				}}
		        , {}
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
					return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='movePageDetail(\""+full.projectBoxId+"\",\""+full.projectId+"\",\""+full.projectName+"\",\""+full.programSeq+"\")'><i class='fa fa-search'></i></a>";
					}
				}
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
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

	function movePageDetail(projectBoxId, projectId, projectName, programSeq){
		var params = "?projectBoxId="+projectBoxId;
		params += "&projectId="+projectId;
		params += "&projectName="+projectName;
		params += "&programSeq="+programSeq;
		location.href = "${contextPath}/mng/project/filestorage/view"+params;
	}

	function excelDown(){
	    var params = "";
	    params += "&searchKind=" + $("#searchKind option:selected").val();
	    params += "&keyword=" + $("#keyword").val();
	    params += "&customerId=";
	    location.href =  '${contextPath}/mng/oss/project/diskExcel?' + encodeURI(params);
	}

	$(document).ready(function() {
		App.init();
		gridList();

		//메뉴활성화
		$("#project").addClass("active");
		$("#projectFs").addClass("active");

		//tab 첫번째 메뉴 활성화
		$(".nav-pills>li:first-child").addClass("active");
	});
</script>
</body>
</html>