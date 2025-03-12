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
	</head>

	<body>
		<iframe id='iframeBasket' name='iframeBasket' style='display:none; border:0px;'></iframe>

		<!-- begin #page-container -->
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
			<!-- begin #page-container header -->
			<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->
			<!-- begin #page-container sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #content -->
			<div id="content" class="content">
				<p class="page_title">블록디스크 신청
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> <b>블록디스크 신청 </b>
			    </span>
		    	</p>


				<!-- begin #content page-body -->
				<div class="row p20 bgwh br10">

					<!-- 상단 자원설명 시작 -->
					<c:set var="totalPrice" value="" />
					<c:set var="cpuPrice" value="" />
					<c:set var="memPrice" value="" />
					<c:set var="memPrice1" value="" />
					<c:set var="diskPrice" value="" />
					<c:set var="diskPrice1" value="" />
					<c:set var="osPrice" value="" />
					<c:set var="priceTypeTxt" value="" />
					<c:choose>
						<c:when test="${getCatalogueSelectView.hourlyFlag eq 'Y'}">
							<c:set var="cpuPrice" value="${getCatalogueSelectView.cpuHourlyPrice}" />
							<c:set var="memPrice" value="${getCatalogueSelectView.memGb * getCatalogueSelectView.memHourlyPrice}" />
							<c:set var="memPrice1" value="${getCatalogueSelectView.memHourlyPrice}" />
							<c:set var="diskPrice" value="${getCatalogueSelectView.diskHourlyPrice * 10}" />
							<c:set var="diskPrice1" value="${getCatalogueSelectView.diskHourlyPrice * getCatalogueSelectView.diskGb / 10}" />
							<c:set var="totalPrice" value="${getCatalogueSelectView.vcpus * cpuPrice + memPrice + diskPrice1}" />

						</c:when>
						<c:otherwise>
							<c:set var="cpuPrice" value="${getCatalogueSelectView.cpuMonthlyPrice}" />
							<c:set var="memPrice" value="${getCatalogueSelectView.memGb * getCatalogueSelectView.memMonthlyPrice}" />
							<c:set var="memPrice1" value="${getCatalogueSelectView.memMonthlyPrice}" />
							<c:set var="diskPrice" value="${getCatalogueSelectView.diskMonthlyPrice * 10}" />
							<c:set var="diskPrice1" value="${getCatalogueSelectView.diskMonthlyPrice * getCatalogueSelectView.diskGb / 10}" />
							<c:set var="totalPrice" value="${getCatalogueSelectView.vcpus * cpuPrice +  memPrice + diskPrice1}" />
						</c:otherwise>
					</c:choose>


					<div class="product_box">
					  <li class="img"><img src="${getCatalogueSelectView.imageName}" class="width-80 pt10"/></li>
					  <li class="description">
					      <span class="productTitle">${getCatalogueSelectView.displayName}</span>
					       <p class="productsubTitle">
					       <c:if test='${getCatalogueSelectView.descriptionTop eq null or getCatalogueSelectView.descriptionTop eq ""}'>
								디스크입니다.
							</c:if>
							<c:if test='${getCatalogueSelectView.descriptionTop ne null or getCatalogueSelectView.descriptionTop ne ""}'>
								${getCatalogueSelectView.descriptionTop}
							</c:if>
					        </p>
					  </li>
					  <ul class="product_sub">
					   <li class="disk"><img src="/resources/assets/img/icon_disk.png"/> DISK  <span class="lh20"> ${getCatalogueSelectView.diskGb} <span class=" fc33">GB</span></span></li>
					  <%--  <li class="memory"><img src="/resources/assets/img/icon_mem.png"/> MEMORY <span class="fc_blue_im flr f24 lh20"> ${getCatalogueSelectView.memGb} <span class="f16 fc33">GB</span></span></li>
					   <li class="cpu"><img src="/resources/assets/img/icon_cpu.png"/> vCPU  <span class="fc_purple_im flr f24 lh20">${getCatalogueSelectView.vcpus} <span class="f16 fc33">Core</span></span></li> --%>
					  </ul>
					</div>








	<%-- 				<div class="productTotalArea">
						<div class="productTitleArea">
							<img src="${getCatalogueSelectView.imageName}" class="width-60 pt10"/>
							<span class="productTitle">${getCatalogueSelectView.displayName}</span>

							<p class="productsubTitle">
							<c:if test='${getCatalogueSelectView.descriptionTop eq null or getCatalogueSelectView.descriptionTop eq ""}'>
								디스크입니다.
							</c:if>
							<c:if test='${getCatalogueSelectView.descriptionTop ne null or getCatalogueSelectView.descriptionTop ne ""}'>
								${getCatalogueSelectView.descriptionTop}
							</c:if>
							</p>
						</div>
						<div class="productInfoArea">
							<div class="productAreaNoLine">
								<img src="/resources/assets/img/icon_disk.png"/>
								<span class="productInfo"> ${getCatalogueSelectView.diskGb} GB</span>
							</div>

							<div class="productSubInfo dpno">
								<!-- <ul>
									<p class="f16 fc66">안정성<span class="fc99"> - 업계 최고의 데이터 지속성과 복구성을 제공</span></p>
									<p class="f16 fc66">효율성<span class="fc99"> - 운영체제를 통해 직접 스토리지에 엑세스하므로 대기시간이 줄어듬</span></p>
									<p class="f16 fc66">신청단위<span class="fc99"> - 100GB</span></p>
								</ul> -->
								<c:if test="${getCatalogueSelectView.description eq null or getCatalogueSelectView.description eq ''}">
								디스크 설명
								</c:if>
								<c:if test="${getCatalogueSelectView.description ne null or getCatalogueSelectView.description ne ''}">
								${getCatalogueSelectView.description}
								</c:if>
							</div>
						</div>
					</div> --%>
					<!-- 상단 자원설명 끝 -->

					<div class="clear"></div>

					<!-- 자원 신청 정보 시작 -->
					<div class="orderArea">
						<div class="tableF">
							<form name="catalogueform"  id="catalogueform" action="catalogueDiskOrderNow" method="post" >
								<input type="hidden" name="imagePath" id="imagePath" value="${getCatalogueSelectView.imagePath}" />
								<input type="hidden" name="imageName" id="imageName" value="${getCatalogueSelectView.imageName}" />
								<input type="hidden" name="type" id="type" value="noworderinsert" />
								<input type="hidden" name="productSeq" id="productSeq" value="${getCatalogueSelectView.productSeq}" />
								<input type="hidden" name="totalPrice" id="totalPrice" value="${totalPrice}" />
								<input type="hidden" name="productCategory" id="productCategory" value="${getCatalogueSelectView.productCategory}" />
								<!-- <input type="hidden" name="hourlyFlag" id="hourlyFlag" value="${getCatalogueSelectView.hourlyFlag}" /> -->
								<input type="hidden" name="networkChk" id="networkChk" value="" />
								<input type="hidden" name="catalogSeq" id="catalogSeq" value="${getCatalogueSelectView.catalogSeq}" />
								<input type="hidden" name="hiddenUserIdReview" id="hiddenUserIdReview" value="" />
								<input type="hidden" name="hiddenUserNameReview" id="hiddenUserNameReview" value="" />
								<input type="hidden" name="hiddenUserIdApprove" id="hiddenUserIdApprove" value="" />
								<input type="hidden" name="hiddenUserNameApprove" id="hiddenUserNameApprove" value="" />
								<input type="hidden" name="hidden_login_user_id" id="hidden_login_user_id" value="${userId}" />
								<input type="hidden" name="cloudId" id="cloudId" value="" />
								<input type="hidden" name="cloudType" id="cloudType" value="" />
								<input type="hidden" name="cloudImgPath" id="cloudImgPath" value="${cloudImgPath}" />
								<input type="hidden" name="approvalStepListString" id="approvalStepListString" />
								<input type="hidden" name="apprvPass" id="apprvPass"	value="${apprvPass}" />
								<input type="hidden" name="selectApprv" id="selectApprv" value="" />

								<table>
									<colgroup>
										<col width="140px">
										<col width="*">
										<col width="140px">
										<col width="*">
									</colgroup>

									<tbody>
										<tr class="dpno">
											<td class="left">이용요금</td>
											<td colspan="3">
												<label><input type="radio" id="hourlyFlag1" name="hourlyFlag" value="N" checked class="va-tb"/> <span class="mr50">월 </span></label> <label><input type="radio" id="hourlyFlag2" name="hourlyFlag" value="Y" class="va-tb"/> 시간</span></label>
											</td>
										</tr>
										<tr>
											<td class="left-t">서비스희망일시</td>
											<td colspan="3">
												<div class="radio-select-group">
													<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성</label>     &nbsp;&nbsp;
													<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> <span class="mr14">희망일시 생성 </span></label><br/>
												</div>
											   <div class="fc-dblue2 f14 pt10" id="selectTEXT" ><i class='fa fa-exclamation-circle f16 fc-dblue2'></i><span class="fb"> 관리자의 최종승인 후 블록디스크가 생성 됩니다. </span></div>
											</td>
										</tr>
										<tr id="sdate" name="sdate" style="display:none">
											<td class="left"></td>
											<td colspan="3">
												<div class="flex align-center gap10">
													<input type="text" class="form-control dpin width-150" id="applyDate" name="applyDate" />
													<div class="searchBoxArea width-80 ml10 dpin">
														<div class="">
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
													<!-- <img src="/resources/assets/img/icon_minus.png"  onclick="applyTimeMinus();" class="minus ml22"/>
													<input type="text" class="snemo ml-4 " placeholder="18:00"  value="18" id="applyTime" name="applyTime"  readonly/>
													<img src="/resources/assets/img/icon_plus.png"  onclick="applyTimePlus();" class="plus"/> -->
												</div>
											</td>
										</tr>
										<tr>


											<td class="left">클라우드</td>
											<td>
												     <div class="searchBoxArea">
													 <label class="selectBoxDrop" for=cloudInfo>클라우드</label>
													 <select class="search-sel" name="cloudInfo" id="cloudInfo" onChange="selectCloud();">
														<option value="">대역선택</option>
														<c:forEach items="${cloudList}" var="cloudList" varStatus="status">
															<option value="${cloudList.cloudId}" data-cloud="${cloudList.cloudId}" data-type="${cloudList.cloudType}" data-name="${cloudList.cloudName}">${cloudList.cloudName}</option>
														</c:forEach>
													</select>
										            </div>
												</td>
										</tr>
										<tr>
											<td class="left">프로젝트명</td>
											<td>
												<div class="search-box">
													<input class="form-control w95" type="text" name="projectAlias" id="projectAlias" readonly="readonly"/>
													<input class="form-control" type="hidden" name="projectName" id="projectName" />
													<input type="hidden" name="projectBoxId" id="projectBoxId" value="" />
													<input type="hidden" name="projectId" id="projectId" value="" />
													<!-- <img src="/resources/assets/img/icon_search.png" onclick="openModal();"class="input_search t6 r0"/> -->
													<img src="${apachePath}/resources/assets/img/btn_search2.png" onclick="openModal();" class="kepco-ser-icon"/>
												</div>
											</td>
											<td class="left">가상서버</td>
											<td>
												<div class="search-box">
													<input class="form-control w95" type="text"  name="vmName" id="vmName" readonly="readonly"/>
													<input type="hidden"  name="vmUuid" id="vmUuid" />
													<input type="hidden"  name="vmHost" id="vmHost" />
													<!-- <img src="/resources/assets/img/icon_search.png"  name="vmBtn" id="vmBtn" onclick="openModal2();" class="input_search t6 r0"/> -->
													<img src="${apachePath}/resources/assets/img/btn_search2.png" onclick="openModal2();" class="kepco-ser-icon"/>
												</div>
											</td>
										</tr>
										<tr>
											<td class="left">디스크명</td>
											<td><input maxlength="30" class="form-control" type="text" name="diskName" id="diskName"  /></td>
											<td class="left">디스크 용량</td>
											<td>
											<div class="flex align-center">
												<input class="form-control w138" type="text"  placeholder="1" value="${getCatalogueSelectView.diskGb}"  maxlength="5" name="diskcnt" id="diskcnt" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" onfocusout="diskfocusout(this);" onkeyup="diskchange(this);" /> <p class="inputUnit"> GB </p>
												<input type="hidden" name="diskprice" id="diskprice" value='<fmt:formatNumber value="${diskPrice}" pattern="####"/>'>
												<input type="hidden" name="diskprice1" id="diskprice1" value='<fmt:formatNumber value="${diskPrice1}" pattern="####"/>'>
												<img src="/resources/assets/img/icon_minus.png"  onclick="diskminus();" class="minus"/><span class="snemo">10</span>
												<img src="/resources/assets/img/icon_plus.png" onclick="diskplus();" class="plus"/>
												<p class="inputUnit"> GB </p>
												<span id="diskpriceview" name="diskpriceview" class="flr f18 fc66 dpno">
													<span class="listwon nanumR">
														<fmt:formatNumber value="${diskPrice1}" pattern="#,###"/>
													</span>&nbsp;원
												</span>
												<input type="hidden" name="imdiskprice" id="imdiskprice" value="<fmt:formatNumber value="${diskPrice}" pattern="####"/>" />
												<input type="hidden" name="imdiskcnt" id="imdiskcnt" value="<fmt:formatNumber value="${getCatalogueSelectView.diskGb}" pattern="####"/>" />
											</div>
											</td>
										</tr>
										<tr class="diskTypeZone" style="display:none">
											<td class="left">디스크 TYPE</td>
											<td colspan="3">
											<div class="searchBoxArea width-540">
												<input type="hidden" name="diskType" id="diskType" />
												<!-- <select class="form-control width-540 pb6" id="diskTypeSel" name="diskTypeSel" onchange="chgDiskType()" disabled="disabled"> -->
												<label class="selectBoxDrop">디스크 유형 </label>
												<select class="search-sel" id="diskTypeSel" name="diskTypeSel" onchange="chgDiskType()" >
									           		<option value="">디스크 유형</option>
												</select>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>


						<!-- 단가 정보 시작 -->
						<div class="appTotal3 dpno">
							<span class="llabel nanumR">총합계<span class="txttotal">(VAT 별도)</span></span>
							<span class="totalwonUnit"><span id="totalpriceview" name="totalpriceview"  class="totalwon nanumR"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/></span>&nbsp;원</span>
							<input type="hidden" name="imamount" id="imamount" value='<fmt:formatNumber value="${totalPrice}" pattern="#,###"/>' />
							<input type="hidden" name="amount" id="amount" value='<fmt:formatNumber value="${totalPrice}" pattern="####"/>' />
						</div>
						<!-- 단가 정보 끝 -->

						<!-- 버튼박스 시작 -->
						<div class="btn_area">
							<a type="button" class="btn_navy"  onclick="openApproveReviewModal();">신청</a>
							<a type="button" class="btn_dngrey ml10" onclick="basketorder();">일괄신청</a>
							<a type="button" class="btn_lgrey ml10" onclick="moveListPage();"> 취소</a>
						</div>
						<!-- 버튼박스 끝 -->
					</div>
				</div>
				<!-- 자원 신청 정보 끝 -->
				<!-- end #content page-body -->

				<!-- begin #content modal -->
				<!-- 결재자 지정 시작 -->
				<!-- #modal-dialog 결재자 지정팝업 시작 -->
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
				<!-- 결재자 지정 끝 -->


				<!-- 프로젝트 검토자 결재자 지정 팝업 시작 -->
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
								<a type="button" class="m_btn_white" data-dismiss="modal" >닫기</a>
							</div>
						</div>
					</div>
				</div>
				<!-- 프로젝트 검토자 결재자 지정 팝업 끝 -->

				<!-- 프로젝트 승인자 결재자 지정 팝업 시작 -->
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
								<a type="button" class="m_btn_white" data-dismiss="modal" >닫기</a>
							</div>
						</div>
					</div>
				</div>
				<!-- 프로젝트 승인자 결재자 지정 팝업 끝-->

				<!-- 프로젝트 선택 시작 -->
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
										<div class="search-box">
											<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)projectPopList();" >
											<button type="button" class="btn_search2 vm" onclick="projectPopList();"><span></span></button>
										</div>
								</div>

									<div class="popListTable">
										<table class="tableV">
											<colgroup>
												<col width="200px">
										 		<col width="*">
										 		<col width="80px">
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
	                			<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
	                    	</div>
	                	</div>
	            	</div>
	        	</div>
				<!-- 프로젝트 선택 끝 -->

				<!-- 가상서버 검색 시작 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog2">
					<div class="modal-dialog width-720">
						<div class="modal-content width-720">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                        <h4 class="modal-title">가상서버 검색</h4>
							</div>
							<div class="modal-body">

							    <div class="col-xs-12 bgee modalpop mb20">
									 <div class="selectBoxAr col-xs-2">
											<label class="selectText" for="vmSearchKind">서버명</label>
											<select class="search-sel" id="vmSearchKind" name="vmSearchKind">
												<option value="hostname_alias">서버명</option>
												<option value="hostname">호스트명</option>
											</select>
										</div>
										<div class="search-box">
											<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="searchKeyword2" onkeypress="if(event.keyCode==13)gridVMList();" data-original-title="" title="">
										<button type="button" class="btn_search2 vm" onclick="gridVMList();"><span></span></button>
									 </div>
								</div>

								<div class="popListTable">
									<table class="tableV" id="VM-list">
										<colgroup>
											<col width="200px">
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
	                   			<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
							</div>
						</div>
               		</div>
				</div>
				<!-- 가상서버 검색 끝 -->

				<!-- 구매 확인 시작 -->
				<!-- #modal-dialog -->
				<div class="modal fade pdManage" id="modal-dialog3">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
								<h4 class="modal-title">신청확인</h4>
							</div>
							<div class="modal-body">
								<!--  <div class="modalManagePop">
									<strong class="title" id="pop_projectName"></strong>
									<strong class="title" id="pop_projectAlias"></strong>
									<div class="detailBox">
										<div class="boxType01">
											<ul>
												<li><span class="title">클라우드</span><img src="${cloudImgPath}" class="w12"/><span class="cnt">${cloudName}</span></li>
											</ul>
											<ul>
												<li><span class="title">서버명</span><span class="cnt nanumR" id="pop_hostname"></span></li>
												<li><span class="title">호스트명</span><span class="cnt nanumR" id="pop_hostnameAlias"></span></li>
											</ul>
										</div>
										<div class="boxType02">
											<ul>
												<li><span class="title">요청유형</span><span class="cnt">신규</span></li>
												<li><span class="title">희망일시</span><span class="cnt" id="pop_onDemandFlag"></span></li>
												<!-- <li><span class="title">과금단위</span><span class="cnt" id="pop_hourlyFlag"></span></li>
												<li><span class="title">디스크명</span><span class="cnt" id="pop_diskName"></span></li>
												<li><span class="title">DISK</span><span class="cnt" id="pop_diskcnt"></span></li>
											</ul>
										</div>
										<!-- <dl class="boxType03">
											<dt>금액<span class="fc-red">(VAT 별도)</span></dt>
											<dd><strong id="pop_totalPrice"></strong><span>&nbsp;원</span></dd>
										</dl>
									</div>
									<p class="commnet">위 내용으로 신청 하시겠습니까?</p>
								</div>-->

								<h4 class="tal mb20"> <span id="pop_projectName" class="pid mr10"></span><img src="${cloudImgPath}" class="w12"/><span class="cnt">${cloudName}</span></h4>
								<table class="tableE">
									<colgroup>
										<col width="120px">
										<col width="*">
										<col width="120px">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<th class="tal">프로젝트명</td>
											<td colspan="3">
												<span id="pop_projectAlias"></span>
											</td>
										</tr>
										<tr>
											<th class="tal">서버명</td>
											<td><span id="pop_hostname"></span></td>
											<th class="tal">호스트명</td>
											<td><span class="cnt nanumR" id="pop_hostnameAlias"></span></td>
										</tr>
										<tr>
											<th class="tal">요청유형</td>
											<td><span id="dddd">신규</span></td>
											<th class="tal">희망일시</td>
											<td><span class="cnt nanumR" id="pop_diskcnt"></span></td>
										</tr>
										<tr>
											<th class="tal">디스크명</td>
											<td><span id="pop_diskName"></span></td>
											<th class="tal">DISK</td>
											<td><span class="cnt nanumR" id="pop_diskcnt"></span></td>
										</tr>
									</tbody>
								</table>

								<p class="commnet fc-red">위 내용으로 신청 하시겠습니까?</p>

							</div>
							<div class="modal-footer tac">
								<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="request_noworder();">확인</a>
	                   			<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
	                       </div>
						</div>
					</div>
				</div>
				<!-- 구매 확인 끝 -->
				<!-- end #content modal -->

				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->
			</div>
			<!-- end #content -->
		</div>
		<!-- end #page-container -->

		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">

			// 결재라인 관련 변수
			var currentApprovalLine = "";
			var approvalList = [];

			function chgDiskType() {
				$("#diskType").val( $("#diskTypeSel option:selected").attr("code") );
				//alert( $("#diskTypeSel option:selected").attr("code") );
			}
			function chgVmdk() {
				$("#diskcnt").val( $("#diskVmdkSel option:selected").attr("code") );
			}

			// 결재자 지정 시작
			function openApproveReviewModal(){

				if($("input[name='onDemandFlag']:checked").val()=="N"){
					if($("#applyDate").val()==""){
						alertBox3("서비스희망일을 입력하세요");
						return false;
					}
					if($("#applyTime > option:selected").val()==""){
						alertBox3("서비스희망시간을 입력하세요");
						return false;
					}
				}
				if($("#projectName").val()==""){
					alertBox3("프로젝트를 입력하세요");
					return false;
				}
				if($("#vmName").val()==""){
					alertBox3("가상서버를 입력하세요");
					return false;
				}
				if($("#diskName").val()==""){
					alertBox3("블록디스크 이름를 입력하세요");
					return false;
				}

				if($("#diskName").val()==""){
					alertBox3("블록디스크 이름를 입력하세요");
					return false;
				}

                if($("#diskTypeSel option:selected").val()=="" && $("#cloudType").val()!='vmware'){
					alertBox3("블록디스크 TYPE를 선택하세요");
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
					confirmBox("재신청할경우 현재 상위결재자값이 <br/> 초기화 됩니다.", clearUpperApproval );

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

				/* if($("#hidden_login_user_id").val() ==userId) {
					alertBox("신청자는 본인을<br>결재자로 지정할수 없습니다.");
					return false;
				} */

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

			// 결재자 지정 끝
			function applyTimePlus(){
				if($("#applyTime").val()=="23") {
					alertBox3("시간을 정확히 입력해 주세요.");
				} else {
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
				} else {
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

				if($("#cloudType").val() == ""){
					alertBox3("클라우드를 선택해주세요.");
					return false;
				}
				$("#modal-dialog2").modal();

				if($("#cloudType").val() == "nutanix"){
					gridNutanixVMList();
				}else{
				    gridVMList();
				}
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
							d.keyword = $("#searchKeyword2").val();
							d.projectName = $("#projectName").val();
							d.projectId = $("#projectId").val();
							d.projectBoxId = $("#projectBoxId").val();
							d.volumeType = $("#diskType").val();
							d.cloudId = $("#cloudId").val();
						}
					}
					,"columns":[
						{"data":"hostname" , "class":"tac nanumR"}
						, {"data":"hostnameAlias" , "class":"tac nanumR"}
						, {"class":"tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
		 				, {"targets":[2], "render": function(data,type,full){
							return '<input type="button" class="popCheckbtn" value="&#xf00c" onclick="setVM(this, \''+full.vmUuid+'\',\''+full.hostnameAlias+'\',\''+full.hostname+'\',\''+full.cloudType+'\',\''+full.cloudName+'\',\''+full.cloudId+'\',\''+full.projectId+'\')">';
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



			// 팝업리스트
			function gridNutanixVMList(){

				$("#VM-list").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${wasPath}/mbr/oss/vm/catalogueNutanixVmlist"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = "hostname_alias";
							d.keyword = $("#searchKeyword2").val();
							d.projectName = $("#projectName").val();
							d.projectBoxId = $("#projectBoxId").val();
							d.volumeType = $("#diskType").val();
							d.cloudId = $("#cloudId").val();
						}
					}
					,"columns":[
						{"data":"hostname" , "class":"tal nanumR"}
						, {"data":"hostnameAlias" , "class":"tal nanumR"}
						, {"class":"tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
		 				, {"targets":[2], "render": function(data,type,full){
							return '<input type="button" class="popCheckbtn" value="&#xf00c" onclick="setVM(this, \''+full.vmUuid+'\',\''+full.hostnameAlias+'\',\''+full.hostname+'\',\''+full.cloudType+'\',\''+full.cloudName+'\',\''+full.cloudId+'\',\''+full.projectId+'\')">';
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
				$.ajax({
					url : "${wasPath}/mbr/req/catalogue/projectPopList",
					dataType : "JSON",
					//type : "POST",
					data : {
						"searchValue" : keyword,
					},
					success : function(data) {
						var projectList = data.getProjectList;

						if(projectList!=""){
							$("#popListTable > tr").remove();
							$.each(projectList,function(key,val){
								var Html="";
			 					//Html="<tr><td class='tac'>"+val["projectName"]+"</td>";
								Html="<tr>";
								    Html = Html + "<td class='tac'>"+val["projectName"]+"</td>";
									Html = Html + "<td class='tac'>"+val["projectAlias"]+"</td>";
									Html = Html + "<td class='tac'><input type='button' class='popCheckbtn'  value='&#xf00c' onclick='updateProject(this, \""+val["projectBoxId"]+"\",  \""+val["projectId"]+"\",  \""+val["projectName"]+"\", \""+val["projectAlias"]+"\")'></td>";
									Html = Html + "</tr>";
								$("#popListTable").append(Html);
							});
						} else {
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

			var hprojectName, hprojectId, hprojectAlias, hvmUuid, hvmName, hvmHost,hcloudId,hcloudName,hcloudType,hprojectBoxId;

			function updateProject(e, projectBoxId, projectId, projectName,projectAlias){
				$("#popListTable > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
				hprojectName = projectName;
				hprojectBoxId = projectBoxId;
				hprojectId = projectId;
				hprojectAlias = projectAlias;
				hvmUuid = "";
				hvmName = "";
				hvmHost = "";
			}

			var diskAvail;

			function okProjectInsert(){
				$("#projectName").val(hprojectName);
				$("#projectBoxId").val(hprojectBoxId);
				$("#projectId").val(hprojectId);
				$("#projectAlias").val(hprojectAlias);
				$("#vmUuid").val(hvmUuid);
				$("#vmName").val(hvmName);
				$("#vmHost").val(hvmHost);
				$("#vmBtn").show();
				/*$.ajax({
					url : "${wasPath}/mng/project/quota/getQuota",
					type:"GET",
					data:{projectId:hprojectId},
					success:function(data){
						diskAvail = data.diskAvail;
						checkAvail();
					}
				})*/
			}

			function setVM(e, vmUuid, vmName, vmHost,cloudType,cloudName,cloudId,projectId){
// 				$("#popListTable2 > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
				if($(e).hasClass("active")){
					hvmUuid = vmUuid;
					hvmName = vmName;
					hvmHost = vmHost;
					hcloudId = cloudId;
					hcloudType = cloudType;
					hcloudName = cloudName;
					hprojectId = projectId;

				} else {
					hvmUuid = "";
					hvmName = "";
					hvmHost = "";
					hcloudId = "";
					hcloudName = "";
					hcloudType = "";
					hprojectId = "";
				}
			}

			function okVMInsert() {
				$("#vmUuid").val(hvmUuid);
				$("#vmName").val(hvmName);
				$("#vmHost").val(hvmHost);
				$("#cloudId").val(hcloudId);
				$("#cloudType").val(hcloudType);
				$("#cloudName").val(hcloudName);
				$("#diskName").val($("#vmHost").val()+"_"+$("#diskcnt").val()+"GB");
				$("#diskTypeSel").html("");
				$("#projectId").val(hprojectId);
				if(hcloudType == "openstack"){
					$(".diskTypeZone").show();
					getDiskType();
				} else {
					$(".diskTypeZone").hide();
				}
			}

			function request_noworder(){
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
					$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma($("#imdiskprice").val())+'</span>&nbsp;원');
					$("#totalpriceview").empty();
					$("#totalpriceview").html(addcomma($("#totalPrice").val()));
				} else {
					var diskcnt;
					var diskprice;
					var imamount;
					//alert($("#diskprice").val());
					diskcnt = Number(rtnnumber($("#diskcnt").val())) + 10;
					$("#diskcnt").val(diskcnt);
					diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
					//alert(Number(rtnnumber($("#diskprice").val()))/10);
					imamount = Number(rtnnumber($("#imamount").val()))+Number(rtnnumber($("#diskprice").val()))/10;
					//alert(addcomma(diskprice));
					if(checkAvail()){
						$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>&nbsp;원');
						$("#imamount").val(addcomma(imamount));
						$("#totalpriceview").empty();
						$("#totalpriceview").append(addcomma(imamount));
						$("#totalPrice").val(addcomma(imamount));
						$("#imdiskprice").val(diskprice);
						$("#imdiskcnt").val($("#diskcnt").val());
					}
				}
			}

			function checkAvail(){
				var diskcnt = Number(rtnnumber($("#diskcnt").val()));
				if(diskcnt > diskAvail && diskAvail != "undefined"){
					alertBox3("디스크 자원 쿼터를 초과하였습니다.");
					diskcnt = Number(rtnnumber(diskAvail));
					diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
					$("#diskcnt").val(diskcnt);
					$("#diskpriceview").empty();
					$("#diskpriceview").append(addcomma(diskprice));
					$("#imamount").val(addcomma(imamount));
					$("#totalpriceview").empty();
					$("#totalpriceview").append(addcomma(imamount));
					$("#totalPrice").val(addcomma(imamount));
					$("#imdiskprice").val(diskprice);
					$("#imdiskcnt").val(diskAvail);
					return false;
				}
				return true;
			}

			function diskminus(){
					if(Number($("#diskcnt").val())<=10){
						alertBox3("디스크는 최소 10GB 이상<br/>신청하셔야 합니다.");
						/* $("#diskcnt").val($("#imdiskcnt").val());
						$("#diskpriceview").empty();
						$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma($("#imdiskprice").val())+'</span>원');
						$("#totalpriceview").empty();
						$("#totalpriceview").append($("#totalPrice").val()); */
					} else {
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
						$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>&nbsp;원');
						$("#imamount").val(addcomma(imamount));
						$("#totalpriceview").empty();
						$("#totalpriceview").append(addcomma(imamount));
						$("#totalPrice").val(addcomma(imamount));
						$("#imdiskprice").val(diskprice);
						$("#imdiskcnt").val($("#diskcnt").val());
					}
			}

			function diskfocusout(id){
				var diskcnt;
				diskcnt = Number($(id).val());

				if(diskcnt<10){
					alertBox3("디스크는 최소 10GB 이상<br/>신청하셔야 합니다.");
					$(id).val($("#imdiskcnt").val());
					$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma($("#imdiskprice").val())+'</span>&nbsp;원');
					$("#totalpriceview").empty();
					$("#totalpriceview").html(addcomma($("#totalPrice").val()));
				}else if(diskcnt>10000){
					alertBox3("디스크는 10,000GB 이상<br/>신청하실수 없습니다.");
					$(id).val($("#imdiskcnt").val());
					$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma($("#imdiskprice").val())+'</span>&nbsp;원');
					$("#totalpriceview").empty();
					$("#totalpriceview").html(addcomma($("#totalPrice").val()));
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
						$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>&nbsp;원');
						$("#imamount").val(addcomma(imamount));
						$("#totalpriceview").empty();
						$("#totalpriceview").append(addcomma(imamount));
						$("#totalPrice").val(addcomma(imamount));
						checkAvail();
					}else{
						$(id).val($("#imdiskcnt").val());
						$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma($("#imdiskprice").val())+'</span>&nbsp;원');
						$("#totalpriceview").html(addcomma($("#totalPrice").val()));

					    if($("#cloudType").val() == 'openstack'){
						  alertBox3("disk는 10GB 단위로 신청하실수 있습니다.");
						}
					}

				}
			}

			function diskchange(id){
				var diskval = $(id).val();

				if(diskval.length>2) {
					var diskprice;
					var imamount;
					diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100;
					imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
					imamount =  imamount + diskprice ;
					$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>&nbsp;원');
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
						$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>&nbsp;원');
						$("#totalpriceview").empty();
						$("#totalpriceview").append(addcomma(imamount));
					}
				}
			}

			function diskOrderView() {
				var productSeq = "${getCatalogueSelectView.productSeq}";
				var hourlyFlag = $("input[name='hourlyFlag']:checked").val();
				var diskcnt = $("#diskcnt").val();
				var cloudId = $("#cloudId").val();

				$.ajax({
					url : "${wasPath}/mbr/req/catalogue/getcatalogueDiskOrderView",
					dataType : "JSON",
					//type : "POST",
					data : {
						"productSeq" : productSeq
						,"hourlyFlag" : hourlyFlag
						,"diskcnt" : diskcnt
						,"cloudId" : cloudId
					},
					success : function(data) {
						//alert( $("#diskTypeSel").val(data.diskType) );
						//$("#diskType").val(data.diskType);

						$("#diskTypeSel").val(data.diskType).prop("selected", true);
						$("#diskType").val( $("#diskTypeSel option:selected").attr("code") );

						if(hourlyFlag=="N"){
							//월 금액
							//var totalPrice = data.diskMonthlyPrice * data.diskGb / 10;
							var totalPrice = data.diskMonthlyPrice * diskcnt / 10;
							var diskprice = data.diskMonthlyPrice * 10;
							var diskprice1 = data.diskMonthlyPrice * diskcnt / 10;

							$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma(diskprice1)+'</span>&nbsp;원');
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
						} else {
							//시간 금액
							var totalPrice = data.diskHourlyPrice * diskcnt / 10;
							var diskprice = data.diskHourlyPrice * 10;
							var diskprice1 = data.diskHourlyPrice * diskcnt / 10;

							$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma(diskprice1)+'</span>&nbsp;원');
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

			// 구매전 확인 팝업
			function setOrder() {
				$("#pop_projectName").text($("#projectName").val());
				$("#pop_projectAlias").text($("#projectAlias").val());
				$("#pop_hostnameAlias").text(hvmHost);
				$("#pop_hostname").text(hvmName);

				if ($("input[name='onDemandFlag']:checked").val() == 'N') {
					$("#pop_onDemandFlag").text($("#applyDate").val()+' '+$("#applyTime").val()+':00');
				} else if ($("input[name='onDemandFlag']:checked").val() == 'Y') {
					$("#pop_onDemandFlag").text('승인 완료 후 생성');
				}

				$("#pop_diskName").text($("#diskName").val());
				$("#pop_diskcnt").text($("#diskcnt").val()+' GB');
				if ($("input[name='hourlyFlag']:checked").val() == 'N') {
					$("#pop_hourlyFlag").text('월');
				} else if ($("input[name='hourlyFlag']:checked").val() == 'Y') {
					$("#pop_hourlyFlag").text('시간');
				}
				$("#pop_totalPrice").text($("#totalPrice").val());

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
				if($("#vmName").val()==""){
					alertBox3("가상서버를 입력하세요");
					return false;
				}
				if($("#diskName").val()==""){
					alertBox3("블록디스크 이름를 입력하세요");
					return false;
				}

				setOrder();
				//$("#catalogueform").submit();
				$("#modal-dialog3").modal();
			}

			// 일괄신청
			function basketorder(){
				if($("input[name='onDemandFlag']:checked").val()=="N"){
					if($("#applyDate").val()==""){
						alertBox3("서비스희망일을 입력하세요");
						return false;
					}
					if($("#applyTime > option:selected").val()==""){
						alertBox3("서비스희망시간을 입력하세요");
						return false;
					}
				}
				if($("#projectName").val()==""){
					alertBox3("프로젝트를 입력하세요");
					return false;
				}
				if($("#vmName").val()==""){
					alertBox3("가상서버를 입력하세요");
					return false;
				}
				if($("#diskName").val()==""){
					alertBox3("블록디스크 이름를 입력하세요");
					return false;
				}

				if($("#diskName").val()==""){
					alertBox3("블록디스크 이름를 입력하세요");
					return false;
				}

                if($("#diskTypeSel option:selected").val()==""){
					alertBox3("블록디스크 TYPE를 선택하세요");
					return false;
                }

				$("#totalPrice").val(rtnnumber($("#totalPrice").val()));
				$("#catalogueform").attr('action','basketOrder.do');
				//$("#catalogueform").submit();

				var params = $('#catalogueform').serialize();

				$.ajax({
					url : "${wasPath}/mbr/req/catalogue/basketOrder2.do",
					dataType : "JSON",
					type : "POST",
					/* beforeSend : function(xhr, opts) {
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

					} */

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

			/* function actCatalogueformSubmit(){
				//$("#catalogueform").attr('action','basketOrder.do');
				//$("#catalogueform").submit();
				//location.href = "${wasPath}/mbr/req/catalogue/basketOrder.do";

				if(e){
					location.href = "${wasPath}/mbr/req/catalogue/basketOrder.do";
				}else{
					location.reload();
				}

			} */

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
				location.href = "${wasPath}/mbr/req/catalogue/catalogueSubList.do";
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



			$(document).ready(function() {
		    	App.init();
		    	diskOrderView();
		    	initApprovalLine();

				$("a>button").on('click',function(){
					location.href = $(this).closest("a").attr("href");
				});

				var dayName = ['일','월','화','수','목','금','토'];
				var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

					$("#applyDate").datepicker({
						showOn:"both",
						buttonImage:"/resources/assets/img/calen2.png",
						buttonImageOnly:true,
						dateFormat : "yy-mm-dd",
						dayNamesMin:dayName,
						monthNamesShort:monthName,
						changeMonth:true,
						minDate:0
					});
					$("img.ui-datepicker-trigger").attr("style", "position:relative; right:10px;");
					$("#applyDate").val($.datepicker.formatDate('yy-mm-dd', new Date()));

					$.datepicker.gotoToday=function(id){
						$(id).datepicker('setDate',newDate()).datepicker('hide').blur();
					};

				if($("input[name='onDemandFlag']:checked").val()=="N"){
			    	$("#sdate").show();
				}else{
					$("#sdate").hide();
				}

				$("input[name='hourlyFlag']").on('click',function(){
					diskOrderView();
				});

				$("input[name='onDemandFlag']").on('click',function(){
					if($("input[name='onDemandFlag']:checked").val()=="N"){
						$("#sdate").show();
					}else{
						$("#sdate").hide();
					}

				});

				$("input[name='onDemandFlag']").click(function(){
					if($("input[name='onDemandFlag']:checked").val()=="N"){
						$("#selectTEXT").empty().append("<i class='fa fa-exclamation-circle f16 fc-dblue2'></i> <span class='fb'>관리자의 최종 승인 후 선택한 시간에 블록디스크가 생성 됩니다. </span>" );
						$("#selectTEXT").show();
					}else{
						$("#selectTEXT").empty().append("<i class='fa fa-exclamation-circle f16 fc-dblue2'></i> <span class='fb'>관리자의 최종승인 후 블록디스크가 생성 됩니다. </span>" );
						$("#selectTEXT").show();
					}
				});

				//메뉴활성화
				$("#reqProduct").addClass("active");
				$("#sub").addClass("active");
			});

			function getDiskType(){
				$.ajax({
					url : "${wasPath}/mbr/req/catalogue/getDiskType",
					dataType : "JSON",
					type : "POST",
					data : {cloudType:$("#cloudType").val()},
					success : function(data) {
						var html = "<option value=''>디스크 유형</option>";
						$.each(data,function(k,v){
							html += "<option value='"+v['codeId']+"' code='"+v['codeValue']+"'>"+v['codeName']+"</option>";
						})
						$("#diskTypeSel").html(html);
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

			function selectCloud(){

				var cloudId = ($("#cloudInfo > option:selected").data("cloud"));
				var cloudType = $("#cloudInfo > option:selected").data("type");
				$("#cloudId").val(cloudId);
				$("#cloudType").val(cloudType);
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


		</script>
	</body>
</html>