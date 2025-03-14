<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname" />
</sec:authorize>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<c:set var="search" value='"' />
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
		<div class="main">
			<!-- begin #sidebar -->
			<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #content -->
			<div id="content" class="content mng-req-product-wiew-wrap">
				<!-- begin #content header -->
				<div class="page_header m-b-30">
					<h1>자원요청 승인</h1>
					<div class="pageNav">
						<a href="#" class="home"><i></i></a><a href="#">승인/작업 처리</a><a href="#" class="on">자원요청 승인</a>
					</div>
				</div>
				<!-- end #content header -->

				<!-- begin #content page-body -->
				<div class="card">
					<input type="hidden" id="h_userId" value="${userId}"> <input type="hidden" id="h_userName" value="${userName}"> <input type="hidden" id="h_projectId" value="${projectInfo.projectId}"> <input type="hidden" id="h_projectAlias" value="${projectInfo.projectAlias}"> <input type="hidden" id="h_managerId" value="${projectInfo.managerId}"> <input type="hidden" id="h_managerName" value="${projectInfo.managerName}"> <input type="hidden" id="apprvPass" value="${apprvPass}" />
					<!-- 					<input type="hidden" id="apprvPass"				value="Y" /> -->
					<input type="hidden" id="selectApprv" value="" />
					<!-- begin page-body 버튼박스  -->
					<div>
						<c:forEach items="${getProductAppSteplist}" var="productApprovalStepInfo" varStatus="status">
							<c:choose>
								<c:when test="${productApprovalStepInfo.apprvState eq 'APPRV_UNASSIGNED' and productApprovalStepInfo.stepLevel > 4}">

									<div class="row tac m-t-50">
										<a type="button" class="rbton bton_blue" onclick="openApproveReviewModal(2)"><i class="fa fa-pencil"></i> 신청</a> <a type="button" class="rbton bton_orange" onclick="projectRejectedPopup('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-reply"></i> 반려</a> <a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
									</div>
								</c:when>
								<c:when test="${productApprovalStepInfo.apprvAuth eq 'Y' and productApprovalStepInfo.apprvState eq 'APPRV_PROCESSING' and productApprovalStepInfo.stepLevel > 4}">
									<c:choose>
										<c:when test="${productApprovalStepInfo.apprvState eq 'APPRV_PROCESSING' and productApprovalStepInfo.stepId eq stepId }">
											<div class="row tac m-t-50">
												<a type="button" class="rbton bton_blue" onclick="projectApprving('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-gavel"></i> 승인</a> <a type="button" class="rbton bton_orange" onclick="projectRejectedPopup('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-reply"></i> 반려</a> <a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
											</div>
										</c:when>
										<c:otherwise>
											<c:if test="${productApprovalStepInfo.apprvState != 'APPRV_PROCESSING' and productApprovalStepInfo.stepId eq stepId }">
												<div class="row tac m-t-50">
													<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
												</div>
											</c:if>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:if test="${productApprovalStepInfo.stepId eq stepId }">
										<div class="row tac m-t-50">
											<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
										</div>
									</c:if>
								</c:otherwise>
							</c:choose>

							<c:if test="${inject eq 'Y' and  productApprovalStepInfo.apprvState eq 'APPRV_REJECTED'}">
								<h2 class="titleBuType01 m-t-40 m-b-15">반려사유</h2>
								<textarea rows="5" placeholder="비고란 입니다. 내용을 입력하세요" id="rejectedApprvDescription" name="rejectedApprvDescription" readonly>${productApprovalStepInfo.apprvDescription}</textarea>
								<div class="row tac m-t-50">
									<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
								</div>
							</c:if>
						</c:forEach>
					</div>
					<!-- end page-body 버튼박스  -->


					<!-- begin page-body 프로젝트 정보  -->
					<div class="client_DetailArea mt20">
						<!-- 프로젝트 정보 -->
						<h2 class="customer_Id">${projectInfo.projectName}</h2>
						<div class="clear"></div>
						<h3 class="pname dpin">${projectInfo.projectAlias}</h3>
						<div class="clear"></div>
						<div class="mt20">
							<span class="dpin fb fc-blue2">본부 : </span><span class="ml5">${fn:split(projectInfo.deptName2,'/')[1]}</span><span class="dpin fb ml40 fc-blue2">처(실) : </span><span class="ml5">${fn:split(projectInfo.deptName2,'/')[2]} </span><span class="dpin fb ml40 fc-blue2">부서 : </span><span class="ml5">${fn:split(projectInfo.deptName2,'/')[3]} </span><span class="dpin fb ml40 fc-blue2">담당자 : </span><span class="ml5">${projectInfo.customerName}(${projectInfo.managerTel})</span>
						</div>
						<div class="fileList mt10">
							<div class="wrap">
								<strong>첨부파일</strong>
								<ul class="m-t-10">
									<c:forEach items="${file}" var="filelist" varStatus="status">
										<li><span class="f15 fc11">${filelist.fileName}</span> <span class="f15 fc66 fontVdn">(${filelist.fileTranSize})</span> <a href="${contextPath}/mbr/cmm/file/download/${filelist.fileId}" class="btn_download ml20"></a></li>
									</c:forEach>
								</ul>
							</div>
						</div>

						<!-- 프로젝트 내 현재 가용 용량  -->
						<div class="usageStatusWrap mt20">
							<strong class="titleLabel">현재 가용 용량</strong>
							<c:forEach items="${getCloudAvailListVo}" var="getCloudAvailListVo" varStatus="status">
								<dl>
									<dt>
										<c:out value="${getCloudAvailListVo.projectName}"></c:out>
									</dt>
									<dd>
										<span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>SERVER</span><span class="cnt"><em class="fc-orange" id="allVmAvail"><fmt:formatNumber value="${getCloudAvailListVo.vmAvail}" pattern="#,###" /></em>EA</span>
									</dd>
									<dd>
										<span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>vCPU</span><span class="cnt"><em class="fc-violet" id="allVcpuAvail"><fmt:formatNumber value="${getCloudAvailListVo.vcpuAvail}" pattern="#,###" /></em>Core</span>
									</dd>
									<dd>
										<span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>MEMORY</span><span class="cnt"><em class="fc-blue" id="allMemAvail"><fmt:formatNumber value="${getCloudAvailListVo.memAvail}" pattern="#,###" /></em>GB</span>
									</dd>
									<dd>
										<span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>DISK</span><span class="cnt"><em class="fc-green" id="allDiskAvail"><fmt:formatNumber value="${getCloudAvailListVo.diskAvail}" pattern="#,###" /></em>GB</span>
									</dd>
									<dd class="mt30">
										<a type="button" onclick="useVolumeDetail('${getCloudAvailListVo.projectId}');"><button class="cbton bton_blue">
												<i class="fa fa-battery-half ml-2"></i>
											</button></a>
									</dd>
								</dl>
							</c:forEach>
						</div>
					</div>

					<!-- end page-body 프로젝트 정보  -->
					<!-- begin page-body 자원상세목록  -->
					<div class="detailView">
						<span class="f16 fc11"></span> <span class="icon"></span>
					</div>

					<div class="detailVeiwArea p30 b5dc mt20">

						<c:set var="amount" value="" />
						<input type="hidden" id="list" name="list" value="${getReqlistvo.size()}"> <input type="hidden" id="onDemandFlag" value=""> <input type="hidden" id="allOrderNo" value="${orderNo}"> <input type="hidden" id="stepId" value="${stepId}"> <input type="hidden" id="userApprvState" value="${userApprvState}"> <input type="hidden" id="h_hostname" value=""> <input type="hidden" id="h_ip" value=""> <input type="hidden" id="h_backupIp" value=""> <input type="hidden" id="h_vmUserId" value=""> <input type="hidden" id="h_vmUserPw" value=""> <input type="hidden" id="h_orderNo" value="">


						<!-----기본자원 시작------->
						<h2 class="titleBuType01 m-b-15">기본자원</h2>
						<div class="tableBorderArea">
							<c:if test='${getReqlistvo.size() eq 0}'>
								<div class="tac orderBg">
									<i class="noOrder"></i> <span class="fc66 f18">신청 내역이 없습니다.</span>
								</div>
							</c:if>

							<c:if test='${getReqlistvo.size() ne 0}'>
								<h2 class="f16 fc11 m-b-12">가상서버</h2>
								<table class="detail_Table" style="table-layout: auto;">
									<colgroup>

										<c:choose>
											<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
												<col width="30px">
											</c:when>
										</c:choose>
										<col width="10%">
										<!--  요청유형 -->
										<col width="10%">
										<!-- 프로젝트명 -->
										<col width="*">
										<!-- 클라우드 -->
										<col width="10%">
										<!-- 서버명 -->
										<col width="10%">
										<!-- 서버 유형 -->
										<col width="10%">
										<!-- 네트워크 -->
										<col width="15%">
										<!--  oS -->
										<col width="80px">
										<!-- cpu -->
										<col width="80px">
										<!-- memory -->
										<col width="80px">
										<!-- disk -->
										<col width="90px">
										<!-- 작업결과 -->
										<col width="90px">
									</colgroup>
									<thead>
										<tr>
											<c:choose>
												<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
													<th></th>
												</c:when>
											</c:choose>
											<th>요청유형</th>
											<th>클라우드</th>
											<th>프로젝트</th>
											<th>서버명</th>
											<th>서버유형</th>
											<th>네트워크</th>
											<th>OS</th>
											<th>vCPU (Core)</th>
											<th>MEMORY (GB)</th>
											<th>DISK (GB)</th>
											<th>작업결과</th>
											<th>상세보기</th>
										</tr>
									</thead>
									<tbody>

										<c:set var="idNum" value="0" />
										<c:forEach items="${getReqlistvo}" var="getBasketlistvo" varStatus="status">
											<tr>
												<c:choose>
													<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
														<td class="tac"><input type="checkbox" name="projectIdchk" id="${getBasketlistvo.orderProductSeq}" value="${getBasketlistvo.orderProductSeq}" /></td>
													</c:when>
												</c:choose>

												<td class="tac onwrap"><a class="accordion-toggle accordion-toggle-styled" data-toggle="collapse" data-parent="#theme-accordion" href="#Asub"> <i class="fa fa-plus-circle"></i>
												</a> <c:if test="${getBasketlistvo.requestName eq '신규'}">
														<span class="statusLabel_small status_new">신규</span>
													</c:if> <c:if test="${getBasketlistvo.requestName eq '변경'}">
														<span class="statusLabel_small status_new">변경</span>
													</c:if> <c:if test="${getBasketlistvo.requestName eq '해지'}">
														<span class="statusLabel_small status_out">삭제</span>
													</c:if></td>
												<td class="tac fc11">${getBasketlistvo.cloudName}</td>
												<td class="tac fc11">${getBasketlistvo.projectAlias}</td>
												<td class="tac fc11">${getBasketlistvo.hostnameAlias}</td>
												<td class="tac fc11">${getBasketlistvo.instanceType}</td>
												<td class="tac fc11">${getBasketlistvo.networkAlias}</td>
												<td class="tac fc11"><a title="${getBasketlistvo.osProductName}">${getBasketlistvo.osProductName}</a></td>
												<td class="tac p-0 fontVdn">${getBasketlistvo.vcpus2}</td>
												<td class="tac p-0 fontVdn">${getBasketlistvo.memGb2}</td>
												<td class="tac p-0 fontVdn">${getBasketlistvo.vmDiskGb}</td>



												<td class="tac"><c:if test="${getBasketlistvo.provisioningStatus eq 'PROVISIONING_FAIL'}">
														<a class="statusLabel_small status_new" onclick="alertFailMessage('${fn:replace(fn:replace(getBasketlistvo.provisioningStatusMessage,'\'',''),search,'')}',${getBasketlistvo.orderProductSeq})">실패</a>
													</c:if> <c:if test="${getBasketlistvo.provisioningStatus eq 'PROVISIONING_SUCCESS'}">
														<span class="dpin fb fc-blue2")">성공</span>
													</c:if> <c:if test="${getBasketlistvo.provisioningStatus eq 'PROVISIONING_END'}">
														<a class="statusLabel_small status_new" onclick="alertEndMessage('${fn:replace(fn:replace(getBasketlistvo.endDescription,'\'',''),search,'')}')">작업종료</a>
													</c:if></td>
												<td class="lastCol p-0 tac"><a type=button type="button" class="cbton bton_lblue" onclick="productDetail('vm','${getBasketlistvo.orderProductSeq}');"> <i class="fa fa-search"></i>
												</a></td>
											</tr>

											<!-- -------------------- qkrwlans ---------------------------------------------------------------------------------------- -->
											<!-- ------------------------------------------------------------------------------------------------------------ -->

											<input type="hidden" id="h_vmImageType${idNum}" value="${getBasketlistvo.imageType}" />
											<input type="hidden" id="h_vmProductSeq${idNum}" value="${getBasketlistvo.vmProductSeq}" />
											<input type="hidden" id="h_osProductSeq${idNum}" value="${getBasketlistvo.osProductSeq}" />
											<input type="hidden" id="h_volumeType${idNum}" value="${getBasketlistvo.volumeType}" />
											<input type="hidden" id="h_defaultNetworkId${idNum}" value="${getBasketlistvo.defaultNetworkId}" />
											<input type="hidden" id="h_orderProductSeq${idNum}" value="${getBasketlistvo.orderProductSeq}" />
											<input type="hidden" id="h_vcpus${idNum}" value="${getBasketlistvo.vcpus}" />
											<input type="hidden" id="h_memGb${idNum}" value="${getBasketlistvo.memGb}" />
											<input type="hidden" id="h_falvorId" value="${getBasketlistvo.bastionFlavorId}" />
											<input type="hidden" id="h_requestType${idNum}" value="${getBasketlistvo.requestType}" />
											<input type="hidden" id="h_projectBoxId${idNum}" value="${getBasketlistvo.projectBoxId}" />
											<input type="hidden" id="h_instanceType${idNum}" value="${getBasketlistvo.instanceType}" />


											<tr>
												<td colspan="13" class="bbno p0">
													<div id="Asub" class="panel-collapse collapse in">
														<div class="panel-body">
															<table class="tableB w100 tableProductView">
																<colgroup>
																	<col width="33%">
																	<col width="33%">
																	<col width="33%">
																</colgroup>
																<tbody>
																	<tr>
																		<td class="tal"><span class="text">서버대역</span> <c:choose>
																				<c:when test="${stepId eq 'WF1000E0' and getBasketlistvo.requestType eq 'REQTYPE_NEW' and userApprvState eq 'APPRV_UNASSIGNED'}">

																					<select class="form-control dpin w50" name="azName" id="azName${idNum}" onChange="selectAz(${idNum});">
																				</c:when>
																				<c:otherwise>
																					<select disabled class="form-control dpin w50" name="azName" id="azName${idNum}" onChange="selectAz(${idNum});">
																				</c:otherwise>
																			</c:choose>

																			<option value="">대역선택</option> <c:if test="${getBasketlistvo.instanceType eq 'INSTANCE_GPU'}">
																				<c:forEach items="${getNetwork}" var="getNetwork" varStatus="status">
																					<%-- 																				<c:if test='getNetwork'></c:if> --%>
																					<c:if test="${getNetwork.zoneName eq 'oa-gpu-zone'}">
																						<c:if test='${getBasketlistvo.azName eq getNetwork.zoneName}'>
																							<option value="${getNetwork.zoneName}" selected data-cloud="${getNetwork.cloudId}" data-type="${getNetwork.cloudType}" data-name="${getNetwork.cloudName}">${getNetwork.zoneDisplayName}</option>
																						</c:if>
																						<c:if test='${getBasketlistvo.azName ne getNetwork.zoneName}'>
																							<option value="${getNetwork.zoneName}" data-cloud="${getNetwork.cloudId}" data-type="${getNetwork.cloudType}" data-name="${getNetwork.cloudName}">${getNetwork.zoneDisplayName}</option>
																						</c:if>
																					</c:if>
																				</c:forEach>
																			</c:if> <c:if test="${getBasketlistvo.instanceType ne 'INSTANCE_GPU'}">
																				<c:forEach items="${getNetwork}" var="getNetwork" varStatus="status">
																					<%-- 																				<c:if test='getNetwork'></c:if> --%>
																					<c:if test="${getNetwork.zoneName ne 'oa-gpu-zone'}">
																						<c:if test='${getBasketlistvo.azName eq getNetwork.zoneName}'>
																							<option value="${getNetwork.zoneName}" selected data-cloud="${getNetwork.cloudId}" data-type="${getNetwork.cloudType}" data-name="${getNetwork.cloudName}">${getNetwork.zoneDisplayName}</option>
																						</c:if>
																						<c:if test='${getBasketlistvo.azName ne getNetwork.zoneName}'>
																							<option value="${getNetwork.zoneName}" data-cloud="${getNetwork.cloudId}" data-type="${getNetwork.cloudType}" data-name="${getNetwork.cloudName}">${getNetwork.zoneDisplayName}</option>
																						</c:if>
																					</c:if>
																				</c:forEach>
																			</c:if> </select>
																		<td class="tal"><span class="text">네트워크</span> <c:choose>
																				<c:when test="${stepId eq 'WF1000E0' and getBasketlistvo.requestType eq 'REQTYPE_NEW' and userApprvState eq 'APPRV_UNASSIGNED'}">
																					<select class="form-control dpin w50ml10 " id="divNetwork${idNum}" onchange="osSenter();">
																				</c:when>
																				<c:otherwise>
																					<select disabled class="form-control dpin w50 ml10" id="divNetwork${idNum}" onchange="osSenter();">
																				</c:otherwise>
																			</c:choose> </select></td>

																		<c:forEach items="${getProductAppSteplist}" var="getProductAppSteplist" varStatus="status">
																			<c:if test="${getProductAppSteplist.stepLevel eq '1' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '2' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '3' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '4' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketlistvo.requestName eq '신규'}">
																				<c:if test="${getBasketlistvo.hostname eq null}">
																					<td class="tal"><span class="text">호스트명</span> <input name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /> <span class="bton-s bton_blue" onClick="saveHostNameCheck(document.getElementById('${getBasketlistvo.orderProductSeq}HostName').value,'${getBasketlistvo.orderProductSeq}');" value="저장">저장 </span></td>


																				</c:if>
																				<c:if test="${getBasketlistvo.hostname ne null}">
																					<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																				</c:if>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getBasketlistvo.hostname eq null  and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																				<td class="tal"><span class="text">호스트명</span> <input name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /> <span class="bton-s bton_blue" onClick="saveHostNameCheck(document.getElementById('${getBasketlistvo.orderProductSeq}HostName').value,'${getBasketlistvo.orderProductSeq}');" value="저장">저장 </span></td>

																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getBasketlistvo.hostname ne null and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규' or  getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketlistvo.requestName eq '신규'}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketlistvo.requestName eq '변경'}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.hostname ne null}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.hostname ne null}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.hostname ne null}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.hostname ne null}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketlistvo.requestName eq '해지'}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.hostname ne null}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.hostname ne null}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.hostname ne null}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.hostname ne null}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.hostname ne null}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.hostname ne null}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.hostname ne null}">
																				<td class="tal"><span class="text">호스트명</span> <input readonly name="hostName" type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}HostName" value="${getBasketlistvo.hostname}" /> <input type="hidden" name="hostNameChk" id="${getBasketlistvo.orderProductSeq}HostNameChk" value="${getBasketlistvo.hostname !='' && getBasketlistvo.hostname != null?'Y':'N'}" /></td>
																			</c:if>

																		</c:forEach>
																	<tr>
																		<td class="tal"><span class="text">클라우드</span> <input class="form-control w60 dpin ml10 h32" type="text" id="cloudName${idNum}" readonly="readonly" value="${getBasketlistvo.cloudName}" /> <!-- 									 <img src="/resources/assets/img/icon_search.png" onclick="openModal();" class="input_search"/> --></td>
																		<td class="tal"><span class="text">운영체제</span> <c:choose>
																				<c:when test="${stepId eq 'WF1000E0' and getBasketlistvo.requestType eq 'REQTYPE_NEW' and userApprvState eq 'APPRV_UNASSIGNED'}">
																					<select class="form-control dpin w50 ml10" id="osProductSeq${idNum}" onchange="osSenter();">
																				</c:when>
																				<c:otherwise>
																					<select disabled class="form-control dpin w50ml10 " id="osProductSeq${idNum}" onchange="osSenter();">
																				</c:otherwise>
																			</c:choose> </select></td>

																		<c:set var="defaultNetworkIpValue" value="${fn:split(getBasketlistvo.networkAlias, '/')}" />


																		<c:forEach items="${getProductAppSteplist}" var="getProductAppSteplist" varStatus="status">
																			<c:if test="${getProductAppSteplist.stepLevel eq '1' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '2' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '3' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '4' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketlistvo.requestName eq '신규'}">
																				<c:if test="${getBasketlistvo.defaultNetworkIp eq null}">
																					<td class="tal"><span class="text"> IP주소</span> <input type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${fn:substring(defaultNetworkIpValue[fn:length(defaultNetworkIpValue)-2], 0, fn:length(defaultNetworkIpValue[fn:length(defaultNetworkIpValue)-2])-1) }" data-orderNo="${getBasketlistvo.orderProductSeq}" data-cloudId="${getBasketlistvo.cloudId}" /> <input type="hidden" name="ipChk" id="${getBasketlistvo.orderProductSeq}IpChk" value="${getBasketlistvo.defaultNetworkIp !='' && getBasketlistvo.defaultNetworkIp != null?'Y':'N'}" /> <span class="bton-s bton_blue" onClick="saveIpCheck(document.getElementById('${getBasketlistvo.orderProductSeq}Ip').value,'${getBasketlistvo.orderProductSeq}','${getBasketlistvo.cloudId}');" value="저장">저장 </span></td>
																				</c:if>
																				<c:if test="${getBasketlistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																				</c:if>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getBasketlistvo.defaultNetworkIp eq null and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getBasketlistvo.defaultNetworkIp ne null and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규' or  getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketlistvo.requestName eq '신규'}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.defaultNetworkIp ne null}">
																				<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketlistvo.orderProductSeq}Ip" value="${getBasketlistvo.defaultNetworkIp}" /></td>
																			</c:if>
																		</c:forEach>

																		<c:if test="${getBasketlistvo.cloudType ne 'nutanix' and getBasketlistvo.backupNetworkFlag eq 'Y'}">
																			<c:set var="backNetworkIpValue" value="${fn:split(getBasketlistvo.backNetworkAlias, '/')}" />
																			<c:forEach items="${getProductAppSteplist}" var="getProductAppSteplist" varStatus="status">
																				<c:if test="${getProductAppSteplist.stepLevel eq '1' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '2' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '3' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName ne '신규'}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '4' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>

																				<c:choose>

																					<c:when test="${getBasketlistvo.backupNetworkFlag eq 'N'}">
																						<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																							<td class="tal"><span class="text">백업IP 주소</span> <input type="text" class="form-control w50 dpin ml10" name="backupIp" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${fn:substring(backNetworkIpValue[fn:length(backNetworkIpValue)-2], 0, fn:length(backNetworkIpValue[fn:length(backNetworkIpValue)-2])-1) }" data-orderNo="${getBasketlistvo.orderProductSeq}" data-cloudId="${getBasketlistvo.cloudId}" /> <input type="hidden" name="backupIpChk" id="${getBasketlistvo.orderProductSeq}BackupIpChk" value="${getBasketlistvo.backupNetworkFlag == 'N'? 'Y' : (getBasketlistvo.backupNetworkIp !='' && getBasketlistvo.backupNetworkIp != null?'Y':'N')}" /> <span class="bton-s bton_blue" onClick="saveBackupIpCheck(document.getElementById('${getBasketlistvo.orderProductSeq}BackupIp').value,'${getBasketlistvo.orderProductSeq}','${getBasketlistvo.cloudId}');" value="저장">저장 </span></td>
																						</c:if>
																					</c:when>
																					<c:otherwise>
																						<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																							<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																						</c:if>
																						<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketlistvo.requestName eq '신규'}">
																							<c:if test="${getBasketlistvo.backupNetworkIp eq null}">
																								<td class="tal"><span class="text">백업IP 주소</span> <input type="text" class="form-control w50 dpin ml10" name="backupIp" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${fn:substring(backNetworkIpValue[fn:length(backNetworkIpValue)-2], 0, fn:length(backNetworkIpValue[fn:length(backNetworkIpValue)-2])-1) }" data-orderNo="${getBasketlistvo.orderProductSeq}" data-cloudId="${getBasketlistvo.cloudId}" /> <input type="hidden" name="backupIpChk" id="${getBasketlistvo.orderProductSeq}BackupIpChk" value="${getBasketlistvo.backupNetworkFlag == 'N'? 'Y' : (getBasketlistvo.backupNetworkIp !='' && getBasketlistvo.backupNetworkIp != null?'Y':'N')}" /> <span class="bton-s bton_blue" onClick="saveBackupIpCheck(document.getElementById('${getBasketlistvo.orderProductSeq}BackupIp').value,'${getBasketlistvo.orderProductSeq}','${getBasketlistvo.cloudId}');" value="저장">저장 </span></td>
																							</c:if>
																							<c:if test="${getBasketlistvo.backupNetworkIp ne null}">
																								<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																							</c:if>
																						</c:if>
																					</c:otherwise>
																				</c:choose>

																				<c:choose>
																					<c:when test="${getBasketlistvo.backupNetworkFlag eq 'N'}">
																						<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																							<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																						</c:if>
																					</c:when>
																					<c:otherwise>
																						<c:if test="${getProductAppSteplist.stepLevel eq '6' and getBasketlistvo.backupNetworkIp eq null and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																							<td class="tal"><span class="text">백업IP 주소</span> <input type="text" class="form-control w50 dpin ml10" name="backupIp" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${fn:substring(backNetworkIpValue[fn:length(backNetworkIpValue)-2], 0, fn:length(backNetworkIpValue[fn:length(backNetworkIpValue)-2])-1) }" data-orderNo="${getBasketlistvo.orderProductSeq}" data-cloudId="${getBasketlistvo.cloudId}" /> <input type="hidden" name="backupIpChk" id="${getBasketlistvo.orderProductSeq}BackupIpChk" value="${getBasketlistvo.backupNetworkFlag == 'N'? 'Y' : (getBasketlistvo.backupNetworkIp !='' && getBasketlistvo.backupNetworkIp != null?'Y':'N')}" /> <span class="bton-s bton_blue" onClick="saveBackupIpCheck(document.getElementById('${getBasketlistvo.orderProductSeq}BackupIp').value,'${getBasketlistvo.orderProductSeq}','${getBasketlistvo.cloudId}');" value="저장">저장 </span></td>
																						</c:if>
																						<c:if test="${getProductAppSteplist.stepLevel eq '6' and getBasketlistvo.backupNetworkIp ne null and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																							<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																						</c:if>
																					</c:otherwise>
																				</c:choose>

																				<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규'}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '신규' and getBasketlistvo.backupNetworkIp ne null or  getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketlistvo.requestName eq '신규' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketlistvo.requestName eq '변경' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketlistvo.requestName eq '해지' and getBasketlistvo.backupNetworkIp ne null}">
																					<td class="tal"><span class="text">백업IP 주소</span> <input readonly type="text" class="form-control w50 dpin ml10" id="${getBasketlistvo.orderProductSeq}BackupIp" value="${getBasketlistvo.backupNetworkIp}" /></td>
																				</c:if>
																			</c:forEach>
																		</c:if>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
												</td>
											</tr>


											<c:set var="idNum" value="${idNum+1}" />

											<!-- ------------------------------------------------------------------------------------------------------------ -->


											<c:set var="amount" value="${amount + getBasketlistvo.amount}" />
										</c:forEach>
										<input type="hidden" id="idNum" value="${idNum}">

									</tbody>
								</table>
						</div>
						</c:if>

						<!-----부가자원  시작------->
						<h2 class="titleBuType01 m-b-15 m-t-40">부가자원</h2>
						<div class="tableBorderArea">
							<!-- 부가자원 - 신청내역 유/무 확인 시작-->
							<c:set value="useitem" var="substr" />
							<c:choose>
								<c:when test="${getBasketDisklistvo.size() ne 0}">
									<c:set var="substr" value="" />
								</c:when>
								<c:when test="${getBasketNaslistvo.size() ne 0}">
									<c:set var="substr" value="" />
								</c:when>
								<c:when test="${getBasketLblistvo.size() ne 0}">
									<c:set var="substr" value="" />
								</c:when>
								<c:when test="${getBasketSnlistvo.size() ne 0}">
									<c:set var="substr" value="" />
								</c:when>
								<c:when test="${getBasketIplistvo.size() ne 0}">
									<c:set var="substr" value="" />
								</c:when>
							</c:choose>
							<c:if test='${substr ne ""}'>
								<div class="tac orderBg">
									<i class="noOrder"></i> <span class="fc66 f18">신청 내역이 없습니다.</span>
								</div>
							</c:if>
							<!-- 부가자원 - 신청내역 유/무 확인 끝-->

							<!-- 부가자원 - 블록디스크 시작-->
							<c:if test='${getBasketDisklistvo.size() ne 0}'>
								<h5 class="f16 fc11 m-b-12">블록디스크</h5>
								<table class="detail_Table m-b-30" style="table-layout: auto;">
									<colgroup>
										<c:choose>
											<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
												<col width="30px">
											</c:when>
										</c:choose>
										<col width="75px">
										<col width="10%">
										<col width="15%">
										<col width="*">
										<col width="15%">
										<col width="10%">
										<col width="75px">
										<col width="80px">
									</colgroup>
									<thead>
										<tr>
											<c:choose>
												<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
													<th></th>
												</c:when>
											</c:choose>
											<th>요청유형</th>
											<th>클라우드</th>
											<th>서비스희망일시</th>
											<th>디스크명</th>
											<th>크기<span class="fontN fontVdn">(GB)</span></th>
											<th>가상서버</th>
											<th>작업결과</th>
											<th>상세보기</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${getBasketDisklistvo}" var="getBasketDisklistvo" varStatus="status">
											<tr>
												<c:choose>
													<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
														<td class="tac"><input type="checkbox" name="projectIdchk" id="${getBasketDisklistvo.orderProductSeq}" value="${getBasketDisklistvo.orderProductSeq}" /></td>
													</c:when>
												</c:choose>
												<td class="tac onwrap"><c:if test="${getBasketDisklistvo.requestName eq '신규'}">
														<span class="statusLabel_small status_new">신규</span>
													</c:if> <c:if test="${getBasketDisklistvo.requestName eq '변경'}">
														<span class="statusLabel_small status_new">변경</span>
													</c:if> <c:if test="${getBasketDisklistvo.requestName eq '해지'}">
														<span class="statusLabel_small status_out">삭제</span>
													</c:if></td>
												<td class="tal fc11">${getBasketDisklistvo.cloudName}</td>
												<td class="tac"><c:choose>
														<c:when test="${getBasketDisklistvo.onDemandFlag eq 'N'}">
															<span class="fontVdn">${getBasketDisklistvo.applyDatetime}</span>
														</c:when>
														<c:otherwise>
													승인완료 후 생성
												</c:otherwise>
													</c:choose></td>
												<td class="tal fc11">${getBasketDisklistvo.diskName}</td>
												<td class="tac"><c:if test="${getBasketDisklistvo.requestName eq '해지'}">
											${getBasketDisklistvo.beforeDiskGb}
											</c:if> <c:if test="${getBasketDisklistvo.requestName eq '변경' or getBasketDisklistvo.requestName eq '신규'}">
											${getBasketDisklistvo.diskGb2}
											</c:if></td>
												<td class="tal fontVdn">${getBasketDisklistvo.hostnameAlias}</td>
												<td class="tac"><c:if test="${getBasketDisklistvo.provisioningStatus eq 'PROVISIONING_FAIL'}">
														<a class="statusLabel_small status_new" onclick="alertFailMessage('${fn:replace(fn:replace(getBasketDisklistvo.provisioningStatusMessage,'\'',''),search,'')}',${getBasketDisklistvo.orderProductSeq})">실패</a>
													</c:if> <c:if test="${getBasketDisklistvo.provisioningStatus eq 'PROVISIONING_SUCCESS'}">
														<span class="dpin fb fc-blue2")">성공</span>
													</c:if> <c:if test="${getBasketDisklistvo.provisioningStatus eq 'PROVISIONING_END'}">

														<a class="statusLabel_small status_new" onclick="alertEndMessage('${fn:replace(fn:replace(getBasketlistvo.endDescription,'\'',''),search,'')}')">작업종료</a>

													</c:if></td>
												<td class="p-0 tac lastCol"><a type=button type="button" class="cbton bton_lblue" onclick="productDetail('disk','${getBasketDisklistvo.orderProductSeq}');"><i class="fa fa-search"></i></a></td>
											</tr>
											<c:set var="amount" value="${amount + getBasketDisklistvo.amount}" />
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							<!-- 부가자원 - 블록디스크 끝-->

							<!-- 부가자원 - NAS 시작 -->
							<c:set var="idNum" value="0" />
							<c:if test='${getBasketNaslistvo.size() ne 0}'>
								<h5 class="f20 fc11 m-b-12">NAS</h5>
								<table class="detail_Table m-b-30" style="table-layout: auto;">
									<colgroup>
										<c:choose>
											<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
												<col width="30px">
											</c:when>
										</c:choose>
										<col width="8%">
										<col width="10%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="6%">
										<col width="10%">
										<col width="3%">
									</colgroup>
									<thead>
										<tr>
											<c:choose>
												<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
													<th></th>
												</c:when>
											</c:choose>
											<th>요청유형</th>
											<th>서비스희망일시</th>
											<th>프로젝트명</th>
											<th>스토리지명</th>
											<th>스토리지ID</th>
											<th>가상서버</th>
											<th>용량<span class="fontN fontVdn">(GB)</span></th>
											<th>작업자지정</th>
											<th>상세</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${getBasketNaslistvo}" var="getBasketNaslistvo" varStatus="status">
											<tr>
												<c:choose>
													<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
														<td class="tac"><input type="checkbox" name="projectIdchk" id="${getBasketNaslistvo.orderProductSeq}" value="${getBasketNaslistvo.orderProductSeq}" /></td>
													</c:when>
												</c:choose>
												<td class="tac onwrap"><c:if test="${getBasketNaslistvo.requestName eq '신규'}">
														<span class="statusLabel_small status_new">신규</span>
													</c:if> <c:if test="${getBasketNaslistvo.requestName eq '변경'}">
														<span class="statusLabel_small status_new">변경</span>
													</c:if> <c:if test="${getBasketNaslistvo.requestName eq '해지'}">
														<span class="statusLabel_small status_out">삭제</span>
													</c:if></td>
												<%-- 										<td class="tac">
											<c:choose>
												<c:when test="${orderNo eq ''}">
													<c:set var="orderNo" value="${getBasketNaslistvo.orderNo}" />
												</c:when>
												<c:otherwise>
													<c:set var="orderNo" value="${orderNo},${getBasketNaslistvo.orderNo}" />
												</c:otherwise>
											</c:choose>

											<c:choose>
												<c:when test="${getBasketNaslistvo.hourlyFlag eq 'N'}">
													월
												</c:when>
												<c:otherwise>
													시간
												</c:otherwise>
											</c:choose>
										</td> --%>
												<td class="tac"><c:choose>
														<c:when test="${getBasketNaslistvo.onDemandFlag eq 'N'}">
															<span class="fontVdn">${getBasketNaslistvo.applyDatetime}</span>
														</c:when>
														<c:otherwise>
													승인완료 후 생성
												</c:otherwise>
													</c:choose></td>
												<td class="tac fc11">${getBasketNaslistvo.projectAlias}</td>
												<td class="tac fc11">${getBasketNaslistvo.nasAlias}</td>
												<td class="tac fc11">${getBasketNaslistvo.nasName}</td>
												<td class="tac fc11">${getBasketNaslistvo.nasVmList}</td>
												<td class="tac fontVdn">${getBasketNaslistvo.nasChange}</td>
												<td class="tac onwrap p-0 lastCol"><c:choose>
														<c:when test="${stepId eq 'WF1000E0' and userApprvState eq 'APPRV_UNASSIGNED' }">
															<input type="hidden" name="workUserId" id="workUserId" value="${getBasketNaslistvo.workUserName}" readonly />
															<input type="text" name="appointUserName" id="${getBasketNaslistvo.orderProductSeq}UserName" value="${getBasketNaslistvo.workUserName}" readonly style="width: 77px" />
															<a class="workUserSet" id="${getBasketNaslistvo.orderProductSeq}UserAppoint" name="${getBasketNaslistvo.orderProductSeq}UserAppoint" onclick="userAppoint('${getBasketNaslistvo.orderProductSeq}','${getBasketNaslistvo.productCategory}')"></a>
														</c:when>
														<c:otherwise>
															<input type="text" name="workUserId" id="workUserId" style="width: 117px" value="${getBasketNaslistvo.workUserName}" readonly />
														</c:otherwise>
													</c:choose></td>
												<td class="p-0 tac"><a type=button type="button" class="btn_viewDetail" onclick="productDetail('nas','${getBasketNaslistvo.orderProductSeq}');"><i class="fa fa-search"></i></a> <input type="hidden" id="c${getBasketNaslistvo.orderProductSeq}" name="c${getBasketNaslistvo.orderProductSeq}" value="0" /></td>
											</tr>
											<c:set var="amount" value="${amount + getBasketNaslistvo.amount}" />

										<input type="hidden" id="h_nasDefaultNetworkId${idNum}"
											value="${getBasketNaslistvo.defaultNetworkId}" />
										<input type="hidden" id="h_nasOrderProductSeq${idNum}"
											value="${getBasketNaslistvo.orderProductSeq}" />
										<input type="hidden" id="h_nasRequestType${idNum}"
											value="${getBasketNaslistvo.requestType}" />
										<input type="hidden" id="h_nasProjectBoxId${idNum}"
											value="${getBasketNaslistvo.projectBoxId}" />

											<c:if test="${getBasketNaslistvo.cloudType ne 'openshift' and stepId eq 'WF1000E0' and getBasketNaslistvo.requestType eq 'REQTYPE_NEW' and userApprvState eq 'APPRV_UNASSIGNED'}">
												<tr>
													<td colspan="13" class="bbno p0">
														<div id="Asub" class="panel-collapse collapse in">
															<div class="panel-body">
																<table class="tableB w100">
																	<colgroup>
																		<col width="*">
																		<col width="24%">
																		<col width="23%">
																		<col width="23%">
																	</colgroup>
																	<tbody>
																		<tr>
																			<td class="tal"><span class="text">서버대역</span> <c:choose>
																					<c:when test="${stepId eq 'WF1000E0' and getBasketNaslistvo.requestType eq 'REQTYPE_NEW' and userApprvState eq 'APPRV_UNASSIGNED'}">
																						<select class="form-control dpin w50" name="azName" id="azName${idNum}" onChange="selectAz(${idNum});" readonly>
																					</c:when>
																					<c:otherwise>
																						<select disabled class="form-control dpin w50" name="azName" id="azName${idNum}" onChange="selectAz(${idNum});">
																					</c:otherwise>
																				</c:choose>

																				<option value="">대역선택</option> <c:forEach items="${getNetworkNas}" var="getNetworkNas" varStatus="status">
																					<c:if test='${getBasketNaslistvo.azName eq getNetworkNas.zoneName}'>
																						<option value="${getNetworkNas.zoneName}" selected data-cloud="${getNetworkNas.cloudId}" data-type="${getNetworkNas.cloudType}" data-name="${getNetworkNas.cloudName}">${getNetworkNas.zoneDisplayName}</option>
																					</c:if>
																					<c:if test='${getBasketNaslistvo.azName ne getNetworkNas.zoneName}'>
																						<option value="${getNetworkNas.zoneName}" data-cloud="${getNetworkNas.cloudId}" data-type="${getNetworkNas.cloudType}" data-name="${getNetworkNas.cloudName}">${getNetworkNas.zoneDisplayName}</option>
																					</c:if>
																				</c:forEach>
																			<td class="tal"><span class="text">네트워크</span> <c:choose>
																					<c:when test="${stepId eq 'WF1000E0' and getBasketNaslistvo.requestType eq 'REQTYPE_NEW' and userApprvState eq 'APPRV_UNASSIGNED'}">
																						<select class="form-control dpin w50 ml10" id="divNetworkNas${idNum}" onchange="osSenter();">
																					</c:when>
																					<c:otherwise>
																						<select disabled class="form-control dpin w50 ml10" id="divNetworkNas${idNum}" onchange="osSenter();">
																					</c:otherwise>
																				</c:choose> </select></td>
																			<c:forEach items="${getProductAppSteplist}" var="getProductAppSteplist" varStatus="status">
																				<c:if test="${getProductAppSteplist.stepLevel eq '1' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '2' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '3' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '4' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketNaslistvo.requestName eq '신규'}">
																					<c:if test="${getBasketNaslistvo.defaultNetworkIp eq null}">
																						<td class="tal"><span class="text"> IP주소</span> <input type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${fn:substring(defaultNetworkIpValue[fn:length(defaultNetworkIpValue)-2], 0, fn:length(defaultNetworkIpValue[fn:length(defaultNetworkIpValue)-2])-1) }" data-orderNo="${getBasketNaslistvo.orderProductSeq}" data-cloudId="${getBasketNaslistvo.cloudId}" /> <input type="hidden" name="ipChk" id="${getBasketNaslistvo.orderProductSeq}IpChk" value="${getBasketNaslistvo.defaultNetworkIp !='' && getBasketNaslistvo.defaultNetworkIp != null?'Y':'N'}" /> <span class="bton-s bton_blue" onClick="saveNasIpCheck(document.getElementById('${getBasketNaslistvo.orderProductSeq}Ip').value,'${getBasketNaslistvo.orderProductSeq}','${getBasketNaslistvo.cloudId}');" value="저장">저장 </span></td>
																					</c:if>
																					<c:if test="${getBasketNaslistvo.defaultNetworkIp ne null}">
																						<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																					</c:if>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '신규'}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '6' and getBasketNaslistvo.defaultNetworkIp eq null and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '신규'}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '6' and getBasketNaslistvo.defaultNetworkIp ne null and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '신규'}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '신규'}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '신규' or  getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketNaslistvo.requestName eq '신규'}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketNaslistvo.requestName eq '변경' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '변경' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '변경' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '변경' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '변경' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketNaslistvo.requestName eq '변경' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getBasketNaslistvo.requestName eq '해지' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '해지' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '해지' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '해지' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>

																				<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getBasketNaslistvo.requestName eq '해지' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>
																				<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getBasketNaslistvo.requestName eq '해지' and getBasketNaslistvo.defaultNetworkIp ne null}">
																					<td class="tal"><span class="text"> IP주소</span> <input readonly type="text" class="form-control w50 dpin" name="ip" id="${getBasketNaslistvo.orderProductSeq}Ip" value="${getBasketNaslistvo.defaultNetworkIp}" /></td>
																				</c:if>
																			</c:forEach>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
													</td>
												</tr>
												<c:set var="idNum" value="${idNum+1}" />
											</c:if>
											<!-- ------------------------------------------------------------------------------------------------------------ -->

											<input type="hidden" id="idNum" value="${idNum}">
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							<!-- 부가자원 - NAS 끝 -->

							<!-- 부가자원 - 서비스 로드분산 시작-->
							<c:if test='${getBasketLblistvo.size() ne 0}'>
								<h5 class="f16 fc11 m-b-12">로드밸런스</h5>
								<table class="detail_Table m-b-30" style="table-layout: auto;">
									<colgroup>
										<col width="8%">
										<col width="8%">
										<col width="15%">
										<col width="*">
										<col width="8%">
										<col width="130px">
										<col width="80px">
									</colgroup>
									<thead>
										<tr>
											<th>요청유형</th>
											<th>로드밸런스명</th>
											<th>PORT</th>
											<th>method</th>
											<th>protocol</th>
											<th>작업자지정</th>
											<th>상세</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${getBasketLblistvo}" var="getBasketLblistvo" varStatus="status">
											<tr>
												<td class="tac onwrap"><c:if test="${getBasketLblistvo.requestName eq '신규'}">
														<span class="statusLabel_small status_new">신규</span>
													</c:if> <c:if test="${getBasketLblistvo.requestName eq '변경'}">
														<span class="statusLabel_small status_new">변경</span>
													</c:if> <c:if test="${getBasketLblistvo.requestName eq '해지'}">
														<span class="statusLabel_small status_out">삭제</span>
													</c:if></td>
												<td class="tac">${getBasketLblistvo.loadbalancerName}</td>
												<td class="tac">${getBasketLblistvo.port}</td>
												<td class="tac">${getBasketLblistvo.method}</td>
												<td class="tac">${getBasketLblistvo.protocol}</td>

												<td class="tac onwrap p-0"><c:choose>
														<c:when test="${stepId eq 'WF1000E0' and userApprvState eq 'APPRV_UNASSIGNED'}">
															<input type="hidden" name="workUserId" id="workUserId" value="${getBasketLblistvo.workUserName}" readonly />
															<input type="text" name="appointUserName" id="${getBasketLblistvo.orderProductSeq}UserName" value="${getBasketLblistvo.workUserName}" readonly style="width: 77px;" />
															<a class="workUserSet" id="${getBasketLblistvo.orderProductSeq}UserAppoint" name="${getBasketLblistvo.orderProductSeq}UserAppoint" onclick="userAppoint('${getBasketLblistvo.orderProductSeq}','${getBasketLblistvo.productCategory}')"></a>
														</c:when>
														<c:otherwise>
															<input type="text" name="workUserId" id="workUserId" style="width: 117px" value="${getBasketLblistvo.workUserName}" readonly />
														</c:otherwise>
													</c:choose> <!-- 작업자 상태 --></td>
												<td class="tac p-0 lastCol"><a type=button type="button" class="btn_viewDetail" onclick="productDetail('lb','${getBasketLblistvo.orderProductSeq}');"></a> <input type="hidden" id="c${getBasketLblistvo.orderProductSeq}" name="c${getBasketLblistvo.orderProductSeq}" value="0" /></td>
											</tr>
											<c:set var="amount" value="${amount + getBasketLblistvo.amount}" />
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							<!-- 부가자원 - 서비스 로드분산 끝-->

							<!-- 부가자원 - 스냅샷 시작-->
							<c:if test='${getBasketSnlistvo.size() ne 0}'>
								<h5 class="f16 fc11 m-b-12">스냅샷</h5>
								<table class="detail_Table m-b-30" style="table-layout: auto;">
									<colgroup>
										<col width="8%">
										<col width="8%">
										<col width="8%">
										<col width="8%">
										<col width="15%">
										<col width="80px">
									</colgroup>
									<thead>
										<tr>
											<th>요청유형</th>
											<th>가상서버</th>
											<th>스냅샷명</th>
											<th>디스크명</th>
											<th>작업자지정</th>
											<th>상세</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${getBasketSnlistvo}" var="getBasketSnlistvo" varStatus="status">
											<tr>
												<td class="tac onwrap"><c:if test="${getBasketSnlistvo.requestName eq '신규'}">
														<span class="statusLabel_small status_new">신규</span>
													</c:if> <c:if test="${getBasketSnlistvo.requestName eq '변경'}">
														<span class="statusLabel_small status_new">변경</span>
													</c:if> <c:if test="${getBasketSnlistvo.requestName eq '해지'}">
														<span class="statusLabel_small status_out">삭제</span>
													</c:if></td>
												<td class="tac">${getBasketSnlistvo.hostname}</td>
												<td class="tac">${getBasketSnlistvo.snapshotName}</td>
												<td class="tac">${getBasketSnlistvo.diskAlias}</td>
												<td class="tac onwrap p-0 lastCol"><c:choose>
														<c:when test="${stepId eq 'WF1000E0' and userApprvState eq 'APPRV_UNASSIGNED'}">
															<input type="hidden" name="workUserId" id="workUserId" value="${getBasketSnlistvo.workUserName}" readonly />
															<input type="text" name="appointUserName" id="${getBasketSnlistvo.orderProductSeq}UserName" value="${getBasketSnlistvo.workUserName}" readonly style="width: 77px;" />
															<a class="workUserSet" id="${getBasketSnlistvo.orderProductSeq}UserAppoint" name="${getBasketSnlistvo.orderProductSeq}UserAppoint" onclick="userAppoint('${getBasketSnlistvo.orderProductSeq}','${getBasketSnlistvo.productCategory}')"></a>
														</c:when>
														<c:otherwise>
															<input type="text" name="workUserId" id="workUserId" style="width: 117px" value="${getBasketSnlistvo.workUserName}" readonly />
														</c:otherwise>
													</c:choose> <!-- 작업자 상태 --></td>
												<td class="tac p-0"><a type=button type="button" class="btn_viewDetail" onclick="openPopSn('${getBasketSnlistvo.requestName}','${getBasketSnlistvo.projectAlias}', '${getBasketSnlistvo.snapshotName}', '${getBasketSnlistvo.hostname}', '${getBasketSnlistvo.diskAlias}','${getBasketSnlistvo.description}','${getBasketSnlistvo.applyDatetime}','${getBasketSnlistvo.onDemandFlag}')"></a> <input type="hidden" id="c${getBasketSnlistvo.orderProductSeq}" name="c${getBasketSnlistvo.orderProductSeq}" value="0" /></td>
											</tr>
											<c:set var="amount" value="${amount + getBasketSnlistvo.amount}" />
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							<!-- 부가자원 - 서비스 로드분산 끝-->

							<!-- 부가자원 - 공인 IP 시작-->
							<c:if test='${getBasketIplistvo.size() ne 0}'>
								<h5 class="f16 fc11 m-b-12">공인 IP</h5>
								<table class="detail_Table" style="table-layout: auto;">
									<colgroup>
										<c:choose>
											<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
												<col width="30px">
											</c:when>
										</c:choose>
										<col width="8%">
										<col width="8%">
										<col width="15%">
										<col width="*">
										<col width="10%">
										<col width="8%">
										<col width="15%">
									</colgroup>
									<thead>
										<tr>
											<c:choose>
												<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
													<th></th>
												</c:when>
											</c:choose>
											<th>요청유형</th>
											<th>과금단위</th>
											<th>서비스희망일시</th>
											<th>프로젝트명</th>
											<th>수량<span class="fontN">(식)</span></th>
											<th>상세</th>
											<th>작업자지정</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${getBasketIplistvo}" var="getBasketIplistvo" varStatus="status">
											<tr>
												<c:choose>
													<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
														<td class="tac"><input type="checkbox" name="projectIdchk" id="${getBasketIplistvo.orderProductSeq}" value="${getBasketIplistvo.orderProductSeq}" /></td>
													</c:when>
												</c:choose>
												<td class="tac onwrap"><c:if test="${getBasketIplistvo.requestName eq '신규'}">
														<span class="statusLabel_small status_new">신규</span>
													</c:if> <c:if test="${getBasketIplistvo.requestName eq '변경'}">
														<span class="statusLabel_small status_new">변경</span>
													</c:if> <c:if test="${getBasketIplistvo.requestName eq '해지'}">
														<span class="statusLabel_small status_out">삭제</span>
													</c:if></td>
												<td class="tac"><c:choose>
														<c:when test="${orderNo eq ''}">
															<c:set var="orderNo" value="${getBasketIplistvo.orderNo}" />
														</c:when>
														<c:otherwise>
															<c:set var="orderNo" value="${orderNo},${getBasketIplistvo.orderNo}" />
														</c:otherwise>
													</c:choose> <c:choose>
														<c:when test="${getBasketIplistvo.hourlyFlag eq 'N'}">
														월
													</c:when>
														<c:otherwise>
														시간
													</c:otherwise>
													</c:choose></td>
												<td class="tac"><c:choose>
														<c:when test="${getBasketIplistvo.onDemandFlag eq 'N'}">
															<span class="fontVdn">${getBasketIplistvo.applyDatetime}</span>
														</c:when>
														<c:otherwise>
													승인완료 후 생성
												</c:otherwise>
													</c:choose></td>
												<td class="tal fc11">${getBasketIplistvo.projectAlias}</td>
												<td class="tar fontVdn">1</td>
												<td class="tac p-0"><a type=button type="button" class="btn_viewDetail" onclick="productDetail('ip','${getBasketIplistvo.orderProductSeq}');"></a> <input type="hidden" id="c${getBasketIplistvo.orderProductSeq}" name="c${getBasketIplistvo.orderProductSeq}" value="0" /></td>
												<td class="tac lastCol p-0 onwrap"><c:choose>
														<c:when test="${stepId eq 'WF1000E0' and userApprvState eq 'APPRV_UNASSIGNED'}">
															<input type="hidden" name="workUserId" id="workUserId" value="${getBasketIplistvo.workUserName}" readonly />
															<input type="text" name="appointUserName" id="${getBasketIplistvo.orderProductSeq}UserName" value="${getBasketIplistvo.workUserName}" readonly style="width: 77px" />
															<a class="workUserSet" id="${getBasketIplistvo.orderProductSeq}UserAppoint" name="${getBasketIplistvo.orderProductSeq}UserAppoint" onclick="userAppoint('${getBasketIplistvo.orderProductSeq}','${getBasketIplistvo.productCategory}')"></a>
														</c:when>
														<c:otherwise>
															<input type="text" name="workUserId" id="workUserId" style="width: 117px" value="${getBasketIplistvo.workUserName}" readonly />
														</c:otherwise>
													</c:choose></td>
											</tr>
											<c:set var="amount" value="${amount + getBasketIplistvo.amount}" />
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							<!-- 부가자원 - 공인 IP 끝-->
						</div>
						<!-----부가자원  끝 ------->

						<!----- 서비스 시작 ------->
						<h2 class="titleBuType01 m-b-15 m-t-40">서비스</h2>
						<div class="tableBorderArea">
							<!-- 신청없음 -->
							<c:set value="useitem" var="subser" />
							<c:choose>
								<c:when test="${getReqServicelistvo.size() ne 0}">
									<c:set var="subser" value="" />
								</c:when>
								<%-- 								<c:when test="${getBasketScmlistvo.size() ne 0}"> --%>
								<%-- 									<c:set var="subser" value="" /> --%>
								<%-- 								</c:when> --%>
								<%-- 								<c:when test="${getBasketMcalistvo.size() ne 0}"> --%>
								<%-- 									<c:set var="subser" value="" /> --%>
								<%-- 								</c:when> --%>
								<%-- 								<c:when test="${getBasketSerlistvo.size() ne 0}"> --%>
								<%-- 									<c:set var="subser" value="" /> --%>
								<%-- 								</c:when> --%>
							</c:choose>
							<c:if test='${subser ne ""}'>
								<div class="tac orderBg">
									<i class="noOrder"></i> <span class="fc66 f18">신청 내역이 없습니다.</span>
								</div>
							</c:if>
							<!-- 서비스 시작 -->
							<c:if test='${getReqServicelistvo.size() ne 0}'>
								<h5 class="f16 fc11 m-b-12">서비스</h5>
								<table class="detail_Table m-b-30" style="table-layout: auto;">
									<colgroup>
										<c:choose>
											<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
												<col width="30px">
											</c:when>
										</c:choose>
										<col width="75px">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="*">
										<col width="15%">
										<c:forEach items="${getReqServicelistvo}" var="getReqServicelistvo" varStatus="status">
											<c:if test="${getReqServicelistvo.serviceType ne 'SERVICE99'}">
												<col width="15%">
											</c:if>
										</c:forEach>
										<col width="80px">
									</colgroup>
									<thead>
										<tr>
											<c:choose>
												<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
													<th></th>
												</c:when>
											</c:choose>
											<th>요청유형</th>
											<th>클라우드</th>
											<th>서비스희망일시</th>
											<th>서비스유형</th>
											<th>서비스명</th>
											<th>자원명</th>
											<c:forEach items="${getReqServicelistvo}" var="getReqServicelistvo" varStatus="status">
												<c:if test="${getReqServicelistvo.serviceType ne 'SERVICE99'}">
													<th>작업자지정</th>
												</c:if>
											</c:forEach>
											<th>상세보기</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${getReqServicelistvo}" var="getReqServicelistvo" varStatus="status">
											<input type="hidden" id="serviceType" value="${getReqServicelistvo.serviceType}" />
											<tr>
												<c:choose>
													<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
														<td class="tac"><input type="checkbox" name="projectIdchk" id="${getReqServicelistvo.orderProductSeq}" value="${getReqServicelistvo.orderProductSeq}" /></td>
													</c:when>
												</c:choose>
												<td class="tac onwrap"><c:if test="${getReqServicelistvo.requestName eq '신규'}">
														<span class="statusLabel_small status_new">신규</span>
													</c:if> <c:if test="${getReqServicelistvo.requestName eq '변경'}">
														<span class="statusLabel_small status_new">변경</span>
													</c:if> <c:if test="${getReqServicelistvo.requestName eq '해지'}">
														<span class="statusLabel_small status_out">삭제</span>
													</c:if></td>

												<td class="tal fc11">${getReqServicelistvo.cloudName}</td>

												<td class="tac"><c:choose>
														<c:when test="${getReqServicelistvo.onDemandFlag eq 'N'}">
															<span class="fontVdn">${getReqServicelistvo.applyDatetime}</span>
														</c:when>
														<c:otherwise>
															승인완료 후 생성
														</c:otherwise>
													</c:choose></td>

												<td class="tal fc11">${getReqServicelistvo.serviceTypeName}</td>

												<td class="tal fc11">${getReqServicelistvo.serviceName}</td>

												<c:choose>
													<c:when test="${getReqServicelistvo.serviceType eq '10'}">
														<td class="tal fc11">${getReqServicelistvo.appName}</td>
													</c:when>
													<c:when test="${getReqServicelistvo.serviceType eq '11'}">
														<td class="tal fc11">${getReqServicelistvo.appName}</td>
													</c:when>
													<c:when test="${getReqServicelistvo.serviceType eq 'SERVICE99'}">
														<td class="tal fc11">${getReqServicelistvo.serviceName}</td>
													</c:when>
													<c:otherwise>
														<td class="tal">${getReqServicelistvo.hostnameAlias}</td>
													</c:otherwise>
												</c:choose>

												<c:if test="${getReqServicelistvo.serviceType ne 'SERVICE99'}">
													<td class="tac p-0 lastCol onwrap"><c:choose>
															<c:when test="${stepId eq 'WF1000E0' and userApprvState eq 'APPRV_UNASSIGNED'}">
																<input type="hidden" name="workUserId" id="workUserId" value="${getReqServicelistvo.workUserName}" readonly />
																<input type="text" name="appointUserName" id="${getReqServicelistvo.orderProductSeq}UserName" value="${getReqServicelistvo.workUserName}" readonly style="width: 77px" />
																<a class="workUserSet" id="${getReqServicelistvo.orderProductSeq}UserAppoint" name="${getReqServicelistvo.orderProductSeq}UserAppoint" onclick="userAppoint('${getReqServicelistvo.orderProductSeq}','${getReqServicelistvo.productCategory}')"></a>
															</c:when>
															<c:otherwise>

																<input type="text" name="workUserId" id="workUserId" style="width: 117px" value="${getReqServicelistvo.workUserName}" readonly />
															</c:otherwise>
														</c:choose></td>
												</c:if>
												<td class="tac p-0"><a type=button type="button" class="cbton bton_lblue" onclick="productDetail('service','${getReqServicelistvo.orderProductSeq}');"><i class="fa fa-search"></i> </a> <input type="hidden" id="c${getReqServicelistvo.orderProductSeq}" name="c${getReqServicelistvo.orderProductSeq}" value="0" /></td>

											</tr>

											<tr>
												<td colspan="13" class="bbno p0">
													<div id="Asub" class="panel-collapse collapse in">
														<div class="panel-body">
															<table class="tableB w100">
																<colgroup>
																	<col width="*">
																	<col width="*">
																	<col width="*">
																	<col width="*">
																</colgroup>
																<tbody>
																	<tr>
																		<c:forEach items="${getProductAppSteplist}" var="getProductAppSteplist" varStatus="status">
																			<c:if test="${getProductAppSteplist.stepLevel eq '1' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '2' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '3' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '4' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<c:if test="${getReqServicelistvo.bastionVmUserId eq null}">
																					<td class="tal"><span class="text">사용자 ID</span> <input name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /> <span class="bton-s bton_blue" onClick="saveUserIdCheck(document.getElementById('${getReqServicelistvo.orderProductSeq}VmUserId').value,'${getReqServicelistvo.orderProductSeq}');" value="저장">저장 </span></td>
																				</c:if>
																				<c:if test="${getReqServicelistvo.bastionVmUserId ne null}">
																					<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																				</c:if>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getReqServicelistvo.bastionVmUserId eq null  and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /> <span class="bton-s bton_blue" onClick="saveUserIdCheck(document.getElementById('${getReqServicelistvo.orderProductSeq}VmUserId').value,'${getReqServicelistvo.orderProductSeq}');" value="저장">저장 </span></td>

																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getReqServicelistvo.bastionVmUserId ne null and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '신규' or  getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.osProductName eq 'PaaS Bastion Image' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserId ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserId ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserId ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserId ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.bastionVmUserId ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.bastionVmUserId ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.bastionVmUserId ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserId ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.bastionVmUserId ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserId ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.bastionVmUserId ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 ID</span> <input readonly name="vmUserId" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserId" value="${getReqServicelistvo.bastionVmUserId}" /> <input type="hidden" name="vmUserIdChk" id="${getReqServicelistvo.orderProductSeq}vmUserIdChk" value="${getReqServicelistvo.bastionVmUserId !='' && getReqServicelistvo.bastionVmUserId != null?'Y':'N'}" /></td>
																			</c:if>
																		</c:forEach>

																		<c:forEach items="${getProductAppSteplist}" var="getProductAppSteplist" varStatus="status">
																			<c:if test="${getProductAppSteplist.stepLevel eq '1' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '2' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '3' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '4' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<c:if test="${getReqServicelistvo.bastionVmUserPassword eq null}">
																					<td class="tal"><span class="text">사용자 PW</span> <input name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /> <span class="bton-s bton_blue" onClick="saveUserPw(document.getElementById('${getReqServicelistvo.orderProductSeq}VmUserPw').value,'${getReqServicelistvo.orderProductSeq}');" value="저장">저장 </span></td>


																				</c:if>
																				<c:if test="${getReqServicelistvo.bastionVmUserPassword ne null}">
																					<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																				</c:if>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getReqServicelistvo.bastionVmUserPassword eq null  and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /> <span class="bton-s bton_blue" onClick="saveUserPw(document.getElementById('${getReqServicelistvo.orderProductSeq}VmUserPw').value,'${getReqServicelistvo.orderProductSeq}');" value="저장">저장 </span></td>

																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getReqServicelistvo.bastionVmUserPassword ne null and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '신규' or  getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getReqServicelistvo.requestName eq '신규' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserPassword ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserPassword ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserPassword ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserPassword ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_UNASSIGNED' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '5' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.bastionVmUserPassword ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '6' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.bastionVmUserPassword ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '7' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.bastionVmUserPassword ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserPassword ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_PROCESSING' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.bastionVmUserPassword ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>

																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getReqServicelistvo.requestName eq '변경' and getReqServicelistvo.bastionVmUserPassword ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>
																			<c:if test="${getProductAppSteplist.stepLevel eq '8' and getProductAppSteplist.apprvState eq 'APPRV_COMPLETED' and getReqServicelistvo.requestName eq '해지' and getReqServicelistvo.bastionVmUserPassword ne null and getReqServicelistvo.serviceType eq 'SERVICE99'}">
																				<td class="tal"><span class="text">사용자 PW</span> <input readonly name="vmUserPw" type="text" class="form-control w50 dpin ml10" id="${getReqServicelistvo.orderProductSeq}VmUserPw" value="${getReqServicelistvo.bastionVmUserPassword}" /> <input type="hidden" name="vmUserPwChk" id="${getReqServicelistvo.orderProductSeq}vmUserPwChk" value="${getReqServicelistvo.bastionVmUserPassword !='' && getReqServicelistvo.bastionVmUserPassword != null?'Y':'N'}" /></td>
																			</c:if>
																		</c:forEach>

																	</tr>
																</tbody>
															</table>
														</div>
													</div>
												</td>
											</tr>

											<c:set var="amount" value="${amount + getReqServicelistvo.amount}" />
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							<!-- 서비스 끝 -->
						</div>

						<!-- 컨테이너 신청 변수 -->
						<input type="hidden" name="appProjectId" id="appProjectId" value="" /> <input type="hidden" name="params" id="params" value="" /> <input type="hidden" name="productSeq" id="productSeq" value="" /> <input type="hidden" name="productCategory" id="productCategory" value="" /> <input type="hidden" name="productCategorySeq" id="productCategorySeq" value="" /> <input type="hidden" name="appNameChk" id="appNameChk" value="N" /> <input type="hidden" name="appNameChkFlag" id="appNameChkFlag" value="N" /> <input type="hidden" name="h_templateName" id="templateName" value="" /> <input type="hidden" name="h_templateNameSpace" id="templateNameSpace" value="" /> <input type="hidden" name="h_templateType" id="templateType" value="" /> <input type="hidden" name="h_osProductSeq" id="osProductSeq" value="" /> <input type="hidden" class="parameterClass" data-key="BROKER_XML" name="h_xml" id="h_xml" value="" /> <input type="hidden" class="parameterClass" data-key="LOGGING_PROPERTIES"
							name="h_properties" id="h_properties" value="" />
						<!----- 어플리케이션 시작 ------->
						<h2 class="titleBuType01 m-b-15 m-t-40">어플리케이션</h2>
						<div class="tableBorderArea">
							<!-- 신청없음 -->
							<c:set value="useitem" var="subser" />
							<c:choose>
								<c:when test="${orderAppviewList.size() ne 0}">
									<c:set var="subser" value="" />
								</c:when>
							</c:choose>
							<c:if test='${subser ne ""}'>
								<div class="tac orderBg">
									<i class="noOrder"></i> <span class="fc66 f18">신청 내역이 없습니다.</span>
								</div>
							</c:if>
							<!-- 서비스 시작 -->
							<c:if test='${orderAppviewList.size() ne 0}'>
								<c:forEach items="${orderAppviewList}" var="orderAppviewEnvType" varStatus="status">
									<c:choose>
										<c:when test="${orderAppviewEnvType.envType eq 'PROD'}">
											<h5 class="f16 fc11 m-b-12">운영배포</h5>
										</c:when>
										<c:otherwise>
											<h5 class="f16 fc11 m-b-12">어플리케이션</h5>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<table class="detail_Table m-b-30" style="table-layout: auto;">
									<colgroup>
										<c:choose>
											<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
												<col width="30px">
											</c:when>
										</c:choose>
										<col width="80px">
										<col width="120px">
										<col width="120px">
										<col width="120px">
										<col width="180px">
										<col width="120px">
										<col width="120px">
										<col width="120px">
										<col width="120px">
									</colgroup>
									<thead>
										<tr>
											<c:choose>
												<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
													<th></th>
												</c:when>
											</c:choose>
											<th scope="col">요청유형</th>
											<th scope="col">클라우드</th>
											<th scope="col">프로젝트</th>
											<th scope="col">베포명</th>
											<th scope="col">템플릿 이미지</th>
											<th scope="col">CPU Limit</th>
											<th scope="col">MEM Limit</th>
											<th scope="col">파드 수</th>
											<th scope="col">상세</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${orderAppviewList}" var="orderAppviewList" varStatus="status">
											<tr>
												<c:choose>
													<c:when test="${userApprvState eq 'APPRV_PROCESSING'}">
														<td class="tac"><input type="checkbox" name="projectIdchk" id="${orderAppviewList.orderProductSeq}" value="${orderAppviewList.orderProductSeq}" /></td>
													</c:when>
												</c:choose>
												<td class="tac onwrap"><c:if test="${orderAppviewList.requestName eq '신규'}">
														<span class="statusLabel_small status_new">신규</span>
													</c:if> <c:if test="${orderAppviewList.requestName eq '변경'}">
														<span class="statusLabel_small status_new">변경</span>
													</c:if> <c:if test="${orderAppviewList.requestName eq '해지'}">
														<span class="statusLabel_small status_out">삭제</span>
													</c:if></td>

												<td class="tac">
													<!-- 클라우드 --> ${orderAppviewList.cloudName}
												</td>
												<td class="tac fc11">
													<!-- 프로젝트 --> ${orderAppviewList.projectName}
												</td>
												<td class="tac fc11">
													<!-- 어플리케이션 명 --> ${orderAppviewList.appAlias}
												</td>
												<td class="tac fc11">
													<!-- Template 이미지 --> ${orderAppviewList.productName}
												</td>
												<c:choose>
													<c:when test="${orderAppviewList.beforeCpuLimit eq null}">
														<td class="tac fc11">${orderAppviewList.cpuLimit}</td>
														<td class="tac fc11">${orderAppviewList.memLimit}</td>
														<td class="tac fc11">${orderAppviewList.podCnt}</td>
													</c:when>
													<c:otherwise>
														<td class="tac fc11">${orderAppviewList.beforeCpuLimit} > ${orderAppviewList.cpuLimit}</td>
														<td class="tac fc11">${orderAppviewList.beforeMemLimit} > ${orderAppviewList.memLimit}</td>
														<td class="tac fc11">${orderAppviewList.beforePodCnt} > ${orderAppviewList.podCnt}</td>
													</c:otherwise>
												</c:choose>

												<%-- <td class="tac fc11">
													<!-- 작업결과 --> 													${orderAppviewList.orderSummary}
													<c:if test="${orderAppviewList.provisioningStatus eq 'PROVISIONING_FAIL'}">
														<a class="statusLabel_small status_new" onclick="alertFailMessage('${fn:replace(fn:replace(orderAppviewList.provisioningStatusMessage,'\'',''),search,'')}',${orderAppviewList.orderProductSeq})">실패</a>
													</c:if>
													<c:if test="${orderAppviewList.provisioningStatus eq 'PROVISIONING_SUCCESS'}">
														<span class="dpin fb fc-blue2")">성공</span>
													</c:if>
													<c:if test="${orderAppviewList.provisioningStatus eq 'PROVISIONING_END'}">
														<span class="dpin fb fc-blue2")">작업종료</span>
													</c:if>
												</td> --%>
												<td class="tac fc11">
													<a type=button type="button" class="btn btn-detail" onclick="productDetail('application','${orderAppviewList.orderProductSeq}');"><i class="fa fa-search"></i></a>
												</td>
											</tr>
											<c:set var="templProductName" value="${orderAppviewList.productName}" />
										</c:forEach>
									</tbody>
								</table>

								<!-- 어플리케이션 끝 -->
								<!-----부가자원 끝---------->

								<!----- 서비스 끝 ------->
								<%-- <div class="tableF">
									<table class="insert-table insert-table-2 container-table">
										<colgroup>
											<col width="140px">
											<col width="*">
											<col width="140px">
											<col width="*">
										</colgroup>
										<tbody>
											<c:forEach items="${orderAppviewList}" var="orderAppview" varStatus="status">
												<tr>
													<td class="left-t">어플리케이션</td>
													<td>
														<div class="col-group col-box">
															<input type="text" class="form-control width-540 parameterClass" name="appName" id="appName" value="${orderAppview.appName}" />
