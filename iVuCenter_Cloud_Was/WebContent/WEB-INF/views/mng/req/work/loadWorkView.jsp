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
		<div id="content" class="content" >
		<input type ="hidden" id = "reqWorkSeq" value ="${getReqWorkView.reqWorkSeq}">
		<input type ="hidden" id = "orderProductSeq" value ="${getReqWorkView.orderProductSeq}">
		<input type ="hidden" id = "productCategory" value ="${getReqWorkView.productCategory}">
		<input type ="hidden" id = "productServiceName" value ="${getReqWorkView.serviceName}">
		<input type ="hidden" id = "projectId" value ="${getReqWorkView.projectId}">
		<input type ="hidden" id = "requestType" value="${getReqWorkView.requestType}">
		<input type ="hidden" id = "vmUuid" value ="">
		<input type ="hidden" id = "vmName" value ="">
		<input type ="hidden" id = "vmHost" value ="">
		
				

			<!-- begin header -->
			<div class="page_header mb30">
				<h1>작업요청 처리</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">승인/작업 처리</a><a href="#" class="on">작업요청 처리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->

			
			<div class="viewbox">
				    <span class="pid" >${getReqWorkView.projectName}</span>
				 	<h3 class="pname dpin ml20" id="projectAlias">${getReqWorkView.projectAlias}</h3> 

				 	<span class="dpin fb fc-blue2 ml20">회원사  : </span> <span>${getReqWorkView.projectCustomerName}</span> <span class="dpin fb ml40 fc-blue2">담당조직(부서) : </span> <span>${getReqWorkView.projectDeptName}</span><span class="dpin fb ml40 fc-blue2">담당자 : </span> <span>${getReqWorkView.projectManagerName} (${getReqWorkView.projectManagerTel})</span>
						<div class="clear"></div>
						<h2 class="titleBuType01 fc-blue2 fb mt20">작업요청 내역</h2>
						<table class="intableV mt10">
						<colgroup>
							<col width="12%">
							<col width="*">
						</colgroup>
						    <tbody>
						    <tr>
						    <th class="tac">서비스유형  </th>
						    <td>
						    <span class="round1">로드밸런스</span>
						   		<c:if test = "${getReqWorkView.completeDatetime2 eq null}">
								<span class="serverName f16 fc11" id="vm_view_tab_hostnameAlias_view"> <span class="company_cont" id="disk_view_diskAlias">${getReqWorkView.loadbalancerName}</span>
									<a type="button" onclick="inputShow('vm_view_tab_hostnameAlias_view','hostnameInput', 'vm_view_tab_hostnameAlias','vm_view_tab_hostnameAlias_text');" class="title_modify"></a>
								</span>
							</c:if>
									 
						    <c:if test = "${getReqWorkView.completeDatetime2 ne null}">	 
							<span class="serverName f16 fc11" id="vm_view_tab_hostnameAlias_view"> <span class="company_cont"  id="disk_view_diskAlias">${getReqWorkView.serviceName}</span>
							</span>		 
							</c:if> 
						   <span class="serverRename" id="hostnameInput" style="display: none;"> 
								<input maxlength="30" type="text" class="input_int  w50 dpin ml20" id="view_tab_service_name_value" data-original-title="" title="">
								<a type="button" onclick="updateServiceAlias();" class="modisave" data-dismiss="modal"></a>
								<a type="button" onclick="inputHide('hostnameInput','vm_view_tab_hostnameAlias_view');" class="modicancel"></a>
							</span>		
						    </td>
						    </tr>
						     <tr>
						    <th class="tac">서비스 희망일시 </th>
						    <td>
						     <c:if test ="${getReqWorkView.onDemandFlag eq 'Y'}">
						 			<span> 승인완료 후 생성</span>
						 </c:if>
						 <c:if test ="${getReqWorkView.onDemandFlag eq 'N'}">
							      <span>${getReqWorkView.applyDatetime}</span>
						 </c:if>
						    </td>
						    </tr>
						    <tr>
						    <th class="tac">요청내용 </th>
						    <td>
						    <c:if test ="${getReqWorkView.productBigo != null and getReqWorkView.productBigo != ''}">
						
						           <%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>
									<span class="txt">${fn:replace(getReqWorkView.productBigo,newLineChar,br)}</span>
					    
					    	</c:if>
						    </td>
						    </tr>
						    <tr>
						    <th class="tac">요청 타입 </th>
						    <td>
						     	<c:if test ="${getReqWorkView.requestType eq 'REQTYPE_EXPR'}">
						     		가상서버 삭제
						     	</c:if>
						     	<c:if test ="${getReqWorkView.requestType eq 'REQTYPE_CHANGE'}">
						     		가상서버 추가
						     	</c:if>
						     	<c:if test ="${getReqWorkView.requestType eq 'REQTYPE_NEW'}">
						     		신규추가
						     	</c:if>
						    </td>
						    </tr>
						    <tr>
						    <th class="tac">요청 protocol </th>
						    <td>
						    ${getReqWorkView.protocol} 
						    </td>
						    </tr>
						    <tr>
						    <th class="tac">요청 method </th>
						    <td>
						    ${getReqWorkView.method} 
						    </td>
						    </tr>
						    </tr>
						    <tr>
						    <th class="tac">IP </th>
						    <td>
						    ${getReqWorkView.ip} 
						    </td>
						    </tr>
						    </tr>
						    <tr>
						    <th class="tac">port </th>
						    <td>
						    ${getReqWorkView.port} 
						    </td>
						    </tr>
						    </tbody>
						</table>
			</div>
			
			<div class="row mt30">
				<h2 class="titleBuType01 m-b-15">서버 정보</h2>
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
							<th>가상서버명</th>
							<th>IP</th>
							<th>vCPU (Core)</th>
							<th>MEMORY (GB)</th>
							<th>볼륨 (EA)</th>
						</tr>
					</thead>
					<tbody>
							<c:forEach items="${getVmList}" var="getVmList" varStatus="status" >
					
							<tr>
								<td>${getVmList.hostnameAlias}</td>
								<td>${getVmList.fixedIps}</td>
								<td>${getVmList.vcpus}</td>
								<td>${getVmList.memGb}</td>
								<td>${getVmList.diskGb}</td>
							</tr>
							</c:forEach>
					</tbody>
				</table>
			</div>
				
				<div class="row mt30">
					<h2 class="titleBuType01 m-b-15">작업 정보</h2>
					<!-- 
						1. 과금적용일시확인 : .case_01
						2. 내작업의경우 : .case_02
						3. 내작업이아닌경우 : .case_03
						<span class="txt">${getReqWorkView.productBigo}</span>
					 -->
					 
					 <c:if test = "${getReqWorkView.readDatetime eq null}">
					 	<c:set var="workStatus">workRequest</c:set>
					 	<c:set var="workDisplayClass">fc1e5dab</c:set>
					 	<c:set var="workDisplay">진행중</c:set>
					 </c:if>
					 <c:if test = "${getReqWorkView.readDatetime ne null}">
					 	<c:set var="workStatus">workCheck</c:set>
					 	<c:set var="workDisplayClass">fc1e5dab</c:set>
					 	<c:set var="workDisplay">진행중</c:set>
					 </c:if>
					 <c:if test = "${getReqWorkView.completeDatetime2 ne null}">
					 	<c:set var="workStatus">workComplete</c:set>
					 	<c:set var="workDisplayClass">fc1e5dab</c:set>
					 	<c:set var="workDisplay">작업완료</c:set>
					 </c:if>
					 <c:if test = "${getReqWorkView.chargeStartDatetime2 ne null}">
					 	
					 <%-- 	<c:set var="workStatus">workCharge</c:set>
					 	<c:set var="workDisplayClass">fcde4e4e</c:set>
					 	<c:set var="workDisplay">과금적용</c:set> --%>
					 	
					 	<c:set var="workStatus">workComplete</c:set>
					 	<c:set var="workDisplayClass">fc1e5dab</c:set>
					 	<c:set var="workDisplay">작업완료</c:set>
					 	
					 </c:if>
					 
					<c:if test ="${workStatus == 'workRequest'}">						
						<div class="case_03" style="display:block;">
							<div class="formType01">
								<div class="tblWrap clearfix">
									<table>
										<colgroup>
											 <col width="13%">
											 <col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><strong>작업자</strong></th>
												<td>${getReqWorkView.workUserName}</td>
											</tr>
											<tr>
												<th scope="row"><strong>작업상태</strong></th>
												<td><strong class="${workDisplayClass}">${workDisplay}</strong></td> 
											</tr>
											<tr>
												<th scope="row"><strong>등록 일시</strong></th>
												<td class="fontVdn">${getReqWorkView.regDatetime2}</td>
											</tr>
											<tr>
												<th scope="row"><strong>작업완료일시</strong></th>
												<td class="fontVdn">${getReqWorkView.completeDatetime2}</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="row tac m-t-60">
								<a type="button" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>         
							</div>
						</div>
					</c:if>
					
					<c:if test ="${workStatus == 'workCheck' }">							
						<div class="case_02" style="display:block;">
							<div class="formType01">
								<div class="tblWrap clearfix">
									<table>
										<colgroup>
											 <col width="13%">
											 <col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><strong>작업자</strong></th>
												<td>${getReqWorkView.workUserName}</td>
											</tr>
											<tr>
												<th scope="row"><strong>작업상태</strong></th>
												<td><strong class="${workDisplayClass}">${workDisplay}</strong></td>
											</tr>
											<tr>
												<th scope="row"><strong>등록일시</strong></th>
												<td class="fontVdn"> ${getReqWorkView.regDatetime2}</td>
											</tr>
											<tr>
												<th scope="row"><strong>작업완료일시</strong></th>
												<td class="fontVdn">${getReqWorkView.completeDatetime2}</td>
											</tr>
											<tr>
												<th scope="row"><strong>작업처리내역</strong></th>
												<c:if test ="${getReqWorkView.confirmUserId == userId }">	
												<td><textarea style="height:100px;" placeholder="작업 처리 내용을 입력하세요" id = "work_description" ></textarea></td>
												</c:if>
												<c:if test ="${getReqWorkView.confirmUserId != userId }">	
												<%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>
												<td>${fn:replace(getReqWorkView.description,newLineChar,br)}</td>
												</c:if>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="row tac m-t-60">
							
							
							<c:if test = "${getReqWorkView.completeDatetime2 eq null}">
								<c:if test ="${getReqWorkView.confirmUserId == userId }">
								<a type="button" class="rbton bton_blue" onclick ="workChk()"><i class="fa fa-check"></i>  작업완료</a>
								</c:if>
								<a type="button" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>      
							</c:if>
							<c:if test = "${getReqWorkView.completeDatetime2 ne null}">
								<a type="button" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>      
							</c:if>
							</div>
						</div>
					</c:if>
					
					<c:if test ="${workStatus == 'workComplete' }">							
					<div class="case_01" style="display:block;">
						<div class="formType01">
							<div class="tblWrap clearfix">
								<table>
									<colgroup>
										 <col width="13%">
										 <col width="*">
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><strong>작업자</strong></th>
											<td>${getReqWorkView.workUserName}</td>
										</tr>
										<tr>
											<th scope="row"><strong>작업상태</strong></th>
											<td><strong class="${workDisplayClass}">${workDisplay}</strong></td>
										</tr>
										<tr>
											<th scope="row"><strong>등록일시</strong></th>
											<td class="fontVdn"> ${getReqWorkView.regDatetime2}</td>
										</tr>
										<tr>
											<th scope="row"><strong>작업완료일시</strong></th>
											<td class="fontVdn">${getReqWorkView.completeDatetime2}</td>
										</tr>
										<%-- <tr>
											<th scope="row"><strong>과금적용일시</strong></th>
											<td>
											
												<div class="datepickArea">
													<input type="text" class="applyDate" name="applyDate" style="width:120px;" id ="applyDate"/>
													<div class="selectBox m-l-25" style="width:76px;">
														<label class="selectText" id ="applyTime">${getReqWorkView.time}</label>
														<select class="search-sel" >
															<option  selected="selected" value ="00">${time}</option>
															<c:forEach var="timeHH" begin="0" end="23">
																<c:if test ="${ 10 > timeHH }">
																	<option value="${timeHH}" <c:if test="${getReqWorkView.time == '0'+timeHH}">selected="selected"</c:if> >0${timeHH}</option>
																</c:if>
																<c:if test ="${ 10 <= timeHH }">
																	<option value="${timeHH}" <c:if test="${getReqWorkView.time == timeHH}">selected="selected"</c:if> >${timeHH}</option>
																</c:if>
															</c:forEach>		
														</select>
													</div>
													<span class="txt">시</span>
												</div>												
											</td>
										</tr> --%>
										<tr>
											<th scope="row"><strong>작업처리내역</strong></th>
											
											<%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>
											<td>${fn:replace(getReqWorkView.description,newLineChar,br)}</td>
											
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="row tac m-t-60">
							<%-- <sec:authorize access="hasRole('ROLE_CLOUD_CONFIRM_ACTION')">						
								<a type="button" class="rbton bton_blue" onclick ="workComplete()"><i class="fa fa-check"></i> 작업확인</a>
							</sec:authorize> --%>
							<!-- 과금적용 주석처리 권한 정리후 활성화 예정 -->
								<!-- <a type="button" class="rbton bton_blue" onclick ="workComplete()"><i class="fa fa-check"></i> 작업확인</a> -->
							<a type="button" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>         
						</div>
					</div>
				</c:if>
				
					<c:if test ="${workStatus == 'workCharge' }">							
						<div class="case_01" style="display:block;">
							<div class="formType01">
								<div class="tblWrap clearfix">
									<table>
										<colgroup>
											 <col width="13%">
											 <col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><strong>작업자</strong></th>
												<td>${getReqWorkView.workUserName}</td>
											</tr>
											<tr>
												<th scope="row"><strong>작업상태</strong></th>
												<td><strong class="${workDisplayClass}">${workDisplay}</strong></td>
											</tr>
											<tr>
												<th scope="row"><strong>등록일시</strong></th>
												<td class="fontVdn">${getReqWorkView.regDatetime2}</td>
											</tr>
											<tr>
												<th scope="row"><strong>작업완료일시</strong></th>
												<td class="fontVdn">${getReqWorkView.completeDatetime2}</td>
											</tr>
											<%-- <tr>
												<th scope="row"><strong>과금적용일시</strong></th>
												<td class="fontVdn"> ${getReqWorkView.chargeStartDatetime2}</td>
											</tr> --%>
											<tr>
												<th scope="row"><strong>작업처리내역</strong></th>
												<td>${getReqWorkView.description}</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="row tac m-t-60">
								<a type="button" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>         
							</div>
						</div>
					</c:if>				
				</div>

				
				<!-- #modal-dialog -->
				<div class="modal fade" id="message-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">알림</h4>
	                       </div>
	                       <div class="modal-body">
	                           <h5 id="confirmMsg"></h5>
	                        </div>
	                       	<div class="modal-footer tac" id="setBtn">
	                       		<a type='button' class="btn width-100 btn-default" data-dismiss="modal" onclick="">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
				
				
				
				<!-- #modal-dialog 가상서버검색-->
                <div class="modal fade" id="modal-dialog2">
	               <div class="modal-dialog width-720">
	                   <div class="modal-content width-720">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">가상서버 검색</h4>
                            </div>
                                        <div class="modal-body">
											
											<div class="page_searchBox m-b-15">
													<div class="selectBox width-100" >
														<label class="selectText" for="vm_searchKind">전체</label>
															<select class="search-sel"  id="vm_searchKind" name="vm_searchKind">
															<option value="searchAll">전체</option>
															<option value="hostname_alias">서버명</option>
															<option  value="hostname">호스트명</option>							
															</select>
													</div>
													
													<div class="searchArea">
														<div class="inputArea m-l-5">
															<input type="text" placeholder="검색어를 입력하세요" id="vm_keyword" onkeypress="if(event.keyCode==13)openModal();" class="width-300">
															<a type="button" class="bton-s bton_blue" onclick="gridVMList();"> <i class="fa fa-search"></i> 검색</a>
														</div>
													</div>
											</div>

											<table class="tableV" id="VM-list">
											 <colgroup>
											 <col width="*">
											 <col width="40%">
											 <col width="20%">
											 </colgroup>
											 <thead>
											 <tr class="skyblue">
												 <th class="tac">호스트명</th>
												 <th class="tac">서버명</th>
												 <th class="tac">적용</th>
											 </tr>
											 </thead>
											 <tbody id="popListTable2">
											 
											 </tbody>
											 </table>
											
                                        </div>
										<div class="clear"></div>
										<div class="modal-footer tac">
				                   			<a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="okVMInsert()">확인</a>	 
				                   			<a type="button" class="pbton bton_dgrey" data-dismiss="modal" onclick="">취소</a>

				                       	</div> 
                                    </div>
                                </div>
                            </div>
						<!-- #modal-dialog  가상서버 검색//-->
			
            <!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->
	
	</div>
	<!-- end page container -->
