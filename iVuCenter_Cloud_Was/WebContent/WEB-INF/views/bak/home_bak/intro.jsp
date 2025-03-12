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

<!-- ================== BEGIN BASE CSS STYLE ================== -->

	<link href="${contextPath}/resources/assets/plugins/jquery-ui/themes/base/minified/jquery-ui.min.css" rel="stylesheet" />
	
	<link href="${contextPath}/resources/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
	<link href="${contextPath}/resources/assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
	<link href="${contextPath}/resources/assets/css/animate.min.css" rel="stylesheet" />
	<link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet" />
	<link href="${contextPath}/resources/assets/css/nhstyle.css" rel="stylesheet" />
	<link href="${contextPath}/resources/assets/css/slider-pro_hj.css" rel="stylesheet" />
	<!-- ================== END BASE CSS STYLE ================== -->


<title>KEPCO Cloud Service Platform</title>
</head>
<body>
	<div id="container">
	
	<!-- top menu start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_top.jsp" charEncoding="UTF-8"></c:import>	
	<!-- top menu end -->
	
	 
	 <div class="simg"></div>
	 <div class="sbody mb30 mt30">
		  <h4><i class="fa fa-cloud f18 nh_blue"></i> 클라우드 소개</h4>
		  <p class="subp">
		  아이뷰센터 클라우드는 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라만세~ 무궁화 삼천리 화려강산 대한민국 대한으로
		  우리나라만세  아이뷰센터 클라우드는 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라만세~ 무궁화 삼천리 화려강산 대한민국 대한으로
		  우리나라만세
	
		<br/> - 남산위에 저소나무 철갑을 두른듯 바람서리 불변함은 우리 기상일세 
		<br/> - 이기상과 이맘으로 충성을 다하여 괴로우나 즐거우나 나라사랑하세
		<br/> - 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리 나라만세 
		무궁화 삼천리 화려강산 대한민국 대한으로 우리나라만세
		  </p>
		  <div class="col-md-12 mb30 mt20">
			  <div class="col-md-3 tac">
				  <div class="b2gr p10">
				  <p class="p10"><i class="fa fa-cogs f80"></i></p>
				  <li class="bg_dc fc53 fb f14 p5 mt10 mb10">손쉬운서버셋팅</li>
				  <p class="f14 tal p5">CPU 메모리, 네트워크를 자신이 원하는 대로 커스터 마이징해서 손쉽게 제공받습니다. </p>
				  </div>
			  </div>
			   <div class="col-md-3 tac">
				  <div class="b2gr p10">
				  <p class="p10"><i class="fa fa-database f80"></i></p>
				  <li class="bg_dc fc53 fb f14 p5 mt10 mb10">빠른스토리지 확장</li>
				  <p class="f14 tal p5">디스크 용량이 필요한 만큼 원하는대로 빠르게 확장할 수 있습니다. </p>
				  </div>
			  </div>
			   <div class="col-md-3 tac">
				  <div class="b2gr p10">
				  <p class="p5 f63 fb">OS</p>
				  <li class="bg_dc fc53 fb f14 p5 mt10 mb10">편리한 OS 관리</li>
				  <p class="f14 tal p5">서버에서 사용할 운영체제를 편리하게 설치하고 업데이트 및 관리 할 수 있습니다. </p>
				  </div>
			  </div>
			   <div class="col-md-3 tac">
				  <div class="b2gr p10">
				  <p class="p10"><i class="fa fa-desktop f80"></i></p>
				  <li class="bg_dc fc53 fb f14 p5 mt10 mb10">강력한 모니터링</li>
				  <p class="f14 tal p5">자체적으로 제공하는 강력한 모니터링 툴로 필요한 정보를 즉시 제공하고 있습니다. </p>
				  </div>
			  </div>
		  </div>
		  
		   <h4 class="nh_green"><i class="fa fa-cloud f18 nh_green"></i> 서비스구성도 </h4>
		   <p class="tac"> <img src="${contextPath}/resources/assets/img/intro_img.png"/></p>
		   
		   <h4><i class="fa fa-cloud f18 nh_blue mt20"></i> 아이뷰센터 클라우드의 장점</h4>
		   <div class="col-md-12">
				<div class="col-md-6">
					<div class="b1_g">
					<h4 class="bgdc p10 m0 f16 fn tac"><i class="fa fa-shield f18 nh_blue"></i> 안전성 및 보안성</h4>
					<li class="mt10">ㆍGolobal 수준 99.95% SLA 품질 보장</li>
					<li>ㆍDDos, Firewall 등 사전 침입차단 및 보안성 보장</li>
					<li>ㆍ고객의 귀중한 정보보호</li>
					<li>ㆍCloud 여유자원으로 전환, 신속한 장애복구</li>
					<li class="mb10">ㆍSystem Redundancy 불필요</li>	
					</div>
				</div>
				<div class="col-md-6">
					<div class="b1_g">
					<h4 class="bgdc p10 m0 f16 fn tac"><i class="fa fa-won f18 nh_blue"></i> 비용절감</h4>
					<li class="mt10">ㆍ클라우드 가상서버(VM)추가로 간단한 확장가능</li>
					<li>ㆍ초기투자 불필요</li>
					<li>ㆍ호스팅 서비스 대비 저렴한 가격</li>
					<li>ㆍ고객니즈에 맞춘 다양한 사양 및 요금제 제공</li>
					<li class="mb10">ㆍ자체 전산시스템 운영 불필요에 따른 운용비 절감</li>	
					</div>				
				</div>
	
				<div class="col-md-6 mt20">
					<div class="b1_g">
					<h4 class="bgdc p10 m0 f16 fn tac"><i class="fa fa-clock-o f18 nh_blue"></i> 신속성</h4>
					<li class="mt10">ㆍ자동화 자원할당으로 5분내 서비스제공</li>
					<li>ㆍHardware Maintenance 자체가 불필요</li>
					<li>ㆍ돌발 수요 및 트래픽 증가에 따른 증설 시간 99% 이상 단축</li>
					<li class="mb10">ㆍucloud biz웹을 간편한 자원신청, 생성, 삭제 제공</li>
					</div>
				</div>
				<div class="col-md-6 mt20">
					<div class="b1_g">
					<h4 class="bgdc p10 m0 f16 fn tac"><i class="fa fa-arrows-alt f18 nh_blue"></i> 신축성 및 확장성</h4>
					<li class="mt10">ㆍ규모를 예측하기 어려운 신사업 개발/적용 </li>
					<li>ㆍ사업확대에 따른 유연한 확장 제공</li>
					<li class="mb34">ㆍ서비스 종료시 매몰비용 없음 </li>
					<li> </li>
					</div>				
				</div>
	
		   </div>
	 
	
	 
	 </div>
	 
	 
	<div class="clear"></div>
	<hr class="bline mt30"></hr>
	
	<!-- footer start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
	<!-- footer end -->
	
	
	
	</div>
	

	
</body>
	
</html>