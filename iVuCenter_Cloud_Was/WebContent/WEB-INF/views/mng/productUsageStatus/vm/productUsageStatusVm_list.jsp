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
			<!-- begin #page-container > header -->
			<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #page-container > header -->
			<!-- begin #page-container > sidebar -->
			<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #page-container > sidebar -->

			<!-- begin #page-container > content -->
			<div id="content" class="content">
				<!-- begin header -->
				<div class="page_header mb30">
					<h1 id="titleText">가상서버</h1>
					<div class="pageNav">
						<a href="#" class="home"><i></i></a><a href="#">자원사용현황</a><a href="#" class="on" id="titleLinkText">가상서버</a>
					</div>
				</div>
				<!-- end header -->

                <input type ="hidden" id ="instanceType"  value="${req.instanceType}">

				<!-- begin page-body -->
				<div class="row pb50">
					<!-- search begin -->
					<div class="page_searchBox">
						<div class="searchArea">
							<div class="selectBox">
								<label class="selectText" for="searchKind">전체</label>
								<select type="select" class="search-sel width-150" id="searchKind" title="전체">
									<option value="searchAll" selected="selected">전체</option>
									<option value="customer_name">회원사명</option>
									<option value="project_alias">프로젝트명</option>
									<option value="hostname_alias">서버명</option>
									<option value="hostname">호스트명</option>
									<option value="ip">IP</option>
								</select>
							</div>
								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
								<button class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</button>
						</div>
					</div>
					<!-- search end -->

					<!-- Usage Status -->
					<div class="usageStatusWrap mb20">
						<strong class="titleLabel">조회 건수 합계</strong>
						<dl>
						    <dt>총 합계</dt>
							<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>vCpu</span><span class="cnt" id='title_vcpus'><em class="fc-violet">0</em>Core</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>MEMORY</span><span class="cnt" id='title_memGb'><em class="fc-blue">0</em>GB</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>DISK</span><span class="cnt" id='title_diskGb'><em class="fc-green">0</em>GB</span></dd>
							<dd class="total" id='title_length' style='text-align:center; padding-left:0px !important'><em>0</em>EA</dd>
						</dl>
					</div>
					<!-- //Usage Status -->

					<!-- 테이블시작 -->

						<!-- 그리드 영역 -->

						<!-- 상단 버튼  -->
						<div class="btnArea tar mb5">
							<a type='button' onclick="excelDown();" class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
						</div>
						<!-- //상단 버튼  -->
						<div class="productUsageStatus-table">
							<table id="table-list" class="tableWrap">

								<colgroup>
									<col width="160px">
									<col width="*">
									<col width="240px">
									<col width="160px">
									<col width="120px">
									<col width="140px">
									<col width="100px">
									<col width="100px">
									<col width="100px">
									<col width="140px">
								</colgroup>
								<thead>
									<tr>
										<th>클라우드</th>
										<th>프로젝트명</th>
										<th>서버명</th>
										<th>호스트명</th>
										<th>OS</th>
										<th>IP</th>
										<th>vCPU (Core)</th>
										<th>MEMORY (GB)</th>
										<th>DISK (GB)</th>
										<th>자원승인일시</th>
									</tr>
								</thead>
							</table>
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
			function cloudSearchId(cloudId, cloudName) {
				$("#h_cloudSearchId").val(cloudId);
				$("#h_cloudSearchName").val(cloudName);

                gridList();
        	}

		   function gridList(act) {

				$("#table-list").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${contextPath}/mng/productUsageStatus/vm/list"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#searchKind option:selected").val();
							d.keyword = $("#keyword").val();
							d.instanceType = $("#instanceType").val();
						}
					}
					,"initComplete" : function(setting, json){
						 $("#title_vcpus em").text(json.totalData.vcpus);
						 $("#title_memGb em").text(json.totalData.memGb);
						 $("#title_diskGb em").text(json.totalData.diskGb);
						 $("#title_length em").text(json.totalData.length);
					}
					,"columns":[
						{"data":"cloudName"}
						, {"data":"projectAlias", "class":"tal overflow-path"}
						, {"data":"hostnameAlias", "class":"tal overflow-path"}
						, {"data":"hostname"}
						, {"data":""}
						, {"data":"fixedIps"}
						, {"data":"vcpus"}
						, {"data":"memGb"}
						, {"data":"diskGb"}
						, {"data":"regDatetime"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[4], "render": function(data,type,full){
							var osCheck = full.hostname.substr(full.hostname.length-2,1);
							if(osCheck == "L"){
								return "Linux";
							} else if(osCheck == "W"){
								return "windows";
							} else {
								return "";
							}
						  }
						}
					]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div style='padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					}
					,"sDom":'<"top">rt<"bottom"ip>'
				});

				//팝업 테이블 odd, even 스타일 세팅
				$('#table-list tr:odd').addClass('odd');
				$('#table-list tr:even').addClass('even');
			}

			function onchangeSearchKey(e){
				if($("#searchKey"+e).val() != ""){
					if( e == "1"){
						var companyName = $("#searchKey"+e+" > option:selected").attr("companyName");
						$("#searchKey0").siblings(".selectText").text(companyName!=""?companyName:"구분");
						$("#searchKey0").val(companyName);
					}else if( e == "2"){
						var companyName = $("#searchKey"+e+" > option:selected").attr("companyName");
						$("#searchKey0").siblings(".selectText").text(companyName!=""?companyName:"구분");
						$("#searchKey0").val(companyName);

						var customerName = $("#searchKey"+e+" > option:selected").attr("customerName");
						$("#searchKey1").siblings(".selectText").text(customerName!=""?customerName:"회원사명");
						$("#searchKey1").val(customerName);
					}
				}

				if( e == "0"){
					setSearchBox("1", 'onchange');
					setSearchBox("2", 'onchange');
				}else if( e == "1"){
					setSearchBox("2", 'onchange');
				}
			}

			function setSearchBox(gbn, act){
				$.ajax({
					url : "${contextPath}/mng/productUsageStatus/total/searchBox",
					dataType : "JSON",
					data : {
						searchKind : gbn
						, searchKey0 : $("#searchKey0 option:selected").val()
						, searchKey1 : $("#searchKey1 option:selected").val()
					},
					success : function(data) {
						var vText = "";
						if(gbn == "0"){
							vText = "구분";
						}else if(gbn == "1"){
							vText = "회원사명";
						}else if(gbn == "2"){
							vText = "프로젝트명";
						}

						if( vText != ""){
							$("#searchKey"+gbn).html('<option value="">'+vText+'</option>');
							$("#searchKey"+gbn).siblings(".selectText").text(vText);
						}

						if(data.searchBox != ""){
							$.each(data.searchBox, function(key,val){
								$("#searchKey"+gbn).append('<option value="'+val.searchKind+'" companyName="'+val.companyName+'" customerName="'+val.customerName+'">'+val.searchKind+'</option>');
							});
						}

						if(act == "ready"){
							if(gbn=='0' && '${req.customerName}' != ""){
								$("#searchKey0").val('${req.customerName}');
								$("#searchKey0").siblings(".selectText").text('${req.customerName}');
							}
							if(gbn=='1' &&  '${req.customerName}' != ""){
								$("#searchKey1").val('${req.customerName}');
								$("#searchKey1").siblings(".selectText").text('${req.customerName}');
							}
							if(gbn=='2' &&  '${req.projectAlias}' != ""){
								$("#searchKey2").val('${req.projectAlias}');
								$("#searchKey2").siblings(".selectText").text('${req.projectAlias}');
							}
						}
					},
					error : function(request, status, error) {
						if(request.status == '200'){
							alertBox("접속이 만료되었습니다.", logout);
						}else{
							alertBox3("code:" + request.status + "\n" + "error:" + error);
						}
					}
				});
			}

			function excelDown(){
				var params = "";
				params += "&searchKind="+$("#searchKind option:selected").val();
				params += "&keyword="+$("#keyword").val();

				location.href =  '${contextPath}/mng/productUsageStatus/vm/excel?' + encodeURI(params);
			}

			$(document).ready(function() {
				App.init();
				gridList('ready');

				$("#productUsageStatus").addClass("active");

				if($("#instanceType").val() == "INSTANCE_NORMAL"){
					$("#productUsageStatusVmNomal").addClass("active");
					$("#titleText").text("가상서버");
					$("#titleLinkText").text("가상서버");
				}else if($("#instanceType").val() == "INSTANCE_GPU"){
					$("#productUsageStatusVmGpu").addClass("active");
					$("#titleText").text("가상서버(GPU)");
					$("#titleLinkText").text("가상서버(GPU)");
				}else if($("#instanceType").val() == "INSTANCE_CTNTRMNL"){
					$("#productUsageStatusVmCtntrmnl").addClass("active");
					$("#titleText").text("컨테이너터미널");
					$("#titleLinkText").text("컨테이너터미널");
				}

				//메뉴활성화
				$("#productUsageStatusVm").addClass("active");

				//tab 첫번째 메뉴 활성화
				$(".nav-pills>li:first-child").addClass("active");
			});
		</script>
	</body>
</html>