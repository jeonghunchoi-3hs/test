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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer">

		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->

		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->

		<!-- begin #content -->
		<div id="content" class="content">


			<!-- begin header -->
			<div class="page_header mb30 mt10">
				<h1>템플릿 관리</h1>
				<div class="pageNav">
						<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">알림/접속 관리</a><a href="#" class="on">템플릿 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">

			      <div class="row">
                        <!-- begin nav-pills -->
                        <ul class="nav nav-pills" id="tabNavi">
                            <li class="active" id="smsTemp"><a href="#nav-pills-tab-1"  data-toggle="tab" onclick="initSearch(); smsTempGridList();">SMS</a></li>
                            <li class="ml10" id="mailTemp"><a href="#nav-pills-tab-2" data-toggle="tab" onclick="initSearch(); mailTempGridList();">이메일</a></li>
                        </ul>
                        <!-- end nav-pills -->

                        <!-- search -->
                   <div class="page_searchBox mt10">
					<div class="searchArea">
					<input type="hidden" id="h_searchGubun" value="${tempGubun}">
						<div class="selectBox">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel width-150" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="tempId">템플릿ID</option>
								<option value="title">제목</option>
							</select>

						</div>
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)searchList();" class="width-600 ml5">
							<a type="button" class="bton-s bton_blue" onclick="searchList();"> <i class="fa fa-search"></i> 검색</a>
					</div>
				   </div>
				    <!-- search -->
					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->

                   <!-- begin tab-content -->
                   <div class="tab-content pl0 pr0">
                      <div class="tab-pane fade active in" id="nav-pills-tab-1">
                 				<!-- 1번내용 -->
                       </div>
                       <div class="tab-pane fade" id="nav-pills-tab-2">
                          	<!-- 2번내용 -->
                       </div>

					<!-- 그리드 영역 -->

						<table id="table-list" summary="알림관리 템플릿" class="tableWrap">
						<caption>게시판 목록 : 템플릿 ID, 제목, 등록자, 등록일시, 상세로 구성</caption>
							<colgroup>
								<col width="143px">
								<col width="*">
								<col width="172px">
								<col width="178px">
								<col width="67px">
							</colgroup>
							<thead>
								<tr>
									<th>템플릿 ID</th>
									<th>제목</th>
									<th>등록자</th>
									<th>등록일시</th>
									<th>상세</th>
								</tr>
							</thead>

						</table>

                        </div>
                        <!-- end tab-content -->
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

	function smsTempGridList() {
		$("#h_searchGubun").val("sms");

		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/sms/template/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[
				 {"data":"templateId" , "class":"tac fontVdn"}
				, {"data":"title" , "class":"tal name "}
				, {"data":"userName" , "class":"tac"}
				, {"data":"modDatetime2" , "class":"tac fontVdn"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[4], "render": function(data,type,full){
					return "<a href='#' class='cbton bton_lblue' onclick='movePageDetail(\""+full.templateId+"\",\"sms\")'><i class='fa fa-search'></i></a>";
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

	function mailTempGridList() {

		$("#h_searchGubun").val("mail");

		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/mail/template/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[
				{"data":"templateId" , "class":"tac fontVdn"}
				, {"data":"title" , "class":"tal name"}
				, {"data":"userName" , "class":"tac"}
				, {"data":"modDatetime2" , "class":"tac fontVdn"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[4], "render": function(data,type,full){
					return "<a href='#' class='cbton bton_lblue' onclick='movePageDetail(\""+full.templateId+"\",\"mail\")'><i class='fa fa-search'></i></a>";
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


	function nhwithTempGridList() {

		$("#h_searchGubun").val("nhwith");

		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/nhwith/template/nhwithTemplatelist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[
				{"data":"templateId" , "class":"tac fontVdn"}
				, {"data":"title" , "class":"tal name"}
				, {"data":"userName" , "class":"tac"}
				, {"data":"modDatetime2" , "class":"tac fontVdn"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[4], "render": function(data,type,full){
					return "<a href='#' class='btn_viewDetail' onclick='movePageDetail(\""+full.templateId+"\",\"nhwith\")'></a>";
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

	function searchList(){
		var searchGubun = $("#h_searchGubun").val();

		if(searchGubun=="mail"){
			$('#tabNavi a[href="#nav-pills-tab-2"]').tab('show')
			mailTempGridList();
		}else{
			$('#tabNavi a[href="#nav-pills-tab-1"]').tab('show')
			smsTempGridList();
		}
	}

	function movePageDetail(templateId, tempGubun){
		var params = "?templateId="+templateId+"&tempGubun="+tempGubun;
		location.href = "${contextPath}/mng/alarms/template/view"+params
	}

	function initSearch(){
		$("#searchKind option[value='searchAll']").attr("selected", "selected");
		$("#searchKind").siblings(".selectText").text($("#searchKind").children('option:selected').text());
		$("#keyword").val("");
	}

	function excelDown(){
		var params = "";
		params += "&searchKind="+$("#searchKind option:selected").val();
		params += "&keyword="+$("#keyword").val();

		var searchGubun = $("#h_searchGubun").val();

		if(searchGubun=="mail"){
			location.href = '${contextPath}/mng/mail/template/excel?'+params;
		}else{
			location.href = '${contextPath}/mng/sms/template/excel?'+params;
		}
	}

	$(document).ready(function() {
		App.init();

		searchList();

		//메뉴활성화
		$("#alarms").addClass("active");
		$("#template").addClass("active");

	});
</script>
</body>
</html>