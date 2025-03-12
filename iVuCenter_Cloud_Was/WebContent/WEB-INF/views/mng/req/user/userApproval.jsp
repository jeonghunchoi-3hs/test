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
				<h1>회원가입 신청현황</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">승인/작업처리</a><a href="#" class="on">회원가입 신청 현황</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<!-- search begin -->
				<div class="page_searchBox">
				<div class="optionBox mr10">
						<label><input type="radio" name="searchAll" data-original-title="" title="" value ='my' checked><span>내작업</span></label>
						<label><input type="radio" name="searchAll" data-original-title="" title=""  value ='all'><span>전체</span></label>
					</div>
					<div class="searchArea">
						<div class="selectBox">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel width-150" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="customer_name">회원사명</option>
								<option value="user_id">ID</option>				
								<option value="user_name">사용자명</option>				
							</select>
						</div>
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
							<a type="button" class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>
					</div>
				</div>
				<!-- search end -->
				
				<!-- 테이블시작 -->

					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a type="button" class="bton-s bton_blue" onclick="excelDown();"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->			
						<table id="user-list" class="tableWrap">
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="8%">
								<col width="8%">
								<col width="10%">
								<col width="10%">
								<col width="8%">
								<col width="12%">
								<col width="6%">
							</colgroup>
							<thead>
								<tr>
									<th>본부</th>
									<th>처(실)</th>
									<th>부서</th>
									<th>ID</th>
									<th>이름</th>
									<th>직급</th>
									<th>전화번호(사선)</th>
									<th>핸드폰</th>
									<th>상태</th>
									<th>가입일시</th>
									<th>상세</th>
								</tr>
							</thead>
						</table>		
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
		$("#user-list").dataTable( {
			"processing":true
			,"ordering" : false
			,"destroy" : true
			,"autoWidth":false
			,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/req/user/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.searchAll = $("input:radio[name='searchAll']:checked").val()
					
				}
			}
			,"columns":[
				{"data":"deptName", "class":"tal"}			// 1
				, {"data":"deptName", "class":"tal"}			// 1
				, {"data":"deptName", "class":"tal"}			// 1
				, {"data":"userId", "class":"tal"}
				, {"data":"userName", "class":"tal"}			// 3
				, {"data":"userLevel", "class":"tal"}
				, {"data":"userTelEx"}			// 5
				, {"data":"userPhone"}
				, {"data":"apprvState"}			// 7
				, {"data":"apprvDatetime", "class":"tal"}
				, {}								// 9
	        ]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }		
				, {"targets":[0], "render": function(data,type,full){
					return full.deptName.split("/")[1];
					}
				}
				, {"targets":[1], "render": function(data,type,full){
					return full.deptName.split("/")[2];
					}
				}
				, {"targets":[2], "render": function(data,type,full){
					return full.deptName.split("/")[3];
					}
				}
				, {"targets":[8], "render": function(data,type,full){
					if     (full.apprvFlag == "N") { return "<span class='ing' >신청</span>"; } 
					else if(full.apprvFlag == "Y") { return "<span class='comp'>승인</span>"; } 
					else if(full.apprvFlag == "J") { return "<span class='reject'>거절</span>"; }						
				}}
				, {"targets":[10], "render": function(data,type,full){
					return "<a type='button' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.reqUserSeq+"\")'><i class='fa fa-search'></i></a>";
				}}
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

	function moveDetailPage(reqUserSeq){		
		location.href = "${contextPath}/mng/req/user/viewApprovalPage?reqUserSeq="+reqUserSeq;
	}
	
	function excelDown(){
	    var params = "";
	    params += "&searchKind=" + $("#searchKind option:selected").val();
	    params += "&keyword=" + $("#keyword").val();
	    location.href =  '${contextPath}/mng/req/user/excel?'+params;
	}
	
	$(document).ready(function() {
		App.init();
		gridList();
		
		//메뉴활성화
		$("#req").addClass("active");
		$("#userApprove").addClass("active");
	});
</script>
</body>
</html>