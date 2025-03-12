<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		
		
		<!-- begin #content -->
		<div id="content" class="content">
		
			<!-- begin header -->
			<h1 class="page-header"><span class="root"> <span class="home"></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow mint"><a href="${wasPath}/mbr/charge/bill/view"><strong>청구서</strong></a></span></span></h1>
			<!-- end header -->
			
			<div class="row mb50" id="print">
				<p class="page_title"><span class="stick">이</span>용요금 상세 </p>
				
				
				
					<div class="billWrapper" >
						<div class="billHeaderType01">
							
							<input type="hidden" id="h_cloudId" value="${cloudId}">
							<input type="hidden" id="h_customerId" value="${customerId}">
							<input type="hidden" id="h_billYyyymm" value="${billYyyymm}">
							<input type="hidden" id="h_get3MonthAmount" value="${get3MonthAmountList}">
							<input type="hidden" id="h_get3Yyyymm" value="">
							
							
							
							<div class="billTitle">
								<strong><em class="nanumR" id="billYear"></em>년 <em class="nanumR" id="billMonth"></em>월 <span id="billTitle">청구서</span> </strong><a type="button" class="btn_calendar" id="startDate"><i></i><input type="text" id="billDate"></a>
								<a type="button" class="btn btn_prev" onclick="movePrev();" id="btnPrevOk"><i></i></a>
								<a type="button" class="btn btn_prev" id="btnPrevNo" style="display: none;"><i></i></a>
								<a type="button" class="btn btn_next" onclick="moveNext();" id="btnNextOk"><i></i></a>
								<a type="button" class="btn btn_next" id="btnNextNo" style="display: none;"><i></i></a>
							</div>
							
							<div class="billDashboard" id="billDashboard1">
								<div class="box">
									<dl class="totalPrice">
										<dt>총 청구금액</dt>
										<dd class="price"><strong class="nanumR" id="totalAmount"></strong>&nbsp;원</dd>
										<dd class="period">사용기간 : <em class="nanumR"><span id="billStartDatetime"></span> ~ <span id="billEndDatetime"></span></em></dd>
	<!-- 									<dd class="period">사용기간 : <em class="nanumR">2017-09-01~2017-09-30</em></dd> -->
									</dl>
								</div>
								<div class="box">
									<dl class="ThreeMonth">
										<dt>최근 3개월</dt>
										<dd class="grephArea" id="divCharts" >
	<!-- 									<div id="divCharts"></div> -->
	<!-- 											<img alt="" src="/resources/assets/img/chart02.png"> -->
										</dd>
										<dd class="graphFigure">
											<p class="horizontal_chart1_label2"><span id="monthAmount0"></span> 원</p>
											<p class="horizontal_chart1_label2"><span id="monthAmount1"></span> 원</p>
											<p class="horizontal_chart1_label2"><span id="monthAmount2"></span> 원</p>
											<br/>
										</dd>
									</dl>
								</div>
							</div>
	
							<div class="billDashboard" id="billDashboard2" style="display: none;">
	
							</div>
						</div>
						<div class="billContents">
							
							<div class="billCntType01">
								<div class="billBox" id="billBox1"></div>
								<div class="billBox" id="billBox2"></div>
								<div class="billBox" id="billBox3"></div>
								<div class="vatBox" id="vatBox1"></div>
								
						
								
								<div class="btnArea" id="btnArea">
								<a type="button"  onclick="printPage();"><span> <i class="fa fa-print"></i> 인쇄</span></a>
								<a type="button"  onclick="moveDetailPage();"><i class="fa fa-search"></i><span>상세</span></a>
							   </div>
							</div>
							
						</div>	
					</div>
					
				
					
					<div class="btn_area">		
					<a type="button" class="bbton bton_blue" onclick="movePage();"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-list"></i></span><span class="dpin ml16">목록</span></a>                     
				   </div>
					
				</div>
					  <!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->		
			</div>
			
	           
		</div>
	
			<!-- end #content -->
			
		<!-- end page container -->
		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">
		
		function monthCalendar(){
			var currentYear = (new Date()).getFullYear();
			var currentMonth = (new Date()).getMonth();
		    var startYear = currentYear-10;
		    var options = {
		    		selectedMonth : currentMonth+1, 
		    		startYear: startYear,
		            finalYear: currentYear,
		            pattern: 'yyyymm',
		            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		           
		    };
		
		    $('#billDate').monthpicker(options);
		  	
			$('#startDate').bind('click', function () {
				$('#billDate').monthpicker('show');
			});
		    //onchange
			$("#billDate").monthpicker().on("change", function(e){
				$("#h_billYyyymm").val($(this).val());
				getDetail();
			});
		}
		
			// 청구서 상세
			function getDetail(){
				
		// 		var yy = $("#billYear option:selected").val();
		// 		var mm = $("#billMonth option:selected").val();
		// 		var billYyyymm = yy+mm;
				var billYyyymm = $("#h_billYyyymm").val();
				
				var currentYear = (new Date()).getFullYear();
				var currentYear2 = (new Date()).getFullYear()+1;
				var currentMonth = (new Date()).getMonth()+1;
				var currentMonth2 = (new Date()).getMonth()+2;
				currentMonth = currentMonth.toString();
				currentYear = currentYear.toString();
				if(currentMonth.length < 2){
					currentMonth = "0"+currentMonth;
				}
				//페이지 진입경로구분
				if("${fromPage}" == "customerView"){
					$("#btnPrevOk").hide();
					$("#btnPrevNo").hide();
					$("#btnNextOk").hide();
					$("#btnNextOk").hide();
		
					$("#startDate").hide();
					$("#billDate").hide();
					
					$("#billTitle").text("예상 청구서");
				}else{
					$("#startDate").show();
					$("#billDate").show();			
					$("#btnPrevOk").show();
					if(currentYm == billYyyymm){
						$("#btnNextOk").hide();
						$("#btnNextNo").show();
					}else{
						$("#btnNextOk").show();
						$("#btnNextNo").hide();
					}
					var currentYm = currentYear+currentMonth;
					
					currentMonth2 = currentMonth2.toString();
					currentYear2 = currentYear2.toString();
					
					if(currentMonth2.length < 2){
						currentMonth2 = "0"+currentMonth2;
					}
					var currentYm2 = currentYear+currentMonth2;
					
					if(currentMonth2 == "01"){
						currentYm2 = currentYear2+currentMonth2;
					}
					
					if(currentYm2 < billYyyymm){
						alertBox3("해당월의 청구내역이 없습니다.");
						
						//화면에 표시된 청구년월로 재구성
						var billym = $("#billYear").text() + $("#billMonth").text(); 
						$("#h_billYyyymm").val(billym);
						
						return false;
					}
					
					if(currentYm2 == billYyyymm){
						$("#billTitle").text("예상 청구서");
					}else{
						$("#billTitle").text("청구서");
					}
					
					
				}
				
				$.ajax({
					url : "${wasPath}/mbr/charge/bill/detail",
					dataType : "JSON",
						type : "POST",
					data : {
						"cloudId" : $("#h_cloudId").val()	
						,"customerId" : $("#h_customerId").val()	
		 				//,"billYyyymm" : $("#h_billYyyymm").val() 
						,"billYyyymm" : billYyyymm
					},
					success : function(data) {
						var billInfoList = data.detail;
						
						var get3MonthAmount = data.get3MonthAmount;
						var get3Yyyymm = data.get3Yyyymm;
						$("#h_get3MonthAmount").val(get3MonthAmount);
						$("#h_get3Yyyymm").val(get3Yyyymm);
						billChart();
					
						var get3MonthList = data.get3MonthList;
						var idx=0;
						$.each(get3MonthList,function(key,val){
							
							$("#monthAmount"+idx).text(addcomma(val["amount"]));
							idx++;
						});
						
						var billStartDate = "";
						var billEndDate = "";
						var customerName = "";
						
						var billYm = $("#h_billYyyymm").val();
						var billY = billYm.substring(0,4);
						var billM = billYm.substring(4,6);
		//		 		$("#billYear").val(billY);
		//		 		$("#billMonth").val(billM);
						$("#billYear").text(billY);
						$("#billMonth").text(billM);
						
						
						$("#billBox1").empty();
						$("#billBox2").empty();
						$("#billBox3").empty();
						$("#billBox2").removeClass("oneLine");
						$("#billBox3").removeClass("oneLine");
						$("#vatBox1").empty();
						$("#totalAmount").text("");
						$("#billStartDatetime").text("");
						$("#billEndDatetime").text("");
						if(billInfoList.length != 0){
							$("#billDashboard1").show();
							$("#billDashboard2").hide();
							
							$("#billBox1").show();
							$("#billBox2").show();
							$("#billBox3").show();
							$("#vatBox1").show();
							
							var Html1 = "";
							
							$.each(billInfoList,function(key,val){
								var billLevel = val["invoiceItem"];
								if(billLevel=="0000"){	//총청구금액
									$("#totalAmount").text(addcomma(val["amount"]));
									billStartDate = val["billStartDatetime"];
									billEndDate = val["billEndDatetime"];
									billStartDate = billStartDate.replace(/\//g, "-");
									billEndDate = billEndDate.replace(/\//g, "-");
									
									$("#billStartDatetime").text(billStartDate);
									$("#billEndDatetime").text(billEndDate);
									
								}else if(billLevel=="A000"){	//클라우드 자원
									Html1 += "<dl class='totalBox'>";
									Html1 += "	<dt> "+val["invoiceItemName"]+"</dt>";
									Html1 += "	<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</dd>";
									Html1 += "</dl>";
									
									Html1 += "<div class='tableBox'>";
									Html1 += "	<table>";
									Html1 += "		<colgroup>";
									Html1 += "			<col width='16%'>";
									Html1 += "			<col width='25%'>";
									Html1 += "			<col width='25%'>";
									Html1 += "		</colgroup>";
									Html1 += "		<tbody>";
								}
		// 						$("#billBox1").append(Html);
							});
							
							
							$.each(billInfoList,function(key,val){
		// 						var Html = "";
								var billLevel = val["invoiceItem"];
								
								if(billLevel=="AA00"){	//기본 자원
									Html1 += "<tr>";
									Html1 += "<th scope='row' class='thType1 borderB p-t-10 p-b-10'> "+val["invoiceItemName"]+"</th>";
								}else if(billLevel=="AAA0"){	//가상 서버
									Html1 += "<td class='productTitle borderB p-t-10 p-b-10'>"+val["invoiceItemName"]+"</td>";
									Html1 += "<td class='price borderB p-t-10 p-b-10'><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
									Html1 += "</tr>";
								}
							});
		// 						$("#billBox1").append(Html1);
							
							
							var rowCnt = 0;
							$.each(billInfoList,function(key,val){
								var billLevel = val["invoiceItem"];
								if(billLevel=="AEA0" || billLevel=="AEB0" || billLevel=="AEC0" || billLevel=="AED0"){
									rowCnt++;
								}
							});
							
						
							$.each(billInfoList,function(key,val){
								var billLevel = val["invoiceItem"];
							
								if(billLevel=="AE00"){	//부가 자원
									Html1 += "<tr>";
									Html1 += "<th scope='row' rowspan='"+rowCnt+"' class='thType1 vat borderB  p-t-10 p-b-10'>"+val["invoiceItemName"]+"</th>";
								}else if(billLevel=="AEA0"){	//블록디스크
									Html1 += "<td class='productTitle borderB p-t-10 p-b-10'>"+val["invoiceItemName"]+"</td>";
									Html1 += "<td class='price borderB p-t-10 p-b-10'><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
									Html1 += "</tr>";
								}else if(billLevel=="AEB0"){	//NAS
									Html1 += "<tr>";
									Html1 += "<td class='productTitle borderB p-t-10 p-b-10'>"+val["invoiceItemName"]+"</td>";
									Html1 += "<td class='price borderB p-t-10 p-b-10'><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
									Html1 += "</tr>";
								}else if(billLevel=="AEC0"){	//로드밸런서
									Html1 += "<tr>";
									Html1 += "<td class='productTitle borderB p-t-10 p-b-10'>"+val["invoiceItemName"]+"</td>";
									Html1 += "<td class='price borderB p-t-10 p-b-10'><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
									Html1 += "</tr>";
								}else if(billLevel=="AED0"){	//공인IP
									Html1 += "<tr>";
									Html1 += "<td class='productTitle borderB  p-t-10 p-b-10'>"+val["invoiceItemName"]+"</td>";
									Html1 += "<td class='price borderB p-t-10 p-b-10'><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
									Html1 += "</tr>";
								}
							});	
		// 					$("#billBox1").append(Html1);
							
							var rowCnt2 = 0;
							$.each(billInfoList,function(key,val){
								var billLevel = val["invoiceItem"];
								if(billLevel=="AIA0" || billLevel=="AIB0" || billLevel=="AIC0" || billLevel=="AID0"){
									rowCnt2++;
								}
							});
							
							$.each(billInfoList,function(key,val){
		// 						var Html = "";
								var billLevel = val["invoiceItem"];
								if(billLevel=="AI00"){	//서비스
									Html1 += "<tr>";
									Html1 += "<th scope='row' rowspan='"+rowCnt2+"' class='thType1 vat p-t-10 p-b-10'>"+val["invoiceItemName"]+"</th>";
								}
								else if(billLevel=="AIA0"){	//백업서비스
									Html1 += "<td class='productTitle  p-t-10 p-b-10'>"+val["invoiceItemName"]+"</td>";
									Html1 += "<td class='price  p-t-10 p-b-10'><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
									Html1 += "</tr>";
								}else if(billLevel=="AIB0"){	//대외계서비스
									Html1 += "<td class='productTitle  p-t-10 p-b-10'>"+val["invoiceItemName"]+"</td>";
									Html1 += "<td class='price  p-t-10 p-b-10'><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
									Html1 += "</tr>";
								}else if(billLevel=="AIC0"){	//형상관리서비스
									Html1 += "<td class='productTitle  p-t-10 p-b-10'>"+val["invoiceItemName"]+"</td>";
									Html1 += "<td class='price  p-t-10 p-b-10'><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
									Html1 += "</tr>";
								}else if(billLevel=="AID0"){	//보안관제서비스
									Html1 += "<td class='productTitle  p-t-10 p-b-10'>"+val["invoiceItemName"]+"</td>";
									Html1 += "<td class='price  p-t-10 p-b-10'><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
									Html1 += "</tr>";
								} 
							});
							
							var basicProdCnt = 0;
							$.each(billInfoList,function(key,val){
		// 						var Html = "";
								var billLevel = val["invoiceItem"];
								
								if(billLevel=="A000"){	//클라우드 자원
									Html1 += "		</tbody>";
									Html1 += "	</table>";
									Html1 += "</div>";
								}
								
								if(billLevel=="AA00" || billLevel=="AE00" || billLevel=="AI00"){
									basicProdCnt++;
								}
								
							});
							
							if(basicProdCnt < 2){
								$("#billBox1").removeClass("oneLine");
								$("#billBox1").addClass("oneLine");
							}else{
								$("#billBox1").removeClass("oneLine");
							}
							
							
							$("#billBox1").append(Html1);
							
							
							Html2 = "";
							
							var levelCnt=0;
							var levelCnt2=0;
							var dcCnt=0;
							$.each(billInfoList,function(key,val){
								var billLevel = val["invoiceItem"];
								if(billLevel=="EA00"){
									levelCnt++;
								}else if(billLevel=="EL00"){
									levelCnt2++;
								}else if(billLevel=="E000"){
									dcCnt++;
								}
							});
							
							if(dcCnt != 0){
								$("#billBox2").removeClass("noData");
								$.each(billInfoList,function(key,val){
									
									var billLevel = val["invoiceItem"];
									
									if(billLevel=="E000"){	//요금할인
										
										Html2 += "<table>";
										Html2 += "	<colgroup>";
										Html2 += "		<col width='34%'>";
										Html2 += "		<col width='33%'>";
										Html2 += "		<col width='33%'>";
										Html2 += "	</colgroup>";
										Html2 += "	<tbody>";
										Html2 += "		<tr>";
										if(levelCnt==0 || levelCnt2==0){
											Html2 += "			<th scope='row'>";
										}else if(levelCnt==1 && levelCnt2==1){
											Html2 += "			<th scope='row' rowspan='2'>";
										}
										Html2 += "				<dl class='totalBox2'>";
										Html2 += "					<dt>요금 할인</dt>";
										Html2 += "					<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</dd>";
										Html2 += "				</dl>";
										Html2 += "			</th>";
									}else if(billLevel=="EA00"){	//프로젝트 할인
										Html2 += "<th scope='row' class='thType1 borderB'>"+val["invoiceItemName"]+"</th>";
										Html2 += "<td class='price borderB'><strong class='nanumR txtBlue'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
										Html2 += "</tr>";
									}else if(billLevel=="EL00" && levelCnt == 0){	//10원 미만 절사 할인
			// 							Html2 += "<tr>";
										Html2 += "<th scope='row' class='thType1'>"+val["invoiceItemName"]+"</th>";
										Html2 += "<td class='price'><strong class='nanumR txtBlue'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
										Html2 += "</tr>";
									}else if(billLevel=="EL00" && levelCnt > 0){	//10원 미만 절사 할인
										Html2 += "<tr>";
										Html2 += "<th scope='row' class='thType1'>"+val["invoiceItemName"]+"</th>";
										Html2 += "<td class='price'><strong class='nanumR txtBlue'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
										Html2 += "</tr>";
									}
								
								});
								
								$.each(billInfoList,function(key,val){
									var billLevel = val["invoiceItem"];
									
									if(billLevel=="E000"){	//요금할인
										Html2 += "		</tbody>";
										Html2 += "	</table>";
									}
								});
								
								$("#billBox2").append(Html2);
								
								if(levelCnt==0 || levelCnt2==0){
									$("#billBox2").removeClass("oneLine");
									$("#billBox2").addClass("oneLine");
								}else if(levelCnt==1 && levelCnt2==1){
									$("#billBox2").removeClass("oneLine");
								}
							}else{
								$("#billBox2").addClass("noData");
							}
							
							var levelCnt3=1;
							var levelCnt4=0;
							$.each(billInfoList,function(key,val){
								var billLevel = val["invoiceItem"];
								if(billLevel=="IA00"){
									levelCnt4++;
								}
							});
							
							var Html3 = "";
							if(levelCnt4 != 0){
								$("#billBox3").removeClass("noData");
								$.each(billInfoList,function(key,val){
									var billLevel = val["invoiceItem"];
									
									if(billLevel=="I000"){	//보정
										Html3 += "<table>";
										Html3 += "	<colgroup>";
										Html3 += "		<col width='34%'>";
										Html3 += "		<col width='33%'>";
										Html3 += "		<col width='33%'>";
										Html3 += "	</colgroup>";
										Html3 += "	<tbody>";
										Html3 += "		<tr>";
										if(levelCnt4 == 1){
											Html3 += "			<th scope='row'>";
										}else if(levelCnt4 > 1){
											Html3 += "			<th scope='row' rowspan='"+levelCnt4+"'>";
										}	
										Html3 += "				<dl class='totalBox2'>";
										Html3 += "					<dt>보정</dt>";
										Html3 += "					<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</dd>";
										Html3 += "				</dl>";
										Html3 += "			</th>";
									}else if(billLevel=="IA00"){	//보정명칭
										if(levelCnt3 == 1 ){
											Html3 += "<th scope='row' class='thType1 borderB'>"+val["invoiceItemName"]+"</th>";
											Html3 += "<td class='price borderB'><strong class='nanumR txtBlue'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
											Html3 += "</tr>";
										}else if(levelCnt3 > 1){
											Html3 += "<tr>";
											Html3 += "<th scope='row' class='thType1 borderB'>"+val["invoiceItemName"]+"</th>";
											Html3 += "<td class='price borderB'><strong class='nanumR txtBlue'>"+addcomma(val["amount"])+"</strong>&nbsp;원</td>";
											Html3 += "</tr>";
										}
										levelCnt3++;
									}
								});
								
								$.each(billInfoList,function(key,val){
									var billLevel = val["invoiceItem"];
									
									if(billLevel=="I000"){	//보정
										Html3 += "		</tbody>";
										Html3 += "	</table>";
									}
								});
								
								$("#billBox3").append(Html3);
							}else{
								$("#billBox3").addClass("noData");
							}
							
							
							var Html4 = "";
							$.each(billInfoList,function(key,val){
								var billLevel = val["invoiceItem"];
								
								if(billLevel=="L000"){	//부가가치세(세금)
									Html4 += "<dl>";
									Html4 += "	<dt><strong>"+val["invoiceItemName"]+"</strong></dt>";
									Html4 += "	<dd><strong class='nanumR'>"+addcomma(val["amount"])+"</strong>&nbsp;원</dd>";
									Html4 += "</dl>";
								}
								
							});
							$("#vatBox1").append(Html4);
							
							
							var btnHtml = "";
							$("#btnArea").empty();
							btnHtml += "<a href='javascript:void(0);' onclick='printPage();'> <i class='fa fa-print f16'></i> <span>인쇄</span></a>";
		// 					btnHtml += "<a href='javascript:void(0);' class='btn_bill_excel' onclick='excelDown();'><i></i><span>엑셀</span></a>";
		// 					btnHtml += "<a href='javascript:void(0);' class='btn_bill_pdf' onclick='pdfDown();''><i></i><span>PDF</span></a>";
							btnHtml += "<a href='javascript:void(0);' class='' onclick='moveDetailPage();'><i class='fa fa-search f16'></i> <span>상세</span></a>";
							
							
							
							
							
							$("#btnArea").append(btnHtml);
							billChart();
							
							
						}
						else{
							$("#billDashboard1").hide();
							$("#billDashboard2").show();
							$("#billBox1").hide();
							$("#billBox2").hide();
							$("#billBox3").hide();
							$("#vatBox1").hide();
							$("#btnArea").empty();
							var HtmlHeader = "";
							
		// 					HtmlHeader ="<div class='noneAddList'><img class='mr10' src='/resources/assets/img/icon_no.png'>청구내역이 없습니다.</div>";
							HtmlHeader ="<div class='noneAddList'><img class='mr10' src='/resources/assets/img/icon_no.png'>청구내역이 없습니다.</div>";
							$("#billDashboard2").empty();
							$("#billDashboard2").append(HtmlHeader);
							
						}
						
					},
					error : function(request, status, error) {
						if(request.status == '200'){
							alertBox("접속이 만료되었습니다.", logout);				
						}else{
							alertBox("code:" + request.status + "\n" + "error:" + error, logout);
						}	
					}
				});
				
				setTimeout (function(){
					/* var tableHeight = $('#billBox1 .tableBox').height();
					$('#billBox1 .totalBox').css('height', tableHeight); */
					
					if ( $('#billBox3 table tbody tr').length == 1 ) {
						$('#billBox3').addClass('oneLine');
					}
					
				},500);
				
			}
			
			
			function movePrev(){
				var prevMonth = $("#h_billYyyymm").val();
				var yy = prevMonth.substring(0, 4);
				var mm = prevMonth.substring(4, 6);
				var yymm = "";
				
				if(mm == "01"){
					mm = "12";
					yy = parseInt(yy, 10) - 1;
				}else{
					mm = parseInt(mm, 10) - 1;
				}
				
				if(mm.toString().length < 2){
					mm = "0"+mm;
				}
				yymm = yy+mm;
				
				$("#h_billYyyymm").val(yymm);
				getDetail();
			}
			
			function moveNext(){
				var prevMonth = $("#h_billYyyymm").val();
				var yy = prevMonth.substring(0, 4);
				var mm = prevMonth.substring(4, 6);
				var yymm = "";
				
				if(mm == "12"){
					mm = "01";
					yy = parseInt(yy, 10) + 1;
				}else{
					mm = parseInt(mm, 10) + 1;
				}
				
				if(mm.toString().length < 2){
					mm = "0"+mm;
				}
				yymm = yy+mm;
				
				$("#h_billYyyymm").val(yymm);
				getDetail();
			}
			
			
			
			
			
			// 금액에 콤마추가 
			function addcomma(n){
				if(isNaN(n)){
					return 0;
				}else{
					var reg=/(^[+-]?\d+)(\d{3})/;
					n +='';			
					while(reg.test(n)){
						n=n.replace(reg,'$1'+','+'$2');
					}				
				return n;
				}
			}
		
			
			// 청구서 프린트
			function printPage(){
				var billYyyymm = $("#h_billYyyymm").val();
				var customerId = $("#h_customerId").val();
		
				var popupWindow = window.open("${wasPath}/mbr/charge/bill/print?billYyyymm="+billYyyymm+"&customerId="+customerId,"_blank","width=1100, scrollbars=yes, resizable=yes");
		 		
			}
			
			// 청구서 PDF
			/* function pdfDown(){
				var billYyyymm = $("#h_billYyyymm").val();
				var customerId = $("#h_customerId").val();
		
				var popupWindow = window.open("${wasPath}/mbr/charge/bill/print?billYyyymm="+billYyyymm+"&customerId="+customerId,"_blank","width=1100, scrollbars=yes, resizable=yes");
			} */
			
			
			
			//목록페이지 이동
			function movePage(){
				location.href="${wasPath}/mbr/charge/bill/";
			}
			
			// 상세내역페이지 이동
			function moveDetailPage(){
				var billYyyymm = $("#h_billYyyymm").val();
				var customerId = $("#h_customerId").val();
				var cloudId = $("#h_cloudId").val();
				var params = "?billYyyymm="+billYyyymm+"&customerId="+customerId+"&cloudId="+cloudId;
				location.href = "${wasPath}/mbr/charge/bill/billDetailListPage"+params;
			}
			
			//엑셀 다운로드
			function excelDown(){
				var billYyyymm = $("#h_billYyyymm").val();
				
		// 		var yy = $("#billYear option:selected").val();
		// 		var mm = $("#billMonth option:selected").val();
		// 		var billYyyymm = yy+mm;
				
				var customerId = $("#h_customerId").val();
				var params = "?billYyyymm="+billYyyymm+"&customerId="+customerId;
				location.href = "${wasPath}/mbr/excel/billExcelDown"+params;
			}
			
			function billChart(){
				var get3MonthAmount = $("#h_get3MonthAmount").val();
				var get3Yyyymm = $("#h_get3Yyyymm").val();
				
				get3Yyyymm = eval(get3Yyyymm);
				get3MonthAmount = eval(get3MonthAmount);
				
				var colors = ['#ecdb69', '#a591d9', '#7ece55', '#6396e5'];
				Highcharts.chart('divCharts', {
					chart: {
				        type: 'bar'
		// 		        	, height : 140
		// 				    , width : 410
							, height : 140
					    	, width : 300
							, backgroundColor: "#f4f8fb"
				    },
				    title: {
				        text: ''
				    },
				    subtitle: {
				        text: ''
				    },
					colors :['#ecdb69', '#a591d9', '#7ece55', '#6396e5'],
				    xAxis: {
				        categories: get3Yyyymm,
		// 		        categories: ['201710','201709','201707'],
				        title: {
				            text: null
				        }
						, lineWidth:0
						, tickLength : 0
						, labels : {
							formatter : function(){
								var ym = this.value;
								var yy = ym.substr(0,4);
								var mm = ym.substr(4,5);
								return yy+"."+mm;
							}
							,
							style : {
								fontSize : '14px'
							}
						}
				    },
				    yAxis: {
				        min: 0,
						title: {
				            text: '',
				            align: 'high'
				        }
						,gridLineWidth: 0
						,labels : {
							overflow: 'justify',
							enabled : false,
							align: "right",
							style : {
								fontSize : '13px' 
							}
						}
						
				    },
				    exporting : {
						enabled : false
					},
					credits : {
						enabled : false
					},
				    tooltip: {
				        valueSuffix: '%'
						,enabled : false
				    },
				    plotOptions: {
				        bar: {
				            dataLabels: {
		// 		            	enabled: true,
				            	enabled: false,
								align : 'left',
								inside : true,
								color : '#333',
								x : 210
				            },
							borderRadius: 3
				        },
						series : {
							states:{
								hover:{
									enabled : false
								}
							},
							enableMouseTracking: false
						}
				    },
				    legend: {
				        enabled : false
					},
				    credits: {
				        enabled: false
				    },
				    series: 
				    	[{
				    		data: get3MonthAmount
				    	}] 
				    	
				});
			}
			
			
			$(document).ready(function() {
			    App.init();
		// 	    calendar();
			    monthCalendar();
			    $("a>button").on('click',function(){
					location.href = $(this).closest("a").attr("href");
				});
			    
		// 		var yy = $("#billYear option:selected").val();
		// 		var mm = $("#billMonth option:selected").val();
		// 		var billYyyymm = yy+mm;
		
				getDetail();
		// 		billChart();
				
				//메뉴활성화
				$("#billMenu").addClass("active");
				$("#bill").addClass("active");
				
			});
			
		</script>
	
	</body>
</html>
