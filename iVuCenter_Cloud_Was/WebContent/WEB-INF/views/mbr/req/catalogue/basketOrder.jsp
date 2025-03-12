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


			<p class="page_title">일괄 신청
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> <b>일괄 신청 </b>
			    </span>
			</p>

				 <!-- begin page-body -->
				 <div class="row p20 bgwh br10">

				 <form name="orderform"  id="orderform" action="basketOrderNow.do" method="post" >
						<input type="hidden" name="type" id="type" value="basketorderinsert" />
						<input type="hidden" name="basketSeqs" id="basketSeqs" value="" />
						<input type="hidden" name="hiddenUserIdReview" id="hiddenUserIdReview" value="" />
						<input type="hidden" name="hiddenUserNameReview" id="hiddenUserNameReview" value="" />
						<input type="hidden" name="hiddenUserIdApprove" id="hiddenUserIdApprove" value="" />
						<input type="hidden" name="hiddenUserNameApprove" id="hiddenUserNameApprove" value="" />
						<input type="hidden" name="hidden_login_user_id" id="hidden_login_user_id" value="${userId}" />

						<input type="hidden" name="approvalStepListString" id="approvalStepListString" />

						<input type="hidden" name="apprvPass" id="apprvPass"				value="${apprvPass}" />
						<input type="hidden" name="selectApprv" id="selectApprv"			value="" />
				    <!-- end section-container -->
				<c:set var="amount" value="0" />
				<c:set var="hourly" value="" />
				<c:set var="hourlyamount" value="0" />
				<c:set var="monthhourly" value="0" />
			    <!-----기본자원 시작------->
				<h4 class="mb10 titleBuType01 mt20">  기본자원(가상서버) </h4>
				<c:if test='${getBasketlistvo.size() ne 0}'>

				 <!-- begin section-container -->
				 <div class="inbox101">
				 <!-- begin normal input table---------->
				 <div class="panel mb0">
					<div>
					    <!--------자원정보 table 시작---------->
						<table class="tableV">
							<colgroup>
							 <col width="3%">
							 <col width="8%">
							 <col width="10%">
							 <col width="10%">
							 <col width="*">
							 <col width="15%">
							 <col width="10%">
							 <col width="8%">
							 <col width="8%">
							 <col width="8%">
							 <col width="6%">
							 </colgroup>
							<thead>
								<tr>
								    <th> </th>
									<th>요청유형</th>
									<th>클라우드</th>
									<th>서비스희망일시</th>
									<th>프로젝트명</th>
									<th>가상서버명</th>
									<th>가상서버유형</th>
									<th>네트워크</th>
									<th>CPU (Core)</th>
									<th>MEM (GB)</th>
									<th>상세</th>
							</thead>
							<tbody>
							<c:forEach items="${getBasketlistvo}" var="getBasketlistvo" varStatus="status" >
								<c:choose>
									<c:when test="${status.index%2 eq 0 }">
										<tr class="odd">
									</c:when>
									<c:otherwise>
										<tr class="even">
									</c:otherwise>
								</c:choose>
								    <td class="tac nodotteText">
								    	<input type="checkbox" name="projectIdchk" id="${getBasketlistvo.basketSeq}" value="${getBasketlistvo.projectId}" />
								    </td>
									<td class="tac">
										${getBasketlistvo.requestName}
									</td>
									<td class="tac">
								    	${getBasketlistvo.cloudName}
								    </td>
									<td class="tac">
										<!--<c:choose>
											<c:when test="${getBasketlistvo.hourlyFlag eq 'N'}">
												월
											</c:when>
											<c:otherwise>
												시간
											</c:otherwise>
										</c:choose>-->
										<c:choose>
											<c:when test="${getBasketlistvo.onDemandFlag eq 'N'}">
												${getBasketlistvo.applyDatetime}
											</c:when>
											<c:otherwise>
												승인완료 후 생성
											</c:otherwise>
										</c:choose>

									</td>
									<td class="tac">
										<span class="project_name">${getBasketlistvo.projectAlias}</span>
									</td>
									<td class="tac">
										${getBasketlistvo.hostnameAlias}
									</td>
									<td class="tac">
										${getBasketlistvo.instanceType}
									</td>
									<td class="tac">
										${getBasketlistvo.defaultNetworkName}
										${getBasketlistvo.defaultNetworkAlias}<br />
										 <c:set var="networktxt" value=""/>
										 <c:set var="networkChk" value="${fn:split(getBasketlistvo.networkChk,',')}"/>
											<c:forEach items="${networkChk}" var="networkChk" varStatus="status" >
											 	<c:set var="networkChkval" value="${fn:split(networkChk,':')}"/>
												<c:if test='${networkChkval[2] eq "Y"}'>
												<c:set var="networktxt" value="${networktxt} ${networkChkval[1]}"/>
												</c:if>
											 </c:forEach>
											 <c:set var="networktxt" value="${fn:split(networktxt,' ')}"/>
											 <c:out value="${fn:join(networktxt,',')}"/>
									</td>
							<!-- <td class="tar">
										${getBasketlistvo.viewVcpus}
									</td>
									<td class="tar">
									    ${getBasketlistvo.viewMemGb}
									</td>  -->

									<c:if test="${getBasketlistvo.requestName eq '신규' || getBasketlistvo.requestName eq '해지'}">
									<td class="tac"> ${getBasketlistvo.vcpus} </td>
									<td class="tac"> ${getBasketlistvo.memGb} </td>
									</c:if>
									<c:if test="${getBasketlistvo.requestName eq '변경'}">
									<td class="tac"> ${getBasketlistvo.beforeVcpus} <i class="fa fa-arrow-right fc99"></i> ${getBasketlistvo.changeVcpus} </td>
									<td class="tac"> ${getBasketlistvo.beforeMemGb}  <i class="fa fa-arrow-right fc99"></i> ${getBasketlistvo.changeMemGb}</td>
									</c:if>

									<!--<td class="tar fc-blue f16 fb">
										<fmt:formatNumber value="${getBasketlistvo.amount}" pattern="#,###"/>
										<c:choose>
											<c:when test="${getBasketlistvo.hourlyFlag eq 'N'}">
												<c:set var="monthhourly" value="${monthhourly + getBasketlistvo.amount}" />
											</c:when>
											<c:otherwise>
												<c:set var="hourlyamount" value="${hourlyamount + getBasketlistvo.amount}" />
											</c:otherwise>
										</c:choose>
										<c:set var="amount" value="${amount + getBasketlistvo.amount}" />
									</td>  -->
									<td class="tac nodotteText">
									     <%-- <img src="/resources/assets/img/icon_detailview01.png" id="s${getBasketlistvo.basketSeq}" onclick="viewtr('${getBasketlistvo.basketSeq}')"/> --%>
	                                    <button type="button" class="cbton bton_lblue" onclick="openPopserver('${getBasketlistvo.projectName}','${getBasketlistvo.defaultNetworkName}','${getBasketlistvo.osProductName}','${getBasketlistvo.description}','${getBasketlistvo.requestType}','${getBasketlistvo.beforeVcpus}','${getBasketlistvo.changeVcpus}','${getBasketlistvo.beforeMemGb}','${getBasketlistvo.changeMemGb}','${getBasketlistvo.projectAlias}', '${getBasketlistvo.hostnameAlias}', '${getBasketlistvo.hostname}', '${getBasketlistvo.requestName}', '${getBasketlistvo.hourlyFlag}', '${getBasketlistvo.onDemandFlag}', '${getBasketlistvo.applyDatetime}', '${getBasketlistvo.amount}', '${getBasketlistvo.vcpus}', '${getBasketlistvo.memGb}', '${getBasketlistvo.vmDiskGb}', '${getBasketlistvo.datastoreId}')" >

										<i class="fa fa-search"></i></button>
										<input type="hidden" id="c${getBasketlistvo.basketSeq}" name="c${getBasketlistvo.basketSeq}" value="0" />
									</td>
								</tr>
								<!-- <tr id="order-one" class="panel-collapse collapse"> -->
								<tr id="v${getBasketlistvo.basketSeq}" name="v${getBasketlistvo.basketSeq}" style="display:none">
								<td colspan="9" class="p20 bgf9">

								     <div>
							         <table class="tableD4">
									 <colgroup>
									 <col width="200px">
									 <col width="150px">
									 <col width="150px">
									 <col width="150px">
									 <col width="*">
									 </colgroup>
									 <thead>
									 <tr class="skyblue">
									 <th>자원이미지</th>
									 <th>CPU</th>
									 <th>MEM</th>
									 <th>DISK</th>
									 <th>비고</th>
									 </tr>
									 </thead>
									 <tbody>
									 <c:choose>
										<c:when test="${status.index%2 eq 0 }">
											<tr class="odd">
										</c:when>
										<c:otherwise>
											<tr class="even">
										</c:otherwise>
									</c:choose>
									 <td class="tac"> <img src="${wasPath}/mbr/cmm/file/download/${getBasketlistvo.imageName}" class="w70"/></td>
									 <td class="tac">
									 	${getBasketlistvo.vcpus} Core
									 </td>
									 <td class="tac">
									 	${getBasketlistvo.memGb} GB
									 </td>
									 <td class="tac">
									 	${getBasketlistvo.vmDiskGb} GB
									 </td>
									 <td class="tac">
									 	${getBasketlistvo.description}
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
						 <!--------자원정보 table 끝---------->

					</div>
				</div>

				<!-- end normal input table---------->

				</div>
				    <!-- end section-container -->
	            <!-----기본자원 시작------->
				</c:if>
				<c:if test='${getBasketlistvo.size() eq 0}'>
				<h5 class="box_grey1 tac p30 fc11 fn"> <img src="/resources/assets/img/icon_no.png"/> 가상서버 신청 내역이 없습니다</h5>
				</c:if>

				 <!-----부가자원  시작------->
				<h4 class="mb10 mt35 titleBuType01"><span class="vbar mr5"></span> 부가자원(블록디스크)  </h4>

				<c:if test='${getBasketDisklistvo.size()+getBasketNaslistvo.size()+getBasketLblistvo.size()+getBasketIplistvo.size() ne 0}'>
				<div class="inbox101">
				<c:if test='${getBasketDisklistvo.size() ne 0}'>


				 <!-- begin section-container -->

				<!-- begin normal input table---------->
				<div class="panel mb0">
					<div>
					    <!--------자원정보 table 시작---------->
						<table class="tableV">
							 <colgroup>
							 <col width="3%">
							 <col width="8%">
							 <col width="10%">
							 <col width="10%">
							 <col width="*">
							 <col width="15%">
							 <col width="16%">
							 <col width="10%">
							 <col width="6%">
							 </colgroup>
							<thead>
								<tr class="skyblue">
								    <th> </th>
									<th>요청유형</th>
									<th>클라우드</th>
									<th>서비스희망일시</th>
									<th>프로젝트명</th>
									<th>가상서버명</th>
									<th>디스크명</th>
									<th>크기 (GB)</th>
									<th>상세</th>
							</thead>
							<tbody>
							<c:forEach items="${getBasketDisklistvo}" var="getBasketDisklistvo" varStatus="status" >
								<c:choose>
									<c:when test="${status.index%2 eq 0 }">
										<tr class="odd">
									</c:when>
									<c:otherwise>
										<tr class="even">
									</c:otherwise>
								</c:choose>
								    <td class="tac nodotteText">
										<input type="checkbox" name="projectIdchk" id="${getBasketDisklistvo.basketSeq}" value="${getBasketDisklistvo.projectId}" />
									</td>
									<td class="tac">
										${getBasketDisklistvo.requestName}
									</td>
									<td class="tac">
										${getBasketDisklistvo.cloudName}
									</td>
									<td class="tac">
										<!--<c:choose>
											<c:when test="${getBasketDisklistvo.hourlyFlag eq 'N'}">
												월
											</c:when>
											<c:otherwise>
												시간
											</c:otherwise>
										</c:choose>-->
										<c:choose>
											<c:when test="${getBasketDisklistvo.onDemandFlag eq 'N'}">
												${getBasketDisklistvo.applyDatetime}
											</c:when>
											<c:otherwise>
												승인완료 후 생성
											</c:otherwise>
										</c:choose>
									</td>
									<td class="tac">
										${getBasketDisklistvo.projectAlias}
									</td>
									<td class="tac">
									   ${getBasketDisklistvo.hostnameAlias}
									</td>

									<td class="tac">
									   ${getBasketDisklistvo.diskName}
									</td>
									<!-- <td class="tar">
									   ${getBasketDisklistvo.diskGb}
									</td> -->

									<c:if test="${getBasketDisklistvo.requestName eq '신규' || getBasketDisklistvo.requestName eq '해지'}">
									<td class="tac"> ${getBasketDisklistvo.diskGb}  </td>
									 </c:if>
									 <c:if test="${getBasketDisklistvo.requestName eq '변경'}">
									<td class="tac"> ${getBasketDisklistvo.beforeDiskGb}  <i class="fa fa-arrow-right fc99"></i> ${getBasketDisklistvo.changeDiskGb}  </td>
									 </c:if>


									<!-- <td class="tar fc-blue f16 fb">
										<fmt:formatNumber value="${getBasketDisklistvo.amount}" pattern="#,###"/>
										<c:choose>
											<c:when test="${getBasketDisklistvo.hourlyFlag eq 'N'}">
												<c:set var="monthhourly" value="${monthhourly + getBasketDisklistvo.amount}" />
											</c:when>
											<c:otherwise>
												<c:set var="hourlyamount" value="${hourlyamount + getBasketDisklistvo.amount}" />
											</c:otherwise>
										</c:choose>
											<c:set var="amount" value="${amount + getBasketDisklistvo.amount}" />
									</td> -->
									<td class="tac nodotteText">
									     <%-- <img src="/resources/assets/img/icon_detailview01.png" id="s${getBasketDisklistvo.basketSeq}" onclick="viewtr('${getBasketDisklistvo.basketSeq}')"/> --%>
	                                   <button type="button" class="cbton bton_lblue" onclick="openPopdisk('${getBasketDisklistvo.projectName}','${getBasketDisklistvo.description}','${getBasketDisklistvo.diskName}','${getBasketDisklistvo.diskProductName}','${getBasketDisklistvo.requestType}','${getBasketDisklistvo.beforeDiskGb}','${getBasketDisklistvo.changeDiskGb}','${getBasketDisklistvo.projectAlias}', '${getBasketDisklistvo.hostname}', '${getBasketDisklistvo.hostnameAlias}', '${getBasketDisklistvo.requestName}', '${getBasketDisklistvo.hourlyFlag}', '${getBasketDisklistvo.onDemandFlag}', '${getBasketDisklistvo.applyDatetime}', '${getBasketDisklistvo.diskGb}', '${getBasketDisklistvo.amount}')" >

	                                   <i class="fa fa-search"></i></button>
										<input type="hidden" id="c${getBasketDisklistvo.basketSeq}" name="c${getBasketDisklistvo.basketSeq}" value="0" />
									</td>
								</tr>
								<tr id="v${getBasketDisklistvo.basketSeq}" name="v${getBasketDisklistvo.basketSeq}" style="display:none">
								<td colspan="9" class="p20 bgf9">
								     <div>
							         <table class="tableD4">
									 <colgroup>
									 <col width="150px">
									 <col width="300px">
									 <col width="150px">
									 <col width="*">
									 </colgroup>
									 <thead>
									 <tr class="skyblue">
									 <th>자원이미지</th>
									 <th>디스크이름</th>
									 <th>용량</th>
									 <th>비고</th>
									 </tr>
									 </thead>
									 <tbody>
									 <c:choose>
									<c:when test="${status.index%2 eq 0 }">
											<tr class="odd">
										</c:when>
										<c:otherwise>
											<tr class="even">
										</c:otherwise>
									</c:choose>
									 <td class="tac">
									 	<img src="${wasPath}/mbr/cmm/file/download/${getBasketDisklistvo.imageName}" class="w80"/>
									 </td>
									 <td class="tac">
									 	${getBasketDisklistvo.diskName}
									 </td>
									 <td class="tac">
									 	${getBasketDisklistvo.diskGb} GB
									 </td>
									 <td class="tac">
										${getBasketDisklistvo.description}
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
						 <!--------자원정보 table 끝---------->
				</div>
				<!-- end normal input table---------->
				</div>
				    <!-- end section-container -->
	            <!-----블럭디스크 끝------->
				</c:if>

