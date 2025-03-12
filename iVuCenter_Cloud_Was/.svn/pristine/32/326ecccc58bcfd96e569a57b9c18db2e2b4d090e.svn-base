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
<!-- 		<form name="catalogueform"  id="catalogueform" action="catalogueEnvExport" method="post" > -->
		<form name="catalogueform"  id="catalogueform" action="reqDevRedeployment" method="post" >

		<div id="content" class="content">
			<!-- begin #content > header -->
				<p class="page_title">
					배포현황 상세
					<span class="root f14">
						<span>Home</span><span class="arrow_ab"> ‣ </span>
						<span class="text">콘솔</span><span class="arrow_ab"> ‣ </span>
						<span class="text arrow">개발환경</span><span class="arrow_ab"> ‣ </span>
						<span class="text arrow mint"><strong>배포현황 상세</strong></span>
					</span>
				</p>
				<div class="row p20 bgwh br10">

					<!-- 상단 이미지 시작  -->
					<%-- <div class="productTotalArea">
						<div class="productTitleArea">
							<img src="${getCatalogueSelectView.imageName}" class="width-60 pt10"/>
							<span class="productTitle">Apache HTTP Server</span>
							<p class="productsubTitle">An example Apache Http Server application </p>
						</div>
					</div> --%>
					<!-- 상단 이미지 끝  -->

					<div class="clear"></div>

					<div class="client_DetailArea mt20 bgwh">
						<!-- 프로젝트 정보 -->
						<h2 class="customer_Id">${getCatalogueSelectApp.catalogCategoryName}</h2>
						<div class="clear"></div>
						<h3 class="pname dpin">${getCatalogueSelectApp.displayName}</h3>
						<div class="clear"></div>
						<div class="mt20 mb20">
				 			<span class="dpin fb fc-blue2">본부 : </span><span id="deptName" class="ml5"></span>
				 			<span class="dpin fb ml40 fc-blue2">처(실) : </span><span id="deptName2" class="ml5"></span>
				 			<span class="dpin fb ml40 fc-blue2">부서 : </span><span id="deptName3" class="ml5"></span>
				 			<span class="dpin fb ml40 fc-blue2">담당자  : </span><span id="managerName" class="ml5"></span> (<span id="managerTel"></span>)
				 		</div>
					</div>

					<div class="clear"></div>

					<!-- 자원 신청 정보 시작 -->
					<h4 class="orderTitle">신청정보  </h4>
					<div class="orderArea">
						<div class="tableF">

							<input type="hidden" name="productSeq" id="productSeq" value="${getCatalogueSelectApp.productSeq}" />
							<input type="hidden" name="catalogSeq" id="catalogSeq" value="${getCatalogueSelectApp.catalogSeq}" />
							<input type="hidden" name="cloudId" id="cloudId" value="${getCatalogueSelectApp.cloudId}"/>

							<input type="hidden" name="type" id="type" value="noworder" />
							<input type="hidden" name="hiddenUserIdReview" id="hiddenUserIdReview" value="" />
							<input type="hidden" name="hiddenUserNameReview" id="hiddenUserNameReview" value="" />
							<input type="hidden" name="hiddenUserIdApprove" id="hiddenUserIdApprove" value="" />
							<input type="hidden" name="hiddenUserNameApprove" id="hiddenUserNameApprove" value="" />
							<input type="hidden" name="apprvPass" id="apprvPass"				value="${apprvPass}" />
							<input type="hidden" name="selectApprv" id="selectApprv"			value="" />
							<input type="hidden" name="params" id="params"	value="" />
							<input type="hidden" name="approvalStepListString" id="approvalStepListString" />
							<input type="hidden" name="applyDatetime" id="applyDatetime" value="" />

							<input type="hidden" name="cpuReq" id="cpuReq" value="${devPipeLine.cpuReq}"/>
							<input type="hidden" name="cpuLimit" id="cpuLimit" value="${devPipeLine.cpuLimit}" />
							<input type="hidden" name="memReq" id="memReq" value="${devPipeLine.memReq}" />
							<input type="hidden" name="memLimit" id="memLimit" value="${devPipeLine.memLimit}" />
							<input type="hidden" name="osProductSeq" id="osProductSeq" value="${devPipeLine.osProductSeq}"/>
							<input type="hidden" name="amount" id="amount" value="" />
							<input type="hidden" name="exportType" id="exportType" value="DEV"/>
							<input type="hidden" name="h_customerId" id="h_customerId"	value="${customerId}"/>
							<input type="hidden" name="h_projectBoxId" id="h_projectBoxId"	value="${projectBoxId}"/>

							<input type="hidden" name="h_cicdProjectId" id="h_cicdProjectId" value="${devPipeLine.cicdProjectId}"/>
							<input type="hidden" id="h_envId"	value="${devPipeLine.cicdProjectId}" />
							<input type="hidden" name="h_envName" id="h_envName"	value="${devPipeLine.envName}" />
							<input type="hidden" name="h_envApplicationVersion" id="h_envApplicationVersion"	value="${devPipeLine.envApplicationVersion}" />
<%-- 							<input type="text" name="imageId" id="imageId" value="${devPipeLine.envApplicationVersion}"/> --%>
<!-- 							<input type="text" id="h_envName"	value="" /> -->
							<input type="hidden" name="h_envGroupId" id="h_envGroupId"	value="${devPipeLine.groupId}" />
							<input type="hidden" name="h_flavorId" id="h_flavorId"				value="${devPipeLine.flavorId}" />


								<table>
									<colgroup>
										<col width="140px">
										<col width="*">
										<col width="140px">
										<col width="*">
									</colgroup>

									<tbody>
										<tr style="display:none">
											<td class="left-t">서비스희망일시</td>
											<td colspan="3">
												<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성</label> &nbsp; &nbsp;
												<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> 희망일시 생성</label> <br/>
												<div class="fc-dblue2 f14 pt10" id="selectTEXT" ><i class='fa fa-exclamation-circle f16 fc-dblue2'></i><span class="fb"> 관리자의 최종승인 후 어플리케이션이 생성 됩니다. </span></div>
											</td>
										</tr>
										<tr id="sdate" name="sdate" style="display:none">
											<td class="left"></td>
											<td colspan="3">
												<input type="text" class="form-control dpin width-100" id="applyDate" name="applyDate" />
												<div class="searchBoxArea width-80 ml10 dpin">
													<div>
														<label class="selectBoxDrop" for="applyTime">18</label>
														<select class="search-sel" name="applyTime" id="applyTime">
															<c:forEach var="time" begin="1" end="24">
																<c:if test="${time eq 18}">
																	<option value="${time}" selected="selected">${time}</option>
																</c:if>
																<c:if test="${time ne 18}">
																	<option value="${time}" >${time}</option>
																</c:if>
															</c:forEach>
														</select>
													</div>
												</div>
												<span class="fc33 f16 lh34 ml5">시</span>
											</td>
										</tr>
										<tr>
											<td class="left">클라우드 </td>
											<td>
												<input type="text" class="form-control parameterClass" name="cloudName" id="cloudName" value="${devPipeLine.cloudName}" readonly/>
