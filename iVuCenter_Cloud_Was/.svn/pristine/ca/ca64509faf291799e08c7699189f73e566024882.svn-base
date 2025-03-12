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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
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
				<h1>발송</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">알림관리</a><a href="#" class="on">발송</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<h2 class="titleBuType01 fontVdn m-b-15">SMS</h2>
				
				<div class="formType01">
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="171px">
								 <col width="800px">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>발신자 이름</strong></th>
									<td><input type="text" style="width:100%;"></td>
								</tr>
								<tr>
									<th scope="row"><strong>발신자 번호</strong></th>
									<td><input type="text" style="width:100%;"></td>
								</tr>
								<tr>
									<th scope="row"><strong>수신 구분</strong></th>
									<td>
										<div class="cmmeditArea">
											<div class="optionBox p-t-10">
												<label><input type="radio" name="opt_radio01" data-original-title="" title=""><span>사용자</span></label>
												<label><input type="radio" name="opt_radio01" data-original-title="" title=""><span>고객사</span></label>
												<label><input type="radio" name="opt_radio01" data-original-title="" title=""><span>프로젝트</span></label>
											</div>
											<a type="button" class="btnType04 cmmeditBtn" style="width:70px;" onclick="moveSrchPage();"><span class="txt"><i class="ico_search"></i>검색</span></a>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>수신자</strong></th>
									<td>
										<div class="receiverList">
											<ul>
												<li>
													<strong class="catogory">사용자</strong>
													<p>정보시스템/솔루션사업부</p>
													<a type="button" class="btn_del">삭제</a>
												</li>
												<li>
													<strong class="catogory">고객사</strong>
													<p>솔루션사업부네트워크/관리자(010-1234-4432)</p>
													<a type="button" class="btn_del">삭제</a>
												</li>
												<li>
													<strong class="catogory">프로젝트</strong>
													<p>솔루션사업부/관리자</p>
													<a type="button" class="btn_del">삭제</a>
												</li>
												<li>
													<strong class="catogory">사용자</strong>
													<p>정보시스템/솔루션사업부</p>
													<a type="button" class="btn_del">삭제</a>
												</li>
												<li>
													<strong class="catogory">고객사</strong>
													<p>솔루션사업부네트워크/관리자(010-1234-4432)</p>
													<a type="button" class="btn_del">삭제</a>
												</li>
												<li>
													<strong class="catogory">프로젝트</strong>
													<p>솔루션사업부/관리자</p>
													<a type="button" class="btn_del">삭제</a>
												</li>
											</ul>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>메세지</strong></th>
									<td>
										<textarea style="width:100%;height:200px;"></textarea>
										<div class="smsByteArea">
											<div class="byte">( <span>70</span> / 80bytes ) </div>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="row tac m-t-60">
					<a type="button" class="btnType03 btnType03_send" onclick="actInsert();">발송</a>         
				</div>
				
				<div class="modal fade" id="modal-srch-copy"> 
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">수신자 선택</h4>
	                       	</div>
	                       	<div class="modal-body">
	                       		
	                       		<div class="page_searchBox m-b-15">
									<div class="searchArea">
										<div class="selectBox" style="width:100px;">
											<label class="selectText" for="searchKind">사용자명</label>
											<select class="search-sel" id="searchKind">
												<option value="">사용자명</option>			
											</select>
										</div>
										<div class="inputArea m-l-5">
											<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)openModal();" style="width: 250px">
											<a type="button" class="btn_search" onclick="openModal();">검색</a>
										</div>
									</div>
								</div>
								
								<div class="gridTableWrap gridType02">
									<!-- 그리드 영역 -->
									<div class="tableWrap">
										<div class="tblBox">
											<table id="">
												<colgroup>
													<col width="180px">
													<col width="240px">
													<col width="80px">
												</colgroup>
												<thead>
													<tr>
														<th scope="col">구분</th>
														<th scope="col">고객사명</th>
														<th scope="col">추가</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td class="tal p-l-30">쓰리에이치에스</td>
														<td class="tar p-r-20">솔루션사업부네트워크</td> 
														<td><a type="button" class="btn_add">추가</a></td>
													</tr>
													<tr>
														<td class="tal p-l-30">쓰리에이치에스</td>
														<td class="tar p-r-20">솔루션사업부네트워크</td> 
														<td><a type="button" class="btn_add on">추가</a></td>
													</tr>
													<tr>
														<td class="tal p-l-30">쓰리에이치에스</td>
														<td class="tar p-r-20">솔루션사업부네트워크</td> 
														<td><a type="button" class="btn_add on">추가</a></td>
													</tr>
													<tr>
														<td class="tal p-l-30">쓰리에이치에스</td>
														<td class="tar p-r-20">솔루션사업부네트워크</td> 
														<td><a type="button" class="btn_add on">추가</a></td>
													</tr>
													<tr>
														<td class="tal p-l-30">쓰리에이치에스</td>
														<td class="tar p-r-20">솔루션사업부네트워크</td> 
														<td><a type="button" class="btn_add">추가</a></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
	                       		
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="whiteline" data-dismiss="modal" id ="popclose">닫기</a>
	                       </div>
		               	</div>
					</div>
	            </div>
				
				
				<!-- begin col-12 -->
				<div class="col-md-12">
					<!-- begin panel -->
						<!-- begin normal input table---------->
						<div class="tableB mb20">
							<table>
								<colgroup>
									<col width="10%">
									<col width="40%">
									<col width="10%">
									<col width="40%">
								</colgroup>
								
								<tbody>
									<tr>
										<td class="cen height-40 tal">수신 구분</td>
									  	<td colspan="3">
										 	<div class="col-md-4"> 
										  		<input name="gubun" id="user" type="radio" checked="checked"  class="mt10" value="U"><span> 사용자</span> &nbsp;&nbsp;&nbsp;
										  		<input name="gubun" id="customer" type="radio"  value="C"> 고객사(전체발송)
										  	</div>
										  	<div class="col-md-6">
												<div>
													<button type="button" class="btn btn-grey" onclick="openModal();">검색</button>
												</div>
										  	</div>
									  	</td>
									</tr>
									<tr>
										<td class="cen height-40 tal">발신자 이름</td>
									  	<td colspan="3">
										 	<div class="col-md-6">
										  		<input class="form-control" type="text" id="senderName" value="${senderName}"/>
										  </div>
									  	</td>
									</tr>
									<tr>									  	
										<td class="cen height-40 tal">발신자 번호</td>
									  	<td colspan="3">
										 	<div class="col-md-6">
										  		<input class="form-control" type="text" id="senderNumber" value="${senderNumber}"/>
										  </div>
									  	</td>									  	
									</tr>
									<tr>
										<td class="cen height-40 tal">메세지</td>
									  	<td colspan="3">
											<div class="col-md-6">
												<textarea class="form-control" rows="10" id="message" placeholder="내용을 입력하세요" ></textarea>
										  	</div>
										</td>
									</tr>