<h4 class="mb10 mt35 titleBuType01"><span class="vbar mr5"></span> NAS  </h4>
<c:if test='${getBasketNaslistvo.size() ne 0}'>
    <!-- begin section-container -->
    <div class="panel mb0">
        <div>
            <!--------자원정보 table 시작---------->
            <table class="tableV">
                <colgroup>
                    <col width="3%">
                    <col width="8%">
                    <col width="10%">
                    <col width="10%">
                    <col width="*">
                    <col width="15%">
                    <col width="16%">
                    <col width="10%">
                    <col width="6%">
                </colgroup>
                <thead>
                    <tr class="skyblue">
                        <th> </th>
                        <th>요청유형</th>
                        <th>클라우드</th>
                        <th>서비스희망일시</th>
                        <th>프로젝트명</th>
                        <th>NAS명</th>
                        <th>NAS 용량</th>
                        <th>가상서버</th>
                        <th>상세</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${getBasketNaslistvo}" var="getBasketNaslistvo" varStatus="status">
                        <c:choose>
                            <c:when test="${status.index % 2 == 0}">
                                <tr class="odd">
                            </c:when>
                            <c:otherwise>
                                <tr class="even">
                            </c:otherwise>
                        </c:choose>
                        <td class="tac nodotteText">
                            <input type="checkbox" name="projectIdchk" id="${getBasketNaslistvo.basketSeq}" value="${getBasketNaslistvo.projectId}" />
                        </td>
                        <td class="tac">
                            ${getBasketNaslistvo.requestName}
                        </td>
                        <td class="tac">
                            ${getBasketNaslistvo.cloudName}
                        </td>
<%--                         <td class="tac">
                            <c:choose>
                                <c:when test="${getBasketNaslistvo.hourlyFlag eq 'N'}">
                                    월
                                </c:when>
                                <c:otherwise>
                                    시간
                                </c:otherwise>
                            </c:choose>
                        </td> --%>
                        <td class="tac">
                            <c:choose>
                                <c:when test="${getBasketNaslistvo.onDemandFlag eq 'N'}">
                                    ${getBasketNaslistvo.applyDatetime}
                                </c:when>
                                <c:otherwise>
                                    승인완료 후 생성
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="tac">
                            ${getBasketNaslistvo.projectAlias}
                        </td>
                        <td class="tac">
                            ${getBasketNaslistvo.nasName}
                        </td>
                        <td class="tac">
                            ${getBasketNaslistvo.nasGb}
                        </td>
                        <td class="tac">
                            ${getBasketNaslistvo.vmName}
                        </td>
                        <td class="tac nodotteText">
                            <button type="button" class="cbton bton_lblue" onclick="openPopNas('${getBasketNaslistvo.projectName}','${getBasketNaslistvo.projectAlias}', '${getBasketNaslistvo.nasName}',
                             '${getBasketNaslistvo.vmName}', '${getBasketNaslistvo.requestName}', '${getBasketNaslistvo.hourlyFlag}', '${getBasketNaslistvo.onDemandFlag}',
                             '${getBasketNaslistvo.applyDatetime}', '${getBasketNaslistvo.nasGb}', '${getBasketNaslistvo.amount}', '${getBasketNaslistvo.description}', '${getBasketNaslistvo.requestType}'
                             )"><i class="fa fa-search"></i></button>
                        </td>

                    <tr id="v${getBasketNaslistvo.basketSeq}" name="v${getBasketNaslistvo.basketSeq}" style="display:none">
                        <td colspan="9" class="p20 bgf9">
                            <div>
                                <table class="tableD4">
                                    <colgroup>
                                        <col width="150px">
                                        <col width="300px">
                                        <col width="150px">
                                        <col width="*">
                                    </colgroup>
                                    <thead>
                                        <tr class="skyblue">
                                            <th>자원이미지</th>
                                            <th>이름</th>
                                            <th>용량</th>
                                            <th>비고</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${status.index % 2 == 0}">
                                                <tr class="odd">
                                            </c:when>
                                            <c:otherwise>
                                                <tr class="even">
                                            </c:otherwise>
                                        </c:choose>
<!--                                         <td class="tac"> -->
<%--                                             <img src="${wasPath}/mbr/cmm/file/download/${getBasketNaslistvo.imageName}" class="w80"/> --%>
<!--                                         </td> -->
                                        <td class="tac">
                                            ${getBasketNaslistvo.nasName}
                                        </td>
                                        <td class="tac">
                                            ${getBasketNaslistvo.nasGb}
                                        </td>
                                        <td class="tac">
                                            ${getBasketNaslistvo.description}
                                        </td>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            <!-------- 자원정보 table 끝 ---------->
        </div>
    </div>
    <!-- end section-container -->
