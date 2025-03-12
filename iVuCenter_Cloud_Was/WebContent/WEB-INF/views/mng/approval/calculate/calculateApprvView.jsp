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

		<!-- begin #content -->
		<div id="content" class="content">

			<!-- begin header -->
			<div class="page_header mb30">
				<h1>정산 승인 상세</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">작업 승인 처리</a><a href="#" class="on">정산 승인</a>
				</div>
			</div>
			<!-- end header -->


			<!-- begin page-body -->
			<div class="row pb50">


				<div class="gridTableWrap gridType02 m-b-40">
					<div class="btnArea tar">
						<a type="button" class="btnType01" onclick="excelDown();"><i class="ico_download"></i><span>다운로드</span></a>
					</div>
					<h2 class="titleBuType01 m-b-15">고객사별 청구요금</h2>
					<span class="flr f14 fc33 m-t-10">금액( 단위 : 원 )/부가가치세별도</span>
					<!-- 그리드 영역 -->
					<div class="tableWrap">
						<table id="calculateDetailTable" style="border-bottom: 0px none; ">
							<colgroup>
								<col width="226px">
								<col width="113px">
								<col width="130px">
								<col width="129px">
								<col width="124px">
								<col width="124px">
								<col width="129px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">customerID</th>
									<th scope="col">고객사</th>
									<th scope="col">청구년월</th>
									<th scope="col">사용금액</th>
									<th scope="col">요금할인</th>
									<th scope="col">보정</th>
									<th scope="col">부가가치세</th>
									<th scope="col">청구금액</th>
								</tr>
							</thead>
							<tbody class="h60">
								<!-- <tr>
									<td class="tal p-l-30">리뷰회원사</td>
									<td class="fontVdn tac">2017-12</td>
									<td class="fontVdn tar p-r-15">122,235,421</td>
									<td class="fontVdn tar p-r-15">-20,881</td>
									<td class="fontVdn tar p-r-15">0</td>
									<td class="fontVdn tar p-r-15">0</td>
									<td class="fontVdn tar p-r-15">122,235,421</td>
								</tr>
								<tr>
									<td class="tal p-l-30">리뷰</td>
									<td class="fontVdn tac">2017-12</td>
									<td class="fontVdn tar p-r-15">35,421</td>
									<td class="fontVdn tar p-r-15">-20,881</td>
									<td class="fontVdn tar p-r-15">0</td>
									<td class="fontVdn tar p-r-15">0</td>
									<td class="fontVdn tar p-r-15">20,881</td>
								</tr> -->
							</tbody>
						</table>
					</div>
				</div>
						<input type="hidden" id="orderNo" value="${orderNo}">
						 <input type="hidden" id="userId" value="${userId}">
						 <input type="hidden" id="inject" value="${inject}">
						 <input type="hidden" id="stepId" value="${stepId}">
						 <input type="hidden" id="userApprvState" value="${userApprvState}">
				<c:if test="${getProjectAppSteplist.size() ne '0'}">
				<h2 class="titleBuType01 m-b-15">승인정보</h2>
				<div class="processingArea">
					<div class="processBox">

						<ul>


						<c:if test="${getProjectAppSteplist.size() ne '0'}">
						<c:forEach items="${getProjectAppSteplist}" var="getProjectAppSteplist" varStatus="status" >
						<c:forEach items="${approvalUserId}" var="approvalUserId" varStatus="status1" >
								<c:if test="${getProjectAppSteplist.stepId == approvalUserId.stepId}">
									<c:if test="${toolvalue ne '' }">
										<c:set value="${toolvalue}<br> ${approvalUserId.userId}" var="toolvalue"/>
									</c:if>
									<c:if test="${toolvalue eq '' }">
										<c:set value="${approvalUserId.userId}" var="toolvalue"/>
									</c:if>
								</c:if>
							</c:forEach>
						<li><strong><c:out value="${getProjectAppSteplist.stepName}"></c:out></strong>

						<c:choose>
					   			<c:when test="${getProjectAppSteplist.apprvState eq 'APPRV_PROCESSING' }">

									<c:out value="${apprvState1}" />
<%-- 										<c:if test="${status.last eq 'false'}"> --%>
										<div class="box box_ing">
										<span>승인처리중</span>
										</div>
