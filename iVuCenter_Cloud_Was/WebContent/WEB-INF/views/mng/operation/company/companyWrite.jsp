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
			<!-- begin page-header -->
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 사업자관리 <span class="root">회원사관리 > 사업자관리</span></h1>
			<!-- end page-header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<!-- begin col-12 -->
				<div class="col-md-12">
					<!-- begin panel -->
						<!-- begin normal input table---------->
						<div class="tableB mb20">
							<input type="hidden" id="companyId" value="${companyId}">
							<input type="hidden" id="programName" value="${programName}">
							<input type="hidden" id="filesCnt" value="${filesCnt}">
							<table>
								<colgroup>
									<col width="10%">
									<col width="40%">
									<col width="10%">
									<col width="40%">
								</colgroup>
								
								<tbody>
									<tr>
										<td class="cen height-40">사업자 명</td>
									  	<td colspan="3">
										 	<div class="col-md-6">
										  		<input class="form-control" type="text" id="companyName"/>
										  </div>
									  	</td>
									</tr>
									<tr>
										<td class="cen height-40">사업자 번호</td>
									  	<td colspan="3">
											<div class="col-md-6">
										  		<input class="form-control" type="text" id="companyNo"/>
										  	</div>
										</td>
									</tr>
									<tr>
										<td class="cen height-40">대표자 이름</td>
									  	<td colspan="3">
											<div class="col-md-6">
										  		<input class="form-control" type="text" id="companyRep"/>
										  	</div>
										</td>
									</tr>
									<tr>
										<td class="cen height-40">사업자 주소</td>
									  	<td colspan="3">
											<div class="col-md-6">
										  		<input class="form-control" type="text" id="companyAddr"/>
										  	</div>
										</td>
									</tr>									
									<tr>
										<td class="cen height-40">담당자 이름</td>
									  	<td colspan="3">
											<div class="col-md-6">
										  		<input class="form-control" type="text" id="contactName"/>
										  	</div>
										</td>
									</tr>
									<tr>
										<td class="cen height-40">담당자 휴대폰번호</td>
									  	<td colspan="3">
											<div class="col-md-6">
										  		<input class="form-control" type="text" id="contactPhone"/>
										  	</div>
										</td>
									</tr>
									<tr>
										<td class="cen height-40">담당자 전화번호</td>
									  	<td colspan="3">
											<div class="col-md-6">
										  		<input class="form-control" type="text" id="contactTel"/>
										  	</div>
										</td>
									</tr>
									<tr>
										<td class="cen height-40">담당자 메일주소</td>
									  	<td colspan="3">
											<div class="col-md-6">
										  		<input class="form-control" type="text" id="contactMail"/>
										  	</div>
										</td>
									</tr>
									<tr>
										<td class="cen height-40 tac">첨부파일</td>
										<td colspan="3">
											<div id="divFile1" style="display:none;">
												<c:forEach items="${file}" var="filelist" varStatus="status" >
													<div>
														<input type="button" value="삭제" class="btn btn-danger f11" onclick="delFile('${filelist.fileId}')">
														${filelist.fileName}
													</div>
												</c:forEach>
											</div>
											<div id="divFile2">
												<form id="file-form" name="file-form" action="${contextPath}/mbr/cmm/file/insert" method="post"  enctype="multipart/form-data">
													<div class="col-md-12 tac" style='padding-left:0px;'>
														<input type='file' id='files' name='files'/>
													</div>
													<div class="col-md-12 mb20">
												       	<div id="files-list" style="padding:10px;"></div>
												    </div>
											    </form>					
											</div>											
										</td>
									</tr>							
								</tbody>
							</table>	
						</div>
						<!-- end normal input table---------->
					<!-- end panel -->



					
					<!-- begin button-->
					<div class="col-md-12 tac">
						<input type="button" id="noticeModify" value="저장" class="btn btn-primary width-100" onclick="noticeBbsInsert()">
				        <input type="button" id="noticeList" value="취소" class="btn btn-grey width-100" onclick="moveListPage()">
					</div>
					<!-- end button -->
				
				</div>
                <!-- end col-12 -->	

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
				, "programSeq" : $("#companyId").val()
			},
			success : function(data) {
				location.reload();			
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		})
		
	}

	// 상세정보 가져오기
	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/operation/company/detail",
			dataType : "JSON",
			data : {
				"companyId" : $("#companyId").val()
			},
			success : function(data) {
				var result = data;

				$("#companyName").val(result.companyName);
				$("#companyNo").val(result.companyNo);
				$("#companyRep").val(result.companyRep);
				$("#companyAddr").val(result.companyAddr);
				$("#contactName").val(result.contactName);
				$("#contactPhone").val(result.contactPhone);
				$("#contactTel").val(result.contactTel);
				$("#contactMail").val(result.contactMail);
				$("#delFlag").val(result.delFlag);

				if($("#filesCnt").val() != "0"){
					$("#divFile1").show();
					$("#divFile2").hide();
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	// 등록/수정
	function noticeBbsInsert() {
		
		$.ajax({
			url : "${contextPath}/mng/operation/company/insert",
			dataType : "JSON",
			type : "POST",
			data : {
				"companyId" : $("#companyId").val()
				, "companyName" : $("#companyName").val()
				, "companyNo" : $("#companyNo").val()
				, "companyRep" : $("#companyRep").val()
				, "companyAddr" : $("#companyAddr").val()
				, "contactName" : $("#contactName").val()
				, "contactPhone" : $("#contactPhone").val()
				, "contactTel" : $("#contactTel").val()
				, "contactMail" : $("#contactMail").val()
				, "delFlag" : $("#delFlag").val()
			},
			success : function(data) {
				var result = data;
 				if(result==1){
					$('#file-form').submit();
				}else{
					alertBox3("fail!!");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		})
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/operation/company/";
	}
	
	// 상세 페이지이동
	function moveDetailPage(){
		var params = "?companyId="+$("#companyId").val();
		location.href = "${contextPath}/mng/operation/company/view"+params
 	}

	$(document).ready(function() {
		App.init();
		
		if($("#companyId").val() != 0 ){
			getDetail();
		}
		
		$('#files').MultiFile({
			list: "#files-list"
			, max : 1
			//, accept : 'gif|jpg|png'
			, maxFile : 10024
			, maxSize :  50024
			, STRING : {
				//remove : "<input type='button' value='삭제' class='btn btn-danger' style='font:8px;padding-bottom:2px;'>"
				duplicate : "$file 은 이미 선택된 파일입니다."
				, denied : "$ext 는(은) 업로드 할수 없는 파일 확장자 입니다."
				, toomuch : "업로드 할 수 있는 최대크기를 초과하였습니다.($size)"
				, toomany : "업로드 할 수 있는 최대 갯수는 $max개 입니다."
				, toobig : "$file 은 크기가 매우 큽니다.(max $size)"
			},
		});
		
		$('#file-form').ajaxForm({
			cache:false
			, data : {
				programName: $("#programName").val()
				, programSeq : $("#companyId").val()
			}
			, dataType:"json"
	       	//보내기전 validation check가 필요할경우
	       	, beforeSubmit: function (data, frm, opt) {
	       		var chk = true;
	       		
	       		$.each(data, function(i, val){
	       			if(val.value.size > 10485760){
	       				alertBox3("첨부파일 용량은 10MB를 초과할수 없습니다.");
	       				chk = false;
	       			}
	       		}); 
	       },
	       //submit이후의 처리
	       success: function(data, statusText){
	           //alertBox3("전송성공!!");
	           moveListPage();
	       },
	       //ajax error
	       error: function(e){
	           //alertBox3("파일 업로드 에러발생!!");
	       }                               
		});
		
		//메뉴활성화
		$("#request").addClass("active");
		$("#operationCompany").addClass("active");
	});
	
</script>
</body>
</html>