<!-- 												<div class="searchBoxArea width-505"> -->
<!-- 													<select class="form-control formInfo" name="cloudInfo" id="cloudInfo" onChange="selectCloud();"> -->
<!-- 														<option value="">대역선택</option> -->
<%-- 														<c:forEach items="${cloudList}" var="cloudList" varStatus="status"> --%>
<%-- 															<c:if test="${cloudList.cloudType eq 'openshift'}"> --%>
<%-- 																<option value="${cloudList.cloudId}" data-cloud="${cloudList.cloudId}"  data-type="${cloudList.cloudType}" data-name="${cloudList.cloudName}">${cloudList.cloudName}</option> --%>
<%-- 															</c:if> --%>
<%-- 														</c:forEach> --%>
<!-- 													</select> -->
<!-- 												</div> -->
											</td>
											<td class="left">프로젝트</td>
											<td>
<!-- 												<input class="form-control formInfo" type="text" name="projectAlias" id="projectAlias" readonly="readonly"/> -->
												<input class="form-control  type="text" name="projectAlias" id="projectAlias" value="${devPipeLine.projectName}" readonly/>
												<input class="form-control" type="hidden" name="projectName" id="projectName" value="${devPipeLine.projectName}"/>
												<input type="hidden" name="projectBoxId" id="projectBoxId" value="" />
												<input type="hidden" name="projectId" id="projectId" value="${devPipeLine.projectId}" />
<!-- 												<input type="hidden" name="appNameAlias" 	id="appNameAlias" value="" /> -->
												<input type="hidden" name="productName" 	id="productName" value="" />
<!-- 												<img src="/resources/assets/img/icon_search.png" onclick="openModal();" class="input_search t10 r0" /> -->
											</td>
										</tr>
										<tr>
											<td class="left">개발환경</td>
											<td>
												<input class="form-control  type="text" name="envAlias" id="envAlias" value="${devPipeLine.envAlias}" readonly="readonly"/>
<!-- 												<img src="/resources/assets/img/icon_search.png" onclick="openEnvModal();" class="input_search t10 r0"/> -->
											</td>
											<td class="left">버전</td>
											<td>
<!-- 												<input class="form-control w138" type="text" name="osProductSeq" id="osProductSeq" value="20240902151820"/> -->
												<input type="hidden" name="imageId" id="imageId"  value="${devPipeLine.imageId}" readonly/>
												<input type="text" maxlength="30" class="form-control width-500 parameterClass" name="imageProductName" id="imageProductName"  value="${devPipeLine.imageProductName}" readonly/>

<!-- 												<div class="searchBoxArea width-505"> -->
<!-- 													<label class="selectBoxDrop" for=osProductSeq>OS선택</label> -->
<!-- 													<select class="search-sel form-select" name="osProductSeq" id="osProductSeq" onChange="appVersionSelect();"> -->
<!-- 														<option value="">버전선택</option> -->
<!-- 													</select> -->
<!-- 												</div> -->
											</td>
										</tr>
										<tr>
											<td class="left">공개범위</td>
											<td>
												<input maxlength="30" class="form-control parameterClass" name="envVisibilityLevel" id="envVisibilityLevel" value="${devPipeLine.visibility}" type="text" readonly/>

<%-- 												<c:forEach items="${getVisibilityCode}" var="getVisibilityCode" varStatus="status" > --%>
<%-- 													<c:if test="${getVisibilityCode.codeId eq 'PRIVATE'}"> --%>
<!-- 														<label class="form-check"> -->
<%-- 															<input class="form-check-input" type="radio" id="envVisibilityLevel" name="envVisibilityLevel" value="${getVisibilityCode.codeId}" checked/> --%>
<%-- 															<span class="form-check-label">${getVisibilityCode.codeName}</span> --%>
<!-- 														</label> -->
<%-- 													</c:if> --%>
<%-- 													<c:if test="${getVisibilityCode.codeId ne 'PRIVATE'}"> --%>
<!-- 														<label class="form-check"> -->
<%-- 															<input class="form-check-input" type="radio" id="envVisibilityLevel" name="envVisibilityLevel" value="${getVisibilityCode.codeId}"/> --%>
<%-- 															<span class="form-check-label">${getVisibilityCode.codeName}</span> --%>
<!-- 														</label> -->
<%-- 													</c:if> --%>
<%-- 												</c:forEach> --%>
											</td>

											<td class="left">도메인 주소</td>
											<td>
												<input class="form-control  type="text" name="domainUrl" id="domainUrl" value="${devPipeLine.domainUrl}" readonly/>
											</td>
										</tr>
										<tr>
											<td class="left" >git URL 주소</td>
											<td colspan="4">
												<input class="form-control parameterClass formInfo" type="text" name="gitRepository" id="gitRepository" value="${devPipeLine.gitRepository}.git" readonly/>
											</td>
										</tr>
										<tr>
											<td class="left">어플리케이션 명</td>
											<td>
												<input maxlength="30" class="form-control parameterClass" name="appAlias" id="appAlias" type="text" value="${devPipeLine.appAlias}"/>
											</td>
											<td class="left">어플리케이션 ID</td>
											<td>
						                    	<div class="duplicate-check-box">
						                    		<input maxlength="30" class="form-control" name="appName" id="appName" type="text" value="${devPipeLine.appName}" readonly/>
<!-- 						                    		<button type="button" onclick="appIdCheck();">중복체크</button> -->
					                    		</div>
						                    </td>
										</tr>
										<tr>
											<td class="left" scope="row">컨테이너사양</td>
											<td>
						                        <div class="depth-dropdown-box">
													<div class="searchBoxArea">
													    <label class="selectBoxDrop" for="appVerSpacGroup">서버분류</label>
														<select class="search-sel form-select" name="appVerSpacGroup" id="appVerSpacGroup" >
															<option value="">서버분류</option>
														</select>
													</div>
													<div class="searchBoxArea">
<!-- 													    <label class="selectBoxDrop" for="appFlavorId"  id="appFlavorlabel">컨테이너사양 선택</label> -->
<%-- 														<select class="search-sel form-select" name="appFlavorId" id="appFlavorId" onchange="selectAppSpecGroup(${idNum});"> --%>
														<select class="form-control" name="appFlavorId" id="appFlavorId" onchange="selectAppSpecGroup(${idNum});">
															<option value="">컨테이너사양 선택</option>
														</select>
													</div>
						                        </div>
						                    </td>
											<td class="left">컨테이너 수</td>
											<td id="DisplaydiskCnt">
												<div class="flex align-center">
													<input class="form-control" type="text"  placeholder="1" value="${devPipeLine.podCnt}" maxlength="5" name="podCount" id="podCount" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" /> <p class="inputUnit"> 개 </p>
													<img src="/resources/assets/img/icon_minus.png"  onclick="appMinus('#podCount');" class="minus"/><span class="snemo">1</span> <img src="/resources/assets/img/icon_plus.png" onclick="appPlus('#podCount');" class="plus"/>
													<p class="inputUnit">개</p>
												</div>
											</td>
										</tr>
										<tr>
