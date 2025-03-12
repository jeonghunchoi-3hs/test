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
		<div id="content" class="content okprojectWrite-wrap">
			<p class="page_title">프로젝트 수정
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/req/project/projectList.do"> 프로젝트 </a> <span class="arrow_ab"> &#8227; </span> 프로젝트 현황(신청)  <span class="arrow_ab"> &#8227; </span>  <b> 프로젝트 수정 </b>
			    </span>
		    </p>

			<!-- begin page-body -->
			 <div class="row p20 bgwh br10">
				<input type="hidden" name="projectBoxId" id="projectBoxId" value="${getOkProjectView.projectBoxId}" />
				<input type="hidden" name="projectId" id="projectId" value="${getOkProjectView.projectBoxId}" />
				<input type="hidden" name="h_popAdminiStratorId" id="h_popAdminiStratorId" value="${getOkProjectView.managerId}" />
				<input type="hidden" name="reqProjectSeq" id="reqProjectSeq" value="${getOkProjectView.programSeq}" />


				<input type="hidden" name="h_popAdminiStratorName" id="h_popAdminiStratorName" value="" />
				<input type="hidden" name="h_popAdminiStratorDept" id="h_popAdminiStratorDept" value="" />
				<input type="hidden" id="h_userLevelCode" 		value="${userLevelCode}">
				<input type="hidden" id="h_cloudIds" value="" />
				<input type="hidden" id="apprvPass"	 value="${apprvPass}" />
			    <input type="hidden" id="selectApprv" value="" />


 				  <table class="tableH4">
            		<colgroup>
            			<col width="160px"/>
            			<col width="*"/>
            			<col width="160px"/>
            			<col width="*"/>
            		</colgroup>
            		<tbody>
            			<tr>
            				<td class="point">프로젝트 이름</td>
            				<td colspan="3" ><input type="text" id="projectAlias" class="form-control dpin"/></td>
            			</tr>
            			<tr>
            				<td class="point">회원사</td>
            				<td><span id="customerName">${getOkProjectView.customerName}</span> </td>
            				<td class="point">담당조직(부서) </td>
            				<td><span id="deptName">${getOkProjectView.deptName}</span></td>
            			</tr>
            			<tr>
            				<td class="point">프로젝트 비용 </td>
            				<td><input type="text" id="projectPrice" onkeyup="inputNumberWithComma(this);"  class="form-control width-100 dpin"/> 천원</td>
            				<td class="point">프로젝트 기간 </td>
            				<td>
            					<div class="flex align-center gap10">
            						<span>
									<input type="text" class="form-control width-100 dpin" id="dispSdate" name="dispSdate"/>
									</span>
									<span>~</span>
									<span>
							        <input type="text" class="form-control width-100 dpin"  id="dispEdate" />
							       	</span>
						        </div>
            				</td>
            			</tr>
            			<tr>
            				<td class="point">프로젝트 내용</td>
            				<td colspan="3"> <textarea  id="description"></textarea></td>
            			</tr>
            			<tr>
            				<td class="point">첨부파일 </td>
            				<td colspan="3">
            				<!-- 첨부파일 시작 -->
									<div class="fileList">
									<div class="wrap">

										<ul class="m-t-10">
											<c:forEach items="${file}" var="filelist" varStatus="status" >
												<li>
													<span class="f15 fc11">${filelist.fileName}</span>
													<span class="f15 fc66">(${filelist.fileTranSize})</span>
													<a href="${contextPath}/mbr/cmm/file/download/${filelist.fileId}" class="btn_download"></a>
												</li>
											</c:forEach>
										</ul>
									</div>
								</div>
						    <!-- 첨부파일 끝 -->
							</td>
            			</tr>
            			<tr>
            				<td class="point">관리자 </td>
            				<td colspan="3">
