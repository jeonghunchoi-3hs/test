<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
</sec:authorize>

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
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
			<!-- begin #header -->
			<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->
			<!-- begin #sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #content -->
			<div id="content" class="content">
				<p class="page_title">자원 승인 현황 상세
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> 자원 승인 현황 <span class="arrow_ab"> &#8227; </span> <b>자원 승인 현황 상세 </b>
			    </span>
			    </p>

				<!-- begin #content page-body -->
				<div class="row p20 bgwh br10">

			 		<input type="hidden" id="reqProjectSeq" value="${orderNo}">
 					<input type="hidden" id="onDemandFlag" value="">
					<input type="hidden" id="userId" value="${userId}">
					<input type="hidden" id="requestType" value="${requestType}">
				    <input type="hidden" id="projectId" value="${detail.projectId}">

<%-- 					<!-- 검토&승인 부서 결재라인 표시부분 시작 -->
					<div class="col-xs-12 mb30 pl0 pr0 mt20">
						<!-- 요청부서 결재 표시부분 시작 -->
						<div class="col-xs-6 request">
							<h3 class="request_title"> 요청부서  </h3>

							<div class="col-xs-12 clear mt50">
								<c:forEach items="${getResourceApprovalStep}" var="resourceAppStepListInfo" varStatus="status" >
							 		<c:if test="${resourceAppStepListInfo.stepLevel eq '1'}">
										<div class="col-xs-3 tac pl0 pr0">
									 		<ul class="step00 fl">
									    		<li class="fc11 f18 fb">입안보조</li>
										    	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }"> <!--  진행중  -->
											    	<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
											    	<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
											    	<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw fc-red f30"></i></li>
										    	</c:if>
										    	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }"> <!-- 승인완료  -->
										    		<li>${resourceAppStepListInfo.apprvUserDeptName}</li>
									        		<li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
										    		<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i></li>
										    	</c:if>
										    	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }"> <!-- 반려  -->
										    		<li>${resourceAppStepListInfo.apprvUserDeptName}</li>
									        		<li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
										    		<li class="mt5 mb5"  onclick="projectRejectHits()"><i class="fa fa-reply fc-orange f30"></i> </li>
										    	</c:if>
										    	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">  <!-- 대기  -->
									    	    	<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
										    		<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
										    		<li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i> 대기</li>
										    	</c:if>
									 		</ul>

									 		<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
										 		<p class="ribbon_00">진행중 </p>
									 		</c:if>
									 		<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
										 		<p class="ribbon_00">승인완료 </p>
									 		</c:if>
									 		<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
										 		<p class="ribbon_re">반려 </p>
									 		</c:if>
									 		<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
										 		<p class="ribbon_stay">대기 </p>
									 		</c:if>
										        <p class="fc99 tac f12 mt5">${resourceAppStepListInfo.apprvDatetime}</p>
									 	</div>
							 		</c:if>

							 		<c:if test="${resourceAppStepListInfo.stepLevel eq '2'}">
										<div class="col-xs-3 pl0 pr0 tac">
									 		<ul class="step01">
									    		<li class="fc11 f18 fb">입안</li>
									   			<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
											   		<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i></li>
										    	</c:if>
										    	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
										    	</c:if>
										    	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply fc-orange f30"></i> </li>
										    	</c:if>
										    	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-hourglass-half fc66 f30"></i></li>
										    	</c:if>
									 		</ul>

											<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
									 			<p class="ribbon_01">진행중 </p>
									 		</c:if>
									 		<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
										 		<p class="ribbon_01">승인완료 </p>
									 		</c:if>
									 		<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
										 		<p class="ribbon_re">반려 </p>
									 		</c:if>
									 		<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
										 		<p class="ribbon_stay">대기 </p>
									 		</c:if>
										        <p class="fc99 tac f12 mt5">${resourceAppStepListInfo.apprvDatetime}</p>
									 	</div>
							 		</c:if>

					 	 			<c:if test="${resourceAppStepListInfo.stepLevel eq '3'}">
										<div class="col-xs-3 pl0 pr0 tac">
								 			<ul class="step02">
								    			<li class="fc11 f18 fb">검토 </li>
									    		<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
											        <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i>  </li>
								    			</c:if>
									    		<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
													<li>${resourceAppStepListInfo.apprvUserDeptName}</li>
													<li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
													<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
									    		</c:if>
									    		<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply f30 fc-orange"></i></li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i></li>
											    </c:if>
									     	</ul>

									     	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
									     		<p class="ribbon_02">진행중 </p>
									     	</c:if>
									     	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
									     		<p class="ribbon_02">승인완료  </p>
									     	</c:if>
									     	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
									     		<p class="ribbon_re">반려 </p>
									     	</c:if>
											<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
									     	 	<p class="ribbon_stay">대기 </p>
									     	</c:if>
									     		<p class="fc99 f12 tac mt5">${resourceAppStepListInfo.apprvDatetime}</p>
									 	</div>
						 			</c:if>

							 		<c:if test="${resourceAppStepListInfo.stepLevel eq '4'}">
										<div class="col-xs-3 tac pl0 pr0 tac">
											<ul class="step03 flr">
									    		<li class="fc11 f18 fb">승인</li>
										        <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
													<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
													<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply f30 fc-orange"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i></li>
											    </c:if>
									 		</ul>

											<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
										 		<p class="ribbon_03 fw">진행중 </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
										 		<p class="ribbon_03 fw">승인완료  </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
										 		<p class="ribbon_re fw">반려  </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
										 		<p class="ribbon_stay">대기  </p>
										 	</c:if>
									 			<p class="fc99 tac f12 mt5">${resourceAppStepListInfo.apprvDatetime}</p>
										</div>
						 			</c:if>
						 		</c:forEach>
						 	</div>
						</div>
						<!-- 요청부서 결재 표시부분 끝-->

						<!-- 승인부서 결재 표시부분 시작 -->
						<div class="col-xs-6 approval flr">
							<h3 class="approval_title">승인부서</h3>

					 		<div class="col-xs-12 clear mt50">
								<c:forEach items="${getResourceApprovalStep}" var="resourceAppStepListInfo" varStatus="status" >
									<c:if test="${resourceAppStepListInfo.stepLevel eq '5'}">
										<div class="col-xs-3 pl0 pr0 tac">
								 			<ul class="step00 fl">
								    			<li class="fc11 f18 fb">입안보조</li>
												<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
													<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
													<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
													<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5" onclick="projectRejectHits()"> <i class="fa fa-reply f30 fc66"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i> </li>
											    </c:if>
										 	</ul>

										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
										 		<p class="ribbon_00">진행중 </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
										 		<p class="ribbon_00">승인완료  </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
										 		<p class="ribbon_re">반려  </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
										 		<p class="ribbon_stay">대기  </p>
										 	</c:if>
									 			<p class="fc99 tac f12 mt5">${resourceAppStepListInfo.apprvDatetime}</p>
							 		</div>
						 			</c:if>

						 			<c:if test="${resourceAppStepListInfo.stepLevel eq '6'}">
										<div class="col-xs-3 pl0 pr0 tac">
									 		<ul class="step04 fl">
									    		<li class="fc11 f18 fb">입안</li>
												<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
													<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
													<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
													<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5" onclick="projectRejectHits()"> <i class="fa fa-reply f30 fc66"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i> </li>
											    </c:if>
										 	</ul>

										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
									 			<p class="ribbon_04">진행중 </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
									 			<p class="ribbon_04">승인완료  </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
										 		<p class="ribbon_re">반려  </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
										 		<p class="ribbon_stay">대기  </p>
										 	</c:if>
										 		<p class="fc99 tac f12 mt5">${resourceAppStepListInfo.apprvDatetime}</p>
								 		</div>
						 			</c:if>

						 			<c:if test="${resourceAppStepListInfo.stepLevel eq '7'}">
										<div class="col-xs-3 pl0 pr0 tac">
								 			<ul class="step05">
									    		<li class="fc11 f18 fb">검토</li>
												<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
													<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
													<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
													<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5" onclick="projectRejectHits()"> <i class="fa fa-reply f30 fc66"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i> </li>
											    </c:if>
										 	</ul>

										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
										 		<p class="ribbon_05">진행중 </p>
										 	</c:if>
									 		<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
										 		<p class="ribbon_05">승인완료  </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
										 		<p class="ribbon_re">반려  </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
										 		<p class="ribbon_stay">대기  </p>
										 	</c:if>
										 		<p class="fc99 tac f12 mt5">${resourceAppStepListInfo.apprvDatetime}</p>
								 		</div>
							 		</c:if>

							 		<c:if test="${resourceAppStepListInfo.stepLevel eq '8'}">
										<div class="col-xs-3 pl0 pr0 tac">
									 		<ul class="step06 flr">
									    		<li class="fc11 f18 fb">승인</li>
												<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
													<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
													<li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
													<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
												    <li>${resourceAppStepListInfo.apprvUserDeptName}</li>
											        <li class="mt-5">${resourceAppStepListInfo.apprvUserName}</li>
												    <li class="mt5 mb5" onclick="projectRejectHits()"> <i class="fa fa-reply f30 fc66"></i> </li>
											    </c:if>
											    <c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserDeptName}</li>
												    <li class="mt-5">${resourceAppStepListInfo.apprvScheduleUserName}</li>
												    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i> </li>
											    </c:if>
										 	</ul>

										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_PROCESSING' }">
										 	<p class="ribbon_06 fw">진행중 </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_COMPLETED' }">
										 	<p class="ribbon_06 fw">승인완료  </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_REJECTED' }">
										 	<p class="ribbon_re fw">반려  </p>
										 	</c:if>
										 	<c:if test="${resourceAppStepListInfo.apprvState eq 'APPRV_WAITING' }">
										 	<p class="ribbon_stay">대기  </p>
										 	</c:if>

										 	<p class="fc99 tac f12 mt5">${resourceAppStepListInfo.apprvDatetime}</p>
								 		</div>
							 		</c:if>
								</c:forEach>
							</div>
						</div>
						<!-- 승인부서 결재 표시부분 끝 -->
					</div>
					<!-- 검토&승인 부서 결재라인 표시부분 끝 -->
					 --%>





						<!-- 2023 New 승인  시작 -->
				<div class="col-md-12 pl0 pr0 mb30">
				       <!-- 2023 new  요청부서 start -->
						<div class="col-md-6 dept_request" >
						 <h3 class="dept_request_title">요청부서 </h3>


						<div class="request_line mt20">
							<div class="progress mt30">
							<c:set var="progressbar_width_1" value="0%" />
								<c:forEach items="${getResourceApprovalStep}" var="projectAppSteplistInfo" varStatus="status" >
								<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_UNASSIGNED'
										|| projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING'
										|| projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED'
										|| projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED'
										||projectAppSteplistInfo.apprvState eq 'APPRV_CANCELLED'}">
										<c:if test="${projectAppSteplistInfo.stepLevel eq '1'}">
											<c:set var="progressbar_width_1" value="7%" />
										</c:if>
										<c:if test="${projectAppSteplistInfo.stepLevel eq '2'}">
											<c:set var="progressbar_width_1" value="35%" />
										</c:if>
										<c:if test="${projectAppSteplistInfo.stepLevel eq '3'}">
											<c:set var="progressbar_width_1" value="65%" />
										</c:if>
										<c:if test="${projectAppSteplistInfo.stepLevel eq '4'}">
											<c:set var="progressbar_width_1" value="100%" />
										</c:if>
									</c:if>
								</c:forEach>
								<div class="progress-bar-green" role="progressbar" aria-valuenow="93" aria-valuemin="0" aria-valuemax="100" style="width:${progressbar_width_1}"></div>
							</div>
						</div>


						 <div class="col-md-12 mb20">
						  <c:forEach items="${getResourceApprovalStep}" var="projectAppSteplistInfo" varStatus="status" >
						  <c:if test="${projectAppSteplistInfo.stepLevel eq '1'}">
						    <div class="col-md-3 tac mt-22">
						       <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
						    	<p class="request_ing">&#133</p>
						    	<li class="fix_subtitle">진행중</li>
						    	<li class="fix_subtitle2">(입안보조)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
						    	<p class="request_ing">&#10003</p>
						    	<li class="fix_subtitle">승인완료</li>
						    	<li class="fix_subtitle2">(입안보조)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
						    	<p class="request_reject">&#8630</p>
						    	<li class="fix_subtitle fc_red"  onclick="projectRejectHits()">반려</li>
						    	<li class="fix_subtitle2 fc_red">(입안보조)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
						    	<p class="request_blank"></p>
						    	<li class="fix_subtitle">대기</li>
						    	<li class="fix_subtitle2">(입안보조)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_CANCELLED' }">
						    	<p class="request_ing">&#8630</p>
						    	<li class="fix_subtitle fc_red">상신취소</li>
						    	<li class="fix_subtitle2 fc_red">(입안보조)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<li class="fix_date">${projectAppSteplistInfo.apprvDatetime}</li>
						    </div>
						    </c:if>

						    <c:if test="${projectAppSteplistInfo.stepLevel eq '2'}">
						    <div class="col-md-3 tac mt-22">
						       <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
						    	<p class="request_ing">&#133</p>
						    	<li class="fix_subtitle">진행중</li>
						    	<li class="fix_subtitle2">(입안)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
						    	<p class="request_ing">&#10003</p>
						    	<li class="fix_subtitle">승인완료</li>
						    	<li class="fix_subtitle2">(입안)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
						    	<p class="request_reject">&#8630</p>
						    	<li class="fix_subtitle fc_red"  onclick="projectRejectHits()">반려</li>
						    	<li class="fix_subtitle2 fc_red">(입안)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
						    	<p class="request_blank"></p>
						    	<li class="fix_subtitle">대기</li>
						    	<li class="fix_subtitle2">(입안)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<li class="fix_date">${projectAppSteplistInfo.apprvDatetime}</li>
						    </div>
						    </c:if>

						    <c:if test="${projectAppSteplistInfo.stepLevel eq '3'}">
						    <div class="col-md-3 tac mt-22">
						       <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
						    	<p class="request_ing">&#133</p>
						    	<li class="fix_subtitle">진행중</li>
						    	<li class="fix_subtitle2">(검토)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
						    	<p class="request_ing">&#10003</p>
						    	<li class="fix_subtitle">승인완료</li>
						    	<li class="fix_subtitle2">(검토)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
						    	<p class="request_reject">&#8630</p>
						    	<li class="fix_subtitle fc_red"  onclick="projectRejectHits()">반려</li>
						    	<li class="fix_subtitle2 fc_red">(검토)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
						    	<p class="request_blank"></p>
						    	<li class="fix_subtitle">대기</li>
						    	<li class="fix_subtitle2">(검토)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<li class="fix_date">${projectAppSteplistInfo.apprvDatetime}</li>
						    </div>
						    </c:if>

						     <c:if test="${projectAppSteplistInfo.stepLevel eq '4'}">
						    <div class="col-md-3 tac mt-22">
						       <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
						    	<p class="request_ing">&#133</p>
						    	<li class="fix_subtitle">진행중</li>
						    	<li class="fix_subtitle2">(승인)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
						    	<p class="request_ing">&#10003</p>
						    	<li class="fix_subtitle">승인완료</li>
						    	<li class="fix_subtitle2">(승인)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
						    	<p class="request_reject">&#8630</p>
						    	<li class="fix_subtitle fc_red"  onclick="projectRejectHits()">반려</li>
						    	<li class="fix_subtitle2 fc_red">(승인)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
						    	<p class="request_blank"></p>
						    	<li class="fix_subtitle">대기</li>
						    	<li class="fix_subtitle2">(승인)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<li class="fix_date">${projectAppSteplistInfo.apprvDatetime}</li>
						    </div>
						    </c:if>
						    </c:forEach>
						  </div>
						</div>
						 <!-- 2023 new  요청부서 end -->


						<div class="col-md-6 dept_access">
						 <h3 class="dept_access_title">승인부서</h3>

						  <div class="request_line mt20">
							<div class="progress mt30">
							<c:set var="progressbar_width_2" value="0%" />
								<c:forEach items="${getResourceApprovalStep}" var="projectAppSteplistInfo" varStatus="status" >
									<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_UNASSIGNED'
										|| projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING'
										|| projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED'
										|| projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED'
										|| projectAppSteplistInfo.apprvState eq 'APPRV_CANCELLED'}">
										<c:if test="${projectAppSteplistInfo.stepLevel eq '5'}">
											<c:set var="progressbar_width_2" value="7%" />
										</c:if>
										<c:if test="${projectAppSteplistInfo.stepLevel eq '6'}">
											<c:set var="progressbar_width_2" value="35%" />
										</c:if>
										<c:if test="${projectAppSteplistInfo.stepLevel eq '7'}">
											<c:set var="progressbar_width_2" value="65%" />
										</c:if>
										<c:if test="${projectAppSteplistInfo.stepLevel eq '8'}">
											<c:set var="progressbar_width_2" value="100%" />
										</c:if>
									</c:if>
								</c:forEach>
								<div class="progress-bar-blue" role="progressbar" aria-valuenow="93" aria-valuemin="0" aria-valuemax="100" style="width:${progressbar_width_2}"></div>
							</div>
						</div>

						  <div class="col-md-12 mb20">
						  <c:forEach items="${getResourceApprovalStep}" var="projectAppSteplistInfo" varStatus="status" >
							<c:if test="${projectAppSteplistInfo.stepLevel eq '5'}">
						    <div class="col-md-3 tac mt-22">
						       <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING'
						       		|| projectAppSteplistInfo.apprvState eq 'APPRV_UNASSIGNED' }">
						    	<p class="access_ing">&#133</p>
						    	<li class="fix_subtitle">진행중</li>
						    	<li class="fix_subtitle2">(입안보조)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
						    	<p class="access_ing">&#10003</p>
						    	<li class="fix_subtitle">승인완료</li>
						    	<li class="fix_subtitle2">(입안보조)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
						    	<p class="access_reject">&#8630</p>
						    	<li class="fix_subtitle fc_red"  onclick="projectRejectHits()">반려</li>
						    	<li class="fix_subtitle2 fc_red">(입안보조)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
						    	<p class="access_blank"></p>
						    	<li class="fix_subtitle">대기</li>
						    	<li class="fix_subtitle2">(입안보조)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<li class="fix_date">${projectAppSteplistInfo.apprvDatetime}</li>
						    </div>
						    </c:if>

						    <c:if test="${projectAppSteplistInfo.stepLevel eq '6'}">
						    <div class="col-md-3 tac mt-22">
						       <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
						    	<p class="access_ing">&#133</p>
						    	<li class="fix_subtitle">진행중</li>
						    	<li class="fix_subtitle2">(입안)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
						    	<p class="access_ing">&#10003</p>
						    	<li class="fix_subtitle">승인완료</li>
						    	<li class="fix_subtitle2">(입안)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
						    	<p class="access_reject">&#8630</p>
						    	<li class="fix_subtitle fc_red"  onclick="projectRejectHits()">반려</li>
						    	<li class="fix_subtitle2 fc_red">(입안)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
						    	<p class="access_blank"></p>
						    	<li class="fix_subtitle">대기</li>
						    	<li class="fix_subtitle2">(입안)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<li class="fix_date">${projectAppSteplistInfo.apprvDatetime}</li>
						    </div>
						    </c:if>

						    <c:if test="${projectAppSteplistInfo.stepLevel eq '7'}">
						    <div class="col-md-3 tac mt-22">
						       <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
						    	<p class="access_ing">&#133</p>
						    	<li class="fix_subtitle">진행중</li>
						    	<li class="fix_subtitle2">(검토)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
						    	<p class="access_ing">&#10003</p>
						    	<li class="fix_subtitle">승인완료</li>
						    	<li class="fix_subtitle2">(검토)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
						    	<p class="access_reject">&#8630</p>
						    	<li class="fix_subtitle fc_red"  onclick="projectRejectHits()">반려</li>
						    	<li class="fix_subtitle2 fc_red">(검토)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
						    	<p class="access_blank"></p>
						    	<li class="fix_subtitle">대기</li>
						    	<li class="fix_subtitle2">(검토)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<li class="fix_date">${projectAppSteplistInfo.apprvDatetime}</li>
						    </div>
						    </c:if>

						     <c:if test="${projectAppSteplistInfo.stepLevel eq '8'}">
						    <div class="col-md-3 tac mt-22">
						       <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
						    	<p class="access_ing">&#133</p>
						    	<li class="fix_subtitle">진행중</li>
						    	<li class="fix_subtitle2">(승인)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
						    	<p class="access_ing">&#10003</p>
						    	<li class="fix_subtitle">승인완료</li>
						    	<li class="fix_subtitle2">(승인)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
						    	<p class="access_reject">&#8630</p>
						    	<li class="fix_subtitle fc_red"  onclick="projectRejectHits()">반려</li>
						    	<li class="fix_subtitle2 fc_red">(승인)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvUserName}</li>
						    	</c:if>
						    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
						    	<p class="access_blank"></p>
						    	<li class="fix_subtitle">대기</li>
						    	<li class="fix_subtitle2">(승인)</li>
						    	<li class="fix_dept">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
						    	<li class="fix_name">${projectAppSteplistInfo.apprvScheduleUserName}</li>
						    	</c:if>
						    	<li class="fix_date">${projectAppSteplistInfo.apprvDatetime}</li>
						    </div>
						    </c:if>
						    </c:forEach>
						  </div>
						  <!-- 2023 승인부서 끝 -->
						</div>
				</div>
				<!-- 2023 New 승인  끝-->















					<div class="clear"></div>



	<%-- 			<table class="tableH4">
            		<colgroup>
            			<col width="10%"/>
            			<col width="23%"/>
            			<col width="10%"/>
            			<col width="23%"/>
            			<col width="10%"/>
            			<col width="23%"/>
            			<col width="10%"/>
            			<col width="23%"/>
            		</colgroup>
            		<tbody>
            			<tr>
            				<th colspan="8" class="f18">
								<span class="pid">${projectInfo.projectName}</span>
            					<h3 class="pname dpin ml20">${projectInfo.projectAlias}</h3>
            				</th>
            			</tr>
            			<tr>
            				<td class="point tac">본부</td>
            				<td>${fn:split(projectInfo.deptName2,'/')[1]}</td>
            				<td class="point tac">처(실)</td>
            				<td>${fn:split(projectInfo.deptName2,'/')[2]}</td>
            				<td class="point tac">부서</td>
            				<td>${fn:split(projectInfo.deptName2,'/')[3]}</td>
            				<td class="point tac">담당자   </td>
            				<td>${projectInfo.managerName}(${projectInfo.managerTel})</td>
            			</tr>
            			<tr>
            				<td class="point tac">첨부파일 </td>
            				<td colspan="7">
            				    	<!-- 첨부파일 시작 -->
								<div class="fileList">
								<div class="wrap">
									<ul class="m-t-10">
										<c:forEach items="${file}" var="filelist" varStatus="status" >
											<li>
												<span class="f14 fc11">${filelist.fileName}</span>
												<span class="f14 fc66">(${filelist.fileTranSize}) </span>
												<a href="${contextPath}/mbr/cmm/file/download/${filelist.fileId}" class="btn_download"></a>
											</li>
										</c:forEach>
									</ul>
								</div>
							</div>
					    <!-- 첨부파일 끝 -->
            				</td>
            			</tr>
            		</tbody>
            	</table> 2023 이전소스 --%>


				 <div class="col-md-12 pl0 pr0">
            	   <div class="col-md-6 pl0">
            	     <label class="f16 mb10 f500">프로젝트 ID </label>
            	     <input type="text" class="form-control"  id="projeectAlias" disabled="disabled" value="${projectInfo.projectName}"/>
            	   </div>
            	   <div class="col-md-6 pr0">
            	   <label class="f16 mb10 f500">프로젝트명 </label>
            	   <input type="text"  class="form-control"   disabled="disabled" value="${projectInfo.projectAlias}"/>
            	   </div>
            	   <div class="clear"></div>
            	   <div class="project_dd">
	            	    <div class="sub4"  style="float:left;">
	            	       <label class="f16 mb10">본부 </label>
	            	       <input type="text"  class="form-control"  disabled="disabled"  value="${fn:split(projectInfo.deptName2,'/')[1]}"/>
	            	    </div>
	            	    <div class="sub4">
	            	       <label class="f16 mb10">처(실) </label>
	            	       <input type="text"  class="form-control"  disabled="disabled"    value="${fn:split(projectInfo.deptName2,'/')[2]}"/>
            	  		</div>
            	  		<div class="sub4">
	            	       <label class="f16 mb10">부서 </label>
	            	       <input type="text"  class="form-control"  disabled="disabled"  value="${fn:split(projectInfo.deptName2,'/')[3]}"/>
            	  		</div>
            	  		<div class="sub4" style="margin-right:0;float:right;">
	            	       <label class="f16 mb10">담당자</label>
	            	       <input type="text"  class="form-control"  disabled="disabled"   value='${projectInfo.customerName}(${projectInfo.managerTel})' />
            	  	   </div>
            	     </div>

            	    <div class="col-md-12 pl0 pr0 mt20">
            	        <div class="f16 mb10 f500">첨부파일 </div>
            	        <c:forEach items="${file}" var="filelist" varStatus="status" >
            	        <div class="col-md-8 pl0 mt5">
            	       <input type="text"  class="form-control"  disabled="disabled"  value="${filelist.fileName} / (${filelist.fileTranSize})"/>
            	       </div>
            	       <div class="col-md-4 pl0 mt5" style="margin-top:0px;">
            	       <a href="${contextPath}/mbr/cmm/file/download/${filelist.fileId}" class="btn_rect"><span class="rotate-270"> &#8677; </span></a>
            	      </div>
            	       </c:forEach>
					</div>

            	   </div>

					<div class="clear"></div>


					<!-- 신청현황  블럭 시작 -->
					<c:set var="amount" value="" />

					<h4 class="sub_title mt30"> 신청 내역  </h4>


				<%-- 	<!-- 2023 이전소스  -->
					<div>
						<table class="sumtableV">
					 		<colgroup>
								 <col width="*">
								 <col width="20%">
								 <col width="20%">
								 <col width="20%">
								<!--  <col width="20%"> -->
							 </colgroup>
							<thead>
								<tr>
									<th>자원구분</th>
									<th>신규</th>
									<th>변경</th>
									<th>삭제</th>
								</tr>
							</thead>

							<tbody>
								<tr>
									<td class="tal">기본자원 (가상서버)</td>
									<td>${vmNew}</td>
									<td>${vmCh}</td>
									<td>${vmEx}</td>
									<!-- <td class="tar fc-blue pr90"><fmt:formatNumber value="${vmAmount}" pattern="#,###"/><span class="fc11">&nbsp;원</span></td> -->
								</tr>
								<tr>
									<td class="tal">부가자원 (블록디스크)</td>
									<td>${subNew}</td>
									<td>${subCh}</td>
									<td>${subEx}</td>
									<!-- <td class="tar fc-blue pr90"><fmt:formatNumber value="${subAmount}" pattern="#,###"/><span class="fc11">&nbsp;원</span></td> -->
								</tr>
								<tr>
									<td class="tal">서비스	(계정관리/보안관제/백업관리/SW설치/디스크관리/오토스케일/재배포)</td>
									<td>${servNew}</td>
									<td>${servCh}</td>
									<td>${servEx}</td>
									<!-- <td class="tar fc-blue pr90"><fmt:formatNumber value="${servmount}" pattern="#,###"/><span class="fc11">&nbsp;원</span></td> -->
								</tr>
								<tr>
									<td class="tal">어플리케이션</td>
									<td>${appNew}</td>
									<td>${appCh}</td>
									<td>${appEx}</td>
									<!-- <td class="tar fc-blue pr90"><fmt:formatNumber value="${servmount}" pattern="#,###"/><span class="fc11">&nbsp;원</span></td> -->
								</tr>
							</tbody>
						</table>
						<div class="appTotal dpno">
							<span class="llabel nanumR">총합계<span class="txttotal">(신규:${totCnt}개)</span></span>
							<span class="totalwon nanumR"><fmt:formatNumber value="${totAmount}" pattern="#,###"/><span class="unit">&nbsp;원</span></span>
						</div>
					</div>
					<!-- 신청현황  블럭 끝 -->

					<!-- begin page-body 상세보기  -->
					<div class="detailView">
						<span class="f18 fc11">상세</span>
						<span class="icon"></span>
					</div>


					<div class="detailVeiwArea" >
						<!-----기본자원 시작------->
						<h4 class="mb10 mt20 f22"> 기본자원  </h4>
						<c:if test='${orderviewList.size() eq 0}'>
            				<h5 class=" box_grey1 tac p50 fc11 fn"> <img src="${apachePath}/resources/assets/img/icon_no.png"/> 가상서버 신청 내역이 없습니다</h5>
						</c:if>

						<c:if test='${orderviewList.size() ne 0}'>
				 			<div class="inbox101 pl30 pr30 pt20 pb30">
				 				<div>
						 			<div>
						 				<h5 class="subtitle">가상서버</h5>
										<div class="panel mb0">
											<div>
								    			<!--------자원정보 table 시작---------->
												<table class="tableV">
													<colgroup>
														 <col width="10%">
														 <col width="10%">
														 <col width="10%">
														 <col width="*">
														 <col width="12%">
														 <col width="10%">
														 <col width="10%">
														 <col width="8%">
													</colgroup>

													<thead>
														<tr class="skyblue">
														    <th>요청유형</th>
														    <th>클라우드</th>
															<th>서비스희망일시</th>
															<th>가상서버명</th>
															<th>네트워크 대역값</th>
															<th>CPU (Core)</th>
															<th>MEM (GB)</th>
															<th>상세</th>
														</tr>
													</thead>

													<tbody>
													<c:forEach items="${orderviewList}" var="orderviewList" varStatus="status" >
													<c:choose>
														<c:when test="${status.index%2 eq 0 }">
														<tr class="odd">
														</c:when>
														<c:otherwise>
														<tr class="even">
														</c:otherwise>
														</c:choose>
															<td class="tac"> ${orderviewList.requestName} </td>
															<td>${orderviewList.cloudName}</td>
															<td class="tac">
																<c:choose>
																	<c:when test="${orderviewList.onDemandFlag eq 'N'}">
																	${orderviewList.applyDatetime}
																	</c:when>
																	<c:otherwise>
																		승인완료 후 생성
																	</c:otherwise>
																</c:choose>
															</td>
															<td class="tal"> ${orderviewList.hostnameAlias} </td>
															<td class="tal"> ${orderviewList.defaultNetworkName} </td>

															<c:if test="${orderviewList.requestName eq '신규' || orderviewList.requestName eq '해지'}">
															<td class="tar"> ${orderviewList.vcpus} </td>
															<td class="tar"> ${orderviewList.memGb} </td>
															</c:if>
															<c:if test="${orderviewList.requestName eq '변경'}">
															<td class="tar"> ${orderviewList.beforeVcpus} <i class="fa fa-arrow-right fc99"></i> ${orderviewList.changeVcpus} </td>
															<td class="tar"> ${orderviewList.beforeMemGb}  <i class="fa fa-arrow-right fc99"></i> ${orderviewList.changeMemGb}</td>
															</c:if>
															<!-- <td class="tar fc-blue f16 fb">
																<fmt:formatNumber value="${orderviewList.amount}" pattern="#,###"/>
																<c:set var="amount" value="${amount + orderviewList.amount}" />
															</td> -->
															<td class="tac">

															 	   <%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>

					  												<button type="button" class="cbton bton_lblue" onclick="openPopserver('${orderviewList.fixedIps}','${orderviewList.bakupFixedIps}','${orderviewList.projectName}','${orderviewList.vmImageName}','${fn:replace(orderviewList.description,newLineChar,br)}','${orderviewList.defaultNetworkName}','${orderviewList.requestType}','${orderviewList.beforeVcpus}','${orderviewList.changeVcpus}','${orderviewList.beforeMemGb}','${orderviewList.changeMemGb}','${orderviewList.projectAlias}', '${orderviewList.hostnameAlias}', '${orderviewList.hostname}', '${orderviewList.requestName}', '${orderviewList.hourlyFlag}', '${orderviewList.onDemandFlag}', '${orderviewList.applyDatetime}', '${orderviewList.amount}', '${orderviewList.vcpus}', '${orderviewList.memGb}', '${orderviewList.vmDiskGb}', '${orderviewList.cloudName}')" >
					  												<i class="fa fa-search"></i></button>
																<input type="hidden" id="c${orderviewList.orderProductSeq}" name="c${orderviewList.orderProductSeq}" value="0" />
															</td>
														</tr>
														<tr id="v${orderviewList.orderProductSeq}" name="v${orderviewList.orderProductSeq}" style="display:none">
															<td colspan="8">
											     				<div>
										         					<table class="tableD4">
												 						<colgroup>
																			 <col width="33.3%">
																			 <col width="33.3%">
																			 <col width="33.3%">
												 						</colgroup>

												 						<thead>
												 							<tr class="skyblue">
												 								<th>CPU</th>
												 								<th>MEM</th>
												 								<th>DISK</th>
												 							</tr>
												 						</thead>

												 						<tbody>
																			 <tr>
												 								<td> ${orderviewList.vcpus} Core </td>
												 								<td> ${orderviewList.memGb} GB </td>
																				<td> ${orderviewList.vmDiskGb} GB </td>
																			</tr>
												 							<tr>
												 								<td class="blue">추가요청사항</td>
												 								<td colspan="2" class="tal pl20">
												 									${orderviewList.description}
												 								</td>
												 							</tr>
												 						</tbody>
												 					</table>
													 			</div>
															</td>
														</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:if>
						<!----- 기본자원 끝 ------->

						<!----- 부가자원 시작 ------->
						<h4 class="mb10 mt20 f22"><span class="vbar"></span>  부가자원  </h4>
						<c:set value="useitem" var="substr"/>
						<c:choose>
							<c:when test="${orderDiskviewList.size() ne 0}">
								<c:set var="substr" value="" />
							</c:when>
							<c:when test="${orderNasviewList.size() ne 0}">
								<c:set var="substr" value="" />
							</c:when>
							<c:when test="${orderLbviewList.size() ne 0}">
								<c:set var="substr" value="" />
							</c:when>
							<c:when test="${getBasketSnlistvo.size() ne 0}">
								<c:set var="substr" value="" />
							</c:when>
							<c:when test="${orderIpviewList.size() ne 0}">
								<c:set var="substr" value="" />
							</c:when>
						</c:choose>
						<c:if test='${substr ne ""}'>
							<h5 class="box_grey1 tac p50 fc11 fn"> <img src="${apachePath}/resources/assets/img/icon_no.png"/>  부가자원 신청 내역이 없습니다</h5>
						</c:if>

						<c:if test='${substr eq ""}'>
							<div class="inbox101 pl30 pr30 pt20 pb30">
								<!----- 부가자원-블록디스크 시작 ------->
								<c:if test='${orderDiskviewList.size() ne 0}'>
							 		<div>
							 			<div>
							 				<h5 class="subtitle"> 블록디스크</h5>
											<div class="panel mb0">
												<div>
													<table class="tableV">
										 				<colgroup>
															 <col width="10%">
															 <col width="10%">
															 <col width="15%">
															 <col width="10%">
															 <col width="*">
															 <col width="15%">
															 <col width="8%">
										 				</colgroup>

														<thead>
													    	<tr  class="skyblue">
															    <th>요청유형</th>
															    <th>클라우드</th>
																<th>서비스희망일시</th>
																<th>디스크명</th>
																<th>크기 (GB)</th>
																<th>가상서버</th>
																<th>상세</th>
															</tr>
														</thead>

														<tbody>
														<c:forEach items="${orderDiskviewList}" var="orderDiskviewList" varStatus="status" >
														<c:choose>
															<c:when test="${status.index%2 eq 0 }">
															<tr class="odd">
															</c:when>
															<c:otherwise>
															<tr class="even">
															</c:otherwise>
															</c:choose>
																<td class="tac"> ${orderDiskviewList.requestName} </td>
																<td class="tac"> ${orderDiskviewList.cloudName} </td>
																<td class="tac">
																	<c:choose>
																		<c:when test="${orderDiskviewList.onDemandFlag eq 'N'}">
																			${orderDiskviewList.applyDatetime}
																		</c:when>
																		<c:otherwise>
																			승인완료 후 생성
																		</c:otherwise>
																	</c:choose>
																</td>
																<td class="tal"> ${orderDiskviewList.diskName} </td>

														    	<c:if test="${orderDiskviewList.requestName eq '신규' || orderDiskviewList.requestName eq '해지'}">
															     <td class="tar"> ${orderDiskviewList.diskGb}  </td>
															    </c:if>
															    <c:if test="${orderDiskviewList.requestName eq '변경'}">
														    	<td class="tar"> ${orderDiskviewList.beforeDiskGb}  <i class="fa fa-arrow-right fc99"></i> ${orderDiskviewList.changeDiskGb}  </td>
															    </c:if>
																<td class="tal"> ${orderDiskviewList.hostnameAlias} </td>
																<!--<td class="tar fc-blue f16 fb">
																	<fmt:formatNumber value="${orderDiskviewList.amount}" pattern="#,###"/>
																	<c:set var="amount" value="${amount + orderDiskviewList.amount}" />
																</td>  -->
																<td class="tac">

																		<button type="button" class="cbton bton_lblue" onclick="openPopdisk('${orderDiskviewList.projectName}','${orderDiskviewList.diskType}','${orderDiskviewList.diskName}','${orderDiskviewList.description}','${orderDiskviewList.requestType}','${orderDiskviewList.beforeDiskGb}','${orderDiskviewList.changeDiskGb}','${orderDiskviewList.projectAlias}', '${orderDiskviewList.hostname}', '${orderDiskviewList.hostnameAlias}', '${orderDiskviewList.requestName}', '${orderDiskviewList.hourlyFlag}', '${orderDiskviewList.onDemandFlag}', '${orderDiskviewList.applyDatetime}', '${orderDiskviewList.diskGb}', '${orderDiskviewList.amount}', '${orderDiskviewList.cloudName}')" >
																		<i class="fa fa-search"></i></button>
																		<input type="hidden" id="c${orderDiskviewList.orderProductSeq}" name="c${orderDiskviewList.orderProductSeq}" value="0" />

																</td>
															</tr>
															<tr id="v${orderDiskviewList.orderProductSeq}" name="v${orderDiskviewList.orderProductSeq}" style="display:none">
																<td colspan="8">
												     				<div>
											         					<table class="tableD4">
													 						<colgroup>
																				 <col width="50%">
																				 <col width="50%">
																			 </colgroup>
													 						<thead>
													 							<tr  class="skyblue">
													 								<th>디스크이름</th>
													 								<th>용량</th>
													 							</tr>
													 						</thead>
													 						<tbody>
													 							<tr>
													 								<td> ${orderDiskviewList.diskName} </td>
													 								<td> ${orderDiskviewList.diskGb} GB </td>
													 						</tbody>
													 					</table>
													 				</div>
																</td>
															</tr>
														</c:forEach>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
								</c:if>
								<!-----부가자원-블록디스크  끝 ------->

								<!----- 부가자원-NAS 시작------->
								<c:if test='${orderNasviewList.size() ne 0}'>
									 <div>
									 	<div>
											<h5 class="subtitle"> NAS</h5>
											<div class="panel mb0">
												<div>
													<table class="sumtableV" summary="자원 신청현황 자원정보">
												 		<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 가상서버, 신청금액(원) 상세로 구성</caption>
														<colgroup>
															<col width="80px">
															<col width="80px">
															<col width="120px">
															<col width="*">
															<col width="180px">
															<col width="120px">
															<col width="80px">
														</colgroup>

														<thead>
															<tr  class="skyblue">
																<th scope="col">요청유형</th>
																<th scope="col">과금단위</th>
																<th scope="col">서비스희망일시</th>
																<th scope="col">프로젝트</th>
																<th scope="col">가상서버</th>
																<th scope="col">신청금액(원)</th>
																<th scope="col">상세</th>
															</tr>
														</thead>

														<tbody>
														<c:forEach items="${orderNasviewList}" var="orderNasviewList" varStatus="status" >
														<c:choose>
														<c:when test="${status.index%2 eq 0 }">
															<tr class="odd">
														</c:when>
														<c:otherwise>
															<tr class="even">
														</c:otherwise>
														</c:choose>
																<td class="tac"> ${orderNasviewList.requestName} </td>
																<td class="tac">
																	<c:choose>
																		<c:when test="${orderNasviewList.hourlyFlag eq 'N'}">
																			월
																		</c:when>
																		<c:otherwise>
																			시간
																		</c:otherwise>
																	</c:choose>
																</td>
																<td class="tac">
																	<c:choose>
																		<c:when test="${orderNasviewList.onDemandFlag eq 'N'}">
																			${orderNasviewList.applyDatetime}
																		</c:when>
																		<c:otherwise>
																			승인완료 후 생성
																		</c:otherwise>
																	</c:choose>
																</td>
																<td class="tal"> ${orderNasviewList.projectAlias} </td>
																<td class="tal"> ${orderNasviewList.vmName} </td>
																<td class="tar fc-blue f16 fb">
																	<fmt:formatNumber value="${orderNasviewList.amount}" pattern="#,###"/>
																	<c:set var="amount" value="${amount + orderNasviewList.amount}" />
																</td>
																<td class="tac">
																	<button type="button" class="tac mt5 table-search" onclick="openPopNas('${orderNasviewList.projectAlias}', '${orderNasviewList.nasName}', '${orderNasviewList.vmName}', '${orderNasviewList.requestName}', '${orderNasviewList.hourlyFlag}', '${orderNasviewList.onDemandFlag}', '${orderNasviewList.applyDatetime}', '${orderNasviewList.nasGb}', '${orderNasviewList.amount}')" ><span></span></button>
																	<input type="hidden" id="c${orderNasviewList.orderProductSeq}" name="c${orderNasviewList.orderProductSeq}" value="0" />
																</td>
															</tr>
															<tr id="v${orderNasviewList.orderProductSeq}" name="v${orderNasviewList.orderProductSeq}" style="display:none">
																<td colspan="7">
													     			<div>
												         				<table class="tableD4">
														 					<colgroup>
																			 	<col width="50%">
																			 	<col width="50%">
																			 </colgroup>
														 					<thead>
														 						<tr  class="skyblue">
														 							<th>이름</th>
														 							<th>용량</th>
														 						</tr>
														 					</thead>
														 					<tbody>
														 						<tr>
														 							<td> ${orderNasviewList.nasName} </td>
																					<td> ${orderNasviewList.nasGb} GB </td>
														 						</tr>
														 					</tbody>
														 				</table>
														 			</div>
																</td>
															</tr>
														</c:forEach>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
								</c:if>
								<!----- 부가자원-NAS 끝 ------->
								<!----- 부가자원-로드밸런서 시작------->
								<c:if test='${orderSnviewList.size() ne 0}'>
						 			<div>
			 							<div>
			 								<h5 class="subtitle"> 스냅샷</h5>
											<div class="panel mb0">
												<div>
				    								<table class="sumtableV" summary="자원 신청현황 자원정보">
														<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 신청금액(원), 상세로 구성</caption>
														 <colgroup>
															    <col width="8%">
														 		<col width="8%">
														 		<col width="15%">
														 		<col width="10%">
														 		<col width="70px">
														 </colgroup>
														<thead>
															<tr class="skyblue">
																<th scope="col">요청유형</th>
																<th scope="col">가상서버</th>
																<th scope="col">스냅샷명</th>
																<th scope="col">디스크명</th>
																<th scope="col">상세</th>
															</tr>
														</thead>
														<tbody>
														<c:forEach items="${orderSnviewList}" var="orderSnviewList" varStatus="status" >
														<c:choose>
														<c:when test="${status.index%2 eq 0 }">
															<tr class="odd">
														</c:when>
														<c:otherwise>
															<tr class="even">
														</c:otherwise>
														</c:choose>
																<td class="tac">
																	<c:if test="${orderSnviewList.requestName eq '신규'}">
																		신규
																	</c:if>
																	<c:if test="${orderSnviewList.requestName eq '변경'}">
																		적용
																	</c:if>
																	<c:if test="${orderSnviewList.requestName eq '해지'}">
																		삭제
																	</c:if>
																</td>
																<td class="tac">
																	${orderSnviewList.hostname}
																</td>
																<td class="tac">
																	${orderSnviewList.snapshotName}
																</td>
																<td class="tac">
																	${orderSnviewList.diskAlias}
																</td>
																<td class="tac">
																 	<button type="button" class="tac mt5 table-search" onclick="openPopSn('${orderSnviewList.projectAlias}', '${orderSnviewList.snapshotName}', '${orderSnviewList.hostname}', '${orderSnviewList.diskAlias}','${orderSnviewList.description}','${orderSnviewList.applyDatetime}','${orderSnviewList.onDemandFlag}','${orderSnviewList.requestName}')" ><span></span></button>
																	<input type="hidden" id="c${orderSnviewList.orderProductSeq}" name="c${orderSnviewList.orderProductSeq}" value="0" />
																</td>
															</tr>
														</c:forEach>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
								</c:if>
								<!----- 부가자원-로드밸런서 끝------->
								<!----- 부가자원-로드밸런서 시작------->
								<c:if test='${orderLbviewList.size() ne 0}'>
						 			<div>
			 							<div>
			 								<h5 class="subtitle"> 로드밸런스</h5>
											<div class="panel mb0">
												<div>
				    								<table class="sumtableV" summary="자원 신청현황 자원정보">
														<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 신청금액(원), 상세로 구성</caption>
														 <colgroup>
															 <col width="8%">
														 		<col width="8%">
														 		<col width="15%">
														 		<col width="10%">
														 		<col width="8%">
														 		<col width="70px">
														 </colgroup>
														<thead>
															<tr class="skyblue">
																<th scope="col">요청유형</th>
																<th scope="col">로드밸런스명</th>
																<th scope="col">PORT</th>
																<th scope="col">method</th>
																<th scope="col">protocol</th>
																<th scope="col">상세</th>
															</tr>
														</thead>
														<tbody>
														<c:forEach items="${orderLbviewList}" var="orderLbviewList" varStatus="status" >
														<c:choose>
														<c:when test="${status.index%2 eq 0 }">
															<tr class="odd">
														</c:when>
														<c:otherwise>
															<tr class="even">
														</c:otherwise>
														</c:choose>
																<td class="tac">
																	<c:if test="${orderLbviewList.requestName eq '신규'}">
																		신규
																	</c:if>
																	<c:if test="${orderLbviewList.requestName eq '변경'}">
																		변경
																	</c:if>
																	<c:if test="${orderLbviewList.requestName eq '해지'}">
																		삭제
																	</c:if>
																</td>
																<td class="tac">
																	${orderLbviewList.loadbalancerName}
																</td>
																<td class="tac">
																	${orderLbviewList.port}
																</td>
																<td class="tac"> ${orderLbviewList.method} </td>
																<td class="tac">
																	${orderLbviewList.protocol}
																</td>
																<td class="tac">
																 	<button type="button" class="tac mt5 table-search" onclick="openPopLb('${orderLbviewList.projectAlias}', '${orderLbviewList.loadbalancerName}', '${orderLbviewList.protocol}', '${orderLbviewList.method}', '${orderLbviewList.ip}', '${orderLbviewList.port}','${orderLbviewList.loadbalancerVm}')" ><span></span></button>
																	<input type="hidden" id="c${orderLbviewList.orderProductSeq}" name="c${orderLbviewList.orderProductSeq}" value="0" />
																</td>
															</tr>
															<tr id="v${orderLbviewList.orderProductSeq}" name="v${orderLbviewList.orderProductSeq}" style="display:none">
																<td colspan="7">
																	<div>
														         		<table class="tableD4">
																 			<colgroup>
																				<col width="20%">
																				<col width="20%">
																				<col width="20%">
																				<col width="20%">
																				<col width="20%">
																			</colgroup>

																 			<thead>
																				<tr class="skyblue">
																					<th>가상서버</th>
																					<th>로드밸런서이름</th>
																					<th>Protocal</th>
																					<th>Method</th>
																					<th>Monitor Type</th>
																				</tr>
																 			</thead>
																 			<tbody>
																 				<tr>
																 					<td>${orderLbviewList.loadbalancerVm}</td>
																					 <td>${orderLbviewList.loadbalancerName}</td>
																					 <td>${orderLbviewList.protocolName}</td>
																					 <td>${orderLbviewList.methodName}</td>
																					 <td>${orderLbviewList.monitorType}</td>
																 				</tr>
																 			</tbody>
																 		</table>
																 	</div>
																</td>
															</tr>
														</c:forEach>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
								</c:if>
								<!----- 부가자원-로드밸런서 끝------->

								<!----- 부가자원-공인IP 시작------->
								<c:if test='${orderIpviewList.size() ne 0}'>
									<div>
								 		<h5 class="subtitle"> 공인IP</h5>
										<div class="panel mb0">
											<div>
												<table class="sumtableV" summary="자원 신청현황 자원정보">
													<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 연결용도, 신청금액(원), 상세로 구성</caption>
											 		<colgroup>
														<col width="80px">
														<col width="80px">
														<col width="120px">
														<col width="*">
														<col width="180px">
														<col width="120px">
														<col width="80px">
													</colgroup>
													<thead>
														<tr class="skyblue">
															<th scope="col">요청유형</th>
															<th scope="col">과금단위</th>
															<th scope="col">서비스희망일시</th>
															<th scope="col">프로젝트</th>
															<th scope="col">연결용도</th>
															<th scope="col">신청금액(원)</th>
															<th scope="col">상세</th>
														</tr>
													</thead>

													<tbody>
													<c:forEach items="${orderIpviewList}" var="orderIpviewList" varStatus="status" >
													<c:choose>
													<c:when test="${status.index%2 eq 0 }">
														<tr class="odd">
													</c:when>
													<c:otherwise>
														<tr class="even">
													</c:otherwise>
													</c:choose>
															<td class="tac"> ${orderIpviewList.requestName} </td>
															<td class="tac">
																<c:choose>
																	<c:when test="${orderIpviewList.hourlyFlag eq 'N'}">
																		월
																	</c:when>
																	<c:otherwise>
																		시간
																	</c:otherwise>
																</c:choose>
															</td>
															<td class="tac">
																<c:choose>
																	<c:when test="${orderIpviewList.onDemandFlag eq 'N'}">
																		${orderIpviewList.applyDatetime}
																	</c:when>
																	<c:otherwise>
																		승인완료 후 생성
																	</c:otherwise>
																</c:choose>
															</td>
															<td class="tal"> ${orderIpviewList.projectAlias} </td>
															<td class="tal"> ${orderIpviewList.description} </td>
															<td class="tar fc-blue f16 fb">
																<fmt:formatNumber value="${orderIpviewList.amount}" pattern="#,###"/>
																<c:set var="amount" value="${amount + orderIpviewList.amount}" />
															</td>
															<td class="tac">
																<button type="button" class="tac mt5 table-search" onclick="openPopIp('${orderIpviewList.projectAlias}', '${orderIpviewList.description}', '${orderIpviewList.requestName}', '${orderIpviewList.hourlyFlag}', '${orderIpviewList.onDemandFlag}', '${orderIpviewList.applyDatetime}', '${orderIpviewList.amount}')" ><span></span></button>
																<input type="hidden" id="c${orderIpviewList.orderProductSeq}" name="c${orderIpviewList.orderProductSeq}" value="0" />
															</td>
														</tr>

														<tr id="v${orderIpviewList.orderProductSeq}" name="v${orderIpviewList.orderProductSeq}" style="display:none">
															<td colspan="7">
													     		<div>
												         			<table class="tableD4" summary="자원 신청현황 자원이미지">
												         				<caption>게시판 목록 : 자원이미지, 비고로 구성</caption>
												         				<colgroup>
																			<col width="150px">
																			<col width="*">
																		</colgroup>
														 				<thead>
														 					<tr class="skyblue">
														 						<th scope="col">자원이미지</th>
														 						<th scope="col">비고</th>
														 					</tr>
														 				</thead>
														 				<tbody>
														 					<tr>
														 						<td> <img src="${wasPath}/mbr/cmm/file/download/${orderIpviewList.imageName}" class="w80"/></td>
														 						<td class="tal"> ${orderIpviewList.description} </td>
														 					</tr>
														 				</tbody>
														 			</table>
														 		</div>
															</td>
														</tr>
													</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</c:if>
								<!----- 부가자원-공인IP 끝------->

							</div>
						</c:if>
						<!-----부가자원 끝---------->

						<!-----서비스  시작------->
						<h4 class="mb10 mt20 f22"><span class="vbar"></span>  서비스 </h4>
						<c:set value="useitem" var="subser"/>
						<c:choose>
							<c:when test="${orderBakviewList.size() ne 0}">
								<c:set var="subser" value="" />
							</c:when>
							<c:when test="${orderServiceviewList.size() ne 0}">
								<c:set var="subser" value="" />
							</c:when>
							<c:when test="${getReqScmOrderList.size() ne 0}">
								<c:set var="subser" value="" />
							</c:when>
							<c:when test="${getReqMcaOrderList.size() ne 0}">
								<c:set var="subser" value="" />
							</c:when>
							<c:when test="${getReqSerOrderList.size() ne 0}">
								<c:set var="subser" value="" />
							</c:when>
						</c:choose>
						<c:if test='${subser ne ""}'>
							<h5 class="box_grey1 tac p50 fc11 fn"> <img src="${apachePath}/resources/assets/img/icon_no.png"/> 서비스 신청 내역이 없습니다 </h5>
						</c:if>
						<c:if test='${subser eq ""}'>
							<div class="inbox101 pl30 pr30 pt20 pb30">
								<!----- 서비스-공통 시작 ------->
								<c:if test='${orderServiceviewList.size() ne 0}'>
									<div>
										<div>
											<h5 class="subtitle"> 서비스</h5>
											<div class="panel mb0">
												<div>
													<table class="tableV">

														<colgroup>
															<col width="10%">
															<col width="10%">
															<col width="8%">
															<col width="10%">
															<col width="*">
														<!-- <col width="15%"> -->
															<col width="8%">
														</colgroup>
														<thead>
															<tr class="skyblue">
																<th>요청유형</th>
																<th>클라우드</th>
																<th>서비스희망일시</th>
															    <th>서비스  유형</th>
																<th>서비스명</th>
																<th>가상서버</th>
															<!-- <th>신청금액(원)</th>-->
																<th>상세</th>
															</tr>
														</thead>
														<tbody>
														<c:forEach items="${orderServiceviewList}" var="orderServiceviewList" varStatus="status" >
														<c:choose>
														<c:when test="${status.index%2 eq 0 }">
															<tr class="odd">
														</c:when>
														<c:otherwise>
															<tr class="even">
														</c:otherwise>
														</c:choose>
																<td class="tac"> ${orderServiceviewList.requestName} </td>
																<td class="tac"> ${orderServiceviewList.cloudName} </td>
																<td class="tac">
																	<c:choose>
																		<c:when test="${orderServiceviewList.onDemandFlag eq 'N'}">
																			${orderServiceviewList.applyDatetime}
																		</c:when>
																		<c:otherwise>
																			승인완료 후 생성
																		</c:otherwise>
																	</c:choose>
																</td>
																<td class="tal"> ${orderServiceviewList.serviceTypeName} </td>
																<td class="tal"> ${orderServiceviewList.serviceName} </td>

																<c:choose>
																	<c:when test="${orderServiceviewList.serviceType eq '10'}"><td class="tal"> ${orderServiceviewList.appName} </td></c:when>
																	<c:when test="${orderServiceviewList.serviceType eq '11'}"><td class="tal"> ${orderServiceviewList.appName} </td></c:when>
																	<c:otherwise><td class="tal"> ${orderServiceviewList.hostnameAlias} </td></c:otherwise>
																</c:choose>

																<!-- <td class="tar fc-blue f16 fb">
																	<fmt:formatNumber value="${orderServiceviewList.amount}" pattern="#,###"/>
																	<c:set var="amount" value="${amount + orderServiceviewList.amount}" />
																</td> -->
																<td class="tac">

																 	<%pageContext.setAttribute("newLineChar","\r\n"); pageContext.setAttribute("br","<br/>");%>

																<c:choose>
																	<c:when test="${orderServiceviewList.serviceType eq '10'}"><button type="button" class="cbton bton_lblue" onclick="openPopService('${orderServiceviewList.projectName}','${fn:replace(fn:replace(fn:escapeXml(orderServiceviewList.description),newLineChar,br),'','&nbsp;')}','${orderServiceviewList.serviceProductName}','${orderServiceviewList.serviceName}','${orderServiceviewList.serviceTypeName}','${orderServiceviewList.projectAlias}', '${orderServiceviewList.appName}', '${orderServiceviewList.hostnameAlias}', '${orderServiceviewList.requestName}', '${orderServiceviewList.hourlyFlag}', '${orderServiceviewList.onDemandFlag}', '${orderServiceviewList.applyDatetime}', '${orderServiceviewList.amount}', '${orderServiceviewList.cloudName}')" ><i class="fa fa-search"></i></button></c:when>
																	<c:when test="${orderServiceviewList.serviceType eq '11'}"><td class="tal"><button type="button" class="cbton bton_lblue" onclick="openPopService('${orderServiceviewList.projectName}','${fn:replace(fn:replace(fn:escapeXml(orderServiceviewList.description),newLineChar,br),'','&nbsp;')}','${orderServiceviewList.serviceProductName}','${orderServiceviewList.serviceName}','${orderServiceviewList.serviceTypeName}','${orderServiceviewList.projectAlias}', '${orderServiceviewList.appName}', '${orderServiceviewList.hostnameAlias}', '${orderServiceviewList.requestName}', '${orderServiceviewList.hourlyFlag}', '${orderServiceviewList.onDemandFlag}', '${orderServiceviewList.applyDatetime}', '${orderServiceviewList.amount}', '${orderServiceviewList.cloudName}')" ><i class="fa fa-search"></i></button></td></c:when>
																	<c:otherwise><button type="button" class="cbton bton_lblue" onclick="openPopService('${orderServiceviewList.projectName}','${fn:replace(fn:replace(fn:escapeXml(orderServiceviewList.description),newLineChar,br),'','&nbsp;')}','${orderServiceviewList.serviceProductName}','${orderServiceviewList.serviceName}','${orderServiceviewList.serviceTypeName}','${orderServiceviewList.projectAlias}', '${orderServiceviewList.hostname}', '${orderServiceviewList.hostnameAlias}', '${orderServiceviewList.requestName}', '${orderServiceviewList.hourlyFlag}', '${orderServiceviewList.onDemandFlag}', '${orderServiceviewList.applyDatetime}', '${orderServiceviewList.amount}', '${orderServiceviewList.cloudName}')" ><i class="fa fa-search"></i></button></c:otherwise>
																</c:choose>

																	<input type="hidden" id="c${orderServiceviewList.orderProductSeq}" name="c${orderServiceviewList.orderProductSeq}" value="0" />
																</td>
															</tr>
															<tr id="v${orderServiceviewList.orderProductSeq}" name="v${orderServiceviewList.orderProductSeq}" style="display:none">
																<td colspan="7">
																	<div>
														         		<table class="tableD4">
																 			<colgroup>
																 				<col width="150px">
																 				<col width="*">
																 			</colgroup>
																 			<thead>
																 				<tr class="skyblue">
																 					<th>자원이미지</th>
																 					<th>비고</th>
																 				</tr>
																 			</thead>
																 			<tbody>
																 				<tr>
																 					<td> <img src="${wasPath}/mbr/cmm/file/download/${orderServiceviewList.imageName}" class="w80"/></td>
																 					<td class="tal"> ${orderServiceviewList.description} </td>
																 				</tr>
																 			</tbody>
																 		</table>
																 	</div>
																</td>
															</tr>
														</c:forEach>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
								</c:if>
								<!----- 서비스-공통 끝 ------->

								<!----- 서비스-백업 시작 ------->
								<c:if test='${orderBakviewList.size() ne 0}'>
