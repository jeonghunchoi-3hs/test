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
				<h1>이용요금 상세</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">요금조회</a><a href="#" class="on">이용요금</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">

				<input type="hidden" id="h_customerId" value="${customerId}">
				<input type="hidden" id="h_billYyyymm" value="${billYyyymm}">
				<input type="hidden" id="h_projectId" value="${projectId}">
				<input type="hidden" id="h_startDt" value="${startDt}">
				<input type="hidden" id="h_endDt" value="${endDt}">

				<div class="client_DetailArea"><div id="billBoxArea"></div></div>
				<div id="billDiv"></div>
				 <!-- <div class="billcomBg"  id="billDiv"></div> -->
				<div class="row tac m-t-40">
					<a type='button' class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>
				</div>

			</div>
             <!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->


<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

	//청구서 상세
	function getDetail(){

		$.ajax({
			url : "${contextPath}/mng/charge/bill/billDetailList",
	//			dataType : "JSON",
	//			type : "POST",
			data : {
				"customerId" : $("#h_customerId").val()
				,"billYyyymm" : $("#h_billYyyymm").val()
				,"projectId" : $("#h_projectId").val()
				,"startDt" : $("#h_startDt").val()
				,"endDt" : $("#h_endDt").val()

			},
			success : function(data) {
				var projectList = data.projectList;
				var detailList = data.detailList;
				var vmResourceList = data.vmResourceList;

				var diskResourceList = data.diskResourceList;
				var nasResourceList = data.nasResourceList;
				var ipResourceList = data.ipResourceList;
				var loadbalancerResourceList = data.loadbalancerResourceList;

// 				var backupResourceList = data.backupResourceList;
// 				var mcaResourceList = data.mcaResourceList;
// 				var scmResourceList = data.scmResourceList;
// 				var securityResourceList = data.securityResourceList;


				// 서비스 추가
				var serviceResourceList = data.serviceResourceList;


				var dcAdList = data.dcAdList;

				delete projectList.length;
				delete detailList.length;
				delete vmResourceList.length;
				delete diskResourceList.length;
				delete nasResourceList.length;
				delete ipResourceList.length;
				delete loadbalancerResourceList.length;
// 				delete backupResourceList.length;
// 				delete mcaResourceList.length;
// 				delete scmResourceList.length;
// 				delete securityResourceList.length;

				delete serviceResourceList.length;


				delete dcAdList.length;

				$("#billDiv").empty();
				var projectHtml = "";


				var startDt = $("#h_startDt").val();
				var endDt = $("#h_endDt").val();

				$.each(projectList,function(key,val){
					var projectId1 = val["projectId"];
					var Html = "";

					var _project = val["projectAlias"];
					var _projectName = val["projectName"];
					var _billYyyymm = val["billYyyymm"];

					var billYm = _billYyyymm;
					var billY = billYm.substring(0,4);
					var billM = billYm.substring(4,6);

					startDtY = startDt.substring(0,4);
					startDtM = startDt.substring(4,6);

					endDtY = endDt.substring(0,4);
					endDtM = endDt.substring(4,6);

					if(strTrim(_project) == ""){
						projectHtml += "<div class='billcompBg'>";
						projectHtml += "		<h2 class='customer_Id dpin width-120'>"+val["projectName"]+"</h2>";
						projectHtml += "<p class='company_Name2 dpin w80 ml10'>"+val["projectName"]+"</p>";
//						projectHtml += "<p class='company_Info'>";
						projectHtml += "<h3  class='mt20'>조회기간 : "+startDtY+"-"+startDtM+" ~ "+endDtY+"-"+endDtM+"</h3>";
//						projectHtml += "	<span class='company_labelf'>조회기간 :</span><span class='company_cont' id=''>"+startDt+"</span>~<span class='company_cont' id=''>"+endDt+"</span>";
//						projectHtml += "	<span class='company_label'>고객사 :</span><span class='company_cont' id=''>"+val["customerName"]+"</span>";
//						projectHtml += "</p>";

						projectHtml += "	<p class='f18 fc11 tar m-b-15 pr100'>총 청구금액</p>";
						projectHtml += "	<p class='tar pr100'><span class='total fontVdn'>"+addcomma(val["amount"])+"</span> <span class='unit'>원</span></p>";

						projectHtml += "</div>";

					}else{
						projectHtml += "<div class='billcompBg'>";
						projectHtml += "<h2 class='customer_Id dpin width-120'>"+val["projectName"]+"</h2>";
						projectHtml += "<p class='company_Name2 dpin w80 ml10'>"+val["projectAlias"]+"</p>";
//						projectHtml += "<p class='company_Info'>";
						projectHtml += "<h3 class='mt20'>조회기간 : "+startDtY+"-"+startDtM+" ~ "+endDtY+"-"+endDtM+"</h3>";
//						projectHtml += "	<span class='company_labelf'>조회기간 :</span><span class='company_cont' id=''>"+startDt+"</span>~<span class='company_cont' id=''>"+endDt+"</span>";
//						projectHtml += "	<span class='company_label'>고객사 :</span><span class='company_cont' id=''>"+val["customerName"]+"</span>";
//						projectHtml += "</p>";

						projectHtml += "	<p class='f18 fc11 tar m-b-15 pr100'>총 청구금액</p>";
						projectHtml += "	<p class='tar pr100'><span class='total fontVdn'>"+addcomma(val["amount"])+"</span> <span class='unit'>원</span></p>";

						projectHtml += "</div>";
					}

					Html += "<div class='billBoxArea'>";

					/* 기본자원 시작 */
					if(detailList!=""){
						var vmTot = 0;
						$.each(detailList,function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2){
								if(vmResourceList != ""){
									vmTot += Number(val["amount"]);
								}
							}
						});

//						Html += "	<h2 class='titleBuType01 m-b-15'>클라우드 자원 상세내역</h2>";
						Html += "	<div class='billBox'>";
						Html += "		<dl>";
						Html += "			<dt>기본 자원</dt>";
						Html += "			<dd><strong class='fontVdn'>"+addcomma(vmTot)+"</strong>&nbsp;원</dd>";
						Html += "		</dl>";
						Html += "		<div class='billBoxList'>";
						Html += "			<ul class='depth1'>";
					}

				 	//-->기본자원 자원 시작
					if(detailList!=""){
						$.each(detailList,function(key,val){
							var projectId2 = val["projectId"];
							var resourceId = val["resourceId"];
							var hourlyFlag = val["hourlyFlag"];
							var vmUuid = val["vmUuid"];

							if(projectId1==projectId2){

								if(vmResourceList != ""){
									Html += "<li class='depth1Li active'>";
									Html += "	<div class='depth1Header'>";
									Html += "		<strong class='productName'>"+val["hostnameAlias"]+"</strong>";
									if(hourlyFlag=="N"){
										Html += "	<span class='month'>월</span>";
									}else{
										Html += "	<span class='month'>시간</span>";
									}
									Html += "		<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
									Html += "		<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em><span class='unit'>원</span></span>";
									Html += "	</div>";

									Html += "<div class='detaliList'>";
									Html += "	<ul class='depth2'>";
									$.each(vmResourceList,function(key,val){
										var resourceId = val["resourceId"];
										if(vmUuid == resourceId){
											var measuerValue = Number(val["measureValue"]);

											Html += "<li class='depth2Li'>";
											Html += "	<span class='product fontVdn'>"+val["resourceItem"]+"</span>";
											if(val["resourceItem"]=="CPU"){
												Html += "	<span class='productSize fontVdn'>"+measuerValue+ " Core</span>";
											}else if(val["resourceItem"]=="MEMORY"){
												Html += "	<span class='productSize fontVdn'>"+measuerValue+ " GB</span>";
											}else if(val["resourceItem"]=="DISK"){
												Html += "	<span class='productSize fontVdn'>"+measuerValue+ " GB</span>";
											}

											Html += "	<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
											Html += "	<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "</li>";

										}
									});
									Html += "		</ul>"; 	//depth2
									Html += "	</div>"; 	//detaliList
									Html += "</li>";	//depth1Li active
								}
							}
						});
					}//<--기본자원 자원 끝

					if(detailList!=""){
						Html += "		</ul>";
						Html += "	</div>";
						Html += "</div>";
					}
					/* 기본자원 끝 */



					/* 부가자원 시작 */
					//-->부가자원 자원 시작
					var subTot = 0;
					if(diskResourceList != ""){
						$.each(diskResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1 == projectId2){
								subTot += Number(val["amount"]);
							}
						});
					}
					if(nasResourceList != ""){
						$.each(nasResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1 == projectId2){
								subTot += Number(val["amount"]);
							}
						});
					}
					if(ipResourceList != ""){
						$.each(ipResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1 == projectId2){
								subTot += Number(val["amount"]);
							}
						});
					}
					if(loadbalancerResourceList != ""){
						$.each(loadbalancerResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1 == projectId2){
								subTot += Number(val["amount"]);
							}
						});
					}


					if(diskResourceList !="" || nasResourceList !="" || ipResourceList !="" || loadbalancerResourceList !=""){
						var projectId2 = "";
						$.each(diskResourceList, function(key,val){
							projectId2 = val["projectId"];
						});
						$.each(nasResourceList, function(key,val){
							projectId2 = val["projectId"];
						});
						$.each(ipResourceList, function(key,val){
							projectId2 = val["projectId"];
						});
						$.each(loadbalancerResourceList, function(key,val){
							projectId2 = val["projectId"];
						});

						if(projectId1 == projectId2){
							Html += "<div class='billBox mt20'>";
							Html += "	<dl>";
							Html += "		<dt>부가 자원</dt>";
							Html += "		<dd><strong class='fontVdn'>"+addcomma(subTot)+"</strong>&nbsp;원</dd>";
							Html += "	</dl>";

							Html += "	<div class='billBoxList'>";
							Html += "		<ul class='depth1'>";
						}else{
							Html += "<div class='billBox mt20'>";
							Html += "	<dl>";
							Html += "		<dt>부가 자원</dt>";
							Html += "		<dd><strong class='fontVdn'>0</strong>&nbsp;원</dd>";
							Html += "	</dl>";

							Html += "	<div class='billBoxList'>";
							Html += "		<ul class='depth1'>";
						}
					}

					//블록디스크
					if(diskResourceList != ""){
						$.each(diskResourceList, function(key,val){
							var projectId2 = val["projectId"];
							var hourlyFlag = val["hourlyFlag"];

							if(projectId1==projectId2){
								var measuerValue = Number(val["measureValue"]);

								Html += "<li class='depth1Li'>";
								Html += "	<div class='depth1Header'>";
								Html += "		<strong class='productName'>블록디스크("+val["diskAlias"]+")</strong>";
								if(hourlyFlag=="N"){
									Html += "		<span class='month'>월</span>";
								}else{
									Html += "		<span class='month'>시간</span>";
								}
								Html += "		<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "		<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em><span class='unit'>원</span></span>";
								Html += "	</div>";
								Html += "	<div class='detaliList'>";
								Html += "		<ul class='depth2'>";
								Html += "			<li class='depth2Li'>";
								Html += "				<span class='product fontVdn'>"+val["resourceItem"]+"</span>";
								Html += "				<span class='productSize fontVdn'>"+measuerValue+" GB</span>";
								Html += "				<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "				<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
								Html += "			</li>";
								Html += "		</ul>";
								Html += "	</div>";
								Html += "</li>";

							}
						});
					}
					//NAS
					if(nasResourceList!=""){
						$.each(nasResourceList, function(key,val){
							var projectId2 = val["projectId"];
							var hourlyFlag = val["hourlyFlag"];
							if(projectId1==projectId2){
								var measuerValue = Number(val["measureValue"]);

								Html += "<li class='depth1Li'>";
								Html += "	<div class='depth1Header'>";
								Html += "		<strong class='productName'>NAS</strong>";
								if(hourlyFlag=="N"){
									Html += "		<span class='month'>월</span>";
								}else{
									Html += "		<span class='month'>시간</span>";
								}
								Html += "		<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "		<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em><span class='unit'>원</span></span>";
								Html += "	</div>";
								Html += "	<div class='detaliList'>";
								Html += "		<ul class='depth2'>";
								Html += "			<li class='depth2Li'>";
								Html += "				<span class='product fontVdn'>"+val["resourceItem"]+"</span>";
								Html += "				<span class='productSize fontVdn'>"+measuerValue+" GB</span>";
								Html += "				<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "				<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
								Html += "			</li>";
								Html += "		</ul>";
								Html += "	</div>";
								Html += "</li>";
							}
						});
					}
					//공인IP
					if(ipResourceList!=""){
						$.each(ipResourceList, function(key,val){
							var projectId2 = val["projectId"];
							var hourlyFlag = val["hourlyFlag"];
							if(projectId1==projectId2){
								var measuerValue = Number(val["measureValue"]);

								Html += "<li class='depth1Li'>";
								Html += "	<div class='depth1Header'>";
								Html += "		<strong class='productName'>공인IP</strong>";
								if(hourlyFlag=="N"){
									Html += "		<span class='month'>월</span>";
								}else{
									Html += "		<span class='month'>시간</span>";
								}
								Html += "		<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "		<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em><span class='unit'>원</span></span>";
								Html += "	</div>";
								Html += "	<div class='detaliList'>";
								Html += "		<ul class='depth2'>";
								Html += "			<li class='depth2Li'>";
								Html += "				<span class='product fontVdn'>"+val["resourceItem"]+"</span>";
								Html += "				<span class='productSize fontVdn'>"+measuerValue+" EA</span>";
								Html += "				<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "				<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
								Html += "			</li>";
								Html += "		</ul>";
								Html += "	</div>";
								Html += "</li>";
							}
						});
					}
					//로드밸런서
					if(loadbalancerResourceList!=""){
						$.each(loadbalancerResourceList, function(key,val){
							var projectId2 = val["projectId"];
							var hourlyFlag = val["hourlyFlag"];
							if(projectId1==projectId2){
								var measuerValue = Number(val["measureValue"]);

								Html += "<li class='depth1Li'>";
								Html += "	<div class='depth1Header'>";
								Html += "		<strong class='productName'>서비스 로드 분산</strong>";
								if(hourlyFlag=="N"){
									Html += "		<span class='month'>월</span>";
								}else{
									Html += "		<span class='month'>시간</span>";
								}
								Html += "		<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "		<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em><span class='unit'>원</span></span>";
								Html += "	</div>";
								Html += "	<div class='detaliList'>";
								Html += "		<ul class='depth2'>";
								Html += "			<li class='depth2Li'>";
								Html += "				<span class='product fontVdn'>"+val["resourceItem"]+"</span>";
								Html += "				<span class='productSize fontVdn'>"+measuerValue+" EA</span>";
								Html += "				<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "				<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
								Html += "			</li>";
								Html += "		</ul>";
								Html += "	</div>";
								Html += "</li>";
							}
						});
					}
					//<--부가자원 자원 끝

					if(diskResourceList !="" || nasResourceList !="" || ipResourceList !="" || loadbalancerResourceList !=""){
						Html += "		</ul>";
						Html += "	</div>";
						Html += "</div>";
					}
					/* 부가자원 끝 */

					//-->서비스 자원 시작

					var srvTot = 0;
