<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
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
		<c:import url="../include/import.jsp" charEncoding="UTF-8"></c:import>
		<title>KEPCO Cloud Service Platform</title>
	</head>

	<body>
		<!-- begin #page-container -->
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
			<!-- begin #header -->
			<c:import url="../../mbr/include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->
			<!-- begin #sidebar -->
			<c:import url="../../mbr/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->
			<!-- begin #content -->
			<div id="content" class="content">
				<input type="hidden" id="hid_mbrProjectResourcesList_button" value="1">


				<div class="dashboard mt0">
				    <div class="col-md-12 pl0 pr0">
				      <div class="col-md-3">
				      <h3 class="d_title">시스템 운영 현황</h3>
				      <div class="wbox height-220 col-md-12 pb-20">
				         <div class="col-md-4 mt20" style="cursor:pointer;">
				           <h3 class="alarm_r">  ${eventCnt.criticalCnt eq null? 0:eventCnt.criticalCnt}</h3>
				           <p class="alarm_red"> 심각</p>
				          </div>
				         <div class="col-md-4 mt20" style="cursor:pointer;">
				         	<h3 class="alarm_o"> ${eventCnt.warningCnt eq null? 0:eventCnt.warningCnt}</h3>
				            <p class="alarm_orange">위험</p>
				         </div>
				         <div class="col-md-4 mt20" style="cursor:pointer;">
				           <h3 class="alarm_g"> ${eventCnt.infoCnt eq null? 0:eventCnt.infoCnt}</h3>
				           <p class="alarm_green">주의</p>
				          </div>

				      </div>
				      </div>
				      <div class="col-md-2">
				      <h3 class="d_title">SERVER CPU TOP5</h3>
				       <div class="wbox height-220">
				             <canvas id="myChart1" style="height:200px; width:200px"></canvas>
				       </div>
				      </div>
				      <div class="col-md-2">
				      <h3 class="d_title">SERVER MEMORY TOP5</h3>
				       <div class="wbox height-220">
				            <canvas id="myChart2"  style="height:200px; width:200px"></canvas>
				        </div>
				      </div>


				      <div class="col-md-5">
				      <h3 class="d_title">신청 및 승인 현황</h3>
				       <div class="wbox height-220 col-md-12">
				            <div class="col-md-3 tac"  onclick="projectReqLink()" style="cursor:pointer;">
				              <p class="grey_w">${mbrProjectReq.projectReqCount}</p>
				              <h4 class="sin_title">프로젝트 신청</h4>
				              <p class="new_sin_txt"> 회원만 프로젝트 신청이 가능합니다. </p>
				            </div>
				             <div class="col-md-3 tac pl0 pr0" onclick="productReqLink()" style="cursor:pointer;">
				             <p class="grey_w">${mbrProductReq.productReqCount}</p>
				              <h4 class="sin_title">자원 신청/변경</h4>
				              <p class="new_sin_txt"> 자원을 신청·변경·삭제 하실 수 있습니다.  </p>
				             </div>
				              <div class="col-md-3 tac" onclick="projectApproveLink()" style="cursor:pointer;">
				              <p class="grey_w">${mbrProjectApprove.projecApproveCount}</p>
				              <h4 class="sin_title">프로젝트 승인</h4>
				              <p class="new_sin_txt">승인이 완료된 후 자원 신청이 가능 합니다.</p>
				              </div>
				               <div class="col-md-3 tac pl0 pr0" onclick="productApproveLink()" style="cursor:pointer;">
				               <p class="grey_w" >${mbrProductApprove.productApproveCount}</p>
				              <h4 class="sin_title">자원승인 </h4>
				              <p class="new_sin_txt"> 자원 승인이 완료된 후 바로 사용이 가능합니다.</p>
				               </div>

				       </div>
				      </div>
				    </div>
				    <div class="clear"></div>


				    <div class="col-md-12 mt50">
				    	<div style="display:flex; align-items:center; margin-bottom:14px;">
					         <h3 class="d_title" style="display:inline-block; margin-bottom:0;">프로젝트 자원현황 </h3>
					         <ul class="nav nav-pills" style="display:flex; align-items:center; gap:10px;">
	                            <li class="active"><a href="#nav-pills-tab-1" data-toggle="tab">IaaS</a></li>
	                            <!-- <li><a href="#nav-pills-tab-2" data-toggle="tab">PaaS</a></li> -->
	                        </ul>
	                    </div>

				         <div class="tab-content panel">
                            <div class="tab-pane fade active in" id="nav-pills-tab-1">
                               <div class="col-md-12 pr0 mb10">
							 	 <select class="form-control w30 flr" id="projectBoxId" onchange="movePageReload();">
									<option value="ALLPROJECT">전체</option>
									<c:forEach items="${getProjectList}" var="getProjectList" varStatus="status" >
									  <option value="${getProjectList.projectBoxId}">${getProjectList.projectAlias}</option>
                                    </c:forEach>
								</select>


								</div>
								<div class="clear"></div>
								<div class="col-md-12">
									<div class="col-md-2 w2"></div>
									<div class="col-md-2 w2"></div>
									<c:forEach items="${mbrProjectResources}" var="mbrProjectResources" varStatus="status" >

  										<c:if test="${mbrProjectResources.zoneName eq 'fa-zone'}">
  										    <div class="col-md-1 tac f12 lh14 w1b">${mbrProjectResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 tac f12 lh14 w1b">${mbrProjectResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 tac f12 lh14 w1b">${mbrProjectResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 tac f12 lh14 w1b">${mbrProjectResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 tac f12 lh14 w1b">${mbrProjectResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 tac f12 lh14 w1b">${mbrProjectResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 tac f12 lh14 w1b">${mbrProjectResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 tac f12 lh14 w1b">${mbrProjectResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 tac f12 lh14 w1b">${mbrProjectResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 tac f12 lh14 w1b">${mbrProjectResources.zoneDisplayName}</div>
                                        </c:if>

									</c:forEach>
								</div>

								<div class="col-md-12 main-resource-grey">
									<div class="col-md-2 w2"><img src="/resources/assets/img/icon_server.png" class="height-30"> SERVER(EA)</div>
									<div class="col-md-2 w2"> </div>

									<c:forEach items="${mbrProjectResources}" var="mbrProjectResources" varStatus="status" >
							 		    <c:if test="${mbrProjectResources.zoneName eq 'fa-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.serverCnt}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.serverCnt}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.serverCnt}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.serverCnt}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.serverCnt}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.serverCnt}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.serverCnt}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-DMZ'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.serverCnt}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.serverCnt}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-DMZ'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.serverCnt}" type="number"/></div>
                                        </c:if>
                                    </c:forEach>
								</div>
								<div class="col-md-12 main-resource-lblue">
									<div class="col-md-2"><img src="/resources/assets/img/icon_cpu.png" class="height-30"> vCPU(CORE)</div>
									<div class="col-md-2"></div>


									<c:forEach items="${mbrProjectResources}" var="mbrProjectResources" varStatus="status" >
									 	<c:if test="${mbrProjectResources.zoneName eq 'fa-zone'}">
                                           <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.vcpus}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.vcpus}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.vcpus}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.vcpus}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.vcpus}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.vcpus}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.vcpus}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.vcpus}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.vcpus}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.vcpus}" type="number"/></div>
                                        </c:if>
                                    </c:forEach>
								</div>
								<div class="col-md-12 main-resource-grey">
									<div class="col-md-2"><img src="/resources/assets/img/icon_mem.png" class="height-30"> MEMORY (GB)</div>
									<div class="col-md-2"></div>
									<c:forEach items="${mbrProjectResources}" var="mbrProjectResources" varStatus="status" >
									    <c:if test="${mbrProjectResources.zoneName eq 'fa-zone'}">
									       <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.memGb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.memGb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.memGb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.memGb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.memGb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.memGb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.memGb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.memGb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.memGb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.memGb}" type="number"/></div>
                                        </c:if>
                                      </c:forEach>

								</div>
								<div class="col-md-12 main-resource-lblue">
									<div class="col-md-2"><img src="/resources/assets/img/icon_disk.png" class="height-30"> OS DISK (GB)</div>
									<div class="col-md-2"></div>
									<c:forEach items="${mbrProjectResources}" var="mbrProjectResources" varStatus="status" >
									    <c:if test="${mbrProjectResources.zoneName eq 'fa-zone'}">
									       <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.osDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.osDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.osDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.osDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.osDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.osDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.osDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.osDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.osDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.osDisk}" type="number"/></div>
                                        </c:if>
                                      </c:forEach>
								</div>
								<div class="col-md-12 main-resource-grey">
									<div class="col-md-2"> <img src="/resources/assets/img/icon_disk.png" class="height-30"> DATA DISK (GB)</div>
									<div class="col-md-2"></div>
									<c:forEach items="${mbrProjectResources}" var="mbrProjectResources" varStatus="status" >
									    <c:if test="${mbrProjectResources.zoneName eq 'fa-zone'}">
									       <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.dataDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.dataDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.dataDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.dataDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.dataDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.dataDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.dataDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.dataDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.dataDisk}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrProjectResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrProjectResources.dataDisk}" type="number"/></div>
                                        </c:if>
                                      </c:forEach>
								</div>
							</div>

							 <div class="tab-pane fade" id="nav-pills-tab-2">
								 <div class="main_paas">
									<div class="paas_sub">
									   <h4><img src="/resources/assets/img/icon_application.svg" height="18px" class="mr5"/>Application (EA)</h4>
									   <ul>
									    <li class="left">OA PaaS</li><li class="right"><span class="fc_red_im pr5">4</span>EA</li>
									    <li class="left">DMZ PaaS</li><li class="right"><span class="fc_red_im pr5">19</span>EA</li>
									    </ul>
									</div>
									<div class="paas_sub">
									   <h4 class="bl"><img src="/resources/assets/img/icon_router.svg" height="18px" class="mr5"/>Router (EA)</h4>
									   <ul>
									    <li class="left">OA PaaS</li><li class="right"><span class="fc_red_im pr5">4</span>EA</li>
									    <li class="left">DMZ PaaS</li><li class="right"><span class="fc_red_im pr5">19</span>EA</li>
									    </ul>
									</div>
									<div class="paas_sub">
									   <h4><img src="/resources/assets/img/icon_service.svg" height="18px" class="mr5"/>Service (EA)</h4>
									   <ul>
									    <li class="left">OA PaaS</li><li class="right"><span class="fc_red_im pr5">4</span>EA</li>
									    <li class="left">DMZ PaaS</li><li class="right"><span class="fc_red_im pr5">19</span>EA</li>
									    </ul>
									 </div>
									<div class="paas_sub">
									 <h4 class="bl"><img src="/resources/assets/img/icon_pod.svg" height="18px" class="mr5"/>Pod (EA)</h4>
									 <ul>
									    <li class="left">OA PaaS</li><li class="right"><span class="fc_red_im pr5">4</span>EA</li>
									    <li class="left">DMZ PaaS</li><li class="right"><span class="fc_red_im pr5">19</span>EA</li>
									    </ul>
									</div>
									<div class="paas_sub">
								      <h4><img src="/resources/assets/img/icon_build.svg" height="18px" class="mr5"/>Build (EA)</h4>
								      <ul>
									    <li class="left">OA PaaS</li><li class="right"><span class="fc_red_im pr5">4</span>EA</li>
									    <li class="left">DMZ PaaS</li><li class="right"><span class="fc_red_im pr5">19</span>EA</li>
									    </ul>
									</div>
								</div>
				  		  </div>
				    </div>

				    </div>



				    <div class="col-md-12 mt30">
				    <h3 class="d_title" >서비스 현황</h3>
				    <div class="main-content" style="display:inline-block; ">
								<div class="col-md-12">
									<div class="col-md-2 w2"></div>
									<div class="col-md-2 w2"></div>

								<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
  										    <div class="col-md-1 tac f12 lh14 w1b">${mbrServiceResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 tac f12 lh14 w1b">${mbrServiceResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 tac f12 lh14 w1b">${mbrServiceResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 tac f12 lh14 w1b">${mbrServiceResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 tac f12 lh14 w1b">${mbrServiceResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 tac f12 lh14 w1b">${mbrServiceResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 tac f12 lh14 w1b">${mbrServiceResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 tac f12 lh14 w1b">${mbrServiceResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 tac f12 lh14 w1b">${mbrServiceResources.zoneDisplayName}</div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 tac f12 lh14 w1b">${mbrServiceResources.zoneDisplayName}</div>
                                        </c:if>
									</c:forEach>

								</div>

								<div class="col-md-12 service_color01">
									<div class="col-md-2"><img src="/resources/assets/img/order_ser_backup.png" class="height-30"> 한전 백업 서비스</div>
									<div class="col-md-2 f15 fc66"> 중요 데이터 백업</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeBackup}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeBackup}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeBackup}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeBackup}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeBackup}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeBackup}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeBackup}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeBackup}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeBackup}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeBackup}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>
								<div class="col-md-12 service_color02">
									<div class="col-md-2"><img src="/resources/assets/img/ser_03.png" class="height-30"> 오라클 DB 서비스</div>
									<div class="col-md-2 f15 fc66">오라클 19C(RAC) DB 스키마</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeOracle}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeOracle}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeOracle}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeOracle}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeOracle}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeOracle}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeOracle}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeOracle}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeOracle}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeOracle}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>
								<div class="col-md-12 service_color03">
									<div class="col-md-2"><img src="/resources/assets/img/order_ser_load.png" class="height-30">로드밸런싱</div>
									<div class="col-md-2 f15 fc66">서비스 로드분산</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeLoadbalancer}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeLoadbalancer}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeLoadbalancer}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeLoadbalancer}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeLoadbalancer}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeLoadbalancer}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeLoadbalancer}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeLoadbalancer}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeLoadbalancer}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeLoadbalancer}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>
								<div class="col-md-12 service_color04">
									<div class="col-md-2"><img src="/resources/assets/img/order_ser_account.png" class="height-30">한전 계정관리</div>
									<div class="col-md-2 f15 fc66"> HI-WARE 연계</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAccount}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAccount}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAccount}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAccount}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAccount}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAccount}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAccount}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAccount}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAccount}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAccount}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>
								<div class="col-md-12 service_color05">
									<div class="col-md-2"><img src="/resources/assets/img/order_ser_snap.png" class="height-30">스냅샷</div>
									<div class="col-md-2 f15 fc66">특정 시간에 파일시스템을 보관</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeSnapshot}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeSnapshot}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeSnapshot}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeSnapshot}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeSnapshot}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeSnapshot}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeSnapshot}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeSnapshot}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeSnapshot}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeSnapshot}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>

								<div class="col-md-12 service_color01">
									<div class="col-md-2"><img src="/resources/assets/img/service_apache.png" class="height-30">Apache 설치</div>
									<div class="col-md-2 f15 fc66">Apache 설치</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeApache}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeApache}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeApache}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeApache}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeApache}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeApache}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeApache}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeApache}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeApache}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeApache}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>



								<div class="col-md-12 service_color02">
									<div class="col-md-2"><img src="/resources/assets/img/service_tomcat.png" class="height-30">Tomcat 설치</div>
									<div class="col-md-2 f15 fc66">Tomcat 설치</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeTomcat}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeTomcat}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeTomcat}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeTomcat}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeTomcat}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeTomcat}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeTomcat}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeTomcat}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeTomcat}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeTomcat}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>


								<div class="col-md-12 service_color03">
									<div class="col-md-2"><img src="/resources/assets/img/service_jboss.png" class="height-30">JBoss 설치</div>
									<div class="col-md-2 f15 fc66">JBoss 설치</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeJboss}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeJboss}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeJboss}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeJboss}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeJboss}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeJboss}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeJboss}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeJboss}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeJboss}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeJboss}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>



								<div class="col-md-12 service_color04">
									<div class="col-md-2"><img src="/resources/assets/img/service_maria.png" class="height-30">MariaDB 설치</div>
									<div class="col-md-2 f15 fc66">MariaDB 설치</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeMariadb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeMariadb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeMariadb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeMariadb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeMariadb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeMariadb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeMariadb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeMariadb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeMariadb}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeMariadb}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>

								<div class="col-md-12 service_color05">
									<div class="col-md-2"><img src="/resources/assets/img/service_postgresql.png" class="height-30">PostgreSQL 설치</div>
									<div class="col-md-2 f15 fc66">PostgreSQL 설치</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypePostgresql}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypePostgresql}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypePostgresql}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypePostgresql}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypePostgresql}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypePostgresql}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypePostgresql}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypePostgresql}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypePostgresql}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypePostgresql}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>


								<div class="col-md-12 service_color01">
									<div class="col-md-2"><img src="/resources/assets/img/service_cubrid.png" class="height-30">Cubrid 설치</div>
									<div class="col-md-2 f15 fc66">Cubrid 설치</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCubrid}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCubrid}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCubrid}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCubrid}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCubrid}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCubrid}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCubrid}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCubrid}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCubrid}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCubrid}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>

								<div class="col-md-12 service_color01">
									<div class="col-md-2"><img src="/resources/assets/img/server_icon.png" class="height-30">오토스케일링</div>
									<div class="col-md-2 f15 fc66">오토스케일링</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAscl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAscl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAscl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAscl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAscl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAscl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAscl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAscl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAscl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeAscl}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>


								<div class="col-md-12 service_color01">
									<div class="col-md-2"><img src="/resources/assets/img/special_icon06.png" class="height-30">컨테이너터미널</div>
									<div class="col-md-2 f15 fc66">컨테이너터미널</div>
									<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
  										<c:if test="${mbrServiceResources.zoneName eq 'fa-zone'}">
									        <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCtntrmnl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-zone'}">
                                          	<div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCtntrmnl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-dev-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCtntrmnl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'nova'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCtntrmnl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'OA-VM-Cluster'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCtntrmnl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'oa-hci-zone'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCtntrmnl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-Mobile'}">
                                            <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCtntrmnl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'EM-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCtntrmnl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-mobile'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCtntrmnl}" type="number"/></div>
                                        </c:if>
                                        <c:if test="${mbrServiceResources.zoneName eq 'PA-DMZ'}">
                                             <div class="col-md-1 w1b"><fmt:parseNumber value="${mbrServiceResources.serviceTypeCtntrmnl}" type="number"/></div>
                                        </c:if>
									</c:forEach>
								</div>

								<!-- <div class="col-md-12 service_color06">
									<div class="col-md-2"><img src="/resources/assets/img/order_ser_disk.png" class="height-30">디스크관리</div>
									<div class="col-md-2 f15 fc66"> 디스크 관리 서비스</div>
									<div class="col-md-1 w1b">13</div>
									<div class="col-md-1 w1b">0</div>
									<div class="col-md-1 w1b">9</div>
									<div class="col-md-1 w1b">0</div>
									<div class="col-md-1 w1b">0</div>
									<div class="col-md-1 w1b">1</div>
									<div class="col-md-1 w1b">2</div>
								</div>
								<div class="col-md-12 service_color01">
									<div class="col-md-2"><img src="/resources/assets/img/catalogIcon01.png" class="height-30">GPU 서비스</div>
									<div class="col-md-2 f15 fc66"> GPU 서비스</div>
									<div class="col-md-1 w1b">0</div>
									<div class="col-md-1 w1b">0</div>
									<div class="col-md-1 w1b">0</div>
									<div class="col-md-1 w1b">0</div>
									<div class="col-md-1 w1b">9</div>
									<div class="col-md-1 w1b">9</div>
									<div class="col-md-1 w1b">9</div>
								</div> -->


						</div>
				    </div>
				</div>
				<!-- end page-body -->
				<div class="clear"></div>
		        <div id="footer" class="footer">
					<p>(우) 58322 전라남도 나주시 전력로 55 Copyright ⓒ 2020  KEPCO.   All rights reserved.</p>
				</div>
			</div>
		</div>


		<c:import url="../../mbr/include/script.jsp" charEncoding="UTF-8"></c:import>
	    <script type='text/javascript' src="${apachePath}/resources/js/chart.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				App.init();
				mbrProjectResourcesList(1);
				if($("#loginFlag").val()!="Y") {
					$("#dashboard").addClass("active");
				}

				if('${projectBoxId}' === ''){
					alertBox3("K-Cloud 관련 문의사항은 <br> 사용문의 -> Q&A 게시판에 등록 바랍니다.");
				}else{
					$("#projectBoxId").val('${projectBoxId}').attr("selected", "selected");
				}

			});



			function movePageReload(){
				var	params = "&projectBoxId="+$("#projectBoxId option:selected").val();

				location.href = "${wasPath}/mbr/mbrhome/dashboard?loginFlag=Y"+params;
			}




			function mbrProjectResourcesList(gubun) {
				var gubunText = gubun;
				var urlText = "";

					if(gubunText == '1'){
						urlText = "/mbr/mbrhome/mbrProjectResourcesList"
							$("#hid_mbrProjectResourcesList_button").val("1");
						$("#button1").hide();
						$("#button2").show();

					}else{
						urlText = "/mbr/mbrhome/mbrProjectResourcesListTotal"
							$("#hid_mbrProjectResourcesList_button").val("2");
						$("#button1").show();
						$("#button2").hide();
					}

				$.ajax({
					url : urlText,
					dataType : "JSON",
					type : "GET",
					success : function(data) {
						// 현재 사용 용량 팝업 부분
						var projectList = data;
						var html = "";
						var allHtml = "";
						$("#useVolumeTable > table").remove();
						html += "<table class='tableWV mt20'>";
				        html += "	<colgroup>";
						html += " 		<col width='*'/>";
						html += " 		<col width='10%'>";
						html += " 		<col width='10%'>";
						html += " 		<col width='13%'>";
						html += " 		<col width='13%'>";
						html += " 		<col width='13%'>";
						html += " 	</colgroup>";
						html += "	<thead>";
						html += "	    <tr>";
						html += "			<th>프로젝트명</th>";
						html += "			<th class='fc-dblue'>SERVER(EA)</th>";
						html += "			<th class='fc-dgreen'>vCPU(Core)</th>";
						html += "			<th class='fc-dbrown'>MEMORY(GB)</th>";
						html += "			<th class='fc-dviolet'> OS DISK(GB)</th>";
						html += "			<th class='fc-grey3'>DATA DISK(GB)</th>";
						html += "		</tr>";
						html += "	</thead>";
						html += "	<tbody>";

						$.each(projectList,function(key,val){


								allHtml += "		<tr>";
								allHtml += "			<td class='tal'>"+val["projectAlias"]+"</td>";
								allHtml += "			<td class='tar'>"+val["serverCnt"]+"</td>";
								allHtml += "			<td class='tar'>"+val["vcpus"]+"</td>";
								allHtml += "			<td class='tar'>"+val["memGb"]+"</td>";
								allHtml += "			<td class='tar'>"+val["osDisk"]+"</td>";
								allHtml += "			<td class='tar'>"+val["dataDisk"]+"</td>";
								allHtml += "		</tr>";

						});
						html += allHtml;

						html += "	</tbody> ";
						html += "</table>    " ;
						$("#useVolumeTable").append(html);

					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}



				//링크 모음 시작

			// 프로젝트 신청현황 페이지 이동
			function projectReqLink(){
				location.href = "${contextPath}/mbr/req/project/projectList.do";
			}
			// 자원 신청현황 페이지 이동
			function productReqLink(){
				location.href = "${contextPath}/mbr/req/catalogue/bssOrderList";
			}
			// 프로젝트 승인 페이지 이동
			function projectApproveLink(){
				location.href = "${contextPath}/mbr/req/project/projectApproveList.do";
			}
			// 자원 승인 페이지 이동
			function productApproveLink(){
				location.href = "${contextPath}/mbr/req/catalogue/bssOrderApproveList";
			}
			// 서비스 이용현황 페이지 이동
// 			function projectServiceReqLink(){
// 				location.href = "${contextPath}/mbr/project/service/";
// 			}

			// 프로젝트 자원 현황,
			function projectProduct1(){
				location.href = "${contextPath}/mbr/project/vm/";
			}
			// 서비스 이용현황 페이지 이동
			function projectProduct2(){
				location.href = "${contextPath}/mbr/project/disk/";
			}

				//링크 모음 끝

		   const ctx1 = document.getElementById('myChart1');
		   const ctx2 = document.getElementById('myChart2');

		   new Chart(ctx1, {
			    type: 'bar',
			    data: {
			      labels: ['-', '-', '-', '-', '-'],
			      datasets: [{
			        data: [0, 0, 0, 0, 0],
			        borderWidth: 0,
			        backgroundColor: '#325584'
			      }]
			    },
			    options: {
                  legend:false,
			      responsive: false,
			      scales: {
			        y: {
			          beginAtZero: true
			        }
			      },
		        plugins: {

		        }
			    }
			  });

			      new Chart(ctx2, {
			    type: 'bar',
			    data: {
			      labels: ['-', '-', '-', '-', '-'],
			      datasets: [{
			        label: '# of Votes',
			        data: [0, 0, 0, 0, 0],
			        borderWidth: 0,
			        backgroundColor: '#4975af'
			      }]
			    },
			    options: {
			      legend:false,
			      responsive: false,
			      scales: {
			        y: {
			          beginAtZero: true
			        }
			      },
			      plugins: {

			        }
			    }
			  });


		</script>

	</body>
</html>