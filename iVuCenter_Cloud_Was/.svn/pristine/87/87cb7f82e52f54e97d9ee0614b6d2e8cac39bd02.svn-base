<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri = "http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
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

	<style type="text/css">
/* 		.reset_hope_table, .resetTableDrow{
			display: none;
		} */
	</style>


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

			<!-- begin #page-container content -->
			<div id="content" class="content">
				<p class="page_title">자원삭제
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> <b>자원 삭제 </b>
			    </span>
			    </p>

				<!-- begin content > page-body -->
				<div class="row p20 bgwh br10">

					<div class="pdManageWrap">
					 	<input type="hidden" id="h_vm_uuid" 			value="" />
					 	<input type="hidden" id="h_create_datetime" 	value="" />
					 	<input type="hidden" id="h_create_datetime2" 	value="" />
					 	<input type="hidden" id="h_hourly_flag" 		value="" />
					 	<input type="hidden" id="h_service_name" 		value="" />
					 	<input type="hidden" id="h_service_type" 		value="" />
					 	<input type="hidden" id="h_disk_type" 			value="" />
					 	<input type="hidden" id="h_disk_type_name" 		value="" />
					 	<input type="hidden" id="h_disk_type_code" 		value="" />
					 	<input type="hidden" id="h_disk_alias" 			value="" />
					 	<input type="hidden" id="h_network_alias" 		value="" />
					 	<input type="hidden" id="h_network_id" 			value="" />
					 	<input type="hidden" id="h_network_name" 		value="" />
						<input type="hidden" id="h_projectId" 			value="${projectId}">
						<input type="hidden" id="projectId" 			value="" />
						<input type="hidden" id="cloudId" 				value="" />
						<input type="hidden" id="cloudName" 				value="" />
						<input type="hidden" id="cloudType" 				value="" />
						<input type="hidden" id="h_gubun" 				value="${gubun}">
						<input type="hidden" id="h_requestType" 		value="REQTYPE_CHANGE">
						<input type="hidden" id="h_requestTypeCode" 	value="">
						<input type="hidden" id="h_productCategory" 	value="">
						<input type="hidden" id="h_productId" 			value="${productId}">
						<input type="hidden" id="h_price_vm_cpu_hourly" 		value="">
						<input type="hidden" id="h_price_vm_cpu_monthly_price" 	value="">
						<input type="hidden" id="h_price_vm_mem_hourly" 		value="">
						<input type="hidden" id="h_price_vm_mem_monthly_price" 	value="">
						<input type="hidden" id="h_price_vm_disk_hourly" 		value="">
						<input type="hidden" id="h_price_vm_disk_monthly_price" value="">

					 	<input type="hidden" id="hiddenUserIdReview" 	value="" />
					 	<input type="hidden" id="hiddenUserNameReview" 	value="" />
					 	<input type="hidden" id="hiddenUserIdApprove" 	value="" />
					 	<input type="hidden" id="hiddenUserNameApprove" value="" />
					 	<input type="hidden" id="h_loginId" 			value="${userId}" />

					 	<input type="hidden" id="approvalStepListString" />

					 	<input type="hidden" id="apprvPass"				value="${apprvPass}" />
						<input type="hidden" id="selectApprv"			value="" />

						<div class="visualArea">
							<strong>보유 자원에 대하여 자원삭제를 하실 수 있습니다.</strong>
							<p>프로젝트를 선택하고 자원유형을 선택한 후 보유중인 자원 삭제를 요청하세요.</p>
						</div>