<!-- 				 					<div>		   -->
<!-- 				 						<div> -->
<!-- 				 							<h5 class="subtitle"> 백업관리</h5> -->
<!-- 											<div class="panel mb0"> -->
<!-- 												<div> -->
<!-- 													<table class="sumtableV" summary="자원 신청현황 자원정보"> -->
														<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 가상서버, 신청금액(원), 상세로 구성</caption>
							 								<colgroup>
																<col width="80px">
																<col width="80px">
																<col width="120px">
																<col width="*">
																<col width="180px">
																<col width="120px">
																<col width="80px">
							 								</colgroup>
<!-- 															<thead> -->
<!-- 																<tr class="skyblue">							    -->
<!-- 																	<th scope="col">요청유형</th> -->
<!-- 																	<th scope="col">과금단위</th> -->
<!-- 																	<th scope="col">서비스희망일시</th> -->
<!-- 																	<th scope="col">프로젝트</th> -->
<!-- 																	<th scope="col">가상서버</th>							 -->
<!-- 																	<th scope="col">신청금액(원)</th> -->
<!-- 																	<th scope="col">상세</th> -->
<!-- 																</tr> -->
<!-- 															</thead> -->
<!-- 															<tbody> -->
															<c:forEach items="${orderBakviewList}" var="orderBakviewList" varStatus="status" >
															<c:choose>
															<c:when test="${status.index%2 eq 0 }">
