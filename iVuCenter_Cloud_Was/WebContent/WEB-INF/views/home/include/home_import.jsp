<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!-- ================== BEGIN BASE CSS STYLE ================== -->
<head>


	<link href="${contextPath}/resources/assets/plugins/jquery-ui/themes/base/minified/jquery-ui.min.css" rel="stylesheet" />
	
	<link href="${contextPath}/resources/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
	<link href="${contextPath}/resources/assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
	<!--<link href="${contextPath}/resources/assets/css/animate.min.css" rel="stylesheet" />  -->
	<link href="${contextPath}/resources/assets/css/intro.css" rel="stylesheet" />
	<!-- <link href="${contextPath}/resources/assets/css/slider-pro_hj.css" rel="stylesheet" /> -->
	<!-- ================== END BASE CSS STYLE ================== -->

	<!--     DataTables CSS	 -->
	<link type='text/css' rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/plugins/dataTables.bootstrap.css" />
	<link type='text/css' rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/plugins/dataTables.tableTools.css" />
	
	<link type='text/css' rel="stylesheet" href="${contextPath}/resources/css/plugins/jquery.modal.css" />
	<link type='text/css' rel="stylesheet" href="${contextPath}/resources/css/plugins/jquery.modal.theme-atlant.css" />
	<link type='text/css' rel="stylesheet" href="${contextPath}/resources/css/plugins/jquery.modal.theme-xenon.css" />
	
</head>	