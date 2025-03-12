<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<div>
		<iframe id='iframeBasket' name='iframeBasket' style='display:none; border:0px;'></iframe>
	</div>

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
			<h1 class="page-header"><span class="root"> <span class="home"><img src="${apachePath}/resources/assets/img/ico_home.png"  alt="홈"/></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow"><a href="${wasPath}/mbr/req/catalogue/catalogueList.do">자원신청</a></span><span class="text arrow"><a href="${wasPath}/mbr/req/catalogue/catalogueBasic.do?hourlyFlag=N">기본자원</a></span><span class="text arrow mint"><a href="${wasPath}/mbr/req/catalogue/catalogueBasic.do?hourlyFlag=N"><strong>신청</strong></a></span></span></h1>
			<!-- end header -->

			 <!-- begin page-body -->
			 <div class="row mb50">
			 	<p class="page_title">기본자원</p>  

				<!----첫번째 자원내용 ------->
				<c:set var="totalPrice" value="" />
				<c:set var="cpuPrice" value="" />
				<c:set var="memPrice" value="" />
				<c:set var="memPrice1" value="" />
				<c:set var="diskPrice" value="" />
				<c:set var="diskPrice1" value="" />
				<c:set var="osPrice" value="" />
				<c:set var="priceTypeTxt" value="" />
				<c:choose>
					<c:when test="${getCatalogueSelectView.hourlyFlag eq 'Y'}">
						<c:set var="cpuPrice" value="${getCatalogueSelectView.cpuHourlyPrice}" />
						<c:set var="memPrice" value="${getCatalogueSelectView.memGb * getCatalogueSelectView.memHourlyPrice}" />
						<c:set var="memPrice1" value="${getCatalogueSelectView.memHourlyPrice}" />						
						<c:set var="diskPrice" value="${getCatalogueSelectView.vmDiskHourlyPrice * 10}" />
						<c:set var="diskPrice1" value="${getCatalogueSelectView.vmDiskHourlyPrice * getCatalogueSelectView.vmDiskGb / 10}" />
						<c:set var="totalPrice" value="${getCatalogueSelectView.vcpus * cpuPrice + memPrice + diskPrice1}" />
						
					</c:when>
					<c:otherwise>
						<c:set var="cpuPrice" value="${getCatalogueSelectView.cpuMonthlyPrice}" />
						<c:set var="memPrice" value="${getCatalogueSelectView.memGb * getCatalogueSelectView.memMonthlyPrice}" />
						<c:set var="memPrice1" value="${getCatalogueSelectView.memMonthlyPrice}" />
						<c:set var="diskPrice" value="${getCatalogueSelectView.vmDiskMonthlyPrice * 10}" />
						<c:set var="diskPrice1" value="${getCatalogueSelectView.vmDiskMonthlyPrice * getCatalogueSelectView.vmDiskGb / 10}" />
						<c:set var="totalPrice" value="${getCatalogueSelectView.vcpus * cpuPrice +  memPrice + diskPrice1}" />						
					</c:otherwise>
				</c:choose>
				
				<!----첫번째 자원내용 끝------->
				<div class="productTotalArea">
					<div class="productTitleArea">
						<img src="${apachePath}/resources/assets/img/catalogIcon01.png" class="pt10"/>
						<span class="productTitle">${getCatalogueSelectView.displayName}</span>
						<p class="productsubTitle">
						<c:if test="${getCatalogueSelectView.descriptionTop eq null or getCatalogueSelectView.descriptionTop eq ''}">
						고객사의 사업을 더욱더 활성화하고 성공비지니스를 안겨 줄 것 입니다
						</c:if>
						<c:if test="${getCatalogueSelectView.descriptionTop ne null or getCatalogueSelectView.descriptionTop ne ''}">
						${getCatalogueSelectView.descriptionTop}
						</c:if>
						</p>
					</div>
					<div class="productInfoArea"> 
						<div class="productAreaLine">
							<img src="${apachePath}/resources/assets/img/icon_cpu.png"/>
							<span class="productInfo">${getCatalogueSelectView.vcpus} Core</span>
						</div>
						<div class="productAreaLine">
							<img src="${apachePath}/resources/assets/img/icon_mem.png"/>
							<span class="productInfo"> ${getCatalogueSelectView.memGb} GB </span>
						</div>
						<div class="productAreaNoLine">
							<img src="${apachePath}/resources/assets/img/icon_disk.png"/>
							<span class="productInfo"> ${getCatalogueSelectView.vmDiskGb} GB</span>
						</div>

						<div class="productSubInfo"> 
						<c:if test="${getCatalogueSelectView.description eq null or getCatalogueSelectView.description eq ''}">
						기본자원 설명입니다.
						</c:if>
						<c:if test="${getCatalogueSelectView.description ne null or getCatalogueSelectView.description ne ''}">
						${getCatalogueSelectView.description}
						</c:if>
						
						</div> 
					</div>
				</div>
				<!----첫번째 자원내용 끝------->
				
				
				<div class="clear"></div>
				<h4 class="orderTitle">신청정보</h4>				
				<div class="orderArea">
					<div class="tableF">
					<form name="catalogueform"  id="catalogueform" action="${wasPath}/mbr/req/catalogue/catalogueOrderNow.do" method="post" >
					<input type="hidden" name="imagePath" id="imagePath" value="${getCatalogueSelectView.imagePath}" />
					<input type="hidden" name="imageName" id="imageName" value="${getCatalogueSelectView.imageName}" />
					<input type="hidden" name="type" id="type" value="noworder" />
					<input type="hidden" name="productSeq" id="productSeq" value="${getCatalogueSelectView.productSeq}" />
					<input type="hidden" name="totalPrice" id="totalPrice" value="${totalPrice}" />
					<input type="hidden" name="productCategory" id="productCategory" value="${getCatalogueSelectView.productCategory}" />
					<input type="hidden" name="networkChk" id="networkChk" value="" />
					<input type="hidden" name="catalogSeq" id="catalogSeq" value="${getCatalogueSelectView.catalogSeq}" />
					<input type="hidden" name="networkAlias" id="networkAlias" value="" />
					<input type="hidden" name="hiddenUserIdReview" id="hiddenUserIdReview" value="" />
					<input type="hidden" name="hiddenUserNameReview" id="hiddenUserNameReview" value="" />
					<input type="hidden" name="hiddenUserIdApprove" id="hiddenUserIdApprove" value="" />
					<input type="hidden" name="hiddenUserNameApprove" id="hiddenUserNameApprove" value="" />
					
					<table>
						<colgroup>
						<col width="190px">
						<col width="*">
						</colgroup>
						<tbody>
						<tr>
						<td class="left">이용요금</td>
							<td>
								<label><input type="radio" id="hourlyFlag1" name="hourlyFlag" value="N" checked class="va-tb"/> <span class="mr50">월 </span></label> <label><input type="radio" id="hourlyFlag2" name="hourlyFlag" value="Y" class="va-tb"/> 시간 </span></label>
							</td>
						</tr>						
						<tr>
						<td class="left-t">서비스희망일시</td>
						<td>
							<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성</label> &nbsp; &nbsp; 				
							<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> 희망일시 생성</label>	 <br/>
							<p class="fcsb f16 mt10"><img src="${apachePath}/resources/assets/img/icon_tpoint.png"/> 승인 완료 후 생성 선택시 클라우드 관리자의 최종승인 완료 후 가상머신이 생성이 됩니다. </p>
						</td>
						</tr>
						<tr id="sdate" name="sdate" style="display:none">
						<td class="left"></td>
						<td>
						<div>
							<input type="text" class="form-control dpin w138" id="applyDate" name="applyDate" />
							<div class="searchBoxArea w110 ml26">   
								<div class="">
									<label class="selectBoxDrop" for="applyTime">18</label>
									<select class="search-sel" name="applyTime" id="applyTime">
										<c:forEach var="time" begin="1" end="24">
											<c:if test="${time eq 18}">
												<option value="${time}" selected="selected">${time}</option>
											</c:if>
											<c:if test="${time ne 18}">
												<option value="${time}" >${time}</option>
											</c:if>
										</c:forEach>
									</select>
								</div> 
							</div>
							<span class="fc33 f16 lh34 ml5">시</span>
							<!-- <img src="/resources/assets/img/icon_minus.png"  onclick="applyTimeMinus();" class="minus ml22"/> 
							<input type="text" class="snemo ml-4 " placeholder="18:00"  value="18" id="applyTime" name="applyTime"  readonly/>
							<img src="/resources/assets/img/icon_plus.png"  onclick="applyTimePlus();" class="plus"/> --> 
						</div>			
						</td>
						</tr>
						<tr>
						<td class="left">프로젝트명</td>
						<td>
							<input class="form-control w706" type="text" name="projectAlias" id="projectAlias" readonly="readonly"/> 
							<input class="form-control" type="hidden" name="projectName" id="projectName" /> 
							<input type="hidden" name="projectId" id="projectId" value="" />
							<img src="${apachePath}/resources/assets/img/icon_search.png" onclick="openModal();" class="input_search"/> 	
						</td>
						</tr>
						<tr>
						<td class="left">네트워크망</td>
						<td>
						<div id="divNetwork" class=""><input class="form-control" type="text" readonly="readonly"/></div>			
						</td>
						</tr>
						<tr>
						<td class="left">호스트명</td>
						<td>
						<input type="hidden" id="confirmFlag" value="">
						<span data-toggle="tooltip" data-html="true" title="<div class='tal'>식별 가능한 영문 호스트명을 <br/>입력하세요.<br/>예) NMBOWSP02</div>">
						<input class="form-control w649" type="text" name="hostname" id="hostname" style="ime-mode:disabled;"/>
						</span>
						<img src="${apachePath}/resources/assets/img/icon_check.png" onclick="hostnameChk();" class="check"/>
						</td>
						</tr>
						<tr>
						<td class="left">서버명</td>
						<td>
						<span data-toggle="tooltip" data-html="true" title="<div class='tal'>식별 가능한 서버명을 입력하세요.<br/>예) 백오피스WAS#2</div>">
						<input class="form-control w100 pull-left" type="text" name="hostnameAlias" id="hostnameAlias" />
						</span>
						</td>
						</tr>						
						<tr>
						<td class="left">CPU</td>
						<td>
						<div class=""> 
							<input class="form-control w138" type="text"  placeholder="1" value="${getCatalogueSelectView.vcpus}" maxlength="2" name="cpucnt" id="cpucnt" onblur="setProductPrice();"/> <p class="inputUnit" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" /> Core</p> 
							<input type="hidden" name="cpuprice" id="cpuprice" value='<fmt:formatNumber value="${cpuPrice}" pattern="####"/>'>
							<img src="${apachePath}/resources/assets/img/icon_minus.png"  onclick="cpuminus();" class="minus"/><span class="snemo">1</span> <img src="${apachePath}/resources/assets/img/icon_plus.png" onclick="cpuplus();" class="plus"/>
							<span id="cpupriceview" name="cpupriceview" class="flr f18 fc66"><span class="listwon nanumR"><fmt:formatNumber value="${cpuPrice * getCatalogueSelectView.vcpus}" pattern="#,###"/></span>&nbsp;원</span>
						</div>
						</td>
						</tr>
						<tr>
						<td class="left">Memory</td>
						<td>
						<div class="">
						<input class="form-control w138" type="text"  placeholder="1" value="${getCatalogueSelectView.memGb}" maxlength="3" name="memcnt" id="memcnt" onblur="setProductPrice();" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" /> <p class="inputUnit"> GB </p>
							<input type="hidden" name="memprice" id="memprice" value='<fmt:formatNumber value="${memPrice}" pattern="####"/>'>
							<input type="hidden" name="memPrice1" id="memPrice1" value='<fmt:formatNumber value="${memPrice1}" pattern="####"/>'>	
							<img src="${apachePath}/resources/assets/img/icon_minus.png"  onclick="memminus();" class="minus"/><span class="snemo">1</span> <img src="${apachePath}/resources/assets/img/icon_plus.png" onclick="memplus();" class="plus"/>						
							<span id="mempriceview" name="mempriceview" class="flr f18 fc66"><span class="listwon nanumR"><fmt:formatNumber value="${memPrice}" pattern="#,###"/></span>&nbsp;원</span>
						</div>

						</td>
						</tr>
						<tr>
						<td class="left">DISK</td>
						<td>
						<div class="">
							<input class="form-control w138" type="text"  placeholder="1" value="${getCatalogueSelectView.vmDiskGb}" maxlength="5" name="diskcnt" id="diskcnt" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" onfocusout="diskfocusout(this);" onkeyup="diskchange(this);" /> <p class="inputUnit"> GB </p> 
							<input type="hidden" name="diskprice" id="diskprice" value='<fmt:formatNumber value="${diskPrice}" pattern="####"/>'>
							<input type="hidden" name="diskprice1" id="diskprice1" value='<fmt:formatNumber value="${diskPrice1}" pattern="####"/>'>
							<img src="${apachePath}/resources/assets/img/icon_minus.png"  onclick="diskminus();" class="minus"/><span class="snemo">10</span> <img src="${apachePath}/resources/assets/img/icon_plus.png" onclick="diskplus();" class="plus"/>
						
							<span id="diskpriceview" name="diskpriceview" class="flr f18 fc66">
							<span class="listwon nanumR"><fmt:formatNumber value="${diskPrice1}" pattern="#,###"/></span> 원</span>
							<input type="hidden" name="imdiskprice" id="imdiskprice" value="<fmt:formatNumber value="${diskPrice}" pattern="####"/>" />
							<input type="hidden" name="imdiskcnt" id="imdiskcnt" value="<fmt:formatNumber value="${getCatalogueSelectView.vmDiskGb}" pattern="####"/>" />
						</div>
						</td>
						</tr>
						<tr>
						<td class="left">OS</td>
						<td>
						<div class="searchBoxArea">
							<div class="">
								<label class="selectBoxDrop" for="osProductSeq">OS 선택</label>
								<select class="search-sel" name="osProductSeq" id="osProductSeq" onchange="osselect();">
									<option value="">OS 선택</option>
									<c:forEach items="${getCatalogueOslist}" var="getCatalogueOslist" varStatus="status" >
									<option value="${getCatalogueOslist.productSeq}">${getCatalogueOslist.productName}</option>								
									</c:forEach>
								</select>
							</div> 
							<input type="hidden" name="imosprice" id="imosprice" value="0"/>
							<input type="hidden" name="himosprice" id="himosprice" value="0"/>
							<input type="hidden" name="mimosprice" id="mimosprice" value="0"/>
						</div>
						<div class="flr">
							<span id="osprice" name="osprice" style="display:none">0</span>  
							<span class="fcsb f16 mt10 lh30"><img src="${apachePath}/resources/assets/img/icon_tpoint.png" class="mr5">사용자 별도 구매</span>		
						</div> 
						</td> 
						</tr>
																
						</tbody>
						</table>
						</form>
				</div>
				
				<div class="appTotal3">	
					<span class="llabel nanumR">총합계<span class="txttotal">(VAT 별도)</span></span>
					<span class="totalwonUnit"><span id="totalpriceview" name="totalpriceview"  class="totalwon nanumR"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/></span>&nbsp;원</span>
					<input type="hidden" name="imamount" id="imamount" value='<fmt:formatNumber value="${totalPrice}" pattern="#,###"/>' />
					<input type="hidden" name="amount" id="amount" value='<fmt:formatNumber value="${totalPrice}" pattern="####"/>' />
				</div> 
				
				<div class="btn_area">	
					<!--  <a type="button" class="bt_w168 bt_buy" onclick="noworder();">구매</a> -->
					<a type="button" class="bt_w168 bt_buy" onclick="openApproveReviewModal();">구매</a> 
					<a type="button" class="bt_w168 bt_basket ml14" onclick="basketorder();">일괄신청</a>
					<a type="button" class="bt_w168 bt_cancle ml14" onclick="moveListPage();">취소</a> 
				</div>
				
			</div>
						
			</div>
			<!-- end page-body -->
			
			
			
			<!-- 결재자 지정 시작 -->
			
			 <!-- #modal-dialog 결재자 지정팝업-->
        <div class="modal fade" id="modal-approve-review-dialog">
            <div class="modal-dialog width-720">
                <div class="modal-content width-720">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title">결재자 지정</h4>
                    </div>
                    <div class="modal-body">
				 	<!-- search begin -->
				 	<div class="col-md-12 bgee modalpop mb20">	
						<div class="" style="text-align: center; display:inline-block;"> 
							<div class="col-md-8"> 
								<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="searchKeyword" data-original-title="" title="">
							</div>
						  	<button type="button" class="btn_search2" onclick="searchCustomer();"><span></span></button>
						</div>
					</div>
				 	<!-- search end -->							   
				   <div>
			   		<input type="hidden" value="" id="h_popCustomerId">
     					<input type="hidden" value="" id="h_popCustomerName">
				   	<table class="table table-bordered table-hover table-striped table-td-valign-middle">
						 <colgroup>
						 <col width="10%">
						 <col width="10%">
						 <col width="10%">
						 <col width="10%">
						 </colgroup>
						 <thead>
						 <tr class="skyblue">
							<th>구분</th>
							<th>이름</th>
							<th>ID</th>
							<th>버튼</th>
						 <tr>
							 <td id="userDeptReview">요청부서(검토)</td>
							 <td id="userNameReview">이름</td>
							 <td id="userIdReview">ID</td>
							 <td>
						  	<button type="button" class="btn_search2" onclick="openReviewModal();"><span></span></button>
							 </td>
						 </tr>
						 <tr>
							 <td id="userDeptApprove">요청부서(승인)</td>
							 <td id="userNameApprove">이름</td>
							 <td id="userIdApprove">ID</td>
							 <td>
						  	<button type="button" class="btn_search2" onclick="openApproveModal();"><span></span></button>
							 </td>
						 </tr>
						 </thead>
				 	</table>
					 </div>
               	</div>
				<div class="clear"></div>
				<div class="modal-footer tac">
             			<a type=button class="lbtn" data-dismiss="modal" onclick="noworder();">확인</a>	 
             			<a type=button class="rbtn" data-dismiss="modal">취소</a> 
                 	</div>
              </div>
           </div>
        </div>
        
        
        
        
      	<!-- 프로젝트 검토자 결재자 지정 팝업 -->
			<!-- #modal-dialog -->
			<div class="modal fade" id="user-modal-review-dialog">
               <div class="modal-dialog">
                   <div class="modal-content w560">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'><span></span></button>
                           <h4 class="modal-title">검토자 결재자 검색</h4>
                       </div>
                       <div class="modal-body">
                       		<div class="page_searchBox m-b-15">
								<div class="searchArea">
									<div class="inputArea m-l-5">
										<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)gridPopList();" style="width: 362px">
										<a type='button' class="btn_search" onclick="gridPopList();">검색</a>
									</div>
								</div>
							</div>
							
							<div class="noneList" id='popListReviewTable2'>
								 <span>검색된 사용자가 없습니다.</span>
							</div> 
							<div class="listArea" id="popListReviewTable" style="display: none;"></div>
                      		<div class="totalcnt" id="totalReviewCnt">총 0 건</div>
	                   	</div>
	                   	<div class="modal-footer tac">
                       		<a type="button" class="whiteline" data-dismiss="modal" >닫기</a>
                       	</div>
	               	</div>
				</div>
           	</div>
			<!-- #modal-dialog --> 
			
			
			
			
			<!-- 프로젝트 승인자 결재자 지정 팝업 -->
			<!-- #modal-dialog -->
			<div class="modal fade" id="user-modal-approve-dialog">
               <div class="modal-dialog">
                   <div class="modal-content w560">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'><span></span></button>
                           <h4 class="modal-title">승인자 검색</h4>
                       </div>
                       <div class="modal-body">
                       		<div class="page_searchBox m-b-15">
								<div class="searchArea">
									<div class="inputArea m-l-5">
										<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)gridPopApproveList();" style="width: 362px">
										<a type='button' class="btn_search" onclick="gridPopApproveList();">검색</a>
									</div>
								</div>
							</div>
							
							
							<div class="noneList" id='popListApproveTable2'>
								 <span>검색된 사용자가 없습니다.</span>
							</div> 
							<div class="listArea" id="popListApproveTable" style="display: none;"></div>
                      		<div class="totalcnt" id="totalApproveCnt">총 0 건</div>
	                   	</div>
	                   	<div class="modal-footer tac">
                       		<a type="button" class="whiteline" data-dismiss="modal" >닫기</a>
                       	</div>
	               	</div>
				</div>
           	</div>
			<!-- #modal-dialog --> 
			<!-- 결재자 지정 끝 -->
			
			
			
				<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog width-720">
	                   <div class="modal-content width-720">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">프로젝트명</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<input type='hidden' id='pop_hid_projectName'>
								<input type='hidden' id='pop_hid_projectId'>
								<input type='hidden' id='pop_hid_projectAlias'>
	                       		<div class="col-md-12 bgee modalpop mb20">	
									<div class="" style="text-align: center; display:inline-block;"> 
										<div class="col-md-8"> 
											<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="searchKeyword" data-original-title="" title="">
										</div>
									  	<button type="button" class="btn_search2" onclick="projectPopList();"><span></span></button>
									</div>
								</div>
								<div >
									<table class="table table-bordered table-hover table-striped table-td-valign-middle mb0">
										<colgroup>
									 		<col width="80%">
									 		<col width="20%">
									 	</colgroup>
									 	<thead>
									 		<tr class="skyblue">
												<th class="tac">프로젝트명</th>
												<th class="tac">적용</th>
											</tr>
									 	</thead>
									</table>
									<div class="popListTable">
										<table class="table table-bordered table-hover table-striped table-td-valign-middle mb0">
											<colgroup>
										 		<col width="80%">
										 		<col width="20%">
										 	</colgroup>
											<tbody id="popListTable">
												
											</tbody>
										
										</table>
									</div>
								</div>	
								
	                      	</div>
	                       	<div class="clear"></div>
	                       	<div class="modal-footer tac">
	                   			<a type="button" class="lbtn" data-dismiss="modal" onclick="okProjectInsert();">확인</a>	 
	                   			<a type="button" class="rbtn" data-dismiss="modal">취소</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
				
				
				<!-- #modal-dialog -->
				<div class="modal fade" id="message-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">알림</h4>
	                       </div>
	                       <div class="modal-body">
	                           <h5 id="confirmMsg"></h5>
	                        </div>
	                       	<div class="modal-footer tac">
	                       		<a type="button" class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
				
				<!-- #modal-dialogok -->
               <div class="modal fade" id="modal-dialogok">
                   <div class="modal-dialog">
                       <div class="modal-content">
                           <div class="modal-header">
                               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                               <h4 class="modal-title fw">자원신청</h4>
                           </div>
                           <div class="modal-body" id="confirmMsg">
                               <h5>해당 자원을 바로 신청하시겠습니까? </h5>
                               <p class="m-b-20 tac mt20">   
                                 <input type="button" class="btn btn-primary width-80" data-dismiss="modal" onclick="catalogueOrderInsert();" value="확인">&nbsp;
								 <a type="button"  class="btn btn-grey width-80" data-dismiss="modal">취소</a>   
                               </p>
                           </div>
                       </div>
                   </div>
               </div>
               <!-- modal-dialogok -->
				
				 <!-- #modal-dialog 구매 확인-->
             <div class="modal fade pdManage" id="modal-dialog3">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">신청확인</h4>
                           </div>
                           <div class="modal-body">
								<div class="modalManagePop">
									<strong class="title" id="pop_projectAlias"></strong>
									<div class="detailBox">
										<div class="boxType01">
											<ul>
												<li><span class="title">서버명</span><span class="cnt nanumR" id="pop_hostnameAlias"></span></li>
												<li><span class="title">호스트명</span><span class="cnt nanumR" id="pop_hostname"></span></li>
											</ul>
										</div>
										<div class="boxType02">
											<ul>
												<li><span class="title">요청유형</span><span class="cnt">신규</span></li>
												<li><span class="title">네트워크망</span><span class="cnt" id="pop_network"></span></li>
												<li><span class="title">희망일시</span><span class="cnt" id="pop_onDemandFlag"></span></li>
												<li><span class="title">과금단위</span><span class="cnt" id="pop_hourlyFlag"></span></li>
												<li><span class="title">CPU</span><span class="cnt" id="pop_cpucnt"></span></li>
												<li><span class="title">MEMORY</span><span class="cnt" id="pop_memcnt"></span></li>
												<li><span class="title">DISK</span><span class="cnt" id="pop_diskcnt"></span></li>
											</ul>
										</div>
										<dl class="boxType03">
											<dt>금액<span class="fc-red">(VAT 별도)</span></dt>
											<dd><strong id="pop_totalPrice"></strong><span>&nbsp;원</span></dd>
										</dl>
									</div>
									<p class="commnet">위 내용으로 신청 하시겠습니까?</p>
								</div>
                           </div>
						   <div class="clear"></div>
                           <div class="modal-footer tac">
	                   			<a type="button" class="lbtn" data-dismiss="modal" onclick="request_noworder();">확인</a>	 
	                   			<a type="button" class="rbtn" data-dismiss="modal">취소</a>
	                       </div>
                       </div>
                </div>
            </div>
			<!-- #modal-dialog  구매 확인//-->
            <!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->
		
	
	</div>
	<!-- end page container -->
	

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">



         // 결재자 지정 시작

			function openApproveReviewModal(){

				var checkVal = "";
				
				$("input:checkbox[name='network']").each(function(){
					if($(this).is(":checked")){
						checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "Y" + ",";
					}else{
						checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "N" +",";
					}
				});
				
				checkVal = checkVal.substring(0, checkVal.length-1);
				
				$("#networkChk").val(checkVal);
				//alert($("#networkChk").val());
				
				if($("input[name='onDemandFlag']:checked").val()=="N"){				
					if($("#applyDate").val()==""){
						alertBox3("서비스희망일시를 입력하세요");
						return false;
					}	
					if($("#applyTime > option:selected").val()==""){
						alertBox3("서비스희망일시 시간을 입력하세요");
						return false;
					}
				}
				if($("#projectName").val()==""){
					alertBox3("프로젝트를 입력하세요");
					return false;
				}
				if($("#networkId > option:selected").val()=="netId"){
					alertBox3("네트워크를 선택하세요");
					return false;
				}
				
				if($("#hostname").val()==""){
					alertBox3("호스트명를 입력하세요");
					return false;
				}

				if($("#confirmFlag").val()=="N"){
					alertBox3("호스트명 중복확인을 하세요");
					$("#hostname").focus();
					return false;
				}
				if($("#hostnameAlias").val()==""){
					alertBox3("호스트 별칭를 입력하세요");
					return false;
				}	
				if($("#osProductSeq > option:selected").val()==""){
					alertBox3("OS를 선택하세요");
					return false;
				}
				
				$("#networkAlias").val($("#networkId > option:selected").text());
				//alert($("#networkId > option:selected").text());
				//alert($("#networkAlias").val());
				
				$("#modal-approve-review-dialog").modal();
			}
			
			
			function openApproveModal(){
			
				$("#user-modal-approve-dialog").modal();
				 gridPopApproveList();
			}
			
			function openReviewModal(){
			
				$("#user-modal-review-dialog").modal();
				 gridPopList();
			}
			
			
			var totalCnt = 0;
			
			// 결재자 등록 팝업 리스트
			function gridPopList(){
				$.ajax({
					url : "${contextPath}/mbr/operation/approveUser/addProjectApproveList",
					dataType : "JSON",
					data : {
						"searchKind": "A.user_name"
						, "keyword"	: $("#searchKeyword").val()
					},
					success : function(req) {
						if(req.data.length == 0){
							$("#popListReviewTable").hide();
							$("#popListReviewTable2").show();
						}else{
							$("#popListReviewTable").empty();
							
							$.each(req.data, function(key,val){
								$("#popListReviewTable").append('<div class="listBg">'
									    +'<span class="WF3000A0">'+val.WF3000A0+'</span>'
										+'<span class="WF3000B0">'+val.WF3000B0+'</span>'
										+'<span class="name">'+val.userName+'</span>'
										+'<span class="idlabel">(사번 : <span class="userid nanumR">'+val.userId+'</span>)</span>'
										+'<a class="applybtn"  data-dismiss="modal"  onclick="updateReview(\''+val.userId+'\', \''+val.userName+'\');" initModal();>검토자</a>'
									+'</div>');
								
							});
							$("#popListReviewTable").show();
							$("#popListReviewTable2").hide();
						}
						totalCnt = req.data.length;
						$("#totalReviewCnt").text("총 "+totalCnt+" 건");
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
			var totalCnt = 0;
			
			  // 검토자 등록 팝업 리스트
			function gridPopApproveList(){
				$.ajax({
					url : "${contextPath}/mbr/operation/approveUser/addProjectApprove2List",
					dataType : "JSON",
					data : {
						"searchKind": "A.user_name"
						, "keyword"	: $("#searchKeyword").val()
					},
					success : function(req) {
						if(req.data.length == 0){
							$("#popListApproveTable").hide();
							$("#popListApproveTable2").show();
						}else{
							$("#popListApproveTable").empty();
							
							$.each(req.data, function(key,val){
								$("#popListApproveTable").append('<div class="listBg">'
										+'<span class="name">'+val.userName+'</span>'
										+'<span class="idlabel">(사번 : <span class="userid nanumR">'+val.userId+'</span>)</span>'
										+'<a class="applybtn" data-dismiss="modal" onclick="updateApprove(\''+val.userId+'\', \''+val.userName+'\');" initModal();>승인자</a>'
									+'</div>');
								
							});
							$("#popListApproveTable").show();
							$("#popListApproveTable2").hide();
						}
						totalCnt = req.data.length;
						$("#totalApproveCnt").text("총 "+totalCnt+" 건");
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
			
			
			
			
		 // 검토자지정
		function updateReview(userId, userName){
			$("#userIdReview").text(userId);
			$("#userNameReview").text(userName);
			$("#hiddenUserIdReview").val(userId);
			$("#hiddenUserNameReview").val(userName);
		}
		
		 // 승인자지정
		function updateApprove(userId, userName){
			$("#userIdApprove").text(userId);
			$("#userNameApprove").text(userName);
			$("#hiddenUserIdApprove").val(userId);
			$("#hiddenUserNameApprove").val(userName);
		}


			// 결재자 지정 끝


//           function onlyEngDesh(){
// 			$("#hostname").on('keyup',function(e){
// 				var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
// 				if(pattern.test(this.value)){
// 					$(this).val(this.value.replace(pattern, ''));
// 				}
// 				var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
// 				if(pattern2.test(this.value)){
// 					$(this).val(this.value.replace(pattern2, ''));
// 				}
				
// // 				$(this).val(this.value.toUpperCase()); 
// 			});
// 		}
		
		function vmOrderView(){
			
			//alert($("input[name='hourlyFlag']:checked").val());
			var productSeq = "${getCatalogueSelectView.productSeq}";
			var hourlyFlag = $("input[name='hourlyFlag']:checked").val();
			var diskcnt = $("#diskcnt").val();
			var cpucnt = $("#cpucnt").val();
			var memcnt = $("#memcnt").val();
			var mimosprice = $("#mimosprice").val();
			var himosprice = $("#himosprice").val();
			
			$.ajax({
				url : "${wasPath}/mbr/req/catalogue/getcatalogueDiskOrderView",
				dataType : "JSON",
//					type : "POST",
				data : {
					"productSeq" : productSeq
					,"hourlyFlag" : hourlyFlag
					,"diskcnt" : diskcnt
				},
				success : function(data) {
					//alert(data.productSeq);
					//alert(diskcnt);
					
					if(hourlyFlag=="N"){
						//월 금액
						//var totalPrice = data.diskMonthlyPrice * data.diskGb / 10;
						var cpuPrice = cpucnt * data.cpuMonthlyPrice;
						var cpuPrice1 = data.cpuMonthlyPrice;
						var memPrice = memcnt * data.memMonthlyPrice;
						var memPrice1 = data.memMonthlyPrice;
						
						
						var diskprice = data.vmDiskMonthlyPrice * 10;
						var diskprice1 = data.vmDiskMonthlyPrice * diskcnt / 10;
						
						var totalPrice = cpuPrice + memPrice + diskprice1 + Number(mimosprice);
						
						$("#cpucnt").val(cpucnt);
						$("#cpupriceview").empty();
						$("#cpupriceview").append('<span class="listwon nanumR">'+addcomma(cpuPrice)+'</span>&nbsp;원');
						
						$("#memcnt").val(memcnt);
						$("#mempriceview").empty();
						$("#mempriceview").append('<span class="listwon nanumR">'+addcomma(memPrice)+'</span>&nbsp;원');
						
						$("#diskpriceview").empty();
						$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma(diskprice1)+'</span>&nbsp;원');
						$("#totalpriceview").empty();
						$("#totalpriceview").append(addcomma(totalPrice));
						
						$("#totalPrice").val(totalPrice);
						$("#diskprice").val(diskprice);
						$("#diskprice1").val(diskprice1);
						$("#imdiskprice").val(diskprice1);
						$("#imdiskcnt").val(diskcnt);
						$("#imamount").val(totalPrice);
						$("#amount").val(totalPrice);
						
						$("#imosprice").val(mimosprice);
						$("#himosprice").val(himosprice);
						$("#mimosprice").val(mimosprice);
						
						$("#memPrice1").val(memPrice1);
						$("#cpuprice").val(cpuPrice1);
						$("#osprice").empty();
						$("#osprice").append(addcomma(mimosprice));						
						
					}else{
						//시간 금액
						var cpuPrice = cpucnt * data.cpuHourlyPrice;
						var cpuPrice1 = data.cpuHourlyPrice;
						var memPrice = memcnt * data.memHourlyPrice;
						var memPrice1 = data.memHourlyPrice;						
						
						var diskprice = data.vmDiskHourlyPrice * 10;
						var diskprice1 = data.vmDiskHourlyPrice * diskcnt / 10;
						
						var totalPrice = cpuPrice + memPrice + diskprice1 + Number(himosprice);
						
						$("#cpucnt").val(cpucnt);
						$("#cpupriceview").empty();
						$("#cpupriceview").append('<span class="listwon nanumR">'+addcomma(cpuPrice)+'</span>&nbsp;원');
						
						$("#memcnt").val(memcnt);
						$("#mempriceview").empty();
						$("#mempriceview").append('<span class="listwon nanumR">'+addcomma(memPrice)+'</span>&nbsp;원');
						
						$("#diskpriceview").empty();
						$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma(diskprice1)+'</span>&nbsp;원');
						$("#totalpriceview").empty();
						$("#totalpriceview").append(addcomma(totalPrice));
						
						$("#totalPrice").val(totalPrice);
						$("#diskprice").val(diskprice);
						$("#diskprice1").val(diskprice1);
						$("#imdiskprice").val(diskprice1);
						$("#imdiskcnt").val(diskcnt);
						$("#imamount").val(totalPrice);
						$("#amount").val(totalPrice);
						
						$("#imosprice").val(himosprice);
						$("#himosprice").val(himosprice);
						$("#mimosprice").val(mimosprice);
						
						$("#memPrice1").val(memPrice1);
						$("#cpuprice").val(cpuPrice1);
						$("#osprice").empty();
						$("#osprice").append(addcomma(himosprice));
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
		
		function winopen(){
			window.open('projectSearch.do','_blank','');
		}
		
		// 달력
		function calendar(){
			
			var dayName = ['일','월','화','수','목','금','토'];
			var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

			$("#applyDate").datepicker({
				showOn:"both",
				buttonImage:"${apachePath}/resources/assets/img/calen.png",
				buttonImageOnly:true,
				dateFormat : "yy-mm-dd",
				dayNamesMin:dayName,
				monthNamesShort:monthName,
				changeMonth:true,
				minDate:0
			});
			$("img.ui-datepicker-trigger").attr("style", "vertical-align:top;");
			$("#applyDate").val($.datepicker.formatDate('yy-mm-dd', new Date()));
		}
		
		function applyTimePlus(){			
// 			alert($("#applyTime").val());
			
			if($("#applyTime").val()=="23"){
				alertBox3("시간을 정확히 입력해 주세요.");
			}else{
				var applyTime;
				applyTime = Number(rtnnumber($("#applyTime").val())) + 1;
				$("#applyTime").val(applyTime);
			}
		}
		function applyTimeMinus(){
			
			if($("#applyDate").val() == $.datepicker.formatDate('yy-mm-dd', new Date())){
				if($("#applyTime").val() < ((new Date()).getHours())+2){
					alertBox3("현재일시보다 빠를수는 업습니다.");
					return false;
				}
			}
			
			if($("#applyTime").val()=="1"){
				alertBox3("시간을 정확히 입력해 주세요.");
			}else{
				var applyTime;
				applyTime = Number(rtnnumber($("#applyTime").val())) - 1;
				$("#applyTime").val(applyTime);
			}
		}
		function memplus(){			
			//alert($("#memcnt").val());
			if($("#memcnt").val()=="999"){
				alertBox3("메모리는 999개 이상 신청하실수 <br>없습니다.");
			}else{
				var memcnt;
				var memprice;
				var imamount;
				//alert($("#memPrice1").val());
				memcnt = Number(rtnnumber($("#memcnt").val())) + 1;
				memprice = Number(rtnnumber($("#memPrice1").val()))*Number(memcnt);
				imamount = Number(rtnnumber($("#imamount").val()))+Number(rtnnumber($("#memPrice1").val()));
				//alert(memprice);
				$("#memcnt").val(memcnt);
				$("#mempriceview").empty();
				$("#mempriceview").append('<span class="listwon nanumR">'+addcomma(memprice)+'</span>&nbsp;원');
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}
			
		}		
		function memminus(){
			//alert($("#memcnt").val());
			if($("#memcnt").val()=="1"){
				alertBox3("메모리는 1개 이상이어야합니다.");
			}else{
				var memcnt;
				var memprice;
				var imamount;
				//alert($("#memPrice1").val());
				memcnt = Number(rtnnumber($("#memcnt").val())) - 1;
				memprice = Number(rtnnumber($("#memPrice1").val()))*Number(memcnt);
				imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#memPrice1").val()));
				//alert(memprice);
				$("#memcnt").val(memcnt);
				$("#mempriceview").empty();
				$("#mempriceview").append('<span class="listwon nanumR">'+addcomma(memprice)+'</span>&nbsp;원');
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}
			
		}
		
	function setProductPrice(){
		var cpucnt = Number(rtnnumber($("#cpucnt").val()));
		var cpuprice = Number(rtnnumber($("#cpuprice").val()))*Number(cpucnt);
		$("#cpucnt").val(cpucnt);
		$("#cpupriceview").html('<span class="listwon nanumR">'+addcomma(cpuprice)+'</span>&nbsp;원');
		
		var memcnt = Number(rtnnumber($("#memcnt").val()));
		var memprice = Number(rtnnumber($("#memPrice1").val()))*Number(memcnt);
		$("#memcnt").val(memcnt);
		$("#mempriceview").html('<span class="listwon nanumR">'+addcomma(memprice)+'</span>&nbsp;원');
		
		var diskcnt = Number(rtnnumber($("#diskcnt").val()));
		var diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
		$("#diskcnt").val(diskcnt);
		$("#diskpriceview").html('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>&nbsp;원');

		var imamount = cpuprice+memprice+diskprice;
		$("#imamount").val(addcomma(imamount));
		$("#totalpriceview").html(addcomma(imamount));
		$("#totalPrice").val(addcomma(imamount));
	}
		
	function cpuplus(){			
			//alert($("#memcnt").val());
			if($("#cpucnt").val()=="99"){
				alertBox3("CPU는 99개 이상 신청하실수 <br>없습니다.");
			}else{
				var cpucnt;
				var cpuprice;
				var imamount;
				//alert($("#cpuprice").val());
				cpucnt = Number(rtnnumber($("#cpucnt").val())) + 1;
				cpuprice = Number(rtnnumber($("#cpuprice").val()))*Number(cpucnt);
				imamount = Number(rtnnumber($("#imamount").val()))+Number(rtnnumber($("#cpuprice").val()));
				//alert(cpuprice);
				$("#cpucnt").val(cpucnt);
				$("#cpupriceview").empty();
				$("#cpupriceview").append('<span class="listwon nanumR">'+addcomma(cpuprice)+'</span>&nbsp;원');
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}
			
	}
		
	function cpuminus(){
			//alert($("#memcnt").val());
			if($("#cpucnt").val()=="1"){
				alertBox3("CPU는 1개 이상이어야합니다.");
			}else{
				var cpucnt;
				var cpuprice;
				var imamount;
				//alert($("#cpuprice").val());
				cpucnt = Number(rtnnumber($("#cpucnt").val())) - 1;
				cpuprice = Number(rtnnumber($("#cpuprice").val()))*Number(cpucnt);
				imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#cpuprice").val()));
				//alert(cpuprice);
				$("#cpucnt").val(cpucnt);
				$("#cpupriceview").empty();
				$("#cpupriceview").append('<span class="listwon nanumR">'+addcomma(cpuprice)+'</span>&nbsp;원');
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
				//$("#cpuprice").val(cpuprice);
			}
			
	}
	
	function diskplus(){			
		//alert($("#diskcnt").val());
		if(Number($("#diskcnt").val())>=10000){
			alertBox3("디스크는 10,000GB 이상<br/>신청하실수 없습니다.");
			$("#diskcnt").val($("#imdiskcnt").val());	
			$("#diskpriceview").empty();
			$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma($("#imdiskprice").val())+'</span>&nbsp;원');
			$("#totalpriceview").empty();
			$("#totalpriceview").append($("#totalPrice").val());
		}else{
			var diskcnt;
			var diskprice;
			var imamount;
			//alert($("#diskprice").val());
			diskcnt = Number(rtnnumber($("#diskcnt").val())) + 10;
			diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
			//alert(Number(rtnnumber($("#diskprice").val()))/10);
			imamount = Number(rtnnumber($("#imamount").val()))+Number(rtnnumber($("#diskprice").val()))/10;
			//alert(addcomma(diskprice));
			$("#diskcnt").val(diskcnt);
			$("#diskpriceview").empty();
			$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>&nbsp;원');	
			$("#imamount").val(addcomma(imamount));
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(imamount));
			$("#totalPrice").val(addcomma(imamount));
			$("#imdiskprice").val(diskprice);
			$("#imdiskcnt").val($("#diskcnt").val());
			
		}
		
	}
		
	function diskminus(){
		//alert($("#diskcnt").val());
		if(Number($("#diskcnt").val())<=30){
			alertBox3("디스크는 최소 30GB 이상<br/>신청하셔야 합니다.");
			$("#diskcnt").val($("#imdiskcnt").val());	
			$("#diskpriceview").empty();
			$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma($("#imdiskprice").val())+'</span>&nbsp;원');
			$("#totalpriceview").empty();
			$("#totalpriceview").append($("#totalPrice").val());
		}else{
			var diskcnt;
			var diskprice;
			var imamount;
			//alert($("#diskprice").val());
			diskcnt = Number(rtnnumber($("#diskcnt").val())) - 10;
			diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
			//alert(Number(rtnnumber($("#diskprice").val()))/10);
			imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#diskprice").val()))/10;
			//alert(addcomma(diskprice));
			$("#diskcnt").val(diskcnt);		
			$("#diskpriceview").empty();
			$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>&nbsp;원');
			$("#imamount").val(addcomma(imamount));	
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(imamount));
			$("#totalPrice").val(addcomma(imamount));
			$("#imdiskprice").val(diskprice);
			$("#imdiskcnt").val($("#diskcnt").val());
		}
			
	}
	
	// 팝업 초기화
	function initModal(){
		$("#_projectName").val("");
		$("#checkMsg").text("");
		$("#enableId").css("display", "none");
		$("#unableId").css("display", "block");
	}
	
	// 구매전 확인 팝업
	function setOrder() {
		$("#pop_projectAlias").text($("#projectAlias").val());
		$("#pop_hostnameAlias").text($("#hostnameAlias").val());
		$("#pop_hostname").text($("#hostname").val());
		$("#pop_network").text($("#networkId > option:selected").text());
		
		if ($("input[name='onDemandFlag']:checked").val() == 'N') {
			$("#pop_onDemandFlag").text($("#applyDate").val()+' '+$("#applyTime").val()+':00');
		} else if ($("input[name='onDemandFlag']:checked").val() == 'Y') {
			$("#pop_onDemandFlag").text('승인 완료 후 생성');
		} 
		
		$("#pop_cpucnt").text($("#cpucnt").val()+' Core');
		$("#pop_memcnt").text($("#memcnt").val()+' GB');
		$("#pop_diskcnt").text($("#diskcnt").val()+' GB');
		if ($("input[name='hourlyFlag']:checked").val() == 'N') {
			$("#pop_hourlyFlag").text('월');
		} else if ($("input[name='hourlyFlag']:checked").val() == 'Y') {
			$("#pop_hourlyFlag").text('시간');
		} 
		$("#pop_totalPrice").text($("#totalPrice").val());
	}
	
	// 바로신청
	function noworder(){	
		
		var checkVal = "";
		
		$("input:checkbox[name='network']").each(function(){
			if($(this).is(":checked")){
				checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "Y" + ",";
			}else{
				checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "N" +",";
			}
		});
		
		checkVal = checkVal.substring(0, checkVal.length-1);
		
		$("#networkChk").val(checkVal);
		//alert($("#networkChk").val());
		
		if($("input[name='onDemandFlag']:checked").val()=="N"){				
			if($("#applyDate").val()==""){
				alertBox3("서비스희망일시를 입력하세요");
				return false;
			}	
			if($("#applyTime > option:selected").val()==""){
				alertBox3("서비스희망일시 시간을 입력하세요");
				return false;
			}
		}
		if($("#projectName").val()==""){
			alertBox3("프로젝트를 입력하세요");
			return false;
		}
		if($("#networkId > option:selected").val()=="netId"){
			alertBox3("네트워크를 선택하세요");
			return false;
		}
		
		if($("#hostname").val()==""){
			alertBox3("호스트명를 입력하세요");
			return false;
		}
		if($("#confirmFlag").val()=="N"){
			alertBox3("호스트명 중복확인을 하세요");
			$("#hostname").focus();
			return false;
		}
		if($("#hostnameAlias").val()==""){
			alertBox3("호스트 별칭를 입력하세요");
			return false;
		}	
		if($("#osProductSeq > option:selected").val()==""){
			alertBox3("OS를 선택하세요");
			return false;
		}
		
		$("#networkAlias").val($("#networkId > option:selected").text());
		//alert($("#networkId > option:selected").text());
		//alert($("#networkAlias").val());
		
		setOrder();
		$("#modal-dialog3").modal();
	}
	
	function request_noworder(){	
		
		$("#catalogueform").submit();
	}
	
	// 일괄신청
	function basketorder(){	
		
		var checkVal = "";
		
		$("input:checkbox[name='network']").each(function(){
			if($(this).is(":checked")){
				checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "Y" + ",";
			}else{
				checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "N" +",";
			}
		});
		
		checkVal = checkVal.substring(0, checkVal.length-1);
		
		$("#networkChk").val(checkVal);
		
		//alert($("#totalPrice").val());		
		if($("input[name='onDemandFlag']:checked").val()=="N"){				
			if($("#applyDate").val()==""){
				alertBox3("서비스희망일시를 입력하세요");
				return false;
			}	
			if($("#applyTime > option:selected").val()==""){
				alertBox3("서비스희망일시 시간을 입력하세요");
				return false;
			}
		}
		if($("#projectName").val()==""){
			alertBox3("프로젝트를 입력하세요");
			return false;
		}
		if($("#networkId > option:selected").val()=="netId"){
			alertBox3("네트워크명을 선택하세요");
			return false;
		}
		if($("#hostname").val()==""){
			alertBox3("호스트명를 입력하세요");
			return false;
		}
		if($("#confirmFlag").val()=="N"){
			alertBox3("호스트명 중복확인을 하세요");
			$("#hostname").focus();
			return false;
		}
		if($("#hostnameAlias").val()==""){
			alertBox3("호스트 별칭를 입력하세요");
			return false;
		}		
		if($("#osProductSeq > option:selected").val()==""){
			alertBox3("OS를 선택하세요");
			return false;
		}
		
		$("#totalPrice").val(rtnnumber($("#totalPrice").val()));
		$("#catalogueform").attr('action','basketOrder.do');
		//$("#catalogueform").submit();
		var params = $('#catalogueform').serialize();
		
		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/basketOrder2.do",
			dataType : "JSON",
			type : "POST",
			data : params,
			success : function(data) {	
				confirmBoxBasket("일괄신청로 이동하시겠습니까?", actCatalogueformSubmit);
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}	
			}
			
		})	
					
	}
	
	function actCatalogueformSubmit(){
		//$("#catalogueform").attr('action','basketOrder.do');
		//$("#catalogueform").submit();
		location.href = "${wasPath}/mbr/req/catalogue/basketOrder.do";
	}
	
	function osselect(){
		//alert($("#osProductSeq > option:selected").val());
		if($("#osProductSeq > option:selected").val()!=""){
			var osProductSeq = $("#osProductSeq > option:selected").val();
			var amount;
			//var jsonData = setJsonData();
			//$("#customerId").empty();
			//$("#customerId").append("<option value='''>=== 회원사 선택 ===</option>");
			$.ajax({
				url : "${wasPath}/mbr/req/catalogue/osSelect",
				dataType : "JSON",
				type : "POST",
				data : {
					"osProductSeq" : osProductSeq
				},
				success : function(data) {					
						if($("input[name='hourlyFlag']:checked").val()=="N"){
							//alert(data.monthlyPrice);
							$("#osprice").empty();
							$("#osprice").append(addcomma(data.monthlyPrice));							
							amount = Number(rtnnumber($("#imamount").val())) + Number(data.monthlyPrice) - Number($("#imosprice").val());	
							//alert(amount);
							amount = addcomma(amount);
							//$("#amount").val(amount);
							$("#imamount").val(amount);
							$("#imosprice").val(data.monthlyPrice);
							$("#himosprice").val(data.hourlyPrice);
							$("#mimosprice").val(data.monthlyPrice);
							
							$("#totalpriceview").empty();
							$("#totalpriceview").append(amount);
							$("#totalPrice").val(amount);	
							
						}else{
							//alert(data.hourlyPrice);
							$("#osprice").empty();
							$("#osprice").append(addcomma(data.hourlyPrice));							
							amount = Number(rtnnumber($("#imamount").val())) + Number(data.hourlyPrice) - Number($("#imosprice").val());
							amount = addcomma(amount);
							//alert(amount);
							//$("#amount").val(amount);
							$("#imamount").val(amount);
							$("#imosprice").val(data.hourlyPrice);
							$("#himosprice").val(data.hourlyPrice);
							$("#mimosprice").val(data.monthlyPrice);
							
							$("#totalpriceview").empty();
							$("#totalpriceview").append(amount);
							$("#totalPrice").val(amount);
							//alert(amount);
							//amount = rtnnumber(amount);
							//alert(amount);
						}
				},
				error : function(request, status, error) {
					if(request.status == '200'){
						alertBox("접속이 만료되었습니다.", logout);				
					}else{
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}	
				}
				
			})	
		}else{
			$("#osprice").empty();
			$("#osprice").append('0');
			var amount;
			amount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imosprice").val()));
			$("#imamount").val(addcomma(amount));
			$("#imosprice").val('0');
			$("#amount").val($("#imamount").val());
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(amount));
			$("#totalPrice").val(addcomma(amount));
		}		
		
	}
	
	function rtnnumber(n){
		n=n.replace(/,/g,"");
		if(isNaN(n)){
			return 0;
		}else{
			return n;
		}
	}

	
	function onlyEngNumDash(id){

// 		$(id).val( $(id).val().replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g,''));
		$(id).val( $(id).val().replace(/[^a-zA-Z0-9_-]/g,''));
		if(
				!(event.keyCode == 45 
				|| event.keyCode == 95
				|| event.keyCode>=65 && event.keyCode<=90
				|| event.keyCode>=97 && event.keyCode<=122
				|| event.keyCode < 12592 
				|| event.keyCode > 12687
				)
			){
			event.returnValue=false;
		}else{
			event.returnValue=true;
		}
	}
	
	function diskfocusout(id){
		//alert(id);
		var diskcnt;
		diskcnt = Number($(id).val());
		//alert(diskcnt);
		if(diskcnt<30){
			alertBox3("디스크는 최소 30GB 이상<br/>신청하셔야 합니다.");
			$(id).val($("#imdiskcnt").val());
			$("#diskpriceview").empty();
			$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma($("#imdiskprice").val())+'</span>&nbsp;원');
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(rtnnumber($("#totalPrice").val())));
		}else if(diskcnt>10000){
			alertBox3("디스크는 10,000GB 이상<br/>신청하실수 없습니다.");
			$(id).val($("#imdiskcnt").val());
			$("#diskpriceview").empty();
			$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma($("#imdiskprice").val())+'</span>&nbsp;원');
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(rtnnumber($("#totalPrice").val())));
		}else{
			var imdiskcnt = diskcnt % 10;
			if(imdiskcnt==0){
				var diskprice;
				var imamount;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100;
				//alert(diskprice);
				//alert($("#imdiskprice").val());
				imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
				imamount =  imamount + diskprice ; //총가격에 디스크 가격 추가
				
				//alert(imamount);
				
				$("#imdiskcnt").val($(id).val());
				$("#imdiskprice").val(diskprice);
				$("#diskpriceview").empty();
				$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>&nbsp;원');
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}else{
				alertBox3("디스크는 10GB 단위로<br/>신청하실수 있습니다.");
				$(id).val($("#imdiskcnt").val());	
				$("#diskpriceview").empty();
				$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma($("#imdiskprice").val())+'</span>&nbsp;원');
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(rtnnumber($("#totalPrice").val())));
			}
			
		}
		
		
	}
	function diskchange(id){
		//alert($(id).val());
		var diskval = $(id).val();
		//alert(diskval.length);
		if(diskval.length>2){
			var diskprice;
			var imamount;
			diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100;
			imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
			imamount =  imamount + diskprice ;
			$("#diskpriceview").empty();
			$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>&nbsp;원');
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(imamount));
		}else{
			var imdiskcnt = Number(diskval) % 10;
			if(imdiskcnt==0){
				var diskprice;
				var imamount;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100;
				imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
				imamount =  imamount + diskprice ;
				$("#diskpriceview").empty();
				$("#diskpriceview").append('<span class="listwon nanumR">'+addcomma(diskprice)+'</span>&nbsp;원');
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
			}
		}
		
	}
	
	