<!-- 																<tr class="odd"> -->
															</c:when>
															<c:otherwise>
<!-- 																<tr class="even"> -->
															</c:otherwise>
															</c:choose>
																	<td class="tac"> ${orderBakviewList.requestName} </td>
<!-- 																	<td class="tac">									 -->
																		<c:choose>
																			<c:when test="${orderBakviewList.hourlyFlag eq 'N'}">
<!-- 																				월 -->
																			</c:when>
																			<c:otherwise>
<!-- 																				시간 -->
																			</c:otherwise>
																		</c:choose>
<!-- 																	</td> -->
<!-- 																	<td class="tac"> -->
																		<c:choose>
																			<c:when test="${orderBakviewList.onDemandFlag eq 'N'}">
																				${orderBakviewList.applyDatetime}
																			</c:when>
																			<c:otherwise>
<!-- 																				승인완료 후 생성 -->
																			</c:otherwise>
																		</c:choose>
<!-- 																	</td> -->
																	<td class="tal"> ${orderBakviewList.projectAlias} </td>
																	<td class="tal"> ${orderBakviewList.hostnameAlias} </td>
<!-- 																	<td class="tar fc-blue f16 fb"> -->
																		<fmt:formatNumber value="${orderBakviewList.amount}" pattern="#,###"/>
																		<c:set var="amount" value="${amount + orderBakviewList.amount}" />
<!-- 																	</td> -->
<!-- 																	<td class="tac">											 -->
																		<button type="button" class="tac mt5 table-search" onclick="openPopBack('${orderBakviewList.projectAlias}', '${orderBakviewList.hostname}', '${orderBakviewList.hostnameAlias}', '${orderBakviewList.requestName}', '${orderBakviewList.hourlyFlag}', '${orderBakviewList.onDemandFlag}', '${orderBakviewList.applyDatetime}', '${orderBakviewList.amount}')" ><span></span></button>
																		<input type="hidden" id="c${orderBakviewList.orderProductSeq}" name="c${orderBakviewList.orderProductSeq}" value="0" />
<!-- 																	</td> -->
<!-- 																</tr> -->
																<tr id="v${orderBakviewList.orderProductSeq}" name="v${orderBakviewList.orderProductSeq}" style="display:none">
<!-- 																	<td colspan="7"> -->
<!-- 																		<div> -->
<!-- 																			<table class="tableD4"> -->
																				<colgroup>
																		 			<col width="150px">
																		 			<col width="*">
																		 		</colgroup>
<!-- 																		 		<thead> -->
<!-- 																		 			<tr class="skyblue"> -->
<!-- 																		 				<th>자원이미지</th>  -->
<!-- 																		 				<th>비고</th> -->
<!-- 																		 			</tr> -->
<!-- 																		 		</thead> -->
<!-- 																		 		<tbody> -->
<!-- 																		 			<tr> -->
																		 				<td> <img src="${wasPath}/mbr/cmm/file/download/${orderBakviewList.imageName}" class="w80"/></td>
																		 				<td class="tal"> ${orderBakviewList.description} </td>
<!-- 																					</tr> -->
<!-- 																		 		</tbody> -->
<!-- 																		 	</table> -->
<!-- 																		 </div> -->
<!-- 																	</td> -->
<!-- 																</tr> -->
															</c:forEach>
<!-- 															</tbody> -->
<!-- 														</table> -->
<!-- 													</div> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
								</c:if>
								<!----- 서비스-백업 끝 ------->

								<!----- 서비스-형상관리 시작 ------->
								<c:if test='${getReqScmOrderList.size() ne 0}'>
<!-- 									<div> 		   -->
<!-- 			 							<div> -->
<!-- 			 								<h5 class="subtitle"> 형상관리서비스</h5> -->
<!-- 											<div class="panel mb0"> -->
<!-- 												<div> -->
<!-- 												    ------자원정보 table 시작-------- -->
<!-- 													<table class="sumtableV" summary="자원 신청현황 자원정보"> -->
														<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 신청금액(원), 상세로 구성</caption>
														<colgroup>
													 		<col width="80px">
															<col width="80px">
												 			<col width="240px">
													 		<col width="*">
												 			<col width="120px">
												 			<col width="80px">
												 		</colgroup>
<!-- 														<thead> -->
<!-- 															<tr class="skyblue">							     -->
<!-- 																<th scope="col">요청유형</th> -->
<!-- 																<th scope="col">과금단위</th> -->
<!-- 																<th scope="col">서비스희망일시</th> -->
<!-- 																<th scope="col">프로젝트</th>								 -->
<!-- 																<th scope="col">신청금액(원)</th> -->
<!-- 																<th scope="col">상세</th> -->
<!-- 															</tr> -->
<!-- 														</thead> -->

<!-- 														<tbody> -->
														<c:forEach items="${getReqScmOrderList}" var="getReqScmOrderList" varStatus="status" >
														<c:choose>
														<c:when test="${status.index%2 eq 0 }">
<!-- 															<tr class="odd"> -->
														</c:when>
														<c:otherwise>
<!-- 															<tr class="even"> -->
														</c:otherwise>
														</c:choose>
																<td class="tac"> ${getReqScmOrderList.requestName} </td>
<!-- 																<td class="tac"> -->
																	<c:choose>
																		<c:when test="${getReqScmOrderList.hourlyFlag eq 'N'}">
<!-- 																		월 -->
																		</c:when>
																		<c:otherwise>
<!-- 																		시간 -->
																		</c:otherwise>
																	</c:choose>
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
																	<c:choose>
																		<c:when test="${getReqScmOrderList.onDemandFlag eq 'N'}">
																			${getReqScmOrderList.applyDatetime}
																		</c:when>
																		<c:otherwise>
<!-- 																			승인완료 후 생성 -->
																		</c:otherwise>
																	</c:choose>
<!-- 																</td> -->
																<td class="tal"> ${getReqScmOrderList.projectAlias} </td>
<!-- 																<td class="tar fc-blue f16 fb"> -->
																	<fmt:formatNumber value="${getReqScmOrderList.amount}" pattern="#,###"/>
																	<c:set var="amount" value="${amount + getReqScmOrderList.amount}" />
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
																	<button type="button" class="tac mt5 table-search" onclick="openPopScm('${getReqScmOrderList.projectAlias}', '${getReqScmOrderList.requestName}', '${getReqScmOrderList.hourlyFlag}', '${getReqScmOrderList.onDemandFlag}', '${getReqScmOrderList.applyDatetime}', '${getReqScmOrderList.amount}')" ><span></span></button>
																	<input type="hidden" id="c${getReqScmOrderList.orderProductSeq}" name="c${getReqScmOrderList.orderProductSeq}" value="0" />
<!-- 																</td> -->
<!-- 															</tr> -->
															<tr id="v${getReqScmOrderList.orderProductSeq}" name="v${getReqScmOrderList.orderProductSeq}" style="display:none">
<!-- 																<td colspan="6"> -->
<!-- 													     			<div> -->
<!-- 												         				<table class="tableD4" summary="자원 신청현황 자원이미지"> -->
												         					<caption>게시판 목록 : 자원이미지, 비고구성</caption>
														 					<colgroup>
																		 		<col width="150px">
																		 		<col width="*">
														 					</colgroup>
<!-- 														 					<thead> -->
<!-- 														 						<tr class="skyblue"> -->
<!-- 														 							<th scope="col">자원이미지</th>  -->
<!-- 														 							<th scope="col">비고</th> -->
<!-- 														 						</tr> -->
<!-- 														 					</thead> -->
<!-- 														 					<tbody> -->
<!-- 														 						<tr> -->
														 							<td> <img src="${wasPath}/mbr/cmm/file/download/${getReqScmOrderList.imageName}" class="w80"/></td>
														 							<td class="tal"> ${getReqScmOrderList.description} </td>
<!-- 														 						</tr> -->
<!-- 														 					</tbody> -->
<!-- 														 				</table> -->
<!-- 														 			</div> -->
<!-- 																</td> -->
<!-- 															</tr> -->
														</c:forEach>
<!-- 														</tbody> -->
<!-- 													</table> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
								</c:if>
								<!----- 서비스-형상관리 끝 ------->

								<!----- 서비스-대외계 시작 ------->
								<c:if test='${getReqMcaOrderList.size() ne 0}'>
<!-- 			 						<div>	   -->
<!-- 			 							<div> -->
<!-- 			 								<h5 class="subtitle"> 대외계서비스</h5> -->
<!-- 											<div class="panel mb0"> -->
<!-- 												<div> -->
<!-- 													<table class="sumtableV"> -->
														<colgroup>
													 		<col width="80px">
													 		<col width="80px">
													 		<col width="240px">
													 		<col width="*">
													 		<col width="120px">
													 		<col width="80px">
													 	</colgroup>
<!-- 														<thead> -->
<!-- 															<tr class="skyblue">							    -->
<!-- 																<th>요청유형</th> -->
<!-- 																<th>과금단위</th> -->
<!-- 																<th>서비스희망일시</th> -->
<!-- 																<th>프로젝트</th> -->
<!-- 																<th>신청금액(원)</th> -->
<!-- 																<th>상세</th> -->
<!-- 															</tr> -->
<!-- 														</thead> -->
<!-- 														<tbody> -->
														<c:forEach items="${getReqMcaOrderList}" var="getReqMcaOrderList" varStatus="status" >
														<c:choose>
														<c:when test="${status.index%2 eq 0 }">
<!-- 															<tr class="odd"> -->
														</c:when>
														<c:otherwise>
<!-- 															<tr class="even"> -->
														</c:otherwise>
														</c:choose>
																<td class="tac"> ${getReqMcaOrderList.requestName} </td>
<!-- 																<td class="tac">																		 -->
																	<c:choose>
																		<c:when test="${getReqMcaOrderList.hourlyFlag eq 'N'}">
<!-- 																			월 -->
																		</c:when>
																		<c:otherwise>
<!-- 																			시간 -->
																		</c:otherwise>
																	</c:choose>
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
																	<c:choose>
																		<c:when test="${getReqMcaOrderList.onDemandFlag eq 'N'}">
																			${getReqMcaOrderList.applyDatetime}
																		</c:when>
																		<c:otherwise>
<!-- 																			승인완료 후 생성 -->
																		</c:otherwise>
																	</c:choose>
<!-- 																</td> -->
																<td class="tal"> ${getReqMcaOrderList.projectAlias} </td>
<!-- 																<td class="tar fc-blue f16 fb"> -->
																	<fmt:formatNumber value="${getReqMcaOrderList.amount}" pattern="#,###"/>
																	<c:set var="amount" value="${amount + getReqMcaOrderList.amount}" />
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
																	<button type="button" class="tac mt5 table-search" onclick="openPopMca('${getReqMcaOrderList.projectAlias}', '${getReqMcaOrderList.requestName}', '${getReqMcaOrderList.hourlyFlag}', '${getReqMcaOrderList.onDemandFlag}', '${getReqMcaOrderList.applyDatetime}', '${getReqMcaOrderList.amount}')" ><span></span></button>
																	<input type="hidden" id="c${getReqMcaOrderList.orderProductSeq}" name="c${getReqMcaOrderList.orderProductSeq}" value="0" />
<!-- 																</td> -->
<!-- 															</tr> -->
															<tr id="v${getReqMcaOrderList.orderProductSeq}" name="v${getReqMcaOrderList.orderProductSeq}" style="display:none">
<!-- 																<td colspan="6"> -->
<!-- 																	<div> -->
<!-- 														         		<table class="tableD4" summary="자원 신청현황 자원이미지"> -->
														         			<caption>게시판 목록 : 자원이미지, 비고로 구성</caption>
																 			<colgroup>
																 				<col width="150px">
																 				<col width="*">
																 			</colgroup>
