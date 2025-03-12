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
		<link href="${apachePath}/resources/assets/plugins/jqGrid/css/ui.jqgrid.css" rel="stylesheet" />
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

			        <input type="hidden" id="downloadNo" 		value="${getProjectView.reqProjectSeq}" />
					<input type="hidden" id="allOrderNo" 		value="${orderNo}" />
					<input type="hidden" id="stepId" 			value="${stepId}" />
					<input type="hidden" id="userApprvState" 	value="${userApprvState}" />
					<input type="hidden" id="userApprvState" 	value="${getProjectView.projectRegDatetime}" />
					<input type="hidden" id="regUserId" 		value="${getProjectView.regUserId}" />
					<input type="hidden" id="sessionRoles" 		value="${roles}" />
					<input type="hidden" id="sessionUserId" 	value="${userId}" />
					<input type="hidden" id="sessionUserName" 	value="${userName}" />
					<input type="hidden" id="reqProjectSeq" 	value="${getProjectView.reqProjectSeq}" />
					<input type="hidden" id="h_cloudIds" value="" />

					<!--  반려사유  -->
					<input type="hidden" id="orderNo" value="${orderNo}" />
					<input type="hidden" id="userId" value="${userId}" />
					<input type="hidden" id="inject" value="${inject}" />

					<!-- 회원사,부서 -->
					<input type="hidden" name="h_customerId" id="h_customerId" value="${getProjectView.customerId}" />
					<input type="hidden" name="h_deptCode" id="h_deptCode" value="${getProjectView.projectDeptCode}" />
					<input type="hidden" name="hiddenUserIdReview" id="hiddenUserIdReview" value="" />
					<input type="hidden" name="hiddenUserIdApprove" id="hiddenUserIdApprove" value="" />
					<input type="hidden" name="hidden_login_user_id" id="hidden_login_user_id" value="${userId}" />
					<input type="hidden" name="h_popAdminiStratorId" id="h_popAdminiStratorId" value="${getProjectView.projectAdminiStratorId}" />
					<input type="hidden" name="h_popAdminiStratorName" id="h_popAdminiStratorName" value="" />
					<input type="hidden" name="h_popAdminiStratorDept" id="h_popAdminiStratorDept" value="" />

					<!-- BOX 1 결재라인 -->

					<!--
					<div class="col-xs-12 mb30 pl0 pr0">
						<div class="col-xs-6 request">
							<h3 class="request_title">요청부서</h3>
						 	<div class="col-xs-12 clear mt50">
									 <div class="col-xs-4 pl0 pr0">
									 <ul class="circle01 flr">
									    <li class="fc11 f18 fb">담당</li>
									    <li>${userVo.deptName}</li>
									    <li class="mt-5">${userVo.userName}</li>

									     <c:if test="${getProjectView.statusFlag eq '01' }">
									    <li class="mt5 mb5"><span class="bg_grey p814 br5 fb"><i class="fa fa-ellipsis-h"></i> 진행중</span></li>
									    </c:if>

									    <c:if test="${getProjectView.statusFlag ne '01' }">
									    <li class="mt5 mb5"><span class="bg_green p814 br5 fb"><i class="fa fa-file-text-o"></i> 신청완료</span></li>
									    <li class="fc99 width-100 f13 center">${userVo.projectRegDatetime}</li>
									    </c:if>

									 </ul>
									 </div>
						 	 <c:forEach items="${getProjectAppSteplist}" var="getProjectAppSteplist" varStatus="status" >
							 <c:if test="${getProjectAppSteplist.stepLevel eq '1'}">
									 <div class="col-xs-4 tac pl0 pr0">
									 <ul class="circle02">
									    <li class="fc11 f18 fb">검토</li>

									        <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_PROCESSING' }">
										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserDeptName}</li>
										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserName}</li>
										    <li class="mt5 mb5"><span class="bg_grey p814 br5 fb"><i class="fa fa-ellipsis-h"></i> 진행중</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_COMPLETED' }">
										    <li>${getProjectAppSteplist.apprvUserDeptName}</li>
									        <li class="mt-5">${getProjectAppSteplist.apprvUserName}</li>
										    <li class="mt5 mb5"><span class="bg_green p814 br5 fb"><i class="fa fa-gavel"></i> 승인완료</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_REJECTED' }">
										    <li>${getProjectAppSteplist.apprvUserDeptName}</li>
									        <li class="mt-5">${getProjectAppSteplist.apprvUserName}</li>
										    <li class="mt5 mb5"><span class="bg_orange p814 br5 fb" onclick="projectRejectHits()"><i class="fa fa-reply"></i> 반려</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_WAITING' }">
										    <li class="mt5 mb5"><span class="bg_grey p814 br5 fb"><i class="fa fa-hourglass-half"></i> 대기</span></li>
										    </c:if>

									   <li class="fc99 width-100 f13 center">${getProjectAppSteplist.apprvDatetime}</li>
									 </ul>
									 </div>
							 </c:if>
							 <c:if test="${getProjectAppSteplist.stepLevel eq '2'}">
									 <div class="col-xs-4 pl0 pr0">
									 <ul class="circle03 fl">
									    <li class="fc11 f18 fb">승인</li>

									        <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_PROCESSING' }">
									   		<li class="mt-5">${getProjectAppSteplist.apprvScheduleUserDeptName}</li>
										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserName}</li>
										    <li class="mt5 mb5"><span class="bg_grey p814 br5 fb"><i class="fa fa-ellipsis-h"></i> 진행중</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_COMPLETED' }">
										    <li>${getProjectAppSteplist.apprvUserDeptName}</li>
									        <li class="mt-5">${getProjectAppSteplist.apprvUserName}</li>
										    <li class="mt5 mb5"><span class="bg_green p814 br5 fb"><i class="fa fa-gavel"></i> 승인완료</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_REJECTED' }">
										    <li>${getProjectAppSteplist.apprvUserDeptName}</li>
									        <li class="mt-5">${getProjectAppSteplist.apprvUserName}</li>
										    <li class="mt5 mb5"><span class="bg_orange p814 br5 fb" onclick="projectRejectHits()"><i class="fa fa-reply"></i> 반려</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_WAITING' }">
										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserDeptName}</li>
										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserName}</li>
										    <li class="mt5 mb5"><span class="bg_grey p814 br5 fb"><i class="fa fa-hourglass-half"></i> 대기</span></li>
										    </c:if>

									  <li class="fc99 width-100 f13 center">${getProjectAppSteplist.apprvDatetime}</li>
									 </ul>
									 </div>
							 </c:if>
					        </c:forEach>

						</div>
						</div>

						<div class="col-xs-6 approval flr">
							<h3 class="approval_title">승인부서</h3>
						 	<div class="col-xs-12 clear mt50">
						 	 <c:forEach items="${getProjectAppSteplist}" var="getProjectAppSteplist" varStatus="status" >
						 	 <c:if test="${getProjectAppSteplist.stepLevel eq '3'}">
								 	 <div class="col-xs-4 pl0 pr0">
									 <ul class="circle04">
									    <li class="fc11 f18 fb">담당</li>

									        <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_PROCESSING' }">
									        <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserDeptName}</li>
										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserName}</li>
										    <li class="mt5 mb5"><span class="bg_lskyblue p814 br5 fb"><i class="fa fa-ellipsis-h"></i> 진행중</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_COMPLETED' }">
										    <li>${getProjectAppSteplist.apprvUserDeptName}</li>
									         <li class="mt-5">${getProjectAppSteplist.apprvUserName}</li>
										    <li class="mt5 mb5"><span class="bg_skyblue p814 br5 fb"><i class="fa fa-gavel"></i> 승인완료</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_REJECTED' }">
										    <li>${getProjectAppSteplist.apprvUserDeptName}</li>
									        <li class="mt-5">${getProjectAppSteplist.apprvUserName}</li>
										    <li class="mt5 mb5"><span class="bg_orange p814 br5 fb" onclick="projectRejectHits()"><i class="fa fa-reply"></i> 반려</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_WAITING' }">
										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserDeptName}</li>
										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserName}</li>
										    <li class="mt5 mb5"><span class="bg_grey p814 br5 fb"><i class="fa fa-hourglass-half"></i> 대기</span></li>
										    </c:if>

									     <li class="fc99 width-100 f13 center">${getProjectAppSteplist.apprvDatetime}</li>
									     </ul>
									 </div>
							 </c:if>
							 <c:if test="${getProjectAppSteplist.stepLevel eq '4'}">
									 <div class="col-xs-4 tac pl0 pr0">
									 <ul class="circle05">
									    <li class="fc11 f18 fb">검토</li>

									        <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_PROCESSING' }">
											<li class="mt-5">${getProjectAppSteplist.apprvScheduleUserDeptName}</li>
											<li class="mt-5">${getProjectAppSteplist.apprvScheduleUserName}</li>
										    <li class="mt5 mb5"><span class="bg_lskyblue p814 br5 fb"><i class="fa fa-ellipsis-h"></i> 진행중</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_COMPLETED' }">
										    <li>${getProjectAppSteplist.apprvUserDeptName}</li>
									        <li class="mt-5">${getProjectAppSteplist.apprvUserName}</li>
										    <li class="mt5 mb5"><span class="bg_skyblue p814 br5 fb"><i class="fa fa-gavel"></i> 승인완료</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_REJECTED' }">
										    <li>${getProjectAppSteplist.apprvUserDeptName}</li>
									        <li class="mt-5">${getProjectAppSteplist.apprvUserName}</li>
										    <li class="mt5 mb5"><span class="bg_orange p814 br5 fb" onclick="projectRejectHits()"><i class="fa fa-reply"></i> 반려</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_WAITING' }">
										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserDeptName}</li>
										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserName}</li>
										    <li class="mt5 mb5"><span class="bg_grey p814 br5 fb"><i class="fa fa-hourglass-half"></i> 대기</span></li>
										    </c:if>

									     <li class="fc99 width-100 f13 center">${getProjectAppSteplist.apprvDatetime}</li>
									 </ul>
									 </div>
							 </c:if>
							 <c:if test="${getProjectAppSteplist.stepLevel eq '5'}">
									<div class="col-xs-4 pl0 pr0">
									 <ul class="circle06">
									    <li class="fc11 f18 fb">승인</li>

									        <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_PROCESSING' }">
									         <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserDeptName}</li>
										     <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserName}</li>
										    <li class="mt5 mb5"><span class="bg_lskyblue p814 br5 fb"><i class="fa fa-ellipsis-h"></i> 진행중</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_COMPLETED' }">
										    <li>${getProjectAppSteplist.apprvUserDeptName}</li>
									        <li class="mt-5">${getProjectAppSteplist.apprvUserName}</li>
										    <li class="mt5 mb5"><span class="bg_skyblue p814 br5 fb"><i class="fa fa-gavel"></i> 승인완료</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_REJECTED' }">
										    <li>${getProjectAppSteplist.apprvUserDeptName}</li>
									        <li class="mt-5">${getProjectAppSteplist.apprvUserName}</li>
										    <li class="mt5 mb5"><span class="bg_orange p814 br5 fb" onclick="projectRejectHits()"><i class="fa fa-reply"></i> 반려</span></li>
										    </c:if>
										    <c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_WAITING' }">

										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserDeptName}</li>
										    <li class="mt-5">${getProjectAppSteplist.apprvScheduleUserName}</li>

										    <li class="mt5 mb5"><span class="bg_grey p814 br5 fb"><i class="fa fa-hourglass-half"></i> 대기</span></li>
										    </c:if>

									   <li class="fc99 width-100 f13 center">${getProjectAppSteplist.apprvDatetime}</li>
									 </ul>
									 </div>
							 </c:if>
							</c:forEach>
							</div>
						</div>
					</div>
					-->

					<div class="clear"></div>

					<!-- BOX 2 프로젝트 정보 -->
				 	<input type="hidden" name="projectId" id="projectId" value="${getProjectView.projectId}" />


				<%-- 	<table class="tableX">
					<colgroup>
					<col width="8%"/>
					<col width="17%"/>
					<col width="8%"/>
					<col width="17%"/>
					<col width="7%"/>
					<col width="14%"/>
					<col width="8%"/>
					<col width="*"/>
					</colgroup>
					<tbody>
					<tr>
					<th>프로젝트 아이디 </th><td colspan="7"><span class="pid" id="projectName">${getProjectView.reqProjectName==null?'미지정':getProjectView.reqProjectName}</span> </td>
					</tr>
					<tr>
					<th>프로젝트 이름 </th><td colspan="7"><input type="text" id="projectAlias" class="form-control dpin width-800"> </td>
					</tr>
					<tr>
					<th>회원사 </th>
					<td><input type="text" name="customerName" id="customerName"  placeholder="고객사를 선택하세요"  style="ime-mode:active;" class="form-control dpin w80"  readonly  />
					<img src="${apachePath}/resources/assets/img/icon_search.png"  class="input_search"  onclick="openCustomerModal();"/>
					</td>
					<th class="tar">담당조직(부서) </th>
					<td><input type="text" name="deptName" id="deptName"  placeholder="부서를 선택하세요" style="ime-mode:active;" class="form-control dpin w90"readonly/>
			               			<img src="${apachePath}/resources/assets/img/icon_search.png"  class="input_search" onclick="openDepartmentModal();"/>
					</td>
					<th class="tar">프로젝트 비용 </th>
					<td><input type="text" id="projectPrice" class="w50 form-control tar dpin"/> 천원 </td>
					<th class="tar">프로젝트 기간 </th>
					<td><input type="text" class="applyDate width-100 form-control dpin" placeholder="날짜선택" id="dispSdate" name="dispSdate" />
									~  <input type="text" class="applyDate width-100 form-control dpin" placeholder="날짜선택" id="dispEdate"/></td>
					</tr>
					<tr>
					<th class="tar">프로젝트 내용 </th><td colspan="7">	<textarea id="description" /></textarea> </td>
					</tr>
					<tr>
					<th>첨부파일  </th>
					<td colspan="7">
						<a type='button' class="bton-s bton_blue"><span class="txt"> <i class="fa fa-file-text-o"></i> 파일추가</span></a>
							<span class="txt_guide_type01 pl20">첨부파일은 5개까지 등록 가능합니다. 용량은 개당 200MB 입니다.</span>
							<form id="file-form" name="file-form" action="${contextPath}/mbr/cmm/file/projectFileInsert" method="post"  enctype="multipart/form-data">
							<input type="hidden" id="programSeq" name="programSeq" value="${getProjectView.reqProjectSeq}">
							<input type="hidden" id="programName" name="programName" value="projectFile">
							<input type='file' id='files' name='files'/>
							<input type='hidden' id='fileNm' name='fileNm'/>

							<div id="files-list" class="mt10">
							<c:forEach items="${file}" var="filelist" varStatus="status" >
							<div class="MultiFile-label">
							<span class="MultiFile-title" title="File selected: C:\fakepath\addi_icon03.png">${filelist.fileName}</span>
							<a class="MultiFile-remove" href="javascript:;" onclick="delFile('${filelist.fileId}')" ></a>
							</div>
							</c:forEach>
							</div>
						</form>
					</td>
					</tr>
					<tr>
					<th>관리자 </th>
					<td colspan="7">

					<input  type="text" class="form-control dpin width-300" name="adminiStrator" id="adminiStrator" value="${getProjectView.projectAdminiStratorInfo}"  placeholder="관리자를 선택하세요" style="ime-mode:active;" readonly="readonly"/>
							<img src="${apachePath}/resources/assets/img/icon_search.png"  class="input_search" onclick="openAdminiStratorModal();"/>
					</td>
					</tr>
					</tbody>
					</table>
					 --%>


