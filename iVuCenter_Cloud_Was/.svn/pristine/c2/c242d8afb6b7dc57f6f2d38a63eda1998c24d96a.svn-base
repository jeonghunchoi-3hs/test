<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="roles" property="principal.roles" />
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
			<!-- begin #page-container > header -->
			<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->
			<!-- begin #page-container > sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #page-container > content -->
			<div id="content" class="content">

				<p class="page_title">블록디스크 상세
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원현황  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/project/disk/">블록디스크 </a>  <span class="arrow_ab"> &#8227; </span> <b>블록디스크 상세   </b>
			    </span>
				</p>

				<input type="hidden" name="apprvPass" id="apprvPass"				value="${apprvPass}" />
				<input type="hidden" name="projectId" id="projectId"				value="${req.projectId}"/>
				<input type="hidden" name="selectApprv" id="selectApprv"			value="" />
				<input type="hidden" id="requestType" name="requestType" />
				<input type="hidden" id="approvalStepListString" name="approvalStepListString" />
				<!-- begin #page-container > content > page-body -->
				<div class="row p20 bgwh br10">

					<%-- <table class="tableH4">
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
							<th colspan="8" class="f18"><%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>
							<span class="pid" id='projectName'></span>
							<h3 class="pname dpin ml20" id="projectAlias"></h3></th>
						</tr>
						<tr>
							<td class="point tac">본부</td>
							<td id="deptName"> </td>
							<td class="point tac">처(실)</td>
							<td id="deptName2"> </td>
							<td class="point tac">부서</td>
							<td id="deptName3"> </td>
							<td class="point tac">담당자 </td>
							<td id="managerName"> (<span id="managerTel"></span>)</td>
						</tr>
						<tr>
							<th colspan="8">
							<!--  현재 사용 용량  -->
								<div class="usageStatusWrap mt20">
									<strong class="titleLabel">현재 사용 용량</strong>
									<dl>
										<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>볼륨<span class="cnt"><em class="fc-violet" id='diskCn'></em>EA</span></dd>
										<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>블록디스크<span class="cnt"><em class="fc-blue" id='diskGb'></em>GB</span></dd>
										<dd class="mt30"><a type="button" onclick="useAvailabilityDetail('${req.projectId}');"><button class="cbton bton_blue"><i class="fa fa-battery-half ml-2"></i></button></a></dd>
									</dl>
								</div>
						</tr>
					</tbody>
					</table> --%>


				  <div class="col-md-12 pl0 pr0">
            	   <div class="col-md-12 pl0"><%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>
            	    <span class="pid" id='projectName'></span>
					<h3 class="pname dpin ml20" id="projectAlias"></h3>
            	   </div>

            	   <div class="clear"></div>
            	   <div class="col-md-12 pl0 pr0 mt20">
	            	    <div class="col-md-3 sub_li"  style="float:left;">
	            	       <label>본부 </label>
	            	       <span id="deptName"></span>
	            	    </div>
	            	    <div class="col-md-3 sub_li">
	            	       <label>처(실)</label>
	            	      <span  id="deptName2"></span>
            	  		</div>
            	  		<div class="col-md-3 sub_li">
	            	       <label>부서</label>
	            	      <span id="deptName3"></span>
            	  		</div>
            	  		<div class="col-md-3 sub_li" style="margin-right:0;float:right;">
	            	       <label>담당자</label>
	            	       <span id="managerName"></span> (<span id="managerTel"></span>)
            	  		</div>
            	     </div>
            	     <div class="col-md-12 pl0 pr0 mt20">
            	     <h4 class="f16 mb10 f500 mb20 flex align-center gap10">현재 사용량 <a type="button" onclick="useAvailabilityDetail('${req.projectId}');" class="btn_navy-ss flr"> 실시간 가용용량</a> </h4>
            	     <div class="col-md-6 sub_use_disk">볼륨<span class="flr"><em class="fc_orange_im f24 mr5" id='diskCn'></em> EA</span> </div>
            	     <div class="col-md-6 sub_use_disk" style="margin-right:0;float:right;">블록디스크 <span class="flr"><em class="fc_blue_im f24 mr5" id='diskGb'></em>GB</span></div>
            	     </div>
            	   </div>

					<div class="clear"></div>

                    <!-- 상단 버튼  -->
						<div class="tar mt20" style="margin-bottom:20px;">
							<a onclick="excelDown();" type='button' class="btn_navy-s"><img src="${apachePath}/resources/assets/img/icon_down.svg" height="18px;"/>  엑셀 다운로드</a>
						</div>
						<!-- //상단 버튼  -->
					<!-- 프로젝트 하위 상세 블록디스크 리스트 시작 -->
					<div class="gridTableWrap gridType02 mt20">
						<input type ="hidden" id="hid_projectBoxId" value="${req.projectBoxId}">
						<input type ="hidden" id="hid_projectName" value="${req.projectName}">
						<input type ="hidden" id ="reqProjectSeq"  value="${req.programSeq}">
						<input type ="hidden" id="hid_customerId" value="">
						<input type ="hidden" id="cloudId" value="${req.cloudId}">
						<input type ="hidden" id ="unconnectVmUuid">
						<input type ="hidden" id ="unconnectDiskId">
						<input type ="hidden" id ="connectVmUuid">
						<input type ="hidden" id ="connectDiskId">

						<!-- 그리드 영역 -->

					        <table id="disk-list"  class="tableV">
					        	<colgroup>
							 		<col width="13%">
							 		<col width="10%">
							 		<col width="7%">
							 		<col width="*">
							 		<col width="10%">
							 		<col width="8%">
							 		<col width="8%">
							 		<col width="10%">
							 		<col width="6%">
							 	</colgroup>
								<thead>
								    <tr class="grey">
										<th>디스크명</th>
										<th>클라우드</th>
										<th>크기(GB)</th>
										<th>가상서버</th>
										<th>마운트포인트</th>
										<th>연결관리</th>
										<th>스냅샷</th>
										<th>자원승인일시</th>
										<th>상세</th>
									</tr>
								</thead>
							</table>


					</div>
					<!-- 프로젝트 하위 상세 블록디스크 리스트 끝 -->

					<div class="tac mt25">
						<a type="button" class="btn_dgrey" onclick="moveListPage();">목록</a>
					</div>
				</div>
				<!-- end content > page-body -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			</div>
			<!-- end #page-container > content -->






			<!-- begin #page-container > modal -->
			<!-- 블록디스크 연결등록 Modal -->
			<div class="modal fade" id="modal-attach">
	            <div class="modal-dialog">
	                <div class="modal-content w560">
	                    <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        <h4 class="modal-title">블록디스크 연결등록</h4>
	                    </div>
	                    <div class="modal-body">
							<div class="col-md-12 bgee modalpop mb20">
								<div class="tac dpin">
									<div class="col-md-8">
										<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="searchKeyword" >
									</div>
						  			<button type="button" class="btn_search2" onclick="projectPopList();"><span></span></button>
								</div>
							</div>
							<div>
					     		<table class="table table-bordered table-hover table-striped table-td-valign-middle mb0"  id="connect-list">
						        	<colgroup>
								 		<col width="30%">
								 		<col width="30%">
								 		<col width="35%">
								 		<col width="15%">
								 	</colgroup>
									<thead>
									   <tr class="skyblue">
											<th class='tac'>가상서버명</th>
											<th class='tac'>호스트명</th>
											<th class='tac'>IP주소</th>
											<th class='tac'>적용</th>
										</tr>
									</thead>
									<tbody id="VM-listTable">
									</tbody>
								</table>
							</div>
                 		</div>
	                 	<div class="modal-footer tac">
							<a type="button" class="lbtn" data-dismiss="modal" onClick="confirmAttach()">확인</a>
							<a type="button" class="rbtn" data-dismiss="modal">취소</a>
						</div>
					</div>
				</div>
			</div>

			<!-- 블록디스크 연결해지 Modal -->
			<div class="modal fade" id="modal-attach-cut">
					<div class="modal-dialog">
	                   <div class="modal-content w560">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">블록디스크 연결해지</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="client_DetailBg m-b-20 txtAleft">
									<div class="client_DetailArea">
										<h2 class="blueBoxTitle">프로젝트정보</h2>
										<p class="company_Name2"  id="modal_projectAlias"></p>
										<p class="company_Info m-b-25">
											<span class="company_labelf">고객사 :</span><span class="company_cont"  id="modal_customerName"></span>
										</p>
									</div>
								</div>

								<div class="topArea txtAleft">
									<p class="fl m-b-10">
										<span class="serverPopLabel">디스크명</span>
										<span class="serverName f18 fc11" id=""><span id="vm_view_tab_diskAlias_text"></span>
									</p>
									<p class="fl cb mt-3">
										<span class="serverPopLabel">디스크ID</span>
										<span class="hostName2 f18 fc11 fontVdn" id="vm_view_tab_diskId_text"></span>
										<input type ="hidden" id ="unconnectVmUuid">
										<input type ="hidden" id ="unconnectDiskId">
										<input type ="hidden" id ="connectVmUuid">
										<input type ="hidden" id ="connectDiskId">
									</p>
	                       		</div>

	                       		<div class="networkListWrap clearfix">
									<p class="m-b-10"><span class="serverPopLabel">호스트명</span><span class="fixedNetwork2 p-l-5" id ="vm_view_tab_hostname_text"></span></p>
									<p class="cb mt-3"><span class="serverPopLabel">마운트포인트</span><span class="fixedNetwork2 p-l-5" id ="vm_view_tab_attachments_text"></span></p>
								</div>

								<div class="bottomArea clearfix">
	                       			<div class="bottomAreaDetail tal clearfix">
	                       				<ul>
	                       					<li class=""><span class="doubledotte">크기</span><span class="fontVdn f16"  id ="vm_view_tab_sizeGb_text"></span></li>
	                       					<li class=""><span class="doubledotte">생성일시</span><span class="fontVdn f16" id ="vm_view_tab_regDatetime2_text"></span></li>
	                       					<li class=""><span class="doubledotte">과금단위</span><span class="f16" id ="vm_view_tab_hourlyFlag_text"></span></li>
	                       				</ul>
	                       			</div>
	                       		</div>
                       			<p class="f18 f11 m-t-30">연결을 해지하시겠습니까?</p>
		                   	</div>

	                       	<div class="modal-footer tac">
	                       		<a type="button" class="pbton bton_blue" data-dismiss="modal" onClick="confirmDetach()">확인</a>
	                       		<a type="button" class="pbton bton_dgrey" data-dismiss="modal" onClick ="closeModal('modal-attach-cut')">취소</a>
	                       	</div>
		               	</div>
					</div>
                 </div>

			<!-- 블록디스크 상세 Modal -->
			<div class="modal fade" id="disk-modal-dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
							<h4 class="modal-title">블록디스크 상세</h4>
                    	</div>
						<div class="modal-body">
							<div class="tableE">
								<table>
									<colgroup>
										<col width="120px" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th class="tal">프로젝트명</td>
											<td>
												<div class="flex align-center gap10">
													<span class="" id="disk_view_projectAlias"></span>
													<span class="pop_pid">${req.projectName}</span>
												</div>
											</td>
										</tr>
										<tr>
											<th class="tal">디스크명</td>
											<td>
												<div class="flex align-center gap10">
													<span class="serverName f14 fc11 flex align-center gap10" id="vm_view_tab_hostnameAlias_view">
														<span id="disk_view_diskAlias"></span>
														<a type="button" onclick="inputShow('vm_view_tab_hostnameAlias_view','hostnameInput', 'vm_view_tab_hostnameAlias','vm_view_tab_hostnameAlias_text');" class="title_modify"></a>
													</span>
													<span class="serverRename" id="hostnameInput" style="display: none;">
														<input maxlength="30" type="text" class="modiedit" id="vm_view_tab_diskNameAlias_value" data-original-title="" title="">
														<a type="button" onclick="updateHostNameAlias();" class="m_btn_navy ml10" data-dismiss="modal" style="padding: 4px 16px;">저장</a>
														<a type="button" onclick="inputHide('hostnameInput','vm_view_tab_hostnameAlias_view');" class="m_btn_white ml10" style="padding: 4px 16px;">취소</a>
													</span>
												</div>
											</td>
										</tr>
										<tr>
											<th class="tal">생성일시</td>
											<td><span class="cnt" id="disk_view_regDatetime2"></span></td>
										</tr>
										<tr>
											<th class="tal">디스크ID</td>
											<td><span class="cnt" id="disk_view_diskId"></span></td>
										</tr>
										<tr>
											<th class="tal">디스크 TYPE</td>
											<td><span class="cnt" id="disk_type_name"></span></td>
										</tr>
									</tbody>
								</table>
							</div>


							<div class="bottomArea clearfix">
								<ul class="w30 fl dpin">
									<li>
										<p class="block mb8" id ="detail_disk_view_sizeGb"></p>
										<p class="fc11 f14">블록디스크<span>(GB)</span></p>
                       				</li>
                       			</ul>
                       		</div>

							<div class="tableE">
								<table>
									<colgroup>
										<col width="120px" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th class="tal">가상서버</td>
											<td><span id="detail_disk_view_hostnameAlias"></span></td>
										</tr>
										<tr>
											<th class="tal">호스트명</td>
											<td><span class="cnt" id="detail_disk_view_hostname"></span></td>
										</tr>
										<tr>
											<th class="tal">마운트포인트</td>
											<td><span class="cnt" id="detail_disk_view_attachments"></span></td>
										</tr>
									</tbody>
								</table>
								<p class="commnet fc-red">위 내용으로 변경 하시겠습니까?</p>
							</div>

						</div>
	                   	<div class="modal-footer tac">
	                     	<a type="button" class="m_btn_navy" href="${wasPath}/mbr/req/changeOrder/changeOrderView">변경신청</a>
                       		<a type="button" class="m_btn_white ml10" data-dismiss="modal" id ="popclose">닫기</a>
                       	</div>
	               	</div>
				</div>
			</div>

			<!-- 실시간 가용 용량 Modal -->
			<div class="modal fade" id="modal-dialog-useVolume">
				<div class="modal-dialog" >
					<div class="modal-content  width-700">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
							<h4 class="modal-title">실시간 가용 용량</h4>
						</div>
                       	<div class="modal-body" id="useVolumeTable">
							<table class="tableV">
								<colgroup>
									<col width="8%">
									<col width="*">
									<col width="16%">
									<col width="16%">
									<col width="16%">
									<col width="16%">
									<col width="16%">
								</colgroup>
								<thead>
                           			<tr>
                           				<th></th>
                           				<th>구분</th>
                           				<th>가상서버</th>
                           				<th>vCPU(Core)</th>
                           				<th>MEMORY(GB)</th>
                           				<th>DISK(GB)</th>
                           				<th>볼륨(EA)</th>
                           			</tr>
                           		</thead>
                           		<tbody>
                           			<!--
									<tr>
										<td rowspan="3" class="lh20 tac">전<br />체</td>
										<td>클라우드용량</td>
										<td class="tar">0</td>
										<td class="tar">1,200</td>
										<td class="tar">2,225</td>
										<td class="tar">15,000</td>
										<td class="tar"></td>
									</tr>
									<tr>
										<td>클라우드 사용용량</td>
										<td class="tar"></td>
										<td class="tar"></td>
										<td class="tar"></td>
										<td class="tar"></td>
										<td class="tar"></td>
									</tr>
									<tr>
										<td>클라우드가용용량</td>
										<td class="tar"></td>
										<td class="tar"></td>
										<td class="tar"></td>
										<td class="tar"></td>
										<td class="tar"></td>
									</tr>
									-->
									<tr>
										<td rowspan="3" class="lh20 bb1859 tac">프<br />로<br />젝<br />트
										</td>
										<td>프로젝트제한</td>
										<td class="tar"></td>
										<td class="tar"></td>
										<td class="tar"></td>
										<td class="tar"></td>
										<td class="tar"></td>
									</tr>
									<tr>
										<td class="fc-orange">프로젝트사용용량</td>
										<td class="tar fc-orange"></td>
										<td class="tar fc-orange"></td>
										<td class="tar fc-orange"></td>
										<td class="tar fc-orange"></td>
										<td class="tar fc-orange"></td>
									</tr>
									<tr>
										<td>실시간가용용량</td>
										<td class="tar">35</td>
										<td class="tar"></td>
										<td class="tar"></td>
										<td class="tar"></td>
										<td class="tar"></td>
									</tr>
								</tbody>
							</table>
	                   	</div>
	                   	<div class="modal-footer tac">
                      			<a type="button" class="m_btn_navy" data-dismiss="modal" id ="popclose">확인</a>
                      			<a type="button" class="m_btn_white ml10" data-dismiss="modal" id ="popclose">닫기</a>
                       	</div>
	               	</div>
				</div>
			</div>
			<!-- #modal-dialog -->
			<div class="modal fade" id="modal-snapshot">
               <div class="modal-dialog width-720">
                   <div class="modal-content width-720">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                           <h4 class="modal-title">스냅샷</h4>
                       </div>
                       <div class="modal-body">
                       <!--//검색 시작// 모달검색은 이걸 가져다 쓰면 됩니다. 2191217 nandakim-->
                       	 <div class="col-xs-12 mb20">
							<!--검색  끝//-->
								<div class="popListTable">
									<table class="tableV">
										<colgroup>
											<col width="20%">
									 		<col width="*">
									 		<col width="15%">
									 		<col width="15%">
									 	</colgroup>
									 	<thead>
								 		<tr class="skyblue">
								 			<th class="tac">디스크명</th>
											<th class="tac">스냅샷명</th>
											<th class="tac">적용신청</th>
											<th class="tac">삭제신청</th>
										</tr>
								 	   </thead>
										<tbody id="snapListTable">
										</tbody>
									</table>
								</div>


                      	</div>
                       	<div class="clear"></div>
                       	<div class="modal-footer tac">
                   			<a type="button" class="m_btn_navy" data-dismiss="modal">확인</a>
                       	</div>
                   	</div>
               	</div>
           	</div>
           </div>
			<!-- #modal-dialog -->
			<!-- #modal-dialog 결재자 지정팝업 시작 -->
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
	             			<a type=button class="lbtn" data-dismiss="modal" onclick="request_noworder();">확인</a>
	             			<a type=button class="rbtn" data-dismiss="modal">취소</a>
	                 	</div>
	             	 </div>
				</div>
	        </div>
				<!-- 결재자 지정 끝 -->

				<!-- 프로젝트 검토자 결재자 지정 팝업 시작 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="user-modal-review-dialog">
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
								<a type="button" class="whiteline" data-dismiss="modal" >닫기</a>
							</div>
						</div>
					</div>
				</div>
				<!-- 프로젝트 검토자 결재자 지정 팝업 끝 -->

				<!-- 프로젝트 승인자 결재자 지정 팝업 시작 -->
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
								<a type="button" class="whiteline" data-dismiss="modal" >닫기</a>
							</div>
						</div>
					</div>
				</div>
				<!-- 프로젝트 승인자 결재자 지정 팝업 끝-->
		</div>
		<!-- end #page-container -->

		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">
			var approvalList = [];
			// 현재 사용 용량 팝업
			function useAvailabilityDetail(projectBoxId){
				$.ajax({
					url : "${contextPath}/mbr/req/product/cloudUsageProject",
					dataType : "JSON",
					type : "GET",
					data : {
						"projectBoxId" : projectBoxId
					},
					success : function(data) {
						// 현재 사용 용량 팝업 부분
						var volumeList = data;
						var html = "";
						var allHtml = "";
						var projectHtml = "";
						$("#useVolumeTable > table").remove();
						html += "<table class='tableV'>";
				        html += "	<colgroup>";
						html += " 		<col width='8%''>";
						html += " 		<col width='*'>";
						html += " 		<col width='16%'>";
						html += " 		<col width='16%'>";
						html += " 		<col width='16%'>";
						html += " 		<col width='16%'>";
						html += " 	</colgroup>";
						html += "	<thead>";
						html += "	    <tr>";
						html += "			<th> </th>";
						html += "			<th>구분</th>";
						html += "			<th>가상서버</th>";
						html += "			<th>vCPU(Core)</th>";
						html += "			<th>MEMORY(GB)</th>";
						html += "			<th>DISK(GB)</th>";
						html += "		</tr>";
						html += "	</thead>";
						html += "	<tbody>";

						$.each(volumeList,function(key,val){
							if (val["projectBoxId"] == 'ALL') {
								/*allHtml += "		<tr>";
								allHtml += "			<td rowspan='3' class='lh20 tac'>전<br/>체</td>";
								allHtml += "			<td>클라우드 용량</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["vmTotal"])+"</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["vcpuTotal"])+"</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["memTotal"])+"</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["diskTotal"])+"</td>";
								allHtml += "		</tr>";
								allHtml += "		<tr>";
								allHtml += "			<td>클라우드 사용용량</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["vmUsed"])+"</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["vcpuUsed"])+"</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["memUsed"])+"</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["diskUsed"])+"</td>";
								allHtml += "		</tr>";
								allHtml += "		<tr>";
								allHtml += "			<td>클라우드 가용용량</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["vmAvail"])+"</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["vcpuAvail"])+"</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["memAvail"])+"</td>";
								allHtml += "			<td class='tar'>"+addcomma(val["diskAvail"])+"</td>";
								allHtml += "		</tr>";*/
							} else {
								projectHtml += "		<tr>";
								projectHtml += "			<td rowspan='3' class='lh20 bb1859 tac'>프<br/>로<br/>젝<br/>트</td>";
								projectHtml += "			<td>프로젝트 제한용량</td>";
								projectHtml += "			<td class='tar'>"+addcomma(val["vmTotal"])+"</td>";
								projectHtml += "			<td class='tar'>"+addcomma(val["vcpuTotal"])+"</td>";
								projectHtml += "			<td class='tar'>"+addcomma(val["memTotal"])+"</td>";
								projectHtml += "			<td class='tar'>"+addcomma(val["diskTotal"])+"</td>";
								projectHtml += "		</tr>";
								projectHtml += "		<tr>";
								projectHtml += "			<td class='fc-orange'>프로젝트 사용용량</td>";
								projectHtml += "			<td class='tar fc-orange'>"+addcomma(val["vmUsed"])+"</td>";
								projectHtml += "			<td class='tar fc-orange'>"+addcomma(val["vcpuUsed"])+"</td>";
								projectHtml += "			<td class='tar fc-orange'>"+addcomma(val["memUsed"])+"</td>";
								projectHtml += "			<td class='tar fc-orange'>"+addcomma(val["diskUsed"])+"</td>";
								projectHtml += "		</tr>";
								projectHtml += "		<tr>";
								projectHtml += "			<td>실시간 가용용량</td>";
								projectHtml += "			<td class='tar'>"+addcomma(val["vmAvail"])+"</td>";
								projectHtml += "			<td class='tar'>"+addcomma(val["vcpuAvail"])+"</td>";
								projectHtml += "			<td class='tar'>"+addcomma(val["memAvail"])+"</td>";
								projectHtml += "			<td class='tar'>"+addcomma(val["diskAvail"])+"</td>";
								projectHtml += "		</tr>";
							}
						});
						html += allHtml;
						html += projectHtml;
						html += "	</tbody> ";
						html += "</table>    " ;
						$("#useVolumeTable").append(html);

						$("#modal-dialog-useVolume").modal();
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}

			// 실시간 가용량 끝
			function getProjectVmInfo() {
				$.ajax({
					url : "${contextPath}/mng/oss/project/projectVmInfo",
					dataType : "JSON",
					data : {
						"projectBoxId" : $("#hid_projectBoxId").val()
					},
					success : function(data) {
						delete data.length;
						$.each(data, function(i, val){
							if(i=="diskGb"){
								$("#diskGb").text(val);
							}else if(i =="diskCn"){
								$("#diskCn").text(val);
							}
						});
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
					}
				});
			}

			//프로젝트 상세정보 조회
			function getDetail() {
				$.ajax({
					url : "${contextPath}/mbr/oss/project/detail",
					dataType : "JSON",
					data : {
						"programSeq" : $("#reqProjectSeq").val()
						,"projectBoxId" : $("#hid_projectBoxId").val()

					},
					success : function(data) {
						delete data.length;
						$.each(data, function(i, val){
							if(i != "deptName"){
								if(val != null){
									if(i=="customerId"){
										$("#hid_"+i).val(val);
									}else if(i =="keyword"){
										// 스크립트 오류로 해당 내역을 추가함(jeffrey)
									}else{
										$("#"+i).text(val);
									}
								}
								if(i == "deptName2"){
									if(val){
										$("#deptName").html(val.split("/")[1]);
										$("#deptName2").html(val.split("/")[2]);
										$("#deptName3").html(val.split("/")[3]);
									}
								}
							}
						});
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
					}
				});
			}

			// 목록 페이지이동
			function moveListPage(){
				location.href = "${contextPath}/mbr/project/disk/";
			}
			// 등록/수정페이지 이동
			function moveInsertPage(){
				var projectBoxId = $("#hid_projectBoxId").val();
				location.href = "${contextPath}/mng/oss/project/write?projectBoxId="+projectBoxId;
			}

			// 블록디스크 연결해지 Modal 조회
			function closeAttach(diskId,vmUuid,cloudId) {
				if (vmUuid == undefined) {
					$("#disk-modal-dialog").modal();
				} else {
					$("#modal-attach-cut").modal();
				}
				$("#cloudId").val(cloudId);
				$("#disk_view_diskId").val(diskId);
				$("#unconnectVmUuid").val(vmUuid);
				$("#unconnectDiskId").val(diskId);
				$.ajax({
					url : "${contextPath}/mng/oss/disk/detail",
					dataType : "JSON",
					data : {
						projectBoxId 		: $("#hid_projectBoxId").val()
						, projectName 	: $("#hid_projectName").val()
						, diskId 		: diskId
						, vmUuid : vmUuid
						, cloudId 		: $("#cloudId").val()

					},
					success : function(data) {
						delete data.length;
						$.each(data, function(key, val){

							if(val != null){
								if(key == "hourlyFlag"){
									$("#disk_view_hourlyFlag").val(val=="N"?"월단위":"시간단위");
									$("#disk_view_hourlyFlag").html(val=="N"?"월단위":"시간단위");
									$("#vm_view_tab_"+key+"_text").html(val=="N"?"월단위":"시간단위");
									//$("#vm_view_tab_hourlyFlag").val(val);
								}else if(key == "diskAlias"){
									$("#disk_view_diskAlias").val(val);
									$("#disk_view_"+key).html(val);
									$("#detail_disk_view_diskAlias").val(val);
									$("#detail_disk_view_"+key).html(val);
									$("#vm_view_tab_"+key+"_text").html(val);
								}else if(key == "size"){
									$("#disk_view_size").val(val+" GB");
									$("#disk_view_"+key).html(val+" GB");
									$("#detail_disk_view_size").val(val+" GB");
									$("#detail_disk_view_"+key).html(val+" GB");
									$("#vm_view_tab_"+key+"_text").html(val+" GB");
								}else if(key == "sizeGb"){



									$("#disk_view_"+key).html(val);
									$("#detail_disk_view_"+key).html(val);
									$("#vm_view_tab_"+key+"_text").html(val+" GB");
								}else if(key == "hostname"){
									$("#disk_view_hostname").val(val+" 에 연결");
									$("#disk_view_"+key).html(val);
									$("#detail_disk_view_hostname").val(val+" 에 연결");
									$("#detail_disk_view_"+key).html(val);
									$("#vm_view_tab_"+key+"_text").html(val);
								}else if(key == "hostnameAlias"){
									$("#disk_view_hostnameAlias").val(val);
									$("#disk_view_"+key).html(val);
									$("#detail_disk_view_hostnameAlias").val(val);
									$("#detail_disk_view_"+key).html(val);
									$("#vm_view_tab_"+key+"_text").html(val);
								}else if(key == "attachments"){
									$("#disk_view_attachments").val(val+" 에 ");
									$("#disk_view_"+key).html(val);
									$("#detail_disk_view_"+key).html(val);
									$("#vm_view_tab_"+key+"_text").html(val);
								}else if(key == "bootable"){
									$("#disk_view_bootable").val(val=="true"?"예":"아니오");
									$("#disk_view_"+key).html(val);
									$("#vm_view_tab_"+key+"_text").html(val);
								}else if(key == "diskTypeName"){
									$("#disk_type_name").html(val);
								}else if(key == "vmdkFileDatastore"){
									$("#vm_view_tab_vmdkFileDatastore_text").text(val);
		                        }else if(key == "vmdkFileLink"){
		    						$("#vm_view_tab_vmdkFileLink_text").text(val);
		                        }else{
									$("#vm_view_tab_"+key+"_text").html(val);
									$("#vm_view_tab_"+key).val(val);

									$("#disk_view_"+key).val(val);
									$("#disk_view_"+key).html(val);
									$("#detail_disk_view_"+key).val(val);
									$("#detail_disk_view_"+key).html(val);

								}


								$('#modal_projectAlias').html($('#projectAlias').html());
								$('#modal_upCompanyName').html($('#deptName').html());

								$('#modal_customerName').html($('#customerName').html());
								$('#disk_view_projectAlias').html($('#projectAlias').html());
								$('#vm_view_tab_projectAlias_text').html($('#projectAlias').html());
								$('#disk_view_upCompanyName').html($('#deptName').html());
								$('#disk_view_customerName').html($('#customerName').html());

								if(key=="size"){
									$("#disk_update_sizeGb").val(val);
									$("#disk_update_sizeGb_bak").val(val);
								}
							}
						});



					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				});
			}

			// 프로젝트 하위 블록디스크 리스트 조회
			function gridDiskList(){
				$("#disk-list").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${contextPath}/mbr/oss/disk/list"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#disk_searchKind option:selected").val();
							d.keyword = $("#disk_keyword").val();
							d.projectName = $("#hid_projectName").val();
							d.projectBoxId = $("#hid_projectBoxId").val();
							d.cloudId = $("#cloudId").val();
							d.cloudType = $("#cloudType").val();

							//d.length = "0";
						}
					}
					, "initComplete" : function(setting, json){
						if(json.recordsTotal > 0){
							$("#h5Disk1").hide();
							$("#h5Disk2").show();
						}
					}
					,"columns":[
						{"data":"diskAlias" }
						, {"data":"cloudName"}
						, {"class":"tar"}
						, {"data":"hostnameAlias" ,"class":"tal"}
						, {"data":"attachments" ,"class":"tal"}
						, {"class":"tac"}
						, {"class":"tac"}
						, {"data":"regDatetime2" , "class":"tac"}
						, {"class":"tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[2], "render": function(data,type,full) {
							return addcomma(full.sizeGb);
						}}
						, {"targets":[5], "render": function(data,type,full) {

                            if(full.cloudType == "openstack"){

                        		if(full.bootable != "true"){
    								if(full.attachments != undefined){

    									return "<a type='button' class='connect' onclick='closeAttach(\""+full.diskId+"\", \""+full.vmUuid+"\", \""+full.cloudId+"\")'><i class='fa fa-times-circle f16 fc-orange2'></i> 연결해지</a>";
    									//return "<a type='button' class='connect' onclick='restricMsg();'>연결해지</a>";
    								} else {
    									return "<a type='button' class='connect active'  onclick='openAttach(\""+full.diskId+"\",\""+full.cloudId+"\")' ><i class='fa fa-check-circle f16 fc-bluegreen'></i> 연결등록</a>";
    									//return "<a type='button' class='connect active'  onclick='restricMsg();' >연결등록</a>";
    								}
    							} else {
    								return "<a type='button' class='connect'>시스템 볼륨</a>";
    							}

                            }else  if(full.cloudType == "vmware"){
                            	if(full.bootable != "true"){
        	 	 	 	 			if(full.status == "ATTACHED"){
        	 	 	 	 				return "<a type='button' class='connect' onclick='closeAttach(\""+full.diskId+"\", \""+full.vmUuid+"\", \""+full.cloudId+"\")'><i class='fa fa-times-circle f16 fc-orange2'></i> 연결해지</a>";
        	 	 	 	 	 		} else {
        	 	 	 	 	 			//return "<a type='button' class='connect active'  onclick='restricMsg();' >연결등록</a>";
        	   							return "<a type='button' class='connect active'  onclick='openAttach(\""+full.diskId+"\",\""+full.cloudId+"\")' ><i class='fa fa-check-circle f16 fc-bluegreen'></i> 연결등록</a>";
        	 	 	 	 	 	 	}
         	 	 				} else {
          						return "<a type='button' class='connect'>시스템 볼륨</a>";
         	 	 				}
                            }

						}}
						, {"targets":[6], "render": function(data,type,full) {
							if(full.cloudType == "openstack"){
                        		if(full.bootable == "true"){
                        			return "<a type='button' class='connect' onclick='openSnapshot(\""+full.diskId+"\", \""+full.vmUuid+"\")'>스냅샷</a>";
    							}
                            }else  if(full.cloudType == "vmware"){
                            	if(full.bootable == "true"){
                            		return "<a type='button' class='connect' onclick='openSnapshot(\""+full.diskId+"\", \""+full.vmUuid+"\")'>스냅샷</a>";
         	 	 				}
                            }
						}}
						, {"targets":[8], "render": function(data,type,full){
							//return "<a href=\"#nav-pills-tab-4-view\" data-toggle=\"tab\"><button type='button' class='btn btn-grey_01' onclick='closeAttach(\""+full.diskId+"\")' ><i class='fa fa-search'></i></button></a>";
							return "<a type='button' class='cbton bton_lblue'  onclick='detailDisk(\""+full.diskId+"\", \""+full.vmUuid+"\")'><i class='fa fa-search'></i></a>";
						}}
					]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div class='data_search'><i class='fa fa-spinner fa-spin'></i> 검색중입니다. </div>"
					}
					,"sDom":'<"top">rt<"bottom"pi>'
				});
			}

					function restricMsg(){
						alertBox3("이용이 제한된 기능입니다.");
					}

					function confirmDetach(){
						 confirmBox("연결해지 하시겠습니까?"
									, actDetach
									, {
										"projectName"		: "${getOkProjectView.projectName}"
											, "projectBoxId"		: $("#hid_projectBoxId").val()
											, "diskId"			: $("#unconnectDiskId").val()
											, "vmUuid"			: $("#unconnectVmUuid").val()
											, "regUserId" 		: "${userId}"
											, "modUserId" 		: "${userId}"
										});
					}

					function actDetach(obj){

						var obj = {
								"projectName"		: $("#hid_projectName").val()
									, "projectBoxId"		: $("#hid_projectBoxId").val()
									, "diskId"			: $("#unconnectDiskId").val()
									, "vmUuid"			: $("#unconnectVmUuid").val()
									, "regUserId" 		: "${userId}"
									, "modUserId" 		: "${userId}"
									, "cloudId"			: $("#cloudId").val()
								};
						$.ajax({
							url : "${contextPath}/mng/oss/disk/detach",
							dataType : "JSON",
							data : obj,
							success : function(data) {
								if(data.errorMsg == "1"){
									alertBox3("연결해지가 요청 되었습니다.<br>요청하신 작업은 시간이 소요 됩니다. <br> 15초 뒤에 검색하여 확인 해주십시오.");
								}else{
									alertBox3(data.errorMsg);
								}
							},
							error : function(request, status, error) {
								alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
							}
						});
					}
					function attachConnect(e, vmUuid){
						$("#VM-listTable > tr").find("input").removeClass("active");
						$(e).toggleClass("active");

						$("#connectVmUuid").val(vmUuid);
					}


					function confirmAttach(){
						if($("#connectVmUuid").val()== ""){
							alertBox3("가상머신을 선택 해주십시요.")
							return false;
						}
						confirmBox("연결하시겠습니까?"
								, actAttach
								, {

								});
					}

					function actAttach(obj){
						var obj ={
								"projectName"		: $("#hid_projectName").val()
								, "diskId"			: $("#connectDiskId").val()
								, "vmUuid"			: $("#connectVmUuid").val()
								, "regUserId" 		: "${userId}"
								, "modUserId" 		: "${userId}"
								, "cloudId"			: $("#cloudId").val()
							};
						$.ajax({
							url : "${contextPath}/mng/oss/disk/attach",
							dataType : "JSON",
							data : obj,
							success : function(data) {
								if(data.errorMsg == "1"){
									$("#modal-attach").hide();
									alertBox("요청 되었습니다.", gridDiskList);
								}else{
									alertBox3(data.errorMsg);
								}
							},
							error : function(request, status, error) {
								alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
							}
						});
					}

					function openAttach(diskId,cloudId){
						//$("#pop_hid_diskId").val(diskId);
						$("#connectDiskId").val(diskId);
						$("#modal-attach").modal();
						$("#connectVmUuid").val("");
						$("#cloudId").val(cloudId);
						connectList();
						//$("#pop_attach_server option").remove();
						//$("#pop_attach_server").append('<option value="">선택</option>');

						/*
						$.ajax({
							url : "${contextPath}/mng/oss/vm/catalogueVmlist",
							dataType : "JSON",
							data : {
								projectId : $("#hid_projectId").val()
								, keyword : ""
							},
							success : function(req) {
								$.each(req.data,function(key,val){
									$("#pop_attach_server").append('<option value="'+val.vmUuid+'">'+val.hostname+' ( '+val.vmUuid+' )</option>');
								});
							},
							error : function(request, status, error) {
								alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
							}
						}); */
					}

					function closeModal(modal){
						$("#"+modal).hide();
					}


					function connectList() {
						$("#connect-list").dataTable( {
							"processing": true
							,"autoWidth": false
							,"serverSide": true
							,"ordering": false
							,"destroy" : true
							,"ajax": {
								"url":"${contextPath}/mng/oss/vm/catalogueVmlist"
								,"type" : "GET"
								,"data":function (d) {
									d.keyword = "";
									d.projectBoxId = $("#hid_projectBoxId").val();
									d.projectId = $("#hid_projectId").val();
									d.cloudId = $("#cloudId").val();
								}
							}
							,"columns":[
								{"data":"hostnameAlias" , "class":"tal"}
								,{"data":"hostname" , "class":"tal"}
								,{"data":"fixedIps" , "class":"tal"}
								,{"class":"tac lastCol"}
							]
							,"columnDefs":[
								{"defaultContent" : "", targets:"_all" }
								, {"targets":[3], "render": function(data,type,full){
									return '<div class="tac"><a href="#" data-toggle="tab"><input type="button" id="'+full.hostname
									+'" value="&#xf00c" class="popCheckbtn" onclick="attachConnect(this, \''+full.vmUuid+'\')" ></a></div>';
								}
								}
							]
							,"language": {
								"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
							}
							,"lengthMenu": [[5], ['5']]
							,"sDom":'<"top">rt<"bottom"pi>'
						});

					}

					/*
					"projectName"		: $("#hid_projectName").val()
									, "diskId"			: $("#unconnectDiskId").val()
									, "vmUuid"			: $("#unconnectVmUuid").val()
									, "regUserId" 		: "${userId}"
									, "modUserId" 		: "${userId}"
					*/

					function inputShow(hide, show, target, text){

						$("#vm_view_tab_diskNameAlias_value").val($("#disk_view_diskAlias").val());
						$("#"+target).val($("#"+text).text());
						$("#"+hide).hide();
						$("#"+show).show();
					}
					function inputHide(hide, show){
						$("#"+hide).hide();
						$("#"+show).show();
					}

					function updateHostNameAlias(){
						$.ajax({
							url : "${contextPath}/mng/oss/disk/update",
							dataType : "JSON",
							data : {
								"diskId" : $("#unconnectDiskId").val()
								, "diskAlias" : $("#vm_view_tab_diskNameAlias_value").val()
								, "regUserId" : "${userId}"
								, "modUserId" : "${userId}"
							},
							success : function(data) {
								alertBox("수정되었습니다",gridDiskList);

							},
							error : function(request, status, error) {
								alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
							}
						});
					}

					function checkBtn(obj){
					}

			function excelDown() {
				var params = "";
			    //params += "&searchKind=" + $("#disk_searchKind option:selected").val();
			    //params += "&keyword=" + $("#disk_keyword").val();
			    params += "&projectName=" + $("#hid_projectName").val();
			    params += "&projectBoxId=" + $("#hid_projectBoxId").val();
			    location.href = "${contextPath}/mbr/oss/disk/excel?"+params;
			}

			$(document).ready(function() {
				App.init();
				//프로젝트 상세정보 조회
				getDetail();
				// 프로젝트별 가용용량 조회
				getProjectVmInfo();
				// 프로젝트 하위 블록디스크 리스트 조회
				gridDiskList();

				// select box text 설정
				$(document).on("click","[class = 'btn_check stop']",function(e) {
					//$('#'+e.target.id).css("btn_check active");
					$.each($("[class = 'btn_check active']"),function(key, val){
						$(val).attr("class","btn_check stop");
					});
					$(this).attr("class","btn_check active");
				});

				//메뉴활성화
				$("#myGoods").addClass("active");
				$("#myStorage").addClass("active");
			});

			function detailDisk(diskId,vmUuid){


				$("#disk-modal-dialog").modal();
				$("#disk_view_diskId").val(diskId);
				$("#unconnectVmUuid").val(vmUuid);
				$("#unconnectDiskId").val(diskId);
				$.ajax({
					url : "${contextPath}/mng/oss/disk/detail",
					dataType : "JSON",
					data : {
						projectId 		: $("#hid_projectId").val()
						, projectName 	: $("#hid_projectName").val()
						, diskId 		: diskId
						, vmUuid : vmUuid
						, cloudId 		: $("#cloudId").val()
					},
					success : function(data) {
						delete data.length;
						$.each(data, function(key, val){

							if(val != null){
								if(key == "hourlyFlag"){
									$("#disk_view_hourlyFlag").val(val=="N"?"월단위":"시간단위");
									$("#disk_view_hourlyFlag").html(val=="N"?"월단위":"시간단위");
									$("#vm_view_tab_"+key+"_text").html(val=="N"?"월단위":"시간단위");
									//$("#vm_view_tab_hourlyFlag").val(val);
								}else if(key == "diskAlias"){
									$("#disk_view_diskAlias").val(val);
									$("#disk_view_"+key).html(val);
									$("#vm_view_tab_"+key+"_text").html(val);
								}else if(key == "size"){
									$("#disk_view_size").val(val+" GB");
									$("#disk_view_"+key).html(val+" GB");
									$("#vm_view_tab_"+key+"_text").html(val+" GB");
								}else if(key == "sizeGb"){
									$("#detail_disk_view_"+key).html(val);
									$("#vm_view_tab_"+key+"_text").html(val+" GB");
									$("#disk_view_"+key).html(val+" GB");
								}else if(key == "hostname"){
									$("#disk_view_hostname").val(val+" 에 연결");
									$("#disk_view_"+key).html(val);
									$("#vm_view_tab_"+key+"_text").html(val);
									$("#detail_disk_view_hostname").html(val);

								}else if(key == "attachments"){
									$("#disk_view_attachments").val(val+" 에 ");
									$("#disk_view_"+key).html(val);
									$("#vm_view_tab_"+key+"_text").html(val);
								}else if(key == "bootable"){
									$("#disk_view_bootable").val(val=="true"?"예":"아니오");
									$("#disk_view_"+key).html(val);
									$("#vm_view_tab_"+key+"_text").html(val);
								}else if(key == "vmdkFileDatastore"){
									$("#vm_view_tab_vmdkFileDatastore_text").text(val);
		                        }else if(key == "vmdkFileLink"){
		    						$("#vm_view_tab_vmdkFileLink_text").text(val);
		                        }else{
									$("#vm_view_tab_"+key+"_text").html(val);
									$("#vm_view_tab_"+key).val(val);

									$("#disk_view_"+key).val(val);
									$("#disk_view_"+key).html(val);

								}
								$('#modal_projectAlias').html($('#projectAlias').html());
								$('#modal_upCompanyName').html($('#upCompanyName').html());
								$('#modal_customerName').html($('#customerName').html());
								$('#disk_view_projectAlias').html($('#projectAlias').html());
								$('#disk_view_upCompanyName').html($('#upCompanyName').html());
								$('#disk_view_customerName').html($('#customerName').html());

								if(key=="size"){
									$("#disk_update_sizeGb").val(val);
									$("#disk_update_sizeGb_bak").val(val);
								}
							}
						});



					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				});
			}
			function openSnapshot(diskId,vmUuid){
				$("#modal-snapshot").modal();
				$.ajax({
					url : "${wasPath}/mbr/req/catalogue/snapshotPopList",
					dataType : "JSON",
		 			//type : "POST",
					data : {
						"diskId" : diskId,
						"vmUuid" : vmUuid
					},
					success : function(data) {
						var getSnapshots = data.getSnapshots;
						if(getSnapshots!=""){

							$("#snapListTable > tr").remove();
							$.each(getSnapshots,function(key,val){
								var Html="";

		// 						Html="<tr><td class='tac'>"+val["projectName"]+"</td>";
								Html="<tr>";
								Html = Html + "<td class='tal'>"+val["diskAlias"]+"</td>";
								Html = Html + "<td class='tal'>"+val["snapshotName"]+"</td>";
								Html = Html + "<td class='tac'><a onclick='requestSnapshot(\""+val["snapshotId"]+"\",\""+val["diskId"]+"\",\""+val["vmUuid"]+"\",\"REQTYPE_CHANGE\");' type='button' class='bton-s bton_blue'>적용신청</a></td>";
								Html = Html + "<td class='tac'><a onclick='requestSnapshot(\""+val["snapshotId"]+"\",\""+val["diskId"]+"\",\""+val["vmUuid"]+"\",\"REQTYPE_EXPR\");' type='button' class='bton-s bton_blue'>삭제신청</a></td>";
								Html = Html + "</tr>";

								$("#snapListTable").html(Html);

							});
						}else{
							$("#popListTable > tr").remove();

							var Html="";

							Html="<tr><td class='tac' colspan='3'>검색된 스냅샷이 없습니다.</td>";
							Html = Html + "</tr>";

							$("#snapListTable").html(Html);
						}

						$('#popListTable tr:odd').addClass('even');
						$('#popListTable tr:even').addClass('odd');

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
			var hSnapshotId,hDiskId,hVmUuid,hRquestType;
			function requestSnapshot(snapshotId,diskId,vmUuid,requestType){
				hSnapshotId = snapshotId;
				hDiskId = diskId;
				hVmUuid = vmUuid;
				hRequestType = requestType;
				$("#requestType").val(requestType);
				openApproveReviewModal();
			}
			function openApproveReviewModal(){
				if($("#apprvPass").val() == "Y"){
    				confirmBox4("결재자를 지정하시겠습니까?",approvSelect,nApprovSelect);
    			} else {
    				approvSelect();
    			}
			}
			function nApprovSelect(){
				$("#selectApprv").val("Y");
				if($("#requestType").val() == "REQTYPE_EXPR"){
					confirmBox("삭제 신청하시겠습니까?",request_noworder);
				}
				if($("#requestType").val() == "REQTYPE_CHANGE"){
					confirmBox("등록 신청하시겠습니까?",request_noworder);
				}
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
						, "cloudId" : $("#cloudId").val()
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
										 +'<td class="tac">'+val.userLevel+'</td>'
								 		 +'<td class="tac">'+val.userName+'</td>'
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

				var tmpValue = { "userId" : userId, "deptName" : deptName, "userName" : userName, "userLevel" : userLevel, "userLevelCode" : userLevelCode }

				$("#"+currentApprovalLine.id+"_userId").text(userId);
				$("#"+currentApprovalLine.id+"_userLevel").text(userLevel);
				$("#"+currentApprovalLine.id+"_userName").text(userName);

				approvalList[tmpCurrentApprovalStep-1] = tmpValue;

				$("#popListReviewTable > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
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

			function request_noworder(){
				//$("#catalogueform").submit();

				//$("#orderform").submit();
				if( approvalList[0] == undefined || approvalList[0] == null) {
					var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
					approvalList[0] = tmp;
				}
				$("#approvalStepListString").val(JSON.stringify(approvalList));

				var type = "POST";
				var url = "${wasPath}/mbr/req/catalogue/catalogueSnapshot";
				$.ajax({
					url:url,
					data:{
						"approvalStepListString" : $("#approvalStepListString").val()
						, "projectBoxId" : $("#projectId").val()
						, "vmUuid" : hVmUuid
						, "diskId" : hDiskId
						, "requestType" : hRequestType
						, "snapshotId" : hSnapshotId
						, "type" : "noworder"
						, "onDemandFlag" : "N"
						, "selectApprv" : $("#selectApprv").val()
						, "apprvPass" : $("#selectApprv").val()
					},
					success:function(data){
						if(data == "1"){
							alertBox("신청이 완료 되었습니다.", orderok2);
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

			function orderok2(){
				location.reload();
			}
		</script>
	</body>
</html>