<!-- 																 			<thead> -->
<!-- 																 				<tr class="skyblue"> -->
<!-- 																 					<th scope="col">자원이미지</th>  -->
<!-- 																 					<th scope="col">비고</th> -->
<!-- 																 				</tr> -->
<!-- 																 			</thead> -->
<!-- 																 			<tbody> -->
<!-- 																 				<tr> -->
																 					<td> <img src="${wasPath}/mbr/cmm/file/download/${getReqMcaOrderList.imageName}" class="w80"/></td>
																 					<td class="tal"> ${getReqMcaOrderList.description} </td>
<!-- 																 				</tr> -->
<!-- 																 			</tbody> -->
<!-- 																 		</table> -->
<!-- 																 	</div> -->
<!-- 																</td> -->
<!-- 															</tr> -->
														</c:forEach>
<!-- 														</tbody> -->
<!-- 													</table> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
								</c:if>
								<!----- 서비스-대외계 끝 ------->

								<!----- 서비스-통합보안관제 시작 ------->
								<c:if test='${getReqSerOrderList.size() ne 0}'>
<!-- 									<div>   -->
<!-- 			 							<div> -->
<!-- 			 								<h5 class="subtitle"> 보안관제서비스</h5> -->
<!-- 											<div class="panel mb0"> -->
<!-- 												<div> -->
<!-- 													<table class="sumtableV"> -->
														<colgroup>
													 		<col width="80px">
													 		<col width="80px">
													 		<col width="240px">
													 		<col width="*">
													 		<col width="120px">
													 		<col width="80px">
													 	</colgroup>
<!-- 														<thead> -->
<!-- 															<tr class="skyblue">							    -->
<!-- 																<th>요청유형</th> -->
<!-- 																<th>과금단위</th> -->
<!-- 																<th>서비스희망일시</th> -->
<!-- 																<th>프로젝트</th>								 -->
<!-- 																<th>신청금액(원)</th> -->
<!-- 																<th>상세</th> -->
<!-- 															</tr> -->
<!-- 														</thead> -->
<!-- 														<tbody> -->
														<c:forEach items="${getReqSerOrderList}" var="getReqSerOrderList" varStatus="status" >
														<c:choose>
														<c:when test="${status.index%2 eq 0 }">
<!-- 															<tr class="odd"> -->
														</c:when>
														<c:otherwise>
<!-- 															<tr class="even"> -->
														</c:otherwise>
														</c:choose>
																<td class="tac"> ${getReqSerOrderList.requestName} </td>
<!-- 																<td class="tac"> -->
																	<c:choose>
																		<c:when test="${getReqSerOrderList.hourlyFlag eq 'N'}">
<!-- 																			월 -->
																		</c:when>
																		<c:otherwise>
<!-- 																			시간 -->
																		</c:otherwise>
																	</c:choose>
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
																	<c:choose>
																		<c:when test="${getReqSerOrderList.onDemandFlag eq 'N'}">
																			${getReqSerOrderList.applyDatetime}
																		</c:when>
																		<c:otherwise>
<!-- 																			승인완료 후 생성 -->
																		</c:otherwise>
																	</c:choose>
<!-- 																</td> -->
																<td class="tal"> ${getReqSerOrderList.projectAlias} </td>
<!-- 																<td class="tar fc-blue f16 fb"> -->
																	<fmt:formatNumber value="${getReqSerOrderList.amount}" pattern="#,###"/>
																	<c:set var="amount" value="${amount + getReqSerOrderList.amount}" />
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
																	<button type="button" class="tac mt5 table-search" onclick="openPopSer('${getReqSerOrderList.projectAlias}', '${getReqSerOrderList.requestName}', '${getReqSerOrderList.hourlyFlag}', '${getReqSerOrderList.onDemandFlag}', '${getReqSerOrderList.applyDatetime}', '${getReqSerOrderList.amount}')" ><span></span></button>
																	<input type="hidden" id="c${getReqSerOrderList.orderProductSeq}" name="c${getReqSerOrderList.orderProductSeq}" value="0" />
<!-- 																</td> -->
<!-- 															</tr> -->
															<tr id="v${getReqSerOrderList.orderProductSeq}" name="v${getReqSerOrderList.orderProductSeq}" style="display:none">
<!-- 																<td colspan="6"> -->
<!-- 														     		<div> -->
<!-- 													         			<table class="tableD4" summary="자원 신청현황 자원이미지"> -->
														         			<caption>게시판 목록 : 자원이미지, 비고로 구성</caption>
																 			<colgroup>
																				 <col width="150px">
																				 <col width="*">
																 			</colgroup>
<!-- 																 			<thead> -->
<!-- 																 				<tr class="skyblue"> -->
<!-- 																 					<th scope="col">자원이미지</th>  -->
<!-- 																					 <th scope="col">비고</th> -->
<!-- 																				 </tr> -->
<!-- 																 			</thead> -->
<!-- 																 			<tbody> -->
<!-- 																 				<tr> -->
																 					<td> <img src="${wasPath}/mbr/cmm/file/download/${getReqSerOrderList.imageName}" class="w80"/></td>
																 					<td class="tal"> ${getReqSerOrderList.description} </td>
<!-- 																 				</tr> -->
<!-- 																 			</tbody> -->
<!-- 																 		</table> -->
<!-- 																	 </div> -->
<!-- 																</td> -->
<!-- 															</tr> -->
														</c:forEach>
<!-- 														</tbody> -->
<!-- 													</table> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
								</c:if>
								<!----- 서비스-통합보안관제 끝 ------->
							</div>
						</c:if>
						<!-----서비스  끝------->

						<!-- begin page-body 총합계 -->

							<hr class="line2a mt20"></hr>
							<div class="appTotal dpno">
								<span class="llabel nanumR">총합계<span class="txttotal">(신청:${totCnt}개)</span></span>
								<span class="totalwon nanumR"><fmt:formatNumber value="${amount}" pattern="#,###"/><span class="unit">&nbsp;원</span></span>
							</div>
						</div>
						<!-- end page-body 2023 이전소스--> --%>

	           <button class="a-ccordion up">기본자원 (가상서버) <div class="sum"><li >신규    <span class="fc_dblue">${vmNew} </span></li> <li>변경   <span class="fc-green"> ${vmCh}</span> </li><li>삭제   <span class="fc-orange"> ${vmEx}</span> </li></div> </button>
				<div class="re_subbox">
				  <p>
				        <c:if test='${orderviewList.size() eq 0}'>
            				<h5 class=" box_grey1 tac p50 fc11 fn"> <img src="${apachePath}/resources/assets/img/icon_no.png"/> 가상서버 신청 내역이 없습니다</h5>
						</c:if>

						<c:if test='${orderviewList.size() ne 0}'>
								    			<!--------자원정보 table 시작---------->
												<table class="tableV">
													<colgroup>
														 <col width="10%">
														 <col width="10%">
														 <col width="10%">
														 <col width="*">
														 <col width="15%">
														 <col width="15%">
														 <col width="10%">
													     <col width="10%">
														 <col width="8%">
													</colgroup>

													<thead>
														<tr class="skyblue">
														    <th>요청유형</th>
														    <th>클라우드</th>
															<th>서비스희망일시</th>
															<th>서버명</th>
															<th>가상서버유형</th>
															<th>네트워크</th>
															<th>CPU (Core)</th>
															<th>MEM (GB)</th>
															<th>상세</th>
														</tr>
													</thead>

													<tbody>
													<c:forEach items="${orderviewList}" var="orderviewList" varStatus="status" >
													<c:choose>
														<c:when test="${status.index%2 eq 0 }">
														<tr class="odd">
														</c:when>
														<c:otherwise>
														<tr class="even">
														</c:otherwise>
														</c:choose>
															<td class="tac"> ${orderviewList.requestName} </td>
															<td class="tac"> ${orderviewList.cloudName} </td>
															<td class="tac">
																<c:choose>
																	<c:when test="${orderviewList.onDemandFlag eq 'N'}">
																	${orderviewList.applyDatetime}
																	</c:when>
																	<c:otherwise>
																		승인완료 후 생성
																	</c:otherwise>
																</c:choose>
															</td>
															<td class="tac"> ${orderviewList.hostnameAlias} </td>
															<td class="tac"> ${orderviewList.instanceType} </td>

															<c:choose>
																<c:when test="${orderviewList.backupNetworkFlag eq 'Y'}">
																	<td class="tac">백업 네트워크 포함</td>
																</c:when>
																<c:otherwise>
																	<td class="tac">백업 네트워크 미포함</td>
																</c:otherwise>
															</c:choose>
<%-- 															<td class="tac"> ${orderviewList.defaultNetworkName} </td> --%>

															<c:if test="${orderviewList.requestName eq '신규' || orderviewList.requestName eq '해지'}">
															<td class="tac"> ${orderviewList.vcpus} </td>
															<td class="tac"> ${orderviewList.memGb} </td>
															</c:if>
															<c:if test="${orderviewList.requestName eq '변경'}">
															<td class="tac"> ${orderviewList.beforeVcpus}  <i class="fa fa-arrow-right fc99"></i> ${orderviewList.changeVcpus} </td>
															<td class="tac"> ${orderviewList.beforeMemGb} <i class="fa fa-arrow-right fc99"></i> ${orderviewList.changeMemGb}</td>
															</c:if>

														<!-- 	<td class="tar fc-blue f16 fb">
																<fmt:formatNumber value="${orderviewList.amount}" pattern="#,###"/>
																<c:set var="amount" value="${amount + orderviewList.amount}" />
															</td> -->
															<td class="tac">



															 	<%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>

																<!--<a href="#server-modal-dialog" data-toggle="modal"><button type="button" class="cbton bton_lblue" ><i class="fa fa-search"></i></button></a><!-- 디자인 된 모달임  -->
					  												<button type="button" class="cbton bton_lblue" onclick="openPopserver('${orderviewList.fixedIps}','${orderviewList.bakupFixedIps}','${orderviewList.projectName}','${orderviewList.vmImageName}','${fn:replace(orderviewList.description,newLineChar,br)}','${orderviewList.defaultNetworkName}','${orderviewList.requestType}','${orderviewList.beforeVcpus}','${orderviewList.changeVcpus}','${orderviewList.beforeMemGb}','${orderviewList.changeMemGb}','${orderviewList.projectAlias}', '${orderviewList.hostnameAlias}', '${orderviewList.hostname}', '${orderviewList.requestName}', '${orderviewList.hourlyFlag}', '${orderviewList.onDemandFlag}', '${orderviewList.applyDatetime}', '${orderviewList.amount}', '${orderviewList.vcpus}', '${orderviewList.memGb}', '${orderviewList.vmDiskGb}', '${orderviewList.cloudName}')" >


					  											<i class="fa fa-search"></i></button>
																<input type="hidden" id="c${orderviewList.orderProductSeq}" name="c${orderviewList.orderProductSeq}" value="0" />
															</td>
														</tr>

														<tr id="v${orderviewList.orderProductSeq}" name="v${orderviewList.orderProductSeq}" style="display:none">
															<td colspan="8">
											     				<div>
										         					<table class="tableD4">
												 						<colgroup>
																			 <col width="33.3%">
																			 <col width="33.3%">
																			 <col width="33.3%">
												 						</colgroup>

												 						<thead>
												 							<tr class="skyblue">
												 								<th>CPU</th>
												 								<th>MEM</th>
												 								<th>DISK</th>
												 							</tr>
												 						</thead>

												 						<tbody>
																			 <tr>
												 								<td> ${orderviewList.vcpus} Core </td>
												 								<td> ${orderviewList.memGb} GB </td>
																				<td> ${orderviewList.vmDiskGb} GB </td>
																			</tr>
												 							<tr>
												 								<td class="blue">추가요청사항</td>
												 								<td colspan="2" class="tal pl20">
												 									${orderviewList.description}
												 								</td>
												 							</tr>
												 						</tbody>
												 					</table>
													 			</div>
															</td>
														</tr>
														</c:forEach>
													</tbody>
												</table>
								<div class="appTotal2 dpno">
									<span class="llabel nanumR">소계<span class="txttotal">(VAT 별도)</span></span>
									<span class="totalwon nanumR"><fmt:formatNumber value="${amount}" pattern="#,###"/><span class="unit">원</span></span>
								</div>
						</c:if>
						<!----- 기본자원 끝 ------->
				  </p>
				</div>




	<button class="a-ccordion up" style="margin-top:20px;">부가자원 (블록디스크) <div class="sum"><li >신규    <span class="fc_dblue">${subNew}  </span></li> <li>변경   <span class="fc-green">${subCh}</span> </li><li>삭제   <span class="fc-orange"> ${subEx}</span> </li></div> </button>
				<div class="re_subbox">
				  <p>
				  		<!----- 부가자원 시작 ------->
						<c:set value="useitem" var="substr"/>
						<c:choose>
							<c:when test="${orderDiskviewList.size() ne 0}">
								<c:set var="substr" value="" />
							</c:when>
							<c:when test="${orderNasviewList.size() ne 0}">
								<c:set var="substr" value="" />
							</c:when>
							<c:when test="${orderLbviewList.size() ne 0}">
								<c:set var="substr" value="" />
							</c:when>
							<c:when test="${getBasketSnlistvo.size() ne 0}">
								<c:set var="substr" value="" />
							</c:when>
							<c:when test="${orderIpviewList.size() ne 0}">
								<c:set var="substr" value="" />
							</c:when>
						</c:choose>
					 	<c:set var="subCnt" value="${orderDiskviewList.size() + orderNasviewList.size() + orderLbviewList.size() + getBasketSnlistvo.size() + orderIpviewList.size()}" />

						<c:if test='${subCnt eq 0}'>
							<h5 class="box_grey1 tac p50 fc11 fn"> <img src="${apachePath}/resources/assets/img/icon_no.png"/>  부가자원 신청 내역이 없습니다</h5>
						</c:if>


						<c:if test='${subCnt ne 0}'>

								<!----- 부가자원-블록디스크 시작 ------->
								<c:if test='${orderDiskviewList.size() ne 0}'>

							 				<h5 class="subtitle"> 블록디스크</h5>

													<table class="tableV">
										 				<colgroup>
															 <col width="10%">
															 <col width="10%">
															 <col width="15%">
															 <col width="10%">
															 <col width="*">
															 <col width="8%">
										 				</colgroup>

														<thead>
															<tr  class="skyblue">
															    <th>요청유형</th>
																<th>서비스희망일시</th>
																<th>디스크명</th>
																<th>크기 (GB)</th>
																<th>가상서버명</th>
																<th>상세</th>
															</tr>
														</thead>

														<tbody>
														<c:forEach items="${orderDiskviewList}" var="orderDiskviewList" varStatus="status" >
														<c:choose>
															<c:when test="${status.index%2 eq 0 }">
															<tr class="odd">
															</c:when>
															<c:otherwise>
															<tr class="even">
															</c:otherwise>
															</c:choose>
																<td class="tac"> ${orderDiskviewList.requestName} </td>
																<td class="tac">
																	<c:choose>
																		<c:when test="${orderDiskviewList.onDemandFlag eq 'N'}">
																			${orderDiskviewList.applyDatetime}
																		</c:when>
																		<c:otherwise>
																			승인완료 후 생성
																		</c:otherwise>
																	</c:choose>
																</td>
																<td class="tac"> ${orderDiskviewList.diskName} </td>

																<c:if test="${orderDiskviewList.requestName eq '신규' || orderDiskviewList.requestName eq '해지'}">
																<td class="tac"> ${orderDiskviewList.diskGb} </td>
																</c:if>
																<c:if test="${orderDiskviewList.requestName eq '변경'}">
																<td class="tac"> ${orderDiskviewList.beforeDiskGb}  <i class="fa fa-arrow-right fc99"></i> ${orderDiskviewList.changeDiskGb}  </td>
																</c:if>

																<td class="tac"> ${orderDiskviewList.hostnameAlias} </td>
															<!--	<td class="tar fc-blue f16 fb">
																	<fmt:formatNumber value="${orderDiskviewList.amount}" pattern="#,###"/>
																	<c:set var="amount" value="${amount + orderDiskviewList.amount}" />
																</td>  -->
																<td class="tac">
																   <!--<a href="#disk-modal-dialog" data-toggle="modal"><button type="button" class="cbton bton_lblue" ><i class="fa fa-search"></i></button></a><!-- 디자인 된 모달임  -->
																	<button type="button" class="cbton bton_lblue" onclick="openPopdisk('${orderDiskviewList.projectName}','${orderDiskviewList.diskType}','${orderDiskviewList.diskName}','${orderDiskviewList.description}','${orderDiskviewList.requestType}','${orderDiskviewList.beforeDiskGb}','${orderDiskviewList.changeDiskGb}','${orderDiskviewList.projectAlias}', '${orderDiskviewList.hostname}', '${orderDiskviewList.hostnameAlias}', '${orderDiskviewList.requestName}', '${orderDiskviewList.hourlyFlag}', '${orderDiskviewList.onDemandFlag}', '${orderDiskviewList.applyDatetime}', '${orderDiskviewList.diskGb}', '${orderDiskviewList.amount}', '${orderDiskviewList.cloudName}')" >
																	<i class="fa fa-search"></i></button>
																		<input type="hidden" id="c${orderDiskviewList.orderProductSeq}" name="c${orderDiskviewList.orderProductSeq}" value="0" />
																</td>
															</tr>
															<tr id="v${orderDiskviewList.orderProductSeq}" name="v${orderDiskviewList.orderProductSeq}" style="display:none">
																<td colspan="8">
												     				<div>
											         					<table class="tableD4">
													 						<colgroup>
																				 <col width="50%">
																				 <col width="50%">
																			 </colgroup>
													 						<thead>
													 							<tr  class="skyblue">
													 								<th>디스크이름</th>
													 								<th>용량</th>
													 							</tr>
													 						</thead>
													 						<tbody>
													 							<tr>
													 								<td> ${orderDiskviewList.diskName} </td>
													 								<td> ${orderDiskviewList.diskGb} GB </td>
													 						</tbody>
													 					</table>
													 				</div>
																</td>
															</tr>
														</c:forEach>
														</tbody>
													</table>

								</c:if>
								<!-----부가자원-블록디스크  끝 ------->
								<!----- 부가자원-로드밸런서 시작------->
								<c:if test='${orderSnviewList.size() ne 0}'>

			 								<h5 class="subtitle"> 스냅샷</h5>

				    								<table class="sumtableV" summary="자원 신청현황 자원정보">
														<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 신청금액(원), 상세로 구성</caption>
														 <colgroup>
															    <col width="8%">
														 		<col width="8%">
														 		<col width="15%">
														 		<col width="10%">
														 		<col width="70px">
														 </colgroup>
														<thead>
															<tr class="skyblue">
																<th scope="col">요청유형</th>
																<th scope="col">가상서버</th>
																<th scope="col">스냅샷명</th>
																<th scope="col">디스크명</th>
																<th scope="col">상세</th>
															</tr>
														</thead>
														<tbody>
														<c:forEach items="${orderSnviewList}" var="orderSnviewList" varStatus="status" >
														<c:choose>
														<c:when test="${status.index%2 eq 0 }">
															<tr class="odd">
														</c:when>
														<c:otherwise>
															<tr class="even">
														</c:otherwise>
														</c:choose>
																<td class="tac">
																	<c:if test="${orderSnviewList.requestName eq '신규'}">
																		신규
																	</c:if>
																	<c:if test="${orderSnviewList.requestName eq '변경'}">
																		적용
																	</c:if>
																	<c:if test="${orderSnviewList.requestName eq '해지'}">
																		삭제
																	</c:if>
																</td>
																<td class="tac">
																	${orderSnviewList.hostname}
																</td>
																<td class="tac">
																	${orderSnviewList.snapshotName}
																</td>
																<td class="tac">
																	${orderSnviewList.diskAlias}
																</td>
																<td class="tac">
																 	<button type="button" class="tac mt5 table-search" onclick="openPopSn('${orderSnviewList.projectAlias}', '${orderSnviewList.snapshotName}', '${orderSnviewList.hostname}', '${orderSnviewList.diskAlias}','${orderSnviewList.description}','${orderSnviewList.applyDatetime}','${orderSnviewList.onDemandFlag}','${orderSnviewList.requestName}')" ><span></span></button>
																	<input type="hidden" id="c${orderSnviewList.orderProductSeq}" name="c${orderSnviewList.orderProductSeq}" value="0" />
																</td>
															</tr>
														</c:forEach>
														</tbody>
													</table>
								</c:if>
								<!----- 부가자원-로드밸런서 끝------->
								<!----- 부가자원-NAS 시작------->
								<c:if test='${orderNasviewList.size() ne 0}'>
											<h5 class="subtitle"> NAS</h5>

													<table class="sumtableV" summary="자원 신청현황 자원정보">
												 		<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 가상서버, 신청금액(원) 상세로 구성</caption>
														<colgroup>
															<col width="80px">
															<col width="160px">
															<col width="*">
															<col width="*">
															<col width="*">
															<col width="240px">
															<col width="120px">
															<col width="80px">
														</colgroup>

														<thead>
															<tr  class="skyblue">
																<th scope="col">요청유형</th>
																<th scope="col">서비스희망일시</th>
																<th scope="col">프로젝트</th>
																<th scope="col">스토리지명</th>
																<th scope="col">스토리지ID</th>
																<th scope="col">가상서버</th>
																<th scope="col">용량</th>
																<th scope="col">상세</th>
															</tr>
														</thead>

														<tbody>
														<c:forEach items="${orderNasviewList}" var="orderNasviewList" varStatus="status" >
														<c:choose>
														<c:when test="${status.index%2 eq 0 }">
															<tr class="odd">
														</c:when>
														<c:otherwise>
															<tr class="even">
														</c:otherwise>
														</c:choose>
																<td class="tac"> ${orderNasviewList.requestName} </td>
																<td class="tac">
																	<c:choose>
																		<c:when test="${orderNasviewList.onDemandFlag eq 'N'}">
																			${orderNasviewList.applyDatetime}
																		</c:when>
																		<c:otherwise>
																			승인완료 후 생성
																		</c:otherwise>
																	</c:choose>
																</td>
																<td class="tac"> ${orderNasviewList.projectAlias} </td>
																<td class="tac"> ${orderNasviewList.nasName} </td>
																<td class="tac"> ${orderNasviewList.nasAlias} </td>
																<c:choose>
																	<c:when test="${orderNasviewList.nasVmList ne null}">
																		<td class="tac"> ${orderNasviewList.hostnameAlias}
																		</td>
																	</c:when>
																	<c:otherwise>
																		<td class="tac">OpenShift</td>
																	</c:otherwise>
																</c:choose>
																<td class="tac"> ${orderNasviewList.nasGb} </td>
																<td class="tac">
																	<button type="button" class="tac mt5 table-search" onclick="openPopNas('${orderNasviewList.projectAlias}',
																	'${orderNasviewList.nasName}', '${orderNasviewList.vmName}', '${orderNasviewList.requestName}',
																	'${orderNasviewList.hourlyFlag}', '${orderNasviewList.onDemandFlag}', '${orderNasviewList.applyDatetime}',
																	'${orderNasviewList.nasGb}', '${orderNasviewList.amount}', '${orderNasviewList.description}',
																	'${orderNasviewList.nasVmList}', '${orderNasviewList.nasAlias}', '${orderNasviewList.nasOption}',
																	'${orderNasviewList.cloudType}', '${orderNasviewList.cloudName}', '${orderNasviewList.nasFileSystemPath}')" >
																		<i class="fa fa-search"></i></button>
																	<input type="hidden" id="c${orderNasviewList.orderProductSeq}" name="c${orderNasviewList.orderProductSeq}" value="0" />
																</td>
															</tr>
															<tr id="v${orderNasviewList.orderProductSeq}" name="v${orderNasviewList.orderProductSeq}" style="display:none">
																<td colspan="7">
													     			<div>
												         				<table class="tableD4">
														 					<colgroup>
																			 	<col width="50%">
																			 	<col width="50%">
																			 </colgroup>
														 					<thead>
														 						<tr  class="skyblue">
														 							<th>이름</th>
														 							<th>용량</th>
														 						</tr>
														 					</thead>
														 					<tbody>
														 						<tr>
														 							<td> ${orderNasviewList.nasName} </td>
																					<td> ${orderNasviewList.nasGb} GB </td>
														 						</tr>
														 					</tbody>
														 				</table>
														 			</div>
																</td>
															</tr>
														</c:forEach>
														</tbody>
													</table>
								</c:if>
								<!----- 부가자원-NAS 끝 ------->

								<!----- 부가자원-로드밸런서 시작------->
								<c:if test='${orderLbviewList.size() ne 0}'>

			 								<h5 class="subtitle"> 로드밸런스</h5>
				    								<table class="sumtableV" summary="자원 신청현황 자원정보">
														<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 신청금액(원), 상세로 구성</caption>
														 <colgroup>
															 	<col width="8%">
														 		<col width="8%">
														 		<col width="15%">
														 		<col width="10%">
														 		<col width="8%">
														 		<col width="70px">
														 </colgroup>
														<thead>
															<tr class="skyblue">
																<th scope="col">요청유형</th>
																<th scope="col">로드밸런스명</th>
																<th scope="col">PORT</th>
																<th scope="col">method</th>
																<th scope="col">protocol</th>
																<th scope="col">상세</th>
															</tr>
														</thead>
														<tbody>
														<c:forEach items="${orderLbviewList}" var="orderLbviewList" varStatus="status" >
														<c:choose>
														<c:when test="${status.index%2 eq 0 }">
															<tr class="odd">
														</c:when>
														<c:otherwise>
															<tr class="even">
														</c:otherwise>
														</c:choose>
																<td class="tac">
																	<c:if test="${orderLbviewList.requestName eq '신규'}">
																		신규
																	</c:if>
																	<c:if test="${orderLbviewList.requestName eq '변경'}">
																		변경
																	</c:if>
																	<c:if test="${orderLbviewList.requestName eq '해지'}">
																		삭제
																	</c:if>
																</td>
																<td class="tac">
																	${orderLbviewList.loadbalancerName}
																</td>
																<td class="tac">
																	${orderLbviewList.port}
																</td>
																<td class="tac"> ${orderLbviewList.method} </td>
																<td class="tac">
																	${orderLbviewList.protocol}
																</td>
																<td class="tac">
																 	<button type="button" class="tac mt5 table-search" onclick="openPopLb('${orderLbviewList.projectAlias}', '${orderLbviewList.loadbalancerName}', '${orderLbviewList.protocol}', '${orderLbviewList.method}', '${orderLbviewList.ip}', '${orderLbviewList.port}','${orderLbviewList.loadbalancerVm}')" ><span></span></button>
																	<input type="hidden" id="c${orderLbviewList.orderProductSeq}" name="c${orderLbviewList.orderProductSeq}" value="0" />
																</td>
															</tr>
															<tr id="v${orderLbviewList.orderProductSeq}" name="v${orderLbviewList.orderProductSeq}" style="display:none">
																<td colspan="7">
																	<div>
														         		<table class="tableD4">
																 			<colgroup>
																				<col width="20%">
																				<col width="20%">
																				<col width="20%">
																				<col width="20%">
																				<col width="20%">
																			</colgroup>

																 			<thead>
																				<tr class="skyblue">
																					<th>가상서버</th>
																					<th>로드밸런서이름</th>
																					<th>Protocal</th>
																					<th>Method</th>
																					<th>Monitor Type</th>
																				</tr>
																 			</thead>
																 			<tbody>
																 				<tr>
																 					<td>${orderLbviewList.loadbalancerVm}</td>
																					 <td>${orderLbviewList.loadbalancerName}</td>
																					 <td>${orderLbviewList.protocolName}</td>
																					 <td>${orderLbviewList.methodName}</td>
																					 <td>${orderLbviewList.monitorType}</td>
																 				</tr>
																 			</tbody>
																 		</table>
																 	</div>
																</td>
															</tr>
														</c:forEach>
														</tbody>
													</table>

								</c:if>
								<!----- 부가자원-로드밸런서 끝------->

								<!----- 부가자원-공인IP 시작------->
								<c:if test='${orderIpviewList.size() ne 0}'>
								 		<h5 class="subtitle"> 공인IP</h5>

												<table class="sumtableV" summary="자원 신청현황 자원정보">
													<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 연결용도, 신청금액(원), 상세로 구성</caption>
											 		<colgroup>
														<col width="80px">
														<col width="80px">
														<col width="120px">
														<col width="*">
														<col width="180px">
														<col width="120px">
														<col width="80px">
													</colgroup>
													<thead>
														<tr class="skyblue">
															<th scope="col">요청유형</th>
															<th scope="col">과금단위</th>
															<th scope="col">서비스희망일시</th>
															<th scope="col">프로젝트</th>
															<th scope="col">연결용도</th>
															<th scope="col">신청금액(원)</th>
															<th scope="col">상세</th>
														</tr>
													</thead>

													<tbody>
													<c:forEach items="${orderIpviewList}" var="orderIpviewList" varStatus="status" >
													<c:choose>
													<c:when test="${status.index%2 eq 0 }">
														<tr class="odd">
													</c:when>
													<c:otherwise>
														<tr class="even">
													</c:otherwise>
													</c:choose>
															<td class="tac"> ${orderIpviewList.requestName} </td>
															<td class="tac">
																<c:choose>
																	<c:when test="${orderIpviewList.hourlyFlag eq 'N'}">
																		월
																	</c:when>
																	<c:otherwise>
																		시간
																	</c:otherwise>
																</c:choose>
															</td>
															<td class="tac">
																<c:choose>
																	<c:when test="${orderIpviewList.onDemandFlag eq 'N'}">
																		${orderIpviewList.applyDatetime}
																	</c:when>
																	<c:otherwise>
																		승인완료 후 생성
																	</c:otherwise>
																</c:choose>
															</td>
															<td class="tal"> ${orderIpviewList.projectAlias} </td>
															<td class="tal"> ${orderIpviewList.description} </td>
															<td class="tar fc-blue f16 fb">
																<fmt:formatNumber value="${orderIpviewList.amount}" pattern="#,###"/>
																<c:set var="amount" value="${amount + orderIpviewList.amount}" />
															</td>
															<td class="tac">
																<button type="button" class="tac mt5 table-search" onclick="openPopIp('${orderIpviewList.projectAlias}', '${orderIpviewList.description}', '${orderIpviewList.requestName}', '${orderIpviewList.hourlyFlag}', '${orderIpviewList.onDemandFlag}', '${orderIpviewList.applyDatetime}', '${orderIpviewList.amount}')" ><span></span></button>
																<input type="hidden" id="c${orderIpviewList.orderProductSeq}" name="c${orderIpviewList.orderProductSeq}" value="0" />
															</td>
														</tr>

														<tr id="v${orderIpviewList.orderProductSeq}" name="v${orderIpviewList.orderProductSeq}" style="display:none">
															<td colspan="7">
													     		<div>
												         			<table class="tableD4" summary="자원 신청현황 자원이미지">
												         				<caption>게시판 목록 : 자원이미지, 비고로 구성</caption>
												         				<colgroup>
																			<col width="150px">
																			<col width="*">
																		</colgroup>
														 				<thead>
														 					<tr class="skyblue">
														 						<th scope="col">자원이미지</th>
														 						<th scope="col">비고</th>
														 					</tr>
														 				</thead>
														 				<tbody>
														 					<tr>
														 						<td> <img src="${wasPath}/mbr/cmm/file/download/${orderIpviewList.imageName}" class="w80"/></td>
														 						<td class="tal"> ${orderIpviewList.description} </td>
														 					</tr>
														 				</tbody>
														 			</table>
														 		</div>
															</td>
														</tr>
													</c:forEach>
													</tbody>
												</table>

								</c:if>
								<!----- 부가자원-공인IP 끝------->

								<div class="appTotal2 dpno">
									<span class="llabel nanumR">소계<span class="txttotal">(VAT 별도)</span></span>
									<span class="totalwon nanumR"><fmt:formatNumber value="${amount}" pattern="#,###"/><span class="unit">원</span></span>
								</div>

						</c:if>
						<!-----부가자원 끝---------->
				  </p>
				</div>



		<button class="a-ccordion up" style="margin-top:20px;">서비스 (계정관리/보안관제/백업관리/SW설치/디스크관리/오토스케일/재배포)<div class="sum"><li >신규    <span class="fc_dblue">${servNew} </span></li> <li>변경   <span class="fc-green"> ${servCh}</span> </li><li>삭제   <span class="fc-orange">${servEx}</span> </li></div> </button>
				<div class="re_subbox">
				  <p>
				  		<!-----서비스  시작------->

						<c:set value="useitem" var="subser"/>
						<c:choose>
