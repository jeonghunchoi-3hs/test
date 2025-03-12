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
			<h1 class="page-header fc66 fb"> <i class="fa fa-dot-circle-o fcb"> </i> 청구서 <span class="root">관리자포털 > 요금 > 청구 요금 조회</span></h1>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row mb50" >
				<div id="print">
				<input type="hidden" id="h_customerId" value="${customerId}">
				<input type="hidden" id="h_billYyyymm" value="${billYyyymm}">
				<div class="col-md-12"> 
					
					<h4 class="mt20 f20 tac" >${year}년 ${month}월 청구서</h4>
					<h5 class="tar">사용기간 : ${billStartDatetime} ~ ${billEndDatetime}</h5>
					<h5 class="tar">회원사 : ${customerName} </h5>
					 
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
					
					<div class="col-md-12 disk p10 mt5" id="billHeader">
<!-- 						<div class="col-md-8 fc66 f24 pr0">총 청구요금</div> -->
<!-- 						<div class="col-md-4 f24 fc-red tar pr0 vm"><span id="totalAmount"></span><span class="f12 fc66 pl4">원</span></div> -->
				    </div>
				</div>
	
			</div>
			<!---- end page body---->
			
			<div class="col-md-12 tac p20">
				<button class="btn btn-primary t-in-3" value="Print" onclick="printPage();"><i class="fa fa-print"></i> Print</button>&nbsp;
<!-- 				<button class="btn btn-primary t-in-3" value="Print" onclick="excelDown();"><i class="fa fa-file-excel-o"></i> Excel</button>&nbsp; -->
				<button class="btn btn-grey" value="목록" onclick="movePage();"><i class="fa fa-reorder"></i> 목록</button>
				<button class="btn btn-grey" value="목록" onclick="moveDetailPage();"><i class="fa fa-reorder"></i> 상세</button>
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
			url : "${contextPath}/mng/charge/bill/detail",
// 			dataType : "JSON",
	//			type : "POST",
			data : {
				"customerId" : $("#h_customerId").val()	
				,"billYyyymm" : $("#h_billYyyymm").val() 
			},
			success : function(data) {
				var billInfoList = data.detail;
				
				$("#billTable > tr").remove();
				$("#billHeader > div").remove();
				
				if(billInfoList.length != 0){
					
					var HtmlHeader = "";
					HtmlHeader = "<div class='col-md-8 fc66 f24 pr0'>총 청구요금</div>";
					HtmlHeader += "<div class='col-md-4 f24 fc-red tar pr0 vm'><span id='totalAmount'></span><span class='f12 fc66 pl4'>원</span></div>";
					$("#billHeader").append(HtmlHeader);
				
					$.each(billInfoList,function(key,val){
						var Html = "";
						var billLevel = val["invoiceItem"];
						
						if(billLevel=="A000"){	//클라우드 자원
							Html="<tr class='bgee'><td class='f18 fb tal'><i class='fa fa-cloud'></i> "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						
	// 					}else if(billLevel=="AA00"){	//기본 자원
	// 						Html="<tr class='bgf5 bge0 bt2-sky accordion-toggle accordion-toggle-styled' data-toggle='collapse' data-parent='#accordion' href='#collapse2'><td class='t-in16'><i class='fa fa-chevron-down f12'></i> "+val["invoiceItemName"]+"</td>";
	// 						Html = Html + "<td class='tar pr10 vm'><span class='fc66 f16 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
	// 					}else if(billLevel=="AAA0"){	//가상 서버
	// 						Html="<tr id='collapse2'><td colspan='2' style='padding:0 !important'><table class='tableD-s'>";
	// 						Html= Html + "<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
	// 						Html = Html + "<td class='tar pr10 rtd'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
	// 						Html= Html + "<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
	// 						Html = Html + "<td class='tar pr10 rtd'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
	// 						Html = Html + "</table></td></tr>";
	// 					}else if(billLevel=="AE00"){	//부가자원
	// 						Html="<tr class='bgf5 accordion-toggle accordion-toggle-styled' data-toggle='collapse' data-parent='#accordion' href='#collapse3'><td class='t-in16'><i class='fa fa-arrow-circle-o-down f12'></i>"+val["invoiceItemName"]+"</td>";
	// 						Html = Html + "<td class='tar pr10 vm'><span class='fc66 f16 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						
						}else if(billLevel=="AA00"){	//기본 자원
							Html="<tr class='vm'><td class='t-in16'><i class='fa fa-arrow-circle-o-down f12'></i>"+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fc66 f16 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="AAA0"){	//가상 서버
							Html= "<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 rtd'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="AE00"){	//부가자원
							Html="<tr class='bgf5 accordion-toggle accordion-toggle-styled' data-toggle='collapse' data-parent='#accordion' href='#collapse3'><td class='t-in16'><i class='fa fa-arrow-circle-o-down f12'></i>"+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fc66 f16 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";	
							
						}else if(billLevel=="AEA0"){	//블록디스크
							Html="<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="AEB0"){	//NAS
							Html="<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
							
						}else if(billLevel=="AI00"){	//서비스
							Html="<tr class='bgf5'><td class='t-in16'><i class='fa fa-code-fork'></i>"+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fc66 f16 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="AIA0"){	//형상관리 서비스
							Html="<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";	
						}else if(billLevel=="AIB0"){	//대외계 서비스
							Html="<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";	
						
						}else if(billLevel=="E000"){	//요금할인
							Html="<tr class='bgee'><td class='f18 fb'><i class='fa fa-won'></i> "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="EA00"){	//프로젝트 할인
							Html="<tr><td class='t-in38'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="EL00"){	//10원 미만 절사 할인
							Html="<tr><td class='t-in38'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						
						}else if(billLevel=="I000"){	//보정	
							Html="<tr class='bgee'><td class='f18 fb'><i class='fa fa-wrench'></i> "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="IA00"){	//보정명칭
							Html="<tr><td class='t-in16'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
							
						}else if(billLevel=="L000"){	//부가가치세(세금)
							Html="<tr class='bgee'><td class='f18 fb'><i class='fa fa-yelp'></i> "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="LA00"){	//부가가치세
							Html="<tr><td class='t-in38 vm'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="0000"){	//총 청구금액
							$("#totalAmount").text(addcomma(val["amount"]));
						}
						
						$("#billTable").append(Html);	
					});
				}else{
					var HtmlHeader = "";
					HtmlHeader = "<div class='col-md-8 fc66 f24 pr0'>청구 내역이 없습니다.</div>";
					HtmlHeader += "<div class='col-md-4 f24 fc-red tar pr0 vm'><span id='totalAmount'></span><span class='f12 fc66 pl4'></span></div>";
					$("#billHeader").append(HtmlHeader);
				}
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
		popupWindow.document.write("<div style='width:850px;'>");
		popupWindow.document.write(document.getElementById("print").innerHTML);
		popupWindow.document.write("</div>");
		popupWindow.document.write("</body>");
		popupWindow.document.write("</html>");
		popupWindow.document.close();
		popupWindow.print();
		
	}
	
	//목록페이지 이동
	function movePage(){
		location.href="${contextPath}/mng/charge/bill/";
	}
	
	// 상세내역페이지 이동
	function moveDetailPage(){
		var billYyyymm = $("#h_billYyyymm").val();
		var customerId = $("#h_customerId").val();
		var params = "?billYyyymm="+billYyyymm+"&customerId="+customerId;
		location.href = "${contextPath}/mng/charge/bill/billDetailListPage"+params;
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
