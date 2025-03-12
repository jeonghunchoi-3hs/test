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
	<div id="page-loader" class="page-loader fade in"><span class="spinner"></span></div>
	<!-- end #page-loader -->

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
			<input type="hidden" id="projectName" value="" />
			<input type="hidden" id="projectId" value="${licenseInfo.projectId}" />
			<input type="hidden" id="beforeVmUuid" value="${licenseInfo.vmUuid}" />
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>라이센스 등록</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책관리</a><a href="#" class="on">라이센스관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<div class="formType01">
					<div class="tblWrap clearfix">
						<input type="hidden" id="hiddenlicenseId" value="${licenseId}">
						<input type="hidden" id="hiddenlicenseDetailId" value="${licenseDetailId}">
						<input type="hidden" id="hiddenVmUuid">
						<table>
							<colgroup>
								<col width="140px">
								<col width="*">
								<col width="140px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
								    <th scope="row"><strong>프로젝트</strong></th>
                					<td>
                						<div class="selectBox" style="width:100%;">
											<label class="selectText" for="selectProjectName">프로젝트를 선택하세요</label>
											<select class="search-sel" id="selectProjectName">
											</select>
										</div>
                					</td>
                					<td></td>
                					<td></td>
								</tr>
								<tr>
 								    <th scope="row"><strong>사용VM</strong></th>
									<td colspan="2"><input maxlength="60" type="hidden" style="width:100%" name="vmUuid" id="vmUuid" readonly><input maxlength="60" type="text" style="width:100%" name="vmName" id="vmName" readonly></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="row tac m-t-60">
				    <c:if test="${licenseDetailId eq null}">
		 			<a type='button' class="rbton bton_blue" id="noticeModify" name="noticeModify" onclick="ossLicenseInsert()"><i class="fa fa-upload"></i>   등록</a>
                    </c:if>
		 			<c:if test="${licenseDetailId ne null}">
		 			<a type='button' id="noticeModify" class="rbton bton_blue" onclick="LicenseUpdate()"><i class="fa fa-pencil"></i> 수정</a>
		 			</c:if>
		 			<a type='button' class="rbton bton_dgrey"  id="noticeList" onclick="moveListPage();"><i class="fa fa-close"></i> 취소</a>
				</div>
			</div>

			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->
	</div>
	<div class="modal fade" id="modal-dialog_vm">
		<div class="modal-dialog">
			<div class="modal-content width-570">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
                    <h4 class="modal-title">가상서버 선택</h4>
                </div>
                <div class="modal-body">
                	<div class="page_searchBox m-b-15">
                		<div class="gridTableWrap gridType02">
							<!-- 그리드 영역 -->
							<div class="tableWrap">
								<div class="tblBox">
									<!-- 고객사 Case -->
									<table id="VM-list">
									    <col width="*">
									    <col width="*">
									    <col width="80px">
										<thead id='popDivThead'>
							 			</thead>
										<tbody id="VM-listTable">
							 			</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="modal-footer tac">
	                       <a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="okproduct()">적용</a>
	                       <a type="button" class="pbton bton_dgrey" data-dismiss="modal">취소</a>
                        </div>
                	</div>
                </div>
			</div>
		</div>
	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
	function bbsDetail(cloudId) {
		/*alert("test");
		$.ajax({
			url : "${contextPath}/mng/cmm/license/detail",

			dataType : "JSON",
 			type : "POST",
			data : {
				"cloudId" : cloudId
			},
			success : function(data) {
				var result = data;
				setData(result);
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		})
*/
	}


	function validationCheck(){
		var licenseKey = $("#licenseKey").val();
		var vmUuid = $("#vmUuid").val();
		if(vmUuid==""){
			warningBox("시용 VM을 입력해주세요");
			$("#vmUuid").focus();
			return false;
		}
		if(vmUuid == $("#beforeVmUuid").val()) {
			warningBox("이전 VM과 동일합니다.");
			return false;
		}
		return true;
	}


	function ossLicenseInsert() {

		if(!validationCheck()){
			return;
		}

		var jsonData = setJsonData();

		$.ajax({
			url : "${contextPath}/mng/cmm/license/detailInsert",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("등록되었습니다.", moveDetailPage);
				}else{
					errorBox("등록실패");
				}
			},
			error : function(request, status, error) {
				errorBox("code1:" + request.status + "\n" + "error:" + error);
			}
		})

	}

	function LicenseUpdate(){
		if(!validationCheck()){
			return;
		}

		var jsonData = setJsonData();

		$.ajax({
			url : "${contextPath}/mng/cmm/license/detailUpdate",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("수정되었습니다.", moveDetailPage);
				}else{
					errorBox("수정실패");
				}
			},
			error : function(request, status, error) {
				errorBox("code1:" + request.status + "\n" + "error:" + error);
			}
		})
	}
	function setJsonData(){

		var jsonData = {

 				  "licenseId":"${licenseId}"
 	 			, "licenseDetailId":$("#hiddenlicenseDetailId").val()
				, "vmUuid":$("#vmUuid").val()
				};
		return jsonData;
	}


	function setData(result){

		$("#adminDomain").val(result.adminDomain);
		$("#adminProject").val(result.adminProject);
		$("#adminUsername").val(result.adminUsername);

	}

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/cmm/license/";
	}

	// 상세 페이지이동
	function moveDetailPage(){
			location.href = "${contextPath}/mng/cmm/license/view?licenseId="+${licenseId};
 	}


	$(document).ready(function() {

		App.init();
		getProjectList();

		//메뉴활성화
		$("#operation").addClass("active");
		$("#ossLicense").addClass("active");

	});

	function getProjectList(){

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
				$("#selectProjectName").empty();
				var Html="";
				Html +="<option value='' selected='selected'>프로젝트를 선택하세요</option>";
				if(projectList!=""){
					$.each(projectList,function(key,val){
						Html +="<option value='"+val["projectId"]+"' projectName='"+val["projectName"]+"'>"+val["projectAlias"]+"</option>";
					});

				}
				$("#selectProjectName").append(Html);
				if($("#beforeVmUuid") != null){
					//$("#selectProjectName").val($("#projectId").val()).prop("selected",true).trigger('change');
					$("#vmUuid").val($("#beforeVmUuid").val());
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

	function changeProjectName(e){
		$("#productId").val("");
		$("#productName").val("");
		$("#checkProjectId").val($("#selectProjectName").val());
		if(e == "project"){
			$("#productSeq").val("자원을 선택하세요");
			$("#productSeq").siblings(".selectBoxDrop").text($("#productSeq").children('option:selected').text());
		}
	}
	$(document).on("change","#selectProjectName",function(){
		$("#projectName").val($(this).attr("projectname"));
		$("#projectId").val($(this).val());
		$("#hiddenVmUuid").val("");
		$("#vmUuid").val("");
		$("#vmName").val("");
		openModal();
	})
	function openModal(){
		gridVMList();
		$("#modal-dialog_vm").modal();
		//setSearchSelect();

	}
	function gridVMList(){
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
					d.projectId = $("#projectId").val();
					d.projectName = $("#projectName").val();
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
						var hostName = full.hostname;
						var vmUuid = full.vmUuid;
						return '<div class="tac"><a href="#" data-toggle="tab"><input type="button"  value="&#xf00c" class="popCheckbtn" onclick=setVm(this,"'+vmUuid+'","'+hostName+'")></a></div>';

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
	function setVm(e,vmUuid,hostName){
		$("#VM-listTable > tr").find("input").removeClass("active");
		$("#hiddenVmUuid").val(vmUuid);
		$("#vmName").val(hostName);
		$(e).toggleClass("active");
	}
	function okproduct(){
		$("#vmUuid").val($("#hiddenVmUuid").val());
	}



</script>

</body>
</html>