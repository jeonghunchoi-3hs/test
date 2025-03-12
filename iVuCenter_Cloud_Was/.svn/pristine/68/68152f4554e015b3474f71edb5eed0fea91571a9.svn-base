<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer in">
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->

		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->


		<!-- begin #content -->
		<div id="content" class="content">

				<p class="page_title">어플리케이션
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원현황  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/application/req/">어플리케이션</a> <span class="arrow_ab"> &#8227; </span> <b>어플리케이션 상세</b>
			    </span>
			    </p>
			 <!-- begin #content > page-body -->
				 <div class="row p20 bgwh br10">


					<input type ="hidden" id ="hid_projectId"  value="">
					<input type ="hidden" id ="hid_projectBoxId"  value="${req.projectBoxId}">
					<input type ="hidden" id ="hid_projectName"  value="${req.projectName}">
					<input type ="hidden" id ="reqProjectSeq"  value="${req.programSeq}">
					<input type="hidden" id="hid_cloudId" value="">
					<input type="hidden" id="hid_appUuid" value="">
					<input type="hidden" id="hid_appName" value="">
					<input type="hidden" id="h_scaleOutUid" value="">
					<input type="hidden" id="scaleOutName" value="">
					<input type="hidden" id="hid_nameSpace" value="">

				 <!-- 프로젝트 정보 & 현재 사용용량 시작 -->
					<!-- <div class="viewbox mb20">
					    프로젝트 상세정보
					    <span class="pid" id="projectName"></span>
					 	<h3 class="pname dpin ml20" id="projectAlias"></h3>
					 	<div class="mt20">
					 		<span class="dpin fb fc-blue2">본부 : </span> <span id="deptName"></span><span class="dpin fb ml40 fc-blue2">처(실) : </span> <span id="deptName2"></span><span class="dpin fb ml40 fc-blue2">부서 : </span> <span id="deptName3"></span><span class="dpin fb ml40 fc-blue2">담당자  : </span> <span id="managerName"></span>(<span id="managerTel"></span>)
					 	</div>

						현재 사용 용량
						<div class="usageStatusWrap mt20">
							<strong class="titleLabel">현재 사용 용량</strong>
							<dl>
								<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>Deployment</span><span class="cnt" id ="title_configs"><em class="fc-orange" >1</em>EA</span></dd>
								<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>Pod</span><span class="cnt" id ="title_pods"><em class="fc-violet" >2</em>EA</span></dd>
								<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>Service</span><span class="cnt" id ="title_services"><em class="fc-blue" >3</em>EA</span></dd>
								<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>Route</span><span class="cnt" id ="title_routes"><em class="fc-green" >4</em>EA</span></dd>
								<dd><span class="title"><i class="fa fa-circle f12 fc66 mr10"></i>Volume</span><span class="cnt" id ="title_volumes"><em class="fc66" >5</em>EA</span></dd>
								<dd><span class="title"><i class="fa fa-circle f12 fc_dyellow mr10"></i>Build</span><span class="cnt" id ="title_builds"><em class="fc_dyellow" >6</em>EA</span></dd>
							</dl>
						</div>
					</div> -->
					<!-- 프로젝트 정보 & 현재 사용용량 끝 -->


					 <div class="col-md-12 pl0 pr0">
            	   <div class="col-md-12 pl0">
            	    <span class="pid" id='projectName'></span>
					<h3 class="pname dpin ml20" id="projectAlias"></h3>
            	   </div>

            	   <div class="clear"></div>
            	   <div class="col-md-12 pl0 pr0 mt20">
	            	    <div class="col-md-3 sub_li"  style="float:left;">
	            	       <label>본부 </label>
	            	       <span id="deptName"></span>
	            	    </div>
	            	    <div class="col-md-3 sub_li">
	            	       <label>처(실)</label>
	            	      <span  id="deptName2"></span>
            	  		</div>
            	  		<div class="col-md-3 sub_li">
	            	       <label>부서</label>
	            	      <span id="deptName3"></span>
            	  		</div>
            	  		<div class="col-md-3 sub_li" style="margin-right:0;float:right;">
	            	       <label>담당자</label>
	            	       <span id="managerName"></span>(<span id="managerTel"></span>)
            	  		</div>
            	     </div>
            	     <div class="col-md-12 pl0 pr0 mt20">
            	     <h4 class="f16 mb10 f500 mb20">현재 사용량  </h4>
            	     <div class="col-md-2 sub_use_app">Delpoyment <span class="flr"><em class="fc_orange_im f24 mr5" id="title_configs">0</em> EA</span> </div>
            	     <div class="col-md-2 sub_use_app">Pod <span class="flr"><em class="fc_purple_im f24 mr5" id="title_pods">0</em>EA</span></div>
            	     <div class="col-md-2 sub_use_app">Service <span class="flr"><em class="fc_blue_im f24 mr5" id="title_services">0</em>EA</span></div>
            	     <div class="col-md-2 sub_use_app">Route<span class="flr"><em class="fc_green_im f24 mr5" id="title_routes">0</em>EA</span></div>
            	     <div class="col-md-2 sub_use_app">Volume<span class="flr"><em class="fc_navy_im f24 mr5" id="title_volumes">0</em>EA</span></div>
            	     <div class="col-md-2 sub_use_app" style="margin-right:0;float:right;">Build <span class="flr"><em class="fc_orange_im f24 mr5" id="title_builds">0</em>EA</span></div>

            	     </div>
            	   </div>

					<div class="clear"></div>


					<!-- 상단 버튼  -->
						<div class="tar mt20" style="margin-bottom:-40px;">
							<a onclick="excelDown();" type='button' class="btn_navy-s"><img src="${apachePath}/resources/assets/img/icon_down.svg" height="18px;"/>  엑셀 다운로드</a>
						</div>
						<!-- //상단 버튼  -->

				   <!-- 프로젝트 하위 상세 VM 리스트 시작 -->
					<div class="gridTableWrap gridType02 mt50">

						<!-- 그리드 영역 -->

							<table id="app-list" class="tableV">
								<colgroup>
									<col width="10%">
									<col width="13%">
									<col width="10%">
									<col width="13%">
									<col width="*">
									<col width="8%">
									<col width="8%">
									<col width="8%">
								</colgroup>
								<thead>
									<tr>
										<th>클라우드 </th>
										<th>어플리케이션명</th>
										<th>이미지 템플릿 </th>
										<th>POD수 </th>
										<th>상태</th>
										<th>ScaleOut </th>
										<th>생성일시 </th>
										<th>상세 </th>
									</tr>
								</thead>
								<tbody>
								<tr>
								<td class="tal"></td>
								<td class="tal"></td>
								<td class="tal"></td>
								<td class="tar"></td>
								<td></td>
								<td></td>
