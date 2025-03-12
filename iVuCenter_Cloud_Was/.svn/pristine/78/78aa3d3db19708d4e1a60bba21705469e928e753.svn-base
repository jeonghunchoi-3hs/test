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
			
			<h5 class="ml20">ㆍ가격정책 정보</h5>
			
			<!-- begin section-container -->		  
			<div class="section-container inbox">
				<div class="tableB">
					<table>
						<colgroup>
							<col width="10%">								
							<col width="*">														
						</colgroup>
						<tbody>
							<tr>
								<td class="cen height-40">
									적용일자
								</td>
								<td>
									<div class="col-md-10" id="datepicker-disabled-past" data-date-format="dd-mm-yyyy" data-date-start-date="Date.default">
										<input type="text" class="form-control dpin width-100" placeholder="날짜선택" id="applyDate" name="applyDate" value="${getBillPolicyInfo.applyDate}" readonly/>
										<!-- <span class="input-group-addon"><i class="fa fa-calendar"></i></span> -->						
									</div>
								</td>
							</tr>
							<tr>
								<td class="cen height-40">
									정책이름
								</td>
								<td>
									<div class="col-md-10">
										<input class="form-control" type="text" name="policyName" id="policyName" value="${getBillPolicyInfo.policyName}" />
										<input type="hidden" name="policySeq" id="policySeq" value="${getBillPolicyInfo.policySeq}" />											
									</div>
								</td>
							</tr>
						</tbody>
						</table>	        
					</div>
				</div>
				<div class="row tac mt20">
					<button type="button" class="btn btn-primary width-80" onclick="saveCheck();">저장</button>
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
	
	// 달력
	function calendar(){
		
		var dayName = ['일','월','화','수','목','금','토'];
		var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

		$("#applyDate").datepicker({
			showOn:"both",
			buttonImage:"${contextPath}/resources/assets/img/calen.png",
			buttonImageOnly:true,
			dateFormat : "yy-mm-01",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});
		
		$("#applyDate").datepicker({
			showOn:"both",
			buttonImage:"${contextPath}/resources/assets/img/calen.png",
			buttonImageOnly:true,
			dateFormat:"yy-mm-01",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});

	}
	
	function saveCheck(){
		if($("#applyDate").val()==""){
			alertBox3("적용일자를 입력하세요");
			$("#applyDate").focus();
			return false;
		}
		if($("#policyName").val()==""){
			alertBox3("정책이름을 입력하세요");
			$("#policyName").focus();
			return false;
		}
		
		confirmBox("저장하시겠습니까?", billpolicyedit);
	}
	
	
	function billpolicyedit(){
		
		var jsonData = policyjsonData();
		$.ajax({
			url : "${contextPath}/mng/bill/policy/billPolicyEditok",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {				
				if(data==1){
					alertBox("수정되었습니다.", movePage);
// 					location.href = "${contextPath}/mng/bill/policy/billPolicyList";
				}else{
					alertBox3("수정이 실패하였습니다.");				
				}
				

			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
			
		})
	}
	
	function policyjsonData(){	
		
		var jsonData = {
				"applyDate" : $("#applyDate").val()        
				, "policyName": $("#policyName").val() 
				, "policySeq": $("#policySeq").val()
				};
		return jsonData;
	}
	
	
	function movePage(){
		var policySeq = $("#policySeq").val();
		location.href="${contextPath}/mng/bill/policy/billPolicyView?policySeq="+policySeq;
	}
	
	$(document).ready(function() {
		
		//gridList();
		
		App.init();
		calendar();

		//메뉴활성화
		$("#productAservice").addClass("active");
		$("#billPolicy").addClass("active");
	});
</script>
</body>
</html>