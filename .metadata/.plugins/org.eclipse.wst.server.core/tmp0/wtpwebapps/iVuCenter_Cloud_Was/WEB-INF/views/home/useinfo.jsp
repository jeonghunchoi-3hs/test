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
 
	 <div class="simg"></div>
	 
	 
	 

       <div class="sub mb30">
		   <h3 class="subtitle"><i class="fa fa-cloud f18"></i> K-Cloud 이용방법</h3>
		  <p class="height-500 pt20">이용방법이 들어갑니다. </p>
		<!--<img src="${contextPath}/resources/assets/img/clouding.png"  class="mt20 pl30"/>
			
			<h3 class="subtitle mt30"><i class="fa fa-cloud f18"></i> K-Cloud 특징</h3>
			<div class="clear"></div>
			<div class="row">
				<div class="col-xs-6">
					<div class="sub_graybox bg_cloud01">
					<h4 class="bg_f3">통합 클라우드 서비스 포털 개발</h4>
					<li class="mt20">ㆍ사용자와 관리자를 위한 손쉬운 클라우드 사용</li>
					<li class="mb30">ㆍIT 자원을 필요한 만큼 신속하게 탄력적으로 제공할 수 있는 체계</li>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="sub_graybox bg_cloud02">
					<h4  class="bg_e9f1">안전한 클라우드 구성</h4>
					<li class="mt20">ㆍ시스템별 특성, 운영 안전성을 고려한 클라우드 설계</li>
					<li class="mb30">ㆍ업무별/시스템별 독립성 보장</li>
					</div>				
				</div>
		   </div>
		   <div class="row mt20">
				<div class="col-xs-6">
					<div class="sub_graybox bg_cloud03">
					<h4 class="bg_e9f1">자원 공유 및 관리 자동화</h4>
					<li class="mt20">ㆍ운영시스템 자원량 신속 조절 체계 구축</li>
					<li>ㆍ기본용량 외 사용 폭주 대비 임시 용량 추가지원</li>
					<li class="mb20">ㆍ신기술 프로젝트의 위험부담을 경감시켜 적극적인 추진여건</li>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="sub_graybox bg_cloud04">
					<h4  class="bg_f3">민간과의 상생협력</h4>
					<li class="mt20">ㆍ공개 SW 및 국산 SW 사용 확대로 국내 중소 SW 업체 활성화</li>
					<li>&nbsp;</li>
					<li class="mb20">&nbsp;</li>
					</div>				
				</div>
		   </div>
			<div class="row mt20">
				<div class="col-xs-6">
					<div class="sub_graybox bg_cloud05">
					<h4 class="bg_f3">한국전력공사 전용 사설 클라우드</h4>
					<li class="mt20">ㆍ한국전력공사 직접 구축하고 운영</li>
					<li>ㆍ최신 가상화 기반 서비스 제공</li>
					<li class="mb20">&nbsp;</li>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="sub_graybox bg_cloud06">
					<h4  class="bg_e9f1">표준화, 범용화, 규격화된 인프라</h4>
					<li class="mt20">ㆍ공개 SW 기반으로 운영환경 표준화</li>
					<li>ㆍ범용HW 사용을 통한 제조사 의존성 탈피</li>
					<li class="mb20">ㆍ규격화 된 인프라 구성을 통해 일관성 있는 시스템 구축</li>
					</div>				
				</div>
		   </div>
		
			<h3 class="subtitle mt30"><i class="fa fa-cloud f18"></i> K-Cloud 기대효과</h3>	
			 <h4 class="f20 fc00 mt20 tac">K-Cloud  서비스 플랫폼 도입과 업무 시스템 플랫폼 전환을 통해  자원의 활용이 신속하고 효율적인 ICT 운영환경을 제공 </h4>
			
			<div class="row w96 center">
			
			<div class="col-xs-12 bg_e9f1">
			 <div class="col-xs-2 ptb30 br_dot mt20 mb20 tac"><img src="${contextPath}/resources/assets/img/effect_icon01.png" /> <h5 class="f20 fc0d">신속한 자원제공</h5></div>
			 <div class="col-xs-6 pt50 pl20">
			 		<h5 class="f18 fc0d">자원 Pool 구성을 통해 현업 Needs에 신속 대응</h5>
			 		<p class="f16 fc0d">ㆍ신규 인프라 구축 시 기존 5~7개월 ⇒ 2일內 가능 </p>
			 </div>
			 <div class="col-xs-4 p20"><img src="${contextPath}/resources/assets/img/effect_img01.png" /></div>
			 </div>
			 
			 <div class="col-xs-12 bg_f3 mt20">
			 <div class="col-xs-2 ptb30 br_dot mt20  mb20 tac"><img src="${contextPath}/resources/assets/img/effect_icon02.png" /> <h5 class="f20 fc0d">효율적 자원사용</h5></div>
			 <div class="col-xs-6 pt50 pl20">
			 		<h5 class="f18 fc0d">ICT자원 통합·공유를 통한 탄력적 운영(이용률 향상)</h5>
			 		<p class="f16 fc0d">ㆍ사용량에 따라 필요한 만큼 할당, 여유자원 재활용 </p>
			 </div>
			 <div class="col-xs-4 p20"><img src="${contextPath}/resources/assets/img/effect_img02.png" /></div>
			 </div>
			  
			 <div class="col-xs-12 bg_e9f1 mt20">
			 <div class="col-xs-2 ptb30 br_dot mt20 mb20 tac"><img src="${contextPath}/resources/assets/img/effect_icon03.png" /> <h5 class="f20 fc0d">유연한 확장</h5></div>
			 <div class="col-xs-6 pt50 pl20">
			 		<h5 class="f18 fc0d">자원 Pool 부족 시 서버 추가(Scale-out) 형태로 증설</h5>
			 		<h5 class="f18 fc0d">서비스 폭증 시 서버(가상머신) 복제 및 부하분산 가능 </h5>
			 </div>
			 <div class="col-xs-4 p20"><img src="${contextPath}/resources/assets/img/effect_img03.png" /></div>
			 </div>
			 
			 <div class="col-xs-12 bg_f3 mt20">
			 <div class="col-xs-2 ptb30 br_dot mt20  mb20 tac"><img src="${contextPath}/resources/assets/img/effect_icon04.png" /> <h5 class="f20 fc0d">아키텍처 표준화</h5></div>
			 <div class="col-xs-6 pt50 pl20">
			 		<h5 class="f18 fc0d">정보자원 표준화를 통한 정보시스템 관리 일관성 유지</h5>
			 		<p class="f16 fc0d">ㆍ다양한 정보자원 운영에 따른 비효율성 제거 </p>
			 </div>
			 <div class="col-xs-4 p10"><img src="${contextPath}/resources/assets/img/effect_img04.png" /></div>
			 </div>  -->	
			 
			 
			 
			</div>
			
		 </div>	 
	<div class="clear"></div>
	
	<!-- footer start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
	<!-- footer end -->
      
      
      
      
      
      
	 
	 

	
	
	

	

	
</body>
	
</html>