<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
</sec:authorize>
<sec:authorize var="isPM" access="hasRole('ROLE_CUSTOM_PM')" />

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

		<!-- begin #page-container -->
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
			<!-- begin #header -->
			<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->

			<!-- begin #sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #content (페이지 바디 컨텐츠 시작입니다)-->
			<div id="content" class="content">

				<p class="page_title">프로젝트 상세
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/req/project/projectList.do"> 프로젝트 </a> <span class="arrow_ab"> &#8227; </span> 프로젝트 현황(신청)  <span class="arrow_ab"> &#8227; </span>  <b> 프로젝트 상세 </b>
			    </span>
				</p>

				<!-- begin page-body -->
				 <div class="row p20 bgwh br10">
					<input type="hidden" name="projectBoxId" id="projectBoxId" value="${getOkProjectView.projectBoxId}" />
				<%-- <table class="tableH4">
            		<colgroup>
            			<col width="10%"/>
            			<col width="15%"/>
            			<col width="10%"/>
            			<col width="18%"/>
            			<col width="10%"/>
            			<col width="12%"/>
            			<col width="10%"/>
            			<col width="*"/>
            		</colgroup>
            		<tbody>
            		 <tr>
            				<th colspan="8" class="f18"><span class="pid" id="projectAlias">${getOkProjectView.projectName}</span>
            				<h3 class="pname dpin ml20" id="projectName">${getOkProjectView.projectAlias}</h3></th>
            			</tr>
            			<tr>
            				<td class="point tac">본부</td>
            				<td>${fn:split(getOkProjectView.deptName2,'/')[1]}</td>
            				<td class="point tac">처(실)</td>
            				<td>${fn:split(getOkProjectView.deptName2,'/')[2]}</td>
            				<td class="point tac">부서</td>
            				<td colspan="3">${fn:split(getOkProjectView.deptName2,'/')[3]}</td>
            			</tr>
            			<tr>
            				<td class="point tac">프로젝트 비용 </td>
            				<td id="projectPrice" colspan="3"><fmt:formatNumber value="${getOkProjectView.projectPrice}" pattern="#,###"/> 천원 </td>
            				<td class="point tac">프로젝트 기간 </td>
            				<td colspan="3"><span id ="projectStartDatetime">${getOkProjectView.projectStartDatetime}</span> ~ <span id ="projectEndDatetime">${getOkProjectView.projectEndDatetime}</span></td>
            			</tr>
            			<tr>
            				<td class="point tac">프로젝트 내용</td>
            				<td colspan="7"><%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>
					         <p>${fn:replace(getOkProjectView.description, newLineChar,br)} </p> </td>
            			</tr>
            			<tr>
            				<td class="point tac">첨부파일 </td>
            				<td colspan="7">
            				    	<!-- 첨부파일 시작 -->
								<div class="fileList">
								<div class="wrap">
									<ul class="m-t-10">
										<c:forEach items="${file}" var="filelist" varStatus="status" >
											<li>
												<span class="f14 fc11">${filelist.fileName}</span>
												<span class="f14 fc66">(${filelist.fileTranSize}) </span>
												<a href="${contextPath}/mbr/cmm/file/download/${filelist.fileId}" class="btn_download"></a>
											</li>
										</c:forEach>
									</ul>
								</div>
							</div>
					    <!-- 첨부파일 끝 -->
            				</td>
            			</tr>
            		</tbody>
            	</table>--%>

            	 <div class="col-md-12 pl0 pr0">
            	   <div class="col-md-6 pl0">
            	     <label class="f16 mb10 f500">프로젝트 ID </label>
            	     <input type="text" class="form-control"  id="projectAlias"  disabled="disabled" value="${getOkProjectView.projectName}"/>
            	   </div>
            	   <div class="col-md-6 pr0">
            	   <label class="f16 mb10 f500">프로젝트명 </label>
            	   <input type="text"  class="form-control"  id="projectName" disabled="disabled" value="${getOkProjectView.projectAlias}"/>
            	   </div>
            	   <div class="clear"></div>
            	   <div class="project_dd">
	            	    <div class="sub"  style="float:left;">
	            	       <label class="f16 mb10">본부 </label>
	            	       <input type="text"  class="form-control"  disabled="disabled"  value="${fn:split(getOkProjectView.deptName2,'/')[1]}"/>
	            	    </div>
	            	    <div class="sub">
	            	       <label class="f16 mb10">처(실) </label>
	            	       <input type="text"  class="form-control"  disabled="disabled"  value="${fn:split(getOkProjectView.deptName2,'/')[2]}"/>
            	  		</div>
            	  		<div class="sub">
	            	       <label class="f16 mb10">부서 </label>
	            	       <input type="text"  class="form-control"  disabled="disabled"  value="${fn:split(getOkProjectView.deptName2,'/')[3]}"/>
            	  		</div>
            	  		<div class="sub">
	            	       <label class="f16 mb10">프로젝트 비용 (천원)</label>
	            	       <input type="text"  class="form-control tar"  disabled="disabled"  id="projectPrice" value='<fmt:formatNumber value="${getOkProjectView.projectPrice}" pattern="#,###"/>' />
            	  		</div>
            	  		<div class="sub" style="margin-right:0;float:right;">
	            	       <label class="f16 mb10">프로젝트 기간</label>
	            	       <input type="text"  class="form-control"  disabled="disabled"   value="${getOkProjectView.projectStartDatetime} ~ ${getOkProjectView.projectEndDatetime} "/>
            	  		</div>
            	     </div>
            	     <div class="col-md-12 pl0 pr0 mt20">
            	     <label class="f16 mb10 f500">프로젝트 내용 </label>
            	      <input type="text"  class="form-control"  disabled="disabled"  value="${fn:replace(getOkProjectView.description, newLineChar,br)}"/>
            	     </div>

            	      <div class="col-md-12 p10 pl0 pr0 mt20">
            	      <div class="col-md-8 pl0">
            	       <label class="f16 mb10 f500">첨부파일 </label>
            	       <c:forEach items="${file}" var="filelist" varStatus="status" >
            	       	<div class="input-group">
            	       <input type="text"  class="form-control"  disabled="disabled"  value="${filelist.fileName} / (${filelist.fileTranSize})"/>
            	      <span class="input-group-btn">
            	       <a href="${contextPath}/mbr/cmm/file/download/${filelist.fileId}" class="btn_rect ml4"><span class="rotate-270"> &#8677; </span></a>
            	       </span>
            	      </div>
            	        </c:forEach>
            	      </div>
            	     </div>
            	   </div>

				<div class="clear"></div>
				<h2 class="sub_title mt30">클라우드 정보(IaaS) </h2>
				<table class="tableV">
					<colgroup>
						<col width="*">
						<col width="13%">
						<col width="12%">
						<col width="13%">
						<col width="12%">
					</colgroup>
					<thead>
						<tr>
							<th>클라우드</th>
							<th>가상서버 (EA)</th>
							<th>vCPU (Core)</th>
							<th>MEMORY (GB)</th>
							<th>볼륨 (GB)</th>
						</tr>
					</thead>
					<tbody>

					<c:forEach items="${cloudProjectInfo}" var="cloudProjectInfo" varStatus="status" >
							<tr>
								<td>${cloudProjectInfo.cloudName}</td>
								<td>${cloudProjectInfo.vmUsed}</td>
								<td>${cloudProjectInfo.vcpuUsed}</td>
								<td>${cloudProjectInfo.memUsed}</td>
								<td>${cloudProjectInfo.diskUsed}</td>
							</tr>
					</c:forEach>
					</tbody>
				</table>

				<h2 class="sub_title mt30">클라우드 정보(PaaS) </h2>
				<table class="tableV">
					<colgroup>
						<col width="*">
						<col width="13%">
						<col width="12%">
						<col width="13%">
						<col width="12%">
					</colgroup>
					<thead>
						<tr>
							<th>클라우드</th>
							<th>어플리케이션</th>
							<th>POD</th>
							<th>오토스케일</th>
							<th>볼륨</th>
						</tr>
					</thead>
					<tbody>

					<c:forEach items="${cloudProjectPassInfo}" var="cloudProjectInfo" varStatus="status" >
							<tr>
								<td>${cloudProjectInfo.cloudName}</td>
								<td>${cloudProjectInfo.vmUsed}</td>
								<td>${cloudProjectInfo.vcpuUsed}</td>
								<td>${cloudProjectInfo.memUsed}</td>
								<td>${cloudProjectInfo.diskUsed}</td>
							</tr>
					</c:forEach>
					</tbody>
				</table>

					<h2 class="sub_title mt30"> 관리자 정보  </h2>
							<table class="tableV">
								<colgroup>
									<col width="150px">
									<col width="150px">
									<col width="150px">
									<col width="12%">
									<col width="13%">
									<col width="12%">
									<col width="*">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th>본부</th>
										<th>처(실)</th>
										<th>부서</th>
										<th>이름(직급)</th>
										<th>사번</th>
										<th>전화번호(사선) </th>
										<th>이메일</th>
										<th>구분</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${managerList}" var="managerList" varStatus="status" >
	                                      <c:if test="${managerList.projectManagerType eq '01'}">
										  <c:set var="deptSub" value="${fn:split(managerList.deptName2,'-')}"/>
	                                      <input type='hidden' id='h_admin_id' value='${managerList.userId}' />
	                                      <tr>
											<td>${fn:split(managerList.deptName2,'/')[1]}</td>
											<td>${fn:split(managerList.deptName2,'/')[2]}</td>
											<td>${fn:split(managerList.deptName2,'/')[3]}</td>
											<td>${managerList.userName} (${managerList.userLevel})</td>
											<td>${managerList.userId}</td>
											<td>${managerList.userTel}</td>
