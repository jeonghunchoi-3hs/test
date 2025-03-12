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
				<!-- begin #content -> header -->
				<div class="page_header mb30">
					<h1>실시간 성능 분석</h1>
					<div class="pageNav">
						<a href="#" class="home"><i></i></a><a href="#">모니터링</a><a href="#" class="on">실시간 성능 분석</a>
					</div>
				</div>
				<!-- begin #content page-body -->
				<div class="row p20 bgwh br10">
					<div class="viewbox">
				    	<span class="pid">${vmDetailInfo.projectName}</span> <h3 class="pname dpin ml50">${vmDetailInfo.projectAlias} </h3>
				 		<div class="clear"></div>
					 	<div class="mt10">
					 	<span class="dpin fb">회원사  : </span><span>${vmDetailInfo.customerName}</span>  <span class="dpin fb ml40">담당조직(부서) : </span><span> ${vmDetailInfo.deptName} </span> <span class="dpin fb ml40">담당자 : </span><span> ${vmDetailInfo.userName} (${vmDetailInfo.userTel})</span>
					 	</div>
				 	   <hr class="dashline"></hr>
				 	    <ul class="server_info pl20">
				 	    <li class="width-80 vat"><i class="fa fa-server f60 fc99"></i></li>
				 	    <li class="vat">
				 	    	<h3 class="f18 fb mt0">${vmDetailInfo.hostnameAlias} <span class="bg_dgreen p414 br5 ml30 fw f14">${vmDetailInfo.hostname}</span> </h3>
				 	        <p class="mt20"><span>IP주소 : <c:forEach items="${vmDetailInfo.fixedIps}" var="fixedIps" varStatus="X" >${fixedIps} ${X.last==true? '' : ',' }  </c:forEach></span> <span class="ml50"> 생성일시 : ${vmDetailInfo.createDatetime}</span></p>
				 	    </li>
				 	    <li>
				 	         <ul class="server_detail pl50">
				 	           <li><p class="cpuArea">${vmDetailInfo.vcpus}</p><p class="titleA">vCPU <span>(Core)</span></p></li>
				 	           <li><p class="memoryArea">${vmDetailInfo.memGb}</p><p class="titleA">MEMORY <span>(GB)</span></p></li>
				 	           <li><p class="diskArea">${vmDetailInfo.diskGb}</p><p class="titleA">OS DISK<span>(GB)</span></p></li>
				 	           <li><p class="block">${vmDetailInfo.sizeGb}</p><p class="titleA">Block DISK<span>(GB)</span></p></li>
				 	         </ul>
				 	    </li>
				 	    </ul>
				    </div>

					<div class="col-xs-12 mt20">
					    <div class="col-xs-6">
					        <h3 class="f18 tac mb10">CPU</h3>
					        <div class="panel panel-default">
					            <div class="panel-body">
					                <div id="divCpuChart" style="width:100%; height:300px;"></div>
					            </div>
					        </div>
					    </div>
					    <div class="col-xs-6">
					        <h3 class="f18 tac mb10">Memory</h3>
					        <div class="panel panel-default">
					            <div class="panel-body">
					                <div id="divMemChart" style="width:100%; height:300px;"></div>
					            </div>
					        </div>
					    </div>
					</div>

					<div class="col-xs-12 mt20">
					    <div class="col-xs-6">
					        <h3 class="f18 tac mb10">Disk</h3>
					        <div class="panel panel-default">
					            <div class="panel-body">
					                <div id="divDiskChart" style="width:100%; height:300px;"></div>
					            </div>
					        </div>
					    </div>
					    <div class="col-xs-6">
					        <h3 class="f18 tac mb10">Network</h3>
					        <div class="panel panel-default">
					            <div class="panel-body">
					                <div id="divNetChart" style="width:100%; height:300px;"></div>
					            </div>
					        </div>
					    </div>
					</div>

					<div class="clear"></div>
					<div class="btn_area">
						<a type='button' class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
				   </div>
				</div>
				<!---- end page body---->

				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
			<!-- end #content -->
		</div>
		<!---- end #page-container---->


		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

		<script type="text/javascript">
		$(document).ready(function() {
	        App.init();
			$("#monitoring").addClass("active");
			$("#statusList").addClass("active");
			    getCpuChart();
			    getMemChart();
			    getDiskChart();
			    getNetworkChart();

			});

		function validateSeriesData(data) {
		    return data && Array.isArray(data) && data.every(item => !isNaN(parseFloat(item)) && isFinite(item));
		}

		function getCpuChart() {
		    var cpuData = JSON.parse('${cpuList}');

		    var seriesData = cpuData.data.map(function(item) {
		        return parseFloat(item.usedpct) || 0;
		    });

		    if (validateSeriesData(seriesData)) {
		        $("#divCpuChart").highcharts({
		            chart: {
		                type: 'line',
		                height: 300
		            },
		            title: {
		                text: null
		            },
		            xAxis: {
		                categories: cpuData.data.map(function(item) {
		                    return item.cpuDateTime;
		                })
		            },
		            yAxis: {
		                title: {
		                    text: 'Usage (%)'
		                },
		                min: 0,
		                max: 100
		            },
		            series: [{
		                name: 'CPU Usage',
		                data: seriesData
		            }]
		        });
		    }
		}

		function getMemChart() {
		    var memData = JSON.parse('${memList}');

		    var seriesData = memData.data.map(function(item) {
		        return parseFloat(item.rmemusedpct) || 0;
		    });

		    if (validateSeriesData(seriesData)) {
		        $("#divMemChart").highcharts({
		            chart: {
		                type: 'line',
		                height: 300
		            },
		            title: {
		                text: null
		            },
		            xAxis: {
		                categories: memData.data.map(function(item) {
		                    return item.memDateTime;
		                })
		            },
		            yAxis: {
		                title: {
		                    text: 'Usage (%)'
		                },
		                min: 0,
		                max: 100
		            },
		            series: [{
		                name: 'Memory Usage',
		                data: seriesData
		            }]
		        });
		    }
		}

		function getDiskChart() {
		    var diskData = JSON.parse('${dskList}');
		    var seriesData = diskData.data.map(function(item) {
		        return parseFloat(item.fsusepct) || 0;
		    });

		    if (validateSeriesData(seriesData)) {
		        $("#divDiskChart").highcharts({
		            chart: {
		                type: 'line',
		                height: 300
		            },
		            title: {
		                text: null
		            },
		            xAxis: {
		                categories: diskData.data.map(function(item) {
		                    return item.diskDateTime;
		                })
		            },
		            yAxis: {
		                title: {
		                    text: 'Usage (%)'
		                },
		                min: 0,
		                max: 100
		            },
		            series: [{
		                name: 'Disk Usage',
		                data: seriesData
		            }]
		        });
		    }
		}

		function getNetworkChart() {
		    var netData = JSON.parse('${netList}');

		    var receivedData = netData.data.map(function(item) {
		        return parseFloat((item.rxkb / 1024).toFixed(2)) || 0;
		    });

		    var sentData = netData.data.map(function(item) {
		        return parseFloat((item.txkb / 1024).toFixed(2)) || 0;
		    });

		    if (validateSeriesData(receivedData) && validateSeriesData(sentData)) {
		        $("#divNetChart").highcharts({
		            chart: {
		                type: 'line',
		                height: 300
		            },
		            title: {
		                text: null
		            },
		            xAxis: {
		                categories: netData.data.map(function(item) {
		                    return item.netDateTime;
		                })
		            },
		            yAxis: {
		                title: {
		                    text: 'Usage (MB)'
		                },
		                min: 0,
		                max: 100
		            },
		            series: [{
		                name: 'Received MB',
		                data: receivedData
		            }, {
		                name: 'Sent MB',
		                data: sentData
		            }]
		        });
		    }
		}

		function moveListPage(){
			location.href = "${contextPath}/mng/monitoring/status/";
		}
		</script>
	</body>
</html>
