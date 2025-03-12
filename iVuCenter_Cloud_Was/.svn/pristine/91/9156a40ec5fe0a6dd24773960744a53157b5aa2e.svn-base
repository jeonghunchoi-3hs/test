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
			
			
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>정산 승인</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">작업 승인 처리</a><a href="#" class="on">정산 승인</a>
				</div>
			</div>
			<!-- end header -->
			
	        <!-- start cloud -->
            <input type="hidden" id="cloudSearchId" value="${getCloudList[0].cloudId}">
             <ul class="nav nav-pills ml-10 mb10" id="tabNavi">
			<c:forEach items="${getCloudList}" var="getCloudList" varStatus="status" >
             <li class="ml10" id='${getCloudList.cloudId}'><a href="#nav-pills-tab-2" data-toggle="tab"  onclick="cloudSearchId('${getCloudList.cloudId}');">${getCloudList.cloudName}</a></li>
			</c:forEach>
		</ul>
             <!-- end cloud -->
			<!-- begin page-body -->
			<div class="row pb50">
			
				<div class="page_searchBox m-b-15">
					<div class="pull-left m-l-50">
						<div class="selectBox" style="width:120px;">
							<label class="selectText">전체</label>
							<select class="search-sel" id="billYear">
								<option value="">전체</option>
								<c:forEach items="${yearList}" var="list" varStatus="status" >
									<option value="${list.YEAR}">${list.YEAR}</option>
								</c:forEach>			
							</select>
						</div>
						<span class="selectTxt m-r-10">년</span>
						<div class="selectBox m-l-5" style="width:120px;">
							<label class="selectText">전체</label>
							<select class="search-sel" id="billMonth">
								<option value="">전체</option>
								<option value="01">01</option>
								<option value="02">02</option>
								<option value="03">03</option>
								<option value="04">04</option>
								<option value="05">05</option>
								<option value="06">06</option>
								<option value="07">07</option>
								<option value="08">08</option>
								<option value="09">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
						</div>
						<span class="selectTxt">월</span>
					</div>
					<div class="searchArea pull-right m-r-50">
						<div class="inputArea">
							<a type="button" class="btn_search" onclick="gridList()">검색</a>
						</div>
					</div>
				</div>
				<!-- //search Box -->
			
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a onclick="excelDown();" type="button" class="btnType01 m-r-5"><i class="ico_download"></i><span>다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-15">
						<table id="calculateListTable" summary="정상 승인">
						<caption>게시판 목록 : 정산년월, 승인상태, 정산자, 정산일시, 확정자,확정일시, 상세로 구성</caption> 
							<colgroup>
								<col width="124">
								<col width="128">
								<col width="181">
								<col width="179">
								<col width="115">
								<col width="178">
								<col width="67">
							</colgroup>
							<thead>
								<tr>
									<th class="tac"  scope="col">정산년월</th>
									<th class="tac"  scope="col">승인상태</th>
									<th class="tac"  scope="col">정산자</th>
									<th class="tac"  scope="col">정산일시</th>
									<th class="tac"  scope="col">확정자</th>
									<th class="tac"  scope="col">확정일시</th>
									<th class="tac"  scope="col">상세</th>
								</tr>
							</thead>
							<tbody>
								<!-- <tr>
									<td class="fontVdn">2017-12</td>
									<td><span type="button" class="comp">완료</span></td>
									<td class="fontVdn">BATCH_SYSTEM</td>
									<td class="fontVdn">2017-11-13 23:33</td>
									<td>관리자1</td>
									<td class="fontVdn">2017-11-13 23:33</td>
									<td><a type="button" class="btn_viewDetail"></a></td>
								</tr>
								<tr>
									<td class="fontVdn">2017-12</td>
									<td><span type="button" class="ing">처리중</span></td>
									<td class="fontVdn">BATCH_SYSTEM</td>
									<td class="fontVdn">2017-11-13 23:33</td>
									<td>관리자1</td>
									<td class="fontVdn">2017-11-13 23:33</td>
									<td><a type="button" class="btn_viewDetail"></a></td>
								</tr>
								<tr>
									<td class="fontVdn">2017-12</td>
									<td><span type="button" class="reject">반려</span></td>
									<td class="fontVdn">BATCH_SYSTEM</td>
									<td class="fontVdn">2017-11-13 23:33</td>
									<td>관리자1</td>
									<td class="fontVdn">2017-11-13 23:33</td>
									<td><a type="button" class="btn_viewDetail"></a></td>
								</tr> -->
							</tbody>
						</table>
					</div>
				</div>
			
			
			
			
			<!-- search begin
			<div class="col-md-12 bgee br10 mb10">		
				<div class="col-md-2 p10">
					<select class="form-control w70 dpin pb6" id="billYear">
					<option value="">전체</option>
					<option value="2017">2017</option>
					</select>
					<span>년</span>
				</div>
				<div class="col-md-2 p10">
					<select class="form-control w70 dpin pb6" id="billMonth">
					<option value="">전체</option>
					<option value="01">01</option>
					<option value="02">02</option>
					<option value="03">03</option>
					<option value="04">04</option>
					<option value="05">05</option>
					<option value="06">06</option>
					<option value="07">07</option>
					<option value="08">08</option>
					<option value="09">09</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					</select>
					<span>월</span>
				</div>
				<div class="col-md-6 p10">  
 				<input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword"  onkeypress="if(event.keyCode==13)gridList();"/> 
				</div>
				<div class="col-md-1"><a href="#"><button type="button" class="btn btn-grey w-80">검색</button></a> </div> 
				<div class="col-md-1 p10"><button type="button" class="btn btn-grey" onclick="gridList()"><i class="fa fa-search"></i> 검색</button></div>
			</div>	
			search end -->		
		<%-- 		
			<!-- 테이블시작 -->
			<div class="col-md-12">
				<div class="panel">
				    <div class="table-responsive">
				        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="">
							<colgroup>
								<col width="124">
								<col width="128">
								<col width="181">
								<col width="179">
								<col width="115">
								<col width="178">
								<col width="67">
							</colgroup>
							<thead>
							    <tr>
							        <th class="tac">정산년월</th>
									<th class="tac">승인상태</th>
									<th class="tac">정산자</th>
									<th class="tac">정산일시</th>
									<th class="tac">정산자</th>
									<th class="tac">확정일시</th>
									<th class="tac">상세</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>			
			</div> --%>
			<!-- 테이블 끝 -->
			
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
			</div>
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
	
