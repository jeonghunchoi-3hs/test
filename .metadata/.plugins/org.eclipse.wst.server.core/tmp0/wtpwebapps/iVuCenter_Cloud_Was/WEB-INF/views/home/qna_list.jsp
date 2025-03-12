<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
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

<c:import url="${contextPath}/WEB-INF/views/home/include/home_import.jsp" charEncoding="UTF-8"></c:import>

<title>KEPCO Cloud Service Platform</title>
</head>
<body>
	<div id="container">

	<!-- top menu start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_top.jsp" charEncoding="UTF-8"></c:import>	
	<!-- top menu end -->
		 
	 <div class="cimg"></div>
	  <div class="sub mb30">
	    <h3 class="subtitle"><i class="fa fa-cloud f18"></i> Q&A </h3>
		 
		<!-- search begin -->
		<div class="row bgee br10 mb10 mr0 ml0">		
			<div class="col-md-2 p10"> 
				<select class="form-control pb6" id="searchKind">
					<option value="searchAll">전체</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
				</select>
			</div>
			<div class="col-md-9 p10 ml-10">  <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/></div>
			<div class="col-md-1 p10 ml-5"><button type="button" class="btn btn-grey" onclick="gridList()"><i class="fa fa-search"></i> 검색</button></div>
		</div>	
		<!-- search end -->
		
		<!-- 테이블시작 -->
			<div class="panel">
			    <div class="mb50">
			        <table class="tableV" id="qnaBbsList">
						<colgroup>
							<col width="5%">
							<col width="10%">
							<col width="*">
							<col width="15%">
							<col width="10%">
						</colgroup>
						<thead>
						    <tr class="primary">
						        <th class="tac">순번</th>
								<th class="tac">분류</th>
								<th class="tac">제목</th>
								<th class="tac">작성일</th>
								<th class="tac">작성자</th>
						    </tr>
						</thead>
					</table>
				</div>
			</div>			
		<!-- 테이블 끝 -->
			
		 
	</div>
		
	  
	 
	 
	<div class="clear"></div>
	
	<!-- footer start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
	<!-- footer end -->
	
	
	
	</div>
	

	
</body>

<script type="text/javascript">

	function gridList() {
		 $("#qnaBbsList").dataTable( {
			"processing":true
			,"autoWidth":false
			,"ordering":false
			,"destroy" : true
			,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/homepage/qnaList"
				,"type" : "POST"
				,"dataSrc" : function(json) {
					return filterData(json.data);
				}
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.userId = "${userId}";
				}
				,"error": function (xhr, error, thrown) {
					if ( error == "parsererror" ) {
						location.reload();
					}else{
						errorBox("ajax error");
						return false;
					}
				}	
			}
			,"columns":[ 
			        	{"data":"qnaNo","class":"tac"}
			        	, {"data":"codeName", "class":"tal"}
			        	, {"data":"title", "class":"tal"}
	//		        	, {"data":"secretFlag", "class":"tac"}
			        	, {"data":"regDatetime2", "class":"tac"}
			        	, {"data":"userName", "class":"tac"}
			        	, {"data":"content", "class":"tal", "visible":false}
			        	//, {"class":"ditailStyle tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[2], "render": function(data,type,full){
						if(full.replyCnt != 0){
							return "<a href='#' onclick='moveDetailPage(\""+full.qnaNo+"\")'>" + full.title + "</a>&nbsp;&nbsp;<i class='fa fa-commenting'></i>";
						}else{
							return "<a href='#' onclick='moveDetailPage(\""+full.qnaNo+"\")'>" + full.title + "</a>";
						}	
					}
				}
//				,{"targets":[3], "render": function(data, type,full){
//						if(full.secretFlag ==='Y'){
//							full.secretFlag = "&nbsp;<i class='fa fa-lock'></i>&nbsp;";
//							return full.secretFlag;
//						}	
//					}
//				}
				//, {"targets":[6], "render": function(data,type,full){
				//	return "<button type='button' class='btn btn-grey_01' onclick='moveDetailPage(\""+full.qnaNo+"\")' ><i class='fa fa-search'></i></button>";
				//	}	
				//}
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
					, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>',"oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {
// 						moveInsertPage();
					}
				}]
			}
		});
		
	}

	function filterData(data) {
		data.forEach(item => {
			if (item.content && item.content.includes('/')) {
				item.content = null;
			}
		});
		return data;
	} 
 
 	function moveDetailPage(qnaNo){
		location.href = "${contextPath}/homepage/qnaView?qnaNo="+qnaNo;
 	}

	$(document).ready(function() {
		
		gridList();
		App.init();
		
		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsQna").addClass("active");
		
	});
</script>
</html>