<!-- 						<ul class="tap nav-pills nav-pills-primary">
							<li >
								<a href="#nav-pills-tab-1" data-toggle="tab" onclick="setRequestType('REQTYPE_CHANGE');">변경신청</a>
							</li>
		                    <li class="active">
		                    	<a href="#nav-pills-tab-2" data-toggle="tab" onclick="setRequestType('REQTYPE_EXPR');">삭제신청</a>
		                    </li>
		                </ul> -->


		                <!-- 변경신청 & 삭제신청 부분 시작 -->
		                <div class="tab-content panel bg-white p0 btno">
		                	<!-- 변경 신청 탭 시작 -->
	                	<div id="nav-pills-tab-1" class="tab-pane">
			                	<div class="formWrapper mt20">
			                		<!-- 프로젝트 & 자원 선택 시작 -->
				                	<div class="formHeader">
				                		<table>
				                			<colgroup>
				                				<col width="10%">
				                				<col width="*">
				                			</colgroup>
				                			<tbody>
				                				<tr>
				                					<th class="vat">프로젝트</th>
				                					<td>
				                						<div class="searchBoxArea">
																<label class="selectBoxDrop" for="selectProjectName">프로젝트를 선택하세요</label>
																<select class="search-sel" name="selectProjectName" id="selectProjectName" onchange="changeProjectName('project');">
																</select>
														</div>

														<p class="fcsb f14 mt10"><i class="fa fa-exclamation-circle"></i> 자신이 관리자로 등록된 프로젝트만 선택이 가능합니다.</p>
				                					</td>
				                				</tr>
				                				<tr>
				                					<th class="vat">자원</th>
				                					<td class="vat">
				                						<div class="searchBoxArea" style="width:39%">
																<label class="selectBoxDrop" for="productSeq">자원을 선택하세요</label>
																<select class="search-sel" name="productSeq" id="productSeq" onchange="openModal('selectBox', true);">
																	<option value="자원을 선택하세요" selected="selected">자원을 선택하세요</option>
																	<option value="vm">가상서버</option>
																	<option value="disk">블록디스크</option>
																	<option value="app">어플리케이션</option>

																	<!-- <option value="service">서비스</option> -->
																	<!-- <option value="lb">서비스네트워크</option> -->
																	<!-- <option value="nas">NAS</option> -->
																	<!-- <option value="ip">공인IP</option> -->
																</select>
														</div>
														<div class="productSearch">
															<input class="form-control" type="text" name="productName" id="productName" onclick="openModal('button');" readonly="readonly">
															<input class="form-control" type="hidden" name="productId" id="productId" >
															<img src="/resources/assets/img/icon_search.png" onclick="openModal('button');" class="input_search">
														</div>
														<p class="fcsb f14 pt10"><i class="fa fa-exclamation-circle"></i>  자원을 선택하시면 보유중인 자원목록을 조회할 수 있습니다.</p>
				                					</td>
				                				</tr>
				                			</tbody>
				                		</table>
				                	</div>
				                	<!-- 프로젝트 & 자원 선택 끝 -->

				                   	<!-- 현재 이용중인 정보 & 변경신청 시작 -->
				                   	<div class="formContents" >

				                   		<!-- 현재 이용중인 정보 시작 -->
				                   		<div class="formBoxWrap formBoxType1">
			                   				<div class="titArea">· 현재 이용중인 정보</div>
			                   				<p class="info_txt reset_info_text"><span class="f18 fc_violet">프로젝트 </span>를 <span class="f18 fc_violet">선택</span>하신 후  <span class="f18 fc_green">자원</span>을  <span class="f18 fc_green">선택</span>하시면<br/>현재 이용중인 정보가 표기됩니다.</p>
				                   			<div class="tableWrap">
				                   				<table class="tableA resetTableDrow" >
				                   					<colgroup>
				                   						<col width="20%">
				                   						<col width="*">
				                   					</colgroup>
				                   					<tbody id="before_table">
				                   					</tbody>
				                   				</table>
				                   			</div>
			                   			</div>
			                   			<!-- 현재 이용중인 정보 끝 -->

			                   			<!-- 변경신청 시작 -->
			                   			<div class="formBoxWrap formBoxType2">
			                   				<div class="titArea">· 변경신청</div>
			                   				<div class="tableWrap">
				                   				<table class="tableG reset_hope_table">
				                   					<colgroup>
				                   						<col width="15%">
				                   						<col width="*">
				                   					</colgroup>
				                   					<tbody>
			                   							<tr>
			                   								<th scope="row" class="vat">희망일시</th>
				                   							<td>
				              									<div class="radioArea">
																	<input type="radio"  class="va-tb" id="onDemandFlag" name="onDemandFlag" value="N" checked/>  희망일시 변경&nbsp; &nbsp;
																	<input type="radio"  class="va-tb" id="onDemandFlag" name="onDemandFlag" value="Y"/> 승인 완료 후 변경
																</div>

																<p class="fcsb f14 mt5 clearfix mb20"> <span id="selectGubun"> </span> 클라우드 관리자의 최종승인 후  <span id="changeMsg"> 선택한 시간에  </span><span id='textProdect_'></span>변경됩니다.<br/>&nbsp;&nbsp;&nbsp;변경이 적용될시 가상서버가 재시작 됩니다.  </p>
																<div id="sdate" name="sdate">
																	<div class="clearfix">
					                   									<div class="pull-left">
					                   										<input type="text" class="form-control dpin width-130 applyDate pull-left" name="applyDate"  id="applyDate"/>
						                   								</div>
						                   								<div class="ml30 dpin">
					                   										<div class="selectBox_time">
						                   										<label class="selectBoxDrop">1</label>
																				<select class="search-sel" name="applyTime" id="applyTime"  >
																					<option value="0">0</option>
																					<option value="1">1</option>
																					<option value="2">2</option>
																					<option value="3">3</option>
																					<option value="4">4</option>
																					<option value="5">5</option>
																					<option value="6">6</option>
																					<option value="7">7</option>
																					<option value="8">8</option>
																					<option value="9">9</option>
																					<option value="10">10</option>
																					<option value="11">11</option>
																					<option value="12">12</option>
																					<option value="13">13</option>
																					<option value="14">14</option>
																					<option value="15">15</option>
																					<option value="16">16</option>
																					<option value="17">17</option>
																					<option value="18">18</option>
																					<option value="19">19</option>
																					<option value="20">20</option>
																					<option value="21">21</option>
																					<option value="22">22</option>
																					<option value="23">23</option>
																				</select>
																				<span class="txt">시</span>
																			</div>
						                   								</div>
																	</div>
																</div>
				                   							</td>
				                   						</tr>
														<tr >
			                   								<th scope="row" id='after_div_cpu1'>CPU</th>
			                   								<td id='after_div_cpu2'>
				                   								<div class="pull-left">
				                   									<input class="form-control" type="text"  placeholder="1" value="0" maxlength="2" name="cpuCnt" id="cpuCnt"/> <p class="inputUnit pull-none"> Core</p>
				                   								</div>
				                   								<div>
																	<img src="/resources/assets/img/icon_minus.png"  onclick="actCnt('cpuCnt', false);" class="minus ml30"/>
																	<span class="snemo">1</span>
																	<img src="/resources/assets/img/icon_plus.png" onclick="actCnt('cpuCnt', true);" class="plus"/>
																</div>
				                   							</td>
				                   						</tr>
														<tr>
			                   								<th scope="row" id='after_div_mem1'>MEMORY</th>
				                   							<td id='after_div_mem2'>
				                   								<div class="pull-left">
				                   									<input class="form-control" type="text"  placeholder="1" value="0" maxlength="3" name="memCnt" id="memCnt"/> <p class="inputUnit pull-none"> GB</p>
				                   								</div>
				                   								<div>
																	<img src="/resources/assets/img/icon_minus.png"  onclick="actCnt('memCnt', false);" class="minus ml30"/>
																	<span class="snemo">1</span>
																	<img src="/resources/assets/img/icon_plus.png" onclick="actCnt('memCnt', true);" class="plus"/>
																</div>
				                   							</td>
				                   						</tr>
				                   						<tr>
				                   							<th scope="row" id='after_div_disk1' style='display:none;'>DISK</th>
				                   							<td id='after_div_disk2' style='display:none;'>
				                   								<div class="pull-left">
				                   									<input class="form-control" type="text"  placeholder="1" value="0" maxlength="4" name="diskCnt" id="diskCnt"/> <p class="inputUnit pull-none"> GB</p>
				                   								</div>
				                   								<div>
																	<img src="/resources/assets/img/icon_minus.png"  onclick="actCnt('diskCnt', false);" class="minus ml30"/>
																	<span class="snemo">10</span>
																	<img src="/resources/assets/img/icon_plus.png" onclick="actCnt('diskCnt', true);" class="plus"/>
																</div>
				                   							</td>
				                   						</tr>
				                   						<!-- 201911 11  새로 추가된 화면  -->
				                   						<tr id='after_div_vm1' style='display:none;'>
				                   							<th>서버분류</th>
				                   							<td>
															<div class="searchBoxArea w50">
																<label class="selectBoxDrop" for="osSvrSpecGroup">자원을 선택하세요</label>
																<select class="search-sel" name="osSvrSpecGroup" id="osSvrSpecGroup">
																	<!-- <option value="s" selected="selected">소형서버</option>
																	<option value="m">중형서버</option>
																	<option value="l">대형서버</option>
																	<option value="b">빅데이터</option>
															        <option value="d">딥러닝</option>-->
																</select>
															</div>
				                   							</td>
				                   						</tr>
				                   						<tr id='after_div_vm2' style='display:none;'>
				                   							<th >서버사양 </th>
				                   							<td>
																<div class="searchBoxArea w80">
																	<label class="selectBoxDrop" for="flavorId" id="flavorId2">서버사양 선택</label>
																	<select class="search-sel" name="flavorId" id="flavorId" onchange="selectServerSpecGroup();">
																	</select>
																</div>
				                   							</td>
				                   						</tr>

				                   						<tr id='after_app_vm1' style='display:none;'>
				                   							<th >POD 수 </th>
				                   							<td>
															<div class="pull-left">
				                   									<input class="form-control" type="text"    name="podCnt" id="podCnt"/> <p class="inputUnit pull-none"> EA</p>
				                   								</div>
				                   								<div>
																	<img src="/resources/assets/img/icon_minus.png"  onclick="pod_actCnt('podCnt', false);" class="minus ml30"/>
																	<span class="snemo" id="plusMaCnt">1</span>
																	<img src="/resources/assets/img/icon_plus.png" onclick="pod_actCnt('podCnt', true);" class="plus"/>
																</div>
				                   							</td>
				                   						</tr>

				                   					</tbody>
				                   				</table>
				                   			</div>
				                   			<dl class="dpno">
				                   				<dt>금액<span class="fc66 f16">(VAT 별도)</span></dt>
				                   				<dd><strong class="nanumR" id='after_amount'>0</strong>&nbsp;원</dd>
				                   			</dl>
				                   		</div>
				                   		<!-- 변경신청 끝 -->
		                  			</div>
		                  			<!-- 현재 이용중인 정보 & 변경신청 끝 -->


		              			</div>

				              	<!-- 버튼박스 시작 -->
				              	<div class="btn_area">
									<a href="#" class="bbton bton_blue" onclick="openApproveReviewModal();"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-pencil"></i></span><span class="dpin ml16">변경신청</span></a>
									<a href="#" class="bbton bton_green ml10" onclick="actChangeBasket()"><span class="dpin dd bton_dgreen ml-1"><i class="fa fa-shopping-cart"></i></span><span class="dpin ml16">일괄신청</span></a>
						   		</div>
						   		<!-- 버튼박스 끝 -->
							</div>
			                <!-- 변경 신청 탭 끝 -->

			                <!-- 삭제신청 탭 시작 -->
			                <div id="nav-pills-tab-2" class="tab-pane active">
			                	<div class="formWrapper mt20">

			                		<!-- 프로젝트 & 자원 선택 -->
				                	<div class="formHeader">
										<table>
											<colgroup>
												<col width="10%">
				                				<col width="*">
				                			</colgroup>
				                			<tbody>
				                				<tr>
				                					<th class="vat">프로젝트</th>
				                					<td>
				                						<div class="searchBoxArea dpin" style="width:39%;">
																<label class="selectBoxDrop" for="selectProjectName1">프로젝트를 선택하세요</label>
																<select class="search-sel" name="selectProjectName1" id="selectProjectName1" onchange="changeProjectName('project');">
																</select>
														</div>
														<div class="productSearch flr">
															<input class="form-control w95" type="text" name="" id="" onclick="" readonly="readonly">
															<input class="form-control" type="hidden" name="" id="" >
															<img src="${apachePath}/resources/assets/img/btn_search2.png" height=32px;  onclick="" class="pa-t4r50"/>
														</div>

														<p class="fcsb f14 mt10"><i class="fa fa-exclamation-circle"></i> 자신이 관리자로 등록된 프로젝트만 선택이 가능합니다.</p>
				                					</td>
				                				</tr>
				                				<tr>
				                					<th class="vat">자원</th>
				                					<td class="vat">
				                						<div class="searchBoxArea" style="width:39%">

																<label class="selectBoxDrop" for="productSeq1">자원을 선택하세요</label>
																<select class="search-sel" name="productSeq1" id="productSeq1" onchange="openModal('selectBox', true);">
																	<option value="자원을 선택하세요" selected="selected">자원을 선택하세요</option>
																	<option value="vm">가상서버</option>
																	<option value="disk">블록디스크</option>
																	<option value="app">어플리케이션</option>

																	<!--
																	<option value="lb">서비스네트워크</option>
																	<option value="nas">NAS</option>
																	<option value="ip">공인IP</option>
																	-->
																	<option value="service">서비스</option>
																</select>
														</div>

														<div class="productSearch">
															<input class="form-control w95" type="text" name="productName1" id="productName1" onclick="openModal('button');" readonly="readonly">
															<input class="form-control" type="hidden" name="productId1" id="productId1" >
															<!-- <img src="/resources/assets/img/icon_search.png" onclick="openModal('button');" class="input_search"> -->
														    <img src="${apachePath}/resources/assets/img/btn_search2.png" height=32px;  onclick="openModal('button');" class="pa-t4r50"/>
														</div>
														<p class="fcsb f14 pt10"><i class="fa fa-exclamation-circle"></i> 자원을 선택하시면 보유중인 자원목록을 조회할 수 있습니다.</p>
				                					</td>
				                				</tr>
				                			</tbody>
				                		</table>
				                	</div>

									<!-- 현재 이용중인 정보 & 삭제신청 시작 -->
									<div class="formContents">

				                   		<!-- 현재 이용중인 정보  시작 -->
				                   		<div class="col-md-12 pl0">
				                   			<div class="col-md-6 pl0 titArea">현재 이용중인 정보 </div>
				                   		    <div class="col-md-6 pl30 titArea">삭제 신청 </div>
				                   		</div>
				                   		<div class="formBoxWrap formBoxType1">

			                   				<p class="info_txt reset_info_text"><span class="f18 fc_violet">프로젝트 </span>를 <span class="f18 fc_violet">선택</span>하신 후  <span class="f18 fc_green">자원</span>을  <span class="f18 fc_green">선택</span>하시면<br/>현재 이용중인 정보가 표기됩니다.</p>
			                   				<div class="tableWrap">
			                   					<table class="tableA resetTableDrow">
			                   						<colgroup>
			                   							<col width="20%">
				                   						<col width="*">
				                   					</colgroup>
				                   					<tbody id="before_table1">

			                	   					</tbody>
			                   					</table>
			                   				</div>
			                   				<dl class="dpno">
			                   					<dt>금액<span class="fc66 f16">(VAT 별도)</span></dt>
			                   					<dd><strong class="nanumR" id='before_amount1'>0</strong>&nbsp;원</dd>
			                   				</dl>
			                   			</div>
										<!-- 현재 이용중인 정보 끝 -->

										<!-- 삭제신청 시작 -->
			                   			<div class="formBoxWrap formBoxType2">

			                   				<div class="tableWrap">
				                   				<table class="tableG reset_hope_table">
			                	   					<colgroup>
			                   							<col width="15%">
		    	               							<col width="*">
		        	           						</colgroup>
		            	       						<tbody>
														<tr>
	                   										<th scope="row" class="vat">희망일시</th>
		                   									<td>
				                   								<div class="radioArea">
																	<input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag1" value="Y" checked /> 승인 완료 후 삭제&nbsp; &nbsp; <input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag1" value="N" /> 희망일시 삭제
																</div>
																<p class="fcsb f14 mt5 clearfix mb20"><span id="selectGubun1"></span> 클라우드 관리자의 최종 승인 후 <span id="changeMsg1" style="display: none;">  선택한 시간에  </span><span id='textProdect_1'></span>삭제됩니다.</p>
																<div id="sdate2" name="sdate2" style="display:none;">
																	<div class="clearfix">
					                   									<div class="pull-left">
				    	               										<input type="text" class="form-control dpin width-150 applyDate pull-left" name="applyDate1" id="applyDate1"/>
				        	           									</div>
																	<div class="dpin">
				                	   									<div class="selectBox_time">
					                	   									<label class="selectBoxDrop">1</label>
																			<select class="search-sel" name="applyTime1" id="applyTime1"  >
																				<option value="1">1</option>
																				<option value="2">2</option>
																				<option value="3">3</option>
																				<option value="4">4</option>
																				<option value="5">5</option>
																				<option value="6">6</option>
																				<option value="7">7</option>
																				<option value="8">8</option>
																				<option value="9">9</option>
																				<option value="10">10</option>
																				<option value="11">11</option>
																				<option value="12">12</option>
																				<option value="13">13</option>
																				<option value="14">14</option>
																				<option value="15">15</option>
																				<option value="16">16</option>
																				<option value="17">17</option>
																				<option value="18">18</option>
																				<option value="19">19</option>
																				<option value="20">20</option>
																				<option value="21">21</option>
																				<option value="22">22</option>
																				<option value="23">23</option>
																				<option value="24">24</option>
																			</select>
																			<span class="txt">시</span>
																		</div>
					                   								</div>
																</div>
															</div>
			                   							</td>
		    	               						</tr>
		        	           					</tbody>
		            	       					</table>
		                	   				</div>
			                   			</div>
			                   			<!-- 삭제신청 끝 -->
				                  	</div>
				                  	<!-- 현재 이용중인 정보 & 삭제신청 끝 -->
				              	</div>

				              	<!-- 버튼박스 시작 -->
					  			<div class="btn_area">
									<a href="#" class="btn_navy" onclick="openApproveReviewModal();">삭제신청</a>
									<a href="#" class="btn_dngrey ml10" onclick="actChangeBasketVm()">일괄신청</a>
					   			</div>
					   			<!-- 버튼박스 끝 -->

							</div>
	                 		<!-- 삭제신청 탭 끝 -->

	                	</div>
		             	<!-- 변경신청 & 삭제신청 부분 끝 -->
	             	</div>
				</div>
				<!-- end content > page-body -->

				<!-- begin content > modal -->
				<!-- 결재자 지정 시작 -->
				<!-- #modal-dialog 결재자 지정팝업-->
				<div class="modal fade" id="modal-approve-review-dialog">
					<div class="modal-dialog width-720">
						<div class="modal-content width-720">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                        <h4 class="modal-title">요청부서 검토자 승인자 지정</h4>
		                    </div>
		                    <div class="modal-body">
						 		<!-- search begin -->
						 		<!-- <div class="col-md-12 bgee modalpop mb20">
									<div class="" style="text-align: center; display:inline-block;">
										<div class="col-md-8">
											<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="searchKeyword" data-original-title="" title="">
										</div>
								  		<button type="button" class="btn_search2" onclick="searchCustomer();"><span></span></button>
									</div>
								</div> -->
						 		<!-- search end -->
							<div>
						   		<input type="hidden" value="" id="h_popCustomerId">
								<input type="hidden" value="" id="h_popCustomerName">
								<table class="tableV">
									 <colgroup>
											 <col width="25%">
											 <col width="25%">
											 <col width="25%">
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
		               	</div>
							<div class="clear"></div>
							<div class="modal-footer tac">
								<a type=button class="m_btn_navy" data-dismiss="modal" onclick="actChangeOrder();">확인</a>
								<a type=button class="m_btn_white ml10" data-dismiss="modal">취소</a>
		                 	</div>
						</div>
					</div>
				</div>

		      	<!-- 프로젝트 검토자 결재자 지정 팝업 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="user-modal-review-dialog">
	               <div class="modal-dialog width-720">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'><span></span></button>
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
											<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="reviewUserId" onkeypress="if(event.keyCode==13)gridPopList();" >
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
	                       		<a type="button" class="m_btn_navy" data-dismiss="modal" >닫기</a>
	                       	</div>
		               	</div>
					</div>
	           	</div>
				<!-- #modal-dialog -->

				<!-- 프로젝트 승인자 결재자 지정 팝업 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="user-modal-approve-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content w560">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'><span></span></button>
	                           <h4 class="modal-title">승인자 검색</h4>
	                       </div>
	                       <div class="modal-body">

	                       	<!--//검색 시작-->
	                       	 <div class="col-xs-12 bgee modalpop mb20">
		                       		<div class="selectBoxBr col-xs-3">
										<label class="selectText" for="approveSearchKind">전체</label>
										<select class="search-sel" id="approveSearchKind">
											<option value="searchAll">전체</option>
											<option value="userId">사번</option>
											<option value="userName">이름</option>
											<option value="deptName">부서</option>
										</select>
									</div>
										<div class="col-xs-9">
											<input type="text" class="search-text-s" placeholder="사번이나 이름 부서를 입력하세요" id="approveUserId" onkeypress="if(event.keyCode==13)gridPopApproveList();" >
											<button type="button" class="btn_search2 vm" onclick="gridPopApproveList();"><span></span></button>
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
								 <tbody id="popListApproveTable">
								 </tbody>
						 	    </table>

								<div class="noneList" id='popListApproveTable2'>
									 <span>검색된 사용자가 없습니다.</span>
								</div>
	                      		<div class="totalcnt" id="totalApproveCnt">총 0 건</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="m_btn_navy" data-dismiss="modal" >닫기</a>
	                       	</div>
		               	</div>
					</div>
	           	</div>
				<!-- #modal-dialog -->
				<!-- 결재자 지정 끝 -->

				<!-- #modal-dialog 가상서버검색-->
				<div class="modal fade pdManage" id="modal-dialog_vm">
					<div class="modal-dialog width-720">
						<div class="modal-content width-720">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
								<h4 class="modal-title" id='popDivTitle'>가상서버 검색</h4>
							</div>
							<div class="modal-body">
								<!-- search begin -->
						 		<!-- <div class="col-md-12 bgee modalpop mb20">

										<div class="selectBoxAr col-xs-2">
											<label class="selectText" for="vm_searchKind" id='vm_searchKindLabel'>서버명</label>
											<select class="search-sel" id="vm_searchKind" name="vm_searchKind">
											</select>
										</div>
										<div class="col-xs-8">
											<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="vm_keyword" data-original-title="" title="" onkeypress="if(event.keyCode==13)getGridList();">
											<button type="button" class="btn_search2 vm" onclick="getGridList();"><span></span></button>
										</div>

								</div> -->
								<!-- search end -->

										<!-- 2023 new search-->
									    <div class="col-xs-12 bgee modalpop mb20">
										 <div class="new-search-modal">
								           <div class="left">
									         <div class="choice-kepco">
											  <div class="select-kepco" for="vm_searchKind">
											    <button class="kep-label"  id='vm_searchKindLabel'>서버명</button>
											    <ul class="optionList">
											      <li class="optionItem" value="vm_searchKind">서버명</li>
											      <li class="optionItem" value="">호스트명</li>
											    </ul>
											  </div>
											</div>
											</div>

											<div class="right">
					                          <input type="text" class="input-kepco-s" placeholder="검색어를 입력하세요." id="vm_keyword" onkeypress="if(event.keyCode==13)getGridList();"/>
					                          <button type="button" class="kepco-ser-icon-modal2 vm" onclick="getGridList();"></button>
					                         </div>
				                          </div>
				                          </div>
								<!--  2023 new search END -->





						   		<div style="max-height: 320px">
									<table class="tableV" id="VM-list">
							 			<colgroup>
											<col width="30%">
											<col width="30%">
											<col width="10%">
										</colgroup>
										<thead id='popDivThead'>
							 			</thead>
										<tbody id="VM-listTable">
							 			</tbody>
							 		</table>
							 	</div>
							</div>
							<div class="clear"></div>
							<div class="modal-footer tac">
								<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="okProduct()">확인</a>
								<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
							</div>
						</div>
					</div>
				</div>
				<!-- #modal-dialog  가상서버 검색//-->

				<!-- #modal-dialog 변경신청-->
				<div class="modal fade pdManage" id="modal-dialog_order">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
								<h4 class="modal-title" id='popDetailTitle'>변경확인</h4>
							</div>
							<div class="modal-body">
								<div class="modalManagePop">
									<div id="popDetailDivProject"></div>
									<div class="detailBox">
										<div class="boxType01 f16" id='popDetailDiv1'></div>
										<div class="boxType02 w50 b3 dpin ml10" id='popDetailDiv2'></div>
										<div class="w3 dpin"><i class="fa fa-arrow-right f20 fc-grey" id = "popDetailDiv2i"></i></div>
										<div class="boxType02 w40 b2-orange dpin" id='popDetailVmChangDiv2'>
											<ul>
												<!-- <li class="tac fc11 mb5">변경 후 가상서버  </li> -->
												<li>요청유형 : </li>
												<li>과금단위 : </li>
												<li>희망일시 : </li>
												<li>CPU  : $("#cpuCnt").val()</li>
												<li>MEM  : $("#memCnt").val()</li>
											</ul>
										</div>
										<dl class="boxType03 dpno"  id='popDetailDiv3'>
											<dt>금액<span class="fc66 f16 fn">(VAT 별도)</span></dt>
											<dd><div id="popDetailAmt"></div></dd>
										</dl>
									</div>
									<p class="commnet" id='popDetailCommnet'>위 내용으로 변경신청 하시겠습니까?</p>
								</div>
							</div>
							<div class="clear"></div>
							<div class="modal-footer tac">
								<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="actChangeOrderInsert()">확인</a>
								<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
							</div>
						</div>
					</div>
				</div>
				<!-- #modal-dialog  변경신청//-->
				<!-- begin content > modal -->

				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->
			</div>
			<!-- end #page-container content -->
		</div>
		<!-- end page container -->

		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">
			// 결재라인 관련 변수
			var currentApprovalLine = "";
			var approvalList = [];
			var hprojectId;
			var hcloudId;
			var hcloudName;
			var hcloudType;
			//결재자 지정 시작
			function openApproveReviewModal() {
				var gbn = $("#h_requestTypeCode").val();

				if(gbn=="") {
					$("#popDetailTitle").text("변경확인");
					$("#popDetailCommnet").text("위 내용으로 변경신청 하시겠습니까?");
				} else {
					$("#popDetailTitle").text("삭제확인");
					$("#popDetailCommnet").text("삭제신청 하시겠습니까?");
				}
				if($("#productName"+gbn).val() == "") {
					alertBox3("자원을 선택하세요.");
					return false;
				}
				hid_data.onDemandFlag = $("input[name='onDemandFlag"+gbn+"']:checked").val();
				hid_data.applyDatetime = hid_data.onDemandFlag=="Y"?"승인완료 후":($("#applyDate"+gbn).val()+" "+$("#applyTime"+gbn).val()+":00");

				if($("#productSeq"+gbn).val() == "vm") {
					/*
					if(gbn == "" && $("#cpuCnt").val() == hid_data.vcpus && $("#memCnt").val() == hid_data.memGb){
						alertBox3("입력한 CPU, MEMORY수량이<br/>현재 이용중인 정보와 동일합니다.");
						return false;
					}
					*/
					if(gbn == "" && $("#flavorId option:selected").val() == hid_data.flavorId) {
						alertBox3("선택한 자원사양이<br/>현재 이용중인 정보와 동일합니다.");
						return false;
					}
					$("#popDetailDivProject").html('<strong class="title">'+$("#selectProjectName"+gbn).children('option:selected').text()+'</strong>');
					$("#popDetailDiv1").html('<ul>'
							+'<li><span class="title">서버명</span><span class="cnt">'+(hid_data.hostnameAlias)+'</span></li>'
							+'<li><span class="title">호스트명</span><span class="cnt">'+(hid_data.hostname)+'</span></li>'
							+'<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>'
						+'</ul>');
					$("#popDetailDiv1").show();
					var div2 = '<ul>';
					div2 += '<li><span class="title">과금단위</span><span class="cnt">'+(hid_data.hourlyFlag == "Y"?"시간":"월")+'</span></li>';
					div2 += '<li><span class="title">희망일시</span><span class="cnt">'+hid_data.applyDatetime+'</span></li>';
					if(gbn=="1"){
						$("#popDetailDiv3").hide();
						$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
					}else{
						$("#popDetailDiv3").show();
						div2 += '<li><span class="title">CPU</span><span class="cnt">'+$("#cpuCnt").val()+' Core</span></li>';
						div2 += '<li><span class="title">MEMORY</span><span class="cnt">'+$("#memCnt").val()+' GB</span></li>';
						$("#popDetailAmt").html('<strong>'+$("#after_amount").text()+'</strong><span>&nbsp;원</span>');
					}
					div2 += '</ul>';
					$("#popDetailDiv2").html(div2);
				}else if($("#productSeq"+gbn).val() == "disk"){
					if(gbn == "" && $("#diskCnt").val() == hid_data.sizeGb){
						alertBox3("입력한 DISK 크기가 현재 이용중인 <br>DISK 크기와 동일합니다.");
						return false;
					}
					if(gbn == "" && $("#diskCnt").val() * 1 < hid_data.sizeGb * 1){
						alertBox3("입력한 DISK 크기가 현재 이용중인 <br>DISK 크기보다 커야합니다.");
						return false;
					}

					$("#popDetailDivProject").html('<strong class="title">'+$("#selectProjectName"+gbn).children('option:selected').text()+'</strong>');
					$("#popDetailDiv1").html('<ul>'
							+'<li><span class="title">디스크명</span><span class="cnt">'+(hid_data.diskAlias)+'</span></li>'
							+'<li><span class="title">디스크ID</span><span class="cnt">'+(hid_data.diskId)+'</span></li>'
							+'<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>'

						+'</ul>');
					$("#popDetailDiv1").show();
					var div2 = '<ul>';
					div2 += '<li><span class="title">과금단위</span><span class="cnt">'+(hid_data.hourlyFlag == "Y"?"시간":"월")+'</span></li>';
					div2 += '<li><span class="title">희망일시</span><span class="cnt">'+hid_data.applyDatetime+'</span></li>';
					if(gbn=="1"){
						$("#popDetailDiv3").hide();
						$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
					}else{
						$("#popDetailDiv3").show();
						div2 += '<li><span class="title">DISK</span><span class="cnt">'+$("#diskCnt").val()+' EA</span></li>';
						$("#popDetailAmt").html('<strong>'+$("#after_amount").text()+'</strong><span>&nbsp;원</span>');
					}
					div2 += '</ul>';
					$("#popDetailDiv2").html(div2);

				}else if($("#productSeq"+gbn).val() == "service"){
					$("#popDetailDivProject").html('<strong class="title">'+$("#selectProjectName"+gbn).children('option:selected').text()+'</strong>');
					$("#popDetailDiv1").html('<ul>'
							+'<li><span class="title">서비스ID</span><span class="cnt">'+(hid_data.serviceName)+'</span></li>'
							+'<li><span class="title">서버명</span><span class="cnt">'+(hid_data.hostnameAlias)+'</span></li>'
							+'<li><span class="title">호스트명</span><span class="cnt">'+(hid_data.hostname)+'</span></li>'
							+'<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>'
						+'</ul>');
					$("#popDetailDiv1").show();
					var div2 = '<ul>';
					div2 += '<li><span class="title">과금단위</span><span class="cnt">'+(hid_data.hourlyFlag == "Y"?"시간":"월")+'</span></li>';
					div2 += '<li><span class="title">희망일시</span><span class="cnt">'+hid_data.applyDatetime+'</span></li>';
					div2 += '</ul>';
					$("#popDetailDiv3").hide();
					$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
					$("#popDetailDiv2").html(div2);
					$("#popDetailDiv1").hide();

				}else if($("#productSeq"+gbn).val() == "app" ){
					hid_data.podCnt = $("#podCnt").val();

// 				}else if($("#productSeq"+gbn).val() == "lb"){
// 				}else if($("#productSeq"+gbn).val() == "nas"){
// 					if(gbn == "" && $("#diskCnt").val() == hid_data.nasGb){
// 						alertBox3("입력한 DISK 크기가 현재 이용중인 <br>정보와 동일합니다.");
// 						return false;
// 					}
// 					$("#popDetailDivProject").html('<strong class="title">'+$("#selectProjectName"+gbn).children('option:selected').text()+'</strong>');
// 					$("#popDetailDiv1").html('<ul>'
// 							+'<li><span class="title">NAS명</span><span class="cnt">'+(hid_data.nasName)+'</span></li>'
// 							+'<li><span class="title">가상서버</span><span class="cnt">'+(hid_data.vmName)+'</span></li>'
// 						+'</ul>');
// 					$("#popDetailDiv1").show();
// 					var div2 = '<ul>';
// 					div2 += '<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>';
// 					div2 += '<li><span class="title">과금단위</span><span class="cnt">'+(hid_data.hourlyFlag == "Y"?"시간":"월")+'</span></li>';
// 					div2 += '<li><span class="title">희망일시</span><span class="cnt">'+hid_data.applyDatetime+'</span></li>';
// 					if(gbn=="1"){
// 						$("#popDetailDiv3").hide();
// 						$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
// 					}else{
// 						$("#popDetailDiv3").show();
// 						div2 += '<li><span class="title">DISK</span><span class="cnt">'+$("#diskCnt").val()+' EA</span></li>';
// 						$("#popDetailAmt").html('<strong>'+$("#after_amount").text()+'</strong><span>&nbsp;원</span>');
// 					}
// 					div2 += '</ul>';
// 					$("#popDetailDiv2").html(div2);
// 				}else if($("#productSeq"+gbn).val() == "ip"){
// 					$("#popDetailDivProject").html('<strong class="title">'+$("#selectProjectName"+gbn).children('option:selected').text()+'</strong>');
// 					$("#popDetailDiv1").html('<ul>'
// 							+'<li><span class="title">서버명</span><span class="cnt">'+(hid_data.hostnameAlias)+'</span></li>'
// 							+'<li><span class="title">호스트명</span><span class="cnt">'+(hid_data.hostname)+'</span></li>'
// 							+'<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>'
// 						+'</ul>');
// 					$("#popDetailDiv1").show();
// 					var div2 = '<ul>';
// 					div2 += '<li><span class="title">과금단위</span><span class="cnt">'+(hid_data.hourlyFlag == "Y"?"시간":"월")+'</span></li>';
// 					div2 += '<li><span class="title">희망일시</span><span class="cnt">'+hid_data.applyDatetime+'</span></li>';
// 					if(gbn=="1"){
// 						$("#popDetailDiv3").hide();
// 						$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
// 					}else{
// 						$("#popDetailDiv3").show();
// 						div2 += '<li><span class="title">DISK</span><span class="cnt">'+$("#diskCnt").val()+' EA</span></li>';
// 						$("#popDetailAmt").html('<strong>'+$("#after_amount").text()+'</strong><span>&nbsp;원</span>');
// 					}
// 					div2 += '</ul>';
// 					$("#popDetailDiv2").html(div2);
				}
				if($("#apprvPass").val() == "Y"){
					confirmBox4("결재자를 지정하시겠습니까?",approvSelect,nApprovSelect);
				} else {
					approvSelect();
				}
			}
			function nApprovSelect(){
				$("#selectApprv").val("Y");
				actChangeOrder();
			}
			function approvSelect(){
				$("#selectApprv").val("N");
				$("#modal-approve-review-dialog").modal();
			}


	function openApproveModal(){

		$("#user-modal-approve-dialog").modal();
		 gridPopApproveList();
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

	var totalCnt = 0;

	// 결재자 등록 팝업 리스트
	function gridPopList(){
		$.ajax({
			url : "${contextPath}/mbr/operation/approveUser/addProjectApproveList",
			dataType : "JSON",
			data : {
				"searchKind": $("#reviewSearchKind option:selected").val()
				, "keyword"	: $("#reviewUserId").val()
				, "cloudId" : $("#h_cloudSearchId").val()
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
									 +'<td class="tac">'+val.userLevel+'</td>'
									 +'<td class="tac">'+val.userName+'</td>'
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
	var totalCnt = 0;

	  // 검토자 등록 팝업 리스트
	function gridPopApproveList(){
		$.ajax({
			url : "${contextPath}/mbr/operation/approveUser/addProjectApprove2List",
			dataType : "JSON",
			data : {
				//"searchKind": $("#approveSearchKind option:selected").val()
				 "searchKind":document.querySelector("#reviewSearchKind .optionItem.active").getAttribute("value")
				, "keyword"	: $("#approveUserId").val()
			},
			success : function(req) {
				if(req.data.length == 0){
					$("#popListApproveTable").hide();
					$("#popListApproveTable2").show();
				}else{
					$("#popListApproveTable").empty();

					$.each(req.data, function(key,val){
						$("#popListApproveTable").append(
								'<tr>'
								+'<td class="tac">'+val.upDeptName+'/'+val.deptName+'</td>'
								+'<td class="tac">'+val.userId+'</td>'
								+'<td class="tac">'+val.userLevel+'</td>'
								+'<td class="tac">'+val.userName+'</td>'
								+'<td class="tac">'+val.userConditionText+'</td>'
								+'<td class="tac"><input type="button"  value="&#xf00c" class="popCheckbtn" onclick="updateApprove(this, \''+val.userId+'\', \''+val.userName+'\');" initModal();></td>'
								+'<tr/>'
							    );

					});
					$("#popListApproveTable").show();
					$("#popListApproveTable2").hide();
				}
				totalCnt = req.data.length;
				$("#totalApproveCnt").text("총 "+totalCnt+" 건");
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




	 // 검토자지정
	function updateReview(e, userId, userName, deptName, userLevel, userLevelCode){

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

	 // 승인자지정
	function updateApprove(e, userId, userName){

		//if($("#h_loginId").val() ==userId) {
		//			alertBox("신청자는 본인을<br>결재자로 지정할수 없습니다.");
		//			return false;
		//		}

		$("#popListApproveTable > tr").find("input").removeClass("active");
		$(e).toggleClass("active");
		$("#userIdApprove").text(userId);
		$("#userNameApprove").text(userName);
		$("#hiddenUserIdApprove").val(userId);
		$("#hiddenUserNameApprove").val(userName);
	}


	// 결재자 지정 끝

	var hid_data = {
			productId : ""
			, productName : ""
			, amount : 0
			, amount2 : 0
	};

	function calendar(){

		var dayName = ['일','월','화','수','목','금','토'];
		var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

		$(".applyDate").datepicker({
			showOn:"both",
			buttonImage:"/resources/assets/img/calen2.png",
			buttonImageOnly:true,
			dateFormat : "yy-mm-dd",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});
		$("img.ui-datepicker-trigger").attr("style", "position:relative; right:40px; top:6px;");
		$(".applyDate").val($.datepicker.formatDate('yy-mm-dd', new Date()));
	}


	//프로젝트 리스트
	function getProjectList(){

		var gbn = $("#h_requestTypeCode").val();

		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/projectPopList",
			dataType : "JSON",
			data : {
				"searchValue" : ""
			},
			success : function(data) {

				var projectList = data.getProjectList;
				changeProjectName('project');
				$("#before_table").html("");
				$("#selectProjectName"+gbn).empty();
				var Html="";
				Html +="<option value='' selected='selected'>프로젝트를 선택하세요</option>";
				if(projectList!=""){
					$.each(projectList,function(key,val){
						Html +="<option value='"+val["projectBoxId"]+"' projectName='"+val["projectName"]+"'>"+val["projectAlias"]+"</option>";
					});

				}
				$("#selectProjectName"+gbn).append(Html);
				$("#selectProjectName"+gbn).siblings(".selectBoxDrop").text($("#selectProjectName"+gbn).children('option:selected').text());
				if('${projectId}' != "" && '${gubun}' != 'lb'){
					$("#selectProjectName"+gbn+" > option[value='"+$("#h_projectId").val()+"']").attr("selected", "selected");
					$("#productSeq"+gbn+" > option[value='"+$("#h_gubun").val()+"']").attr("selected", "selected");
					$("#selectProjectName"+gbn).siblings(".selectBoxDrop").text($("#selectProjectName"+gbn).children('option:selected').text());
					$("#productSeq"+gbn).siblings(".selectBoxDrop").text($("#productSeq"+gbn).children('option:selected').text());

					var vUrl = "";
					var vSearchKind = "";
					if('${gubun}' == 'vm'){
						vUrl = "${wasPath}/mbr/oss/vm/catalogueVmlist";
						vSearchKind = "vm_uuid";
					}else if('${gubun}' == 'disk'){
						vUrl = "${wasPath}/mbr/oss/disk/catalogueList";
						vSearchKind = "disk_id";
					}else if('${gubun}' == 'service'){
						vUrl = "${wasPath}/mbr/oss/service/servicelist";
						vSearchKind = "service_id";
					}else if('${gubun}' == 'app'){
						vUrl = "";
						vSearchKind = "";
					}
// 					}else if('${gubun}' == 'lb'){
//						vUrl = "";
//						vSearchKind = "";
// 					}else if('${gubun}' == 'nas'){
// 						vUrl = "${wasPath}/mbr/oss/nas/nasList";
// 						vSearchKind = "nas_id";
// 					}else if('${gubun}' == 'ip'){
// 						vUrl = "${wasPath}/mbr/req/project/iplist";
// 						vSearchKind = "publicip_id";

					if(vUrl != ''){

						$.ajax({
							url : vUrl,
							dataType : "JSON",
							data : {
								searchKind : vSearchKind,
								keyword : '${productId}',
								projectId : $("#selectProjectName"+gbn).val(),
								projectName : $("#selectProjectName"+gbn+" > option:selected").attr("projectName")
							},
							success : function(req) {
								console.log("호호이이잇");
								var full = req.data[0];
								if(full != undefined){
									hid_data.hourlyFlag = full.hourlyFlag;

									if('${gubun}' == 'vm'){
										hid_data.hostnameAlias = full.hostnameAlias;
										hid_data.hostname = full.hostname;
										hid_data.regDatetime2 = full.regDatetime2;
										hid_data.flavorId = full.flavorId;
										hid_data.vcpus = full.vcpus;
										hid_data.memGb = full.memGb;
										hid_data.diskGb = full.diskGb;
										hid_data.defaultNetworkId = full.defaultNetworkId;
										hid_data.defaultNetworkId = full.defaultNetworkName;
										hid_data.defaultNetworkId = full.defaultNetworkAlias;
										hid_data.vmCatalogSeq = full.vmCatalogSeq;
										hid_data.vmProductSeq = full.vmProductSeq;
										hid_data.osProductSeq = full.osProductSeq;
										hid_data.vmUuid = full.vmUuid;
										hid_data.imageId = full.imageId;
									}else if('${gubun}' == "disk"){
										hid_data.regDatetime2 = full.regDatetime2;
										hid_data.sizeGb = full.sizeGb;
										hid_data.vmUuid = full.vmUuid;
										hid_data.diskId = full.diskId;
										hid_data.diskAlias = full.diskAlias;
										hid_data.diskCatalogSeq = full.diskCatalogSeq;
										hid_data.diskProductSeq = full.diskProductSeq;
									}else if('${gubun}' == "service"){
										hid_data.serviceId = full.serviceId;
										hid_data.serviceEa = full.serviceEa;
										hid_data.serviceCatalogSeq = full.serviceCatalogSeq;
										hid_data.serviceProductSeq = full.serviceProductSeq;
									}
// 									else if('${gubun}' == "nas"){
// 										hid_data.nasId = full.nasId;
// 										hid_data.nasName = full.nasName;
// 										hid_data.nasGb = full.nasGb;
// 										hid_data.nasCatalogSeq = full.nasCatalogSeq;
// 										hid_data.nasProductSeq = full.nasProductSeq;
// 										hid_data.vmName = full.vmName;
// 									}else if('${gubun}' == "ip"){
// 										hid_data.hostnameAlias = full.hostnameAlias;
// 										hid_data.hostname = full.hostname;
// 										hid_data.vmUuid = full.vmUuid;
// 										hid_data.publicipId = full.publicipId;
// 										hid_data.publicipEa = full.publicipEa;
// 										hid_data.publicipCatalogSeq = full.publicipCatalogSeq;
// 										hid_data.publicipProductSeq = full.publicipProductSeq;
// 									}

									if('${gubun}' != ""){
										okProduct();
									}
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



			function openModal(e, _openObj){
				var gbn = $("#h_requestTypeCode").val();
				if(e == "selectBox") {
					if( _openObj){
						$( ".resetTableDrow").hide();
						$( ".reset_hope_table").hide();
						$( ".reset_info_text").show();
					}

					changeProjectName('');
					$("#before_table"+gbn).html('<tr>'
						+'	<th scope="row">서버명</th>'
						+'	<td></td>'
						+'</tr>'
						+'<tr>'
						+'	<th scope="row">호스트명</th>'
						+'	<td></td>'
						+'</tr>'
						+'<tr>'
						+'	<th scope="row">생성일시</th>'
						+'	<td></td>'
						+'</tr>'
						+'<tr>'
						+'	<th scope="row">CPU</th>'
						+'	<td></td>'
						+'</tr>'
						+'<tr>'
						+'	<th scope="row">MEMORY</th>'
						+'	<td></td>'
						+'</tr>');

					$("#before_amount"+gbn).text("0");
					$("#cpuCnt"+gbn).val("0");
					$("#memCnt"+gbn).val("0");
					$("#diskCnt"+gbn).val("0");
					$("#after_amount"+gbn).text("0");
					$("#change_amount"+gbn).text("0");
					$("#total_amount"+gbn).text("0");
				}

				if($("#productSeq"+gbn).val() == "") {
					if(e == "selectBox"){
						$("#productSeq"+gbn).focus();
					}else{
						alertBox3("자원을 선택하세요");
					}
				} else {
					if($("#selectProjectName"+gbn).val() == "") {
						$("#selectProjectName"+gbn).focus();
						alertBox3("프로젝트를 선택하세요.");
						return false;
					} else {
						$("#textProdect"+gbn).text($("#productSeq"+gbn+" > option:selected").text());
						$("#textProdect_"+gbn).text($("#productSeq"+gbn+" > option:selected").text());
						$("#modal-dialog_vm").modal();

						setSearchSelect();
						$("#searchKeyword2").focus();
					}
				}
			}

			function setSearchSelect() {

				var gbn = $("#h_requestTypeCode").val();
				$("#vm_keyword").val("");

				if($("#productSeq"+gbn).val() == "vm"){
					$("#vm_searchKindLabel").text('서버명');
					$("#vm_searchKind").html('<option value="hostname_alias">서버명</option>'
							+'<option value="hostname">호스트명</option>');
					$("#h_productCategory").val("PRODCATE_VM");

				}else if($("#productSeq"+gbn).val() == "disk"){
					$("#vm_searchKindLabel").text('디스크명');
					$("#vm_searchKind").html('<option value="disk_alias">디스크명</option>'
							+'<option value="disk_id">디스크 ID</option>');
					$("#h_productCategory").val("PRODCATE_DISK");

				}else if($("#productSeq"+gbn).val() == "service"){
					$("#vm_searchKindLabel").text('서비스ID');
					$("#vm_searchKind").html('<option value="service_id">서비스ID</option>');
					$("#h_productCategory").val("PRODCATE_SERVICE");

				}else if($("#productSeq"+gbn).val() == "app"){
					$("#vm_searchKindLabel").text('어플리케이션 명');
					$("#vm_searchKind").html('<option value="applicationName">어플리케이션명</option>'
							+'<option value="applicationId">applicationId</option>');
					$("#h_productCategory").val("PRODCATE_APP");

				}
// 				else if($("#productSeq"+gbn).val() == "lb"){
// 					$("#vm_searchKindLabel").text('서비스네트워크명');
// 					$("#vm_searchKind").html('<option value="loadbalancer_name">서비스네트워크명</option>'
// 							+'<option value="loadbalancer_id">서비스네트워크ID</option>');
// 					$("#h_productCategory").val("PRODCATE_LOADBALANCER");

// 				}else if($("#productSeq"+gbn).val() == "nas"){
// 					$("#vm_searchKindLabel").text('NAS명');
// 					$("#vm_searchKind").html('<option value="nas_name">NAS명</option>'
// 							+'<option value="nas_id">NAS ID</option>');
// 					$("#h_productCategory").val("PRODCATE_NAS");

// 				}else if($("#productSeq"+gbn).val() == "ip"){
// 					$("#vm_searchKindLabel").text('서버명');
// 					$("#vm_searchKind").html('<option value="hostname_alias">서버명</option>'
// 							+'<option value="hostname">호스트명</option>');
// 					$("#h_productCategory").val("PRODCATE_PUBLICIP");
// 				}

				if($("#productSeq"+gbn).val() != "자원을 선택하세요"){
					getGridList();
				}
			}

			function getGridList(){
				var gbn = $("#h_requestTypeCode").val();
				if($("#productSeq"+gbn).val() == "vm"){
					gridVMList();
				}else if($("#productSeq"+gbn).val() == "disk"){
					gridDiskList();
				}else if($("#productSeq"+gbn).val() == "service"){
					gridServiceList();
				}else if($("#productSeq"+gbn).val() == "app"){
					gridAppList();
				}
// 				else if($("#productSeq"+gbn).val() == "lb"){
// 					gridLbList();
// 				}else if($("#productSeq"+gbn).val() == "nas"){
// 					gridNasList();
// 				}else if($("#productSeq"+gbn).val() == "ip"){
// 					gridIpList();
// 				}
			}

			function gridVMList(){
				var gbn = $("#h_requestTypeCode").val();
				$("#popDivTitle").html("가상서버 검색");
				$("#popDivThead").html('<tr class="skyblue">'
						 				+'<th class="tac">호스트명</th>'
						 				+'<th class="tac">서버명</th>'
						 				+'<th class="tac">선택</th>'
						 			+'</tr>');

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
							d.projectId = $("#selectProjectName"+gbn).val();
							d.projectName = $("#selectProjectName"+gbn+" > option:selected").attr("projectName");
						}
					}
					,"columns":[
						{"data":"hostname" , "class":"tal nanumR"}
						, {"data":"hostnameAlias" , "class":"tal nanumR"}
						, {"class":"tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[2], "render": function(data,type,full){
								return activeBtn(full);
							}
						}
					]
					,"order": [[0,"asc"]]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
					}
					,"sDom":'<"top">rt<"bottom"pi>'
				});
			}

			// 가상서버 검색에서 선택 버튼 클릭시
			function activeBtn(full){
				console.log( " full JSON");
				console.log(full);
				console.log( " full JSON NONE");

				var param = {
						a01 : ""	/* hostnameAlias */
						, a02 : ""	/* hostname */
						, a03 : ""	/* regDatetime2 */
						, a04 : 0	/* vcpus */
						, a05 : 0	/* memGb */
						, a06 : 0	/* diskGb */
						, a07 : ""	/* hourlyFlag */
						, a08 : ""	/* vmCatalogSeq */
						, a09 : ""	/* vmProductSeq */
						, a10 : ""	/* osProductSeq */
						, a11 : ""	/* vmUuid */

						, a12 : ""	/* diskId */
						, a13 : ""	/* diskAlias */
						, a26 : ""	/* sizeGb */
						, a14 : ""	/* diskCatalogSeq */
						, a15 : ""	/* diskProductSeq */

						, a16 : ""	/* nasId */
						, a17 : ""	/* nasName */
						, a18 : 0	/* nasGb */
						, a19 : ""	/* nasCatalogSeq */
						, a20 : ""	/* nasProductSeq */
						, a21 : ""	/* vmName */

						, a22 : ""	/* publicipId */
						, a23 : ""	/* publicipEa */
						, a24 : ""	/* publicipCatalogSeq */
						, a25 : ""	/* publicipProductSeq */

// 						, a27 : ""	/* backupId */
// 						, a28 : ""	/* backupGb */
// 						, a29 : ""	/* backupCatalogSeq */
// 						, a30 : ""	/* backupProductSeq */

// 						, a31 : ""  /* mcaId */
// 						, a32 : ""  /* mcaEa */
// 						, a33 : ""  /* mcaCatalogSeq */
// 						, a34 : ""  /* mcaProductSeq */

// 						, a35 : ""  /* scmId */
// 						, a36 : ""  /* scmEa */
// 						, a37 : ""  /* scmCatalogSeq */
// 						, a38 : ""  /* scmProductSeq */

// 						, a39 : ""  /* securityId */
// 						, a40 : ""  /* securityEa */
// 						, a41 : ""  /* securityCatalogSeq */
// 						, a42 : ""  /* securityProductSeq */

						, a43 : "" /* networkAlias */
						, a44 : "" /* networkName */
						, a45 : "" /* networkId */
			            , a46 : "" /* serviceId */
			            , a47 : "" /* serviceEa */
			            , a48 : "" /* serviceCatalogSeq */
			            , a49 : "" /* serviceProductSeq */
			            , a50 : "" /* serviceType */

			            , a51 : "" /* vm - flavorId */

			            , a52 : "" /* createDatetime */
				        , a53 : "" /* serviceName */
				        , a54 : "" /* diskType */
				        , a55 : "" /* diskTypeName */
				        , a56 : "" /* diskTypeCode */
				        , a57 : "" /* azName */
				        , a58 : "" /* vm - imageId */
				        , a59 : "" /* createDatetime2 */
						, a60 : "" /* projectId */
						, a61 : "" /* cloudId */
 						, a62 : "" /* cloudType */
						, a63 : "" /* cloudName */
						, a64 : "" /* appName */
						, a65 : "" /* appUid */
						, a66 : "" /* host */
						, a67 : "" /* servicePort */
						, a68 : "" /* replicas */
						, a69 : "" /* templateCatalogSeq */
						, a70 : "" /* templateProductSeq */
						, a71 : "" /* templateProductSeq */
				};

				var gbn = $("#h_requestTypeCode").val();

				param.a07 = full.hourlyFlag;

				if($("#productSeq"+gbn).val() == "vm"){
					param.a01 = full.hostnameAlias;
					param.a02 = full.hostname;
					param.a03 = full.regDatetime2;
					param.a04 = full.vcpus;
					param.a05 = full.memGb;
					param.a06 = full.diskGb;
					param.a08 = full.vmCatalogSeq;
					param.a09 = full.vmProductSeq;
					param.a10 = full.osProductSeq;
					param.a11 = full.vmUuid;
					param.a43 = full.networkAlias;
					param.a44 = full.networkName;
					param.a45 = full.networkId;
					param.a51 = full.flavorId;
					param.a52 = full.createDatetime;
					param.a57 = full.azName;
					param.a58 = full.imageId;
					param.a59 = full.createDatetime2;
					param.a60 = full.projectId;
					param.a61 = full.cloudId;
					param.a62 = full.cloudType;
					param.a63 = full.cloudName;

				}else if($("#productSeq"+gbn).val() == "disk"){
					param.a03 = full.regDatetime2;
					param.a26 = full.sizeGb;
					param.a11 = full.vmUuid;
					param.a12 = full.diskId;
					param.a13 = full.diskAlias;
					param.a14 = full.diskCatalogSeq;
					param.a15 = full.diskProductSeq;
					param.a01 = full.hostnameAlias;
					param.a54 = full.diskType;
					param.a55 = full.diskTypeName;
					param.a56 = full.diskTypeCode;
					param.a59 = full.createDatetime2;
					param.a60 = full.projectId;
					param.a61 = full.cloudId;

				}else if($("#productSeq"+gbn).val() == "nas"){
					param.a16 = full.nasId;
					param.a17 = full.nasName;
					param.a18 = full.nasGb;
					param.a19 = full.nasCatalogSeq;
					param.a20 = full.nasProductSeq;
					param.a21 = full.vmName;

				}else if($("#productSeq"+gbn).val() == "ip"){
					param.a01 = full.hostnameAlias;
					param.a02 = full.hostname;
					param.a11 = full.vmUuid;
					param.a22 = full.publicipId;
					param.a23 = full.publicipEa;
					param.a24 = full.publicipCatalogSeq;
					param.a25 = full.publicipProductSeq;

				}else if($("#productSeq"+gbn).val() == "service"){
					param.a01 = full.hostnameAlias;
					param.a46 = full.serviceId;
					param.a47 = full.serviceEa;
					param.a48 = full.serviceCatalogSeq;
					param.a49 = full.serviceProductSeq;
					param.a50 = full.serviceType;
					param.a52 = full.createDatetime;
					param.a11 = full.vmUuid;
					param.a53 = full.serviceName;

				}else if($("#productSeq"+gbn).val() == "app"){
					param.a60 = full.additionalProperties.projectId;
					param.a61 = full.additionalProperties.cloudId;
					param.a63 = full.metadata.namespace;
					param.a64 = full.metadata.name;
					param.a65 = full.metadata.uid;
					param.a66 = full.additionalProperties.host;
					param.a67 = full.additionalProperties.servicePort;
					param.a68 = full.spec.replicas;
					param.a69 = full.additionalProperties.templateCatalogSeq;
					param.a70 = full.additionalProperties.templateProductSeq;
					param.a71 = full.additionalProperties.cloudName;
				}

				return '<div class="tac"><a href="#" data-toggle="tab"><input type="button"  value="&#xf00c" class="popCheckbtn" onclick="setVm(this'
						+',\''+param.a01+'\''+',\''+param.a02+'\''+',\''+param.a03+'\''+',\''+param.a04+'\''+',\''+param.a05+'\''
						+',\''+param.a06+'\''+',\''+param.a07+'\''+',\''+param.a08+'\''+',\''+param.a09+'\''+',\''+param.a10+'\''
						+',\''+param.a11+'\''+',\''+param.a12+'\''+',\''+param.a13+'\''+',\''+param.a14+'\''+',\''+param.a15+'\''
						+',\''+param.a16+'\''+',\''+param.a17+'\''+',\''+param.a18+'\''+',\''+param.a19+'\''+',\''+param.a20+'\''
						+',\''+param.a21+'\''+',\''+param.a22+'\''+',\''+param.a23+'\''+',\''+param.a24+'\''+',\''+param.a25+'\''
						+',\''+param.a26+'\''
						+',\''+param.a43+'\''+',\''+param.a44+'\''+',\''+param.a45+'\''
						+',\''+param.a46+'\''+',\''+param.a47+'\''+',\''+param.a48+'\''+',\''+param.a49+'\''+',\''+param.a50+'\''
						+',\''+param.a51+'\''+',\''+param.a52+'\''+',\''+param.a53+'\''+',\''+param.a54+'\''+',\''+param.a55+'\''
						+',\''+param.a56+'\''+',\''+param.a57+'\''+',\''+param.a58+'\''+',\''+param.a59+'\''+',\''+param.a60+'\''
						+',\''+param.a61+'\''+',\''+param.a62+'\''+',\''+param.a63+'\''+',\''+param.a64+'\''+',\''+param.a65+'\''+',\''+param.a66+'\''
						+',\''+param.a67+'\''+',\''+param.a68+'\''+',\''+param.a69+'\''+',\''+param.a70+'\''+',\''+param.a71+'\''
						+')"></a></div>';
			}

			function setVm(e, hostnameAlias, hostname, regDatetime2, vcpus, memGb
							, diskGb, hourlyFlag, vmCatalogSeq, vmProductSeq, osProductSeq
							, vmUuid, diskId, diskAlias, diskCatalogSeq, diskProductSeq
							, nasId, nasName, nasGb, nasCatalogSeq, nasProductSeq
							, vmName, publicipId, publicipEa, publicipCatalogSeq, publicipProductSeq
							, sizeGb
							, networkAlias, networkName, networkId
							, serviceId, serviceEa, serviceCatalogSeq, serviceProductSeq, serviceType
							, flavorId, createDatetime, serviceName, diskType, diskTypeName
							, diskTypeCode, azName, imageId, createDatetime2 ,projectId,cloudId
							, cloudType, cloudName, appName, appUid, host, servicePort
							, spacReplicas, templateCatalogSeq, templateProductSeq, cloudNameMain
							){
				$("#VM-listTable > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
				$("#checkVcpus").val(vcpus);
				$("#checkMemGb").val(memGb);
				$("#checkDiskGb").val(sizeGb);


				hprojectId = projectId;
				hcloudId = cloudId;
				hcloudName = cloudName;
				hcloudType = cloudType;
				hid_data.hostnameAlias 	= hostnameAlias;
				hid_data.hostname 		= hostname;
				hid_data.regDatetime2 	= regDatetime2;
				hid_data.imageId 		= imageId;
				hid_data.flavorId 		= flavorId;
				hid_data.vcpus 			= vcpus;
				hid_data.memGb 			= memGb;
				hid_data.diskGb 		= (diskGb<10) ? 10 : diskGb;
				hid_data.hourlyFlag 	= hourlyFlag;
				hid_data.vmCatalogSeq 	= vmCatalogSeq;
				hid_data.vmProductSeq 	= vmProductSeq;
				hid_data.osProductSeq 	= osProductSeq;
				hid_data.vmUuid 		= vmUuid;
				hid_data.diskId 		= diskId;
				hid_data.sizeGb 		= sizeGb;
				hid_data.diskAlias 		= diskAlias;
				hid_data.diskCatalogSeq = diskCatalogSeq;
				hid_data.diskProductSeq = diskProductSeq;
				hid_data.nasId 			= nasId;
				hid_data.nasName 		= nasName;
				hid_data.nasGb 			= nasGb;
				hid_data.nasCatalogSeq 	= nasCatalogSeq;
				hid_data.nasProductSeq 	= nasProductSeq;
				hid_data.vmName 		= vmName;
				hid_data.publicipId 	= publicipId;
				hid_data.publicipEa 	= publicipEa;
				hid_data.publicipCatalogSeq = publicipCatalogSeq;
				hid_data.publicipProductSeq = publicipProductSeq;

			    // 서비스 통합 추가
			    hid_data.serviceId 		= serviceId;
				hid_data.serviceEa 		= serviceEa;
				hid_data.serviceCatalogSeq = serviceCatalogSeq;
				hid_data.serviceProductSeq = serviceProductSeq;
				hid_data.serviceType 	= serviceType;
				hid_data.createDatetime = createDatetime;
				hid_data.createDatetime2= createDatetime2;
				hid_data.serviceName 	= serviceName;

				hid_data.defaultNetworkAlias = networkAlias;
				hid_data.defaultNetworkName = networkName;
				hid_data.defaultNetworkId = networkId;

				hid_data.diskType 		= diskType;
				hid_data.diskTypeName 	= diskTypeName;
				hid_data.diskTypeCode 	= diskTypeCode;
				hid_data.azName 		= azName;
				hid_data.cloudName 		= cloudName;
				hid_data.cloudType 		= cloudType;
				hid_data.appName 		= appName;
				hid_data.appUid 		= appUid;
				hid_data.host 			= host;
				hid_data.servicePort 	= servicePort;
				hid_data.spacReplicas 	= spacReplicas;
				hid_data.templateCatalogSeq = templateCatalogSeq;
				hid_data.templateProductSeq = templateProductSeq;
				hid_data.cloudNameMain = cloudNameMain;
			}

			function okProduct() {

				$( ".info_txt").hide();
				$( ".resetTableDrow").show();
				$( ".reset_hope_table").show();

				var gbn = $("#h_requestTypeCode").val();

				$("#after_div_cpu1"+gbn).hide();
				$("#after_div_cpu2"+gbn).hide();
				$("#after_div_mem1"+gbn).hide();
				$("#after_div_mem2"+gbn).hide();
				$("#after_div_disk1"+gbn).hide();
				$("#after_div_disk2"+gbn).hide();


				$("#projectId").val(hprojectId);
				$("#cloudId").val(hcloudId);
				$("#cloudType").val(hcloudType);
				$("#cloudName").val(hcloudName);


				if($("#productSeq"+gbn).val() == "vm"){
					$("#productName"+gbn).val(hid_data.hostnameAlias);
					$("#productId"+gbn).val(hid_data.vmUuid);
					getFlavorTypeList();
					getFlavorList();
					$("#before_table"+gbn).html('<tr>'
												+'<th scope="row">서버명</th>'
											//	+'<td>'+hid_data.hostnameAlias+'</td>'
											    +'<td><input type="text" class="input_white" value="'+ hid_data.hostnameAlias +'"/></td>'
											+'</tr>'
											+'<tr>'
												+'<th scope="row">호스트명</th>'
											//	+'<td>'+hid_data.hostname+'</td>'
											    +'<td><input type="text" class="input_white" value="'+ hid_data.hostname +'"/></td>'
											+'</tr>'
											/*+'<tr>'
												+'<th scope="row">과금단위</th>'
												+'<td>'+(hid_data.hourlyFlag == "Y"?"시간":"월")+'</td>'
											+'</tr>'*/
											+'<tr>'
												+'<th scope="row">CPU</th>'
											//	+'<td>'+hid_data.vcpus+'Core</td>'
												+'<td><input type="text" class="input_white" value="'+ hid_data.vcpus +' Core"/></td>'
											+'</tr>'
											+'<tr>'
												+'<th scope="row">MEMORY</th>'
											//	+'<td>'+hid_data.memGb+'GB</td>'
											    +'<td><input type="text" class="input_white" value="'+ hid_data.memGb +' GB"/></td>'
											+'</tr>');
					if(hid_data.hourlyFlag == "N"){
						hid_data.amount = Number($("#h_price_vm_cpu_monthly_price").val())*Number(hid_data.vcpus);
						hid_data.amount += Number($("#h_price_vm_mem_monthly_price").val()) * Number(hid_data.memGb);
						hid_data.amount += Number($("#h_price_vm_disk_monthly_price").val()) * Number(hid_data.diskGb);
					}else{
						hid_data.amount = Number($("#h_price_vm_cpu_hourly").val()) * Number(hid_data.vcpus);
						hid_data.amount += Number($("h_price_vm_mem_hourly").val()) * Number(hid_data.memGb);
						hid_data.amount += Number($("#h_price_vm_disk_hourly").val()) * Number(hid_data.diskGb);
					}
					$("#flavorId").val(hid_data.flavorId).prop("selected", true).trigger('change');
					/*
					$("#flavorId").change(function() {
						var select_name = $(this).childrend('option:selected').text();
						$(this).siblings('label').text(select_name)
					})
					*/
					$("#cpuCnt"+gbn).val(hid_data.vcpus);
					$("#memCnt"+gbn).val(hid_data.memGb);
					$("#diskCnt"+gbn).val(hid_data.diskGb);



					if($("#cloudType").val()  != "nutanix"){
						$("#after_div_vm1"+gbn).show();
						$("#after_div_vm2"+gbn).show();
					}else{
						$("#after_div_cpu1"+gbn).show();
						$("#after_div_cpu2"+gbn).show();
						$("#after_div_mem1"+gbn).show();
						$("#after_div_mem2"+gbn).show();
					}

					$("#flavorId2").text("서버사양을 선택하여주세요.");
					$("#h_vm_uuid").val(hid_data.vmUuid);
					$("#h_network_alias").val(hid_data.defaultNetworkAlias);
					$("#h_network_id").val(hid_data.defaultNetworkId);
					$("#h_network_name").val(hid_data.defaultNetworkName);
					$("#h_create_datetime2").val(hid_data.createDatetime2);
				}else if($("#productSeq"+gbn).val() == "disk"){

					$("#productName"+gbn).val(hid_data.diskAlias);
					$("#productId"+gbn).val(hid_data.diskId);
					$("#before_table"+gbn).html('<tr>'
													+'<th scope="row">디스크명</th>'
													//+'<td>'+hid_data.diskAlias+'</td>'
													+'<td><input type="text" class="input_white" value="'+ hid_data.diskAlias +'"/></td>'
												+'</tr>'
												/* +'<tr>'
													+'<th scope="row">디스크ID</th>'
													+'<td>'+hid_data.diskId+'</td>'
												+'</tr>'
												+'<tr>'
													+'<th scope="row">과금단위</th>'
													+'<td>'+(hid_data.hourlyFlag == "Y"?"시간":"월")+'</td>'
												+'</tr>'*/
												+'<tr>'
													+'<th scope="row">DISK</th>'
												  //+'<td>'+hid_data.sizeGb+'GB</td>'
													+'<td><input type="text" class="input_white" value="'+ hid_data.sizeGb +' GB"/></td>'
												+'</tr>');
					if(hid_data.hourlyFlag == "N"){
						hid_data.amount = (Number($("#h_price_vm_disk_monthly_price").val()) * hid_data.sizeGb);
					}else{
						hid_data.amount = (Number($("#h_price_vm_disk_hourly").val()) * hid_data.sizeGb);
					}
					$("#diskCnt"+gbn).val(hid_data.sizeGb);
					$("#after_div_vm1"+gbn).hide();
					$("#after_div_vm2"+gbn).hide();
					$("#after_div_disk1"+gbn).show();
					$("#after_div_disk2"+gbn).show();

					$("#h_vm_uuid").val(hid_data.vmUuid);
					$("#h_disk_type").val(hid_data.diskType);
					$("#h_disk_type_name").val(hid_data.diskTypeName);
					$("#h_disk_type_code").val(hid_data.diskTypeCode);
					$("#h_disk_alias").val(hid_data.diskAlias);
					$("#h_create_datetime").val(hid_data.createDatetime);
					$("#h_create_datetime2").val(hid_data.createDatetime2);
				}else if($("#productSeq"+gbn).val() == "nas"){
					$("#productName"+gbn).val(hid_data.nasName);
					$("#productId"+gbn).val(hid_data.nasId);
					$("#before_table"+gbn).html('<tr>'
													+'<th scope="row">NAS명</th>'
													+'<td>'+hid_data.nasName+'</td>'
												+'</tr>'
												+'<tr>'
													+'<th scope="row">가상서버</th>'
													+'<td>'+hid_data.vmName+'</td>'
												+'</tr>'
												/*+'<tr>'
													+'<th scope="row">과금단위</th>'
													+'<td>'+(hid_data.hourlyFlag == "Y"?"시간":"월")+'</td>'
												+'</tr>'*/
												+'<tr>'
													+'<th scope="row">DISK</th>'
													+'<td>'+hid_data.nasGb+'GB</td>'
												+'</tr>');
					if(hid_data.hourlyFlag == "N"){
						hid_data.amount = (Number($("#h_price_vm_disk_monthly_price").val()) * hid_data.nasGb);
					}else{
						hid_data.amount = (Number($("#h_price_vm_disk_hourly").val()) * hid_data.nasGb);
					}
					$("#diskCnt"+gbn).val(hid_data.nasGb);
					$("#after_div_disk1"+gbn).show();
					$("#after_div_disk2"+gbn).show();
				}else if($("#productSeq"+gbn).val() == "ip"){
					$("#productName"+gbn).val(hid_data.hostnameAlias);
					$("#productId"+gbn).val(hid_data.publicipId);
					$("#before_table"+gbn).html('<tr>'
													+'<th scope="row">서버명</th>'
													+'<td>'+hid_data.hostnameAlias+'</td>'
												+'</tr>'
												+'<tr>'
													+'<th scope="row">호스트명</th>'
													+'<td>'+hid_data.hostname+'</td>'
												+'</tr>'
												/*+'<tr>'
													+'<th scope="row">과금단위</th>'
													+'<td>'+(hid_data.hourlyFlag == "Y"?"시간":"월")+'</td>'
												+'</tr>'*/
												+'<tr>'
													+'<th scope="row">IP수량</th>'
													+'<td>'+hid_data.publicipEa+'</td>'
												+'</tr>');
				}else if($("#productSeq"+gbn).val() == "service"){
					$("#productName"+gbn).val(hid_data.serviceId);
					$("#productId"+gbn).val(hid_data.serviceId);
					$("#before_table"+gbn).html('<tr>'
													+'<th scope="row">서비스ID</th>'
													+'<td>'+hid_data.serviceName+'</td>'
												+'</tr>'
												+'<tr>'
													+'<th scope="row">호스트명</th>'
													+'<td>'+hid_data.hostnameAlias+'</td>'
												+'</tr>'
												+'<tr>'
													+'<th scope="row">생성일시</th>'
													+'<td>'+hid_data.createDatetime+'</td>'
												+'</tr>'
												/*+'<tr>'
													+'<th scope="row">과금단위</th>'
													+'<td>'+(hid_data.hourlyFlag == "Y"?"시간":"월")+'</td>'
												+'</tr>'*/);
					$("#h_vm_uuid").val(hid_data.vmUuid);
					$("#h_create_datetime").val(hid_data.createDatetime);
					$("#h_hourly_flag").val(hid_data.hourlyFlag);
					$("#h_service_name").val(hid_data.serviceName);
					$("#h_service_type").val(hid_data.serviceType);
				}else if( $("#productSeq"+gbn).val() == "app"){


					$("#after_div_vm1"+gbn).hide();
					$("#after_div_vm2"+gbn).hide();
					$("#after_div_disk1"+gbn).hide();
					$("#after_div_disk2"+gbn).hide();

					$( "#podCnt").val( hid_data.spacReplicas);

					$( "#after_app_vm1").show();
					$( "#after_app_vm2").show();


					$("#productName"+gbn).val(hid_data.appName);
					$("#productId"+gbn).val(hid_data.appUid);
					$("#before_table"+gbn).html('<tr>'
							+'<th scope="row">어플리케이션 이름</th>'
							+'<td>'+hid_data.appName+'</td>'
						+'</tr>'
						+'<tr>'
							+'<th scope="row">서비스</th>'
							+'<td>'+hid_data.servicePort+'</td>'
						+'</tr>'
						+'<tr>'
							+'<th scope="row">Pod 수</th>'
							+'<td>'+hid_data.spacReplicas+'</td>'
						+'</tr>'
						+'<tr>'
							+'<th scope="row">Route</th>'
							+'<td>'+hid_data.host+'</td>'
						+'</tr>'
					);
				}

				$("#before_amount"+gbn).text(addcomma(hid_data.amount));
				$("#after_amount"+gbn).text(addcomma(hid_data.amount));
				$("#change_amount"+gbn).text("0");
				$("#total_amount"+gbn).text(addcomma(hid_data.amount*1.1));
			}

			function actChangeOrder(){
				if( (approvalList[3] == undefined || approvalList[3] == null || approvalList[3] == '')
						&& $("#selectApprv").val() == 'N' ) {
					alertBox3("결재자를 지정해 주세요");
					return false;
				}
				var gbn = $("#h_requestTypeCode").val();

				if(gbn==""){
					$("#popDetailTitle").text("변경확인");
					$("#popDetailCommnet").text("위 내용으로 변경신청 하시겠습니까?");
				}else{
					$("#popDetailTitle").text("삭제확인");
					$("#popDetailCommnet").text("삭제신청 하시겠습니까?");
				}

				if($("#productName"+gbn).val() == ""){
					alertBox3("자원을 선택하세요.");
					return false;
				}
				hid_data.onDemandFlag = $("input[name='onDemandFlag"+gbn+"']:checked").val();
				hid_data.applyDatetime = hid_data.onDemandFlag=="Y"?"승인완료 후":($("#applyDate"+gbn).val()+" "+$("#applyTime"+gbn).val()+":00");

				if($("#productSeq"+gbn).val() == "vm"){
					/*
					if(gbn == "" && $("#cpuCnt").val() == hid_data.vcpus && $("#memCnt").val() == hid_data.memGb){
						alertBox3("입력한 CPU, MEMORY수량이<br/>현재 이용중인 정보와 동일합니다.");
						return false;
					}
					*/
					if(gbn == "" && $("#flavorId option:selected").val() == hid_data.flavorId) {
						alertBox3("선택한 자원사양이<br/>현재 이용중인 정보와 동일합니다.");
						return false;
					}
					$("#popDetailDivProject").html('<strong class="title">'+$("#selectProjectName"+gbn).children('option:selected').text()+'</strong>');
					$("#popDetailDiv1").html('<ul>'
							+'<li><span class="title">서버명</span><span class="cnt">'+(hid_data.hostnameAlias)+'</span></li>'
							+'<li><span class="title">호스트명</span><span class="cnt">'+(hid_data.hostname)+'</span></li>'
						/* 	+'<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>'  */

						+'</ul>');
					$("#popDetailDiv1").show();

					var div2 = '<ul>';
					div2 += '<li><span class="title">생성일시</span><span class="cnt">'+hid_data.createDatetime2+'</span></li>';
					if(gbn=="1"){
						$("#popDetailDiv3").hide();
						$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
					}else{
						$("#popDetailDiv3").show();
						div2 += '<li><span class="title">CPU</span><span class="cnt">'+hid_data.vcpus+' Core</span></li>';
						div2 += '<li><span class="title">MEMORY</span><span class="cnt">'+hid_data.memGb+' GB</span></li>';
						$("#popDetailAmt").html('<strong>'+$("#after_amount").text()+'</strong><span>&nbsp;원</span>');
					}
					div2 += '</ul>';
					$("#popDetailDiv2").html(div2);

					var div3 = '<ul>';
					div3 += '<li><span class="title">희망일시</span><span class="cnt">'+hid_data.applyDatetime+'</span></li>';
					if(gbn=="1"){
						$("#popDetailDiv3").hide();
						$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
					}else{
						$("#popDetailDiv3").show();
						div3 += '<li><span class="title">CPU</span><span class="cnt">'+$("#cpuCnt").val()+' Core</span></li>';
						div3 += '<li><span class="title">MEMORY</span><span class="cnt">'+$("#memCnt").val()+' GB</span></li>';
						$("#popDetailAmt").html('<strong>'+$("#after_amount").text()+'</strong><span>&nbsp;원</span>');
					}
					div3 += '</ul>';
					$("#popDetailVmChangDiv2").html(div3);
				}else if($("#productSeq"+gbn).val() == "disk"){
					if(gbn == "" && $("#diskCnt").val() == hid_data.sizeGb){
						alertBox3("입력한 DISK 크기가 현재 이용중인 <br>DISK 크기와 동일합니다.");
						return false;
					}
					if(gbn == "" && $("#diskCnt").val() < hid_data.sizeGb){
						alertBox3("입력한 DISK 크기가 현재 이용중인 <br>DISK 크기보다 커야합니다.");
						return false;
					}

					$("#popDetailDivProject").html('<strong class="title">'+$("#selectProjectName"+gbn).children('option:selected').text()+'</strong>');
					$("#popDetailDiv1").html('<ul>'
							+'<li><span class="title">디스크명</span><span class="cnt">'+(hid_data.diskAlias)+'</span></li>'
							+'<li><span class="title">디스크ID</span><span class="cnt">'+(hid_data.diskId)+'</span></li>'
					/* 		+'<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>'  */


						+'</ul>');
					$("#popDetailDiv1").show();
					var div2 = '<ul>';
					div2 += '<li><span class="title">생성일시</span><span class="cnt">'+hid_data.createDatetime2+'</span></li>';
					if(gbn=="1"){
						$("#popDetailDiv3").hide();
						$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
					}else{
						$("#popDetailDiv3").show();
						div2 += '<li><span class="title">DISK</span><span class="cnt">'+ hid_data.sizeGb+' Gb</span></li>';
						$("#popDetailAmt").html('<strong>'+$("#after_amount").text()+'</strong><span>&nbsp;원</span>');
					}
					div2 += '</ul>';
					$("#popDetailDiv2").html(div2);

					var div3 = '<ul>';
					div3 += '<li><span class="title">희망일시</span><span class="cnt">'+hid_data.applyDatetime+'</span></li>';
					if(gbn=="1"){
						$("#popDetailDiv3").hide();
						$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
					}else{
						$("#popDetailDiv3").show();
						div3 += '<li><span class="title">DISK</span><span class="cnt">'+$("#diskCnt").val()+' Gb</span></li>';
						$("#popDetailAmt").html('<strong>'+$("#after_amount").text()+'</strong><span>&nbsp;원</span>');
					}
					div3 += '</ul>';
					$("#popDetailVmChangDiv2").html(div3);
				}
				else if($("#productSeq"+gbn).val() == "service"){
					$("#popDetailDivProject").html('<strong class="title">'+$("#selectProjectName"+gbn).children('option:selected').text()+'</strong>');
					$("#popDetailDiv1").html('<ul>'
							+'<li><span class="title">서비스명</span><span class="cnt">'+(hid_data.serviceName)+'</span></li>'
							+'<li><span class="title">서버명</span><span class="cnt">'+(hid_data.hostnameAlias)+'</span></li>'
						+'</ul>');
					$("#popDetailDiv1").show();
					var div2 = '<ul>';
					div2 += '<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>';
					div2 += '<li><span class="title">생성일시</span><span class="cnt">'+hid_data.createDatetime+'</span></li>';
					div2 += '</ul>';
					$("#popDetailDiv3").hide();
					$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
					$("#popDetailDiv2").html(div2);

					var div3 = '<ul>';
					div3 += '<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>';
					div3 += '<li><span class="title">희망일시</span><span class="cnt">'+hid_data.applyDatetime+'</span></li>';
					div3 += '</ul>';
					$("#popDetailVmChangDiv2").html(div3);

				}else if($("#productSeq"+gbn).val() == "app"){
					$("#popDetailDiv1").html('<ul>'
							+'<li><span class="title" style=width:100px;>클라우드 명</span><span class="cnt">'+(hid_data.cloudNameMain)+'</span></li>'
							+'<li><span class="title" style=width:130px;>어플리케이션 명</span><span class="cnt">'+(hid_data.appName)+'</span></li>'
							+'<li><span class="title" style=width:100px;>서비스 포트</span><span class="cnt">'+(hid_data.servicePort)+'</span></li>'
						+'</ul>');
					$("#popDetailDiv2").html(" <ul><li>변경 전  : "+hid_data.spacReplicas+"</li></ul>");

					$("#popDetailVmChangDiv2").html(" <ul><li>변경 후  : "+$("#podCnt").val()+"</li></ul>");
				}
// 				else if($("#productSeq"+gbn).val() == "lb"){
// 				}else if($("#productSeq"+gbn).val() == "nas"){
// 					if(gbn == "" && $("#diskCnt").val() == hid_data.nasGb){
// 						alertBox3("입력한 DISK 크기가 현재 이용중인 <br>정보와 동일합니다.");
// 						return false;
// 					}
// 					$("#popDetailDivProject").html('<strong class="title">'+$("#selectProjectName"+gbn).children('option:selected').text()+'</strong>');
// 					$("#popDetailDiv1").html('<ul>'
// 							+'<li><span class="title">NAS명</span><span class="cnt">'+(hid_data.nasName)+'</span></li>'
// 							+'<li><span class="title">가상서버</span><span class="cnt">'+(hid_data.vmName)+'</span></li>'
// 						+'</ul>');
// 					$("#popDetailDiv1").show();
// 					var div2 = '<ul>';
// 					div2 += '<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>';
// 					div2 += '<li><span class="title">희망일시</span><span class="cnt">'+hid_data.applyDatetime+'</span></li>';
// 					if(gbn=="1"){
// 						$("#popDetailDiv3").hide();
// 						$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
// 					}else{
// 						$("#popDetailDiv3").show();
// 						div2 += '<li><span class="title">DISK</span><span class="cnt">'+$("#diskCnt").val()+' EA</span></li>';
// 						$("#popDetailAmt").html('<strong>'+$("#after_amount").text()+'</strong><span>&nbsp;원</span>');
// 					}
// 					div2 += '</ul>';
// 					$("#popDetailDiv2").html(div2);
// 				}else if($("#productSeq"+gbn).val() == "ip"){
// 					$("#popDetailDivProject").html('<strong class="title">'+$("#selectProjectName"+gbn).children('option:selected').text()+'</strong>');
// 					$("#popDetailDiv1").html('<ul>'
// 							+'<li><span class="title">서버명</span><span class="cnt">'+(hid_data.hostnameAlias)+'</span></li>'
// 							+'<li><span class="title">호스트명</span><span class="cnt">'+(hid_data.hostname)+'</span></li>'
// 						+'</ul>');
// 					$("#popDetailDiv1").show();
// 					var div2 = '<ul>';
// 					div2 += '<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>';
// 					div2 += '<li><span class="title">희망일시</span><span class="cnt">'+hid_data.applyDatetime+'</span></li>';
// 					if(gbn=="1"){
// 						$("#popDetailDiv3").hide();
// 						$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
// 					}else{
// 						$("#popDetailDiv3").show();
// 						div2 += '<li><span class="title">DISK</span><span class="cnt">'+$("#diskCnt").val()+' EA</span></li>';
// 						$("#popDetailAmt").html('<strong>'+$("#after_amount").text()+'</strong><span>&nbsp;원</span>');
// 					}
// 					div2 += '</ul>';
// 					$("#popDetailDiv2").html(div2);
// 				}


				$("#modal-dialog_order").modal();
			}

			function gridDiskList(){
				var gbn = $("#h_requestTypeCode").val();
				$("#popDivTitle").html("블록디스크 검색");
				$("#popDivThead").html('<tr class="skyblue">'
						 				+'<th class="tal">디스크명</th>'
						 				+'<th class="tal">호스트명</th>'
						 				+'<th class="tac">선택</th>'
						 			+'</tr>');
				$("#VM-list").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${wasPath}/mbr/oss/disk/catalogueList"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#vm_searchKind option:selected").val();
							d.keyword = $("#vm_keyword").val();
							d.projectId = $("#selectProjectName"+gbn).val();
							d.projectName = $("#selectProjectName"+gbn+" > option:selected").attr("projectName");
							d.length = "0";
						}
					}
					,"columns":[
						{"data":"diskAlias" , "class":"tal nanumR"}
						, {"data":"hostnameAlias" , "class":"tal nanumR"}
						, {"class":"tac"}
						]
						,"columnDefs":[
							{"defaultContent" : "", targets:"_all" }
							, {"targets":[2], "render": function(data,type,full){
									return activeBtn(full);
								}
							}
						]
					,"order": [[0,"asc"]]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
					}
					,"sDom":'<"top">rt<"bottom"pi>'
				});
			}

			function gridServiceList(){
				var gbn = $("#h_requestTypeCode").val();
				$("#popDivTitle").html("서비스 검색");
				$("#popDivThead").html('<tr class="skyblue">'
						 				+'<th class="tac">서비스ID</th>'
						 				+'<th class="tac">생성일시</th>'
						 				+'<th class="tac">선택</th>'
						 			+'</tr>');

				$("#VM-list").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${wasPath}/mbr/req/changeOrder/serviceList"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#vm_searchKind option:selected").val();
							d.keyword = $("#vm_keyword").val();
							d.projectId = $("#selectProjectName"+gbn).val();
							d.projectName = $("#selectProjectName"+gbn+" > option:selected").attr("projectName");
							d.length = "0";
						}
					}
					,"columns":[
						{"data":"serviceId" , "class":"tac nanumR"}
						, {"data":"createDatetime" , "class":"tac nanumR"}
						, {"class":"tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						, {"targets":[2], "render": function(data,type,full){
								return activeBtn(full);
							}
						}
					]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
					}
					,"sDom":'<"top">rt<"bottom">'
				});
			}

			function gridAppList(){

				var gbn = $("#h_requestTypeCode").val();
				$("#popDivTitle").html("어플리케이션 검색");
				$("#popDivThead").html('<tr class="skyblue">'
						 				+'<th class="tal">클라우드명</th>'
						 				+'<th class="tal">어플리케이션명</th>'
						 				+'<th class="tac">선택</th>'
						 			+'</tr>');
				$("#VM-list").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${wasPath}/mbr/oss/app/catalogueList"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#vm_searchKind option:selected").val();
							d.keyword = $("#vm_keyword").val();
							d.projectId = $("#selectProjectName"+gbn).val();
							d.projectName = $("#selectProjectName"+gbn+" > option:selected").attr("projectName");
							d.length = "0";
						}
					}
					,"columns":[
						{"data":"metadata.namespace" , "class":"tal cloudName"}
						, {"data":"metadata.name" , "class":"tal appName"}
						, {"class":"tac"}
						]
						,"columnDefs":[
							  {"defaultContent" : "", targets:"_all" }
							, {"targets":[2], "render": function(data,type,full){
								//param.a63 = full.metadata.namespace;
								//param.a64 = full.metadata.labels.app;
								//param.a65 = full.metadata.uid;
								return activeBtn(full);
							}


							}
						]
					,"order": [[0,"asc"]]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
					}
					,"sDom":'<"top">rt<"bottom"pi>'
				});
			}

