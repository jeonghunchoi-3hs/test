<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="adminId" 	property="principal.username" />
	<sec:authentication var="adminName" property="principal.nickname"/>
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
		<link href="${apachePath}/resources/assets/plugins/jqGrid/css/ui.jqgrid.css" rel="stylesheet" />
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

			<!-- begin #content (페이지 바디 컨텐츠 시작입니다)-->
			<div id="content" class="content">

				<!-- begin header -->
				<div class="page_header mb30">
					<h1>사용자 수정</h1>
					<div class="pageNav">
						<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책관리</a><a href="#" class="on">사용자 관리</a>
					</div>
				</div>
				<!-- end header -->

				<!-- begin page-body -->
				<div class="row pb50">

						<input type="hidden" id="_userId" value="${_userId}">
						<input type="hidden" id="_role" value="${role}">
						<input type="hidden" name="customerId" id="h_customerId" value="" />
						<input type="hidden" name="deptCode" id="h_deptCode" value="" />
							<table class="tableH">
								<colgroup>
									 <col width="140px">
									 <col width="*">
									 <col width="140px">
									 <col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th>ID</th>
										<td id="userId" colspan="3"></td>
									</tr>
									<tr>
										<th>회원사명</th>
										<td>
											<span id="customerName" class="pt10 dpin"></span>
											<a type="button" class="bton-s bton_blue flr"  onclick="openCustomerModal();"><i class="fa fa-search"></i> 검색 </a>
										</td>
										<th>소속조직(부서)</th>
										<td>
											<span id="deptName" class="pt10 dpin"></span>
											<a type="button" class="bton-s bton_blue flr"  id="openDepartment"><i class="fa fa-search"></i> 검색</a>
										</td>
									</tr>
									<tr>
										<th>사용자명</th>
										<td><input type="text" id="userName" class="w100"/></td>
										<th>핸드폰</th>
										<td><input type="text" id="userPhone" class="w100"/></td>
									</tr>
									<tr>
										<th>전화번호 (국선)</th>
										<td><input type="text" class="w100" id="userTel"></td>
										<th>전화번호 (사선)</th>
										<td><input type="text" class="w100" id="userTelEx"></td>
									</tr>
									<tr>
										<th>SMS 수신여부</th>
										<td>
											<div class="flex align-center gap10">
												<span class="mr20" id="smsRecvFlag"></span>
												<label for="sms01" class="flex align-center gap10"><input type="radio" name="opt_smsRecvFlag" id="sms01" value="Y"/> 수신</label>
												<label for="sms02" class="flex align-center gap10" ><input type="radio" name="opt_smsRecvFlag" id="sms02"  value="N"/>미수신</label>
											</div>
										</td>
										<th>이메일 수신여부</th>
										<td>
											<div class="flex align-center gap10">
												<span class="mr20" id="mailRecvFlag"></span>
												<label for="mail01" class="flex align-center gap10"><input type="radio" name="opt_mailRecvFlag" id="mail01" value="Y" checked="checked">수신</label>
												<label for="mail02" class="flex align-center gap10"><input type="radio" name="opt_mailRecvFlag" id="mail02" value="N">미수신</label>
											</div>
										</td>
									</tr>
								</tbody>
							</table>


					<div class="row tac m-t-60">
						<a type="button" class="rbton bton_blue" onClick="userInfoUpdate()"><i class="fa fa-floppy-o"></i> 저장</a>
			 			<a type="button" class="rbton bton_dgrey" onClick ="moveViewPage()"><i class="fa fa-close"></i> 취소</a>
	                </div>

	                <!-- 고객사 검색 modal -->
	                <div class="modal fade" id="modal-srch-copy">
						<div class="modal-dialog">
							<div class="modal-content width-570">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
		                        	<h4 class="modal-title">회원사 지정</h4>
		                       	</div>
		                       	<div class="modal-body">
		                       		<div class="page_searchBox m-b-15">
										<div class="searchArea">
											<div class="inputArea m-l-5">
												<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)customerSearch();" style="width: 362px">
												<a type="button" class="bton-s bton_blue" onclick="customerSearch();"><i class="fa fa-search"></i> 검색</a>
											</div>
										</div>
									</div>
									<div class="noneList" style="display: none;">
										 <span>검색된 사용자가 없습니다.</span>
									</div>
									<div class="listArea" id ="popListDiv">
		                      		</div>
		                      		<div class="totalcnt" id="totalCnt">총 <span id="listTotal">0</span> 건</div>
			                   </div>
			                   <div class="modal-footer tac">
			                       <a type="button" class="whiteline" data-dismiss="modal" id ="popclose" onclick="initModal();">닫기</a>
		                       </div>
			               	</div>
						</div>
		            </div>
			      </div>
				<!-- #부서 선택 modal-dialog -->
				<div class="modal fade" id="modal-dialog-department">
	            <div class="modal-dialog width-720">
	                <div class="modal-content width-720">

	                    <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                        <h4 class="modal-title">부서 검색</h4>
	                    </div>
	                    <div class="modal-body">
					 	<!-- search begin -->
					 	<div class="page_searchBox m-b-15">
								<div class="searchArea">
									<div class="inputArea m-l-5">
									<input type="text" placeholder="검색어를 입력하세요" id="searchKeywordDept" style="width: 362px">
									<a type="button" class="bton-s bton_blue" id="searchDepartment"><i class="fa fa-search"></i> 검색</a>
									</div>
									</div>
						</div>
						<div class="noneList" style="display: none;">
							 <span>검색된 사용자가 없습니다.</span>
						</div>

					 	<!-- search end -->
					   <div class="col-md-12 pl0 pr0">
				   		<input type="hidden" value="" id="h_popDeptCode">
	     				<input type="hidden" value="" id="h_popDeptName">
	     				<div class="table_wrap">
							<table id="table-list" ></table>
						</div>
					   </div>
	               	</div>
					<div class="clear"></div>
					<div class="modal-footer tac">
	             			<a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="confirmDepartment();">확인</a>
	             			<a type="button" class="pbton bton_dgrey" data-dismiss="modal">취소</a>
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
	<script type='text/javascript' src="${apachePath}/resources/assets/plugins/jqGrid/i18n/grid.locale-kr.js"></script>
	<script type='text/javascript' src="${apachePath}/resources/assets/plugins/jqGrid/jquery.jqgrid.src.js"></script>
	<script type="text/javascript">
		// 화면 표시
		function userInfoDetail(){
			$.ajax({
				url : "${contextPath}/mng/cmm/user/userInfoDetail",
				dataType : "JSON",
				type : "POST",
				data : {
					"userId" : $("#_userId").val()
				},
				success : function(data) {
					setData(data);
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}

		function setData(data){

			delete data.length;
			$.each(data, function(key, val){
				if(val != null){
					if(key=="smsRecvFlag" || key=="mailRecvFlag" || key=="nhwithRecvFlag"){
						var msg = (val == "Y") ? "수신":"미수신";
						$("input:radio[name='opt_"+key+"'][value='"+val+"']").prop("checked", true);
						$("#"+key).text(msg)
					} else if(key=="customerId" || key=="deptCode"){
						$("#h_"+key).val(val);
					} else {
						$("#"+key).val(val);
						$("#"+key).text(val);
					}
				}
			});
		}

		// 사용자 정보 수정 (최종 저장)
		function userInfoUpdate(){

			$.ajax({
				url : "${contextPath}/mng/cmm/user/updateUserCustomer",
				dataType : "JSON",
				type : "POST",
				data : {
					"userId" : $("#_userId").val()
					, "customerId" : $("#h_customerId").val()
					, "deptCode" : $("#h_deptCode").val()
					, "userName" : $("#userName").val()
					, "userPhone" : $("#userPhone").val()
					, "userTel" : $("#userTel").val()
					, "userTelEx" : $("#userTelEx").val()
					, "smsRecvFlag" : $("input:radio[name='opt_smsRecvFlag']:checked").val()
					, "mailRecvFlag" : $("input:radio[name='opt_mailRecvFlag']:checked").val()
				    , "nhwithRecvFlag" : 'N' // $("input:radio[name='opt_nhwithRecvFlag']:checked").val()
				    , "mod_user_id" : "${adminId}"
				},
				success : function(data) {
					alertBox("저장되었습니다.", moveViewPage);
				},
				error : function(request, status, error) {
					errorBox("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}

		// 고객사 검색
		function openCustomerModal(){
			$("#modal-srch-copy").modal();
			customerSearch();
		}

		// 고객사 목록 조회
		function customerSearch(){

			$.ajax({
				url : "${contextPath}/mng/cmm/user/customerSelect",
				dataType : "JSON",
				type : "POST",
				data : {
					"keyword" : $("#searchKeyword").val()
				},
				success : function(data) {
					var popList = data.getCustomerList;
					var listTot = data.listTot;

					if(popList != ""){
						$("#popListDiv > div").remove();
						$.each(popList,function(key,val){
							var Html="";

							Html += "<div class='listBg'>";
							Html += "	<span class='name2'>"+val["customerName"]+"</span>";
							Html += "	<a class='applybtn' data-dismiss='modal' onclick='updateCustomer2(\""+val["customerId"]+"\", \""+val["customerName"]+"\"); initModal();'>적용</a>";
							Html += "</div>";

							$("#popListDiv").append(Html);
						});
						$("#listTotal").text(listTot);
					}else{
						$("#popListDiv > div").remove();
						$("#listTotal").text(0);
					}

				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}

		 // 고객사 검색 값 적용
		function updateCustomer2(customerId, customerName){
			$("#h_customerId").val(customerId);
			$("#customerName").text(customerName);
		}

		// 부서 검색
		function initialDepartment() {
			$("#table-list").jqGrid('clearGridData', true);
			$("#table-list").jqGrid({
				url:'${contextPath}/mng/cmm/department/TreeAll',
				mtype: "POST",
				datatype:"json",
				postData: {
			    },
				colNames:['부서코드','상위부서코드', '부서명','level','isLeaf', 'isExpanded'],
				colModel:[
					{name:'deptCode', 	index:'deptCode', 	hidden:false, 	width:140, align:"center", key: true}
					,{name:'upCode', 	index:'upCode', 	hidden:true, 	width:100, align:"left"}
		 	   		,{name:'deptName', 	index:'deptName', 	hidden:false, 	width:520, align:"left"}
		 	   		,{name:'treeLevel', index:'treeLevel', 	hidden:true, 	width:220, align:"left"}
		 	   		,{name:'isLeaf', 	index:'isLeaf', 	hidden:true, 	width:220, align:"left"}
		 	   		,{name:'isExpanded',index:'isExpanded',	hidden:true, 	width:220, align:"left"}
				],

	// 			rowNum:10,
	// 			rowList:[5,10,15],
				rownumbers:false,
				loadonce:false,
				scrollrows:true,
				loadtext : "조회중 잠시만 기다려주세요.",
				//shrinkToFit:false,
// 				height: '100%', //220, //$(".tbl_type01").height()-40,
// 				width : '100%',
				gridview : true,
				treeGrid : true,
				treeGridModel: 'adjacency',
				ExpandColumn: 'deptName',
				ExpandColClick: true,
				tree_root_level: 1,
	 			treeIcons: {
	 				plus: 'ui-icon-triangle-1-e',
	 				minus:'ui-icon-triangle-1-s',
	 				leaf: 'ui-icon-radio-off'},
	//  			leaf: 'ui-icon-document-b'},
				jsonReader : {
					root: 'data'			//controller에서 가져오는 json명
					, id: 'deptCode'
					, repeatitems: true
				},
				treeReader: {
					level_field: 'treeLevel'
					, parent_id_field: 'upCode'
					, leaf_field: 'isLeaf'
					, expanded_field: 'isExpanded'
				},
				gridComplete: function() {
				},
				loadError : function(xhr,status, error) {
					alert(error);
				},
				onSelectRow:function(rowid, status, e) {
					var list = $('#table-list').getRowData(rowid);
	 				var code = list.deptCode;
					var name = list.deptName.split('>');
					name = name[name.length -1];
					$("#h_popDeptCode").val(code);
					$("#h_popDeptName").val(name);
				},
				onCellSelect:function(rowid, iCol) {
// 					var list = $('#table-list').getRowData(rowid);
// 					var treeLevel = list.treeLevel;
// 					if(treeLevel != 1){
// 						var code = list.deptCode;
// 						var name = list.deptName.split('>');
// 						name = name[name.length -1];
// 						$("#h_popDeptCode").val(code);
// 						$("#h_popDeptName").val(name);
// 						confirmBox(name+"를 적용하시겠습니까?", updateDepartment);
// 					}else{
// 						var code = list.deptCode;
// 						var name = list.deptName.split('>');
// 						name = name[name.length -1];
// 					}
				},
				ondblClickRow:function(rowid, iRow, iCol) {
					var list = $('#table-list').getRowData(rowid);
					var code = list.deptCode;
					var name = list.deptName.split('>');
					name = name[name.length -1];
					$("#h_popDeptCode").val(code);
					$("#h_popDeptName").val(name);
					confirmDepartment();
				}
			}).trigger('reloadGrid');
		}

		function searchDepartment() {
			$("#table-list").jqGrid('setGridParam', {
				url: '${contextPath}/mbr/mbrinfo/TreeAll',
				mtype: "POST",
				datatype: "json",
				postData: {
					searchKind : "dept_name",
					keyword : $("#searchKeywordDept").val()
				}
			}).trigger('reloadGrid');
		}
		function confirmDepartment() {
			var deptName = $("#h_popDeptName").val();
			if(deptName == null || deptName == "") {
				alertBox("선택된 부서가 없습니다.");
				return ;
			}
			confirmBox(deptName+"를 적용하시겠습니까?", updateDepartment);
		}

		// 부서 검색 값 적용
		function updateDepartment() {
			var deptCode = $("#h_popDeptCode").val();
			var deptName = $("#h_popDeptName").val();

			$("#h_deptCode").val(deptCode);
			$("#deptName").val(deptName);
			$("#deptName").text(deptName);

			$("#searchKeywordDept").val("");
			$("#modal-dialog-department").modal("hide");
		}

		function moveInsertPage(){
			var userId = $("#_userId").val();
			location.href = "${contextPath}/mng/cmm/user/userInfoWrite?userId="+userId;
		}

		function moveViewPage(){
			var userId = $("#_userId").val();
			var params = "?userId="+userId;
			location.href = "${contextPath}/mng/cmm/user/viewPage"+params;
		}

		// 팝업 초기화
		function initModal(){
			$("#searchKeyword").val("");
		}

		$(document).ready(function(){
			App.init();
			userInfoDetail();

			$("#openDepartment").click(function() {
				$("#modal-dialog-department").modal();
				initialDepartment();
			});
			$("#searchKeywordDept").keypress(function(event) {
				if(event.keyCode==13) { searchDepartment(); }
			});
			$("#searchDepartment").click(function() {
				searchDepartment();
			});

			//메뉴활성화
			$("#operation").addClass("active");
			$("#cmmUser").addClass("active");
		});

	</script>
	</body>
</html>
