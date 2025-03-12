<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="roles" property="principal.roles" />
</sec:authorize>
<sec:authorize var="isPM" access="hasRole('ROLE_CUSTOM_PM')" />

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
				<!-- Begin hidden input Data -->
				<input type="hidden" id="h_cloudId" value="${cloudList[0].cloudId}">
				
				<!-- End hidden input Data -->
				
				<!-- begin header -->
				<h1 class="page-header"><span class="root"> <span class="home"></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow"><a href="${wasPath}/mbr/charge/bill/view"><strong>청구서</strong></a></span><span class="text arrow mint"><a href="${wasPath}/mbr/charge/bill/"><strong>목록</strong></a></span></span></h1>
				<!-- end header -->
				
				<!-- begin page-body -->
				
					<div class="row mb50">
						<p class="page_title"><span class="stick">청</span>구서 목록</p>
					    <ul class="nav nav-pills ml-10 mb10" id="tabNavi">
					 	 	<c:forEach items="${cloudList}" var="getCloudList" varStatus="status">
					 	 		<li class="ml10 <c:if test="${status.first}">active</c:if>"><a href="#nav-pills-tab-2" data-toggle="tab" onclick="gridItem('${getCloudList.cloudId}');">${getCloudList.cloudName}</a></li>
					 	 	</c:forEach>
						</ul> 	
					
					
					<!-- search begin -->
					<div class="col-md-12 br5 p10 mb20 bgee">
						<!-- 날짜 검색 -->
						<div class="search_date">
							<div class="dateBox">
								<input type="text" value="" id="startDate" readonly="readonly" placeholder="검색 시작일">
								<button type="button" class="btn_calendar"><span></span></button>
							</div>
							<span class="hyphen"></span>
							<div class="dateBox">
								<input type="text" value="" id="endDate" readonly="readonly" placeholder="검색 종료일">
								<button type="button" class="btn_calendar"><span></span></button>
							</div>
							<button type="button" class="btn_search2" onclick="dateChk();"><span></span></button>
						</div>
						<!-- //날짜 검색 -->
					</div>	
					<!-- search end -->	
				
					<!-- color01, color02, color03, color04, color05 클래스 랜덤 적용 -->
					<div class="card_contents_wrap" id="cardList">
					</div>
					<!-- 테이블시작 -->
					<div class="col-md-12">
						<input type="hidden" id="roles" value="${roles}">
						<div class="panel">
					    	<div class="table-responsive">
					        	<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="chargeBillList" summary="청구서">
									<caption>게시판 목록 : 청구년월, 고객사, 사용요금, 할인금액, 청구요금, 상세로 구성</caption> 
									<colgroup>						 		
								 		<col width="30%">
								 		<col width="30%">
								 		<col width="20%">
								 		<col width="20%"> 
							 		</colgroup>
									<thead>
										<tr class="primary">
											<th class="tac">고객사</th>									
									  		<th class="tac">프로젝트명</th>								  	
									  		<th class="tac">신청자</th>
									  		<th class="tac">신청일시</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>			
					</div>
									
				</div>
				
				<!-- end page-body -->
				
				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->
				
			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->
	
		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
	
		<script type="text/javascript">

			function gridList() {
	 			//var yy = $("#billYear option:selected").val();
	 			//var mm = $("#billMonth option:selected").val();
	 			//var billYyyymm = yy+mm;
	
				var startDt = $("#startDate").val();
				var endDt = $("#endDate").val();
				var cloudId = $("#h_cloudId").val();
				
				startDt = startDt.replace("-", "");
				endDt = endDt.replace("-", "");
				
				$("#chargeBillList").dataTable({
					"processing":true
					,"ordering" : true
					,"destroy" : true
					,"autoWidth":false
					,"serverSide":true
					,"ajax": {
						"url": "${contextPath}/mbr/charge/bill/list"
						,"type" : "GET"
						,"dateSrc" : ""
						,"data":function (d) {
							d.customerId = "${customerId}";
							d.cloudId = cloudId;
							d.billYyyymm = "";
							d.startDt = startDt;
							d.endDt = endDt;
		 					//d.startDt = billYyyymm1;
		 					//d.endDt = billYyyymm2;
						}
						,"complete" : function(obj, status) {
							setCardList(obj.responseJSON);
							/*
							if(status == 'success'){
								setCardList(obj.responseJSON);
							}
							*/
						}
		
					}
					, "initComplete" : function(setting, json){
						$("#chargeBillList > thead").remove();
						$("#chargeBillList > tbody").remove();
					}
					,"columns":[ 
					        	{"data":"billYyyymm", "class":"tac"}
					        	, {"data":"customerName", "class":"tac"}
					        	, {"data":"billProcStat", "class":"tac"}
					        	, {"data":"confirnFlag", "class":"tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
					]
					,"order": [[0,"desc"]]
					,"lengthMenu": [[8,15], [8, 15]]
					,"sDom":'<"top"><"bottom"ip>'
					,"language": { 
						"zeroRecords":"" 
						, "processing":""  
					}
				});
			}
		
			function dateChk(){
				var startDt = $("#startDate").val().replace(/-/g, "/");
				var endDt = $("#endDate").val().replace(/-/g, "/");
				startDt = new Date(startDt);
				endDt = new Date(endDt);
				
				
				if(startDt > endDt){
					alertBox3("조회시작일은 조회종료일 <br>이전이어야 합니다.");
					return false;
				}
					
				gridList();
				
			}
			
			function moveDetailPage(billYyyymm,customerId){
				//var params = "?billYyyymm="+billYyyymm+"&customerId="+customerId+"&customerName="+ encodeURI(encodeURIComponent(customerName));
				var params = "?billYyyymm="+billYyyymm+"&customerId="+customerId;
				
				location.href = "${wasPath}/mbr/charge/bill/view"+params;
			}
			
			
			function setCardList(jsonData){
				var Html = "";
				
				$("#cardList > div").remove();
		
				var k = 1;
				
				for(var i=0; i<jsonData.data.length; i++){
					var billYyyymm = 	jsonData.data[i]["billYyyymm"];
					
					var yy = billYyyymm.substring(0,4);
					var mm = billYyyymm.substring(4,6);
					
					var billProcStat = jsonData.data[i]["billProcStat"];
					var confirnFlag = jsonData.data[i]["confirnFlag"];
					var customerId = jsonData.data[i]["customerId"];
					var cloudId = jsonData.data[i]["cloudId"];
					var customerName = jsonData.data[i]["customerName"];
					var totAmount = jsonData.data[i]["totAmount"];
					var A000Amount = jsonData.data[i]["A000Amount"];
					var dcAmount = jsonData.data[i]["dcAmount"];
					
					if(k%6==0){
						k = 1;
					}
					
					if(i%4==0){
						Html += "<div class='card_list_row'>";
						Html += 	"<div class='card_list_b color0"+k+" first'>";
					}else{
						Html += 	"<div class='card_list_b color0"+k+"'>";
					}
					
					Html +=			"<a href='${wasPath}/mbr/charge/bill/view?billYyyymm="+billYyyymm+"&customerId="+customerId+"&cloudId="+cloudId+"'>";
					Html +=				"<li class='code'>"+customerId+"</li>";
					Html +=				"<li class='fc66 mt20 f16 fb'>"+yy+"년 "+mm+"월</li>";
					Html +=				"<li class='fc_red f30 tar db mt20'>"+addcomma(totAmount)+"<span class='f20 fc66'>원</span></li>";
//					Html +=				"<ul class='bill_totalPrice mt70'>";
//					Html +=					"<li><span class='fa-stack fa-lg'> <i class='fa fa-circle-thin fa-stack-2x'></i><i class='fa fa-krw fa-stack-1x f13'></i></span> 자원금액<span class='flr f16 pt10'>"+addcomma(A000Amount)+"원</span></li>";
//					Html +=					"<li><span class='fa-stack fa-lg'> <i class='fa fa-circle-thin fa-stack-2x'></i><i class='fa fa-krw fa-stack-1x f13'></i></span> 할인금액<span class='flr f16 pt10'>"+addcomma(dcAmount)+"원</span></li>";
//					Html +=				"</ul>";
					Html +=			"</a>";
					Html +=			"<span class='color_btm'></span>";
					Html += 	"</div>";
					
					if(i%4==0){
						Html += "</div>";
					}
					k++;
				}
				$("#cardList").append(Html);
			}
			
			function moveInsertPage(){
				
				if("${isPM}" == "true"){
					location.href="${wasPath}/mbr/req/project/projectInsert.do";
				}else{
					errorBox("프로젝트 신청권한이 없습니다.");
				}	
			}
				
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
			
			
			function calendar(){
				
				var dayName = ['일','월','화','수','목','금','토'];
				var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];
		
				$("#startDate").datepicker({
					showOn:"both",
					buttonImage:"${apachePath}/resources/assets/img/c_calen.png",
					buttonImageOnly:false,
					dateFormat : "yy-mm",
					dayNamesMin:dayName,
					monthNamesShort:monthName,
					changeMonth:true
					, maxDate:0
				});
		
				$("#endDate").datepicker({
					showOn:"both",
					buttonImage:"${apachePath}/resources/assets/img/c_calen.png",
					buttonImageOnly:false,
					dateFormat:"yy-mm",
					dayNamesMin:dayName,
					monthNamesShort:monthName,
					changeMonth:true
					, maxDate:0
				});
				
				$(".ui-datepicker").css({"margin-left" : "0px"});
		
			}
			
			function gridItem(cloudId){
				$("#h_cloudId").val(cloudId);
				gridList();
			}
			
			
			$(document).ready(function(){		
				//alert("키보드입력");
				 App.init();
				 //gridList();
				 gridItem("${cloudList[0].cloudId}");
				 calendar();
				 
				// select box text 설정
				$(".search-sel").change(function() {
					$(this).siblings(".selectText").text($(this).children('option:selected').text());
				});
				
				
				
				//메뉴활성화
				$("#billMenu").addClass("active");
				$("#bill").addClass("active");
					
			});	
	</script>
	
	
	<!--  이전 소스 
	<script type="text/javascript">
		
		var oTable;
		
		
		function gridList() {
			
	// 		var yy1 = $("#billYear1 option:selected").val();
	// 		var mm1 = $("#billMonth1 option:selected").val();
	// 		var yy2 = $("#billYear2 option:selected").val();
	// 		var mm2 = $("#billMonth2 option:selected").val();
	// 		var billYyyymm1 = yy1+mm1;
	// 		var billYyyymm2 = yy2+mm2;
	
			var yy = $("#billYear option:selected").val();
			var mm = $("#billMonth option:selected").val();
			var billYyyymm = yy+mm;
	
			
			oTable = $("#chargeBillList").dataTable( {
				"processing":true
				,"ordering" : true
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
				,"ajax": {
					"url":"${wasPath}/mbr/charge/bill/list"
					,"type" : "GET"
					,"dateSrc" : ""
					,"data":function (d) {
						d.customerId = "${customerId}"
	// 					d.searchKind = $("#billSearchKind option:selected").val();
	// 					d.keyword = $("#keyword").val();
						d.billYyyymm = billYyyymm;
	// 					d.startDt = billYyyymm1;
	// 					d.endDt = billYyyymm2;
					}
					,"error": function (xhr, error, thrown) {
						if ( error == "parsererror" ) {
							location.reload();
						}else{
							//alert("ajax error");
							return false;
						}
					}	
				}
				,"columns":[ 
				        	{"data":"billYyyymm", "class":"tac"}
				        	, {"data":"customerName", "class":"tac"}
				        	, {"data":"billProcStat", "class":"tac"}
				        	, {"data":"confirnFlag", "class":"tac"}
				]
				,"columnDefs":[
					{"defaultContent" : "", targets:"_all" }
					, {"targets":[1], "render": function(data,type,full){
						return "<a href='#' onclick='moveDetailPage(\""+full.billYyyymm+"\",\""+full.customerId+"\")'>" + full.customerName + "</a>";
						}	
					}
					, {"targets":[2], "render":function(data,type,full){
							var stat = "";
							if(full.billProcStat!=null){
								if(full.billProcStat == "BILLPROCSTAT_COMPLETE"){
									stat = "완료";
									return stat;
								}else if(full.billProcStat == "BILLPROCSTAT_NA"){
									stat = "미적용";
									return stat;
								}else if(full.billProcStat == "BILLPROCSTAT_PROCESS"){
									stat = "처리중";
									return stat;
								}
							}	
						}
					}
					, {"targets":[3], "render":function(data,type,full){
							var flag = "";
							if(full.confirnFlag!=null){
								if(full.confirnFlag == "Y"){
									flag = "정산확정";
									return flag;
								}else if(full.confirnFlag == "N"){
									flag = "정산미확정";
									return flag;
								}
							}
						}
					}
				]
				,"order": [[0,"asc"]]
		//			,"lengthMenu": [[10,15], [10, 15]]
				,"language": { 
					"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
					, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
				}
				,"sDom":'<"top">rt<"bottom"pi>'
			});
			
			
		}
		
		function moveDetailPage(billYyyymm,customerId){
			//var params = "?billYyyymm="+billYyyymm+"&customerId="+customerId+"&customerName="+ encodeURI(encodeURIComponent(customerName));
			var params = "?billYyyymm="+billYyyymm+"&customerId="+customerId;
			
			location.href = "${wasPath}/mbr/charge/bill/view"+params;
		}
		
		/*
		function moveDetailPage(){
	 		var table = $("#chargeBillList").DataTable();
	 		
	 		$("#chargeBillList tbody").on("click", "td.ditailStyle", function() {
				var rowData = table.row($(this).closest("tr")).data();
				var billYyyymm = rowData.billYyyymm;
				var customerId = rowData.customerId;
	// 			var customerName = rowData.customerName;
	// 			var params = "?billYyyymm="+billYyyymm+"&customerId="+customerId+"&customerName="+ encodeURI(encodeURIComponent(customerName));
				var params = "?billYyyymm="+billYyyymm+"&customerId="+customerId;
				
				location.href = "${wasPath}/mbr/charge/bill/view"+params;
	 		});
	 	}
		*/
		
		
		function getYyyymm(){
			var date = new Date();
			var date_year = date.getFullYear();
			var date_month = date.getMonth()+1;
			
			
			
		}
		
		
		
		$(document).ready(function(){
			App.init();
			gridList();
			
			//메뉴활성화
			$("#billMenu").addClass("active");
			$("#bill").addClass("active");
		
		});
	
	</script>
	
	-->
	</body>
</html>