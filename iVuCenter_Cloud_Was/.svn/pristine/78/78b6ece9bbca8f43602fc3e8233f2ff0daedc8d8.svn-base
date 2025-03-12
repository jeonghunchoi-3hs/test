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
			<!-- begin #header -->
			<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->
			<!-- begin #sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #content -->
			<div id="content" class="content">

				 <p class="page_title">개발환경
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원현황  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/project/service/">개발환경 </a></b> <span class="arrow_ab"> &#8227; </span> <b>개발환경 상세 </b>
			    </span>
				</p>

				<!-- begin page-body -->
				<div class="row p20 bgwh br10">
						<%--  <table class="tableH4">
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
									<th colspan="8" class="f18"><%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>"); %>
									<span class="pid" id='projectName'></span>
									<h3 class="pname dpin ml20" id="projectAlias"></h3></th>
								</tr>
								<tr>
									<td class="point tac">본부</td>
									<td id="deptName"></td>
									<td class="point tac">처(실)</td>
									<td id="deptName2"></td>
									<td class="point tac">부서</td>
									<td id="deptName3"></td>
									<td class="point tac">담당자</td>
									<td id="managerName"> (<span id="managerTel"></span>)</td>
								</tr>
								<tr>
									<th colspan="8">
									<!--  현재 사용 용량 -->
										<div class="usageStatusWrap mt20">
											<strong class="titleLabel">현재 사용 용량</strong>
											<dl>
												<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>계정관리</span><span class="cnt"><em class="fc-orange" id="serviceTypeAccount">0</em></span></dd>
												<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>보안관제</span><span class="cnt"><em class="fc-violet" id="serviceTypeSecurity">0</em></span></dd>
												<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>백업관리</span><span class="cnt"><em class="fc-blue" id="serviceTypeBackup">0</em></span></dd>
												<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>SW설치</span><span class="cnt"><em class="fc-green" id="serviceTypeSw">0</em></span></dd>
												<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>디스크관리</span><span class="cnt"><em class="fc-orange" id="serviceTypeDisk">0</em></span></dd>
												<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>오토스케일</span><span class="cnt"><em class="fc-orange" id="serviceTypeAutoscale">0</em></span></dd>
												<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>APP재배포</span><span class="cnt"><em class="fc-orange" id="serviceTypeApplicationRedistribution">0</em></span></dd>

											</dl>
										</div>
									</th>
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
            	     <!-- <div class="col-md-12 pl0 pr0 mt20">
            	     <h4 class="f16 mb10 f500 mb20">현재 사용량  </h4>
            	     <div class="col-md-2 sub_use_service">계정관리 <span class="flr"><em class="fc_orange_im f24 mr5" id="serviceTypeAccount">0</em> EA</span> </div>
            	     <div class="col-md-2 sub_use_service">보안관제 <span class="flr"><em class="fc_purple_im f24 mr5" id="serviceTypeSecurity">0</em>EA</span></div>
            	     <div class="col-md-2 sub_use_service">백업관리 <span class="flr"><em class="fc_blue_im f24 mr5" id="serviceTypeBackup">0</em>EA</span></div>
            	     <div class="col-md-2 sub_use_service">SW설치  <span class="flr"><em class="fc_green_im f24 mr5" id="serviceTypeSw">0</em>EA</span></div>
            	     <div class="col-md-2 sub_use_service" style="margin-right:0;float:right;">디스크관리 <span class="flr"><em class="fc_navy_im f24 mr5" id="serviceTypeDisk">0</em>EA</span></div>

            	     <div class="col-md-12 pl0 pr0 mt10">
            	     <div class="col-md-2 sub_use_service">오토스케일 <span class="flr"><em class="fc_orange_im f24 mr5" id="serviceTypeAutoscale">0</em> EA</span> </div>
            	     <div class="col-md-2 sub_use_service">App재배포<span class="flr"><em class="fc_purple_im f24 mr5" id="serviceTypeApplicationRedistribution">0</em>EA</span></div>
            	     <div class="col-md-2 sub_use_service">Container Terminal<span class="flr"><em class="fc_purple_im f24 mr5" id="serviceTypeContainerTerminal">0</em>EA</span></div>
            	     </div>


            	     </div> -->
            	   </div>

					<div class="clear"></div>




						<!-- search begin -->
		<!-- 				<div class="page_searchBox m-b-15">
							<div class="searchArea">
								<div class="selectBox" style="width:130px;">
									<label class="selectText" for="disk_searchKind">전체</label>
									<select class="search-sel" id="disk_searchKind">
										<option value="searchAll">전체</option>
										<option value="disk_alias">디스크명</option>
										<option value="hostname">호스트명</option>
										<option value="project_alias">프로젝트명</option>
										<option value="project_name">프로젝트ID</option>
									</select>
								</div>
								<div class="inputArea m-l-5">
									<input type="text" placeholder="검색어를 입력하세요" id="disk_keyword" onkeypress="if(event.keyCode==13)gridDiskList();" style="width: 634px">
									<a type="button" class="btn_search" onclick="gridDiskList()">검색</a>
								</div>
							</div>
						</div> -->



						<!-- 상단 버튼  -->
						<div class="tar mt20" style="margin-bottom:-40px;">
							<a onclick="excelDown();" type='button' class="btn_navy-s"><img src="${apachePath}/resources/assets/img/icon_down.svg" height="18px;"/>  엑셀 다운로드</a>
						</div>
						<!-- //상단 버튼  -->

						 <div class="gridTableWrap gridType02 mt20">


							<input type="hidden" id="hid_projectBoxId" value="${req.projectBoxId}">
							<input type="hidden" id="hid_projectId" value="${req.projectId}">
							<input type="hidden" id="hid_projectName" value="${req.projectName}">
							<input type ="hidden" id ="reqProjectSeq"  value="${req.programSeq}">
							<input type="hidden" id="hid_customerId" value="">
					        <table id="env-list" class="tableV">
									<colgroup>
										<col width="10%">
										<col width="15%">
										<col width="*">
										<col width="15%">
										<col width="15%">
										<col width="5%">

									</colgroup>
									<thead>
										<tr>
											<th>cicd그룹명</th>
											<th>cicd개발환경명</th>
											<th>개발환경 Url</th>
											<th>관리자</th>
											<th>생성일시</th>
											<th>상세</th>
										</tr>
									</thead>
								</table>


						</div>
						<!-- search end -->
						<div class="flr mt-30">
							<a type="button" class="btn_dgrey" onclick="moveListPage();">목록</a>
						</div>


					</div>
					<!-- end page-body -->
						<div class="modal fade" id="modal-attach">
			               <div class="modal-dialog">
			                   <div class="modal-content w560">
			                       <div class="modal-header">
			                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
			                           <h4 class="modal-title">블록디스크 연결등록</h4>
			                       </div>
			                       <div class="modal-body">
			                       		<div class="page_searchBox m-b-20">
											<div class="searchArea">
												<div class="inputArea m-l-5">
													<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword"  data-original-title="" title="" style="width: 362px">
													<a type="button" class="btn_search" onclick="connectList();">검색</a>
												</div>
											</div>
										</div>
										<div>
											<table class="detail_Table" id="connect-list">
									        	<colgroup>
											 		<col width="*">
											 		<col width="210px">
											 		<col width="65px">
											 	</colgroup>
												<thead>
												    <tr class="grey">
														<th class='tac'>호스트명</th>
														<th class='tac'>서버명</th>
														<th class='tac'>적용</th>
													</tr>
												</thead>
												<!-- <tbody>
													<tr>
														<td class="tal fontVdn fstCol">nhbank_opstack_create</td>
														<td class="tal fontVdn">콜센터서버</td>
														<td class="tac lastCol"><a></a></td>
													</tr>
												</tbody> -->
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
													<span class="company_labelf">본사 :</span><span class="company_cont"  id="modal_upCompanyName"></span>
													<span class="company_label">고객사 :</span><span class="company_cont"  id="modal_customerName"></span>
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
			                       		<a type="button" class="lbtn" data-dismiss="modal" onClick="confirmDetach()">확인</a>
			                       		<a type="button" class="rbtn" data-dismiss="modal" onClick ="closeModal('modal-attach-cut')">취소</a>
			                       	</div>
				               	</div>
							</div>
		                 </div>

						<div class="modal fade" id="disk-modal-dialog">
							<div class="modal-dialog">
			                   <div class="modal-content w560">
			                       <div class="modal-header">
			                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
			                           <h4 class="modal-title">블록디스크 상세</h4>
			                       </div>
			                       <div class="modal-body">
			                       		<div class="client_DetailBg m-b-20 txtAleft">
											<div class="client_DetailArea">
												<h2 class="blueBoxTitle">프로젝트정보</h2>
												<p class="company_Name2" id="disk_view_projectAlias"></p>
												<p class="company_Info m-b-25">
													<span class="company_labelf">본사 :</span><span class="company_cont"  id="disk_view_upCompanyName"></span>
													<span class="company_label">고객사 :</span><span class="company_cont" id="disk_view_customerName"></span>
												</p>
											</div>
										</div>

			                       		<div class="topArea txtAleft">
											<p class="fl m-b-10">
												<span class="serverPopLabel">디스크명</span>
												<span class="serverName f18 fc11" id="vm_view_tab_hostnameAlias_view"><span id="disk_view_diskAlias"></span>
													<a type="button" onclick="inputShow('vm_view_tab_hostnameAlias_view','hostnameInput', 'vm_view_tab_hostnameAlias','vm_view_tab_hostnameAlias_text');" class="title_modify"></a>
												</span>
												<span class="serverRename" id="hostnameInput" style="display: none;">
													<input type="text" class="modiedit" id="vm_view_tab_diskNameAlias_value" data-original-title="" title="">
													<a type="button" onclick="updateHostNameAlias();" class="modisave" data-dismiss="modal"></a>
													<a type="button" onclick="inputHide('hostnameInput','vm_view_tab_hostnameAlias_view');" class="modicancel"></a>
												</span>
											</p>
											<p class="fl cb mt-3">
												<span class="serverPopLabel">디스크ID</span>
												<span class="hostName2 f18 fc11 fontVdn" id="disk_view_diskId"></span>
											</p>
			                       		</div>

			                       		<div class="networkListWrap clearfix">
											<p class="m-b-10"><span class="serverPopLabel">호스트명</span><span class="fixedNetwork2 p-l-5" id="disk_view_hostname"></span></p>
											<p class="cb mt-3"><span class="serverPopLabel">마운트포인트</span><span class="fixedNetwork2 p-l-5" id="disk_view_attachments"></span></p>
										</div>

										<div class="bottomArea clearfix">
			                       			<div class="bottomAreaDetail tal clearfix">
			                       				<ul>
			                       					<li class=""><span class="doubledotte">크기</span><span class="fontVdn f16" id="disk_view_sizeGb"></span></li>
			                       					<li class=""><span class="doubledotte">생성일시</span><span class="fontVdn f16" id="disk_view_regDatetime2"></span></li>
			                       					<li class=""><span class="doubledotte">과금단위</span><span class="fontVdn f16" id="disk_view_hourlyFlag"></span></li>
			                       				</ul>
			                       			</div>
			                       		</div>
				                   	</div>
				                   	<div class="modal-footer tac">
			                       		<a type="button" class="whiteline" data-dismiss="modal" id ="popclose">닫기</a>
			                       	</div>
				               	</div>
							</div>
		                 </div>


		                  <!-- 실시간 가용 용량 팝업 -->
						<div class="modal fade" id="modal-dialog-useVolume">
							<div class="modal-dialog width-800" >
								<div class="modal-content">
									<div class="modal-header">
		 								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
										<h4 class="modal-title">실시간 가용 용량</h4>
									</div>
			                       	<div class="modal-body useVolumeTable" id="useVolumeTable">
										<table class="detail_Table">
								        	<colgroup>
										 		<col width="*">
										 		<col width="100x">
										 		<col width="100px">
										 		<col width="100px">
										 		<col width="100px">
										 	</colgroup>
											<thead>
											    <tr>
													<th>구분</th>
													<th>가상서버</th>
													<th class='fontVdn'><span class="fontVdn">vCPU</span><br/><span class="fontN">(Core)</span></th>
													<th class='fontVdn'><span class="fontVdn">MEMORY</span><br/><span class="fontN">(GB)</span></th>
													<th class='fontVdn'><span class="fontVdn">DISK</span><br/><span class="fontN">(GB)</span></th>
												</tr>
											</thead>
											<tbody>
												<!--
												<tr>
													<td class="leftHead tal">클라우드<br/>용량</td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn lastCol"></td>
												</tr>
												<tr>
													<td class="leftHead tal">클라우드<br/>사용용량</td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn lastCol"></td>
												</tr>
												<tr>
													<td class="leftHead tal">클라우드<br/>가용용량</td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn lastCol"></td>
												</tr>
												-->
												<tr>
													<td class="leftHead tal">프로젝트<br/>제한</td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn lastCol"></td>
												</tr>
												<tr>
													<td class="leftHead tal">프로젝트<br/>사용용량</td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn lastCol"></td>
												</tr>
												<tr class="sumRow b-b99" >
													<td class="leftHead tal">실시간<br/>가용용량</td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn"></td>
													<td class="tar fontVdn lastCol"></td>
												</tr>
											</tbody>
										</table>
				                   	</div>
				                   	<div class="modal-footer tac">
		                       			<a type="button" class="lbtn" data-dismiss="modal" id ="popclose">확인</a>
		                       			<a type="button" class="rbtn" data-dismiss="modal" id ="popclose">취소</a>
			                       	</div>
				               	</div>
							</div>
		                 </div>



		                 	<!--서비스 상세 modal-dialog 시작-->

						<div class="modal fade" id="env-modal-dialog">
							<div class="modal-dialog">
			                   <div class="modal-content w560">
			                       <div class="modal-header">
			                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
			                           <h4 class="modal-title">개발환경 상세</h4>
			                       </div>
			                       <div class="modal-body">

			                       		<div class="topArea txtAleft">
			                       			<%-- <p class="fl m-b-10">
												<span class="serverPopLabel">클라우드</span>
												<span class="hostName2 f14 fc11 fontVdn" id="tabCloudName"></span>
												<span class="pop_pid flr" id="infoProjectName">${req.projectName}</span>
											</p> --%>
											<p class="fl m-b-10">
												<span class="serverPopLabel">그룹명</span>
												<span class="hostName2 f14 fc11 fontVdn" id="cicdGroupName"></span>
											</p>
											<p class="fl m-b-10">
												<span class="serverPopLabel">그룹 Path</span>
												<span class="hostName2 f14 fc11 fontVdn" id="cicdGroupPath"></span>
											</p>
											<p class="fl m-b-10">
												<span class="serverPopLabel">개발환경 Url	</span>
												<span class="hostName2 f14 fc11 fontVdn" id="cicdUrl"></span>
											</p>
											<p class="fl m-b-10">
												<span class="serverPopLabel">내용</span>
												<span class="hostName2 f14 fc11 fontVdn" id="description"></span>
											</p>
			                       		</div>

										<div id="envUserList">
										</div>

				                   	</div>
				                   	<div class="modal-footer tac">
			                       		<a type="button" class="rbtn" data-dismiss="modal" id ="popclose">닫기</a>
			                       	</div>
				               	</div>
							</div>
		                 </div>
						<!--서비스 상세 modal-dialog 끝-->


		                 <!-- 실시간 가용량 팝업 END -->


					<!-- begin #footer -->
					<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
					<!-- end #footer -->

				</div>
				<!-- end #content -->
			</div>
			<!-- end page container -->

		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

		<script type="text/javascript">
			function detailEnv(cicdProjectId){
				$("#env-modal-dialog").modal();
				$.ajax({
					url : "${contextPath}/mbr/application/env/mbrEnvDetailInfo",
					dataType : "JSON",
					data : {
						cicdProjectId : cicdProjectId
					},
					success : function(data) {
						delete data.length;
						$.each(data, function(key, val){
							if(val != null) {
								if(key == "cicdGroupName"){
									$("#cicdGroupName").val(val);
									$("#cicdGroupName").html(val);
								}else if(key == "cicdGroupPath"){
									$("#cicdGroupPath").val(val);
									$("#cicdGroupPath").html(val);
								}else if(key == "url"){
									$("#cicdUrl").val(val);
									$("#cicdUrl").html(val);
								}else if(key == "description"){
									$("#description").val(val);
									$("#description").html(val);
								}
							}
						});
// 						$("#tabCloudName").html(cloudName);
						// 개발자 리스트 함수
						gridEnvUserList(data.cicdProjectId);
					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				});
			}

			function gridEnvUserList(cicdProjectId){
				$.ajax({
					url : "${contextPath}/mbr/application/env/mbrEnvUserList",
					dataType : "JSON",
					type : "GET",
					data : {
						cicdProjectId : cicdProjectId
					},
					success : function(data) {
						var html = "";
						html += "<table class='tableV'>";
				        html += "	<colgroup>";
						html += " 		<col width='15%'>";
						html += " 		<col width='*'>";
						html += " 		<col width='15%'>";
						html += " 	</colgroup>";
						html += "	<thead>";
						html += "	    <tr>";
						html += "			<th>유저명</th>";
						html += "			<th>이메일</th>";
						html += "			<th>권한</th>";
						html += "		</tr>";
						html += "	</thead>";
						html += "	<tbody>";
						$.each(data, function(key, val){
							html += "		<tr>";
							html += "			<td class='tac'>"+val["alias"]+"</td>";
							html += "			<td class='tac'>"+val["userEmail"]+"</td>";
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

					function getProjectServiceInfo() {
						$.ajax({
							url : "${contextPath}/mng/oss/project/projectServiceInfo",
							dataType : "JSON",
							data : {
								"projectId" : $("#hid_projectId").val(),
								"projectBoxId" : $("#hid_projectBoxId").val()
							},
							success : function(data) {
								delete data.length;

								$.each(data, function(i, val){

									if(i=="serviceTypeAccount"){
										$("#serviceTypeAccount").text(val);
									}else if(i =="serviceTypeSecurity"){
										$("#serviceTypeSecurity").text(val);
									}else if(i =="serviceTypeBackup"){
										$("#serviceTypeBackup").text(val);
									}else if(i =="serviceTypeSw"){
										$("#serviceTypeSw").text(val);
									}else if(i =="serviceTypeDisk"){
										$("#serviceTypeDisk").text(val);
									}else if(i =="serviceTypeAutoscale"){
										$("#serviceTypeAutoscale").text(val);
									}else if(i =="serviceTypeApplicationRedistribution"){
										$("#serviceTypeApplicationRedistribution").text(val);
									}else if(i =="serviceTypeCt"){
										$("#serviceTypeContainerTerminal").text(val);
									}

								});
							},
							error : function(request, status, error) {
								alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
							}
						});
					}


					// 실시간 가용량 시작
					function useVolumeDetail(projectId){
					$.ajax({
						url : "${contextPath}/mng/req/product/cloudUsageProject",
						dataType : "JSON",
					//		type : "POST",
						data : {
							"projectId" : projectId
						},
						success : function(data) {

							var volumeList = data;
							var html = "";

							$("#useVolumeTable > table").remove();
							html += "<table class=\"detail_Table\">";
					        html += "	<colgroup>";
							html += " 		<col width=\"*\">";
							html += " 		<col width=\"100x\">";
							html += " 		<col width=\"100px\">";
							html += " 		<col width=\"100px\">";
							html += " 		<col width=\"100px\">";
							html += " 	</colgroup>";
							html += "	<thead>";
							html += "	    <tr>";
							html += "			<th>구분</th>";
							html += "			<th>가상서버</th>";
							html += "			<th class='fontVdn'><span class=\"fontVdn\">vCPU</span><br/><span class=\"fontN\">(Core)</span></th>";
							html += "			<th class='fontVdn'><span class=\"fontVdn\">MEMORY</span><br/><span class=\"fontN\">(GB)</span></th>";
							html += "			<th class='fontVdn'><span class=\"fontVdn\">DISK</span><br/><span class=\"fontN\">(GB)</span></th>";
							html += "		</tr>";
							html += "	</thead>";
							html += "	<tbody>";

							$.each(volumeList,function(key,val){
								if (val["projectId"] == 'ALL') {
									/*
									html += "		<tr>";
									html += "			<td class=\"leftHead tal\">클라우드<br/>용량</td>";
									html += "			<td class=\"tar fontVdn\">-</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["vcpuTotal"])+"</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["memTotal"])+"</td>";
									html += "			<td class=\"tar fontVdn lastCol\">"+addcomma(val["diskTotal"])+"</td>";
									html += "		</tr>";
									html += "		<tr>";
									html += "			<td class=\"leftHead tal\">클라우드<br/>사용용량</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["vmUsed"])+"</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["vcpuUsed"])+"</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["memUsed"])+"</td>";
									html += "			<td class=\"tar fontVdn lastCol\">"+addcomma(val["diskUsed"])+"</td>";
									html += "		</tr>";
									html += "		<tr>";
									html += "			<td class=\"leftHead tal\">클라우드<br/>가용용량</td>";
									html += "			<td class=\"tar fontVdn\">-</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["vcpuAvail"])+"</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["memAvail"])+"</td>";
									html += "			<td class=\"tar fontVdn lastCol\">"+addcomma(val["diskAvail"])+"</td>";
									html += "		</tr>";
									*/
								} else {
									html += "		<tr>";
									html += "			<td class=\"leftHead tal\">프로젝트<br/>제한용량</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["vmTotal"])+"</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["vcpuTotal"])+"</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["memTotal"])+"</td>";
									html += "			<td class=\"tar fontVdn lastCol\">"+addcomma(val["diskTotal"])+"</td>";
									html += "		</tr>";
									html += "		<tr>";
									html += "			<td class=\"leftHead tal\">프로젝트<br/>사용용량</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["vmUsed"])+"</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["vcpuUsed"])+"</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["memUsed"])+"</td>";
									html += "			<td class=\"tar fontVdn lastCol\">"+addcomma(val["diskUsed"])+"</td>";
									html += "		</tr>";
									html += "		<tr class=\"sumRow b-b99\">";
									html += "			<td class=\"leftHead tal\">실시간<br/>가용용량</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["vmAvail"])+"</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["vcpuAvail"])+"</td>";
									html += "			<td class=\"tar fontVdn\">"+addcomma(val["memAvail"])+"</td>";
									html += "			<td class=\"tar fontVdn lastCol\">"+addcomma(val["diskAvail"])+"</td>";
									html += "		</tr>";
								}

							});
							html += "	</tbody>                                                                                                     ";
							html += "</table>                                                                                                        " ;
							$("#useVolumeTable").append(html);

							$("#modal-dialog-useVolume").modal();
						},
						error : function(request, status, error) {
							alertBox3("code:" + request.status + "\n" + "error:" + error);
						}
					});
					}

					// 실시간 가용량 끝

					/* function getProjectVmInfo() {
						$.ajax({
							url : "${contextPath}/mng/oss/project/projectVmInfo",
							dataType : "JSON",
							data : {
								"projectId" : $("#hid_projectId").val()
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
					} */

			// 서비스자원 이용현황 상세조회
			function getDetail() {
				$.ajax({
					url : "${contextPath}/mng/oss/project/detail",
					dataType : "JSON",
					data : {
						"projectId" : $("#hid_projectId").val() ,
						"projectBoxId" : $("#hid_projectBoxId").val()
					},
					success : function(data) {
						delete data.length;
						$.each(data, function(i, val){
							if(val != null){
								if(i != "deptName"){
									if(i=="customerId"){
										$("#hid_"+i).val(val);
									}else if(i =="keyword"){
										// 스크립트 오류로 해당 내역을 추가함(jeffrey)
									}else{
										$("#"+i).text(val);
									}
									if(i == "deptName2"){
										if(val){
											$("#deptName").html(val.split("/")[1]);
											$("#deptName2").html(val.split("/")[2]);
											$("#deptName3").html(val.split("/")[3]);
										}
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
				location.href = "${contextPath}/mbr/project/service/";
			}
			// 등록/수정페이지 이동
			function moveInsertPage(){
				var projectId = $("#hid_projectId").val();
				location.href = "${contextPath}/mng/oss/project/write?projectId="+projectId;
			}

					function detailDisk(diskId,vmUuid){

						if (vmUuid == undefined)
						$("#disk-modal-dialog").modal();
						else
						$("#modal-attach-cut").modal();

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
											$("#vm_view_tab_"+key+"_text").html(val+" GB");
											$("#disk_view_"+key).html(val+" GB");
										}else if(key == "hostname"){
											$("#disk_view_hostname").val(val+" 에 연결");
											$("#disk_view_"+key).html(val);
											$("#vm_view_tab_"+key+"_text").html(val);
										}else if(key == "attachments"){
											$("#disk_view_attachments").val(val+" 에 ");
											$("#disk_view_"+key).html(val);
											$("#vm_view_tab_"+key+"_text").html(val);
										}else if(key == "bootable"){
											$("#disk_view_bootable").val(val=="true"?"예":"아니오");
											$("#disk_view_"+key).html(val);
											$("#vm_view_tab_"+key+"_text").html(val);
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

					function gridEnvList(){
						$("#env-list").dataTable( {
							"processing": true
							,"autoWidth": false
							,"serverSide": true
							,"ordering": false
							,"destroy" : true
							,"ajax": {
								"url":"${contextPath}/mbr/application/env/projectEnvList"
								,"type" : "GET"
								,"data":function (d) {
// 									d.searchKind = $("#vm_searchKind option:selected").val();
// 									d.keyword = $("#vm_keyword").val();
									d.projectBoxId = $("#hid_projectBoxId").val();
									d.projectId = $("#hid_projectId").val();
									d.projectName = $("#hid_projectName").val();
								}
							}
							,"columns":[
								{"data":"cicdGroupName", "class":"tac" }
								, {"data":"cicdProjectName", "class":"tac"}
								, {"data":"url", "class":"tac" }
								, {"data":"devUserName", "class":"tac" }
								, {"data":"regDatetime2" , "class":"tac"}
							]
							,"columnDefs":[
								{"defaultContent" : "", targets:"_all" }

				 				, {"targets":[5], "render": function(data,type,full){
				 					return '<a href="javascript:detailEnv(\''+full.cicdProjectId+'\');" class="cbton bton_lblue" onclick=""><i class="fa fa-search"></i></a>';
									//return "<a href='#nav-pills-tab-3-view' data-toggle='tab'><button type='button' class='btn btn-grey_01' onclick='detailVM(\""+full.vmUuid+"\")' ><i class='fa fa-search'></i></button></a>";
									}
								}
							]
							,"language": {
								"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
								, "processing":"<div class='data_search'><i class='fa fa-spinner fa-spin'></i> 검색중입니다. </div>"
							}
							,"sDom":'<"top"i>rt<"bottom"p>'
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
											, "projectId"		: $("#hid_projectId").val()
											, "diskId"			: $("#unconnectDiskId").val()
											, "vmUuid"			: $("#unconnectVmUuid").val()
											, "regUserId" 		: "${userId}"
											, "modUserId" 		: "${userId}"
										});
					}

					function actDetach(obj){

						var obj = {
								"projectName"		: $("#hid_projectName").val()
									, "projectId"		: $("#hid_projectId").val()
									, "diskId"			: $("#unconnectDiskId").val()
									, "vmUuid"			: $("#unconnectVmUuid").val()
									, "regUserId" 		: "${userId}"
									, "modUserId" 		: "${userId}"
								};
						$.ajax({
							url : "${contextPath}/mng/oss/disk/detach",
							dataType : "JSON",
							data : obj,
							success : function(data) {
								if(data.errorMsg == "1"){
									alertBox("연결해지가 요청 되었습니다.<br>요청하신 작업은 시간이 소요 됩니다. <br> 15초 뒤에 검색하여 확인 해주십시오.", aa);
								}else{
									alertBox3(data.errorMsg);
								}
							},
							error : function(request, status, error) {
								alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
							}
						});
					}
					function attachConnect(vmUuid){
						$("#connectVmUuid").val(vmUuid)
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

					function openAttach(diskId){
						//$("#pop_hid_diskId").val(diskId);
						$("#connectDiskId").val(diskId);
						$("#modal-attach").modal();
						$("#connectVmUuid").val("");
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
									d.projectId = $("#hid_projectId").val();
								}
							}
							,"columns":[
								{"data":"hostname" , "class":"tal"}
								, {"data":"hostnameAlias" , "class":"tal"}
								, {"class":"tac lastCol"}
							]
							,"columnDefs":[
								{"defaultContent" : "", targets:"_all" }
								, {"targets":[2], "render": function(data,type,full){
									return "<a href='javascript:attachConnect(\""+full.vmUuid+"\");' class='btn_check stop' id ='"+full.hostname+"' ></a>";
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

			function excelDown(){
			    var params = "";
			    params += "&projectBoxId=" + $("#hid_projectBoxId").val();
			    location.href = "${contextPath}/mbr/application/env/envViewExcel?"+params;
			}

			$(document).ready(function() {
				App.init();
				// 서비스자원 이용현황 상세조회
				getDetail();
				// 프로젝트 하위 서비스 리스트 조회
				gridEnvList();

				getProjectServiceInfo();

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
				$("#myEnvList").addClass("active");
			});
		</script>
	</body>
</html>