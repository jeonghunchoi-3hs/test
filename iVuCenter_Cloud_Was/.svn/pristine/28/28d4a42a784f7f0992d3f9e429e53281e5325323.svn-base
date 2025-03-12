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
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 프로젝트 자원 관리 <span class="root">관리자포털 > 프로젝트 관리 > 자원 관리</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			 <div class="row mb50">
			
	         	<!-- begin col-12 -->
	         	<div class="section-container inbox100"style='display:none;'>
	                	
	                <!-- begin panel -->
					<!-- begin normal input table---------->
					<div class="tableC">
						<input type="hidden" id="hid_projectId" value="${projectId}">
						<input type="hidden" id="hid_projectName" value="${projectName}">
						<input type="hidden" id="hid_customerId" value="">
						<table>
							<colgroup>
								<col width="20%">
								<col width="80%">
							</colgroup>
							<tbody>
								<tr>
									<td class="left-b height-40">사업자</td>
								  	<td class="f14 fb">
										<div class="col-md-6" id="companyName"></div>
								  	</td>
								</tr>
								<tr>
									<td class="left-b height-40">회원사</td>
								  	<td class="f14 fb">
										<div class="col-md-6" id="customerName"></div>
								  	</td>
								</tr>										
								<tr>
									<td class="left-b height-40">프로젝트 명</td> 
								  	<td class="f14 fb">
										<div class="col-md-6" id="projectName"></div>
								  	</td>
								</tr>
								<tr>
									<td class="left-b height-40">프로젝트 별칭</td>
								  	<td class="f14 fb">
										<div class="col-md-6" id="projectAlias"></div>
								  	</td>
								</tr>
								<tr>
									<td class="left-b height-40">프로젝트 PM</td>
								  	<td class="f14 fb pl20" >
										<div class="dpin" id="userName"></div>
<!-- 										<input type="button" id="projectPmPopList" name="projectPmPopList" value="PM설정" onclick="openModal();" class="btn btn-primary" /> -->
										<button type="button" id="projectPmPopList" name="projectPmPopList" onclick="openModal();" class="btn btn-primary" > PM설정</button>
								  	</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- end normal input table---------->
					<!-- end panel -->
						
					<!-- begin button-->
					<div class="col-md-12 tac mt20">						
						<sec:authorize access="hasRole('ROLE_CLOUD_ADMIN')">
	<%-- 					 	<a href="okprojectExpr.do?projectId=${getOkProjectView.projectId}"><button type="button" class="btn btn-danger width-80">해지</button> </a> --%>
<%-- 	                     	<a href="okProjectInsert.do?projectId=${getOkProjectView.projectId}"><button type="button" class="btn btn-lime width-80">수정</button></a> --%>
<!-- 	                     	<input type="button" id="noticeList" value="수정" class="btn btn-lime width-100" onclick="moveInsertPage()">  -->
	                     	<button type="button" id="noticeList" class="btn btn-lime" onclick="moveInsertPage()"><i class="fa fa-edit"> </i> 수정 </button> 
						 </sec:authorize>
<!-- 	                    <input type="button" id="noticeList" value="목록" class="btn btn-grey width-100" onclick="moveListPage()"> -->
	                    <button class="btn btn-grey"  id="noticeList"  onclick="moveListPage()"><i></i> 목록</button>
					</div>
					<!-- end button -->
				</div>
                <!-- end col-12 -->


				<!---여기서부터사용---->
                <!-- begin col-6 -->
                <div class="col-md-12 mt20">
                	<!-- begin nav-pills -->
                    <ul class="nav nav-pills nav-pills-primary">
                    	<!-- <li class="active"><a href="#nav-pills-tab-1" data-toggle="tab" onclick="gridBillList()"><i class="fa fa-won"></i>  청구요금</a></li> -->
