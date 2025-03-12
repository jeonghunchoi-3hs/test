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
			<c:import url="../../mng/include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->
			<!-- begin #sidebar -->
			<c:import url="../../mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #content -->
			<div id="content" class="content_dash bge5">
			 	<!-- begin page-body -->
				<div class="row mt-20 pb50">
					<div class="row mt30">
						<div class="col-xs-12">
					 		<h3 class="dash_title">클라우드 자원 현황</h3>
					 		<div class="bg-white p10">
								<table class="tableI">
								<colgroup>
								    <col width="*"/>
									<col width="18%"/>
									<col width="18%"/>
									<col width="18%"/>
									<col width="18%"/>
									<col width="18%"/>
								</colgroup>
								<thead>
									<tr>
									<th></th>
									<th>가상서버</th>
									<th>vCPU</th>
									<th>Memory</th>
									<th>SAN디스크 </th>
									<th>Ceph디스크</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${mngProductAvr}" var="mngProductAvr" varStatus="status" >
									<tr>
									<td>
										<c:if test="${mngProductAvr.cloudType eq 'openstack'}">
											<img src="/resources/assets/img/icon_openstack.png" height="24px" class="vm"/>
										</c:if>
										<c:if test="${mngProductAvr.cloudType eq 'vmware'}">
											<img src="/resources/assets/img/icon_vm.png" height="24px" class="vm"/>
										</c:if>
								    	<p class="mt10"> ${mngProductAvr.cloudName} </p>
									</td>
									<td>
										<c:if test="${mngProductAvr.vmAvr <= 60}">
									    	<c:set var="vmFill" value="green" />
									    </c:if>
									    <c:if test="${mngProductAvr.vmAvr > 60}">
									    	<c:set var="vmFill" value="yellow" />
									    </c:if>
									    <c:if test="${mngProductAvr.vmAvr > 80}">
									    	<c:set var="vmFill" value="red" />
									    </c:if>
										<div class="progress mb5">
										<div class="progress-bar progress-bar-${vmFill}" style="width:<fmt:formatNumber value="${mngProductAvr.vmAvr}" pattern="#"/>%" pattern="#"/></div>
										</div>
										<span class="text-${vmFill} f16"><fmt:formatNumber value="${mngProductAvr.vmAvr+(1-(mngProductAvr.vmAvr%1))%1}" pattern="#"/>%</span> <span class="text-66">(<fmt:formatNumber value="${mngProductAvr.vmUsed}" pattern="#,###" />/<fmt:formatNumber value="${mngProductAvr.vmTotal}" pattern="#,###" /> EA)</span>
									</td>
									<td>
										<c:if test="${mngProductAvr.vcpuAvr <= 60}">
									    	<c:set var="cpuFill" value="green" />
									    </c:if>
									    <c:if test="${mngProductAvr.vcpuAvr > 60}">
									    	<c:set var="cpuFill" value="yellow" />
									    </c:if>
									    <c:if test="${mngProductAvr.vcpuAvr > 80}">
									    	<c:set var="cpuFill" value="red" />
									    </c:if>
										<div class="progress mb5">
											<div class="progress-bar progress-bar-${cpuFill}" style="width:<fmt:formatNumber value="${mngProductAvr.vcpuAvr}" pattern="#"/>%" pattern="#"/></div>
										</div>
										<span class="text-${cpuFill} f16"><fmt:formatNumber value="${mngProductAvr.vcpuAvr+(1-(mngProductAvr.vcpuAvr%1))%1}" pattern="#"/>%</span> <span class="text-66">(<fmt:formatNumber value="${mngProductAvr.vcpuUsed}" pattern="#,###" />/<fmt:formatNumber value="${mngProductAvr.vcpuTotal}" pattern="#,###" /> EA)</span>
									</td>
									<td>
										<c:if test="${mngProductAvr.memAvr <= 60}">
									    	<c:set var="memFill" value="green" />
									    </c:if>
									    <c:if test="${mngProductAvr.memAvr > 60}">
									    	<c:set var="memFill" value="yellow" />
									    </c:if>
									    <c:if test="${mngProductAvr.memAvr > 80}">
									    	<c:set var="memFill" value="red" />
									    </c:if>
										<div class="progress mb5">
											<div class="progress-bar progress-bar-${memFill}" style="width:<fmt:formatNumber value="${mngProductAvr.memAvr}" pattern="#"/>%" pattern="#"/></div>
										</div>
										<span class="text-${memFill} f16"><fmt:formatNumber value="${mngProductAvr.memAvr+(1-(mngProductAvr.memAvr%1))%1}" pattern="#"/>%</span> <span class="text-66">(<fmt:formatNumber value="${mngProductAvr.memUsed}" pattern="#,###" />/<fmt:formatNumber value="${mngProductAvr.memTotal}" pattern="#,###" /> GB)</span>
									</td>
									<td>
										<c:forEach items="${mngProductAvr.storageList}" var="storageList" varStatus="status" >
											<c:if test="${storageList.storageType eq 'hitachi-g900' }">
												<c:set var="storageAvr" value="${storageList.usedSpace / storageList.totalSpace * 100}" />
												<c:if test="${storageAvr <= 60}">
													<c:set var="storageFill" value="green" />
												</c:if>
												<c:if test="${storageAvr > 60}">
													<c:set var="storageFill" value="yellow" />
												</c:if>
												<c:if test="${storageAvr > 80}">
													<c:set var="storageFill" value="red" />
												</c:if>
												<c:if test="${mngProductAvr.cloudType eq 'openstack' }">
													<div class="progress mb5">
														<div class="progress-bar progress-bar-${storageFill}" style="width:<fmt:formatNumber value="${storageAvr}" pattern="#"/>%" pattern="#"/></div>
													</div>
													<span class="text-yellow f16"><fmt:formatNumber value="${storageAvr+(1-(storageAvr%1))%1}" pattern="#"/>%</span> <span class="text-66">(<fmt:formatNumber value="${storageList.usedSpace}" pattern="#,###" />/<fmt:formatNumber value="${storageList.totalSpace}" pattern="#,###" />GB)</span>
												</c:if>
												<c:if test="${mngProductAvr.cloudType eq 'vmware' }">
													<h6 class="mb5 tal">${storageList.storageId}</h6>
													<div class="progress mb5">
														<div class="progress-bar progress-bar-${storageFill}" style="width:<fmt:formatNumber value="${storageAvr}" pattern="#"/>%" pattern="#"/></div>
													</div>
													<span class="text-${storageFill} f16"><fmt:formatNumber value="${storageAvr}" pattern="#"/>%</span> <span class="text-66">(<fmt:formatNumber value="${storageList.usedSpace}" pattern="#,###" />/<fmt:formatNumber value="${storageList.totalSpace}" pattern="#,###" />GB)</span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
									<td>
										<c:if test="${mngProductAvr.cloudType eq 'openstack' and mngProductAvr.cloudId eq 'e8bea700-878f-489e-bd11-488398a33ed8'}">
											<c:forEach items="${mngProductAvr.storageList}" var="storageList" varStatus="status" >
												<c:set var="storageAvr" value="${storageList.usedSpace / storageList.totalSpace * 100}" />
												<c:if test="${storageAvr <= 60}">
													<c:set var="storageFill" value="green" />
												</c:if>
												<c:if test="${storageAvr > 60}">
													<c:set var="storageFill" value="yellow" />
												</c:if>
												<c:if test="${storageAvr > 80}">
													<c:set var="storageFill" value="red" />
												</c:if>
												<c:if test="${storageList.storageType eq 'tripleo_ceph' }">
													<h6 class="mb5 tal">SATA</h6>
												</c:if>
												<c:if test="${storageList.storageType eq 'tripleo_ceph2' }">
													<h6 class="mb5 tal">SAS</h6>
												</c:if>
												<c:if test="${storageList.storageType eq 'tripleo_ceph' or storageList.storageType eq 'tripleo_ceph2'}">
												<div class="progress mb5">
													<div class="progress-bar progress-bar-${storageFill}" style="width:<fmt:formatNumber value="${storageAvr}" pattern="#"/>%" pattern="#"/></div>
												</div>
												<span class="text-${storageFill} f16"><fmt:formatNumber value="${storageAvr}" pattern="#"/>%</span> <span class="text-66">(<fmt:formatNumber value="${storageList.usedSpace}" pattern="#,###" />/<fmt:formatNumber value="${storageList.totalSpace}" pattern="#,###" />GB)</span>
												</c:if>
											</c:forEach>
										</c:if>
									</td>
									</tr>
									</c:forEach>
								</tbody>
								</table>
							</div>
					 	</div>
					</div>


					<div class="row mt20">
						<div class="col-xs-7">
							<h3 class="dash_title">시스템 운영 현황</h3>
						 	<div class="wbox height-220  bg-white">

								<ul class="tac p10">
						 			<li class="dpin w38 vm fl">
						 	   			<div class="stick">
						 	    			<h4 class="stick_title">SERVER CPU TOP 5</h4>