<%-- 							<c:when test="${orderBakviewList.size() ne 0}"> --%>
<%-- 								<c:set var="subser" value="" /> --%>
<%-- 							</c:when> --%>
							<c:when test="${orderServiceviewList.size() ne 0}">
								<c:set var="subser" value="" />
							</c:when>
<%-- 							<c:when test="${getReqScmOrderList.size() ne 0}"> --%>
<%-- 								<c:set var="subser" value="" /> --%>
<%-- 							</c:when> --%>
<%-- 							<c:when test="${getReqMcaOrderList.size() ne 0}"> --%>
<%-- 								<c:set var="subser" value="" /> --%>
<%-- 							</c:when> --%>
<%-- 							<c:when test="${getReqSerOrderList.size() ne 0}"> --%>
<%-- 								<c:set var="subser" value="" /> --%>
<%-- 							</c:when>				 --%>
						</c:choose>
						<c:if test='${subser ne ""}'>
							<h5 class="box_grey1 tac p50 fc11 fn"> <img src="${apachePath}/resources/assets/img/icon_no.png"/> 서비스 신청 내역이 없습니다 </h5>
						</c:if>
						<c:if test='${subser eq ""}'>
								<!----- 서비스-공통 시작 ------->
								<c:if test='${orderServiceviewList.size() ne 0}'>

											<h5 class="subtitle"> 서비스</h5>
													<table class="tableV">

														<colgroup>
															<col width="10%">
															<col width="10%">
															<col width="10%">
															<col width="25%">
															<col width="*">
															<col width="8%">
														</colgroup>
														<thead>
															<tr class="skyblue">
																<th>요청유형</th>
																<th>서비스희망일시</th>
															    <th>서비스자원 유형</th>
																<th>서비스 자원명</th>
																<th>자원</th>
																<th>상세</th>
															</tr>
														</thead>
														<tbody>
														<c:forEach items="${orderServiceviewList}" var="orderServiceviewList" varStatus="status" >
														<c:choose>
														<c:when test="${status.index%2 eq 0 }">
															<tr class="odd">
														</c:when>
														<c:otherwise>
															<tr class="even">
														</c:otherwise>
														</c:choose>
																<td class="tac"> ${orderServiceviewList.requestName} </td>
																<td class="tac">
																	<c:choose>
																		<c:when test="${orderServiceviewList.onDemandFlag eq 'N'}">
																			${orderServiceviewList.applyDatetime}
																		</c:when>
																		<c:otherwise>
																			승인완료 후 생성
																		</c:otherwise>
																	</c:choose>
																</td>
																<td class="tac"> ${orderServiceviewList.serviceTypeName} </td>
																<td class="tac"> ${orderServiceviewList.serviceName} </td>

																<c:choose>
																	<c:when test="${orderServiceviewList.serviceType eq '10'}"><td class="tac"> ${orderServiceviewList.appName} </td></c:when>
																	<c:when test="${orderServiceviewList.serviceType eq '11'}"><td class="tac"> ${orderServiceviewList.appName} </td></c:when>
																	<c:when test="${orderServiceviewList.serviceType eq 'SERVICE99'}"><td class="tac"> ${orderServiceviewList.serviceName} </td></c:when>
																	<c:otherwise><td class="tac"> ${orderServiceviewList.hostnameAlias} </td></c:otherwise>
																</c:choose>

																<!-- <td class="tar fc-blue f16 fb">
																	<fmt:formatNumber value="${orderServiceviewList.amount}" pattern="#,###"/>
																	<c:set var="amount" value="${amount + orderServiceviewList.amount}" />
																</td> -->
																<td class="tac">
																	<%-- <img src="${apachePath}/resources/assets/img/icon_detailview01.png" onclick="viewtr('${orderBakviewList.orderProductSeq}')" onclick="viewtr('${orderBakviewList.orderProductSeq}')" /> --%>
																    <!--  <a href="#service-modal-dialog" data-toggle="modal"><button type="button" class="cbton bton_lblue" ><i class="fa fa-search"></i></button></a><!-- 디자인 된 모달임  -->
																	 <%pageContext.setAttribute("newLineChar","\r\n"); pageContext.setAttribute("br","<br/>");%>

																<c:choose>
																	<c:when test="${orderServiceviewList.serviceType eq '10'}"><button type="button" class="cbton bton_lblue" onclick="openPopService('${orderServiceviewList.projectName}','${fn:replace(fn:replace(fn:escapeXml(orderServiceviewList.description),newLineChar,br),'','&nbsp;')}','${orderServiceviewList.serviceProductName}','${orderServiceviewList.serviceName}','${orderServiceviewList.serviceTypeName}','${orderServiceviewList.projectAlias}', '${orderServiceviewList.appName}', '${orderServiceviewList.hostnameAlias}', '${orderServiceviewList.requestName}', '${orderServiceviewList.hourlyFlag}', '${orderServiceviewList.onDemandFlag}', '${orderServiceviewList.applyDatetime}', '${orderServiceviewList.amount}', '${orderServiceviewList.cloudName}')" ></c:when>
																	<c:when test="${orderServiceviewList.serviceType eq '11'}"><button type="button" class="cbton bton_lblue" onclick="openPopService('${orderServiceviewList.projectName}','${fn:replace(fn:replace(fn:escapeXml(orderServiceviewList.description),newLineChar,br),'','&nbsp;')}','${orderServiceviewList.serviceProductName}','${orderServiceviewList.serviceName}','${orderServiceviewList.serviceTypeName}','${orderServiceviewList.projectAlias}', '${orderServiceviewList.appName}', '${orderServiceviewList.hostnameAlias}', '${orderServiceviewList.requestName}', '${orderServiceviewList.hourlyFlag}', '${orderServiceviewList.onDemandFlag}', '${orderServiceviewList.applyDatetime}', '${orderServiceviewList.amount}', '${orderServiceviewList.cloudName}')" ></c:when>
																	<c:otherwise><button type="button" class="cbton bton_lblue" onclick="openPopService('${orderServiceviewList.projectName}','${fn:replace(fn:replace(fn:escapeXml(orderServiceviewList.description),newLineChar,br),'','&nbsp;')}','${orderServiceviewList.serviceProductName}','${orderServiceviewList.serviceName}','${orderServiceviewList.serviceTypeName}','${orderServiceviewList.serviceType}','${orderServiceviewList.projectAlias}', '${orderServiceviewList.hostname}', '${orderServiceviewList.hostnameAlias}', '${orderServiceviewList.requestName}', '${orderServiceviewList.hourlyFlag}', '${orderServiceviewList.onDemandFlag}', '${orderServiceviewList.applyDatetime}', '${orderServiceviewList.amount}', '${orderServiceviewList.cloudName}')" ></c:otherwise>
																</c:choose>

																	<i class="fa fa-search"></i></button>
																	<input type="hidden" id="c${orderServiceviewList.orderProductSeq}" name="c${orderServiceviewList.orderProductSeq}" value="0" />
																</td>
															</tr>
															<tr id="v${orderServiceviewList.orderProductSeq}" name="v${orderServiceviewList.orderProductSeq}" style="display:none">
																<td colspan="7">
																	<div>
														         		<table class="tableD4">
																 			<colgroup>
																 				<col width="150px">
																 				<col width="*">
																 			</colgroup>
																 			<thead>
																 				<tr class="skyblue">
																 					<th>자원이미지</th>
																 					<th>비고</th>
																 				</tr>
																 			</thead>
																 			<tbody>
																 				<tr>
																 					<td> <img src="${wasPath}/mbr/cmm/file/download/${orderServiceviewList.imageName}" class="w80"/></td>


																 					<td class="tal"> ${orderServiceviewList.description} </td>
																 				</tr>
																 			</tbody>
																 		</table>
																 	</div>
																</td>
															</tr>
														</c:forEach>
														</tbody>
													</table>
								</c:if>
								<!----- 서비스-공통 끝 ------->

								<!----- 서비스-백업 시작 ------->
<%-- 								<c:if test='${orderBakviewList.size() ne 0}'> --%>
<!-- 				 					<div>		   -->
<!-- 				 						<div> -->
<!-- 				 							<h5 class="subtitle"> 백업관리</h5> -->
<!-- 											<div class="panel mb0"> -->
<!-- 												<div> -->
<!-- 													<table class="sumtableV" summary="자원 신청현황 자원정보"> -->
<%-- 														<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 가상서버, 신청금액(원), 상세로 구성</caption>  --%>
<%-- 							 								<colgroup>						 --%>
<%-- 																<col width="80px"> --%>
<%-- 																<col width="80px"> --%>
<%-- 																<col width="120px"> --%>
<%-- 																<col width="*"> --%>
<%-- 																<col width="180px">					 --%>
<%-- 																<col width="120px"> --%>
<%-- 																<col width="80px"> --%>
<%-- 							 								</colgroup> --%>
<!-- 															<thead> -->
<!-- 																<tr class="skyblue">							    -->
<!-- 																	<th>요청유형</th> -->
<!-- 																	<th>과금단위</th> -->
<!-- 																	<th>서비스희망일시</th> -->
<!-- 																	<th>프로젝트</th> -->
<!-- 																	<th>가상서버</th>							 -->
<!-- 																	<th>신청금액(원)</th> -->
<!-- 																	<th>상세</th> -->
<!-- 																</tr> -->
<!-- 															</thead> -->
<!-- 															<tbody> -->
<%-- 															<c:forEach items="${orderBakviewList}" var="orderBakviewList" varStatus="status" >		 --%>
<%-- 															<c:choose> --%>
<%-- 															<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 																<tr class="odd"> -->
<%-- 															</c:when> --%>
<%-- 															<c:otherwise> --%>
<!-- 																<tr class="even"> -->
<%-- 															</c:otherwise> --%>
<%-- 															</c:choose>							     --%>
<%-- 																	<td class="tac"> ${orderBakviewList.requestName} </td> --%>
<!-- 																	<td class="tac">									 -->
<%-- 																		<c:choose> --%>
<%-- 																			<c:when test="${orderBakviewList.hourlyFlag eq 'N'}"> --%>
<!-- 																				월 -->
<%-- 																			</c:when> --%>
<%-- 																			<c:otherwise> --%>
<!-- 																				시간 -->
<%-- 																			</c:otherwise> --%>
<%-- 																		</c:choose> --%>
<!-- 																	</td> -->
<!-- 																	<td class="tac"> -->
<%-- 																		<c:choose> --%>
<%-- 																			<c:when test="${orderBakviewList.onDemandFlag eq 'N'}"> --%>
<%-- 																				${orderBakviewList.applyDatetime} --%>
<%-- 																			</c:when> --%>
<%-- 																			<c:otherwise> --%>
<!-- 																				승인완료 후 생성 -->
<%-- 																			</c:otherwise> --%>
<%-- 																		</c:choose> --%>
<!-- 																	</td> -->
<%-- 																	<td class="tal"> ${orderBakviewList.projectAlias} </td> --%>
<%-- 																	<td class="tal"> ${orderBakviewList.hostnameAlias} </td> --%>
<!-- 																	<td class="tar fc-blue f16 fb"> -->
<%-- 																		<fmt:formatNumber value="${orderBakviewList.amount}" pattern="#,###"/> --%>
<%-- 																		<c:set var="amount" value="${amount + orderBakviewList.amount}" /> --%>
<!-- 																	</td> -->
<!-- 																	<td class="tac">											 -->
<%-- 																		<button type="button" class="tac mt5 table-search" onclick="openPopBack('${orderBakviewList.projectAlias}', '${orderBakviewList.hostname}', '${orderBakviewList.hostnameAlias}', '${orderBakviewList.requestName}', '${orderBakviewList.hourlyFlag}', '${orderBakviewList.onDemandFlag}', '${orderBakviewList.applyDatetime}', '${orderBakviewList.amount}')" ><span></span></button> --%>
<%-- 																		<input type="hidden" id="c${orderBakviewList.orderProductSeq}" name="c${orderBakviewList.orderProductSeq}" value="0" />  --%>
<!-- 																	</td> -->
<!-- 																</tr> -->
<%-- 																<tr id="v${orderBakviewList.orderProductSeq}" name="v${orderBakviewList.orderProductSeq}" style="display:none"> --%>
<!-- 																	<td colspan="7"> -->
<!-- 																		<div> -->
<!-- 																			<table class="tableD4"> -->
<%-- 																				<colgroup> --%>
<%-- 																		 			<col width="150px"> --%>
<%-- 																		 			<col width="*"> --%>
<%-- 																		 		</colgroup> --%>
<!-- 																		 		<thead> -->
<!-- 																		 			<tr class="skyblue"> -->
<!-- 																		 				<th>자원이미지</th>  -->
<!-- 																		 				<th>비고</th> -->
<!-- 																		 			</tr> -->
<!-- 																		 		</thead> -->
<!-- 																		 		<tbody> -->
<!-- 																		 			<tr> -->
<%-- 																		 				<td> <img src="${wasPath}/mbr/cmm/file/download/${orderBakviewList.imageName}" class="w80"/></td>  --%>
<%-- 																		 				<td class="tal"> ${orderBakviewList.description} </td> --%>
<!-- 																					</tr> -->
<!-- 																		 		</tbody> -->
<!-- 																		 	</table> -->
<!-- 																		 </div> -->
<!-- 																	</td> -->
<!-- 																</tr> -->
<%-- 															</c:forEach>	 --%>
<!-- 															</tbody> -->
<!-- 														</table> -->
<!-- 													</div> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<%-- 								</c:if> --%>
								<!----- 서비스-백업 끝 ------->

								<!----- 서비스-형상관리 시작 ------->
<%-- 								<c:if test='${getReqScmOrderList.size() ne 0}'> --%>
<!-- 									<div> 		   -->
<!-- 			 							<div> -->
<!-- 			 								<h5 class="subtitle"> 형상관리서비스</h5> -->
<!-- 											<div class="panel mb0"> -->
<!-- 												<div> -->
<!-- 												    ------자원정보 table 시작-------- -->
<!-- 													<table class="sumtableV" summary="자원 신청현황 자원정보"> -->
<%-- 														<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 신청금액(원), 상세로 구성</caption>  --%>
<%-- 														<colgroup>						  --%>
<%-- 													 		<col width="80px"> --%>
<%-- 															<col width="80px"> --%>
<%-- 												 			<col width="240px"> --%>
<%-- 													 		<col width="*">						 --%>
<%-- 												 			<col width="120px"> --%>
<%-- 												 			<col width="80px"> --%>
<%-- 												 		</colgroup> --%>
<!-- 														<thead> -->
<!-- 															<tr class="skyblue">							     -->
<!-- 																<th>요청유형</th> -->
<!-- 																<th>과금단위</th> -->
<!-- 																<th>서비스희망일시</th> -->
<!-- 																<th>프로젝트</th>								 -->
<!-- 																<th>신청금액(원)</th> -->
<!-- 																<th>상세</th> -->
<!-- 															</tr> -->
<!-- 														</thead> -->

