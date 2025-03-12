<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
			
			<div class="page_header mb30">
				<h1>회원사 관리</h1>
				<div class="pageNav">
						<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">회원사 관리</a>
				</div>
			</div>
			
			<div class="row mb50">
			
			   
			   
			
				
					<div class="client_DetailArea row">
						<h2 class="customer_Id">${customerId}</h2>
						<input type="hidden" id="hid_customerId" value="${customerId}">						
						<div class="comp_btn_Area">
						
						<c:forEach items="${file}" var="filelist" varStatus="status" >
									<a href="${contextPath}/mng/cmm/file/download/${filelist.fileId}" class="bton-s lton_green enable"><span class="txt"><i class="fa fa-newspaper-o"></i> 사업자등록증</span></a>
						</c:forEach>
						
						<c:if test = "${filesCnt < 1}" >
						<a href="#" class="bton-s lton_green disabled"><span class="txt"><i class="fa fa-newspaper-o"></i> 사업자등록증</span></a>
						
						</c:if>
						  	<%-- <td class="f14 fb">												
								<c:forEach items="${file}" var="filelist" varStatus="status" >
									<div><a href="${contextPath}/mng/cmm/file/download/${filelist.fileId}">${filelist.fileName}</a></div>
								</c:forEach>http://localhost:8081/mng/cmm/file/download/20171107-74fe2805-968f-4e06-8197-7fa9d87c7f2b
						  	</td> --%>
							<a type="button" class="bton-s lton_blue" onclick="bssAdjustmentedit();"><span class="txt"><i class="fa fa-edit"></i> 정보수정</span></a>
						</div>
						<p class="customer_Name"><!-- <span id ="upCompanyName"></span><span class="company_Name" id="downCompanyName"> --></span></p>
		
						<div class="col-xs-12 pl0">
						<p class="company_Info">
							<span class="company_labelf">사업자명 :</span><span class="company_cont" id="customerName"></span>
							<span class="company_label">사업자등록번호 :</span><span class="company_cont fontVdn" id="companyNo"></span>
							<span class="company_label ml10">법인등록번호 :</span><span class="company_cont fontVdn" id="corporationNo"></span>
							<span class="company_label">대표자명 :</span><span class="company_cont" id="companyRep"></span>
						</p>								
						<table>
							<colgroup>
								 <col width="67px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<td><span class="typebis_label">업태</span></td>
								  	<td class="">
										<span class="typebis_cont" id="bizCondition"></span>
								  	</td>
								</tr>  
								<tr>
									<td><span class="typebis_label">업종</span></td>
								  	<td class="">
										<span class="typebis_cont" id="bizType"></span>
								  	</td>
								</tr> 
							</tbody>
						</table>
						</div>
						<div class="col-xs-12 pr0 pl0">
						<div class="manager_Info">
							<h2> <i class="fa fa-user"></i> 관리자정보 <a href="javascript:openModal();" class="bton-ss bton_blue flr"><span class="txt"><i class="fa fa-user-circle-o"></i> 관리자설정</span></a></h2>
							
							<div id = 'adminArea'>
							<div class="mt15"> 
								<span class="manager_Name" id="managerName"></span>
								<span class="manager_Id_label">(ID : <span class="manager_Id" id="managerId"></span>)</span>
								<input type="hidden" name="managerName" id="managerName" value=""/>
							</div>
							<div class="mt10"> 
								<span class="cc bton_lblue"><i class="fa fa-phone"></i></span> <span class="manager_Tel" id="managerTel"></span>
								<span class="cc bton_lgreen ml20"><i class="fa fa-mobile"></i></span> <span class="manager_Phone" id="managerPhone"></span>
								<span class="cc bton_lorange ml20"><i class="fa fa-envelope-o"></i></span> <span class="manager_Mail" id="managerMail"></span> 
							</div>
							</div>
						</div>
						 </div>
						
						
						
						
					</div> 
				
				
				
				
				<div class="dpno">
					<div class="col-md-2 p10"> 
					</div>
					<div class="col-md-8 p10"><input type="text" class="form-control" placeholder="검색어를 입력하세요" id="network_keyword"  onkeypress="if(event.keyCode==13)gridNetwork();"/></div>
				</div>	 
			   <!-- <div class="gridTableWrap gridType02 m-t-40">
			    	<div class="tableWrap">
				    	<h2 class="titleBuType01 mb15">네트워크 정책</h2>
				        <table class="dataTable" id="network-list" style="border-bottom: 0px none;">
				        	<colgroup>
						 		<col width="150px">
						 		<col width="160px">
						 		<col width="*">
						 		<col width="150px">
						 		<col width="180px">
						 	</colgroup> 
							<thead>
							    <tr class="grey">
									<th class='tac'>업무 구분</th>
									<th class='tac'>네트워크 구분</th>
									<th class='tac'>네트워크 주소</th>
									<th class='tac'>등록자</th>
									<th class='tac'>등록일시</th>
								</tr>
							</thead>
						</table>
					</div>
				</div> --> 
				
				<div class="row tac mt20">		
					<a type="button" class="rbton bton_blue" onclick="bssAdjustmentlist();"><i class="fa fa-list"></i> 목록</a>         
				</div>
                   
                  
				<!-- #modal-dialog -->
                 <div class="modal fade" id="modal-dialog"> 
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">관리자 설정</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="page_searchBox m-b-15">
									<div class="searchArea">
										<div class="inputArea m-l-5">
											<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)openModal();" style="width: 362px">
											<a type="button" class="bton-s bton_blue" onclick="openModal();"> <i class="fa fa-search"></i> 검색</a>
										</div>
									</div>
								</div>
								
							
								
									<table class="tableV">
									 <colgroup>
									 <col width="25%">
									 <col width="25%">
									 <col width="*">
									 <col width="10%">
									 </colgroup>
									 <thead>
									 <tr>
										<th>이름</th>
										<th>사번</th>
										<th>부서</th>
										<th>버튼</th>
									 </tr>
									 </thead>
									 <tbody id="popListTable">
									 
									 </tbody>
							 	    </table>	
							 	    
							 	 <div class="popListTable2" style="display: none;">
									 <span>검색된 사용자가 없습니다.</span>
								</div> 
								
	                      		<div class="totalcnt" id="totalCnt">총 4 건</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="pbton bton_blue" data-dismiss="modal" >닫기</a>
	                       	</div>
		               	</div>
					</div>
                 </div>
                 <!-- 청구요금 상세 -->
				<!-- #modal-dialog -->
				<%-- <div class="modal fade" id="bill-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">청구요금 상세</h4>
	                       </div>
	                       <div class="modal-body">
								<div class="tableB">
									<table>
										<colgroup>
									 		<col width="200px;">
									 		<col width="*">									 		
									 	</colgroup>
									 	<tbody id="billDetailTable">											
											
										</tbody>									
									</table>
								</div>
								
								<div class="col-md-12 disk p10 mt5 mb20" id="totalDiv">
