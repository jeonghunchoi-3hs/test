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
					<h1>자원구성 관리</h1>
					<div class="pageNav">
						<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">자원관리</a><a href="#" class="on">자원구성 관리</a>
					</div>
				</div>
				<!-- end header -->

				<!-- begin page-body -->
				<div class="row pb50">
					<!-- search begin -->
					<div class="page_searchBox m-b-15">
						<div class="searchArea">

							<div class="selectBox">
								<label class="selectText" for="productKind">분류</label>
								<select class="search-sel width-150" id="productKind"  onchange="getProductKind();">
									<option value="">분류</option>
									<option value="categoryVm">가상서버</option>
									<option value="categoryDisk">블록디스크</option>
									<option value="categoryService">서비스</option>
									<option value="categoryOs">운영체계</option>
									<option value="categoryApp">어플리케이션</option>

								</select>
							</div>
							<div class="selectBox">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel width-150" id="searchKind"  onchange="getProductKind();">
									<option value="searchAll">전체</option>
									<option value="sProductName">자원명</option>
									<option value="sProductCategoryName">자원카테고리</option>
								</select>
							</div>

								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
								<a type="button" class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>

						</div>
					</div>
					<!-- search end -->


						<!-- 상단 버튼  -->
						<div class="tar mb5">
							<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
							<a type="button" class="bton-s bton_blue" onclick="moveInsertPage();"><i class="fa fa-upload"></i><span> 등록</span></a>
						</div>
						<!-- //상단 버튼  -->
						<!-- 그리드 영역 -->

							<table id="bssProductList" class="tableWrap">

								<colgroup>
									<col width="120px">
									<col width="*">
									<col width="120px">
									<col width="140px">
									<col width="140px">
									<col width="80px">
								</colgroup>
								<thead>
									<tr>
										<th>자원카테고리</th>
								    	<th>자원명</th>
										<th>사용여부</th>
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

			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->
				<!-- #modal-dialog -->
					<div class="modal fade" id="modal-dialog-insert">
						<div class="modal-dialog">
							<div class="modal-content width-570">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
		                        	<h4 class="modal-title">자원 등록</h4>
		                       	</div>
		                       	<div class="modal-body">
								 	<p class="f18 commnet tac">자원을 등록하시겠습니까?</p>
			                   </div>
			                   <div class="modal-footer tac">
			                       <a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="catalogInsert();">확인</a>
			                       <a type="button" class="pbton bton_dgrey" data-dismiss="modal" onclick="initCopyPopup();">취소</a>
		                       </div>
			               	</div>
						</div>
		            </div>


		<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">

		    function cloudSearchId(cloudId){
				$("#cloudSearchId").val(cloudId);
               gridList();
            }

			function gridList() {
				$("#bssProductList").dataTable({
					"processing":true
					,"ordering" : false
					,"destroy" : true
					,"autoWidth":false
					,"serverSide":true
					,"displayStart" : "${pageNum}"
					,"ajax": {
						"url":"${contextPath}/mng/bss/product/list"
						,"type" : "GET"
						,"dateSrc" : ""
						,"data":function (d) {
							d.searchKind = $("#searchKind option:selected").val();
							d.productKind = $("#productKind option:selected").val();
							d.productSeq = "${productSeq}";
							d.keyword = $("#keyword").val();
						}
					}
					,"columns":[
								{"data":"productCategoryName"}
					        	, {"data":"productName", "class":"tal"}
					        	, {"data":"delFlag"}
					        	, {"data":"userName"}
					        	, {"data":"regDatetime2"}
					        	, {}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[2], "render": function(data,type,full){
			 					if(full.delFlag=="N"){
			 						return "사용 ";
			 					}else{
			 						return "미사용";
			 					}
							}
						}
						, {"targets":[5], "render": function(data,type,full){
							return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='moveDetailPage(\""+full.productSeq+"\")'><i class='fa fa-search'></i></a>";
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

			function getProductKind(){
				gridList();
			}

		 	function moveDetailPage(productSeq){

				location.href = "${contextPath}/mng/bss/product/view?productSeq="+productSeq;
		 	}

		 	function moveApprovalPage(){

		 		var table = $("#mngProjectList").DataTable();

		 		$("#mngProjectList tbody").on("click", "td.ditailStyle", function() {
					var rowData = table.row($(this).closest("tr")).data();
					var rowSeq = rowData.noticeNo;

					location.href = "${contextPath}/mng/bbs/notice/approval?noticeNo="+rowSeq;

		 		});
		 	}

			function moveInsertPage(){
				$("#modal-dialog-insert").modal();
			}

			function catalogInsert() {
		 		location.href = "${contextPath}/mng/bss/product/write";

			}


			function excelDown(){
			    var params = "";
			    params += "&searchKind=" + $("#searchKind option:selected").val();
			    params += "&keyword=" + $("#keyword").val();
			    params += "&productSeq=${productSeq}";
			    params += "&productKind="+$("#productKind option:selected").val();
			    params += "&cloudKind="+$("#cloudKind option:selected").val();
			    location.href =  '${contextPath}/mng/bss/product/excel?'+params;
			}

			$(document).ready(function() {

				gridList();
				App.init();

				//메뉴활성화
				$("#productAservice").addClass("active");
				$("#product").addClass("active");

				$(".nav-pills>li:first-child").addClass("active");

			});
		</script>
	</body>
</html>