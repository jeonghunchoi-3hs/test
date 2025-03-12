<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="roles" property="principal.roles" />
</sec:authorize>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
		<title>KEPCO Cloud Service Platform</title>
	</head>

	<body>
		<!-- begin #page-container -->
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">

			<!-- begin #header -->
			<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->

			<!-- begin #sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #content -->
			<div id="content" class="content">
				 <p class="page_title">서비스
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원현황  <span class="arrow_ab"> &#8227; </span> <b><a href="${wasPath}/mbr/project/service/">서비스</a> </b>
			    </span>
				</p>

				<!-- begin page-body -->
				<div class="row p20 bgwh br10">
					<!-- <p class="page_title"><span class="stick">서</span>비스 </p>

					search begin
					<div class="col-md-12 br5 p30 mb20 bgee">
							<div class="selectBoxAr">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel" id="searchKind">
										<option value="searchAll">전체</option>
									<option value="project_alias">프로젝트명</option>
									<option value="project_name">프로젝트ID</option>

								</select>
							</div>
							<div class="searchBoxAr">
								<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
								<button type="button" class="btn_search2"  onclick="gridList()"><span></span></button>
							</div> -->


					<!-- search begin -->
					<div class="col-md-12 br5 p30 mb20 bgee">
						<div class="selectBoxAr">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel" id="searchKind">
									<option value="searchAll">전체</option>
								<option value="project_ name">프로젝트ID</option>
								<option value="project_alias">프로젝트명</option>
							</select>
						</div>
						<div class="search-box">
							<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
							<button type="button" class="btn_search2"  onclick="gridList()"><span></span></button>
						</div>
					</div>
					<!-- search end -->

					<!-- search end -->
					<!-- 테이블시작 -->

						<!-- 상단 버튼  -->
						<div class="tar" style="margin-bottom:-20px;">
							<a onclick="excelDown();" type='button' class="btn_navy-s"><img src="${apachePath}/resources/assets/img/icon_down.svg" height="18px;"/>  엑셀 다운로드</a>
						</div>
						<!-- //상단 버튼  -->
						<!-- 그리드 영역 -->

							<table id="table-list-service" class="tableV">
								<colgroup>
									<col width="160px">
									<col width="160px">
									<col width="140px">
									<col width="140px">
									<col width="*">
									<col width="100px">
									<col width="140px">
									<col width="120px">
									<col width="80px">
								</colgroup>
								<thead>
									<tr>
										<th>본부</th>
										<th>처(실)</th>
										<th>부서</th>
										<th>프로젝트ID</th>
										<th>프로젝트명</th>
										<th>담당자</th>
										<th>전화번호(사선)</th>
										<th>서비스자원(EA)</th>
										<th>상세</th>
									</tr>
								</thead>
							</table>


					<!-- 테이블 끝 -->
				</div>
				<!-- end page-body -->

				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->

	<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

	<script type="text/javascript">

				function gridList() {
					$("#table-list-service").dataTable( {
						"processing": true
						,"autoWidth": false
						,"serverSide": true
						,"ordering": false
						,"destroy" : true
						,"ajax": {
							"url":"${contextPath}/mbr/oss/project/mbrList"
							,"type" : "GET"
							,"data":function (d) {
								//d.searchKind = $("#searchKind option:selected").val();
								d.searchKind = $("#searchKind").val();
								d.keyword = $("#keyword").val();
								d.customerId = "";

							}
						}
						,"columns":[
							{"data":"deptName" , "class":""}
							, {"data":"deptName" , "class":""}
							, {"data":"deptName" , "class":""}
							, {"data":"projectName" , "class":""}
							, {"data":"projectAlias" , "class":"tal"}
							, {"data":"managerName" , "class":""}
							, {"data":"managerTelEx" , "class":""}
							, {"data":"serviceCnt" , "class":"tac","render":function (data,type,full,meta){
								return addcomma(data);
							}}
					        , {"class":"tac", "width":"65px"}
						]
						,"columnDefs":[
							{"defaultContent" : "", targets:"_all" }
							, {"targets":[0], "render": function(data,type,full){
								return full.deptName2.split("/")[1];
								}
							}
							, {"targets":[1], "render": function(data,type,full){
								return full.deptName2.split("/")[2];
								}
							}
							, {"targets":[2], "render": function(data,type,full){
								return full.deptName2.split("/")[3];
								}
							}
							, {"targets":[8], "render": function(data,type,full){
								return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='movePageDetail(\""+full.projectBoxId+"\",\""+full.projectId+"\",\""+full.projectName+"\",\""+full.programSeq+"\",\""+full.cloudName+"\")'><i class='fa fa-search'></i></a>";
								}
							}
						]
						,"language": {
							"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
							, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
						}
						,"sDom":'<"top"i>rt<"bottom"p>'
					});
					tblColorSet();
				}
				function tblColorSet() {
					$('.gridType01 .tableWrap table thead th').each(function(index, item){
						$(item).addClass('th' + index);
					});
				}
				function movePageDetail(projectBoxId, projectId, projectName, programSeq, cloudName){
					var params = "?projectBoxId="+projectBoxId;
					params += "&projectId="+projectId;
					params += "&projectName="+projectName;
					params += "&programSeq="+programSeq;
					location.href = "${contextPath}/mbr/project/service/serviceView"+params;
				}

				function moveInsertPage(){
					location.href = "${contextPath}/mng/project/disk/write";
				}

				function excelDown(){
				    var params = "";
				    params += "&searchKind=" + $("#searchKind").val();
				    params += "&keyword=" + $("#keyword").val();
				    params += "&customerId=";
				    location.href =  '${contextPath}/mbr/oss/project/mbrOssServiceExcel?'+params;
				}

				$(document).ready(function() {
					App.init();
					gridList();


					$("#searchKind").val("searchAll");
					//메뉴활성화
					$("#myGoods").addClass("active");
					$("#myService").addClass("active");

				});

				const label = document.querySelector('.kep-label');
				const options = document.querySelectorAll('.optionItem');
				const handleSelect = function(item) {
				  label.innerHTML = item.innerText;
				  label.parentNode.classList.remove('active');
				  document.querySelector("#searchKind").value = item.getAttribute("value");
				}
				for( let i = 0; i < options.length; i++ ){
				  options[i].addEventListener('click', function(){handleSelect(this)})
				}

				label.addEventListener('click', function(){
				  if(label.parentNode.classList.contains('active')) {
				    label.parentNode.classList.remove('active');
				  } else {
				    label.parentNode.classList.add('active');
				  }
				});


		</script>
	</body>
</html>