<!-- 	                    <li><a href="#nav-pills-tab-2" data-toggle="tab" style='display:none;'><i class="fa fa-user"></i> 사용자</a></li> -->
	                    <li class="active"><a href="#nav-pills-tab-3" data-toggle="tab" onclick="gridVMList()"><i class="fa fa-cloud"></i> 가상서버</a></li>
 						<li><a href="#nav-pills-tab-4" data-toggle="tab" onclick="gridSubList()"><i class="fa fa-cubes"></i> 부가자원</a></li>
						<li><a href="#nav-pills-tab-14" data-toggle="tab" onclick="gridServiceList()"><i class="fa fa-share-alt"></i> 서비스</a></li>
						<!-- <li><a href="#nav-pills-tab-5" data-toggle="tab" onclick="gridNetworkList()"><i class="fa fa-share-alt"></i> 네트워크</a></li> -->
						<!-- <li><a href="#nav-pills-tab-quota" data-toggle="tab" onclick="detailQuota()"><i class="fa fa-share-alt"></i> Quota</a></li> -->
						<!-- <li style="display: none;"><a href="#nav-pills-tab-9" data-toggle="tab"><i class="fa fa-pencil-square-o"></i> 계약관리</a></li> -->
						<!-- <li><a href="#nav-pills-tab-11" data-toggle="tab" onclick="gridList()"><i class="fa fa-percent"></i> 할인률관리</a></li> -->
                    
                    </ul>
                    <!-- end nav-pills -->
                    <!-- begin tab-content -->
                    <div class="tab-content panel t-sblue col-md-12">
                    
                    	<!-- tab1 시작 -->
	                    <div class="tab-pane fade" id="nav-pills-tab-1">
							<!-- search begin -->
							<div class="col-md-12 br5 p10 mb10 bgee">	
								<div class="col-md-1 pt8 tar pl0 pr0">과금년월</div>
								<div class="col-md-2">
									<select class="form-control w70 dpin pb6" id="billYear">
									</select>
									<span>년</span>
								</div>
								<div class="col-md-2">
									<select class="form-control w70 dpin pb6" id="billMonth">
									<option value="">전체</option>
									<option value="01">01</option>
									<option value="02">02</option>
									<option value="03">03</option>
									<option value="04">04</option>
									<option value="05">05</option>
									<option value="06">06</option>
									<option value="07">07</option>
									<option value="08">08</option>
									<option value="09">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									</select>
									<span>월</span>
								</div>
								<div class="col-md-5"></div>
								<div class="col-md-2 tar flr"><a href="#"><button type="button" class="btn btn-grey" onclick="gridBillList();"><i class="fa fa-search"></i> 검색</button></a></div>
							</div>			
							<!-- search end -->
							
							<!-- 테이블시작 -->
							<div class="col-md-12 pl0 pr0">
								<div class="panel">
									<div class="table-responsive">
										<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="charge-list">
											 <colgroup>
											 <col width="10%">
											 <col width="20%">
											 <col width="30%">
											 <col width="10%">
											 <col width="10%">
											 <col width="10%">
											 <col width="10%">
											 <col width="5%">
											 </colgroup>
											<thead>
												<tr class="grey">
													<th class="tac">청구년월</th>
													<th class="tac">회원사아이디</th>
													<th class="tac">회원사</th>
													<th class="tac">프로젝트아이디</th>
													<th class="tac">프로젝트명</th>
													<th class="tac">사용요금</th>
													<th class="tac">보정금액</th>
													<th class="tac">할인금액</th>
													<th class="tac">청구요금</th>
													<th class="tac">상세</th>
												</tr>
											</thead>
											<tbody>
												
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<!-- 테이블 끝 -->
                        </div>
                        <!-- tab1 종료 -->
                        
                        <!-- tab2 시작 -->
                        <div class="tab-pane fade" id="nav-pills-tab-2">
                        	<div class="col-md-12">
						    	<!--- begin left content------>
								<div class="col-md-6 br1px">
						        	<!---- begin left search---->
									<div class="row br5 p10 mb10 bgee">		
										<div class="col-md-9">
											<input type="text" class="form-control" placeholder="검색어를 입력하세요" />
										</div>
							    		<div class="col-md-3">
							    			<a href="#modal-dialog" data-toggle="modal"><button type="button" class="btn btn-grey"><i class="fa fa-search"></i> 검색 </button></a> 
							    		</div>
							    	</div>
									<!---- end left search---->

									<div class="col-md-12 p5">
								<li class="col-md-9"><h5>홍길동</h5></li>
								<li class="col-md-3"><button type="button" class="btn btn-primary width-80">추가</button></li>

								<li class="col-md-9"><h5>김긷동길동</h5></li>
								<li class="col-md-3"><button type="button" class="btn btn-primary width-80">추가</button></li>
								
								<li class="col-md-9"><h5>스티브 잡~스</h5></li>
								<li class="col-md-3"><button type="button" class="btn btn-primary width-80">추가</button></li>
								</div>
							</div>
							<!---end left content------>
						
						
							<!--- begin right content------>
							<div class="col-md-6 bl1px ml-1">
							     <!---- begin right search---->
								<div class="row br5 p10 mb10 bgee">		
									<div class="col-md-9">
									<input type="text" class="form-control" placeholder="검색어를 입력하세요" />
									</div>
								    <div class="col-md-3"><a href="#"><button type="button" class="btn btn-grey"><i class="fa fa-search"></i> 검색</button></a> 
								    </div>
								</div>
								<!---- end right search---->
									<div class="col-md-12 p5">
									<li class="col-md-6"><h5>첫번째사람</h5></li>
									<li class="col-md-3">
										<select class="form-control pb6">
										<option>권한1</option>
										<option>권한2</option>
										<option>권한3</option>
										</select>
									</li>
									<li class="col-md-3"><button type="button" class="btn btn-primary width-80">추가</button></li>
									<div class="clear"></div>
									<li class="col-md-6"><h5>두번째인물</h5></li>
									<li class="col-md-3">
										<select class="form-control pb6">
										<option>권한1</option>
										<option>권한2</option>
										<option>권한3</option>
										</select>
									</li>
									<li class="col-md-3"><button type="button" class="btn btn-primary width-80">추가</button></li>
									<div class="clear"></div>
									<li class="col-md-6"><h5>세번째위인</h5></li>
									<li class="col-md-3">
										<select class="form-control pb6">
										<option>권한1</option>
										<option>권한2</option>
										<option>권한3</option>
										</select>
									</li>
									<li class="col-md-3"><button type="button" class="btn btn-primary width-80">추가</button></li>
									<div class="clear"></div>
									<li class="col-md-6"><h5>네번째위인</h5></li>
									<li class="col-md-3">
										<select class="form-control pb6">
										<option>권한1</option>
										<option>권한2</option>
										<option>권한3</option>
										</select>
									</li>
									<li class="col-md-3"><button type="button" class="btn btn-primary width-80">추가</button></li>
									<div class="clear"></div>
									<li class="col-md-6"><h5>다섯번째의인</h5></li>
									<li class="col-md-3">
										<select class="form-control pb6">
										<option>권한1</option>
										<option>권한2</option>
										<option>권한3</option>
										</select>
									</li>
									<li class="col-md-3"><button type="button" class="btn btn-primary width-80">추가</button></li>
									</div>
							</div>
							<!--- end right content------>	
						</div>
						<div class="col-md-12 tar pt10"> <button type="button" class="btn btn-lime width-80">저장</button></div>
					</div>
							
					<!-- #modal-dialog -->
					<div class="modal fade" id="modal-dialog">
                    	<div class="modal-dialog modal-sm">
                        	<div class="modal-content">
                            	<div class="modal-header">
                                	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                    <h4 class="modal-title fw">사용자검색</h4>
                                </div>
                                <div class="modal-body p1510">
									<div class="col-md-12 pr0 pl0">
                                    	<div class="col-md-3 pr0 pl0 pt10">사용자명</div>
								   		<div class="col-md-7 pr0 pl0"><input type="text" class="form-control w90"/></div>
								   		<div class="col-md-2 pl0 tar">
											<a role="tab" id="headingThree" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
											<button type="button" class="btn btn-grey width-50">검색</button> </a></div>
								   		</div>
								   		<div class="col-md-12 mb20 panel-collapse collapse mt20" id="collapseThree" role="tabpanel" aria-labelledby="headingThree">
								   			<li>검색했을때 나오는 사람들 목록</li>
								   			<li>김길동</li>
								   			<li>이길동</li>
								   			<li>이사람</li>
								   			<li>저사람</li>
								   		</div>
								</div>
								<div class="clear"></div>
                              	<div class="modal-footer tac mt20">
                                  	<a type='button' class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
								</div>
							</div>
						</div>
					</div>
					<!-- #modal-dialog 끝 -->	
					
				<!-- 탭3 시작 -->		
				<div class="tab-pane fade active in pl0 pr0" id="nav-pills-tab-3">
				
					<!-- search begin -->
					<div class="col-md-12 br5 p10 mb10 bgee">		
						<div class="col-md-2">
							<select class="form-control dp-in pb6" id="vm_searchKind">
								<option value="">전체</option>
								<option value="hostname_alias">서버명</option>
								<option value="hostname">호스트명</option>
							</select>
						</div>
						<div class="col-md-7"><input type="text" class="form-control" placeholder="검색어를 입력하세요" id="vm_keyword"/></div>
					   	<div class="col-md-1 tar"><a href="#"><button type="button" class="btn btn-grey" onclick="gridVMList()"><i class="fa fa-search"></i> 검색</button></a></div>
					   	<div class="col-md-2 tar"><a href="#"><button type="button" class="btn btn-primary_04" onclick="gridVMList()"><i class="fa fa-refresh"></i> 새로고침</button></a></div>
					</div>
					<!-- search end -->
					
					<!-- 테이블시작 -->
					<div class="col-md-12 pl0 pr0">
						<div class="panel">
							<div class="table-responsive">
								<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="VM-list">
									<thead>
										<tr class="grey">
											<th>호스트명별칭</th>
											<th>호스트명</th>
											<th>네트워크</th>
											<th>vCPU</th>
											<th>MEM</th>
											<th>DISK</th>
											<th>상태</th>
											<th>전원상태</th>
											<th>정지</th>
											<th>시작</th>
											<th>재시작</th> 
											<th>상세보기</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				<!-- 테이블 끝 -->
				</div>
				<!-- 탬3 끝 -->
					
				<!-- 탭3 상세 -->		
				<div class="tab-pane fade" id="nav-pills-tab-3-view">
					<h5>ㆍ가상서버 정보</h5>
					<div class="tableC">
						<input type='hidden' id="vm_view_tab_vmUuid" />
						<table>
							<colgroup>
								<col width="30%">
								<col width="70%">
							</colgroup>
							<tbody>
								<tr>
								    <td class="left-b p10">서버명</td>
									<td class="p10"><input type="text" class="form-control" id="vm_view_tab_hostnameAlias"/></td>
								</tr>
								<tr>
								    <td class="left-b p10">호스트명</td>
									<td class="p10"><div id="vm_view_tab_hostname"></div></td>
								</tr>
								<tr>
								<tr>
								    <td class="left-b p10">네트워크</td>
									<td class="p10"><div id="vm_view_tab_ipAddr"></div></td>
								</tr>
								<tr>
								    <td class="left-b p10">vCPU</td>
									<td class="p10"><div id="vm_view_tab_vcpus"></div></td>
								</tr>
								<tr>
								    <td class="left-b p10">MEMORY</td>
									<td class="p10"><div id="vm_view_tab_memGb"></div></td>
								</tr>
								<tr>
								    <td class="left-b p10">DISK</td>
									<td class="p10"><div id="vm_view_tab_diskGb"></div></td>
								</tr>
								<tr>
								    <td class="left-b p10">상태</td>
									<td class="p10"><div id="vm_view_tab_status"></div></td>
								</tr>	
								<tr>
								    <td class="left-b p10">전원상태</td>
									<td class="p10"><div id="vm_view_tab_power"></div></td>
								</tr>	
								<tr>
								    <td class="left-b p10">생성 일시</td>
									<td class="p10"><div id="vm_view_tab_regDatetime"></div></td>
								</tr>																																									
							</tbody>
						</table>
					</div>
					<div class="col-md-12 tar pt10"> 
						<button type="button" class="btn btn-lime" onclick="updateHostNameAlias()">저장</button>
						<!-- <a href="#nav-pills-tab-5" data-toggle="tab"><button type="button" class="btn btn-grey">목록</button></a> -->
						<a href="#nav-pills-tab-3" data-toggle="tab"><button type="button" class="btn btn-grey" onclick='gridVMList()'>목록</button></a>
					</div>	
				</div>
				<!-- 탬3 끝 -->

				
				<!-- 탭4 시작 -->
				<div class="tab-pane fade" id="nav-pills-tab-4">
					<div id="divDiskList" style='display:none;'>
						<!-- 테이블시작 -->
						<div class="col-md-12 pl0 pr0">
							<div class="panel mb0">
								<div class="table-responsive">
									<h5 class="m24 fc_grey mb0 box_grey" id="h5Disk1"><i class="fa fa-caret-right"></i> 블록디스크 목록이 없습니다</h5>
									<div id="h5Disk2" style='display:none;'>
									<h5 class="ml24 fcb"><i class="fa fa-caret-right"></i> 블록디스크</h5>
									<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="disk-list">
										<thead>
											<tr class="grey">
												<th>디스크명</th>
												<th>크기</th>
												<th>과금단위</th>
												<th>연결된곳</th>
												<th>연결관리</th>
												<th>자원 가입일시</th>
												<th>상세보기</th>
											</tr>
										</thead>
									</table>
									</div>
								</div>
							</div>
						</div>
					
					<!-- 테이블시작 -->
							<div class="col-md-12 pl0 pr0">
								<div class="panel">
									<div class="table-responsive">
										<!-- 디스크 -->
										
			<!-- =====================================  nas 리스트 시작  ========================================================= -->	
	
									<div id="nas-listall">	
										<c:if test='${getNasList.size() eq 0}'>
										<h5 class="m24 fc_grey mb0 box_grey"><i class="fa fa-caret-right"></i> NAS 목록이 없습니다</h5>
										</c:if>
										<c:if test='${getNasList.size() ne 0}'>
										<h5 class="ml24 fcb"><i class="fa fa-caret-right"></i> NAS</h5>
										
										<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="nas-list">
											<colgroup>
												 <col width="*">
												 <col width="150px">
												 <col width="100px">
												 <col width="100px">
												 <col width="300px">																						
												 <col width="100px">												
											 </colgroup>	
											<thead>
												<tr class="grey">
													<th>NAS 이름</th>
													<th>가상서버</th>
													<th>NAS 용량</th>
													<th>과금단위</th>													
													<th>자원 가입일시</th>
													<th>상세보기</th>
												</tr>												
											</thead>
											<tbody>
											<c:forEach items="${getNasList}" var="getNasList" varStatus="status" >												
												<tr>
													<td class="tac">
														${getNasList.nasName}
													</td>
													<td class="tac">
														${getNasList.vmName}
													</td>
													<td class="tac">
														${getNasList.nasGb}
													</td>
													<td class="tac">														
														<c:choose>
															<c:when test="${getNasList.hourlyFlag eq 'N'}">
																월 단위
															</c:when>
															<c:otherwise>
																시간 단위
															</c:otherwise>
														</c:choose>
													</td>
													<td class="tac">
														${getNasList.createDatetime}
													</td>
													<td class="tac">
														<button type="button" class="btn btn-grey_01" onclick="nasview('${getNasList.nasId}')"><i id="s${getNasList.nasId}" name="s${getNasList.nasId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
														<input type="hidden" id="c${getNasList.nasId}" name="c${getNasList.nasId}" value="0" />
													</td>
												</tr>
												<tr id="v${getNasList.nasId}" name="v${getNasList.nasId}" style="display:none">
													<td colspan="6" class="p20">
														<div class="tableD">
						         						<table>
						         							<colgroup>
																 <col width="*">																 																						
															 </colgroup>
						         							 <thead>
																 <tr>
																	 <th>비고</th> 																																																	 
																 </tr>
															 </thead>
															 <tbody>
															 	<tr>
															 		<td class="tac">
															 			${getNasList.description}
															 		</td>															 																 		
															 	</tr>	
															 </tbody>
						         						</table>
						         						</div>
													</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
										</c:if>
							</div>										
										
	<!-- =====================================  nas 리스트 끝  ========================================================= -->		
	
	<!-- =====================================  nas 상세시작  ========================================================= -->									
										
							<div id="nasView" style='display:none;'>
								<h5>ㆍNAS 상세 정보</h5>
								<div class="tableC">									
									<table>
										<colgroup>
									 		<col width="150px">
									 		<col width="*">	
										</colgroup>
										<tbody>
											<tr>
											    <td class="left-b">NAS 이름</td>
												<td class="p10"><input type="text" class="form-control" id="editnasName2" name="editnasName2" /></td>
											</tr>
											<tr>
											    <td class="left-b">가상서버</td>
												<td class="p10"><input type="text" class="form-control" id="editnasVm2" name="editnasVm2"/></td>
											</tr>										
											<tr>
											    <td class="left-b">NAS 용량</td>
												<td class="p10"><input type="text" class="form-control" style="border:0px;background-color:#fff;" id="editnasGb2" name="editnasGb2"/></td>
											</tr>
											<tr>																														
											<tr>
											    <td class="left-b">자원 가입일시</td>
											    <td class="p10"><input type="text" class="form-control" style="border:0px;background-color:#fff;" id="editcreateDatetime2" name="editcreateDatetime2" readonly="readonly"></td>
											</tr>
											<tr>
											    <td class="left-b">설명</td>
												<td class="p10">
													<textarea class="form-control" rows="2" placeholder="설명을 입력하세요" name="editnasdescription2" id="editnasdescription2"></textarea>
													<input type="hidden" class="form-control" id="editnasId2" name="editnasId2" />
												</td>
											</tr>												
										</tbody>
									</table>
								</div>
								<div class="col-md-12 tar pt10" id='divBtnNas'>									
									<button type="button" class="btn btn-grey" onclick='naslistview()'>목록</button>
								</div>
							</div>
							

	<!-- =====================================  nas 상세끝  ========================================================= -->	
	
	<!-- =====================================  LB 리스트 시작  ========================================================= -->
									<div id="lb-listall">
															
										<c:if test='${getLbList.size() eq 0}'>
										<h5 class="m24 fc_grey mb0 box_grey"><i class="fa fa-caret-right"></i> 로드밸런서 목록이 없습니다</h5>
										</c:if>
										<c:if test='${getLbList.size() ne 0}'>
										<h5 class="ml24 fcb"><i class="fa fa-caret-right"></i> 로드밸런서</h5>
										<!-- loadbalancer -->
										<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="lb-list">
											<colgroup>
												 <col width="*">
												 <col width="100px">
												 <col width="100px">
												 <col width="300px">																						
												 <col width="100px">												
											 </colgroup>
											<thead>
												<tr class="grey">
													<th>로드밸런서 이름</th>
													<th>과금단위</th>
													<th>네트워크</th>
													<th>자원 가입일시</th>													
													<th>상세보기</th>													
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${getLbList}" var="getLbList" varStatus="status" >												
												<tr>
													<td class="tac">
														${getLbList.loadbalancerName}
													</td>													
													<td class="tac">														
														<c:choose>
															<c:when test="${getLbList.hourlyFlag eq 'N'}">
																월 단위
															</c:when>
															<c:otherwise>
																시간 단위
															</c:otherwise>
														</c:choose>
													</td>
													<td class="tac">
														${getLbList.networkAlias}
													</td>
													<td class="tac">
														${getLbList.createDatetime}
													</td>
													<td class="tac">
														<button type="button" class="btn btn-grey_01" onclick="lbview('${getLbList.loadbalancerId}')"><i id="s${getLbList.loadbalancerId}" name="s${getLbList.loadbalancerId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
														<input type="hidden" id="c${getLbList.loadbalancerId}" name="c${getLbList.loadbalancerId}" value="0" />
													</td>
												</tr>
												<tr id="v${getLbList.loadbalancerId}" name="v${getLbList.loadbalancerId}" style="display:none">
													<td colspan="5" class="p20">
														<div class="tableD">
						         						<table>
						         							<colgroup>
																 <col width="100px">
																 <col width="100px">
																 <col width="150px">
																 <col width="100px">
																 <col width="*">																 																 						
															 </colgroup>
						         							 <thead>
																 <tr>
																 	 <th>가상서버</th>
																 	 <th>Protocal</th>
																 	 <th>Method</th>
																 	 <th>Monitor Type</th>
																	 <th>비고</th> 																													 
																 </tr>
															 </thead>
															 <tbody>
															 	<tr>
															 		<td class="tac">
															 			${fn:replace(getLbList.loadbalancerVm,"|",",<br/>")}
															 		</td>
															 		<td class="tac">
															 			${getLbList.protocolName}
															 		</td>
															 		<td class="tac">
															 			${getLbList.methodName}
															 		</td>
															 		<td class="tac">
															 			${getLbList.monitorTypeName}
															 		</td>
															 		<td class="tac">
															 			${getLbList.description}
															 		</td>															 		
															 	</tr>	
															 </tbody>
						         						</table>
						         						</div>
													</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
										</c:if>
								</div>	
	<!-- =====================================  LB 리스트 끝  ========================================================= -->	
	
			<!-- =====================================  LB 상세 시작  ========================================================= -->
								<div  id="lbview" name="lbview" style="display:none">
										<h5>ㆍ 로드밸런서 정보 </h5>
										<div class="tableC">											
											<table>
												<colgroup>
												 	<col width="150px">												
												 	<col width="*">												 											
											 	</colgroup>
												<tr>
													<td class="left-b">
														로드밸런서 이름
													</td>
													<td class="p10">
														<input type="text" class="form-control" id="editlbName2" name="editlbName2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>
													<td class="left-b">
														네트워크
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editlbNetworkAlias2" name="editlbNetworkAlias2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>
													<td class="left-b">
														Protocol
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editlbProtocolName2" name="editlbProtocolName2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>
													<td class="left-b">
														Method
													</td>
													<td class="p10">													
														<input type="text" class="form-control" id="editlbMethodName2" name="editlbMethodName2" style="border:0px;background-color:#fff;" />												
													</td>
												</tr>
												<tr>
													<td class="left-b">
														Monitor Type
													</td>
													<td class="p10">															
														<input type="text" class="form-control" id="editlbMonitorTypeName2" name="editlbMonitorTypeName2" style="border:0px;background-color:#fff;" />												
													</td>
												</tr>
												<tr>
													<td class="left-b">
														가상서버
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editlbLoadbalancerVm2" name="editlbLoadbalancerVm2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>	
													<td class="left-b">
														생성일자
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editlbCreateDatetime2" name="editlbCreateDatetime2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>
													<td class="left-b">
														설명
													</td>
													<td class="p10">		
														<textarea class="form-control" rows="2" placeholder="설명을 입력하세요" name="editlbdescription2" id="editlbdescription2"></textarea>
														<input type="hidden" class="form-control" id="editloadbalancerId2" name="editloadbalancerId2" />

													</td>
												</tr>
											</table>
											
										</div>	
										
										<div class="col-md-12 tar pt10" id='divBtnLb'>											
											<button type="button" class="btn btn-grey" onclick='lblistview()'>목록</button>
										</div>									
									</div>									
	
	<!-- =====================================  LB 상세 끝  ========================================================= -->
	
		<!-- =====================================  IP 리스트 시작  ========================================================= -->
						<div id="ip-listall">
														
										<c:if test='${getIpList.size() eq 0}'>
										<h5 class="m24 fc_grey mb0 box_grey"><i class="fa fa-caret-right"></i> 공인 IP 목록이 없습니다</h5>
										</c:if>
										<c:if test='${getIpList.size() ne 0}'>
										<h5 class="ml24 fcb"><i class="fa fa-caret-right"></i> 공인 IP</h5>
										<!-- ip -->
										<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="ip-list">
											<colgroup>
												 <col width="*">
												 <col width="100px">
												 <col width="100px">
												 <col width="300px">																						
												 <col width="100px">												
											 </colgroup>
											<thead>
												<tr class="grey">
													<th>과금단위</th>													
													<th>호스트명</th>
													<th>호스트 별칭</th>
													<th>자원 가입일시</th>
													<th>상세보기</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${getIpList}" var="getIpList" varStatus="status" >												
												<tr>																										
													<td class="tac">														
														<c:choose>
															<c:when test="${getIpList.hourlyFlag eq 'N'}">
																월 단위
															</c:when>
															<c:otherwise>
																시간 단위
															</c:otherwise>
														</c:choose>
													</td>
													<td class="tac">
														${getIpList.hostname}
													</td>
													<td class="tac">
														${getIpList.hostnameAlias}
													</td>
													<td class="tac">
														${getIpList.createDatetime}
													</td>
													<td class="tac">
														<button type="button" class="btn btn-grey_01" onclick="ipview('${getIpList.publicipId}')"><i id="s${getIpList.publicipId}" name="s${getIpList.publicipId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
														<input type="hidden" id="c${getIpList.publicipId}" name="c${getIpList.publicipId}" value="0" />
													</td>
												</tr>
												<tr id="v${getIpList.publicipId}" name="v${getIpList.publicipId}" style="display:none">
													<td colspan="5" class="p20">
														<div class="tableD">
						         						<table>
						         							<colgroup>
																 <col width="*">																 	
															 </colgroup>
						         							 <thead>
																 <tr>
																	 <th>비고</th>																															 
																 </tr>
															 </thead>
															 <tbody>
															 	<tr>
															 		<td class="tac">
															 			${getIpList.description}
															 		</td>															 		
															 	</tr>	
															 </tbody>
						         						</table>
						         						</div>
													</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
										</c:if>
								</div>				
	<!-- =====================================  IP 리스트 끝  ========================================================= -->
	
		<!-- =====================================  IP 상세시작  ========================================================= -->
	
									<div id="ipview" name="ipview" style="display:none">
										<h5>ㆍ공인 IP 정보</h5>
										<div class="tableC">	
											<table>
												<colgroup>
												 	<col width="200px">												
												 	<col width="*">												 											
											 	</colgroup>
												<tr>
													<td class="left-b">
														호스트명
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editipHostname2" name="editipHostname2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>
													<td class="left-b">
														호스트 별칭
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editipHostnameAlias2" name="editipHostnameAlias2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>	
													<td class="left-b">
														생성일자
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editipcreateDatetime2" name="editipcreateDatetime2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>
													<td class="left-b">
														설명
													</td>
													<td class="p10">														
														<textarea class="form-control" rows="2" placeholder="설명을 입력하세요" name="editipdescription2" id="editipdescription2"></textarea>
														<input type="hidden" class="form-control" id="editipId2" name="editipId2" />
													</td>
												</tr>
											</table>										
										</div>	
										<div class="col-md-12 tar pt10" id='divBtnIp'>											
											<button type="button" class="btn btn-grey" onclick='iplistview()'>목록</button>
										</div>									
									</div>
									
	<!-- =====================================  IP 상세끝  ========================================================= -->
	
									</div>
								</div>
							</div>
						<!-- 테이블 끝 -->
						
				</div>
			
				<div id="divDiskView" style='display:none;'>
						<h5>ㆍ블록디스크 상세 정보</h5>
						<div class="tableC">
							<input type='hidden' id="disk_view_diskId" />
							<table>
								<colgroup>
							 		<col width="150px">
							 		<col width="*">	
								</colgroup>
								<tbody>
									<tr>
									    <td class="left-b">디스크명</td>
										<td class="p10"><input type="text" class="form-control" style="border:0px;background-color:#fff;" id="disk_view_diskName" readonly="readonly"></td>
									</tr>										
									<tr>
									    <td class="left-b">별칭</td>
										<td class="p10"><input type="text" class="form-control" id="disk_view_diskAlias"/></td>
									</tr>
									<tr>
									<tr>
									    <td class="left-b">크기</td>
										<td class="p10"><input type="text" class="form-control" style="border:0px;background-color:#fff;" id="disk_view_size" readonly="readonly"></td>
									</tr>
									<!-- 
									<tr>
									    <td class="left-b">상태</td>
										<td class="p10"><div id="disk_view_status"></div></td>
									</tr>
									<tr>
									    <td class="left-b">유형</td>
										<td class="p10"><div id="disk_view_volumeType"></div></td>
									</tr>
									<tr>
									    <td class="left-b">부팅가능</td>
										<td class="p10"><div id="disk_view_bootable"></div></td>
									</tr>																							
									<tr>
									    <td class="left-b">암호화</td>
										<td class="p10"><div id="disk_view_encrypted"></div></td>
									</tr>	
									 -->										
									<tr>
									    <td class="left-b">연결된곳</td>
										<td class="p10">
											<input type="text" class="form-control" style="float:left;width:80px;border:0px;background-color:#fff;" id="disk_view_attachments" readonly="readonly">
											<input type="text" class="form-control" style="float:left;width:500px;border:0px;background-color:#fff;" id="disk_view_hostname" readonly="readonly">
										</td>
									</tr>
									<!-- 
									<tr>
									    <td class="left-b">과금단위</td>
										<td class="p10"><div id="disk_view_hourlyFlag"></div></td>
									</tr>
									 -->											
									<tr>
									    <td class="left-b">생성 일시</td>
									    <td class="p10"><input type="text" class="form-control" style="border:0px;background-color:#fff;" id="disk_view_regDatetime2" readonly="readonly"></td>
									</tr>
									<tr>
									    <td class="left-b">비고</td>
										<td class="p10"><textarea class="form-control" rows="2" placeholder="설명을 입력하세요" name="disk_view_description" id="disk_view_description"></textarea></td>
									</tr>												
								</tbody>
							</table>
						</div>
						
						<div class="col-md-12 tar pt10" id='divBtnDisk'>
							<button type="button" class="btn btn-grey" onclick='gridDiskList()'>목록</button>
						</div>
					</div>
						
						
				</div>
				<!-- 탭4 종료 -->
				
				<!-- 탭14 시작 -->
				<div class="tab-pane fade" id="nav-pills-tab-14">
					<!-- 테이블시작 -->
							<div class="col-md-12 pl0 pr0">
								<div class="panel">
									<div class="table-responsive">										
	
	<!-- ======================================== 백업 서비스 시작 ====================================================== -->		
							<div id="bak-listall">						
										<c:if test='${getBakList.size() eq 0}'>
										<h5 class="m24 fc_grey mb0 box_grey"><i class="fa fa-caret-right"></i> 백업 서비스 목록이 없습니다</h5>
										</c:if>
										<c:if test='${getBakList.size() ne 0}'>
										<h5 class="ml24 fcb"><i class="fa fa-caret-right"></i> 백업 서비스</h5>
										<!-- 백업 서비스 -->
										<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="bak-list">
											<colgroup>
												 <col width="150px">
												 <col width="150px">
												 <col width="150px">
												 <col width="*">																																		 																						
												 <col width="100px">												
											 </colgroup>
											<thead>
												<tr class="grey">
													<th>과금단위</th>
													<th>호스트명</th>
													<th>호스트 별칭</th>
													<th>서비스 시작일시</th>																								
													<th>상세보기</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${getBakList}" var="getBakList" varStatus="status" >												
												<tr>																										
													<td class="tac">								
														<c:choose>
															<c:when test="${getBakList.hourlyFlag eq 'N'}">
																월 단위
															</c:when>
															<c:otherwise>
																시간 단위
															</c:otherwise>
														</c:choose>
													</td>
													<td class="tac">
														${getBakList.hostname}
													</td>
													<td class="tac">
														${getBakList.hostnameAlias}
													</td>
													<td class="tac">
														${getBakList.createDatetime}
													</td>																									
													<td class="tac">
														<button type="button" class="btn btn-grey_01" onclick="bakview('${getBakList.backupId}')"><i id="s${getBakList.backupId}" name="s${getBakList.backupId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
														<input type="hidden" id="c${getBakList.backupId}" name="c${getBakList.backupId}" value="0" />
													</td>
												</tr>
												<tr id="v${getBakList.backupId}" name="v${getBakList.backupId}" style="display:none">
													<td colspan="5" class="p20">
														<div class="tableD">
						         						<table>						         							
						         							 <thead>
																 <tr>
																	 <th>비고</th>																	 																	 
																 </tr>
															 </thead>
															 <tbody>
															 	<tr>
															 		<td class="tac">
															 			${getBakList.description}
															 		</td>															 		
															 	</tr>	
															 </tbody>
						         						</table>
						         						</div>
													</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
										</c:if>
								</div>	
		<!-- ======================================== 백업 서비스 끝 ====================================================== -->
		
		<!-- ======================================== 백업 서비스 상세 시작====================================================== -->
						<div id="bakview" name="bakview" style="display:none">
										<h5>ㆍ백업서비스 정보</h5>
										<div class="tableC">	
											<table>
												<colgroup>
												 	<col width="200px">												
												 	<col width="*">												 											
											 	</colgroup>
												<tr>
													<td class="left-b">
														호스트명
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editbakHostname2" name="editbakHostname2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>
													<td class="left-b">
														호스트 별칭
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editbakHostnameAlias2" name="editbakHostnameAlias2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>	
													<td class="left-b">
														생성일자
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editbakcreateDatetime2" name="editbakcreateDatetime2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>
													<td class="left-b">
														설명
													</td>
													<td class="p10">														
														<textarea class="form-control" rows="2" placeholder="설명을 입력하세요" name="editbakdescription2" id="editbakdescription2"></textarea>
														<input type="hidden" class="form-control" id="editbakId2" name="editbakId2" />
													</td>
												</tr>
											</table>										
										</div>	
										<div class="col-md-12 tar pt10" id='divBtnBak'>											
											<button type="button" class="btn btn-grey" onclick='baklistview()'>목록</button>
										</div>									
									</div>
		<!-- ======================================== 백업 서비스 상세 끝====================================================== -->
		
		<!-- ======================================== 대외계 서비스 시작 ====================================================== -->		
						<div id="mca-listall">								
										<c:if test='${getMcaList.size() eq 0}'>
										<h5 class="m24 fc_grey mb0 box_grey"><i class="fa fa-caret-right"></i> 대외계 서비스 목록이 없습니다</h5>
										</c:if>
										<c:if test='${getMcaList.size() ne 0}'>
										<h5 class="ml24 fcb"><i class="fa fa-caret-right"></i> 대외계 서비스</h5>
										<!-- 대외계 서비스 -->
										<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="mca-list">
											<colgroup>
												 <col width="150px">												
												 <col width="*">																																			 																						
												 <col width="100px">												
											 </colgroup>
											<thead>
												<tr class="grey">
													<th>과금단위</th>
													<th>서비스 시작일시</th>																																				
													<th>상세보기</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${getMcaList}" var="getMcaList" varStatus="status" >												
												<tr>																										
													<td class="tac">								
														<c:choose>
															<c:when test="${getMcaList.hourlyFlag eq 'N'}">
																월 단위
															</c:when>
															<c:otherwise>
																시간 단위
															</c:otherwise>
														</c:choose>
													</td>													
													<td class="tac">
														${getMcaList.createDatetime}
													</td>																										
													<td class="tac">
														<button type="button" class="btn btn-grey_01" onclick="mcaview('${getMcaList.mcaId}')"><i id="s${getMcaList.mcaId}" name="s${getMcaList.mcaId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
														<input type="hidden" id="c${getMcaList.mcaId}" name="c${getMcaList.mcaId}" value="0" />
													</td>
												</tr>
												<tr id="v${getMcaList.mcaId}" name="v${getMcaList.mcaId}" style="display:none">
													<td colspan="3" class="p20">
														<div class="tableD">
						         						<table>						         							
						         							 <thead>
																 <tr>
																	 <th>비고</th>																	 																	 
																 </tr>
															 </thead>
															 <tbody>
															 	<tr>
															 		<td class="tac">
															 			${getMcaList.description}
															 		</td>															 		
															 	</tr>	
															 </tbody>
						         						</table>
						         						</div>
													</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
										</c:if>
							</div>
	<!-- ======================================== 대외계 서비스 끝 ====================================================== -->	
	
	<!-- ======================================== 대외계 서비스 상세 시작 ====================================================== -->
	
							<div id="mcaview" name="mcaview" style="display:none">
										<h5>ㆍ대외계 서비스 정보</h5>
										<div class="tableC">	
											<table>
												<colgroup>
												 	<col width="200px">												
												 	<col width="*">												 											
											 	</colgroup>												 		
											 	<tr>	
													<td class="left-b">
														과금단위
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editmcahourlyFlag2" name="editmcahourlyFlag2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>										
												<tr>	
													<td class="left-b">
														생성일자
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editmcacreateDatetime2" name="editmcacreateDatetime2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>
													<td class="left-b">
														설명
													</td>
													<td class="p10">														
														<textarea class="form-control" rows="2" placeholder="설명을 입력하세요" name="editmcadescription2" id="editmcadescription2"></textarea>
														<input type="hidden" class="form-control" id="editmcaId2" name="editmcaId2" />
													</td>
												</tr>
											</table>										
										</div>	
										<div class="col-md-12 tar pt10" id='divBtnMca'>											
											<button type="button" class="btn btn-grey" onclick='mcalistview()'>목록</button>
										</div>									
									</div>
										
	<!-- ======================================== 대외계 서비스 상세 끝 ====================================================== -->
	
		<!-- ======================================== 형상관리 서비스 시작 ====================================================== -->	
						<div id="scm-listall">									
										<c:if test='${getScmList.size() eq 0}'>
										<h5 class="m24 fc_grey mb0 box_grey"><i class="fa fa-caret-right"></i> 형상관리 서비스 목록이 없습니다</h5>
										</c:if>
										<c:if test='${getScmList.size() ne 0}'>
										<h5 class="ml24 fcb"><i class="fa fa-caret-right"></i> 형상관리 서비스</h5>
										<!-- 형상관리 서비스 -->
										<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="scm-list">
											<colgroup>
												 <col width="150px">												
												 <col width="*">												 																							 																						
												 <col width="100px">												
											 </colgroup>
											<thead>
												<tr class="grey">
													<th>과금단위</th>
													<th>서비스 시작일시</th>																																		
													<th>상세보기</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${getScmList}" var="getScmList" varStatus="status" >												
												<tr>																										
													<td class="tac">								
														<c:choose>
															<c:when test="${getScmList.hourlyFlag eq 'N'}">
																월 단위
															</c:when>
															<c:otherwise>
																시간 단위
															</c:otherwise>
														</c:choose>
													</td>													
													<td class="tac">
														${getScmList.createDatetime}
													</td>																									
													<td class="tac">
														<button type="button" class="btn btn-grey_01" onclick="scmview('${getScmList.scmId}')"><i id="s${getScmList.scmId}" name="s${getScmList.scmId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
														<input type="hidden" id="c${getScmList.scmId}" name="c${getScmList.scmId}" value="0" />
													</td>
												</tr>
												<tr id="v${getScmList.scmId}" name="v${getScmList.scmId}" style="display:none">
													<td colspan="3" class="p20">
														<div class="tableD">
						         						<table>						         							
						         							 <thead>
																 <tr>
																	 <th>비고</th>																	 																	 
																 </tr>
															 </thead>
															 <tbody>
															 	<tr>
															 		<td class="tac">
															 			${getScmList.description}
															 		</td>															 		
															 	</tr>	
															 </tbody>
						         						</table>
						         						</div>
													</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
										</c:if>
							</div>
