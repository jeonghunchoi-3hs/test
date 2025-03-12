<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
		
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
		
			<!-- begin page-header -->
			<h1 class="page-header"><span class="root"> <span class="home"><img src="/resources/assets/img/ico_home.png"  alt="홈"/></span> <span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow mint"><a href="${wasPath}/mbr/cmm/customer/customerView"><strong>고객사</strong></a></span> </span></h1>
			<!-- end page-header -->

			<!-- begin page-body -->
			<div class="row mb50">
				<!-- 20170916 -->
				<div class="customer_information">
					<div class="id_info">
						<div class="top_c">
							<input type="hidden" id="customerId" value="${customerView.customerId}">
							<input type="hidden" id="h_billYyyymm" value="">
							<input type="hidden" id="popCategory" value="">
							<input type="hidden" id="popProduct" value="">
							
							<div class="pic" id="picback">
								<c:if test="${filePic.size() eq 0}">
									<span class="mask"></span>
									<img name="dPic" id="dPic" src="${apachePath}/resources/assets/img/ico_userInfo_picto.png" alt="사진"/>
									<input type="hidden" id="h_fileId" value="">
								</c:if>
								<c:if test="${filePic.size() ne 0}">
									<span class="mask"></span>
									<img name="cPic" id="cPic" src="${wasPath}/mbr/cmm/file/download/${filePic.get(0).fileId}" alt="사진"/>
									<input type="hidden" id="h_fileId" value="${filePic.get(0).fileId}">
								</c:if>
							</div>
							<div class="pictooltip" id="picsettip">
								<span>버튼으로 이미지를</span>
								<p>등록하거나 수정하실 수 있습니다.</p>									
							</div>
							<p class="name" id="customerName">${customerView.customerName}</p>
							<p class="name" id="customerId">(${customerView.customerId})</p>
							<div class="per_wrap">
								<span class="txt">부가가치율</span><span class="per nanumR" id="vatRate">${customerView.vatRate}<span class="f24">%</span></span>
							</div>
						</div>
						<div class="etc_info">
							<div class="l_info">
								<dl>
									<dt>사업자 등록번호</dt>
									<dd style="display: none" id="companyName">${customerView.companyName}</dd>
									<dd id="companyNo nanumR">${customerView.companyNo}</dd>
								</dl>
								<p class="down"></p>
