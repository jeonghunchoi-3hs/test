<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
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
	<c:import url="/WEB-INF/views/mng/include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in hide"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			
			
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>계열사 수정</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책 관리</a><a href="#" class="on">계열사 관리</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<div class="formType01">
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col style="width:150px">
								 <col style="width:820px">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>구분</strong></th>
									<td>
										<div class="cmmeditArea">
											<div class="selectBox" style="width:380px;">
												<label class="selectText"></label>
												<select class="search-sel" id='companyName'>
												</select>
											</div>
											<a type='button'class="btnType04 cmmeditBtn" style="width:70px;" onclick="moveCopyPage();"><span class="txt">추가</span></a>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>계열사명</strong></th>
									<td>
										<input type="text" style="width:650px; margin-right: 5px" id='customerName'>
										<input type="hidden" id='customerNameChk'>
										<a type='button'class="btnType04" style="width:100px;" onclick="chkName();"><span class="txt">중복확인</span></a>
									</td>
								</tr> 
								<tr>
									<th scope="row"><strong>등록자</strong></th>
									<td id='userName'></td>
								</tr>
								<tr>
									<th scope="row"><strong>등록일시</strong></th>
									<td class="fontVdn" id='regDatetime2'>0000-00-00 00:00</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="row tac m-t-60">
		 			<a type='button'class="btnType03 btnType03_save" onClick="actInsertPage();">저장</a>
		 			<a type='button'class="btnType03 btnType03_cancel m-l-15" onClick ="moveListPage()">취소</a>
                </div>
                
                <div class="modal fade" id="modal-dialog-copy"> 
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">구분 등록</h4>
	                       	</div>
	                       	<div class="modal-body">
	                       		<div class="formType01">
									<div class="tblWrap clearfix">
										<table>
											<colgroup>
												 <col width="100px">
												 <col width="400px">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><strong>구분</strong></th>
													<td class="tal">
														<input type="text" style="width:255px;" id='popCompanyName'>
														<input type="hidden" id='popCompanyNameChk'>
														<a type='button'class="btnType02_form" onclick="popChkName()"><span class="txt">중복확인</span></a>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="lbtn" onclick="actInsertPop();">확인</a>
		                       <a type="button" class="rbtn" data-dismiss="modal">취소</a>
	                       </div>
		               	</div>
					</div>
	            </div>
			
			</div>
			<!-- end page-body -->
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

	function moveListPage(){
		location.href="${contextPath}/mng/cmm/company/";
	}
	
	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/cmm/company/detail",
			dataType : "JSON",
			data : {
				"companyId" : "${req.companyId}"
			},
			success : function(req) {
				delete req.length;
				$.each(req, function(i, val){
					if(val != null){
						if(i == "regDatetime2" || i == "userName"){
							$("#"+i).text(val);
						}else if (i=="customerName") {
							$("#customerName").val(val);
							$("#customerNameChk").val(val);
						}else{
							$("#"+i).val(val);							
						}
					}
				});
				actCompanylist(req.companyId);
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	function actCompanylist(id){
		$.ajax({
			url : "${contextPath}/mng/cmm/company/companylist",
			dataType : "JSON",
			data : {
				"searchKind" : "selectBox"
			},
			success : function(data) {
				if(data.companylist != ""){
					$("#companyName").html('<option value="">구분</option>');
					$.each(data.companylist, function(key,val){
						$("#companyName").append('<option value="'+val.companyId+'">'+val.companyName+'</option>');
					});
					
					$("#companyName").val(id);
					$("#companyName").siblings(".selectText").text($("#companyName > option:selected").text());
				}
				if(id==''){
					
				}
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			} 
		});
	}
	
	function chkName(){
		if($("#customerName").val() == ""){
			alertBox3("계열사명을 입력해주세요.");
			return false;
		}
		
		actChkName({
				"searchKind" : "company_name"				
				, "companyName" : $("#customerName").val()
				, "upCompanyId" : $("#companyName").val() 
				, "regUserId" : "${userId}"
		});
	}
	
	function actChkName(data){
		$.ajax({
			url : "${contextPath}/mng/cmm/company/companylist",
			dataType : "JSON",
			data : data,
			success : function(req) {
				if(req.companylist.length == 0){
					alertBox3("등록이 가능합니다.");
					if(data.upCompanyId == "*"){
						$("#popCompanyNameChk").val(data.companyName);
					}else{
						$("#customerNameChk").val(data.companyName);
					}
				}else{
					if(data.upCompanyId == "*"){
						alertBox3("구분명이 중복되었습니다.");
					}else{
						alertBox3("계열사명이 중복되었습니다.");
					}
				}
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			} 
		});		
	}
	
	function moveCopyPage(){
		$("#popCompanyName").val("");
		$("#popCompanyNameChk").val("");
		$("#modal-dialog-copy").modal();
	}
	
	function popChkName(){
		if($("#popCompanyName").val() == ""){
			alertBox3("구분을 입력해주세요.");
			return false;
		}
		
		actChkName({
				"searchKind" : "company_name"				
				, "companyName" : $("#popCompanyName").val()
				, "upCompanyId" : "*" 
				, "regUserId" : "${userId}"
		});
	}

	function actInsertPop(){
		if($("#popCompanyName").val() == ""){
			alertBox3("구분을 입력해주세요.");
			return false;
		}
		if($("#popCompanyNameChk").val() == "" || $("#popCompanyName").val() != $("#popCompanyNameChk").val()){
			alertBox3("중복확인을 해주세요.");
			return false;
		}
		actInsert({
				"gbn" : "pop"				
				, "companyName" : $("#popCompanyName").val()
				, "upCompanyId" : "*" 
				, "regUserId" : "${userId}"
		});
	}
	
	// 계열사 정보 수정 (저장)
	function actInsertPage(){
		if($("#companyName").val() == ""){
			alertBox3("구분을 선택해주세요.");
			return false;
		}
		if($("#customerName").val() == ""){
			alertBox3("계열사명을 입력해주세요.");
			return false;
		}		
		if($("#customerNameChk").val() == "" || $("#customerName").val() != $("#customerNameChk").val()){
			alertBox3("중복확인을 해주세요.");
			return false;
		}		
		actInsert({
				"gbn" : "page"		
				, "companyId"	: "${req.companyId}"
				, "companyName" : $("#customerName").val()
				, "upCompanyId" : $("#companyName").val()
				, "modUserId" : "${userId}"
		});
	}
	
	function actInsert(data){
		$.ajax({
			url : "${contextPath}/mng/cmm/company/"+(data.gbn=="pop"?"insert":"update"),
			dataType : "JSON",
			type : "POST",
			data : data,
			success : function(req) {
				if(req != ""){
					if(data.gbn == "pop"){
						$("#modal-dialog-copy").modal('hide');
						actCompanylist(req.companyId);
						if(req.errorCode == "1"){
							alertBox3("등록되었습니다.");
						}else{
							alertBox3("등록에 실패하였습니다.");
						}
					}else{
						if(req == "1"){
							alertBox("수정되었습니다.", moveListPage);
						}else{
							alertBox3("수정에 실패하였습니다.");
						}
					}
				}else{
					$("#modal-dialog-copy").modal('hide');
					alertBox3("예외 오류가 발생되었습니다.");
				}
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			} 
		});
	}
	
	
	$(document).ready(function() {
		App.init();
		getDetail();
		
		//메뉴활성화
		$("#operation").addClass("active");
		$("#cmmCompany").addClass("active");
	});
</script>
</body>
</html>