// 					if(backupResourceList != ""){
// 						$.each(backupResourceList, function(key,val){
// 							var projectId2 = val["projectId"];
// 							if(projectId1 == projectId2){
// 								srvTot += Number(val["amount"]);
// 							}
// 						});
// 					}
// 					if(mcaResourceList != ""){
// 						$.each(mcaResourceList, function(key,val){
// 							var projectId2 = val["projectId"];
// 							if(projectId1 == projectId2){
// 								srvTot += Number(val["amount"]);
// 							}
// 						});
// 					}
// 					if(scmResourceList != ""){
// 						$.each(scmResourceList, function(key,val){
// 							var projectId2 = val["projectId"];
// 							if(projectId1 == projectId2){
// 								srvTot += Number(val["amount"]);
// 							}
// 						});
// 					}
// 					if(securityResourceList != ""){
// 						$.each(securityResourceList, function(key,val){
// 							var projectId2 = val["projectId"];
// 							if(projectId1 == projectId2){
// 								srvTot += Number(val["amount"]);
// 							}
// 						});
// 					}


					if(serviceResourceList != ""){
						$.each(serviceResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1 == projectId2){
								srvTot += Number(val["amount"]);
							}
						});
					}



					if(serviceResourceList !=""){
						var projectId2 = "";

						$.each(serviceResourceList, function(key,val){
							projectId2 = val["projectId"];
						});

						if(projectId1 == projectId2){

							Html += "<div class='billBox mt20'>";
							Html += "	<dl>";
							Html += "		<dt>서비스</dt>";
							Html += "		<dd><strong class='fontVdn'>"+addcomma(srvTot)+"</strong>&nbsp;원</dd>";
							Html += "	</dl>";

							Html += "	<div class='billBoxList'>";
							Html += "		<ul class='depth1'>";
						}else{

							Html += "<div class='billBox mt20'>";
							Html += "	<dl>";
							Html += "		<dt>서비스</dt>";
							Html += "		<dd><strong class='fontVdn'>0</strong>&nbsp;원</dd>";
							Html += "	</dl>";

							Html += "	<div class='billBoxList'>";
							Html += "		<ul class='depth1'>";
						}
					}

					//서비스
					if(serviceResourceList!=""){
						$.each(serviceResourceList, function(key,val){

							var projectId2 = val["projectId"];
							var hourlyFlag = val["hourlyFlag"];
							if(projectId1==projectId2){
								var measuerValue = Number(val["measureValue"]);
								var serviceName = val["serviceName"];
								var serviceTypeName = val["serviceTypeName"];

								Html += "<li class='depth1Li'>";
								Html += "	<div class='depth1Header'>";
								Html += "		<strong class='productName'>서비스 ("+serviceTypeName+") "+serviceName+"</strong>";
								Html += "		<span class='month'>월</span>";
								Html += "		<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "		<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em><span class='unit'>원</span></span>";
								Html += "	</div>";
								Html += "	<div class='detaliList'>";
								Html += "		<ul class='depth2'>";
								Html += "			<li class='depth2Li'>";
								Html += "				<span class='product fontVdn'>"+val["resourceItem"]+"</span>";
								Html += "				<span class='productSize fontVdn'>"+measuerValue+" EA</span>";
								Html += "				<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "				<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
								Html += "			</li>";
								Html += "		</ul>";
								Html += "	</div>";
								Html += "</li>";
							}
						});
					}

					//백업서비스