</c:if>


				<c:if test='${getBasketLblistvo.size() ne 0}'>
				<!----로드밸런서 시작------->

				 <!-- begin section-container -->
				 <div >
				 <div >
				 <h5 class="subtitle"> 서비스 로드분산</h5>

				<!-- begin normal input table---------->
				<div class="panel mb0">
					<div>
					    <!--------자원정보 table 시작---------->
						<table class="subtable table-bordered table-hover table-striped table-td-valign-middle">
							 <colgroup>
							 <col width="50px">
							 <col width="70px">
							 <col width="75px">
							 <col width="121px">
							 <col width="*">
							 <col width="180px">
							 <col width="125px">
							 <col width="75px">
							 </colgroup>
							<thead>
								<tr  class="skyblue">
								    <th> </th>
									<th>요청유형</th>
									<th>과금단위</th>
									<th>서비스희망일시</th>
									<th>프로젝트명</th>
									<th>서비스 로드분산명</th>
									<th>신청금액(원)</th>
									<th>상세</th>
							</thead>
							<tbody>
							<c:forEach items="${getBasketLblistvo}" var="getBasketLblistvo" varStatus="status" >
								<c:choose>
									<c:when test="${status.index%2 eq 0 }">
										<tr class="odd">
									</c:when>
									<c:otherwise>
										<tr class="even">
									</c:otherwise>
								</c:choose>
								    <td class="tac nodotteText">
								    	<input type="checkbox" name="projectIdchk" id="${getBasketLblistvo.basketSeq}" value="${getBasketLblistvo.projectId}" />
								    </td>
									<td class="tac">
										${getBasketLblistvo.requestName}
									</td>
									<td class="tac">
										<c:choose>
											<c:when test="${getBasketLblistvo.hourlyFlag eq 'N'}">
												월
											</c:when>
											<c:otherwise>
												시간
											</c:otherwise>
										</c:choose>
									</td>
									<td class="tac">
										<c:choose>
											<c:when test="${getBasketLblistvo.onDemandFlag eq 'N'}">
												${getBasketLblistvo.applyDatetime}
											</c:when>
											<c:otherwise>
												승인완료 후 생성
											</c:otherwise>
										</c:choose>
									</td>
									<td class="tac">
										${getBasketLblistvo.projectAlias}
									</td>
									<td class="tac">
										${getBasketLblistvo.loadbalancerName}
									</td>
									<td class="tar fc-blue f16 fb">
										<fmt:formatNumber value="${getBasketLblistvo.amount}" pattern="#,###"/>
										<c:choose>
											<c:when test="${getBasketLblistvo.hourlyFlag eq 'N'}">
												<c:set var="monthhourly" value="${monthhourly + getBasketLblistvo.amount}" />
											</c:when>
											<c:otherwise>
												<c:set var="hourlyamount" value="${hourlyamount + getBasketLblistvo.amount}" />
											</c:otherwise>
										</c:choose>
										<c:set var="amount" value="${amount + getBasketLblistvo.amount}" />
									</td>
									<td class="tac nodotteText">
									  <%-- <img src="/resources/assets/img/icon_detailview01.png" id="s${getBasketLblistvo.basketSeq}" onclick="viewtr('${getBasketLblistvo.basketSeq}')"/> --%>
									  <button type="button" class="tac table-search" onclick="openPopLb('${getBasketLblistvo.projectAlias}', '${getBasketLblistvo.loadbalancerName}', '${getBasketLblistvo.requestName}', '${getBasketLblistvo.hourlyFlag}', '${getBasketLblistvo.onDemandFlag}', '${getBasketLblistvo.applyDatetime}', '${getBasketLblistvo.amount}')" ><span></span></button>
										<input type="hidden" id="c${getBasketLblistvo.basketSeq}" name="c${getBasketLblistvo.basketSeq}" value="0" />
									</td>
								</tr>
								<tr id="v${getBasketLblistvo.basketSeq}" name="v${getBasketLblistvo.basketSeq}" style="display:none">
								<td colspan="8" class="p20 bgf9">
								     <div>
							         <table class="tableD4">
									 <colgroup>
									 <col width="150px">
									 <col width="170px">
									 <col width="100px">
									 <col width="100px">
									 <col width="100px">
									 <col width="100px">
									 <col width="*">
									 </colgroup>
									 <thead>
									 <tr class="skyblue">
									 <th>자원이미지</th>
									 <th>가상서버</th>
									 <th>로드밸런서이름</th>
									 <th>Protocal</th>
									 <th>Method</th>
									 <th>Monitor Type</th>
									 <th>비고</th>
									 </tr>
									 </thead>
									 <tbody>
									 <c:choose>
									<c:when test="${status.index%2 eq 0 }">
										<tr class="odd">
									</c:when>
									<c:otherwise>
										<tr class="even">
									</c:otherwise>
								</c:choose>
									 <td class="tac"> <img src="${wasPath}/mbr/cmm/file/download/${getBasketLblistvo.imageName}" class="w80"/></td>
									 <td class="tac">${getBasketLblistvo.loadbalancerVm}</td>
									 <td class="tac">${getBasketLblistvo.loadbalancerName}</td>
									 <td class="tac">${getBasketLblistvo.protocolName}</td>
									 <td class="tac">${getBasketLblistvo.methodName}</td>
									 <td class="tac">${getBasketLblistvo.monitorTypeName}</td>
									 <td class="tal">${getBasketLblistvo.description}</td>
									 </tr>
									 </tbody>
									 </table>
									 </div>
								</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						 <!--------자원정보 table 끝---------->

					</div>
					</div>
				</div>
				<!-- end normal input table---------->
				</div>
				    <!-- end section-container -->
	            <!-----로드밸런서 끝 ------->
				</c:if>

				<c:if test='${getBasketIplistvo.size() ne 0}'>
				<!----공인 ip 시작------->

				 <!-- begin section-container -->
				 <div >
				 <div >
				 <h5 class="subtitle"> 공인IP</h5>

				<!-- begin normal input table---------->
				<div class="panel mb0">
					<div>
					    <!--------자원정보 table 시작---------->
						<table class="subtable table-bordered table-hover table-striped table-td-valign-middle">
							  <colgroup>
							 <col width="50px">
							 <col width="70px">
							 <col width="75px">
							 <col width="121px">
							 <col width="*">
							 <col width="180px">
							 <col width="125px">
							 <col width="75px">
							 </colgroup>
							<thead>
								<tr class="skyblue">
								    <th> </th>
									<th>요청유형</th>
									<th>과금단위</th>
									<th>서비스희망일시</th>
									<th>프로젝트명</th>
									<th>연결용도</th>
									<th>신청금액(원)</th>
									<th>상세</th>
							</thead>
							<tbody>
							<c:forEach items="${getBasketIplistvo}" var="getBasketIplistvo" varStatus="status" >
								<c:choose>
									<c:when test="${status.index%2 eq 0 }">
										<tr class="odd">
									</c:when>
									<c:otherwise>
										<tr class="even">
									</c:otherwise>
								</c:choose>
								    <td class="tac nodotteText">
								    	<input type="checkbox" name="projectIdchk" id="${getBasketIplistvo.basketSeq}" value="${getBasketIplistvo.projectId}" />
								    </td>
									<td class="tac">
										${getBasketIplistvo.requestName}
									</td>
									<td class="tac">
										<c:choose>
											<c:when test="${getBasketIplistvo.hourlyFlag eq 'N'}">
												월
											</c:when>
											<c:otherwise>
												시간
											</c:otherwise>
										</c:choose>
									</td>
									<td class="tac">
										<c:choose>
											<c:when test="${getBasketIplistvo.onDemandFlag eq 'N'}">
												${getBasketIplistvo.applyDatetime}
											</c:when>
											<c:otherwise>
												승인완료 후 생성
											</c:otherwise>
										</c:choose>
									</td>
									<td class="tac">
										${getBasketIplistvo.projectAlias}
									</td>
									<td class="tac">
										${getBasketIplistvo.description}
									</td>

									<td class="tar fc-blue f16 fb">
										<fmt:formatNumber value="${getBasketIplistvo.amount}" pattern="#,###"/>
										<c:choose>
											<c:when test="${getBasketIplistvo.hourlyFlag eq 'N'}">
												<c:set var="monthhourly" value="${monthhourly + getBasketIplistvo.amount}" />

											</c:when>
											<c:otherwise>
												<c:set var="hourlyamount" value="${hourlyamount + getBasketIplistvo.amount}" />
											</c:otherwise>
										</c:choose>
										<c:set var="amount" value="${amount + getBasketIplistvo.amount}" />
									</td>
									<td class="tac nodotteText">
									  <%-- <img src="/resources/assets/img/icon_detailview01.png" id="s${getBasketIplistvo.basketSeq}" onclick="viewtr('${getBasketIplistvo.basketSeq}')"/> --%>
									  <button type="button" class="tac table-search" onclick="openPopIp('${getBasketIplistvo.projectAlias}', '${getBasketIplistvo.description}', '${getBasketIplistvo.requestName}', '${getBasketIplistvo.hourlyFlag}', '${getBasketIplistvo.onDemandFlag}', '${getBasketIplistvo.applyDatetime}', '${getBasketIplistvo.amount}')" ><span></span></button>
										<input type="hidden" id="c${getBasketIplistvo.basketSeq}" name="c${getBasketIplistvo.basketSeq}" value="0" />
									</td>
								</tr>
								<tr id="v${getBasketIplistvo.basketSeq}" name="v${getBasketIplistvo.basketSeq}" style="display:none">
								<td colspan="8" class="p20 bgf9">
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
									 <c:choose>
									<c:when test="${status.index%2 eq 0 }">
										<tr class="odd">
									</c:when>
									<c:otherwise>
										<tr class="even">
									</c:otherwise>
								</c:choose>
									 <td class="tac"> <img src="${wasPath}/mbr/cmm/file/download/${getBasketIplistvo.imageName}" class="w80"/></td>
									 <td class="tal">
										${getBasketIplistvo.description}
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
						 <!--------자원정보 table 끝---------->

					</div>
					</div>
				</div>
				<!-- end normal input table---------->
				</div>
				    <!-- end section-container -->
	            <!-----공인 IP 끝 ------->

			<!-----부가자원 끝---------->
				</c:if>

				</div>
				</c:if>
				<c:if test='${getBasketDisklistvo.size()+getBasketNaslistvo.size()+getBasketLblistvo.size()+getBasketIplistvo.size() eq "0"}'>
					<h5 class="box_grey1 tac p30 fc11 fn"> <img src="/resources/assets/img/icon_no.png"/> 부가자원 신청 내역이 없습니다</h5>
				</c:if>
			<!-----서비스  시작------->


				<h4 class="mb10 mt35 titleBuType01"> <span class="vbar mr5"></span> 서비스</h4>
				<c:if test='${getBasketServicelistvo.size() ne "0"}'>
				<div class="inbox101">
<%-- 				<c:if test='${getBasketBaklistvo.size() ne 0}'> --%>

				 <!-- begin section-container -->
<!-- 				  <div >		   -->
<!-- 				 <div > -->
<!-- 				 <h5 class="subtitle"> 백업관리</h5> -->

<!-- 				begin normal input table-------- -->
<!-- 				<div class="panel mb0"> -->
<!-- 					<div> -->
<!-- 					    ------자원정보 table 시작-------- -->
<!-- 						<table class="subtable table-bordered table-hover table-striped table-td-valign-middle"> -->
<%-- 							  <colgroup> --%>
<%-- 							 <col width="50px"> --%>
<%-- 							 <col width="70px"> --%>
<%-- 							 <col width="75px"> --%>
<%-- 							 <col width="121px"> --%>
<%-- 							 <col width="*"> --%>
<%-- 							 <col width="180px">						 --%>
<%-- 							 <col width="125px"> --%>
<%-- 							 <col width="75px"> --%>
<%-- 							 </colgroup> --%>
<!-- 							<thead> -->
<!-- 								<tr class="skyblue"> -->
<!-- 								    <th> </th> -->
<!-- 									<th>요청유형</th> -->
<!-- 									<th>과금단위</th> -->
<!-- 									<th>서비스희망일시</th> -->
<!-- 									<th>프로젝트명</th> -->
<!-- 									<th>서버명</th>							 -->
<!-- 									<th>신청금액(원)</th> -->
<!-- 									<th>상세</th> -->
<!-- 							</thead> -->
<!-- 							<tbody> -->
<%-- 							<c:forEach items="${getBasketBaklistvo}" var="getBasketBaklistvo" varStatus="status" >		 --%>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 										<tr class="odd"> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<tr class="even"> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose>	 --%>
<!-- 								    <td class="tac nodotteText"> -->
<%-- 								    	<input type="checkbox" name="projectIdchk" id="${getBasketBaklistvo.basketSeq}" value="${getBasketBaklistvo.projectId}" /> --%>
<!-- 								    </td> -->
<!-- 									<td class="tac"> -->
<%-- 										${getBasketBaklistvo.requestName} --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketBaklistvo.hourlyFlag eq 'N'}"> --%>
<!-- 												월 -->
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<!-- 												시간 -->
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketBaklistvo.onDemandFlag eq 'N'}"> --%>
<%-- 												${getBasketBaklistvo.applyDatetime} --%>
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<!-- 												승인완료 후 생성 -->
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										${getBasketBaklistvo.projectAlias} --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										${getBasketBaklistvo.hostnameAlias} --%>
<!-- 									</td> -->
<!-- 									<td class="tar fc-blue f16 fb"> -->
<%-- 										<fmt:formatNumber value="${getBasketBaklistvo.amount}" pattern="#,###"/> --%>
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketBaklistvo.hourlyFlag eq 'N'}"> --%>
<%-- 												<c:set var="monthhourly" value="${monthhourly + getBasketBaklistvo.amount}" />											 --%>
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<%-- 												<c:set var="hourlyamount" value="${hourlyamount + getBasketBaklistvo.amount}" /> --%>
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<%-- 										<c:set var="amount" value="${amount + getBasketBaklistvo.amount}" /> --%>
<!-- 									</td> -->
<!-- 									<td class="tac nodotteText">  -->
<%-- 									  <img src="/resources/assets/img/icon_detailview01.png" id="s${getBasketBaklistvo.basketSeq}" onclick="viewtr('${getBasketBaklistvo.basketSeq}')"/> --%>
<%-- 										<button type="button" class="tac table-search" onclick="openPopBack('${getBasketBaklistvo.projectAlias}', '${getBasketBaklistvo.hostname}', '${getBasketBaklistvo.hostnameAlias}', '${getBasketBaklistvo.requestName}', '${getBasketBaklistvo.hourlyFlag}', '${getBasketBaklistvo.onDemandFlag}', '${getBasketBaklistvo.applyDatetime}', '${getBasketBaklistvo.amount}')" ><span></span></button> --%>
<%-- 										<input type="hidden" id="c${getBasketBaklistvo.basketSeq}" name="c${getBasketBaklistvo.basketSeq}" value="0" />  --%>
<!-- 									</td> -->
<!-- 								</tr> -->
<%-- 								<tr id="v${getBasketBaklistvo.basketSeq}" name="v${getBasketBaklistvo.basketSeq}" style="display:none"> --%>
<!-- 								<td colspan="8" class="p20 bgf9"> -->
<!-- 								     <div> -->
<!-- 							         <table class="tableD4"> -->
<%-- 									 <colgroup> --%>
<%-- 									 <col width="150px"> --%>
<%-- 									 <col width="*"> --%>
<%-- 									 </colgroup> --%>
<!-- 									 <thead> -->
<!-- 									 <tr class="skyblue"> -->
<!-- 									 <th>자원이미지</th>  -->
<!-- 									 <th>비고</th> -->
<!-- 									 </tr> -->
<!-- 									 </thead> -->
<!-- 									 <tbody> -->
<%-- 									 <c:choose> --%>
<%-- 									<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 										<tr class="odd"> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<tr class="even"> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose>	 --%>
<%-- 									 <td class="tac"> <img src="${wasPath}/mbr/cmm/file/download/${getBasketBaklistvo.imageName}" class="w80"/></td>  --%>
<!-- 									 <td class="tal"> -->
<%-- 									 	${getBasketBaklistvo.description} --%>
<!-- 									 </td> -->
<!-- 									 </tr> -->
<!-- 									 </tbody> -->
<!-- 									 </table> -->
<!-- 									 </div> -->
<!-- 								</td> -->
<!-- 								</tr> -->
<%-- 							</c:forEach>	 --%>
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 						 ------자원정보 table 끝-------- -->

<!-- 					</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				end normal input table-------- -->
<!-- 				</div> -->
				    <!-- end section-container -->
	            <!-----백업 끝------->
