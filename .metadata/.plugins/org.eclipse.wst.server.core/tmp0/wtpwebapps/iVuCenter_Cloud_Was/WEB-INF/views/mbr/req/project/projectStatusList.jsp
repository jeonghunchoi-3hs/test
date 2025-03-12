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
	<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>
	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin header -->
			<h1 class="page-header fc66 fbold"> <i class="fa fa-dot-circle-o fcb"> </i> 프로젝트 신청 현황 <span class="root">관리자포털 > 프로젝트 > 프로젝트 신청 관리</span></h1>
			<!-- end header -->
			
			<!-- search begin -->
			<div class="col-md-12 bgee br10 mb10">		
				<div class="col-md-2 p10"> 
					<select class="form-control" id="appvKind">
						<option value="">처리상태</option>
						<option value="APPRV_PROCESSING">승인처리중</option>
						<option value="APPRV_COMPLETED">승인완료</option>
						<option value="APPRV_REJECTED">승인취소</option>
					</select>
				</div>
				<div class="col-md-2 p10">
					<select class="form-control" id="searchKind">
						<option value="searchAll">검색기준</option>
						<option value="cstmName">회원사명</option>
						<option value="prjtName">프로젝트명</option>
					</select>
				</div>
				<div class="col-md-6 p10">  <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword" /></div>
<!-- 				<div class="col-md-1"><a href="#"><button type="button" class="btn btn-grey w-80">검색</button></a> </div> -->
				<div class="col-md-1 p10"><input type="button" class="btn btn-grey w-80" value="검색" onclick="gridList()"></div>
			</div>	
			<!-- search end -->		
				
			<!-- 테이블시작 -->
			<div class="col-md-12">
			<input type="hidden" id="customerId" value="${customerId}">
				<div class="panel">
				    <div class="table-responsive">
				        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="mbrProjectList">
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="*">
								<col width="10%">
								<col width="20%"> 
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
							    <tr class="primary">
							    	<th class="tac">사업자</th>
									<th class="tac">회원사명</th>
									<th class="tac">프로젝트</th>
									<th class="tac">요청처리상태</th>
									<th class="tac">설명</th>
									<th class="tac">신청일시</th>
									<th class="tac">프로젝트상세보기</th>
									
							    </tr>
							</thead>
						</table>
					</div>
				</div>			
			</div>
			<!-- 테이블 끝 -->
			
			<!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
	
</body>



<script type="text/javascript">
var oTable;


	function gridList() {
		
		 oTable = $("#mbrProjectList").dataTable( { 
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"projectStatusList"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.appvKind = $("#appvKind > option:selected").val();
					d.searchKind = $("#searchKind > option:selected").val();
					d.keyword = $("#keyword").val();
					d.customerId = $("#customerId").val();
				}
			}
			,"columns":[
						{"data":"companyName", "class":"tac"}
			        	, {"data":"customerName", "class":"tac"}
			        	, {"data":"projectAlias", "class":"tac"}
			        	, {"data":"requestApprvState","class":"tac"}
			        	, {"data":"projectDescription", "class":"tac"}
			        	, {"data":"regDatetime", "class":"tac"}
			        	, {"defaultContent":"<button onclick='moveDetailPage()' >승인 상세보기</button>", "class":"ditailStyle tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
			]
			,"order": [[0,"asc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
					, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>',"oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {
						//moveInsertPage();
					}
				}]
			}
		});
		
	}

 
 
 	function moveDetailPage(){

 		var table = $("#mbrProjectList").DataTable();
 		
 		$("#mbrProjectList tbody").on("click", "td.ditailStyle", function() {
			var rowData = table.row($(this).closest("tr")).data();
			var rowSeq = rowData.reqProjectSeq;
			
			location.href = "${contextPath}/mbr/req/project/view?reqProjectSeq="+rowSeq;

 		});
 	}
 
 	function moveApprovalPage(){

 		var table = $("#mbrProjectList").DataTable();
 		
 		$("#mbrProjectList tbody").on("click", "td.ditailStyle", function() {
			var rowData = table.row($(this).closest("tr")).data();
			var rowSeq = rowData.noticeNo;
			
			location.href = "${contextPath}/mbr/bbs/notice/approval?noticeNo="+rowSeq;

 		});
 	}
 	
 	function moveInsertPage(){
 		location.href = "${contextPath}/mbr/bbs/notice/write";	
 	}
	
	$(document).ready(function() {
		
		gridList();
		App.init();
		
		//메뉴활성화
		$("#reqStatus").addClass("active");
		$("#projectReqStatus").addClass("active");

	});
</script>

</html>