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
				<h1>사용자 관리</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">정책관리</a><a href="#" class="on">사용자 관리</a>
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
							<a type="button" class="bton-s bton_blue" onclick="gridList()"><i class='fa fa-search'></i> 검색</a>
				
					</div>
				</div>
				<!-- search end -->
				
				<!-- 테이블시작 -->
	
					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a type="button" class="bton-s bton_blue" onclick="excelDown();"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
					
						<table id="user-list" class="tableWrap">
						
							<colgroup>
								<col width="*">
								<col width="10%">
								<col width="10%">
								<col width="12%">
								<col width="12%">
								<col width="8%">
								<col width="6%">
							</colgroup>
							<thead>
								<tr>
									<th>소속조직(부서)</th>
									<th>ID</th>
									<th>사용자명</th>
									<th>전화번호(사선)</th>
									<th>수신여부</th>
									<th>잠금</th>
									<th>상세</th>
								</tr>
							</thead>
						</table>
				

				
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

	function gridList() {
		$("#user-list").dataTable( {
			"processing":true
			,"ordering" : false
			,"destroy" : true
			,"autoWidth":false
			,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/user/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[ 
				{"data":"deptName", "class":"tal"}
				, {"data":"userId", "class":"tac"}
				, {"data":"userName", "class":"tac"}
				, {"data":"userTelEx", "class":"tac"}
				, {"class":"tac"}
	        ]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }				
				, {"targets":[4], "render": function(data,type,full){
						var smsFlag = full.smsRecvFlag;
						var mailFlag = full.mailRecvFlag;
						//var nhwithFlag = full.nhwithRecvFlag;
						
						var html = "";
						
						html += "<ul class='pushBtns'>";
						
						if(smsFlag=="Y"){
							smsFlag = "<li class='push_sms on'></li>";
						}else{
							smsFlag = "<li class='push_sms'></li>";
						}
						
						if(mailFlag=="Y"){
							mailFlag = "<li class='push_mail on'></li>";
						}else{
							mailFlag = "<li class='push_mail'></li>";
						}
						
						// mailFlag = "<li class='push_mail on'></li>";
						
						
						html += smsFlag;
						html += mailFlag;
					//	html += nhwithFlag;
						
						html += "</ul>";
						
						
					
					return html;
					}	
				}
				, {"targets":[5], "render": function(data,type,full){
						if(full.userBlock == "N"){
							return "<a type='button' class='bton-s bton_orange' onclick='userBlock(\"Y\",\""+full.userId+"\")'>잠금</a>";
						} else if(full.userBlock == "Y"){
							return "<a type='button' class='bton-s bton_blue' onclick='userBlock(\"N\",\""+full.userId+"\")'>해제</a>";
						}
					}	
				}
				, {"targets":[6], "render": function(data,type,full){
					return "<a type='button' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.userId+"\")'><i class='fa fa-search'></i></a>";
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

	function moveDetailPage(userId){
		var params = "?userId="+userId;
		location.href = "${contextPath}/mng/cmm/user/viewPage"+params;
	}
	
	function excelDown(){
	    var params = "";
	    params += "&searchKind=" + $("#searchKind option:selected").val();
	    params += "&keyword=" + $("#keyword").val();
	    location.href =  '${contextPath}/mng/cmm/user/excel?'+params;
	}

	function userBlock(block,userId){
		$.ajax({
			url : "${contextPath}/mng/cmm/user/blockUpdate",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" 		: userId
				, "userBlock" 		: block
			},
			success : function(data) {
				alertBox("처리되었습니다.", reload);
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	function reload(){
		location.reload();
	}
	
	$(document).ready(function() {
		App.init();
		gridList();
		
		//메뉴활성화
		$("#operation").addClass("active");
		$("#cmmUser").addClass("active");
	});
</script>
</body>
</html>