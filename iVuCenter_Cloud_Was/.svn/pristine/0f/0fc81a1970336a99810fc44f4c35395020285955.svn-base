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

				<p class="page_title">PV 상세
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원현황  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/project/disk/">PV 관리 </a>  <span class="arrow_ab"> &#8227; </span> <b>PV 상세   </b>
			    </span>
				</p>

				<input type="hidden" name="apprvPass" id="apprvPass"				value="${apprvPass}" />
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
            	     <h4 class="f16 mb10 f500 mb20 flex gap10">현재 사용량 <a type="button" onclick="useAvailabilityDetail('${req.projectBoxId}');" class="btn_navy-ss flr"> 실시간 가용용량</a> </h4>
            	     <div class="flex">
	            	     <!-- <div class="col-md-6 sub_use_nas" style="width:100%;">볼륨<span class="flr"><em class="fc_orange_im f20 mr5" id='nasCnt'></em> EA</span> </div> -->
	            	     <div class="col-md-6 sub_use_nas flr" style="margin-right:0; width:100%;">NAS <span class="flr"><em class="fc_blue_im f20 mr5" id='nasGb'></em>GB</span></div>
	            	 </div>
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
						<input type ="hidden" id="hid_projectId"		value="${req.projectId}"/>
						<input type ="hidden" id="hid_projectName" value="${req.projectName}">
						<input type ="hidden" id ="reqProjectSeq"  value="${req.programSeq}">
						<input type ="hidden" id="hid_customerId" value="">
						<input type ="hidden" id="hid_cloudId" value="">
						<input type ="hidden" id ="hid_appUid" value="">
						<input type ="hidden" id ="hid_appName" value="">
						<input type ="hidden" id ="hid_appNameSpace" value="">
						<input type ="hidden" id ="hid_pvcName" value="">
						<input type ="hidden" id ="hid_pvName" value="">
						<input type ="hidden" id ="hid_mountPath" value="">
						<input type ="hidden" id ="hid_nasId" value="">


						<!-- 그리드 영역 -->

					        <table id="nas-list"  class="tableV">
					        	<colgroup>
							 		<col width="13%">
							 		<col width="10%">
							 		<col width="7%">
							 		<col width="*">
<%-- 							 		<col width="10%"> --%>
							 		<col width="8%">
							 		<col width="6%">
							 	</colgroup>
								<thead>
								    <tr class="grey">
										<th>스토리지ID</th>
										<th>스토리지명</th>
										<th>크기(GB)</th>
										<th>파일 경로</th>
