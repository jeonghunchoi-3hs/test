<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="roles" property="principal.roles" />
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

		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)-->
		<div id="content" class="content">
		<input type ="hidden" id ="hid_projectId"  value="${req.projectId}">
		<input type ="hidden" id ="hid_loadbalancerId" value="${req.loadbalancerId}">
		<input type ="hidden" id ="hid_projectName"  value="${req.projectName}">
		<input type ="hidden" id ="hid_reqProjectSeq"  value="${req.programSeq}">
		<input type ="hidden" id ="targetUuid"  >
		<input type ="hidden" id ="targetAct"  >
		<input type ="hidden" id ="vmUuid"  >
		<input type ="hidden" id ="cloudId" >
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>로드밸런스</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">로드밸런스 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			 <div class="row pb50">
			 	<div class="viewbox mb20">
				    <span class="pid" id='loadbalancerName'></span>
				 	<span class="dpin fb fc-blue2 ml40">vip  : </span><span id="ip"></span>
				 	<span class="dpin fb fc-blue2 ml40">port  : </span><span id="port"></span>
				 	<span class="dpin fb fc-blue2 ml40">프로토콜  : </span><span id="protocol"></span>
				 	<span class="dpin fb fc-blue2 ml40">method  : </span><span id="method"></span>
				</div>


				<div class="mt40">
			    	<h2 class="titleBuType01 mb15">가상서버 </h2>
			    	<div class="gridTableWrap gridType01">
						<!-- 그리드 영역 -->
						<div class="tableWrap">
							<table id="table-list">
								<colgroup>
									<col width="*">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th>가상서버명</th>
										<th>클라우드</th>
										<th>ip</th>
										<th>vcpus</th>
										<th>memory</th>
										<th>disk</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
				<div class="row tac m-t-40">
					<a type="button" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>
				</div>
             </div>
             <!-- end tab-content -->
             <!-- begin #footer -->
            <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			<!-- end page-body -->
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
				"url":"${contextPath}/mng/oss/loadbalancer/vmList"
				,"type" : "GET"
				,"data":function (d) {
					d.loadbalancerId = $("#hid_loadbalancerId").val();
				}
			}
			,"columns":[
				 {"data":"hostnameAlias" , "class":"tac"}
				 ,{"data":"cloudName" , "class":"tac"}
				 ,{"data":"fixedIps" , "class":"tac"}
				 ,{"data":"vcpus" , "class":"tac"}
				 ,{"data":"memGb" , "class":"tac"}
				 ,{"data":"diskGb" , "class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
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


	function getDetail() {

		$.ajax({
			url : "${contextPath}/mng/oss/loadbalancer/detail",
			dataType : "JSON",
			data : {
				"projectId" : $("#hid_projectId").val()
				,"loadbalancerId" : $("#hid_loadbalancerId").val()
			},
			async : false,
			success : function(data) {
				delete data.length;
				$.each(data.data, function(i, val){
                    //프로젝트 상세 ID 값 넣기
                    $("#loadbalancerName").html(val['loadbalancerName']);
					$("#ip").html(val['ip']);
					$("#port").html(val['port']);
					$("#protocol").html(val['protocol']);
					$("#method").html(val['method']);
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}

	function delLoadbalancerVm(vmUuid,loadbalancerId){
		var obj = {
				"vmUuid"				: vmUuid
				, "loadbalancerId"		: loadbalancerId

				};
		confirmBox2("삭제 하시겠습니까?",actDelete, obj);
	}
	function actDelete(obj){
		$.ajax({
			url : "${contextPath}/mng/oss/loadbalancer/deleteVm",
			dataType : "JSON",
			data : obj ,
			async : false ,
			success : function(data) {
				alertBox("삭제되었습니다.", gridList);
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		})
	}
	
	$(document).ready(function() {
		App.init();
		getDetail();
		gridList();
		//메뉴활성화
		$("#project").addClass("active");
		$("#projectLB").addClass("active");
	});
</script>
</body>
</html>