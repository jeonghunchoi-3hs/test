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
	<div id="page-loader" class="page-loader fade in hide"><span class="spinner"></span></div>
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
			<div class="page_header m-b-30">
				<c:if test="${downloadNo ne 0}">
					<h1>자료실 수정</h1>
				</c:if>
				<c:if test="${downloadNo eq 0}">
					<h1>자료실 등록</h1>
				</c:if>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">사용문의</a><a href="#" class="on">자료실</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row p-b-100">


				<div class="formType01">
					<div class="tblWrap clearfix">
						<input type="hidden" id="downloadNo" name="downloadNo" value="${downloadNo}">
						<input type="hidden" id="programName" name="programName" value="${programName}">
						<input type="hidden" id="filesCnt" value="0">
						<table>
							<colgroup>
								 <col width="140px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>제목</strong></th>
									<td><input type="text" style="width:100%" name="title" id="title"></td>
								</tr>
								<tr>
									<th scope="row"><strong>분류</strong></th>
									<td>
										<div class="selectBox" style="width:160px;">
											<label class="selectText" for="downloadType" id="downloadTypelabel"></label>
											<select class="search-sel" name="downloadType" id="downloadType">
												<c:forEach items="${code}" var="codelist" varStatus="status" >
													<option value="${codelist.codeId}">${codelist.codeName}</option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>내용</strong></th>
									<td>
										<textarea style="width:100%;height:200px;" id="_content"></textarea>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>첨부파일</strong></th>
									<td class="p-t-20">
									<a type='button' class="bton-s bton_blue" style="width:100px;"><span class="txt"> <i class="fa fa-file-text-o"></i> 파일추가</span></a>
									<span class="txt_guide_type01 flr m-t-8">첨부파일은 5개까지 등록 가능합니다. 용량은 개당 200MB 입니다.</span>
									<form id="file-form" name="file-form" action="${contextPath}/mng/cmm/file/insert" method="post"  enctype="multipart/form-data">
										<input type='file' id='files' name='files'/>