<%-- 	            				<c:set var="managerInfo" value="${getOkProjectView.managerId}/${getOkProjectView.managerName}/${getOkProjectView.managerDeptName}" /> --%>
								<div class="search-box">
		            				<c:set var="managerInfo" value="${getOkProjectView.projectAdminiStratorInfo}" />
							   		<input class="form-control dpin" type="text" name="adminiStrator" id="adminiStrator" value="${managerInfo}"  placeholder="관리자를 선택하세요" style="ime-mode:active;" readonly="readonly"/>
				               		<button type="button" class="kepco-ser-icon" onclick="openAdminiStratorModal()"></button>
				               	</div>
            				</td>
            			</tr>
            		</tbody>
            	</table>




               <%-- <div class="col-md-12 pl0 pr0">
            	   <div class="col-md-6 pl0">
            	     <label class="f16 mb10 f500">프로젝트 ID </label>
            	     <input type="text" class="form-control"  id="projectAlias"  disabled="disabled" value="${getOkProjectView.projectName}"/>
            	   </div>
            	   <div class="col-md-6 pr0">
            	   <label class="f16 mb10 f500">프로젝트명 </label>
            	   <input type="text"  class="form-control"  id="projectName"  value="${getOkProjectView.projectAlias}"/>
            	   </div>
            	   <div class="clear"></div>
            	   <div class="project_dd">
	            	    <div class="sub3"  style="float:left;">
	            	       <label class="f16 mb10">회원사 </label>
	            	       <input type="text"  class="form-control"  disabled="disabled" id="customerName" value="${getOkProjectView.customerName}"/>
	            	    </div>
	            	    <div class="sub3">
	            	       <label class="f16 mb10">담담조직(부서)</label>
	            	       <input type="text"  class="form-control"  disabled="disabled" id="deptName" value="${getOkProjectView.deptName}"/>
            	  		</div>
            	  		<div class="sub">
	            	       <label class="f16 mb10">부서 </label>
	            	       <input type="text"  class="form-control"  disabled="disabled"  value="${fn:split(getOkProjectView.deptName2,'/')[3]}"/>
            	  		</div>
            	  		<div class="sub3">
	            	       <label class="f16 mb10">프로젝트 비용 (천원)</label>
	            	       <input type="text"  class="form-control tar"   id="projectPrice" value='<fmt:formatNumber value="${getOkProjectView.projectPrice}" pattern="#,###"/>' />
            	  		</div>
            	  		<div class="sub3" style="margin-right:0;float:right;">
	            	       <label class="f16 mb10">프로젝트 기간</label>
	            	       <input type="text"  class="form-control"  disabled="disabled"   value="${getOkProjectView.projectStartDatetime} ~ ${getOkProjectView.projectEndDatetime} "/>
            	  		</div>
            	     </div>
            	     <div class="col-md-12 pl0 pr0 mt20">
            	     <label class="f16 mb10 f500">프로젝트 내용 </label>
            	      <input type="text"  class="form-control"  id="description" value="${fn:replace(getOkProjectView.description, newLineChar,br)}"/>
            	     </div>
            	      <div class="col-md-12 pl0 pr0 mt20">
            	         <div class="col-md-8 pl0">
            	              <div class="col-md-11 pl0">
		            	       <label class="f16 mb10 f500">첨부파일 </label>
		            	       <c:forEach items="${file}" var="filelist" varStatus="status" >
		            	       <input type="text"  class="form-control"  disabled="disabled"  value="${filelist.fileName} / (${filelist.fileTranSize})"/>
		            	        </c:forEach>
		            	      </div>
		            	      <div class="col-md-1 pl0" style="margin-top:26px;">
		            	       <a href="${contextPath}/mbr/cmm/file/download/${filelist.fileId}" class="btn_rect"><span class="rotate-270"> &#8677; </span></a>
		            	      </div>
            	         </div>
            	         <div class="col-md-4" >
            	            <div class="col-md-11 pl0">
            	            <label class="f16 mb10 f500">관리자</label>
            	            <c:set var="managerInfo" value="${getOkProjectView.managerId}/${getOkProjectView.managerName}/${getOkProjectView.managerDeptName}" />
            	            <input type="text"  class="form-control"   name="adminiStrator" id="adminiStrator" value="${managerInfo}" readonly="readonly" />
            	             </div>
            	             <div class="col-md-1 pl0" style="margin-top:26px;"><a type="button" class="btn_rect" onclick="openAdminiStratorModal();"><span class="rotate-45"> &#9906; </span></a></div>
            	         </div>




            	     </div>
            	   </div>  --%>

				<div class="clear"></div>









				<h2 class="sub_title mt30"> 클라우드 선택 </h2>
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
	                 		 <h4><input type="checkbox"  class="big_check" name ="cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
						         </c:otherwise>
							</c:choose>

						 	 <li class="cdesc">${ossCloudList.content}</li>
	                 	  </ul>
					     </div>
	                 	</c:if>
