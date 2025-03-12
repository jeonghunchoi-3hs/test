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
		<!-- begin #page-loader -->
		<div id="page-loader" class="page-loader fade in hide"><span class="spinner">Loading...</span></div>
		<!-- end #page-loader -->

		<!-- begin #page-container -->
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">

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
					<h1>진열자원 등록</h1>
					<div class="pageNav">
						<a href="#" class="home"><i></i></a><a href="#">자원관리</a><a href="#" class="on">진열자원 관리</a>
					</div>
				</div>
				<!-- end header -->

				<!-- begin page-body -->
				<div class="row mb50">
					<div class="formType01">
						<div class="tblWrap clearfix">
							<input type="hidden" id="catalogItemNo" name="catalogItemNo" value="${catalogItemNo}">
							<input type="hidden" id="programName" name="programName" value="${programName}">

							<input type="hidden" id="h_catalogSeq" value="${catalogSeq}">
							<input type="hidden" id="h_catalogCategory" value="">
							<input type="hidden" id="h_productSeq" value="">
							<input type="hidden" id="h_productCategory" value="">
							<input type="hidden" id="h_serviceType" value="">
							<!-- vm 디스크 타입, 이미지 타입 -->
							<input type="hidden" id="h_diskType" value="">
							<input type="hidden" id="h_imageType" value="">
							<!-- os 이비지 타입 -->
							<input type="hidden" id="h_itemId" value="">
							<!-- disk 디스크 타입, 디스크vmdkFile -->
							<input type="hidden" id="h_diskType" value="">
							<input type="hidden" id="h_vmdkFile" value="">


		                    <!-- 가격추가 시작 -->
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

							<input type="hidden" id="h_price_san_vm_disk_hourly" value="${getItemPrice.sanDiskHourlyPrice/getItemPrice.sanDiskQuantity}">
							<input type="hidden" id="h_price_san_vm_disk_monthly_price" value="${getItemPrice.sanDiskMonthlyPrice/getItemPrice.sanDiskQuantity}">
							<input type="hidden" id="h_price_san_vm_disk_quantity" value="${getItemPrice.sanDiskQuantity}">
							<input type="hidden" id="h_price_sata_vm_disk_hourly" value="${getItemPrice.sataDiskHourlyPrice/getItemPrice.sataDiskQuantity}">
							<input type="hidden" id="h_price_sata_vm_disk_monthly_price" value="${getItemPrice.sataDiskMonthlyPrice/getItemPrice.sataDiskQuantity}">
							<input type="hidden" id="h_price_sata_vm_disk_quantity" value="${getItemPrice.sataDiskQuantity}">
							<input type="hidden" id="h_price_sas_vm_disk_hourly" value="${getItemPrice.sasDiskHourlyPrice/getItemPrice.sasDiskQuantity}">
							<input type="hidden" id="h_price_sas_vm_disk_monthly_price" value="${getItemPrice.sasDiskMonthlyPrice/getItemPrice.sasDiskQuantity}">
							<input type="hidden" id="h_price_sas_vm_disk_quantity" value="${getItemPrice.sasDiskQuantity}">
							<!-- 가격추가 끝 -->

							<input type="hidden" id="h_price_vm_cpu_hourly" value="${getItemPrice.cpuHourlyPrice/getItemPrice.cpuQuantity}">
							<input type="hidden" id="h_price_vm_cpu_monthly_price" value="${getItemPrice.cpuMonthlyPrice/getItemPrice.cpuQuantity}">
							<input type="hidden" id="h_price_vm_mem_hourly" value="${getItemPrice.memHourlyPrice/getItemPrice.memQuantity}">
							<input type="hidden" id="h_price_vm_mem_monthly_price" value="${getItemPrice.memMonthlyPrice/getItemPrice.memQuantity}">
							<input type="hidden" id="h_price_vm_disk_hourly" value="${getItemPrice.diskHourlyPrice/getItemPrice.diskQuantity}">
							<input type="hidden" id="h_price_vm_disk_monthly_price" value="${getItemPrice.diskMonthlyPrice/getItemPrice.diskQuantity}">
							<input type="hidden" id="h_price_nas_hourly" value="${getItemPrice.nasHourlyPrice/getItemPrice.nasQuantity}">
							<input type="hidden" id="h_price_nas_monthly_price" value="${getItemPrice.nasMonthlyPrice/getItemPrice.nasQuantity}">

							<input type="hidden" id="h_price_lb_hourly" value="${getItemPrice.loadbalancerHourlyPrice/getItemPrice.loadbalancerQuantity}">
							<input type="hidden" id="h_price_lb_monthly_price" value="${getItemPrice.loadbalancerMonthlyPrice/getItemPrice.loadbalancerQuantity}">
							<input type="hidden" id="h_price_ip_hourly" value="${getItemPrice.publicipHourlyPrice/getItemPrice.publicipQuantity}">
							<input type="hidden" id="h_price_ip_monthly_price" value="${getItemPrice.publicipMonthlyPrice/getItemPrice.publicipQuantity}">
