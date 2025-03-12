<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
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
<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer in">
	<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
	<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
	<div id="content" class="content">
			<c:if test="${instanceType eq null}">
				<p class="page_title">개발환경 배포
					<span class="root f14">Home <span class="arrow_ab"> &#8227; </span>
					<a href="${wasPath}/mbr/main"> 콘솔</a>
						<span class="arrow_ab"> &#8227; </span> 개발환경
						<span class="arrow_ab"> &#8227; </span>
					<b>개발환경 배포</b>
					</span>
				</p>
			</c:if>
			<c:if test="${instanceType ne null}">
				<p class="page_title">컨테이너 터미널
					<span class="root f14">Home <span class="arrow_ab"> &#8227; </span>
					<a href="${wasPath}/mbr/main"> 콘솔</a>
						<span class="arrow_ab"> &#8227; </span> 개발환경
						<span class="arrow_ab"> &#8227; </span>
					<b>컨테이너 터미널</b>
					</span>
				</p>
			</c:if>
			<input type="hidden" id="cicdProjectId" value="${cicdProjectId}"/>
			<input type="hidden" id="cicdUrl" value="${cicdUrl}"/>
			<input type="hidden" id="instanceType" value="${instanceType}"/>
			<!-- begin #content > page-body -->
			<div class="row p20 bgwh br10">
				<div class="col-lg-12">
                     <div class="clear"></div>
	                 <div class="loading-content">
	                         <i class="fas fa-spinner fa-spin"></i><span>목록을 가져오고 있습니다.</span>
	                 </div>
	                 <div class="overflow-wrapper">
	                 	<div class="col-md-12 pl0">
	                         <table class="productAppList productvmList table table-hover table-800">
	                             <colgroup>
	                                 <col width="100px">
	                                 <col width="*">
	                                 <col width="180px">
	                             </colgroup>
	                             <tbody>
	                             </tbody>
	                         </table>
	                 	</div>
	                 </div>
				</div>
	        </div>
		<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
	</div>

