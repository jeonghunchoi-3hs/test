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
				<h1> 개발환경 </h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">개발환경 관리</a>
				</div>
			</div>


			 <!-- begin #content > page-body -->
				 <div class="row mb50">
					<input type ="hidden" id ="hid_projectId"  value="${req.projectId}">
					<input type ="hidden" id ="hid_projectBoxId"  value="${req.projectBoxId}">
					<input type ="hidden" id ="hid_projectName"  value="${req.projectName}">
					<input type ="hidden" id ="reqProjectSeq"  value="${req.programSeq}">

				 <!-- 프로젝트 정보 & 현재 사용용량 시작 -->
					<div class="viewbox mb20">
					    <!-- 프로젝트 상세정보 -->
					    <span class="pid" id="projectName"></span>
					 	<h3 class="pname dpin ml20" id="projectAlias"></h3>
					 	<div class="mt20">
					 		<span class="dpin fb fc-blue2">본부 : </span> <span id="deptName"></span><span class="dpin fb ml40 fc-blue2">처(실) : </span> <span id="deptName2"></span><span class="dpin fb ml40 fc-blue2">부서 : </span> <span id="deptName3"></span><span class="dpin fb ml40 fc-blue2">담당자  : </span> <span id="managerName"></span>(<span id="managerTel"></span>)
					 	</div>

					</div>
					<!-- 프로젝트 정보 & 현재 사용용량 끝 -->

				   <!-- 프로젝트 하위 상세 VM 리스트 시작 -->
					<div class="gridTableWrap gridType02">
						<div>
							<a onclick="excelDown();" type='button' class="bton-s bton_blue flr mb10"><i class="fa fa-file-excel-o"></i> <span> 엑셀 다운로드</span></a>
						</div>

						<!-- 그리드 영역 -->
						<div class="tableWrap">
							<table id="env-list">
								<colgroup>
									<col width="240px">
									<col width="140px">
									<col width="*">
									<col width="120px">
									<col width="140px">
									<col width="80px">
								</colgroup>
								<thead>
									<tr>
										<th>그룹명</th>
										<th>개발환경명</th>
										<th>URL </th>
										<th>관리자 </th>
										<th>생성일시 </th>
										<th>상세 </th>
									</tr>
								</thead>
								<tbody>
								<tr>
									<td class="tal"></td>
									<td class="tal"></td>
									<td class="tal"></td>
									<td class="tar"></td>
									<td></td>
									<td></td>
