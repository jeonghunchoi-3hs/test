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
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> SMS발송내역<span class="root">관리자포털 > SMS > SMS발송이력 </span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
	         	<!-- begin col-12 -->
	         	<div class="col-md-12">
	                	
	                	<!-- begin panel -->
							<!-- begin normal input table---------->
							<div class="tableB mb20">
							<input type="hidden" id="smsSeq" value="${smsSeq}">
								<table>
									<colgroup>
										<col width="15%">
										<col width="35%">
										<col width="10%">
										<col width="40%">
									</colgroup>
									<tbody>
										<tr>
											<td class="cen height-40 tal">템플릿 ID</td>
										  	<td colspan="3">
												<div class="col-md-6" id="templateId"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen height-40 tal">발신자 이름</td>
										  	<td colspan="3">
												<div class="col-md-6" id="senderName"></div>
										  	</td>
										</tr>										
										<tr>
											<td class="cen height-40 tal">발신자 번호</td>
										  	<td colspan="3">
												<div class="col-md-6" id="senderNumber"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen height-40 tal">수신자 ID 구분</td>
										  	<td colspan="3">
												<div class="col-md-6" id="receiverFlg"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen height-40 tal">수신자 ID</td>
										  	<td colspan="3">
												<div class="col-md-6" id="receiverId"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen height-40 tal">수신자 이름</td>
										  	<td colspan="3">
												<div class="col-md-6" id="receiverName"></div>
										  	</td>
										</tr>
										<tr>
											<td class="cen height-40 tal">수신자 번호</td>
										  	<td colspan="3">
												<div class="col-md-6" id="receiverNumber"></div>
										  	</td>
										</tr>																																									
										<tr>
											<td class="cen height-40 tal">메시지</td>
											<td colspan="3">
												<div class="col-sm-6" id="message" style="white-space: pre-wrap;">
												</div>
											</td>
										</tr>
										<tr>
											<td class="cen height-40 tal">재 전송 횟수</td>
											<td colspan="3">
												<div class="col-sm-6" id="retryCount">
												</div>
										  	</td>
										</tr>
										<tr>
											<td class="cen height-40 tal">발송처리상태</td>
											<td colspan="3">
												<div class="col-sm-6" id="resultFlg">
											  	</div>
											</td>
										</tr>
										<tr>
											<td class="cen height-40 tal">발송처리일시</td>
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
		                    <input type="button" id="noticeList" value="목록" class="btn btn-grey" onclick="moveListPage()">
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
			url : "${contextPath}/mng/smsQueue/history/detail",
			dataType : "JSON",
			data : {
				"smsSeq" : $("#smsSeq").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){
					if(val != null){
						if(i == "smsSeq"){
						}else{
							$("#"+i).html(val);
						}
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/smsQueue/history/";
	}
	
	$(document).ready(function() {
		App.init();
		getDetail();
		
		//메뉴활성화
		$("#sms").addClass("active");
		$("#smsHistory").addClass("active");
	});
	
</script>

</body>
</html>