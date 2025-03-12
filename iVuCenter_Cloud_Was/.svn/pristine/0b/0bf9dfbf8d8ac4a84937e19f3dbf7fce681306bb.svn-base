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
	<c:import url="/WEB-INF/views/mbr/include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mbr/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mbr/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin header
			<div class="page_header">
				<div class="pageNav">
					<a href="${contextPath}/mbr/main" class="home"><i></i></a><a href="#">변경신청</a><a href="#" class="on">부서별 결재경로관리</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin header -->
			<h1 class="page-header">
				<span class="root"> <span class="home"><img src="${apachePath}/resources/assets/img/ico_home.png"  alt="홈"/></span>
									<span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span>
									<span class="text arrow"><a href="${wasPath}/mbr/req/project/projectList.do">신청 현황</a></span>
									<span class="text arrow"><a href="${wasPath}/mbr/req/project/projectList.do">프로젝트 신청 현황</a></span>
									<span class="text arrow mint"><a href="${wasPath}/mbr/req/project/projectList.do"><strong>부서별 결재 경로관리 </strong></a></span>
				</span>
			</h1>
			<!-- end header -->
			

			<!-- begin page-body -->
			<div class="row pb50">
				<p class="page_title">부서별 결재라인 관리 </p>		
				
			<!-- search begin -->
			<div class="col-md-12 br5 p10 mb20 bgee">	
				<div class="" style="text-align: center; display:inline-block;"> 
					<div class="selectBoxAr">
						<label class="selectText" for="searchKind">사번</label>
						<select class="search-sel" id="searchKind">
							<option value="user_id">사번</option>
							<option value="user_name">사용자명</option>
						</select>
					</div>
					<div class="searchBoxAr">
						<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
						<button type="button" class="btn_search2"  onclick="gridList()"><span></span></button>
					</div>
			  	</div>
			</div>	
			<!-- search end -->		
				
				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a type="button" class="btnType01 m-r-5" onclick="excelDown();"><i class="ico_download"></i><span>다운로드</span></a>
						<a type="button" class="btnType01" onclick="openUserModal();"><i class="ico_write m-l-5"></i><span>등록</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
					<div class="tableWrap gridType01_bType m-t-15">
						<table id="table-list" summary="네트워크 정책관리 " class="tableV">
							<caption>게시판 목록 : 사번, 이름, 작업, 자원승인, 정상승인, 권한변경, 장업담당, 작업확인, 1차승인 , 2차승인 , 3차승인, 신청자, 1차승인, 기획담당, 회계담당, 2차승인  로 구성</caption> 
							 <colgroup>
								<col width="135px">
								<col width="102px">
								<col width="73px">
								<col width="73px">
								<col width="60px">
								<col width="60px">
								<col width="60px">
								<col width="55px">
								<col width="60px">
								<col width="60px">
								<col width="73px">
								<col width="73px">
								<col width="84px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" rowspan="2">사번</th>
									<th scope="col" rowspan="2">이름</th>
									<th scope="col" colspan="3" class="theader_bdr">부서승인</th>
								</tr>
								<tr>
									<th scope="col" class="theaderType01">요청부서검토</th>
									<th scope="col" class="theaderType01">요청부서승인</th>
									<th scope="col" class="theaderType01">승인부서담당</th>
									<th scope="col" class="theaderType01">승인부서검토</th>
									<th scope="col" class="theaderType01">승인부서승인</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			
			<!-- 일반사용자 목록 팝업 -->
			<!-- #modal-dialog -->
			<div class="modal fade" id="user-modal-dialog">
               <div class="modal-dialog">
                   <div class="modal-content w560">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'><span></span></button>
                           <h4 class="modal-title">사용자 검색</h4>
                       </div>
                       <div class="modal-body">
                       		<div class="page_searchBox m-b-15">
								<div class="searchArea">
									<div class="inputArea m-l-5">
										<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)gridPopList();" style="width: 362px">
										<a type='button' class="btn_search" onclick="gridPopList();">검색</a>
									</div>
								</div>
							</div>
							
							<div class="noneList" id='popListTable2'>
								 <span>검색된 사용자가 없습니다.</span>
							</div> 
							<div class="listArea" id="popListTable" style="display: none;"></div>
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
			<c:import url="/WEB-INF/views/mbr/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
			</div>
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
<c:import url="/WEB-INF/views/mbr/include/script.jsp" charEncoding="UTF-8"></c:import>	
<script type="text/javascript">
 	
	function gridList() {
		 $("#table-list").dataTable( {
				"processing":true
				,"autoWidth":false
				,"serverSide":true
				,"ordering" : false
				,"destroy" : true
				,"ajax": {
					"url":"${contextPath}/mbr/operation/approveUser/list"
					,"type" : "GET"
					,"data":function (d) {
						d.searchKind = $("#searchKind option:selected").val();
						d.keyword = $("#keyword").val();
					}
				}
				,"columns":[ 
		        	{"data":"userId", "class":"tac fontVdn"}
		        	, {"data":"userName", "class":"tac"}
		        	, {"data":"operation", "class":"tac"}
		        	, {"data":"WF3000A0", "class":"tac"}
		        	, {"data":"WF3000B0", "class":"tac"}
		        	, {"data":"WF3000C0", "class":"tac"}
		        	, {"data":"WF3000D0", "class":"tac"}
		        	, {"data":"WF3000E0", "class":"tac"}
		        	, {"class":"tac"}
				]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[2], "render":function(data,type,full){
						if(full.WF3000A0 == "Y"){
							//return '<i class="authCheck on"></i>';
							return 'Y';
							
						}else{
						   //return '<i class="authCheck"></i>';
							return 'N';
							   
						}
					}
				}
				, {"targets":[3], "render":function(data,type,full){
						if(full.WF3000B0 == "Y"){
							//return '<i class="authCheck on"></i>';
							return 'Y';
						}else{
							 //return '<i class="authCheck"></i>';
							return 'N';
						}
					}
				}
				, {"targets":[4], "render":function(data,type,full){
						if(full.WF3000C0 == "Y"){  
							return 'Y';
						}else{
							return 'N';
						}
					}
				}
				, {"targets":[5], "render":function(data,type,full){
						if(full.WF3000D0 == "Y"){
							return 'Y';
						}else{
							return 'N';
						}
					}
				}
				, {"targets":[6], "render":function(data,type,full){
						if(full.WF3000E0 == "Y"){
							return 'Y';
						}else{
							return 'N';
						}
					}
				}
				, {"targets":[7], "render":function(data,type,full){
						if(full.WF2000A0 == "Y"){
							return '<i class="authCheck on"></i>';
						}else{
							return '<i class="authCheck"></i>';
						}
					}
				}
				, {"targets":[8], "render":function(data,type,full){
						if(full.WF2000B0 == "Y"){
							return '<i class="authCheck on"></i>';
						}else{
							return '<i class="authCheck"></i>';
						}
					}
				}
				, {"targets":[9], "render":function(data,type,full){
						if(full.WF2000C0 == "Y"){
							return '<i class="authCheck on"></i>';
						}else{
							return '<i class="authCheck"></i>';
						}
					}
				}
				, {"targets":[10], "render":function(data,type,full){
						if(full.WF2000D0 == "Y"){
							return '<i class="authCheck on"></i>';
						}else{
							return '<i class="authCheck"></i>';
						}
					}
				}
				, {"targets":[11], "render":function(data,type,full){
						if(full.WF2000E0 == "Y"){
							return '<i class="authCheck on"></i>';
						}else{
							return '<i class="authCheck"></i>';
						}
					}
				}
				, {"targets":[12], "render":function(data,type,full){
						return '<a type="button" class="btnType05" onclick="moveDetailPage(\''+full.userId+'\');"><span class="bg_left"></span><span class="txt">변경</span><span class="bg_right"></span></a>';
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
		
		location.href =  '${contextPath}/mbr/operation/approveUser/excel?'+params;
	}
 	
	function openUserModal(){
		gridPopList();
		$("#user-modal-dialog").modal();
	}
	
	var totalCnt = 0;
	
	function gridPopList(){
		$.ajax({
			url : "${contextPath}/mbr/operation/approveUser/addList",
			
			dataType : "JSON",
			data : {
				"searchKind": "user_name"
				, "keyword"	: $("#searchKeyword").val()
			},
			success : function(req) {
				if(req.data.length == 0){
					$("#popListTable").hide();
					$("#popListTable2").show();
				}else{
					$("#popListTable").empty();
					
					$.each(req.data, function(key,val){
						$("#popListTable").append('<div class="listBg">'
								+'<span class="name">'+val.userName+'</span>'
								+'<span class="idlabel">(사번 : <span class="userid nanumR">'+val.userId+'</span>)</span>'
								+'<a class="applybtn" onclick="insertAdmin(this, \''+val.userId+'\');">적용</a>'
							+'</div>');
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
			url : "${contextPath}/mbr/operation/approveUser/insertUserAdmin",
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
 		location.href="${contextPath}/mbr/operation/approveUser/view?userId="+userId;
 	}
	
	$(document).ready(function() {
		App.init();
		gridList();
		
		
		//메뉴활성화
		$("#reqStatus").addClass("active");
	 	$("#projectList").addClass("active");

	});
</script>
</body>
</html>