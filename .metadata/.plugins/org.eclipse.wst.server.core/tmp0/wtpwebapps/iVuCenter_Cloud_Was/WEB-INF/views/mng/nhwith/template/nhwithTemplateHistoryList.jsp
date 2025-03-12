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

	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in hide"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin header -->
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> NHwith 발송이력 목록 <span class="root">관리자포털 > NHwith > NHwith 발송이력 </span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
			<!-- search begin -->
			<div class="col-md-12 bgee br10 mb10">		
				<div class="col-md-2 p10"> 
					<select class="form-control" id="searchKind">
						<option value="receiver_name">수신자이름</option>
						<option value="result_flg">발송결과</option>						
					</select>
				</div>
				<div class="col-md-9 p10">  <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword" /></div>
<!-- 				<div class="col-md-1"><a href="#"><button type="button" class="btn btn-grey w-80">검색</button></a> </div> -->
				<div class="col-md-1 p10"><input type="button" class="btn btn-grey w-80" value="검색" onclick="gridList()"></div>
			</div>	
			<!-- search end -->
			
			<!-- 테이블시작 -->
			<div class="col-md-12">
				<div class="panel">
				    <div class="table-responsive">
				        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="table-list">
							<thead>
							    <tr class="grey">
									<th>수신자 구분</th>
									<th>수신자 ID</th>
									<th>수신자 이름</th>									
									<th>발송처리상태</th>
									<th>발송처리일시</th>
							    </tr>
							</thead>
						</table>
					</div>
				</div>			
			</div>
			<!-- 테이블 끝 -->
			
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
		$("#table-list").dataTable( {
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
				}
			}
			,"columns":[ 
				{"data":"receiverFlg" , "class":"tac"}
				, {"data":"receiverId" , "class":"tac"}
				, {"data":"receiverName" , "class":"tac"}				
				, {"data":"resultFlg" , "class":"tac"}
				, {"data":"resultDatetime" , "class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0], "render": function(data,type,full){
						if(full.receiverFlg=="U"){
							return "사용자";
						}else if(full.receiverFlg=="C"){
							return "회원사";
						}else{
							return "사용자";
						}					
					}	
				}
				, {"targets":[1], "render": function(data,type,full){
					return "<a href='#' onclick='movePageDetail(\""+full.nhwithSeq+"\")'>" + full.receiverId + "</a>";
					}	
				}
				, {"targets":[3], "render": function(data,type,full){
						if(full.resultFlg=="Y"){
							return "성공";
						}else{
							return "실패";
						}
					}	
				}
				, {"targets":[4], "render": function(data,type,full){
					return full.resultDatetime.substring(0,19);
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

	function movePageDetail(nhwithSeq){
		var params = "?nhwithSeq="+nhwithSeq;
		location.href = "${contextPath}/mng/nhwith/template/nhwithTemplateHistoryView"+params;
	}
	
	$(document).ready(function() {
		App.init();
		gridList();
		//메뉴활성화
		$("#nhwith").addClass("active");
		$("#nhwithHistory").addClass("active");
	});
</script>
</body>
</html>