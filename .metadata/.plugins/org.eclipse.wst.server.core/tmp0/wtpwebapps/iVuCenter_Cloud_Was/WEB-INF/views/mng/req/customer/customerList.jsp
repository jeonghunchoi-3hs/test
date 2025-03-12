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

	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

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
			<h1 class="page-header fc66 fb"> <i class="fa fa-dot-circle-o fcb"> </i> 회원사 신청 현황 <span class="root"> 회원사 관리 > 회원사 신청 현황</span></h1>
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
						<option value="cstmId">회원사ID</option>
						<option value="ctctName">담당자명</option>
					</select>
				</div>
				<div class="col-md-6 p10">  <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/></div>
<!-- 				<div class="col-md-1"><a href="#"><button type="button" class="btn btn-grey w-80">검색</button></a> </div> -->
				<div class="col-md-1 p10"><input type="button" class="btn btn-grey w-80" value="검색" onclick="gridList()"></div>
			</div>	
			<!-- search end -->		
				
			<!-- 테이블시작 -->
			<div class="col-md-12">
				<div class="panel">
				    <div class="table-responsive">
				        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="mngCustomerList">
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="*">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
							    <tr class="primary">
							        <th class="tac">사업자</th>
									<th class="tac">회원사명</th>
									<th class="tac">회원사아이디</th>
									<th class="tac">담당자이름</th>
									<th class="tac">담당자핸드폰</th>
									<th class="tac">담당자이메일</th>
									<th class="tac">신청일시</th>
									<th class="tac">진행상태</th>
									<th class="tac">승인상세보기</th>
									
							    </tr>
							</thead>
						</table>
					</div>
				</div>			
			</div>
			<!-- 테이블 끝 -->
			
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
		 $("#mngCustomerList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/req/customer/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.appvKind = $("#appvKind > option:selected").val();
					d.searchKind = $("#searchKind > option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[ 
			        	  {"data":"companyId","class":"tac"}
			        	, {"data":"customerName", "class":"tac"}
			        	, {"data":"customerId", "class":"tac"}
			        	, {"data":"contactName", "class":"tac"}
			        	, {"data":"contactPhone", "class":"tac"}
			        	, {"data":"contactMail", "class":"tac"}
			        	, {"data":"regDatetime", "class":"tac"}
			        	, {"data":"requestApprvState","class":"tac"}
			        	, {"defaultContent":"<button onclick='moveDetailPage()' >승인 상세보기</button>", "class":"ditailStyle tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top"T>rt<"bottom"p>',"oTableTools": {
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

 		var table = $("#mngCustomerList").DataTable();
 		
 		$("#mngCustomerList tbody").on("click", "td.ditailStyle", function() {
			var rowData = table.row($(this).closest("tr")).data();
			var rowSeq = rowData.requestSeq;
			
			location.href = "${contextPath}/mng/req/customer/view?requestSeq="+rowSeq;

 		});
 	}
 
 	function moveApprovalPage(){

 		var table = $("#mngCustomerList").DataTable();
 		
 		$("#mngCustomerList tbody").on("click", "td.ditailStyle", function() {
			var rowData = table.row($(this).closest("tr")).data();
			var rowSeq = rowData.noticeNo;
			
			location.href = "${contextPath}/mng/bbs/notice/approval?noticeNo="+rowSeq;

 		});
 	}
 	
 	function moveInsertPage(){
 		location.href = "${contextPath}/mng/bbs/notice/write";	
 	}
	
	$(document).ready(function() {
		App.init();
		gridList();
		
		//메뉴활성화
		$("#request").addClass("active");
		$("#reqCustomer").addClass("active");

	});
</script>
</body>
</html>