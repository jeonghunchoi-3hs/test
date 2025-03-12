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

				<p class="page_title" id="pageTitle">기본자원 신청
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> <b>기본자원 신청 </b>
			    </span>
		    	</p>

				<!-- begin page-body -->
				<div class="row p20 bgwh br10">

					<!----첫번째 자원내용 ------->
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
							<c:set var="diskPrice" value="${getCatalogueSelectView.vmDiskHourlyPrice * 10}" />
							<c:set var="diskPrice1" value="${getCatalogueSelectView.vmDiskHourlyPrice * getCatalogueSelectView.vmDiskGb / 10}" />
							<c:set var="totalPrice" value="${getCatalogueSelectView.vcpus * cpuPrice + memPrice + diskPrice1}" />

						</c:when>
						<c:otherwise>
							<c:set var="cpuPrice" value="${getCatalogueSelectView.cpuMonthlyPrice}" />
							<c:set var="memPrice" value="${getCatalogueSelectView.memGb * getCatalogueSelectView.memMonthlyPrice}" />
							<c:set var="memPrice1" value="${getCatalogueSelectView.memMonthlyPrice}" />
							<c:set var="diskPrice" value="${getCatalogueSelectView.vmDiskMonthlyPrice * 10}" />
							<c:set var="diskPrice1" value="${getCatalogueSelectView.vmDiskMonthlyPrice * getCatalogueSelectView.vmDiskGb / 10}" />
							<c:set var="totalPrice" value="${getCatalogueSelectView.vcpus * cpuPrice +  memPrice + diskPrice1}" />
						</c:otherwise>
					</c:choose>
					<!----첫번째 자원내용 끝
					<div class="col-md-12">
						<div class="col-md-12 bgf2 b1s">
							<div class="col-md-3 br5 bgwh tac mt10 mb10 vm p35"><img src="${wasPath}/mbr/cmm/file/download/${getCatalogueSelectView.imageName}" class="w100">

							</div>
							<div class="col-md-9 pr0">
								<h5 class="bgdb p10 fcdb f16">${getCatalogueSelectView.displayName} </h5>
								<li class="fcdb f14 pl20">CPU : ${getCatalogueSelectView.vcpus} Core</li>
								<li class="fcdb f14 pl20"> MEM : ${getCatalogueSelectView.memGb} GB</li>
								<li class="fcdb f14 pl20"> DISK : ${getCatalogueSelectView.vmDiskGb} GB</li>
								<li class="fc66 p20"> ${getCatalogueSelectView.description} </li>
							</div>
					  	</div>
					</div>
					<!----첫번째 자원내용 끝------->


					<div class="product_box">
					  <li class="img"><img src="${getCatalogueSelectView.imageName}" class="width-80 pt10"/></li>
					  <li class="description">
					      <span class="productTitle">${getCatalogueSelectView.displayName}</span>
					       <p class="productsubTitle"> ${getCatalogueSelectView.descriptionTop} </p>
					  </li>
					  <ul class="product_sub">
					   <li class="disk"><img src="/resources/assets/img/icon_disk.png"/> DISK  <span>${getCatalogueSelectView.vmDiskGb}GB</span></li>
					   <li class="memory"><img src="/resources/assets/img/icon_mem.png"/> MEMORY <span> ${getCatalogueSelectView.memGb}GB</span></li>
					   <li class="cpu"><img src="/resources/assets/img/icon_cpu.png"/> vCPU  <span>${getCatalogueSelectView.vcpus}Core</span></li>
					  </ul>
					</div>




					<!----첫번째 자원내용 끝------->
