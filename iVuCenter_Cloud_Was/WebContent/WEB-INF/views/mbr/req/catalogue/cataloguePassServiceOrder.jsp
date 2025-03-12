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

			<!-- begin header -->
			<h1 class="page-header"><span class="root"> <span class="home"></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow"><a href="${wasPath}/mbr/req/catalogue/catalogueList.do">자원신청</a></span><span class="text arrow"><a href="${wasPath}/mbr/req/catalogue/catalogueServiceList.do">서비스</a></span><span class="text arrow mint"><a href="${wasPath}/mbr/req/catalogue/catalogueServiceOrder.do?productSeq=${getCatalogueServiceView.productSeq}"><strong>신청</strong></a></span></span></h1>
			<!-- end header -->

			 <!-- begin page-body -->
			 <div class="row mb50">
			 	<p class="page_title"><span class="stick">서</span>비스 신청</p>
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
				<!----첫번째 자원내용 끝------->
				<div class="productTotalArea">
					<div class="productTitleArea">
						<c:if test="${getCatalogueServiceView.catalogCategory eq 'CATACATE_SERVICE'}">
							<img src="${getCatalogueServiceView.imageName}" class=" width-120 pt10"/>
							<span class="productTitle">${getCatalogueServiceView.displayName}</span>
							<p class="productsubTitle">
							<c:if test="${getCatalogueServiceView.descriptionTop eq null or getCatalogueServiceView.descriptionTop eq ''}">
							한전 K-Cloud 전문가 서비스 자원
							</c:if>
							<c:if test="${getCatalogueServiceView.descriptionTop ne null or getCatalogueServiceView.descriptionTop ne ''}">
							${getCatalogueServiceView.descriptionTop}
							</c:if>
							</p>
						</c:if>
					</div>

					<div class="productInfoArea">
						<div class="productSubInfo dpno">
							${getCatalogueServiceView.descriptionList}
						</div>
					</div>
				</div>

				<div class="clear"></div>
				<h4 class="orderTitle">신청정보</h4>
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

						<table>
						<colgroup>
						<col width="190px">
						<col width="*">
						</colgroup>
						<tbody>
						<tr>
						<td class="left-t">서비스희망일시</td>
						<td>
							<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성</label>&nbsp; &nbsp;
							<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> 희망일시 생성 </label>	 <br/>
						</td>
						</tr>
						<tr id="sdate" name="sdate" style="display:none">
						<td class="left-b th20"></td>
						<td>
						<div>
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
						</div>
						</td>
						</tr>
						<tr>
						<td class="left">프로젝트명</td>
						<td>
							<input class="form-control w706" type="text" name="projectAlias" id="projectAlias" readonly="readonly"/>
							<input class="form-control" type="hidden" name="projectName" id="projectName" />
							<input type="hidden" name="projectBoxId" id="projectBoxId" value="" />
							<input type="hidden" name="projectId" id="projectId" value="" />
							<img src="${apachePath}/resources/assets/img/icon_search.png" onclick="openModal();" class="input_search"/>
						</td>
						</tr>

						<tr>
						<td class="left">어플리케이션</td>
						<td>
							<input class="form-control w706" type="text"  name="appName" id="appName" readonly="readonly"/>
							<input type="hidden"  name="appUuid" id="appUuid" />
							<img src="${apachePath}/resources/assets/img/icon_search.png"onclick="openModal2();" name="appBtn" id="appBtn" class="input_search"/>
						</td>
						</tr>
						<tr>
						<c:if test="${getCatalogueServiceView.serviceType eq '10'}">
						   <td class="left">오토스케일명</td>
					    </c:if>
					    <c:if test="${getCatalogueServiceView.serviceType eq '11'}">
						   <td class="left">재배포명​</td>
					    </c:if>
						  	<td>
						  	   	<input maxlength="30" class="form-control w742" type="text"  name="productName" id="productName" />
						  		<!--<a type="button" class="check_btn vm" onclick="productNameChk();"> <i class="fa fa-check"></i> 중복확인</a>-->
						  	</td>
						</tr>
						<tr>
						    <td class="left">추가 요청사항</td>
							<td>
					<%-- <textarea style="width:100%;height:200px;" name="description" id="description"><c:if test="${getCatalogueServiceView.serviceType eq '10'}">CPU 기준 / 메모리 기준 &#10;&#10;최소 운영 POD : 2 &#10;최대 생성 가능한 POD:  5 &#10;부하량:  80 % &#10;지속시간:  5분 &#10;POD: 1EA POD 증가​&#10;부하량: 30 %&#10;지속시간: 5분&#10;POD: 1EA POD 삭제</c:if><c:if test="${getCatalogueServiceView.serviceType eq '11'}">소스 위치 :  http://000.000.000.000/sample/test.git​</c:if></textarea> --%>
					         <textarea style="width:100%;height:200px;" name="description" id="description"></textarea>
							</td>
						</tr>
						</tbody>
						</table>
						</form>
				</div>

				<div class="appTotal3 dpno">
					<span class="llabel nanumR">총합계<span class="txttotal">(VAT 별도)</span></span>
					<span class="totalwonUnit"><span id="totalpriceview" name="totalpriceview"  class="totalwon nanumR"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/></span>&nbsp;원</span>
					<input type="hidden" name="imamount" id="imamount" value='<fmt:formatNumber value="${totalPrice}" pattern="#,###"/>' />
					<input type="hidden" name="amount" id="amount" value='<fmt:formatNumber value="${totalPrice}" pattern="####"/>' />
				</div>

				<div class="btn_area">
				<a type="button" class="bbton bton_blue"  onclick="openApproveReviewModal();"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-check"></i></span><span class="dpin ml16">신청</span></a>
				<a type="button" class="bbton bton_green ml10" onclick="basketorder();"><span class="dpin dd bton_dgreen ml-1"><i class="fa fa-cart-arrow-down"></i></span><span class="dpin ml16">일괄신청</span></a>
				<a type="button" class="bbton bton_dgrey ml10" onclick="moveListPage();"><span class="dpin dd bton_ddgrey ml-1"><i class="fa fa-close"></i></span><span class="dpin ml16"> 취소</span></a>
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
							<div class="listArea" id="popListReviewTable" style="display: none;"></div>
                      		<div class="totalcnt" id="totalReviewCnt">총 0 건</div>
	                   	</div>
	                   	<div class="modal-footer tac">
                       		<a type="button" class="whiteline" data-dismiss="modal" >닫기</a>
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
                       		<a type="button" class="whiteline" data-dismiss="modal" >닫기</a>
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

	                       	 <div class="col-xs-12 bgee modalpop mb20">
		                       		<div class="selectBoxAr col-xs-2">
										<label class="selectText" for="searchKind">전체</label>
										<select class="search-sel" id="searchKind">
											<option value="searchAll">전체</option>
											<option value="project_name">프로젝트ID</option>
											<option value="project_alias">프로젝트명</option>
										</select>
									</div>
									<div class="col-xs-2"></div>
										<div class="col-xs-8">
											<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="searchKeyword" >
											<button type="button" class="btn_search2 vm" onclick="projectPopList();"><span></span></button>
										</div>
								</div>
								<!--검색  끝//-->

									<div class="popListTable">
										<table class="tableV">
											<colgroup>
												<col width="20%">
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
	                   			<a type="button" class="lbtn" data-dismiss="modal" onclick="okProjectInsert();">확인</a>
	                   			<a type="button" class="rbtn" data-dismiss="modal" onclick="">취소</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
				<!-- #modal-dialog 어플리케이션-->
                <div class="modal fade" id="modal-dialog2">
	               <div class="modal-dialog width-720">
	                   <div class="modal-content width-720">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">어플리케이션 검색</h4>
                                        </div>
                                        <div class="modal-body">
											 <!-- search begin -->
											 	<div class="col-md-12 bgee modalpop mb20">
													<div class="selectBoxAr col-xs-2">

															<label class="selectText" for="billYear">어플리케이션명</label>
															<select class="search-sel" id="billYear" name="billYear">
															<option value="">어플리케이션명</option>
															</select>
														</div>
													  <div class="col-xs-2"></div>
														<div class="col-md-8">
															<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="searchKeyword2" data-original-title="" title="">
													  	<button type="button" class="btn_search2 vm" onclick="gridVMList();"><span></span></button>
													  	</div>
													</div>
											<!-- search end -->

										   <div class="popListTable">
											<table class="tableV" id="VM-list">
											 <colgroup>
											 <col width="40%">
											 <col width="40%">
											 <col width="20%">
											 </colgroup>
											 <thead>
											 <tr class="skyblue">
												 <th class="tac">클라우드명</th>
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
				                   			<a type="button" class="lbtn" data-dismiss="modal" onclick="okAppInsert()">확인</a>
				                   			<a type="button" class="rbtn" data-dismiss="modal" onclick="">취소</a>
				                       	</div>
                                    </div>
                                </div>
                            </div>
						<!-- #modal-dialog  어플리케이션 검색-->
			<!-- #modal-dialog 구매 확인-->
             <div class="modal fade pdManage" id="modal-dialog3">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">신청확인</h4>
                           </div>
                           <div class="modal-body">

								<h4 class="tal mb10"> · 프로젝트명  : <span id="pop_projectAlias"></span> <img src="${cloudImgPath}" class="w12"/><span class="cnt">${cloudName}</span></h4>
								<table class="tableE">
									<colgroup>
										<col width="15%"/>
										<col width="35%"/>
										<col width="15%"/>
										<col width="*"/>
									</colgroup>
									<thead>
									<tr><th> 어플리케이션  </th><td colspan="3" id="pop_appName"></td></tr>
									</thead>
									<tbody>
									<tr>
									<th>서비스유형 </th><td id="pop_serviceTypeName"></td><th>희망일시  </th><td id="pop_onDemandFlag"> </td>
									</tr>
									<tr>
									<th>서비스명 </th><td id="pop_productName"></td><th>요청유형  </th><td>신규 </td>
									</tr>
									<tr>
									<th>요청내용 </th><td colspan="3"> <textarea readonly id="pop_description"></textarea></td>
									</tr>
									</tbody>
								</table>

								<p class="fc-red mt10">위 내용으로 신청 하시겠습니까?</p>

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

	 if($("#appName").val()==""){
		alertBox3("어플리케이션을를 입력하세요");
		return false;
	}

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