<!-- 											<td class="left" style="display:none">포트</td> -->
<!-- 											<td> -->
<!-- 												<div class="duplicate-check-box"> -->
<%-- 						                    		<input  type="text" class="form-control" name="deploymentPort" id="deploymentPort"  value="${devPipeLine.deploymentPort}" maxlength="30" readonly /> --%>
<!-- 					                    		</div> -->
<!-- 											</td> -->
											<td class="left" >Context Dir</td>
											<td class="multiple-items two-input-box" >
												<input maxlength="30" class="form-control" name="deploysDirectory" id="deploysDirectory" type="text" value="${devPipeLine.deploysDirectory}">

<!-- 												<div class="searchBoxArea width-150 dpin"> -->
<!-- 												<div class="searchBoxArea width-505 dpin"> -->
<!-- 													<label class="selectBoxDrop" for="appVerSpacGroup">sources-java17-main</label> -->
<!-- 													<select class="search-sel form-select" name="deploysDirectory" id="deploysDirectory" > -->
<!-- 														<option value="sources-java17-main">sources-java17-main</option> -->
<!-- 													</select> -->
<!-- 												</div> -->
											</td>
										</tr>

										<tr>
						                	<td class="left" colspan="4">파이프라인 단계</td>
						                </tr>
						                <tr>
						                	<td colspan="4">
<!-- 						                		<ul class="pipeline-group"> -->
<!-- 						                			<li> -->
<!-- 						                				<div class="title">Stage: staging</div> -->
<!-- 						                				<div class="pip-content"> -->
<!-- 						                					<div class="pip-status"><i class="success"></i> Cleanup-job	<i class="ongoing"></i></div> -->
<!-- 						                				</div> -->
<!-- 						                			</li> -->
<!-- 						                			<li> -->
<!-- 						                				<div class="title">Stage: production​</div> -->
<!-- 						                				<div class="pip-content"> -->
<!-- 						                					<div class="pip-status"><i class="fail"></i> Job:skipped_production​</div> -->
<!-- 						                				</div> -->
<!-- 						                			</li> -->
<!-- 						                		</ul> -->
						                		<ul class="pipeline-group">
						                			<li>
						                				<div class="title">개발</div>
						                				<div class="pip-content">
							                				<c:if test="${devPipeLine.deployStatus eq 'SYNC_APP_SUCCESS'}">
								                				<div class="pip-status">skipped_production <i class="success"></i></div>
							                				</c:if>
							                				<c:if test="${devPipeLine.deployStatus eq 'SYNC_APP_FAIL'}">
								                				<div class="pip-status">skipped_production <i class="fail"></i></div>
							                				</c:if>
							                				<c:if test="${devPipeLine.deployStatus eq null}">
								                				<div class="pip-status">skipped_production <i class="before"></i></div>
							                				</c:if>
						                				</div>
						                			</li>
						                			<li>
						                				<div class="title">Copy</div>
						                				<div class="pip-content">
							                				<c:if test="${devPipeLine.copyStatus eq 'SYNC_APP_SKIP'}">
								                				<div class="pip-status">skipped_production <i class="success"></i></div>
							                				</c:if>
							                				<c:if test="${devPipeLine.copyStatus ne 'SYNC_APP_SKIP'}">
								                				<div class="pip-status">skipped_production <i class="before"></i></div>
							                				</c:if>
						                				</div>
						                			</li>
						                			<li>
						                				<div class="title">운영</div>
						                				<div class="pip-content">
							                				<c:if test="${devPipeLine.productionStatus eq 'SYNC_APP_SUCCESS'}">
								                				<div class="pip-status">deploy_production <i class="success"></i></div>
							                				</c:if>
							                				<c:if test="${devPipeLine.productionStatus eq 'SYNC_APP_FAIL'}">
								                				<div class="pip-status">deploy_production <i class="fail"></i></div>
							                				</c:if>
							                				<c:if test="${devPipeLine.productionStatus eq null}">
								                				<div class="pip-status">deploy_production <i class="before"></i></div>
							                				</c:if>
						                				</div>
						                			</li>
<!-- 						                			<li> -->
<!-- 						                				<div class="title">운영</div> -->
<!-- 						                				<div class="pip-content"> -->
<!-- 						                					<div class="pip-status">Deploy-flag <i class="before"></i></div> -->
<!-- 						                					<div class="pip-status">Rollback <i class="before"></i></div> -->
<!-- 						                				</div> -->
<!-- 						                			</li> -->
						                		</ul>
						                	</td>
						                </tr>

										<tr style="display:none">
											<td class="left-t">PV 사용 여부</td>
											<td>
												<label class="form-check">
													<input class="form-check-input" type="radio" id="onPvcFlag" name="onPvcFlagNm" value="Y"  />
													<span class="form-check-label">신청</span>
												</label>
												<label class="form-check">
													<input class="form-check-input" type="radio" id="offPvcFlag" name="onPvcFlagNm" value="N" checked />
													<span class="form-check-label">미신청</span>
												</label>
											</td>
											<td class="left pvc-box" style="display:none">PV 용량</td>
											<td class="multiple-items pvc-box" style="display:none">
												<div>
													<input class="form-control width-100" type="text" placeholder="1" value="1" maxlength="5" name="pvcVolume" id="pvcVolume"
														onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode: disabled;" onfocusout="appFocusout(this);"
														onkeyup="containerChange(this); "/>
													<p class="inputUnit pt10">GB</p>
													<input type="hidden" name="appPrice" id="appPrice" value='<fmt:formatNumber value="${appPrice}" pattern="####"/>'>
													<input type="hidden" name="appPrice1" id="appPrice1" value='<fmt:formatNumber value="${appPrice1}" pattern="####"/>'>
												</div>
												<div>
													<div class="input-group input-count-group">
														<input type="button" onclick="appMinus('#pvcVolume');" value="-">
															<div id="result01">1</div>
														<input type="button" onclick="appPlus('#pvcVolume');" value="+">
													</div>

													<p class="inputUnit pt10">GB</p>
													<span id="appPriceview" name="appPriceview" class="flr f18 fc66 dpno">
														<span class="listwon nanumR"> <fmt:formatNumber value="${appPrice1}" pattern="#,###" />
														</span>&nbsp;원
													</span>
														<input type="hidden" name="imappPrice" id="imappPrice" value="<fmt:formatNumber value="${appPrice}" pattern="####"/>" />
														<input type="hidden" name="imappCnt" id="imappCnt" value="<fmt:formatNumber value="${getCatalogueSelectApp.diskGb}" pattern="####"/>" />
												</div>
											</td>
										</tr>
									</tbody>
								</table>
						</div>

						<!-- 버튼박스 시작 -->
						<div class="btn_area">