<!-- 									<tr> -->
<!-- 										<td class="cen height-40">수신자</td> -->
<!-- 									  	<td colspan="3"> -->
<!-- 									  		<div class="col-md-6"> -->
<!-- 												<div> -->
<!-- 													<button type="button" class="btn btn-grey" onclick="openModal();">검색</button> -->
<!-- 												</div> -->
<!-- 						                       	<div id='divReceiverNumber' class="row"> -->
<!-- 						                       		<div id="receiverNumberList"></div> -->
<!-- 						                       	</div>												 -->
<!-- 										  	</div> -->
<!-- 										</td> -->
<!-- 									</tr> -->
									<!-- 
									<tr>
										<td class="cen height-40">수신자 이름</td>
									  	<td colspan="1">
										 	<div class="col-md-6">
										  		<input class="form-control" type="text" id="receiverName"/>
										  </div>
									  	</td>
										<td class="cen height-40">수신자 번호</td>
									  	<td colspan="1">
										 	<div class="col-md-6">
										  		<input class="form-control" type="text" id="receiverNumber"/>
										  </div>
									  	</td>									  	
									</tr>	 
									-->
																											
								</tbody>
							</table>	
						</div>
						<div class="tableB mb20">
							<table>
								<colgroup>
									<col width="50%">
									<col width="50%">
								</colgroup>
								<tr>
									<td class="cen height-40" id="sendUser">사용자
									</td>
									<td class="cen height-40" id="sendCustomer" style="display: none">고객사(전체발송)
									</td>
								</tr>
								<tr>
									<td>
										<div id='divReceiverNumber' class="row">
				                       		<div id="receiverNumberList"></div>
				                       	</div>
									</td>
								</tr>
							</table>
						</div>
						<!-- end normal input table---------->
					<!-- end panel -->

					
					<!-- begin button-->
					<div class="col-md-12 tac">
						<input type="button" id="btnModify" value="발송" class="btn btn-primary" onclick="actInsert()">
				        <!-- <input type="button" id="btnList" value="취소" class="btn btn-grey" onclick="moveListPage()"> -->
					</div>
					<!-- end button -->
				
				</div>
                <!-- end col-12 -->	

			</div>
			<!-- end page-body -->				
							
			<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">수신자 검색</h4>
	                       </div>
	                       <div class="modal-body">
		                       	<div class="row pb50">
									<!-- search begin -->
									<div class="col-md-12 bgee br10 mb10 ml10">		
										<div class="col-md-3 p10"> 
											<select class="form-control pb6" id="searchKind">
												<option value="user_name">사용자명</option>
												<option value="customer_name">고객사명</option>
												<option value="user_phone">전화번호</option>
											</select> 
										</div>
										<div class="col-md-6 p10">  <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)actSearch();"/></div>
										<div class="col-md-1 p10"><input type="button" class="btn btn-grey" value="검색" onclick="actSearch()"></div>
									</div>
										  
									<!-- 테이블시작 -->
									<div id="divTable1" class="col-md-12" style='display:none;'>
										<div class="panel">
										    <div class="table-responsive">
										        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="table1-list">
													<thead>
													    <tr class="primary">
															<th>고객사 이름</th>
															<th>고객사 아이디</th>
															<th>담당자 이름</th>
															<th>담당자 전화번호</th>
															<th>추가</th>
													    </tr>
													</thead>
												</table>
											</div>
										</div>			
									</div>
									<!-- 테이블 끝 -->								
	
									<!-- 테이블시작 -->
									<div id="divTable2" class="col-md-12" style='display:none;'>
										<div class="panel">
										    <div class="table-responsive">
										        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="table2-list">
													<thead>
													    <tr class="primary">
															<th>고객사 이름</th>
															<th>사용자 아이디</th>
															<th>사용자 이름</th>
															<th>사용자 전화번호</th>
															<th>추가</th>
													    </tr>
													</thead>
												</table>
											</div>
										</div>			
									</div>
									<!-- 테이블 끝 -->
										
		                       	</div>
		                       	<div id='divSmsTarget' class="row">
		                       		<div id="smsTarget"></div>
		                       	</div>
		                    </div>
	                       	<div class="modal-footer tac">
	                        	<a type='button' class="btn btn-primary" onclick="setId();">적용</a>
								<a type='button' class="btn btn-grey" data-dismiss="modal" onclick="initModal();">닫기</a>
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

