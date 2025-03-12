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
				<h1>라이센스 관리</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책관리</a><a href="#" class="on">클라우드 관리</a>
				</div>
			</div>

			<div class="row pb50">

				<!-- search begin -->
				<div class="page_searchBox">
					<div class="searchArea">
						<div class="selectBox">
						   <label class="selectText" for="searchKind">전체</label>
							<select class="search-sel width-150" id="searchKind">
								<option value="">전체</option>
								<option value="cloudId">클라우드ID</option>
								<option value="cloudType">클라우드TYPE</option>
							</select>
						</div>
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
							<a type='button' class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>
					</div>
				</div>
				<!-- search end -->

				<!-- 테이블시작 -->

					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a type="button" class="bton-s bton_blue" onclick="moveInsertPage();"><i class="fa fa-upload"></i><span> 등록</span></a>
					</div>

						<table id="cloudList" class="tableWrap">
							<colgroup>
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="80px">
							</colgroup>
							<thead>
								<tr>
									<th>라이센스명</th>
									<th>등록가능 수량</th>
									<th>사용량</th>
									<th>사용가능</th>
									<th>등록일</th>
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
	function moveDetailPage(cloudId){
		location.href = "${contextPath}/mng/cmm/license/view?licenseId="+cloudId;
	}

	function moveInsertPage(){
		location.href = "${contextPath}/mng/cmm/license/write";
	}

	$(document).ready(function() {
        //조회추가
		gridList();
		App.init();
		//메뉴활성화
		$("#operation").addClass("active");
		$("#ossLicense").addClass("active");

	});

	function gridList() {
		 $("#cloudList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/license/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[
	        	{"data":"licenseName", "class":"name"}
	        	, {"data":"licenseAvail", "class":"name"}
	        	, {"data":"licenseUse", "class":"name"}
	        	, {}
	        	, {"data":"licenseRegdate", "class":"name"}
	        	, {}

			],"columnDefs":[
				{"targets":[3], "render": function(data,type,full){
					var useAvail = full.licenseAvail - full.licenseUse;
					return useAvail;
					}
				}
				,{"targets":[5], "render": function(data,type,full){
					return "<a href='javascript:void(0);' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.licenseId+"\")'><i class='fa fa-search'></i></a>";
					}
				}
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});

	}

</script>
</body>
</html>