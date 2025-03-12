<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

		<!-- begin #content -->
		<div id="content" class="content">

			<!-- begin header -->
			<div class="page_header mb30">
				<h1>자원구성 등록</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">자원관리</a><a href="#" class="on">자원구성 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<input type="hidden" id="itemId" value="${itemId}">
				<input type="hidden" id="cloudId">
				<input type="hidden" id="cloudType">
				<input type="hidden" id="envEa">


				<c:forEach items="${getItemPrice}" var="getItemPrice" varStatus="status" >
				   <input type="hidden" id="${getItemPrice.itemId}Hourly" value="${getItemPrice.quantityHourly}">
				</c:forEach>

				<c:forEach items="${getItemPrice}" var="getItemPrice" varStatus="status" >
				   <input type="hidden" id="${getItemPrice.itemId}Monthly" value="${getItemPrice.quantityMonthly}">
				</c:forEach>

				<c:forEach items="${getItemPrice}" var="getItemPrice" varStatus="status" >
				   <input type="hidden" id="${getItemPrice.itemId}" value="${getItemPrice.itemId}">
				</c:forEach>


				<div class="formType01" >
					<h2 class="titleBuType01"><span class="bullet"></span> 자원 정보</h2>
					<div class="tblWrap clearfix">
						<table style="border-collapse: separate !important;">
							<colgroup>
								 <col width="197px">
								 <col width="*">
							</colgroup>

								<tr>
									<th scope="row"><strong>자원 카테고리</strong></th>
									<td>
										<div class="selectBox" style="width:356px;">
											<label class="selectText"  for="productCategoryName">자원 카테고리 선택</label>
											<select class="search-sel" name="productCategoryName" id="productCategoryName" onchange="productCategoryselect();">
												<option value="">자원 카테고리 선택</option>
												<c:forEach items="${pc}" var="productCategory" varStatus="status" >
												<option value="${productCategory.codeId}">${productCategory.codeName}</option>
											</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>자원명</strong></th>
									<td class="fontVdn">
										<input type="text"  id="productName" maxlength="40" style="width: 100%"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<!-- 가상서버 -->
				<div class="formType01 m-t-40" id="productList" style="display:none;">
					<h2 class="titleBuType01"><span class="bullet"></span> 가상서버 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="197px">
								 <col width="*">
							</colgroup>

							<!-- 이미지 목록 추가 시작 -->
								<tr>
								 <th  class="fontVdn"><strong>이미지 유형</strong></th>
									  <td><select class="form-control w50 pb6" id="imageType" name="imageType" onchange="calcProdCateVmAmount();">
									           	<option value="">이미지 유형</option>
											<c:forEach items="${cmmCode}" var="cmmCode" varStatus="status" >
												<c:if test="${cmmCode.parentCodeId eq 'ITEMCATE_VMIMAGE'}">
												<option value="${cmmCode.codeId}">${cmmCode.codeName}</option>
												</c:if>
											</c:forEach>
										</select>
									   </td>
								</tr>
								<!-- 이미지 목록 추가  끝-->

							<!-- 디스크 유형 목록 시작 -->
								<tr>
								 <th class="fontVdn"><strong>디스크 유형</strong></th>
								  <td><select class="form-control w50 pb6" id="vmDiskType" name="vmDiskType" onchange="calcProdCateVmAmount();">
								        <option value="">디스크 유형</option>
										<c:forEach items="${cmmCode}" var="cmmCode" varStatus="status" >
													<c:if test="${cmmCode.parentCodeId eq 'ITEMCATE_DISK'}">
													<option value="${cmmCode.codeId}" code="${cmmCode.codeValue}">${cmmCode.codeName}</option>
													</c:if>
										</c:forEach>
									</select>
								   </td>
								</tr>
								<!-- 디스크 유형 목록 끝 -->

								<tr>
									<th scope="row" class="fontVdn">
										<strong>DISK</strong><span class="unit f16">(GB)</span>
									</th>
									<td class="fontVdn">
										<input type="text"  id="diskGb" maxlength="5" style="width: 100%" onkeypress="number_only(this);" onkeyup="calcProdCateVmAmount();"/>
									</td>
								</tr>
								<tr>
									<th scope="row" class="fontVdn">
										<strong>vCPU</strong><span class="unit f16">(Core)</span>
									</th>
									<td class="fontVdn">
										<input type="text"  id="vcpus" maxlength="3" style="width: 100%" onkeypress="number_only(this);" onkeyup="calcProdCateVmAmount();"/>
									</td>
								</tr>
								<tr>
									<th scope="row" class="fontVdn">
										<strong>MEMORY</strong><span class="unit f16">(GB)</span>
									</th>
									<td class="fontVdn">
										<input type="text"  id="memGb" maxlength="4" style="width: 100%" onkeypress="number_only(this);" onkeyup="calcProdCateVmAmount();"/>
									</td>
								</tr>

							</tbody>
						</table>
					</div>
				</div>

				<!-- 운영체제 -->
				<div class="formType01 m-t-40"  id="osList" style="display:none;">
					<h2 class="titleBuType01"><span class="bullet"></span> 운영체제 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="190px">
								 <col width="*">
							</colgroup>
								<tr>
									<th scope="row"><strong>운영체제</strong></th>
									<td>
										<input type="text" style="width:635px;" maxlength="40" id="itemName" onchange="calcProdCmount();">
										<a type="button" class="bton-s bton_blue"  id="billItemList" name="billItemList" onclick="openBillItemModal();"><span class="txt"><i class="fa fa-search"></i>검색</span></a>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>클라우드</strong></th>
									<td>

										<input type="text" style="width:635px;" maxlength="40" id="cloudName" readonly>
										<a type="button" class="bton-s bton_blue"  id="cloudList" name="cloudList" onclick="openCloudModal('os');"><span class="txt"><i class="fa fa-search"></i>검색</span></a>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>수량(단위)</strong></th>
									<td class="fontVdn">
										<span class="f16 fontB">
											<span id="quantity"></span>
											<span class="fc66 wd55 tar dpin fontN">EA</span>
										</span>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>이미지</strong></th>
									<td>
										<input type="hidden" id="appTemplateId" value="">
										<input type="hidden" id="appTemplateName" value="">
										<input type="hidden" id="appTemplateNameSpace" value="">
										<input type="hidden" id="appProvider" value="">

										<input type="hidden" id="vmImageId" value="">
										<input type="text" style="width:635px;" maxlength="40" id="vmImageName" disabled="" data-original-title="" title="">
										<a type="button" class="bton-s bton_blue"  id="billItemList" name="billItemList" onclick="openImageModal();"><span class="txt"><i class="fa fa-search"></i>검색</span></a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<!-- 어플리케이션 -->
				<div class="formType01 m-t-40"  id="appList" style="display:none;">
					<h2 class="titleBuType01"><span class="bullet"></span> 어플리케이션 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="190px">
								 <col width="*">
							</colgroup>
								<tr>
									<th scope="row"><strong>vCPU</strong></th>
									<td>
										<input type="text" style="width:635px;" maxlength="40" id="appCpu">
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>MEMORY</strong></th>
									<td>
										<input type="text" style="width:635px;" maxlength="40" id="appMemory">
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>POD수</strong></th>
									<td class="fontVdn">
										<input type="text" style="width:635px;" maxlength="40" id="appPod">
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>구분</strong></th>
									<td>
										<select class="form-control w50 pb6" id="appDivisionType" name="appDivisionType">
								        	<option value="">구분 유형</option>
											<c:forEach items="${cmmCode}" var="cmmCode" varStatus="status" >
												<c:if test="${cmmCode.parentCodeId eq 'ITEMCATE_APP_DIVISION'}">
												<option value="${cmmCode.codeId}" data-code="${cmmCode.codeValue}">${cmmCode.codeName}</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>클라우드</strong></th>
									<td>
										<iput type="hidden" id="cloudId2">
										<input type="text" style="width:635px;" maxlength="40" id="cloudName2" readonly>
										<a type="button" class="bton-s bton_blue"  id="cloudList2" name="cloudList2" onclick="openCloudModal('app');"><span class="txt"><i class="fa fa-search"></i>검색</span></a>
									</td>
								</tr>
