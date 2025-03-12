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
				<h1>자원구성 수정</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">자원관리</a><a href="#" class="on">자원구성 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<div class="client_DetailArea clearfix  m-b-40">
					<input type="hidden" id="productSeq" value="${productSeq}">
					<input type="hidden" id="productCategory" value="${productCategory}">
					<input type="hidden" id="itemId" value="${itemId}">

					<input type="hidden" id="serviceType" value="${serviceType}">
					<input type="hidden" id="productImageType" value="${productImageType}">
					<input type="hidden" id="productDiskType" value="${productDiskType}">
					<input type="hidden" id="productVmDiskType" value="${productVmDiskType}">
					<input type="hidden" id="hiddenOsMonthlyPrice" value="">

					<input type="hidden" id="h_price_vm_cpu_hourly" value="${getItemPrice.cpuHourlyPrice/getItemPrice.cpuQuantity}">
					<input type="hidden" id="h_price_vm_cpu_monthly_price" value="${getItemPrice.cpuMonthlyPrice/getItemPrice.cpuQuantity}">
					<input type="hidden" id="h_price_vm_mem_hourly" value="${getItemPrice.memHourlyPrice/getItemPrice.memQuantity}">
					<input type="hidden" id="h_price_vm_mem_monthly_price" value="${getItemPrice.memMonthlyPrice/getItemPrice.memQuantity}">
					<input type="hidden" id="h_price_vm_disk_hourly" value="${getItemPrice.diskHourlyPrice/getItemPrice.diskQuantity}">
					<input type="hidden" id="h_price_vm_disk_monthly_price" value="${getItemPrice.diskMonthlyPrice/getItemPrice.diskQuantity}">
					<input type="hidden" id="h_price_nas_hourly" value="${getItemPrice.nasHourlyPrice/getItemPrice.nasQuantity}">
					<input type="hidden" id="h_price_nas_monthly_price" value="${getItemPrice.nasMonthlyPrice/getItemPrice.nasQuantity}">

					<input type="hidden" id="h_price_san_vm_disk_hourly" value="${getItemPrice.sanDiskHourlyPrice/getItemPrice.sanDiskQuantity}">
					<input type="hidden" id="h_price_san_vm_disk_monthly_price" value="${getItemPrice.sanDiskMonthlyPrice/getItemPrice.sanDiskQuantity}">
					<input type="hidden" id="h_price_san_vm_disk_quantity" value="${getItemPrice.sanDiskQuantity}">
					<input type="hidden" id="h_price_sata_vm_disk_hourly" value="${getItemPrice.sataDiskHourlyPrice/getItemPrice.sataDiskQuantity}">
					<input type="hidden" id="h_price_sata_vm_disk_monthly_price" value="${getItemPrice.sataDiskMonthlyPrice/getItemPrice.sataDiskQuantity}">
					<input type="hidden" id="h_price_sata_vm_disk_quantity" value="${getItemPrice.sataDiskQuantity}">
					<input type="hidden" id="h_price_sas_vm_disk_hourly" value="${getItemPrice.sasDiskHourlyPrice/getItemPrice.sasDiskQuantity}">
					<input type="hidden" id="h_price_sas_vm_disk_monthly_price" value="${getItemPrice.sasDiskMonthlyPrice/getItemPrice.sasDiskQuantity}">
					<input type="hidden" id="h_price_sas_vm_disk_quantity" value="${getItemPrice.sasDiskQuantity}">

					<input type="hidden" id="h_price_vmimglin_hourly_price" value="${getItemPrice.vmimglinHourlyPrice/getItemPrice.vmimglinQuantity}">
					<input type="hidden" id="h_price_vmimglin_monthly_price" value="${getItemPrice.vmimglinMonthlyPrice/getItemPrice.vmimglinQuantity}">
					<input type="hidden" id="h_price_vmimgwin_hourly_price" value="${getItemPrice.vmimgwinHourlyPrice/getItemPrice.vmimgwinQuantity}">
					<input type="hidden" id="h_price_vmimgwin_monthly_price" value="${getItemPrice.vmimgwinMonthlyPrice/getItemPrice.vmimgwinQuantity}">
					<input type="hidden" id="h_price_vmimgweb_hourly_price" value="${getItemPrice.vmimgwebHourlyPrice/getItemPrice.vmimgwebQuantity}">
					<input type="hidden" id="h_price_vmimgweb_monthly_price" value="${getItemPrice.vmimgwebMonthlyPrice/getItemPrice.vmimgwebQuantity}">
					<input type="hidden" id="h_price_vmimgwas_hourly_price" value="${getItemPrice.vmimgwasHourlyPrice/getItemPrice.vmimgwasQuantity}">
					<input type="hidden" id="h_price_vmimgwas_monthly_price" value="${getItemPrice.vmimgwasMonthlyPrice/getItemPrice.vmimgwasQuantity}">
					<input type="hidden" id="h_price_vmimgwdev_hourly_price" value="${getItemPrice.vmimgwdevHourlyPrice/getItemPrice.vmimgwdevQuantity}">
					<input type="hidden" id="h_price_vmimgwdev_monthly_price" value="${getItemPrice.vmimgwdevMonthlyPrice/getItemPrice.vmimgwdevQuantity}">
	                <input type="hidden" id="h_price_vmimgwdb_hourly_price" value="${getItemPrice.vmimgwdbHourlyPrice/getItemPrice.vmimgwdbQuantity}">
					<input type="hidden" id="h_price_vmimgwdb_monthly_price" value="${getItemPrice.vmimgwdbMonthlyPrice/getItemPrice.vmimgwdbQuantity}">

					<input type="hidden" id="h_price_service_account_hourly" value="${getItemPrice.serviceAccountHourlyPrice/getItemPrice.serviceAccountQuantity}">
					<input type="hidden" id="h_price_service_account_monthly_price" value="${getItemPrice.serviceAccountMonthlyPrice/getItemPrice.serviceAccountQuantity}">
					<input type="hidden" id="h_price_service_security_hourly" value="${getItemPrice.serviceSecurityHourlyPrice/getItemPrice.serviceSecurityQuantity}">
					<input type="hidden" id="h_price_service_security_monthly_price" value="${getItemPrice.serviceSecurityMonthlyPrice/getItemPrice.serviceSecurityQuantity}">
					<input type="hidden" id="h_price_service_backup_hourly" value="${getItemPrice.serviceBackupQuantity/getItemPrice.serviceBackupQuantity}">
					<input type="hidden" id="h_price_service_backup_monthly_price" value="${getItemPrice.serviceBackupMonthlyPrice/getItemPrice.serviceBackupQuantity}">
					<input type="hidden" id="h_price_service_sw_hourly" value="${getItemPrice.serviceSwHourlyPrice/getItemPrice.serviceSwQuantity}">
					<input type="hidden" id="h_price_service_sw_monthly_price" value="${getItemPrice.serviceSwMonthlyPrice/getItemPrice.serviceSwQuantity}">
					<input type="hidden" id="h_price_service_disk_hourly" value="${getItemPrice.serviceDiskHourlyPrice/getItemPrice.serviceDiskQuantity}">
					<input type="hidden" id="h_price_service_disk_monthly_price" value="${getItemPrice.serviceDiskMonthlyPrice/getItemPrice.serviceDiskQuantity}">



					<h2 class="blueBoxTitle">자원 정보</h2>
					<div class="clear"></div>
					<h2 class="categoryTitle dpin mt10" id="productCategoryName" ></h2> <input type="text" id="productName" class="dpin w50 ml20">
					<p class="company_Info">
						<span class="company_labelf">사용여부 :</span><span class="company_cont" id="delFlag"></span>
						<span class="company_label">등록자 :</span><span class="company_cont" id="regUserName"></span>
						<span class="company_label">등록일시 :</span><span class="company_cont fontVdn" id="regDatetime2"></span>
					</p>
				</div>

				<!-- 가상서버 -->
				<div class="formType01"  id="productList">
					<div class="col-xs-6">
					<h2 class="titleBuType01 m-b-20">가상서버 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="120px">
								 <col width="80px">
								 <col width="50px">
								 <col width="*">
								 <col width="60px">
								 <col width="90px">
							</colgroup>
								<tr>
									<th scope="row"><strong class="fontVdn">vCPU</strong></th>
									<td class="fontVdn">
										<span class="flr">
											<span id="vcpus"></span>
											<span class="fc66 wd35 tar dpin fontN">Core</span>
										</span>
									</td>
									<td class="p-0 tac">
										<div class="modeArrow"></div>
									</td>
									<td class="fontVdn">
										<span class="flr">
											<input type="text" maxlength="5" style="width: 120px" class="tar" id="vcpus2" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount(this, 'vcpus', 'vcpus2', 'modiVcpu');"/>
											<span class="fc66 wd35 tar dpin fontN">Core</span>
										</span>
									</td>
									<td rowspan="3" class="modeArea pStatic fontB fc33 p-0 tac" style="border-bottom: 1px solid #8593a9;">
										차이
									</td>
									<td class="modeArea pStatic fontVdn">
										<span class="flr">
											<span class="fontB" id="modiVcpu">0</span>
											<span class="fc66 wd35 tar dpin fontN">Core</span>
										</span>
									</td>
								</tr>

								<tr>
									<th scope="row"><strong class="fontVdn">MEMORY</strong></th>
									<td class="fontVdn">
										<span class="flr">
											<span id="memGb"></span>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>
									<td class="p-0 tac">
										<div class="modeArrow"></div>
									</td>
									<td class="fontVdn">
										<span class="flr">
											<input type="text" maxlength="5" style="width: 120px"  class="tar" id="memGb2" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount(this, 'memGb', 'memGb2', 'modiMemGb');"/>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>
									<td class="modeArea pStatic fontVdn">
										<span class="flr">
											<span id="modiMemGb">0</span>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>
								</tr>

								<tr>
									<th scope="row"><strong class="fontVdn">DISK</strong></th>
									<td class="fontVdn">
										<span class="flr">
											<span id="diskGb"></span>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>
									<td class="p-0 tac">
										<div class="modeArrow"></div>
									</td>
									<td class="fontVdn">
										<span class="flr">
											<input type="text" maxlength="5" style="width: 120px" class="tar" id="diskGb2" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount(this, 'diskGb', 'diskGb2', 'modiDiskGb');"/>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>
									<td class="modeArea pStatic fontVdn">
										<span class="flr">
											<span id="modiDiskGb">0</span>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>
								</tr>
							</tbody>
						</table>

						<table class="mt20">
						   <colgroup>
								 <col width="120px">
								 <col width="*">
							</colgroup>
								<!-- 이미지 목록 추가 시작 -->
								<tr>
								 <th><strong>이미지 유형</strong></th>
									  <td><select class="form-control w60 pb6" id="imageType" name="imageType" onchange="productAmountChage();">
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
									<tr>
								 <th><strong>디스크 유형</strong></th>
									  <td><select class="form-control w60 pb6" id="vmDiskType" name="vmDiskType" onchange="productAmountChage();">
									           	<option value="">디스크 유형</option>
											<c:forEach items="${cmmCode}" var="cmmCode" varStatus="status" >
												<c:if test="${cmmCode.parentCodeId eq 'ITEMCATE_DISK'}">
												<option value="${cmmCode.codeId}" code="${cmmCode.codeValue}">${cmmCode.codeName}</option>
												</c:if>
											</c:forEach>
										</select>
									   </td>
								</tr>

						</table>
					</div>
					</div>

					<div class="col-xs-6">
					<!-- 가격정보 -->
	                <div class="formType01"  id="">
						<h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
								 	<col width="120px">
									<col width="80px">
									<col width="50px">
									<col width="*">
									<col width="60px">
									<col width="90px">
								</colgroup>
								<tbody>
									<tr>
										<th><strong>변경 월 금액</strong></th>
										<td>
											<span class="flr">
												<span class="fontVdn" id="vmMonthlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td>
											<span class="flr">
												<span class="fontB fontVdn" id="vmMonthlyPrice2">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="modeArea pStatic fc33 p-0 tac">
											차액
										</td>
										<td class="modeArea pStatic">
											<span class="flr">
												<span class="fontVdn" id="vmMonthlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</div>
				</div>

				<input type="hidden" id="vmHourlyPrice" value="">
				<input type="hidden" id="vmHourlyPrice2" value="">
				<input type="hidden" id="vmHourlyDif" value="">

				<!-- 운영체제 -->
				<div class="formType01"  id="osList" style="display:none;">
				    <div class="col-xs-6">
					<h2 class="titleBuType01 m-b-20">운영체제 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="190px">
								 <col width="*">
							</colgroup>
								<tr>
									<th scope="row"><strong>운영체제</strong></th>
									<td>
										<input type="text" style="width:400px;" maxlength="40" id="itemName"  title="" onchange="productAmountChage();">
										<a type="button" class="bton-s bton_blue
										"  id="billItemList" name="billItemList" onclick="openBillItemModal();"><span class="txt"><i class="fa fa-search"></i>검색</span></a>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>수량(단위)</strong></th>
									<td class="fontVdn">
										<span class="flr f16 fontB">
											<span id="quantity"></span>
											<span class="fc66 wd35 tar dpin fontN">EA</span>
										</span>
									</td>
								</tr>
								<tr>
								<th scope="row"><strong>클라우드</strong></th>
									<td>
										<input type="hidden" id="cloudId" value="">
										<input type="text" style="width:400px;" maxlength="40" id="cloudName" disabled="" data-original-title="" title="">
										<a type="button" class="bton-s bton_blue"  id="cloudList" name="cloudList" onclick="openCloudModal();"><span class="txt"><i class="fa fa-search"></i>검색</span></a>
									</td>
								</tr>
								<tr>
								<th scope="row"><strong>이미지</strong></th>
									<td>
										<input type="hidden" id="vmImageId" value="">
										<input type="text" style="width:400px;" maxlength="40" id="vmImageName" disabled="" data-original-title="" title="">
										<a type="button" class="bton-s bton_blue"  id="billItemList" name="billItemList" onclick="openImageModal();"><span class="txt"><i class="fa fa-search"></i>검색</span></a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>

					<!-- 가격정보3 -->
					<div class="col-xs-6">
	                <div class="formType01"  id="">
						<h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col width="100px">
									 <col width="100px">
									 <col width="100px">
									 <col width="*">
								</colgroup>
												<tr>
										<th scope="row"><strong>변경 월 금액</strong></th>
										<td>
											<span class="flr f16">
												<span class="fontVdn" id="osMonthlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td>
											<span class="flr f16">
												<span class="fontB f20 modiMinus fontVdn" id="osMonthlyPriceChange">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td rowspan="2" class="modeArea pStatic fontB fc33 f16 p-0 tac">
											차액
										</td>
										<td class="modeArea pStatic">
											<span class="flr f16">
												<span class="modiPlus fontVdn fontB" id="osMonthlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>

								</tbody>
							</table>
						</div>
					</div>
					</div>
				</div>

				<!-- 블록디스크 -->
				<div class="formType01"  id="diskList" style="display:none;">

					<div class="col-xs-6">
					<h2 class="titleBuType01 m-b-20">블록디스크 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="16%">
								 <col width="20%">
								 <col width="50px">
								 <col width="*">
								 <col width="10%">
								 <col width="20%">
							</colgroup>
								<tr>
									<th scope="row"><strong class="fontVdn">DISK</strong></th>
									<td class="fontVdn">
										<span class="flr f16">
											<span id="diskDiskGb"></span>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>
									<td class="p-0 tac">
										<div class="modeArrow"></div>
									</td>
									<td class="fontVdn">
										<span class="flr f16">
											<input type="text" maxlength="5" style="width: 120px" class="tar" id="diskDiskGb2" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount(this, 'diskDiskGb', 'diskDiskGb2', 'modiDiskDiskGb');"/>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>
									<td class="modeArea pStatic fontB fc33 f16 p-0 tac">
										차이
									</td>
									<td class="modeArea pStatic fontVdn">
										<span class="flr f16">
											<span class="modiMinus fontB" id="modiDiskDiskGb">0</span>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>

								</tr>
							</tbody>
						</table>

						<table class="mt20">
						   <colgroup>
								 <col width="16%">
								 <col width="*">
							</colgroup>

								 <tr>
								 <th><strong>디스크유형</strong></th>
									  <td><select class="form-control w50 pb6" id="diskType" name="diskType" onchange="productAmountChage();">
										           	<option value="">디스크 유형</option>
												<c:forEach items="${cmmCode}" var="cmmCode" varStatus="status" >
													<c:if test="${cmmCode.parentCodeId eq 'ITEMCATE_DISK'}">
														<option value="${cmmCode.codeId}" code="${cmmCode.codeValue}">${cmmCode.codeName}</option>
													</c:if>
												</c:forEach>
											</select>
									   </td>
								  </tr>

						</table>
					</div>
					</div>

					<!-- 가격정보 -->
					<div class="col-xs-6">
	                <div class="formType01">
						<h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
								 <col width="18%">
								 <col width="20%">
								 <col width="50px">
								 <col width="*">
								 <col width="10%">
								 <col width="20%">
								</colgroup>
									<tr>
										<th scope="row"><strong>변경 월 금액</strong></th>
										<td>
											<span class="flr f16">
												<span class="fontVdn" id="diskDiskMonthlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td>
											<span class="flr f16">
												<span class="fontB f20 modiMinus fontVdn" id="diskDiskMonthlyPrice2">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td rowspan="2" class="modeArea pStatic fontB fc33 f16 p-0 tac">
											차액
										</td>
										<td class="modeArea pStatic">
											<span class="flr f16">
												<span class="modiPlus fontVdn fontB" id="diskDiskMonthlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>

									<tr>
										<th scope="row"><strong>변경 시간 금액</strong></th>
										<td>
											<span class="flr f16">
												<span class="fontVdn" id="diskDiskHourlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td class="fontVdn">
											<span class="flr f16">
												<span class="fontB f20 modiMinus fontVdn" id="diskDiskHourlyPrice2">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="modeArea pStatic">
											<span class="flr f16">
												<span class="modiMinus fontVdn fontB" id="diskDiskHourlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</div>
				</div>

				<!-- NAS -->
				<div class="formType01"  id="nasList" style="display:none;">
					<div class="col-xs-6">
					<h2 class="titleBuType01 m-b-20">NAS 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="16%">
								 <col width="20%">
								 <col width="50px">
								 <col width="*">
								 <col width="10%">
								 <col width="20%">
							</colgroup>
								<tr>
									<th scope="row"><strong class="fontVdn">DISK</strong></th>
									<td class="fontVdn">
										<span class="flr f16">
											<span id="nasGb"></span>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>
									<td class="p-0 tac">
										<div class="modeArrow"></div>
									</td>
									<td class="fontVdn">
										<span class="flr f16">
											<input type="text" maxlength="5" style="width: 120px" class="tar" id="nasGb2" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount(this, 'nasGb', 'nasGb2', 'modiNasGb');"/>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>
									<td class="modeArea pStatic fontB fc33 f16 p-0 tac">
										차이
									</td>
									<td class="modeArea pStatic fontVdn">
										<span class="flr f16">
											<span class="modiMinus fontB" id="modiNasGb">0</span>
											<span class="fc66 wd35 tar dpin fontN">GB</span>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>

					<!-- 가격정보 -->
					<div class="col-xs-6">
	                <div class="formType01"  id="">
						<h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
								 <col width="18%">
								 <col width="20%">
								 <col width="50px">
								 <col width="*">
								 <col width="10%">
								 <col width="20%">
								</colgroup>
									<tr>
										<th scope="row"><strong>변경 월 금액</strong></th>
										<td>
											<span class="flr f16">
												<span class="fontVdn" id="nasMonthlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td>
											<span class="flr f16">
												<span class="fontB f20 modiMinus fontVdn" id="nasMonthlyPrice2">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td rowspan="2" class="modeArea pStatic fontB fc33 f16 p-0 tac">
											차액
										</td>
										<td class="modeArea pStatic">
											<span class="flr f16">
												<span class="modiPlus fontVdn fontB" id="nasMonthlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>

									<tr>
										<th scope="row"><strong>변경 시간 금액</strong></th>
										<td>
											<span class="flr f16">
												<span class="fontVdn" id="nasHourlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td class="fontVdn">
											<span class="flr f16">
												<span class="fontB f20 modiMinus fontVdn" id="nasHourlyPrice2">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="modeArea pStatic">
											<span class="flr f16">
												<span class="modiMinus fontVdn fontB" id="nasHourlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</div>
				</div>

				<!-- 서비스 로드분산 -->
				<div class="formType01"  id="lbList" style="display:none;">
				<div class="col-xs-6">
					<h2 class="titleBuType01 m-b-20">서비스 로드분산 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="16%">
								 <col width="20%">
								 <col width="50px">
								 <col width="*">
								 <col width="10%">
								 <col width="20%">
							</colgroup>
								<tr>
									<th scope="row"><strong>수량</strong></th>
									<td class="fontVdn">
										<span class="flr f16">
											<span id="loadbalancerEa"></span>
											<span class="fc66 wd35 tar dpin fontN">EA</span>
										</span>
									</td>
									<td class="p-0 tac">
										<div class="modeArrow"></div>
									</td>
									<td class="fontVdn">
										<span class="flr f16">
											<input type="text" maxlength="5" style="width: 120px" class="tar" id="loadbalancerEa2"  onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount(this, 'loadbalancerEa', 'loadbalancerEa2', 'modiLoadbalancerEa');"/>
											<span class="fc66 wd35 tar dpin fontN">EA</span>
										</span>
									</td>
									<td class="modeArea pStatic fontB fc33 f16 p-0 tac">
										차이
									</td>
									<td class="modeArea pStatic fontVdn">
										<span class="flr f16">
											<span class="modiMinus fontB" id="modiLoadbalancerEa">0</span>
											<span class="fc66 wd35 tar dpin fontN">EA</span>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
					<!-- 가격정보 -->
					<div class="col-xs-6">
	                <div class="formType01"  id="">
						<h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
								 <col width="18%">
								 <col width="20%">
								 <col width="50px">
								 <col width="*">
								 <col width="10%">
								 <col width="20%">
								</colgroup>
									<tr>
										<th scope="row"><strong>변경 월 금액</strong></th>
										<td>
											<span class="flr f16">
												<span class="fontVdn" id="lbMonthlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td>
											<span class="flr f16">
												<span class="fontB f20 modiMinus fontVdn" id="lbMonthlyPrice2">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td rowspan="2" class="modeArea pStatic fontB fc33 f16 p-0 tac">
											차액
										</td>
										<td class="modeArea pStatic">
											<span class="flr f16">
												<span class="modiPlus fontVdn fontB" id="lbMonthlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>

									<tr>
										<th scope="row"><strong>변경 시간 금액</strong></th>
										<td>
											<span class="flr f16">
												<span class="fontVdn" id="lbHourlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td class="fontVdn">
											<span class="flr f16">
												<span class="fontB f20 modiMinus fontVdn" id="lbHourlyPrice2">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="modeArea pStatic">
											<span class="flr f16">
												<span class="modiMinus fontVdn fontB" id="lbHourlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</div>
				</div>

				<!-- 공인IP -->
				<div class="formType01"  id="ipList" style="display:none;">
				<div class="col-xs-6">
					<h2 class="titleBuType01 m-b-20">공인IP 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="16%">
								 <col width="20%">
								 <col width="50px">
								 <col width="*">
								 <col width="10%">
								 <col width="20%">
							</colgroup>
								<tr>
									<th scope="row"><strong>수량</strong></th>
									<td class="fontVdn">
										<span class="flr f16">
											<span id="publicipEa"></span>
											<span class="fc66 wd35 tar dpin fontN">EA</span>
										</span>
									</td>
									<td class="p-0 tac">
										<div class="modeArrow"></div>
									</td>
									<td class="fontVdn">
										<span class="flr f16">
											<input type="text" maxlength="5" style="width: 120px" class="tar" id="publicipEa2" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount('publicipEa', 'publicipEa2', 'modiPublicipEa');"/>
											<span class="fc66 wd35 tar dpin fontN">EA</span>
										</span>
									</td>
									<td class="modeArea pStatic fontB fc33 f16 p-0 tac">
										차이
									</td>
									<td class="modeArea pStatic fontVdn">
										<span class="flr f16">
											<span class="modiMinus fontB" id="modiPublicipEa">0</span>
											<span class="fc66 wd35 tar dpin fontN">EA</span>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
					<!-- 가격정보 -->
					<div class="col-xs-6">
	                <div class="formType01"  id="">
						<h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
								 <col width="18%">
								 <col width="20%">
								 <col width="50px">
								 <col width="*">
								 <col width="10%">
								 <col width="20%">
								</colgroup>
									<tr>
										<th scope="row"><strong>변경 월 금액</strong></th>
										<td>
											<span class="flr f16">
												<span class="fontVdn" id="publicipMonthlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td>
											<span class="flr f16">
												<span class="fontB f20 modiMinus fontVdn" id="publicipMonthlyPrice2">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td rowspan="2" class="modeArea pStatic fontB fc33 f16 p-0 tac">
											차액
										</td>
										<td class="modeArea pStatic">
											<span class="flr f16">
												<span class="modiPlus fontVdn fontB" id="publicipMonthlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>

									<tr>
										<th scope="row"><strong>변경 시간 금액</strong></th>
										<td>
											<span class="flr f16">
												<span class="fontVdn" id="publicipHourlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td class="fontVdn">
											<span class="flr f16">
												<span class="fontB f20 modiMinus fontVdn" id="publicipHourlyPrice2">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="modeArea pStatic">
											<span class="flr f16">
												<span class="modiMinus fontVdn fontB" id="publicipHourlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</div>
				</div>

				<!-- 형상관리 -->
