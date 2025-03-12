<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		
			<!-- begin page-header -->
			<h1 class="page-header"> <img src="<%=request.getContextPath()%>/resources/images/title_icon/userInfo.png"/>  회원사정보 수정<span class="root"><img src="/resources/assets/img/root_icon.png"/> 콘솔 > 내정보 </span></h1>
			<!-- end page-header -->

			<!-- begin page-body -->
			<div class="row mb50">
			
			<!-- begin section-container -->		  
			<div class="section-container inbox">

				<!-- begin normal input table---------->		
				
				<div class="tableB">
					<input type="hidden" id="_customerId" value="${customerId}">
					<input type="hidden" id="_role" value="${role}">
					 <table>
					 	<colgroup>
					 		<col width="30%">
					 		<col width="70%">
					 	</colgroup>
						<tbody>
							<tr>
							  	<td class="left th20">고객사 아이디</td>
							  	<td>
								 	<div class="col-sm-12">
								 		<p class="form-control-static f14 fb lh34 p0" id="customerId"></p>
								 	</div>
								</td>
							</tr>
							<tr>
							  	<td class="left">고객사 이름</td>
							  	<td>
							  		<div class="col-sm-12">
							  			<p class="form-control-static f14 fb lh34 p0" id="customerName"></p></div>
							  	</td>
							</tr>
							<tr>
							  	<td class="left">사업자 이름</td>
							  	<td>
							  		<div class="col-sm-12">
							  			<p class="form-control-static f14 fb lh34 p0" id="companyName"></p></div>
							  	</td>
							</tr>
							
							<tr>
								<td class="left">기존 비밀번호</td>
							  	<td>
							  		<div class="col-sm-6">
							  			 <input class="form-control" type="password" id="customerPassword" name="customerPassword" value="" />
							  			 * 비밀번호 변경시에만 입력하세요.
							  		</div>
							  	</td>
							</tr>
							
							<tr>
								<td class="left">새 비밀번호</td>
							  	<td>
							  		<div class="col-sm-6">
							  			 <input class="form-control" type="password" id="newcustomerPassword1" name="newcustomerPassword1" value="" />
							  			 * 비밀번호 변경시에만 입력하세요.
							  		</div>
							  	</td>
							</tr>
							
							<tr>
								<td class="left">새 비밀번호 확인</td>
							  	<td>
							  		<div class="col-sm-6">
							  			 <input class="form-control" type="password" id="newcustomerPassword2" name="newcustomerPassword2" value="" />
							  			 * 비밀번호 변경시에만 입력하세요.
							  		</div>
							  	</td>
							</tr>
							
							<tr>
								<td class="left">담당자 이름</td>
							  	<td>
							  		<div class="col-sm-6">
							  			<input type="text" class="form-control" id="contactName" >
							  		</div>
							  	</td>
							</tr>
							<tr>
								<td class="left">담당자 전화번호</td>
							  	<td>
							  		<div class="col-sm-6">
							  			<input type="text" class="form-control" id="contactTel">
							  		</div>
							  	</td>
							</tr>
							<tr>
							  	<td class="left">담당자 이메일</td>
								<td>
									<div class="col-sm-3"> <input class="form-control" type="text" id="contactMail"/></div>
									<div class="col-sm-1 com"> @ </div>
									<div class="col-sm-4"> 
										<select class="combobox form-control" id="mailKind">
									  		<option value="3hs.co.kr" selected="selected">3hs.co.kr</option>
									  		<option value="naver.com">naver.com</option>
									  		<option value="abcd.com">abcd.com</option>
									  	</select>
									</div>
								</td>
							</tr>
							<tr>
							  	<td class="left">SMS 수신여부</td>
							  	<td>
								  	<div class="col-sm-3">
								  		<select class="combobox form-control" id="smsRecvFlag">
											<option value="Y">수신</option>
											<option value="N">비수신</option>
										</select>
<!-- 								  		<p class="form-control-static f14 fb lh34 p0" id="smsRecvFlag"></p> 			                  	 -->
<!-- 				                  	  	<select class="combobox form-control" name="smsRecvFlag" id="smsRecvFlag" > -->
<%-- 									  		<option value="Y" <c:if test="${vo.smsRecvFlag eq 'Y'}">selected</c:if>>수신</option> --%>
<%-- 									  		<option value="N" <c:if test="${vo.smsRecvFlag eq 'N'}">selected</c:if>>비수신</option> --%>
<!-- 									  	</select> -->
								  	</div>			                  
								</td>
							</tr>							
						</tbody>
					</table>
				</div>
				<!-- end normal input table---------->
				
			</div>
		    <!-- end section-container -->	   
		    
		    <!-- begin button-->
			<div class="row tac mt20">
				<input type="button" value="저장" class="btn btn-lime width-80" onclick="customerInfoUpdate();">
				<input type="button" value="취소" class="btn btn-gray width-80" onclick="moveViewPage();">
			</div>
			<!-- end button -->
			
		</div>
		<!-- end page-body -->
			
		<!-- begin #footer -->
		<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #footer -->

	</div>
	<!-- end #content -->
	
