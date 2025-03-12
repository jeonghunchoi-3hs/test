<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />

<c:import url="${contextPath}/WEB-INF/views/home/include/home_import.jsp" charEncoding="UTF-8"></c:import>

<title>KEPCO Cloud Service Platform</title>
</head>
<body>
	<div id="container">

	<!-- top menu start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_top.jsp" charEncoding="UTF-8"></c:import>	
	<!-- top menu end -->
		 
	 <div class="cimg"></div>
	  <div class="sub mb30">
	    <h3 class="subtitle"><i class="fa fa-cloud f18"></i> 공지사항</h3>

		 

	                	
	                	<!-- begin panel -->
							<!-- begin normal input table---------->
							<div class="tableC">
								<input type="hidden" id="noticeNo" value="${fn:escapeXml(noticeNo)}">
								<table>
									<colgroup>
										<col width="8%">
										<col width="25%">
										<col width="9%">
										<col width="25%">
										<col width="8%"> 
										<col width="25%">
									</colgroup>
									<tbody>
										<tr>
											<td class="left-b">제목</td>
											<td colspan="5"  id="title">
											</td>
										</tr>
										<tr>
											<td class="left-b">유형</td>
											<td id="codeName"></td>
											<td class="left-b">작성자</td>
											<td id="userName"></td>
										  	<td class="left-b">작성일</td>
										  	<td id="regDatetime"></td>
										</tr>

										<tr>
											<td class="left-b">내용</td>
											<td colspan="6" id="_content" style="vertical-align: top;"></td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- end normal input table---------->
						<!-- end panel -->
						
						<!-- begin button-->
						<div class="tac mt20">
							<button type="button" class="btn btn-grey" id="noticeList"  onclick="moveListPage()"><i class="fa fa-reorder"></i> 목록</button>
						</div>
						<!-- end button -->
							

		 
		 
	 </div>
		
	  
	 
	 
	<div class="clear"></div>
	
	<!-- footer start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
	<!-- footer end -->
	
	
	
	</div>
	

	
</body>

<script type="text/javascript">
	
	function bbsDetail(noticeNo) {
		$.ajax({
			url : "${contextPath}/homepage/detail",
			dataType : "JSON",
	//			type : "POST",
			data : {
				"noticeNo" : encodeURIComponent(noticeNo)
			},
			success : function(data) {
				var result = data;
				setData(result);
			},
			error : function(request, status, error) {
				alertBox("code:" + request.status + "\n" + "error:" + error);
			}
		});
	
	}
	
	function sanitizeHTML(str) {
		var temp = document.createElement('div');
		temp.innerHTML = str;
		['script', 'style', 'iframe', 'link', 'meta', 'object', 'embed'].forEach(tag => {
			var elements = temp.getElementsByTagName(tag);
			for (let i = elements.length - 1; i >= 0; i--) {
				elements[i].parentNode.removeChild(elements[i]);
			}
		});
		return temp.innerHTML;
	}
	
	function setData(result){
		$("#title").text(result.title);
		$("#regDatetime").text(result.regDatetime2);
		$("#regUserId").text(result.regUserId);
		$("#codeName").text(result.codeName);
		$("#userName").text(result.userName);
		
		var safeContent = sanitizeHTML(result.content);
		$("#_content").html(safeContent);
	}

	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/homepage/notice/";
	}

	$(document).ready(function() {
		bbsDetail("${fn:escapeXml(noticeNo)}");
	});


</script>
	
</html>