<%-- 								<td><a href="${wasPath}/mbr/application/req/detail" class="cbton bton_lblue"><i class="fa fa-search"></i></a></td> --%>
								</tr>
								</tbody>

							</table>
						</div>
						<div class="tac mt30">
							<a onclick="moveListPage()" type="button" class="btn_dgrey">목록</a>
						</div>
				</div>
					<!-- 프로젝트 하위 상세 VM 리스트 끝 -->

				<!---- end page body---->
	            </div>

	            <div class="modal fade virtual-server-modal" id="env-modal-dialog">
					<div class="modal-dialog">
		               <div class="modal-content">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
				                    <span></span>
				                </button>
				                <h4 class="modal-title">개발환경 상세</h4>
				            </div>
	                       <div class="modal-body">
								<div class="modalManagePop">
									<div id="popDetailDivProject"></div>
									<div class="detailBox">
										<div class="boxType01" id='popDetailDiv1'></div>
									</div>
								</div>
								<div id="envUserList" class="mt20">
								</div>
	                       </div>
							<div class="clear"></div>
				            <div class="modal-footer tac">
								<a type="button" class="whiteline" data-dismiss="modal" id="popclose">닫기</a>
				            </div>
	                    </div>
	                </div>
				</div>
				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
		</div>

	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/project/application/detail",
			dataType : "JSON",
			async : false,
			data : {
				"programSeq" : $("#reqProjectSeq").val()
				,"projectBoxId" : $("#hid_projectBoxId").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){
					if(i != "deptName"){
						if(i == "cloudType"){
		                    if(val == "vmware"){
			                    $("#status1").text("상태");
			                    $("#status3").text("상태 : ");
			                    $("#status4").remove();
			                    visible = 0;
			                }
		                }
						if(val != null){
							if(i=="customerId"){
								$("#hid_"+i).val(val);
							}else if(i == "keyword"){
								// skip
							}else{
								$("#"+i).text(val);
							}
						}
						if(i == "deptName2"){
							if(val){
								$("#deptName").html(val.split("/")[1]);
								$("#deptName2").html(val.split("/")[2]);
								$("#deptName3").html(val.split("/")[3]);
							}
						}
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}

	function gridEnvList() {
		$("#env-list").dataTable({
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/application/env/projectEnvList"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = "";
					d.keyword = "";
					d.projectBoxId = $("#hid_projectBoxId").val();
					d.projectId = $("#hid_projectId").val();
					d.projectName = $("#hid_projectName").val();
				}
			}
			,"columns":[
				{"data":"cicdGroupName" , "class":"tal fontVdn"}
				, {"data":"cicdProjectName" , "class":"tac fontVdn"}
				, {"data":"url" , "class":"overflow-path tal"}
				, {"data":"devUserName" , "class":"tac fontVdn"}
				, {"data":"regDatetime2" , "class":"tac fontVdn"}

			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[5], "render": function(data,type,full){
					return '<a type="button" class="tac btn mt5 btn-detail table-search" onclick="detailEnv(\''+full.cicdGroupName+'\',\''+full.cicdGroupPath+'\',\''+full.url+'\',\''+full.description+'\',\''+full.cicdProjectId+'\');" class="cbton bton_lblue" onclick=""><i class="fa fa-search"></i></a>';
					}
				}
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div class='data_search'><i class='fa fa-spinner fa-spin'></i> 검색중입니다. </div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});

	}

	function detailEnv(cicdGroupName, cicdGroupPath, url, description, cicdProjectId){
		$("#env-modal-dialog").modal('show');
	   	var html = "";
	   		html +='<div class="tableE">'
	   		html +='<table><colgroup><col width="130px" /><col width="*" /></colgroup><tbody>'
   			html +='<tr><th class="tal">그룹명</th><td>' + cicdGroupName + '</td></tr>'
  			html +='<tr><th class="tal">그룹 Path</th><td>' + cicdGroupName + '</td></tr>'
  			html +='<tr><th class="tal">개발환경 URL</th><td>' + url + 'EA</td></tr>'
  			html +='<tr><th class="tal">내용</th><td>' + description + 'EA</td></tr>'
  			html +='</tbody></table>'
 			html +='</div>'
			$("#env-modal-dialog #popDetailDiv1").html(html);
		$("#popDetailDiv1").show();
		gridEnvUserList(cicdProjectId);
	}

	function gridEnvUserList(cicdProjectId){
		$.ajax({
			url : "${contextPath}/mbr/application/env/mbrEnvUserList",
			dataType : "JSON",
			type : "GET",
			data : {
				cicdProjectId : cicdProjectId
			},
			success : function(data) {
				var html = "";
				html += "<table class='tableV'>";
		        html += "	<colgroup>";
				html += " 		<col width='140px'>";
				html += " 		<col width='80px'>";
				html += " 		<col width='*'>";
				html += " 		<col width='80px'>";
				html += " 	</colgroup>";
				html += "	<thead>";
				html += "	    <tr>";
				html += "			<th>유저명</th>";
				html += "			<th>아이디</th>";
				html += "			<th>이메일</th>";
				html += "			<th>권한</th>";
				html += "		</tr>";
				html += "	</thead>";
				html += "	<tbody>";
				$.each(data, function(key, val){
					html += "		<tr>";
					html += "			<td class='tac'>"+val["alias"]+"</td>";
					html += "			<td class='tal'>"+val["userId"]+"</td>";
					html += "			<td class='tal'>"+val["userEmail"]+"</td>";
					html += "			<td class='tac'>"+val["codeName"]+"</td>";
					html += "		</tr>";
				});
				html += "	</tbody>";
				html += "</table>" ;
				$("#envUserList").html(html);
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	function moveListPage(){
		location.href = "${contextPath}/mng/application/env/envList";
	}

	function excelDown(){
	    var params = "";
	    params += "&projectBoxId=" + $("#hid_projectBoxId").val();
	    location.href = "${contextPath}/mng/application/env/envViewExcel?"+params;
	}

	$(document).ready(function() {
		App.init();
		getDetail();
		gridEnvList();

		//메뉴활성화
		$("#project").addClass("active");
		$("#projectEnv").addClass("active");

		//tab 첫번째 메뉴 활성화
		$(".nav-pills>li:first-child").addClass("active");
	});

</script>
</body>
</html>