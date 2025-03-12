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
				<h1>FAQ</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">사용문의</a><a href="#" class="on">FAQ</a>
				</div>
			</div>
			<!-- end header -->
			
			<div class="row pb50">
				
				<!-- search begin -->
				<div class="page_searchBox">
					<div class="searchArea">
						<div class="selectBox">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel width-150" id="searchKind">
								<option value="customer_name">고객사명</option>
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
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
						<table id="noticeBbsList" class="tableWrap">
							<colgroup>
								<col width="15%">
								<col width="*">
								<col width="12%">
								<col width="10%">
								<col width="6%">
							</colgroup>
							<thead>
								<tr>
									<th>분류</th>
									<th>질문</th>
									<th>작성일시</th>
									<th>작성자</th>							
                                    <th>상세</th>								
                               </tr>
							</thead>
						</table>
				
					<!-- faq 종료 -->
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
 	
	function moveDetailPage(faqNo){
	location.href = "${contextPath}/mng/bbs/faq/view?faqNo="+faqNo;
	}
	
	function moveInsertPage(){
		location.href = "${contextPath}/mng/bbs/faq/write";
	}
 	
 	
	$(document).ready(function() {
      //조회추가
		gridList();
		App.init();
		
		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsFaq").addClass("active");

	});

	function gridList() {
		 $("#noticeBbsList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/bbs/faq/list"
				,"type" : "POST"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[ 
	        	{"data":"faqType"}
	        	, {"data":"title", "class":"tal name"}
	        	, {"data":"regDatetime2", "class":"name"}
	        	, {"data":"regUserId", "class":"name"}
	        	, {}
	        	
			],"columnDefs":[
				 {"targets":[4], "render": function(data,type,full){
					return "<a href='javascript:void(0);' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.faqNo+"\")'><i class='fa fa-search'></i></a>";
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

	
</script>

</body>
</html>