<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>

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
		
		<!-- begin #page-container -->
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
			
			<!-- begin #header -->
			<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->
		
			<!-- begin #sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->
			
			<!-- begin #hidden input data -->
			<input type="hidden" id="h_cloudId" value="${cloudId}">
			<input type="hidden" id="h_customerId" value="${customerId}">
			<input type="hidden" id="h_billYyyymm" value="${billYyyymm}">
			<!-- begin #hidden input data -->
			
			<!-- begin #content -->
			<div id="content" class="content">
			
				<h1 class="page-header"><span class="root"> <span class="home"></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow"><a href="${wasPath}/mbr/charge/bill/view"><strong>청구서</strong></a></span><span class="text arrow mint"><a href="${wasPath}/mbr/charge/bill/billDetailListPage?billYyyymm=${billYyyymm}&customerId=${customerId}"><strong>상세</strong></a></span></span></h1>
	
				<!-- begin page-body -->
				<div class="row mb50">
					<p class="page_title"><span class="stick">청</span>구서 상세</p>
					<div class="billWrapper p20" id="billWrapper">
					
					</div>
					
					<div class="btn_area">		
						<a type="button" class="bbton bton_blue" onclick="movePage();"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-list"></i></span><span class="dpin ml16">목록</span></a>         
						<a type="button" class="bbton bton_green ml10"><span class="dpin dd bton_dgreen ml-1"><i class="fa fa-arrow-left"></i></span><span class="dpin ml16">이전</span></a>                  
					</div> 
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
		
			function bbsAccor() {
				$('.billBoxList .depth1 > li .depth1Header').click(function(e){
					$(this).parent().toggleClass('active');
				});
			}
			
			
			// 청구서 상세
			function getDetail(){
				
				var currentYear = (new Date()).getFullYear();
				var currentMonth = (new Date()).getMonth()+1;
				if(currentMonth.length < 2){
					currentMonth = "0"+currentMonth;
				}
				
				$.ajax({
					url : "${contextPath}/mbr/charge/bill/billCustomerDetailList",
			//			dataType : "JSON",
			//			type : "POST",
					data : {
						"cloudId" : $("#h_cloudId").val()
						,"customerId" : $("#h_customerId").val()	
						,"billYyyymm" : $("#h_billYyyymm").val()
						,"projectId" : ""
					},
					success : function(data) {
						var projectList = data.projectList;
						var detailList = data.detailList;
						var vmResourceList = data.vmResourceList;
						
						var diskResourceList = data.diskResourceList;
						var nasResourceList = data.nasResourceList;
						var ipResourceList = data.ipResourceList;
						var loadbalancerResourceList = data.loadbalancerResourceList;
						
						var serviceResourceList = data.serviceResourceList
						/*
						var backupResourceList = data.backupResourceList;
						var mcaResourceList = data.mcaResourceList;
						var scmResourceList = data.scmResourceList;
						var securityResourceList = data.securityResourceList;
						*/
						var dcAdList = data.dcAdList;
						
						delete projectList.length;
						delete detailList.length;
						delete vmResourceList.length;
						delete diskResourceList.length;
						delete nasResourceList.length;
						delete ipResourceList.length;
						delete loadbalancerResourceList.length;
						
						delete serviceResourceList.length;
						/*
						delete backupResourceList.length;
						delete mcaResourceList.length;
						delete scmResourceList.length;
						delete securityResourceList.length;
						*/
						delete dcAdList.length;
						
						$("#billWrapper").empty();
						if(projectList.length != 0){
						
							$.each(projectList,function(key,val){
								var projectId1 = val["projectId"];
								var headerHtml = "";
								var Html = "";
								var _project = val["projectAlias"];
								var _projectName = val["projectName"];
								var _billYyyymm = val["billYyyymm"];
								
								var billYm = _billYyyymm;
								var billY = billYm.substring(0,4);
								var billM = billYm.substring(4,6);
								
								// header
								if(strTrim(_project) == ""){
									Html = "<div class='billHeaderType02'>";
									Html += "<strong class='projectName'>"+val["projectName"]+"</strong>";
									Html += "<dl>";
									if(currentMonth < billM){
										Html += "<dt><strong class='nanumR'>"+billM+"</strong> <span>월 예상 청구요금</span></dt>";
									}else{
										Html += "<dt><strong class='nanumR'>"+billM+"</strong> <span>월 청구요금</span></dt>";
									}
									Html += "<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>원</dd>";
									Html += "</dl>";
									Html += "</div>";
								}else{
									Html = "<div class='billHeaderType02'>";
									Html += "<strong class='projectName'>"+val["projectAlias"]+"</strong>";
									Html += "<dl>";
									if(currentMonth < billM){
										Html += "<dt><strong class='nanumR'>"+billM+"</strong> <span>월 예상 청구요금</span></dt>";
									}else{
										Html += "<dt><strong class='nanumR'>"+billM+"</strong> <span>월 청구요금</span></dt>";
									}
									Html += "<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</dd>";
									Html += "</dl>";
									Html += "</div>";
								}
			// 					$("#billWrapper").append(headerHtml);
								
								
								Html += "<div class='billContents'>";
								Html += "	<div class='billCntType02'>";
								Html += "		<div class='titleArea'>클라우드 자원 상세내역</div>";
								
								//-->기본자원 자원 시작
								if(detailList!=""){
									Html += "			<div class='billBox'>";
									Html += "<dl>";
									Html += "	<dt>기본 자원</dt>";
									$.each(dcAdList, function(key,val){
										var projectId2 = val["projectId"];
										if(projectId1==projectId2){
											if(val["invoiceItem"]=="AA00"){
												Html += "				<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</dd>";
											}
										}
									});
									Html += "</dl>";
									Html += "<div class='billBoxList'>";
									Html += "	<ul class='depth1'>";
									
									$.each(detailList,function(key,val){
										var projectId2 = val["projectId"];
										var resourceId = val["resourceId"];
										var hourlyFlag = val["hourlyFlag"];
										var vmUuid = val["vmUuid"];
										
										if(projectId1==projectId2){
											
											if(vmResourceList != ""){
												Html += "<li class='depth1Li'>";
												Html += "	<div class='depth1Header'>";
												Html += "		<strong class='productName'>"+val["hostnameAlias"]+"</strong>";
												if(hourlyFlag=="N"){
													Html += "	<span class='month'>월</span>";
												}else{
													Html += "	<span class='month'>시간</span>";
												}
												
												Html += "		<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
												Html += "		<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
												Html += "	</div>";
												Html += "	<div class='detaliList'>";
												Html += "		<ul class='depth2'>";
												
												$.each(vmResourceList,function(key,val){
													var resourceId = val["resourceId"];
													if(vmUuid == resourceId){
														var measuerValue = Number(val["measureValue"]);
														
														Html += "<li class='depth2Li'>";
														Html += "<span class='product'>"+val["resourceItem"]+"</span>";
														
														if(val["resourceItem"]=="CPU"){
															Html += "<span class='productSize'>"+addcomma(measuerValue)+ " Core</span>";
														}else if(val["resourceItem"]=="MEMORY"){
															Html += "<span class='productSize'>"+addcomma(measuerValue)+ " GB</span>";
														}else if(val["resourceItem"]=="DISK"){
															Html += "<span class='productSize'>"+addcomma(measuerValue)+ " GB</span>";
														}	
														Html += "<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
														Html += "<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
														Html += "</li>";
														
													}
												});
												Html += "		</ul>";
												Html += "	</div>";
												Html += "</li>";
											}
										}
									});
									
									Html += "</ul>";
									Html += "</div>";
									Html += "</div>";
								}//<--기본자원 자원 끝
								
			// 					$("#billContents").append(Html);
								
								
								//-->부가자원 자원 시작
								Html += "<div class='billBox'>";
								Html += "	<dl>";
								Html += "		<dt>부가 자원</dt>";
								$.each(dcAdList, function(key,val){
									var projectId2 = val["projectId"];
									if(projectId1==projectId2){
										if(val["invoiceItem"]=="AE00"){
											Html += "				<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</dd>";
										}
									}
								});
								Html += "	</dl>";
								Html += "	<div class='billBoxList'>";
								Html += "		<ul class='depth1'>";
								
								//블록디스크
								if(diskResourceList!=""){
									$.each(diskResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var resourceId = val["resourceId"];
										var hourlyFlag = val["hourlyFlag"];
										var vmUuid = val["vmUuid"];
										
										if(projectId1==projectId2){
										
											Html += "<li class='depth1Li'>";
											Html += "	<div class='depth1Header'>";
											Html += "		<strong class='productName'>블록디스크("+val["diskAlias"]+")</strong>";
											if(hourlyFlag=="N"){
												Html += "	<span class='month'>월</span>";
											}else{
												Html += "	<span class='month'>시간</span>";
											}
											
											Html += "		<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "		<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "	</div>";
											Html += "	<div class='detaliList'>";
											Html += "		<ul class='depth2'>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html += "		<li class='depth2Li'>";
											Html += "			<span class='product'>"+val["resourceItem"]+"</span>";
											Html += "			<span class='productSize'>"+addcomma(measuerValue)+ " GB</span>";
											Html += "			<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "			<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "		</li>";
										
											Html += "		</ul>";
											Html += "	</div>";
											Html += "</li>";
											
										}
									});
								}
								
								// NAS
								if(nasResourceList!=""){
									$.each(nasResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var resourceId = val["resourceId"];
										var hourlyFlag = val["hourlyFlag"];
										var vmUuid = val["vmUuid"];
										
										if(projectId1==projectId2){
										
											Html += "<li class='depth1Li'>";
											Html += "	<div class='depth1Header'>";
											Html += "		<strong class='productName'>NAS("+val["nasName"]+")</strong>";
											if(hourlyFlag=="N"){
												Html += "	<span class='month'>월</span>";
											}else{
												Html += "	<span class='month'>시간</span>";
											}
											
											Html += "		<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "		<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "	</div>";
											Html += "	<div class='detaliList'>";
											Html += "		<ul class='depth2'>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html += "		<li class='depth2Li'>";
											Html += "			<span class='product'>"+val["resourceItem"]+"</span>";
											Html += "			<span class='productSize'>"+addcomma(measuerValue)+ " GB</span>";
											Html += "			<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "			<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "		</li>";
										
											Html += "		</ul>";
											Html += "	</div>";
											Html += "</li>";
											
										}
									});
									
								}
								
								// 공인IP
								if(ipResourceList!=""){
									$.each(ipResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var resourceId = val["resourceId"];
										var hourlyFlag = val["hourlyFlag"];
										var vmUuid = val["vmUuid"];
										
										if(projectId1==projectId2){
										
											Html += "<li class='depth1Li'>";
											Html += "	<div class='depth1Header'>";
											Html += "		<strong class='productName'>공인IP</strong>";
											if(hourlyFlag=="N"){
												Html += "	<span class='month'>월</span>";
											}else{
												Html += "	<span class='month'>시간</span>";
											}
											
											Html += "		<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "		<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "	</div>";
											Html += "	<div class='detaliList'>";
											Html += "		<ul class='depth2'>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html += "		<li class='depth2Li'>";
											Html += "			<span class='product'>공인IP</span>";
											Html += "			<span class='productSize'>"+addcomma(measuerValue)+ " EA</span>";
											Html += "			<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "			<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "		</li>";
										
											Html += "		</ul>";
											Html += "	</div>";
											Html += "</li>";
											
										}
									});
									
								}
								
								// 로드밸런서
								if(loadbalancerResourceList!=""){
									$.each(loadbalancerResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var resourceId = val["resourceId"];
										var hourlyFlag = val["hourlyFlag"];
										var vmUuid = val["vmUuid"];
										
										if(projectId1==projectId2){
										
											Html += "<li class='depth1Li'>";
											Html += "	<div class='depth1Header'>";
											Html += "		<strong class='productName'>로드밸런서</strong>";
											if(hourlyFlag=="N"){
												Html += "	<span class='month'>월</span>";
											}else{
												Html += "	<span class='month'>시간</span>";
											}
											
											Html += "		<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "		<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "	</div>";
											Html += "	<div class='detaliList'>";
											Html += "		<ul class='depth2'>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html += "		<li class='depth2Li'>";
											Html += "			<span class='product'>"+val["resourceItem"]+"</span>";
											Html += "			<span class='productSize'>"+addcomma(measuerValue)+ " EA</span>";
											Html += "			<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "			<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "		</li>";
										
											Html += "		</ul>";
											Html += "	</div>";
											Html += "</li>";
											
										}
									});
									
								}
								//<--부가자원 자원 끝
								
								Html += "		</ul>";
								Html += "	</div>";
								Html += "</div>";
								
								//-->서비스 자원 시작
								Html += "<div class='billBox'>";
								Html += "	<dl>";
								Html += "		<dt>서비스</dt>";
								$.each(dcAdList, function(key,val){
									var projectId2 = val["projectId"];
									if(projectId1==projectId2){
										if(val["invoiceItem"]=="AI00"){
											Html += "				<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</dd>";
										}
									}
								});
								Html += "	</dl>";
								Html += "	<div class='billBoxList'>";
								Html += "		<ul class='depth1'>";
								
								// 신 통합비스
								if(serviceResourceList!=""){
									
									$.each(serviceResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var resourceId = val["resourceId"];
										var hourlyFlag = val["hourlyFlag"];
										var vmUuid = val["vmUuid"];
										
										if(projectId1==projectId2){
										
											Html += "<li class='depth1Li'>";
											Html += "	<div class='depth1Header'>";
											Html += "		<strong class='productName'>"+val["serviceType"] +"</strong>";
											if(hourlyFlag=="N"){
												Html += "	<span class='month'>월</span>";
											}else{
												Html += "	<span class='month'>시간</span>";
											}
											
											Html += "		<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "		<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "	</div>";
											Html += "	<div class='detaliList'>";
											Html += "		<ul class='depth2'>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html += "		<li class='depth2Li'>";
											Html += "			<span class='product'>"+val["resourceItem"]+"</span>";
											Html += "			<span class='productSize'>"+addcomma(measuerValue)+ " GB</span>";
											Html += "			<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "			<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "		</li>";
										
											Html += "		</ul>";
											Html += "	</div>";
											Html += "</li>";
											
										}
									});
								}
								/*
								// 서비스 통합됨 2020.08.11 - 장중일
								//백업서비스
								if(backupResourceList!=""){
									$.each(backupResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var resourceId = val["resourceId"];
										var hourlyFlag = val["hourlyFlag"];
										var vmUuid = val["vmUuid"];
										
										if(projectId1==projectId2){
										
											Html += "<li class='depth1Li'>";
											Html += "	<div class='depth1Header'>";
											Html += "		<strong class='productName'>백업관리</strong>";
											if(hourlyFlag=="N"){
												Html += "	<span class='month'>월</span>";
											}else{
												Html += "	<span class='month'>시간</span>";
											}
											
											Html += "		<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "		<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "	</div>";
											Html += "	<div class='detaliList'>";
											Html += "		<ul class='depth2'>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html += "		<li class='depth2Li'>";
											Html += "			<span class='product'>"+val["resourceItem"]+"</span>";
											Html += "			<span class='productSize'>"+addcomma(measuerValue)+ " GB</span>";
											Html += "			<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "			<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "		</li>";
										
											Html += "		</ul>";
											Html += "	</div>";
											Html += "</li>";
											
										}
									});
								}
								
								// 대외계서비스
								if(mcaResourceList!=""){
									$.each(mcaResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var resourceId = val["resourceId"];
										var hourlyFlag = val["hourlyFlag"];
										var vmUuid = val["vmUuid"];
										
										if(projectId1==projectId2){
										
											Html += "<li class='depth1Li'>";
											Html += "	<div class='depth1Header'>";
											Html += "		<strong class='productName'>대외계 서비스</strong>";
											if(hourlyFlag=="N"){
												Html += "	<span class='month'>월</span>";
											}else{
												Html += "	<span class='month'>시간</span>";
											}
											
											Html += "		<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "		<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "	</div>";
											Html += "	<div class='detaliList'>";
											Html += "		<ul class='depth2'>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html += "		<li class='depth2Li'>";
											Html += "			<span class='product'>"+val["resourceItem"]+"</span>";
											Html += "			<span class='productSize'>"+addcomma(measuerValue)+ " 식</span>";
											Html += "			<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "			<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "		</li>";
										
											Html += "		</ul>";
											Html += "	</div>";
											Html += "</li>";
											
										}
									});
									
								}
								
								// 형상관리 서비스
								if(scmResourceList!=""){
									$.each(scmResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var resourceId = val["resourceId"];
										var hourlyFlag = val["hourlyFlag"];
										var vmUuid = val["vmUuid"];
										
										if(projectId1==projectId2){
										
											Html += "<li class='depth1Li'>";
											Html += "	<div class='depth1Header'>";
											Html += "		<strong class='productName'>형상관리 서비스</strong>";
											if(hourlyFlag=="N"){
												Html += "	<span class='month'>월</span>";
											}else{
												Html += "	<span class='month'>시간</span>";
											}
											
											Html += "		<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "		<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "	</div>";
											Html += "	<div class='detaliList'>";
											Html += "		<ul class='depth2'>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html += "		<li class='depth2Li'>";
											Html += "			<span class='product'>"+val["resourceItem"]+"</span>";
											Html += "			<span class='productSize'>"+addcomma(measuerValue)+ " 식</span>";
											Html += "			<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "			<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "		</li>";
										
											Html += "		</ul>";
											Html += "	</div>";
											Html += "</li>";
											
										}
									});
									
								}
								
								// 보안관제 서비스
								if(securityResourceList!=""){
									$.each(securityResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var resourceId = val["resourceId"];
										var hourlyFlag = val["hourlyFlag"];
										var vmUuid = val["vmUuid"];
										
										if(projectId1==projectId2){
										
											Html += "<li class='depth1Li'>";
											Html += "	<div class='depth1Header'>";
											Html += "		<strong class='productName'>보안관제 서비스</strong>";
											if(hourlyFlag=="N"){
												Html += "	<span class='month'>월</span>";
											}else{
												Html += "	<span class='month'>시간</span>";
											}
											
											Html += "		<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "		<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "	</div>";
											Html += "	<div class='detaliList'>";
											Html += "		<ul class='depth2'>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html += "		<li class='depth2Li'>";
											Html += "			<span class='product'>"+val["resourceItem"]+"</span>";
											Html += "			<span class='productSize'>"+addcomma(measuerValue)+ " 식</span>";
											Html += "			<span class='period nanumR'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</span>";
											Html += "			<span class='price'><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
											Html += "		</li>";
										
											Html += "		</ul>";
											Html += "	</div>";
											Html += "</li>";
											
										}
									});
									
								}
								*/
								
								Html += "		</ul>";
								Html += "	</div>";
								Html += "</div>";
						
								
							//	Html += "<div class='totalBoxArea'>";
							//	Html += "	<div class='box'>";
							//	Html += "		<dl class='cloudPrice'>";
							//	Html += "			<dt>클라우드 자원 총 합계</dt>";
								$.each(dcAdList, function(key,val){
									var projectId2 = val["projectId"];
									if(projectId1==projectId2){
										if(val["invoiceItem"]=="A000"){
											Html += "			<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</dd>";
										}
									}
								});
								Html += "		</dl>";
								Html += "	</div>";
								Html += "	<div class='box'>";
								
								if(dcAdList!=""){
									Html += "		<div class='boxType2 p-t-20'>";
									Html += "			<dl class='clearfix'>";
									Html += "				<dt>요금할인</dt>";
									var discount = 0;
									$.each(dcAdList, function(key,val){
										var projectId2 = val["projectId"];
										if(projectId1==projectId2){
											if(val["invoiceItem"]=="E000"){
												discount = val["amount"];
			// 									Html += "				<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</dd>";
											}
										}	
									});
									Html += "				<dd><strong class='nanumR'>"+addcomma(discount)+"</strong>&nbsp;원</dd>";
									
									Html += "			</dl>";
									Html += "			<ul class='clearfix'>";
									$.each(dcAdList, function(key,val){
										var projectId2 = val["projectId"];
										if(projectId1==projectId2){
											if(val["invoiceItem"]=="EA00"){
												Html += "<li><span>- 프로젝트 할인</span><strong><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</strong></li>";
											}else if(val["invoiceItem"]=="EL00"){
												Html += "<li><span>- 10원미만 절사 할인</span><strong><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</strong></li>";
											}
										}
									});
									Html += "			</ul>";
									Html += "		</div>";
								}
								if(dcAdList!=""){
									Html += "		<div class='boxType2 p-b-20'>";
									Html += "			<dl class='clearfix'>";
									Html += "				<dt>보정</dt>";
									var discount = 0;
									$.each(dcAdList, function(key,val){
										var projectId2 = val["projectId"];
										if(projectId1==projectId2){
											if(val["invoiceItem"]=="I000"){
												discount = val["amount"];
			// 									Html += "				<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</dd>";
											}
										}
									});
									Html += "				<dd><strong class='nanumR'>"+addcomma(discount)+"</strong>&nbsp;원</dd>";
									
									Html += "			</dl>";
									Html += "			<ul class='clearfix'>";
									$.each(dcAdList, function(key,val){
										var projectId2 = val["projectId"];
										if(projectId1==projectId2 && val["invoiceItem"]=="IA00"){
											Html += "<li><span>- "+val["invoiceItemName"]+"</span><strong><em class='nanumR'>"+addcomma(val["amount"])+"</em>&nbsp;원</strong></li>";
										}
									});
									Html += "			</ul>";
									Html += "		</div>";
								}
								Html += "	</div>";
								
							//	Html += "	<div class='box'>";
							//	Html += "		<div class='totalAcc'>";
							//	Html += "			<dl>";
							//	Html += "				<dt><strong>총 합계</strong></dt>";
			// 					Html += "				<dt><strong>총 합계</strong>(부가가치세)</dt>";
			// 					Html += "				<dd><strong class='nanumR'>888,888,888</strong>원<br><span>(444,444,444원)</span></dd>";
									
								$.each(dcAdList, function(key,val){
									var projectId2 = val["projectId"];
									if(projectId1==projectId2){
										if(val["invoiceItem"]=="0000"){
											Html += "				<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원<br></dd>";
										}
									}
								});
								Html += "			</dl>";
								Html += "		</div>";
								Html += "	</div>";
								Html += "</div>";
								
								Html += "	</div>";
								Html += "</div>";
						
								$("#billWrapper").append(Html);
					
								
								
							});
						
						}else{
							Html = "<tr><td colspan='4' class='f14 t-in16 fb tac'>상세내역이 없습니다.</td>";
							$("#billTable").append(Html);	
						}
						
						bbsAccor();
						
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "error:" + error);
					}
				});
				
			}
				
				
			/*
			// 청구서 상세
			function getDetail1(){
				$.ajax({
					url : "${contextPath}/mbr/charge/bill/billDetailList",
		 			//dataType : "JSON",
					//type : "POST",
					data : {
						"customerId" : $("#h_customerId").val()	
						,"billYyyymm" : $("#h_billYyyymm").val()
						,"projectId" : ""
					},
					success : function(data) {
						var projectList = data.projectList;
						var detailList = data.detailList;
						var vmResourceList = data.vmResourceList;
						
						var diskResourceList = data.diskResourceList;
						var nasResourceList = data.nasResourceList;
						var ipResourceList = data.ipResourceList;
						var loadbalancerResourceList = data.loadbalancerResourceList;
						
						var backupResourceList = data.backupResourceList;
						var mcaResourceList = data.mcaResourceList;
						var scmResourceList = data.scmResourceList;
						var securityResourceList = data.securityResourceList;
		
						var dcAdList = data.dcAdList;
						
						delete projectList.length;
						delete detailList.length;
						delete vmResourceList.length;
						delete diskResourceList.length;
						delete nasResourceList.length;
						delete ipResourceList.length;
						delete loadbalancerResourceList.length;
						delete backupResourceList.length;
						delete mcaResourceList.length;
						delete scmResourceList.length;
						delete securityResourceList.length;
						delete dcAdList.length;
						
						$("#billTable > tr").remove();
					
						if(projectList.length != 0){
						
							$.each(projectList,function(key,val){
								var projectId1 = val["projectId"];
								var Html = "";
								var _project = val["projectAlias"];
								var _projectName = val["projectName"];
								var _billYyyymm = val["billYyyymm"];
								
								var billYm = _billYyyymm;
								var billY = billYm.substring(0,4);
								var billM = billYm.substring(4,6);
								
								 
								if(strTrim(_project) == ""){
									Html="<tr class='bt2'><td class='f18 fbold fcb' colspan='2'>"+val["projectName"]+'<span class="fc00">(요금상세내역)</span><br><span><span class="circle-b">'+billM+"</span><span class='fc89 f-s-15 pb6 pl5'>월 총 청구요금</span></span></td>";  
									Html = Html + "<td class='f30 fc-red tar pt20' colspan='2'>"+addcomma(val["amount"])+"<span class='f16 fc66 pl4'>&nbsp;원</span>"+"</td></tr>"
									Html = Html + "<tr><td colspan='4' class='f14 t-in16 fb'>기본자원</td></tr>";
								}else{
									Html="<tr class='bt2'><td class='f18 fbold fcb' colspan='2'>"+val["projectAlias"]+'<span class="fc00">(요금상세내역)</span><br><span class="circle-b">'+billM+"</span><span class='fc89 f-s-15 pb6 pl5'>월 총 청구요금</span></td>";  
									Html = Html + "<td class='f30 fc-red tar pt20' colspan='2'>"+addcomma(val["amount"])+"<span class='f16 fc66 pl4'>&nbsp;원</span>"+"</td></tr>"
									Html = Html + "<tr><td colspan='4' class='f14 t-in16 fb'>기본자원</td></tr>";
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
												Html = Html + "<tr class='fbold' style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>"+val["hostnameAlias"]+" ("+val["hostname"]+")"+"</td>";
												if(hourlyFlag=="N"){
													Html = Html + "<td>월단위</td>";
												}else{
													Html = Html + "<td>시간단위</td>";
												}
												Html = Html + "<td>"+ val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
												Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
											
												$.each(vmResourceList,function(key,val){
													var resourceId = val["resourceId"];
													if(vmUuid == resourceId){
														var measuerValue = Number(val["measureValue"]);
														
														Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
														if(val["resourceItem"]=="CPU"){
															Html = Html + "<td class='f12'>"+measuerValue+ " vCPU</td>";
														}else if(val["resourceItem"]=="MEMORY"){
															Html = Html + "<td class='f12'>"+measuerValue+ " GB</td>";
														}else if(val["resourceItem"]=="DISK"){
															Html = Html + "<td class='f12'>"+measuerValue+ " GB</td>";
														}	
														Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
														Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
													}
												});
											}
										}
									});
								}//<--기본자원 자원 끝
								
								//-->부가자원 자원 시작
								if(val["projectAlias"]!=""){
									Html = Html + "<tr><td colspan='4' class='f14 t-in16 fb'>부가자원</td>";
								}
								
								//블록디스크
								if(diskResourceList!=""){
									$.each(diskResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var hourlyFlag = val["hourlyFlag"];
										if(projectId1==projectId2){
											Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>블록디스크"+" ("+val["diskAlias"]+")"+"</td>";
											if(hourlyFlag=="N"){
												Html = Html + "<td>월단위</td>";
											}else{
												Html = Html + "<td>시간단위</td>";
											}
											Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
											Html = Html + "<td class='f12'>"+measuerValue+ " GB</td>";
												
											Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
			
											
										}
									});
								}
								//NAS
								if(nasResourceList!=""){
									$.each(nasResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var hourlyFlag = val["hourlyFlag"];
										if(projectId1==projectId2){
											Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>NAS</td>";
											if(hourlyFlag=="N"){
												Html = Html + "<td>월단위</td>";
											}else{
												Html = Html + "<td>시간단위</td>";
											}
											Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
											Html = Html + "<td class='f12'>"+measuerValue+ " GB</td>";
												
											Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
			
											
										}
									});
								}
								//공인IP
								if(ipResourceList!=""){
									$.each(ipResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var hourlyFlag = val["hourlyFlag"];
										if(projectId1==projectId2){
											Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>공인IP</td>";
											if(hourlyFlag=="N"){
												Html = Html + "<td>월단위</td>";
											}else{
												Html = Html + "<td>시간단위</td>";
											}
											Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
											Html = Html + "<td class='f12'>"+measuerValue+ " EA</td>";
												
											Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
			
											
										}
									});
								}
								//로드밸런서
								if(loadbalancerResourceList!=""){
									$.each(loadbalancerResourceList, function(key,val){
										var projectId2 = val["projectId"];
										var hourlyFlag = val["hourlyFlag"];
										if(projectId1==projectId2){
											Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>로드밸런서</td>";
											if(hourlyFlag=="N"){
												Html = Html + "<td>월단위</td>";
											}else{
												Html = Html + "<td>시간단위</td>";
											}
											Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
											
											var measuerValue = Number(val["measureValue"]);
											
											Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
											Html = Html + "<td class='f12'>"+measuerValue+ " EA</td>";
												
											Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
										}
									});
								}
								//<--부가자원 자원 끝
								
								//-->서비스 자원 시작
								if(val["projectAlias"]!=""){
									Html = Html + "<tr><td colspan='4' class='f14 t-in16 fb'>서비스</td>";
								}
								//백업서비스
			// 					Html = Html + "<tr><td class='f14 t-in16 fb'>서비스</td>";
								if(backupResourceList!=""){
									$.each(backupResourceList, function(key,val){
										var hourlyFlag = val["hourlyFlag"];
										var projectId2 = val["projectId"];
										if(projectId1==projectId2){
											Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>백업관리</td>";
											if(hourlyFlag=="N"){
												Html = Html + "<td>월단위</td>";
											}else{
												Html = Html + "<td>시간단위</td>";
											}
		// 									Html = Html + "<td>월단위</td>";
											Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
											
											var measuerValue = Number(val["measureValue"]);
											Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
											Html = Html + "<td class='f12'>"+measuerValue+ "GB</td>";
											Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
										}
									});
								}
								//대외계
								if(mcaResourceList!=""){
									$.each(mcaResourceList, function(key,val){
										var hourlyFlag = val["hourlyFlag"];
										var projectId2 = val["projectId"];
										if(projectId1==projectId2){
											Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>대외계 서비스</td>";
											if(hourlyFlag=="N"){
												Html = Html + "<td>월단위</td>";
											}else{
												Html = Html + "<td>시간단위</td>";
											}
		// 									Html = Html + "<td>월단위</td>";
											Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
											
											var measuerValue = Number(val["measureValue"]);
											Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
											Html = Html + "<td class='f12'>"+measuerValue+ " 식</td>";
											Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
										}
									});
								}
								//형상관리
								if(scmResourceList!=""){
									$.each(scmResourceList, function(key,val){
										var hourlyFlag = val["hourlyFlag"];
										var projectId2 = val["projectId"];
										if(projectId1==projectId2){
											Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>형상관리 서비스</td>";
											if(hourlyFlag=="N"){
												Html = Html + "<td>월단위</td>";
											}else{
												Html = Html + "<td>시간단위</td>";
											}
		// 									Html = Html + "<td>월단위</td>";
											Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
											
											var measuerValue = Number(val["measureValue"]);
											Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
											Html = Html + "<td class='f12'>"+measuerValue+ " 식</td>";
											Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
										}
									});
								}
								//보안관제
								if(securityResourceList!=""){
									$.each(securityResourceList, function(key,val){
										var hourlyFlag = val["hourlyFlag"];
										var projectId2 = val["projectId"];
										if(projectId1==projectId2){
											Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>보안관제 서비스</td>";
											if(hourlyFlag=="N"){
												Html = Html + "<td>월단위</td>";
											}else{
												Html = Html + "<td>시간단위</td>";
											}
		// 									Html = Html + "<td>월단위</td>";
											Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
											
											var measuerValue = Number(val["measureValue"]);
											Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
											Html = Html + "<td class='f12'>"+measuerValue+ " 식</td>";
											Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
										}
									});
								}
								//<--서비스 자원 끝
								
								
								//요금할인
								if(val["projectAlias"]!=""){
									Html = Html + "<tr><td colspan='4' class='f14 t-in16 fb'>요금할인</td>";
								}
								if(dcAdList!=""){
									$.each(dcAdList, function(key,val){
										var projectId2 = val["projectId"];
										if(projectId1==projectId2 && val["invoiceItem"]=="EA00"){
											Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>프로젝트 할인</td>";
											Html = Html + "<td colspan='2'></td>";
											Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
										}
										if(projectId1==projectId2 && val["invoiceItem"]=="EL00"){
											Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>10원미만 절사 할인</td>";
											Html = Html + "<td colspan='2'></td>";
											Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
											
										}
									});
								}
								
								//보정
								if(val["projectAlias"]!=""){
									Html = Html + "<tr><td colspan='4' class='f14 t-in16 fb'>보정</td>";
								}
								if(dcAdList!=""){
									$.each(dcAdList, function(key,val){
										var projectId2 = val["projectId"];
										if(projectId1==projectId2 && val["invoiceItem"]=="IA00"){
											Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>"+val["invoiceItemName"]+"</td>";
											Html = Html + "<td colspan='2'></td>";
											Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span>&nbsp;원</td></tr>";
										}
									});
								}
								
								
								
								$("#billTable").append(Html);	
							});
						
						}else{
							Html = "<tr><td colspan='4' class='f14 t-in16 fb tac'>상세내역이 없습니다.</td>";
							$("#billTable").append(Html);	
						}
						
						
						
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "error:" + error);
					}
				});
				
			}
			*/
			
			//엑셀 다운로드
			function excelDown(){
				var billYyyymm = $("#h_billYyyymm").val();
				var customerId = $("#h_customerId").val();
				var params = "?billYyyymm="+billYyyymm+"&customerId="+customerId;
				location.href = "${wasPath}/mbr/excel/billExcelDown"+params;
			}
			
			
			
			// 청구서 프린트
			function printPage(){
				var popupWindow = window.open("","_blank");
				popupWindow.document.write("<html>");
				popupWindow.document.write("<head>");
				popupWindow.document.write($("head").html());
				popupWindow.document.write("</head>");
				popupWindow.document.write("<body>");
				popupWindow.document.write(document.getElementById("print").innerHTML);
				popupWindow.document.write("</body>");
				popupWindow.document.write("</html>");
				popupWindow.document.close();
				popupWindow.print();
				
			}
			
			//목록페이지 이동
			function movePage(){
				location.href="${contextPath}/mbr/charge/bill/";
			}
			
			function strTrim(str){
				return str.replace(/(^\s*)|(\s*$)/g, "");
			}
			
			$(document).ready(function() {
				
			    App.init();
			    getDetail();
			    
			    
				$("a>button").on('click',function()	{
					location.href = $(this).closest("a").attr("href");
				});
			
				
				function toggleIcon(e) {
					 $(e.target).prev('.panel-heading').find(".more-less").toggleClass('fa-chevron-down fa-chevron-up');
				}
				
				$('.tablebill').on('hidden.bs.collapse',toggleIcon);
				$('.tablebill').on('show.bs.collapse',toggleIcon);
				
				//메뉴활성화
				$("#billMenu").addClass("active");
				$("#bill").addClass("active");
				
			});
		</script>
	</body>
</html>