<!-- 														<tbody> -->
<%-- 														<c:forEach items="${getReqScmOrderList}" var="getReqScmOrderList" varStatus="status" > --%>
<%-- 														<c:choose> --%>
<%-- 														<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 															<tr class="odd"> -->
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
<!-- 															<tr class="even"> -->
<%-- 														</c:otherwise> --%>
<%-- 														</c:choose> --%>
<%-- 																<td class="tac"> ${getReqScmOrderList.requestName} </td> --%>
<!-- 																<td class="tac"> -->
<%-- 																	<c:choose> --%>
<%-- 																		<c:when test="${getReqScmOrderList.hourlyFlag eq 'N'}"> --%>
<!-- 																		월 -->
<%-- 																		</c:when> --%>
<%-- 																		<c:otherwise> --%>
<!-- 																		시간 -->
<%-- 																		</c:otherwise> --%>
<%-- 																	</c:choose> --%>
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
<%-- 																	<c:choose> --%>
<%-- 																		<c:when test="${getReqScmOrderList.onDemandFlag eq 'N'}"> --%>
<%-- 																			${getReqScmOrderList.applyDatetime} --%>
<%-- 																		</c:when> --%>
<%-- 																		<c:otherwise> --%>
<!-- 																			승인완료 후 생성 -->
<%-- 																		</c:otherwise> --%>
<%-- 																	</c:choose> --%>
<!-- 																</td> -->
<%-- 																<td class="tal"> ${getReqScmOrderList.projectAlias} </td>								 --%>
<!-- 																<td class="tar fc-blue f16 fb"> -->
<%-- 																	<fmt:formatNumber value="${getReqScmOrderList.amount}" pattern="#,###"/> --%>
<%-- 																	<c:set var="amount" value="${amount + getReqScmOrderList.amount}" /> --%>
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
<%-- 																	<button type="button" class="tac mt5 table-search" onclick="openPopScm('${getReqScmOrderList.projectAlias}', '${getReqScmOrderList.requestName}', '${getReqScmOrderList.hourlyFlag}', '${getReqScmOrderList.onDemandFlag}', '${getReqScmOrderList.applyDatetime}', '${getReqScmOrderList.amount}')" ><span></span></button> --%>
<%-- 																	<input type="hidden" id="c${getReqScmOrderList.orderProductSeq}" name="c${getReqScmOrderList.orderProductSeq}" value="0" /> --%>
<!-- 																</td> -->
<!-- 															</tr> -->
<%-- 															<tr id="v${getReqScmOrderList.orderProductSeq}" name="v${getReqScmOrderList.orderProductSeq}" style="display:none"> --%>
<!-- 																<td colspan="6"> -->
<!-- 													     			<div> -->
<!-- 												         				<table class="tableD4" summary="자원 신청현황 자원이미지"> -->
<%-- 												         					<caption>게시판 목록 : 자원이미지, 비고구성</caption>  --%>
<%-- 														 					<colgroup> --%>
<%-- 																		 		<col width="150px"> --%>
<%-- 																		 		<col width="*"> --%>
<%-- 														 					</colgroup> --%>
<!-- 														 					<thead> -->
<!-- 														 						<tr class="skyblue"> -->
<!-- 														 							<th scope="col">자원이미지</th>  -->
<!-- 														 							<th scope="col">비고</th> -->
<!-- 														 						</tr> -->
<!-- 														 					</thead> -->
<!-- 														 					<tbody> -->
<!-- 														 						<tr> -->
<%-- 														 							<td> <img src="${wasPath}/mbr/cmm/file/download/${getReqScmOrderList.imageName}" class="w80"/></td>  --%>
<%-- 														 							<td class="tal"> ${getReqScmOrderList.description} </td> --%>
<!-- 														 						</tr> -->
<!-- 														 					</tbody> -->
<!-- 														 				</table> -->
<!-- 														 			</div> -->
<!-- 																</td> -->
<!-- 															</tr> -->
<%-- 														</c:forEach>	 --%>
<!-- 														</tbody> -->
<!-- 													</table> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<%-- 								</c:if>		 --%>
								<!----- 서비스-형상관리 끝 ------->

								<!----- 서비스-대외계 시작 ------->
<%-- 								<c:if test='${getReqMcaOrderList.size() ne 0}'> --%>
<!-- 			 						<div>	   -->
<!-- 			 							<div> -->
<!-- 			 								<h5 class="subtitle"> 대외계서비스</h5> -->
<!-- 											<div class="panel mb0"> -->
<!-- 												<div> -->
<!-- 													<table class="sumtableV"> -->
<%-- 														<colgroup>						  --%>
<%-- 													 		<col width="80px"> --%>
<%-- 													 		<col width="80px"> --%>
<%-- 													 		<col width="240px"> --%>
<%-- 													 		<col width="*">						 --%>
<%-- 													 		<col width="120px"> --%>
<%-- 													 		<col width="80px"> --%>
<%-- 													 	</colgroup> --%>
<!-- 														<thead> -->
<!-- 															<tr class="skyblue">							    -->
<!-- 																<th>요청유형</th> -->
<!-- 																<th>과금단위</th> -->
<!-- 																<th>서비스희망일시</th> -->
<!-- 																<th>프로젝트</th> -->
<!-- 																<th>신청금액(원)</th> -->
<!-- 																<th>상세</th> -->
<!-- 															</tr> -->
<!-- 														</thead> -->
<!-- 														<tbody> -->
<%-- 														<c:forEach items="${getReqMcaOrderList}" var="getReqMcaOrderList" varStatus="status" > --%>
<%-- 														<c:choose> --%>
<%-- 														<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 															<tr class="odd"> -->
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
<!-- 															<tr class="even"> -->
<%-- 														</c:otherwise> --%>
<%-- 														</c:choose>							   --%>
<%-- 																<td class="tac"> ${getReqMcaOrderList.requestName} </td> --%>
<!-- 																<td class="tac">																		 -->
<%-- 																	<c:choose> --%>
<%-- 																		<c:when test="${getReqMcaOrderList.hourlyFlag eq 'N'}"> --%>
<!-- 																			월 -->
<%-- 																		</c:when> --%>
<%-- 																		<c:otherwise> --%>
<!-- 																			시간 -->
<%-- 																		</c:otherwise> --%>
<%-- 																	</c:choose> --%>
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
<%-- 																	<c:choose> --%>
<%-- 																		<c:when test="${getReqMcaOrderList.onDemandFlag eq 'N'}"> --%>
<%-- 																			${getReqMcaOrderList.applyDatetime} --%>
<%-- 																		</c:when> --%>
<%-- 																		<c:otherwise> --%>
<!-- 																			승인완료 후 생성 -->
<%-- 																		</c:otherwise> --%>
<%-- 																	</c:choose> --%>
<!-- 																</td> -->
<%-- 																<td class="tal"> ${getReqMcaOrderList.projectAlias} </td>								 --%>
<!-- 																<td class="tar fc-blue f16 fb"> -->
<%-- 																	<fmt:formatNumber value="${getReqMcaOrderList.amount}" pattern="#,###"/> --%>
<%-- 																	<c:set var="amount" value="${amount + getReqMcaOrderList.amount}" /> --%>
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
<%-- 																	<button type="button" class="tac mt5 table-search" onclick="openPopMca('${getReqMcaOrderList.projectAlias}', '${getReqMcaOrderList.requestName}', '${getReqMcaOrderList.hourlyFlag}', '${getReqMcaOrderList.onDemandFlag}', '${getReqMcaOrderList.applyDatetime}', '${getReqMcaOrderList.amount}')" ><span></span></button> --%>
<%-- 																	<input type="hidden" id="c${getReqMcaOrderList.orderProductSeq}" name="c${getReqMcaOrderList.orderProductSeq}" value="0" />  --%>
<!-- 																</td> -->
<!-- 															</tr> -->
<%-- 															<tr id="v${getReqMcaOrderList.orderProductSeq}" name="v${getReqMcaOrderList.orderProductSeq}" style="display:none"> --%>
<!-- 																<td colspan="6"> -->
<!-- 																	<div> -->
<!-- 														         		<table class="tableD4" summary="자원 신청현황 자원이미지"> -->
<%-- 														         			<caption>게시판 목록 : 자원이미지, 비고로 구성</caption>  --%>
<%-- 																 			<colgroup> --%>
<%-- 																 				<col width="150px"> --%>
<%-- 																 				<col width="*"> --%>
<%-- 																 			</colgroup> --%>
<!-- 																 			<thead> -->
<!-- 																 				<tr class="skyblue"> -->
<!-- 																 					<th scope="col">자원이미지</th>  -->
<!-- 																 					<th scope="col">비고</th> -->
<!-- 																 				</tr> -->
<!-- 																 			</thead> -->
<!-- 																 			<tbody> -->
<!-- 																 				<tr> -->
<%-- 																 					<td> <img src="${wasPath}/mbr/cmm/file/download/${getReqMcaOrderList.imageName}" class="w80"/></td>  --%>
<%-- 																 					<td class="tal"> ${getReqMcaOrderList.description} </td> --%>
<!-- 																 				</tr> -->
<!-- 																 			</tbody> -->
<!-- 																 		</table> -->
<!-- 																 	</div> -->
<!-- 																</td> -->
<!-- 															</tr> -->
<%-- 														</c:forEach>	 --%>
<!-- 														</tbody> -->
<!-- 													</table> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<%-- 								</c:if>		 --%>
								<!----- 서비스-대외계 끝 ------->

								<!----- 서비스-통합보안관제 시작 ------->
<%-- 								<c:if test='${getReqSerOrderList.size() ne 0}'> --%>
<!-- 									<div>   -->
<!-- 			 							<div> -->
<!-- 			 								<h5 class="subtitle"> 보안관제서비스</h5> -->
<!-- 											<div class="panel mb0"> -->
<!-- 												<div> -->
<!-- 													<table class="sumtableV"> -->
<%-- 														<colgroup>						  --%>
<%-- 													 		<col width="80px"> --%>
<%-- 													 		<col width="80px"> --%>
<%-- 													 		<col width="240px"> --%>
<%-- 													 		<col width="*">						 --%>
<%-- 													 		<col width="120px"> --%>
<%-- 													 		<col width="80px"> --%>
<%-- 													 	</colgroup> --%>
<!-- 														<thead> -->
<!-- 															<tr class="skyblue">							    -->
<!-- 																<th>요청유형</th> -->
<!-- 																<th>과금단위</th> -->
<!-- 																<th>서비스희망일시</th> -->
<!-- 																<th>프로젝트</th>								 -->
<!-- 																<th>신청금액(원)</th> -->
<!-- 																<th>상세</th> -->
<!-- 															</tr> -->
<!-- 														</thead> -->
<!-- 														<tbody> -->
<%-- 														<c:forEach items="${getReqSerOrderList}" var="getReqSerOrderList" varStatus="status" > --%>
<%-- 														<c:choose> --%>
<%-- 														<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 															<tr class="odd"> -->
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
<!-- 															<tr class="even"> -->
<%-- 														</c:otherwise> --%>
<%-- 														</c:choose>							    --%>
<%-- 																<td class="tac"> ${getReqSerOrderList.requestName} </td> --%>
<!-- 																<td class="tac"> -->
<%-- 																	<c:choose> --%>
<%-- 																		<c:when test="${getReqSerOrderList.hourlyFlag eq 'N'}"> --%>
<!-- 																			월 -->
<%-- 																		</c:when> --%>
<%-- 																		<c:otherwise> --%>
<!-- 																			시간 -->
<%-- 																		</c:otherwise> --%>
<%-- 																	</c:choose> --%>
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
<%-- 																	<c:choose> --%>
<%-- 																		<c:when test="${getReqSerOrderList.onDemandFlag eq 'N'}"> --%>
<%-- 																			${getReqSerOrderList.applyDatetime} --%>
<%-- 																		</c:when> --%>
<%-- 																		<c:otherwise> --%>
<!-- 																			승인완료 후 생성 -->
<%-- 																		</c:otherwise> --%>
<%-- 																	</c:choose> --%>
<!-- 																</td> -->
<%-- 																<td class="tal"> ${getReqSerOrderList.projectAlias} </td>								 --%>
<!-- 																<td class="tar fc-blue f16 fb"> -->
<%-- 																	<fmt:formatNumber value="${getReqSerOrderList.amount}" pattern="#,###"/> --%>
<%-- 																	<c:set var="amount" value="${amount + getReqSerOrderList.amount}" /> --%>
<!-- 																</td> -->
<!-- 																<td class="tac"> -->
<%-- 																	<button type="button" class="tac mt5 table-search" onclick="openPopSer('${getReqSerOrderList.projectAlias}', '${getReqSerOrderList.requestName}', '${getReqSerOrderList.hourlyFlag}', '${getReqSerOrderList.onDemandFlag}', '${getReqSerOrderList.applyDatetime}', '${getReqSerOrderList.amount}')" ><span></span></button> --%>
<%-- 																	<input type="hidden" id="c${getReqSerOrderList.orderProductSeq}" name="c${getReqSerOrderList.orderProductSeq}" value="0" />  --%>
<!-- 																</td> -->
<!-- 															</tr> -->
<%-- 															<tr id="v${getReqSerOrderList.orderProductSeq}" name="v${getReqSerOrderList.orderProductSeq}" style="display:none"> --%>
<!-- 																<td colspan="6"> -->
<!-- 														     		<div> -->
<!-- 													         			<table class="tableD4" summary="자원 신청현황 자원이미지"> -->
<%-- 														         			<caption>게시판 목록 : 자원이미지, 비고로 구성</caption>  --%>
<%-- 																 			<colgroup> --%>
<%-- 																				 <col width="150px"> --%>
<%-- 																				 <col width="*"> --%>
<%-- 																 			</colgroup> --%>
<!-- 																 			<thead> -->
<!-- 																 				<tr class="skyblue"> -->
<!-- 																 					<th scope="col">자원이미지</th>  -->
<!-- 																					 <th scope="col">비고</th> -->
<!-- 																				 </tr> -->
<!-- 																 			</thead> -->
<!-- 																 			<tbody> -->
<!-- 																 				<tr> -->
<%-- 																 					<td> <img src="${wasPath}/mbr/cmm/file/download/${getReqSerOrderList.imageName}" class="w80"/></td>  --%>
<%-- 																 					<td class="tal"> ${getReqSerOrderList.description} </td> --%>
<!-- 																 				</tr> -->
<!-- 																 			</tbody> -->
<!-- 																 		</table> -->
<!-- 																	 </div> -->
<!-- 																</td> -->
<!-- 															</tr> -->
<%-- 														</c:forEach>	 --%>
<!-- 														</tbody> -->
<!-- 													</table> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<%-- 								</c:if> --%>
								<!----- 서비스-통합보안관제 끝 ------->
								<div class="appTotal2 dpno">
									<span class="llabel nanumR">소계<span class="txttotal">(VAT 별도)</span></span>
									<span class="totalwon nanumR"><fmt:formatNumber value="${amount}" pattern="#,###"/><span class="unit">원</span></span>
								</div>

						</c:if>
						<!-----서비스  끝------->
				  </p>
				</div>


	        <button class="a-ccordion up" style="margin-top:20px;">어플리케이션<div class="sum"><li >신규    <span class="fc_dblue"> ${appNew} </span></li> <li>변경   <span class="fc-green"> ${appCh}</span> </li><li>삭제   <span class="fc-orange"> ${appEx}</span> </li></div>  </button>
				<div class="re_subbox">
				  <p>
						<c:set value="useitem" var="subAser"/>
						<c:choose>
						<c:when test="${orderAppviewList.size() ne 0}">
							<c:set var="subAser" value="" />
						</c:when>

						</c:choose>
						<c:if test='${subAser ne ""}'>
							<h5 class="box_grey1 tac p50 fc11 fn"> <img src="${apachePath}/resources/assets/img/icon_no.png"/> 서비스 신청 내역이 없습니다 </h5>
						</c:if>

						<c:if test='${subAser eq ""}'>
							<c:if test='${orderAppviewList.size() ne 0}'>
								<h5 class="f16 fc11 m-b-12">운영배포</h5>
								<table class="tableV" summary="자원 신청현황 자원정보">
									<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 연결용도, 신청금액(원), 상세로 구성</caption>
									<colgroup>
										<col width="80px">
										<col width="80px">
										<col width="120px">
										<col width="120px">
										<col width="180px">
										<col width="120px">
										<col width="120px">
										<col width="120px">
										<col width="120px">
									</colgroup>
									<thead>
										<tr class="skyblue">
											<th scope="col">요청유형</th>
											<th scope="col">과금단위</th>
											<th scope="col">서비스희망일시</th>
											<th scope="col">프로젝트</th>
											<th scope="col">배포 명</th>
											<th scope="col">cpu</th>
											<th scope="col">memory</th>
											<th scope="col">파드 수</th>
											<th scope="col">상세</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${orderAppviewList}" var="orderIpviewList" varStatus="status" >
									<tr>
									<c:choose>
									<c:when test="${status.index%2 eq 0 }">
										<tr class="odd">
									</c:when>
									<c:otherwise>
										<tr class="even">
									</c:otherwise>
									</c:choose>
											<td class="tac"> ${orderIpviewList.requestName} </td>
											<td class="tac">
												<c:choose>
													<c:when test="${orderIpviewList.hourlyFlag eq 'N'}">
														월
													</c:when>
													<c:otherwise>
														시간
													</c:otherwise>
												</c:choose>
											</td>
											<td class="tac">
												<c:choose>
													<c:when test="${orderIpviewList.onDemandFlag eq 'N'}">
														${orderIpviewList.applyDatetime}
													</c:when>
													<c:otherwise>
														승인완료 후 생성
													</c:otherwise>
												</c:choose>
											</td>
											<td class="tac"> ${orderIpviewList.projectName} </td>
											<td class="tac"> ${orderIpviewList.appName} </td>
											<c:choose>
												<c:when test="${orderIpviewList.beforeCpuLimit eq null}">
													<td class="tac"> ${orderIpviewList.cpuLimit} </td>
													<td class="tac"> ${orderIpviewList.memLimit} </td>
													<td class="tac"> ${orderIpviewList.podCnt} </td>
												</c:when>
												<c:otherwise>
													<td class="tac"> ${orderIpviewList.beforeCpuLimit} > ${orderIpviewList.cpuLimit} </td>
													<td class="tac"> ${orderIpviewList.beforeMemLimit} > ${orderIpviewList.memLimit} </td>
													<td class="tac"> ${orderIpviewList.beforePodCnt} > ${orderIpviewList.podCnt} </td>
												</c:otherwise>
											</c:choose>
											<td class="tac"><button type="button" class="cbton bton_lblue" onclick="openPopApp(
											'${orderIpviewList.cloudName}',
											'${orderIpviewList.projectAlias}',
											'${orderIpviewList.projectName}',
											'${orderIpviewList.productCategoryName}',
											'${orderIpviewList.appName}',
											'${orderIpviewList.domainUrl}',
											'${orderIpviewList.deploysDirectory}',
											'${orderIpviewList.cpuLimit}',
											'${orderIpviewList.memLimit}',
											'${orderIpviewList.podCnt}'
											);"><i class="fa fa-search"></i></button></td>
										</tr>

										<tr id="v${orderIpviewList.orderProductSeq}" name="v${orderIpviewList.orderProductSeq}" style="display:none">
											<td colspan="7">
									     		<div>
								         			<table class="tableD4" summary="자원 신청현황 자원이미지">
								         				<caption>게시판 목록 : 자원이미지, 비고로 구성</caption>
								         				<colgroup>
															<col width="150px">
															<col width="*">
														</colgroup>
										 				<thead>
										 					<tr class="skyblue">
										 						<th scope="col">자원이미지</th>
										 						<th scope="col">비고</th>
										 					</tr>
										 				</thead>
										 				<tbody>
										 					<tr>
										 						<td> <img src="${wasPath}/mbr/cmm/file/download/${orderIpviewList.imageName}" class="w80"/></td>
										 						<td class="tal"> ${orderIpviewList.description} </td>
										 					</tr>
										 				</tbody>
										 			</table>
										 		</div>
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</c:if>
						</c:if>
				  </p>
				</div>

				<button class="a-ccordion up" style="margin-top:20px;">개발환경<div class="sum"><li >신규    <span class="fc_dblue"> ${envNew} </span></li> <li>변경   <span class="fc-green"> ${envCh}</span> </li><li>삭제   <span class="fc-orange"> ${envEx}</span> </li></div>  </button>
				<div class="re_subbox">
					<p>
						<c:set value="useitem" var="subEnv"/>
						<c:choose>
							<c:when test="${orderEnvviewList.size() ne 0}">
								<c:set var="subEnv" value="" />
							</c:when>
						</c:choose>
						<c:if test='${subEnv ne ""}'>
							<h5 class="box_grey1 tac p50 fc11 fn"> <img src="${apachePath}/resources/assets/img/icon_no.png"/> 서비스 신청 내역이 없습니다 </h5>
						</c:if>
						<c:if test='${subEnv eq ""}'>
							<c:if test='${orderEnvviewList.size() ne 0}'>
								<table class="tableV" summary="자원 신청현황 자원정보">
									<caption>게시판 목록 : 요청유형, 과금단위, 서비스희망일시, 프로젝트, 연결용도, 신청금액(원), 상세로 구성</caption>
									<colgroup>
										<col width="10%">
										<col width="35%">
										<col width="25%">
										<col width="25%">
										<col width="5%">
									</colgroup>
									<thead>
										<tr class="skyblue">
											<th scope="col">요청유형</th>
											<th scope="col">신청타입</th>
											<th scope="col">개발환경Alias</th>
											<th scope="col">프로젝트</th>
											<th scope="col">상세</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${orderEnvviewList}" var="orderEnvviewList" varStatus="status" >
										<tr>
											<td>${orderEnvviewList.requestName}</td>
											<td>${orderEnvviewList.productCategoryName}</td>
											<td>${orderEnvviewList.envAlias}</td>
											<td>${orderEnvviewList.projectName}</td>
											<td class="tac"><button type="button" class="cbton bton_lblue" onclick="openPopEnv('${orderEnvviewList.cloudName}','${orderEnvviewList.projectName}','${orderEnvviewList.projectAlias}','${orderEnvviewList.productCategoryName}','${orderEnvviewList.envAlias}','${orderEnvviewList.description}');"><i class="fa fa-search"></i></button></td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</c:if>
					</p>
				</div>


				  <div class="clear"></div>

						<!-- begin page-body 버튼박스 -->
					<input type="hidden" id="orderNo" value="${orderNo}">
					<input type="hidden" id="userId" value="${userId}">
					<input type="hidden" id="inject" value="${inject}">
					<div>
						<c:forEach items="${getResourceApprovalStep}" var="resourceApprovalStepInfo" varStatus="status" >
							<c:choose>
								<c:when test="${resourceApprovalStepInfo.apprvAuth eq 'Y'}">
									<c:choose>
										<c:when test="${resourceApprovalStepInfo.apprvState eq 'APPRV_PROCESSING' and resourceApprovalStepInfo.stepLevel < '5'}">
											<div class="tac mt50 mb50">
												<a type="button" class="btn_navy"  onclick="projectApprving('${resourceApprovalStepInfo.stepLevel}','${orderNo}','${resourceApprovalStepInfo.rightStepId}')">승인</a>
												<a type="button" class="btn_line55 ml10" onclick="projectRejectedPopup('${resourceApprovalStepInfo.stepLevel}','${orderNo}','${resourceApprovalStepInfo.rightStepId}')">반려</a>
												<a type="button" class="btn_dgrey ml10" onclick="moveListPage()">목록</a>
											</div>
										</c:when>
										<c:otherwise>
											<c:if test="${resourceApprovalStepInfo.apprvState != 'APPRV_PROCESSING' and resourceApprovalStepInfo.stepId eq stepId }">
												<div class="tac mt50 mb50">
													<a type="button" class="btn_dgrey" onclick="moveListPage()">목록</a>
												</div>
											</c:if>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:if test="${resourceApprovalStepInfo.stepId eq stepId }">
									<div class="tac mt50 mb50">
										<a type="button" class="btn_dgrey" onclick="moveListPage()"> 목록</a>
									</div>
									</c:if>
								</c:otherwise>
							</c:choose>
							<c:if test="${inject eq 'Y' and  resourceApprovalStepInfo.apprvState eq 'APPRV_REJECTED'}">
								<div class="row tac mt50">
									<a type="button" class="btn_dgrey" onclick="moveListPage()"> 목록</a>
								</div>
							</c:if>
						</c:forEach>
					</div>
				 	<!-- end page-body 버튼박스 -->


					</div>
				</div>
				<!-- end #content page-body -->

				<!-- begin #content modal -->
				<!-- 승인완료 -->
				<div class="modal fade" id="modal-dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
                           		<button type="button" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                             	<h4 class="modal-title fw">승인완료</h4>
                          	</div>
                          	<div class="modal-body" id="confirmMsg">
								<h5>승인 처리가 완료 되었습니다. 승인 처리 내용이 신청 담당자한테 메일, SMS를 통해서 전달되었습니다.</h5>
                               	<p class="m-b-20 tac mt20">
									<a type="button"  class="btn btn-grey width-80" data-dismiss="modal" onclick="moveViewPage();">닫기</a>
                               </p>
							</div>
                     	</div>
					</div>
           		</div>

		   <!-- 가상서버 상세 20191223 -->
					<!-- #modal-dialog -->
					<div class="modal fade" id="server-modal-dialog">
		               	<div class="modal-dialog">
		                   	<div class="modal-content">
		                       	<div class="modal-header">
		                           <button type="button" type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                       	   <h4 class="modal-title" id="modal-title">가상서버 상세</h4>
		                       	</div>
		                       	<div class="modal-body">
		                       		 <div  id="popDetailDiv1">
										<p>
											<span class="serverPopLabel2 fl" >프로젝트명</span>
											<span class="serverName fc11 fl lh26 ml5">${projectInfo.projectAlias} </span>
											<span class="pop_pid flr">${projectInfo.projectName}</span>
										</p>
										<p class="fl mt10 clear">
											<span class="serverPopLabel2">서버명</span>
											<span class="nanumR fc11">호스트명은 잘 모르겠음</span>
										</p>
										<p  class="fl mt10 clear">
											<span class="serverPopLabel3" >서비스희망일시</span>
											<span class="serverDate nanumR fc66"> 희망일시가 들어가는데..
											</span>
										</p>
										<p  class="fl mt10 clear">
											<span class="serverPopLabel3">네트워크 </span>
											<span class="serverDate nanumR  fc66">네트워크망이 들어감.</span>
											<span class="serverPopLabel3 ml20">이미지  </span>
											<span class="serverDate nanumR fc66">이미지명이들어감</span>
										</p>
		                       		</div>
		                       		<div class="bottomArea" id="popDetailDiv2">
		                       			<div class="fl mr20 tac">
		                       				<p class="cpuArea nanumR mb5 f36">36</p>
		                       				<p class="fc11">vCPU<span class="fc66 fn">(Core)</span></p>
		                       			</div>
		                       			<div class="fl mr20 tac">
		                       				<p class="memoryArea nanumR mb5 f36">63</p>
		                       				<p class="fc11">MEMORY<span class="fc66 fn">(GB)</span></p>
		                       			</div>
		                       			<div class="fl tac">
		                       				<p class="diskArea nanumR mb5 f26">9999</p>
		                       				<p class="fc11">DISK<span class="fc66 fn">(GB)</span></p>
		                       			</div>
		                       			<div class="fl bottomAreaDetail tal">
		                       				  <li><span class="fc11">요청유형 : </span><span class="fc66 nanumR">신규</span></li>
		                       			</div>
		                       		</div>
								</div>
								<div class="clear"></div>
		                       	<div class="modal-footer tac">
		                   			<a type="button" class="m_btn_navy" data-dismiss="modal">닫기</a>
		                       	</div>
		                   	</div>
		               	</div>
		           	</div>


		           	<!-- 블록2 상세 -->
					<!-- #modal-dialog -->
					<div class="modal fade" id="disk-modal-dialog">
		               	<div class="modal-dialog">
		                   	<div class="modal-content">
		                       	<div class="modal-header">
		                           <button type="button" type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                       	   <h4 class="modal-title" id="disk-title">블록디스크  상세</h4>
		                       	</div>
		                       	<div class="modal-body">
		                       		<div id="blockDetailDiv1">
										<p>
											<span class="serverPopLabel2 fl" >프로젝트명</span>
											<span class="serverName fc11 fl lh26 ml5">프로젝트명이 들어감!!! </span>
											<span class="pop_pid flr">ABCDEFG</span>
										</p>
										<p class="fl mt10 clear">
											<span class="serverPopLabel2">디스크명</span>
											<span class="nanumR fc11">디스크디스크</span>
										</p>
										<p  class="fl mt10 clear">
											<span class="serverPopLabel3" >서비스희망일시</span>
											<span class="serverDate nanumR fc66">승인완료 후 생성</span>
										</p>
										<p  class="fl mt10 clear">
											<span class="serverPopLabel3">서버명 </span>
											<span class="serverDate nanumR  fc66">OA운영</span>
											<span class="serverPopLabel3 ml20">디스크 종류  </span>
											<span class="serverDate nanumR fc66">레드헷 리눅스  7.6</span>
										</p>
		                       		</div>
		                       		<div class="bottomArea"  id="blockDetailDiv2">

		                       			<div class="fl tac center w30">
		                       				<p class="diskArea nanumR mb5 f30">999</p>
		                       				<p class="fc11">DISK<span class="fc66 fn">(GB)</span></p>
		                       			</div>
		                       			<div class="fl bottomAreaDetail tal">
		                       				<!-- <li><span class="fc11">신청금액 : </span><span class="f20 fcr nanumR">81,083,040 <span class="fc66 f14">원</span></span></li>-->
		                       				<li><span class="fc11">요청유형 : </span><span class="fc66 nanumR">신규</span></li>
		                       			</div>
		                       		</div>
								</div>
								<div class="clear"></div>
		                       	<div class="modal-footer tac">
		                   			<a type="button" class="m_btn_navy" data-dismiss="modal">닫기</a>
		                       	</div>
		                   	</div>
		               	</div>
		           	</div>


		           		<!-- 서비스3 상세 -->
					<!-- #modal-dialog -->
					<div class="modal fade" id="service-modal-dialog">
		               	<div class="modal-dialog">
		                   	<div class="modal-content">
		                       	<div class="modal-header">
		                           <button type="button" type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                       	   <h4 class="modal-title" id="service-title">서비스자원  상세</h4>
		                       	</div>
		                       	<div class="modal-body">
		                       	  <div id="serviceDetailDiv1">
		                       	    <table class="m_table">
		                       	      <tbody>
		                       	       <tr>
		                       	          <th>프로젝트ID</th> <td></td>
		                       	       </tr>
		                       	       <tr>
		                       	          <th>프로젝트명</th> <td></td>
		                       	       </tr>
		                       	       <tr>
		                       	          <th>자원유형</th> <td></td>
		                       	       </tr>
		                       	       <tr>
		                       	          <th>서비스 희망일시</th> <td></td>
		                       	       </tr>
		                       	       <tr>
		                       	          <th>서비스 자원명</th> <td></td>
		                       	       </tr>
		                       	       <tr>
		                       	          <th>가상서버</th> <td></td>
		                       	       </tr>
		                       	       <tr>
		                       	          <th>요청내용</th> <td></td>
		                       	       </tr>
		                       	      </tbody>
		                       	    </table>
		                       		<!-- <div id="serviceDetailDiv1">
										<p>
											<span class="serverPopLabel2 fl" >프로젝트명</span>
											<span class="serverName fc11 fl lh26 ml5">프로젝트명이 들어감!!! </span>
											<span class="pop_pid flr">ABCDEFG</span>
										</p>
										<p class="fl mt10 clear">
											<span class="serverPopLabel2">자원유형</span>
											<span class="nanumR fc11">백업관리</span>
										</p>
										<p  class="fl mt10 clear">
											<span class="serverPopLabel3" >서비스희망일시</span>
											<span class="serverDate nanumR fc66">승인완료 후 생성</span>
										</p>
										<p  class="fl mt10 clear">
											<span class="serverPopLabel3">서비스 자원명 </span>
											<span class="serverDate nanumR  fc66">ERP_백업1</span>
											<span class="serverPopLabel3 ml20">가상서버  </span>
											<span class="serverDate nanumR fc66">ERP_웹서버 </span>
										</p>
										<p class="fl mt10 clear">
											<span class="serverPopLabel2">요청내용</span>
											<span class="nanumR fc11">이자ㅓ릳자ㅓ린아ㅓ란머이라ㅓㅁ니아러니아러ㅣㄴ알ㄴ</span>
										</p>
		                       		</div>
		                       		<div class="bottomArea" id="serviceDetailDiv2">
		                       			<ul>
		                       				<li class="fl"><span class="serverPopLabel3">요청유형 : </span><span class="fc66 nanumR">신규</span></li>
		                       				<li class="clear fl mt10"><span class="serverPopLabel3">요청내용 </span></li>
		                       				<li class="clear fl mt10">요청한 내용이 나오면 됩니다. </li>
		                       			</ul>
		                       		</div> -->
								</div>
								</div>
								<div class="clear"></div>

		                       	<div class="modal-footer tac">
		                   			<a type="button" class="m_btn_navy" data-dismiss="modal">닫기</a>
		                       	</div>
		                   	</div>
		               	</div>
		           	</div>