<div style="display:none;">
    <!-- 시작 -->
    <div class="resource-request-wrap">
		<div id="content" class="content mng-req-product-wiew-wrap">

			<!-- 코드 작성 -->
			<p style="margin:80px 0; font-size:30px;">아래는 PPT 5Page 코드입니다.</p>
			<!-- //코드 작성 -->

			<!-- begin #content header -->
			<p class="page_title">자원요청 승인
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span>
				<a href="${wasPath}/mbr/main"> 콘솔</a>
					<span class="arrow_ab"> &#8227; </span> 개발환경
					<span class="arrow_ab"> &#8227; </span>
				<b>자원요청 승인</b>
				</span>
			</p>


			<c:forEach items="${getProductAppSteplist}" var="productApprovalStepInfo" varStatus="status" >
				<c:choose>
					<c:when test="${productApprovalStepInfo.apprvState eq 'APPRV_UNASSIGNED' and productApprovalStepInfo.stepLevel > 4}">

						<div class="row tac m-t-50">
							<a type="button" class="rbton bton_blue" onclick="openApproveReviewModal(2)"><i class="fa fa-pencil"></i> 신청</a>
							<a type="button" class="rbton bton_orange" onclick="projectRejectedPopup('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-reply"></i> 반려</a>
							<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
						</div>
					</c:when>
					<c:when test="${productApprovalStepInfo.apprvAuth eq 'Y' and productApprovalStepInfo.apprvState eq 'APPRV_PROCESSING' and productApprovalStepInfo.stepLevel > 4}">
						<c:choose>
							<c:when test="${productApprovalStepInfo.apprvState eq 'APPRV_PROCESSING' and productApprovalStepInfo.stepId eq stepId }">
								<div class="row tac m-t-50">
									<a type="button" class="rbton bton_blue"  onclick="projectApprving('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-gavel"></i> 승인</a>
									<a type="button" class="rbton bton_orange" onclick="projectRejectedPopup('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-reply"></i> 반려</a>
									<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
								</div>
							</c:when>
							<c:otherwise>
								<c:if test="${productApprovalStepInfo.apprvState != 'APPRV_PROCESSING' and productApprovalStepInfo.stepId eq stepId }">
									<div class="row tac m-t-50">
										<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
									</div>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:if test="${productApprovalStepInfo.stepId eq stepId }">
							<div class="row tac m-t-50">
								<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
							</div>
						</c:if>
					</c:otherwise>
				</c:choose>

				<c:if test="${inject eq 'Y' and  productApprovalStepInfo.apprvState eq 'APPRV_REJECTED'}">
					<h2 class="titleBuType01 m-t-40 m-b-15">반려사유</h2>
					<textarea  rows="5" placeholder="비고란 입니다. 내용을 입력하세요" id="rejectedApprvDescription" name="rejectedApprvDescription" readonly >${productApprovalStepInfo.apprvDescription}</textarea>
					<div class="row tac m-t-50">
						<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i>  목록</a>
					</div>
				</c:if>
			</c:forEach>
			<!-- end page-body 버튼박스  -->


			<!-- begin page-body 프로젝트 정보  -->
			<div class="client_DetailArea mt20 bgwh">
				<!-- 프로젝트 정보 -->
				<h2 class="customer_Id">${projectInfo.projectName}</h2>
				<div class="clear"></div>
				<h3 class="pname dpin">${projectInfo.projectAlias} </h3>
				<div class="clear"></div>
				<div class="mt20 mb20">
		 			<span class="dpin fb fc-blue2">본부 : </span><span class="ml5">${fn:split(projectInfo.deptName2,'/')[1]}</span><span class="dpin fb ml40 fc-blue2">처(실) : </span><span class="ml5">${fn:split(projectInfo.deptName2,'/')[2]} </span><span class="dpin fb ml40 fc-blue2">부서 : </span><span class="ml5">${fn:split(projectInfo.deptName2,'/')[3]} </span><span class="dpin fb ml40 fc-blue2">담당자  : </span><span class="ml5">${projectInfo.customerName}(${projectInfo.managerTel})</span>
		 		</div>
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

		 		<!-- 프로젝트 내 현재 가용 용량  -->
				<div class="usageStatusWrap mt20">
					<strong class="titleLabel ml-24">현재 가용 용량</strong>
					<c:forEach items="${getCloudAvailListVo}" var="getCloudAvailListVo" varStatus="status" >
						<dl>
							<dt><c:out value="${getCloudAvailListVo.projectName}"></c:out></dt>
							<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>SERVER</span><span class="cnt"><em class="fc-orange"  id="allVmAvail"><fmt:formatNumber value="${getCloudAvailListVo.vmAvail}" pattern="#,###"/></em>EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>vCPU</span><span class="cnt"><em class="fc-violet" id="allVcpuAvail"><fmt:formatNumber value="${getCloudAvailListVo.vcpuAvail}" pattern="#,###"/></em>Core</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>MEMORY</span><span class="cnt"><em class="fc-blue" id="allMemAvail"><fmt:formatNumber value="${getCloudAvailListVo.memAvail}" pattern="#,###"/></em>GB</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>DISK</span><span class="cnt"><em class="fc-green" id="allDiskAvail"><fmt:formatNumber value="${getCloudAvailListVo.diskAvail}" pattern="#,###"/></em>GB</span></dd>
							<dd class="mt30"> <a type="button" onclick="useVolumeDetail('${getCloudAvailListVo.projectId}');"><button class="cbton bton_blue"><i class="fa fa-battery-half ml-2"></i> </button></a></dd>
						</dl>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>