<!-- ======================================== 형상관리 서비스 끝 ====================================================== -->	

<!-- ======================================== 형상관리 서비스 상세 시작 ====================================================== -->
	
							<div id="scmview" name="scmview" style="display:none">
										<h5>ㆍ형상관리 서비스 정보</h5>
										<div class="tableC">	
											<table>
												<colgroup>
												 	<col width="200px">												
												 	<col width="*">												 											
											 	</colgroup>	
											 	<tr>	
													<td class="left-b">
														과금단위
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editscmhourlyFlag2" name="editscmhourlyFlag2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>											
												<tr>	
													<td class="left-b">
														생성일자
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editscmcreateDatetime2" name="editscmcreateDatetime2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>
													<td class="left-b">
														설명
													</td>
													<td class="p10">														
														<textarea class="form-control" rows="2" placeholder="설명을 입력하세요" name="editscmdescription2" id="editscmdescription2"></textarea>
														<input type="hidden" class="form-control" id="editscmId2" name="editscmId2" />
													</td>
												</tr>
											</table>										
										</div>	
										<div class="col-md-12 tar pt10" id='divBtnScm'>											
											<button type="button" class="btn btn-grey" onclick='scmlistview()'>목록</button>
										</div>									
									</div>									
							
	<!-- ======================================== 형상관리 서비스 상세 끝 ====================================================== -->
	
	<!-- ======================================== 보안관제 서비스 시작 ====================================================== -->									
					<div id="scr-listall">									
										<c:if test='${getScrList.size() eq 0}'>
										<h5 class="m24 fc_grey mb0 box_grey"><i class="fa fa-caret-right"></i> 보안관제 서비스 목록이 없습니다</h5>
										</c:if>
										<c:if test='${getScrList.size() ne 0}'>
										<h5 class="ml24 fcb"><i class="fa fa-caret-right"></i> 보안관제 서비스</h5>
										<!-- 보안관제 서비스 -->
										<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="scr-list">
											<colgroup>
												 <col width="150px">												
												 <col width="*">																																			 																						
												 <col width="100px">												
											 </colgroup>
											<thead>
												<tr class="grey">
													<th>과금단위</th>
													<th>서비스 시작일시</th>																																					
													<th>상세보기</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${getScrList}" var="getScrList" varStatus="status" >												
												<tr>																										
													<td class="tac">								
														<c:choose>
															<c:when test="${getScrList.hourlyFlag eq 'N'}">
																월 단위
															</c:when>
															<c:otherwise>
																시간 단위
															</c:otherwise>
														</c:choose>
													</td>													
													<td class="tac">
														${getScrList.createDatetime}
													</td>																									
													<td class="tac">
														<button type="button" class="btn btn-grey_01" onclick="scrview('${getScrList.securityId}')"><i id="s${getScrList.securityId}" name="s${getScrList.securityId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
														<input type="hidden" id="c${getScrList.securityId}" name="c${getScrList.securityId}" value="0" />
													</td>
												</tr>
												<tr id="v${getScrList.securityId}" name="v${getScrList.securityId}" style="display:none">
													<td colspan="3" class="p20">
														<div class="tableD">
						         						<table>						         							
						         							 <thead>
																 <tr>
																	 <th>비고</th>																	 																	 
																 </tr>
															 </thead>
															 <tbody>
															 	<tr>
															 		<td class="tac">
															 			${getScrList.description}
															 		</td>															 		
															 	</tr>	
															 </tbody>
						         						</table>
						         						</div>
													</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
										</c:if>
							</div>
	<!-- ======================================== 보안관제 서비스 끝 ====================================================== -->	
		<!-- ======================================== 보안관제 서비스 상세 시작 ====================================================== -->
	
							<div id="scrview" name="scrview" style="display:none">
										<h5>ㆍ보안관제 서비스 정보</h5>
										<div class="tableC">	
											<table>
												<colgroup>
												 	<col width="200px">												
												 	<col width="*">												 											
											 	</colgroup>	
											 	<tr>	
													<td class="left-b">
														과금단위
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editscrhourlyFlag2" name="editscrhourlyFlag2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>											
												<tr>	
													<td class="left-b">
														생성일자
													</td>
													<td class="p10">														
														<input type="text" class="form-control" id="editscrcreateDatetime2" name="editscrcreateDatetime2" style="border:0px;background-color:#fff;" />													
													</td>
												</tr>
												<tr>
													<td class="left-b">
														설명
													</td>
													<td class="p10">														
														<textarea class="form-control" rows="2" placeholder="설명을 입력하세요" name="editscrdescription2" id="editscrdescription2"></textarea>
														<input type="hidden" class="form-control" id="editscrId2" name="editscrId2" />
													</td>
												</tr>
											</table>										
										</div>	
										<div class="col-md-12 tar pt10" id='divBtnScr'>											
											<button type="button" class="btn btn-grey" onclick='scrlistview()'>목록</button>
										</div>									
									</div>
									
	<!-- ======================================== 보안관제 서비스 상세 끝 ====================================================== -->
									</div>
								</div>
							</div>
						<!-- 테이블 끝 -->
					
					
					
				</div>
				<!-- 탭14 종료 -->
				
				
				<!-- 탭5 (네트워크) 시작 -->
				<div class="tab-pane fade" id="nav-pills-tab-5">
					<!-- search begin -->
					<div class="col-md-12 br5 p10 mb10 bgee">		
						<div class="col-md-2">
							<select class="form-control dp-in pb6" id="network_searchKind">
								<option value="subnet_name">서브넷명</option>
								<option value="subnet_alias">서브넷별칭</option>
							</select>
						</div>
						<div class="col-md-8"><input type="text" class="form-control" placeholder="검색어를 입력하세요" id="network_keyword" /></div>
						<div class="col-md-2 tar"><a href="#"><button type="button" class="btn btn-grey" onclick="gridNetworkList();"><i class="fa fa-search"></i> 검색</button></a></div>
					</div>			
					<!-- search end -->
								  
					<!-- 테이블시작 -->
					<div class="col-md-12 pl0 pr0">
						<div class="panel">
							<div class="table-responsive">
								<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="Network-list">
									<thead>
										<tr class="grey">
											<th>네트워크명</th>
											<th>네트워크별칭</th>
											<th>관련 서브넷</th>
											<th>공유</th>
											<th>외부</th>
											<th>상태</th>
											<th>관리자상태</th>
											<th>상세</th>
										</tr>
									</thead>
								</table>
							</div>
							<div class="col-md-12 tar pt10"><a href="#nav-pills-tab-6" data-toggle="tab"><button type="button" class="btn btn-lime width-80" onclick="setNetworkInsert()">등록</button></a></div>
						</div>
					</div>
					<!-- 테이블 끝 -->
				</div>
				<!-- 탭5 (네트워크) 종료 -->
							
				<!-- 탭6 시작 -->	
				<div class="tab-pane fade" id="nav-pills-tab-6">
					<h5>ㆍ네트워크 정보</h5>
					<div class="tableC">
						<table>
							<colgroup>
								<col width="30%">
								<col width="70%">
							</colgroup>
							<tbody>
								<tr>
									<td class="left-b p10">회원사 네트워크</td>
									<td class="p10">
										<select id='network_insert_tab_cmm_network' name='network_insert_tab_cmm_network' class="form-control dpin pb6" onchange="actCmmNetwork('1')">
										</select>
									</td>
								</tr>
								<tr>
									<td class="left-b p10">업무</td>
									<td class="p10">
										<select id='network_insert_tab_work_kind' name='network_insert_tab_work_kind' class="form-control dpin pb6" onchange="actCmmNetwork('2')">
										</select>
									</td>
								</tr>
								<tr>
									<td class="left-b p10">네트워크 종류</td>
									<td class="p10">
										<select id='network_insert_tab_work_net_kind' name='network_insert_tab_work_net_kind' class="form-control dpin pb6" onchange="actCmmNetwork('3')">
										</select>
									</td>
								</tr>																							
							
								<tr>
									<td class="left-b p10">네트워크명</td>
									<td class="p10"><input type="text" class="form-control" id="network_insert_tab_networkName"/></td>
								</tr>
								<tr>
									<td class="left-b p10">네트워크별칭</td>
									<td class="p10"><input type="text" class="form-control" id="network_insert_tab_networkAlias"/></td>
								</tr>								
								<tr>
									<td class="left-b p10">관리자 상태</td>
									<td class="p10">
										<select class="form-control w50" id="network_insert_tab_adminStateUp">
											<option value="true" selected="selected">UP</option>
											<option value="false">DOWN</option>
										</select>
									</td>
								</tr>
								<!-- 
								<tr>
								    <td class="left-b p10">공유</td>
									<td class="p10"><input type="checkbox" id="network_insert_tab_shared" /></td>
								</tr>
								 -->
							</tbody>
						</table>
					</div>	
					<h5>ㆍ서브넷</h5>
					<div class="tableC">
						<table>
							<colgroup>
								<col width="30%">
								<col width="70%">
							</colgroup>
						<tbody>
							<tr>
								<td class="left-b p10">서브넷 이름</td>
								<td class="p10"><input type="text" class="form-control" id="network_insert_tab_subnetName"/></td>
							</tr>
							<tr>
							    <td class="left-b p10">네트워크 주소</td>
								<td class="p10"><input type="text" class="form-control" id="network_insert_tab_cidr"/></td>
							</tr>
							<tr>
							    <td class="left-b p10">IP 버전</td>
								<td class="p10"> 
									 <select class="form-control w50 pb6" id="network_insert_tab_ipVersion">
										<option value="4" selected="selected">IPv4</option>
										<option value="6">IPv6</option>
									</select>
								</td>
							</tr>
							<tr>
							    <td class="left-b p10">게이트웨이</td>
								<td class="p10"><input type="text" class="form-control" id="network_insert_tab_gatewayIp"/></td>
							</tr>
							<!-- 							
							<tr>
							    <td class="left-b p10">게이트웨이 비활성화</td>
								<td class="p10"><input type="checkbox" id="network_insert_tab_gateway"/></td>
							</tr>
							 -->
							<tr>
							    <td class="left-b p10">DHCP 사용</td>
								<td class="p10"><input type="checkbox" id="network_insert_tab_enableDhcp" checked="checked"/></td>
							</tr>
							<tr>
							    <td class="left-b p10"><span title="풀에 할당된 IP 주소. 각 빈칸은 start_ip_address,end_ip_address (예. 192.168.1.100,192.168.1.120)와 라인당 하나만 입력합니다." data-toggle="tooltip">Pools 할당</span></td>
								<td class="p10"><textarea id="network_insert_tab_allocationPools" class="form-control" rows="5" placeholder="내용을 입력하세요"></textarea></td>
							</tr>
							<tr>
							    <td class="left-b p10"><span title="이 서브넷에 대한 DNS 네임 서버의 IP 주소 목록입니다. 한 줄에 하나의 항목입니다." data-toggle="tooltip">DNS 네임서버</span></td>
								<td class="p10"><textarea id="network_insert_tab_dnsNameservers" class="form-control" rows="5" placeholder="내용을 입력하세요"></textarea></td>
							</tr>
							<tr>
							    <td class="left-b p10"><span title="호스트에 추가 경로가 알려졌습니다. 각 엔트리는: destination_cidr,nexthop (예., 192.168.200.0/24,10.56.1.254) 그리고 한 행당 하나의 엔트리입니다." data-toggle="tooltip">호스트경로</span></td>
								<td class="p10"><textarea id="network_insert_tab_hostRoutes" class="form-control" rows="5" placeholder="내용을 입력하세요"></textarea></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="col-md-12 tar pt10"> 
					<button type="button" class="btn btn-lime" onclick='insertNetwork()'>저장</button>
					<button type="button" class="btn btn-grey" onclick='listNetwork()'>목록</button>
				</div>	
			</div>

			<!-- tab 7 시작 -->							
			<div class="tab-pane fade" id="nav-pills-tab-7">
            	<h5>ㆍ네트워크 정보</h5>
				<div class="tableC">
					<input type="hidden" id="network_view_tab_networkId" />
					<table>
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tbody>
							<tr>
							    <td class="left-b p10">네트워크명</td>
								<td class="p10"><input type="text" class="form-control" style='border:0px;background-color:#fff;height:20px;' id="network_view_tab_networkName" readonly="readonly"/></td>
							</tr>
							<tr>
							    <td class="left-b p10">네트워크별칭</td>
								<td class="p10"><input type="text" class="form-control" style='border:0px;background-color:#fff;height:20px;' id="network_view_tab_networkAlias" readonly="readonly"/></td>
							</tr>							
							<tr>
							    <td class="left-b p10">관리자 상태</td>
								<td class="p10"><input type="text" class="form-control" style='border:0px;background-color:#fff;height:20px;' id="network_view_tab_adminStateUp" readonly="readonly"/></td>
							</tr>
							<!-- 
							<tr>
							    <td class="left-b p10">공유</td>
								<td class="p10"><div id="network_view_tab_shared"></div></td>
							</tr> 
							-->
						</tbody>
					</table>
				</div>
				
				<div id="tab-7-SubnetList">
					<div class="col-md-12 tar pt10"> 
						<button type="button" class="btn btn-danger width-80" onclick="confirmDeleteNetwork()">삭제</button>
						<a href="#nav-pills-tab-6edit" data-toggle="tab"><button type="button" class="btn btn-lime width-80" onclick="detailNetwork()">수정</button></a>
						<button type="button" class="btn btn-grey width-80" onclick="listNetwork();">목록</button>
					</div>	
	
					<h5>ㆍ서브넷</h5>
					<div class="table-responsive">
						<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="SubNet-list">
							<colgroup>
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="25%">
							</colgroup>
							<thead>
								<tr class="grey">
									<th class="tac fw">이름</th>
									<th class="tac fw">네트워크주소</th>
									<th class="tac fw">IP버전</th>
									<th class="tac fw">게이트웨이 IP</th>
									<th class="tac fw">상세</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="col-md-12 tar"> 
						<button type="button" class="btn btn-lime_04" onclick='actDivSubnet("insert")'>서브넷등록</button>
					</div>	
				</div>
				
				<div id="tab-7-SubnetEdit" style='display:none;'>
					<h5>ㆍ서브넷</h5>
					<div class="tableC">
						<input type="hidden" class="form-control" id="subnet_update_tab_subnetId"/>
						<table>
							<colgroup>
								<col width="30%">
								<col width="70%">
							</colgroup>
							<tbody>
								<tr>
								    <td class="left-b p10">서브넷 이름</td>
									<td class="p10"><input type="text" class="form-control" id="subnet_update_tab_subnetName"/></td>
								</tr>
								<tr>
								    <td class="left-b p10">네트워크 주소</td>
									<td class="p10"><input type="text" class="form-control" id="subnet_update_tab_cidr" readonly="readonly"/></td>
								</tr>
								<tr>
								    <td class="left-b p10">IP 버전</td>
								    <td class="p10"><input type="text" class="form-control" id="subnet_update_tab_ipVersion" readonly="readonly"/></td>
								</tr>
								<tr>
								    <td class="left-b p10">게이트웨이</td>
									<td class="p10">
										<input type="text" class="form-control" id="subnet_update_tab_gatewayIp"/>
										<input type="hidden" class="form-control" id="subnet_update_tab_gatewayIp_bak"/>
									</td>
								</tr>
								<!-- 							
								<tr>
								    <td class="left-b p10">게이트웨이 비활성화</td>
									<td class="p10"><input type="checkbox" id="network_insert_tab_gateway"/></td>
								</tr>
								 -->
								<tr>
								    <td class="left-b p10">DHCP 사용</td>
									<td class="p10"><input type="checkbox" id="subnet_update_tab_enableDhcp"/></td>
								</tr>
								<tr>
								    <td class="left-b p10">Pools 할당</td>
									<td class="p10"><textarea id="subnet_update_tab_allocationPools" class="form-control" rows="5" placeholder="내용을 입력하세요"></textarea></td>
								</tr>
								<tr>
								    <td class="left-b p10">DNS 네임서버</td>
									<td class="p10"><textarea id="subnet_update_tab_dnsNameservers" class="form-control" rows="5" placeholder="내용을 입력하세요"></textarea></td>
								</tr>
								<tr>
								    <td class="left-b p10">호스트경로</td>
									<td class="p10"><textarea id="subnet_update_tab_hostRoutes" class="form-control" rows="5" placeholder="내용을 입력하세요"></textarea></td>
								</tr>								
							</tbody>
						</table>
					</div>
					<div class="col-md-12 tar pt10"> 
						<button type="button" class="btn btn-danger" onclick="confirmDeleteSubnet()">삭제</button>
						<button type="button" class="btn btn-lime" onclick="updateSubnet()">저장</button>
						<!-- <a href="#nav-pills-tab-5" data-toggle="tab"><button type="button" class="btn btn-grey">목록</button></a> -->
						<button type="button" class="btn btn-grey" onclick='viewNetwork($("#network_view_tab_networkId").val())'>목록</button>
					</div>	
				</div>	
				
				<div id="tab-7-SubnetInsert" style='display:none;'>
					<h5>ㆍ서브넷</h5>
					<div class="tableC">
						<table>
							<colgroup>
								<col width="30%">
								<col width="70%">
							</colgroup>
							<tbody>
								<tr>
								    <td class="left-b p10">서브넷 이름</td>
									<td class="p10"><input type="text" class="form-control" id="subnet_insert_tab_subnetName"/></td>
								</tr>
								<tr>
								    <td class="left-b p10">네트워크 주소</td>
									<td class="p10"><input type="text" class="form-control" id="subnet_insert_tab_cidr"/></td>
								</tr>
								<tr>
								    <td class="left-b p10">IP 버전</td>
									<td class="p10"> 
										 <select class="form-control w50 pb6" id="subnet_insert_tab_ipVersion">
											<option value="4">IPv4</option>
											<option value="6">IPv6</option>
										</select>
									</td>
								</tr>								
								<tr>
								    <td class="left-b p10">게이트웨이</td>
									<td class="p10">
										<input type="text" class="form-control" id="subnet_insert_tab_gatewayIp"/>
									</td>
								</tr>
								<!-- 							
								<tr>
								    <td class="left-b p10">게이트웨이 비활성화</td>
									<td class="p10"><input type="checkbox" id="subnet_insert_tab_gateway"/></td>
								</tr>
								 -->
								<tr>
								    <td class="left-b p10">DHCP 사용</td>
									<td class="p10"><input type="checkbox" id="subnet_insert_tab_enableDhcp"/></td>
								</tr>
								<tr>
								    <td class="left-b p10">Pools 할당</td>
									<td class="p10"><textarea id="subnet_insert_tab_allocationPools" class="form-control" rows="5" placeholder="내용을 입력하세요"></textarea></td>
								</tr>
								<tr>
								    <td class="left-b p10">DNS 네임서버</td>
									<td class="p10"><textarea id="subnet_insert_tab_dnsNameservers" class="form-control" rows="5" placeholder="내용을 입력하세요"></textarea></td>
								</tr>
								<tr>
								    <td class="left-b p10">호스트경로</td>
									<td class="p10"><textarea id="subnet_insert_tab_hostRoutes" class="form-control" rows="5" placeholder="내용을 입력하세요"></textarea></td>
								</tr>								
							</tbody>
						</table>
					</div>
					<div class="col-md-12 tar pt10"> 
						<button type="button" class="btn btn-lime" onclick="insertSubnet()">저장</button>
						<!-- <a href="#nav-pills-tab-5" data-toggle="tab"><button type="button" class="btn btn-grey">목록</button></a> -->
						<button type="button" class="btn btn-grey" onclick='viewNetwork($("#network_view_tab_networkId").val())'>목록</button>
					</div>	
				</div>								
			</div>
			<!-- tab 7 종룟 -->
			
			<div class="tab-pane fade" id="nav-pills-tab-6edit">
	            <h5>ㆍ네트워크 정보</h5>
				<div class="tableC">
					<input type="hidden" id="network_update_tab_networkId" />
					<table>
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tbody>
							<tr>
							     <td class="left-b p10">네트워크명</td>
								<td class="p10"><input type="text" class="form-control" id="network_update_tab_networkName"/></td>
							</tr>
							<tr>
							     <td class="left-b p10">네트워크별칭</td>
								<td class="p10"><input type="text" class="form-control" id="network_update_tab_networkAlias"/></td>
							</tr>							
							<tr>
								<td class="left-b p10">관리자 상태</td>
								<td class="p10">
									<select class="form-control w50 pb6" id="network_update_tab_adminStateUp">
										<option value="true" selected="selected">UP</option>
										<option value="false">DOWN</option>
									</select>
								</td>
							</tr>
							<!-- 
							<tr>
							    <td class="left-b p10">공유</td>
								<td class="p10"><input type="checkbox" id="network_update_tab_shared"/></td>
							</tr>
							 -->
						</tbody>
					</table>
				</div>	

				<div class="col-md-12 tar pt10"> 
					<button type="button" class="btn btn-lime" onclick="updateNetwork()">저장</button>
					<a href="#nav-pills-tab-5" data-toggle="tab"><button type="button" class="btn btn-grey">취소</button></a>
				</div>	
			</div>

			<div class="tab-pane fade" id="nav-pills-tab-quota">
				<form id='quotaForm' name='quotaForm'>
	            <h5>ㆍQuota 정보</h5>
				<div class="tableC">
					<table>
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tbody>
							<tr>
							    <td class="left-b p10">메타데이터 항목</td>
								<td class="p10">
									<div class="col-md-6" title="메타데이터 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_metadata_items" id="quota_edit_metadata_items"/>
									</div>	
									<!-- 				
									<div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_metadata_items', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_metadata_items', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div>
									 -->								
								</td>
							</tr>
							<tr>
							    <td class="left-b p10">VCPUs</td>
								<td class="p10">
									<div class="col-md-6" title="VCPUs 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_cores" id="quota_edit_cores"/>
									</div>
									<!-- 					
									<div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_cores', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_cores', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div>
									 -->								
								</td>
							</tr>
							<tr>	
							    <td class="left-b p10">인스턴스</td>
								<td class="p10">
									<div class="col-md-6" title="인스턴스 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_instances" id="quota_edit_instances"/>
									</div>
									<!-- 					
									<div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_instances', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_instances', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> 
									-->								
								</td>
							</tr>
							<tr>
							    <td class="left-b p10">첨부한 파일</td>
								<td class="p10">
									<div class="col-md-6" title="첨부한 파일 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_injected_files" id="quota_edit_injected_files"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_injected_files', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_injected_files', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div>	 -->							
								</td>
							</tr>							
							<tr>
							    <td class="left-b p10">주입된 파일 컨텐츠 (Bytes)</td>
								<td class="p10">
									<div class="col-md-6" title="주입된 파일 컨텐츠 (Bytes) 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_injected_file_content_bytes" id="quota_edit_injected_file_content_bytes"/>
									</div>					
								<!-- 	<div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_injected_file_content_bytes', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_injected_file_content_bytes', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div>		 -->						
								</td>
							</tr>
							<tr>
							    <td class="left-b p10">볼륨</td>
								<td class="p10">
									<div class="col-md-6" title="볼륨 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_volumes" id="quota_edit_volumes"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_volumes', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_volumes', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> -->								
								</td>
							</tr>
							<tr>
							    <td class="left-b p10">볼륨 스냅샷</td>
								<td class="p10">
									<div class="col-md-6" title="볼륨 스냅샷 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_snapshots" id="quota_edit_snapshots"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_snapshots', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_snapshots', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> -->								
								</td>
							</tr>
							<tr>
							    <td class="left-b p10">볼륨과 스냅샷의 총 크기 (GiB)</td>
								<td class="p10">
									<div class="col-md-6" title="볼륨과 스냅샷의 총 크기 (GiB) 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_gigabytes" id="quota_edit_gigabytes"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_gigabytes', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_gigabytes', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> -->								
								</td>
							</tr>																					
							<tr>
							    <td class="left-b p10">RAM (MB)</td>
								<td class="p10">
									<div class="col-md-6" title="RAM (MB) 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_ram" id="quota_edit_ram"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_ram', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_ram', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> -->								
								</td>
							</tr>
							<tr>
							    <td class="left-b p10">보안 그룹</td>
								<td class="p10">
									<div class="col-md-6" title="보안 그룹 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_security_group" id="quota_edit_security_group"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_security_group', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_security_group', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> -->								
								</td>
							</tr>
							<tr>
							    <td class="left-b p10">보안 그룹 규칙</td>
								<td class="p10">
									<div class="col-md-6" title="보안 그룹 규칙 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_security_group_rule" id="quota_edit_security_group_rule"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_security_group_rule', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_security_group_rule', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> -->								
								</td>
							</tr>
							<tr>
							    <td class="left-b p10">Floating IP</td>
								<td class="p10">
									<div class="col-md-6" title="Floating IP 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_floatingip" id="quota_edit_floatingip"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_floatingip', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_floatingip', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> -->								
								</td>
							</tr>
							<tr>
							    <td class="left-b p10">네트워크</td>
								<td class="p10">
									<div class="col-md-6" title="네트워크 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_network" id="quota_edit_network"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_network', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_network', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> -->								
								</td>
							</tr>
							<tr>
							    <td class="left-b p10">포트</td>
								<td class="p10">
									<div class="col-md-6" title="포트 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_port" id="quota_edit_port"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_port', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_port', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> -->								
								</td>
							</tr>			
							<tr>
							    <td class="left-b p10">라우터</td>
								<td class="p10">
									<div class="col-md-6" title="라우터 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_router" id="quota_edit_router"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_router', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_router', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> -->								
								</td>
							</tr>	
							<tr>
							    <td class="left-b p10">서브넷</td>
								<td class="p10">
									<div class="col-md-6" title="서브넷 항목입니다." data-toggle="tooltip">
										<input class="form-control" type="text" name="quota_edit_subnet" id="quota_edit_subnet"/>
									</div>					
									<!-- <div class="col-md-6">												
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_subnet', true);"> <i class="fa fa-chevron-up t-in-3"></i> </button>
										<button type="button" class="btn btn-grey_01 mt-3" onclick="actCnt('quota_edit_subnet', false);"> <i class="fa fa-chevron-down t-in-3"></i> </button> 
									</div> -->								
								</td>
							</tr>																											
						</tbody>
					</table>
				</div>	

				<div class="col-md-12 tar pt10"> 
					<button type="button" class="btn btn-lime" onclick="updateQuota()">저장</button>
				</div>
				</form>	
			</div>			
			
			
							
							<div class="tab-pane fade" id="nav-pills-tab-9">
                                <!-- 테이블시작 -->
									 <div class="col-md-12 pl0 pr0">
												<div class="panel">
													<div class="table-responsive">
														<table class="table table-bordered table-hover table-striped table-td-valign-middle">
															 <colgroup>
															 <col width="25%">
															 <col width="25%">
															 <col width="25%">
															 <col width="25%">

															 </colgroup>
															<thead>
																<tr class="grey">
																	<th class="tac">계약명</th>
																	<th class="tac">적용일시</th>
																	<th class="tac">계약금액</th>
																	<th class="tac">사용여부</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																    <td class="tac">a마켓 전용자원</td>
																	<td class="tac">2017-06-01</td>
																	<td class="tac">10,000</td>
																	<td class="tac">사용</td>
																</tr>
															</tbody>
														</table>
													</div>
													<div class="col-md-12 tar pt10">
														<a href="#nav-pills-tab-10" data-toggle="tab" class="btn btn-lime width-80">등록</a>
													</div>
		
												</div>
									</div>
								<!-- 테이블 끝 -->
                            </div>
							
							<div class="tab-pane fade" id="nav-pills-tab-10">
											
												<div class="tableC">
												<table>
															 <colgroup>
															 <col width="30%">
															 <col width="70%">
															 </colgroup>
															<tbody>
																<tr>
																    <td class="left-b p10">계약명</td>
																	<td class="p10"><input type="text" class="form-control"/></</td>
																</tr>
																<tr>
																    <td class="left-b p10">적용일시</td>
																	<td class="p10"><input type="text" class="form-control width-100"/></td>
																</tr>
																<tr>
																    <td class="left-b p10">계약금액</td>
																	<td class="p10"><input type="text" class="form-control width-150"/></td>
																</tr>
																<tr>
																    <td class="left-b p10">계약내용</td>
																	<td class="p10">  <textarea class="form-control" rows="5" placeholder="내용을 입력하세요"></textarea></td>
																</tr>
																<tr>
																    <td class="left-b p10">사용여부</td>
																	<td class="p10"> <input type="checkbox"/> 사용 </td>
																</tr>

															</tbody>
												</table>
												</div>
											<div class="col-md-12 tar pt10"> 
												<button type="button" class="btn btn-lime width-80">등록</button>
												<a href="#nav-pills-tab-9" data-toggle="tab"><button type="button" class="btn btn-grey width-80">목록</button></a>
											</div>	
			
							</div>
							
							
							<div class="tab-pane fade" id="nav-pills-tab-11">
                                <!-- 테이블시작 -->
									 <div class="col-md-12 pl0 pr0">
												<div class="panel">
													<div class="table-responsive">
														<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="mngBssDiscountList">
															 <colgroup>
															 <col width="20%">
															 <col width="20%">
															 <col width="20%">
															 <col width="20%">
															 <col width="20%">
															 </colgroup>
															<thead>
																<tr class="grey">
																	<th class="tac">적용일자</th>
																	<th class="tac">할인률</th>
																	<th class="tac">수정자</th>
																	<th class="tac">수정일시</th>
																	<th class="tac">수정</th>
																</tr>
															</thead>															
														</table>
													</div>
													<div class="col-md-12 tar pt10">
														<a href="#nav-pills-tab-12" data-toggle="tab" class="btn btn-lime width-80">등록</a>
													</div>
		
												</div>
									</div>
								<!-- 테이블 끝 -->
                            </div>
							
							
							<div class="tab-pane fade" id="nav-pills-tab-12">
											
												<div class="tableC">
												<table>
															 <colgroup>
															 <col width="30%">
															 <col width="70%">
															 </colgroup>
															<tbody>
																<tr>
																    <td class="left-b p10">적용일시</td>
																    <td class="p10">																		
																			<input type="text" class="form-control dpin width-100" placeholder="날짜선택" id="applyDate" name="applyDate" readonly/>
																			<!-- <span class="input-group-addon"><i class="fa fa-calendar"></i></span> -->						
																		
																	</td>
																</tr>
																<tr>
																    <td class="left-b p10">할인률</td>
																	<td class="p10"><input type="text" class="form-control width-100" id="discountRate" name="discountRate" /> %</td>
																</tr>
															</tbody>
												</table>
												</div>
											<div class="col-md-12 tar pt10"> 
												<input type="button" class="btn btn-lime width-80" onclick="setBssDiscount();" value="등록" />
												<a href="#nav-pills-tab-11" data-toggle="tab"><button type="button" class="btn btn-grey width-80">목록</button></a>
											</div>	
			
							</div>
							
							<div class="tab-pane fade" id="nav-pills-tab-13">
											
												<div class="tableC">
												<table>
															 <colgroup>
															 <col width="30%">
															 <col width="70%">
															 </colgroup>
															<tbody>
																<tr>
																    <td class="left-b p10">적용일시</td>
																    <td class="p10">																		
																			<input type="text" class="form-control dpin width-100" placeholder="날짜선택" id="applyDateedit" name="applyDateedit" readonly/>
																			<!-- <span class="input-group-addon"><i class="fa fa-calendar"></i></span> -->						
																		
																	</td>
																</tr>
																<tr>
																    <td class="left-b p10">할인률</td>
																	<td class="p10">
																		<input type="text" class="form-control width-100" id="discountRateedit" name="discountRateedit" /> %
																		<input type="hidden" class="form-control width-100" id=discountSeq name="discountSeq" />
																	</td>
																</tr>
															</tbody>
												</table>
												</div>
											<div class="col-md-12 tar pt10"> 
												<input type="button" class="btn btn-lime width-80" onclick="setBssDiscountDel();" value="삭제" />
												<input type="button" class="btn btn-lime width-80" onclick="setBssDiscountEdit();" value="수정" />
												<a href="#nav-pills-tab-11" data-toggle="tab"><input type="button" class="btn btn-grey width-80"  value="목록" />	</a>											
											</div>	
			
							</div>
							

                        </div>
                        <!-- end tab-content -->
                        
                        <div class="col-md-12 tac mt20">
								<input type="button" class="btn btn-grey" onclick="moveListPage();" value="목록" />
							</div>
				</div>
                <!-- end col-6 -->	
				<!------여기까지 사용------>
	
			</div>
			<!-- end page-body -->
			

				<div class="modal fade" id="modal-attach">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">볼륨 연결 관리</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<input type='hidden' id='pop_hid_diskId' name='pop_hid_diskId' /> 
								<div class="col-md-8" >
									<select id='pop_attach_server' name='pop_attach_server' class="form-control dpin pb6" >
										<option value="">선택</option>									
									</select>
								</div>
								<div class="col-md-4" >
									<input type="button" id="" name="" value="연결" onclick="confirmAttach();" class="btn btn-primary width-80" />
								</div>
	                      	</div>
	                       	<div class="modal-footer tac" style='margin-top: 40px !important;'>
	                   			<a type='button' class="btn btn-default width-80" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>			
			
			<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog4">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">PM 설정</h4>
	                       </div>
	                       <div class="modal-body">
