<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="roles" property="principal.roles" />
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
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
			<!-- begin #header -->
			<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->
			<!-- begin #page-container > sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #page-container > content -->
			<div id="content" class="content">
				<!-- begin content > header -->
				<h1 class="page-header"><span class="root"> <span class="home"></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow"><a href="${wasPath}/mbr/project/vm/">자원이용현황</a></span><span class="text arrow mint"><a href="${wasPath}/mbr/project/vm/"><strong>기본자원(가상서버)</strong></a></span></span></h1>
				<!-- end content > header -->

				<!-- begin content > page-body -->
				<div class="row pb50">
					<form name="catalogueform"  id="catalogueform" action="${wasPath}/mbr/req/catalogue/catalogueLoadBalancer" method="post" >
					    <p class="page_title"><span class="stick">로</span>드밸런스 이용현황</p>
					    <input type ="hidden" id ="projectId" name="projectId" value="${req.projectId}">
						<input type ="hidden" id ="hid_loadbalancerId" name="loadbalancerId" value="${req.loadbalancerId}">
						<input type="hidden" name="loadbalancerName" id="hid_loadbalancerName">
						<input type ="hidden" id ="hid_projectName"  value="${req.projectName}">
						<input type ="hidden" id ="reqProjectSeq"  value="${req.programSeq}">
						<input type="hidden" name="apprvPass" id="apprvPass"				value="${apprvPass}" />
						<input type="hidden" name="selectApprv" id="selectApprv"			value="" />
						<input type ="hidden" id ="targetUuid"  >
						<input type ="hidden" id ="targetAct"  >
						<input type ="hidden" id ="vmUuid" name="vmUuid" >
						<input type="hidden" name="applyDatetime" id="applyDatetime" value="" />
						<input type="hidden" name="approvalStepListString" id="approvalStepListString" />
						<input type="hidden"  id="onDemandFlag" name="onDemandFlag" value="N" />
						<input type="hidden" id="ip" name="ip">
						<input type="hidden" id="port" name="port">
						<input type="hidden" id="protocol" name="protocol">
						<input type="hidden" id="method" name="method">
						<input type="hidden" id="loadbalancerProductSeq" name="loadbalancerProductSeq" />
						<input type="hidden" id="loadbalancerCatalogSeq" name="catalogSeq" />
						<input type="hidden" id="requestType" name="requestType" />

 						<!-- 프로젝트 정보 & 현재 사용용량 시작 -->
						<div class="viewbox mb20">
						    <!-- 프로젝트 상세정보 -->
						 	<div class="mt20">
						 		<span class="pid" id='loadbalancerName'></span>
							 	<span class="dpin fb fc-blue2 ml40">vip  : </span><span id="vip"></span>
							 	<span class="dpin fb fc-blue2 ml40">port  : </span><span id="vport"></span>
							 	<span class="dpin fb fc-blue2 ml40">프로토콜  : </span><span id="vprotocol"></span>
							 	<span class="dpin fb fc-blue2 ml40">method  : </span><span id="vmethod"></span>
						 	</div>
						</div>
						<!-- 프로젝트 정보 & 현재 사용용량 끝 -->

						<!-- 프로젝트 하위 상세 VM 리스트 시작 -->
						<h5 class="subtitle">가상서버</h5>
						<div class="btnArea tar mb5">
							<a type="button" onclick="openModal2();" class="bton-s bton_blue"><span> 추가</span></a>
						</div>
						<div class="gridTableWrap gridType02">
							<!-- 그리드 영역 -->
							<div class="tableWrap">
								<table id="VM-list">
									<colgroup>
										<col width="*">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="70px">
									</colgroup>
									<thead>
										<tr>
											<th>가상서버명</th>
											<th>클라우드</th>
											<th>ip</th>
											<th>vcpus</th>
											<th>memory</th>
											<th>disk</th>
											<th>삭제신청</th>
										</tr>
									</thead>
								</table>
							</div>

						</div>
						<!-- 프로젝트 하위 상세 VM 리스트 끝 -->

						<div class="tac m-t-40">
							<a type="button" class="bbton bton_dgrey ml10" onclick="moveListPage();"><span class="dpin dd bton_ddgrey ml-1"><i class="fa fa-list"></i></span><span class="dpin ml16">목록</span></a>
						</div>
					</form>
				</div>
				<!-- end content > page-body -->
			</div>
			<!-- end #page-container > content -->

			<!-- begin #page-container > footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #page-container > footer -->

			<!-- begin #page-container > modal -->
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
	             			<a type=button class="rbtn" data-dismiss="modal">취소</a>
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
			<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog2">
					<div class="modal-dialog width-720">
						<div class="modal-content width-720">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                        <h4 class="modal-title">가상서버 검색</h4>
							</div>
							<div class="modal-body">
								<!-- search begin -->
								<div class="col-md-12 bgee modalpop mb20">
									<div class="" style="text-align: center; display:inline-block;">
										<div class="col-md-1">
											<label class="selectText" for="billYear">서버명</label>
											<select class="search-sel" id="billYear" name="billYear">
												<option value="">서버명</option>
												<option value="2017">호스트명</option>
											</select>
										</div>
										<div class="col-md-6">
											<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="searchKeyword2" data-original-title="" title="">
										</div>
										<button type="button" class="btn_search2" onclick="gridVMList();"><span></span></button>
									</div>
								</div>
								<!-- search end -->
								<div>
									<table class="table table-bordered table-hover table-striped table-td-valign-middle" id="VM-list2">
										<colgroup>
											<col width="40%">
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
							</div>
							<div class="clear"></div>
							<div class="modal-footer tac">
	                   			<a type="button" class="lbtn" data-dismiss="modal" onclick="okVMInsert();">확인</a>
	                   			<a type="button" class="rbtn" data-dismiss="modal">취소</a>
							</div>
						</div>
               		</div>
				</div>
				<!-- 가상서버 검색 끝 -->
			</div>

		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">

		var approvalList = [];

		function gridList() {
			$("#VM-list").dataTable( {
				"processing": true
				,"autoWidth": false
				,"serverSide": true
				,"ordering": false
				,"destroy" : true
				,"ajax": {
					"url":"${contextPath}/mng/oss/loadbalancer/vmList"
					,"type" : "GET"
					,"data":function (d) {
						d.loadbalancerId = $("#hid_loadbalancerId").val();
					}
				}
				,"columns":[
					 {"data":"" , "class":"tac"}
					 ,{"data":"cloudName" , "class":"tac"}
					 ,{"data":"fixedIps" , "class":"tac"}
					 ,{"data":"vcpus" , "class":"tac"}
					 ,{"data":"memGb" , "class":"tac"}
					 ,{"data":"diskGb" , "class":"tac"}
					 ,{"data":"" , "class":"tac"}
				]
				,"columnDefs":[
					{"defaultContent" : "", targets:"_all" }
					,{"targets":[0], "render": function(data,type,full){
						return "<input type='hidden' name='vmUuid2' value='"+full.vmUuid+"''>"+full.hostnameAlias+"";
					}}
					,{"targets":[6], "render": function(data,type,full){
						return "<a class='MultiFile-remove' onclick='removeLoadbalanceVm(\""+full.vmUuid+"\",\""+$('#hid_loadbalancerId').val()+"\",\"REQTYPE_EXPR\")'></a>";
					}}
				]
				,"order": [[0,"desc"]]
				,"lengthMenu": [[10,15], [10, 15]]
				,"language": {
					"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
					, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:666; font-weight:bold;'>검색중입니다.</p></div>"

				}
				,"sDom":'<"top">rt<"bottom"ip>'
			});
			tblColorSet();
		}

		function getDetail() {

			$.ajax({
				url : "${contextPath}/mng/oss/loadbalancer/detail",
				dataType : "JSON",
				data : {
					"projectId" : $("#projectId").val()
					,"loadbalancerId" : $("#hid_loadbalancerId").val()
				},
				async : false,
				success : function(data) {
					delete data.length;
					$.each(data.data, function(i, val){
	                    //프로젝트 상세 ID 값 넣기
	                    $("#loadbalancerName").html(val['loadbalancerName']);
	                    $("#hid_loadbalancerName").val(val['loadbalancerName']);
						$("#ip").val(val['ip']);
						$("#port").val(val['port']);
						$("#protocol").val(val['protocol']);
						$("#method").val(val['method']);
						$("#loadbalancerCatalogSeq").val(val['loadbalancerCatalogSeq']);
						$("#loadbalancerProductSeq").val(val['loadbalancerProductSeq']);
						$("#vip").html(val['ip']);
						$("#vport").html(val['port']);
						$("#vprotocol").html(val['protocol']);
						$("#vmethod").html(val['method']);

					});
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
				}
			});
		}


			$(document).ready(function() {
				App.init();
				//프로젝트 상세정보 조회
				getDetail();
				gridList();
				//메뉴활성화
				$("#myGoods").addClass("active");
				$("#myLoadbalancer").addClass("active");
			});

			function moveDetailPage(projectId,loadbalancerId){
				var params = "?projectId="+projectId;
				params += "&loadbalancerId="+loadbalancerId;
				location.href = "${contextPath}/mbr/project/lb/detail"+params;
			}

			function removeLoadbalanceVm(vmUuid,loadbalancerId,type){
				hType = type;
				$("#requestType").val(type);
				$("#vmUuid").val(vmUuid);
				$("#loadbalancerId").val(loadbalancerId);
				if($("#apprvPass").val() == "Y"){
					confirmBox4("결재자를 지정하시겠습니까?",approvSelect,nApprovSelect);
				} else {
					approvSelect();
				}
			}
			function nApprovSelect(){
				$("#selectApprv").val("Y");
				if($("#requestType").val() == "REQTYPE_EXPR"){
					confirmBox("삭제 신청하시겠습니까?",removeLoadbalancerVm);
				}
				if($("#requestType").val() == "REQTYPE_CHANGE"){
					confirmBox("등록 신청하시겠습니까?",removeLoadbalancerVm);
				}
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

			function tblColorSet() {
				$('.gridType01 .tableWrap table thead th').each(function(index, item){
					$(item).addClass('th' + index);
				});
			}
			function noworder(){
				if( (approvalList[3] == undefined || approvalList[3] == null || approvalList[3] == '') && $("#selectApprv").val() == 'N') {
					alertBox3("결재자를 지정해 주세요");
					return false;
				}
				if($("#requestType").val() == "REQTYPE_EXPR"){
					confirmBox("삭제 신청하시겠습니까?",removeLoadbalancerVm);
				}
				if($("#requestType").val() == "REQTYPE_CHANGE"){
					confirmBox("등록 신청하시겠습니까?",removeLoadbalancerVm);
				}
			}
			function removeLoadbalancerVm(){
				$("#approvalStepListString").val(JSON.stringify(approvalList));
				var data = $("#catalogueform").serialize();
				$.ajax({
					url : "${contextPath}/mng/project/lb/catalogueLoadBalancer",
					dataType : "JSON",
					data : data,
					async : false,
					success : function(data) {
						if(data == "1"){
							alertBox("신청이 완료 되었습니다.", orderok2);
						} else {
							alertBox3("신청에 실패하였습니다.");
						}
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
					}
				});
			}

			function openModal2(){
				if($("#projectBoxId").val() == ""){
					alertBox3("프로젝트를 선택해주세요.");
					return false;
				}
				$("#modal-dialog2").modal();
				gridVMList();
			}

			// 팝업리스트
			function gridVMList(){
			   $("#VM-list2").dataTable( {
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${wasPath}/mbr/oss/vm/catalogueVmlist"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = "hostname_alias";
							d.keyword = $("#searchKeyword2").val();
							d.projectName = $("#projectName").val();
							d.projectId = $("#projectId").val();
							d.volumeType = $("#diskType").val();
						}
						,"dataSrc": function ( json ) {
							var list = new Array();
							var filterData = new Array();
						    $("input[name=vmUuid2]").each(function(index, item){
							    list.push($(item).val());
						    });
							$.each(json.data,function(index,item){
								if($.inArray(item.vmUuid,list) > -1){

								} else {
									filterData.push(item);
								}
							})
			      	        return filterData;
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
							return '<input type="button" class="popCheckbtn" value="&#xf00c" onclick="setVM(this, \''+full.vmUuid+'\',\''+full.hostnameAlias+'\',\''+full.hostname+'\',\''+full.cloudType+'\',\''+full.cloudName+'\',\''+full.cloudId+'\',\''+full.projectId+'\',\''+full.vcpus+'\',\''+full.memGb+'\',\''+full.diskGb+'\',\''+full.fixedIps+'\')">';
						}
					}
					]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
							, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
					}
					,"sDom":'<"top">rt<"bottom"pi>'
				});
			}

			var hprojectName, hprojectId, hprojectAlias, hvmUuid, hvmName, hvmHost,hcloudId,hcloudName,hcloudType,hprojectBoxId,hvCpus,hmemGb,hdiskGb,hfixedIps,hType;

			function setVM(e, vmUuid, vmName, vmHost,cloudType,cloudName,cloudId,projectId,vCpus,memGb,diskGb,fixedIps){
				$("#popListTable2 > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
				if($(e).hasClass("active")){
					hvmUuid = vmUuid;
					hvmName = vmName;
					hvmHost = vmHost;
					hcloudId = cloudId;
					hcloudType = cloudType;
					hcloudName = cloudName;
					hprojectId = projectId;
					hvCpus = vCpus;
					hmemGb = memGb;
					hdiskGb = diskGb;
					hFixedIps = fixedIps;
				} else {
					hvmUuid = "";
					hvmName = "";
					hvmHost = "";
					hcloudId = "";
					hcloudName = "";
					hcloudType = "";
					hprojectId = "";
					hvCpus = "";
					hmemGb = "";
					hdiskGb = "";
					hFixedIps = "";
				}
			}

			function okVMInsert(){
				hType = "REQTYPE_CHANGE";
				$("#vmUuid").val(hvmUuid);

				removeLoadbalanceVm(hvmUuid,$("#hid_loadbalancerId").val(),hType);
			}

			function orderok2(){
				location.href="${wasPath}/mbr/req/catalogue/bssOrderApproveList";
			}

		</script>
	</body>
</html>