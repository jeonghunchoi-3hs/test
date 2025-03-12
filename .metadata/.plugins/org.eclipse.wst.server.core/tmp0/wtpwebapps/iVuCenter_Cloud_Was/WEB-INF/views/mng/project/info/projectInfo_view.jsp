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
				<h1>기본정보</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">기본정보 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			  <div class="row">
			 	<input type="hidden" id="hid_projectId" value="${req.projectId}">
			 	<input type="hidden" id="hid_projectBoxId" value="${req.projectBoxId}">
				<input type="hidden" id="hid_reqProjectSeq" value="${req.reqProjectSeq}">

				<div class="viewbox">
				    <span class="pid" id="projectName">${req.projectName}</span>
				 	<h3 class="pname dpin ml20" id="projectAlias">${req.projectAlias}</h3>
				 	<ul class="mt20">
				 	<li>
				 	<span class="dpin fb fc-blue2"><span class="dot"></span>본부 : </span><span id="deptName"></span>
				 	<span class="dpin fb ml40 fc-blue2"><span class="dot"></span>처(실) : </span><span id="deptName2"></span>
				 	<span class="dpin fb ml40 fc-blue2"><span class="dot"></span>부서 : </span><span id="deptName3"></span>
				 	<span class="dpin fb ml40 fc-blue2"> <span class="dot"></span>프로젝트 비용 : </span> <span id="projectPrice" ></span>
				 	<span class="dpin fb ml40 fc-blue2"> <span class="dot"></span>프로젝트 기간  : </span> <span id ="projectStartDatetime"></span> ~ <span id ="projectEndDatetime"></span>
				 	 </li>
				 	 </ul>
				 	<h4 class="ptxt_t"><span class="dot"></span>프로젝트 내용</h4>
				 	<p class="ptxt"><span id="projectDescription"></span></p>

					<h4 class="fc-blue2 fb">
						<span class="dot"></span> 첨부파일
					</h4>
					<ul class="mt10">
						<c:forEach items="${file}" var="filelist" varStatus="status">
							<li class="ml10 mb8"><span class="f14 fc11">${filelist.fileName}</span>
								<span class="f14 fc66">(${filelist.fileTranSize})</span> <a
								href="${contextPath}/mbr/cmm/file/download/${filelist.fileId}"
								class="btn_download"></a></li>
						</c:forEach>
					</ul>


							<h4 class="fc-blue2 fb mt20 dpin">
								<span class="dot"></span> 파일추가
							</h4>
							<form id="file-form" name="file-form"
								action="${contextPath}/mbr/cmm/file/projectFileInsertAdd"
								method="post" enctype="multipart/form-data" class="dpin ml10">
								<input type="text" id="programSeq" name="programSeq"
									value="${req.reqProjectSeq}" class="opa0" /> <input type="hidden"
									name="returnUrl" value="project" /> <input type="hidden"
									id="programName" name="programName" value="projectFile" /> <input
									type='file' id='files' name='files' class="width-500" /> <input
									type='hidden' id='fileNm' name='fileNm' />
							</form>
					    <!-- 첨부파일 끝 -->
				</div>

				<h2 class="titleBuType01"><span class="bullet"></span>클라우드 정보(IaaS)</h2>
				<table class="tableV">
					<colgroup>
						<col width="*">
						<col width="13%">
						<col width="12%">
						<col width="13%">
						<col width="12%">
					</colgroup>
					<thead>
						<tr>
							<th>클라우드</th>
							<th>가상서버 (EA)</th>
							<th>vCPU (Core)</th>
							<th>MEMORY (GB)</th>
							<th>볼륨 (EA)</th>
						</tr>
					</thead>
					<tbody>

					<c:forEach items="${cloudProjectInfo}" var="cloudProjectInfo" varStatus="status" >
						<c:if test="${cloudProjectInfo.cloudType eq 'openstack' or cloudProjectInfo.cloudType eq 'vmware'}">
							<tr>
								<td>${cloudProjectInfo.cloudName}</td>
								<td>${cloudProjectInfo.vmUsed}</td>
								<td>${cloudProjectInfo.vcpuUsed}</td>
								<td>${cloudProjectInfo.memUsed}</td>
								<td>${cloudProjectInfo.diskUsed}</td>
							</tr>
						</c:if>
					</c:forEach>
					</tbody>
				</table>

				<h2 class="titleBuType01"><span class="bullet"></span>클라우드 정보(PaaS)</h2>
				<table class="tableV">
					<colgroup>
						<col width="*">
						<col width="13%">
						<col width="12%">
						<col width="13%">
						<col width="12%">
					</colgroup>
					<thead>
						<tr>
							<th>클라우드</th>
							<th>어플리케이션</th>
							<th>POD</th>
							<th>오토스케일</th>
							<th>볼륨(PV)</th>
						</tr>
					</thead>
					<tbody>

					<c:forEach items="${cloudProjectInfo}" var="cloudProjectInfo" varStatus="status" >
						<c:if test="${cloudProjectInfo.cloudType eq 'openshift'}">
							<tr>
								<td>${cloudProjectInfo.cloudName}</td>
								<td>${cloudProjectInfo.vmUsed}</td>
								<td>${cloudProjectInfo.vcpuUsed}</td>
								<td>${cloudProjectInfo.memUsed}</td>
								<td>${cloudProjectInfo.diskUsed}</td>
							</tr>
						</c:if>
					</c:forEach>
					</tbody>
				</table>


				<h2  class="titleBuType01 mb10 mt20"> 클라우드 선택 </h2>
				<div class="col-md-12 pl0 pr0">
				   <c:forEach items="${reqProjectCloudList}" var="reqProjectCloudList" varStatus="status" >

					   <c:if test="${reqProjectCloudList.cloudType eq 'openstack'}">

					   <div class="cloud_oa">
	                 	<ul>
	                 		<h4><input type="checkbox"  class="big_check" disabled checked/> ${reqProjectCloudList.cloudName} </h4>
							<li class="cdesc">${reqProjectCloudList.content}</li>
	                 	</ul>
					   </div>
					   </c:if>

					  <c:if test="${reqProjectCloudList.cloudType eq 'vmware'}">
					   <div class="cloud_dmz">
						<ul>
	                 		<h4><input type="checkbox"  class="big_check" disabled checked/> ${reqProjectCloudList.cloudName} </h4>
							<li class="cdesc">${reqProjectCloudList.content}</li>
	                 	</ul>
					   </div>
					  </c:if>

					  <c:if test="${reqProjectCloudList.cloudType eq 'openshift'}">
					  <div class="cloud_mobile">
	                 	<ul>
	                 		<h4><input type="checkbox"  class="big_check" disabled checked/> ${reqProjectCloudList.cloudName} </h4>
							<li class="cdesc">${reqProjectCloudList.content}</li>
	                 	</ul>
	                  </div>
	                  </c:if>
					  <c:if test="${reqProjectCloudList.cloudType eq 'nutanix'}">
					  <div class="cloud_mobile">
	                 	<ul>
	                 		<h4><input type="checkbox"  class="big_check" disabled checked/> ${reqProjectCloudList.cloudName} </h4>
							<li class="cdesc">${reqProjectCloudList.content}</li>
	                 	</ul>
	                  </div>
	                  </c:if>

				   </c:forEach>
				</div>

				<h2 class="titleBuType01"><span class="bullet"></span>담당자 정보  </h2>
				<table class="tableV">
					<colgroup>
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="190px">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
							<th>본부</th>
							<th>처(실)</th>
							<th>부서</th>
							<th>이름(직급)</th>
							<th>사번</th>
							<th>전화번호(사선) </th>
							<th>핸드폰</th>
							<th>이메일</th>
							<th>구분</th>
						</tr>
					</thead>
					<tbody>

					<c:forEach items="${managerList}" var="managerList" varStatus="status" >
						<c:set var="deptSub" value="${fn:split(managerList.deptName2,'-')}"/>
							<tr>
								<td>${fn:split(managerList.deptName2,'/')[1]}</td>
								<td>${fn:split(managerList.deptName2,'/')[2]}</td>
								<td>${fn:split(managerList.deptName2,'/')[3]}</td>
								<td>${managerList.userName}</td>
								<td>${managerList.userId}</td>
								<td>${managerList.userTel}</td>
								<td>${managerList.userPhone}</td>
								<td class="tal">${managerList.userMail}</td>
								<td>${managerList.projectManagerTypeName}</td>
							</tr>
					</c:forEach>
					</tbody>
				</table>
				<div class="clear row tac mt40">
					<a type="button" class="rbton bton_blue" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>
				</div>
				<!-- //20191016 add NDK -->


	         	<!-- begin col-12 -->
	         	<div class="section-container inbox100">

	                <!-- begin panel -->
					<!-- begin normal input table---------->
					<%-- <div class="tableC">
						<input type="hidden" id="hid_projectId" value="${req.projectId}">
						<input type="hidden" id="hid_projectName" value="${req.projectName}">
						<input type="hidden" id="hid_customerId" id = 'customerId' >
						<table>
							<colgroup>
								<col width="20%">
								<col width="80%">
							</colgroup>
							<tbody>
								<tr>
									<td class="left-b height-40">사업자</td>
								  	<td class="f14 fb">
										<div class="col-md-6" id="companyName"></div>
								  	</td>
								</tr>
								<tr>
									<td class="left-b height-40">고객사</td>
								  	<td class="f14 fb">
										<div class="col-md-6" id="customerName"></div>
								  	</td>
								</tr>
								<tr>
									<td class="left-b height-40">프로젝트 명</td>
								  	<td class="f14 fb">
										<div class="col-md-6" id="projectName"></div>
								  	</td>
								</tr>
								<tr>
									<td class="left-b height-40">프로젝트 별칭</td>
								  	<td class="f14 fb">
										<div class="col-md-6" id="projectAlias"></div>
								  	</td>
								</tr>
								<tr>
									<td class="left-b height-40">프로젝트 PM</td>
								  	<td class="f14 fb pl20" >
										<div class="dpin" id="userName"></div>
								  	</td>
								</tr>
							</tbody>
						</table>
					</div> --%>
					<!-- end normal input table---------->
					<!-- end panel -->

					<!-- begin button-->
					<%-- <div class="col-md-12 tac mt20">
						<sec:authorize access="hasRole('ROLE_CLOUD_ADMIN')">
	                     	<button type="button" id="noticeList" class="btn btn-lime" onclick="moveInsertPage()"><i class="fa fa-edit"> </i> 수정 </button>
						</sec:authorize>
	                    <button class="btn btn-grey"  id="noticeList"  onclick="moveListPage()"><i></i> 목록</button>
					</div> --%>
					<!-- end button -->
				</div>
                <!-- end col-12 -->
			</div>
			<!-- end page-body -->


				<div class="modal fade" id="modal-attach">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">볼륨 연결 관리</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<input type='hidden' id='pop_hid_diskId' name='pop_hid_diskId' />
								<div class="col-md-8" >
									<select id='pop_attach_server' name='pop_attach_server' class="form-control dpin pb6" >
										<option value="">선택</option>
									</select>
								</div>
								<div class="col-md-4" >
									<input type="button" id="" name="" value="연결" onclick="confirmAttach();" class="btn btn-primary width-80" />
								</div>
	                      	</div>
	                       	<div class="modal-footer tac" style='margin-top: 40px !important;'>
	                   			<a type='button' class="btn btn-default width-80" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>

			<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog4">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">PM 설정</h4>
	                       </div>
	                       <div class="modal-body">
