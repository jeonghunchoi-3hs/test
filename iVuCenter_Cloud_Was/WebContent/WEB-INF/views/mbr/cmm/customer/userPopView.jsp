<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<style>
	</style>
	<script src="${contextPath}/assets/plugins/jquery/jquery-1.9.1.min.js"></script>
	<script src="${contextPath}/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
	<script src="${contextPath}/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
	<script type="text/javascript">
	
	function userlist(){
		opener.userList();
		self.close();
	}	
	
	function valchk(){		
		if($("input:checkbox[name='adchk']").is(":checked")){
			//alert("회계담당");
			$("#authority2").val("1");	
		}else{
			$("#authority2").val("0");
		}	
		if($("input:checkbox[name='pmchk']").is(":checked")){
			//alert("프로젝트 관리자");
			$("#authority1").val("1");	
		}else{
			$("#authority1").val("0");
		}	
		$("#userEdit").submit();
	}
	</script>
</head>
<body>

<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
		
		
			<!-- begin page-body -->
			<div class="row mb50">
			<form name="userEdit"  id="userEdit" action="userPopViewEdit" method="post" >
	         	<!-- begin col-12 -->
	         	<div class="section-container inbox100">
	                	* 사용자 정보
						<!-- begin normal input table---------->
						
						<div class="tableC">
							<input type="hidden" id="customerId" name="customerId" value="${userView.customerId}">
							<input type="hidden" id="userId" name="userId"  value="${userView.userId}">
							<input type="hidden" id="userAuthority" name="userAuthority"  value="${userView.userAuthority}">
							<input type="hidden" id="authority1" name="authority1"  value="${userView.authority1}">
							<input type="hidden" id="authority2" name="authority2"  value="${userView.authority2}">
								<table id="table_1" class="table" border="1">
									<colgroup>
										 <col width="20%">
										 <col width="80%">
									</colgroup>
									<tbody>
										<tr>
											<td class="left-b th20">사용자아이디</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="userId">${userView.userId}</div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b th20">고객사 이름</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="customerName">${userView.customerName}</div>
										  	</td>
										</tr>										
										<tr>
											<td class="left-b th20">사용자명</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="companyName">${userView.userName}</div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b th20">사용자 핸드폰</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="companyNo">${userView.userPhone}</div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b th20">사용자 전화번호</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="corporationNo">${userView.userTel}</div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b th20">사용자 이메일</td>
										  	<td class="f14 fb">
												<div class="col-md-6" id="companyRep">${userView.userMail}</div>
										  	</td>
										</tr>																																																				
									</tbody>
								</table>
							</div>
							
							* 권한 정보
							<div class="tableC">							
								<table id="table_2" class="table" border="1">
									<colgroup>
										 <col width="20%">
										 <col width="80%">
									</colgroup>
									<tbody>								
										<tr>
										  <td class="left-b"> </td>
										  <td>
										  <div class="col-md-6" id="userName">권한</div>
										  
										  </td>
										</tr>
										<tr>
										  <td class="left-b"> <input type="checkbox" name="adchk" id="adchk" <c:if test='${userView.authority2 eq "1"}'> checked </c:if>>  </td>
										  <td>
										  <div class="col-md-6" id="userName">회계담당</div>
											${userView.authority2} 
										  </td>
										</tr>
										<tr>
										  <td class="left-b"> <input type="checkbox" name="pmchk" id="pmchk" <c:if test='${userView.authority1 	}'> checked </c:if>> </td>
										  <td>
										  <div class="col-md-6" id="userPhone">프로젝트 관리자</div>
										  	${userView.authority1} 
										  </td>
										</tr>																																																
									</tbody>
								</table>
							</div>
							<!-- end normal input table---------->
						<!-- end panel -->
						
							
                   </div>
                   <!-- end col-12 -->
                   
                   <!-- begin button-->
							<div class="col-md-12 tac">	
								<input type="button"  class="btn btn-primary width-100" onclick="valchk();" value="저장" />																		
								<input type="button" class="btn btn-grey width-100" onclick="userlist();" value="목록" />
							</div>
							<!-- end button -->
      </form>
			</div>
			<!-- end page-body -->
			
</div>
</body>
</html>