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
	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

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
				<h1>보정</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">요금 관리</a><a href="#" class="on">보정</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">

				<div class="page_searchBox m-b-15">
					<div class="selectBox" style="width:120px;">
						<label class="selectText">전체</label>
						<select class="search-sel" id="billYyyy">
							<option value="">전체</option>
							<c:forEach items="${getBillYyyy}" var="list" varStatus="status" >
								<option value="${list.billYyyy}">${list.billYyyy}</option>
							</c:forEach>
						</select>
					</div>
					<span class="selectTxt m-r-10">년</span>
					<div class="selectBox m-l-5" style="width:120px;">
						<label class="selectText">전체</label>
						<select class="search-sel" id="billMm">
							<option value="">전체</option>
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
					</div>
					<span class="selectTxt">월</span>
					<div class="searchArea m-l-30">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="customer_name">고객사명</option>
								<option value="user_name">사용자명</option>
							</select>
						</div>
						<div class="inputArea">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 298px">
							<a type="button" class="btn_search" onclick="gridList()">검색</a>
						</div>
					</div>
				</div>
				<!-- //search Box -->

				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a type="button" class="btnType01 m-r-5" onclick="excelDown();"><i class="ico_download"></i><span>다운로드</span></a>
						<a type="button" class="btnType01" onclick="moveInsertPage();"><i class="ico_write"></i><span>등록</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-15">
						<table id="table-list" summary="보정">
							<caption>게시판 목록 : 고객사, 프로젝트명, 보정내역, 청구년월, 보정금액, 보정율, 작성일시로 구성</caption>
							<colgroup>
								<col width="126">
								<col width="166">
								<col width="149">
								<col width="93">
								<col width="112">
								<col width="102">
								<col width="158">
								<col width="67">
							</colgroup>
							<thead>
								<tr>
									<th class="tac">회원사명</th>
									<th class="tac">프로젝트명</th>
									<th class="tac">보정내역</th>
									<th class="tac">청구년월</th>
									<th class="tac">보정금액</th>
									<th class="tac">보정율</th>
									<th class="tac">작성일시</th>
									<th class="tac">상세</th>
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
			"processing":true
			,"ordering" : false
			,"destroy" : true
			,"autoWidth":false
			,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/bss/adjustment/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind > option:selected").val();
					d.keyword = $("#keyword").val();
					d.billYyyy = $("#billYyyy > option:selected").val();
					d.billMm = $("#billMm > option:selected").val();
				}
			}
			,"columns":[
						{"data":"customerName", "class":"tal"}
			        	, {"data":"projectAlias", "class":"tal name"}
			        	, {"data":"adjustContents", "class":"tal"}
			        	, {"data":"billYyyymm", "class":"fontVdn"}
			        	, {"data":"absamount","class":"fontVdn tar p-r-5"}
			        	, {"data":"absrate","class":"fontVdn tar p-r-5"}
			        	, {"data":"regDatetime", "class":"fontVdn"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[4], "render": function(data,type,full){
						var absamount = full.absamount.indexOf("%")>0? full.absamount: addcomma(full.absamount);
						if(absamount.indexOf("-")){
							return "<span class='txtBlue'>"+absamount+"</span>";
						}else{
							return "<span class='txtRed'>"+absamount+"</span>";
						}
					}
				}
				, {"targets":[5], "render": function(data,type,full){
						var absrate = full.absrate.indexOf("%")>0? full.absrate: addcomma(full.absrate);
						if(absrate.indexOf("-")){
							return "<span class='txtBlue'>"+absrate+"</span>";
						}else{
							return "<span class='txtRed'>"+absrate+"</span>";
						}
					}
				}
				, {"targets":[7], "render": function(data,type,full){
					return '<a type="button" class="btn_viewDetail" onclick="moveDetailPage(\''+full.adjustSeq+'\');"></a>';
					}
				}
			]
			//,"order": [[6,"asc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
		tblColorSet();
	}

	function moveDetailPage(adjustSeq){
		location.href = "${contextPath}/mng/bss/adjustment/view?adjustSeq="+adjustSeq;
 	}

	function moveInsertPage(){
		location.href = "${contextPath}/mng/bss/adjustment/write";
	}

	function excelDown(){
		var params = "";
		params += "&searchKind="+$("#searchKind option:selected").val();
		params += "&keyword="+$("#keyword").val();
		params += "&billYyyy="+$("#billYyyy > option:selected").val();
		params += "&billMm="+$("#billMm > option:selected").val();

		location.href = '${contextPath}/mng/bss/adjustment/excel?'+params;
	}

	$(document).ready(function() {
		gridList();
		App.init();

		//메뉴활성화
		$("#chargeManagement").addClass("active");
		$("#adjustment").addClass("active");

	});
</script>
</body>
</html>