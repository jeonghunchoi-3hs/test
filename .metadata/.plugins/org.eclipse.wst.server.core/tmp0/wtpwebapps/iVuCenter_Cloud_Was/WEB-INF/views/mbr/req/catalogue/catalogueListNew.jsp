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
<!-- <body class="boxed-layout">  -->

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
			<h1 class="page-header"><span class="root"> <span class="home"><img src="${apachePath}/resources/assets/img/ico_home.png"  alt="홈"/></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow"><a href="${wasPath}/mbr/req/catalogue/catalogueList.do">자원신청</a></span><span class="text arrow"><a href="${wasPath}/mbr/req/catalogue/catalogueList.do">추천자원</a></span><span class="text arrow mint"><a href="${wasPath}/mbr/req/catalogue/catalogueList.do"><strong>목록</strong></a></span></span></h1>
			<!-- end header -->

			 <!-- begin page-body -->
			 <div class="row mb50">
			 	<p class="page_title">추천자원 목록</p> 
			 	
			 	<div class="catalogTapBg">
			 		<p class="title">K-Cloud에서 추천하는 자원</p>
			 		<p class="sectitle">회원사의 사업을 더욱더 활성화하고 성공비지니스를 향해 한 걸음 더 나가게 해줄것입니다</p>
			 	</div> 
			 	<div class="catalogTapArea">
			 		<ul class="ml230">
			 			<li class="active" id="tap01">
			 				<div class="catalogIcon01"></div>
			 				<p class="catalogtype">가상서버</p>
			 			</li>
			 			<li class="" id="tap02">
			 				<div class="catalogIcon07 mt30"></div>
			 				<p class="catalogtype pt15">디스크</p>
			 			</li>
			 		<!--<li class="" id="tap03">
			 				<div class="catalogIcon03"></div>
			 				<p class="catalogtype">NAS</p>
			 			</li>
			 			<li class="" id="tap04">
			 				<div class="catalogIcon04"></div>
			 				<p class="catalogtype">공인IP</p>
			 			</li>
			 			<li class="" id="tap05">
			 				<div class="catalogIcon05"></div>
			 				<p class="catalogtype">서비스 로드분산</p>
			 			</li>-->	
			 			<li class="" id="tap06">
			 				<div class="catalogIcon11"></div>
			 				<p class="catalogtype">서비스</p>
			 			</li>
			 		</ul>
			 	</div>
			 	
			 	<div class="tabPageArea active" id="page-tap01">
			 		<p class="title mt20">가상서버</p>
			 		<table class="productList bt1d3">
						<colgroup>
							<col width="15%">
							<col width="*">
							<col width="35%">
							<col width="15%">
						</colgroup>		
						 <tbody> 
					 		<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
								<c:if test='${getCatalogueList.catalogCategory eq "CATACATE_VM"}'> 	
						 			<tr>
						 			    <td class="tac"><img src="${getCatalogueList.imagePath}" class="height-100"></td>
						 				<td class="serverInfo">
						 					<p class="infoTitle">${getCatalogueList.displayName.replace(" ", " ")}</p>
												
												<!-- 가상서버 -->
												<c:if test="${getCatalogueList.descriptionList eq null or getCatalogueList.descriptionList eq ''}">
												<p class="infoContents">
													운영체제 설치를 위한 기본 DISK가 제공되며, <br>추가 DISK를 직접 생성 할 수 있습니다.
												</p>
												</c:if>
												<c:if test="${getCatalogueList.descriptionList ne null or getCatalogueList.descriptionList ne ''}">
												<p class="infoContents">
													${getCatalogueList.descriptionList}
												</p>
												</c:if>
												
						 				</td>
						 				<td class="productInfo">
						 				 <h3 class="f14 fc-dblue mb0 mt10 fb">★ Standard ★</h3>
						 					<span class="pcpu nanumR">${getCatalogueList.vcpus}Core</span>
						 					<span class="addcion"></span>
						 					<span class="pmem nanumR">${getCatalogueList.memGb}GB</span>
						 					<span class="addcion"></span>
						 					<span class="pdisk nanumR">${getCatalogueList.vmDiskGb}GB</span>
						 				</td>
						 				<!-- <td class="priceInfo">
						 					<p class="punint">가격(월)</p>
						 					<p class="nanumR unit"><span class="nanumR ptotalwon"><fmt:formatNumber value="${getCatalogueList.monthlyPrice}" pattern="#,###"/></span>&nbsp;원</p>
						 				</td> -->
						 				<td class="BasketArea">
						 					<a href="${wasPath}/mbr/req/catalogue/catalogueOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=N" class="insertBasket"></a>
						 				</td>
						 			</tr>
					 			</c:if>		 		 
							</c:forEach>
						</tbody>
					</table>
			 	</div>
			 	
			 	<div class="tabPageArea" id="page-tap02">
			 		<p class="title">디스크</p>
			 		<table class="productList bt1d3">
			 			<colgroup>
							<col width="15%">
							<col width="*">
							<col width="35%">
							<col width="15%">
						</colgroup>
						 <tbody>
					 		<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
								<c:if test='${getCatalogueList.catalogCategory eq "CATACATE_DISK"}'>	
						 			<tr>
						 			   <td class="tac"><img src="${getCatalogueList.imagePath}"  class="height-100"></td>
						 				<td class="serverInfo">
						 					<p class="infoTitle">${getCatalogueList.displayName.replace(" ", " ")}</p>
						 						
						 						<!-- 디스크 -->
						 						<c:if test="${getCatalogueList.descriptionList eq null or getCatalogueList.descriptionList eq ''}">
												<p class="infoContents">
													운영체제 설치를 위한 기본 DISK가 제공되며, <br>추가 DISK를 직접 생성 할 수 있습니다.
												</p>
												</c:if>
												<c:if test="${getCatalogueList.descriptionList ne null or getCatalogueList.descriptionList ne ''}">
												<p class="infoContents">
													${getCatalogueList.descriptionList}
												</p>
												</c:if>
												
						 				</td> 
						 				<td class="productInfo tac">
						 					<span class="pdisk nanumR">${getCatalogueList.diskGb}GB</span>
						 				</td>
						 				<!--<td class="priceInfo">
						 					<p class="punint">가격(월)</p>
						 					<p class="nanumR unit"><span class="nanumR ptotalwon"><fmt:formatNumber value="${getCatalogueList.monthlyPrice}" pattern="#,###"/></span>&nbsp;원</p>
						 				</td>-->
						 				<td class="BasketArea">
						 					<a href="${wasPath}/mbr/req/catalogue/catalogueDiskOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=N" class="insertBasket"></a>
						 				</td>
						 			</tr>
					 			</c:if>		 		 
							</c:forEach> 
						</tbody>
					</table>
			 	</div>


				<div class="tabPageArea"  id="page-tap03">
			 		<p class="title">NAS</p>
			 		<table class="productList bt1d3">
			 			<colgroup>
							<col width="*">
							<col width="9.3%">
							<col width="18.7%">
							<col width="12.3%">
						</colgroup>
						 <tbody>
					 		<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
								<c:if test='${getCatalogueList.catalogCategory eq "CATACATE_NAS"}'> 
						 			<tr>
						 				<td class="serverInfo">
						 					<p class="infoTitle">${getCatalogueList.displayName.replace(" ", " ")}</p>
						 						
						 						<!-- NAS -->
						 						<c:if test="${getCatalogueList.descriptionList eq null or getCatalogueList.descriptionList eq ''}">
												<p class="infoContents">
													다수의 업무용 서버들이 네트워크를 통하여 NFS 혹은 CIFS 프로토콜로 연결하여 <br/>사용할 수 있는 스토리지입니다.
												</p>
												</c:if>
												<c:if test="${getCatalogueList.descriptionList ne null or getCatalogueList.descriptionList ne ''}">
												<p class="infoContents">
													${getCatalogueList.descriptionList}
												</p>
												</c:if>
										
						 				</td>
						 				<td class="productInfo">
						 					<span class="pdisk nanumR">${getCatalogueList.nasGb}GB</span>
						 				</td>
						 				<td class="priceInfo">
						 					<p class="punint">가격(월)</p>
						 					<p class="nanumR unit"><span class="nanumR ptotalwon"><fmt:formatNumber value="${getCatalogueList.monthlyPrice}" pattern="#,###"/></span>&nbsp;원</p>
						 				</td>
						 				<td class="BasketArea">
						 					<a href="${wasPath}/mbr/req/catalogue/catalogueNasOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=N" class="insertBasket"></a>
						 				</td>
						 			</tr>
					 			</c:if>		 		 
							</c:forEach> 
						</tbody>
					</table>
			 	</div>
			 	
			 	
			 	<div class="tabPageArea"  id="page-tap04">
			 		<p class="title">공인IP<span class="flr f18 fc66 mt7">(VAT 별도)</span></p>
			 		<table class="productList">
			 			<colgroup>
							<col width="*">
							<col width="18.7%">
							<col width="12.3%">
						</colgroup>
						 <tbody>
					 		<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
								<c:if test='${getCatalogueList.catalogCategory eq "CATACATE_PUBLICIP"}'>
						 			<tr>
						 				<td class="serverInfo">
						 					<p class="infoTitle">${getCatalogueList.displayName.replace(" ", " ")}</p>
						 						
						 						<!-- 공인 IP -->
						 						<c:if test="${getCatalogueList.descriptionList eq null or getCatalogueList.descriptionList eq ''}">
												<p class="infoContents">
													외부에서 인터넷을 이용하여 내부의 자원에 접근할 수 있도록 내부 네트워크 IP와 1대 1로 <br/>IP를 매칭합니다.
												</p>
												</c:if>
												<c:if test="${getCatalogueList.descriptionList ne null or getCatalogueList.descriptionList ne ''}">
												<p class="infoContents">
													${getCatalogueList.descriptionList}
												</p>
												</c:if>
						 				
						 				</td>
						 				<td class="priceInfo">
						 					<p class="punint">가격(월)</p>
						 					<p class="nanumR unit"><span class="nanumR ptotalwon"><fmt:formatNumber value="${getCatalogueList.monthlyPrice}" pattern="#,###"/></span>&nbsp;원</p>
						 				</td>
						 				<td class="BasketArea">
						 					<a href="${wasPath}/mbr/req/catalogue/catalogueIpOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=N" class="insertBasket"></a>
						 				</td>
						 			</tr>
					 			</c:if>		 		 
							</c:forEach> 
						</tbody>
					</table>
			 	</div>
			 	
			 	<div class="tabPageArea"  id="page-tap05">
			 		<p class="title">서비스 로드분산<span class="flr f18 fc66 mt7">(VAT 별도)</span></p>
			 		<table class="productList">
			 			<colgroup>
							<col width="*">
							<col width="18.7%">
							<col width="12.3%">
						</colgroup>
						 <tbody> 
					 		<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
								<c:if test='${getCatalogueList.catalogCategory eq "CATACATE_LOADBALANCER"}'>	
						 			<tr>
						 				<td class="serverInfo">
						 					<p class="infoTitle">${getCatalogueList.displayName.replace(" ", " ")}</p>
												
												<!-- 서비스 로드분산 -->
						 						<c:if test="${getCatalogueList.descriptionList eq null or getCatalogueList.descriptionList eq ''}">
												<p class="infoContents">
													365일 중단 없는 안정적인 서비스 제공하기 위해 필요한 로드밸런서를 신청하기 위한 <br/>서비스 로드분산입니다.
												</p>
												</c:if>
												<c:if test="${getCatalogueList.descriptionList ne null or getCatalogueList.descriptionList ne ''}">
												<p class="infoContents">
													${getCatalogueList.descriptionList}
												</p>
												</c:if>
											
						 				</td>
						 				<td class="priceInfo">
						 					<p class="punint">가격(월)</p>
						 					<p class="nanumR unit"><span class="nanumR ptotalwon"><fmt:formatNumber value="${getCatalogueList.monthlyPrice}" pattern="#,###"/></span>&nbsp;원</p>
						 				</td>
						 				<td class="BasketArea">
						 					<a href="${wasPath}/mbr/req/catalogue/catalogueLoadBalancerOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=N" class="insertBasket"></a>
						 				</td>
						 			</tr>
					 			</c:if>		 		 
							</c:forEach>
						</tbody>
					</table>
			 	</div>
			 	
			 	<div class="tabPageArea"  id="page-tap06">
			 		<p class="title">서비스</p>
			 		<table class="productList bt1d3">
			 			<colgroup>
							<col width="15%">
							<col width="*">
							<col width="15%">
						</colgroup>
						 <tbody> 
					 		<c:forEach items="${getCatalogueServiceList}" var="getCatalogueServiceList" varStatus="status" >
						 			<tr>
						 			    <td class="tac vm"><img src="${getCatalogueServiceList.imagePath}" class="height-100"></td>
						 				<td class="serverInfo">
						 					<p class="infoTitle">${getCatalogueServiceList.displayName.replace(" ", " ")}</p>
						 					
						 						<!-- 서비스 로드분산 -->
						 						<c:if test="${getCatalogueServiceList.descriptionList eq null or getCatalogueServiceList.descriptionList eq ''}">
												<p class="infoContents">
													서비스 로드분산입니다.
												</p>
												</c:if>
												<c:if test="${getCatalogueServiceList.descriptionList ne null or getCatalogueServiceList.descriptionList ne ''}">
												<p class="infoContents">
													${getCatalogueServiceList.descriptionList}
												</p>
												</c:if>
						 					

						 				</td>
						 				<!-- <td class="priceInfo">
						 					<p class="punint">가격(월)</p>
						 					<p class="nanumR unit"><span class="nanumR ptotalwon"><fmt:formatNumber value="${getCatalogueServiceList.monthlyPrice}" pattern="#,###"/></span>&nbsp;원</p>
						 				</td> -->
						 				<td class="BasketArea">
						 					<a href="${wasPath}/mbr/req/catalogue/catalogueServiceOrder.do?productSeq=${getCatalogueServiceList.productSeq}&hourlyFlag=N" class="insertBasket"></a>
						 				</td>
						 			</tr>
							</c:forEach>
						</tbody>
					</table>
			 	</div>
			 	
			    <%-- 
			    	<!-- begin 가상서버시작입니다.... -->
			       <div class="col-lg-12">
			        <!-- begin panel -->
			       		<div class="panel panel-primary mb0">
				            <div class="panel-heading">
	                            <div class="panel-heading-btn">
	                                <a type="button" data-click="panel-collapse"><i class="fa fa-chevron-down f18 fc82 mt20 mr10" ></i></a>  
	                            </div>
				                <h4 class="panel-title"> <img src="${apachePath}/resources/assets/img/product_t_server.png"/> 가상서버 </h4>
				            </div>
		            		<div class="panel-body bgf9 pl30 pr30 pt0 mb20">
			           
								<!---가상서버   시작------>	
								
								<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
									<c:if test='${getCatalogueList.catalogCategory eq "CATACATE_VM"}'> 	
																								
										<div class="col-md-3 pl17 pr17 mt40">
											<h3 class="width-73_0${(status.index%6)+1}">${getCatalogueList.displayName.replace(" ", "<br/>")}</h3>
											<p class="tac b1cf height-198 vm pt30 mt-70 z-98">
												<!-- <img src="/resources/assets/img/plus_blockdisk.png" class="width-150"/> -->
 												<img src="${wasPath}/mbr/cmm/file/download/${getCatalogueList.imageName}" class="width-150"/>
											<img src="${wasPath}/mbr/cmm/file/download/${getCatalogueList.imageName}" class="width-150"/>   

											</p>
										    <div class="pl0 pr0 pb10">
										    	<li class="f15 fc66 mt10 pl10 fb">CPU <span class="ml40 fn">${getCatalogueList.vcpus} Core</span></li>
												<li class="f15 fc66 mt0 pl10 fb">MEM  <span class="ml36 fn">${getCatalogueList.memGb} GB</span></li>
												<li class="f15 fc66 mt0 pl10 fb">DISK <span class="ml36 fn">${getCatalogueList.vmDiskGb} GB</span></li>
												<li class="f14 fc66 mt5 pl10" id="monthlyPrice" name="monthlyPrice">가격(월)  
													<span class="fc00 f22 ml22"><fmt:formatNumber value="${getCatalogueList.monthlyPrice}" pattern="#,###"/></span>
												</li>								
												<li class="tac mt20 mb10">
													<a href="${wasPath}/mbr/req/catalogue/catalogueOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=N">
													  <img src="${apachePath}/resources/assets/img/btn_order02.png"/>
			<!-- 											<button type="button"  class="btn btn-lime_04" ><i class="fa fa-mouse-pointer"></i> 신청하기</button> -->
													</a>
												</li>
											</div>
										</div>						
									</c:if>				
								</c:forEach>
							</div>
						</div>
					</div>
					<!-- 가상서버 정말 끝입니다.... -->
				
				
				
				
				 <!-- begin 디스크시작   시작입니다.... -->
			    <div class="col-lg-12">
			        <!-- begin panel -->
			        <div class="panel panel-primary mb0">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a type="button" data-click="panel-collapse"><i class="fa fa-chevron-down f18 fc82 mt20 mr10" ></i></a>  
                            </div>
			                <h4 class="panel-title"> <img src="${apachePath}/resources/assets/img/product_t_disk.png"/> 디스크 </h4>
			            </div>
				            <div class="panel-body bgf9 pl30 pr30 pt0 mb20">
	                                <!-----디스크  시작-------->
										<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
											<c:if test='${getCatalogueList.catalogCategory eq "CATACATE_DISK"}'> 																
												<div class="col-md-3 pl17 pr17 mt40">
												   
														<h3 class="width-73_0${(status.index%6)+1}">${getCatalogueList.displayName.replace(" ", "<br/>")} </h3>
														<p class="tac b1cf height-198 vm pt30 mt-70 z-98">
														<img src="${wasPath}/mbr/cmm/file/download/${getCatalogueList.imageName}" class="width-190"/></p>
												    	<div class="pl0 pr0 pb10">
														<li class="f15 fc66 mt10 pl10 fb">DISK <span class="ml40 fn"> ${getCatalogueList.diskGb} GB</span></li>
														<li class="f14 fc66 mt5 pl10" id="monthlyPrice" name="monthlyPrice">가격(월)  
															<span class="fc00 f22 ml22">
																<fmt:formatNumber value="${getCatalogueList.monthlyPrice}" pattern="#,###"/>
															</span>
														</li>								
														<li class="tac mt20 mb10">
															<a href="${wasPath}/mbr/req/catalogue/catalogueDiskOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=N">
															 <img src="${apachePath}/resources/assets/img/btn_order02.png"/>
	<!-- 															<button type="button"  class="btn btn-lime_04" ><i class="fa fa-mouse-pointer"></i> 신청하기</button> -->
															</a>
														</li>
													    </div>
												</div>						
											</c:if>				
										</c:forEach>
								<!----디스크  끝----->
				        	</div>
			        <!-- end panel -->
               		 </div>
                </div>
                <!-- end 디스크 -->
			  
				
				   <!-- begin NAS시작 -->
			    <div class="col-lg-12">
			        <!-- begin panel -->
			        <div class="panel panel-primary mb0">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a type="button" data-click="panel-collapse"><i class="fa fa-chevron-down f18 fc82 mt20 mr10"></i></a>  
                            </div>
			                <h4 class="panel-title"> <img src="${apachePath}/resources/assets/img/product_t_nas.png"/> NAS</h4>
			            </div>
			            	<div class="panel-body bgf9 pl30 pr30 pt0 mb20">
                              
                                <!-----NAS  시작-------->
									<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
										<c:if test='${getCatalogueList.catalogCategory eq "CATACATE_NAS"}'> 																
											<div class="col-md-3 pl17 pr17 mt40">
											    
													<h3 class="width-73_0${(status.index%6)+1}">${getCatalogueList.displayName.replace(" ", "<br/>")} </h3>
													<p class="tac b1cf height-198 vm pt30 mt-70 z-98"><img src="${wasPath}/mbr/cmm/file/download/${getCatalogueList.imageName}" class="width-190"/></p>
											    	<div class="pl0 pr0 pb10">
														<li class="f15 fc66 mt10 pl10 fb">DISK <span class="ml40 fn"> ${getCatalogueList.nasGb} GB</span></li>
													
														<li class="f14 fc66 mt5 pl10" id="monthlyPrice" name="monthlyPrice">가격(월)  
														<span class="fc00 f22 ml22">
															<fmt:formatNumber value="${getCatalogueList.monthlyPrice}" pattern="#,###"/>
														</span>
														</li>								
													    <li class="tac mt20 mb10">
														<a href="${wasPath}/mbr/req/catalogue/catalogueNasOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=N">
														<img src="${apachePath}/resources/assets/img/btn_order02.png"/>
