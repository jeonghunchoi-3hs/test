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

	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<div id="content" class="content">
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>카탈로그 상세</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">자원관리</a><a href="#" class="on">진열자원 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row mb50">
				<input type="hidden" id="catalogSeq" value="${catalogSeq}">
				<input type="hidden" id="userId" name="userId" value="${userId}">
				<input type="hidden" id="applyDate" value="${detail.applyDate}">


				<input type="hidden" id="h_recordsTotal" value="">

				<div class="client_DetailArea clearfix m-b-40">
					<h2 class="blueBoxTitle">${detail.catalogSeq}</h2>
					<p class="company_Name2">${detail.catalogName}</p>
					<p class="company_Info m-t-0 p-t-15">
						<span>적용일자 :</span><span class="company_cont">
						<c:if test="${detail.applyDate eq '9999-12-01'}">

						</c:if>
						<c:if test="${detail.applyDate ne '9999-12-01'}">
							${detail.applyDate}
						</c:if>
						</span>
						<span class="company_label">등록자 :</span><span class="company_cont" id="">${detail.userName}</span>
						<span class="company_label">등록일시 :</span><span class="company_cont" id="">${detail.regDatetime}</span>
					</p>
					<div class="comp_btn_Area" style="position:absolute; top:4px; right:10px;">
						<c:if test="${detail.applyDate ne '9999-12-30'}">
							<a type="button" class="bton-s bton_green" onclick="moveCopyPage('${catalogSeq}');"><span class="txt"><i class="fa fa-files-o"></i> 복사</span></a>
						</c:if>
						<c:if test="${detail.active eq 'Y'}">
							<a type="button" class="bton-s bton_blue" onclick="moveUpdatePage('${catalogSeq}');"><span class="txt"><i class="fa fa-pencil"></i> 수정</span></a>
							<a type="button" class="bton-s bton_orange" onclick="catalogDelchk();"><span class="txt"><i class="fa fa-trash"></i> 삭제</span></a>
						</c:if>
					</div>
				</div>

				<div class="page_searchBox m-b-15">
					<div class="searchArea">
						<div class="selectBox mr10">
							<label class="selectText" for="searchKind">운영체제</label>
							<select class="search-sel width-150" id="searchKind" onchange="gridList();">
								<c:forEach items="${cateList}" var="cateList" varStatus="status" >
									<option value="${cateList.codeId}">${cateList.codeName}</option>
								</c:forEach>
							</select>
						</div>
						<div class="selectBox">
							<label class="selectText" for="searchKind2">전체</label>
							<select class="search-sel width-150" id="searchKind2">
								<option value="searchAll">전체</option>
								<option value="product_name">자원명</option>
								<option value="display_name">진열자원명</option>
							</select>
						</div>
						<div class="inputArea ml5">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
							<a type="button" class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>
						</div>
					</div>
				</div>



					<!-- 상단 버튼  -->
					<div class="btnArea tar mb5">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
						<a type="button" class="bton-s bton_blue" onclick="moveInsertPage();"><i class="fa fa-upload"></i><span> 등록</span></a>
					</div>
					<!-- //상단 버튼  -->

					<!-- 그리드 영역 -->

						<table id="totalGrid" class="tableWrap">
							<colgroup>
								<col width="15%">
								<col width="15%">
								<col width="10%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<%-- <col width="*"> --%>
								<col width="12%">
								<col width="6%">
							</colgroup>
							<thead>
								<tr>
									<th>진열자원명</th>
									<th>자원명</th>
									<th>정렬</th>
									<th>구분</th>
									<th>표시여부</th>
									<th>추천여부</th>
									<!-- <th>이미지</th> -->
									<th>월 금액(원)</th>
									<th>상세</th>
								</tr>
							</thead>
						</table>

				<!-- 테이블 끝 -->

				<div class="row tac m-t-40">
					<a type="button" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i>목록</a>
				</div>


			<!------여기까지 사용------>

			<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog-copy">
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">카달로그 복사</h4>
	                       	</div>
	                       	<div class="modal-body">
								<h4 class="tal f16 fc11 m-b-20">기존 카달로그</h4>
	                       		<div class="formType01 m-b-25">
									<div class="tblWrap clearfix">
										<table>
											<colgroup>
												 <col width="130px">
												 <col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><strong>적용일자</strong></th>
													<td class="tal">
														${detail.applyDate}
													</td>
												</tr>
												<tr>
													<th scope="row"><strong>카탈로그명</strong></th>
													<td class="tal">
														${detail.catalogName}
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<h4 class="tal f16 fc11 m-b-20">복사할 카달로그</h4>
	                       		<div class="formType01">
									<div class="tblWrap clearfix">
										<table>
											<colgroup>
												 <col width="130px">
												 <col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><strong>카탈로그명</strong></th>
													<td>
														<input type="text" style="width:100%;" name="" id="catalogName" maxlength="40">
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							 	<p class="f16 commnet tac">카달로그를 복사하시겠습니까?</p>
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="catalogCopy();">확인</a>
		                       <a type="button" class="pbton bton_dgrey" data-dismiss="modal" onclick="initCopyPopup();">취소</a>
	                       </div>
		               	</div>
					</div>
	            </div>
	            <!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog-update">
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">카달로그 수정</h4>
	                       	</div>
	                       	<div class="modal-body">
								<h4 class="tal f20 fc11 m-b-20">카달로그 정보</h4>
	                       		<div class="formType01">
									<div class="tblWrap clearfix">
										<table>
											<colgroup>
												 <col width="145px">
												 <col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><strong>적용일자</strong></th>
													<td class="tal">
														<input type="text" class="applyDate" name="applyDateUpdate" id="applyDateUpdate" style="width:120px;" readonly="readonly" value="${detail.applyDate.substring(0,7)}"/><img src="/resources/mng/assets/img/ico_datepicker_cal.png" id="applyDateBtn" style="vertical-align: top;">
													</td>
												</tr>
												<tr>
													<th scope="row"><strong>카탈로그명</strong></th>
													<td class="tal">
														<input type="text" style="width:100%" name="catalogNameUpdate" id="catalogNameUpdate" maxlength="40" value="${detail.catalogName}">
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
		                   		<p class="f18 f11 m-t-30">카달로그를 수정하시겠습니까?</p>
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="saveCheck();">확인</a>
		                       <a type="button" class="pbton bton_dgrey" data-dismiss="modal" onclick="">취소</a>
	                       </div>
		               	</div>
					</div>
	            </div>


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

				$("#totalGrid > tr").empty();

				 $("#totalGrid").dataTable( {
						"processing":true
						,"ordering" : false
						,"destroy" : true
						,"autoWidth":false
						,"serverSide":true
					,"ajax": {
						"url":"${contextPath}/mng/bss/catalog/mngReqProjectViewList"
						,"type" : "GET"
						,"dateSrc" : ""
						,"data":function (d) {
							d.searchKind = $("#searchKind2 option:selected").val();
							d.keyword = $("#keyword").val();
							d.applyDate = $("#applyDate").val();
							d.catalogCategory = $("#searchKind option:selected").val();
							d.catalogSeq = $("#catalogSeq").val();
						}
					}
				 	,"columns":[
								{"data":"displayName", "class":"tal"}
					        	, {"data":"productName", "class":"tal"}
					        	, {"data":"displayOrder", "class":"fontVdn overflowN subnet"}
					        	, {"data":"basicProductFlag", "class":"tac"}
					        	, {"data":"displayFlag", "class":"tac"}
					        	, {"data":"recommandFlag", "class":"tac"}
					        	, {"data":"monthlyPrice", "class":"tar"}
					        	, {"class":"tac", "width":"65px"}
					]
					,"initComplete" : function(setting, json){
						$("select[name='test']").append("<option value='1'>1</option>");
						$("select[name='test']").append("<option value='2'>2</option>");
						$("select[name='test']").append("<option value='3'>3</option>");
					}
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[2], "render": function(data,type,full){
								return full.selectHtml;
							}
						}
						, {"targets":[3], "render": function(data,type,full){
								if(full.basicProductFlag =="Y"){
									return "YES";
								}else{
									return "NO";
								}
							}
						}
						, {"targets":[4], "render": function(data,type,full){
								if(full.displayFlag =="Y"){
									return "표시";
								}else{
									return "미표시";
								}
							}
						}
						, {"targets":[5], "render": function(data,type,full){
								if(full.recommandFlag =="Y"){
									return "추천";
								}else{
									return "미추천";
								}
							}
						}
			/*			, {"targets":[6], "render": function(data,type,full){
							return addcomma(full.hourlyPrice);
							}
						} */
						, {"targets":[6], "render": function(data,type,full){
							return addcomma(full.monthlyPrice);
							}
						}
						, {"targets":[7], "render": function(data,type,full){
							return "<a type='button' class='cbton bton_lblue' onclick='moveProductDetailPage(\""+full.productSeq+"\",\""+full.catalogSeq+"\")'><i class='fa fa-search'></i></a>";
							}
						}
					]
					,"order": [[0,"desc"]]
					,"lengthMenu": [[10,15], [10, 15]]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					}
					,"sDom":'<"top">rt<"bottom"ip>'
				});

			}

			//자원 view상세 불러오기
			function productView(productSeq,catalogCategory,catalogSeq,applyDate) {
				$.ajax({
					url : "${contextPath}/mng/bss/catalog/productView",
					dataType : "JSON",
		 			type : "POST",
					data : {
						"productSeq" : productSeq
						,"catalogSeq" : catalogSeq
						,"catalogCategory" : catalogCategory
						,"applyDate" : applyDate
					},
					success : function(data) {
						var result = data;
						productSetData(result);
						showView(result);
						getFile(productSeq,catalogSeq,catalogCategory);
					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				});
			}

			// 카탈로그 자원 display order 수정
			function updateDisplayOrder(e){
				var productSeq = e.id;
				var displayOrder = $("#"+productSeq+" option:selected").val();

				$.ajax({
					url : "${contextPath}/mng/bss/catalog/updateDiplayOrder",
					dataType : "JSON",
		 			type : "POST",
					data : {
						"productSeq" : productSeq
						, "catalogSeq" : $("#catalogSeq").val()
						, "displayOrder" : displayOrder
					},
					success : function(data) {
						gridList();
					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				});
			}

			//카탈로그 상세보기
			function moveViewDetail(catalogTpye){
				location.href = "${contextPath}/mng/bss/catalog/viewDetail?catalogTpye="+catalogTpye;
			}

			// 카탈로그 자원 등록페이지 이동
			function moveInsertPage(){
				var catalogSeq = $("#catalogSeq").val();
				location.href = "${contextPath}/mng/bss/catalog/write?catalogSeq="+catalogSeq;
			}

			// 카탈로그 자원 상세페이지 이동
			function moveProductDetailPage(productSeq, catalogSeq){

				var catalogCategory = $("#searchKind option:selected").val();
				var param = "?catalogSeq="+catalogSeq+"&productSeq="+productSeq+"&catalogCategory="+catalogCategory;

				location.href = "${contextPath}/mng/bss/catalog/productViewPage"+param;
			}

			//카탈로그 수정하기 팝업
			function moveUpdatePage(catalogSeq){
				//location.href = "${contextPath}/mng/bss/catalog/catalog?catalogSeq="+catalogSeq;
				$("#modal-dialog-update").modal();
			}

			//카탈로그 복사하기 팝업
			function moveCopyPage(catalogSeq){
					//location.href = "${contextPath}/mng/bss/catalog/catalogCopy?catalogSeq="+catalogSeq;
				$("#modal-dialog-copy").modal();
			}


			// 카탈로그 복사
			function catalogCopy() {
				/*
		 		if($("#applyDate").val()==""){
		 			alertBox3("적용일자를 입력하세요");
		 			$("#applyDate").focus();
		 			return false;
		 		}
				*/
				if($("#catalogName").val()==""){
					alertBox3("카탈로그 이름을 입력하세요");
					$("#catalogName").focus();
					return false;
				}

				$.ajax({
					url : "${contextPath}/mng/bss/catalog/insert",
					dataType : "JSON",
					type : "POST",
					data : {
						"catalogName": $("#catalogName").val()
						, "policyName": $("#catalogName").val()+" 정책"
						, "beforeCatalogSeq": $("#catalogSeq").val()
						, "applyDate" : "9999-12-31"
						, "regUserId" : "${userId}"
						, "modUserId" : "${userId}"
					},
					success : function(data) {
						var result = data;
						if(result==1){
							alertBox("복사 되었습니다.", moveListPage);
						}else if(data==0){
							alertBox3("정책일자가 중복되었습니다.<br /> 기존에 등록된 정책일자가 존재하여 <br>복사할 수 없습니다.");
						}else{
							alertBox3("복사 실패");
						}
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}

			// 카탈로그 수정 유효성 체크
			function saveCheck(){
		 		var now = new Date();
		 		var year = now.getYear();
		 		var month = now.getMonth() + 1;
		 		if ((month + "").length < 2) {month = "0" + month;}

				if($("#applyDateUpdate").val()==""){
					alertBox3("적용일자를 입력하세요");
					$("#applyDateUpdate").focus();
					return false;
				}if($("#applyDateUpdate").val()<=(year +"-" + month)){
					alertBox3("적용일자는 익월부터 가능합니다");
					$("#applyDateUpdate").focus();
					return false;
				}
				if($("#catalogNameUpdate").val()==""){
					alertBox3("카탈로그 이름을 입력하세요");
					$("#applyDateUpdate").focus();
					return false;
				}
				confirmBox("저장하시겠습니까?", catalogUpdate);
			}

			// 카탈로그 수정 action
			function catalogUpdate() {
				var jsonData = setJsonDataForUpdate();
				$.ajax({
					url : "${contextPath}/mng/bss/catalog/catalogUpdate",
					dataType : "JSON",
					type : "POST",
					data : jsonData,
					success : function(data) {
						var result = data;
						if(result==1){
							alertBox("저장되었습니다.", moveListPage);
						}else{
							alertBox("적용일자가 중복되었습니다.", moveListPage);
							//alertBox("저장에 실패하였습니다.", moveListPage);
						}
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}

			// 수정 json 데이터 세팅
			function setJsonDataForUpdate(){
				var jsonData = {
						"applyDate" : $("#applyDateUpdate").val()+"-01"
						, "policyName": ""
						, "catalogSeq": $("#catalogSeq").val()
						, "catalogName": $("#catalogNameUpdate").val()
						, "regUserId" : "${userId}"
						, "modUserId" : "${userId}"
					};
				return jsonData;
			}

			// 삭제confirm
			function catalogDelchk(){
		 		confirmBox("삭제하시겠습니까?.",catalogDelchkOk);
		 	}

			// 삭제 action
		 	function catalogDelchkOk(){
		 		$.ajax({
					url : "${contextPath}/mng/bss/catalog/delete",
					dataType : "JSON",
					type : "POST",
					data : {
						catalogSeq: '${catalogSeq}'
					},
					success : function(data) {
						var result = data;
						if(result=1){
							alertBox("삭제 되었습니다.",moveListPage);
						}else{
							alertBox("삭제가 실패되었습니다.",moveListPage);
						}
					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				});
		 	}


			// 카탈로그 복사 팝업 초기화
			function initCopyPopup(){
				$("#catalogName").val("");
			}

			// 목록 페이지이동
			function moveListPage(){
				location.href = "${contextPath}/mng/bss/catalog/";
			}

			// 달력
			function calendar(){
				var dayName = ['일','월','화','수','목','금','토'];
				var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

				$(".applyDate").datepicker({
					showOn:"both",
					buttonImage:"/resources/mng/assets/img/ico_datepicker_cal.png",
					buttonImageOnly:true,
					dateFormat : "yy-mm-dd",
					dayNamesMin:dayName,
					monthNamesShort:monthName,
					changeMonth:true,
					minDate:0
				});
				$("img.ui-datepicker-trigger").attr("style", "vertical-align:top;");
				$(".applyDate").val($.datepicker.formatDate('yy-mm-dd', new Date()));
			}


			// 월달력
			function monthCalendar(){
				var currentYear = (new Date()).getFullYear();
				var currentMonth = (new Date()).getMonth();
			    var options = {
			    		selectedMonth : currentMonth+1,
			    		startYear: currentYear,
			            finalYear: currentYear+10,
			            pattern: 'yyyy-mm',
			            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']

			    };

			    $('.applyDate').monthpicker(options);
			    $('#applyDateBtn').bind('click', function () {
					$('#applyDateUpdate').monthpicker('show');
				});
			}

			function excelDown(){
				var params = "";
				params += "&searchKind="+$("#searchKind option:selected").val();
				params += "&keyword="+$("#keyword").val();
				params += "&applyDate="+$("#applyDate").val();
				params += "&catalogCategory="+$("#searchKind option:selected").val();
				params += "&catalogSeq="+$("#catalogSeq").val();

				location.href = '${contextPath}/mng/bss/catalog/mngReqProjectViewExcel?'+params;
			}

		 	$(document).ready(function(){
		 		App.init();
		 		monthCalendar();
		 		gridList();

		 		$("#productAservice").addClass("active");
				$("#catalog").addClass("active");

		 	});

		</script>
	</body>
</html>