<!-- 															<button type="button" id="saveBtn" class="btn btn-outline-primary bton-s bton_blue ml4 parameterClass" onclick="appNameChk();">저장</button> -->
														</div>
													</td>
													<td class="left-t">Labels</td>
													<td><input type="text" class="form-control width-540 parameterClass" name="labels" id="labels" value="app-version = ${orderAppview.appVersion}" /></td>
												</tr>
												<tr>
													<td class="left">Git Repository URL</td>
													<td colspan="3"><input class="form-control width-540 parameterClass" type="text" name="gitRepository" id="gitRepository" value="${orderAppview.gitRepository}" /></td>
												</tr>
												<tr>
													<td class="left">템플릿 이미지</td>
													<td class="insert-search" colspan="3">
														<div class="searchBoxArea width-400">
															<input type="hidden" name="appCloudId" id="appCloudId${status.index }" value="${orderAppview.cloudId }" /> <input type="hidden" name="templateName" id="templateName${status.index }" value="${orderAppview.templateName }" /> <input type="hidden" name="templateNameSpace" id="templateNameSpace${status.index }" value="${orderAppview.templateNameSpace}" /> <input type="hidden" name="templateType" id="templateType${status.index }" value="" /> <input type="hidden" name="osProductSeq" id="osProductSeq${status.index }" value="" /> <label class="selectBoxDrop" for="templateInfo">서버대역</label> <select class="form-control dpin w50ml10 " name="templateInfo" id="templateInfo" onChange="selectTemplate(${status.index });">
																<!-- <option value="">템플릿 이미지선택</option> -->

																<c:forEach items="${getImageTemplateList}" var="templateList" varStatus="status">
																	<c:choose>
																																	<c:when test="${templateList.productName eq templProductName} eq ${templateList.productName}">
																		<c:when test="${templateList.productName eq templProductName}">
																			<option value="${templateList.productSeq}" data-seq="${templateList.productSeq}" data-category="${templateList.productCategory}" data-name="${templateList.productName}" data-templatename="${templateList.templateName}" data-templatenamespace="${templateList.templateNameSpace}" data-templatetype="${templateList.itemId}" data-osproductseq="${templateList.productSeq}" data-categoryseq="${templateList.catalogSeq}" selected>${templateList.productName}</option>
																		</c:when>
																		<c:otherwise>
																			<option value="${templateList.productSeq}" data-seq="${templateList.productSeq}" data-category="${templateList.productCategory}" data-name="${templateList.productName}" data-templatename="${templateList.templateName}" data-templatenamespace="${templateList.templateNameSpace}" data-templatetype="${templateList.itemId}" data-osproductseq="${templateList.productSeq}" data-categoryseq="${templateList.catalogSeq}">${templateList.productName}</option>
																		</c:otherwise>
																	</c:choose>
																</c:forEach>
															</select>
														</div>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div> --%>
								<!-- end tableF -->
								<%-- <div class="clear"></div>
								<h4 class="orderTitle f16 fc11 m-b-12 m-t-40">
									<strong>입력 정보 </strong>
								</h4>
								<div class="tableF">
									<table class="insert-table insert-table-2">
										<colgroup>
											<col width="20%">
											<col width="*">
										</colgroup>
										<tbody id="inputInfo">

										</tbody>
									</table>
								</div>
								<h4 class="orderTitle innerTitle mt-4">
									<strong>추가정보 </strong>
								</h4>
								<div class="btn-wrap flex-end">
									<a class="accordion-toggle accordion-toggle-styled" data-bs-toggle="collapse" data-bs-parent="#theme-accordion" href="#appMoreInfo">
										<h3 class="app_title">
											<span class="pull-right f14 mr10 pt6">모두보기</span> <i class="fa fa-plus-circle pull-right btn-warp flex-end"></i>
										</h3>
									</a>
								</div>
								<div class="panel-collapse collapse tableF " id="appMoreInfo">
									<table class="insert-table insert-table-2">
										<colgroup>
											<col width="20%">
											<col width="*">
										</colgroup>
										<tbody id="moreInfo">

										</tbody>
									</table>
								</div> --%>
							</c:if>

						</div>
						<!-- begin page-body 자원상세목록  -->

						<h2 class="titleBuType01 m-b-15 m-t-40">개발환경</h2>
						<div class="tableBorderArea">
							<c:set value="useitem" var="subenv" />
							<c:choose>
								<c:when test="${orderEnvviewList.size() ne 0}">
									<c:set var="subenv" value="" />
								</c:when>
							</c:choose>
							<c:if test='${subenv ne ""}'>
								<div class="tac orderBg">
									<i class="noOrder"></i> <span class="fc66 f18">신청 내역이 없습니다.</span>
								</div>
							</c:if>
							<c:if test='${orderEnvviewList.size() ne 0}'>
								<h5 class="f16 fc11 m-b-12">개발환경</h5>
								<table class="detail_Table m-b-30" style="table-layout: auto;">
									<colgroup>
										<col width="100px">
										<col width="250px">
										<col width="220px">
										<col width="220px">
										<col width="270px">
										<col width="270px">
										<col width="200px">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">요청유형</th>
											<th scope="col">클라우드</th>
											<th scope="col">프로젝트</th>
											<th scope="col">개발환경Alias</th>
											<!-- 										<th scope="col">그룹 URL</th> -->
											<!-- 										<th scope="col">그룹명</th> -->
											<th scope="col">그룹 URL</th>
											<th scope="col">개발환경명</th>
											<th scope="col">상세</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${orderEnvviewList}" var="orderEnvviewList" varStatus="status">
											<tr>
												<td class="tac onwrap"><c:if test="${orderEnvviewList.requestName eq '신규'}">
														<span class="statusLabel_small status_new">신규</span>
													</c:if> <c:if test="${orderEnvviewList.requestName eq '변경'}">
														<span class="statusLabel_small status_new">변경</span>
													</c:if> <c:if test="${orderEnvviewList.requestName eq '해지'}">
														<span class="statusLabel_small status_out">삭제</span>
													</c:if></td>
												<td class="tac">${orderEnvviewList.cloudName}</td>
												<td class="tac">
													<%-- 												${orderEnvviewList.envName} --%> ${orderEnvviewList.projectName}
												</td>
												<td class="tac">${orderEnvviewList.envAlias}</td>
												<td class="tac p-0 lastCol onwrap">
													<div class="flex align-center gap10">
														<!-- 											envGroupName -->
														<c:if test="${orderEnvviewList.envGroupName eq null}">
															<input type="text" name="envGroupName" id="envGroupName" style="width: 160px" />
															<button type="button" onclick="envGroupNameChk();" class="bton-s bton_blue ml4">등록</button>
														</c:if>
														<c:if test="${orderEnvviewList.envGroupName ne null}">
															<input type="text" name="envGroupName" id="envGroupName" value="${orderEnvviewList.envGroupName}" style="width: 200px" readonly/>
														</c:if>
													</div>
												</td>



												<td class="tac p-0 lastCol onwrap">
													<div class="flex align-center gap10">
														<c:if test="${orderEnvviewList.envName eq null}">
															<input type="text" name="envName" id="envName" style="width: 160px" />
															<button type="button" onclick="envNameChk();" class="bton-s bton_blue ml4">등록</button>
														</c:if>
														<c:if test="${orderEnvviewList.envName ne null}">
															<input type="text" name="envName" id="envName" value="${orderEnvviewList.envName}" style="width: 200px" readonly/>
														</c:if> <!-- 												<button type="button" onclick="envGrpUrlChk();">등록</button> -->
														<!-- 												<button type="button" onclick="envGroupNameChk();">등록</button> -->
													</div>
												</td>

												<td class="tac fc11">
													<!-- 상세 --> <a type=button type="button" class="btn btn-detail" onclick="productDetail('env','${orderEnvviewList.orderProductSeq}');"><i class="fa fa-search"></i></a>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</div>

						<!-- begin page-body 승인요약금액  -->
						<table class="sumtableV mt20">
							<thead>
								<tr>
									<th>자원구분</th>
									<th>신청</th>
									<th>변경</th>
									<th>삭제</th>
									<!-- <th>금액</th>-->
								</tr>
							</thead>
							<tbody>

								<c:if test="${vmNew ne 0 or vmCh ne 0 or vmEx ne 0}">
									<tr>
										<td class=" tac" scope="row">기본자원</td>
										<td class=" tac nanumR">${vmNew}</td>
										<td class=" tac nanumR">${vmCh}</td>
										<td class=" tac nanumR">${vmEx}</td>
										<!-- <td class=" tar nanumR fc-blue pr30"><fmt:formatNumber value="${vmAmount}" pattern="#,###"/><span class="fc11">&nbsp;원</span></td>-->
									</tr>
								</c:if>

								<c:if test="${subNew ne 0 or subCh ne 0 or subEx ne 0}">
									<tr class="">
										<td class=" tac" scope="row">부가자원</td>
										<td class=" tac nanumR">${subNew}</td>
										<td class=" tac nanumR">${subCh}</td>
										<td class=" tac nanumR">${subEx}</td>
										<!-- <td class=" tar nanumR fc-blue pr30"><fmt:formatNumber value="${subAmount}" pattern="#,###"/><span class="fc11">&nbsp;원</span></td>-->
									</tr>
								</c:if>

								<c:if test="${servNew ne 0 or servCh ne 0 or servEx ne 0}">
									<tr class="">
										<td class=" tac" scope="row">서비스</td>
										<td class=" tac nanumR">${servNew}</td>
										<td class=" tac nanumR">${servCh}</td>
										<td class=" tac nanumR">${servEx}</td>
										<!-- <td class=" tar nanumR fc-blue pr30"><fmt:formatNumber value="${servmount}" pattern="#,###"/><span class="fc11">&nbsp;원</span></td>-->
									</tr>
								</c:if>

							</tbody>
							<!-- <tfoot>
			      	 		<tr>
			      	 			<td class="tac">총합계 </td>
			      	 			<td class="f20 fc-red"></td>
			      	 			<td></td>
			      	 			<td></td>
			      	 			<td class="f20 fc-red pr30" ><input type="text" id="totalPrice" class="dpin bn w80 tar"/> <span class="f14 fc99"> 원</span></td>
			      	 		</tr>
			      	 	</tfoot>-->
						</table>
						<!-- end page-body 승인요약금액  -->

						<!-- begin page-body 승인부분  -->
						<div class="row p-b-100 ">
							<!-- 검토&승인 부서 결재라인 표시부분 시작 -->
							<div class="row mb30 mt20 workApprovalProjectView-group">
								<!-- 요청부서 결재 표시부분 시작 -->
								<div class="col-xs-6 request box">
									<h3 class="request_title">요청부서</h3>

									<div class="col-xs-12 clear mt50">
										<c:forEach items="${getProductAppSteplist}" var="projectAppSteplistInfo" varStatus="status">
											<c:if test="${projectAppSteplistInfo.stepLevel eq '1'}">
												<div class="col-xs-3 tac pl0 pr0">
													<ul class="step00 fl">
														<li class="fc11 f18 fb">입안보조</li>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
															<!--  진행중  -->
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw fc-red f30"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
															<!-- 승인완료  -->
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
															<!-- 반려  -->
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply fc-orange f30"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
															<!-- 대기  -->
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i></li>
														</c:if>
													</ul>

													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
														<p class="ribbon_00">진행중</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
														<p class="ribbon_00">승인완료</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
														<p class="ribbon_re">반려</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
														<p class="ribbon_stay">대기</p>
													</c:if>
													<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
												</div>
											</c:if>

											<c:if test="${projectAppSteplistInfo.stepLevel eq '2'}">
												<div class="col-xs-3 pl0 pr0 tac">
													<ul class="step01">
														<li class="fc11 f18 fb">입안</li>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply fc-orange f30"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-hourglass-half fc66 f30"></i></li>
														</c:if>
													</ul>

													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
														<p class="ribbon_01">진행중</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
														<p class="ribbon_01">승인완료</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
														<p class="ribbon_re">반려</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
														<p class="ribbon_stay">대기</p>
													</c:if>
													<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
												</div>
											</c:if>

											<c:if test="${projectAppSteplistInfo.stepLevel eq '3'}">
												<div class="col-xs-3 pl0 pr0 tac">
													<ul class="step02">
														<li class="fc11 f18 fb">검토</li>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply f30 fc-orange"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i></li>
														</c:if>
													</ul>

													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
														<p class="ribbon_02">진행중</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
														<p class="ribbon_02">승인완료</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
														<p class="ribbon_re">반려</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
														<p class="ribbon_stay">대기</p>
													</c:if>
													<p class="fc99 f12 tac mt5">${projectAppSteplistInfo.apprvDatetime}</p>
												</div>
											</c:if>

											<c:if test="${projectAppSteplistInfo.stepLevel eq '4'}">
												<div class="col-xs-3 tac pl0 pr0 tac">
													<ul class="step03 flr">
														<li class="fc11 f18 fb">승인</li>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING'}">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply f30 fc-orange"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i></li>
														</c:if>
													</ul>

													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
														<p class="ribbon_03 fw">진행중</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
														<p class="ribbon_03 fw">승인완료</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
														<p class="ribbon_re fw">반려</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
														<p class="ribbon_stay">대기</p>
													</c:if>
													<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
								<!-- 요청부서 결재 표시부분 끝-->

								<!-- 승인부서 결재 표시부분 시작 -->
								<div class="col-xs-6 approval flr box">
									<h3 class="approval_title">승인부서</h3>

									<div class="col-xs-12 clear mt50">
										<c:forEach items="${getProductAppSteplist}" var="projectAppSteplistInfo" varStatus="status">
											<c:if test="${projectAppSteplistInfo.stepLevel eq '5'}">
												<div class="col-xs-3 pl0 pr0 tac">
													<ul class="step00 fl">
														<li class="fc11 f18 fb">입안보조</li>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i></li>
														</c:if>
													</ul>

													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
														<p class="ribbon_00">진행중</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
														<p class="ribbon_00">승인완료</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
														<p class="ribbon_re">반려</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
														<p class="ribbon_stay">대기</p>
													</c:if>
													<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
												</div>
											</c:if>

											<c:if test="${projectAppSteplistInfo.stepLevel eq '6'}">
												<div class="col-xs-3 pl0 pr0 tac">
													<ul class="step04 fl">
														<li class="fc11 f18 fb">입안</li>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i></li>
														</c:if>
													</ul>

													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
														<p class="ribbon_04">진행중</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
														<p class="ribbon_04">승인완료</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
														<p class="ribbon_re">반려</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
														<p class="ribbon_stay">대기</p>
													</c:if>
													<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
												</div>
											</c:if>

											<c:if test="${projectAppSteplistInfo.stepLevel eq '7'}">
												<div class="col-xs-3 pl0 pr0 tac">
													<ul class="step05">
														<li class="fc11 f18 fb">검토</li>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i></li>
														</c:if>
													</ul>

													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
														<p class="ribbon_05">진행중</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
														<p class="ribbon_05">승인완료</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
														<p class="ribbon_re">반려</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
														<p class="ribbon_stay">대기</p>
													</c:if>
													<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
												</div>
											</c:if>

											<c:if test="${projectAppSteplistInfo.stepLevel eq '8'}">
												<div class="col-xs-3 pl0 pr0 tac">
													<ul class="step06 flr">
														<li class="fc11 f18 fb">승인</li>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
															<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
															<li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply f30 fc66"></i></li>
														</c:if>
														<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
															<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
															<li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i></li>
														</c:if>
													</ul>

													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
														<p class="ribbon_06 fw">진행중</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
														<p class="ribbon_06 fw">승인완료</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
														<p class="ribbon_re fw">반려</p>
													</c:if>
													<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
														<p class="ribbon_stay">대기</p>
													</c:if>

													<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
								<!-- 승인부서 결재 표시부분 끝 -->
							</div>
							<!-- end page-body 승인부분  -->
							<input type="hidden" id="hiddenTotalprice" value="${amount}"> <input type="hidden" id="orderNo" value="${orderNo}"> <input type="hidden" id="userId" value="${userId}"> <input type="hidden" id="inject" value="${inject}">
							<div class="clear"></div>
						</div>
						<!-- 검토&승인 부서 결재라인 표시부분 끝 -->

					</div>
					<!-----기본자원 끝------->

					<!-- begin #content page-body -->

					<!-- begin #content modal -->
					<!-- 작업자 지정 팝업 -->
					<div class="modal fade" id="modal-dialog3">
						<div class="modal-dialog">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title">작업자 지정</h4>
								</div>
								<div class="modal-body">
									<div class="page_searchBox m-b-15">
										<div class="searchArea">
											<div class="inputArea m-l-5">
												<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)modalList();" style="width: 362px"> <a type="button" class="btn_search" onclick="modalList();">검색</a>
											</div>
										</div>
									</div>
									<div class="noneList" style="display: none;">
										<span>검색된 사용자가 없습니다.</span>
									</div>
									<div class="listArea" id="popListTable"></div>
									<div class="totalcnt" id="totalCnt">총 4 건</div>
								</div>
								<div class="modal-footer tac">
									<a type="button" class="whiteline" id="popclose" onclick='setWorkUserName();'>확인</a>
								</div>
							</div>
						</div>
					</div>

					<div class="modal fade" id="retryModal">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<input type="hidden" id="retryOrderno">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridPopList();'>
										<span></span>
									</button>
									<h4 class="modal-title">작업내역</h4>
								</div>
								<div class="modal-body">
									<div class="client_DetailArea">
										<div>
											<span class="dpin fb fc-blue2">작업 결과 : 실패</span>
										</div>
										<div class="mt15">
											<span class="dpin fb fc-blue2">실패 내용 : <span id="retryMessage"></span></span>
										</div>
										<div class="mt15">
											<textarea style="height: 200px" rows="5" placeholder="작업종료 사유를 입력해주세요." id="endDescription" name="endDescription"></textarea>
										</div>
									</div>
								</div>
								<div class="modal-footer tac">
									<a type=button class="pbton bton_blue" data-dismiss="modal" onclick="retryProvisioning();">재시도</a> <a type=button class="pbton bton_green" data-dismiss="modal" onclick="endProvisioning();">작업종료</a> <a type=button class="pbton bton_dgrey" data-dismiss="modal">취소</a>
								</div>
							</div>
						</div>
					</div>


					<div class="modal fade" id="endModal">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<input type="hidden" id="retryOrderno">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridPopList();'>
										<span></span>
									</button>
									<h4 class="modal-title">작업종료내역</h4>
								</div>
								<div class="modal-body">
									<div class="client_DetailArea">
										<div>
											<span class="dpin fb fc-blue2">작업 결과 : 실패</span>
										</div>
										<div class="mt15">
											<span class="dpin fb fc-blue2">작업종료 내용 : <span id="endMessage"></span></span>
										</div>

									</div>
								</div>
								<div class="modal-footer tac">
									<a type=button class="pbton bton_dgrey" data-dismiss="modal">닫기</a>
								</div>
							</div>
						</div>
					</div>

					<!-- 가상서버 상세 팝업 -->
					<div class="modal fade" id="modal-dialog-reqlist">
						<div class="modal-dialog">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title">가상서버 상세</h4>
								</div>
								<div class="modal-body" id="vmDetailPopup">
									<div class="reqDetailArea">
										<div class="title tal">
											<span class="statusLabel_small status_new">신규</span>
											<h4>아이뷰몰 프로젝트</h4>
										</div>
										<div class="detail_01">
											<ul>
												<li><span class="doubledotte">서버명</span> <em id="">리뷰호스트0805_1리뷰호스트</em></li>
												<li><span class="doubledotte">호스트명</span> <em id="" class="fontVdn">review_host0805_1reviewrev</em></li>
												<li><span class="doubledotte">네트워크</span> <em id="">리뷰회원사_내부_망</em></li>
												<li><span class="doubledotte">OS</span> <em id=""></em></li>

											</ul>
										</div>
										<div class="detail_02">
											<ul>
												<li class="p-r-20  p-l-20"><span class="fontVdn tal label01">vCPU</span>
													<p class="tar m-t-5">
														<em class="fontVdn vcpuResult">44</em><span class="fontVdn fc66 f14 m-l-5">Core</span>
													</p></li>
												<li class="p-r-20 p-l-20"><span class="fontVdn tal label02">MEMORY</span>
													<p class="tar m-t-5">
														<em class="fontVdn memResult">1,123</em><span class="fontVdn fc66 f14 m-l-5">GB</span>
													</p></li>
												<li class="p-r-20 p-l-20"><span class="fontVdn tal label03">DISK</span>
													<p class="tar m-t-5">
														<em class="fontVdn diskResult">99,999</em><span class="fontVdn fc66 f14 m-l-5">GB</span>
													</p></li>
											</ul>
										</div>
										<div class="detail_03">
											<ul>
												<li><span class="doubledotte">과금단위</span> <em id="">월 단위</em></li>
												<li><span class="doubledotte">서비스희망일시</span> <em id="">승인완료 후 생성</em></li>
											</ul>
										</div>
										<div class="detail_04">
											<span class="f18 fc11">금액</span> <span class="flr"> <em class="fontVdn result">88,888,888</em> <span class="f18 fc66">원</span>
											</span>
										</div>
									</div>
								</div>
								<div class="modal-footer tac">
									<a type="button" class="whiteline" data-dismiss="modal" id="popclose">닫기</a>
								</div>
							</div>
						</div>
					</div>

					<!-- 블록디스크 상세 팝업 -->
					<div class="modal fade" id="modal-dialog-disk">
						<div class="modal-dialog">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title">블록디스크 상세</h4>
								</div>
								<div class="modal-body" id="diskDetailPopup">
									<div class="reqDetailArea">
										<div class="title tal">
											<span class="statusLabel_small status_new">신규</span>
											<h4>아이뷰몰 프로젝트</h4>
										</div>
										<div class="detail_01" style="border-bottom: 1px solid #999">
											<ul>
												<li><span class="doubledotte" style="width: 90px">가상서버</span> <em id="">리뷰호스트0805_1리뷰호스트</em></li>
												<li><span class="doubledotte" style="width: 90px">디스크명</span> <em id="" class="fontVdn" style="letter-spacing: -1px">12838c52-4ace-4e31-afcb-03e3ea23d37b</em></li>
												<li><span class="doubledotte" style="width: 90px">디스크크기</span> <em id="" class="fontVdn"> <strong class="fc11">12,345</strong> <strong class="fc66 f16">GB</strong>
												</em></li>
											</ul>
										</div>
										<div class="detail_03">
											<ul>
												<li><span class="doubledotte">과금단위</span> <em id="">월 단위</em></li>
												<li><span class="doubledotte">서비스희망일시</span> <em id="">승인완료 후 생성</em></li>
											</ul>
										</div>
										<div class="detail_04">
											<span class="f18 fc11">금액</span> <span class="flr"> <em class="fontVdn result">88,888,888</em> <span class="f18 fc66">원</span>
											</span>
										</div>
									</div>
								</div>
								<div class="modal-footer tac">
									<a type="button" class="whiteline" data-dismiss="modal" id="popclose">닫기</a>
								</div>
							</div>
						</div>
					</div>

					<!-- NAS 상세 팝업 -->
					<div class="modal fade" id="modal-dialog-nas">
						<div class="modal-dialog">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title">NAS 상세</h4>
								</div>
								<div class="modal-body" id="nasDetailPopup">
									<div class="reqDetailArea">
										<div class="title tal">
											<span class="statusLabel_small status_new">신규</span>
											<h4>아이뷰몰 프로젝트</h4>
										</div>
										<div class="detail_01" style="border-bottom: 1px solid #999">
											<ul>
												<li><span class="doubledotte" style="width: 80px">서버명</span> <em id="">리뷰호스트0805_1리뷰호스트</em></li>
												<li><span class="doubledotte" style="width: 80px">NAS명</span> <em id="" class="fontVdn" style="letter-spacing: -1px">12838c52-4ace-4e31-afcb-03e3ea23d37b</em></li>
												<li><span class="doubledotte" style="width: 80px">NAS용량</span> <em id="" class="fontVdn"> <strong class="fc11">12,345</strong> <strong class="fc66 f16">GB</strong>
												</em></li>
											</ul>
										</div>
										<div class="detail_03">
											<ul>
												<li><span class="doubledotte">과금단위</span> <em id="">월 단위</em></li>
												<li><span class="doubledotte">서비스희망일시</span> <em id="">승인완료 후 생성</em></li>
											</ul>
										</div>
										<div class="detail_04">
											<span class="f18 fc11">금액</span> <span class="flr"> <em class="fontVdn result">88,888,888</em> <span class="f18 fc66">원</span>
											</span>
										</div>
									</div>
								</div>
								<div class="modal-footer tac">
									<a type="button" class="whiteline" data-dismiss="modal" id="popclose">닫기</a>
								</div>
							</div>
						</div>
					</div>

					<!-- 서비스 로드분산 상세 팝업 -->
					<div class="modal fade" id="modal-dialog-lb">
						<div class="modal-dialog">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title" id="lbpoptitle">서비스 로드분산 상세</h4>
								</div>
								<div class="modal-body" id="lbDetailPopup">
									<div class="reqDetailArea">
										<div class="title tal">
											<span class="statusLabel_small status_new">신규</span>
											<h4>아이뷰몰 프로젝트</h4>
										</div>
										<div class="detail_01" style="border-bottom: 1px solid #999">
											<ul>
												<li><span class="doubledotte" style="width: 140px">서비스 로드분산명</span><br /> <em id="" class="fontVdn">12838c52-4ace-4e31-afcb-03e3ea23d37b</em></li>
											</ul>
										</div>
										<div class="detail_03">
											<ul>
												<li><span class="doubledotte">과금단위</span> <em id="">월 단위</em></li>
												<li><span class="doubledotte">서비스희망일시</span> <em id="">승인완료 후 생성</em></li>
											</ul>
										</div>
										<div class="detail_04">
											<span class="f18 fc11">금액</span> <span class="flr"> <em class="fontVdn result">88,888,888</em> <span class="f18 fc66">원</span>
											</span>
										</div>
									</div>
								</div>
								<div class="modal-footer tac">
									<a type="button" class="whiteline" data-dismiss="modal" id="popclose">닫기</a>
								</div>
							</div>
						</div>
					</div>

					<!-- 스냅샷 상세 팝업 -->
					<div class="modal fade" id="modal-dialog-sn">
						<div class="modal-dialog">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title">스냅샷 상세</h4>
								</div>
								<div class="modal-body" id="snDetailPopup">
									<div class="reqDetailArea">
										<div class="title tal">
											<span class="statusLabel_small status_new">신규</span>
											<h4>아이뷰몰 프로젝트</h4>
										</div>
										<div class="detail_01" style="border-bottom: 1px solid #999">
											<ul>
												<li><span class="doubledotte" style="width: 140px">스냅샷명</span><br /> <em id="" class="fontVdn">12838c52-4ace-4e31-afcb-03e3ea23d37b</em></li>
											</ul>
										</div>
										<div class="detail_03">
											<ul>
												<li><span class="doubledotte">서비스희망일시</span> <em id="">승인완료 후 생성</em></li>
											</ul>
										</div>
										<div class="detail_04">
											<span class="f18 fc11">금액</span> <span class="flr"> <em class="fontVdn result">88,888,888</em> <span class="f18 fc66">원</span>
											</span>
										</div>
									</div>
								</div>
								<div class="modal-footer tac">
									<a type="button" class="whiteline" data-dismiss="modal" id="popclose">닫기</a>
								</div>
							</div>
						</div>
					</div>

					<!-- 공인IP 상세 팝업 -->
					<div class="modal fade" id="modal-dialog-ip">
						<div class="modal-dialog">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title">공인 IP 상세</h4>
								</div>
								<div class="modal-body" id="ipDetailPopup">
									<div class="reqDetailArea">
										<div class="title tal">
											<span class="statusLabel_small status_new">신규</span>
											<h4>아이뷰몰 프로젝트</h4>
										</div>
										<div class="detail_01" style="border-bottom: 1px solid #999">
											<ul>
												<li><span class="doubledotte" style="width: 80px">연결할 곳</span> <em id="">웹 서버#1, 웹 서버#1, 웹 서버#1</em></li>
											</ul>
										</div>
										<div class="detail_03">
											<ul>
												<li><span class="doubledotte">과금단위</span> <em id="">월 단위</em></li>
												<li><span class="doubledotte">서비스희망일시</span> <em id="">승인완료 후 생성</em></li>
											</ul>
										</div>
										<div class="detail_04">
											<span class="f18 fc11">금액</span> <span class="flr"> <em class="fontVdn result">88,888,888</em> <span class="f18 fc66">원</span>
											</span>
										</div>
									</div>
								</div>
								<div class="modal-footer tac">
									<a type="button" class="whiteline" data-dismiss="modal" id="popclose">닫기</a>
								</div>
							</div>
						</div>
					</div>

					<!-- 서비스 상세 팝업 -->
					<div class="modal fade" id="modal-dialog-service">
						<div class="modal-dialog" id="svcDetailPopup">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title">서비스 상세</h4>
								</div>
								<div class="modal-body">
									<div class="reqDetailArea">
										<div class="title tal">
											<span class="statusLabel_small status_new">신규</span>
											<h4>아이뷰몰 프로젝트</h4>
										</div>
										<div class="detail_03" style="border-top: 2px solid #999">
											<ul>
												<li><span class="doubledotte">과금단위</span> <em id="">월 단위</em></li>
												<li><span class="doubledotte">서비스희망일시</span> <em id="">승인완료 후 생성</em></li>
											</ul>
										</div>
										<div class="detail_04">
											<span class="f18 fc11">금액</span> <span class="flr"> <em class="fontVdn result">88,888,888</em> <span class="f18 fc66">원</span>
											</span>
										</div>
									</div>
								</div>
								<div class="modal-footer tac">
									<a type="button" class="whiteline" data-dismiss="modal" id="popclose">닫기</a>
								</div>
							</div>
						</div>
					</div>

					<div class="modal fade" id="modal-dialog-app">
						<div class="modal-dialog" id="appDetailPopup">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title">어플리케이션 상세</h4>
								</div>

								<div class="modal-body"></div>
								<div class="modal-footer tac">
									<a type="button" class="whiteline" data-dismiss="modal" id="popclose">닫기</a>
								</div>

							</div>
						</div>
					</div>

					<div class="modal fade" id="modal-dialog-env">
						<div class="modal-dialog" id="envDetailPopup">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title">개발환경 상세</h4>
								</div>
								<div class="modal-body">
								</div>
								<div class="modal-footer tac">
									<a type="button" class="whiteline" data-dismiss="modal" id="popclose">닫기</a>
								</div>
							</div>
						</div>