<!-- 															<button type="button"  class="btn btn-lime_04" ><i class="fa fa-mouse-pointer"></i> 신청하기</button> -->
														</a>
													   </li>
												     </div>
											</div>						
										</c:if>				
									</c:forEach>
							<!----NAS  끝----->
                          	</div>
			        </div>
			        <!-- end panel -->
                </div>
                <!-- end NAS -->
                
                
                  <!-- begin 공인IP 시작 -->
			    <div class="col-lg-12">
			        <!-- begin panel -->
			        <div class="panel panel-primary mb0">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a type="button" data-click="panel-collapse"><i class="fa fa-chevron-down f18 fc82 mt20 mr10" ></i></a>  
                            </div>
			                <h4 class="panel-title"><img src="${apachePath}/resources/assets/img/product_t_ip.png"/> 공인IP</h4>
			            </div>
			             	<div class="panel-body bgf9 pl30 pr30 pt0 mb20">

                                <!-----공인IP  시작-------->
									<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
										<c:if test='${getCatalogueList.catalogCategory eq "CATACATE_PUBLICIP"}'> 																
											<div class="col-md-3 pl17 pr17 mt40">
											    
													<h3 class="width-73_0${(status.index%6)+1}">${getCatalogueList.displayName.replace(" ", "<br>")} </h3>
													<p class="tac b1cf height-198 vm pt30 mt-70 z-98"><img src="${wasPath}/mbr/cmm/file/download/${getCatalogueList.imageName}" class="width-190"/></p>
											    
													<div class="pl0 pr0 pb10">
													<li class="f14 fc66 mt5 pl10" id="monthlyPrice" name="monthlyPrice">가격(월)  
														<span class="fc00 f22 ml22">
															<fmt:formatNumber value="${getCatalogueList.monthlyPrice}" pattern="#,###"/>
														</span>
													</li>								
													<li class="tac mt20 mb10">
														<a href="${wasPath}/mbr/req/catalogue/catalogueIpOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=N">
														<img src="${apachePath}/resources/assets/img/btn_order02.png"/>