<!-- 							<a type="button" id="newOrderBtn" class="bbton bton_blue"  onclick="request_noworderPop();"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-check"></i></span><span class="dpin ml16">배포신청</span></a> -->
<!-- 							<a type="button" class="bbton bton_blue"  onclick="openApproveReviewModal();"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-check"></i></span><span class="dpin ml16">배포 신청</span></a> -->
<!-- 							<a type="button" id="reOrderBtn" class="bbton bton_blue"  onclick="reOrderPop();"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-check"></i></span><span class="dpin ml16">재배포</span></a> -->
<!-- 							<a type="button" class="bbton bton_green ml10" onclick="basketorder();"><span class="dpin dd bton_dgreen ml-1"><i class="fa fa-cart-arrow-down"></i></span><span class="dpin ml16">일괄신청</span></a> -->
<%-- 							<c:if test="${devPipeLine.productionStatus ne 'SYNC_APP_SUCCESS' and afterVersion eq 'N'}"> --%>
							<c:if test="${afterVersion eq 'N'}">
								<a type="button" id="newOrderBtn" class="btn_navy"  onclick="request_noworderPop();">재배포신청</a>
							</c:if>
							<a type="button" class="btn_white ml10" onclick="moveListPage();">취소</a>
						</div>
						<!-- 버튼박스 끝 -->
					</div>
				</div>
				<!-- 자원 신청 정보 끝 -->

				<!-- #modal-dialog -->
				<div class="modal fade" id="message-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">알림</h4>
	                       </div>
	                       <div class="modal-body">
	                           <h5 id="confirmMsg"></h5>
	                        </div>
	                       	<div class="modal-footer tac">
	                       		<a type="button" class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->

				<!-- #modal-dialogok -->
	               <div class="modal fade" id="modal-dialogok">
	                   <div class="modal-dialog">
	                       <div class="modal-content">
	                           <div class="modal-header">
	                               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                               <h4 class="modal-title fw">자원신청</h4>
	                           </div>
	                           <div class="modal-body" id="confirmMsg">
	                               <h5>해당 자원을 바로 신청하시겠습니까? </h5>
	                               <p class="m-b-20 tac mt20">
	                                 <input type="button" class="btn btn-primary width-80" data-dismiss="modal" onclick='updateProject();' value="확인">
									 <a type="button"  class="btn btn-grey width-80" data-dismiss="modal">취소</a>
	                               </p>
	                           </div>
	                       </div>
	                   </div>
	               </div>
	               <!-- modal-dialogok -->

	               <!-- #modal-dialog 구매 확인-->
	             <div class="modal fade pdManage" id="modal-dialog3">
		               <div class="modal-dialog">
		                   <div class="modal-content">
		                       <div class="modal-header">
		                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                           <h4 class="modal-title">신청확인</h4>
	                           </div>
	                           <div class="modal-body">
									<div class="modalManagePop">
										<div class="detailBox">
											<div class="boxType01">
												<ul>
													<li>
														<span class="title" style ="width: 90px;" >프로젝트명 :</span>
														<span class="cnt nanumR" id="pop_projectAlias"></span>
													</li>
												</ul>
											</div>
											<div class="boxType02">
												<ul>
													<li>
														<span class="title" style = "width: 140px;">클라우드</span>
														<span class="cnt" id="pop_cloudName"></span>
													</li>
													<li>
														<span class="title" style = "width: 140px;">어플리케이션별칭</span>
														<span class="cnt" id="pop_appNameAlias"></span>
													</li>
													<li>
														<span class="title" style = "width: 140px;">이미지 버전</span>
														<span class="cnt" id="pop_appProductContainer"></span>
													</li>
													<li>
														<span class="title" style = "width: 140px;">Git URL 주소</span>
														<span class="cnt" id="pop_gitRepository"></span>
													</li>
													<li>
														<span class="title" style = "width: 140px;">CPU</span>
														<span class="cnt" id="pop_podCpu"></span>
													</li>

													<li>
														<span class="title" style = "width: 140px;">MEMORY</span>
														<span class="cnt" id="pop_podMem"></span>
													</li>
													<li>
														<span class="title" style = "width: 140px;">POD 수</span>
														<span class="cnt" id="pop_podCnt"></span>
													</li>
<!-- 													<li> -->
<!-- 														<span class="title" style = "width: 140px;">Volume</span> -->
<!-- 														<span class="cnt" id="pop_podPv"></span> -->
<!-- 													</li> -->

												</ul>
											</div>
