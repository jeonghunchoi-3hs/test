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
			<div id='divSidebar' class="fixedArea">
				<!-- begin sidebar nav -->
				<ul class="nav">
					<li class="has-sub" id="project" style='display:none'>
						<a type='button'>
							<b class="caret pull-right"></b>
							<i class=""><img src="/resources/assets/img/left_project.svg" height="26px" class="pt5"/></i>
							<span>프로젝트 신청</span>
						</a>
						<ul class="sub-menu">
							<li id="projectList"><a type='button' href="${wasPath}/mbr/req/project/okprojectList.do"> 프로젝트 현황(신청) </a></li>
							<!-- 프로젝트 삭제 신청(신규) 개발 완료시 적용
							<li id="projectList"><a type='button' href="${wasPath}/mbr/req/project/okprojectList.do"> 프로젝트 목록 </a></li>
							-->
						</ul>
					</li>

					<li class="has-sub" id="reqProduct" style='display:none'>
						<a type='button'>
							<b class="caret pull-right"></b>
							<i class=""><img src="/resources/assets/img/left_resource_sin.svg" height="26px" class="pt5"/></i>
							<span>자원 신청</span>
						</a>
						<ul class="sub-menu">
						    <!-- <li id="recommend"><a type='button'href="${wasPath}/mbr/req/catalogue/catalogueList.do">추천자원</a></li> -->
						    <li id="basic"><a type='button' href="${wasPath}/mbr/req/catalogue/catalogueBasicList.do?hourlyFlag=N&instanceType=INSTANCE_NORMAL"> 가상서버 신청 </a></li>
						    <li id="basicGPU"><a type='button' href="${wasPath}/mbr/req/catalogue/catalogueBasicList.do?hourlyFlag=N&instanceType=INSTANCE_GPU"> 가상서버(GPU) 신청 </a></li>
						     <%-- <c:choose>
								<c:when test="${userId eq 'admin'}">
									<li id="direct"><a type='button' href="${wasPath}/mbr/req/catalogue/catalogueDirectList.do?hourlyFlag=N"> 즉시 생성 </a></li>
								</c:when>
								<c:otherwise>
									<sec:authorize access="hasAnyRole('ROLE_CLOUD_ADMIN_USER')" >
										<li id="direct"><a type='button' href="${wasPath}/mbr/req/catalogue/catalogueDirectList.do?hourlyFlag=N"> 즉시 생성 </a></li>
									</sec:authorize>
								</c:otherwise>
							</c:choose>  --%>
						    <li id="sub"><a type='button' href="${wasPath}/mbr/req/catalogue/catalogueSubList.do"> 블록디스크 신청</a></li>
						    <li id="fs"><a type='button' href="${wasPath}/mbr/req/catalogue/catalogueFsOrder.do?productSeq=20241126153504&hourlyFlag=N"> 파일 스토리지 신청</a></li>
						    <li id="pv"><a type='button' href="${wasPath}/mbr/req/catalogue/cataloguePvOrder.do?productSeq=20220603390000&hourlyFlag=N"> PV 신청</a></li>
						    <li id="service"><a type='button' href="${wasPath}/mbr/req/catalogue/catalogueServiceList.do"> 서비스 신청</a></li>
<%-- 						    <li id="reqApp"><a type='button' href="${wasPath}/mbr/application/req/">어플리케이션 신청</a></li> --%>
						    <li id="autoscale"><a type='button' href="${wasPath}/mbr/req/catalogue/catalogueServiceOrder.do?productSeq=20191114130000&hourlyFlag=N&serviceType=ASCL"> 오토스케일링 신청</a></li>
					   		<li id="modify"><a type='button' href="${wasPath}/mbr/req/changeOrder/changeOrderView?viewFlag=Y">자원 변경</a></li>
					   		<li id="del"><a type='button' href="${wasPath}/mbr/req/changeOrder/changeOrderView?viewFlag=N">자원 삭제</a></li>
					   		<li id="basket"><a type='button' href="${wasPath}/mbr/req/catalogue/basketOrder.do">일괄 신청</a></li>
						</ul>
					</li>

					<li class="has-sub" id="reqDev">
						<a type='button'>
							<b class="caret pull-right"></b>
							<i class=""><img src="/resources/assets/img/left_sincurrent.svg" height="26px" class="pt5"/></i>
							<span>개발환경</span>
						</a>
						<ul class="sub-menu">
							<li id="devImport"><a type='button' href="${wasPath}/mbr/application/req/catalogueDevEnv?productSeq=20240406003429&cloudType=openshift&imageType=APPIMGWAS110&hourlyFlag=N"> 개발환경(신청) </a></li>
							<li id="reqDevDeploy"><a type='button' href="${wasPath}/mbr/application/req/catalogueDevList"> 개발환경 배포 (신규)</a></li>
							<li id="envApp"><a type='button' href="${wasPath}/mbr/application/env/">운영환경 배포 (신규)</a></li>
