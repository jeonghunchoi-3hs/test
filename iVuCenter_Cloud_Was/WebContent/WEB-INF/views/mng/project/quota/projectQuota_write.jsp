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
				<h1>자원 배분 정책 </h1>

			    <input type ="hidden" id = "hid_projectId"  value ="${req.projectId}">
			   <input type ="hidden" id = "hid_projectName"  value ="${req.projectName}">
			   <input type ="hidden" id = "hid_reqProjectSeq"  value ="${req.reqProjectSeq}">
			   <input type ="hidden" id = "hid_cloudId"  value ="${req.cloudId}">


               <input type ="hidden" id = "quota_edit_metadata_items" name = "quota_edit_metadata_items"  label="메타데이터 항목"  label2 = "EA" value ="">
   			   <input type ="hidden" id = "quota_edit_injected_files" name = "quota_edit_injected_files" label="첨부한 파일"  label2 = "EA" value ="">
   			   <input type ="hidden" id = "quota_edit_injected_file_content_bytes" name = "quota_edit_injected_file_content_bytes" label="주입된 파일 컨텐츠"  label2 = "Bytes"  value ="">
   			   <input type ="hidden" id = "quota_edit_security_group" name = "quota_edit_security_group" label="보안 그룹"  label2 = "EA"  value ="">
   			   <input type ="hidden" id = "quota_edit_security_group_rule" name = "quota_edit_security_group_rule" label="보안 그룹 규칙"  label2 = "EA"  value ="">
   			   <input type ="hidden" id = "quota_edit_floatingip" name = "quota_edit_floatingip" label="Floating IP"  label2 = "EA"  value ="">
   			   <input type ="hidden" id = "quota_edit_network" name = "quota_edit_network" label="네트워크"  label2 = "EA"  value ="">
   			   <input type ="hidden" id = "quota_edit_port" name = "quota_edit_port" label="포트"  label2 = "EA"  value ="">
   			   <input type ="hidden" id = "quota_edit_router" name = "quota_edit_router" label="라우터"  label2 = "EA"  value ="">
   			   <input type ="hidden" id = "quota_edit_subnet" name = "quota_edit_subnet" label="서브넷"  label2 = "EA"  value ="">

				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">자원배분 정책</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			 <div class="row pb50">
			 	<div class="viewbox mb20">
		 			<span class="pid" id='cloudName'></span>
				    <span class="pid" id='projectName'></span>
				 	<h3 class="pname dpin ml20" id="projectAlias"></h3>
				 	<span class="dpin fb ml40">회원사  : </span><span id="customerName"></span> <span class="dpin fb ml40">담당조직(부서) : </span><span id="deptName"></span><span class="dpin fb ml40">담당자  : </span><span id="managerName"></span>(<span id="managerPhone"></span>)
				</div>

				<div class="clear mt50"></div>
				<h2 class="titleBuType01 mb15">자원배분량 </h2>

				<table class="tableH">
				    <colgroup>
						 <col width="15%">
						 <col width="35%">
						 <col width="15%">
						 <col width="35%">
					</colgroup>
					<c:choose>
						<c:when test="${cloud.cloudType eq 'openstack'}">
							<tr>
								<th>가상서버 </th>
								<td><input type="text" class="input_int width-100" name="quota_edit_instances" id="quota_edit_instances"  label="가상서버"  label2 = "EA" onkeypress="number_only(this);"/></span> EA
								   <p class="comment"> 현재프로젝트에서 생성 가능한 최대 가상서버 수량 (EA) </p>
								</td>
								<th>vCPU</th>
								<td><input type="text" class="input_int width-100" name="quota_edit_cores" id="quota_edit_cores" label="vCPU"  label2 = "Core" onkeypress="number_only(this);"/> Core
								   <p class="comment"> 현재프로젝트에서 할당 가능한 CPU 코어 수량 (Core) </p>
								</td>
							</tr>
							<tr>
							    <th>MEMORY</th>
								<td><input type="text" class="input_int width-100" name="quota_edit_ram" id="quota_edit_ram" label="MEMORY"  label2 = "GB" onkeypress="number_only(this);"/> GB
									<p class="comment"> 현재프로젝트에서 할당 가능한 최대 메모리 크기(GB) </p>
								</td>
								<th>볼륨</th>
								<td><input type="text" class="input_int width-100" name="quota_edit_volumes" id="quota_edit_volumes" label="볼륨"  label2 = "EA" onkeypress="number_only(this);"/> EA
									<p class="comment"> 현재프로젝트에서 생성 가능한 볼륨 수량 (EA)</p>
								</td>
							</tr>
							<tr>
								<th>볼륨 스냅샷</th>
								<td><input type="text" class="input_int width-100" name="quota_edit_snapshots" id="quota_edit_snapshots" label="볼륨 스냅샷"  label2 = "EA" onkeypress="number_only(this);"/> EA
									<p class="comment"> 현재프로젝트에서 생성 가능한 볼륨 스냅샷 수량 (EA) </p>
								</td>
								<th>블록디스크 </th>
								<td><input type="text" class="input_int width-100" name="quota_edit_gigabytes" id="quota_edit_gigabytes" label="블록디스크"  label2 = "GB" onkeypress="number_only(this);"/> GB
									<p class="comment"> 현재프로젝트에서 할당 가능한 블록 디스크 용량 (GB) </p>
								</td>
							</tr>
						</c:when>
						<c:when test="${cloud.cloudType eq 'vmware'}">
							<tr>
								<th>가상서버 </th>
								<td><input type="text" class="input_int width-100" name="quota_edit_instances" id="quota_edit_instances"  label="가상서버"  label2 = "EA" onkeypress="number_only(this);"/></span> EA
								   <p class="comment"> 현재프로젝트에서 생성 가능한 최대 가상서버 수량 (EA) </p>
								</td>
								<th>vCPU</th>
								<td><input type="text" class="input_int width-100" name="quota_edit_cores" id="quota_edit_cores" label="vCPU"  label2 = "Core" onkeypress="number_only(this);"/> Core
								   <p class="comment"> 현재프로젝트에서 할당 가능한 CPU 코어 수량 (Core) </p>
								</td>
							</tr>
							<tr>
							    <th>MEMORY</th>
								<td><input type="text" class="input_int width-100" name="quota_edit_ram" id="quota_edit_ram" label="MEMORY"  label2 = "GB" onkeypress="number_only(this);"/> GB
									<p class="comment"> 현재프로젝트에서 할당 가능한 최대 메모리 크기(GB) </p>
								</td>
								<th>블록디스크 </th>
								<td><input type="text" class="input_int width-100" name="quota_edit_gigabytes" id="quota_edit_gigabytes" label="블록디스크"  label2 = "GB" onkeypress="number_only(this);"/> GB
									<p class="comment"> 현재프로젝트에서 할당 가능한 블록 디스크 용량 (GB) </p>
								</td>
							</tr>
						</c:when>
					</c:choose>
				</table>



				<div class="row tac m-t-40">
					<a type="button" class="rbton bton_blue" onclick="openModal()"><i class="fa fa-floppy-o"></i> 저장</a>
					<a type="button" class="rbton bton_dgrey ml10"  onclick="moveListPage();"><i class="fa fa-close"></i> 취소</a>
				</div>

			</div>

			<!-- #modal-dialog -->
                 <div class="modal fade" id="modal-dialog">
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">수정 확인</h4>
	                       </div>
	                       <div class="modal-body">
								<div class="popScroll302">
									<div class="formType01">
										<div class="tblWrap clearfix">
											<table>
												<colgroup>
													 <col width="130px">
													 <col width="*">
												</colgroup>
												<tbody id = "changeList">

												</tbody>
											</table>
										</div>
									</div>
	                      		</div>
	                      		<p class="commnet fc-red tac">할당량 정보를 수정하시겠습니까?</p>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="updateQuota();">확인</a>
	                       		<a type="button" class="pbton bton_dgrey ml10" data-dismiss="modal" onclick="initPopup();">취소</a>
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


	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/oss/project/projectDetail",
			dataType : "JSON",
			data : {
				"projectId" : $("#hid_projectId").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){
					 //프로젝트 상세 ID 값 넣기
					$("#"+i).text(val);

				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}



	var change_input =  false;

	// 목록 페이지이동
	function moveListPage(){
		var params = "?projectId="+$("#hid_projectId").val();
		params += "&projectName="+$("#hid_projectName").val();
		params += "&reqProjectSeq="+$("#hid_reqProjectSeq").val();
		params += "&cloudId="+$("#hid_cloudId").val();

		location.href = "${contextPath}/mng/project/quota/view"+params;
	}
	//modal팝업 open
	function openModal(){

		if(change_input == false){
			alertBox3("변경된 내용이 없습니다.");
		}else{
			var nowObj ={
				projectId : $("#hid_projectId").val()
				, projectName	: $("#hid_projectName").val()
				, metadata_items : $("#quota_edit_metadata_items").val()
				, cores : $("#quota_edit_cores").val()
				, instances : $("#quota_edit_instances").val()
				, injected_files : $("#quota_edit_injected_files").val()
				, injected_file_content_bytes : $("#quota_edit_injected_file_content_bytes").val()
				, ram : $("#quota_edit_ram").val()
				, security_group : $("#quota_edit_security_group").val()
				, security_group_rule : $("#quota_edit_security_group_rule").val()
				, floatingip : $("#quota_edit_floatingip").val()
				, network : $("#quota_edit_network").val()
				, port : $("#quota_edit_port").val()
				, router : $("#quota_edit_router").val()
				, subnet : $("#quota_edit_subnet").val()
				, volumes : $("#quota_edit_volumes").val()
				, snapshots : $("#quota_edit_snapshots").val()
				, gigabytes : $("#quota_edit_gigabytes").val()
				, cloudId : $("#hid_cloudId").val()



			};
			delete backupObj.length;
			var changeObj ={};
			var html ="";
			$.each(backupObj, function(key, val){
				if(backupObj[key] != nowObj[key]){

						html += '<tr><th scope="row"><strong>'+$('#quota_edit_'+key).attr("label")+'<span class="fontVdn fc66 f16 fontN">('+$('#quota_edit_'+key).attr("label2")+')</span></strong></th><td class="p-0 p-r-10">';
						html +=  '<span class="oldData fontVdn fc66 f16">'+addcomma(backupObj[key])+'</span>';
						html +=	'<span class="newData fontVdn f16">'+addcomma(nowObj[key])+'</span></td> </tr>';
				}
			});
			$('#changeList').html(html)
			$("#modal-dialog").modal();
		}

		//$("#modal-dialog").modal();

	}

	function modalCreate(){
		$("#modal-dialog").modal();
	}


	function detailQuota(){
		$.ajax({
			url : "${contextPath}/mng/project/quota/detail",
			dataType : "JSON",
			data : {
				projectId 		: $("#hid_projectId").val()
				,cloudId 		: $("#hid_cloudId").val()
			},
			success : function(data) {
			delete data.data.length;
				$.each(data.data, function(key, val){
					if(val != null){
						if (key =="ram"){
							$("#quota_edit_"+key).val(val / 1024);
						}else
						$("#quota_edit_"+key).val(val);
					}
				});
			  backupObj ={
						projectId : $("#hid_projectId").val()
						, projectName	: $("#hid_projectName").val()
						, metadata_items : $("#quota_edit_metadata_items").val()
						, cores : $("#quota_edit_cores").val()
						, instances : $("#quota_edit_instances").val()
						, injected_files : $("#quota_edit_injected_files").val()
						, injected_file_content_bytes : $("#quota_edit_injected_file_content_bytes").val()
						, ram : $("#quota_edit_ram").val()
						, security_group : $("#quota_edit_security_group").val()
						, security_group_rule : $("#quota_edit_security_group_rule").val()
						, floatingip : $("#quota_edit_floatingip").val()
						, network : $("#quota_edit_network").val()
						, port : $("#quota_edit_port").val()
						, router : $("#quota_edit_router").val()
						, subnet : $("#quota_edit_subnet").val()
						, volumes : $("#quota_edit_volumes").val()
						, snapshots : $("#quota_edit_snapshots").val()
						, gigabytes : $("#quota_edit_gigabytes").val()
					};
				delete data.detail.length;
				$.each(data.detail, function(key, val){
					if(val != null){
						$("#"+key).text(val);
					}
				});
				change_input =  false;
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}


	$(document).ready(function() {
		detailQuota();
		getDetail();

		var backupObj;


		$("input").change(function(){
			change_input = true;
		});

		App.init();
		//메뉴활성화
		$("#project").addClass("active");
		$("#projectQuota").addClass("active");


	});


	function updateQuota(){
	var obj = 	{
			projectId : $("#hid_projectId").val()
			, projectName	: $("#hid_projectName").val()
			, metadata_items : $("#quota_edit_metadata_items").val()
			, cores : $("#quota_edit_cores").val()
			, instances : $("#quota_edit_instances").val()
			, injected_files : $("#quota_edit_injected_files").val()
			, injected_file_content_bytes : $("#quota_edit_injected_file_content_bytes").val()
			, ram : $("#quota_edit_ram").val()
			, security_group : $("#quota_edit_security_group").val()
			, security_group_rule : $("#quota_edit_security_group_rule").val()
			, floatingip : $("#quota_edit_floatingip").val()
			, network : $("#quota_edit_network").val()
			, port : $("#quota_edit_port").val()
			, router : $("#quota_edit_router").val()
			, subnet : $("#quota_edit_subnet").val()
			, volumes : $("#quota_edit_volumes").val()
			, snapshots : $("#quota_edit_snapshots").val()
			, gigabytes : $("#quota_edit_gigabytes").val()
			, cloudId : $("#hid_cloudId").val()
		};
			ajaxUpdateQuota(obj);
	}
function ajaxUpdateQuota(obj){

		alertBox("처리중 입니다.<br>잠시만 기다려 주십시오.", waiting);
		$.ajax({
			url : "${contextPath}/mng/project/quota/update",
			dataType : "JSON",
			data : obj,
			success : function(data) {
				if(data.errorMsg=="1"){
					QuotaSynchronize();
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	function QuotaSynchronize(){
		alertBox("동기화중 입니다.<br>잠시만 기다려 주십시오.", waiting2);
		$.ajax({
			url : "${contextPath}/mng/project/quota/QuotaSynchronize",
			dataType : "JSON",
			data : {cloudId : $("#hid_cloudId").val()},
			type : "POST",
			success : function(data) {
				var result = data;
				if(result == "1"){
					alertBox("동기화가 완료되었습니다.", moveListPage);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		})
	}
	function waiting(){
		alertBox("처리중 입니다.<br>잠시만 기다려 주십시오.", waiting);
	}
	function waiting2(){
		alertBox("동기화중 입니다.<br>잠시만 기다려 주십시오.", waiting2);
	}


</script>
</body>
</html>