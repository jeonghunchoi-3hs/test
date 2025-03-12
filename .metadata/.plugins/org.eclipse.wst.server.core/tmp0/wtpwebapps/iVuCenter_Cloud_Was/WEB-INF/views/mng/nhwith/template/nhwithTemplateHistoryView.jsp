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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
		
			<!-- begin header -->
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> NHwith 템플릿 이력 상세 <span class="root">관리자포털 > NHwith > NHwith 발송이력 </span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
	         	<!-- begin col-12 -->
	         	<div class="col-md-12">
	                	
	                	<!-- begin panel -->
							<!-- begin normal input table---------->
							<div class="tableB mb20">
							<input type="hidden" id="nhwithSeq" value="${nhwithSeq}">
								<table>
									<colgroup>
										<col width="10%">
										<col width="40%">
										<col width="10%">
										<col width="40%">
									</colgroup>
									<tbody>
										<tr>
											<td class="cen th20 tal">템플릿 ID</td>
										  	<td colspan="3">
												<div class="col-md-6" id="templateId"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen th20 tal">제목</td>
										  	<td colspan="3">
												<div class="col-md-6" id="title"></div>
										  	</td>
										</tr>						
										<tr>
											<td class="cen th20 tal">내용</td>
											<td colspan="3">
												<div class="col-sm-6" id="_content" style="white-space: pre-wrap;">
												</div>
											</td>
										</tr>														
										<tr>
											<td class="cen th20 tal">수신자 이름</td>
										  	<td colspan="3">
												<div class="col-md-6" id="senderName"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen th20 tal">수신자 ID</td>
										  	<td colspan="3">
												<div class="col-md-6" id="senderId"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen th20 tal">발신자 ID</td>
										  	<td colspan="3">
												<div class="col-md-6" id="receiverId"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen th20 tal">발신자 이름</td>
										  	<td colspan="3">
												<div class="col-md-6" id="receiverName"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen th20 tal">발송처리상태</td>
										  	<td colspan="3">
												<div class="col-md-6" id="resultFlg"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen th20 tal tac">수신자 구분</td>
											<td colspan="3">
												<div class="col-sm-6" id="receiverFlg">
											  	</div>
											</td>
										</tr>
										<tr>
											<td class="cen th20 tal">발송처리일시</td>
										  	<td colspan="3">
												<div class="col-sm-6" id="resultDatetime">
											  	</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- end normal input table---------->
						<!-- end panel -->
						
						<!-- begin button-->
						<div class="col-md-12 tac">	
							<button class="btn btn-grey"  id="noticeList"  onclick="moveListPage()"><i></i> 목록</button>						
		                    
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

	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/nhwith/template/nhwithTemplateHistoryDetail",
			dataType : "JSON",
			data : {
				"nhwithSeq" : $("#nhwithSeq").val()
			},
			success : function(data) {
				var result = data;
				var receiverFlg = "";
				var resultFlg = "";
				if(result.receiverFlg=="U"){
					receiverFlg = "사용자";
				}else if(result.receiverFlg=="C"){
					receiverFlg = "회원사";
				}else{
					receiverFlg = "사용자";
				}
				if(result.resultFlg=="Y"){
					resultFlg = "성공";
				}else{
					resultFlg = "실패";
				}
				$("#templateId").text(result.templateId);
				$("#title").text(result.title);
				$("#_content").text(result.content);
				$("#senderName").text(result.senderName);
				$("#senderId").text(result.senderId);
				$("#receiverId").text(result.receiverId);
				$("#receiverName").text(result.receiverName);
				$("#resultFlg").text(resultFlg);
				$("#receiverFlg").text(receiverFlg);
				$("#resultDatetime").text(result.resultDatetime.substring(0,19));
				
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/nhwith/template/nhwithTemplateHistoryList.do";
	}
	
	// 등록/수정 페이지이동
	function moveInsertPage(){
		var params = "?templateId="+$("#templateId").val();

		location.href = "${contextPath}/mng/nhwith/template/templateWrite"+params
	}
	
	$(document).ready(function() {
		getDetail();
		App.init();
		
		//메뉴활성화
		$("#nhwith").addClass("active");
		$("#nhwithHistory").addClass("active");
	});
	
</script>
</body>

</html>