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
	<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
	<script type="text/javascript">
	function projectSearchresult(projectName,projectId){
		//window.opener.mbrform.mbrId.value="";
		opener.document.getElementById("projectName").value=projectName;
		opener.document.getElementById("projectId").value=projectId;
		opener=window;
		opener.close();
	}
	</script>
</head>
<body>
	<form name="projectSearch"  id="projectSearch" action="projectSearch.do" method="post" >
		<input type="hidden" name="type" id="type" value="check" />
		<table id="table_1" class="table" border="1">
				<tr>					
					<td>
						<input type="text" name="searchValue" id="searchValue" value="${searchValue}" /> <input type="submit" value="확인" /> 						
					</td>					
				</tr>
				<tr>					
					<td >
						${namechktext} <c:if test='${chkval eq "0"}'> <input type="button" value="아이디 적용확인" onclick="projectSearchresult()"  /> </c:if> 
					</td>
				</tr>			
		</table>
		<table id="table_1" class="table" border="1">			
				<tr>
					<td>
						영문이름 										
					</td>
					<td>	
						한글이름										
					</td>					
					<td>
						적용확인											
					</td>				
				</tr>
				<c:forEach items="${getProjectList}" var="getProjectList" varStatus="status" >											
				<tr>
					<td>
						${getProjectList.projectName}										
					</td>
					<td>
						${getProjectList.projectAlias}	${getProjectList.projectId}										
					</td>					
					<td>
						<input type="button" value="적용" onclick="projectSearchresult('${getProjectList.projectName}','${getProjectList.projectId}')"  />									
					</td>				
				</tr>
			</c:forEach>		
		</table>
	</form>
</body>
</html>