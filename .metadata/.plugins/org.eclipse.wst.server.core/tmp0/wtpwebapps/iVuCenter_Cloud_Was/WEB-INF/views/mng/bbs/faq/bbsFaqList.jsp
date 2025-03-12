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
	<link href="${contextPath}/resources/assets/css/nhstyle.css" rel="stylesheet" />
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
			
			
			<!-- begin page-body -->
			<div class="row pb50">
			
			<!-- search begin -->
			<div class="col-md-12 bgee br10 mb10">		
				<div class="col-md-2 p10"> 
					<select class="form-control pb6" id="searchKind">
						<option value="searchAll">전체</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
					</select>
				</div>
				<div class="col-md-9 p10 ml-10">  <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword"  onkeypress="if(event.keyCode==13)gridList();"/></div>
				<div class="col-md-1 p10 ml-5"><button type="button" class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</button></div>
			</div>	
			<!-- search end -->
			
			<!-- 테이블시작 -->
			<div class="col-md-12">
				<div class="panel">
				    <div class="table-responsive">
				        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="faqBbsList">
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="*">
								<col width="15%">
								<col width="10%">
								<!-- <col width="10%"> --> 
							</colgroup>
							<thead>
							    <tr class="grey">
							        <th class="tac">순번</th>
									<th class="tac">분류</th>
									<th class="tac">제목</th>
									<th class="tac">작성일</th>
									<th class="tac">작성자</th>
									<!-- <th class="tac" style="border-right:none;">상세</th> --> 
							    </tr>
							</thead>
						</table>
					</div>
				</div>			
			</div>
			<!-- 테이블 끝 -->
			
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
		 $("#faqBbsList").dataTable( {
			"processing":true
			,"autoWidth":false
			,"ordering":false
			,"destroy" : true
			,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/bbs/faq/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[ 
	        	{"data":"faqNo","class":"tac"}
	        	, {"data":"codeName", "class":"tac"}
	        	, {"data":"title", "class":"tal"}
	        	, {"data":"regDatetime2", "class":"tac"}
	        	, {"data":"regUserId", "class":"tac"}
	        	//, {"class":"ditailStyle tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[2], "render": function(data,type,full){
					return "<a href='#' onclick='moveDetailPage(\""+full.faqNo+"\")'>" + full.title + "</a>";
					}	
				}
				//, {"targets":[5], "render": function(data,type,full){
				//	return "<button type='button' class='btn btn-grey_01' onclick='moveDetailPage(\""+full.faqNo+"\")' ><i class='fa fa-search'></i></button>";
				//	}	
				//}				
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top"T>rt<"bottom"pi>',"oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {
						moveInsertPage();
					}
				}]
			}
		});
		
	}

 
 
 	function moveDetailPage(faqNo){
		location.href = "${contextPath}/mng/bbs/faq/view?faqNo="+faqNo;
 	}
 	
 	function moveInsertPage(){
 		location.href = "${contextPath}/mng/bbs/faq/write";
 	}

 	
	$(document).ready(function() {
		
		gridList();
		App.init();
		
		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsFaq").addClass("active");

	});
</script>
</body>
</html>