<%--
	                 	<c:if test="${ossCloudList.cloudType eq 'vmware'}">
	                 	  <div class="cloud_dmz">
	                 	  <ul>
	                 	     <c:choose>
	                 	  	    <c:when test="${ossCloudList.projectYn eq 'Y'}">
	                 		 <h4><input type="checkbox"  class="big_check" disabled checked name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
								</c:when>
						         <c:otherwise>
	                 		 <h4><input type="checkbox"  class="big_check" name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
						         </c:otherwise>
							</c:choose>

						 	 <li class="cdesc">${ossCloudList.content}</li>
	                 	  </ul>
					     </div>
	                 	</c:if>
	                 	 --%>
	                 	<c:if test="${ossCloudList.cloudType eq 'openshift'}">
	                 	 <div class="cloud_mobile">
	                 	  <ul>
	                 		  <c:choose>
	                 	  	    <c:when test="${ossCloudList.projectYn eq 'Y'}">
	                 	  	    	<h4><input type="checkbox"  class="big_check" disabled checked name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
								</c:when>
						         <c:otherwise>
						         	  <h4><input type="checkbox"  class="big_check" name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>
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
	                 		     <h4><input type="checkbox"  class="big_check" name = "cloudIds" id = "${ossCloudList.cloudId}" value = "${ossCloudList.cloudId}" /> ${ossCloudList.cloudName} </h4>

					         </c:otherwise>
						  </c:choose>
						 	 <li class="cdesc">${ossCloudList.content}</li>
	                 	  </ul>
					     </div>
	                 	</c:if>
					  </c:forEach>
				</div>

				<div class="clear"></div>

				<h2 class="sub_title mt30"> 담당자 정보  </h2>
									<div class="tableWrap">
									<table id="projectManagerList"  class="tableV">
										<colgroup>
										<col width="10%">
										<col width="*">
										<col width="8%">
										<col width="10%">
										<col width="12%">
									<%-- 	<col width="12%"> --%>
										<col width="15%">
										<col width="12%">
										<col width="8%">
									    </colgroup>
										<thead>
											<tr>
												<th>회원사</th>
												<th>소속조직(부서)</th>
												<th>이름(직급)</th>
												<th>ID</th>
												<th>전화번호(사선)</th>
												<!-- <th>핸드폰</th> -->
												<th>이메일</th>
												<th>구분</th>
												<th>비고</th>
											</tr>
										</thead>
									</table>
									<a type="button" class="btn_navy-s flr mb10" onclick="openManagerModal();"> 담당자 등록</a>
								</div>
				<div class="clear"></div>
				<div class="tac mt30 mb20">
				    <a href="#" class="btn_navy" onclick="okProjectInsert();">저장</a>
					<a type="button" class="btn_dgrey ml10" onclick="moveListPage();">목록</a>
				    <a type="button" class="btn_mint ml10" onclick="projectCloudAdd('${getOkProjectView.projectBoxId}');">클라우드존 추가​</a>
				</div>
			</div>



	           	<!-- 프로젝트 리네임 팝업 -->
	           	<div class="modal fade" id="rename-modal-dialog">
	               <div class="modal-dialog">
	                   	<div class="modal-content">
	                       	<div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                       	   <h4 class="modal-title">프로젝트명 설정</h4>
	                       	</div>
	                       	<div class="modal-body" id="serverDetailTable">
	                       		<div class="topArea2"></div>
	                       		<div class="bottomArea">
	                       			<p class="f22 fc11">프로젝트명</p>
	                       			<input type="text" class="renameEdit" value="${getOkProjectView.projectAlias}" id="popProjectAlias" maxlength="16">
	                       			<div class="renameWarn">
										<img class="fl mr20 mt5" src="/resources/assets/img/renameWarn.png">
										<p class="f14 fc66">띄어쓰기를 포함한 <span class="fc1d4766">16글자 이하로 입력</span>이 가능합니다.</p>
		                       			<p class="f14 fc11">(한글,숫자,영문,특수문자 입력이 가능합니다.)</p>

	                       			</div>
	                       		</div>
							</div>
							<div class="clear"></div>
	                       	<div class="modal-footer tac">
	                   			<a type="button" class="lbtn" data-dismiss="modal" onclick="okProjectInsert();">확인</a>
	                   			<a type="button" class="rbtn" data-dismiss="modal" onclick="initRenamePopup()">취소</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>

				<!-- #modal-dialog -->



				<!-- 프로젝트 담당자 지정 팝업 -->
			<!-- #modal-dialog -->
			<div class="modal fade" id="manager-modal-dialog">
               <div class="modal-dialog">
                   <div class="modal-content w560">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='projectManagerList();'><span></span></button>
                           <h4 class="modal-title">담당자 검색</h4>
                       </div>
                       <div class="modal-body">

                       	<!--기존 박지문 과장 검색 화면
                       		<div class="page_searchBox m-b-15">
								<div class="searchArea">
									<div class="inputArea m-l-5">
										<input type="text" placeholder="검색어를 입력하세요" id="searchManageKeyword" onkeypress="if(event.keyCode==13)gridManagerPopList();" style="width: 362px">
										<a type='button' class="btn_search" onclick="gridManagerPopList();">검색</a>
									</div>
								</div>
							</div> -->

							  <!--//검색 시작-->
	                       	 <div class="col-xs-12 bgee modalpop mb20">
		                       		<div class="selectBoxBr col-xs-3">
										<label class="selectText" for="searchKind">전체</label>
										<select class="search-sel" id="searchKind">
											<option value="searchAll">전체</option>
											<option value="userId">사번</option>
											<option value="userName">이름</option>
											<option value="deptName">부서</option>
										</select>
									</div>
										<div class="search-box">
											<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="searchManageKeyword" onkeypress="if(event.keyCode==13)gridManagerPopList();" >
											<button type="button" class="btn_search2 vm" onclick="gridManagerPopList();"><span></span></button>
										</div>
								</div>
								<!--검색  끝//-->

								 <table class="tableV">
								 <colgroup>
								 <col width="25%">
								 <col width="25%">
								 <col width="*">
								 <col width="10%">
								 </colgroup>
								 <thead>
								 <tr class="skyblue">
									<th class="tac">이름</th>
									<th class="tac">사번</th>
									<th class="tac">부서</th>
									<th class="tac">버튼</th>
								 </tr>
								 </thead>
								 <tbody id="popManagerListTable">

								 </tbody>
						 	    </table>

							<div class="noneList" id='popManagerListTable2'>
								 <span>검색된 사용자가 없습니다.</span>
							</div>
                      		<div class="totalcnt" id="totalCntManager">총 0 건</div>
	                   	</div>
	                   	<div class="modal-footer tac">
                       		<a type="button" class="m_btn_white ml10" data-dismiss="modal" onclick='projectManagerList();'>닫기</a>
                       	</div>
	               	</div>
				</div>
           	</div>
			<!-- #modal-dialog -->


				<!-- 프로젝트 관리자 지정 팝업 -->
			<!-- #modal-dialog -->
			<div class="modal fade" id="administrator-modal-dialog">
               <div class="modal-dialog">
                   <div class="modal-content w560">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridAdminiStratorPopList();'><span></span></button>
                           <h4 class="modal-title">관리자 검색</h4>
                       </div>
                       <div class="modal-body">


	                       	 <div class="col-xs-12 bgee modalpop mb20">
		                       		<div class="selectBoxBr col-xs-3">
										<label class="selectText" for="searchKindAdminiStrator">전체</label>
										<select class="search-sel" id="searchKindAdminiStrator">
											<option value="searchAll">전체</option>
											<option value="userId">사번</option>
											<option value="userName">이름</option>
											<option value="deptName">부서</option>

										</select>
									</div>
										<div class="search-box">
											<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="searchAdminiStratorKeyword" onkeypress="if(event.keyCode==13)gridAdminiStratorPopList();" >
											<button type="button" class="btn_search2 vm" onclick="gridAdminiStratorPopList();"><span></span></button>
										</div>
								</div>



								<!-- 2023 new search -->
										<!-- <div class="col-xs-12 bgee modalpop mb20">
										 <div class="new-search-modal">
								           <div class="left">
									         <div class="choice-kepco">
											  <div class="select-kepco" id="searchKindAdminiStrator">
											    <button class="kep-label"  for="searchKindAdminiStrator">전체 </button>
											    <ul class="optionList">
											      <li class="optionItem" value="searchAll">전체</li>
											      <li class="optionItem" value="userId">사번</li>
											      <li class="optionItem" value="userName">이름</li>
											      <li class="optionItem" value="deptName">부서</li>
											    </ul>
											  </div>
											</div>
											</div>

											<div class="right">
					                          <input type="text" class="input-kepco-s" placeholder="사번이나 이름 부서로 입력하세요" id="searchAdminiStratorKeyword" onkeypress="if(event.keyCode==13)gridAdminiStratorPopList();"/>
					                          <button type="button" class="kepco-ser-icon-modal2 vm"  onclick="gridAdminiStratorPopList();"></button>
					                         </div>
				                          </div>
				                          </div> -->
								<!-- 2023 new search END -->


		                       <table class="tableV">
								 <colgroup>
								 <col width="25%">
								 <col width="25%">
								 <col width="*">
								 <col width="10%">
								 </colgroup>
								 <thead>
								 <tr class="skyblue">
									<th class="tac">이름</th>
									<th class="tac">사번</th>
									<th class="tac">부서</th>
									<th class="tac">버튼</th>
								 </tr>
								 </thead>
								 <tbody id="popAdminiStratorListTable">
								 </tbody>
						 	    </table>


							<div class="noneList" id='popAdminiStratorListTable2'>
								 <span>검색된 사용자가 없습니다.</span>
							</div>
                      		<div class="totalcnt" id="totalCntAdminiStrator">총 0 건</div>
	                   	</div>
	                   	<div class="modal-footer tac">

	                   		 <a type="button" class="m_btn_navy" data-dismiss="modal" onclick="updateAdminiStrator();">확인</a>
                       		<a type="button" class="m_btn_white ml10" data-dismiss="modal" >닫기</a>

                       	</div>
	               	</div>
				</div>
           	</div>
			<!-- #modal-dialog -->

			<!-- #modal-dialog 결재자 지정팝업 시작-->
	        	<div class="modal fade" id="modal-approve-review-dialog">
            	<div class="modal-dialog width-720">
                	<div class="modal-content width-720">
                    	<div class="modal-header">
                        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        	<h4 class="modal-title">요청부서 결재지정</h4>
                    	</div>

                    	<div class="modal-body">
				   			<table class="tableV">
						 		<colgroup>
						 			<col width="20%">
						 			<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
						 		</colgroup>
						 		<thead>
						 			<tr class="skyblue">
										<th>구분</th>
										<th>사번</th>
										<th>직급</th>
										<th>이름</th>
										<th></th>
								     </tr>
					    		</thead>
					    		<tbody>
						 			<tr>
										<td class="tac" id="approvalLine1_title"> 입안보조 </td>
										<td class="tac" id="approvalLine1_userId"> 사번 </td>
										<td class="tac" id="approvalLine1_userLevel"> 직급 </td>
										<td class="tac" id="approvalLine1_userName"> 이름 </td>
										<td class="tac">
											<button type="button" class="cbton bton_lblue" id="approvalLine1" onclick="openReviewModal(this);"><i class='fa fa-search'></i></button>
										</td>
									</tr>
						 			<tr>
							 			<td class="tac" id="approvalLine2_title"> 입안 </td>
							 			<td class="tac" id="approvalLine2_userId"> 사번 </td>
							 			<td class="tac" id="approvalLine2_userLevel"> 직급 </td>
							 			<td class="tac" id="approvalLine2_userName"> 이름 </td>
							 			<td class="tac">
							 				<button type="button" class="cbton bton_lblue" id="approvalLine2" onclick="openReviewModal(this);" disabled="disabled"><i class='fa fa-search'></i></button>
							 			</td>
						 			</tr>
						 			<tr>
										<td class="tac" id="approvalLine3_title"> 검토 </td>
										<td class="tac" id="approvalLine3_userId"> 사번 </td>
										<td class="tac" id="approvalLine3_userLevel"> 직급 </td>
										<td class="tac" id="approvalLine3_userName"> 이름 </td>
										<td class="tac">
											<button type="button" class="cbton bton_lblue" id="approvalLine3" onclick="openReviewModal(this);" disabled="disabled"><i class='fa fa-search'></i></button>
										</td>
									</tr>
									<tr>
										<td class="tac" id="approvalLine4_title"> 승인 </td>
										<td class="tac" id="approvalLine4_userId"> 사번 </td>
										<td class="tac" id="approvalLine4_userLevel"> 직급 </td>
										<td class="tac" id="approvalLine4_userName"> 이름 </td>
										<td class="tac">
											<button type="button" class="cbton bton_lblue" id="approvalLine4" onclick="openReviewModal(this);" disabled="disabled"><i class='fa fa-search'></i></button>
										</td>
									</tr>
						 		</tbody>
				 			</table>
					 	</div>
						<div class="clear"></div>
						<div class="modal-footer tac">
	             			<a type=button class="lbtn" data-dismiss="modal" onclick="projectCloudInsert();">확인</a>
	             			<a type=button class="rbtn" data-dismiss="modal">취소</a>
	                 	</div>
              		</div>
           		</div>
			</div>
		<!-- #modal-dialog 결재자 지정팝업 끝-->

		<!-- 프로젝트 검토자 결재자 지정 팝업 -->
					<!-- #modal-dialog -->
					<div class="modal fade" id="user-modal-review-dialog">
						<div class="modal-dialog width-720">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridPopList();'><span></span></button>
		                           	<h4 class="modal-title">검토자 검색</h4>
		                       	</div>
		                       	<div class="modal-body">
									<!--//검색 시작-->
									<div class="col-xs-12 bgee modalpop mb20">
										<div class="selectBoxBr col-xs-3">
											<label class="selectText" for="reviewSearchKind">전체</label>
											<select class="search-sel" id="reviewSearchKind">
												<option value="searchAll">전체</option>
												<option value="userId">사번</option>
												<option value="userName">이름</option>
												<option value="deptName">부서</option>
											</select>
										</div>
										<div class="col-xs-9">
											<input type="text" class="search-text-s" placeholder="사번이나 이름 부서로 입력하세요" id="reviewUserId" onkeypress="if(event.keyCode==13)gridPopList();" >
											<button type="button" class="btn_search2 vm" onclick="gridPopList();"><span></span></button>
										</div>
									</div>
									<!--검색  끝//-->

									<table class="tableV">
								 		<colgroup>
											<col width="*">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="8%">
								 		</colgroup>
								 		<thead>
								 			<tr class="skyblue">
								 				<th class="tac">부서</th>
												<th class="tac">사번</th>
												<th class="tac">직급</th>
												<th class="tac">이름</th>
												<th class="tac">상태</th>
												<th class="tac"></th>
											</tr>
										</thead>
								 		<tbody id="popListReviewTable">
								 		</tbody>
						 	    	</table>

									<div class="noneList" id='popListReviewTable2'>
										<span>검색된 사용자가 없습니다.</span>
									</div>
		                      		<div class="totalcnt" id="totalReviewCnt">총 0 건</div>
			                   	</div>
			                   	<div class="modal-footer tac">
		                       		<a type="button" class="whiteline" data-dismiss="modal" >닫기</a>
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

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

				// 결재라인 관련 변수
				var currentApprovalLine = "";
				var approvalList = [];



				function selectAdminiStrator(e, id, nm, dept){
					$("#popAdminiStratorListTable > tr").find("input").removeClass("active");
					$(e).toggleClass("active");
					$("#h_popAdminiStratorId").val(id);
					$("#h_popAdminiStratorName").val(nm);
					$("#h_popAdminiStratorDept").val(dept);
				}

				// 관리자 적용
				function updateAdminiStrator(){
					var adminiStratorId = $("#h_popAdminiStratorId").val();
					var adminiStratorName = $("#h_popAdminiStratorName").val();
					var adminiStratorDept = $("#h_popAdminiStratorDept").val();

					$("#adminiStrator").val(adminiStratorId + " / " +  adminiStratorName + " / " +adminiStratorDept );
				}


				// 관리자 팝업
				function openAdminiStratorModal(){
					if('${userId}' == 'admin' || '${userId}' == '${getOkProjectView.managerId}') {
						gridAdminiStratorPopList();
						$("#administrator-modal-dialog").modal();
					} else {
						alertBox("관리자는 해당 프로젝트의 관리자 <br/> 혹은 포털 관리자만 변경할 수 있습니다.");
					}
				}

				// 관리자 등록 팝업 리스트
				function gridAdminiStratorPopList(){

					$.ajax({
						url : "${contextPath}/mbr/operation/approveUser/addOssProjectManageList",
						dataType : "JSON",
						data : {
							"searchKind": $("#searchKindAdminiStrator option:selected").val()
							, "keyword"	: $("#searchAdminiStratorKeyword").val()
							  , "projectBoxId":$("#projectBoxId").val()


						},
						success : function(req) {
							if(req.data.length == 0){
								$("#popAdminiStratorListTable").hide();
								$("#popAdminiStratorListTable2").show();
							}else{
								$("#popAdminiStratorListTable").empty();

								$.each(req.data, function(key,val){
									$("#popAdminiStratorListTable").append(
											'<tr>'
											+'<td>'+val.userName+'</td>'
											+'<td>'+val.userId+'</td>'
											+'<td>'+val.deptName+'</td>'
											+'<td class="tac"><input type="button"  value="&#xf00c" class="popCheckbtn"  onclick="selectAdminiStrator(this, \''+val.userId+'\', \''+val.userName+'\', \''+val.deptName+'\');"></td>'
										+'</tr>');

								});
								$("#popAdminiStratorListTable").show();
								$("#popAdminiStratorListTable2").hide();
							}
							totalCnt = req.data.length;
							$("#totalCntAdminiStrator").text("총 "+totalCnt+" 건");
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






		//프로젝트 관리자 타입 변경시 타입 업데이트

		function projectManagerType(userId,seq){

			if($("#h_popAdminiStratorId").val() == userId){
				alertBox("선택한 사용자는 관리자 입니다.");
				return false;
			}

			   var text = "projectManagerTypeId"+seq;

			   if(seq == 1){var projectManagerType = $("#projectManagerTypeId1 option:selected").val();}
			   else if(seq == 2){var projectManagerType = $("#projectManagerTypeId2 option:selected").val();}
			   else{var projectManagerType = $("#projectManagerTypeId3 option:selected").val();}


			   $.ajax({
					url : "${wasPath}/mbr/req/project/ossProjectManagerTypeUdate",
					dataType : "JSON",
					type : "GET",
					data : {
						"userId" : userId
						, "projectBoxId" : $("#projectBoxId").val()
						,"projectManagerType" : projectManagerType
					},
					success : function(data) {
						var result = data;

						if(result == "1"){
							projectManagerList();
						}else if(result == "2"){
							alertBox("실무부서는 필수 항목 입니다.");
							projectManagerList();
						}else if(result == "0"){
							//alert(0);
						}else{
							alertBox("접속이 만료되었습니다.", logout);
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



		//프로젝트 관리자
		function projectManagerUserDelete(userId){

			$.ajax({
				url : "${wasPath}/mbr/req/project/ossProjectManagerUserDelete",
				dataType : "JSON",
					type : "GET",
				data : {
					"userId" : userId
					, "projectBoxId" : $("#projectBoxId").val()

				},
				success : function(data) {
					var result = data;

					if(result==2){
						alertBox("실무부서는 삭제할수 없습니다.");
					}else if(result==1){
						alertBox("삭제되었습니다.", projectManagerList);
					}else if	(result==0){
						alertBox("접속이 만료되었습니다.", logout);
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




				//프로젝트 사용자포탈 관리자 insert
				function ossInsertManager(e, userId){
				$.ajax({
					url : "${contextPath}/mbr/operation/approveUser/ossInsertManager",
					dataType : "JSON",
					data : {
						"userId": userId
					  , "projectBoxId":$("#projectBoxId").val()

					},
				success : function(data) {

					if(data == "2"){alertBox("프로젝트 담당자는 최대 3명등록가능합니다.", projectManagerList);}

					$(e).parent().remove();
					totalCnt = totalCnt-1;
					$("#totalCnt").text("총 "+totalCnt+" 건");
					if(totalCnt == 0){
						$("#popListTable").hide();
						$("#popListTable2").show();
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






		//담당자 팝업
		function openManagerModal(){
			gridManagerPopList();
			$("#manager-modal-dialog").modal();
		}

		// 관리자 등록 팝업 리스트
		function gridManagerPopList(){

			$.ajax({
				url : "${contextPath}/mbr/operation/approveUser/addOssProjectManageList",
				dataType : "JSON",
				data : {
					  "searchKind": $("#searchKind option:selected").val()
					, "keyword"	: $("#searchManageKeyword").val()
					  , "projectBoxId":$("#projectBoxId").val()
				},
				success : function(req) {
					if(req.data.length == 0){
						$("#popManagerListTable").hide();
						$("#popManagerListTable2").show();
					}else{
						$("#popManagerListTable").empty();

						$.each(req.data, function(key,val){
							$("#popManagerListTable").append(
									'<tr>'
									+'<td>'+val.userName+'</td>'
									+'<td>'+val.userId+'</td>'
									+'<td>'+val.deptName+'</td>'
									+'<td class="tac"><input type="button"  value="&#xf00c" class="popCheckbtn"  onclick="ossInsertManager(this, \''+val.userId+'\');"></td>'
								+'</tr>');
						});
						$("#popManagerListTable").show();
						$("#popManagerListTable2").hide();
					}
					totalCnt = req.data.length;
					$("#totalCntManager").text("총 "+totalCnt+" 건");
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


			//프로젝트 관리자 목록
			function projectManagerList() {


				var i = 0;
				 $("#projectManagerList").dataTable( {
						"processing":true
						,"ordering" : false
						,"destroy" : true
						,"autoWidth":false
						,"serverSide":true
					,"ajax": {
						"url":"${contextPath}/mbr/req/project/managerListGrid"
						,"type" : "GET"
						,"dateSrc" : ""
						,"data":function (d) {
							d.searchKind = ""
							d.keyword = $("#searchManageKeyword").val();
							d.projectBoxId = $("#projectBoxId").val();
							d.managerType = "Y";
						}
					}
					,"columns":[
			        	  {"data":"customerName", "class":"tac"}
			        	, {"data":"deptName", "class":"tac"}
			        	, {"data":"userNameLevel", "class":"tal"}
			        	, {"data":"userId", "class":"tac"}
			        	, {"data":"userTel", "class":"tac"}
			        	/* , {"data":"userPhone", "class":"tac"} */
			        	, {"data":"userMail", "class":"tac"}
			        	, {"data":"projectManagerType", "class":"tac"}
						]

					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" ,"class":"tac"}
							, {"targets":[6], "render":function(data,type,full){

							    i++;
								if(full.projectManagerType == 02){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="02" selected="selected">실무부서</option><option value="03">시스템관리부서</option><option value="04">위탁운영부서</option></select>';}
								else if(full.projectManagerType == 03){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="02">실무부서</option><option value="03" selected="selected">시스템관리부서</option><option value="04">위탁운영부서</option></select>';}
								else if(full.projectManagerType == 04){return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="02">실무부서</option><option value="03">시스템관리부서</option><option value="04" selected="selected">위탁운영부서</option></select>';}
								else{return '<select class="form-control pb6"  class="typeselectClass" id="projectManagerTypeId'+i+'" onchange="projectManagerType(\''+full.userId+'\',\''+i+'\');"><option value="00"></option><option value="02">실무부서</option><option value="03">시스템관리부서</option><option value="04">위탁운영부서</option></select>';}
								}
							}

							, {"targets":[7], "render":function(data,type,full){
								return '<a type="button" class="bton-s bton_orange" onclick="projectManagerUserDelete(\''+full.userId+'\');"> <i class="fa fa-trash"></i> 삭제</a>';
							}
						}
					]
					,"order": [[3,"desc"]]
					,"lengthMenu": [[10,15], [10, 15]]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					}
					,"sDom":''
				});

			}




		function moveListPage(){
			location.href="${wasPath}/mbr/req/project/okprojectList.do";
		}

		function moveProjectListPage(){

			location.href="${wasPath}/mbr/req/project/projectList.do";

		}


		// 상세정보 가져오기
		function projectDetail(projectBoxId) {
			$.ajax({
				url : "${contextPath}/mbr/req/project/okProjectDetail",
				dataType : "JSON",
				data : {
					"projectBoxId" : $("#projectBoxId").val()
				},
				success : function(data) {
					var result = data;
					 setData(result);
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			})

		}

		// 프로젝트 상세정보 세팅
		function setData(result){
			$("#projectAlias").val(result.projectAlias);
		    $("#projectPrice").val(String(result.projectPrice).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,"));
			$("#description").val(result.description);
			var sDate = result.projectStartDatetime;
			var eDate = result.projectEndDatetime;
			if (sDate.length == 8) {
				sDate = sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2);
			}
			if (eDate !=null){
				if (eDate.length == 8) {
					eDate = eDate.substr(0, 4) + "-" + eDate.substr(4, 2) + "-" + eDate.substr(6, 2);
				}
			}
			$("#dispSdate").val(sDate);
			$("#dispEdate").val(eDate);
		}

		// 달력
		function calendar(){

			var dayName = ['일','월','화','수','목','금','토'];
			var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

			$("#dispSdate").datepicker({
				showOn:"both",
				buttonImage:"/resources/assets/img/calen2.png",
				buttonImageOnly:true,
				buttonText : '',
				dateFormat : "yy-mm-dd",
				dayNamesMin:dayName,
				monthNamesShort:monthName,
				changeMonth:true,
				changeYear:true,
				minDate:0
			});

			$("#dispEdate").datepicker({
				showOn:"both",
				buttonImage:"/resources/assets/img/calen2.png",
				buttonImageOnly:true,
				buttonText : '',
				dateFormat:"yy-mm-dd",
				dayNamesMin:dayName,
				monthNamesShort:monthName,
				changeMonth:true,
				changeYear:true,
				minDate:0
			});

			$("img.ui-datepicker-trigger").attr("style", "vertical-align:top;");
		}


	function okProjectInsert(){
		confirmBox("저장 하시겠습니까?",projectInsert)
	}
	//프로젝트명, 프로젝트 비용, 프로젝트 기간 저장
	function projectInsert(){

		$.ajax({
			url : "${wasPath}/mbr/req/project/okProjectModify",
			dataType : "JSON",
			type : "POST",
			data : {
				  "projectBoxId" : $("#projectBoxId").val()
				, "ProjectAlias" : $("#projectAlias").val()
 				, "projectPrice" : $("#projectPrice").val().replace(/\,/g, "")
 				, "description" : $("#description").val()
 				, "projectStartDatetime":$("#dispSdate").val().replace(/-/gi, "")
				, "projectEndDatetime":$("#dispEdate").val().replace(/-/gi, "")
				, "adminiStratorId":$("#h_popAdminiStratorId").val()

			},
			success : function(data) {
				alertBox("저장되었습니다", moveDetailPage);
			},
			error : function(request, status, error) {
				if(request.status == '200'){
// 					alertBox("접속이 만료되었습니다.", logout);
					moveErrorPage();
				}else{
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			}
		});
	}

	function moveErrorPage() {
		var currentPath = window.location.pathname;
		location.href = currentPath;
	}

	// 상세 페이지이동
	function moveDetailPage(){
 		location.href = "${wasPath}/mbr/req/project/okprojectView.do?projectBoxId="+$("#projectBoxId").val();
 	}


	// 프로젝트명 수정팝업 초기화
	//function initRenamePopup(){
	//	$("#popProjectAlias").val("${getOkProjectView.projectAlias}");
	//}

	$(document).ready(function() {
	    App.init();
	    projectDetail($("#projectBoxId").val());
	    projectManagerList();

	    calendar();
	    //메뉴활성화
	 	$("#project").addClass("active");
	 	$("#projectList").addClass("active");
	});


	function projectCloudAdd() {

		 var items = [];
		 $('input:checkbox[name=cloudIds]:checked').each(function () {
		     items.push($(this).val());
		 });
		 $("#h_cloudIds").val(items);

		$("#selectApprv").val("Y");
		var jsonData = setJsonData();

		$.ajax({
			url : "${wasPath}/mbr/req/project/reqCloudListChk",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {

				if(data==1){
					 if($("#apprvPass").val() == "Y"){
						 confirmBox4("결재자로 지정하시겠습니까?",approvSelect,projectCloudInsert);
					 }else{
						 approvSelect();
					 }
				}else if(data==3){
					alertBox3("결재 진행중인 클라우드가 있습니다.");
				}else if(data==2){
					alertBox3("클라우드를 선택하세요.");
				}else{
					alertBox3("fail!");
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


	// 클라우드 추가 req_project 테이블 작성중으로 상태값 변경 , 스텝 데이터 히스토리 테이블로 이동, 스텝 데이터 초기화
	function projectCloudInsert() {

		var jsonData = setJsonData();

		$.ajax({
			url : "${wasPath}/mbr/req/project/reqProjectUpdate",
			dataType : "JSON",
			type : "POST",
			data : jsonData,

			success : function(data) {
				if(data==1){
					alertBox("신청되었습니다", moveProjectListPage)

				}else{
					alertBox3("fail!");
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

	function approvSelect(){
		$("#selectApprv").val("N");
		$("#modal-approve-review-dialog").modal();
	}

	function openReviewModal(e){
		currentApprovalLine = e;
		var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
		if( approvalList[tmpCurrentApprovalStep-1] != undefined) {
			confirmBox("재신청할경우 현재 상위결재자값이 초기화 됩니다.", clearUpperApproval );

		} else {
			$("#user-modal-review-dialog").modal();
			gridPopList();
		}

	}

	function clearUpperApproval() {
		var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
		for(var i = tmpCurrentApprovalStep-1 ; i < 4; i++) {
			approvalList.splice(i, 1);

			$("#approvalLine"+(i+1)+"_userId").text("사번");
			$("#approvalLine"+(i+1)+"_userLevel").text("직급");
			$("#approvalLine"+(i+1)+"_userName").text("이름");

			$("#approvalLine"+(i+1)).attr('disabled', true);
		}

		//초기화 하더라도 차장급 이상이면 재활성화되게
		if( ${userLevelCode} < 5 ) {
			$("#approvalLine2").attr('disabled', false);
		}

		$("#user-modal-review-dialog").modal();
		gridPopList();
	}

	// 결재자 등록 팝업 리스트
	function gridPopList(){


		$.ajax({
			url : "${contextPath}/mbr/operation/approveUser/addProjectApproveList",
			dataType : "JSON",
			data : {
				"searchKind": $("#reviewSearchKind option:selected").val()
				, "keyword"	: $("#reviewUserId").val()
			},
			success : function(req) {
				if(req.data.length == 0){
					$("#popListReviewTable").hide();
					$("#popListReviewTable2").show();
				}else{
					$("#popListReviewTable").empty();

					$.each(req.data, function(key,val){
						$("#popListReviewTable").append(
							'<tr>'
							    +'<td class="tac">'+val.upDeptName+'/'+val.deptName+'</td>'
								+'<td class="tac">'+val.userId+'</td>'
								+'<td class="tac">'+val.userLevel+'</span>'
								+'<td class="tac">'+val.userName+'</span>'
								+'<td class="tac">'+val.userConditionText+'</td>'
								+'<td class="tac"><input type="button"  value="&#xf00c"  class="popCheckbtn"  onclick="updateReview(this, \''+val.userId+'\', \''+val.userName+'\', \''+val.deptName+'\',  \''+val.userLevel+'\',  \''+val.userLevelCode+'\');" initModal();></td>'
							+'</tr>');

					});
					$("#popListReviewTable").show();
					$("#popListReviewTable2").hide();
				}
				totalCnt = req.data.length;
				$("#totalReviewCnt").text("총 "+totalCnt+" 건");
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

	// 결재라인 초기화
	function initApprovalLine() {
		var tmpUserLevelCode = 100;
		if( ${userLevelCode} == null || ${userLevelCode} == '' ) {
			tmpUserLevelCode == 100;
		} else {
			tmpUserLevelCode == ${userLevelCode};
		}

		// 직급에 따른 버튼활성화 - 3직급(차장) == 4
		$("#approvalLine1").attr('disabled', false);
		if( ${userLevelCode} < 5 ) {
			$("#approvalLine2").attr('disabled', false);
		}
	}


	//요청부서 검토자/승인자 지정 - 요청부서(검토) 검토자지정
	function updateReview(e, userId, userName, deptName, userLevel, userLevelCode) {
		var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
		if( tmpCurrentApprovalStep > 1 && approvalList[tmpCurrentApprovalStep-2] != undefined) {
			if( approvalList[tmpCurrentApprovalStep-2].userLevelCode < userLevelCode) {
				alertBox("이전단계보다 같거나 높은 직급의 담당자를 선택하세요");
				return false;
			}
		}
		/* if($("#hidden_login_user_id").val() ==userId) {
			alertBox("신청자는 본인을<br>결재자로 지정할수 없습니다.");
			return false;
		} */

		$("#popListReviewTable > tr").find("input").removeClass("active");
		$(e).toggleClass("active");
		//alert(tmpCurrentApprovalStep);
		var tmpValue = { "userId" : userId, "deptName" : deptName, "userName" : userName, "userLevel" : userLevel, "userLevelCode" : userLevelCode }
		//alert( JSON.stringify(tmpValue) );


		$("#"+currentApprovalLine.id+"_userId").text(userId);
		$("#"+currentApprovalLine.id+"_userLevel").text(userLevel);
		$("#"+currentApprovalLine.id+"_userName").text(userName);

		approvalList[tmpCurrentApprovalStep-1] = tmpValue;
		$("#hiddenUserIdReview").val(userId);
		$("#hiddenDeptNameReview").val(deptName);
		$("#hiddenUserNameReview").val(userName);

		// 다음 단계 버튼 활성화
		$("#approvalLine"+(parseInt(tmpCurrentApprovalStep)+1) ).attr('disabled', false);

	}

	//데이터 세팅
	function setJsonData(){

		var items={};
		var i=0;
//			var netstr="";
//			var checkVal = networkValues();

		if( approvalList[0] == undefined || approvalList[0] == null) {
			var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
			approvalList[0] = tmp;
		}

		var jsonData = {
				"projectAlias":$("#projectAlias").val()
				, "projectDescription":$("#projectDescription").val()


				//, "networkEtc":$("#networkEtc").val()
				//, "network": checkVal
				, "reqProjectSeq":$("#reqProjectSeq").val()

				, "hiddenUserIdReview":$("#hiddenUserIdReview").val()
				, "hiddenUserNameReview":$("#hiddenUserNameReview").val()
				, "hiddenUserIdApprove":$("#hiddenUserIdApprove").val()
				, "hiddenUserNameApprove":$("#hiddenUserNameApprove").val()

				, "projectCustomerId":$("#h_popCustomerId").val()
				, "projectCustomerName":$("#h_popCustomerName").val()
				, "projectDeptCode":$("#h_popDeptCode").val()
				, "projectDeptName":$("#h_popDeptName").val()
				, "statusFlag":$("#h_projectStatusFlag").val()
				, "adminiStratorId":$("#h_popAdminiStratorId").val()

				, "approvalStepList" : approvalList
				, "apprvPass":$("#apprvPass").val()
				, "selectApprv":$("#selectApprv").val()
				, "cloudIds":$("#h_cloudIds").val()

				};
		return jsonData;
	}


	</script>

</body>
</html>