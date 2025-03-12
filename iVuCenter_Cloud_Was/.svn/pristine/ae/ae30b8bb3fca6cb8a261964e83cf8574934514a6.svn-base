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
				<h1>접속이력</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">알림/접속 관리</a><a href="#" class="on">접속이력 조회</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
					<input type="hidden" id="h_searchGubun" value="${historyGubun}">
                        <!-- begin tab-content -->
                            <div class="tab-pane fade active in" id="nav-pills-tab-1">
                      				<div class="page_searchBox m-b-15">
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
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="user_id">사용자</option>				
								<option value="user_name">사용자명</option>	
								<option value="site_gbn_name">포털구분</option>	
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" class="width-200" onkeypress="if(event.keyCode==13)gridList();">
							<a type="button" class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i>  검색</a>
						</div>
					</div>
				</div>
                  </div>
                <!-- end tab-content -->
			
				
			

                    <!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
                   
					<!-- 그리드 영역 -->
					
						<table id="loginHistoryList" summary="접속이력" class="tableWrap">
							<colgroup>
								<col width="180px">
								<col width="90px">
								<col width="150px">
								<col width="130px">
								<col width="100px">
								<col width="130px">	
								<col width="130px">								
								<col width="*">
							</colgroup>
							<thead>
								<tr>
									<th>일시</th>
									<th>포털구분</th>
									<th>서비스</th>
									<th>IP주소</th>
									<th>ID</th>
									<th>사용자명</th>									
									<th>성공/실패</th>
									<th>로그인 실패 사유</th>
								</tr>
							</thead>
						</table>

			
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
		    
			$("#startY").val(currentYear);
			$("#startY").siblings(".selectText").text($("#startY > option:selected").text());
			
			$("#endY").val(currentYear);
			$("#endY").siblings(".selectText").text($("#endY > option:selected").text());
			
		    $("#startM").val(currentMonth).attr("selected","selected");
		    $("#startM").siblings(".selectText").text($("#startM > option:selected").text());
		    
		    $("#endM").val(currentMonth).attr("selected","selected"); 
		    $("#endM").siblings(".selectText").text($("#endM > option:selected").text());
		}




	function gridList() {
		
		var startY = $("#startY option:selected").val();
		var startM = $("#startM option:selected").val();
		var endY = $("#endY option:selected").val();
		var endM = $("#endM option:selected").val();
		
		var startYm = startY + startM;
		var endYm = endY + endM;
		
		
		 $("#loginHistoryList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/aop/loginHistoryList"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.startYm = startYm;
					d.endYm = endYm;
				}
			}
			,"columns":[ 
	        	{"data":"loginDatetime", "class":"tal"}
	        	, {"data":"siteGbnName"}
	        	, {"data":"service"}
	        	, {"data":"ip"}
	        	, {"data":"userId"}
	        	, {"data":"userName"} 
	        	, {"data":"successYn"}
	        	, {"data":"loginFailMessage", "class":"tal"}

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

	function excelDown(){
		
		var startY = $("#startY option:selected").val();
		var startM = $("#startM option:selected").val();
		var endY = $("#endY option:selected").val();
		var endM = $("#endM option:selected").val();
		
		var startYm = startY + startM;
		var endYm = endY + endM;
		
	    var params = "";
	    params += "&searchKind=" + $("#searchKind option:selected").val();
	    params += "&keyword=" + $("#keyword").val();
	    params += "&startYm=" + startYm;
	    params += "&endYm=" + endYm;
	    location.href = '${contextPath}/mng/cmm/aop/loginHistoryExcel?'+params;
	}
     	
	$(document).ready(function() {
		
		getYearMonth();
		gridList();
		App.init();
		//메뉴활성화
		$("#alarms").addClass("active");
		$("#loginHistory").addClass("active");

	});
</script>
</body>
</html>