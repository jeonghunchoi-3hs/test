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
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
		
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>프로젝트 신청</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">작업승인처리</a><a href="#" class="on">프로젝트 신청</a>
				</div>
			</div>
			<!-- end header --> 
			<div class="row pb50">
				<div class="client_DetailBg">
					<div class="client_DetailArea">
						<h2 class="blueBoxTitle">신청내역 정보</h2>
						<input type = "hidden" id ="reqProjectSeq" value = "${getProjectView.reqProjectSeq}" >
						<p class="company_Name2"  name="projectAlias" id="projectAlias">${getProjectView.projectAlias}</p>
						<p class="company_Info m-b-25"> 
							<span class="company_labelf">구분 :</span><span class="company_cont" id="upCompanyName">${getProjectView.upCompanyName }</span>
							<span class="company_label">고객사 :</span><span class="company_cont" id="customerName">${getProjectView.companyName }</span>
						</p>
						
						<div class="networkDetailArea">
							<h2 class="fc11 f18 fontB m-b-20">네트워크망</h2>
 							<ul> 
								<c:forEach items="${getProjectNetSlist}" var="getProjectNetSlist" varStatus="status" begin="0" step="1">	
						  			<c:if test="${status.index==0}">
						  			<li>
										<span class="blue">개발</span>
									</c:if>	
									<c:if test="${status.index==3}">
									<li>
										<span class="red">운영</span>
									</c:if>
									<c:if test="${status.index==5}">
									<li>
										<span class="purple">검증</span>
									</c:if>	
									<c:if test="${status.index==2}">
									<li>
										<span class="green">관리</span>
									</c:if>	
									<span>									
										<label class="checkbox-inline p-l-40"> 
			                            	<input type="checkbox" data-original-title="" title=""  value="${getProjectNetSlist.selectFlag}" name="network" id="${getProjectNetSlist.netDfltKind}" disabled="disabled"> ${getProjectNetSlist.netDfltKindName}
			                            </label>
		                            </span>
		                            <c:if test="${status.index==1}">
									</li>
									</c:if>	
									<c:if test="${status.index==4}">
									</li>
									</c:if>
									<c:if test="${status.index==6}">
									</li>
									</c:if>
									<c:if test="${status.index==2}">
									<td></td>
									</li>
									</c:if>		                            
								</c:forEach>
							</ul>
							<textarea rows="2" placeholder="추가 네트워크망 없음" name="networkEtc" id="networkEtc" style="width: 100%; height: 100px; margin-top: 8px; margin-bottom: 20px; " disabled>${getProjectView.networkEtc}</textarea>
						</div>
						<p class="networkDescription" name="projectDescription" id="projectDescription">${getProjectView.projectDescription}</p>
						<div class="manager_Info">
							<h2>신청자정보</h2>
							<div id="adminArea">
							<div class="mt15"> 
								<span class="manager_Name" id="regUserId">${userVo.userName}</span>
							</div>
							<div class="mt10"> 
								<span class="manager_Phone" style="margin-left: 0px;" id="userPhone">${userVo.userPhone}</span>
								<span class="manager_Mail" id="userMail">${userVo.userMail}</span>
								<span class="manager_Date"id="regDatetime">${userVo.regDatetime}</span>  
								<c:if test="${getProjectView.length eq 0 and getProjectView.completeFlag eq 'N'}">
						 		</c:if>
							 	<c:if test="${getProjectView.length ne 0 and getProjectView.completeFlag eq 'N'}">
							 		<textarea class="" rows="2" placeholder="작업처리내역을 입력하세요" name="closeDescription" id="closeDescription" style="width: 100%; height: 100px; margin-top: 15px;">${getProjectView.closeDescription}</textarea>
							 	</c:if>
							</div>
							</div>
						</div>
					</div>
				
				</div>

			<c:if test="${getProjectView.completeFlag eq 'N'}">
				<!-- begin page-body -->
				<div class="row m-t-40" id='divProject'>
					<h2 class="titleBuType01 mb15">프로젝트 등록</h2>
					<div class="formType01">
						<div class="tblWrap clearfix">
							<input type="hidden" id="hid_projectId" value="c0faf13b33d242e1a2213ce61c348abe" data-original-title="" title="">
							<input type="hidden" id="hid_projectName" value="" data-original-title="" title="">
							<table>
								<colgroup>
									 <col width="173px">
									 <col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><strong>프로젝트ID</strong></th>
									  	<td>
									 		<input type="hidden" id="confirmFlag" value="N"/>
									  		<input type="text" style="width:626px; margin-right: 5px" id="oss_projectName" value="${userVo.customerId}_"/>
									  		<a type='button' class="btnType04" style="width:100px;" onclick="projectNameChk();"><span class="txt">중복확인</span></a>
									  	</td>									  	
									</tr>
									<tr>
										<th scope="row"><strong>프로젝트명</strong></th>
									  	<td><span id="oss_projectAlias">${getProjectView.projectAlias}</span></td>
									  	<input type ="hidden" id ="hid_oss_projectAlias" value = "${getProjectView.projectAlias}"	>								  	
									</tr>	 								
									<tr>
										<th scope="row"><strong>설명</strong></th>
									  	<td><textarea style="width:100%; height: 200px" name="description" id="description" maxlength="40"></textarea></td>									  	
									</tr>
								</tbody>
							</table>
						</div>
					</div>
	                	 
				</div>
				<!-- end page-body -->	
			</c:if>
			 
			<div class="row tac m-t-40">	
			    <!-- end section-container -->	   
				<!-- begin button----------->
				 <div class="row tac">
				 	<c:if test="${getProjectView.length eq 0 and getProjectView.completeFlag eq 'N'}">
			 			<a type='button' id="btnModify" class="btnType03 btnType03_Pinstert mr20" onclick="actInsert()">프로젝트 등록</a>
			 		</c:if>
			 	
				 	<c:if test="${getProjectView.length ne 0 and getProjectView.completeFlag eq 'N'}">
				 		<a type='button' class="btnType03 type03_2 btnType03_submit mr20" onclick="projectWorkComplete()">작업완료</a>
				 	</c:if>
					<a type='button' class="btnType03 btnType03_list" onclick="moveListPage();">목록</a>                    
                 </div> 
				<!-- end button----------->
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
		
		// 프로젝트 신청정보 조회
		function projectDetail() {
			var reqProjectSeq = $("#reqProjectSeq").val();
			$.ajax({
				url : "${contextPath}/mng/req/project/projectWorkCompleteInfo",
				dataType : "JSON",
				type : "POST",
				data : {
					"reqProjectSeq": reqProjectSeq
				},
				success : function(data) {
				//	moveListPage();
				},
				error : function(request, status, error) {
					alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
				}
			});	
		}
		
		
		// 작업완료 처리
		function projectWorkComplete(){
			confirmBox("완료처리 하시겠습니까?", ajaxProjectWorkComplete)
		}
		function ajaxProjectWorkComplete(){
			$.ajax({
				url : "${contextPath}/mng/req/project/projectWorkComplete",
				dataType : "JSON",
				type : "POST",
				data : {
					"reqProjectSeq": "${getProjectView.reqProjectSeq}"
					, "closeDescription": $("#closeDescription").val()
					, "projectAlias": "${getProjectView.projectAlias}"
					, "projectManagerId": "${getProjectView.projectManagerId}"
					, "receiverId": "${userVo.userId}"
					, "receiverName": "${userVo.userName}" 
					, "receiverMail": "${userVo.userMail}"
					, "regUserId"	: "${userId}"
					, "modUserId"	: "${userId}"
				},
				success : function(data) {
					alertBox("완료처리 되었습니다.",workComplate);
					//location.href = "${contextPath}/mng/oss/project/";
				},
				error : function(request, status, error) {
					//if(request.status=="200"){
					//	alertBox("재로그인  필요.",actReqProjectUpdate);
					//}
					alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
				}
			});	
		}
		
		function workComplate(){
			location.href = "${contextPath}/mng/oss/project/";
		}
		
		function valchk(){
			if($("#projectDescription").val()==""){
				alertBox3("작업처리내역을 입력하세요");
				$("#projectDescription").focus();
				return false;
			}
			return true;
		}
		
		// 체크박스 값 세팅
		function setNetworkVal(){
			$("input:checkbox[name='network']").each(function(){
				if($(this).val()=="Y"){
					$(this).attr("checked",true);
				}
			});
		}
		
		function moveListPage(){
			location.href="${contextPath}/mng/req/project/";
		}
		
		
		// 유효성 체크
		function validationChk(){
			if($("#oss_projectName").val() == ""){
				alertBox3("프로젝트명을 입력하세요.");
				$("#oss_projectName").focus();
				return false;
			}
			if($("#confirmFlag").val() == "N"){
				alertBox3("프로젝트명 중복을 확인하세요.");
				return false;
			}
			
			var ossProjectAlias = $("#hid_oss_projectAlias").val();
			/* if(ossProjectAlias.replace(/ /gi, "") == ""){
				alertBox3("프로젝트 별칭을 입력하세요.");
				$("#oss_projectAlias").focus();
				return false;
			} */
			return true;
		}
		
		// 프로젝트 등록
		function actInsert() {
		
		 	if(validationChk()){
				
				$.ajax({
					url : "${contextPath}/mng/oss/project/insert",
					dataType : "JSON",
					type : "POST",
					data : {
						"regUserId" 		: "${userId}"
						, "modUserId" 		: "${userId}"
						, "customerId" 		: "${getProjectView.customerId}"
						, "projectManagerId": "${getProjectView.projectManagerId}"
						, "projectName" 	: strTrim($("#oss_projectName").val())
						, "projectAlias" 	: strTrim($("#hid_oss_projectAlias").val())
						, "description" 	: $("#oss_description").val()
						, reqProjectSeq		: "${reqProjectSeq}"
					},
					success : function(data) {
		 				if(data.error == 1){
		 					$("#h_projectId").val(data.projectId);
		 					$("#h_projectName").val(data.projectName);
		 					reqProjectUpdate(data.projectId);
						}else{
							alertBox3("등록실패");
						}
					},
					error : function(request, status, error) {
						alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
					}
				});
			} 
		}
		
		function reqProjectUpdate(projectId){
			$.ajax({
				url : "${contextPath}/mng/req/project/updateProject",
				dataType : "JSON",
				type : "POST",
				data : {
					"regUserId" 		: "${userId}"
					, "modUserId" 		: "${userId}"
					, "projectId" 		: projectId
					, "reqProjectSeq"	: "${reqProjectSeq}"
				},	
				success : function(data) {
	 				if(data == 1){
	 					//confirmBox2("프로젝트 등록이 완료되었습니다.",actReqProjectUpdate);
	 					alertBox("프로젝트 등록이 완료되었습니다.",actReqProjectUpdate);
					}else{
						alertBox3("등록실패");
					}
				},
				error : function(request, status, error) {
					alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
				}
			});			
		}
		
		function actReqProjectUpdate(e){
			//if(e){
			//	moveDetailPage();
			//}else{
				location.reload();
			//}
		}
		
		function moveDetailPage(){
			var params = "?projectId="+$("#h_projectId").val();
			params += "&projectName="+$("#h_projectName").val();
			location.href = "${contextPath}/mng/oss/project/view"+params;
		}
		
		//프로젝트 영문명 중복체크
		function projectNameChk(){
			
			if($("#oss_projectName").val()==""){
				alertBox3("프로젝트 영문명을 입력하세요");
				return;
			}
			
			$.ajax({
				url : "${contextPath}/mng/oss/project/projectNameChk",
				data : {
					"projectName" : $("#oss_projectName").val()
				},
				success : function(data) {
					var chkVal = data;
					if(chkVal==0){
						$("#confirmMsg").css("color","blue");
						$("#confirmFlag").val("Y");
						alertBox3("사용가능한 프로젝트 영문명 입니다.");
						
					}else{
						$("#confirmMsg").css("color","#ff0000");
						$("#confirmFlag").val("N");
						alertBox3("사용할 수 없는 프로젝트 영문명 입니다.");
						
					}
				},
				error : function(request, status, error) {
					alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
				}
			});
			
		}
		
		
		// 팝업메시지 세팅	