<%--  					<div class="productTotalArea">
						<div class="productTitleArea">
							<img src="${getCatalogueSelectView.imageName}" class="width-80 pt10"/>


							<p class="productsubTitle"> ${getCatalogueSelectView.descriptionTop} </p>
						</div>

						<div id="flag" class="mt10 ml160"> Standard</div>
						<div class="productInfoArea ppxy" >
							<div class="productAreaLine">
								<img src="/resources/assets/img/icon_cpu.png"/>
								<span class="productInfo">${getCatalogueSelectView.vcpus} Core</span>
							</div>
							<div class="productAreaLine">
								<img src="/resources/assets/img/icon_mem.png"/>
								<span class="productInfo"> ${getCatalogueSelectView.memGb} GB </span>
							</div>
							<div class="productAreaNoLine">
								<img src="/resources/assets/img/icon_disk.png"/>
								<span class="productInfo"> ${getCatalogueSelectView.vmDiskGb} GB</span>
							</div>

							<div class="productSubInfo"> ${getCatalogueSelectView.description}</div>
							<div class="productSubInfo dpno">

								<c:if test="${getCatalogueSelectView.description eq null or getCatalogueSelectView.description eq ''}">
								ㆍ운영체제 설치를 위한 기본 디스크가 제공되며, 추가 디스크를 직업 생성 할 수 있습니다.<br/>
								ㆍ월 또는 시간 단위로 서버를 사용 할 수 있습니다.<br/>
								ㆍ월단위 요금으로 서버를 1개월 미만으로 사용하면 이용요금은 일할로 계산되어 청구됩니다.
								</c:if>
								<c:if test="${getCatalogueSelectView.description ne null or getCatalogueSelectView.description ne ''}">
								${getCatalogueSelectView.description}
								</c:if>

							</div>
						</div>
					</div> --%>
					<!----첫번째 자원내용 끝------->



					<div class="clear"></div>

					<div class="orderArea">
						<div class="tableF">
							<form name="catalogueform"  id="catalogueform" action="catalogueOrderNow" method="post" >
								<input type="hidden" name="imagePath" id="imagePath" value="${getCatalogueSelectView.imagePath}" />
								<input type="hidden" name="imageName" id="imageName" value="${getCatalogueSelectView.imageName}" />
								<input type="hidden" name="vmImageType" id="vmImageType" value="${getCatalogueSelectView.vmImageType}" />
								<input type="hidden" name="type" id="type" value="noworderinsert" />
								<input type="hidden" name="productSeq" id="productSeq" value="${getCatalogueSelectView.productSeq}" />
								<input type="hidden" name="instanceType" id="instanceType" value="${instanceType}" />
								<input type="hidden" name="totalPrice" id="totalPrice" value="${totalPrice}" />
								<input type="hidden" name="productCategory" id="productCategory" value="${getCatalogueSelectView.productCategory}" />
								<input type="hidden" name="networkChk" id="networkChk" value="" />
								<input type="hidden" name="catalogSeq" id="catalogSeq" value="${getCatalogueSelectView.catalogSeq}" />
								<input type="hidden" name="networkAlias" id="networkAlias" value="" />
								<input type="hidden" name="hiddenUserIdReview" id="hiddenUserIdReview" value="" />
								<input type="hidden" name="hiddenUserNameReview" id="hiddenUserNameReview" value="" />
								<input type="hidden" name="hiddenUserIdApprove" id="hiddenUserIdApprove" value="" />
								<input type="hidden" name="hiddenUserNameApprove" id="hiddenUserNameApprove" value="" />
								<input type="hidden" name="volumeType" id="volumeType" />
								<input type="hidden" name="hidden_login_user_id" id="hidden_login_user_id" value="${userId}" />
								<input type="hidden" name="applyDatetime" id="applyDatetime" value="" />
								<input type="hidden" name="approvalStepListString" id="approvalStepListString" />
								<input type="hidden" id="cloudType" />
								<input type="hidden" name="cloudId" id="cloudId" />
								<input type="hidden" name="apprvPass" id="apprvPass"				value="${apprvPass}" />
								<input type="hidden" name="selectApprv" id="selectApprv"			value="" />
                                <input type="hidden" name="blueprintUuid" id="blueprintUuid" />
                                <input type="hidden" name="osProductName" id="osProductName" />


								<table>
									<colgroup>
										<col width="140px">
										<col width="*">
										<col width="140px">
										<col width="*">
									</colgroup>

									<tbody>
										<tr class="dpno">
											<td class="left" scope="row">이용요금</td>
											<td colspan="3">
												<label><input type="radio" id="hourlyFlag1" name="hourlyFlag" value="N" checked class="va-tb"/> <span class="mr50">월 </span></label> <label><input type="radio" id="hourlyFlag2" name="hourlyFlag" value="Y" class="va-tb"/> 시간 </span></label>
											</td>
										</tr>
										<c:if test="${instanceType eq 'INSTANCE_CTNTRMNL'}">
											<tr style="display:none">
												<td class="left-t">서비스희망일시</td>
												<td colspan="3">
													<div class="radio-select-group">
														<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성</label> &nbsp; &nbsp;
														<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> 희망일시 생성</label> <br/>
													</div>
													<div class="fc-dblue2 f14 pt10" id="selectTEXT" ><i class='fa fa-exclamation-circle f16 fc-dblue2'></i><span class="fb"> 관리자의 최종승인 후 가상머신이 생성 됩니다. </span></div>
												</td>
											</tr>
										</c:if>
										<c:if test="${instanceType ne 'INSTANCE_CTNTRMNL'}">
											<tr>
												<td class="left-t">서비스희망일시</td>
												<td colspan="3">
													<div class="radio-select-group">
														<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성</label> &nbsp; &nbsp;
														<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> 희망일시 생성</label> <br/>
													</div>
													<div class="fc-dblue2 f14 pt10" id="selectTEXT" ><i class='fa fa-exclamation-circle f16 fc-dblue2'></i><span class="fb"> 관리자의 최종승인 후 가상머신이 생성 됩니다. </span></div>
												</td>
											</tr>
										</c:if>
										<tr id="sdate" name="sdate" style="display:none">
											<td class="left"></td>
											<td colspan="3">
												<input type="text" class="form-control dpin width-150" id="applyDate" name="applyDate" />
												<div class="searchBoxArea width-80 dpin">
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
											<td class="left" scope="row">프로젝트명</td>
											<td>
												<div class="search-box">
													<input class="form-control" type="text" name="projectAlias" id="projectAlias" readonly="readonly"/>
													<input class="form-control" type="hidden" name="projectName" id="projectName" />
													<input type="hidden" name="projectBoxId" id="projectBoxId" value="" />
													<input type="hidden" name="projectId" id="projectId" value="" />
													<!-- <img src="/resources/assets/img/icon_search.png" onclick="openModal();" class="input_search t6 r35"/> -->
													<img src="${apachePath}/resources/assets/img/btn_search2.png" onclick="openModal();" class="kepco-ser-icon"/>
												</div>
											</td>
											<td class="left" scope="row">서버대역</td>
											<td>
												<div class="searchBoxArea">

														<label class="selectBoxDrop" for=azName>대역선택</label>
														<select class="search-sel" name="azName" id="azName" onChange="selectAz();">
														</select>

												</div>
											</td>
										</tr>
										<tr>
											<td class="left" scope="row">운영체제</td>
											<td>
												<div class="searchBoxArea">
													<label class="selectBoxDrop" for="osProductSeq">OS 선택</label>
													<select class="search-sel" name="osProductSeq" id="osProductSeq" onchange="osSenter();">
													</select>
													<input type="hidden" name="imosprice" id="imosprice" value="0"/>
													<input type="hidden" name="himosprice" id="himosprice" value="0"/>
													<input type="hidden" name="mimosprice" id="mimosprice" value="0"/>
												</div>
											</td>
											<td class="left" scope="row">서버명</td>
											<td>
												<input maxlength="30" class="form-control" type="text" name="hostnameAlias" id="hostnameAlias" />
											</td>
										</tr>

										<tr>
											<td class="left" scope="row" id="DisplaydiskTitle">OS DISK</td>
											<td id="DisplaydiskCnt">
												<div class="flex align-center">
													<input class="form-control w138" type="text"  placeholder="1" value="50" maxlength="5" name="diskcnt" id="diskcnt" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"  onfocusout="diskfocusout(this);" onkeyup="diskchange(this);" /> <p class="inputUnit"> GB </p>
													<input type="hidden" name="diskprice" id="diskprice" value='<fmt:formatNumber value="${diskPrice}" pattern="####"/>'>
													<input type="hidden" name="diskprice1" id="diskprice1" value='<fmt:formatNumber value="${diskPrice1}" pattern="####"/>'>
													<img src="/resources/assets/img/icon_minus.png"  onclick="diskminus();" class="minus"/><span class="snemo">10</span> <img src="/resources/assets/img/icon_plus.png" onclick="diskplus();" class="plus"/>
													 <p class="inputUnit"> GB </p>
													<!-- <span class="flr f18 fc66"><span id="diskpriceview" name="diskpriceview"  class="listwon nanumR"><fmt:formatNumber value="${diskPrice1}" pattern="#,###"/></span>&nbsp;원</span>
													<input type="hidden" name="imdiskprice" id="imdiskprice" value="<fmt:formatNumber value="${diskPrice}" pattern="####"/>" />
													<input type="hidden" name="imdiskcnt" id="imdiskcnt" value="<fmt:formatNumber value="${getCatalogueSelectView.vmDiskGb}" pattern="####"/>" />		 -->
												</div>
											</td>
											<td class="left" scope="row" id="osSvrSpecGroupDisplay">서버사양</td>
											<td>
												<div class="depth-dropdown-box">
													<div class="searchBoxArea dpin">
															<label class="selectBoxDrop" for="osSvrSpecGroup">서버분류</label>
															<select class="search-sel" name="osSvrSpecGroup" id="osSvrSpecGroup" >
															</select>
													</div>
													<div class="searchBoxArea  dpin">
															<label class="selectBoxDrop" for="flavorId"  id="flavorId2">서버사양 선택</label>
															<select class="search-sel" name="flavorId" id="flavorId" onchange="selectServerSpecGroup();">
															</select>
													</div>
												</div>
											</td>
										</tr>

										<tr >
											<td class="left" scope="row" style="display:none">CPU</td>
											<td style="display:none">
												<div class="">
													<input class="form-control w138" type="text"  placeholder="1" value="${getCatalogueSelectView.vcpus}" maxlength="2" name="cpucnt" id="cpucnt" onblur="setProductPrice();" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" /> <p class="inputUnit"> Core</p>
													<input type="hidden" name="cpuprice" id="cpuprice" value='<fmt:formatNumber value="${cpuPrice}" pattern="####"/>'>
													<img src="/resources/assets/img/icon_minus.png"  onclick="cpuminus();" class="minus"/><span class="snemo">1</span> <img src="/resources/assets/img/icon_plus.png" onclick="cpuplus();" class="plus"/>
												</div>
											</td>
										</tr>

										<tr>
											<c:if test="${instanceType eq 'INSTANCE_CTNTRMNL'}">
												<td id="tdAzNameTitle" class="left" scope="row" style="display:none">백업네트워크</td>
												<td id="tdAzName" style="display:none">
													<div class="radio-select-group">
														<label>
															<input type="radio" id="backupNetwork2" name="backupNetworkFlag" value="N" checked class="va-tb"/>
															<span class="ml4"> 백업 네트워크 미포함 </span>
														</label>

														<label>
															<input type="radio" id="backupNetwork1" name="backupNetworkFlag" value="Y"  class="va-tb"/>
															<span class="ml4"> 백업 네트워크 포함 </span>
														</label>
													</div>
												</td>
											</c:if>
											<c:if test="${instanceType ne 'INSTANCE_CTNTRMNL'}">
												<td id="tdAzNameTitle" class="left" scope="row">백업네트워크</td>
												<td id="tdAzName">
													<div class="radio-select-group">
														<label>
															<input type="radio" id="backupNetwork2" name="backupNetworkFlag" value="N" checked class="va-tb"/>
															<span class="ml4"> 백업 네트워크 미포함 </span>
														</label>

														<label>
															<input type="radio" id="backupNetwork1" name="backupNetworkFlag" value="Y"  class="va-tb"/>
															<span class="ml4"> 백업 네트워크 포함 </span>
														</label>
													</div>
												</td>
											</c:if>
