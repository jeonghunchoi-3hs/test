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
				<h1>네트워크 관리</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책 관리</a><a href="#" class="on">네트워크</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<!-- search begin -->
				<div class="page_searchBox m-b-15">
					<div class="searchArea">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel" id="searchKind">
								<option value="">전체</option>				
								<option value="affiliateName">계열사명</option>
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 450px">
							<a type="button" class="bton-s bton_blue" onclick="gridList();"><i class="fa fa-search"></i> 검색</a>
						</div>
					</div>
				</div>
				<!-- search end -->
				
				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a type="button" class="bton-s bton_blue" onclick="excelDown();"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
						<!--  <a type="button" class="bton-s bton_blue" href="${contextPath}/mng/cmm/network/write"><i class="fa fa-upload"></i><span> 네트워크 정책 등록</span></a>-->
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
					<div class="tableWrap gridType01_aType">
						<table id="table-list">
						
							<colgroup>
								<col width="*">
								<col width="15%">
								<col width="10%">
								<col width="15%">
								<col width="10%">
								<col width="8%">
								<col width="6%">
							</colgroup>
							<thead>
								<tr>
									<th>네트워크ID </th>
									<th>네트워크명</th>
									<th>네트워크 별칭</th>
									<th>서브넷명</th>
									<th>서브넷 주소</th>
									<th>할당된IP</th>
									<th>상세</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				
				<div class="modal fade" id="modal-network-edit"> 
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">네트워크 정책 수정</h4>
	                       	</div>
	                       	<div class="modal-body p-b-10">
								<div class="client_DetailBg tal m-b-20">
									<input type='hidden' id='pop_networkId'>
									<input type='hidden' id='pop_ipAddr'>
									<div class="client_DetailArea">
										<dl>
											<dt id='pop_customerHeardName'></dt>
											<dd id='pop_affiliateName'></dd>
										</dl>
										<p class="company_Info"> 
											<span class="company_labelf">업무 :</span><span class="company_cont" id="pop_workKindName"></span>
											<span class="company_label">업무네트워크 :</span><span class="company_cont" id="pop_workNetKindName"></span>
										</p>
										<p class="company_Info m-b-25 m-t-15"> 
											<span class="company_label lineChange">네트워크 정책 :</span><span class="company_cont fontVdn" id="pop_ipAddrView"></span>
										</p>
									</div> 
								</div>
								<div class="networkNumBox clearfix m-b-20">
									<input type="text" style="width:90px;" id='pop_ipAddr0' onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"/>
									<span class="txt"></span>
									<input type="text" style="width:80px;" id='pop_ipAddr1' onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"/>
									<span class="txt"></span>
									<input type="text" style="width:80px;" id='pop_ipAddr2' onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"/>
									<span class="txt"></span>
									<input type="text" style="width:80px;" id='pop_ipAddr3' onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"/>
									<span class="slash">/</span> 
									<input type="text" style="width:80px;" id='pop_ipAddr4' onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"/>
								</div>
								
								<div class="networkPolicyList">
									<p class="txt_guide_type01">네트워크정책은 아래와 같습니다. 정책에 맞게 수정해주세요.</p>
									<ul>
										<li>
											<span class="statusLabel_type02 label_03">운영</span>
											<span class="category fontVdn">DMZ</span>
											<span class="netW">*.*.1.0/24</span>
										</li>
										<li>
											<span class="statusLabel_type02 label_03">운영</span>
											<span class="category">내부</span>
											<span class="netW">*.*.2.0/23</span>
										</li>
										<li>
											<span class="statusLabel_type02 label_02">검증</span>
											<span class="category fontVdn">DMZ</span>
											<span class="netW">*.*.4.0/24</span>
										</li>
										<li>
											<span class="statusLabel_type02 label_02">검증</span>
											<span class="category">내부</span>
											<span class="netW">*.*.5.0/24</span>
										</li>
										<li>
											<span class="statusLabel_type02 label_01">개발</span>
											<span class="category fontVdn">DMZ</span>
											<span class="netW">*.*.7.0/24</span>
										</li>
										<li>
											<span class="statusLabel_type02 label_01">개발</span>
											<span class="category">내부</span>
											<span class="netW">*.*.8.0/23</span>
										</li>
										<li>
											<span class="statusLabel_type02 label_04">관리</span>
											<span class="category">내부</span>
											<span class="netW">*.*.10.0/24</span>
										</li>
									</ul>
								</div>
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="pbton bton_blue" onclick="actUpdatePopup();"> 확인</a>
		                       <a type="button" class="pbton bton_dgrey" data-dismiss="modal"> 취소</a>
	                       </div>
		               	</div>
					</div>
	            </div>
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
	
	function gridList() {
		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/network/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[ 
				{"data":"customerHeardName" , "class":"tal"}
				, {"data":"affiliateName" , "class":"tal name"}
				, {"data":"workKindName" , "class":"tac"}
				, {"data":"workNetKindName" , "class":"tac"}
				, {"data":"ipAddr" , "class":"tac"}
				, {"data":"" , "class":"tac"}
				, {"data":"" , "class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" } 
				, {"targets":[2], "render": function(data,type,full){
					if(full.workKindName=="관리"){
						return '<span class="ing">관리</span>';
					}else if(full.workKindName=="개발"){
						return '<span class="comp">개발</span>';
					}else if(full.workKindName=="운영"){
						return '<span class="reject">운영</span>';
					}else
						return '<span class="veri">'+full.workKindName+'</span>'; 
					}	
				}
				, {"targets":[6], "render": function(data,type,full){
					<!--return '<a type="button" class="cbton bton_lblue" onclick="moveEditPage(\''+full.networkId+'\',\''+full.customerHeardName+'\',\''+full.affiliateName+'\',\''+full.workKindName+'\',\''+full.workNetKindName+'\',\''+full.ipAddr+'\');"><i class="fa fa-search"></i></a>';-->
					return "<a href='javascript:void(0);' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.networkId+"\")'><i class='fa fa-search'></i> </a>";
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
	
	function moveDetailPage(noticeNo){
		location.href = "${contextPath}/mng/cmm/network/detail?networkId="+noticeNo;
 	}

	function excelDown(){
		var params = "";
		params += "&searchKind="+$("#searchKind option:selected").val();
		params += "&keyword="+$("#keyword").val();
		location.href = '${contextPath}/mng/cmm/network/excel?'+params;
	}	

	function moveEditPage(networkId, customerHeardName, affiliateName, workKindName, workNetKindName, ipAddr){
		$("#pop_networkId").val(networkId);
		$("#pop_ipAddr").val(ipAddr);
		
		$("#pop_customerHeardName").text(customerHeardName);
		$("#pop_affiliateName").text(affiliateName);  
		$("#pop_workKindName").text(workKindName);
		$("#pop_workNetKindName").text(workNetKindName);
		$("#pop_ipAddrView").text(ipAddr);
		$("#pop_ipAddr0").val(ipAddr.split('.')[0]);
		$("#pop_ipAddr1").val(ipAddr.split('.')[1]);
		$("#pop_ipAddr2").val(ipAddr.split('.')[2]);
		$("#pop_ipAddr3").val(ipAddr.split('.')[3].split('/')[0]);
		$("#pop_ipAddr4").val(ipAddr.split('.')[3].split('/')[1]);
		$("#modal-network-edit").modal();
	}
	
	function actUpdatePopup(){
		if( $("#pop_ipAddr").val() == ($("#pop_ipAddr0").val()+"."+$("#pop_ipAddr1").val()+"."+$("#pop_ipAddr2").val()+"."+$("#pop_ipAddr3").val()+"/"+$("#pop_ipAddr4").val())){
			$("#modal-network-edit").modal('hide');
		}else{
			if($("#pop_ipAddr0").val()==""
					|| $("#pop_ipAddr1").val()==""
					|| $("#pop_ipAddr2").val()==""
					|| $("#pop_ipAddr3").val()==""
					|| $("#pop_ipAddr4").val()==""
				)
			{
				alertBox3("IP대역에 공백을 입력할수 없습니다.");
				return false;
			}
			
			$.ajax({
				url : "${contextPath}/mng/cmm/network/insert",
				dataType : "JSON",
				data : {
					networkId	: $("#pop_networkId").val()
					, aClass	: $("#pop_ipAddr0").val()
					, bClass	: $("#pop_ipAddr1").val()
					, cClass	: $("#pop_ipAddr2").val()
					, cidr		: "/"+$("#pop_ipAddr4").val()
					, modUserId	: "${userId}"
				},
				success : function(data) {
					if(data == "1"){
						$("#modal-network-edit").modal('hide');
						alertBox("변경되었습니다.", gridList);
					}else{
						alertBox3("변경이 실패하였습니다.");
					}
				},
				error : function(request, status, error) {
					if(request.status == '200'){
						alertBox("접속이 만료되었습니다.", logout);				
					}else{
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				} 
			});
			
		}
	}
	
	$(document).ready(function() {
		App.init();
 		gridList();
		
		//메뉴활성화
		$("#operation").addClass("active");
		$("#cmmNetwork").addClass("active");
	});
</script>
</body>
</html>