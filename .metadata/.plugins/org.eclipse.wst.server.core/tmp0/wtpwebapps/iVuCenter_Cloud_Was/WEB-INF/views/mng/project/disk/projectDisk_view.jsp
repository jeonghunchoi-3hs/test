<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
</sec:authorize>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<c:import url="/WEB-INF/views/mng/include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		<input type="hidden" id="cloudId" />
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->

		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->

		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)-->
		<div id="content" class="content">
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>블록디스크</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">블록디스크 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->

				<div class="row">
			 	<div class="viewbox mb20">
				    <span class="pid" id='projectName'></span>
				 	<h3 class="pname dpin ml20" id="projectAlias"></h3>
				 	<span class="dpin fb ml20 fc-blue2">본부 : </span><span id="deptName"></span><span class="dpin fb ml40 fc-blue2">처(실) : </span><span id="deptName2"></span><span class="dpin fb ml40 fc-blue2">부서 : </span><span id="deptName3"></span><span class="dpin fb ml40 fc-blue2">담당자  : </span><span id="managerName"></span>(<span id="managerPhone"></span>)
				</div>

				<!-- Usage Status -->
				<div class="usageStatusWrap mb20">
					<strong class="titleLabel">현재 사용 용량</strong>
					<dl>
						<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>볼륨</span><span class="cnt"><em class="fc-violet" id='diskCn'></em>EA</span></dd>
						<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>블록디스크</span><span class="cnt"><em class="fc-blue" id='diskGb'></em>GB</span></dd>
						<dd class="mt30"> <a type="button" onclick="useVolumeDetail('${req.projectBoxId}');"><button class="cbton bton_blue"><i class="fa fa-battery-half ml-2"></i> </button></a></dd>

					</dl>
				</div>
				<!-- //Usage Status -->


				<!-- search begin -->
				<div class="page_searchBox m-b-15">
					<div class="searchArea">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="disk_searchKind">전체</label>
							<select class="search-sel" id="disk_searchKind">
								<option value="searchAll">전체</option>
								<option value="disk_alias">디스크명</option>
								<option value="hostname">호스트명</option>
								<!-- <option value="project_alias">프로젝트명</option>
								<option value="project_name">프로젝트ID</option> -->
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="disk_keyword" onkeypress="if(event.keyCode==13)gridDiskList();" style="width: 450px">
							<a type="button" class="bton-s bton_blue" onclick="gridDiskList()"><i class="fa fa-search"></i> 검색</a>
						</div>
					</div>
				</div>
				 <div class="gridTableWrap gridType02">
				 	<div class="tableWrap">
					 <!-- 상단 버튼  -->
					<div class="tar mb5">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue mb10"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<input type="hidden" id="hid_projectBoxId" value="${req.projectBoxId}">
					<input type="hidden" id="hid_projectName" value="${req.projectName}">
					<input type="hidden" id="hid_reqProjectSeq" value="${req.programSeq}">
					<input type="hidden" id="hid_customerId" value="">
			        <table id="disk-list" style="border-bottom: 0px none">
			        	<colgroup>
					 		<col width="*">
					 		<col width="140px">
					 		<col width="100px">
					 		<col width="240px">
					 		<col width="100px">
					 		<col width="100px">
					 		<col width="140px">
					 		<col width="140px">
					 		<col width="80px">
					 	</colgroup>
						<thead>
						    <tr class="grey">
								<th class='tac'>디스크명</th>
								<th class='tac'>클라우드</th>
								<th class='tac'>크기(GB)</th>
								<th class='tac'>가상서버</th>
								<th class='tac'>호스트명</th>
								<th class='tac'>마운트포인트</th>
								<th class='tac'>연결관리</th>
								<th class='tac'>생성일시</th>
								<th class='tac'>상세</th>
							</tr>
						</thead>
					</table>
					</div>
				</div>
				<!-- search end -->
				<div class="row tac m-t-40">
					<a type='button' class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
				</div>


			</div>
			<!-- end page-body -->
				<div class="modal fade" id="modal-attach">
	               <div class="modal-dialog">
	                   <div class="modal-content width-570">
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
									 		<col width="120px">
									 		<col width="120px">
									 		<col width="60px">
									 	</colgroup>
										<thead>
										    <tr class="grey">
												<th class='tac'>호스트명</th>
												<th class='tac'>가상서버명</th>
												<th class='tac'>IP주소</th>
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
	                       		<a type="button" class="pbton bton_blue" data-dismiss="modal" onClick="confirmAttach()">확인</a>
	                       		<a type="button" class="pbton bton_dgrey ml10" data-dismiss="modal">취소</a>
	                       	</div>
		               	</div>
	               	</div>
	           	</div>

				<div class="modal fade" id="modal-attach-cut">
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
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

							<c:if test="${req.cloudType eq 'vmware'}">
                                     <span class="serverPopLabel">파일위치</span>
									<span class="serverName f18 fc11" id=""><span id="vm_view_tab_vmdkFileLink_text"></span>
										<span class="serverPopLabel">데이터스토어</span>
									<span class="serverName f18 fc11" id=""><span id="vm_view_tab_vmdkFileDatastore_text"></span>
							</c:if>

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

				<div class="modal fade" id="disk-modal-dialog">
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">블록디스크 상세</h4>
	                       </div>
	                       <div class="modal-body">
								<div class="tableE">
									<table>
										<colgroup>
											<col width="130px" />
											<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th class="tal">프로젝트정보</td>
												<td><span id="disk_view_projectAlias"></span></td>
											</tr>
											<tr>
												<th class="tal">고객사</td>
												<td><span class="cnt nanumR" id="disk_view_customerName"></span></td>
											</tr>
											<tr>
												<th class="tal">디스크ID</td>
												<td><span class="cnt" id="disk_view_diskId"></span></td>
											</tr>
											<tr>
												<th class="tal vm">디스크명</td>
												<td>
													<span class="serverName  " id="vm_view_tab_hostnameAlias_view"><span id="disk_view_diskAlias"></span>
														<a type="button" onclick="inputShow('vm_view_tab_hostnameAlias_view','hostnameInput', 'vm_view_tab_hostnameAlias','vm_view_tab_hostnameAlias_text');" class="title_modify ml10"></a>
													</span>
													<span class="serverRename" id="hostnameInput" style="display: none;">
														<input maxlength="30" type="text" class="modiedit" id="vm_view_tab_diskNameAlias_value" data-original-title="" title="" style="width: calc(100% - 160px);">
														<a type="button" onclick="updateHostNameAlias();" class="pbton bton_blue ml10" data-dismiss="modal">수정</a>
														<a type="button" onclick="inputHide('hostnameInput','vm_view_tab_hostnameAlias_view');" class="pbton bton_dgrey">취소</a>
													</span>
												</td>
											</tr>
											<tr>
												<th class="tal">호스트명</td>
												<td><span class="cnt" id="disk_view_hostname"></span></td>
											</tr>
											<tr>
												<th class="tal">마운트포인트</td>
												<td><span class="cnt" id="disk_view_attachments"></span></td>
											</tr>
											<tr>
												<th class="tal">크기</td>
												<td><span class="cnt" id="disk_view_sizeGb"></span></td>
											</tr>
											<tr>
												<th class="tal">생성일시</td>
												<td><span class="cnt" id="disk_view_regDatetime2"></span></td>
											</tr>
											<tr>
												<th class="tal">과금단위</td>
												<td><span class="cnt" id="disk_view_hourlyFlag"></span></td>
											</tr>
										</tbody>
									</table>
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
								<!-- <table class="detail_Table">
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
								</table> -->
		                   	</div>
		                   	<div class="modal-footer tac">
                       			<a type="button" class="pbton bton_blue" data-dismiss="modal" id ="popclose">확인</a>
                       			<a type="button" class="pbton bton_dgrey ml10" data-dismiss="modal" id ="popclose">취소</a>
	                       	</div>
		               	</div>
					</div>
                 </div>
                 <!-- 실시간 가용량 팝업 END -->

            <!-- begin #footer -->
            <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">



		// 실시간 가용량 시작
		function useVolumeDetail(projectBoxId){
		$.ajax({
			url : "${contextPath}/mng/req/product/cloudUsageProject",
			dataType : "JSON",
		//		type : "POST",
			data : {
				"projectBoxId" : projectBoxId
			},
			success : function(data) {

				console.log(projectBoxId);
				var volumeList = data;
				var html = "";
				var allHtml = "";
				var projectHtml = "";

				$("#useVolumeTable > table").remove();
				html += "<table  class='tableV'>";
		        html += "	<colgroup>";
				html += " 		<col width='8%''>";
				html += " 		<col width='*'>";
				html += " 		<col width='14%'>";
				html += " 		<col width='14%'>";
				html += " 		<col width='14%'>";
				html += " 		<col width='14%'>";
				html += " 		<col width='14%'>";
				html += " 	</colgroup>";
				html += "	<thead>";
				html += "	    <tr>";
				html += "			<th> </th>";
				html += "			<th>구분</th>";
				html += "			<th>가상서버</th>";
				html += "			<th>vCPU(Core)</th>";
				html += "			<th>MEMORY(GB)</th>";
				html += "			<th>DISK(GB)</th>";
				html += "			<th>NAS(GB)</th>";
				html += "		</tr>";
				html += "	</thead>";
				html += "	<tbody>";

				$.each(volumeList,function(key,val){
					if (val["projectId"] == 'ALL') {

						allHtml += "		<tr>";
						allHtml += "			<td rowspan='3' class='lh20'>전<br/>체</td>";
						allHtml += "			<td>클라우드 용량</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["vmTotal"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["vcpuTotal"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["memTotal"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["diskTotal"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["nasTotal"])+"</td>";
						allHtml += "		</tr>";
						allHtml += "		<tr>";
						allHtml += "			<td>클라우드 사용용량</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["vmUsed"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["vcpuUsed"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["memUsed"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["diskUsed"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["nasUsed"])+"</td>";
						allHtml += "		</tr>";
						allHtml += "		<tr>";
						allHtml += "			<td>클라우드 가용용량</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["vmAvail"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["vcpuAvail"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["memAvail"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["diskAvail"])+"</td>";
						allHtml += "			<td class='tar'>"+addcomma(val["nasAvail"])+"</td>";
						allHtml += "		</tr>";


					} else {

						projectHtml += "		<tr>";
						projectHtml += "			<td rowspan='3' class='lh20'>프<br/>로<br/>젝<br/>트</td>";
						projectHtml += "			<td>프로젝트 제한용량</td>";
						projectHtml += "			<td class='tar'>"+addcomma(val["vmTotal"])+"</td>";
						projectHtml += "			<td class='tar'>"+addcomma(val["vcpuTotal"])+"</td>";
						projectHtml += "			<td class='tar'>"+addcomma(val["memTotal"])+"</td>";
						projectHtml += "			<td class='tar'>"+addcomma(val["diskTotal"])+"</td>";
						projectHtml += "			<td class='tar'>"+addcomma(val["nasTotal"])+"</td>";
						projectHtml += "		</tr>";
						projectHtml += "		<tr>";
						projectHtml += "			<td class='fc-orange'>프로젝트 사용용량</td>";
						projectHtml += "			<td class='tar fc-orange'>"+addcomma(val["vmUsed"])+"</td>";
						projectHtml += "			<td class='tar fc-orange'>"+addcomma(val["vcpuUsed"])+"</td>";
						projectHtml += "			<td class='tar fc-orange'>"+addcomma(val["memUsed"])+"</td>";
						projectHtml += "			<td class='tar fc-orange'>"+addcomma(val["diskUsed"])+"</td>";
						projectHtml += "			<td class='tar fc-orange'>"+addcomma(val["nasUsed"])+"</td>";
						projectHtml += "		</tr>";
						projectHtml += "		<tr>";
						projectHtml += "			<td>실시간 가용용량</td>";
						projectHtml += "			<td class='tar'>"+addcomma(val["vmAvail"])+"</td>";
						projectHtml += "			<td class='tar'>"+addcomma(val["vcpuAvail"])+"</td>";
						projectHtml += "			<td class='tar'>"+addcomma(val["memAvail"])+"</td>";
						projectHtml += "			<td class='tar'>"+addcomma(val["diskAvail"])+"</td>";
						projectHtml += "			<td class='tar'>"+addcomma(val["nasAvail"])+"</td>";
						projectHtml += "		</tr>";
					}

				});
				html += allHtml;
				html += projectHtml;
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

	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/oss/project/detail",
			dataType : "JSON",
			data : {
				"programSeq" : $("#reqProjectSeq").val(),
				"projectBoxId" : $("#hid_projectBoxId").val()
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
						$("#diskGb").text(addcomma(val));
					}else if(i =="diskCn"){
						$("#diskCn").text(addcomma(val));
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
		location.href = "${contextPath}/mng/project/disk/";
	}
	// 등록/수정페이지 이동
	function moveInsertPage(){
		var projectBoxId = $("#hid_projectBoxId").val();
		location.href = "${contextPath}/mng/oss/project/write?projectBoxId="+projectBoxId;
	}

	function detailDisk(diskId,vmUuid,cloudId){

		$("#disk-modal-dialog").modal();

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
				, cloudId 		: cloudId
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

	function gridDiskList(){
		$("#disk-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/disk/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#disk_searchKind option:selected").val();
					d.keyword = $("#disk_keyword").val();
					d.projectName = $("#hid_projectName").val();
					d.projectBoxId = $("#hid_projectBoxId").val();
					d.cloudId = $("#hid_cloudId").val();
					d.cloudType = $("#hid_cloudType").val();

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
				{"data":"diskAlias" , "class":"tal fstCol"}
				, {"data":"cloudName" , "class":"tac"}
				, {"class":"tac fontVdn"}
				, {"data":"hostnameAlias" ,"class":"tal fontVdn"}
				, {"data":"hostname" ,"class":"tal fontVdn"}
				, {"data":"attachments" ,"class":"tal fontVdn"}
				, {"class":"tac btnCol onwrap"}
				, {"data":"regDatetime2" , "class":"tac fontVdn"}
				, {"class":"tac lastCol onwrap"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[2], "render": function(data,type,full){
					return addcomma(full.sizeGb);
					}
				}

 				, {"targets":[6], "render": function(data,type,full){


 					if(full.cloudType == "openstack"){

                	  if(full.bootable != "true"){
   						if(full.attachments != undefined){
    						return "<a type='button' class='connect' onclick='closeAttach(\""+full.diskId+"\", \""+full.vmUuid+"\", \""+full.cloudId+"\")'><i class='fa fa-times-circle f16 fc-orange2'></i> 연결해지</a>";
   						}else{
   							//return "<a type='button' class='connect active'  onclick='restricMsg();' >연결등록</a>";
   							return "<a type='button' class='connect active'  onclick='openAttach(\""+full.diskId+"\", \""+full.cloudId+"\")' ><i class='fa fa-check-circle f16 fc-bluegreen'></i> 연결등록</a>";
   						}
  					    }else{
  						    return "<a type='button' class='connect'>시스템 볼륨</a>";
  					    }

 	 	 			}else if(full.cloudType == "vmware"){
 	 	 				if(full.bootable != "true"){
	 	 	 	 			if(full.status == "ATTACHED"){
	 	 	 	 				return "<a type='button' class='connect' onclick='closeAttach(\""+full.diskId+"\", \""+full.vmUuid+"\", \""+full.cloudId+"\")'><i class='fa fa-times-circle f16 fc-orange2'></i> 연결해지</a>";
	 	 	 	 	 		} else {
	 	 	 	 	 			//return "<a type='button' class='connect active'  onclick='restricMsg();' >연결등록</a>";
	   							return "<a type='button' class='connect active'  onclick='openAttach(\""+full.diskId+"\", \""+full.cloudId+"\")' ><i class='fa fa-check-circle f16 fc-bluegreen'></i> 연결등록</a>";
	 	 	 	 	 	 	}
 	 	 				} else {
  							return "<a type='button' class='connect'>시스템 볼륨</a>";
 	 	 				}
 	 	 			}
 				 }}
 				, {"targets":[8], "render": function(data,type,full){
					return "<a type='button' class='cbton bton_lblue'  onclick='detailDisk(\""+full.diskId+"\", \""+full.vmUuid+"\", \""+full.cloudId+"\")'><i class='fa fa-search'></i></a>";
					}
				}
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
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
						    , "cloudId"         : $("#cloudId").val()
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
					, "cloudId"         : $("#cloudId").val()
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
	function attachConnect(vmUuid){
		$("#connectVmUuid").val(vmUuid)
	}


	function confirmAttach(){
		if($("#connectVmUuid").val()== ""){
			alertBox3("가상머신을 선택 해주십시요.")
			return false;
		}
		confirmBox("연결하시겠습니까?"
				, actAttach	, {	});
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
				projectBoxId : $("#hid_projectBoxId").val()
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
					d.cloudId = $("#cloudId").val();
				}
			}
			,"columns":[
				{"data":"hostname" , "class":"tal"}
				, {"data":"hostnameAlias" , "class":"tal"}
				,{"data":"fixedIps" , "class":"tal"}
				, {"class":"tac lastCol"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[3], "render": function(data,type,full){
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

	function excelDown(){
	    var params = "";
	    params += "&searchKind=" + $("#disk_searchKind option:selected").val();
	    params += "&keyword=" + $("#disk_keyword").val();
	    params += "&projectName=" + $("#hid_projectName").val();
	    params += "&projectBoxId=" + $("#hid_projectBoxId").val();
	    location.href = "${contextPath}/mng/oss/disk/excel?"+params;
	}

	$(document).ready(function() {
		App.init();
		getDetail();
		gridDiskList();
		getProjectVmInfo();
		// select box text 설정
		$(document).on("click","[class = 'btn_check stop']",function(e) {
			//$('#'+e.target.id).css("btn_check active");
			$.each($("[class = 'btn_check active']"),function(key, val){
				$(val).attr("class","btn_check stop");
			});
			$(this).attr("class","btn_check active");
		});
		//메뉴활성화
		$("#project").addClass("active");
		$("#projectDisk").addClass("active");
	});

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
</script>
</body>
</html>