<%-- 								<c:forEach items="${file}" var="filelist" varStatus="status" > --%>
<%-- 									<a href="${filelist.filePath}${filelist.fileId}">${filelist.fileName}</a> --%>
<%-- 									<div><a href="${filelist.filePath}${filelist.fileId}">${filelist.fileName}</a></div> --%>
<%-- 								</c:forEach> --%>
							</div>
							<div class="r_info">
								<dl>
									<dt>법인 등록번호</dt>
									<dd style="display: none" id="companyRep">${customerView.companyRep}</dd>
									<dd id="corporationNo nanumR">${customerView.corporationNo}</dd>
								</dl>
								<%-- <dl>
									<dt>업태 · 업종</dt>
									<dd><span id="bizCondition">${customerView.bizCondition}</span> · <span id="bizType">${customerView.bizType}</span></dd>
								</dl> --%>
							</div>
						</div>
						<p class="modify"><a href="#" onclick="openModal2();"><img src="/resources/assets/img/icon_modify.png" alt="수정하기" /></a></p>
						<a class="moreViewBtn" onclick="openDetailView();">자세히보기</a>
						
					</div>
					<!-- // id_info -->
					<div class="project_info">
						<div class="money_info">
							<p class="tit">당월 사용금액</p>
							<p class="num nanumR"><span id="currentAmount"></span>원</p>
							<p class="detail_btn">
							<c:if test="${currentAmount.billYyyymm eq null}">
							<a type="button" onclick="noExist();">자세히</a>
							</c:if>
							<c:if test="${currentAmount.billYyyymm ne null}">
							<a href="${wasPath}/mbr/charge/bill/view?currentBillYyyymm=${currentAmount.billYyyymm}">자세히</a>
							</c:if>
							</p>
						</div>
						<div class="mng_info">
							<input type="hidden" name="managerId" id="managerId" value="" />
							<p class="tit">고객사 관리자 정보</p>
							<dl class="pic">
								<dt><span class="mask"></span><img src="/resources/assets/img/user_sample2.png" alt="고객사사진" /></dt>
								<dd><span id="userName">${customerView.userName}</span><span class="email nanumR"id="userMail">${customerView.userMail}</span></dd>
							</dl>
							<dl class="cell"> 
								<dt><img src="/resources/assets/img/icon_cell.png" alt="휴대폰번호" /></dt>
								<dd id="userPhone" class="nanumR ls1">${customerView.userPhone}</dd>
							</dl>
							<dl class="phone">
								<dt><img src="/resources/assets/img/icon_phone.png" alt="전화번호" /></dt>
								<dd id="userTel" class="nanumR ls1">${customerView.userTel}</dd>
							</dl>
						</div>
						<div class="project_process">
							<div class="circle_chart">
								<p class="tit tit_type2">자원현황</p>
								<div class="resourcesBox">
									<ul class="resBox01">
										<li><em class="nanumR">${getResourceTotalAmount.serverCnt}</em><p><strong>SERVER</strong>(EA)</p></li>
									</ul>
									<ul class="resBox02">
										<li class="resCpu"><em class="nanumR"><fmt:formatNumber value="${getResourceTotalAmount.vcpus}" pattern="#,###"/></em><p class="nanumR"><strong>vCPU</strong>(Core)</p></li>
										<li class="resMem"><em class="nanumR"><fmt:formatNumber value="${getResourceTotalAmount.memGb}" pattern="#,###"/></em><p class="nanumR"><strong>MEM</strong>(GB)</p></li>
										<li class="resDisk"><em class="nanumR"><fmt:formatNumber value="${getResourceTotalAmount.diskGb}" pattern="#,###"/></em><p class="nanumR"><strong>DISK</strong>(GB)</p></li>
									</ul>
								</div>
								

								 
							</div>
							<div class="horizontal_chart1">
								<p class="tit">최근3개월</p>
								<div id="divCharts2"></div> 
							</div>
							<div class="horizontal_chart1_zone">
								<br/>
								<p class="horizontal_chart1_label"><fmt:formatNumber value="${get3MonthAmountList.get(0).amount}" pattern="#,###"/> 원</p>
								<br/>
								<p class="horizontal_chart1_label"><fmt:formatNumber value="${get3MonthAmountList.get(1).amount}" pattern="#,###"/> 원</p>
								<br/>
								<p class="horizontal_chart1_label"><fmt:formatNumber value="${get3MonthAmountList.get(2).amount}" pattern="#,###"/> 원</p>
								<br/>
							</div>
						</div>
					</div>
					<!-- // "project_info" -->
				</div>
				<!-- // 20170916 -->
                   
					<!---tab사용---->
                    <!-- begin col-6 -->
                    <div class="mt70">
                        <!-- begin nav-pills -->
                        <ul class="tap nav-pills nav-pills-primary">
                            <li class="active"><a href="#nav-pills-tab-1" data-toggle="tab" onclick="chargeList();">청구요금</a></li>                           
                            <li><a href="#nav-pills-tab-3" data-toggle="tab" onclick="gridList();">프로젝트</a></li>
                            <li><a href="#nav-pills-tab-4" data-toggle="tab" onclick="userList();">권한설정</a></li>
                        </ul>
                        <!-- end nav-pills -->
                        <!-- begin tab-content -->
                        <div class="tab-content panel bg-white">
							<div class="tab-pane fade active in pl0 pr0" id="nav-pills-tab-1">
								
								<!-- search begin -->
								<div class="col-md-12 p10 mb20 bgee searchBoxAr">
									<div class="" style="text-align: center; display:inline-block;"> 
										<div class="selectBoxAr" style="width:125px;">
											<label class="selectText" for="billYear">전체</label>
											<select class="search-sel" id="billYear" name="billYear">
												<option value="">전체</option>
												<c:forEach items="${getBillYyyy}" var="getBillYyyy" varStatus="status" >			
												<option value="${getBillYyyy.billYyyy}">${getBillYyyy.billYyyy}</option>							
												</c:forEach>
											</select>
										</div>
										<div class="selectBoxAr" style="width:125px;margin:0 0 0 25px;">
											<label class="selectText" for="billMonth">전체</label>
											<select class="search-sel" id="billMonth">
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
										</div>
										<button type="button" class="btn_search" onclick="chargeList();"><span></span></button>
	  								</div> 
								</div>			
   								<!-- search end -->
								
								<!-- 테이블시작 -->
								<div class="col-md-12 pl0 pr0">
									<div class="panel">
										<div class="table-responsive">
											<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="charge-list" summary="고객사 청구요금">
					 							<caption>게시판 목록 : 청구년월, 고객사, 사용요금, 할인금액, 청구요금, 상세로 구성</caption> 
					 							<colgroup>
													<col width="15%">
													<col width="*">
													<col width="15%">
													<col width="15%">
													<col width="15%">
													<col width="10%">
												</colgroup>
												<thead>
													<tr class="skyblue">
														<th class="tac" scope="col">청구년월</th>
														<th class="tac" scope="col">고객사</th>
														<th class="tar" scope="col">사용요금</th>
														<th class="tar" scope="col">할인금액</th> 
														<th class="tar" scope="col">청구요금</th> 
														<th class="tac" scope="col">상세</th> 
													</tr>
												</thead>
											</table>
										</div>
									</div>
								</div>
								<!-- 테이블 끝 -->
							</div>

                            <div class="tab-pane fade" id="nav-pills-tab-3">
								<!-- search begin -->
								<div class="col-md-12 br5 p10 mb20 bgee">
									<div class="" style="text-align: center; display:inline-block;"> 
										<div class="selectBoxAr" style="">
											<label class="selectText" for="searchKind">전체</label>
											<select class="search-sel" id="searchKind">
												<option value="searchAll">전체</option>
												<option value="project_alias">프로젝트명</option>
												<option value="project_name">프로젝트코드</option>
											</select>
										</div>
										<div class="searchBoxAr" style="">
											<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
											<button type="button" class="btn_search2"  onclick="gridList()"><span></span></button>
										</div>

								  	</div>
								</div>		

								<div class="col-md-12 pl0 pr0">
									<div class="panel">
									    <div class="table-responsive">
									        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="table-list" summary="고객사 프로젝트">
									        	<caption>게시판 목록 : 사업자, 고객사, 프로젝트명, 프로젝트코드, 담당 PM, 상세로 구성</caption> 
									        	<colgroup>
													<col width="15%">
													<col width="15%">
													<col width="*">
													<col width="15%">
													<col width="15%">
													<col width="10%">
												</colgroup>
												<thead>
												    <tr class="skyblue">
														<th scope="col">사업자</th>
														<th scope="col">고객사</th>
														<th scope="col">프로젝트명</th>
														<th scope="col">프로젝트코드</th>
														<th scope="col">담당 PM</th>
														<th scope="col">상세</th>
												    </tr>
												</thead>
											</table>
										</div>
									</div>			
								</div>
                            </div>
                            
                            
                            <div class="tab-pane fade" id="nav-pills-tab-4">
                                
								<!-- search begin -->
								<div class="col-md-12 br5 p10 mb20 bgee">
							    	<div class="" style="text-align: center; display:inline-block;"> 
										<div class="selectBoxAr" style="">
											<label class="selectText" for="searchKind2">전체</label>
											<select class="search-sel" id="searchKind2">
												<option value="searchAll">전체</option>
												<option value="userName">사용자 이름</option>
												<option value="userId">사용자 아이디</option>
												<option value="userPhone">휴대폰</option>
											</select>
										</div>
										<div class="searchBoxAr" style="">
											<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword2" onkeypress="if(event.keyCode==13)userList();"/>
											<button type="button" class="btn_search2"  onclick="userList()"><span></span></button>
										</div>
	
									</div>
								</div>

								<div class="col-md-12 pl0 pr0">
									<div class="panel">
									    <div class="table-responsive">
									        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="table-userlist" summary="고객사 권한설정">
									        	<caption>게시판 목록 : 사용자이름, 사번, 핸드폰, 고객사관리자, 회계담당, 프로젝트관리자로 구성</caption> 
												<colgroup>
													<col width="130px">
													<col width="150px">
													<col width="*">
													<col width="140px">
													<col width="140px">
													<col width="140px">
													<col width="90px">
												 </colgroup>
												<thead>
												    <tr class="skyblue">
														<th scope="col">사용자이름</th>
														<th scope="col">사번</th>
														<th scope="col">핸드폰</th>
														<th scope="col">고객사관리자</th>
														<th scope="col">회계담당</th>
														<th scope="col">프로젝트관리자</th>
