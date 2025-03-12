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

		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>매출현황</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">요금조회</a><a href="#" class="on">매출현황</a>
				</div>
			</div>
			<!-- end header -->
            <input type="hidden" id="cloudSearchId" value="${getCloudList[0].cloudId}">
			<%-- <ul class="nav nav-pills ml-10 mb10" id="tabNavi">
		     <c:forEach items="${getCloudList}" var="getCloudList" varStatus="status" >
                  <li class="ml10 <c:if test="${status.first}">active</c:if>" id='${getCloudList.cloudId}'><a href="#nav-pills-tab-2" data-toggle="tab"  onclick="cloudSearchId('${getCloudList.cloudId}');">${getCloudList.cloudName}</a></li>
			 </c:forEach>
		    </ul> --%>
		    <input type="hidden" id="h_cloudSearchId" value="${req.getCloudId() == null ? getCloudList[0].cloudId : req.getCloudId()}">
			<input type="hidden" id="h_cloudSearchName" value="${req.getCloudName() == null ? getCloudList[0].cloudName : req.getCloudName()}">
			<!-- begin page-body -->
			<div class="row pb50">
				<div class="page_searchBox m-b-15">
					<div class="searchArea">
						<div class="selectBox m-r-5 width-100 dpno">
							<label class="selectText" for="searchKey0">구분</label>
							<select class="search-sel" id="searchKey0" onchange="onchangeSearchKey('0');">
								<option value="">구분</option>
							</select>
						</div>
						<div class="selectBox m-r-5 width-200">
							<label class="selectText" for="searchKey1">회원사명</label>
							<select class="search-sel" id="searchKey1" onchange="onchangeSearchKey('1');">
								<option value="">회원사명</option>
							</select>
						</div>
						<div class="selectBox width-250 mr20">
							<label class="selectText" for="searchKey2">프로젝트명</label>
							<select class="search-sel" id="searchKey2" onchange="onchangeSearchKey('2');">
								<option value="">프로젝트명</option>
							</select>
						</div>
						<div>
							<div class="selectBox width-80">
								<label class="selectText" for="billYear1">전체</label>
								<select class="search-sel" id="billYear1">
									<option value="">전체</option>
								</select>
							</div>
							<span class="selectTxt mr10">년</span>
							<div class="selectBox width-60">
								<label class="selectText" for="billMonth1">전체</label>
								<select class="search-sel" id="billMonth1">
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
							<span class="selectTxt">월 ~</span>
							<div class="selectBox width-80">
								<label class="selectText" for="billYear2">전체</label>
								<select class="search-sel" id="billYear2">
									<option value="">전체</option>
								</select>
							</div>
							<span class="selectTxt">년</span>
							<div class="selectBox m-l-5 width-60">
								<label class="selectText" for="billMonth2">전체</label>
								<select class="search-sel" id="billMonth2">
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

							 <div class="selectBox width-100">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel" id="searchKind">
									<option value="searchAll">전체</option>
									<option value="project_alias">프로젝트명</option>
									<option value="manager_name">담당자명</option>
								</select>
							</div>
							<div class="inputArea ml5">
								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-300">
								<a type='button' class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>
							</div>

					</div>
				</div>
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="tar mb5">
					<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->

					<!-- 그리드 영역 -->
					<div class="tableWrap">
						<table id="salesListTable">
							<colgroup>
								<col width="10%">
								<col width="15%">
								<col width="10%">
								<col width="*">
								<col width="8%">
								<col width="8%">
								<col width="15%">
								<col width="6%">
							</colgroup>
							<thead>
								<tr>
									<th class="tac">회원사명</th>
									<th class="tac">담당조직(부서)</th>
									<th class="tac">프로젝트ID</th>
									<th class="tac">프로젝트명</th>
									<th class="tac">담당자</th>
									<th class="tac">매출년월</th>
									<th class="tac">사용요금 (단위: 원)</th>
									<th class="tac">상세</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>

				<!-- <div class="salesTotalBg">
					<span class="f20 fc11">매출 합계</span>
					<span class="flr"><span class="salesTotal fontVdn" id="totalAmount">0</span><span class="f20 fc66 m-l-10">원</span></span>
			    </div> -->

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


	function cloudSearchId(cloudId){
		$("#cloudSearchId").val(cloudId);
	  gridList();
	}

	function gridList() {

		var yy1 = $("#billYear1 option:selected").val();
		var mm1 = $("#billMonth1 option:selected").val();
		var billYyyymm1 = yy1+mm1;

		var yy2 = $("#billYear2 option:selected").val();
		var mm2 = $("#billMonth2 option:selected").val();
		var billYyyymm2 = yy2+mm2;
		$("#salesListTable").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/charge/bill/salesList"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.startDt = billYyyymm1;
					d.endDt = billYyyymm2;
					d.keyword = $("#keyword").val();
					d.searchKind = $("#searchKind").val();
				 	/*  d.searchKey0 = $("#searchKey0 option:selected").val();
					d.searchKey1 = $("#searchKey1 option:selected").val(); */
					 d.searchKey2 = $("#searchKey2 option:selected").val();
					 //d.cloudId = $("#cloudSearchId").val();
				}
			}
		 	, "initComplete" : function(setting, json){
		 		var totalAmount = json.totalAmount;

		 		$("#totalAmount").text(addcomma(totalAmount));
			}
			,"columns":[
	        	{"data":"customerName", "class":"tac"}
	        	, {"data":"deptName", "class":"tal"}
	        	, {"data":"projectName", "class":"tac"}
	        	, {"data":"projectAlias", "class":"tal"}
	        	, {"data":"managerName", "class":"tal"}
	        	, {"data":"billYyyymm", "class":"tac"}
	        	, {"data":"amount", "class":"tar name pr15"}
	        	, {"class":"tac"}
	        ]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
			, {"targets":[5], "render": function(data,type,full){
						return full.billYyyymm.substr(0, 4) + "-" + full.billYyyymm.substr(4, 2);
				}
			}
			, {"targets":[6], "render": function(data,type,full){
					return addcomma(full.amount);
				}
			}
			, {"targets":[7], "render": function(data,type,full){
// 				return "<a type='button' class='btn_viewDetail'  onclick='moveDetailPage(\""+full.projectId+"\")'></a>";
				return "<a type='button' class='cbton bton_lblue'  onclick='movePageDetail(\""+full.projectId+"\", \""+full.billYyyymm+"\")'><i class='fa fa-search'></i></a>";
				}
			}
			]
			,"order": [[5,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});

	}

	function getNowDate(){
		var currentYear = (new Date()).getFullYear();
		var currentYear2 = (new Date()).getFullYear();

	    var years="";
	    var html = "";
	    for(var i=0; i < 5 ; i++){
	    	years = (currentYear + 1) - i;
	    	html += "<option value='"+years+"'>"+ years +"</option>";
	    }

	    $("#billYear1").html(html);
	    $("#billYear2").html(html);

	    // 월 선택
		var currentMonth = (new Date()).getMonth();
		var currentMonth2 = (new Date()).getMonth();


		if(currentMonth == 0){
			currentMonth = 1;
		}else if(currentMonth == 1){
			currentMonth = 11;
			currentYear = currentYear - 1;
		}else if(currentMonth == 2){
			currentMonth = 12;
			currentYear = currentYear - 1;
		}else{
			currentMonth = currentMonth - 1;
		}


		if(currentMonth2 == 0){
			currentMonth2 = 1;
		}else if(currentMonth2 == 12){
			currentMonth2 = 1;
			currentYear2 = currentYear2 + 1;
		}else{
			currentMonth2 = currentMonth2 + 1;
		}



		if(currentMonth<10){
			currentMonth = "0"+currentMonth;
		}
		if(currentMonth2<10){
			currentMonth2 = "0"+currentMonth2;
		}

		$("#billYear1").val(currentYear);
		$("#billYear1").siblings(".selectText").text($("#billYear1 > option:selected").text());
 	    $("#billMonth1").val(currentMonth).attr("selected","selected");
	    $("#billMonth1").siblings(".selectText").text($("#billMonth1 > option:selected").text());

		$("#billYear2").val(currentYear2);
		$("#billYear2").siblings(".selectText").text($("#billYear2 > option:selected").text());

	    $("#billMonth2").val(currentMonth2).attr("selected","selected");
	    $("#billMonth2").siblings(".selectText").text($("#billMonth2 > option:selected").text());

	    gridList();
	}




	// 청구서 프린트
	function printPage(){
		var popupWindow = window.open("","_blank");
		popupWindow.document.write("<html>");
		popupWindow.document.write("<head>");
		popupWindow.document.write($("head").html());
		popupWindow.document.write("</head>");
		popupWindow.document.write("<body>");
		popupWindow.document.write("<div style='width:850px;'>");
		popupWindow.document.write(document.getElementById("print").innerHTML);
		popupWindow.document.write("</div>");
		popupWindow.document.write("</body>");
		popupWindow.document.write("</html>");
		popupWindow.document.close();
		popupWindow.print();

	}

	//엑셀 다운로드
	function excelDown(){
		var yy1 = $("#billYear1 option:selected").val();
		var mm1 = $("#billMonth1 option:selected").val();
		var billYyyymm1 = yy1+mm1;

		var yy2 = $("#billYear2 option:selected").val();
		var mm2 = $("#billMonth2 option:selected").val();
		var billYyyymm2 = yy2+mm2;

		var startDt = billYyyymm1;
		var endDt = billYyyymm2;

		var params = "?startDt="+startDt;
		params += "&endDt="+endDt;
		params += "&keyword="+$("#keyword").val();
		params += "&searchKind="+$("#searchKind").val();
	/* 	params += "&searchKey0="+$("#searchKey0 option:selected").val();*/
	/*	params += "&searchKey1="+$("#searchKey1 option:selected").val();*/
		params += "&searchKey2="+$("#searchKey2 option:selected").val();


		location.href = "${contextPath}/mng/excel/salesExcelDown"+encodeURI(params);
	}


	function onchangeSearchKey(e){
		if($("#searchKey"+e).val() != ""){
			if( e == "1"){
				var customerName = $("#searchKey"+e+" > option:selected").attr("customerName");
				$("#searchKey0").siblings(".selectText").text(customerName!=""?customerName:"회원사명");
				$("#searchKey0").val(customerName);
			}else if( e == "2"){
				var customerName = $("#searchKey"+e+" > option:selected").attr("customerName");
				$("#searchKey0").siblings(".selectText").text(customerName!=""?customerName:"회원사명");
				$("#searchKey0").val(customerName);

				var customerName = $("#searchKey"+e+" > option:selected").attr("customerName");
				$("#searchKey1").siblings(".selectText").text(customerName!=""?customerName:"회원사명");
				$("#searchKey1").val(customerName);
			}
		}

		if( e == "0"){
			setSearchBox("1");
			setSearchBox("2");
		}else if( e == "1"){
			setSearchBox("2");
		}
	}

	function setSearchBox(gbn){
		$.ajax({
			url : "${contextPath}/mng/productUsageStatus/total/searchBox",
			dataType : "JSON",
			data : {
				searchKind : gbn
				, searchKey0 : $("#searchKey0 option:selected").val()
				, searchKey1 : $("#searchKey1 option:selected").val()
				, cloudId : $("#h_cloudSearchId").val()
			},
			success : function(data) {
				var vText = "";
				if(gbn == "0"){
					vText = "회원사명";
				}else if(gbn == "1"){
					vText = "회원사명";
				}else if(gbn == "2"){
					vText = "프로젝트명";
				}

				if( vText != ""){
					$("#searchKey"+gbn).html('<option value="">'+vText+'</option>');
					$("#searchKey"+gbn).siblings(".selectText").text(vText);
				}

				if(data.searchBox != ""){
					$.each(data.searchBox, function(key,val){
						$("#searchKey"+gbn).append('<option value="'+val.searchKind+'" customerName="'+val.customerName+'" customerName="'+val.customerName+'">'+val.searchKind+'</option>');
					});
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



	function movePageDetail(projectId, billYyyymm){
		var param = "?projectId="+projectId+"&billYyyymm="+billYyyymm;

		location.href = "${contextPath}/mng/charge/bill/salesViewPage"+param;
	}

	$(document).ready(function() {
		App.init();
		setSearchBox("0");
		setSearchBox("1");
		setSearchBox("2");

		getNowDate();
 		gridList();

		//메뉴활성화
		$("#priceInquiry").addClass("active");
		$("#sales").addClass("active");
	});
</script>
</body>
</html>