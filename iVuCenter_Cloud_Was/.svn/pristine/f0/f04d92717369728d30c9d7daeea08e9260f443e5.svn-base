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

    <div id="wrapper">
    
    	<c:import url="${contextPath}/mng/navi/naviTop.jsp" charEncoding="UTF-8"></c:import>

        <div id="page-wrapper">
            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">${title} <small> ${sub}</small></h1>
                        <input type='hidden' id='subname' name='subname' value='${sub}'/>
                    </div>
                </div>
                <!-- /.row -->
                
				<div class="row">
                    <div class="col-lg-12">
                    	<div class="panel panel-default">
							<div class="panel-body">
							<table class='table table-striped table-bordered table-hover' id='list'  class='display' cellspacing='0' width='100%'>
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
								<th>등록일시</th>
								<th>등록자</th>
								<th>수정일시</th>
								<th>수정자</th>
							</tr>
							</thead>
							</table>
							</div>
                    	</div>
                    </div>
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->
    </div>
    <!-- /#wrapper -->
    <c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
</body>
</html>
