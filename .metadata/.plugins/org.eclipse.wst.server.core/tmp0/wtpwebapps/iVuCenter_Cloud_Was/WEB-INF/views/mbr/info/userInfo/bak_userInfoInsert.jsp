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
			<h1 class="page-header"><span class="root"> <span class="home"><img src="/resources/assets/img/ico_home.png"  alt="홈"/></span><span class="text">콘솔</span><span class="text arrow"><strong>내정보</strong></span><span class="text arrow mint"><strong>수정</strong></span></span></h1>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row mb50">
			
			<!-- begin section-container -->		  
			<div class="section-container inbox100">

				<!-- begin normal input table---------->		
				
				<div class="tableC">
					<input type="hidden" id="_userId" value="${userId}">
					<input type="hidden" id="_role" value="${role}">
					 <table>
					 	<colgroup>
					 		<col width="200px">
					 		<col width="*">
					 	</colgroup>
						<tbody>
							<tr>
							  	<td class="left tal pl20 th20">사용자 아이디</td>
							  	<td>
								 	
								 		<p class="form-control-static f14 fb lh34 p0" id="userId"></p>
								 	
								</td>
							</tr>
							<tr>
							  	<td class="left tal pl20 th20">고객사</td>
							  	<td><p class="form-control-static width-300 f14 fb lh34 p0" id="customerName"></p></td>
							</tr>
							
							<tr>
								<td class="left tal pl20 th20">사용자 이름</td>
							  	<td><p class="form-control-static width-300 f14 fb lh34 p0" id="userName"></p></td>
							</tr>
							<tr>
								<td class="left tal pl20 th20">기존 비밀번호</td>
							  	<td> <input class="form-control width-300 dpin" type="password" id="userPassword" name="userPassword" value="" />
							  	* 비밀번호 변경시에만 입력하세요.
							  	</td>
							</tr>
							
							<tr>
								<td class="left tal pl20 th20">새 비밀번호</td>
							  	<td>
								  	<span data-toggle="tooltip" data-html="true" title="<div class='tal'>7글자 이상 가능 <br/>3연속 연속된 영문 및 숫자(abc, cba, 123) 불가 <br/>동일한 숫자, 문자를 3번 이상 불가 <br/>영문, 숫자, 특수문자 1개 이상 포함</div>">
									  	<input class="form-control width-300 dpin" type="password" id="newuserPassword1" name="newuserPassword1" value=""  />
								  	</span>
								  	* 비밀번호 변경시에만 입력하세요. 
							  	</td>
							</tr>
							 
							<tr>
								<td class="left tal pl20 th20">새 비밀번호 확인</td>
							  	<td>
							  		<input class="form-control width-300 dpin" type="password" id="newuserPassword2" name="newuserPassword2" value=""  />
							  		* 비밀번호 변경시에만 입력하세요.
							  	</td>
							</tr>
							
							<tr>
							  	<td class="left tal pl20 th20">사용자 핸드폰</td>
							  	<td>
							  			 <!-- <input class="form-control width-300" type="text" id="userPhone" value="" onkeypress="number_only(this);" /> -->
