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

	<form name="billItemSearch"  id="billItemSearch" action="billItemSearch" method="post" >
		<input type="hidden" name="type" id="type" value="check" />
		<table id="table_1" class="table" border="1">
				<tr>					
					<td>
						<input type="text" name="itemName" id="itemName" value="${itemName}" /> <input type="button" value="검색" onclick="search()" /> 		
						<input type="hidden" name="policySeq" id="policySeq" value="${policySeq}" />
					</td>					
				</tr>						
		</table>
		<table id="table_1" class="table" border="1">			
				<tr>
					<td>
						아이템명 										
					</td>
					<td>	
						수량										
					</td>					
					<td>
						단위											
					</td>
					<td>
						적용											
					</td>				
				</tr>
				<c:forEach items="${getBillItemSearchList}" var="getBillItemSearchList" varStatus="status" >											
				<tr>
					<td>
						${getBillItemSearchList.itemName}										
					</td>
					<td>
						${getBillItemSearchList.quantity}									
					</td>
					<td>
						${getBillItemSearchList.unit}									
					</td>				
					<td>
						<input type="button" value="적용" onclick="billItemSearchresult('${getBillItemSearchList.itemName}','${getBillItemSearchList.itemId}','${getBillItemSearchList.quantity}','${getBillItemSearchList.unit}')"  />									
					</td>				
				</tr>
			</c:forEach>		
		</table>
	</form>
	

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
	
	
	function billItemSearchresult(itemName,itemId,quantity,unit){
		//window.opener.mbrform.mbrId.value="";
		opener.document.getElementById("itemName").value=itemName;
		opener.document.getElementById("itemId").value=itemId;
		opener.document.getElementById("quantity").value=quantity;
		opener.document.getElementById("unit").value=unit;
		opener=window;
		opener.close();
	}
	
	function search(){
		if($("#itemName").val()==""){
			alert("아이템명를 입력하세요");
			$("#itemName").focus();
			return false;
		}
		$("#billItemSearch").submit();
		/*
		var jsonData = policyjsonData();
		$.ajax({
			url : "billitemwriteok",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {			
				//alert(data);
				if(data==1){
					//alert("등록되었습니다.");
					location.href = "${contextPath}/mng/bill/policy/billPolicyList";
				}else{
					//alert("등록이 실패하였습니다.");
					location.href = "${contextPath}/mng/bill/policy/billItemWrite";
				}
				

			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
			
		})
		*/
	}
	
	function policyjsonData(){	
		
		var jsonData = {
				"itemName" : $("#searchValue").val()     
				, "policySeq": "${policySeq}" 				
				};
		return jsonData;
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