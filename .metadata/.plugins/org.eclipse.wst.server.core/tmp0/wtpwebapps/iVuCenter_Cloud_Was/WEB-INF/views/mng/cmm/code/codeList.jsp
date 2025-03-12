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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content" style='display:none;'>
			<!-- begin header -->
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 공통코드 관리 <span class="root">운영관리 > 공통코드 관리</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<input type='hidden' id='list2SearchKey' name='list2SearchKey'  value='' />
			
				<!-- search begin -->
				<div class="col-md-12 bgee br10 mb10">
					<div class="col-md-10 p10 ml-10"><input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword"  onkeypress="if(event.keyCode==13)gridList();"/></div>
					<div class="col-md-1 p10 ml-5">
						<button type="button" class="btn btn-grey" onclick="gridList()"><i class="fa fa-search"></i> 검색</button>
					</div>
				</div>	
				<!-- search end -->
				
				<!-- 테이블시작 -->
				<div class="col-md-12">
					<div class="panel">
					    <div class="table-responsive">
					        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="cmmCode-list">
								<thead>
								    <tr class="grey">
										<th>KEY ID</th>
										<th>ID</th>
										<th>이름</th>
										<th>유형</th>
										<th>레벨</th>
										<th>상위ID</th>
										<th>숨김여부</th>
										<th>정렬순번</th>
										<th>삭제여부</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- end page-body -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<!-- search begin -->
				<div class="col-md-12 bgee br10 mb10">
					<div class="col-md-10 p10 ml-10"><input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword"  onkeypress="if(event.keyCode==13)gridList2();"/></div>
					<div class="col-md-1 p10 ml-5">
						<button type="button" class="btn btn-grey" onclick="gridList2()"><i class="fa fa-search"></i> 검색</button>
					</div>
				</div>	
				<!-- search end -->
				
				<!-- 테이블시작 -->
				<div class="col-md-12">
					<div class="panel">
					    <div class="table-responsive">
					        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="cmmCode-list2">
								<thead>
								    <tr class="grey">
										<th>KEY ID</th>
										<th>ID</th>
										<th>이름</th>
										<th>유형</th>
										<th>레벨</th>
										<th>상위ID</th>
										<th>숨김여부</th>
										<th>정렬순번</th>
										<th>삭제여부</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
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
	location.href = "${contextPath}/mng/mnghome/dashboard";
</script>        
         
</body>
</html>