<!-- 														<th>등록일시</th> -->
														<th style="border-right:none;" scope="col">상세</th>
												    </tr>
												</thead>
											</table>
										</div>
									</div>			
								</div>
                            </div>
                        </div>
                        <!-- end tab-content -->
                    </div>
                    <!-- end col-6 -->	
					<!------tab 사용------>                   
                  
                <!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">사용자권한설정</h4>
	                       </div>
	                       <div class="modal-body">
		                       <div class="userinfoArea">	
		                       		<img class="fl" alt="" src="${apachePath}/resources/assets/img/pic_Bg.png">
		                       		<div class="fl pl20"> 
										<span class="userName" id="usernameView"></span>
										<span class="userBrit">(<span class="userId nanumR" id="useridView"></span>)</span>      
		                       			<p class="userAttach" id="cusomernameView"></p>	                       		
		                       		</div> 
		                       		<div class="infoArea"> 
										<span class="userTel nanumR" id="usertelView"></span><span class="userPhone nanumR" id="userphoneView"></span>      
		                       			<p class="userEmail nanumR" id="useremailView"></p>	                        		
		                       		</div>
		                       </div>
		                       <div class="abilityArea">
		                       		<p class="tit">권한설정</p>
		                       		<div class="chkArea">
		                       			<ul>
		                       				<li>
		                       					<input type="checkbox"  name="adchk" id="adchk"> 회계담당
		                       				</li>
		                       				<li>
		                       					<input type="checkbox" name="pmchk" id="pmchk"> 프로젝트 관리자
		                       				</li>
		                       			</ul>
									</div>
		                       </div>
	                      	</div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="lbtn" data-dismiss="modal" onclick="valchk();">저장</a>	 
	                   			<a type='button' class="rbtn" data-dismiss="modal">닫기</a>
	                   			<div class="whiteline2"></div> 
	                   			<div class="doubleline"></div>
	                       		<input type="hidden" id="authority1" name="authority1"  value="">
								<input type="hidden" id="authority2" name="authority2"  value="">
								<input type="hidden" id="userAuthority" name="userAuthority"  value="">
								<input type="hidden" id="userId" name="userId"  value="">
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
                   
				<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog1">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">알림</h4>
	                       </div>
	                       <div class="modal-body">
								변경된 권한을 적용하려면 재로그인을 해야 됩니다.								
								
	                      	</div>
	                       	<div class="modal-footer tac">
	                       		<input type="button" class="btn btn-info width-100" value="로그인화면으로" onclick="logout();"/>
	                   			<a type='button' class="btn btn-default width-80" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog --> 
				
				
				<!-- 청구요금 상세 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="bill-modal-dialog">
	               <div class="modal-dialog width-720"> 
	                   <div class="modal-content width-720"> 
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">청구요금상세</h4>
	                       </div>
	                       <div class="modal-body" id="billDetailTable">
	                       		<div class="cloudArea">
	                       			<ul>
	                       				<li class="w43">
	                       					<p class="title">클라우드 자원</p>
	                       					<p class="total nanumR">888,888,888<span>&nbsp;원</span></p>
	                       				</li>
	                       				<li class="w57">
	                       					<div id="divCharts3" style="float:left;">
												<img alt="" src="/resources/assets/img/modal_sp.png">
											</div>
											<div class="chart_list_text_modal">
												<ul>
													<li class="cr01"><span class="title">기본자원</span><span class="price"></span>&nbsp;원</li>
													<li class="cr02"><span class="title">부가자원</span><span class="price"></span>&nbsp;원</li>
													<li class="cr03"><span class="title">서비스</span><span class="price"></span>&nbsp;원</li>
												</ul>
											</div>
	                       				</li>
	                       			</ul>
	                       		</div>
	                       		<div class="contentArea">
	                       			<ul class="sumArea">
	                       				<li class="active"> 
	                       					<div class="suminfo">
	                       						<span class="title fl f16">기본자원</span>
		                       					<span class="flr f14 unit"><span class="nanumR f24">217,217,531</span>&nbsp;원</span>
	                       					</div>
	                       					<div class="detailArea">
	                       						<ul class="detail">
		                       						<li>
		                       							<span class="fl f14">기본자원</span>
		                       							<span class="flr f14"><span class="nanumR f16">217,217,531</span>&nbsp;원</span>
		                       						</li>
		                       						<li>
		                       							<span class="fl f14">기본자원</span>
		                       							<span class="flr f14"><span class="nanumR f16">217,217,531</span>&nbsp;원</span>
		                       						</li>
		                       					</ul>
	                       					</div>
	                       				</li>
	                       				<li class="active"> 
	                       					<div class="suminfo">
	                       						<span class="title fl f16">부가자원</span>
		                       					<span class="flr f14 unit"><span class="nanumR f24">217,217,531</span>&nbsp;원</span>
	                       					</div>
	                       					<div class="detailArea">
	                       						<ul class="detail">
		                       						<li>
		                       							<span class="fl f14">블록디스크</span>
		                       							<span class="flr f14"><span class="nanumR f16">217,217,531</span>&nbsp;원</span>
		                       						</li>
		                       						<li>
		                       							<span class="fl f14">NAS</span>
		                       							<span class="flr f14"><span class="nanumR f16">217,217,531</span>&nbsp;원</span>
		                       						</li>
		                       					</ul>
	                       					</div>
	                       				</li>
	                       				<li class="active">  
	                       					<div class="suminfo">
	                       						<span class="title fl f16">서비스</span>
		                       					<span class="flr f14 unit"><span class="nanumR f24">217,217,531</span>&nbsp;원</span>
	                       					</div>
	                       					<div class="detailArea">
	                       						<ul class="detail">
		                       						<li>
		                       							<span class="fl f14">백업관리</span>
		                       							<span class="flr f14"><span class="nanumR f16">217,217,531</span>&nbsp;원</span>
		                       						</li>
		                       						<li>
		                       							<span class="fl f14">대외계 서비스</span>
		                       							<span class="flr f14"><span class="nanumR f16">217,217,531</span>&nbsp;원</span>
		                       						</li>
		                       					</ul>
	                       					</div>
	                       				</li>
	                       			</ul>
	                       		</div>
	                       		
								<%-- <div class="tableB">
									<table>
										<colgroup>
									 		<col width="200px;">
									 		<col width="*">									 		
									 	</colgroup>
									 	<tbody id="billDetailTable">											
											
										</tbody>									
									</table>
								</div> --%>
								<div class="subDetail">
									<ul class="subtable">
	                       				<li> 
	                       					<div class="sub-title">
	                       						<span class="title fl f16">요금할인</span>
		                       					<span class="flr f14 mt4 unit"><span class="nanumR f24 won">- 217,531</span>&nbsp;원</span>
	                       					</div>
	                       					<div class="sub-content">
	                       						<ul class="detail">
		                       						<li>
		                       							<span class="fl f14">- 프로젝트 할인</span>
		                       							<span class="flr f14 unit"><span class="nanumR f16 won">- 217,531</span>&nbsp;원</span>
		                       						</li>
		                       						<li>
		                       							<span class="fl f14">- 10원미만 절사 할인</span>
		                       							<span class="flr f14 unit"><span class="nanumR f16 won">- 8</span>&nbsp;원</span> 
		                       						</li>
		                       					</ul>
	                       					</div>
	                       				</li>
	                       				<li> 
	                       					<div class="sub-title">
	                       						<span class="title fl f16">보정</span>
		                       					<span class="flr f14 mt4 unit"><span class="nanumR f24 won">- 217,531</span>&nbsp;원</span>
	                       					</div>
	                       					<div class="sub-content">
	                       						<ul class="detail">
		                       						<li>
		                       							<span class="fl f14">- 특가 보정</span>
		                       							<span class="flr f14 unit"><span class="nanumR f16 won">- 17,531</span>&nbsp;원</span>
		                       						</li>
		                       						<li>
		                       							<span class="fl f14">- 리뷰 인권비</span>
		                       							<span class="flr f14 unit"><span class="nanumR f16 won">+ 1,000</span>&nbsp;원</span>
		                       						</li>
		                       					</ul>
	                       					</div>
	                       				</li>
	                       				<li> 
	                       					<div class="last-sub-title">
	                       						<span class="title fl f16">부가가치세(세금)</span>
		                       					<span class="flr f14 mt4 unit"><span class="nanumR f24 won">- 217,531</span>&nbsp;원</span>
	                       					</div>
	                       				</li>
	                       			</ul>  
								</div>
								
								<div class="totalArea">
									<span class="fl title">총 청구금액</span> 
                 					<span class="flr unit"><span class="nanumR won">423,800</span>&nbsp;원</span>
								</div>
							</div> 
							<div class="clear"></div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="whiteline" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->                  
			
			<!-- #modal-dialog -->
			<div class="modal fade" id="modal-dialog-profileImg">
	            <div class="modal-dialog">
	                <div class="modal-content">
	                    <div class="modal-header btlr5 btrr5">
	                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                        <h4 class="modal-title">고객사사진 등록</h4>
	                    </div>
	                    <div class="modal-body">
	                       
	                       <div class="profileImgBox type2">
	                       		<div class="thumbNailImg" id="image_preview">
	                       		<span class="mask"></span>
	                       		<c:if test="${filePic.size() eq 0}">
									<img name="popPicD" src="${apachePath}/resources/assets/img/ico_userInfo_picto.png" alt="사진"/>
								</c:if>
								<c:if test="${filePic.size() ne 0}">
									<img name="popPic" src="${wasPath}/mbr/cmm/file/download/${filePic.get(0).fileId}" alt="사진"/>
								</c:if>
