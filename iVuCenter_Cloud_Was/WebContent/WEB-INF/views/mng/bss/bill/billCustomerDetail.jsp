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
			<h1 class="page-header fc66 fb"> <i class="fa fa-dot-circle-o fcb"> </i> 청구서 상세 <span class="root">관리자포털 > 요금 > 청구 요금 조회</span></h1>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row mb50">
			<div id="print">
				<input type="hidden" id="h_customerId" value="${customerId}">
				<input type="hidden" id="h_billYyyymm" value="${billYyyymm}">
				<div class="col-md-12"> 
					<%-- 
					<h4 class="mt20 f20 tac" >${year}년 ${month}월 청구서</h4>
					<h5 class="tar">사용기간 : ${billStartDatetime} ~ ${billEndDatetime}</h5>
					<h5 class="tar">회원사 : ${customerName} </h5>
					  --%>
					<div class="tableD mt20">
						<table class="table mb0" id="accordion" >
							<colgroup>
								<col width="*">
								<col width="200px">
							</colgroup>
									
							<tbody id="billTable">
							</tbody>
								
						</table>
					</div>
					
<!-- 					<div class="col-md-12 disk p10 mt5"> -->
<!-- 						<div class="col-md-8 fc66 f24 pr0">총 청구요금</div> -->
<!-- 						<div class="col-md-4 f24 fc-red tar pr0 vm"><span id="totalAmount"></span><span class="f12 fc66 pl4">원</span></div> -->
<!-- 				    </div> -->
				</div>
	
			</div>
			<!---- end page body---->
			
			<div class="col-md-12 tac p20">
				<button class="btn btn-grey" value="목록" onclick="movePage();"><i class="fa fa-reorder"></i> 목록</button>
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
	
	// 청구서 상세
	function getDetail(){
		$.ajax({
			url : "${contextPath}/mng/charge/bill/billDetailList",
// 			dataType : "JSON",
	//			type : "POST",
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
						Html="<tr class='bt2'><td class='f18 fb fcb' colspan='2'>"+val["projectName"]+'<span class="fc00">(요금상세내역)</span><br><span><span class="circle-b">'+billM+"</span><span class='fc89 f-s-15 pb6'>월 총 청구요금</span></span></td>";  
						Html = Html + "<td class='f30 fc-red tar pt20' colspan='2'>"+addcomma(val["amount"])+"<span class='f16 fc66 pl4'> 원</span>"+"</td></tr>"
						Html = Html + "<tr><td colspan='4' class='f14 t-in16 fb'>기본자원</td></tr>";
					}else{
						Html="<tr class='bt2'><td class='f18 fb fcb' colspan='2'>"+val["projectAlias"]+'<span class="fc00">(요금상세내역)</span><br><span class="circle-b">'+billM+"</span><span class='fc89 f-s-15 pb6'>월 총 청구요금</span></td>";  
						Html = Html + "<td class='f30 fc-red tar pt20' colspan='2'>"+addcomma(val["amount"])+"<span class='f16 fc66 pl4'> 원</span>"+"</td></tr>"
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
									Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>"+val["hostnameAlias"]+" ("+val["hostname"]+")"+"</td>";
									if(hourlyFlag=="N"){
										Html = Html + "<td>월단위</td>";
									}else{
										Html = Html + "<td>시간단위</td>";
									}
									Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
									Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
								
									$.each(vmResourceList,function(key,val){
										var resourceId = val["resourceId"];
										if(vmUuid == resourceId){
											var measuerValue = Number(val["measureValue"]);
											
											Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
											if(val["resourceItem"]=="CPU"){
												Html = Html + "<td class='f12'>"+measuerValue+ " Core</td>";
											}else if(val["resourceItem"]=="MEMORY"){
												Html = Html + "<td class='f12'>"+measuerValue+ " GB</td>";
											}else if(val["resourceItem"]=="DISK"){
												Html = Html + "<td class='f12'>"+measuerValue+ " GB</td>";
											}	
											Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
											Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
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
								Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>블록디스크</td>";
								if(hourlyFlag=="N"){
									Html = Html + "<td>월단위</td>";
								}else{
									Html = Html + "<td>시간단위</td>";
								}
								Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
								
								var measuerValue = Number(val["measureValue"]);
								
								Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
								Html = Html + "<td class='f12'>"+measuerValue+ " GB</td>";
									
								Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";

								
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
								Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
								
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
								Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
								
								var measuerValue = Number(val["measureValue"]);
								
								Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
								Html = Html + "<td class='f12'>"+measuerValue+ " EA</td>";
									
								Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";

								
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
								Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
								
								var measuerValue = Number(val["measureValue"]);
								
								Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
								Html = Html + "<td class='f12'>"+measuerValue+ " EA</td>";
									
								Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
							}
						});
					}
					//<--부가자원 자원 끝
					
					//-->서비스 자원 시작
					if(val["projectAlias"]!=""){
						Html = Html + "<tr><td colspan='4' class='f14 t-in16 fb'>서비스</td>";
					}
					//백업서비스
					if(backupResourceList!=""){
						$.each(backupResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2){
								Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>백업서비스</td>";
								Html = Html + "<td>월단위</td>";
								Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
								
								var measuerValue = Number(val["measureValue"]);
								Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
								Html = Html + "<td class='f12'>"+measuerValue+ "GB</td>";
								Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
							}
						});
					}
					//대외계
					if(mcaResourceList!=""){
						$.each(mcaResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2){
								Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>대외계 서비스</td>";
								Html = Html + "<td>월단위</td>";
								Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
								
								var measuerValue = Number(val["measureValue"]);
								Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
								Html = Html + "<td class='f12'>"+measuerValue+ " 식</td>";
								Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
							}
						});
					}
					//형상관리
					if(scmResourceList!=""){
						$.each(scmResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2){
								Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>형상관리 서비스</td>";
								Html = Html + "<td>월단위</td>";
								Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
								
								var measuerValue = Number(val["measureValue"]);
								Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
								Html = Html + "<td class='f12'>"+measuerValue+ " 식</td>";
								Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
							}
						});
					}
					//보안관제
					if(securityResourceList!=""){
						$.each(securityResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1==projectId2){
								Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>보안관제 서비스</td>";
								Html = Html + "<td>월단위</td>";
								Html = Html + "<td>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
								
								var measuerValue = Number(val["measureValue"]);
								Html = Html + "<tr><td class='f12 t-in56'>"+val["resourceItem"]+"</td>";
								Html = Html + "<td class='f12'>"+measuerValue+ " 식</td>";
								Html = Html + "<td class='f12'>"+val["chargeStartDatetime"]+" ~ "+val["chargeEndDatetime"]+"</td>";
								Html = Html + "<td class='tar'><span class='fc66 f14 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
							}
						});
					}
					//<--부가자원 자원 끝
					
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
								Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
							}
							if(projectId1==projectId2 && val["invoiceItem"]=="EL00"){
								Html = Html + "<tr style='background: #f7FcFd !important;'><td class='f14 t-in30 fb'>10원미만 절사 할인</td>";
								Html = Html + "<td colspan='2'></td>";
								Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
								
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
								Html = Html + "<td class='tar'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
							}
						});
					}
					$("#billTable").append(Html);	
				});
				
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
		
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
		location.href="${contextPath}/mng/charge/bill/";
	}
	
	function strTrim(str){
		return str.replace(/(^\s*)|(\s*$)/g, "");
	}
	
	$(document).ready(function() {
		
	    App.init();
	    getDetail();
	    
		$("a>button").on('click',function(){
			location.href = $(this).closest("a").attr("href");
		});
	
		//메뉴활성화
		$("#billMenu").addClass("active");
		$("#bill").addClass("active");
		
	});
	
</script>

</body>
</html>
