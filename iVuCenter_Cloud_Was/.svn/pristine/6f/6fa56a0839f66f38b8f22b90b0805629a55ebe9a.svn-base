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
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 네트워크 관리 상세 <span class="root">관리자포털 > 운영관리 > 네트워크 관리</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row mb50">
			
	         	<!-- begin col-12 -->
	         	<div class="section-container inbox100">
	                	<h5 class="mt20">* 고객사 정보</h5>
						<!-- begin normal input table---------->
						<div class="tableC">
							<input type="hidden" id="hid_networkId" value="${networkId}">
								<table>
									<colgroup>
										 <col width="20%">
										 <col width="80%">
									</colgroup>
									<tbody>
										<tr>
											<td class="left-b height-40 pl22">본사</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="customerHeardName"></div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b height-40 pl22">A Class</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="aClass"></div>
										  	</td>
										</tr>										
										<tr>
											<td class="left-b height-40 pl22">계열사명</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="affiliateName"></div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b height-40 pl22">B Class</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="bClass"></div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b height-40 pl22">업무</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="workKindName"></div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b height-40 pl22">업무네트워크</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="workNetKindName"></div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b height-40 pl22">C Class</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="cClass"></div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b height-40 pl22">CIDR</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="cidr"></div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b height-40 pl22">사용여부</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="useFlag"></div>
										  	</td>
										</tr>
									</tbody>
								</table>
							</div>
						<!-- end panel -->
                   </div>
                   <!-- end col-12 -->
                   
                   	<!-- begin button-->
					<div class="col-md-12 tac mt20">
						<input type="button" class="btn btn-primary" onclick="moveWrite();" value="수정" />		
						<button type="button" class="btn btn-danger" onclick="confirmDelete()">삭제</button>																
						<input type="button" class="btn btn-grey" onclick="moveList();" value="목록" />
					</div>
					<!-- end button -->
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
	
	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/cmm/network/detail",
			dataType : "JSON",
			data : {
				"networkId" : "${networkId}"
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){					
					if(val != null){
						$("#"+i).text(val);	
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}

	function confirmDelete(){
		confirmBox("삭제하시겠습니까?", actDelete)
	}
	
	function actDelete(){
		$.ajax({
			url : "${contextPath}/mng/cmm/network/delete",
			dataType : "JSON",
			data : {
				"networkId" : "${networkId}"
			},
			success : function(data) {
				if(data == "1"){
					alertBox("삭제되었습니다.", moveList)
				}else{
					alertBox3("삭제 실패")
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});		
	}
	
	function moveList(){
 		location.href = "${contextPath}/mng/cmm/network/";
 	}
	
	function moveWrite(){
 		location.href = "${contextPath}/mng/cmm/network/write?networkId=${networkId}";
 	}
	
	$(document).ready(function() {
		App.init();
		getDetail();	
		
		//메뉴활성화
		$("#operation").addClass("active");
		$("#cmmNetwork").addClass("active");
	});
	
</script>

</body>
</html>