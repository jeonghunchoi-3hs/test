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
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="expires" content="0" />
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>
	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container">
		
		<!-- begin register -->
		<div class="register width-800 left25">
		    <!-- begin register-brand -->
            <div class="register-brand bg-inverse fw">
                <img src="${contextPath}/resources/assets/img/nh.png" height="36" class="pull-right logo" alt="로고" /> 고객사 회원가입
            </div>
            <!-- end register-brand -->
            <!-- begin register-content -->
            <div class="register-content">
               <!-- begin normal input table---------->
			
			<div class="tableB">
				<form name="customerform"  id="customerform" action="customerInsert.do" method="post" >
				<input type="hidden" name="type" id="type" value="write" />
				<input type="hidden" name="namechk" id="namechk" value="F" />
				<input type="hidden" name="idchk" id="idchk" value="F" />
				 <table>
				 	<colgroup>
				 		<col width="30%">
				 		<col width="70%">
				 	</colgroup>
					<tbody>
						<tr>
						  <td class="left th20">고객사 아이디</td>
						  	<td>
							 	<div class="col-sm-6 pl0">
							 		<input type="text" name="customerId" id="customerId" class="form-control" style="ime-mode:disabled;"/> <p id="customerIdchktxt" name="customerIdchktxt" class="form-control-static f14 fb lh34 p0" style="ime-mode:disabled; text-transform:lowercase;"></p>
			                 	</div>
						 	</td>
						 </tr>
						 <tr>
						  	<td class="left">고객사 이름</td>
						  	<td>
						      	<div class="col-sm-6 pl0">
						      		<input type="text" name="customerName" id="customerName" class="form-control" /> <p id="customerNamechktxt" name="customerNamechktxt" class="form-control-static f14 fb lh34 p0"></p> <!-- <a href="customerNamecheck.do" target="_blank">중복확인</a> -->			                  		
			                  	</div>
						  	</td>
						</tr>
						<tr>
						  <td class="left">사업자</td>
						  <td>
						  		<div class="col-sm-6 pl0">
						  			<select name="companyId" id="companyId" onchange="companyidselect();" class="form-control">
										<option value="">=== 사업자 선택 ===</option>
									<c:forEach items="${vo}" var="companyNames" varStatus="status" >							
										<option value="${companyNames.companyId}">${companyNames.companyName}</option>
									</c:forEach>
									</select>			                    	
			                  	</div>
						  </td>
						</tr>
						<tr name="companyview" id="companyview" style="display:none">
							<td class="left">
								대표자 이름
							</td>
							<td name="companyview2" id="companyview2">
								<div class="col-sm-3 pl0">
								</div>
							</td>
						</tr>
						<tr>
						  <td class="left">담당자 이름</td>
						  <td>
						  		<div class="col-sm-6 pl0">
						  			<input type="text" name="contactName" id="contactName" class="form-control" />			                  		
			                  	</div>
						  </td>
						</tr>
						<tr>
						  <td class="left">담당자 핸드폰</td>
						  <td>
								<input type="text" class="form-control width-80 dpin" name="contactPhone1" id="contactPhone1"  onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" /> - <input type="text" class="form-control width-80 dpin" name="contactPhone2" id="contactPhone2" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" /> - <input type="text" class="form-control width-80 dpin" name="contactPhone3" id="contactPhone3"  onkeypress="number_only(this);"  style="ime-mode:disabled;" />
			              </td>
						</tr>
						<tr>
						  <td class="left">담당자 전화번호</td>
						  <td>
						  		<div class="col-sm-12 pl0">
			                  		<input type="text" class="form-control width-80 dpin" name="contactTel1" id="contactTel1"   onkeypress="number_only(this);"  style="ime-mode:disabled;"/> - <input type="text" class="form-control width-80 dpin" name="contactTel2" id="contactTel2"  onkeypress="number_only(this);"  style="ime-mode:disabled;" /> - <input type="text" class="form-control width-80 dpin" name="contactTel3" id="contactTel3"  onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" />
			                  	</div>
						  </td>
						</tr>
						<tr>
							<td class="left">담당자 이메일</td>
							<td>
							  	<input type="text" class="form-control width-150 dpin" name="contactMail" id="contactMail" class="form-control" style="ime-mode:disabled; text-transform:lowercase;"/> @ 
							  	<select class="combobox form-control width-150 dpin">
									<option value="3hs.co.kr">3hs.co.kr</option>							  
								</select>
						  	</td>
						</tr>
						<tr>
						  <td class="left">SMS 수신여부</td>
						  <td>
							  <div class="col-sm-3 pl0"> 			                  	
			                  	  <select class="combobox form-control" name="smsRecvFlag" id="smsRecvFlag" >
								  	<option value="Y">수신</option>
								  	<option value="N">비수신</option>
								  </select>
							  </div>			                  
						  </td>
						</tr>
						<tr>
						  <td class="left">자동가입방지</td>
						  <td colspan='3'>
						  		<div class="col-md-6 pl0">
									<input type="text" class="form-control dpin" id="autoStringtext" name="autoStringtext"/>
						  		</div>
						  </td>
						</tr>
					</tbody>
			</table>
			</form>
			</div>
			<!-- end normal input table---------->
				
		    	</div>
			    <!-- end section-container -->	   
				<!-- begin button----------->
				 <div class="row tac mt20">                           
                            <!--<input type="button" id="buttonok" name="buttonok" value="버튼확인" onclick="valchk()" />--> 
							<input type="button" id="jquerybuttonok" name="jquerybuttonok" value="가입신청" onclick="reqcustomerInsert()" class="btn btn-primary width-80" /> 