<!-- 	                           <p class="m-b-20"> -->
	                              <div class="col-md-12 bgee br10 mb10">
	                              <div class="col-md-9 p10"><input type="text"  id="searchKeyword" class="form-control" value="" /></div>
	                              <div class="col-md-1 p10"><input type="button" value="검색" class="btn btn-grey" onclick="projectPmPopList();"/></div> 
	                              </div>
<!-- 	                           </p> -->
								
								<div>
									<table class="table table-bordered table-hover table-striped table-td-valign-middle">
										<colgroup>
									 		<col width="40%">
									 		<col width="40%">
									 		<col width="20%">
									 	</colgroup>
									 	<thead>
									 		<tr class="primary">
												<th class="left height-40 tac">사용자 아이디</th>
												<th class="left height-40 tac">사용자 이름</th>
												<th class="left height-40 tac">PM등록</th>
											</tr>
									 	</thead>
										<tbody id="popListTable">
											
										</tbody>
									
									</table>
								</div>	
								
	                      	</div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="btn btn-grey" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
		
				<!-- #modal-dialog -->
				<div class="modal fade" id="massage-modal-dialog">
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
		
				<!-- #modal-dialog -->
				<div class="modal fade" id="modal-alert">
	               <div class="modal-dialog">
	               	<input type='hidden' id='modal-alert-reload' value='N'>
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">알림 메세지</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div id="modal_msg"></div>
	                      	</div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
				
				
				 <!-- 청구요금 상세 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="bill-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">청구요금 상세</h4>
	                       </div>
	                       <div class="modal-body">
								<div class="tableB">
									<table>
										<colgroup>
									 		<col width="200px;">
									 		<col width="*">									 		
									 	</colgroup>
									 	<tbody id="billDetailTable">											
											
										</tbody>									
									</table>
								</div>
								
								<div class="col-md-12 disk p10 mt5 mb20">
									<div class="col-md-8 fc66 f24 pr0">총 청구요금</div>
									<div class="col-md-4 f24 fc-red tar pr0 vm"><span id="totalAmount"></span><span class="f12 fc66 pl4">원</span></div>
								</div>
							</div>
							<div class="clear"></div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="btn btn-default width-80" data-dismiss="modal">닫기</a>
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
	function actVM(uuid, act){
		confirmBox("처리 하시겠습니까?"
				,ajaxActVM
				,{
					"projectName" : $("#hid_projectName").val()
					, "vmUuid" : uuid
					, "action" : act
				}
		);
	}
	function ajaxActVM(obj){
		$.ajax({
			url : "${contextPath}/mng/oss/vm/action",
			dataType : "JSON",
			data : obj,
			success : function(data) {
				if(data == "1"){
					alertBox("요청 하였습니다.", gridVMList);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}

	function updateHostNameAlias(){
		$.ajax({
			url : "${contextPath}/mng/oss/vm/update",
			dataType : "JSON",
			data : {
				"vmUuid" : $("#vm_view_tab_vmUuid").val()
				, "hostnameAlias" : $("#vm_view_tab_hostnameAlias").val()
				, "regUserId" : $("#loginId").val()
				, "modUserId" : $("#loginId").val()
			},
			success : function(data) {
				gridVMList();
				$('a[href="#nav-pills-tab-3"]').tab('show');
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}


	function detailVM(vmUuid){
		$.ajax({
			url : "${contextPath}/mng/oss/vm/detail",
			dataType : "JSON",
			data : {
				"vmUuid" : vmUuid
				, "projectName" : $("#hid_projectName").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(key, val){
					if(val != null){
						if(key=="hostnameAlias" || key == "vmUuid"){
							$("#vm_view_tab_"+key).val(val);
						}else{
							$("#vm_view_tab_"+key).text(val);
						}
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}

	function gridVMList(){
		$("#VM-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/vm/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#vm_searchKind option:selected").val();
					d.keyword = $("#vm_keyword").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
					d.networkId = $("#network_view_tab_networkId").val();
				}
			}
			,"columns":[
				{"data":"hostnameAlias" , "class":"tac", "width":"10%"}
				, {"data":"hostname" , "class":"tac", "width":"10%"}
				, {"data":"ipAddr" , "class":"tac", "width":"10%"}
				, {"data":"vcpus" , "class":"tac", "width":"7%"}
				, {"data":"memGb" , "class":"tac", "width":"5%"}
				, {"data":"diskGb" , "class":"tac", "width":"5%"}
				, {"data":"status" , "class":"tac", "width":"8%"}
				, {"data":"power" , "class":"tac", "width":"10%"}
				, {"class":"tac", "width":"5%"}
				, {"class":"tac", "width":"5%"}
				, {"class":"tac", "width":"5%"}
				, {"class":"tac", "width":"5%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[3], "render": function(data,type,full){
					return full.vcpus+" Core";
					}	
				}
 				, {"targets":[4], "render": function(data,type,full){
					return full.memGb+" GB";
					}	
				}
 				, {"targets":[5], "render": function(data,type,full){
					return full.diskGb+" GB";
					}	
				}
 				, {"targets":[8], "render": function(data,type,full){
					return '<button class="btn btn-grey_01" onclick="actVM(\''+full.vmUuid+'\',\'stop\')"><i class="fa fa-stop"></i></button>';
 					} 
				}
 				, {"targets":[9], "render": function(data,type,full){
					return '<button class="btn btn-lime_01" onclick="actVM(\''+full.vmUuid+'\',\'start\')"><i class="fa fa-play"></i></button>';
 					} 
				}
 				, {"targets":[10], "render": function(data,type,full){
					return '<button class="btn btn-danger_01" onclick="actVM(\''+full.vmUuid+'\',\'reboot\')"><i class="fa fa-refresh"></i></button>';
 					} 
				} 				
 				, {"targets":[11], "render": function(data,type,full){
					return "<a href='#nav-pills-tab-3-view' data-toggle='tab'><button type='button' class='btn btn-grey_01' onclick='detailVM(\""+full.vmUuid+"\")' ><i class='fa fa-search'></i></button></a>";
					}	
				}	
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});		
	}

	function listNetwork(){
		$('a[href="#nav-pills-tab-5"]').tab('show');
		gridNetworkList();
	}
	
	function confirmDeleteSubnet(){
		confirmBox("삭제하시겠습니까?", deleteSubnet)
	}
	//서브넷 삭제
	function deleteSubnet(){
		$.ajax({
			url : "${contextPath}/mng/oss/subnet/delete",
			dataType : "JSON",
			data : {
				"projectId" 		: $("#hid_projectId").val()
				, "projectName" 	: $("#hid_projectName").val()
				, "subnetId" 	: $("#subnet_update_tab_subnetId").val()
			},
			success : function(data) {
				if(data =="1"){
					alertBox2("삭제되었습니다.", actDivSubnet, 'list');
				}
			},
			error : function(request) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}

	function confirmDeleteNetwork(){
		confirmBox("네트워크를 삭제하시겠습니까?", deleteNetwork);
	}
	//네트워크 삭제
	function deleteNetwork(){
		$.ajax({
			url : "${contextPath}/mng/oss/network/delete",
			dataType : "JSON",
			data : {
				"projectId" 		: $("#hid_projectId").val()
				, "projectName" 	: $("#hid_projectName").val()
				, "networkId" 		: $("#network_view_tab_networkId").val()
			},
			success : function(data) {
				if(data =="1"){
					alertBox("삭제되었습니다.", listNetwork);
				}
			},
			error : function(request) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	//네트워크 수정
	function updateNetwork(){
		$.ajax({
			url : "${contextPath}/mng/oss/network/update",
			dataType : "JSON",
			data : {
				"projectId" 		: $("#hid_projectId").val()
				, "projectName" 	: $("#hid_projectName").val()
				, "networkId" 		: $("#network_update_tab_networkId").val()
				, "networkName" 	: $("#network_update_tab_networkName").val()
				, "networkAlias" 	: $("#network_update_tab_networkAlias").val()
				, "adminStateUp" 	: $("#network_update_tab_adminStateUp").val()
				//, "shared" 			: $("#network_update_tab_shared").is(":checked")
				, "regUserId" : $("#loginId").val()
				, "modUserId" : $("#loginId").val()
			},
			success : function(data) {
				if(data == "1"){
					$('a[href="#nav-pills-tab-7"]').tab('show');
					viewNetwork($("#network_update_tab_networkId").val());
				}
				else{
					alertBox3(data);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	//네트워크 수정페이지
	function detailNetwork(){
		$.ajax({
			url : "${contextPath}/mng/oss/network/detail",
			dataType : "JSON",
			data : {
				"networkId" : $("#network_view_tab_networkId").val()
				, "projectName" : $("#hid_projectName").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(key, val){
					if(val != null){
						if(key=="adminStateUp"){
							$("#network_update_tab_"+key).val(val+"");
						}else if(key=="shared"){
							$("#network_update_tab_"+key).attr('checked', val);
						}else{
							$("#network_update_tab_"+key).val(val);
						}
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	//네트워크 등록
	function insertNetwork(){
		$.ajax({
			url : "${contextPath}/mng/oss/network/insert",
			dataType : "JSON",
			data : {
				"projectId" 		: $("#hid_projectId").val()
				, "projectName" 	: $("#hid_projectName").val()
				, "networkName" 	: $("#network_insert_tab_networkName").val()
				, "networkAlias" 	: $("#network_insert_tab_networkAlias").val()
				, "adminStateUp" 	: $("#network_insert_tab_adminStateUp").val()
				//, "shared" 			: $("#network_insert_tab_shared").is(":checked")
				, "regUserId" : $("#loginId").val()
				, "modUserId" : $("#loginId").val()
			},
			success : function(data) {
				if(data.success == "1"){
					if(
							$("#network_insert_tab_subnetName").val()!=""
							&& $("#network_insert_tab_cidr").val()!=""
							&& $("#network_insert_tab_gatewayIp").val()!=""
						){
						insertSubnet2(data.networkId);	
					}else{
						alertBox2("네트워크가 등록되었습니다.", actDivNetwork, "list");
					}
				}
				else{
					alertBox3(data);
				}
			},
			error : function(request) {
				alertBox3("네트워크 등록 실패:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	// 네트워크와 서브넷을 한번에 등록할때 사용
	function insertSubnet2(networkId){
		$.ajax({
			url : "${contextPath}/mng/oss/subnet/insert",
			dataType : "JSON",
			data : {
				"projectName" 	: $("#hid_projectName").val()
				, "networkId" 	: networkId
				, "networkName" : $("#network_insert_tab_networkName").val()
				, "subnetName" 	: $("#network_insert_tab_subnetName").val()
				, "cidr" 		: $("#network_insert_tab_cidr").val()
				, "ipVersion" 		: $("#network_insert_tab_ipVersion").val()
				, "gatewayIp" 		: $("#network_insert_tab_gatewayIp").val()
				, "enableDhcp" 		: $("#network_insert_tab_enableDhcp").is(":checked")
				, "allocationPools" : $("#network_insert_tab_allocationPools").val()
				, "dnsNameservers" 	: $("#network_insert_tab_dnsNameservers").val()
				, "hostRoutes" 		: $("#network_insert_tab_hostRoutes").val()
				, "regUserId" : $("#loginId").val()
				, "modUserId" : $("#loginId").val()				
			},
			success : function(data) {
				if(data =="1"){
					alertBox2("등록되었습니다.", actDivNetwork, "list");
				}
			},
			error : function(request) {
				alertBox3("서브넷 등록 실패 :" + request.status + "\n" + "error:" + request.text);
			}
		});
	}
	
	function actDivNetwork(e){
		if(e=="list"){
			gridNetworkList();
			$('a[href="#nav-pills-tab-5"]').tab('show');	
		}
	}
	function actDivSubnet(e){
		if(e=="list"){
			gridSubNetList();
			$("#tab-7-SubnetList").show();
			$("#tab-7-SubnetEdit").hide();
			$("#tab-7-SubnetInsert").hide();
		}else if(e=="edit"){
			$("#tab-7-SubnetList").hide();
			$("#tab-7-SubnetEdit").show();
			$("#tab-7-SubnetInsert").hide();
		}else if(e=="insert"){
			$("#subnet_insert_tab_subnetName").val("");
			$("#subnet_insert_tab_cidr").val("");
			$("#subnet_insert_tab_ipVersion").val("");
			$("#subnet_insert_tab_gatewayIp").val("");
			$("#subnet_insert_tab_gateway").val("");
			$("#subnet_insert_tab_enableDhcp").val("");
			$("#subnet_insert_tab_allocationPools").val("");
			$("#subnet_insert_tab_dnsNameservers").val("");
			$("#subnet_insert_tab_hostRoutes").val("");
			$("#tab-7-SubnetList").hide();
			$("#tab-7-SubnetEdit").hide();
			$("#tab-7-SubnetInsert").show();
		}
	}
	function insertSubnet(){
		$.ajax({
			url : "${contextPath}/mng/oss/subnet/insert",
			dataType : "JSON",
			data : {
				"projectName" 	: $("#hid_projectName").val()
				, "networkId" 	: $("#network_view_tab_networkId").val()
				, "networkName" : $("#subnet_insert_tab_networkId").val()
				, "subnetName" 	: $("#subnet_insert_tab_subnetName").val()
				, "cidr" 		: $("#subnet_insert_tab_cidr").val()
				, "ipVersion" 	: $("#subnet_insert_tab_ipVersion").val()
				, "gatewayIp" 	: $("#subnet_insert_tab_gatewayIp").val()
				, "gatewayIpBak": $("#subnet_insert_tab_gatewayIp_bak").val()
				, "enableDhcp" 	: $("#subnet_insert_tab_enableDhcp").val()
				, "allocationPools" : $("#subnet_insert_tab_allocationPools").val()
				, "dnsNameservers"  : $("#subnet_insert_tab_dnsNameservers").val()
				, "hostRoutes" 		: $("#subnet_insert_tab_hostRoutes").val()
				, "regUserId" : $("#loginId").val()
				, "modUserId" : $("#loginId").val()				
			},
			success : function(data) {
				if(data =="1"){
					alertBox2("저장되었습니다.", actDivSubnet, "list");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	function updateSubnet(){
		$.ajax({
			url : "${contextPath}/mng/oss/subnet/update",
			dataType : "JSON",
			data : {
				"projectName" 	: $("#hid_projectName").val()
				, "networkName" : $("#network_view_tab_networkId").val()
				, "subnetId" 	: $("#subnet_update_tab_subnetId").val()
				, "subnetName" 	: $("#subnet_update_tab_subnetName").val()
				//, "cidr" 		: $("#subnet_update_tab_cidr").val()
				//, "ipVersion" 	: $("#subnet_update_tab_ipVersion").val()
				, "gatewayIp" 	: $("#subnet_update_tab_gatewayIp").val()
				, "gatewayIpBak": $("#subnet_update_tab_gatewayIp_bak").val()
				, "enableDhcp" 	: $("#subnet_update_tab_enableDhcp").val()
				, "allocationPools" : $("#subnet_update_tab_allocationPools").val()
				, "dnsNameservers"  : $("#subnet_update_tab_dnsNameservers").val()
				, "hostRoutes" 		: $("#subnet_update_tab_hostRoutes").val()
				, "regUserId" : $("#loginId").val()
				, "modUserId" : $("#loginId").val()
			},
			success : function(data) {
				if(data =="1"){
					alertBox2("수정되었습니다.", actDivSubnet, "list");
				}
			},
			error : function(request) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	//네트워크 상세
	function detailSubnet(subnetId){
		actDivSubnet('edit');
		
		$.ajax({
			url : "${contextPath}/mng/oss/subnet/detail",
			dataType : "JSON",
			data : {
				"subnetId" : subnetId
				, "projectName" : $("#hid_projectName").val()
				, "networkName" : $("#network_view_tab_networkId").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(key, val){
					if(val != null){
						if(key =="enableDhcp"){
							$("#subnet_update_tab_"+key).attr('checked', val);
						}else if(key =="dnsNameservers"){
							$("#subnet_update_tab_"+key).val(val.replace(/, /gi,'\n'));
						}else if(key =="ipVersion"){ 
							$("#subnet_update_tab_"+key).val("IPv"+val);
						}else if(key =="gatewayIp"){ 
							$("#subnet_update_tab_"+key).val(val);							
							$("#subnet_update_tab_"+key+"_bak").val(val);							
						}else{
							$("#subnet_update_tab_"+key).val(val);	
						}
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	function gridSubNetList(){
		$("#SubNet-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/subnet/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#subnet_searchKind option:selected").val();
					d.keyword = $("#subnet_keyword").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
					d.networkId = $("#network_view_tab_networkId").val();
				}
			}
			,"columns":[ 
				{"data":"subnetName" , "class":"tac", "width":"15%"}
				, {"data":"cidr" , "class":"tac", "width":"15%"}
				, {"data":"ipVersion" , "class":"tac", "width":"40%"}
				, {"data":"gatewayIp" , "class":"tac", "width":"6%"}
		        , {"class":"tac", "width":"6%"} 
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[2], "render": function(data,type,full){
					return "IPv"+full.ipVersion;
					}	
				}
				, {"targets":[4], "render": function(data,type,full){
					return "<button type='button' class='btn btn-grey_01' onclick='detailSubnet(\""+full.subnetId+"\")' ><i class='fa fa-search'></i></button>";
					}	
				}	
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});		
	}
	//네트워크 상세
	function viewNetwork(networkId){
		actDivSubnet('list');
		$("#network_view_tab_networkId").val(networkId);
		
		$.ajax({
			url : "${contextPath}/mng/oss/network/detail",
			dataType : "JSON",
			data : {
				"networkId" : networkId
				, "projectName" : $("#hid_projectName").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(key, val){
					if(val != null){
						if(key =="adminStateUp"){
							$("#network_view_tab_"+key).val(getTextAdminStateUp(val));
						}else{
							$("#network_view_tab_"+key).val(val);	
						}
					}
				});
				gridSubNetList();				
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}

	function getTextShared(shared){ return shared?"예":"아니오"; }
	function getTextRouterExternal(routerExternal){ return routerExternal?"예":"아니오"; }
	function getTextAdminStateUp(adminStateUp){ return adminStateUp?"UP":"DOWN"; }
	
	
	function gridNetworkList() {
		$("#Network-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/network/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#network_searchKind option:selected").val();
					d.keyword = $("#network_keyword").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
				}
			}
			,"columns":[ 
				{"data":"networkName" , "class":"tac", "width":"20%"}
				, {"data":"networkAlias" , "class":"tac", "width":"20%"}
				, {"data":"subnets" , "class":"tac", "width":"30%"}
				, {"data":"shared" , "class":"tac", "width":"6%"}
				, {"data":"routerExternal" , "class":"tac", "width":"6%"}
				, {"data":"status" , "class":"tac", "width":"6%"}
				, {"data":"adminStateUp" , "class":"tac", "width":"6%"}
		        , {"class":"tac", "width":"6%"} 
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[2], "render": function(data,type,full){
					var vHtml = "";					
					$.each(full.subnets, function(i){
						vHtml += full.subnets[i];
						if(i < full.subnets.length) { vHtml += "<br/>" ;}
					});
					return vHtml;
					}	
				}
				, {"targets":[3], "visible":false, "render": function(data,type,full){
					return getTextShared(full.shared);
					}	
				}
				, {"targets":[4], "render": function(data,type,full){
					return getTextRouterExternal(full.routerExternal);
					}	
				}
				, {"targets":[6], "render": function(data,type,full){
					return getTextAdminStateUp(full.adminStateUp);
					}	
				}
				, {"targets":[7], "render": function(data,type,full){
					return "<a href='#nav-pills-tab-7' data-toggle='tab'><button type='button' class='btn btn-grey_01' onclick='viewNetwork(\""+full.networkId+"\")' ><i class='fa fa-search'></i></button></a>";
					}	
				}	
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
	}

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
						if(i=="customerId"){
							$("#hid_"+i).val(val);
						}else{
							$("#"+i).text(val);
						}
					}
					
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/project/vm/";
	}
	
	// 등록/수정페이지 이동
	function moveInsertPage(){
		var projectId = $("#hid_projectId").val();
		location.href = "${contextPath}/mng/project/vm/write?projectId="+projectId;
	}
	
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
		
		$("#applyDateedit").datepicker({
			showOn:"both",
			buttonImage:"${contextPath}/resources/assets/img/calen.png",
			buttonImageOnly:true,
			dateFormat : "yy-mm-01",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});
		
		$("#applyDateedit").datepicker({
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


	function gridList(){
		$("#mngBssDiscountList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/oss/project/bssDiscountList"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind > option:selected").val();
					d.keyword = $("#keyword").val();
					d.projectId = $("#hid_projectId").val();					
				}
			}
			,"columns":[
						{"data":"applyDate", "class":"tac"}
			        	, {"data":"discountRate", "class":"tac"}
			        	, {"data":"modUserId", "class":"tac"}
			        	, {"data":"modDatetime","class":"tac"}			        	        	
			        	, {"class":"ditailStyle tac"}
			]
			,"columnDefs":[				
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[1], "render": function(data,type,full){
					return full.discountRate+"%";
					}	
				}
				, {"targets":[4], "render": function(data,type,full){
					return "<button type='button' class='btn btn-grey_01' onclick='moveEditPage(\""+full.discountSeq+"\",\""+full.discountRate+"\",\""+full.applyDate+"\")' ><i class='fa fa-search'></i></button>";
					}	
				}	
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"i>'
		});
		
	}
	
	function moveEditPage(discountSeq, discountRate, applyDate){
		//alertBox3(rowData.applyDate);
		//$("#nav-pills-tab-11").hide();
		//$("#nav-pills-tab-13").show();
		$("#discountSeq").val(discountSeq);
		$("#discountRateedit").val(discountRate);
		$("#applyDateedit").val(applyDate);
		
		//location.href = "${contextPath}/mng/bill/policy/billPolicyView?discountSeq="+rowSeq;
 	}
	
	function bssDiscountList(){ 		
			$("#nav-pills-tab-13").hide();
			$("#nav-pills-tab-11").show(); 	
 	}
	
	function setBssDiscount() {
		if($("#applyDate").val()==""){
			warningBox("적용일시를 입력해주세요.");
			$("#applyDate").focus();
			return false;
		}
		if($("#discountRate").val()==""){
			warningBox("할인률를 입력하세요.");
			$("#discountRate").focus();
			return false;
		}
		$.ajax({
			url : "setBssDiscount",
			dataType : "JSON",
			data : {
				"projectId" : $("#hid_projectId").val()
				,"applyDate" : $("#applyDate").val()
				,"discountRate" : $("#discountRate").val()
			},
			success : function(data) {
				if(data==1){
					$("#nav-pills-tab-12").hide();
					$("#nav-pills-tab-11").show();
					alertBox("등록되엇습니다.", gridList);
				}else if(data==0){
					alertBox3("적용일자가 같은 할인률이 있습니다.");
				}else{
					alertBox3("등록이 되지 않았습니다.");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	function setBssDiscountDel() {
		confirm("삭제 하시겠습니까?", ajaxSetBssDiscountDel);
	}		
	function ajaxSetBssDiscountDel() {		
		
		$.ajax({
			url : "setBssDiscountDel",
			dataType : "JSON",
			data : {
				"discountSeq" : $("#discountSeq").val()				
			},
			success : function(data) {
				if(data==1){
					gridList();
					$("#nav-pills-tab-13").hide();
					$("#nav-pills-tab-11").show();
					alertBox("삭제되었습니다", gridList);
				}else{
					alertBox3("삭제 실패.");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	function setBssDiscountEdit() {
		confirmBox("수정 하시겠습니까?", ajaxSetBssDiscountEdit)
	}		
	function ajaxSetBssDiscountEdit() {		
		$.ajax({
			url : "setBssDiscountEdit",
			dataType : "JSON",
			data : {
				"discountSeq" : $("#discountSeq").val()	
				,"applyDate" : $("#applyDateedit").val()
				,"discountRate" : $("#discountRateedit").val()
			},
			success : function(data) {
				if(data==1){
					$("#nav-pills-tab-13").hide();
					$("#nav-pills-tab-11").show();
					alertBox("수정되었습니다." , gridList);
				}else{
					alertBox3("수정 실패");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	
	//---> Modal popup start
	//modal팝업 open
	function openModal(){
		$("#modal-dialog4").modal();
		projectPmPopList();
	}
	
	// PM 대상 팝업리스트
	function projectPmPopList(){
		var projectId = $("#hid_projectId").val();
		var customerId = $("#hid_customerId").val();
		var keyword = $("#searchKeyword").val();
		
		$.ajax({
			url : "${contextPath}/mng/req/project/pmPopList",
			dataType : "JSON",
			data : {
				"projectId" : projectId
				,"customerId" : customerId
				,"keyword" : keyword
			},
			success : function(data) {
				var pmPopList = data.pmPopList;
				
				if(pmPopList!=""){
					$("#popListTable > tr").remove();
					$.each(pmPopList,function(key,val){
						var Html="";
						Html="<tr><td class='tac'>"+val["userId"]+"</td>";
						Html = Html + "<td class='tac'>"+val["userName"]+"</td>";
						Html = Html + "<td class='tac'><input type='button' value='적용' data-dismiss='modal' class='btn btn-primary' onclick='updatePm(\""+val["userId"]+"\", \""+val["userName"]+"\")'></td>";
						Html = Html + "</tr>";
						$("#popListTable").append(Html);	
					});
				}else{
					$("#popListTable > tr").remove();
					var Html="";
					Html="<tr><td class='tac' colspan='3'>검색된 사용자가 없습니다.</td>";
					Html = Html + "</tr>";
					$("#popListTable").append(Html);		
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	// PM 등록
	function updatePm(pmId, pmName){
// 		$("#pmName").val(pmName);
// 		$("#pmId").val(pmId);
		
		$("#userName").text(pmName);
		
		$.ajax({
			url : "${contextPath}/mng/req/project/projectPmInsert",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : pmId,
				"projectId" : "${projectId}"
			},
			success : function(data) {
				alertBox3("적용되었습니다.");
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	//<--- Modal popup end

	function actCmmNetwork(e){
		var obj = JSON.parse($('#network_insert_tab_cmm_network').val());
		var t1 = "network_insert_tab_work_kind option:selected";
		var t2 = "network_insert_tab_work_net_kind option:selected";
		if(e == "1"){
			$('#network_insert_tab_work_kind').val(obj.workKind);
			$('#network_insert_tab_work_net_kind').val(obj.workNetKind);	
		}
		$('#network_insert_tab_networkAlias').val( 
				(
						$("#projectAlias").text()
						+'_'
						+$('#'+t1).text()
						+'_'
						+$('#'+t2).text()
						+'망'
				).toLowerCase());
		$('#network_insert_tab_networkName').val( 
				(
						$("#hid_projectName").val()						
						+'_'
						+($('#'+t1).val()).replace('WORKKIND_', '')
						+'_'
						+($('#'+t2).val()).replace('WORKNET_', '')
						+'_net'
				).toLowerCase());
		
		$('#network_insert_tab_subnetName').val(
				(
					$("#hid_projectName").val()						
					+'_'
					+($('#'+t1).val()).replace('WORKKIND_', '')
					+'_'
					+($('#'+t2).val()).replace('WORKNET_', '')
					+'_subnet'
			).toLowerCase()); 
		$('#network_insert_tab_cidr').val(obj.ipAddr);
		$('#network_insert_tab_gatewayIp').val(obj.gateway);
		
	}
	
	function actCmmNetworkKind(){
		var obj = JSON.parse($('#network_insert_tab_cmm_network').val());
		$('#network_insert_tab_work_kind').val();
		$('#network_insert_tab_work_net_kind').val(obj.workNetKind);
		
		$('#network_insert_tab_networkName').val( 
				(
						$("#projectAlias").text()
						+'_'
						+$('#network_insert_tab_work_kind option:selected').text()
						+'_'
						+$('#network_insert_tab_work_net_kind option:selected').text()
				).toLowerCase());
		$('#network_insert_tab_networkAlias').val( 
				(
						$("#hid_projectName").val()						
						+'_'
						+($('#network_insert_tab_work_kind option:selected').val()).replace('WORKKIND_', '')
						+'_'
						+($('#network_insert_tab_work_net_kind option:selected').val()).replace('WORKNET_', '')
				).toLowerCase());
		$('#network_insert_tab_cidr').val(obj.ipAddr); 
	}
	function actCmmNetworkNetKind(){}
	
	function actCmmNetworkList(){
		$.ajax({
			url : "${contextPath}/mng/cmm/network/customerlist",
			dataType : "JSON",
			data : {
				searchKind 		: ""
				, keyword 		: ""
				, length 		: 0
				, customerId	: $("#hid_customerId").val()		
			},
			success : function(res) {
				var data = res.data;
				$("#network_insert_tab_cmm_network option").remove();
				$("#network_insert_tab_cmm_network").append('<option value="">선택</option>');
 				$.each(data, function(key, val){  
					$("#network_insert_tab_cmm_network").append("<option value='"+JSON.stringify(val)+"'>"+val['workKindName']+' '+val['workNetKindName']+' 망 '+val['ipAddr']+'</option>');
				});
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	function actCmmCode(e){
		var parentCodeId ="";
		if(e=="network_insert_tab_work_kind"){
			parentCodeId="WORK_KIND";
		}else if(e=="network_insert_tab_work_net_kind"){
			parentCodeId= "WORK_NET_KIND";
		}

		$.ajax({
			url : "${contextPath}/mng/cmm/code/listDetail",
			dataType : "JSON",
			data : {
				parentCodeId 		: parentCodeId
			},
			success : function(data) {
				$("#"+e+" option").remove();
				$("#"+e).append('<option value="">선택</option>');
 				$.each(data, function(key, val){
 					$("#"+e).append('<option value="'+val['codeId']+'">'+val['codeName']+'</option>');
				});
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	
	function setNetworkInsert(){
		actCmmNetworkList();
		actCmmCode('network_insert_tab_work_kind');
		actCmmCode('network_insert_tab_work_net_kind');
		
		$("#network_insert_tab_networkName").val("");
		$("#network_insert_tab_networkAlias").val("");
		$("#network_insert_tab_adminStateUp").val("true");

		$("#network_insert_tab_subnetName").val("");
		$("#network_insert_tab_cidr").val("");
		$("#network_insert_tab_ipVersion").val("4");
		$("#network_insert_tab_gatewayIp").val("");
		$("#network_insert_tab_enableDhcp").attr('checked', true);
		$("#network_insert_tab_allocationPools").val("");
		$("#network_insert_tab_dnsNameservers").val("");
		$("#network_insert_tab_hostRoutes").val("");
	}
	
	function setDiskDiv(gbn){
		$("#divDiskList").hide();
		$("#divDiskView").hide();
		$("#divDisk"+gbn).show();
		
		if(gbn=="View"){
			$("#divBtnDisk").show();
		}
	}

	function detailDisk(diskId){
		setDiskDiv("View");
		
		$("#disk_view_diskId").val(diskId);
		$.ajax({
			url : "${contextPath}/mng/oss/disk/detail",
			dataType : "JSON",
			data : {
				projectId 		: "${projectId}"
				, projectName 	: "${projectName}"
				, diskId 		: diskId
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(key, val){
					if(val != null){
						if(key == "hourlyFlag"){
							$("#disk_view_hourlyFlag").val(val=="N"?"월단위":"시간단위");
							$("#vm_view_tab_hourlyFlag").val(val);
						}else if(key == "diskAlias"){
							$("#disk_view_diskAlias").val(val);
						}else if(key == "size"){
							$("#disk_view_size").val(val+" GB");
						}else if(key == "hostname"){
							$("#disk_view_hostname").val(val+" 에 연결");
						}else if(key == "attachments"){
							$("#disk_view_attachments").val(val+" 에 "); 
						}else if(key == "bootable"){
							$("#disk_view_bootable").val(val=="true"?"예":"아니오");
						}else{
							$("#disk_view_"+key).val(val);	
						}
						
						if(key=="size"){
							$("#disk_update_sizeGb").val(val);
							$("#disk_update_sizeGb_bak").val(val);
						}
					}
				});
				if($("#disk_view_diskName").val() == ""){
					$("#disk_view_diskName").val($("#disk_view_diskId").val());
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
		
	function gridDiskList(){
		setDiskDiv("List");
		
		$("#disk-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/disk/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#disk_searchKind option:selected").val();
					d.keyword = $("#disk_keyword").val();
					d.projectName = "${projectName}";
					d.projectId = "${projectId}";
					d.length = "0";
				}
			}
			, "initComplete" : function(setting, json){
				if(json.recordsTotal > 0){
					$("#h5Disk1").hide();
					$("#h5Disk2").show();
				}
			}
			,"columns":[
				{"data":"diskAlias" , "class":"tac"}
				, {"class":"tac"}
				, {"class":"tac"}
				, {"class":"tac"}
				, {"class":"tac", "width":"10%"}
				, {"data":"regDatetime2" , "class":"tac", "width":"15%"}
				, {"class":"tac detail-control", "width":"10%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[1], "render": function(data,type,full){
					return full.sizeGb+" GB";
					}	
				}								
 				, {"targets":[2], "render": function(data,type,full){
					return full.hourlyFlag=="N"?"월단위":"시간단위";
					}	
				}					
 				, {"targets":[3], "render": function(data,type,full){
	 					if(full.attachments != undefined){
	 						return full.attachments+"에 "+full.hostname+"에 연결";	
	 						//return full.attachments+"에 "+full.hostnameAlias+"에 연결";	
	 					}else{
	 						return "";
	 					}
					}	
				}
 				, {"targets":[4], "render": function(data,type,full){ 
 						if(full.attachments != undefined){
 							return "<button type='button' class='btn btn-danger_04' onclick='confirmDetach(\""+full.diskId+"\", \""+full.vmUuid+"\")' >연결해지</button>";	
 						}else{
 							return "<button type='button' class='btn btn-primary_04' onclick='openAttach(\""+full.diskId+"\")' >연결등록</button>";
 						}
					}	
				}		 		 				
 				, {"targets":[6], "render": function(data,type,full){
					return "<a href=\"#nav-pills-tab-4-view\" data-toggle=\"tab\"><button type='button' class='btn btn-grey_01' onclick='detailDisk(\""+full.diskId+"\")' ><i class='fa fa-search'></i></button></a>";
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom">'
		});		
	}
	
	// 청구요금목록 조회
	function gridBillList(){
		var yy = $("#billYear option:selected").val();
		var mm = $("#billMonth option:selected").val();
		var billYyyymm = yy+mm;
		
		$("#charge-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/charge/bill/projectBillList" 
				,"type" : "GET"
				,"data":function (d) {
					//d.searchKind = $("#vm_searchKind option:selected").val();
					//d.keyword = $("#vm_keyword").val();
					d.billYyyymm = billYyyymm;
					d.projectId = $("#hid_projectId").val();
				}
			}
			,"columns":[
				{"data":"billYyyymm", "class":"tac"}
	        	, {"data":"customerId", "class":"tac"}
	        	, {"data":"customerName", "class":"tac"}
	        	, {"data":"projectId", "class":"tac"}
	        	, {"data":"projectAlias", "class":"tac"}
	        	, {"data":"totAmount", "class":"tar fc-blue fb"}
	        	, {"data":"dcAmount", "class":"tar fc-blue fb"}
	        	, {"data":"dcAmount", "class":"tar fc-blue fb"}
	        	, {"data":"totAmount", "class":"tar fc-red fb"}
	        	, {"class":"tac", "width":"5%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0], "render": function(data,type,full){
					var date = full.billYyyymm;
					return date.substring(0,4) + "/" + date.substring(4,6);
					}	 
				} 
				, {"targets":[1],"visible":false,"searchable":false }
				, {"targets":[3],"visible":false,"searchable":false }
 				, {"targets":[5], "render": function(data,type,full){
					return addcomma(full.totAmount);
					}	
				}  				
 				, {"targets":[6], "render": function(data,type,full){
					return addcomma(full.dcAmount);
					}	
				}  				
 				, {"targets":[7], "render": function(data,type,full){
					return addcomma(full.dcAmount);
					}	
				}  				
 				, {"targets":[8], "render": function(data,type,full){
					return addcomma(full.totAmount);
					}	
				}
 				, {"targets":[9], "render":function(data,type,full){
					return '<button class="btn btn-grey_01 width-40 tac" onclick="billDetailPop(\''+full.projectId+'\',\''+full.billYyyymm+'\')"><i class="fa fa-search ml-2"></i></button>';
				} }
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});		
	}
	
	
	// 청구요금 상세
	function billDetailPop(projectId, billYyyymm){
		$("#bill-modal-dialog").modal();
		$.ajax({
			url : "${contextPath}/mng/charge/bill/projectBillDetail",
// 			dataType : "JSON",
	//			type : "POST",
			data : {
				"projectId" : projectId
				,"billYyyymm" : billYyyymm
			},
			success : function(data) {
				var billInfoList = data.detail;
				
				$("#billDetailTable > tr").remove();
				$.each(billInfoList,function(key,val){
					var Html = "";
					var billLevel = val["invoiceItem"];
					
					if(billLevel=="A000"){	//클라우드 자원
						Html="<tr class='bgee'><td class='f18 fb tal'><i class='fa fa-cloud'></i> "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					
					}else if(billLevel=="AA00"){	//기본 자원
						Html="<tr class='vm'><td class='t-in16'><i class='fa fa-arrow-circle-o-down f12'></i>"+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10 vm'><span class='fc66 f16 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					}else if(billLevel=="AAA0"){	//가상 서버
						Html= "<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10 rtd'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					}else if(billLevel=="AE00"){	//부가자원
						Html="<tr class='bgf5 accordion-toggle accordion-toggle-styled' data-toggle='collapse' data-parent='#accordion' href='#collapse3'><td class='t-in16'><i class='fa fa-arrow-circle-o-down f12'></i>"+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10 vm'><span class='fc66 f16 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";	
						
					}else if(billLevel=="AEA0"){	//블록디스크
						Html="<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					}else if(billLevel=="AEB0"){	//NAS
						Html="<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						
					}else if(billLevel=="AI00"){	//서비스
						Html="<tr class='bgf5'><td class='t-in16'><i class='fa fa-code-fork'></i>"+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10 vm'><span class='fc66 f16 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					}else if(billLevel=="AIA0"){	//형상관리 서비스
						Html="<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";	
					}else if(billLevel=="AIB0"){	//대외계 서비스
						Html="<tr><td class='t-in56'>· "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";	
					
					}else if(billLevel=="E000"){	//요금할인
						Html="<tr class='bgee'><td class='f18 fb'><i class='fa fa-won'></i> "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					}else if(billLevel=="EA00"){	//프로젝트 할인
						Html="<tr><td class='t-in38'>· "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					}else if(billLevel=="EL00"){	//10원 미만 절사 할인
						Html="<tr><td class='t-in38'>· "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					
					}else if(billLevel=="I000"){	//보정	
						Html="<tr class='bgee'><td class='f18 fb'><i class='fa fa-wrench'></i> "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					}else if(billLevel=="IA00"){	//보정명칭
						Html="<tr><td class='t-in16'>· "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
						
					}else if(billLevel=="L000"){	//부가가치세(세금)
						Html="<tr class='bgee'><td class='f18 fb'><i class='fa fa-yelp'></i> "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10 vm'><span class='fcb f18 fb'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					}else if(billLevel=="LA000"){	//부가가치세
						Html="<tr><td class='t-in38 vm'>· "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					}else if(billLevel=="0000"){	//총 청구금액
						$("#totalAmount").text(addcomma(val["amount"]));
					}
					
					$("#billDetailTable").append(Html);	
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function gridNasList(){
		$("#nas-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/nas/nasList"
				,"type" : "GET"
				,"data":function (d) {
					//d.searchKind = $("#vm_searchKind option:selected").val();
					//d.keyword = $("#vm_keyword").val();
					d.projectName = $("#hid_projectName").val();
					d.projectId = $("#hid_projectId").val();
				}
			}
			,"columns":[
				{"data":"nasName" , "class":"tac"}
				, {"data":"nasGb" , "class":"tac"}
				, {"data":"hourlyFlag" , "class":"tac"}				
				, {"data":"createDatetime" , "class":"tac"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[2], "render": function(data,type,full){
						if(full.hourlyFlag=="Y"){
	 						return "시간 단위 ";
	 					}else{
	 						return "월 단위";
	 					}
					}	
				}  	
 				, {"targets":[4], "render": function(data,type,full){
					//return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">상세보기</button></a></div>';
 					return "";
 					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"i>'
		});		
	}
	
	function gridLbList(){
		$("#lb-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/loadbalancer/lbList"
				,"type" : "GET"
				,"data":function (d) {
					//d.searchKind = $("#vm_searchKind option:selected").val();
					//d.keyword = $("#vm_keyword").val();
					d.projectName = $("#hid_projectName").val();
					d.projectId = $("#hid_projectId").val();
				}
			}
			,"columns":[
				{"data":"loadbalancerName" , "class":"tac"}
				, {"data":"hourlyFlag" , "class":"tac"}
				, {"data":"networkAlias" , "class":"tac"}
				, {"data":"createDatetime" , "class":"tac"}				
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[1], "render": function(data,type,full){
						if(full.hourlyFlag=="Y"){
	 						return "시간 단위 ";
	 					}else{
	 						return "월 단위";
	 					}
					}	
				}  
 				, {"targets":[4], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">상세보기</button></a></div>';
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"i>'
		});		
	}
	
	function gridIpList(){
		$("#ip-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/publicip/ipList"
				,"type" : "GET"
				,"data":function (d) {
					//d.searchKind = $("#vm_searchKind option:selected").val();
					//d.keyword = $("#vm_keyword").val();
					d.projectName = $("#hid_projectName").val();
					d.projectId = $("#hid_projectId").val();
				}
			}
			,"columns":[
				{"data":"hourlyFlag" , "class":"tac"}
				, {"data":"hostname" , "class":"tac"}
				, {"data":"hostnameAlias" , "class":"tac"}				
				, {"data":"createDatetime" , "class":"tac"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0], "render": function(data,type,full){
						if(full.hourlyFlag=="Y"){
	 						return "시간 단위 ";
	 					}else{
	 						return "월 단위";
	 					}
					}	
				}  
 				, {"targets":[4], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">상세보기</button></a></div>';
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"i>'
		});		
	}
	
	function gridBakList(){
		$("#bak-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/backup/bakList"
				,"type" : "GET"
				,"data":function (d) {					
					d.projectName = $("#hid_projectName").val();
					d.projectId = $("#hid_projectId").val();
				}
			}
			,"columns":[
				{"data":"hourlyFlag" , "class":"tac"}
				, {"data":"" , "class":"tac"}
				, {"data":"" , "class":"tac"}				
				, {"data":"createDatetime" , "class":"tac"}
				, {"class":"tac"}
				, {"class":"tac"}
				, {"class":"tac"}
			]			
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0], "render": function(data,type,full){
						if(full.hourlyFlag=="Y"){
	 						return "시간 단위 ";
	 					}else{
	 						return "월 단위";
	 					}
					}	
				}
				, {"targets":[4], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">수정</button></a></div>';
					}	
				}  
				, {"targets":[5], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">해지</button></a></div>';
					}	
				}  
 				, {"targets":[6], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">상세보기</button></a></div>';
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"i>'
		});		
	}
	
	function gridMcaList(){
		$("#mca-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/mca/mcaList"
				,"type" : "GET"
				,"data":function (d) {					
					d.projectName = $("#hid_projectName").val();
					d.projectId = $("#hid_projectId").val();
				}
			}
			,"columns":[
				{"data":"hourlyFlag" , "class":"tac"}
				, {"data":"createDatetime" , "class":"tac"}				
				, {"class":"tac"}
				, {"class":"tac"}
				, {"class":"tac"}
			]			
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0], "render": function(data,type,full){
						if(full.hourlyFlag=="Y"){
	 						return "시간 단위 ";
	 					}else{
	 						return "월 단위";
	 					}
					}	
				} 
				, {"targets":[2], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">수정</button></a></div>';
					}	
				}  
				, {"targets":[3], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">해지</button></a></div>';
					}	
				}  
 				, {"targets":[4], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">상세보기</button></a></div>';
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"i>'
		});		
	}
	
	function gridScmList(){
		$("#scm-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/scm/scmList"
				,"type" : "GET"
				,"data":function (d) {					
					d.projectName = $("#hid_projectName").val();
					d.projectId = $("#hid_projectId").val();
				}
			}
			,"columns":[
				{"data":"hourlyFlag" , "class":"tac"}
				, {"data":"createDatetime" , "class":"tac"}				
				, {"class":"tac"}
				, {"class":"tac"}
				, {"class":"tac"}
			]			
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0], "render": function(data,type,full){
						if(full.hourlyFlag=="Y"){
	 						return "시간 단위 ";
	 					}else{
	 						return "월 단위";
	 					}
					}	
				} 
				, {"targets":[2], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">수정</button></a></div>';
					}	
				}  
				, {"targets":[3], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">해지</button></a></div>';
					}	
				}  
 				, {"targets":[4], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">상세보기</button></a></div>';
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"i>'
		});		
	}
	
	function gridScrList(){
		$("#scr-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/scr/scrList"
				,"type" : "GET"
				,"data":function (d) {					
					d.projectName = $("#hid_projectName").val();
					d.projectId = $("#hid_projectId").val();
				}
			}
			,"columns":[
				{"data":"hourlyFlag" , "class":"tac"}
				, {"data":"createDatetime" , "class":"tac"}				
				, {"class":"tac"}
				, {"class":"tac"}
				, {"class":"tac"}
			]			
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0], "render": function(data,type,full){
						if(full.hourlyFlag=="Y"){
	 						return "시간 단위 ";
	 					}else{
	 						return "월 단위";
	 					}
					}	
				} 
				, {"targets":[2], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">수정</button></a></div>';
					}	
				}  
				, {"targets":[3], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">해지</button></a></div>';
					}	
				}  
 				, {"targets":[4], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-4-view" data-toggle="tab"><button type="button" class="btn btn-info w-80" onclick="detailVM(\''+full.vmUuid+'\')">상세보기</button></a></div>';
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"i>'
		});		
	}

	function viewtr(nasId){
		var vnasId = "v"+nasId;
		var cnasId = "c"+nasId; 
		var snasId = "s"+nasId;
		
		if($("#"+cnasId).val()=="0"){					
			$("#"+cnasId).val("1");
			$("#"+vnasId).show();
			$("#"+snasId).removeClass('fa fa-chevron-down');
			$("#"+snasId).addClass('fa fa-chevron-up');
		}else{
			$("#"+cnasId).val("0");
			$("#"+vnasId).hide();	
			$("#"+snasId).removeClass('fa fa-chevron-up');
			$("#"+snasId).addClass('fa fa-chevron-down');
		}
		
	}


	
	function confirmDetach(diskId, vmUuid){
		confirmBox("연결해지 하시겠습니까?"
				, actDetach
				, {
					"projectName"		: $("#hid_projectName").val()
						, "projectId"		: $("#hid_projectId").val()
						, "diskId"			: diskId
						, "vmUuid"			: vmUuid
						, "regUserId" 		: "${userId}"
						, "modUserId" 		: "${userId}"
					});
	}
	
	function actDetach(obj){
		$.ajax({
			url : "${contextPath}/mng/oss/disk/detach",
			dataType : "JSON",
			data : obj,
			success : function(data) {
				if(data.errorMsg == "1"){
					alertBox("요청 되었습니다.<br>연결해지는 시간이 소요 됩니다.", reload);
				}else{
					alertBox3(data.errorMsg);
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});		
	}
	
	function reload(){
		location.reload();
	}
	
	function confirmAttach(){
		if($("#pop_attach_server").val()== ""){
			alertBox("가상머신을 선택 해주십시요.")	
			return false;
		}
		
		confirmBox("연결하시겠습니까?"
				, actAttach
				, {
					"projectName"		: "${projectName}"
					, "diskId"			: $("#pop_hid_diskId").val()
					, "vmUuid"			: $("#pop_attach_server").val()
					, "regUserId" 		: "${userId}"
					, "modUserId" 		: "${userId}"
				});
	}
	
	function actAttach(obj){
		$.ajax({
			url : "${contextPath}/mng/oss/disk/attach",
			dataType : "JSON",
			data : obj,
			success : function(data) {
				if(data.errorMsg == "1"){
					alertBox("요청 되었습니다.", gridDiskList);
				}else{
					alertBox3(data.errorMsg);
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});	
	}
	
	function openAttach(diskId){
		$("#pop_hid_diskId").val(diskId);
		$("#modal-attach").modal();
		
		$("#pop_attach_server option").remove();
		$("#pop_attach_server").append('<option value="">선택</option>'); 

		$.ajax({
			url : "${contextPath}/mng/oss/vm/catalogueVmlist",
			dataType : "JSON",
			data : {
				projectId : "${projectId}"
				, keyword : ""
			},
			success : function(req) {
				$.each(req.data,function(key,val){
					$("#pop_attach_server").append('<option value="'+val.vmUuid+'">'+val.hostname+' ( '+val.vmUuid+' )</option>');
				});
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	function detailQuota(){
		$.ajax({
			url : "${contextPath}/mng/project/quota/detail",
			dataType : "JSON",
			data : {
				projectId 		: "${projectId}"
				, projectName 	: "${projectName}"
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(key, val){
					if(val != null){
						$("#quota_edit_"+key).val(val);
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	function actCnt(id, e){
		var cnt = parseInt($("#"+id).val(), 10);
		if(isNaN(cnt)){ cnt = 0; }
		cnt = e?(cnt+1):(cnt-1);
		if(cnt==0){
			warningBox("1 이상이어야합니다.");
			return false;
		}
		$("#"+id).val(cnt);
	}
	
	function updateQuota(){
		confirmBox("변경 하시겠습니까?"
				,ajaxUpdateQuota
				,{
						projectId : "${projectId}"
						, projectName	: "${projectName}"
						, metadata_items : $("#quota_edit_metadata_items").val()
						, cores : $("#quota_edit_cores").val()
						, instances : $("#quota_edit_instances").val()
						, injected_files : $("#quota_edit_injected_files").val()
						, injected_file_content_bytes : $("#quota_edit_injected_file_content_bytes").val()
						, ram : $("#quota_edit_ram").val()
						, security_group : $("#quota_edit_security_group").val()
						, security_group_rule : $("#quota_edit_security_group_rule").val()
						, floatingip : $("#quota_edit_floatingip").val()
						, network : $("#quota_edit_network").val()
						, port : $("#quota_edit_port").val()
						, router : $("#quota_edit_router").val()
						, subnet : $("#quota_edit_subnet").val()
						, volumes : $("#quota_edit_volumes").val()
						, snapshots : $("#quota_edit_snapshots").val()
						, gigabytes : $("#quota_edit_gigabytes").val()
					}
		);	
	}
	function ajaxUpdateQuota(obj){
		$.ajax({
			url : "${contextPath}/mng/project/quota/update",
			dataType : "JSON",
			data : obj,
			success : function(data) {
				if(data.errorMsg=="1"){
					alertBox("변경 되었습니다.", detailQuota)
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	function selectBoxbyBillYear(){
		var today = new Date(); 
		var nowYear = today.getFullYear(); // 로컬 컴퓨터의 년(year)을 구함
		$("#billYear option").remove();
		$("#billYear").append('<option value="" selected="selected">전체</option>');
		$("#billYear").append('<option value="'+(nowYear-1)+'">'+(nowYear-1)+'</option>');
		$("#billYear").append('<option value="'+(nowYear)+'">'+(nowYear)+'</option>');
		$("#billYear").append('<option value="'+(nowYear+1)+'">'+(nowYear+1)+'</option>');
	}
	
	//nas 스크립트 시작
	function gridNasList(){
		//setDiskDiv("List");		
		$("#nas-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mbr/req/project/naslist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#disk_searchKind option:selected").val();
					d.keyword = $("#disk_keyword").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
					d.length = "0";
				}
			}
			, "initComplete" : function(setting, json){
				if(json.recordsTotal > 0){
					$("#h5Disk1").hide();
					$("#h5Disk2").show();
				}
			}		
			,"columns":[
				{"data":"nasName" , "class":"tac"}
				, {"data":"vmName" , "class":"tac"}
				, {"data":"nasGb" , "class":"tac"}
				, {"data":"hourlyFlag" , "class":"tac"}
				, {"data":"createDatetime" , "class":"tac", "width":"15%"}
				, {"class":"tac detail-control", "width":"10%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[3], "render": function(data,type,full){ 
 						if(full.hourlyFlag == "N"){
 							return "월 단위";	
 						}else{
 							return "시간 단위";
 						}
					}	
				}				 				
 				, {"targets":[5], "render": function(data,type,full){
					return "<a href=\"#nav-pills-tab-4-view\" data-toggle=\"tab\"><button type='button' class='btn btn-grey_01' onclick='nasview(\""+full.nasId+"\")' ><i class='fa fa-search'></i></button></a>";
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom">'
		});		
	}
	
	function nasview(nasId){				
		$.ajax({
			url : "${contextPath}/mbr/req/project/nasEditUpdate",		
			dataType : "JSON",
			type : "POST",
			data : {
				"nasId" : nasId
				},
			success : function(data) {		
				
					$("#editnasId2").val(data.nasId);
					$("#editnasName2").val(data.nasName);
					$("#editnasVm2").val(data.vmName);
					$("#editnasGb2").val(data.nasGb);
					$("#editcreateDatetime2").val(data.createDatetime);
					$("#editnasdescription2").val(data.description);			
					
					$("#nasView").show();
					$("#nas-listall").hide();
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
			
		})
		
	}
	
	function naslistview(){
		$("#nasView").hide();		
		$("#nas-listall").show();
		gridSubList();
	}
	//nas 스크립트 끝

	//lb 관련 스크립트 시작

	function lbview(loadbalancerId){				
		$.ajax({
			url : "${contextPath}/mbr/req/project/lbEditUpdate",		
			dataType : "JSON",
			type : "POST",
			data : {
				"loadbalancerId" : loadbalancerId
				},
			success : function(data) {		
				
					$("#editloadbalancerId2").val(data.loadbalancerId);
					$("#editlbName2").val(data.loadbalancerName);
					$("#editlbNetworkAlias2").val(data.networkAlias);
					$("#editlbProtocolName2").val(data.protocolName);
					$("#editlbMethodName2").val(data.methodName);
					$("#editlbMonitorTypeName2").val(data.monitorTypeName);
					$("#editlbLoadbalancerVm2").val(data.loadbalancerVm);
					$("#editlbCreateDatetime2").val(data.createDatetime);
					$("#editlbdescription2").val(data.description);
					
					$("#lbview").show();
					$("#lb-listall").hide();
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function lblistview(){
		$("#lbview").hide();		
		$("#lb-listall").show();
		gridSubList();
	}
	
	function gridLbList(){
		//setDiskDiv("List");		
		$("#lb-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mbr/req/project/lblist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#disk_searchKind option:selected").val();
					d.keyword = $("#disk_keyword").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
					d.length = "0";
				}
			}
			, "initComplete" : function(setting, json){
				if(json.recordsTotal > 0){
					$("#h5Disk1").hide();
					$("#h5Disk2").show();
				}
			}		
			,"columns":[
				{"data":"loadbalancerName" , "class":"tac"}
				, {"data":"hourlyFlag" , "class":"tac"}
				, {"data":"networkAlias" , "class":"tac"}
				, {"data":"createDatetime" , "class":"tac", "width":"15%"}
				, {"class":"tac detail-control", "width":"10%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[1], "render": function(data,type,full){ 
 						if(full.hourlyFlag == "N"){
 							return "월 단위";	
 						}else{
 							return "시간 단위";
 						}
					}	
				}				 				
 				, {"targets":[4], "render": function(data,type,full){
					return "<a href=\"#nav-pills-tab-4-view\" data-toggle=\"tab\"><button type='button' class='btn btn-grey_01' onclick='lbview(\""+full.loadbalancerId+"\")' ><i class='fa fa-search'></i></button></a>";
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom">'
		});		
	}
	// lb 관련 스크립트  끝
	
	// ip 스크립트 시작
	function ipview(publicipId){				
		$.ajax({
			url : "${contextPath}/mbr/req/project/ipEditUpdate",		
			dataType : "JSON",
			type : "POST",
			data : {
				"publicipId" : publicipId
				},
			success : function(data) {		
				
					$("#editipId2").val(data.publicipId);
					$("#editipHostname2").val(data.hostname);
					$("#editipHostnameAlias2").val(data.hostnameAlias);
					$("#editipcreateDatetime2").val(data.createDatetime);
					$("#editipdescription2").val(data.description);
					
					$("#ipview").show();
					$("#ip-listall").hide();
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function iplistview(){
		$("#ipview").hide();		
		$("#ip-listall").show();
		gridSubList();
	}
	
	function gridIpList(){
		$("#ip-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mbr/req/project/iplist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#disk_searchKind option:selected").val();
					d.keyword = $("#disk_keyword").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
					d.length = "0";
				}
			}
			, "initComplete" : function(setting, json){
				if(json.recordsTotal > 0){
					$("#h5Disk1").hide();
					$("#h5Disk2").show();
				}
			}		
			,"columns":[
				{"data":"hourlyFlag" , "class":"tac"}
				, {"data":"hostname" , "class":"tac"}
				, {"data":"hostnameAlias" , "class":"tac"}
				, {"data":"createDatetime" , "class":"tac", "width":"15%"}
				, {"class":"tac detail-control", "width":"10%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[0], "render": function(data,type,full){ 
 						if(full.hourlyFlag == "N"){
 							return "월 단위";	
 						}else{
 							return "시간 단위";
 						}
					}	
				}				 				
 				, {"targets":[4], "render": function(data,type,full){
					return "<a href=\"#nav-pills-tab-4-view\" data-toggle=\"tab\"><button type='button' class='btn btn-grey_01' onclick='ipview(\""+full.publicipId+"\")' ><i class='fa fa-search'></i></button></a>";
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom">'
		});		
	}
	
	// ip 스크립트 끝
	
	//백업 서비스 스크립트 시작
	function gridBakList(){
		$("#bak-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mbr/req/project/baklist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#disk_searchKind option:selected").val();
					d.keyword = $("#disk_keyword").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
					d.length = "0";
				}
			}
			, "initComplete" : function(setting, json){
				if(json.recordsTotal > 0){
					$("#h5Disk1").hide();
					$("#h5Disk2").show();
				}
			}		
			,"columns":[
				{"data":"hourlyFlag" , "class":"tac"}
				, {"data":"hostname" , "class":"tac"}
				, {"data":"hostnameAlias" , "class":"tac"}
				, {"data":"createDatetime" , "class":"tac", "width":"15%"}
				, {"class":"tac detail-control", "width":"10%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[0], "render": function(data,type,full){ 
 						if(full.hourlyFlag == "N"){
 							return "월 단위";	
 						}else{
 							return "시간 단위";
 						}
					}	
				}				 				
 				, {"targets":[4], "render": function(data,type,full){
					return "<a href=\"#nav-pills-tab-4-view\" data-toggle=\"tab\"><button type='button' class='btn btn-grey_01' onclick='bakview(\""+full.backupId+"\")' ><i class='fa fa-search'></i></button></a>";
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom">'
		});		
	}
	
	function bakview(backupId){
		$.ajax({
			url : "${contextPath}/mbr/req/project/bakExpr",
			dataType : "JSON",
			type : "POST",
			data : {
				"backupId" : backupId
				},
			success : function(data) {		
									
					$("#editbakHostname2").val(data.hostname);
					$("#editbakHostnameAlias2").val(data.hostnameAlias);
					$("#editbakcreateDatetime2").val(data.createDatetime);
					$("#editbakdescription2").val(data.description);
					$("#editbakId2").val(data.backupId);
										
					$("#bakview").show();
					$("#bak-listall").hide();
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
			
		})
	}
	
	function baklistview(){
		$("#bakview").hide();		
		$("#bak-listall").show();
		gridServiceList();
	}
	//백업 서비스 스크립트 끝
	
	//대외계 서비스 시작
	function gridMcaList(){
		$("#mca-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mbr/req/project/mcalist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#disk_searchKind option:selected").val();
					d.keyword = $("#disk_keyword").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
					d.length = "0";
				}
			}
			, "initComplete" : function(setting, json){
				if(json.recordsTotal > 0){
					$("#h5Disk1").hide();
					$("#h5Disk2").show();
				}
			}		
			,"columns":[
				{"data":"hourlyFlag" , "class":"tac"}				
				, {"data":"createDatetime" , "class":"tac", "width":"15%"}
				, {"class":"tac detail-control", "width":"10%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[0], "render": function(data,type,full){ 
 						if(full.hourlyFlag == "N"){
 							return "월 단위";	
 						}else{
 							return "시간 단위";
 						}
					}	
				}				 				
 				, {"targets":[2], "render": function(data,type,full){
					return "<a href=\"#nav-pills-tab-4-view\" data-toggle=\"tab\"><button type='button' class='btn btn-grey_01' onclick='mcaview(\""+full.mcaId+"\")' ><i class='fa fa-search'></i></button></a>";
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom">'
		});		
	}
	
	function mcaview(mcaId){
		$.ajax({
			url : "${contextPath}/mbr/req/project/mcaExpr",
			dataType : "JSON",
			type : "POST",
			data : {
				"mcaId" : mcaId
				},
			success : function(data) {	
					//calendar("mca_expr_applyDate");
					
					$("#editmcacreateDatetime2").val(data.createDatetime);
					$("#editmcadescription2").val(data.description);
					$("#editmcaId2").val(data.mcaId);
					if(data.hourlyFlag=="N"){
						$("#editmcahourlyFlag2").val("월 단위");
					}else{
						$("#editmcahourlyFlag2").val("시간 단위");
					}
					
					$("#mcaId").val(data.mcaId);
					$("#mcaprojectAlias").val(data.projectAlias);
					$("#mcaproductCategory").val(data.productCategory);
					$("#mcaimageName").val(data.imageName);
					$("#mcaproductSeq").val(data.mcaProductSeq);
					$("#mcacatalogSeq").val(data.mcaCatalogSeq);						
					
					$("#mcaview").show();
					$("#mca-listall").hide();
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
			
		})
	}
	
	function mcalistview(){
		$("#mcaview").hide();		
		$("#mca-listall").show();
		gridServiceList();
	}
	//대외계 서비스 끝
	
	//형상관리 서비스 시작
	function gridScmList(){
		$("#scm-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mbr/req/project/scmlist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#disk_searchKind option:selected").val();
					d.keyword = $("#disk_keyword").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
					d.length = "0";
				}
			}
			, "initComplete" : function(setting, json){
				if(json.recordsTotal > 0){
					$("#h5Disk1").hide();
					$("#h5Disk2").show();
				}
			}		
			,"columns":[
				{"data":"hourlyFlag" , "class":"tac"}				
				, {"data":"createDatetime" , "class":"tac", "width":"15%"}
				, {"class":"tac detail-control", "width":"10%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[0], "render": function(data,type,full){ 
 						if(full.hourlyFlag == "N"){
 							return "월 단위";	
 						}else{
 							return "시간 단위";
 						}
					}	
				}				 				
 				, {"targets":[2], "render": function(data,type,full){
					return "<a href=\"#nav-pills-tab-4-view\" data-toggle=\"tab\"><button type='button' class='btn btn-grey_01' onclick='scmview(\""+full.scmId+"\")' ><i class='fa fa-search'></i></button></a>";
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom">'
		});		
	}
	
	function scmview(scmId){
		$.ajax({
			url : "${contextPath}/mbr/req/project/scmExpr",
			dataType : "JSON",
			type : "POST",
			data : {
				"scmId" : scmId
				},
			success : function(data) {	
					$("#editscmcreateDatetime2").val(data.createDatetime);
					$("#editscmdescription2").val(data.description);
					$("#editscmId2").val(data.scmId);
					if(data.hourlyFlag=="N"){
						$("#editscmhourlyFlag2").val("월 단위");
					}else{
						$("#editscmhourlyFlag2").val("시간 단위");
					}
					$("#scmview").show();
					$("#scm-listall").hide();
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
			
		})
	}
	
	function scmlistview(){
		$("#scmview").hide();		
		$("#scm-listall").show();
		gridServiceList();
	}
	
	//형상관리 서비스 끝
	
	//보안관제 서비스 시작
	function gridScrList(){
		$("#scr-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mbr/req/project/scrlist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#disk_searchKind option:selected").val();
					d.keyword = $("#disk_keyword").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
					d.length = "0";
				}
			}
			, "initComplete" : function(setting, json){
				if(json.recordsTotal > 0){
					$("#h5Disk1").hide();
					$("#h5Disk2").show();
				}
			}		
			,"columns":[
				{"data":"hourlyFlag" , "class":"tac"}				
				, {"data":"createDatetime" , "class":"tac", "width":"15%"}
				, {"class":"tac detail-control", "width":"10%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[0], "render": function(data,type,full){ 
 						if(full.hourlyFlag == "N"){
 							return "월 단위";	
 						}else{
 							return "시간 단위";
 						}
					}	
				}				 				
 				, {"targets":[2], "render": function(data,type,full){
					return "<a href=\"#nav-pills-tab-4-view\" data-toggle=\"tab\"><button type='button' class='btn btn-grey_01' onclick='scrview(\""+full.securityId+"\")' ><i class='fa fa-search'></i></button></a>";
					}	
				}  				
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom">'
		});		
	}
	
	function scrlistview(){
		$("#scrview").hide();		
		$("#scr-listall").show();
		gridServiceList();
	}
	
	function scrview(securityId){
		$.ajax({
			url : "${contextPath}/mbr/req/project/scrExpr",
			dataType : "JSON",
			type : "POST",
			data : {
				"securityId" : securityId
				},
			success : function(data) {	
					//calendar("scr_expr_applyDate");					
									
					$("#editscrcreateDatetime2").val(data.createDatetime);
					$("#editscrdescription2").val(data.description);
					$("#editscrId2").val(data.securityId);
					if(data.hourlyFlag=="N"){
						$("#editscrhourlyFlag2").val("월 단위");
					}else{
						$("#editscrhourlyFlag2").val("시간 단위");
					}
					
										
					$("#scrview").show();
					$("#scr-listall").hide();
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
			
		})
	}
	//보안관제 서비스 끝
	
	//부가자원 선택
	function gridSubList(){
		gridDiskList();
		gridNasList();
		gridLbList();
		gridIpList();
	}
	//
	
	//서비스 선택
	function gridServiceList(){
		gridBakList();
		gridMcaList();
		gridScmList();
		gridScrList();
	}
	
	$(document).ready(function() {
		App.init();
		getDetail();
		gridVMList();
		
		$("#vm_keyword").keydown(function(e){
			if(e.keyCode == 13){
				gridVMList();
			}
		});
		$("#network_keyword").keydown(function(e){
			if(e.keyCode == 13){
				gridNetworkList();
			}
		});
		
		//메뉴활성화
		$("#project").addClass("active");
		$("#projectVM").addClass("active");
	});	
	
</script>
</body>
</html>