<!-- 										<th>가상서버</th> -->
										<th>연결관리</th>
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
			<!-- PVC 연결등록 Modal -->
			<div class="modal fade" id="modal-attach">
	            <div class="modal-dialog width-720">
	                <div class="modal-content width-720">
	                    <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        <h4 class="modal-title">PV 연결등록</h4>
	                    </div>
	                    <div class="modal-body">
                            <div class="col-xs-12 bgee modalpop mb20">
	                       		<div class="selectBoxAr col-xs-2">
									<label class="selectText" for="searchKind">전체</label>
									<select class="search-sel" id="searchKind">
										<option value="searchAll">전체</option>
										<option value="app_uid">어플리케이션ID</option>
										<option value="app_name">어플리케이션명</option>
									</select>
								</div>
								<div class="col-xs-2"></div>
									<div class="col-xs-8">
										<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)connectList();">
										<button type="button" class="btn_search2 vm" onclick="connectList();"><span></span></button>
									</div>
							</div>
							<div>
					     		<table class="table table-bordered table-hover table-striped table-td-valign-middle mb0"  id="connect-list">
						        	<colgroup>
								 		<col width="50%">
								 		<col width="*">
								 		<col width="15%">
								 	</colgroup>
									<thead>
									   <tr class="skyblue">
											<th class='tac'>어플리케이션ID</th>
											<th class='tac'>어플리케이션명</th>
											<th class='tac'>적용</th>
										</tr>
									</thead>
									<tbody id="app-listTable">
									</tbody>
								</table>
							</div>
                 		</div>
	                 	<div class="modal-footer tac">
							<a type="button" class="lbtn" data-dismiss="modal" onClick="openMountPath()">확인</a>
							<a type="button" class="rbtn" data-dismiss="modal">취소</a>
						</div>
					</div>
				</div>
			</div>

					<!-- NAS 상세 Modal -->

			<div class="modal fade" id="detail-modal-dialog">
			    <div class="modal-dialog">
			        <div class="modal-content w560">
			            <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
			                <h4 class="modal-title">NAS 상세</h4>
			            </div>
			            <div class="modal-body">
	                       		<div class="client_DetailBg m-b-20 txtAleft">
									<div class="client_DetailArea" style="padding-bottom:20px;">
										<!-- <h2 class="blueBoxTitle">프로젝트정보</h2> -->
										<p class="company_Name2" id="detail_projectAlias"></p>
									</div>
								</div>
			                <div class="mb20" stype="padding:0;">
										<div id="popDetailDivProject"></div>
										<div class="detailBox">
											<div class="boxType01" id='popDetailDiv1'></div>
										</div>
			                </div>
			            </div>

			            <div class="modal-footer tac">
			                <a type="button" class="m_btn_navy" href="${wasPath}/mbr/req/changeOrder/changeOrderView?viewFlag=Y">변경신청</a>
			                <a type="button" class="btn m_btn_white ml10" data-dismiss="modal" id="popclose">닫기</a>
			            </div>
			        </div>
			    </div>
			</div>


			<div class="modal fade" id="modal-dialog-mountpath">
				<div class="modal-dialog">
					<div class="modal-content w560">
						<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
							<h4 class="modal-title">MountPath 입력</h4>
						</div>
                       	<div class="modal-body">
							<textarea style="height: 200px" rows="5" placeholder="MountPath를 입력해주세요. ex) mount/path/test" id="mountPath" name="mountPath" ></textarea>
	                   	</div>
	                   	<div class="modal-footer tac">
                      			<a type="button" class="lbtn" id ="popclose" onclick="confirmAttach()">확인</a>
                      			<a type="button" class="rbtn ml10" data-dismiss="modal" id ="popclose">취소</a>
                       	</div>
	               	</div>
				</div>
            </div>

			<!-- PVC 연결해지 Modal -->

 			<div class="modal fade" id="modal-detach">
					<div class="modal-dialog">
	                   <div class="modal-content w560">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">PV 연결해지</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="client_DetailBg m-b-20 txtAleft">
									<div class="client_DetailArea pb20">
										<!-- <h2 class="blueBoxTitle">프로젝트정보</h2> -->
										<p class="company_Name2"  id="modal_projectAlias"></p>
									</div>
								</div>

								<div class="tableE">
									<table>
										<colgroup>
											<col width="120px" />
											<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th class="tal">스토리지ID</th>
												<td id="modal_nasName"></td>
											</tr>
											<tr>
												<th class="tal">스토리지명</th>
												<td id="modal_nasAlias"></td>
											</tr>
											<tr>
												<th class="tal">파일 경로</th>
												<td id="modal_nasFileSystemPath"></td>
											</tr>
										</tbody>

									</table>

									<table class="mt20" style="border-top:1px solid #d3d3d3;">
										<colgroup>
											<col width="120px" />
											<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th class="tal">어플리케이션명</th>
												<td id="modal_appName"></td>
											</tr>
											<tr>
												<th class="tal">mountPath</th>
												<td id="modal_mountPath"></td>
											</tr>
										</tbody>

									</table>
                       				<p class="commnet fc-red">위 내용으로 신청 하시겠습니까?</p>
								</div>

		                   	</div>

	                       	<div class="modal-footer tac">
	                       		<a type="button" class="m_btn_navy" data-dismiss="modal" onClick="confirmDetach()">확인</a>
	                       		<a type="button" class="m_btn_white ml10" data-dismiss="modal" onClick ="closeModal('modal-detach')">취소</a>
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
                           				<th>NAS(GB)</th>
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
										<td class="tac"></td>
										<td class="tac"></td>
										<td class="tac"></td>
										<td class="tac"></td>
										<td class="tac"></td>
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
		</div>
		<!-- end #page-container -->

		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">

			$(document).ready(function() {
				App.init();
				//프로젝트 상세정보 조회
				getDetail();
				// 프로젝트별 가용용량 조회
				getProjectVmInfo();
				// 프로젝트 하위 블록디스크 리스트 조회
				gridNasList();

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
				$("#myPv").addClass("active");
			});

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
						html += " 		<col width='54px''>";
						html += " 		<col width='*'>";
						html += " 		<col width='80px'>";
						html += " 		<col width='100px'>";
						html += " 		<col width='100px'>";
						html += " 		<col width='80px'>";
						html += " 		<col width='80px'>";
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
								projectHtml += "			<td rowspan='3' class='lh20 bb1859 tac'>프로<br/>젝트</td>";
								projectHtml += "			<td>프로젝트 제한용량</td>";
								projectHtml += "			<td class='tac'>"+addcomma(val["vmTotal"])+"</td>";
								projectHtml += "			<td class='tac'>"+addcomma(val["vcpuTotal"])+"</td>";
								projectHtml += "			<td class='tac'>"+addcomma(val["memTotal"])+"</td>";
								projectHtml += "			<td class='tac'>"+addcomma(val["diskTotal"])+"</td>";
								projectHtml += "			<td class='tac'>"+addcomma(val["nasTotal"])+"</td>";
								projectHtml += "		</tr>";
								projectHtml += "		<tr>";
								projectHtml += "			<td class='fc-orange'>프로젝트 사용용량</td>";
								projectHtml += "			<td class='tac fc-orange'>"+addcomma(val["vmUsed"])+"</td>";
								projectHtml += "			<td class='tac fc-orange'>"+addcomma(val["vcpuUsed"])+"</td>";
								projectHtml += "			<td class='tac fc-orange'>"+addcomma(val["memUsed"])+"</td>";
								projectHtml += "			<td class='tac fc-orange'>"+addcomma(val["diskUsed"])+"</td>";
								projectHtml += "			<td class='tac fc-orange'>"+addcomma(val["nasUsed"])+"</td>";
								projectHtml += "		</tr>";
								projectHtml += "		<tr>";
								projectHtml += "			<td>실시간 가용용량</td>";
								projectHtml += "			<td class='tac'>"+addcomma(val["vmAvail"])+"</td>";
								projectHtml += "			<td class='tac'>"+addcomma(val["vcpuAvail"])+"</td>";
								projectHtml += "			<td class='tac'>"+addcomma(val["memAvail"])+"</td>";
								projectHtml += "			<td class='tac'>"+addcomma(val["diskAvail"])+"</td>";
								projectHtml += "			<td class='tac'>"+addcomma(val["nasAvail"])+"</td>";
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
					url : "${contextPath}/mng/oss/project/projectNasInfo",
					dataType : "JSON",
					data : {
						"projectBoxId" : $("#hid_projectBoxId").val()
					},
					success : function(data) {
						delete data.length;
						$.each(data, function(i, val){
							if(i=="nasGb"){
								$("#nasGb").text(val);
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

			function gridNasList(){
				$("#nas-list").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${contextPath}/mbr/oss/persistentvolume/nasList"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#disk_searchKind option:selected").val();
							d.keyword = $("#disk_keyword").val();
							d.projectName = $("#hid_projectName").val();
							d.projectBoxId = $("#hid_projectBoxId").val();
							d.projectId = $("#hid_projectId").val();
							d.nasId = $("#hid_nasId").val();
							d.cloudType = $("#cloudType").val();
						}
					}
					,"columns":[
						{"data":"nasName" }
						, {"data":"nasAlias"}
						, {"class":"nasGb"}
						, {"data":"nasFileSystemPath" ,"class":"tac"}
						, {"data":"" ,"class":"tac"}
						, {"class":"tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[2], "render": function(data,type,full) {
							return addcomma(full.nasGb);
						}}
						, {"targets":[4], "render": function(data,type,full) {
							if (full.cloudType == "openshift") {

							    if (full.connectStatus === "PVC_MOUNT") {
							        return "<a type='button' class='connect' onclick='openDetach(\"" + full.projectId + "\", \"" + full.nasId + "\", \"" + full.cloudId + "\")'>" +
							               "<i class='fa fa-times-circle f16 fc-orange2'></i> 연결해지</a>";
							    } else {
							        return "<a type='button' class='connect active' onclick='openAttach(\"" + full.projectId + "\", \"" + full.nasId + "\", \"" + full.cloudId + "\", \"" + full.pvcName + "\")'>" +
							               "<i class='fa fa-check-circle f16 fc-bluegreen'></i> 연결등록</a>";
							    }
							}
						}}
						, {"targets":[5], "render": function(data,type,full){
							return "<a type='button' class='cbton bton_lblue'  onclick='detailNas(\""+full.nasName+"\", \""+full.nasAlias+"\", \""+full.orderProductSeq+"\", \""+full.nasGb+"\", \""+full.nasFileSystemPath+"\", \""+full.description+"\", \""+full.amount+"\", \""+full.nasVmList+"\", \""+full.cloudName+"\", \""+full.projectAlias+"\")'><i class='fa fa-search'></i></a>";
						}}
					]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div class='data_search'>검색중입니다. </div>"
					}
					,"sDom":'<"top">rt<"bottom"pi>'
				});
			}

			function detailNas(nasName,nasAlias,orderProductSeq,nasGb,nasFileSystemPath,description,amount,nasVmList,cloudName,projectAlias){
				$("#detail_projectAlias").html(projectAlias);

				$("#detail-modal-dialog").modal('show');
				$("#popDetailTitle").html('NAS 상세내역');
				var html = "";

				// 모달 상단 내용 추가
				html += '<div class="tableE">'
				html += '<table><colgroup><col width="120px" /><col width="*" /></colgroup><tbody>'
				html += '<tr><th class="tal">스토리지ID</th><td>' + nasName + '</td></tr>';
				html += '<tr><th class="tal">스토리지명</th><td>' + nasAlias + '</td></tr>';
				html += '<tr><th class="tal">클러스터명</th><td>' + cloudName + '</td></tr>';
				html += '<tr><th class="tal">파일 경로</th><td>' + nasFileSystemPath + '</td></tr>';
				html += '</tbody></table>';
				html += '</div>'

				// NAS 용량
				html += '<div class="bottomArea clearfix">';
				html += '   <ul class="w30 fl dpin">';
				html += '       <li>';
				html += '           <p class="block mb8">' + nasGb + '</p>';
				html += '           <p class="titleA">NAS 용량<span>(GB)</span></p>';
				html += '       </li>';
				html += '   </ul>';
				html += '</div>'; // bottomArea 끝

				// 추가 정보 섹션
				html += '<div class="modal-info-group">';
				html += '   <div class="col-group info-box">';

				// 요청내용 처리
		/* 		if (description === "" || description === undefined || description === null) {
				    html += '       <div class="left">요청내용</div>';
				    html += '       <div class="right">요청내용 없음</div>';
				} else {
				    html += '       <div class="left">요청내용</div>';
				    html += '       <div class="right">' + description + '</div>';
				} */

				html += '   </div>'; // col-group info-box 끝

	       		$("#detail-modal-dialog #popDetailDiv1").html(html);
				$("#popDetailDiv1").show();
			}

