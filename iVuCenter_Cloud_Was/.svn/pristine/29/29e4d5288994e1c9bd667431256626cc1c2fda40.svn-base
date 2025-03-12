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
	<c:import url="/WEB-INF/views/mbr/include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mbr/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mbr/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			
			
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>프로젝트 결재자 지정</h1>
				<div class="pageNav">
					<a href="${contextPath}/mbr/main" class="home"><i></i></a><a href="#">변경신청</a><a href="#" class="on">사용자 권한 관리</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				
				<div class="client_DetailBg m-b-40">
					<div class="client_DetailArea">
	
						
						<h2 class="customer_Id">${req.userId}</h2>
						<p class="customer_Name"><span id="companyName"></span><span class="company_Name" id="customerName"></span></p> 
						<p class="company_Info">
							<span class="company_labelf">NHwith수신여부 :</span><span class="company_cont" id="smsRecvFlag">수신</span>
							<span class="company_label">이메일 수신여부 :</span><span class="company_cont" id="">수신</span>
							<span class="company_label">SMS 수신여부 :</span><span class="company_cont" id="nhwithRecvFlag">미수신</span>
						</p>
								
						<div class="manager_Info">
							<h2>사용자정보</h2>
							<div id="adminArea">
							<div class="mt15"> 
								<span class="manager_Name fontN" id="userName"></span>
								<input type="hidden" name="managerName" id="managerName" value="" data-original-title="" title="">
							</div>
							<div class="mt10"> 
								<span class="manager_Tel" id="userTel"></span>
								<span class="manager_Phone" id="userPhone"></span>
								<span class="manager_Mail" id="userMail"></span> 
							</div>
							</div>
						</div>
					</div> 
				</div>
				
				<h2 class="titleBuType01 m-b-15">권한 정보</h2>
				<div class="formType01">
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="150px">
								 <col width="*">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row"><strong>승인자 등록</strong></th>
								<td>
										<div class="optionBox w114">
											<label><input type="checkbox" id="WF3000A0" name='auth' value='Y'><span>부장승인</span></label>
											<label><input type="checkbox" id="WF3000B0" name='auth' value='Y'><span>차장승인</span></label>
										</div>
									</td>
							</tr>
								<tr>
									<th scope="row"><strong>정산승인</strong></th>
									<td>
										<div class="optionBox w114">
											<label><input type="checkbox" id="WF2000A0" name='auth' value='Y'><span>신청자</span></label>
											<label><input type="checkbox" id="WF2000B0" name='auth' value='Y'><span>1차승인</span></label>
											<label><input type="checkbox" id="WF2000C0" name='auth' value='Y'><span>기획담당</span></label>
											<label><input type="checkbox" id="WF2000D0" name='auth' value='Y'><span>회계담당</span></label>
											<label><input type="checkbox" id="WF2000E0" name='auth' value='Y'><span>2차승인</span></label>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>자원승인</strong></th>
									<td>
										<div class="optionBox w114">
											<label><input type="checkbox" id="WF1000A0" name='auth' value='Y'><span>1차승인</span></label>
											<label><input type="checkbox" id="WF1000B0" name='auth' value='Y'><span>2차승인</span></label>
											<label><input type="checkbox" id="WF1000C0" name='auth' value='Y'><span>3차승인</span></label>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>작업</strong></th>
									<td>
										<div class="optionBox w114">
											<label><input type="checkbox" id="OPERATION" name='auth' value='Y'><span>작업담당</span></label>
											<label><input type="checkbox" id="CONFIRMACTION" name='auth' value='Y'><span>작업확인</span></label>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="row tac m-t-60">
					<a type="button" class="btnType03 btnType03_del" onClick="actDelete();">삭제</a>
					<a type="button" class="btnType03 btnType03_save m-l-15" onClick="actUpdate();">저장</a>
		 			<a type="button" class="btnType03 btnType03_list m-l-15" onClick="moveListPage();">목록</a>
                </div>
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mbr/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
			</div>
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
<c:import url="/WEB-INF/views/mbr/include/script.jsp" charEncoding="UTF-8"></c:import>	
<script type="text/javascript">
	
	function userInfoDetail(){
		$.ajax({
			url : "${contextPath}/mng/cmm/user/userInfoDetail",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : '${req.userId}'
			},
			success : function(req) {
				delete req.length; 
				$.each(req, function(key, val){
					if(val != null){
						if(key=="smsRecvFlag" || key=="nhwithRecvFlag"){
							if(val == "Y"){
								$("#"+key).text("수신");
							}else{
								$("#"+key).text("미수신");
							}
						}else{
							$("#"+key).text(val);
						}
					}
				});
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function moveListPage(){
		location.href = "${contextPath}/mbr/req/project/projectInsert.do";
	}

	function userAuthDetail(){
		$.ajax({
			url : "${contextPath}/mbr/operation/approveUser/auth",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : '${req.userId}'
			},
			success : function(req) {
				delete req.length; 
				$.each(req, function(key, val){
					if(val == "Y"){
						$("input:checkbox[id='"+key.toUpperCase()+"']").attr('checked', val);
					}
				});
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function actUpdate(){
		$.ajax({
			url : "${contextPath}/mbr/operation/approveUser/updateAdmin",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : '${req.userId}'
				, "operation" :$("input:checkbox[id='OPERATION']").is(":checked")?"Y":"N" 
				, "confirmAction" :$("input:checkbox[id='CONFIRMACTION']").is(":checked")?"Y":"N" 
				, "WF1000A0" : $("input:checkbox[id='WF1000A0']").is(":checked")?"Y":"N"
				, "WF1000B0" : $("input:checkbox[id='WF1000B0']").is(":checked")?"Y":"N"
				, "WF1000C0" : $("input:checkbox[id='WF1000C0']").is(":checked")?"Y":"N"
				, "WF2000A0" : $("input:checkbox[id='WF2000A0']").is(":checked")?"Y":"N"
				, "WF2000B0" : $("input:checkbox[id='WF2000B0']").is(":checked")?"Y":"N"
				, "WF2000C0" : $("input:checkbox[id='WF2000C0']").is(":checked")?"Y":"N"
				, "WF2000D0" : $("input:checkbox[id='WF2000D0']").is(":checked")?"Y":"N"
				, "WF2000E0" : $("input:checkbox[id='WF2000E0']").is(":checked")?"Y":"N"
				, "WF3000A0" : $("input:checkbox[id='WF3000A0']").is(":checked")?"Y":"N"
				, "WF3000B0" : $("input:checkbox[id='WF3000B0']").is(":checked")?"Y":"N"
				, "length"	 : $("input:checkbox[name='auth']:checked").length
			},
			success : function(req) {
				if(req == "1"){
					if($("input:checkbox[name='auth']:checked").length > 0){
						alertBox("수정되었습니다.", moveListPage)
					}else{
						alertBox("사용자 권한이 삭제 되었습니다.", moveListPage)
					}
				}else{
					alertBox3("오류");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});		
	}
	
	
	function actDelete() {
		$.ajax({
			url : "${contextPath}/mbr/operation/approveUser/updateAdmin",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : '${req.userId}'
				, "operation" : "N" 
				, "confirmAction" : "N" 
				, "WF1000A0" : "N"
				, "WF1000B0" : "N"
				, "WF1000C0" : "N"
				, "WF2000A0" : "N"
				, "WF2000B0" : "N"
				, "WF2000C0" : "N"
				, "WF2000D0" : "N"
				, "WF2000E0" : "N"
				, "WF3000A0" : "N"
				, "WF3000B0" : "N"
				, "length"	 : 0
			},
			success : function(req) {
				if(req == "1"){
					alertBox("사용자 권한이 삭제 되었습니다.", moveListPage)
				}else{
					alertBox3("오류");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});		
		
	}
	
	
	$(document).ready(function() {
		App.init();
		userInfoDetail();
		userAuthDetail();
		
		//메뉴활성화
		$("#operation").addClass("active");
		$("#adminUser").addClass("active");

	});
</script>
</body>
</html>