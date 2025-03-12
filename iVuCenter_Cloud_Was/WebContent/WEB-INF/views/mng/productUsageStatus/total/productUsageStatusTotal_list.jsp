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

			<!-- begin #page-container > content -->
			<div id="content" class="content">
				<!-- begin header -->
				<div class="page_header mb30">
					<h1>전체현황</h1>
					<div class="pageNav">
						<a type='button' class="home"><i></i></a><a href="#">자원사용현황</a><a type='button' class="on">전체현황</a>
					</div>
				</div>
				<!-- end header -->

				<!-- begin page-body -->
				<div class="row pb50">
					<!-- search begin -->
					<div class="page_searchBox ">
						<div class="searchArea">
							<div class="selectBox width-130">
								<label class="selectText" for="searchKind">전체</label>
								<select type="select" class="search-sel" id="searchKind" title="전체">
									<option value="searchAll">전체</option>
									<option value="project_alias">프로젝트명</option>
								</select>
							</div>
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
							<a type='button' class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>
						</div>
					</div>
					<!-- search end -->

					<!-- 테이블시작 -->
					<div class="gridTableWrap gridType03">
						<!-- 그리드 영역 -->
						<div class="tableWrap m-t-15">
							<div class="tar mb5">
								<a onclick="excelDown();" type="button" class="bton-s bton_blue mb10"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
								<form name="excelForm" method="post" onsubmit="return false;"></form>
							</div>

							<div class="productUsageStatus-table">
								<table id="table-list"  class="sumtableV">
									<colgroup>
										<col width="300px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
										<col width="84px">
									</colgroup>
									<thead>
										<tr>
											<th>프로젝트명</th>
											<th onclick="vmLink()" style="cursor:pointer">SERVER<br/>(EA)</th>
											<th onclick="vmLink()" style="cursor:pointer">vCPU<br/>(Core)</th>
											<th onclick="vmLink()" style="cursor:pointer">MEMORY<br/>(GB)</th>
											<th onclick="diskLink()" style="cursor:pointer">OS DISK<br/>(GB)</th>
											<th onclick="diskLink()" style="cursor:pointer">DATA DISK<br/>(GB)</th>


											<th onclick="serviceLink()" style="cursor:pointer">pv DISK<br/>(GB)</th>
											<th onclick="serviceLink()" style="cursor:pointer">nas DISK<br/>(GB)</th>



											<th onclick="serviceLink()" style="cursor:pointer">보안관제<br/>(EA)</th>
											<th onclick="serviceLink()" style="cursor:pointer">계정관리<br/>(EA)</th>
											<th onclick="serviceLink()" style="cursor:pointer">백업관리<br/>(EA)</th>
											<th onclick="serviceLink()" style="cursor:pointer">SW설치<br/>(EA)</th>
											<th onclick="serviceLink()" style="cursor:pointer">디스크관리<br/>(EA)</th>
											<th onclick="serviceLink()" style="cursor:pointer">어플리케이션<br/>(EA)</th>
											<th onclick="serviceLink()" style="cursor:pointer">POD<br/>(EA)</th>
											<th onclick="serviceLink()" style="cursor:pointer">오토스케일링<br/>(EA)</th>
											<th onclick="serviceLink()" style="cursor:pointer">컨테이너터미널<br/>(EA)</th>



										</tr>
									</thead>
									<tbody>

									</tbody>
									<tfoot>

									</tfoot>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- end page-body -->

				<!-- begin #footer -->
				<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
			<!-- end #page-container > content -->
		</div>
		<!-- end #page-container -->

		<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">

			function cloudSearchId(cloudId, cloudName) {
				$("#h_cloudSearchId").val(cloudId);
				$("#h_cloudSearchName").val(cloudName);

				gridList();
	        }

			function gridList() {
				$("#table-list").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${contextPath}/mng/productUsageStatus/total/list"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#searchKind option:selected").val();
							d.keyword = $("#keyword").val();
							d.cloudId = $("#h_cloudSearchId").val();
						}
					}
					,"initComplete" : function(setting, json){
						$("#table-list > tfoot >").remove();
						$("#table-list > tfoot").append(
								'<tr>'
									+'<td class="tac"> 합계</td>'
									+'<td class="tac" onclick="vmLink()" style="cursor:pointer">'+json.totalData.vmCnt+'</td>'
									+'<td class="tac" onclick="vmLink()" style="cursor:pointer">'+json.totalData.vcpusTotal+'</td>'
									+'<td class="tac" onclick="vmLink()" style="cursor:pointer">'+json.totalData.memTotal+'</td>'
									+'<td class="tac" onclick="diskLink()" style="cursor:pointer">'+json.totalData.osDiskTotal+'</td>'
									+'<td class="tac" onclick="diskLink()" style="cursor:pointer">'+json.totalData.dataDiskTotal+'</td>'

									+'<td class="tac" onclick="diskLink()" style="cursor:pointer">'+json.totalData.pvDiskTotal+'</td>'
									+'<td class="tac" onclick="diskLink()" style="cursor:pointer">'+json.totalData.nasDiskTotal+'</td>'

									+'<td class="tac" onclick="serviceLink()" style="cursor:pointer">'+json.totalData.secCnt+'</td>'
									+'<td class="tac" onclick="serviceLink()" style="cursor:pointer">'+json.totalData.actCnt+'</td>'
									+'<td class="tac" onclick="serviceLink()" style="cursor:pointer">'+json.totalData.backCnt+'</td>'
									+'<td class="tac" onclick="serviceLink()" style="cursor:pointer">'+json.totalData.swCnt+'</td>'
									+'<td class="tac" onclick="serviceLink()" style="cursor:pointer">'+json.totalData.diskMngCnt+'</td>'
									+'<td class="tac" onclick="serviceLink()" style="cursor:pointer">'+json.totalData.appCnt+'</td>'
									+'<td class="tac" onclick="serviceLink()" style="cursor:pointer">'+json.totalData.podCnt+'</td>'
									+'<td class="tac" onclick="serviceLink()" style="cursor:pointer">'+json.totalData.autoscalingGroupTotal+'</td>'
									+'<td class="tac" onclick="serviceLink()" style="cursor:pointer">'+json.totalData.containerTerminalTotal+'</td>'

								+'</tr>'
						);
					}
					,"columns":[
						{"data":"projectAlias" , "class":"tal"}
						, {"data":"vmCnt" , "class":"tac"}
						, {"data":"vcpusTotal" , "class":"tac"}
						, {"data":"memTotal" , "class":"tac"}
						, {"data":"osDiskTotal" , "class":"tac"}
						, {"data":"dataDiskTotal" , "class":"tac"}

						, {"data":"pvDiskTotal" , "class":"tac"}
						, {"data":"nasDiskTotal" , "class":"tac"}

						, {"data":"secCnt" , "class":"tac"}
						, {"data":"actCnt" , "class":"tac"}
						, {"data":"backCnt" , "class":"tac"}
						, {"data":"swCnt" , "class":"tac"}
						, {"data":"diskMngCnt" , "class":"tac"}
						, {"data":"appCnt" , "class":"tac"}
						, {"data":"podCnt" , "class":"tac"}
						, {"data":"autoscalingGourpCnt" , "class":"tac"}
						, {"data":"containerTerminalCnt" , "class":"tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[0], "render": function(data,type,full){
							return '<div>'+full.projectAlias+'</div>';
							}
						}
						, {"targets":[1], "render": function(data,type,full){
							return ''+full.vmCnt+'';
							}
						}
						, {"targets":[2], "render": function(data,type,full){
							return ''+full.vcpusTotal+'';
							}
						}
						, {"targets":[3], "render": function(data,type,full){
							return ''+full.memTotal+'';
							}
						}
						, {"targets":[4], "render": function(data,type,full){
							return ''+full.osDiskTotal+'';
							}
						}
						, {"targets":[5], "render": function(data,type,full){
							return ''+full.dataDiskTotal+'';
							}
						}


						, {"targets":[6], "render": function(data,type,full){
							return ''+full.pvDiskTotal+'';
							}
						}
						, {"targets":[7], "render": function(data,type,full){
							return ''+full.nasDiskTotal+'';
							}
						}


						, {"targets":[8], "render": function(data,type,full){
							return ''+full.secCnt+'';
							}
						}
						, {"targets":[9], "render": function(data,type,full){
							return ''+full.actCnt+'';
							}
						}
						, {"targets":[10], "render": function(data,type,full){
							return ''+full.backCnt+'';
							}
						}
						, {"targets":[11], "render": function(data,type,full){
							return ''+full.swCnt+'';
							}
						}
						, {"targets":[12], "render": function(data,type,full){
							return ''+full.diskMngCnt+'';
							}
						}
						, {"targets":[13], "render": function(data,type,full){
							return ''+full.appCnt+'';
							}
						}
						, {"targets":[14], "render": function(data,type,full){
							return ''+full.podCnt+'';
							}
						}
						, {"targets":[15], "render": function(data,type,full){

							return ''+full.autoscalingGourpCnt+'';
							}
						}
						, {"targets":[16], "render": function(data,type,full){

							return ''+full.containerTerminalCnt+'';
							}
						}
					]
		  			,"createdRow" : function (row, data, index){
						$(row).find('td:eq(0) div').tooltip({
		  					"delay"	:0
		  					, "track"	:true
		   					, "html"	:true
		  					, "fade"	:250
		  					, "title" : "<div class='tal'><p class='f14 m-b-5'>"+data.projectAlias+"</p><p><span>구분　　 : </span>"+(data.companyName==undefined?"":data.companyName)+"</p><p>고객사명 : "+(data.customerName==undefined?"":data.customerName)+"</p></div>"
		  				});
					}
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
							, "processing":"<div style='padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					}
					,"sDom":'<"top">rt<"bottom">'
				});

				//팝업 테이블 odd, even 스타일 세팅
				$('#table-list tr:odd').addClass('odd');
				$('#table-list tr:even').addClass('even');
			}

			function excelDown(){
				var params = "";
				params += "&searchKind="+$("#searchKind option:selected").val();
				params += "&keyword="+$("#keyword").val();
				params += "&cloudName="+ $("#h_cloudSearchName").val();

				location.href =  '${contextPath}/mng/productUsageStatus/total/excel?' + encodeURI(params);
			}

			function movePage(gbn, companyName, customerName, projectAlias){
				var params = "";
				params += "&companyName="+encodeURI(companyName);
				params += "&customerName="+encodeURI(customerName);
				params += "&projectAlias="+encodeURI(projectAlias);

				location.href = "${contextPath}/mng/productUsageStatus/"+gbn+"/?"+params;
			}

			$(document).ready(function() {
				App.init();
				gridList();

				//메뉴활성화
				$("#productUsageStatus").addClass("active");
				$("#productUsageStatusTotal").addClass("active");

				//tab 첫번째 메뉴 활성화
				$(".nav-pills>li:first-child").addClass("active");
			});

			// 프로젝트 승인 페이지 이동
			function vmLink() {
				var params = "";
				params += "?cloudId="+ $("#h_cloudSearchId").val();
				params += "&cloudName="+ $("#h_cloudSearchName").val();

				location.href = "${contextPath}/mng/productUsageStatus/vm/" + encodeURI(params);
			}

			function diskLink() {
				var params = "";
				params += "?cloudId="+ $("#h_cloudSearchId").val();
				params += "&cloudName="+ $("#h_cloudSearchName").val();

				location.href = "${contextPath}/mng/productUsageStatus/disk/" + encodeURI(params);
			}

			function serviceLink() {
				var params = "";
				params += "?cloudId="+ $("#h_cloudSearchId").val();
				params += "&cloudName="+ $("#h_cloudSearchName").val();

				location.href = "${contextPath}/mng/productUsageStatus/service/" + encodeURI(params);
			}


		</script>
	</body>
</html>