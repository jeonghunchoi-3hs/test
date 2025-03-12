<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		<div id="header" class="header navbar navbar-default navbar-fixed-top">
			<!--  <div class="info width-300">  
			<span> <img src="${apachePath}/resources/assets/img/df_user_icon.png"/> <b class="userName">어서오세요.</b> 반갑습니다.</span>
			</div>-->
			<div class="container-fluid">
				<div class="navbar-header">
					<a href="${wasPath}/mbr/" class="navbar-brand"><img src="${apachePath}/resources/assets/img/logo.png" width="200px" class="logo" alt="ECloud"/></a>
				</div>
			</div> 
		</div>
		<body class="boxed-layout"> 
		<div id="sidebar" class="sidebar">
			<!-- begin sidebar scrollbar -->
			<div   id='divSidebar' style='display:none'>
			</div>
			<!-- end sidebar scrollbar -->
		</div>
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
			<!-- begin page-header -->
			<h1 class="page-header"><span class="root"> <span class="home"><img src="${apachePath}/resources/assets/img/ico_home.png"  alt="홈"/></span> <span class="text">콘솔</span><span class="text arrow mint"><strong>가입완료</strong></span> </span></h1>
			<!-- end page-header -->
			
			<!-- begin page-body -->
			<div class="row mb50">
			<div class="memJoinStep">
				<img src="${apachePath}/resources/assets/img/memStep03.png"/> 
			</div>
			<p class="page_title">회원가입완료</p> 
		
			<div class="mbrCompArea">
		    	<img src="${apachePath}/resources/assets/img/icon_mbrComp.png"  alt=""/>
		    	<p class="f26 fc11 mt15">한국전력 K-Cloud사이트에 가입해주셔서 감사합니다.</p>
				<p class="f26 fc11 lh8d mt10">관리자의 승인후에  K-Cloud의 각종 자원과 서비스를 이용할 수 있습니다. </p>
		    	<p class="f20 fc66 lh3d8">문의 : ICT 기획처 전화번호 : 061-345-5366</p>
		    </div> 
			    <!-- end section-container -->	   
				<!-- begin button----------->
			<div class="btn_area">	
				<a type='button' id="jquerybuttonok" name="jquerybuttonok"  class="bbton bton_blue" onclick="moveLoginPage();"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-arrow-left"></i></span><span class="dpin ml16"> 초기화면으로 이동</span></a>
			</div> 
			<!-- end button-----------> 
				

				
				
		</div>
		<!-- end page-body -->
		<!-- begin #footer -->
		<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #footer -->
	</div>
	<!-- end page container -->
	
</body>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/bootstrap.min.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/respond.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/metisMenu.min.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.dataTables.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/dataTables.bootstrap.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/dataTables.tableTools.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/bootstrapValidator.min.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.placeholder.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.MultiFile.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.form.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.modal.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/set/core.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/set/modal.js"></script>
   
<script src="${apachePath}/resources/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
<script src="${apachePath}/resources/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
<script src="${apachePath}/resources/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
   
<script src="${apachePath}/resources/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${apachePath}/resources/assets/plugins/jquery-cookie/jquery.cookie.js"></script>

<script src="${apachePath}/resources/assets/plugins/bootstrap-calendar/js/bootstrap_calendar.min.js"></script>
<%-- 	<script src="${apachePath}/resources/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script> --%>
<!-- ================== END BASE JS ================== -->

<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<script src="${apachePath}/resources/assets/js/page-ui-modal-notification.demo.min.js"></script>
<script src="${apachePath}/resources/assets/js/page-form-plugins.demo.js"></script>
<script src="${apachePath}/resources/assets/js/demo.min.js"></script>
<script src="${apachePath}/resources/assets/js/apps.min.js"></script>
<!-- ================== END PAGE LEVEL JS ================== -->

<!-- captcha -->
<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.plugin.js"></script>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.realperson.js"></script>
	
<script type="text/javascript">

	//로그인페이지로 이동
	function moveLoginPage(){
		location.href="${wasPath}/mbr/";
	}
	
</script>
</html>