<%-- 							<input type="hidden" id="h_price_scm_hourly" value="${getItemPrice.scmHourlyPrice/getItemPrice.scmQuantity}"> --%>
<%-- 							<input type="hidden" id="h_price_scm_monthly_price" value="${getItemPrice.scmMonthlyPrice/getItemPrice.scmQuantity}"> --%>
<%-- 							<input type="hidden" id="h_price_backup_hourly" value="${getItemPrice.backupHourlyPrice/getItemPrice.backupQuantity}"> --%>
<%-- 							<input type="hidden" id="h_price_backup_monthly_price" value="${getItemPrice.backupMonthlyPrice/getItemPrice.backupQuantity}"> --%>
<%-- 							<input type="hidden" id="h_price_mca_hourly" value="${getItemPrice.mcaHourlyPrice/getItemPrice.mcaQuantity}"> --%>
<%-- 							<input type="hidden" id="h_price_mca_monthly_price" value="${getItemPrice.mcaMonthlyPrice/getItemPrice.mcaQuantity}"> --%>
<%-- 							<input type="hidden" id="h_price_security_hourly" value="${getItemPrice.securityHourlyPrice/getItemPrice.securityQuantity}"> --%>
<%-- 							<input type="hidden" id="h_price_security_monthly_price" value="${getItemPrice.securityMonthlyPrice/getItemPrice.securityQuantity}"> --%>

					        <input type="hidden" id="h_price_service_account_hourly" value="${getItemPrice.serviceAccountHourlyPrice/getItemPrice.serviceAccountQuantity}">
							<input type="hidden" id="h_price_service_account_monthly_price" value="${getItemPrice.serviceAccountMonthlyPrice/getItemPrice.serviceAccountQuantity}">
<%-- 							<input type="hidden" id="h_price_service_security_hourly" value="${getItemPrice.serviceSecurityHourlyPrice/getItemPrice.serviceSecurityQuantity}"> --%>
<%-- 							<input type="hidden" id="h_price_service_security_monthly_price" value="${getItemPrice.serviceSecurityMonthlyPrice/getItemPrice.serviceSecurityQuantity}"> --%>
<%-- 							<input type="hidden" id="h_price_service_backup_hourly" value="${getItemPrice.serviceBackupQuantity/getItemPrice.serviceBackupQuantity}"> --%>
<%-- 							<input type="hidden" id="h_price_service_backup_monthly_price" value="${getItemPrice.serviceBackupMonthlyPrice/getItemPrice.serviceBackupQuantity}"> --%>
							<input type="hidden" id="h_price_service_sw_hourly" value="${getItemPrice.serviceSwHourlyPrice/getItemPrice.serviceSwQuantity}">
							<input type="hidden" id="h_price_service_sw_monthly_price" value="${getItemPrice.serviceSwMonthlyPrice/getItemPrice.serviceSwQuantity}">
							<input type="hidden" id="h_price_service_disk_hourly" value="${getItemPrice.serviceDiskHourlyPrice/getItemPrice.serviceDiskQuantity}">
							<input type="hidden" id="h_price_service_disk_monthly_price" value="${getItemPrice.serviceDiskMonthlyPrice/getItemPrice.serviceDiskQuantity}">


							<table>
								<colgroup>
									 <col width="168px">
									 <col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><strong>카테고리</strong></th>
										<td colspan="3">
											<div class="selectBox" style="width:371px;">
												<label class="selectText" for="catalogCategory">카테고리를 선택하세요</label>
												<select class="search-sel" id="catalogCategory" onchange="setCataCate(); getDisplayOrderCount();">
													<option value="">카테고리를 선택하세요</option>
													<c:forEach items="${cateList}" var="cateList" varStatus="status" >
														<option value="${cateList.codeId}">${cateList.codeName}</option>
													</c:forEach>
												</select>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>진열자원명</strong></th>
										<td colspan="3"><input type="text" style="width:100%" name="" id="displayName" maxlength="40"></td>
									</tr>
									<tr>
										<th scope="row"><strong>상     품</strong></th>
										<td colspan="3">
											<input type="text" style="width:658px; margin-right: 5px" name="" id="productName" maxlength="40" readonly="readonly">
											<a type="button" class="bton-s bton_blue" onclick="openModal();"><span class="txt"> <i class="fa fa-search"></i> 검색</span></a>
										</td>
									</tr>
									<tr id="vmDiv" style="display: none;">
										<th scope="row"><strong>자원정보</strong></th>
										<td class="fontVdn">
											<span class="fontB">vCPU</span>
											<span class="flr"><span id="vcpus"></span><span class="fc66 m-l-10">Core</span></span>
										</td>
										<td class="colline fontVdn">
											<span class="fontB">MEMORY</span>
											<span class="flr"><span id="memGb"></span><span class="fc66 m-l-10">GB</span></span>
										</td>
										<td class="colline fontVdn">
											<span class="fontB">DISK</span>
											<span class="flr"><span id="vmDiskGb"></span><span class="fc66 m-l-10">GB</span></span>
										</td>
									</tr>
									<tr id="appDiv" style="display: none;">
										<th scope="row"><strong>자원정보</strong></th>
										<td class="fontVdn">
											<span class="fontB">vCPU</span>
											<span class="flr"><span id="templateVcpus"></span><span class="fc66 m-l-10">Core</span></span>
										</td>
										<td class="colline fontVdn">
											<span class="fontB">MEMORY</span>
											<span class="flr"><span id="templateMem"></span><span class="fc66 m-l-10">GB</span></span>
										</td>
										<td class="colline fontVdn">
											<span class="fontB">POD</span>
											<span class="flr"><span id="templatePod"></span><span class="fc66 m-l-10"></span></span>
										</td>
									</tr>
									<tr id="etcDiv" style="display: none;">
										<th scope="row"><strong>자원정보</strong></th>
										<td class="fontVdn" colspan="3"><span id="gbEa"></span><span class="fc66 m-l-10" id="typeGb" style="display: none;">EA</span><span class="fc66 m-l-10" id="typeEa" style="display: none;">EA</span><span class="fc66 m-l-10" id="typeSik" style="display: none;">식</span></td>
									</tr>


									<tr id="etcDivVmware" style="display: none;">
										<th scope="row"><strong>VMDK FILE</strong></th>
										<td class="fontVdn" colspan="3"><span id="vmdkFile"></span><span class="fc66 m-l-10" id="typeVmdkFile" style="display: none;"></span>
									</tr>



									<tr>
										<th scope="row"><strong>월 금액<span class="fontN">(원)</span></strong></th>
										<td colspan="3"><input type="text" style="width:100%" id="monthlyPrice" maxlength="40" readonly="readonly"></td>
									</tr>
								 	<tr>
										<th scope="row"><strong>시간 금액<span class="fontN">(원)</span></strong></th>
										<td colspan="3">
											<input type="hidden"  id="hourlyPrice"  readonly="readonly">
											<input type="text" style="width:100%" id="hourlyPrice" maxlength="40" readonly="readonly">
										</td>
									</tr>

									<tr>
										<th scope="row"><strong>추천자원<br/>이미지</strong></th>
										<td colspan="3">
											<a type='button' class="bton-s bton_blue" style="width:100px;"><span class="txt"> <i class="fa fa-file-text-o"></i> 파일추가</span></a>
