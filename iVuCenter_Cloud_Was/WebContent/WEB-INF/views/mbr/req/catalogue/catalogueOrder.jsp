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
			<h1 class="page-header fc66 fbold"> <i class="fa fa-cubes fcb"> </i> 가상머신신청<span class="root"><img src="/resources/assets/img/root_icon.png"/> 콘솔 > 카달로그 > 목록</span></h1>
			<!-- end header -->

			 <!-- begin page-body -->
			 <div class="row mb50">
				<h5 class="pl20"> ㆍ자원정보 </h5>
				<!----첫번째 자원내용 끝------->
				<c:set var="totalPrice" value="" />
				<c:set var="cpuPrice" value="" />
				<c:set var="memPrice" value="" />
				<c:set var="memPrice1" value="" />
				<c:set var="diskPrice" value="" />
				<c:set var="osPrice" value="" />
				<c:set var="priceTypeTxt" value="" />
				<c:choose>
					<c:when test="${getCatalogueSelectView.hourlyFlag eq 'Y'}">
						<c:set var="cpuPrice" value="${getCatalogueItempric.cpuHourlyPrice}" />
						<c:set var="memPrice" value="${getCatalogueSelectView.memGb * getCatalogueItempric.memHourlyPrice}" />
						<c:set var="memPrice1" value="${getCatalogueItempric.memHourlyPrice}" />
						<c:set var="diskPrice" value="${getCatalogueItempric.diskHourlyPrice * 10}" />
						<c:set var="totalPrice" value="${getCatalogueSelectView.vcpus * cpuPrice + memPrice + diskPrice}" />
						<c:set var="priceTypeTxt" value="시간과금  자원입니다." />
					</c:when>
					<c:otherwise>
						<c:set var="cpuPrice" value="${getCatalogueItempric.cpuMonthlyPrice}" />
						<c:set var="memPrice" value="${getCatalogueSelectView.memGb * getCatalogueItempric.memMonthlyPrice}" />
						<c:set var="memPrice1" value="${getCatalogueItempric.memMonthlyPrice}" />
						<c:set var="diskPrice" value="${getCatalogueItempric.diskMonthlyPrice * 10}" />
						<c:set var="totalPrice" value="${getCatalogueSelectView.vcpus * cpuPrice +  memPrice + diskPrice}" />
						<c:set var="priceTypeTxt" value="월과금  자원입니다." />
					</c:otherwise>
				</c:choose>
				<!----첫번째 자원내용------->
				<div class="col-md-12">
				  <div class="col-md-12 bgf2 b1s">
					<div class="col-md-4 br5 bgwh tac mt10 vm p35"><img src="${contextPath}/resources/assets/img/server_sample.png">
					</div>
					<div class="col-md-8">
						<h5 class="bgdb p10 fcdb f16">${getCatalogueSelectView.displayName} (${priceTypeTxt})</h5>
						<li class="fcdb f14 pl20">CPU : ${getCatalogueSelectView.vcpus} Core</li>
						<li class="fcdb f14 pl20"> MEM : ${getCatalogueSelectView.memGb} GB</li>
						<li class="fcdb f14 pl20"> DISK : ${getCatalogueSelectView.diskGb} GB</li>
						<li class="fc66 p20"> ${getCatalogueSelectView.description} </li>
					</div>
				  </div>
				</div>

				<div class="col-md-12">
					<div class="col-md-12 machine pl5 pr5 mt20">
					<div class="tableF p10">
					<form name="catalogueform"  id="catalogueform" action="catalogueOrderNow.do" method="post" >
					<input type="hidden" name="type" id="type" value="noworder" />
					<input type="hidden" name="productSeq" id="productSeq" value="${getCatalogueSelectView.productSeq}" />
					<input type="hidden" name="totalPrice" id="totalPrice" value="${totalPrice}" />
					<input type="hidden" name="productCategory" id="productCategory" value="${getCatalogueSelectView.productCategory}" />
					<input type="hidden" name="hourlyFlag" id="hourlyFlag" value="${getCatalogueSelectView.hourlyFlag}" />

					<table>
						<colgroup>
						<col width="20%">
						<col width="80%">
						</colgroup>
						<tbody>
						<tr>
						<td class="left-b th20"></td>
						<td>
						<div class="col-md-5">
							<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> 희망일시 생성</label> &nbsp; &nbsp;
							<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성</label>
						</div>
						<div class="col-md-7 fc-red mb10">* 승인 완료 후 생성 선택시 클라우드 관리자에 최종승인 완료 후 가상머신이 생성이 됩니다. </div>
						</td>
						</tr>
						<tr id="sdate" name="sdate" style="display:none">
						<td class="left-b th20">서비스희망일시</td>
						<td>
