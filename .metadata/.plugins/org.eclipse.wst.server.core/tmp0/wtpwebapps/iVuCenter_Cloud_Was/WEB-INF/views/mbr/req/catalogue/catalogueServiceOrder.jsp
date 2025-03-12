<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri = "http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
   	<sec:authentication var="roles" property="principal.roles"/>
   		<sec:authentication var="userId" 	property="principal.username" />
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

<iframe id='iframeBasket' name='iframeBasket' style='display:none; border:0px;'></iframe>

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

			    <p class="page_title">서비스 신청
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> <b>서비스 신청 </b>
			    </span>
		    	</p>

			 <!-- begin page-body -->
			 <div class="row p20 bgwh br10">

				<!----첫번째 자원내용------->
				<c:set var="totalPrice" value="" />
				<c:set var="cpuPrice" value="" />
				<c:set var="memPrice" value="" />
				<c:set var="memPrice1" value="" />
				<c:set var="diskPrice" value="" />
				<c:set var="diskPrice1" value="" />
				<c:set var="osPrice" value="" />
				<c:set var="priceTypeTxt" value="" />
				<c:choose>
					<c:when test="${getCatalogueServiceView.hourlyFlag eq 'Y'}">
						<c:set var="cpuPrice" value="${getCatalogueServiceView.cpuHourlyPrice}" />
						<c:set var="memPrice" value="${getCatalogueServiceView.memGb * getCatalogueServiceView.memHourlyPrice}" />
						<c:set var="memPrice1" value="${getCatalogueServiceView.memHourlyPrice}" />
						<c:set var="diskPrice" value="${getCatalogueServiceView.diskHourlyPrice * 10}" />
						<c:set var="diskPrice1" value="${getCatalogueServiceView.diskHourlyPrice * getCatalogueServiceView.diskGb / 10}" />
						<c:set var="totalPrice" value="${getCatalogueServiceView.monthlyPrice}" />

					</c:when>
					<c:otherwise>
						<c:set var="cpuPrice" value="${getCatalogueServiceView.cpuMonthlyPrice}" />
						<c:set var="memPrice" value="${getCatalogueServiceView.memGb * getCatalogueServiceView.memMonthlyPrice}" />
						<c:set var="memPrice1" value="${getCatalogueServiceView.memMonthlyPrice}" />
						<c:set var="diskPrice" value="${getCatalogueServiceView.diskMonthlyPrice * 10}" />
						<c:set var="diskPrice1" value="${getCatalogueServiceView.diskMonthlyPrice * getCatalogueServiceView.diskGb / 10}" />
						<c:set var="totalPrice" value="${getCatalogueServiceView.monthlyPrice}" />
					</c:otherwise>
				</c:choose>


				<div class="product_box">
				     <c:if test="${getCatalogueServiceView.catalogCategory eq 'CATACATE_SERVICE'}">
					  <li class="img"><img src="${getCatalogueServiceView.imageName}" class="width-80"/></li>
					  <li class="description">
					      <span class="productTitle">${getCatalogueServiceView.displayName}</span>
					       <p class="productsubTitle">
					       <c:if test="${getCatalogueServiceView.descriptionTop eq null or getCatalogueServiceView.descriptionTop eq ''}">
							한전 K-Cloud 전문가 서비스 자원
							</c:if>
							<c:if test="${getCatalogueServiceView.descriptionTop ne null or getCatalogueServiceView.descriptionTop ne ''}">
							${getCatalogueServiceView.descriptionTop}
							</c:if>
					        </p>
					  </li>
					  </c:if>
					  <ul class="product_sub">
					  </ul>
					</div>


					<div class="clear"></div>
					<div class="orderArea">
						<div class="tableF">
						<form name="catalogueform"  id="catalogueform" action="catalogueServiceOrderNow" method="post" >
							<input type="hidden" name="imagePath" id="imagePath" value="${getCatalogueServiceView.imagePath}" />
							<input type="hidden" name="imageName" id="imageName" value="${getCatalogueServiceView.imageName}" />
							<input type="hidden" name="type" id="type" value="noworderinsert" />
							<input type="hidden" name="productSeq" id="productSeq" value="${getCatalogueServiceView.productSeq}" />
							<input type="hidden" name="totalPrice" id="totalPrice" value="<fmt:formatNumber value="${totalPrice}" pattern="#,###"/>" />
							<input type="hidden" name="productCategory" id="productCategory" value="${getCatalogueServiceView.productCategory}" />
							<input type="hidden" name="displayName" id="displayName" value="${getCatalogueServiceView.displayName}" />
							<input type="hidden" name="catalogSeq" id="catalogSeq" value="${getCatalogueServiceView.catalogSeq}" />
							<input type="hidden" name="hiddenUserIdReview" id="hiddenUserIdReview" value="" />
							<input type="hidden" name="hiddenUserNameReview" id="hiddenUserNameReview" value="" />
							<input type="hidden" name="hiddenUserIdApprove" id="hiddenUserIdApprove" value="" />
							<input type="hidden" name="hiddenUserNameApprove" id="hiddenUserNameApprove" value="" />
							<input type="hidden" name="serviceType" id="serviceType" value="${getCatalogueServiceView.serviceType}"/>
							<input type="hidden" id="confirmFlag" value="N"/>
							<input type="hidden" name="hidden_login_user_id" id="hidden_login_user_id" value="${userId}" />
							<input type="hidden" name="cloudId" id="cloudId" value="${cloudId}" />
							<input type="hidden" name="cloudType" id="cloudType" value="${cloudType}" />
							<input type="hidden" name="cloudImgPath" id="cloudImgPath" value="${cloudImgPath}" />
							<input type="hidden" name="approvalStepListString" id="approvalStepListString" />
							<input type="hidden" name="apprvPass" id="apprvPass"				value="${apprvPass}" />
							<input type="hidden" name="selectApprv" id="selectApprv"			value="" />

                            <input type="hidden" id="autoScaleOut" name="autoScaleOut" value="0"/>
                            <input type="hidden" id="pod" name="pod" value="1"/>

							<table>
								<colgroup>
									<col width="140px">
									<col width="*">
									<col width="140px">
									<col width="*">
								</colgroup>
								<tbody>
								<tr>
								<td class="left-t">서비스희망일시</td>
								<td colspan="3">
									<div class="radio-select-group">
										<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성</label>&nbsp; &nbsp;
										<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> 희망일시 생성 </label>	 <br/>
									</div>
									<c:if test="${getCatalogueServiceView.catalogCategory eq 'CATACATE_BACKUP'}">
										<p class="fcsb f16 mt10"><img src="${apachePath}/resources/assets/img/icon_tpoint.png"/> 승인 완료 후 생성 선택시 클라우드 관리자의 최종승인 완료 후 백업 서비스가 생성이 됩니다. </p>
									</c:if>
									<c:if test="${getCatalogueServiceView.catalogCategory eq 'CATACATE_MCA'}">
										<p class="fcsb f16 mt10"><img src="${apachePath}/resources/assets/img/icon_tpoint.png"/> 승인 완료 후 생성 선택시 클라우드 관리자의 최종승인 완료 후 대외계 서비스가 생성이 됩니다. </p>
									</c:if>
									<c:if test="${getCatalogueServiceView.catalogCategory eq 'CATACATE_SCM'}">
										<p class="fcsb f16 mt10"><img src="${apachePath}/resources/assets/img/icon_tpoint.png"/> 승인 완료 후 생성 선택시 클라우드 관리자의 최종승인 완료 후 형상관리 서비스가 생성이 됩니다. </p>
									</c:if>
									<c:if test="${getCatalogueServiceView.catalogCategory eq 'CATACATE_SECURITY'}">
										<p class="fcsb f16 mt10"><img src="${apachePath}/resources/assets/img/icon_tpoint.png"/> 승인 완료 후 생성 선택시 클라우드 관리자의 최종승인 완료 후 보안관제 서비스가 생성이 됩니다. </p>
									</c:if>
								</td>
								</tr>
								<tr id="sdate" name="sdate" style="display:none">
								<td class="left-b th20"></td>
								<td colspan="3">
								<div>
									<input type="text" class="form-control dpin width-150" id="applyDate" name="applyDate" />
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
								</div>
								</td>
								</tr>

								<c:if test="${getCatalogueServiceView.serviceType ne 'ASCL'}">
									<tr>
										<td class="left">프로젝트명</td>
										<td>
											<div class="search-box">
												<input class="form-control w95" type="text" name="projectAlias" id="projectAlias" readonly="readonly"/>
												<input class="form-control" type="hidden" name="projectName" id="projectName" />
												<input type="hidden" name="projectBoxId" id="projectBoxId" value="" />
												<input type="hidden" name="projectId" id="projectId" value="" />
												<%-- <img src="${apachePath}/resources/assets/img/icon_search.png" onclick="openModal();" class="input_search"/> --%>
												<img src="${apachePath}/resources/assets/img/btn_search2.png" onclick="openModal();" class="kepco-ser-icon"/>
											</div>
										</td>
										<td class="left">가상서버</td>
										<td>
											<div class="search-box">
												<input class="form-control w95" type="text"  name="vmName" id="vmName" readonly="readonly"/>
												<input type="hidden"  name="vmUuid" id="vmUuid" />
												<%-- <img src="${apachePath}/resources/assets/img/icon_search.png"onclick="openModal2();" name="vmBtn" id="vmBtn" class="input_search"/> --%>
											    <img src="${apachePath}/resources/assets/img/btn_search2.png" onclick="openModal2();" class="kepco-ser-icon"/>
											</div>
										</td>
									</tr>
									<tr>
									   <td class="left">서비스명</td>
									  	<td colspan="3">
									  	   	<input maxlength="60" class="form-control" type="text"  name="productName" id="productName" />
									  		<!--<a type="button" class="check_btn vm" onclick="productNameChk();"> <i class="fa fa-check"></i> 중복확인</a>-->
									  	</td>
									</tr>
									<tr>
									    <td class="left">추가 요청사항</td>
										<td colspan="3">
											<textarea style="width:100%;height:200px;" name="description" id="description"><c:if test="${getCatalogueServiceView.serviceType eq '09'}">1.WAS 호스트명 : &#10;2. DB캐릭터셋 :  하기사항 중 택1 &#10; - AL32UTF8(기본) &#10; - KO16MSWIN949 &#10;3. DB계정명 : &#10;4. 용량(GB) &#10; 1) 테이블 : &#10; 2) 인덱스 : (일반적으로 테이블 용량 10%)&#10;※테이블 용량 신청 전 K-Cloud 담당자 사전 연락 필요</c:if>
