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
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<input type="hidden" id="hid_networkId" value="${req.networkId}">
			<input type="hidden" id="hid_projectName" value="${req.projectName}">
		<div id="content" class="content">
			<!-- begin header -->
			<div class="page_header mb30">
			
				<h1>네트워크</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">네트워크 관리</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			 <div class="row pb50">
				<div class="client_DetailBg m-b-40">
					<div class="client_DetailArea">
						<h2 class="blueBoxTitle">프로젝트정보</h2>
						<p class="company_Name2" id="projectAlias"></p>
						<p class="company_Info m-b-25"> 
							<span class="company_labelf">본사 :</span><span class="company_cont" id="upCompanyName"></span>
							<span class="company_label">고객사 :</span><span class="company_cont" id="customerName"></span>
						</p>
					</div> 
				</div>
				
				<div class="row m-b-40">
					<h2 class="titleBuType01 m-b-15">네트워크 정보</h2>
					<div class="formType01">
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col width="163px">
									 <col width="162px">
									 <col width="163px">
									 <col width="159px">
									 <col width="163px">
									 <col width="162px">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><strong>네트워크명</strong></th>
										<td colspan="5">
											
											<div class="editArea">
												<span id="networkName" class="fontVdn txtSkyBlue fontB"></span>
												<span class="serverName f20 fc11" id="networkName">
													<a type="button" onclick="inputShow('networkName','networkNameInput', 'newnetworkName','networkName');" class="title_modify"></a>
												</span>
												<span class="serverRename" id="networkNameInput" style="display: none;"> 
													<input type="text" class="modiedit" id="newnetworkName" data-original-title="" title="" style="width:665px;">
													<a type="button" onclick="updateHostNameAlias();" class="modisave" data-dismiss="modal"></a>
													<a type="button" onclick="inputHide('networkNameInput','networkName');" class="modicancel"></a>
												</span>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>네트워크별칭</strong></th>
										<td colspan="5">
											<div class="editArea">
												<span id="networkAlias"></span>
												<span class="serverName f20 fc11" id="networkAlias">
													<a type="button" onclick="inputShow('networkAlias','hostnameInput2', 'newnetworkAlias','networkAlias');" class="title_modify"></a>
												</span>
												<span class="serverRename" id="hostnameInput2" style="display: none;"> 
													<input type="text" class="modiedit" id="newnetworkAlias" data-original-title="" title="" style="width:665px;">
													<a type="button" onclick="updateHostNameAlias();" class="modisave" data-dismiss="modal"></a>
													<a type="button" onclick="inputHide('hostnameInput2','networkAlias');" class="modicancel"></a>
												</span>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>관리자 상태</strong></th>
										<td id ="adminStateUp"></td>
										<th scope="row"><strong>외부</strong></th>
										<td id ="routerExternal"></td>
										<th scope="row"><strong>상태</strong></th>
										<td id ="status"></td> 
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				
				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType02">
					<h2 class="titleBuType01">서브넷</h2>
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-15">
						<table id="sub-list" style="border-bottom: 0px none ">
							<colgroup>
								<col width="290px">
								<col width="240px">
								<col width="136px">
								<col width="240px">
								<col width="66px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">이름</th>
									<th scope="col">네트워크 주소</th>
									<th scope="col">IP 버젼</th>
									<th scope="col">게이트웨이 IP</th>
									<th scope="col">상세</th>
								</tr>
							</thead>
							<tbody>
								<!-- <tr>
									<td class="fontVdn tal p-l-30">nhbank_op_int_subnet</td>
									<td class="fontVdn txtBlue">123.456.789.123/24</td>
									<td class="fontVdn">IPv4</td>
									<td class="fontVdn">123.456.789.123</td>
									<td><a type="button" class="btn_viewDetail_gray" onclick="openModal();"></a></td>
								</tr>
								<tr>
									<td class="fontVdn tal p-l-30">nhbank_op_int_subnetnhbank_op_int_subnet</td>
									<td class="fontVdn txtBlue">123.456.789.123/24</td>
									<td class="fontVdn">IPv4</td>
									<td class="fontVdn">123.456.789.123</td>
									<td><a type="button" class="btn_viewDetail_gray" onclick="openModal();"></a></td>
								</tr> -->
							</tbody>
						</table>
					</div>
				</div>
				<!-- 테이블 끝 -->
				
				
				<div class="row tac m-t-40">
					<a type="button" class="btnType03 btnType03_prev m-r-15" onclick ="moveBackDetail()">이전</a>
					<a type="button" class="btnType03 btnType03_list" onclick="moveListPage();">목록</a>         
				</div>
				
				
				<div class="modal fade" id="modal-dialog"> 
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">서브넷 상세</h4>
	                       </div>
	                       <div class="modal-body">
								
								<div class="topArea txtAleft">
									<p class="fl m-b-10">
										<span class="serverPopLabel">서브넷이름</span>
										<span class="serverName fc11 fontVdn" id ="sub_tab_subnetName"></span>
									</p>
									<p class="fl cb mt-3">
										<span class="serverPopLabel">네트워크주소</span>
										<span class="hostName fc11 fontVdn txtBlue f18" id ="sub_tab_cidr"></span>
									</p>
	                       		</div>
	                       		
	                       		<div class="networkBox_01 clearfix">
									<ul>
										<li><span class="doubledotte">IP 버젼</span><em  id="sub_tab_ipVersion"></span></em></li>
										<li><span class="doubledotte">게이트웨이 IP</span><em id="sub_tab_gatewayIp"></em></li>
										<li><span class="doubledotte">DHCP 사용여부</span><em id="sub_tab_enableDhcp"></em></li>
									</ul>
								</div>
								
	                       		<div class="networkBox_02 clearfix">
	                       			<dl id="allocationPools" style="display: none">
	                       				<dt>Pools 할당</dt>
	                       				<dd class="m-b-20">
	                       					<ul id ="sub_tab_allocationPools">
												
											</ul>
	                       				</dd>
	                       			</dl>
	                       			<dl id="dnsNameservers" style="display: none">
	                       				<dt>DNS 네임서버</dt>
	                       				<dd class="m-b-20">
	                       					<ul id="sub_tab_dnsNameservers">
										
											</ul>
	                       				</dd>
	                       			</dl>
	                       			<dl id="hostRoutes" style="display: none">
	                       				<dt>호스트경로</dt>
	                       				<dd class="m-b-20">
	                       					<ul id ="sub_tab_hostRoutes">
											
											</ul>
	                       				</dd>
	                       			</dl>
								</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="whiteline" data-dismiss="modal" id ="popclose">확인</a>
	                       	</div>
		               	</div>
					</div>
                 </div>
                 

			</div>
			<!-- end page-body -->
			
				<!-- #modal-dialog -->
				<div class="modal fade" id="massage-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header bgb btlr5 btrr5">
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
	                       <div class="modal-header bgb btlr5 btrr5">
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
		
            <!-- begin #footer -->
            <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">
	function actVM(uuid, act){
		confirmBox("처리 하시겠습니까?"
				,ajaxActVM
				,{
					"projectName" : $("#hid_projectName").val()
					, "vmUuid" : uuid
					, "action" : act
				}
		);
	}
	function ajaxActVM(obj){
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
			url : "${contextPath}/mng/oss/network/update",
			dataType : "JSON",
			data : {
				"networkName" : $("#newnetworkName").val()
				, "networkAlias" : $("#newnetworkAlias").val()
				, "networkId" : $("#hid_networkId").val()
				, "projectName" : $("#hid_projectName").val()
				, "regUserId" : '${userId}'
				, "modUserId" : '${userId}'
			},
			success : function(data) {
				alertBox("수정 하였습니다.", reload);
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
				$.each(data, function(key, val){
					if(val != null){
						if(key=="hostnameAlias" || key == "vmUuid"){
							$("#vm_view_tab_"+key).val(val);
						}else{
							$("#vm_view_tab_"+key).text(val);
						}
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}

	function gridSubNetworkList(){
		$("#sub-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/network/sublist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#vm_searchKind option:selected").val();
					d.keyword = $("#vm_keyword").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
					d.networkId = $("#hid_networkId").val()
				}
			}
			,"columns":[
				{"data":"name" , "class":"fontVdn tal p-l-30"}
				, {"data":"cidr" , "class":"fontVdn txtBlue"}
				, {"data":"ip_version" , "class":"fontVdn"}
				, {"data":"gateway_ip" , "class":"fontVdn"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[4], "render": function(data,type,full){
					return '<a type="button" class="btn_viewDetail_gray" onclick="openModal(\''+full.id+'\');"></a>';
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

	function getTextShared(shared){ return shared?"예":"아니오"; }
	function getTextRouterExternal(routerExternal){ return routerExternal?"예":"아니오"; }
	function getTextAdminStateUp(adminStateUp){ return adminStateUp?"UP":"DOWN"; }
	function getTextDhcp(dhcp){ return dhcp?"예":"아니오"; }
	
	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/oss/network/info",
			dataType : "JSON",
			data : {
				"networkId" : $("#hid_networkId").val()
				,"projectName" :  $("#hid_projectName").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){
				
					if(val != null){
						if(i=="customerId"){
							$("#hid_"+i).val(val);
						}else if(i=="shared"){
							$("#shared").text(getTextShared(val));
						}else if(i=="routerExternal"){
							$("#routerExternal").text( getTextRouterExternal(val));
						}else if(i=="adminStateUp"){
							$("#adminStateUp").text( getTextAdminStateUp(val));
						}else if(i=="status"){
							if (val =="ACTIVE" ||val =="RUNNING" ){
								$("#status").html( val);
							}else{
								$("#status").html(  '<span class="txtRed">'+val +'</span>');
							}
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
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/project/network/";
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
	
	function openModal(subnetId){
	    $.ajax({
			url : "${contextPath}/mng/oss/subnet/detail2",
			dataType : "JSON",
			data : {
				"subnetId" : subnetId
				,"projectName" :  $("#hid_projectName").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(key, val){
					if(val != null){
						if(key=="allocationPools" || key=="dnsNameservers" || key=="hostRoutes" ){
							if(val != null && val != ""){
								$("#"+key).show();
								$("#sub_tab_"+key).html(val);
							} else{
								$("#"+key).hide(); 
							}
						}else if (key =="ipVersion"){
							$("#sub_tab_"+key).html("IPv"+val);
						}else if (key =="enableDhcp"){
							$("#sub_tab_"+key).html(getTextDhcp(val));
						}
						else{
							$("#sub_tab_"+key).text(val);
						}
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
		
		$("#modal-dialog").modal();
	}
	
	function reload(){
		location.reload();
	}
	
	
	function moveBackDetail(){
		history.back();
	/* 	var params = "?projectId="+projectId;
		params += "&projectName="+projectName;
		location.href = "${contextPath}/mng/project/network/view"+params; */
	}
	
	$(document).ready(function() {
		App.init();
		getDetail();
		gridSubNetworkList();
		
		$("#vm_keyword").keydown(function(e){
			if(e.keyCode == 13){
				gridVMList();
			}
		});

		//메뉴활성화
		$("#project").addClass("active");
		$("#projectNetwork").addClass("active");
	});	
	
</script>
</body>
</html>