<!-- 									<div class="col-md-8 fc66 f24 pr0">총 청구요금</div> -->
<!-- 									<div class="col-md-4 f24 fc-red tar pr0 vm"><span id="totalAmount"></span><span class="f12 fc66 pl4">원</span></div> -->
								</div>
							</div>
							<div class="clear"></div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="btn btn-default width-80" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div> --%>
				<!-- #modal-dialog -->
                   
				<%-- <div class="modal fade" id="popNetwork-modal-dialog" >
	               <div class="modal-dialog" style='width:800px;'>
	                   <div class="modal-content" >
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">고객사 네트워크 등록</h4>
	                       </div>
	                       <div class="modal-body">

								<!--search begin-->
								<div class="col-md-12 br10 mb10"  style='width:760px;background-color: #eeeeee !important;'>		
									<div class="col-md-2 p10"> 
										<select class="form-control pb6" id="popNetwork_searchKind">
											<option value="customerHeardName">본사</option>
											<option value="affiliateName">계열사명</option>
											<option value="workKindName">업무</option>
											<option value="workNetKindName">네트워크</option>
										</select>
									</div>
									<div class="col-md-8 p10"><input type="text" class="form-control" placeholder="검색어를 입력하세요" id="popNetwork_keyword"  onkeypress="if(event.keyCode==13)gridPopNetwork();"/></div>
									<div class="col-md-1 p10 ml-5">
										<button type="button" class="btn btn-grey" onclick="gridPopNetwork()"><i class="fa fa-search"></i> 검색</button>
									</div>
								</div>	
								
								<!-- 테이블시작 -->
								<div class="col-md-12">
									<div class="panel">
									    <div class="table-responsive">
									        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="popNetwork-list">
												<thead>
												    <tr class="grey">
														<th class='tac'>본사</th>
														<th class='tac'>계열사명</th>
														<th class='tac'>업무 구분</th>
														<th class='tac'>네트워크 구분</th>
														<th class='tac'>네트워크 주소</th>
														<th class='tac'>등록</th>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								</div>
							</div>
							<div class="clear"></div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="btn btn-default width-80" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>   --%>                 
	
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
	
	function movePageDetail(projectId, projectName){
		var params = "?projectId="+projectId;
		params += "&projectName="+projectName;

		location.href = "/mng/oss/project/view"+params;
	}

	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/cmm/customer/detail",
			dataType : "JSON",
			data : {
				"customerId" : $("#hid_customerId").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){					
					if(val != null || i=="managerId"){
						if(i=="managerId"){ 
						
							if(val != null){
								$("#adminArea").show();
								$("#"+i).html(val);
							}else{
								$("#adminArea").hide();
							}
						}else if(i=="vatRate"){
							$("#"+i).text(val+" %");
						}else{
							$("#"+i).text(val);	
						}
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	//modal팝업 open
	function openModal(){
		$("#modal-dialog").modal();
		var customerId="${customerId}";		
		var keyword = $("#searchKeyword").val();
		$.ajax({
			url : "userListModal",
			dataType : "JSON",
	//			type : "POST",
			data : {
				"customerId" : customerId	
				,"keyword" : keyword 
			},
			success : function(data) {
				
				if(data.getCustomerMemberList.length == 0){
					$("#popListTable").hide();
					$("#popListTable2").show();
				}else{
					$("#popListTable").empty();
					
					$.each(data.getCustomerMemberList, function(key,val){
						$("#popListTable").append(
								 '<tr>'
								+'<td>'+val.userName+'</td>'
								+'<td>'+val.userId+'</td>'
								+'<td>'+val.deptName+'</td>'
								+'<a class="applybtn" onclick="insertAdmin(this, \''+val.userId+'\');">적용</a>'
								+'<td class="tac"><input type="button"  value="&#xf00c"  class="popCheckbtn"  onclick="customadminSet(\''+val.userId+'\' , \''+val.userAuthority+'\');" initModal();></td>'
								+'</tr>');
					});
					$("#popListTable").show();
					$("#popListTable2").hide();
				}
				totalCnt = data.getCustomerMemberList.length;
				$("#totalCnt").text("총 "+totalCnt+" 건");
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
	
	function customadminSet(userId,userAuthority){
		$.ajax({
			url : "${contextPath}/mng/cmm/customer/customadminInsert",
			dataType : "JSON",
			type : "POST",
			data : {"userId" : userId,"customerId" : '${customerId}',"userAuthority" : userAuthority},
			success : function(data) {
				var result = data;	
				$("#modal-dialog").modal("hide");
				alertBox("고객사 관리자가 적용되었습니다.", getDetail);
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	
	// 청구요금 조회
	/* function chargeList() {
		
		var yy = $("#billYear option:selected").val();
		var mm = $("#billMonth option:selected").val();
		var billYyyymm = yy+mm;
		$("#charge-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/charge/bill/list"
				,"type" : "GET"
				,"data":function (d) {
					d.billYyyymm = billYyyymm;
// 					d.searchKind = $("#billSearchKind option:selected").val();
// 					d.keyword = $("#billKeyword").val();
					d.customerId = $("#hid_customerId").val();
				}
			}
			,"columns":[ 
				{"data":"billYyyymm", "class":"tac"} 
	        	, {"data":"customerId", "class":"tac"}
	        	, {"data":"customerName", "class":"tac"}
// 	        	, {"data":"projectId", "class":"tac"}
// 	        	, {"data":"projectAlias", "class":"tac"}
	        	, {"data":"totAmount", "class":"tar fc-blue fb"}
	        	, {"data":"dcAmount", "class":"tar fc-blue fb"}
	        	, {"data":"totAmount", "class":"tar fc-red fb"} 
	        	, {"class":"tac", "width":"5%"}
	        ]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[1],"visible":false,"searchable":false }
// 				, {"targets":[3],"visible":false,"searchable":false }
				, {"targets":[3],"render":function(data,type,full){
					return addcomma(full.totAmount);
				} }
				, {"targets":[4],"render":function(data,type,full){
					return addcomma(full.dcAmount);
				} }
				, {"targets":[5],"render":function(data,type,full){
					return addcomma(full.totAmount);
				} }
				, {"targets":[6],"render":function(data,type,full){
					return '<button class="btn btn-grey_01 width-40 tac" onclick="billDetailPop(\''+full.customerId+'\',\''+full.billYyyymm+'\')"><i class="fa fa-search ml-2"></i></button>';
				} }
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
	}
	
	// 청구서 상세
	function billDetailPop(customerId, billYyyymm){
		$("#bill-modal-dialog").modal();
		$.ajax({
			url : "${contextPath}/mng/charge/bill/detail",
// 			dataType : "JSON",
	//			type : "POST",
			data : {
				"customerId" : customerId
				,"billYyyymm" : billYyyymm
			},
			success : function(data) {
				var billInfoList = data.detail;
				
				$("#billDetailTable > tr").remove();
				$("#totalAmount").text("");
				
				if(billInfoList!=""){
					var vHtml = '<div class="col-md-8 fc66 f24 pr0">총 청구요금</div>';
					vHtml += '<div class="col-md-4 f24 fc-red tar pr0 vm"><span id="totalAmount"></span><span class="f12 fc66 pl4">원</span></div>';
					$("#totalDiv").html(vHtml);
					
					var Html = "";
					$.each(billInfoList,function(key,val){
						
						var billLevel = val["invoiceItem"];
						
						if(billLevel=="A000"){	//클라우드 자원
							Html="<tr class='bgee'><td class='f18 fb tal'><i class='fa fa-cloud'></i> "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						
						}else if(billLevel=="AA00"){	//기본 자원
							Html = Html + "<tr class='vm'><td class='t-in16'><i class='fa fa-arrow-circle-o-down f12'></i>"+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fc66 f16 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="AAA0"){	//가상 서버
							Html = Html + "<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 rtd'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="AE00"){	//부가자원
							Html = Html + "<tr class='bgf5 accordion-toggle accordion-toggle-styled' data-toggle='collapse' data-parent='#accordion' href='#collapse3'><td class='t-in16'><i class='fa fa-arrow-circle-o-down f12'></i>"+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fc66 f16 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";	
							
						}else if(billLevel=="AEA0"){	//블록디스크
							Html = Html + "<tr><td class='t-in56'>· "+val["invoiceItemName"]+"("+val["disk_alias"]+")</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="AEB0"){	//NAS
							Html = Html + "<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
							
						}else if(billLevel=="AI00"){	//서비스
							Html = Html + "<tr class='bgf5'><td class='t-in16'><i class='fa fa-code-fork'></i>"+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fc66 f16 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="AIA0"){	//형상관리 서비스
							Html = Html + "<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";	
						}else if(billLevel=="AIB0"){	//대외계 서비스
							Html = Html + "<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";	
						
						}else if(billLevel=="E000"){	//요금할인
							Html = Html + "<tr class='bgee'><td class='f18 fb'><i class='fa fa-won'></i> "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="EA00"){	//프로젝트 할인
							Html = Html + "<tr><td class='t-in38'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="EL00"){	//10원 미만 절사 할인
							Html = Html + "<tr><td class='t-in38'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						
						}else if(billLevel=="I000"){	//보정	
							Html = Html + "<tr class='bgee'><td class='f18 fb'><i class='fa fa-wrench'></i> "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="IA00"){	//보정명칭
							Html = Html + "<tr><td class='t-in16'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
							
						}else if(billLevel=="L000"){	//부가가치세(세금)
							Html = Html + "<tr class='bgee'><td class='f18 fb'><i class='fa fa-yelp'></i> "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="LA00"){	//부가가치세
							Html = Html + "<tr><td class='t-in38 vm'>· "+val["invoiceItemName"]+"</td>";
							Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						}else if(billLevel=="0000"){	//총 청구금액
							$("#totalAmount").text(addcomma(val["amount"]));
						}
						
					});
					$("#billDetailTable").html(Html);	
				}else{
					var vHtml = '<div class="col-md-8 fc66 f24 pr0">청구요금이 없습니다.</div>';
					$("#totalDiv").html(vHtml);
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	} */
	
	
 	function projectPminsert(){
		window.open('coustomadminPopList?customerId=${customerId}','_blank','');			
	}

	function bssAdjustmentlist(){
 		location.href = "${contextPath}/mng/cmm/customer/";
 	}
	
	function bssAdjustmentedit(){
 		location.href = "${contextPath}/mng/cmm/customer/edit?customerId=${customerId}";
 	}
	
	
	function gridNetwork(){
		$("#network-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/network/customerlist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#network_searchKind option:selected").val();
					d.keyword = $("#network_keyword").val();
					d.customerId = $("#hid_customerId").val();
				}
			}
			,"columns":[ 
				{"data":"workKindName" , "class":"tac bold"}
				, {"data":"workNetKindName" , "class":"tac"}
				, {"data":"ipAddr" , "class":"tac blue fontVdn"} 
				, {"data":"regUserName" , "class":"tac"}
				, {"data":"regDatetime2" , "class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
			]
			,"order": [[0,"desc"]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.11</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom">'
		}); 
	}
	
	function deleteNetwork(networkId){
		/* confirmBox("삭제하시겠습니까?" , actDeleteNetwork, {
			networkId: networkId
			, customerId : $("#hid_customerId").val()
		}); */
		actDeleteNetwork({
			networkId: networkId
			, customerId : $("#hid_customerId").val()
		});
	}
	
	function actDeleteNetwork(obj){
		$.ajax({
			url : "${contextPath}/mng/cmm/network/customerDelete",
			dataType : "JSON",
			data : obj,
			success : function(data) {
				//alertBox("삭제되었습니다.", gridNetwork);
				gridNetwork();
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	function insertNetwork(networkId){
		/* confirmBox("등록하시겠습니까?" , actInsertNetwork, {
			networkId: networkId
			, customerId : $("#hid_customerId").val()
		}); */
		
		actInsertNetwork({
			networkId: networkId
			, customerId : $("#hid_customerId").val()
		});
	}
	
	function actInsertNetwork(obj){
		$.ajax({
			url : "${contextPath}/mng/cmm/network/customerInsert",
			dataType : "JSON",
			data : obj,
			success : function(data) {
				//alertBox("등록되었습니다.", gridPopNetwork);
				if(data == "1"){
					gridPopNetwork();	
				}else{
					alertBox3("이미 동일한 종류의 네트워크망이 등록되어있습니다.");
				}
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	function gridPopNetwork(){
		$("#popNetwork-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/network/customerPopList"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#popNetwork_searchKind option:selected").val();
					d.keyword = $("#popNetwork_keyword").val();
					d.customerId = $("#hid_customerId").val();
				}
			}
			,"columns":[ 
				{"data":"customerHeardName" , "class":"tac"}
				, {"data":"affiliateName" , "class":"tac"}
				, {"data":"workKindName" , "class":"tac"}
				, {"data":"workNetKindName" , "class":"tac"}
				, {"data":"ipAddr" , "class":"tac"}
		        , {"class":"tac", "width":"10%"} 
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[5], "render": function(data,type,full){
					return "<button type='button' class='btn btn-grey width-80' onclick='insertNetwork(\""+full.networkId+"\")' >등록</button>";
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
	
	$(document).ready(function() {
		App.init();
		getDetail();
		gridNetwork();
		
		$("#popNetwork-modal-dialog").on('hidden.bs.modal', function(){
			gridNetwork();
			$("#popNetwork_searchKind").val("customerHeardName");
			$("#popNetwork_keyword").val("");
		});
		//메뉴활성화
		$("#customerInfo").addClass("active");
	});
	
</script>

</body>
</html>