<!-- 				<div class="formType01"  id="scmList" style="display:none;"> -->
<!-- 				<div class="col-xs-6"> -->
<!-- 					<h2 class="titleBuType01 m-b-20">형상관리 서비스 정보</h2> -->
<!-- 					<div class="tblWrap clearfix"> -->
<!-- 						<table> -->
<%-- 							<colgroup> --%>
<%-- 								 <col width="16%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								 <col width="50px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 								 <col width="10%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 							</colgroup> --%>
<!-- 								<tr> -->
<!-- 									<th scope="row"><strong>수량</strong></th> -->
<!-- 									<td> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<span id="scmEa" class="fontVdn"></span> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN">식</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 									<td class="p-0 tac"> -->
<!-- 										<div class="modeArrow"></div> -->
<!-- 									</td> -->
<!-- 									<td> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<input type="text" maxlength="5" style="width: 120px" class="tar" id="scmEa2" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount('scmEa', 'scmEa2', 'modiScmEa');"/> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN">식</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 									<td class="modeArea pStatic fontB fc33 f16 p-0 tac"> -->
<!-- 										차이 -->
<!-- 									</td>  -->
<!-- 									<td class="modeArea pStatic"> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<span class="modiMinus fontB fontVdn" id="modiScmEa">0</span> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN">식</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</div> -->
<!-- 					</div> -->
<!-- 					가격정보 -->
<!-- 					<div class="col-xs-6"> -->
<!-- 	                <div class="formType01"  id=""> -->
<!-- 						<h2 class="titleBuType01 m-b-20">가격 정보</h2> -->
<!-- 						<div class="tblWrap clearfix"> -->
<!-- 							<table> -->
<%-- 								<colgroup> --%>
<%-- 								 <col width="18%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								 <col width="50px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 								 <col width="10%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								</colgroup> --%>
<!-- 									<tr> -->
<!-- 										<th scope="row"><strong>변경 월 금액</strong></th> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontVdn" id="scmMonthlyPrice">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="p-0 tac"> -->
<!-- 											<div class="modeArrow"></div> -->
<!-- 										</td> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontB f20 modiMinus fontVdn" id="scmMonthlyPrice2">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td rowspan="2" class="modeArea pStatic fontB fc33 f16 p-0 tac"> -->
<!-- 											차액 -->
<!-- 										</td> -->
<!-- 										<td class="modeArea pStatic"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="modiPlus fontVdn fontB" id="scmMonthlyDif">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 									</tr> -->