// 			String namespace, String deploymentConfigName, String pvcName, CustomOssCloudVO cloudVo
			// 블록디스크 연결해지 Modal 조회
			function openDetach(projectId,nasId,cloudId) {
				$("#hid_projectId").val(projectId);
				$("#hid_nasId").val(nasId);
				$("#modal-detach").modal();
				$("#hid_cloudId").val(cloudId);

				$.ajax({
					url : "${contextPath}/mbr/oss/persistentvolume/pvDetachList",
					dataType : "JSON",
					data : {
						 projectName 	: $("#hid_projectName").val()
						,projectBoxId 	: $("#hid_projectBoxId").val()
						,projectId 		: $("#hid_projectId").val()
						,nasId 			: $("#hid_nasId").val()
						,appNameSpace : $("#hid_appNameSpace").val()
						,cloudId 		: $("#hid_cloudId").val()
						,cloudType 		: $("#cloudType").val()
					},
					success: function(response) {
					    var data = response.data[0];

					    $("#modal_nasName").text(data.nasName);
					    $("#modal_nasAlias").text(data.nasAlias);
					    $("#modal_nasFileSystemPath").text(data.nasFileSystemPath);
					    $("#modal_projectAlias").html($('#projectAlias').html());
					    $("#modal_appName").text(data.appName);
					    $("#modal_mountPath").text(data.mountPath);

					    $("#hid_appName").val(data.appName);
					    $("#hid_appUid").val(data.appUid);
					    $("#hid_appNameSpace").val(data.appNameSpace);
					    $("#hid_pvcName").val(data.pvcName);
					    $("#hid_nasId").val(data.nasId);
					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				});
			}

					function confirmDetach(){
						 confirmBox("연결해지 하시겠습니까?", actDetach);
					}

					function actDetach(obj){

						var obj = {
									"projectName"		: $("#hid_projectName").val()
									, "appName" 		: $("#hid_appName").val()
									, "appNameSpace": $("#hid_appNameSpace").val()
									, "appUid" 			: $("#hid_appUid").val()
									, "pvName"			: $("#hid_pvName").val()
									, "pvcName"		: $("#hid_pvcName").val()
									, "cloudId"			: $("#hid_cloudId").val()
									, "nasId"			: $("#hid_nasId").val()
									, "pvcYn"			: 'N'
								};
						$.ajax({
							url : "${contextPath}/mbr/oss/persistentvolume/detach",
							dataType : "JSON",
							data : obj,
							success : function(data) {
								debugger;
								if(data.errorMsg == "1"){
									alertBox("연결해지가 요청 되었습니다.<br>요청하신 작업은 시간이 소요 됩니다.<br>15초 뒤에 검색하여 확인 해주십시오.", function() {
									    reload();
									});
								}else{
									alertBox(data.errorMsg);
								}
							},
							error : function(request, status, error) {
								alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
							}
						});
					}

					function openAttach(projectId, nasId, cloudId, pvcName){
						$("#projectId").val(projectId);
						$("#hid_nasId").val(nasId);
						$("#modal-attach").modal();
						$("#hid_pvcName").val(pvcName);
						$("#hid_cloudId").val(cloudId);

						connectList();
					}

					function openMountPath(){
						$("#modal-dialog-mountpath").modal();
					}

					function confirmAttach(){
						confirmBox("연결하시겠습니까?" , actAttach);
					}

					function actAttach(obj){
						var mountPath = $("#mountPath").val();

						var obj ={
								"projectName"		: $("#hid_projectName").val()
								, "appUid"			: $("#hid_appUid").val()
								, "nasId"			: $("#hid_nasId").val()
								, "appName" 		: $("#hid_appName").val()
								, "appNameSpace" 		: $("#hid_appNameSpace").val()
								, "pvcName"		: $("#hid_pvcName").val()
								, "mountPath"		: mountPath
								, "cloudId"			: $("#hid_cloudId").val()
								, "pvcYn"			: 'Y'
							};
						$.ajax({
							url : "${contextPath}/mbr/oss/persistentvolume/attach",
							dataType : "JSON",
							data : obj,
							success : function(data) {
								if(data.errorMsg == "1"){
									$("#modal-attach").hide();
							        alertBox("요청 되었습니다.", function() {
							            reload();
							        });

								}else{
									alertBox3(data.errorMsg);
								}
							},
							error : function(request, status, error) {
								alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
							}
						});
					}

					function connectList() {
						$("#connect-list").dataTable( {
							"processing": true
							,"autoWidth": false
							,"serverSide": true
							,"ordering": false
							,"destroy" : true
							,"ajax": {
								"url":"${contextPath}/mbr/oss/app/pvAppList"
								,"type" : "GET"
								,"data":function (d) {
									d.searchKind = $("#searchKind").val();
									d.keyword = $("#keyword").val();
									d.projectId = $("#hid_projectId").val();
									d.projectBoxId = $("#hid_projectBoxId").val();
									d.projectName = $("#hid_projectName").val();
									d.pvcName = $("#hid_pvcName").val();
									d.nasId = $("#hid_nasId").val();
									d.cloudId = $("#hid_cloudId").val();
								}
							}
							,"columns":[
								{"data":"appNameSpace" , "class":"tac"}
								,{"data":"appName" , "class":"tac"}
								,{"class":"tac lastCol"}
							]
							,"columnDefs":[
								{"defaultContent" : "", targets:"_all" }
								, {"targets":[2], "render": function(data,type,full){
									return '<div class="tac"><a href="#" data-toggle="tab"><input type="button" id="'+full.appUid+'" value="&#xf00c" class="popCheckbtn" onclick="attachConnect(this, \''+full.appUid+'\', \''+full.appName+'\', \''+full.appNameSpace+'\', \''+full.cloudId+'\')" ></a></div>';
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

					function attachConnect(e, appUid, appName, appNameSpace, cloudId) {
					    $("#app-listTable > tr").find("input").removeClass("active");

					    $(e).toggleClass("active");
					    $("#hid_appUid").val(appUid);
					    $("#hid_appName").val(appName);
					    $("#hid_appNameSpace").val(appNameSpace);
					    $("#hid_cloudId").val(cloudId);
					}

// 					function updateHostNameAlias(){
// 						$.ajax({
// 							url : "${contextPath}/mng/oss/disk/update",
// 							dataType : "JSON",
// 							data : {
// 								"diskId" : $("#unconnectDiskId").val()
// 								, "diskAlias" : $("#vm_view_tab_diskNameAlias_value").val()
// 								, "regUserId" : "${userId}"
// 								, "modUserId" : "${userId}"
// 							},
// 							success : function(data) {
// 								alertBox("수정되었습니다",gridDiskList);

// 							},
// 							error : function(request, status, error) {
// 								alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
// 							}
// 						});
// 					}

// 					function checkBtn(obj){
// 					}

			function excelDown() {
				var params = "";
			    params += "&projectName=" + $("#hid_projectName").val();
			    params += "&projectBoxId=" + $("#hid_projectBoxId").val();
			    location.href = "${contextPath}/mbr/oss/persistentvolume/excel?"+params;
			}

			function reload() {
				location.reload();
			}

			// 목록 페이지이동
			function moveListPage(){
				location.href = "${contextPath}/mbr/project/persistentvolume/";
			}

			function closeModal(modal){
				$("#"+modal).hide();
			}

		</script>
	</body>
</html>