// 					if(backupResourceList!=""){
// 						$.each(backupResourceList, function(key,val){
// 							var projectId2 = val["projectId"];
// 							var hourlyFlag = val["hourlyFlag"];
// 							if(projectId1==projectId2){
// 								var measuerValue = Number(val["measureValue"]);

// 								Html += "<li class='depth1Li'>";
// 								Html += "	<div class='depth1Header'>";
// 								Html += "		<strong class='productName'>백업 서비스</strong>";
// 								if(hourlyFlag=="N"){
// 									Html += "		<span class='month'>월</span>";
// 								}else{
// 									Html += "		<span class='month'>시간</span>";
// 								}
// 								Html += "		<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
// 								Html += "		<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em><span class='unit'>원</span></span>";
// 								Html += "	</div>";
// 								Html += "	<div class='detaliList'>";
// 								Html += "		<ul class='depth2'>";
// 								Html += "			<li class='depth2Li'>";
// 								Html += "				<span class='product fontVdn'>"+val["resourceItem"]+"</span>";
// 								Html += "				<span class='productSize fontVdn'>"+measuerValue+" GB</span>";
// 								Html += "				<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
// 								Html += "				<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
// 								Html += "			</li>";
// 								Html += "		</ul>";
// 								Html += "	</div>";
// 								Html += "</li>";
// 							}
// 						});
// 					}
					//대외계
