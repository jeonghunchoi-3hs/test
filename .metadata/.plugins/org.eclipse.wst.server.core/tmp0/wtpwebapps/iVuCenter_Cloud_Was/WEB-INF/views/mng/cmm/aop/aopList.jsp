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
				<h1>사용이력 조회</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">알림/접속 관리</a><a href="#" class="on">사용이력 조회</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<div class="page_searchBox m-b-15">
					<div class="searchArea">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="userId">사용자ID</option>
								<option value="userNm">사용자명</option>	
								<option value="methodName">메소드명</option>			
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 450px" data-original-title="" title="">
							<a type="button" class="bton-s bton_blue" onclick="searchList()"><i class="fa fa-search"></i>  검색</a>
						</div>
					</div>
				</div>
				<div class="gridTableWrap gridType01">

                    <!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
                   
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-15">
						<table id="noticeBbsList" summary="공지사항">
						<caption>게시판 목록 : 시간, 사용자ID, 사용자ROLE, ip, 메소드명, 타스크경로 구성</caption> 
							<colgroup>
								<col width="180px">
								<col width="90px">
								<col width="90px">
								<!-- <col width="130px">-->
								<col width="130px">
								<col width="200px">
								<col width="*">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">시간</th>
									<th scope="col">사용자ID</th>
									<th scope="col">사용자명</th>
									<!-- <th scope="col">사용자ROLE</th> -->
									<th scope="col">IP주소</th>
									<th scope="col">메소드명</th>
									<th scope="col">업무경로</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			
				<!-- begin #footer -->
				<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->
				
			</div>
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
	
<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">
	function gridList() {
		 $("#noticeBbsList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/aop/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[ 
	        	{"data":"historyDatetime", "class":"tac"}
	        	, {"data":"userId", "class":"tal name"}
	        	, {"data":"userName", "class":"tal name"}
	        	//, {"data":"userRole", "class":"tal name"}
	        	, {"data":"ip", "class":"tal name"}
	        	, {"data":"methodName", "class":"tal name"}
	        	, {"data":"taskName", "class":"tal name"}
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

	function excelDown(){
	    var params = "";
	    params += "&searchKind=" + $("#searchKind option:selected").val();
	    params += "&keyword=" + $("#keyword").val();
	    location.href = '${contextPath}/mng/cmm/aop/excel?'+params;
	}
     	
	$(document).ready(function() {
		
		gridList();
		App.init();
		
		//메뉴활성화
		$("#alarms").addClass("active");
		$("#aop").addClass("active");

	});
</script>
</body>
</html>