<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="roles" property="principal.roles" />
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

		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->

		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->

		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)-->
		<div id="content" class="content">
		<input type ="hidden" id ="hid_projectBoxId"  value="${req.projectBoxId}">
		<input type ="hidden" id ="hid_projectId"  value="">
		<input type ="hidden" id ="hid_projectName"  value="${req.projectName}">
		<input type ="hidden" id ="hid_reqProjectSeq"  value="${req.programSeq}">


		<input type ="hidden" id ="instanceType"  value="${req.instanceType}">
		<input type ="hidden" id ="targetUuid"  >
		<input type ="hidden" id ="targetAct"  >
		<input type ="hidden" id ="vmUuid"  >
		<input type ="hidden" id ="cloudId" >
			<!-- begin header -->
			<div class="page_header mb30">
				<h1 id="titleText"></h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on" id="titleLinkText"></a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			 <div class="row">
			 	<div class="viewbox mb20">
				    <span class="pid" id='projectName'></span>
				 	<h3 class="pname dpin ml20" id="projectAlias"></h3>
				 	<span class="dpin fb ml20 fc-blue2">본부 : </span> <span id="deptName"></span><span class="dpin ml40 fb fc-blue2">처(실) : </span> <span id="deptName2"></span><span class="dpin ml40 fb fc-blue2">부서 : </span> <span id="deptName3"></span><span class="dpin fb ml40 fc-blue2">담당자  : </span> <span id="managerName"></span>(<span id="managerPhone"></span>)
				</div>


				<!-- Usage Status -->
				<div class="usageStatusWrap mb20">
					<strong class="titleLabel">현재 사용 용량</strong>
					<dl>
						<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>가상서버</span><span class="cnt"><em class="fc-orange" id="instances"></em>EA</span></dd>
						<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>vCpu</span><span class="cnt"><em class="fc-violet" id="cores"></em>Core</span></dd>
						<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>MEMORY</span><span class="cnt"><em class="fc-blue" id="ram"></em>GB</span></dd>
						<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>DISK</span><span class="cnt"><em class="fc-green" id="volumes"></em>GB</span></dd>
						<dd class="mt30"><a type="button" onclick="useVolumeDetail('${req.projectId}');"><button class="cbton bton_blue"><i class="fa fa-battery-half ml-2"></i> </button></a></dd>
					</dl>
				</div>
				<!-- //Usage Status -->


				<!-- search begin -->
				<div class="page_searchBox m-b-15">
					<div class="searchArea">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="vm_searchKind">전체</label>
							<select class="search-sel" id="vm_searchKind">
								<option value="searchAll">전체</option>
								<option value="hostname_alias">서버명</option>
								<option value="hostname">호스트명</option>
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="vm_keyword" onkeypress="if(event.keyCode==13)gridVMList();" style="width: 450px">
							<a type="button" class="bton-s bton_blue" onclick="gridVMList()"><i class="fa fa-search"></i> 검색</a>
						</div>
					</div>
				</div>
				<!-- search end -->

				<!-- 테이블시작 -->


					<!-- 상단 버튼  -->

						<a onclick="excelDown();" type='button' class="bton-s bton_blue flr mb5"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
						<a onclick="pageReload();" type='button' class="bton-s bton_blue fl mb5"><i class="fa fa-refresh"></i> <span> 새로고침</span></a>

					<!-- //상단 버튼  -->

					<!-- 그리드 영역 -->

						<table id="VM-list"  class="tableWrap">
							<colgroup>
								<col width="15%">
								<col width="10%">
								<col width="*">
								<col width="10%">
								<col width="10%">
								<col width="8%">
								<col width="8%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="5%">
							</colgroup>
							<thead>
								<tr>
									<th>서버명</th>
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


				<!-- 테이블 끝 -->


				<div class="row tac m-t-40">
					<a type="button" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>
				</div>


				<div class="modal fade" id="modal-dialog">
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
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
												<th class="tal">프로젝트명</td>
												<td><span id="vm_view_tab_projectAlias"></span></td>
											</tr>
											<tr>
												<th class="tal">클라우드</td>
												<td><span class="cnt nanumR" id="vm_view_tab_cloudName"></span></td>
											</tr>
											<tr>
												<th class="tal">서버명</td>
												<td>
													<span class="serverName f14 fc11" id="vm_view_tab_hostnameAlias_view"><span id="vm_view_tab_hostnameAlias_text"></span>
														<a type="button" onclick="inputShow('vm_view_tab_hostnameAlias_view','hostnameInput', 'vm_view_tab_hostnameAlias','vm_view_tab_hostnameAlias_text');" class="title_modify"></a>
													</span>
													<span class="serverRename" id="hostnameInput" style="display: none;">
														<span class="flex align-center">
															<input maxlength="30"  type="text" class="modiedit mr10" id="vm_view_tab_hostnameAlias" data-original-title="" title="">
															<a type="button" onclick="updateHostNameAlias();" class="pbton bton_blue" data-dismiss="modal">저장</a>
															<a type="button" onclick="inputHide('hostnameInput','vm_view_tab_hostnameAlias_view');" class="pbton bton_dgrey">취소</a>
														</span>
													</span>
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

	                       		<div class="bottomArea clearfix" style="border-bottom:0;">
	                       			<ul class="dashboardArea clearfix">
	                       				<li>
	                       					<p class="cpuArea mb8 txtType02" id ="vm_view_tab_vcpus"></p>
	                       					<p class="titleA">vCPU<span>(Core)</span></p>
	                       				</li>
	                       				<li>
	                       					<p class="memoryArea mb8"  id ="vm_view_tab_memGb"></p>
	                       					<p class="titleA">MEMORY<span>(GB)</span></p>
	                       				</li>
	                       				<li>
	                       					<p class="diskArea mb8 txtType02" id ="vm_view_tab_diskGb"></p>
	                       					<p class="titleA">OS DISK<span>(GB)</span></p>
	                       				</li>
	                  <!--      				<li>
	                       					<p class="block mb8 txtType02" id ="vm_view_tab_blockSize"></p>
	                       					<p class="titleA">Block DISK<span>(GB)</span></p>
	                       				</li> -->
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
												<td><span id="vm_view_tab_ipAddr"></span></td>
											</tr>
											<tr>
												<th class="tal">BAKUP IP주소</td>
												<td><span id="vm_view_tab_bakupFixedIps"></span></td>
											</tr>
											<tr>
												<th class="tal">전원상태</td>
												<td><span class="cnt" id="vm_view_tab_power"></span></td>
											</tr>
										</tbody>
									</table>
								</div>
		                   	</div>
		                   	<div class="mt10 mb20 tac">
	                       		<a type="button" class="whiteline" data-dismiss="modal" id ="popclose">닫기</a>
	                       	</div>
		               	</div>
					</div>
                 </div>


                        </div>
                        <!-- end tab-content -->
			<!-- 	</div> -->
                <!-- end col-6 -->
				<!------여기까지 사용------>


                 <!-- begin #footer -->
            <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

			</div>
			<!-- end page-body -->

				<!-- #modal-dialog -->
				<div class="modal fade" id="massage-modal-dialog">
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
	                       		<a type='button' class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->

				<!-- #modal-dialog -->
				<div class="modal fade" id="modal-alert">
	               <div class="modal-dialog">
	               	<input type='hidden' id='modal-alert-reload' value='N'>
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">알림 메세지</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div id="modal_msg"></div>
	                      	</div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->



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
                       			<a type="button" class="pbton bton_blue" data-dismiss="modal" id ="popclose">확인</a>
                       			<a type="button" class="pbton bton_dgrey" data-dismiss="modal" id ="popclose">취소</a>
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
	                       		<h2 class="mb20"><span class="fc-blue2" id='hostname'> </span>를 <span class="f16 fb fc-orange">시작</span> 하시겠습니까? </h2>
	                       		<table class="tableH">
	                       		<colgroup>
	                       		 <col width="20%">
								 <col width="*">
	                       		</colgroup>
	                       		<tr><th>비밀번호</th><td><input class="input_int" type="password" id="passWord"/></td></tr>
	                       		<tr><th>시작이유</th><td><textarea  rows="3" id="description" placeholder="내용을 입력하세요"></textarea></td></tr>
	                       		</table>

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
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">
			var visible = 1;
			function pageReload(){
					location.reload();
			}


			function getDetail() {

				$.ajax({
					url : "${contextPath}/mng/oss/project/detail",
					dataType : "JSON",
					data : {
						"projectBoxId" : $("#hid_projectBoxId").val(),
						"instanceType" : $("#instanceType").val()
					},
					async : false,
					success : function(data) {
						delete data.length;
						$.each(data, function(i, val){
		                    //프로젝트 상세 ID 값 넣기
		                    if(i != "deptName"){
			                    if(i == "cloudType"){
				                    if(val == "vmware"){
				                    	 $("#status1").text("상태");
					                     $("#status3").text("상태 : ");
					                     $("#status4").remove();
					                     visible = 0;
					                }
				                }
								$("#"+i).text(val);
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


		   function openActVmModal(uuid, act, hostname,cloudId){
			   $("#description").val("");
				$("#targetUuid").val(uuid);
			 	$("#targetAct").val(act);
			 	$("#hostname").text(hostname);
			 	$("#cloudId").val(cloudId);
				//$("#modal-dialog3").modal();
				if(act == 'stop') {
					confirmBox(hostname+"를 정지하시겠습니까?", ajaxActVM);
				} else if(act == 'start') {
					confirmBox(hostname+"를 시작하시겠습니까?", ajaxActVM);
				} else if(act == 'reboot') {
					confirmBox(hostname+"를 재부팅하시겠습니까?", ajaxActVM);
				}
		   }


			function passWordCheck(uuid, act){


				if($("#passWord").val()==""){
					alertBox3("패스워드를 입력하세요");
					return false;
				}
				if($("#description").val()==""){
					alertBox3("사유를 입력하세요");
					return false;
				}

				$.ajax({
					url : "${contextPath}/mng/oss/vm/passWordCheck",
					dataType : "JSON",
					data : {
						"passWord" : $("#passWord").val()
						, "description" : $("#description").val()
						, "ActionType" : $("#targetAct").val()
						, "vmUuid" : $("#targetUuid").val()

					},
					success : function(data) {

						if(data == 1){


							alertBox("실행 하시겠습니까", ajaxActVM);
						}else if(data == 2){
							alertBox("패스워드가 일치하지 않습니다.", gridVMList);
						}

					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
					}

				});

			}

			function ajaxActVM(obj){
				var obj = {
						"projectName" : $("#hid_projectName").val()
						, "vmUuid" : $("#targetUuid").val()
						, "action" : $("#targetAct").val()
						, "cloudId" : $("#cloudId").val()
					};
				$.ajax({
					url : "${contextPath}/mng/oss/vm/action",
					dataType : "JSON",
					data : obj,
					success : function(data) {
						alertBox("요청 하였습니다.","");

						if(data == "1"){
							$("#modal-dialog3").hide();

							setTimeout(function(){
							location.reload();
							},1500);
						}
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
					}
				});
			}

			function updateHostNameAlias(){
				$.ajax({
					url : "${contextPath}/mng/oss/vm/update",
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
					url : "${contextPath}/mng/oss/vm/detail",
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
								if(key == "status" && val=="POWERED_ON"){
									val="전원켜짐";
								}
								if(key=="hostnameAlias" || key == "vmUuid"){
									$("#vm_view_tab_"+key+"_text").text(val);

								}else if(key=="addrList" && val.length>0){

									$.each(val, function(key, addr){
										$("#vm_view_tab_bakupFixedIps").html(addr);
									});

								}else if(key=="blockSize"){
									$("#vm_view_tab_"+key).text(val - data.diskGb);
								}else{
									$("#vm_view_tab_"+key).text(val);
								}
							}
							$("#vm_view_tab_upCompany").html($("#upCompanyName").html());
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

			function gridVMList(){
				$("#VM-list").dataTable( {
					"processing": true
					,"autoWidth": true
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${contextPath}/mng/oss/vm/list"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#vm_searchKind option:selected").val();
							d.keyword = $("#vm_keyword").val();
							d.projectBoxId = $("#hid_projectBoxId").val();
							d.projectName = $("#hid_projectName").val();
							d.cloudId = $("#hid_cloudId").val();

						}
					}
					,"columns":[
						{"data":"hostnameAlias" , "class":"tal"}
						, {"data":"cloudName" , "class":"tal"}
						, {"data":"hostname"}
						, {"data":"ipAddr"}
						, {"data":"backUpIpAddr"}
						, {"data":"status" , "class":"p-0"}
						, {"data":"power" , "class":"power"}
						, {}
						, {}
						, {}
						, {}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						,{"targets":[5],"visible":visible, "render": function(data,type,full){
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
		 					return '<a href="javascript:openActVmModal(\''+full.vmUuid+'\',\'stop\',\''+full.hostname+'\',\''+full.cloudId+'\');" class="cbton bton_orange"><i class="fa fa-stop"></i></a>';
							//return '<button class="btn btn-grey_01" onclick="actVM(\''+full.vmUuid+'\',\'stop\')"><i class="fa fa-stop"></i></button>';
		 					}
						}
		 				, {"targets":[8], "render": function(data,type,full){
		 					return '<a href="javascript:openActVmModal(\''+full.vmUuid+'\',\'start\',\''+full.hostname+'\',\''+full.cloudId+'\');" class="cbton bton_blue"><i class="fa fa-play"></i></a>';
							//return '<button class="btn btn-lime_01" onclick="actVM(\''+full.vmUuid+'\',\'start\')"><i class="fa fa-play"></i></button>';
		 					}
						}
		 				, {"targets":[9], "render": function(data,type,full){
		 					return '<a href="javascript:openActVmModal(\''+full.vmUuid+'\',\'reboot\',\''+full.hostname+'\',\''+full.cloudId+'\');" class="cbton bton_green"><i class="fa fa-refresh"></i></a>';
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
						, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					}
					,"sDom":'<"top">rt<"bottom"pi>'
				});
			}

			/* function getDetail() {
				$.ajax({
					url : "${contextPath}/mng/oss/project/detail",
					dataType : "JSON",
					data : {
						"projectId" : $("#hid_projectId").val()
					},
					success : function(data) {
						delete data.length;
						$.each(data, function(i, val){

							if(val != null){
								if(i=="customerId"){
									$("#hid_"+i).val(val);
								}else if(i=="keyword"){
									// skip
								}else{
									$("#"+i).text(val);
								}
							}

						});
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
					}
				});
			} */

			// 목록 페이지이동
			function moveListPage(){
				location.href = "${contextPath}/mng/project/vm/";
			}
			// 등록/수정페이지 이동
			function moveInsertPage(){
				var projectId = $("#hid_projectId").val();
				location.href = "${contextPath}/mng/project/vm/write?projectId="+projectId;
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
			    params += "&searchKind=" + $("#vm_searchKind option:selected").val();
			    params += "&keyword=" + $("#vm_keyword").val();
			    params += "&projectId=" + $("#hid_projectId").val();
			    params += "&projectName=" + $("#hid_projectName").val();
			    location.href =  '${contextPath}/mng/oss/vm/excel?'+params;
			}


			/* function projectVmInfo(){

				$.ajax({
					url : "${wasPath}/mng/oss/vm/projectVmInfo",
					dataType : "JSON",
		 			type : "GET",
					data : {
						  "projectId" : $("#hid_projectId").val()
					},
					success : function(data) {
						var result = data;
						$("#ram").text(result.ram/1024)
						$("#cores").text(result.cores)
						$("#volumes").text(result.volumes)
						$("#instances").text(result.instances)

					},
					error : function(request, status, error) {
						if(request.status == '200'){
							alertBox("접속이 만료되었습니다.", logout);
						}else{
							alertBox3("code:" + request.status + "\n" + "error:" + error);
						}
					}
				});

			} */


			// 실시간 가용량 시작
		    function useVolumeDetail(projectId){
			$.ajax({
				url : "${contextPath}/mng/req/product/cloudUsageProject",
				dataType : "JSON",
//	 			type : "POST",
				data : {
					"projectId" : projectId
				},
				success : function(data) {

					var volumeList = data;
					var allHtml = "";
					var projectHtml = "";
					var html = "";

					$("#useVolumeTable > table").remove();
					html += "<table class='tableV'>";
			        html += "	<colgroup>";
					html += " 		<col width='8%'>";
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

						if (val["projectId"] == 'ALL') {

							allHtml += "		<tr>";
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
							allHtml += "		</tr>";
						} else {
							projectHtml += "		<tr>";
							projectHtml += "			<td rowspan='3' class='lh20'>프<br/>로<br/>젝<br/>트</td>";
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



		    function useVolumeInit(){

			$.ajax({
				url : "${contextPath}/mng/req/product/cloudUsageProject",
				dataType : "JSON",
//	 			type : "POST",
				data : {
					"projectId" : $("#hid_projectId").val()
				},
				success : function(data) {

					var volumeList = data;

					$.each(volumeList,function(key,val){
						if (val["projectId"] != 'ALL') {
						$("#instances").text(addcomma(val["vmUsed"]));
						$("#cores").text(addcomma(val["vcpuUsed"]));
						$("#ram").text(addcomma(val["memUsed"]));
						$("#volumes").text(addcomma(val["diskUsed"]));
						}
					});
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}


			$(document).ready(function() {
				App.init();
				getDetail();
				gridVMList();
				useVolumeInit();
				//projectVmInfo();

				$("#vm_keyword").keydown(function(e){
					if(e.keyCode == 13){
						gridVMList();
					}
				});

				//메뉴활성화
				$("#project").addClass("active");

				if($("#instanceType").val() == "INSTANCE_NORMAL"){
					$("#projectVmNomal").addClass("active");
					$("#titleText").text("가상서버");
					$("#titleLinkText").text("가상서버 관리");
				}else if($("#instanceType").val() == "INSTANCE_GPU"){
					$("#projectVmGpu").addClass("active");
					$("#titleText").text("가상서버(GPU)");
					$("#titleLinkText").text("가상서버 관리(GPU)");
				}else if($("#instanceType").val() == "INSTANCE_CTNTRMNL"){
					$("#projectVmCtntrmnl").addClass("active");
					$("#titleText").text("컨테이너터미널");
					$("#titleLinkText").text("가상서버 관리");
				}

			});

</script>
</body>
</html>