<!-- 							  			<p class="form-control-static f14 fb lh34 p0" id="userPhone"></p> -->

									<select name="mbrPhone1" id="mbrPhone1" class="combobox form-control width-80 dpin pb6">
			                  			<option value="010">010</option>
			                  			<option value="011">011</option>
			                  			<option value="016">016</option>
			                  			<option value="017">017</option>
			                  			<option value="018">018</option>
			                  			<option value="019">019</option>
			                  		</select>
			                  		 - <input type="text" class="form-control width-80 dpin" name="mbrPhone2" id="mbrPhone2" onkeypress="number_only(this);" style="ime-mode:disabled;" maxlength="4"/>
			                  		 - <input type="text" class="form-control width-80 dpin" name="mbrPhone3" id="mbrPhone3" onkeypress="number_only(this);"  style="ime-mode:disabled;" maxlength="4"/>
							  	</td>
							</tr>
							<tr>
							  	<td class="left tal pl20 th20">사용자 전화번호</td>
							  	<td>
							  			<!-- <input class="form-control width-300" type="text" id="userTel" value="" onkeypress="number_only(this);"/> -->
										<select name="mbrTel1" id="mbrTel1" class="combobox form-control width-80 dpin pb6">
			                  			<option value="02">02</option>
			                  			<option value="031">031</option>
			                  			<option value="032">032</option>
			                  			<option value="033">033</option>
			                  			<option value="041">041</option>
			                  			<option value="042">042</option>
			                  			<option value="043">043</option>
			                  			<option value="044">044</option>
			                  			<option value="051">051</option>
			                  			<option value="052">052</option>
			                  			<option value="053">053</option>
			                  			<option value="054">054</option>
			                  			<option value="055">055</option>
			                  			<option value="061">061</option>
			                  			<option value="062">062</option>
			                  			<option value="063">063</option>
			                  			<option value="">------</option>
			                  			<option value="010">010</option>
			                  			<option value="011">011</option>
			                  			<option value="016">016</option>
			                  			<option value="017">017</option>
			                  			<option value="018">018</option>
			                  			<option value="019">019</option>
			                  		</select>
			                  		 - <input type="text" class="form-control width-80 dpin" name="mbrTel2" id="mbrTel2"  onkeypress="number_only(this);" style="ime-mode:disabled;" maxlength="4"/>
			                  		 - <input type="text" class="form-control width-80 dpin" name="mbrTel3" id="mbrTel3" onkeypress="number_only(this);"  style="ime-mode:disabled;" maxlength="4"/>
							  	</td>
							</tr>
							<tr>
								<td class="left tal pl20 th20">사용자 이메일</td>
								<td> <input class="form-control dpin width-200" type="text" id="userMail" readonly/> @  
										<select class="combobox form-control dpin width-150 pb6" id="mailKind">
									  		<c:forEach items="${getEmailCode}" var="getEmailCode" varStatus="status" >
										  	<option value="${getEmailCode.codeName}">${getEmailCode.codeName}</option>		
										  	</c:forEach>
									  	</select>
								</td>
							</tr>
							<tr>
							  	<td class="left tal pl20 th20">SMS 수신여부</td>
							  	<td>
								  		<select class="combobox form-control width-100 pb6" id="smsRecvFlag">
											<option value="Y">수신</option>
											<option value="N">비수신</option>
										</select>
<!-- 								  		<p class="form-control-static f14 fb lh34 p0" id="smsRecvFlag"></p> 			                  	 -->
<!-- 				                  	  	<select class="combobox form-control" name="smsRecvFlag" id="smsRecvFlag" > -->
<%-- 									  		<option value="Y" <c:if test="${vo.smsRecvFlag eq 'Y'}">selected</c:if>>수신</option> --%>
<%-- 									  		<option value="N" <c:if test="${vo.smsRecvFlag eq 'N'}">selected</c:if>>비수신</option> --%>
<!-- 									  	</select> -->		                  
								</td>
							</tr>		
							<tr>
							  	<td class="left tal pl20 th20">NHwith 수신여부</td> 
							  	<td>
							  		<select class="combobox form-control width-100 pb6" id="nhwithRecvFlag">
										<option value="Y">수신</option>
										<option value="N">비수신</option>
									</select>
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
<!-- 				<input type="button" value="저장" class="btn btn-lime" onclick="userInfoUpdate();"> -->
				<button type="button" class="btn btn-lime" onclick="userInfoUpdate();"><i class="fa fa-floppy-o"></i> 저장</button>
<!-- 				<input type="button" value="취소" class="btn btn-gray" onclick="moveViewPage();"> -->
				<button type="button" class="btn btn-grey" onclick="moveViewPage();"><i class="fa fa-times"></i> 취소</button>
			</div>
			<!-- end button -->
			
		</div>
		<!-- end page-body -->
			
			
			
			<!-- #modal-dialog -->
				<div class="modal fade" id="message-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">알림</h4>
	                       </div>
	                       <div class="modal-body">
	                           <h5 id="confirmMsg"></h5>
	                        </div>
	                       	<div class="modal-footer tac" id="setBtn">
<!-- 	                       		<a type='button' class="btn width-100 btn-default" data-dismiss="modal" onclick="">닫기</a> -->
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
			
			
		<!-- begin #footer -->
		<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #footer -->

	</div>
	<!-- end #content -->
	