// 					if(mcaResourceList!=""){
// 						$.each(mcaResourceList, function(key,val){
// 							var projectId2 = val["projectId"];
// 							var hourlyFlag = val["hourlyFlag"];
// 							if(projectId1==projectId2){
// 								var measuerValue = Number(val["measureValue"]);

// 								Html += "<li class='depth1Li'>";
// 								Html += "	<div class='depth1Header'>";
// 								Html += "		<strong class='productName'>대외계 서비스</strong>";
// 								if(hourlyFlag=="N"){
// 									Html += "		<span class='month'>월</span>";
// 								}else{
// 									Html += "		<span class='month'>시간</span>";
// 								}
// 								Html += "		<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
// 								Html += "		<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em><span class='unit'>원</span></span>";
// 								Html += "	</div>";
// 								Html += "	<div class='detaliList'>";
// 								Html += "		<ul class='depth2'>";
// 								Html += "			<li class='depth2Li'>";
// 								Html += "				<span class='product fontVdn'>"+val["resourceItem"]+"</span>";
// 								Html += "				<span class='productSize fontVdn'>"+measuerValue+" 식</span>";
// 								Html += "				<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
// 								Html += "				<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
// 								Html += "			</li>";
// 								Html += "		</ul>";
// 								Html += "	</div>";
// 								Html += "</li>";
// 							}
// 						});
// 					}
					//형상관리
