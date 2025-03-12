<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
	<sec:authentication var="authorities" property="principal.authorities"/>
</sec:authorize>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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


			<input type="hidden" id="hiddenUserIdReview" 	value="" />
			<input type="hidden" id="hiddenUserNameReview" 	value="" />
			<input type="hidden" id="hiddenDeptNameReview" 	value="" />
			<input type="hidden" id="hiddenUserIdApprove" 	value="" />
			<input type="hidden" id="hiddenUserNameApprove" value="" />
			<input type="hidden" id="hiddenDeptNameApprove" value="" />
			<input type="hidden" id="h_projectStatusFlag" 	value="" />
			<input type="hidden" id="reqProjectSeq" 		value="${programSeq}" class="opa0">

			<input type="hidden" id="h_popDeptCode" 		value="${userDeptCode}" >
	     	<input type="hidden" id="h_popDeptName"			value="${userDeptName}" >

	     	<input type="hidden" id="h_popCustomerId" 		value="${userCustomerId}">
	     	<input type="hidden" id="h_popCustomerName" 	value="${userCustomerName}">

	     	<input type="hidden" id="hidden_login_user_id" 	value="${userId}" />
	     	<input type="hidden" id="hidden_login_user_name"value="${userName}" />
	     	<input type="hidden" id="h_userLevelCode" 		value="${userLevelCode}">

			<input type="hidden" id="h_popAdminiStratorId" 	value="${userId}" />
			<input type="hidden" id="h_popAdminiStratorName"value="" />
			<input type="hidden" id="h_popAdminiStratorDept"value="" />

			<input type="hidden" id="h_manager_count" 		value="N" />
			<input type="hidden" id="h_cloudIds" value="" />


			<input type="hidden" id="apprvPass"				value="${apprvPass}" />
			<input type="hidden" id="selectApprv"			value="" />
			<!-- begin #content (페이지 바디 컨텐츠 시작입니다)-->
			<div id="content" class="content">

				<p class="page_title">프로젝트 신청
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/req/project/projectList.do"> 프로젝트 </a> <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/req/project/projectList.do">프로젝트 현황(신청)</a>  <span class="arrow_ab"> &#8227; </span> <b> 프로젝트 신청 </b>
			    </span>
				</p>

				<!-- begin page-body -->
				<div class="row p20 bgwh br10">

					<div class="white_table">
						<table>
							<colgroup>
								<col width="140px"/>
								<col width="*"/>
								<col width="140px"/>
								<col width="*"/>
							</colgroup>
							<tbody>

								<tr>
									<th scope="row"><strong>프로젝트명</strong></th>
									<td colspan="3"><input maxlength="30" class="form-control" type="text" name="projectAlias" id="projectAlias" placeholder="프로젝트명을 입력하세요"/></td>
								</tr>
								<tr>
									<th scope="row"><strong>내용</strong></th>
									<td colspan="3"><textarea class="form-control" rows="5" placeholder="프로젝트에 대한 간략한 정보을 입력하세요" name="projectDescription" id="projectDescription"></textarea></td>
								</tr>
								<tr style="display:none">
									<th scope="row"><strong>프로젝트비용(천원)</strong></th>
									<td class="tal">
	 									<input type="text" name="price" id="price" class="form-control tar width-150"  value="0"  onkeyup="inputNumberWithComma(this);"
	 									oninput="this.value = this.value.replace(/[^0-9.]/g,'').replace(/(\..*)\./g, '$1');"/>

									</td>
								</tr>
								<tr>
									<th scope="row"><strong>프로젝트기간</strong></th>
									<td>
										<input type="text" class="form-control width-140 dpin" placeholder="날짜선택" id="dispSdate" name="dispSdate" />
								  		<span style="margin-left:-20px; margin-right:10px;"> ~ </span>
										<input type="text" class="form-control width-140 dpin" placeholder="날짜선택" id="dispEdate" />
									</td>
								</tr>
								<tr>
							  		<th><strong>회원사</strong></th>
							    	<td>
							    		<div class="search-box">
								   			<input type="text" name="customerName" id="customerName" value="" class="form-control " placeholder="회원사를 선택하세요" style="ime-mode:active;" readonly="readonly"/>
					              			<img src="${apachePath}/resources/assets/img/btn_search2.png" onclick="openCustomerModal();" class="kepco-ser-icon"/>
				              			</div>
					           		</td>
								</tr>
								<tr>
							  		<th><strong>부서</strong></th>
							    	<td>
							    		<div class="search-box">
								   			<input type="text" name="deptName" id="deptName" value="" class="form-control" placeholder="부서를 선택하세요" style="ime-mode:active;" readonly="readonly"/>
					               			<img src="${apachePath}/resources/assets/img/btn_search2.png"  onclick="openDepartmentModal();" class="kepco-ser-icon"/>
					               		</div>
					           		</td>
								</tr>
								<tr>
							  		<th><strong>관리자</strong></th>
							    	<td>
							    		<div class="search-box">
								   			<input type="text" name="adminiStrator" id="adminiStrator" value="" class="form-control" placeholder="관리자를 선택하세요" style="ime-mode:active;" readonly="readonly"/>
					               			<img src="${apachePath}/resources/assets/img/btn_search2.png"  onclick="openAdminiStratorModal();" class="kepco-ser-icon"/>
					               		</div>
					           		</td>
								</tr>
						     	<tr>
									<th scope="row" class="vm"><strong>첨부파일</strong></th>
									<td colspan="3">
										<a type='button' class="btn_navy-s">파일추가</a>
										<span class="txt_guide_type01 ml30 m-t-8">사업계획서를 첨부해 주세요. 최대용량은 50MB까지 가능합니다.</span>
										<form id="file-form" name="file-form" action="${contextPath}/mbr/cmm/file/projectFileInsert" method="post"  enctype="multipart/form-data">
											<input type="text" id="programSeq" name="programSeq" value="${programSeq}" class="opa0" />
											<input type="hidden" id="programName" name="programName" value="projectFile" />
											<input type='file' id='files' name='files'/>
											<!--
 											<input style="display:block;width:106px;height:36px;position:absolute;top:85px;left:160px;opacity:0;filter: alpha(opacity=0);cursor:pointer;" type='file' id='files' name='files'/>
 											-->
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
							 		<th class="vt"><strong>담당자</strong></th>
							 		<td colspan="3">
										<table id="projectManagerList"  class="tableV">
											<colgroup>
												<col width="140px">
												<col width="140px">
												<col width="100px">
												<col width="100px">
												<col width="120px">
												<col width="240px">
												<col width="*">
												<col width="140px">
										    </colgroup>
											<thead>
												<tr>
													<th>회원사</th>
													<th>소속조직(부서)</th>
													<th>이름(직급)</th>
													<th>ID</th>
													<th>전화번호(사선)</th>
													<th>이메일</th>
													<th>구분</th>
													<th></th>
												</tr>
											</thead>
										</table>
										<a type="button" class="btn_navy-s flr" onclick="openManagerModal();"> 담당자 등록</a>
							  		</td>
								</tr>

								<tr>
								<th><strong>클라우드 선택</strong></th>
								<td colspan="3">

								<div class="col-md-12 pl0 pr0">
								   <c:forEach items="${ossCloudList}" var="ossCloudList" varStatus="status" >

				                 	<c:if test="${ossCloudList.cloudType eq 'openstack'}">
				                 	 <div class="cloud_choice_disabled">
				                 		 <h4><input type="checkbox"  class="big_check" name ="cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}"  <c:if test="${ossCloudList.requiredYn eq 'Y'}"> disabled="disabled"  checked </c:if> /> ${ossCloudList.cloudName} </h4>
									 	 <li class="cdesc">${ossCloudList.content}</li>
								     </div>
				                 	</c:if>

