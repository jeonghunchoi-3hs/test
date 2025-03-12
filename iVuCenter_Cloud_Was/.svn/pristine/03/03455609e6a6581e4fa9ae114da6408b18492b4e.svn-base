<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
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
				<h1>부가가치세율 수정</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">요금 관리</a><a href="#" class="on">부가가치세율</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<div class="formType01">
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="212px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>고객사 아이디</strong></th>
									<td class="fontVdn">${req.customerId}</td>
								</tr>
								<tr>
									<th scope="row"><strong>구분</strong></th>
									<td id="upCompanyName"></td>
								</tr>
								<tr>
									<th scope="row"><strong>고객사</strong></th>
									<td id="downCompanyName"></td>
								</tr>
								<tr>
									<th scope="row"><strong>사업자 등록번호</strong></th>
									<td class="fontVdn" id="companyNo"></td>
								</tr>
								<tr>
									<th scope="row"><strong>법인 등록번호</strong></th>
									<td class="fontVdn" id="corporationNo"></td>
								</tr>
								<tr>
									<th scope="row"><strong>대표자명</strong></th>
									<td id="companyRep"></td>
								</tr>
								<tr>
									<th scope="row"><strong>업태</strong></th>
									<td id="bizCondition"></td>
								</tr>
								<tr>
									<th scope="row"><strong>업종</strong></th>
									<td id="bizType"></td>
								</tr>
								<tr>
									<th scope="row"><strong>부가가치세율(%)</strong></th>
									<td>
										<div class="selectBox" style="width:380px;">
											<label class="selectText">선택</label>
											<select class="search-sel" name="vatRate" id="vatRate">
								  				<option value="">선택</option>
											<c:forEach items="${vatRateList}" var="vatRateList" varStatus="status" >
												<option value="${vatRateList.codeId}">${vatRateList.codeName}%</option>
											</c:forEach>
											</select>	
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>등록자</strong></th>
									<td id='regUserName'></td>
								</tr>
								<tr>
									<th scope="row"><strong>등록일시</strong></th>
									<td class="fontVdn" id='regDatetime'></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="row tac m-t-60">
					<a type="button"class="btnType03 btnType03_save" onClick="actUpdate()">저장</a>
		 			<a type="button"class="btnType03 btnType03_cancel m-l-15" onClick ="moveListPage()">취소</a>
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
							$("#"+i).val(val);
							$("#"+i).siblings(".selectText").text($("#"+i+" > option:selected").text());
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

	function actUpdate() {
		if($("#vatRate > option:selected").val()==""){
			alertBox3("부가가치세율을 선택하세요");
			$("#vatRate").focus();
			return false;
		}		
		$.ajax({
			url : "${contextPath}/mng/cmm/customer/vatRateEdit",
			dataType : "JSON",
			type : "POST",
			data : {
					"customerId" : '${req.customerId}'
					, "vatRate" : $("#vatRate > option:selected").val()
					, "modUserId":	'${userId}'
				},
			success : function(data) {
				var result = data;
		 		if(result==1){
		 			alertBox("저장되었습니다.", moveListPage);
				}else{
					alertBox3("fail!!");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
			
	function moveListPage(){
		location.href = "${contextPath}/mng/cmm/customer/vatRateListPage";
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