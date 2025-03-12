<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<%-- 			<h1 class="page-header"><span class="root"> <span class="home"><img src="${apachePath}/resources/assets/img/ico_home.png"  alt="홈"/></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow"><a href="${wasPath}/mbr/req/catalogue/catalogueList.do">자원신청</a></span><span class="text arrow"><a href="${wasPath}/mbr/req/catalogue/catalogueSubList.do">부가자원</a></span><span class="text arrow mint"><a href="${wasPath}/mbr/req/catalogue/catalogueNasOrder.do?productSeq=${getCatalogueSelectView.productSeq}&hourlyFlag=N"><strong>신청</strong></a></span></span></h1> --%>
			<!-- end header -->
			<p class="page_title">Persistent Volume 신청
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> <b>Persistent Volume 신청 </b>
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
				<input type="hidden" name="imNasGb" id="imNasGb" value="100" />
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
					   <li class="disk"><img src="/resources/assets/img/icon_disk.png"/><span>DISK&nbsp;${getCatalogueSelectView.nasGb} <span>GB</span></span></li>
					  </ul>
				</div>
				<!----첫번째 자원내용 끝------->
				<div class="clear"></div>
				<div class="orderArea">
					<div class="tableF">
<%-- 					<form name="catalogueform"  id="catalogueform" action="${wasPath}/mbr/req/catalogue/catalogueNasOrderNow.do" method="post" > --%>
<!-- 					<form name="catalogueform"  id="catalogueform" action="catalogueOrderNow" method="post" > -->
					<form name="catalogueform"  id="catalogueform" action="catalogueNasOrderNow.do" method="post" >
						<input type="hidden" name="type" id="type" value="noworderinsert" />
						<input type="hidden" name="imagePath" id="imagePath" value="${getCatalogueSelectView.imagePath}" />
						<input type="hidden" name="imageName" id="imageName" value="${getCatalogueSelectView.imageName}" />
						<input type="hidden" name="type" id="type" value="noworder" />
						<input type="hidden" name="productSeq" id="productSeq" value="${getCatalogueSelectView.productSeq}" />
						<input type="hidden" name="totalPrice" id="totalPrice" value="${totalPrice}" />
						<input type="hidden" name="productCategory" id="productCategory" value="${getCatalogueSelectView.productCategory}" />
						<!-- <input type="hidden" name="hourlyFlag" id="hourlyFlag" value="${getCatalogueSelectView.hourlyFlag}" /> -->
						<input type="hidden" name="networkChk" id="networkChk" value="" />
						<input type="hidden" name="catalogSeq" id="catalogSeq" value="${getCatalogueSelectView.catalogSeq}" />
						<input type="hidden" name="cloudId" id="cloudId" value="" />
						<input type="hidden" name="cloudType" id="cloudType" value="" />
						<input type="hidden" name="apprvPass" id="apprvPass"	value="${apprvPass}" />
						<input type="hidden" name="selectApprv" id="selectApprv" value="" />
						<input type="hidden" name="hiddenUserIdReview" id="hiddenUserIdReview" value="" />
						<input type="hidden" name="hiddenUserNameReview" id="hiddenUserNameReview" value="" />
						<input type="hidden" name="hiddenUserIdApprove" id="hiddenUserIdApprove" value="" />
						<input type="hidden" name="hiddenUserNameApprove" id="hiddenUserNameApprove" value="" />
						<input type="hidden" name="approvalStepListString" id="approvalStepListString" />
						<table>
							<colgroup>
								<col width="140px" />
								<col width="*" />
								<col width="140px" />
								<col width="*" />
							</colgroup>
							<tbody>
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
												<c:if test="${cloudList.cloudType == 'openshift'}">
													<option value="${cloudList.cloudId}" data-cloud="${cloudList.cloudId}" data-type="${cloudList.cloudType}" data-name="${cloudList.cloudName}">${cloudList.cloudName}</option>
												</c:if>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>

								<tr>
									<td class="left">프로젝트명</td>
									<td>
										<div class="search-box">
											<input class="form-control" type="text" name="projectAlias" id="projectAlias" readonly="readonly"/>
											<input class="form-control" type="hidden" name="projectName" id="projectName" />
											<input type="hidden" name="projectBoxId" id="projectBoxId" value="" />
											<input type="hidden" name="projectId" id="projectId" value="" />
											<img src="${apachePath}/resources/assets/img/btn_search2.png"  onclick="openModal();" class="kepco-ser-icon"/>
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
									<td class="left">NAS 이름</td>
									<td>
										<input class="form-control" type="text" name="nasName" id="nasName"/>
									</td>

									<td class="left" scope="row">File Path</td>
									<td>
				                    	<div class="duplicate-check-box">
				                    		<input maxlength="30" class="form-control width-500" type="text" name="nasFileSystemPath" id="nasFileSystemPath" oninput="replace(this)"/>
				                    		<button type="button" onclick="pathChk();">중복체크</button>
			                    		</div>
									</td>
								</tr>
								<tr>
									<td class="left">NAS 용량</td>
									<td colspan="3">
										<div class="flex align-center">
											<input class="form-control w138" type="text"  placeholder="1" value="${getCatalogueSelectView.nasGb}"  maxlength="5" name="nasGb" id="nasGb" onkeypress="number_only(this);" onfocusout="diskfocusout(this);" onkeyup="diskchange(this);" style="ime-mode:disabled;" /> <p class="inputUnit" style="padding:7px 0 0 0;"> GB </p>
											<input type="hidden" name="diskprice" id="diskprice" value='<fmt:formatNumber value="${diskPrice}" pattern="####"/>'>
											<input type="hidden" name="diskprice1" id="diskprice1" value='<fmt:formatNumber value="${diskPrice1}" pattern="####"/>'>

											<div class="flex align-center">
												<img src="/resources/assets/img/icon_minus.png"  onclick="diskminus();" class="minus"/><span class="snemo">100</span>  <img src="/resources/assets/img/icon_plus.png"  onclick="diskplus();"  class="plus"/>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td class="left" scope="row">기타사항</td>
									<td colspan="3">
										<textarea rows="2" cols="100%" id="description" name="description"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					</div>
				</div>




				<div class="appTotal3" style="display:none;">
					<span class="llabel nanumR">총합계<span class="txttotal">(VAT 별도)</span></span>
					<span class="totalwonUnit"><span id="totalpriceview" name="totalpriceview"  class="totalwon nanumR"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/></span>&nbsp;원</span>
					<input type="hidden" name="imamount" id="imamount" value='<fmt:formatNumber value="${totalPrice}" pattern="#,###"/>' />
					<input type="hidden" name="amount" id="amount" value='<fmt:formatNumber value="${totalPrice}" pattern="####"/>' />
				</div>

				<div class="btn_area">
					<a type="button" class="btn_navy" onclick="openApproveReviewModal();">신청</a>
					<a type="button" class="btn_dngrey ml10" onclick="basketorder();">일괄신청</a>
					<a type="button" class="btn_lgrey ml10" onclick="moveListPage();">취소</a>
				</div>

			</div>
			<!---- end page body---->

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
	            			<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="okProjectInsert();">확인</a>
	            			<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
	                	</div>
	            	</div>
	            </div>
	        </div>
				<!-- #modal-dialog -->

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

			<!-- #modal-dialog 구매 확인-->
             <div class="modal fade pdManage" id="modal-dialog3">
	               <div class="modal-dialog width-720">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">신청확인</h4>
                           </div>
                           <div class="modal-body">
								<div class="tableE">
									<table>
										<colgroup>
											<col width="120px" />
											<col width="*" />
											<col width="120px" />
											<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th class="tal">프로젝트명</th>
												<td><span id="pop_projectAlias"></span></td>
												<th class="tal">NAS 이름</th>
												<td><span class="cnt nanumR" id="pop_nasName"></span></td>
											</tr>
											<tr>
												<th class="tal">희망일시</th>
												<td><span class="cnt" id="pop_onDemandFlag"></span></td>
												<th class="tal">개발/운영</th>
												<td><span class="cnt" id="pop_envTypeName"></span></td>
											</tr>
											<tr>
												<th class="tal">File Path</th>
												<td><span class="cnt" id="pop_nasFileSystemPath"></span></td>
												<th class="tal">NAS 용량</th>
												<td><span class="cnt" id="pop_nasGb"></span></td>
											</tr>
										</tbody>
								</table>
								<table style="margin-top:20px; border-top:1px solid #d3d3d3;">
										<colgroup>
											<col width="120px" />
											<col width="*" />
											<col width="120px" />
											<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th class="tal" colspan="4"><div class="flex center">MOUNT 필요</div></th>
											</tr>
											<tr>
												<td colspan="4">
													<div  class="flex center">90.1.1.231:/<span class="cnt" id="pop_nasFileSystemComment"></span></div>
													<div  class="flex center">90.1.1.232:/<span class="cnt" id="pop_nasFileSystemComment2"></span></div>
												</td>
											</tr>
										</tbody>
								</table>
								<p class="tac fc-red" style="margin:20px 0;">위 내용으로 신청 하시겠습니까?</p>
								</div>
							</div>
	                           <div class="modal-footer tac">
		                   			<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="request_noworder();">확인</a>
		                   			<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
		                       </div>
                          </div>
                       </div>
                </div>
            </div>
			<!-- #modal-dialog  구매 확인//-->


		<%-- 		<div class="modal fade pdManage" id="modal-srch-copy">
				    <div class="modal-dialog width-720">
				        <div class="modal-content width-720">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				                <h4 class="modal-title">수신자 선택</h4>
				            </div>
				            <div class="modal-body">
				                <!-- 2023 new search -->
				                <div class="col-xs-12 bgee modalpop mb20">
				                    <div class="new-search-modal">
				                        <div class="left">
				                            <div class="choice-kepco">
				                                <div class="select-kepco" for="vmSearchKind">
				                                    <button class="kep-label" id="vm_searchKind">전체</button>
				                                    <ul class="optionList">
				                                        <li class="optionItem" value="searchAll">전체</li>
				                                        <li class="optionItem" value="hostname_alias">서버명</li>
				                                        <li class="optionItem" value="hostname">호스트명</li>
				                                    </ul>
				                                </div>
				                            </div>
				                        </div>
				                        <div class="right">
				                            <input type="text" class="input-kepco-s" placeholder="검색어를 입력하세요" id="searchKeyword2" onkeypress="if(event.keyCode==13)gridVMList();" />
				                            <button type="button" class="kepco-ser-icon-modal2 vm" onclick="gridVMList();"></button>
				                        </div>
				                    </div>
				                </div>
				                <!-- 2023 new search END -->

				                <div style="max-height: 320px">
				                    <table class="tableV" id="VM-list">
				                        <colgroup>
				                            <col width="*">
				                            <col width="20%">
				                            <col width="20%">
				                        </colgroup>
				                        <thead id="pop_thead">
				                            <tr>
				                                <th>호스트명</th>
				                                <th>서버명</th>
				                                <th>추가</th>
				                            </tr>
				                        </thead>
				                        <tbody id="vmListTable">
				                        </tbody>
				                    </table>
				                </div>
				            </div>
				            <div class="clear"></div>
				            <div class="modal-footer tac">
				                <a type="button" class="m_btn_navy" data-dismiss="modal" id="addReceiverList">적용</a>
				                <a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
				            </div>
				        </div>
				    </div>
				</div> --%>


            <!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->

	<!-- end page container -->