<div class="resource-request-wrap">
		<div id="content" class="content mng-req-product-wiew-wrap">


			<!-- 코드 작성 -->
			<p style="margin:80px 0; font-size:30px;">아래는 PPT 10Page 개발환경 배포 코드입니다.</p>
			<!-- //코드 작성 -->


			<!-- begin #content header -->
			<p class="page_title">개발환경 배포
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span>
				<a href="${wasPath}/mbr/main"> 콘솔</a>
					<span class="arrow_ab"> &#8227; </span> 개발환경
					<span class="arrow_ab"> &#8227; </span>
				<b>개발환경 배포</b>
				</span>
			</p>


			<c:forEach items="${getProductAppSteplist}" var="productApprovalStepInfo" varStatus="status" >
				<c:choose>
					<c:when test="${productApprovalStepInfo.apprvState eq 'APPRV_UNASSIGNED' and productApprovalStepInfo.stepLevel > 4}">

						<div class="row tac m-t-50">
							<a type="button" class="rbton bton_blue" onclick="openApproveReviewModal(2)"><i class="fa fa-pencil"></i> 신청</a>
							<a type="button" class="rbton bton_orange" onclick="projectRejectedPopup('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-reply"></i> 반려</a>
							<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
						</div>
					</c:when>
					<c:when test="${productApprovalStepInfo.apprvAuth eq 'Y' and productApprovalStepInfo.apprvState eq 'APPRV_PROCESSING' and productApprovalStepInfo.stepLevel > 4}">
						<c:choose>
							<c:when test="${productApprovalStepInfo.apprvState eq 'APPRV_PROCESSING' and productApprovalStepInfo.stepId eq stepId }">
								<div class="row tac m-t-50">
									<a type="button" class="rbton bton_blue"  onclick="projectApprving('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-gavel"></i> 승인</a>
									<a type="button" class="rbton bton_orange" onclick="projectRejectedPopup('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-reply"></i> 반려</a>
									<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
								</div>
							</c:when>
							<c:otherwise>
								<c:if test="${productApprovalStepInfo.apprvState != 'APPRV_PROCESSING' and productApprovalStepInfo.stepId eq stepId }">
									<div class="row tac m-t-50">
										<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
									</div>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:if test="${productApprovalStepInfo.stepId eq stepId }">
							<div class="row tac m-t-50">
								<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
							</div>
						</c:if>
					</c:otherwise>
				</c:choose>

				<c:if test="${inject eq 'Y' and  productApprovalStepInfo.apprvState eq 'APPRV_REJECTED'}">
					<h2 class="titleBuType01 m-t-40 m-b-15">반려사유</h2>
					<textarea  rows="5" placeholder="비고란 입니다. 내용을 입력하세요" id="rejectedApprvDescription" name="rejectedApprvDescription" readonly >${productApprovalStepInfo.apprvDescription}</textarea>
					<div class="row tac m-t-50">
						<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i>  목록</a>
					</div>
				</c:if>
			</c:forEach>
			<!-- end page-body 버튼박스  -->


			<!-- begin page-body 프로젝트 정보  -->
			<div class="client_DetailArea mt20 bgwh">
				<!-- 프로젝트 정보 -->
				<h2 class="customer_Id">test</h2>
				<div class="clear"></div>
				<h3 class="pname dpin">test</h3>
				<div class="clear"></div>
				<div class="mt20 mb20">
		 			<span class="dpin fb fc-blue2">본부 : </span><span class="ml5">경영관리부사장</span>
		 			<span class="dpin fb ml40 fc-blue2">처(실) : </span><span class="ml5">ICT 기획처</span>
		 			<span class="dpin fb ml40 fc-blue2">부서 : </span><span class="ml5">인프라계획실</span>
		 			<span class="dpin fb ml40 fc-blue2">담당자  : </span><span class="ml5">한국전력공사(061-345-5387)</span>
		 		</div>
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

		 		<!-- 프로젝트 내 현재 가용 용량  -->
				<div class="usageStatusWrap mt20">
					<strong class="titleLabel ml-24">현재 가용 용량</strong>
					<c:forEach items="${getCloudAvailListVo}" var="getCloudAvailListVo" varStatus="status" >
						<dl>
							<dt><c:out value="${getCloudAvailListVo.projectName}"></c:out></dt>
							<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>SERVER</span><span class="cnt"><em class="fc-orange"  id="allVmAvail"><fmt:formatNumber value="${getCloudAvailListVo.vmAvail}" pattern="#,###"/></em>EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>vCPU</span><span class="cnt"><em class="fc-violet" id="allVcpuAvail"><fmt:formatNumber value="${getCloudAvailListVo.vcpuAvail}" pattern="#,###"/></em>Core</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>MEMORY</span><span class="cnt"><em class="fc-blue" id="allMemAvail"><fmt:formatNumber value="${getCloudAvailListVo.memAvail}" pattern="#,###"/></em>GB</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>DISK</span><span class="cnt"><em class="fc-green" id="allDiskAvail"><fmt:formatNumber value="${getCloudAvailListVo.diskAvail}" pattern="#,###"/></em>GB</span></dd>
							<dd class="mt30"> <a type="button" onclick="useVolumeDetail('${getCloudAvailListVo.projectId}');"><button class="cbton bton_blue"><i class="fa fa-battery-half ml-2"></i> </button></a></dd>
						</dl>
					</c:forEach>
				</div>
			</div>

			<p class="page_title mt40 mb20">신청정보</p>

			<div class="tableF">
				<table>
		            <colgroup>
		                <col width="15%">
		                <col width="35%">
		                <col width="15%">
		                <col width="35%">
		            </colgroup>

		            <tbody>
		                <tr>
		                    <td class="left">개발환경명</td>
		                    <td>
		                    	<input maxlength="30" class="form-control" name="" id="" type="text" data-original-title="" title="" control-id="">
		                    </td>
		                    <td class="left">공개범위</td>
		                    <td>
		                        <div class="searchBoxArea width-400">
								    <label class="selectBoxDrop" for="">공개범위</label>
								    <select class="search-sel" name="" id="" onchange="selectCloud();" control-id="ControlID-3">
								        <option value="">대역선택</option>
								    </select>
								</div>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="left">컨테이너 플랫폼</td>
		                    <td colspan="3">
		                        <input maxlength="30" class="form-control" name="" id="" type="text" data-original-title="" title="" control-id="">
		                    </td>
		                </tr>
		                <tr>
		                    <td class="left">컨테이너 템플릿</td>
		                    <td colspan="3">
		                        <input maxlength="30" class="form-control" name="" id="" type="text" data-original-title="" title="" control-id="">
		                    </td>
		                </tr>
		                <tr>
		                    <td class="left">망구분</td>
		                    <td>
		                        <div class="searchBoxArea width-400">
								    <label class="selectBoxDrop" for="">망구분</label>
								    <select class="search-sel" name="" id="" onchange="selectCloud();" control-id="ControlID-3">
								        <option value="">대역선택</option>
								    </select>
								</div>
		                    </td>
		                    <td class="left">프로젝트</td>
		                    <td>
		                    	<input maxlength="30" class="form-control" name="" id="" type="text">
		                    </td>
		                </tr>

		                <tr>
		                    <td class="left">어플리케이션명</td>
		                    <td>
		                        <input maxlength="30" class="form-control" name="" id="" type="text">
		                    </td>
		                    <td class="left">어플리케이션 ID</td>
		                    <td>
		                    	<div class="duplicate-check-box">
		                    		<input maxlength="30" class="form-control" name="" id="" type="text">
		                    		<button type="button">중복체크</button>
	                    		</div>
		                    </td>
		                </tr>

		                <tr>
		                    <td class="left">도메인 주소</td>
		                    <td>
		                    	<div class="domain-write-box">
			                        <input maxlength="30" class="form-control" name="" id="" type="text">
			                        <p>.oaocp4.kepco.co.kr</p>
		                        </div>
		                    </td>
		                    <td class="left">포트</td>
		                    <td>
		                    	<div class="duplicate-check-box">
		                    		<input maxlength="30" class="form-control" name="" id="" type="text">
		                    		<button type="button">중복체크</button>
	                    		</div>
		                    </td>
		                </tr>


		                <tr>
		                    <td class="left">git URL 주소</td>
		                    <td colspan="3">
		                        <input maxlength="30" class="form-control" name="" id="" type="text">
		                    </td>
		                </tr>


		                <tr>
		                    <td class="left">컨테이너 사양</td>
		                    <td>
		                        <div class="depth-dropdown-box">
									<div class="searchBoxArea">
									    <label class="selectBoxDrop" for="">서버분류</label>
									    <select class="search-sel" name="" id="" onchange="selectCloud();" control-id="ControlID-3">
									        <option value="">소규모</option>
									    </select>
									</div>
									<div class="searchBoxArea">
									    <label class="selectBoxDrop" for="">컨테이너사양 선택</label>
									    <select class="search-sel" name="" id="" onchange="selectCloud();" control-id="ControlID-3">
									        <option value="">ROOT</option>
									    </select>
									</div>
		                        </div>
		                    </td>
		                    <td class="left">컨테이너 수량</td>
		                    <td>
								<div id="DisplaydiskCnt">
									<input class="form-control w138" type="text"  placeholder="1" value="50" maxlength="5" name="diskcnt" id="diskcnt" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"  onfocusout="diskfocusout(this);" onkeyup="diskchange(this);" /> <p class="inputUnit pt15"> 개 </p>
									<input type="hidden" name="diskprice" id="diskprice" value='<fmt:formatNumber value="${diskPrice}" pattern="####"/>'>
									<input type="hidden" name="diskprice1" id="diskprice1" value='<fmt:formatNumber value="${diskPrice1}" pattern="####"/>'>
									<img src="/resources/assets/img/icon_minus.png"  onclick="diskminus();" class="minus"/><span class="snemo">10</span> <img src="/resources/assets/img/icon_plus.png" onclick="diskplus();" class="plus"/>
									 <p class="inputUnit pt15">개</p>
								</div>
		                    </td>
		                </tr>

		                <tr>
		                    <td class="left">context-Dir</td>
		                    <td>
		                        <div class="searchBoxArea width-400">
								    <label class="selectBoxDrop" for="">ROOT</label>
								    <select class="search-sel" name="" id="" onchange="selectCloud();" control-id="ControlID-3">
								        <option value="">ROOT</option>
								    </select>
								</div>
		                    </td>
		                </tr>

		                <!-- 재배포시 아래 상태 추가 -->
		                <tr>
		                    <td class="left">최종 배포 상태</td>
		                    <td>성공</td>
		                </tr>
		                <!-- // -->

		            </tbody>
		        </table>
	   			<div class="btn_area">
			        <a type="button" class="btn_navy" onclick="">배포 요청</a>
			        <a type="button" class="btn_dngrey ml10" onclick="moveListPage();">취소</a>
			    </div>
			</div>

		</div>
	</div>


