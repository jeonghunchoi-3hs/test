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
				<h1>부가가치세율</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">요금 관리</a><a href="#" class="on">부가가치세율</a>
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
								<option value="searchAll">전체</option>
								<option value="customerName">구분</option>
								<option value="companyName">고객사</option>
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 450px">
							<a type='button' class="btn_search" onclick="gridList()">검색</a>
						</div>
					</div>
				</div>
				<!-- search end -->

				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a type="button" class="btnType01" onclick="excelDown();"><i class="ico_download"></i><span>다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-15" >
						<table id="table-list" summary="부가가치세율">
					 <caption>게시판 목록 : 구분, 고객사, 대표자명, 담당자, 부가가치세율(%), 상세로 구성</caption>
							<colgroup>
								<col width="203px">
								<col width="250px">
								<col width="126px">
								<col width="126px">
								<col width="202px">
								<col width="67px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">회원사명</th>
									<th scope="col">회원사코드</th>
									<th scope="col">대표자명</th>
									<th scope="col">담당자</th>
									<th scope="col">부가가치세율<span class="fontVdn">(%)</span></th>
									<th scope="col">상세</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
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
				"url":"${contextPath}/mng/cmm/customer/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.searchKey0 = "";
					d.searchKey1 = "";
				}
			}
			,"columns":[
				{"data":"customerName" , "class":"tal p-l-30"}
				, {"data":"customerId" , "class":"tal name"}
				, {"data":"companyRep"}
				, {"data":"managerName"}
				, {"data":"vatRate" , "class":"tar fontVdn p-r-20"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[5], "render": function(data,type,full){
					return '<a type="button" class="btn_viewDetail" onclick="moveDetailPage(\''+full.customerId+'\');"></a>';
					}
				}
			]
			,"order": [[0,"desc"]]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});

	}

	function moveDetailPage(customerId){
		var params = "?customerId="+customerId;
		location.href = "${contextPath}/mng/cmm/customer/vatRateViewPage"+params;
	}

	function excelDown(){
		var params = "";
		params += "&searchKind="+$("#searchKind option:selected").val();
		params += "&keyword="+$("#keyword").val();

		location.href = '${contextPath}/mng/cmm/customer/vatRateExcel?'+params;
	}

	$(document).ready(function() {
		App.init();
		gridList();

		//메뉴활성화
		$("#chargeManagement").addClass("active");
		$("#vatRateMenu").addClass("active");
	});
</script>
</body>
</html>