<!-- 										    <div id="inputInfoPop"></div> -->
											<dl class="boxType03 dpno">
												<dt>금액<span class="fc-red">(VAT 별도)</span></dt>
												<dd><strong id="pop_totalPrice"></strong><span>&nbsp;원</span></dd>
											</dl>
										</div>
										<p class="commnet fc-red">위 내용으로 신청 하시겠습니까?</p>
									</div>
	                           </div>
							   <div class="clear"></div>
	                           <div class="modal-footer tac">
		                   			<a type="button" class="lbtn" data-dismiss="modal" onclick="request_noworder();">확인</a>
		                   			<a type="button" class="rbtn" data-dismiss="modal">취소</a>
		                       </div>
	                       </div>
	                </div>
	            </div>
				<!-- #modal-dialog  구매 확인//-->

				<!-- 결재자 지정 시작 -->
				<!-- #modal-dialog 결재자 지정팝업-->
	            <div class="modal fade" id="modal-approve-dialog">
		            <div class="modal-dialog width-720">
		                <div class="modal-content width-720">
		                    <div class="modal-header">
		                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                        <h4 class="modal-title">요청부서 결재지정</h4>
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
											<td class="tac" id="approvalLine1_title"> 입안보조 </td>
											<td class="tac" id="approvalLine1_userId"> 사번 </td>
											<td class="tac" id="approvalLine1_userLevel"> 직급 </td>
											<td class="tac" id="approvalLine1_userName"> 이름 </td>
											<td class="tac">
												<button type="button" class="cbton bton_lblue" id="approvalLine1" onclick="openReviewModal(this);"><i class='fa fa-search'></i></button>
											</td>
										</tr>
							 			<tr>
								 			<td class="tac" id="approvalLine2_title"> 입안 </td>
								 			<td class="tac" id="approvalLine2_userId"> 사번 </td>
								 			<td class="tac" id="approvalLine2_userLevel"> 직급 </td>
								 			<td class="tac" id="approvalLine2_userName"> 이름 </td>
								 			<td class="tac">
								 				<button type="button" class="cbton bton_lblue" id="approvalLine2" onclick="openReviewModal(this);" disabled="disabled"><i class='fa fa-search'></i></button>
								 			</td>
							 			</tr>
							 			<tr>
											<td class="tac" id="approvalLine3_title"> 검토 </td>
											<td class="tac" id="approvalLine3_userId"> 사번 </td>
											<td class="tac" id="approvalLine3_userLevel"> 직급 </td>
											<td class="tac" id="approvalLine3_userName"> 이름 </td>
											<td class="tac">
												<button type="button" class="cbton bton_lblue" id="approvalLine3" onclick="openReviewModal(this);" disabled="disabled"><i class='fa fa-search'></i></button>
											</td>
										</tr>
										<tr>
											<td class="tac" id="approvalLine4_title"> 승인 </td>
											<td class="tac" id="approvalLine4_userId"> 사번 </td>
											<td class="tac" id="approvalLine4_userLevel"> 직급 </td>
											<td class="tac" id="approvalLine4_userName"> 이름 </td>
											<td class="tac">
												<button type="button" class="cbton bton_lblue" id="approvalLine4" onclick="openReviewModal(this);" disabled="disabled"><i class='fa fa-search'></i></button>
											</td>
										</tr>
							 		</tbody>
					 			</table>
						 	</div>
							<div class="clear"></div>
							<div class="modal-footer tac">
		             			<a type=button class="lbtn" data-dismiss="modal" onclick="noworder();">확인</a>
		             			<a type=button class="rbtn" data-dismiss="modal">취소</a>
		                 	</div>
		             	 </div>
					</div>
		        </div>


			<!-- 프로젝트 검토자 결재자 지정 팝업 -->
			<!-- #modal-dialog -->
			<div class="modal fade" id="user-modal-review-dialog">
				<div class="modal-dialog width-720">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'>
								<span></span>
							</button>
							<h4 class="modal-title">검토자 검색</h4>
						</div>
						<div class="modal-body">

				 		<!--//검색 시작-->
	                       	 <div class="col-xs-12 bgee modalpop mb20">
		                       		<div class="selectBoxBr col-xs-3">
										<label class="selectText" for="reviewSearchKind">전체</label>
										<select class="search-sel" id="reviewSearchKind">
											<option value="searchAll">전체</option>
											<option value="userId">사번</option>
											<option value="userName">이름</option>
											<option value="deptName">부서</option>

										</select>
									</div>
										<div class="col-xs-9">
											<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="reviewUserId" onkeypress="if(event.keyCode==13)gridPopList();" >
											<button type="button" class="btn_search2 vm" onclick="gridPopList();"><span></span></button>
										</div>
								</div>
						<!--검색  끝//-->


						<table class="tableV">
						 <colgroup>
								 <col width="*">
								 <col width="15%">
								 <col width="15%">
								 <col width="15%">
								 <col width="15%">
								<col width="8%">
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
				<!-- 프로젝트 승인자 결재자 지정 팝업 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="user-modal-approve-dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true" onclick='gridList();'>
									<span></span>
								</button>
								<h4 class="modal-title">승인자 검색</h4>
							</div>
							<div class="modal-body">
								<!--//검색 시작-->
								<div class="col-xs-12 bgee modalpop mb20">
									<div class="selectBoxBr col-xs-3">
										<label class="selectText" for="approveSearchKind">전체</label>
										<select class="search-sel" id="approveSearchKind">
											<option value="searchAll">전체</option>
											<option value="userId">사번</option>
											<option value="userName">이름</option>
											<option value="deptName">부서</option>
										</select>
									</div>
									<div class="col-xs-9">
										<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="approveUserId" onkeypress="if(event.keyCode==13)gridPopApproveList();" >
										<button type="button" class="btn_search2 vm" onclick="gridPopApproveList();"><span></span></button>
									</div>
								</div>
								<!--검색  끝//-->

								<table class="tableV">
							 		<colgroup>
							 			<col width="*">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="8%">
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
							 		<tbody id="popListApproveTable">
							 		</tbody>
				 	    		</table>
								<div class="noneList" id='popListApproveTable2'>
									<span>검색된 사용자가 없습니다.</span>
								</div>
								<div class="totalcnt" id="totalApproveCnt">총 0 건</div>
							</div>
							<div class="modal-footer tac">
								<a type="button" class="whiteline" data-dismiss="modal">닫기</a>
							</div>
						</div>
					</div>
				</div>
				<!-- 결재자 지정 끝 -->
				<!-- #modal-dialog 모음 끝-->

				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
			<!-- end #content -->
	  		</form>
		<!-- end page container -->
	</div>

<div style="display: none;">
<table>
	<tbody id="parameter_clone_temp">
		<tr>
			<td class="left">#paramKey#</td>
			<td>
				<input class="form-control width-505 #parameterClass#"
				type="text"
				name="#paramName#"
				id="#paramId#"
				value="#paramValue#"
				data-expression=#paramGenerate#
				data-from=#paramFrom#
				data-key="#paramKey#"
				data-original-title=""
				title="">
			</td>
		</tr>
	</tbody>
</table>
</div>

<div style="display: none;">
<table>
	<tbody id="parameter_clone_temp_pop">
		<tr>
			<td class="left">#paramKeyPop#</td>
			<td>
				<input class="form-control width-300 #parameterClass#"
				type="text"
				name="#paramNamePop#"
				id="#paramIdPop#"
				value="#paramValuePop#"
				data-expression=#paramGeneratePop#
				data-from=#paramFromPop#
				data-key="#paramKeyPop#"
				data-original-title=""
				title=""
				readonly>
			</td>
		</tr>
	</tbody>
</table>
</div>


