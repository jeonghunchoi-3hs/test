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
	<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>
	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin header -->
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 프로젝트 신청 현황 <span class="root">콘솔 > 프로젝트 > 프로젝트 신청 현황</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			 <div class="row mb50">
			
			<h5 class="ml60">ㆍ프로젝트 신청 정보</h5>	
			
			<!-- begin section-container -->		  
			<div class="section-container inbox">	

			<!-- 테이블시작 -->
			<div class="tableB">
									<table>
									<colgroup>
										<col width="30%">
										<col width="70%">
									</colgroup>
									<tbody>
										<tr>
											<td class="cen th20">회원사 명</td>
												<td>
													<div class="col-md-6">
													<p class="form-control-static f14 fb lh34 p0" id="customerId"></p>
													</div>
												</td>
										</tr>
										<tr>
											<td class="cen th20">프로젝트코드</td>
												<td>
													<div class="col-md-6" >
														<p class="form-control-static f14 fb lh34 p0" id="projectName"></p>
													</div>
												</td>
										</tr>
										<tr>
											<td class="cen th20">프로젝트명</td>
												<td>
													<div class="col-md-6">
														<p class="form-control-static f14 fb lh34 p0" id="projectAlias"></p>
													</div>
												</td>
										</tr>
										<tr>
											<td class="cen th20">네트워크망</td>
												<td>
													<div class="col-md-6" >
												<c:forEach items="${code}" var="codelist" varStatus="status" >											
												<c:set value="" var="chkvalue"/>
														<c:forEach items="${getProjectNetSlist}" var="getProjectNetSlist" varStatus="netstatus" >													
							                                	<c:if test='${getProjectNetSlist.netDfltKind eq codelist.codeId}'>
																	<p class="form-control-static f14 fb lh34 p0" id="projectNetSlist"><c:out value="${codelist.codeName}"/></p>
							                                	</c:if>
														</c:forEach>
												</c:forEach>							
													</div> 
												</td>
										</tr>
										<tr>
											<td class="cen th20">설명</td> 
												<td>
													<div class="col-md-6" >
													<p class="form-control-static f14 fb lh34 p0" id="projectDescription"></p>
													</div>
												</td>
										</tr>
									</tbody>
								</table>
						</div>
				</div>			
			</div>
			<!-- 테이블 끝 -->			
			
				 <!----승인정보 box 시작------->
			 <input type="hidden" id="reqProjectSeq" value="${reqProjectSeq}">
			 <input type="hidden" id="userId" value="${userId}">
			 <input type="hidden" id="reqProjectSeq" value="${detail.reqProjectSeq}">
		     <input type="hidden" id="requestType" value="${detail.requestType}">
		     <input type="hidden" id="projectId" value="${detail.projectId}">
			 <h5 class="ml60 mt20">ㆍ승인정보</h5>
			 <div class="section-container mb50">
			  <div class="col-md-12"> 
			    <c:set value="승인 처리중" var="apprvState1"/>
				<c:set value="승인 완료" var="apprvState2"/>
				<c:set value="승인 반려" var="apprvState3"/>
				<c:set value="승인 대기" var="apprvState4"/>
				<c:set value="btn btn-lime width-100 mt10" var="apprvStatestyle"/>
			    <div class="col-md-1"></div> 
		    	<c:forEach items="${getProjectAppSteplist}" var="getProjectAppSteplist" varStatus="status" >		  
					<%-- <c:forEach items="${approval}" var="app" varStatus="status" > --%>
			   			<div class="col-md-2 box1 tac"> 
							<li class="f18 pb10"><c:out value="${getProjectAppSteplist.stepLevel}"></c:out>차 승인자</li>
							<c:forEach items="${approvalUserId}" var="approvalUserId" varStatus="status1" >
								<c:if test="${getProjectAppSteplist.stepId == approvalUserId.stepId}">
									<c:set value="${approvalUserId.userId}" var="stepId"  />
										<!-- 
										마우스 오버시 보여주게 하면됨.
										<c:out value="${approvalUserId.userId}"></c:out>
										-->		
									<c:set value="${getProjectAppSteplist.stepLevel}" var="stepLevel"/>
									</c:if>  
							</c:forEach>
							<li class="f14 fb"><c:out value="${getProjectAppSteplist.stepName}"></c:out>	 
					   <p>  
					   		<c:choose> 
					   			<c:when test="${getProjectAppSteplist.apprvState eq 'APPRV_PROCESSING'}">	
					   			 	<p class="${apprvStatestyle}">				   				
										<c:out value="${apprvState1}" />
										<c:if test="${status.last eq 'false'}">
											<c:set value="승인 대기" var="apprvState1"/>
									   		<c:set value="승인 대기" var="apprvState2"/>
									   		<c:set value="승인 대기" var="apprvState3"/>
									   		<c:set value="승인 대기" var="apprvState4"/>
									   		<c:set value="btn btn-grey width-80 mt10" var="apprvStatestyle"/>
										</c:if>
									 </p> 
								</c:when> 
								<c:when test="${getProjectAppSteplist.apprvState eq 'APPRV_COMPLETED'}">
									<button type="submit" class="${apprvStatestyle}" >
										<c:out value="${apprvState2}" />
									</button>
								</c:when>
								<c:when test="${getProjectAppSteplist.apprvState eq 'APPRV_REJECTED'}">
									<button type="submit" class="${apprvStatestyle}" >
										<c:out value="${apprvState3}" />
									</button>									
								</c:when>
								<c:otherwise>
									<button type="submit" class="${apprvStatestyle}">
										<c:out value="${apprvState4}" />
									</button>									
								</c:otherwise>
							</c:choose>				   		
					   </p>
					   </li>	
					   </div>
		   					<c:if test="${status.last eq 'false'}">
								<div class="col-md-2 tac"><i class="fa fa-chevron-right f50 arrow1 mt30"></i></div>
							</c:if>								
							</c:forEach>
						 </div>
							<div class="col-md-1"></div> 
							
			 <!----승인정보 box 끝----->
			<div class="clear"></div>
				<c:forEach items="${getProjectAppSteplist}" var="getProjectAppSteplist" varStatus="status" >
					<c:forEach items="${approvalUserId}" var="approvalUserId" varStatus="status1" >
						<c:if test="${getProjectAppSteplist.stepId == approvalUserId.stepId}">
							<c:if test="${approvalUserId.userId == userId and getProjectAppSteplist.apprvState eq 'APPRV_PROCESSING'}">
							<h5 class="ml60 mt20">ㆍ비고</h5> 
							<div class="section-container inbox tac">
								<textarea class="form-control" rows="10" placeholder="비고란 입니다. 내용을 입력하세요" name="apprvDescription" id="apprvDescription"></textarea>
								<c:choose>
										<c:when test="${getProjectAppSteplist.rightStepId == '*'}">
											<c:choose> 
												<c:when test="${detail.requestType == 'REQTYPE_EXPR'}">
													<!--  
													<div class="col-md-1"><input type="button" class="btn btn-grey w-80" value="해지 승인" onclick="exprProjectApprv('${getProjectAppSteplist.stepLevel}','${requestSeq }','${getProjectAppSteplist.rightStepId}')"></div>
													-->
													
													<button type="button" class="btn btn-primary width-80 mt10" onclick="exprProjectApprv('${getProjectAppSteplist.stepLevel}','${reqProjectSeq }','${getProjectAppSteplist.rightStepId}')">승인</button> 
													<button type="button" class="btn btn-primary width-80 mt10" onclick="projectRejected('${getProjectAppSteplist.stepLevel}','${reqProjectSeq }','${getProjectAppSteplist.rightStepId}')">미승인</button>
													<button type="button" class="btn btn-primary width-80 mt10" onclick="moveListPage()">목록</button>
													  
												</c:when>
												<c:when test="${detail.requestType == 'REQTYPE_NEW'}">
												<!--  
													<div class="col-md-1"><input type="button" class="btn btn-grey w-80" value="신규 승인" onclick="newProjectApprv('${getProjectAppSteplist.stepLevel}','${requestSeq }','${getProjectAppSteplist.rightStepId}')"></div>
												-->
													
													<button type="button" class="btn btn-primary width-80 mt10" onclick="newProjectApprv('${getProjectAppSteplist.stepLevel}','${reqProjectSeq }','${getProjectAppSteplist.rightStepId}')">승인</button> 
													<button type="button" class="btn btn-primary width-80 mt10" onclick="projectRejected('${getProjectAppSteplist.stepLevel}','${reqProjectSeq }','${getProjectAppSteplist.rightStepId}')">미승인</button>
													<button type="button" class="btn btn-primary width-80 mt10" onclick="moveListPage()">목록</button>
																										
												</c:when>
											</c:choose>
										</c:when>
										<c:otherwise>  
