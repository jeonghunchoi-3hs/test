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
				<h1>권한 관리</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">정책관리</a><a href="#" class="on">권한 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">

				<!-- search begin -->
				<div class="page_searchBox">
					<div class="searchArea">
						<div class="selectBox">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel width-150" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="user_id">ID</option>
								<option value="user_name">사용자명</option>
							</select>
						</div>
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
							<a type='button' class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>
					</div>
				</div>
				<!-- search end -->

				<!-- 테이블시작 -->

					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a type="button" class="bton-s bton_blue" onclick="excelDown();"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
						<a type="button" class="bton-s bton_blue" onclick="openUserModal();"><i class="fa fa-upload"></i><span> 등록</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
						<table id="table-list" class="tableWrap">

							 <colgroup>
								<col width="*">
								<col width="140px">
								<col width="140px">
								<col width="100px">
								<col width="100px">
								<col width="100px">
								<col width="100px">
								<col width="100px">
								<col width="100px">
							</colgroup>
							<thead>
								<tr>
									<th rowspan="2">소속조직(부서)</th>
									<th rowspan="2">ID</th>
									<th rowspan="2">이름</th>
									<th colspan="2">작업</th>
									<th colspan="3">승인</th>
									<th rowspan="2">권한변경</th>
								</tr>
								<tr>
									<th>작업담당</th>
									<th>포털 담당자</th>
									<th>회원가입승인</th>
									<th>한전결재라인</th>
									<th>결재전결</th>
								</tr>
							</thead>
						</table>

			<!-- 일반사용자 목록 팝업 -->
			<!-- #modal-dialog -->
			<div class="modal fade" id="user-modal-dialog">
               <div class="modal-dialog">
                   <div class="modal-content width-570">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'><span></span></button>
                           <h4 class="modal-title">사용자 검색</h4>
                       </div>
                        <div class="modal-body">
							<!-- search begin -->
							<div class="page_searchBox m-b-15">
								<div class="searchArea">
									<div class="selectBox width-100" >
										<label class="selectText" for="searchKindInsert">전체</label>
										<select class="search-sel" id="searchKindInsert">
											<option value="searchAll">전체</option>
											<option value="userId">사번</option>
											<option value="userName">이름</option>
											<option value="deptName">부서</option>
										</select>
									</div>
									<div class="inputArea m-l-5">
										<input type="text" placeholder="검색어를 입력하세요" id="keywordInsert" onkeypress="if(event.keyCode==13)gridPopList();">
										<a type='button' class="bton-s bton_blue" onclick="gridPopList()"><i class="fa fa-search"></i> 검색</a>
									</div>
								</div>
							</div>
							<!-- search end -->

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

							<div class="noneList" id='popListTable2'>
								 <p class="tac pt20">검색된 사용자가 없습니다.</p>
							</div>
                      		<div class="totalcnt" id="totalCnt">총 0 건</div>
	                   	</div>
	                   	<div class="modal-footer tac">
                       		<a type="button" class="whiteline" data-dismiss="modal" onclick='gridList();'>닫기</a>
                       	</div>
	               	</div>
				</div>
           	</div>
			<!-- #modal-dialog -->

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
		 $("#table-list").dataTable( {
				"processing":true
				,"autoWidth":false
				,"serverSide":true
				,"ordering" : false
				,"destroy" : true
				,"ajax": {
					"url":"${contextPath}/mng/operation/adminUser/list"
					,"type" : "GET"
					,"data":function (d) {
						d.searchKind = $("#searchKind option:selected").val();
						d.keyword = $("#keyword").val();
					}
				}
				,"columns":[
		        	{"data":"deptName", "class":"overflow-path tal"}
		        	, {"data":"userId"}
		        	, {"data":"userName"}
		        	, {"data":"operation"}
		        	, {"data":"login"}
		        	, {"data":"WF4000A0"}
		        	, {}
				]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[3], "render":function(data,type,full){
						if(full.operation == "Y"){
							return '<i class="authCheck on"></i>';
						}else{
							return '<i class="authCheck"></i>';
						}
					}
				}
				, {"targets":[4], "render":function(data,type,full){
						if(full.portaladmin == "Y"){
							return '<i class="authCheck on"></i>';
						}else{
							return '<i class="authCheck"></i>';
						}
					}
				}
				, {"targets":[5], "render":function(data,type,full){
						if(full.login == "Y"){
							return '<i class="authCheck on"></i>';
						}else{
							return '<i class="authCheck"></i>';

						}
					}
				}
				, {"targets":[6], "render":function(data,type,full){
						if(full.WF4000A0 == "Y"){
							return '<i class="authCheck on"></i>';
						}else{
							return '<i class="authCheck"></i>';
						}
					}
				}
				, {"targets":[7], "render":function(data,type,full){
						if(full.apprvPass == "Y"){
							return '<i class="authCheck on"></i>';
						}else{
							return '<i class="authCheck"></i>';
						}
					}
				}
				, {"targets":[8], "render":function(data,type,full){
						return '<a type="button" class="bton-s bton_blue" onclick="moveDetailPage(\''+full.userId+'\');"><span class="bg_left"></span><span class="txt"><i class="fa fa-edit"></i> 수정</span><span class="bg_right"></span></a>';
					}
				}
			]
			,"order": [[1,"asc"]]
			,"lengthMenu": [[10,15], [10, 15]]
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

		location.href =  '${contextPath}/mng/operation/adminUser/excel?'+params;
	}

	function openUserModal(){
		gridPopList();
		$("#user-modal-dialog").modal();
	}

	var totalCnt = 0;

	function gridPopList(){
		$.ajax({
			url : "${contextPath}/mng/operation/adminUser/addList",
			dataType : "JSON",
			data : {

				  "searchKind": $("#searchKindInsert option:selected").val()
				, "keyword"	: $("#keywordInsert").val()
			},
			success : function(req) {
				if(req.data.length == 0){
					$("#popListTable").hide();
					$("#popListTable2").show();
				}else{
					$("#popListTable").empty();

					$.each(req.data, function(key,val){
						$("#popListTable").append(
								 '<tr>'
								+'<td>'+val.userName+'</td>'
								+'<td>'+val.userId+'</td>'
								+'<td>'+val.deptName+'</td>'
								+'<a class="applybtn" onclick="insertAdmin(this, \''+val.userId+'\');">적용</a>'
								+'<td class="tac"><input type="button"  value="&#xf00c"  class="popCheckbtn"  onclick="insertAdmin(this, \''+val.userId+'\');" initModal();></td>'
								+'</tr>');

					});
					$("#popListTable").show();
					$("#popListTable2").hide();
				}
				totalCnt = req.data.length;
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
	function insertAdmin(e, userId){
		$.ajax({
			url : "${contextPath}/mng/operation/adminUser/insertAdmin",
			dataType : "JSON",
			data : {
				"userId": userId
			},
			success : function(req) {
				$(e).parent().remove();
				totalCnt = totalCnt-1;
				$("#totalCnt").text("총 "+totalCnt+" 건");
				if(totalCnt == 0){
					$("#popListTable").hide();
					$("#popListTable2").show();
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

 	function moveDetailPage(userId){
 		location.href="${contextPath}/mng/operation/adminUser/view?userId="+userId;
 	}

	$(document).ready(function() {
		App.init();
		gridList();

		//메뉴활성화
 		$("#operation").addClass("active");
 		$("#adminUser").addClass("active");

	});
</script>
</body>
</html>