<div class="resource-request-wrap">
		<div id="content" class="content mng-req-product-wiew-wrap">


			<!-- 코드 작성 -->
			<p style="margin:80px 0; font-size:30px;">아래는 파이프라인 관련 개발환경 배포 코드입니다.</p>
			<!-- //코드 작성 -->


			<!-- begin #content header -->
			<p class="page_title">운영 배포
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span>
				<a href="${wasPath}/mbr/main"> 콘솔</a>
					<span class="arrow_ab"> &#8227; </span> 개발환경
					<span class="arrow_ab"> &#8227; </span>
				<b>개발환경 배포</b>
				</span>
			</p>


			<c:forEach items="${getProductAppSteplist}" var="productApprovalStepInfo" varStatus="status" >
				<c:choose>
					<c:when test="${productApprovalStepInfo.apprvState eq 'APPRV_UNASSIGNED' and productApprovalStepInfo.stepLevel > 4}">

						<div class="row tac m-t-50">
							<a type="button" class="rbton bton_blue" onclick="openApproveReviewModal(2)"><i class="fa fa-pencil"></i> 신청</a>
							<a type="button" class="rbton bton_orange" onclick="projectRejectedPopup('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-reply"></i> 반려</a>
							<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
						</div>
					</c:when>
					<c:when test="${productApprovalStepInfo.apprvAuth eq 'Y' and productApprovalStepInfo.apprvState eq 'APPRV_PROCESSING' and productApprovalStepInfo.stepLevel > 4}">
						<c:choose>
							<c:when test="${productApprovalStepInfo.apprvState eq 'APPRV_PROCESSING' and productApprovalStepInfo.stepId eq stepId }">
								<div class="row tac m-t-50">
									<a type="button" class="rbton bton_blue"  onclick="projectApprving('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-gavel"></i> 승인</a>
									<a type="button" class="rbton bton_orange" onclick="projectRejectedPopup('${productApprovalStepInfo.stepLevel}','${orderNo}','${productApprovalStepInfo.rightStepId}')"><i class="fa fa-reply"></i> 반려</a>
									<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
								</div>
							</c:when>
							<c:otherwise>
								<c:if test="${productApprovalStepInfo.apprvState != 'APPRV_PROCESSING' and productApprovalStepInfo.stepId eq stepId }">
									<div class="row tac m-t-50">
										<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
									</div>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:if test="${productApprovalStepInfo.stepId eq stepId }">
							<div class="row tac m-t-50">
								<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
							</div>
						</c:if>
					</c:otherwise>
				</c:choose>

				<c:if test="${inject eq 'Y' and  productApprovalStepInfo.apprvState eq 'APPRV_REJECTED'}">
					<h2 class="titleBuType01 m-t-40 m-b-15">반려사유</h2>
					<textarea  rows="5" placeholder="비고란 입니다. 내용을 입력하세요" id="rejectedApprvDescription" name="rejectedApprvDescription" readonly >${productApprovalStepInfo.apprvDescription}</textarea>
					<div class="row tac m-t-50">
						<a type="button" class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i>  목록</a>
					</div>
				</c:if>
			</c:forEach>
			<!-- end page-body 버튼박스  -->


			<!-- begin page-body 프로젝트 정보  -->
			<div class="client_DetailArea mt20 bgwh">
				<!-- 프로젝트 정보 -->
				<h2 class="customer_Id">test</h2>
				<div class="clear"></div>
				<h3 class="pname dpin">test</h3>
				<div class="clear"></div>
				<div class="mt20 mb20">
		 			<span class="dpin fb fc-blue2">본부 : </span><span class="ml5">경영관리부사장</span>
		 			<span class="dpin fb ml40 fc-blue2">처(실) : </span><span class="ml5">ICT 기획처</span>
		 			<span class="dpin fb ml40 fc-blue2">부서 : </span><span class="ml5">인프라계획실</span>
		 			<span class="dpin fb ml40 fc-blue2">담당자  : </span><span class="ml5">한국전력공사(061-345-5387)</span>
		 		</div>
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

		 		<!-- 프로젝트 내 현재 가용 용량  -->
				<div class="usageStatusWrap mt20">
					<strong class="titleLabel ml-24">현재 가용 용량</strong>
					<c:forEach items="${getCloudAvailListVo}" var="getCloudAvailListVo" varStatus="status" >
						<dl>
							<dt><c:out value="${getCloudAvailListVo.projectName}"></c:out></dt>
							<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>SERVER</span><span class="cnt"><em class="fc-orange"  id="allVmAvail"><fmt:formatNumber value="${getCloudAvailListVo.vmAvail}" pattern="#,###"/></em>EA</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>vCPU</span><span class="cnt"><em class="fc-violet" id="allVcpuAvail"><fmt:formatNumber value="${getCloudAvailListVo.vcpuAvail}" pattern="#,###"/></em>Core</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>MEMORY</span><span class="cnt"><em class="fc-blue" id="allMemAvail"><fmt:formatNumber value="${getCloudAvailListVo.memAvail}" pattern="#,###"/></em>GB</span></dd>
							<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>DISK</span><span class="cnt"><em class="fc-green" id="allDiskAvail"><fmt:formatNumber value="${getCloudAvailListVo.diskAvail}" pattern="#,###"/></em>GB</span></dd>
							<dd class="mt30"> <a type="button" onclick="useVolumeDetail('${getCloudAvailListVo.projectId}');"><button class="cbton bton_blue"><i class="fa fa-battery-half ml-2"></i> </button></a></dd>
						</dl>
					</c:forEach>
				</div>
			</div>

			<p class="page_title mt40 mb20">신청정보</p>

			<div class="tableF">
				<table>
		            <colgroup>
		                <col width="15%">
		                <col width="35%">
		                <col width="15%">
		                <col width="35%">
		            </colgroup>

		            <tbody>
		                <tr>
		                    <td class="left">개발환경명</td>
		                    <td>
		                    	<input maxlength="30" class="form-control" name="" id="" type="text" data-original-title="" title="" control-id="">
		                    </td>
		                    <td class="left">공개범위</td>
		                    <td>
		                        <div class="searchBoxArea width-400">
								    <label class="selectBoxDrop" for="">공개범위</label>
								    <select class="search-sel" name="" id="" onchange="selectCloud();" control-id="ControlID-3">
								        <option value="">대역선택</option>
								    </select>
								</div>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="left">컨테이너 플랫폼</td>
		                    <td colspan="3">
		                        <input maxlength="30" class="form-control" name="" id="" type="text" data-original-title="" title="" control-id="">
		                    </td>
		                </tr>
		                <tr>
		                    <td class="left">망구분</td>
		                    <td>
		                        <div class="searchBoxArea width-400">
								    <label class="selectBoxDrop" for="">망구분</label>
								    <select class="search-sel" name="" id="" onchange="selectCloud();" control-id="ControlID-3">
								        <option value="">대역선택</option>
								    </select>
								</div>
		                    </td>
		                    <td class="left">프로젝트</td>
		                    <td>
		                    	<input maxlength="30" class="form-control" name="" id="" type="text">
		                    </td>
		                </tr>

		                <tr>
		                    <td class="left">어플리케이션명</td>
		                    <td>
		                        <input maxlength="30" class="form-control" name="" id="" type="text">
		                    </td>
		                    <td class="left">어플리케이션 ID</td>
		                    <td>
		                    	<div class="duplicate-check-box">
		                    		<input maxlength="30" class="form-control" name="" id="" type="text">
		                    		<button type="button">중복체크</button>
	                    		</div>
		                    </td>
		                </tr>

		                <tr>
		                    <td class="left">도메인 주소</td>
		                    <td>
		                    	<div class="domain-write-box">
			                        <input maxlength="30" class="form-control" name="" id="" type="text">
			                        <p>.oaocp4.kepco.co.kr</p>
		                        </div>
		                    </td>
		                    <td class="left">포트</td>
		                    <td>
		                    	<div class="duplicate-check-box">
		                    		<input maxlength="30" class="form-control" name="" id="" type="text">
		                    		<button type="button">중복체크</button>
	                    		</div>
		                    </td>
		                </tr>


		                <tr>
		                    <td class="left">git URL 주소</td>
		                    <td colspan="3">
		                        <input maxlength="30" class="form-control" name="" id="" type="text">
		                    </td>
		                </tr>


		                <tr>
		                    <td class="left">컨테이너 사양</td>
		                    <td>
		                        <div class="depth-dropdown-box">
									<div class="searchBoxArea">
									    <label class="selectBoxDrop" for="">서버분류</label>
									    <select class="search-sel" name="" id="" onchange="selectCloud();" control-id="ControlID-3">
									        <option value="">소규모</option>
									    </select>
									</div>
									<div class="searchBoxArea">
									    <label class="selectBoxDrop" for="">컨테이너사양 선택</label>
									    <select class="search-sel" name="" id="" onchange="selectCloud();" control-id="ControlID-3">
									        <option value="">ROOT</option>
									    </select>
									</div>
		                        </div>
		                    </td>
		                    <td class="left">컨테이너 수량</td>
		                    <td>
								<div id="DisplaydiskCnt">
									<input class="form-control w138" type="text"  placeholder="1" value="50" maxlength="5" name="diskcnt" id="diskcnt" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"  onfocusout="diskfocusout(this);" onkeyup="diskchange(this);" /> <p class="inputUnit pt15"> 개 </p>
									<input type="hidden" name="diskprice" id="diskprice" value='<fmt:formatNumber value="${diskPrice}" pattern="####"/>'>
									<input type="hidden" name="diskprice1" id="diskprice1" value='<fmt:formatNumber value="${diskPrice1}" pattern="####"/>'>
									<img src="/resources/assets/img/icon_minus.png"  onclick="diskminus();" class="minus"/><span class="snemo">10</span> <img src="/resources/assets/img/icon_plus.png" onclick="diskplus();" class="plus"/>
									 <p class="inputUnit pt15">개</p>
								</div>
		                    </td>
		                </tr>

		                <tr>
		                    <td class="left">context-Dir</td>
		                    <td>
		                        <div class="searchBoxArea width-400">
								    <label class="selectBoxDrop" for="">ROOT</label>
								    <select class="search-sel" name="" id="" onchange="selectCloud();" control-id="ControlID-3">
								        <option value="">ROOT</option>
								    </select>
								</div>
		                    </td>
		                </tr>
		                <tr>
		                	<td class="left" colspan="4">파이프라인 단계</td>
		                </tr>
		                <tr>
		                	<td colspan="4">
		                		<ul class="pipeline-group">
		                			<li>
		                				<div class="title">Stage: staging</div>
		                				<div class="pip-content">
		                					<div class="pip-status"><i class="success"></i> Cleanup-job	<i class="ongoing"></i></div>
		                				</div>
		                			</li>
		                			<li>
		                				<div class="title">Stage: production​</div>
		                				<div class="pip-content">
		                					<div class="pip-status"><i class="fail"></i> Job:skipped_production​</div>
		                				</div>
		                			</li>
		                		</ul>
		                		<!-- 필요시 사용하세요
		                		<ul class="pipeline-group">
		                			<li>
		                				<div class="title">Cleanup</div>
		                				<div class="pip-content">
		                					<div class="pip-status">Cleanup-job <i class="success"></i></div>
		                				</div>
		                			</li>
		                			<li>
		                				<div class="title">개발</div>
		                				<div class="pip-content">
		                					<div class="pip-status">Deploy-job <i class="success"></i></div>
		                				</div>
		                			</li>
		                			<li>
		                				<div class="title">운영</div>
		                				<div class="pip-content">
		                					<div class="pip-status">Prd-depoly-job <i class="ongoing"></i></div>
		                				</div>
		                			</li>
		                			<li>
		                				<div class="title">운영</div>
		                				<div class="pip-content">
		                					<div class="pip-status">Deploy-flag <i class="before"></i></div>
		                					<div class="pip-status">Rollback <i class="before"></i></div>
		                				</div>
		                			</li>
		                		</ul>
		                		 -->
		                	</td>
		                </tr>
		            </tbody>
		        </table>
	   			<div class="btn_area">
	   				<a type="button" class="btn_navy" onclick="">재배포</a>
			        <a type="button" class="btn_navy ml10" onclick="">배포 요청</a>
			        <a type="button" class="btn_dngrey ml10" onclick="moveListPage();">취소</a>
			    </div>
			</div>

		</div>
	</div>
	<!-- 파이프라인 단계 관련 UI -->
