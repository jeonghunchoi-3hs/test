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

	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in hide"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
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
				<h1>계열사 관리</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책 관리</a><a href="#" class="on">계열사 관리</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<!-- search begin -->
				<div class="page_searchBox m-b-15">
					<div class="searchArea">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="company_name">구분</option>				
								<option value="customer_name">계열사명</option>				
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 450px">
							<a type='button' class="btn_search" onclick="gridList()">검색</a>
						</div>
					</div>
				</div>
				<!-- search end -->
				
				
				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a type="button" class="btnType01 m-r-5" onclick="excelDown();"><i class="ico_download"></i><span>다운로드</span></a>
						<a type="button" class="btnType01" onclick="moveInserPage();"><i class="ico_write"></i><span>등록</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-15" >
						<table id="table-list" summary="계열사관리">
						<caption>게시판 목록 : 구분, 계열사명, 등록일시, 등록자, 수정 구성</caption> 
							<colgroup>
								<col width="244px">
								<col width="295px">
								<col width="219px">
								<col width="148px">
								<col width="67px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">구분</th>
									<th scope="col">계열사명</th>
									<th scope="col">등록일시</th>
									<th scope="col">등록자</th>
									<th scope="col">수정</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			
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
		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/company/affilatelist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[ 
				 {"data":"upCompanyName" , "class":"tal p-l-30"}
				, {"data":"companyName" , "class":"tal name"}
				, {"data":"regDatetime" , "class":"tac fontVdn"}
				, {"data":"regUserName" , "class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[4], "render": function(data,type,full){
					return '<a href="javascript:moveDetailPage(\''+full.companyId+'\');" class="btn_edit" onclick="moveDetailPage()"></a>';
					} 
				}
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"ip>' 
		});
		tblColorSet();
	}
	function tblColorSet() {
		$('.gridType01 .tableWrap table thead th').each(function(index, item){
			$(item).addClass('th' + index);
		});
	}
	function moveDetailPage(companyId){
		var params = "";
		params += "companyId="+companyId;
		location.href="${contextPath}/mng/cmm/company/edit?"+params;
	}
	function moveInserPage(){
		location.href="${contextPath}/mng/cmm/company/write";
	}
	function excelDown(){
		var params = "";
		params += "&searchKind="+$("#searchKind option:selected").val();
		params += "&keyword="+$("#keyword").val();
		
		location.href = '${contextPath}/mng/cmm/company/excel?'+params;
	}	
	
	$(document).ready(function() {
		App.init();
		gridList();
		
		//메뉴활성화
		$("#operation").addClass("active");
		$("#cmmCompany").addClass("active");
	});
</script>
</body>
</html>