// 					if(scmResourceList!=""){
// 						$.each(scmResourceList, function(key,val){
// 							var projectId2 = val["projectId"];
// 							var hourlyFlag = val["hourlyFlag"];
// 							if(projectId1==projectId2){
// 								var measuerValue = Number(val["measureValue"]);

// 								Html += "<li class='depth1Li'>";
// 								Html += "	<div class='depth1Header'>";
// 								Html += "		<strong class='productName'>형상관리 서비스</strong>";
// 								if(hourlyFlag=="N"){
// 									Html += "		<span class='month'>월</span>";
// 								}else{
// 									Html += "		<span class='month'>시간</span>";
// 								}
// 								Html += "		<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
// 								Html += "		<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em><span class='unit'>원</span></span>";
// 								Html += "	</div>";
// 								Html += "	<div class='detaliList'>";
// 								Html += "		<ul class='depth2'>";
// 								Html += "			<li class='depth2Li'>";
// 								Html += "				<span class='product fontVdn'>"+val["resourceItem"]+"</span>";
// 								Html += "				<span class='productSize fontVdn'>"+measuerValue+" 식</span>";
// 								Html += "				<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
// 								Html += "				<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
// 								Html += "			</li>";
// 								Html += "		</ul>";
// 								Html += "	</div>";
// 								Html += "</li>";
// 							}
// 						});
// 					}
					//보안관제