<%-- 										</c:if> --%>

								</c:when>
								<c:when test="${getProjectAppSteplist.apprvState eq 'APPRV_COMPLETED'  }">
								<!-- <button type="submit" class="${apprvStatestyle}" > -->


										<c:out value="${apprvState2}" />
										<div class="box box_finish">
										<span>승인완료</span>
										</div>
										<span class="date"><c:out value="${getProjectAppSteplist.apprvDatetime}" /></span>

								</c:when>
								<c:when test="${getProjectAppSteplist.apprvState eq 'APPRV_REJECTED'  }">

										<c:out value="${apprvState3}" />
										<div class="box box_reject">
										<span>승인반려</span>
										</div>
										<span class="date"><c:out value="${getProjectAppSteplist.apprvDatetime}" /></span>
								</c:when>

								<c:when test="${getProjectAppSteplist.stepLevel eq 1}">
										<c:out value="${apprvState3}" />
										<div class="box box_request">
										<span>승인요청</span>
										</div>
										<span class="date"><c:out value="${getProjectAppSteplist.apprvDatetime}" /></span>
								</c:when>

								<c:otherwise>

										<c:out value="${apprvState4}" />
										<div class="box box_ready">
										<span>승인대기</span>
										</div>

								</c:otherwise>
							</c:choose>
						</li>
						</c:forEach>


						</c:if>
							<!-- <li>
								<strong>신청자</strong>
								<div class="box box_request">
									<span>승인요청</span>
								</div>
								<span class="date">2017-09-18 16:40</span>
							</li>
							<li>
								<strong>1차 승인자</strong>
								<div class="box box_ing">
									<span>승인처리중</span>
								</div>
								<span class="date">2017-09-18 16:40</span>
							</li>
							<li>
								<strong>2차 승인자</strong>
								<div class="box box_finish">
									<span>승인완료</span>
								</div>
								<span class="date">2017-09-18 16:40</span>
							</li>
							<li>
								<strong>기획담당자</strong>
								<div class="box box_reject">
									<span>승인반려</span>
								</div>
								<span class="date">2017-09-18 16:40</span>
							</li>
							<li>
								<strong>회계담당자</strong>
								<div class="box box_ready">
									<span>승인대기</span>
								</div>
							</li>  -->
						</ul>
					</div>
					<!--  반려사유  -->


				<c:if test="${getProjectAppSteplist.size() ne '0'}">
				<c:forEach items="${getProjectAppSteplist}" var="getProjectAppSteplist" varStatus="status" >
					<c:choose>
					<c:when test="${getProjectAppSteplist.apprvState eq 'APPRV_REJECTED'  and getProjectAppSteplist.stepLevel > 1}">
					<div class="rejectCause">
						<dl>
							<dt>반려사유</dt>
							<dd><c:out value="${getProjectAppSteplist.apprvDescription}"></c:out></dd>
						</dl>
						<p>반려단계 : <span><c:out value="${getProjectAppSteplist.stepName}"></c:out></span></p>
							</div>
					</c:when>
					</c:choose>
					</c:forEach>
					</c:if>
				</div>

			</c:if>
				<c:if test="${getProjectAppSteplist.size() ne '0'}">
				<c:forEach items="${getProjectAppSteplist}" var="getProjectAppSteplist" varStatus="status" >
					<c:choose>
						<c:when test="${getProjectAppSteplist.apprvAuth eq 'N'}">
							<c:choose>
								<c:when test="${getProjectAppSteplist.billMasterApprvStat eq 'APPRV_PROCESSING'}">
<!-- 									<textarea class="form-control" rows="5" placeholder="비고란 입니다. 내용을 입력하세요" name="apprvDescription" id="apprvDescription"></textarea> -->
									<div class="row tac mt50">
										<a type="button" class="btnType03 btnType03_submit"  onclick="apprvConfirm('${getProjectAppSteplist.stepLevel}','${orderNo}','${getProjectAppSteplist.rightStepId}')">승인</a>