<!-- 						<div id="envUserList"  class="mt20"> -->
<!-- 						</div> -->
					</div>

					<!-- 실시간 가용 용량 팝업 -->
					<div class="modal fade" id="modal-dialog-useVolume">
						<div class="modal-dialog width-800">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title">실시간 가용 용량</h4>
								</div>
								<div class="modal-body useVolumeTable" id="useVolumeTable">
									<table class="detail_Table" style="table-layout: auto;">
										<colgroup>
											<col width="*">
											<col width="100x">
											<col width="100px">
											<col width="100px">
											<col width="100px">
										</colgroup>
										<thead>
											<tr>
												<th>구분</th>
												<th>가상서버</th>
												<th class='fontVdn'><span class="fontVdn">vCPU</span><br /> <span class="fontN">(Core)</span></th>
												<th class='fontVdn'><span class="fontVdn">MEMORY</span><br /> <span class="fontN">(GB)</span></th>
												<th class='fontVdn'><span class="fontVdn">DISK</span><br /> <span class="fontN">(GB)</span></th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="leftHead tal">클라우드<br />용량
												</td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
											</tr>
											<tr>
												<td class="leftHead tal">클라우드<br />사용용량
												</td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
											</tr>
											<tr>
												<td class="leftHead tal">클라우드<br />가용용량
												</td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
											</tr>
											<tr>
												<td class="leftHead tal">프로젝트<br />제한
												</td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
											</tr>
											<tr>
												<td class="leftHead tal">프로젝트<br />사용용량
												</td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
											</tr>
											<tr class="sumRow b-b99">
												<td class="leftHead tal">실시간<br />가용용량
												</td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
												<td class="tar fontVdn"></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="modal-footer tac">
									<a type="button" class="pbton bton_blue" data-dismiss="modal" id="popclose">확인</a> <a type="button" class="pbton bton_dgrey ml10" data-dismiss="modal" id="popclose">취소</a>
								</div>
							</div>
						</div>
					</div>
					<!-- #modal-dialog 결재자 지정팝업-->
					<div class="modal fade" id="modal-approve-review-dialog">
						<div class="modal-dialog width-720">
							<div class="modal-content width-720">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									<h4 class="modal-title">승인부서 결재지정</h4>
								</div>

								<div class="modal-body">
									<table class="tableV">
										<colgroup>
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="10%">
										</colgroup>
										<thead>
											<tr class="skyblue">
												<th>구분</th>
												<th>사번</th>
												<th>직급</th>
												<th>이름</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="tac" id="approvalLine1_title">입안보조</td>
												<td class="tac" id="approvalLine1_userId">사번</td>
												<td class="tac" id="approvalLine1_userLevel">직급</td>
												<td class="tac" id="approvalLine1_userName">이름</td>
												<td class="tac">
													<button type="button" class="cbton bton_lblue" id="approvalLine1" onclick="openReviewModal(this);">
														<i class='fa fa-search'></i>
													</button>
												</td>
											</tr>
											<tr>
												<td class="tac" id="approvalLine2_title">입안</td>
												<td class="tac" id="approvalLine2_userId">사번</td>
												<td class="tac" id="approvalLine2_userLevel">직급</td>
												<td class="tac" id="approvalLine2_userName">이름</td>
												<td class="tac">
													<button type="button" class="cbton bton_lblue" id="approvalLine2" onclick="openReviewModal(this);" disabled="disabled">
														<i class='fa fa-search'></i>
													</button>
												</td>
											</tr>
											<tr>
												<td class="tac" id="approvalLine3_title">검토</td>
												<td class="tac" id="approvalLine3_userId">사번</td>
												<td class="tac" id="approvalLine3_userLevel">직급</td>
												<td class="tac" id="approvalLine3_userName">이름</td>
												<td class="tac">
													<button type="button" class="cbton bton_lblue" id="approvalLine3" onclick="openReviewModal(this);" disabled="disabled">
														<i class='fa fa-search'></i>
													</button>
												</td>
											</tr>
											<tr>
												<td class="tac" id="approvalLine4_title">승인</td>
												<td class="tac" id="approvalLine4_userId">사번</td>
												<td class="tac" id="approvalLine4_userLevel">직급</td>
												<td class="tac" id="approvalLine4_userName">이름</td>
												<td class="tac">
													<button type="button" class="cbton bton_lblue" id="approvalLine4" onclick="openReviewModal(this);" disabled="disabled">
														<i class='fa fa-search'></i>
													</button>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="clear"></div>
								<div class="modal-footer tac">
									<a type=button class="pbton bton_blue" data-dismiss="modal" onclick="checkApproval();">확인</a> <a type=button class="pbton bton_dgrey" data-dismiss="modal">취소</a>
								</div>
							</div>
						</div>
					</div>

					<!-- 프로젝트 검토자 결재자 지정 팝업 -->
					<!-- #modal-dialog -->
					<div class="modal fade" id="user-modal-review-dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridPopList();'>
										<span></span>
									</button>
									<h4 class="modal-title">직원 검색</h4>
								</div>
								<div class="modal-body">

									<!--//검색 시작-->
									<div class="page_searchBox m-b-15">
										<div class="searchArea">
											<div class="selectBox" style="width: 100px;">
												<label class="selectText" for="reviewSearchKind">전체</label> <select class="search-sel" id="reviewSearchKind">
													<option value="searchAll">전체</option>
													<option value="userId">사번</option>
													<option value="userName">이름</option>
													<option value="deptName">부서</option>
												</select>
											</div>
											<div class="inputArea m-l-5">
												<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="reviewUserId" onkeypress="if(event.keyCode==13)gridPopList();">
												<button type="button" class="bton-s bton_blue" onclick="gridPopList();">
													<i class="fa fa-search"></i> 검색
												</button>
											</div>
										</div>
									</div>
									<!--검색  끝//-->

									<table class="tableV">
										<colgroup>
											<col width="*">
											<col width="*">
											<col width="*">
											<col width="*">
											<col width="*">
											<col width="80px">
										</colgroup>
										<thead>
											<tr class="skyblue">
												<th class="tac">부서</th>
												<th class="tac">사번</th>
												<th class="tac">직급</th>
												<th class="tac">이름</th>
												<th class="tac">상태</th>
												<th class="tac"></th>
											</tr>
										</thead>
										<tbody id="popListReviewTable">
										</tbody>
									</table>

									<div class="noneList" id='popListReviewTable2'>
										<span>검색된 사용자가 없습니다.</span>
									</div>
									<div class="totalcnt" id="totalReviewCnt">총 0 건</div>
								</div>
								<div class="modal-footer tac">
									<a type="button" class="whiteline" data-dismiss="modal">닫기</a>
								</div>
							</div>
						</div>
					</div>
					<!-- #modal-dialog -->


					<!-- 반려사유 팝업 -->
					<div class="modal fade" id="modal-dialog-reject">
						<div class="modal-dialog">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										<span></span>
									</button>
									<h4 class="modal-title">반려 사유</h4>
								</div>
								<div class="modal-body">
									<div class="rejectInfo m-b-20">반려 사유를 상세하게 입력하여 주십시오.</div>
									<textarea style="height: 200px" rows="5" placeholder="반려 사유를 입력해주세요." id="apprvDescription" name="apprvDescription"></textarea>
								</div>
								<div class="modal-footer tac">
									<a type="button" class="lbtn" id="popclose" onclick="javascript:projectRejected();">확인</a> <a type="button" class="rbtn" data-dismiss="modal" id="popclose">취소</a>
								</div>
							</div>
						</div>
					</div>
					<!-- end modal -->
					<!-- 			</div> -->
				</div>
				<!-- end .card page-body -->

				<!-- begin #footer -->
				<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

				<div style="display: none;">
					<table>
						<tbody id="parameter_clone_temp">
							<tr>
								<td class="left">#paramKey#</td>
								<td><input class="form-control width-505 #parameterClass#" type="text" name="#paramName#" id="#paramId#" value="#paramValue#" data-expression=#paramGenerate# data-from=#paramFrom# data-key="#paramKey#" data-original-title="" title=""></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div style="display: none;">
					<table>
						<tbody id="parameter_clone_temp_pop">
							<tr>
								<td class="left">#paramKeyPop#</td>
								<td><input class="form-control width-300 #parameterClass#" type="text" name="#paramNamePop#" id="#paramIdPop#" value="#paramValuePop#" data-expression=#paramGeneratePop# data-from=#paramFromPop# data-key="#paramKeyPop#" data-original-title="" title="" readonly></td>
							</tr>
						</tbody>
					</table>
				</div>

			</div>
			<!-- end #content -->
		</div>
		<!-- end .main -->
	</div>
	<!-- end #page-container -->
	<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
	<script type="text/javascript" src="/resources/assets/js/randexp.min.js"></script>
	<script type="text/javascript">

	// 결재라인 관련 변수
	var currentApprovalLine = "";
	var approvalList = [];
	var hostnameList = [<c:forEach items="${checkHostName}" var="checkHostName" varStatus="status" >'${checkHostName.hostname}'<c:if test="${!status.last}">,</c:if></c:forEach>];
	var ipList =[<c:forEach items="${checkIp}" var="checkIp" varStatus="status" >'${checkIp.defaultNetworkIp}'<c:if test="${!status.last}">,</c:if></c:forEach>];
	var nasIpList =[<c:forEach items="${checkNasIp}" var="checkNasIp" varStatus="status" >'${checkNasIp.defaultNetworkIp}'<c:if test="${!status.last}">,</c:if></c:forEach>];
	var backIpList =[<c:forEach items="${checkBackupIp}" var="checkBackupIp" varStatus="status" >'${checkBackupIp.defaultNetworkIp}'<c:if test="${!status.last}">,</c:if></c:forEach>];

	// 가상서버 신청 관련 변수
	var bssOrderProductVmUpdateList = [];
	var bssOrderProductNasUpdateList = [];



	function saveHostNameCheck(hostname, orderNo) {
		if(hostname == '' && hostname == null) {
			alertBox3("HOSTNAME을 확인해 주세요");
			return false;
		}
		if(hostname.length != 8) {
			alertBox3("호스트명이 8자가 아닙니다.");
			return false;
		}
		$("#h_hostname").val(hostname);
		$("#h_orderNo").val(orderNo);

		$.ajax({
			url : "${contextPath}/mng/req/product/setHostNameCheck",
			dataType : "JSON",
 			type : "POST",
			data : {
				"hostname" : hostname
			},
			success : function(data) {
				var result = data;
				if(result == 0){
					saveYn();
				} else {
					alertBox3("HOSTNAME이 중복되었습니다.");
					return false;
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function saveIpCheck(ip, orderNo,cloudId) {
		if((ip == '' && ip == null) || regIp(ip) == null) {
// 		if(ip == "" || ip == null || regIp(ip) == null) {
			alertBox3("IP를 확인해 주세요");
			return false;
		}

		$("#h_ip").val(ip);
		$("#h_orderNo").val(orderNo);
		$.ajax({
			url : "${contextPath}/mng/req/product/setIpCheck",
			dataType : "JSON",
 			type : "POST",
			data : {
				"defaultNetworkIp" : ip,
				"cloudId" : cloudId
			},
			success : function(data) {
				var result = data;

				if(result == 0){
					saveYnIp();
				}else{
					alertBox3("이미 사용중인 IP 입니다.");
					return false;
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function saveNasIpCheck(ip, orderNo,cloudId) {

		if((ip == '' && ip == null) || regIp(ip) == null) {
			alertBox3("IP를 확인해 주세요");
			return false;
		}

		$("#h_ip").val(ip);
		$("#h_orderNo").val(orderNo);
		$.ajax({
			url : "${contextPath}/mng/req/product/setNasIpCheck",
			dataType : "JSON",
 			type : "POST",
			data : {
				"defaultNetworkIp" : ip,
				"cloudId" : cloudId
			},
			success : function(data) {
				var result = data;

				if(result == 0){
					saveYnNasIp();
				}else{
					alertBox3("이미 사용중인 IP 입니다.");
					return false;
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function saveBackupIpCheck(ip, orderNo,cloudId) {

		if(ip == '' && ip == null || regIp(ip) == null) {
			alertBox3("IP를 확인해 주세요");
			return false;
		}
		$("#h_backupIp").val(ip);
		$("#h_orderNo").val(orderNo);
		var cloudId = "${projectInfo.cloudId}";
		$.ajax({
			url : "${contextPath}/mng/req/product/setBackupIpCheck",
			dataType : "JSON",
 			type : "POST",
			data : {
				"backupNetworkIp" : ip,
				"cloudId" : cloudId
			},
			success : function(data) {
				var result = data;
				if(result == 0){
					saveYnBackupIp();
				}else{
					alertBox3("이미 사용중인 IP 입니다.");
					return false;
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function regIp(ip){
		var regExp = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}((0|[2-9])|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-4])$/;
		var regResult = ip.match(regExp);
		return regResult;
	}

	function saveUserIdCheck(userId , orderNo){
		if(userId == '' || userId == null) {
			alertBox3("사용자 ID를 입력해주세요");
			return false;
		}

		$("#h_vmUserId").val(userId);
		$("#h_orderNo").val(orderNo);

		$.ajax({
			url : "${contextPath}/mng/req/product/setUserIdCheck",
			dataType : "JSON",
 			type : "POST",
			data : {
				"bastionVmUserId" : userId
			},
			success : function(data) {
				var result = data;
				if(result == 0){
					saveUserIdYn();
				} else {
					alertBox3("사용중인 ID입니다.");
					return false;
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function saveUserPwCheck(userPw , orderNo){
		if(userPw == '' || userPw == null) {
			alertBox3("사용자 PW를 입력해주세요");
			return false;
		}

		$("#h_vmUserPw").val(userPw);
		$("#h_orderNo").val(orderNo);

		$.ajax({
			url : "${contextPath}/mng/req/product/setUserPwCheck",
			dataType : "JSON",
 			type : "POST",
			data : {
				"bastionVmUserPassword" : userPw
			},
			success : function(data) {
				var result = data;
				if(result == 0){
					saveUserPwYn();
				} else {
					alertBox3("사용중인 비밀번호입니다.");
					return false;
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function saveYn(){
		confirmBox2("저장 하시겠습니까?", saveHostName);
	}

	function saveHostName() {
		var targetId = $("#h_orderNo").val()+'HostNameChk';
		$.ajax({
			url : "${contextPath}/mng/req/product/setHostName",
			dataType : "JSON",
 			type : "POST",
			data : {
				"orderProductSeq" : $("#h_orderNo").val(),
				"hostname" : $("#h_hostname").val()

			},
			success : function(data) {
				alertBox3("저장 되었습니다.");
				$("#"+targetId).val("Y");
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function saveYnIp(){
		confirmBox2("저장 하시겠습니까?", saveIp);
	}

	function saveIp() {
		var targetId = $("#h_orderNo").val()+'IpChk';
		$.ajax({
			url : "${contextPath}/mng/req/product/setIp",
			dataType : "JSON",
 			type : "POST",
			data : {
				"orderProductSeq" : $("#h_orderNo").val(),
				"defaultNetworkIp" : $("#h_ip").val()

			},
			success : function(data) {
				alertBox3("저장 되었습니다.");
				$("#"+targetId).val("Y");
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function saveYnNasIp(){
		confirmBox2("저장 하시겠습니까?", saveNasIp);
	}

	function saveNasIp() {
		var targetId = $("#h_orderNo").val()+'IpChk';
		$.ajax({
			url : "${contextPath}/mng/req/product/setNasIp",
			dataType : "JSON",
 			type : "POST",
			data : {
				"orderProductSeq" : $("#h_orderNo").val(),
				"defaultNetworkIp" : $("#h_ip").val()

			},
			success : function(data) {
				alertBox3("저장 되었습니다.");
				$("#"+targetId).val("Y");
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function saveYnBackupIp(){
		confirmBox2("저장 하시겠습니까?", saveBackupIp);
	}

	function saveBackupIp() {
		var targetId = $("#h_orderNo").val()+'BackupIpChk';
		$.ajax({
			url : "${contextPath}/mng/req/product/setBackupIp",
			dataType : "JSON",
 			type : "POST",
			data : {
				"orderProductSeq" : $("#h_orderNo").val(),
				"backupNetworkIp" : $("#h_backupIp").val()

			},
			success : function(data) {
				alertBox3("저장 되었습니다.");
				$("#"+targetId).val("Y");
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function saveUserIdYn(){
		confirmBox2("저장 하시겠습니까?", saveUserId);
	}

	function saveUserId(){
		var targetId = $("#h_orderNo").val()+'VmUserId';
		$.ajax({
			url : "${contextPath}/mng/req/product/setVmUserId",
			dataType : "JSON",
 			type : "POST",
			data : {
				"orderProductSeq" : $("#h_orderNo").val(),
				"bastionVmUserId" : $("#h_vmUserId").val()
			},
			success : function(data) {
				alertBox3("저장 되었습니다.");
// 				$("#"+targetId).val("Y");
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function saveUserPwYn(){
		confirmBox2("저장 하시겠습니까?", saveUserPw);
	}

	function saveUserPw(userPw , orderNo){

		if(userPw == '' || userPw == null) {
			alertBox3("사용자 PW를 입력해주세요");
			return false;
		}

		$("#h_vmUserPw").val(userPw);
		$("#h_orderNo").val(orderNo);

		var targetId = $("#h_orderNo").val()+'VmUserPw';
		$.ajax({
			url : "${contextPath}/mng/req/product/setVmUserPw",
			dataType : "JSON",
 			type : "POST",
			data : {
				"orderProductSeq" : $("#h_orderNo").val(),
				"bastionVmUserPassword" : $("#h_vmUserPw").val()
			},
			success : function(data) {
				alertBox3("저장 되었습니다.");
// 				$("#"+targetId).val("Y");
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

		// 자원구매승인 상세 불러오기
// 	function productDetail(orderNo) {
// 		$.ajax({
// 			url : "${contextPath}/mng/req/product/detail",
// 			dataType : "JSON",
// 				type : "POST",
// 			data : {
// 				"orderNo" : orderNo
// 			},
// 			success : function(data) {
// 				var result = data;
// 				setData(result);
// 			},
// 			error : function(request, status, error) {
// 				alertBox3("code:" + request.status + "\n" + "error:" + error);
// 			}
// 		});

// 	}

	function setData(result){
		$("#projectAlias").text(result.projectAlias);
		$("#hostname").text(result.hostname);
		$("#vcpus").text(result.vcpus);
		$("#memGb").text(result.memGb);
		$("#diskGb").text(result.diskGb);
		$("#onDemandFlag").val(result.onDemandFlag);

		//$("#apprvDescription").text(result.rejectedApprvDescription);
	}

	//승인 버튼 누를시 체크 박스 확인
	function projectApprving(stepLevel,requestSeq,rightStepId){

		var tmpLength = $("input[name='hostNameChk']").length;
		var tmpData = new Array(tmpLength);
		for(var i=0 ; i < tmpLength; i++) {
			tmpData[i] = $("input[name='hostNameChk']")[i].value;
		}

		var tmpIpLength = $("input[name='ipChk']").length;
		var tmpIpData = new Array(tmpIpLength);
		for(var i=0 ; i < tmpIpLength; i++) {
			tmpIpData[i] = $("input[name='ipChk']")[i].value;
		}

		var tmpBackupIpLength = $("input[name='backupIpChk']").length;
		var tmpBackupIpData = new Array(tmpBackupIpLength);
		for(var i=0 ; i < tmpBackupIpLength; i++) {
			tmpBackupIpData[i] = $("input[name='backupIpChk']")[i].value;
		}

		var appValueChk = openshiftTemplateSave();
		if (appValueChk === false){
			alertBox3("어플리케이션명을 체크해주세요");
			return false;
		}
		var templateType = $("select[name='templateInfo'] > option:selected").data("templatetype");

		if(templateType != undefined && templateType != null){
			templateType = templateType.replace(/[0-9]/g, "");
			var orderAppJsonList = ${orderAppJsonList};
			if(!$("#gitRepository").val() && templateType != "APPIMGMQ"){
				if(orderAppJsonList.appJson[0].requstType === "REQTYPE_NEW"){
					alertBox3("Git Repository URL을 체크해주세요");
					return false;
				}
			}
		}

		var apprvDescription = $("#apprvDescription").val();
		var jsonData = {
				"requestSeq" : $("#allOrderNo").val()
				,"stepLevel" :stepLevel
				,"rightStepId":rightStepId
				,"apprvDescription":apprvDescription
				,"orderUserId" : "${getOrderUserId.orderUserId}"
				,"apprvUserName" : "${userName}"
				,"apprvUserId" : "${userId}"
				,"projectAlias": $("#h_projectAlias").val()
				,"managerName" : $("#h_managerName").val()
			}
		if( $("input:checkbox[name='projectIdchk']:checked").length == $("input:checkbox[name='projectIdchk']").length && tmpData.indexOf("N") == -1 && tmpIpData.indexOf("N") == -1 && tmpBackupIpData.indexOf("N") == -1 ) {
			confirmBox2("승인 처리  하시겠습니까?", checkWorkUser ,jsonData);
		}  else if( tmpData.indexOf("N") != -1) {
			alertBox3("HOSTNAME을 입력해주세요");
		} else if( tmpIpData.indexOf("N") != -1) {
			alertBox3("IP를 입력해주세요");
		} else if( tmpBackupIpData.indexOf("N") != -1) {
			alertBox3("Backup IP를 입력해주세요");
		} else if($("input:checkbox[name='projectIdchk']:checked").length==0 || $("input:checkbox[name='projectIdchk']:checked").length != $("input:checkbox[name='projectIdchk']").length) {
			alertBox3("승인대상 자원을 체크해 주세요");
		}
	}



	//승인 버튼 누를시 체크박스 후 작업자지정 확인
	function checkWorkUser(jsonData){
		var sign = "${userApprvState}";

		$.ajax({
			url : "${contextPath}/mng/req/product/checkWorkUser",
			dataType : "JSON",
			type : "POST",
			data : {
				"orderNo" : $("#allOrderNo").val()
			},
			beforeSend : function(xhr, opts) {
				setLodingFun.blocksFun();
			},
			complete : function() {
				setLodingFun.nonesFun();
			},

			success : function(data) {
				var result = data
				if(result > 0 && $("#serviceType").val() != "SERVICE99"){
					alertBox3("작업자를 지정해 주세요.");
				}else{
					ajaxProjectApprving(jsonData);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function waiting(){
		alertBox("처리중 입니다.<br>잠시만 기다려 주십시오.", waiting);
	}

	function ajaxProjectApprving(jsonObj){

		//alert(jsonObj.rightStepId);

		if(jsonObj.rightStepId != '*'){

			$.ajax({
				url : "${contextPath}/mng/req/product/stepUpdate",
				dataType : "JSON",
				type : "POST",
				data : jsonObj,
				beforeSend : function(xhr, opts) {
					setLodingFun.blocksFun();
				},
				complete : function() {
					setLodingFun.nonesFun();
				},
				success : function(data) {
					var result = data;
					if(result==1){
// 						alertBox("승인 처리가 완료 되었습니다.<br>처리 내용이 신청 담당자에게<br>메일, SMS를 통해<br>전달되었습니다.", moveViewPage);
						alertBox("승인 처리가 완료 되었습니다.<br>처리 내용이 신청 담당자에게<br>메일, SMS를 통해<br>전달되었습니다.", moveListPage);
					}else{
// 						alertBox("fail!!", moveViewPage);
						alertBox("fail!!", moveListPage);
					}
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}else if(jsonObj.rightStepId == '*'){
				alertBox("처리중 입니다.<br>잠시만 기다려 주십시오.", waiting);
				var jsonData = setJsonData();

				$.ajax({
					url : "${contextPath}/mng/req/product/insert",
					dataType : "JSON",
					type : "POST",
					data : jsonData,
					success : function(data) {
						var result = data;
						if(result=1){
// 							alertBox("승인 처리가 완료 되었습니다.<br>처리 내용이 신청 담당자에게<br>메일, SMS를 통해<br>전달되었습니다.", moveViewPage);
							alertBox("승인 처리가 완료 되었습니다.<br>처리 내용이 신청 담당자에게<br>메일, SMS를 통해<br>전달되었습니다.", moveListPage);
						}else{
// 							alertBox("fail!!", moveViewPage);
							alertBox("fail!!", moveListPage);
						}
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
		}

	}

	var rejectStepLevel = "";
	var rejectOrderNo = "";
	var rejectRightStepId = "";

	//반려 버튼 누를시
	function projectRejectedPopup(stepLevel, requestSeq, rightStepId) {
		$("#modal-dialog-reject").modal();
		rejectStepLevel = stepLevel;
		rejectOrderNo = $("#allOrderNo").val();
		rejectRightStepId = rightStepId;
	}

	function projectRejected() {
		if($("#apprvDescription").val()==""){
			$("#apprvDescription").focus();
			alertBox("자원신청 반려시 반려사유를<br>입력해 주시기 바랍니다.");
			return false;
		}
		// var jsonData = setJsonData();
		$.ajax({
			url : "${contextPath}/mng/req/product/rejectedUpdate",
			dataType : "JSON",
//			type : "POST",
			data : {
				"requestSeq" : rejectOrderNo
				,"stepLevel" : rejectStepLevel
				,"apprvDescription":$("#apprvDescription").val()
				,"orderUserId" : "${getOrderUserId.orderUserId}"
				,"apprvUserId" : "${userId}"
				,"apprvUserName" : "${userName}"
			},
			beforeSend : function(xhr, opts) {
				setLodingFun.blocksFun();
			},
			complete : function() {
				setLodingFun.nonesFun();
			},

			success : function(data) {
				var result = data;
				if(result==1){
// 					alertBox("자원신청이 반려되었습니다.", moveViewPage);
					alertBox("자원신청이 반려되었습니다.", moveListPage);
				}else{
					alertBox3("fail!!");
// 					moveViewPage();
					moveListPage();
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		})
	}

	// 목록 페이지이동
	function moveViewPage(){
		setLodingFun.blocksFun();
		location.href = "${contextPath}/mng/req/product/view?orderNo="+$("#allOrderNo").val();
	}

	// 목록 페이지이동
	function moveListPage(){
	//			location.reload();
		location.href = "${contextPath}/mng/req/product/";
	}



	function viewtr(orderProductSeq){
		//alertBox3(basketSeq);
		var vorderProductSeq = "v"+orderProductSeq;
		var corderProductSeq = "c"+orderProductSeq;
		var sorderProductSeq = "s"+orderProductSeq;

		if($("#"+corderProductSeq).val()=="0"){
			$("#"+corderProductSeq).val("1");
			$("#"+vorderProductSeq).show();
			$("#"+sorderProductSeq).removeClass('fa fa-chevron-down');
			$("#"+sorderProductSeq).addClass('fa fa-chevron-up');
		}else{
			$("#"+corderProductSeq).val("0");
			$("#"+vorderProductSeq).hide();
			$("#"+sorderProductSeq).removeClass('fa fa-chevron-up');
			$("#"+sorderProductSeq).addClass('fa fa-chevron-down');
		}

	}

	var pmParam = {
			userName : ""
			,userId : ""
			,orderProductSeq : ""
			,productCategory : ""
	}

	var vOrderProductSeq = "";
	var vProductCategory = "";

	function userAppoint(orderProductSeq,productCategory){

		pmParam = {
			userName : ""
			,userId : ""
			,orderProductSeq : ""
			,productCategory : ""
		}
		vOrderProductSeq = orderProductSeq;
		vProductCategory = productCategory;
		$("#modal-dialog3").modal();
		modalList();
	}

	function modalList(){

		var customerId="${customerId}";
		var keyword = $("#searchKeyword").val();

		$.ajax({
			url : "${contextPath}/mng/req/product/productPmList",
			dataType : "JSON",
	//	 			type : "POST",
			data : {
				"customerId" : customerId
				,"keyword" : keyword
			},
			success : function(data) {
				var getPmList = data;

				$("#popListTable > div").remove();
				$("#totalCnt").text("");

				if(getPmList!=""){
					var Html="";
					Html = "<div class='listArea maxH' id='popListTable'>";

					$.each(getPmList,function(key,val){
						Html +=			"<div class='listBg'>";
						Html +=				"<span class='name'>"+ val["userName"] +"</span>";
						Html +=				"<span class='idlabel'>(사번 : <span class='userid nanumR'>"+val["userId"]+"</span>)</span>";
						Html +=				"<a class='applybtn' onclick='updatePmUser(\""+val["userName"]+"\", \""+val["userId"]+"\", \""+vOrderProductSeq+"\",\""+vProductCategory+"\", this)'>선택</a>";
						Html +=			"</div>";
					});
					Html += "</div>";

					$("#popListTable").append(Html);
					$("#totalCnt").text("총 "+getPmList.length+" 건");

				}else{
					var Html="";
					Html = "<div class='noneList' style='display: none;'>";
					Html +=		"<span>검색된 사용자가 없습니다.</span>";
					Html += "</div>";

					$("#popListTable").append(Html);
					$("#totalCnt").text("총 0 건");
				}

			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}

	function updatePmUser(userName,userId,orderProductSeq,productCategory, e){
		$(".applybtn").removeClass("active");
		$(e).addClass("active");
		pmParam.userName = userName;
		pmParam.userId = userId;
		pmParam.orderProductSeq = orderProductSeq;
		pmParam.productCategory = productCategory;

		setWorkUserName();
	}

	function setWorkUserName(){
		if(pmParam.userName != ""){
			var orderProductSeqId = pmParam.orderProductSeq+"UserName"
		 	document.getElementById(orderProductSeqId).value= pmParam.userName;
			$("#"+orderProductSeqId).val(pmParam.userName);
			ajaxUpdatePmUser();
		}
		$("#modal-dialog3").modal("hide");
	}

	function ajaxUpdatePmUser(){
		$.ajax({
			url : "${contextPath}/mng/req/product/updateWorkUser",
			dataType : "JSON",
			type : "POST",
			data : {
				"orderProductSeq" : pmParam.orderProductSeq
				,"productCategory" :pmParam.productCategory
				,"workUserId": pmParam.userId
			},
			success : function(data) {
				var result = data;
				if(result==1){

				}else{
					alertBox3("fail!!");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + request);
			}
		});
	}


	function productDetail(productType, orderProductSeq){

		$.ajax({
			url : "${contextPath}/mng/req/product/detailOrderProduct",
			dataType : "JSON",
		//	 			type : "POST",
			data : {
				"productType" : productType,
				"orderProductSeq" : orderProductSeq
			},
			success : function(data) {
				if (productType == 'vm') vmDetail(data);
				else if (productType == 'disk') diskDetail(data);
				else if (productType == 'nas') nasDetail(data);
				else if (productType == 'ip') ipDetail(data);
				else if (productType == 'lb') lbDetail(data);
				else if (productType == 'service') serviceDetail(data);
				else if (productType == 'application') appDetail(data);
				else if (productType == 'env') envDetail(data);
				// 					else if (productType == 'bak') bakDetail(data);
				// 					else if (productType == 'mca') mcaDetail(data);
				// 					else if (productType == 'scm') scmDetail(data);
				// 					else if (productType == 'scr') scrDetail(data);






				hadleChangeDate();



			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function hadleChangeDate() {
		const dateTimeInput = document.getElementById("handleDateTime");

		if (dateTimeInput.value == "") {
			alert("데이터가 없습니다.")
		}
		console.log("current date time : ", dateTimeInput.value);
	}

	function vmDetail(data){
		var html = "";
		if(data.reqMessage==''){
			data.reqMessage = "요청내용이 없습니다."
		};
		$("#vmDetailPopup > div").remove();
		html += "<div class=\"reqDetailArea\">";

		html += "<div class='tableE'>"
		html += "<table><colgroup><col width='120px' /><col width=''*' /></colgroup><tbody>"
		html += "<tr><th class='left-t vm'>프로젝트명</th><td>"
		html += "	<div class=\"flex align-center gap10\">";
		if(data.requestName == '해지') {
			html += "		<span class=\"statusLabel_small status_out\">"+data.requestName+"</span>";
		} else {
			html += "		<span class=\"statusLabel_small status_new\">"+data.requestName+"</span>";
		}
		html += "		<h4>"+data.projectAlias+"</h4>";
		html += "	</div>";
		html += "</td></tr>"
		html += "<tr><th class='left-t'>서버명</th><td>"+data.hostnameAlias+"</td></tr>"
		html += "<tr><th class='left-t'>호스트명</th><td>"+data.hostname+"</td></tr>"
		html += "<tr><th class='left-t'>네트워크</th><td>"+data.defaultNetworkName+"</td></tr>"
		html += "<tr><th class='left-t'>OS</th><td>"+data.osProductName+"</td></tr>"
		//html += "<tr><th class='left-t'></th><td></td></tr>"
		html += "</tbody></table></div>"

		html += "	<div class=\"detail_02\">";
		html += "		<ul>";
		html += "			<li class=\"p-r-20  p-l-20\">";
		html += "				<span class=\"fontVdn tal label01\">vCPU</span>";
		html += "				<p class=\"tar m-t-5\"><em class=\"fontVdn vcpuResult\">"+addcomma(data.vcpus)+"</em><span class=\"fontVdn fc66 f14 m-l-5\">Core</span></p>";
		html += "			</li>";
		html += "			<li class=\"p-r-20 p-l-20\">";
		html += "				<span class=\"fontVdn tal label02\">MEMORY</span>";
		html += "				<p class=\"tar m-t-5\"><em class=\"fontVdn memResult\">"+addcomma(data.memGb)+"</em><span class=\"fontVdn fc66 f14 m-l-5\">GB</span></p>";
		html += "			</li>";
		html += "			<li class=\"p-r-20 p-l-20\">";
		html += "				<span class=\"fontVdn tal label03\">DISK</span>";
		html += "				<p class=\"tar m-t-5\"><em class=\"fontVdn diskResult\">"+addcomma(data.vmDiskGb)+"</em><span class=\"fontVdn fc66 f14 m-l-5\">GB</span></p>";
		html += "			</li>";
		html += "		</ul>";
		html += "	</div>";

		html += "<div class='tableE'>"
		html += "<table><colgroup><col width='120px' /><col width=''*' /></colgroup><tbody>"
		html += "<tr><th class='left-t'>서비스희망일시</th><td>"
		if (data.onDemandFlag == 'Y') {
			html += "				<em id=\"\">승인완료 후 생성</em>";
		} else {
			html += "				<em id=\"\" id='handleReDateTime'>"+data.applyDatetime+"</em>";
			html += "<input type='datetime-local' class='form-control width-100  ml10 dpin'  id='handleDateTime' />";
			html += "<button type='button' class='pbton bton_blue ml10' onclick='hadleChangeDate()')>변경</button>";
		}
		html += "</td></tr>";
		html += "<tr><th class='left-t'>요청내용</th><td>"+data.reqMessage+"</td></tr>";
		html += "</tbody></table></div>";
		html += "</div>";
		$("#vmDetailPopup").html(html);

		$("#modal-dialog-reqlist").modal();
	}

	function openPopSn(requestName,projectAlias, snapshotName, hostname,diskAlias,description,applyDatetime,onDemandFlag) {
		$("#lbpoptitle").text("스냅샷 상세");
		var html = "";
		$("#snDetailPopup > div").remove();
		html += "<div class=\"reqDetailArea\">";
		html += "	<div class=\"title tal\">";
		if(requestName == '해지') {
			requestName = "삭제";
			html += "		<span class=\"statusLabel_small status_out\">"+requestName+"</span>";
		} else {
			if(requestName == '변경'){
				requestName = "적용";
			}
			html += "		<span class=\"statusLabel_small status_new\">"+requestName+"</span>";
		}
		html += "		<h4>"+projectAlias+"</h4>";
		html += "	</div>";
		html += "	<div class=\"detail_01\">";
		html += "		<ul>";
		html += "			<li>";
		html += "				<span class=\"doubledotte\" style=\"width: 140px\">스냅샷 명</span>";
		html += "				<em id=\"\">"+snapshotName+"</em>";
		html += "			</li>";
		html += "		</ul>";
		html += "	</div>";
		html += "	<div class=\"detail_03\">";
		html += "		<ul>";
		html += "			<li>";
		html += "				<span class=\"doubledotte\">호스트명</span>";
		html += "				<em id=\"\">"+hostname+"</em>";
		html += "			</li>";
		html += "			<li>";
		html += "				<span class=\"doubledotte\">디스크명</span>";
		html += "				<em id=\"\">"+diskAlias+"</em>";
		html += "			</li>";
		if(requestName == '신규') {
			if(onDemandFlag == "Y"){
				html += '<li><span class=\"doubledotte\">생성일시</span><em id=\"\">승인완료 후 생성</em></li>';
			} else {
				html += '<li><span class=\"doubledotte\">생성일시</span><em id=\"\">'+applyDatetime+'</em></li>';
			}
			html += "			<li>";
			html += "				<span class=\"doubledotte\">설명</span>";
			html += "				<em id=\"\">"+description+"</em>";
			html += "			</li>";
		}
		html += "		</ul>";
		html += "	</div>";
		html += "</div>";
		$("#lbDetailPopup").html(html);

		$("#modal-dialog-lb").modal();
	}

	function diskDetail(data){

		var html = "";
		$("#diskDetailPopup > div").remove();
		html += "<div class=\"reqDetailArea\">";

		html += "<div class='tableE'>"
		html += "<table><colgroup><col width='120px' /><col width=''*' /></colgroup><tbody>"
		html += "<tr><th class='left-t vm'>프로젝트명</th><td>"
		html += "	<div class=\"flex gap10\">";
		if(data.requestName == '해지') {
			html += "		<span class=\"statusLabel_small status_out\">"+data.requestName+"</span>";
		} else {
			html += "		<span class=\"statusLabel_small status_new\">"+data.requestName+"</span>";
		}
		html += "		<h4>"+data.projectAlias+"</h4>";
		html += "	</div>";
		html += "</td></tr>"
		html += "<tr><th class='left-t'>서버명</th><td>"+data.hostnameAlias+"</td></tr>"
		html += "<tr><th class='left-t'>디스크명</th><td>"+data.diskName+"</td></tr>"
		html += "<tr><th class='left-t'>디스크크기</th><td>"
		html += "				<em id=\"\" class=\"fontVdn\">";
		if(data.requestName == '변경') {
			html += "				<strong class=\"fc11\">"+addcomma(data.beforeDiskGb)+ "->" +addcomma(data.diskGb)+"</strong>";
		}else{
		html += "				<strong class=\"fc11\">"+addcomma(data.beforeDiskGb)+"</strong>";
		}
		html += "				<strong class=\"fc66 f16\">GB</strong>";
		html += "				</em>";
		html += "</td></tr>"
		html += "</tbody></table></div>"


		html += "<div class='tableE'>"
		html += "<table><colgroup><col width='120px' /><col width=''*' /></colgroup><tbody>"
		html += "<tr><th class='left-t'>과금단위</th><td>"
		if (data.hourlyFlag == 'Y') {
			html += "				<em id=\"\">시간 단위</em>";
		} else {
			html += "				<em id=\"\">월 단위</em>";
		}
		html += "</td></tr>"
		html += "<tr><th class='left-t'>서비스희망일시</th><td>"
		if (data.onDemandFlag == 'Y') {
			html += "				<em id=\"\">승인완료 후 생성</em>";
		} else {
			html += "				<em id=\"\">"+data.applyDatetime+"</em>";
		}
		html += "</td></tr>"
		html += "<tr><th class='left-t'>금액</th><td>"
		html += "		<p class=\"flex gap10\">";
		html += "			<em class=\"fontVdn result\">"+addcomma(data.amount)+"</em>";
		html += "			<span>원</span>";
		html += "		</p>";
		html += "</td></tr>"
		html += "</tbody></table></div>"

		html += "</div>";
		$("#diskDetailPopup").append(html);

		$("#modal-dialog-disk").modal();
	}

	function nasDetail(data){

	    if(data.description == '') {
	        data.description = "요청내용이 없습니다.";
	    }

	    var html = "";
	    $("#nasDetailPopup > div").remove();
	    html += "<div class=\"reqDetailArea\">";

		html += "<div class='tableE'>"
		html += "<table><colgroup><col width='120px' /><col width=''*' /></colgroup><tbody>"
		html += "<tr><th class='left-t vm'>프로젝트명</th><td>"

	    if(data.requestName == '해지') {
	        html += "        <span class=\"statusLabel_small status_out mr10\">" + data.requestName + "</span>";
	    } else {
	        html += "        <span class=\"statusLabel_small status_new mr10\">" + data.requestName + "</span>";
	    }

		html += ""+data.projectAlias+"</td></tr>"
		html += "<tr><th class='left-t'>프로젝트 ID</th><td>"+data.projectAlias+"</td></tr>"
		html += "<tr><th class='left-t'>스토리지ID</th><td>"+data.nasName+"</td></tr>"
		if (data.requestName == '신규' && data.cloudType != 'openshift' || data.requestName == '변경' && data.cloudType != 'openshift') {
			html += "<tr><th class='left-t'>가상서버</th><td>"+data.nasVmList+"</td></tr>"
		}
		html += "<tr><th class='left-t'>파일경로</th><td>"+data.nasFileSystemPath+"</td></tr>"
		html += "<tr><th class='left-t'>클러스터명</th><td>"+data.cloudName+"</td></tr>"
		html += "<tr><th class='left-t'>요청유형</th><td>"+data.requestName+"</td></tr>"
		html += "<tr><th class='left-t'>요청내용</th><td>"+data.description+"</td></tr>"
		html += "</tbody></table></div>"
	    html += "    <div class=\"tac center \" style='margin-top: 20px !important;'>";
	    html += "            <p class=\"cpuArea changeCpuArea nanumR mb5 f20 center\">" + data.nasChange + "</p>";
	    html += "            <p class=\"fc11 fb\">NAS 용량<span class=\"fc66 fn\">(GB)</span></p>";
	    html += "    </div>";
		html += "</div>";

	    html += "</div>";

	    $("#nasDetailPopup").append(html);
	    $("#modal-dialog-nas").modal();
	}



	function ipDetail(data){
		var html = "";
		$("#ipDetailPopup > div").remove();
		html += "<div class=\"reqDetailArea\">";
		html += "	<div class=\"title tal\">";
		if(data.requestName == '해지') {
			html += "		<span class=\"statusLabel_small status_out\">"+data.requestName+"</span>";
		} else {
			html += "		<span class=\"statusLabel_small status_new\">"+data.requestName+"</span>";
		}
		html += "		<h4>"+data.projectAlias+"</h4>";
		html += "	</div>";
		html += "	<div class=\"detail_01\">";
		html += "		<ul>";
		html += "			<li>";
		html += "				<span class=\"doubledotte\" style=\"width: 80px\">연결할 곳</span>";
		html += "				<em id=\"\">"+data.description+"</em>";
		html += "			</li>";
		html += "		</ul>";
		html += "	</div>";
		html += "	<div class=\"detail_03\">";
		html += "		<ul>";
		html += "			<li>";
		html += "				<span class=\"doubledotte\">과금단위</span>";
		if (data.hourlyFlag == 'Y') {
			html += "				<em id=\"\">시간 단위</em>";
		} else {
			html += "				<em id=\"\">월 단위</em>";
		}
		html += "			</li>";
		html += "			<li>";
		html += "				<span class=\"doubledotte\">서비스희망일시</span>";
		if (data.onDemandFlag == 'Y') {
			html += "				<em id=\"\">승인완료 후 생성</em>";
		} else {
			html += "				<em id=\"\">"+data.applyDatetime+"</em>";
		}
		html += "			</li>";
		html += "		</ul>";
		html += "	</div>";
		html += "	<div class=\"detail_04\">";
		html += "		<span class=\"f18 fc11\">금액</span>";
		html += "		<span class=\"flr\">";
		html += "			<em class=\"fontVdn result\">"+addcomma(data.amount)+"</em>";
		html += "			<span class=\"f18 fc66\">원</span>";
		html += "		</span>";
		html += "	</div>";
		html += "</div>";
		$("#ipDetailPopup").append(html);

		$("#modal-dialog-ip").modal();
	}

	function lbDetail(data){
		$("#lbpoptitle").text("로드밸런스 상세");
		var html = "";
		$("#lbDetailPopup > div").remove();
		html += "<div class=\"reqDetailArea\">";
		html += "	<div class=\"title tal\">";
		if(data.requestName == '해지') {
			html += "		<span class=\"statusLabel_small status_out\">"+data.requestName+"</span>";
		} else {
			html += "		<span class=\"statusLabel_small status_new\">"+data.requestName+"</span>";
		}
		html += "		<h4>"+data.projectAlias+"</h4>";
		html += "	</div>";
		html += "	<div class=\"detail_01\">";
		html += "		<ul>";
		html += "			<li>";
		html += "				<span class=\"doubledotte\" style=\"width: 140px\">서비스 로드분산명</span>";
		html += "				<em id=\"\">"+data.loadbalancerName+"</em>";
		html += "			</li>";
		html += "		</ul>";
		html += "	</div>";
		html += "	<div class=\"detail_03\">";
		html += "		<ul>";
		html += "			<li>";
		html += "				<span class=\"doubledotte\">가상서버 목록</span>";
		html += "				<em id=\"\">"+data.loadbalancerVm+"</em>";
		html += "			</li>";
		html += "			<li>";
		html += "				<span class=\"doubledotte\">PORT</span>";
		html += "				<em id=\"\">"+data.port+"</em>";
		html += "			</li>";
		html += "			<li>";
		html += "				<span class=\"doubledotte\">method</span>";
		html += "				<em id=\"\">"+data.method+"</em>";
		html += "			</li>";
		html += "			<li>";
		html += "				<span class=\"doubledotte\">protocol</span>";
		html += "				<em id=\"\">"+data.protocol+"</em>";
		html += "			</li>";
		html += "		</ul>";
		html += "	</div>";
		html += "</div>";
		$("#lbDetailPopup").append(html);

		$("#modal-dialog-lb").modal();
	}

	function appDetail(data){
		appDetailModal('어플리케이션 상세', data);
	}

	function appDetailModal(popTitle, data){
		var html = "";
		$("#appDetailPopup > div").remove();

		html += "<div class=\"modal-dialog\" id=\"appDetailPopup\">";
		html += "	<div class=\"modal-content w560\">";
		html += "		<div class=\"modal-header\">";
		html += "			<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\"><span></span></button>";
		html += "			<h4 class=\"modal-title\">"+popTitle+"</h4>";
		html += "		</div>";
        html += "       <div class=\"modal-body\">";

        html += "<div class=\"reqDetailArea\">";
		html += "<div class='tableE'>"
		html += "<table><colgroup><col width='120px' /><col width=''*' /></colgroup><tbody>"
		html += "<tr><th class='left-t vm'>프로젝트명</th><td>"
		html += "				<div class=\"flex align-center gap10\">";
		if(data.requestName == '해지') {
			html += "				<span class=\"statusLabel_small status_out\">"+data.requestName+"</span>";
		} else {
			html += "				<span class=\"statusLabel_small status_new\">"+data.requestName+"</span>";
		}
		html += "					<h4>"+data.projectAlias+"</h4>";
		html += "				</div>";
		html += "</td></tr>"
		html += "<tr><th class='left-t'>서버명</th><td>"+data.productCategory+"</td></tr>"
		html += "<tr><th class='left-t'>배포명</th><td>"+data.appName+"</td></tr>"
		html += "<tr><th class='left-t'>배포버전</th><td>"+data.appVersion+"</td></tr>"
		html += "<tr><th class='left-t'>도메인 주소</th><td>"+data.domainUrl+"</td></tr>"
		html += "<tr><th class='left-t'>Context Dir</th><td>"+data.deploysDirectory+"</td></tr>"
		html += "</tbody></table></div>"

		html += "	<div class=\"detail_02\">";
		html += "		<ul>";
		html += "			<li class=\"p-r-20  p-l-20\">";
		html += "				<span class=\"fontVdn tal label01\">CPU</span>";
		html += "				<p class=\"tar m-t-5\"><em class=\"fontVdn vcpuResult\">"+addcomma(data.cpuLimit)+"</em><span class=\"fontVdn fc66 f14 m-l-5\">Core</span></p>";
		html += "			</li>";
		html += "			<li class=\"p-r-20 p-l-20\">";
		html += "				<span class=\"fontVdn tal label02\">MEMORY</span>";
		html += "				<p class=\"tar m-t-5\"><em class=\"fontVdn memResult\">"+addcomma(data.memLimit)+"</em><span class=\"fontVdn fc66 f14 m-l-5\">GB</span></p>";
		html += "			</li>";
		html += "			<li class=\"p-r-20 p-l-20\">";
		html += "				<span class=\"fontVdn tal label03\">POD</span>";
		html += "				<p class=\"tar m-t-5\"><em class=\"fontVdn diskResult\">"+addcomma(data.podCnt)+"</em><span class=\"fontVdn fc66 f14 m-l-5\">GB</span></p>";
		html += "			</li>";
		html += "		</ul>";
		html += "	</div>";

        html += "       <div class=\"modal-footer tac\">";
        html += "   		<a type=\"button\" class=\"whiteline\" data-dismiss=\"modal\" id =\"popclose\">닫기</a>";
        html += "       </div>";
        html += "   </div>";
		html += "</div>";
		html += "</div>";
		$("#appDetailPopup").append(html);

		$("#modal-dialog-app").modal();
	}

	function envDetail(data){
		envDetailModal('개발환경 상세', data);
	}

	function envDetailModal(popTitle, data){
		gridEnvUserList(data.orderProductSeq);
		var html = "";
		$("#envDetailPopup > div").remove();

		html += "<div class=\"modal-dialog\" id=\"envDetailPopup\">";
		html += "	<div class=\"modal-content w560\">";
		html += "		<div class=\"modal-header\">";
		html += "			<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\"><span></span></button>";
		html += "			<h4 class=\"modal-title\">"+popTitle+"</h4>";
		html += "		</div>";
        html += "       <div class=\"modal-body\">";

		html += "<div class='tableE'>"
		html += "<table><colgroup><col width='120px' /><col width=''*' /></colgroup><tbody>"
		html += "<tr><th class='left-t vm'>프로젝트명</th><td>"
		if(data.requestName == '해지') {
			html += "				<span class=\"statusLabel_small status_out mr10\">"+data.requestName+"</span>";
		} else {
			html += "				<span class=\"statusLabel_small status_new mr10\">"+data.requestName+"</span>";
		}
		html += ""+data.projectAlias+"</td></tr>"
		html += "<tr><th class='left-t'>서버명</th><td>"+data.productCategory+"</td></tr>"
		html += "<tr><th class='left-t'>카테고리</th><td>"+data.productCategory+"</td></tr>"
		html += "<tr><th class='left-t'>개발환경 Alias</th><td>"+data.envAlias+"</td></tr>"
		if(data.description != "" || data.description != null){
			html += "<tr><th class='left-t'>요청내용</th><td>"+data.description+"</td></tr>"
		} else {
			html += "<tr><th class='left-t'>요청내용</th><td>요청한 내용이 없습니다.</td></tr>"
		}
		html += "</tbody></table></div>"

		html += "<div id='envUserList' class='mt20'>";
		html += "</div>";

        html += "       </div>";
        html += "       <div class=\"modal-footer tac\">";
        html += "   		<a type=\"button\" class=\"whiteline\" data-dismiss=\"modal\" id =\"popclose\">닫기</a>";
        html += "       </div>";
        html += "   </div>";
		html += "</div>";
		$("#envDetailPopup").append(html);
		$("#modal-dialog-env").modal();
	}

	function gridEnvUserList(orderProductSeq){
		debugger;
		$.ajax({
			url : "${contextPath}/mbr/req/catalogue/bssEnvUserList",
			dataType : "JSON",
			type : "GET",
			data : {
				orderProductSeq : orderProductSeq
			},
			success : function(data) {
				var html = "";
				html += "<table class='tableV'>";
		        html += "	<colgroup>";
				html += " 		<col width='15%'>";
				html += " 		<col width='15%'>";
				html += " 		<col width='*'>";
				html += " 		<col width='15%'>";
				html += " 	</colgroup>";
				html += "	<thead>";
				html += "	    <tr>";
				html += "			<th>유저명</th>";
				html += "			<th>아이디</th>";
				html += "			<th>이메일</th>";
				html += "			<th>권한</th>";
				html += "		</tr>";
				html += "	</thead>";
				html += "	<tbody>";
				$.each(data, function(key, val){
					html += "		<tr>";
					html += "			<td class='tac'>"+val["envUserName"]+"</td>";
					html += "			<td class='tac'>"+val["envUserId"]+"</td>";
					html += "			<td class='tac'>"+val["envUserEmail"]+"</td>";
					html += "			<td class='tac'>"+val["codeName"]+"</td>";
					html += "		</tr>";
				});
				html += "	</tbody>";
				html += "</table>" ;
				$("#envUserList").html(html);
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	function serviceDetail(data){
		svcDetail('서비스 상세', data);
	}

	function svcDetail(popTitle, data){
		var html = "";
		$("#svcDetailPopup > div").remove();

		html += "<div class=\"modal-dialog\" id=\"svcDetailPopup\">";
		html += "	<div class=\"modal-content w560\">";
		html += "		<div class=\"modal-header\">";
		html += "			<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\"><span></span></button>";
		html += "			<h4 class=\"modal-title\">"+popTitle+"</h4>";
		html += "		</div>";
        html += "       <div class=\"modal-body\">";

		html += "<div class='tableE'>"
		html += "<table><colgroup><col width='120px' /><col width=''*' /></colgroup><tbody>"
		html += "<tr><th class='left-t vm'>프로젝트명</th><td>"
		html += "				<div class=\"flex align-center gap10\">";
		if(data.requestName == '해지') {
			html += "					<span class=\"statusLabel_small status_out\">"+data.requestName+"</span>";
		} else {
			html += "					<span class=\"statusLabel_small status_new\">"+data.requestName+"</span>";
		}
		html += "					<h4>"+data.projectAlias+"</h4>";
		html += "				</div>";
		html += "</td></tr>"
		html += "<tr><th class='left-t'>요청내용</th>"
		var description = data.description;
		description = replaceAll(description,"\n","<br/>");
		html += "<td>" +description+"</td></tr>"
		html += "<tr><th class='left-t'>서비스희망일시</th><td>"
		if (data.onDemandFlag == 'Y') {
			html += "							<em id=\"\">승인완료 후 생성</em>";
		} else {
			html += "							<em id=\"\">"+data.applyDatetime+"</em>";
		}
		html += "</td></tr>"
		html += "<tr><th class='left-t'>서비스 타입</th><td>"+data.serviceProductName+"</td></tr>"
		html += "</tbody></table></div>"

        html += "       	</div>";
        html += "       	<div class=\"modal-footer tac\">";
        html += "   			<a type=\"button\" class=\"whiteline\" data-dismiss=\"modal\" id =\"popclose\">닫기</a>";
        html += "       	</div>";
        html += "   	</div>";
		html += "</div>";
		$("#svcDetailPopup").append(html);

		$("#modal-dialog-service").modal();
	}

	function replaceAll(str,searchStr,replaceStr){
		if(str != undefined && str != null){
			str.split(searchStr).join(replaceStr);
		}else{
			str="";
		}

		return str;
	}

	function syncCloudAvail(){
		confirmBox2("가용용량을 새로고침 하시겠습니까?", openstacksync);
	}


	function openstacksync(){
		alertBox("처리중입니다.<br>잠시만 기다려 주십시오.", waiting);
		$.ajax({
			url : "${contextPath}/mng/req/product/cloudUsageProjectSync",
			dataType : "JSON",
			success : function(data) {
				alertBox("완료되었습니다.", moveListPage);
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function useVolumeDetail(projectId){
		$.ajax({
			url : "${contextPath}/mng/req/product/cloudUsageProject",
			dataType : "JSON",
 			type : "GET",
			data : {
				"projectId" : projectId
			},
			success : function(data) {

				var volumeList = data;
				var allhtml = "";
				var projecthtml = "";
				var html = "";

				$("#useVolumeTable > table").remove();
				html += "<table class='tableV'>";
		        html += "	<colgroup>";
				html += " 		<col width='8%''>";
				html += " 		<col width='*'>";
				html += " 		<col width='14%'>";
				html += " 		<col width='14%'>";
				html += " 		<col width='14%'>";
				html += " 		<col width='14%'>";
				html += " 	</colgroup>";
				html += "	<thead>";
				html += "	    <tr>";
				html += "			<th> </th>";
				html += "			<th>구분</th>";
				html += "			<th>가상서버</th>";
				html += "			<th>vCPU(Core)</th>";
				html += "			<th>MEMORY(GB)</th>";
				html += "			<th>DISK(GB)</th>";
				html += "		</tr>";
				html += "	</thead>";
				html += "	<tbody>";

				$.each(volumeList,function(key,val){

					if (val["projectId"] == 'ALL') {

						allhtml += "		<tr>";
						allhtml += "			<td rowspan='3' class='lh20'>전<br/>체</td>";
						allhtml += "			<td>클라우드 용량</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["vmTotal"])+"</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["vcpuTotal"])+"</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["memTotal"])+"</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["diskTotal"])+"</td>";
						allhtml += "		</tr>";
						allhtml += "		<tr>";
						allhtml += "			<td>클라우드 사용용량</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["vmUsed"])+"</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["vcpuUsed"])+"</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["memUsed"])+"</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["diskUsed"])+"</td>";
						allhtml += "		</tr>";
						allhtml += "		<tr>";
						allhtml += "			<td>클라우드 가용용량</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["vmAvail"])+"</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["vcpuAvail"])+"</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["memAvail"])+"</td>";
						allhtml += "			<td class='tar'>"+addcomma(val["diskAvail"])+"</td>";
						allhtml += "		</tr>";
					} else {
						projecthtml += "		<tr>";
						projecthtml += "			<td rowspan='3' class='lh20'>프<br/>로<br/>젝<br/>트</td>";
						projecthtml += "			<td>프로젝트 제한용량</td>";
						projecthtml += "			<td class='tar'>"+addcomma(val["vmTotal"])+"</td>";
						projecthtml += "			<td class='tar'>"+addcomma(val["vcpuTotal"])+"</td>";
						projecthtml += "			<td class='tar'>"+addcomma(val["memTotal"])+"</td>";
						projecthtml += "			<td class='tar'>"+addcomma(val["diskTotal"])+"</td>";
						projecthtml += "		</tr>";
						projecthtml += "		<tr>";
						projecthtml += "			<td>프로젝트 사용용량</td>";
						projecthtml += "			<td class='tar'>"+addcomma(val["vmUsed"])+"</td>";
						projecthtml += "			<td class='tar'>"+addcomma(val["vcpuUsed"])+"</td>";
						projecthtml += "			<td class='tar'>"+addcomma(val["memUsed"])+"</td>";
						projecthtml += "			<td class='tar'>"+addcomma(val["diskUsed"])+"</td>";
						projecthtml += "		</tr>";
						projecthtml += "		<tr>";
						projecthtml += "			<td class='fc-orange'>실시간 가용용량</td>";
						projecthtml += "			<td class='tar fc-orange'>"+addcomma(val["vmAvail"])+"</td>";
						projecthtml += "			<td class='tar fc-orange'>"+addcomma(val["vcpuAvail"])+"</td>";
						projecthtml += "			<td class='tar fc-orange'>"+addcomma(val["memAvail"])+"</td>";
						projecthtml += "			<td class='tar fc-orange'>"+addcomma(val["diskAvail"])+"</td>";
						projecthtml += "		</tr>";
					}

				});

				html += allhtml;
				html += projecthtml;
				html += "	</tbody> ";
				html += "</table>    " ;
				$("#useVolumeTable").append(html);

				$("#modal-dialog-useVolume").modal();
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	// 신청 버튼 클릭시 결재자 지정 팝업 Open
	function openApproveReviewModal(projectStatusFlag) {
		//01 작성중,02 처리중,03 반려,04 처리완료
		$("#h_projectStatusFlag").val(projectStatusFlag);
		$("#pop_projectAlias").text($("#projectAlias").val());
		$("#pop_description").text($("#projectDescription").val());

		$("#pop_projectAlias").text($("#projectAlias").val());
		$("#pop_description").text($("#projectDescription").val());
		$("#pop_price").text($("#price").val());
		$("#pop_dispSdate").text($("#dispSdate").val());
		$("#pop_dispEdate").text($("#dispEdate").val());
		$("#pop_customerName").text($("#customerName").val());
		$("#pop_deptName").text($("#deptName").val());
		$("#selectApprv").val("Y");

		var tmpLength = $("input[name='hostNameChk']").length;
		var tmpData = new Array(tmpLength);
		for(var i=0 ; i < tmpLength; i++) {
			tmpData[i] = $("input[name='hostNameChk']")[i].value;
		}

		var tmpIpLength = $("input[name='ipChk']").length;
		var tmpIpData = new Array(tmpIpLength);
		for(var i=0 ; i < tmpIpLength; i++) {
			tmpIpData[i] = $("input[name='ipChk']")[i].value;
		}

		var tmpBackupIpLength = $("input[name='backupIpChk']").length;
		var tmpBackupIpData = new Array(tmpBackupIpLength);
		for(var i=0 ; i < tmpBackupIpLength; i++) {
			tmpBackupIpData[i] = $("input[name='backupIpChk']")[i].value;
		}

		// OS 체크

		// 어플리케이션 체크
		var appValueChk = openshiftTemplateSave();
		if (appValueChk === false){
			alertBox3("어플리케이션명을 체크해주세요");
			return false;
		}
		var templateType = $("select[name='templateInfo'] > option:selected").data("templatetype");

		if(templateType != undefined && templateType != null){
			templateType = templateType.replace(/[0-9]/g, "");

			var orderAppJsonList = ${orderAppJsonList};

			if(!$("#gitRepository").val() && templateType != "APPIMGMQ"){
				if((orderAppJsonList.appJson[0].requstType === "REQTYPE_NEW")){
					alertBox3("Git Repository URL을 체크해주세요");
					return false;
				}
			}
		}

		var apprvDescription = $("#apprvDescription").val();

		if( $("input:checkbox[name='projectIdchk']:checked").length == $("input:checkbox[name='projectIdchk']").length && tmpData.indexOf("N") == -1 && tmpIpData.indexOf("N") == -1 && tmpBackupIpData.indexOf("N") == -1 ) {
			$.ajax({
				url : "${contextPath}/mng/req/product/checkWorkUser",
				dataType : "JSON",
				type : "POST",
				data : {
					"orderNo" : $("#allOrderNo").val()
				},
				success : function(data) {
					var result = data
					if(result > 0 && $("#serviceType").val() != "SERVICE99"){
						alertBox3("작업자를 지정해 주세요.");
						return false;
					}else{
						if(projectStatusFlag == 1) {
							projectInsert();
						} else {
							checkQuota();
						}
					}
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		} else {
			if( tmpData.indexOf("N") != -1) {
				alertBox3("HOSTNAME을 입력해주세요");
				return false;
			} else if( tmpIpData.indexOf("N") != -1) {
				alertBox3("IP를 입력해주세요");
				return false;
			} else if( tmpBackupIpData.indexOf("N") != -1) {
				alertBox3("Backup IP를 입력해주세요");
				return false;
			}
			if(projectStatusFlag == 1) {
				projectInsert();
			} else {
				checkQuota();
			}
		}

	}

	function checkQuota(){
		var userId = $( "#h_userId").val();
		if( userId != 18109816){
			approveModalOpen();
			return;
		}

		alertBox("쿼터 사용량 확인중입니다.", waiting);
		$.ajax({
			url : "${contextPath}/mng/req/product/checkCloudUsage",
			dataType : "JSON",
 			type : "GET",
			data : {
				"orderNo" : $("#allOrderNo").val()
			},
			success : function(data) {
				if(data.res == "200"){
					alertBox("쿼터확인이 완료되었습니다.",approveModalOpen);
				}
				if(data.res == "406"){
					alertBox3("cpu쿼터를 초과하였습니다.");
				}
				if(data.res == "407"){
					alertBox3("memory쿼터를 초과하였습니다.");
				}
				if(data.res == "408"){
					alertBox3("Disk쿼터를 초과하였습니다.");
				}
				if(data.res == "409"){
					alertBox3("가상서버 수량을 초과하였습니다.");
				}
				if(data.res == "410"){
					alertBox("볼륨최대 수량을 초과하였습니다.");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}


	function closeApprovModal(){
		$("#modal-approve-review-dialog").modal("hide");
	}

	function nApprovCmForm(){
		confirmBox4("결재자를 지정하지않고 승인하시겠습니까?",nApprovSelect,closeApprovModal);
	}

	function nApprovSelect(){
		$("#selectApprv").val("Y");
		projectInsert();
	}

	function approvSelect(){
		$("#selectApprv").val("N");
		$("#modal-approve-review-dialog").modal();
	}

	function approveModalOpen(){

		if($("#apprvPass").val() == "Y"){
			confirmBox4("결재자를 지정하시겠습니까?",approvSelect,nApprovCmForm);
		} else {
			approvSelect();
		}
	}

	function waiting(){
		alertBox("쿼터 사용량 확인중입니다.", waiting);
	}

	// 결재지정 담당자 검색
	function openReviewModal(e){
		currentApprovalLine = e;
		var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
		if( approvalList[tmpCurrentApprovalStep-1] != undefined) {
			confirmBox("재신청할경우 현재 상위결재자값이 초기화 됩니다.", clearUpperApproval );

		} else {
			$("#user-modal-review-dialog").modal();
			gridPopList();
		}
	}

	// 승인부서 결재지정 팝업 - 담당자조회 검색
	function gridPopList(){
		$.ajax({
			url : "${contextPath}/mbr/operation/approveUser/addProjectApproveList",
			dataType : "JSON",
			data : {
				"searchKind": $("#reviewSearchKind option:selected").val()
				, "keyword"	: $("#reviewUserId").val()
				, "cloudId" : "${projectInfo.cloudId}"
			},
			success : function(req) {
				if(req.data.length == 0){
					$("#popListReviewTable").hide();
					$("#popListReviewTable2").show();
				}else{
					$("#popListReviewTable").empty();

					$.each(req.data, function(key,val){
						$("#popListReviewTable").append(
							'<tr>'
							    +'<td class="tac">'+val.upDeptName+'/'+val.deptName+'</td>'
								+'<td class="tac">'+val.userId+'</td>'
								+'<td class="tac">'+val.userLevel+'</span>'
								+'<td class="tac">'+val.userName+'</span>'
								+'<td class="tac">'+val.userConditionText+'</td>'
								+'<td class="tac"><input type="button"  value="&#xf00c"  class="popCheckbtn"  onclick="updateReview(this, \''+val.userId+'\', \''+val.userName+'\', \''+val.deptName+'\',  \''+val.userLevel+'\',  \''+val.userLevelCode+'\');" initModal();></td>'
							+'</tr>');

					});
					$("#popListReviewTable").show();
					$("#popListReviewTable2").hide();
				}
				totalCnt = req.data.length;
				$("#totalReviewCnt").text("총 "+totalCnt+" 건");
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

	function clearUpperApproval() {
		var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
		for(var i = tmpCurrentApprovalStep-1 ; i < 4; i++) {
			approvalList.splice(i, 1);

			$("#approvalLine"+(i+1)+"_userId").text("사번");
			$("#approvalLine"+(i+1)+"_userLevel").text("직급");
			$("#approvalLine"+(i+1)+"_userName").text("이름");

			$("#approvalLine"+(i+1)).attr('disabled', true);
		}

		//초기화 하더라도 차장급 이상이면 재활성화되게
		if( ${userLevelCode} < 5 ) {
			$("#approvalLine2").attr('disabled', false);
		}

		$("#user-modal-review-dialog").modal();
		gridPopList();
	}

	//요청부서 검토자/승인자 지정 - 요청부서(검토) 검토자지정
	function updateReview(e, userId, userName, deptName, userLevel, userLevelCode) {
		var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
		if( tmpCurrentApprovalStep > 1 && approvalList[tmpCurrentApprovalStep-2] != undefined) {
			if( approvalList[tmpCurrentApprovalStep-2].userLevelCode < userLevelCode) {
				alertBox("이전단계보다 같거나 높은 직급의 담당자를 선택하세요");
				return false;
			}
		}
		/* if($("#hidden_login_user_id").val() ==userId) {
			alertBox("신청자는 본인을<br>결재자로 지정할수 없습니다.");
			return false;
		} */

		$("#popListReviewTable > tr").find("input").removeClass("active");
		$(e).toggleClass("active");
		//alert(tmpCurrentApprovalStep);
		var tmpValue = { "userId" : userId, "deptName" : deptName, "userName" : userName, "userLevel" : userLevel, "userLevelCode" : userLevelCode }
		//alert( JSON.stringify(tmpValue) );


		$("#"+currentApprovalLine.id+"_userId").text(userId);
		$("#"+currentApprovalLine.id+"_userLevel").text(userLevel);
		$("#"+currentApprovalLine.id+"_userName").text(userName);

		approvalList[tmpCurrentApprovalStep-1] = tmpValue;
		$("#hiddenUserIdReview").val(userId);
		$("#hiddenDeptNameReview").val(deptName);
		$("#hiddenUserNameReview").val(userName);

		// 다음 단계 버튼 활성화
		$("#approvalLine"+(parseInt(tmpCurrentApprovalStep)+1) ).attr('disabled', false);

	}

	// 결재라인 초기화
	function initApprovalLine() {
		var tmpUserLevelCode = 100;
		if( ${userLevelCode} == null || ${userLevelCode} == '' ) {
			tmpUserLevelCode == 100;
		} else {
			tmpUserLevelCode == ${userLevelCode};
		}

		// 직급에 따른 버튼활성화 - 3직급(차장) == 4
		$("#approvalLine1").attr('disabled', false);
		if( ${userLevelCode} < 5 ) {
			$("#approvalLine2").attr('disabled', false);
// 			$("#approvalLine2").removeAttr('disabled');

		}
	}

	function checkApproval() {
		if( approvalList[3] == undefined || approvalList[3] == null || approvalList[3] == '' ) {
			alertBox3("결재자를 지정해 주세요");
			return false;
		}

		$("#pop_projectAlias").text($("#projectAlias").val());
		$("#pop_description").text($("#projectDescription").val());
		$("#pop_price").text($("#price").val());
		$("#pop_dispSdate").text($("#dispSdate").val());
		$("#pop_dispEdate").text($("#dispEdate").val());
		$("#pop_customerName").text($("#customerName").val());
		$("#pop_deptName").text($("#deptName").val());

		projectInsert();
	}

	//데이터 세팅
	function setJsonData(){

		setTemplateValue();

		$("select.read-only").prop("disabled", false);
		$("input.parameterClass").prop("disabled", false);

		if( approvalList[0] == undefined || approvalList[0] == null) {
			var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
			approvalList[0] = tmp;
		}

		var regex = /[^0-9]/g;
		var posCnt = 0;
		var cpuLimit = 0;
		var memLimit = 0;

		var orderAppJsonList = ${orderAppJsonList};

		if (orderAppJsonList.appJson != null && orderAppJsonList.appJson != ""){

			if($("#number_of_instances").val() != undefined){
				posCnt 	 = 	$("#number_of_instances").val().replace(regex, "");
			}
			if($("#cpu_limit").val() != undefined){
				cpuLimit = 	$("#cpu_limit").val().replace(regex, "");
			}
			if($("#memory_limit").val() != undefined){
				memLimit =  $("#memory_limit").val().replace(regex, "");
			}
		}

		var jsonData = {

				"reqProjectSeq": $("#allOrderNo").val()
				, "regUserId" : '${userId}'
				, "approvalStepList" : approvalList
				, "requestSeq": $("#allOrderNo").val()
				, "orderUserId": $("#h_userId").val()
				, "orderUserName": $("#h_userName").val()
				, "apprvPass" : $("#apprvPass").val()
				, "selectApprv" : $("#selectApprv").val()
				, "bssOrderProductVmUpdateList" : bssOrderProductVmUpdateList
				, "bssOrderProductNasUpdateList" : bssOrderProductNasUpdateList
				, "appName": $("#appName").val()
				, "label" : $("#labels").val()
				, "templateProductSeq" : $("#productSeq").val()
				, "templateCatalogSeq" : $("#productCategorySeq").val()
				, "gitRepository": $( "#gitRepository").val()
				, "params" : $("#params").val()
				, "templateName" : $("#templateName").val()
				, "templateNameSpace" : $("#templateNameSpace").val()
//					, "podCnt" : $("#number_of_instances").val()
//					, "cpuLimit" : $("#cpu_limit").val()
//					, "memLimit" : $("#memory_limit").val()
				, "podCnt" :   posCnt
				, "cpuLimit" : cpuLimit
				, "memLimit" : memLimit
				, "osProductSeq" : $("#osProductSeq").val()
				, "onDemandFlag" : $("#onDemandFlag").val()
				,"apprvUserId" : $("#h_userId").val()
				,"apprvUserName" : $("#h_userName").val()


			};
		return jsonData;
	}

	// 승인부서 결재라인 업데이트
	function projectInsert() {

		setBssOrderProductVmUpdateList();
		setBssOrderProductNasUpdateList();

		var jsonData = setJsonData();

		$.ajax({
			url : "${wasPath}/mng/req/product/updateApprovalLine",
			dataType : "JSON",
			type : "POST",
			data : jsonData,

			beforeSend : function(xhr, opts) {
				setLodingFun.blocksFun();
			},
			complete : function() {
				setLodingFun.nonesFun();
			},

			success : function(data) {

				var result = data;
				var res = data.res;
				var programSeq = data.reqProjectSeq;
				var apprv = data.apprv;
				if(res==1){
					if(apprv == "pass"){
						var apprvDescription = $("#apprvDescription").val();
						var jsonData = {
							"requestSeq" : $("#allOrderNo").val()
							,"stepLevel" :"8"
							,"rightStepId":"*"
							,"apprvDescription":apprvDescription
							,"orderUserId" : "${getOrderUserId.orderUserId}"
							,"apprvUserName" : "${userName}"
							,"apprvUserId" : "${userId}"
							,"projectAlias": $("#h_projectAlias").val()
							,"managerName" : $("#h_managerName").val()
							,"apprvPass" : $("#apprvPass").val()
							,"selectApprv" : $("#selectApprv").val()
						}
						ajaxProjectApprving(jsonData);
					} else {
						$("#programSeq").val(programSeq);
						alertBox("저장하였습니다.", moveListPage);
					}
				}else if(res==2){
					alertBox3("프로젝트 클라우드존을 추가 해주세요.");
				}else {
					alertBox3("fail!");
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

	function getOsList(i){
	 	$("#osProductSeq"+i).html("");
 		var cloudId = $("#azName"+i).children('option:selected').data("cloud");
 		var cloudType = $("#azName"+i+" > option:selected").data("type");

 		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/osListMngReq",
			dataType : "JSON",
 			type : "GET",
			data : {
				"vmImageType" : $("#h_vmImageType"+i).val()
				,"cloudId" : cloudId
				,"cloudType" : cloudType
			},
			success : function(req) {
				var html = "<option value=''>OS 선택</option>";
				$.each(req,function(k,v){

					html += "<option value='"+v['productSeq']+"'data-name='"+v['productName']+"'>"+v['productName']+"</option>";

				})
				$("#osProductSeq"+i).html(html);
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

 	function getNetworkList(j){
 		$("#divNetwork"+j).html("");
		$.ajax({
			url : "${wasPath}/mbr/oss/zone/list",
			dataType : "JSON",
 			type : "GET",
			data : {
				"zoneName" : $("#azName"+j+" > option:selected").val()
				,"cloudId" : $("#azName"+j+" > option:selected").data("cloud")
				,"cloudType" : $("#azName"+j+" > option:selected").data("type")
			},
			success : function(req) {
				var vHtml = "<option value='netId'>네트워크 선택</option>";


				for(var i=0; i<req.length; i++){
					vHtml += "<option netalias='"+req[i].networkAlias+"' netname='"+req[i].networkName+"' value='"+req[i].networkId+"' volume='"+req[i].volumeType+"'>"+(req[i].networkAlias==""?req[i].networkName:req[i].networkAlias)+"</option>";
				}
				$("#divNetwork"+j).html(vHtml);

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

 	function getNetworkNasList(j){
 		$("#divNetworkNas"+j).html("");
		$.ajax({
			url : "${wasPath}/mbr/oss/zone/list",
			dataType : "JSON",
 			type : "GET",
			data : {
				"zoneName" : $("#azName"+j+" > option:selected").val()
				,"cloudId" : $("#azName"+j+" > option:selected").data("cloud")
				,"cloudType" : $("#azName"+j+" > option:selected").data("type")
			},
			success : function(req) {
				var vHtml = "<option value='netId'>네트워크 선택</option>";


				for(var i=0; i<req.length; i++){
					vHtml += "<option netalias='"+req[i].networkAlias+"' netname='"+req[i].networkName+"' value='"+req[i].networkId+"' volume='"+req[i].volumeType+"'>"+(req[i].networkAlias==""?req[i].networkName:req[i].networkAlias)+"</option>";
				}
				$("#divNetworkNas"+j).html(vHtml);
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

 	function selectAz(i) {
			getOsList(i);
			getNetworkList(i);

			$("#cloudName"+i+"").val($("#azName"+i+" > option:selected").val());
	}

    function setBssOrderProductVmUpdateList() {

 		for(i=0; i< ${getReqlistvo.size()}; i++){
			var bssOrderProductVm = {

				"orderProductSeq" : $("#h_orderProductSeq"+i).val(),
				"cloudId" : $("#azName"+i).children('option:selected').data("cloud"),
				"azName" : $("#azName"+i+" > option:selected").val(),
				"osProductSeq" : $("#osProductSeq"+i).val(),
				"vmProductSeq" : $("#h_vmProductSeq"+i).val(),
				"vcpus" : $("#h_vcpus"+i).val(),
				"memGb" : $("#h_memGb"+i).val(),
				"falvorId" : $("#h_falvorId").val(),
				"defaultNetworkId" : $("#divNetwork"+i+" option:selected").attr("value"),
				 "defaultNetworkName" : $("#divNetwork"+i+" option:selected").attr("netname"),
				"defaultNetworkAlias" : $("#divNetwork"+i+" option:selected").attr("netalias"),
				"volumeType" : $("#divNetwork"+i+" option:selected").attr("volume"),
				"requestType" : $("#h_requestType"+i).val(),
				"projectBoxId" : $("#h_projectBoxId"+i).val(),
				"instanceType" : $("#h_instanceType"+i).val()

			 }
			bssOrderProductVmUpdateList[i] = bssOrderProductVm;

		}
	}

    function setBssOrderProductNasUpdateList() {

 		for(i=0; i< ${getBasketNaslistvo.size()}; i++){
			var bssOrderProductNas = {

				"orderProductSeq" : $("#h_nasOrderProductSeq"+i).val(),
				"cloudId" : $("#azName"+i).children('option:selected').data("cloud"),
				"azName" : $("#azName"+i+" > option:selected").val(),
				"osProductSeq" : $("#osProductSeq"+i).val(),
				"defaultNetworkId" : $("#divNetworkNas"+i+" option:selected").attr("value"),
				"defaultNetworkName" : $("#divNetworkNas"+i+" option:selected").attr("netname"),
				"defaultNetworkAlias" : $("#divNetworkNas"+i+" option:selected").attr("netalias"),
				"requestType" : $("#h_nasRequestType"+i).val(),
				"projectBoxId" : $("#h_nasProjectBoxId"+i).val()

			 }
			bssOrderProductNasUpdateList[i] = bssOrderProductNas;

		}
	}

	function retryProvisioning(){
		confirmBox2("재시도 하시겠습니까?", changeProvisioningStatus);
	}

	function changeProvisioningStatus(){
		var OrderNo = $("#retryOrderno").val();
		$.ajax({
			url : "${wasPath}/mng/req/product/changeProvisioning",
			dataType : "JSON",
			type : "POST",
			data : {"orderProductSeq" : OrderNo},
			beforeSend : function(xhr, opts) {
				setLodingFun.blocksFun();
			},
			complete : function() {
				setLodingFun.nonesFun();
			},

			success : function(data) {
// 				alertBox("처리 되었습니다.", moveViewPage);
				alertBox("처리 되었습니다.", moveListPage);
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

	function endProvisioning(OrderNo){
		confirmBox2("작업종료 하시겠습니까?", endProvisioningStatus);
	}

	function endProvisioningStatus(){
		var OrderNo = $("#retryOrderno").val();


		var endDescription = $("#endDescription").val();

		$.ajax({
			url : "${wasPath}/mng/req/product/endProvisioning",
			dataType : "JSON",
			type : "POST",
			data : {

					"orderProductSeq" : OrderNo,
					"endDescription" : endDescription

			       },
			success : function(data) {
// 				alertBox("처리 되었습니다.", moveViewPage);
				alertBox("처리 되었습니다.", moveListPage);
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

	function alertFailMessage(Message,orderSeq){
		$("#retryMessage").html(Message);
		$("#retryOrderno").val(orderSeq);
		$("#retryModal").modal();
	}


	function alertEndMessage(Message){
		$("#endMessage").html(Message);
		$("#endModal").modal();
	}

	// select box Data hidden 변수에 설정
	function setTemplateValue(){

		var productSeq = ($("#templateInfo > option:selected").data("seq"));
		var productCategory = $("#templateInfo > option:selected").data("category");
		var productCategorySeq = $("#templateInfo > option:selected").data("categoryseq");

		var templateName = $("select[name='templateInfo'] > option:selected").data("templatename");
		var templateNameSpace = $("select[name='templateInfo'] > option:selected").data("templatenamespace");
		var templateType = $("select[name='templateInfo'] > option:selected").data("templatetype");
		var osProductSeq = $("select[name='templateInfo'] > option:selected").data("osproductseq");

		$("#productSeq").val(productSeq);
		$("#productCategory").val(productCategory);
		$("#productCategorySeq").val(productCategorySeq);
		$("#templateName").val(templateName);
		$("#templateNameSpace").val(templateNameSpace);
		$("#templateType").val(templateType);
		$("#osProductSeq").val(osProductSeq);

	}

	// 서버대역 (클라우드) 선택, 타입, ID - 템플릿 선택에 따른 입력 폼 바꾸기
	function selectTemplate(argCnt){

		var cloudId = $("#appCloudId" + argCnt).val();
		var templateName = $("select[name='templateInfo'] > option:selected").data("templatename");
		var templateNameSpace = $("select[name='templateInfo'] > option:selected").data("templatenamespace");
		var reqType =  {requestType : "REQTYPE_NEW"};

		var templateType = $("select[name='templateInfo'] > option:selected").data("templatetype");
		var osProductSeq = $("select[name='templateInfo'] > option:selected").data("osproductseq");

		$("#templateName"+argCnt).val(templateName);
		$("#templateNameSpace"+argCnt).val(templateNameSpace);
		$("#templateType"+argCnt).val(templateType);
		$("#osProductSeq"+argCnt).val(osProductSeq);

		$("#templateName").val(templateName);
		$("#templateNameSpace").val(templateNameSpace);
		$("#templateType").val(templateType);
		$("#osProductSeq").val(osProductSeq);

		setTemplateValue();

		$.ajax({
			url : "${contextPath}/mng/req/product/selectTemplate",
			dataType : "JSON",
			data : {
				"cloudId" : cloudId,
				"templateName" : templateName,
				"templateNameSpace" : templateNameSpace
			},
			success : function(data) {
				var parametersList = data.parametersList;

				if(JSON.parse(parametersList).jsonParam == null){
					alertBox("Oepnshift 템플릿에 등록되지 않았습니다.");
					return;
				}
				var paramJsonData = JSON.parse(parametersList).jsonParam.parameters;

				$("#inputInfo").empty();
				$("#moreInfo").empty();
				$("#inputInfoPop").empty();

				for(var cnt=0; cnt < paramJsonData.length; cnt++){
					containerItemGrid(paramJsonData[cnt], reqType);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	// opnshift provisioning Template Param 데이터
	function openshiftTemplateSave(){

		if($("#appNameChkFlag").val() === "Y" && $("#appNameChk").val() === "N"){
			return false;
		}

		var grp = $("input.parameterClass").length;
		var parameterValue = "";
		//배열 생성
		var grparr = new Array(grp);
		//배열에 값 주입
		for(var i=0; i<grp; i++){
			var paramClassValue = $("input.parameterClass").eq(i).val();

			if($("input.parameterClass").eq(i).data("expression") == "expression"){
				var exp = RegExp($("input.parameterClass").eq(i).data("from"));
				/*if(!exp.test(v)){
					alertBox($("input.parameterClass").eq(i).data("key") + "필드의 값이 잘못되었습니다.");
					return false;
				} */
				paramClassValue += new RandExp(exp).gen();
			}

			if($("input.parameterClass").eq(i).data("key") === "APPLICATION_NAME"){
				paramClassValue = paramClassValue.toLowerCase();
			}else if($("input.parameterClass").eq(i).data("key") === "BROKER_XML" || $("input.parameterClass").eq(i).data("key") === "LOGGING_PROPERTIES"){
				if(paramClassValue != 'Y') continue;
			}
			parameterValue += $("input.parameterClass").eq(i).data("key")+"=" + paramClassValue;

			if(i+1 != grp){
				parameterValue += "&";
			}
		}
		$("#params").val(parameterValue);
	}


	function disableContainerInput(argOrderAppData){

		if(argOrderAppData.requestType != 'REQTYPE_NEW' || $("#userApprvState").val() != "APPRV_UNASSIGNED"){
			$(".parameterClass").addClass("read-only");
			$("select#templateInfo").addClass("read-only");
			$(".read-only").attr("readonly", true);
			$("select.read-only").prop("disabled", true);
			$("#saveBtn").prop("disabled", true);
		}else{
			$("#appNameChkFlag").val("Y"); // 어플리케이션 생성시 AppName 체크 여부
		}
	}

	function containerItemGrid(argTemplateParamList, argOrderAppData){

		$("#appProjectId").val(argOrderAppData.projectId);

		switch(argTemplateParamList.name){
			//Git Repository URL
			case "SOURCE_REPOSITORY_URL":
				if((argOrderAppData.requestType != 'REQTYPE_NEW') || ($("#userApprvState").val() != "APPRV_UNASSIGNED")){
					$("#gitRepository").val(argOrderAppData.gitRepository);
				}
				else{
					$("#gitRepository").val(argTemplateParamList.value);
				}
				$("#gitRepository").attr("data-expression", argTemplateParamList.generate);
				$("#gitRepository").attr("data-from", argTemplateParamList.from);
				$("#gitRepository").attr("data-key", argTemplateParamList.name);
				break;

			//Application Name
			case "APPLICATION_NAME":
				if(argOrderAppData.requestType != 'REQTYPE_NEW' || $("#userApprvState").val() != "APPRV_UNASSIGNED"){
					$("#appName").val(argOrderAppData.appName);
				}else{
					$("#appName").attr("placeholder", argTemplateParamList.value);
				}
				$("#appName").attr("data-expression", argTemplateParamList.generate);
				$("#appName").attr("data-from", argTemplateParamList.from);
				$("#appName").attr("data-key", argTemplateParamList.name);
				break;

			case "BROKER_XML":
			case "LOGGING_PROPERTIES":
				if (argTemplateParamList.name === "BROKER_XML"){
					$("#h_xml").val(argTemplateParamList.value);
				}
				else if (argTemplateParamList.name === "LOGGING_PROPERTIES"){
					$("#h_properties").val(argTemplateParamList.value);
				}
				break;

			default:
				var cloneTemp = $('#parameter_clone_temp').clone(); 		//복제품 복제
				var cloneTemp_html = cloneTemp.html(); 						//복제품 html
				var cloneTempPop = $('#parameter_clone_temp_pop').clone(); 	//신청 확인 팝업 복제품 복제
				var cloneTempHtmlPop= cloneTempPop.html(); 					//신청 확인 팝업 복제품 html

				cloneTemp_html = cloneTemp_html.replaceAll("#paramKey#", argTemplateParamList.name);
				cloneTemp_html = cloneTemp_html.replaceAll("#paramFrom#", argTemplateParamList.from);
				cloneTemp_html = cloneTemp_html.replaceAll("#paramGenerate#", argTemplateParamList.generate);

				cloneTemp_html = cloneTemp_html.replaceAll("#parameterClass#", "parameterClass");
				cloneTemp_html = cloneTemp_html.replaceAll("#paramName#", argTemplateParamList.name.toLowerCase());
				cloneTemp_html = cloneTemp_html.replaceAll("#paramId#", argTemplateParamList.name.toLowerCase());

				cloneTempHtmlPop = cloneTempHtmlPop.replaceAll("#paramKeyPop#", argTemplateParamList.name);
				cloneTempHtmlPop = cloneTempHtmlPop.replaceAll("#paramFromPop#", argTemplateParamList.from);
				cloneTempHtmlPop = cloneTempHtmlPop.replaceAll("#paramGeneratePop#", argTemplateParamList.generate);
				cloneTempHtmlPop = cloneTempHtmlPop.replaceAll("#parameterClassPop#", "parameterClass");

				cloneTempHtmlPop = cloneTempHtmlPop.replaceAll("#paramNamePop#", argTemplateParamList.name.toLowerCase());
				cloneTempHtmlPop = cloneTempHtmlPop.replaceAll("#paramIdPop#", argTemplateParamList.name.toLowerCase());

				if( argTemplateParamList.value){
					cloneTemp_html = cloneTemp_html.replaceAll("#paramValue#", argTemplateParamList.value);
					cloneTempHtmlPop = cloneTempHtmlPop.replaceAll("#paramValuePop#", argTemplateParamList.value);
				}else{
					cloneTemp_html = cloneTemp_html.replaceAll("#paramValue#", "");
					cloneTempHtmlPop = cloneTempHtmlPop.replaceAll("#paramValuePop#", "");
				}

				if(argTemplateParamList.required == true){
					$("#inputInfo").append(cloneTemp_html);
					$("#inputInfoPop").append(cloneTempHtmlPop);

				}else{
					$("#moreInfo").append(cloneTemp_html);
					$("#inputInfoPop").append(cloneTempHtmlPop);
				}
			break;
		}
	}

	function paramsReloader(argParams){

		if(typeof argParams == 'undefined' || argParams == null){
			return ;
		}

		var params = argParams.split('&');

		for (var pcnt =0; pcnt < params.length; pcnt++){
			var parseArr = params[pcnt].split('=');
			$(".parameterClass").each(function(){
				if($(this).data('key') === parseArr[0]){
					$(this).val(parseArr[1]);
				}
			});
		}
	}

	// 컨테이너 상세 정보 출력
	function openShiftLoader() {

		var parametersList = ${parametersList};
		var orderAppJsonList = ${orderAppJsonList}; 			// Type
		var userApprvState = "${userApprvState}";

		if (parametersList.jsonParam != null && parametersList.jsonParam != ""){
			// parametersList.jsonParam 0, 1, 2, 3, 4, 5, 6, 7, 8 담길 수 있음. 주문건당 숫자 증가
			for (var tempCnt = 0; tempCnt < parametersList.jsonParam.length; tempCnt++){

				var orderAppData = orderAppJsonList.appJson[tempCnt];
				parametersList.jsonParam[tempCnt].forEach(function(templateParamList){

					containerItemGrid(templateParamList, orderAppData);
					disableContainerInput(orderAppData);
				}); //end forEach templateParamList
				var str = $("#labels").val();
				str = str.substring(0, str.indexOf('=')+1) + $("#appName").val();
				$("#labels").val(str);
			} // end for arametersList.jsonParam

			if((orderAppJsonList.appJson[0].requestType != "REQTYPE_NEW") || ($("#userApprvState").val() != "APPRV_UNASSIGNED")){

				paramsReloader(orderAppJsonList.appJson[0].params);
			}
		}
	}

	function saveAppName() {
		$("#appNameChk").val("Y");
		alertBox3("저장되었습니다.");

	}

	// 어플리케이션 명 체크
	function appNameChk(){
		if($("#appName").val()==""){
			alertBox3("어플리케이션명을 입력하세요");
			return;
		}

		var check_text = /^[a-z]([-a-z0-9]*[a-z0-9])*$/;

		if(!check_text.test( $("#appName").val())){
			alertBox3("어플리케이션명은 영문[소문자]와 '-', '_'를 제외한 이름이 들어갈 수 없습니다");
			$("#appName").val($("#appName").val().toLowerCase());
			return;
		}

		//어플리케이션명 특수문자 체크 끝
		$.ajax({
			url : "${contextPath}/mng/req/product/appNameChk",
			dataType : "JSON",
			type : "POST",
			data : {
				"appName" : $("#appName").val(),
				"projectId" : $("#appProjectId").val()
			},
			success : function(data) {

				var chkVal = data;
				if(chkVal==0){
					confirmBox("사용가능한 어플리케이션명 입니다.<br>프로젝트명을 사용하시겠습니까?", saveAppName);

					var str = $("#labels").val();
					str = str.substring(0, str.indexOf('=')+1) + $("#appName").val();
					$("#labels").val(str);

					$("input[name='appName']").attr("readonly", true);
					$("input[name='labels']").attr("readonly", true);
				}else{
					alertBox3("사용할 수 없는 어플리케이션 <br>영문명 입니다.");
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	// 개발환경명 중복체크
	function envNameChk(){
		$.ajax({
// 			url : "${contextPath}/mng/req/product/envGrpUrlChk",
			url : "${contextPath}/mng/req/product/envNameChk",
			data : {
				"envName" : $("#envName").val()
			},
			success : function(data) {
				var chkVal = data;
				if(chkVal==0){
					confirmBox("사용가능한 개발환경명 입니다 저장 하시겠습니까?", envNameInsert);
				}else{
					alertBox3("사용할 수 없는 URL 입니다.");
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	function envNameInsert(){
		$.ajax({
			url : "${contextPath}/mng/req/product/mngEnvNameInsert",
			dataType : "JSON",
			type : "POST",
			data : {
				"envName" : $("#envName").val() ,
// 				"envGroupUrl" : $("#envGrpUrl").val() ,
				"orderNo" : $("#allOrderNo").val()
			},
			success : function(data) {
				alertBox3("등록되었습니다.");
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	// 개발환경 그룹 명칭 중복체크
	function envGroupNameChk(){
		$.ajax({
			url : "${contextPath}/mng/req/product/envGroupNameChk",
			data : {
				"envGroupName" : $("#envGroupName").val()
			},
			success : function(data) {
				var chkVal = data;
				if(chkVal==0){
					confirmBox2("사용가능한 그룹명 입니다 저장 하시겠습니까?", envGroupNameInsert);
				}else{
					alertBox3("사용할 수 없는 그룹명 입니다.");
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	function envGroupNameInsert(){
		$.ajax({
			url : "${contextPath}/mng/req/product/mngEnvGroupNameInsert",
			dataType : "JSON",
			type : "POST",
			data : {
				"envGroupName" : $("#envGroupName").val() ,
				"orderNo" : $("#allOrderNo").val()
			},
			success : function(data) {
				alertBox3("등록되었습니다.");
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	$(document).ready(function() {

		for(i=0; i< ${getReqlistvo.size()}; i++){
			getNetworkList(i);
			getOsList(i);
		}

		for(i=0; i< ${getBasketNaslistvo.size()}; i++){
			getNetworkNasList(i);
			getOsList(i);
		}

		setTimeout (function(){
			for(j=0; j< ${getReqlistvo.size()}; j++){
				$("#osProductSeq"+j).val($("#h_osProductSeq"+j).val()).attr("selected", "selected");
				$("#divNetwork"+j).val($("#h_defaultNetworkId"+j).val()).attr("selected", "selected");
			}
		},1000);

		setTimeout (function(){
			for(j=0; j< ${getBasketNaslistvo.size()}; j++){
				$("#osProductSeq"+j).val($("#h_osProductSeq"+j).val()).attr("selected", "selected");
				$("#divNetworkNas"+j).val($("#h_nasDefaultNetworkid"+j).val()).attr("selected", "selected");
			}
		},1000);

		//productDetail("${orderNo}");
		var totalPrice = $("#hiddenTotalprice").val();
		var tmpPrice = addcomma(totalPrice);
		$("#totalPrice").val(tmpPrice);

		if('WF1000C0' != $("#stepId").val()){
			$('input:checkbox[name="projectIdchk"]').prop("checked",true);
		}

		App.init();
		initApprovalLine();
		openShiftLoader();

		//상세 open close
		$(".detailView").click(function name() {
			$(this).toggleClass('active');
			$(".detailVeiwArea").toggleClass('active');
		});

		//메뉴활성화
		$("#req").addClass("active");
		$("#productManage").addClass("active");

		$("input[name=hostName]").autocomplete({
			source:hostnameList
		});

		$("input[name=ip]").autocomplete({
			source:ipList
		});

		$("input[name=ip]").autocomplete({
			nasIpList
		});

		$("input[name=backupIp]").autocomplete({
			source:ipList
		});

	});

</script>
</body>
</html>