</div>

</div>

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

    function gridItem() {
    	$(".productAppList tbody").empty();

    	var urlValue = "";
    	if($("#instanceType").val() == ""){
    		urlValue = "${contextPath}/mbr/application/req/containerList";
		} else {
			urlValue = "${contextPath}/mbr/application/req/terminalList";
		}

        var html = "";
        $.ajax({
            url : urlValue,
            dataType : "JSON",
            type : "GET",
			success : function(req) {
					var appList = req;
					var idx = 0;
					$.each(appList,	function(key, val) {
					var Html = "";
					Html = "<tr>";
					Html += "<td class='tac app vam'><img src='"+val["imagePath"]+"'  class='width-70'></td>";
					Html += "<td class='serverInfo'><p class='infoTitle'>"
					        + val["displayName"]
					        + "</p>";
					if (val["descriptionList"] != null) {
					    Html += "<p class='infoContents'>"
					            + val["descriptionList"].replace('\n', '<br/>')
					            + "</p>";
					} else {
					    Html += "<p class='infoContents'>'운영체제 설치를 위한 기본 DISK가 제공되며, <br>추가 DISK를 직접 생성 할 수 있습니다.'</p>";
					}
					Html += "</td>";


					if($("#instanceType").val() == ""){
						Html += "<td class='BasketArea'><a href='${wasPath}/mbr/application/req/catalogueDevExport?productSeq=";
	                    Html += val["productSeq"]
								+ "&cloudId="
						   		+ val["cloudId"]
								+ "&cloudType="
						   		+ val["cloudType"]
								+ "&imageType="
						   		+ val["imageType"]
						   		+ "&hourlyFlag=N' class='insertBasket btn btn-detail'></a></td>";
					} else {
						Html += "<td class='BasketArea'><a href='${wasPath}/mbr/req/catalogue/catalogueOrder.do?productSeq=";
	                    Html += val["productSeq"]
	                    		+ "&instanceType="
						   		+ $("#instanceType").val()
// 	                    		+ "&cloudId="
// 						   		+ val["cloudId"]
// 			                    + "&cloudType="
// 						   		+ val["cloudType"]
			                    + "&imageType="
						   		+ val["imageType"]
						   		+ "&hourlyFlag=N' class='insertBasket btn btn-detail'></a></td>";
					}

//                     Html += "<td class='BasketArea'><a href='${wasPath}/mbr/application/req/catalogueDevExport?productSeq=";
//                     Html += val["productSeq"]
// 							+ "&cicdProjectId="
// 					   		+ $("#cicdProjectId").val()
// 					   		+ "&cicdUrl="
// 					   		+ $("#cicdUrl").val()
// 							+ "&cloudId="
// 					   		+ val["cloudId"]
// 							+ "&cloudType="
// 					   		+ val["cloudType"]
// 							+ "&imageType="
// 					   		+ val["imageType"]
// 					   		+ "&hourlyFlag=N' class='insertBasket btn btn-detail'><i class='fas fa-search'></i></a></td>";
					Html += "</tr>";

					$(".pl0 .productAppList tbody").append(Html);
					idx++;
                }); //end forEach
                $(".loading-content").hide();
            },
            error : function(request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

	$(document).ready(function() {
		App.init();
        gridItem();

		//메뉴활성화
		if($("#instanceType").val() == ""){
			$("#reqDev").addClass("active");
			$("#reqDevDeploy").addClass("active");
		} else {
			$("#reqDev").addClass("active");
			$("#reqCt").addClass("active");
		}
	});
</script>
</body>
</html>