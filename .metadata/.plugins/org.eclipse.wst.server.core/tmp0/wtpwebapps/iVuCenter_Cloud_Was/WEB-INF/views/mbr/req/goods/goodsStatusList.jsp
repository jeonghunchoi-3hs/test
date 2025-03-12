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
			<h1 class="page-header fc66 fbold"> <i class="fa fa-dot-circle-o fcb"> </i> 나의자원 가상머신 <span class="root"> 콘솔 > 나의 자원 > 나의 가상머신</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row mb50">
			
			<!-- search begin -->
			<div class="col-md-12 bgee br10 mb10">
				<div class="col-md-2 p10"> 
	                <select class="form-control" id="searchKind">
		                <option value="">검색기준</option>
		                <option value="projectNm">프로젝트명</option>
		                <option value="hostNm">호스트명</option>
	                </select>
				</div>
				<div class="col-md-4 p10"> 
					<input type="text" class="form-control" placeholder="검색어를 입력하세요" />
				</div>
				<div class="col-md-1 tar pr0 mt20">상태</div>
				<div class="col-md-1 p10"> 
	                <select class="form-control" id="delFlag">
		                <option value="">서비스 상태</option>
		                <option value="Y">사용</option>
		                <option value="N">중지</option>
	                </select>
				</div>
				<div class="col-md-1 tar pr0 mt20 pl0">서비스시작일</div>
				<div class="col-md-2 p10">
<!-- 					<div class="input-group date"> -->
<!-- 						<input type="text" class="form-control dpin w80" placeholder="날짜선택" id="startDate"/> -->
<!-- 													<span class="input-group-addon"><i class="fa fa-calendar"></i></span> -->
<!-- 					</div> -->
				</div>
               <div class="col-md-1 p10"><a href="#"><button type="button" class="btn btn-grey w-100">검색</button></a> </div>
			</div>			
			<!-- search end -->		
				
			<!-- 테이블시작 -->
			<div class="col-md-12">
				<div class="panel">
				    <div class="table-responsive">
				        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="mbrMyVmList">
							<colgroup>
								<col width="30%">
								<col width="30%">
								<col width="20">
								<col width="20%">
							</colgroup>
							<thead>
							    <tr class="primary">
							        <th class="tac">프로젝트명</th>
									<th class="tac">호스트명</th>
									<th class="tac">서비스시작일</th>
									<th class="tac">서비스상태</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>			
			</div>
			<!-- 테이블 끝 -->
			</div>
			<!---- end page body---->
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
		
		 oTable = $("#mbrMyVmList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.appvKind = $("#delFlag > option:selected").val();
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
			,"order": [[0,"asc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
					, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"p>',"oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {
					}
				}]
			}
		});
		
	}

	
 	function moveDetailPage(){

 		var table = $("#mbrMyVmList").DataTable();
 		
 		$("#mbrMyVmList tbody").on("click", "td.ditailStyle", function() {
			var rowData = table.row($(this).closest("tr")).data();
			var rowSeq = rowData.requestSeq;
			
			location.href = "${contextPath}/mbr/myGoods/vm/view?requestSeq="+rowSeq;

 		});
 	}
 	
 	

	// 달력
// 	function calendar(){
		
// 		var dayName = ['월','화','수','목','금','토','일'];
// 		var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

// 		$("#startDate").datepicker({
// 			showOn:"both",
// 			buttonImage:"${apachePath}/resources/assets/img/calen.png",
// 			buttonImageOnly:true,
// 			dateFormat : "yy-mm-dd",
// 			dayNamesMin:dayName,
// 			monthNamesShort:monthName,
// 			changeMonth:true
// 		});
		

// 	}
	
	$(document).ready(function() {
		
// 		gridList();
		App.init();
// 		calendar();
		
		//메뉴활성화
		$("#myGoods").addClass("active");
		$("#myVm").addClass("active");

	});
</script>

</html>