// 			function gridNasList(){
// 				var gbn = $("#h_requestTypeCode").val();
// 				$("#popDivTitle").html("NAS 검색");
// 				$("#popDivThead").html('<tr class="skyblue">'
// 						 				+'<th class="tac">NAS명</th>'
// 						 				+'<th class="tac">NAS ID</th>'
// 						 				+'<th class="tac">선택</th>'
// 						 			+'</tr>');

// 				$("#VM-list").dataTable( {
// 					"processing": true
// 					,"autoWidth": false
// 					,"serverSide": true
// 					,"ordering": false
// 					,"destroy" : true
// 					,"ajax": {
// 						"url":"${wasPath}/mbr/oss/nas/nasList"
// 						,"type" : "GET"
// 						,"data":function (d) {
// 							d.searchKind = $("#vm_searchKind option:selected").val();
// 							d.keyword = $("#vm_keyword").val();
// 							d.projectId = $("#selectProjectName"+gbn).val();
// 							d.projectName = $("#selectProjectName"+gbn+" > option:selected").attr("projectName");
// 							d.length = "0";
// 						}
// 					}
// 					,"columns":[
// 						{"data":"nasName" , "class":"tac nanumR"}
// 			// 			, {"data":"vmName" , "class":"tac"}
// 						, {"data":"nasId" , "class":"tac nanumR"}
// 						, {"class":"tac"}
// 					]
// 					,"columnDefs":[
// 						{"defaultContent" : "", targets:"_all" }
// 						, {"targets":[2], "render": function(data,type,full){
// 								return activeBtn(full);
// 							}
// 						}
// 					]
// 					,"order": [[0,"asc"]]
// 					,"language": {
// 						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
// 					}
// 					,"sDom":'<"top">rt<"bottom"pi>'
// 				});
// 			}