<!-- 							<input type="submit" value="가입신청" class="btn btn-primary width-80" />  -->
							<input type="button" value="취소" class="btn btn-grey width-80" onclick="moveLoginPage();"/>
                                  </div>
				<!-- end button----------->
				
			</div>
			<!-- end page-body -->
		
	
	</div>
	<!-- end page container -->
	
	
	
</body>
<script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/bootstrap.min.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/respond.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/metisMenu.min.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.dataTables.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/dataTables.bootstrap.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/dataTables.tableTools.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/bootstrapValidator.min.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.placeholder.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.MultiFile.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.form.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/set/core.js"></script>
    
	<script src="<%=request.getContextPath()%>/resources/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    
	<script src="<%=request.getContextPath()%>/resources/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/plugins/jquery-cookie/jquery.cookie.js"></script>

	<script src="<%=request.getContextPath()%>/resources/assets/plugins/bootstrap-calendar/js/bootstrap_calendar.min.js"></script>
<%-- 	<script src="<%=request.getContextPath()%>/resources/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script> --%>
	<!-- ================== END BASE JS ================== -->
	
	<!-- ================== BEGIN PAGE LEVEL JS ================== -->
    <script src="<%=request.getContextPath()%>/resources/assets/js/page-ui-modal-notification.demo.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/page-form-plugins.demo.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/demo.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/apps.min.js"></script>
	<!-- ================== END PAGE LEVEL JS ================== -->
    
 	<!-- captcha -->
	<script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.plugin.js"></script>
	<script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.realperson.js"></script>
	
	
	<script type="text/javascript">
	<c:if test="${not empty errortext}">alert("고객사 아이디 또는 이름을 사용하실수 없습니다.");</c:if>
	$(document).ready(function(){		
		//alert("키보드입력");
		 App.init();
		 
		//메뉴활성화
// 		$("#requestMenu").addClass("active");
// 	 	$("#reqCustomer").addClass("active");
		
		//고객사 ID 중복체크
		$("#customerId").keyup(function(event){
			
			//특수문자 & 공백 입력 제한
	 		if(!(event.KeyCode>=37 && event.keyCode<=40)){
	 			var inputVal = $(this).val();
	 			$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
	 		}
			
			//alert("키보드입력");
			if($("#customerId").val()!=""){
				$.post("<c:url value="/mbr/req/customer/customerIDajaxcheck"/>",
						{"customerId":$("#customerId").val()},
						function(data){
							//alert(data);
							if(data == "true"){
								//alert(1);
								//alert("사용 가능한 ID ID입니다.");
								$("#customerIdchktxt").text("사용 가능한 ID입니다.");								
							}else{
								//alert(2);
								//alert("사용중인 ID입니다.");
								$("#customerIdchktxt").text("이미 사용중인 ID입니다.");
							}
						});
			}else{
				$("#customerIdchktxt").text("");
			}
			
		});
		
		//고객사 이름 중복체크
		$("#customerName").keyup(function(){
			//alert("키보드입력");
			if($("#customerName").val()!=""){
				$.post("<c:url value="/mbr/req/customer/customerNameajaxcheck"/>",
						{"customerName":$("#customerName").val()},
						function(data){
							//alert(data);
							if(data == "true"){
								//alert(1);
								//alert("사용 가능한 ID ID입니다.");
								$("#customerNamechktxt").text("사용 가능한 이름입니다.");								
							}else{
								//alert(2);
								//alert("사용중인 ID입니다.");
								$("#customerNamechktxt").text("이미 사용중인 이름입니다.");
							}
						});
			}else{
				$("#customerNamechktxt").text("");
			}
			
			
		});
		
		$('#autoStringtext').realperson({
			length:6
			, chars: $.realperson.alphabetic
			, regenerate : "클릭시 문자가 변경 됩니다."
		});
		
	});	
	
	function valchk(){
		//$("#buttonok").click(function(){
			
			if($("#customerId").val()==""){
				alert("고객사 ID을 입력하세요");
				$("#customerId").focus();
				return false;
			}
			if($("#customerName").val()==""){
				alert("고객사 이름을 입력하세요");
				$("#customerName").focus();
				return false;
			}			
			if($("#contactName").val()==""){
				alert("담당자이름을 입력하세요");
				$("#contactName").focus();
				return false;
			}
			if($("#contactPhone1").val()==""){
				alert("담당자 핸드폰번호를 입력하세요");
				$("#contactPhone1").focus();
				return false;
			}
			if($("#contactPhone2").val()==""){
				alert("담당자 핸드폰번호를 입력하세요");
				$("#contactPhone2").focus();
				return false;
			}
			if($("#contactPhone3").val()==""){
				alert("담당자 핸드폰번호를 입력하세요");
				$("#contactPhone3").focus();
				return false;
			}
			if($("#contactTel1").val()==""){
				alert("담당자 전화번호번호를 입력하세요");
				$("#contactTel1").focus();
				return false;
			}
			if($("#contactTel2").val()==""){
				alert("담당자 전화번호번호를 입력하세요");
				$("#contactTel2").focus();
				return false;
			}
			if($("#contactTel3").val()==""){
				alert("담당자 전화번호번호를 입력하세요");
				$("#contactTel3").focus();
				return false;
			}
			if($("#contactMail").val()==""){
				alert("담당자 이메일을 입력하세요");
				$("#contactMail").focus();
				return false;
			}
			if($("#autoStringtext").val()==""){
				alert("자동가입방지문자를 입력하세요");
				$("#autoStringtext").focus();
				return false;
			}
			return true;
			//$('form[name=customerform]').submit();
			/*
			if($("#companyId > option:selected").val()!=""){
				//alert($("#companyId > option:selected").val());
				$("#companyId").focus();
				return false;
			}
			if($("input:checkbox[name='smsRecvFlag']:checked").length!=1){
				//alert($("input:checkbox[name='smsRecvFlag']:checked").val());
			}else{
				//alert($("input:checkbox[name='smsRecvFlag']:checked").val());
			}
			*/
		//});
	}
	function number_only(id){
		//alert(id);
		$(id).val( $(id).val().replace(/[^0-9]/gi,''));
		if( !( event.keyCode>=48 && event.keyCode<=57 ) ){
			event.returnValue=false;
	    }
	}
	
	function reqcustomerInsert() {
					
					if(valchk()){
						var jsonData = setJsonData();
						
						$.ajax({
							url : "reqcustomerinsert",
							dataType : "JSON",
							type : "POST",
							data : jsonData,
							success : function(data) {
								var result = data;
								if(result==1){
									//alert("success!!");
									moveLoginPage();
								}else{
									//alert("fail!!");
									moveLoginPage();
								}
							},
							error : function(request, status, error) {
								alert("code:" + request.status + "\n" + "error:" + error);
							}
						})
					}

	}
	
	function setJsonData(){	
		
		var jsonData = {
				"customerId" : $("#customerId").val()        
				, "customerName": $("#customerName").val()                
				, "contactName":$("#contactName").val()
				, "contactPhone1":$("#contactPhone1").val()
				, "contactPhone2":$("#contactPhone2").val()
				, "contactPhone3":$("#contactPhone3").val()
				, "contactTel1":$("#contactTel1").val()
 				, "contactTel2":$("#contactTel2").val()
 				, "contactTel3":$("#contactTel3").val()
 				, "contactMail":$("#contactMail").val()
 				, "autoStringtext":$("#autoStringtext").val()
 				, "autoStringtextHash":$('#autoStringtext').realperson('getHash')
				, "companyId":$("#companyId > option:selected").val()
				, "smsRecvFlag":$("#smsRecvFlag > option:selected").val()
				//, "smsRecvFlag":$("input:checkbox[name='smsRecvFlag']:checked").val()			
				};
		return jsonData;
	}
	
	function companyidselect(){
		//alert($("#companyId > option:selected").val());
		if($("#companyId > option:selected").val()!=""){
			$("#companyview2").empty();
			var jsonData = setJsonData();			
			$.ajax({
				url : "companySelect",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					$.each(data,function(key,val){

						var Html="";
						Html=val["companyRep"];
						$("#companyview2").append(Html);
					});

				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
				
			})
			
			//$("#companyview2").append("test");
			$("#companyview").show();
		}else{
			//alert($("#companyId > option:selected").val());
			$("#companyview2").empty();
			$("#companyview").hide();
		}
			
		//alert($("#companyId > option:selected").val());
		/*
		var jsonData = setJsonData();
		$("#customerId").empty();
		$("#customerId").append("<option value='''>=== 고객사 선택 ===</option>");
		$.ajax({
			url : "companyidSelect",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				$.each(data,function(key,val){

					var Html="";
					Html="<option value='"+val["customerId"]+"''>"+val["customerName"]+"</option>";
					$("#customerId").append(Html);
				});

			},
			error : function(request, status, error) {
				//alert("code:" + request.status + "\n" + "error:" + error);
			}
			
		})
		*/
	}
	
	function moveLoginPage(){

		location.href="${contextPath}/mbr/";
	}
	
	
	</script>
</html>