<!-- 						<div class="col-md-3">  -->
							<div class="input-group date" id="datepicker-disabled-past" data-date-format="dd-mm-yyyy" data-date-start-date="Date.default">
								<input type="text" class="form-control dpin width-100" placeholder="날짜선택" id="applyDate" name="applyDate" readonly/>
								<!-- <span class="input-group-addon"><i class="fa fa-calendar"></i></span> -->
							</div>
<!-- 						</div> -->
						<div class="col-md-2 pl0 pr0">
							<select name="applyTime" id="applyTime" class="form-control">
								<option value="">시간 선택</option>
								<option value="01">01 시</option>
								<option value="02">02 시</option>
								<option value="03">03 시</option>
								<option value="04">04 시</option>
								<option value="05">05 시</option>
								<option value="06">06 시</option>
								<option value="07">07 시</option>
								<option value="08">08 시</option>
								<option value="09">09 시</option>
								<option value="10">10 시</option>
								<option value="11">11 시</option>
								<option value="12">12 시</option>
								<option value="13">13 시</option>
								<option value="14">14 시</option>
								<option value="15">15 시</option>
								<option value="16">16 시</option>
								<option value="17">17 시</option>
								<option value="18">18 시</option>
								<option value="19">19 시</option>
								<option value="20">20 시</option>
								<option value="21">21 시</option>
								<option value="22">22 시</option>
								<option value="23">23 시</option>
								<option value="24">24 시</option>
							</select>
						</div>
						</td>
						</tr>
						<tr>
						<td class="left-b">프로젝트</td>
						<td>
						<div class="col-md-10">
							<input class="form-control" type="text" name="projectName" id="projectName" readonly />
							<input type="hidden" name="projectId" id="projectId" value="" />
						</div>
						<div class="col-md-2 pl0">
<!-- 							<button type="button" class="btn btn-grey width-80" onclick="winopen();">검색</button> -->
<!-- 							<input type="button" value="검색" onclick="openModal();" class="btn btn-primary" />  -->
							<button type="button" class="btn btn-grey" onclick="openModal();"> <i class="fa fa-search"></i> 검색</button>


						</div>
						</td>
						</tr>
						<tr>
						<td class="left-b th20">네트워크망</td>
						<td>

							<div class="col-md-8">
								<div id="divNetwork"><input class="form-control" type="text" readonly /></div>
							</div>