<!-- 2023 프로젝트 관련내용 디자인  시작-->
					<div class="col-md-12 pl0 pr0">
            	   <div class="col-md-6 pl0">
            	     <label class="f16 mb10 f500">프로젝트 ID </label>
            	     <input type="text" class="form-control"  id="projectName"   value="${getProjectView.reqProjectName==null?'미지정':getProjectView.reqProjectName}"/>
            	   </div>
            	   <div class="col-md-6 pr0">
            	   <label class="f16 mb10 f500">프로젝트명 </label>
            	   <input type="text"  class="form-control"  id="projectAlias"  value="${getProjectView.projectAlias}"/>
            	   </div>
            	   <div class="clear"></div>
            	   <div class="project_dd">
	            	    <div class="sub3"  style="float:left;">
	            	       <label class="f16 mb10">회원사 </label>
	            	       <input type="text"  class="form-control"   id="deptName" value="${fn:split(getProjectView.deptName2,'/')[1]}"/>
	            	       <img src="${apachePath}/resources/assets/img/btn_search2.png"  onclick="openCustomerModal();" style="position:relative; top:-36px; right:-160px; "/>
	            	    </div>
	            	    <div class="sub3">
	            	       <label class="f16 mb10">담당조직(부서) </label>
	            	       <input type="text"  class="form-control"    id="deptName"  value="${fn:split(getProjectView.deptName2,'/')[2]}"/>
	            	        <img src="${apachePath}/resources/assets/img/btn_search2.png"   onclick="openDepartmentModal();" style="position:relative; top:-36px; right:-160px; "/>
            	  		</div>
            	  		<div class="sub3">
	            	       <label class="f16 mb10">프로젝트 비용 (천원)</label>
	            	       <input type="text"  class="form-control tar"    id="projectPrice" value='<fmt:formatNumber value="${getProjectView.projectPrice}" pattern="#,###"/>' />
            	  		</div>
            	  		<div class="sub3" style="margin-right:0;float:right;">
	            	       <label class="f16 mb10">프로젝트 기간</label>
	            	       <div style="clear:both; float:left; ">
	            	       <input type="text" class="form-control width-130 dpin"  placeholder="날짜선택" id="dispSdate" name="dispSdate" /><span class="dpin mr10 ml-20 lh32"> ~ </span>
	            	       <input type="text" class="form-control width-130 dpin" id="dispEdate"/>

            	  		   </div>
            	  		</div>
            	     </div>
            	     <div class="col-md-12 pl0 pr0 mt10">
            	     <label class="f16 mb10 f500">프로젝트 내용 </label>
            	     <%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>
            	      <input type="text"  class="form-control"   id="projectDescription" value="${fn:replace(getProjectView.projectDescription,newLineChar,br)}"/>
            	     </div>

            	      <div class="col-md-12 pl0 pr0 mt20">
            	        <div class="col-md-8 pl0">
            	           <div class="col-md-11 pl0">
		            	    <label class="f16 mb10 f500">첨부파일 </label>

		            	    <div class="clear"></div>
							<a type='button' class="btn_navy-s"> 파일추가</a> <span class="txt_guide_type01 ml30 m-t-8">첨부파일은 5개까지 등록 가능합니다. 용량은 개당 200MB 입니다.</span>
							<form id="file-form" name="file-form" action="${contextPath}/mbr/cmm/file/projectFileInsert" method="post"  enctype="multipart/form-data">
							<input type="hidden" id="programSeq" name="programSeq" value="${getProjectView.reqProjectSeq}">
							<input type="hidden" id="programName" name="programName" value="projectFile">
							<input type='file' id='files' name='files'/>
							<input type='hidden' id='fileNm' name='fileNm'/>

							<div id="files-list" class="mt10">
							<c:forEach items="${file}" var="filelist" varStatus="status" >
							<div class="MultiFile-label">
							<span class="MultiFile-title" title="File selected: C:\fakepath\addi_icon03.png">${filelist.fileName}</span>
							<a class="MultiFile-remove" href="javascript:;" onclick="delFile('${filelist.fileId}')" ></a>
							</div>
							</c:forEach>
							</div>
						  </form>
						  </div>
            	         </div>
            	         <div class="col-md-4" >
            	            <div class="col-md-11 pl0">
            	            <label class="f16 mb10 f500">관리자</label>
            	            <input type="text"  class="form-control"   name="adminiStrator" id="adminiStrator" value="${getProjectView.projectAdminiStratorInfo}" readonly="readonly" />
            	             </div>
            	             <div class="col-md-1 pl0" style="margin-top:26px;"><a type="button" class="btn_rect" onclick="openAdminiStratorModal();"><span class="rotate-45"> &#9906; </span></a></div>
            	         </div>

            	     </div>

            	   </div>

				<!-- 2023 프로젝트 관련내용 디자인 끝 -->














							<div class="clear"></div>
							<h2 class="titleBuType01 mb10 mt20"> 클라우드 선택  </h2>

								<div class="col-md-12 pl0 pr0">
								   <c:forEach items="${ossCloudList}" var="ossCloudList" varStatus="status" >

				                 	<c:if test="${ossCloudList.cloudType eq 'openstack'}">
				                 	 <div class="cloud_oa">
				                 	  <ul>
				                 		 <h4><input type="checkbox"  class="big_check" name ="cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}"  <c:if test="${ossCloudList.requiredYn eq 'Y'}"> disabled="disabled"  checked </c:if> /> ${ossCloudList.cloudName} </h4>
									 	 <li class="cdesc">${ossCloudList.content}</li>
				                 	  </ul>
								     </div>
				                 	</c:if>

				                 	<c:if test="${ossCloudList.cloudType eq 'vmware'}">
				                 	  <div class="cloud_dmz">
				                 	  <ul>
				                 		 <h4><input type="checkbox"  class="big_check" name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" <c:if test="${ossCloudList.requiredYn eq 'Y'}"> disabled="disabled"  checked </c:if> /> ${ossCloudList.cloudName} </h4>
									 	 <li class="cdesc">${ossCloudList.content}</li>
				                 	  </ul>
								     </div>
				                 	</c:if>

				                 	<c:if test="${ossCloudList.cloudType eq 'openshift'}">
				                 	 <div class="cloud_mobile">
				                 	  <ul>
				                 		 <h4><input type="checkbox"  class="big_check" name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" <c:if test="${ossCloudList.requiredYn eq 'Y'}"> disabled="disabled"  checked </c:if> /> ${ossCloudList.cloudName} </h4>
									 	 <li class="cdesc">${ossCloudList.content}</li>
				                 	  </ul>
								     </div>
				                 	</c:if>

				                 	<c:if test="${ossCloudList.cloudType eq 'nutanix'}">
				                 	 <div class="cloud_mobile">
				                 	  <ul>
				                 		 <h4><input type="checkbox"  class="big_check" name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" <c:if test="${ossCloudList.requiredYn eq 'Y'}"> disabled="disabled"  checked </c:if> /> ${ossCloudList.cloudName} </h4>
									 	 <li class="cdesc">${ossCloudList.content}</li>
				                 	  </ul>
								     </div>
				                 	</c:if>

								  </c:forEach>
								</div>


					<!-- BOX3 담당자정보 -->

					<div class="clear"></div>
			    	<h2 class="titleBuType01 mb10 mt20"> 담당자 정보 <a type="button" class="btn_navy-s flr mb10" onclick="openManagerModal();">담당자 등록</a> </h2>
					<table id="projectManagerList"  class="tableV">
						<colgroup>
							<col width="10%">
							<col width="*">
							<col width="10%">
							<col width="10%">
							<col width="12%">
							<col width="12%">
							<col width="15%">
							<col width="12%">
							<col width="6%">
						</colgroup>
						<thead>
							<tr>
								<th>회원사</th>
								<th>소속조직(부서)</th>
								<th>이름(직급)</th>
								<th>ID</th>
								<th>전화번호(사선)</th>
								<th>핸드폰</th>
								<th>이메일</th>
								<th>구분</th>
								<th>버튼</th>
							</tr>
						</thead>
					</table>

			        <div class="clear"></div>

					<div class=" col-xs-12 tac mt50 mb30">
			            <a onclick="openApproveReviewModal()" type="button" class="btn_navy"> 재신청</a>
			            <a onclick="projectInsert()" type="button" class="btn_dngrey ml10"> 저장</a>
						<a onclick="moveListPage()" type="button" class="btn_lgrey ml10"> 목록</a>
					</div>

				  	<!-- Modal 모음 시작 -->

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
	                       			<a type="button" class="m_btn_navy" id ="popclose" onclick="javascript:projectRejected();">확인</a>

	                       			<a type="button" class="m_btn_white ml10" data-dismiss="modal" id ="popclose">취소</a>
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
			                   	      <a type="button" class="m_btn_navy" data-dismiss="modal" id ="popclose">닫기</a>
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
			                        	<a type="button" class="m_btn_navy" onclick="setId();">적용</a>
										<a type="button" class="m_btn_white ml10" data-dismiss="modal" onclick="initModal();">닫기</a>
		                           	</div>
									<div id="unableId" style="display: block;">
										<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="initModal();">닫기</a>
									</div>

		                       	</div>
		                   	</div>
		               	</div>
		           	</div>
					<!-- #modal-dialog -->


					<!-- 고객사 검색 modal -->
	                <div class="modal fade" id="modal-srch-copy">
						<div class="modal-dialog">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
		                        	<h4 class="modal-title">회원사 지정</h4>
		                       	</div>
		                       	<div class="modal-body">

		                       	    <!-- search begin -->
									<div class="col-md-12 bgee modalpop mb20">
									<div class="tac dpin">
										<div class="col-md-12">
											<input type="text" class="search-text" onkeypress="if(event.keyCode==13)customerSearch();" id="searchKeyword" placeholder="검색어를 입력하세요" >
											</div>
										  	<button type="button" class="btn_search2" onclick="customerSearch();"><span></span></button>
											</div>
									</div>
									 	<!-- search end -->
									<div class="noneList" style="display: none;">
										 <span>검색된 사용자가 없습니다.</span>
									</div>

									<!-- <div class="listArea" id="popListTable"> -->
									<div class="listArea" id ="popListDiv">

		                      		</div>
		                      		<div class="totalcnt" id="totalCnt">총 <span id="listTotal">0</span> 건</div>

			                   </div>
			                   <div class="modal-footer tac">
			                       <a type="button" class="m_btn_navy" data-dismiss="modal" id ="popclose" onclick="initModal();">닫기</a>
		                       </div>
			               	</div>
						</div>
		            </div>
			      </div>


				<!-- #부서 선택 modal-dialog -->
				<div class="modal fade" id="modal-dialog-department">
	            <div class="modal-dialog width-720">
	                <div class="modal-content width-720">
	                    <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                        <h4 class="modal-title">부서 검색</h4>
	                    </div>
	                    <div class="modal-body">
					 	<!-- search begin -->
					 	<div class="col-md-12 bgee modalpop mb20">
							<div class="" style="text-align: center; display:inline-block;">
								<div class="col-md-12">
									<input type="text" class="search-text" onkeypress="if(event.keyCode==13)searchDepartment();" id="searchKeywordDept" placeholder="검색어를 입력하세요" data-original-title="" title="">
								</div>
							  	<button type="button" class="btn_search2" onclick="searchDepartment();"><span></span></button>
							</div>
						</div>
					 	<!-- search end -->
					   <div class="col-md-12">
				   		<input type="hidden" id="h_popDeptCode">
	     				<input type="hidden"  id="h_popDeptName">

						<table  id="table-list" ></table>

					   	<%-- <table class="table table-bordered table-hover table-striped table-td-valign-middle">
							 <colgroup>
							 <col width="40%">
							 <col width="40%">
							 <col width="20%">
							 </colgroup>
							 <thead>
							 <tr class="skyblue">
								 <th class="tac">부서 아이디</th>
								<th class="tac">부서 이름</th>
								<th class="tac">적용</th>
							 </tr>
							 </thead>
							 <tbody id="popDeptListTable">

							 </tbody>
					 	</table> --%>
					   </div>
	               	</div>
					<div class="clear"></div>
					<div class="modal-footer tac">
	             			<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="confirmDepartment();">확인</a>
	             			<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
	                 	</div>
	              </div>
	           </div>
	        </div>



			<!-- 프로젝트 담당자 지정 팝업 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="manager-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content w560">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='projectManagerList();'><span></span></button>
	                           <h4 class="modal-title">담당자 검색</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<!--  기존 박과장 검색 20191218
	                       		 <div class="page_searchBox m-b-15">
									<div class="searchArea">
										<div class="inputArea m-l-5">
											<input type="text" placeholder="검색어를 입력하세요" id="searchManageKeyword" onkeypress="if(event.keyCode==13)gridManagerPopList();" style="width: 362px">
											<a type='button' class="btn_search" onclick="gridManagerPopList();">검색</a>
										</div>
									</div>
								</div>-->

								  <!--//검색 시작-->
		                       	 <div class="col-xs-12 bgee modalpop mb20">
			                       		<div class="selectBoxBr col-xs-3">
											<label class="selectText" for="searchKind">전체</label>
											<select class="search-sel" id="searchKind">
												<option value="searchAll">전체</option>
												<option value="userId">사번</option>
												<option value="userName">이름</option>
												<option value="deptName">부서</option>
											</select>
										</div>
											<div class="col-xs-9">
												<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="searchManageKeyword" onkeypress="if(event.keyCode==13)gridManagerPopList();" >
												<button type="button" class="btn_search2 vm" onclick="gridManagerPopList();"><span></span></button>
											</div>
									</div>
									<!--검색  끝//-->



								<table class="tableV">
									 <colgroup>
									 <col width="25%">
									 <col width="25%">
									 <col width="*">
									 <col width="10%">
									 </colgroup>
									 <thead>
									 <tr class="skyblue">
										<th class="tac">이름</th>
										<th class="tac">사번</th>
										<th class="tac">부서</th>
										<th class="tac">버튼</th>
									 </tr>
									 </thead>
									 <tbody id="popManagerListTable">

									 </tbody>
							 	    </table>

								<div class="noneList" id='popManagerListTable2'>
									 <span>검색된 사용자가 없습니다.</span>
								</div>

	                      		<div class="totalcnt" id="totalCntManager">총 0 건</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="m_btn_navy" data-dismiss="modal" onclick='projectManagerList();'>닫기</a>
	                       	</div>
		               	</div>
					</div>
	           	</div>
				<!-- #modal-dialog -->



					<!-- 결재자 지정팝업 시작 -->
					<!-- #modal-dialog 결재자 지정팝업-->
					<div class="modal fade" id="modal-approve-review-dialog">
	            		<div class="modal-dialog width-720">
	                		<div class="modal-content width-720">
	                    		<div class="modal-header">
	                        		<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                        		<h4 class="modal-title">요청부서 결재지정</h4>
	                    		</div>

	                    		<div class="modal-body">
						 			<!-- search begin -->
						 			<!--
						 			<div class="col-md-12 bgee modalpop mb20">
										<div class="tac dpin">
											<div class="col-md-8">
												<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="searchKeyword" >
											</div>
								  			<button type="button" class="btn_search2" onclick="searchCustomer();"><span></span></button>
										</div>
									</div>
									-->
						 			<!-- search end -->
						   			<div>
							   			<input type="hidden" value="" id="h_popCustomerId">
				     					<input type="hidden" value="" id="h_popCustomerName">

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
								</div>

								<div class="clear"></div>

								<div class="modal-footer tac">
									<!--
									<a type=button class="lbtn" data-dismiss="modal" onclick="noworder();">확인</a>
									-->
									<a type=button class="m_btn_navy" data-dismiss="modal" onclick="projectReInsert();">확인</a>
									<a type=button class="m_btn_white ml10" data-dismiss="modal">취소</a>
								</div>
							</div>
						</div>
					</div>

					<!-- 프로젝트 결재자 재정 - 검토자 검색 -->
					<div class="modal fade" id="user-modal-review-dialog">
						<div class="modal-dialog width-720">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridPopList();'><span></span></button>
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
										<div class="col-xs-9">
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
								 		<tbody id="popListReviewTable">
								 		</tbody>
						 	    	</table>

									<div class="noneList" id='popListReviewTable2'>
										<span>검색된 사용자가 없습니다.</span>
									</div>
		                      		<div class="totalcnt" id="totalReviewCnt">총 0 건</div>
			                   	</div>
			                   	<div class="modal-footer tac">
		                       		<a type="button" class="m_btn_navy" data-dismiss="modal" >닫기</a>
		                       	</div>
			               	</div>
						</div>
		           	</div>

				<!-- 프로젝트 승인자 결재자 지정 팝업 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="user-modal-approve-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content w560">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridPopApproveList();'><span></span></button>
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
									 <col width="25%">
									 <col width="25%">
									 <col width="*">
									 <col width="10%">
									 </colgroup>
									 <thead>
									 <tr class="skyblue">
										<th class="tac">이름</th>
										<th class="tac">사번</th>
										<th class="tac">부서</th>
										<th class="tac">버튼</th>
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
				<!-- 결재자 지정 끝 -->





				<!-- 프로젝트 관리자 지정 팝업 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="administrator-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content w560">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='projectAdminiStratorList();'><span></span></button>
	                           <h4 class="modal-title">관리자 검색</h4>
	                       </div>
	                       <div class="modal-body">

							 	  <!--//검색 시작-->
		                       	 <div class="col-xs-12 bgee modalpop mb20">
			                       		<div class="selectBoxBr col-xs-3">
											<label class="selectText" for="searchKindAdminiStrator">전체</label>
											<select class="search-sel" id="searchKindAdminiStrator">
												<option value="searchAll">전체</option>
												<option value="userId">사번</option>
												<option value="userName">이름</option>
												<option value="deptName">부서</option>

											</select>
										</div>
											<div class="col-xs-9">
												<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="searchAdminiStratorKeyword" onkeypress="if(event.keyCode==13)gridAdminiStratorPopList();" >
												<button type="button" class="btn_search2 vm" onclick="gridAdminiStratorPopList();"><span></span></button>
											</div>
									</div>
									<!--검색  끝//-->

			                       <table class="tableV">
									 <colgroup>
									 <col width="25%">
									 <col width="25%">
									 <col width="*">
									 <col width="10%">
									 </colgroup>
									 <thead>
									 <tr class="skyblue">
										<th class="tac">이름</th>
										<th class="tac">사번</th>
										<th class="tac">부서</th>
										<th class="tac">버튼</th>
									 </tr>
									 </thead>
									 <tbody id="popAdminiStratorListTable">

									 </tbody>
							 	    </table>


								<div class="noneList" id='popAdminiStratorListTable2'>
									 <span>검색된 사용자가 없습니다.</span>
								</div>
	                      		<div class="totalcnt" id="totalCntAdminiStrator">총 0 건</div>
		                   	</div>
		                   	<div class="modal-footer tac">


		                   		 <a type="button" class="m_btn_navy" data-dismiss="modal" onclick="updateAdminiStrator();">확인</a>
	                       		<a type="button" class="m_btn_white ml10" data-dismiss="modal" >닫기</a>

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
	<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.realperson.js"></script>
	<script type='text/javascript' src="${apachePath}/resources/assets/plugins/jqGrid/i18n/grid.locale-kr.js"></script>
	<script type='text/javascript' src="${apachePath}/resources/assets/plugins/jqGrid/jquery.jqgrid.src.js"></script>
		<script type="text/javascript">
			// 결재라인 관련 변수
			var currentApprovalLine = "";
			var approvalList = [];

			function selectAdminiStrator(e, id, nm, dept){
				$("#popAdminiStratorListTable > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
				$("#h_popAdminiStratorId").val(id);
				$("#h_popAdminiStratorName").val(nm);
				$("#h_popAdminiStratorDept").val(dept);
			}

				// 관리자 적용
				function updateAdminiStrator(){
					var adminiStratorId = $("#h_popAdminiStratorId").val();
					var adminiStratorName = $("#h_popAdminiStratorName").val();
					var adminiStratorDept = $("#h_popAdminiStratorDept").val();

					$("#adminiStrator").val(adminiStratorId + " / " +  adminiStratorName + " / " +adminiStratorDept );
				}


				// 관리자 팝업
				function openAdminiStratorModal() {
					if('${userId}' == 'admin' || '${userId}' == '${getProjectView.projectAdminiStratorId}' ) {
						gridAdminiStratorPopList();
						$("#administrator-modal-dialog").modal();
					} else {
						alertBox("프로젝트의 관리자 혹은 포털 관리자만 변경할 수 있습니다.");
					}
				}

				// 관리자 등록 팝업 리스트
				function gridAdminiStratorPopList(){

					$.ajax({
						url : "${contextPath}/mbr/operation/approveUser/addProjectManageList",
						dataType : "JSON",
						data : {
							"searchKind": $("#searchKindAdminiStrator option:selected").val()
							, "keyword"	: $("#searchAdminiStratorKeyword").val()
							  , "programSeq":$("#reqProjectSeq").val()


						},
						success : function(req) {
							if(req.data.length == 0){
								$("#popAdminiStratorListTable").hide();
								$("#popAdminiStratorListTable2").show();
							}else{
								$("#popAdminiStratorListTable").empty();

								$.each(req.data, function(key,val){
									$("#popAdminiStratorListTable").append(
											'<tr>'
											+'<td>'+val.userName+'</td>'
											+'<td>'+val.userId+'</td>'
											+'<td>'+val.deptName+'</td>'
											+'<td class="tac"><input type="button"  value="&#xf00c" class="popCheckbtn"  onclick="selectAdminiStrator(this, \''+val.userId+'\', \''+val.userName+'\', \''+val.deptName+'\');"></td>'
										+'</tr>');

								});
								$("#popAdminiStratorListTable").show();
								$("#popAdminiStratorListTable2").hide();
							}
							totalCnt = req.data.length;
							$("#totalCntAdminiStrator").text("총 "+totalCnt+" 건");
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




			function openApproveReviewModal() {
				$("#modal-approve-review-dialog").modal();
			}

				function openApproveModal(){

					$("#user-modal-approve-dialog").modal();
					 gridPopApproveList();
				}

				function openReviewModal(e){
					currentApprovalLine = e;
					var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
					if( approvalList[tmpCurrentApprovalStep-1] != undefined) {
						confirmBox("재신청할경우 현재 상위결재자값이 초기화 됩니다.", clearUpperApproval );

					} else {
						$("#user-modal-review-dialog").modal();
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
								$("#popListReviewTable").hide();
								$("#popListReviewTable2").show();
							}else{
								$("#popListReviewTable").empty();

								$.each(req.data, function(key,val){

								$("#popListReviewTable").append(
									'<tr>'
									    +'<td class="tac">'+val.upDeptName+'/'+val.deptName+'</td>'
										+'<td class="tac">'+val.userId+'</td>'
										+'<td class="tac">'+val.userLevel+'</span>'
										+'<td class="tac">'+val.userName+'</span>'
										+'<td class="tac">'+val.userConditionText+'</td>'
										+'<td class="tac"><input type="button"  value="&#xf00c"  class="popCheckbtn"  onclick="updateReview(this, \''+val.userId+'\', \''+val.userName+'\', \''+val.deptName+'\',  \''+val.userLevel+'\',  \''+val.userLevelCode+'\');" initModal();></td>'
									+'</tr>');
								});

								$("#popListReviewTable").show();
								$("#popListReviewTable2").hide();
							}
							totalCnt = req.data.length;
							$("#totalReviewCnt").text("총 "+totalCnt+" 건");
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
											+'<td class="tac">'+val.userName+'</td>'
											+'<td class="tac">'+val.userId+'</td>'
											+'<td class="tac">'+val.deptName+'</td>'
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


				 // 검토자지정
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


				// 결재자 지정 끝

				function projectInsert(){




					 var items = [];
					 $('input:checkbox[name=cloudIds]:checked').each(function () {
					     items.push($(this).val());
					 });

					 $("#h_cloudIds").val(items);

					if(items==""){
						alertBox("클라우드를 선택해주세요");
						return false;
					}






					confirmBox("저장 하시겠습니까?",projectInsert)
				}
				//프로젝트명, 프로젝트 비용, 프로젝트 기간 저장
				function projectInsert(){



					$.ajax({
						url : "${wasPath}/mbr/req/project/projectModify",
						dataType : "JSON",
						type : "POST",
						data : {
							  "reqProjectSeq" : $("#reqProjectSeq").val()
							, "ProjectAlias" : $("#projectAlias").val()
							, "projectPrice" : $("#projectPrice").val().replace(/\,/g, "")
							, "description" : $("#description").val()
							, "projectStartDatetime":$("#dispSdate").val().replace(/-/gi, "")
							, "projectEndDatetime":$("#dispEdate").val().replace(/-/gi, "")
							, "projectCustomerId" : $("#h_customerId").val()
							, "projectDeptCode" : $("#h_deptCode").val()
							, "projectAdminiStratorId" : $("#h_popAdminiStratorId").val()
							, "cloudIds":$("#h_cloudIds").val()

						},
						success : function(data) {
							alertBox("저장하였습니다.", actFileUpload);

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

				function projectReInsert(){
					confirmBox("저장 하시겠습니까?",projectReInsert)
				}
				//프로젝트명, 프로젝트 비용, 프로젝트 기간 저장
				function projectReInsert(){
					if( approvalList[0] == undefined || approvalList[0] == null) {
						var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
						approvalList[0] = tmp;
					}

					$.ajax({
						url : "${wasPath}/mbr/req/project/projectReInsert",
						dataType : "JSON",
						type : "POST",
						data : {
							  "reqProjectSeq" : $("#reqProjectSeq").val()
							, "ProjectAlias" : $("#projectAlias").val()
							, "projectPrice" : $("#projectPrice").val().replace(/\,/g, "")
							, "description" : $("#description").val()
							, "projectStartDatetime":$("#dispSdate").val().replace(/-/gi, "")
							, "projectEndDatetime":$("#dispEdate").val().replace(/-/gi, "")
							, "projectCustomerId" : $("#h_customerId").val()
							, "projectDeptCode" : $("#h_deptCode").val()
							, "userIdReview" : $("#hiddenUserIdReview").val()
							, "userIdApprove" : $("#hiddenUserIdApprove").val()
							, "projectAdminiStratorId" : $("#h_popAdminiStratorId").val()

							, "approvalStepList" : approvalList
						},
						success : function(data) {
							alertBox("저장하였습니다.", actFileUpload);

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


				//달력
				function calendar(){

					var dayName = ['일','월','화','수','목','금','토'];
					var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

					$("#dispSdate").datepicker({
						showOn:"both",
						buttonImage:"/resources/assets/img/calen2.png",
						buttonImageOnly:true,
						buttonText : '',
						dateFormat : "yy-mm-dd",
						dayNamesMin:dayName,
						monthNamesShort:monthName,
						changeMonth:true,
						changeYear:true,
						minDate:0
					});

					$("#dispEdate").datepicker({
						showOn:"both",
						buttonImage:"/resources/assets/img/calen2.png",
						buttonImageOnly:true,
						buttonText : '',
						dateFormat:"yy-mm-dd",
						dayNamesMin:dayName,
						monthNamesShort:monthName,
						changeMonth:true,
						changeYear:true,
						minDate:0
					});

					$("img.ui-datepicker-trigger").attr("style", "position:relative; right:40px; top:-2px;");
				}

			//상세정보 가져오기
			function projectDetail() {
				$.ajax({
					url : "${contextPath}/mbr/req/project/projectDetail",
					dataType : "JSON",
					data : {
						"reqProjectSeq" : $("#reqProjectSeq").val()
					},
					success : function(data) {
						var result = data;
						 setData(result);
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				})

			}


			// 프로젝트 상세정보 세팅
			function setData(result){
				$("#description").val(result.description);
				$("#deptName").val(result.deptName);
				$("#customerName").val(result.customerName);
				$("#projectAlias").val(result.projectAlias);
				$("#projectPrice").val(String(result.projectPrice).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,"));
				$("#description").val(result.description);
				var sDate = result.projectStartDatetime;
				var eDate = result.projectEndDatetime;
				if (sDate.length == 8) {
					sDate = sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2);
				}

				if(eDate !=null){
					if (eDate.length == 8) {
						eDate = eDate.substr(0, 4) + "-" + eDate.substr(4, 2) + "-" + eDate.substr(6, 2);
					}
				}
				$("#dispSdate").val(sDate);
				$("#dispEdate").val(eDate);
			}


			// 체크박스 값 세팅
// 			function setNetworkVal(){
// 			$("input:checkbox[name='network']").each(function(){
// 				if($(this).val()=="Y"){
// 					$(this).attr("checked",true);
// 				}
// 			});
// 				<c:forEach items="${getProjectNetSlist}" var="getProjectNetSlist" varStatus="status" begin="0" step="1">
// 					<c:if test="${getProjectNetSlist.selectFlag eq 'Y'}">
// 						$("#"+ "${getProjectNetSlist.netDfltKind}").attr("checked", true);
// 					</c:if>
// 				</c:forEach>
// 			}

			function moveListPage(){
				location.href="${wasPath}/mbr/req/project/projectList.do";
			}

			function actFileUpload(){

				$('#file-form').ajaxForm({
					cache:false
					, data : {
						programName: $("#programName").val()
						, programSeq : $("#reqProjectSeq").val()
					}
					, dataType:"json"
			       	//보내기전 validation check가 필요할경우
			       	, beforeSubmit: function (data, frm, opt) {
			       		var chk = true;

			       		$.each(data, function(i, val){
			       			if(val.value.size > 209715200){
			       				alertBox3("첨부파일 용량은 200MB를 초과할수 없습니다.");
			       				chk = false;
			       			}
			       		});
			       },
			       //submit이후의 처리
			       success: function(data, statusText){

			       },
			       //ajax error
			       error: function(e){
			           //alert("파일 업로드 에러발생!!");
			       }
				});
				$('#file-form').submit();
			}

			function delFile(fileId){
				$.ajax({
					url : "${contextPath}/mng/cmm/file/delete",
					dataType : "JSON",
					data : {
						"fileId" : fileId
						, "programName": $("#programName").val()
						, "programSeq" : $("#downloadNo").val()
					},
					success : function(data) {
						updateFilesCnt("1");
					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				})
			}

			//승인 버튼 누를시 체크 박스 확인
			function projectApprving(stepLevel,requestSeq,rightStepId){
				var apprvDescription = $("#apprvDescription").val();
				var jsonData = {
						"requestSeq" : $("#allOrderNo").val()
						,"stepLevel" :stepLevel
						,"rightStepId":rightStepId
						,"apprvDescription":apprvDescription
						,"orderUserId" : $("#regUserId").val()
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
								alertBox("승인 처리가 완료 되었습니다.<br>처리 내용이 신청 담당자에게<br>메일, SMS, NH With를 통해<br>전달되었습니다.", moveViewPage);
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
					alertBox("자원신청 반려시 반려사유를<br>입력해 주시기 바랍니다.");
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
						"url":"${contextPath}/mbr/operation/approveUser/projectManagerWriteList"
						,"type" : "GET"
						,"dateSrc" : ""
						,"data":function (d) {
							d.searchKind = $("#searchKind option:selected").val();
							d.keyword = $("#keyword").val();
							d.programSeq = $("#allOrderNo").val();
						}
					}
					,"columns":[
			        	  {"data":"customerName", "class":"tac"}
			        	,  {"data":"deptName", "class":"tac"}
			        	, {"data":"userNameLevel", "class":"tac"}
			        	, {"data":"userId", "class":"tac"}
			        	, {"data":"userPhone", "class":"tac"}
			        	, {"data":"userTel", "class":"tac"}
			        	, {"data":"userMail", "class":"tal"}
			        	, {"data":"projectManagerType", "class":"tac"}
			        	, {"data":"", "class":"tac"}
	   				]

					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
							, {"targets":[7], "render":function(data,type,full){

							    i++;
								if(full.projectManagerType == 02){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="02" selected="selected">실무부서</option><option value="03">시스템관리부서</option><option value="04">위탁운영부서</option></select>';}
								else if(full.projectManagerType == 03){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="02">실무부서</option><option value="03" selected="selected">시스템관리부서</option><option value="04">위탁운영부서</option></select>';}
								else if(full.projectManagerType == 04){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="02">실무부서</option><option value="03">시스템관리부서</option><option value="04" selected="selected">위탁운영부서</option></select>';}
								else{return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="00"></option><option value="02">실무부서</option><option value="03">시스템관리부서</option><option value="04">위탁운영부서</option></select>';}

								}

							}

							, {"targets":[8], "render":function(data,type,full){
								return '<a type="button" class="bton-s bton_orange" onclick="projectManagerUserDelete(\''+full.userId+'\');"> <i class="fa fa-trash"></i> 삭제</a>';
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

			//프로젝트 관리자 타입 변경시 타입 업데이트

			   function projectManagerType(userId,seq){

				   var text = "projectManagerTypeId"+seq;

				   if(seq == 1){var projectManagerType = $("#projectManagerTypeId1 option:selected").val();}
				   else if(seq == 2){var projectManagerType = $("#projectManagerTypeId2 option:selected").val();}
				   else{var projectManagerType = $("#projectManagerTypeId3 option:selected").val();}


				   $.ajax({
						url : "${wasPath}/mbr/req/project/projectManagerTypeUdate",
						dataType : "JSON",
			 			type : "GET",
						data : {
							"userId" : userId
							, "reqProjectSeq" : $("#reqProjectSeq").val()
							, "projectManagerType" : projectManagerType
						},
						success : function(data) {
							var result = data;


							if(result == "1"){
								projectManagerList();
							}else if(result == "2"){
								alertBox("실무부서는 필수 항목 입니다.");
								projectManagerList();
							}else if(result == "0"){
								//alert(0);
							}else{
								alertBox("접속이 만료되었습니다.", logout);
							}


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




			// 고객사 검색
			function openCustomerModal(){
				$("#modal-srch-copy").modal();
				customerSearch();
			}

			// 고객사 목록 조회
			function customerSearch(){

				$.ajax({
					url : "${contextPath}/mng/cmm/user/customerSelect",
					dataType : "JSON",
					type : "POST",
					data : {
						"keyword" : $("#searchKeyword").val()
					},
					success : function(data) {
						var popList = data.getCustomerList;
						var listTot = data.listTot;

						if(popList != ""){
							$("#popListDiv > div").remove();
							$.each(popList,function(key,val){
								var Html="";

								Html += "<div class='listBg'>";
								Html += "	<span class='name2'>"+val["customerName"]+"</span>";
								Html += "	<a class='applybtn' data-dismiss='modal' onclick='updateCustomer2(\""+val["customerId"]+"\", \""+val["customerName"]+"\"); initModal();'>적용</a>";
								Html += "</div>";

								$("#popListDiv").append(Html);
							});
							$("#listTotal").text(listTot);
						}else{
							$("#popListDiv > div").remove();
							$("#listTotal").text(0);
						}

					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}

			 // 고객사 검색 값 적용
			function updateCustomer2(customerId, customerName){

				 //alert(customerName);

				$("#h_customerId").val(customerId);
				$("#customerName").val(customerName);
			}

			// 부서 검색
			function openDepartmentModal(){
				$("#modal-dialog-department").modal();
				initialDepartment();
			}
			function initialDepartment() {
				$("#table-list").jqGrid('clearGridData', true);
				$("#table-list").jqGrid({
					url: '${contextPath}/mng/cmm/department/TreeAll',
					mtype: "POST",
					datatype:"json",
					postData: {
				    },
					colNames:['부서코드','상위부서코드', '부서명','level','isLeaf', 'isExpanded'],
					colModel:[
						{name:'deptCode', 	index:'deptCode', 	hidden:false, 	width:140, align:"center", key: true}
						,{name:'upCode', 	index:'upCode', 	hidden:true, 	width:100, align:"left"}
			 	   		,{name:'deptName', 	index:'deptName', 	hidden:false, 	width:520, align:"left"}
			 	   		,{name:'treeLevel', index:'treeLevel', 	hidden:true, 	width:220, align:"left"}
			 	   		,{name:'isLeaf', 	index:'isLeaf', 	hidden:true, 	width:220, align:"left"}
			 	   		,{name:'isExpanded',index:'isExpanded',	hidden:true, 	width:220, align:"left"}
					],

	//	 			rowNum:10,
	//	 			rowList:[5,10,15],
					rownumbers:false,
					loadonce:false,
					scrollrows:true,
					loadtext : "조회중 잠시만 기다려주세요.",
					//shrinkToFit:false,
// 					height: '100%', // 300, //$(".tbl_type01").height()-40,
// 					width : '100%',
					gridview : true,
					treeGrid : true,
					treeGridModel: 'adjacency',
					ExpandColumn: 'deptName',
					ExpandColClick: true,
					tree_root_level: 1,
		 			treeIcons: {
		 				plus: 'ui-icon-triangle-1-e',
		 				minus:'ui-icon-triangle-1-s',
		 				leaf: 'ui-icon-radio-off'},
	//	  			leaf: 'ui-icon-document-b'},
					jsonReader : {
						root: 'data'			//controller에서 가져오는 json명
						, id: 'deptCode'
						, repeatitems: true
					},
					treeReader: {
						level_field: 'treeLevel'
						, parent_id_field: 'upCode'
						, leaf_field: 'isLeaf'
						, expanded_field: 'isExpanded'
					},
					gridComplete: function() {
					},
					loadError : function(xhr,status, error) {
						alert(error);
					},
					onSelectRow:function(rowid, status, e) {
						var list = $('#table-list').getRowData(rowid);
		 				var code = list.deptCode;
						var name = list.deptName.split('>');
						name = name[name.length -1];
						$("#h_popDeptCode").val(code);
						$("#h_popDeptName").val(name);
					},
					onCellSelect:function(rowid, iCol) {
// 						var list = $('#table-list').getRowData(rowid);
// 						var treeLevel = list.treeLevel;
// 						if(treeLevel != 1){
// 							var code = list.deptCode;
// 							var name = list.deptName.split('>');
// 							name = name[name.length -1];
// 							$("#h_popDeptCode").val(code);
// 							$("#h_popDeptName").val(name);
// 							confirmBox(name+"를 적용하시겠습니까?", updateDepartment);
// 						}else{
// 							var code = list.deptCode;
// 							var name = list.deptName.split('>');
// 							name = name[name.length -1];
// 						}
					},
					ondblClickRow:function(rowid, iRow, iCol) {
						var list = $('#table-list').getRowData(rowid);
						var code = list.deptCode;
						var name = list.deptName.split('>');
						name = name[name.length -1];
						$("#h_popDeptCode").val(code);
						$("#h_popDeptName").val(name);
						confirmDepartment();
					}
				}).trigger('reloadGrid');
			}
			//부서 검색
			function searchDepartment() {
				$("#table-list").jqGrid('setGridParam', {
					url: '${contextPath}/mng/cmm/department/TreeAll'
					, mtype: "POST"
					, datatype: "json"
					, postData: {
						"searchKind": "dept_name",
						"keyword":$("#searchKeywordDept").val()
					}
				}).trigger('reloadGrid');
			}
			function confirmDepartment() {
				var deptName = $("#h_popDeptName").val();
				if(deptName == null || deptName == "") {
					alertBox("선택된 부서가 없습니다.");
					return ;
				}
				confirmBox(deptName+"를 적용하시겠습니까?", updateDepartment);
			}
			// 부서 검색 값 적용
			function updateDepartment() {
				var deptCode = $("#h_popDeptCode").val();
				var deptName = $("#h_popDeptName").val();
				$("#h_deptCode").val(deptCode);
				$("#deptName").val(deptName);

				$("#searchKeywordDept").val("");
				$("#modal-dialog-department").modal("hide");
			}

			function projectRejectHits(){

				var text = $("#rejectedApprvDescription").val()
				$("#rejectedApprvDescriptionHits").val(text)

				$("#modal-dialog-reject-hits").modal();

			}

			 // 담당자 팝업
			function openManagerModal(){
				gridManagerPopList();
				$("#manager-modal-dialog").modal();
			}

			// 관리자 등록 팝업 리스트
			function gridManagerPopList(){

				$.ajax({
					url : "${contextPath}/mbr/operation/approveUser/addProjectManageList",
					dataType : "JSON",
					data : {
						"searchKind": $("#searchKind option:selected").val()
						, "keyword"	: $("#searchManageKeyword").val()
						  , "programSeq":$("#programSeq").val()

					},
					success : function(req) {
						if(req.data.length == 0){
							$("#popManagerListTable").hide();
							$("#popManagerListTable2").show();
						}else{
							$("#popManagerListTable").empty();

							$.each(req.data, function(key,val){
								$("#popManagerListTable").append(
										'<tr>'
										+'<td>'+val.userName+'</td>'
										+'<td>'+val.userId+'</td>'
										+'<td>'+val.deptName+'</td>'
										+'<td class="tac"><input type="button"  value="&#xf00c" class="popCheckbtn"  onclick="insertManager(this, \''+val.userId+'\');"></td>'
									+'</tr>');
							});
							$("#popManagerListTable").show();
							$("#popManagerListTable2").hide();
						}
						totalCnt = req.data.length;
						$("#totalCntManager").text("총 "+totalCnt+" 건");
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



			//프로젝트 사용자포탈 관리자 insert
			function insertManager(e, userId){
				$.ajax({
					url : "${contextPath}/mbr/operation/approveUser/insertManager",
					dataType : "JSON",
					data : {
						"userId": userId
					  , "programSeq":$("#reqProjectSeq").val()

					},
					success : function(data) {
						if(data == "4"){
							alertBox("프로젝트 관리자는 최대 5명등록가능합니다.", projectManagerList);
						}

						$(e).parent().remove();
						totalCnt = totalCnt-1;
						$("#totalCnt").text("총 "+totalCnt+" 건");
						if(totalCnt == 0){
							$("#popListTable").hide();
							$("#popListTable2").show();
						}

						gridManagerPopList();

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


			//프로젝트 관리자
			function projectManagerUserDelete(userId){

				$.ajax({
					url : "${wasPath}/mbr/req/project/projectManagerUserDelete",
					dataType : "JSON",
		 			type : "GET",
					data : {
						"userId" : userId
						, "reqProjectSeq" : $("#reqProjectSeq").val()

					},
					success : function(data) {
						var result = data;

						if(result==2){
							alertBox("실무부서는 삭제할수 없습니다.");
						}else if(result==1){
							alertBox("삭제되었습니다.", projectManagerList);
						}else if	(result==0){
							alertBox("접속이 만료되었습니다.", logout);
						}

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
// 			    setNetworkVal();
			    projectManagerList();
			    $("#downloadType").siblings(".selectText").text($("#downloadType").children('option:selected').text());
				if($("#downloadNo").val() != 0 ){
					projectDetail();
				}
				 initApprovalLine();

				$('#files').MultiFile({
					list: "#files-list"
					, max : 5
					//, accept : 'gif|jpg|png'
					, maxFile : 204800
					, maxSize :  204800
					, STRING : {
						//remove : "<input type='button' value='삭제' class='btn btn-danger' style='font:8px;padding-bottom:2px;'>"
						duplicate : "$file 은 이미 선택된 파일입니다."
						, denied : "$ext 는(은) 업로드 할수 없는 파일 확장자 입니다."
						, toomuch : "업로드 할 수 있는 최대크기를 초과하였습니다.($size)"
						, toomany : "업로드 할 수 있는 최대 갯수는 $max개 입니다."
						, toobig : "$file 은 크기가 매우 큽니다.(max $size)"
					},
				});

				calendar();
			  	//메뉴활성화
				$("#reqStatus").addClass("active");
		 		$("#projectRequestList").addClass("active");

			});


		</script>
	</body>
</html>