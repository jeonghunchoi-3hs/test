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
				<h1>요금상세</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">요금 조회</a><a href="#" class="on">요금상세</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50"> 
				<div class="client_DetailBg m-b-20">
					<input type="hidden" id="h_projectId" value="" data-original-title="" title="">
					<input type="hidden" id="h_billYyyymm" value="" data-original-title="" title="">
					<div class="client_DetailArea">
						<p class="customer_Name" style="margin-top: 32px;"><span id="upCompanyName"></span><span class="company_Name" id="downCompanyName"></span></p>
						<p class="company_Info m-b-25"> 
							<span class="company_labelf">조회기간 :</span><span class="company_cont fontVdn" id="companyName">2017-09 ~ 2017-11</span>
						</p>
					</div> 
				</div>
				
				
				 <div class="mt15">
					 <!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a onclick="excelDown();" type='button' class="btnType01 m-r-5"><i class="ico_download"></i><span>다운로드</span></a>
					</div>
					<h2 class="titleBuType01">프로젝트별 요금현황</h2>
					<span class="flr f14 fc33 m-t-8">(단위:원, VAT별도)</span>
					<!-- //상단 버튼  -->
			        <table class="detail_Table m-t-15" id="">
			        	<colgroup>
					 		<col width="*">
					 		<col width="126px">
					 		<col width="126px">
					 		<col width="126px">
					 		<col width="115px">
					 		<col width="115px">
					 		<col width="126px">
					 		<col width="65px">
					 	</colgroup> 
						<thead>
						    <tr class="grey">
								<th class="tac">프로젝트명</th>
								<th class="tac">기본자원</th>
								<th class="tac">부가자원</th>
								<th class="tac">서비스</th>
								<th class="tac">요금할인</th>
								<th class="tac">보정금액</th>
								<th class="tac">사용금액</th>
								<th class="tac">상세</th>
							</tr>
						</thead>
						<tbody id="detailView">
							<tr>
								<td class="tac">아이뷰몰 프로젝트</td>
								<td class="tar fontVdn ls1"></td>
								<td class="tar fontVdn ls1"></td>
								<td class="tar fontVdn ls1"></td>
								<td class="tar fontVdn ls1"></td>
								<td class="tar fontVdn ls1"></td>
								<td class="tar fontVdn fc11 ls1"></td>
								<td class="tac lastCol"><a class="btn_viewDetail_gray" onclick="moveDetailPage();"></a></td>
							</tr>
							<tr>
								<td class="tac"></td>
								<td class="tar fontVdn ls1"></td>
								<td class="tar fontVdn ls1"></td>
								<td class="tar fontVdn ls1"></td>
								<td class="tar fontVdn ls1"></td>
								<td class="tar fontVdn ls1"></td>
								<td class="tar fontVdn fc11 ls1"></td>
								<td class="tac lastCol"><a class="btn_viewDetail_gray" onclick="moveDetailPage();"></a></td>
							</tr>
							<tr class="sumRow2">
								<td class="tac p-0 f20 fc11">합계</td>
								<td class="tar fontVdn ls1 fc11"></td>
								<td class="tar fontVdn ls1 fc11"></td>
								<td class="tar fontVdn ls1 fc11"></td>
								<td class="tar fontVdn ls1 fc11"></td>
								<td class="tar fontVdn ls1 fc11"></td>
								<td class="tar fontVdn ls1 fc11 fontB blue p-0 p-r-15"></td>
								<td class="tac lastCol"></td>
							</tr>		
						</tbody>
					</table>
				</div>
				<!-- search end -->
				<div class="row tac m-t-40">	
					<a type='button' class="btnType03 btnType03_list" onclick="moveListPage();">목록</a>         
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

	function moveListPage(){
		location.href = "${contextPath}/mng/bill/invoice/billDetails/";
	}
	function moveDetailPage(){
		location.href = "${contextPath}/mng/bill/invoice/billDetails/detail";
	}
	$(document).ready(function(){
	
		App.init();
		
		//메뉴활성화
		$("#priceInquiry").addClass("active");
		$("#billDetails").addClass("active");
	
	});

</script>
</body>
</html>