<!-- 	                       		<img src="/resources/assets/img/ico_userInfo_picto.png" alt=""> -->
	                       		</div>
	                       		<div class="box">
	                       			<strong>고객사 사진</strong>
	                       			<a href="#"><i class="ico_search_green"></i><span>사진등록</span></a>
	                       			<a type='button' onclick="fileRemove()"><i class="ico_del_orange"></i><span>사진삭제</span></a>
	                       			
									<form id="file-form" name="file-form" action="${wasPath}/mbr/cmm/file/deleteInsert" method="post" enctype="multipart/form-data" target="_iframeFile" >
											<input class='btn_picSearch' type='file' id='files' name='files' onchange="$('#file-form').submit(); closeModal();"/>
<!-- 											<input class='btn_picSearch' type='file' id='files' name='files'/> -->
											<input class='btn_picSearch' type='hidden' id='fileName' name='fileName'/>
<!-- 											<input class='btn_picSearch' type='text' id='files' name='files'/> -->
									       	<div id="files-list" style='display:none;'></div>
									       	<input type='hidden' id='programName' name='programName' value='cmm_customer_pic'>
									       	<input type='hidden' id='programSeq' name='programSeq' value='${customerView.customerId}'>
								    </form>		                       			
	                       			<div style='display:none;'><iframe id='_iframeFile' name='_iframeFile'></iframe></div>
	                       			
	                       		</div>
	                       		<p class="noticeCmt"><span class="txtBlue">78px X 78px</span> 사이즈에 최적화 되어 있습니다.<br>등록할 이미지 사이즈가 다른 경우 다르게 보일 수 있습니다.<br><span class="txtRed">등록할 이미지는 10MB을 초과할 수 없습니다.<span></p>
	                       </div>
	                       
	                    </div>
	                    <div class="modal-footer tac">
                   			<a type='button' class="whiteline" data-dismiss="modal" onclick="">닫기</a>
                       	</div>
	            	</div>
	        	</div>
	        </div>
			<!-- #modal-dialog -->
			
			<!-- 프로젝트 리네임 팝업 -->
	           	<div class="modal fade" id="moreview-modal-dialog">
	               <div class="modal-dialog">
	                   	<div class="modal-content">
	                       	<div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                       	   <h4 class="modal-title">고객사 상세</h4>
	                       	</div>
	                       	<div class="modal-body">
								<div class="topArea2"></div> 
	                       		<div class="bottomArea"> 
	                       			<div class="pic" id="detailPop">
										<c:if test="${filePic.size() eq 0}">
											<img name="detailPopPicD" src="${apachePath}/resources/assets/img/ico_userInfo_picto.png" alt="사진"/>
										</c:if>
										<c:if test="${filePic.size() ne 0}">
											<img name="detailPopPic" src="${wasPath}/mbr/cmm/file/download/${filePic.get(0).fileId}" alt="사진"/>
										</c:if>
									</div>
									<ul class="cluodInfoArea ml30 mt-10">
										<li class="fc11 f22">${customerView.customerName}</li>
										<li class="fc66 f20 lh20">(<span class="fc3a728e nanumR fb">${customerView.customerId}</span>)</li>
										<li class="f16 fc66 lh50">사업자 등록번호 : <span class="f18 fc11 nanumR">${customerView.companyNo}</span></li>
									</ul>
									
									<div class="bubInfoArea">
										<ul class="bubInfoAreaList">
											<li><span class="title01 f14 fc66">법인등록번호</span><span class="ml5 f16 fc11 nanumR">${customerView.corporationNo}</span></li>
											<li class="mt-5"><span class="title01 f14 fc66">부가가치세율</span><span class="ml5 f16 fc11 nanumR">${customerView.vatRate}%</span></li>
											<li class="mt5"><span class="title02 f14 fc66 mt5">업태</span><span class="coments f14 fc11 mt3">${customerView.bizCondition}</span></li>
											<li class=""><span class="title02 f14 fc66 mt5">업종</span><span class="coments f14 fc11 mt3">${customerView.bizType}</span></li>
										</ul>
									</div>
	                       		</div> 
							</div>   
							<div class="clear"></div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="whiteline" data-dismiss="modal" onclick="">확인</a>
	                       	</div> 
	                   	</div>
	               	</div>
	           	</div>
	        </div>
		<!-- begin #footer -->
		<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #footer -->
	</div>
	<!-- end #content -->
