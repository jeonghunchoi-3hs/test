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
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>정산</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">요금관리</a><a href="#" class="on">정산</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<div class="client_DetailBg m-b-20">
					<input type="hidden" id="h_billYyyymm" value="${billYyyymm}">
					<div class="client_DetailArea p-b-30">
						<h2 class="customer_Id fontVdn" id ="billYm"></h2>
						<p class="company_Name2" id="">
							<span class="txtLabel txtLabel_comp" id="confirmed" style="display: none">확정</span>
							<span class="txtLabel txtLabel_out" id="notConfirmed" style="display: none">미확정</span>
							<span id="procUserName"></span>
							<span> 
								(<span class="f16 fc66 fontN" style="vertical-align: top; display: inline-block; padding-top: 3px;">정산일시 : </span>
								<span class="fontVdn fontN" id="procDatetime"></span>)
							</span>
						</p>
						<p class="company_Info">
							<span class="company_labelf">확정자 :</span><span class="company_cont" id="comfirmUserName"></span>
							<span class="company_label">확정일시 :</span><span class="company_cont fontVdn" id="confirmDatetime"></span>
						</p>
					</div> 
				</div>
				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType02">
					
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a onclick="excelDown();" type='button' class="btnType01 m-r-5"><i class="ico_download"></i><span>다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<h2 class="titleBuType01 m-b-15">고객사별 정산 상세</h2>
					<span class="flr f14 fc33 m-t-10">( 단위 : 원 )</span>
					<div id="disk-list_wrapper" class="dataTables_wrapper form-inline" role="grid">
						<table class="detail_Table dataTable no-footer" id="disk-list" aria-describedby="disk-list_info">
				        	<colgroup>
								<col width="122px">
								<col width="*">
								<col width="125px">
								<col width="107px">
								<col width="107px">
								<col width="125px">
								<col width="107px">
								<col width="132px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">구분</th>
									<th scope="col">고객사</th>
									<th scope="col">클라우드 요금</th>
									<th scope="col">요금할인</th>
									<th scope="col">보정</th>
									<th scope="col">사용요금</th>
									<th scope="col">부가가치세</th>
									<th scope="col">청구금액</th>
								</tr>
							</thead>
							<tbody class="hg60" id="calcDiv">
								
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="row tac m-t-40">	
					<a type='button' class="btnType03 btnType03_list" onclick="moveListPage();">목록</a>         
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

	// 정산 상세 
	function getDetail() {
		
		var billYyyymm = $("#h_billYyyymm").val();
		
		$.ajax({
			url : "${contextPath}/mng/charge/bill/calculateDetailList",
			dataType : "JSON",
			data : {
				"billYyyymm" : billYyyymm
			},
			success : function(data) {
				var result = data;
				
				$("#calcDiv").empty();
				var a000Tot = 0;
				var e000Tot = 0;
				var i000Tot = 0;
				var usedTot = 0;
				var l000Tot = 0;
				var totAmount = 0;
				var confirmFlag = "";
				
				var comfirmUserName = "";
				var confirmDatetime = "";
				var procUserName = "";
				var procDatetime = "";
				var Html = "";
				
				var idx = 1;
				
				if(result != ""){
					$.each(result,function(key,val){
						
						if(idx == result.length){
							Html += "<tr class='lastLow'>";
						}else{
							Html += "<tr>";
						}	
						Html += "	<td class='tac p-0'>"+val["companyName"]+"</td>";
						Html += "	<td class='tal'>"+val["customerName"]+"</td>";
						Html += "	<td class='tar fontVdn numCol'>"+addcomma(val["a000Amount"])+"</td>";
						Html += "	<td class='tar fontVdn numCol'>"+addcomma(val["e000Amount"])+"</td>";
						Html += "	<td class='tar fontVdn numCol'>"+addcomma(val["i000Amount"])+"</td>";
						Html += "	<td class='tar fontVdn numCol'>"+addcomma(val["usedAmount"])+"</td>";
						Html += "	<td class='tar fontVdn numCol'>"+addcomma(val["l000Amount"])+"</td>";
						Html += "	<td class='tar fontVdn numCol fc11  lastCol'>"+addcomma(val["amount"])+"</td>"; 
						Html += "</tr>"; 
						
						
						a000Tot += Number(val["a000Amount"]); 
						e000Tot += Number(val["e000Amount"]);
						i000Tot += Number(val["i000Amount"]);
						usedTot += Number(val["usedAmount"]);
						l000Tot += Number(val["l000Amount"]);
						totAmount += Number(val["amount"]);
						
						confirmFlag = val["confirnFlag"];
						
						comfirmUserName = val["comfirmUserName"];
						confirmDatetime = val["confirmDatetime"];
						procUserName = val["procUserName"];
						procDatetime = val["procDatetime"];
						
						if(comfirmUserName == "" || comfirmUserName == null){
							comfirmUserName = "-";
						}
						if(confirmDatetime == "" || confirmDatetime == null){
							confirmDatetime = "-";
						}
						if(procUserName == "" || procUserName == null){
							procUserName = "-";
						}
						if(procDatetime == "" || procDatetime == null){
							procDatetime = "-";
						}
						
						idx++;
						
					});
					
					Html += "<tr class='sumRow2'>";
					Html += "	<td class='tac p-0 f20 fc11 p-l-75' colspan='2'>합계</td>";
					Html += "	<td class='tar fontVdn numCol fc11'>"+addcomma(a000Tot)+"</td>";
					Html += "	<td class='tar fontVdn numCol fc11'>"+addcomma(e000Tot)+"</td>";
					Html += "	<td class='tar fontVdn numCol fc11'>"+addcomma(i000Tot)+"</td>";
					Html += "	<td class='tar fontVdn numCol fc11'>"+addcomma(usedTot)+"</td>";
					Html += "	<td class='tar fontVdn numCol fc11'>"+addcomma(l000Tot)+"</td>";
					Html += "	<td class='tar fontVdn numCol fc11 fontB blue  lastCol'>"+addcomma(totAmount)+"</td>"; 
					Html += "</tr>";
					
					$("#calcDiv").html(Html);	
					
					if(confirmFlag=="Y"){
						$("#confirmed").show();
						$("#notConfirmed").hide();
					}else{
						$("#confirmed").hide();
						$("#notConfirmed").show();
					}
					
					$("#comfirmUserName").text(comfirmUserName);
					$("#confirmDatetime").text(confirmDatetime);
					$("#procUserName").text(procUserName);
					$("#procDatetime").text(procDatetime);
					
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
		
		
	}
	
	
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/charge/bill/calculateListPage";
	}
	
	$(document).ready(function() {
		App.init();
		getDetail();
		
		var billYyyymm = "${billYyyymm}";
		$("#billYm").text(billYyyymm.substring(0,4)+'-'+billYyyymm.substring(4,6));
		
		
		//메뉴활성화
		$("#chargeManagement").addClass("active");
		$("#calculate").addClass("active");
	});	
	
</script>
</body>
</html>