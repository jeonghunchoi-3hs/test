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

		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)-->
		<div id="content" class="content">
			<!-- begin header -->
			<input type ="hidden" id = "hid_projectBoxId"  value ="${req.projectBoxId}">
			<input type ="hidden" id = "hid_projectName"  value ="${req.projectName}">
			<input type ="hidden" id = "hid_reqProjectSeq"  value ="${req.reqProjectSeq}">
			<div class="page_header mb30">
				<h1>프로젝트 쿼터 관리</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">자원배분 정책</a>
				</div>
			</div>
			<!-- end header -->

		<!-- begin page-body -->
			 <div class="row">

			 	<div class="viewbox mb20">
			 	    <span class="pid" id='projectName'>${req.projectName}</span>
				 	<h3 class="pname dpin ml20 mr20" id="projectAlias"></h3>
				 	<span class="dpin fb fc-blue2">본부</span><span id="deptName">${fn:split(detail.deptName2,'/')[1]}</span>
				 	<span class="dpin fb ml40 fc-blue2">처(실)</span><span id="deptName">${fn:split(detail.deptName2,'/')[2]}</span>
				 	<span class="dpin fb ml40 fc-blue2">부서</span><span id="deptName">${fn:split(detail.deptName2,'/')[3]}</span>
				 	<span class="dpin fb ml40 fc-blue2">담당자  : </span><span id="managerName">${detail.managerName}</span>(<span id="managerPhone">${detail.managerPhone}</span>)
				</div>
				<div class="mt20">
			    	<h2 class="titleBuType01"><span class="bullet"></span>자원배분량(laaS) </h2>

						<!-- 그리드 영역 -->

							<table id="table-list" class="tableWrap">
								<colgroup>
									<col width="*">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="65px">
								</colgroup>
								<thead>
									<tr>
										<th>클라우드명</th>
										<th>가상서버</th>
										<th>vCpu</th>
										<th>MEMORY</th>
										<th>볼륨</th>
										<th>볼륨스냅샷</th>
										<th>블록디스크</th>
										<th scope="col">상세</th>
									</tr>
								</thead>
							</table>



					<br />
					<h2 class="titleBuType01"><span class="bullet"></span>자원배분량(PaaS)</h2>

						<!-- 그리드 영역 -->

							<table id="table-list_paas" class="tableWrap">
								<colgroup>
									<col width="*">
									<col width="14%">
									<col width="14%">
									<col width="14%">
									<col width="14%">
									<col width="65px">
								</colgroup>
								<thead>
									<tr>
										<th>클라우드명</th>
										<th>POD</th>
										<th>CPU(CORE)</th>
										<th>MEMORY(GB)</th>
										<th>볼륨(PV)</th>
										<th scope="col">상세</th>
									</tr>
								</thead>
							</table>




				</div>
			</div>
			<div class="row tac mt40">
				<a type='button' class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
			</div>
            <!-- begin #footer -->
            <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->


		<!-- end #content -->

	</div>
	<!-- end page container -->

