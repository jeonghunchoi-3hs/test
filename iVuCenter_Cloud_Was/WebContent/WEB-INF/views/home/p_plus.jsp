<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />

<c:import url="${contextPath}/WEB-INF/views/home/include/home_import.jsp" charEncoding="UTF-8"></c:import>

<title>KEPCO Cloud Service Platform</title>
</head>
<body>
	<div id="container">
	
	<!-- top menu start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_top.jsp" charEncoding="UTF-8"></c:import>	
	<!-- top menu end -->
	
	 
	 <div class="pimg"></div>
	 <div class="sub mb30">
		   
		   <!-- <h4 class="f20 fc00 mt20 tac">간편하게 생성하고 서버에 연결 사용 가능한 효율적인 데이터 저장 공간  </h4> --> 
		   <!-- <p class="summary wbka">가상 서버의  저장 공간 부족할 때 추가로 부가적인 블록디스크를 요청할 수 있습니다. 
		   Block Storage는 요청 시 수 분 내에 생성되어 서버에 즉시 연결해 사용할 수 있습니다.  
		   </p>
		   <p class="summary wbka">데이터 영역 확장을 위한 고성능 블록디스크를 추가할 수 있습니다. 추가된 디스크는 간단한 작업만으로 서버에 즉시 연결하여 사용할 수 있습니다.
		   </p> -->
		   
		   <p class="tac">
			<img src="${contextPath}/resources/assets/img/intro_sub_block1.png"/>
			<img src="${contextPath}/resources/assets/img/intro_sub_block2.png"/>
			
			</p>
		   
		   
		   	<div class="row mb120">
				<div class="col-xs-6">
					<div class="sub_graybox bg_disk01 height-210">
					<h4 class="bg_f3">높은 안정성 보장</h4>
					<p class="basic pl50 wbka">데이터 손실 방지를 최우선으로 설계하여 모든 관리 노드가 이중화되어 있으며 높은 수준의 가용성을 제공합니다. 이를 통해 시스템의 안정성 보장에 기여합니다.
					</p>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="sub_graybox bg_disk02  height-210">
					<h4  class="bg_e9f1">I/O 성능에 따른 스토리지 종류 </h4>
					<p class="basic2 pl30 wbka">
					 OA Zone과 DMZ Zone의 블록디스크는 고성능 통합 스토리지를 기본적으로 제공합니다. 
					 또한 FA Zone은 Ceph 기반의 분산 스토리지로 디스크 장애에도 데이터 유실 위험이 없는 고성능 I/O SAS 및 범용적인 SATA 타입의 디스크를 제공합니다.

					</p>
					</div>				
				</div>
		   </div>

			



			

			
		 </div>	 
	  
	 
	 
	<div class="clear"></div>
	
	<!-- footer start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
	<!-- footer end -->
	
	
	
	</div>
	

	
</body>
	
</html>