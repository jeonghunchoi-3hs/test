<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
   	<sec:authentication var="roles" property="principal.roles"/>
   		<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

<c:set var="contextPath" value="${wasPath}"></c:set>

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

		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)-->
		<div id="content" class="content">


			<p class="page_title">프로젝트 요청 현황 상세
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 신청 현황  <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/req/project/projectList.do"> 프로젝트 요청 현황  </a><span class="arrow_ab"> &#8227; </span> <b> 프로젝트 요청 현황 상세 </b>
			    </span>
			</p>


			<!-- begin page-body -->
			<div class="row p20 bgwh br10">

						<input type="hidden" id="allOrderNo" value="${orderNo}">
						<input type="hidden" id="stepId" value="${stepId}">
						<input type="hidden" id="userApprvState" value="${userApprvState}">
						<input type="hidden" id="userApprvState" value="${getOrderUserId.orderDatetime}">
						<input type="hidden" id="regUserId" value="${getProjectView.regUserId}">
						<input type="hidden" id="sessionRoles" value="${roles}">
						<input type="hidden" id="sessionUserId" value="${userId}">
						<input type="hidden" id="sessionUserName" value="${userName}">
									<!--  반려사유  -->
						 <input type="hidden" id="orderNo" value="${orderNo}">
						 <input type="hidden" id="userId" value="${userId}">
						 <input type="hidden" id="inject" value="${inject}">
						 <input type="hidden" id="reqProjectSeq" value="${getProjectView.reqProjectSeq}">







			<%-- 	<div class="col-xs-12 mb30 pl0 pr0 mt20">
						<div class="col-xs-6 request">
							<h3 class="request_title">요청부서  </h3>
						 	<div class="col-xs-12 clear mt50">
								<c:forEach items="${getProjectAppSteplist}" var="projectAppSteplistInfo" varStatus="status" >
						 		<c:if test="${projectAppSteplistInfo.stepLevel eq '1'}">
									<div class="col-xs-3 tac pl0 pr0">
								 		<ul class="step00 fl">
								    		<li class="fc11 f18 fb">입안보조</li>
									    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }"> <!--  진행중  -->
										    	<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
										    	<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
										    	<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw fc-red f30"></i></li>
									    	</c:if>
									    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }"> <!-- 승인완료  -->
									    		<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
								        		<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
									    		<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i></li>
									    	</c:if>
									    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }"> <!-- 반려  -->
									    		<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
								        		<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
									    		<li class="mt5 mb5"  onclick="projectRejectHits()"><i class="fa fa-reply fc-orange f30"></i> </li>
									    	</c:if>
									    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">  <!-- 대기  -->
								    	    	<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
									    		<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
									    		<li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i> 대기</li>
									    	</c:if>
									    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_CANCELLED' }"> <!-- 상신 취소  -->
									    		<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
								        		<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
									    		<li class="mt5 mb5"><i class="fa fa-reply fc-khaki f30"></i> </li>
									    	</c:if>
								 		</ul>

								 		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
									 		<p class="ribbon_00">진행중 </p>
								 		</c:if>
								 		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
									 		<p class="ribbon_00">승인완료 </p>
								 		</c:if>
								 		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
									 		<p class="ribbon_re">반려 </p>
								 		</c:if>
								 		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
									 		<p class="ribbon_stay">대기 </p>
								 		</c:if>
								 		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_CANCELLED' }">
									 		<p class="ribbon_can">상신 취소 </p>
								 		</c:if>
									        <p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
								 	</div>
						 		</c:if>

						 		<c:if test="${projectAppSteplistInfo.stepLevel eq '2'}">
									<div class="col-xs-3 pl0 pr0 tac">
								 		<ul class="step01">
								    		<li class="fc11 f18 fb">입안</li>
								   			<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
										   		<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i></li>
									    	</c:if>
									    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
									    	</c:if>
									    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply fc-orange f30"></i> </li>
									    	</c:if>
									    	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-hourglass-half fc66 f30"></i></li>
									    	</c:if>
								 		</ul>

										<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
								 			<p class="ribbon_01">진행중 </p>
								 		</c:if>
								 		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
									 		<p class="ribbon_01">승인완료 </p>
								 		</c:if>
								 		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
									 		<p class="ribbon_re">반려 </p>
								 		</c:if>
								 		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
									 		<p class="ribbon_stay">대기 </p>
								 		</c:if>
									        <p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
								 	</div>
						 		</c:if>

				 	 			<c:if test="${projectAppSteplistInfo.stepLevel eq '3'}">
									<div class="col-xs-3 pl0 pr0 tac">
							 			<ul class="step02">
							    			<li class="fc11 f18 fb">검토 </li>
								    		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
										        <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i>  </li>
							    			</c:if>
								    		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
												<li>${projectAppSteplistInfo.apprvUserDeptName}</li>
												<li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
												<li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i></li>
								    		</c:if>
								    		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply f30 fc-orange"></i></li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i></li>
										    </c:if>
								     	</ul>

								     	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
								     		<p class="ribbon_02">진행중 </p>
								     	</c:if>
								     	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
								     		<p class="ribbon_02">승인완료  </p>
								     	</c:if>
								     	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
								     		<p class="ribbon_re">반려 </p>
								     	</c:if>
										<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
								     	 	<p class="ribbon_stay">대기 </p>
								     	</c:if>
								     		<p class="fc99 f12 tac mt5">${projectAppSteplistInfo.apprvDatetime}</p>
								 	</div>
					 			</c:if>

						 		<c:if test="${projectAppSteplistInfo.stepLevel eq '4'}">
									<div class="col-xs-3 tac pl0 pr0 tac">
										<ul class="step03 flr">
								    		<li class="fc11 f18 fb">승인</li>
									        <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
												<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
												<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5" onclick="projectRejectHits()"><i class="fa fa-reply f30 fc-orange"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i></li>
										    </c:if>
								 		</ul>

										<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
									 		<p class="ribbon_03 fw">진행중 </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
									 		<p class="ribbon_03 fw">승인완료  </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
									 		<p class="ribbon_re fw">반려  </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
									 		<p class="ribbon_stay">대기  </p>
									 	</c:if>
								 			<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
									</div>
					 			</c:if>
					 		</c:forEach>
							</div>
						</div>
						<div class="col-xs-6 approval flr">
							<h3 class="approval_title">승인부서</h3>
						 		<div class="col-xs-12 clear mt50">
						 	 		<c:forEach items="${getProjectAppSteplist}" var="projectAppSteplistInfo" varStatus="status" >
								<c:if test="${projectAppSteplistInfo.stepLevel eq '5'}">
									<div class="col-xs-3 pl0 pr0 tac">
							 			<ul class="step00 fl">
							    			<li class="fc11 f18 fb">입안보조</li>
											<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
												<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
												<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
												<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5" onclick="projectRejectHits()"> <i class="fa fa-reply f30 fc66"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i> </li>
										    </c:if>
									 	</ul>

									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
									 		<p class="ribbon_00">진행중 </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
									 		<p class="ribbon_00">승인완료  </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
									 		<p class="ribbon_re">반려  </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
									 		<p class="ribbon_stay">대기  </p>
									 	</c:if>
								 			<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
						 		</div>
					 			</c:if>
					 			<c:if test="${projectAppSteplistInfo.stepLevel eq '6'}">
									<div class="col-xs-3 pl0 pr0 tac">
								 		<ul class="step04 fl">
								    		<li class="fc11 f18 fb">입안</li>
											<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
												<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
												<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
												<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5" onclick="projectRejectHits()"> <i class="fa fa-reply f30 fc66"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i> </li>
										    </c:if>
									 	</ul>

									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
								 			<p class="ribbon_04">진행중 </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
								 			<p class="ribbon_04">승인완료  </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
									 		<p class="ribbon_re">반려  </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
									 		<p class="ribbon_stay">대기  </p>
									 	</c:if>
									 		<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
							 		</div>
					 			</c:if>

					 			<c:if test="${projectAppSteplistInfo.stepLevel eq '7'}">
									<div class="col-xs-3 pl0 pr0 tac">
							 			<ul class="step05">
								    		<li class="fc11 f18 fb">검토</li>
											<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
												<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
												<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
												<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5" onclick="projectRejectHits()"> <i class="fa fa-reply f30 fc66"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i> </li>
										    </c:if>
									 	</ul>

									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
									 		<p class="ribbon_05">진행중 </p>
									 	</c:if>
								 		<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
									 		<p class="ribbon_05">승인완료  </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
									 		<p class="ribbon_re">반려  </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
									 		<p class="ribbon_stay">대기  </p>
									 	</c:if>
									 		<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
							 		</div>
						 		</c:if>

						 		<c:if test="${projectAppSteplistInfo.stepLevel eq '8'}">
									<div class="col-xs-3 pl0 pr0 tac">
								 		<ul class="step06 flr">
								    		<li class="fc11 f18 fb">승인</li>
											<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
												<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
												<li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
												<li class="mt5 mb5"><i class="fa fa-spinner fa-pulse fa-fw f30 fc-red"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-bell-o f30 fc66"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
											    <li>${projectAppSteplistInfo.apprvUserDeptName}</li>
										        <li class="mt-5">${projectAppSteplistInfo.apprvUserName}</li>
											    <li class="mt5 mb5" onclick="projectRejectHits()"> <i class="fa fa-reply f30 fc66"></i> </li>
										    </c:if>
										    <c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserDeptName}</li>
											    <li class="mt-5">${projectAppSteplistInfo.apprvScheduleUserName}</li>
											    <li class="mt5 mb5"><i class="fa fa-hourglass-half f30 fc66"></i> </li>
										    </c:if>
									 	</ul>

									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_PROCESSING' }">
									 	<p class="ribbon_06 fw">진행중 </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_COMPLETED' }">
									 	<p class="ribbon_06 fw">승인완료  </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_REJECTED' }">
									 	<p class="ribbon_re fw">반려  </p>
									 	</c:if>
									 	<c:if test="${projectAppSteplistInfo.apprvState eq 'APPRV_WAITING' }">
									 	<p class="ribbon_stay">대기  </p>
									 	</c:if>

									 	<p class="fc99 tac f12 mt5">${projectAppSteplistInfo.apprvDatetime}</p>
							 		</div>
						 		</c:if>
							</c:forEach>
						</div>
					</div>
				</div> --%>
				<!--  승인 단계 4단 계 끝!! -->


					<!-- 2023 New 승인  시작 -->
				<div class="col-md-12 pl0 pr0 mb30">
				       <!-- 2023 new  요청부서 start -->
						<div class="col-md-6 dept_request" >
						 <h3 class="dept_request_title">요청부서 </h3>


						<div class="request_line mt20">
							<div class="progress mt30">
							<c:set var="progressbar_width_1" value="0%" />
								<c:forEach items="${getProjectAppSteplist}" var="projectAppSteplistInfo" varStatus="status" >
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
						  <c:forEach items="${getProjectAppSteplist}" var="projectAppSteplistInfo" varStatus="status" >
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
								<c:forEach items="${getProjectAppSteplist}" var="projectAppSteplistInfo" varStatus="status" >
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
						  <c:forEach items="${getProjectAppSteplist}" var="projectAppSteplistInfo" varStatus="status" >
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