<!-- 								<tr> -->
<!-- 									<th scope="row"><strong>템플릿</strong></th> -->
<!-- 									<td> -->
<!-- 										<input type="hidden" id="appTemplateId" value=""> -->
<!-- 										<input type="hidden" id="appTemplateName" value=""> -->
<!-- 										<input type="hidden" id="appTemplateNameSpace" value=""> -->
<!-- 										<input type="hidden" id="appProvider" value=""> -->
<!-- 										<input type="text" style="width:635px;" maxlength="40" id="appItemName" disabled="" data-original-title="" title=""> -->
<!-- 										<a type="button" class="bton-s bton_blue"  id="appTemplateList" name="appTemplateList" onclick="openTemplateModal();"><span class="txt"><i class="fa fa-search"></i>검색</span></a> -->
<!-- 									</td> -->
<!-- 								</tr> -->
							</tbody>
						</table>
					</div>
				</div>

				<!-- 블록디스크 -->
				<div class="formType01 m-t-40" id="diskList" style="display:none;">
					<h2 class="titleBuType01"><span class="bullet"></span> 블록디스크 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="197px">
								 <col width="*">
							</colgroup>

								<tr>
								 <th  class="fontVdn"><strong>디스크 유형</strong></th>
									  <td><select class="form-control w50 pb6" id="diskType" name="diskType" onchange="calcProdCateDiskAmount();">
									           	<option value="">디스크 유형</option>
											<c:forEach items="${cmmCode}" var="cmmCode" varStatus="status" >
												<c:if test="${cmmCode.parentCodeId eq 'ITEMCATE_DISK'}">
												<option value="${cmmCode.codeId}" code="${cmmCode.codeValue2}">${cmmCode.codeName}</option>
												</c:if>
											</c:forEach>
										</select>
									   </td>
								</tr>
								<tr>
									<th scope="row" class="fontVdn">
										<strong>DISK</strong><span class="unit f16">(GB)</span>
									</th>
									<td class="fontVdn">
										<input type="text"  id="diskDiskGb" maxlength="10" style="width: 100%"  onchange="number_only(this);" onkeyup="calcProdCateDiskAmount();" />
									</td>
								</tr>


							</tbody>
						</table>
					</div>
				</div>

				<!-- NAS -->
				<div class="formType01 m-t-40" id="nasList" style="display:none;">
					<h2 class="titleBuType01"><span class="bullet"></span> NAS 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="197px">
								 <col width="*">
							</colgroup>
								<tr>
									<th scope="row" class="fontVdn">
										<strong>DISK</strong><span class="unit f16">(GB)</span>
									</th>
									<td class="fontVdn">
										<input type="text"  id="nasGb" maxlength="5" style="width: 100%"  onkeyup="number_only(this);" onkeypress="calcProdCateNasAmount(this, 'nasGb');"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<!-- 서비스 로드분산 -->
				<div class="formType01 m-t-40" id="lbList" style="display:none;">
					<h2 class="titleBuType01"><span class="bullet"></span> 서비스 로드분산 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="197px">
								 <col width="*">
							</colgroup>
								<tr>
									<th scope="row">
										<strong>수량</strong><span class="unit f16 fontVdn">(EA)</span>
									</th>
									<td class="fontVdn">
										<input type="text"  id="loadbalancerEa" maxlength="5" style="width: 100%" onkeyup="number_only(this);" onkeypress="calcProdCateLbAmount(this, 'loadbalancerEa');"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<!-- 공인IP -->
				<div class="formType01 m-t-40" id="ipList" style="display:none;">
					<h2 class="titleBuType01"><span class="bullet"></span> 공인IP 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="197px">
								 <col width="*">
							</colgroup>
								<tr>
									<th scope="row">
										<strong>수량</strong><span class="unit f16 fontVdn">(EA)</span>
									</th>
									<td class="fontVdn">
										<input type="text"  id="publicipEa" maxlength="5" style="width: 100%" onkeyup="number_only(this);" onkeypress="calcProdCateIpAmount(this, 'publicipEa');"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<!-- 형상관리 서비스 -->
<!-- 				<div class="formType01 m-t-40" id="scmList" style="display:none;"> -->
<!-- 					<h2 class="titleBuType01 m-b-20">형상관리 서비스 정보</h2> -->
<!-- 					<div class="tblWrap clearfix"> -->
<!-- 						<table> -->
<%-- 							<colgroup> --%>
<%-- 								 <col width="197px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 							</colgroup> --%>
<!-- 								<tr> -->
<!-- 									<th scope="row"> -->
<!-- 										<strong>수량</strong><span class="unit f16">(식)</span> -->
<!-- 									</th> -->
<!-- 									<td class="fontVdn"> -->
<!-- 										<input type="text"  id="scmEa" maxlength="5" style="width: 100%" onkeyup="number_only(this);" onkeypress="calcProdCateScmAmount(this, 'scmEa');"/> -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</div> -->
<!-- 				</div> -->

				<!-- 백업 서비스 -->
<!-- 				<div class="formType01 m-t-40" id="bkList" style="display:none;"> -->
<!-- 					<h2 class="titleBuType01 m-b-20">백업 서비스 정보</h2> -->
<!-- 					<div class="tblWrap clearfix"> -->
<!-- 						<table> -->
<%-- 							<colgroup> --%>
<%-- 								 <col width="197px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 							</colgroup> --%>
<!-- 								<tr> -->
<!-- 									<th scope="row"> -->
<!-- 										<strong>용량</strong><span class="unit f16 fontVdn">(GB)</span> -->
<!-- 									</th> -->
<!-- 									<td class="fontVdn"> -->
<!-- 										<input type="text"  id="backupGb" maxlength="5" style="width: 100%" onkeyup="number_only(this);" onkeypress="calcProdCateBackAmount(this, 'backupGb');"/> -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</div> -->
<!-- 				</div> -->



				<!-- 서비스자원 -->
				<div class="formType01 m-t-40" id="serviceList" style="display:none;">
					<h2 class="titleBuType01"><span class="bullet"></span> 서비스 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="197px">
								 <col width="*">
							</colgroup>

								<tr>
								 <th  class="fontVdn"><strong>서비스유형</strong></th>
									  <td><select class="form-control w50 pb6" id="serviceType" name="serviceType" onchange="calcProdCateServiceTypeChange();">
									           	<option value="">서비스유형</option>
											<c:forEach items="${cmmCode}" var="cmmCode" varStatus="status" >
												<c:if test="${cmmCode.parentCodeId eq 'SERVICE_TYPE'}">
												<option value="${cmmCode.codeValue}">${cmmCode.codeName}</option>
												</c:if>
											</c:forEach>
										</select>
									   </td>
								</tr>

								<tr>
									<th scope="row">
										<strong>수량</strong><span class="unit f16 fontVdn">(EA)</span>
									</th>
									<td class="fontVdn">
										<input type="text"  id="serviceEa" maxlength="5" style="width: 100%" onkeypress="number_only(this);" onkeyup="calcProdCateServiceAmount(this, 'serviceEa');"/>
									</td>
								</tr>

							</tbody>
						</table>
					</div>
				</div>


				<!-- 대외계 서비스 -->
