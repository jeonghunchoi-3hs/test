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
		  <div>
                        <!-- begin nav-pills -->
                        <ul class="nav nav-pills2">
                            <li class="active"><a href="#nav-pills-tab-1" data-toggle="tab">모니터링</a></li>
                            <li><a href="#nav-pills-tab-2" data-toggle="tab">계정관리</a></li>
                            <li><a href="#nav-pills-tab-3" data-toggle="tab">백업관리</a></li>
                        </ul>
                        <!-- end nav-pills -->
                        <!-- begin tab-content -->
                        <div class="tab-content">
                            <div class="tab-pane fade active in" id="nav-pills-tab-1">
								<p class="summary2 wbka">
									K-Cloud에서 생성되는 모든 가상서버는 IBM Tivoli 솔루션을 통해 모니터링할 수 있습니다.<br />
								  	사용자는 Tivoli 라이선스 구매 및 사내망 접속신청이 필요하지 않으며, K-Cloud 포털에서 서비스 신청만으로<br /> 
									Tivoli Agent 설치 및 관리 포털 연계가 가능하고 가상서버의 상세 정보와 이벤트를 확인할 수 있습니다.
								 </p>
								 <img src="${contextPath}/resources/assets/img/service_img01.png"  />

								 <h3 class="subtitle mt40"><i class="fa fa-cloud f18"></i> 기능 및 특징 </h3>	
								  <ul class="action">
								  		 <li>ㆍ직관적 인터페이스를 통한 진정한 End–to-End 모니터링 실현</li>
										 <li>ㆍ서버/어플리케이션/미들웨어 장애 징후 검출로 문제 발생을 사전에 방지</li>
										 <li>ㆍ자동대응 기능을 통한 관리자 업무 경감</li>
										 <li>ㆍ다양한 플랫폼과 Plug-in 방식의 추가 모니터링 제품을 통해 혼재하는 시스템 및 어플리케이션 관리의 일원화, 효율화로 관리비 절감</li>
										 <li>ㆍ웹, 데이터베이스, 미들웨어, J2EE등 다양한 IT관리 자원을 단일 인터페이스로 관리 가능</li>
										 <li>ㆍ400여 개 이상의 이벤트를 수집하여 다양한 원천 자료를 통합 관리</li>
										 <li>ㆍ통합된 이벤트들을 중요도에 따라 필터링 및 이벤트 처리 자동화</li>
										 <li>ㆍ관리 대상의 이벤트 감소와 다양한 툴을 통해 문제 분석</li>
								  </ul>
								 


								<h3 class="subtitle mt40"><i class="fa fa-cloud f18"></i> 제공기능 </h3>	
									<div class="row mb120">
									<div class="col-xs-6">
										<div class="sub_graybox bg_service01 height-210">
										<h4 class="bg_f3">가상서버 모니터링</h4>
										<ul>
											 <li class="ml120 mt30">서버 자원 사용률 (CPU/MEM/DISK 등)</li>
											 <li class="ml120 mt5">서버 주요 프로세스 감시</li>
											 <li class="ml120 mt5">임계치 설정에 따른 이벤트 감시</li>
											 <li class="ml120 mt5">장애 이벤트 발생 시 자동 통보 (SMS, 이메일)</li>
										</ul>
										</div>
									</div>
									<div class="col-xs-6">
										<div class="sub_graybox bg_service02  height-210">
										<h4  class="bg_e9f1">하이퍼바이저 모니터링</h4>
										<ul>
										 	 <li class="ml120 mt30">물리 서버의 자원 사용률 (CPU/MEM/DISK 등)</li>
											 <li class="ml120 mt5">물리 서버의 자원 할당률 (할당된 vCore/MEM/Disk 등)</li>
											 <li class="ml120 mt5">임계치 설정에 따른 이벤트 감시</li>
											 <li class="ml120 mt5">장애 이벤트 발생 시 자동 통보 (SMS, 이메일)</li>
										</ul>
										</div>				
									</div>
							        </div>
								

							</div>
							 <div class="tab-pane fade" id="nav-pills-tab-2">
							 
							  <p class="summary2 wbka">
							  	K-Cloud에서 생성되는 모든 가상서버는 HI-TAM을 통해 접속할 수 있습니다. <br /> 
								사용자는 HI-WARE 라이선스 구매 및 사내망 접속신청이 필요하지 않으며, K-Cloud 포털에서 서비스 신청만으로 <br />
							  	HI-WARE 솔루션 연계 및 HI-TAM을 통한 접속자의 계정권한 관리 및 감사추적이 가능합니다.<br />
							 </p>
							 <p class="tac mt20">
							 <img src="${contextPath}/resources/assets/img/service_img03.png"  />
							 </p>
								 <p class="summary2 wbka">
								 	K-Cloud는 Veritas NetBackup 솔루션을 지원합니다. <br />
									사용자는 별도 라이선스 구매 및 사내망 접속신청이 필요하지 않으며, K-Cloud 포털에서 서비스 신청만으로<br />
									Backup Master를 통해 포괄적이면서 통합적인 방식으로 데이터를 보호할 수 있습니다. 
								 </p>
								<p class="tac mt20">
							    <img src="${contextPath}/resources/assets/img/backup_0408.png"  width="980px"/>
							    </p>
							</div>
						    <div class="tab-pane fade" id="nav-pills-tab-4">
							<p class="height-500 pt20"> SW 설치에 관한 내용이 들어갑니다. 
							</p> 
							</div>
							<div class="tab-pane fade" id="nav-pills-tab-5">
							<p class="height-500 pt20">디스크관리에 관한 내용이 들어갑니다. </p>
							</div>
						</div>
 
			</div>
	 </div>
	 
	 
	<div class="clear"></div>

	
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
	
	
	
	</div>
	

	
</body>
	
</html>