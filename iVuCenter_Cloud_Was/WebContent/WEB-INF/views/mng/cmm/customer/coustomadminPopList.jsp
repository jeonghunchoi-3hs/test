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

	<form name="userSearch"  id="userSearch" action="userSearch.do" method="post" >
		<input type="hidden" name="type" id="type" value="check" />
		<table id="table_1" class="table" border="1">
				<tr>
					<td>
						사용자명
					</td>
					<td>
						<input type="text" name="searchValue" id="searchValue" value="${searchValue}" />
						<button type="submit" class="btn btn-primary width-80" >검색</button>
					</td>					
				</tr>
				<tr>					
					<td  colspan="2">
						${namechktext} <c:if test='${chkval eq "0"}'> <input type="button" value="아이디 적용확인" onclick="projectSearchresult()"  /> </c:if> 
					</td>
				</tr>			
		</table>
		<table border="1">
			<tr>
				<td >
					사용자명
				</td>
				<td>
					아이디
				</td>
				<td>
					권한
				</td>
				<td >
					
				</td>							  				
			</tr>
			<tbody id="memTable" name="memTable">	
				<c:forEach items="${getCustomerMemberList}" var="getCustomerMemberList" varStatus="status" >
				<tr>
					<td>											
							${getCustomerMemberList.userName} 
					</td>
					<td>											
							 ${getCustomerMemberList.userId}
					</td>
					<td>											
							${getCustomerMemberList.userAuthority} 
					</td>
					<td>
						<input type="button" id="${getCustomerMemberList.userId}" name="${getCustomerMemberList.userId}" value="추가" onclick="customadminSet('${getCustomerMemberList.userId}','${getCustomerMemberList.userAuthority}');" class="btn btn-primary width-80" />
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
	
	<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
	
	<script type="text/javascript">
	
	function customadminSet(userId,userAuthority){
			$.ajax({
					url : "${contextPath}/mng/cmm/customer/customadminInsert",
					dataType : "JSON",
					type : "POST",
					data : {"userId" : userId,"customerId" : '${customerId}',"userAuthority" : userAuthority},
					success : function(data) {
						var result = data;	
						//opener.document.getElementById("managerId").value=userId;
						opener.getDetail();
						opener=window;
						opener.close();
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
			})

	}
	</script>
</body>
</html>