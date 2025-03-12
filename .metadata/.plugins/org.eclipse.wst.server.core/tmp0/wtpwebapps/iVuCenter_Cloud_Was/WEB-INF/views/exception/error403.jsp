<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%
response.setStatus(HttpServletResponse.SC_OK); 
System.out.println("###javax.servlet.error.status_code\n=>"+request.getAttribute("javax.servlet.error.status_code"));
System.out.println("###javax.servlet.error.exception_type\n=>"+request.getAttribute("javax.servlet.error.exception_type"));
System.out.println("###javax.servlet.error.message\n=>"+request.getAttribute("javax.servlet.error.message"));
System.out.println("###javax.servlet.error.request_uri\n=>"+request.getAttribute("javax.servlet.error.request_uri"));
System.out.println("###javax.servlet.error.exception\n=>"+request.getAttribute("javax.servlet.error.exception"));
System.out.println("###javax.servlet.error.servlet_name\n=>"+request.getAttribute("javax.servlet.error.servlet_name"));
String referer = request.getHeader( "REFERER");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="administrator">
    <meta name="author" content="brandom">
	
	<!-- Bootstrap Core CSS -->
	<link type='text/css' rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Fonts -->
	<link type='text/css' rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/font-awesome.min.css" rel="stylesheet">
	<title>error</title>
</head>

<body>

	<div class="container">
	    <div class="row">
	        <div class="col-sm-6 col-md-4 col-md-offset-4">

	            <div class="account-wall">
	                <div style="height:250px;"></div>
					<div class="row">
	                    <div class="col-lg-12">
	                        <h1 class="page-header" style='text-align:center'><small>잘못된 접근입니다.<br/>관리자에게 문의주세요.</small></h1>
	                    </div>
	                </div>
	             <%--    <form class="form-signin" action="<c:choose><c:when test = "${fn:contains(pageContext.errorData.requestURI, 'mbr')}">/mbr/j_spring_security_logout</c:when><c:otherwise>/mng/j_spring_security_logout</c:otherwise></c:choose>" method="post" id="login_form">
	                	<button class="btn btn-lg btn-primary btn-block" type="submit" id="login_btn" >로그인 화면으로 돌아가기</button>
	                	<span class="clearfix"></span>
	                </form> --%>
	            </div>
	            <span class="clearfix"></span>
	        </div>
	    </div>
	</div>
	
</body>
    
    <!-- ================== BEGIN BASE JS ================== -->
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/bootstrap.min.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/respond.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/metisMenu.min.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.dataTables.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/dataTables.bootstrap.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/dataTables.tableTools.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/bootstrapValidator.min.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.placeholder.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.MultiFile.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.form.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/set/core.js"></script>
    
	<script src="<%=request.getContextPath()%>/resources/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    
	<script src="<%=request.getContextPath()%>/resources/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/plugins/jquery-cookie/jquery.cookie.js"></script>

	<script src="<%=request.getContextPath()%>/resources/assets/plugins/bootstrap-calendar/js/bootstrap_calendar.min.js"></script>
<%-- 	<script src="<%=request.getContextPath()%>/resources/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script> --%>
	<!-- ================== END BASE JS ================== -->
	
	<!-- ================== BEGIN PAGE LEVEL JS ================== -->
    <script src="<%=request.getContextPath()%>/resources/assets/js/page-ui-modal-notification.demo.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/page-form-plugins.demo.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/demo.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/apps.min.js"></script>
	<!-- ================== END PAGE LEVEL JS ================== -->
    
	
	
	
	<script type="text/javascript">
		$(function() {
			$('input, textarea').placeholder();
		});
		$(document).ready(function(){
			App.init();
			window.history.forward();
			function noBack(){
				window.history.forward();
			}
		});
		
		
	</script> 
</html>