<%-- 								<td><a href="${wasPath}/mbr/application/req/detail" class="cbton bton_lblue"><i class="fa fa-search"></i></a></td> --%>
								<td></i></a></td>
								</tr>
								</tbody>

							</table>

				</div>
					<!-- 프로젝트 하위 상세 VM 리스트 끝 -->

				<div class="tac mt30">
					<a onclick="moveListPage()" type="button" class="btn_dgrey">목록</a>
				</div>
				<!---- end page body---->
	            </div>

				<!-- 컨테이너 상세 Modal -->
				<div class="modal fade" id="container-modal-dialog">
				    <div class="modal-dialog">
				        <div class="modal-content w560">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
				                    <span></span>
				                </button>
				                <h4 class="modal-title">컨테이너 상세</h4>
				            </div>
				            <div class="modal-body">
								<div class="tableE">
										<table>
											<colgroup>
												<col width="140px" />
												<col width="*" />
											</colgroup>
											<tbody>
												<tr>
													<th class="tal">이미지 템플릿</th>
													<td><span id="applicationTemplate"></span></td>
												</tr>
												<tr>
													<th class="tal">어플리케이션 명</th>
													<td><span class="cnt" id="applicationName"></span></td>
												</tr>
												<tr>
													<th class="tal">Label</th>
													<td><span class="cnt" id="applicationLabel"></span></td>
												</tr>
												<tr>
													<th class="tal">Status</th>
													<td><span class="cnt" id="applicationStatus"></span></td>
												</tr>
												<tr>
													<th class="tal">ScaleOut</th>
													<td>
														<div class="flex gap10">
															<span class="hostName2 f14 fc11 fontVdn" id="applicationScaleOut"></span>
									                        <button class="btn btn-danger" id="noticeDelete" onclick="deleteScaleOut()">삭제</button>
									                        <button class="btn btn-primary" id="noticeList" onclick="moveInsertPage()">수정</button>
														</div>
													</td>
												</tr>
												<tr>
													<th class="tal">생성</td>
													<td><span class="cnt" id="applicationRegDate"></span></td>
												</tr>
												<tr>
													<td colspan="2">
														<p class="podArea mb5 f20" id ="applicationPod"></p>
		                       							<p class="fc11 tac">어플리케이션<span class="fc66 fn">(POD 수)</span></p>
													</td>
												</tr>
										</table>
										<ul class="cloud-list-group">
					                        <li id="pods-list"></li>
					                        <li id="builds-list"></li>
					                        <li id="service-list"></li>
					                        <li id="routes-list"></li>
					                    </ul>
							            <div class="modal-footer tac">
							                <%-- <a type="button" class="m_btn_navy" href="${wasPath}/mbr/req/changeOrder/changeOrderView?viewFlag=Y">변경신청</a> --%>
							                <a type="button" class="m_btn_white ml10" data-dismiss="modal" id="popclose">닫기</a>
							            </div>
							        </div>
				           </div>
				        </div>
				    </div>
				</div>
				<!-- #modal-dialog -->

				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
			<!-- end #content -->

		<!-- end page container -->
	</div>

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	function getDetail() {
		$.ajax({
			url : "${contextPath}/mbr/oss/project/detail",
			dataType : "JSON",
			async : false,
			data : {
				"programSeq" : $("#reqProjectSeq").val()
				,"projectBoxId" : $("#hid_projectBoxId").val()
			},
			success : function(data) {

				delete data.length;

				$.each(data, function(i, val){

					if(i != "deptName"){
						if(i == "cloudType"){
		                    if(val == "vmware"){
			                    $("#status1").text("상태");
			                    $("#status3").text("상태 : ");
			                    $("#status4").remove();
			                    visible = 0;
			                }
		                }
						if(val != null){
							if(i === "customerId" || i === "projectId"){
								$("#hid_"+i).val(val);
							}else if(i == "keyword"){
								// skip
							}else{
								$("#"+i).text(val);
							}
						}
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

	// 컨테이너 상세 팝업 정보 관련 함수
	//PodList 정보
	function getPodList() {

	    $.ajax({
	        url: "${contextPath}/mbr/application/req/getPodList",
	        type: "GET",
	        dataType: "JSON",
	        data: {
	            projectBoxId: $("#hid_projectBoxId").val()
	            , projectId: $("#hid_projectId").val()
	            , cloudId: $("#hid_cloudId").val()
	            , appUuid: $("#hid_appUuid").val()
	        },
	        success: function (data) {
	            var podList = "";

	            $.each(data.items, function (k, v) {
	                var appName = v.metadata.labels.application;
	                var deploymentConfig = v.metadata.labels.deploymentconfig;

	                if (k === 0) {
	                    podList += "<h4>Pods</h4>";
	                }

	                if (appName === $("#hid_appName").val() || deploymentConfig === $("#hid_appName").val()) {
	                    podList += "<div class='item'>";
	                    podList += "<div class='item-info'>";
	                    podList += "<label class='item-label'>P</label>";
	                    podList += "<p class='item-name'>" + v.metadata.name + "</p>";

	                    if (v.status.startTime === undefined) {
	                        podList += "<p class='item-status'>생성일시: N/A</p>";
	                    } else {
	                        var strDate = new Date(v.status.startTime);
	                        strDate.setHours(strDate.getHours() + 9);
	                        var coustomDate = strDate.toISOString().replace('T', ' ').substring(0, 19);
	                        podList += "<p class='item-status'>생성일시: " + coustomDate + "</p>";
	                    }
	                    podList += "</div>";
	                    podList += "<div class='item-actions'>";
	                    if (v.status.phase === "Running") {
	                        podList += "<p class='sub-txt'>Running</p>";
// 	                        podList += "<button class='action-btn'>Running</button>";
	                    } else {
	                        podList += "<p class='sub-txt'>" + v.status.phase + "</p>";
// 	                        podList += "<button class='action-btn action-secondary'>" + v.status.phase + "</button>";
	                    }
	                    podList += "</div>";
	                    podList += "</div>";
	                }
	            });

	            $("#pods-list").html(podList);
	        },
	        error: function (request, status, error) {
	            alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
	        }
	    });
	}

	function gridBuildList(argData){

	    var buildList = "";
	    $("#builds-list").empty();

	    $.each(argData.items, function (k, v) {
	        var appName = v.metadata.labels.application;
	        var buildconfig = v.metadata.labels.buildconfig;

	        if (k === 0) {
	            buildList += "<h4>Builds</h4>";
	            buildList += "<ul>";
	            buildList += "<li class='item'>";
	            buildList += "<div class='item-info'>";
	            buildList += "<label class='item-label'>BC</label>";
	            buildList += "<p class='item-name'>" + $("#hid_projectName").val() + "</p>";
	            buildList += "</div>";
	            buildList += "<div class='item-actions'>";
	            buildList += "<button class='start-btn action-btn action-primary' onclick='startBuild(\"" + buildconfig + "\");'>StartBuild</button>";
	            buildList += "</div>";
	            buildList += "</li>";
	            buildList += "</ul>";
	            buildList += "<ul>";
	        }

	        if (appName === $("#hid_appName").val() || buildconfig === $("#hid_appName").val()) {
	            buildList += "<li class='item'>";
	            buildList += "<div class='item-info'>";
	            buildList += "<label class='item-label'>BC</label>";
	            buildList += "<p class='item-name'>" + v.metadata.name + "</p>";
	            buildList += "</div>";

	            if (v.status.phase != "Complete") {
	                buildList += "<div class='item-actions'>";
	                buildList += "<button class='stop-btn'>Stop</button>";
	                buildList += "</div>";
	            } else {
	                buildList += "<div class='item-actions'>";
	                buildList += "<p class='sub-txt'>" + v.status.phase + "</p>";
	                buildList += "</div>";
	            }

	            buildList += "</li>";
	        }
	    });

	    buildList += "</ul>";
	    $("#builds-list").html(buildList);
	}

	function startBuild(argBuildConfig){
		$.ajax({
			url: "${contextPath}/mbr/application/req/startBuild",
			type: "GET",
			dataType: "JSON",
			data: {
				projectBoxId: $("#hid_projectBoxId").val()
				, projectId: $("#hid_projectId").val()
				, cloudId: $("#hid_cloudId").val()
				, appUuid: $("#hid_appUuid").val()
				, buildConfigName: argBuildConfig
			},
			success: function (data) {
				gridBuildList(data);
				alertBox3("재빌드 요청이 완료 되었습니다.")
			},
			error: function (request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	//BuildList 정보
	function getBuildList() {

		$.ajax({
			url: "${contextPath}/mbr/application/req/getBuildList",
			type: "GET",
			dataType: "JSON",
			data: {
				projectBoxId: $("#hid_projectBoxId").val()
				, projectId: $("#hid_projectId").val()
				, cloudId: $("#hid_cloudId").val()
				, appUuid: $("#hid_appUuid").val()
			},
			success: function (data) {

				gridBuildList(data);
			},
			error: function (request, status, error) {

				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
		//ServiceList 정보
	function getServiceList() {
	    $.ajax({
	        url: "${contextPath}/mbr/application/req/getServiceList",
	        type: "GET",
	        dataType: "JSON",
	        data: {
	            projectBoxId: $("#hid_projectBoxId").val()
				, projectId: $("#hid_projectId").val()
	            , cloudId: $("#hid_cloudId").val()
	            , appUuid: $("#hid_appUuid").val()
	        },
	        success: function (data) {
	            var serviceList = "";

	            $.each(data.items, function (k, v) {
	                var appName = v.metadata.labels.application;
	                var app = v.metadata.labels.app;

	                if (k === 0) {
	                    serviceList += "<h4>Services</h4>";
	                }

	                if (appName === $("#hid_appName").val() || app === $("#hid_appName").val()) {
	                    serviceList += "<div class='item'>";
	                    serviceList += "<div class='item-info'>";
	                    serviceList += "<label class='item-label'>R</label>";
	                    serviceList += "<p class='item-name'>Service: " + v.metadata.name + "</p>";
	                    serviceList += "<p class='item-status'>Service port: " + v.spec.ports[0].protocol + " / " + v.spec.ports[0].port + " ➔ Pod Port: " + v.spec.ports[0].targetPort + "</p>";
	                    serviceList += "</div>";
	                    serviceList += "</div>";
	                }
	            });

	            $("#service-list").html(serviceList);
	        },
	        error: function (request, status, error) {
	            alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
	        }
	    });
	}

		//RouteList 정보
	function getRouteList() {
	    $.ajax({
	        url: "${contextPath}/mbr/application/req/getRouteList",
	        type: "GET",
	        dataType: "JSON",
	        data: {
	            projectBoxId: $("#hid_projectBoxId").val()
	            , projectId: $("#hid_projectId").val()
	            , cloudId: $("#hid_cloudId").val()
	            , appUuid: $("#hid_appUuid").val()
	        },
	        success: function (data) {
	            var routesList = "";

	            $.each(data.items, function (k, v) {
	                var appName = v.metadata.labels.application;
	                var app = v.metadata.labels.app;

	                if (k === 0) {
	                    routesList += "<h4>Routes</h4>";
	                }

	                if (appName === $("#hid_appName").val() || app === $("#hid_appName").val()) {
	                    routesList += "<div class='item'>";
	                    routesList += "<div class='item-info'>";
	                    routesList += "<label class='item-label'>RT</label>";
	                    routesList += "<p class='item-name'>Route: " + v.metadata.name + "</p>";
	                    if (typeof(v.spec.tls) != 'undefined') {
	                        routesList += "<p class='item-status'>Location: <a href='https://" + v.spec.host + "' target='_blank'>" + v.spec.host + "</a></p>";
	                    } else {
	                        routesList += "<p class='item-status'>Location: <a href='http://" + v.spec.host + "' target='_blank'>" + v.spec.host + "</a></p>";
	                    }
	                    routesList += "</div>";
	                    routesList += "</div>";
	                }
	            });

	            $("#routes-list").html(routesList);
	        },
	        error: function (request, status, error) {
	            alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
	        }
	    });
	}

	//ProjectAppInfo 정보
	function getProjectAppDetail() {
	//		alert("getProjectAppDetail");
		$.ajax({
			url: "${contextPath}/mbr/application/management/detail",
			dataType: "JSON",
			type: "POST",
			data: {
				projectBoxId: $("#hid_projectBoxId").val()
				, projectId: $("#hid_projectId").val()
				, cloudId: $("#hid_cloudId").val()
				, appUid: $("#hid_appUuid").val()
			},
			success: function (data) {
				var result = data.data;

				$("#templateName").val(result.templateName);
				$("#hid_appName").val(result.appName);
				$("#h_scaleOutUid").val(result.scaleOutUid);
				$("#scaleOutName").val(result.scaleOutName);
				$("#hid_nameSpace").val(result.appNameSpace);
				var html;
				if($("#h_scaleOutUid").val() == ''){
				    $("#noticeList").hide();
				    $("#noticeDelete").hide();
				} else {
				$("#noticeList").show();
				$("#noticeDelete").show();
				}

			},
			error: function (request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	//ProjectAppInfo 정보
	function getProjectAppInfo() {

		$.ajax({
			url: "${contextPath}/mbr/application/req/getProjectAppInfo",
			dataType: "JSON",
			type: "POST",
			data: {
				projectBoxId: $("#hid_projectBoxId").val()
				, cloudId: $("#hid_cloudId").val()
				, appUid: $("#hid_appUuid").val()
			},
			success: function (data) {
				var result = data;
				$("#applicationTemplate").text(result.templateName);
				$("#applicationName").text(result.appName);
				$("#applicationLabel").text(result.label);
				$("#applicationStatus").text(result.status);
				$("#applicationRegDate").text(result.regDatetime);
				$("#applicationProjectName").text(result.projectName);
				$("#applicationProjectAlias").text(result.projectAlias);
				$("#applicationPod").text(result.pod);
				$("#popCustomerName").text(result.customerName);
				$("#popDeptName").text(result.deptName);
				$("#popManagerName").text(result.managerName);
				$("#applicationScaleOut").text(result.scaleOutName);

				$("#hid_appName").val(result.appName);

		 		getPodList();
		 		getBuildList();
		 		getServiceList();
		 		getRouteList();

			},
			error: function (request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	// 컨테이너 상세 정보 관련 함수 끝
	function detailContainer(argAppUuid, argProjectBoxId, argProjectId, argCloudId){
		$("#hid_appUuid").val(argAppUuid);
		$("#hid_projectBoxId").val(argProjectBoxId);
		$("#hid_projectId").val(argProjectId);
		$("#hid_cloudId").val(argCloudId);
		$("#container-modal-dialog").modal('show');

		getProjectAppInfo();
		getProjectAppDetail();
	}

	function gridAppList() {

		$("#app-list").dataTable({
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mbr/application/management/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = "";
					d.keyword = "";
					d.projectBoxId = $("#hid_projectBoxId").val();
					d.projectName = $("#hid_projectName").val();
				}
				,"complete" : function(obj, status){

	//					if(status == 'success'){
	//						var jsonData = obj.responseJSON.data;
	//						makeTableBody(jsonData);
	//					}
				}
			}
			,"initComplete" : function(setting, json){
				if(json.recordsTotal != 0){
					$("#hid_projectId").val(json.data[0].projectId);
				}
				$("#title_configs").text(json.resourceTotal.deploymentConfigTotal);
				$("#title_pods").text(json.resourceTotal.podTotal);
				$("#title_services").text(json.resourceTotal.serviceTotal);
				$("#title_routes").text(json.resourceTotal.routesTotal);
				$("#title_volumes").text(json.resourceTotal.volumeTotal);
				$("#title_builds").text(json.resourceTotal.buildsTotal);
			}
			,"columns":[
				{"data":"cloudName" , "class":"tac", "width":"10%"}
				, {"data":"appName" , "class":"tac fontVdn", "width":"15%"}
	// 			, {"data":"appAlias" , "class":"tal fontVdn", "width":"15%"}
				, {"data":"templateName" , "class":"tac fontVdn", "width":"20%"}
				, {"data":"pod" , "class":"tac fontVdn", "width":"20%"}
				, {"data":"state" , "class":"tac fontVdn", "width":"8%"}
				, {"data":"scaleOutName" , "class":"tac fontVdn", "width":"10%"}
				, {"data":"regDatetime" , "class":"tac fontVdn", "width":"10%"}
				, {"data":"" , "class":"tac p-0 fontVdn", "width":"8%"}
			]
	//			,"columnDefs":[
	//				  {"defaultContent" : "", targets:"_all" }
	//				, {"targets":[7], "render": function(data,type,full){
	//					return "<a href='#' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.appUid+"\",\""+full.projectId+"\",\""+full.cloudId+"\")'><i class='fa fa-search'></i></a>";
	//					}
	//				}
	//			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[7], "render": function(data,type,full){
					return "<a type='button' class='btn btn-detail'  onclick='detailContainer(\""+full.appUid+"\", \""+full.projectBoxId+"\", \""+full.projectId+"\",\""+full.cloudId+"\")'><i class='fa fa-search'></i></a>";
					}
				}
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div class='data_search'><i class='fa fa-spinner fa-spin'></i> 검색중입니다. </div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
	}


	function moveListPage() {
		location.href = "${contextPath}/mbr/application/management/";
	}

// 	function moveDetailPage(appUid,projectId,cloudId){
// 		var params = "?appUid="+appUid;
// 		params += "&projectId="+projectId;
// 		params += "&cloudId="+cloudId;
// 		location.href = "${contextPath}/mbr/application/req/detail"+params;
// 	}

	// 새로고침
	function pageReload(){
		location.reload();
	}

	// 어플리케이션 엑셀 다운로드
	function excelDown(){
		var params = "";

		params += "&projectBoxId=" + $("#hid_projectBoxId").val();
		location.href = "${contextPath}/mbr/application/management/viewExcel?"+params;
	}

	function ajaxDeleteScaleOut(){

		var cloudId = $("#hid_cloudId").val();

		var setData = {
				"scaleOutUid"  : $("#h_scaleOutUid").val(),
				"scaleOutName" : $("#scaleOutName").val(),
				"appName" : $("#hid_appName").val(),
				"nameSpace" : $("#hid_nameSpace").val(),
				"cloudId" : cloudId
		};

		$.ajax({
			url : "${contextPath}/mbr/req/catalogue/delete",
			dataType : "JSON",
			type : "POST",
			data : setData,
			success : function(data) {
				var result = data.result;
				if(data==1){
					alertBox("삭제되었습니다.", moveListPage);
				}else{
					errorBox("failed!!");
				}
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});
	};

	function deleteScaleOut(){
		confirmBox("삭제하시겠습니까?",ajaxDeleteScaleOut);
	}

	//등록페이지이동
	function moveInsertPage(){

		var params = "?scaleOutUid=" + $("#h_scaleOutUid").val();
		location.href = "${contextPath}/mbr/oss/app/scaleOutWrite"+params;
	}

	$(document).ready(function() {
		App.init();
		getDetail();
		gridAppList();
		//메뉴활성화
		$("#myGoods").addClass("active");
		$("#managementApp").addClass("active");


	});

  	function moveDetailPage(appUid,projectId,cloudId){
		var params = "?appUid="+appUid;
		params += "&projectId="+projectId;
		params += "&cloudId="+cloudId;
		location.href = "${contextPath}/mbr/application/req/detail"+params;

 	}


</script>

</body>
</html>
