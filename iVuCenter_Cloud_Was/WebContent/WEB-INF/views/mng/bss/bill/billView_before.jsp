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
	<title>iVuCenter Cloud portal System</title>
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
				<h1>청구요금 상세</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">요금조회</a><a href="#" class="on">청구요금</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				
				<input type="hidden" id="h_customerId" value="${customerId}">
				<input type="hidden" id="h_projectId"  value="${projectId}">
				<input type="hidden" id="h_billYyyymm" value="${billYyyymm}">
				
				<div class="client_DetailBg">
					<div class="client_DetailArea" id="billDiv"></div>
				</div>

				
				<h4 class="mt50"> ============여기서 부터 새로운 화면 입니다. 적용 후 이 태그  h4 태그 는 지워주기 바랍니다. ===================</h4>
				
				<div class="viewbox">
				    
				 		 	
				 	<ul class="dpin w100">
				 		<li class="dpin w10"><span class="pid">SAM4281</span></li><li class="dpin w55"><h3 class="fc11 f20 mt0 pl0"><span class="ml30">ERP 차세대 웹서버 </span></h3></li>
				 	   <li class="dpin w15 f18 tar">2019년 8월 이용요금  </li><li class="fc_red f30 tar db flr dpin w20">881,300,000<span class="f20 fc66">원</span></li>
				 	</ul>
				</div>
				<table class="tablebill mt20">
							<colgroup>
								<col width="20%">
								<col width="8%">
								<col width="*">
								<col width="20%">
								<col width="5%">
							</colgroup>
					<thead>
						<tr>
						<th>기본자원(가상서버)</th><th colspan="4" class="f18 fc11 tar pr100">741,751,173 <span class="f14 fc66">원</span></th>
						</tr>
					</thead>
					<tbody>
						<tr data-toggle="collapse" data-parent="#accordion" href="#server_01" class="panel-heading">
							<td class="fc_dblue f16 fb">ERP차세대 웹서버 </td>
							<td>월</td>
							<td>2019-08-01 12:00 ~ 2019-10-30 18:00</td>
							<td class="f18 fc_dblue tar pr20"> 217,531,531 <span class="f14 fc66">원</span></td>
							<td><i class="more-less fa fa-chevron-down pull-right"></i>
							</td>
						</tr>
						<tr id="server_01" class="panel-collapse collapse">
						   <td colspan="5">
								<table class="bill_grey">
									<colgroup>
									<col width="20%">
									<col width="8%">
									<col width="*">
									<col width="20%">
									<col width="5%">
									</colgroup>
								<tbody>
								<tr>
							    <td>CPU</td><td>1 Core</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 217,000,000 <span class="f14 fc66">원</span></td>
							    </tr>
							    <tr>
							    <td>MEMORY</td><td>1 GB</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 531,000 <span class="f14 fc66">원</span></td>
							    </tr>
							     <tr>
							    <td>DISK</td><td>1 GB</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 531 <span class="f14 fc66">원</span></td>
							    </tr>
							    </tbody>
							    </table>
						   </td>
						</tr>
						<tr data-toggle="collapse" data-parent="#accordion" href="#server_02" class="panel-heading">
							<td class="fc_dblue f16 fb">ERP차세대 웹WEB SERVER서버 </td>
							<td>월</td>
							<td>2019-08-01 12:00 ~ 2019-10-30 18:00</td>
							<td class="f18 fc_dblue tar pr20"> 524,219,642 <span class="f14 fc66">원</span></td>
							<td><i class="more-less fa fa-chevron-down pull-right"></i></td>
						</tr>
						<tr id="server_02" class="panel-collapse collapse">
						   <td colspan="5">
								<table class="bill_grey">
									<colgroup>
									<col width="20%">
									<col width="8%">
									<col width="*">
									<col width="20%">
									<col width="5%">
									</colgroup>
								<tbody>
								<tr>
							    <td>CPU</td><td>1 Core</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 642 <span class="f14 fc66">원</span></td>
							    </tr>
							    <tr>
							    <td>MEMORY</td><td>1 GB</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 524,000,000 <span class="f14 fc66">원</span></td>
							    </tr>
							     <tr>
							    <td>DISK</td><td>1 GB</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 219,000 <span class="f14 fc66">원</span></td>
							    </tr>
							    </tbody>
							    </table>
						   </td>
						</tr>
					</tbody>
				</table>
				
				<table class="tablebill mt20">
							<colgroup>
								<col width="20%">
								<col width="8%">
								<col width="*">
								<col width="20%">
								<col width="5%">
							</colgroup>
					<thead>
						<tr>
						<th>부가자원 (블록디스크)</th><th colspan="4" class="f18 fc11 tar pr100">741,532,173 <span class="f14 fc66">원</span></th>
						</tr>
					</thead>
					<tbody>
						<tr data-toggle="collapse" data-parent="#accordion" href="#disk_01" class="panel-heading">
							<td class="fc_dblue f16 fb">블록디스크</td>
							<td>월</td>
							<td>2019-08-01 12:00 ~ 2019-10-30 18:00</td>
							<td class="f18 fc_dblue tar pr20"> 217,531,531 <span class="f14 fc66">원</span></td>
							<td><i class="more-less fa fa-chevron-down pull-right"></i></td>
						</tr>
						<tr id="disk_01" class="panel-collapse collapse">
						   <td colspan="5">
								<table class="bill_grey">
									<colgroup>
									<col width="20%">
									<col width="8%">
									<col width="*">
									<col width="20%">
									<col width="5%">
									</colgroup>
								<tbody>
								<tr>
							    <td>내가 신청한 블록디스크 이름 </td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 217,000,000 <span class="f14 fc66">원</span></td>
							    </tr>
							    <tr>
							    <td>내가 신청한 블록디스크 이름2</td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 531,000 <span class="f14 fc66">원</span></td>
							    </tr>
							     <tr>
							    <td>내가 신청한 블록디스크 이름3</td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 531 <span class="f14 fc66">원</span></td>
							    </tr>
							    </tbody>
							    </table>
						   </td>
						</tr>
						<tr data-toggle="collapse" data-parent="#accordion" href="#disk_02" class="panel-heading">
							<td class="fc_dblue f16 fb">블록디스크33  </td>
							<td>월</td>
							<td>2019-08-01 12:00 ~ 2019-10-30 18:00</td>
							<td class="f18 fc_dblue tar pr20"> 524,000,642 <span class="f14 fc66">원</span></td>
							<td><i class="more-less fa fa-chevron-down pull-right"></i></td>
						</tr>
						<tr id="disk_02" class="panel-collapse collapse">
						   <td colspan="5">
								<table class="bill_grey">
									<colgroup>
									<col width="20%">
									<col width="8%">
									<col width="*">
									<col width="20%">
									<col width="5%">
									</colgroup>
								<tbody>
								<tr>
							    <td>내가 신청한 블록디스크 이름 </td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 642 <span class="f14 fc66">원</span></td>
							    </tr>
							    <tr>
							    <td>내가 신청한 블록디스크 이름33333 </td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 524,000,000 <span class="f14 fc66">원</span></td>
							    </tr>
							    
							    </tbody>
							    </table>
						   </td>
						</tr>
					</tbody>
				</table>
				
				
				
				<table class="tablebill mt20">
							<colgroup>
								<col width="20%">
								<col width="8%">
								<col width="*">
								<col width="20%">
								<col width="5%">
							</colgroup>
					<thead>
						<tr>
						<th>서비스 자원 </th><th colspan="4" class="f18 fc11 tar pr100">741,532,173 <span class="f14 fc66">원</span></th>
						</tr>
					</thead>
					<tbody>
						<tr data-toggle="collapse" data-parent="#accordion" href="#service_01"  class="panel-heading">
							<td class="fc_dblue f16 fb">계정관리</td>
							<td>월</td>
							<td>2019-08-01 12:00 ~ 2019-10-30 18:00</td>
							<td class="f18 fc_dblue tar pr20"> 217,531,531 <span class="f14 fc66">원</span></td>
							<td><i class="more-less fa fa-chevron-down pull-right"></i></td>
						</tr>
						<tr id="service_01" class="panel-collapse collapse">
						   <td colspan="5">
								<table class="bill_grey">
									<colgroup>
									<col width="20%">
									<col width="8%">
									<col width="*">
									<col width="20%">
									<col width="5%">
									</colgroup>
								<tbody>
								<tr>
							    <td>계정관리  이름 </td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 217,000,000 <span class="f14 fc66">원</span></td>
							    </tr>
							    <tr>
							    <td>계정관리 서비스  이름2</td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 531,000 <span class="f14 fc66">원</span></td>
							    </tr>
							     <tr>
							    <td>계정관리  이름3</td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 531 <span class="f14 fc66">원</span></td>
							    </tr>
							    </tbody>
							    </table>
						   </td>
						</tr>
						<tr data-toggle="collapse" data-parent="#accordion" href="#service_02"  class="panel-heading">
							<td class="fc_dblue f16 fb">보안관제  </td>
							<td>월</td>
							<td>2019-08-01 12:00 ~ 2019-10-30 18:00</td>
							<td class="f18 fc_dblue tar pr20"> 524,000,642 <span class="f14 fc66">원</span></td>
							<td><i class="more-less fa fa-chevron-down pull-right"></i></td>
						</tr>
						<tr id="service_02" class="panel-collapse collapse">
						   <td colspan="5">
								<table class="bill_grey">
									<colgroup>
									<col width="20%">
									<col width="8%">
									<col width="*">
									<col width="20%">
									<col width="5%">
									</colgroup>
								<tbody>
								<tr>
							    <td>보안관제이름 </td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 642 <span class="f14 fc66">원</span></td>
							    </tr>
							    <tr>
							    <td>보안관제  이름33333 </td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 524,000,000 <span class="f14 fc66">원</span></td>
							    </tr>
							    
							    </tbody>
							    </table>
						   </td>
						</tr>
						<tr data-toggle="collapse" data-parent="#accordion" href="#service_03"  class="panel-heading">
							<td class="fc_dblue f16 fb">백업  </td>
							<td>월</td>
							<td>2019-08-01 12:00 ~ 2019-10-30 18:00</td>
							<td class="f18 fc_dblue tar pr20"> 524,000,642 <span class="f14 fc66">원</span></td>
							<td><i class="more-less fa fa-chevron-down pull-right"></i></td>
						</tr>
						<tr id="service_03" class="panel-collapse collapse">
						   <td colspan="5">
								<table class="bill_grey">
									<colgroup>
									<col width="20%">
									<col width="8%">
									<col width="*">
									<col width="20%">
									<col width="5%">
									</colgroup>
								<tbody>
								<tr>
							    <td>보안관제이름 </td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 642 <span class="f14 fc66">원</span></td>
							    </tr>
							    <tr>
							    <td>보안관제  이름33333 </td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 524,000,000 <span class="f14 fc66">원</span></td>
							    </tr>
							    
							    </tbody>
							    </table>
						   </td>
						</tr>
						<tr data-toggle="collapse" data-parent="#accordion" href="#service_04"  class="panel-heading">
							<td class="fc_dblue f16 fb">SW 설치  </td>
							<td>월</td>
							<td>2019-08-01 12:00 ~ 2019-10-30 18:00</td>
							<td class="f18 fc_dblue tar pr20"> 524,000,642 <span class="f14 fc66">원</span></td>
							<td><i class="more-less fa fa-chevron-down pull-right"></i></td>
						</tr>
						<tr id="service_04" class="panel-collapse collapse">
						   <td colspan="5">
								<table class="bill_grey">
									<colgroup>
									<col width="20%">
									<col width="8%">
									<col width="*">
									<col width="20%">
									<col width="5%">
									</colgroup>
								<tbody>
								<tr>
							    <td>보안관제이름 </td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 642 <span class="f14 fc66">원</span></td>
							    </tr>
							    <tr>
							    <td>보안관제  이름33333 </td><td>월</td><td>2019-08-01 12:00 ~ 2019-10-30 18:00</td><td colspan="2" class="f18 fc33 tar pr88"> 524,000,000 <span class="f14 fc66">원</span></td>
							    </tr>
							    
							    </tbody>
							    </table>
						   </td>
						</tr>
					</tbody>
				</table>

				<!-- 여기가 끝  -->
				
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

	$(document).ready(function() {
	    App.init();
	    getDetail();
		
		$('.tablebill').on('hidden.bs.collapse',toggleIcon);
		$('.tablebill').on('show.bs.collapse',toggleIcon);
	
		//메뉴활성화
		$("#priceInquiry").addClass("active");
		$("#bill").addClass("active");
		
	});
	
	function toggleIcon(e) {
		$(e.target)
		.prev('.panel-heading')
		.find(".more-less")
		.toggleClass('fa-chevron-down fa-chevron-up');
	}
	
	function moveListPage() {
		location.href = "${contextPath}/mng/charge/bill/";
	}
	
	function strTrim(str){
		return str.replace(/(^\s*)|(\s*$)/g, "");
	}

	//청구서 상세
	function getDetail(){
		$.ajax({
//			url : "${contextPath}/mng/charge/bill/billDetailList",
			url : "${contextPath}/mng/charge/bill/billProjectDetailList",
	//			dataType : "JSON",
	//			type : "POST",
			data : {
				"customerId" : $("#h_customerId").val()
				,"projectId" : $("#h_projectId").val()
				,"billYyyymm" : $("#h_billYyyymm").val()				
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
				
				$("#billDiv").empty();
			
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
						Html += "<div class='billcompBg'>";
						Html += "<h2 class='customer_Id'>"+billY+"-"+billM+"</h2>";
						Html += "<p class='company_Name2' id=''>"+val["projectName"]+"</p>";
						Html += "<p class='company_Info'>"; 
						Html += "	<span class='company_labelf'>구분 :</span><span class='company_cont' id=''>"+val["companyName"]+"</span>";
						Html += "	<span class='company_label'>고객사 :</span><span class='company_cont' id=''>"+val["customerName"]+"</span>";
						Html += "</p>";
						Html += "<div class='detailtotalArea'>";
						Html += "	<p class='f18 fc11 tar m-b-15'>총 청구금액</p>";
						Html += "	<p class='tar'><span class='total fontVdn'>"+addcomma(val["amount"])+"</span><span class='unit'>원</span></p>";
						Html += "</div>"; 
						Html += "</div>";  
						
					}else{
						Html += "<div class='billcompBg'>";
						Html += "<h2 class='customer_Id'>"+billY+"-"+billM+"</h2>";
						Html += "<p class='company_Name2' id=''>"+val["projectAlias"]+"</p>";
						Html += "<p class='company_Info'>"; 
						Html += "	<span class='company_labelf'>구분 :</span><span class='company_cont' id=''>"+val["companyName"]+"</span>";
						Html += "	<span class='company_label'>고객사 :</span><span class='company_cont' id=''>"+val["customerName"]+"</span>";
						Html += "</p>";
						Html += "<div class='detailtotalArea'>";
						Html += "	<p class='f18 fc11 tar m-b-15'>총 청구금액</p>";
						Html += "	<p class='tar'><span class='total fontVdn'>"+addcomma(val["amount"])+"</span><span class='unit'>원</span></p>";
						Html += "</div>"; 
						Html += "</div>";  
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
						
						Html += "	<h2 class='titleBuType01 m-b-15'>클라우드 자원 상세내역</h2>";
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
							Html += "<div class='billBox'>";
							Html += "	<dl>";
							Html += "		<dt>부가 자원</dt>";
							Html += "		<dd><strong class='fontVdn'>"+addcomma(subTot)+"</strong>&nbsp;원</dd>";
							Html += "	</dl>";
							
							Html += "	<div class='billBoxList'>";
							Html += "		<ul class='depth1'>";	
						}else{
							Html += "<div class='billBox'>";
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
								
								Html += "<li class='depth1Li active'>";	
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
								
								Html += "<li class='depth1Li active'>";	
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
								
								Html += "<li class='depth1Li active'>";	
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
								
								Html += "<li class='depth1Li active'>";	
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
					if(backupResourceList != ""){
						$.each(backupResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1 == projectId2){
								srvTot += Number(val["amount"]);
							}
						});
					}	
					if(mcaResourceList != ""){
						$.each(mcaResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1 == projectId2){
								srvTot += Number(val["amount"]);
							}
						});
					}	
					if(scmResourceList != ""){
						$.each(scmResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1 == projectId2){
								srvTot += Number(val["amount"]);
							}
						});
					}	
					if(securityResourceList != ""){
						$.each(securityResourceList, function(key,val){
							var projectId2 = val["projectId"];
							if(projectId1 == projectId2){
								srvTot += Number(val["amount"]);
							}
						});
					}
					
					if(backupResourceList !="" || mcaResourceList !="" || scmResourceList !="" || securityResourceList !=""){
						var projectId2 = "";
						$.each(backupResourceList, function(key,val){
							projectId2 = val["projectId"];
						});
						$.each(mcaResourceList, function(key,val){
							projectId2 = val["projectId"];
						});
						$.each(scmResourceList, function(key,val){
							projectId2 = val["projectId"];
						});
						$.each(securityResourceList, function(key,val){
							projectId2 = val["projectId"];
						});
						
						if(projectId1 == projectId2){
							Html += "<div class='billBox'>";
							Html += "	<dl>";
							Html += "		<dt>서비스</dt>";
							Html += "		<dd><strong class='fontVdn'>"+addcomma(srvTot)+"</strong>&nbsp;원</dd>";
							Html += "	</dl>";
							
							Html += "	<div class='billBoxList'>";
							Html += "		<ul class='depth1'>";	
						}else{
							Html += "<div class='billBox'>";
							Html += "	<dl>";
							Html += "		<dt>서비스</dt>";
							Html += "		<dd><strong class='fontVdn'>0</strong>&nbsp;원</dd>";
							Html += "	</dl>";
							
							Html += "	<div class='billBoxList'>";
							Html += "		<ul class='depth1'>";
						}
					}
					
					
					//백업서비스
					if(backupResourceList!=""){
						$.each(backupResourceList, function(key,val){
							var projectId2 = val["projectId"];
							var hourlyFlag = val["hourlyFlag"];
							if(projectId1==projectId2){
								var measuerValue = Number(val["measureValue"]);
								
								Html += "<li class='depth1Li active'>";	
								Html += "	<div class='depth1Header'>";
								Html += "		<strong class='productName'>백업 서비스</strong>";
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
					//대외계
					if(mcaResourceList!=""){
						$.each(mcaResourceList, function(key,val){
							var projectId2 = val["projectId"];
							var hourlyFlag = val["hourlyFlag"];
							if(projectId1==projectId2){
								var measuerValue = Number(val["measureValue"]);
								
								Html += "<li class='depth1Li active'>";	
								Html += "	<div class='depth1Header'>";
								Html += "		<strong class='productName'>대외계 서비스</strong>";
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
								Html += "				<span class='productSize fontVdn'>"+measuerValue+" 식</span>";
								Html += "				<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "				<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
								Html += "			</li>";
								Html += "		</ul>";
								Html += "	</div>";
								Html += "</li>";
							}
						});
					}
					//형상관리
					if(scmResourceList!=""){
						$.each(scmResourceList, function(key,val){
							var projectId2 = val["projectId"];
							var hourlyFlag = val["hourlyFlag"];
							if(projectId1==projectId2){
								var measuerValue = Number(val["measureValue"]);
								
								Html += "<li class='depth1Li active'>";	
								Html += "	<div class='depth1Header'>";
								Html += "		<strong class='productName'>형상관리 서비스</strong>";
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
								Html += "				<span class='productSize fontVdn'>"+measuerValue+" 식</span>";
								Html += "				<span class='period fontVdn'>"+val["chargeStartDatetime"]+"~"+val["chargeEndDatetime"]+"</span>";
								Html += "				<span class='price'><em class='fontVdn'>"+addcomma(val["amount"])+"</em>&nbsp;원</span>";
								Html += "			</li>";
								Html += "		</ul>";
								Html += "	</div>";
								Html += "</li>";
							}
						});
					}
					//보안관제
					if(securityResourceList!=""){
						$.each(securityResourceList, function(key,val){
							var projectId2 = val["projectId"];
							var hourlyFlag = val["hourlyFlag"];
							if(projectId1==projectId2){
								var measuerValue = Number(val["measureValue"]);
								
								Html += "<li class='depth1Li active'>";	
								Html += "	<div class='depth1Header'>";
								Html += "		<strong class='productName'>보안관제 서비스</strong>";
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
								Html += "				<span class='productSize fontVdn'>"+measuerValue+" 식</span>";
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
					
					if(backupResourceList !="" || mcaResourceList !="" || scmResourceList !="" || securityResourceList !=""){
						Html += "		</ul>";
						Html += "	</div>";
						Html += "</div>";
					}
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
					
					
					Html += "<div class='billtotalArea m-t-20'>";
					Html += "	<span class='fl f24 fc11 m-t-37'>총 합계</span>";
					Html += "	<div class='flr tar f24 fc66  m-t-30'>";
					Html += "		<p class='m-b-5'>";
					Html += "			<em class=''>"+addcomma(total)+"</em>";
					Html += "			원";
					Html += "		</p>";
					Html += "	</div>";
					Html += "</div>";
					
					Html += "</div>";
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
	
	
</script>

</body>
</html>
