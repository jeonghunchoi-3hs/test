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
		
		<!-- begin #content -->
		<div id="content" class="content">
		<input type="hidden" id ="hid_projectId" value ="${req.projectId }">
		<input type="hidden" id ="hid_companyId">
		<input type="hidden" id ="hid_projectName">
		<input type="hidden" id ="hid_customerId">
		<input type="hidden" id ="hid_networkId">
		
		<input type ="hidden" id ="ruleNetworkId">
			<!-- begin page-header -->
			<div class="page_header mb30">
				<h1>네트워크</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">네트워크 관리</a>
				</div>
			</div>
			<!-- end page-header -->
			
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
					<div class="formType01">
						<h2 class="titleBuType01 m-b-15">네트워크 정보</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col style="width:200px">
									 <col style="width:770px">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><strong>네트워크명</strong></th>
										<td>
											<input type="hidden" id="confirmFlag" value="Y"/> 
									  		<input type="hidden" class="form-control" id="projectNameOrg"/>
											<input type="text" style="width:550px; margin-right: 5px" name="netWokrName" id="netWokrName" maxlength="40" readonly>
											<a type="button" class="btnType04" style="width:150px;" onclick="openModal();"><span class="txt">미할당정책 검색</span></a>
										</td>
									</tr> 
									<tr>
										<th scope="row"><strong>네트워크별칭</strong></th>
										<td><input type="text" style="width:100%" id ="netWorkAlias"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="formType01">
						<h2 class="titleBuType01 m-b-15">서브넷</h2>
						<div class="tblWrap clearfix">
							<table>
								<colgroup>
									 <col style="width:200px">
									 <col style="width:770px">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><strong>서브넷 이름</strong></th>
										<td><input type="text" style="width:100%" id ="subNetworkName"></td>
									</tr> 
									<tr>
										<th scope="row"><strong>네트워크 주소</strong></th>
										<td><input type="text" style="width:100%" id ="ipAddr"></td>
									</tr>
									<tr>
										<th scope="row"><strong>IP 버전</strong></th>
										<td>
											<div class="selectBox" style="width:356px;">
												<label class="selectText">IPv4</label>
												<select class="search-sel">
													<option value="">IPv4</option>
												</select>
											</div>
										</td>
									</tr> 
									<tr>
										<th scope="row"><strong>게이트웨이 IP</strong></th>
										<td><input type="text" style="width:100%" id="gateWay"></td>
									</tr> 
									<tr>
										<th scope="row"><strong>DCHP 사용여부</strong></th>
										<td>
											<div class="optionBox">
												<label><input type="radio" name="dhcp"  value='true'><span>사용</span></label>
												<label><input type="radio" name="dhcp"  value='false'><span>사용안함</span></label>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong>Pools 할당</strong></th>
										<td><textarea placeholder="내용을 입력하세요" style="height:100px;" id ="pools"></textarea></td>
									</tr>
									<tr>
										<th scope="row"><strong>DNS 네임서버</strong></th>
										<td><textarea placeholder="내용을 입력하세요" style="height:100px;" id ="dnsName"></textarea></td>
									</tr>
									<tr>
										<th scope="row"><strong>호스트경로</strong></th>
										<td><textarea placeholder="내용을 입력하세요" style="height:100px;" id ="host"></textarea></td>
									</tr>    
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<!-- begin button-->
			    <div class="row tac m-t-60">
			    	<a type="button" class="btnType03 btnType03_prev" onClick ="moveBackDetail()">이전</a>
		 			<a type="button" class="btnType03 btnType03_save m-l-15" onClick="validationChk()">저장</a>
		 			<a type="button" class="btnType03 btnType03_list m-l-15" onClick ="moveListPage()">목록</a>
                 </div>
				<!-- end button -->
			</div>
			<!-- end page-body -->				 
			<!-- #modal-dialog -->
                 <div class="modal fade" id="modal-dialog"> 
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">미할당 네트워크</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="page_searchBox m-b-15">
									<div class="searchArea">
										<div class="inputArea m-l-5">
											<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)openModal();" style="width: 362px">
											<a type="button" class="btn_search" onclick="openModal();">검색</a>
										</div>
									</div>
								</div>
								
								<div class="noneList" style="display: none;">
									 <span>검색된 사용자가 없습니다.</span>
								</div> 
								
								<!-- <div class="listArea" id="popListTable"> -->
								<div class="listArea" id ="popListTable">
	                      		</div>
	                      		<div class="totalcnt" id="totalCnt">총 4 건</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="whiteline" data-dismiss="modal"  id ="popclose">닫기</a>
	                       	</div>
		               	</div>
					</div>
                 </div>				
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
		
	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
	//modal팝업 open
	
	function openModal(){
		var obj = {
				"customerId" : $('#hid_customerId').val()
		,"projectId" : $('#hid_projectId').val()
		,"companyId" :$('#hid_companyId').val()
		,"projectName" :$('#hid_projectName').val()
		,"keyword" : keyword 
	};

		$("#modal-dialog").modal();
		var customerId="${customerId}";		
		var keyword = $("#searchKeyword").val();
		$.ajax({
			url : "${contextPath}/mng/oss/network/ruleNetList",
			dataType : "JSON",
			data : {
				"customerId" : $('#hid_customerId').val()	
				,"projectId" : $('#hid_projectId').val()
				,"companyId" :$('#hid_companyId').val()
				,"projectName" :$('#hid_projectName').val()
				,"keyword" : keyword 
			},
			success : function(data) {
				
				var getRuleList = data.ruleList;
				var ipaddr ="";
				var gateway ="";
				$("#popListTable > div").remove();
				$("#totalCnt").text("");
				if(getRuleList!=""){
					var Html="";
					Html = "<div class='listArea' id='popListTable'>";
					$.each(getRuleList,function(key,val){
						ipaddr = val["aClass"]+'.'+val["bClass"]+"."+atstaString(val["cClass"])+"."+"0"+val["cidr"];
						gateway = val["aClass"]+'.'+val["bClass"]+"."+atstaString(val["cClass"])+"."+"1";
						Html +=			"<div class='listBg'>";
						Html +=				"<span class='name2'>"+ val["codeName"] +"</span>";
						Html +=				"<span class='idlabel2 fontVdn txtBlue'>"+ val["aClass"]+'.'+val["bClass"]+"."+val["cClass"]+"."+"0"+val["cidr"]+"</span>";
						if( val['ruleNetworkId'] == $('#ruleNetworkId').val()){
							Html +=				"<a class='applybtn active' onclick=''>적용</a>";
						}else{
							Html +=				"<a class='applybtn' onclick='changeNetwork(\""+val['ruleNetworkName']+"\",\""+val['codeName']+"\",\""+ipaddr+"\",\""+gateway+"\",\""+val['workKind']+"\",\""+val['workNetKind']+"\",\""+ val['ruleNetworkId']+"\" )'>적용</a>";
						}
						Html +=			"</div>";
					});
					Html += "</div>";
					
					$("#popListTable").append(Html);
					$("#totalCnt").text("총 "+getRuleList.length+" 건");
					
				}else{
					var Html="";
					Html = "<div class='noneList' style='display: none;'>";
					Html +=		"<span>검색된 정책이 없습니다.</span>";
					Html += "</div>";
					
					$("#popListTable").append(Html);
					$("#totalCnt").text("총 0 건");
				}		 
				
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	function atstaString(str){
		var string ="";
		+str
		for (var i = 0 ; i < 3 - str.length ;i++)
			string += '*';
		
		return string+str;
	}
	
	
	function changeNetwork(netWokrName,codeName,ipaddr,gateway,workKind,workNetKind,networkId){
		$('#netWokrName').val(netWokrName.toLowerCase());
		$('#netWorkAlias').val($('#projectAlias').text()+"_"+codeName);
		$('#ruleNetworkId').val(networkId);
		$('#subNetworkName').val(($('#hid_projectName').val()+"_"+workKind.replace('WORKKIND_', '')+"_"+workNetKind.replace('WORKNET_', '')+"_subnet").toLowerCase());

		$('#ipAddr').val(ipaddr);
		$('#gateWay').val(gateway); 
		$("#popclose").click();
	}
	
	function insertNetwork(){
		$.ajax({
			url : "${contextPath}/mng/oss/network/insert",
			dataType : "JSON",
			data : {
				"projectId" 		: $("#hid_projectId").val()
				, "projectName" 	: $("#hid_projectName").val()
				, "networkName" 	: $("#netWokrName").val()
				, "networkAlias" 	: $("#netWorkAlias").val()
				, "adminStateUp" 	: "true"
				, "ipVersion" : "4"
				//, "shared" 			: $("#network_insert_tab_shared").is(":checked")
				, "regUserId" : '${userId}'
				, "modUserId" : '${userId}'
			},
			success : function(data) {
				if(data.success == "1"){
					   $('#hid_networkId').val(data.networkId);
						insertSubnet2(data.networkId);	
				}
				else{
					errorBox(data);
				}
			},
			error : function(request) {
				errorBox("네트워크 등록 실패:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	// 네트워크와 서브넷을 한번에 등록할때 사용
	function insertSubnet2(networkId){
		$.ajax({
			url : "${contextPath}/mng/oss/subnet/insert",
			dataType : "JSON",
			data : {
				"projectName" 	: $("#hid_projectName").val()
				, "networkId" 	: networkId
				, "networkName" : $("#netWokrName").val()
				, "subnetName" 	: $("#subNetworkName").val()
				, "cidr" 		: $("#ipAddr").val()
				, "ipVersion" 		: "4"
				, "gatewayIp" 		: $("#gateWay").val()
				, "enableDhcp" 		: $('input:radio[name="dhcp"]:checked').val()
				, "allocationPools" : $("#pools").val()
				, "dnsNameservers" 	: $("#dnsName").val()
				, "hostRoutes" 		: $("#host").val()
				, "regUserId" : '${userId}'
				, "modUserId" :  '${userId}'			
			},
			success : function(data) {
				if(data =="1"){
					
					alertBox("등록되었습니다.");
				}
			},
			error : function(request) {
			
				deleteNetwork(request);
			}
		});
	}
	
	//네트워크 삭제
	function deleteNetwork(obj){
		$.ajax({
			url : "${contextPath}/mng/oss/network/delete",
			dataType : "JSON",
			data : {
				"projectId" 		: $("#hid_projectId").val()
				, "projectName" 	: $("#hid_projectName").val()
				, "networkId" 		: $("#hid_networkId").val()
			},
			success : function(data) {
				/* if(data =="1"){
					alertBox("삭제되었습니다.", listNetwork);
				} */
				if(obj != undefined)
				errorBox("code:" + obj.status + "<br>" + "error:" + obj.responseText);
				
			},
			error : function(request) {
				if(obj != undefined)
					errorBox("code:" + obj.status + "<br>" + "error:" + obj.responseText);
				else
					errorBox("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	
	
	// 유효성 체크
	function validationChk(){
		
		if($("#netWokrName").val()==""){
			alertBox3("미할당 정책을 선택하세요.");
			return false;
		}
		if($("#netWorkAlias").val()==""){
			alertBox3("네트워크 별칭을 입력하세요.");
			return false;
		}
		if($("#subNetworkName").val()==""){
			alertBox3("서브넷 이름을 입력하세요");
			return false;
		}
		if($("#ipAddr ").val()==""){
			alertBox3("네트워크 주소를 입력하세요.");
			return false;
		}else if($("#ipAddr ").val().indexOf("*") != -1){
			alertBox3("네트워크 주소를 양식에 맞게 <br>입력하세요.");
			return false;
		}
		if($("#gateWay  ").val()==""){
			alertBox3("게이트웨이 IP 를 입력하세요.");
			return false;
		}else if($("#gateWay  ").val().indexOf("*") != -1){
			alertBox3("게이트웨이 IP 를 양식에 맞게 <br>입력하세요.");
			return false;
		}
		
		if( $('input:radio[name="dhcp"]:checked').val()==undefined ){
			alertBox3("dhcp 사용 여부를 체크 해주세요");
			return false;
		}

		alertBox("저장하시겠습니까?", insertNetwork);
	}
  // insertNetwork()
	// 프로젝트 정보 저장
	function actInsert() {
			$.ajax({
				url : "${contextPath}/mng/oss/project/insert",
				dataType : "JSON",
				type : "POST",
				data : {
					"regUserId" 		: "${userId}"
					, "modUserId" 		: "${userId}"
					, "customerId" 		: $("#customerId").val()
					, "projectName" 	: $("#projectName").val()
					, "projectNameOrg" 	: $("#projectNameOrg").val()
					, "projectAlias" 	: $("#projectAlias").val()
					, "description" 	: $("#description").val()
					, "projectId" 		: $("#hid_projectId").val()
				},
				success : function(data) {
					if(data.error == 1){
						alertBox("저장되었습니다.", movePage);
						
						if(data.projectId!=""){
							$("#hid_projectId").val(data.projectId);
							$("#hid_projectName").val(data.projectName);
						}
					}else if(data==1){
						alertBox("저장되었습니다.", movePage);
					}else{
						alertBox3("failed!!");
					}
				},
				error : function(request, status, error) {
					if(request.status == "200"){
						alertBox("로그인 대기시간이 종료되었습니다. <br>재로그인이 필요합니다.", reload);
					}else{
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				}
			});
	}
	
	// 수정시 상세 조회
	function getDetail() {
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
						if(i=="projectName"){
							$("#hid_projectName").val(val);
						}else if(i=="projectId") {
							$("#hid_projectId").val(val);
						}else if(i=="customerId") {
							$("#hid_customerId").val(val);
						}else if(i=="companyId") {
							$("#hid_companyId").val(val);
						}else{
							$("#"+i).text(val);
						}
					}
				});
			},
			error : function(request, status, error) {
				if(request.status == "200"){
					alertBox("로그인 대기시간이 종료되었습니다. <br>재로그인이 필요합니다.", reload);
				}else{
					alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
				}
			}
		});
	}
	

	//프로젝트 영문명 중복체크
	function projectNameChk(){
		
		if($("#projectName").val()==""){
			alertBox3("프로젝트 영문명을 입력하세요");
			return;
		}
		
		$.ajax({
			url : "${contextPath}/mng/oss/project/projectNameChk",
			data : {
				"projectName" : $("#projectName").val()
			},
			success : function(data) {
				var chkVal = data;
				if(chkVal==0){
					$("#confirmMsg").css("color","blue");
					$("#confirmFlag").val("Y");
					alertBox3("사용가능한 프로젝트명 입니다.");
					$("#confirmFlag").val("Y")
				}else{
					$("#confirmMsg").css("color","#ff0000");
					$("#confirmFlag").val("N");
					alertBox3("사용할 수 없는 프로젝트명 입니다.");
					$("#confirmFlag").val("N")
				}
			},
			error : function(request, status, error) {
				if(request.status == "200"){
					alertBox("로그인 대기시간이 종료되었습니다. <br>재로그인이 필요합니다.", reload);
				}else{
					alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
				}
			}
		});
		
	}
	
	function reload(){
		location.reload();
	}
	
	// 팝업메시지 세팅	
	function alertModal(txt){
		$("#confirmMsg").text(txt);
		$("#modal-dialog2").modal();
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/project/network/";
	}
	
	
	//페이지이동
	function movePage(){
		var params="";
		if($("#hid_projectId").val()==""){
			location.href = "${contextPath}/mng/oss/project/";
		}else{
			params = "?projectId="+$("#hid_projectId").val();
			params += "&projectName="+$("#projectName").val();
			location.href = "${contextPath}/mng/oss/project/view"+params;
		}
	}
	
	$(document).ready(function() {
		App.init();
		getDetail();
		
		//메뉴활성화
		$("#project").addClass("active");
		$("#projectNetwork").addClass("active");
		
		if($("#hid_projectId").val()!=""){
			getDetail(); 
		}
		
		$("#projectName").keypress(function(e){
			$("#confirmFlag").val("N");
		});
	
		$("#projectName").on('keyup',function(e){
			var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
			if(pattern.test(this.value)){
				$(this).val(this.value.replace(pattern, ''));
			}
			
 			var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
			if(pattern2.test(this.value)){
				$(this).val(this.value.replace(pattern2, ''));
			}
			 
			
			$(this).val(this.value.toUpperCase()); 
		});
 			
		$("#projectName").on('blur',function(e){
			var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
			if(pattern.test(this.value)){
				$(this).val(this.value.replace(pattern, ''));
			}
			
 			var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
			if(pattern2.test(this.value)){
				$(this).val(this.value.replace(pattern2, ''));
			}
			
			$(this).val(this.value.toUpperCase());
		});
	});
	
	function moveBackDetail(){
		history.back();
	/* 	var params = "?projectId="+projectId;
		params += "&projectName="+projectName;
		location.href = "${contextPath}/mng/project/network/view"+params; */
	}
</script>
</body>
</html>