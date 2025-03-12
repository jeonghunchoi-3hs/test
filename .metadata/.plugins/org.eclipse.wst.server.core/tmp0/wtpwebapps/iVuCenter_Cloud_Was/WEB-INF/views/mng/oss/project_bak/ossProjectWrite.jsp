<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
			<!-- begin page-header -->
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 프로젝트 관리 <span class="root">프로젝트 관리</span></h1>
			<!-- end page-header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<!-- begin col-12 -->
				<div class="section-container inbox">
					<!-- begin panel -->
						<!-- begin normal input table---------->
						<div class="tableB">
						<input type="hidden" id="hid_projectId" value="${projectId}">
						<input type="hidden" id="hid_projectName" value="${projectName}">
							<table>
							 	<colgroup>
							 		<col width="150px">
							 		<col width="*">
							 	</colgroup>
								
								<tbody>
									<tr>
										<td class="left-b"><span style="color:red;">* </span>회원사</td>
									  	<td>
											<div class="col-md-12">
												<select class="form-control pb6" name="customerId" id="customerId">
													<c:forEach items="${customerlist}" var="customerlist" varStatus="status" >
														<option value="${customerlist.customerId}">${customerlist.customerName}</option>
													</c:forEach>
												</select>												
											</div>
									  	</td>
									</tr>
									<tr>
										<td class="left-b"><span style="color:red;">* </span>프로젝트 명</td>
									  	<td colspan="3">
										 	<div class="col-md-8">
										  		<input type="hidden" id="confirmFlag" value="Y"/> 
										  		<input type="hidden" class="form-control" id="projectNameOrg"/>
										  		<input type="text" class="form-control" id="projectName"/>
											</div>
											<div>
												<button type="button" class="btn btn-grey_04 dpin" onclick="projectNameChk();">중복확인</button>
											</div>
									  	</td>									  	
									</tr>
									<tr>
										<td class="left-b"><span style="color:red;">* </span>프로젝트별칭</td>
									  	<td colspan="3">
										 	<div class="col-md-12">
										  		<input type="text" class="form-control" id="projectAlias"/>
											</div>
									  	</td>									  	
									</tr>
									<tr>
										<td class="left-b">설명</td>
									  	<td colspan="3">
										 	<div class="col-md-12">
										  		<textarea class="form-control" rows="15" id="description" placeholder="내용을 입력하세요" ></textarea>
										  </div>
									  	</td>									  	
									</tr>																		
								</tbody>
							</table>	
						</div>
						<!-- end normal input table---------->
					<!-- end panel -->
				</div>
                <!-- end col-12 -->	

				<!-- begin button-->
				<div class="row tac mt20">
					<input type="button" id="btnModify" value="저장" class="btn btn-primary width-80" onclick="actInsert()">
			        <input type="button" id="btnList" value="취소" class="btn btn-grey width-80" onclick="movePage()">
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
	                           <h4 class="modal-title fw">알림</h4>
	                       </div>
	                       <div class="modal-body">
	                           <h5 id="confirmMsg"></h5>
	                        </div>
	                       	<div class="modal-footer tac">
	                       		<a type='button' class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->				
							
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
		
	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
	$(document).ready(function() {
		App.init();
		
		if($("#hid_projectId").val()!=""){
			getDetail(); 
		}
		
		$("#projectName").keypress(function(e){
			$("#confirmFlag").val("N");
		});
	
		$("#projectName").on('keyup',function(e){
			var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
			if(pattern.test(this.value)){
				$(this).val(this.value.replace(pattern, ''));
			}
			
 			var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
			if(pattern2.test(this.value)){
				$(this).val(this.value.replace(pattern2, ''));
			}
			 
			
			$(this).val(this.value.toUpperCase()); 
		});
 			
		$("#projectName").on('blur',function(e){
			var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
			if(pattern.test(this.value)){
				$(this).val(this.value.replace(pattern, ''));
			}
			
 			var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
			if(pattern2.test(this.value)){
				$(this).val(this.value.replace(pattern2, ''));
			}
			
			$(this).val(this.value.toUpperCase());
		});
	});
	
	
	// 유효성 체크
	function validationChk(){
		
		if($("#customerId").val()==""){
			warningBox("회원사를 선택하세요");
			return false;
		}
		if($("#projectName").val()==""){
			warningBox("프로젝트코드를 입력하세요");
			return false;
		}
		
		if(($("#projectName").val()!=$("#projectNameOrg").val()) && $("#confirmFlag").val()=="N"){
			warningBox("프로젝트코드 중복확인을 해주세요");
			return false;
		}
		
		if($("#projectAlias").val()==""){
			warningBox("프로젝트명을 입력하세요");
			return false;
		}
		return true;
	}


	// 프로젝트 정보 저장
	function actInsert() {
		if(validationChk()){
			$.ajax({
				url : "${contextPath}/mng/oss/project/insert",
				dataType : "JSON",
				type : "POST",
				data : {
					"regUserId" 		: "${userId}"
					, "modUserId" 		: "${userId}"
					, "customerId" 		: $("#customerId").val()
					, "projectName" 	: $("#projectName").val()
					, "projectNameOrg" 	: $("#projectNameOrg").val()
					, "projectAlias" 	: $("#projectAlias").val()
					, "description" 	: $("#description").val()
					, "projectId" 		: $("#hid_projectId").val()
				},
				success : function(data) {
					if(data.error == 1){
						alertBox("저장되었습니다.", movePage);
						
						if(data.projectId!=""){
							$("#hid_projectId").val(data.projectId);
							$("#hid_projectName").val(data.projectName);
						}
					}else if(data==1){
						alertBox("저장되었습니다.", movePage);
					}else{
						alertBox("failed!!");
					}
				},
				error : function(request, status, error) {
					errorBox("code : " + request.status + "\n" + "error : " + request.responseText);
				}
			});
		}
	}
	
	
	
	// 수정시 상세 조회
	function getDetail() {
		$.ajax({
			url : "detail",
			dataType : "JSON",
			data : {
				"projectId" : $("#hid_projectId").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){
					if(val != null){
						if(i=="projectName"){
							$("#projectName").val(val);
							$("#projectNameOrg").val(val);	//수정전 프로젝트 영문명
						}else{
							$("#"+i).val(val);
						}
					}
				});
			},
			error : function(request, status, error) {
				errorBox("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	

	//프로젝트 영문명 중복체크
	function projectNameChk(){
		
		if($("#projectName").val()==""){
			warningBox("프로젝트 영문명을 입력하세요");
			return;
		}
		
		$.ajax({
			url : "projectNameChk",
			data : {
				"projectName" : $("#projectName").val()
			},
			success : function(data) {
				var chkVal = data;
				if(chkVal==0){
					$("#confirmMsg").css("color","blue");
					$("#confirmFlag").val("Y");
					alertBox("사용가능한 프로젝트 영문명 입니다.");
					$("#confirmFlag").val("Y")
				}else{
					$("#confirmMsg").css("color","#ff0000");
					$("#confirmFlag").val("N");
					alertBox("사용할 수 없는 프로젝트 영문명 입니다.");
					$("#confirmFlag").val("N")
				}
			},
			error : function(request, status, error) {
				alert("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
		
	}
	
	// 팝업메시지 세팅	
	function alertModal(txt){
		$("#confirmMsg").text(txt);
		$("#modal-dialog").modal();
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/oss/project/";
	}
	
	
	//페이지이동
	function movePage(){
		var params="";
		if($("#hid_projectId").val()==""){
			location.href = "${contextPath}/mng/oss/project/";
		}else{
			params = "?projectId="+$("#hid_projectId").val();
			params += "&projectName="+$("#projectName").val();
			location.href = "${contextPath}/mng/oss/project/view"+params;
		}
	}
	
	
</script>
</body>
</html>