<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
 
	 <div class="chimg"></div>
	 
	 
	 

       <div class="sub mb30">
		   <h3 class="subtitle"><i class="fa fa-cloud f18"></i> K-Cloud 업무 전환 수행 절차</h3>
		
		<img src="${contextPath}/resources/assets/img/change_img.png"  class="mt20 pl30"/>
			
		
			 
			 
			</div>
			
		 </div>	 
	<div class="clear"></div>
	
	<!-- footer start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
	<!-- footer end -->
      
      
      
      
      
      
	 
	 

	
	
	

	

	
</body>
	
</html>