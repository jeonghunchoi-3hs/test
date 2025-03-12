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
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 프로젝트 관리 <span class="root">프로젝트 관리</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
			<!-- search begin -->
			<div class="col-md-12 bgee br10 mb10">		
				<div class="col-md-2 p10"> 
					<select class="form-control pb6" id="searchKind">
						<option value="project_alias">프로젝트명</option>
						<option value="project_name">프로젝트별칭</option>
					</select>
				</div>
				<div class="col-md-9 p10">  <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword" onkeydown="if(event.keyCode==13)gridList();"/></div>
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
									<th>회원사</th>
									<th>프로젝트명</th>
									<th>프로젝트별칭</th>
									<th>담당 PM</th>
									<!-- <th>상세</th> --> 
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
				"url":"${contextPath}/mng/oss/project/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.customerId = "";
				}
				,"error": function (xhr, error, thrown) {
					if ( error == "parsererror" ) {
						location.reload();
					}else{
						errorBox("ajax error");
						return false;
					}
				}	
			}
			,"columns":[ 
				{"data":"customerName" , "class":"tac"}
				, {"data":"projectName" , "class":"tac"}
				, {"data":"projectAlias" , "class":"tac"}
				, {"data":"userName" , "class":"tac"}
		        //, {"class":"tac", "width":"10%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[1], "render": function(data,type,full){
					return "<a href='#' onclick='movePageDetail(\""+full.projectId+"\",\""+full.projectName+"\")'>" + full.projectName + "</a>";
					}	
				}
				//, {"targets":[4], "render": function(data,type,full){
				//	return "<button type='button' class='btn btn-grey_01' onclick='movePageDetail(\""+full.projectId+"\",\""+full.projectName+"\")' ><i class='fa fa-search'></i></button>";
				//	}	
				//}				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top"T>rt<"bottom"p>',"oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {
						moveInsertPage();
					}
				}]
			}
		});
	}

	function movePageDetail(projectId, projectName){
		var params = "?projectId="+projectId;
		params += "&projectName="+projectName;

		location.href = "${contextPath}/mng/oss/project/view"+params;
	}
	
	function moveInsertPage(){
		location.href = "${contextPath}/mng/oss/project/write";
	}
	
	$(document).ready(function() {
		gridList();
		App.init();
		
		//메뉴활성화
		$("#project").addClass("active");
	});
</script>
</body>
</html>