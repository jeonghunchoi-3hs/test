<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
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
				<h1>정산</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">요금관리</a><a href="#" class="on">정산</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<div class="page_searchBox m-b-15" >
					<div class="searchArea">
						<!-- <input type="hidden" id="h_approvalMemberCheck" value="${approvalMemberCheck}">  -->
						<input type="hidden" id="h_approvalMemberCheck" value="Y">
						<div class="selectBox" style="width:120px;">
							<label class="selectText" for="billYear">전체</label>
							<select class="search-sel" id="billYear">
								<option value="">전체</option>
								<c:forEach items="${yearList}" var="list" varStatus="status" >
									<option value="${list.YEAR}">${list.YEAR}</option>
								</c:forEach>
							</select>
						</div>
						<span class="unit">년</span>
						<div class="selectBox" style="width:120px;">
							<label class="selectText" for="billMonth">전체</label>
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
						<span class="unit" style="width: 500px;">월</span>
						<div class="inputArea m-l-5">
							<a type='button' class="btn_search" onclick="gridList();">검색</a>
						</div>
					</div>
				</div>

				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a onclick="excelDown();" type='button' class="btnType01"><i class="ico_download"></i><span>다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-15">
						<table id="calculateListTable" summary="정산">
						<caption>게시판 목록 : 청구년월, 정산상태, 정산수행, 정산일시, 확정자, 확정일시, 사용금액(원), 작업, 상세로 구성</caption>
							<colgroup>
								<col width="105px">
								<col width="87px">
								<col width="85px">
								<col width="160px">
								<col width="85px">
								<col width="160px">
								<col width="*">
								<col width="100px">
								<col width="65px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">청구년월</th>
									<th scope="col">정산상태</th>
									<th scope="col">정산수행</th>
									<th scope="col">정산일시</th>
									<th scope="col">확정자</th>
									<th scope="col">확정일시</th>
									<th scope="col">사용금액<span class="fontN">(원)</span></th>
									<th scope="col">작업</th>
									<th scope="col">상세</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>

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
				"url":"${contextPath}/mng/charge/bill/calculateList"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.billYyyymm = billYyyymm;
				}
			}
			,"columns":[
	        	{"data":"billYyyymm", "class":"tac fontVdn"}
	        	, {"data":"confirnFlag", "class":"tac"}
	        	, {"data":"", "class":"tac"}
	        	, {"data":"procDatetime", "class":"tac fontVdn ls-1"}
	        	, {"data":"comfirmUserName", "class":"tac"}
	        	, {"data":"confirmDatetime", "class":"tac fontVdn ls-1"}
	        	, {"data":"", "class":"tar fontVdn ls-1 p-r-15"}
	        	, {"class":"tac"}
	        	, {"class":"tac"}
	        ]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				 , {"targets":[0], "render": function(data,type,full){
					var date = full.billYyyymm;

					return date.substring(0,4) + "-" + date.substring(4,6);
					}
				}
				, {"targets":[1], "render": function(data,type,full){
					var flag = full.confirnFlag;

					if(flag=="Y"){
						return "<span class='comp'>확정</span>";
					}else{
						return "<span class='reject'>미확정</span>";
					}
				}}
				, {"targets":[2], "render": function(data,type,full){
					return full.procUserName;

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
					return full.comfirmUserName;

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
					return addcomma(full.amount);

				}}
				, {"targets":[7], "render": function(data,type,full){
					var flag = full.confirnFlag;
					var billflag = full.billFlag;
					var apprvStat = full.apprvStat;
					var approvalMemberCheck = "${approvalMemberCheck}";
					// if(approvalMemberCheck =="Y"){	//요청권한이 있는가?
						if(flag=="Y"){
							return "승인완료";
						}else{
							//정산요청 전 또는 반려시에만 버튼 노출
							if(apprvStat == null || apprvStat == "APPRV_REJECTED" ){
								if(billflag=="0"){
									if(apprvStat == "APPRV_REJECTED"){
										return '<a type="button" class="btnType05 green" onclick="checkConfirm2(\''+full.billYyyymm+'\');"><span class="bg_left"></span><span class="txt" style="width:60px">승인요청</span><span class="bg_right"></span>';
									}else{
										return '<a type="button" class="btnType05 green" onclick="checkConfirm(\''+full.billYyyymm+'\');"><span class="bg_left"></span><span class="txt" style="width:60px">승인요청</span><span class="bg_right"></span>';
									}
								}else{
									return '<a type="button" class="btnType05" onclick="checkBillingConfirm(\''+full.billYyyymm+'\');"><span class="bg_left"></span><span class="txt" style="width:60px">재정산</span><span class="bg_right"></span>';
								}
							}else if(apprvStat == "APPRV_PROCESSING"){
								return "승인중";
							}
						}
					//}
				}}
				, {"targets":[8], "render": function(data,type,full){
					return "<a type='button' class='btn_viewDetail' onclick='moveDetailPage(\""+full.billYyyymm+"\")'></a>";
					}
				}
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});

	}

	//정산요청
	function checkConfirm(billYyyymm){
		var memChk = $("#h_approvalMemberCheck").val();
		if(memChk=="Y"){
			confirmBox2("승인요청 하시겠습니까?", calApprovalRequest, billYyyymm);
		}else{
			alertBox3("승인요청권한이 없습니다.");
			return false;
		}
	}
	// 반려 후 정산 재 요청
	function checkConfirm2(billYyyymm){
		var memChk = $("#h_approvalMemberCheck").val();
		if(memChk=="Y"){
			confirmBox2("승인요청 하시겠습니까?", calApprovalRequest2, billYyyymm);
		}else{
			alertBox3("승인요청권한이 없습니다.");
			return false;
		}
	}

	function checkBillingConfirm(billYyyymm){
		confirmBox2("재정산 하시겠습니까?", billing, billYyyymm);
	}

	function waiting(){
		alertBox("처리중입니다.<br>잠시만 기다려 주십시오.", waiting);
	}
	// 재정산
	function billing(billYyyymm){
		alertBox("처리중입니다.<br>잠시만 기다려 주십시오.", waiting);
		$.ajax({
			url : "${contextPath}/mng/charge/bill/billing",
			dataType : "JSON",

			data : {
				"billYyyymm" : billYyyymm
				, "userId" : "${userId}"
			},
			success : function(data) {
				alertBox("재정산되었습니다.", moveListPage);
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	// 정산승인 요청
	function calApprovalRequest(billYyyymm){
		$.ajax({
			url : "${contextPath}/mng/approval/calculate/calApprovalRequest",
			dataType : "JSON",
			data : {
				"billYyyymm" : billYyyymm
				, "userName" : "${userName}"
			},
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("승인요청 되었습니다.", pageReload);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	// 정산승인 재 요청
	function calApprovalRequest2(billYyyymm){
		$.ajax({
			url : "${contextPath}/mng/approval/calculate/reReqUpdate",
			dataType : "JSON",
			data : {
				"billYyyymm" : billYyyymm
				, "userName" : "${userName}"
			},
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("승인요청 되었습니다.", pageReload);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
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
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}

	function moveListPage(){
		location.href = "${contextPath}/mng/charge/bill/calculateListPage";
	}

	function pageReload(){
		location.reload();
	}


	function moveDetailPage(billYyyymm){
		location.href = "${contextPath}/mng/charge/bill/calculateView?billYyyymm="+billYyyymm;
	}


	$(document).ready(function() {

		gridList();
		App.init();

		//메뉴활성화
		$("#chargeManagement").addClass("active");
		$("#calculate").addClass("active");

	});
</script>
</body>
</html>