<c:if test="${getCatalogueServiceView.serviceType eq '03'}">백업 디렉토리 위치 : </c:if></textarea>
										</td>
									</tr>
								</c:if>
								<c:if test="${getCatalogueServiceView.serviceType eq 'ASCL'}">
									<tr>
										<td class="left">클러스터</td>
										<td>
											<div class="searchBoxArea ">
												<label class="selectBoxDrop" for=cloudInfo>클라우드</label>
												<select class="search-sel" name="cloudInfo" id="cloudInfo" onChange="selectCloud();">
													<option value="">대역선택</option>
													<c:forEach items="${cloudList}" var="cloudList" varStatus="status">
														<c:if test="${cloudList.cloudType == 'openshift'}">
															<option value="${cloudList.cloudId}" data-cloud="${cloudList.cloudId}" data-type="${cloudList.cloudType}" data-name="${cloudList.cloudName}">${cloudList.cloudName}</option>
														</c:if>
													</c:forEach>
												</select>
											</div>
										</td>
										<td class="left">프로젝트명</td>
										<td>
											<div class="search-box" style="max-width:100%;">
												<input class="form-control " type="text" name="projectAlias" id="projectAlias" readonly="readonly"/>
												<input class="form-control" type="hidden" name="projectName" id="projectName" />
												<input type="hidden" name="projectBoxId" id="projectBoxId" value="" />
												<input type="hidden" name="projectId" id="projectId" value="" />
												<img src="${apachePath}/resources/assets/img/btn_search2.png" height=32px;  onclick="openModal();" class="kepco-ser-icon"/>
											</div>
										</td>
									</tr>
									<tr>
										<td class="left">어플리케이션</td>
										<td>
											<div class="search-box" style="max-width:100%;">
												<input class="form-control " type="text"  name="appName" id="appName" readonly="readonly"/>
												<input type="hidden" name="appUuid" id="appUuid" value=""/>
											    <img src="${apachePath}/resources/assets/img/btn_search2.png" onclick="openModalApp();" class="kepco-ser-icon"/>
											</div>
										</td>
									    <td class="left">서비스명</td>
									  	<td>
									  	   	<input maxlength="60" class="form-control" type="text"  name="productName" id="productName" />
									  	</td>
									</tr>
									<tr>
										<td class="left" scope="row">Scale-Out 구분</td>
										<td>
											<div class="searchBoxArea">
												<label class="selectBoxDrop" for="scaleOutSeq">OS 선택</label>
												<select class="search-sel" name="hpaDivision" id="hpaDivision">
													<option value="" selected="selected">Scale-Out 선택</option>
											 		<option value="cpu">CPU</option>
											 		<option value="memory">메모리</option>
												</select>
											</div>
										</td>

									<td class="left" scope="row">개발/운영</td>
									<td>
										<div class="searchBoxArea">
											<label class="selectBoxDrop" for=cloudInfo>선택</label>
                                                        <select class="search-sel form-select" name="envType" id="envType">
												<option value="">선택</option>
												<c:forEach items="${cmmCode}" var="cmmCode" varStatus="status">
													<c:if test="${cmmCode.parentCodeId eq 'ENV_TYPE' and cmmCode.codeId eq 'DEV'}">
														<option value="${cmmCode.codeId}">${cmmCode.codeName}</option>
													</c:if>
													<c:if test="${cmmCode.parentCodeId eq 'ENV_TYPE' and cmmCode.codeId eq 'PROD'}">
														<option value="${cmmCode.codeId}">${cmmCode.codeName}</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
									</td>

									</tr>
									<tr>
										<td class="left">임계값</td>
										<td>
											<div class="flex align-center">
												<input class="form-control w138" type="text" value="80" maxlength="5" name="hpaMax" id="hpaMax" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="diskchange(this);" /> <p class="inputUnit">%</p>
												<img src="/resources/assets/img/icon_minus.png"  onclick="hpaminus('hpaMax');" class="minus"/><span id="hpaMaxCnt" class="snemo">1</span>
												<img src="/resources/assets/img/icon_plus.png" onclick="hpaplus('hpaMax');" class="plus"/>
												<p class="inputUnit">%</p>
											</div>
										</td>
										<td class="left">지속시간</td>
										<td>
											<div class="flex align-center">
												<input class="form-control w138" type="text" value="5" maxlength="5" name="hpaContinue" id="hpaContinue" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="diskchange(this);" /> <p class="inputUnit">분</p>
												<img src="/resources/assets/img/icon_minus.png"  onclick="hpaminus('hpaContinue');" class="minus"/><span id="hpaContinueCnt" class="snemo">5</span>
												<img src="/resources/assets/img/icon_plus.png" onclick="hpaplus('hpaContinue');" class="plus"/>
												<p class="inputUnit">분</p>
											</div>
										</td>
									</tr>
									<tr>
										<td class="left">최소 POD</td>
										<td>
											<div class="flex align-center">
												<input class="form-control w138" type="text" value="1" maxlength="5" name="hpaMinPod" id="hpaMinPod" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="diskchange(this);" /> <p class="inputUnit">EA</p>
												<img src="/resources/assets/img/icon_minus.png"  onclick="hpaminus('hpaMinPod');" class="minus"/><span id="hpaMinPodCnt" class="snemo">1</span>
												<img src="/resources/assets/img/icon_plus.png" onclick="hpaplus('hpaMinPod');" class="plus"/>
												<p class="inputUnit">EA</p>
											</div>
										</td>
										<td class="left">최대 POD</td>
										<td>
											<div class="flex align-center">
												<input class="form-control w138" type="text" value="1" maxlength="5" name="hpaMaxPod" id="hpaMaxPod" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="diskchange(this);" /> <p class="inputUnit">EA</p>
												<img src="/resources/assets/img/icon_minus.png"  onclick="hpaminus('hpaMaxPod');" class="minus"/><span id="hpaMaxPodCnt" class="snemo">1</span>
												<img src="/resources/assets/img/icon_plus.png" onclick="hpaplus('hpaMaxPod');" class="plus"/>
												<p class="inputUnit">EA</p>
											</div>
										</td>
									</tr>
									<tr>
										<td class="left">증가 POD</td>
										<td colspan="3">
											<div class="flex align-center">
												<input class="form-control w138" type="text" value="1" maxlength="5" name="hpaIncrePod" id="hpaIncrePod" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="diskchange(this);" /> <p class="inputUnit">EA</p>
												<img src="/resources/assets/img/icon_minus.png"  onclick="hpaminus('hpaIncrePod');" class="minus"/><span id="hpaIncrePodCnt" class="snemo">1</span>
												<img src="/resources/assets/img/icon_plus.png" onclick="hpaplus('hpaIncrePod');" class="plus"/>
												<p class="inputUnit">EA</p>
											</div>
										</td>
									</tr>
								</c:if>
								</tbody>
							</table>
						</form>
					</div>
					<div class="btn_area">
						<a type="button" class="btn_navy"  onclick="openApproveReviewModal();">신청</a>
						<a type="button" class="btn_dngrey ml10" onclick="basketorder();">일괄신청</a>
