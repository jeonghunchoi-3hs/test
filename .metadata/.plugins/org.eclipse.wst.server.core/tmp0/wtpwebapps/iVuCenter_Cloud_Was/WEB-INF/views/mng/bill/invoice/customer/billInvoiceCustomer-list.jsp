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
				<h1>세금계산서</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">요금조회</a><a href="#" class="on">세금계산서</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<div class="page_searchBox m-b-15">
					<div class="searchArea">
						<div class="selectBox m-r-5" style="width:130px;">
							<label class="selectText" for="searchKey0">구분</label>
							<select class="search-sel" id="searchKey0" onchange="onchangeSearchKey('0');">
								<option value="">구분</option>
							</select>
						</div>
						<div class="selectBox m-r-45" style="width:235px;">
							<label class="selectText" for="searchKey1">고객사명</label>
							<select class="search-sel" id="searchKey1" onchange="onchangeSearchKey('1');">
								<option value="">고객사명</option>
							</select>
						</div>
						<div class="selectBox" style="width:90px;">
							<label class="selectText" for="billYear1"></label>
							<select class="search-sel" id="billYear1">
								<c:forEach items="${getBillYyyy}" var="list" varStatus="status" >
									<option value="${list.billYyyy}">${list.billYyyy}</option>
								</c:forEach>			
							</select>
						</div>
						<span class="selectTxt" style="margin-right: 3px">년</span>
						<div class="selectBox m-l-5" style="width:60px;">
							<label class="selectText" for="billMonth1"></label>
							<select class="search-sel" id="billMonth1">
								<option value="01">01</option>
								<option value="02">02</option>
								<option value="03">03</option>
								<option value="04">04</option>
								<option value="05">05</option>
								<option value="06">06</option>
								<option value="07">07</option>
								<option value="08">08</option>
								<option value="09">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
						</div>
						<span class="selectTxt" style="margin-left:8px;margin-right: 11px">월 ~ </span>
						<div class="selectBox" style="width:90px;">
							<label class="selectText" for="billYear2"></label>
							<select class="search-sel" id="billYear2">
								<c:forEach items="${getBillYyyy}" var="list" varStatus="status" >
									<option value="${list.billYyyy}">${list.billYyyy}</option>
								</c:forEach>			
							</select>
						</div>
						<span class="selectTxt" style="margin-right: 3px">년</span>
						<div class="selectBox m-l-5" style="width:60px;">
							<label class="selectText" for="billMonth2"></label>
							<select class="search-sel" id="billMonth2">
								<option value="01">01</option>
								<option value="02">02</option>
								<option value="03">03</option>
								<option value="04">04</option>
								<option value="05">05</option>
								<option value="06">06</option>
								<option value="07">07</option>
								<option value="08">08</option>
								<option value="09">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
						</div> 
						<span class="selectTxt">월</span>
						<div class="mt10">
							<div class="selectBox" style="width:130px;">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel" id="searchKind">
									<option value="All">전체</option>
									<option value="up_company_name">구분</option>
									<option value="customer_name">고객사</option>
								</select>
							</div>
							<div class="inputArea m-l-5">
								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 655px">
								<a type='button' class="btn_search" onclick="gridList()">검색</a>
							</div>	
						</div>	
					</div>
				</div>
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a type="button" class="btnType01 m-r-5" onclick="excelDown();"><i class="ico_download"></i><span>다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<span class="flr f14 fc33 m-t-8">(단위:원, VAT별도)</span>
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-35"> 
						<table id="table-list" summary="세금계산서">
							<caption>게시판 목록 : 구분, 고객사, 담당자(연락처), 원금, 부가가치세, 총 금액로 구성</caption> 
							<colgroup>
								<col width="132px">
								<col width="*">
								<col width="102px">
								<col width="200px">
								<col width="125px">
								<col width="115px">
								<col width="126px">
							</colgroup>
							<thead>
								<tr>
									<th class="tac">구분</th>
									<th class="tac">고객사</th>
									<th class="tac">발행년월</th>
									<th class="tac">담당자(연락처)</th>
									<th class="tac">원금</th>
									<th class="tac">부가가치세</th>
									<th class="tac">총 금액</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
			</div>
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
	