<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>	
	<script type="text/javascript">
	
		function openModal2(){
			$("#modal-dialog2").modal();
			gridVMList();
		}
	
		// 팝업리스트
			function gridVMList(){
				$("#VM-list").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${wasPath}/mbr/oss/vm/catalogueVmlist"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#vm_searchKind option:selected").val();
							d.keyword = $("#vm_keyword").val();
							d.projectName = $("#projectName").val();
							d.projectId = $("#projectId").val();
						}
					}
					,"columns":[
						{"data":"hostname" , "class":"tal"}
						, {"data":"hostnameAlias" , "class":"tal"}
						, {"class":"tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[2], "render": function(data,type,full){
							return '<div class="tac"><a href="#nav-pills-tab-3-view" data-toggle="tab"><input type="button" class="popCheckbtn"  value="&#xf00c" onclick="setVM(this, \''+full.vmUuid+'\',\''+full.hostnameAlias+'\',\''+full.hostname+'\')"></a></div>';
						}	
						}
		 				//, {"targets":[4], "render": function(data,type,full){
						//	return '<div class="col-md-12 tar"><a href="#nav-pills-tab-3-view" data-toggle="tab"><button type="button" data-dismiss="modal" class="btn btn-primary" onclick="setVM(\''+full.vmUuid+'\',\''+full.hostnameAlias+'\')">적용</button></a></div>';
						//}	
						//} 						
					]
					,"language": { 
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
							, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
					}
					,"sDom":'<"top">rt<"bottom"i>'
				});		
			}
		
		
			function setVM(e, vmUuid, vmName, vmHost){
				$("#popListTable2 > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
				hvmUuid = vmUuid;
				hvmName = vmName;
				hvmHost = vmHost;
				
				
				$("#vmUuid").val(hvmUuid);
				$("#vmName").val(hvmName);
				$("#vmHost").val(hvmHost);
				
			}
			
		function okVMInsert(){
		confirmBox("가상서버를 변경하시겠습니까?", confirmOkVMInsert); 
		}
			
		function confirmOkVMInsert(){
			
			$.ajax({
				url : "${contextPath}/mng/req/work/ossServiceVmUpdate",
				dataType : "JSON",
				data : {
					 "vmUuid" : $("#vmUuid").val()
					 ,"reqServiceProductSeq" :  $("#orderProductSeq").val()                         
					
				},
				success : function(data) {
					alertBox("수정되었습니다", reload);
					
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
				}
			});
			
			
		}
			
		
		function inputShow(hide, show, target, text){
			
			$("#"+target).val($("#"+text).text());
			$("#view_tab_service_name_value").val($("#productServiceName").val());
			
			$("#"+hide).hide();
			$("#"+show).show();
		}
		function inputHide(hide, show){
			$("#"+hide).hide();
			$("#"+show).show();
		}
		
		function updateServiceAlias(){
			$.ajax({
				url : "${contextPath}/mng/req/work/serviceUpdate",
				dataType : "JSON",
				data : {
					 "serviceName" : $("#view_tab_service_name_value").val()
					 ,"orderProductSeq" :  $("#orderProductSeq").val()                         
					, "regUserId" : "${userId}"
					, "modUserId" : "${userId}"
				},
				success : function(data) {
					alertBox("수정되었습니다", reload);
					
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
				}
			});
		}
	
		function reload(){
			location.reload();
		}
		
		// 달력
		function calendar(){
			
			var dayName = ['일','월','화','수','목','금','토'];
			var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

			$("#applyDate").datepicker({
				showOn:"both",
				buttonImage:"${contextPath}/resources/assets/img/calen.png",
				buttonImageOnly:true,
				dateFormat : "yy-mm-dd",
				dayNamesMin:dayName,
				monthNamesShort:monthName,
				changeMonth:true,
				minDate:0
			});
			$("img.ui-datepicker-trigger").attr("style", "vertical-align:top;");			
		}
		
		function applyTimePlus(){			
// 			alert($("#applyTime").val());
			
			if($("#applyTime").val()=="23"){
				alert("시간을 정확히 입력해 주세요.");
			}else{
				var applyTime;
				applyTime = Number(rtnnumber($("#applyTime").val())) + 1;
				$("#applyTime").val(applyTime);
			}
		}
		function applyTimeMinus(){
			//alert($("#memcnt").val());
			if($("#applyTime").val()=="0"){
				alert("시간을 정확히 입력해 주세요.");
			}else{
				var applyTime;
				applyTime = Number(rtnnumber($("#applyTime").val())) - 1;
				$("#applyTime").val(applyTime);
			}
		}
		
		function workok(){
			
			
			var reqWorkSeq = $("#reqWorkSeq").val();
			var description = $("#work_description").val();
			var applyDate = $("#applyDate").val();
			var applyTime = $("#applyTime").text();
			var modUserId = "${userId}";
			var orderProductSeq = $("#orderProductSeq").val();
			var chargeStartDatetime = applyDate +" "+ applyTime+":00"
			var productCategory = $("#productCategory").val();
			var requestType = "${getReqWorkView.requestType}";
			var oldId = "${getReqWorkView.oldId}"
		//	var oldId = "${getReqWorkView.oldId}";
		//	var nasGb = "${getReqWorkView.nasGb}";
			
			$.ajax({
				url : "${contextPath}/mng/req/work/workComplete",
				dataType : "JSON",
				type : "POST",
				data : {
					"reqWorkSeq": reqWorkSeq,
					"description": description,
					"productCategory": productCategory,
					"modUserId": modUserId,
					"orderProductSeq": orderProductSeq,
					"chargeStartDatetime": chargeStartDatetime,
					"requestType" : requestType,
					"oldId" : oldId
					//"nasGb" : nasGb,
					//"oldId" : oldId
				},
				success : function(data) {					
					alertBox("작업완료 되었습니다.",moveListPage);					
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});	
		}
		
		function workchkok(){
			var reqWorkSeq = $("#reqWorkSeq").val();
			var modUserId = "${userId}";
			var orderProductSeq = $("#orderProductSeq").val();
			var productCategory = $("#productCategory").val();
			var description = $("#work_description").val();
			var applyDate = $("#applyDate").val();
			var requestType = $("#requestType").val();
			var applyTime = $("#applyTime").text();
			var chargeStartDatetime = applyDate +" "+ applyTime+":00"
			$.ajax({
				url : "${contextPath}/mng/req/work/workChkOk",
				dataType : "JSON",
				type : "POST",
				data : {
					"reqWorkSeq": reqWorkSeq
					, "reqType": requestType
					, "productCategory": productCategory
					, "modUserId": modUserId
					, "orderProductSeq": orderProductSeq
					, "chargeStartDatetime": chargeStartDatetime
					, "description" :description					 
				},
				success : function(data) {			
					
					workok();
					
					//alertBox("작업완료 되었습니다.",moveListPage);					
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});	
		}


		// 작업완료 처리
		function workComplete(){
		 	if($("#applyDate").val()==""){
				//alert("과금적용 일자을 입력하세요");
				alertBox3("과금적용 일자을 입력하세요");
				//$("#applyDate").focus();
				return false;
			} 
			confirmBox("과금이 적용됩니다.<br/>작업확인 하시겠습니까?",workok);
		}
		
		// 작업완료 처리
		function workChk(){
			confirmBox("작업을 완료 하시겠습니까?",workchkok);
			
		}
		
		function calendar(){
			
			var dayName = ['일','월','화','수','목','금','토'];
			var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

			$(".applyDate").datepicker({
				showOn:"both",
				buttonImage:"/resources/mng/assets/img/ico_datepicker_cal.png",
				buttonImageOnly:true,
				dateFormat : "yy-mm-dd",
				dayNamesMin:dayName,
				monthNamesShort:monthName,
				changeMonth:true,
				minDate:0
			});
			$("img.ui-datepicker-trigger").attr("style", "vertical-align:top;");
			$(".applyDate").val($.datepicker.formatDate('yy-mm-dd', new Date()));
		}
		
		
	
		function moveListPage(){
			location.href="${contextPath}/mng/req/work/";
		}
	
	
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
		
		$(document).ready(function() {
		    App.init();
		    calendar();
			 var obj ={
					// upComapnyName :  '${getReqWorkView.upCompanyName}',
					// customerName : '${getReqWorkView.customerName}'
					 
			 }	
			 
				function inputShow(hide, show, target, text){
					$("#"+target).val($("#"+text).text());
					$("#"+hide).hide();
					$("#"+show).show();
				}
				function inputHide(hide, show){
					$("#"+hide).hide();
					$("#"+show).show();
				}
			 
		    
			$("a>button").on('click',function(){
			location.href = $(this).closest("a").attr("href");
			});

			//메뉴활성화
			$("#req").addClass("active");
			$("#workManage").addClass("active");
			
			//setNetworkVal();
					
		});
		
	</script>
	</body>
</html>