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
		
		<!-- begin #content -->
		<div id="content" class="content">
			
			
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>결재 단계 관리</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">정책관리</a><a href="#" class="on">권한 관리</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- start cloud -->
			 <input type="hidden" id="h_cloudSearchId" value="${getCloudList[0].cloudId}">
			 <input type="hidden" id="stepTypeCount" value="">
	              <ul class="nav nav-pills ml-10 mb10" id="tabNavi">
			    <c:forEach items="${getCloudList}" var="getCloudList" varStatus="status" >
	                  <li class="ml10" id='${getCloudList.cloudId}'><a href="#nav-pills-tab-2" data-toggle="tab"  onclick="cloudSearchId('${getCloudList.cloudId}');">${getCloudList.cloudName}</a></li>
				</c:forEach>
		      </ul>
			<!-- end cloud -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<!-- search begin -->
		<!-- 		<div class="page_searchBox m-b-15">
					<div class="searchArea">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="searchKind">ID</label>
							<select class="search-sel" id="searchKind">
								<option value="user_id">ID</option>
								<option value="user_name">사용자명</option>				
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 450px">
							<a type='button' class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</a>
						</div>
					</div>
				</div> -->
				<!-- search end -->
				
				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a type="button" class="bton-s bton_blue" onclick="openApproveLineModal();"><i class="fa fa-upload"></i><span> 등록</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
					<div class="tableWrap gridType01_bType">
						<table id="table-list">
							
							 <colgroup>
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="*">
								<col width="20%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th >클라우드</th>
									<th >순서</th>
									<th >결재Type명</th>
									<th >결재단계명</th>
									<th >결재단계코드</th>
									<th >삭제</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			
			       <div class="modal fade" id="approveLine-modal-dialog">
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">결재 단계 입력</h4>
	                       	</div>
	                       	<div class="modal-body">
	                       		<div class="formType01">

									<div class="tblWrap clearfix">
										<table>
											<colgroup>
												 <col width="168px">
												 <col width="332px">
											</colgroup>
											<tbody>
												
												<tr>
													<th scope="row"><strong>클라우드</strong></th>
													<td class="tal">
														<input type="text" readonly="readonly" style="width:100%" id="insertCloudId" class="tar fontVdn"  value="${getCloudList[0].cloudId}" "/>
													</td>
												</tr>

												<tr>
													<th scope="row"><strong>순서</strong></th>
													<td class="tal">
														<input type="text" readonly="readonly" style="width:100%" value="" id="insertStepLevel" class="tar fontVdn"  onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this); "/>
													</td>
												</tr>

												<tr>
													<th scope="row"><strong>결재단계코드</strong></th>
													<td class="tal">
														<input type="text" style="width:100%" value="" id="insertStepId" class="tar fontVdn""/>
													</td>
												</tr>
												<tr>
													<th scope="row"><strong>결재단계명</strong></th>
													<td class="tal">
														<input type="text" style="width:100%" value="" id="insertStepName" class="tar fontVdn""/>
													</td>
												</tr>
										
											   <tr>
													<th scope="row"><strong>결재Type명</strong></th>
													<th><select class="" id="insertStepType" 	style="width: 100%">
															<option value="">결재Type명 을 선택하세요</option>
															<c:forEach items="${approveLineType}"
															
																var="approveLineType" varStatus="status">
																<option value="${approveLineType.codeId}">${approveLineType.codeName}</option>
															</c:forEach>
													</select></th>
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
			
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
			</div>
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>	
<script type="text/javascript">

	function cloudSearchId(cloudId){
		$("#h_cloudSearchId").val(cloudId);
		$("#insertCloudId").val(cloudId);
	    gridList();
	}
 	
	function gridList() {
		 $("#table-list").dataTable( {
				"processing":true
				,"autoWidth":false
				,"serverSide":true
				,"ordering" : false
				,"destroy" : true
				,"ajax": {
					"url":"${contextPath}/mng/operation/approveLine/list"
					,"type" : "GET"
					,"data":function (d) {
						d.searchKind = $("#searchKind option:selected").val();
						d.keyword = $("#keyword").val();
						d.cloudId = $("#h_cloudSearchId").val();
						
					}
				}
				,"columns":[ 
		        	  {"data":"cloudName", "class":"tac"}
		        	, {"data":"stepLevel", "class":"tal"}
		        	, {"data":"codeName", "class":"tal"}
		        	, {"data":"stepName", "class":"tal"}
		        	, {"data":"stepId", "class":"tal"}
		         	, {"class":"tac"}
				]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[5], "render":function(data,type,full){

					if(full.stepLevel == full.stepLevelMax){
						return '<a type="button" class="bton-s bton_blue" onclick="deleteApproveLine(\''+full.stepId+'\',\''+full.modelId+'\',\''+full.cloudId+'\');"><span class="bg_left"></span><span class="txt"><i class="fa fa-edit"></i> 삭제</span><span class="bg_right"></span></a>';
					}else{
						return '-';
					}
		          }
				}				
			]
			,"order": [[1,"asc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
	}
	
	function openApproveLineModal(){
		gridPopList();
		$("#approveLine-modal-dialog").modal();
	}
	
	var totalCnt = 0;
	
	function gridPopList(){
		$.ajax({
			url : "${contextPath}/mng/operation/approveLine/stepMaxValue",
			dataType : "JSON",
			data : {
				
				  "searchKind": $("#searchKindInsert option:selected").val()
				, "keyword"	: $("#keywordInsert").val()
				, "cloudId"	: $("#h_cloudSearchId").val()
			},
			success : function(data) {
				var result = data;

				$("#insertStepLevel").val(Number(result.approvalCount)+1);
				$("#stepTypeCount").val(Number(result.stepTypeCount));
				
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
	


 	//************** 결재 단계 관리  insert start **************

	// 과금항목 수정 confirm
	function insertConfirm(){
		confirmBox("저장하시겠습니까?", approveLineInsert);
 	}
	// 과금항목 수정 action
	function approveLineInsert(){

		/* if($("#insertUnit option:selected").val()==""){
			alertBox3("unit을 선택하세요.");
			$("#modify_applyDate").focus();
			return false;
		}
		if($("#insertItemId").val()==""){
			alertBox3("itemId를 입력하세요");
			$("#modify_applyDate").focus();
			return false;
		} */

		var jsonData = insertJsonData();
		$.ajax({
			url : "${contextPath}/mng/operation/approveLine/insert",
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



    function movePage(){
    	gridList();
    }
	
	function insertJsonData(){

		var jsonData = {
				  "cloudId" : $("#insertCloudId").val()
				  ,"stepId" : $("#insertStepId").val()
				  ,"stepName" : $("#insertStepName").val()
				  ,"stepLevel" : $("#insertStepLevel").val()
				  ,"stepType": $("#insertStepType option:selected").val()
				};

		return jsonData;
	}


	//************** 결재 단계 관리  insert end **************
	
	 	function deleteApproveLine(stepId, modelId, cloudId){
 		$.ajax({
			url : "${contextPath}/mng/operation/approveLine/delete",
			dataType : "JSON",
			type : "POST",
			data : {
				"stepId" : stepId
				,"modelId" : modelId
				,"cloudId" : cloudId
			},
			success : function(data) {
				alertBox("삭제되었습니다.", gridList);
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
	
	$(document).ready(function() {
		App.init();
		gridList();
		
		//메뉴활성화
 		$("#operation").addClass("active");
 		$("#approveLine").addClass("active");

 		//tab 첫번째 메뉴 활성화
		$(".nav-pills>li:first-child").addClass("active");

	});
</script>
</body>
</html>