<!-- 									<tr> -->
<!-- 										<th scope="row"><strong>변경 시간 금액</strong></th> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontVdn" id="scmHourlyPrice">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="p-0 tac"> -->
<!-- 											<div class="modeArrow"></div> -->
<!-- 										</td> -->
<!-- 										<td class="fontVdn"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontB f20 modiMinus fontVdn" id="scmHourlyPrice2">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="modeArea pStatic"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="modiMinus fontVdn fontB" id="scmHourlyDif">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 									</tr>  -->
<!-- 								</tbody> -->
<!-- 							</table>  -->
<!-- 						</div> -->
<!-- 					</div>  -->
<!-- 					</div> -->
<!-- 				</div> -->

				<!-- 백업 -->
<!-- 				<div class="formType01"  id="bkList" style="display:none;"> -->
<!-- 				<div class="col-xs-6"> -->
<!-- 					<h2 class="titleBuType01 m-b-20">백업관리 정보</h2> -->
<!-- 					<div class="tblWrap clearfix"> -->
<!-- 						<table> -->
<%-- 							<colgroup> --%>
<%-- 								 <col width="16%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								 <col width="50px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 								 <col width="10%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 							</colgroup> --%>
<!-- 								<tr> -->
<!-- 									<th scope="row"><strong>용량</strong></th> -->
<!-- 									<td> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<span id="backupGb" class="fontVdn"></span> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN fontVdn">GB</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 									<td class="p-0 tac"> -->
<!-- 										<div class="modeArrow"></div> -->
<!-- 									</td> -->
<!-- 									<td> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<input type="text" maxlength="5" style="width: 120px" class="tar" id="backupGb2" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount(this, 'backupGb', 'backupGb2', 'modiBackupGb');"/> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN fontVdn">GB</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 									<td class="modeArea pStatic fontB fc33 f16 p-0 tac"> -->
<!-- 										차이 -->
<!-- 									</td>  -->
<!-- 									<td class="modeArea pStatic"> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<span class="modiMinus fontB fontVdn" id="modiBackupGb">0</span> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN fontVdn">GB</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</div> -->
<!-- 					</div> -->
<!-- 					가격정보 -->
<!-- 					<div class="col-xs-6"> -->
<!-- 	                <div class="formType01"  id=""> -->
<!-- 						<h2 class="titleBuType01 m-b-20">가격 정보</h2> -->
<!-- 						<div class="tblWrap clearfix"> -->
<!-- 							<table> -->
<%-- 								<colgroup> --%>
<%-- 								 <col width="18%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								 <col width="50px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 								 <col width="10%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								</colgroup> --%>
<!-- 									<tr> -->
<!-- 										<th scope="row"><strong>변경 월 금액</strong></th> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontVdn" id="backupMonthlyPrice">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="p-0 tac"> -->
<!-- 											<div class="modeArrow"></div> -->
<!-- 										</td> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontB f20 modiMinus fontVdn" id="backupMonthlyPrice2">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td rowspan="2" class="modeArea pStatic fontB fc33 f16 p-0 tac"> -->
<!-- 											차액 -->
<!-- 										</td> -->
<!-- 										<td class="modeArea pStatic"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="modiPlus fontVdn fontB" id="backupMonthlyDif">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 									</tr> -->