<!-- 						<a type="button" class="btn_lgrey ml10" onclick="moveListPage();"> 취소</a> -->
					</div>
				</div>
			</div>
			<!---- end page body---->


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
	             			<a type=button class="m_btn_navy" data-dismiss="modal" onclick="noworder();">확인</a>
	             			<a type=button class="m_btn_white ml10" data-dismiss="modal">취소</a>
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
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'><span></span></button>
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
										<div class="search-box">
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
							<div class="listArea" id="popListReviewTable" style="display: none;"></div>
                      		<div class="totalcnt" id="totalReviewCnt">총 0 건</div>
	                   	</div>
	                   	<div class="modal-footer tac">
                       		<a type="button" class="m_btn_navy" data-dismiss="modal" >닫기</a>
                       	</div>
	               	</div>
				</div>
           	</div>
			<!-- #modal-dialog -->

			<!-- 프로젝트 승인자 결재자 지정 팝업 -->
			<!-- #modal-dialog -->
			<div class="modal fade" id="user-modal-approve-dialog">
               <div class="modal-dialog">
                   <div class="modal-content w560">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'><span></span></button>
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
                       		<a type="button" class="m_btn_navy" data-dismiss="modal" >닫기</a>
                       	</div>
	               	</div>
				</div>
           	</div>
			<!-- #modal-dialog -->
			<!-- 결재자 지정 끝 -->




				<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog width-720">
	                   <div class="modal-content width-720">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">프로젝트명</h4>
	                       </div>
	                       <div class="modal-body">

								<!-- 2023 new search-->
									    <div class="col-xs-12 bgee modalpop mb20">
										 <div class="new-search-modal">
								           <div class="left">
									         <div class="choice-kepco">
											  <div class="select-kepco" for="searchKind">
											    <button class="kep-label"  id="searchKind">전체 </button>
											    <ul class="optionList">
											      <li class="optionItem" value="searchAll">전체</li>
											      <li class="optionItem" value="project_name">프로젝트ID</li>
											      <li class="optionItem" value="project_alias">프로젝트명</li>
											    </ul>
											  </div>
											</div>
											</div>

											<div class="right">
					                          <input type="text" class="input-kepco-s" placeholder="검색어를 입력하세요." id="searchKeyword" onkeypress="if(event.keyCode==13)projectPopList();" />
					                          <button type="button" class="kepco-ser-icon-modal2 vm" onclick="projectPopList();"></button>
					                         </div>
				                          </div>
				                          </div>
								<!--  2023 new search END -->




									<div class="popListTable">
										<table class="tableV">
											<colgroup>
												<col width="30%">
										 		<col width="*">
										 		<col width="15%">
										 	</colgroup>
										 	<thead>
										 	<tr class="skyblue">
									 			<th class="tac">프로젝트ID</th>
												<th class="tac">프로젝트명</th>
												<th class="tac">적용</th>
											</tr>
									 	   </thead>
											<tbody id="popListTable">
											</tbody>
										</table>
									</div>

	                      	</div>
	                       	<div class="clear"></div>
	                       	<div class="modal-footer tac">
	                   			<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="okProjectInsert();">확인</a>
	                   			<a type="button" class="m_btn_white ml10" data-dismiss="modal" onclick="">취소</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
				<!-- #modal-dialog 가상서버검색-->
                <div class="modal fade" id="modal-dialog2">
	               <div class="modal-dialog width-720">
	                   <div class="modal-content width-720">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">가상서버 검색</h4>
                           </div>
                           <div class="modal-body">

											<!-- 2023 new search-->
	                       	 <div class="col-xs-12 bgee modalpop mb20">
		                       		<div class="selectBoxAr col-xs-2">
										<label class="selectText" for="vmSearchKind">전체</label>
										<select class="search-sel" id="vmSearchKind">
										<option value="searchAll">전체</option>
										<option value="hostname_alias">서버명</option>
										<option value="hostname">호스트명</option>
										</select>
									</div>
										<div class="search-box">
											<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="vmSearchKeyword" onkeypress="if(event.keyCode==13)gridVMList();">
											<button type="button" class="btn_search2 vm" onclick="gridVMList();"><span></span></button>
										</div>
								</div>

										   <div class="popListTable">
											<table class="tableV" id="VM-list">
											 <colgroup>
											 <col width="*">
											 <col width="*">
											 <col width="80px">
											 </colgroup>
											 <thead>
											 <tr class="skyblue">
												 <th class="tac">호스트명</th>
												 <th class="tac">서버명</th>
												 <th class="tac">적용</th>
											 </tr>
											 </thead>
											 <tbody id="popListTable2">

											 </tbody>
											 </table>
											 </div>
                                        </div>
										<div class="clear"></div>
										<div class="modal-footer tac">
				                   			<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="okVMInsert();">확인</a>
				                   			<a type="button" class="m_btn_white ml10" data-dismiss="modal" onclick="">취소</a>
				             </div>
                    	</div>
                    </div>
            	</div>

            	<div class="modal fade" id="modal-dialog-app">
            		<div class="modal-dialog width-720">
	                   <div class="modal-content width-720">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">어플리케이션 검색</h4>
                           </div>

                           <div class="modal-body">
								<div class="col-xs-12 bgee modalpop mb20">
									<div class="selectBoxAr col-xs-2">
										<label class="selectText" for="appSearchKind">전체</label>
										<select class="search-sel" id="appSearchKind">
										<option value="searchAll">전체</option>
										<option value="appName">어플리케이션ID</option>
										<option value="appAlias">어플리케이션명</option>
										</select>
									</div>
									<div class="search-box">
										<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="appSearchKeyword" onkeypress="if(event.keyCode==13)gridAppList();">
										<button type="button" class="btn_search2 vm" onclick="gridAppList();"><span></span></button>
									</div>
								</div>

								<div class="popListTable">
									<table class="tableV" id="APP-list">
										<colgroup>
											<col width="40%">
											<col width="40%">
											<col width="20%">
										</colgroup>
										<thead>
											<tr class="skyblue">
												<th class="tac">어플리케이션ID</th>
												<th class="tac">어플리케이션명</th>
												<th class="tac">적용</th>
											</tr>
										</thead>
										<tbody id="popListTable2">

										</tbody>
									</table>
								</div>
                           </div>
                           <div class="clear"></div>
                           <div class="modal-footer tac">
								<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="okAppInsert();">확인</a>
								<a type="button" class="m_btn_white ml10" data-dismiss="modal" onclick="">취소</a>
				           </div>
                       </div>
                    </div>
            	</div>

			<!-- #modal-dialog  가상서버 검색//-->
			<!-- #modal-dialog 구매 확인-->
             <div class="modal fade pdManage" id="modal-dialog3">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">신청확인</h4>
                           </div>
                           <div class="modal-body">
								<table class="tableE" id="reqConfirmTable">
									<colgroup>
										<col width="120px"/>
										<col width="*"/>
										<col width="120px"/>
										<col width="*"/>
									</colgroup>
									<tbody>
									<tr>
										<th class="tal">프로젝트명</th>
										<td colspan="3"><span id="pop_projectAlias"></span> <img src="${cloudImgPath}" class="w12"/><span class="cnt">${cloudName}</span></td>
									</tr>
									<c:if test="${getCatalogueServiceView.serviceType ne 'ASCL'}">
									<tr>
										<th class="tal">가상서버</th>
										<td colspan="3" id="pop_vmName"></td>
									</tr>
									</c:if>
									<tr>
										<th class="tal">서비스유형 </th>
										<td id="pop_serviceTypeName"></td>
										<th class="tal">희망일시  </th>
										<td id="pop_onDemandFlag"> </td>
									</tr>
									<tr>
										<th class="tal">서비스명 </th>
										<td colspan="3" id="pop_productName"></td>
									</tr>
									<tr>
										<th class="tal">요청유형  </th>
										<td colspan="3">신규 </td>
									</tr>
									<tr>
										<th class="tal">요청내용 </th>
										<td colspan="3">
										<textarea readonly id="pop_description"></textarea>
										</td>
									</tr>
									</tbody>
								</table>

								<p class="commnet fc-red">위 내용으로 신청 하시겠습니까?</p>

                           </div>
						   <div class="clear"></div>
                           <div class="modal-footer tac">
	                   			<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="request_noworder();">확인</a>
	                   			<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
	                       </div>
                       </div>
                </div>
            </div>
			<!-- #modal-dialog  구매 확인//-->
            <!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
		//결재라인 관련 변수
		var currentApprovalLine = "";
		var approvalList = [];

		//서비스 자원 입력시 중복체크 flag
		$("#productName").keypress(function(){
			$("#confirmFlag").val("N");
		});

		//서비스 자원명 중복체크
		function productNameChk(){

			if($("#productName").val()==""){
				alertBox3("서비스 자원명을 입력하세요");
				return false;
			}

			$.ajax({
				url : "${contextPath}/mbr/req/catalogue/productNameChk",
				data : {
					"productName" : $("#productName").val()
				},
				success : function(data) {
					var chkVal = data;

					if(chkVal==0){
						$("#confirmFlag").val("Y");
						alertBox3("사용가능한 서비스 자원명<br>입니다.");

					}else{
						$("#confirmFlag").val("N");
						alertBox3("사용할 수 없는 서비스 자원명 <br> 입니다.");

					}
				},
				error : function(request, status, error) {
					alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
				}
			});

		}

		// 결재자 지정 시작
		function openApproveReviewModal(){

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

			if($("#productName").val()==""){
				alertBox3("서비스 자원명을 입력하세요");
				return false;
			}

			 if($("#vmName").val()==""){
				alertBox3("가상서버를 입력하세요");
				return false;
			}

			if($("#hpaDivision").val()==""){
				alertBox3("Scale-Out 구분을 설정하세요.");
				return false;
			}
			if($("#appUuid").val()==""){
				alertBox3("어플리케이션을 설정하세요.");
				return false;
			}
			if($("#autoScaleOut").val()!="0") {
				alertBox3("오토스케일이 이미 등록되어 있습니다.");
				return false;
			}


		    /*if($("#confirmFlag").val() == "N"){
				alertBox3("서비스 자원명 중복을 확인하세요.");
				return false;
			} */
		 	if($("#apprvPass").val() == "Y"){
				confirmBox4("결재자를 지정하시겠습니까?",approvSelect,nApprovSelect);
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

		function openApproveModal(){

			$("#user-modal-approve-dialog").modal();
			 gridPopApproveList();
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

		var totalCnt = 0;
		// 결재자 등록 팝업 리스트
		function gridPopList(){
			$.ajax({
				url : "${contextPath}/mbr/operation/approveUser/addProjectApproveList",
				dataType : "JSON",
				data : {
					"searchKind": $("#reviewSearchKind option:selected").val()
					, "keyword"	: $("#reviewUserId").val()
					, "cloudId" : $("#cloudId").val()
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

		var totalCnt = 0;
		// 검토자 등록 팝업 리스트
		function gridPopApproveList(){
			$.ajax({
				url : "${contextPath}/mbr/operation/approveUser/addProjectApprove2List",
				dataType : "JSON",
				data : {
					"searchKind": $("#approveSearchKind option:selected").val()
					, "keyword"	: $("#approveUserId").val()
				},
				success : function(req) {
					if(req.data.length == 0){
						$("#popListApproveTable").hide();
						$("#popListApproveTable2").show();
					}else{
						$("#popListApproveTable").empty();

						$.each(req.data, function(key,val){
							$("#popListApproveTable").append(
									'<tr>'
									+'<td class="tac">'+val.upDeptName+'/'+val.deptName+'</td>'
									+'<td class="tac">'+val.userId+'</td>'
									+'<td class="tac">'+val.userLevel+'</td>'
									+'<td class="tac">'+val.userName+'</td>'
									+'<td class="tac">'+val.userConditionText+'</td>'
									+'<td class="tac"><input type="button"  value="&#xf00c" class="popCheckbtn" onclick="updateApprove(this, \''+val.userId+'\', \''+val.userName+'\');" initModal();></td>'
									+'<tr/>'
								    );

						});
						$("#popListApproveTable").show();
						$("#popListApproveTable2").hide();
					}
					totalCnt = req.data.length;
					$("#totalApproveCnt").text("총 "+totalCnt+" 건");
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

			/* if($("#hidden_login_user_id").val() ==userId) {
				alertBox("신청자는 본인을<br>결재자로 지정할수 없습니다.");
				return false;
			} */
			var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
			if( tmpCurrentApprovalStep > 1 && approvalList[tmpCurrentApprovalStep-2] != undefined) {
				if( approvalList[tmpCurrentApprovalStep-2].userLevelCode < userLevelCode) {
					alertBox("이전단계보다 같거나 높은 직급의 담당자를 선택하세요");
					return false;
				}
			}

			$("#popListReviewTable > tr").find("input").removeClass("active");
			$(e).toggleClass("active");

			var tmpValue = { "userId" : userId, "deptName" : deptName, "userName" : userName, "userLevel" : userLevel, "userLevelCode" : userLevelCode }

			$("#"+currentApprovalLine.id+"_userId").text(userId);
			$("#"+currentApprovalLine.id+"_userLevel").text(userLevel);
			$("#"+currentApprovalLine.id+"_userName").text(userName);

			approvalList[tmpCurrentApprovalStep-1] = tmpValue;

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


		// 결재자 지정 끝


		function applyTimePlus(){
		//		alert($("#applyTime").val());

			if($("#applyTime").val()=="23"){
				alertBox3("시간을 정확히 입력해 주세요.");
			}else{
				var applyTime;
				applyTime = Number(rtnnumber($("#applyTime").val())) + 1;
				$("#applyTime").val(applyTime);
			}
		}
		function applyTimeMinus(){
			if($("#applyDate").val() == $.datepicker.formatDate('yy-mm-dd', new Date())){
				if($("#applyTime").val() < ((new Date()).getHours())+2){
					alertBox3("현재일시보다 빠를수는 업습니다.");
					return false;
				}
			}
			if($("#applyTime").val()=="0"){
				alertBox3("시간을 정확히 입력해 주세요.");
			}else{
				var applyTime;
				applyTime = Number(rtnnumber($("#applyTime").val())) - 1;
				$("#applyTime").val(applyTime);
			}
		}

		function openModalApp(){
			$("#modal-dialog-app").modal();
			gridAppList();
		}

		function gridAppList(){
			$("#APP-list").dataTable( {
				"processing": true
				,"autoWidth": false
				,"serverSide": true
				,"ordering": false
				,"destroy" : true
				,"ajax": {
					"url":"${wasPath}/mbr/oss/app/catalogueAppList"
					,"type" : "GET"
					,"data":function (d) {
// 						d.searchKind = $("#vmSearchKind option:selected").val();
// 						d.keyword = $("#vmSearchKeyword").val();
						d.projectName = $("#projectName").val();
						d.projectBoxId = $("#projectBoxId").val();
					}
				}
				,"columns":[
					{"data":"appNameSpace" , "class":"tac"}
					, {"data":"appAlias" , "class":"tac"}
					, {"class":"tac"}
				]
				,"columnDefs":[
					{"defaultContent" : "", targets:"_all" }
					, {"targets":[2], "render": function(data,type,full){
						return '<div class="tac"><a href="#nav-pills-tab-3-view" data-toggle="tab"><input type="button" class="popCheckbtn"  value="&#xf00c" onclick="setApp(this, \''+full.appUid+'\',\''+full.appAlias+'\',\''+full.appName+'\',\''+full.projectBoxId+'\',\''+full.pod+'\')"></a></div>';
						}
					}
				]
				,"language": {
					"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
				}
				,"sDom":'<"top">rt<"bottom"pi>'
			});
		}

		function setApp(e, appUid, appName, appAlias, projectBoxId, pod){
			$("#popListTable2 > tr").find("input").removeClass("active");
			$(e).toggleClass("active");
			hprojectBoxId = projectBoxId;
			hvmUuid = appUid;
			hvmName = appName;
			hvmHost = appAlias;
			hvmPod = pod;
		}

		function okAppInsert(){
			$("#appUuid").val(hvmUuid);
			$("#appName").val(hvmName);
			$("#projectBoxId").val(hprojectBoxId);
			$("#productName").val(hvmName + " : ${getCatalogueServiceView.displayName} ").removeAttr("readonly").focus();
			$('#pod').val(hvmPod);
			$('#hpaMinPodCnt').val(hvmPod);
			$('#hpaMaxPodCnt').val(Number(hvmPod)+1);

			getAutoScaleOutCnt();
		}

		function openModal2(){
			$("#modal-dialog2").modal();
			gridVMList();
		}

		// 팝업리스트
		function gridVMList(){
			$("#VM-list").dataTable( {
				"processing": true
				,"autoWidth": false
				,"serverSide": true
				,"ordering": false
				,"destroy" : true
				,"ajax": {
					"url":"${wasPath}/mbr/oss/vm/catalogueVmlist"
					,"type" : "GET"
					,"data":function (d) {
						d.searchKind = $("#vmSearchKind option:selected").val();
						d.keyword = $("#vmSearchKeyword").val();
						d.projectName = $("#projectName").val();
						d.projectBoxId = $("#projectBoxId").val();
						d.projectId = $("#projectId").val();
					}
				}
				,"columns":[
					{"data":"hostname"}
					, {"data":"hostnameAlias"}
					, {"class":"tac"}
				]
				,"columnDefs":[
					{"defaultContent" : "", targets:"_all" }
					, {"targets":[2], "render": function(data,type,full){
						return '<div class="tac"><a href="#nav-pills-tab-3-view" data-toggle="tab"><input type="button" class="popCheckbtn"  value="&#xf00c" onclick="setVM(this, \''+full.vmUuid+'\',\''+full.hostnameAlias+'\',\''+full.hostname+'\',\''+full.projectBoxId+'\',\''+full.projectId+'\')"></a></div>';
						}
					}
	 				//, {"targets":[4], "render": function(data,type,full){
					//	return '<div class="col-md-12 tar"><a href="#nav-pills-tab-3-view" data-toggle="tab"><button type="button" data-dismiss="modal" class="btn btn-primary" onclick="setVM(\''+full.vmUuid+'\',\''+full.hostnameAlias+'\')">적용</button></a></div>';
					//}
					//}
				]
				,"language": {
					"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
				}
				,"sDom":'<"top">rt<"bottom"pi>'
			});
		}

		//modal팝업 open
		function openModal(){
			$("#modal-dialog").modal();
			projectPopList();
		}


		function projectPopList(){

			var keyword = $("#searchKeyword").val();
			var cloudId = $("#cloudId").val();
			$.ajax({
				url : "${wasPath}/mbr/req/catalogue/projectPopList",
				dataType : "JSON",
		//			type : "POST",
				data : {
					"cloudId" : cloudId,
					"searchValue" : keyword
				},
				success : function(data) {
					var projectList = data.getProjectList;

					if(projectList!=""){

						$("#popListTable > tr").remove();
						$.each(projectList,function(key,val){

							var Html="";

		// 					Html="<tr><td class='tac'>"+val["projectName"]+"</td>";
							Html="<tr>";
							Html = Html + "<td class='tac'>"+val["projectName"]+"</td>";
							Html = Html + "<td class='tac'>"+val["projectAlias"]+"</td>";
							Html = Html + "<td class='tac'><input type='button' class='popCheckbtn'  value='&#xf00c' onclick='updateProject(this, \""+val["projectBoxId"]+"\", \""+val["projectId"]+"\", \""+val["projectName"]+"\", \""+val["projectAlias"]+"\" , \""+val["envType"]+"\")'></td>";

							Html = Html + "</tr>";

							$("#popListTable").append(Html);

						});
					}else{
						$("#popListTable > tr").remove();

						var Html="";

						Html="<tr><td class='tac' colspan='3'>검색된 프로젝트가 없습니다.</td>";
						Html = Html + "</tr>";

						$("#popListTable").append(Html);
					}

					$('#popListTable tr:odd').addClass('even');
					$('#popListTable tr:even').addClass('odd');

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

		var hprojectName, hprojectBoxId, hprojectId, hprojectAlias, hvmUuid, hvmName, hvmHost, hvmPod;

		function updateProject(e, projectBoxId, projectId, projectName,projectAlias){
			$("#popListTable > tr").find("input").removeClass("active");
			$(e).toggleClass("active");
			hprojectBoxId = projectBoxId;
			hprojectId 		= projectId;
			hprojectName = projectName;
			hprojectAlias = projectAlias;
			hvmUuid = "";
			hvmName = "";
			hvmHost = "";

// 			getAppCnt();
		}

		function okProjectInsert(){
			$("#projectName").val(hprojectName);
			$("#projectBoxId").val(hprojectBoxId);
			$("#projectId").val(hprojectId);
			$("#projectAlias").val(hprojectAlias);
			$("#vmUuid").val(hvmUuid);
			$("#vmName").val(hvmName);
			$("#vmHost").val(hvmHost);
			$("#vmBtn").show();
		}

		function setVM(e, vmUuid, vmName, vmHost,projectId){
			$("#popListTable2 > tr").find("input").removeClass("active");
			$(e).toggleClass("active");
			hprojectId = projectId;
			hvmUuid = vmUuid;
			hvmName = vmName;
			hvmHost = vmHost;
		}

		function okVMInsert() {
			$("#vmUuid").val(hvmUuid);
			$("#vmName").val(hvmName);
			$("#vmHost").val(hvmHost);
// 			$("#projectId").val(hprojectId);
// 			$("#projectBoxId").val(hprojectBoxId);
			$("#productName").val(hvmName + " : ${getCatalogueServiceView.displayName} ").removeAttr("readonly").focus();

		}

		function request_noworder() {
			//$("#catalogueform").submit();

			if( approvalList[0] == undefined || approvalList[0] == null) {
				var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
				approvalList[0] = tmp;
			}
			$("#approvalStepListString").val(JSON.stringify(approvalList));

			var type = $("#catalogueform").attr("type");
			var url = $("#catalogueform").attr("action");
			var data = $("#catalogueform").serialize();
			var data = data + "&amount=" + rtnnumber($("#totalPrice").val());

			$.ajax({
				url:url,
				type:type,
				data:data,
				beforeSend : function(xhr, opts) {
					setLodingFun.blocksFun();
				},
				complete : function() {
					setLodingFun.nonesFun();
				},
				success:function(data){
					if(data == "1"){
						alertBox("신청이 완료 되었습니다.", orderok2);
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

		function orderok2(){
			location.href="${wasPath}/mbr/req/catalogue/bssOrderList";
		}

		// 디스크 가격
		function diskplus(){
			//alert($("#diskcnt").val());
			if(Number($("#diskcnt").val())>=10000){
				alertBox3("디스크는 10,000GB 이상<br/>신청하실수 없습니다.");
				$("#diskcnt").val($("#imdiskcnt").val());
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").empty();
				$("#totalpriceview").append($("#totalPrice").val());
			}else{
				var diskcnt;
				var diskprice;
				var imamount;
				//alert($("#diskprice").val());
				diskcnt = Number(rtnnumber($("#diskcnt").val())) + 10;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
				//alert(Number(rtnnumber($("#diskprice").val()))/10);
				imamount = Number(rtnnumber($("#imamount").val()))+Number(rtnnumber($("#diskprice").val()))/10;
				//alert(addcomma(diskprice));
				$("#diskcnt").val(diskcnt);
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
				$("#imdiskprice").val(diskprice);
				$("#imdiskcnt").val($("#diskcnt").val());

			}

		}

		function diskminus(){
			//alert($("#diskcnt").val());
			if(Number($("#diskcnt").val())<=10){
				alert("디스크는 최소 10GB 이상<br/>신청하셔야 합니다.");
				$("#diskcnt").val($("#imdiskcnt").val());
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").empty();
				$("#totalpriceview").append($("#totalPrice").val());
			}else{
				var diskcnt;
				var diskprice;
				var imamount;
				//alert($("#diskprice").val());
				diskcnt = Number(rtnnumber($("#diskcnt").val())) - 10;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
				//alert(Number(rtnnumber($("#diskprice").val()))/10);
				imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#diskprice").val()))/10;
				//alert(addcomma(diskprice));
				$("#diskcnt").val(diskcnt);
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
				$("#imdiskprice").val(diskprice);
				$("#imdiskcnt").val($("#diskcnt").val());
			}
		}

		function diskfocusout(id){
			//alert(id);
			var diskcnt;
			diskcnt = Number($(id).val());
			//alert(diskcnt);
			if(diskcnt<10){
				alertBox3("디스크는 최소 10GB 이상<br/>신청하셔야 합니다.");
				$(id).val($("#imdiskcnt").val());
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").empty();
				$("#totalpriceview").append($("#totalPrice").val());
			}else if(diskcnt>10000){
				alertBox3("디스크는 10,000GB 이상<br/>신청하실수 없습니다.");
				$(id).val($("#imdiskcnt").val());
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").empty();
				$("#totalpriceview").append($("#totalPrice").val());
			}else{
				var imdiskcnt = diskcnt % 10;
				if(imdiskcnt==0){
					var diskprice;
					var imamount;
					diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100; // 디스크가격
					//alert(diskprice);
					//alert($("#imdiskprice").val());
					imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
					imamount =  imamount + diskprice ; //총가격에 디스크 가격 추가

					//alert(imamount);

					$("#imdiskcnt").val($(id).val());
					$("#imdiskprice").val(diskprice);
					$("#diskpriceview").empty();
					$("#diskpriceview").append(addcomma(diskprice));
					$("#imamount").val(addcomma(imamount));
					$("#totalpriceview").empty();
					$("#totalpriceview").append(addcomma(imamount));
					$("#totalPrice").val(addcomma(imamount));
				}else{
					alertBox3("디스크는 10GB 단위로<br/>신청하실수 있습니다.");
					$(id).val($("#imdiskcnt").val());
					$("#diskpriceview").empty();
					$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
					$("#totalpriceview").empty();
					$("#totalpriceview").append($("#totalPrice").val());
				}

			}
		}

		function diskchange(id){
			//alert($(id).val());
			var diskval = $(id).val();
			//alert(diskval.length);
			if(diskval.length>2){
				var diskprice;
				var imamount;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100;
				imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
				imamount =  imamount + diskprice ;
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
			}else{
				var imdiskcnt = Number(diskval) % 10;
				if(imdiskcnt==0){
					var diskprice;
					var imamount;
					diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100;
					imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
					imamount =  imamount + diskprice ;
					$("#diskpriceview").empty();
					$("#diskpriceview").append(addcomma(diskprice));
					$("#totalpriceview").empty();
					$("#totalpriceview").append(addcomma(imamount));
				}
			}

		}

		function diskOrderView(){

			//alert($("input[name='hourlyFlag']:checked").val());
			var productSeq = "${getCatalogueSelectView.productSeq}";
			var hourlyFlag = $("input[name='hourlyFlag']:checked").val();
			var diskcnt = $("#diskcnt").val();

			$.ajax({
				url : "${wasPath}/mbr/req/catalogue/getcatalogueDiskOrderView",
				dataType : "JSON",
		//			type : "POST",
				data : {
					"productSeq" : productSeq
					,"hourlyFlag" : hourlyFlag
					,"diskcnt" : diskcnt
				},
				success : function(data) {
					//alert(data.productSeq);
					//alert(diskcnt);

					if(hourlyFlag=="N"){
						//월 금액
						//var totalPrice = data.diskMonthlyPrice * data.diskGb / 10;
						var totalPrice = data.diskMonthlyPrice * diskcnt / 10;
						var diskprice = data.diskMonthlyPrice * 10;
						var diskprice1 = data.diskMonthlyPrice * diskcnt / 10;

						$("#diskpriceview").empty();
						$("#diskpriceview").append(addcomma(diskprice1));
						$("#totalpriceview").empty();
						$("#totalpriceview").append(addcomma(totalPrice));

						$("#totalPrice").val(totalPrice);
						$("#diskprice").val(diskprice);
						$("#diskprice1").val(diskprice1);
						$("#imdiskprice").val(diskprice1);
						$("#imdiskcnt").val(diskcnt);
						$("#imamount").val(totalPrice);
						$("#amount").val(totalPrice);
						//$("#diskpriceview").empty();
						//$("#diskpriceview").append(addcomma(diskprice));
						//$("#totalpriceview").empty();
						//$("#totalpriceview").append(addcomma(imamount));
						//$("#totalPrice").val();
					}else{
						//시간 금액
						var totalPrice = data.diskHourlyPrice * diskcnt / 10;
						var diskprice = data.diskHourlyPrice * 10;
						var diskprice1 = data.diskHourlyPrice * diskcnt / 10;

						$("#diskpriceview").empty();
						$("#diskpriceview").append(addcomma(diskprice1));
						$("#totalpriceview").empty();
						$("#totalpriceview").append(addcomma(totalPrice));

						$("#totalPrice").val(totalPrice);
						$("#diskprice").val(diskprice);
						$("#diskprice1").val(diskprice1);
						$("#imdiskprice").val(diskprice1);
						$("#imdiskcnt").val(diskcnt);
						$("#imamount").val(totalPrice);
						$("#amount").val(totalPrice);


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

			//구매전 확인 팝업
		function setOrder() {

			$("#pop_projectAlias").text($("#projectAlias").val());
			$("#pop_hostnameAlias").text(hvmHost);
			$("#pop_hostname").text(hvmName);

			if($("#serviceType").val() == '01'){
				$("#pop_serviceTypeName").text('계정관리');
			}else if($("#serviceType").val() == '02'){
				$("#pop_serviceTypeName").text('보안관제');
			}else if($("#serviceType").val() == '03'){
				$("#pop_serviceTypeName").text('백업');
			}else if($("#serviceType").val() == '04'){
				$("#pop_serviceTypeName").text('SW설치');
			}else if($("#serviceType").val() == '05'){
				$("#pop_serviceTypeName").text('디스크관리');
			}else if($("#serviceType").val() == 'ASCL'){
				$("#pop_serviceTypeName").text('오토스케일링');
			}

			if ($("input[name='onDemandFlag']:checked").val() == 'N') {
				$("#pop_onDemandFlag").text($("#applyDate").val()+' '+$("#applyTime").val()+':00');
			} else if ($("input[name='onDemandFlag']:checked").val() == 'Y') {
				$("#pop_onDemandFlag").text('승인 완료 후 생성');
			}

			$("#pop_description").html($("#description").val());
			$("#pop_productName").text($("#productName").val());
			$("#pop_vmName").text($("#vmName").val());

			$("#pop_diskName").text($("#diskName").val());
			$("#pop_diskcnt").text($("#diskcnt").val()+' GB');
			$("#pop_totalPrice").text($("#totalPrice").val());

			if($("#serviceType").val() === "ASCL"){

				var makeHtml = "";
				var makeTitleHtml = "";

				makeTitleHtml += "<tr><th class='tal'>어플리케이션명 </th><td id='pop_appName'></td><th class='tal'>개발/운영</th><td id='pop_envType'></td></tr>";

				makeHtml += "<tr><th class='tal'>Scale-Out 구분 </th><td id='pop_hpaDivision'></td>";
				makeHtml += "<th class='tal'>임계값 </th><td id='pop_hpaMax'></td></tr>";

				makeHtml += "<tr><th class='tal'>지속시간 </th><td id='pop_hpaContinue'></td>";
				makeHtml += "<th class='tal'>최소 POD </th><td id='pop_hpaMinPod'></td></tr>";

				makeHtml += "<tr><th class='tal'>최대 POD </th><td id='pop_hpaMaxPod'></td>";
				makeHtml += "<th class='tal'>증가 POD </th><td id='pop_hpaIncrePod'></td></tr>";

				$("#reqConfirmTable>tbody>tr").eq(1).after(makeHtml);
				$("#reqConfirmTable>tbody>tr").eq(0).after(makeTitleHtml);
				$("#reqConfirmTable>tbody>tr").eq(0).remove();

				$("#pop_appName").text($("#appName").val());
				$("#pop_hpaDivision").text($("#hpaDivision").val());
				$("#pop_hpaMax").text($("#hpaMax").val());
				$("#pop_hpaContinue").text($("#hpaContinue").val());
				$("#pop_hpaMinPod").text($("#hpaMinPod").val());
				$("#pop_hpaMaxPod").text($("#hpaMaxPod").val());
				$("#pop_hpaIncrePod").text($("#hpaIncrePod").val());
				$("#pop_envType").text($("#envType").val());


			}

			if( approvalList[0] == undefined || approvalList[0] == null) {
				var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
				approvalList[0] = tmp;
			}

			$("#approvalStepListString").val(JSON.stringify(approvalList));
		}


			// 바로신청
		function noworder() {
			/*
			if($("#hiddenUserIdReview").val() == ""){
				alertBox3("검토자를 지정해주세요.");
				return false;
			}
			if($("#hiddenUserIdApprove").val() == ""){
				alertBox3("승인자를 지정해주세요.");
				return false;
			}
			*/
			if( (approvalList[3] == undefined || approvalList[3] == null || approvalList[3] == '') && $("#selectApprv").val() == 'N') {
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

			/* if($("#vmName").val()==""){
				alertBox3("가상서버를 입력하세요");
				return false;
			} */

			setOrder();
			//$("#catalogueform").submit();
			$("#modal-dialog3").modal();
		}

		// 일괄신청
		function basketorder(){
			if($("input[name='onDemandFlag']:checked").val()=="N"){
				if($("#applyDate").val()==""){
					alertBox3("서비스희망일시를 입력하세요");
					return false;
				}
				if($("#applyTime > option:selected").val()==""){
					alert("서비스희망일시 시간을 입력하세요");
					return false;
				}
			}
			if($("#productName").val()==""){
				alertBox3("서비스 자원명을 입력하세요");
				return false;
			}

		    /*if($("#confirmFlag").val() == "N"){
				alertBox3("서비스 자원명 중복을 확인하세요.");
				return false;
			}*/

			/* if($("#vmName").val()==""){
				alertBox3("가상서버를 입력하세요");
				return false;
			} */

			$("#totalPrice").val(rtnnumber($("#totalPrice").val()));
			$("#catalogueform").attr('action','basketOrder.do');
			//$("#catalogueform").submit();

 			var params = $('#catalogueform').serialize();
	 		$.ajax({
	 			url : "${wasPath}/mbr/req/catalogue/basketOrder2.do",
	 			dataType : "JSON",
	 			type : "POST",
			    beforeSend : function(xhr, opts) {
	                setLodingFun.blocksFun();
	            },
	            complete : function() {
	                setLodingFun.nonesFun();
	            },
	 			data : params,
	 			success : function(data) {
	 	 			if(data == "2"){
	 	 				alertBox3("장바구니에 다른 프로젝트 신청자원이 존재합니다.");
	 	 	 		} else {
	 	 	 			confirmBox3("일괄신청으로 이동하시겠습니까?", actCatalogueformSubmit);
	 	 	 		}
	 			},
	 			error : function(request, status, error) {
	 				if(request.status == '200'){
	 					alertBox("접속이 만료되었습니다.", logout);
	 				}else{
	 					alertBox3("code:" + request.status + "\n" + "error:" + error);
	 				}
	 			}

	 		})
 		}

		function actCatalogueformSubmit(e){
			//$("#catalogueform").attr('action','basketOrder.do');
			//$("#catalogueform").submit();
			if(e){
				location.href = "${wasPath}/mbr/req/catalogue/basketOrder.do";
			}else{
				location.reload();
			}
		}

		// 목록 페이지이동
		function moveListPage(){
			location.href = "${wasPath}/mbr/req/catalogue/catalogueServiceList.do";
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
			}
		}

		$(document).ready(function(){
		    App.init();
		    initApprovalLine();

			$("a>button").on('click',function(){
			location.href = $(this).closest("a").attr("href");
			});

			var dayName = ['일','월','화','수','목','금','토'];
			var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

				$("#applyDate").datepicker({
					showOn:"both",
					buttonImage:"${apachePath}/resources/assets/img/calen2.png",
					buttonImageOnly:true,
					dateFormat : "yy-mm-dd",
					dayNamesMin:dayName,
					monthNamesShort:monthName,
					changeMonth:true,
					minDate:0
				});

				$("img.ui-datepicker-trigger").attr("style", "position:relative; right:2px; top:-2px;");
				$("#applyDate").val($.datepicker.formatDate('yy-mm-dd', new Date()));

			$.datepicker.gotoToday=function(id){
				$(id).datepicker('setDate',newDate()).datepicker('hide').blur();
			};

			if($("input[name='onDemandFlag']:checked").val()=="N"){
		    	$("#sdate").show();
			}else{
				$("#sdate").hide();
			}

			$("input[name='onDemandFlag']").on('click',function(){
				//alert($("input[name='onDemandFlag']:checked").val());
				if($("input[name='onDemandFlag']:checked").val()=="N"){
					$("#sdate").show();
				}else{
					$("#sdate").hide();
				}

			});

			//메뉴활성화
			if($("#productSeq").val() == "20191114130000"){
				$("#reqProduct").addClass("active");
				$("#autoscale").addClass("active");
			} else {
				$("#reqProduct").addClass("active");
				$("#service").addClass("active");
			}
		});

		if($("#serviceType").val() != "ASCL"){
			$(document).on("keyup","#productName",function(e){
				var baseText = hvmName + " : ${getCatalogueServiceView.displayName} ";
				var checkText = $(this).val().substring(0,baseText.length);
				var serviceName = $(this).val().substring(baseText.length,$(this).val().length);
				if(baseText != checkText){
					$(this).val(baseText+serviceName);
				}
			})
		}


		const label = document.querySelector('.kep-label');
		const options = document.querySelectorAll('.optionItem');
		const handleSelect = function(item) {
		  label.innerHTML = item.innerText;
		  label.parentNode.classList.remove('active');
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

		function selectCloud(){
			var cloudId = ($("#cloudInfo > option:selected").data("cloud"));
			var cloudType = $("#cloudInfo > option:selected").data("type");
			$("#cloudId").val(cloudId);
			$("#cloudType").val(cloudType);
		}

		function hpaplus(id){
		    var originalValue = $("#"+id).val(); // 변경 전 원래 값 저장
		    var incrementValue = Number($("#"+id+"Cnt").text());
	        if(originalValue >= 100){
	        	alertBox3("100이상 신청 하실 수 없습니다.");
	        	return false;
	        } else {
		        var diskcnt = Number(rtnnumber(originalValue)) + incrementValue;
		        $("#"+id).val(diskcnt);
	        }
		}

		function hpaminus(id){
		    var originalValue = $("#"+id).val(); // 변경 전 원래 값 저장
		    var decrementValue = Number($("#"+id+"Cnt").text());
	        if(originalValue <= 1){
	        	alertBox3("최소 1개 이상 신청하셔야합니다.");
	        	return false;
	        } else {
	 	        var diskcnt = Number(rtnnumber(originalValue)) - decrementValue;
	 	        $("#"+id).val(diskcnt);
	        }
		}

		function getAutoScaleOutCnt(){
			$.ajax({
				url : "${wasPath}/mbr/req/catalogue/getAutoScaleOutCnt",
				dataType : "JSON",
				type : "GET",
				data : {
					appUid : $("#appUuid").val()
				},
				success : function(data) {
					var appUidCnt = data;

					$("#autoScaleOut").val(appUidCnt);
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

</script>

</body>
</html>