<%--  				<div class="viewbox">

				    <span class="pid" id="projectName">${getProjectView.reqProjectName==null?'미지정':getProjectView.reqProjectName}<span class="opa0">.</span> </span>
				    <h3 class="pname dpin ml20" id="projectAlias">${getProjectView.projectAlias}</h3> <!--  <span class="opa0">.</span> 지우지 말것! 꼭 필요함.  -->
				 	<div class="mt20">
					<span class="dpin fb fc-blue2">본부 : </span> <span id="deptName">${fn:split(getProjectView.deptName2,'/')[1]}</span>
					<span class="dpin fb ml40 fc-blue2">처(실) : </span> <span id="deptName">${fn:split(getProjectView.deptName2,'/')[2]}</span>
					<span class="dpin fb ml40 fc-blue2">부서 : </span> <span id="deptName">${fn:split(getProjectView.deptName2,'/')[3]}</span>
				   <span class="dpin fb fc-blue2 ml40">프로젝트 비용 : </span> <span id="projectPrice" ><fmt:formatNumber value="${getProjectView.projectPrice}" pattern="#,###"/></span>천원
				   <span class="dpin fb ml40 fc-blue2">프로젝트 기간  : </span><span id ="projectStartDatetime">${getProjectView.projectStartDatetime}</span> ~ <span id ="projectEndDatetime">${getProjectView.projectEndDatetime}</span>
				 	</div>
				 	<h4 class="ptxt_t">프로젝트 내용</h4>
				 	<%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>
				 	<p class="ptxt"><span id="projectDescription">${fn:replace(getProjectView.projectDescription,newLineChar,br)}</span></p>

				 	<!-- 첨부파일 시작 -->
						<div class="fileList">
							<div class="wrap">
								<strong>첨부파일</strong>
								<ul class="m-t-10">
									<c:forEach items="${file}" var="filelist" varStatus="status" >
										<li>
											<span class="f15 fc11">${filelist.fileName}</span>
											<span class="f15 fc66 fontVdn">(${filelist.fileTranSize})</span>
											<a href="${contextPath}/mbr/cmm/file/download/${filelist.fileId}" class="btn_download ml20"></a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
				    <!-- 첨부파일 끝-
				</div>
				 --%>


 					 <div class="col-md-12 pl0 pr0">
            	   <div class="col-md-6 pl0">
            	     <label class="f16 mb10 f500">프로젝트 ID </label>
            	     <input type="text" class="form-control"  id="projectName"  disabled="disabled" value="${getProjectView.reqProjectName==null?'미지정':getProjectView.reqProjectName}"/>
            	   </div>
            	   <div class="col-md-6 pr0">
            	   <label class="f16 mb10 f500">프로젝트명 </label>
            	   <input type="text"  class="form-control"  id="projectAlias" disabled="disabled" value="${getProjectView.projectAlias}"/>
            	   </div>
            	   <div class="clear"></div>
            	   <div class="project_dd flex align-center">
	            	    <div class="sub"  style="float:left;">
	            	       <label class="f16 mb10">본부 </label>
	            	       <input type="text"  class="form-control"  disabled="disabled" id="deptName" value="${fn:split(getProjectView.deptName2,'/')[1]}"/>
	            	    </div>
	            	    <div class="sub">
	            	       <label class="f16 mb10">처(실) </label>
	            	       <input type="text"  class="form-control"  disabled="disabled"  id="deptName"  value="${fn:split(getProjectView.deptName2,'/')[2]}"/>
            	  		</div>
            	  		<div class="sub">
	            	       <label class="f16 mb10">부서 </label>
	            	       <input type="text"  class="form-control"  disabled="disabled"  value="${fn:split(getProjectView.deptName2,'/')[3]}"/>
            	  		</div>
            	  		<div class="sub">
	            	       <label class="f16 mb10">프로젝트 비용 (천원)</label>
	            	       <input type="text"  class="form-control tar"  disabled="disabled"  id="projectPrice" value='<fmt:formatNumber value="${getProjectView.projectPrice}" pattern="#,###"/>' />
            	  		</div>
            	  		<div class="sub " style="margin-right:0;float:right;">
	            	       <label class="f16 mb10" style="float:initial !important;">프로젝트 기간</label>
	            	       <div class="flex align-center">
		            	       <input type="text" class="form-control dpin" disabled="disabled"  id ="projectStartDatetime" value="${getProjectView.projectStartDatetime}"/>
		            	       <span class="dpin mr10 ml10 lh32"> ~ </span>
		            	       <input type="text" class="form-control dpin" disabled="disabled"  id ="projectEndDatetime" value="${getProjectView.projectEndDatetime}"/>
							</div>
            	  		   </div>
            	  		</div>
            	     </div>



            	     <div class="col-md-12 pl0 pr0 mt20">
            	     <label class="f16 mb10 f500">프로젝트 내용 </label>
            	     <%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>
            	      <input type="text"  class="form-control"  disabled="disabled" id="projectDescription" value="${fn:replace(getProjectView.projectDescription,newLineChar,br)}"/>
            	     </div>
     <%--        	      <div class="col-md-12 pl0 pr0 mt20">
            	      <div class="col-md-8 pl0">
            	       <label class="f16 mb10 f500">첨부파일 </label>
            	       <c:forEach items="${file}" var="filelist" varStatus="status" >
            	       <input type="text"  class="form-control"  disabled="disabled"  value="${filelist.fileName} / (${filelist.fileTranSize})"/>
            	        </c:forEach>
            	      </div>
            	      <div class="col-md-4 pl0" style="margin-top:26px;">
            	       <a href="${contextPath}/mbr/cmm/file/download/${filelist.fileId}" class="btn_rect"><span class="rotate-270"> &#8677; </span></a>
            	      </div>
            	     </div> --%>



            	      <div class="col-md-12 pl0 pr0 mt20">
            	      <div class="col-md-8 pl0">
            	       <label class="f16 mb10 f500">첨부파일 </label>
            	       <c:forEach items="${file}" var="filelist" varStatus="status" >
            	       	<div class="input-group">
            	       <input type="text"  class="form-control"  disabled="disabled"  value="${filelist.fileName} / (${filelist.fileTranSize})"/>
            	      <span class="input-group-btn">
            	       <a href="${contextPath}/mbr/cmm/file/download/${filelist.fileId}" class="btn_rect ml4"><span class="rotate-270"> &#8677; </span></a>
            	       </span>
            	      </div>
            	        </c:forEach>
            	      </div>
            	     </div>


				<div class="col-md-12 pl0 pr0 mt20">
		          	     <h2  class="sub_title mt30"> 클라우드 선택 </h2>
					<div class="col-md-12 pl0 pr0">
					   <c:forEach items="${reqProjectCloudList}" var="reqProjectCloudList" varStatus="status" >

						   <c:if test="${reqProjectCloudList.cloudType eq 'openstack'}">

						   <div class="cloud_oa">
		                 	<ul>
		                 		<h4><input type="checkbox"  class="big_check" disabled checked/> ${reqProjectCloudList.cloudName} </h4>
								<li class="cdesc">${reqProjectCloudList.content}</li>
		                 	</ul>
						   </div>
						   </c:if>

						  <c:if test="${reqProjectCloudList.cloudType eq 'vmware'}">
						   <div class="cloud_dmz">
							<ul>
		                 		<h4><input type="checkbox"  class="big_check" disabled checked/> ${reqProjectCloudList.cloudName} </h4>
								<li class="cdesc">${reqProjectCloudList.content}</li>
		                 	</ul>
						   </div>
						  </c:if>

						  <c:if test="${reqProjectCloudList.cloudType eq 'openshift'}">
						  <div class="cloud_mobile">
		                 	<ul>
		                 		<h4><input type="checkbox"  class="big_check" disabled checked/> ${reqProjectCloudList.cloudName} </h4>
								<li class="cdesc">${reqProjectCloudList.content}</li>
		                 	</ul>
		                  </div>
		                  </c:if>

						  <c:if test="${reqProjectCloudList.cloudType eq 'nutanix'}">
						  <div class="cloud_mobile">
		                 	<ul>
		                 		<h4><input type="checkbox"  class="big_check" disabled checked/> ${reqProjectCloudList.cloudName} </h4>
								<li class="cdesc">${reqProjectCloudList.content}</li>
		                 	</ul>
		                  </div>
		                  </c:if>

					   </c:forEach>
					</div>

					<div class="clear"></div>
					<h2 class="sub_title mt30"> 관리자 정보  </h2>
							<table class="tableV">
								<colgroup>
									<col width="150px">
									<col width="150px">
									<col width="150px">
									<col width="12%">
									<col width="13%">
									<col width="10%">
						<%-- 			<col width="10%"> --%>
									<col width="*">
									<col width="13%">
								</colgroup>
								<thead>
									<tr>
										<th>본부</th>
										<th>처(실)</th>
										<th>부서</th>
										<th>이름(직급)</th>
										<th>사번</th>
										<th>전화번호(사선) </th>
								<!-- 		<th>핸드폰</th> -->
										<th>이메일</th>
										<th>구분</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${managerList}" var="managerList" varStatus="status" >
										<c:if test="${managerList.projectManagerType eq '01' }">
										<tr>
											<td>${fn:split(managerList.deptName2,'/')[1]}</td>
											<td>${fn:split(managerList.deptName2,'/')[2]}</td>
											<td>${fn:split(managerList.deptName2,'/')[3]}</td>
											<td>${managerList.userName} (${managerList.userLevel})</td>
											<td>${managerList.userId}</td>
											<td>${managerList.userTel}</td>
									<%-- 		<td>${managerList.userPhone}</td> --%>
											<td>${managerList.userMail}</td>
											<td>${managerList.projectManagerTypeName}</td>
										</tr>
										</c:if>
								</c:forEach>
								</tbody>
							</table>


			    	<h2 class="sub_title mt30"> 담당자 정보  </h2>
							<table class="tableV">
								<colgroup>
									<col width="150px">
									<col width="150px">
									<col width="150px">
									<col width="12%">
									<col width="13%">
									<col width="10%">
									<%-- <col width="10%"> --%>
									<col width="*">
									<col width="13%">
								</colgroup>
								<thead>
									<tr>
										<th>본부</th>
										<th>처(실)</th>
										<th>부서</th>
										<th>이름(직급)</th>
										<th>사번</th>
										<th>전화번호(사선) </th>
								<!-- 		<th>핸드폰</th> -->
										<th>이메일</th>
										<th>구분</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${managerList}" var="managerList" varStatus="status" >
										<c:if test="${managerList.projectManagerType ne '01' }">
										<tr>
											<td>${fn:split(managerList.deptName2,'/')[1]}</td>
											<td>${fn:split(managerList.deptName2,'/')[2]}</td>
											<td>${fn:split(managerList.deptName2,'/')[3]}</td>
											<td>${managerList.userName} (${managerList.userLevel})</td>
											<td>${managerList.userId}</td>
											<td>${managerList.userTel}</td>
										<%-- 	<td>${managerList.userPhone}</td> --%>
											<td>${managerList.userMail}</td>
											<td>${managerList.projectManagerTypeName}</td>
										</tr>
										</c:if>
								</c:forEach>
								</tbody>
							</table>




			        <div class="clear"></div>
					<c:forEach items="${getProjectAppSteplist}" var="getProjectAppSteplist" varStatus="status" >

						<c:if test="${inject eq 'Y' and  getProjectAppSteplist.apprvState eq 'APPRV_REJECTED'}">
							 <input type="hidden" id="rejectedApprvDescription" value="${getProjectAppSteplist.apprvDescription}">
							<div class="tac mt30">
					            <a onclick="moveWritePage('${getProjectView.reqProjectSeq}');" type="button" class="btn_navy"> 수정</a>
					            <a onclick="projectDeleteCheck()" type="button" class="btn_dngrey ml10"> 삭제</a>
								<a onclick="moveListPage()" type="button" class="btn_lgrey ml10"> 목록</a>
							</div>
						</c:if>
					</c:forEach>

					<c:forEach items="${getProjectAppSteplist}" var="getProjectAppSteplist" varStatus="status" >
						<c:if test="${inject eq 'Y' and  getProjectAppSteplist.apprvState eq 'APPRV_CANCELLED'}">
							<div class="tac mt30">
					            <a onclick="moveWritePage('${getProjectView.reqProjectSeq}');" type="button" class="btn_navy"> 수정 </a>
					            <a onclick="projectDeleteCheck()" type="button" class="btn_lgrey ml10"> 삭제</a>
								<a onclick="moveListPage()" type="button" class="btn_dgrey ml10"> 목록</a>
							</div>
						</c:if>
					</c:forEach>

						<c:if test="${getProjectView.statusFlag eq '01' and inject eq 'N'}">
							<div class="tac mt30">
					            <a onclick="moveWritePage('${getProjectView.reqProjectSeq}');" type="button" class="btn_navy">수정 </a>
					            <a onclick="projectDeleteCheck()" type="button" class="btn_lgrey ml10"> 삭제</a>
								<a onclick="moveListPage()" type="button" class="btn_dgrey ml10"> 목록 </a>
							</div>
						</c:if>



						<c:if test="${getProjectView.statusFlag ne '01' and inject ne 'Y'}">
						<div class="tac mt30">
							<a onclick="moveListPage()" type="button" class="btn_dgrey"> 목록</a>
						</div>
						</c:if>
					</div>

            	   </div>





			  <!-- 프로젝트 신청 반려사유 팝업 -->
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
                       			<a type="button" class="lbtn" id ="popclose" onclick="javascript:projectRejected();">확인</a>

                       			<a type="button" class="rbtn" data-dismiss="modal" id ="popclose">취소</a>
	                       	</div>
		               	</div>
					</div>
                 </div>

                   <!-- 프로젝트 반려팝업 -->
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





			<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">중복체크</h4>
	                       </div>
	                       <div class="modal-body">
	                           <h5>프로젝트 영문명을 입력해주세요 ${namechktext}</h5>
	                           <p class="m-b-20">
	                              <input type="text" id="_projectName"/>
	                              <input type="button" onclick="projectIdCheck();" value="확인">
	                           </p>
	                           <div id="checkMsg" style="color: red"></div>

	                       	</div>
	                       	<div class="modal-footer tac">
	                       		<div id="enableId" style="display: none;">
		                        	<a type="button" class="btn width-100 btn-primary" onclick="setId();">적용</a>
									<a type="button" class="btn width-100 btn-default" data-dismiss="modal" onclick="initModal();">닫기</a>
	                           	</div>
								<div id="unableId" style="display: block;">
									<a type="button" class="btn width-100 btn-default" data-dismiss="modal" onclick="initModal();">닫기</a>
								</div>

	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
		</div>

			 <!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

		// 체크박스 값 세팅
		//function setNetworkVal(){
