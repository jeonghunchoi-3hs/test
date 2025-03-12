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

		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)-->
		<div id="content" class="content">
			<!-- begin header -->
			<input type ="hidden" id = "hid_projectId"  value ="${req.projectId}">
			<input type ="hidden" id = "hid_projectName"  value ="${req.projectName}">
			<input type ="hidden" id = "hid_reqProjectSeq"  value ="${req.reqProjectSeq}">
            <input type ="hidden" id = "hid_cloudId"  value ="${req.cloudId}">
			<div class="page_header mb30">
				<h1>자원배분 정책</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">프로젝트 쿼터 관리</a>
				</div>
			</div>
			<!-- end header -->

		<!-- begin page-body -->
			 <div class="row">

			 	<div class="viewbox mb20">
			 		<span class="pid" id='cloudName'></span>
				    <span class="pid ml10" id='projectName'></span>
				 	<h3 class="pname dpin ml20 mr40" id="projectAlias"></h3>
				 	<span class="dpin fb fc-blue2">본부 : </span> <span id="deptName"></span>
				 	<span class="dpin fb ml40 fc-blue2">처(실) : </span> <span id="deptName2"></span>
				 	<span class="dpin fb ml40 fc-blue2">부서 : </span> <span id="deptName3"></span>
				 	<span class="dpin fb ml40 fc-blue2">담당자  :</span> <span id="managerName"></span>(<span id="managerPhone"></span>)
				</div>

				<div class="mt40">
			    	<h2 class="titleBuType01"><span class="bullet"></span>자원배분량${cloud.cloudType} </h2>
			    	<div class="formType01">
					<div class="tblWrap clearfix">
						<input type="hidden" id="programName" value="cmm_customer">
						<input type="hidden" id="filesCnt" value="${filesCnt}">
						<table class="tableH">
							<colgroup>
								<col width="140px">
								 <col width="*">
								 <col width="140px">
								 <col width="*">
							</colgroup>
							<tbody>
								<c:choose>
									<c:when test="${cloud.cloudType eq 'openshift'}">
										<tr>
											<th><strong>CPU<br>(Request/Limit)</strong></th>
											<td>
												<span class="f16 fb fc-blue2" id="quota_cpu"></span> Core

											    <p class="comment"> 현재 프로젝트에서 요청 가능한 최소 CPU 코어 / 최대 사용가능한 CPU 코어 </p>
											</td>
											<th><strong class="fontVdn">MEMORY<br>(Request/Limit)</strong></th>
											<td>
												<span class="f16 fb fc-blue2" id="quota_memory"></span>
								 				<p class="comment">현재 프로젝트에서 요청 가능한 최소 메모리 / 최대 사용가능한 메모리</p>
											</td>
										</tr>
										<tr>
											<th><strong class="fontVdn">Volume</strong></th>
											<td>
												<span class="f16 fb fc-blue2" id="quota_pv"> </span>
												<p class="comment">최대 사용가능한 볼륨 수</p>
											</td>
											<th><strong>POD</strong></th>
											<td>
												<span class="f16 fb fc-blue2" id="quota_pod"> </span>
												<p class="comment">최대 사용가능한 생성 가능한 POD수</p>
											</td>
										</tr>
									</c:when>
								</c:choose>

							</tbody>
						</table>
					</div>
				</div>
				</div>




				<div class="row tac m-t-40">
					<a type='button' id="noticeList" class="rbton bton_blue" onclick="moveInsertPage()"><i class="fa fa-pencil"></i> 수정</a>
					<a type='button' class="rbton bton_dgrey ml10" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
				</div>
				<!-- <div class="row tac m-t-40">
					<a type="button" id="noticeList" class="btnType03 btnType03_edit mr20" onclick="moveInsertPage()">수정</a>
					<a type="button" class="btnType03 btnType03_list" onclick="moveListPage();">목록</a>
				</div> -->
			</div>

            <!-- begin #footer -->
            <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->


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
				,"cloudId" : $("#hid_cloudId").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){
					 //프로젝트 상세 ID 값 넣기
					 if(i != "deptName"){
						$("#"+i).text(val);
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

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/project/quota/";
	}
	// 등록/수정페이지 이동
	function moveInsertPage(){
		var params = "?projectId="+$("#hid_projectId").val();
		params += "&projectName="+$("#hid_projectName").val();;
		params += "&reqProjectSeq="+$("#hid_reqProjectSeq").val();;
		params += "&cloudId="+$("#hid_cloudId").val();;

		location.href = "${contextPath}/mng/project/quota/writePass"+params;
	}
	function addcomma(n){
		if(isNaN(n)){
			return 0;
		}else{
			var reg=/(^[+-]?\d+)(\d{3})/;
			n +='';

			if( n.indexOf(".") != -1){
				n = n.split(".")[0];
			}

			while(reg.test(n)){
				n=n.replace(reg,'$1'+','+'$2');
			}
		return n;
		}
	}
	function detailQuota(){
		$.ajax({
			url : "${contextPath}/mng/project/quota/detail",
			dataType : "JSON",
			data : {
				projectId 		: $("#hid_projectId").val()
				, projectName 	: $("#hid_projectName").val()
				, cloudId             :$("#hid_cloudId").val()
			},
			success : function(data) {


				console.log(data.data);


				if( data.data){
					//quota_cpu
					$( "#quota_cpu").html( data.data.specHardRequestCpu + " / "+ data.data.specHardLimitCpu);
					$( "#quota_memory").html(
							data.data.specHardRequestMemory
							+ " / "
							+ data.data.specHardLimitMemory);

					$( "#quota_pv").html( data.data.specHardPV);
					$( "#quota_pod").html( data.data.specHardPod);

					return;
				}


			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	$(document).ready(function() {
		App.init();
		getDetail();
		detailQuota();

		//메뉴활성화
		$("#project").addClass("active");
		$("#projectQuota").addClass("active");
	});

</script>
</body>
</html>