<!-- 															<button type="button"  class="btn btn-lime_04" ><i class="fa fa-mouse-pointer"></i> 신청하기</button> -->
														</a>
													</li>
												</div>
											</div>						
										</c:if>				
									</c:forEach>
							<!----공인IP  끝----->   
							</div>               
			        </div>
			        <!-- end panel -->
                </div>
                <!-- end 공인IP -->
                
                
                
                	 <!-- begin 로드 밸런서 시작 -->
			    <div class="col-lg-12">
			        <!-- begin panel -->
			        <div class="panel panel-primary mb0">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a type="button" data-click="panel-collapse"><i class="fa fa-chevron-down f18 fc82 mt20 mr10" ></i></a>  
                            </div>
			                <h4 class="panel-title"><img src="${apachePath}/resources/assets/img/product_t_road.png"/> 로드 밸런서</h4>
			            </div>
			           		<div class="panel-body bgf9 pl30 pr30 pt0 mb20">
                              
                                <!-----로드 밸런서  시작-------->
									<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
										<c:if test='${getCatalogueList.catalogCategory eq "CATACATE_LOADBALANCER"}'> 																
											<div class="col-md-3 pl17 pr17 mt40">
													<h3 class="width-73_0${(status.index%6)+1}">${getCatalogueList.displayName.replace(" ", "<br>")} </h3>
													<p class="tac b1cf height-198 vm pt30 mt-70 z-98"><img src="${wasPath}/mbr/cmm/file/download/${getCatalogueList.imageName}" class="width-190"/></p>
											    	<!-- 
											    	<li class="f14 fc66 mt10 pl20">CPU : ${getCatalogueList.vcpus} Core</li>
													<li class="f14 fc66 mt5 pl20">MEM : ${getCatalogueList.memGb} GB</li>
													<li class="f14 fc66 mt5 pl20">DISK : ${getCatalogueList.diskGb} GB</li>
											    	 -->											    	
													<div class="pl0 pr0 pb10">
													<li class="f14 fc66 mt5 pl10" id="monthlyPrice" name="monthlyPrice">가격(월)  
														<span class="fc00 f22 ml22">
															<fmt:formatNumber value="${getCatalogueList.monthlyPrice}" pattern="#,###"/>
														</span>
													</li>								
													<li class="tac mt20 mb10">
														<a href="${wasPath}/mbr/req/catalogue/catalogueLoadBalancerOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=N">
															<img src="${apachePath}/resources/assets/img/btn_order02.png"/>