<!-- 											<img id="blah" src="#" width="200" /> -->
											<form id="file-form" name="file-form" action="${contextPath}/mng/cmm/file/insert" method="post"  enctype="multipart/form-data">
												<input type='file' id='files' name='files' onchange="loadFile(event)"/>
												<input type='hidden' id='fileNm' name='fileNm' />
												<div id="files-list" class="mt10">
													<c:forEach items="${file}" var="filelist" varStatus="status" >
														<div class="MultiFile-label">
															<span class="MultiFile-title" title="File selected: C:\fakepath\addi_icon03.png">${filelist.fileName}</span>
															<a class="MultiFile-remove" href="javascript:;" onclick="delFile('${filelist.fileId}')" ></a>
														</div>
													</c:forEach>
												</div>
											</form>
										</td>
									</tr>

									<tr>
										<th scope="row"><strong>추천자원<br/>목록설명</strong></th>
										<td colspan="3"><textarea  style="width:100%; height: 100px" maxlength="80" id="descriptionList"></textarea></td>
									</tr>
									<tr>
										<th scope="row"><strong>추천자원<br/>상세소제목</strong></th>
										<td colspan="3"><textarea  style="width:100%; height: 100px" maxlength="150" id="descriptionTop"></textarea></td>
									</tr>
									<tr>
										<th scope="row"><strong>추천자원<br/>상세설명</strong></th>
										<td colspan="3"><textarea  style="width:100%; height: 100px" maxlength="300" id="description"></textarea></td>
									</tr>
									<tr>
										<th scope="row"><strong>정렬순서</strong></th>
										<td colspan="3">
											<div class="selectBox" style="width:371px;">
												<label class="selectText" for="displayOrder">정렬순서를 설정하세요</label>
												<select class="search-sel" id="displayOrder">
													<option value="">정렬순서를 설정하세요</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
													<option value="10">10</option>
												</select>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>표시여부</strong></th>
										<td colspan="3">
											<label class="checkbox-inline flex align-center gap10">
				                            	<input type="checkbox" data-original-title="" title="" value="Y" name="displayFlag" id="displayFlag">표시
				                            </label>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>추천여부</strong></th>
										<td colspan="3">
											<label class="checkbox-inline flex align-center gap10">
				                            	<input type="checkbox" data-original-title="" title="" value="Y" name="recommandFlag" id="recommandFlag">추천
				                            </label>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>기본여부</strong></th>
										<td colspan="3">
											<label class="checkbox-inline flex align-center gap10">
				                            	<input type="checkbox" data-original-title="" title="" value="Y" name="basicProductFlag" id="basicProductFlag">기본자원
				                            </label>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>

					<!-- begin button-->
				    <div class="row tac m-t-60">
			 			<a type="button" class="rbton bton_blue" id="jquerybuttonok" name="jquerybuttonok" onclick="setJsonData()">등록</a>
			 			<a type="button" class="rbton bton_dgrey" onclick="moveViewPage();">취소</a>
	                 </div>
					<!-- end button -->
				</div>

				<!-- begin #footer -->
				<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
			<!-- end #content -->

			<!-- Modal 모음 -->

			<!-- 자원 검색 Modal -->
			<div class="modal fade" id="modal-dialog">
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">자원 선택</h4>
	                       </div>
	                       <div class="modal-body">
								<div class="listArea" id="popListDiv">
									<div class="listBg">
										<span class="name2">쓰리에이치에스</span>
										<a class="applybtn" >적용</a>
									</div>
								</div>
	                      		<div class="totalcnt" >총 <span id="totalCnt">0</span> 건</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="whiteline" data-dismiss="modal" onclick="initPopup();">닫기</a>
	                       	</div>
		               	</div>
					</div>
	            </div>
		</div>
		<!-- end page container -->

		<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">

			//자원별 정렬순번 세팅
			function getDisplayOrderCount(){

				$.ajax({
					url : "${contextPath}/mng/bss/catalog/getDisplayOrderCount",
					dataType : "JSON",
					type : "POST",
					data : {
						"catalogSeq" : $("#h_catalogSeq").val()
						,"catalogCategory" :$("#catalogCategory option:selected").val()
					},
					success : function(data) {

						var orderCnt = data;
						var Html = "";
						var idx = 0;
						$("#displayOrder").empty();


						for(var i=1; i<=orderCnt+1; i++){
							if(idx==0){
								Html += "<option value=''>정렬순서를 설정하세요</option>";
								Html += "<option value='"+0+"'>"+0+"</option>";
							}
							Html += "<option value='"+i+"'>"+i+"</option>";
							idx++;
						}
						$("#displayOrder").html(Html);


					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				});
			}



			// 자원 검색 Modal 활성화 Fn
			function openModal(){

				var catalogCategory = $("#h_catalogCategory").val();

				if(catalogCategory==""){
					alertBox3("카테고리를 선택하세요.");
					return false;
				}

				$("#modal-dialog").modal();
				productPopList();
			}

			// 가상서버 팝업리스트
			function productPopList(){
				var catalogSeq = $("#h_catalogSeq").val();
				var catalogCategory = $("#h_catalogCategory").val();


				$.ajax({
					url : "${contextPath}/mng/bss/catalog/productPopList",
					dataType : "JSON",
		// 			type : "POST",
					data : {
						"catalogSeq" : catalogSeq
						, "catalogCategory" : catalogCategory
						, "searchValue" : ""
					},
					success : function(data) {
						var productPopList = data.productPopList;

						if(productPopList!=""){

							$("#popListDiv > div").remove();
							var total = "";
							var Html="";
							$.each(productPopList,function(key,val){
								Html += "<div class='listBg'>";
								Html += "<span class='name2'>"+val["productName"]+"</span>";

								if(val["productCategory"]=="PRODCATE_VM"){
									Html += "<a class='applybtn' data-dismiss='modal' onclick='setProductVm(\""+val["productName"]+"\", \""+val["vcpus"]+"\", \""+val["memGb"]+"\", \""+val["diskGb"]+"\", \""+val["productSeq"]+"\", \"" +val["productCategory"]+"\", \"" +val["diskType"]+"\", \"" +val["imageType"]+"\")'>적용<a>";
								}else if(val["productCategory"]=="PRODCATE_DISK"){
									Html += "<a class='applybtn' data-dismiss='modal' onclick='setProductDisk(\""+val["productName"]+"\", \""+val["productSeq"]+"\", \"" +val["diskGb"]+"\", \"" +val["productCategory"]+"\", \"" +val["diskType"]+"\", \"" +val["vmdkFile"]+"\")'>적용<a>";
								}else if(val["productCategory"]=="PRODCATE_NAS"){
									Html += "<a class='applybtn' data-dismiss='modal' onclick='setProduct(\""+val["productName"]+"\", \""+val["productSeq"]+"\", \"" +val["nasGb"]+"\", \"" +val["productCategory"]+"\")'>적용<a>";
								}else if(val["productCategory"]=="PRODCATE_LOADBALANCER"){
									Html += "<a class='applybtn' data-dismiss='modal' onclick='setProduct(\""+val["productName"]+"\", \""+val["productSeq"]+"\", \"" +val["loadbalancerEa"]+"\", \"" +val["productCategory"]+"\")'>적용<a>";
								}else if(val["productCategory"]=="PRODCATE_PUBLICIP"){
									Html += "<a class='applybtn' data-dismiss='modal' onclick='setProduct(\""+val["productName"]+"\", \""+val["productSeq"]+"\", \"" +val["publicipEa"]+"\", \"" +val["productCategory"]+"\")'>적용<a>";
								}else if(val["productCategory"]=="PRODCATE_OS"){
									Html += "<a class='applybtn' data-dismiss='modal' onclick='setImage(\""+val["productName"]+"\", \""+val["productSeq"]+"\", \"" +val["productCategory"]+"\", \"" +val["itemId"]+"\")'>적용<a>";
								}else if(val["productCategory"]=="PRODCATE_SERVICE"){
									Html += "<a class='applybtn' data-dismiss='modal' onclick='setService(\""+val["productName"]+"\", \""+val["productSeq"]+"\", \"" +val["serviceEa"]+"\", \"" +val["productCategory"]+"\", \"" +val["serviceType"]+"\")'>적용<a>";
								}else if(val["productCategory"]=="PRODCATE_APP"){
									Html += "<a class='applybtn' data-dismiss='modal' onclick='setProductApp(\""+val["productName"]+"\", \""+val["productSeq"]+"\", \"" +val["templateVcpus"]+"\", \"" +val["templateMem"]+"\", \"" +val["templatePod"]+"\", \"" +val["productCategory"]+"\")'>적용<a>";
								}else if(val["productCategory"]=="PRODCATE_ENV"){
									Html += "<a class='applybtn' data-dismiss='modal' onclick='setProduct(\""+val["productName"]+"\", \""+val["productSeq"]+"\", \"" +val["envEa"]+"\", \"" +val["productCategory"]+"\")'>적용<a>";
								}

								Html += "</div>";
								total++;
							});
							$("#popListDiv").append(Html);
							$("#totalCnt").text(total);
						}else{
							$("#popListDiv > div").remove();

							var Html="";

							Html += "<div>검색목록이 없습니다.</div>";

							$("#popListDiv").append(Html);
						}
					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				});
			}

			// 가상서버 팝업 목록 선택시 데이터 세팅
			function setProductVm(productName, vcpus, memGb, diskGb, productSeq, productCategory,diskType,imageType ){
				$("#productName").val(productName);
				$("#vcpus").text(vcpus);
				$("#memGb").text(memGb);
				$("#vmDiskGb").text(diskGb);
				$("#h_productSeq").val(productSeq);
				$("#h_productCategory").val(productCategory);

				$("#h_diskType").val(diskType);
				$("#h_imageType").val(imageType);

				setProductData(productName, vcpus, memGb,diskGb, "", productSeq, productCategory);
			}

			function setProductApp(productName, productSeq, vcpus, mem, pod,productCategory){
				$("#productName").val(productName);
				$("#templateVcpus").text(vcpus);
				$("#templateMem").text(mem);
				$("#templatePod").text(pod);
				$("#h_productSeq").val(productSeq);
				$("#h_productCategory").val(productCategory);
				//setProductData(productName, vcpus, memGb,diskGb, "", productSeq, productCategory);
			}

			// 목록 선택시 데이터 세팅
			function setProduct(productName, productSeq, gbEa, productCategory){

				$("#productName").val(productName);
				$("#h_productSeq").val(productSeq);
				$("#h_productCategory").val(productCategory);
				setProductData(productName, "", "", "", gbEa, productSeq, productCategory);
			}

			// 목록 선택시 데이터 세팅
			function setProductDisk(productName, productSeq, gbEa, productCategory,diskType, vmdkFile){

				$("#productName").val(productName);
				$("#h_productSeq").val(productSeq);
				$("#h_productCategory").val(productCategory);
				$("#h_diskType").val(diskType);
				$("#h_vmdkFile").val(vmdkFile);


				setProductData(productName, "", "", "", gbEa, productSeq, productCategory);
			}


			function setService(productName, productSeq, gbEa, productCategory, serviceType){

				$("#productName").val(productName);
				$("#h_productSeq").val(productSeq);
				$("#h_productCategory").val(productCategory);
				$("#h_serviceType").val(serviceType);

				setProductData(productName, "", "", serviceType, gbEa, productSeq, productCategory);
			}

			function setImage(productName, productSeq, productCategory, itemId){
				$("#productName").val(productName);
				$("#h_productSeq").val(productSeq);
				$("#h_productCategory").val(productCategory);

				$("#h_itemId").val(itemId);

				setProductData(productName, "", "", "", "", productSeq, productCategory);
			}

			function setProductData(productName, vcpus, memGb,diskGb, gbEa, productSeq, productCategory){

				var cpuHourlyPrice = $("#h_price_vm_cpu_hourly").val();
				var cpuMonthlyPrice = $("#h_price_vm_cpu_monthly_price").val();
				var memHourlyPrice = $("#h_price_vm_mem_hourly").val();
				var memMonthlyPrice = $("#h_price_vm_mem_monthly_price").val();


				var nasHourlyPrice = $("#h_price_nas_hourly").val();
				var nasMonthlyPrice = $("#h_price_nas_monthly_price").val();
				var lbHourlyPrice = $("#h_price_lb_hourly").val();
				var lbMonthlyPrice = $("#h_price_lb_monthly_price").val();
				var ipHourlyPrice = $("#h_price_ip_hourly").val();
				var ipMonthlyPrice = $("#h_price_ip_monthly_price").val();
// 				var scmHourlyPrice = $("#h_price_scm_hourly").val();
// 				var scmMonthlyPrice = $("#h_price_scm_monthly_price").val();
// 				var backupHourlyPrice = $("#h_price_backup_hourly").val();
// 				var backupMonthlyPrice = $("#h_price_backup_monthly_price").val();
// 				var mcaHourlyPrice = $("#h_price_mca_hourly").val();
// 				var mcaMonthlyPrice = $("#h_price_mca_monthly_price").val();
// 				var securityHourlyPrice = $("#h_price_security_hourly").val();
// 				var securityMonthlyPrice = $("#h_price_security_monthly_price").val();

				var serviceAccountHourlyPrice = $("#h_price_service_account_hourly").val();
				var serviceAccountMonthlyPrice = $("#h_price_service_account_monthly_price").val();
// 				var serviceSecurityHourlyPrice = $("#h_price_service_security_hourly").val();
// 				var serviceSecurityMonthlyPrice = $("#h_price_service_security_monthly_price").val();
// 				var serviceBackupHourlyPrice = $("#h_price_service_backup_hourly").val();
// 				var serviceBackupMonthlyPrice = $("#h_price_service_backup_monthly_price").val();
				var serviceSwHourlyPrice = $("#h_price_service_sw_hourly").val();
				var serviceSwMonthlyPrice = $("#h_price_service_sw_monthly_price").val();
				var serviceDiskHourlyPrice = $("#h_price_service_disk_hourly").val();
				var serviceDiskMonthlyPrice = $("#h_price_service_disk_monthly_price").val();


				$("#typeGb").hide();
				$("#typeEa").hide();
				$("#typeSik").hide();

				if(productCategory=="PRODCATE_VM"){
					var hp1 = vcpus*cpuHourlyPrice;
					var mp1 = vcpus*cpuMonthlyPrice;
					var hp2 = memGb*memHourlyPrice;
					var mp2 = memGb*memMonthlyPrice;


					//alert($("#h_diskType").val());


					if($("#h_diskType").val() =="ITEMCATE_DISK_SAN"){
		            	var diskHourlyPrice = $("#h_price_san_vm_disk_hourly").val();
						var diskMonthlyPrice = $("#h_price_san_vm_disk_monthly_price").val();
					}else if($("#h_diskType").val() =="ITEMCATE_DISK_SAS"){
						var diskHourlyPrice = $("#h_price_sas_vm_disk_hourly").val();
						var diskMonthlyPrice = $("#h_price_sas_vm_disk_monthly_price").val();
					}else if($("#h_diskType").val() =="ITEMCATE_DISK_SATA"){
						var diskHourlyPrice = $("#h_price_sata_vm_disk_hourly").val();
						var diskMonthlyPrice = $("#h_price_sata_vm_disk_monthly_price").val();
					}

					var hp3 = diskGb*diskHourlyPrice;
					var mp3 = diskGb*diskMonthlyPrice;


					if($("#h_imageType").val() =="VMIMGLIN100"){
						var imageHourlyPrice = $("#h_price_vmimglin_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimglin_monthly_price").val();
		            }else if($("#h_imageType").val() =="VMIMGWIN200"){
		            	var imageHourlyPrice = $("#h_price_vmimgwin_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwin_monthly_price").val();
		            }else if($("#h_imageType").val() =="VMIMGWEB110"){
		            	var imageHourlyPrice = $("#h_price_vmimgweb_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgweb_monthly_price").val();
		            }else if($("#h_imageType").val() =="VMIMGWAS120"){
		            	var imageHourlyPrice = $("#h_price_vmimgwas_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwas_monthly_price").val();
		            }else if($("#h_imageType").val() =="VMIMGDB130"){
		            	var imageHourlyPrice = $("#h_price_vmimgwdb_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwdb_monthly_price").val();
		            }else if($("#h_imageType").val() =="VMIMGDEV140"){
		            	var imageHourlyPrice = $("#h_price_vmimgwdev_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwdev_monthly_price").val();
		            }

					var hp4 = parseInt(imageHourlyPrice);
					var mp4 = parseInt(imageMonthlyPrice);

					$("#monthlyPrice").val(addcomma(mp1+mp2+mp3+mp4));
					$("#hourlyPrice").val(addcomma(hp1+hp2+hp3));
				}else if(productCategory=="PRODCATE_OS"){


					if($("#h_itemId").val() =="VMIMGLIN100"){
						var imageHourlyPrice = $("#h_price_vmimglin_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimglin_monthly_price").val();
		            }else if($("#h_itemId").val() =="VMIMGWIN200"){
		            	var imageHourlyPrice = $("#h_price_vmimgwin_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwin_monthly_price").val();
		            }else if($("#h_itemId").val() =="VMIMGWEB110"){
		            	var imageHourlyPrice = $("#h_price_vmimgweb_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgweb_monthly_price").val();
		            }else if($("#h_itemId").val() =="VMIMGWAS120"){
		            	var imageHourlyPrice = $("#h_price_vmimgwas_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwas_monthly_price").val();
		            }else if($("#h_itemId").val() =="VMIMGDB130"){
		            	var imageHourlyPrice = $("#h_price_vmimgwdb_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwdb_monthly_price").val();
		            }else if($("#h_itemId").val() =="VMIMGDEV140"){
		            	var imageHourlyPrice = $("#h_price_vmimgwdev_hourly_price").val();
						var imageMonthlyPrice = $("#h_price_vmimgwdev_monthly_price").val();
		            }

					var hp = imageHourlyPrice;
					var mp = imageMonthlyPrice;
					$("#gbEa").text(gbEa);
					$("#typeGb").show();
					$("#monthlyPrice").val(addcomma(mp));
					$("#hourlyPrice").val(addcomma(hp));

				}else if(productCategory=="PRODCATE_DISK"){

					if($("#h_diskType").val() =="ITEMCATE_DISK_SAN"){
		            	var diskHourlyPrice = $("#h_price_san_vm_disk_hourly").val();
						var diskMonthlyPrice = $("#h_price_san_vm_disk_monthly_price").val();
					}else if($("#h_diskType").val() =="ITEMCATE_DISK_SAS"){
						var diskHourlyPrice = $("#h_price_sas_vm_disk_hourly").val();
						var diskMonthlyPrice = $("#h_price_sas_vm_disk_monthly_price").val();
					}else if($("#h_diskType").val() =="ITEMCATE_DISK_SATA"){
						var diskHourlyPrice = $("#h_price_sata_vm_disk_hourly").val();
						var diskMonthlyPrice = $("#h_price_sata_vm_disk_monthly_price").val();
					}

					var hp = gbEa*diskHourlyPrice;
					var mp = gbEa*diskMonthlyPrice;
					$("#gbEa").text(gbEa);
					$("#typeGb").show();

                   if("${cloudType}" ==  "vmware"){
					$("#vmdkFile").text($("#h_vmdkFile").val());
					$("#typeVmdkFile").show();
                   }

					$("#monthlyPrice").val(addcomma(mp));
					$("#hourlyPrice").val(addcomma(hp));
				}else if(productCategory=="PRODCATE_NAS"){
					var hp = gbEa*nasHourlyPrice;
					var mp = gbEa*nasMonthlyPrice;
					$("#gbEa").text(gbEa);
					$("#typeGb").show();
					$("#monthlyPrice").val(addcomma(mp));
					$("#hourlyPrice").val(addcomma(hp));
				}else if(productCategory=="PRODCATE_PUBLICIP"){
					var hp = gbEa*ipHourlyPrice;
					var mp = gbEa*ipMonthlyPrice;
					$("#gbEa").text(gbEa);
					$("#typeEa").show();
					$("#monthlyPrice").val(addcomma(mp));
					$("#hourlyPrice").val(addcomma(hp));
				}else if(productCategory=="PRODCATE_LOADBALANCER"){
					var hp = gbEa*lbHourlyPrice;
					var mp = gbEa*lbMonthlyPrice;
					$("#gbEa").text(gbEa);
					$("#typeEa").show();
					$("#monthlyPrice").val(addcomma(mp));
					$("#hourlyPrice").val(addcomma(hp));
				}else if(productCategory=="PRODCATE_ENV"){
					var hp = gbEa*lbHourlyPrice;
					var mp = gbEa*lbMonthlyPrice;
					$("#gbEa").text(gbEa);
					$("#typeEa").show();
					$("#monthlyPrice").val(addcomma(mp));
					$("#hourlyPrice").val(addcomma(hp));
				}else if(productCategory=="PRODCATE_SERVICE"){

		           if($("#h_serviceType").val()=='01'){

		        		var hp = gbEa*serviceAccountHourlyPrice;
		    			var mp = gbEa*serviceAccountMonthlyPrice;
		    			$("#gbEa").text(gbEa);
		    			$("#typeGb").show();
		    			$("#monthlyPrice").val(addcomma(mp));
		    			$("#hourlyPrice").val(addcomma(hp));

		           }else if($("#h_serviceType").val()=='02'){
		        		var hp = gbEa*serviceSecurityHourlyPrice;
		    			var mp = gbEa*serviceSecurityMonthlyPrice;
		    			$("#gbEa").text(gbEa);
		    			$("#typeGb").show();
		    			$("#monthlyPrice").val(addcomma(mp));
		    			$("#hourlyPrice").val(addcomma(hp));
		           }else if($("#h_serviceType").val()=='03'){
		        		var hp = gbEa*serviceBackupHourlyPrice;
		    			var mp = gbEa*serviceBackupMonthlyPrice;
		    			$("#gbEa").text(gbEa);
		    			$("#typeGb").show();
		    			$("#monthlyPrice").val(addcomma(mp));
		    			$("#hourlyPrice").val(addcomma(hp));
		           }else if($("#h_serviceType").val()=='04'){
		        		var hp = gbEa*serviceSwHourlyPrice;
		    			var mp = gbEa*serviceSwMonthlyPrice;
		    			$("#gbEa").text(gbEa);
		    			$("#typeGb").show();
		    			$("#monthlyPrice").val(addcomma(mp));
		    			$("#hourlyPrice").val(addcomma(hp));
		           }else if($("#h_serviceType").val()=='05'){
		        		var hp = gbEa*serviceDiskHourlyPrice;
		    			var mp = gbEa*serviceDiskMonthlyPrice;
		    			$("#gbEa").text(gbEa);
		    			$("#typeGb").show();
		    			$("#monthlyPrice").val(addcomma(mp));
		    			$("#hourlyPrice").val(addcomma(hp));
		           }
				}
			}

			// 유효성 체크 및 jsonData 세팅
			function setJsonData(){
				if($("#displayName").val()==""){
					alertBox3("표시명을 입력하세요");
					$("#displayName").focus();
					return false;
				}
				if($("#productName").val()==""){
					alertBox3("자원명을 입력하세요");
					return false;
				}
				if($("#displayOrder").val()==""){
					alertBox3("정렬순서를 설정하세요");
					return false;
				}
				if($("#description")==""){
					alertBox3("추천자원 상세설명을 입력하세요");
					$("#description").focus();
					return false;
				}
				if($("#descriptionList")==""){
					alertBox3("추천자원 목록설명을 입력하세요");
					$("#descriptionList").focus();
					return false;
				}
				if($("#descriptionTop")==""){
					alertBox3("추천자원 상세소제목을 입력하세요");
					$("#descriptionTop").focus();
					return false;
				}

				var displayFlag = "";
				if($("input:checkbox[name='displayFlag']").is(":checked")==true){
					displayFlag = "Y";
				}else{
					displayFlag = "N";
				}

				var recommandFlag = "";
				if($("input:checkbox[name='recommandFlag']").is(":checked")==true){
					recommandFlag = "Y";
				}else{
					recommandFlag = "N";
				}

				var basicProductFlag = "";
				if($("input:checkbox[name='basicProductFlag']").is(":checked")==true){
					basicProductFlag = "Y";
				}else{
					basicProductFlag = "N";
				}

				var jsonData = {
						"catalogSeq" : $("#h_catalogSeq").val()
						, "productSeq" : $("#h_productSeq").val()
						, "catalogCategory" : $("#catalogCategory option:selected").val()
						, "displayName": $("#displayName").val()
						, "productName": $("#productName").val()
						, "description": $("#description").val()
						, "descriptionTop": $("#descriptionTop").val()
						, "descriptionList": $("#descriptionList").val()
						, "displayOrder": $("#displayOrder option:selected").val()
						, "displayFlag": displayFlag
						, "recommandFlag": recommandFlag
						, "basicProductFlag": basicProductFlag
						, "vmdkFile" : $("#vmdkFile").val()
						};

				confirmBox2("등록 하시겠습니까?", productInsert, jsonData);
			}

			// 자원 등록 action
			function productInsert(jsonData){
				var cataCate = $("#catalogCategory option:selected").val();
				var url = "";
				if(cataCate == "CATACATE_VM"){
					url = "${contextPath}/mng/bss/catalog/productInsert";
				}else if(cataCate == "CATACATE_DISK"){
					url = "${contextPath}/mng/bss/catalog/diskInsert";
				}else if(cataCate == "CATACATE_OS"){
					url = "${contextPath}/mng/bss/catalog/osInsert";
				}else if(cataCate == "CATACATE_NAS"){
					url = "${contextPath}/mng/bss/catalog/nasInsert";
				}else if(cataCate == "CATACATE_LOADBALANCER"){
					url = "${contextPath}/mng/bss/catalog/lbInsert";
				}else if(cataCate == "CATACATE_PUBLICIP"){
					url = "${contextPath}/mng/bss/catalog/ipInsert";
				}else if(cataCate == "CATACATE_SERVICE"){
					url = "${contextPath}/mng/bss/catalog/serviceInsert";
				}else if(cataCate == "CATACATE_APP"){
					url = "${contextPath}/mng/bss/catalog/appInsert";
				}else if(cataCate == "CATACATE_ENV"){
					url = "${contextPath}/mng/bss/catalog/envInsert";
				}

				$.ajax({
					url : url,
					dataType : "JSON",
					type : "POST",
					data : jsonData,
					success : function(data) {
						var result = data;
						if(result>=1){
							//alertBox("등록되었습니다.", moveListPage);
							alertBox("등록되었습니다.", actFileUpload);
						}else{
							alertBox("fail!!", moveListPage);
						}

					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				});
			}

			// 목록 페이지이동
			function moveListPage() {
				location.href = "${contextPath}/mng/bss/catalog/";
			}

			// 상세 페이지이동
			function moveViewPage(){
				//location.href = "${contextPath}/mng/bss/catalog/viewPage?catalogSeq="+$("#h_catalogSeq").val();
				window.history.back();
			}

			// catalogCategory 선택
			function setCataCate(){
				$("#vcpus").text("");
				$("#memGb").text("");
				$("#vmDiskGb").text("");
				$("#appVcpus").text("");
				$("#appPod").text("");
				$("#appMem").text("");
				$("#gbEa").text("");
				$("#monthlyPrice").val("");
				$("#hourlyPrice").val("");

				$("#typeGb").hide();
				$("#typeEa").hide();
				$("#typeSik").hide();

				var catalogCategory = $("#catalogCategory").val();
				$("#h_catalogCategory").val(catalogCategory);
				if(catalogCategory == "CATACATE_VM"){
					$("#vmDiv").show();
					$("#appDiv").hide();
					$("#etcDiv").hide();

				}else if(catalogCategory == "CATACATE_OS"){
					$("#vmDiv").hide();
					$("#appDiv").hide();
					$("#etcDiv").hide();

				}else if(catalogCategory == "CATACATE_DISK"){
					$("#vmDiv").hide();
					$("#appDiv").hide();
					$("#etcDiv").show();

				}else if(catalogCategory == "CATACATE_SERVICE"){
					$("#vmDiv").hide();
					$("#appDiv").hide();
					$("#etcDiv").show();
				}else if(catalogCategory == "CATACATE_APP"){
					$("#appDiv").show();
					$("#vmDiv").hide();
					$("#etcDiv").hide();
				}
			}

			// 팝업 초기화
			function initPopup(){
				$("#popListDiv > div").remove();
			}

			// 자원등록 저장 후 파일 저장
			function actFileUpload(){
				var programSeq = $("#h_catalogSeq").val() + "_" + $("#h_productSeq").val();

				$('#file-form').ajaxForm({
					cache:false
					, data : {
						programName: $("#programName").val()
						, programSeq : programSeq
					}
					, dataType:"json"
			       	//보내기전 validation check가 필요할경우
			       	, beforeSubmit: function (data, frm, opt) {
			       		var chk = true;

			       		$.each(data, function(i, val){
			       			if(val.value.size > 209715200){
			       				alertBox3("첨부파일 용량은 200MB를 초과할수 없습니다.");
			       				chk = false;
			       			}
			       		});
			       },
			       //submit이후의 처리
			       success: function(data, statusText){
			    	   moveViewPage();
			       },
			       //ajax error
			       error: function(e){
			           alert("파일 업로드 에러발생!!");
			       }
				});
				$('#file-form').submit();
			}

			// 이미지 미리보기
			function loadFile(event) {
				var output = document.getElementById('blah');
			    output.src = URL.createObjectURL(event.target.files[0]);
			    output.onload = function() {
					URL.revokeObjectURL(output.src) // free memory
			    }
			}


			$(document).ready(function() {
				App.init();

				$('#files').MultiFile({

					list: "#files-list"
					, max : 1
					, accept : 'gif|jpg|png'
					, maxFile : 204800
					, maxSize :  204800
					, STRING : {
						//remove : "<input type='button' value='삭제' class='btn btn-danger' style='font:8px;padding-bottom:2px;'>"
						duplicate : "$file 은 이미 선택된 파일입니다."
						, denied : "$ext 는(은) 업로드 할수 없는 파일 확장자 입니다."
						, toomuch : "업로드 할 수 있는 최대크기를 초과하였습니다.($size)"
						, toomany : "업로드 할 수 있는 최대 갯수는 $max개 입니다."
						, toobig : "$file 은 크기가 매우 큽니다.(max $size)"
					}
					, afterFileRemove: function(element, value, master_element) {
						$("#filesCnt").val( $("#files-list")[0].childElementCount );
					}
					, afterFileAppend: function(element, value, master_element) {
						$("#filesCnt").val( $("#files-list")[0].childElementCount );
					}

				});

				//메뉴활성화
				$("#productAservice").addClass("active");
				$("#catalog").addClass("active");
			});

		</script>
	</body>
</html>