<!-- 									<tr> -->
<!-- 										<th scope="row"><strong>변경 시간 금액</strong></th> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontVdn" id="backupHourlyPrice">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="p-0 tac"> -->
<!-- 											<div class="modeArrow"></div> -->
<!-- 										</td> -->
<!-- 										<td class="fontVdn"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontB f20 modiMinus fontVdn" id="backupHourlyPrice2">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="modeArea pStatic"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="modiMinus fontVdn fontB" id="backupHourlyDif">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 									</tr>  -->
<!-- 								</tbody> -->
<!-- 							</table>  -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					</div>  -->
<!-- 				</div> -->


				<div class="formType01"  id="serviceList" style="display:none;">
				<div class="col-xs-6">
					<h2 class="titleBuType01 m-b-20">서비스 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="16%">
								 <col width="20%">
								 <col width="50px">
								 <col width="*">
								 <col width="10%">
								 <col width="20%">
							</colgroup>
								<tr>
									<th scope="row"><strong>수량</strong></th>
									<td>
										<span class="flr f16">
											<span id="serviceEa" class="fontVdn"></span>
											<span class="fc66 wd35 tar dpin fontN fontVdn">(식)</span>
										</span>
									</td>
									<td class="p-0 tac">
										<div class="modeArrow"></div>
									</td>
									<td>
										<span class="flr f16">
											<input type="text" maxlength="5" style="width: 120px" class="tar" id="serviceEa2" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount(this, 'serviceEa', 'serviceEa2', 'modiServiceGb');"/>
											<span class="fc66 wd35 tar dpin fontN fontVdn">(식)</span>
										</span>
									</td>
									<td class="modeArea pStatic fontB fc33 f16 p-0 tac">
										차이
									</td>
									<td class="modeArea pStatic">
										<span class="flr f16">
											<span class="modiMinus fontB fontVdn" id="modiServiceGb">0</span>
											<span class="fc66 wd35 tar dpin fontN fontVdn">(식)</span>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
					<!-- 가격정보 -->
					<div class="col-xs-6">
	                <div class="formType01"  id="">
						<h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
								 <col width="18%">
								 <col width="20%">
								 <col width="50px">
								 <col width="*">
								 <col width="10%">
								 <col width="20%">
								</colgroup>
									<tr>
										<th scope="row"><strong>변경 월 금액</strong></th>
										<td>
											<span class="flr f16">
												<span class="fontVdn" id="serviceMonthlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td>
											<span class="flr f16">
												<span class="fontB f20 modiMinus fontVdn" id="serviceMonthlyPrice2">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td rowspan="2" class="modeArea pStatic fontB fc33 f16 p-0 tac">
											차액
										</td>
										<td class="modeArea pStatic">
											<span class="flr f16">
												<span class="modiPlus fontVdn fontB" id="serviceMonthlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>

								<!-- 	<tr>
										<th scope="row"><strong>변경 시간 금액</strong></th>
										<td>
											<span class="flr f16">
												<span class="fontVdn" id="serviceHourlyPrice">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="p-0 tac">
											<div class="modeArrow"></div>
										</td>
										<td class="fontVdn">
											<span class="flr f16">
												<span class="fontB f20 modiMinus fontVdn" id="serviceHourlyPrice2">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
										<td class="modeArea pStatic">
											<span class="flr f16">
												<span class="modiMinus fontVdn fontB" id="serviceHourlyDif">0</span>
												<span class="fc66 wd35 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>  -->
								</tbody>
							</table>
						</div>
					</div>
					</div>
				</div>

				<input type="hidden" id="serviceHourlyPrice" value="">
				<input type="hidden" id="serviceHourlyPrice2" value="">
				<input type="hidden" id="serviceHourlyDif" value="">


               <!-- 대외계 -->
<!-- 				<div class="formType01"  id="mcaList" style="display:none;"> -->
<!-- 				<div class="col-xs-6"> -->
<!-- 					<h2 class="titleBuType01 m-b-20">대외계 서비스 정보</h2> -->
<!-- 					<div class="tblWrap clearfix"> -->
<!-- 						<table> -->
<%-- 							<colgroup> --%>
<%-- 								 <col width="16%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								 <col width="50px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 								 <col width="10%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 							</colgroup> --%>
<!-- 								<tr> -->
<!-- 									<th scope="row"><strong>수량</strong></th> -->
<!-- 									<td> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<span id="mcaEa" class="fontVdn"></span> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN">식</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 									<td class="p-0 tac"> -->
<!-- 										<div class="modeArrow"></div> -->
<!-- 									</td> -->
<!-- 									<td> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<input type="text" maxlength="5" style="width: 120px" class="tar" id="mcaEa2" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount(this, 'mcaEa', 'mcaEa2', 'modiMcaEa');"/> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN">식</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 									<td class="modeArea pStatic fontB fc33 f16 p-0 tac"> -->
<!-- 										차이 -->
<!-- 									</td>  -->
<!-- 									<td class="modeArea pStatic"> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<span class="modiMinus fontB fontVdn" id="modiMcaEa">0</span> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN">식</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</div> -->
<!-- 					</div> -->
<!-- 					가격정보 -->
<!-- 					<div class="col-xs-6"> -->
<!-- 	                <div class="formType01"  id=""> -->
<!-- 						<h2 class="titleBuType01 m-b-20">가격 정보</h2> -->
<!-- 						<div class="tblWrap clearfix"> -->
<!-- 							<table> -->
<%-- 								<colgroup> --%>
<%-- 								 <col width="18%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								 <col width="50px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 								 <col width="10%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								</colgroup> --%>
<!-- 									<tr> -->
<!-- 										<th scope="row"><strong>변경 월 금액</strong></th> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontVdn" id="mcaMonthlyPrice">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="p-0 tac"> -->
<!-- 											<div class="modeArrow"></div> -->
<!-- 										</td> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontB f20 modiMinus fontVdn" id="mcaMonthlyPrice2">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td rowspan="2" class="modeArea pStatic fontB fc33 f16 p-0 tac"> -->
<!-- 											차액 -->
<!-- 										</td> -->
<!-- 										<td class="modeArea pStatic"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="modiPlus fontVdn fontB" id="mcaMonthlyDif">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 									</tr> -->

<!-- 									<tr> -->
<!-- 										<th scope="row"><strong>변경 시간 금액</strong></th> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontVdn" id="mcaHourlyPrice">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="p-0 tac"> -->
<!-- 											<div class="modeArrow"></div> -->
<!-- 										</td> -->
<!-- 										<td class="fontVdn"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontB f20 modiMinus fontVdn" id="mcaHourlyPrice2">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="modeArea pStatic"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="modiMinus fontVdn fontB" id="mcaHourlyDif">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 						        			</span> -->
<!-- 										</td> -->
<!-- 									</tr>  -->
<!-- 								</tbody> -->
<!-- 							</table>  -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					</div>  -->
<!-- 				</div>        -->

                 <!-- 보안관제 -->
<!-- 				<div class="formType01"  id="serList" style="display:none;"> -->
<!-- 				<div class="col-xs-6"> -->
<!-- 					<h2 class="titleBuType01 m-b-20">보안관제 서비스 정보</h2> -->
<!-- 					<div class="tblWrap clearfix"> -->
<!-- 						<table> -->
<%-- 							<colgroup> --%>
<%-- 								 <col width="16%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								 <col width="50px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 								 <col width="10%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 							</colgroup> --%>
<!-- 								<tr> -->
<!-- 									<th scope="row"><strong>수량</strong></th> -->
<!-- 									<td> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<span id="securityEa" class="fontVdn"></span> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN">식</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 									<td class="p-0 tac"> -->
<!-- 										<div class="modeArrow"></div> -->
<!-- 									</td> -->
<!-- 									<td> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<input type="text" maxlength="5" style="width: 120px" class="tar" id="securityEa2" onblur="number_only(this);" style="ime-mode:disabled;" onkeyup="calcAmount(this, 'securityEa', 'securityEa2', 'modiSecurityEa');"/> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN">식</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 									<td class="modeArea pStatic fontB fc33 f16 p-0 tac"> -->
<!-- 										차이 -->
<!-- 									</td>  -->
<!-- 									<td class="modeArea pStatic"> -->
<!-- 										<span class="flr f16"> -->
<!-- 											<span class="modiMinus fontB fontVdn" id="modiSecurityEa">0</span> -->
<!-- 											<span class="fc66 wd35 tar dpin fontN">식</span> -->
<!-- 										</span> -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</div> -->
<!-- 					</div> -->
<!--  					</div> -->
					<!-- 가격정보 -->
<!-- 					<div class="col-xs-6"> -->
<!-- 	                <div class="formType01"  id=""> -->
<!-- 						<h2 class="titleBuType01 m-b-20">가격 정보</h2> -->
<!-- 						<div class="tblWrap clearfix"> -->
<!-- 							<table> -->
<%-- 								<colgroup> --%>
<%-- 								 <col width="18%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								 <col width="50px"> --%>
<%-- 								 <col width="*"> --%>
<%-- 								 <col width="10%"> --%>
<%-- 								 <col width="20%"> --%>
<%-- 								</colgroup> --%>
<!-- 									<tr> -->
<!-- 										<th scope="row"><strong>변경 월 금액</strong></th> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontVdn" id="securityMonthlyPrice">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="p-0 tac"> -->
<!-- 											<div class="modeArrow"></div> -->
<!-- 										</td> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontB f20 modiMinus fontVdn" id="securityMonthlyPrice2">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td rowspan="2" class="modeArea pStatic fontB fc33 f16 p-0 tac"> -->
<!-- 											차액 -->
<!-- 										</td> -->
<!-- 										<td class="modeArea pStatic"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="modiPlus fontVdn fontB" id="securityMonthlyDif">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 									</tr> -->

<!-- 									<tr> -->
<!-- 										<th scope="row"><strong>변경 시간 금액</strong></th> -->
<!-- 										<td> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontVdn" id="securityHourlyPrice">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="p-0 tac"> -->
<!-- 											<div class="modeArrow"></div> -->
<!-- 										</td> -->
<!-- 										<td class="fontVdn"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="fontB f20 modiMinus fontVdn" id="securityHourlyPrice2">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 										<td class="modeArea pStatic"> -->
<!-- 											<span class="flr f16"> -->
<!-- 												<span class="modiMinus fontVdn fontB" id="securityHourlyDif">0</span> -->
<!-- 												<span class="fc66 wd35 tar dpin fontN">원</span> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 									</tr>  -->
<!-- 								</tbody> -->
<!-- 							</table>  -->
<!-- 						</div> -->
<!-- 					</div>  -->
<!-- 					</div> -->
         	 		</div>
				<div class="row tac mt20">
		 			<a type="button" class="rbton bton_blue" onclick="setProductUpdate(${productSeq})"><i class="fa fa-floppy-o"></i> 저장</a>
					<a type="button" class="rbton bton_dgrey" onclick="moveViewPage();"><i class="fa fa-close"></i> 취소</a>
                </div>


			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

             </div>
			</div>


			<!-- #modal-dialog -->
			<div class="modal fade" id="modal-dialog-os" style="display:none;">
				<div class="modal-dialog">
                   <div class="modal-content width-570">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
                           <h4 class="modal-title">운영체제 선택</h4>
                       </div>
                       <div class="modal-body">
							<div class="listArea" id="osPopListDiv">
								<div class="listBg">
									<span class="name2"></span>
									<a class="applybtn active" ></a>
								</div>
								<div class="listBg">
									<span class="name2"></span>
									<a class="applybtn" ></a>
								</div>
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

			<div class="modal fade" id="modal-dialog-image" style="display:none;">
				<div class="modal-dialog">
                   <div class="modal-content width-570">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
                           <h4 class="modal-title">이미지 선택</h4>
                       </div>
                       <div class="modal-body">
							<div class="listArea" id="imagePopListDiv">
								<div class="listBg">
									<span class="name2"></span>
									<a class="applybtn" ></a>
								</div>
								<div class="listBg">
									<span class="name2"></span>
									<a class="applybtn" ></a>
								</div>
                      		</div>
                      		<div class="totalcnt">총 <span id="totalCnt">0</span> 건</div>
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



