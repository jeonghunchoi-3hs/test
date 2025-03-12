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

		<!-- begin #content -->
		<div id="content" class="content">


			<!-- begin header -->
			<div class="page_header mb30">
				<h1>가격정책 상세</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">자원관리</a><a href="#" class="on">가격정책 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<input type="hidden" id="h_policySeq" value="${getBillPolicyView.policySeq}">

				<div class="client_DetailArea clearfix m-b-20">
					<h2 class="blueBoxTitle">가격정책 정보</h2>
					<p class="company_Name2">${getBillPolicyView.policyName}</p>
					<p class="company_Info m-t-0 m-b-25 p-t-15">
						<span class="company_labelf">적용일자 :</span><span class="company_cont" id="">
							<c:if test="${getBillPolicyView.applyDate ne '9999-12-31'}">
								${getBillPolicyView.applyDate}
							</c:if>
						</span>
					</p>
					<div class="comp_btn_Area" style="position:absolute; top:4px; right:10px;">
						<a type="button" class="bton-s bton_blue" onclick="moveInsertPage();"><span class="txt"> <i class="fa fa-files-o"></i> 등록</span></a>
						<a type="button" class="bton-s bton_green" onclick="moveCopyPage();"><span class="txt"> <i class="fa fa-files-o"></i> 복사</span></a>
						<c:if test="${getBillPolicyView.active eq 'Y'}">
							<a type="button" class="bton-s bton_blue" onclick="moveUpdatePage();"><span class="txt"><i class="fa fa-pencil"></i> 수정</span></a>
							<a type="button" class="bton-s bton_orange" onclick="billpolicydelchk();"><span class="txt"><i class="fa fa-trash"></i> 삭제</span></a>
						</c:if>
					</div>
				</div>

				<div class="gridTableWrap gridType02 ">
					<div class="tar mb5">
						<h2 class="titleBuType01 fl">과금항목 정보</h2>
						<a type="button" class="bton-s bton_blue" onclick="excelDown();"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
					</div>

					<!-- 그리드 영역 -->
					<div class="tableWrap">
						<table id="">
							<colgroup>
								<col width="*">
								<col width="140px">
								<col width="140px">
								<col width="120px">
							</colgroup>
							<thead>
								<tr>
									<th>과금항목명</th>
									<th>수량 (단위)</th>
									<th>월 금액(원)</th>
									<th>수정</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${getBillItemList}" var="getBillItemList" varStatus="status" >
									<tr>
										<td class="tal p-l-30">${getBillItemList.itemName}</td>
										<td class="tar p-r-20">
											<span class="unitNum">${getBillItemList.quantity}</span> <span class="unitTxt">${getBillItemList.unit}</span>
										</td>
									<!-- 시간금액 목록 주석처리 -->
									<!-- 	<td  class="fontVdn tar p-r-20">
											<fmt:formatNumber value="${getBillItemList.hourlyPrice}" pattern="#,###"/>
										</td> -->
										<td  class="fontVdn tar p-r-20">
											<fmt:formatNumber value="${getBillItemList.monthlyPrice}" pattern="#,###"/>
										</td>
										<td class="ditailStyle tac">
										<a type="button" class="bton-s bton_blue" type="button" onclick="moveEditPage('${getBillPolicyView.policySeq}','${getBillItemList.itemId}','${getBillItemList.itemName}','${getBillItemList.quantity}','${getBillItemList.unit}','${getBillItemList.hourlyPrice}','${getBillItemList.monthlyPrice}');"><i class='fa fa-edit'></i> 수정</a>
										</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</div>

				<div class="row tac m-t-40">
					<a type="button"  class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>
				</div>


				<div class="modal fade" id="modal-dialog-update">
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">가격정책 수정</h4>
	                       	</div>
	                       	<div class="modal-body">
								<h4 class="tal fc11 mb10">가격정책 정보</h4>
	                       		<div class="formType01">
									<div class="tblWrap clearfix">
										<table>
											<colgroup>
												 <col width="145px">
												 <col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><strong>적용일자</strong></th>
													<td class="tal">
														<input type="text" class="applyDate" name="modify_applyDate" id="modify_applyDate" style="width:120px;" readonly="readonly" value="${getBillPolicyView.applyDate.substring(0,7)}"/><img src="/resources/mng/assets/img/ico_datepicker_cal.png" id="applyDateBtn" style="vertical-align: top;height:32px;">
													</td>
												</tr>
												<tr>
													<th scope="row"><strong>클라우드</strong></th>
													<td class="tal">${getBillPolicyView.cloudName}</td>
												</tr>
												<tr>
													<th scope="row"><strong>정책명</strong></th>
													<td class="tal">
														<input type="text" style="width:100%" name="modify_policyName" id="modify_policyName" maxlength="40" value="${getBillPolicyView.policyName}">
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<p class="f16 f11 mt10  fc-blue">가격정책을 수정하시겠습니까?</p>
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="modySaveCheck();">확인</a>
		                       <a type="button" class="pbton bton_dgrey" data-dismiss="modal" onclick="">취소</a>
	                       </div>
		               	</div>
					</div>
	            </div>

				<div class="modal fade" id="modal-dialog-copy">
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">가격정책 복사</h4>
	                       	</div>
	                       	<div class="modal-body">
								<h4 class="tal fc11 mb10">기존 가격정책 정보</h4>
	                       		<div class="formType01 m-b-25">
									<div class="tblWrap clearfix">
										<table>
											<colgroup>
												 <col width="145px">
												 <col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><strong>적용일자</strong></th>
													<td class="tal" id="copyOrg_applyDate">
														${getBillPolicyView.applyDate}
													</td>
												</tr>
												<tr>
													<th scope="row"><strong>클라우드</strong></th>
													<td class="tal">
														${getBillPolicyView.cloudName}
													</td>
												</tr>
												<tr>
													<th scope="row"><strong>정책명</strong></th>
													<td class="tal" id="copyOrg_policyName">
														${getBillPolicyView.policyName}
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<h4 class="tal fc11 mb10">복사할 가격정책 정보</h4>
	                       		<div class="formType01">
									<div class="tblWrap clearfix">
										<table>
											<colgroup>
												 <col width="145px">
												 <col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><strong>정책명</strong></th>
													<td>
														<input type="text" style="width:100%;" name="" id="copy_policyName" maxlength="40">
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<p class="f16 f11 mt10 fc-blue">가격정책을 복사하시겠습니까?</p>
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="saveCheck();">확인</a>
		                       <a type="button" class="pbton bton_dgrey" data-dismiss="modal" onclick="">취소</a>
	                       </div>
		               	</div>
					</div>
	            </div>

	            <div class="modal fade" id="modal-dialog-edit">
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">과금항목 수정</h4>
	                       	</div>
	                       	<div class="modal-body">
								<!-- <h4 class="tal f20 fc11 m-b-20">과금항목 정보</h4> -->
	                       		<div class="formType01">
	                       		<input type ="hidden" id = "policySeq">
	                       		<input type ="hidden" id = "itemId">
	                       		<input type ="hidden" id = "itemName">
	                       		<input type ="hidden" id = "quantity">
	                       		<input type ="hidden" id = "unit">

									<div class="tblWrap clearfix">
										<table>
											<colgroup>
												 <col width="130px">
												 <col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><strong>과금항목명</strong></th>
													<td class="tal" id ="itemNameText"></td>
												</tr>
												<tr>
													<th scope="row"><strong>클라우드</strong></th>
													<td class="tal">${getBillPolicyView.cloudName}</td>
												</tr>
												<tr>
													<th scope="row"><strong>수량(단위)</strong></th>
													<td class="tal fontVdn" id="quantityText"></td>
												</tr>
												 <!-- <tr>
													<th scope="row"><strong>시간 금액(원)</strong></th>
													<td class="tal">
														<input type="text" style="width:100%" name="" id="hourlyPrice" class="tar fontVdn" maxlength="40" value="" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" />
													</td>
												</tr>  -->
												<!-- <input type="hidden"  id="hourlyPrice" value=""/> -->
												<tr>
													<th scope="row"><strong>월 금액(원)</strong></th>
													<td class="tal">
														<input type="text" style="width:100%" name="" id="monthlyPrice" class="tar fontVdn" maxlength="40" value="" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" />
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="saveConfirm()"> 확인</a>
		                       <a type="button" class="pbton bton_dgrey" data-dismiss="modal" onclick=""> 취소</a>
	                       </div>
		               	</div>
					</div>
	            </div>


	            <!-- 가격정책 상세 등록 팝업창 시작 -->

	             <div class="modal fade" id="modal-dialog-insert">
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">과금항목 수정</h4>
	                       	</div>
	                       	<div class="modal-body">
								<!-- <h4 class="tal f20 fc11 m-b-20">과금항목 정보</h4> -->
	                       		<div class="formType01">

									<div class="tblWrap clearfix">
										<table>
											<colgroup>
												 <col width="130px">
												 <col width="*">
											</colgroup>
											<tbody>

												<tr>
													<th scope="row"><strong>클라우드</strong></th>
													<td class="tal">
														<input type="text" style="width:100%" id="insertCloudId" class="tar fontVdn"  value="${getBillPolicyView.cloudId}"/>
													</td>
												</tr>

												<tr>
													<th scope="row"><strong>수량(단위)</strong></th>
													<td><select class="form-control" id="insertUnit" 	style="width: 100%">
															<option value="">unit을 선택하세요</option>
															<c:forEach items="${getBillTypeList}"
																var="getBillTypeList" varStatus="status">
																<option value="${getBillTypeList.unit}">${getBillTypeList.unit}</option>
															</c:forEach>
													</select></td>
												</tr>

												<tr>
													<th scope="row"><strong>과금항목카테고리</strong></th>
													<td><select class="form-control" id="insertItemCategory"	style="width: 100%">
															<option value="">itemCategory을 선택하세요</option>
															<c:forEach items="${getBillTypeList}"
																var="getBillTypeList" varStatus="status">
																<option value="${getBillTypeList.itemCategory}">${getBillTypeList.itemCategory}</option>
															</c:forEach>
													</select></td>
												</tr>

												<tr>
													<th scope="row"><strong>과금항목ID</strong></th>
													<td class="tal">
														<input type="text" style="width:100%" value="" id="insertItemId" class="tar fontVdn"/>
													</td>
												</tr>
												<tr>
													<th scope="row"><strong>과금항목명</strong></th>
													<td class="tal">
														<input type="text" style="width:100%" value="" id="insertItemName" class="tar fontVdn"/>
													</td>
												</tr>
												<tr>
													<th scope="row"><strong>시간 금액(원)</strong></th>
													<td class="tal">
														<input type="text" style="width:100%" value="" id="insertHourlyPrice" class="tar fontVdn"  onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this); "/>
													</td>
												</tr>
												<tr>
													<th scope="row"><strong>월 금액(원)</strong></th>
													<td class="tal">
														<input type="text" style="width:100%" value="" id="insertMonthlyPrice" class="tar fontVdn"  onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);"  />
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="insertConfirm()"> 확인</a>
		                       <a type="button" class="pbton bton_dgrey" data-dismiss="modal" onclick=""> 취소</a>
	                       </div>
		               	</div>
					</div>
	            </div>

	            <!-- 가격정책 상세 등록 팝업창 끝 -->






			<!-- begin section-container
			<div class="section-container inbox">
			<h5 class="ml10 mt20">ㆍ가격정책 정보</h5>
				<div class="tableB">
					<table>
						<colgroup>
					 		<col width="20%">
					 		<col width="80%">
					 	</colgroup>
						<tbody>
							<tr>
								<td class="cen height-40">적용일자</td>
								<td>
									<div class="col-md-6">
										<p class="form-control-static f14 fb lh34 p0">${getBillPolicyView.applyDate}</p>
									</div>
								</td>
							</tr>
							<tr>
								<td class="cen height-40">정책이름</td>
								<td>
									<div class="col-md-6">
										<p class="form-control-static f14 fb lh34 p0">${getBillPolicyView.policyName}</p>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row tac mt20">
				 <button type="button" class="btn btn-primary width-80" onclick="billpolicycopy();">복사</button>
				 <button type="button" class="btn btn-lime width-80" onclick="billpolicyedit();">수정</button>
				 <button type="button" class="btn btn-danger width-80" onclick="billpolicydelchk();">삭제</button>
				 <button type="button" class="btn btn-grey width-80" onclick="billpolicylist();">목록</button>
			</div>
			-->

			<%--
			<h5 class="ml10 mt20">ㆍ과금항목 정보</h5>

			<!-- 테이블시작 -->
			<div class="col-md-12">
				<div class="panel">
				    <div class="table-responsive">
				    	<table class="table table-bordered table-hover table-striped table-td-valign-middle">
							<colgroup>
								<col width="*">
								<col width="10%">
								<col width="10%">
								<col width="15%">
								<col width="15%">
								<col width="10%">
							</colgroup>
							<thead>
							    <tr class="primary">
							    	<th class="tac">과금항목명</th>
									<th class="tac">수량</th>
									<th class="tac">단위</th>
									<th class="tac">시간단위가격</th>
									<th class="tac">월단위가격</th>
									<th class="tac">수정</th>
							    </tr>
							</thead>
							<tbody>
								<c:forEach items="${getBillItemList}" var="getBillItemList" varStatus="status" >
								<tr>
									<td>
										${getBillItemList.itemName}
									</td>
									<td>
										${getBillItemList.quantity}
									</td>
									<td>
										${getBillItemList.unit}
									</td>
									<td>
										<fmt:formatNumber value="${getBillItemList.hourlyPrice}" pattern="#,###"/> 원
									</td>
									<td>
										<fmt:formatNumber value="${getBillItemList.monthlyPrice}" pattern="#,###"/> 원
									</td>
									<td class="ditailStyle tac">
										<button type="button" class="btn btn-default" onclick="saveConfirm();">수정</button>
									</td>
								</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- 테이블 끝 -->

				<div class="row tac mt20">
					<button type="button" class="btn btn-primary_05" onclick="billitemwrite();">과금항목 등록</button>
				</div> --%>

			</div>

			<!-- end page-body -->
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

    function moveInsertPage(){
		$("#modal-dialog-insert").modal();
    }

	//************** 과금항목 수정 관련 Start **************
	function moveEditPage(policySeq,itemId,itemName,quantity,unit,hourlyPrice,monthlyPrice){

		var now = new Date();
 		var nowYear = now.getFullYear();
 		var nowMonth = now.getMonth()+1;
 		if((nowMonth+"").length < 2){
 			nowMonth = "0"+nowMonth;
 		}
 		var nowDate = now.getDate();
 		if((nowDate+"").length < 2){
 			nowDate = "0"+nowDate;
 		}
 		var today = nowYear+ "" + nowMonth + "" + nowDate;
 		var applyDate = "${getBillPolicyView.applyDate}";
 	 	applyDate = applyDate.replace("-", "");
 		applyDate = applyDate.replace("-", "");

 		if(applyDate < today){
 			alertBox3("현재일 이전의 가격정책은 수정할 수 없습니다.");
 			return false;
 		}else{
			$('#policySeq').val(policySeq);
			$('#itemId').val(itemId);
			$('#itemName').val(itemName);
			$('#quantity').val(quantity);
			$('#unit').val(unit);
			$('#hourlyPrice').val(hourlyPrice);


			$('#monthlyPrice').val(Math.floor(monthlyPrice));
			$('#itemNameText').html(itemName);
			$('#quantityText').html(quantity + unit);
			$("#modal-dialog-edit").modal();
 		}
	}
	// 과금항목 수정 confirm
	function saveConfirm(){
		confirmBox("저장하시겠습니까?", billitemedit);
 	}
	// 과금항목 수정 action
	function billitemedit(){
		if($("#hourlyPrice").val()==""){
			alertBox3("시간단위 가격을 입력하세요");
			$("#hourlyPrice").focus();
			return false;
		}
		if($("#monthlyPrice").val()==""){
			alertBox3("월단위 가격을 입력하세요");
			$("#monthlyPrice").focus();
			return false;
		}

		var jsonData = policyjsonData();
		$.ajax({
			url : "${contextPath}/mng/bill/policy/billitemeditok",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				if(data==1){
					alertBox("수정되었습니다.",movePage);
				}else{
					alertBox("수정이 실패하였습니다.");
				}

			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	// 과금항목 수정 데이터
	function policyjsonData(){

		var jsonData = {
				"itemName" : $("#itemName").val()
				, "itemId": $("#itemId").val()
				, "quantity": $("#quantity").val()
				, "unit": $("#unit").val()
				, "hourlyPrice": $("#hourlyPrice").val().replace(/,/gi,"")
				, "monthlyPrice": $("#monthlyPrice").val().replace(/,/gi,"")
				, "policySeq": $("#h_policySeq").val()
				};
		return jsonData;
	}


	//************** 과금항목 수정 관련 End **************




	function billpolicycopy(){
		location.href = "${contextPath}/mng/bill/policy/billPolicyCopy?policySeq="+${getBillPolicyView.policySeq};
	}

	function billpolicyedit(){
 		location.href = "${contextPath}/mng/bill/policy/billPolicyEdit?policySeq="+${getBillPolicyView.policySeq};
 	}

	function billpolicylist(){
 		location.href = "${contextPath}/mng/bill/policy/billPolicyList";
 	}

 	function billitemwrite(){
 		location.href = "${contextPath}/mng/bill/policy/billItemWrite?policySeq="+${getBillPolicyView.policySeq};
 	}

	function reload(){
 		location.reload();
 	}
 	/*
 	function billitemedit(policySeq,itemId){
 		//location.href = "${contextPath}/mng/bill/policy/billItemWrite?policySeq="+${getBillPolicyView.policySeq};
 		$("#policySeq").val(policySeq);
 		$("#itemId").val(itemId);
 		//alertBox3($("#policySeq").val());
 		//alertBox3($("#itemId").val());
 		$("#policyitemedit").submit();
 	}
 	 */



 	//************** 가격정책 삭제 관련 Start **************

 	function billpolicydelchk(){

 		var now = new Date();
 		var nowYear = now.getFullYear();
 		var nowMonth = now.getMonth()+1;
 		if((nowMonth+"").length < 2){
 			nowMonth = "0"+nowMonth;
 		}
 		var nowDate = now.getDate();
 		if((nowDate+"").length < 2){
 			nowDate = "0"+nowDate;
 		}
 		var today = nowYear+ "" + nowMonth + "" + nowDate;
 		var applyDate = "${getBillPolicyView.applyDate}";

 		applyDate = applyDate.replace("-", "");
 		applyDate = applyDate.replace("-", "");

 		if(applyDate < today){
 			alertBox3("현재일 이전의 가격정책은 <br>삭제할 수 없습니다.");
 			return false;
 		}else{
 			confirmBox("삭제하시겠습니까?.",billPolicyDelchkok);
 		}

 	}

 	function billPolicyDelchkok(){
//  		$.ajax({
// 			url : "${contextPath}/mng/bill/policy/billPolicyDelchkok",
// 			dataType : "JSON",
// 			type : "POST",
// 			data : {
// 				policySeq: '${getBillPolicyView.policySeq}'
// 				,applyDate: '${getBillPolicyView.applyDate}'
// 			},
// 			success : function(data) {
// 				var result = data;
// 				if(result=1){
// 					alertBox("삭제 되었습니다.",billpolicylist);
// 				}else{
// 					alertBox("삭제가 실패되었습니다.",billpolicylist);
// 				}
// 			},
// 			error : function(request, status, error) {
// 				alertBox3("code:" + request.status + "\n" + "error:" + error);
// 			}
// 		});
 		$.ajax({
			url : "${contextPath}/mng/bss/catalog/delete",
			dataType : "JSON",
			type : "POST",
			data : {
				catalogSeq: '${getBillPolicyView.policySeq}'
			},
			success : function(data) {
				var result = data;
				if(result=1){
					alertBox("삭제 되었습니다.",moveListPage);
				}else{
					alertBox("삭제가 실패되었습니다.",moveListPage);
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
 	}
 	//************** 가격정책 삭제 관련 End **************


 	//************** 가격정책 복사 관련 Start **************

 	//복사하기
	function moveCopyPage(catalogSeq){
			//location.href = "${contextPath}/mng/bss/catalog/catalogCopy?catalogSeq="+catalogSeq;
		$("#modal-dialog-copy").modal();
	}
 	// Copy check
 	function saveCheck(){
		if($("#copy_policyName").val()==""){
			alertBox3("정책이름을 입력하세요");
			$("#copy_policyName").focus();
			return false;
		}
		confirmBox("등록하시겠습니까?", billpolicywrite);
	}
	// Copy action
	function billpolicywrite(){
		$.ajax({
			//url : "${contextPath}/mng/bill/policy/billPolicyWriteok",
			url : "${contextPath}/mng/bss/catalog/insert",
			dataType : "JSON",
			type : "POST",
			data : {
				"catalogName": $("#copy_policyName").val()+" 카탈로그"
				, "policyName": $("#copy_policyName").val()
				, "beforeCatalogSeq": $("#h_policySeq").val()
				, "cloudId" : "${getBillPolicyView.cloudId}"
				, "applyDate" : "9999-12-31"
				, "regUserId" : "${userId}"
				, "modUserId" : "${userId}"
			},
			success : function(data) {
				if(data==1){
					alertBox("복사 되었습니다.", moveListPage);
				}else if(data==0){
					alertBox3("정책일자가 중복되었습니다.<br /> 기존에 등록된 정책일자가 존재하여 복사할 수 없습니다.");
				}else{
					alertBox3("등록이 실패하였습니다.");
				}
					},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

 	//************** 가격정책 복사 관련 End **************


 	//************** 가격정책 수정 관련 Start **************
 	function moveUpdatePage(){
 		var now = new Date();
 		var nowYear = now.getFullYear();
 		var nowMonth = now.getMonth()+1;
 		if((nowMonth+"").length < 2){
 			nowMonth = "0"+nowMonth;
 		}
 		var nowDate = now.getDate();
 		if((nowDate+"").length < 2){
 			nowDate = "0"+nowDate;
 		}
 		var today = nowYear+ "" + nowMonth + "" + nowDate;
 		var applyDate = "${getBillPolicyView.applyDate}";
 	 	applyDate = applyDate.replace("-", "");
 		applyDate = applyDate.replace("-", "");

 		if(applyDate < today){
 			alertBox3("현재일 이전의 가격정책은 <br>수정할 수 없습니다.");
 			return false;
 		}else{
			$("#modal-dialog-update").modal();
 		}
	}
 	// Modify check
 	function modySaveCheck(){
 		var now = new Date();
 		var year = now.getYear();
 		var month = now.getMonth() + 1;
 		if ((month + "").length < 2) {month = "0" + month;}

		if($("#modify_applyDate").val()==""){
			alertBox3("적용일자를 입력하세요");
			$("#modify_applyDate").focus();
			return false;
		}
		if($("#modify_applyDate").val()<=(year +"-" + month)){
			alertBox3("적용일자는 익월부터 가능합니다");
			$("#modify_applyDate").focus();
			return false;
		}
		if($("#modify_policyName").val()==""){
			alertBox3("정책이름을 입력하세요");
			$("#modify_policyName").focus();
			return false;
		}

		confirmBox("저장하시겠습니까?", modifyPolicyEdit);

	}
	// Modify action
	function modifyPolicyEdit(){

		var jsonData = ModifyPolicyjsonData();
		$.ajax({
			//url : "${contextPath}/mng/bill/policy/billPolicyEditok",
			url : "${contextPath}/mng/bss/catalog/catalogUpdate",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				if(data==1){
					alertBox("수정되었습니다.", movePage);
				}else{
					alertBox3("적용일자가 중복되었습니다.");
					// alertBox3("수정이 실패하였습니다.");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	// Set Modify data
	function ModifyPolicyjsonData(){

		var jsonData = {
				"applyDate" : $("#modify_applyDate").val()+"-01"
				, "policyName": $("#modify_policyName").val()
				, "catalogSeq": $("#h_policySeq").val()
				, "catalogName": ""
				, "regUserId" : "${userId}"
				, "modUserId" : "${userId}"
				};
		return jsonData;
	}
	//************** 가격정책 수정 관련 End **************

 	// 목록페이지 이동
 	function moveListPage(){
 		location.href="${contextPath}/mng/bill/policy/billPolicyList";
 	}
 	// 상세페이지 이동
 	function movePage(){
		var policySeq = $("#h_policySeq").val();
		location.href="${contextPath}/mng/bill/policy/billPolicyView?policySeq="+policySeq;
	}
    //가격정책 적용
	function movePage(){
		var policySeq = $("#h_policySeq").val();
		location.href="${contextPath}/mng/bill/policy/billPolicyView?policySeq="+policySeq;
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

	function monthCalendar(){
		var currentYear = (new Date()).getFullYear();
		var currentMonth = (new Date()).getMonth();
	    var options = {
	    		selectedMonth : currentMonth+1,
	    		startYear: currentYear,
	            finalYear: currentYear+10,
	            pattern: 'yyyy-mm',
	            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']

	    };

	    $('.applyDate').monthpicker(options);
	    $('#applyDateBtn').bind('click', function () {
			$('#modify_applyDate').monthpicker('show');
		});
	}




	//************** 과금항목 insert start **************

	// 과금항목 수정 confirm
	function insertConfirm(){
		confirmBox("저장하시겠습니까?", billitemInsert);
 	}
	// 과금항목 수정 action
	function billitemInsert(){

		if($("#insertUnit option:selected").val()==""){
			alertBox3("unit을 선택하세요.");
			$("#modify_applyDate").focus();
			return false;
		}
		if($("#insertItemCategory option:selected").val()==""){
			alertBox3("itemCategory를 선택하세요.");
			$("#modify_applyDate").focus();
			return false;
		}
		if($("#insertItemId").val()==""){
			alertBox3("itemId를 입력하세요");
			$("#modify_applyDate").focus();
			return false;
		}
		if($("#insertItemName").val()==""){
			alertBox3("itemName를 입력하세요");
			$("#modify_applyDate").focus();
			return false;
		}
		if($("#insertHourlyPrice").val()==""){
			alertBox3("hourlyPrice를 입력하세요");
			$("#modify_applyDate").focus();
			return false;
		}
		if($("#insertMonthlyPrice").val()==""){
			alertBox3("monthlyPrice를 입력하세요");
			$("#modify_applyDate").focus();
			return false;
		}

		var jsonData = insertJsonData();
		$.ajax({
			url : "${contextPath}/mng/bill/policy/billitemeInsert",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				if(data==1){
					alertBox("저장 되었습니다.",movePage);
				}else{
					alertBox("저장이 실패하였습니다.");
				}

			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	// 과금항목 수정 데이터
	function insertJsonData(){

		var jsonData = {
				  "cloudId" : $("#insertCloudId").val()
				, "itemId": $("#insertItemId").val()
				, "itemName": $("#insertItemName").val()
				, "unit": $("#insertUnit option:selected").val()
				, "quantity": $("#insertQuantity").val()
				, "itemCategory": $("#insertItemCategory option:selected").val()
				, "hourlyPrice": $("#insertHourlyPrice").val()
				, "MonthlyPrice": $("#insertMonthlyPrice").val()
				, "policySeq": $("#h_policySeq").val()
				};

		$("#searchKind option:selected").val();

		return jsonData;
	}
	function excelDown(){
		var params = "";
		params += "&policySeq="+$("#h_policySeq").val();

		location.href = '${contextPath}/mng/bill/policy/viewExcel?'+params;
	}


	//************** 과금항목 insert end **************


	$(document).ready(function() {

		App.init();
		//gridList();
		//calendar();
		monthCalendar();

		//메뉴활성화
		$("#productAservice").addClass("active");
		$("#billPolicy").addClass("active");
	});
</script>
</body>
</html>