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
			<input type="hidden" id="hid_projectId" value="${req.projectId}">
			<input type="hidden" id="hid_projectName" value="${req.projectName}">
			<div class="page_header mb30">
				<h1>네트워크</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">네트워크 관리</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			 <div class="row mb50">
				<div class="client_DetailBg m-b-40">
					<div class="client_DetailArea">
						<h2 class="blueBoxTitle">프로젝트정보</h2>
						<p class="company_Name2" id="projectAlias"></p>
						<p class="company_Info m-b-25"> 
							<span class="company_labelf">본사 :</span><span class="company_cont" id="upCompanyName"></span>
							<span class="company_label">고객사 :</span><span class="company_cont" id="customerName"></span>
						</p>
					</div> 
				</div>
				
				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType02">
					
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a type="button" class="btnType01 m-r-5" onclick="excelDown();"><i class="ico_download"></i><span>다운로드</span></a>
						<a type="button" class="btnType01" onclick="moveInsertPage();"><i class="ico_write"></i><span>등록</span></a>
					</div>
					<!-- //상단 버튼  -->
					
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-15">
						<table id="Network-list" style="border-bottom: 0px none">
							<colgroup>
								<col width="197px">
								<col width="172px">
								<col width="250px">
								<col width="70px">
								<col width="138px">
								<col width="80px">
								<col width="65px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">네트워크명</th>
									<th scope="col">네트워크별칭</th>
									<th scope="col">관련 서브넷</th>
									<th scope="col">외부</th>
									<th scope="col">상태</th>
									<th scope="col">관리자상태</th>
									<th scope="col">상세</th>
								</tr>
							</thead>
							<tbody>
								<!-- <tr>
									<td class="fontVdn tal p-l-30">NMWCAPP012</td>
									<td class="tal">솔루션사업부검증_내A증_내A</td>
									<td class="fontVdn overflowN tal subnet">nhbank_mgt_int_subnet<br><span class="txtBlue fontVdn">12.2.10.0/24</span></td>
									<td class="fontVdn">YES</td>
									<td class="txtRed fontVdn txtSpacing1">HARD_REBOOT</td>
									<td class="fontVdn">UP</td>
									<td><a class="btn_viewDetail_gray" onclick="viewNetwork('');"></a></td>
								</tr>
								<tr>
									<td class="fontVdn tal p-l-30">NMWCAPP012</td>
									<td class="tal">솔루션사업부검증_내A증_내A</td>
									<td class="fontVdn overflowN tal subnet">nhbank_mgt_int_subnet<br><span class="txtBlue fontVdn">12.2.10.0/24</span></td>
									<td class="fontVdn txtRed">NO</td>
									<td class="fontVdn txtSpacing1">ACTIVE</td>
									<td class="fontVdn">UP</td>
									<td><a type="button" class="btn_viewDetail_gray" onclick="openModal();"></a></td>
								</tr>
								<tr>
									<td class="fontVdn tal p-l-30">NMWCAPP012dfdfdfdf</td>
									<td class="tal">솔루션사업부</td>
									<td class="fontVdn overflowN tal subnet">nhbank_mgt_int_subnet<br><span class="txtBlue fontVdn">12.2.10.0/24</span></td>
									<td class="fontVdn">YES</td>
									<td class="fontVdn txtRed txtSpacing1">SHUTOFF</td>
									<td class="fontVdn">UP</td>
									<td><a type="button" class="btn_viewDetail_gray" onclick="openModal();"></a></td>
								</tr>
								<tr>
									<td class="fontVdn tal p-l-30">NMWCAPP012dfdfdfdf</td>
									<td class="tal">솔루션사업부</td>
									<td class="fontVdn overflowN tal subnet">nhbank_mgt_int_subnet<br><span class="txtBlue fontVdn">12.2.10.0/24</span></td>
									<td class="fontVdn">YES</td>
									<td class="fontVdn txtRed txtSpacing1">SHUTOFF</td>
									<td class="fontVdn txtRed">DOWN</td>
									<td><a type="button" class="btn_viewDetail_gray" onclick="openModal();"></a></td>
								</tr> -->
							</tbody>
						</table>
					</div>
				</div>
				<!-- 테이블 끝 -->
				
				<div class="row tac m-t-40">	
					<a type="button" class="btnType03 btnType03_list" onclick="moveListPage();">목록</a>         
				</div>
				
	         	<%-- <!-- begin col-12 -->
	         	<div class="section-container inbox100">
	                	
	                <!-- begin panel -->
					<!-- begin normal input table---------->
					<div class="tableC">
						
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
									<td class="left-b height-40">고객사</td>
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
	                     	<button type="button" id="noticeList" class="btn btn-lime" onclick="moveInsertPage()"><i class="fa fa-edit"> </i> 수정 </button>
						 </sec:authorize>
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
						<li class="active"><a href="#nav-pills-tab-5" data-toggle="tab" onclick="gridNetworkList()"><i class="fa fa-share-alt"></i> 네트워크</a></li>
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
													<th class="tac">고객사 아이디</th>
													<th class="tac">고객사</th>
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
				<div class="tab-pane fade" id="nav-pills-tab-3">
				
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
										
										<!-- NAS -->
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
														<button type="button" class="btn btn-grey_01" onclick="viewtr('${getNasList.nasId}')"><i id="s${getNasList.nasId}" name="s${getNasList.nasId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
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
														<button type="button" class="btn btn-grey_01" onclick="viewtr('${getLbList.loadbalancerId}')"><i id="s${getLbList.loadbalancerId}" name="s${getLbList.loadbalancerId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
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
														<button type="button" class="btn btn-grey_01" onclick="viewtr('${getIpList.publicipId}')"><i id="s${getIpList.publicipId}" name="s${getIpList.publicipId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
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
														<button type="button" class="btn btn-grey_01" onclick="viewtr('${getBakList.backupId}')"><i id="s${getBakList.backupId}" name="s${getBakList.backupId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
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
														<button type="button" class="btn btn-grey_01" onclick="viewtr('${getMcaList.mcaId}')"><i id="s${getMcaList.mcaId}" name="s${getMcaList.mcaId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
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
														<button type="button" class="btn btn-grey_01" onclick="viewtr('${getScmList.scmId}')"><i id="s${getScmList.scmId}" name="s${getScmList.scmId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
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
														<button type="button" class="btn btn-grey_01" onclick="viewtr('${getScrList.securityId}')"><i id="s${getScrList.securityId}" name="s${getScrList.securityId}" class="fa fa-chevron-down t-in-3"></i> </button> 									
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
								</div>
							</div>
						<!-- 테이블 끝 -->
					
					
					
				</div>
				<!-- 탭14 종료 -->
				
				
				<!-- 탭5 (네트워크) 시작 -->
	            <div class="tab-pane fade active in pl0 pr0" id="nav-pills-tab-5">				
					<!-- search begin -->
					<div class="col-md-12 br5 p10 mb10 bgee">		
						<div class="col-md-2">
							<select class="form-control dp-in pb6" id="network_searchKind">
								<option value="network_name">네트워크명</option>
								<option value="network_alias">네트워크별칭</option>
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
								<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="">
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
									<td class="left-b p10">고객사 네트워크</td>
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
									<th class="tac">이름</th>
									<th class="tac">네트워크주소</th>
									<th class="tac">IP버전</th>
									<th class="tac">게이트웨이 IP</th>
									<th class="tac">상세</th>
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
							

                        </div>
                        <!-- end tab-content -->
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
	               	</div>--%>
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
					alertBox3(data.message);
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
	/* 
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
	 */
	
	function viewNetwork(networkId){
			var params = "?networkId="+networkId;
			params += "&projectName="+$('#hid_projectName').val();
			location.href = "${contextPath}/mng/project/network/viewDetail"+params; 
		// location.href = "${contextPath}/mng/project/network/viewDetail";
	}

	function getTextShared(shared){ return shared?"예":"아니오"; }
	function getTextRouterExternal(routerExternal){ return routerExternal?"YES":"NO"; }
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
				{"data":"networkName" , "class":"fontVdn tal p-l-30"}
				, {"data":"networkAlias" , "class":"tal p-l-20", "width":"20%"}
				, {"data":"subnets" , "class":"fontVdn onwrap tal subnet"}
			//	, {"data":"shared" , "class":"tac", "width":"6%"}
				, {"data":"routerExternal" , "class":"fontVdn"}
				, {"data":"status" , "class":"fontVdn txtSpacing1"}
				, {"data":"adminStateUp" , "class":"fontVdn"}
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
				 ,  {"targets":[3], "render": function(data,type,full){
					return getTextRouterExternal(full.routerExternal);
					}	
				} 
				,  {"targets":[4], "render": function(data,type,full){
					if (data =="ACTIVE" ||data =="RUNNING" ){
						return data;
					}else{
						return '<span class="fc-red">'+data +'</span>';
					}
					return getTextRouterExternal(full.routerExternal);
					}	
				} 
				 , {"targets":[5], "render": function(data,type,full){
					return getTextAdminStateUp(full.adminStateUp);
					}	
				}
				, {"targets":[6], "render": function(data,type,full){
					return "<a class='btn_viewDetail_gray' onclick='viewNetwork(\""+full.networkId+"\")' ></a>";
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
						if(i=="customerId" || i =="projectName"){
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
		location.href = "${contextPath}/mng/project/network/";
	} 
	// 등록/수정페이지 이동
	function moveInsertPage(){
		var projectId = $("#hid_projectId").val();
		location.href = "${contextPath}/mng/project/network/write?projectId="+projectId;
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
		location.href = "${contextPath}/mng/project/network/write";
		
	/* 	actCmmNetworkList();
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
		$("#network_insert_tab_hostRoutes").val(""); */
	}
	
	function setDiskDiv(gbn){
		$("#divDiskList").hide();
		$("#divDiskView").hide();
		$("#divDisk"+gbn).show();
		
		if(gbn=="View"){
			$("#divBtnDisk").show();
		}
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

	
	function actCnt(id, e){
		var cnt = parseInt($("#"+id).val(), 10);
		if(isNaN(cnt)){ cnt = 0; }
		cnt = e?(cnt+1):(cnt-1);
		if(cnt==0){
			alertBox3("1 이상이어야합니다.");
			return false;
		}
		$("#"+id).val(cnt);
	}
	
	function updateQuota(){
		confirmBox("변경 하시겠습니까?"
				,ajaxUpdateQuota
				,{
						projectId : $("#hid_projectId").val()
						, projectName	: $("#hid_projectName").val()
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
	
	function chkAlpha(e){
		$("#"+e).on('keyup',function(e){
			var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
			if(pattern.test(this.value)){
				$(this).val(this.value.replace(pattern, ''));
			}
			var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
			if(pattern2.test(this.value)){
				$(this).val(this.value.replace(pattern2, ''));
			}
			
		});
		$("#"+e).on('blur',function(e){
			var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
			if(pattern.test(this.value)){
				$(this).val(this.value.replace(pattern, ''));
			}
			var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
			if(pattern2.test(this.value)){
				$(this).val(this.value.replace(pattern2, ''));
			}
		});
		
	}
	
	$(document).ready(function() {
		App.init();
		getDetail();
		gridNetworkList();
		
		chkAlpha("network_insert_tab_networkName");
		chkAlpha("network_insert_tab_subnetName");
		
		$("#network_keyword").keydown(function(e){
			if(e.keyCode == 13){
				gridNetworkList();
			}
		});
		
		//메뉴활성화
		$("#project").addClass("active");
		$("#projectNetwork").addClass("active");
	});	
	
</script>
</body>
</html>