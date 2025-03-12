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
			
			
				
					<h2 class="titleBuType01 mb10">네트워크 정보 </h2>
						<table class="tableH">
							<colgroup>
								 <col width="*">
								 <col width="16%">
								 <col width="16%">
								 <col width="16%">
								 <col width="16%">
								 <col width="16%">
							</colgroup>
								<tr>
									<th>네트워크 명</th>
									<td colspan="5" >
										 Qa_PROO_ERP 
									</td> 
								</tr>
								<tr> 
									<th>네트워크 별칭</th>
									<td colspan="5">
									     <input type="text" class="input_int w80"/> <button class="cc bton_dgrey"> <i class="fa fa-edit"></i> </button> <button class="cc bton_blue"> <i class="fa fa-check"></i> </button> <button class="cc bton_orange"> <i class="fa fa-times"></i> </button>
									</td> 
								</tr>
								<tr>
								  <th>
										관리자 상태
									</th>
									<td>
									   UP
									</td> 
									<th>외부</th>
									<td>NO</td>
									<th>상태</th>
									<td>ACTICVE</td>
								</tr>
							</tbody>
						</table>

				
				
					<h2 class="titleBuType01 mb10 mt20">서브넷 정보 </h2> 
						<table class="tableH_g">
							<colgroup>
								 <col width="*">
								 <col width="16%">
								 <col width="16%">
								 <col width="16%">
								 <col width="16%">
								 <col width="16%">
							</colgroup>
								<tr>
									<th>
										서브넷 이름
									</th>
									<td colspan="5">
										QA_PROD_ERP_SUB
									</td> 
								</tr>
								<tr>
									<th>
										서브넷 주소
									</th>
									<td colspan="5">
										192.168.7.0/24
									</td> 
								</tr>
								<tr>
									<th>
										관리자 상태
									</th>
									<td>
										192.168.70.1
									</td> 
									<th>DNS</th>
									<td>192.168.70.11</td>
									<th>DHCP 사용</th>
									<td>NO</td>
								</tr>
							</tbody>
						</table>

				
				
				
				
				
				<h2 class="titleBuType01 mb10 mt20">IP주소 이용현황 </h2> 
					<!-- 상단 버튼  -->
					<div class="btnArea flr mt20 mb10">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
						<table class="tableV">
							<colgroup>
								<col width="*">
								<col width="20%">
								<col width="20%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">ID</th>
									<th scope="col">IP주소</th>
									<th scope="col">연결된 장치</th>
									<th scope="col">상태</th>
									<th scope="col">관리자 상태 </th>
								</tr>
							</thead>
							<tbody>
							<tr>
							<td>B2203d5b-1234-5678-1234-3f0769705013
							</td>
							<td>192.168.70.121
							</td>
							<td>CLWEB001L1
							</td>
							<td>Active</td>
							<td>UP</td>
							</tr>
							<tr>
							<td>1</td><td>2</td><td>3</td><td>4</td><td>5</td>
							</tr>
							<tr>
							<td>1</td><td>2</td><td>3</td><td>4</td><td>5</td>
							</tr>
							<tr>
							<td>1</td><td>2</td><td>3</td><td>4</td><td>5</td>
							</tr>
							</tbody>
						</table>
						
					<div class="bottom">
					   <ul class="dpin fl mt20">총 100건 </ul>
	                   <ul class="pagination flr">
                                <li class="disabled"><a href="javascript:;">Pre</a></li>
                                <li class="active"><a href="javascript:;">1</a></li>
                                <li><a href="javascript:;">2</a></li>
                                <li><a href="javascript:;">3</a></li>
                                <li><a href="javascript:;">4</a></li>
                                <li><a href="javascript:;">5</a></li>
                                <li><a href="javascript:;">Next</a></li>
                            </ul>
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
				{"data":"customerHeardName" , "class":"tal p-l-30"}
				, {"data":"affiliateName" , "class":"tal name"}
				, {"data":"workKindName" , "class":"tac"}
				, {"data":"workNetKindName" , "class":"tac"}
				, {"data":"ipAddr" , "class":"tac fontVdn"}
				, {"data":"regDatetime2" , "class":"tac fontVdn"}
				, {"data":"regUserName" , "class":"tac"}
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
				, {"targets":[7], "render": function(data,type,full){
					return '<a type="button" class="cbton bton_lblue" onclick="moveEditPage(\''+full.networkId+'\',\''+full.customerHeardName+'\',\''+full.affiliateName+'\',\''+full.workKindName+'\',\''+full.workNetKindName+'\',\''+full.ipAddr+'\');"><i class="fa fa-search"></i></a>';
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