<!-- 							<div class="col-md-4 pl0">  -->
<!-- 								<input type="checkbox" class="va-tb" /> 백업  &nbsp; &nbsp;  -->
<!-- 								<input type="checkbox"  class="va-tb"/> 공용  &nbsp; &nbsp;  -->
<!-- 								<input type="checkbox"  class="va-tb"/> 대외망  -->
<!-- 							</div>   -->
						</td>
						</tr>
						<tr>
						<td class="left-b th20">HOST NAME(영문명)</td>
						<td>
						<div class="col-md-10">
						<input class="form-control" type="text" name="hostname" id="hostname" style="ime-mode:disabled"/>
						</div>
						</td>
						</tr>
						<tr>
						<td class="left-b th20">HOST NAME ALIAS(한글명)</td>
						<td>
						<div class="col-md-10">
						<input class="form-control" type="text" name="hostnameAlias" id="hostnameAlias" />
						</div>
						</td>
						</tr>
						<tr>
						<tr>
						<td class="left-b">CPU</td>
						<td class="pr0">
						<div class="col-md-3">
							<input class="form-control" type="text"  placeholder="1" value="${getCatalogueSelectView.vcpus}" maxlength="2" name="cpucnt" id="cpucnt" readonly onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" />
						</div>
						<div class="col-md-1 w5">
							<input type="hidden" name="cpuprice" id="cpuprice" value='<fmt:formatNumber value="${cpuPrice}" pattern="####"/>'>
							<button type="button" class="btn btn-grey dpin" onclick="cpuplus();"> <i class="fa fa-plus" ></i> </button>
						</div>
						<div class="col-md-1"> <button type="button" class="btn btn-grey dpin" onclick="cpuminus();"> <i class="fa fa-minus" ></i> </button> </div>
						<div class="col-md-1 pl0 mt15">Core</div>
						<div class="col-md-6 f20 fcb tar pr10 mt5">
						<span id="cpupriceview" name="cpupriceview">
							<fmt:formatNumber value="${cpuPrice * getCatalogueSelectView.vcpus}" pattern="#,###"/>
						</span>
						<span class="f12 fc66">&nbsp;원 </span>
						</div>

						</td>
						</tr>
						<tr>
						<td class="left-b">MEM</td>
						<td class="pr0">
						<div class="col-md-3"><input class="form-control" type="text"  placeholder="1" value="${getCatalogueSelectView.memGb}" maxlength="3" name="memcnt" id="memcnt" readonly onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" /> </div>
						<div class="col-md-1 w5">
							<input type="hidden" name="memprice" id="memprice" value='<fmt:formatNumber value="${memPrice}" pattern="####"/>'>
							<input type="hidden" name="memPrice1" id="memPrice1" value='<fmt:formatNumber value="${memPrice1}" pattern="####"/>'>
							<button type="button" class="btn btn-grey dpin" onclick="memplus();"> <i class="fa fa-plus"></i> </button> </div>
						<div class="col-md-1"> <button type="button" class="btn btn-grey dpin" onclick="memminus();"> <i class="fa fa-minus"></i> </button> </div>
						<div class="col-md-1 pl0 mt15">GB</div>
						<div class="col-md-6 f20 fcb tar pr10 mt5">
						<span id="mempriceview" name="mempriceview">
							<fmt:formatNumber value="${memPrice}" pattern="#,###"/>
						</span>
						<span class="f12 fc66">&nbsp;원 </span>
						</div>

						</td>
						</tr>
						<tr>
						<td class="left-b">DISK</td>
						<td class="pr0">
						<div class="col-md-3">
							<input class="form-control" type="text"  placeholder="1" value="${getCatalogueSelectView.diskGb}" maxlength="5" name="diskcnt" id="diskcnt" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"  onfocusout="diskfocusout(this);" onkeyup="diskchange(this);"/>
						</div>
						<div class="col-md-1 w5">
							<input type="hidden" name="diskprice" id="diskprice" value='<fmt:formatNumber value="${diskPrice}" pattern="####"/>'>
							<button type="button" class="btn btn-grey dpin" onclick="diskplus();"> <i class="fa fa-plus"></i> </button>
						</div>
						<div class="col-md-1">
							<button type="button" class="btn btn-grey dpin" onclick="diskminus();"> <i class="fa fa-minus"></i> </button>
						</div>
						<div class="col-md-1 pl0 mt15">GB</div>
						<div class="col-md-6 f20 fcb tar pr10 mt5">
						<span id="diskpriceview" name="diskpriceview" >
							<fmt:formatNumber value="${diskPrice}" pattern="#,###"/>
						</span>
						<input type="hidden" name="imdiskprice" id="imdiskprice" value="<fmt:formatNumber value="${diskPrice}" pattern="####"/>" />
						<input type="hidden" name="imdiskcnt" id="imdiskcnt" value="<fmt:formatNumber value="${getCatalogueSelectView.diskGb}" pattern="####"/>" />
						<span class="f12 fc66">&nbsp;원 </span>
						</div>

						</td>
						</tr>
						<tr>
						<td class="left-b">OS</td>
						<td class="pr0">
						<div class="col-md-5">
							<select class="form-control" name="osProductSeq" id="osProductSeq" onchange="osselect();">
								<option value="">OS 선택</option>
								<c:forEach items="${getCatalogueOslist}" var="getCatalogueOslist" varStatus="status" >
								<option value="${getCatalogueOslist.productSeq}">${getCatalogueOslist.productName}</option>
								</c:forEach>
							</select>
							<input type="hidden" name="imosprice" id="imosprice" value="0"/>
						</div>
						<div class="col-md-1"></div>
						<div class="col-md-6 f20 fcb tar mt5 pr34">
							<span id="osprice" name="osprice">0</span>
							<span class="f12 fc66">&nbsp;원 </span>
						</div>
						</td>
						</tr>

						</tbody>
						</table>
						</form>
				</div>
				</div>


				<!--다섯번째 상자---->
				<div class="col-md-12 bgf2 b1s mt20">
					<div class="col-md-6 mt10 pl0"><h5 class="mb0 fc66 pl0">총합계 (월 청구금액 VAT 별도)</h5></div>
					<div class="col-md-6 f24 fc-red tar pr54 pt20">
						<span id="totalpriceview" name="totalpriceview">
							<fmt:formatNumber value="${totalPrice}" pattern="#,###"/>
						</span>
						<span class="f12 fc66">&nbsp;원 </span>
						<input type="hidden" name="imamount" id="imamount" value='<fmt:formatNumber value="${totalPrice}" pattern="#,###"/>' />
						<input type="hidden" name="amount" id="amount" value='<fmt:formatNumber value="${totalPrice}" pattern="####"/>' />
					</div>
				<div class="clear"></div>
				<hr class="b1c7 mbtb10"></hr>
				<div class="col-md-12 tac p20">
					  <button type="button" class="btn btn-primary width-100" onclick="noworder();">바로신청</button>&nbsp;
					  <button type="submit" class="btn btn-lime width-100" onclick="basketorder();">일괄신청</button>&nbsp;
                      <button type="submit" class="btn btn-grey width-80" onclick="moveListPage()">취소</button>
				</div>
				</div>
				<!--다섯번째 상자//---->



			</div>



			</div>
			<!---- end page body---->

			<!-- end page-body -->

				<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">프로젝트 검색</h4>
	                       </div>
	                       <div class="modal-body">
	                           <p class="m-b-20">
	                              <input type="text" id="searchKeyword" value="" />
	                              <input type="button" value="검색" onclick="projectPopList();"/>
	                           </p>

								<div>
									<table class="table table-bordered table-hover table-striped table-td-valign-middle">
										<colgroup>
									 		<col width="*">
									 		<col width="*">
									 		<col width="80px">
									 	</colgroup>
									 	<thead>
									 		<tr class="primary">
												<th class="left th20 tac">프로젝트코드</th>
												<th class="left th20 tac">프로젝트명</th>
												<th class="left th20 tac">적용</th>
											</tr>
									 	</thead>
										<tbody id="popListTable">

										</tbody>

									</table>
								</div>

	                      	</div>
	                       	<div class="modal-footer tac">
	                   			<a type="button" class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
            <!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->


	</div>
	<!-- end page container -->


	<script type="text/javascript">
		$(document).ready(function() {
		    App.init();
		    calendar();
		    //Demo.init();
		  //  PageDemo.init();

		//	$("a>button").live('click',function(){
		//	location.href = $(this).closest("a").attr("href");
		//	});
		    if($("input[name='onDemandFlag']:checked").val()=="N"){
		    	$("#sdate").show();
			}else{
				$("#sdate").hide();
			}

		    //메뉴활성화
			$("#catalogueMain").addClass("active");
			$("#catalogueVm").addClass("active");


		});
		$("input[name='onDemandFlag']").live('click',function(){
			//alert($("input[name='onDemandFlag']:checked").val());
			if($("input[name='onDemandFlag']:checked").val()=="N"){
				$("#sdate").show();
			}else{
				$("#sdate").hide();
			}

		});

		function winopen(){
			window.open('projectSearch.do','_blank','');
		}

		// 달력
		function calendar(){

			var dayName = ['일','월','화','수','목','금','토'];
			var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

			$("#applyDate").datepicker({
				showOn:"both",
				buttonImage:"/resources/assets/img/calen.png",
				buttonImageOnly:true,
				dateFormat : "yy-mm-dd",
				dayNamesMin:dayName,
				monthNamesShort:monthName,
				changeMonth:true,
				minDate:0
			});

			$("#applyDate").datepicker({
				showOn:"both",
				buttonImage:"/resources/assets/img/calen.png",
				buttonImageOnly:true,
				dateFormat:"yy-mm-dd",
				dayNamesMin:dayName,
				monthNamesShort:monthName,
				changeMonth:true,
				minDate:0
			});
			$("img.ui-datepicker-trigger").attr("style", "margin-top:-5px;");
		}

		function memplus(){
			//alert($("#memcnt").val());
			if($("#memcnt").val()=="999"){
				alert("메모리는 999개 이상 신청하실수 없습니다.");
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
				$("#mempriceview").append(addcomma(memprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}

		}

		function memminus(){
			//alert($("#memcnt").val());
			if($("#memcnt").val()=="1"){
				alert("메모리는 1개 이상이어야합니다.");
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
				$("#mempriceview").append(addcomma(memprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}

		}

	function cpuplus(){
			//alert($("#memcnt").val());
			if($("#cpucnt").val()=="99"){
				alert("CPU는 99개 이상 신청하실수 없습니다.");
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
				$("#cpupriceview").append(addcomma(cpuprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}

	}

	function cpuminus(){
			//alert($("#memcnt").val());
			if($("#cpucnt").val()=="1"){
				alert("CPU는 1개 이상이어야합니다.");
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
				$("#cpupriceview").append(addcomma(cpuprice));
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
			alert("디스크는 10,000GB 이상<br/>신청하실수 없습니다.");
			$("#diskcnt").val($("#imdiskcnt").val());
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma($("#totalPrice").val()));
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
			$("#diskpriceview").append(addcomma(diskprice));
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
			alert("디스크는 최소 30GB 이상<br/>신청하셔야 합니다.");
			$("#diskcnt").val( $("#imdiskcnt").val());
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma($("#totalPrice").val()));
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
			$("#diskpriceview").append(addcomma(diskprice));
			$("#imamount").val(addcomma(imamount));
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(imamount));
			$("#totalPrice").val(addcomma(imamount));
			$("#imdiskprice").val(diskprice);
			$("#imdiskcnt").val($("#diskcnt").val());
		}
	}


	// 중복체크완료된 프로젝트영문명 적용
	function setId(){
		var projectName = $("#_projectName").val();
		$("#projectName").val(projectName);

		initModal();
		$("#modal-dialog").modal("hide");
	}

	// 팝업 초기화
	function initModal(){
		$("#_projectName").val("");
		$("#checkMsg").text("");
		$("#enableId").css("display", "none");
		$("#unableId").css("display", "block");
	}

	// 바로신청
	function noworder(){
		//alert($("#totalPrice").val());
		if($("input[name='onDemandFlag']:checked").val()=="N"){
			if($("#applyDate").val()==""){
				alert("서비스희망일시를 입력하세요");
				return false;
			}
			if($("#applyTime > option:selected").val()==""){
				alert("서비스희망일시 시간을 입력하세요");
				return false;
			}
		}
		if($("#projectName").val()==""){
			alert("프로젝트를 입력하세요");
			return false;
		}
		if($("#hostname").val()==""){
			alert("HOST NAME(영문명)을 입력하세요");
			return false;
		}
		if($("#hostnameAlias").val()==""){
			alert("HOST NAME ALIAS(한글명)를 입력하세요");
			return false;
		}
		if($("#osProductSeq > option:selected").val()==""){
			alert("OS를 선택하세요");
			return false;
		}


		$("#catalogueform").submit();
	}

	// 일괄신청
	function basketorder(){
		//alert($("#totalPrice").val());
		if($("input[name='onDemandFlag']:checked").val()=="N"){
			if($("#applyDate").val()==""){
				alert("서비스희망일시를 입력하세요");
				return false;
			}
			if($("#applyTime > option:selected").val()==""){
				alert("서비스희망일시 시간을 입력하세요");
				return false;
			}
		}
		if($("#projectName").val()==""){
			alert("프로젝트를 입력하세요");
			return false;
		}
		if($("#hostname").val()==""){
			alert("HOST NAME를 입력하세요");
			return false;
		}
		if($("#osProductSeq > option:selected").val()==""){
			alert("OS를 선택하세요");
			return false;
		}

		$("#totalPrice").val(rtnnumber($("#totalPrice").val()));
		$("#catalogueform").attr('action','basketOrder.do');
		$("#catalogueform").submit();
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
				url : "osSelect",
				dataType : "JSON",
				type : "POST",
				data : {
					"osProductSeq" : osProductSeq
				},
				success : function(data) {
					<c:choose>
						<c:when test="${getCatalogueSelectView.hourlyFlag eq 'Y'}">
							//alert(data.hourlyPrice);
							$("#osprice").empty();
							$("#osprice").append(addcomma(data.hourlyPrice));
							amount = Number(rtnnumber($("#imamount").val())) + Number(data.hourlyPrice) - Number($("#imosprice").val());
							amount = addcomma(amount);
							//alert(amount);
							//$("#amount").val(amount);
							$("#imamount").val(amount);
							$("#imosprice").val(data.hourlyPrice);
							$("#totalpriceview").empty();
							$("#totalpriceview").append(amount);
							$("#totalPrice").val(amount);
							//alert(amount);
							//amount = rtnnumber(amount);
							//alert(amount);
						</c:when>
						<c:otherwise>
							//alert(data.monthlyPrice);
							$("#osprice").empty();
							$("#osprice").append(addcomma(data.monthlyPrice));
							amount = Number(rtnnumber($("#imamount").val())) + Number(data.monthlyPrice) - Number($("#imosprice").val());
							//alert(amount);
							amount = addcomma(amount);
							//$("#amount").val(amount);
							$("#imamount").val(amount);
							$("#imosprice").val(data.monthlyPrice);
							$("#totalpriceview").empty();
							$("#totalpriceview").append(amount);
							$("#totalPrice").val(amount);
						</c:otherwise>
					</c:choose>
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
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

	/**
	 *  숫자만 입력 가능
	 */
	function number_only(id){
		//alert(id);
		$(id).val( $(id).val().replace(/[^0-9]/gi,''));
		if( !( event.keyCode>=48 && event.keyCode<=57 ) ){
			event.returnValue=false;
	    }

	}

	function diskfocusout(id){
		//alert(id);
		var diskcnt;
		diskcnt = Number($(id).val());
		//alert(diskcnt);
		if(diskcnt<30){
			alert("디스크는 최소 30GB 이상<br/>신청하셔야 합니다.");
			$(id).val($("#imdiskcnt").val());
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma($("#totalPrice").val()));
		}else if(diskcnt>10000){
			alert("디스크는 10,000GB 이상<br/>신청하실수 없습니다.");
			$(id).val($("#imdiskcnt").val());
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma($("#totalPrice").val()));
		}else{
			var imdiskcnt = diskcnt % 10;
			if(imdiskcnt==0){
				var diskprice;
				var imamount;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100; // 디스크 가격
				//alert(diskprice);
				//alert($("#imdiskprice").val());
				imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
				imamount =  imamount + diskprice ; //총가격에 디스크 가격 추가

				//alert(imamount);

				$("#imdiskcnt").val($(id).val());
				$("#imdiskprice").val(diskprice);
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}else{
				alert("디스크는 10GB 단위로<br/>신청하실수 있습니다.");
				$(id).val($("#imdiskcnt").val());
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma($("#totalPrice").val()));
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
			$("#diskpriceview").append(addcomma(diskprice));
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
				$("#diskpriceview").append(addcomma(diskprice));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
			}
		}

	}


//---> Modal popup start

	//modal팝업 open
	function openModal(){
		$("#modal-dialog").modal();
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

						Html="<tr><td class='tac'>"+val["projectName"]+"</td>";
						Html = Html + "<td class='tac'>"+val["projectAlias"]+"</td>";
						Html = Html + "<td class='tac'><input type='button' value='적용' data-dismiss='modal' class='btn btn-primary width-60' onclick='updateProject(\""+val["projectId"]+"\", \""+val["projectName"]+"\")'></td>";
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

	function updateProject(projectId, projectName){
		$("#projectName").val(projectName);
		$("#projectId").val(projectId);
		getNetworkList();
	}

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mbr/req/catalogue/catalogueList.do";
	}

 	function getNetworkList(){
		$.ajax({
			url : "${contextPath}/mng/oss/network/list",
			dataType : "JSON",
 			type : "GET",
			data : {
				"projectName" : $("#projectName").val()
			},
			success : function(req) {
				var obj = req.data;
				var vHtml = "<select class='form-control' id='networkId' name='networkId'>";
 				for(var i=0; i<obj.length; i++){
 					vHtml += "<option value='"+obj[i].id+"'>"+(obj[i].networkAlias==""?obj[i].name:obj[i].networkAlias)+"</option>";
				}
				vHtml += "</select>"
				$("#divNetwork").html(vHtml);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
 	}
	//<--- Modal popup end

	</script>

</body>
</html>