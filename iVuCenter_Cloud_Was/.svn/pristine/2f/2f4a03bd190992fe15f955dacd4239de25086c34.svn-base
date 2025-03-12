<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer in">
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->

		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->


		<!-- begin #content -->
		<div id="content" class="content">
			<input type="hidden" id="projectName" name="projectName" value="cloud-010">
			<input type="hidden" id="deploymentConfigName" name="deploymentConfigName" value="httpd-example">

			<input type="hidden" id="cloudId" value="${cloudId}">
			<input type="hidden" id="projectId" value="${projectId}">
			<input type="hidden" id="appUuid" value="${appUuid}">

				<!-- begin #content > header -->
				<h1 class="page-header">
					<span class="root"><span class="home"></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow"><a>어플리케이션 </a></span><span class="text arrow mint"><a href="${wasPath}/mbr/application/req/"><strong>어플리케이션 이용현황 </strong></a></span></span>
				</h1>
				<!-- end header -->


			 <!-- begin #content > page-body -->
				 <div class="row mb50">
					<p class="page_title"><span class="stick">어</span>플리케이션 상세  </p>

				 <!-- 프로젝트 정보 & 현재 사용용량 시작 -->
					<div class="viewbox mb20 dpin">
					    <!-- 프로젝트 상세정보 -->
					    <p class="openshift"> 클라우드 <img src="${apachePath}/resources/assets/img/openshift_s.png"/> </p>
					    <span class="pid" id = "applicationProjectAlias"></span>
					 	<h3 class="pname dpin ml20" id = "applicationProjectName"></h3>


						<!-- 현재 사용 용량 -->

								<div class="col-lg-12 mt30 pl0 pr0">
	                                	<div class="col-lg-2 tac mt20">
	                                		<p class="pod_circle"><span id = "applicationPod"></span></p>

	                                	</div>
	                                	<div class="col-lg-10">
	                                		<table class="tableH">
					                  		<colgroup>
					                  			<col width="15%"/>
					                  			<col width="*"/>
					                  		</colgroup>
					                  		<tbody>
					                  			<tr>
					                  				<td class="bgf3 tar" > 어플리케이션 </td><td id="applicationTemplate"> </td>
					                  			</tr>
					                  			<tr>
					                  				<td class="bgf3 tar" > 이름</td><td id="applicationName"></td>
					                  			</tr>
					                  			<tr>
					                  				<td class="bgf3 tar" > Label</td><td id="applicationLabel"></td>
					                  			</tr>
					                  			<tr>
					                  				<td class="bgf3 tar" > Status</td><td id="applicationStatus"></td>
					                  			</tr>
					                  			<tr>
					                  				<td class="bgf3 tar" > ScaleOut</td><td id="applicationScaleOut"></td>
					                  			</tr>
					                  			<tr>
					                  				<td class="bgf3 tar" > 생성 </td><td id="applicationRegDate"></td>
					                  			</tr>
					                  		</tbody>
					                  		</table>

	                                	</div>
			                       </div>
					</div>
					<!-- 프로젝트 정보 & 현재 사용용량 끝 -->

					<div class="col-lg-12 pl0 pr0">
						<!-- begin nav-pills-->
			             <ul class="nav nav-tabs">
			             <li class="active"><a href="#tabmenu_01" data-toggle="tab">Overview </a></li>
			             <li><a href="#tabmenu_02" data-toggle="tab">Pod</a></li>
			             <li><a href="#tabmenu_03" data-toggle="tab">빌드</a></li>
			             <li><a href="#tabmenu_04" data-toggle="tab">서비스</a></li>
                        </ul>
                        <!-- end nav-pills -->

                        <!-- begin tab-content -->
                        <div class="tab-content mt-2">
	                            <div class="tab-pane fade active in" id="tabmenu_01">
	                            	<div id="pods">
	                            	<!--<h4>Pods</h4>
	                            		<table class="tableAA" id="pods">
	                                		<colgroup>
	                                			<col width="*"/>
	                                			<col width="10%"/>
	                                			<col width="10%"/>
	                                		</colgroup>
	                                		<tbody>
	                                			<tr><td> <p class="icon_P">P</p> eap-app-1-jlrxh </td><td class="tac"> <span class="btn_run"><i class="fa fa-refresh"></i> Running</span></td><td class="tac">  <span class="btn_logs"><i class="fa fa-eye"></i>  Viewlogs</span></td></tr>
	                                		</tbody>
	                                	</table>
	                                	<table class="tableAA mt10">
	                                		<colgroup>
	                                			<col width="*"/>
	                                			<col width="10%"/>
	                                			<col width="10%"/>
	                                		</colgroup>
	                                		<tbody>
	                                			<tr><td><p class="icon_P">P</p>  eap-app-1-jlrxh </td><td class="tac"> <span class="btn_stop"><i class="fa fa-stop"></i> Stop </span></td><td class="tac">  <span class="btn_logs"><i class="fa fa-eye"></i> Viewlogs</span></td></tr>
	                                		</tbody>
	                                	</table>-->
	                            	</div>
			                        <div id="builds">
			                        </div>
			                                	<!-- <h4 class="mt20">Builds</h4>
			                                	<table class="tableBB">
			                                		<colgroup>
			                                			<col width="*"/>
			                                			<col width="10%"/>
			                                		</colgroup>
			                                		<tbody>
			                                			<tr><td><p class="icon_BC">BC</p> eap-app </td><td class="tac"><span class="btn_logs"><i class="fa fa-eye"></i> View logs</span></td></tr>
			                                			<tr><td> Build #1 is complete (an hour ago)</td><td class="tac"> </td></tr>
			                                		</tbody>
			                                	</table>-->
			                        <div id="services">
			                        </div>
			                        <!--
			                                	<h4 class="mt20">Services</h4>
			                                	<table class="tableCC">
			                                		<colgroup>
			                                			<col width="*"/>
			                                		</colgroup>
			                                		<tbody>
			                                			<tr><td><p class="icon_S">S</p>  eap-app </td></tr>
			                                			<tr><td> Service port: TCP/8080  <i class="fa fa-arrow-right fc-red"></i> Pod Port:8080</td></tr>
			                                		</tbody>
			                                	</table>
			                                	<table class="tableCC mt10">
			                                		<colgroup>
			                                			<col width="*"/>
			                                		</colgroup>
			                                		<tbody>
			                                			<tr><td><p class="icon_S">S</p>  eap-app-ping </td></tr>
			                                			<tr><td> Service port: ping <i class="fa fa-arrow-right fc-red"></i>  Pod Port:8888</td></tr>
			                                		</tbody>
			                                	</table>
			                         -->
			                         <div id="routes">
			                         </div>
			                                	<!-- <h4 class="mt20">Routes</h4>
			                                	<table class="tableDD">
			                                		<colgroup>
			                                			<col width="*"/>
			                                		</colgroup>
			                                		<tbody>
			                                			<tr><td><p class="icon_RT">RT</p>  eap-app </td></tr>
			                                			<tr><td> Location  <a href="https://eap-app-3hs-test.apps.ocp.3hs.com" target="_blank">https://eap-app-3hs-test.apps.ocp.3hs.com <i class="fa fa-external-link"></i></a></td></tr>
			                                		</tbody>
			                                	</table>-->
			                            </div>


			                            <div class="tab-pane fade" id="tabmenu_02">
			                            	<div class="w100" id="podDetailList">
				                          <%--   	<div class="w48 dpin">
				                            		<table class="tableSH">
				                                		<colgroup>
				                                			<col width="40%"/>
				                                			<col width="*"/>
				                                		</colgroup>
				                                		<tbody>
				                                			<tr><th colspan="2">POD 정보 	<a href="#modal-pod" data-toggle="modal" class="ml20"><span class="cbton bton_lblue"><i class="fa fa-search"></i></span></a></th></tr>
				                                			<tr><td class="point">Name </td><td> jboss-2-xpntm </td></tr>
				                                			<tr><td class="point">상태 </td><td> Running </td></tr>
				                                			<tr><td class="point">Container Ready </td><td> 1/1</td></tr>
				                                			<tr><td class="point">Container Restarts </td><td> 0</td></tr>
				                                			<tr><td class="point">기간  </td><td> 3Hours</td></tr>
				                                		</tbody>
				                                	</table>
				                            	</div> --%>
				                     <%--        	<div class="w48 flr">
				                            		<table class="tableSH">
				                                		<colgroup>
				                                			<col width="40%"/>
				                                			<col width="*"/>
				                                		</colgroup>
				                                		<tbody>
				                                			<tr><th colspan="2">POD 정보 	<a href="#modal-pod" data-toggle="modal" class="ml20"><span class="cbton bton_lblue"><i class="fa fa-search"></i></span></a></th></tr>
				                                			<tr><td class="point">Name </td><td> jboss-2-abcde </td></tr>
				                                			<tr><td class="point">상태 </td><td> Running </td></tr>
				                                			<tr><td class="point">Container Ready </td><td> 1/1</td></tr>
				                                			<tr><td class="point">Container Restarts </td><td> 0</td></tr>
				                                			<tr><td class="point">기간  </td><td> 24Hours</td></tr>
				                                		</tbody>
				                                	</table>
				                            	</div> --%>
			                            	</div>
			                            </div>
			                            <div class="tab-pane fade" id="tabmenu_03">
			                            	<div class="w100" id="buildDetailList">
			                         	<%-- <div class="w48 dpin">
			                            		<table class="tableSH">
			                                		<colgroup>
			                                			<col width="30%"/>
			                                			<col width="*"/>
			                                		</colgroup>
			                                		<tbody>
			                                			<tr><th colspan="2"><p class="icon_BC">BC</p>  빌드 	<a href="#modal-build" data-toggle="modal" class="ml20"><span class="cbton bton_lblue"><i class="fa fa-search"></i></span></a></th></tr>
			                                			<tr><td class="point">Name </td><td> jboss-2-xpntm </td></tr>
			                                			<tr><td class="point">빌드 </td><td> eap-app-1 </td></tr>
			                                			<tr><td class="point">Status </td><td> Complete</td></tr>
			                                			<tr><td class="point">Type </td><td> Source</td></tr>
			                                		</tbody>
			                                	</table>
			                            	</div>
			                           	<div class="w48 flr">
			                            		<table class="tableSH">
			                                		<colgroup>
			                                			<col width="30%"/>
			                                			<col width="*"/>
			                                		</colgroup>
			                                		<tbody>
			                                			<tr><th colspan="2"><p class="icon_BC">BC</p>  빌드 	<a href="#modal-build" data-toggle="modal" class="ml20"><span class="cbton bton_lblue"><i class="fa fa-search"></i></span></a></th></tr>
			                                			<tr><td class="point">Name </td><td> jboss-2-xpntm </td></tr>
			                                			<tr><td class="point">빌드 </td><td> eap-app-1 </td></tr>
			                                			<tr><td class="point">Status </td><td> Complete</td></tr>
			                                			<tr><td class="point">Type </td><td> Source</td></tr>
			                                		</tbody>
			                                	</table>
			                            	</div> --%>
			                             </div>

			                            </div>
			                             <div class="tab-pane fade" id="tabmenu_04">
			                            	<div class="w100" id = "servicesDetailList">
			                            	<div class="w48 dpin">
			                            		<table class="tableSH">
			                                		<colgroup>
			                                			<col width="30%"/>
			                                			<col width="*"/>
			                                		</colgroup>
			                                		<tbody>
			                                			<tr><th colspan="2"><p class="icon_S">S</p>  서비스	</th></tr>
			                                			<tr><td class="point">Name </td><td> eap-app </td></tr>
			                                			<tr><td class="point">Address </td><td> 172.30.16.18 </td></tr>
			                                			<tr><td class="point">서비스포트  </td><td> 8080</td></tr>
			                                			<tr><td class="point">Pod포트 </td><td> 8080</td></tr>
			                                		</tbody>
			                                	</table>
			                            	</div>
			                            	<div class="w48 flr">
			                            		<table class="tableSH">
			                                		<colgroup>
			                                			<col width="30%"/>
			                                			<col width="*"/>
			                                		</colgroup>
			                                		<tbody>
			                                			<tr><th colspan="2"><p class="icon_RT">RT</p>  라우트 </th></tr>
			                                			<tr><td class="point">Name </td><td> eap-app</td></tr>
			                                			<tr><td class="point">Status </td><td> Accepted </td></tr>
			                                			<tr><td class="point">Hostname </td><td> apps.ocp.3hs.com</td></tr>
			                                			<tr><td class="point">Url </td><td>  <a href="https://eap-app-3hs-test.apps.ocp.3hs.com" target="_blank">https://eap-app-3hs-test.apps.ocp.3hs.com <i class="fa fa-external-link"></i></a></td></tr>
			                                		</tbody>
			                                	</table>
			                            	</div>
			                               </div>
			                               <div class="w100 mt10">
			                            	<div class="w48 dpin">
			                            		<table class="tableSH">
			                                		<colgroup>
			                                			<col width="30%"/>
			                                			<col width="*"/>
			                                		</colgroup>
			                                		<tbody>
			                                			<tr><th colspan="2"><p class="icon_S">S</p> 서비스 </th></tr>
			                                			<tr><td class="point">Name </td><td> eap-app </td></tr>
			                                			<tr><td class="point">Address </td><td> 172.30.16.18 </td></tr>
			                                			<tr><td class="point">서비스포트  </td><td> 8080</td></tr>
			                                			<tr><td class="point">Pod포트 </td><td> 8080</td></tr>
			                                		</tbody>
			                                	</table>
			                            	</div>
			                            	<div class="w48 flr">

			                            	</div>
			                               </div>

			                            </div>

			                        </div>



								 </div>



				<!---- end page body---->
	            </div>

				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
			<!-- end #content -->

		<!-- end page container -->
	</div>

		<!-- #modal-dialog pod  -->
                            <div class="modal fade" id="modal-pod">
                                <div class="modal-dialog">
                                    <div class="modal-content width-800">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                            <h4 class="modal-title">Pod 정보  </h4>
                                        </div>
                                        <div class="modal-body">
                                        	<table class="tableH">
							                  		<colgroup>
							                  			<col width="30%"/>
							                  			<col width="*"/>
							                  		</colgroup>
							                  		<tbody>
							                  			<tr>
							                  				<td> 이름</td><td>eap-app-1-jlrxh</td>
							                  			</tr>
							                  			<tr>
							                  				<td>IP</td><td>10.129.2.117</td>
							                  			</tr>
							                  			<tr>
							                  				<td> Node</td><td>Worker1.ocp.3hs.com</td>
							                  			</tr>
							                  			<tr>
							                  				<td> Restart Policy </td><td>Always Restart</td>
							                  			</tr>
							                  			<tr>
							                  				<td> Status </td><td>Running</td>
							                  			</tr>
							                  		</tbody>
							                 </table>
							              <div class="w100 mt10">
			                            	<div class="w48 dpin fl">
			                            	    <h4 class="tal mb10"> ⊙ 컨테이너 </h4>
			                            		<table class="tableSHM">
			                                		<colgroup>
			                                			<col width="30%"/>
			                                			<col width="*"/>
			                                		</colgroup>
			                                		<tbody>
			                                			<tr><th>Name </th><td> eap-app </td></tr>
			                                			<tr><th>상태 </th><td> Running</td></tr>
			                                			<tr><th>Restart  </th><td> 0</td></tr>
			                                			<tr><th>Started </th><td>2020-07-30 10:29</td></tr>
			                                			<tr><th>Finished </th><td></td></tr>
			                                			<tr><th>이미지 </th><td>image-registry.openshift</td></tr>
			                                		</tbody>
			                                	</table>
			                            	</div>
			                            	<div class="w48 flr">
			                            	    <h4 class="tal mb10"> ⊙ Volumes </h4>
			                            		<table class="tableSHM">
			                                		<colgroup>
			                                			<col width="30%"/>
			                                			<col width="*"/>
			                                		</colgroup>
			                                		<tbody>

			                                			<tr><th>Name </th><td> Defaut-token</td></tr>
			                                			<tr><th>Mount </th><td> /var/run/servicecc </td></tr>
			                                			<tr><th>Type </th><td> default-token</td></tr>
			                                			<tr><th>Permission </th><td>  Read-only</td></tr>
			                                			<tr><th>Utilized By </th><td>  eap-app</td></tr>
			                                			<tr><th>&nbsp; </th><td> </td></tr>
			                                		</tbody>
			                                	</table>
			                            	</div>
			                               </div>
											<div class="clear"></div>
			                                <div class="w100 mt10 mb10">
			                            	<div class="w48 dpin fl">
												    <div id="divMemChart"></div>
			                            	</div>
			                            	<div class="w48 flr">
			                            		 <div id="divCpuChart"></div>
			                            	</div>
			                               </div>

                                        </div>

                                        <div class="modal-footer tac">
                                            <a type=button class="lbtn" data-dismiss="modal">확인</a>
		             						<a href="javascript:;" type=button class="rbtn" data-dismiss="modal">취소</a>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <!-- #modal-dialog build  -->
                            <div class="modal fade" id="modal-build">
                                <div class="modal-dialog">
                                    <div class="modal-content width-800">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                            <h4 class="modal-title">Build 정보  </h4>
                                        </div>
                                        <div class="modal-body">
                                        	<table class="tableH">
							                  		<colgroup>
							                  			<col width="30%"/>
							                  			<col width="*"/>
							                  		</colgroup>
							                  		<tbody>
							                  			<tr>
							                  				<td> 이름</td><td>eap-app-1-jlrxh</td>
							                  			</tr>
							                  			<tr>
							                  				<td>Git Repo</td><td>http://192.168.70.144/root/jboss-sample-app.git</td>
							                  			</tr>
							                  			<tr>
							                  				<td> Git Commit </td><td>Logo changed</td>
							                  			</tr>
							                  			<tr>
							                  				<td> Startecd </td><td>2020-06-30 10:17 AM</td>
							                  			</tr>
							                  			<tr>
							                  				<td> Status </td><td>Complete</td>
							                  			</tr>
							                  		</tbody>
							                 </table>
							              <div class="log mt10">
			                              </div>
                                        </div>

                                        <div class="modal-footer tac">
                                            <a type=button class="lbtn" data-dismiss="modal">확인</a>
		             						<a href="javascript:;" type=button class="rbtn" data-dismiss="modal">취소</a>
                                        </div>
                                    </div>
                                </div>
                            </div>






