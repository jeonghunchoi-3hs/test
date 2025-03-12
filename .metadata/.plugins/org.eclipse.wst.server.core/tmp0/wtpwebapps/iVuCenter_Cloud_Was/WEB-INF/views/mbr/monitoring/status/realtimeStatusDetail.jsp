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
			<!-- begin #page-container > header -->
			<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #page-container > header -->
			<!-- begin #page-container > sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #page-container > sidebar -->

			<!-- begin #page-container > content -->
			<div id="content" class="content">
				<p class="page_title">실시간 성능분석
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 모니터링  <span class="arrow_ab"> &#8227; </span> 실시간 성능분석  <span class="arrow_ab"> &#8227; </span> <b>실시간 성능분석 상세 </b>
			    </span>
			    </p>

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
				 	           <li><p class="CpuArea">${vmDetailInfo.vcpus}</p><p class="titleA">vCPU <span>(Core)</span></p></li>
				 	           <li><p class="MemoryArea">${vmDetailInfo.memGb}</p><p class="titleA">MEMORY <span>(GB)</span></p></li>
				 	           <li><p class="DiskArea">${vmDetailInfo.diskGb}</p><p class="titleA">OS DISK<span>(GB)</span></p></li>
				 	           <li><p class="Block">${vmDetailInfo.sizeGb}</p><p class="titleA">Block DISK<span>(GB)</span></p></li>
				 	         </ul>
				 	    </li>
				 	    </ul>
				    </div>

				    <div class="col-xs-12 mt20">
						<div class="col-xs-6">
							<h3 class="orderTitle tac mb10">CPU</h3>
				          	<div id="divCpuChart"></div>
				   	   	</div>
				   	   	<div class="col-xs-6">
							<h3 class="orderTitle tac mb10">Memory</h3>
				   	 	   	<div id="divMemChart"></div>
				   	   	</div>
				    </div>

					<div class="col-xs-12 mt20">
						<div class="col-xs-6">
							<h3 class="orderTitle tac mb10">Disk</h3>
							<div id="divDiskChart"></div>
						</div>
						<div class="col-xs-6">
							<h3 class="orderTitle tac mb10">Network</h3>
							<div id="divNetworkChart"></div>
						</div>
					</div>

					<div class="clear"></div>
					<div class="btn_area">
						<a href="#" type="button" class="m_btn_navy">목록</a>
				   </div>
				</div>
				<!---- end page body---->

				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->

		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript" src="${apachePath}/resources/highCharts/code/highcharts.js"></script>
		<script type="text/javascript" src="${apachePath}/resources/highCharts/code/modules/series-label.js"></script>
		<script type="text/javascript" src="${apachePath}/resources/highCharts/code/modules/exporting.js"></script>
		<script type="text/javascript" src="${apachePath}/resources/highCharts/code/modules/export-data.js"></script>
		<script type="text/javascript" src="${apachePath}/resources/highCharts/code/modules/accessibility.js"></script>
		<script type="text/javascript">
			// CPU Chart
			function getCpuChart(){

				$("#divCpuChart").highcharts({
					chart :{
						type: 'line'
						, height: 400
						, width: 750
					},
				    title: {
				        text: null
				    },
				    xAxis: {
				        categories: [<c:forEach items="${cpuUsageDatetime}" var="datetime" varStatus="X" >'${datetime}' ${X.last==true? '' : ',' }  </c:forEach>]

				    },
				    yAxis: {
				    	text : null
				    },
				    series: [
				    	{name : 'CPU_USAGE', data: [<c:forEach items="${cpuUsageValue}" var="value" varStatus="X" >${value} ${X.last==true? '' : ',' }  </c:forEach>]}
				    ],

				    responsive: {
				    	rules: [{
				    		condition: {
				    			maxWidth: 500
				    		}
				    	}]
				    }
				});
			}

			// MEM Chart
			function getMemChart(){
				$("#divMemChart").highcharts({
					chart :{
						type: 'line'
						, height: 400
						, width: 750
					},
				    title: {
				        text: null
				    },
				    xAxis: {
				        categories: [<c:forEach items="${memUsageDatetime}" var="datetime" varStatus="X" >'${datetime}' ${X.last==true? '' : ',' }  </c:forEach>]

				    },
				    yAxis: {
				    	min : 0,
				    	max : 100,
				    	text : null
				    },
				    series: [
				    	{name : 'MEM_USAGE', data: [<c:forEach items="${memUsageValue}" var="value" varStatus="X" >${value} ${X.last==true? '' : ',' }  </c:forEach>]}
				    ],

				    responsive: {
				    	rules: [{
				    		condition: {
				    			maxWidth: 500
				    		}
				    	}]
				    }
				});
			}

			// DISK Chart
			function getDiskChart(){
				$("#divDiskChart").highcharts({
					chart :{
						type: 'line'
						, height: 400
						, width: 750
					},
				    title: {
				        text: null
				    },
				    xAxis: {
				        categories: [<c:forEach items="${diskUsageDatetime}" var="datetime" varStatus="X" >'${datetime}' ${X.last==true? '' : ',' }  </c:forEach>]

				    },
				    yAxis: {
				    	min : 0,
				    	max : 100,
				    	text : null
				    },
				    series: [
				    	<c:forEach items="${fsNameValue}" var="fs" varStatus="X"  >
				    	{name : '${fs}', data: [<c:forEach items="${spaceUsageValue}" var="value" varStatus="X2" >${value} ${X2.last==true? '' : ',' }  </c:forEach> ]} ${X.last==true? '' : ',' }
				    	</c:forEach>
				    ],

				    responsive: {
				    	rules: [{
				    		condition: {
				    			maxWidth: 500
				    		}
				    	}]
				    }
				});
			}

			// NETWORK Chart
			function getNetworkChart(){
				$("#divNetworkChart").highcharts({
					chart :{
						type: 'line'
						, height: 400
						, width: 750
					},
				    title: {
				        text: null
				    },
				    xAxis: {
				        categories: [<c:forEach items="${networkUsageDatetime}" var="datetime" varStatus="X" >'${datetime}' ${X.last==true? '' : ',' }  </c:forEach>]

				    },
				    yAxis: {
				    	min : 0,
				    	max : 100,
				    	title: {
				            text:null
				        }
				    },
				    series: [
				    	{name : 'SENT_MB', data: [<c:forEach items="${sendUsageValue}" var="value" varStatus="X" >${value} ${X.last==true? '' : ',' }  </c:forEach>]},
				    	{name : 'RECIVED_MB', data: [<c:forEach items="${reciveUsageValue}" var="value" varStatus="X" >${value} ${X.last==true? '' : ',' }  </c:forEach>]}
				    ],

				    responsive: {
				    	rules: [{
				    		condition: {
				    			maxWidth: 500
				    		}
				    	}]
				    }
				});
			}

			$(document).ready(function() {
				App.init();
				getCpuChart();
				getMemChart();
				getDiskChart();
				getNetworkChart();

				//메뉴활성화
				$("#monitoring").addClass("active");
				$("#statusList").addClass("active");
			});
		</script>
	</body>
</html>