function moveSrchPage(catalogSeq){
	$("#modal-srch-copy").modal();
}

	var vReceiverParam = new Array;

	// 적용 
	function setId(){
		var html = $("#smsTarget").html();
		$("#receiverNumberList").append(html);
		$("#modal-dialog").modal("hide");
	}
	
	
	// 발송목록 세팅
	function actAppend(a, b, c, d, gbn){
		if(d == "undefined"){
			alertBox3("등록된 연락처가 없습니다.");
			return false;
		}
		
		if($("#smsTarget").html().indexOf(d) >-1){
			alertBox3("이미 등록된 번호 입니다.");
			return false;
		}
		//$("#divSmsTarget").show();
		
		$("#smsTarget").append("<div><a class='btn' onclick='actTargetDel(this)'> X </a>"+a+" "+c+" "+d+"<div>");
		
		data = {
			"receiverFlg" : gbn
			, "receiverNumber" : d
			, "receiverName" : (gbn=="C"?a:c)		
			, "receiverId" : b
		}
		vReceiverParam.push(data);
	}
	
	// 팝업 선택목록 삭제
	function actTargetDel(e){
		var vTarget = $(e).parent();

		var num = vTarget.text().substring(vTarget.text().lastIndexOf(" ")+1, vTarget.text().length);
		for(var i=0; i< vReceiverParam.length; i++){
			if(num == vReceiverParam[i].receiverNumber){
				vReceiverParam.splice(i,1);
				break;
			}			
		}
		vTarget.remove();
	}

	// 사용자 회원사 구분에 따른 팝업 레이아웃
	function actSearch(){
		if($("#searchKind option:selected").val() == "customerName"){
			$("#divTable1").show();
			$("#divTable2").hide();
			gridList1();			
		}else{
			$("#divTable2").show();
			$("#divTable1").hide();
			gridList2();			
		}
	}
	
	//회원사
	function gridList1() {
		$("#table1-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/customer/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
				,"error": function (xhr, error, thrown) {
					if ( error == "parsererror" ) {
						location.reload();
					}else{
						alert("ajax error");
						return false;
					}
				}	
			}
			,"columns":[ 
				{"data":"customerName" , "class":"tac"}
				, {"data":"customerId" , "class":"tac"}
				, {"data":"managerName" , "class":"tac"}
				, {"data":"managerPhone" , "class":"tac"}
		        , {"class":"tac", "width":"15%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[1],"visible":false,"searchable":false }
				, {"targets":[4], "render": function(data,type,full){
					return '<input type="button" class="btn btn-primary_02" value="추가" onclick="actAppend(\''+full.customerName+'\',\''+full.customerId+'\',\''+full.managerName+'\',\''+full.managerPhone+'\',\'C\')"/>';
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

	// 사용자 목록
	function gridList2() {
		$("#table2-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/user/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
				,"error": function (xhr, error, thrown) {
					if ( error == "parsererror" ) {
						location.reload();
					}else{
						errorBox("ajax error");
						return false;
					}
				}	
			}
			,"columns":[ 
				{"data":"customerName" , "class":"tac"}
				, {"data":"userId" , "class":"tac"}
				, {"data":"userName" , "class":"tac"}
				, {"data":"userPhone" , "class":"tac"}
		        , {"class":"tac", "width":"15%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[1],"visible":false,"searchable":false }
				, {"targets":[4], "render": function(data,type,full){
					return '<input type="button" class="btn btn-primary_02" value="추가" onclick="actAppend(\''+full.customerName+'\',\''+full.userId+'\',\''+full.userName+'\',\''+full.userPhone+'\',\'U\')"/>';
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
	
	// 팝업 오픈
	function openModal(){
		$("#modal-dialog").modal();
		$("#smsTarget").html("");
		$("#keyword").val("");
		actSearch();
	}
	
	// 팝업초기화
	function initModal(){
		$("#_mbrId").val("");
		$("#checkMsg").text("");
		$("#enableId").css("display", "none");
		$("#unableId").css("display", "block");
	}

	// 등록/수정
	function actInsert() {
			var gubun = $("input:radio[name=gubun]:checked").val();
		
		if(vReceiverParam.length >0){
			$.ajax({
				url : "${contextPath}/mng/sms/queue/insert",
				dataType : "JSON",
				type : "POST",
				data : {
					"senderName" : $("#senderName").val()
					, "senderNumber" : $("#senderNumber").val()
					, "message" : $("#message").val()
					, "receiverNumberList" : vReceiverParam
					, "receiverNumberListSize" : vReceiverParam.length
					, "regUserId" : "${userId}"
					, "gubun" : gubun //사용자, 회원사 구분값 ( U , C )
					, templateId : ""
					
				},
				success : function(data) {
					alertBox(data+"건이 등록되었습니다.", reload);
				},
				error : function(request, status, error) {
					errorBox("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
	}
	
	//화면 새로고침
	function reload(){
		location.reload();
	}
	
	$(document).ready(function() {
		App.init();
		
		//메뉴활성화
		$("#sms").addClass("active");
		$("#smsQueue").addClass("active");
		
		// 사용자 회원사 구분
		$("input:radio[name=gubun]").click(function(){
			if($("#user").is(":checked")){
				$("#smsTarget > div").remove();
				$("#receiverNumberList > div").remove();
				$("#sendCustomer").hide();
				$("#sendUser").show();
				
				$("#searchKind > option").remove();
				var html = "";
				html = "<option value='user_name'>사용자명</option>";
				html += "<option value='customer_name'>고객사명</option>";
				html += "<option value='user_phone'>전화번호</option>";
				
				$("#searchKind").html(html); 
				
			}else if($("#customer").is(":checked")){
				$("#smsTarget > div").remove();
				$("#receiverNumberList > div").remove();
				$("#sendUser").hide();
				$("#sendCustomer").show();
				
				$("#searchKind > option").remove();
				var html = "";
				html = "<option value='customerName'>고객사명(전체발송용)</option>";
				
				$("#searchKind").html(html); 
			}	
		});
		
	});
	
</script>
</body>
</html>