<%--										<c:if test="${instanceType eq 'INSTANCE_CTNTRMNL'}">
											</c:if> --%>
											<td class="left" scope="row" style="display:none">Memory</td>
											<td colspan="3" style="display:none">
												<div class="">
													<input class="form-control w138" type="text"  placeholder="1" value="${getCatalogueSelectView.memGb}" maxlength="3" name="memcnt" id="memcnt" onblur="setProductPrice();" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" /> <p class="inputUnit"> GB </p>
													<input type="hidden" name="memprice" id="memprice" value='<fmt:formatNumber value="${memPrice}" pattern="####"/>'>
													<input type="hidden" name="memPrice1" id="memPrice1" value='<fmt:formatNumber value="${memPrice1}" pattern="####"/>'>
													<img src="/resources/assets/img/icon_minus.png"  onclick="memminus();" class="minus"/><span class="snemo">1</span> <img src="/resources/assets/img/icon_plus.png" onclick="memplus();" class="plus"/>
												</div>
											</td>
										</tr>

										<!--<c:if test="${cloudInfo.cloudType eq 'vmware'}">
										<tr>
											<td colspan="3" style="display:none">
												<div class="">
													<input type="radio" id="backupNetwork2" name="backupNetworkFlag" value="N" checked class="va-tb"/>
													<input class="form-control w138" type="text"  placeholder="1" value="${getCatalogueSelectView.memGb}" maxlength="3" name="memcnt" id="memcnt" onblur="setProductPrice();" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" /> <p class="inputUnit"> GB </p>
													<input type="hidden" name="memprice" id="memprice" value='<fmt:formatNumber value="${memPrice}" pattern="####"/>'>
													<input type="hidden" name="memPrice1" id="memPrice1" value='<fmt:formatNumber value="${memPrice1}" pattern="####"/>'>
													<img src="/resources/assets/img/icon_minus.png"  onclick="memminus();" class="minus"/><span class="snemo">1</span> <img src="/resources/assets/img/icon_plus.png" onclick="memplus();" class="plus"/>
												</div>
											</td>
										</tr>
										</c:if>-->
										<!--
										<tr style="display:none;">
											<td class="left" scope="row">DISK</td>
											<td colspan="3">
												<div class="">
													<input class="form-control w138" type="text"  placeholder="1" value="${getCatalogueSelectView.vmDiskGb}" maxlength="5" name="diskcnt" id="diskcnt" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"  onfocusout="diskfocusout(this);" onkeyup="diskchange(this);" /> <p class="inputUnit"> GB </p>
													<input type="hidden" name="diskprice" id="diskprice" value='<fmt:formatNumber value="${diskPrice}" pattern="####"/>'>
													<input type="hidden" name="diskprice1" id="diskprice1" value='<fmt:formatNumber value="${diskPrice1}" pattern="####"/>'>
													<img src="/resources/assets/img/icon_minus.png"  onclick="diskminus();" class="minus"/><span class="snemo">10</span> <img src="/resources/assets/img/icon_plus.png" onclick="diskplus();" class="plus"/>
													<span class="flr f18 fc66"><span id="diskpriceview" name="diskpriceview"  class="listwon nanumR"><fmt:formatNumber value="${diskPrice1}" pattern="#,###"/></span>&nbsp;원</span>
													<input type="hidden" name="imdiskprice" id="imdiskprice" value="<fmt:formatNumber value="${diskPrice}" pattern="####"/>" />
													<input type="hidden" name="imdiskcnt" id="imdiskcnt" value="<fmt:formatNumber value="${getCatalogueSelectView.vmDiskGb}" pattern="####"/>" />
												</div>
											</td>
										</tr>
									 	-->
										<!-- <tr>
											<td class="left" scope="row">서버사양</td>
											<td>
												<div class="searchBoxArea width-150 dpin">
														<label class="selectBoxDrop" for="osSvrSpecGroup">서버분류</label>
														<select class="search-sel" name="osSvrSpecGroup" id="osSvrSpecGroup" >
															<c:forEach items="${getFlavorTypeList}" var="getFlavorTypeList">
															<option value="${getFlavorTypeList.flavorType}">${getFlavorTypeList.flavorName}</option>
															</c:forEach>
														</select>
												</div>
												<div class="searchBoxArea  width-350 dpin">
														<label class="selectBoxDrop" for="flavorId"  id="flavorId2">서버사양 선택</label>
														<select class="search-sel" name="flavorId" id="flavorId" onchange="selectServerSpecGroup();">
															<c:forEach items="${getCatalogueFlavorList}" var="catalogueFlavorList">
																<fmt:parseNumber var="ramGb" integerOnly="true" value="${catalogueFlavorList.ramMb/1024 }" />
																<option group="${catalogueFlavorList.flavorType}" cpu="${catalogueFlavorList.vcpus}" mem="${ramGb}" disk="50" value="${catalogueFlavorList.flavorId}">CPU: ${catalogueFlavorList.vcpus}Core MEM: ${ramGb}GB</option>
															</c:forEach>
														</select>
													</div>
											</td>
											<td id="tdAzNameTitle" class="left" scope="row">백업네트워크</td>
											<td id="tdAzName">
												<label>
													<input type="radio" id="backupNetwork1" name="backupNetworkFlag" value="Y" checked class="va-tb"/>
													<span class="mr50"> 백업 네트워크 포함 </span>
												</label>
												<label>
													<input type="radio" id="backupNetwork2" name="backupNetworkFlag" value="N" class="va-tb"/>
													<span class="mr50"> 백업 네트워크 미포함 </span>
												</label>
											</td>
										</tr>-->
										<tr>
											 <td class="left" scope="row">기타사항</td>
											<td colspan="3">
												<textarea rows="2" cols="100%" id="reqMessage" name="reqMessage"></textarea>
											</td>
										</tr>

									</tbody>
								</table>
							</form>
						</div>


						<div class="btn_area mt-20">
							<a type="button" class="btn_navy"  onclick="openApproveReviewModal();">신청</a>
							<c:if test="${instanceType ne 'INSTANCE_CTNTRMNL'}">
								<a type="button" class="btn_dngrey ml10" onclick="basketorder();">일괄신청</a>
							</c:if>
							<a type="button" class="btn_white ml10" onclick="moveListPage();"> 취소</a>
				   		</div>


					</div>
				</div>
				<!---- end page body---->

				<!-- end page-body -->

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
											<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)projectPopList();">
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
				<!-- #modal-dialog -->


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
	               <div class="modal-dialog width-720">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">신청확인</h4>
                           </div>
                           <div class="modal-body">
								<!-- <div class="modalManagePop">
									<strong class="title" id="pop_projectAlias"></strong>
									<div class="detailBox">
										<div class="boxType01">
											<ul>
												<li><span class="title">서버명</span><span class="cnt nanumR" id="pop_hostnameAlias"></span></li>
											</ul>
										</div>
										<div class="boxType02">
											<ul>
												<li><span class="title">클라우드</span><span class="cnt" id="cloudPanel"></span></li>
												<li><span class="title">요청유형</span><span class="cnt">신규</span></li>
												<li><span class="title">네트워크</span><span class="cnt" id="pop_network"></span></li>
												<li><span class="title">희망일시</span><span class="cnt" id="pop_onDemandFlag"></span></li>
												<li><span class="title">백업NW포함여부</span><span class="cnt" id="pop_backupNWFlag"></span></li>
												<li><span class="title">CPU</span><span class="cnt" id="pop_cpucnt"></span></li>
												<li><span class="title">MEMORY</span><span class="cnt" id="pop_memcnt"></span></li>
												<li><span class="title">DISK</span><span class="cnt" id="pop_diskcnt"></span></li>
											</ul>
										</div>
										<dl class="boxType03 dpno">
											<dt>금액<span class="fc-red">(VAT 별도)</span></dt>
											<dd><strong id="pop_totalPrice"></strong><span>&nbsp;원</span></dd>
										</dl>
									</div>
									<p class="commnet fc-red">위 내용으로 신청 하시겠습니까?</p>
								</div> -->
								<div class="tableE">
									<table>
										<colgroup>
											<col width="140px" />
											<col width="*" />
											<col width="140px" />
											<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th class="tal">프로젝트명</th>
												<td colspan="3"><span id="pop_projectAlias"></span></td>
											</tr>
											<tr>
												<th class="tal">클라우드</th>
												<td><span class="cnt" id="cloudPanel"></span></td>
												<th class="tal">요청유형</th>
												<td><span class="cnt">신규</span></td>
											</tr>
											<tr>
												<c:if test="${instanceType ne 'INSTANCE_CTNTRMNL'}">
													<th class="tal">네트워크</th>
													<td><span class="cnt" id="pop_network"></span></td>
												</c:if>
												<th class="tal">희망일시</th>
												<td><span class="cnt" id="pop_onDemandFlag"></span></td>
											</tr>
											<tr>
												<th class="tal">백업NW포함여부</th>
												<td><span class="cnt" id="pop_backupNWFlag"></span></td>
												<th class="tal">CPU</th>
												<td><span class="cnt" id="pop_cpucnt"></span></td>
											</tr>
											<tr>
												<th class="tal">MEMORY</th>
												<td><span class="cnt" id="pop_memcnt"></span></td>
												<th class="tal">DISK</th>
												<td><span class="cnt" id="pop_diskcnt"></span></td>
											</tr>
										</tbody>
									</table>
									<p class="commnet fc-red">위 내용으로 신청 하시겠습니까?</p>
								</div>
                           </div>
                           <div class="modal-footer tac">
	                   			<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="request_noworder();">확인</a>
	                   			<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
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
						<a type="button" class="m_btn_navy" data-dismiss="modal">닫기</a>
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
							<a type="button" class="m_btn_navy" data-dismiss="modal">닫기</a>
						</div>
					</div>
				</div>
			</div>
			<!-- 결재자 지정 끝 -->
			<!-- #modal-dialog 모음 끝-->


			<div>
				<iframe id='iframeBasket' name='iframeBasket' style='display:none; border:0px;'></iframe>
			</div>
            <!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->


		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">
			// 결재라인 관련 변수
			var currentApprovalLine = "";
			var approvalList = [];

			// 결재자 지정 시작
		function openApproveReviewModal() {

			var checkVal = "";

			$("input:checkbox[name='network']").each(function(){
				if($(this).is(":checked")){
					checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "Y" + ",";
				}else{
					checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "N" +",";
				}
			});

			checkVal = checkVal.substring(0, checkVal.length-1);

			$("#networkChk").val(checkVal);
			//alertBox3($("#networkChk").val());

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
			if($("#networkId > option:selected").val()=="netId"){
				alertBox3("네트워크를 선택하세요");
				return false;
			}
			/*
			if($("#hostname").val()==""){
				alertBox3("호스트명을 입력하세요");
				return false;
			}
			if($("#confirmFlag").val()=="N"){
				alertBox3("호스트명 중복확인을 하세요");
				$("#hostname").focus();
				return false;
			}
			*/
			if($("#hostnameAlias").val()==""){
				alertBox3("서버명을 입력하세요");
				return false;
			}

			if($("#osProductSeq > option:selected").val()==""){
				alertBox3("OS를 선택하세요");
				return false;
			}

			if($("#azName > option:selected").val()==""){
				alertBox3("서버대역을 선택하세요");
				return false;
			}

			var cloudType = $("#azName > option:selected").data("type");

			if(cloudType != "nutanix"){
				if($("#flavorId > option:selected").val()==""){
					alertBox3("서버사양을 선택하세요");
					return false;
				}
			}

			$("#networkAlias").val($("#networkId > option:selected").text());
			$("#osProductName").val($("#osProductSeq > option:selected").data("name"));


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

		// 결재자 지정 끝
		function vmOrderView(){
			//alertBox3($("input[name='hourlyFlag']:checked").val());
			var productSeq = "${getCatalogueSelectView.productSeq}";
			var hourlyFlag = $("input[name='hourlyFlag']:checked").val();
			var diskcnt = $("#diskcnt").val();
			var cpucnt = $("#cpucnt").val();
			var memcnt = $("#memcnt").val();
			var mimosprice = $("#mimosprice").val();
			var himosprice = $("#himosprice").val();

			$.ajax({
				url : "${wasPath}/mbr/req/catalogue/getcatalogueDiskOrderView",
				dataType : "JSON",
				//type : "POST",
				data : {
					"productSeq" : productSeq
					,"hourlyFlag" : hourlyFlag
					,"diskcnt" : diskcnt
				},
				success : function(data) {
					//alertBox3(data.productSeq);
					//alertBox3(diskcnt);

					if(hourlyFlag=="N"){
						//월 금액
						//var totalPrice = data.diskMonthlyPrice * data.diskGb / 10;
						var cpuPrice = cpucnt * data.cpuMonthlyPrice;
						var cpuPrice1 = data.cpuMonthlyPrice;
						var memPrice = memcnt * data.memMonthlyPrice;
						var memPrice1 = data.memMonthlyPrice;


						var diskprice = data.vmDiskMonthlyPrice * 10;
						var diskprice1 = data.vmDiskMonthlyPrice * diskcnt / 10;

						var totalPrice = cpuPrice + memPrice + diskprice1 + Number(mimosprice);

						$("#cpucnt").val(cpucnt);
						$("#cpupriceview").empty();
						$("#cpupriceview").append(addcomma(cpuPrice));

						$("#memcnt").val(memcnt);
						$("#mempriceview").empty();
						$("#mempriceview").append(addcomma(memPrice));

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

						$("#imosprice").val(mimosprice);
						$("#himosprice").val(himosprice);
						$("#mimosprice").val(mimosprice);

						$("#memPrice1").val(memPrice1);
						$("#cpuprice").val(cpuPrice1);
						$("#osprice").empty();
						$("#osprice").append(addcomma(mimosprice));

					}else{
						//시간 금액
						var cpuPrice = cpucnt * data.cpuHourlyPrice;
						var cpuPrice1 = data.cpuHourlyPrice;
						var memPrice = memcnt * data.memHourlyPrice;
						var memPrice1 = data.memHourlyPrice;

						var diskprice = data.vmDiskHourlyPrice * 10;
						var diskprice1 = data.vmDiskHourlyPrice * diskcnt / 10;

						var totalPrice = cpuPrice + memPrice + diskprice1 + Number(himosprice);

						$("#cpucnt").val(cpucnt);
						$("#cpupriceview").empty();
						$("#cpupriceview").append(addcomma(cpuPrice));

						$("#memcnt").val(memcnt);
						$("#mempriceview").empty();
						$("#mempriceview").append(addcomma(memPrice));

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

						$("#imosprice").val(himosprice);
						$("#himosprice").val(himosprice);
						$("#mimosprice").val(mimosprice);

						$("#memPrice1").val(memPrice1);
						$("#cpuprice").val(cpuPrice1);
						$("#osprice").empty();
						$("#osprice").append(addcomma(himosprice));
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

		function winopen(){
			window.open('projectSearch.do','_blank','');
		}

		// 달력
		function calendar(){

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
		}

		function applyTimePlus(){
 			//alertBox3($("#applyTime").val());

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

		// #### 서버 사양 기능 관련 Fn Start ####
		function memplus(){
			//alertBox3($("#memcnt").val());
			if($("#memcnt").val()=="999"){
				alertBox3("메모리는 999개 이상 신청하실수 없습니다.");
			}else{
				var memcnt;
				var memprice;
				var imamount;
				//alertBox3($("#memPrice1").val());
				memcnt = Number(rtnnumber($("#memcnt").val())) + 1;
				memprice = Number(rtnnumber($("#memPrice1").val()))*Number(memcnt);
				imamount = Number(rtnnumber($("#imamount").val()))+Number(rtnnumber($("#memPrice1").val()));
				//alertBox3(memprice);
				$("#memcnt").val(memcnt);
				$("#mempriceview").empty();
				$("#mempriceview").append(addcomma(memprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}

		}

		function memminus(){
			//alertBox3($("#memcnt").val());
			if($("#memcnt").val()=="1"){
				alertBox3("메모리는 1개 이상이어야합니다.");
			}else{
				var memcnt;
				var memprice;
				var imamount;
				//alertBox3($("#memPrice1").val());
				memcnt = Number(rtnnumber($("#memcnt").val())) - 1;
				memprice = Number(rtnnumber($("#memPrice1").val()))*Number(memcnt);
				imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#memPrice1").val()));
				//alertBox3(memprice);
				$("#memcnt").val(memcnt);
				$("#mempriceview").empty();
				$("#mempriceview").append(addcomma(memprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}

		}

		function cpuplus(){

			//alertBox3($("#memcnt").val());
			if($("#cpucnt").val()=="99"){
				alertBox3("CPU는 99개 이상 신청하실수 없습니다.");
			}else{
				var cpucnt;
				var cpuprice;
				var imamount;
				//alertBox3($("#cpuprice").val());
				cpucnt = Number(rtnnumber($("#cpucnt").val())) + 1;
				cpuprice = Number(rtnnumber($("#cpuprice").val()))*Number(cpucnt);
				imamount = Number(rtnnumber($("#imamount").val()))+Number(rtnnumber($("#cpuprice").val()));
				//alertBox3(cpuprice);
				$("#cpucnt").val(cpucnt);
				$("#cpupriceview").empty();
				$("#cpupriceview").append(addcomma(cpuprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}

		}

		function cpuminus(){
			//alertBox3($("#memcnt").val());
			if($("#cpucnt").val()=="1"){
				alertBox3("CPU는 1개 이상이어야합니다.");
			}else{
				var cpucnt;
				var cpuprice;
				var imamount;
				//alertBox3($("#cpuprice").val());
				cpucnt = Number(rtnnumber($("#cpucnt").val())) - 1;
				cpuprice = Number(rtnnumber($("#cpuprice").val()))*Number(cpucnt);
				imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#cpuprice").val()));
				//alertBox3(cpuprice);
				$("#cpucnt").val(cpucnt);
				$("#cpupriceview").empty();
				$("#cpupriceview").append(addcomma(cpuprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
				//$("#cpuprice").val(cpuprice);
			}

		}

		function diskplus(){
			//alertBox3($("#diskcnt").val());
			if(Number($("#diskcnt").val())>=50){
				alertBox3("OS디스크는 50GB 이상<br/>신청하실수 없습니다.");
				//$("#diskcnt").val($("#imdiskcnt").val());
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").empty();
				$("#totalpriceview").append($("#totalPrice").val());
			}else{
				var diskcnt;
				var diskprice;
				var imamount;
				//alertBox3($("#diskprice").val());
				diskcnt = Number(rtnnumber($("#diskcnt").val())) + 10;
				$("#diskcnt").val(diskcnt);
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
				//alertBox3(Number(rtnnumber($("#diskprice").val()))/10);
				imamount = Number(rtnnumber($("#imamount").val()))+Number(rtnnumber($("#diskprice").val()))/10;
				//alertBox3(addcomma(diskprice));
				if(checkAvail()){
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
		}

		function diskminus(){
			//alertBox3($("#diskcnt").val());
			if(Number($("#diskcnt").val())<=30){
				alertBox3("OS디스크는 최소 30GB 이상<br/>신청하셔야 합니다.");
				//$("#diskcnt").val($("#imdiskcnt").val());
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").empty();
				$("#totalpriceview").append($("#totalPrice").val());
			}else{
				var diskcnt;
				var diskprice;
				var imamount;
				//alertBox3($("#diskprice").val());
				diskcnt = Number(rtnnumber($("#diskcnt").val())) - 10;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
				//alertBox3(Number(rtnnumber($("#diskprice").val()))/10);
				imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#diskprice").val()))/10;
				//alertBox3(addcomma(diskprice));
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

		function selectServerSpecGroup() {
			var selectCpuCnt = $("#flavorId option:selected").attr("cpu");
			var selectMemCnt = $("#flavorId option:selected").attr("mem");
			//var selectDiskCnt = $("#flavorId option:selected").attr("disk");

			$("#cpucnt").val(selectCpuCnt);
			$("#memcnt").val(selectMemCnt);
			//$("#diskcnt").val(selectDiskCnt);

			//CPU
			var cpucnt;
			var cpuprice;
			var imamount;
			cpucnt = Number(rtnnumber($("#cpucnt").val()));
			cpuprice = Number(rtnnumber($("#cpuprice").val()))*Number(cpucnt);
			cimamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#cpuprice").val()));
			var memcnt;
			var memprice;
			var imamount;
			memcnt = Number(rtnnumber($("#memcnt").val()));
			memprice = Number(rtnnumber($("#memPrice1").val()))*Number(memcnt);
			if(checkAvail()){
				$("#cpucnt").val(cpucnt);
				$("#cpupriceview").empty();
				$("#cpupriceview").append(addcomma(cpuprice));
				$("#imamount").val(addcomma(cimamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(cimamount));
				imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#memPrice1").val()));
				$("#memcnt").val(memcnt);
				$("#mempriceview").empty();
				$("#mempriceview").append(addcomma(memprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}
			//MEM

			// Disk
			/* 디스크 부분 용량 수정할 수 있게 기능 다시 변경해 달라고 요청함 (요청자 : 정희철, 2019.11.20 장중일)
			var diskcnt;
			var diskprice;
			var imamount;
			diskcnt = Number(rtnnumber($("#diskcnt").val()));
			diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
			imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#diskprice").val()))/10;

			$("#diskcnt").val(diskcnt);
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma(diskprice));
			$("#imamount").val(addcomma(imamount));
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(imamount));
			$("#totalPrice").val(addcomma(imamount));
			$("#imdiskprice").val(diskprice);
			$("#imdiskcnt").val($("#diskcnt").val());
			*/
		}
		// #### 서버 사양 기능 관련 Fn End ####

		// 팝업 초기화
		function initModal(){
			$("#_projectName").val("");
			$("#checkMsg").text("");
			$("#enableId").css("display", "none");
			$("#unableId").css("display", "block");
		}

		// 일괄신청
		function basketorder(){

			var checkVal = "";

			$("input:checkbox[name='network']").each(function(){
				if($(this).is(":checked")){
					checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "Y" + ",";
				}else{
					checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "N" +",";
				}
			});

			checkVal = checkVal.substring(0, checkVal.length-1);

			$("#networkChk").val(checkVal);

			//alertBox3($("#totalPrice").val());
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
			if($("#networkId > option:selected").val()=="netId"){
				alertBox3("네트워크를 선택하세요");
				return false;
			}
			/*
			if($("#hostname").val()==""){
				alertBox3("호스트명을 입력하세요");
				return false;
			}
			if($("#confirmFlag").val()=="N"){
				alertBox3("호스트명 중복확인을 하세요");
				$("#hostname").focus();
				return false;
			}
			*/
			if($("#hostnameAlias").val()==""){
				alertBox3("서버명을 입력하세요");
				return false;
			}
			if($("#osProductSeq > option:selected").val()==""){
				alertBox3("OS를 선택하세요");
				return false;
			}

			if($("#azName > option:selected").val()==""){
				alertBox3("서버대역을 선택하세요");
				return false;
			}

			if($("#flavorId > option:selected").val()==""){
				alertBox3("서버사양을 선택하세요");
				return false;
			}

			$("#totalPrice").val(rtnnumber($("#totalPrice").val()));
			//$("#catalogueform").attr('action','basketOrder.do');
			//$("#catalogueform").submit();
			$("#confirmFlag").val("N");
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
			//confirmBox2("일괄신청로 이동하시겠습니까?", actCatalogueformSubmit,cansel);
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

		function osSenter(){
				osselect();
		}

		function osselect(){

			//alertBox3($("#osProductSeq > option:selected").val());
			if($("#osProductSeq > option:selected").val()!=""){
				var osProductSeq = $("#osProductSeq > option:selected").val();
				var cloudId = $("#azName").children('option:selected').data("cloud");
				var amount;
				//var jsonData = setJsonData();
				//$("#customerId").empty();
				//$("#customerId").append("<option value='''>=== 회원사 선택 ===</option>");
				$.ajax({
					url : "${wasPath}/mbr/req/catalogue/osSelect",
					dataType : "JSON",
					type : "POST",
					data : {
						"osProductSeq" : osProductSeq
						,"cloudId": cloudId
					},
					success : function(data) {
							if($("input[name='hourlyFlag']:checked").val()=="N"){
								//alertBox3(data.monthlyPrice);
								$("#osprice").empty();
								$("#osprice").append(addcomma(data.monthlyPrice));
								amount = Number(rtnnumber($("#imamount").val())) + Number(data.monthlyPrice) - Number($("#imosprice").val());
								//alertBox3(amount);
								amount = addcomma(amount);
								//$("#amount").val(amount);
								$("#imamount").val(amount);
								$("#imosprice").val(data.monthlyPrice);
								$("#himosprice").val(data.hourlyPrice);
								$("#mimosprice").val(data.monthlyPrice);

								$("#totalpriceview").empty();
								$("#totalpriceview").append(amount);
								$("#totalPrice").val(amount);

							}else{
								//alertBox3(data.hourlyPrice);
								$("#osprice").empty();
								$("#osprice").append(addcomma(data.hourlyPrice));
								amount = Number(rtnnumber($("#imamount").val())) + Number(data.hourlyPrice) - Number($("#imosprice").val());
								amount = addcomma(amount);
								//alertBox3(amount);
								//$("#amount").val(amount);
								$("#imamount").val(amount);
								$("#imosprice").val(data.hourlyPrice);
								$("#himosprice").val(data.hourlyPrice);
								$("#mimosprice").val(data.monthlyPrice);

								$("#totalpriceview").empty();
								$("#totalpriceview").append(amount);
								$("#totalPrice").val(amount);
								//alertBox3(amount);
								//amount = rtnnumber(amount);
								//alertBox3(amount);
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

			} else {
				$("#osprice").empty();
				$("#osprice").append('0');
				var amount;
				amount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imosprice").val()));
				$("#imamount").val(addcomma(amount));
				$("#imosprice").val('0');
				$("#amount").val($("#imamount").val());
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(amount));
				$("#totalPrice").val(addcomma(amount));
			}
		}

		function selectAz() {


				$("#osSvrSpecGroupDisplay").show();
				$("#DisplaydiskTitle").show();
				$("#DisplaydiskCnt").show();

				getNetworkList();
				getOsList();
				getFlavorTypeList();

				$("#cloudName").val($("#azName > option:selected").data("name"));
				$("#cloudId").val($("#azName > option:selected").data("cloud"));
				$("#cloudPanel").val($("#azName > option:selected").data("name"));
				var selectedAz = $("#azName > option:selected").val();


				if(selectedAz == 'fa-zone' ||
				   selectedAz == 'EM-DMZ' ||
				   selectedAz == 'EM-Mobile' ||
				   selectedAz == 'PA-mobile' ||
				   selectedAz == 'PA-DMZ' ||
				   selectedAz == 'oa-hci-zone' ||
				   selectedAz == 'OA-VM-Cluster')
				{
					$("#tdAzNameTitle").addClass("dpno");
					$("#tdAzName").addClass("dpno");
					$("#backupNetwork1").prop('checked', false);
					$("#backupNetwork2").prop('checked', true);
				} else {
					$("#tdAzNameTitle").removeClass("dpno");
					$("#tdAzName").removeClass("dpno");
				}
		}


		function diskfocusout(id){
			//alertBox3(id);
			var diskcnt;
			diskcnt = Number($(id).val());
			//alertBox3(diskcnt);
			if(diskcnt < 30) {
				alertBox3("디스크는 최소 30GB 이상<br/>신청하셔야 합니다.");
				$(id).val($("#imdiskcnt").val());
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(rtnnumber($("#totalPrice").val())));
			} else if (diskcnt > 10000){
				alertBox3("디스크는 10,000GB 이상<br/>신청하실수 없습니다.");
				$(id).val($("#imdiskcnt").val());
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(rtnnumber($("#totalPrice").val())));
			} else {
				var imdiskcnt = diskcnt % 10;
				if(imdiskcnt == 0 ){
					var diskprice;
					var imamount;
					diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100;
					//alertBox3(diskprice);
					//alertBox3($("#imdiskprice").val());
					imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
					imamount =  imamount + diskprice ; //총가격에 디스크 가격 추가

					//alertBox3(imamount);

					$("#imdiskcnt").val($(id).val());
					$("#imdiskprice").val(diskprice);
					$("#diskpriceview").empty();
					$("#diskpriceview").append(addcomma(diskprice));
					$("#imamount").val(addcomma(imamount));
					$("#totalpriceview").empty();
					$("#totalpriceview").append(addcomma(imamount));
					$("#totalPrice").val(addcomma(imamount));
					checkAvail();
				} else {
					alertBox3("디스크는 10GB 단위로<br/>신청하실수 있습니다.");
					$(id).val($("#imdiskcnt").val());
					$("#diskpriceview").empty();
					$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
					$("#totalpriceview").empty();
					$("#totalpriceview").append(addcomma(rtnnumber($("#totalPrice").val())));
				}
			}
		}

		function diskchange(id) {
			//alertBox3($(id).val());
			var diskval = $(id).val();
			//alertBox3(diskval.length);
			if(diskval.length > 2){
				var diskprice;
				var imamount;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100;
				imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
				imamount =  imamount + diskprice ;
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
			} else {
				var imdiskcnt = Number(diskval) % 10;
				if(imdiskcnt == 0){
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

		function setProductPrice(){
			var cpucnt = Number(rtnnumber($("#cpucnt").val()));
			var cpuprice = Number(rtnnumber($("#cpuprice").val()))*Number(cpucnt);
			$("#cpucnt").val(cpucnt);
			$("#cpupriceview").html('<span class="listwon nanumR">'+addcomma(cpuprice)+'</span>');

			var memcnt = Number(rtnnumber($("#memcnt").val()));
			var memprice = Number(rtnnumber($("#memPrice1").val()))*Number(memcnt);
			$("#memcnt").val(memcnt);
			$("#mempriceview").html('<span class="listwon nanumR">'+addcomma(memprice)+'</span>');

			var diskcnt = Number(rtnnumber($("#diskcnt").val()));
			var diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
			$("#diskcnt").val(diskcnt);
			$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>');

			var imamount = cpuprice+memprice+diskprice;
			$("#imamount").val(addcomma(imamount));
			$("#totalpriceview").html(addcomma(imamount));
			$("#totalPrice").val(addcomma(imamount));
		}

		// ## Modal popup Fn start ##

		//modal팝업 open
		function openModal(){
			$("#modal-dialog").modal({backdrop:'static', keyboard:false});
			projectPopList();
		}

		// 팝업리스트
		function projectPopList(){
			var keyword = $("#searchKeyword").val();
			var searchKind = $("#searchKind option:selected").val();

			$.ajax({
				url : "${wasPath}/mbr/req/catalogue/projectPopList",
				dataType : "JSON",
	 			//type : "POST",
				data : {
					"searchValue" : keyword,
					"searchKey" : searchKind
				},
				success : function(data) {
					var projectList = data.getProjectList;

					if(projectList!=""){

						$("#popListTable > tr").remove();
						$.each(projectList,function(key,val){

							var Html="";

	// 						Html="<tr><td class='tac'>"+val["projectName"]+"</td>";
							Html="<tr>";
							Html = Html + "<td class='tac'>"+val["projectName"]+"</td>";
							Html = Html + "<td class='tac'>"+val["projectAlias"]+"</td>";
							Html = Html + "<td class='tac'><input type='button' class='popCheckbtn' value='&#xf00c' onclick='updateProject(this, \""+val["projectBoxId"]+"\", \""+val["projectName"]+"\", \""+val["projectAlias"]+"\")'></td>";
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

		var hprojectName,hprojectBoxId, hprojectId, hprojectAlias;

		function updateProject(e, projectId, projectName, projectAlias){
			$("#popListTable > tr").find("input").removeClass("active");
			$(e).toggleClass("active");
			hprojectName = projectName;
			hprojectBoxId = projectId;
			hprojectAlias = projectAlias;
		}

		var vmAvail,diskAvail, memAvail, vcpuAvail;

		function okProjectInsert(){
			$("#projectName").val(hprojectName);
			$("#projectBoxId").val(hprojectBoxId);
			$("#projectAlias").val(hprojectAlias);
			getProjectZoneList();

			/*$.ajax({
				url : "${wasPath}/mng/project/quota/getQuota",
				type:"GET",
				data:{projectId:hprojectId},
				success:function(data){
					vmAvail = data.vmAvail;
					diskAvail = data.diskAvail;
					memAvail = data.memAvail;
					vcpuAvail = data.vcpuAvail;
					checkAvail();
				}
			})*/
			//getNetworkList();
		}

		function checkAvail(){
			var diskcnt = Number(rtnnumber($("#diskcnt").val()));
			var memcnt = Number(rtnnumber($("#memcnt").val()));
			var cpucnt = Number(rtnnumber($("#cpucnt").val()));
			if(vmAvail == 0){
				alertBox3("가상서버 자원 쿼터를 초과하였습니다.");
				$("#projectName").val("");
				$("#projectId").val("");
				$("#projectAlias").val("");
				return false;
			}
			if(diskcnt > diskAvail && diskAvail != "undefined"){
				alertBox3("디스크 자원 쿼터를 초과하였습니다.");
				diskcnt = Number(rtnnumber(Number(diskAvail)));
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
			if(cpucnt > vcpuAvail && vcpuAvail != "undefined"){
				resetSelect();
				alertBox3("cpu 자원 쿼터를 초과하였습니다.");
				return false;
			}
			memcnt = memcnt * 1024;
			if(memcnt > memAvail && memAvail != "undefined"){
				resetSelect();
				alertBox3("메모리 자원 쿼터를 초과하였습니다.");
				return false;
			}
			return true;
		}
		function resetSelect(){
			$("#cpucnt").val("");
			$("#cpupriceview").empty();
			$("#imamount").val("");
			$("#totalpriceview").empty();
			$("#totalPrice").val("");
			$("#memcnt").val('');
			$("#mempriceview").empty();
			$("#imamount").val("");
			$("#totalpriceview").empty();
			$("#totalPrice").val("");
			$("#cpucnt").val("");
			$("#memcnt").val("");
			$("#flavorId").val("");
			$("#flavorId").html("서버사양을 선택하여주세요.");
		}

		// 목록 페이지이동
		function moveListPage(){
			if($("#productSeq").val() == "20240820145200"){
				location.href = "${wasPath}/mbr/application/req/";
			} else {
				location.href = "${wasPath}/mbr/req/catalogue/catalogueBasicList.do?hourlyFlag=N";
			}
// 			location.href = "${wasPath}/mbr/req/catalogue/catalogueBasicList.do?hourlyFlag=N";
		}

		function selectNetwork() {
			$("#volumeType").val($("#networkId option:selected").attr("volume"));
		}

	 	function getNetworkList(){
	 		$("#divNetwork").html("");
			$.ajax({
				url : "${wasPath}/mbr/oss/zone/list",
				dataType : "JSON",
	 			type : "GET",
				data : {
					"zoneName" : $("#azName > option:selected").val()
					,"cloudId" : $("#azName > option:selected").data("cloud")
					,"cloudType" : $("#azName > option:selected").data("type")
				},
				success : function(req) {
					var vHtml = "<div class='searchBoxArea2'>";
						vHtml += "<div class=''>";
						vHtml += "<label class='selectBoxDrop' for='networkId'>선택해주세요.</label>";
					 	vHtml += "<select class='search-sel' id='networkId' name='networkId' onChange='selectNetwork()'>";
						vHtml += "<option value='netId'>선택해주세요.</option>";
					for(var i=0; i<req.length; i++){

						vHtml += "<option value='"+req[i].networkId+"' volume='"+req[i].volumeType+"'>"+(req[i].networkAlias==""?req[i].networkName:req[i].networkAlias)+"</option>";
					}
					vHtml += "</select>"

					$("#divNetwork").html(vHtml);

				 	var Html = "<input type='hidden' id='netId' name='netId' value='netId' />";
					for(var i=0; i<req.length; i++){
							Html += "<input type='hidden' id='"+req[i].networkId+"' name='"+req[i].networkId+"' value='"+req[i].networkName+"' />";
							Html += "<input type='hidden' id='"+req[i].networkName+"' name='"+req[i].networkName+"' value='"+req[i].networkAlias+"' />";
					}
						$("#divNetwork").append(Html);

						// select box text 설정
						$(".search-sel").change(function() {
							$(this).siblings(".selectBoxDrop").text($(this).children('option:selected').text());
						});

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

	 	function getNetworkNutanixList(){
	 		$("#divNetwork").html("");
			$.ajax({
				url : "${wasPath}/mbr/oss/zone/list",
				dataType : "JSON",
	 			type : "GET",
				data : {
					"zoneName" : $("#azName > option:selected").val()
					,"cloudId" : $("#azName > option:selected").data("cloud")
					,"cloudType" : $("#azName > option:selected").data("type")
					,"blueprintUuid" : $("#blueprintUuid").val()
				},
				success : function(req) {
					console.log(req);
					var vHtml = "<div class='searchBoxArea2'>";
						vHtml += "<div class=''>";
						vHtml += "<label class='selectBoxDrop' for='networkId'>선택해주세요.</label>";
					 	vHtml += "<select class='search-sel' id='networkId' name='networkId' onChange='selectNetwork()'>";
						vHtml += "<option value='netId'>선택해주세요.</option>";
					for(var i=0; i<req.length; i++){

						vHtml += "<option value='"+req[i].networkId+"' >"+(req[i].networkAlias==""?req[i].networkName:req[i].networkAlias)+"</option>";
					}
					vHtml += "</select>"

					$("#divNetwork").html(vHtml);

				 	var Html = "<input type='hidden' id='netId' name='netId' value='netId' />";
					for(var i=0; i<req.length; i++){
							Html += "<input type='hidden' id='"+req[i].networkId+"' name='"+req[i].networkId+"' value='"+req[i].networkName+"' />";
							Html += "<input type='hidden' id='"+req[i].networkName+"' name='"+req[i].networkName+"' value='"+req[i].networkAlias+"' />";
					}
						$("#divNetwork").append(Html);

						// select box text 설정
						$(".search-sel").change(function() {
							$(this).siblings(".selectBoxDrop").text($(this).children('option:selected').text());
						});

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

	 	function getOsList(){
		 	$("#osProductSeq").html("");
	 		var cloudId = $("#azName").children('option:selected').data("cloud");
	 		var cloudType = $("#azName > option:selected").data("type");

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

					var html = "<option value=''>OS 선택</option>";
					$.each(req,function(k,v){

						html += "<option value='"+v['productSeq']+"'data-name='"+v['productName']+"'>"+v['productName']+"</option>";

					})

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
		//<--- Modal popup end

		// 호스트명(영문명) 중복체크
		function hostnameChk(){

			if($("#hostname").val()==""){
				alertBox3("호스트명을 입력하세요");
				return;
			}

			$.ajax({
				url : "${wasPath}/mbr/req/catalogue/hostnameChk",
	// 			dataType : "JSON",
	 			type : "GET",
				data : {
					"hostname" : $("#hostname").val()
				},
				success : function(data) {
					var result = data;

					if(result==0){
						$("#confirmMsg").css("color","blue");
						$("#confirmFlag").val("Y");
						alertBox3("사용가능한 호스트명입니다.");
					}else{
						$("#confirmMsg").css("color","#ff0000");
						$("#confirmFlag").val("N");
						alertBox3("이미 사용중인 호스트명입니다.");
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
		// 팝업메시지 세팅
		function alertModal(txt){
			$("#confirmMsg").text(txt);
			$("#message-modal-dialog").modal();
		}

		// 구매전 확인 팝업
		function setOrder() {
			$("#pop_projectAlias").text($("#projectAlias").val());
			$("#pop_hostnameAlias").text($("#hostnameAlias").val());
			$("#pop_hostname").text($("#hostname").val());
			$("#pop_network").text($("#networkId > option:selected").text());
			if ($("input[name='backupNetworkFlag']:checked").val() == 'Y') {
				$("#pop_backupNWFlag").text('Y');
			} else {
				$("#pop_backupNWFlag").text('N');
			}

			if ($("input[name='onDemandFlag']:checked").val() == 'N') {
				$("#pop_onDemandFlag").text($("#applyDate").val()+' '+$("#applyTime").val()+':00');
				$("#applyDatetime").val($("#applyDate").val()+' '+$("#applyTime").val()+':00');
			} else if ($("input[name='onDemandFlag']:checked").val() == 'Y') {
				$("#pop_onDemandFlag").text('승인 완료 후 생성');
			}
			$("#cloudPanel").text($("#azName > option:selected").data("name"));
			$("#pop_cpucnt").text($("#cpucnt").val()+' Core');
			$("#pop_memcnt").text($("#memcnt").val()+' GB');
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
		function noworder(){
			var checkVal = "";
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
			if( (approvalList[3] == undefined || approvalList[3] == null || approvalList[3] == '') && $("#selectApprv").val() == 'N' ) {
				alertBox3("결재자를 지정해 주세요");
				return false;
			}

			$("input:checkbox[name='network']").each(function(){
				if($(this).is(":checked")){
					checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "Y" + ",";
				}else{
					checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "N" +",";
				}
			});

			checkVal = checkVal.substring(0, checkVal.length-1);

			$("#networkChk").val(checkVal);
			//alertBox3($("#networkChk").val());

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
			if($("#networkId > option:selected").val()=="netId"){
				alertBox3("네트워크를 선택하세요");
				return false;
			}
			/*
			if($("#hostname").val()==""){
				alertBox3("호스트명을 입력하세요");
				return false;
			}
			if($("#confirmFlag").val()=="N"){
				alertBox3("호스트명 중복확인을 하세요");
				$("#hostname").focus();
				return false;
			}
			*/
			if($("#hostnameAlias").val()==""){
				alertBox3("서버명을 입력하세요");
				return false;
			}

			if($("#osProductSeq > option:selected").val()==""){
				alertBox3("OS를 선택하세요");
				return false;
			}

			//alertBox3($("#networkId > option:selected").text());
			$("#networkAlias").val($("#networkId > option:selected").text());
			//alertBox3($("#networkId > option:selected").val());


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

		//modal팝업 open
		function openModalok(){
			$("#modal-dialogok").modal();
		}

		// 신청신청
		function catalogueOrderInsert(){
			var jsonData = setJsonData();
			$.ajax({
				url : "catalogueOrderNow",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					//openModal2();
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


		// jsonData 세팅
		function setJsonData(){

			$("#amount").val(rtnnumber($("#amount").val()));

			var applyDatetime = $("#applyDatetime").val();
			var jsonData;

			if(applyDatetime == ""){
				jsonData={
						"type" : "noworderinsert" // 타입은 수정
						, "vmProductSeq" : $("#productSeq").val() //productSeq
						, "amount" : rtnnumber($("#totalPrice").val()) //totalPrice
						, "onDemandFlag" : $("input[name='onDemandFlag']:checked").val() //onDemandFlag
						, "projectName" : $("#projectName").val()//projectName
						, "hostname" : $("#hostname").val()//hostname
						, "hostnameAlias" : $("#hostnameAlias").val()//hostnameAlias
						, "vcpus" : $("#cpucnt").val()//cpucnt
						, "memGb" : $("#memcnt").val()//memcnt
						, "diskGb" : $("#diskcnt").val()//diskcnt
						, "osProductSeq" : $("#osProductSeq").val()//osProductSeq
						, "projectId" : $("#projectId").val()//projectId
						, "productCategory" : $("#productCategory").val()//	productCategory
						, "hourlyFlag" : $("input[name='hourlyFlag']:checked").val()		//$("input[name='hourlyFlag']:checked").val()
						, "orderName" : ""	//
						, "description" : $("#description").val() // description
						, "defaultNetworkId" : $("#networkId").val() //networkId
						, "defaultNetworkName" : $("#defaultNetworkName").val() //defaultNetworkName
						, "defaultNetworkAlias" : $("#defaultNetworkAlias").val() //defaultNetworkAlias
						, "networkChk" : $("#networkChk").val()//networkChk
						, "catalogSeq" : $("#catalogSeq").val() //catalogSeq
						, "volumeType" : $("#networkId option:selected").attr("volume")
					}
			}else{
				jsonData={
						"type" : "noworderinsert" // 타입은 수정
						, "vmProductSeq" : $("#productSeq").val() //productSeq
						, "amount" : rtnnumber($("#totalPrice").val()) //totalPrice
						, "applyDatetime" : $("#applyDate").val() + $("#applyTime").val() + ":00" //${ordervo.applyDate} ${ordervo.applyTime}:00
						, "onDemandFlag" : $("input[name='onDemandFlag']:checked").val()  //onDemandFlag
						, "projectName" : $("#projectName").val()//projectName
						, "hostnameAlias" : $("#hostnameAlias").val()//hostnameAlias
						, "hostname" : $("#hostname").val()//hostname
						, "vcpus" : $("#cpucnt").val()//cpucnt
						, "memGb" : $("#memcnt").val()//memcnt
						, "diskGb" : $("#diskcnt").val()//diskcnt
						, "osProductSeq" : $("#osProductSeq").val()//osProductSeq
						, "projectId" : $("#projectId").val()//projectId
						, "productCategory" : $("#productCategory").val()	//productCategory
						, "hourlyFlag" : $("input[name='hourlyFlag']:checked").val()		//$("input[name='hourlyFlag']:checked").val()
						, "orderName" : ""		//
						, "description" : $("#description").val() //
						, "defaultNetworkId" : $("#networkId").val()  //networkId
						, "defaultNetworkName" : $("#defaultNetworkName").val() //defaultNetworkName
						, "defaultNetworkAlias" : $("#defaultNetworkAlias").val() //defaultNetworkAlias
						, "networkChk" : $("#networkChk").val() //networkChk
						, "catalogSeq" : $("#catalogSeq").val() //catalogSeq
						, "volumeType" : $("#networkId option:selected").attr("volume")
					}
			}

			return jsonData;
		}

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
								$(select).append( $('<option>').text("서버사양을 선택하세요.").val(""));
							}

							$(select).append( $('<option>').text(option.text).val(option.value).attr("cpu", option.cpu).attr("mem", option.mem).attr("disk", option.disk) );
							a++;
						}
					});
					if (selectSingleMatch === true && $(select).children().length === 1) {
						$(select).childeren().get(0).selected = true;
					}
					$("#flavorId2").text("서버사양을 선택하여주세요.");
				});
			});
		};

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
		    calendar();
		    initApprovalLine();

			$("#flavorId").filterBySelect($("#osSvrSpecGroup"), false);
		    $("#osSvrSpecGroup").change();

		//	$("a>button").on('click',function(){
		//	location.href = $(this).closest("a").attr("href");
		//	});
		    if($("input[name='onDemandFlag']:checked").val()=="N"){
		    	$("#sdate").show();
			}else{
				$("#sdate").hide();
			}

		    $("input[name='hourlyFlag']").on('click',function(){
				vmOrderView();
			});

		    $("input[name='backupNetworkFlag']").on('click',function(){
		    	if ($(this).val() == "Y") {
				alertBox("백업 네트워크 포함 옵션을 선택하셔도 백업 서비스는 별도로 신청해야 합니다.");
		    	}
			});

			// 중복체크 확인용
			$("#hostname").on({
				"keypress" : function(){
			 		$("#confirmFlag").val("N");
			 	},
			 	"keyup blur" : function(e){
					var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
					if(pattern.test(this.value)){
						$(this).val(this.value.replace(pattern, ''));
					}
					var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
					if(pattern2.test(this.value)){
						$(this).val(this.value.replace(pattern2, ''));
					}
			 	}
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
					$("#selectTEXT").empty().append("<i class='fa fa-exclamation-circle f16 fc-dblue2'></i> <span class='fb'>관리자의 최종 승인 후 선택한 시간에 가상머신이 생성 됩니다. </span>" );
					$("#selectTEXT").show();
				}else{
					$("#selectTEXT").empty().append("<i class='fa fa-exclamation-circle f16 fc-dblue2'></i> <span class='fb'>관리자의 최종승인 후 가상머신이 생성 됩니다. </span>" );
					$("#selectTEXT").show();
				}
			});

			setProductPrice();
			var instanceType = $("#instanceType").val();

		    //메뉴활성화
		    if(instanceType == "INSTANCE_CTNTRMNL"){
		    	$("#pageTitle").text("컨테이너터미널 신청");
		    	$("#reqDev").addClass("active");
				$("#reqCt").addClass("active");
		    } else if(instanceType != "INSTANCE_GPU") {
		    	$("#pageTitle").text("기본자원 신청");
				$("#reqProduct").addClass("active");
				$("#basic").addClass("active");
		    } else{
		    	$("#pageTitle").text("기본자원 신청 GPU");
				$("#reqProduct").addClass("active");
				$("#basicGPU").addClass("active");
		    }
		});

		function getFlavorTypeList(){

			var cloudId = $("#azName").children('option:selected').data("cloud");

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
						if($("#instanceType").val() == "INSTANCE_CTNTRMNL"){
							if(v['flavorType'] == "as"){
								html += "<option value='"+v['flavorType']+"'>"+v['flavorName']+"</option>";
							}
						}else{
							html += "<option value='"+v['flavorType']+"'>"+v['flavorName']+"</option>";
						}
					})

					$("#osSvrSpecGroup").html(html);
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

		function getCatalogueFlavorList(){

			var cloudId = $("#azName").children('option:selected').data("cloud");

			var instanceType = "";
			if($("#instanceType").val() != "INSTANCE_CTNTRMNL"){
				instanceType = $("#instanceType").val();
			}

			$.ajax({
				url : "${wasPath}/mbr/req/catalogue/getCatalogueFlavorList",
				dataType : "JSON",
	 			type : "GET",
				data : {
					"cloudId" : cloudId,
					"instanceType": instanceType
				},
				success : function(req) {
					var html = "";
					$.each(req,function(k,v){

						var ramGb = v['ramMb'] / 1024;
						html += "<option group='"+v['flavorType']+"' cpu='"+v['vcpus']+"' mem='"+ramGb+"' disk='50' value='"+v['flavorId']+"'>CPU : "+v['vcpus']+"Core MEM: "+ramGb+"GB</option>";
					})
					$("#flavorId").html(html);
					$("#flavorId").filterBySelect($("#osSvrSpecGroup"), false);
					$("#osSvrSpecGroup option:first").prop("selected", true).trigger('change');
					$("#flavorId option:first").prop("selected", true).trigger('change');
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



		function getNetworkList(){
	 		$("#divNetwork").html("");
			$.ajax({
				url : "${wasPath}/mbr/oss/zone/list",
				dataType : "JSON",
	 			type : "GET",
				data : {
					"zoneName" : $("#azName > option:selected").val()
					,"cloudId" : $("#azName > option:selected").data("cloud")
					,"cloudType" : $("#azName > option:selected").data("type")
				},
				success : function(req) {
					console.log(req);
					var vHtml = "<div class='searchBoxArea2'>";
						vHtml += "<div class=''>";
						vHtml += "<label class='selectBoxDrop' for='networkId'>선택해주세요.</label>";
					 	vHtml += "<select class='search-sel' id='networkId' name='networkId' onChange='selectNetwork()'>";
						vHtml += "<option value='netId'>선택해주세요.</option>";
					for(var i=0; i<req.length; i++){

						vHtml += "<option value='"+req[i].networkId+"' volume='"+req[i].volumeType+"'>"+(req[i].networkAlias==""?req[i].networkName:req[i].networkAlias)+"</option>";
					}
					vHtml += "</select>"

					$("#divNetwork").html(vHtml);

				 	var Html = "<input type='hidden' id='netId' name='netId' value='netId' />";
					for(var i=0; i<req.length; i++){
							Html += "<input type='hidden' id='"+req[i].networkId+"' name='"+req[i].networkId+"' value='"+req[i].networkName+"' />";
							Html += "<input type='hidden' id='"+req[i].networkName+"' name='"+req[i].networkName+"' value='"+req[i].networkAlias+"' />";
					}
						$("#divNetwork").append(Html);

						// select box text 설정
						$(".search-sel").change(function() {
							$(this).siblings(".selectBoxDrop").text($(this).children('option:selected').text());
						});

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

		function getProjectZoneList(){
	 		$("#azName").html("");

	 		var instanceType = $("#instanceType").val();
			$.ajax({
				url : "${wasPath}/mbr/oss/zone/projectZoneList",
				dataType : "JSON",
	 			type : "GET",
				data : {
					"projectBoxId" : $("#projectBoxId").val()
				},
				success : function(req) {
					var vHtml = "<select class='search-sel' name='azName' id='azName' onChange='selectAz();'>";
						vHtml += "<option value=''>대역선택</option>";

					for(var i=0; i<req.length; i++){
						if(instanceType === "INSTANCE_GPU" && req[i].zoneName === "oa-gpu-zone"){
								vHtml += "<option value='"+req[i].zoneName+"' data-cloud='"+req[i].cloudId+"' data-type='"+req[i].cloudType+"' data-name='"+req[i].cloudName+"'>"+req[i].zoneDisplayName+"</option>"
						}else if(instanceType === "INSTANCE_CTNTRMNL" && req[i].zoneName === "oa-zone"){
							vHtml += "<option value='"+req[i].zoneName+"' data-cloud='"+req[i].cloudId+"' data-type='"+req[i].cloudType+"' data-name='"+req[i].cloudName+"'>"+req[i].zoneDisplayName+"</option>"
						}else if(instanceType === "INSTANCE_NORMAL" && (req[i].zoneName === "oa-zone" ||
								                                                                       req[i].zoneName === "oa-dev-zone" ||
								                                                                       req[i].zoneName === "fa-zone" ||
								                                                                       req[i].zoneName === "dmz-netapp-zone" ||
								                                                                       req[i].zoneName === "oa-hci-zone" ||
								                                                                       req[i].zoneName === "EM-Mobile" ||
								                                                                       req[i].zoneName === "EM-DMZ" ||
								                                                                       req[i].zoneName === "PA-mobile" ||
								                                                                       req[i].zoneName === "PA-DMZ")){

							vHtml += "<option value='"+req[i].zoneName+"' data-cloud='"+req[i].cloudId+"' data-type='"+req[i].cloudType+"' data-name='"+req[i].cloudName+"'>"+req[i].zoneDisplayName+"</option>"
						}
					}
					vHtml += "</select>"
					$("#azName").html(vHtml);
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