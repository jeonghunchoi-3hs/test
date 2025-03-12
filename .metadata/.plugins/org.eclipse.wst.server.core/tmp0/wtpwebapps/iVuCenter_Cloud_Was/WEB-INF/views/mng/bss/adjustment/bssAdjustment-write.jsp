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
				<h1>보정 등록</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">요금 관리</a><a href="#" class="on">보정</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			 <div class="row pb50">
			 
			 	<div class="formType01">
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="166px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>고객사</strong></th>
									<td>
										<div class="cmmeditArea">
											<span class="dpin p-t-10" id="company"></span>
											<input type="hidden" id="customerId">
											<a type='button' class="btnType04 cmmeditBtn" style="width:70px;" onclick="moveSrchPage();"><span class="txt"><i class="ico_search"></i>검색</span></a>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>프로젝트명</strong></th>
									<td>
										<div class="cmmeditArea">
											<span class="dpin p-t-10" id="projectAlias"></span>
											<input type="hidden" id="projectId">
											<a type='button' class="btnType04 cmmeditBtn" style="width:70px;" onclick="moveSrchPrj();"><span class="txt"><i class="ico_search"></i>검색</span></a>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>청구년월</strong></th>
									<td>
										<div class="selectBox" style="width:220px;">
											<label class="selectText fontVdn"></label>
											<select class="search-sel" id="billYyyymm" name="billYyyymm">
												<c:forEach items="${getBillMasterYyyymmList}" var="list" varStatus="status" >
												<option value="${list.billYyyymm}">${fn:substring(list.billYyyymm,0,4)}-${fn:substring(list.billYyyymm,4,7)}</option>									  
												</c:forEach>		
											</select>
										</div>
										<p class="txt_guide_type01 dpin pull-right m-t-10">정산이 확정되었거나 승인진행중인 청구년월은 목록에서 제외됩니다</p>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>보정내역</strong></th>
									<td><input type="text" style="width:100%;" id="adjustContents"></td>
								</tr>
								<tr>
									<th scope="row"><strong>보정금액</strong></th>
									<td>
										<div class="selectBox" style="width:220px;">
											<label class="selectText txtBlue">+ (원)</label>
											<select class="search-sel" id="signtxt" name="signtxt" onchange="onchangeSigntxt(this)">
												<option value="1" class="txtBlue" selected="selected">+ (원)</option>
												<option value="2" class="txtRed">- (원)</option>
												<option value="3" class="txtBlue">+ (%)</option>
												<option value="4" class="txtRed">- (%)</option>
											</select>
										</div>
										<input type="text" style="width:514px;" class="fontVdn tar pull-right" id="adjustAmount">
									</td>
								</tr>
								<tr>
									<th scope="row" class="vaT p-t-15"><strong>비고</strong></th>
									<td>
										<textarea style="width:100%;height:100px;" id="description"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="row tac m-t-60">
					<a type="button" class="btnType03 btnType03_save" onClick="actInsert()">등록</a>
		 			<a type="button" class="btnType03 btnType03_cancel m-l-15" onClick ="movePage()">취소</a>
                </div>
                
				<div class="modal fade" id="modal-srch-dialog"> 
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">계열사 지정</h4>
	                       	</div>
	                       	<div class="modal-body">
	                       		<div class="page_searchBox m-b-15">
									<div class="searchArea">
										<div class="inputArea m-l-5">
											<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)actCompanyList();" style="width: 362px">
											<a type='button' class="btn_search" onclick="actCompanyList();">검색</a> 
										</div>
									</div>
								</div>
								
								<div class="noneList" style="display: none;">
									 <span>검색된 사용자가 없습니다.</span>
								</div> 
								
								<!-- <div class="listArea" id="popListTable"> -->
								<div class="listArea" id ="popBody">
	                      		</div>
	                      		<div class="totalcnt" id="totalCnt">총 0 건</div>
	                       		
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="whiteline" data-dismiss="modal" id ="popclose">닫기</a>
	                       </div>
		               	</div>
					</div>
	            </div>
                 
                 
                <div class="modal fade" id="modal-srch-copy"> 
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">프로젝트 검색</h4>
	                       	</div>
	                       	<div class="modal-body">
	                       		
	                       		<div class="page_searchBox m-b-15">
									<div class="searchArea">
										<div class="inputArea">
											<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword2" onkeypress="if(event.keyCode==13)actProjectList();" style="width: 360px">
											<a type="button" class="btn_search" onclick="actProjectList();">검색</a>
										</div>
									</div>
								</div>
								<div class="gridTableWrap gridType02">
									<!-- 그리드 영역 -->
									<div class="tableWrap">
										<div class="tblBox">
											<!-- 프로젝트 Case -->
											<table id="table-list">
												<colgroup>
													<col width="85%">
													<col width="15%">
												</colgroup>
												<thead>
													<tr>
														<th scope="col">프로젝트명</th>
														<th scope="col">적용</th>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								</div>
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="lbtn" onclick="selectPop2();">확인</a>
		                       <a type="button" class="rbtn" data-dismiss="modal">취소</a>
	                       </div>
		               	</div>
					</div>
	            </div>
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
	
	function actInsert(){
		if($("#adjustContents").val()==""){
			alertBox3("보정내역을 입력하세요");
			$("#adjustContents").focus();
			return false;
		}
		if($("#projectId").val()==""){
			alertBox3("프로젝트를 선택하세요");
			$("#projectName").focus();
			return false;
		}		
		if($("#adjustAmount").val()== "0" || $("#adjustAmount").val()== ""){
			alertBox3("보정금액을 입력하세요");
			$("#adjustAmount").focus();
			return false;
		}
				
		$.ajax({
			url : "${contextPath}/mng/bss/adjustment/insert",
			dataType : "JSON",
			type : "POST",
			data : {
				"billYyyymm" : $("#billYyyymm").val()     
				, "adjustContents": $("#adjustContents").val()
				, "adjustAmount": $("#adjustAmount").val() 
				, "description": $("#description").val() 
				, "projectId": $("#projectId").val() 
				, "projectName": $("#projectName").val() 
				, "projectAlias": $("#projectAlias").val()
				, "signtxt": $("#signtxt").val()
				, "regUserId" : '${userId}'
			},
			success : function(data) {			
				//alertBox3(data);
				if(data==1){
					alertBox("등록되었습니다.", movePage);
				}else{
					alertBox("등록이 실패하였습니다.", movePage);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	var pop2 = {
			projectId :""
			, projectAlias :""
	};
	
	function selectPop2(){
		$("#projectId").val(pop2.projectId);
		$("#projectAlias").text(pop2.projectAlias);
		$("#modal-srch-copy").modal('hide');
	}
	
	function popProjectSelect(e, projectId, projectAlias){
		$(".btn_check").removeClass("active"); 
		$(e).addClass("active"); 
		pop2.projectId = projectId;
		pop2.projectAlias = projectAlias;
	}
	
	function moveSrchPrj(catalogSeq){
		if($("#customerId").val() ==""){
			alertBox3("고객사를 선택해주세요."); 
			return false;
		}
		pop2.projectId = "";
		pop2.projectAlias = "";
		$("#modal-srch-copy").modal();
		actProjectList(); 
	}

	function actProjectList(){
		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/project/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = 'project_alias';
					d.keyword = $("#searchKeyword2").val();
					d.customerId = $("#customerId").val();
					d.length = 0;
				}
			}
			,"columns":[ 
				{"data":"projectAlias" , "class":"tal p-l-20" }
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" } 
				, {"targets":[1], "render": function(data,type,full){
						return '<a class="btn_check stop" type="button" onclick="popProjectSelect(this, \''+full.projectId+'\', \''+full.projectAlias+'\');"/>';
					}	
				}
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"lengthMenu": [[5], ['5']]
			,"sDom":'<"top">rt<"bottom"ip>' 
		});
	}
	
	
	
	function moveSrchPage(){
		$("#modal-srch-dialog").modal();
		actCompanyList();
	}
	
	function actCompanyList(){
		$.ajax({
			url : "${contextPath}/mng/cmm/company/list",
			dataType : "JSON",
			data : {
				"searchKind": "customer_name"
				, "keyword"	: $("#searchKeyword").val()
				, "length"	: 0
			},
			success : function(req) {
				$("#totalCnt").text("총 "+req.recordsTotal+"건");
				$("#popBody").empty();
				
				var vCss = "";
				$.each(req.data, function(key,val){
					if($("#customerId").val() == val.customerId ){
						vCss = "applybtn active";
					}else{
						vCss = "applybtn";
					}
					
					$("#popBody").append('<div class="listBg">'
											+'<span class="name2">'+val.upCompanyName+'</span>' 
											+'<span class="idlabel2">'+val.companyName+'</span>'
											+'<a class="'+vCss+'" onclick="popSelect(this, \''+val.customerId+'\', \''+(val.upCompanyName+" / "+val.companyName)+'\')">적용</a>'
										+'</div>');
				});
			}, 
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	function popSelect(e, customerId, company){
		$(".applybtn").removeClass("active"); 
		$(e).addClass("active"); 
		$("#customerId").val(customerId);
		$("#company").text(company);
	}
	
	function movePage(){
		location.href = "${contextPath}/mng/bss/adjustment/";
	}
	
	function onchangeSigntxt(e){
		$(e).siblings(".selectText").removeClass("txtRed");
		$(e).siblings(".selectText").removeClass("txtBlue");
		
		if($(e).val() == "1" || $(e).val() == "3"){
			$(e).siblings(".selectText").addClass("txtBlue");
		}else{
			
			$(e).siblings(".selectText").addClass("txtRed");
		}
	}
	
	$(document).ready(function() {
		App.init();
		$("#billYyyymm").siblings(".selectText").text($("#billYyyymm > option:selected").text());		
		
 		$("#adjustAmount").keyup(function(){ 
 			if(isNaN($(this).val())){
 				$(this).val("0");
 				alertBox3("숫자만 입력이 가능합니다.")
 			}
 		});
		
		//메뉴활성화
		$("#chargeManagement").addClass("active");
		$("#adjustment").addClass("active");
	});
	
</script>
</body>
</html>