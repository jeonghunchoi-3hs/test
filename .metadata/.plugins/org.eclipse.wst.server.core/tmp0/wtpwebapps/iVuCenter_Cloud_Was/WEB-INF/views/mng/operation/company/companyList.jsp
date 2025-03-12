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
			<h1 class="page-header fc66 fb"> <i class="fa fa-dot-circle-o fcb"> </i> 사업자관리 <span class="root">회원사관리 > 사업자관리</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
			<!-- search begin -->
			<div class="col-md-12 bgee br10 mb10">		
				<div class="col-md-2 p10"> 
					<select class="form-control" id="searchKind">
						<option value="company_name">사업자명</option>
						<option value="company_no">사업자번호</option>
					</select>
				</div>
				<div class="col-md-9 p10"><input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword" /></div>
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
									<th>사업자 ID</th>
									<th>사업자 명</th>
									<th>사업자 번호</th>
									<th>대표자 이름</th>
									<th>사업자 주소</th>
									<th>담당자 이름</th>
									<th>담당자 휴대폰번호</th>
									<th>담당자 전화번호</th>
									<th>담당자 메일주소</th>
									<th>등록일시</th>
									<th>등록자</th>
									<th>수정일시</th>
									<th>수정자</th>
									<th>삭제 여부</th>
									<th>상세</th>
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
				"url":"list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[ 
				{"data":"companyId" , "class":"tac"}
				, {"data":"companyName" , "class":"tac"}
				, {"data":"companyNo" , "class":"tac"}
				, {"data":"companyRep" , "class":"tac"}
				, {"data":"companyAddr" , "class":"tac"}
				, {"data":"contactName" , "class":"tac"}
				, {"data":"contactPhone" , "class":"tac"}
				, {"data":"contactTel" , "class":"tac"}
				, {"data":"contactMail" , "class":"tac"}
				, {"data":"regDatetime" , "class":"tac"}
				, {"data":"regUserId" , "class":"tac"}
				, {"data":"modDatetime" , "class":"tac"}
				, {"data":"modUserId" , "class":"tac"}
				, {"data":"delFlag" , "class":"tac"}
		        , {"class":"tac", "width":"15%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0],"visible":false,"searchable":false }
				, {"targets":[4],"visible":false,"searchable":false }
				, {"targets":[5],"visible":false,"searchable":false }
				, {"targets":[6],"visible":false,"searchable":false }
				, {"targets":[7],"visible":false,"searchable":false }
				, {"targets":[8],"visible":false,"searchable":false }
				, {"targets":[9],"visible":false,"searchable":false }
				, {"targets":[10],"visible":false,"searchable":false }
				, {"targets":[11],"visible":false,"searchable":false }
				, {"targets":[12],"visible":false,"searchable":false }
				, {"targets":[13],"visible":false,"searchable":false }
				, {"targets":[14], "render": function(data,type,full){
					return '<input type="button" class="btn btn-info w-80" value="상세보기" onclick="movePageDetail(\''+full.companyId+'\')"/>';
					}	
				}
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top"T>rt<"bottom"pi>'
			,"oTableTools": {
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

 
	function movePageDetail(companyId){
		var params = "?companyId="+companyId;
		location.href = "${contextPath}/mng/operation/company/view"+params
	}
 
 	
 	function moveInsertPage(){
 		location.href = "${contextPath}/mng/operation/company/write";
 	}

	$(document).ready(function() {
		App.init();
		gridList();
		
		//메뉴활성화
		$("#request").addClass("active");
		$("#reqCompany").addClass("active"); 
	});
</script>
</body>
</html>