// 					if(securityResourceList!=""){
// 						$.each(securityResourceList, function(key,val){
// 							var projectId2 = val["projectId"];
// 							var hourlyFlag = val["hourlyFlag"];
// 							if(projectId1==projectId2){
// 								var measuerValue = Number(val["measureValue"]);

// 								Html += "<li class='depth1Li active'>";
// 								Html += "	<div class='depth1Header'>";
// 								Html += "		<strong class='productName'>보안관제 서비스</strong>";
// 								if(hourlyFlag=="N"){
// 									Html += "		<span class='month'>월</span>";
// 								}else{
// 									Html += "		<span class='month'>시간</span>";
// 								}
// 								Html += "		<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
// 								Html += "		<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em><span class='unit'>원</span></span>";
// 								Html += "	</div>";
// 								Html += "	<div class='detaliList'>";
// 								Html += "		<ul class='depth2'>";
// 								Html += "			<li class='depth2Li'>";
// 								Html += "				<span class='product fontVdn'>"+val["resourceItem"]+"</span>";
// 								Html += "				<span class='productSize fontVdn'>"+measuerValue+" 식</span>";
// 								Html += "				<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
// 								Html += "				<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
// 								Html += "			</li>";
// 								Html += "		</ul>";
// 								Html += "	</div>";
// 								Html += "</li>";
// 							}
// 						});
// 					}
					//<--부가자원 자원 끝