// 			function gridIpList(){
// 				var gbn = $("#h_requestTypeCode").val();
// 				$("#popDivTitle").html("공인IP 검색");
// 				$("#popDivThead").html('<tr class="skyblue">'
// 						 				+'<th class="tac">호스트명</th>'
// 						 				+'<th class="tac">서버명</th>'
// 						 				+'<th class="tac">선택</th>'
// 						 			+'</tr>');

// 				$("#VM-list").dataTable( {
// 					"processing": true
// 					,"autoWidth": false
// 					,"serverSide": true
// 					,"ordering": false
// 					,"destroy" : true
// 					,"ajax": {
// 						"url":"${wasPath}/mbr/req/project/iplist"
// 						,"type" : "GET"
// 						,"data":function (d) {
// 							d.searchKind = $("#vm_searchKind option:selected").val();
// 							d.keyword = $("#vm_keyword").val();
// 							d.projectId = $("#selectProjectName"+gbn).val();
// 							d.projectName = $("#selectProjectName"+gbn+" > option:selected").attr("projectName");
// 							d.length = "0";
// 						}
// 					}
// 					,"columns":[
// 						{"data":"hostname" , "class":"tac nanumR"}
// 						, {"data":"hostnameAlias" , "class":"tac nanumR"}
// 						, {"class":"tac"}
// 					]
// 					,"columnDefs":[
// 						{"defaultContent" : "", targets:"_all" }
// 						, {"targets":[2], "render": function(data,type,full){
// 								return activeBtn(full);
// 							}
// 						}
// 					]
// 					,"language": {
// 						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
// 					}
// 					,"sDom":'<"top">rt<"bottom">'
// 				});
// 			}



			function changeProjectName(e){
				var gbn = $("#h_requestTypeCode").val();
				$("#productId"+gbn).val("");
				$("#productName"+gbn).val("");
				$("#checkProjectId").val($("#selectProjectName").val());
				if(e == "project"){
					$("#productSeq"+gbn).val("자원을 선택하세요");
					$("#productSeq"+gbn).siblings(".selectBoxDrop").text($("#productSeq"+gbn).children('option:selected').text());
				}
			}

			function pod_actCnt(id, b){
				var bon_temp = Number( $( "#podCnt").val());
				var plusMaTemp = Number( Number( $( "#plusMaCnt").text()));

				if( bon_temp <= 0 && b == false){
					$( "#podCnt").val( 0);
					return;
				}

				if( b){
					$( "#podCnt").val( bon_temp + plusMaTemp);
				}

				if( b == false){
					$( "#podCnt").val( bon_temp - plusMaTemp);

				}
				//hid_data.amount2
			}

			function actCnt(id, b){
				console.log(id,b);
				var num = Number(1);
				if(id=='diskCnt'){
					num = Number(10);
				}

				if(isNaN($("#"+id).val())){
					afterReset(id);
					return false;
				}else if($("#"+id).val() < num){

					afterReset(id);
					return false;
				}else if($("#"+id).val() == num && !b){
					afterReset(id);
					return false;
				}else{
					$("#"+id).val(Number($("#"+id).val())+Number(b?+num:-num));
					getAtertAmount();
				}
			}


			function getAtertAmount(){
				var gbn = $("#h_requestTypeCode").val();

				$("#cpuCnt"+gbn).val(Number($("#cpuCnt").val()));
				$("#memCnt"+gbn).val(Number($("#memCnt").val()));
				var diskCnt = Number($("#diskCnt").val())%10 == 0?Number($("#diskCnt").val()):Number($("#diskCnt").val())-Number($("#diskCnt").val())%10;
				$("#diskCnt"+gbn).val(diskCnt);

				if(hid_data.hourlyFlag == "N"){
					if($("#productSeq"+gbn).val() == "vm"){
						hid_data.amount2 = (Number($("#h_price_vm_cpu_monthly_price").val()) * Number($("#cpuCnt"+gbn).val()))
						+ (Number($("#h_price_vm_mem_monthly_price").val()) * Number($("#memCnt"+gbn).val()))
						+ (Number($("#h_price_vm_disk_monthly_price").val()) * Number($("#diskCnt"+gbn).val()));
					}else if($("#productSeq"+gbn).val() == "disk" || $("#productSeq"+gbn).val() == "nas"){
						hid_data.amount2 = (Number($("#h_price_vm_disk_monthly_price").val()) * Number($("#diskCnt"+gbn).val()));
					}
				}else{
					if($("#productSeq"+gbn).val() == "vm"){
						hid_data.amount2 = (Number($("#h_price_vm_cpu_hourly").val()) * Number($("#cpuCnt"+gbn).val()))
						+ (Number($("h_price_vm_mem_hourly").val()) * Number($("#memCnt"+gbn).val()))
						+ (Number($("#h_price_vm_disk_hourly").val()) * Number($("#diskCnt"+gbn).val()));
					}else if($("#productSeq"+gbn).val() == "disk" || $("#productSeq"+gbn).val() == "nas"){
						hid_data.amount2 = (Number($("#h_price_vm_disk_hourly").val()) * Number($("#diskCnt"+gbn).val()));
					}
				}

				$("#after_amount"+gbn).text(addcomma(hid_data.amount2));
				$("#change_amount"+gbn).text(addcomma(hid_data.amount2-hid_data.amount));
				$("#total_amount"+gbn).text(addcomma(hid_data.amount2*1.1));
				//checkAvail();
			}

			function afterReset(id){
				var gbn = $("#h_requestTypeCode").val();

				if(id=="cpuCnt"){
					$("#cpuCnt"+gbn).val(hid_data.vcpus);
				}else if(id=="memCnt"){
					$("#memCnt"+gbn).val(hid_data.memGb);
				}else if(id=="diskCnt"){
					$("#diskCnt"+gbn).val(hid_data.diskGb<10?10:hid_data.diskGb);
				}else if(id="podCnt"){
					$("#podCnt"+gbn).val(hid_data.spacReplicas);
				}


				getAtertAmount();
			}

			function setRequestType(act){
				$( ".resetTableDrow").hide();
				$( ".reset_hope_table").hide();
				$( ".reset_info_text").show();

				$("#h_requestType").val(act);
				$("#h_requestTypeCode").val(act=="REQTYPE_CHANGE"?"":"1");
				$("#after_div_vm1").hide();
				$("#after_div_vm2").hide();
				$("#after_div_disk1").hide();
				$("#after_div_disk2").hide();
				$("#after_app_vm1").hide();
				$("#after_app_vm2").hide();


				getProjectList();


				if(act == "REQTYPE_CHANGE"){
					$("#productSeq").val("자원을 선택하세요");
					$("#productSeq").siblings(".selectBoxDrop").text($("#productSeq").children('option:selected').text());
					$("#productName").val("");
					$("#productId").val("");
					$("#before_table").html('<tr>'
							+'<th scope="row">서버명</th>'
							+'<td></td>'
						+'</tr>'
						+'<tr>'
							+'<th scope="row">호스트명</th>'
							+'<td></td>'
						+'</tr>'
						+'<tr>'
							+'<th scope="row">생성일시</th>'
							+'<td></td>'
						+'</tr>'
						+'<tr>'
							+'<th scope="row">CPU</th>'
							+'<td></td>'
						+'</tr>'
						+'<tr>'
							+'<th scope="row">MEMORY</th>'
							+'<td></td>'
						+'</tr>');
					$("#before_amount").text("0");
					$("#cpuCnt").val("0");
					$("#memCnt").val("0");
					$("#diskCnt").val("0");
					$("#after_amount").text("0");
					$("#change_amount").text("0");
					$("#total_amount").text("0");
				}else if(act == "REQTYPE_EXPR"){
					$("#productSeq1").val("자원을 선택하세요");
					$("#productSeq1").siblings(".selectBoxDrop").text($("#productSeq1").children('option:selected').text());
					$("#productName1").val("");
					$("#productId1").val("");
					$("#before_table1").html('<tr>'
							+'<th scope="row">서버명</th>'
							+'<td></td>'
						+'</tr>'
						+'<tr>'
							+'<th scope="row">호스트명</th>'
							+'<td></td>'
						+'</tr>'
						+'<tr>'
							+'<th scope="row">생성일시</th>'
							+'<td></td>'
						+'</tr>'
						+'<tr>'
							+'<th scope="row">CPU</th>'
							+'<td></td>'
						+'</tr>'
						+'<tr>'
							+'<th scope="row">MEMORY</th>'
							+'<td></td>'
						+'</tr>');
					$("#before_amount1").text("0");
					$("#cpuCnt1").val("0");
					$("#memCnt1").val("0");
					$("#diskCnt").val("0");
					$("#after_amount1").text("0");
					$("#change_amount1").text("0");
					$("#total_amount1").text("0");
				}
			}

			function actChangeBasket(){
				var gbn = $("#h_requestTypeCode").val();

				if($("#productName").val() == ""){
					alertBox3("자원을 선택하세요.");
					return false;
				}
				hid_data.onDemandFlag = $("input[name='onDemandFlag1']:checked").val();
				hid_data.applyDatetime = hid_data.onDemandFlag=="Y"?"승인완료 후":($("#applyDate").val()+" "+$("#applyTime").val()+":00");

				if($("#productSeq").val() == "vm"){
					if(gbn == "" && $("#flavorId option:selected").val() == hid_data.flavorId) {
						alertBox3("선택한 자원사양이<br/>현재 이용중인 정보와 동일합니다.");
						return false;
					}
					$("#popDetailDivProject").html('<strong class="title">'+$("#selectProjectName"+gbn).children('option:selected').text()+'</strong>');
					$("#popDetailDiv1").html('<ul>'
							+'<li><span class="title">서버명</span><span class="cnt">'+(hid_data.hostnameAlias)+'</span></li>'
							+'<li><span class="title">호스트명</span><span class="cnt">'+(hid_data.hostname)+'</span></li>'
							+'<li><span class="title">요청유형</span><span class="cnt">'+(gbn==""?"변경":"삭제")+'</span></li>'
						+'</ul>');
					$("#popDetailDiv1").show();
					var div2 = '<ul>';
					div2 += '<li><span class="title">과금단위</span><span class="cnt">'+(hid_data.hourlyFlag == "Y"?"시간":"월")+'</span></li>';
					div2 += '<li><span class="title">희망일시</span><span class="cnt">'+hid_data.applyDatetime+'</span></li>';
					if(gbn=="1"){
						$("#popDetailDiv3").hide();
						$("#popDetailAmt").html('<strong>0</strong><span>&nbsp;원</span>');
					}else{
						$("#popDetailDiv3").show();
						div2 += '<li><span class="title">CPU</span><span class="cnt">'+$("#cpuCnt").val()+' Core</span></li>';
						div2 += '<li><span class="title">MEMORY</span><span class="cnt">'+$("#memCnt").val()+' GB</span></li>';
						$("#popDetailAmt").html('<strong>'+$("#after_amount").text()+'</strong><span>&nbsp;원</span>');
					}

				}else if($("#productSeq").val() == "disk"){
					if(gbn == "" && $("#diskCnt").val() == hid_data.sizeGb){
						alertBox3("입력한 DISK 크기가 현재 이용중인 <br>DISK 크기와 동일합니다.");
						return false;
					}
					if(gbn == "" && $("#diskCnt").val() * 1 < hid_data.sizeGb * 1){
						alertBox3("입력한 DISK 크기가 현재 이용중인 <br>DISK 크기보다 커야합니다.");
						return false;
					}
				}else if($("#productSeq").val() == "lb"){
				}else if($("#productSeq").val() == "nas"){
				}else if($("#productSeq").val() == "ip"){
				}else if($("#productSeq").val() == "service"){
				}

				actChangeBasketVm();
			}

			// 바로구매 & 일괄신청전 paramater Data 정리
			function sethidData(){
				var gbn = $("#h_requestTypeCode").val();

				hid_data.userId				= $("#h_loginId").val();
				hid_data.orderUserId 		= $("#h_loginId").val();
				hid_data.apprvState 		= "APPRV_PROCESSING" ;
				hid_data.requestType 		= $("#h_requestType").val();
				hid_data.productCategory 	= $("#h_productCategory").val();
				hid_data.amount 			= hid_data.amount2;
				hid_data.projectBoxId 		= (gbn == "") ? $("#selectProjectName").val() : $("#selectProjectName1").val();

				hid_data.projectId 			= $("#projectId").val();
				hid_data.projectName 		= $("#selectProjectName"+gbn+" > option:selected").attr("projectName");
				hid_data.onDemandFlag 		= $("input[name='onDemandFlag"+gbn+"']:checked").val();
				hid_data.applyDatetime 		= hid_data.onDemandFlag=="Y"?null:($("#applyDate"+gbn).val()+" "+$("#applyTime"+gbn).val()+":00");

				hid_data.beforeFlavorId 	= hid_data.flavorId;
				hid_data.beforeVcpus 		= hid_data.vcpus;
				hid_data.beforeMemGb 		= hid_data.memGb;
				hid_data.beforeDiskGb 		= ($("#productSeq"+gbn).val() == "disk") ? hid_data.sizeGb : hid_data.diskGb;
				hid_data.beforeNasGb 		= hid_data.nasGb;

				hid_data.flavorId 			= (gbn=="") ? $("#flavorId option:selected").val() : hid_data.flavorId;
				hid_data.vcpus 				= (gbn=="") ? $("#cpuCnt").val() : hid_data.vcpus;
				hid_data.memGb 				= (gbn=="") ? $("#memCnt").val() : hid_data.memGb;
				hid_data.diskGb 			= (gbn=="") ? $("#diskCnt").val() : hid_data.diskGb;

				hid_data.nasGb 				= (gbn==""?$("#diskCnt").val():hid_data.nasGb);
				hid_data.description 		=  "";
				hid_data.regUserId 			= $("#h_loginId").val();
				hid_data.modUserId 			= $("#h_loginId").val();
				hid_data.hiddenUserIdReview = $("#hiddenUserIdReview").val();
				hid_data.hiddenUserIdApprove= $("#hiddenUserIdApprove").val();
				hid_data.vmUuid 			= $("#h_vm_uuid").val();
				hid_data.serviceName 		= $("#h_service_name").val();
				hid_data.serviceType 		= $("#h_service_type").val();
				hid_data.diskType 			= $("#h_disk_type").val();
				hid_data.diskTypeName 		= $("#h_disk_type_name").val();
				hid_data.diskTypeCode 		= $("#h_disk_type_code").val();
				hid_data.diskAlias 			= $("#h_disk_alias").val();
				hid_data.defaultNetworkAlias= $("#h_network_alias").val();
				hid_data.defaultNetworkId 	= $("#h_network_id").val();
				hid_data.beforeFlavorId 	= $("#flavorId option:selected").val();
				hid_data.apprvPass 			= $("#apprvPass").val();
				hid_data.selectApprv 		= $("#selectApprv").val();


				hid_data.hourlyFlag = $("input[name='onDemandFlag1']:checked").val();
				hid_data.approvalStepListString = JSON.stringify(approvalList);

			}

			// 변경확인 Modal에서 일괄신청버튼 이벤트(일괄신청)
			function actChangeBasketVm(){
				var gbn = $("#h_requestTypeCode").val();

				sethidData();

				$.ajax({
					url : "${wasPath}/mbr/bss/basket/changeBasket",
					dataType : "JSON",
					data : hid_data,
					success : function(data) {
						if(data.errorMsg == "1"){
							confirmBox3("일괄신청로 이동하시겠습니까?", moveBasket);
						}else if(data.errorMsg == "2"){
							alertBox3("장바구니에 다른 프로젝트 신청자원이 존재합니다.");
						} else {
							errorBox(data.errorMsg);
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

			function moveBasket(e){
				if(e){
					location.href = "${wasPath}/mbr/req/catalogue/basketOrder.do";
				}else{
					reload();
				}

			}

			function reload(){
				location.href = "${wasPath}/mbr/req/changeOrder/changeOrderView?projectId=${projectId}&gubun=${gubun}&productId=${productId}";
			}

			function moveBssOrderListPage(){
				location.href="${wasPath}/mbr/req/catalogue/bssOrderList";
			}

			// 변경확인 Modal에서 확인버튼 이벤트(바로변경)
			function actChangeOrderInsert(){

				var gbn = $("#h_requestTypeCode").val();
				sethidData();
				$.ajax({
					url : "${wasPath}/mbr/bss/order/changeOrder",
					dataType : "JSON",
					data : hid_data,
					success : function(data) {
						if(data.errorMsg == "1"){
			// 				alertBox("요청 되었습니다.", reload);
							alertBox("요청 되었습니다.", moveBssOrderListPage);
						}else{
							errorBox(data.errorMsg);
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

			function selectServerSpecGroup() {
				var selectCpuCnt = $("#flavorId option:selected").attr("cpu");
				var selectMemCnt = $("#flavorId option:selected").attr("mem");
				//var selectDiskCnt = $("#flavorId option:selected").attr("disk");
				$("#cpuCnt").val(selectCpuCnt);
				$("#memCnt").val(selectMemCnt);
				//checkAvail();
				//$("#diskcnt").val(selectDiskCnt);
				/*
				//CPU
				var cpucnt;
				var cpuprice;
				var imamount;
				cpucnt = Number(rtnnumber($("#cpucnt").val()));
				cpuprice = Number(rtnnumber($("#cpuprice").val()))*Number(cpucnt);
				imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#cpuprice").val()));
				$("#cpucnt").val(cpucnt);
				$("#cpupriceview").empty();
				$("#cpupriceview").append(addcomma(cpuprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));

				//MEM
				var memcnt;
				var memprice;
				var imamount;
				memcnt = Number(rtnnumber($("#memcnt").val()));
				memprice = Number(rtnnumber($("#memPrice1").val()))*Number(memcnt);
				imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#memPrice1").val()));
				$("#memcnt").val(memcnt);
				$("#mempriceview").empty();
				$("#mempriceview").append(addcomma(memprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
				*/
				// Disk
				/* 디스크 부분 용량 수정할 수 있게 기능 다시 변경해 달라고 요청함 (요청자 : 정희철, 2019.11.20 장중일)
				var diskcnt;
				var diskprice;
				var imamount;
				diskcnt = Number(rtnnumber($("#diskcnt").val()));
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
				imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#diskprice").val()))/10;

				$("#diskcnt").val(diskcnt);
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
				$("#imdiskprice").val(diskprice);
				$("#imdiskcnt").val($("#diskcnt").val());
				*/
			}
			jQuery.fn.filterBySelect = function(select1, selectSingleMatch) {
				return this.each(function () {
					var select = this;
					var options = [];
					$(select).find('option').each(function() {
						options.push({value: $(this).val(), text: $(this).text(), group: $(this).attr("group"), cpu: $(this).attr("cpu"), mem: $(this).attr("mem"), disk: $(this).attr("disk")  });
					});
					$(select).data('options', options);
					$(select1).bind('change', function() {
						var options = $(select).empty().data('options');
						var search = $(this).val();
						var regex = new RegExp(search, "gi");
						var a = 1;
						$.each(options, function(i) {
							var option = options[i];

							if(option.group.match(regex) !== null) {
								if(a == 1){
									$(select).append( $('<option>').text("서버사양을 선택하세요").val(""));
								}
								$(select).append( $('<option>').text(option.text).val(option.value).attr("cpu", option.cpu).attr("mem", option.mem).attr("disk", option.disk) );
								a++;
							}
						});
						if (selectSingleMatch === true && $(select).children().length === 1) {
							$(select).childeren().get(0).selected = true;
						}

						$("#flavorId2").text("서버사양을 선택하여주세요.");

					});
				});
			};

			function gridPrice(cloudId){

				if($("#h_requestTypeCode").val() != 1){
					setRequestType('REQTYPE_EXPR');
				}else{
					setRequestType('REQTYPE_CHANGE');
				}

 				$("#h_cloudSearchId").val(cloudId);
				$("#after_div_vm1").hide();
				$("#after_div_vm2").hide();
				$("#after_div_disk1").hide();
				$("#after_div_disk2").hide();
				$("#after_app_vm1").hide();
				$("#after_app_vm2").hide();

				if(cloudId != ""){
					$.ajax({
						url : "${contextPath}/mbr/req/changeOrder/changeOrderPriceInfo",
						dataType : "JSON",
			 			type : "GET",
						data : {
							"cloudId" : cloudId
						},
						success : function(req) {
							var result = req;
							getFlavorTypeList();
							getFlavorList();
							setData(result);
						},
						error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "error:" + error);
						}
					});
				}
			}

			function setData(result){

				getProjectList();

				$("#h_price_vm_cpu_hourly").val(result.cpuHourlyPrice/result.cpuQuantity);
				$("#h_price_vm_cpu_monthly_price").val(result.cpuMonthlyPrice/result.cpuQuantity);
				$("#h_price_vm_mem_hourly").val(result.memHourlyPrice/result.memQuantity);
				$("#h_price_vm_mem_monthly_price").val(result.memMonthlyPrice/result.memQuantity);
				$("#h_price_vm_disk_hourly").val(result.diskHourlyPrice/result.diskQuantity);
				$("#h_price_vm_disk_monthly_price").val(result.diskMonthlyPrice/result.diskQuantity);
			}

			$(document).ready(function() {
				App.init();
				calendar();
				gridPrice("${getCloudList[0].cloudId}");

				if('${gubun}' == 'lb'
						|| '${gubun}' == 'ip'
						|| '${gubun}' == 'service'
				){
					setRequestType('REQTYPE_EXPR');
					$('a[href="#nav-pills-tab-2"]').tab("show");
				}

				getProjectList();
				$("input[name='onDemandFlag']").click(function(){
					if($("input[name='onDemandFlag']:checked").val()=="N"){
						$("#sdate").show();
						$('.pdManageWrap .formContents .formBoxType2 table .fcsb').removeClass('mb20');
						$("#selectGubun").text("");
						$("#changeMsg").show();
					}else{
						$("#sdate").hide();
						$('.pdManageWrap .formContents .formBoxType2 table .fcsb').addClass('mb20');
						$("#selectGubun").text("");
						$("#changeMsg").hide();
					}
				});

				$("input[name='onDemandFlag1']").click(function(){
					if($("input[name='onDemandFlag1']:checked").val()=="N"){
						$("#sdate2").show();
						$('.pdManageWrap .formContents .formBoxType2 table .fcsb').removeClass('mb20');
						$("#selectGubun1").text("");
						$("#changeMsg1").show();
					}else{
						$("#sdate2").hide();
						$('.pdManageWrap .formContents .formBoxType2 table .fcsb').addClass('mb20');
						$("#selectGubun1").text("");
						$("#changeMsg1").hide();
					}
				});

				$("#cpuCnt").on('blur', function(){
					if(isNaN($(this).val())){
						afterReset(this.id);
					}else{
						getAtertAmount();
					}
				});

				$("#memCnt").on('blur', function(){
					if(isNaN($(this).val())){
						afterReset(this.id);
					}else{
						getAtertAmount();
					}
				});

				$("#diskCnt").on('blur', function(){
					if(isNaN($(this).val())){
						afterReset(this.id);
					}else{
						getAtertAmount();
					}
				});

				//메뉴활성화
				$("#reqProduct").addClass("active");
				$("#del").addClass("active");
			});

			function getFlavorTypeList(){
				var cloudId = $("#cloudId").val();
				if(cloudId != ""){
					var html = "";
					$.ajax({
						url : "${contextPath}/mbr/req/changeOrder/getFlavorTypeList",
						dataType : "JSON",
			 			type : "GET",
						data : {
							"cloudId" : cloudId
						},
						success : function(req) {
							var result = req;
							var html = "";
							$.each(result,function(key,val){
								if(key == 0){
									html += "<option value='"+val.flavorType+"' selected=\"selected\">"+val.flavorName+"</option>";
								} else {
									html += "<option value='"+val.flavorType+"'>"+val.flavorName+"</option>";
								}
							})
							$("#osSvrSpecGroup").html(html);
						},
						error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "error:" + error);
						}
					});
				}
			}

			function getFlavorList(){
				var cloudId = $("#cloudId").val();
				if(cloudId != ""){
					var html = "";
					$.ajax({
						url : "${contextPath}/mbr/req/changeOrder/getFlavorList",
						dataType : "JSON",
			 			type : "GET",
						data : {
							"cloudId" : cloudId
						},
						success : function(req) {
							var result = req;
							$.each(result,function(key,val){
								var ramGb = val.ramMb / 1024;
								html += "<option group='"+val.flavorType+"' cpu='"+val.vcpus+"' mem='"+ramGb+"' disk=\"50\" value='"+val.flavorId+"'>CPU: "+val.vcpus+"Core MEM: "+ramGb+"GB</option>";
							})
							$("#flavorId").html(html);
							$("#flavorId").filterBySelect($("#osSvrSpecGroup"), false);
							$("#osSvrSpecGroup option:first").prop("selected", true).trigger('change');
							$("#flavorId option:first").prop("selected", true).trigger('change');
						},
						error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "error:" + error);
						}
					});
				}
			}


			const label = document.querySelector('.kep-label');
			const options = document.querySelectorAll('.optionItem');
			const handleSelect = function(item) {
			  label.innerHTML = item.innerText;
			  label.parentNode.classList.remove('active');
			}
			for( let i = 0; i < options.length; i++ ){
			  options[i].addEventListener('click', function(){handleSelect(this)})
			}

			label.addEventListener('click', function(){
			  if(label.parentNode.classList.contains('active')) {
			    label.parentNode.classList.remove('active');
			  } else {
			    label.parentNode.classList.add('active');
			  }
			});

// 			function checkAvail(){
// 				var cpuCnt = $("#cpuCnt").val() * 1;
// 				var memCnt = $("#memCnt").val() * 1;
// 				var diskCnt = $("#diskCnt").val() * 1;
// 				var currentCpu = $("#checkVcpus").val() * 1;
// 				var currentMem = $("#checkMemGb").val() * 1;
// 				var currentDisk = $("#checkDiskGb").val() * 1;
// 				var cpuAvail;
// 				var memAvail;
// 				var diskAvail;
// 				$.ajax({
// 					url : "${wasPath}/mng/project/quota/getQuota",
// 					type:"GET",
// 					data:{projectId:hprojectId},
// 					success:function(data){
// 						cpuAvail = data.vcpuAvail * 1;
// 						cpuAvail = cpuAvail + currentCpu;
// 						memAvail = data.memAvail * 1;
// 						memAvail = memAvail / 1024;
// 						memAvail = memAvail + currentMem;
// 						diskAvail = data.diskAvail * 1;
// 						diskAvail = diskAvail + currentDisk;
// 						if(diskCnt > diskAvail && diskAvail != "undefined"){
// 							alertBox3("디스크 자원 쿼터를 초과하였습니다.");
// 							$("#diskCnt").val(diskAvail);
// 							return false;
// 						}
// 						if(cpuCnt > cpuAvail && cpuAvail != "undefined"){
// 							resetSelect();
// 							alertBox3("cpu 자원 쿼터를 초과하였습니다.");
// 							return false;
// 						}
// 						if(memCnt > memAvail && memAvail != "undefined"){
// 							resetSelect();
// 							alertBox3("메모리 자원 쿼터를 초과하였습니다.");
// 							return false;
// 						}
// 					}
// 				})
// 			}

// 			function resetSelect(){
// 				$("#cpuCnt").val(0);
// 				$("#memCnt").val(0);
// 				$("#flavorId option:eq(0)").prop("selected",true);
// 				$("#flavorId2").html("서버사양을 선택하여주세요.");
// 			}
		</script>
	</body>
</html>