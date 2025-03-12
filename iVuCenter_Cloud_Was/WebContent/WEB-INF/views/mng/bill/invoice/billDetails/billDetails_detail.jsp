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
						<h2 class="blueBoxTitle">프로젝트정보</h2>
						<p class="customer_Name"><span id="upCompanyName">쓰리에이치에스</span><span class="company_Name" id="downCompanyName">솔루션사업부</span></p>
						<p class="company_Info m-b-25"> 
							<span class="company_labelf">구분 :</span><span class="company_cont" id="companyName">쓰리에이치에스</span>
							<span class="company_label">고객사 :</span><span class="company_cont" id="companyName">솔루션사업부</span>
							<span class="company_label">조회기간 :</span><span class="company_cont fontVdn" id="companyName">2017-09 ~ 2017-11</span>
						</p>
					</div> 
				</div>
				
				
				 <div class="mt15">
					 <!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a onclick="excelDown();" type='button' class="btnType01 m-r-5"><i class="ico_download"></i><span>다운로드</span></a>
					</div>
					<h2 class="titleBuType01">자원별 요금현황</h2>
					<span class="flr f14 fc33 m-t-8">(단위:원, VAT별도)</span>
					<!-- //상단 버튼  -->
			        <table class="detail_Table m-t-15" id="">
			        	<colgroup>
					 		<col width="105px">
					 		<col width="120px">
					 		<col width="165px">
					 		<col width="160px">
					 		<col width="160px">
					 		<col width="67px">
					 		<col width="*">
					 		<col width="65px">
					 	</colgroup> 
						<thead>
						    <tr class="grey">
								<th class="tac">청구년월</th>
								<th class="tac">자원구분</th>
								<th class="tac">자원명</th>
								<th class="tac">과금시작</th>
								<th class="tac">과금종료</th>
								<th class="tac">과금단위</th>
								<th class="tac">사용금액</th>
								<th class="tac">상세</th>
							</tr>
						</thead>
						<tbody id="">
							<tr>
								<td class="tac fontVdn">2017-11</td>
								<td class="tac">기본자원</td>
								<td class="tac ls1">리뷰NMWAAPD021</td>
								<td class="tac fontVdn f15 ls1 p-0">2017-10-31 23:59</td>
								<td class="tac fontVdn f15 ls1 p-0">2017-10-31 23:59</td>
								<td class="tac">월</td>
								<td class="tar fontVdn fc11 ls1">122,214,540</td>
								<td class="tac lastCol onwrap"><a class="btn_viewDetail_gray" onclick="openPopup(1);"></a></td>
							</tr>
							<tr>
								<td class="tac fontVdn">2017-11</td>
								<td class="tac">부가자원</td>
								<td class="tac ls1">리뷰NMWAAPD021</td>
								<td class="tac fontVdn f15 ls1 p-0">2017-10-31 23:59</td>
								<td class="tac fontVdn f15 ls1 p-0">2017-10-31 23:59</td>
								<td class="tac">월</td>
								<td class="tar fontVdn fc11 ls1">122,214,540</td>
								<td class="tac lastCol onwrap"><a class="btn_viewDetail_gray" onclick="openPopup(2);"></a></td>
							</tr>
							<tr>
								<td class="tac fontVdn">2017-11</td>
								<td class="tac">서비스</td>
								<td class="tac ls1">리뷰NMWAAPD021</td>
								<td class="tac fontVdn f15 ls1 p-0">2017-10-31 23:59</td> 
								<td class="tac fontVdn f15 ls1 p-0">2017-10-31 23:59</td>
								<td class="tac">시간</td>
								<td class="tar fontVdn fc11 ls1">122,214,540</td>
								<td class="tac lastCol onwrap"><a class="btn_viewDetail_gray" onclick="openPopup(3);"></a></td>
							</tr>
						</tbody>
					</table>
					<div class="salesDetailTotalBg">
						<span class="f20 fc11 p-l-50">합계</span>
						<span class="flr p-r-10"><span class="salesDetailTotal fontVdn fontB" id="totalAmount">999,999,999</span><span class="f14 fc66">원</span></span>
				    </div>
				</div>
				
				
				<div class="m-t-40">
					<h2 class="titleBuType01">요금할인 현황</h2>
					<span class="flr f14 fc33 m-t-8">금액( 단위 : 원 )/부가가치세별도</span>
					<!-- //상단 버튼  -->
			        <table class="detail_Table m-t-15" id="">
			        	<colgroup>
					 		<col width="180px">
					 		<col width="420px">
					 		<col width="*">
					 	</colgroup> 
						<thead>
						    <tr class="grey">
								<th class="tac">청구년월</th>
								<th class="tac">할인율(%)</th>
								<th class="tac">할인금액</th>
							</tr>
						</thead>
						<tbody id="">
							<tr>
								<td class="tac fontVdn">2017-11</td>
								<td class="tac fontVdn">6</td>
								<td class="tar fontVdn lastCol fc11 ls1 p-r-30">122,214,540</td>
							</tr>
							<tr>
								<td class="tac fontVdn">2017-11</td>
								<td class="tac fontVdn">6</td>
								<td class="tar fontVdn lastCol fc11 ls1 p-r-30">122,214,540</td>
							</tr>
						</tbody>
					</table>
					<div class="salesDetailTotalBg">
						<span class="f20 fc11 p-l-50">합계</span>
						<span class="flr p-r-10"><span class="salesDetailTotal fontVdn fontB" id="totalAmount">999,999,999</span><span class="f14 fc66">원</span></span>
				    </div>
				</div>
				
				<div class="m-t-40">
					<h2 class="titleBuType01">보정 현황</h2>
					<span class="flr f14 fc33 m-t-8">금액( 단위 : 원 )/부가가치세별도</span>
					<!-- //상단 버튼  -->
			        <table class="detail_Table m-t-15" id="">
			        	<colgroup>
					 		<col width="180px">
					 		<col width="420px">
					 		<col width="*">
					 	</colgroup> 
						<thead>
						    <tr class="grey">
								<th class="tac">청구년월</th>
								<th class="tac">보정항목</th>
								<th class="tac">보정방식</th>
								<th class="tac">보정금액</th>
							</tr>
						</thead>
						<tbody id="">
							<tr>
								<td class="tac fontVdn">2017-11</td>
								<td class="tal">요금할인</td>
								<td class="tac">금액</td>
								<td class="tar fontVdn lastCol fc11 ls1 p-r-30">122,214,540</td>
							</tr>
							<tr>
								<td class="tac fontVdn">2017-11</td>
								<td class="tal">서비스장애</td>
								<td class="tac">비율(<span class="fontVdn fcde4e4e">2%</span>)</td>
								<td class="tar fontVdn lastCol fc11 ls1 p-r-30">122,214,540</td>
							</tr>
						</tbody>
					</table>
					<div class="salesDetailTotalBg">
						<span class="f20 fc11 p-l-50">합계</span>
						<span class="flr p-r-10"><span class="salesDetailTotal fontVdn fontB" id="totalAmount">999,999,999</span><span class="f14 fc66">원</span></span>
				    </div>
				</div>
				<!-- search end -->
				<div class="row tac m-t-40">	
					<a type='button' class="btnType03 btnType03_prev" onclick="moveDetailPage();">이전</a>
					<a type='button' class="btnType03 btnType03_list m-l-15" onclick="moveListPage();">목록</a>         
				</div>
	
			</div>
			<!-- end page-body -->
			<!-- #modal-dialog -->
            <div class="modal fade" id="modal-dialog"> 
				<div class="modal-dialog">
   					<div class="modal-content width-570">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
							<h4 class="modal-title">자원 요금 상세</h4>
                       	</div>
						<div class="modal-body">
							<div class="invoiceInfoTop">
								<p class="f16 fc11">[기본자원]</p>
								<p style="margin-top: 13px;">
									<span class="f16 fc66">자원명&ensp;&ensp; :&nbsp;</span>
									<span class="f18 fc11">리뷰호스트0805_31리뷰호스트</span>
								</p>
								<p class="m-t-10">
									<span class="f16 fc66">과금단위 :&nbsp;</span>
									<span class="f18 fc11">월</span>
									<span class="f16 fontVdn fc3f99b7">(2017-10-31 12:00 ~ 2017-10-31 12:00)</span>
								</p>
							</div>
							<div class="invoiceInfoTotal">
								<span class="fl fc11 f18">금액</span>
								<span class="flr">
									<span class="fontVdn f30 fcde4e4e ls1">88,888,888</span>
									<span class="f18 fc66">원</span>
								</span>
							</div>
							<div class="invoiceInfoList">
								<ul>
									<li>
										<p class="fl w100">
											<span class="fontVdn f15 fc66 dpin tal fl" style="width:80px">CPU</span>
											<span class="fontVdn f15 fc11 dpin tar fl p-r-10" style="width:80px">1Core</span>
											<span class="fontVdn f15 fc66 dpin tar flr" >2017-08-01 12:00~2017-08-31 12:00</span>
										</p>
										<p class="flr m-t-15">
											<span class="fontVdn f18 fc66">887,531</span>
											<span class="f14 fc99">원</span>
										</p>
									</li>
									<li>
										<p class="fl w100">
											<span class="fontVdn f15 fc66 dpin tal fl" style="width:80px">MEMORY</span>
											<span class="fontVdn f15 fc11 dpin tar fl p-r-10" style="width:80px">1GB</span>
											<span class="fontVdn f15 fc66 dpin tar flr" >2017-08-01 12:00~2017-08-31 12:00</span>
										</p>
										<p class="flr m-t-15">
											<span class="fontVdn f18 fc66">887,531</span>
											<span class="f14 fc99">원</span>
										</p>
									</li>
									<li>
										<p class="fl w100">
											<span class="fontVdn f15 fc66 dpin tal fl" style="width:80px">DISK</span>
											<span class="fontVdn f15 fc11 dpin tar fl p-r-10" style="width:80px">9,999GB</span>
											<span class="fontVdn f15 fc66 dpin tar flr" >2017-08-01 12:00~2017-08-31 12:00</span>
										</p>
										<p class="flr m-t-15">
											<span class="fontVdn f18 fc66">887,531</span>
											<span class="f14 fc99">원</span>
										</p>
									</li>
								</ul>
							</div>
                   		</div>
	                   	<div class="modal-footer tac">
                       		<a type="button" class="whiteline" data-dismiss="modal" onclick="initPopup();">닫기</a>
                       	</div>
	               	</div>
				</div>
            </div>	
			<!-- #modal-dialog -->
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
	
	function moveDetailPage(policySeq){
		location.href = "${contextPath}/mng/bill/invoice/billDetails/viewPage?viewSeq="+policySeq;
	}
	function openPopup(type){
		$("#modal-dialog").modal(); 
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