</div>

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/project/quota/";
	}
	// 등록/수정페이지 이동
	function moveDetailPage(projectId,cloudId){
		var params = "?projectId="+projectId;
		params += "&projectName="+$("#hid_projectName").val();
		params += "&reqProjectSeq="+$("#hid_reqProjectSeq").val();
		params += "&cloudId="+cloudId;

		location.href = "${contextPath}/mng/project/quota/view" + encodeURI(params);
	}

	function movePassDetailPage(projectId,cloudId){
		var params = "?projectId="+projectId;
		params += "&projectName="+$("#hid_projectName").val();
		params += "&reqProjectSeq="+$("#hid_reqProjectSeq").val();
		params += "&cloudId="+cloudId;

		location.href = "${contextPath}/mng/project/quota/viewPass" + encodeURI(params);
	}

	function addcomma(n){
		if(isNaN(n)){
			return 0;
		}else{
			var reg=/(^[+-]?\d+)(\d{3})/;
			n +='';

			if( n.indexOf(".") != -1){
				n = n.split(".")[0];
			}

			while(reg.test(n)){
				n=n.replace(reg,'$1'+','+'$2');
			}
		return n;
		}
	}
	function gridLaaSList() {

		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/project/quota/cloudDetail"
				,"type" : "GET"
				,"data":function (d) {
					d.projectBoxId = $("#hid_projectBoxId").val();
					d.cloudType = 'LaaS';
				}
			}
			,"columns":[
				 {"data":"cloudName" , "class":"tac"}
				 ,{"data":"instances" , "class":"tac"}
				 ,{"data":"cores" , "class":"tac"}
				 ,{"data":"" , "class":"tac"}
				 ,{"data":"" , "class":"tac"}
				 ,{"data":"" , "class":"tac"}
				 ,{"data":"gigabytes" , "class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }

				,{"targets":[1], "render": function(data,type,full){

				 if(full.cloudType == "openstack"){
						return full.instances;
					} else if(full.cloudType == "vmware"){
						return full.instances;
					} else {
						return "-";
					}
				}}

				,{"targets":[3], "render": function(data,type,full){
					return addcomma(Number(full.ram/1024));
				}}
				,{"targets":[4], "render": function(data,type,full){
					if(full.cloudType == "openstack"){
						return full.volumes;
					} else if(full.cloudType == "vmware"){
						return "-";
					} else if(full.cloudType == "nutanix"){
						return "-";
					}
				}}
				,{"targets":[5], "render": function(data,type,full){
					if(full.cloudType == "openstack"){
						return full.snapshots;
					} else if(full.cloudType == "vmware"){
						return "-";
					}  else if(full.cloudType == "nutanix"){
						return "-";
					}
				}}
				,{"targets":[6], "render": function(data,type,full){
					return addcomma(Number(full.gigabytes));
				}}
				,{"targets":[7], "render": function(data,type,full){


				if(full.cloudType == "openstack"){
					return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='moveDetailPage(\""+full.projectId+"\",\""+full.cloudId+"\")'><i class='fa fa-search'></i></a>";
				} else if(full.cloudType == "vmware"){
					return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='moveDetailPage(\""+full.projectId+"\",\""+full.cloudId+"\")'><i class='fa fa-search'></i></a>";
				} else {
					return "-";
				}
				}}
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:666; font-weight:bold;'>검색중입니다.</p></div>"

			}
			,"sDom":'<"top">rt<"bottom"ip>'
		});
		tblColorSet();
	}


	function gridPaaSList() {
		$("#table-list_paas").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/project/quota/cloudDetail"
				,"type" : "GET"
				,"data":function (d) {
					d.projectBoxId = $("#hid_projectBoxId").val();
					d.cloudType = 'PaaS';

				}
			}
			,"columns":[
				 {"data":"cloudName" , "class":"tac"}
				 ,{"data":"instances" , "class":"tac"}
				 ,{"data":"cores" , "class":"tac"}
				 ,{"data":"" , "class":"tac"}
				 ,{"data":"gigabytes" , "class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				,{"targets":[1], "render": function(data,type,full){
					return full.specHardPod;
				}}
				,{"targets":[2], "render": function(data,type,full){
					return full.specHardLimitCpu;
				}}
				,{"targets":[3], "render": function(data,type,full){
					return full.specHardLimitMemory;
				}}
				,{"targets":[4], "render": function(data,type,full){
					return full.specHardPV;
				}}

				,{"targets":[5], "render": function(data,type,full){
					return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='movePassDetailPage(\""+full.projectId+"\",\""+full.cloudId+"\")'><i class='fa fa-search'></i></a>";
				}}
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:666; font-weight:bold;'>검색중입니다.</p></div>"

			}
			,"sDom":'<"top">rt<"bottom"ip>'
		});
		tblColorSet();
	}




	$(document).ready(function() {
		App.init();
	    gridLaaSList();
		gridPaaSList();

		//메뉴활성화
		$("#project").addClass("active");
		$("#projectQuota").addClass("active");
	});

</script>
</body>
</html>