<!-- 						 	       			<div id="cpuChart" style="min-width: 260px; height: 150px; margin: 0 auto"></div> -->
						 	       			<canvas id="cpuChart" style="width: 100%; height: 100%; margin: 0 auto"></canvas>
						 	       		</div>

						 			</li>

						 			<li class="dpin w20 vm">
						 	  			<div class="siginal">
						 	  				<i class="fa fa-warning fc-red f24 pt10"></i>
						 	  				<span class="text">심각</span>
						 	  				<span class="dpin flr width-60 bgwh br5 p10 fc-red f26">${eventCnt.criticalCnt}</span>
						 	  			</div>
						 	  			<div class="siginal mt10">
						 	  				<i class="fa fa-exclamation-circle fc-orange2 f24 pt10"></i>
						 	  				<span class="text"> 위험</span>
						 	  				<span class="dpin flr width-60 bgwh br5 p10 fc-orange2 f26">${eventCnt.warningCnt}</span>
						 	  			</div>

						 	  			<div class="siginal mt10">
						 	  				<i class="fa fa-exclamation fc-green3 f24 pt10"></i>
						 	  				<span class="text pl10"> 주의</span>
						 	  				<span class="dpin flr width-60 bgwh br5 p10 fc-green3 f26">${eventCnt.infoCnt}</span>
						 	  			</div>
						 			</li>

						 			<li class="dpin w38 vm flr">
							 	   		<div class="stick">
							 	    		<h4 class="stick_title">SERVER Memory TOP 5</h4>
							 	    		<canvas id="memChart" style="width: 100%; height: 100%; margin: 0 auto"></canvas>
							 	   		</div>
						 			</li>
						 		</ul>
							</div>
						</div>
						<!-- 승인 및 작업현황 시작  -->

						<div class="col-xs-5">
					 		<h3 class="dash_title">승인 및 작업현황</h3>
					 		<div class="bg-white p10">
						 	  	<!-- begin nav-pills -->
		                        <ul class="nav nav-pills2 nav-justified">
		                            <li class="active"><a href="#nav-pills-one" data-toggle="tab">나의 할일</a></li>
		                            <li><a href="#nav-pills-two" data-toggle="tab">프로젝트 승인</a></li>
		                            <li><a href="#nav-pills-three" data-toggle="tab">자원 승인</a></li>
		                            <li><a href="#nav-pills-four" data-toggle="tab">사용자 승인</a></li>
		                            <li><a href="#nav-pills-five" data-toggle="tab">작업</a></li>
		                        </ul>
	                        	<!-- end nav-pills -->
	                        	<!-- begin tab-content -->
	                        	<div class="tab-content b2blue mb15">
	                            	<div class="tab-pane fade active in" id="nav-pills-one">
	                                	<ul>
	                                		<li class="w24 dpin tac"><p class="cc_g" onclick="projectApproveLink()" style="cursor:pointer">${myAllWork[0].myCnt}</p><p class="f16 fc33 pt10 fb">프로젝트 승인 </p></li>
	                                		<li class="w24 dpin tac"><p class="cc_g" onclick="productApproveLink()" style="cursor:pointer">${myAllWork[1].myCnt}</p><p class="f16 fc33 pt10 fb">자원 승인 </p></li>
	                                		<li class="w24 dpin tac"><p class="cc_g" onclick="userApproveLink()" style="cursor:pointer">${myAllWork[2].myCnt}</p><p class="f16 fc33 pt10 fb">사용자 승인 </p></li>
	                                		<li class="w24 dpin tac"><p class="cc_g" onclick="myWorkLink()" style="cursor:pointer">${myAllWork[3].myCnt}</p><p class="f16 fc33 pt10 fb">작업 </p></li>
	                                	</ul>
	                            	</div>
	                            	<div class="tab-pane fade" id="nav-pills-two">
										<ul>
	                                		<li class="w32 dpin tac"><p class="cc_g" onclick="projectAllApproveLink()" style="cursor:pointer">${mngProjectApprove.runningCnt}</p><p class="f16 fc33 pt10 fb">처리중</p></li>
	                                		<li class="w32 dpin tac"><p class="cc_g" onclick="projectAllApproveLink()" style="cursor:pointer">${mngProjectApprove.rejectCnt}</p><p class="f16 fc33 pt10 fb">반려 </p></li>
	                                		<li class="w32 dpin tac"><p class="cc_g" onclick="projectAllApproveLink()" style="cursor:pointer">${mngProjectApprove.endCnt}</p><p class="f16 fc33 pt10 fb">승인 완료 </p></li>
	                                	</ul>
	                            	</div>
	                            	<div class="tab-pane fade" id="nav-pills-three">
	                                	<ul>
	                                		<li class="w32 dpin tac"><p class="cc_g" onclick="productAllApproveLink()" style="cursor:pointer">${mngProductApprove.runningCnt}</p><p class="f16 fc33 pt10 fb">처리중</p></li>
	                                		<li class="w32 dpin tac"><p class="cc_g" onclick="productAllApproveLink()" style="cursor:pointer">${mngProductApprove.rejectCnt}</p><p class="f16 fc33 pt10 fb">반려 </p></li>
	                                		<li class="w32 dpin tac"><p class="cc_g" onclick="productAllApproveLink()" style="cursor:pointer">${mngProductApprove.endCnt}</p><p class="f16 fc33 pt10 fb">승인 완료 </p></li>
	                                	</ul>
	                            	</div>
	                             	<div class="tab-pane fade" id="nav-pills-four">
										<ul>
	                                		<li class="w49 dpin tac"><p class="cc_g" onclick="userApproveLink()" style="cursor:pointer">${mngUserApprove.runningCnt}</p><p class="f16 fc33 pt10 fb">가입 요청</p></li>
	                                		<li class="w49 dpin tac"><p class="cc_g" onclick="userApproveLink()" style="cursor:pointer">${mngUserApprove.endCnt}</p><p class="f16 fc33 pt10 fb">가입 승인</p></li>
	                                	</ul>
	                            	</div>
	                            	<div class="tab-pane fade" id="nav-pills-five">
										<ul class="mt0">
	                                		<li class="w49 dpin tac"><p class="cc_g" onclick="workAllApproveLink()" style="cursor:pointer">${mngMyWork.runningCnt}</p><p class="f16 fc33 pt10 fb">처리중</p></li>
	                                		<li class="w49 dpin tac"><p class="cc_g" onclick="workAllApproveLink()" style="cursor:pointer">${mngMyWork.endCnt}</p><p class="f16 fc33 pt10 fb">작업 완료 </p></li>
	                                	</ul>
	                            	</div>
	                        	</div>
	                        	<!-- end tab-content -->
							</div>
					 	</div>

						<!--  승인 및 작업 현황 끝  -->




					</div>


					<!-- <div class="row mt20">

					 	<!-- 미답변 QA 시작  -->
					 	<!-- <div class="col-xs-6">
							<h3 class="dash_title">미답변 Q&A</h3>
						 	<div class="height-210  bg-white p10">
							 	<table class="tableV">
							 		<colgroup>
									 	<col width="*"/>
									 	<col width="10%"/>
									 	<col width="20%"/>
						 			</colgroup>
						 			<thead>
						 				<tr>
							 				<th>제 목</th>
							 				<th>작성자</th>
							 				<th>작성일시</th>
							 			</tr>
						 			</thead>
						 			<tbody>
						 				<c:forEach items="${mngQnaList}" var="mngQnaList" varStatus="status" >
						 				<tr onclick="qnaLink()" style="cursor:pointer">
						 					<td class="tal">${mngQnaList.title}</td>
						 					<td>${mngQnaList.regName}</td>
						 					<td>${mngQnaList.regDatetime}</td>
						 				</tr>
						 				</c:forEach>
						 			</tbody>
						 		</table>
						 	</div>
					 	</div>
					 	<!-- 미답변 QA 시작  --
					</div>-->

					<div class="row mt20">
						<div class="col-xs-6">
					 		<h3 class="dash_title">클라우드 서비스 현황</h3>
					 		<div class="bg-white p10">

					 			<!-- begin nav-pills -->
		                        <ul class="nav nav-pills2 nav-justified">
		                            <li class="active"><a href="#nav-pills-1" data-toggle="tab">ALL</a></li>
		                            <c:forEach items="${mngCloudProduct}" var="mngCloudProduct" varStatus="status" >
		                            	<li><a href="#nav-pills-${status.count + 1}" data-toggle="tab">${mngCloudProduct.cloudName}</a></li>
		                            </c:forEach>
		                        </ul>
		                        <c:set var="allCompanyCnt" value="" />
								<c:set var="allProjectCnt" value="" />
								<c:set var="allVmCnt" value="" />
								<c:set var="allVcpuCnt" value="" />
								<c:set var="allMemGb" value="" />
								<c:set var="allOsDiskCnt" value="" />
								<c:set var="allOsDiskSizeGb" value="" />
								<c:set var="allDataDiskCnt" value="" />
								<c:set var="allDataDiskSizeGb" value="" />
		                        <c:forEach items="${mngCloudProduct}" var="mngCloudProduct" varStatus="status" >
		                        	<c:if test="${status.count eq '1'}">
			                        	<c:set var="allCompanyCnt" value="${allCompanyCnt + mngCloudProduct.companyCnt}" />
										<c:set var="allProjectCnt" value="${allProjectCnt + mngCloudProduct.projectCnt}" />
									</c:if>
									<c:set var="allVmCnt" value="${allVmCnt + mngCloudProduct.vmCnt}" />
									<c:set var="allVcpuCnt" value="${allVcpuCnt + mngCloudProduct.vcpuCnt}" />
									<c:set var="allMemGb" value="${allMemGb + mngCloudProduct.memGb}" />
									<c:set var="allOsDiskCnt" value="${allOsDiskCnt + mngCloudProduct.osDiskCnt}" />
									<c:set var="allOsDiskSizeGb" value="${allOsDiskSizeGb + mngCloudProduct.osDiskSizeGb}" />
									<c:set var="allDataDiskCnt" value="${allDataDiskCnt + mngCloudProduct.dataDiskCnt}" />
									<c:set var="allDataDiskSizeGb" value="${allDataDiskSizeGb + mngCloudProduct.dataDiskSizeGb}" />
		                        </c:forEach>
	                        	<!-- end nav-pills -->
	                        	<!-- begin tab-content -->
	                        	<div class="tab-content b2blue">
	                        		<div class="tab-pane fade active in" id="nav-pills-1">
		                                <ul class="tac p20">
							 			<li class="service01 cursor" onclick="projectInfoLink()">
							  				<h5 class="pt5 f16 fc-ser01 fb tac">회원수</h5>
							  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${mngUserApprove.userCount}" pattern="#,###"/><span class="f16 fc66"></span></span>
							  			</li>
							   			<li class="service02 cursor" onclick="projectInfoLink()">
							  				<h5 class="pt5 f16 fc-ser02 fb tac">프로젝트</h5>
							  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${allProjectCnt}" pattern="#,###"/><span class="f16 fc66">EA</span></span>
							  			</li>
							  			<li class="service03 cursor" onclick="projectVmLink()">
							  				<h5 class="pt5 f16 fc-ser03 fb tac">SERVER</h5>
							  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${allVmCnt}" pattern="#,###"/><span class="f16 fc66">EA</span></span>
							  			</li>
							    		<li class="service04 cursor" onclick="projectVmLink()">
							  				<h5 class="pt5 f16 fc-ser04 fb tac">vCPU</h5>
							  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${allVcpuCnt}" pattern="#,###"/><span class="f16 fc66">Core</span></span>
							  			</li>
							    		<li class="service05 cursor" onclick="projectVmLink()">
							  				<h5 class="pt5 f16 fc-ser01 fb tac">MEMORY</h5>
							  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${allMemGb}" pattern="#,###"/><span class="f16 fc66">GB</span></span>
							  			</li>
							    		<li class="service06 cursor" onclick="projectVmLink()">
							  				<h5 class="pt5 f16 fc-ser02 fb tac">OS DISK 수량</h5>
							  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${allOsDiskCnt}" pattern="#,###"/><span class="f16 fc66">EA</span></span>
							  			</li>
							   			<li class="service07 cursor" onclick="projectVmLink()">
							  				<h5 class="pt5 f16 fc-ser03 fb tac">OS DISK 용량</h5>
							  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${allOsDiskSizeGb}" pattern="#,###"/><span class="f16 fc66">GB</span></span>
							  			</li>
							    		<li class="service08 cursor" onclick="projectDiskLink()">
							  				<h5 class="pt5 f16 fc-ser04 fb tac">DATA DISK 수량</h5>
							  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${allDataDiskCnt}" pattern="#,###"/><span class="f16 fc66">EA</span></span>
							  			</li>
							    		<li class="service09 cursor" onclick="projectDiskLink()">
							  				<h5 class="pt5 f16 fc-ser01 fb tac">DATA DISK 용량</h5>
							  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${allDataDiskSizeGb}" pattern="#,###"/><span class="f16 fc66">GB</span></span>
							  			</li>
							  			</ul>
	                            	</div>
	                        		<c:forEach items="${mngCloudProduct}" var="mngCloudProduct" varStatus="status" >
	                        			<div class="tab-pane fade" id="nav-pills-${status.count + 1}">
											<ul class="tac p20">
									 			<li class="service01 cursor" onclick="projectInfoLink()">
									  				<h5 class="pt5 f16 fc-ser01 fb tac">회원수</h5>
									  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${mngUserApprove.userCount}" pattern="#,###"/><span class="f16 fc66"></span></span>
									  			</li>
									   			<li class="service02 cursor" onclick="projectInfoLink()">
									  				<h5 class="pt5 f16 fc-ser02 fb tac">프로젝트</h5>
									  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${mngCloudProduct.projectCnt}" pattern="#,###"/><span class="f16 fc66">EA</span></span>
									  			</li>
									  			<li class="service03 cursor" onclick="projectVmLink()">
									  				<h5 class="pt5 f16 fc-ser03 fb tac">SERVER</h5>
									  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${mngCloudProduct.vmCnt}" pattern="#,###"/><span class="f16 fc66">EA</span></span>
									  			</li>
									    		<li class="service04 cursor" onclick="projectVmLink()">
									  				<h5 class="pt5 f16 fc-ser04 fb tac">vCPU</h5>
									  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${mngCloudProduct.vcpuCnt}" pattern="#,###"/><span class="f16 fc66">Core</span></span>
									  			</li>
									    		<li class="service05 cursor" onclick="projectVmLink()">
									  				<h5 class="pt5 f16 fc-ser01 fb tac">MEMORY</h5>
									  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${mngCloudProduct.memGb}" pattern="#,###"/><span class="f16 fc66">GB</span></span>
									  			</li>
									    		<li class="service06 cursor" onclick="projectVmLink()">
									  				<h5 class="pt5 f16 fc-ser02 fb tac">OS DISK 수량</h5>
									  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${mngCloudProduct.osDiskCnt}" pattern="#,###"/><span class="f16 fc66">EA</span></span>
									  			</li>
									   			<li class="service07 cursor" onclick="projectVmLink()">
									  				<h5 class="pt5 f16 fc-ser03 fb tac">OS DISK 용량</h5>
									  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${mngCloudProduct.osDiskSizeGb}" pattern="#,###"/><span class="f16 fc66">GB</span></span>
									  			</li>
									    		<li class="service08 cursor" onclick="projectDiskLink()">
									  				<h5 class="pt5 f16 fc-ser04 fb tac">DATA DISK 수량</h5>
									  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${mngCloudProduct.dataDiskCnt}" pattern="#,###"/><span class="f16 fc66">EA</span></span>
									  			</li>
									    		<li class="service09 cursor" onclick="projectDiskLink()">
									  				<h5 class="pt5 f16 fc-ser01 fb tac">DATA DISK 용량</h5>
									  				<span class="fc33 f28 flr pr10 pt25"><fmt:formatNumber value="${mngCloudProduct.dataDiskSizeGb}" pattern="#,###"/><span class="f16 fc66">GB</span></span>
									  			</li>
								  			</ul>
			                            </div>
	                        		</c:forEach>
	                        	</div>
							</div>
					 	</div>

					 		<div class="col-xs-6">
					 		<h3 class="dash_title">클라우드 자원 생성 현황 </h3>
					 		<div class="height-444  bg-white p20">
					 	  		<div id="line-chart"></div>
							</div>
					 	</div>

					 	</div>





				</div>

				<div id="divCharts1" class="p-l-30 p-t-35"></div>
				<!-- end page-body -->

				<div id="footer" class="footer bgwh bt2-9e">
					 <p>(우) 58322 전라남도 나주시 전력로 55 Copyright ⓒ 2020  KEPCO.   All rights reserved.<br/>
               		가상서버 신청 관련 문의사항은 <br> 사용문의 -> Q&A 게시판에 등록 바랍니다.</p>
	            </div>
	            <!-- end #footer -->

			</div>
			<!-- end #content -->
		</div>

		<!-- end page container -->
		<c:import url="../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type='text/javascript' src="${contextPath}/resources/js/chart.js"></script>
		<script type="text/javascript">

		$(document).ready(function() {
			App.init();

			var Now = new Date();
			var NowTimeYyyy = Now.getFullYear();
			var NowTimeMm = Now.getMonth() + 1;
			$("#NowTimeYyyy").text(NowTimeYyyy+"년"+NowTimeMm+"월 매출현황");

			if($("#loginFlag").val()!="Y"){
			$("#dashboard").addClass("active");
			}
		});

		function getCharts2(){
			<c:forEach items="${mngCustomerAmount6month}" var="mngCustomerAmount6month" varStatus="status" >
    			var month<c:out value="${status.index}"></c:out> = <c:out value="${mngCustomerAmount6month.billYyyymm.substring(4,6)}"></c:out>;
				var amt<c:out value="${status.index}"></c:out> = <c:out value="${mngCustomerAmount6month.totAmount}"></c:out>;
			</c:forEach>
			Highcharts.chart('cpuChart', {
				chart: {
					type: 'column'
				},
				title: {
					text:  null
				},
				xAxis: {
					categories: [<c:forEach items="${cpuTopX}" var="item" varStatus="X" ><c:if test="${X.index < 5}">'${item.hostname}'${X.last==true? '' : ',' }</c:if></c:forEach>],
					crosshair: true
				},
				yAxis: {
					min: 0,
					max: 100,
					title: {text: ''}
				},
				credits : {
					enabled : false		//highchart 로고 제거
				},
				legend : {
					enabled : false
				},
				tooltip: {
			        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
			        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' + '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
			        footerFormat: '</table>',
			        shared: true,
			        useHTML: false
				},
				plotOptions: {
					column: {
						pointPadding: 0.2,
  						borderWidth: 0
						}
				},
				series: [
					{data: [<c:forEach items="${cpuTopX}" var="item" varStatus="X" ><c:if test="${X.index < 5}">${item.cpuUsedPct}${X.last==true? '' : ',' }</c:if></c:forEach>]}
				]
			});

			Highcharts.chart('memChart', {
				chart: {
					type: 'column'
			    },
			   title: {
			    //  text: 'Monthly Average Rainfall'
			   text:  null

			    },
			    subtitle: {
			    // text: 'Source: WorldClimate.com'

			    },

			    xAxis: {
			        categories: [<c:forEach items="${memTopX}" var="item" varStatus="X" ><c:if test="${X.index < 5}">'${item.hostname}'${X.last==true? '' : ',' }</c:if></c:forEach>],
			        crosshair: true
			    },
			    yAxis: {
			        min: 0,
			        max: 100,
			        title: {
			            text: ''
			        }
			    },
				 credits : {
							enabled : false		//highchart 로고 제거
				},

				legend : {
					enabled : false
				},
			    tooltip: {
			        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
			        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
			            '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
			        footerFormat: '</table>',
			        shared: true,
			        useHTML: false
			    },
			    colors:[
			    	'#185380'
			    ],
			   plotOptions: {
			       column: {
			         pointPadding: 0.2,
			         borderWidth: 0
			      }
			    },
			    series: [
			    	{data: [<c:forEach items="${memTopX}" var="item" varStatus="X" ><c:if test="${X.index < 5}">${item.memUsedPct}${X.last==true? '' : ',' }</c:if></c:forEach>]}
			    ]
			});

			Highcharts.chart('line-chart', {
			    title: {text: null},
			    subtitle: {text: null},

			    yAxis: {
			        title: {
			            text:null
			        }
			    },
			    credits : {
							enabled : false		//highchart 로고 제거
				},

				chart:{
					backgroundColor: '#fff'
				},

			    legend: {
			        enabled : false
					// layout: 'vertical',
			       // align: 'right',
			       //  verticalAlign: 'middle'
			    },

			  /*  plotOptions: {
			        series: {
			            label: {
			                connectorAllowed: false
			            },
			            pointStart: 2010
			        }
			    }, */

				 xAxis:{
					categories: [<c:forEach items="${monthVm}" var="monthVm" varStatus="X" ><c:if test="${X.index < 5}">'${monthVm.regMonth}'${X.last==true? '' : ',' }</c:if></c:forEach>]

				 },

				    colors:[
				    	'#185380'
				    ],

			    plotOptions: {
			        series: {
			            marker: {
			               enabled:true
			            },
			        },
			        line: {
			        	dataLabels: {
			        		enabled: true
			        	}
			        }
			    },


			    series: [{
			        name: '생성 가상서버 : ',
			        data: [<c:forEach items="${monthVm}" var="monthVm" varStatus="X" ><c:if test="${X.index < 5}">${monthVm.totAmount}${X.last==true? '' : ',' }</c:if></c:forEach>]

			    }],

			    responsive: {
			        rules: [{
			            condition: {
			                maxWidth: 500
			            },
			            chartOptions: {
			                legend: {
			                    layout: 'horizontal',
			                    align: 'center',
			                    verticalAlign: 'bottom'
			                }
			            }
			        }]
			    }

			});

			}


				//링크 모음 시작

				// 프로젝트 승인 페이지 이동
				function projectApproveLink(){
					location.href = "${contextPath}/mng/req/project/workApprovalProject/";
				}
				// 자원 승인 페이지 이동
				function productApproveLink(){
					location.href = "${contextPath}/mng/req/product/";
				}
				// 사용자 승인 페이지 이동
				function userApproveLink(){
					location.href = "${contextPath}/mng/req/user/userApproval";
				}
				// 작업 승인 페이지 이동
				function myWorkLink(){
					location.href = "${contextPath}/mng/req/work/";
				}
				// 프로젝트 승인 페이지 이동
				function projectAllApproveLink(){
					location.href = "${contextPath}/mng/req/project/workApprovalProject/?myWorkYn=N";
				}
				// 자원 승인 페이지 이동
				function productAllApproveLink(){
					location.href = "${contextPath}/mng/req/product/?myWorkYn=N";
				}
				// 작업 승인 페이지 이동
				function workAllApproveLink(){
					location.href = "${contextPath}/mng/req/work/?myWorkYn=N";
				}

				// 프로젝트 기본정보 관리 이동
				function projectInfoLink(){
					location.href = "${contextPath}/mng/project/info/";
				}// 가상서버 관리 이동
				function projectVmLink(){
					location.href = "${contextPath}/mng/productUsageStatus/vm/";
				}// 블록디스크 관리 이동
				function projectDiskLink(){
					location.href = "${contextPath}/mng/productUsageStatus/disk/";
				}// 서비스 자원 관리 이동
				function projectServiceLink(){
					location.href = "${contextPath}/mng/productUsageStatus/service/";
				}
				function qnaLink(){
					location.href = "${contextPath}/mng/bbs/qna/";
				}


				//링크 모음 끝




		</script>

	</body>
</html>