<%-- data-expression="${parameters.generate}" data-from="${parameters.from}" data-key="${parameters.name}" --%>
<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript" src="/resources/assets/js/jquery.amsify.suggestags.js"></script>
<script type="text/javascript" src="/resources/assets/js/randexp.min.js"></script>
<script type="text/javascript">
	//결재라인 관련 변수
	var currentApprovalLine = "";
	var approvalList = [];

	$('input[name="label"]').amsifySuggestags({
		type : 'amsify'
   	});

	var hprojectName,hprojectBoxId, hprojectId, hprojectAlias;

   	function openApproveReviewModal(){

		var imageType = "${imageType}";

		if(imageType != "" && imageType != undefined){
			imageType = imageType.replace(/[0-9]/g, "");
		}

		if($("#projectAlias").val() ==""){
			alertBox3("프로젝트를 선택하세요");
			return false;
		}

   		if($("input[name='onDemandFlag']:checked").val()=="N"){
			if($("#applyDate").val()==""){
				alertBox3("서비스희망일시를 입력하세요");
				return false;
			}
			if($("#applyTime > option:selected").val()==""){
				alertBox3("서비스희망일시 시간을 입력하세요");
				return false;
			}
		}

		if($("#appName").val()==""){
			alertBox3("어플리케이션 명을 입력하세요");
			return false;
		}
		if(imageType != "APPIMGMQ"){
			if($("#gitRepository").val()==""){
				alertBox3("Git URL 주소를 입력하세요");
				return false;
			}
		}
		if($("#cloudInfo > option:selected").val()==""){
				alertBox3("서버대역을 입력하세요");
				return false;
		}
		if($("#osProductSeq > option:selected").val()==""){
				alertBox3("버전을 입력하세요");
				return false;
		}
		if($("#appFlavorId > option:selected").val()==""){
				alertBox3("컨테이너사양을 입력하세요");
				return false;
		}

		//조건 체크
		if($("#apprvPass").val() == "Y"){
			confirmBox4("결재자를 지정하시겠습니까?",approvSelect, nApprovSelect);
		} else {
			approvSelect();
		}
   	}

   	function nApprovSelect(){
		$("#selectApprv").val("Y");
		noworder();
	}
	function approvSelect(){
		$("#selectApprv").val("N");
		$("#modal-approve-dialog").modal();
	}

	function openReviewModal(e) {
		currentApprovalLine = e;
		var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
		if( approvalList[tmpCurrentApprovalStep-1] != undefined) {
			confirmBox("재신청할경우 현재 상위결재자값이 초기화 됩니다.", clearUpperApproval );

		} else {
			$("#user-modal-review-dialog").modal();
			gridPopList();
		}

	}

	// 결재자 등록 팝업 리스트
	function gridPopList(){
		$.ajax({
			url : "${contextPath}/mbr/operation/approveUser/addProjectApproveList",
			dataType : "JSON",
			data : {
				"searchKind": $("#reviewSearchKind option:selected").val()
				, "keyword"	: $("#reviewUserId").val()
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
								 +'<td class="tac">'+val.userLevel+'</td>'
						 		 +'<td class="tac">'+val.userName+'</td>'
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

	// 검토자지정
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

		var tmpValue = { "userId" : userId, "deptName" : deptName, "userName" : userName, "userLevel" : userLevel, "userLevelCode" : userLevelCode }

		$("#"+currentApprovalLine.id+"_userId").text(userId);
		$("#"+currentApprovalLine.id+"_userLevel").text(userLevel);
		$("#"+currentApprovalLine.id+"_userName").text(userName);

		approvalList[tmpCurrentApprovalStep-1] = tmpValue;
		$("#popListReviewTable > tr").find("input").removeClass("active");
		$(e).toggleClass("active");
		$("#userIdReview").text(userId);
		$("#userNameReview").text(userName);
		$("#hiddenUserIdReview").val(userId);
		$("#hiddenUserNameReview").val(userName);

		// 다음 단계 버튼 활성화
		$("#approvalLine"+(parseInt(tmpCurrentApprovalStep)+1) ).attr('disabled', false);
	}

	 // 승인자지정
	function updateApprove(e, userId, userName){

		/* if($("#hidden_login_user_id").val() ==userId) {
			alertBox("신청자는 본인을<br>결재자로 지정할수 없습니다.");
			return false;
		} */

		$("#popListApproveTable > tr").find("input").removeClass("active");
		$(e).toggleClass("active");
		$("#userIdApprove").text(userId);
		$("#userNameApprove").text(userName);
		$("#hiddenUserIdApprove").val(userId);
		$("#hiddenUserNameApprove").val(userName);
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

	function podminus(){
		if(Number($("#podCnt").val())>1){
			var cnt = $("#podCnt").val() * 1;
			$("#podCnt").val(cnt - 1);
		}
	}
	function podplus(){
		var cnt = $("#podCnt").val() *1;
		$("#podCnt").val(cnt + 1);
	}

	// 바로신청
	function noworder(){

		var checkVal = "";
		if( (approvalList[3] == undefined || approvalList[3] == null || approvalList[3] == '') && $("#selectApprv").val() == 'N' ) {
			alertBox3("결재자를 지정해 주세요");
			return false;
		}


		if($("input[name='onDemandFlag']:checked").val()=="N"){
			if($("#applyDate").val()==""){
				alertBox3("서비스희망일시를 입력하세요");
				return false;
			}
			if($("#applyTime > option:selected").val()==""){
				alertBox3("서비스희망일시 시간을 입력하세요");
				return false;
			}
		}

		if($("#projectName").val()==""){
			alertBox3("프로젝트를 입력하세요");
			return false;
		}
		if($("#appName").val()==""){
			alertBox3("어플리케이션 명을 입력하세요");
			return false;
		}
		if($("#cloudInfo > option:selected").val()==""){
				alertBox3("서버대역을 입력하세요");
				return false;
		}
		if($("#osProductSeq > option:selected").val()==""){
				alertBox3("버전을 입력하세요");
				return false;
		}
		if($("#appFlavorId > option:selected").val()==""){
				alertBox3("컨테이너사양을 입력하세요");
				return false;
		}
		setOrder();

// 		$("#pop_title_projectAlias").text($("#projectAlias").val());
// 		$("#pop_appName").text($("#appName").val());
// 		$("#pop_jenkins_service_name").text($("#jenkins_service_name").val());
// 		$("#pop_jenkins_image_stream_tag").text($("#jenkins_image_stream_tag").val());
// 		$("#pop_onDemandFlag").text($("#onDemandFlag").val());
// 		$("#pop_gitRepository").text($("#gitRepository").val());
// 		$("#pop_label").text($("#label").val());

		$("#modal-dialog3").modal();
	}

	// 구매전 확인 팝업
	function setOrder() {

		$("#pop_projectName").text($("#projectName").val());			// 프로젝트 명
		$("#pop_projectAlias").text($("#projectAlias").val());

		$("#pop_cloudName").text($("#cloudName").val());				// 클라우드명
		$("#pop_appNameAlias").text($("#appName").val());				// 어플리케이션 명
		$("#pop_gitRepository").text($("#gitRepository").val());		// Git URL 주소
		$("#pop_appProductContainer").text($("#productName").val());	// 카탈로그 상품 명

		$("#pop_podCpu").text($("#cpuReq").val());						// 서버 사양 cpu
		$("#pop_podMem").text($("#memReq").val());						// 서버 사양 memory

		$("#pop_podCnt").text($("#podCount").val());					// POD 개수
		$("#pop_podPv").text($("#pvcVolume").val()+' GB');				// PV 용량


		if ($("input[name='onDemandFlag']:checked").val() == 'N') {
			$("#pop_onDemandFlag").text($("#applyDate").val()+' '+$("#applyTime").val()+':00');
			$("#applyDatetime").val($("#applyDate").val()+' '+$("#applyTime").val()+':00');
		} else if ($("input[name='onDemandFlag']:checked").val() == 'Y') {
			$("#pop_onDemandFlag").text('승인 완료 후 생성');
		}

		if( approvalList[0] == undefined || approvalList[0] == null) {
			var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
			approvalList[0] = tmp;
		}
		$("#approvalStepListString").val(JSON.stringify(approvalList));

	}

	function request_noworderPop(){
// 		if($("#projectName").val()==""){
// 			alertBox3("프로젝트를 선택하세요.");
// 			return false;
// 		} else if($("#envName").val()==""){
// 			alertBox3("개발환경 명을 입력하세요.");
// 			return false;
// 		} else if($("#envAlias").val()==""){
// 			alertBox3("공개범위를 입력하세요.");
// 			return false;
// 		}
		confirmBox("재배포 신청하시겠습니까?", request_noworder);
	}

	function request_noworder(){

		if( approvalList[0] == undefined || approvalList[0] == null) {
			var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
			approvalList[0] = tmp;
		}

		$("#approvalStepListString").val(JSON.stringify(approvalList));

		var type = $("#catalogueform").attr("type");
		var url = $("#catalogueform").attr("action");
		var data = $("#catalogueform").serialize();

		$.ajax({
			url:url,
			type:type,
			data:data,
			success:function(data){

				if(data == "1"){
// 					alertBox("신청이 완료 되었습니다.", orderok2);
// 					alertBox("신청이 완료 되었습니다.", reload);
					alertBox("신청이 완료 되었습니다.", moveListPage);
				} else {
					alertBox3("신청에 실패하였습니다.");
				}
			},
			error : function(request, status, error) {
				regTemp = true;
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);
				}else{
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			}
		})
	}

	// 재배포
	function reOrderPop(){
		confirmBox("재배포 신청하시겠습니까?",reOrder);
	}

	function reDevOrder(){

		$.ajax({
			url : "${contextPath}/mbr/application/env/reDevOrder",
			data : {
				"envGroupUrl" : $("#envGrpUrl").val()
			},
			success : function(data) {

				var chkVal = data;
				if(chkVal==0){
					alertBox3("사용 가능한 ID 입니다.");
				}else{
					alertBox3("기존에 사용중인 ID 입니다.");
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	function reload(){
		location.reload();
	}

	function orderok2(){
		location.href="${wasPath}/mbr/application/req/";
	}

	function moveListPage() {
// 		location.href="${wasPath}/mbr/application/req/";
		location.href="${wasPath}/mbr/application/req/reqDevDeployList";
	}

	function calendar(){

		var dayName = ['일','월','화','수','목','금','토'];
		var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

		$("#applyDate").datepicker({
			showOn:"both",
			buttonImage:"${apachePath}/resources/assets/img/calen.png",
			buttonImageOnly:true,
			dateFormat : "yy-mm-dd",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});
		$("img.ui-datepicker-trigger").attr("style", "margin-top:-5px;");
		$("#applyDate").val($.datepicker.formatDate('yy-mm-dd', new Date()));
	}

	function createValue(){
		var grp = $("input[name=parameter]").length;
   		var parameterValue = "";
		//배열 생성
		var grparr = new Array(grp);
		//배열에 값 주입
		for(var i=0; i<grp; i++){
				if($("input[name=parameter]").eq(i).data("expression") == "expression"){
				var exp = $("input[name=parameter]").eq(i).data("from");
				var v = new RandExp(exp).gen();
				$("input[name=parameter]").eq(i).val(v);
			}
		}
	}

	function appMinus(cntId){
		if(Number($(cntId).val())<=1){
			alertBox3("컨테이너는 최소 1개 이상<br/>신청하셔야 합니다.");
		} else {
			var appCnt;
			appCnt = Number(rtnnumber($(cntId).val())) - 1;
			$(cntId).val(appCnt);
		}
	}

	function appPlus(cntId){
		if(Number($(cntId).val())>=50){
			alertBox3("컨테이너는 최대 50개 이상<br/>신청하실수 없습니다.");
		} else {
			var appCnt;
			appCnt = Number(rtnnumber($(cntId).val())) + 1;
			$(cntId).val(appCnt);
		}
	}

	// 서버대역 (클라우드) 선택, 타입, ID
	function selectCloud(){

		var cloudId = ($("#cloudInfo > option:selected").data("cloud"));
		var cloudType = $("#cloudInfo > option:selected").data("type");
		var cloudName = $("#cloudInfo > option:selected").data("name");

		$("#cloudId").val(cloudId);
		$("#cloudType").val(cloudType);
		$("#cloudName").val(cloudName);
		getVersionList();
	}

	// 버전 선택 시 금액 정보 출력
	function appVersionSelect(){

		// 이미지 ID Set
// 		var vmImageId = $("#osProductSeq").children('option:selected').data("vmimageid");
		var vmImageId = $("#osProductSeq").children('option:selected').data("templatename");
		$("#imageId").val(vmImageId);
		$("#productName").val($("#osProductSeq").children('option:selected').data("name"));
		getFlavorTypeList();

	}

	// 버전 드롭다운 메뉴 불러오기
	function getVersionList(){

	 	$("#osProductSeq").html("");
		var cloudId = '${cloudId}';
		var cloudType = '${cloudType}';

		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/osList",
			dataType : "JSON",
				type : "GET",
			data : {
				"productSeq" : $("#productSeq").val()
				,"cloudId" : cloudId
				,"cloudType" : cloudType
			},
			success : function(req) {

// 				var html = "<select class='search-sel form-select' name='osProductSeq' id='osProductSeq' onchange='appVersionSelect();'>";
				var html = "<option value=''>OS 선택</option>";

				$.each(req,function(k,v){
					if(`${getCatalogueSelectApp.displayName}` == "KDN Python Django Server") {
						if("${imageType}" === v["itemId"]){
							if (v['productName'] == "kdn-python-django-server"){
								html += "<option value='"+v['productSeq']+"'data-name='"+v['productName']+"'data-templatename='"+v['templateName']+"'>"+v['productName']+"</option>";
							}
						}
					} else if(`${getCatalogueSelectApp.displayName}` == "WAS 서버 기반의 어플리케이션 배포") {
						if("${imageType}" === v["itemId"]){
							if (v['productName'] != "kdn-python-django-server"){
								html += "<option value='"+v['productSeq']+"'data-name='"+v['productName']+"'data-templatename='"+v['templateName']+"'>"+v['productName']+"</option>";
							}
						}
					} else {
						if("${imageType}" === v["itemId"]){
							html += "<option value='"+v['productSeq']+"'data-name='"+v['productName']+"'data-templatename='"+v['templateName']+"'>"+v['productName']+"</option>";
						}
					}
				})
// 				html += "</select>"
				$("#osProductSeq").html(html);
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

	// 서버 사양
	jQuery.fn.filterBySelect = function(select1, selectSingleMatch) {
		return this.each(function () {
			var select = this;
			var options = [];
			$(select).find('option').each(function() {
				options.push({value: $(this).val(), text: $(this).text(), group: $(this).attr("group"), cpu: $(this).attr("cpu"), mem: $(this).attr("mem"), disk: $(this).attr("disk")  });
			});
			$(select).data('options', options);
			$(select1).bind('change select', function() {
				var options = $(select).empty().data('options');
				var search = $(this).val();
				var a = 1;
				var regex = new RegExp(search, "gi");

				$.each(options, function(i) {
					var option = options[i];
					if(option.group.match(regex) !== null) {

						if(a == 1){
							$(select).append( $('<option>').text("컨테이너사양을 선택하세요.").val(""));
						}

						$(select).append( $('<option>').text(option.text.replace(/'/g, '')).val(option.value).attr("cpu", option.cpu).attr("mem", option.mem).attr("disk", option.disk) );
						a++;
					}
				});
				if (selectSingleMatch === true && $(select).children().length === 1) {
					$(select).childeren().get(0).selected = true;
				}
				$("#flavorId2").text("컨테이너사양을 선택하여주세요.");
			});
		});
	};

	// 컨테이너사양(대용량, 저용량 등) 버전 선택에 따른 서버 사양 / 따로 분리가 되는지 확인 필요함.
	function getFlavorTypeList(){

// 		var cloudId = $("#cloudInfo").children('option:selected').data("cloud");
		var cloudId = $("#cloudId").val();
		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/getFlavorTypeList",
			dataType : "JSON",
				type : "GET",
			data : {
				"cloudId" : cloudId
			},
			success : function(req) {
				var html = "";
				$.each(req,function(k,v){
					html += "<option value='"+v['flavorType']+"'>"+v['flavorName']+"</option>";
				})
				$("#appVerSpacGroup").html(html);
				getCatalogueFlavorList();
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

	// 버전 선택에 따른 서버 사양 / 따로 분리가 되는지 확인 필요함.
	function getCatalogueFlavorList(){

// 		var cloudId = $("#cloudInfo").children('option:selected').data("cloud");
		var cloudId = $("#cloudId").val();
// 		var vmImageId = $("#osProductSeq").children('option:selected').data("vmimageid");
		var imageId = $("#imageId").val();
		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/getCatalogueFlavorList",
			dataType : "JSON",
 			type : "GET",
			data : {
				"cloudId" : cloudId,
				"vmImageId" : imageId
			},
			success : function(req) {

				var html = "";
				var flavorType = "";
				$.each(req,function(k,v){
					var ramGb = v['ramMb'] / 1024;
// 					if(v['cloudType'] == 'ncloud' ){
// 						html += "<option group='"+v['flavorType']+"' cpu='"+v['vcpus']+"' mem='"+ramGb+"' disk='"+v['diskGb']+"' value='"+v['flavorId']+"'> CPU : "+v['vcpus']+"Core MEM: "+ramGb+"GB + DISK : "+v['diskGb']+"</option>";
// 					}else{
// 					    html += "<option group='"+v['flavorType']+"' cpu='"+v['vcpus']+"' mem='"+ramGb+"' disk='"+v['diskGb']+"' value='"+v['flavorId']+"'> CPU : "+v['vcpus']+"Core MEM: "+ramGb+"GB</option>";
// 					}
					if(v['flavorId'] === $("#h_flavorId").val()){
						flavorType = v['flavorType'];
					}
				    html += "<option group='"+v['flavorType']+"' cpu='"+v['vcpus']+"' mem='"+ramGb+"' disk='"+v['diskGb']+"' value='"+v['flavorId']+"'> CPU : "+v['vcpus']+"Core MEM: "+ramGb+"GB</option>";
				});
				$("#appFlavorId").html(html);
				$("#appFlavorId").filterBySelect($("#appVerSpacGroup"), false);
// 				$("#appVerSpacGroup option:first").prop("selected", true).trigger('change');
// 				$("#appVerSpacGroup").val(flavorType).prop("selected", true).trigger('change');
// 				$("#appFlavorId option:first").prop("selected", true).trigger('change');
// 				$("#appFlavorId").val($("#h_flavorId").val()).prop("selected", true).trigger('change');
				if(flavorType != undefined && flavorType != ''){
					$("#appVerSpacGroup").val(flavorType).prop("selected", true).trigger('change');
				}else{
					$("#appVerSpacGroup option:first ").prop("selected", true).trigger('change');
				}

				if($("#h_flavorId").val() != undefined && $("#h_flavorId").val() != ""){
					$("#appFlavorId").val($("#h_flavorId").val()).prop("selected", true).trigger('change');
				}else{
					$("#appFlavorId option:first").prop("selected", true).trigger('change');
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

	// 컨테이너사양 선택시 값 설정
	function selectAppSpecGroup(argCnt){
		var cpuLimitVal = $("#appFlavorId option:selected").attr("cpu");
		var memLimitVal = $("#appFlavorId option:selected").attr("mem");
		var memReqType = "Gi";

		$("#cpuReq").val(cpuLimitVal);
		$("#cpuLimit").val(cpuLimitVal+"");
		$("#memReq").val(memLimitVal);
		$("#memLimit").val(memLimitVal+"");
		$("#memReq_type").val("Gi");
		$("#memLimit_type").val("Gi");

// 		amountView();
	}

	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/oss/project/detail",
			dataType : "JSON",
			data : {
				"projectBoxId" : $("#h_projectBoxId").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){
					if(val != null){
						if(i != "deptName"){
							if(i=="customerId"){
								$("#hid_"+i).val(val);
							}else if(i =="keyword"){
								// 스크립트 오류로 해당 내역을 추가함(jeffrey)
							}else{
								$("#"+i).text(val);
							}
							if(i == "deptName2"){
								if(val){
									$("#deptName").html(val.split("/")[1]);
									$("#deptName2").html(val.split("/")[2]);
									$("#deptName3").html(val.split("/")[3]);
								}
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
		//메뉴활성화
		calendar();

		$("input[name='onDemandFlag']").on('click',function(){
			if($("input[name='onDemandFlag']:checked").val()=="N"){
				$("#sdate").show();
				$("#selectTEXT").empty().append("<i class='fa fa-exclamation-circle f16 fc-dblue2'></i> <span class='fb'>관리자의 최종 승인 후 선택한 시간에 가상머신이 생성 됩니다. </span>" );
				$("#selectTEXT").show();
			}else{
				$("#sdate").hide();
				$("#selectTEXT").empty().append("<i class='fa fa-exclamation-circle f16 fc-dblue2'></i> <span class='fb'>관리자의 최종승인 후 가상머신이 생성 됩니다. </span>" );
				$("#selectTEXT").show();
			}
		});

		getFlavorTypeList();

		getDetail();

		$("#reqDev").addClass("active");
		$("#reqDevDeployList").addClass("active");

// 		createValue();
// 		appVersionSelect();
// 		$(".formInfo").prop("disabled", true);
	});

</script>
</body>
</html>