<%-- 				</c:if> --%>

				<!-- 서비스 시작 -->
				<c:if test='${getBasketServicelistvo.size() ne 0}'>

				 <!-- begin section-container -->


				<!-- begin normal input table---------->
				<div class="panel mb0">
					<div>
					    <!--------자원정보 table 시작---------->
						<table class="tableV">
							  <colgroup>
							 <col width="3%">
							 <col width="8%">
							 <col width="10%">
							 <col width="10%">
							 <col width="15%">
							 <col width="15%">
							 <col width="*">
							 <col width="10%">
							  <col width="6%">
							 </colgroup>
							<thead>
								<tr class="skyblue">
								    <th> </th>
									<th>요청유형</th>
									<th>클라우드</th>
	 								<th>서비스희망일시</th>
	 								<th>프로젝트명</th>
	 								<th>가상서버</th>
									<th>서비스명</th>
									<th>서비스 유형</th>
									<th>상세</th>
							</thead>
							<tbody>
							<c:forEach items="${getBasketServicelistvo}" var="getBasketServicelistvo" varStatus="status" >
								<c:choose>
									<c:when test="${status.index%2 eq 0 }">
										<tr class="odd">
									</c:when>
									<c:otherwise>
										<tr class="even">
									</c:otherwise>
								</c:choose>
								    <td class="tac nodotteText">
								    	<input type="checkbox" name="projectIdchk" id="${getBasketServicelistvo.basketSeq}" value="${getBasketServicelistvo.projectId}" />
								    </td>

									<td class="tac">
										${getBasketServicelistvo.requestName}
									</td>
									<td class="tac">
										${getBasketServicelistvo.cloudName}
									</td>
								     <td class="tac">

										<c:choose>
											<c:when test="${getBasketServicelistvo.onDemandFlag eq 'N'}">
												${getBasketServicelistvo.applyDatetime}
											</c:when>
											<c:otherwise>
												승인완료 후 생성
											</c:otherwise>
										</c:choose>
									</td>
									 <td class="tac">
									 	${getBasketServicelistvo.projectAlias}
									</td>
									<!-- <td class="tac">
										<c:choose>
											<c:when test="${getBasketServicelistvo.hourlyFlag eq 'N'}">
												월
											</c:when>
											<c:otherwise>
												시간
											</c:otherwise>
										</c:choose>
									</td> -->
									<td class="tac">
										${getBasketServicelistvo.hostnameAlias}
									</td>
									<td class="tac">
										${getBasketServicelistvo.serviceName}
									</td>
									<td class="tac">
									   ${getBasketServicelistvo.serviceTypeName}
									</td>
									<!-- <td class="tar fc-blue f16 fb">
										<fmt:formatNumber value="${getBasketServicelistvo.amount}" pattern="#,###"/>
										<c:choose>
											<c:when test="${getBasketServicelistvo.hourlyFlag eq 'N'}">
												<c:set var="monthhourly" value="${monthhourly + getBasketServicelistvo.amount}" />
											</c:when>
											<c:otherwise>
												<c:set var="hourlyamount" value="${hourlyamount + getBasketServicelistvo.amount}" />
											</c:otherwise>
										</c:choose>
										<c:set var="amount" value="${amount + getBasketServicelistvo.amount}" />
									</td> -->
									<td class="tac nodotteText">
									<%--   <img src="/resources/assets/img/icon_detailview01.png" id="s${getBasketBaklistvo.basketSeq}" onclick="viewtr('${getBasketBaklistvo.basketSeq}')"/> --%>




										<%pageContext.setAttribute("newLineChar","\r\n"); pageContext.setAttribute("br","<br/>");%>
										<button type="button" class="cbton bton_lblue" onclick="openPopService('${getBasketServicelistvo.projectName}','${getBasketServicelistvo.serviceName}','${getBasketServicelistvo.serviceTypeName}','${fn:replace(fn:replace(fn:escapeXml(getBasketServicelistvo.description),newLineChar,br),'','&nbsp;')}','${getBasketServicelistvo.projectAlias}', '${getBasketServicelistvo.hostname}', '${getBasketServicelistvo.hostnameAlias}', '${getBasketServicelistvo.requestName}', '${getBasketServicelistvo.hourlyFlag}', '${getBasketServicelistvo.onDemandFlag}', '${getBasketServicelistvo.applyDatetime}', '${getBasketServicelistvo.amount}')" ><i class="fa fa-search"></i></button>
										<input type="hidden" id="c${getBasketServicelistvo.basketSeq}" name="c${getBasketServicelistvo.basketSeq}" value="0" />
									</td>
								</tr>
								<tr id="v${getBasketServicelistvo.basketSeq}" name="v${getBasketServicelistvo.basketSeq}" style="display:none">
								<td colspan="8" class="p20 bgf9">
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
									 <c:choose>
									<c:when test="${status.index%2 eq 0 }">
										<tr class="odd">
									</c:when>
									<c:otherwise>
										<tr class="even">
									</c:otherwise>
								</c:choose>
									 <td class="tac"> <img src="${wasPath}/mbr/cmm/file/download/${getBasketServicelistvo.imageName}" class="w80"/></td>
									 <td class="tal">
									 	${getBasketServicelistvo.description}
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
						 <!--------자원정보 table 끝---------->

					</div>
					</div>
				    <!-- end section-container -->
	            <!-----서비스 끝------->
				</c:if>


<%-- 				<c:if test='${getBasketScmlistvo.size() ne 0}'> --%>
				<!-----형상관리 시작------->

				 <!-- begin section-container -->
<!-- 				 <div >			   -->
<!-- 				 <div > -->
<!-- 				 <h5 class="subtitle"> 형상관리서비스</h5> -->

<!-- 			<!-- begin normal input table---------->
<!-- 				<div class="panel mb0"> -->
<!-- 					<div> -->
<!-- 					    ------자원정보 table 시작-------- -->
<!-- 						<table class="subtable table-bordered table-hover table-striped table-td-valign-middle"> -->
<%-- 							 <colgroup> --%>
<%-- 							 <col width="50px"> --%>
<%-- 							 <col width="80px"> --%>
<%-- 							 <col width="85px"> --%>
<%-- 							 <col width="141px"> --%>
<%-- 							 <col width="*">						 --%>
<%-- 							 <col width="146px"> --%>
<%-- 							 <col width="75px"> --%>
<%-- 							 </colgroup> --%>
<!-- 							<thead> -->
<!-- 								<tr class="skyblue"> -->
<!-- 								    <th> </th> -->
<!-- 									<th>요청유형</th> -->
<!-- 									<th>과금단위</th> -->
<!-- 									<th>서비스희망일시</th> -->
<!-- 									<th>프로젝트명</th>								 -->
<!-- 									<th>신청금액(원)</th> -->
<!-- 									<th>상세</th> -->
<!-- 							</thead> -->
<!-- 							<tbody> -->
<%-- 							<c:forEach items="${getBasketScmlistvo}" var="getBasketScmlistvo" varStatus="status" > --%>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 										<tr class="odd"> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<tr class="even"> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose>	 --%>
<!-- 								    <td class="tac nodotteText"> -->
<%-- 								    	<input type="checkbox" name="projectIdchk" id="${getBasketScmlistvo.basketSeq}" value="${getBasketScmlistvo.projectId}" /> --%>
<!-- 								    </td> -->
<!-- 									<td class="tac"> -->
<%-- 										${getBasketScmlistvo.requestName} --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketScmlistvo.hourlyFlag eq 'N'}"> --%>
<!-- 												월 -->
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<!-- 												시간 -->
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketScmlistvo.onDemandFlag eq 'N'}"> --%>
<%-- 												${getBasketScmlistvo.applyDatetime} --%>
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<!-- 												승인완료 후 생성 -->
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										${getBasketScmlistvo.projectAlias} --%>
<!-- 									</td>								 -->
<!-- 									<td class="tar fc-blue f16 fb"> -->
<%-- 										<fmt:formatNumber value="${getBasketScmlistvo.amount}" pattern="#,###"/> --%>
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketScmlistvo.hourlyFlag eq 'N'}"> --%>
<%-- 												<c:set var="monthhourly" value="${monthhourly + getBasketScmlistvo.amount}" />											 --%>
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<%-- 												<c:set var="hourlyamount" value="${hourlyamount + getBasketScmlistvo.amount}" /> --%>
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<%-- 										<c:set var="amount" value="${amount + getBasketScmlistvo.amount}" /> --%>
<!-- 									</td> -->
<!-- 									<td class="tac nodotteText">  -->
<%-- 									  <img src="/resources/assets/img/icon_detailview01.png" id="s${getBasketScmlistvo.basketSeq}" onclick="viewtr('${getBasketScmlistvo.basketSeq}')"/> --%>
<%-- 									  <button type="button" class="tac table-search" onclick="openPopScm('${getBasketScmlistvo.projectAlias}', '${getBasketScmlistvo.requestName}', '${getBasketScmlistvo.hourlyFlag}', '${getBasketScmlistvo.onDemandFlag}', '${getBasketScmlistvo.applyDatetime}', '${getBasketScmlistvo.amount}')" ><span></span></button> --%>
<%-- 										<input type="hidden" id="c${getBasketScmlistvo.basketSeq}" name="c${getBasketScmlistvo.basketSeq}" value="0" />  --%>
<!-- 									</td> -->
<!-- 								</tr> -->
<%-- 								<tr id="v${getBasketScmlistvo.basketSeq}" name="v${getBasketScmlistvo.basketSeq}" style="display:none"> --%>
<!-- 								<td colspan="8" class="p20 bgf9"> -->
<!-- 								     <div> -->
<!-- 							         <table class="tableD4"> -->
<%-- 									 <colgroup> --%>
<%-- 									 <col width="150px"> --%>
<%-- 									 <col width="*"> --%>
<%-- 									 </colgroup> --%>
<!-- 									 <thead> -->
<!-- 									 <tr class="skyblue"> -->
<!-- 									 <th>자원이미지</th>  -->
<!-- 									 <th>비고</th> -->
<!-- 									 </tr> -->
<!-- 									 </thead> -->
<!-- 									 <tbody> -->
<%-- 									 <c:choose> --%>
<%-- 									<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 										<tr class="odd"> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<tr class="even"> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose>	 --%>
<%-- 									 <td class="tac"> <img src="${wasPath}/mbr/cmm/file/download/${getBasketScmlistvo.imageName}" class="w80"/></td>  --%>
<!-- 									 <td class="tal"> -->
<%-- 										${getBasketScmlistvo.description} --%>
<!-- 									 </td> -->
<!-- 									 </tr> -->
<!-- 									 </tbody> -->
<!-- 									 </table> -->
<!-- 									 </div> -->
<!-- 								</td> -->
<!-- 								</tr> -->
<%-- 							</c:forEach>	 --%>
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 						 ------자원정보 table 끝-------- -->

<!-- 					</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				end normal input table-------- -->
<!-- 				</div> -->
				    <!-- end section-container -->
	            <!-----형상관리 끝 ------->
<%-- 				</c:if> --%>

<%-- 				<c:if test='${getBasketMcalistvo.size() ne 0}'> --%>
				<!----공용대외계 시작------->

				 <!-- begin section-container -->
<!-- 				 <div >	   -->
<!-- 				 <div > -->
<!-- 				 <h5 class="subtitle"> 대외계서비스</h5> -->

<!-- 			<!-- begin normal input table---------->
<!-- 				<div class="panel mb0"> -->
<!-- 					<div> -->
<!-- 					    ------자원정보 table 시작-------- -->
<!-- 						<table class="subtable table-bordered table-hover table-striped table-td-valign-middle"> -->
<%-- 							  <colgroup> --%>
<%-- 							 <col width="50px"> --%>
<%-- 							 <col width="80px"> --%>
<%-- 							 <col width="85px"> --%>
<%-- 							 <col width="141px"> --%>
<%-- 							 <col width="*">						 --%>
<%-- 							 <col width="146px"> --%>
<%-- 							 <col width="75px"> --%>
<%-- 							 </colgroup> --%>
<!-- 							<thead> -->
<!-- 								<tr class="skyblue"> -->
<!-- 								    <th> </th> -->
<!-- 									<th>요청유형</th> -->
<!-- 									<th>과금단위</th> -->
<!-- 									<th>서비스희망일시</th> -->
<!-- 									<th>프로젝트명</th> -->
<!-- 									<th>신청금액(원)</th> -->
<!-- 									<th>상세</th> -->
<!-- 							</thead> -->
<!-- 							<tbody> -->
<%-- 							<c:forEach items="${getBasketMcalistvo}" var="getBasketMcalistvo" varStatus="status" > --%>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 										<tr class="odd"> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<tr class="even"> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose>	 --%>
<!-- 								    <td class="tac nodotteText"> -->
<%-- 								    	<input type="checkbox" name="projectIdchk" id="${getBasketMcalistvo.basketSeq}" value="${getBasketMcalistvo.projectId}" /> --%>
<!-- 								    </td> -->
<!-- 									<td class="tac"> -->
<%-- 										${getBasketMcalistvo.requestName} --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketMcalistvo.hourlyFlag eq 'N'}"> --%>
<!-- 												월 -->
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<!-- 												시간 -->
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketMcalistvo.onDemandFlag eq 'N'}"> --%>
<%-- 												${getBasketMcalistvo.applyDatetime} --%>
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<!-- 												승인완료 후 생성 -->
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										${getBasketMcalistvo.projectAlias} --%>
<!-- 									</td>								 -->
<!-- 									<td class="tar fc-blue f16 fb"> -->
<%-- 										<fmt:formatNumber value="${getBasketMcalistvo.amount}" pattern="#,###"/> --%>
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketMcalistvo.hourlyFlag eq 'N'}"> --%>
<%-- 												<c:set var="monthhourly" value="${monthhourly + getBasketMcalistvo.amount}" /> --%>