</div>
<!-- end page container -->

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
	function userInfoDetail(){
		
		$.ajax({
			url : "userInfoDetail",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : $("#_userId").val()
			},
			success : function(data) {
				setData(data);
				
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
		
	}
	
	function setData(data){
		$("#userId").text(data.userId);
		$("#customerName").text(data.customerName);
		$("#userName").text(data.userName);
		//$("#userPassword").val(data.userPassword);
		$("#userPhone").val(data.userPhone);
		$("#mbrPhone1").val(data.mbrPhone1);
		$("#mbrPhone2").val(data.mbrPhone2);
		$("#mbrPhone3").val(data.mbrPhone3);
		$("#userTel").val(data.userTel);
		$("#mbrTel1").val(data.mbrTel1);
		$("#mbrTel2").val(data.mbrTel2);
		$("#mbrTel3").val(data.mbrTel3);
// 		$("#userMail").val(data.userMail);
		
		$("#smsRecvFlag").val(data.smsRecvFlag);
		
		var addrArr = data.userMail.split("@");
		var preAddr = addrArr[0]; 	
		var postAddr = addrArr[1];
		$("#userMail").val(preAddr);
		$("#mailKind").val(postAddr);
		
	}
	
	function userInfoUpdate(){
		if($("#mbrPhone1").val()==""){
			alertBox3("사용자 핸드폰를 입력하세요");
			return false;
		}
		if($("#mbrPhone2").val()==""){
			alertBox3("사용자 핸드폰를 입력하세요");
			return false;
		}
		if($("#mbrPhone3").val()==""){
			alertBox3("사용자 핸드폰를 입력하세요");
			return false;
		}
		if($("#mbrTel1").val()!=""){
			if($("#mbrTel2").val()==""){
				alertBox3("사용자 전화번호를 입력하세요");
				return false;
			}
			if($("#mbrTel3").val()==""){
				alertBox3("사용자 전화번호를 입력하세요");
				return false;
			}
		}
		if($("#mbrTel2").val()!=""){
			if($("#mbrTel1").val()==""){
				alertBox3("사용자 전화번호를 입력하세요");
				return false;
			}
			if($("#mbrTel3").val()==""){
				alertBox3("사용자 전화번호를 입력하세요");
				return false;
			}
		}
		if($("#mbrTel3").val()!=""){
			if($("#mbrTel1").val()==""){
				alertBox3("사용자 전화번호를 입력하세요");
				return false;
			}
			if($("#mbrTel2").val()==""){
				alertBox3("사용자 전화번호를 입력하세요");
				return false;
			}
		}
		if($("#userPassword").val()!=""){
			if( $("#newuserPassword1").val().length < 7){
				alertBox3("비밀번호는 7자리 이상만 가능합니다.");
				return false;
			}
			var vmath = (/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/);
			if( !$("#newuserPassword1").val().match(vmath)){
				alertBox3("비밀번호는 문자, 숫자, 특수문자의 <br>조합으로 가능합니다.");
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
					alertBox3("공백은  사용할 수 없습니다.");
					return false;
				}
				
				if(chr_pass_0==chr_pass_1){
					SamePass_0 = SamePass_0 +1;
				}
				
				if(chr_pass_0.charCodeAt(0)-chr_pass_1.charCodeAt(0)==1){
					SamePass_1 = SamePass_1 +1;
				}
				
				if(chr_pass_0.charCodeAt(0)-chr_pass_1.charCodeAt(0)==-1){
					SamePass_2 = SamePass_2 +1;
				}				
				
				if(SamePass_0 >1){
					alertBox3("동일한 숫자, 문자를 3번이상 <br>사용할 수 없습니다.");
					return false;
				}
				
				if(SamePass_1 >1 || SamePass_2 >1){
					alertBox3("연속된 문자(123 또는 321, abc, cba 등)을 <br>3자 이상 사용할수 없습니다.");
					return false;
				}
			}
			
			$.ajax({
				url : "userInfoDetailpw",
				dataType : "JSON",
				type : "POST",
				data : {
					"userId" : $("#_userId").val()
					,"userPassword" : $("#userPassword").val()
				},
				success : function(data) {		
					//alert(data);					
					if(data==0){
						//alert("기존 비밀번호가 맞습니다.");
						if($("#newuserPassword1").val()==""){
							alertBox3("새 비밀번호를 입력하세요.")
						}else if($("#newuserPassword2").val()==""){
							alertBox3("새 비밀번호 확인를 입력하세요.")
						}else{
							if($("#newuserPassword1").val()==$("#newuserPassword2").val()){
								//alert("새 비밀번호가 맞습니다");
								var jsonData = setJsonDatapw();
								
								$.ajax({
									url : "userInfoUpdatepw",
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
								errorBox("새 비밀번호가 맞지않습니다");
							}
						}					
						
					}else{
						errorBox("기존 비밀번호가 맞지않습니다.");
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
				url : "userInfoUpdate",
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
		
		var preAddr = $("#userMail").val();	
		var postAddr = $("#mailKind").val();
		var mailAddrArr = preAddr + "@" + postAddr;
		
		var mbrPhone = $("#mbrPhone1").val() + "-" +$("#mbrPhone2").val()+ "-" +$("#mbrPhone3").val();
		
		var mbrTel = $("#mbrTel1").val() + "-" +$("#mbrTel2").val()+ "-" +$("#mbrTel3").val()
		
		var jsonData = {
				"userId" : $("#_userId").val()
				,"userPhone" : mbrPhone
				,"userTel" : mbrTel
				,"userMail" : mailAddrArr
				,"smsRecvFlag" : $("#smsRecvFlag > option:selected").val()
		}
		
		return jsonData;
	}
	
	function setJsonDatapw(){
		
		var preAddr = $("#userMail").val();	
		var postAddr = $("#mailKind").val();
		var mailAddrArr = preAddr + "@" + postAddr;	
		
		var mbrPhone = $("#mbrPhone1").val() + "-" +$("#mbrPhone2").val()+ "-" +$("#mbrPhone3").val();
		
		var mbrTel = $("#mbrTel1").val() + "-" +$("#mbrTel2").val()+ "-" +$("#mbrTel3").val()
// 		alert($("#newuserPassword1").val());
		var jsonData = {
				"userId" : $("#_userId").val()
				,"userPassword" : $("#newuserPassword1").val()				
				,"userPhone" : mbrPhone
				,"userTel" : mbrTel
				,"userMail" : mailAddrArr
				,"smsRecvFlag" : $("#smsRecvFlag > option:selected").val()
		}
		
		return jsonData;
	}
	
	function moveViewPage(){
		var userId = $("#_userId").val();
		location.href = "${contextPath}/mbr/cmm/user/userInfo";
		
	}

	// 팝업메시지 세팅	
	function alertModal(txt, fn){
		$("#confirmMsg").text(txt);
		$("#setBtn").html("");
		
		if(fn==""||fn=="undefined"){
			var vHtml = "";
			vHtml = '<a type="button" class="btn width-100 btn-grey" data-dismiss="modal">닫기</a>';
			$("#setBtn").html(vHtml);
		}else{
			var vHtml = "";
			vHtml = '<a type="button" class="btn width-100 btn-grey" data-dismiss="modal" onclick="'+fn+'">닫기</a>';
			$("#setBtn").html(vHtml);
		}
		
		$("#message-modal-dialog").modal();
	}
	//숫자만 입력
	function number_only(id){
		//alert(id);
		$(id).val( $(id).val().replace(/[^0-9-]/gi,''));
		if( !( event.keyCode>=48 && event.keyCode<=57 )){
			event.returnValue=false;
	    }
		if(event.keyCode==45 ){
			event.returnValue=true;
		}
	
	}
	
// 	function alertModal2(txt, fn){
		
// 		if(txt == ""){
// 			txt = "알림";
// 		}
		
// 		var vHtml = "";
		
// 			<div class="modal fade" id="message-modal-dialog">
// 	        <div class="modal-dialog">
// 	            <div class="modal-content">
// 	                <div class="modal-header">
// 	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
// 	                    <h4 class="modal-title fw" id="title">알림</h4>
// 	                </div>
// 	                <div class="modal-body">
// 	                    <h5 id="confirmMsg"></h5>
// 	                 </div>
// 	                	<div class="modal-footer tac" id="setBtn">
// 							<a type='button' class="btn width-100 btn-default" data-dismiss="modal" onclick="">닫기</a>
// 	                	</div>
// 	            	</div>
// 	        	</div>
// 	    	</div>
// 	}
	
	
	
	
	

	$(document).ready(function(){		
		
		 App.init();
		 userInfoDetail();
	});

</script>
</body>
</html>