<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
 		//카탈로그 수정하기
 		function moveUpdatePage(catalogSeq){
				location.href = "${contextPath}/mng/bss/catalog/catalog?catalogSeq="+catalogSeq;
		}
		//자원 상세 정보 불러오기
		function productView(productSeq) {
			$.ajax({
				url : "${contextPath}/mng/bss/product/productView",
				dataType : "JSON",
	 			type : "POST",
				data : {
					"productSeq" : productSeq
				},
				success : function(data) {
					var result = data;
					productSetData(result);

				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		function productSetData(result){
			$("#productSeq").val(result.productSeq);
			$("#productName").val(result.productName);
			$("#productCategoryName").text(result.productCategoryName);
			$("#productCategory").val(result.productCategory);
			$("#serviceType").val(result.serviceType);
			$("#cloudName").val(result.cloudName);
			$("#cloudId").val(result.cloudId);
			$("#regUserId").text(result.regUserId);
			$("#regUserName").text(result.userName);
			$("#regDatetime2").text(result.regDatetime2);

			var cpuHourlyPrice = $("#h_price_vm_cpu_hourly").val();
			var cpuMonthlyPrice = $("#h_price_vm_cpu_monthly_price").val();
			var memHourlyPrice = $("#h_price_vm_mem_hourly").val();
			var memMonthlyPrice = $("#h_price_vm_mem_monthly_price").val();


			var diskHourlyPrice = $("#h_price_vm_disk_hourly").val();
			var diskMonthlyPrice = $("#h_price_vm_disk_monthly_price").val();


			var serviceAccountHourlyPrice = $("#h_price_service_account_hourly").val();
			var serviceAccountMonthlyPrice = $("#h_price_service_account_monthly_price").val();
			var serviceSecurityHourlyPrice = $("#h_price_service_security_hourly").val();
			var serviceSecurityMonthlyPrice = $("#h_price_service_security_monthly_price").val();
			var serviceBackupHourlyPrice = $("#h_price_service_backup_hourly").val();
			var serviceBackupMonthlyPrice = $("#h_price_service_backup_monthly_price").val();
			var serviceSwHourlyPrice = $("#h_price_service_sw_hourly").val();
			var serviceSwMonthlyPrice = $("#h_price_service_sw_monthly_price").val();
			var serviceDiskHourlyPrice = $("#h_price_service_disk_hourly").val();
			var serviceDiskMonthlyPrice = $("#h_price_service_disk_monthly_price").val();

			if((result.delFlag)=="N"){
				$("#delFlag").text("사용");
			}else {
				$("#delFlag").text("미사용");
			}

			if((result.productCategory)=="PRODCATE_VM"){
				$("#vcpus").text(result.vcpus);
				$("#memGb").text(result.memGb);
				$("#diskGb").text(addcomma(result.diskGb));

				if($("#vmDiskType").val() =="ITEMCATE_DISK_SAN"){
	            	var diskHourlyPrice = $("#h_price_san_vm_disk_hourly").val();
					var diskMonthlyPrice = $("#h_price_san_vm_disk_monthly_price").val();
				}else if($("#vmDiskType").val() =="ITEMCATE_DISK_SAS"){
					var diskHourlyPrice = $("#h_price_sas_vm_disk_hourly").val();
					var diskMonthlyPrice = $("#h_price_sas_vm_disk_monthly_price").val();
				}else if($("#vmDiskType").val() =="ITEMCATE_DISK_SATA"){
					var diskHourlyPrice = $("#h_price_sata_vm_disk_hourly").val();
					var diskMonthlyPrice = $("#h_price_sata_vm_disk_monthly_price").val();
				}

			 	if($("#imageType").val() =="VMIMGLIN100"){
					var imageHourlyPrice = $("#h_price_vmimglin_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimglin_monthly_price").val();
	            }else if($("#imageType").val() =="VMIMGWIN200"){
	            	var imageHourlyPrice = $("#h_price_vmimgwin_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimgwin_monthly_price").val();
	            }else if($("#imageType").val() =="VMIMGWEB110"){
	            	var imageHourlyPrice = $("#h_price_vmimgweb_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimgweb_monthly_price").val();
	            }else if($("#imageType").val() =="VMIMGWAS120"){
	            	var imageHourlyPrice = $("#h_price_vmimgwas_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimgwas_monthly_price").val();
	            }else if($("#imageType").val() =="VMIMGDB130"){
	            	var imageHourlyPrice = $("#h_price_vmimgwdb_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimgwdb_monthly_price").val();
	            }else if($("#imageType").val() =="VMIMGDEV140"){
	            	var imageHourlyPrice = $("#h_price_vmimgwdev_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimgwdev_monthly_price").val();
	            }

				var hp1 = result.vcpus*cpuHourlyPrice;
				var mp1 = result.vcpus*cpuMonthlyPrice;
				var hp2 = result.memGb*memHourlyPrice;
				var mp2 = result.memGb*memMonthlyPrice;
				var hp3 = result.diskGb*diskHourlyPrice;
				var mp3 = result.diskGb*diskMonthlyPrice;
				var hp4 = parseInt(imageHourlyPrice);
				var mp4 = parseInt(imageMonthlyPrice);

				$("#vmMonthlyPrice").text(addcomma(mp1+mp2+mp3+mp4)); //변경 월 금액
				$("#vmHourlyPrice").text(addcomma(hp1+hp2+hp3+hp4));

				showProductView();
			}else if((result.productCategory)=="PRODCATE_OS"){
				$("#itemId").val(result.itemId);
				$("#itemName").val(result.itemName);
				$("#quantity").text(result.quantity);
				$("#unit").text(result.unit);
				$("#vmImageId").val(result.vmImageId);
				$("#vmImageName").val(result.vmImageName);


				if($("#itemId").val() =="VMIMGLIN100"){
					var imageHourlyPrice = $("#h_price_vmimglin_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimglin_monthly_price").val();
	            }else if($("#itemId").val() =="VMIMGWIN200"){
	            	var imageHourlyPrice = $("#h_price_vmimgwin_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimgwin_monthly_price").val();
	            }else if($("#itemId").val() =="VMIMGWEB110"){
	            	var imageHourlyPrice = $("#h_price_vmimgweb_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimgweb_monthly_price").val();
	            }else if($("#itemId").val() =="VMIMGWAS120"){
	            	var imageHourlyPrice = $("#h_price_vmimgwas_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimgwas_monthly_price").val();
	            }else if($("#itemId").val() =="VMIMGDEV140"){
	            	var imageHourlyPrice = $("#h_price_vmimgwdev_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimgwdev_monthly_price").val();
	            }else if($("#itemId").val() =="VMIMGDB130"){
	            	var imageHourlyPrice = $("#h_price_vmimgwdb_hourly_price").val();
					var imageMonthlyPrice = $("#h_price_vmimgwdb_monthly_price").val();
	            }

				$("#osMonthlyPrice").text(addcomma(imageMonthlyPrice)); //변경 월 금액

				$("#hiddenOsMonthlyPrice").text(imageMonthlyPrice); //변경 월 금액

				showOsView();

			}else if((result.productCategory)=="PRODCATE_DISK"){
				$("#diskDiskGb").text(addcomma(result.diskGb));

				if($("#diskType").val() =="ITEMCATE_DISK_SAN"){
	            	var diskHourlyPrice = $("#h_price_san_vm_disk_hourly").val();
					var diskMonthlyPrice = $("#h_price_san_vm_disk_monthly_price").val();
				}else if($("#diskType").val() =="ITEMCATE_DISK_SAS"){
					var diskHourlyPrice = $("#h_price_sas_vm_disk_hourly").val();
					var diskMonthlyPrice = $("#h_price_sas_vm_disk_monthly_price").val();
				}else if($("#diskType").val() =="ITEMCATE_DISK_SATA"){
					var diskHourlyPrice = $("#h_price_sata_vm_disk_hourly").val();
					var diskMonthlyPrice = $("#h_price_sata_vm_disk_monthly_price").val();
				}

				var hp = result.diskGb*diskHourlyPrice;
				var mp = result.diskGb*diskMonthlyPrice;

				$("#diskDiskMonthlyPrice").text(addcomma(mp));
				$("#diskDiskHourlyPrice").text(addcomma(hp));
				showDiskView();
			}else if((result.productCategory)=="PRODCATE_NAS"){
				$("#nasGb").text(addcomma(result.nasGb));
				var hp = result.nasGb*nasHourlyPrice;
				var mp = result.nasGb*nasMonthlyPrice;

				$("#nasMonthlyPrice").text(addcomma(mp));
				$("#nasHourlyPrice").text(addcomma(hp));
				showNasView();
			}else if((result.productCategory)=="PRODCATE_PUBLICIP"){
				$("#publicipEa").text(result.publicipEa);
				var hp = result.publicipEa*ipHourlyPrice;
				var mp = result.publicipEa*ipMonthlyPrice;

				$("#publicipMonthlyPrice").text(addcomma(mp));
				$("#publicipHourlyPrice").text(addcomma(hp));
				showIpView();
			}else if((result.productCategory)=="PRODCATE_LOADBALANCER"){
				$("#loadbalancerEa").text(result.loadbalancerEa);
				var hp = result.loadbalancerEa*lbHourlyPrice;
				var mp = result.loadbalancerEa*lbMonthlyPrice;

				$("#lbMonthlyPrice").text(addcomma(mp));
				$("#lbHourlyPrice").text(addcomma(hp));
				showLbView();
			}else if((result.productCategory)=="PRODCATE_SERVICE"){
					$("#serviceEa").text(result.serviceEa);

					var serviceType = result.serviceType;

                    if(serviceType == "01"){
						var hp = result.serviceEa*serviceAccountHourlyPrice;
						var mp = result.serviceEa*serviceAccountMonthlyPrice;
                    }else if(serviceType == "02"){
    					var hp = result.serviceEa*serviceSecurityHourlyPrice;
    					var mp = result.serviceEa*serviceSecurityMonthlyPrice;
                    }else if(serviceType == "03"){
    					var hp = result.serviceEa*serviceBackupHourlyPrice;
    					var mp = result.serviceEa*serviceBackupMonthlyPrice;
                    }else if(serviceType == "04"){
    					var hp = result.serviceEa*serviceSwHourlyPrice;
    					var mp = result.serviceEa*serviceSwMonthlyPrice;
                    }else if(serviceType == "05"){
    					var hp = result.serviceEa*serviceDiskHourlyPrice;
    					var mp = result.serviceEa*serviceDiskMonthlyPrice;
                    }

					$("#serviceMonthlyPrice").text(addcomma(mp));
					$("#serviceHourlyPrice").text(addcomma(hp));
					showServiceView();
			}
// 			else if((result.productCategory)=="PRODCATE_SCM"){
// 				$("#scmEa").text(result.scmEa);
// 				var hp = result.scmEa*scmHourlyPrice;
// 				var mp = result.scmEa*scmMonthlyPrice;
// 				$("#scmMonthlyPrice").text(addcomma(mp));
// 				$("#scmHourlyPrice").text(addcomma(hp));
// 				showScmView();
// 			}else if((result.productCategory)=="PRODCATE_BACKUP"){
// 				$("#backupGb").text(result.backupGb);
// 				var hp = result.backupGb*backupHourlyPrice;
// 				var mp = result.backupGb*backupMonthlyPrice;
// 				$("#backupMonthlyPrice").text(addcomma(mp));
// 				$("#backupHourlyPrice").text(addcomma(hp));
// 				showBkView();
// 			}else if((result.productCategory)=="PRODCATE_SECURITY"){
// 				$("#securityEa").text(result.securityEa);
// 				var hp = result.securityEa*securityHourlyPrice;
// 				var mp = result.securityEa*securityMonthlyPrice;
// 				$("#securityMonthlyPrice").text(addcomma(mp));
// 				$("#securityHourlyPrice").text(addcomma(hp));
// 				showSerView();
// 			}
// 			else if((result.productCategory)=="PRODCATE_MCA"){
// 				$("#mcaEa").text(result.mcaEa);
// 				var hp = result.mcaEa*mcaHourlyPrice;
// 				var mp = result.mcaEa*mcaMonthlyPrice;
// 				$("#mcaMonthlyPrice").text(addcomma(mp));
// 				$("#mcaHourlyPrice").text(addcomma(hp));
// 				showMcaView();
// 			}
		}

		// 금액변경세팅
		function productAmountChage(){

			var cpuHourlyPrice = $("#h_price_vm_cpu_hourly").val();
			var cpuMonthlyPrice = $("#h_price_vm_cpu_monthly_price").val();
			var memHourlyPrice = $("#h_price_vm_mem_hourly").val();
			var memMonthlyPrice = $("#h_price_vm_mem_monthly_price").val();
			var diskHourlyPrice = $("#h_price_vm_disk_hourly").val();
			var diskMonthlyPrice = $("#h_price_vm_disk_monthly_price").val();
			var nasHourlyPrice = $("#h_price_nas_hourly").val();
			var nasMonthlyPrice = $("#h_price_nas_monthly_price").val();
			var lbHourlyPrice = $("#h_price_lb_hourly").val();
			var lbMonthlyPrice = $("#h_price_lb_monthly_price").val();
			var ipHourlyPrice = $("#h_price_ip_hourly").val();
			var ipMonthlyPrice = $("#h_price_ip_monthly_price").val();
			var scmHourlyPrice = $("#h_price_scm_hourly").val();
			var scmMonthlyPrice = $("#h_price_scm_monthly_price").val();
			var backupHourlyPrice = $("#h_price_backup_hourly").val();
			var backupMonthlyPrice = $("#h_price_backup_monthly_price").val();
			var serviceHourlyPrice = $("#h_price_service_hourly").val();
			var serviceMonthlyPrice = $("#h_price_service_monthly_price").val();
			var mcaHourlyPrice = $("#h_price_mca_hourly").val();
			var mcaMonthlyPrice = $("#h_price_mca_monthly_price").val();
			var securityHourlyPrice = $("#h_price_security_hourly").val();
			var securityMonthlyPrice = $("#h_price_security_monthly_price").val();


			var serviceAccountHourlyPrice = $("#h_price_service_account_hourly").val();
			var serviceAccountMonthlyPrice = $("#h_price_service_account_monthly_price").val();
			var serviceSecurityHourlyPrice = $("#h_price_service_security_hourly").val();
			var serviceSecurityMonthlyPrice = $("#h_price_service_security_monthly_price").val();
			var serviceBackupHourlyPrice = $("#h_price_service_backup_hourly").val();
			var serviceBackupMonthlyPrice = $("#h_price_service_backup_monthly_price").val();
			var serviceSwHourlyPrice = $("#h_price_service_sw_hourly").val();
			var serviceSwMonthlyPrice = $("#h_price_service_sw_monthly_price").val();
			var serviceDiskHourlyPrice = $("#h_price_service_disk_hourly").val();
			var serviceDiskMonthlyPrice = $("#h_price_service_disk_monthly_price").val();

			if($("#productCategory").val()=="PRODCATE_VM"){
				var vcpus = $("#vcpus2").val();
				var memGb = $("#memGb2").val();
				var diskGb = $("#diskGb2").val();

				 	if($("#vmDiskType").val() =="ITEMCATE_DISK_SAN"){
		            	var diskHourlyPrice = $("#h_price_san_vm_disk_hourly").val();
						var diskMonthlyPrice = $("#h_price_san_vm_disk_monthly_price").val();
					}else if($("#vmDiskType").val() =="ITEMCATE_DISK_SAS"){
						var diskHourlyPrice = $("#h_price_sas_vm_disk_hourly").val();
						var diskMonthlyPrice = $("#h_price_sas_vm_disk_monthly_price").val();
					}else if($("#vmDiskType").val() =="ITEMCATE_DISK_SATA"){
						var diskHourlyPrice = $("#h_price_sata_vm_disk_hourly").val();
						var diskMonthlyPrice = $("#h_price_sata_vm_disk_monthly_price").val();
					}

				 	if($("#imageType").val() =="VMIMGLIN100"){
						var imageHourlyPrice = $("#h_price_vmimglin_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimglin_monthly_price").val();
		            }else if($("#imageType").val() =="VMIMGWIN200"){
		            	var imageHourlyPrice = $("#h_price_vmimgwin_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwin_monthly_price").val();
		            }else if($("#imageType").val() =="VMIMGWEB110"){
		            	var imageHourlyPrice = $("#h_price_vmimgweb_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgweb_monthly_price").val();
		            }else if($("#imageType").val() =="VMIMGWAS120"){
		            	var imageHourlyPrice = $("#h_price_vmimgwas_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwas_monthly_price").val();
		            }else if($("#imageType").val() =="VMIMGDB130"){
		            	var imageHourlyPrice = $("#h_price_vmimgwdb_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwdb_monthly_price").val();
		            }else if($("#imageType").val() =="VMIMGDEV140"){
		            	var imageHourlyPrice = $("#h_price_vmimgwdev_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwdev_monthly_price").val();
		            }

				var hp1 = vcpus*cpuHourlyPrice;
				var mp1 = vcpus*cpuMonthlyPrice;
				var hp2 = memGb*memHourlyPrice;
				var mp2 = memGb*memMonthlyPrice;
				var hp3 = diskGb*diskHourlyPrice;
				var mp3 = diskGb*diskMonthlyPrice;
				var hp4 = parseInt(imageHourlyPrice);
				var mp4 = parseInt(imageMonthlyPrice);

				var vmMonthlyPrice = $("#vmMonthlyPrice").text();
				var vmHourlyPrice = $("#vmHourlyPrice").text();

				if((mp1+mp2+mp3+mp4) > 0){
					$("#vmMonthlyPrice2").removeClass("modiMinus");
					$("#vmMonthlyPrice2").addClass("modiPlus");
				}else{
					$("#vmMonthlyPrice2").removeClass("modiPlus");
					$("#vmMonthlyPrice2").addClass("modiMinus");
				}
				$("#vmMonthlyPrice2").text(addcomma(mp1+mp2+mp3+mp4));

				if((hp1+hp2+hp3+hp4) > 0){
					$("#vmHourlyPrice2").removeClass("modiMinus");
					$("#vmHourlyPrice2").addClass("modiPlus");
				}else{
					$("#vmHourlyPrice2").removeClass("modiPlus");
					$("#vmHourlyPrice2").addClass("modiMinus");
				}
				$("#vmHourlyPrice2").text(addcomma(hp1+hp2+hp3+hp4));

				var vmMonthlyDif = (mp1+mp2+mp3+mp4)-rtnnumber(vmMonthlyPrice);
				if((vmMonthlyDif) > 0){
					$("#vmMonthlyDif").removeClass("modiMinus");
					$("#vmMonthlyDif").addClass("modiPlus");
				}else{
					$("#vmMonthlyDif").removeClass("modiPlus");
					$("#vmMonthlyDif").addClass("modiMinus");
				}

				$("#vmMonthlyDif").text(addcomma(vmMonthlyDif));

				var vmHourlyDif = (hp1+hp2+hp3+hp4)-rtnnumber(vmHourlyPrice);
				if((vmHourlyDif) > 0){
					$("#vmHourlyDif").removeClass("modiMinus");
					$("#vmHourlyDif").addClass("modiPlus");
				}else{
					$("#vmHourlyDif").removeClass("modiPlus");
					$("#vmHourlyDif").addClass("modiMinus");
				}
				$("#vmHourlyDif").text(addcomma(vmHourlyDif));

			}else if($("#productCategory").val()=="PRODCATE_OS"){


			}else if($("#productCategory").val()=="PRODCATE_DISK"){
				var diskGb = $("#diskDiskGb2").val();

				if($("#diskType").val() =="ITEMCATE_DISK_SAN"){
	            	var diskHourlyPrice = $("#h_price_san_vm_disk_hourly").val();
					var diskMonthlyPrice = $("#h_price_san_vm_disk_monthly_price").val();
				}else if($("#diskType").val() =="ITEMCATE_DISK_SAS"){
					var diskHourlyPrice = $("#h_price_sas_vm_disk_hourly").val();
					var diskMonthlyPrice = $("#h_price_sas_vm_disk_monthly_price").val();
				}else if($("#diskType").val() =="ITEMCATE_DISK_SATA"){
					var diskHourlyPrice = $("#h_price_sata_vm_disk_hourly").val();
					var diskMonthlyPrice = $("#h_price_sata_vm_disk_monthly_price").val();
				}

				var hp = diskGb*diskHourlyPrice;
				var mp = diskGb*diskMonthlyPrice;

				var diskDiskMonthlyPrice = $("#diskDiskMonthlyPrice").text();
				var diskDiskHourlyPrice = $("#diskDiskHourlyPrice").text();

				$("#diskDiskMonthlyPrice2").text(addcomma(mp));
				$("#diskDiskHourlyPrice2").text(addcomma(hp));
				$("#diskDiskMonthlyDif").text(addcomma(mp-rtnnumber(diskDiskMonthlyPrice)));
				$("#diskDiskHourlyDif").text(addcomma(hp-rtnnumber(diskDiskHourlyPrice)));

			}else if($("#productCategory").val()=="PRODCATE_NAS"){
// 				$("#nasGb").text(addcomma(result.nasGb));
				var nasGb = $("#nasGb2").val();
				var hp = nasGb*nasHourlyPrice;
				var mp = nasGb*nasMonthlyPrice;

				var nasMonthlyPrice = $("#nasMonthlyPrice").text();
				var nasHourlyPrice = $("#nasHourlyPrice").text();

				$("#nasMonthlyPrice2").text(addcomma(mp));
				$("#nasHourlyPrice2").text(addcomma(hp));
				$("#nasMonthlyDif").text(addcomma(mp-rtnnumber(nasMonthlyPrice)));
				$("#nasHourlyDif").text(addcomma(hp-rtnnumber(nasHourlyPrice)));

			}else if($("#productCategory").val()=="PRODCATE_PUBLICIP"){
// 				$("#publicipEa").text(result.publicipEa);
				var publicipEa = $("#publicipEa2").val();
				var hp = publicipEa*ipHourlyPrice;
				var mp = publicipEa*ipMonthlyPrice;

				var publicipMonthlyPrice = $("#publicipMonthlyPrice").text();
				var publicipHourlyPrice = $("#publicipHourlyPrice").text();

				$("#publicipMonthlyPrice2").text(addcomma(mp));
				$("#publicipHourlyPrice2").text(addcomma(hp));
				$("#publicipMonthlyDif").text(addcomma(mp-rtnnumber(publicipMonthlyPrice)));
				$("#publicipHourlyDif").text(addcomma(hp-rtnnumber(publicipHourlyPrice)));

			}else if($("#productCategory").val()=="PRODCATE_LOADBALANCER"){
// 				$("#loadbalancerEa").text(result.loadbalancerEa);
				var loadbalancerEa = $("#loadbalancerEa2").val();
				var hp = loadbalancerEa*lbHourlyPrice;
				var mp = loadbalancerEa*lbMonthlyPrice;

				var lbMonthlyPrice = $("#lbMonthlyPrice").text();
				var lbHourlyPrice = $("#lbHourlyPrice").text();

				$("#lbMonthlyPrice2").text(addcomma(mp));
				$("#lbHourlyPrice2").text(addcomma(hp));
				$("#lbMonthlyDif").text(addcomma(mp-rtnnumber(lbMonthlyPrice)));
				$("#lbHourlyDif").text(addcomma(hp-rtnnumber(lbHourlyPrice)));

			}else if($("#productCategory").val()=="PRODCATE_SERVICE"){

				var serviceEa = $("#serviceEa2").val();
                var serviceType = $("#serviceType").val();
                if(serviceType == "01"){
					var hp = serviceEa*serviceAccountHourlyPrice;
					var mp = serviceEa*serviceAccountMonthlyPrice;
                }else if(serviceType == "02"){
    				var hp = serviceEa*serviceSecurityHourlyPrice;
    				var mp = serviceEa*serviceSecurityMonthlyPrice;
                }else if(serviceType == "03"){
    				var hp = serviceEa*serviceBackupHourlyPrice;
    				var mp = serviceEa*serviceBackupMonthlyPrice;
                }else if(serviceType == "04"){
    				var hp = serviceEa*serviceSwHourlyPrice;
    				var mp = serviceEa*serviceSwMonthlyPrice;
                }else if(serviceType == "05"){
    				var hp = serviceEa*serviceDiskHourlyPrice;
    				var mp = serviceEa*serviceDiskMonthlyPrice;
                }

                var serviceMonthlyPrice = $("#serviceMonthlyPrice").text();
				var serviceHourlyPrice = $("#serviceHourlyPrice").text();

				$("#serviceMonthlyPrice2").text(addcomma(mp));
				$("#serviceHourlyPrice2").text(addcomma(hp));
				$("#serviceMonthlyDif").text(addcomma(mp-rtnnumber(serviceMonthlyPrice)));
				$("#serviceHourlyDif").text(addcomma(hp-rtnnumber(serviceHourlyPrice)));
			}

// 			else if($("#productCategory").val()=="PRODCATE_SCM"){
// // 				$("#scmEa").text(result.scmEa);
// 				var scmEa = $("#scmEa2").val();
// 				var hp = scmEa*scmHourlyPrice;
// 				var mp = scmEa*scmMonthlyPrice;
// 				var scmMonthlyPrice = $("#scmMonthlyPrice").text();
// 				var scmHourlyPrice = $("#scmHourlyPrice").text();
// 				$("#scmMonthlyPrice2").text(addcomma(mp));
// 				$("#scmHourlyPrice2").text(addcomma(hp));
// 				$("#scmMonthlyDif").text(addcomma(mp-rtnnumber(scmMonthlyPrice)));
// 				$("#scmHourlyDif").text(addcomma(hp-rtnnumber(scmHourlyPrice)));
// 			}else if($("#productCategory").val()=="PRODCATE_BACKUP"){
// // 				$("#backupGb").text(result.backupGb);
// 				var backupGb = $("#backupGb2").val();
// 				var hp = backupGb*backupHourlyPrice;
// 				var mp = backupGb*backupMonthlyPrice;
// 				var backupMonthlyPrice = $("#backupMonthlyPrice").text();
// 				var backupHourlyPrice = $("#backupHourlyPrice").text();
// 				$("#backupMonthlyPrice2").text(addcomma(mp));
// 				$("#backupHourlyPrice2").text(addcomma(hp));
// 				$("#backupMonthlyDif").text(addcomma(mp-rtnnumber(backupMonthlyPrice)));
// 				$("#backupHourlyDif").text(addcomma(hp-rtnnumber(backupHourlyPrice)));
// 			}else if($("#productCategory").val()=="PRODCATE_SECURITY"){
// // 				$("#securityEa").text(result.securityEa);
// 				var securityEa = $("#securityEa2").val();
// 				var hp = securityEa*securityHourlyPrice;
// 				var mp = securityEa*securityMonthlyPrice;
// 				var securityMonthlyPrice = $("#securityMonthlyPrice").text();
// 				var securityHourlyPrice = $("#securityHourlyPrice").text();
// 				$("#securityMonthlyPrice2").text(addcomma(mp));
// 				$("#securityHourlyPrice2").text(addcomma(hp));
// 				$("#securityMonthlyDif").text(addcomma(mp-rtnnumber(securityMonthlyPrice)));
// 				$("#securityHourlyDif").text(addcomma(hp-rtnnumber(securityHourlyPrice)));
// 			}else if($("#productCategory").val()=="PRODCATE_MCA"){
// // 				$("#mcaEa").text(result.mcaEa);
// 				var mcaEa = $("#mcaEa2").val();
// 				var hp = mcaEa*mcaHourlyPrice;
// 				var mp = mcaEa*mcaMonthlyPrice;
// 				var mcaMonthlyPrice = $("#mcaMonthlyPrice").text();
// 				var mcaHourlyPrice = $("#mcaHourlyPrice").text();
// 				$("#mcaMonthlyPrice2").text(addcomma(mp));
// 				$("#mcaHourlyPrice2").text(addcomma(hp));
// 				$("#mcaMonthlyDif").text(addcomma(mp-rtnnumber(mcaMonthlyPrice)));
// 				$("#mcaHourlyDif").text(addcomma(hp-rtnnumber(mcaHourlyPrice)));
// 			}
		}


		function pageSet(){
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
		}
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
		}

// 		function showScmView(){
// 			$("#productList").hide();
// 			$("#osList").hide();
// 			$("#diskList").hide();
// 			$("#nasList").hide();
// 			$("#ipList").hide();
// 			$("#lbList").hide();
// 			$("#scmList").show();
// 			$("#bkList").hide();
// 			$("#serList").hide();
// 			$("#mcaList").hide();
// 			$("#serviceList").hide();
// 		}
// 		function showBkView(){
// 			$("#productList").hide();
// 			$("#osList").hide();
// 			$("#diskList").hide();
// 			$("#nasList").hide();
// 			$("#ipList").hide();
// 			$("#lbList").hide();
// 			$("#scmList").hide();
// 			$("#bkList").show();
// 			$("#serList").hide();
// 			$("#mcaList").hide();
// 			$("#serviceList").hide();
// 		}
// 		function showSerView(){
// 			$("#productList").hide();
// 			$("#osList").hide();
// 			$("#diskList").hide();
// 			$("#nasList").hide();
// 			$("#ipList").hide();
// 			$("#lbList").hide();
// 			$("#scmList").hide();
// 			$("#bkList").hide();
// 			$("#serList").show();
// 			$("#mcaList").hide();
// 			$("#serviceList").hide();
// 		}
// 		function showMcaView(){
// 			$("#productList").hide();
// 			$("#osList").hide();
// 			$("#diskList").hide();
// 			$("#nasList").hide();
// 			$("#ipList").hide();
// 			$("#lbList").hide();
// 			$("#scmList").hide();
// 			$("#bkList").hide();
// 			$("#serList").hide();
// 			$("#mcaList").show();
// 			$("#serviceList").hide();
// 		}

		//osModal BillItemModal팝업 open
		function openImageModal(){
			$("#modal-dialog-image").modal();
			imagePopList();
		}
		// image 팝업리스트
		function imagePopList(){

			var cloudId = $("#cloudId").val();
			var keyword = "";

			$.ajax({
				url : "${contextPath}/mng/bss/product/imagePopList",
				dataType : "JSON",
//	 			type : "POST",
				data : {
					"searchValue" : keyword,
					"cloudId" : cloudId

				},
				success : function(data) {
					var imagePopList = data.imagePopList;

					if(imagePopList!=""){
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
						$("#totalCnt").text(listTot);
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
							Html += "	<a class='applybtn' data-dismiss='modal' onclick='updateOs(\""+val["itemName"]+"\", \""+val["quantity"]+"\", \""+val["unit"]+"\", \""+val["itemId"]+"\")'>적용</a>";
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
		function updateOs(itemName,quantity,unit,itemId){
			$("#itemId").val(itemId);
			$("#itemName").val(itemName);
			$("#quantity").text(quantity);
			$("#unit").text(unit);


			if($("#itemId").val() =="VMIMGLIN100"){
				var imageHourlyPrice = $("#h_price_vmimglin_hourly_price").val();
				var imageMonthlyPrice = $("#h_price_vmimglin_monthly_price").val();
            }else if($("#itemId").val() =="VMIMGWIN200"){
            	var imageHourlyPrice = $("#h_price_vmimgwin_hourly_price").val();
				var imageMonthlyPrice = $("#h_price_vmimgwin_monthly_price").val();
            }else if($("#itemId").val() =="VMIMGWEB110"){
            	var imageHourlyPrice = $("#h_price_vmimgweb_hourly_price").val();
				var imageMonthlyPrice = $("#h_price_vmimgweb_monthly_price").val();
            }else if($("#itemId").val() =="VMIMGWAS120"){
            	var imageHourlyPrice = $("#h_price_vmimgwas_hourly_price").val();
				var imageMonthlyPrice = $("#h_price_vmimgwas_monthly_price").val();
            }else if($("#itemId").val() =="VMIMGDEV140"){
            	var imageHourlyPrice = $("#h_price_vmimgwdev_hourly_price").val();
				var imageMonthlyPrice = $("#h_price_vmimgwdev_monthly_price").val();
            }else if($("#itemId").val() =="VMIMGDB130"){
            	var imageHourlyPrice = $("#h_price_vmimgwdb_hourly_price").val();
				var imageMonthlyPrice = $("#h_price_vmimgwdb_monthly_price").val();
            }

			$("#osMonthlyPriceChange").text(addcomma(imageMonthlyPrice)); //변경 월 금액

			var  mp =  $("#hiddenOsMonthlyPrice").text();
			var osMonthlyDif = (mp)-rtnnumber(imageMonthlyPrice);

			if((osMonthlyDif) > 0){
				$("#osMonthlyDif").removeClass("modiMinus");
				$("#osMonthlyDif").addClass("modiPlus");
			}else{
				$("#osMonthlyDif").removeClass("modiPlus");
				$("#osMonthlyDif").addClass("modiMinus");
			}

			$("#osMonthlyDif").text(addcomma(osMonthlyDif));
		}

		function updateImage(vmImageName,vmImageId){
			$("#vmImageId").val(vmImageId);
			$("#vmImageName").val(vmImageName);
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
		function setProductUpdate() {
			if($("#productName").val()==""){
				alertBox3("자원이름을 입력하세요");
				$("#productName").focus();
				return false;
			}
			if($("#productCategory").val()=="PRODCATE_VM"){
				if($("#vcpus2").val()==""){
					alertBox3("vCPU수를 입력하세요");
					$("#vcpus2").focus();
					return false;
				}
				if($("#memGb2").val()==""){
					alertBox3("MEM를 입력하세요");
					$("#memGb2").focus();
					return false;
				}
				if($("#diskGb2").val()==""){
					alertBox3("DISK를 입력하세요");
					$("#diskGb2").focus();
					return false;
				}
			}
			if($("#productCategory").val()=="PRODCATE_OS"){
				if($("#cloudId").val()==""){
					alertBox3("클라우드를 선택하세요");
					$("#cloudId").focus();
					return false;
				}
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
			if($("#productCategory").val()=="PRODCATE_DISK"){
				if($("#diskDiskGb2").val()==""){
					alertBox3("disk용량을 입력하세요");
					$("#diskDiskGb2").focus();
					return false;
				}
			}
			if($("#productCategory").val()=="PRODCATE_NAS"){
				if($("#nasGb").val()==""){
					alertBox3("NAS용량을 입력하세요");
					$("#nasGb").focus();
					return false;
				}
			}
			if($("#productCategory").val()=="PRODCATE_PUBLICIP"){
				if($("#publicipEa").val()==""){
					alertBox3("IP 개수를 입력하세요");
					$("#publicipEa").focus();
					return false;
				}
			}
			if($("#productCategory").val()=="PRODCATE_LOADBALANCER"){
				if($("#loadbalancerEa").val()==""){
					alertBox3("서비스 로드분산 개수를 입력하세요");
					$("#loadbalancerEa").focus();
					return false;
				}
			}
			if($("#productCategory").val()=="PRODCATE_SERVICE"){
				if($("#serviceEa2").val()==""){
					alertBox3("서비스 개수를 입력하세요");
					$("#serviceEa2").focus();
					return false;
				}
			}
// 			if($("#productCategory").val()=="PRODCATE_SCM"){
// 				if($("#scmEa").val()==""){
// 					alertBox3("형상관리 개수를 입력하세요");
// 					$("#scmEa").focus();
// 					return false;
// 				}
// 			}
// 			if($("#productCategory").val()=="PRODCATE_BACKUP"){
// 				if($("#backupGb").val()==""){
// 					alertBox3("백업 용량 입력하세요");
// 					$("#backupGb").focus();
// 					return false;
// 				}
// 			}
// 			if($("#productCategory").val()=="PRODCATE_SECURITY"){
// 				if($("#securityEa").val()==""){
// 					alertBox3("보안관제 개수를 입력하세요");
// 					$("#securityEa").focus();
// 					return false;
// 				}
// 			}
// 			if($("#productCategory").val()=="PRODCATE_MCA"){
// 				if($("#mcaEa").val()==""){
// 					alertBox3("대외계 개수를 입력하세요");
// 					$("#mcaEa").focus();
// 					return false;
// 				}
// 			}

			confirmBox("저장 하시겠습니까?",setUpdate)
		}
		function setUpdate(){

			if($("#productCategory").val()=="PRODCATE_VM"){
				var jsonData = setJsonVmData();
			}
			if($("#productCategory").val()=="PRODCATE_OS"){
				var jsonData = setJsonOsData();
			}
			if($("#productCategory").val()=="PRODCATE_DISK"){
				var jsonData = setJsonDiskData();
			}
			if($("#productCategory").val()=="PRODCATE_NAS"){
				var jsonData = setJsonNasData();
			}
			if($("#productCategory").val()=="PRODCATE_PUBLICIP"){
				var jsonData = setJsonIpData();
			}
			if($("#productCategory").val()=="PRODCATE_LOADBALANCER"){
				var jsonData = setJsonLbData();
			}
			if($("#productCategory").val()=="PRODCATE_SERVICE"){
				var jsonData = setJsonServiceData();
			}
// 			if($("#productCategory").val()=="PRODCATE_SCM"){
// 				var jsonData = setJsonScmData();
// 			}
// 			if($("#productCategory").val()=="PRODCATE_BACKUP"){
// 				var jsonData = setJsonBkData();
// 			}
// 			if($("#productCategory").val()=="PRODCATE_SECURITY"){
// 				var jsonData = setJsonSerData();
// 			}
// 			if($("#productCategory").val()=="PRODCATE_MCA"){
// 				var jsonData = setJsonMcaData();
// 			}

			$.ajax({
				url : "update",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					var result = data;
					if(result==1){
						alertBox("저장 되었습니다.",moveViewPage);
					}else{
						alertBox("저장 실패 하였습니다.",moveViewPage);
					}
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		function setJsonVmData(){
			//alertBox3($("#diskGb").val().replace(/,/gi,''));
			var jsonData = {
					"productSeq" : $("#productSeq").val()
					, "productName": $("#productName").val()
					, "productCategory": $("#productCategory").val()
					, "vcpus": $("#vcpus2").val()
					, "memGb": $("#memGb2").val()
					, "diskGb": $("#diskGb2").val().replace(/,/gi,'')
					, "imageType": $("#imageType").val()
					, "diskType":$("#vmDiskType").val()


					};
			return jsonData;
		}
		function setJsonOsData(){
			var jsonData = {
					"productSeq" : $("#productSeq").val()
					, "productName": $("#productName").val()
					, "productCategory": $("#productCategory").val()
					, "itemId": $("#itemId").val()
					, "itemName": $("#itemName").val()
					, "quantity": $("#quantity").val()
					, "unit": $("#unit").val()
					, "vmImageId": $("#vmImageId").val()
					, "vmImageName": $("#vmImageName").val()
					, "cloudId":$("#cloudId").val()
					};
			return jsonData;
		}
		function setJsonDiskData(){
			var jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategory").val()
					, "diskDiskGb": $("#diskDiskGb2").val().replace(/,/gi,'')
					, "productSeq": $("#productSeq").val()
					, "diskType": $("#diskType").val()
					};
			return jsonData;
		}
		function setJsonNasData(){
			var jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategory").val()
					, "nasGb": $("#nasGb2").val().replace(/,/gi,'')
					, "productSeq": $("#productSeq").val()
					};
			return jsonData;
		}
		function setJsonIpData(){
			var jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategory").val()
					, "publicipEa": $("#publicipEa2").val()
					, "productSeq": $("#productSeq").val()
					};
			return jsonData;
		}
		function setJsonLbData(){
			var jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategory").val()
					, "loadbalancerEa": $("#loadbalancerEa2").val()
					, "productSeq": $("#productSeq").val()
					};
			return jsonData;
		}
		function setJsonServiceData(){
			var jsonData = {
					"productName": $("#productName").val()
					, "productCategory": $("#productCategory").val()
					, "serviceEa": $("#serviceEa2").val()
					, "productSeq": $("#productSeq").val()
					};
			return jsonData;
		}
// 		function setJsonScmData(){
// 			var jsonData = {
// 					"productName": $("#productName").val()
// 					, "productCategory": $("#productCategory").val()
// 					, "scmEa": $("#scmEa2").val()
// 					, "productSeq": $("#productSeq").val()
// 					};
// 			return jsonData;
// 		}
// 		function setJsonBkData(){
// 			var jsonData = {
// 					"productName": $("#productName").val()
// 					, "productCategory": $("#productCategory").val()
// 					, "backupGb": $("#backupGb2").val()
// 					, "productSeq": $("#productSeq").val()
// 					};
// 			return jsonData;
// 		}
// 		function setJsonSerData(){
// 			var jsonData = {
// 					"productName": $("#productName").val()
// 					, "productCategory": $("#productCategory").val()
// 					, "securityEa": $("#securityEa2").val()
// 					, "productSeq": $("#productSeq").val()
// 					};
// 			return jsonData;
// 		}
// 		function setJsonMcaData(){
// 			var jsonData = {
// 					"productName": $("#productName").val()
// 					, "productCategory": $("#productCategory").val()
// 					, "mcaEa": $("#mcaEa2").val()
// 					, "productSeq": $("#productSeq").val()
// 					};
// 			return jsonData;
// 		}

		// 상세 목록 페이지이동
		function moveViewPage(){
//			location.reload();
			location.href = "${contextPath}/mng/bss/product/view?productSeq="+${productSeq};
		}
		// 목록 페이지이동
		function moveListPage(productSeq){
			location.href = "${contextPath}/mng/bss/product/?productSeq="+productSeq;
		}


		function diskchange(id){

			var diskval = $(id).val();
			//alertBox3(diskval.length);
			if(diskval.length>3){
				diskcnt = Number(rtnnumber(diskval));
				$(id).val(addcomma(diskcnt))
			}else{
				diskcnt = Number(rtnnumber(diskval));
				$(id).val(addcomma(diskcnt))
			}
		}

		function calcAmount(e, id1, id2, id3){
			number_only(e);

			var amount1 = $("#"+id1).text();
			var amount2 = $("#"+id2).val();
			var modiAmount = amount2 - amount1;
			if(amount2 == ""){
				$("#"+id3).text("0");
			}else{
				$("#"+id3).text(addcomma(modiAmount));

				if(modiAmount > 0){
					$("#"+id3).removeClass("modiMinus");
					$("#"+id3).addClass("modiPlus");
				}else{
					$("#"+id3).removeClass("modiPlus");
					$("#"+id3).addClass("modiMinus");
				}
			}

			productAmountChage();
		}

		$(document).ready(function() {

			App.init();
			pageSet();
			productView("${productSeq}");


		    $("#imageType").val($("#productImageType").val()).attr("selected","selected");
		    $("#diskType").val($("#productDiskType").val()).attr("selected","selected");
		    $("#vmDiskType").val($("#productVmDiskType").val()).attr("selected","selected");

			//메뉴활성화
			$("#productAservice").addClass("active");
			$("#product").addClass("active");

		});

		function openCloudModal(){
			$("#modal-dialog-cloud").modal();
			cloudPopList();
		}

		function cloudPopList(){
			$("#cloudPopListDiv").empty();
			$("#imagePopListDiv").empty();
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
							Html += "	<a class='applybtn' data-dismiss='modal' onclick='updateCloud(\""+val["cloudName"]+"\", \""+val["cloudId"]+"\")'>적용</a>";
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

		function updateCloud(cloudName,cloudId){
			$("#vmImageId").val("");
			$("#vmImageName").val("");
			$("#cloudId").val(cloudId);
			$("#cloudName").val(cloudName);
		}
	</script>

</body>
</html>