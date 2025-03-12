<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

		<!-- begin #sidebar -->
		<div id="sidebar" class="sidebar">
			<!-- begin sidebar scrollbar -->
			<div data-scrollbar="false" data-height="100%">
				<!-- begin sidebar nav -->
				<ul class="nav">

					<!-- <li id="" class="mt15">
						<a href="${contextPath}/mng/mnghome/dashboard/">
						    <i class="fa fa-tachometer"></i>
						    <span>대시보드 </span>
					    </a>
					</li>-->
					<!-- <li id="customerInfo" style='display:none'>
						<a href="${contextPath}/mng/cmm/customer/">
						    <i class="fa fa-handshake-o"></i>
						    <span>회원사 관리</span>
					    </a>
					</li>  -->	
					<li class="has-sub" id="project" style='display:none'>
						<a type="button">
						    <b class="caret pull-right"></b>
							<i class="fa fa-clipboard"></i>
							<span>프로젝트</span>
					    </a>
						<ul class="sub-menu">
						    <li id="projectInfo"><a href="${contextPath}/mng/project/info/">프로젝트 관리</a></li>
						    <li id="projectQuota"><a href="${contextPath}/mng/project/quota/">프로젝트 쿼터 관리</a></li>
						    <li id="projectVmNomal"><a href="${contextPath}/mng/project/vm/?instanceType=INSTANCE_NORMAL">가상서버 관리</a></li>
						    <li id="projectVmGpu"><a href="${contextPath}/mng/project/vm/?instanceType=INSTANCE_GPU">가상서버(GPU) 관리</a></li>
						    <li id="projectVmCtntrmnl"><a href="${contextPath}/mng/project/vm/?instanceType=INSTANCE_CTNTRMNL">컨테이너터미널 관리</a></li>

						    <li id="projectDisk"><a href="${contextPath}/mng/project/disk/">블록디스크 관리</a></li>
						    <li id="projectFs"><a href="${contextPath}/mng/project/filestorage/">파일스토리지 관리</a></li>
						    <li id="projectPv"><a href="${contextPath}/mng/project/persistentvolume/">PV 관리</a></li>
							<li id="projectApp"><a href="${contextPath}/mng/project/application/">어플리케이션 관리 </a></li>
						    <li id="projectService"><a href="${contextPath}/mng/project/service/">서비스 관리 </a></li>