<!-- 										<input style="display:block;width:106px;height:36px;position:absolute;top:85px;left:160px;opacity:0;filter: alpha(opacity=0);cursor:pointer;" type='file' id='files' name='files'/> -->
											<input type='hidden' id='fileNm' name='fileNm'/>
										<div id="files-list" class="mt10">
											<c:forEach items="${file}" var="filelist" varStatus="status" >
												<div class="MultiFile-label">
													<span class="MultiFile-title" title="File selected: C:\fakepath\addi_icon03.png">${filelist.fileName}</span>
													<a class="MultiFile-remove" href="javascript:;" onclick="delFile('${filelist.fileId}')" ></a>
												</div>
											</c:forEach>
										</div>
									</form>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="row tac m-t-60">
					<c:if test="${downloadNo ne 0}">
						<a type='button' class="rbton bton_blue" id="noticeModify" name="noticeModify" onclick="validationCheck();"><i class="fa fa-floppy-o"></i>  저장</a>
					</c:if>
					<c:if test="${downloadNo eq 0}">
		 				<a type='button' class="rbton bton_blue" id="noticeModify" name="noticeModify" onclick="validationCheck();"><i class="fa fa-upload"></i>  등록</a>
	 				</c:if>
		 			<!-- 수정 case 일시
		 			<a type='button' class="btnType03 btnType03_save" onclick="">저장</a>
		 			-->
		 			<a type='button' class="rbton bton_dgrey"  id="noticeList" onclick="moveListPage();"><i class="fa fa-close"></i> 취소</a>
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

	function delFile(fileId){
		$.ajax({
			url : "${contextPath}/mng/cmm/file/delete",
			dataType : "JSON",
			data : {
				"fileId" : fileId
				, "programName": $("#programName").val()
				, "programSeq" : $("#downloadNo").val()
			},
			success : function(data) {
				updateFilesCnt("1");
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		})
	}

	function updateFilesCnt(gbn){
		$.ajax({
			url : "${contextPath}/mng/bbs/download/updateFilesCnt",
			dataType : "JSON",
			type : "POST",
			data : {
				"programName": $("#programName").val()
				, "programSeq" : $("#downloadNo").val()
			},
			success : function(data) {
				if(gbn =="1"){
					alertBox("삭제 되었습니다.", reload);
				}else if(gbn=="2"){
					alertBox("등록 되었습니다.", moveDetailPage);
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		})
	}
	function reload(){
		location.reload();
	}

	// 상세정보 가져오기
	function bbsDetail() {
		$.ajax({
			url : "${contextPath}/mng/bbs/download/detail",
			dataType : "JSON",
			data : {
				"downloadNo" : $("#downloadNo").val()
			},
			success : function(data) {
				var result = data;

				$("#downloadType").val(result.downloadType);
				$("#downloadTypelabel").text(result.codeName);

				$("#title").val(result.title);
				$("#_content").val(result.content);
				$("#filesCnt").val(result.filesCnt);
				$("#regDatetime").val(result.regDatetime);
				$("#regUserId").val(result.regUserId);
				$("#modDatetime").val(result.modDatetime);
				$("#modUserId").val(result.modUserId);
				$("#delFlag").val(result.delFlag);

				if(result.filesCnt > 0){
					$("#divFile").show();
				}
				if(result.filesCnt > 4){
					$("#files").hide();
				}

			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}


	// 등록 버튼 클릭 시 Validation 체크
	function validationCheck(){
		var title = $("#title").val();
		var content = $("#_content").val();

		if(title==""){
			alertBox("제목을 입력해주세요");
			$("#title").focus();
			return false;
		}
		if(content==""){
			alertBox("내용을 입력해주세요.");
			$("#_content").focus();
			return false;
		}
		confirmBox("저장하시겠습니까?", noticeBbsInsert);
	}


	// Validation 체크 후 게시글 저장/수정저장
	function noticeBbsInsert() {
		$.ajax({
			url : "${contextPath}/mng/bbs/download/insert",
			dataType : "JSON",
			type : "POST",
			data : {
				"downloadNo" : $("#downloadNo").val()
				, "downloadType": $("#downloadType > option:selected").val()
				, "title": $("#title").val()
				, "content":$("#_content").val()
				, "filesCnt":$("#filesCnt").val()
				, "delFlag":$("#delFlag").val()
				, "regUserId":"${userId}"
				, "modUserId":"${userId}"
			},
			success : function(data) {
				var result = data;
				if($("#downloadNo").val() == "0"){
					$("#downloadNo").val(result);
				}
				if(result != "0"){
					alertBox("저장하였습니다.", actFileUpload);
				}else{
					errorBox("실패");
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		})
	}

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/bbs/download/";
	}

	// 게시글 저장 후 파일 저장
	function actFileUpload(){
		$('#file-form').ajaxForm({
			cache:false
			, data : {
				programName: $("#programName").val()
				, programSeq : $("#downloadNo").val()
			}
			, dataType:"json"
	       	//보내기전 validation check가 필요할경우
	       	, beforeSubmit: function (data, frm, opt) {
	       		var chk = true;

	       		$.each(data, function(i, val){
	       			if(val.value.size > 209715200){
	       				alertBox3("첨부파일 용량은 200MB를 초과할수 없습니다.");
	       				chk = false;
	       			}
	       		});
	       },
	       //submit이후의 처리
	       success: function(data, statusText){
	    	   moveDetailPage();
	       },
	       //ajax error
	       error: function(e){
	           alert("파일 업로드 에러발생!!");
	       }
		});
		$('#file-form').submit();
	}

	// 상세 페이지이동
	function moveDetailPage(){
		location.href = "${contextPath}/mng/bbs/download/view?downloadNo="+$("#downloadNo").val();
 	}

	function pushfileaddbtn(){
		$("#files").click();
	}

	function closeModal(){
		$("#modal-dialog-profileImg").modal("hide");
		$("#fileName").val($(".MultiFile-title").text());
	}

	function openFileModal(){
		$("#modal-dialog-profileImg").modal();
	}

	$(document).ready(function() {
		$("#downloadType").siblings(".selectText").text($("#downloadType").children('option:selected').text());
		if($("#downloadNo").val() != 0 ){
			bbsDetail();
		}
		App.init();

		$('#files').MultiFile({

			list: "#files-list"
			, max : 5
			//, accept : 'gif|jpg|png'
			, maxFile : 204800
			, maxSize :  204800
			, STRING : {
				//remove : "<input type='button' value='삭제' class='btn btn-danger' style='font:8px;padding-bottom:2px;'>"
				duplicate : "$file 은 이미 선택된 파일입니다."
				, denied : "$ext 는(은) 업로드 할수 없는 파일 확장자 입니다."
				, toomuch : "업로드 할 수 있는 최대크기를 초과하였습니다.($size)"
				, toomany : "업로드 할 수 있는 최대 갯수는 $max개 입니다."
				, toobig : "$file 은 크기가 매우 큽니다.(max $size)"
			}
			, afterFileRemove: function(element, value, master_element) {
				$("#filesCnt").val( $("#files-list")[0].childElementCount );
			}
			, afterFileAppend: function(element, value, master_element) {
				$("#filesCnt").val( $("#files-list")[0].childElementCount );
			}

		});

		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsDownload").addClass("active");
	});

</script>

</body>
</html>