//modal팝업 open
function openModal(){
	$("#modal-dialog").modal();
	projectPopList();
}


function openModal2(){
	$("#modal-dialog2").modal();
	gridApplicationList();
}

// 팝업리스트
	function gridApplicationList(){

		$("#VM-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${wasPath}/mbr/oss/app/catalogueList"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = "";
					d.keyword = "";
					d.projectName = $("#projectName").val();
					d.projectId = $("#projectBoxId").val();
				}
			}
			,"columns":[
				{"data":"additionalProperties.cloudName" , "class":"tal"}
				, {"data":"additionalProperties.appName" , "class":"tal"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[2], "render": function(data,type,full){
					return '<div class="tac"><a href="#nav-pills-tab-3-view" data-toggle="tab"><input type="button" class="popCheckbtn"  value="&#xf00c" onclick="setApplication(this, \''+full.additionalProperties.appUid+'\',\''+full.additionalProperties.appName+'\',\''+full.additionalProperties.projectId+'\',\''+full.additionalProperties.cloudId+'\')"></a></div>';
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

function projectPopList(){

	var keyword = $("#searchKeyword").val();
	var cloudId = $("#cloudId").val();
	$.ajax({
		url : "${wasPath}/mbr/req/catalogue/projectPopList",
		dataType : "JSON",
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
					Html="<tr>";
					Html = Html + "<td class='tal'>"+val["projectName"]+"</td>";
					Html = Html + "<td class='tal'>"+val["projectAlias"]+"</td>";
					Html = Html + "<td class='tac'><input type='button' class='popCheckbtn'  value='&#xf00c' onclick='updateProject(this, \""+val["projectBoxId"]+"\", \""+val["projectName"]+"\", \""+val["projectAlias"]+"\")'></td>";
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

var hprojectName, hprojectBoxId, hprojectId, hprojectAlias, happUid, happName, happUid, hcloudId;

function updateProject(e, projectId, projectName, projectAlias){
	$("#popListTable > tr").find("input").removeClass("active");
	$(e).toggleClass("active");
	hprojectBoxId = projectId;
	hprojectName = projectName;
	hprojectAlias = projectAlias;
}

function okProjectInsert(){
	$("#projectName").val(hprojectName);
	$("#projectBoxId").val(hprojectBoxId);
	$("#projectAlias").val(hprojectAlias);
	$("#appBtn").show();
}

function setApplication(e, appUid, appName, projectId, cloudId){
	$("#popListTable2 > tr").find("input").removeClass("active");
	$(e).toggleClass("active");

	hprojectId = projectId;
	happUid = appUid;
	happName = appName;
	hcloudId = cloudId


}

function okAppInsert() {

	$("#projectId").val(hprojectId);
	$("#appUuid").val(happUid);  // uuid uid 명칭 통일 필요
	$("#appName").val(happName);
	$("#cloudId").val(hcloudId);
	$("#productName").val(happName + " : ${getCatalogueServiceView.displayName} ").removeAttr("readonly").focus();

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


			//구매전 확인 팝업
			function setOrder() {

				$("#pop_projectAlias").text($("#projectAlias").val());



				if($("#serviceType").val() == '10'){
					$("#pop_serviceTypeName").text('오토스케일');
				}else if($("#serviceType").val() == '11'){
					$("#pop_serviceTypeName").text('어플리케이션 재배포');
				}



				if ($("input[name='onDemandFlag']:checked").val() == 'N') {
					$("#pop_onDemandFlag").text($("#applyDate").val()+' '+$("#applyTime").val()+':00');
				} else if ($("input[name='onDemandFlag']:checked").val() == 'Y') {
					$("#pop_onDemandFlag").text('승인 완료 후 생성');
				}

				$("#pop_description").html($("#description").val());
				$("#pop_productName").text($("#productName").val());
				$("#pop_appName").text($("#appName").val());

				$("#pop_diskName").text($("#diskName").val());
				$("#pop_diskcnt").text($("#diskcnt").val()+' GB');

				if( approvalList[0] == undefined || approvalList[0] == null) {
					var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
					approvalList[0] = tmp;
				}
				$("#approvalStepListString").val(JSON.stringify(approvalList));
			}


			// 바로신청
			function noworder() {

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

				setOrder();
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


	$("#totalPrice").val(rtnnumber($("#totalPrice").val()));
	$("#catalogueform").attr('action','basketOrder.do');

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

				$.datepicker.gotoToday=function(id){
					$(id).datepicker('setDate',newDate()).datepicker('hide').blur();
				};

				if($("input[name='onDemandFlag']:checked").val()=="N"){
			    	$("#sdate").show();
				}else{
					$("#sdate").hide();
				}

				$("input[name='onDemandFlag']").on('click',function(){
					if($("input[name='onDemandFlag']:checked").val()=="N"){
						$("#sdate").show();
					}else{
						$("#sdate").hide();
					}

				});

				//메뉴활성화
				$("#reqProduct").addClass("active");
				$("#service").addClass("active");

			});

$(document).on("keyup","#productName",function(e){
	var baseText = happName + " : ${getCatalogueServiceView.displayName} ";
	var checkText = $(this).val().substring(0,baseText.length);
	var serviceName = $(this).val().substring(baseText.length,$(this).val().length);
	if(baseText != checkText){
		$(this).val(baseText+serviceName);
	}
})



</script>

</body>
</html>