<!-- 															<button type="button"  class="btn btn-lime_04" ><i class="fa fa-mouse-pointer"></i> 신청하기</button> -->
														</a>
													</li>
													</div>
											</div>
										</c:if>				
									</c:forEach>
							<!----로드 밸런서  끝----->
							</div>
					 <!-- end panel -->
			        </div>
				</div>
                <!-- end 로드 밸런서 -->
                
                
 
				 <!-- begin 서비스시작 -->
			    <div class="col-lg-12">
			        <!-- begin panel -->
			        <div class="panel panel-primary mb0">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                 <a type="button" data-click="panel-collapse"><i class="fa fa-chevron-down f18 fc82 mt20 mr10" ></i></a>   
                            </div>
			                <h4 class="panel-title"><img src="${apachePath}/resources/assets/img/product_t_service.png"/> 서비스</h4>
			            </div>
			            	<div class="panel-body bgf9 pl30 pr30 pt0 mb20">
                                <!-----서비스  시작-------->
									<c:forEach items="${getCatalogueServiceList}" var="getCatalogueServiceList" varStatus="status" >																								
											<div class="col-md-3 pl17 pr17 mt40">
											   
													<h3 class="width-73_0${(status.index%6)+1}">${getCatalogueServiceList.displayName.replace(" ", "<br>")} </h3>
													<p class="tac b1cf height-198 vm pt30 mt-70 z-98"><img src="${wasPath}/mbr/cmm/file/download/${getCatalogueServiceList.imageName}"  class="width-190"/></p>
											    	<!-- 
											    	<li class="f14 fc66 mt10 pl20">CPU : ${getCatalogueServiceList.vcpus} Core</li>
													<li class="f14 fc66 mt5 pl20">MEM : ${getCatalogueServiceList.memGb} GB</li>
													<li class="f14 fc66 mt5 pl20">DISK : ${getCatalogueServiceList.diskGb} GB</li>
											    	 -->											    	
													<div class="pl0 pr0 pb10">
													<li class="f14 fc66 mt5 pl10" id="monthlyPrice" name="monthlyPrice">가격(월)  
														<span class="fc00 f22 ml22">
															<fmt:formatNumber value="${getCatalogueServiceList.monthlyPrice}" pattern="#,###"/>
														</span>
													</li>								
													<li class="tac mt20 mb10">
														<a href="${wasPath}/mbr/req/catalogue/catalogueServiceOrder.do?productSeq=${getCatalogueServiceList.productSeq}">
														<img src="${apachePath}/resources/assets/img/btn_order02.png"/>