// 					if(backupResourceList !="" || mcaResourceList !="" || scmResourceList !="" || securityResourceList !=""){
					if(serviceResourceList !="") {}
						Html += "		</ul>";
						Html += "	</div>";
						Html += "</div>";
					
					/* 부가자원 끝 */



					//요금할인
					var dcTot = 0;
					if(dcAdList!=""){
						var dcChk = "false";
						$.each(dcAdList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2 && val["invoiceItem"]=="EA00"){
								dcTot += Number(val["amount"]);
								dcChk = "true";
							}
							if(projectId1==projectId2 && val["invoiceItem"]=="EL00"){
								dcTot += Number(val["amount"]);
								dcChk = "true";
							}
						});
						if(dcChk == "true"){
							Html += "<h2 class='titleBuType01 m-b-15 m-t-20'>요금할인</h2>";
							Html += "<div class='billBox'>";
							Html += "	<dl>";
							Html += "		<dt>요금할인</dt>";
							Html += "		<dd><strong class='fontVdn down'>"+addcomma(dcTot)+"</strong>&nbsp;원</dd>";
							Html += "	</dl>";
							Html += "	<div class='billBoxList'>";
							Html += "		<ul class='depth1'>";
							Html += "			<li class='depth1Li active'>";
							Html += "				<div class='detaliList'>";
							Html += "					<ul class='depth2'>";
							Html += "						<li class='colli'>";
						}
					}

					if(dcAdList!=""){
						$.each(dcAdList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2 && val["invoiceItem"]=="EA00"){
								Html += "<p>";
								Html += "	<span class='product'>- 프로젝트 할인</span>";
								Html += "	<span class='price flr m-r-10'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
								Html += "</p>";
							}
							if(projectId1==projectId2 && val["invoiceItem"]=="EL00"){
								Html += "<p>";
								Html += "	<span class='product'>- 10원미만 절사 할인</span>";
								Html += "	<span class='price flr m-r-10'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
								Html += "</p>";
							}
						});
					}

					if(dcAdList!=""){
						var dcChk = "false";
						$.each(dcAdList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2 && val["invoiceItem"]=="EA00"){
								dcTot += Number(val["amount"]);
								dcChk = "true";
							}
							if(projectId1==projectId2 && val["invoiceItem"]=="EL00"){
								dcTot += Number(val["amount"]);
								dcChk = "true";
							}
						});

						if(dcChk == "true"){
							Html += "						</li>";
							Html += "					</ul>";
							Html += "				</div>";
							Html += "			</li>";
							Html += "		</ul>";
							Html += "	</div>";
							Html += "</div>";
						}
					}



					//보정
					var fixTot = 0;
					if(dcAdList!=""){
						var fixChk = "false";
						$.each(dcAdList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2 && val["invoiceItem"]=="IA00"){
								fixTot += Number(val["amount"]);
								fixChk = "true";
							}
						});

						if(fixChk=="true"){
							Html += "<h2 class='titleBuType01 m-b-15 m-t-20'>보정</h2>";
							Html += "<div class='billBox'>";
							Html += "	<dl>";
							Html += "		<dt>보정</dt>";
							if(fixTot < 0){
								Html += "		<dd><strong class='fontVdn up'>"+addcomma(fixTot)+"</strong>&nbsp;원</dd>";
							}else{
								Html += "		<dd><strong class='fontVdn down'>"+addcomma(fixTot)+"</strong>&nbsp;원</dd>";
							}
							Html += "	</dl>";
							Html += "	<div class='billBoxList'>";
							Html += "		<ul class='depth1'>";
							Html += "			<li class='depth1Li active'>";
							Html += "				<div class='detaliList'>";
							Html += "					<ul class='depth2'>";
							Html += "						<li class='colli'>";
						}
					}


					if(dcAdList!=""){
						$.each(dcAdList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2 && val["invoiceItem"]=="IA00"){
								Html += "<p>";
								Html += "	<span class='product'>- "+val["invoiceItemName"]+"</span>";
								Html += "	<span class='price flr m-r-10'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
								Html += "</p>";
							}
						});
					}

					if(dcAdList!=""){
						var fixChk = "false";

						$.each(dcAdList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2 && val["invoiceItem"]=="IA00"){
								fixChk = "true";
							}
						});

						if(fixChk == "true"){
							Html += "						</li>";
							Html += "					</ul>";
							Html += "				</div>";
							Html += "			</li>";
							Html += "		</ul>";
							Html += "	</div>";
							Html += "</div>";
						}
					}

					var total = 0;
					var vat = 0;
					if(dcAdList!=""){
						$.each(dcAdList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2){
								if(val["invoiceItem"]=="0000"){
									total = val["amount"];
								}
								if(val["invoiceItem"]=="L000"){
									vat = val["amount"];
								}
							}
						});
					}


/*					Html += "<div class='billtotalArea m-t-20'>";
				    Html += "	<span class='fl f24 fc11 m-t-37'>총 합계</span>";
			    	Html += "	<div class='flr tar f24 fc66  m-t-30'>";
					Html += "		<p class='m-b-5'>";
					Html += "			<em class=''>"+addcomma(total)+"</em>";
					Html += "			원";
					Html += "		</p>";
					Html += "	</div>";
					Html += "</div>"; */

					Html += "</div>";


					$("#billBoxArea").append(projectHtml);
					$("#billDiv").append(Html);
				});

				$('.billBoxList .depth1 > li .depth1Header').click(function(e){
					$(this).parent().toggleClass('active');
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function moveListPage() {
		location.href = "${contextPath}/mng/charge/bill/";
	}

	function strTrim(str){
		return str.replace(/(^\s*)|(\s*$)/g, "");
	}

	$(document).ready(function() {
	    App.init();
	    getDetail();



		//메뉴활성화
		$("#priceInquiry").addClass("active");
		$("#bill").addClass("active");

	});

</script>

</body>
</html>