<%-- 							<li id="reqDevDeploy"><a type='button' href="${wasPath}/mbr/application/req/reqDevDeployList"> 개발환경 배포 before</a></li> --%>
							<li id="reqDevDeployList"><a type='button' href="${wasPath}/mbr/application/req/reqDevDeployList">배포 현황(개발)</a></li>
							<li id="reqPrdDeployList"><a type='button' href="${wasPath}/mbr/application/req/reqPrdDeployList">배포 현황(운영)</a></li>
<%-- 						    <li id="reqCt"><a type='button' href="${wasPath}/mbr/application/req/catalogueDevList?vmType=containerTerminal">컨테이너터미널 신청</a></li> --%>
						    <li id="reqCt"><a type='button' href="${wasPath}/mbr/application/req/catalogueDevList?instanceType=INSTANCE_CTNTRMNL">컨테이너터미널 신청</a></li>
						</ul>
					</li>

					<li class="has-sub" id="reqStatus">
						<a type='button'>
							<b class="caret pull-right"></b>
							<i class=""><img src="/resources/assets/img/left_sincurrent.svg" height="26px" class="pt5"/></i>
							<span>신청/승인 현황</span>
						</a>
						<ul class="sub-menu">
							<li id="projectRequestList"><a type='button' href="${wasPath}/mbr/req/project/projectList.do"> 프로젝트 요청 현황 </a></li>
							<li id="projectApproveList"><a type='button' href="${wasPath}/mbr/req/project/projectApproveList.do"> 프로젝트 승인 </a></li>
							<li id="goodsReqStatus"><a type='button' href="${wasPath}/mbr/req/catalogue/bssOrderList"> 자원 요청 현황</a></li>
						    <li id="goodsReqStatusApprove"><a type='button' href="${wasPath}/mbr/req/catalogue/bssOrderApproveList"> 자원 승인 </a></li>
						</ul>
					</li>

					<li class="has-sub" id="myGoods">
						<a type='button'>
							<b class="caret pull-right"></b>
							<i class=""><img src="/resources/assets/img/left_resource_current.svg" height="24px" class="pt5"/></i>
							<span>자원 현황</span>
						</a>
						<ul class="sub-menu">
						    <li id="myVmNomal"><a type='button' href="${wasPath}/mbr/project/vm/?instanceType=INSTANCE_NORMAL"> 가상서버 </a></li>
						    <li id="myVmGpu"><a type='button' href="${wasPath}/mbr/project/vm/?instanceType=INSTANCE_GPU"> 가상서버(GPU) </a></li>
						    <li id="myVmCtntrmnl"><a type='button' href="${wasPath}/mbr/project/vm/?instanceType=INSTANCE_CTNTRMNL"> 컨테이너터미널 </a></li>
						    <li id="myStorage"><a type='button' href="${wasPath}/mbr/project/disk/"> 블록디스크 </a></li>
						    <li id="myService"><a type='button' href="${wasPath}/mbr/project/service/"> 서비스 </a></li>
						    <li id="myFs"><a type='button' href="${wasPath}/mbr/project/filestorage/"> 파일스토리지 </a></li>
						    <li id="myPv"><a type='button' href="${wasPath}/mbr/project/persistentvolume/"> PV </a></li>

<%-- 						    <li id="myLoadbalancer"><a type='button' href="${wasPath}/mbr/project/lb/">오토스케일 관리(신규)</a></li> --%>
<%-- 						    <li id="myLoadbalancer"><a type='button' href="${wasPath}/mbr/project/lb/">로드밸런스</a></li> --%>
						    <li id="managementApp"><a type='button' href="${wasPath}/mbr/application/management/">어플리케이션 관리</a></li>
						    <li id="myEnvList"><a type='button' href="${wasPath}/mbr/application/env/envList">개발환경</a></li>
						</ul>
					</li>

 					<li class="has-sub" id="monitoring" style=''>
						<a type='button'>
							<b class="caret pull-right"></b>
						    <i><img src="/resources/assets/img/left_monitoring.svg" height="26px" class="pt5"/></i>
						    <span>모니터링</span>
					    </a>
						<ul class="sub-menu">
						    <li id="statusList"><a href="${contextPath}/mbr/monitoring/status/">실시간 성능 분석</a></li>
						    <li id="eventList"><a href="${contextPath}/mbr/monitoring/event/">이벤트 발생 현황</a></li>
						</ul>
					</li>


					<li class="has-sub" id="bbs" style='display:none'>
						<a type='button'>
							<b class="caret pull-right"></b>
							<i class=""><img src="/resources/assets/img/left_question.svg" height="26px" class="pt5"/></i>
							<span>사용문의</span>
						</a>
						<ul class="sub-menu">
						    <li id="bbsNotice"><a type='button' href="${wasPath}/mbr/bbs/notice/">공지사항</a></li>
						    <li id="bbsFaq"><a type='button' href="${wasPath}/mbr/bbs/faq/">FAQ</a></li>
						    <li id="bbsQna"><a type='button' href="${wasPath}/mbr/bbs/qna/">Help Desk</a></li>
						    <li id="bbsDownload"><a type='button' href="${wasPath}/mbr/bbs/download/">자료실</a></li>
						</ul>
					</li>

				</ul>
				<!-- end sidebar nav -->
			</div>
			<!-- end sidebar scrollbar -->
		</div>

		<!-- end #sidebar -->