<!-- 															<button type="button"  class="btn btn-lime_04" ><i class="fa fa-mouse-pointer"></i> 신청하기</button> -->
														</a>
													</li>
												    </div>
											</div>
									</c:forEach>
							<!----서비스  끝----->
							</div>

			        <!-- end panel -->
            	 </div>
 
			</div>
            <!-- end 서비스 -->
 --%>
			<!---- end page body---->
            </div>	
            		
			<!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->
  
	<!-- end page container -->
</div>

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	$(document).ready(function() {
		App.init();
	  	if($("input[name='hourlyFlag']:checked").val()=="N"){					
			$("#hourlyPriceview").hide();
			$("#monthlyPriceview").show();					
		}else{
			$("#monthlyPriceview").hide();
			$("#hourlyPriceview").show();
		}
		  
		$("a>button").on('click',function(){
			location.href = $(this).closest("a").attr("href");
		});
		
		$("input[name='hourlyFlag']").on('click',function(){	
			//alert($("input[name='hourlyFlag']:checked").val());
			if($("input[name='hourlyFlag']:checked").val()=="N"){					
				$("#hourlyPriceview").hide();
				$("#monthlyPriceview").show();					
			}else{
				$("#monthlyPriceview").hide();
				$("#hourlyPriceview").show();
			}			
		});
		
		$(".panel-heading-btn a i").click(function(){
			$(this).toggleClass("fa-chevron-down fa-chevron-up");
		});		
			
		$(".catalogTapArea ul li").click(function(){
			var tapPage= "#page-"+ $(this).attr('id');
			
			$(".catalogTapArea ul li").removeClass("active");	
			$(this).toggleClass("active");
			
			$(".tabPageArea").removeClass("active");
			$(tapPage).addClass("active");
		});
		 
		//메뉴활성화
		$("#reqProduct").addClass("active");
		$("#recommend").addClass("active");			
	});
	
</script>
	
</body>
</html>