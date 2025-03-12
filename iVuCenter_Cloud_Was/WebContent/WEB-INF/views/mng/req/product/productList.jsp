<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
	<sec:authorize var="isAdmin" access="hasAnyRole('ROLE_CLOUD_ADMIN')" />
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
			<!-- begin #page-container > header -->
			<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->

			<!-- begin #page-container > sidebar -->
			<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #page-container > content -->
			<div id="content" class="content">
				<!-- begin #page-container > content > header -->
				<div class="page_header mb30">
					<h1>자원신청 승인</h1>
					<div class="pageNav">
						<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">승인/작업 처리</a><a href="#" class="on">자원신청 승인</a>
					</div>
				</div>
				<input type="hidden" id="cloudSearchId" value="${getCloudList[0].cloudId}">
				<!-- end #page-container > content > header -->
				<input type="hidden" id="myWorkYn" value="${myWorkYn}">

				<!-- begin #page-container > content > page-body -->
				<div class="row pb50">
					<div class="page_searchBox">
						<div class="optionBox mr10">
							<input type="hidden" id="h_cloudSearchId" value="${req.getCloudId() == null ? getCloudList[0].cloudId : req.getCloudId()}">
							<input type="hidden" id="h_cloudSearchName" value="${req.getCloudName() == null ? getCloudList[0].cloudName : req.getCloudName()}">
							<label><input type="radio" name="searchAll" value="my" data-original-title="" title="" checked="checked"><span>내작업</span></label>
							<label><input type="radio" name="searchAll" value="all" data-original-title="" title=""><span>전체</span></label>
						</div>
						<div class="searchArea">


							<div class="selectBox">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel width-150" id="searchKindStatus">
									<option value="searchAll">전체</option>
									<option value="APPRV_UNASSIGNED">미지정</option>
									<option value="APPRV_PROCESSING">처리중</option>
									<option value="PROVISIONING_FAIL">작업실패</option>
									<option value="APPRV_REJECTED">반려</option>
									<option value="APPRV_COMPLETED">완료</option>
								</select>
							</div>




							<div class="selectBox">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel width-150" id="searchKind">
									<option value="searchAll">전체</option>
									<option value="orderUserName">신청자</option>
									<option value="customerName">회원사</option>
									<option value="projectName">프로젝트명</option>
									<option value="orderNo">신청번호</option>
								</select>
							</div>
								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
								<a type="button" class="bton-s bton_blue" onclick="gridList();"><i class="fa fa-search"></i>  검색</a>
						</div>
					</div>


						<!-- 상단 버튼  -->
						<div class="btnArea tar mb5">
							<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i> <span> 엑셀  다운로드</span></a>
						</div>
						<!-- //상단 버튼  -->
						<!-- 그리드 영역 -->

							<table id="mngProductList" class="tableWrap">
								<colgroup>
									<col width="12%">
									<col width="*">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="8%">
									<col width="6%">
									<col width="6%">
									<col width="6%">
									<col width="10%">
									<col width="6%">
								</colgroup>
								<thead>
									<tr>
										<th>신청번호</th>
										<th>프로젝트명</th>
										<th>본부</th>
										<th>처(실)</th>
										<th>부서</th>
										<th>승인단계</th>
										<th>신규(EA)</th>
										<th>변경(EA)</th>
										<th>삭제(EA)</th>
										<th>신청자</th>
										<th>상세</th>
									</tr>
								</thead>
							</table>

				</div>
				<!-- end #page-container > content > page-body -->

				<!-- begin #page-container > content > footer -->
				<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #page-container > content > footer -->

			</div>
			<!-- end #page-container > content -->
		</div>
		<!-- end #page-container -->

		<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">

			function cloudSearchId(cloudId){
				$("#cloudSearchId").val(cloudId);
			  gridList();
			}

			function gridList() {
				 $("#mngProductList").dataTable( {
						"processing":true
						,"ordering" : false
						,"destroy" : true
						,"autoWidth":false
						,"serverSide":true
					,"ajax": {
						"url":"${contextPath}/mng/req/product/list"
						,"type" : "GET"
						,"dateSrc" : ""
						,"data":function (d) {
							d.searchKind = $("#searchKind option:selected").val();
							d.searchKindStatus = $("#searchKindStatus option:selected").val();
							d.keyword = $("#keyword").val();
							d.searchAll = $("input:radio[name='searchAll']:checked").val();
							d.userId = '${userId}';
							d.isAdmin = '${isAdmin}';
							d.cloudId = $("#cloudSearchId").val();
						}
					}
				 ,"columns":[
						{"data":"orderNo"}
						, {"data":"projectName","class":"tal name"}
						, {"data":"deptName","class":"tal"}
						, {"data":"deptName","class":"tal"}
						, {"data":"deptName","class":"tal"}
						, {"data":"apprvState"}
						, {"data":"newCnt","class":"tar"}
						, {"data":"changeCnt","class":"tar"}
						, {"data":"exprCnt","class":"tar"}
			        	, {"data":"orderUserName"}
			        	, {}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[2], "render": function(data,type,full){
							return full.deptName2.split("/")[1];
							}
						}
						, {"targets":[3], "render": function(data,type,full){
							return full.deptName2.split("/")[2];
							}
						}
						, {"targets":[4], "render": function(data,type,full){
							return full.deptName2.split("/")[3];
							}
						}
						, {"targets":[5], "render": function(data,type,full){
			 					if(data=="APPRV_PROCESSING") {
			 						return "<span class='ing'>처리중</span> ";
			 					} else if(data=="APPRV_COMPLETED") {
			 						if(full.provisioningStatus == "PROVISIONING_FAIL"){
					 					return "<span class='notarget'>작업실패</span>";
					 				}
			 						return "<span class='comp'>완료</span>";
			 					} else if (full.apprvState == "APPRV_UNASSIGNED") {
									return "<span class='notarget'> 미지정 </span>";
								} else if(data=="APPRV_REJECTED") {
			 						return "<span class='reject'>반려</span>";
			 					}

							}
						}
						, {"targets":[10], "render": function(data,type,full){
							return "<a href='javascript:void(0);' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.orderNo+"\", \""+full.cloudId+"\")'><i class='fa fa-search'></i></a>";
							}
						}

					]
					,"order": [[0,"desc"]]
					,"lengthMenu": [[11,16], [11, 16]]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					}
					,"sDom":'<"top">rt<"bottom"pi>',"oTableTools": {
						"aButtons":[ {
							"sExtends":"text"
							,"sButtonText":"등록"
							,"fnClick":function(nButton,oConfig,oFlash) {

							}
						}]
					}
				});
				 tblColorSet();
			}

			function tblColorSet() {
				$('.gridType01 .tableWrap table thead th').each(function(index, item){
					$(item).addClass('th' + index);
				});
			}
		 	function moveDetailPage(orderNo, cloudId){
				location.href = "${contextPath}/mng/req/product/view?orderNo="+orderNo + "&cloudId="+ cloudId;
		 	}

			function excelDown(){

				var params = "searchKind="+$("#searchKind option:selected").val();
				params += "&keyword="+$("#keyword").val();
				params += "&searchAll="+$("input:radio[name='searchAll']:checked").val();
				params += "&userId=${userId}";
				params += "&isAdmin=${isAdmin}"

				location.href = "${contextPath}/mng/req/product/excel?"+params;
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
				$("#productManage").addClass("active");
			});
		</script>
	</body>
</html>