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
				<h1>자원구성 상세</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">자원관리</a><a href="#" class="on">자원구성 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<div class="client_DetailArea clearfix  m-b-40">
					<input type="hidden" id="productSeq" value="${productSeq}">
					<input type="hidden" id="productCategory" value="${productCategory}">
					<input type="hidden" id="serviceType" value="${serviceType}">


					<!-- 가격정보 시작 -->
					<c:forEach items="${getItemPrice}" var="getItemPrice" varStatus="status" >
					   <input type="hidden" id="${getItemPrice.itemId}Hourly" value="${getItemPrice.quantityHourly}">
					</c:forEach>

					<c:forEach items="${getItemPrice}" var="getItemPrice" varStatus="status" >
					   <input type="hidden" id="${getItemPrice.itemId}Monthly" value="${getItemPrice.quantityMonthly}">
					</c:forEach>

					<c:forEach items="${getItemPrice}" var="getItemPrice" varStatus="status" >
					   <input type="hidden" id="${getItemPrice.itemId}" value="${getItemPrice.itemId}">
					</c:forEach>
					<!-- 가격정보 끝 -->

					<h2 class="blueBoxTitle">자원 정보</h2>
					<h2 class="categoryTitle" id="productCategoryName"></h2>
					<div class="editArea categoryTitleArea" style="height: 34px; margin-top: 12px;">
						<span class="company_Name2" id="productName"></span>
						<span class="serverName f20 fc11" id="categoryNameEdit">
							<!-- <a type="button" onclick="inputShow();" class="title_modify"></a> -->
						</span>
						<span class="serverRename m-l-30" id="categoryNameUp">
							<input type="text" class="modiInput" id="nameEditInput" data-original-title="" title="" style="width:828px;">
							<a type="button" onclick="" class="modisave" data-dismiss="modal"></a>
							<a type="button" onclick="inputHide();" class="modicancel"></a>
						</span>
					</div>
					<p class="company_Info mt-8 m-b-25 p-t-15">
						<span class="company_labelf">사용여부 :</span><span class="company_cont" id="delFlag"></span>
						<input type="hidden" id="h_regUserId" value="">
						<span class="company_label">등록자 :</span><span class="company_cont" id="regUserName"></span>
						<span class="company_label">등록일시 :</span><span class="company_cont fontVdn" id="regDatetime2"></span>
					</p>
				</div>

				<!-- 가상서버 -->
				<div class="formType01 row"  id="productList" style="display:none;">
					<div class="col-xs-6">
					<h2 class="titleBuType01 m-b-20">가상서버 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="120px">
								 <col width="*">
							</colgroup>
								<tr>
									<th scope="row" ><strong class="fontVdn">vCPU</strong></th>
									<td class="fontVdn">
										<span class="flr f16 fontB">
											<span id="vcpus"></span>
											<span class="fc66 wd55 tar dpin fontN">Core</span>
										</span>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong class="fontVdn">MEMORY</strong></th>
									<td class="fontVdn">
										<span class="flr f16 fontB">
											<span id="memGb"></span>
											<span class="fc66 wd55 tar dpin fontN">GB</span>
										</span>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong class="fontVdn">DISK</strong></th>
									<td class="fontVdn">
										<span class="flr f16 fontB">
											<span id="diskGb"></span>
											<span class="fc66 wd55 tar dpin fontN">GB</span>
										</span>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong class="fontVdn">이미지유형</strong></th>
									<td class="fontVdn">
										<span class="flr f16 fontB">
											<span id="imageType"></span>

										</span>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong class="fontVdn">디스크유형</strong></th>
									<td class="fontVdn">
										<span class="flr f16 fontB">
											<span id="distType"></span>

										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
					<div class="col-xs-6">
							<!-- 가격정보 -->
	                  <div class="formType01"  id="">
						<h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col width="120px">
									 <col width="*">
								</colgroup>
									<tr>
										<th scope="row"><strong>월 금액</strong></th>
										<td>
											<span class="flr f16 fontB">
												<span class="fontVdn" id="vmMonthlyPrice">0</span>
												<span class="fc66  wd55 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>시간 금액</strong></th>
										<td>
											<span class="flr f16 fontB">
												<span class="fontVdn" id="vmHourlyPrice">0</span>
												<span class="fc66  wd55 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</div>
				 </div>

				<!-- 블록디스크 -->
				<div class="formType01 row"  id="diskList" style="display:none;">
					<div class="col-xs-6">
					 <h2 class="titleBuType01 m-b-20">블록디스크 정보</h2>
					 <div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="190px">
								 <col width="*">
							</colgroup>
								<tr>
									<th scope="row"><strong class="fontVdn">DISK</strong></th>
									<td class="fontVdn">
										<span class="flr f16 fontB">
											<span id="diskDiskGb"></span>
											<span class="fc66 wd40 tar dpin fontN">GB</span>
										</span>
									</td>
								</tr>
									<tr>
									<th scope="row"><strong class="fontVdn">디스크유형</strong></th>
									<td class="fontVdn">
										<span class="flr f16 fontB">
											<span id="diskType"></span>

										</span>
									</td>
								</tr>

							</tbody>
						</table>
					</div>
					</div>
					<div class="col-xs-6">
					  <h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col width="190px">
									 <col width="*">
								</colgroup>
									<tr>
										<th scope="row"><strong>월 금액</strong></th>
										<td>
											<span class="flr f16 fontB">
												<span class="fontVdn" id="diskMonthlyPrice">0</span>
												<span class="fc66  wd40 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>시간 금액</strong></th>
										<td>
											<span class="flr f16 fontB">
												<span class="fontVdn" id="diskHourlyPrice">0</span>
												<span class="fc66  wd40 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>

								</tbody>
							</table>
						</div>
					</div>
				 </div>

				 <!-- 서비스자원 -->
				 <div class="formType01 row"  id="bkList" style="display:none;">


					<div class="col-xs-6">
					       <h2 class="titleBuType01 m-b-20">서비스 자원정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="190px">
								 <col width="*">
							</colgroup>
								<tr>
									<th scope="row"><strong>서비스자원 유형 </strong></th>
									<td>
										<span class="flr f16 fontB fontVdn">
											<span id="backupGb"></span>
											<span class="fc66 wd40 tar dpin fontN">GB</span>
										</span>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>수량</strong></th>
									<td>
										<span class="flr f16 fontB fontVdn">
											<span id="">1</span>
											<span class="fc66 wd40 tar dpin fontN">식</span>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
					<div class="col-xs-6">
					          <!-- 가격정보 -->
	                <div class="formType01"  id="">
						<h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col width="190px">
									 <col width="*">
								</colgroup>
									<tr>
										<th scope="row"><strong>월 금액</strong></th>
										<td>
											<span class="flr f16 fontB">
												<span class="fontVdn" id="backupMonthlyPrice">0</span>
												<span class="fc66  wd40 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>시간 금액</strong></th>
										<td>
											<span class="flr f16 fontB">
												<span class="fontVdn" id="backupHourlyPrice">0</span>
												<span class="fc66  wd40 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</div>
				 </div>




				<!-- 운영체제 -->
				<div class="formType01"  id="osList" style="display:none;">
					<div class="col-xs-6">
					<h2 class="titleBuType01 m-b-20">운영체제 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="190px">
								 <col width="*">
							</colgroup>
								<tr>
									<th scope="row"><strong>클라우드</strong></th>
									<td class="fontVdn">
										<span class="f16 fontB">
											<span id="cloudName"></span>
										</span>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>운영체제</strong></th>
									<td class="fontVdn">
										<span class="f16 fontB">
											<span id="itemName"></span>
										</span>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>수량(단위)</strong></th>
									<td class="fontVdn">
										<span class="flr f16 fontB">
											<span id="quantity"></span>
											<span class="fc66 wd40 tar dpin fontN">EA</span>
										</span>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>이미지</strong></th>
									<td class="fontVdn">
										<span class="f16 fontB">
											<span id="vmImageInfo"></span>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
					<!-- 가격정보 -->
					<div class="col-xs-6">
	                <div class="formType01">
						<h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col width="190px">
									 <col width="*">
								</colgroup>
									<tr>
										<th scope="row"><strong>월 금액</strong></th>
										<td>
											<span class="flr f16 fontB">
												<span class="fontVdn" id="osMonthlyPrice" >0</span>
												<span class="fc66  wd40 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>시간 금액</strong></th>
										<td>
											<span class="flr f16 fontB">
												<span class="fontVdn">0</span>
												<span class="fc66 wd40 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</div>
				</div>

					<!--서비스 -->
				<div class="formType01"  id="serviceList" style="display:none;">
				<div class="col-xs-6">
					<h2 class="titleBuType01 m-b-20">서비스 정보</h2>
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="190px">
								 <col width="*">
							</colgroup>
								<tr>
									<th scope="row"><strong>수량</strong></th>
									<td>
										<span class="flr f16 fontB fontVdn">
											<span id="serviceEa"></span>
											<span class="fc66 wd40 tar dpin fontN">(식)</span>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
					<!-- 가격정보 -->
					<div class="col-xs-6">
	                <div class="formType01"  id="">
						<h2 class="titleBuType01 m-b-20">가격 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col width="190px">
									 <col width="*">
								</colgroup>
									<tr>
										<th scope="row"><strong>월 금액</strong></th>
										<td>
											<span class="flr f16 fontB">
												<span class="fontVdn" id="serviceMonthlyPrice">0</span>
												<span class="fc66  wd40 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
								<tr>
										<th scope="row"><strong>시간 금액</strong></th>
										<td>
											<span class="flr f16 fontB">
												<span class="fontVdn" id="serviceHourlyPrice">0</span>
												<span class="fc66  wd40 tar dpin fontN">원</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</div>
				</div>
				<div class="clear"></div>
		      <div class="row tac m-t-60">
		 			<a type="button" class="rbton bton_blue" onclick="moveProductUpdatePage('${productSeq}');"><i class="fa fa-pencil"></i> 수정</a>
		 			<a type="button" class="rbton bton_orange ml10" onclick="productDeleteQ();"><i class="fa fa-trash"></i> 삭제</a>
					<a type="button" class="rbton bton_dgrey ml10" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>
			</div>

			<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog-os" style="display:none;">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">os 설정</h4>
	                       </div>
	                       <div class="modal-body">
	                           <p class="m-b-20">
	                              <input type="text"  id="searchKeyword" value="" />
	                              <input type="button" value="검색" onclick="projectPmPopList();"/>
	                           </p>

								<div class="tableB">
									<table>
										<colgroup>

									 		<col width="30%">
									 		<col width="30%">
									 	</colgroup>
									 	<thead>
									 		<tr>
												<td class="left height-40 tac">자원 이름</td>
												<td class="left height-40 tac">적용</td>
											</tr>
									 	</thead>
										<tbody id="osPopListTable">

										</tbody>

									</table>
								</div>

	                      	</div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
					<!------여기까지 사용------>
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

		function pageSet(){

			$("#productList").hide();
			$("#osList").hide();
			$("#diskList").hide();
			$("#nasList").hide();
			$("#ipList").hide();
			$("#lbList").hide();
			$("#scmList").hide();
			$("#bkList").hide();
			$("#serList").hide();
			$("#mcaList").hide();
			$("#serviceList").hide();
		}
		//자원 상세 정보 불러오기
		function productView(productSeq) {
			$.ajax({
				url : "${contextPath}/mng/bss/product/productView",
				dataType : "JSON",
	 			type : "POST",
				data : {
					"productSeq" : productSeq
				},
				success : function(data) {
					var result = data;
					productSetData(result);

				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}

		function productSetData(result){
			$("#serviceType").val(result.serviceType);
			$("#productSeq").val(result.productSeq);
			$("#productName").text(result.productName);
			$("#productCategoryName").text(result.productCategoryName);
			$("#productCategory").val(result.productCategory);


			$("#h_regUserId").val(result.regUserId);
			$("#regUserName").text(result.userName);
			$("#regDatetime2").text(result.regDatetime2);

			$("#vmImageInfo").text(result.vmImageName+' ('+result.vmImageId+')');


			var cpuHourlyPrice = $("#CPU010Hourly").val();
			var cpuMonthlyPrice = $("#CPU010Monthly").val();
			var memHourlyPrice = $("#MEM010Hourly").val();
			var memMonthlyPrice = $("#MEM010Monthly").val();

			if((result.delFlag)=="N"){
				$("#delFlag").text("사용");
			}else {
				$("#delFlag").text("미사용");
			}

			if((result.productCategory)=="PRODCATE_VM"){


				$("#imageType").text(result.imageTypeName);
				$("#distType").text(result.diskTypeName);


				var diskType = result.diskType;
		        if(diskType ==$("#"+diskType+"").val()){
					var diskHourlyPrice = $("#"+diskType+"Hourly").val();
					var diskMonthlyPrice = $("#"+diskType+"Monthly").val();
		        }

	            var imageType = result.imageType;
	            if(imageType ==$("#"+imageType+"").val()){
					var imageHourlyPrice = $("#"+imageType+"Hourly").val();
					var imageMonthlyPrice = $("#"+imageType+"Monthly").val();
	            }

				$("#vcpus").text(result.vcpus);
				$("#memGb").text(result.memGb);
				$("#diskGb").text(addcomma(result.diskGb));
				var hp1 = result.vcpus*cpuHourlyPrice;
				var mp1 = result.vcpus*cpuMonthlyPrice;
				var hp2 = result.memGb*memHourlyPrice;
				var mp2 = result.memGb*memMonthlyPrice;
				var hp3 = result.diskGb*diskHourlyPrice;
				var mp3 = result.diskGb*diskMonthlyPrice;
				var hp4 = parseInt(imageHourlyPrice);
				var mp4 = parseInt(imageMonthlyPrice);


				$("#vmMonthlyPrice").text(addcomma(mp1+mp2+mp3+mp4));
				$("#vmHourlyPrice").text(addcomma(hp1+hp2+hp3+hp4));
				showProductView();
			}else if((result.productCategory)=="PRODCATE_OS"){
				$("#itemName").text(result.itemName);
				$("#cloudName").text(result.cloudName);
				$("#quantity").text(result.quantity);
				$("#unit").text(result.unit);


              var imageType = result.itemId;
	            if(imageType ==$("#"+imageType+"").val()){
					var imageHourlyPrice = $("#"+imageType+"Hourly").val();
					var imageMonthlyPrice = $("#"+imageType+"Monthly").val();
	            }

				 $("#osMonthlyPrice").text(parseInt(imageMonthlyPrice));


				showOsView();
			}else if((result.productCategory)=="PRODCATE_DISK"){
				$("#diskDiskGb").text(addcomma(result.diskGb));
				$("#diskType").text(result.codeName);

				var diskType = result.diskType;
		        if(diskType ==$("#"+diskType+"").val()){
					var diskHourlyPrice = $("#"+diskType+"Hourly").val();
					var diskMonthlyPrice = $("#"+diskType+"Monthly").val();
		        }

				var hp = result.diskGb*diskHourlyPrice;
				var mp = result.diskGb*diskMonthlyPrice;

				$("#diskMonthlyPrice").text(addcomma(mp));
				$("#diskHourlyPrice").text(addcomma(hp));
				showDiskView();
			}else if((result.productCategory)=="PRODCATE_SERVICE"){

				$("#serviceEa").text(result.serviceEa);

              	var serviceType = result.serviceType;
		        if(serviceType ==$("#"+serviceType+"").val()){
					var hp = $("#"+serviceType+"Hourly").val();
					var mp = $("#"+serviceType+"Monthly").val();
		        }

				$("#serviceMonthlyPrice").text(addcomma(mp));
				$("#serviceHourlyPrice").text(addcomma(hp));
				showServiceView();
			}
		}

		function showProductView(){
			$("#productList").show();
			$("#osList").hide();
			$("#diskList").hide();
			$("#serviceList").hide();
		}
		function showOsView(){

			$("#productList").hide();
			$("#osList").show();
			$("#diskList").hide();
			$("#serviceList").hide();

		}
		function showDiskView(){

			$("#productList").hide();
			$("#osList").hide();
			$("#diskList").show();
			$("#serviceList").hide();

		}

		function showServiceView(){
			$("#serviceList").show();
			$("#productList").hide();
			$("#osList").hide();
			$("#diskList").hide();
			$("#nasList").hide();
			$("#ipList").hide();
			$("#lbList").hide();
			$("#scmList").hide();
			$("#bkList").hide();
			$("#serList").hide();
			$("#mcaList").hide();
		}

 		//자원 상제 수정하기
 		function moveProductUpdatePage(productSeq){
				location.href = "${contextPath}/mng/bss/product/update?productSeq="+productSeq+"&productCategory="+$("#productCategory").val();
		}


 		function productDeleteQ(){
			confirmBox("삭제하시겠습니까?", productDelete);
 		}

 		function productDelete() {

			$.ajax({
				url : "${contextPath}/mng/bss/product/productDelete",
				dataType : "JSON",
	 			type : "POST",
				data : {
					"productSeq" : $("#productSeq").val()
					,"productCategory" : $("#productCategory").val()


				},
				success : function(data) {
					var result = data;

					alertBox("삭제되었습니다.", moveListPage);


				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});

		}





		// 목록 페이지이동
		function moveListPage(){
			location.href = "${contextPath}/mng/bss/product/";
		}

		function inputShow(){
			$("#nameEditInput").val($("#productName").text());
			$("#productName").hide();
			$("#categoryNameEdit").hide();
			$("#categoryNameUp").show();
		}
		function inputHide(){
			$("#productName").show();
			$("#categoryNameEdit").show();
			$("#categoryNameUp").hide();
		}
		$(document).ready(function() {

			App.init();
			pageSet();
			productView("${productSeq}");

			//메뉴활성화
			$("#productAservice").addClass("active");
			$("#product").addClass("active");


		});
	</script>
</body>
</html>