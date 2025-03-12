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
				<h1>이미지 관리</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책 관리</a><a href="#" class="on"> 이미지 관리 </a>
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
								<option value="">전체</option>				
								<option value="affiliateName">계열사명</option>
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 450px">
							<a type="button" class="bton-s bton_blue" onclick="gridList();"><i class="fa fa-search"></i> 검색</a>
						</div>
					</div>
				</div>
				<!-- search end -->
			
			
			<!-- 테이블시작 -->
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a type="button" class="bton-s bton_blue" onclick="excelDown();"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
						<a type="button" class="bton-s bton_blue" href="${contextPath}/mng/bss/productOs/write?productSeq=0"><i class="fa fa-upload"></i><span> 등록</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
					<div class="tableWrap gridType01_aType">
						<table id="bssProductList">
						
							<colgroup>
								<col width="*">
								<col width="10%">
								<col width="15%">
								<col width="15%">
								<col width="10%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
							</colgroup>
							<thead>
								<tr>
									<th>이미지 ID </th>
									<th>이미지유형</th>
									<th>이미지명</th>
									<th>이미지 별칭</th>
									<th>이미지 Type</th>
									<th>Public</th>
									<th>이미지 크기</th>
									<th> 상세</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>

			
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

	function gridList() {
		
		 $("#bssProductList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/bss/productOs/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[
						  {"data":"vmImageId", "class":"tac"}
			        	, {"data":"itemId", "class":"tac"}
			        	, {"data":"vmImageName", "class":"tac"}
			        	, {"data":"imageAlias", "class":"tac"}
			        	, {"data":"imageRange", "class":"tac"}
			        	, {"data":"", "class":"tac"}
			        	, {"data":"imageSize", "class":"tac"}
			        	, {"class":"ditailStyle tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[7], "render": function(data,type,full){
					return "<button type='button' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.productSeq+"\")' ><i class='fa fa-search'></i></button>";
					}	
				}
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
	}
 
 	function moveDetailPage(productSeq){
		location.href = "${contextPath}/mng/bss/productOs/view?productSeq="+productSeq;
 	}
 
 	function moveApprovalPage(){

 		var table = $("#mngProjectList").DataTable();
 		
 		$("#mngProjectList tbody").on("click", "td.ditailStyle", function() {
			var rowData = table.row($(this).closest("tr")).data();
			var rowSeq = rowData.noticeNo;
			
			location.href = "${contextPath}/mng/bbs/notice/approval?noticeNo="+rowSeq;

 		});
 	}
 	
 	function moveInsertPage(){
 		location.href = "${contextPath}/mng/bss/productOs/write?productSeq=0";
 	}
	
	$(document).ready(function() {
		
		gridList();
		App.init();
		
		//메뉴활성화
		$("#operation").addClass("active");
		$("#bssProductOs").addClass("active");

	});
</script>
</body>
</html>