<!-- 				<div class="formType01 m-t-40" id="mcaList" style="display:none;"> -->
<!-- 					<h2 class="titleBuType01 m-b-20">대외계 서비스 정보</h2> -->
<!-- 					<div class="tblWrap clearfix"> -->
<!-- 						<table> -->
<%-- 							<colgroup> --%>
<%-- 								 <col width="197px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 							</colgroup> --%>
<!-- 								<tr> -->
<!-- 									<th scope="row"> -->
<!-- 										<strong>수량</strong><span class="unit f16">(식)</span> -->
<!-- 									</th> -->
<!-- 									<td class="fontVdn"> -->
<!-- 										<input type="text"  id="mcaEa" maxlength="5" style="width: 100%" onkeyup="number_only(this);" onkeypress="calcProdCateMcaAmount(this, 'mcaEa');"/> -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</div> -->
<!-- 				</div> -->

				<!-- 보안관제 서비스 -->
<!-- 				<div class="formType01 m-t-40" id="serList" style="display:none;"> -->
<!-- 					<h2 class="titleBuType01 m-b-20">보안관제 서비스 정보</h2> -->
<!-- 					<div class="tblWrap clearfix"> -->
<!-- 						<table> -->
<%-- 							<colgroup> --%>
<%-- 								 <col width="197px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 							</colgroup> --%>
<!-- 								<tr> -->
<!-- 									<th scope="row"> -->
<!-- 										<strong>수량</strong><span class="unit f16">(식)</span> -->
<!-- 									</th> -->
<!-- 									<td class="fontVdn"> -->
<!-- 										<input type="text"  id="securityEa" maxlength="5" style="width: 100%" onkeyup="number_only(this);" onkeypress="calcProdCateSecAmount(this, 'securityEa');"/> -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</div> -->
<!-- 				</div> -->

				<!-- 가격정보 -->
                <div class="formType01 mt40">
					<h2 class="titleBuType01"><span class="bullet"></span> 가격정보 자원 가격</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="190px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>월 금액</strong></th>
									<td>
										<span class="flr f16 fontB">
											<span class="fontVdn" id="totalMonthlyPrice">0</span>
											<span class="fc66  wd55 tar dpin fontN">원</span>
										</span>
									</td>
								</tr>
								<!-- 시간금액 주석처리 -->
								<!-- <tr>
									<th scope="row"><strong>시간 금액</strong></th>
									<td>
										<span class="flr f16 fontB">
											<span class="fontVdn" id="totalHourlyPrice">0</span>
											<span class="fc66  wd55 tar dpin fontN">원</span>
										</span>
									</td>
								    </tr> -->
							</tbody>
						</table>
					</div>
				</div>
     					<!-- 시간금액 주석처리 hidden 변경 -->
						<input type="hidden" id="totalHourlyPrice">

				<div class="row tac m-t-60">
		 			<a type="button" class="rbton bton_blue" onclick="setProductInsert()"> <i class="fa fa-upload"></i> 등록</a>
		 			<a type="button" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-close"></i> 취소</a>
                </div>
			</div>
            <!-- #modal-dialog -->
			<div class="modal fade" id="modal-dialog-os">
				<div class="modal-dialog">
                   <div class="modal-content width-570">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
                           <h4 class="modal-title">운영체제 선택</h4>
                       </div>
                       <div class="modal-body">
							<div class="listArea" id="osPopListDiv">

                      		</div>
                      		<div class="totalcnt">총 <span id="totalCnt">0</span> 건</div>
	                   	</div>
	                   	<div class="modal-footer tac">
                       		<a type="button" class="whiteline" data-dismiss="modal" >닫기</a>
                       	</div>
	               	</div>
				</div>
            </div>

            <!-- #modal-dialog -->
			<div class="modal fade" id="modal-dialog-template">
				<div class="modal-dialog">
                   <div class="modal-content width-570">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
                           <h4 class="modal-title">Template 선택</h4>
                       </div>
                       <div class="modal-body">
							<div class="listArea" id="appTemplatePopListDiv">

                      		</div>
                      		<div class="totalcnt">총 <span id="totalTemplateCnt">0</span> 건</div>
	                   	</div>
	                   	<div class="modal-footer tac">
                       		<a type="button" class="whiteline" data-dismiss="modal" >닫기</a>
                       	</div>
	               	</div>
				</div>
            </div>

            <div class="modal fade" id="modal-dialog-image">
				<div class="modal-dialog">
                   <div class="modal-content width-570">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
                           <h4 class="modal-title">이미지 선택</h4>
                       </div>
                       <div class="modal-body">
							<div class="listArea" id="imagePopListDiv">
                      		</div>
                      		<div class="totalcnt">총 <span id="imageTotalCnt">0</span> 건</div>
	                   	</div>
	                   	<div class="modal-footer tac">
                       		<a type="button" class="whiteline" data-dismiss="modal" >닫기</a>
                       	</div>
	               	</div>
				</div>
            </div>

             <div class="modal fade" id="modal-dialog-cloud">
				<div class="modal-dialog">
                   <div class="modal-content width-570">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
                           <h4 class="modal-title">클라우드 선택</h4>
                       </div>
                       <div class="modal-body">
							<div class="listArea" id="cloudPopListDiv">
                      		</div>
                      		<div class="totalcnt">총 <span id="cloudTotalCnt">0</span> 건</div>
	                   	</div>
	                   	<div class="modal-footer tac">
                       		<a type="button" class="whiteline" data-dismiss="modal" >닫기</a>
                       	</div>
	               	</div>
				</div>
            </div>
			<!-- #modal-dialog -->
			<!-- #modal-dialog -->
			<!------여기까지 사용------>
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
	var cloudSelectType;
	//osModal BillItemModal팝업 open
	function openImageModal(){
		if($("#cloudId").val()==""){
			alertBox3("클라우드를 선택하세요.");
			$("#cloudId").focus();
			return false;
		}
		$("#modal-dialog-image").modal();
		imagePopList();
	}

	function openCloudModal(type){
		cloudSelectType = type;
		$("#modal-dialog-cloud").modal();
		cloudPopList();
	}
	function cloudPopList(){
		$("#cloudPopListDiv").empty();
		$("#imagePopListDiv").empty();
		$("#vmImageId").val("");
		$("#vmImageName").val("");
		$("#cloudTotalCnt").text(0);
		$.ajax({
			url : "${contextPath}/mng/bss/product/cloudPopList",
			dataType : "JSON",
	//			type : "POST",
			success : function(data) {
				var cloudPopList = data.cloudPopList;


				if(cloudPopList!=""){
					var listTot = 0;
					var Html="";
					$.each(cloudPopList,function(key,val){

						Html += "<div class='listBg'>";
						Html += "	<span class='name3'>"+val["cloudName"]+"</span>";
						Html += "	<a class='applybtn' data-dismiss='modal' onclick='updateCloud(\""+val["cloudName"]+"\", \""+val["cloudId"]+"\", \""+val["cloudType"]+"\")'>적용</a>";
						Html += "</div>";
						listTot++;
					});
					$("#cloudPopListDiv").append(Html);
					$("#cloudTotalCnt").text(listTot);
				}else{
					$("#cloudPopListDiv").empty();

					var Html="";

					Html = "<div class='listBg'>";
					Html += "	검색된 목록이 없습니다.";
					Html += "</div>";

					$("#cloudPopListDiv").append(Html);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	// image 팝업리스트
	function imagePopList(){
		var cloudId = $("#cloudId").val();
		var keyword = "";
		$("#imageTotalCnt").text(0);
		$.ajax({
			url : "${contextPath}/mng/bss/product/imagePopList",
			dataType : "JSON",
	//			type : "POST",
			data : {
				"searchValue" : keyword,
				"cloudId" : cloudId

			},
			success : function(data) {

				var imagePopList = data.imagePopList;

				if(imagePopList!="" && data.osCloudType != "openshift"){
					var listTot = 0;
					var Html="";
					$("#imagePopListDiv").empty();
					$.each(imagePopList,function(key,val){
						Html += "<div class='listBg'>";
						Html += "	<span class='name3'>"+val["name"]+"</span>";
						Html += "	<a class='applybtn' data-dismiss='modal' onclick='updateImage(\""+val["name"]+"\", \""+val["id"]+"\")'>적용</a>";
						Html += "</div>";
						listTot++;
					});
					$("#imagePopListDiv").append(Html);
					$("#imageTotalCnt").text(listTot);

				}else if(imagePopList!="" && data.osCloudType === "openshift"){

					var listTot = 0;
					var Html="";
					$("#imagePopListDiv").empty();
					$.each(imagePopList.items,function(key,val){
						var provider = "";
						if(val["metadata"]["annotations"]["openshift.io/provider-display-name"]){
							provider=val["metadata"]["annotations"]["openshift.io/provider-display-name"];
						}

						Html += "<div class='listBg'>";
						Html += "	<span>"+val["metadata"]["name"]+"</span>";
// 						Html += "	<a class='applybtn' data-dismiss='modal' onclick='updateImage(\""+val["name"]+"\", \""+val["id"]+"\")'>적용</a>";
						Html += "	<a class='applybtn' data-dismiss='modal' onclick='updateApp(\""+val["metadata"]["name"]+"\", \""+val["metadata"]["uid"]+"\", \""+val["metadata"]["namespace"]+"\",\""+provider+"\",\""+"os"+"\")'>적용</a>";
						Html += "</div>";
						listTot++;
					});
					$("#imagePopListDiv").append(Html);
					$("#imageTotalCnt").text(listTot);
				}else{
					$("#imagePopListDiv").empty();

					var Html="";

					Html = "<div class='listBg'>";
					Html += "	검색된 목록이 없습니다.";
					Html += "</div>";

					$("#imagePopListDiv").append(Html);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}


		//osModal BillItemModal팝업 open
		function openBillItemModal(){
			$("#modal-dialog-os").modal();
			osPopList();
		}

		function openTemplateModal(){
			if($("#cloudId2").val()==""){
				alertBox3("클라우드를 선택하세요.");
				$("#cloudId2").focus();
				return false;
			}
			$("#modal-dialog-template").modal();
			appTemplateList();
		}

		function appTemplateList(){
			var cloudId = $("#cloudId2").val();
			var keyword = "";
			$("#imageTotalCnt").text(0);
			$.ajax({
				url : "${contextPath}/mng/bss/product/appTemplateList",
				dataType : "JSON",
				data : {
					"searchValue" : keyword,
					"cloudId" : cloudId

				},
				success : function(data) {
					var appTemplateList = data.appTemplateList;
					if(appTemplateList!=""){
						var listTot = 0;
						var Html="";
						$("#appTemplatePopListDiv").empty();
						$.each(appTemplateList.items,function(key,val){
							var provider = "";
							if(val["metadata"]["annotations"]["openshift.io/provider-display-name"]){
								provider=val["metadata"]["annotations"]["openshift.io/provider-display-name"];
							}
							Html += "<div class='listBg'>";
							Html += "	<span class='name2'>"+val["metadata"]["name"]+"</span>";
							Html += "	<a class='applybtn' data-dismiss='modal' onclick='updateApp(\""+val["metadata"]["name"]+"\", \""+val["metadata"]["uid"]+"\", \""+val["metadata"]["namespace"]+"\",\""+provider+"\",\""+"app"+"\" )'>적용</a>";
							Html += "</div>";
							listTot++;
						})
						$("#appTemplatePopListDiv").append(Html);
						$("#totalTemplateCnt").text(listTot);
					}else{
						$("#appTemplatePopListDiv").empty();

						var Html="";

						Html = "<div class='listBg'>";
						Html += "	검색된 목록이 없습니다.";
						Html += "</div>";

						$("#appTemplatePopListDiv").append(Html);
					}
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}

		// os 팝업리스트
		function osPopList(){

			var keyword = "";

			$.ajax({
				url : "${contextPath}/mng/bss/product/osPopList",
				dataType : "JSON",
//	 			type : "POST",
				data : {
					"searchValue" : keyword
				},
				success : function(data) {
					var osPopList = data.osPopList;

					if(osPopList!=""){
						var listTot = 0;
						var Html="";
						$("#osPopListDiv").empty();
						$.each(osPopList,function(key,val){
							Html += "<div class='listBg'>";
							Html += "	<span class='name2'>"+val["itemName"]+"</span>";
							Html += "	<a class='applybtn' data-dismiss='modal' onclick='updateOs(\""+val["itemName"]+"\", \""+val["quantity"]+"\", \""+val["unit"]+"\", \""+val["itemId"]+"\", \""+val["monthlyPrice"]+"\")'>적용</a>";
							Html += "</div>";
							listTot++;
						});
						$("#osPopListDiv").append(Html);
						$("#totalCnt").text(listTot);
					}else{
						$("#osPopListDiv").empty();

						var Html="";

						Html = "<div class='listBg'>";
						Html += "	검색된 목록이 없습니다.";
						Html += "</div>";

						$("#osPopListDiv").append(Html);
					}
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		function updateOs(itemName,quantity,unit,itemId,monthlyPrice){

			$("#totalMonthlyPrice").text(parseInt(monthlyPrice));
			$("#itemId").val(itemId);
			$("#itemName").val(itemName);
			$("#quantity").text(quantity);
			$("#unit").text(unit);
		}

		function updateApp(itemName,itemId,namespace,provider, type){
			if(type === "os"){
				$("#vmImageId").val(itemId);
				$("#vmImageName").val(itemName);

				$("#appTemplateId").val(itemId);
				$("#appTemplateName").val(itemName);
				$("#appItemName").val(itemName);
				$("#appTemplateNameSpace").val(namespace);
				$("#appProvider").val(provider);
			}
		}

		function updateImage(vmImageName,vmImageId){

			$("#vmImageId").val(vmImageId);
			$("#vmImageName").val(vmImageName);
		}

		function updateCloud(cloudName,cloudId, cloudType){

			if(cloudSelectType === "app"){
				$("#cloudId2").val(cloudId);
				$("#cloudName2").val(cloudName);
			}
			if(cloudSelectType === "os"){
				$("#cloudId").val(cloudId);
				$("#cloudName").val(cloudName);
				$("#cloudType").val(cloudType);
			}

		}

		//자원 update상세 불러오기
		function productUpdate(productSeq) {
			$.ajax({
				url : "${contextPath}/mng/bss/product/productView",
				dataType : "JSON",
	 			type : "POST",
				data : {
					"productSeq" : productSeq
				},
				success : function(data) {
					var result = data;
					productUpSetData(result);
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});

		}

		//가상서버 상세 수정
		function setProductInsert() {
			if($("#productName").val()==""){
				alertBox3("자원이름을 입력하세요");
				$("#productName").focus();
				return false;
			}
			if($("#productCategoryName").val()==""){
				alertBox3("자원카테고리를 선택하세요");
				$("#productCategoryName").focus();
				return false;
			}
		/* 	if($("#productCategoryName").val()=="PRODCATE_SERVICE"){
				alertBox3("서비스는 자원이 없습니다.");
				$("#productCategoryName").focus();
				return false;
			} */
			if($("#productCategoryName").val()=="PRODCATE_VM"){

				if($("#vcpus").val()==""){
					alertBox3("vCPU수를 입력하세요");
					$("#vcpus").focus();
					return false;
				}
				if($("#memGb").val()==""){
					alertBox3("MEM를 입력하세요");
					$("#memGb").focus();
					return false;
				}
				if($("#diskGb").val()==""){
					alertBox3("DISK를 입력하세요");
					$("#diskGb").focus();
					return false;
				}
			}
			if($("#productCategoryName").val()=="PRODCATE_OS"){
				if($("#itemName").val()==""){
					alertBox3("아이템 명을 입력하세요");
					$("#itemName").focus();
					return false;
				}

				if($("#vmImageName").val()==""){
					alertBox3("이미지를 검색하세요");
					$("#vmImageName").focus();
					return false;
				}
			}
			if($("#productCategoryName").val()=="PRODCATE_DISK"){
				if($("#diskDiskGb").val()==""){
					alertBox3("disk용량을 입력하세요");
					$("#diskDiskGb").focus();
					return false;
				}
			}
			if($("#productCategoryName").val()=="PRODCATE_NAS"){
				if($("#nasGb").val()==""){
					alertBox3("NAS용량을 입력하세요");
					$("#nasGb").focus();
					return false;
				}
			}
			if($("#productCategoryName").val()=="PRODCATE_PUBLICIP"){
				if($("#publicipEa").val()==""){
					alertBox3("IP 개수를 입력하세요");
					$("#publicipEa").focus();
					return false;
				}
			}
			if($("#productCategoryName").val()=="PRODCATE_LOADBALANCER"){
				if($("#loadbalancerEa").val()==""){
					alertBox3("로드밸런서 개수를 입력하세요");
					$("#loadbalancerEa").focus();
					return false;
				}
			}
			if($("#productCategoryName").val()=="PRODCATE_APP"){
				if($("#appCpu").val()==""){
					alertBox3("cpu개수를 입력하세요");
					$("#appCpu").focus();
					return false;
				}
				if($("#appMemory").val()==""){
					alertBox3("Memory개수를 입력하세요");
					$("#appMemory").focus();
					return false;
				}
				if($("#appPod").val()==""){
					alertBox3("Pod수를 입력하세요");
					$("#appPod").focus();
					return false;
				}
				if($("#appDivisionType").val()==""){
					alertBox3("구븐을 선택하세요");
					$("#appDivisionType").focus();
					return false;
				}
// 				if($("#appTemplateId").val()==""){
// 					alertBox3("Template을 선택하세요");
// 					$("#appTemplateId").focus();
// 					return false;
// 				}
				if($("#productCategoryName").val()=="PRODCATE_SERVICE"){

					if($("#serviceType").val()==""){
						alertBox3("서비스 유형을 선택하세요.");
						$("#serviceType").focus();
						return false;
					}

					if($("#serviceGroupType").val()==""){
						alertBox3("서비스그룹 유형을 선택하세요.");
						$("#serviceGroupType").focus();
						return false;
					}

				}

			}
// 			if($("#productCategoryName").val()=="PRODCATE_SCM"){
// 				if($("#scmEa").val()==""){
// 					alertBox3("형상관리 개수를 입력하세요");
// 					$("#scmEa").focus();
// 					return false;
// 				}
// 			}
// 			if($("#productCategoryName").val()=="PRODCATE_BACKUP"){
// 				if($("#backupGb").val()==""){
// 					alertBox3("백업 용량 입력하세요");
// 					$("#backupGb").focus();
// 					return false;
// 				}
// 			}
// 			if($("#productCategoryName").val()=="PRODCATE_SECURITY"){
// 				if($("#securityEa").val()==""){
// 					alertBox3("보안관제 개수를 입력하세요");
// 					$("#securityEa").focus();
// 					return false;
// 				}
// 			}
// 			if($("#productCategoryName").val()=="PRODCATE_MCA"){
// 				if($("#mcaEa").val()==""){
// 					alertBox3("대외계 개수를 입력하세요");
// 					$("#mcaEa").focus();
// 					return false;
// 				}
// 			}

			confirmBox("등록 하시겠습니까?",setInsert)
		}

		function setInsert(){
			var productCategoryName = $("#productCategoryName").val();
			var jsonData = "";

			switch(productCategoryName){
			case "PRODCATE_VM":
				jsonData = setJsonVmData();
				break;
			case "PRODCATE_OS":
				jsonData = setJsonOsData();
				break;
			case "PRODCATE_DISK":
				jsonData = setJsonDiskData();
				break;
			case "PRODCATE_NAS":
				jsonData = setJsonNasData();
				break;
			case "PRODCATE_PUBLICIP":
				jsonData = setJsonIpData();
				break;
			case "PRODCATE_LOADBALANCER":
				jsonData = setJsonLbData();
				break;
			case "PRODCATE_SERVICE":
				jsonData = setJsonServiceData();
				break;
			case "PRODCATE_APP":
				jsonData = setJsonContainerData();
				break;
			case "PRODCATE_ENV":
				jsonData = setJsonEnvData();
				break;
			default :
				break;
			}
// 			if($("#productCategoryName").val()=="PRODCATE_SCM"){
// 				var jsonData = setJsonScmData();
// 			}
// 			if($("#productCategoryName").val()=="PRODCATE_BACKUP"){
// 				var jsonData = setJsonBkData();
// 			}
// 			if($("#productCategoryName").val()=="PRODCATE_SECURITY"){
// 				var jsonData = setJsonSerData();
// 			}
// 			if($("#productCategoryName").val()=="PRODCATE_MCA"){
// 				var jsonData = setJsonMcaData();
// 			}

			$.ajax({
				url : "${contextPath}/mng/bss/product/insert",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					var result = data;
					if(result==1){
						alertBox("등록 되었습니다.",moveListPage);
					}else{
						alertBox("fail!!",moveListPage);
					}
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		function setJsonVmData(){
			var jsonData = {
					 "productName": $("#productName").val()
					, "productCategory": $("#productCategoryName").val()
					, "vcpus": $("#vcpus").val()
					, "memGb": $("#memGb").val()
					, "diskGb": $("#diskGb").val().replace(/,/gi,'')
					, "imageType": $("#imageType option:selected").val()
					, "diskType": $("#vmDiskType option:selected").val()
					};
			return jsonData;
		}

		function setJsonOsData(){

			var jsonData = "";

			if($("#cloudType").val() === "openshift"){
				jsonData = {
						"productName": $("#productName").val()
						, "productCategory": $("#productCategoryName").val()
						, "cloudId" : $("#cloudId").val()
						, "cloudType" : $("#cloudType").val()
						, "itemId": $("#itemId").val()
						, "itemName": $("#itemName").val()
						, "quantity": $("#quantity").val()
						, "unit": $("#unit").val()
						, "vmImageId": $("#vmImageName").val()			  // bss_product_os > Template Name
						, "vmImageName": $("#appTemplateNameSpace").val() // bss_product_os > Template NameSpace
						, "templateId" : $("#vmImageId").val()
						, "templateName" : $("#vmImageName").val()
						, "templateNameSpace" : $("#appTemplateNameSpace").val()
						, "templateProvider" : $("#appProvider").val()
				};
			}else {
				jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategoryName").val()
					, "cloudId" : $("#cloudId").val()
					, "cloudType" : $("#cloudType").val()
					, "itemId": $("#itemId").val()
					, "itemName": $("#itemName").val()
					, "quantity": $("#quantity").val()
					, "unit": $("#unit").val()
					, "vmImageId": $("#vmImageId").val()
					, "vmImageName": $("#vmImageName").val()
				};
			}
			return jsonData;
		}

		function setJsonDiskData(){
			var jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategoryName").val()
					, "diskDiskGb": $("#diskDiskGb").val().replace(/,/gi,'')
					, "diskType": $("#diskType option:selected").val()
					, "vmdkFile": $("#diskVmdk option:selected").val()
					};
			return jsonData;
		}
		function setJsonNasData(){
			var jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategoryName").val()
					, "cloudId" : $("#cloudId option:selected").val()
					, "nasGb": $("#nasGb").val().replace(/,/gi,'')
					};
			return jsonData;
		}
		function setJsonIpData(){
			var jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategoryName").val()
					, "cloudId" : $("#cloudId option:selected").val()
					, "publicipEa": $("#publicipEa").val()
					};
			return jsonData;
		}


		function setJsonLbData(){
			var jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategoryName").val()
					, "cloudId" : $("#cloudId option:selected").val()
					, "loadbalancerEa": $("#loadbalancerEa").val()
					};
			return jsonData;
		}

		function setJsonEnvData(){

			var jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategoryName").val()
					, "cloudId" : $("#cloudId option:selected").val()
					, "envEa": $("#envEa").val()
					};
			return jsonData;
		}
// 		function setJsonScmData(){
// 			var jsonData = {
// 					"productName": $("#productName").val()
// 					, "productCategory": $("#productCategoryName").val()
// 					, "cloudId" : $("#cloudId option:selected").val()
// 					, "scmEa": $("#scmEa").val()
// 					};
// 			return jsonData;
// 		}
// 		function setJsonBkData(){
// 			var jsonData = {
// 					"productName": $("#productName").val()
// 					, "productCategory": $("#productCategoryName").val()
// 					, "cloudId" : $("#cloudId option:selected").val()
// 					, "backupGb": $("#backupGb").val()
// 					};
// 			return jsonData;
// 		}
		function setJsonServiceData(){
			var jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategoryName").val()
					, "cloudId" : $("#cloudId option:selected").val()
					, "serviceEa": $("#serviceEa").val()
					, "serviceType": $("#serviceType option:selected").val()
					};
			//alert($("#serviceType").val());
			return jsonData;
		}

		function setJsonContainerData(){
			var itemId = $("#appDivisionType option:selected").val();
			var imageType = $("#appDivisionType option:selected").data("code");

			var jsonData = {
					  "productName": $("#productName").val()
					, "productCategory": $("#productCategoryName").val()
					, "cloudId" : $("#cloudId2").val()
					, "podCpu" : $("#appCpu").val()
					, "podMem" : $("#appMemory").val()
					, "podCnt" : $("#appPod").val()
					, "imageType" : imageType
					, "itemId" : itemId
					};

			return jsonData;
		}

// 		function setJsonSerData(){
// 			var jsonData = {
// 					"productName": $("#productName").val()
// 					, "productCategory": $("#productCategoryName").val()
// 					, "cloudId" : $("#cloudId option:selected").val()
// 					, "securityEa": $("#securityEa").val()
// 					};
// 			return jsonData;
// 		}
// 		function setJsonMcaData(){
// 			var jsonData = {
// 					"productName": $("#productName").val()
// 					, "productCategory": $("#productCategoryName").val()
// 					, "cloudId" : $("#cloudId option:selected").val()
// 					, "mcaEa": $("#mcaEa").val()
// 					};
// 			return jsonData;
// 		}

		function productCategoryselect(){

			$("#totalMonthlyPrice").text(0);
			$("#totalHourlyPrice").text(0);
			if($("#productCategoryName").val()=="PRODCATE_VM"){
				showProductView();

			}else if($("#productCategoryName").val()=="PRODCATE_OS"){
				showOsView();

			}else if($("#productCategoryName").val()=="PRODCATE_DISK"){
				showDiskView();
			}
			else if($("#productCategoryName").val()=="PRODCATE_NAS"){
				showNasView();
			}
			else if($("#productCategoryName").val()=="PRODCATE_PUBLICIP"){
				showIpView();
			}
			else if($("#productCategoryName").val()=="PRODCATE_LOADBALANCER"){
				showLbView();
			}
			else if($("#productCategoryName").val()=="PRODCATE_SERVICE"){
				showServiceView();
			}
			else if($("#productCategoryName").val()=="PRODCATE_APP"){
				showAppView();
			}
// 			else if($("#productCategoryName").val()=="PRODCATE_SCM"){
// 				showScmView();
// 			}
// 			else if($("#productCategoryName").val()=="PRODCATE_BACKUP"){
// 				showBkView();
// 			}
// 			else if($("#productCategoryName").val()=="PRODCATE_SECURITY"){
// 				showSerView();
// 			}
// 			else if($("#productCategoryName").val()=="PRODCATE_MCA"){
// 				showMcaView();
// 			}

			else if($("#productCategoryName").val()==""){
				showServiceView();
			}
		}
		function initPageSet(){

			$("#productList").hide();
			$("#osList").hide();
			$("#diskList").hide();
			$("#nasList").hide();
			$("#ipList").hide();
			$("#lbList").hide();
// 			$("#scmList").hide();
// 			$("#bkList").hide();
// 			$("#serList").hide();
// 			$("#mcaList").hide();
			$("#serviceList").hide();
			$("#appList").hide();

		}

		function showProductView(){

			$("#productList").show();
			$("#osList").hide();
			$("#diskList").hide();
			$("#nasList").hide();
			$("#ipList").hide();
			$("#lbList").hide();
// 			$("#scmList").hide();
// 			$("#bkList").hide();
// 			$("#serList").hide();
// 			$("#mcaList").hide();
			$("#serviceList").hide();
			$("#appList").hide();
		}
		function showOsView(){

			$("#productList").hide();
			$("#osList").show();
			$("#diskList").hide();
			$("#nasList").hide();
			$("#ipList").hide();
			$("#lbList").hide();
// 			$("#scmList").hide();
// 			$("#bkList").hide();
// 			$("#serList").hide();
// 			$("#mcaList").hide();
			$("#serviceList").hide();
			$("#appList").hide();
		}
		function showAppView(){
			$("#productList").hide();
			$("#osList").hide();
			$("#diskList").hide();
			$("#nasList").hide();
			$("#ipList").hide();
			$("#lbList").hide();
// 			$("#scmList").hide();
// 			$("#bkList").hide();
// 			$("#serList").hide();
// 			$("#mcaList").hide();
			$("#serviceList").hide();
			$("#appList").show();
		}
		function showDiskView(){

			$("#productList").hide();
			$("#osList").hide();
			$("#diskList").show();
			$("#nasList").hide();
			$("#ipList").hide();
			$("#lbList").hide();
// 			$("#scmList").hide();
// 			$("#bkList").hide();
// 			$("#serList").hide();
// 			$("#mcaList").hide();
			$("#serviceList").hide();
			$("#appList").hide();
		}
		function showNasView(){

			$("#productList").hide();
			$("#osList").hide();
			$("#diskList").hide();
			$("#nasList").show();
			$("#ipList").hide();
			$("#lbList").hide();
// 			$("#scmList").hide();
// 			$("#bkList").hide();
// 			$("#serList").hide();
// 			$("#mcaList").hide();
			$("#serviceList").hide();
			$("#appList").hide();
		}
		function showIpView(){

			$("#productList").hide();
			$("#osList").hide();
			$("#diskList").hide();
			$("#nasList").hide();
			$("#ipList").show();
			$("#lbList").hide();
// 			$("#scmList").hide();
// 			$("#bkList").hide();
// 			$("#serList").hide();
// 			$("#mcaList").hide();
			$("#serviceList").hide();
			$("#appList").hide();
		}
		function showLbView(){

			$("#productList").hide();
			$("#osList").hide();
			$("#diskList").hide();
			$("#nasList").hide();
			$("#ipList").hide();
			$("#lbList").show();
// 			$("#scmList").hide();
// 			$("#bkList").hide();
// 			$("#serList").hide();
// 			$("#mcaList").hide();
			$("#serviceList").hide();
			$("#appList").hide();
		}
// 		function showScmView(){
// 			$("#productList").hide();
// 			$("#osList").hide();
// 			$("#diskList").hide();
// 			$("#nasList").hide();
// 			$("#ipList").hide();
// 			$("#lbList").hide();
// // 			$("#scmList").show();
// // 			$("#bkList").hide();
// // 			$("#serList").hide();
// // 			$("#mcaList").hide();
// 			$("#serviceList").hide();
// 		}
// 		function showBkView(){
// 			$("#productList").hide();
// 			$("#osList").hide();
// 			$("#diskList").hide();
// 			$("#nasList").hide();
// 			$("#ipList").hide();
// 			$("#lbList").hide();
// // 			$("#scmList").hide();
// // 			$("#bkList").show();
// // 			$("#serList").hide();
// // 			$("#mcaList").hide();
// 			$("#serviceList").hide();
// 		}
// 		function showSerView(){
// 			$("#productList").hide();
// 			$("#osList").hide();
// 			$("#diskList").hide();
// 			$("#nasList").hide();
// 			$("#ipList").hide();
// 			$("#lbList").hide();
// // 			$("#scmList").hide();
// // 			$("#bkList").hide();
// // 			$("#serList").show();
// // 			$("#mcaList").hide();
// 			$("#serviceList").hide();
// 		}
// 		function showMcaView(){

// 			$("#productList").hide();
// 			$("#osList").hide();
// 			$("#diskList").hide();
// 			$("#nasList").hide();
// 			$("#ipList").hide();
// 			$("#lbList").hide();
// // 			$("#scmList").hide();
// // 			$("#bkList").hide();
// // 			$("#serList").hide();
// // 			$("#mcaList").show();
// 			$("#serviceList").hide();
// 		}
		function showServiceView(){

			$("#productList").hide();
			$("#osList").hide();
			$("#diskList").hide();
			$("#nasList").hide();
			$("#ipList").hide();
			$("#lbList").hide();
// 			$("#scmList").hide();
// 			$("#bkList").hide();
// 			$("#serList").hide();
// 			$("#mcaList").hide();
			$("#serviceList").show();
			$("#appList").hide();
		}
		// 목록 페이지이동
		function moveListPage(){
			location.href = "${contextPath}/mng/bss/product/";
		}

		function diskchange(id){
			var diskval = $(id).val();
			//alertBox3(diskval.length);
// 			if(diskval.length>3){
// 				diskcnt = Number(rtnnumber(diskval));
// 				$(id).val(addcomma(diskcnt))
// 			}else{
// 				diskcnt = Number(rtnnumber(diskval));
// 				$(id).val(addcomma(diskcnt))
// 			}
			diskcnt = Number(rtnnumber(diskval));
			$(id).val(addcomma(diskcnt))

// 			calcProdCateDiskAmount(id.id);
		}

		function calcProdCmount(){
			   alertBox3("이미지 유형을 선택하세요.");
		}

		function calcProdCateVmAmount(){
			var imageType = $("#imageType option:selected").val();
			if(imageType==""){
			   alertBox3("이미지 유형을 선택하세요.");
			return false;
			}


			var vmDiskType = $("#vmDiskType option:selected").val();
			if(vmDiskType=="" && imageType==""){
			   alertBox3("디스크 유형을 선택하세요.");
			return false;
			}

			if($("#productCategoryName").val()=="PRODCATE_VM"){

				var vcpus = $("#vcpus").val();
				var memGb = $("#memGb").val();
				var diskGb = $("#diskGb").val();

				if(vmDiskType=="" && diskGb != ""){
					   alertBox3("디스크 유형을 선택하세요.");
					return false;
				}

				vcpus = Number(rtnnumber(vcpus));
				memGb = Number(rtnnumber(memGb));
				diskGb = Number(rtnnumber(diskGb));

				var cpuHourlyPrice = $("#CPU010Hourly").val();
				var cpuMonthlyPrice = $("#CPU010Monthly").val();
				var memHourlyPrice = $("#MEM010Hourly").val();
				var memMonthlyPrice = $("#MEM010Monthly").val();


                if($("#vmDiskType").val() == $("#"+vmDiskType+"").val()){
                	var diskHourlyPrice = $("#"+vmDiskType+"Hourly").val();
                	var diskMonthlyPrice = $("#"+vmDiskType+"Monthly").val();
                }

	            var imageType = $("#imageType").val();
		            if($("#imageType").val() ==$("#"+imageType+"").val()){
						var imageHourlyPrice = $("#"+imageType+"Hourly").val();
						var imageMonthlyPrice = $("#"+imageType+"Monthly").val();
		        }

				var hp1 = vcpus*cpuHourlyPrice;
				var mp1 = vcpus*cpuMonthlyPrice;

				var hp2 = memGb*memHourlyPrice;
				var mp2 = memGb*memMonthlyPrice;

				var hp3 = diskGb*diskHourlyPrice;
				var mp3 = diskGb*diskMonthlyPrice;
				var hp4 = parseInt(imageHourlyPrice);
				var mp4 = parseInt(imageMonthlyPrice);

				$("#totalMonthlyPrice").text(addcomma(mp1+mp2+mp3+mp4));
				$("#totalHourlyPrice").text(addcomma(hp1+hp2+hp3+hp4));
			}
		}

		function calcProdCateDiskAmount(){

			var diskType = $("#diskType option:selected").val();
			if(diskType==""){
			   alertBox3("디스크 유형을 선택하세요.");
			return false;
			}

			if($("#productCategoryName").val()=="PRODCATE_DISK"){

			      if($("#diskType").val() == $("#"+diskType+"").val()){

			  		var diskDiskGb = $("#diskDiskGb").val();
	                	var diskHourlyPrice = $("#"+diskType+"Hourly").val();
	                	var diskMonthlyPrice = $("#"+diskType+"Monthly").val();

	            		var mp1 = diskMonthlyPrice*diskDiskGb;
						var hp1 = diskHourlyPrice*diskDiskGb;

						$("#totalMonthlyPrice").text(addcomma(mp1));
						$("#totalHourlyPrice").text(addcomma(hp1));

	                }

			}
		}

		function calcProdCateNasAmount(e, nasGb){
			number_only(e);
			if($("#productCategoryName").val()=="PRODCATE_NAS"){
				var nasGb = $("#"+nasGb).val();
				nasGb = Number(rtnnumber(nasGb));

				var nasHourlyPrice = $("#h_price_nas_hourly").val();
				var nasMonthlyPrice = $("#h_price_nas_monthly_price").val();

				var mp1 = nasGb*nasMonthlyPrice;
				var hp1 = nasGb*nasHourlyPrice;

				$("#totalMonthlyPrice").text(addcomma(mp1));
				$("#totalHourlyPrice").text(addcomma(hp1));
			}
		}

		function calcProdCateLbAmount(e, loadbalancerEa){
			number_only(e);
			if($("#productCategoryName").val()=="PRODCATE_LOADBALANCER"){
				var loadbalancerEa = $("#"+loadbalancerEa).val();
				loadbalancerEa = Number(rtnnumber(loadbalancerEa));

				var lbHourlyPrice = $("#h_price_lb_hourly").val();
				var lbMonthlyPrice = $("#h_price_lb_monthly_price").val();

				var mp1 = loadbalancerEa*lbMonthlyPrice;
				var hp1 = loadbalancerEa*lbHourlyPrice;

				$("#totalMonthlyPrice").text(addcomma(mp1));
				$("#totalHourlyPrice").text(addcomma(hp1));
			}
		}

		function calcProdCateIpAmount(e, publicipEa){
			number_only(e);
			if($("#productCategoryName").val()=="PRODCATE_PUBLICIP"){
				var publicipEa = $("#"+publicipEa).val();
				publicipEa = Number(rtnnumber(publicipEa));

				var ipHourlyPrice = $("#h_price_ip_hourly").val();
				var ipMonthlyPrice = $("#h_price_ip_monthly_price").val();

				var mp1 = publicipEa*ipMonthlyPrice;
				var hp1 = publicipEa*ipHourlyPrice;

				$("#totalMonthlyPrice").text(addcomma(mp1));
				$("#totalHourlyPrice").text(addcomma(hp1));
			}
		}

// 		function calcProdCateScmAmount(e, scmEa){
// 			number_only(e);
// 			if($("#productCategoryName").val()=="PRODCATE_SCM"){
// 				var scmEa = $("#"+scmEa).val();
// 				scmEa = Number(rtnnumber(scmEa));

// 				var scmHourlyPrice = $("#h_price_scm_hourly").val();
// 				var scmMonthlyPrice = $("#h_price_scm_monthly_price").val();

// 				var mp1 = scmEa*scmMonthlyPrice;
// 				var hp1 = scmEa*scmHourlyPrice;

// 				$("#totalMonthlyPrice").text(addcomma(mp1));
// 				$("#totalHourlyPrice").text(addcomma(hp1));
// 			}
// 		}

// 		function calcProdCateBackAmount(e, backupGb){
// 			number_only(e);
// 			if($("#productCategoryName").val()=="PRODCATE_BACKUP"){
// 				var backupGb = $("#"+backupGb).val();
// 				backupGb = Number(rtnnumber(backupGb));

// 				var backupHourlyPrice = $("#h_price_backup_hourly").val();
// 				var backupMonthlyPrice = $("#h_price_backup_monthly_price").val();

// 				var mp1 = backupGb*backupMonthlyPrice;
// 				var hp1 = backupGb*backupHourlyPrice;

// 				$("#totalMonthlyPrice").text(addcomma(mp1));
// 				$("#totalHourlyPrice").text(addcomma(hp1));
// 			}
// 		}

		function calcProdCateServiceTypeChange(){
			$("#serviceEa").val("");
			$("#totalMonthlyPrice").text("0");
		}

		function calcProdCateServiceAmount(e, serviceEa){

			  number_only(e);
				if($("#productCategoryName").val()=="PRODCATE_SERVICE"){

				var serviceType = $("#serviceType option:selected").val();

					var serviceEa = $("#"+serviceEa).val();
					serviceEa = Number(rtnnumber(serviceEa));

					 if(serviceType == $("#"+serviceType+"").val()){
		               	var serviceHourlyPrice = $("#"+serviceType+"Hourly").val();
		               	var serviceMonthlyPrice = $("#"+serviceType+"Monthly").val();
		            }

					var mp1 = serviceEa*serviceMonthlyPrice;
					var hp1 = serviceEa*serviceHourlyPrice;

					$("#totalMonthlyPrice").text(addcomma(mp1));
					$("#totalHourlyPrice").text(addcomma(hp1));
				}
			}

// 		function calcProdCateMcaAmount(e, mcaEa){
// 			number_only(e);
// 			if($("#productCategoryName").val()=="PRODCATE_MCA"){
// 				var mcaEa = $("#"+mcaEa).val();
// 				mcaEa = Number(rtnnumber(mcaEa));

// 				var mcaHourlyPrice = $("#h_price_mca_hourly").val();
// 				var mcaMonthlyPrice = $("#h_price_mca_monthly_price").val();

// 				var mp1 = mcaEa*mcaMonthlyPrice;
// 				var hp1 = mcaEa*mcaHourlyPrice;

// 				$("#totalMonthlyPrice").text(addcomma(mp1));
// 				$("#totalHourlyPrice").text(addcomma(hp1));
// 			}
// 		}

// 		function calcProdCateSecAmount(e, securityEa){
// 			number_only(e);
// 			if($("#productCategoryName").val()=="PRODCATE_SECURITY"){
// 				var securityEa = $("#"+securityEa).val();
// 				securityEa = Number(rtnnumber(securityEa));

// 				var securityHourlyPrice = $("#h_price_security_hourly").val();
// 				var securityMonthlyPrice = $("#h_price_security_monthly_price").val();

// 				var mp1 = securityEa*securityMonthlyPrice;
// 				var hp1 = securityEa*securityHourlyPrice;

// 				$("#totalMonthlyPrice").text(addcomma(mp1));
// 				$("#totalHourlyPrice").text(addcomma(hp1));
// 			}
// 		}

		$(document).ready(function() {
			App.init();

			// 화면 기초 데이터 Bind하는 Funcion
			initPageSet();

		    $("#cloudId").val($("#hidden_cloudId").val()).attr("selected","selected");

			//메뉴활성화
			$("#productAservice").addClass("active");
			$("#product").addClass("active");
		});
	</script>

</body>
</html>