<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		
		<c:import url="${contextPath}/WEB-INF/views/home/include/home_import.jsp" charEncoding="UTF-8"></c:import>		
		
		<title>KEPCO Cloud Service Platform</title>
		
		<style>
			.table_p {width:95%; margin-left:30px;}
			.table_p thead tr th {
				border-right:1px solid #d9e5f9; 
				border-top:2px solid #0068B6 !important; 
				border-bottom:2px solid #0068B6 !important; 
				background:#f3f6f7;
				font-weight:bold;
				padding:12px 6px;
				text-align:center !important;
				vertical-align:middle;
				}
			.table_p thead tr th:last-child {border-right:none;}
			.table_p tbody tr td {
				border-right:1px solid #e5e5e5; 
				border-bottom:1px solid #e5e5e5; 
				padding:10px 8px;
				text-align:center;
				vertical-align:middle;
				}
			.br1e5 {
				border-right:1px solid #e5e5e5 !important;
			}
			.bbn {
				border-bottom:none !important;
			}
			
			/* .table_p tbody tr:last-child td {border-bottom:1px solid #c5c5c5;} */
			.table_p tbody tr td:last-child {border-right:none;}
			
			
		</style>
	</head>
	
	<body>
		<div id="container">
			<!-- top menu start -->
			<c:import url="${contextPath}/WEB-INF/views/home/include/home_top.jsp" charEncoding="UTF-8"></c:import>	
			<!-- top menu end -->
		 	
		 	<div class="simg"></div>
	 	 	
	 	 	<div class="sub mb30">
				<h3 class="subtitle"><i class="fa fa-cloud f18"></i> 서비스 수준 약정_SLA(Service Level Agreement)</h3>
			  	
			  	<section class="policy">
					<!-- <h4 class="t-in6">적용범위<h4> -->
					
					<h5 class="bgee p10"> 적용범위 </h5>
					<p>
						본 개별 서비스 수준 약정 (“본 SLA")는 가상서버(이하 ”본 서비스“)를 사용하는 각 계정에 개별적으로 적용됩니다.<br/>
					</p>
					
					<h5 class="bgee p10">정의</h5>
					<p>
						∙ 장애 : 1분 동안 본 서비스에 대한 모든 연결 요청이 실패함을 말합니다. <br/>					 
						∙ 장애시간 : 해당월 동안 장애가 발생한 시간의 총합을 말하며, 본 서비스를 이용하지 못한 사실을 회원이 회사에 통지한 때(회원의 통지 전에 회사가 그 사실을 알 경우는 회사가 그 사실을 알게 된 때)부터 
						측정됩니다. 단, 본 SLA의 적용이 배제되는 경우 그 해당 시간은 장애시간에 포함되지 않습니다.<br/>
						∙ 가용성 : 100 * [1-{본 서비스를 이용한 한달 동안 ”회사“의 책임 있는 사유로 인한 장애로 본 서비스를 이용하지 못하는 장애시간(분)의 합/본 서비스를 이용할 수 있는 기간 한달(분)}] <br/>
						∙ 확장성 : 본 서비스는 이용자의 요청에 따라 자원의 양을 할당할 수 있는 능력을 말합니다. <br/>
						
						<table class="table_p"> 
							<colgroup>
								<col width="30%"/>
								<col width="35%"/>
								<col width="35%"/>
							</colgroup>
							<thead>
								<tr>
									<th>정의</th>
									<th>장애 시간</th>
									<th>장애 내역</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td> 가용성 </td>
									<td> 월 가용률 99.9% 보장 </td>
									<td> 서버/네트워크 고장으로 서비스 접속 불가 </td>
								</tr>
							</tbody>
						</table>
						<br/>

						<table class="table_p"> 
							<colgroup>
								<col width="30%"/>
								<col width="35%"/>
								<col width="35%"/>
							</colgroup>
							<thead>
								<tr>
									<th>정의</th>
									<th>생성 응답 수준</th>
									<th>변경, 삭제 응답 수준</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td> 응답성 </td>
									<td> 결재 완료 후 10분 이내 응답 </td>
									<td> 결재 완료 후 5분 이내 응답 </td>
								</tr>
							</tbody>
						</table>
						<br/>
						
						<table class="table_p"> 
							<colgroup>
								<col width="30%"/>
								<col width="35%"/>
								<col width="35%"/>
							</colgroup>
							<thead>
								<tr>
									<th>정의</th>
									<th>확장성 상세내용</th>
									<th>처리 방식</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td rowspan="3"> 확장성 </td>
									<td> 운영 중 Instance 확장 </td>
									<td rowspan="3"> On-Demand </td>
								</tr>
								<tr>
									<!-- <td> 가용성 </td> -->
									<td class="br1e5"> 운영 중 Volume 확장 </td>
									<!-- <td> 서버/네트워크 고장으로 서비스 접속 불가 </td> -->
								</tr>
								<tr>
									<!-- <td> 가용성 </td> -->
									<td class="br1e5"> 확장 사양의 축소 </td>
									<!-- <td> 서버/네트워크 고장으로 서비스 접속 불가 </td> -->
								</tr>
							</tbody>
						</table>
						<br/>
					 </p>
				</section>
		 	
		 	</div>
	
			<div class="clear"></div>
			
			<!-- footer start -->
			<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
			<!-- footer end -->		
		</div>
	</body>
</html>