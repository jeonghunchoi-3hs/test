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
	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading..</span></div>
	<!-- end #page-loader -->

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
		
			<!-- begin header -->
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 사업자관리 <span class="root">콘솔 > 고객센터 > 자료실</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
	         	<!-- begin col-12 -->
	         	<div class="col-md-12">
	                	
	                	<!-- begin panel -->
							<!-- begin normal input table---------->
							<div class="tableB mb20">
							<input type="hidden" id="companyId" value="${companyId}">
							<input type="hidden" id="filesCnt" value="${filesCnt}">
								<table>
									<colgroup>
										<col width="10%">
										<col width="40%">
										<col width="10%">
										<col width="40%">
									</colgroup>
									<tbody>
										<tr>
											<td class="cen height-40">사업자 명</td>
										  	<td colspan="3">
												<div class="col-md-6" id="companyName"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen height-40">사업자 번호</td>
											<td colspan="3">
												<div class="col-sm-6" id="companyNo">
												</div>
											</td>
										</tr>
										<tr>
											<td class="cen height-40 tac">대표자 이름</td>
											<td colspan="3">
												<div class="col-sm-6" id="companyRep">
												</div>
										  	</td>
										</tr>
										<tr>
											<td class="cen height-40 tac">사업자 주소</td>
											<td colspan="3">
												<div class="col-sm-6" id="companyAddr">
											  	</div>
											</td>
										</tr>
										<tr>
											<td class="cen height-40">담당자 이름</td>
										  	<td colspan="3">
												<div class="col-sm-6" id="contactName">
											  	</div>
											</td>
										</tr>
										<tr>
											<td class="cen height-40">담당자 휴대폰번호</td>
										  	<td colspan="3">
												<div class="col-sm-6" id="contactPhone"> 
											  	</div>
											</td>
										</tr>
										<tr>
											<td class="cen height-40">담당자 전화번호</td>
										  	<td colspan="3">
												<div class="col-sm-6" id="contactTel">
											  	</div>
											</td>
										</tr>
										<tr>
											<td class="cen height-40">담당자 메일주소</td>
										  	<td colspan="3">
												<div class="col-sm-6" id="contactMail">
											  	</div>
											</td>
										</tr>										
										<tr>
											<td class="cen height-40 tac">첨부파일</td>
											<td colspan="3">
												<c:forEach items="${file}" var="filelist" varStatus="status" >
													<div><a href="${filelist.filePath}${filelist.fileId}">${filelist.fileName}</a></div>
												</c:forEach>
											</td>
										</tr>										
										
									</tbody>
								</table>
							</div>
							<!-- end normal input table---------->
						<!-- end panel -->
						
						<!-- begin button-->
						<div class="col-md-12 tac">
							<input type="button" id="noticeModify" value="수정" class="btn btn-primary width-100" onclick="moveInsertPage()">
		                    <input type="button" id="noticeDelete" value="삭제" class="btn btn-danger width-100" onclick="deleteNoticeBbs()">
		                    <input type="button" id="noticeList" value="목록" class="btn btn-grey width-100" onclick="moveListPage()">
		                     
	<!-- 					<a href="공지사항목록.html"><button type="button" class="btn btn-grey width-100">목록</button> </a> -->
	<!-- 					<a href="공지사항작성.html"><button type="button" class="btn btn-primary width-100">수정</button></a> -->
	<!-- 					<a href="#modal-dialog" class="btn btn-danger width-100" data-toggle="modal">삭제</a>  -->
						</div>
						<!-- end button -->
							
                   </div>
                   <!-- end col-12 -->
	
			</div>
			<!-- end page-body -->
		
		
            <!-- begin #footer -->
            <div id="footer" class="footer">
               <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
            </div>
			<!-- end #footer -->

		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

	function bbsDetail() {
		$.ajax({
			url : "${contextPath}/mng/operation/company/detail",
			dataType : "JSON",
			data : {
				"companyId" : $("#companyId").val()
			},
			success : function(data) {
				var result = data;
				
				$("#companyName").text(result.companyName);
				$("#companyNo").text(result.companyNo);
				$("#companyRep").text(result.companyRep);
				$("#companyAddr").text(result.companyAddr);
				$("#contactName").text(result.contactName);
				$("#contactPhone").text(result.contactPhone);
				$("#contactTel").text(result.contactTel);
				$("#contactMail").text(result.contactMail);
				$("#delFlag").text(result.delFlag);
				$("#regDatetime").text(result.regDatetime);
				$("#regUserId").text(result.regUserId);
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}

	
	function deleteNoticeBbs(){
		confirmBox("삭제하시겠습니까?", deleteNoticeBbsAjax);
	}
	
	function deleteNoticeBbsAjax(){
		$.ajax({
			url : "${contextPath}/mng/operation/company/delete",
			dataType : "JSON",
			type : "POST",
			data : {
				"companyId" : $("#companyId").val()
			},
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("삭제되었습니다.", moveListPage);
				}else{
					alertBox3("실패");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/operation/company/";
	}
	
	// 등록/수정 페이지이동
	function moveInsertPage(){
		var params = "?companyId="+$("#companyId").val();
		location.href = "${contextPath}/mng/operation/company/write"+params
	}
	
	$(document).ready(function() {
		App.init();
		bbsDetail();
		
		//메뉴활성화
		$("#request").addClass("active");
		$("#operationCompany").addClass("active");
	});
	
</script>
</body>

</html>