<%-- 											<td>${managerList.userPhone}</td> --%>
											<td>${managerList.userMail}</td>
											<td>${managerList.projectManagerTypeName}</td>
										</tr>
										</c:if>
								</c:forEach>
								</tbody>
							</table>

							<h2 class="sub_title mt30">클라우드 선택 </h2>
							<div class="col-md-12 pl0 pr0">
								   <c:forEach items="${ossCloudList}" var="ossCloudList" varStatus="status" >

				                 	<c:if test="${ossCloudList.cloudType eq 'openstack'}">
				                 	 <div class="cloud_oa">
				                 	  <ul>
				  	                   <c:choose>
				                 	  	    <c:when test="${ossCloudList.projectYn eq 'Y'}">
				                 		 <h4><input type="checkbox"  class="big_check" disabled checked name ="cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
											</c:when>
									         <c:otherwise>
				                 		 <h4><input type="checkbox"  class="big_check" disabled name ="cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
									         </c:otherwise>
										</c:choose>

									 	 <li class="cdesc">${ossCloudList.content}</li>
				                 	  </ul>
								     </div>
				                 	</c:if>

				                 	<c:if test="${ossCloudList.cloudType eq 'vmware'}">
				                 	  <div class="cloud_dmz">
				                 	  <ul>
				                 	     <c:choose>
				                 	  	    <c:when test="${ossCloudList.projectYn eq 'Y'}">
				                 		 <h4><input type="checkbox"  class="big_check" disabled checked name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
											</c:when>
									         <c:otherwise>
				                 		 <h4><input type="checkbox"  class="big_check" disabled name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
									         </c:otherwise>
										</c:choose>

									 	 <li class="cdesc">${ossCloudList.content}</li>
				                 	  </ul>
								     </div>
				                 	</c:if>

				                 	<c:if test="${ossCloudList.cloudType eq 'openshift'}">
				                 	 <div class="cloud_mobile">
				                 	  <ul>
				                 		  <c:choose>
				                 	  	    <c:when test="${ossCloudList.projectYn eq 'Y'}">
				                 	  	    	<h4><input type="checkbox"  class="big_check" disabled checked name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
											</c:when>
									         <c:otherwise>
									         	  <h4><input type="checkbox"  class="big_check" disabled name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
									         </c:otherwise>
										  </c:choose>
									 	 <li class="cdesc">${ossCloudList.content}</li>
				                 	  </ul>
								     </div>
				                 	</c:if>

				                 	<c:if test="${ossCloudList.cloudType eq 'nutanix'}">
				                 	 <div class="cloud_mobile">
				                 	  <ul>

				                 	    <c:choose>
			                 	  	    <c:when test="${ossCloudList.projectYn eq 'Y'}">
			                 	  	    	<h4><input type="checkbox"  class="big_check" disabled checked name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
										</c:when>
								         <c:otherwise>
				                 		     <h4><input type="checkbox"  class="big_check" disabled name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>

								         </c:otherwise>
									  </c:choose>
									 	 <li class="cdesc">${ossCloudList.content}</li>
				                 	  </ul>
								     </div>
				                 	</c:if>
								  </c:forEach>
							</div>

						<h2 class="sub_title mt30">담당자 정보  </h2>
							<table class="tableV">
								<colgroup>
									<col width="150px">
									<col width="150px">
									<col width="150px">
									<col width="12%">
									<col width="13%">
									<col width="12%">
									<%-- <col width="13%"> --%>
									<col width="*">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th>본부</th>
										<th>처(실)</th>
										<th>부서</th>
										<th>이름(직급)</th>
										<th>사번</th>
										<th>전화번호(사선) </th>
										<!-- <th>핸드폰</th> -->
										<th>이메일</th>
										<th>구분</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${managerList}" var="managerList" varStatus="status" >
									 <c:if test="${managerList.projectManagerType ne '01'}">
									 	<tr>
											<td>${fn:split(managerList.deptName2,'/')[1]}</td>
											<td>${fn:split(managerList.deptName2,'/')[2]}</td>
											<td>${fn:split(managerList.deptName2,'/')[3]}</td>
											<td>${managerList.userName} (${managerList.userLevel})</td>
											<td>${managerList.userId}</td>
											<td>${managerList.userTel}</td>
											<%-- <td>${managerList.userPhone}</td> --%>
											<td>${managerList.userMail}</td>
											<td>${managerList.projectManagerTypeName}</td>
										</tr>
										</c:if>
								</c:forEach>
								</tbody>
							</table>

					<div class="tac mt40">
						<a type="button" class="btn_line55" onclick="moveWritePage('${getOkProjectView.projectBoxId}');">수정</a>
						<a type="button" class="btn_dgrey ml10" onclick="moveListPage();">목록</a>
					</div>

				</div>

				<!-- end page-body -->



	            <!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
			<!-- end #content -->


		</div>
		<!-- end page container -->

	<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
	<script type="text/javascript">

		function moveListPage(){
			location.href="${wasPath}/mbr/req/project/okprojectList.do";
		}

		function moveWritePage(projectBoxId){

			if('${userId}' != 'admin'){
				if( '${userId}' != $("#h_admin_id").val() ) {
					alertBox("프로젝트 관리자만 수정이 가능합니다.")
					return false;
				}
			}

			location.href = "${wasPath}/mbr/req/project/okprojectWrite.do?projectBoxId="+projectBoxId;
		}

		//프로젝트명 유효성체크
		function valchk(){
			if($("#popProjectAlias").val()==""){
				alertBox3("프로젝트명을 입력하세요");
				//$("#projectAlias").focus();
				return false;
			}
			return true;
		}

		//프로젝트명 저장
		function okProjectInsert(){

			$.ajax({
				url : "${wasPath}/mbr/req/project/okProjectModify",
				dataType : "JSON",
				type : "POST",
				data : {
					"projectBoxId" : $("#projectBoxId").val()
					, "projectAlias" : $("#popProjectAlias").val()
	// 				, "projectDescription" : $("#projectDescription").val()
				},
				success : function(data) {
					alertBox3("저장되었습니다.");
					$("#projectAliasTitle").text("");
					$("#projectAliasTitle").text($("#popProjectAlias").val());
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

			//메뉴활성화
		 	$("#project").addClass("active");
		 	$("#projectList").addClass("active");
		});
		</script>

	</body>
</html>