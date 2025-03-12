<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri = "http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
   	<sec:authentication var="roles" property="principal.roles"/>
   		<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

<c:set var="contextPath" value="${wasPath}"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
	</head>
	<body>
		<iframe id='iframeBasket' name='iframeBasket' style='display:none; border:0px;'></iframe>

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

				 <p class="page_title">스냅샷 신청
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> 서비스 신청 <span class="arrow_ab"> &#8227; </span> <b>스냅샷 신청 </b>
			    </span>
		    	</p>

				 <!-- begin page-body -->
				 <div class="row p20 bgwh br10">



					<%-- <div class="productTotalArea">
						<div class="productTitleArea">
							<img src="${getCatalogueSubList.imageName}" class=" width-120 pt10"/>

							<span class="productTitle">
							${getCatalogueSubList.displayName}
							</span>
							<!-- <p class="productsubTitle">고객사의 사업을 더욱더 활성화하고 성공비지니스를 안겨 줄 것 입니다</p> -->
							<p class="productsubTitle">
							<c:if test="${getCatalogueSubList.descriptionTop eq null or getCatalogueSubList.descriptionTop eq ''}">
							특정 시간에 파일시스템을 보관하는 스냅샷을 신청하는 기능입니다.
							</c:if>
							<c:if test="${getCatalogueSubList.descriptionTop ne null or getCatalogueSubList.descriptionTop ne ''}">
							${getCatalogueSubList.descriptionTop}
							</c:if>
							</p>
						</div>
					</div>  --%>

					<div class="product_box">
					  <li class="img"><img src="${getCatalogueSubList.imageName}" class="width-80"/></li>
					  <li class="description">
					      <span class="productTitle">${getCatalogueSubList.displayName}</span>
					       <p class="productsubTitle">
					       <c:if test="${getCatalogueSubList.descriptionTop eq null or getCatalogueSubList.descriptionTop eq ''}">
							특정 시간에 파일시스템을 보관하는 스냅샷을 신청하는 기능입니다.
							</c:if>
							<c:if test="${getCatalogueSubList.descriptionTop ne null or getCatalogueSubList.descriptionTop ne ''}">
							${getCatalogueSubList.descriptionTop}
							</c:if>
					        </p>
					  </li>
					  <ul class="product_sub">
					  <%-- <li class="disk"><img src="/resources/assets/img/icon_disk.png"/> DISK  <span class="fc_green_im flr f24 lh20"> ${getCatalogueSelectView.diskGb} <span class="f16 fc33">GB</span></span></li>
					    <li class="memory"><img src="/resources/assets/img/icon_mem.png"/> MEMORY <span class="fc_blue_im flr f24 lh20"> ${getCatalogueSelectView.memGb} <span class="f16 fc33">GB</span></span></li>
					   <li class="cpu"><img src="/resources/assets/img/icon_cpu.png"/> vCPU  <span class="fc_purple_im flr f24 lh20">${getCatalogueSelectView.vcpus} <span class="f16 fc33">Core</span></span></li> --%>
					  </ul>
					</div>




					<div class="clear"></div>

					<div class="orderArea">
						<div class="tableF">
							<form name="catalogueform"  id="catalogueform" action="${wasPath}/mbr/req/catalogue/catalogueSnapshot" method="post" >
								<input type="hidden" name="type" id="type" value="noworder" />
								<input type="hidden" name="requestType" id="requestType" value="REQTYPE_NEW" />
								<input type="hidden" name="imageName" id="imageName" value="${getCatalogueSubList.imageName}" />
								<input type="hidden" name="productSeq" id="productSeq" value="${getCatalogueSubList.productSeq}" />
								<input type="hidden" name="totalPrice" id="totalPrice" value="${getCatalogueSubList.monthlyPrice}"/>
								<input type="hidden" name="productCategory" id="productCategory" value="${getCatalogueSubList.productCategory}" />
								<input type="hidden" name="hourlyFlag" id="hourlyFlag" value="${hourlyvo.hourlyFlag}" />
								<input type="hidden" name="lowProjectName" id="lowProjectName" value="" />
								<input type="hidden" name="catalogSeq" id="catalogSeq" value="${getCatalogueSubList.catalogSeq}" />
								<input type="hidden" name="snapshotProductSeq" id="snapshotProductSeq" value="${getCatalogueSubList.productSeq}" />
								<input type="hidden" name="apprvPass" id="apprvPass"				value="${apprvPass}" />
								<input type="hidden" name="selectApprv" id="selectApprv"			value="" />
								<input type="hidden" name="applyDatetime" id="applyDatetime" value="" />
								<input type="hidden" name="approvalStepListString" id="approvalStepListString" />
								<input type="hidden" name="vmUuid" id="vmUuid" />

								<table>
									<colgroup>
										<col width="9%">
										<col width="40%">
										<col width="9%">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<td class="left-t">서비스희망일시</td>
											<td colspan="3">
												<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성</label>     &nbsp;&nbsp;
												<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> <span class="mr14">희망일시 생성 </span></label><br/>
												   <div class="fc-dblue2 f14 pt10" id="selectTEXT" ><i class='fa fa-exclamation-circle f16 fc-dblue2'></i><span class="fb"> 관리자의 최종승인 후 스냅샷이 생성이 됩니다. </span></div>
											</td>
										</tr>
										<tr id="sdate" name="sdate" style="display:none">
											<td class="left"></td>
											<td>
											<div>
												<input type="text" class="form-control dpin w138" id="applyDate" name="applyDate" />
												<div class="searchBoxArea w110 ml26">
													<div class="">
														<label class="selectBoxDrop" for="applyTime">18</label>
														<select class="search-sel" name="applyTime" id="applyTime">
															<c:forEach var="time" begin="1" end="24">
																<c:if test="${time eq 18}">
																	<option value="${time}" selected="selected">${time}</option>
																</c:if>
																<c:if test="${time ne 18}">
																	<option value="${time}" >${time}</option>
																</c:if>
															</c:forEach>
														</select>
													</div>
												</div>
												<span class="fc33 f16 lh34 ml5">시</span>
											</div>
											</td>
										</tr>
										<tr>
											<td class="left">프로젝트명</td>
											<td>
												<input class="form-control" type="text" name="projectAlias" id="projectAlias" readonly="readonly"/>
												<input class="form-control" type="hidden" name="projectName" id="projectName" />
												<input type="hidden" name="projectBoxId" id="projectBoxId" value="" />
												<input type="hidden" name="projectId" id="projectId" value="" />
												<!-- <img src="/resources/assets/img/icon_search.png" onclick="openModal();"class="input_search t6 r0"/> -->
												<img src="${apachePath}/resources/assets/img/btn_search2.png" height=32px;  onclick="openModal();" class="pa-t14r20"/>
											</td>
										</tr>
										<tr>
											<td class="left" scope="row">스냅샷명</td>
											<td>
												<input maxlength="30" class="form-control" type="text" name="snapshotName" id="snapshotName" />
											</td>
											<td class="left">디스크</td>
											<td>
												<input class="form-control" type="text" name="diskAlias" id="diskAlias" readonly="readonly"/>
												<input class="form-control" type="hidden" name="diskName" id="diskName" />
												<input type="hidden" name="diskId" id="diskId" value="" />
												<!-- <img src="/resources/assets/img/icon_search.png" onclick="openModal2();"class="input_search t6 r0"/> -->
												<img src="${apachePath}/resources/assets/img/btn_search2.png" height=32px;  onclick="openModal2();" class="pa-t14r20"/>
											</td>
										</tr>
										<tr>
											 <td class="left" scope="row">스냅샷설명</td>
											<td colspan="3">
												<textarea rows="2" cols="100%" id="description" name="description"></textarea>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>

					<div class="btn_area">
						<a type="button" class="btn_navy"  onclick="openApproveReviewModal();">신청</a>

						<a type="button" class="btn_lgrey ml10" onclick="moveListPage();"> 취소 </a>
					</div>

				</div>
				<!-- begin #footer -->

				<!-- 프로젝트 선택 시작 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
					<div class="modal-dialog width-720">
						<div class="modal-content width-720">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
								<h4 class="modal-title">프로젝트명</h4>
							</div>
							<div class="modal-body">

		                     	 <div class="col-xs-12 bgee modalpop mb20">
		                      		<div class="selectBoxAr col-xs-2">
										<label class="selectText" for="searchKind">전체</label>
										<select class="search-sel" id="searchKind">
											<option value="searchAll">전체</option>
											<option value="project_name">프로젝트ID</option>
											<option value="project_alias">프로젝트명</option>
										</select>
									</div>
									<div class="search-box">
										<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="searchKeyword" >
										<button type="button" class="btn_search2 vm" onclick="projectPopList();"><span></span></button>
									</div>
								</div>
								<!--검색  끝//-->
								<div class="popListTable">
									<table class="tableV">
										<colgroup>
											<col width="*">
									 		<col width="*">
									 		<col width="80px">
									 	</colgroup>
									 	<thead>
								 		<tr class="skyblue">
								 			<th class="tac">프로젝트ID</th>
											<th class="tac">프로젝트명</th>
											<th class="tac">적용</th>
										</tr>
								 	   </thead>
										<tbody id="popListTable">
										</tbody>
									</table>
								</div>
							</div>
	                  		<div class="clear"></div>
		                  	<div class="modal-footer tac">
		              			<a type="button" class="m_btn_navy" data-dismiss="modal" onclick="okProjectInsert();">확인</a>
		              			<a type="button" class="m_btn_white ml10" data-dismiss="modal">취소</a>
		                  	</div>
		              	</div>
		          	</div>
		      	</div>
				<!-- 프로젝트 선택 끝 -->
				<!-- #modal-dialog 가상서버검색-->
				<div class="modal fade pdManage" id="modal-dialog_disk">
					<div class="modal-dialog width-720">
						<div class="modal-content width-720">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
								<h4 class="modal-title" id='popDivTitle'>블록디스크 검색</h4>
							</div>
							<div class="modal-body">
								<!-- search begin -->
						 			<div class="col-xs-12 bgee modalpop mb20">
		                      			<div class="selectBoxAr col-xs-2">
											<label class="selectText" for="disk_searchKind" id='vm_searchKindLabel'>블록디스크명</label>
											<select class="search-sel" id="disk_searchKind" name="disk_searchKind">
											</select>
										</div>
										<div class="search-box">
											<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="disk_keyword" data-original-title="" title="" onkeypress="if(event.keyCode==13)getGridList();">
											<button type="button" class="btn_search2" onclick="getGridList();"><span></span></button>
										</div>
								</div>
								<!-- search end -->
						   		<div style="max-height: 320px">
									<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="disk-List">
							 			<colgroup>
											<col width="*">
											<col width="*">
											<col width="80px">
										</colgroup>
										<thead id='popDivThead'>
							 			</thead>
										<tbody id="disk-listTable">
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
				<!-- #modal-dialog 결재자 지정팝업-->
	            <div class="modal fade" id="modal-approve-dialog">
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
		             			<a type=button class="lbtn" data-dismiss="modal" onclick="noworder();">확인</a>
		             			<a type=button class="rbtn ml10" data-dismiss="modal">취소</a>
		                 	</div>
		             	 </div>
					</div>
		        </div>
		        <!-- 프로젝트 검토자 결재자 지정 팝업 -->
		        <!-- 프로젝트 검토자 결재자 지정 팝업 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="user-modal-review-dialog">
					<div class="modal-dialog width-720">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'>
									<span></span>
								</button>
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
								<a type="button" class="whiteline" data-dismiss="modal">닫기</a>
							</div>
						</div>
					</div>
				</div>
				<!-- #modal-dialog 구매 확인-->
	            <div class="modal fade pdManage" id="modal-dialog3">
		              <div class="modal-dialog">
		                  <div class="modal-content">
		                      <div class="modal-header">
		                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                          <h4 class="modal-title">신청확인</h4>
	                          </div>
	                          <div class="modal-body">
								<div class="modalManagePop">
									<strong class="title" id="pop_loadbalancerName"></strong>
									<div class="detailBox">
										<div class="boxType02">
											<ul>
												<li><span class="title">요청유형</span><span class="cnt">신규</span></li>
												<li><span class="title">프로젝트</span><span id="project_name"></span></li>
												<li><span class="title">가상서버</span><span id="vm_name"></span></li>
												<li><span class="title">스냅샷명</span><span id="snapshot_name"></span></li>
												<li><span class="title">디스크</span><span id="snapshot_disk"></span></li>
												<li><span class="title">희망일시</span><span id="pop_onDemandFlag"></span></li>
												<li><span class="title">설명</span><span id="snapshot_alias"></span></li>

											</ul>
										</div>
										<dl class="boxType03 dpno">
											<dt>금액<span class="fc-red">(VAT 별도)</span></dt>
											<dd><strong id="pop_totalPrice"></strong><span>&nbsp;원</span></dd>
										</dl>
									</div>
									<p class="commnet fc-red">위 내용으로 신청 하시겠습니까?</p>
								</div>
	                          </div>
						   <div class="clear"></div>
	                          <div class="modal-footer tac">
		        	       			<a type="button" class="lbtn" data-dismiss="modal" onclick="request_noworder();">확인</a>
		                   			<a type="button" class="rbtn ml10" data-dismiss="modal">취소</a>
		                      </div>
	                      </div>
	                </div>
	            </div>
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			</div>
		</div>

	<!-- end page container -->

	<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

	<script type="text/javascript">

	var approvalList = [];
	var hprojectName, hprojectId,hprojectBoxId, hprojectAlias,hdiskId,hdiskAlias,hvmUuid,hvmName,hhostnameAlias;
	$(document).ready(function() {
	    App.init();
	    calendar();
	    if($("input[name='onDemandFlag']:checked").val()=="N"){
	    	$("#sdate").show();
		}else{
			$("#sdate").hide();
		}
		$("input[name='onDemandFlag']").on('click',function(){
			if($("input[name='onDemandFlag']:checked").val()=="N"){
				$("#sdate").show();
			}else{
				$("#sdate").hide();
			}
		});
		$("#reqProduct").addClass("active");
		$("#service").addClass("active");

	});

	function openModal(){
		$("#modal-dialog").modal();
		projectPopList();
	}

	function projectPopList(){
		var keyword = $("#searchKeyword").val();
		$.ajax({
			url : "${wasPath}/mbr/req/catalogue/projectPopList",
			dataType : "JSON",
			//type : "POST",
			data : {
				"searchValue" : keyword,
			},
			success : function(data) {
				var projectList = data.getProjectList;

				if(projectList!=""){
					$("#popListTable > tr").remove();
					$.each(projectList,function(key,val){
						var Html="";
	 					//Html="<tr><td class='tac'>"+val["projectName"]+"</td>";
						Html="<tr>";
						    Html = Html + "<td class='tac'>"+val["projectName"]+"</td>";
							Html = Html + "<td class='tac'>"+val["projectAlias"]+"</td>";
							Html = Html + "<td class='tac'><input type='button' class='popCheckbtn'  value='&#xf00c' onclick='updateProject(this, \""+val["projectId"]+"\", \""+val["projectName"]+"\", \""+val["projectAlias"]+"\", \""+val["projectBoxId"]+"\")'></td>";
							Html = Html + "</tr>";
						$("#popListTable").append(Html);
					});
				} else {
					$("#popListTable > tr").remove();
					var Html="";
					Html="<tr><td class='tac' colspan='3'>검색된 프로젝트가 없습니다.</td>";
					Html = Html + "</tr>";
					$("#popListTable").append(Html);
				}

				$('#popListTable tr:odd').addClass('even');
				$('#popListTable tr:even').addClass('odd');
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

	// 달력
	function calendar(){

		var dayName = ['일','월','화','수','목','금','토'];
		var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

		$("#applyDate").datepicker({
			showOn:"both",
			buttonImage:"${apachePath}/resources/assets/img/calen.png",
			buttonImageOnly:true,
			dateFormat : "yy-mm-dd",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});
		$("img.ui-datepicker-trigger").attr("style", "vertical-align:top;");

		$("#applyDate").val($.datepicker.formatDate('yy-mm-dd', new Date()));
	}

	function updateProject(e, projectId, projectName,projectAlias,projectBoxId){
		$("#popListTable > tr").find("input").removeClass("active");
		$(e).toggleClass("active");
		hprojectName = projectName;
		hprojectId = projectId;
		hprojectBoxId = projectBoxId;
		hprojectAlias = projectAlias;
		hvmUuid = "";
		hdiskId = "";
		hdiskAlias = "";
	}

	function okProjectInsert(){
		$("#projectName").val(hprojectName);
		$("#projectId").val(hprojectId);
		$("#projectBoxId").val(hprojectBoxId);
		$("#projectAlias").val(hprojectAlias);
		$("#vmUuid").val(hvmUuid);
		$("#hdiskId").val(hvmName);
		$("#hdiskAlias").val(hdiskAlias);
		$("#vmBtn").show();
	}

	function openModal2(){
		if($("#projectBoxId").val() == ""){
			alertBox3("프로젝트를 선택해주세요.");
			return false;
		}
		$("#modal-dialog_disk").modal();
		gridDiskList();
	}

	function gridDiskList(){
		$("#popDivTitle").html("블록디스크 검색");
		$("#popDivThead").html('<tr class="skyblue">'
				 				+'<th class="tac">디스크명</th>'
				 				+'<th class="tac">호스트명</th>'
				 				+'<th class="tac">선택</th>'
				 			+'</tr>');
		$.ajax({
			url : "${wasPath}/mbr/oss/disk/snapshotDiskList",
			dataType : "JSON",
			//type : "POST",
			data : {
				"searchKind" : $("#disk_searchKind option:selected").val(),
				"keyword" : $("#disk_keyword").val(),
				"projectId" : $("#projectBoxId").val(),
				"projectName" : $("#projectName").val(),
				"length" : "0"
			},
			success : function(data) {
				$("#disk-listTable > tr").remove();
				var diskList = data.data;
				if(diskList!=""){
					$("#disk-List > tr").remove();
					$.each(diskList,function(key,val){
						var Html="";
						Html="<tr>";
						    Html = Html + "<td class='tac'>"+val["diskAlias"]+"</td>";
							Html = Html + "<td class='tac'>"+val["hostnameAlias"]+"</td>";
							Html = Html + "<td class='tac'><input type='button' class='popCheckbtn'  value='&#xf00c' onclick='updateDisk(this, \""+val["diskId"]+"\", \""+val["diskAlias"]+"\", \""+val["vmUuid"]+"\", \""+val["hostnameAlias"]+"\")'></td>";
							Html = Html + "</tr>";
						$("#disk-listTable").append(Html);
					});
				} else {
					$("#disk-List > tr").remove();
					var Html="";
					Html="<tr><td class='tac' colspan='3'>검색된 프로젝트가 없습니다.</td>";
					Html = Html + "</tr>";
					$("#popListTable").append(Html);
				}

				$('#popListTable tr:odd').addClass('even');
				$('#popListTable tr:even').addClass('odd');
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

	function updateDisk(e, diskId, diskAlias,vmUuid,hostnameAlias){
		$("#disk-listTable > tr").find("input").removeClass("active");
		$(e).toggleClass("active");
		hdiskId = diskId;
		hdiskAlias = diskAlias;
		hvmUuid = vmUuid;
		hhostnameAlias = hostnameAlias;
	}

	function okProduct(){
		$("#diskId").val(hdiskId);
		$("#diskAlias").val(hdiskAlias);
		$("#vmUuid").val(hvmUuid);
	}

	function openApproveReviewModal() {
		if($("#projectBoxId").val() == "" ){
			alertBox3("프로젝트를 선택해주세요.");
			return false;
		}
		if($("#snapshotName").val() == ""){
			alertBox3("스냅샷명을 입력해주세요.");
			return false;
		}
		if($("#diskId").val() == ""){
			alertBox3("디스크를 선택해주세요.");
			return false;
		}

		if($("#apprvPass").val() == "Y"){
			confirmBox4("결재자를 지정하시겠습니까?",approvSelect,nApprovSelect);
		} else {
			approvSelect();
		}
	}
	function nApprovSelect(){
		$("#selectApprv").val("Y");
		noworder();
	}
	function approvSelect(){
		$("#selectApprv").val("N");
		$("#modal-approve-dialog").modal();
	}
	function openReviewModal(e) {
		currentApprovalLine = e;
		var tmpCurrentApprovalStep = currentApprovalLine.id.replace("approvalLine", "");
		if( approvalList[tmpCurrentApprovalStep-1] != undefined) {
			confirmBox("재신청할경우 현재 상위결재자값이 초기화 됩니다.", clearUpperApproval );

		} else {
			$("#user-modal-review-dialog").modal();
			gridPopList();
		}
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
	// 검토자지정
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

		var tmpValue = { "userId" : userId, "deptName" : deptName, "userName" : userName, "userLevel" : userLevel, "userLevelCode" : userLevelCode }

		$("#"+currentApprovalLine.id+"_userId").text(userId);
		$("#"+currentApprovalLine.id+"_userLevel").text(userLevel);
		$("#"+currentApprovalLine.id+"_userName").text(userName);

		approvalList[tmpCurrentApprovalStep-1] = tmpValue;
		$("#popListReviewTable > tr").find("input").removeClass("active");
		$(e).toggleClass("active");
		$("#userIdReview").text(userId);
		$("#userNameReview").text(userName);
		$("#hiddenUserIdReview").val(userId);
		$("#hiddenUserNameReview").val(userName);

		// 다음 단계 버튼 활성화
		$("#approvalLine"+(parseInt(tmpCurrentApprovalStep)+1) ).attr('disabled', false);
	}

	function noworder(){
		if( (approvalList[3] == undefined || approvalList[3] == null || approvalList[3] == '') && $("#selectApprv").val() == 'N') {
			alertBox3("결재자를 지정해 주세요");
			return false;
		}
		setOrder();
		//$("#catalogueform").submit();
		$("#modal-dialog3").modal();
	}
	function setOrder(){
		$("#project_name").text($("#projectName").val());
		$("#snapshot_disk").text($("#diskAlias").val());
		$("#snapshot_name").text($("#snapshotName").val());
		$("#snapshot_alias").text($("#description").val());
		$("#vm_name").text(hhostnameAlias);
		if ($("input[name='onDemandFlag']:checked").val() == 'N') {
			$("#pop_onDemandFlag").text($("#applyDate").val()+' '+$("#applyTime").val()+':00');
			$("#applyDatetime").val($("#applyDate").val()+' '+$("#applyTime").val()+':00');
		} else if ($("input[name='onDemandFlag']:checked").val() == 'Y') {
			$("#pop_onDemandFlag").text('승인 완료 후 생성');
		}
	}
	function request_noworder(){
		//$("#catalogueform").submit();

		//$("#orderform").submit();
		if( approvalList[0] == undefined || approvalList[0] == null) {
			var tmp = {"userId" : "", "deptName" : "", "userName" : "", "userLevel" : "", "userLevelCode" : ""};
			approvalList[0] = tmp;
		}
		$("#approvalStepListString").val(JSON.stringify(approvalList));

		var type = $("#catalogueform").attr("type");
		var url = $("#catalogueform").attr("action");
		var data = $("#catalogueform").serialize();
		var data = data;
		$.ajax({
			url:url,
			type:type,
			data:data,
			success:function(data){
				if(data == "1"){
					alertBox("신청이 완료 되었습니다.", orderok2);
				} else {
					alertBox3("신청에 실패하였습니다.");
				}
			},
			error : function(request, status, error) {
				regTemp = true;
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);
				}else{
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			}
		})
	}

	function orderok2(){
		location.href="${wasPath}/mbr/req/catalogue/bssOrderList";
	}

	function moveListPage() {
		location.href="${wasPath}/mbr/req/catalogue/catalogueServiceList.do";
	}
	</script>

</body>
</html>