<%-- 											<div><input type="button" class="btn btn-primary width-80 mt10" value="승인" onclick="projectApprving('${getProjectAppSteplist.stepLevel}','${requestSeq }','${getProjectAppSteplist.rightStepId}')"></div>
											<div><input type="button" class="btn btn-primary width-80 mt10" value="미승인" onclick="projectApprving('${getProjectAppSteplist.stepLevel}','${requestSeq }','${getProjectAppSteplist.rightStepId}')"></div>
											<div><input type="button" class="btn btn-primary width-80 mt10" value="목록" onclick="moveListPage()"></div> --%>
											<button type="button" class="btn btn-primary width-80 mt10" onclick="projectApprving('${getProjectAppSteplist.stepLevel}','${reqProjectSeq }','${getProjectAppSteplist.rightStepId}')">승인</button>
											<button type="button" class="btn btn-primary width-80 mt10" onclick="projectRejected('${getProjectAppSteplist.stepLevel}','${reqProjectSeq }','${getProjectAppSteplist.rightStepId}')">미승인</button>
											<button type="button" class="btn btn-primary width-80 mt10" onclick="moveListPage()">목록</button>
										</c:otherwise> 
								</c:choose> 
							</div>
							</c:if>
							<c:if test="${getProjectAppSteplist.apprvState eq 'APPRV_REJECTED'}" >
								<h5 class="ml60 mt20">ㆍ미승인 사유</h5> 
								<div class="section-container inbox tac">
								<textarea class="form-control" rows="10" placeholder="비고란 입니다. 내용을 입력하세요" id="rejectedApprvDescription" name="rejectedApprvDescription" readonly >${getProjectAppSteplist.apprvDescription}</textarea> 
								</div>
							</c:if>
						</c:if>
					</c:forEach>
				</c:forEach>
			<!-- 테이블 끝 -->
			</div> 
			    <!-- end section-container -->	   
				<!-- begin button----------->
				 <div class="row tac mt20">
				 	<input type="button" value="목록" onclick="moveListPage();" class="btn btn-primary width-80" />                           
                 </div>
				<!-- end button----------->
				
