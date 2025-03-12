<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		 
 <div class="cimg"></div>
	<div class="sub mb30">
	    <h3 class="subtitle"><i class="fa fa-cloud f18"></i> FAQ</h3>
		<!-- begin panel -->
		<c:forEach items="${faqList}" var="faqList" varStatus="status" >
			<div class="panel overflow-hidden ml20 mb0 pt20">
            	<div class="panel-heading">
                	<a class="accordion-toggle accordion-toggle-styled collapsed" data-toggle="collapse" data-parent="#theme-accordion" href="#theme_${faqList.faqNo}">
	                    <span class="q2">Q</span>
	                    <div class="f16 width-1050 dpin qh ml10">
	                    	<i class="fa fa-plus-circle pull-right mt5"></i> 
	                        ${faqList.title}
	                    </div>
                    </a>
                </div>
                <div id="theme_${faqList.faqNo}" class="panel-collapse collapse mt20 mb10">
                    <span class="a2 mt-10"> A</span> 
                        <div class="panel-body width-1050 dpin ml10 bg_e1 br5 mt-10">  
                      	 ${faqList.content}
                        </div>
                </div>
            </div>
		</c:forEach>
    </div>
	<div class="clear"></div>	
	<!-- footer start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
	<!-- footer end -->
	
	
	
	</div>
	

	
</body>
	
</html>