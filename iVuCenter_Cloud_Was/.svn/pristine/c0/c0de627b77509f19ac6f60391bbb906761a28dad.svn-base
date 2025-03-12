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
				<h1>파일스토리지 관리 상세</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">파일스토리지 관리</a>
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
<!-- 						<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>볼륨</span><span class="cnt"><em class="fc-violet" id='diskCn'></em>EA</span></dd> -->
						<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>NAS</span><span class="cnt"><em class="fc-blue" id='nasGb'></em>GB</span></dd>
						<dd class="mt30"> <a type="button" onclick="useVolumeDetail('${req.projectBoxId}');"><button class="cbton bton_blue"><i class="fa fa-battery-half ml-2"></i> </button></a></dd>

					</dl>
				</div>
				<!-- //Usage Status -->


				<!-- search begin -->
				<div class="page_searchBox m-b-15">
					<div class="searchArea">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="nasSearchKind">전체</label>
							<select class="search-sel" id="nasSearchKind">
								<option value="searchAll">전체</option>
								<option value="app_uid">어플리케이션ID</option>
								<option value="app_name">어플리케이션명</option>
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="nasKeyword" onkeypress="if(event.keyCode==13)connectList();" style="width: 450px">
							<a type="button" class="bton-s bton_blue" onclick="connectList()"><i class="fa fa-search"></i> 검색</a>
						</div>
					</div>
				</div>
				 <div class="gridTableWrap gridType02">
				 	<div class="tableWrap">
					 <!-- 상단 버튼  -->
					<div class="tar mb5">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
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

			        <table id="nas-list" style="border-bottom: 0px none">
			        	<colgroup>
						 		<col width="13%">
						 		<col width="10%">
						 		<col width="7%">
						 		<col width="*">
						 		<col width="8%">
						 		<col width="6%">
					 	</colgroup>
						<thead>
						    <tr class="grey">
								<th>스토리지ID</th>
								<th>스토리지명</th>
								<th>크기(GB)</th>
								<th>파일 경로</th>
								<th>연결관리</th>
								<th>상세</th>
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
	               <div class="modal-dialog width-720">
	                   <div class="modal-content width-720">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">PV 연결등록</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="page_searchBox m-b-20">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="disk_searchKind">전체</label>
							<select class="search-sel" id="disk_searchKind">
								<option value="searchAll">전체</option>
								<option value="app_uid">어플리케이션ID</option>
								<option value="app_name">어플리케이션명</option>
								<!-- <option value="project_alias">프로젝트명</option>
								<option value="project_name">프로젝트ID</option> -->
							</select>
						</div>
									<div class="searchArea">
										<div class="inputArea m-l-5">
											<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword"  data-original-title="" title="" style="width: 362px">
											<a type="button" class="btn_search" onclick="connectList();">검색</a>
										</div>
									</div>
								</div>
								<div>
									<table class="table table-bordered table-hover table-striped table-td-valign-middle mb0"  id="connect-list">
							        	<colgroup>
									 		<col width="50%">
									 		<col width="*%">
									 		<col width="10%">
									 	</colgroup>
										<thead>
										    <tr class="grey">
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
	                       		<a type="button" class="pbton bton_blue" data-dismiss="modal" onClick="openMountPath()">확인</a>
	                       		<a type="button" class="pbton bton_dgrey" data-dismiss="modal">취소</a>
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
								<textarea style="height: 200px" rows="5" placeholder="MountPath를 입력해주세요." id="mountPath" name="mountPath" ></textarea>
		                   	</div>
		                   	<div class="modal-footer tac">
	                      			<a type="button" class="pbton bton_blue" id ="popclose" onclick="confirmAttach()">확인</a>
	                      			<a type="button" class="pbton bton_dgrey" data-dismiss="modal" id ="popclose">취소</a>
	                       	</div>
		               	</div>
					</div>
	            </div>

				<div class="modal fade" id="modal-detach">
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">PV 연결해지</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="client_DetailBg m-b-20 txtAleft">
									<div class="client_DetailArea">
										<h2 class="blueBoxTitle">프로젝트정보</h2>
										<p class="company_Name2"  id="modal_projectAlias"></p>
									</div>
								</div>

								<div class="topArea txtAleft">
									<p class="fl m-b-10">
										<span class="serverPopLabel">스토리지ID</span>
										<span class="serverName f18 fc11"id="modal_nasName"></span>
									</p>
									<p class="fl m-b-10">
										<span class="serverPopLabel">스토리지명</span>
										<span class="serverName f18 fc11 fontVdn" id="modal_nasAlias"></span>
									</p>
									<p class="fl m-b-10">
										<span class="serverPopLabel">파일 경로</span>
										<span class="serverName f18 fc11 fontVdn" id="modal_nasFileSystemPath"></span>
									</p>
	                       		</div>

	                       		<div class="networkListWrap clearfix">
									<p class="m-b-10"><span class="serverPopLabel">어플리케이션</span><span class="fixedNetwork2 p-l-5" id ="modal_appName"></span></p>
									<p class="cb mt-3"><span class="serverPopLabel">mountPath</span><span class="fixedNetwork2 p-l-5" id ="modal_mountPath"></span></p>
								</div>

                       			<p class="f18 f11 m-t-30">연결을 해지하시겠습니까?</p>
		                   	</div>

	                       	<div class="modal-footer tac">
	                       		<a type="button" class="pbton bton_blue" data-dismiss="modal" onClick="confirmDetach()">확인</a>
	                       		<a type="button" class="pbton bton_dgrey" data-dismiss="modal" onClick ="closeModal('modal-detach')">취소</a>
	                       	</div>
		               	</div>
					</div>
                 </div>

			<div class="modal fade" id="detail-modal-dialog">
			    <div class="modal-dialog">
			        <div class="modal-content w560">
			            <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
			                <h4 class="modal-title">NAS 상세</h4>
			            </div>
			            <div class="modal-body">
	                       		<div class="client_DetailBg m-b-20 txtAleft">
									<div class="client_DetailArea">
										<h2 class="blueBoxTitle">프로젝트정보</h2>
										<p class="company_Name2" id="detail_projectAlias"></p>
									</div>
								</div>
			                <div class="col-md-12 bgee modalpop mb20">
										<div id="popDetailDivProject"></div>
										<div class="detailBox">
											<div class="boxType01" id='popDetailDiv1'></div>
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
		                   	</div>
		                   	<div class="modal-footer tac">
                       			<a type="button" class="pbton bton_blue" data-dismiss="modal" id ="popclose">확인</a>
                       			<a type="button" class="pbton bton_dgrey" data-dismiss="modal" id ="popclose">취소</a>
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

		$(document).ready(function() {
			App.init();
			getDetail();
			gridNasList();
			getProjectNasInfo();
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
			$("#projectFs").addClass("active");
		});

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
						projectHtml += "			<td rowspan='3' class='lh20 bb1859'>프<br/>로<br/>젝<br/>트</td>";
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
			function getProjectNasInfo() {
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
					url : "${contextPath}/mng/oss/project/detail",
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
						"url":"${contextPath}/mng/oss/filestorage/fsList"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#nasSearchKind option:selected").val();
							d.keyword = $("#nasKeyword").val();
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
				        return "<a type='button' class='connect active' onclick='openAttach(\"" + full.projectId + "\", \"" + full.nasId + "\", \"" + full.cloudId + "\" , \"" + full.pvcName + "\")'>" +
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
				$("#detail_projectAlias").text(projectAlias);
				$("#detail-modal-dialog").modal('show');
				$("#popDetailTitle").html('NAS 상세내역');
				var html = "";

				// 모달 상단 내용 추가
				html += '<div class="topArea txtAleft">';
				html += '   <p class="fl cb mb10">';
				html += '       <span class="serverPopLabel">스토리지ID</span>';
				html += '       <span class="hostName2 f14 fc11 fontVdn">' + nasName + '</span>';
				html += '   </p>';
				html += '   <p class="fl mb10">';
				html += '       <span class="serverPopLabel">스토리지명</span>';
				html += '       <span class="serverName f14 fc11">' + nasAlias + '</span>';
				html += '   </p>';
				html += '   <p class="fl cb mb10">';
				html += '       <span class="serverPopLabel">클러스터명</span>';
				html += '       <span class="hostName2 f14 fc11 fontVdn">' + cloudName + '</span>';
				html += '   </p>';
				html += '   <p class="fl cb mb10">';
				html += '       <span class="serverPopLabel">파일 경로</span>';
				html += '       <span class="hostName2 f14 fc11 fontVdn">' + nasFileSystemPath + '</span>';
				html += '   </p>';

				html += '</div>'; // topArea 끝

				// NAS 용량
				html += '<div class="bottomArea clearfix">';
				html += '   <ul class="w30 fl dpin">';
				html += '       <li>';
				html += '           <p class="block mb8">' + nasGb + '</p>';
				html += '           <p class="titleA mb8">NAS 용량<span>(GB)</span></p>';
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
				$("#modal-detach").modal();
				$("#cloudId").val(cloudId);
				$("#hid_projectId").val(projectId);
				$("#hid_nasId").val(nasId);

				$.ajax({
					url : "${contextPath}/mng/oss/persistentvolume/pvDetachList",
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
							url : "${contextPath}/mng/oss/persistentvolume/detach",
							dataType : "JSON",
							data : obj,
							success : function(data) {
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
						$("#cloudId").val(cloudId);
						$("#hid_pvcName").val(pvcName);
						connectList();
					}

					function openMountPath(){
						$("#modal-dialog-mountpath").modal();
					}

					function confirmAttach(){
						confirmBox("연결하시겠습니까?", actAttach);
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
							url : "${contextPath}/mng/oss/persistentvolume/attach",
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
// 					success : function(data) {
// 						alertBox("요청 되었습니다.", reload());

// 					},
					function connectList() {
						$("#connect-list").dataTable( {
							"processing": true
							,"autoWidth": false
							,"serverSide": true
							,"ordering": false
							,"destroy" : true
							,"ajax": {
								"url":"${contextPath}/mng/oss/app/pvAppList"
								,"type" : "GET"
								,"data":function (d) {
									d.searchKind = $("#searchKind").val();
									d.keyword = $("#keyword").val();
									d.projectId = $("#hid_projectId").val();
									d.projectBoxId = $("#hid_projectBoxId").val();
									d.projectName = $("#hid_projectName").val();
									d.pvcName = $("#hid_pvcName").val();
									d.nasId = $("#hid_nasId").val();
									d.cloudId = $("#cloudId").val();
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
			    params += "&projectName=" + $("#hid_projectName").val();
			    params += "&projectBoxId=" + $("#hid_projectBoxId").val();
			    location.href = "${contextPath}/mng/oss/filestorage/excel?"+params;
			}

			function reload() {
				location.reload();
			}

			// 목록 페이지이동
			function moveListPage(){
				location.href = "${contextPath}/mng/project/filestorage/";
			}

			function closeModal(modal){
				$("#"+modal).hide();
			}

</script>
</body>
</html>