<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	function cloudSearchId(cloudId){
		$("#cloudSearchId").val(cloudId);
	  gridList();
	}

	function gridList() {
		
		var yy = $("#billYear option:selected").val();
		var mm = $("#billMonth option:selected").val();
		var billYyyymm = yy+mm;
		
		 $("#calculateListTable").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/approval/calculate/calApprovalList"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.billYyyymm = billYyyymm;
					d.cloudId = $("#cloudSearchId").val();
	//					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[ 
	        	{"data":"billYyyymm", "class":"tac fontVdn"}
	        	, {"data":"confirnFlag", "class":"tac"} 
	        	, {"data":"procUserName", "class":"tac"}
	        	, {"data":"procDatetime", "class":"tac fontVdn"}
	        	, {"data":"comfirmUserName", "class":"tac"}
	        	, {"data":"confirmDatetime", "class":"tac fontVdn"}
	        	
	        ]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0], "render": function(data,type,full){
		
					var date = full.billYyyymm;
					return date.substring(0,4) + "-" + date.substring(4,6) ;
					}	
				}  	
				, {"targets":[1], "render": function(data,type,full){
					var flag = full.confirnFlag;
					if(flag=="Y"){
						return '<span type="button" class="comp">완료</span>';
					}else if (full.rejectCnt == 1){
						return '<span type="button" class="reject">반려</span>';
					}else if (full.rejectCnt == null && full.stepCnt > 0){
						return '<span type="button" class="ing">처리중</span>';
					}else if ( full.stepCnt == null){
						return '<span type="button" class="veri">요청전</span>'; 
					}
				}}
				, {"targets":[2], "render": function(data,type,full){
					var procUserName = full.procUserName;
					return procUserName;
					
				}}
				, {"targets":[3], "render": function(data,type,full){
					var date = full.procDatetime;
					if(date!=null){
						return date.substring(0,16);
					}else{
						return "";
					}
				}}
				, {"targets":[4], "render": function(data,type,full){
					var comfirmUserName = full.comfirmUserName;
					return comfirmUserName;
					
				}}
				, {"targets":[5], "render": function(data,type,full){
					var date = full.confirmDatetime;
					if(date!=null){
						return date.substring(0,16);
					}else{
						return "";
					}
				}}
				, {"targets":[6], "render": function(data,type,full){
					var date = full.billYyyymm;
					return	'<a type="button" class="btn_viewDetail" onclick ="moveDetailPage(\''+date+'\''+","+'\''+full.confirnFlag+'\')"></a>';
					
				}}
				
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>',"oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {
						
					}
				}]
			}
		});
		 tblColorSet();
		
	}
	
	
	function checkBillingConfirm(billYyyymm){
		confirmBox2("재정산 하시겠습니까?", billing, billYyyymm);
	}
	
	function tblColorSet() {
		$('.gridType01 .tableWrap table thead th').each(function(index, item){
			$(item).addClass('th' + index);
		});
	}
	
	// 재정산
	function billing(billYyyymm){
		
		$.ajax({
			url : "${contextPath}/mng/charge/bill/billing",
			dataType : "JSON",

			data : {
				"billYyyymm" : billYyyymm
				, "userId" : "${userId}"
			},
			success : function(data) {
				alertBox3("재정산되었습니다.");
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});
		
	}
	
	function checkConfirm(billYyyymm){
		confirmBox2("정산확정 하시겠습니까?", updateConfirmFlag, billYyyymm);
	}
	// 정산확정
	function updateConfirmFlag(billYyyymm){
		
		$.ajax({
			url : "${contextPath}/mng/charge/bill/updateConfirmFlag",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"billYyyymm" : billYyyymm
				, "userName" : "${userName}"
			},
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("정산확정을 완료하였습니다.", pageReload);
				}
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});
		
	}
	
	function pageReload(){
		location.reload();
	}
	
	
	function moveDetailPage(billYyyymm, confirmFlag){
		location.href="${contextPath}/mng/approval/calculate/calApprovalDetailPage?billYyyymm="+billYyyymm+"&confirmFlag="+confirmFlag;
	}
	
	// 정산 상세 팝업
	function openDetailPop(billYyyymm){
		$("#modal-dialog").modal();
		calculateDetailList(billYyyymm);
	}
	
	
	// 정산 상세 
	function calculateDetailList(billYyyymm) {
		
		 $("#calculateDetailTable").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/approval/calculate/calApprovalList"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.billYyyymm = billYyyymm;
				}
			}
		 	,"columns":[ 
	        	{"data":"customerId", "class":"tac"}
	        	, {"data":"customerName", "class":"tac"}
	        	, {"data":"billYyyymm", "class":"fontVdn"}
	        	, {"data":"amount", "class":"tar fc-blue fb"}
	        	, {"data":"AA00Amount", "class":"tar fc-red fb"}
	        	, {"data":"AE00Amount", "class":"tar fc-red fb"}
	        	, {"data":"AI00Amount", "class":"tar fc-red fb"}
	        ]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0],"visible":false,"searchable":false }
				, {"targets":[2], "render": function(data,type,full){
						var date = full.billYyyymm;
						
						if(date==" "){
							return "";
						}else{
							return date.substring(0,4) + "-" + date.substring(4,6);
						}
					}	
				}  	
				, {"targets":[3], "render": function(data,type,full){
					return addcomma(full.amount);
					}	
				}  	
				, {"targets":[4], "render": function(data,type,full){
					return addcomma(full.AA00Amount);
					}	
				}  	
				, {"targets":[5], "render": function(data,type,full){
					if(full.AE00Amount=="Sales Total"){
						return full.AE00Amount;
					}else{
						return addcomma(full.AE00Amount);
					}
					}	
				}  	
				, {"targets":[6], "render": function(data,type,full){
					return addcomma(full.AI00Amount);
					}	
				}  	

			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top"i>rt<"bottom">',"oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {
						
					}
				}]
			}
		});
	}

	function excelDown(){
		var params = "";
		var yy = $("#billYear option:selected").val();
		var mm = $("#billMonth option:selected").val();
		params += "&billYyyymm="+yy+mm;
		
		location.href = '${contextPath}/mng/approval/calculate/excel?'+params;
	}	
	
	
	$(document).ready(function() {
		gridList();
		App.init();
		
		//메뉴활성화
		$("#req").addClass("active");
		$("#calcApprv").addClass("active");

		//tab 첫번째 메뉴 활성화
		$(".nav-pills>li:first-child").addClass("active");

	});
</script>

</body>
</html>