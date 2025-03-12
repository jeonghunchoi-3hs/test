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
	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin header -->
			<h1 class="page-header fc66 fb"> <i class="fa fa-dot-circle-o fcb"> </i> 가격 정책 관리 <span class="root">관리자포털 > 요금  > 가격 정책 관리</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row mb50">
			
			<!-- begin section-container -->		  
			
			<div class="section-container inbox">
			<h5 class="ml20">ㆍ가격정책 정보</h5>
				<div class="tableB">
					<table>
						<colgroup>
							<col width="15%">								
							<col width="*">														
						</colgroup>
						<tbody>
							<tr>
								<td class="left-b height-40">
									과금항목명
								</td>
								<td>
									${getBillItemEditVo.itemName}
									<input  type="hidden" name="itemId" id="itemId" value="${getBillItemEditVo.itemId}"/>
									<input  type="hidden" name="policySeq" id="policySeq" value="${policySeq}"/>
								</td>
							</tr>
							<tr>
								<td class="left-b height-40">
									수량
								</td>
								<td>
									${getBillItemEditVo.quantity}
								</td>
							</tr>
							<tr>
								<td class="left-b height-40">
									단위
								</td>
								<td>
									${getBillItemEditVo.unit}
								</td>
							</tr>
							<tr>
								<td class="left-b height-40">
									시간단위 가격
								</td>
								<td>
									<input class="form-control width-200 dpin tar" type="text" maxlength="9" name="hourlyPrice" id="hourlyPrice" value='<fmt:formatNumber value="${getBillItemEditVo.hourlyPrice}" pattern="#,###"/>' onkeypress="number_only(this)" onblur="addcommaById(this);"/> 원
								</td>
							</tr>
							<tr>
								<td class="left-b height-40">
									월단위 가격
								</td>
								<td>
									<input class="form-control width-200 dpin tar" type="text" maxlength="9" name="monthlyPrice" id="monthlyPrice" value='<fmt:formatNumber value="${getBillItemEditVo.monthlyPrice}" pattern="#,###"/>' onkeypress="number_only(this)" onblur="addcommaById(this);"/> 원
								</td>
							</tr>
						</tbody>
					</table>	        
				</div>
				</div>
				
				<div class="row tac mt20">
					<button type="button" class="btn btn-lime width-80" onclick="saveConfirm();">저장</button>
					<button type="button" class="btn btn-grey width-80" onclick="movePage();">취소</button>	
				</div>
			
			</div>
			<!-- 테이블 끝 -->
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
	
<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
	
	function saveConfirm(){
		confirmBox("저장하시겠습니까?", billitemedit);
	}
	
	function billitemedit(){
		
		if($("#hourlyPrice").val()==""){
			alertBox3("시간단위 가격을 입력하세요");
			$("#hourlyPrice").focus();
			return false;
		}
		if($("#monthlyPrice").val()==""){
			alertBox3("월단위 가격을 입력하세요");
			$("#monthlyPrice").focus();
			return false;
		}
		
		var jsonData = policyjsonData();
		$.ajax({
			url : "${contextPath}/mng/bill/policy/billitemeditok",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {				
				if(data==1){
					alertBox("수정되었습니다.", movePage);
				}else{
					alertBox("수정이 실패하였습니다.", movePage);
				}

			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
			
		})
	}
	
	function policyjsonData(){	
		
		var jsonData = {
				"itemName" : $("#itemName").val()     
				, "itemId": $("#itemId").val()
				, "quantity": $("#quantity").val() 
				, "unit": $("#unit").val() 
				, "hourlyPrice": $("#hourlyPrice").val().replace(/,/gi,"") 
				, "monthlyPrice": $("#monthlyPrice").val().replace(/,/gi,"") 
				, "policySeq": "${policySeq}" 				
				};
		return jsonData;
	}
	
	function movePage(){
		var policySeq = $("#policySeq").val();
		location.href="${contextPath}/mng/bill/policy/billPolicyView?policySeq="+policySeq;
	}

	
	// 금액에 콤마추가 
	function addcommaById(e){
		
		var n = e.value;
		var id = e.id;
		
		$("#"+id).val(addcomma(n));
	}
	
	$(document).ready(function() {
		
		//gridList();		
		App.init();
		
		//메뉴활성화
		$("#productAservice").addClass("active");
		$("#billPolicy").addClass("active");
	});
</script>
</body>
</html>