<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<%-- 												<c:set var="hourlyamount" value="${hourlyamount + getBasketMcalistvo.amount}" /> --%>
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<%-- 										<c:set var="amount" value="${amount + getBasketMcalistvo.amount}" /> --%>
<!-- 									</td> -->
<!-- 									<td class="tac nodotteText">  -->
<%-- 									  <img src="/resources/assets/img/icon_detailview01.png" id="s${getBasketMcalistvo.basketSeq}" onclick="viewtr('${getBasketMcalistvo.basketSeq}')"/> --%>
<%-- 									  <button type="button" class="tac table-search" onclick="openPopMca('${getBasketMcalistvo.projectAlias}', '${getBasketMcalistvo.requestName}', '${getBasketMcalistvo.hourlyFlag}', '${getBasketMcalistvo.onDemandFlag}', '${getBasketMcalistvo.applyDatetime}', '${getBasketMcalistvo.amount}')" ><span></span></button> --%>
<%-- 										<input type="hidden" id="c${getBasketMcalistvo.basketSeq}" name="c${getBasketMcalistvo.basketSeq}" value="0" /> --%>
<!-- 									</td> -->
<!-- 								</tr> -->
<%-- 								<tr id="v${getBasketMcalistvo.basketSeq}" name="v${getBasketMcalistvo.basketSeq}" style="display:none"> --%>
<!-- 								<td colspan="8" class="p20 bgf9"> -->
<!-- 								     <div> -->
<!-- 							         <table class="tableD4"> -->
<%-- 									 <colgroup> --%>
<%-- 									 <col width="150px"> --%>
<%-- 									 <col width="*"> --%>
<%-- 									 </colgroup> --%>
<!-- 									 <thead> -->
<!-- 									 <tr class="skyblue"> -->
<!-- 									 <th>자원이미지</th>  -->
<!-- 									 <th>비고</th> -->
<!-- 									 </tr> -->
<!-- 									 </thead> -->
<!-- 									 <tbody> -->
<%-- 									 <c:choose> --%>
<%-- 									<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 										<tr class="odd"> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<tr class="even"> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose>	 --%>
<%-- 									 <td class="tac"> <img src="${wasPath}/mbr/cmm/file/download/${getBasketMcalistvo.imageName}" class="w80"/></td>  --%>
<!-- 									 <td class="tal"> -->
<%-- 										${getBasketMcalistvo.description} --%>
<!-- 									</td> -->
<!-- 									 </tr> -->
<!-- 									 </tbody> -->
<!-- 									 </table> -->
<!-- 									 </div> -->
<!-- 								</td> -->
<!-- 								</tr> -->
<%-- 							</c:forEach>	 --%>
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 						 ------자원정보 table 끝-------- -->

<!-- 					</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				end normal input table-------- -->
<!-- 				</div> -->
				    <!-- end section-container -->
	            <!-----공용대외계 끝 ------->
<%-- 				</c:if> --%>

<%-- 				<c:if test='${getBasketSerlistvo.size() ne 0}'> --%>
				<!----통합보안관제 시작------->

				 <!-- begin section-container -->
<!-- 				 <div >			   -->
<!-- 				 <div > -->
<!-- 				 <h5 class="subtitle"> 보안관제서비스</h5> -->

<!-- 			<!-- begin normal input table---------->
<!-- 				<div class="panel mb0"> -->
<!-- 					<div> -->
<!-- 					    ------자원정보 table 시작-------- -->
<!-- 						<table class="subtable table-bordered table-hover table-striped table-td-valign-middle"> -->
<%-- 							 <colgroup> --%>
<%-- 							 <col width="50px"> --%>
<%-- 							 <col width="80px"> --%>
<%-- 							 <col width="85px"> --%>
<%-- 							 <col width="141px"> --%>
<%-- 							 <col width="*">						 --%>
<%-- 							 <col width="146px"> --%>
<%-- 							 <col width="75px"> --%>
<%-- 							 </colgroup> --%>
<!-- 							<thead> -->
<!-- 								<tr class="skyblue"> -->
<!-- 								    <th> </th> -->
<!-- 									<th>요청유형</th> -->
<!-- 									<th>과금단위</th> -->
<!-- 									<th>서비스희망일시</th> -->
<!-- 									<th>프로젝트명</th>								 -->
<!-- 									<th>신청금액(원)</th> -->
<!-- 									<th>상세</th> -->
<!-- 							</thead> -->
<!-- 							<tbody> -->
<%-- 							<c:forEach items="${getBasketSerlistvo}" var="getBasketSerlistvo" varStatus="status" > --%>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 										<tr class="odd"> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<tr class="even"> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose>	 --%>
<!-- 								    <td class="tac nodotteText"> -->
<%-- 								    	<input type="checkbox" name="projectIdchk" id="${getBasketSerlistvo.basketSeq}" value="${getBasketSerlistvo.projectId}" /> --%>
<!-- 								    </td> -->
<!-- 									<td class="tac"> -->
<%-- 										${getBasketSerlistvo.requestName} --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketSerlistvo.hourlyFlag eq 'N'}"> --%>
<!-- 												월 -->
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<!-- 												시간 -->
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketSerlistvo.onDemandFlag eq 'N'}"> --%>
<%-- 												${getBasketSerlistvo.applyDatetime} --%>
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<!-- 												승인완료 후 생성 -->
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<!-- 									</td> -->
<!-- 									<td class="tac"> -->
<%-- 										${getBasketSerlistvo.projectAlias} --%>
<!-- 									</td>								 -->
<!-- 									<td class="tar fc-blue f16 fb"> -->
<%-- 										<fmt:formatNumber value="${getBasketSerlistvo.amount}" pattern="#,###"/> --%>
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${getBasketSerlistvo.hourlyFlag eq 'N'}"> --%>
<%-- 												<c:set var="monthhourly" value="${monthhourly + getBasketSerlistvo.amount}" /> --%>

<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<%-- 												<c:set var="hourlyamount" value="${hourlyamount + getBasketSerlistvo.amount}" /> --%>
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
<%-- 										<c:set var="amount" value="${amount + getBasketSerlistvo.amount}" /> --%>
<!-- 									</td> -->
<!-- 									<td class="tac nodotteText">  -->
<%-- 									  <img src="/resources/assets/img/icon_detailview01.png" id="s${getBasketSerlistvo.basketSeq}" onclick="viewtr('${getBasketSerlistvo.basketSeq}')"/> --%>
<%-- 									  <button type="button" class="tac table-search" onclick="openPopSer('${getBasketSerlistvo.projectAlias}', '${getBasketSerlistvo.requestName}', '${getBasketSerlistvo.hourlyFlag}', '${getBasketSerlistvo.onDemandFlag}', '${getBasketSerlistvo.applyDatetime}', '${getBasketSerlistvo.amount}')" ><span></span></button> --%>
<%-- 										<input type="hidden" id="c${getBasketSerlistvo.basketSeq}" name="c${getBasketSerlistvo.basketSeq}" value="0" /> --%>
<!-- 									</td> -->
<!-- 								</tr> -->
<%-- 								<tr id="v${getBasketSerlistvo.basketSeq}" name="v${getBasketSerlistvo.basketSeq}" style="display:none"> --%>
<!-- 								<td colspan="8" class="p20 bgf9"> -->
<!-- 								     <div> -->
<!-- 							         <table class="tableD4"> -->
<%-- 									 <colgroup> --%>
<%-- 									 <col width="150px"> --%>
<%-- 									 <col width="*"> --%>
<%-- 									 </colgroup> --%>
<!-- 									 <thead> -->
<!-- 									 <tr class="skyblue"> -->
<!-- 									 <th>자원이미지</th>  -->
<!-- 									 <th>비고</th> -->
<!-- 									 </tr> -->
<!-- 									 </thead> -->
<!-- 									 <tbody> -->
<%-- 									 <c:choose> --%>
<%-- 									<c:when test="${status.index%2 eq 0 }"> --%>
<!-- 										<tr class="odd"> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<tr class="even"> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose>	 --%>
<%-- 									 <td class="tac"> <img src="${wasPath}/mbr/cmm/file/download/${getBasketSerlistvo.imageName}" class="w80"/></td>  --%>
<!-- 									 <td class="tal"> -->
<%-- 										${getBasketSerlistvo.description} --%>
<!-- 									 </td> -->
<!-- 									 </tr> -->
<!-- 									 </tbody> -->
<!-- 									 </table> -->
<!-- 									 </div> -->
<!-- 								</td> -->
<!-- 								</tr> -->
<%-- 							</c:forEach>	 --%>
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 						 ------자원정보 table 끝-------- -->

<!-- 					</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				end normal input table-------- -->
<!-- 				</div> -->
				    <!-- end section-container -->
	            <!-----통합보안관제  끝 ------->
