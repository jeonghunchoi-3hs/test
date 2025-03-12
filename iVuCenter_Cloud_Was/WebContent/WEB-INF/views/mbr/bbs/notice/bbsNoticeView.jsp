<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
 		
			<!-- begin header -->
			<h1 class="page-header"><img src="<%=request.getContextPath()%>/resources/images/title_icon/notice.png"/>  공지사항  <span class="root"> <img src="/resources/assets/img/root_icon.png"/> 콘솔 > 사용문의 > 공지사항 </span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
	         	<!-- begin col-12 -->
	         	<div class="col-md-12">
	                	
	                	<!-- begin panel -->
							<!-- begin normal input table---------->
							<div class="tableC">
								<input type="hidden" id="noticeNo" value="${noticeNo}">
								<table>
									<colgroup>
										<col width="100px">
										<col width="200px">
										<col width="100px">
										<col width="200px">
										<col width="100px">
										<col width="*">
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
											<td colspan="5" id="_content" style="vertical-align: top;">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- end normal input table---------->
						<!-- end panel -->
						
						<!-- begin button-->
						<div class="col-md-12 tac mt20">
							<!-- <button type="button" class="btn btn-grey" id="noticeList"  onclick="moveListPage()"><i class="fa fa-reorder"></i> 목록</button> -->
							<a href="${contextPath}/mbr/bbs/notice/"><img src="/resources/assets/img/btn_list.png"/></a> 
						</div>
						<!-- end button -->
							
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



<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	function bbsDetail(noticeNo) {
		$.ajax({
			url : "${contextPath}/mbr/bbs/notice/detail",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"noticeNo" : noticeNo
			},
			success : function(data) {
				var result = data;
				setData(result);
			},
			error : function(request, status, error) {
				alertBox("code:" + request.status + "\n" + "error:" + error, logout);
			}
		});

	}
	
	function setData(result){
		$("#title").text(result.title);
		$("#regDatetime").text(result.regDatetime);
		$("#regUserId").text(result.regUserId);
		$("#userName").text(result.userName);
		$("#codeName").text(result.codeName);
		$("#_content").html(result.content);
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mbr/bbs/notice/";
	}
	
	// 등록/수정 페이지이동
	function moveInsertPage(){
		var noticeNo = $("#noticeNo").val();
		location.href = "${contextPath}/mbr/bbs/notice/write?noticeNo="+noticeNo;
	}
	
	$(document).ready(function() {
		bbsDetail("${noticeNo}");
		App.init();
		
		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsNotice").addClass("active");
	});
	
</script>

</body>
</html>