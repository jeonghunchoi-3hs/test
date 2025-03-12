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
			<h1 class="page-header">  <img src="<%=request.getContextPath()%>/resources/images/title_icon/userInfo.png"/>  고객사 정보<span class="root"><img src="/resources/assets/img/root_icon.png"/> 콘솔 > 내정보 </span></h1>
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
								 	<div class="col-sm-6">
								 		<p class="form-control-static f14 fb lh34 p0" id="customerId"></p>
								 	</div>
								</td>
							</tr>
							<tr>
							  	<td class="left">고객사 이름</td>
							  	<td>
							  		<div class="col-sm-6">
							  			<p class="form-control-static f14 fb lh34 p0" id="customerName"></p></div>
							  	</td>
							</tr>
							<tr>
							  	<td class="left">사업자 이름</td>
							  	<td>
							  		<div class="col-sm-6">
							  			<p class="form-control-static f14 fb lh34 p0" id="companyName"></p>
							  		</div>
							  		<input type="hidden" id="companyId" value="">
							  	</td>
							</tr>
							
							<tr>
								<td class="left">담당자 이름</td>
							  	<td>
							  		<div class="col-sm-6">
							  			<p class="form-control-static f14 fb lh34 p0" id="contactName"></p>
							  		</div>
							  	</td>
							</tr>
							<tr>
							  	<td class="left">담당자 전화번호</td>
							  	<td>
							  		<div class="col-sm-6">
							  			<p class="form-control-static f14 fb lh34 p0" id="contactTel"></p>
							  		</div>
							  	</td>
							</tr>
							<tr>
								<td class="left">사용자 이메일</td>
								<td>
									<div class="col-sm-6">
										<p class="form-control-static f14 fb lh34 p0" id="contactMail"></p>
									</div>								 
								</td>
							</tr>
							<tr>
							  	<td class="left">SMS 수신여부</td>
							  	<td>
								  	<div class="col-sm-6">
								  		<p class="form-control-static f14 fb lh34 p0" id="smsRecvFlag"></p> 			                  	
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
				<input type="button" value="수정" class="btn btn-lime width-80" onclick="moveInsertPage();">
				<input type="button" value="해지" class="btn btn-danger width-80" onclick="customerExpr();" id="exprbtn" name="exprbtn">
<!-- 				<input type="button" value="탈퇴" class="btn btn-danger width-80" onclick="customerInfoDelete();"> -->
			</div>
			<!-- end button -->
			
		</div>
		<!-- end page-body -->
		
		<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">탈퇴신청</h4>
	                       </div>
	                       <div class="modal-body">
	                          <h5 id="resMsg"></h5>
	                       	</div>
	                       	<div class="modal-footer tac">
	                       		<div id="exitEnable">
		                        	<a type='button' class="btn width-100 btn-primary" onclick="userInfoDelete();">확인</a>
									<a type='button' class="btn width-100 btn-default" data-dismiss="modal" onclick="initModal();">닫기</a>
	                           	</div>
								<div id="exitUnable">
									<a type='button' class="btn width-100 btn-default" data-dismiss="modal" onclick="initModal();">닫기</a>
								</div>

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
				if(data.exprcnt!=0){					
					$("#exprbtn").hide();
				}
				setData(data);
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});
		
	}
	
	function customerInfoDelete(){
		
		$.ajax({
			url : "customerInfoDelete",
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

		$("#_customerId").val(data.customerId);
		$("#customerId").text(data.customerId);
		$("#customerName").text(data.customerName);
		$("#companyName").text(data.companyName);
		$("#contactName").text(data.contactName);
		$("#contactTel").text(data.contactTel);
		$("#contactMail").text(data.contactMail);
		if(data.smsRecvFlag == "Y"){
			$("#smsRecvFlag").text("수신");
		}else{
			$("#smsRecvFlag").text("미수신");
		}
		$("#companyId").val(data.companyId);
		
	}
	
	function moveInsertPage(){
		var customerId = $("#_customerId").val();
		location.href = "${contextPath}/mbr/cmm/customer/customerInfoWrite?customerId="+customerId;
	}

	$(document).ready(function(){		
		//alert("키보드입력");
		 App.init();
		 customerInfoDetail();
		
	});
	
	//고객사 해지 
	function customerExpr() {							
		if(confirm("해지신청 하시겠습니까?")){
			
			var customerId = "${customerId}";
			var customerName = $("#customerName").text();				
			var companyId = $("#companyId").val();
			var contactName = $("#contactName").text(); 
			var contactPhone = "";
			var contactTel = $("#contactTel").text();
			var contactMail = $("#contactMail").text();
			//alert($("#companyId").val());
			$.ajax({
				url : "customerExpr",
				dataType : "JSON",
				type : "POST",
				data : {
					"customerId" : customerId,
					"customerName" : customerName,
					"companyId" : companyId,
					"contactName" : contactName,
					"contactPhone" : contactPhone,
					"contactTel" : contactTel,
					"contactMail" : contactMail					
				},					
				success : function(data) {
					//var result = data;						
					//alert(data);
					if(data==0){
						alertBox3("정상적으로 해지신청되었습니다.");
					}else{
						errorBox3("등록된 프로젝트가 있어서 해지를 하실수 없습니다.");
					}
					
				},
				error : function(request, status, error) {
					errorBox("code:" + request.status + "\n" + "error:" + error);
				}
			})
		}				
		
	}

</script>

</html>