</div>
<!-- end page container -->

</body>

<script type="text/javascript">
	function customerInfoDetail(){
		
		$.ajax({
			url : "customerInfoDetail",
			dataType : "JSON",
			type : "POST",
			data : {
				"customerId" : $("#_customerId").val()
			},
			success : function(data) {
				setData(data);
				
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});
		
	}
	
	function setData(data){
		$("#customerId").text(data.customerId);
		$("#customerName").text(data.customerName);
		$("#companyName").text(data.companyName);
		$("#contactName").val(data.contactName);
		$("#contactTel").val(data.contactTel);
// 		$("#contactMail").val(data.contactMail);
		$("#smsRecvFlag").val(data.smsRecvFlag);
		
		var addrArr = data.contactMail.split("@");
		var preAddr = addrArr[0]; 	
		var postAddr = addrArr[1];
		$("#contactMail").val(preAddr);
		$("#mailKind").val(postAddr);
		
	}

	
	function customerInfoUpdate(){
		
		if($("#customerPassword").val()!=""){
			$.ajax({
				url : "customerInfoDetailpw",
				dataType : "JSON",
				type : "POST",
				data : {
					"customerId" : $("#_customerId").val()
					,"customerPassword" : $("#customerPassword").val()
				},
				success : function(data) {		
					//alert(data);					
					if(data==0){
						//alert("기존 비밀번호가 맞습니다.");
						if($("#newcustomerPassword1").val()==""){
							warningBox("새 비밀번호를 입력하세요.")
						}else if($("#newcustomerPassword2").val()==""){
							warningBox("새 비밀번호 확인를 입력하세요.")
						}else{
							if($("#newcustomerPassword1").val()==$("#newcustomerPassword2").val()){
								//alert("새 비밀번호가 맞습니다");
								var jsonData = setJsonDatapw();
								
								$.ajax({
									url : "customerInfoUpdatepw",
									dataType : "JSON",
									type : "POST",
									data : jsonData,
									success : function(data) {
										alertBox("저장되었습니다.", moveViewPage);
									},
									error : function(request, status, error) {
										errorBox("code:" + request.status + "\n" + "error:" + error);
									}
								});
								
							}else{
								warningBox("새 비밀번호가 맞지않습니다");
							}
						}					
						
					}else{
						warningBox("기존 비밀번호가 맞지않습니다.");
						return false;
					}
				},
				error : function(request, status, error) {
					errorBox("code:" + request.status + "\n" + "error:" + error);
				}
			}); 
		}else{
			
			var jsonData = setJsonData();
			
			$.ajax({
				url : "customerInfoUpdate",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					alertBox("저장되었습니다.", moveViewPage);
				},
				error : function(request, status, error) {
					errorBox("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		
		
		
	}
	
	function setJsonData(){
		
		var preAddr = $("#contactMail").val();	
		var postAddr = $("#mailKind").val();
		var mailAddrArr = preAddr + "@" + postAddr;
		var jsonData = {
				"customerId" : $("#_customerId").val()
				,"contactName" : $("#contactName").val()
				,"contactTel" : $("#contactTel").val()
				,"contactMail" : mailAddrArr
				,"smsRecvFlag" : $("#smsRecvFlag > option:selected").val()
		}
		
		return jsonData;
	}
	
	function setJsonDatapw(){
		
		var preAddr = $("#contactMail").val();	
		var postAddr = $("#mailKind").val();
		var mailAddrArr = preAddr + "@" + postAddr;
		var jsonData = {
				"customerId" : $("#_customerId").val()
				,"customerPassword" : $("#newcustomerPassword1").val()
				,"contactName" : $("#contactName").val()
				,"contactTel" : $("#contactTel").val()
				,"contactMail" : mailAddrArr
				,"smsRecvFlag" : $("#smsRecvFlag > option:selected").val()
		}
		
		return jsonData;
	}
	
	function moveViewPage(){
		var customerId = $("#_customerId").val();
		location.href = "${contextPath}/mbr/cmm/user/userInfo";
		
	}


	$(document).ready(function(){		
		 App.init();
		 
// 		 location.href="${contextPath}/mbr/cmm/customer/customerInfoDetail";
		 customerInfoDetail();
		
	});

</script>

</html>
