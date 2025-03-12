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
					<h1>카탈로그 목록</h1>
					<div class="pageNav">
						<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">자원관리</a><a href="#" class="on">진열자원 관리</a>
					</div>
				</div>
				<!-- end header -->

				<!-- begin page-body -->
				<div class="row pb50">

					<div class="page_searchBox">
						<div class="searchArea">

							<div class="selectBox">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel width-150" id="searchKind">
									<option value="searchAll">전체</option>
									<option value="sCatalogName">카탈로그명</option>
									<option value="sApplyDate">적용일자</option>
								</select>
							</div>
								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
								<a type="button" class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>
						</div>
					</div>


						<!-- 상단 버튼  -->
						<div class="btnArea tar mb5">
							<a type="button" onclick="excelDown();" class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
							<a type="button" onclick="moveInsertPage();" class="bton-s bton_blue"><i class="fa fa-upload"></i> <span>등록</span></a>
						</div>
						<!-- //상단 버튼  -->
						<!-- 그리드 영역 -->

							<table id="mngCatalogList" class="tableWrap">
								<colgroup>
									<col width="*">
									<col width="140px">
									<col width="140px">
									<col width="140px">
									<col width="80px">
								</colgroup>
								<thead>
									<tr>
										<th>카탈로그명</th>
										<th>적용일자</th>
										<th>등록자</th>
										<th>등록일시</th>
										<th>상세</th>
									</tr>
								</thead>
							</table>
				</div>
				<!-- begin #footer -->
				<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->




				<!-- #modal-dialog -->
					<div class="modal fade" id="modal-dialog-insert">
						<div class="modal-dialog">
							<div class="modal-content width-570">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
		                        	<h4 class="modal-title">카달로그 등록</h4>
		                       	</div>
		                       	<div class="modal-body">

									<div class="tableE">
										<table>
											<colgroup>
												 <col width="130px">
												 <col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th class="tal vm">카탈로그명</th>
													<td>
														<input type="text" style="width:100%;" name="" id="catalogName" maxlength="40">
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								 	<p class="commnet fc-red tac">카달로그를 등록하시겠습니까?</p>
			                   </div>
			                   <div class="modal-footer tac">
			                       <a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="catalogInsert();">확인</a>
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


			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->

		<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">

			//카탈로그 복사
			function catalogInsert() {

				if($("#catalogName").val()==""){
					alertBox3("카탈로그 이름을 입력하세요");
					$("#catalogName").focus();
					return false;
				}

				$.ajax({
					url : "${contextPath}/mng/bss/catalog/catalogNewInsert",
					dataType : "JSON",
					type : "POST",
					data : {
						"catalogName": $("#catalogName").val()
						, "applyDate" : "9999-12-31"
					},
					success : function(data) {
						var result = data;


						if(result==1){
							alertBox("등록 되었습니다.", moveListPage);
						}else if(data==2){
							alertBox3("정책일자가 중복되었습니다.<br /> 기존에 등록된 정책일자가 존재하여 <br>등록할 수 없습니다.");
						}else{
							alertBox3("등록 실패");
						}
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}

			// 카탈로그 복사 팝업 초기화
			function initCopyPopup(){
				$("#catalogName").val("");
			}

			function moveInsertPage(){
				$("#modal-dialog-insert").modal();
			}

		    function cloudSearchId(cloudId){
				$("#cloudSearchId").val(cloudId);
                gridList();
            }

			function gridList() {
				 $("#mngCatalogList").dataTable( {
						"processing":true
						,"ordering" : false
						,"destroy" : true
						,"autoWidth":false
						,"serverSide":true
					,"ajax": {
						"url":"${contextPath}/mng/bss/catalog/list"
						,"type" : "GET"
						,"dateSrc" : ""
						,"data":function (d) {
							d.cloudKind = $("#cloudKind option:selected").val();
							d.searchKind = $("#searchKind option:selected").val();
							d.keyword = $("#keyword").val();
						}
					}
				 	,"columns":[
				 				{"data":"catalogName", "class":"tal"}
					        	, {"data":"applyDate"}
					        	, {"data":"userName"}
					        	, {"data":"modDatetime"}
					        	, {}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[1], "render": function(data,type,full){
								if(full.applyDate == "9999-12-31"){
									return "";
								}else{
									return full.applyDate;
								}
							}
						}
						, {"targets":[4], "render": function(data,type,full){
							return "<a type='button' class='cbton bton_lblue'  onclick='moveDetailPage(\""+full.catalogSeq+"\")'><i class='fa fa-search'></i></a>";
							}
						}
					]
					,"createdRow" : function (row, data, index){
						if(data.active == "Y"){
							$(row).addClass('active');
						}
					}
					,"order": [[0,"desc"]]
					,"lengthMenu": [[10,15], [10, 15]]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					}
					,"sDom":'<"top">rt<"bottom"ip>'
				});

				 tblColorSet();

			}


		 	function tblColorSet() {
				$('.gridType01 .tableWrap table thead th').each(function(index, item){
					$(item).addClass('th' + index);
				});
			}


		 	function moveDetailPage(catalogSeq){
				location.href = "${contextPath}/mng/bss/catalog/viewPage?catalogSeq="+catalogSeq;
		 	}

		 	function excelDown(){
			    var params = "";
			    params += "&searchKind=" + $("#searchKind option:selected").val();
			    params += "&keyword=" + $("#keyword").val();
			    params += "&cloudKind="+$("#cloudKind option:selected").val();
			    location.href =  '${contextPath}/mng/bss/catalog/excel?'+params;
		 	}

		 	function searchCloud() {
				gridList();
			}


			$(document).ready(function() {

				gridList();
				App.init();

				//메뉴활성화
				$("#productAservice").addClass("active");
				$("#catalog").addClass("active");

				$(".nav-pills>li:first-child").addClass("active");

			});
		</script>
	</body>
</html>