<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

	function gridList() {
		var yy = $("#billYear option:selected").val();
		var mm = $("#billMonth option:selected").val();
		var billYyyymm = yy+mm;
		
		 $("#table-list").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/bill/invoice/customer/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.searchKey0 = $("#searchKey0 option:selected").val();
					d.searchKey1 = $("#searchKey1 option:selected").val();
					d.billYear1 = $("#billYear1 option:selected").val();
					d.billMonth1 = $("#billMonth1 option:selected").val();
					d.billYear2 = $("#billYear2 option:selected").val();
					d.billMonth2 = $("#billMonth2 option:selected").val();					
				}
			}
			,"columns":[
				{"data":"upCompanyName", "class":"tal"}
				, {"data":"customerName", "class":"tal"}
	        	, {"data":"billYyyymm", "class":"tac fontVdn ls-1"}
	        	, {"data":"userName", "class":"tal ls1"}
	        	, {"data":"A000Amount", "class":"tar fontVdn p-r-15 ls-1"}
	        	, {"data":"LA00Amount", "class":"tar fontVdn p-r-15 ls-1"}		
	        	, {"data":"amount", "class":"tar fontVdn name p-r-15 ls-1"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[2], "render": function(data,type,full){
						return full.billYyyymm.substring(0,4)+'-'+full.billYyyymm.substring(4,6);
					}
				}
				, {"targets":[3], "render": function(data,type,full){
						return full.userName+'<span class="fontVdn">('+full.userTel+')</span>';
					}
				}
			]
			,"order": [[2,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
		
	}

	function onchangeSearchKey(e){
		if($("#searchKey"+e).val() != ""){
			if( e == "1"){
				var companyName = $("#searchKey"+e+" > option:selected").attr("companyName");
				$("#searchKey0").siblings(".selectText").text(companyName!=""?companyName:"구분");
				$("#searchKey0").val(companyName);
			}else if( e == "2"){
				var companyName = $("#searchKey"+e+" > option:selected").attr("companyName");
				$("#searchKey0").siblings(".selectText").text(companyName!=""?companyName:"구분");
				$("#searchKey0").val(companyName);

				var customerName = $("#searchKey"+e+" > option:selected").attr("customerName");
				$("#searchKey1").siblings(".selectText").text(customerName!=""?customerName:"고객사명");
				$("#searchKey1").val(customerName);
			}			
		}
		
		if( e == "0"){
			setSearchBox("1");
			setSearchBox("2");
		}else if( e == "1"){
			setSearchBox("2"); 
		}
	}
	
	function setSearchBox(gbn){
		$.ajax({
			url : "${contextPath}/mng/productUsageStatus/total/searchBox",
			dataType : "JSON",
			data : {
				searchKind : gbn
				, searchKey0 : $("#searchKey0 option:selected").val()
				, searchKey1 : $("#searchKey1 option:selected").val()
			},
			success : function(data) {
				var vText = "";
				if(gbn == "0"){
					vText = "구분";
				}else if(gbn == "1"){
					vText = "고객사명";
				}else if(gbn == "2"){
					vText = "프로젝트명";
				}  
				
				if( vText != ""){
					$("#searchKey"+gbn).html('<option value="">'+vText+'</option>');
					$("#searchKey"+gbn).siblings(".selectText").text(vText);
				}
				
				if(data.searchBox != ""){
					$.each(data.searchBox, function(key,val){
						$("#searchKey"+gbn).append('<option value="'+val.searchKind+'" companyName="'+val.companyName+'" customerName="'+val.customerName+'">'+val.searchKind+'</option>');
					});
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
	
	function excelDown(){
		var params = "";
		params += "&searchKind="+$("#searchKind option:selected").val();
		params += "&keyword="+$("#keyword").val();
		params += "&searchKey0="+$("#searchKey0 > option:selected").val();
		params += "&searchKey1="+$("#searchKey1 > option:selected").val();
		params += "&billYear1="+$("#billYear1 > option:selected").val();
		params += "&billMonth1="+$("#billMonth1 > option:selected").val();
		params += "&billYear2="+$("#billYear2 > option:selected").val();
		params += "&billMonth2="+$("#billMonth2 > option:selected").val();
		
		location.href = '${contextPath}/mng/bill/invoice/customer/excel?'+params;
	}
	
	function getNowDate(){
		var currentYear = (new Date()).getFullYear();
		var currentYear2 = (new Date()).getFullYear();
		
	    var years="";
	    var html = "";
	    for(var i=0; i < 5 ; i++){
	    	years = (currentYear + 1) - i;
	    	html += "<option value='"+years+"'>"+ years +"</option>";
	    }

	    $("#billYear1").html(html);
	    $("#billYear2").html(html);

	    // 월 선택
		var currentMonth = (new Date()).getMonth();
		var currentMonth2 = (new Date()).getMonth();
		
		if(currentMonth == 1){
			currentMonth = 11;
			currentYear = currentYear - 1;
		}else if(currentMonth == 2){
			currentMonth = 12;
			currentYear = currentYear - 1;
		}else{
			currentMonth = currentMonth - 1;
		}
		
		if(currentMonth2 == 12){
			currentMonth2 = 1;
			currentYear2 = currentYear2 + 1;
		}else{
			currentMonth2 = currentMonth2 + 1;
		}
		
		if(currentMonth<10){
			currentMonth = "0"+currentMonth;
		}
		if(currentMonth2<10){
			currentMonth2 = "0"+currentMonth2;
		}
	    
		$("#billYear1").val(currentYear);
		$("#billYear1").siblings(".selectText").text($("#billYear1 > option:selected").text());
 	    $("#billMonth1").val(currentMonth).attr("selected","selected");
	    $("#billMonth1").siblings(".selectText").text($("#billMonth1 > option:selected").text());

		$("#billYear2").val(currentYear2);
		$("#billYear2").siblings(".selectText").text($("#billYear2 > option:selected").text());
	    
	    $("#billMonth2").val(currentMonth2).attr("selected","selected"); 
	    $("#billMonth2").siblings(".selectText").text($("#billMonth2 > option:selected").text());
	    
	    gridList();
	}
	
	$(document).ready(function() {
		App.init();
		setSearchBox("0");
		setSearchBox("1");
		getNowDate();
// 		gridList();
		
		//메뉴활성화
		$("#priceInquiry").addClass("active");
		$("#taxinvoice").addClass("active");

	});
</script>
</body>
</html>