<!-- 			</div> -->
			<!-- end page-body -->
			
			
			<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">중복체크</h4>
	                       </div>
	                       <div class="modal-body">
	                           <h5>프로젝트 영문명을 입력해주세요 ${namechktext}</h5>
	                           <p class="m-b-20">
	                              <input type="text" id="_projectName"/>
	                              <input type="button" onclick="projectIdCheck();" value="확인">
	                           </p>
	                           <div id="checkMsg" style="color: red"></div>
	
	                       	</div>
	                       	<div class="modal-footer tac">
	                       		<div id="enableId" style="display: none;">
		                        	<a type="button" class="btn width-100 btn-primary" onclick="setId();">적용</a>
									<a type="button" class="btn width-100 btn-default" data-dismiss="modal" onclick="initModal();">닫기</a>
	                           	</div>
								<div id="unableId" style="display: block;">
									<a type="button" class="btn width-100 btn-default" data-dismiss="modal" onclick="initModal();">닫기</a>
								</div>

	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
			
			
            <!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->
		
	
	</div>
	<!-- end page container -->
	
</body> 

<script type="text/javascript">
		
 		
		//pho 상세 불러오기
		function customerDetail(reqProjectSeq) {
			$.ajax({
				url : "detail",
				dataType : "JSON",
	 			type : "POST",
				data : {
					"reqProjectSeq" : reqProjectSeq
				},
				success : function(data) {
					var result = data;
					setData(result);
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
	
		}
		function setData(result){
			 $("#projectName").text(result.projectName);
			$("#projectAlias").text(result.projectAlias);
			$("#projectDescription").text(result.projectDescription);
			$("#customerId").text(result.customerId);
			$("#apprvDescription").text(result.rejectedApprvDescription);
			
		}
		//승인 버튼 누를시
		function projectApprving(stepLevel,requestSeq,rightStepId) {
			if(confirm("승인 처리 하시겠습니까?")){
			var jsonData = setJsonData();
			$.ajax({
				url : "stepUpdate",
				dataType : "JSON",
				type : "POST",
				data : {
					"requestSeq" : requestSeq
					,"stepLevel" :stepLevel
					,"rightStepId":rightStepId
					,"apprvDescription":$("#apprvDescription").val()
				},
				success : function(data) {
					var result = data;
					if(result==1){
						alert("승인 처리가 완료 되었습니다. 승인 처리 내용이 신청 담당자한테 메일, SMS를 통해서 전달되었습니다.");
						moveViewPage();
					}else{
						//alert("fail!!");
						moveViewPage();
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
			}
		}	
		//미승인 버튼 누를시
		function projectRejected(stepLevel,requestSeq,rightStepId) {
		if($("#apprvDescription").val()==""){ 
			alert("미승인 처리 시 미승인 사유를 입력 하여 주십시오");
			$("#apprvDescription").focus();
			return false;
		}
		if($("#apprvDescription").val()=="-"){
			alert("미승인 처리 시 미승인 사유를 입력 하여 주십시오");
			$("#apprvDescription").focus();
			return false;
		}
		var jsonData = setJsonData();
		$.ajax({
			url : "rejectedUpdate",
			dataType : "JSON",
//			type : "POST",
			data : {
				"requestSeq" : requestSeq
				,"stepLevel" :stepLevel
				,"apprvDescription":$("#apprvDescription").val()
			},
			success : function(data) {
				var result = data;
				if(result==1){
					//alert("success!!");
					moveViewPage();
				}else{
					//alert("fail!!");
					moveViewPage();
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		})

	}			
		// 목록 페이지이동
		function moveViewPage(){
			location.reload();
		}
		
		// 목록 페이지이동
		function moveListPage(){
			location.href = "${contextPath}/mbr/req/project/projectStatusListPage";
		}
		//마지막 승인 버튼 누를시
		function lastCustomerApprving(stepLevel,requestSeq,rightStepId) {
		var jsonData = setJsonData();
		
		$.ajax({
			url : "stepUpdate",
			dataType : "JSON",
//			type : "POST",
			data : {
				"requestSeq" : requestSeq
				,"stepLevel" :stepLevel
				,"rightStepId":rightStepId
				,"apprvDescription":$("#apprvDescription").val()
			},
			success : function(data) {
				var result = data;
				if(result==1){
					alert("승인 처리가 완료 되었습니다. 승인 처리 내용이 신청 담당자한테 메일, SMS를 통해서 전달되었습니다.");
					moveViewPage();
				}else{
					//alert("fail!!");
					moveViewPage();
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		})
	}		
		//신규 마지막 승인 버튼 누를시
		function newProjectApprv(stepLevel,requestSeq,rightStepId) {
			if(confirm("승인 처리 하시겠습니까?")){
			var jsonData = setJsonData();
			$.ajax({
				url : "insert",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					var result = data;
					if(result==1){
						//alert("success!!");
						alert("승인 처리가 완료 되었습니다. 승인 처리 내용이 신청 담당자한테 메일, SMS를 통해서 전달되었습니다.");
						lastCustomerApprving(stepLevel,requestSeq,rightStepId);
						moveViewPage();
					}else{
						//alert("fail!!");
						moveViewPage();
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
			}
		}	

		//해지 마지막 승인 버튼 누를시
		function exprProjectApprv(stepLevel,requestSeq,rightStepId) {
			if(confirm("승인 처리 하시겠습니까?")){
			var jsonData = setJsonData();
			$.ajax({
				url : "update",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					var result = data;
					if(result==1){
						//alert("success!!");
						alert("승인 처리가 완료 되었습니다. 승인 처리 내용이 신청 담당자한테 메일, SMS를 통해서 전달되었습니다.");
						lastCustomerApprving(stepLevel,requestSeq,rightStepId);
						moveViewPage();
					}else{
						//alert("fail!!");
						moveViewPage();
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
			}
		}	
		function setJsonData(){
			var jsonData = {
					"reqProjectSeq" : $("#reqProjectSeq").val()
					, "projectName": $("#projectName").text()           
					, "projectAlias": $("#projectAlias").text()                
					, "projectDescription":$("#projectDescription").text()
					, "customerId":$("#customerId").text()
					,"projectId" : $("#projectId").val()
					,"requestType" : $("#requestType").val()
					, "apprvDescription" : $("#apprvDescription").val()
					}; 
			return jsonData;
		}
	
		
		
		
		
		$(document).ready(function() {
		    customerDetail("${reqProjectSeq}");
		    
			App.init();
			
			//메뉴활성화
			$("#reqStatus").addClass("active");
			$("#projectReqStatus").addClass("active");
		    
		});		
	</script>
	

</html>