<!-- 			nas 상세 -->

				<div class="modal fade" id="nas-detail-modal-dialog">
				   <div class="modal-dialog">
				       <div class="modal-content">
				           <div class="modal-header">
				               <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				               <h4 class="modal-title" id="popDetailTitle">nas 상세</h4>
				           </div>
				           <div class="modal-body">
				               <div id="nasPopDetailDiv1">
				                   <p>
				                       <span class="serverPopLabel2 fl">프로젝트명</span>
				                       <span class="serverName fc11 fl lh26 ml5">${projectInfo.projectAlias}</span>
				                       <span class="pop_pid flr">${projectInfo.projectName}</span>
				                   </p>
				                   <p class="fl mt10 clear">
				                       <span class="serverPopLabel2">서버명</span>
				                       <span class="nanumR fc11">서버명이 들어갑니다.</span>
				                   </p>
				                   <p class="fl mt10 clear">
				                       <span class="serverPopLabel3">서비스희망일시</span>
				                       <span class="serverDate nanumR fc66">서비스희망일시가 들어갑니다.</span>
				                   </p>
				                   <p class="fl mt10 clear">
				                       <span class="serverPopLabel3">네트워크</span>
				                       <span class="serverDate nanumR fc66">네트워크 정보가 들어갑니다.</span>
				                       <span class="serverPopLabel3 ml20">이미지</span>
				                       <span class="serverDate nanumR fc66">이미지 정보가 들어갑니다.</span>
				                   </p>
				               </div>
				               <div class="bottomArea" id="nasPopDetailDiv2">
				                   <div class="fl mr20 tac">
				                       <p class="cpuArea nanumR mb5 f36">4</p>
				                       <p class="fc11">vCPU<span class="fc66 fn">(Core)</span></p>
				                   </div>
				                   <div class="fl mr20 tac">
				                       <p class="memoryArea nanumR mb5 f36">16</p>
				                       <p class="fc11">MEMORY<span class="fc66 fn">(GB)</span></p>
				                   </div>
				                   <div class="fl tac">
				                       <p class="diskArea nanumR mb5 f26">500</p>
				                       <p class="fc11">DISK<span class="fc66 fn">(GB)</span></p>
				                   </div>
				                   <div class="fl bottomAreaDetail tal">
				                       <li><span class="fc11">요청유형 :</span><span class="fc66 nanumR">신규</span></li>
				                   </div>
				               </div>
				           </div>
				           <div class="clear"></div>
				           <div class="modal-footer tac">
				               <a type="button" class="m_btn_navy" data-dismiss="modal">닫기</a>
				           </div>
				       </div>
				   </div>
				</div>

				<!-- 부가자원/서비스 상세팝업 -->
	           	<div class="modal fade pdManage" id="detail-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title" id='popDetailTitle'>상세내역</h4>
                           </div>
                           <div class="modal-body">
								<div class="modalManagePop">
									<div id="popDetailDivProject"></div>
									<div class="detailBox">
										<div class="boxType01" id='popDetailDiv1'></div>
										<div class="boxType02" id='popDetailDiv2'></div>
									</div>
								</div>
                           </div>
						   <div class="clear"></div>
                             <div class="modal-footer tac">
	                   			<a type="button" class="whiteline" data-dismiss="modal">닫기</a>
                            </div>
                       </div>
	                </div>
	            </div>

				<!-- 반려사유 팝업 -->
				<div class="modal fade" id="modal-dialog-reject">
					<div class="modal-dialog">
						<div class="modal-content w560">
							<div class="modal-header">
 								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
								<h4 class="modal-title">반려 사유</h4>
							</div>
	                       	<div class="modal-body">
								<div class="rejectInfo m-b-20">
									 반려 사유를 상세하게 입력하여 주십시오.
								</div>
								<textarea style="height: 200px" rows="5" placeholder="반려 사유를 입력해주세요." id="apprvDescription" name="apprvDescription" ></textarea>
		                   	</div>
		                   	<div class="modal-footer tac">
                       			<a type="button" class="lbtn" id ="popclose" onclick="projectRejected()">확인</a>
                       			<a type="button" class="rbtn ml10" data-dismiss="modal" id ="popclose">취소</a>
	                       	</div>
		               	</div>
					</div>
                 </div>

				<!-- 승인 반려 팝업 -->
				<div class="modal fade" id="modal-dialog-reject-hits">
					<div class="modal-dialog">
						<div class="modal-content w560">
							<div class="modal-header">
 								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
								<h4 class="modal-title">반려 사유</h4>
							</div>
	                       	<div class="modal-body">
								<div class="rejectInfo m-b-20">
								</div>
								<textarea  rows="5"  id="rejectedApprvDescriptionHits" name="rejectedApprvDescriptionHits" readonly ></textarea>
		                   	</div>
		                   	<div class="modal-footer tac">
		                   	      <a type="button" class="rbtn" data-dismiss="modal" id ="popclose">닫기</a>
	                       	</div>
		               	</div>
					</div>
                 </div>
				<!-- end #content modal -->

				<div class="modal fade" id="app-modal-dialog">
					<div class="modal-dialog">
		               	<div class="modal-content">
		                   	<div class="modal-header">
		                       <button type="button" type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                   	   <h4 class="modal-title" id="app-title">어플리케이션 상세</h4>
		                   	</div>
		                   	<div class="modal-body">
		                    	<div id="appDetailDiv">
								</div>
								<div class="bottomArea" id="appDetailDiv2">
								</div>
							</div>
							<div class="clear"></div>
		                    <div class="modal-footer tac">
		                   		<a type="button" class="m_btn_navy" data-dismiss="modal">닫기</a>
		                    </div>
		               	</div>
		            </div>
				</div>

				<div class="modal fade" id="env-modal-dialog">
		            <div class="modal-dialog">
		               	<div class="modal-content">
		                   	<div class="modal-header">
		                       <button type="button" type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                   	   <h4 class="modal-title" id="env-title">개발환경 상세</h4>
		                   	</div>
		                   	<div class="modal-body">
		                    	<div id="envDetailDiv1">
								</div>
								<div id="envUserList">
								</div>
							</div>
							<div class="clear"></div>
		                    <div class="modal-footer tac">
		                   		<a type="button" class="m_btn_navy" data-dismiss="modal">닫기</a>
		                    </div>
		               	</div>
		            </div>
		        </div>


	            <!-- begin #content footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #conetne footer -->
			</div>
			<!-- end #content -->
		</div>
		<!-- end #page-container -->

		<c:import url="../../include/script.jsp" charEncoding="UTF-8" />
		<script type="text/javascript">
			function openCompleteModal() {
				$("#modal-dialog").modal();
			}

			// 목록 페이지이동
			function moveListPage() {
				location.href = "${wasPath}/mbr/req/catalogue/bssOrderApproveList";
			}
		/* 	//마지막 승인 버튼 누를시
			function lastCustomerApprving(stepLevel,requestSeq,rightStepId) {
				var jsonData = setJsonData();

				$.ajax({
					url : "stepUpdate",
					dataType : "JSON",
				//	type : "POST",
					data : {
						"requestSeq" : requestSeq
						,"stepLevel" :stepLevel
						,"rightStepId":rightStepId
						,"apprvDescription":$("#apprvDescription").val()
					},
					success : function(data) {
						var result = data;
						if(result==1){
							openCompleteModal();
						}else{
							//alert("fail!!");
							moveViewPage();
						}
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}
			//신규 마지막 승인 버튼 누를시
			function newProjectApprv(stepLevel,requestSeq,rightStepId) {
				if(confirm("승인 처리 하시겠습니까?")){
				var jsonData = setJsonData();
				$.ajax({
					url : "insert",
					dataType : "JSON",
					type : "POST",
					data : jsonData,
					success : function(data) {
						var result = data;
						if(result==1){
							lastCustomerApprving(stepLevel,requestSeq,rightStepId);
							openCompleteModal();
						}else{
							alert("fail!!");
							moveViewPage();
						}
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "error:" + error);
					}
				});
				}
			}

			//해지 마지막 승인 버튼 누를시
			function exprProjectApprv(stepLevel,requestSeq,rightStepId) {
				if(confirm("승인 처리 하시겠습니까?")){
				var jsonData = setJsonData();
				$.ajax({
					url : "update",
					dataType : "JSON",
					type : "POST",
					data : jsonData,
					success : function(data) {
						var result = data;
						if(result==1){
							lastCustomerApprving(stepLevel,requestSeq,rightStepId);
							openCompleteModal();
						}else{
							//alert("fail!!");
							moveViewPage();
						}
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "error:" + error);
					}
				});
				}
			}
			function setJsonData(){
				var jsonData = {
						"reqProjectSeq" : $("#orderNo").val()
						, "projectName": $("#projectName").text()
						, "projectAlias": $("#projectAlias").text()
						, "projectDescription":$("#projectDescription").text()
						, "customerId":$("#customerId").text()
						,"projectId" : $("#projectId").val()
						,"requestType" : $("#requestType").val()
						, "apprvDescription" : $("#apprvDescription").val()
						};
				return jsonData;
			} */

			function moveViewPage(){
				//location.reload();
				setLodingFun.blocksFun();
				location.href = "${wasPath}/mbr/req/catalogue/bssOrderApproveView?orderNo=${orderNo}&cloudId=${cloudInfo.cloudId}";
			}

			function viewtr(basketSeq){
				//alert(basketSeq);
				var vbasketSeq = "v"+basketSeq;
				var cbasketSeq = "c"+basketSeq;
				var sbasketSeq = "s"+basketSeq;

				if($("#"+cbasketSeq).val()=="0"){
					$("#"+cbasketSeq).val("1");
					$("#"+vbasketSeq).show();
					$("#"+sbasketSeq).attr("src", '${apachePath}/resources/assets/img/icon_detailview02.png');
				//	$("#"+sbasketSeq).addClass('fa fa-chevron-up');
				}else{
					$("#"+cbasketSeq).val("0");
					$("#"+vbasketSeq).hide();
				//	$("#"+sbasketSeq).removeClass('fa fa-chevron-up');
					$("#"+sbasketSeq).attr("src", '${apachePath}/resources/assets/img/icon_detailview01.png');
				}

			}

			function openPopserver(fixedIps, bakupFixedIps, projectName,vmImageName,description,defaultNetworkName,requestType,beforeVcpus,changeVcpus,beforeMemGb,changeMemGb,projectAlias, hostnameAlias, hostname, requestName, hourlyFlag, onDemandFlag, applyDatetime, amount, vcpus, memGb, vmDiskGb, cloudName) {


				if(description==''){
					description = "요청내용이 없습니다.";
				}

				$("#server-modal-dialog").modal();

				$("#modal-title").html('가상서버 상세내역');
			/* 	$("#popDetailDiv1").html('<p>'
						+'<span class="serverPopLabel2 fl">클라우드</span><span class="fc11 fl lh26 ml5">'+cloudName+'</span>'
						+'<span class="pop_pid flr">'+projectName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel2 fl">프로젝트명</span><span class="fc11 fl lh26 ml5">'+projectAlias+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel2">서버명</span><span class="fc11 ml5">'+(hostnameAlias==null?"":hostnameAlias)+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3" >서비스희망일시</span><span class="fc11 ml5">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">네트워크</span><span class="fc11 ml5">'+defaultNetworkName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">이미지</span><span class="fc11 ml5">'+vmImageName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">요청유형</span><span class="fc11 ml5">'+requestName+'</span>'
					+'</p>');	 */

				$("#popDetailDiv1").html('<table class="m_table">'
						+'<tbody>'
						+'<tr><th>클라우드</th><td>'+cloudName+'</td></tr>'
						+'<tr><th>프로젝트 ID</th><td>'+projectName+'</td></tr>'
						+'<tr><th>프로젝트명</th><td>'+projectAlias+'</td></tr>'
						+'<tr><th>서버명</th><td>'+(hostnameAlias==null?"":hostnameAlias)+'</td></tr>'
						+'<tr><th>서비스 희망일시</th><td>'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</td></tr>'
						+(defaultNetworkName==null?'<tr><th>네트워크</th><td>'+defaultNetworkName+'</td></tr>':'')
						//'<tr><th>네트워크</th><td>'+defaultNetworkName+'</td></tr>'
						+'<tr><th>이미지</th><td>'+vmImageName+'</td></tr>'
						+'<tr><th>요청유형</th><td>'+requestName+'</td></tr>'
						+'<tr><th>요청내용</th><td>'+description+'</td></tr>'
						+'</tbody>'
					+'</table>');



				if(requestType == 'REQTYPE_CHANGE'){
					$("#popDetailDiv2").html(
							'<div class="fl mr20 tac w30">'
							+(changeVcpus==null?"":'<p class="cpuArea nanumR mb5 f20 center">'+changeVcpus+'</p>')
							+ '<p class="fc11">vCPU<span class="fc66 fn">(Core)</span></p>'
							+'</div>'
							+'<div class="fl mr20 tac w30">'
							+(changeMemGb==null?"":'<p class="memoryArea nanumR mb5 f20 center">'+changeMemGb+'</p>')
							+'<p class="fc11">MEMORY<span class="fc66 fn">(GB)</span></p>'
							+'</div>'
							+'<div class="fl tac w30">'
							+(vmDiskGb==null?"":'<p class="diskArea nanumR mb5 f20 center">'+vmDiskGb+'</p>')
							+'<p class="fc11">DISK<span class="fc66 fn">(GB)</span></p>'
							+'</div>'
/* 							+'<div class="clear"></div>'
							+'<ul class="mt30">'
							+'<li class="clear fl"><span class="serverPopLabel3">요청내용 </span></li>'
							+'<li class="clear fl mt10 tal lh24">'+description+'</li>'
							+'</ul>' */
							);
				}else{
					$("#popDetailDiv2").html(
							'<div class="fl mr20 tac w30">'
							+(vcpus==null?"":'<p class="cpuArea nanumR mb5 f20 center">'+vcpus+'</p>')
							+ '<p class="fc11">vCPU<span class="fc66 fn">(Core)</span></p>'
							+'</div>'
							+'<div class="fl mr20 tac w30">'
							+(memGb==null?"":'<p class="memoryArea nanumR mb5 f20 center">'+memGb+'</p>')
							+'<p class="fc11">MEMORY<span class="fc66 fn">(GB)</span></p>'
							+'</div>'
							+'<div class="fl tac w30">'
							+(vmDiskGb==null?"":'<p class="diskArea nanumR mb5 f20 center">'+vmDiskGb+'</p>')
							+'<p class="fc11">DISK<span class="fc66 fn">(GB)</span></p>'
							+'</div>'
/* 							+'<div class="clear"></div>'
							+'<ul class="mt30">'
							+'<li class="clear fl"><span class="serverPopLabel3">요청내용 </span></li>'
							+'<li class="clear fl mt10 tal lh24">'+description+'</li>'
							+'</ul>' */
							);
				}

			}

			function openPopdisk(projectName,diskType,diskName,description,requestType, beforeDiskGb, changeDiskGb, projectAlias, hostname, hostnameAlias, requestName, hourlyFlag, onDemandFlag, applyDatetime, diskGb, amount, cloudName) {

				if(description==''){
					description = "요청내용이 없습니다.";
				}

				$("#disk-modal-dialog").modal();

				$("#disk-title").html('블록디스크  상세내역');
/* 				$("#blockDetailDiv1").html('<p>'
						+'<span class="serverPopLabel2 fl">클라우드</span><span class="fc11 fl lh26 ml5">'+cloudName+'</span>'
						+'<span class="pop_pid flr">'+projectName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel2 fl">프로젝트명</span><span class="fc11 fl lh26 ml5">'+projectAlias+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel2">디스크명</span><span class="fc11 ml5">'+diskName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3" >서비스희망일시</span><span class="fc11 ml5">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">서버명</span><span class="fc11 ml5">'+(hostnameAlias==null?"":hostnameAlias)+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">디스크 종류</span><span class="fc11 ml5">'+diskType+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">요청유형</span><span class="fc11 ml5">'+requestName+'</span>'
					+'</p>'); */

				$("#blockDetailDiv1").html('<table class="m_table">'
						+'<tbody>'
						+'<tr><th>클라우드</th><td>'+cloudName+'</td></tr>'
						+'<tr><th>프로젝트 ID</th><td>'+projectName+'</td></tr>'
						+'<tr><th>프로젝트명</th><td>'+projectAlias+'</td></tr>'
						+'<tr><th>디스크명</th><td>'+diskName+'</td></tr>'
						+'<tr><th>서비스 희망일시</th><td>'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</td></tr>'
						+'<tr><th>서버명</th><td>'+(hostnameAlias==null?"":hostnameAlias)+'</td></tr>'
						+'<tr><th>디스크종류</th><td>'+diskType+'</td></tr>'
						+'<tr><th>요청유형</th><td>'+requestName+'</td></tr>'
						+'</tbody>'
					+'</table>');


				if(requestType == 'REQTYPE_CHANGE'){
					$("#blockDetailDiv2").html('<div class="tac center">'
							+(changeDiskGb==null?"":'<p class="diskArea mb5 f20 center">'+changeDiskGb+'</p>')
							+ '<p class="fc11">DISK<span class="fc66 fn">(GB)</span></p>'
							+'</div>'
							/*+'<div class="clear"></div>'
							+'<ul class="mt30">'
							 +'<li class="clear fl"><span class="serverPopLabel3">요청내용 </span></li>'
							+'<li class="clear fl mt10 tal lh24">'+description+'</li>'
							+'</ul>'*/
							);
				}else{
					$("#blockDetailDiv2").html('<div class="tac center">'
							+(diskGb==null?"":'<p class="diskArea mb5 f20 center">'+diskGb+'</p>')
							+ '<p class="fc11">DISK<span class="fc66 fn">(GB)</span></p>'
							+'</div>'
							/*+'<div class="clear"></div>'
							+'<ul class="mt30">'
							 +'<li class="clear fl"><span class="serverPopLabel3">요청내용 </span></li>'
							+'<li class="clear fl mt10 tal lh24">'+description+'</li>'
							+'</ul>'*/
							);
				}
			}

			function openPopNas(projectAlias, nasName, vmName, requestName, hourlyFlag, onDemandFlag, applyDatetime, nasGb, amount, description, nasVmList, nasAlias, nasOption, cloudType, cloudName, nasFileSystemPath) {
			    if(description == ''){
			        description = "요청내용이 없습니다.";
			    }

			    $("#nas-detail-modal-dialog").modal();
			    $("#popDetailTitle").html('NAS 상세내역');

			    $("#nasPopDetailDiv1").html(
			        '<table class="m_table">'
			        + '<tbody>'
			        + '<tr><th>프로젝트명</th><td>' + projectAlias + '</td></tr>'
			        + '<tr><th>스토리지명</th><td>' + nasAlias + '</td></tr>'
			        + '<tr><th>스토리지 ID</th><td>' + nasName + '</td></tr>'
			        + (cloudType != 'openshift' ? '<tr><th>가상서버명</th><td>' + nasVmList + '</td></tr>' : '')
			        + '<tr><th>자원구분</th><td>' + requestName + '</td></tr>'
			        + '<tr><th>서비스 희망일시</th><td>' + (onDemandFlag == 'N' ? applyDatetime : '승인 완료 후 생성') + '</td></tr>'
			        + '<tr><th>클러스터명</th><td>' + cloudName + '</td></tr>'
			        + '<tr><th>파일경로</th><td>' + nasFileSystemPath + '</td></tr>'
			        + '<tr><th>요청내용</th><td>' + description + '</td></tr>'
			        + '</tbody>'
			        + '</table>'
			    );

			    if(requestName == '변경'){
			        $("#nasPopDetailDiv2").html(
			            '<div class="tac center">'
			            + (nasGb == null ? "" : '<p class="cpuArea changecpuArea nanumR mb5 f20 center">' + nasGb + '</p>')
			            + '<p class="fc11">NAS 용량<span class="fc66 fn">(GB)</span></p>'
			            + '</div>'
			            + '<div class="clear"></div>'
			        );
			    } else {
			        $("#nasPopDetailDiv2").html(
			            '<div class="tac center">'
			            + (nasGb == null ? "" : '<p class="cpuArea nanumR mb5 f20 center">' + nasGb + '</p>')
			            + '<p class="fc11">NAS 용량<span class="fc66 fn">(GB)</span></p>'
			            + '</div>'
			            + '<div class="clear"></div>'
			        );
			    }
			}

			function openPopLb(projectAlias, loadbalancerName, protocol,method, ip, port,loadbalancerVm) {
				$("#detail-modal-dialog").modal();

				$("#detail-modal-dialog #popDetailTitle").html('로드밸런스 상세내역');
				$("#detail-modal-dialog #popDetailDivProject").html('<strong class="title">'+projectAlias+'</strong>');

				$("#detail-modal-dialog #popDetailDiv1").html('<ul>'
						+'<li><span class="title" style="width:135px">로드밸런스명</span><span class="cnt">'+loadbalancerName+'</span></li>'
					+'</ul>');
				$("#detail-modal-dialog #popDetailDiv1").show();

				$("#detail-modal-dialog #popDetailDiv2").html('<ul>'
						+'<li><span class="title">가상서버</span><span class="cnt">'+loadbalancerVm+'</span></li>'
						+'<li><span class="title">Protocol</span><span class="cnt">'+protocol+'</span></li>'
						+'<li><span class="title">Method</span><span class="cnt">'+method+'</span></li>'
						+'<li><span class="title">PORT</span><span class="cnt">'+port+'</span></li>'
					+'</ul>');
			}

			function openPopSn(projectAlias, snapshotName, hostname,diskAlias,description,applyDatetime,onDemandFlag,type) {
				$("#detail-modal-dialog").modal();

				$("#detail-modal-dialog #popDetailTitle").html('스냅샷 상세내역');
				$("#detail-modal-dialog #popDetailDivProject").html('<strong class="title">'+projectAlias+'</strong>');

				$("#detail-modal-dialog #popDetailDiv1").html('<ul>'
						+'<li><span class="title" style="width:135px">스냅샷명</span><span class="cnt">'+snapshotName+'</span></li>'
					+'</ul>');
				$("#detail-modal-dialog #popDetailDiv1").show();
				var html = "<ul>";
				if(type == "신규"){
					type = type;
				} else if(type == "해지"){
					type = "삭제";
				} else if(type == "변경"){
					type = "적용";
				}
				html += '<li><span class=title>요청유형</span><span class="cnt">'+type+'</span></li>';
				html += '<li><span class=title>가상서버</span><span class="cnt">'+hostname+'</span></li>';
				html += '<li><span class="title">디스크</span><span class="cnt">'+diskAlias+'</span></li>';
				if(type == "신규"){
					if(onDemandFlag == "Y"){
						html += '<li><span class="title">생성일시</span><span class="cnt">승인완료 후 생성</span></li>';
					} else {
						html += '<li><span class="title">생성일시</span><span class="cnt">'+applyDatetime+'</span></li>';
					}
				}
				html += '<li><span class="title">설명</span><span class="cnt">'+description+'</span></li>';
				html += '</ul>';
				$("#detail-modal-dialog #popDetailDiv2").html(html);
				$(".boxType03").hide();
			}

			function openPopIp(projectAlias, description, requestName, hourlyFlag, onDemandFlag, applyDatetime, amount) {
				$("#detail-modal-dialog").modal();

				$("#popDetailTitle").html('공인IP 상세내역');
				$("#popDetailDivProject").html('<strong class="title">'+projectAlias+'</strong>');

				$("#popDetailDiv1").html('<ul>'
						+'<li><span class="title">연결정보</span><span class="cnt">'+description+'</span></li>'
					+'</ul>');
				$("#popDetailDiv1").show();

				$("#popDetailDiv2").html('<ul>'
						+'<li><span class="title">요청유형</span><span class="cnt">'+requestName+'</span></li>'
						+'<li><span class="title">과금단위</span><span class="cnt">'+(hourlyFlag == "Y"?"시간":"월")+'</span></li>'
						+'<li><span class="title">희망일시</span><span class="cnt">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span></li>'
					+'</ul>');
				$("#popDetailAmt").html('<strong>'+addcomma(amount)+'</strong><span>&nbsp;원</span>');
			}

