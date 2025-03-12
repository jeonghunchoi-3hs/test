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

<c:set var="contextPath" value="${wasPath}"></c:set>

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
			<!-- begin #header -->
			<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->

			<!-- begin #sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #content -->
			<div id="content" class="content">

				 <p class="page_title">로드밸런싱 신청
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> 서비스 신청 <span class="arrow_ab"> &#8227; </span> <b>로드밸런싱 신청 </b>
			    </span>
		    	</p>

				 <!-- begin page-body -->
				 <div class="row p20 bgwh br10">


			<%-- 		<div class="productTotalArea">
						<div class="productTitleArea">
							<img src="${getCatalogueSubList.imageName}" class=" width-120 pt10"/>

							<span class="productTitle">
							${getCatalogueSubList.displayName}
							</span>
							<!-- <p class="productsubTitle">고객사의 사업을 더욱더 활성화하고 성공비지니스를 안겨 줄 것 입니다</p> -->
							<p class="productsubTitle">
							<c:if test="${getCatalogueSubList.descriptionTop eq null or getCatalogueSubList.descriptionTop eq ''}">
							안정적인 서비스 제공하기 위해 필요한 서비스 로드분산을 신청하기 위한 서비스 로드분산입니다.
							</c:if>
							<c:if test="${getCatalogueSubList.descriptionTop ne null or getCatalogueSubList.descriptionTop ne ''}">
							${getCatalogueSubList.descriptionTop}
							</c:if>
							</p>
						</div>
					</div>  --%>

					<div class="product_box">
					  <li class="img"><img src="${getCatalogueSubList.imageName}" class="width-80"/></li>
					  <li class="description">
					      <span class="productTitle">${getCatalogueSubList.displayName}</span>
					       <p class="productsubTitle">
					      <c:if test="${getCatalogueSubList.descriptionTop eq null or getCatalogueSubList.descriptionTop eq ''}">
							안정적인 서비스 제공하기 위해 필요한 서비스 로드분산을 신청하기 위한 서비스 로드분산입니다.
							</c:if>
							<c:if test="${getCatalogueSubList.descriptionTop ne null or getCatalogueSubList.descriptionTop ne ''}">
							${getCatalogueSubList.descriptionTop}
							</c:if>
					        </p>
					  </li>
					  <ul class="product_sub">
					  <%-- <li class="disk"><img src="/resources/assets/img/icon_disk.png"/> DISK  <span class="fc_green_im flr f24 lh20"> ${getCatalogueSelectView.diskGb} <span class="f16 fc33">GB</span></span></li>
					    <li class="memory"><img src="/resources/assets/img/icon_mem.png"/> MEMORY <span class="fc_blue_im flr f24 lh20"> ${getCatalogueSelectView.memGb} <span class="f16 fc33">GB</span></span></li>
					   <li class="cpu"><img src="/resources/assets/img/icon_cpu.png"/> vCPU  <span class="fc_purple_im flr f24 lh20">${getCatalogueSelectView.vcpus} <span class="f16 fc33">Core</span></span></li> --%>
					  </ul>
					</div>



					<div class="clear"></div>
					<div class="orderArea">
						<div class="tableF">
							<form name="catalogueform"  id="catalogueform" action="${wasPath}/mbr/req/catalogue/catalogueLoadBalancer" method="post" >
								<input type="hidden" name="type" id="type" value="noworder" />
								<input type="hidden" name="imageName" id="imageName" value="${getCatalogueSubList.imageName}" />
								<input type="hidden" name="productSeq" id="productSeq" value="${getCatalogueSubList.productSeq}" />
								<input type="hidden" name="totalPrice" id="totalPrice" value="${getCatalogueSubList.monthlyPrice}"/>
								<input type="hidden" name="productCategory" id="productCategory" value="${getCatalogueSubList.productCategory}" />
								<input type="hidden" name="hourlyFlag" id="hourlyFlag" value="${hourlyvo.hourlyFlag}" />
								<input type="hidden" name="vmNetworkChk" id="vmNetworkChk" value="" />
								<input type="hidden" name="lowProjectName" id="lowProjectName" value="" />
								<input type="hidden" name="networkAlias" id="networkAlias" value="" />
								<input type="hidden" name="catalogSeq" id="catalogSeq" value="${getCatalogueSubList.catalogSeq}" />
								<input type="hidden" name="loadbalancerProductSeq" id="loadbalancerProductSeq" value="${getCatalogueSubList.productSeq}" />
								<input type="hidden" name="apprvPass" id="apprvPass"				value="${apprvPass}" />
								<input type="hidden" name="selectApprv" id="selectApprv"			value="" />
								<input type="hidden" name="applyDatetime" id="applyDatetime" value="" />
								<input type="hidden" name="approvalStepListString" id="approvalStepListString" />

								<table>
									<colgroup>
										<col width="9%">
										<col width="40%">
										<col width="9%">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<td class="left-t">서비스희망일시</td>
											<td colspan="3">
												<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성</label>     &nbsp;&nbsp;
												<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> <span class="mr14">희망일시 생성 </span></label><br/>
												   <div class="fc-dblue2 f14 pt10" id="selectTEXT" ><i class='fa fa-exclamation-circle f16 fc-dblue2'></i><span class="fb"> 관리자의 최종승인 후 서비스 로드분산이 생성이 됩니다. </span></div>
											</td>
										</tr>
										<tr id="sdate" name="sdate" style="display:none">
											<td class="left"></td>
											<td>
											<div>
												<input type="text" class="form-control dpin w138" id="applyDate" name="applyDate" />
												<div class="searchBoxArea w110 ml26">
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
											</div>
											</td>
										</tr>
										<tr>
											<td class="left">프로젝트명</td>
											<td>
												<input class="form-control" type="text" name="projectAlias" id="projectAlias" readonly="readonly"/>
												<input class="form-control" type="hidden" name="projectName" id="projectName" />
												<input type="hidden" name="projectBoxId" id="projectBoxId" value="" />
												<input type="hidden" name="projectId" id="projectId" value="" />
											<!-- 	<img src="/resources/assets/img/icon_search.png" onclick="openModal();"class="input_search t6 r0"/> -->
												<img src="${apachePath}/resources/assets/img/btn_search2.png" height=32px;  onclick="openModal();" class="pa-t14r20"/>
											</td>
											<td class="left" scope="row">로드밸런서명</td>
											<td>
												<input maxlength="30" class="form-control width-505" type="text" name="loadbalancerName" id="loadbalancerName" />
											</td>
										</tr>
										<tr>
											<td class="left" scope="row">네트워크</td>
											<td>
												<div id="divNetwork">
													<div class='searchBoxArea2'>
														<div class=''>
															<label class='selectBoxDrop' for='networkId'>선택해주세요.</label>
															<select class='search-sel' id='defaultNetworkId' name='defaultNetworkId' onChange='selectNetwork()'>
																<option value="">선택해주세요.</option>
																<c:forEach items="${networkList}" var="networkList" varStatus="status">
																	<option value="${networkList.networkId}" volume="${networkList.volumeType}">${networkList.networkAlias}</option>
																</c:forEach>
															</select>
														</div>
													</div>
												</div>
											</td>
											<td class="left" scope="row" style="display:none">IP</td>
											<td style="display:none">
												<input maxlength="30" class="form-control width-505" type="text" name="ip" id="ip" />
											</td>
											<td class="left" scope="row">Port</td>
											<td>
												<input maxlength="30" class="form-control width-505" type="text" name="port" id="port" />
											</td>
										</tr>
										<tr>
											<td class="left" scope="row">프로토콜</td>
											<td>
												<div id="divNetwork">
													<div class='searchBoxArea2'>
														<div class=''>
															<label class='selectBoxDrop' for='networkId'>선택해주세요.</label>
															<select class='search-sel' id='protocol' name='protocol'>
																<option value="">선택해주세요.</option>
																<c:forEach items="${protocolList}" var="protocolList" varStatus="status">
																	<option value="${protocolList.codeName}">${protocolList.codeName}</option>
																</c:forEach>
															</select>
														</div>
													</div>
												</div>
											</td>
											<td class="left" scope="row">Method</td>
											<td>
												<div id="divNetwork">
													<div class='searchBoxArea2'>
														<div class=''>
															<label class='selectBoxDrop' for='networkId'>선택해주세요.</label>
															<select class='search-sel' id='method' name='method'>
																<option value="">선택해주세요.</option>
																<c:forEach items="${methodList}" var="methodList" varStatus="status">
																	<option value="${methodList.codeName}">${methodList.codeName}</option>
																</c:forEach>
															</select>
														</div>
													</div>
												</div>
											</td>
										</tr>
									</tbody>
								</table>

									<div class="inbox101 pt20 pb30">
								 				<h5 class="subtitle">가상서버   <a type="button" onclick="openModal2();" class="bton-s bton_blue" style="float:right;margin-bottom:10px;  "><span> 추가</span></a></h5>

								 				<div class="panel mb0">
								 					<div>
								 						<table class="tableV" id="vmInsert">
								 							<colgroup>
																 <col width="10%">
																 <col width="10%">
																 <col width="10%">
																 <col width="10%">
																 <col width="15%">
																 <col width="10%">
															     <col width="10%">
																 <col width="40px">
															</colgroup>
															<thead>
																<tr class="skyblue">
																    <th>클라우드</th>
																    <th>서버명</th>
																	<th>호스트명</th>
																	<th>IP</th>
																	<th>vCPU (Core)</th>
																	<th>MEMORY (GB)</th>
																	<th>DISK (GB)</th>
																	<th>삭제</th>
																</tr>
															</thead>
															<tbody>
															</tbody>
								 						</table>
								 					</div>
								 				</div>
								 	</div>
							</form>
						</div>
					</div>

					<div class="btn_area">
						<a type="button" class="btn_navy"  onclick="openApproveReviewModal();">신청</a>
						<!-- <a type="button" class="bbton bton_green ml10" onclick="basketorder();"><span class="dpin dd bton_dgreen ml-1"><i class="fa fa-cart-arrow-down"></i></span><span class="dpin ml16">일괄신청</span></a>-->
						<a type="button" class="btn_lgrey ml10" onclick="moveListPage();"> 취소</a>
					</div>

				</div>
				<!-- begin #footer -->

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
								 <!--//검색 시작// 모달검색은 이걸 가져다 쓰면 됩니다. 2191217 nandakim-->
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
										<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="searchKeyword" >
										<button type="button" class="btn_search2 vm" onclick="projectPopList();"><span></span></button>
									</div>
								</div>
								<!--검색  끝//-->
								<div class="popListTable">
									<table class="tableV">
										<colgroup>
											<col width="*">
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
								<!-- search begin -->
								<div class="col-md-12 bgee modalpop mb20">
									<div class="" style="text-align: center; display:inline-block;">
										<div class="col-md-1">
											<label class="selectText" for="billYear">서버명</label>
											<select class="search-sel" id="billYear" name="billYear">
												<option value="">서버명</option>
												<option value="2017">호스트명</option>
											</select>
										</div>
										<div class="col-md-6">
											<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="searchKeyword2" data-original-title="" title="">
										</div>
										<button type="button" class="btn_search2" onclick="gridVMList();"><span></span></button>
									</div>
								</div>
								<!-- search end -->
								<div>
									<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="VM-list">
										<colgroup>
											<col width="40%">
											<col width="40%">
					 						<col width="20%">
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
									<strong class="title" id="pop_loadbalancerName"></strong>
									<div class="detailBox">
										<div class="boxType02">
											<ul>
												<li><span class="title">요청유형</span><span class="cnt">신규</span></li>
												<li><span class="title">port</span><span class="cnt" id="pop_port"></span></li>
												<li><span class="title">희망일시</span><span class="cnt" id="pop_onDemandFlag"></span></li>
												<li><span class="title">네트워크</span><span class="cnt" id="pop_network"></span></li>
												<li><span class="title">Method</span><span class="cnt" id="pop_method"></span></li>
												<li><span class="title">프로토콜</span><span class="cnt" id="pop_protocol"></span></li>

											</ul>
										</div>
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
				<!-- #modal-dialog -->
				<!-- end #content -->
				<!-- end #footer -->
				<!---- end page body---->


	<!-- end page container -->
		<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
	    </div>
		</div>
		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	var approvalList = [];

	function openModal(){
		$("#modal-dialog").modal();
		projectPopList();
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
							Html = Html + "<td class='tac'><input type='button' class='popCheckbtn'  value='&#xf00c' onclick='updateProject(this, \""+val["projectBoxId"]+"\", \""+val["projectName"]+"\", \""+val["projectAlias"]+"\")'></td>";
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

	function openModal2(){
		if($("#projectBoxId").val() == ""){
			alertBox3("프로젝트를 선택해주세요.");
			return false;
		}
		$("#modal-dialog2").modal();
		gridVMList();
	}

	function okVMInsert() {
		$(".setVM").each(function(){
			if($(this).hasClass("active") === true) {
				console.log($(this));
				var html = "<tr>";
				html += "<td>"+$(this).data("cloudname")+"<input type='hidden' name='vmUuid' value='"+$(this).data("vmuuid")+"'></td>";
				html += "<td>"+$(this).data("hostnamealias")+"</td>";
				html += "<td>"+$(this).data("hostname")+"</td>";
				html += "<td>"+$(this).data("fixedips")+"</td>";
				html += "<td>"+$(this).data("vcpus")+"</td>";
				html += "<td>"+$(this).data("memgb")+"</td>";
				html += "<td>"+$(this).data("diskgb")+"</td>";
				html += "<td><a class='MultiFile-remove'></a></td>";
				html += "</tr>";
				$("#vmInsert tbody").append(html);
			}
		})
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
					d.searchKind = "hostname_alias";
					d.keyword = $("#searchKeyword2").val();
					d.projectName = $("#projectName").val();
					d.projectId = $("#projectBoxId").val();
					d.volumeType = $("#diskType").val();
				}
				,"dataSrc": function ( json ) {
					var list = new Array();
					var filterData = new Array();
				    $("input[name=vmUuid]").each(function(index, item){
					    list.push($(item).val());
				    });
					$.each(json.data,function(index,item){
						if($.inArray(item.vmUuid,list) > -1){
							$.inArray(item.vmUuid,list,1)
						} else {
							filterData.push(item);
						}
					})
	      	        return filterData;
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
					return '<input type="button" class="popCheckbtn setVM" value="&#xf00c" data-vmUuid="'+full.vmUuid+'" data-hostnameAlias="'+full.hostnameAlias+'" data-hostname="'+full.hostname+'" data-cloudType="'+full.cloudType+'" data-cloudName="'+full.cloudName+'" data-cloudId="'+full.cloudId+'" data-projectId="'+full.projectId+'" data-vcpus="'+full.vcpus+'" data-memGb="'+full.memGb+'" data-diskGb="'+full.diskGb+'" data-fixedIps="'+full.fixedIps+'">';
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

	var hprojectName, hprojectId, hprojectAlias, hvmUuid, hvmName, hvmHost,hcloudId,hcloudName,hcloudType,hprojectBoxId,hvCpus,hmemGb,hdiskGb,hfixedIps;

	$(document).on("click",".setVM",function(e){
		$(this).toggleClass("active");
	})
	function setVM(e, vmUuid, vmName, vmHost,cloudType,cloudName,cloudId,projectId,vCpus,memGb,diskGb,fixedIps){
		$("#popListTable2 > tr").find("input").removeClass("active");
		$(e).toggleClass("active");
		if($(e).hasClass("active")){
			hvmUuid = vmUuid;
			hvmName = vmName;
			hvmHost = vmHost;
			hcloudId = cloudId;
			hcloudType = cloudType;
			hcloudName = cloudName;
			hprojectId = projectId;
			hvCpus = vCpus;
			hmemGb = memGb;
			hdiskGb = diskGb;
			hFixedIps = fixedIps;
		} else {
			hvmUuid = "";
			hvmName = "";
			hvmHost = "";
			hcloudId = "";
			hcloudName = "";
			hcloudType = "";
			hprojectId = "";
			hvCpus = "";
			hmemGb = "";
			hdiskGb = "";
			hFixedIps = "";
		}
	}

	function updateProject(e, projectId, projectName,projectAlias){
		$("#popListTable > tr").find("input").removeClass("active");
		$(e).toggleClass("active");
		hprojectName = projectName;
		hprojectBoxId = projectId;
		hprojectAlias = projectAlias;
		hvmUuid = "";
		hvmName = "";
		hvmHost = "";
		hcloudId = "";
		hcloudName = "";
		hcloudType = "";
		hprojectId = "";
		hvCpus = "";
		hmemGb = "";
		hdiskGb = "";
		hFixedIps = "";
	}

	function okProjectInsert(){
		$("#projectName").val(hprojectName);
		$("#projectBoxId").val(hprojectBoxId);
		$("#projectAlias").val(hprojectAlias);
		$("#vmUuid").val(hvmUuid);
		$("#vmName").val(hvmName);
		$("#vmHost").val(hvmHost);
		$("#vmBtn").show();
	}

	// 달력
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
		$("img.ui-datepicker-trigger").attr("style", "vertical-align:top;");

		$("#applyDate").val($.datepicker.formatDate('yy-mm-dd', new Date()));
	}

	$(document).ready(function() {
	    App.init();
	    calendar();
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
		$("#reqProduct").addClass("active");
		$("#service").addClass("active");

	});

	$("#projectAlias").change(function(){
		$(".tableV tbody").empty();
	})

	$(document).on("click",".MultiFile-remove",function(){
		$(this).parents("tr").remove();
	})

	function openApproveReviewModal() {

		if($("#projectName").val()==""){
			alertBox3("프로젝트를 입력하세요.");
			return false;
		}

		if($("#loadbalancerName").val()==""){
			alertBox3("로드밸런서명을 입력하세요.");
			return false;
		}

		if($("#defaultNetworkId").val()==""){
			alertBox3("네트워크를 선택하세요.");
			return false;
		}
		if($("#port").val()==""){
			alertBox3("port를 입력하세요.");
			return false;
		}
		if($("#protocol").val()==""){
			alertBox3("프로토콜를 입력하세요.");
			return false;
		}
		if($("#method").val()==""){
			alertBox3("method를 입력하세요.");
			return false;
		}

		if($("input[name=vmUuid]").length == 0){
			alertBox3("가상서버를 등록하세요.");
			return false;
		}

		if($("#apprvPass").val() == "Y"){
			confirmBox4("결재자를 지정하시겠습니까?",approvSelect,nApprovSelect);
		} else {
			approvSelect();
		}
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

	function nApprovSelect(){
		$("#selectApprv").val("Y");
		noworder();
	}
	function approvSelect(){
		$("#selectApprv").val("N");
		$("#modal-approve-dialog").modal();
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

	function setOrder() {
		$("#pop_projectAlias").text($("#projectAlias").val());
		$("#pop_hostnameAlias").text($("#hostnameAlias").val());
		$("#pop_network").text($("#defaultNetworkId option:selected").val());

		$("#pop_port").text($("#port").val());
		$("#pop_method").text($("#method").val());
		$("#pop_protocol").text($("#protocol").val());
		$("#pop_loadbalancerName").text($("#loadbalancerName").val());
		if ($("input[name='onDemandFlag']:checked").val() == 'N') {
			$("#pop_onDemandFlag").text($("#applyDate").val()+' '+$("#applyTime").val()+':00');
			$("#applyDatetime").val($("#applyDate").val()+' '+$("#applyTime").val()+':00');
		} else if ($("input[name='onDemandFlag']:checked").val() == 'Y') {
			$("#pop_onDemandFlag").text('승인 완료 후 생성');
		}
	}
	// 바로신청
	function noworder(){
		if( (approvalList[3] == undefined || approvalList[3] == null || approvalList[3] == '') && $("#selectApprv").val() == 'N') {
			alertBox3("결재자를 지정해 주세요");
			return false;
		}
		setOrder();
		//$("#catalogueform").submit();
		$("#modal-dialog3").modal();
	}
	function request_noworder(){
		//$("#catalogueform").submit();

		//$("#orderform").submit();
		if( approvalList[0] == undefined || approvalList[0] == null) {
			var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
			approvalList[0] = tmp;
		}
		$("#approvalStepListString").val(JSON.stringify(approvalList));

		var type = $("#catalogueform").attr("type");
		var url = $("#catalogueform").attr("action");
		var data = $("#catalogueform").serialize();
		var data = data;
		$.ajax({
			url:url,
			type:type,
			data:data,
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

	function insertVmUuid(){
		var data = $("#catalogueform").serialize();
		$.ajax({
			url:"${wasPath}/mbr/req/catalogue/catalogueLoadBalancerVm",
			type:"POST",
			data:data,
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
		location.href="${wasPath}/mbr/req/catalogue/bssOrderApproveList";
	}
	</script>

</body>
</html>