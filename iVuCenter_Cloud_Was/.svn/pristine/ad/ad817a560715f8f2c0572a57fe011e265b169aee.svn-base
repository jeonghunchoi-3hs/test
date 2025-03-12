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
				<h1>요금상세 목록</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">요금 조회</a><a href="#" class="on">요금상세</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<div class="page_searchBox m-b-15">
					<input type="hidden" id="h_customerId" value="" data-original-title="" title="">
					<div class="searchArea">
						<div class="selectBox m-r-5" style="width:130px;">
							<label class="selectText" for="">구분</label>
							<select class="search-sel" id="">
								<option value="">구분</option>
							</select>
						</div>
						<div class="selectBox m-r-45" style="width:235px;">
							<label class="selectText" for="">고객사명</label>
							<select class="search-sel" id="">
								<option value="">고객사명</option>
							</select>
						</div>
						<div class="selectBox" style="width:90px;">
							<label class="selectText" for="billYear1"></label>
							<select class="search-sel" id="billYear1">
											
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
									<option value="">전체</option>
									<option value="project_alias">프로젝트명</option>
								</select>
							</div>
							<div class="inputArea m-l-5">
								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 650px" data-original-title="" title="">
								<a type="button" class="btn_search" onclick="gridList()">검색</a>
							</div>	
						</div>	
					</div>
				</div>
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a onclick="excelDown();" type='button' class="btnType01 m-r-5"><i class="ico_download"></i><span>다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<span class="fl f14 fc33 m-t-8">[조회기간] <span class="fontVdn f16 fc66">2017-09 ~2017-11</span></span>
					<span class="flr f14 fc33 m-t-8">(단위:원, VAT별도)</span>
					
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-35"> 
						<table id="invoice-list">
							<colgroup>
								<col width="*">
								<col width="130px">
								<col width="130px">
								<col width="125px">
								<col width="120px">
								<col width="120px">
								<col width="130px">
								<col width="65px">
							</colgroup>
							<thead>
								<tr>
									<th class="tac">고객사</th>
									<th class="tac">기본자원</th>
									<th class="tac">부가자원</th>
									<th class="tac">서비스</th>
									<th class="tac">요금할인</th>
									<th class="tac">보정금액</th>
									<th class="tac">사용금액</th>
									<th class="tac">상세</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach begin="1" end="10" var="i">
									<tr>
										<td class="tal">쓰리에이치에스쓰리에이치에스</td>
										<td class="tar fontVdn p-r-15 ls-1">888,888,888</td>
										<td class="tar fontVdn p-r-15 ls-1">888,888,888</td>
										<td class="tar fontVdn p-r-15 ls-1">888,888,888</td>
										<td class="tar fontVdn p-r-15 ls-1">888,888,888</td>
										<td class="tar fontVdn p-r-15 ls-1">888,888,888</td>
										<td class="tar fontVdn p-r-15 ls-1 name">888,888,888</td>
										<td>
											<a type='button' class="btn_viewDetail" onclick="moveDetailPage(${i});"></a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				
				
			</div>
				
			<!-- end page-body -->
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->


<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
	function moveDetailPage(policySeq){
		location.href = "${contextPath}/mng/bill/invoice/billDetails/viewPage?viewSeq="+policySeq;
	}
	function getNowDate(){
		var currentYear = (new Date()).getFullYear();
		
	    var years="";
	    var html = "";
	    for(var i=0; i < 5 ; i++){
	    	years = (currentYear + 1) - i;
	    	html += "<option value='"+years+"'>"+ years +"</option>";
	    }

	    $("#billYear1").html(html);
	    $("#billYear2").html(html);

	    // 당월 선택
		var currentMonth = (new Date()).getMonth()+1;
		if(currentMonth<10){
			currentMonth = "0"+currentMonth;
		}
	    
		$("#billYear1").val(currentYear);
		$("#billYear1").siblings(".selectText").text($("#billYear1 > option:selected").text());
 	    $("#billMonth1").val(currentMonth).attr("selected","selected");
	    $("#billMonth1").siblings(".selectText").text($("#billMonth1 > option:selected").text());

		$("#billYear2").val(currentYear);
		$("#billYear2").siblings(".selectText").text($("#billYear2 > option:selected").text());
	    
	    $("#billMonth2").val(currentMonth).attr("selected","selected"); 
	    $("#billMonth2").siblings(".selectText").text($("#billMonth2 > option:selected").text());
	}
	
	$(document).ready(function(){
	
		App.init();
		getNowDate();
		
		//메뉴활성화
		$("#priceInquiry").addClass("active");
		$("#billDetails").addClass("active");
	
	});

</script>
</body>
</html>