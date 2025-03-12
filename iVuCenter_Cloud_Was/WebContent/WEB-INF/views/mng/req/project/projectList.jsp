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
				<h1>프로젝트 신청</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">작업승인처리</a><a href="#" class="on">프로젝트 신청</a>
				</div>
			</div>
			<!-- end header --> 
			<div class="row pb50"> 
			
			<!-- search begin -->
			<div class="page_searchBox m-b-15">
				<div class="searchArea">
					<div class="selectBox" style="width:130px;">
						<label class="selectText" for="searchKind">전체</label>
						<select class="search-sel" id="searchKind">
							<option value="searchAll">전체</option>
							<option value="cstmName">고객사</option>
							<option value="prjtName">프로젝트명</option>
							<option value="regUserName">신청사</option>				
						</select>
					</div>
					<div class="inputArea m-l-5">
						<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 450px">
						<a type="button" class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>
					</div>
				</div>
			</div>
			<!-- search end -->	
			<!-- 테이블시작 -->
			<div class="gridTableWrap gridType01">
				<!-- 그리드 영역 --> 
				<div class="tableWrap m-t-15">
					<!-- 상단 버튼  -->
					<div class="btnArea tar m-b-15">
						<a onclick="excelDown();" type='button' class="btnType01 m-r-5"><i class="ico_download"></i><span>다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<table id="mngProjectList">
						<colgroup>
							<col width="138px">
							<col width="120px">
							<col width="*">
							<col width="118px"> 
							<col width="86px">
							<col width="74px">
							<col width="150px">
							<col width="65px">
						</colgroup>
						<thead>
						    <tr class="grey">
						    	<th class="tac">구분</th>
						    	<th class="tac">고객사</th>
								<th class="tac">프로젝트명</th>
								<th class="tac">고객사 관리자</th>
								<th class="tac">담당PM</th>
								<th class="tac">상태</th>
								<th class="tac">신청일시</th>
								<th class="tac">상세</th>
						    </tr>
						</thead>
					</table>
				</div>
			</div>
			<!-- 테이블 끝 -->
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
	function gridList() {
		 $("#mngProjectList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/req/project/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[
			        	{"data":"upCompanyName", "class":"tal"}
			        	, {"data":"customerName", "class":"tal"}
			        	, {"data":"projectAlias","class":"tal name"}
			        	, {"data":"adminName", "class":"tac"}
			        	, {"data":"regUserName", "class":"tac"}
			        	, {"data":"completeFlag", "class":"tac"}
			        	, {"data":"regDatetime2", "class":"tac fontVdn"}
			        	, {"class":"tac"}  
			]
			,"columnDefs":[
 				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[5], "render": function(data,type,full){
 					if(full.completeFlag == "완료"){ 
 						return "<span href='javascript:void(0);' class='comp' >"+full.completeFlag+"</span>";
					}else{
						return "<span href='javascript:void(0);' class='ing' >"+full.completeFlag+"</span>";
					}
 					
					
					} 
				}
 				, {"targets":[7], "render": function(data,type,full){
					return "<a href='javascript:void(0);' class='btn_viewDetail'   onclick='moveDetailPage(\""+full.reqProjectSeq+"\")'></a>";
					} 
				} 
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>',"oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {
						//moveInsertPage();
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
	
 	function moveDetailPage(reqProjectSeq){
		location.href = "${contextPath}/mng/req/project/projectWorkCompletePage?reqProjectSeq="+reqProjectSeq;
 	}
 	
 	function moveInsertPage(){
 		location.href = "${contextPath}/mng/bbs/notice/write";	
 	}
	
	$(document).ready(function() {
		App.init();
		gridList();
		
		//메뉴활성화
		$("#request").addClass("active");
		$("#reqProject").addClass("active");  

	});
</script>
</body>
</html>