<%-- 										<a type="button" class="btnType03 btnType03_reject m-l-15" onclick="rejectConfirm('${getProjectAppSteplist.stepLevel}','${orderNo}','${getProjectAppSteplist.rightStepId}')">반려</a> --%>
										<a type="button" class="btnType03 btnType03_reject m-l-15" onclick="rejectApprovalPopup('${getProjectAppSteplist.stepLevel}','${orderNo}','${getProjectAppSteplist.rightStepId}')">반려</a>
										<a type="button" class="btnType03 btnType03_list m-l-15" onclick="moveListPage()">목록</a>
									</div>
								</c:when>
								<c:otherwise>
									<c:if test="${getProjectAppSteplist.billMasterApprvStat != 'APPRV_PROCESSING' and getProjectAppSteplist.stepId eq stepId }">
										<div class="row tac mt50">
											<a type="button" class="btnType03 btnType03_list" onclick="moveListPage()">목록</a>
										</div>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:if test="${getProjectAppSteplist.stepId eq stepId }">
							<div class="row tac mt50">
								<a type="button" class="btnType03 btnType03_list" onclick="moveListPage()">목록</a>
							</div>
							</c:if>
						</c:otherwise>
					</c:choose>
					<c:if test="${inject eq 'Y' and  getProjectAppSteplist.apprvState eq 'APPRV_REJECTED'}">