</div>
<!-- end page container -->

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">
	function gridList() {
		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true 
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url": "${wasPath}/mbr/oss/project/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.customerId = $("#customerId").val();
				}
			}
			,"columns":[ 
				{"data":"companyName" , "class":"tac"}
				, {"data":"customerName" , "class":"tac"}
				, {"data":"projectAlias" , "class":"tal"}
				, {"data":"projectName" , "class":"tac nanumR"} 
				, {"data":"userName" , "class":"tac"}
		        , {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[5], "render": function(data,type,full){
				//	<button class="btn btn-grey_01 width-40 tac" onclick="openModal(\''+full.userId+'\',\''+full.customerId+'\')"><i class="fa fa-search ml-2"></i></button>
					return '<button type="button" class="tac mt5 table-search" onclick="movePageDetail(\''+full.projectId+'\',\''+full.projectName+'\')"/><span></span></button> ';
// 					return '<input type="button" class="btn btn-info w-80" value="상세보기" onclick="movePageDetail(\''+full.projectId+'\',\''+full.projectName+'\')"/> ';
					}	
				}				
			]
			,"order": [[2,"asc"]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
					, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"ip>'
		});
	}
	
	function movePageDetail(projectId, projectName){
		var params = "?projectId="+projectId;
		params += "&projectName="+projectName;
		
		location.href = "${wasPath}/mbr/req/project/okprojectView.do"+params;
	}
	
	function userList() {
		$("#table-userlist").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url": "${wasPath}/mbr/cmm/customer/userlist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind2 option:selected").val();
					d.keyword = $("#keyword2").val();
					d.customerId = $("#customerId").val();
				}
			}
			,"columns":[ 
				{"data":"userName" , "class":"tac"}
				, {"data":"userId" , "class":"tac f16"}
				, {"data":"userPhone" , "class":"tac f16"}
				, {"data":"authority0" , "class":"tac"}
				, {"data":"authority2" , "class":"tac"}
				, {"data":"authority1" , "class":"tac"}
// 				, {"data":"authority3" , "class":"tac"}
// 				, {"data":"regDatetime" , "class":"tac f16"}
		        , {"class":"tac", "width":"92px"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[3], "render":function(data,type,full){
					if(full.authority0 == "O"){
						return '<img src="/resources/assets/img/t-icon03.png" alt=""/>';
					}else{
						return "";
					}
				}}
				, {"targets":[4], "render":function(data,type,full){
					if(full.authority2 == "O"){
						return '<img src="/resources/assets/img/t-icon01.png" alt=""/>';
					}else{
						return "";
					}
				}}
				, {"targets":[5], "render":function(data,type,full){
					if(full.authority1 == "O"){
						return '<img src="/resources/assets/img/t-icon02.png" alt=""/>';
					}else{
						return "";
					}
				}}
				/* , {"targets":[5], "render":function(data,type,full){
					if(full.authority3 == "O"){
						return '<img src="/resources/assets/img/t-icon03.png" alt=""/>'; 
					}else{
						return "";
					}
				}} */
				, {"targets":[6], "render": function(data,type,full){
					return '<button type="button" class="tac mt5 table-search" onclick="openModal(\''+full.userId+'\',\''+full.customerId+'\')"><span></span></button>';
						//return '<input type="button" class="btn btn-info" value="상세보기" onclick="userPageDetail(\''+full.userId+'\',\''+full.customerId+'\')"/> <input type="button" class="btn btn-info w-80" value="모달" onclick="openModal(\''+full.userId+'\',\''+full.customerId+'\')"/>';
					}
				}				
			]
			,"order": [[0,"asc"]]
			,"lengthMenu": [[5,15], [5, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
					, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"ip>'
		});
	}
	
	function userPageDetail(userId, customerId){
		//var params = "?projectId="+projectId;
		//params += "&projectName="+projectName;

		//location.href = "/mbr/oss/project/view"+params;
		//alert(userId);
		//alert(customerId);
		window.open('${wasPath}/mbr/cmm/customer/userPopView?userId='+userId+'&customerId='+customerId,'_blank','');
	}
	
	//modal팝업 open
	
	function openModal2(){
		$("#modal-dialog-profileImg").modal();
	}
	function closeModal(){
		$("#modal-dialog-profileImg").modal("hide");
		
		setTimeout (function(){
			getImgFile();
		},500);
	}

	function openModal(userId,customerId){
		
		//var userId=userId;
		//var customerId=customerId;				
		$.ajax({
			url : "${wasPath}/mbr/cmm/customer/userViewModal",
			dataType : "JSON",
	//			type : "POST",
			data : {
				"customerId" : customerId	
				,"userId" : userId 
			},
			success : function(data) {
				//	alert("111");
				//	alert(data.userId);
					$("#useridView").text(data.userId);
					$("#cusomernameView").text(data.customerName);
					$("#usernameView").text(data.userName);
					$("#userphoneView").text(data.userPhone);
					$("#usertelView").text(data.userTel);
					$("#useremailView").text(data.userMail);
					$("#authority1").val(data.authority1);
					$("#authority2").val(data.authority2);
					//alert(data.userAuthority);
					//alert(data.userId);
					$("#userAuthority").val(data.userAuthority);
					$("#userId").val(data.userId);
					if(data.authority1=="1"){						
						$("#pmchk").prop('checked',true);
					}else{
						$("#pmchk").prop('checked',false);
					}
					if(data.authority2=="1"){						
						$("#adchk").prop('checked',true);
					}else{
						$("#adchk").prop('checked',false);
					}
					//$("#useremailView").text(data.authority1);
					//$("#useremailView").text(data.authority2);
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					$("#modal-dialog").hide();
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox("code:" + request.status + "\n" + "error:" + error, logout);
				}	
			}
		});
		
		setTimeout (function(){
			$("#modal-dialog").modal();
		},100);
		
	}
	
	
	// 청구요금 조회
	function chargeList() {
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
				"url": "${wasPath}/mbr/charge/bill/list"
				,"type" : "GET"
				,"data":function (d) {
					d.billYyyymm = billYyyymm;
					d.customerId = $("#customerId").val();
				}
			}
			,"columns":[ 
				{"data":"billYyyymm", "class":"tac f16"}
// 	        	, {"data":"customerId", "class":"tac"}
	        	, {"data":"customerName", "class":"tac"}
// 	        	, {"data":"projectId", "class":"tac"}
// 	        	, {"data":"projectAlias", "class":"tac"}
	        	, {"data":"A000Amount", "class":"tar f16"}
	        	, {"data":"dcAmount", "class":"tar fc-blue f16"}
	        	, {"data":"totAmount", "class":"tar fc-red fb f16"}
	        	, {"class":"tac", "width":"92px"}
	        ]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0], "render": function(data,type,full){
					var date = full.billYyyymm;
					return date.substring(0,4) + "-" + date.substring(4,6);
					}	
				}  	
