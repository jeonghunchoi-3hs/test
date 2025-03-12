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
			<h1 class="page-header fc66 fb"> <i class="fa fa-dot-circle-o fcb"> </i> 사용현황 <span class="root"> 포털 > 모니터링 > 사용현황</span></h1>
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
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
		
	</div>
	<!-- end page container -->
	<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
	
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
		location.href = "${contextPath}/mbr/monitor/event/";
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
