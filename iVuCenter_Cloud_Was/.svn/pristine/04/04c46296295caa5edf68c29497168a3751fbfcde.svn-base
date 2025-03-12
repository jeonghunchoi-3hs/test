<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
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
				<h1 class="fontVdn">Q&A</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">고객센터</a><a href="#" class="on fontVdn">Q&A</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<div class="page_searchBox">
					<div class="searchArea">
						<div class="selectBox">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel width-150" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
						</div>
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
							<a type='button' class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>
					</div>
				</div>


					<!-- 그리드 영역 -->

						<table id="qnaBbsList" class="tableWrap">

							<colgroup>
								<col width="10%">
								<col width="*">
								<col width="5%">
								<col width="8%">
								<col width="10%">
								<col width="8%">
								<col width="8%">
							</colgroup>
							<thead>
								<tr>
									<th>분류</th>
									<th colspan="2">제목</th>
									<th>공개여부</th>
									<th>작성일시</th>
									<th>작성자</th>
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
		 $("#qnaBbsList").dataTable( {
			"processing":true
			,"autoWidth":false
			,"ordering":false
			,"destroy" : true
			,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/bbs/qna/list"
				,"type" : "POST"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.userId = "${userId}";
				}
			}
			,"columns":[
	        	  {"data":"codeName"}
	        	, {"data":"title", "class":"tal"}
	        	, {}
	        	, {"data":"secretFlag"}
	        	, {"data":"regDatetime2"}
	        	, {"data":"userName"}
	        	, {}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0], "render": function(data,type,full){
						if(full.qnaType == "CD00001"){
							return "<span class='bbsLabel billT'>사용요금</span>";
						}else if(full.qnaType == "CD00002"){
							return "<span class='bbsLabel virServer'>가상서버</span>";
						}else if(full.qnaType == "CD00003"){
							return "<span class='bbsLabel addPrdt'>부가자원</span>";
						}else if(full.qnaType == "CD00004"){
							return "<span class='bbsLabel service'>서비스</span>";
						}else{
							return "<span class='bbsLabel etc'>기타</span>";
						}
					}
				}
				, {"targets":[2], "render": function(data,type,full){
						if(full.replyCnt != 0){
							return "<span class='qna_answer'></span>";
						}else{
							return "";
						}
					}
				}

				,{"targets":[3], "render": function(data, type,full){
						if(full.secretFlag ==='Y'){
							return "<span class='qna_public'></span>";
						}else{
							return "";
						}
					}
				}
				, {"targets":[6], "render": function(data,type,full){
					return "<a type='button' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.qnaNo+"\")'><i class='fa fa-search'></i></a>";
					}
				}
			]
			,"order": [[4,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>'
			,"oTableTools": {
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


 	function moveDetailPage(qnaNo){
		location.href = "${contextPath}/mng/bbs/qna/view?qnaNo="+qnaNo;
 	}
 	/*
 	function moveInsertPage(){
 		location.href = "${contextPath}/mng/bbs/qna/write";
 	}
 	*/

	function excelDown(){
	    var params = "";
	    params += "&searchKind=" + $("#searchKind option:selected").val();
	    params += "&keyword=" + $("#keyword").val();
	    params += "&userId=${userId}";
	    location.href = '${contextPath}/mng/bbs/qna/excel?'+params;
	}

	$(document).ready(function() {

		gridList();
		App.init();

		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsQna").addClass("active");

	});
</script>
</body>
</html>