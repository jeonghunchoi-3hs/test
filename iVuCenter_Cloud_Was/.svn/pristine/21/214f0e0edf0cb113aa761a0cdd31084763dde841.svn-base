<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
</sec:authorize>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<c:import url="../include/import.jsp" charEncoding="UTF-8"></c:import>
		<title>KEPCO Cloud Service Platform</title>
	</head>
	
	<body>
		<!-- begin #page-container -->
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">			
			<!-- begin #header -->
			<c:import url="../../mbr/include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->
			<!-- begin #sidebar -->
			<c:import url="../../mbr/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->
			<!-- begin #content -->
			<div id="content" class="content bgwh">
				<input type="hidden" id="hid_mbrProjectResourcesList_button" value="1">
				
				<!-- begin page-body -->
				<div class="dashboard mb80">
					<!-- 상단 -->
					<ul>
						<li class="width-995 p10 user_box1">
							<h2 class="f30 fc11 tac mb30">시스템 운영 현황</h2>
							<div>
								<div class="width-400 dpin">
									<ul>
										<li>
											<p class="criticalA"> <span data-toggle="tooltip" data-html="true"  title="<div class='tal'>CPU 사용률이 98% 초과하거나 </br>MEM 사용률이 95% 초과합니다</br>그리고 기타 위험한 이벤트가</br>발생했습니다.</div>">${eventCnt.criticalCnt}</span></p>
										 	<p class="mt20 br5 b3dc tac p5 bgwh"><i class="fa fa-warning fc-red" ></i> 심각</p>
										</li>
										<li class="ml20">
											<p class="dangerB"><span data-toggle="tooltip" data-html="true"  title="<div class='tal'>CPU 사용률이 80% 초과하거나 </br>MEM 사용률이 80% 초과합니다</br>그리고 기타 주의가 필요한 </br>이벤트가 발생했습니다.</div>">${eventCnt.majorCnt}</span></p>
											<p class="mt20 br5 b3dc tac p5 bgwh"><i class="fa fa-exclamation-circle fc-orange"></i> 위험</p>
										</li>
										<li class="ml20"><p class="careC">
											<span data-toggle="tooltip" data-html="true"  title="<div class='tal'>CPU 사용률이 70% 초과하거나 MEM 사용률이 70% 초과합니다</br>그리고 기타 이벤트가</br>발생했습니다.</div>"> ${eventCnt.waringCnt}</span></p>
											<p class="mt20 br5 b3dc tac p5 bgwh"><i class="fa fa-exclamation fc-green"></i> 주의</p>
										</li>
									</ul>
								</div>
								<div class="width-280 dpin vt">
									<div class="cpu_box ml10">
										<h3 class="cpu_title">SERVER CPU TOP 5</h3>
										<c:choose>
											<c:when test="${fn:length(cpuTopX) != 0}">
												<ul class="mt5 mb5 p5 height-120">
													<c:forEach items="${cpuTopX}" var="item" varStatus="X" >
														<c:if test="${X.index < 5}">
															<li class="w25 dpin">${item.hostname}</li>
										  					<li class="w55 dpin">
										  						<div class="progress mt3">
		                                         					<div class="progress-bar progress-bar-warning" style="width: ${item.cpuUsedPct}%"></div>
		                                   						</div>
										  					</li>
												  			<li class="w15 dpin">${item.cpuUsedPct}%</li>
														</c:if>											
													</c:forEach>
												</ul>
											</c:when>
											<c:otherwise>
												<ul  class="height-130 tac">
													<li class="tac f16 pt30"> <i class="fa fa-server fc-dblue f30"></i> <br/> 해당서버가 없습니다.</li>
												</ul>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<div class="width-280 dpin vt">
									<div class="cpu_box ml10">
										<h3 class="cpu_title">SERVER MEMORY TOP 5</h3>
										<c:choose>
											<c:when test="${fn:length(memTopX) != 0}">
												<ul class="mb5 p5 height-120">
											  		<c:forEach items="${memTopX}" var="item" varStatus="X" >
														<c:if test="${X.index < 5}">
														  	<li class="w25 dpin">${item.hostname}</li>
														  	<li class="w55 dpin">
														  		<div class="progress mt3">
						                                         <div class="progress-bar progress-bar-success" style="width: ${item.memUsedPct}%"></div>
						                                   		</div>
														  	</li>
														  	<li class="w15 dpin">${item.memUsedPct}%</li>
														  		
											  			</c:if>											
													</c:forEach>
										  		</ul>
										  	</c:when>
										  	<c:otherwise>
												<ul class="height-130 tac">
													<li class="tac f16 pt30"> <i class="fa fa-server fc-dblue f30"></i> <br/> 해당서버가 없습니다.</li>
												</ul>  	
										  	</c:otherwise>
									  	</c:choose>
									</div>
								</div>
							</div>
						</li>
						<li class="width-600 flr p10 user_box2">
							<h2 class="f30 fc11 tac mb30">신청 및 승인 현황</h2>
							<div class="tac vm">
								<ul class="mt-10">
									<li class="w23 bsbx cursor p10 vt" onclick="projectReqLink()">
										<h3 class="f16 fc33 tac fb" >프로젝트 신청</h3><p class="sgbox">${mbrProjectReq.projectReqCount}</p>
										<p class="fc66 lh20">회원만 프로젝트 신청이 가능합니다. </p>
									</li>
									<li class="w23 bsbx cursor p10 vt" onclick="productReqLink()">
										<h3 class="f16 fc33 tac fb" >자원 신청/변경</h3><p class="sgbox">${mbrProductReq.productReqCount}</p>
									<p class="fc66 lh20">자원을 신청ㆍ변경ㆍ삭제 하실 수 <br/>있습니다.</p>
									</li>
									<li class="w23 bsbx cursor p10 vt" onclick="projectApproveLink()">
										<h3 class="f16 fc33 tac fb" >프로젝트 승인</h3><p class="sgbox">${mbrProjectApprove.projecApproveCount}</p>
									<p class="fc66 lh20">승인이 완료된 후 <br/> 자원 신청이 가능 <br/>합니다.</p>
									</li>
									<li class="w23 bsbx cursor p10 vt" onclick="productApproveLink()">
										<h3 class="f16 fc33 tac fb" >자원 승인</h3><p class="sgbox">${mbrProductApprove.productApproveCount}</p>
									<p class="fc66 lh20">자원승인이 완료된 후 바로 사용이 <br/>가능합니다.</p>
									</li>
								</ul>
							</div>
							
						</li>
					</ul>
					
					<!-- 하단 -->
					<ul class="mt30">
						<li class="width-995 p10 user_box3">
							<h2 class="f30 fc11 tac mb30">프로젝트 자원 현황</h2>
							<div>
								<div>
									<ul>
									   <li class="w15 dpin vt" style="margin-top:46px">	
								    		
								 		</li>
								  		<li class="w16 dpin bsbx cursor mr5" onclick="projectProduct1()">
								    		<div class="re_box"> 
								    			<h3 class="f20 fc-dblue tac p8"><img src="/resources/assets/img/server_icon.png" height="27px" class="vm"/> Server</h3>

								     		</div>
								 		</li>
										<li class="w16 dpin bsbx cursor mr5" onclick="projectProduct1()">
											<div class="re_box"> 
												<h3 class="f20 fc-dgreen tac p8"><img src="/resources/assets/img/icon_cpu.png"  height="27px"class="vm"/> vCPU</h3>
					
											</div>
										</li>
										<li class="w16 dpin bsbx cursor mr5" onclick="projectProduct1()">
											<div class="re_box"> 
												<h3 class="f20 fc-dbrown tac p8"><img src="/resources/assets/img/icon_mem.png"  height="27px" class="vm"/> Memory</h3>
					
											</div>
										</li>
								  		<li class="w16 dpin bsbx cursor mr5" onclick="projectProduct1()">
											<div class="re_box"> 
								    			<h3 class="f20 fc-dviolet tac p8"><img src="/resources/assets/img/icon_disk.png"  height="27px" class="vm"/> OS Disk</h3>

								     		</div>
								  		</li>
								  		<li class="w16 dpin bsbx cursor" onclick="projectProduct2()">
								  			<div class="re_box"> 
								      			<h3 class="f20 fc-grey3 tac p8"><img src="/resources/assets/img/icon_disk.png"  height="27px" class="vm"/> Data Disk</h3>
								      			
								      		</div>
								   		</li>
								 	</ul>
								 	<c:forEach items="${mbrProjectResources}" var="mbrProjectResources" varStatus="status" >
									 	<ul>
										   <li class="w15 dpin vt" >	
										   		<c:if test="${mbrProjectResources.cloudType eq 'openstack'}">
									    		<p class="re_box_left"><img src="/resources/assets/img/icon_openstack.png" height="24px" class="vm"/> ${mbrProjectResources.cloudName} </p>		
									    		</c:if>			 
									    		<c:if test="${mbrProjectResources.cloudType eq 'vmware'}">    		
									     		<p class="re_box_left"><img src="/resources/assets/img/icon_vm.png" height="24px" class="vm"/> ${mbrProjectResources.cloudName} </p>
									     		</c:if>	
									 		</li>
									  		<li class="w16 dpin bsbx cursor mr5" onclick="projectProduct1()">
									     		<p class="re_box_num">${mbrProjectResources.serverCnt} <span class="f20 fc33">EA</span></p>
									 		</li>
											<li class="w16 dpin bsbx cursor mr5" onclick="projectProduct1()">
									     		<p class="re_box_num">${mbrProjectResources.vcpus} <span class="f20 fc33">Core</span></p>
											</li>
											<li class="w16 dpin bsbx cursor mr5" onclick="projectProduct1()">
												<p class="re_box_num">${mbrProjectResources.memGb} <span class="f20 fc33">GB</span></p>
											</li>
									  		<li class="w16 dpin bsbx cursor mr5" onclick="projectProduct1()">
									     		<p class="re_box_num">${mbrProjectResources.osDisk} <span class="f20 fc33">GB</span></p>
									  		</li>
									  		<li class="w16 dpin bsbx cursor" onclick="projectProduct2()">
									     		<p class="re_box_num">${mbrProjectResources.dataDisk}  <span class="f20 fc33">GB</span></p>
									   		</li>
									 	</ul>
								 	</c:forEach>
								</div>
								<div id="useVolumeTable" style="min-height: 210px;">
									<table class="tableWV mt20">
										<colgroup>
										    <col width="13%"/>
											<col width="*"/>
											<col width="10%"/>
											<col width="10%"/>
											<col width="13%"/>
											<col width="13%"/>
											<col width="13%"/>
										</colgroup>
								 		<thead>
								 			<tr>
										 		<th>프로젝트명</th>
										 		<th class="fc-dblue">SERVER</th>
										 		<th class="fc-dgreen">vCPU</th>
										 		<th class="fc-dbrown ">MEMORY(GB)</th>
										 		<th class="fc-dviolet"> OS DISK(GB)</th>
										 		<th class="fc-grey3"> DATA DISK(GB)</th>
								 			</tr>
								 		</thead>
								  		<tbody>
								 			<tr>
								 				<td class="tal">프로젝트</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
								 			</tr>
								 			<tr>
								 				<td class="tal">프로젝트</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
								 			</tr>
								 			<tr>
								 				<td class="tal">프로젝트</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
								 			</tr>
								 		</tbody>
								 	</table>
							 	</div>
							
								<div class="tac">
									<button class="view_btn" id="button2"  onclick="mbrProjectResourcesList(2)">펼쳐보기</button>
									<button class="view_btn mt20" id="button1" onclick="mbrProjectResourcesList(1)">접어보기</button>					  
								</div>
							</div>
						</li>
						<li class="width-600 flr p10 user_box4">
							<h2 class="f30 fc11 tac mb20">서비스 현황</h2>
							
							<div>
								
							      <ul class="tar">
										<li class="w8 tal pl10"></li>
										<li class="w15 tal h60 mt-15 vm fb"></li>
										<li class="w23 h60 mt-15 vm tal lt-1"></li>
										<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
											<c:if test="${mbrServiceResources.cloudType eq 'openstack'}">
								    		<li class="w15 tac lt-1"> <img src="/resources/assets/img/icon_openstack.png" height="24px" class="vm"/><br/> ${mbrServiceResources.cloudName} </li>		
								    		</c:if>			 
								    		<c:if test="${mbrServiceResources.cloudType eq 'vmware'}">    		
								     		<li class="w15 tac lt-1"> <img src="/resources/assets/img/icon_vm.png" height="24px" class="vm"/><br/> ${mbrServiceResources.cloudName}</li>
								     		</c:if>	
										</c:forEach>

									</ul>
									
								<a href="${contextPath}/mbr/project/service/">
									<ul class="service01">
										<li class="w8 tal pl10"><i class="fa fa-shield f30 fc-6b87a2"></i></li>
										<li class="w15 tal h60 mt-15 vm fb">모니터링</li>
										<li class="w25 h60 mt-15 vm tal">가상서버 모니터링</li>
										<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
											<li class="w15 tar f30 fc-6b87a2 pr10">${mbrServiceResources.serviceTypeSecurity eq ''? 0:mbrServiceResources.serviceTypeSecurity}</li>
										</c:forEach>
									</ul>
								</a>
								<a href="${contextPath}/mbr/project/service/">
									<ul class="service02">
										<li class="w8 tal pl10"><i class="fa fa-user-plus f30 fc-577f14"></i></li>
										<li class="w15 tal h60 mt-15 vm fb">계정관리</li>
										<li class="w25 h60 mt-15 vm tal">사용자 인증ㆍ이상  <br/>행위 및 계정도용 탐지 </li>
										<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
										<li class="w15 tar f30 fc-577f14 pr10">${mbrServiceResources.serviceTypeAccount eq ''? 0:mbrServiceResources.serviceTypeAccount}</li>
										</c:forEach>
									</ul>
								</a>
								<a href="${contextPath}/mbr/project/service/">
									<ul class="service03">
										<li class="w8 tal pl10"><i class="fa fa-download f30 fc-707070"></i></li>
										<li class="w15 tal h60 mt-15 vm fb">백업관리</li>
										<li class="w25 h60 mt-15 vm tal">백업 저장장치 및 <br/>데이터 이동관리 </li>
										<c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
										<li class="w15 tar f30 fc-707070 pr10"> ${mbrServiceResources.serviceTypeBackup eq ''? 0:mbrServiceResources.serviceTypeBackup}</li>
										</c:forEach>
									</ul>
								</a>
								<a href="${contextPath}/mbr/project/service/">
									<ul class="service04">
									    <li class="w8 tal pl10"><i class="fa fa-cogs f30 fc-7d6eb7"></i></li>
									    <li class="w15 tal h60 mt-15 vm fb">SW설치</li>
									    <li class="w25 h60 mt-15 vm tal">서버에 필요한 <br/>프로그램 설치 </li>
									    <c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
									    <li class="w15 tar f30 fc-7d6eb7 pr10">${mbrServiceResources.serviceTypeSw eq ''? 0:mbrServiceResources.serviceTypeSw}</li>
									    </c:forEach>
									</ul>
								</a>
								<a href="${contextPath}/mbr/project/service/">
									<ul class="service05">
									    <li class="w8 tal pl10"><i class="fa fa-hdd-o f30 fc-d9a43a"></i></li>
									    <li class="w15 tal h60 mt-15 vm fb">디스크관리</li>
									    <li class="w25 h60 mt-15 vm tal">추가디스크 파티션<br/> 포맷 마운트 </li>
									    <c:forEach items="${mbrServiceResources}" var="mbrServiceResources" varStatus="status" >
									    <li class="w15 tar f30 fc-d9a43a pr10">${mbrServiceResources.serviceTypeDisk eq ''? 0:mbrServiceResources.serviceTypeDisk}</li>
									    </c:forEach>
									</ul>
								</a>

							</div>
						</li>
					</ul>
				</div>
				<!-- end page-body -->
				
				<div id="footer" class="footer bgef">
					<p>(우) 58322 전라남도 나주시 전력로 55 Copyright ⓒ 2020  KEPCO.   All rights reserved.<br/>
               		가상서버 신청 관련 문의사항은 <br> 사용문의 -> Q&A 게시판에 등록 바랍니다.</p>
					</p>
				</div>
			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->
	
		<c:import url="../../mbr/include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">
			$(document).ready(function() {
				App.init();				
				mbrProjectResourcesList(1);
				if($("#loginFlag").val()!="Y") {
					$("#dashboard").addClass("active");
				}
				
				alertBox3("K-Cloud 관련 문의사항은 <br> 사용문의 → Q&A 게시판에 등록 바랍니다.");

			});

			function mbrProjectResourcesList(gubun) {
				var gubunText = gubun;
				var urlText = "";
				
					if(gubunText == '1'){
						urlText = "/mbr/mbrhome/mbrProjectResourcesList"
							$("#hid_mbrProjectResourcesList_button").val("1");
						$("#button1").hide();
						$("#button2").show();
	
					}else{
						urlText = "/mbr/mbrhome/mbrProjectResourcesListTotal"
							$("#hid_mbrProjectResourcesList_button").val("2");
						$("#button1").show();
						$("#button2").hide();
					}
				
				$.ajax({
					url : urlText,
					dataType : "JSON",
					type : "GET",
					success : function(data) {						
						// 현재 사용 용량 팝업 부분
						var projectList = data;
						var html = "";
						var allHtml = "";
						$("#useVolumeTable > table").remove();
						html += "<table class='tableWV mt20'>";
				        html += "	<colgroup>";
						html += " 		<col width='*'/>";
						html += " 		<col width='10%'>";
						html += " 		<col width='10%'>";
						html += " 		<col width='13%'>";
						html += " 		<col width='13%'>";
						html += " 		<col width='13%'>";
						html += " 	</colgroup>";
						html += "	<thead>";
						html += "	    <tr>";
						html += "			<th>프로젝트명</th>";
						html += "			<th class='fc-dblue'>SERVER(EA)</th>";
						html += "			<th class='fc-dgreen'>vCPU(Core)</th>";
						html += "			<th class='fc-dbrown'>MEMORY(GB)</th>";
						html += "			<th class='fc-dviolet'> OS DISK(GB)</th>";
						html += "			<th class='fc-grey3'>DATA DISK(GB)</th>";
						html += "		</tr>";
						html += "	</thead>";
						html += "	<tbody>";
						
						$.each(projectList,function(key,val){
						
							
								allHtml += "		<tr>";
								allHtml += "			<td class='tal'>"+val["projectAlias"]+"</td>";
								allHtml += "			<td class='tar'>"+val["serverCnt"]+"</td>";
								allHtml += "			<td class='tar'>"+val["vcpus"]+"</td>";
								allHtml += "			<td class='tar'>"+val["memGb"]+"</td>";
								allHtml += "			<td class='tar'>"+val["osDisk"]+"</td>";
								allHtml += "			<td class='tar'>"+val["dataDisk"]+"</td>";
								allHtml += "		</tr>";
						
						});
						html += allHtml;
						
						html += "	</tbody> ";
						html += "</table>    " ;
						$("#useVolumeTable").append(html);
						
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}
				
				
				
				//링크 모음 시작
				
			// 프로젝트 신청현황 페이지 이동
			function projectReqLink(){
				location.href = "${contextPath}/mbr/req/project/projectList.do";
			}
			// 자원 신청현황 페이지 이동
			function productReqLink(){
				location.href = "${contextPath}/mbr/req/catalogue/bssOrderList";
			}
			// 프로젝트 승인 페이지 이동
			function projectApproveLink(){
				location.href = "${contextPath}/mbr/req/project/projectApproveList.do";	
			}
			// 자원 승인 페이지 이동
			function productApproveLink(){
				location.href = "${contextPath}/mbr/req/catalogue/bssOrderApproveList";
			}
			// 서비스 이용현황 페이지 이동
// 			function projectServiceReqLink(){
// 				location.href = "${contextPath}/mbr/project/service/";
// 			}	
			
			// 프로젝트 자원 현황, 
			function projectProduct1(){
				location.href = "${contextPath}/mbr/project/vm/";
			}
			// 서비스 이용현황 페이지 이동
			function projectProduct2(){
				location.href = "${contextPath}/mbr/project/disk/";
			}
				
				//링크 모음 끝
			
			
		</script>
	
	</body>
</html>