<!-- 	                           <p class="m-b-20"> -->
	                              <div class="col-md-12 bgee br10 mb10">
	                              <div class="col-md-9 p10"><input type="text"  id="searchKeyword" class="form-control" value="" /></div>
	                              <div class="col-md-1 p10"><input type="button" value="검색" class="btn btn-grey" onclick="projectPmPopList();"/></div>
	                              </div>
<!-- 	                           </p> -->

								<div>
									<table class="table table-bordered table-hover table-striped table-td-valign-middle">
										<colgroup>
									 		<col width="40%">
									 		<col width="40%">
									 		<col width="20%">
									 	</colgroup>
									 	<thead>
									 		<tr class="primary">
												<th class="left height-40 tac">사용자 아이디</th>
												<th class="left height-40 tac">사용자 이름</th>
												<th class="left height-40 tac">PM등록</th>
											</tr>
									 	</thead>
										<tbody id="popListTable">

										</tbody>

									</table>
								</div>

	                      	</div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="btn btn-grey" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->

				<!-- #modal-dialog -->
				<div class="modal fade" id="massage-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">알림</h4>
	                       </div>
	                       <div class="modal-body">
	                           <h5 id="confirmMsg"></h5>
	                        </div>
	                       	<div class="modal-footer tac">
	                       		<a type='button' class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->

				<!-- #modal-dialog -->
				<div class="modal fade" id="modal-alert">
	               <div class="modal-dialog">
	               	<input type='hidden' id='modal-alert-reload' value='N'>
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">알림 메세지</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div id="modal_msg"></div>
	                      	</div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->


				 <!-- 청구요금 상세 -->
				<!-- #modal-dialog -->
				<div class="modal fade" id="bill-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">청구요금 상세</h4>
	                       </div>
	                       <div class="modal-body">
								<div class="tableB">
									<table>
										<colgroup>
									 		<col width="200px;">
									 		<col width="*">
									 	</colgroup>
									 	<tbody id="billDetailTable">

										</tbody>
									</table>
								</div>

								<div class="col-md-12 disk p10 mt5 mb20">
									<div class="col-md-8 fc66 f24 pr0">총 청구요금</div>
									<div class="col-md-4 f24 fc-red tar pr0 vm"><span id="totalAmount"></span><span class="f12 fc66 pl4">원</span></div>
								</div>
							</div>
							<div class="clear"></div>
	                       	<div class="modal-footer tac">
	                   			<a type='button' class="btn btn-default width-80" data-dismiss="modal">닫기</a>
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

	function getDetail() {

		$.ajax({
			url : "${contextPath}/mng/oss/project/detail",
			dataType : "JSON",
			data : {
				"projectId" : $("#hid_projectId").val()
				,"projectBoxId" : $("#hid_projectBoxId").val()
			},
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){
		                    //프로젝트 상세 ID 값 넣기
					if(i != "deptName"){
	                    if(val == null){
							$("#"+i).text("");
	                    }else{

							$("#"+i).text(val);
								if(i == "projectDescription"){
									var content = val.replace(/(?:\r\n|\r|\n)/g,"<br />")
									$("#"+i).html(content);
								}
								if(i == "projectPrice"){
									var content = val.replace(/\B(?=(\d{3})+(?!\d))/g,",")
									$("#"+i).html(content);
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

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/project/info/";
	}
	// 등록/수정페이지 이동
	function moveInsertPage(){
		var projectBoxId = $("#hid_projectBoxId").val();
		location.href = "${contextPath}/mng/project/info/write?projectBoxId="+projectBoxId;
	}

	$("#files").change(function(){
		confirmBox("파일을 추가하시겠습니까?", actFileUpload);
	})
	function actFileUpload(){
		$('#file-form').submit();
	}

	$(document).ready(function() {
		App.init();
		getDetail();

		//메뉴활성화
		$("#project").addClass("active");
		$("#projectInfo").addClass("active");
	});

</script>
</body>
</html>