<!-- 						<h2 class="titleBuType01 m-t-40 m-b-15">반려사유</h2> -->
<%-- 						<textarea  rows="5" placeholder="비고란 입니다. 내용을 입력하세요" id="rejectedApprvDescription" name="rejectedApprvDescription" readonly >${getProjectAppSteplist.apprvDescription}</textarea>  --%>
						<div class="row tac mt50">
							<a type="button" class="btnType03 btnType03_list" onclick="moveListPage()">목록</a>
						</div>
					</c:if>
				</c:forEach>
				</c:if>
				<c:if test="${getProjectAppSteplist.size() eq '0'}">
					<div class="row tac mt50">
						<a type="button" class="btnType03 btnType03_list" onclick="moveListPage()">목록</a>
					</div>
				</c:if>



			</div>

			<!-- 반려사유 팝업 -->
			<div class="modal fade" id="modal-dialog-reject">
				<div class="modal-dialog">
					<div class="modal-content width-570">
						<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
							<h4 class="modal-title">반려 사유</h4>
						</div>
                       	<div class="modal-body">
							<div class="rejectInfo m-b-20">
								반려 사유를 상세하게 입력하여 주십시오.
							</div>
							<textarea style="height: 200px" rows="5" placeholder="반려 사유를 입력해주세요." id="apprvDescription" name="apprvDescription" ></textarea>
	                   	</div>
	                   	<div class="modal-footer tac">
                      			<a type="button" class="lbtn" id ="popclose" onclick="rejectConfirm();">확인</a>
                      			<a type="button" class="rbtn" data-dismiss="modal" id ="popclose">취소</a>
                       	</div>
	               	</div>
				</div>
                </div>


			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	// 정산 상세
	function gridList() {

		var billYyyymm = '${orderNo}' ;

		 $("#calculateDetailTable").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/approval/calculate/calApprovalDetail"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.billYyyymm = billYyyymm;
					d.stepId = $("#stepId").val();
				}
			}
		 	, "initComplete" : function(setting, json){
				if(json.recordsTotal == 0){
					$("#reqApprv").hide();
				}
			}
		 	,"columns":[
	        	{"data":"customerId", "class":"tac"}
	        	, {"data":"customerName", "class":"tal p-l-30"}
	        	, {"data":"billYyyymm", "class":"fontVdn tac"}
	        	, {"data":"A000Amount", "class":"fontVdn tar p-r-15"}
	        	, {"data":"E000Amount", "class":"fontVdn tar p-r-15"}
	        	, {"data":"I000Amount", "class":"fontVdn tar p-r-15"}
	        	, {"data":"LA00Amount", "class":"fontVdn tar p-r-15"}
	        	, {"data":"amount", "class":"fontVdn tar p-r-15"}
	        ]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0],"visible":false,"searchable":false }
				, {"targets":[2], "render": function(data,type,full){
						var date = full.billYyyymm;
						if(date==" "){
							return "";
						}else{
							return date.substring(0,4) + "-" + date.substring(4,6);
						}
					}
				}
				, {"targets":[3], "render": function(data,type,full){
					return addcomma(full.A000Amount);
					}
				}
				, {"targets":[4], "render": function(data,type,full){
					return addcomma(full.E000Amount);
					}
				}
				, {"targets":[5], "render": function(data,type,full){
					return addcomma(full.I000Amount);
					}
				}
				, {"targets":[6], "render": function(data,type,full){
					return addcomma(full.LA00Amount);
					}
				}
				, {"targets":[7], "render": function(data,type,full){
					return addcomma(full.amount);
					}
				}

			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top">rt<"bottom">',"oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {

					}
				}]
			}
		});
	}



	/* 승인 Start */

	// 승인조회
	function approvalSearch(){
		var yy = $("#billYear option:selected").val();
		var mm = $("#billMonth option:selected").val();
		var billYyyymm = yy+mm;
		location.href="${contextPath}/mng/approval/calculate/calApprovalDetailPage?billYyyymm="+billYyyymm;
	}


	// 승인 버튼 클릭
	function apprvConfirm(stepLevel,requestSeq,rightStepId){
		var apprvDescription = $("#apprvDescription").val();
		var jsonData = {
				"requestSeq" : $("#orderNo").val()
				,"stepLevel" :stepLevel
				,"rightStepId":rightStepId
				,"apprvDescription":apprvDescription
				,"orderUserId" : "${getOrderUserId.orderUserId}"
				,"apprvUserId" : "${userId}"
				,"apprvUserName" : "${userName}"
				,"stepId" : $("#stepId").val()
			};

		confirmBox2("승인 처리 하시겠습니까?",ajaxApprving,jsonData);
	}


	// 승인 action
	function ajaxApprving(jsonObj){
		$.ajax({
			url : "${contextPath}/mng/approval/calculate/stepUpdate",
			dataType : "JSON",
			type : "POST",
			data : jsonObj,
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("승인 처리가 완료 되었습니다." +"<br>"+ "처리 내용이 신청 담당자에게 메일, SMS, NH With를 통해 전달되었습니다.", moveViewPage);
				}else{
					alertBox("fail!!", moveViewPage);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	// reject gloval
	var rejectStepLevel = "";
	var rejectRequestSeq = "";
	var rejectRightStepId = "";

	function rejectApprovalPopup(stepLevel,requestSeq,rightStepId){
		$("#modal-dialog-reject").modal();
		rejectStepLevel = stepLevel;
		rejectRequestSeq = requestSeq;
		rejectRightStepId = rightStepId;
	}


	//반려 유효성 체크
// 	function rejectConfirm(stepLevel,requestSeq,rightStepId){
	function rejectConfirm(){
		var apprvDescription = $("#apprvDescription").val();
		if($("#apprvDescription").val()==""){
			alertBox3("반려 사유를 입력해 주시기 바랍니다.");
			$("#apprvDescription").focus();
			return false;
		}
		var jsonData = {
				"requestSeq" : $("#orderNo").val()
				,"stepLevel" :rejectStepLevel
				,"rightStepId":rejectRightStepId
				,"apprvDescription":apprvDescription
				,"orderUserId" : "${getOrderUserId.orderUserId}"
				,"apprvUserId" : "${userId}"
				,"apprvUserName" : "${userName}"
				,"stepId" : $("#stepId").val()
			};

		confirmBox2("반려 처리 하시겠습니까?",apprvRejected,jsonData);
	}

	// 반려 action
	function apprvRejected(jsonObj) {

		$.ajax({
			url : "${contextPath}/mng/approval/calculate/stepRejectUpdate",
			dataType : "JSON",
			type : "POST",
			data : jsonObj,
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("반려 처리되었습니다.", moveViewPage)
				}else{
					alertBox3("fail!!");
					moveViewPage();
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	/* 승인 End */

	// 목록화면이동
	function moveListPage(){
		location.href="${contextPath}/mng/approval/calculate/calApprovalListPage";
	}

	// 새로고침
	function moveViewPage(){
		location.reload();
	}


	$(document).ready(function() {

		var billYm = "${billYyyymm}";
		var billY = billYm.substring(0,4);
		var billM = billYm.substring(4,6);
		$("#billYear").val(billY);
		$("#billMonth").val(billM);
		$("#h_billYyyymm").val(billYm);

		var yy = $("#billYear option:selected").val();
		var mm = $("#billMonth option:selected").val();

		gridList();
		App.init();
		//메뉴활성화
		$("#req").addClass("active");
		$("#calcApprv").addClass("active");


	});

</script>

</body>
</html>