<%-- 						    <li id="projectLB"><a href="${contextPath}/mng/project/lb/">로드밸런스 관리 </a></li> --%>
						    <li id="projectEnv"><a href="${contextPath}/mng/application/env/envList">개발환경 </a></li>
						    <li id="projectProd"><a href="${contextPath}/mng/application/env/prodList">운영환경배포(신규)</a></li>
						    <li id="projectDev"><a href="${contextPath}/mng/application/req/reqDevDeployList">배포 현황(개발) </a></li>
						    <li id="reProd"><a href="${contextPath}/mng/application/req/reqPrdDeployList">배포 현황(운영) </a></li>
							<!-- <li id="projectQuota"><a href="${contextPath}/mng/project/quota/">할당량 관리</a></li>
							<li id="projectNetwork"><a href="${contextPath}/mng/project/network/">네트워크 관리</a></li> -->
						</ul>
					</li>

					<!--new -->
					<li class="has-sub" id="productUsageStatus" style='display:none'>
						<a type="button">
						    <b class="caret pull-right"></b>
							<i class="fa fa-sliders"></i>
							<span>자원사용현황</span>
					    </a>
						<ul class="sub-menu">
							<li id="productUsageStatusTotal"><a href="${contextPath}/mng/productUsageStatus/total/">전체현황</a></li>
					    	<li id="productUsageStatusVmNomal"><a href="${contextPath}/mng/productUsageStatus/vm/?instanceType=INSTANCE_NORMAL">가상서버</a></li>
					    	<li id="productUsageStatusVmGpu"><a href="${contextPath}/mng/productUsageStatus/vm/?instanceType=INSTANCE_GPU">가상서버(GPU)</a></li>
					    	<li id="productUsageStatusVmCtntrmnl"><a href="${contextPath}/mng/productUsageStatus/vm/?instanceType=INSTANCE_CTNTRMNL">컨테이너터미널</a></li>

					    	<li id="productUsageStatusDisk"><a href="${contextPath}/mng/productUsageStatus/disk/">블록디스크</a></li>
					    	<li id="productUsageStatusFs"><a href="${contextPath}/mng/productUsageStatus/fs/">파일스토리지 </a></li>
					    	<li id="productUsageStatusPv"><a href="${contextPath}/mng/productUsageStatus/pv/">PV </a></li>
					    	<li id="productUsageStatusApp"><a href="${contextPath}/mng/productUsageStatus/app/">어플리케이션 </a></li>
					    	<li id="productUsageStatusBack"><a href="${contextPath}/mng/productUsageStatus/service/">서비스 </a></li>
					    	<!-- <li id="productUsageStatusNas"><a href="${contextPath}/mng/productUsageStatus/nas/">NAS</a></li>
					    	<li id="productUsageStatusLb"><a href="${contextPath}/mng/productUsageStatus/lb/">로드 분산</a></li>
					    	<li id="productUsageStatusIp"><a href="${contextPath}/mng/productUsageStatus/ip/">공인 IP</a></li>
					    	<li id="productUsageStatusBack"><a href="${contextPath}/mng/productUsageStatus/back/">백업 서비스</a></li>
					    	<li id="productUsageStatusMca"><a href="${contextPath}/mng/productUsageStatus/mca/">대외계 서비스</a></li>
					    	<li id="productUsageStatusScm"><a href="${contextPath}/mng/productUsageStatus/scm/">형상관리 서비스</a></li>
					    	<li id="productUsageStatusSec"><a href="${contextPath}/mng/productUsageStatus/sec/">보안관제 서비스</a></li> -->
						</ul>
					</li>

					<!--new-->
					<li class="has-sub" id="req" style='display:none'>
						<a type="button">
						    <b class="caret pull-right"></b>
							<i class="fa fa-gavel"></i>
							<span>결재 승인</span>
					    </a>
						<ul class="sub-menu">
							<c:choose>
								<c:when test="${userId eq 'admin'}">
									<li id="userApprove"><a href="${contextPath}/mng/req/user/userApproval">회원가입 승인</a></li>
								</c:when>
								<c:otherwise>
									<sec:authorize access="hasAnyRole('ROLE_CLOUD_ADMIN_USER')" >
										<li id="userApprove"><a href="${contextPath}/mng/req/user/userApproval">회원가입 승인</a></li>
									</sec:authorize>
								</c:otherwise>
							</c:choose>
							<li id="projectManage"><a href="${contextPath}/mng/req/project/workApprovalProject/">프로젝트 승인</a></li>
					    	<li id="productManage"><a href="${contextPath}/mng/req/product/">자원신청 승인</a></li>
					    	<li id="workManage"><a href="${contextPath}/mng/req/work/">작업요청 처리</a></li>
					    	<!-- <li id="calcApprv"><a href="${contextPath}/mng/approval/calculate/calApprovalListPage">정산 승인</a></li> -->
						</ul>
					</li>

					<li class="has-sub" id="productAservice" style='display:none'>
						<a type="button">
							<b class="caret pull-right"></b>
						    <i class="fa fa-server"></i>
						    <span>서비스 관리</span>
					    </a>
					    <ul class="sub-menu">
							<li id="catalog"><a href="${contextPath}/mng/bss/catalog/">서비스 목록 관리 </a></li>
							<li id="product"><a href="${contextPath}/mng/bss/product/">서비스 구성 관리</a></li>
							<li id="billPolicy"><a href="${contextPath}/mng/bill/policy/billPolicyList">서비스 정책 관리</a></li>
						</ul>
					</li>
					<li class="has-sub" id="operation" style='display:none'>
						<a type="button">
						    <b class="caret pull-right"></b>
						    <i class="fa fa-list-alt"></i>
						    <span>정책관리</span>
					    </a>
						<ul class="sub-menu">
							<li id="adminUser"><a href="${contextPath}/mng/operation/adminUser/">결재권한 관리</a></li>
							<li id="cmmUser"><a href="${contextPath}/mng/cmm/user/">사용자 관리</a></li>
							<!--  <li id="cmmCompany"><a href="${contextPath}/mng/cmm/company/">계열사 관리</a></li>-->
							<li id="ossNetwork"><a href="${contextPath}/mng/oss/network/">네트워크  관리</a></li>
							<li id="ossLicense"><a href="${contextPath}/mng/cmm/license/">라이센스 관리</a></li>
							<li id="ossCloud"><a href="${contextPath}/mng/cmm/cloud/">클라우드 관리</a></li>
							<!-- <li id="image"><a href="${contextPath}/mng/bss/productOs/">이미지관리</a></li> -->
							<%-- <li id="batch"><a href="${contextPath}/mng/bss/batch/">배치 관리</a></li> --%>
							<%-- <li id="department"><a href="${contextPath}/mng/cmm/department/">부서 관리</a></li> --%>

						</ul>
					</li>
					<li class="has-sub" id="monitoring" >
						<a type="button">
						    <b class="caret pull-right"></b>
						    <i class="fa fa-desktop"></i>
						    <span>모니터링 </span>
						</a>
						<ul class="sub-menu">
							<li id="statusList"><a href="${contextPath}/mng/monitoring/status/">실시간 성능 분석</a></li>
							<li id="eventList"><a href="${contextPath}/mng/monitoring/event/">이벤트 발생 현황</a></li>
							<%-- <li id="kvmStatusList"><a href="${contextPath}/mng/kvm/status/">물리서버 현황</a></li> --%>
						</ul>
					</li>
					<!--

					 <li class="has-sub" id="priceInquiry" style='display:none'>
						<a type="button">
						    <b class="caret pull-right"></b>
						    <i class="fa fa-money"></i>
						    <span>요금조회</span>
						</a>
						<ul class="sub-menu">
							<li id="bill"><a href="${contextPath}/mng/charge/bill/">이용요금</a></li>
							<li id="sales"><a href="${contextPath}/mng/charge/bill/salesListPage">매출현황</a></li>-->
							<!-- <li id="taxinvoice"><a href="${contextPath}/mng/bill/invoice/customer/">세금계산서</a></li>
						    <li id="aop"><a href="${contextPath}/mng/bss/productOs/">이미지목록</a></li>
						    <li id="aop"><a href="${contextPath}/mng/cmm/aop/">사용자로그</a></li>-->
						<!-- </ul>
					</li>-->



					<!-- <li class="has-sub" id="chargeManagement" style='display:none'>
						<a type="button">
						    <b class="caret pull-right"></b>
						    <i class="ico ico_depth1_08"></i>
						    <span>요금관리</span>
						</a>
						<ul class="sub-menu">

							<li id="adjustment"><a href="${contextPath}/mng/bss/adjustment/">보정</a></li>
							<li id="calculate"><a href="${contextPath}/mng/charge/bill/calculateListPage">정산</a></li>
							<li id="vatRateMenu"><a href="${contextPath}/mng/cmm/customer/vatRateListPage">부가가치세율</a></li>
							<li id="dcRateMenu"><a href="${contextPath}/mng/bss/discount/">할인율</a></li>
						</ul>
					</li>-->

					<li class="has-sub" id="bbs" style='display:none'>
						<a type="button">
						    <b class="caret pull-right"></b>
							<i class="fa fa-comments-o"></i>
							<span>사용문의</span>
						</a>
						<ul class="sub-menu">
						    <li id="bbsNotice"><a href="${contextPath}/mng/bbs/notice/">공지사항</a></li>
						    <li id="bbsDownload"><a href="${contextPath}/mng/bbs/download/">자료실</a></li>
						    <li id="bbsFaq"><a href="${contextPath}/mng/bbs/faq/">FAQ</a></li>
						    <li id="bbsQna"><a href="${contextPath}/mng/bbs/qna/">Q&A</a></li>


						</ul>
					</li>
					<li class="has-sub" id="alarms" style='display:none'>
						<a type="button">
						    <b class="caret pull-right"></b>
						    <i class="fa fa-bell-o"></i>
						    <span>접속관리/문자발송</span>
					    </a>
						<ul class="sub-menu">
							<li id ="loginHistory"><a href="${contextPath}/mng/cmm/aop/loginHistory">접속이력 조회</a></li>
							<li id="smsQueue"><a href="${contextPath}/mng/alarms/smsQueue/">문자 발송</a></li>
							<li id="template"><a href="${contextPath}/mng/alarms/template/">템플릿 관리</a></li>
							<li id="smsHistory"><a href="${contextPath}/mng/alarms/history/">발송이력 조회</a></li>
							<!-- <li id ="aop"><a href="${contextPath}/mng/cmm/aop/">사용이력 조회</a></li>-->
						</ul>
					</li>

				</ul>
				<!-- end sidebar nav -->
			</div>
			<!-- end sidebar scrollbar -->
		</div>

		<!-- end #sidebar -->