//---> Modal popup start
	
	//modal팝업 open
	function openModal(){
		$("#modal-dialog").modal();
		$("#pop_hid_projectName").val("");
		$("#pop_hid_projectId").val("");
		$("#pop_hid_projectAlias").val("");
		projectPopList();
	}
	
	
	// 팝업리스트
	function projectPopList(){
		
		var keyword = $("#searchKeyword").val();
		
		$.ajax({
			url : "projectPopList",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"searchValue" : keyword
			},
			success : function(data) {
				var projectList = data.getProjectList;
				
				if(projectList!=""){
					
					$("#popListTable > tr").remove();
					$.each(projectList,function(key,val){
						
						var Html="";
						
// 						Html="<tr><td class='tac'>"+val["projectName"]+"</td>";
						Html="<tr>";
						Html = Html + "<td class='tal'>"+val["projectAlias"]+"</td>";
						Html = Html + "<td class='tac'><input type='button' class='popCheckbtn' onclick='updateProject(this, \""+val["projectId"]+"\", \""+val["projectName"]+"\", \""+val["projectAlias"]+"\")'></td>";
						Html = Html + "</tr>";
						
						$("#popListTable").append(Html);	
						
					});
				}else{
					$("#popListTable > tr").remove();
						
					var Html="";
					
					Html="<tr><td class='tac' colspan='3'>검색된 프로젝트가 없습니다.</td>";
					Html = Html + "</tr>";
					
					$("#popListTable").append(Html);		
						
					
				}
				
				$('#popListTable tr:odd').addClass('even');
				$('#popListTable tr:even').addClass('odd'); 
				
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function updateProject(e, projectId, projectName, projectAlias){
		$("#popListTable > tr").find("input").removeClass("active");
		$(e).toggleClass("active");
		$("#pop_hid_projectName").val(projectName);
		$("#pop_hid_projectId").val(projectId);
		$("#pop_hid_projectAlias").val(projectAlias);
	}
	
	function okProjectInsert(){
		$("#projectName").val($("#pop_hid_projectName").val());
		$("#projectId").val($("#pop_hid_projectId").val());
		$("#projectAlias").val($("#pop_hid_projectAlias").val());
		getNetworkList();
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${wasPath}/mbr/req/catalogue/catalogueList.do";
	}
	
 	function getNetworkList(){
 		$("#divNetwork").html("");
		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/networkList",
			dataType : "JSON",
 			type : "GET",
			data : {
				"projectId" : $("#projectId").val()
				, "projectName" : $("#projectName").val()
			},
			success : function(req) {
				
			
//				var vHtml = "<select class='form-control' id='networkId' name='networkId' onchange='networkIdSelect()'>";

				var vHtml = "<div class='searchBoxArea2'>";
					vHtml += "<div class=''>";
					vHtml += "<label class='selectBoxDrop' for='networkId'>선택해주세요.</label>";
				 	vHtml += "<select class='search-sel' id='networkId' name='networkId' >";
					vHtml += "<option value='netId'>선택해주세요.</option>";
				for(var i=0; i<req.length; i++){
				
					vHtml += "<option value='"+req[i].networkId+"'>"+(req[i].networkAlias==""?req[i].networkName:req[i].networkAlias)+"</option>";
				}
				vHtml += "</select>"
				
				$("#divNetwork").html(vHtml);
				
			 	var Html = "<input type='hidden' id='netId' name='netId' value='netId' />";
				for(var i=0; i<req.length; i++){
						Html += "<input type='hidden' id='"+req[i].networkId+"' name='"+req[i].networkId+"' value='"+req[i].networkName+"' />";
						Html += "<input type='hidden' id='"+req[i].networkName+"' name='"+req[i].networkName+"' value='"+req[i].networkAlias+"' />";
				}
					$("#divNetwork").append(Html);
					
					// select box text 설정
					$(".search-sel").change(function() {
						$(this).siblings(".selectBoxDrop").text($(this).children('option:selected').text());
					});  
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
 	}
	//<--- Modal popup end
	
	
	// 호스트명(영문명) 중복체크
	function hostnameChk(){
		
		if($("#hostname").val()==""){
			alertBox3("호스트명을 입력하세요");
			return;
		}
		
		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/hostnameChk",
// 			dataType : "JSON",
 			type : "GET",
			data : {
				"hostname" : $("#hostname").val()
			},
			success : function(data) {
				var result = data;
				
				if(result==0){
					$("#confirmMsg").css("color","blue");
					$("#confirmFlag").val("Y");
					alertBox3("사용가능한 호스트명입니다.");
				}else{
					$("#confirmMsg").css("color","#ff0000");
					$("#confirmFlag").val("N");
					alertBox3("이미 사용중인 호스트명입니다.");
				}
				
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	// 팝업메시지 세팅	
	function alertModal(txt){
		$("#confirmMsg").text(txt);
		$("#message-modal-dialog").modal();
	}
	
		
	// 신청신청
	function catalogueOrderInsert(){
		var jsonData = setJsonData();
		$.ajax({
			url : "catalogueOrderNow",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				//openModal2();
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	

	// jsonData 세팅
	function setJsonData(){
		
		$("#amount").val(rtnnumber($("#amount").val()));
		
		var applyDatetime = $("#applyDatetime").val();
		var jsonData;
		
		if(applyDatetime == ""){
			jsonData={
					"type" : "noworderinsert" // 타입은 수정
					, "vmProductSeq" : $("#productSeq").val() //productSeq
					, "amount" : rtnnumber($("#totalPrice").val()) //totalPrice
					, "onDemandFlag" : $("input[name='onDemandFlag']:checked").val() //onDemandFlag
					, "projectName" : $("#projectName").val()//projectName
					, "hostname" : $("#hostname").val()//hostname
					, "hostnameAlias" : $("#hostnameAlias").val()//hostnameAlias
					, "vcpus" : $("#cpucnt").val()//cpucnt
					, "memGb" : $("#memcnt").val()//memcnt
					, "diskGb" : $("#diskcnt").val()//diskcnt
					, "osProductSeq" : $("#osProductSeq").val()//osProductSeq
					, "projectId" : $("#projectId").val()//projectId
					, "productCategory" : $("#productCategory").val()//	productCategory		
					, "hourlyFlag" : $("input[name='hourlyFlag']:checked").val()		//$("input[name='hourlyFlag']:checked").val()
					, "orderName" : ""	//	
					, "description" : $("#description").val() // description
					, "defaultNetworkId" : $("#networkId").val() //networkId
					, "defaultNetworkName" : $("#defaultNetworkName").val() //defaultNetworkName
					, "defaultNetworkAlias" : $("#defaultNetworkAlias").val() //defaultNetworkAlias
					, "networkChk" : $("#networkChk").val()//networkChk
					, "catalogSeq" : $("#catalogSeq").val() //catalogSeq
				}	
		}else{
			jsonData={
					"type" : "noworderinsert" // 타입은 수정
					, "vmProductSeq" : $("#productSeq").val() //productSeq
					, "amount" : rtnnumber($("#totalPrice").val()) //totalPrice
					, "applyDatetime" : $("#applyDate").val() + $("#applyTime").val() + ":00" //${ordervo.applyDate} ${ordervo.applyTime}:00
					, "onDemandFlag" : $("input[name='onDemandFlag']:checked").val()  //onDemandFlag
					, "projectName" : $("#projectName").val()//projectName
					, "hostnameAlias" : $("#hostnameAlias").val()//hostnameAlias
					, "hostname" : $("#hostname").val()//hostname
					, "vcpus" : $("#cpucnt").val()//cpucnt
					, "memGb" : $("#memcnt").val()//memcnt
					, "diskGb" : $("#diskcnt").val()//diskcnt
					, "osProductSeq" : $("#osProductSeq").val()//osProductSeq
					, "projectId" : $("#projectId").val()//projectId
					, "productCategory" : $("#productCategory").val()	//productCategory		
					, "hourlyFlag" : $("input[name='hourlyFlag']:checked").val()		//$("input[name='hourlyFlag']:checked").val()
					, "orderName" : ""		//
					, "description" : $("#description").val() //
					, "defaultNetworkId" : $("#networkId").val()  //networkId
					, "defaultNetworkName" : $("#defaultNetworkName").val() //defaultNetworkName
					, "defaultNetworkAlias" : $("#defaultNetworkAlias").val() //defaultNetworkAlias
					, "networkChk" : $("#networkChk").val() //networkChk
					, "catalogSeq" : $("#catalogSeq").val() //catalogSeq
				}
		}
		
		return jsonData;
	}
	
	$(document).ready(function() {
	    App.init();
	    calendar();
	    
	    //Demo.init();
	  //  PageDemo.init();
		
	//	$("a>button").on('click',function(){
	//	location.href = $(this).closest("a").attr("href");
	//	});
	    if($("input[name='onDemandFlag']:checked").val()=="N"){					
	    	$("#sdate").show();				
		}else{
			$("#sdate").hide();
		}
		
	    $("input[name='hourlyFlag']").on('click',function(){	
			vmOrderView();	
			//alert($("input[name='hourlyFlag']:checked").val());
		});
	    
	    //메뉴활성화
		$("#reqProduct").addClass("active");
		$("#basic").addClass("active");
	    
		
		// 중복체크 확인용
		$("#hostname").keypress(function(){
	 		$("#confirmFlag").val("N"); 
	 	});
		
		$("#hostname").on('keyup',function(e){
			var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
			if(pattern.test(this.value)){
				$(this).val(this.value.replace(pattern, ''));
			}
			var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
			if(pattern2.test(this.value)){
				$(this).val(this.value.replace(pattern2, ''));
			}
			
		});
		$("#hostname").on('blur',function(e){
			var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
			if(pattern.test(this.value)){
				$(this).val(this.value.replace(pattern, ''));
			}
			var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
			if(pattern2.test(this.value)){
				$(this).val(this.value.replace(pattern2, ''));
			}
			
		});
		$("input[name='onDemandFlag']").on('click',function(){	
			//alert($("input[name='onDemandFlag']:checked").val());
			if($("input[name='onDemandFlag']:checked").val()=="N"){				
				$("#sdate").show();					
			}else{
				$("#sdate").hide();
			}
			
		});
	});
	
	</script>
	
</body>
</html>