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
			<!-- begin #page-container > sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

		    <input type ="hidden" id ="instanceType"  value="${req.instanceType}">

			<!-- begin #page-container > content -->
			<div id="content" class="content">


				 <p class="page_title"><span id="titleText"></span>
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원현황  <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/project/vm/">가상서버</a>  <span class="arrow_ab"> &#8227; </span> <b><span id="titleLinkText"></span></b>
			    </span>
				</p>

				<!-- begin content > page-body -->
				<div class="row p20 bgwh br10">

					<input type ="hidden" id ="hid_projectBoxId"  value="${req.projectBoxId}">
					<input type ="hidden" id ="hid_projectId"  value="">
					<input type ="hidden" id ="hid_projectName"  value="${req.projectName}">
					<input type ="hidden" id ="reqProjectSeq"  value="${req.programSeq}">
					<input type ="hidden" id ="cloudId">
					<input type ="hidden" id ="hostUuid">
					<input type ="hidden" id ="targetUuid"  >
					<input type ="hidden" id ="targetAct"  >
					<input type ="hidden" id ="vmUuid"  >

					<!-- 프로젝트 정보 & 현재 사용용량 시작
					<div class="viewbox mb20">
					    <!-- 프로젝트 상세정보
				 	    <span class="pid" id='projectName'></span>
					 	<h3 class="pname dpin ml20" id="projectAlias"></h3><a type='button' class="bton-s bton_blue dpin ml40"><i class="fa fa-file-text-o"></i> <span> 프로젝트 정의서 </span></a>
					 	<div class="mt20">
					 		<span class="dpin fb fc-blue2">본부 : </span> <span id="deptName"></span><span class="dpin fb ml40 fc-blue2">처(실) : </span> <span id="deptName2"></span><span class="dpin fb ml40 fc-blue2">부서 : </span> <span id="deptName3"></span><span class="dpin fb ml40 fc-blue2">담당자  : </span> <span id="managerName"></span>(<span id="managerTel"></span>)
					 	</div>

						<!-- 현재 사용 용량
					 	<div class="usageStatusWrap mt20">
							<strong class="titleLabel">현재 사용 용량</strong>
							<dl>
								<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>가상서버</span><span class="cnt"><em class="fc-orange" id="instances"></em>EA</span></dd>
								<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>vCpu</span><span class="cnt"><em class="fc-violet" id="cores"></em>Core</span></dd>
								<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>MEMORY</span><span class="cnt"><em class="fc-blue" id="ram"></em>GB</span></dd>
								<!--<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>DISK</span><span class="cnt"><em class="fc-green" id="volumes"></em>GB</span></dd>
								<!--<dd class="mt50"> <a href="#modal-dialog2" data-toggle="modal"><button class="cbton bton_blue"><i class="fa fa-battery-half ml-2"></i> </button></a></dd>
								<dd class="mt30"> <a type="button" onclick="useAvailabilityDetail('${req.projectId}');"><button class="cbton bton_blue"><i class="fa fa-battery-half ml-2"></i> </button></a></dd>
							</dl>
						</div>

					</div>
					<!-- 프로젝트 정보 & 현재 사용용량 끝 -->


				 <div class="col-md-12 pl0 pr0">
            	   <div class="col-md-12 pl0">
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
            	     <h4 class="f16 mb10 f500 mb20 flex align-center gap10">현재 사용량 <a type="button" onclick="useAvailabilityDetail('${req.projectBoxId}');" class="m_btn_navy" style="padding: 6px 14px;"> 실시간 가용용량</a> </h4>
            	     <div class="col-md-4 sub_use">가상서버<span class="flr"><em class="fc_orange_im f24 mr5" id="instances"></em> EA</span> </div>
            	     <div class="col-md-4 sub_use">vCPU <span class="flr"><em class="fc_purple_im f24 mr5" id="cores"></em>Core</span></div>
            	     <div class="col-md-4 sub_use" style="margin-right:0;float:right;">MEMORY <span class="flr"><em class="fc_blue_im f24 mr5" id="ram"></em>GB</span></div>
            	     </div>
            	   </div>

					<div class="clear"></div>


					<!-- 프로젝트 하위 상세 VM 리스트 시작 -->

						<div class="flr mt30">
							<a onclick="pageReload();" type='button' class="btn_line55-s flex align-center gap4">새로고침 </a>
							<a onclick="excelDown();" type='button' class="btn_navy-s ml10">엑셀 다운로드</a>
						</div>
						<!-- 그리드 영역 -->

							<table id="VM-list" class="tableV">
								<colgroup>
									<col width="240px">
									<col width="160px">
									<col width="200px">
									<col width="180px">
									<col width="120px">
									<col width="80px">
									<col width="80px">
									<col width="80px">
									<col width="80px">
									<col width="80px">
									<col width="80px">
								</colgroup>
								<thead>
									<tr>
										<th>가상서버</th>
										<th>클라우드</th>
										<th>호스트명</th>
										<th>IP 주소</th>
										<th>BACKUP IP 주소</th>
										<th id="status1">운전상태</th>
										<th id="status2">전원상태</th>
										<th>정지</th>
										<th>시작</th>
										<th>재시작</th>
										<th>상세</th>
									</tr>
								</thead>
							</table>



					<!-- 프로젝트 하위 상세 VM 리스트 끝 -->

					<div class="flr mt-30">
						<a type="button" class="btn_dgrey" onclick="moveListPage();">목록</a>
					</div>
				</div>
				<!-- end content > page-body -->



			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>


			<!-- begin #page-container > modal -->

			<!-- 가상서버 상세 Modal -->
			<div class="modal fade" id="modal-dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
							<h4 class="modal-title">가상서버 상세</h4>
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
											<th class="tal">클라우드</td>
											<td>
												<div class="flex align-center gap10">
													<span id="vm_view_tab_cloudName"></span>
													<span class="pop_pid">${req.projectName}</span>
												</div>
											</td>
										</tr>
										<tr>
											<th class="tal">프로젝트명</td>
											<td><span class="cnt" id="vm_view_tab_projectAlias"></span></td>
										</tr>
										<tr>
											<th class="tal">서버명</td>
											<td>
												<div class="flex align-center gap10">
													<span class="serverName f14 fc11 flex align-center gap10" id="vm_view_tab_hostnameAlias_view"><span id="vm_view_tab_hostnameAlias_text"></span>
														<a type="button" onclick="inputShow('vm_view_tab_hostnameAlias_view','hostnameInput', 'vm_view_tab_hostnameAlias','vm_view_tab_hostnameAlias_text');" class="title_modify"></a>
													</span>
													<span class="serverRename" id="hostnameInput" style="display: none;">
														<input maxlength="30" type="text" class="modiedit" id="vm_view_tab_hostnameAlias" data-original-title="" title="">
														<a type="button" onclick="updateHostNameAlias();" class="m_btn_navy ml10" data-dismiss="modal" style="padding: 4px 16px;">저장</a>
														<a type="button" onclick="inputHide('hostnameInput','vm_view_tab_hostnameAlias_view');" class="m_btn_white ml10" style="padding: 4px 16px;">취소</a>
													</span>
												</div>
											</td>
										</tr>
										<tr>
											<th class="tal">호스트명</td>
											<td><span class="cnt" id="vm_view_tab_hostname"></span></td>
										</tr>
										<tr>
											<th class="tal">생성일시</td>
											<td><span class="cnt" id="vm_view_tab_regDatetime2"></span></td>
										</tr>
									</tbody>
								</table>
							</div>


							<div class="bottomArea clearfix">
                       			<ul class="dashboardArea clearfix">
                       				<li>
                       					<p class="cpuArea mb8 f20" id ="vm_view_tab_vcpus"></p>
                       					<p class="fc11 f14">vCPU<span>(Core)</span></p>
                       				</li>
                       				<li>
                       					<p class="memoryArea mb8 f20"  id ="vm_view_tab_memGb"></p>
                       					<p class="fc11 f14">MEMORY<span>(GB)</span></p>
                       				</li>
                       				<li>
                       					<p class="diskArea mb8 f20" id ="vm_view_tab_diskGb"></p>
                       					<p class="fc11 f14">OS DISK<span>(GB)</span></p>
                       				</li>
                       				<li>
                       					<p class="block mb8 f20" id ="vm_view_tab_blockSize"></p>
                       					<p class="fc11 f14">Block DISK<span>(GB)</span></p>
                       				</li>
                       				<li> </li>
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
											<th class="tal">운전상태</td>
											<td><span id="vm_view_tab_status"></span></td>
										</tr>
										<tr>
											<th class="tal">IP주소</td>
											<td><span class="cnt" id="vm_view_tab_ipAddr"></span></td>
										</tr>
										<tr>
											<th class="tal">BAKUP IP주소</td>
											<td><span class="cnt" id="vm_view_tab_bakupFixedIps"></span></td>
										</tr>
										<tr>
											<th class="tal">전원상태</td>
											<td><span class="cnt" id="vm_view_tab_power"></span></td>
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

				<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog2">
					<div class="modal-dialog">
						<div class="modal-content width-700">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
								<h4 class="modal-title">실시간 가용 용량</h4>
							</div>
							<div class="modal-body">
								<table class="tableV">
									<colgroup>
										<col width="8%">
										<col width="*">
										<col width="14%">
										<col width="14%">
										<col width="14%">
										<col width="14%">
										<col width="14%">
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
											<td rowspan="3" class="lh20">전<br />체
											</td>
											<td>클라우드 용량</td>
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
											<td rowspan="3" class="lh20 bb1859">프<br />로<br />젝<br />트</td>
											<td>프로젝트제한</td>
											<td class="tar"></td>
											<td class="tar"></td>
											<td class="tar"></td>
											<td class="tar"></td>
											<td class="tar"></td>
										</tr>
										<tr>
											<td>프로젝트사용용량</td>
											<td class="tar"></td>
											<td class="tar"></td>
											<td class="tar"></td>
											<td class="tar"></td>
											<td class="tar"></td>
										</tr>
										<tr>
											<td class="fc-orange">실시간가용용량</td>
											<td class="tar fc-orange">35</td>
											<td class="tar fc-orange"></td>
											<td class="tar fc-orange"></td>
											<td class="tar fc-orange"></td>
											<td class="tar fc-orange"></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="modal-footer tac">
								<a type='button' class="m_btn_navy">확인  </a>
		                   		<a type='button' class="m_btn_white ml10" data-dismiss="modal">닫기</a>
		                   	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->

					 <!-- 실시간 가용 용량 팝업 -->
					<div class="modal fade" id="modal-dialog-useVolume">
						<div class="modal-dialog" >
							<div class="modal-content width-700">
								<div class="modal-header">
	 								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
									<h4 class="modal-title">실시간 가용 용량</h4>
								</div>
		                       	<div class="modal-body" id="useVolumeTable">
									<table class="tableV">

										<thead>
										    <tr>
												<th>구분</th>
												<th>가상서버</th>
												<th class='fontVdn'><span class="fontVdn">vCPU</span><br/><span class="fontN" id="title_vcpus">(Core)</span></th>
												<th class='fontVdn'><span class="fontVdn">MEMORY</span><br/><span class="fontN" id="title_memGb">(GB)</span></th>
												<th class='fontVdn'><span class="fontVdn">DISK</span><br/><span class="fontN" id="title_diskGb">(GB)</span></th>

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
									</table>
			                   	</div>
			                   	<div class="modal-footer tac">
	                       			<a type="button" class="m_btn_navy" data-dismiss="modal" id ="popclose">확인</a>
	                       			<a type="button" class="m_btn_white ml10" data-dismiss="modal" id ="popclose">닫기</a>
		                       	</div>
			               	</div>
						</div>
	                 </div>
	                 <!-- old view end -->



					<!-- #modal-dialog 시작, 중지  20191018 추가  -->
					<div class="modal fade"  id="modal-dialog3">
		               <div class="modal-dialog">
		               	<input type='hidden' id='modal-alert-reload' value='N'>
		                   <div class="modal-content">
		                       <div class="modal-header">
		                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                           <h4 class="modal-title">알림</h4>
		                       </div>
		                        <div class="modal-body">
		                       		<h2 class="mb20 f16 fn tal mt0"><span class="fc-blue2" id='hostname'></span>를 <span class="f16 fb fc-orange">시작</span> 하시겠습니까? </h2>
		                       		<%-- <table class="tableH">
		                       		<colgroup>
		                       		 <col width="20%">
									 <col width="*">
		                       		</colgroup>
		                       		<tr><th>비밀번호</th><td><input class="input_int" type="password" id="passWord"/></td></tr>
		                       		<tr><th>시작이유</th><td><textarea  rows="3" id="description" ></textarea></td></tr>
		                       		</table> --%>

		                      	</div>
		                       	<div class="modal-footer tac">
		                   			<a type='button' class="pbton bton_blue"  data-dismiss="modal" onclick="passWordCheck()">확인  </a>
		                       		<a type='button' class="pbton bton_dgrey" data-dismiss="modal">취소 </a>
		                       	</div>
		                   	</div>
		               	</div>
		           	</div>
					<!-- #modal-dialog -->



			</div>
		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">

			var visible = 1;
			var cloudId;
			function pageReload(){
		 		location.reload();
		 	}


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
						html += "		</tr>";
						html += "	</thead>";
						html += "	<tbody>";

						$.each(volumeList,function(key,val){
							if (val["projectBoxId"] == 'ALL') {

								/*allHtml += "		<tr>";
								allHtml += "			<td rowspan='3' class='lh20'>전<br/>체</td>";
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
								projectHtml += "			<td rowspan='3' class='lh20 bb1859'>프<br/>로<br/>젝<br/>트</td>";
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

			// vm 리스트의 정지/시작/재기동시 사용 Fn
			function openActVmModal(uuid, act, hostname,cloudId,hostUuid){
				$("#description").val("");
				$("#targetUuid").val(uuid);
			 	$("#targetAct").val(act);
			 	$("#hostname").text(hostname);
			 	$("#cloudId").val(cloudId);
			 	$("#hostUuid").val(hostUuid);
				//$("#modal-dialog3").modal();

				if(act == 'stop') {
					confirmBox(hostname+"를 정지하시겠습니까?", ajaxActVM);
				} else if(act == 'start') {
					confirmBox(hostname+"를 시작하시겠습니까?", ajaxActVM);
				} else if(act == 'reboot') {
					confirmBox(hostname+"를 재부팅하시겠습니까?", ajaxActVM);
				}
			}

			// 프로젝트 별 현재 사용 용량 조회
			function getAvailableStatus(){

				$.ajax({
					url : "${contextPath}/mbr/oss/vm/detailSum",
					dataType : "JSON",
					type : "GET",
					data : {
						"projectBoxId" : $("#hid_projectBoxId").val(),
						"instanceType" : $("#instanceType").val()
					},
					success : function(data) {

						if(data.cores == null){
							$("#cores").text(0);
						}else{
							$("#cores").text(data.cores);
						}

						if(data.ram == null){
							$("#ram").text(0);
						}else{
							$("#ram").text(data.ram);
						}

						$("#instances").text(data.instances);

					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}

			function actVM(uuid, act){
				alertBox3("이용이 제한된 기능입니다.");

					$("#targetUuid").val(uuid);
					$("#targetAct").val(act);

					confirmBox("처리 하시겠습니까?",ajaxActVM,{});
			}
			// 정지/시작/재시작에 대하여 Openstack에 요청
			function ajaxActVM(obj){
				var obj = {
					"projectName" : $("#hid_projectName").val()
					, "vmUuid" : $("#targetUuid").val()
					, "action" : $("#targetAct").val()
					, "cloudId" : $("#cloudId").val()
					, "hostUuid" : $("#hostUuid").val()
				};

				$.ajax({
					url : "${contextPath}/mbr/oss/vm/action",
					dataType : "JSON",
					data : obj,
					success : function(data) {
						if(data == "1"){
							alertBox("요청 하였습니다.", gridVMList);
						}
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
					}
				});
			}

					function updateHostNameAlias(){
						$.ajax({
							url : "${contextPath}/mbr/oss/vm/update",
							dataType : "JSON",
							data : {
								"vmUuid" : $("#vmUuid").val()
								, "hostnameAlias" : $("#vm_view_tab_hostnameAlias").val()
								, "regUserId" : $("#loginId").val()
								, "modUserId" : $("#loginId").val()
							},
							success : function(data) {
								inputHide('hostnameInput','vm_view_tab_hostnameAlias_view');
								alertBox("수정 하였습니다.", gridVMList);
							},
							error : function(request, status, error) {
								alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
							}

						});
					}


					function detailVM(vmUuid,cloudId){
						$.ajax({
							url : "${contextPath}/mbr/oss/vm/detail",
							dataType : "JSON",
							data : {
								"vmUuid" : vmUuid
								, "projectName" : $("#hid_projectName").val()
								, "cloudId" : cloudId
							},
							success : function(data) {
								delete data.length;
								$('#vmUuid').val(data.vmUuid);
								var ipaddr ="";
								$.each(data, function(key, val){
									if(val != null){
										if(key=="hostnameAlias" || key == "vmUuid"){
											$("#vm_view_tab_"+key+"_text").text(val);
										}else if(key=="addrList" && val.length>0){

											$.each(val, function(key, addr){
												$("#vm_view_tab_bakupFixedIps").html(addr);
											});

										}else if(key=="blockSize"){
											console.log(val)
											$("#vm_view_tab_"+key).text(val - data.diskGb);
										}else{
											$("#vm_view_tab_"+key).text(val);
										}
									}
									$("#vm_view_tab_deptName").html($("#deptName").html());
									$("#vm_view_tab_customerName").html($("#customerName").html());
									$("#vm_view_tab_projectAlias").html($("#projectAlias").html());
								});


								openModal();
							},
							error : function(request, status, error) {
								alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
							}
						});
					}
			// 프로젝트 하위 VM 리스트 조회
			function gridVMList() {
				$("#VM-list").dataTable({
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${contextPath}/mbr/oss/vm/list"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#vm_searchKind option:selected").val();
							d.keyword = $("#vm_keyword").val();
							d.projectBoxId = $("#hid_projectBoxId").val();
							d.projectName = $("#hid_projectName").val();
							d.cloudId = $("#cloudId").val();
							d.instanceType = $("#instanceType").val();

						}
					}
					,"initComplete" : function(setting, json){

						/*  $("#cores").text(json.totalData.vcpus);
						 $("#ram").text(json.totalData.memGb);
						 $("#instances").text(json.totalData.length); */
					}

					,"columns":[
						{"data":"hostnameAlias" , "class":"", "width":"*"}
						, {"data":"cloudName" , "class":"fontVdn", "width":"10%"}
						, {"data":"hostname" , "class":"tac fontVdn", "width":"15%"}
						, {"data":"ipAddr" , "class":"tac fontVdn", "width":"10%"}
						, {"data":"backUpIpAddr" , "class":"tac fontVdn", "width":"10%"}
						, {"data":"status" , "class":"tac p-0 fontVdn", "width":"8%"}
						, {"data":"power" , "class":"tac p-0 fontVdn", "width":"80px"}
						, {"class":"tac", "width":"5%"}
						, {"class":"tac", "width":"5%"}
						, {"class":"tac", "width":"5%"}
						, {"class":"tac", "width":"5%"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						,{"targets":[5], "visible":visible,"render": function(data,type,full){
								if(full.status != "ACTIVE"){
									return '<span class="fcde4e4e">'+full.status+'</span>';
								}else{
									return full.status;
								}
							}
						}
						, {"targets":[6], "render": function(data,type,full){
								if(full.power != "RUNNING"){
									return '<span class="fcde4e4e">'+full.power+'</span>';
								}else{
									return full.power;
								}
							}
						}
							, {"targets":[7], "render": function(data,type,full){
								return '<a href="javascript:openActVmModal(\''+full.vmUuid+'\',\'stop\',\''+full.hostname+'\',\''+full.cloudId+'\',\''+full.hostUuid+'\');" class="cbton bton_orange"><i class="fa fa-stop"></i></a>';
							//return '<button class="btn btn-grey_01" onclick="actVM(\''+full.vmUuid+'\',\'stop\')"><i class="fa fa-stop"></i></button>';
								}
						}
							, {"targets":[8], "render": function(data,type,full){
								return '<a href="javascript:openActVmModal(\''+full.vmUuid+'\',\'start\',\''+full.hostname+'\',\''+full.cloudId+'\',\''+full.hostUuid+'\');" class="cbton bton_blue"><i class="fa fa-play"></i></a>';
							//return '<button class="btn btn-lime_01" onclick="actVM(\''+full.vmUuid+'\',\'start\')"><i class="fa fa-play"></i></button>';
								}
						}
							, {"targets":[9], "render": function(data,type,full){
								return '<a href="javascript:openActVmModal(\''+full.vmUuid+'\',\'reboot\',\''+full.hostname+'\',\''+full.cloudId+'\',\''+full.hostUuid+'\');" class="cbton bton_green"><i class="fa fa-refresh"></i></a>';
							//return '<button class="btn btn-danger_01" onclick="actVM(\''+full.vmUuid+'\',\'reboot\')"><i class="fa fa-refresh"></i></button>';
								}
						}
							, {"targets":[10], "render": function(data,type,full){
								return '<a href="javascript:detailVM(\''+full.vmUuid+'\',\''+full.cloudId+'\');" class="cbton bton_lblue" onclick=""><i class="fa fa-search"></i></a>';
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

			//프로젝트 상세정보 조회
			function getDetail() {
				$.ajax({
					url : "${contextPath}/mbr/oss/project/detail",
					dataType : "JSON",
					async : false,
					data : {
						"programSeq" : $("#reqProjectSeq").val()
						,"projectBoxId" : $("#hid_projectBoxId").val()
						,"cloudId" : $("#cloudId").val()
					},
					success : function(data) {
						delete data.length;
						$.each(data, function(i, val){
							if(i != "deptName"){
								if(i == "cloudType"){
				                    if(val == "vmware"){
					                    $("#status1").text("상태");
					                    $("#status3").text("상태 : ");
					                    $("#status4").remove();
					                    visible = 0;
					                }
				                }
								if(val != null){
									if(i=="customerId"){
										$("#hid_"+i).val(val);
									}else if(i == "keyword"){
										// skip
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
						location.href = "${contextPath}/mbr/project/vm/";
					}
					// 등록/수정페이지 이동
					function moveInsertPage(){
						var projectBoxId = $("#hid_projectBoxId").val();
						location.href = "${contextPath}/mng/project/vm/write?projectBoxId="+projectBoxId;
					}

					function inputShow(hide, show, target, text){
						$("#"+target).val($("#"+text).text());
						$("#"+hide).hide();
						$("#"+show).show();
					}
					function inputHide(hide, show){
						$("#"+hide).hide();
						$("#"+show).show();
					}

					function openModal(){
						$("#modal-dialog").modal();
						/* var customerId="${customerId}";
						var keyword = $("#searchKeyword").val();
						$.ajax({
							url : "companyListModal",
							dataType : "JSON",
							data : {
								"customerId" : customerId
								,"keyword" : keyword
							},
							success : function(data) {

								var getCustomerMemberList = data.companyList;

								$("#popListTable > div").remove();
								$("#totalCnt").text("");
								if(getCustomerMemberList!=""){
									var Html="";
									Html = "<div class='listArea' id='popListTable'>";
									$.each(getCustomerMemberList,function(key,val){

										Html +=			"<div class='listBg'>";
										Html +=				"<span class='name2'>"+ val["upCompanyName"] +"</span>";
										Html +=				"<span class='idlabel2'>"+ val["companyName"] +"</span>";
										if( val['companyId'] == $('#refCompanyId').val()){
											Html +=				"<a class='applybtn active' onclick=''>적용</a>";
										}else{
											Html +=				"<a class='applybtn' onclick='changeCompany(\""+val['companyId']+"\",\""+val['upCompanyName']+"\",\""+val['companyName']+"\")'>적용</a>";
										}


										Html +=			"</div>";
									});
									Html += "</div>";

									$("#popListTable").append(Html);
									$("#totalCnt").text("총 "+getCustomerMemberList.length+" 건");

								}else{
									var Html="";
									Html = "<div class='noneList' style='display: none;'>";
									Html +=		"<span>검색된 사용자가 없습니다.</span>";
									Html += "</div>";

									$("#popListTable").append(Html);
									$("#totalCnt").text("총 0 건");
								}

							},
							error : function(request, status, error) {
								alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
							}
						}); */
					}

					function excelDown(){
					    var params = "";
					    //params += "&searchKind=" + $("#vm_searchKind option:selected").val();
					    //params += "&keyword=" + $("#vm_keyword").val();
					    params += "&projectBoxId=" + $("#hid_projectBoxId").val();
					    params += "&projectName=" + $("#hid_projectName").val();
					    location.href =  '${contextPath}/mbr/oss/vm/excel?'+params;
					}

			$(document).ready(function() {
				App.init();
				//프로젝트 상세정보 조회
				getDetail();
				// 프로젝트별 가용용량 조회

				getAvailableStatus();
				// 프로젝트 하위 VM 리스트 조회
				gridVMList();

				$("#vm_keyword").keydown(function(e){
					if(e.keyCode == 13){
						gridVMList();
					}
				});

				//메뉴활성화
				$("#myGoods").addClass("active");

				if($("#instanceType").val() == "INSTANCE_NORMAL"){
					$("#myVmNomal").addClass("active");
					$("#titleText").text("가상서버");
					$("#titleLinkText").text("가상서버 상세");
				}else if($("#instanceType").val() == "INSTANCE_GPU"){
					$("#myVmGpu").addClass("active");
					$("#titleText").text("가상서버(GPU)");
					$("#titleLinkText").text("가상서버(GPU) 상세");
				}else if($("#instanceType").val() == "INSTANCE_CTNTRMNL"){
					$("#myVmCtntrmnl").addClass("active");
					$("#titleText").text("컨테이너터미널");
					$("#titleLinkText").text("컨테이너터미널 상세");
				}

			});

		</script>
	</body>
</html>