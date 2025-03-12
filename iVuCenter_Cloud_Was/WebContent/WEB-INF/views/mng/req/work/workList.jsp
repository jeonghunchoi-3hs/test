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
				<h1>작업 요청 처리</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">승인/작업 처리</a><a href="#" class="on">작업 요청 처리</a>
				</div>
			</div>
			<!-- end header -->

            <input type="hidden" id="cloudSearchId" value="${getCloudList[0].cloudId}">

			<!-- begin page-body -->
			<div class="row pb50">
				<input type="hidden" id="myWorkYn" value="${myWorkYn}">

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
								<option value="projectName">프로젝트명</option>
								<option value="serviceName">서비스명</option>
								<option value="workUserName">작업자</option>
							</select>
						</div>
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="" class="width-600 ml5">
							<a type='button' class="bton-s bton_blue" onclick="gridList();"><i class="fa fa-search"></i> 검색</a>
					</div>
				</div>


					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i> <span> 엑셀  다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->

						<table id="mngProjectList" class="tableWrap">
							<colgroup>
								<col width="80px">
								<col width="140px">
								<col width="*">
								<col width="240px">
								<col width="120px">
								<col width="120px">
								<col width="140px">
								<col width="140px">
								<!--<col width="10%">-->
								<col width="80px">
							</colgroup>
							<thead>
								<tr>
									<th>작업유형</th>
									<th>카탈로그유형</th>
									<th>프로젝트명</th>
									<th>서비스명</th>
									<th>작업상태</th>
									<th>작업자</th>
									<th>등록일시</th>
									<th>완료일시</th>
									<!-- <th>과금적용일시</th> -->
									<th>상세</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>

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
		$("#cloudSearchId").val(cloudId);
	  gridList();
	}

	function gridList() {
		$("#mngProjectList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/req/work/worklist"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.searchAll = $("input:radio[name='searchAll']:checked").val()
					d.userId = '${userId}'
				}
			}
			,"columns":[
			        	  {"data":"requestTypeName"}
			        	, {"data":"productCategoryName"}
			        	, {"data":"projectName", "class":"tal overflow-path"}
			        	, {"data":"serviceName", "class":"tal overflow-path"}
			        	, {"data":"workState"}
			        	, {"data":"workUserName"}
			        	, {"data":"regDatetime2"}
			        	, {"data":"completeDatetime2"}
			        	//, {"data":"chargeStartDatetime2", "class":"tac"}
			        	, {"class":"ditailStyle"}
			]
			,"columnDefs":[
 				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[0], "render": function(data,type,full){

 					if(data=="신규"){
	 						return "<span class='statusLabel_small status_new'>신규</span> ";
	 					}else if(full.requestTypeName=="변경"){
		 					if(full.serviceType=="snapshot"){
		 						return "<span class='statusLabel_small status_chg'>적용</span>";
			 				} else {
	 							return "<span class='statusLabel_small status_chg'>변경</span>";
			 				}
	 					}else {
	 						return "<span class='statusLabel_small status_out'>삭제</span>";
	 					}
 				}
 				},

 				{"targets":[3], "render": function(data,type,full){

 					if(full.serviceType !=null ){	return '<strong">'+full.serviceName+'</strong>';}

 					else{	return "<strong></strong>";}
 				}
 				},
				{"targets":[4], "render": function(data,type,full){

	 					if(full.workState=="Y"){
	 						return "<strong>작업완료 </strong>";
	 						//return "<strong class='fcde4e4e'>과금적용 </strong>";

	 					}else if (full.readDatetime !=undefined && full.workState=="N"){
	 						return "<strong>처리중</strong>";
	 					}else if (full.workState=="C"){
	 						return "<strong>작업완료</strong>";
	 					}else{
	 							return "<strong>처리중</strong>";
	 					}
 				}
 				} ,

 				{"targets":[8], "render": function(data,type,full){
 	 				if(full.serviceType == "loadbalancer"){
 	 					return "<a type='button' class='cbton bton_lblue' onclick='moveLoadBalanacerPage(\""+full.reqWorkSeq+"\",\""+full.workUserId+"\")'><i class='fa fa-search'></i></a>";
 	 	 			} else if(full.serviceType == "snapshot"){
 	 	 				return "<a type='button' class='cbton bton_lblue' onclick='moveSnapshotPage(\""+full.reqWorkSeq+"\",\""+full.workUserId+"\")'><i class='fa fa-search'></i></a>";
 	 	 	 		} else {
 						return "<a type='button' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.reqWorkSeq+"\",\""+full.workUserId+"\")'><i class='fa fa-search'></i></a>";
 	 	 			}
					}
				}
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[11,16], [11, 16]]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
		tblColorSet();
	}



 	function moveDetailPage(reqWorkSeq,workUserId){
		location.href = "${contextPath}/mng/req/work/workView?reqWorkSeq="+reqWorkSeq +"&workUserId="+workUserId;
 	}

 	function moveLoadBalanacerPage(reqWorkSeq,workUserId) {
 		location.href = "${contextPath}/mng/req/work/loadWorkView?reqWorkSeq="+reqWorkSeq +"&workUserId="+workUserId;
 	}

 	function moveSnapshotPage(reqWorkSeq,workUserId) {
 		location.href = "${contextPath}/mng/req/work/SnapWorkView?reqWorkSeq="+reqWorkSeq +"&workUserId="+workUserId;
 	}

 	function tblColorSet() {
		$('.gridType01 .tableWrap table thead th').each(function(index, item){
			$(item).addClass('th' + index);
		});
	}

	function excelDown(){
	    var params = "";
	    params += "&searchKind=" + $("#searchKind option:selected").val();
	    params += "&keyword=" + $("#keyword").val();
	    params += "&searchAll=" + $("input:radio[name='searchAll']:checked").val();
	    params += "&userId=${userId}";

	    location.href =  '${contextPath}/mng/req/work/excel?'+params;
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
		$("#workManage").addClass("active");

		//tab 첫번째 메뉴 활성화
		$(".nav-pills>li:first-child").addClass("active");

	});


</script>
</body>
</html>