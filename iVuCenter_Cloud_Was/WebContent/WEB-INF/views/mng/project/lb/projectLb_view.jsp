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
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">가상서버 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			 <div class="row">
			 	<div class="viewbox mb20">
				    <span class="pid" id='projectName'></span>
				 	<h3 class="pname dpin ml20" id="projectAlias"></h3>
				 	<span class="dpin fb ml40 fc-blue2">본부 : </span><span id="deptName"></span><span class="dpin fb ml40 fc-blue2">처(실) : </span><span id="deptName2"></span><span class="dpin fb ml40 fc-blue2">부서 : </span><span id="deptName3"></span><span class="dpin fb ml40 fc-blue2">담당자  : </span> <span id="managerName"></span>(<span id="managerPhone"></span>)
				</div>

						<!-- 그리드 영역 -->
						
							<table id="table-list" class="tableWrap mt40">
								<colgroup>
									<col width="*">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="65px">
								</colgroup>
								<thead>
									<tr>
										<th>로드밸런스명</th>
										<th>가상서버(EA)</th>
										<th>VIP</th>
										<th>PORT</th>
										<th>method</th>
										<th>프로토콜</th>
										<th>상세</th>
									</tr>
								</thead>
							</table>

				<div class="row tac mt40">
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
				"url":"${contextPath}/mng/oss/loadbalancer/detail"
				,"type" : "GET"
				,"data":function (d) {
					d.projectId = $("#hid_projectId").val();
				}
			}
			,"columns":[
				 {"data":"loadbalancerName"}
				 ,{"data":"vmCnt"}
				 ,{"data":"ip"}
				 ,{"data":"port"}
				 ,{"data":"method"}
				 ,{"data":"protocol"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				,{"targets":[6], "render": function(data,type,full){
					return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='moveDetailPage(\""+full.projectId+"\",\""+full.loadbalancerId+"\")'><i class='fa fa-search'></i></a>";
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


	function getDetail() {

		$.ajax({
			url : "${contextPath}/mng/oss/project/detail",
			dataType : "JSON",
			data : {
				"projectId" : $("#hid_projectId").val()
			},
			async : false,
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){
                    //프로젝트 상세 ID 값 넣기
                    if(i != "deptName"){
	                    if(i == "cloudType"){
		                    if(val == "vmware"){
		                    	 $("#status1").text("상태");
			                     $("#status3").text("상태 : ");
			                     $("#status4").remove();
			                     visible = 0;
			                }
		                }
						$("#"+i).text(val);
						if(i == "deptName2"){
							if(val){
								$("#deptName").html(val.split("/")[1]);
								$("#deptName2").html(val.split("/")[2]);
								$("#deptName3").html(val.split("/")[3]);
							}
						}
                    }
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	$(document).ready(function() {
		App.init();
		getDetail();
		gridList();

		//메뉴활성화
		$("#project").addClass("active");
		$("#projectLB").addClass("active");
	});

	function moveDetailPage(projectId,loadbalancerId){
		var params = "?projectId="+projectId;
		params += "&loadbalancerId="+loadbalancerId;
		location.href = "${contextPath}/mng/project/lb/detail"+params;
	}
	function moveListPage(){
		location.href = "${contextPath}/mng/project/lb/";
	}
</script>
</body>
</html>