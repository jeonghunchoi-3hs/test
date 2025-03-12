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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer">

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
				<h1>발송이력 조회</h1>
				<div class="pageNav">
						<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">알림/접속 관리</a><a href="#" class="on">발송이력 조회</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<div class="row">
				<!-- begin nav-pills -->
					<input type="hidden" id="h_searchGubun" value="${historyGubun}">
                        <ul class="nav nav-pills" id="tabNavi">
                            <li class="active" id='liSms'><a href="#nav-pills-tab-1" data-toggle="tab" onclick="initSearch(); smsHistoryGridList();">SMS</a></li>
                            <li class="ml10" id='liMail'><a href="#nav-pills-tab-2" data-toggle="tab"  onclick="initSearch(); mailHistoryGridList();">이메일</a></li>
                            <li class="ml10" id='liKepco'><a href="#nav-pills-tab-3" data-toggle="tab"  onclick="initSearch(); kepcoHistoryGridList();">결재시스템</a></li>
                        </ul>
                        <!-- end nav-pills -->


                      	<div class="page_searchBox m-b-15 mt10">
						<div class="selectBox width-100">
							<label class="selectText" for="startY">2017</label>
							<select class="search-sel" name="startY" id="startY">
							</select>
						</div>
						<span class="selectTxt m-r-15">년</span>
						<div class="selectBox width-60">
							<label class="selectText" for="startM">01</label>
							<select class="search-sel" name="startM" id="startM">
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
						<span class="selectTxt" style="width:50px;font-size:20px;">~</span>
						<div class="selectBox width-100">
							<label class="selectText" for="endY">2017</label>
							<select class="search-sel" name="endY" id="endY">
							</select>
						</div>
						<span class="selectTxt m-r-15">년</span>
						<div class="selectBox width-60">
							<label class="selectText" for="endM">01</label>
							<select class="search-sel" name="endM" id="endM">
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

						<div class="searchArea">
						<div class="selectBox width-100 ml50">
							<label class="selectText" for="searchKind">템플릿ID</label>
							<select class="search-sel" id="searchKind">
								<option value="template_id">템플릿ID</option>
								<option value="template_name">템플릿이름</option>
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" class="width-200">
							<a type="button" class="bton-s bton_blue" onclick="searchList()"><i class="fa fa-search"></i>  검색</a>
						</div>
					</div>
				    </div>
				    <!-- search box -->
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
				<!-- begin tab-content -->
				<div class="tab-content pl0 pr0 pt5">
                  <div role="tabpanel" class="tab-pane fade active in" id="nav-pills-tab-1">
                   <div  id="smsDiv">
					<!-- 그리드 영역 -->

						<table id="sms-table-list" class="tableWrap">
							<colgroup>
								<col width="10%">
								<col width="8%">
								<col width="*">
								<col width="10%">
								<col width="15%">
								<col width="8%">
								<col width="12%">
								<col width="6%">
							</colgroup>
							<thead>
								<tr>
									<th>수신자 ID</th>
									<th>수신자 이름</th>
									<th>수신자 번호</th>
									<th>템플릿ID</th>
									<th>템플릿이름</th>
									<th>발송여부</th>
									<th>발송처리일시</th>
									<th>상세보기</th>
								</tr>
							</thead>
							<tbody>

						   </tbody>
						</table>
				    </div>
                  </div>


                 <div role="tabpanel" class="tab-pane fade" id="nav-pills-tab-2">
                	<div id="mailDiv">
						<table id="mail-table-list" class="tableWrap">
							<colgroup>
								<col width="10%">
								<col width="8%">
								<col width="*">
								<col width="10%">
								<col width="15%">
								<col width="10%">
								<col width="12%">
								<col width="6%">
							</colgroup>
							<thead>
								<tr>
									<th>수신자 ID</th>
									<th>수신자 이름</th>
									<th>수신자 메일</th>
									<th>템플릿ID</th>
									<th>템플릿이름</th>
									<th>발송여부</th>
									<th>발송처리일시</th>
									<th>상세</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
				    </div>
                </div>


                <div role="tabpanel" class="tab-pane fade" id="nav-pills-tab-3">
                	<div  id="kepcoDiv">
						<table id="kepco-table-list" class="tableWrap">
							<colgroup>
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="*">
								<col width="12%">
								<col width="8%">
							</colgroup>
							<thead>
								<tr>
									<th>상태</th>
									<th>기안자 사번</th>
									<th>기안자 이름</th>
									<th>결재자 사번</th>
									<th>문서제목</th>
									<th>등록시간</th>
									<th>수신결과</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>

				    </div>
                </div>
                </div>
                <!-- end tab-content -->
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

	function smsHistoryGridList() {

		$("#h_searchGubun").val("sms");

		var startY = $("#startY option:selected").val();
		var startM = $("#startM option:selected").val();
		var endY = $("#endY option:selected").val();
		var endM = $("#endM option:selected").val();

		var startYm = startY + startM;
		var endYm = endY + endM;

		$("#sms-table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/smsQueue/history/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.startYm = startYm;
					d.endYm = endYm;
				}
			}
			,"columns":[
				  {"data":"receiverId" , "class":"tal fontVdn"}
				, {"data":"receiverName" , "class":"tac"}
				, {"data":"receiverNumber" , "class":"tac fontVdn"}
				, {"data":"templateId" , "class":"tac fontVdn"}
				, {"data":"templateName" , "class":"tac fontVdn"}
				, {"data":"resultFlg" , "class":"tac"}
				, {"data":"resultDatetime2" , "class":"tac fontVdn"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[5], "render": function(data,type,full){
						if(full.resultFlg=="Y"){
							return "<span class='statusLabel_small status_suc'>성공</span>";
						}else{
							return "<span class='statusLabel_small status_fail'>실패</span>";
						}
					}
				}
				, {"targets":[7], "render": function(data,type,full){
					return "<a type='button' class='cbton bton_lblue' onclick='movePageDetail(\""+full.smsSeq+"\",\"sms\")'><i class='fa fa-search'></i></a>";
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


	function mailHistoryGridList() {

		$("#h_searchGubun").val("mail");

		var startY = $("#startY option:selected").val();
		var startM = $("#startM option:selected").val();
		var endY = $("#endY option:selected").val();
		var endM = $("#endM option:selected").val();

		var startYm = startY + startM;
		var endYm = endY + endM;

		$("#mail-table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/mailQueue/history/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.startYm = startYm;
					d.endYm = endYm;
				}
			}
			,"columns":[
				{"data":"receiverId" , "class":"tal fontVdn"}
				, {"data":"receiverName" , "class":"tac"}
				, {"data":"receiverMail" , "class":"tal fontVdn"}
				, {"data":"templateId" , "class":"tal fontVdn"}
				, {"data":"templateName" , "class":"tal fontVdn"}
				, {"data":"resultFlg" , "class":"tac"}
				, {"data":"resultDatetime2" , "class":"tac fontVdn"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[5], "render": function(data,type,full){
						if(full.resultFlg=="Y"){
							return "<span class='statusLabel_small status_suc'>성공</span>";
						}else{
							return "<span class='statusLabel_small status_fail'>실패</span>";
						}
					}
				}
				,{"targets":[7], "render": function(data,type,full){
					return "<a type='button' class='cbton bton_lblue' onclick='movePageDetail(\""+full.mailSeq+"\",\"mail\")'><i class='fa fa-search'></i></a>";
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

	function nhwithHistoryGridList() {

		$("#h_searchGubun").val("nhwith");

		var startY = $("#startY option:selected").val();
		var startM = $("#startM option:selected").val();
		var endY = $("#endY option:selected").val();
		var endM = $("#endM option:selected").val();

		var startYm = startY + startM;
		var endYm = endY + endM;

		$("#nhwith-table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/nhwith/template/nhwithTemplateHistoryList"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.startYm = startYm;
					d.endYm = endYm;
				}
			}
			,"columns":[
				{"data":"receiverId" , "class":"tal fontVdn"}
				, {"data":"receiverName" , "class":"tac"}
				, {"data":"resultFlg" , "class":"tac"}
				, {"data":"resultDatetime2" , "class":"tac fontVdn"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[2], "render": function(data,type,full){
						if(full.resultFlg=="Y"){
							return "<span class='statusLabel_small status_suc'>성공</span>";
						}else{
							return "<span class='statusLabel_small status_fail'>실패</span>";
						}
					}
				}
				, {"targets":[4], "render": function(data,type,full){
					return "<a type='button' class='cbton bton_lblue' onclick='movePageDetail(\""+full.nhwithSeq+"\",\"nhwith\")'><i class='fa fa-search'></i></a>";
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

	function kepcoHistoryGridList(){
		$("#h_searchGubun").val("kepcowith");

		var startY = $("#startY option:selected").val();
		var startM = $("#startM option:selected").val();
		var endY = $("#endY option:selected").val();
		var endM = $("#endM option:selected").val();

		var startYm = startY + startM;
		var endYm = endY + endM;
		$("#kepco-table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/kepco/history/list"
				,"type" : "GET"
				,"data":function (d) {
					console.log(d);
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.startYm = startYm;
					d.endYm = endYm;
				}
			}
			,"columns":[
				{"data":"status" , "class":"tac"}
				, {"data":"writerId" , "class":"tac"}
				, {"data":"writerName" , "class":"tac"}
				, {"data":"payerId" , "class":"tac"}
				, {"data":"title" , "class":"tac fontVdn"}
				, {"data":"regDatetime" , "class":"tac fontVdn"}
				, {"data":"rtnCode" , "class":"tac fontVdn"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				,{"targets":[0], "render": function(data,type,full){
						if(full.status=="0"){
							return "<span class='statusLabel_small status_chg'>진행</span>";
						}else if(full.status=="1"){
							return "<span class='statusLabel_small status_suc'>완료</span>";
						}else if(full.status=="9"){
							return "<span class='statusLabel_small status_fail'>회수</span>";
						}
					}
				}
				,{"targets":[6], "render": function(data,type,full){
					if(full.rtnCode=="0000"){
							return "<span class='statusLabel_small status_suc'>성공</span>";
						} else {
							return "<span class='statusLabel_small status_fail'>실패</span>";
						}
					}
				}
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
		$(".height-40").removeClass("height-40");
	}

	function searchList(){
		var searchGubun = $("#h_searchGubun").val();
// 		if(searchGubun=="nhwith"){
// 			nhwithHistoryGridList();
// 		}else
		if(searchGubun=="mail"){
			$('#tabNavi a[href="#nav-pills-tab-2"]').tab('show')
			mailHistoryGridList();
		} else if(searchGubun=="kepcowith"){
			$('#tabNavi a[href="#nav-pills-tab-3"]').tab('show')
			kepcoHistoryGridList();
		}
		else{
			$('#tabNavi a[href="#nav-pills-tab-1"]').tab('show')
			smsHistoryGridList();
		}
	}

	function initSearch(){
		$("#keyword").val("");
	}

	function movePageDetail(historySeq, historyGubun){
		var params = "?historySeq="+historySeq+"&historyGubun="+historyGubun;
		location.href = "${contextPath}/mng/alarms/history/view"+params;
	}

	function getYearMonth(){
		var currentYear = (new Date()).getFullYear();
		var currentMonth = (new Date()).getMonth();


		currentMonth += 1;
		if(currentMonth<10){
			currentMonth = "0"+currentMonth;
		}

	    var years="";
	    var html = "";
	    for(var i=0; i < 5 ; i++){
	    	years = currentYear-i;
	    	html += "<option value='"+years+"'>"+ years +"</option>";
	    }
	    $("#startY").html(html);
	    $("#endY").html(html);
	    $("#startY").html(html);
	    $("#endY").html(html);

	    $("#startY").val(currentYear);
		$("#startY").siblings(".selectText").text($("#startY > option:selected").text());

		$("#endY").val(currentYear);
		$("#endY").siblings(".selectText").text($("#endY > option:selected").text());

	    $("#startM").val(currentMonth).attr("selected","selected");
	    $("#startM").siblings(".selectText").text($("#startM > option:selected").text());

	    $("#endM").val(currentMonth).attr("selected","selected");
	    $("#endM").siblings(".selectText").text($("#endM > option:selected").text());
	}

	function excelDown(){
		var params = "";
		var searchGubun = $("#h_searchGubun").val();

		params += "&searchKind="+$("#searchKind option:selected").val();
		params += "&keyword="+$("#keyword").val();

		var startY = $("#startY option:selected").val();
		var startM = $("#startM option:selected").val();
		var endY = $("#endY option:selected").val();
		var endM = $("#endM option:selected").val();

		params += "&startYm="+startY + startM;
		params += "&endYm="+endY + endM;

		if(searchGubun=="sms"){
			location.href = '${contextPath}/mng/smsQueue/history/excel?'+params;
		}else if(searchGubun=="mail"){
			location.href = '${contextPath}/mng/mailQueue/history/excel?'+params;
		}else if(searchGubun=="nhwith"){
			location.href = '${contextPath}/mng/nhwith/template/historyExcel?'+params;
		}else if(searchGubun=="kepcowith"){
			location.href = '${contextPath}/mng/kepco/history/excel?'+params;
		}
	}


	$(document).ready(function() {
		App.init();

		getYearMonth();
		searchList();

		//메뉴활성화
		$("#alarms").addClass("active");
		$("#smsHistory").addClass("active");

	});
</script>
</body>
</html>