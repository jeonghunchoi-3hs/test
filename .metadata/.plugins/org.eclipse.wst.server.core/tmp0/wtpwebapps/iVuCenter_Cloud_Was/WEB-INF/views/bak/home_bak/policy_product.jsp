<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	 <div class="sbody mb30 mt30">
		  <h4><i class="fa fa-shopping-bag f18 nh_blue"></i> 자원이용약관</h4>
		  <section class="policy">
			 <h5 class="bgee p10">제 1조 </h5>
			 <p>자원이용약관에 대한내용이 들어갑니다. </p>
	
			 <h5  class="bgee p10">제 2조 </h5>
			 <p>2조에 관한 내용이 들어갑니다. </p>
		  
		  </section>
	 </div>
	
	    
	                          
	  
	 
	 
	<div class="clear"></div>
	<hr class="bline mt30"></hr>
	
	<!-- footer start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
	<!-- footer end -->
	
	
	
	</div>
	

	
</body>
	
</html>