// 			$("input:checkbox[name='network']").each(function(){
// 				if($(this).val()=="Y"){
// 					$(this).attr("checked",true);
// 				}
// 			});

		//	<c:forEach items="${getProjectNetSlist}" var="getProjectNetSlist" varStatus="status" begin="0" step="1">
		//		<c:if test="${getProjectNetSlist.selectFlag eq 'Y'}">
		//			$("#"+ "${getProjectNetSlist.netDfltKind}").attr("checked", true);
		//		</c:if>
		//	</c:forEach>
		//}

		function moveListPage(){
			location.href="${wasPath}/mbr/req/project/projectList.do";
		}


		function moveWritePage(reqProjectSeq){
			location.href = "${wasPath}/mbr/req/project/projectWrite.do?reqProjectSeq="+reqProjectSeq;
		}

		$(document).ready(function() {
		    App.init();
		    //setNetworkVal();
		    projectManagerList();

		  	//메뉴활성화
			$("#reqStatus").addClass("active");
	 		$("#projectRequestList").addClass("active");

		});



		//승인 버튼 누를시 체크 박스 확인
		function projectApprving(stepLevel,requestSeq,rightStepId){
			var apprvDescription = $("#apprvDescription").val();
			var jsonData = {
					"requestSeq" : $("#allOrderNo").val()
					,"stepLevel" :stepLevel
					,"rightStepId":rightStepId
					,"apprvDescription":apprvDescription
					,"orderUserId" : "${getOrderUserId.orderUserId}"
					,"apprvUserName" : "${userName}"
					,"apprvUserId" : "${userId}"

				}

//			if($("input:checkbox[name='projectIdchk']:checked").length == $("input:checkbox[name='projectIdchk']").length){
//	         	작업자 체크하지 않고 바로 승인스텝 처리
//				confirmBox2("승인 처리  하시겠습니까?", checkWorkUser ,jsonData);
				confirmBox2("승인 처리  하시겠습니까?", ajaxProjectApprving ,jsonData);

//			}else if($("input:checkbox[name='projectIdchk']:checked").length==0 || $("input:checkbox[name='projectIdchk']:checked").length != $("input:checkbox[name='projectIdchk']").length){
// 				alertBox3("체크박스를 확인해 주세요");
//				alertBox3("체크박스를 확인해 주세요");
//			}
		}

		//승인 버튼 누를시 체크박스 후 작업자지정 확인
		function checkWorkUser(jsonData){
			$.ajax({
				url : "${contextPath}/mng/req/product/checkWorkUser",
				dataType : "JSON",
				type : "POST",
				data : {
					"orderNo" : $("#allOrderNo").val()
				},
				success : function(data) {
					var result = data
					if(result > 0){
						alertBox3("작업자를 지정해 주세요.");
					}else{
						ajaxProjectApprving(jsonData);
					}
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}

		function waiting(){
			alertBox("처리중 입니다.<br>잠시만 기다려 주십시오.", waiting);
		}
		function ajaxProjectApprving(jsonObj){
			if(jsonObj.rightStepId != '*'){

				$.ajax({
					url : "${contextPath}/mbr/req/project/stepUpdate",
					dataType : "JSON",
					type : "POST",
					data : jsonObj,
					success : function(data) {
						var result = data;
						if(result==1){
							alertBox("승인 처리가 완료 되었습니다.<br>처리 내용이 신청 담당자에게<br>메일, SMS 를 통해<br>전달되었습니다.", moveViewPage);
						}else{
							alertBox("fail!!", moveViewPage);
						}
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}else if(jsonObj.rightStepId == '*'){
					alertBox("처리중 입니다.<br>잠시만 기다려 주십시오.", waiting);
					var jsonData = setJsonData();
					$.ajax({
						url : "${contextPath}/mng/req/product/insert",
						dataType : "JSON",
						type : "POST",
						data : jsonData,
						success : function(data) {
							var result = data;
							if(result=1){
								alertBox("승인 처리가 완료 되었습니다.<br>처리 내용이 신청 담당자에게<br>메일, SMS, NH With를 통해<br>전달되었습니다.", moveViewPage);
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

		var rejectStepLevel = "";
		var rejectOrderNo = "";
		var rejectRightStepId = "";

		//미승인 버튼 누를시
		function projectRejectedPopup(stepLevel,requestSeq,rightStepId) {
			$("#modal-dialog-reject").modal();
			rejectStepLevel = stepLevel;
			rejectOrderNo = $("#allOrderNo").val();
			rejectRightStepId = rightStepId;
		}

		function projectRejected() {

			if($("#apprvDescription").val()==""){
				$("#apprvDescription").focus();
				alertBox("프로젝트 반려시 반려사유를<br>입력해 주시기 바랍니다.");
				return false;
			}

		var jsonData = setJsonData();
		$.ajax({
			url : "${contextPath}/mbr/req/project/rejectedUpdate",
			dataType : "JSON",
//			type : "POST",
			data : {
				"requestSeq" : rejectOrderNo
				,"stepLevel" : rejectStepLevel
				,"apprvDescription":$("#apprvDescription").val()
				,"regUserId" : $("#regUserId").val()
			},
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("프로젝트 신청이 반려되었습니다.", moveViewPage)
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
					"requestSeq" : $("#allOrderNo").val()
					, "onDemandFlag" : $("#onDemandFlag").val()
					,"regUserId" : $("#regUserId").val()
					};
			return jsonData;
			}

		// 목록 페이지이동
		function moveViewPage(){
			location.href = "${contextPath}/mbr/req/project/projectView.do?reqProjectSeq="+$("#allOrderNo").val();

		}



        //프로젝트 관리자 목록
		function projectManagerList() {

			var i = 0;
			 $("#projectManagerList").dataTable( {
					"processing":true
					,"ordering" : false
					,"destroy" : true
					,"autoWidth":false
					,"serverSide":true
				,"ajax": {
					"url":"${contextPath}/mbr/operation/approveUser/projectManagerList"
					,"type" : "GET"
					,"dateSrc" : ""
					,"data":function (d) {
						d.searchKind = $("#searchKind option:selected").val();
						d.keyword = $("#keyword").val();
						d.programSeq = $("#allOrderNo").val();
					}
				}
				,"columns":[
		        	  {"data":"customername", "class":"tac"}
		        	, {"data":"userName", "class":"tac"}
		        	, {"data":"userId", "class":"tac"}
		        	, {"data":"userPhone", "class":"tac"}
		        	, {"data":"userTel", "class":"tac"}
		        	, {"data":"userMail", "class":"tac"}
		        	/* , {"data":"division", "class":"tac"}  */
		        	, {"data":"projectManagerType", "class":"tac"}
/* 		        	, {"class":"tac"}
 */				]

				,"columnDefs":[
					{"defaultContent" : "", targets:"_all" }
						, {"targets":[6], "render":function(data,type,full){

						    i++;
							if(full.projectManagerType == 01){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="01" selected="selected">실무부서</option><option value="02">시스템관리부서</option><option value="03">위탁운영부서</option></select>';}
							else if(full.projectManagerType == 02){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="01">실무부서</option><option value="02" selected="selected">시스템관리부서</option><option value="03">위탁운영부서</option></select>';}
							else if(full.projectManagerType == 03){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="01">실무부서</option><option value="02">시스템관리부서</option><option value="03" selected="selected">위탁운영부서</option></select>';}
							else{return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="00"></option><option value="01">실무부서</option><option value="02">시스템관리부서</option><option value="03">위탁운영부서</option></select>';}

							}

						}
				]
				,"order": [[3,"desc"]]
				,"lengthMenu": [[10,15], [10, 15]]
				,"language": {
					"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
					, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
				}
				,"sDom":'<"top">rt<"bottom"pi>'
			});

		}

		function projectRejectHits(){

			var text = $("#rejectedApprvDescription").val()
			$("#rejectedApprvDescriptionHits").val(text)

			$("#modal-dialog-reject-hits").modal();

		}

		function projectDeleteCheck(){
			confirmBox("프로젝트를 삭제 하시겠습니까?",projectDelete)
		}
		//프로젝트 req_project, req_project_manager, sr_approval_step   delete
		function projectDelete(){

			$.ajax({
				url : "${wasPath}/mbr/req/project/reqProjectDelete",
				dataType : "JSON",
				type : "POST",
				data : {
					  "reqProjectSeq" : $("#reqProjectSeq").val()
				},
				success : function(data) {
						alertBox("삭제 되었습니다.",moveListPage);
				},
				error : function(request, status, error) {
					if(request.status == '200'){
						alertBox("접속이 만료되었습니다.", logout);
					}else{
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				}
			});
		}




	</script>

</body>

</html>