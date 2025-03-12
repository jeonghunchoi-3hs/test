<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="ko" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="ko">
<!--<![endif]-->
<head>
	<meta charset="utf-8" />
	<title>NH(user) Cloudportal System</title>
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
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
			<h1 class="page-header"> <i class="fa fa-dashboard fcb"> </i> 사용현황 <span class="root"> 포털 > 모니터링 > 사용현황</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row mb50">
			
				<!-- 테이블시작 -->
				<div class="col-md-12">
					<div id="divCharts1"></div>
				</div>
				<!-- 테이블 끝 -->
				
				<!-- 테이블시작 -->
				<div class="col-md-12">
					<div id="divCharts2"></div>
				</div>
				<!-- 테이블 끝 -->
				
				
			    <!-- begin button-->
				<div class="col-md-12 tac mt20">
					<input type="button" class="btn btn-grey" onclick="moveList();" value="목록" />
				</div>
				<!-- end button -->
			</div>
			
			<!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
		
	</div>
	<!-- end page container -->
	<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
	
	<script type="text/javascript">
	
	function getCharts1(){
		$("#divCharts1").highcharts({
			chart :{
				height: 350
				, width: 978
			},
		    title: {
		        text: 'CPU 사용현황'
		    },
		    xAxis: {
		        categories: ${CPUlabel}
		    },
		    colors :['#fdb042', '#1e77c5', '#0d233a', '#8bbc21', '#910000', '#1aadce', '#492970', '#f28f43', '#77a1e5', '#c42525', '#a6c96a'],
		    yAxis: {
		        title: {
		            text: '사용율'
		            , align : 'high'
		            , rotation : 0
		        }
		    },
		    plotOptions: {
		        line: {
		            dataLabels: {
		                enabled: true
		            }, 
		            enableMouseTracking: false
		        }
		    },
		    series: ${CPUdata}
		});
	}
	function getCharts2(){
		$("#divCharts2").highcharts({
			chart :{
				height: 350
				, width: 978
			},
		    title: {
		        text: 'MEMORY 사용현황'
		    },
		    xAxis: {
		        categories: ${MEMlabel}
		    },
		    colors :['#fdb042', '#1e77c5', '#0d233a', '#8bbc21', '#910000', '#1aadce', '#492970', '#f28f43', '#77a1e5', '#c42525', '#a6c96a'],
		    yAxis: {
		        title: {
		            text: '사용율'
		            , align : 'high'
		            , rotation : 0
		        }
		    },
		    plotOptions: {
		        line: {
		            dataLabels: {
		                enabled: true
		            }, 
		            enableMouseTracking: false
		        }
		    },
		    series: ${MEMdata}
		});
	}
	
	function moveList(){
		location.href = "<%=request.getContextPath()%>/mbr/monitor/event/";
	}
	
	$(document).ready(function(){		
		 App.init();

		getCharts1();
		getCharts2();
		 
		//메뉴활성화
		$("#monitor").addClass("active");
	});	
		
		
	
		</script>
</body>
</html>
