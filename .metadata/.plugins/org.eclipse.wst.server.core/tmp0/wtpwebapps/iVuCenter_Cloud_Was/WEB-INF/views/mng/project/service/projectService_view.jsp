<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize var="ROLE_CLOUD_ADMIN" access="hasRole('ROLE_CLOUD_ADMIN')" />

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
		<input type ="hidden" id ="hid_projectId"  value="${req.projectId}">
		<input type ="hidden" id ="hid_projectBoxId"  value="${req.projectBoxId}">
		<input type ="hidden" id ="hid_projectName"  value="${req.projectName}">
		<input type ="hidden" id ="hid_reqProjectSeq"  value="${req.programSeq}">
		<input type ="hidden" id ="targetUuid"  >
		<input type ="hidden" id ="targetAct"  >
		<input type ="hidden" id ="vmUuid"  >


			<!-- begin header -->
			<div class="page_header mb30">
				<h1>서비스 상세</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">서비스 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			 <div class="row pb50">
			 	<div class="viewbox mb20">
				    <span class="pid" id='projectName'></span>
				 	<h3 class="pname dpin ml20" id="projectAlias"></h3>
					<span class="dpin ml20 fb fc-blue2">담당조직(부서) : </span><span id="deptName"></span><span class="dpin fb ml40 fc-blue2">담당조직(부서) : </span><span id="deptName2"></span><span class="dpin fb ml40 fc-blue2">담당조직(부서) : </span><span id="deptName3"></span><span class="dpin fb ml40 fc-blue2">담당자  : </span><span id="managerName"></span>(<span id="managerPhone"></span>)
				</div>

				<!-- Usage Status -->
				<div class="usageStatusWrap mb20">
					<strong class="titleLabel">현재 사용 용량</strong>
					<dl>
						<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>계정관리</span><span class="cnt"><em class="fc-orange" id="serviceTypeAccount">0</em>EA</span></dd>
						<dd><span class="title"><i class="fa fa-circle f12 fc-violet mr10"></i>보안관제</span><span class="cnt"><em class="fc-violet" id="serviceTypeSecurity">0</em>EA</span></dd>
						<dd><span class="title"><i class="fa fa-circle f12 fc-blue mr10"></i>백업관리</span><span class="cnt"><em class="fc-blue" id="serviceTypeBackup">0</em>EA</span></dd>
						<dd><span class="title"><i class="fa fa-circle f12 fc-green mr10"></i>SW설치 </span><span class="cnt"><em class="fc-green" id="serviceTypeSw">0</em>EA</span></dd>
						<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>디스크관리</span><span class="cnt"><em class="fc-orange" id="serviceTypeDisk">0</em>EA</span></dd>
						<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>오토스케일</span><span class="cnt"><em class="fc-orange" id="serviceTypeAutoscale">0</em></span></dd>
						<dd><span class="title"><i class="fa fa-circle f12 fc-orange mr10"></i>APP재배포</span><span class="cnt"><em class="fc-orange" id="serviceTypeApplicationRedistribution">0</em></span></dd>

					</dl>
				</div>
				<!-- //Usage Status -->

				<!-- search begin -->
				<div class="page_searchBox">
					<div class="searchArea">
						<div class="selectBox">
							<label class="selectText" for="vm_searchKind">전체</label>
							<select class="search-sel width-150" id="vm_searchKind">
								<option value="searchAll">전체</option>
								<option value="service_type_name">서비스 유형</option>
								<option value="service_name">서비스명</option>
							</select>
						</div>

							<input type="text" placeholder="검색어를 입력하세요" id="vm_keyword" onkeypress="if(event.keyCode==13)gridVMList();" class="width-600 ml5">
							<a type="button" class="bton-s bton_blue" onclick="gridVMList()"><i class="fa fa-search"></i> 검색</a>

					</div>
				</div>
				<!-- search end -->

				<!-- 테이블시작 -->


					<!-- 상단 버튼  -->
					<div class="btnArea tar mb5">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->


						<table id="service-list"  class="tableWrap">
							<colgroup>
								<col width="160px">
								<col width="160px">
								<col width="140px">
								<col width="*">
								<col width="140px">
								<col width="80px">

							</colgroup>
							<thead>
								<tr>
									<th>자원ID</th>
									<th>클라우드</th>
									<th>서비스 유형</th>
									<th>서비스명</th>
									<th>자원명</th>
									<th>상세</th>
								</tr>
							</thead>

						</table>
				<div class="row tac mt40">
					<a type="button" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>
				</div>

	         	<div class="section-container inbox100">

				</div>

				<div class="modal fade" id="modal-dialog">
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">가상서버 상세</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="client_DetailBg m-b-20 txtAleft">
									<div class="client_DetailArea">
										<h2 class="blueBoxTitle">프로젝트정보</h2>
										<p class="company_Name2" id="vm_view_tab_projectAlias">아이뷰몰 프로젝트</p>
										<p class="company_Info m-b-25">
											<span class="company_labelf">본사 :</span><span class="company_cont" id="vm_view_tab_upCompany">쓰리에이치에스</span>
											<span class="company_label">고객사 :</span><span class="company_cont" id="vm_view_tab_customerName">솔루션사업부</span>
										</p>
									</div>
								</div>

								<div class="topArea txtAleft">
									<p class="fl m-b-10">
										<span class="serverPopLabel">서버명</span>
										<span class="serverName f14 fc11" id="vm_view_tab_hostnameAlias_view"><span id="vm_view_tab_hostnameAlias_text"></span>
											<a type="button" onclick="inputShow('vm_view_tab_hostnameAlias_view','hostnameInput', 'vm_view_tab_hostnameAlias','vm_view_tab_hostnameAlias_text');" class="title_modify"></a>
										</span>
										<span class="serverRename" id="hostnameInput" style="display: none;">
											<input type="text" class="modiedit" id="vm_view_tab_hostnameAlias" data-original-title="" title="">
											<a type="button" onclick="updateHostNameAlias();" class="modisave" data-dismiss="modal"></a>
											<a type="button" onclick="inputHide('hostnameInput','vm_view_tab_hostnameAlias_view');" class="modicancel"></a>
										</span>
									</p>
									<p class="fl cb mt-3">
										<span class="serverPopLabel">호스트명</span>
										<span class="hostName f14 fc11 fontVdn" id="vm_view_tab_hostname"></span>
									</p>
	                       		</div>

	                       		<div class="networkListWrap clearfix"  id ="ipaddrarray">
									<p><span class="serverPopLabel">네트워크</span><span class="fixedNetwork" id ="vm_view_tab_ipAddr">123.456.789.123<em>(Fixed)</em></span></p>
									<!-- <ul class="clearfix m-t-10">

									</ul> -->
								</div>

	                       		<div class="bottomArea clearfix">
	                       			<ul class="dashboardArea clearfix">
	                       				<li>
	                       					<p class="cpuArea mb8 txtType02" id ="vm_view_tab_vcpus"></p><!-- 네자리 이상 될 경우, 클래스 .txtType02 추가  -->
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
	                       				<li>
	                       					<p class="diskArea mb8 txtType02" id ="vm_view_tab_blockSize"></p>
	                       					<p class="titleA">Block DISK<span>(GB)</span></p>
	                       				</li>
	                       			</ul>
	                       			<div class="bottomAreaDetail tal clearfix">
	                       				<ul>
	                       					<li class=""><span class="doubledotte">상태</span><span class="fontVdn" id ="vm_view_tab_status"></span></li>
	                       					<li class=""><span class="doubledotte">생성일시</span><span class="fontVdn" id ="vm_view_tab_regDatetime2"></span></li>
	                       					<li class=""><span class="doubledotte">전원상태</span><span class="fontVdn" id ="vm_view_tab_power"></span></li>
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

              </div>


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

				<!--서비스 상세 modal-dialog 시작-->

				<div class="modal fade" id="service-modal-dialog">
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">서비스 상세</h4>
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
												<td><span id="infoCloudName"></span></td>
											</tr>
											<tr>
												<th class="tal">프로젝트명</td>
												<td><span id="infoProjectName"></span></td>
											</tr>
											<tr>
												<th class="tal">프로젝트ID</td>
												<td><span id="projectId"></span></td>
											</tr>
											<tr>
												<th class="tal">자원ID</td>
												<td><span id="serviceId"></span></td>
											</tr>
											<tr>
												<th class="tal">서비스명</td>
												<td><span id="serviceName"></span></td>
											</tr>
											<tr>
												<th class="tal">서비스 유형</td>
												<td><span id="serviceTypeName"></span></td>
											</tr>
											<tr>
												<th class="tal">자원명</td>
												<td><span id="resourceName"></span></td>
											</tr>
											<tr>
												<th class="tal vm">서비스내용</td>
												<td><textarea id="description" readonly></textarea></td>
											</tr>
											<tr>
												<th class="tal">요청일시</td>
												<td><span id="createDatetime"></span></td>
											</tr>
										</tbody>
									</table>
									<p class="commnet fc-red" style="text-align:center;">위 내용으로 신청 하시겠습니까?</p>
								</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="whiteline" data-dismiss="modal" id ="popclose">닫기</a>
	                       	</div>
		               	</div>
					</div>
                 </div>
				<!--서비스 상세 modal-dialog 끝-->


		</div>
		<!-- end #content -->

	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">



		function detailService(projectId, serviceId){
			$("#service-modal-dialog").modal();


			$.ajax({
				url : "${contextPath}/mng/oss/service/serviceDetailInfo",
				dataType : "JSON",
				data : {
					projectId 		: projectId
					,serviceId : serviceId
				},
				success : function(data) {
					delete data.length;
					$.each(data, function(key, val){
						if(val != null){

								if(key == "serviceId"){
									$("#serviceId").val(val);
									$("#serviceId").html(val);
								}else if(key == "serviceProductSeq"){
									$("#serviceProductSeq").val(val);
									$("#serviceProductSeq").html(val);
								}else if(key == "serviceType"){
									$("#serviceType").val(val);
									$("#serviceType").html(val);
								}else if(key == "serviceName"){
									$("#serviceName").val(val);
									$("#serviceName").html(val);
								}else if(key == "vmUuid"){
									$("#vmUuid").val(val);
									$("#vmUuid").html(val);
								}else if(key == "projectId"){
									$("#projectId").val(val);
									$("#projectId").html(val);
								}else if(key == "description"){
									$("#description").val(val);
									$("#description").html(val);
								}else if(key == "createDatetime2"){
									$("#createDatetime").val(val);
									$("#createDatetime").html(val);
								}else if(key == "projectName"){
									$("#infoProjectName").val(val);
									$("#infoProjectName").html(val);
								}else if(key == "resourceName"){
									$("#resourceName").val(val);
									$("#resourceName").html(val);
								}else if(key == "serviceTypeName"){
									$("#serviceTypeName").val(val);
									$("#serviceTypeName").html(val);
								}else if(key == "cloudName"){
									$("#infoCloudName").html(val);
								}
							}

					});
				},
				error : function(request, status, error) {
					alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
				}
			});
		}



	function actVM(uuid, act){
		alertBox3("이용이 제한된 기능입니다.");

// 		$("#targetUuid").val(uuid);
// 		$("#targetAct").val(act);

// 		confirmBox("처리 하시겠습니까?"
// 				,ajaxActVM
// 				,{}
// 		);
	}
	function ajaxActVM(obj){
		var obj = {
				"projectName" : $("#hid_projectName").val()
				, "vmUuid" : $("#targetUuid").val()
				, "action" : $("#targetAct").val()
			};
		$.ajax({
			url : "${contextPath}/mng/oss/vm/action",
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


	function detailVM(vmUuid){
		$.ajax({
			url : "${contextPath}/mng/oss/vm/detail",
			dataType : "JSON",
			data : {
				"vmUuid" : vmUuid
				, "projectName" : $("#hid_projectName").val()
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
							ipaddr += "<ul class='clearfix m-t-10'>";
							$.each(val, function(key, addr){
								ipaddr += "<li>"+addr+"</li>";
							});
							ipaddr += "</ul>";
							$("#ipaddrarray").html(ipaddr);
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
		$("#service-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/service/serviceDetail"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#vm_searchKind option:selected").val();
					d.keyword = $("#vm_keyword").val();
					d.projectBoxId = $("#hid_projectBoxId").val();
					d.projectName = $("#hid_projectName").val();
				}
			}
			,"columns":[
				{"data":"serviceId" , "class":"tal"}
				, {"data":"cloudName"}
				, {"data":"serviceTypeName" , "class":"tal"}
				, {"data":"serviceName" , "class":"tal"}
				, {"data":"resourceName" , "class":"tal"}


			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }

 				, {"targets":[5], "render": function(data,type,full){



 					return '<a href="javascript:detailService(\''+full.projectId+'\',\''+full.serviceId+'\');" class="cbton bton_lblue" onclick=""><i class="fa fa-search"></i></a>';
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

	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/oss/project/detail",
			dataType : "JSON",
			data : {
				"projectBoxId" : $("#hid_projectBoxId").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){
					if(i != "deptName"){
						if(val != null){
							if(i=="customerId"){
								$("#hid_"+i).val(val);
							}else if(i=="keyword"){
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


	function getProjectServiceInfo() {
		$.ajax({
			url : "${contextPath}/mng/oss/project/projectServiceInfo",
			dataType : "JSON",
			data : {
				"projectId" : $("#hid_projectId").val()
			},
			success : function(data) {
				if(data != null) {
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
						}

					});
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}


	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/project/service/";
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
	    location.href =  '${contextPath}/mng/oss/service/viewExcel?'+params;
	}

	$(document).ready(function() {
		App.init();
		getDetail();
		gridVMList();
		getProjectServiceInfo();

		$("#vm_keyword").keydown(function(e){
			if(e.keyCode == 13){
				gridVMList();
			}
		});

		//메뉴활성화
		$("#project").addClass("active");
		$("#projectService").addClass("active");
	});

</script>
</body>
</html>