<%-- 				</c:if> --%>
				</div>
				</c:if>
				<c:if test='${getBasketServicelistvo.size() eq "0"}'>
					<h5 class="box_grey1 tac p30 fc11 fn"> <img src="/resources/assets/img/icon_no.png"/> 서비스 신청 내역이 없습니다</h5>
				</c:if>

	<!-- 			<div class="section-container inbox mt20 mb10">	 -->
	<!-- 				<div class="panel bgwh mb0 p30"> -->
	<!-- 					<div class="col-md-6 f24 mt-20">총합계(VAT 별도)</div> -->
	<%-- 					<div class="col-md-6 f24 mt-20 fc-red tar"><fmt:formatNumber value="${amount}" pattern="#,###"/> <span class="f12 fc66">원 </span></div> --%>
	<!-- 				</div> -->
	<!-- 			</div> -->




				<!-----부가자원 끝---------->
				<hr class="line2a mt20"></hr>
				<label for="all_chk" class="col-md-12 mb10 p0" style="font-weight:500;"> <input type="checkbox" value="all" id="all_chk" name="all_chk"  class="pb6"/> 전체선택</label>

						<!-- <div class="appTotal2 mt10">
						<span class="llabel nanumR">월별 총합계<span class="txttotal">(VAT 별도)</span></span>
						<span class="totalwon nanumR"><span id="totalpriceview" name="totalpriceview"><fmt:formatNumber value="${monthhourly}" pattern="#,###"/></span><span class="unit">&nbsp;원</span></span>
					</div>

				    <div class="appTotal2 mt-1">
						<span class="llabel nanumR">시간별 총합계<span class="txttotal">(VAT 별도)</span></span>
						<span class="totalwon nanumR"><span id="totalpriceview" name="totalpriceview"><fmt:formatNumber value="${hourlyamount}" pattern="#,###"/></span><span class="unit">&nbsp;원</span></span>
					</div> -->

					<!-- <div class="appTotal mt-1">
						<span class="llabel nanumR">총합계<span class="fc66">(VAT 별도)</span></span>
						<span class="totalwon nanumR"><span id="totalpriceview" name="totalpriceview"><fmt:formatNumber value="${amount}" pattern="#,###"/></span><span class="unit">&nbsp;원</span></span>
					</div> -->

				<div class="clear"></div>
				<div class="btn_area mt40">
					<a type="button" class="btn_navy" onclick="openModal();">신청</a>
					<a type="button" class="btn_line55 ml10" onclick="movePage();">취소</a>
					<a type="button" class="btn_dgrey ml10" onclick="basketDel();">선택삭제</a>
				</div>



				<input type="hidden" name="amount" id="amount" value="${amount}" />
				</form>
				<form name="basketdel"  id="basketdel" action="basketOrder.do" method="post" >
				<input type="hidden" name="type" id="type" value="chkbasketdel" />
				<input type="hidden" name="basketSeq" id="basketSeq" value="" />
				<input type="hidden" name="projectId" id="projectId" value="" />
				</form>
				</div>
				<!-- end page-body -->
			<!-- 수정된 화면 끝 -->


					<!-- 가상서버 상세 -->
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
			                       				<p class="fc11 fb">vCPU<span class="fc66 fn">(Core)</span></p>
			                       			</div>
			                       			<div class="fl mr20 tac">
			                       				<p class="memoryArea nanumR mb5 f36">63</p>
			                       				<p class="fc11 fb">MEMORY<span class="fc66 fn">(GB)</span></p>
			                       			</div>
			                       			<div class="fl tac">
			                       				<p class="diskArea nanumR mb5 f26">9999</p>
			                       				<p class="fc11 fb">DISK<span class="fc66 fn">(GB)</span></p>
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
					<!-- #modal-dialog -->

				<!-- 	<div class="modal fade pdManage" id="detail-modal-dialog">
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
											<dl class="boxType03 dpno">
												<dt>금액<span class="fc-red">(VAT 별도)</span></dt>
												<dd><div id="popDetailAmt"></div></dd>
											</dl>
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
												<span class="serverPopLabel3">가상서버 </span>
												<span class="serverDate nanumR  fc66">OA운영</span>
												<span class="serverPopLabel3 ml20">디스크 TYPE  </span>
												<span class="serverDate nanumR fc66">레드헷 리눅스  7.6</span>
											</p>
			                       		</div>
			                       		<div class="bottomArea"  id="blockDetailDiv2">

			                       			<div class="fl tac center w30">
			                       				<p class="diskArea nanumR mb5 f30">999</p>
			                       				<p class="fc11 fb">DISK<span class="fc66 fn">(GB)</span></p>
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

						<!-- nas 상세 -->
						<div class="modal fade" id="nas-modal-dialog">
			               	<div class="modal-dialog">
			                   	<div class="modal-content">
			                       	<div class="modal-header">
			                           <button type="button" type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
			                       	   <h4 class="modal-title" id="nas-title">NAS  상세</h4>
			                       	</div>
			                       	<div class="modal-body">
			                       		<div id="nasDetailDiv1">
											<p>
												<span class="serverPopLabel2 fl" >프로젝트명</span>
												<span class="serverName fc11 fl lh26 ml5"></span>
												<span class="pop_pid flr"></span>
											</p>
											<p class="fl mt10 clear">
												<span class="serverPopLabel2">디스크명</span>
												<span class="nanumR fc11"></span>
											</p>
											<p  class="fl mt10 clear">
												<span class="serverPopLabel3" >서비스희망일시</span>
												<span class="serverDate nanumR fc66">승인완료 후 생성</span>
											</p>
											<p  class="fl mt10 clear">
												<span class="serverPopLabel3">가상서버 </span>
												<span class="serverDate nanumR  fc66">OA운영</span>
												<span class="serverPopLabel3 ml20">디스크 TYPE  </span>
												<span class="serverDate nanumR fc66">레드헷 리눅스  7.6</span>
											</p>
			                       		</div>
			                       		<div class="bottomArea"  id="nasDetailDiv2">

			                       			<div class="fl tac center w30">
			                       				<p class="diskArea nanumR mb5 f30">999</p>
			                       				<p class="fc11 fb">DISK<span class="fc66 fn">(GB)</span></p>
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
			                       		<div  id="serviceDetailDiv1">
											<p>
												<span class="serverPopLabel2 fl" >프로젝트명</span>
												<span class="serverName fc11 fl lh26 ml5">프로젝트명이 들어감!!! </span>
												<span class="pop_pid flr">ABCDEFG</span>
											</p>
											<p class="fl mt10 clear">
												<span class="serverPopLabel2">서비스 유형</span>
												<span class="nanumR fc11">백업관리</span>
											</p>
											<p  class="fl mt10 clear">
												<span class="serverPopLabel3" >서비스희망일시</span>
												<span class="serverDate nanumR fc66">승인완료 후 생성</span>
											</p>
											<p  class="fl mt10 clear">
												<span class="serverPopLabel3">서비스명 </span>
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
			                       		</div>
									</div>
									<div class="clear"></div>
			                       	<div class="modal-footer tac">
			                   			<a type="button" class="m_btn_navy" data-dismiss="modal">닫기</a>
			                       	</div>
			                   	</div>
			               	</div>
			           	</div>



			<!-- # modal-approve-dialog 승인자 지정팝업-->
	        <div class="modal fade" id="modal-approve-dialog">
	            <div class="modal-dialog width-720">
	                <div class="modal-content width-720">
	                    <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                        <h4 class="modal-title">요청부서 결재지정</h4>
	                    </div>
	                    <div class="modal-body">
				   			<table class="tableV">
						 		<colgroup>
						 			<col width="20%">
						 			<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
						 		</colgroup>
						 		<thead>
						 			<tr class="skyblue">
										<th>구분</th>
										<th>사번</th>
										<th>직급</th>
										<th>이름</th>
										<th></th>
								     </tr>
					    		</thead>
					    		<tbody>
						 			<tr>
										<td class="tac" id="approvalLine1_title"> 입안보조 </td>
										<td class="tac" id="approvalLine1_userId"> 사번 </td>
										<td class="tac" id="approvalLine1_userLevel"> 직급 </td>
										<td class="tac" id="approvalLine1_userName"> 이름 </td>
										<td class="tac">
											<button type="button" class="cbton bton_lblue" id="approvalLine1" onclick="openReviewModal(this);"><i class='fa fa-search'></i></button>
										</td>
									</tr>
						 			<tr>
							 			<td class="tac" id="approvalLine2_title"> 입안 </td>
							 			<td class="tac" id="approvalLine2_userId"> 사번 </td>
							 			<td class="tac" id="approvalLine2_userLevel"> 직급 </td>
							 			<td class="tac" id="approvalLine2_userName"> 이름 </td>
							 			<td class="tac">
							 				<button type="button" class="cbton bton_lblue" id="approvalLine2" onclick="openReviewModal(this);" disabled="disabled"><i class='fa fa-search'></i></button>
							 			</td>
						 			</tr>
						 			<tr>
										<td class="tac" id="approvalLine3_title"> 검토 </td>
										<td class="tac" id="approvalLine3_userId"> 사번 </td>
										<td class="tac" id="approvalLine3_userLevel"> 직급 </td>
										<td class="tac" id="approvalLine3_userName"> 이름 </td>
										<td class="tac">
											<button type="button" class="cbton bton_lblue" id="approvalLine3" onclick="openReviewModal(this);" disabled="disabled"><i class='fa fa-search'></i></button>
										</td>
									</tr>
									<tr>
										<td class="tac" id="approvalLine4_title"> 승인 </td>
										<td class="tac" id="approvalLine4_userId"> 사번 </td>
										<td class="tac" id="approvalLine4_userLevel"> 직급 </td>
										<td class="tac" id="approvalLine4_userName"> 이름 </td>
										<td class="tac">
											<button type="button" class="cbton bton_lblue" id="approvalLine4" onclick="openReviewModal(this);" disabled="disabled"><i class='fa fa-search'></i></button>
										</td>
									</tr>
						 		</tbody>
				 			</table>
					 	</div>
						<div class="clear"></div>
						<div class="modal-footer tac">
	             			<a type=button class="m_btn_navy" data-dismiss="modal" onclick="orderok();">확인</a>
	             			<a type=button class="m_btn_white ml10" data-dismiss="modal">취소</a>
	                 	</div>
	             	 </div>
				</div>
	        </div>

	      	<!-- 프로젝트 검토자 결재자 지정 팝업 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="user-modal-dialog">
	               <div class="modal-dialog width-720">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'><span></span></button>
	                           <h4 class="modal-title">검토자 검색</h4>
	                       </div>
	                       <div class="modal-body">

					 	<!--//검색 시작-->
	                      	 <div class="col-xs-12 bgee modalpop mb20">
	                       		<div class="selectBoxBr col-xs-3">
									<label class="selectText" for="reviewSearchKind">전체</label>
									<select class="search-sel" id="reviewSearchKind">
										<option value="searchAll">전체</option>
										<option value="userId">사번</option>
										<option value="userName">이름</option>
										<option value="deptName">부서</option>
									</select>
								</div>
									<div class="search-box">
										<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="reviewUserId" onkeypress="if(event.keyCode==13)gridPopList();" >
										<button type="button" class="btn_search2 vm" onclick="gridPopList();"><span></span></button>
									</div>
							</div>
						<!--검색  끝//-->

		                      <table class="tableV">
								 <colgroup>
										<col width="*">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="8%">
								 </colgroup>
								 <thead>
								 <tr class="skyblue">
								    <th class="tac">부서</th>
									<th class="tac">사번</th>
									<th class="tac">직급</th>
									<th class="tac">이름</th>
									<th class="tac">상태</th>
									<th class="tac"></th>
								 </tr>
								 </thead>
								 <tbody id="popListTable">

								 </tbody>
						 	    </table>

								<div class="noneList" id='popListTable2'>
									 <span>검색된 사용자가 없습니다.</span>
								</div>
								<div class="listArea" id="popListTable" style="display: none;"></div>
	                      		<div class="totalcnt" id="totalCnt">총 0 건</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="m_btn_navy" data-dismiss="modal" >닫기</a>
	                       	</div>
		               	</div>
					</div>
	           	</div>
				<!-- #modal-dialog -->




				<!-- 프로젝트 승인자 결재자 지정 팝업 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="user-modal-approve-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content w560">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'><span></span></button>
	                           <h4 class="modal-title">승인자 검색</h4>
	                       </div>
	                       <div class="modal-body">

							 	 <!--//검색 시작-->
		                       	 <div class="col-xs-12 bgee modalpop mb20">
			                       		<div class="selectBoxBr col-xs-3">
											<label class="selectText" for="approveSearchKind">전체</label>
											<select class="search-sel" id="approveSearchKind">
												<option value="searchAll">전체</option>
												<option value="userId">사번</option>
												<option value="userName">이름</option>
												<option value="deptName">부서</option>
											</select>
										</div>
											<div class="col-xs-9">
												<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="approveUserId" onkeypress="if(event.keyCode==13)gridPopApproveList();" >
												<button type="button" class="btn_search2 vm" onclick="gridPopApproveList();"><span></span></button>
											</div>
									</div>
									<!--검색  끝//-->

						<table class="tableV">
							 <colgroup>
							 <col width="*">
							 <col width="15%">
							 <col width="15%">
							 <col width="15%">
							 <col width="15%">
							 <col width="8%">
							 </colgroup>
							 <thead>
							 <tr class="skyblue">
							    <th class="tac">부서</th>
								<th class="tac">사번</th>
								<th class="tac">직급</th>
								<th class="tac">이름</th>
								<th class="tac">상태</th>
								<th class="tac"></th>
							 </tr>
							 </thead>
							 <tbody id="popListApproveTable">

							 </tbody>
					 	    </table>

								<div class="noneList" id='popListApproveTable2'>
									 <span>검색된 사용자가 없습니다.</span>
								</div>
	                      		<div class="totalcnt" id="totalApproveCnt">총 0 건</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="m_btn_navy" data-dismiss="modal" >닫기</a>
	                       	</div>
		               	</div>
					</div>
	           	</div>
				<!-- #modal-dialog -->



	            <!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->
			</div>
			<!-- end #content -->


		</div>
		<!-- end page container -->

		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">
			// 결재라인 관련 변수
			var currentApprovalLine = "";
			var approvalList = [];

			var regTemp = true;

			function openModal(){
				if(regTemp){
					if($("input:checkbox[name='projectIdchk']:checked").length==0){
						alertBox3("신청하실 자원은 1개이상을 <br>선택하셔야 합니다.");
						$("input:checkbox[name='projectIdchk']").focus();
						return false;
					}

					if($("#apprvPass").val() == "Y"){
						confirmBox4("결재자를 지정하시겠습니까?",approvSelect,nApprovSelect);
					} else {
						approvSelect();
					}
				}
			}
			function nApprovSelect(){
				$("#selectApprv").val("Y");
				orderok();
			}
			function approvSelect(){
				$("#selectApprv").val("N");
				$("#modal-approve-dialog").modal();
			}

			function openApproveModal(){

				$("#user-modal-approve-dialog").modal();
				 gridPopApproveList();
			}

			function openReviewModal(e) {
				currentApprovalLine = e;
				var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
				if( approvalList[tmpCurrentApprovalStep-1] != undefined) {
					confirmBox("재신청할경우 현재 상위결재자값이 초기화 됩니다.", clearUpperApproval );

				} else {
					$("#user-modal-dialog").modal();
					gridPopList();
				}
			}


			var totalCnt = 0;

	        // 결재자 등록 팝업 리스트
			function gridPopList(){
				$.ajax({
					url : "${contextPath}/mbr/operation/approveUser/addProjectApproveList",
					dataType : "JSON",
					data : {
						"searchKind": $("#reviewSearchKind option:selected").val()
						, "keyword"	: $("#reviewUserId").val()
					},
					success : function(req) {
						if(req.data.length == 0){
							$("#popListTable").hide();
							$("#popListTable2").show();
						}else{
							$("#popListTable").empty();

							$.each(req.data, function(key,val){
								$("#popListTable").append(
										  '<tr>'
										     +'<td class="tac">'+val.upDeptName+'/'+val.deptName+'</td>'
											 +'<td class="tac">'+val.userId+'</td>'
											 +'<td class="tac">'+val.userLevel+'</td>'
									 		 +'<td class="tac">'+val.userName+'</td>'
											 +'<td class="tac">'+val.userConditionText+'</td>'
											 +'<td class="tac"><input type="button"  value="&#xf00c"  class="popCheckbtn"  onclick="updateReview(this, \''+val.userId+'\', \''+val.userName+'\', \''+val.deptName+'\',  \''+val.userLevel+'\',  \''+val.userLevelCode+'\');" initModal();></td>'
											+'</tr>');

							});
							$("#popListTable").show();
							$("#popListTable2").hide();
						}
						totalCnt = req.data.length;
						$("#totalCnt").text("총 "+totalCnt+" 건");
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
			var totalCnt = 0;

			  // 검토자 등록 팝업 리스트
			function gridPopApproveList(){
				$.ajax({
					url : "${contextPath}/mbr/operation/approveUser/addProjectApprove2List",
					dataType : "JSON",
					data : {
						"searchKind": $("#approveSearchKind option:selected").val()
						, "keyword"	: $("#approveUserId").val()
					},
					success : function(req) {
						if(req.data.length == 0){
							$("#popListApproveTable").hide();
							$("#popListApproveTable2").show();
						}else{
							$("#popListApproveTable").empty();

							$.each(req.data, function(key,val){
								$("#popListApproveTable").append(
										'<tr>'
										+'<td class="tac">'+val.upDeptName+'/'+val.deptName+'</td>'
										+'<td class="tac">'+val.userId+'</td>'
									 	+'<td class="tac">'+val.userLevel+'</td>'
									 	+'<td class="tac">'+val.userName+'</td>'
									 	+'<td class="tac">'+val.userConditionText+'</td>'
										+'<td class="tac"><input type="button"  value="&#xf00c" class="popCheckbtn" onclick="updateApprove(this, \''+val.userId+'\', \''+val.userName+'\');" initModal();></td>'
										+'<tr/>'
									    );

							});
							$("#popListApproveTable").show();
							$("#popListApproveTable2").hide();
						}
						totalCnt = req.data.length;
						$("#totalApproveCnt").text("총 "+totalCnt+" 건");
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




			// 요청부서 결재지정 팝업 - 담당자지정
			function updateReview(e, userId, userName, deptName, userLevel, userLevelCode) {
				var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
				if( tmpCurrentApprovalStep > 1 && approvalList[tmpCurrentApprovalStep-2] != undefined) {
					if( approvalList[tmpCurrentApprovalStep-2].userLevelCode < userLevelCode) {
						alertBox("이전단계보다 같거나 높은 직급의 담당자를 선택하세요");
						return false;
					}
				}
				/* if($("#hidden_login_user_id").val() ==userId) {
					alertBox("신청자는 본인을<br>결재자로 지정할수 없습니다.");
					return false;
				} */

				$("#popListReviewTable > tr").find("input").removeClass("active");
				$(e).toggleClass("active");

				var tmpValue = { "userId" : userId, "deptName" : deptName, "userName" : userName, "userLevel" : userLevel, "userLevelCode" : userLevelCode }

				$("#"+currentApprovalLine.id+"_userId").text(userId);
				$("#"+currentApprovalLine.id+"_userLevel").text(userLevel);
				$("#"+currentApprovalLine.id+"_userName").text(userName);

				approvalList[tmpCurrentApprovalStep-1] = tmpValue;
				$("#userIdReview").text(userId);
				$("#userNameReview").text(userName);
				$("#hiddenUserIdReview").val(userId);
				$("#hiddenUserNameReview").val(userName);

				// 다음 단계 버튼 활성화
				$("#approvalLine"+(parseInt(tmpCurrentApprovalStep)+1) ).attr('disabled', false);
			}

			 // 승인자지정
			function updateApprove(e, userId, userName){

				/* if($("#hidden_login_user_id").val() ==userId) {
					alertBox("신청자는 본인을<br>결재자로 지정할수 없습니다.");
					return false;
				} */

				$("#popListApproveTable > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
				$("#userIdApprove").text(userId);
				$("#userNameApprove").text(userName);
				$("#hiddenUserIdApprove").val(userId);
				$("#hiddenUserNameApprove").val(userName);
			}


			function orderok(){
				/*
				if($("#hiddenUserIdReview").val() == ""){
					alertBox3("검토자를 지정해주세요.");
					return false;
				}
				if($("#hiddenUserIdApprove").val() == ""){
					alertBox3("승인자를 지정해주세요.");
					return false;
				}
				*/
				if( (approvalList[3] == undefined || approvalList[3] == null || approvalList[3] == '') && $("#selectApprv").val() == 'N') {
					alertBox3("결재자를 지정해 주세요");
					return false;
				}

				if($("input:checkbox[name='projectIdchk']:checked").length==0){
					alertBox3("신청하실 자원은 1개이상을 <br>선택하셔야 합니다.");
					$("input:checkbox[name='projectIdchk']").focus();
					return false;
				}


				var i=0;
				var netstr="";
				var basketSeq="";
				$("input:checkbox[name='projectIdchk']:checked").each(function(){
					if($(this).is(":checked")){
						var netidtxt=$(this).attr("id");
						if(i==0){
							netstr = $(this).val();
							basketSeq = netidtxt;
						}else{
							/*
							if(netstr!=$(this).val()){
								alert("같은프로젝트만 신청가능합니다.");
								basketSeq = "";
								return false;

							}
							*/
							basketSeq = basketSeq +","+ netidtxt;
						}

						i+=1;
					}
				})


				$("#projectId").val(netstr);
				$("#basketSeqs").val(basketSeq);

				if(basketSeq!=""){
					confirmBox("해당 자원에 대하여 신청 하시겠습니까?",orderchoice);
				}

			}

			// 팝업 초기화
			function initModal(){
				$("#searchKeyword").val("");
			}

			function orderchoice(){
				//$("#orderform").submit();
				if( approvalList[0] == undefined || approvalList[0] == null) {
					var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
					approvalList[0] = tmp;
				}
				$("#approvalStepListString").val(JSON.stringify(approvalList));

				var type = $("#orderform").attr("type");
				var url = $("#orderform").attr("action");
				var data = $("#orderform").serialize();
				if(regTemp){
					regTemp = false;
					$.ajax({
						url:url,
						type:type,
						data:data,
						beforeSend : function(xhr, opts) {
							setLodingFun.blocksFun();
						},
						complete : function() {
							setLodingFun.nonesFun();
						},
						success:function(data){
							regTemp = true;
							if(data == "true"){
								alertBox("신청이 완료 되었습니다.",orderok2);
							} else {
								alertBox3("신청에 실패하였습니다.");
							}
						},
						error : function(request, status, error) {
							regTemp = true;
							if(request.status == '200'){
								alertBox("접속이 만료되었습니다.", logout);
							}else{
								alertBox3("code:" + request.status + "\n" + "error:" + error);
							}
						}
					})
				}
			}

			function orderok2(){
				setLodingFun.blocksFun();
				location.href="${wasPath}/mbr/req/catalogue/bssOrderList";
			}

			function bdel(basketSeq){

				$("#basketSeq").val(basketSeq);
				$("#basketdel").submit();
			}

			function basketDel(){
				////alert("1111");
				if($("input:checkbox[name='projectIdchk']:checked").length==0){
					alertBox3("삭제하실 자원은 1개이상을 <br>선택하셔야 합니다.");
					$("input:checkbox[name='projectIdchk']").focus();
					return false;
				}

				var i=0;
				var netstr="";
				var basketSeq="";
				$("input:checkbox[name='projectIdchk']:checked").each(function(){
					if($(this).is(":checked")){
						var netidtxt=$(this).attr("id");
						if(i==0){
							netstr = $(this).val();
							basketSeq = netidtxt;
						}else{
							basketSeq = basketSeq +","+ netidtxt;
						}
						i+=1;
					}
				})

				$("#projectId").val(netstr);
				$("#basketSeq").val(basketSeq);
				//alert($("#basketSeq").val());
				if(basketSeq!=""){
					//$("#basketSeq").val(basketSeq);
					//alert($("#basketSeq").val());
					confirmBox("해당 자원을 삭제하시겠습니까?",delchoice);

				}
			}

			function delchoice(){
				$("#basketdel").submit();
			}

			//가상머신 목록 페이지지로 이동
			function movePage(){
				location.href="${wasPath}/mbr/req/catalogue/catalogueList.do";
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
					//$("#"+sbasketSeq).addClass('fa fa-chevron-up');
				}else{
					$("#"+cbasketSeq).val("0");
					$("#"+vbasketSeq).hide();
					//$("#"+sbasketSeq).removeClass('fa fa-chevron-up');
					$("#"+sbasketSeq).attr("src", '${apachePath}/resources/assets/img/icon_detailview01.png');
				}

			}

			 function openPopserver(projectName, defaultNetworkName, osProductName, description, requestType, beforeVcpus, changeVcpus, beforeMemGb, changeMemGb, projectAlias, hostnameAlias, hostname, requestName, hourlyFlag, onDemandFlag, applyDatetime, amount, vcpus, memGb, vmDiskGb) {
				$("#server-modal-dialog").modal();

						if(description == ''){
							description = '요청내용이 없습니다.'
						}

				$("#modal-title").html('가상서버 상세내역');
/* 				$("#popDetailDiv1").html('<p>'
						+'<span class="serverPopLabel2 fl">프로젝트명</span><span class="fc11 fl lh26 ml5">'+projectAlias+'</span>'
						+'<span class="pop_pid flr">'+projectName+'</span>'
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
						+'<span class="serverPopLabel3">이미지</span><span class="fc11 ml5">'+osProductName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">요청유형</span><span class="fc11 ml5">'+requestName+'</span>'
					+'</p>'); */

				$("#popDetailDiv1").html('<table class="m_table">'
						+'<tbody>'
						+'<tr><th>프로젝트 ID</th><td>'+projectName+'</td></tr>'
						+'<tr><th>프로젝트명</th><td>'+projectAlias+'</td></tr>'
						+'<tr><th>서버명</th><td>'+(hostnameAlias==null?"":hostnameAlias)+'</td></tr>'
						+'<tr><th>서비스 희망일시</th><td>'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</td></tr>'
						+'<tr><th>네트워크</th><td>'+defaultNetworkName+'</td></tr>'
						+'<tr><th>이미지</th><td>'+osProductName+'</td></tr>'
						+'<tr><th>요청유형</th><td>'+requestName+'</td></tr>'
						+'<tr><th>요청내용</th><td>'+description+'</td></tr>'
						+'</tbody>'
					+'</table>');



				if(requestType == 'REQTYPE_CHANGE'){
					$("#popDetailDiv2").html(
							'<div class="fl mr20 tac w30">'
							+(changeVcpus==null?"":'<p class="cpuArea nanumR mb5 f36 center">'+changeVcpus+'</p>')
							+ '<p class="fc11 fb">vCPU<span class="fc66 fn">(Core)</span></p>'
							+'</div>'
							+'<div class="fl mr20 tac w30">'
							+(changeMemGb==null?"":'<p class="memoryArea nanumR mb5 f36 center">'+changeMemGb+'</p>')
							+'<p class="fc11 fb">MEMORY<span class="fc66 fn">(GB)</span></p>'
							+'</div>'
							+'<div class="fl tac w30">'
							+(vmDiskGb==null?"":'<p class="diskArea nanumR mb5 f26 center">'+vmDiskGb+'</p>')
							+'<p class="fc11 fb">DISK<span class="fc66 fn">(GB)</span></p>'
							+'</div>'
/* 					    	+'<div class="clear"></div>'
							+'<ul class="mt30">'
							+'<li class="clear fl"><span class="serverPopLabel3">요청내용 </span></li>'
							+'<li class="clear fl mt10 tal lh24">'+description+'</li>'
							+'</ul>' */
							);
				}else{

				$("#popDetailDiv2").html(
						'<div class="fl mr20 tac w30">'
						+(vcpus==null?"":'<p class="cpuArea nanumR mb5 f36 center">'+vcpus+'</p>')
						+ '<p class="fc11 fb">vCPU<span class="fc66 fn">(Core)</span></p>'
						+'</div>'
						+'<div class="fl mr20 tac w30">'
						+(memGb==null?"":'<p class="memoryArea nanumR mb5 f36 center">'+memGb+'</p>')
						+'<p class="fc11 fb">MEMORY<span class="fc66 fn">(GB)</span></p>'
						+'</div>'
						+'<div class="fl tac w30">'
						+(vmDiskGb==null?"":'<p class="diskArea nanumR mb5 f26 center">'+vmDiskGb+'</p>')
						+'<p class="fc11 fb">DISK<span class="fc66 fn">(GB)</span></p>'
						+'</div>'
/* 						+'<div class="clear"></div>'
						+'<ul class="mt30">'
						+'<li class="clear fl"><span class="serverPopLabel3">요청내용 </span></li>'
						+'<li class="clear fl mt10 tal lh24">'+description+'</li>'
						+'</ul>' */
						);
					}
			       }

			function openPopdisk(projectName, description, diskName, diskProductName, requestType, beforeDiskGb, changeDiskGb, projectAlias, hostname, hostnameAlias, requestName, hourlyFlag, onDemandFlag, applyDatetime, diskGb, amount) {
				$("#disk-modal-dialog").modal();

				if(description == ''){
					description = '요청내용이 없습니다.'
				}

				$("#disk-title").html('블록디스크  상세내역');
/* 				$("#blockDetailDiv1").html('<p>'
						+'<span class="serverPopLabel2 fl">프로젝트명</span><span class=" fc11 fl lh26 ml5">'+projectAlias+'</span>'
						+'<span class="pop_pid flr">'+projectName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel2">디스크명</span><span class="fc11 ml5">'+diskName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3" >서비스희망일시</span><span class="fc11 ml5">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">가상서버</span><span class="fc11 ml5">'+(hostnameAlias==null?"":hostnameAlias)+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">디스크 TYPE</span><span class="fc11 ml5">'+diskProductName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">요청유형</span><span class="fc11 ml5">'+requestName+'</span>'
					+'</p>');	 */

				$("#blockDetailDiv1").html('<table class="m_table">'
						+'<tbody>'
						+'<tr><th>프로젝트 ID</th><td>'+projectName+'</td></tr>'
						+'<tr><th>프로젝트명</th><td>'+projectAlias+'</td></tr>'
						+'<tr><th>디스크명</th><td>'+diskName+'</td></tr>'
						+'<tr><th>서비스 희망일시</th><td>'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</td></tr>'
						+'<tr><th>가상서버</th><td>'+(hostnameAlias==null?"":hostnameAlias)+'</td></tr>'
						+'<tr><th>디스크TYPE</th><td>'+diskProductName+'</td></tr>'
						+'<tr><th>요청유형</th><td>'+requestName+'</td></tr>'
						+'<tr><th>요청내용</th><td>'+description+'</td></tr>'
						+'</tbody>'
					+'</table>');



				if(requestType == 'REQTYPE_CHANGE'){
					$("#blockDetailDiv2").html('<div class="tac center">'
							+(changeDiskGb==null?"":'<p class="diskArea mb5 f20 center">'+changeDiskGb+'</p>')
							+ '<p class="fc11 fb">DISK<span class="fc66 fn">(GB)</span></p>'
							+'</div>'
							+'<div class="clear"></div>'
/* 							+'<ul class="mt30">'
							+'<li class="clear fl"><span class="serverPopLabel3">요청내용 </span></li>'
							+'<li class="clear fl mt10 tal lh24">'+description+'</li>'
							+'</ul>' */
							);
				}else{
				$("#blockDetailDiv2").html('<div class="tac center">'
						+(diskGb==null?"":'<p class="diskArea mb5 f20 center">'+diskGb+'</p>')
						+ '<p class="fc11 fb">DISK<span class="fc66 fn">(GB)</span></p>'
						+'</div>'
						+'<div class="clear"></div>'
/* 						+'<ul class="mt30">'
						+'<li class="clear fl"><span class="serverPopLabel3">요청내용 </span></li>'
						+'<li class="clear fl mt10 tal lh24">'+description+'</li>'
						+'</ul>' */
						);
			}
			}
// 			function openPopNas(projectAlias, nasName, vmName, requestName, hourlyFlag, onDemandFlag, applyDatetime, nasGb, amount) {
// 				$("#detail-modal-dialog").modal();

// 				$("#popDetailTitle").html('NAS 상세내역');
// 				$("#popDetailDivProject").html('<strong class="title">'+projectAlias+'</strong>');

// 				$("#popDetailDiv1").html('<ul>'
// 						+'<li><span class="title">NAS명</span><span class="cnt">'+(nasName==null?"":nasName)+'</span></li>'
// 						+'<li><span class="title">가상서버</span><span class="cnt">'+(vmName==null?"":vmName)+'</span></li>'
// 					+'</ul>');
// 				$("#popDetailDiv1").show();

// 				$("#popDetailDiv2").html('<ul>'
// 						+'<li><span class="title">요청유형</span><span class="cnt">'+requestName+'</span></li>'
// 						+'<li><span class="title">과금단위</span><span class="cnt">'+(hourlyFlag == "Y"?"시간":"월")+'</span></li>'
// 						+'<li><span class="title">희망일시</span><span class="cnt">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span></li>'
// 						+(nasGb==null?"":'<li><span class="title">DISK</span><span class="cnt">'+nasGb+' GB</span></li>')
// 					+'</ul>');
// 				$("#popDetailAmt").html('<strong>'+addcomma(amount)+'</strong><span>&nbsp;원</span>');
// 			}

			function openPopNas(projectName, projectAlias, nasName, vmName, requestName, hourlyFlag, onDemandFlag, applyDatetime, nasGb, amount,description, requestType) {
				$("#nas-modal-dialog").modal();
				if(description == ''){
					description = '요청내용이 없습니다.'
				}

				$("#nas-title").html('NAS 상세내역');

				$("#nasDetailDiv1").html('<table class="m_table">'
						+'<tbody>'
						+'<tr><th>프로젝트 ID</th><td>'+projectName+'</td></tr>'
						+'<tr><th>프로젝트명</th><td>'+projectAlias+'</td></tr>'
						+'<tr><th>NAS명</th><td>'+nasName+'</td></tr>'
						+'<tr><th>서비스 희망일시</th><td>'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</td></tr>'
						+'<tr><th>가상서버</th><td>'+(vmName==null?"":vmName)+'</td></tr>'
						+'<tr><th>요청유형</th><td>'+requestName+'</td></tr>'
						+'<tr><th>요청내용</th><td>'+description+'</td></tr>'
						+'</tbody>'
					+'</table>');



				if(requestType == 'REQTYPE_CHANGE'){
					$("#nasDetailDiv2").html('<div class="tac center">'
							+(nasGb==null?"":'<p class="diskArea mb5 f20 center">'+nasGb+'</p>')
							+ '<p class="fc11 fb">NAS<span class="fc66 fn">(GB)</span></p>'
							+'</div>'
							+'<div class="clear"></div>'
/* 							+'<ul class="mt30">'
							+'<li class="clear fl"><span class="serverPopLabel3">요청내용 </span></li>'
							+'<li class="clear fl mt10 tal lh24">'+description+'</li>'
							+'</ul>' */
							);
				}else{
				$("#nasDetailDiv2").html('<div class="tac center">'
						+(nasGb==null?"":'<p class="diskArea mb5 f20 center">'+nasGb+'</p>')
						+ '<p class="fc11 fb">NAS<span class="fc66 fn">(GB)</span></p>'
						+'</div>'
						+'<div class="clear"></div>'
/* 						+'<ul class="mt30">'
						+'<li class="clear fl"><span class="serverPopLabel3">요청내용 </span></li>'
						+'<li class="clear fl mt10 tal lh24">'+description+'</li>'
						+'</ul>' */
						);
			}
			}


			function openPopLb(projectAlias, loadbalancerProductName, requestName, hourlyFlag, onDemandFlag, applyDatetime, amount) {
				$("#detail-modal-dialog").modal();

				$("#popDetailTitle").html('서비스 로드분산 상세내역');
				$("#popDetailDivProject").html('<strong class="title">'+projectAlias+'</strong>');

				$("#popDetailDiv1").html('<ul>'
						+'<li><span class="title">서비스 로드분산명</span><span class="cnt">'+(loadbalancerProductName==null?"":loadbalancerProductName)+'</span></li>'
					+'</ul>');
				$("#popDetailDiv1").show();

				$("#popDetailDiv2").html('<ul>'
						+'<li><span class="title">요청유형</span><span class="cnt">'+requestName+'</span></li>'
						+'<li><span class="title">과금단위</span><span class="cnt">'+(hourlyFlag == "Y"?"시간":"월")+'</span></li>'
						+'<li><span class="title">희망일시</span><span class="cnt">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span></li>'
					+'</ul>');
				$("#popDetailAmt").html('<strong>'+addcomma(amount)+'</strong><span>&nbsp;원</span>');
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




			function openPopService(projectName, serviceName, serviceTypeName, description, projectAlias, hostname, hostnameAlias, requestName, hourlyFlag, onDemandFlag, applyDatetime, amount) {
				$("#service-modal-dialog").modal();

				if(description == ''){
					description = '요청내용이 없습니다.'
				}


				$("#service-title").html('서비스 상세내역');
/* 				$("#serviceDetailDiv1").html('<p>'
						+'<span class="serverPopLabel2 fl">프로젝트명</span><span class="fc11 fl lh26 ml5">'+projectAlias+'</span>'
						+'<span class="pop_pid flr">'+projectName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel2">서비스 유형</span><span class="fc11 ml5">'+serviceTypeName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3" >서비스 희망일시</span><span class="fc11 ml5">'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">서비스명</span><span class="fc11 ml5">'+serviceName+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3" >가상서버</span><span class="fc11 ml5">'+hostnameAlias+'</span>'
						+'</p>'
						+'<p class="fl mt10 clear">'
						+'<span class="serverPopLabel3">요청유형 </span><span class="fc11 ml5">'+requestName+'</span>'
					+'</p>');	 */

				$("#serviceDetailDiv1").html('<table class="m_table">'
						+'<tbody>'
						+'<tr><th>프로젝트 ID</th><td>'+projectName+'</td></tr>'
						+'<tr><th>프로젝트명</th><td>'+projectAlias+'</td></tr>'
						+'<tr><th>서비스 유형</th><td>'+serviceTypeName+'</td></tr>'
						+'<tr><th>서비스 희망일시</th><td>'+(onDemandFlag == "N"?applyDatetime:"승인완료 후")+'</td></tr>'
						+'<tr><th>서비스명</th><td>'+serviceName+'</td></tr>'
						+'<tr><th>가상서버</th><td>'+hostnameAlias+'</td></tr>'
						+'<tr><th>요청유형</th><td>'+requestName+'</td></tr>'
						+'<tr><th>요청내용</th><td>'+description+'</td></tr>'
						+'</tbody>'
					+'</table>');



				$("#serviceDetailDiv2").html('<div>'
/* 						+'<ul>'
						+'<li class="clear fl mt10"><span class="serverPopLabel3">요청내용 </span></li>'
						+'<li class="clear fl mt10 tal lh24">'+description+'</li>'
						+'</ul>' */
						+'</div>');
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

			function clearUpperApproval() {
				var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
				for(var i = tmpCurrentApprovalStep-1 ; i < 4; i++) {
					approvalList.splice(i, 1);

					$("#approvalLine"+(i+1)+"_userId").text("사번");
					$("#approvalLine"+(i+1)+"_userLevel").text("직급");
					$("#approvalLine"+(i+1)+"_userName").text("이름");

					$("#approvalLine"+(i+1)).attr('disabled', true);
				}

				//초기화 하더라도 차장급 이상이면 재활성화되게
				if( ${userLevelCode} < 5 ) {
					$("#approvalLine2").attr('disabled', false);
				}

				$("#user-modal-review-dialog").modal();
				gridPopList();
			}

			// 결재라인 초기화
			function initApprovalLine() {
				var tmpUserLevelCode = 100;
				if( ${userLevelCode} == null || ${userLevelCode} == '' ) {
					tmpUserLevelCode == 100;
				} else {
					tmpUserLevelCode == ${userLevelCode};
				}

				// 직급에 따른 버튼활성화 - 3직급(차장) == 4
				$("#approvalLine1").attr('disabled', false);
				if( ${userLevelCode} < 5 ) {
					$("#approvalLine2").attr('disabled', false);
				}
			}

			$(document).ready(function() {
			    App.init();
			    initApprovalLine();


			    $("a>button").on('click',function(){
					location.href = $(this).closest("a").attr("href");
				});

				$("#all_chk").on("change",function(){
					//alert("11");
					if($(this).is(':checked')){
						//체크박스 모두 체크
						$("input:checkbox[name='projectIdchk']").prop('checked',true);
					}else{
						//체크박스 모두 해제
						$("input:checkbox[name='projectIdchk']").prop('checked',false);
					}
				});

			  	//메뉴활성화
				$("#reqProduct").addClass("active");
				$("#basket").addClass("active");
			});

		</script>
	</body>
</html>