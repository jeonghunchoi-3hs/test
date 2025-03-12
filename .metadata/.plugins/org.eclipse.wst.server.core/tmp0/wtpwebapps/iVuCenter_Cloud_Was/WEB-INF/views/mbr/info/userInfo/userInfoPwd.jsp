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
</head>
<body>
	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

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
			<h1 class="page-header"><span class="root"> <span class="home"></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow mint"><a href="${wasPath}/mbr/req/changeOrder/changeOrderView"><strong>비밀번호 변경</strong></a></span></span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
			<p class="page_title"><span class="stick">비</span>밀번호 변경</p>

					<!-- begin normal input table---------->		
					<h4>비밀번호를 변경한지 90일이 초과되었습니다. 비밀번호를 변경해주십시오.</h4>
					<div class="orderArea">
					<div class="tableF">
						<table>
						 	<colgroup>
						 		<col width="20%">
						 		<col width="80%">
						 	</colgroup>
							<tbody>
								<tr>
									<td class="left">새 비밀번호</td>
								  	<td>
									  	<span data-toggle="tooltip" data-html="true" title="<div class='tal'>7글자 이상 가능 <br/>3연속 연속된 영문 및 숫자(abc, cba, 123) 불가 <br/>동일한 숫자, 문자를 3번 이상 불가 <br/>영문, 숫자, 특수문자 1개 이상 포함</div>">
										  	<input class="form-control w493"  type="password" id="newuserPassword1" name="newuserPassword1" value=""  />
									  	</span>
								  	</td>
								</tr> 
								 
								<tr>
									<td class="left">새 비밀번호 확인</td>
								  	<td>
								  		<input class="form-control w493" type="password" id="newuserPassword2" name="newuserPassword2" value=""  />
								  	</td>
								</tr>							
							</tbody> 
						</table>
					</div>
				</div>
			    
			    <!-- begin button-->
				<div class="btn_area">		
					<a type="button"  onclick="userInfoUpdate();" class="bbton bton_blue"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-pencil"></i></span><span class="dpin ml16">저장 </span></a>                   
				</div>
				<!-- end button -->
			

	</div>
	<!-- end #content -->
			<!-- begin #footer -->
		<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #footer -->
	
</div> 
<!-- end page container -->

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	$(document).ready(function(){		
		 App.init();
	});
	
	function userInfoUpdate(){
		if($("#newuserPassword1").val()==""){
			alertBox2("새 비밀번호를 입력하세요.", focusField, "#newuserPassword1");			
			return false;
		}
		if($("#newuserPassword2").val()==""){
			alertBox2("새 비밀번호 확인를 입력하세요.", focusField, "#newuserPassword2");
			return false;
		}
		if( ($("#newuserPassword1").val()==$("#newuserPassword2").val()) == false){
			alertBox2("새 비밀번호가 맞지않습니다", focusField, "#newuserPassword2");
			return false;
		}
		
		if( $("#newuserPassword1").val().length < 8){
			alertBox2("비밀번호는 8자리 이상만 <br>가능합니다.", focusField, "#newuserPassword1");
			return false;
		}
		var vmath = (/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/);
		if( !$("#newuserPassword1").val().match(vmath)){
			alertBox2("비밀번호는 문자, 숫자, 특수문자의 <br>조합으로 가능합니다.", focusField, "#newuserPassword1");
			return false;
		}
		
		var SamePass_0 = 0;
		var SamePass_1 = 0;
		var SamePass_2 = 0;
		
		var chr_pass_0;
		var chr_pass_1;

		for(var i=0;i<$("#newuserPassword1").val().length;i++){
			chr_pass_0 = $("#newuserPassword1").val().charAt(i);
			chr_pass_1 = $("#newuserPassword1").val().charAt(i+1);
			
			if(chr_pass_0==" "){
				alertBox2("공백은  사용할 수 없습니다.", focusField, "#newuserPassword1");
				return false;
			}
			
			// 다음 문자와 동일 문자 일 경우 1 증가, 연속이 아닐 경우 초기화 
			SamePass_0 = (chr_pass_0==chr_pass_1) ? SamePass_0 +1 : 0; 
						
			var code0 = chr_pass_0.charCodeAt(0);
			var code1 = chr_pass_1.charCodeAt(0);
			// 앞 뒤의 문자 코드값이 +1 차이날  경우 1 증가, 연속이 아닐 경우 초기화
			SamePass_1 = (code0 - code1 == 1) ? (SamePass_1+1) : 0;
			// 앞 뒤의 문자 코드값이 -1 차이날  경우 1 증가, 연속이 아닐 경우 초기화
			SamePass_2 = (code0 - code1 == -1) ? (SamePass_2+1) : 0;
			
			if(SamePass_0 >1){
				alertBox2("동일한 숫자, 문자를 3번이상 <br>사용할 수 없습니다.", focusField, "#newuserPassword1");
				return false;
			}
			
			if(SamePass_1 >1 || SamePass_2 >1){
				alertBox2("연속된 문자(123 또는 321, abc, cba 등)을 <br>3자 이상 사용할수 없습니다.", focusField, "#newuserPassword1");
				return false;
			}
		}
		
		$.ajax({
			url : "${contextPath}/mbr/cmm/user/userInfoUpdatepw2",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : "${userId}"
				, "userPassword" : $("#newuserPassword1").val()
			},
			success : function(data) {
				alertBox("저장되었습니다.", moveViewPage);
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + request.responseText);
			}
		});
	}
	
	function moveViewPage(){
		location.href = "${contextPath}/mbr/mbrhome/dashboard";
	}
	
	function focusField(id) {
		$(id).focus();
	}
	
</script>
</body>
</html>
