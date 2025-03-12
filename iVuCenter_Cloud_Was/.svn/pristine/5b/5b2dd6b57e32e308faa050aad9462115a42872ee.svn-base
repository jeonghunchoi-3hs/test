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
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
			<!-- begin #header -->
			<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->
			<!-- begin #sidebar -->
			<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #content -->
			<div id="content" class="content">
				<!-- begin header -->
				<div class="page_header mb30">
					<h1>네트워크 상세</h1>
					<div class="pageNav">
						<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책관리</a><a href="#" class="on">네트워크 관리</a>
					</div>
				</div>
				<!-- end header -->

				<!-- begin page-body -->
				<div class="row pb50">
					<input type="hidden" name="networkId" id="networkId" value="${networkId}" />
					<h2 class="titleBuType01"><span class="bullet"></span> 네트워크 정보 </h2>
					<table class="tableH">
						<colgroup>
							 <col width="140px">
							 <col width="*">
						</colgroup>
						<tr>
							<th>클라우드</th>
							<td>
								${getSubnetView.cloudName}
							</td>
						</tr>
						<tr>
							<th>네트워크 명</th>

							<td>
								${getSubnetView.networkName}
							</td>
						</tr>
						<tr>
							<th>네트워크 별칭</th>
							<td>
								<span class="serverName f16 fc11" id="vm_view_tab_hostnameAlias_view">
									<span class="company_cont" id="disk_view_Alias">${getSubnetView.networkAlias}</span>
									<a type="button" onclick="inputShow('vm_view_tab_hostnameAlias_view','hostnameInput', 'vm_view_tab_hostnameAlias','vm_view_tab_hostnameAlias_text');" class="title_modify ml10"></a>
								</span>
								<span class="serverRename" id="hostnameInput" style="display: none;">
									<input type="text" class="input_int  w50 dpin mr10" id="view_tab_network_name_value"  title="" value="${getSubnetView.networkAlias}">
									<a type="button" onclick="updateNetworkAlias();" class="pbton bton_blue" >저장</a>
									<a type="button" onclick="inputHide('hostnameInput','vm_view_tab_hostnameAlias_view');" class="pbton bton_dgrey">취소</a>
						   		</span>
							</td>
						</tr>
					</table>

					<h2 class="titleBuType01 mb10"><span class="bullet"></span> 서브넷 정보 </h2>
					<table class="tableH_g">
						<colgroup>
							 <col width="140px">
							 <col width="*">
							 <col width="140px">
							 <col width="*">
							 <col width="140px">
							 <col width="*">
						</colgroup>
						<tr>
							<th>
								서브넷 이름
							</th>
							<td colspan="5">
								${getSubnetView.subnetName}
							</td>
						</tr>
						<tr>
							<th>
								서브넷 주소
							</th>
							<td id="subnetCidr" colspan="5">
								${getSubnetView.subnetCidr}
							</td>
						</tr>
						<tr>
							<th>
								GATEWAY
							</th>
							<td id="gatewayIp">
								${getSubnetView.gatewayIp}
							</td>
							<th>DNS</th>
							<td id="dnsNameservers">${getSubnetView.dnsNameservers}</td>
							<th>DHCP 사용</th>
							<td id="enableDhcp">${getSubnetView.enableDhcp}</td>
						</tr>
						<tr>
							<th>
								IP Address Pool
							</th>
							<td id="allocationPools" colspan="5">
								${getSubnetView.allocationPools}
							</td>
						</tr>
					</table>


					<!-- 테이블시작 -->
						<!-- 상단 버튼  -->
						<div class="flex align-center mb5">
							<h2 class="titleBuType01"><span class="bullet"></span> IP주소 이용현황 </h2>
							<a type="button" class="bton-s bton_blue" onclick="excelDown();" style="margin-left:auto;"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
							<!--  <a type="button" class="bton-s bton_blue" href="${contextPath}/mng/cmm/network/write"><i class="fa fa-upload"></i><span> 네트워크 정책 등록</span></a>-->
						</div>
						<!-- //상단 버튼  -->
						<!-- 그리드 영역 -->

							<table  class="tableWrap" id="table-list">
								<colgroup>
									<col width="240px">
									<col width="140px">
									<col width="140px">
									<col width="*">
									<col width="140px">
									<col width="160px">
									<col width="100px">
								</colgroup>
								<thead>
									<tr>
										<th>VIP주소</th>
										<th>IP주소</th>
										<th>MAC주소</th>
										<th>프로젝트명</th>
										<th>호스트명</th>
										<th>서버명</th>
										<th>상태</th>
									</tr>
								</thead>
							</table>
				</div>
				<!-- end page-body -->

				<!-- begin #footer -->
				<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->

		<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">
			function excelDown() {
				var params = "";
				params += "&networkId="+$("#networkId").val();
				location.href = '${contextPath}/mng/oss/network/detailExcel?'+params;
			}

			function updateNetworkAlias() {
				$.ajax({
					url : "${contextPath}/mng/oss/network/networkAliasUpdate",
					dataType : "JSON",
					data : {
						"networkAlias" : $("#view_tab_network_name_value").val()
						,"networkId" :  $("#networkId").val()
					},
					success : function(data) {
						alertBox("수정되었습니다", reload);
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
					}
				});
			}

			function inputShow(hide, show, target, text) {
				$("#"+target).val($("#"+text).text());
				$("#"+hide).hide();
				$("#"+show).show();
			}

			function inputHide(hide, show){
				$("#"+hide).hide();
				$("#"+show).show();
			}

			function gridList() {
				var tmp = 0;
				$("#table-list").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${contextPath}/mng/oss/network/portList"
						,"type" : "GET"
						,"data":function (d) {
							d.networkId = $("#networkId").val();
						}
					}
					,"columns":[
						{"data":"virtualIps"}
						, {"data":"fixedIps"}
						, {"data":"macAddress" , "class":"overflow-path tal name"}
						, {"data":"projectAlias" , "class":"overflow-path tal"}
						, {"data":"hostName" , "class":"overflow-path tal"}
						, {"data":"hostNameAlias" , "class":"overflow-path tal"}
						, {"data":"status"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[0], "render": function(data, type, full) {
							//alert(JSON.stringify(full));
							tmp++;
							return ""
							+ "<span class=\"serverName f13 fc11\" id=\"vipView_"+tmp+"\" >"
							+ "	<span class=\"company_cont\" id=\"vipViewIps_"+tmp+"\" >"+ full.virtualIps +"</span>"
							+ "	<a type=\"button\" onclick=\"vipInputShow('vipView_" + tmp + "','vipInputView_"+ tmp +"', 'vipInput_"+tmp+"', 'vipViewIps_"+tmp+"');\" class=\"title_modify\"></a> "
							+ "	</span> "

							+ "<span class=\"serverRename\" id=\"vipInputView_"+tmp+"\" style=\"display: none;\" >"
							+ " <input type=\"text\" class=\"input_int  w70 dpin\" id=\"vipInput_"+tmp+"\" />"
							+ " <a type=\"button\" onclick=\"updateVip('"+full.portId+"', 'vipInput_"+tmp+"');\" class=\"modisave\" ></a> "
							+ " <a type=\"button\" onclick=\"vipInputHide('vipInputView_"+tmp+"', 'vipView_"+tmp+"');\" class=\"modicancel\"></a> "
							+ "	</span> ";
							}
						}
					]
					,"order": [[0,"desc"]]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					}
					,"sDom":'<"top">rt<"bottom"pi>'
				});
			}

			function networkInfoDetail(){
				$.ajax({
					url : "${contextPath}/mng/oss/network/networkInfoDetail",
					dataType : "JSON",
					type : "POST",
					data : {
						"networkId" : $("#networkId").val()
					},
					success : function(data) {
						 setData(data);
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}

			function updateNetworkNameAlias(){
				$.ajax({
					url : "${contextPath}/mng/oss/network/update",
					dataType : "JSON",
					data : {
						"networkId" : $("#networkId").val()
						, "networkAlias" : $("#vm_view_tab_hostnameAlias").val()
						, "modUserId" : $("#loginId").val()
					},
					success : function(data) {
						inputHide('networknameInput','networknameAlias_view');
						alertBox("수정 하였습니다.", networkInfoDetail);
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
					}

				});
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

			function moveList() {
					location.href = "${contextPath}/mng/oss/network/";
			}

			function moveWrite() {
					location.href = "${contextPath}/mng/cmm/network/write?networkId=${networkId}";
			}

			function setData(data) {
				delete data.length;
				$.each(data, function(key, val){
					//alert(key);
					if(val != null){
							$("#"+key).text(val);
					}
				});
			}

			function vipInputShow(hide, show, target, text){
				$("#"+target).val($("#"+text).text());
				$("#"+hide).hide();
				$("#"+show).show();
			}

			function vipInputHide(hide, show){
				$("#"+hide).hide();
				$("#"+show).show();
			}

			function updateVip(portId, target) {
				//alert(portId + "//" + $("#"+target).val() );
				$.ajax({
					url : "${contextPath}/mng/oss/network/virtualIpsUpdate",
					dataType : "JSON",
					data : {
						 "virtualIps" : $("#"+target).val()
						 ,"portId" :  portId

					},
					success : function(data) {
						alertBox("수정되었습니다", reload);

					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
					}
				});
			}

			$(document).ready(function() {
				App.init();
				gridList();
				//networkInfoDetail();

				//메뉴활성화
				$("#operation").addClass("active");
				$("#ossNetwork").addClass("active");
			});
		</script>
	</body>
</html>