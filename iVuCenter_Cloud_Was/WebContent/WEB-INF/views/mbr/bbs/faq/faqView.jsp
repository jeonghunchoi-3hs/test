<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
		
			<!-- begin header -->
			<h1 class="page-header"><img src="<%=request.getContextPath()%>/resources/images/title_icon/faq.png"/>  FAQ  <span class="root"> <img src="/resources/assets/img/root_icon.png"/> 콘솔 > 사용문의 > FAQ  </span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<!-- begin col-12 -->
	         	<div class="col-md-12">
	                	
	                	<!-- begin panel -->
							<!-- begin normal input table---------->
							<div class="tableC">
								<input type="hidden" id="faqNo" value="${faqNo}"/>
								<table>
									<colgroup>
										<col width="100px">
										<col width="200px">
										<col width="100px">
										<col width="200px">
										<col width="100px">
										<col width="278px">
									</colgroup>
									<tbody>
										<tr>
											<td class="left-b">제목</td>
											<td colspan="5" id="title">
											</td>
										</tr>
										<tr>
											<td class="left-b">유형</td>
											<td id="codeName">

												<%-- 
												<select name="faqType" id="faqType">
													<c:forEach items="${code}" var="codelist" varStatus="status" >
														<option value="${codelist.codeId}">${codelist.codeName}</option>
													</c:forEach>
												</select>
												 --%>
												
											</td>
											<td class="left-b">작성자</td>
											<td id="regUserId">	${userId}</td>
											<td class="left-b">작성일</td>
											<td id="regDatetime" ></td>
										</tr>
										<tr>
											<td class="left-b">내용</td>
											<td colspan="5" id="_content" style="white-space: pre-wrap; vertical-align: top;" class="height-200">
											</td>
										</tr>
										
									</tbody>
								</table>
							</div>
							<!-- end normal input table---------->
						<!-- end panel -->
						
					<!-- begin button-->
					<div class="col-md-12 tac mt20">
						<button type="button" class="btn btn-grey" id="noticeList"  onclick="moveListPage()"><i class="fa fa-reorder"></i> 목록</button>
					</div>
			 	</div>
			 	<!-- end col-12 -->
	
			</div>
			<!-- end page-body -->
			
			<!-- begin #footer -->
          
               <c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
           
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
			
	</div>
	<!-- end page container -->

	
</body>


<script type="text/javascript">

	function bbsDetail(faqNo) {
		$.ajax({
			url : "${contextPath}/mbr/bbs/faq/detail",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"faqNo" : faqNo
			},
			success : function(data) {
				var result = data;
				setData(result);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}
	
	function setData(result){
		$("#title").text(result.title);
		$("#regDatetime").text(result.regDatetime);
		$("#regUserId").text(result.regUserId);
		//$("#hitCount").text(result.hitCount);
		$("#codeName").text(result.codeName);
		$("#faqType").val(result.faqType);
		$("#_content").text(result.content);
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mbr/bbs/faq/";
	}
	// 등록/수정 페이지이동
	function moveInsertPage(){
		var faqNo = $("#faqNo").val();
		location.href = "${contextPath}/mbr/bbs/faq/write?faqNo="+faqNo;
	}
	
	$(document).ready(function() {
		bbsDetail("${faqNo}");
		App.init();
		
		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsFaq").addClass("active");
	
	});
	
</script>

</html>