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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
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
			<div class="row pb50">
			
			<!-- search begin -->
			<div class="page_searchBox m-b-15">
				<div class="searchArea">
					<div class="selectBox" style="width:130px;">
						<label class="selectText" for="searchKind">전체</label>
						<select class="search-sel" id="searchKind">
							<option value="project_alias">프로젝트명</option>
							<option value="project_name">프로젝트별칭</option>				
						</select>
					</div>
					<div class="inputArea m-l-5">
						<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 450px">
						<a type="button" class="btn_search" onclick="gridList()">검색</a>
					</div>
				</div>
			</div>
			<!-- search end -->
			<!-- 테이블시작 -->
			<div class="gridTableWrap gridType01">
					<!-- 그리드 영역 --> 
					<div class="tableWrap m-t-15">
						<table id="table-list">
							<colgroup>
								<col width="140px">
								<col width="120px">
								<col width="210px">
								<col width="120px">
								<col width="105px">
								<col width="130px">
								<col width="75px">
								<col width="65px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">본사</th>
									<th scope="col">고객사</th>
									<th scope="col">프로젝트명</th>
									<th scope="col">고객사 관리자</th>
									<th scope="col">담당PM</th>
									<th scope="col">시작일</th>
									<th scope="col">상태</th>
									<th scope="col">상세</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
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
					d.customerId = "";
				}
			}
			,"columns":[
				{"data":"upCompanyName" , "class":"tal"}
				,{"data":"customerName" , "class":"tal"}
				//, {"data":"projectName" , "class":"tal"}
				, {"data":"projectAlias" , "class":"tal name"} 
				, {"data":"userName" , "class":"tac"}
				, {"data":"managerName" , "class":"tac"}
				, {"data":"regDatetime" , "class":"tac fontVdn"}
				, {"data":"start" , "class":"tac"}
		        , {"class":"tac", "width":"65px"} 
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[6], "render": function(data,type,full){
					
						if(full.start == "1"){ 
							return "<span class='state_use'>사용</span>";
						}else{
							return "<span class='state_end'>사용</span>";
						}
					}	
				}
				, {"targets":[7], "render": function(data,type,full){
					return "<a href='javascript:void(0);' class='btn_viewDetail'  onclick='movePageDetail(\""+full.projectId+"\",\""+full.projectName+"\")'></a>";
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
	function movePageDetail(projectId, projectName){
		var params = "?projectId="+projectId;
		params += "&projectName="+projectName;
		location.href = "${contextPath}/mng/oss/project/view"+params;
	}
	
	function moveInsertPage(){
		location.href = "${contextPath}/mng/oss/project/write";
	}
	
	$(document).ready(function() {
		App.init();
		gridList();
		
		//메뉴활성화
		$("#project").addClass("active");
		$("#ossProject").addClass("active");
	});
</script>
</body>
</html>