<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	$(document).ready(function() {
		App.init();
		//메뉴활성화
		getPodList();
		getBuildList();
		getServiceList();
		getRouteList();
		getProjectAppInfo();
		$("#myGoods").addClass("active");
		$("#managementApp").addClass("active");
	});

	//Chart
	Highcharts.chart('divMemChart', {
	    title: {
	        text: 'MEM'
	    },
	    xAxis: {
	        accessibility: {
	            rangeDescription: 'Range: 2010 to 2017'
	        }
	    },
	    legend: {
	        layout: 'vertical',
	        align: 'center',
	        verticalAlign: 'bottom'
	    },
	    plotOptions: {
	        series: {
	            label: {
	                connectorAllowed: false
	            },
	            pointStart: 2010
	        }
	    },

	    series: [{
	        name: 'Installation',
	        data: [43934, 52503, 10523, 69658, 97031, 32552, 137133, 154175]

	    }],
	     credits: {
         enabled: false
         },

	    responsive: {
	        rules: [{
	            condition: {
	                maxWidth: 480
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

	Highcharts.chart('divCpuChart', {

	    title: {
	        text: 'CPU'
	    },

	    xAxis: {
	        accessibility: {
	            rangeDescription: 'Range: 2010 to 2017'
	        }
	    },

	    legend: {
	        layout: 'vertical',
	        align: 'center',
	        verticalAlign: 'bottom'
	    },

	    plotOptions: {
	        series: {
	            label: {
	                connectorAllowed: false
	            },
	            pointStart: 2010
	        }
	    },

	    series: [{
	        name: 'Installation',
	        data: [12345, 52003, 30523, 49658, 27031, 32552, 507133, 54175]

	    }],
	     credits: {
        enabled: false
         },

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

	//PodList 정보
	function getPodList() {
		$.ajax({
			url : "${contextPath}/mbr/application/req/getPodList",
			type : "GET",
			dataType : "JSON",
			data : {
				 projectId : $("#projectId").val()
				,cloudId : $("#cloudId").val()
				,appUuid : $("#appUuid").val()
			},
			success : function(data) {
				var podList = "";
				var podDetailList = "";
				var now = new Date();
				$.each(data.items,function(k,v){
					if (k === 0) {
						podList += "<h4>Pods</h4>";
				    }
					if (k === 0) {
						podList += "<table class='tableAA'>";
					} else {
						podList += "<table class='tableAA mt10'>";
					}
					podList += "<colgroup><col width='*' /><col width='10%' /><col width='10%' />";
					podList += "<tr>";
					podList += "<td><p class='icon_P'>P</p> " +v.metadata.name+"</td>";
					podList += "<td class='tac'><span class='btn_run'>";
					if(v.status.phase == "Running"){
						podList += "<i class='fa fa-refresh'></i> Running</span></td>";
					}
					podList += "<td class='tac'><span class='btn_logs'><i class='fa fa-eye'></i> Viewlogs</span></td>";
					podList += "<tr>";



					podDetailList += "<div class='w48 dpin'>";
					podDetailList += "<table class='tableSH'>";
					podDetailList += "	<colgroup>";
					podDetailList += "		<col width='40%''/>";
					podDetailList += "		<col width='*'/>";
					podDetailList += "	</colgroup>";
					podDetailList += "	<tbody>";
					podDetailList += "		<tr><th colspan='2'>POD 정보 	<a href='#' data-toggle='modal' class='ml20'><span class='cbton bton_lblue'><i class='fa fa-search'></i></span></a></th></tr>";
					//podDetailList += "		<tr><th colspan='2'>POD 정보 	<a href='#modal-pod' data-toggle='modal' class='ml20'><span class='cbton bton_lblue'><i class='fa fa-search'></i></span></a></th></tr>";
					podDetailList += "		<tr><td class='point'>Name </td><td>" +v.metadata.name+"</td></tr>";

					if(v.status.reason == undefined){
					    podDetailList += "		<tr><td class='point'>상태 </td><td></td></tr>";
					}else{
						podDetailList += "		<tr><td class='point'>상태 </td><td>" +v.status.reason+"</td></tr>";
					}

				/* 	podDetailList += "		<tr><td class='point'>Container Ready </td><td>" +v.metadata.name+"</td></tr>";
					podDetailList += "		<tr><td class='point'>Container Restarts </td><td>" +v.metadata.name+"</td></tr>"; */


					if(v.status.startTime == undefined) {
						podDetailList += "		<tr><td class='point'>기간  </td><td></td></tr>";
					}else{
					    podDetailList += "		<tr><td class='point'>기간  </td><td>" +v.status.startTime.slice(0,10)+" ~ " +      now.format('yyyy-MM-dd')   +"</td></tr>";
					}

					podDetailList += "	</tbody>";
					podDetailList += "</table>";
					podDetailList += "</div>";


				})
				$("#pods").html(podList);
				$("#podDetailList").html(podDetailList);
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	//BuildList 정보
	function getBuildList() {
		$.ajax({
			url : "${contextPath}/mbr/application/req/getBuildList",
			type : "GET",
			dataType : "JSON",
			data : {
				projectId : $("#projectId").val()
				,cloudId : $("#cloudId").val()
				,appUuid : $("#appUuid").val()
			},
			success : function(data) {
				var buildList = "";
				var buildDetailList = "";



				$.each(data.items,function(k,v){
					if (k === 0) {
						buildList += "<h4 class='mt20'>Builds</h4>";
				    }
					if (k === 0) {
						buildList += "<table class='tableBB'>";
					} else {
						buildList += "<table class='tableBB mt10'>";
					}
					buildList += "<table class='tableBB'>";
					buildList += "<colgroup><col width='*' /><col width='10%' />";
					buildList += "<tr>";
					buildList += "<td><p class='icon_BC'>BC</p> " +v.metadata.name+"</td>";
					buildList += "<td class='tac'><span class='btn_logs'><i class='fa fa-eye'></i> Viewlogs</span></td>";
					buildList += "</tr>";

				 	buildDetailList += "<div class='w48 dpin'>";
					buildDetailList += "<table class='tableSH'>";
					buildDetailList += "<colgroup>";
					buildDetailList += "<col width='30%'/>";
					buildDetailList += "<col width='*'/>";
					buildDetailList += "</colgroup>";
					buildDetailList += "<tbody>";
					//buildDetailList += "<tr><th colspan='2'><p class='icon_BC'>BC</p>  빌드 	<a href='#' data-toggle='modal' class='ml20'><span class='cbton bton_lblue'><i class='fa fa-search'></i></span></a></th></tr>";
					buildDetailList += "<tr><th colspan='2'><p class='icon_BC'>BC</p>  빌드 	<a href='#modal-build' data-toggle='modal' class='ml20'><span class='cbton bton_lblue'><i class='fa fa-search'></i></span></a></th></tr>";
					buildDetailList += "<tr><td class='point'>Name </td><td>"+v.metadata.namespace+"</td></tr>";
					buildDetailList += "<tr><td class='point'>빌드 </td><td>"+v.metadata.name+"</td></tr>";
					buildDetailList += "<tr><td class='point'>Status </td><td>"+v.status.phase+"</td></tr>";


					$.each(v.spec.strategy,function(k2,v2){

						if(k2 === "type"){
						buildDetailList += "<tr><td class='point'>Type </td><td>"+v2+"</td></tr>";
						}
					});

					buildDetailList += "</tbody>";
					buildDetailList += "</table>";
					buildDetailList += "</div>";

				})
				$("#builds").html(buildList);
 				$("#buildDetailList").html(buildDetailList);
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	//ServiceList 정보
	function getServiceList() {
		$.ajax({
			url : "${contextPath}/mbr/application/req/getServiceList",
			type : "GET",
			dataType : "JSON",
			data : {
				projectId : $("#projectId").val()
				,cloudId : $("#cloudId").val()
				,appUuid : $("#appUuid").val()
			},
			success : function(data) {
				var html = "";
				var servicesDetailList = "";
				$.each(data.items,function(k,v){
				/* 	if(v.metadata.name == 'jenkins23'){ */
						if (k === 0) {
							html += "<h4 class='mt20'>Services</h4>";
					    }
						if (k === 0) {
							html += "<table class='tableCC'>";
						} else {
							html += "<table class='tableCC mt10'>";
						}
						html += "<colgroup><col width='*' />";
						html += "<tr>";
						html += "<td><p class='icon_S'>S</p> " +v.metadata.name+"</td>";
						html += "</tr>";
						$.each(v.spec.ports,function(k2,v2){

							html += "<tr>";
							html += "<td>Service port: "+v2.protocol+" / "+v2.port+" <i class='fa fa-arrow-right fc-red'></i> Pod Port:"+v2.targetPort+"</td>";
							html += "</tr>";
						});


						servicesDetailList += "<div class='w48 dpin'>";
						servicesDetailList += "<table class='tableSH'>";
						servicesDetailList += "	<colgroup>";
						servicesDetailList += "	<col width='30%'/>";
						servicesDetailList += "	<col width='*'/>";
						servicesDetailList += "	</colgroup>";
						servicesDetailList += "	<tbody>";
						servicesDetailList += "	<tr><th colspan='2'><p class='icon_S'>S</p>  서비스	</th></tr>";
						servicesDetailList += "	<tr><td class='point'>Name </td><td>"+v.metadata.name+"</td></tr>";
						servicesDetailList += "	<tr><td class='point'>Address </td><td>"+v.spec.clusterIP+"</td></tr>";
						$.each(v.spec.ports,function(k2,v2){
							servicesDetailList += "	<tr><td class='point'>서비스포트  </td><td>"+v2.port+"</tr>";
							servicesDetailList += "	<tr><td class='point'>Pod포트 </td><td>"+v2.targetPort+"</td></tr>";
						});

						servicesDetailList += "	</tbody>";
						servicesDetailList += "</table>";
						servicesDetailList += "</div>";

				})


				$("#services").html(html);
				$("#servicesDetailList").html(servicesDetailList);
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	//RouteList 정보
	function getRouteList() {
		$.ajax({
			url : "${contextPath}/mbr/application/req/getRouteList",
			type : "GET",
			dataType : "JSON",
			data : {
				projectId : $("#projectId").val()
				,cloudId : $("#cloudId").val()
				,appUuid : $("#appUuid").val()
			},
			success : function(data) {
				var html = "";
				$.each(data.items,function(k,v){
					if (k === 0) {
						html += "<h4 class='mt20'>Routes</h4>";
				    }
					if (k === 0) {
						html += "<table class='tableDD'>";
					} else {
						html += "<table class='tableDD mt10'>";
					}
					html += "<colgroup><col width='*' />";
					html += "<tr>";
					html += "<td><p class='icon_RT'>RT</p> " +v.metadata.name+"</td>";
					html += "</tr>";
					html += "<tr>";
					html += "<td> Location  <a href='https://"+v.spec.host+"' target='_blank'>"+v.spec.host+" <i class='fa fa-external-link'></i></a></td>";
					html += "</tr>";
				})
				$("#routes").html(html);
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		})
	}

	//RouteList 정보
	function getProjectAppInfo() {
		$.ajax({
			url : "${contextPath}/mbr/application/req/getProjectAppInfo",
			dataType : "JSON",
			type : "POST",
			data : {
				projectId : $("#projectId").val()
				,cloudId : $("#cloudId").val()
				,appUid : $("#appUuid").val()
			},
			success : function(data) {

				var result = data;
				$("#applicationTemplate").text(result.templateName)
				$("#applicationName").text(result.appName)
				$("#applicationLabel").text(result.label)
				$("#applicationStatus").text(result.status)
				$("#applicationRegDate").text(result.regDatetime)
				$("#applicationProjectName").text(result.projectName)
				$("#applicationProjectAlias").text(result.projectAlias)
				$("#applicationPod").text(result.pod)
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		})
	}


</script>

</body>
</html>