<%-- 				                 	<c:if test="${ossCloudList.cloudType eq 'vmware'}">
				                 	  <div class="cloud_choice_disabled">

				                 		 <h4><input type="checkbox"  class="big_check" name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" <c:if test="${ossCloudList.requiredYn eq 'Y'}"> disabled="disabled"  checked </c:if> /> ${ossCloudList.cloudName} </h4>
									 	 <li class="cdesc">${ossCloudList.content}</li>

								     </div>
				                 	</c:if>
			 --%>
				                 	<c:if test="${ossCloudList.cloudType eq 'openshift'}">
				                 	 <div class="cloud_choice_disabled">
<!-- 				                 	 <div class="cloud_choice"> -->
				                 		 <h4><input type="checkbox"  class="big_check" name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" <c:if test="${ossCloudList.requiredYn eq 'Y'}"> disabled="disabled"  checked </c:if> /> ${ossCloudList.cloudName} </h4>
									 	 <li class="cdesc">${ossCloudList.content}</li>
								     </div>
				                 	</c:if>

				                 	<c:if test="${ossCloudList.cloudType eq 'nutanix'}">
				                 	 <div class="cloud_choice">
				                 		 <h4><input type="checkbox"  class="big_check" name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" <c:if test="${ossCloudList.requiredYn eq 'Y'}"> disabled="disabled"  checked </c:if> /> ${ossCloudList.cloudName} </h4>
									 	 <li class="cdesc">${ossCloudList.content}</li>
								     </div>
				                 	</c:if>

								  </c:forEach>
								</div>

								</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="btn_area">
						<a href="#" class="btn_navy" id="jquerybuttonok" name="jquerybuttonok" onclick="projectManagerCheck('02');">신청하기</a>
						<%-- <c:if test = "${fn:contains(authorities, 'ROLE_CLOUD_OPERATION') and fn:contains(authorities, 'ROLE_CLOUD_ADMIN')}">
						</c:if> --%>
						<a href="#" class="btn_line55 ml10" onclick="projectManagerCheck('01');">임시저장</a>
						<a type="button" class="btn_lgrey ml10" onclick="moveListPage();"> 취소</a>
					</div>

					<!-- #modal-dialog 모음 시작 -->

					<!-- 청구요금 상세 -->
					<!-- #modal-dialog -->
					<div class="modal fade" id="insert-modal-dialog">
						<div class="modal-dialog">
		                   <div class="modal-content">
		                       <div class="modal-header">
		                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                           <h4 class="modal-title">신청확인</h4>
		                       </div>
		                       <div class="modal-body">
		                       			<div class="tableE">
		                       				<table>
		                       					<colgroup>
		                       						<col width="140px"/>
		                       						<col width="*"/>
		                       					</colgroup>
		                       					<tbody>
			                       					<tr>
			                       				    	<th class="tal">프로젝트명</th>
			                       				    	<td id="pop_projectAlias"></td>
			                       				    </tr>
			                       				    <tr>
			                       				    	<th class="tal">회원사 </th>
			                       				    	<td id="pop_customerName"></td>
			                       				    </tr>
			                       				    <tr>
			                       				    	<th class="tal">담당조직</th>
			                       				    	<td id="pop_deptName"></td>
			                       				    </tr>
			                       				    <tr>
			                       				    	<th class="tal">내용</th>
			                       				    	<td class="height-50"><textarea id="pop_description" class="form-control2" rows="5" readonly></textarea></td>
			                       				    </tr>
	<!-- 		                       				 <tr>
				                       				    <th>프로젝트 비용</th>
				                       				    <td><span id="pop_price"></span><span>천원</span></td>
			                       				    </tr> -->
			                       				    <tr>
				                       				    <th class="tal">프로젝트 기간</th>
				                       				    <td><span id="pop_dispSdate"></span> ~ <span id="pop_dispEdate"></span></td>
			                       				    </tr>
			                       				</tbody>
		                       				</table>
		                       			</div>
								</div>
		                       	<div class="modal-footer tac">
		                   			<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="projectManagerApproveCheck();">확인</a>
	 	                   			<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
		                       	</div>
		                   	</div>
		               	</div>
		           	</div>
					<!-- #modal-dialog -->

					<!-- #modal-dialog -->
					<div class="modal fade" id="modal-dialog">
		               <div class="modal-dialog">
		                   <div class="modal-content">
		                       <div class="modal-header">
		                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                           <h4 class="modal-title fw">중복체크</h4>
		                       </div>
		                       <div class="modal-body">
		                           <h5>프로젝트 영문명을 입력해주세요</h5>
		                           <p class="m-b-20">
		                              <input type="text" id="_projectName" style="ime-mode:disabled; text-transform:lowercase;"/>
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

					<!-- #modal-dialog -->
					<div class="modal fade" id="message-modal-dialog">
		               <div class="modal-dialog">
		                   <div class="modal-content">
		                       <div class="modal-header">
		                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                           <h4 class="modal-title fw">알림</h4>
		                       </div>
		                       <div class="modal-body">
		                           <h5 id="confirmMsg"></h5>
		                        </div>
		                       	<div class="modal-footer tac">
		                       		<input type="button" class="btn width-100 btn-default" data-dismiss="modal" value="닫기" onclick="moveListPage();">
		                       	</div>
		                   	</div>
		               	</div>
		           	</div>

					<!-- #modal-dialog 결재자 지정팝업-->
		        	<div class="modal fade" id="modal-approve-review-dialog">
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
		             			<a type=button class="m_btn_navy" data-dismiss="modal" onclick="valchk();">확인</a>
		             			<a type=button class="m_btn_white ml10" data-dismiss="modal">취소</a>
		                 	</div>
	              		</div>
	           		</div>
				</div>

					<!-- 프로젝트 검토자 결재자 지정 팝업 -->
					<!-- #modal-dialog -->
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
										<div class="search-box">
											<input type="text" class="search-text-s" placeholder="사번이나 이름 부서로 입력하세요" id="reviewUserId" onkeypress="if(event.keyCode==13)gridPopList();" >
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
											<col width="80px">
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
					<!-- #modal-dialog -->

					<!-- 프로젝트 승인자 결재자 지정 팝업 -->
					<!-- #modal-dialog -->
					<div class="modal fade" id="user-modal-approve-dialog">
						<div class="modal-dialog">
		                   <div class="modal-content">
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
												<option value="deptName">부서</option>
											</select>
										</div>
										<div class="col-xs-9">
											<input type="text" class="search-text-s" placeholder="사번이나 이름 부서로 입력하세요" id="approveUserId" onkeypress="if(event.keyCode==13)gridPopApproveList();" >
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
					<!-- 결재자 지정 끝 -->

					<!-- 프로젝트 담당자 지정 팝업 -->
					<div class="modal fade" id="manager-modal-dialog">
						<div class="modal-dialog">
							<div class="modal-content w560">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='projectManagerList();'><span></span></button>
									<h4 class="modal-title">담당자 검색</h4>
								</div>
								<div class="modal-body">
									<!-- 검색 부분 -->
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
										<div class="search-box">
											<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="searchManageKeyword" onkeypress="if(event.keyCode==13)gridManagerPopList();" >
											<button type="button" class="btn_search2 vm" onclick="gridManagerPopList();"><span></span></button>
										</div>
									</div>
									<!-- 검색 부분 끝 -->

										<!-- 2023 new search-->
									  <!-- <div class="col-xs-12 bgee modalpop mb20">
										 <div class="new-search-modal">
								           <div class="left">
									         <div class="choice-kepco">
									         <input type="hidden" name="searchKind" id="searchKind" value="" />
											  <div class="select-kepco" for="searchKind">
											    <button class="kep-label"  id="__searchKind">전체 </button>
											    <ul class="optionList">
											      <li class="optionItem" value="searchAll">전체</li>
											      <li class="optionItem" value="userId">사번</li>
											      <li class="optionItem" value="userName">이름</li>
											      <li class="optionItem" value="deptName">부서</li>
											    </ul>
											  </div>
											</div>
											</div>

											<div class="right">
					                          <input type="text" class="input-kepco-s" placeholder="사번이나 이름 부서로 입력하세요" id="searchManageKeyword" onkeypress="if(event.keyCode==13)gridManagerPopList();"/>
					                          <button type="button" class="kepco-ser-icon-modal2 vm" onclick="gridManagerPopList();"></button>
					                         </div>
				                          </div>
				                          </div> -->
										<!--  2023 new search END -->







									<table class="tableV">
										<colgroup>
											<col width="*">
										 	<col width="15%">
										 	<col width="15%">
										 	<col width="15%">
										 	<col width="10%">
										</colgroup>

										<thead>
											<tr class="skyblue">
												<th class="tac">부서</th>
												<th class="tac">사번</th>
												<th class="tac">직급</th>
												<th class="tac">이름</th>
												<th class="tac"></th>
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

					<!-- 프로젝트 관리자 지정 팝업 -->
					<!-- #modal-dialog -->
					<div class="modal fade" id="administrator-modal-dialog">
		               <div class="modal-dialog">
		                   <div class="modal-content w560">
		                       <div class="modal-header">
		                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='projectAdminiStratorList();'></button>
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
												<div class="search-box">
													<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="searchAdminiStratorKeyword" onkeypress="if(event.keyCode==13)gridAdminiStratorPopList();" >
													<button type="button" class="btn_search2 vm" onclick="gridAdminiStratorPopList();"><span></span></button>
												</div>
										</div>
										<!--검색  끝//-->

										<!-- 2023 new search -->
										<!-- <div class="col-xs-12 bgee modalpop mb20">
										 <div class="new-search-modal">
								           <div class="left">
									         <div class="choice-kepco">
									         <input type="hidden" name="searchKindAdminiStrator" id="searchKindAdminiStrator" />
											  <div class="select-kepco" id="__searchKindAdminiStrator">
											    <button class="kep-label2" value="searchAll"  for="searchKindAdminiStrator">전체 </button>
											    <ul class="optionList" >
											      <li class="optionItem2" value="searchAll">전체</li>
											      <li class="optionItem2" value="userId">사번</li>
											      <li class="optionItem2" value="userName">이름</li>
											      <li class="optionItem2" value="deptName">부서</li>
											    </ul>
											  </div>
											</div>

											</div>

											<div class="right">
					                          <input type="text" class="input-kepco-s" placeholder="사번이나 이름 부서로 입력하세요" id="searchAdminiStratorKeyword" onkeypress="if(event.keyCode==13)gridAdminiStratorPopList();"/>
					                          <button type="button" class="kepco-ser-icon-modal2 vm"  onclick="gridAdminiStratorPopList();"></button>
					                         </div>
				                          </div>
				                          </div> -->
										<!-- 2023 new search END -->


				                       <table class="tableV">
										 <colgroup>
											<col width="*">
										 	<col width="15%">
										 	<col width="15%">
										 	<col width="15%">
										 	<col width="10%">
										</colgroup>

										<thead>
											<tr class="skyblue">
												<th class="tac">부서</th>
												<th class="tac">사번</th>
												<th class="tac">직급</th>
												<th class="tac">이름</th>
												<th class="tac"></th>
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

					<div class="modal fade" id="modal-dialog2">
		            	<div class="modal-dialog width-720">
			                <div class="modal-content width-720">
		                    	<div class="modal-header">
			                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
			                        <h4 class="modal-title">고객사 검색</h4>
		                    	</div>
								<div class="modal-body">
								 	<!-- search begin -->
								 	<div class="col-md-12 bgee modalpop mb20">

											<div class="col-md-12">
												<input type="text" class="search-text" placeholder="검색어로 입력하세요" id="searchKeyword" data-original-title="" title="">
											</div>
								  			<button type="button" class="kepco-ser-icon-modal" onclick="searchCustomer();"></button>

									</div>
						 			<!-- search end -->

						   			<div>
					   					<input type="hidden" value="" id="h_popCustomerId">
		     							<input type="hidden" value="" id="h_popCustomerName">
						   				<table class="tableV">
								 			<colgroup>
												 <col width="40%">
												 <col width="40%">
												 <col width="20%">
								 			</colgroup>
								 		<thead>
								 			<tr class="skyblue">
									 		<th class="tac">고객사 아이디</th>
											<th class="tac">고객사 이름</th>
											<th class="tac">적용</th>
								 			</tr>
								 		</thead>
								 		<tbody id="popListTable">

										 </tbody>
								 	</table>
								 </div>
		               		</div>
							<div class="clear"></div>
							<div class="modal-footer tac">
		             			<a type=button class="m_btn_navy" data-dismiss="modal" onclick="updateCustomer();">확인</a>
		             			<a type=button class="m_btn_white ml10" data-dismiss="modal">닫기</a>
		                 	</div>
		              	</div>
		    			</div>
					</div>
					<!-- #modal-dialog2  고객사  검색//-->

					<!-- #modal-dialog3 부서 검색-->
			        <div class="modal fade" id="modal-dialog3">
			            <div class="modal-dialog width-720">
			                <div class="modal-content width-720">
			                <!-- <table class="tbl_type01" id="deptTreeGrid" summary="" cellpadding="0" cellspacing="0"></table> -->

			                    <div class="modal-header">
			                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
			                        <h4 class="modal-title">부서 검색</h4>
			                    </div>
			                    <div class="modal-body">
							 	<!-- search begin -->
							 	<div class="col-md-12 bgee modalpop mb20">
										<div class="col-md-12">
											<input type="text" class="search-text" onkeypress="if(event.keyCode==13)searchDepartment();" id="searchKeywordDept" placeholder="검색어로 입력하세요" data-original-title="" title="">
										</div>
									  	<button type="button" class="kepco-ser-icon-modal" onclick="searchDepartment();"><span></span></button>

								</div>
							 	<!-- search end -->
							   <div class="col-md-12 pl0">
									<table id="table-list"></table>
							   </div>
			               	</div>
							<div class="clear"></div>
							<div class="modal-footer tac">
			             			<a type=button class="m_btn_navy" data-dismiss="modal" onclick="confirmDepartment();">확인</a>
			             			<a type=button class="m_btn_white ml10" data-dismiss="modal">닫기</a>
			                 	</div>
			              </div>
			           </div>
			        </div>
					<!-- #modal-dialog 부서  검색//-->

					<!-- #modal-dialog 모음 끝 -->
				</div>


				<!-- 모델 Cloud 검색 시작 -->
				<div class="modal fade" id="modal-dialog4">
		            	<div class="modal-dialog width-720">
			                <div class="modal-content width-720">
		                    	<div class="modal-header">
			                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
			                        <h4 class="modal-title">클라우드 검색</h4>
		                    	</div>
								<div class="modal-body">
								 	<!-- search begin -->
								 	<div class="col-md-12 bgee modalpop mb20">
										<div class="" style="text-align: center; display:inline-block;">
											<div class="col-md-8">
												<input type="text" class="search-text" placeholder="검색어로 입력하세요" id="searchKeyword" data-original-title="" title="">
											</div>
								  			<button type="button" class="btn_search2" onclick="searchCloud();"><span></span></button>
										</div>
									</div>
						 			<!-- search end -->

						   			<div>
					   					<input type="hidden" value="" id="h_popCloudId">
					   					<input type="hidden" value="" id="h_popCloudName">
		     							<input type="hidden" value="" id="h_popCloudType">
		     							<input type="hidden" value="" id="h_popCloudImgPath">
						   				<table class="tableV">
								 			<colgroup>
												 <col width="30%">
												 <col width="30%">
												 <col width="20%">
												 <col width="20%">
								 			</colgroup>
								 		<thead>
								 			<tr class="skyblue">
									 		<th class="tac">클라우드 ID</th>
									 		<th class="tac">클라우드 명</th>
											<th class="tac">클라우드 Type</th>
											<th class="tac">적용</th>
								 			</tr>
								 		</thead>
								 		<tbody id="popCloudListTable">

										 </tbody>
								 	</table>
								 </div>
		               		</div>
							<div class="clear"></div>
							<div class="modal-footer tac">
		             			<a type=button class="m_btn_navy" data-dismiss="modal" onclick="updateCloud();">확인</a>
		             			<a type=button class="m_btn_white ml10" data-dismiss="modal">취소</a>
		                 	</div>
		              	</div>
		    			</div>
					</div>
					<!-- 모델 Cloud 검색 끝 -->

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

			function projectManagerCheck(projectStatusFlag) {

				 var items = [];
				 $('input:checkbox[name=cloudIds]:checked').each(function () {
				     items.push($(this).val());
				 });

				 $("#h_cloudIds").val(items);

				if(items==""){
					alertBox("클라우드를 선택해주세요");
					return false;
				}

				var dispSdate = $("#dispSdate").val();
				var dispEdate = $("#dispEdate").val();
				if($("#projectAlias").val()==""){
					alertBox3("프로젝트명을 입력하세요");
					$("#projectAlias").focus();
					return false;
				}

				/* if(dispEdate==""){
					alertBox("프로젝트 종료일을 선택해주세요");
					return false;
				} */

				if($("#price").val()==""){
					alertBox("프로젝트 금액을 입력하세요");
					return false;
				}

				if(dispSdate==""){
					alertBox("프로젝트 시작일을 선택해주세요");
					return false;
				}


				if($("#customerName").val()==""){
					alertBox("회원사를 선택하세요");
					return false;
				}

				if($("#deptName").val()==""){
					alertBox("부서를 선택하세요.");
					return false;
				}

				// 사업계획서 파일 첨부 여부 체크
				if($("#files-list")[0].childElementCount < 1) {
					alertBox("사업계획서를 반드시 첨부하여 주세요.");
					return false;
				}

				// 담당자 목록의 담당자 구분여부
				var tmpCnt = $("#h_manager_count").val();

				for( var i = 1 ; i <= tmpCnt; i++) {
					var tmpValue = $("#projectManagerTypeId"+ i + " option:selected").val();
					if(tmpValue == undefined || tmpValue == '00' ){
						alertBox("담당자 구분을 선택하세요.");
						return false;
					}
				}
				openApproveReviewModal(projectStatusFlag);
			}

			// 신청 버튼 클릭시 결재자 지정 팝업 Open
			function openApproveReviewModal(projectStatusFlag) {
				//01 작성중,02 처리중,03 반려,04 처리완료
				$("#h_projectStatusFlag").val(projectStatusFlag);
				$("#pop_projectAlias").text($("#projectAlias").val());
				$("#pop_description").text($("#projectDescription").val());

				if(projectStatusFlag == 1) {
					projectTempInsert();
				} else {
					if($("#apprvPass").val() == "Y"){
						confirmBox4("결재자를 지정하시겠습니까?",approvSelect,nApprovSelect);
					} else {
						approvSelect();
					}
				}
			}

			function nApprovSelect(){
				$("#pop_projectAlias").text($("#projectAlias").val());
				$("#pop_description").text($("#projectDescription").val());
				$("#pop_price").text($("#price").val());
				$("#pop_dispSdate").text($("#dispSdate").val());
				$("#pop_dispEdate").text($("#dispEdate").val());
				$("#pop_customerName").text($("#customerName").val());

				$("#pop_deptName").text($("#deptName").val());
				$("#selectApprv").val("Y");
				$("#insert-modal-dialog").modal();
			}
			function approvSelect(){
				$("#selectApprv").val("N");
				$("#modal-approve-review-dialog").modal();
			}

			function openApproveModal() {
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
									+'<td class="tac">'+val.upDeptName+'/'+val.deptName+'</td>'
									+'<td class="tac">'+val.userId+'</td>'
									+'<td class="tac">'+val.userLevel+'</span>'
									+'<td class="tac">'+val.userName+'</td>'
									+'<td class="tac">'+val.userConditionText+'</td>'
									+'<td class="tac"><input type="button"  value="&#xf00c" class="popCheckbtn" onclick="updateApprove(this, \''+val.userId+'\', \''+val.userName+'\', \''+val.deptName+'\');" initModal();></td>'
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



				//요청부서 검토자/승인자 지정 - 요청부서(검토) 검토자지정
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
					//alert(tmpCurrentApprovalStep);
					var tmpValue = { "userId" : userId, "deptName" : deptName, "userName" : userName, "userLevel" : userLevel, "userLevelCode" : userLevelCode }
					//alert( JSON.stringify(tmpValue) );


					$("#"+currentApprovalLine.id+"_userId").text(userId);
					$("#"+currentApprovalLine.id+"_userLevel").text(userLevel);
					$("#"+currentApprovalLine.id+"_userName").text(userName);

					approvalList[tmpCurrentApprovalStep-1] = tmpValue;
					$("#hiddenUserIdReview").val(userId);
					$("#hiddenDeptNameReview").val(deptName);
					$("#hiddenUserNameReview").val(userName);

					// 다음 단계 버튼 활성화
					$("#approvalLine"+(parseInt(tmpCurrentApprovalStep)+1) ).attr('disabled', false);

				}

				// 요청부서 검토자/승인자 지정 - 요청부서(승인) 승인자지정
				function updateApprove(e, userId, userName, deptName) {
					/* if($("#hidden_login_user_id").val() ==userId) {
						alertBox("신청자는 본인을<br>결재자로 지정할수 없습니다.");
						return false;
					} */
					$("#popListApproveTable > tr").find("input").removeClass("active");
					$(e).toggleClass("active");
					$("#userIdApprove").text(userId);
					$("#deptNameApprove").text(deptName);
					$("#userNameApprove").text(userName);
					$("#hiddenUserIdApprove").val(userId);
					$("#hiddenDeptNameApprove").val(deptName);
					$("#hiddenUserNameApprove").val(userName);
				}

				// 결재자 지정 끝

				// 결재자 팝업
			function openUserModal(){
				gridPopList();
				$("#user-modal-dialog").modal();
			}

			// 담당자 등록 버튼 시 담당자 지정 Modal Open
			function openManagerModal(){
				gridManagerPopList();
				$("#manager-modal-dialog").modal();
			}

			 // 관리자 팝업
			function openAdminiStratorModal(){
				gridAdminiStratorPopList();
				$("#administrator-modal-dialog").modal();
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
										+'<td class="tac">'+val.upDeptName+'/'+val.deptName+'</td>'
										+'<td class="tac">'+val.userId+'</td>'
										+'<td class="tac">'+val.userLevel+'</td>'
										+'<td class="tac">'+val.userName+'</td>'
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


			// 담당자 등록 팝업 리스트
			function gridManagerPopList(){

				$.ajax({
					url : "${contextPath}/mbr/operation/approveUser/addProjectManageList",
					dataType : "JSON",
					data : {
						 "searchKind": $("#searchKind option:selected").val()
						, "keyword"	: $("#searchManageKeyword").val()
						  , "programSeq":$("#reqProjectSeq").val()

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
										+'<td class="tac">'+val.upDeptName+'/'+val.deptName+'</td>'
										+'<td class="tac">'+val.userId+'</td>'
										+'<td class="tac">'+val.userLevel+'</td>'
										+'<td class="tac">'+val.userName+'</td>'
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

	        //프로젝트 사용자포탈 결재자 insert
			function insertAdmin(e, userId){
				$.ajax({
					url : "${contextPath}/mbr/operation/approveUser/insertAdmin",
					dataType : "JSON",
					data : {
						"userId": userId
					  , "programSeq":$("#reqProjectSeq").val()

					},
					success : function(req) {
						$(e).parent().remove();
						totalCnt = totalCnt-1;
						$("#totalCnt").text("총 "+totalCnt+" 건");
						if(totalCnt == 0){
							$("#popListTable").hide();
							$("#popListTable2").show();
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



			// 담당자 등록 Modal에서 사용자 지정 클릭시 저장되는 Fn
			function insertManager(e, userId){

				if($("#h_popAdminiStratorId").val()==userId){
					alertBox("선택한 사용자는 관리자 입니다.");
					return false;
				}


				$.ajax({
					url : "${contextPath}/mbr/operation/approveUser/insertManager",
					dataType : "JSON",
					data : {
						"userId": userId
					  , "programSeq":$("#reqProjectSeq").val()

					},
					success : function(data) {
						 if(data == "5"){
							alertBox("프로젝트 담당자는 최대 5명등록가능합니다.", projectManagerList);
						}

						$(e).parent().remove();
						totalCnt = totalCnt-1;
						$("#totalCnt").text("총 "+totalCnt+" 건");
						if(totalCnt == 0){
							$("#popListTable").hide();
							$("#popListTable2").show();
						}

						//${"#h_gubun_validation"}.val("N");
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



			// 팝업메시지 세팅
			function alertModal(txt){
				$("#confirmMsg").text(txt);
				$("#message-modal-dialog").modal();
			}


			function valchk(){
				/* var dispSdate = $("#dispSdate").val();
				var dispEdate = $("#dispEdate").val();
				var projectPrice = $("#price").val();


				if(dispSdate==""){
					alertBox("프로젝트 시작일을 선택해주세요");
					return false;
				} */

				/* if(dispEdate==""){
					alertBox("프로젝트 종료일을 선택해주세요");
					return false;
				} */

				/* if(projectPrice==""){
					alertBox("프로젝트 금액을 입력하세요");
					return false;
				} */

				/* if($("#projectAlias").val()==""){
					alertBox3("프로젝트명을 입력하세요");
					$("#projectAlias").focus();
					return false;
				} */

				/* var vNetwork = "";
				var pop_network = "";
				var i = 1;
				$("input:checkbox[name='network']").each(function(){
					if($(this).is(":checked")){
						vNetwork += $(this).val();
					}

	// 				pop_network += $(this).val()+" ";
					if($(this).is(":checked")){
						if(i%2 !=0){
							pop_network += $(this).val() +" / ";
							i++;
						}else{
							pop_network += $(this).val()+"<br/>";
							i++;
						}
					}

				});

				if(vNetwork==""){
					alertBox3("네트워크망을 선택하세요");
					return false;
				}

				var msg = "";
				if(vNetwork.indexOf("내부망") != -1 && vNetwork.indexOf("DMZ") == -1){ msg = "외부 인터넷 구간과 통신하는 DMZ 네트워크 존이 선택되지 않았습니다.<br>DMZ망이 추가로 필요한 경우 관리자에게 문의 바랍니다."; }
				if(vNetwork.indexOf("내부망") == -1 && vNetwork.indexOf("DMZ") != -1){ msg = "내부통신만 하는 네트워크 존이 선택되지 않았습니다.<br>내부망이 추가로 필요한 경우 관리자에게 문의 바랍니다."; }
				if(vNetwork.indexOf("내부망") == -1 && vNetwork.indexOf("DMZ") == -1){ msg = "네트워크를 선택하지 않으면 자원신청을 할수가 없습니다.<br>자원 신청시 네트워크를 관리자에게 문의 후 신청 바랍니다."; }

				pop_network = pop_network.substring(0, pop_network.length-3);
				$("#pop_networkZone").html(pop_network);
				$("#pop_networkEtc").text($("#networkEtc").val()); */

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

				if( approvalList[3] == undefined || approvalList[3] == null || approvalList[3] == '' ) {
					alertBox3("결재자를 지정해 주세요");
					return false;
				}

				$("#pop_projectAlias").text($("#projectAlias").val());
				$("#pop_description").text($("#projectDescription").val());
				$("#pop_price").text($("#price").val());
				$("#pop_dispSdate").text($("#dispSdate").val());
				$("#pop_dispEdate").text($("#dispEdate").val());
				$("#pop_customerName").text($("#customerName").val());

				$("#pop_deptName").text($("#deptName").val());

				$("#insert-modal-dialog").modal();
	// 			confirmBox(msg+"<br><br>프로젝트를 신청하시겠습니까?", projectInsert);
			}


			// 프로젝트 신청
			function projectInsert() {
				var jsonData = setJsonData();

				$.ajax({
					url : "${wasPath}/mbr/req/project/reqProjectInsert",
					dataType : "JSON",
					type : "POST",
					data : jsonData,

					success : function(data) {

						var result = data;
						var res = data.res;
						var programSeq = data.reqProjectSeq;

						if(res==1){
							$("#programSeq").val(programSeq);
							alertBox("저장하였습니다.", actFileUpload);
						}else if(res == 2){
							alertBox("사용자 아이디을 사용하실수 없습니다.", moveListPage);
						}else if(res ==3){
							alertBox("실무부서는 한명만 선택 가능합니다.");
						}else{
							alertBox3("fail!");
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

			// 프로젝트 신청
			function projectTempInsert() {
				var jsonData = setJsonData();

				$.ajax({
					url : "${wasPath}/mbr/req/project/reqProjectTempInsert",
					dataType : "JSON",
					type : "POST",
					data : jsonData,

					success : function(data) {

						var result = data;
						var res = data.res;
						var programSeq = data.reqProjectSeq;

						if(res==1){
							$("#programSeq").val(programSeq);
							alertBox("저장하였습니다.", actFileUpload);
						}else if(res == 2){
							alertBox("사용자 아이디을 사용하실수 없습니다.", moveListPage);
						}else if(res ==3){
							alertBox("실무부서는 한명만 선택 가능합니다.");
						}else{
							alertBox3("fail!");
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

			function actFileUpload(){
				$('#file-form').ajaxForm({
					cache:false
					, data : {
						programName: $("#programName").val()
						, programSeq : $("#programSeq").val()
					}

					, dataType:"json"
			       	//보내기전 validation check가 필요할경우
			       	, beforeSubmit: function (data, frm, opt) {
			       		alert(data);
			       		var chk = true;

			       		$.each(data, function(i, val){
			       			if(val.value.size > 52428800){
			       				alertBox3("첨부파일 용량은 50MB를 초과할수 없습니다.");
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


			// 선택된 네트워크 세팅
// 			function networkValues(){
// 				var checkVal = "";

// 				$("input:checkbox[name='network']").each(function(){
// 					if($(this).is(":checked")){
// 						checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "Y" + ",";
// 					}else{
// 						checkVal += $(this).attr("id") + ":" + $(this).val() + ":" + "N" +",";
// 					}
// 				});

// 				checkVal = checkVal.substring(0, checkVal.length-1);
// 				return checkVal;
// 			}

			//데이터 세팅
			function setJsonData(){

				var items={};
				var i=0;
// 				var netstr="";
// 				var checkVal = networkValues();

				if( approvalList[0] == undefined || approvalList[0] == null) {
					var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
					approvalList[0] = tmp;
				}

				var jsonData = {
						"projectAlias":$("#projectAlias").val()
						, "projectDescription":$("#projectDescription").val()
						//, "networkEtc":$("#networkEtc").val()
						//, "network": checkVal
						, "reqProjectSeq":$("#reqProjectSeq").val()
						, "projectPrice":$("#price").val().replace(/\,/g, "")
						, "projectStartDatetime":$("#dispSdate").val().replace(/-/gi, "")
						, "projectEndDatetime":$("#dispEdate").val().replace(/-/gi, "")

						, "hiddenUserIdReview":$("#hiddenUserIdReview").val()
						, "hiddenUserNameReview":$("#hiddenUserNameReview").val()
						, "hiddenUserIdApprove":$("#hiddenUserIdApprove").val()
						, "hiddenUserNameApprove":$("#hiddenUserNameApprove").val()

						, "projectCustomerId":$("#h_popCustomerId").val()
						, "projectCustomerName":$("#h_popCustomerName").val()
						, "projectDeptCode":$("#h_popDeptCode").val()
						, "projectDeptName":$("#h_popDeptName").val()
						, "statusFlag":$("#h_projectStatusFlag").val()
						, "adminiStratorId":$("#h_popAdminiStratorId").val()

						, "approvalStepList" : approvalList
						, "apprvPass":$("#apprvPass").val()
						, "selectApprv":$("#selectApprv").val()
						, "cloudIds":$("#h_cloudIds").val()

						};
				return jsonData;
			}
			//---> Modal popup start

			//modal팝업 open
			function openModal(){
				$("#insert-modal-dialog").modal();
			}

			//프로젝트 영문명 중복체크
			function projectIdCheck(){

				var projectName = $("#_projectName").val();

				$.ajax({
					url : "${wasPath}/mbr/req/project/projectNamecheck",
					dataType : "JSON",
		 			type : "GET",
					data : {
						"projectName" : projectName
					},
					success : function(data) {
						var result = data;
						$("#checkMsg").text(result.namechktext);
						if(result.chkval==0){
							$("#enableId").css("display", "block");
							$("#unableId").css("display", "none");
						}else{
							$("#enableId").css("display", "none");
							$("#unableId").css("display", "block");
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


			// 중복체크완료된 프로젝트영문명 적용
			function setId(){
				var projectName = $("#_projectName").val();
				$("#projectName").val(projectName);

				initModal();
				$("#modal-dialog").modal("hide");
			}

			// 팝업 초기화
			function initModal(){
				$("#_projectName").val("");
				$("#checkMsg").text("");
				$("#enableId").css("display", "none");
				$("#unableId").css("display", "block");
			}

			//<--- Modal popup end


			function moveListPage(){
				location.href="${wasPath}/mbr/req/project/okprojectList.do";
			}

			//해당 회원사에 네트워크 존재 유무확인
// 			function netDisabled(){
// 				<c:forEach items="${code}" var="codelist" varStatus="status" begin="0" step="1">
// 					<c:if test="${codelist.disabled ne ''}">
// 						$("#"+ "${codelist.codeId}").attr("disabled", true);
// 					</c:if>
// 				</c:forEach>
// 			}

			function gridList() {
				 $("#approveList").dataTable( {
						"processing":true
						,"ordering" : false
						,"destroy" : true
						,"autoWidth":false
						,"serverSide":true
					,"ajax": {
						"url":"${contextPath}/mbr/operation/approveUser/projectList"
						,"type" : "GET"
						,"dateSrc" : ""
						,"data":function (d) {
							d.searchKind = $("#searchKind option:selected").val();
							d.keyword = $("#keyword").val();
							d.programSeq = $("#programSeq").val();
						}
					}
					,"columns":[
			        	{"data":"WF3000A0", "class":"tac"}
			        	,{"data":"WF3000B0", "class":"tac"}
			        	, {"data":"customername", "class":"tac"}
			        	, {"data":"userName", "class":"tac"}
			        	, {"data":"userPhone", "class":"tac"}
			        	, {"data":"userTel", "class":"tac"}
			        	, {"data":"userMail", "class":"tac"}
			        	, {"class":"tac"}
					]

					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
							, {"targets":[0], "render":function(data,type,full){
								if(full.WF3000A0 == "Y"){
									return 'Y';
								}else{
									return 'N';
								}
							}
						}
							, {"targets":[1], "render":function(data,type,full){
								if(full.WF3000B0 == "Y"){
									return 'Y';
								}else{
									return 'N';
								}
							}
						}
					/* 		, {"targets":[7], "render":function(data,type,full){
								return '<a type="button" class="btnType05" onclick="moveDetailPage(\''+full.userId+'\');"><span class="bg_left"></span><span class="txt">변경</span><span class="bg_right"></span></a>';
							}
						}		 */
							, {"targets":[8], "render":function(data,type,full){
								return '<a type="button" class="bton-s bton_orange" onclick="projectApproveUserDelete(\''+full.userId+'\');"> <i class="fa fa-trash"></i> 삭제 </a>';
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

			// 프로젝트 담당자 목록 조회
			function projectManagerList() {
				var i = 0;
				$("#projectManagerList").dataTable({
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
							d.programSeq = $("#programSeq").val();
						}
					}
					,"columns":[
			        	  {"data":"customerName", "class":"tac"}
			        	 ,{"data":"deptName", "class":"tac"}
			        	, {"data":"userName", "class":"tac"}
			        	, {"data":"userId", "class":"tac"}
	//		        	, {"data":"userPhone", "class":"tac"}
			        	, {"data":"userTel", "class":"tac"}
			        	, {"data":"userMail", "class":"tac"}
			        	, {"data":"division", "class":"tac"}
			        	, {"data":"projectManagerType", "class":"tac"}
					]

					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
							, {"targets":[6], "render":function(data,type,full){

							    i++;
							    $("#h_manager_count").val(i);
								if(full.projectManagerType == 02){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="02" selected="selected">실무부서</option><option value="03">시스템관리부서</option><option value="04">위탁운영부서</option></select>';}
								else if(full.projectManagerType == 03){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="02">실무부서</option><option value="03" selected="selected">시스템관리부서</option><option value="04">위탁운영부서</option></select>';}
								else if(full.projectManagerType == 04){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="02">실무부서</option><option value="03">시스템관리부서</option><option value="04" selected="selected">위탁운영부서</option></select>';}
								else{return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="00" selected="selected"></option><option value="02">실무부서</option><option value="03">시스템관리부서</option><option value="04">위탁운영부서</option></select>';}

								}
						}
							, {"targets":[7], "render":function(data,type,full){
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
					,"sDom":'<"top"><"bottom">'
				});
			}





			function delFile(fileId){
				$.ajax({
					url : "${contextPath}/mbr/cmm/file/delete",
					dataType : "JSON",
					data : {
						"fileId" : fileId
						, "programName": $("#programName").val()
						, "programSeq" : $("#programSeq").val()
					},
					success : function(data) {
						updateFilesCnt("1");
					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				})
			}

	       //프로젝트 사용자 권한 변경, 권한 삭제 뷰
			function moveDetailPage(userId){
				var windowW = 1000;  // 창의 가로 길이
		        var windowH = 500;  // 창의 세로 길이
		        var left = Math.ceil((window.screen.width - windowW)/2);
		        var top = Math.ceil((window.screen.height - windowH)/2);

				var g_oWindow = null;
				var g_oInterval = null;

				    g_oWindow = window.open("${contextPath}/mbr/operation/approveUser/projectView?userId="+userId,"_blank","scrollbars=yes, resizable=yes, top ="+top+" , left ="+left+", height ="+windowH+", width ="+windowW+"");
				    g_oInterval = window.setInterval(function() {
				        try {
				            // 창이 꺼졌는지 판단
				            if( g_oWindow == null || g_oWindow.closed ) {
				                window.clearInterval(g_oInterval);
				                g_oWindow = null;
				               gridList();
				            }
				        } catch (e) { }
				    }, 500);
			 	}

		 	//프로젝트 결재자 삭제
		 	//	 사용자 권한 변경, 권한 삭제 뷰
			function projectApproveUserDelete(userId){

				$.ajax({
					url : "${wasPath}/mbr/req/project/projectApproveUserDelete",
					dataType : "JSON",
		 			type : "GET",
					data : {
						"userId" : userId
						, "reqProjectSeq" : $("#programSeq").val()
					},
					success : function(data) {
						var result = data;
						if(result.res==0){
							alertBox("접속이 만료되었습니다.", logout);

						}else{
							alertBox("삭제되었습니다.", gridList);
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

			//프로젝트 관리자 권한 삭제
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
						if(result.res==0){
							alertBox("접속이 만료되었습니다.", logout);
						}else{
							alertBox("삭제되었습니다.", projectManagerList);
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
						,"reqProjectSeq" : $("#reqProjectSeq").val()
						,"projectManagerType" : projectManagerType
					},
					success : function(data) {
						var result = data;

						if(result.res==0){
							alertBox("접속이 만료되었습니다.", logout);

						}else{
							projectManagerList();
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

			// 달력
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
					changeYear:true,
					minDate:0
				});

				$("img.ui-datepicker-trigger").attr("style", "position:relative; right:40px; top:-2px;");
			}


			//프로젝트 영문명 중복체크
			function projectManagerApproveCheck(){

				$.ajax({
					url : "${wasPath}/mbr/req/project/projectManagerApproveCheck",
					dataType : "JSON",
		 			type : "GET",
					data : {
						  "reqProjectSeq" : $("#reqProjectSeq").val()
					},
					success : function(data) {
						var result = data;


						if(result.managerTypeChkval < 0){
							alertBox("프로젝트 관리자 구분을 선택해주세요");
							return false;
						}
						//if(result.approve1Chkval <= 0){
						//	alertBox("프로젝트 1차 결재자를 입력해주세요");
						//	return false;
						//}
						//if(result.approve2Chkval <= 0){
						//	alertBox("프로젝트 2차 결재자를 입력해주세요");
						//	return false;
						//}

	                    projectInsert();
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


			function openCustomerModal(){
				$("#modal-dialog2").modal();
				searchCustomer();
			}
			// 회원사 목록 조회
			function searchCustomer(){
				$.ajax({
					url : "${wasPath}/mbr/cmm/user/customerSelect",
					dataType : "JSON",
					type : "POST",
					data : {
						"keyword" : $("#searchKeyword").val()
					},
					success : function(data) {
						var popList = data
						$("#modal-dialog2").modal();
						if(popList != ""){
							$("#popListTable > tr").remove();
							$.each(data,function(key,val){
								var Html="";
								Html="<tr><td class='tac'>"+val["customerId"]+"</td>";
								Html = Html + "<td class='tac'>"+val["customerName"]+"</td>";
								Html = Html + "<td class='tac'><input type='button'  value='&#xf00c' class='popCheckbtn' onclick='selectCustomer(this, \""+val["customerId"]+"\", \""+val["customerName"]+"\")' ></td>";
								Html = Html + "</tr>";

								$("#popListTable").append(Html);
							});
						}else{
							$("#popListTable > tr").remove();
							var Html="";
							Html="<tr><td class='tac' colspan='3'><span style='color:#bbb;'>"+"검색된 목록이 없습니다."+"</span></td></tr>";


							$("#popListTable").append(Html);
						}
						$('#popListTable tr:odd').addClass('even');
						$('#popListTable tr:even').addClass('odd');
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "error:" + error + "\n" + "message:" + request.responseText);
					}
				});
			} // end of function searchCustomer()


			function openCloudModal(){
				$("#modal-dialog4").modal();
				searchCloud();

			}

			// 클라우드 목록 조회
			function searchCloud(){
				$.ajax({
					url : "${wasPath}/mbr/cmm/cloud/cloudSelect",
					dataType : "JSON",
					type : "POST",
					data : {
						"keyword" : $("#searchKeyword").val()
					},
					success : function(data) {
						var popList = data
						$("#modal-dialog4").modal();
						if(popList != ""){
							$("#popCloudListTable > tr").remove();
							$.each(data,function(key,val){
								var Html="";
								Html="<tr><td class='tac'>"+val["cloudId"]+"</td>";
								Html = Html + "<td class='tac'>"+val["cloudName"]+"</td>";
								Html = Html + "<td class='tac'>"+val["cloudType"]+"</td>";
								Html = Html + "<td class='tac'><input type='button'  value='&#xf00c' class='popCheckbtn' onclick='selectCloud(this, \""+val["cloudId"]+"\", \""+val["cloudName"]+"\", \""+val["cloudType"]+"\", \""+val["cloudImgPath"]+"\")' ></td>";
								Html = Html + "</tr>";

								$("#popCloudListTable").append(Html);
							});
						}else{
							$("#popCloudListTable > tr").remove();
							var Html="";
							Html="<tr><td class='tac' colspan='3'><span style='color:#bbb;'>"+"검색된 목록이 없습니다."+"</span></td></tr>";

							$("#popCloudListTable").append(Html);
						}
						$('#popCloudListTable tr:odd').addClass('even');
						$('#popCloudListTable tr:even').addClass('odd');
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "error:" + error + "\n" + "message:" + request.responseText);
					}
				});
			} // end of function searchCloud()

			function selectCustomer(e, cstmId, cstmNm){
				$("#popListTable > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
				$("#h_popCustomerId").val(cstmId);
				$("#h_popCustomerName").val(cstmNm);

			}

			// 회원사 적용
			function updateCustomer(){
				var customerId = $("#h_popCustomerId").val();
				var customerName = $("#h_popCustomerName").val();
				$("#h_popCustomerName").val();
				$("#customerId").val(customerId);
				$("#customerName").val(customerName);
			}

			// 클라우드 적용
			function selectCloud(e, cloudId, cloudName, cloudType, cloudImgPath) {

				$("#popCloudListTable > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
				$("#h_popCloudId").val(cloudId);
				$("#h_popCloudName").val(cloudName);
				$("#h_popCloudType").val(cloudType);
				$("#h_popCloudImgPath").val(cloudImgPath);
			}

			// 클라우드 팝업창 확인 적용
			function updateCloud(){

				var cloudId = $("#h_popCloudId").val();
				var cloudName = $("#h_popCloudName").val();
				var cloudType = $("#h_popCloudType").val();
				var cloudImgPath = $("#h_popCloudImgPath").val();

				$("#cloudId").val(cloudId);
				$("#cloudName").val(cloudName);
				$("#cloudType").val(cloudType);
				$("#cloudImgPath").val(cloudImgPath);
			}

			// --> Modal3 부서 다이얼로그
		 	function openDepartmentModal(){
				$("#modal-dialog3").modal();
				initialDepartment();
			}
			function initialDepartment() {
				$("#table-list").jqGrid('clearGridData', true);
				$("#table-list").jqGrid({
					url : '${contextPath}/mng/cmm/department/TreeAll',
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
	//	  				leaf: 'ui-icon-document-b'},
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
			// 부서 적용
			function updateDepartment() {
				var deptCode = $("#h_popDeptCode").val();
				var deptName = $("#h_popDeptName").val();
				//$("#h_popDeptName").val();
				$("#deptCode").val(deptCode);
				$("#deptName").val(deptName);

				$("#searchKeywordDept").val("");
				$("#modal-dialog3").modal("hide");
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


                //alert("${fn:contains(authorities, 'ROLE_CLOUD_OPERATION')}");
			    //if("${fn:contains(authorities, 'ROLE_CLOUD_OPERATION')}"){
			    // alert("ROLE");
				//} qkrwl


			    App.init();
// 			    netDisabled();
			    gridList();
			    projectManagerList();
			    calendar();
			    initApprovalLine();

			    //로그인 사용자 회원사, 부서 선택
	     	    $("#customerId").val($("#h_popCustomerId").val());
				$("#customerName").val($("#h_popCustomerName").val());
				$("#deptCode").val($("#h_popDeptCode").val());
				$("#deptName").val($("#h_popDeptName").val());

				var login_user_id =  $("#hidden_login_user_id").val();
				var login_user_name = $("#hidden_login_user_name").val();
				var login_user_dept_name = $("#h_popDeptName").val();

				$("#adminiStrator").val(login_user_id +" / "+ login_user_name+" / "+login_user_dept_name);

				$("a>button").on('click',function(){
					location.href = $(this).closest("a").attr("href");
				});

				//중복확인 후 추가입력 방지
			 	$("#_projectName").on({
				 	focus : function() {
				 		$("#enableId").css("display", "none");
						$("#unableId").css("display", "block");
					},
					keyup : function() {
						$("#checkMsg").text("");
				 		//특수문자 & 공백 입력 제한
				 		if(!(event.KeyCode>=37 && event.keyCode<=40)){
				 			var inputVal = $(this).val();
				 			$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
				 		}
					}
				});

				$('#files').MultiFile({
					list: "#files-list",
					max : 5,
					//, accept : 'gif|jpg|png'
					maxfile : 51200,
					maxsize : 51200,
					STRING : {
						//remove : "<input type='button' value='삭제' class='btn btn-danger' style='font:8px;padding-bottom:2px;'>"
						duplicate : "$file 은 이미 선택된 파일입니다."
						, denied : "$ext 는(은) 업로드 할수 없는 파일 확장자 입니다."
						, toobig : "$file 은 크기가 매우 큽니다.(max $size)"
						, toomuch : "업로드 할 수 있는 최대크기를 초과하였습니다.($size)"
						, toomany : "업로드 할 수 있는 최대 갯수는 $max개 입니다."
					}
				});

				//메뉴활성화
				$("#project").addClass("active");
	 		 	//$("#projectInsert").addClass("active");

			});


			const label = document.querySelector('.kep-label');
			const options = document.querySelectorAll('.optionItem');
			const handleSelect = function(item) {
			  label.innerHTML = item.innerText;
			  label.parentNode.classList.remove('active');
			  document.querySelector("#searchKind").value = item.getAttribute("value");
			}
			for( let i = 0; i < options.length; i++ ){
			  options[i].addEventListener('click', function(){handleSelect(this)})
			}

			label.addEventListener('click', function(){
			  if(label.parentNode.classList.contains('active')) {
			    label.parentNode.classList.remove('active');
			  } else {
			    label.parentNode.classList.add('active');
			  }
			});


 			const label2 = document.querySelector('.kep-label2');
			const options2 = document.querySelectorAll('.optionItem2');
			const handleSelect2 = function(item) {
			  label2.innerHTML = item.innerText;
			  label2.parentNode.classList.remove('active');
			  document.querySelector("#searchKindAdminiStrator").value = item.getAttribute("value");
			}
			for( let i = 0; i < options2.length; i++ ){
			  options2[i].addEventListener('click', function(){handleSelect2(this)})
			}

			label2.addEventListener('click', function(){
			  if(label2.parentNode.classList.contains('active')) {
			    label2.parentNode.classList.remove('active');
			  } else {
			    label2.parentNode.classList.add('active');
			  }
			});





		</script>
	</body>
</html>