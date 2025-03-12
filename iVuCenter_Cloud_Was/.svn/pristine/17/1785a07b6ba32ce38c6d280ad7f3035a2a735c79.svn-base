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
			<div class="page_header mb30">
				<h1>부가가치세율 상세</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">요금 관리</a><a href="#" class="on">부가가치세율</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				
				<div class="client_DetailBg">
					<div class="client_DetailArea p-b-25">
						<h2 class="customer_Id">${req.customerId}</h2>
						<p class="customer_Name"><span id="upCompanyName"></span><span class="company_Name" id="downCompanyName"></span></p>
						<p class="company_Info">
							<span class="company_labelf">사업자명 :</span><span class="company_cont" id="companyName"></span>
							<span class="company_label">사업자등록번호 :</span><span class="company_cont fontVdn" id="companyNo"></span>
							<span class="company_label">법인등록번호 :</span><span class="company_cont fontVdn" id="corporationNo"></span>
						</p>
						<p class="company_Info m-t-15">
							<span class="company_labelf">등록자 :</span><span class="company_cont" id="regUserName"></span>
							<span class="company_label">등록일시 :</span><span class="company_cont fontVdn" id="regDatetime"></span>
							<span class="company_label">부가가치세율 :</span><span class="company_cont fontVdn txtSkyBlue fontB" id="vatRate"></span>
						</p>
						<table>
							<colgroup>
								 <col width="67px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<td><span class="typebis_label">업태</span></td>
								  	<td class="p-t-7">
										<span class="typebis_cont" id="bizCondition"></span>
								  	</td>
								</tr>  
								<tr>
									<td><span class="typebis_label">업종</span></td>
								  	<td class="p-t-7">
										<span class="typebis_cont" id="bizType"></span>
								  	</td>
								</tr> 
							</tbody>
						</table>
					</div> 
				</div>
				
				<div class="row tac m-t-60">
					<a type="button" class="btnType03 btnType03_save" onClick="moveEditPage()">수정</a>
		 			<a type="button" class="btnType03 btnType03_list m-l-15" onClick ="moveListPage()">목록</a>
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

	function moveListPage(){
 		location.href = "${contextPath}/mng/cmm/customer/vatRateListPage";
 	}
	
	function moveEditPage(){
 		location.href = "${contextPath}/mng/cmm/customer/vatRateEditPage?customerId=${req.customerId}";
 	}
	
	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/cmm/customer/detail",
			dataType : "JSON",
			data : {
				"customerId" : '${req.customerId}'
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){					
					if(val != null){
						if(i=="vatRate"){
							$("#"+i).text(val+" %");
						}else{
							$("#"+i).text(val);	
						}
					}
				});
				$("#modal-dialog").modal("hide");
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	$(document).ready(function() {
		App.init();
		getDetail();
		
		//메뉴활성화
		$("#chargeManagement").addClass("active");
		$("#vatRateMenu").addClass("active");
	});
	
</script>

</body>
</html>