// 		function alertModal(txt){
// 			$("#confirmMsg").text(txt);
// 			$("#message-modal-dialog").modal();
// 		}
		
		// 팝업메시지 세팅	
		function alertModal(txt, fn){
			$("#confirmMsg").text(txt);
			$("#setBtn").html("");
			
			if(fn==""||fn=="undefined"){
				var vHtml = "";
				vHtml = '<a type="button" class="btn width-100 btn-grey" data-dismiss="modal">닫기</a>';
				$("#setBtn").html(vHtml);
			}else{
				var vHtml = "";
				vHtml = '<a type="button" class="btn width-100 btn-grey" data-dismiss="modal" onclick="'+fn+'">닫기</a>';
				$("#setBtn").html(vHtml);
			}
			
			$("#message-modal-dialog").modal({backdrop:'static'});
		}	
		
		function strTrim(str){
			return str.replace(/(^\s*)|(\s*$)/g, "");
		}
		
		$(document).ready(function() {
		    App.init();
		  //  projectDetail();
		    if("${getProjectView.projectId}" != ""){
		    	$("#divProject").hide();
		    }else{
		    	$("#divNetwork").hide();
		    }
		    
			$("#oss_projectName").on('keyup',function(e){
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
	 			
			$("#oss_projectName").on('blur',function(e){
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
		    
		    
			$("a>button").on('click',function(){
			location.href = $(this).closest("a").attr("href");
			});

			//메뉴활성화
			$("#request").addClass("active");
			$("#reqProject").addClass("active");
			
			setNetworkVal();
			
			//프로젝트영문명 입력시 중복체크 flag
			$("#oss_projectName").keypress(function(){
				$("#confirmFlag").val("N"); 
			});
		
		});
		
	</script>
	</body>
</html>