<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	//결재라인 관련 변수
	var currentApprovalLine = "";
	var approvalList = [];

	function applyTimePlus(){
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

// 	function openModal2(){

// 		if ($("cloudType").val == "") {
// 			alertBox3("클라우드를 선택해주세요.")
// 			return false;
// 		}
// 		if ($("projectboxId").val == "") {
// 			alertBox3("프로젝트를를 선택해주세요.")
// 			return false;
// 		}
// 		gridVMList();
// 		$("#modal-srch-copy").modal();
// 	}

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
					d.searchKind = $("#vm_searchKind option:selected").val();
					d.keyword = $("#vm_keyword").val();
					d.projectName = $("#projectName").val();
					d.projectId = $("#projectId").val();
					d.projectBoxId = $("#projectBoxId").val();
				}
			}
			,"columns":[
				{"data":"hostname" , "class":"tal"}
				, {"data":"hostnameAlias" , "class":"tal"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[2], "render": function(data,type,full){
					return '<div class="tac"><a href="#nav-pills-tab-3-view" data-toggle="tab"><input type="button" class="popCheckbtn"  value="&#xf00c" onclick="setVM(this, \''+full.vmUuid+'\', \''+full.hostnameAlias+'\', \''+full.hostname+'\', \''+full.fiexIps+'\', \''+full.vcpus+'\', \''+full.memGb+'\', \''+full.diskGb+'\')"></a></div>';
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
			,"sDom":'<"top">rt<"bottom"i>'
		});
	}

	function projectPopList(){
		var keyword = $("#searchKeyword").val();
		var cloudId = ($("#cloudInfo > option:selected").data("cloud"));

		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/projectPopList",
			dataType : "JSON",
			//type : "POST",
			data : {
				"searchValue" : keyword,
				"cloudId" : cloudId,
			},
			success : function(data) {
				var projectList = data.getProjectList;

				if(projectList!=""){
					$("#popListTable > tr").remove();
					$.each(projectList,function(key,val){

						var Html="";
						Html="<tr>";
						    Html = Html + "<td class='tac'>"+val["projectName"]+"</td>";
					    	Html = Html + "<td class='tac'>"+val["projectAlias"]+" </td>";
							Html = Html + "<td class='tac'><input type='button' class='popCheckbtn'  value='&#xf00c' onclick='updateProject(this, \""+val["projectBoxId"]+"\", \""+val["projectId"]+"\", \""+val["projectName"]+"\", \""+val["projectAlias"]+"\" , \""+val["envType"]+"\")'></td>";
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

	var hprojectName, hprojectBoxId, hprojectId, hprojectAlias, hprojectType;


	function updateProject(e, projectBoxId, projectId, projectName,projectAlias, hprojectType){

		$("#popListTable > tr").find("input").removeClass("active");
		$(e).toggleClass("active");

		hprojectName = projectName;
		hprojectBoxId = projectBoxId;
		hprojectId = projectId;
		hprojectAlias = projectAlias;
	}

	function okProjectInsert(){
		$("#projectName").val(hprojectName);
		$("#projectBoxId").val(hprojectBoxId);
		$("#projectId").val(hprojectId);
		$("#projectAlias").val(hprojectAlias);
	}

	// 디스크 가격
	function diskplus(){
		if(Number($("#nasGb").val())>=10000){
			alertBox3("NAS는 10,000GB 이상<br/>신청하실수 없습니다.");
			$("#nasGb").val($("#imNasGb").val());
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").html(addcomma($("#totalPrice").val()));
		}else{
			var nasGb;
			var diskprice;
			var imamount;
			//alert($("#diskprice").val());
			nasGb = Number(rtnnumber($("#nasGb").val())) + 100;
			diskprice = Number(rtnnumber($("#diskprice").val()))*Number(nasGb)/10000;
			//alert(Number(rtnnumber($("#diskprice").val()))/10);
			//imamount = Number(rtnnumber($("#imamount").val()))+Number(rtnnumber($("#diskprice").val()))/10;
			imamount = diskprice;
			//alert(addcomma(diskprice));
			$("#nasGb").val(nasGb);
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma(diskprice));
			$("#imamount").val(addcomma(imamount));
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(imamount));
			$("#totalPrice").val(addcomma(imamount));
			$("#imdiskprice").val(diskprice);
			$("#imNasGb").val($("#nasGb").val());
		}
	}

	function diskminus(){
			//alert($("#nasGb").val());
			if(Number($("#nasGb").val())<=100){
				alertBox3("NAS는 최소 100GB 이상<br/>신청하셔야 합니다.");
				$("#nasGb").val($("#imNasGb").val());
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").html(addcomma($("#totalPrice").val()));
			}else{
				var nasGb;
				var diskprice;
				var imamount;
				//alert($("#diskprice").val());
				nasGb = Number(rtnnumber($("#nasGb").val())) - 100;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number(nasGb)/10000;
				//alert(Number(rtnnumber($("#diskprice").val()))/10);
				//imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#diskprice").val()))/10;
				imamount = diskprice;
				//alert(addcomma(diskprice));
				$("#nasGb").val(nasGb);
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
				$("#imdiskprice").val(diskprice);
				$("#imNasGb").val($("#nasGb").val());
			}

	}

	function diskfocusout(id){
		//alert(id);
		var nasGb;
		nasGb = Number($(id).val());
		//alert(nasGb);
		if(nasGb<100){
			alertBox3("NAS는 최소 100GB 이상<br/>신청하셔야 합니다.");
			$(id).val($("#imNasGb").val());
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").empty();
			$("#totalpriceview").html(addcomma($("#totalPrice").val()));
		}else if(nasGb>10000){
			alertBox3("NAS는 10,000GB 이상<br/>신청하실수 없습니다.");
			$(id).val($("#imNasGb").val());
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").empty();
			$("#totalpriceview").html(addcomma($("#totalPrice").val()));
		}else{
			var imNasGb = nasGb % 100;
			if(imNasGb==0){
				var diskprice;
				var imamount;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/10000; // 디스크가격
				//alert(diskprice);
				//alert($("#imdiskprice").val());
				//imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
				//imamount =  imamount + diskprice ; //총가격에 디스크 가격 추가
				imamount = diskprice;
				//alert(imamount);

				$("#imNasGb").val($(id).val());
				$("#imdiskprice").val(diskprice);
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}else{
				alertBox3("NAS는 100GB 단위로<br/>신청하실수 있습니다.");
				$(id).val($("#imNasGb").val());
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").html(addcomma($("#totalPrice").val()));
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
			diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/10000;
			//imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
			//imamount =  imamount + diskprice ;
			imamount =  diskprice ;
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma(diskprice));
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(imamount));
		}else{
			var imNasGb = Number(diskval) % 100;
			if(imNasGb==0){
				var diskprice;
				var imamount;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/10000;
				//imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
				//imamount =  imamount + diskprice ;
				imamount =  diskprice ;
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
		var nasGb = $("#nasGb").val();

		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/getcatalogueDiskOrderView",
			dataType : "JSON",
	//			type : "POST",
			data : {
				"productSeq" : productSeq
				,"hourlyFlag" : hourlyFlag
				,"nasGb" : nasGb
			},
			success : function(data) {
				//alert(data.productSeq);
				//alert(nasGb);

				if(hourlyFlag=="N"){
					//월 금액
					//var totalPrice = data.diskMonthlyPrice * data.diskGb / 10;
					var totalPrice = data.nasMonthlyPrice * nasGb / data.nasQuantity;
					var diskprice = data.nasMonthlyPrice * data.nasQuantity;
					var diskprice1 = data.nasMonthlyPrice * nasGb / data.nasQuantity;

					$("#diskpriceview").empty();
					$("#diskpriceview").append(addcomma(diskprice1));
					$("#totalpriceview").empty();
					$("#totalpriceview").append(addcomma(totalPrice));

					$("#totalPrice").val(totalPrice);
					$("#diskprice").val(diskprice);
					$("#diskprice1").val(diskprice1);
					$("#imdiskprice").val(diskprice1);
					$("#imNasGb").val(nasGb);
					$("#imamount").val(totalPrice);
					$("#amount").val(totalPrice);
					//$("#diskpriceview").empty();
					//$("#diskpriceview").append(addcomma(diskprice));
					//$("#totalpriceview").empty();
					//$("#totalpriceview").append(addcomma(imamount));
					//$("#totalPrice").val();
				}else{
					//시간 금액
					var totalPrice = data.nasHourlyPrice * nasGb / data.nasQuantity;
					var diskprice = data.nasHourlyPrice * data.nasQuantity;
					var diskprice1 = data.nasHourlyPrice * nasGb / data.nasQuantity;

					$("#diskpriceview").empty();
					$("#diskpriceview").append(addcomma(diskprice1));
					$("#totalpriceview").empty();
					$("#totalpriceview").append(addcomma(totalPrice));

					$("#totalPrice").val(totalPrice);
					$("#diskprice").val(diskprice);
					$("#diskprice1").val(diskprice1);
					$("#imdiskprice").val(diskprice1);
					$("#imNasGb").val(nasGb);
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
		$("#pop_projectAlias").text($("#projectAlias").val());

		if ($("input[name='onDemandFlag']:checked").val() == 'N') {
			$("#pop_onDemandFlag").text($("#applyDate").val()+' '+$("#applyTime").val()+':00');
		} else if ($("input[name='onDemandFlag']:checked").val() == 'Y') {
			$("#pop_onDemandFlag").text('승인 완료 후 생성');
		}

		$("#pop_nasName").text($("#nasName").val());
		$("#pop_nasAlias").text($("#nasName").val());
		$("#pop_nasGb").text(addcomma($("#nasGb").val()) + " GB");
// 		$("#pop_saveType").text($("#saveType").val());
		$("#pop_envType").text($("#envType").val());
		$("#pop_envTypeName").text($("#envType option:selected").val());
		$("#pop_nasFileSystemPath").text("/"+$("#projectName").val() + "." + $("#nasFileSystemPath").val());  //   /projectName.mountPath
		$("#pop_nasFileSystemComment").text($("#projectName").val() + "." + $("#nasFileSystemPath").val());
		$("#pop_nasFileSystemComment2").text($("#projectName").val() + "." + $("#nasFileSystemPath").val());
		$("#pop_vmName").text($("#vmName").val());
		if ($("input[name='hourlyFlag']:checked").val() == 'N') {
			$("#pop_hourlyFlag").text('월');
		} else if ($("input[name='hourlyFlag']:checked").val() == 'Y') {
			$("#pop_hourlyFlag").text('시간');
		}
// 		$("#pop_totalPrice").text(addcomma(rtnnumber($("#totalPrice").val())));
		$("#approvalStepListString").val(JSON.stringify(approvalList));
	}

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

		if($("#projectName").val()==""){
			alertBox3("프로젝트를 입력하세요");
			return false;
		}
		if($("#nasName").val()==""){
			alertBox3("NAS 이름를 입력하세요");
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


	// 바로신청
	function noworder(){
		if( (approvalList[3] == undefined || approvalList[3] == null || approvalList[3] == '') && $("#selectApprv").val() == 'N') {
			alertBox3("결재자를 지정해 주세요");
			return false;
		}

		//$("#catalogueform").submit();
		setOrder();
		$("#modal-dialog3").modal();
	}


	function request_noworder(){
		$("#approvalStepListString").val(JSON.stringify(approvalList));
// 		$("#catalogueform").submit();
		catalogueOrderInsert();
	}

	function catalogueOrderInsert(){
		var jsonData = setJsonData();
		var data = $("#catalogueform").serialize();
		var data = data + "&amount=" + rtnnumber($("#totalPrice").val());
		$.ajax({
			url : "catalogueNasOrderNow",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
// 			data : data,
			success : function(data) {
				parent.moveLocation("${wasPath}/mbr/req/catalogue/bssOrderList");
			},
			error : function(request, status, error) {
				//alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}



// 	// jsonData 세팅
	function setJsonData(){

		$("#amount").val(rtnnumber($("#amount").val()));

		var applyDatetime = $("#applyDatetime").val();
		var jsonData;

		if(applyDatetime == ""){
			jsonData={
					"type" : $("#type").val()
					, "nasProductSeq" : $("#productSeq").val()
					, "amount" : $("#amount").val()
					, "apprvPass" : $("#apprvPass").val()
					, "selectApprv" : $("#selectApprv").val()
					, "onDemandFlag" : $("input[name='onDemandFlag']:checked").val()
					, "projectName" : $("#projectName").val()
					, "diskGb" : $("#diskGb").val()
					, "projectId" : $("#projectId").val()
					, "projectBoxId" : $("#projectBoxId").val()
					, "productCategory" : $("#productCategory").val()
					, "hourlyFlag" : $("input[name='hourlyFlag']:checked").val()
					, "orderName" : $("#orderName").val()
					, "description" : $("#description").val()
					, "vmName" : $("#vmName").val()
					, "vmUuid" : $("#vmUuid").val()
					, "nasName" : $("#nasName").val()
					, "nasAlias" : $("#nasName").val()
					, "envType" : $("#envType").val()
					, "catalogSeq" : $("#catalogSeq").val()
					, "cloudType" : $("#cloudType").val()
					, "requestType" : ""
					, "nasId" : $("#nasId").val()
					, "nasFileSystemPath" : "/" + $("#projectName").val() + "." + $("#nasFileSystemPath").val()   // 1depth만 허용 /projectname.filepath 형식
					, "nasGb" : $("#nasGb").val()
					, "beforeNasGb" : $("#beforeNasGb").val()
					, "cloudId" : $("#cloudId").val()
					, "approvalStepListString" : $("#approvalStepListString").val()
					, "hiddenUserIdReview" : $("#hiddenUserIdReview").val()
					, "hiddenUserNameReview" : $("#hiddenUserNameReview").val()
					, "hiddenUserIdApprove" : $("#hiddenUserIdApprove").val()
					, "hiddenUserNameApprove" : $("#hiddenUserNameApprove").val()
				}
		}else{
			jsonData={
					"type" : $("#type").val()
					, "nasProductSeq" : $("#productSeq").val()
					, "amount" : $("#amount").val()
					, "apprvPass" : $("#apprvPass").val()
					, "selectApprv" : $("#selectApprv").val()
					, "applyDatetime" : $("#applyDatetime").val()
					, "onDemandFlag" : $("input[name='onDemandFlag']:checked").val()
					, "projectName" : $("#projectName").val()
					, "diskGb" : $("#diskGb").val()
					, "projectId" : $("#projectId").val()
					, "projectBoxId" : $("#projectBoxId").val()
					, "productCategory" : $("#productCategory").val()
					, "hourlyFlag" : $("input[name='hourlyFlag']:checked").val()
					, "orderName" : $("#orderName").val()
					, "description" : $("#description").val()
					, "vmName" : $("#vmName").val()
					, "vmUuid" : $("#vmUuid").val()
					, "nasName" : $("#nasName").val()
					, "nasAlias" : $("#nasName").val()
					, "envType" : $("#envType").val()
					, "catalogSeq" : $("#catalogSeq").val()
					, "cloudType" : $("#cloudType").val()
					, "requestType" : ""
					, "nasId" : $("#nasId").val()
					, "nasFileSystemPath" :"/" + $("#projectName").val() + "." + $("#nasFileSystemPath").val()   // 1depth만 허용 projectname.filepath 형식
					, "nasGb" : $("#nasGb").val()
					, "beforeNasGb" : $("#beforeNasGb").val()
					, "cloudId" : $("#cloudId").val()
					, "approvalStepListString" : $("#approvalStepListString").val()
					, "hiddenUserIdReview" : $("#hiddenUserIdReview").val()
					, "hiddenUserNameReview" : $("#hiddenUserNameReview").val()
					, "hiddenUserIdApprove" : $("#hiddenUserIdApprove").val()
					, "hiddenUserNameApprove" : $("#hiddenUserNameApprove").val()
				}
		}

		return jsonData;
	}

	// 일괄신청
	function basketorder(){
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
		/*
		if($("#vmName").val()==""){
			alertBox3("가상서버를 입력하세요");
			return false;
		}
		*/
		if($("#nasName").val()==""){
			alertBox3("NAS 이름를 입력하세요");
			return false;
		}

		console.log($("#nasFileSystemPath").val());
		$("#totalPrice").val(rtnnumber($("#totalPrice").val()));
		$("#catalogueform").attr('action','basketOrder.do');
		//$("#catalogueform").submit();

		var params = $('#catalogueform').serialize();

		console.log(params);

		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/basketOrder2.do",
			dataType : "JSON",
			type : "POST",
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
		});
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

		$("img.ui-datepicker-trigger").attr("style", "vertical-align:bottom;");

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
			//alert($("input[name='hourlyFlag']:checked").val());
		});

		$("input[name='onDemandFlag']").on('click',function(){
			//alert($("input[name='onDemandFlag']:checked").val());
			if($("input[name='onDemandFlag']:checked").val()=="N"){
				$("#sdate").show();
			}else{
				$("#sdate").hide();
			}

		});

		//메뉴활성화
		$("#reqProduct").addClass("active");
		$("#pv").addClass("active");
	});

	function selectCloud(){
		var cloudId = ($("#cloudInfo > option:selected").data("cloud"));
		var cloudType = $("#cloudInfo > option:selected").data("type");
		$("#cloudId").val(cloudId);
		$("#cloudType").val(cloudType);
	}

	function replace(input) {
		input.value = input.value.replace(/\//g, '');
	}

	function pathChk(){

		if($("#nasFileSystemPath").val()==""){
			warningBox("경로를 입력하세요.");
			return;
		}

		if($("#projectName").val()==""){
			warningBox("프로젝트를 선택하세요.");
			return;
		}

		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/pathChk",
			data : {
// 				"nasFileSystemPath" : $("#nasFileSystemPath").val()
				"nasFileSystemPath" : "/" + $("#projectName").val() + "." + $("#nasFileSystemPath").val()

			},
			success : function(data) {
				var chkVal = data;
				if(chkVal==0){
					$("#confirmMsg").css("color","blue");
					$("#confirmFlag").val("Y");
					alertBox("사용 가능한 경로입니다.");
					$("#confirmFlag").val("Y")
				}else{
					$("#confirmMsg").css("color","#ff0000");
					$("#confirmFlag").val("N");
					alertBox("중복된 경로입니다.");
					$("#confirmFlag").val("N")
				}
			},
			error : function(request, status, error) {
				alert("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});

	}


</script>
</body>
</html>