// 				, {"targets":[1],"visible":false,"searchable":false }
// 				, {"targets":[3],"visible":false,"searchable":false }
				, {"targets":[2],"render":function(data,type,full){
					return addcomma(full.A000Amount);
				} }
				, {"targets":[3],"render":function(data,type,full){
					return addcomma(full.dcAmount);
				} }
				, {"targets":[4],"render":function(data,type,full){
					return addcomma(full.totAmount);
				} }
				, {"targets":[5],"render":function(data,type,full){
					return '<button type="button" class="tac mt5 table-search" onclick="billDetailPop(\''+full.customerId+'\',\''+full.billYyyymm+'\')"><span></span></button>';
				} }
			]
			,"order": [[0,"desc"]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
					, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"ip>'
		});
	}
	
	// 청구서 상세
	/* function billDetailPop(customerId, billYyyymm){
		$("#bill-modal-dialog").modal();
		$.ajax({
			url : "${ajaxPath}/mbr/charge/bill/detail",
			dataType : "JSON",
			type : "POST",
			data : {
				"customerId" : customerId
				,"billYyyymm" : billYyyymm
			},
			success : function(data) {
				var billInfoList = data.detail;
				
				//$("#billDetailTable > tr").remove();
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
					}else if(billLevel=="LA00"){	//부가가치세
						Html="<tr><td class='t-in38 vm'>· "+val["invoiceItemName"]+"</td>";
						Html = Html + "<td class='tar pr10'><span class='fc66 f16'>"+addcomma(val["amount"])+"</span> 원</td></tr>";
					}else if(billLevel=="0000"){	//총 청구금액
						$("#totalAmount").text(addcomma(val["amount"]));
					}
					
					//$("#billDetailTable").append(Html);	
				});
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	} */
	
	//청구서 상세
	function billDetailPop(customerId, billYyyymm){
		$("#bill-modal-dialog").modal();
		$.ajax({
			url : "${wasPath}/mbr/charge/bill/detail",
			dataType : "JSON",
			type : "POST",
			data : {
				"customerId" : customerId
				,"billYyyymm" : billYyyymm
			},
			success : function(data) {
				var billInfoList = data.detail;
				var popCategory = data.popCategory;
				var popProduct = data.popProduct;
				
				$("#popCategory").val(popCategory);
				$("#popProduct").val(popProduct);
				
				var vHtml = "";	//고정태그
				var Html = "";	//동적태그
				
				//팝업초기화
				$("#billDetailTable").empty();
				
				if(billInfoList != ""){
					$.each(billInfoList,function(key,val){
						var billLevel = val["invoiceItem"];
						Html = "";
						if(billLevel=="A000"){	//클라우드 자원
							Html = "<div class='cloudArea'>";
							Html += 	"<ul>";
							Html += 		"<li class='w43'>";
							Html += 			"<p class='title'>"+val["invoiceItemName"]+"</p>";
							Html += 			"<p class='total nanumR'>"+addcomma(val["amount"])+"<span>&nbsp;원</span></p>";
							Html += 		"</li>";
							Html += 		"<li class='w57'>";
							Html += 		"<div id='divCharts3' style='float:left;'>";
							Html += 		"</div>";
							Html += 		"<div class='chart_list_text_modal'>";
							Html += 			"<ul>";
							
							$.each(billInfoList,function(key,val){
								var billLevel2 = val["invoiceItem"];
								if(billLevel2=="AA00"){
									Html += 				"<li class='cr01'><span class='title'>기본자원</span><span class='price'>"+addcomma(val["amount"])+"</span>&nbsp;원</li>";
									amount1 = [val["amount"]];
								}else if(billLevel2=="AE00"){
									Html += 				"<li class='cr02'><span class='title'>부가자원</span><span class='price'>"+addcomma(val["amount"])+"</span>&nbsp;원</li>";
									amount2 = [val["amount"]];
								}else if(billLevel2=="AI00"){
									Html += 				"<li class='cr03'><span class='title'>서비스</span><span class='price'>"+addcomma(val["amount"])+"</span>&nbsp;원</li>";
									amount3 = [val["amount"]];
								}
							});	
						
							Html += 			"</ul>";
							Html += 		"</div>";
							Html += 		"</li>";
							Html += 	"</ul>";
							Html += "</div>";
							
							$("#billDetailTable").append(Html);
						}
					});
				
					$.each(billInfoList,function(key,val){
						var billLevel = val["invoiceItem"];
						
						if(billLevel=="AA00"){	//기본 자원
							Html = "<div class='contentArea'>";
							Html += 	"<ul class='sumArea'>";
							Html += 		"<li class='active'>";
							Html += 			"<div class='suminfo'>";
							Html += 				"<span class='title fl f16'>"+val["invoiceItemName"]+"</span>";
							Html += 				"<span class='flr f14 unit'><span class='nanumR f24'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
							Html += 			"</div>";
							
							$.each(billInfoList,function(key,val){
								var billLevel2 = val["invoiceItem"];
								
								if(billLevel2=="AAA0"){	//가상 서버
									Html +=				"<div class='detailArea'>";
									Html +=					"<ul class='detail'>";
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14'><span class='nanumR f20'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
									Html +=					"</ul>";
									Html += 			"</div>";
								}
							});
							Html += 	"</li>";
						}
					});		
					
					$.each(billInfoList,function(key,val){
						var billLevel = val["invoiceItem"];
						if(billLevel=="AE00"){	//부가자원
							Html +=			"<li class='active'>";
							Html += 			"<div class='suminfo'>";
							Html += 				"<span class='title fl f16'>"+val["invoiceItemName"]+"</span>";
							Html += 				"<span class='flr f14 unit'><span class='nanumR f24'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
							Html += 			"</div>";
							
							Html += 			"<div class='detailArea'>";
							Html +=					"<ul class='detail'>";
							
							$.each(billInfoList,function(key,val){
								var billLevel2 = val["invoiceItem"];
								if(billLevel2=="AEA0"){	
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14'><span class='nanumR f20'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
								}else if(billLevel2=="AEB0"){
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14'><span class='nanumR f20'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
								}else if(billLevel2=="AEC0"){
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14'><span class='nanumR f20'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
								}else if(billLevel2=="AED0"){
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14'><span class='nanumR f20'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
								}
							});
							
							Html +=					"</ul>";
							Html += 			"</div>";
							Html +=			"</li>";
						}
					});
					
					$.each(billInfoList,function(key,val){
						var billLevel = val["invoiceItem"];
						if(billLevel=="AI00"){	//서비스
							Html +=			"<li class='active'>";
							Html += 			"<div class='suminfo'>";
							Html += 				"<span class='title fl f16'>"+val["invoiceItemName"]+"</span>";
							Html += 				"<span class='flr f14 unit'><span class='nanumR f24'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
							Html += 			"</div>";
							
							Html += 			"<div class='detailArea'>";
							Html +=					"<ul class='detail'>";
							
							$.each(billInfoList,function(key,val){
								var billLevel2 = val["invoiceItem"];
								if(billLevel2=="AIA0"){		//백업서비스	
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14'><span class='nanumR f20'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
								}else if(billLevel2=="AIB0"){	//대외계서비스
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14'><span class='nanumR f20'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
								}else if(billLevel2=="AIC0"){	//형상관리서비스
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14'><span class='nanumR f20'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
								}else if(billLevel2=="AID0"){	//보안관제서비스
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14'><span class='nanumR f20'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
								}
							});
							
							Html +=					"</ul>";
							Html += 			"</div>";
							Html +=			"</li>";
						}
					});
					
					vHtml += 	"</ul>";
					vHtml += "</div>";
					
					$.each(billInfoList,function(key,val){
						var billLevel = val["invoiceItem"];
						
						if(billLevel=="E000"){	//요금할인
							Html += "<div class='subDetail'>";
							Html += 	"<ul class='subtable'>";
							Html += 		"<li>";
							Html += 			"<div class='sub-title'>";
							Html += 				"<span class='title fl f16'>"+val["invoiceItemName"]+"</span>";
							Html += 				"<span class='flr f14 mt4 unit'><span class='nanumR f24 won'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
							Html += 			"</div>";
							
							Html +=				"<div class='sub-content'>";
							Html +=					"<ul class='detail'>";
							
							$.each(billInfoList,function(key,val){
								var billLevel2 = val["invoiceItem"];
								
								if(billLevel2=="EA00"){		//프로젝트할인
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14 unit'><span class='nanumR f16 won'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
								}else if(billLevel2=="EL00"){ 	//10원미만 절사 할인
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14 unit'><span class='nanumR f16 won'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
								}
							});
						
							Html += 				"</ul>";
							Html += 			"</div>";
							Html += 		"</li>";
							
						}else if(billLevel=="I000"){ 	// 보정
							Html += 		"<li>";
							Html += 			"<div class='sub-title'>";
							Html += 				"<span class='title fl f16'>"+val["invoiceItemName"]+"</span>";
							Html += 				"<span class='flr f14 mt4 unit'><span class='nanumR f24 won'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
							Html += 			"</div>";
							
							Html +=				"<div class='sub-content'>";
							Html +=					"<ul class='detail'>";
							
							$.each(billInfoList,function(key,val){
								var billLevel2 = val["invoiceItem"];
								
								if(billLevel2=="IA00"){		//보정내역
									Html +=						"<li>";
									Html +=							"<span class='fl f14'>"+val["invoiceItemName"]+"</span>";
									Html +=							"<span class='flr f14 unit'><span class='nanumR f16 won'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
									Html +=						"</li>";
								}
							});
							Html += 				"</ul>";
							Html += 			"</div>";
							Html += 		"</li>";
							
						}else if(billLevel=="L000"){	//부가가치세(세금)
							Html += 		"<li>";
							Html += 			"<div class='last-sub-title'>";
							Html += 				"<span class='title fl f16'>"+val["invoiceItemName"]+"</span>";
							Html += 				"<span class='flr f14 mt4 unit'><span class='nanumR f24 won'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
							Html += 			"</div>";
							Html +=			"</li>";
						}
					});		
					
					Html += 	"</ul>";
					Html += "</div>";
					
					$.each(billInfoList,function(key,val){
						var billLevel = val["invoiceItem"];
						
						if(billLevel=="0000"){	//요금할인
							Html +=	"<div class='totalArea'>";
							Html +=		"<span class='fl title'>총 청구금액</span>"; 
							Html +=		"<span class='flr unit'><span class='nanumR won'>"+addcomma(val["amount"])+"</span>&nbsp;원</span>";
							Html += "</div>";
						}
					});
					
					vHtml += Html;

					$("#billDetailTable").append(vHtml);
					
					//팝업 내 토글
					$(".suminfo").click(function name() {
						var viewDetail = $(this).parents("li");
						viewDetail.toggleClass('active'); 
					});
					billChartPop(); 	//차트					
				}else{
					$("#billDetailTable").append("청구요금이 없습니다.");	
				}

			},
			error : function(request, status, error) {
				if(request.status == '200'){
					$("#bill-modal-dialog").hide();
					alertBox("접속이 만료되었습니다.", logout);														
				}else{
					alertBox("code:" + request.status + "\n" + "error:" + error, logout);
				}
			}
		});
	}
	
	function valchk(){				
		if($("input:checkbox[name='adchk']").is(":checked")){
			$("#authority2").val("1");	
		}else{
			$("#authority2").val("0");
		}	
		if($("input:checkbox[name='pmchk']").is(":checked")){
			//alert("프로젝트 관리자");
			$("#authority1").val("1");	
		}else{
			$("#authority1").val("0");
		}	
		//$("#userEdit").submit();
		
		$.ajax({
			url : "${wasPath}/mbr/cmm/customer/userModalViewEdit",
			dataType : "JSON",
	//			type : "POST",
			data : {
				"userAuthority" : $("#userAuthority").val()	
				,"userId" :  $("#userId").val() 
				,"authority1" :  $("#authority1").val()
				,"authority2" :  $("#authority2").val()
			},
			success : function(data) {
				userList();
				if($("#userId").val() == $("#loginId").val() ){
					confirmBox("변경된 권한은 재 로그인시 "+"<br>"+"적용됩니다."+"<br>"+"로그인페이지로 이동하시겠습니까?", logout);
				}
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					$("#modal-dialog").hide();
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox("code:" + request.status + "\n" + "error:" + error, logout);
				}	
			}
		});		
	}
	<%--
	// 차트 
	function resourceChart(){
		
		var colors = Highcharts.getOptions().colors,
	    categories = ['SERVER', 'vCPU', 'MEM', 'DISK'],
	    data = 
	    	//"${getResourceTotalAmount}"
	    	[ ${getResourceTotalAmount1}, ${getResourceTotalAmount2}, ${getResourceTotalAmount3}, ${getResourceTotalAmount4}]

		,
	    browserData = [],
	    versionsData = [],
	    i,
	    j,
	    dataLen = data.length,
	    drillDataLen,
	    brightness;


		// Build the data arrays
		for (i = 0; i < dataLen; i += 1) {
	
		    // add browser data
		    //browserData.push({
		    //    name: categories[i],
		    //    y: data[i].y,
		    //    color: data[i].color
		    //});
	
		    // add version data
		    drillDataLen = data[i].drilldown.data.length;
		    for (j = 0; j < drillDataLen; j += 1) {
		        brightness = 0.2 - (j / drillDataLen) / 5;
		        versionsData.push({
		            name: data[i].drilldown.categories[j],
		            y: data[i].drilldown.data[j],
		            color: Highcharts.Color(data[i].color).brighten(brightness).get()
		        });
		    }
		}

		// Create the chart
		Highcharts.chart('divCharts1', {
		    chart: {
		        type: 'pie'
		        , height : 150
		        , width : 150
		        , backgroundColor: "#f9f9f9"
		        , margin : 0
		    },
		    title: {
		        text: ''
		    },
		    subtitle: {
		        text: ''
		    },
		    colors :['#e84971', '#ac5fbd', '#30f6e7', '#6396e5'],
		    plotOptions: {
		        pie: {
		            shadow: false,
		            center: ['50%', '50%'],
					borderWidth:0
		        }
				,series : {
					states:{
						hover:{
							enabled : false
						}
					},
					enableMouseTracking: false
				}
		    },
		    exporting : {
				enabled : false
			},
			credits : {
				enabled : false
			},
		    tooltip: {
		        valueSuffix: '%'
				,enabled : false
		    },
		    series: [{
		        name: 'Versions',
		        data: versionsData,
		        size: '80%',
		        innerSize: '60%',
				dataLabels: {
		            formatter: function () {
		                // display only if larger than 1
		                //return this.y > 1 ? '<b>' + this.point.name + ':</b> ' +
		                //    this.y + '%' : null;
		            }
		        },
		        id: 'versions'
		    }],
		    responsive: {
		        rules: [{
		            condition: {
		                maxWidth: 400
		            },
		            chartOptions: {
		                series: [{
		                    id: 'versions',
		                    dataLabels: {
		                        enabled: false
		                    }
		                }]
		            }
		        }]
		    }
		});
	}
	  --%>
	function billChart(){
		var colors = ['#ecdb69', '#a591d9', '#7ece55', '#6396e5'];
		Highcharts.chart('divCharts2', {
			chart: {
		        type: 'bar'
				, height : 150
			    , width : 255
				, backgroundColor: "#f9f9f9"
		    },
		    title: {
		        text: ''
		    },
		    subtitle: {
		        text: ''
		    },
			colors :['#ecdb69', '#a591d9', '#7ece55', '#6396e5'],
		    xAxis: {
		        categories: ${get3Yyyymm},
		        title: {
		            text: null
		        }
				, lineWidth:0
				, tickLength : 0
				, labels : {
					formatter : function(){
						var ym = this.value;
						var yy = ym.substr(0,4);
						var mm = ym.substr(4,5);
						return yy+"."+mm;
					}
					,
					style : {
						fontSize : '14px'
					}
				}
		    },
		    yAxis: {
		        min: 0,
				title: {
		            text: '',
		            align: 'high'
		        }
				,gridLineWidth: 0
				,labels : {
					overflow: 'justify',
					enabled : false,
					align: "right",
					style : {
						fontSize : '13px' 
					}
				}
				
		    },
		    exporting : {
				enabled : false
			},
			credits : {
				enabled : false
			},
		    tooltip: {
		        valueSuffix: '%'
				,enabled : false
		    },
		    plotOptions: {
		        bar: {
		            dataLabels: {
		            	enabled: false,
						align : 'left',
						inside : true,
						color : '#333',
						x : 210
		            },
					borderRadius: 3
		        },
				series : {
					states:{
						hover:{
							enabled : false
						}
					},
					enableMouseTracking: false
				}
		    },
		    legend: {
		        enabled : false
			},
		    credits: {
		        enabled: false
		    },
		    series: 
		    	/* [
				{
					data:[
						{y:1070,color:colors[0]},
						{y:1500,color:colors[1]},
						{y:4000,color:colors[2]}
					]
					,
					dataLabels : {
						formatter : function(){
							return addcomma(this.y);
						} 
					}
				}
			] */
			${get3MonthAmount}
		});
	}
	
	
	function billChartPop(){
		var product = $("#popProduct").val();
		product = eval(product);
		
		// Create the chart
		Highcharts.chart('divCharts3', {
		    chart: {
		        type: 'pie'
		        , height : 150
		        , width : 150
		        , backgroundColor: "#f9f9f9"
		        , margin : 0
		    },
		    title: {
		        text: ''
		    },
		    subtitle: {
		        text: ''
		    },
		    colors :['#e84971', '#ac5fbd', '#30f6e7', '#6396e5'],
		    plotOptions: {
		        pie: {
		            shadow: false,
		            center: ['50%', '50%'],
					borderWidth:0
		        }
				,series : {
					states:{
						hover:{
							enabled : false
						}
					},
					enableMouseTracking: false
				}
		    },
		    exporting : {
				enabled : false
			},
			credits : {
				enabled : false
			},
		    tooltip: {
		        valueSuffix: '%'
				,enabled : false
		    },
		    series: [{
		        name: 'Versions',
		        data: product,
		        size: '80%',
		        innerSize: '60%',
				dataLabels: {
		            formatter: function () {
		                // display only if larger than 1
		                //return this.y > 1 ? '<b>' + this.point.name + ':</b> ' +
		                //    this.y + '%' : null;
		            }
		        },
		        id: 'versions'
		    }],
		    responsive: {
		        rules: [{
		            condition: {
		                maxWidth: 400
		            },
		            chartOptions: {
		                series: [{
		                    id: 'versions',
		                    dataLabels: {
		                        enabled: false
		                    }
		                }]
		            }
		        }]
		    }
		});
	}
	
	//파일 삭제 및 썸네일 삭제
	function fileRemove(){
		if($("#h_fileId").val()==""){
			alertBox3("삭제할 사진이 없습니다.");
			return false;
		}else{
			var fileId = $("#h_fileId").val();
			
			$.ajax({
				url : "${wasPath}/mbr/cmm/file/delete",
				dataType : "JSON",
				type : "POST",
				data : {
					"fileId" : fileId
					, "programName" : "cmm_customer_pic"
					, "programSeq" :  $("#customerId").val()
				},
				success : function(data) {
					alertBox("삭제되었습니다.", closeModal);
				},
				error : function(request, status, error) {
					if(request.status == '200'){
						alertBox("접속이 만료되었습니다.", logout);				
					}else{
						alertBox("code:" + request.status + "\n" + "error:" + error, logout);
					}
				}
			});
		}
// 		$(".MultiFile-remove").trigger('click');
// 		$("#image_preview > img").attr("src", "/resources/assets/img/myInfo_profileImgPicto.png");
	}
	
	function getImgFile(){
		
		$.ajax({
			url : "${contextPath}/mbr/cmm/file/list",
			dataType : "JSON",
			data : {
				"programName" : "cmm_customer_pic"
				, "programSeq" :  $("#customerId").val()
			},
			success : function(data) {
				if(data.length !=0){
					$.each(data,function(key,val){
						var imgPath = "${wasPath}/mbr/cmm/file/download/"+val["fileId"];
						$("#picback > img[name='cPic']").attr("src",imgPath);
						$("#picback > img[name='dPic']").attr("src",imgPath);
						$("#h_fileId").val(val["fileId"]);
						$("#image_preview > img[name='popPic']").attr("src",imgPath);
						$("#image_preview > img[name='popPicD']").attr("src",imgPath);
						$("#detailPop > img[name='detailPopPic']").attr("src",imgPath);
						$("#detailPop > img[name='detailPopPicD']").attr("src",imgPath);
					});
				}else{
					var imgPath = "${apachePath}/resources/assets/img/ico_userInfo_picto.png";
					$("#picback > img[name='cPic']").attr("src",imgPath);
					$("#h_fileId").val("");
					$("#image_preview > img[name='popPic']").attr("src",imgPath);
					$("#image_preview > img[name='popPicD']").attr("src",imgPath);
					$("#image_preview > img[name='popPic']").attr("src",imgPath);
					$("#image_preview > img[name='popPicD']").attr("src",imgPath);
					$("#detailPop > img[name='detailPopPic']").attr("src",imgPath);
					$("#detailPop > img[name='detailPopPicD']").attr("src",imgPath);
				}
			},
			error : function(request, status, error) {
				alertBox("code : " + request.status + "\n" + "error : " + request.responseText, logout);
			}
		});
	}
	
	
	
	function delFile(fileId){
		$.ajax({
			url : "${contextPath}/mbr/cmm/file/delete",
			dataType : "JSON",
			data : {
				"fileId" : fileId
				, "programName": $("#programName").val()
				, "programSeq" : $("#downloadNo").val()
			},
			success : function(data) {
				updateFilesCnt("1");			
			},
			error : function(request, status, error) {
				alertBox("code : " + request.status + "\n" + "error : " + request.responseText, logout);
			}
		})
	}
	
	function noExist(){
		alertBox3("조회할 사용금액이 없습니다.");
	}
	
	$(document).ready(function() {
		App.init();
		
		if("${currentAmount}" != ""){
			$("#currentAmount").text(addcomma("${currentAmount.amount}")+" ");
			$("#h_billYyyymm").val("${currentAmount.billYyyymm}");
		}else{
			$("#currentAmount").text("0");
			var currentYear = (new Date()).getFullYear();
			var currentMonth = (new Date()).getMonth();
		}
		
// 		resourceChart();
		billChart();
		chargeList();
		
		// select box text 설정
		$(".search-sel").change(function() {
			$(this).siblings(".selectText").text($(this).children('option:selected').text());
		});

		//pic tool tip
		$("#picback").mouseover(function () {
			$("#picsettip").show();
		}).mouseout(function () {
			$("#picsettip").hide();  
		});
		
		
		$('#files').MultiFile({
			list: "#files-list"
			, max : 1
			, accept : 'gif|jpg|png'
			, maxFile : 10024
			, maxSize :  50024
			, STRING : {
				duplicate : "$file 은 이미 선택된 파일입니다."
				, denied : "$ext 는(은) 업로드 할수 없는 파일 확장자 입니다."
				, toomuch : "업로드 할 수 있는 최대크기를 초과하였습니다.($size)"
				, toomany : "업로드 할 수 있는 최대 갯수는 $max개 입니다."
				, toobig : "$file 은 크기가 매우 큽니다.(max $size)"
			},
		});
		//팝업 내 토글
// 		$(".suminfo").click(function name() {
// 			var viewDetail = $(this).parents("li");
// 			viewDetail.toggleClass('active'); 
// 		});
		
		//메뉴활성화
		$("#customerInfo").addClass("active");
		
	});
	
	function openDetailView(){
		$("#moreview-modal-dialog").modal(); 
	}
</script>

</body>
</html>
