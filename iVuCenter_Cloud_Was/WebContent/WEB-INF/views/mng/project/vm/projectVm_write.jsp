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
			<!-- begin page-header -->
			<div class="page_header mb30">
				<h1>기본정보</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">기본정보 관리</a>
				</div>
			</div>
			<!-- end page-header -->
			
			<!-- begin page-body -->
			<div class="row mb50">
				<div class="formType01">
					<p class="txt_guide">필수항목 입니다</p>
					<div class="tblWrap clearfix">
						<input type="hidden" id="hid_projectId" value="${req.projectId}">
						<input type="hidden" id="hid_projectName" value="${req.projectName}">
						<table>
							<colgroup>
								 <col width="173px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong class="require">고객사</strong></th>
									<td>
										<input type="text" class="m-r-5" style="width:321px;" maxlength="40">
										<input type="text" style="width:321px;" maxlength="40">
										<a type="button" class="btnType04 valignTop m-l-5" onclick="openModal();"><span class="txt"><i class="ico_search"></i>검색</span></a>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong class="require">프로젝트명</strong></th>
									<td><input type="text" style="width:100%" name="companyName" id="companyName" maxlength="40"></td>
								</tr>
								<tr>
									<th scope="row"><strong class="require">프로젝트ID</strong></th>
									<td>
										<input type="hidden" id="confirmFlag" value="Y"/> 
								  		<input type="hidden" class="form-control" id="projectNameOrg"/>
										<input type="text" style="width:626px; margin-right: 5px" name="projectName" id="projectName" maxlength="40">
										<a type="button" class="btnType04" style="width:100px;" onclick="projectNameChk();"><span class="txt">중복확인</span></a>
									</td>
									
								</tr> 
								<tr>
									<th scope="row"><strong>설명</strong></th>
									<td><textarea  style="width:100%; height: 200px" name="description" id="description" maxlength="40"></textarea></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<!-- begin button-->
			    <div class="row tac m-t-60">
		 			<a type="button" class="btnType03 btnType03_write" id="jquerybuttonok" name="jquerybuttonok" onclick="validationChk()">등록</a>
		 			<a type="button" class="btnType03 btnType03_cancel m-l-15" onclick="movePage();">취소</a>
                 </div>
				<!-- end button -->
			</div>
			<!-- end page-body -->				 
			<!-- #modal-dialog -->
                 <div class="modal fade" id="modal-dialog"> 
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">고객사 지정</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="page_searchBox m-b-15">
									<div class="searchArea">
										<div class="inputArea m-l-5">
											<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)openModal();" style="width: 362px">
											<a type="button" class="btn_search" onclick="openModal();">검색</a>
										</div>
									</div>
								</div>
								
								<div class="noneList" style="display: none;">
									 <span>검색된 사용자가 없습니다.</span>
								</div> 
								
								<!-- <div class="listArea" id="popListTable"> -->
								<div class="listArea">
									<div class="listBg">
										<span class="name2">쓰리에이치에스</span>
										<span class="idlabel2">솔루션사업부</a>
										<a class="applybtn" >적용</button>
									</div>
									<div class="listBg">
										<span class="name2">쓰리에이치에스</span>
										<span class="idlabel2">솔루션사업부</a>
										<a class="applybtn" >적용</a>
									</div>
									<div class="listBg">
										<span class="name2">쓰리에이치에스</span>
										<span class="idlabel2">솔루션사업부</a>
										<a class="applybtn" >적용</a>
									</div>
									<div class="listBg">
										<span class="name2">쓰리에이치에스</span> 
										<span class="idlabel2">솔루션사업부</a>
										<a class="applybtn" >적용</a>
									</div>
	                      		</div>
	                      		<div class="totalcnt" id="totalCnt">총 4 건</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="whiteline" data-dismiss="modal" onclick="initPopup();">닫기</a>
	                       	</div>
		               	</div>
					</div>
                 </div>				
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
		
	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
	//modal팝업 open
	function openModal(){
		$("#modal-dialog").modal();
	}
	
	// 유효성 체크
	function validationChk(){
		
		if($("#customerId").val()==""){
			alertBox3("고객사를 선택하세요");
			return false;
		}
		if($("#projectName").val()==""){
			alertBox3("프로젝트 영문명을 입력하세요");
			return false;
		}
		
		if(($("#projectName").val()!=$("#projectNameOrg").val()) && $("#confirmFlag").val()=="N"){
			alertBox3("프로젝트 영문명 중복확인을 해주세요");
			return false;
		}
		
		if($("#projectAlias").val()==""){
			alertBox3("프로젝트 별칭을 입력하세요");
			return false;
		}
		alertBox("저장하시겠습니까?", actInsert);
	}

	// 프로젝트 정보 저장
	function actInsert() {
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
						alertBox3("failed!!");
					}
				},
				error : function(request, status, error) {
					if(request.status == "200"){
						alertBox("로그인 대기시간이 종료되었습니다. <br>재로그인이 필요합니다.", reload);
					}else{
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				}
			});
	}
	
	// 수정시 상세 조회
	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/oss/project/detail",
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
				if(request.status == "200"){
					alertBox("로그인 대기시간이 종료되었습니다. <br>재로그인이 필요합니다.", reload);
				}else{
					alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
				}
			}
		});
	}
	

	//프로젝트 영문명 중복체크
	function projectNameChk(){
		
		if($("#projectName").val()==""){
			alertBox3("프로젝트 영문명을 입력하세요");
			return;
		}
		
		$.ajax({
			url : "${contextPath}/mng/oss/project/projectNameChk",
			data : {
				"projectName" : $("#projectName").val()
			},
			success : function(data) {
				var chkVal = data;
				if(chkVal==0){
					$("#confirmMsg").css("color","blue");
					$("#confirmFlag").val("Y");
					alertBox3("사용가능한 프로젝트명 입니다.");
					$("#confirmFlag").val("Y")
				}else{
					$("#confirmMsg").css("color","#ff0000");
					$("#confirmFlag").val("N");
					alertBox3("사용할 수 없는 프로젝트명 입니다.");
					$("#confirmFlag").val("N")
				}
			},
			error : function(request, status, error) {
				if(request.status == "200"){
					alertBox("로그인 대기시간이 종료되었습니다. <br>재로그인이 필요합니다.", reload);
				}else{
					alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
				}
			}
		});
		
	}
	
	function reload(){
		location.reload();
	}
	
	// 팝업메시지 세팅	
	function alertModal(txt){
		$("#confirmMsg").text(txt);
		$("#modal-dialog2").modal();
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/project/vm/";
	}
	
	
	//페이지이동
	function movePage(){
		var params="";
		if($("#hid_projectId").val()==""){
			location.href = "${contextPath}/mng/project/vm/";
		}else{
			params = "?projectId="+$("#hid_projectId").val();
			params += "&projectName="+$("#projectName").val();
			location.href = "${contextPath}/mng/project/vm/view"+params;
		}
	}
	
	$(document).ready(function() {
		App.init();
		//메뉴활성화
		$("#project").addClass("active");
		$("#ossProject").addClass("active");
		
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
</script>
</body>
</html>