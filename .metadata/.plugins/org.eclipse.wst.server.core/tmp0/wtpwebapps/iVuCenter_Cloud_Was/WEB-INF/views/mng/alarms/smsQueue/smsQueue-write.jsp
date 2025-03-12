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

	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in hide"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

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
				<h1>알림 발송</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">알림/접속 관리</a><a href="#" class="on">알림 발송</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">

				<!-- <h2 class="titleBuType01 fontVdn m-b-15">SMS</h2> -->


						<table class="tableH">
						   <colgroup>
								 <col width="140px">
								 <col width="*">
							</colgroup>
						<tr><th>발신자 이름</th><td><input type="text" style="width:100%;" value="${userName}" id="senderName"></td></tr>
						<tr>
							<th>발신자 번호</th>
							<td><input type="text" class="w100" value="061-345-5366" id="senderNumber" readonly="readonly"></td>
						</tr>
						<tr>
							<th>수신 구분</th>
							<td>
								<div class="flex align-center gap10">
									<label for="receive1"><input type="radio" name="receiverGbn" value="1" id="receive1" checked="checked" class="mr5"> 사용자</label>
									<label for="receive2"><input type="radio" name="receiverGbn" value="2" id="receive2" class="mr5">회원사</label>
									<label for="receive3"><input type="radio" name="receiverGbn" value="3" id="receive3" class="mr5">프로젝트</label>
									<a type='button' class="bton-s bton_blue dpin flr"  id="moveSrchPage" style="margin-left:auto;"><i class="fa fa-search"></i> 검색</a>
								</div>
							</td>
						</tr>
						<tr>
							<th>수신자</th>
							<td>
								<div class="receiverList" id='receiverList'>
								<ul>
								</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th>메세지</th>
							<td>
							<textarea  class="w100 height-200" id="message"></textarea>
							<div class="smsByteArea heightAuto">
							<div class="byte m-t-8">( <span id="divByte">0</span> / 80bytes ) </div>
							</div>
						</td>
						</tr>
						</table>

				<div class="row tac m-t-60">
					<a type='button' class="rbton bton_blue" id="actInsert"><i class="fa fa-paper-plane"></i> 발송</a>
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
											<label class="selectText" for="searchKind"></label>
											<select class="search-sel" id="searchKind">
											</select>
										</div>
										<div class="inputArea m-l-5">
											<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)seachPopList();" style="width: 250px">
											<a type='button' class="bton-s bton_blue" onclick="seachPopList();"><i class="fa fa-search"></i> 검색</a>
										</div>
									</div>
								</div>

								<div class="gridTableWrap gridType02">
									<!-- 그리드 영역 -->
									<div class="tableWrap">
										<div class="tblBox">
											<!-- 고객사 Case -->
											<table id="pop_table_list">
											    <col width="*">
											    <col width="20%">
											    <col width="20%">
												<thead id="pop_thead">
													<tr>
														<th>구분</th>
														<th>고객사명</th>
														<th>추가</th>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								</div>

		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="pbton bton_blue" id="addReceiverList">적용</a>
		                       <a type="button" class="pbton bton_dgrey" data-dismiss="modal">취소</a>
	                       </div>
		               	</div>
					</div>
	            </div>


				<!-- begin col-12 -->

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



 function seachPopList(){
	 var gbn = $("input:radio[name='receiverGbn']:checked").val();

	 if	   (gbn == "1") { gridList1(); }
	 else if(gbn == "2") { gridList2(); }
	 else if(gbn == "3") { gridList3(); }


 }

	$(document).ready(function() {
		App.init();

		// 메시지 길이 표시
		$("#message").keyup(function(){
			var len = 0;
			for(var i=0; i<this.value.length; i++){
				if(escape(this.value.charAt(i)).length == 6){
					len++;
				}
				len++;
			}
			$("#divByte").text(len);
		});
		// 수신자 검색  modal 버튼
		$("#moveSrchPage").click(function(){

			var gbn = $("input:radio[name='receiverGbn']:checked").val();
			moveSrchPage(gbn);
			if	   (gbn == "1") { gridList1(); }
			else if(gbn == "2") { gridList2(); }
			else if(gbn == "3") { gridList3(); }

			$("#modal-srch-copy").modal();
		});
		// 수신자 검색 후 적용 버튼
		$("#addReceiverList").click(function(){
			addReceiverList();
			$("#modal-srch-copy").modal('hide');
		});
		// 발송 버튼
		$("#actInsert").click(function(){
			if(vReceiverParam.length == 0) {
				alertBox3('수신인을 선택하세요');
				return;
			}
			if($("#message").val().length == 0) {
				alertBox3('메시지를 입력하세요');
				return;
			}
			actInsert();
		});

		//메뉴활성화
		$("#alarms").addClass("active");
		$("#smsQueue").addClass("active");
	});

	function moveSrchPage(gbn) {
		var thead = "";
		var searchKind = "";
		if(gbn == "1") {
			thead = '<tr><th>회원사명</th>'+
			            '<th>사용자</th>' +
			            '<th>사용자Id</th>' +
			            '<th>부서</th>' +
			            '<th>추가</th></tr>';
			searchKind = '<option value="user_id" selected="selected">사용자ID</option>' +
			                   '<option value="user_name">사용자명</option>' +
			                   '<option value="dept_name_only">부서명</option>';

		} else if(gbn == "2") {
			thead = '<tr><th>회원사명</th>'+
            		    '<th>관리자명</th>' +
            		    '<th>관리자ID</th>' +
            		    '<th>부서명</th>' +
            			'<th>추가</th></tr>';
			searchKind = '<option value="customerName" selected="selected">회원사명</option>';
		} else if(gbn == "3") {
			thead = '<tr><th>회원사명</th>'+
		   			    '<th>프로젝트명</th>' +
			   			'<th>관리자명</th>' +
			   			'<th>관리자ID</th>' +
			            '<th>추가</th></tr>';
			searchKind = '<option value="project_customer_name" selected="selected">회원사명</option>' +
				         '<option value="project_alias">프로젝트명</option>';

		}
		$("#pop_thead").html(thead);
		$("#searchKind").html(searchKind);
		$("#searchKind").siblings(".selectText").text($("#searchKind > option:selected").text());
	}

	function gridList1() {
		$("#pop_table_list").dataTable( {
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
						alert("ajax error");
						return false;
					}
				}
			}
			,"columns":[
				{"data":"customerName" , "class":"tac", "width":"20%"}
				, {"data":"userName" , "class":"tac", "width":"20%"}
				, {"data":"userId" , "class":"tac", "width":"20%"}
				, {"data":"deptNameOnly" , "class":"tac", "width":"20%"}
		        , {"class":"tac", "width":"20%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[4], "render": function(data,type,full){
					return '<a type="button" class="btn_add" onclick="addReceiver(this,\''+1+'\',\''+
							full.userId+'\',\'사용자\',\''+full.customerName+' / '+full.userName+' / '+full.userPhone+'\');"><span class="vtt">추가</span></a>';
					}
				}
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"lengthMenu": [[5], ['5']]
			,"sDom":'<"top">rt<"bottom"pi>'
		});
	}

	function gridList2() {

		$("#pop_table_list").dataTable( {
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
				{"data":"customerName" , "class":"tac", "width":"20%"}
				, {"data":"managerName" , "class":"tac", "width":"20%"}
				, {"data":"managerId" , "class":"tac", "width":"20%"}
				, {"data":"managerDeptName" , "class":"tac", "width":"20%"}
		        , {"class":"tac", "width":"20%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[4], "render": function(data,type,full){
					return '<a type="button" class="btn_add" onclick="addReceiver(this,\''+2+'\',\''+
							full.managerId+'\',\'회원사\',\''+full.customerName+' / '+full.managerName+' / '+full.managerPhone+'\');"><span class="vtt">추가</span></a>';
					}
				}
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"lengthMenu": [[5], ['5']]
			,"sDom":'<"top">rt<"bottom"pi>'
		});
	}

	function gridList3() {
		$("#pop_table_list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/oss/project/list"
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
				{"data":"projectCustomerName" , "class":"tac", "width":"15%"}
				, {"data":"projectAlias" , "class":"tac", "width":"40%"}
				, {"data":"managerName" , "class":"tac", "width":"15%"}
				, {"data":"managerId" , "class":"tac", "width":"15%"}
		        , {"class":"tac", "width":"15%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[4], "render": function(data,type,full){
					return '<a type="button" class="btn_add" onclick="addReceiver(this,\''+3+'\',\''+
							full.managerId+'\',\'프로젝트\',\''+full.projectCustomerName+' / '+full.projectAlias+' / '+full.managerName+' / '+full.managerPhone+'\');"><span class="vtt">추가</span></a>';
					}
				}
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"lengthMenu": [[5], ['5']]
			,"sDom":'<"top">rt<"bottom"pi>'
		});
	}

	var vPopReceiverParam = new Array;
	function addReceiver(e, gbn, id, td1, td2){
		$(e).toggleClass("on");

		if($(e).attr("class").indexOf(" on") > -1){
			data = {
					"gbn" : gbn
					, "id" : id
					, "td1" : td1
					, "td2" : td2
				}
			vPopReceiverParam.push(data);
		}else{
			for(var i=0; i< vPopReceiverParam.length; i++){
				if(gbn == vPopReceiverParam[i].gbn && id == vPopReceiverParam[i].id){
					vPopReceiverParam.splice(i,1);
					break;
				}
			}
		}
	}

	var vReceiverParam = new Array;
	function addReceiverList(){
		var len = vReceiverParam.length;
		for(var i=0; i< vPopReceiverParam.length; i++){
			if(len > 0){
				var chk = 0;
	 			for(var j=0; j< len; j++){
					if(vReceiverParam[j].gbn == vPopReceiverParam[i].gbn && vReceiverParam[j].id == vPopReceiverParam[i].id){
						chk++;
						break;
					}
				}
	 			if(chk==0){
					vReceiverParam.push(vPopReceiverParam[i]);
					$("#receiverList > ul").append('<li>'
							+'<a type="button" onclick="actTargetDel(this,\''+vPopReceiverParam[i].gbn+'\',\''+vPopReceiverParam[i].id+'\')" class="btn_del"> </a>'
							+'<strong class="catogory">&nbsp;'+vPopReceiverParam[i].td1+'</strong>'
							+'<p>'+vPopReceiverParam[i].td2+'</p>'
					+'</li>');
	 			}else{
	 				chk = 0;
	 			}
			}else{
				vReceiverParam.push(vPopReceiverParam[i]);
				$("#receiverList > ul").append('<li>'
					+'<a type="button" onclick="actTargetDel(this,\''+vPopReceiverParam[i].gbn+'\',\''+vPopReceiverParam[i].id+'\')" class="btn_del"></a>'
					+'<strong class="catogory">&nbsp;'+vPopReceiverParam[i].td1+'</strong>'
					+'<p>'+vPopReceiverParam[i].td2+'</p>'
				+'</li>');
			}
		}
		vPopReceiverParam = [];
	}

	// 등록/수정
	function actInsert() {
		if(vReceiverParam.length >0){
			$.ajax({
				url : "${contextPath}/mng/alarms/smsQueue/insert",
				dataType : "JSON",
				type : "POST",
				data : {
					"senderName" : $("#senderName").val()
					, "senderNumber" : $("#senderNumber").val()
					, "message" : $("#message").val()
					, "receiverNumberList" : vReceiverParam
					, "receiverNumberListSize" : vReceiverParam.length
					, "regUserId" : "${userId}"
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

	function actTargetDel(e, gbn, id){
		$(e).parent().remove();
		for(var i=0; i< vReceiverParam.length; i++){
			if(vReceiverParam[i].gbn == gbn && vReceiverParam[i].id == id){
				vReceiverParam.splice(i,1);
				break;
			}
		}
	}

</script>
</body>
</html>