// 			function openPopBack(projectAlias, hostname, hostnameAlias, requestName, hourlyFlag, onDemandFlag, applyDatetime, amount) {
// 				$("#detail-modal-dialog").modal();

// 				$("#popDetailTitle").html('백업관리 상세내역');
// 				$("#popDetailDivProject").html('<strong class="title">'+projectAlias+'</strong>');

// 				$("#popDetailDiv1").html('<ul>'
// 						+'<li><span class="title">호스트명</span><span class="cnt">'+(hostnameAlias==null?"":hostnameAlias)+'</span></li>'
// 						+'<li><span class="title">서버명</span><span class="cnt">'+(hostname==null?"":hostname)+'</span></li>'
// 					+'</ul>');
// 				$("#popDetailDiv1").show();

// 				$("#popDetailDiv2").html('<ul>'
// 						+'<li><span class="title">요청유형</span><span class="cnt">'+requestName+'</span></li>'
// 						+'<li><span class="title">과금단위</span><span class="cnt">'+(hourlyFlag == "Y"?"시간":"월")+'</span></li>'
// 						+'<li><span class="title">희망일시</span><span class="cnt">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span></li>'
// 					+'</ul>');
// 				$("#popDetailAmt").html('<strong>'+addcomma(amount)+'</strong><span>&nbsp;원</span>');
// 			}

	function openPopApp(cloudName, projectName, projectAlias, productCategoryName, appName, domainUrl, deploysDirectory, cpuLimit, memLimit, podCnt){
		$("#app-modal-dialog").modal();

		$("#appDetailDiv").html('<table class="m_table">'
			+'<tbody>'
			+'<tr><th>클라우드</th><td>'+cloudName+'</td></tr>'
			+'<tr><th>프로젝트 ID</th><td>'+projectAlias+'</td></tr>'
			+'<tr><th>프로젝트명</th><td>'+projectName+'</td></tr>'
			+'<tr><th>자원유형</th><td>'+productCategoryName+'</td></tr>'
			+'<tr><th>배포명</th><td>'+appName+'</td></tr>'
			+'<tr><th>도메인 주소</th><td>'+domainUrl+'</td></tr>'
			+'<tr><th>Context Dir</th><td>'+deploysDirectory+'</td></tr>'
			+'</tbody>'
			+'</table>');
		$("#appDetailDiv2").html(
			'<div class="fl mr20 tac w30">'
			+(cpuLimit==null?"":'<p class="cpuArea nanumR mb5 f20 center">'+cpuLimit+'</p>')
			+ '<p class="fc11">vCPU<span class="fc66 fn">(Core)</span></p>'
			+'</div>'
			+'<div class="fl mr20 tac w30">'
			+(memLimit==null?"":'<p class="memoryArea nanumR mb5 f20 center">'+memLimit+'</p>')
			+'<p class="fc11">MEMORY<span class="fc66 fn">(GB)</span></p>'
			+'</div>'
			+'<div class="fl tac w30">'
			+(podCnt==null?"":'<p class="diskArea nanumR mb5 f20 center">'+podCnt+'</p>')
			+'<p class="fc11">DISK<span class="fc66 fn">(개)</span></p>'
			+'</div>'
		);
	}

	function openPopEnv(cloudName,projectName,projectAlias,productCategoryName,envAlias,description){
		var orderProductSeq = $("#reqProjectSeq").val();

		if(description == ''){
			description = "요청한 내용이 없습니다.";
		}

		$("#env-modal-dialog").modal();
		$("#env-title").html('개발환경 상세내역');

		$("#envDetailDiv1").html('<table class="m_table">'
				+'<tbody>'
				+'<tr><th>클라우드</th><td>'+cloudName+'</td></tr>'
				+'<tr><th>프로젝트 ID</th><td>'+projectName+'</td></tr>'
				+'<tr><th>프로젝트명</th><td>'+projectAlias+'</td></tr>'
				+'<tr><th>자원유형</th><td>'+productCategoryName+'</td></tr>'
				+'<tr><th>개발환경 Alias</th><td>'+envAlias+'</td></tr>'
				+'<tr><th>요청내용</th><td>'+description+'</td></tr>'
				+'</tbody>'
			+'</table>');
		gridEnvUserList(orderProductSeq);
	}

	function gridEnvUserList(orderProductSeq){
		$.ajax({
			url : "${contextPath}/mbr/req/catalogue/bssEnvUserList",
			dataType : "JSON",
			type : "GET",
			data : {
				orderProductSeq : orderProductSeq
			},
			success : function(data) {
				var html = "";
				html += "<table class='tableV'>";
		        html += "	<colgroup>";
				html += " 		<col width='15%'>";
				html += " 		<col width='15%'>";
				html += " 		<col width='*'>";
				html += " 		<col width='15%'>";
				html += " 	</colgroup>";
				html += "	<thead>";
				html += "	    <tr>";
				html += "			<th>유저명</th>";
				html += "			<th>아이디</th>";
				html += "			<th>이메일</th>";
				html += "			<th>권한</th>";
				html += "		</tr>";
				html += "	</thead>";
				html += "	<tbody>";
				$.each(data, function(key, val){
					html += "		<tr>";
					html += "			<td class='tac'>"+val["envUserName"]+"</td>";
					html += "			<td class='tac'>"+val["envUserId"]+"</td>";
					html += "			<td class='tac'>"+val["envUserEmail"]+"</td>";
					html += "			<td class='tac'>"+val["codeName"]+"</td>";
					html += "		</tr>";
				});
				html += "	</tbody>";
				html += "</table>" ;
				$("#envUserList").html(html);
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}


	function openPopService(projectName,description,serviceProductName,serviceName,serviceTypeName, serviceType, projectAlias, hostname, hostnameAlias, requestName, hourlyFlag, onDemandFlag, applyDatetime, amount,cloudName) {

		if(description == ''){
			description = "요청한 내용이 없습니다.";
		}

		$("#service-modal-dialog").modal();

		$("#service-title").html('서비스 상세내역');
/* 		$("#serviceDetailDiv1").html('<p>'
				+'<span class="serverPopLabel2 fl">클라우드</span><span class="fc11 fl lh26 ml5">'+cloudName+'</span>'
				+'<span class="pop_pid flr">'+projectName+'</span>'
				+'</p>'
				+'<p class="fl mt10 clear">'
				+'<span class="serverPopLabel2 fl">프로젝트명</span><span class="fc11 fl lh26 ml5">'+projectAlias+'</span>'
				+'</p>'
				+'<p class="fl mt10 clear">'
				+'<span class="serverPopLabel2">서비스 자원유형</span><span class="fc11 ml5">'+serviceTypeName+'</span>'
				+'</p>'
				+'<p class="fl mt10 clear">'
				+'<span class="serverPopLabel3" >서비스 희망일시</span><span class="fc11 ml5">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span>'
				+'</p>'
				+'<p class="fl mt10 clear">'
				+'<span class="serverPopLabel3">서비스 자원명</span><span class="fc11 ml5">'+serviceProductName+'</span>'
				+'</p>'
				+'<p class="fl mt10 clear">'
				+'<span class="serverPopLabel3" >가상서버</span><span class="fc11 ml5">'+hostname+'</span>'
				+'</p>'
				+'<p class="fl mt10 clear">'
				+'<span class="serverPopLabel3">요청유형 </span><span class="fc11 ml5">'+requestName+'</span>'
			+'</p>');	 */


		$("#serviceDetailDiv1").html('<table class="m_table">'
				+'<tbody>'
				+'<tr><th>클라우드</th><td>'+cloudName+'</td></tr>'
				+'<tr><th>프로젝트 ID</th><td>'+projectName+'</td></tr>'
				+'<tr><th>프로젝트명</th><td>'+projectAlias+'</td></tr>'
				+'<tr><th>서비스 자원유형</th><td>'+serviceTypeName+'</td></tr>'
				+'<tr><th>서비스 희망일시</th><td>'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</td></tr>'
				+'<tr><th>서비스 자원명</th><td>'+serviceName+'</td></tr>'
				+ (serviceType == 'ASCL' ? '' : '<tr><th>가상서버</th><td>'+hostname+'</td></tr>')
				+'<tr><th>요청유형</th><td>'+requestName+'</td></tr>'
				+'<tr><th>요청내용</th><td>'+description+'</td></tr>'
				+'</tbody>'
			+'</table>');

		$("#serviceDetailDiv2").html('<div>'
				/* +'<ul>'
				+'<li class="clear fl mt10"><span class="serverPopLabel3">요청내용 </span></li>'
				+'<li class="clear fl mt10" style="text-align:left">'+description+'</li>'
				+'</ul>' */
				+'</div>');
	}


// 			function openPopScm(projectAlias, requestName, hourlyFlag, onDemandFlag, applyDatetime, amount){
// 				$("#detail-modal-dialog").modal();

// 				$("#popDetailTitle").html('형상관리서비스  상세내역');
// 				$("#popDetailDivProject").html('<strong class="title">'+projectAlias+'</strong>');

// 				$("#popDetailDiv1").html('');
// 				$("#popDetailDiv1").hide();

// 				$("#popDetailDiv2").html('<ul>'
// 						+'<li><span class="title">요청유형</span><span class="cnt">'+requestName+'</span></li>'
// 						+'<li><span class="title">과금단위</span><span class="cnt">'+(hourlyFlag == "Y"?"시간":"월")+'</span></li>'
// 						+'<li><span class="title">희망일시</span><span class="cnt">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span></li>'
// 					+'</ul>');
// 				$("#popDetailAmt").html('<strong>'+addcomma(amount)+'</strong><span>&nbsp;원</span>');
// 			}

// 			function openPopMca(projectAlias, requestName, hourlyFlag, onDemandFlag, applyDatetime, amount){
// 				$("#detail-modal-dialog").modal();

// 				$("#popDetailTitle").html('대외계서비스  상세내역');
// 				$("#popDetailDivProject").html('<strong class="title">'+projectAlias+'</strong>');

// 				$("#popDetailDiv1").html('');
// 				$("#popDetailDiv1").hide();

// 				$("#popDetailDiv2").html('<ul>'
// 						+'<li><span class="title">요청유형</span><span class="cnt">'+requestName+'</span></li>'
// 						+'<li><span class="title">과금단위</span><span class="cnt">'+(hourlyFlag == "Y"?"시간":"월")+'</span></li>'
// 						+'<li><span class="title">희망일시</span><span class="cnt">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span></li>'
// 					+'</ul>');
// 				$("#popDetailAmt").html('<strong>'+addcomma(amount)+'</strong><span>&nbsp;원</span>');
// 			}

// 			function openPopSer(projectAlias, requestName, hourlyFlag, onDemandFlag, applyDatetime, amount){
// 				$("#detail-modal-dialog").modal();

// 				$("#popDetailTitle").html('보안관제서비스  상세내역');
// 				$("#popDetailDivProject").html('<strong class="title">'+projectAlias+'</strong>');

// 				$("#popDetailDiv1").html('');
// 				$("#popDetailDiv1").hide();

// 				$("#popDetailDiv2").html('<ul>'
// 						+'<li><span class="title">요청유형</span><span class="cnt">'+requestName+'</span></li>'
// 						+'<li><span class="title">과금단위</span><span class="cnt">'+(hourlyFlag == "Y"?"시간":"월")+'</span></li>'
// 						+'<li><span class="title">희망일시</span><span class="cnt">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span></li>'
// 					+'</ul>');
// 				$("#popDetailAmt").html('<strong>'+addcomma(amount)+'</strong><span>&nbsp;원</span>');
// 			}



			// 승인 버튼 시작
			function projectApprving(stepLevel,requestSeq,rightStepId){
				var apprvDescription = $("#apprvDescription").val();
				var jsonData = {
					"requestSeq" : $("#reqProjectSeq").val()
					,"stepLevel" :stepLevel
					,"rightStepId":rightStepId
					,"apprvDescription":apprvDescription
					,"orderUserId" : "${getOrderUserId3.orderUserId}"
					,"apprvUserName" : "${userName}"
					,"apprvUserId" : "${userId}"
				}

				confirmBox2("승인 처리  하시겠습니까?", ajaxProjectApprving, jsonData);
			}

			var rejectStepLevel = "";
			var rejectOrderNo = "";
			var rejectRightStepId = "";
			//미승인 버튼 누를시
			function projectRejectedPopup(stepLevel,requestSeq,rightStepId) {
				$("#modal-dialog-reject").modal();
				rejectStepLevel = stepLevel;
				rejectOrderNo = $("#reqProjectSeq").val();
				rejectRightStepId = rightStepId;
			}


			function ajaxProjectApprving(jsonObj) {
				if(jsonObj.rightStepId != '*') {
					$.ajax({
						url : "${contextPath}/mbr/req/product/stepUpdate",
						dataType : "JSON",
						type : "POST",
						data : jsonObj,
						beforeSend : function(xhr, opts) {
							setLodingFun.blocksFun();
						},
						complete : function() {
							setLodingFun.nonesFun();
						},
						success : function(data) {
							var result = data;
							if(result==1){
								alertBox("승인 처리가 완료 되었습니다.<br>처리 내용이 신청 담당자에게<br>메일, SMS를 통해<br>전달되었습니다.", moveViewPage);
							}else{
								alertBox("fail!!", moveViewPage);
							}
						},
						error : function(request, status, error) {
							alertBox3("code:" + request.status + "\n" + "error:" + error);
						}
					});
				} else if(jsonObj.rightStepId == '*') {
						alertBox("처리중 입니다.<br>잠시만 기다려 주십시오.", waiting);
						var jsonData = setJsonData();
						$.ajax({
							url : "${contextPath}/mbr/req/product/insert",
							dataType : "JSON",
							type : "POST",
							data : jsonData,
							success : function(data) {
								var result = data;
								if(result=1){
									alertBox("승인 처리가 완료 되었습니다.<br>처리 내용이 신청 담당자에게<br>메일, SMS를 통해<br>전달되었습니다.", moveViewPage);
								}else{
									alertBox("fail!!", moveViewPage);
								}
							},
							error : function(request, status, error) {
								alertBox3("code:" + request.status + "\n" + "error:" + error);
							}
						});
				}

			}

			// 반려사유 저장 Fn
			function projectRejected() {
				if( $("#apprvDescription").val()=="" ) {
					$("#apprvDescription").focus();
					alertBox("자원신청 반려시 반려사유를<br>입력해 주시기 바랍니다.");
					return false;
				}

				var jsonData = setJsonData();
				$.ajax({
					url : "${contextPath}/mng/req/product/rejectedUpdate",
					dataType : "JSON",
					//type : "POST",
					data : {
						"requestSeq" : rejectOrderNo
						,"stepLevel" : rejectStepLevel
						,"apprvDescription":$("#apprvDescription").val()
						,"orderUserId" : "${getOrderUserId3.orderUserId}"
						,"apprvUserId" : "${userId}"
					},

					beforeSend : function(xhr, opts) {
						setLodingFun.blocksFun();
					},
					complete : function() {
						setLodingFun.nonesFun();
					},
					success : function(data) {
						var result = data;
						if(result==1){
							alertBox("자원신청이 반려되었습니다.", moveViewPage)
						}else{
							alertBox3("fail!!");
							moveViewPage();
						}
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				})
			}


			function setJsonData(){
				var jsonData = {
						"requestSeq" : $("#reqProjectSeq").val()
						, "onDemandFlag" : $("#onDemandFlag").val()
						,"orderUserId" : "${getOrderUserId3.orderUserId}"
						};
				return jsonData;
			}

			function projectRejectHits() {
				var text = $("#rejectedApprvDescription").val()
				$("#rejectedApprvDescriptionHits").val(text)

				$("#modal-dialog-reject-hits").modal();
			}

			$(document).ready(function() {
				App.init();
				//상세 open close
				$(".detailView").click(function name() {
					$(this).toggleClass('active');
					$(".detailVeiwArea").toggleClass('active');
				});


				//메뉴활성화
				$("#reqStatus").addClass("active");
				$("#goodsReqStatusApprove").addClass("active");

			});

			var acc = document.getElementsByClassName("a-ccordion");
			var i;

			for (i = 0; i < acc.length; i++) {
			  acc[i].addEventListener("click", function() {
			    this.classList.toggle("live");
			    this.classList.toggle("up"); // <== Here
			    var re_subbox = this.nextElementSibling;
			    if (re_subbox.style.maxHeight) {
			      re_subbox.style.maxHeight = null;
			    } else {
			      re_subbox.style.maxHeight = re_subbox.scrollHeight + "px";
			    }
			  });
			}
		</script>
	</body>
</html>