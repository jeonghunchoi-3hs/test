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
			
			<div class="page_header mb30">
				<h1>회원사 등록</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">회원사 등록</a>
				</div>
			</div>
			
			<!-- begin page-body -->
			<div class="row mb50 m-t-30">
			
				<div class="formType01">
					<p class="txt_guide">필수항목 입니다</p>
					<div class="tblWrap clearfix">
						<input type="hidden" id="programName" value="cmm_customer">
						<input type="hidden" id="filesCnt" value="${filesCnt}">
						<input type="hidden" id="h_idChk" value="">
						<input type="hidden" id="ref_company_id" value="${refCompanyId}">
						<table>
							<colgroup>
								 <col width="15%">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th class="tal pl60"><strong class="require">회원사 코드</strong></th>
									<td><input type="text" style="width:100%" name="customerId" id="customerId"  maxlength="20"></td>
								</tr>
								 <!-- <tr>
									<th scope="row"><strong class="require">고객사</strong></th>
									<td>
										<input type="text" class="m-r-5" style="width:342px;" maxlength="40" id ="upCompanyName" disabled>
										<input type="text" style="width:260px;" maxlength="40" id ="downCompanyName" disabled>
										<input type="hidden" id ="refCompanyId">
										<a type="button" class="bton-s bton_blue" onclick="openModal();"><span class="txt"><i class="fa fa-search"></i> 검색</span></a>
									</td>
								</tr> -->
								<tr>
									<th class="tal pl60"><strong class="require">회원사명</strong></th>
									<td><input type="text" style="width:100%" name="customerName" id="customerName" maxlength="40" placeholder="사업자명을 입력하세요"></td>
								</tr>
								<tr>
									<th class="tal pl60"><strong class="require">사업자 등록번호</strong></th>
									<td>
										<input type="text" class="fontVdn" name="companyNo1" id="companyNo1" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" maxlength="3" style="width:108px;"/>
										<span class="txt_hyphen"></span> 
						                <input type="text" class="fontVdn" name="companyNo2" id="companyNo2" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" maxlength="2" style="width:108px;"/> 
						                <span class="txt_hyphen"></span> 
						                <input type="text" class="fontVdn" name="companyNo3" id="companyNo3" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" maxlength="5" style="width:108px;"/>
									</td>
								</tr>
								<tr>
									<th class="tal pl60"><strong>법인 등록번호</strong></th>
									<td>
										<input type="text" class="fontVdn" name="corporationNo1" id="corporationNo1" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" maxlength="6" style="width:171px;"/> 
						                <span class="txt_hyphen"></span> 
						                <input type="text" class="fontVdn" name="corporationNo2" id="corporationNo2" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" maxlength="7" style="width:171px;"/> 
						                <input type="hidden" name="corporationNo3" id="corporationNo3" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"/>
									</td>
								</tr>
								<tr>
									<th class="tal pl60"><strong class="require">대표자명</strong></th>
									<td><input type="text" style="width:100%" name="companyRep" id="companyRep" maxlength="20" placeholder="대표자명을 입력하세요"></td>
								</tr>
								<tr>
									<th class="tal pl60"><strong>업태</strong></th>
									<td><input type="text" style="width:100%" name="bizCondition" id="bizCondition" maxlength="100" placeholder="사업자등록증 상의 업태를 입력하세요"></td>
								</tr>
								<tr>
									<th class="tal pl60"><strong>업종</strong></th>
									<td><input type="text" style="width:100%" name="bizType" id="bizType" maxlength="100" placeholder="사업자등록증 상의 업종을 입력하세요"></td>
								</tr>
								<tr>
									<th class="tal pl60"><strong>사업자 등록증</strong></th>
									<td>
										<div class="row">
											<div class="fileArea">
												<input type="text" style="width:584px;" id ='fileTitleName' readonly="readonly">
												<a type="button" class="bton-s bton_blue"><i class="fa fa-file-text-o"></i> <span class="txt"> 찾아보기</span></a>
												<form id="file-form" name="file-form" action="${contextPath}/mng/cmm/file/insert" method="post" enctype="multipart/form-data" >
												<input type="file" id="files" name="files" accept=".jpg,.jpeg,.JPG,.JPEG,.pdf,.PDF" onclick="delSelectedFile();" onchange="setFileName();" multiple class="multi" data-maxfile="300"/>      
												<!-- <div id="files-list"></div>  -->
												</form>
											</div>
											<div class="row m-t-10" id = 'fileNone'>
												<p class="txt_guide_type01"> <i class="fa fa-warning"></i> JPEG, JPG, PDF 파일만 선택 가능합니다.</p>
											</div> 
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
				<!-- #modal-dialog -->
                 <div class="modal fade" id="modal-dialog"> 
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">계열사 지정</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="page_searchBox m-b-15">
									<div class="searchArea">
										<div class="inputArea m-l-5">
											<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)openModal();">
											<a type="button" class="bton-s bton_blue" onclick="openModal();" >검색</a>
										</div>
									</div>
								</div>
								
								<div class="noneList" style="display: none;">
									 <span>검색된 계열사가 없습니다.</span>
								</div> 
								<div class="listArea" id="popListTable"></div>
	                      		<div class="totalcnt" id="totalCnt">총 0 건</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="pbton bton_blue" data-dismiss="modal" id ="popclose">닫기</a>
	                       	</div>
		               	</div>
					</div>
                 </div>
				
				<!-- #modal-dialog -->
				<div class="modal fade" id="message-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">알림</h4>
	                       </div>
	                       <div class="modal-body">
	                           <h5 id="confirmMsg"></h5>
	                        </div>
	                       	<div class="modal-footer tac" id="setBtn">
<!-- 	                       		<a type='button' class="btn width-100 btn-default" data-dismiss="modal" onclick="">닫기</a> -->
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
	
				
				<!-- begin button----------->
		 		<div class="row tac mt30">
		 			<a type="button" class="rbton bton_blue" id="jquerybuttonok" name="jquerybuttonok" onclick="reqcustomerInsertValidation()"><i class="fa fa-upload"></i> 등록</a>
		 			<a type="button" class="rbton bton_dgrey" onclick="movePage();"> <i class="fa fa-close"></i> 취소</a>
                 </div>
				<!-- end button----------->
	
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

	function actFileUpload(){
		$('#file-form').ajaxForm({				
			cache:false
			, data : {				
				programName: $("#programName").val()
				, programSeq : $("#customerId").val()
				//, programSeq2 : $("#customerId").val()
			}
			, dataType:"json"
	       	//보내기전 validation check가 필요할경우
	       	, beforeSubmit: function (data, frm, opt) {
	           //alertBox3("전송전!!");
	           return true;
	       },
	       //submit이후의 처리
	       success: function(data, statusText){
	    	   alertBox("등록이 완료되었습니다.", movePage);
// 	           alertBox3("전송성공!!");
// 	           moveListPage();
	       },
	       //ajax error
	       error: function(e){
	           //alertBox3("파일 업로드 에러발생!!");
	       }                               
		});
		$('#file-form').submit();

	}
	
	
	// 등록/수정
	function reqcustomerInsertValidation() {
		if($("#customerId").val()==""){
			alertBox3("고객사 아이디를 입력하세요");
			$("#customerId").focus();
			return false;
		}
		
		if($("#h_idChk").val()=="false"){
			alertBox3("이미 등록된 고객사 아이디입니다.");
			$("#customerId").focus();
			return false;
		}
		
		/* if($("#refCompanyId").val()==""){
			 alertBox("고객사 정보를 입력하세요", openModal);
			return false;
		}
		if($("#companyName").val()==""){
			alertBox3("사업자명를 입력하세요");
			$("#companyName").focus();
			return false;
		} */
		if($("#companyNo1").val()==""){
			alertBox3("사업자 등록번호를 입력하세요");
			$("#companyNo1").focus();
			return false;
		}
		if($("#companyNo2").val()==""){
			alertBox3("사업자 등록번호를 입력하세요");
			$("#companyNo2").focus();
			return false;
		}
		if($("#companyNo3").val()==""){
			alertBox3("사업자 등록번호를 입력하세요");
			$("#companyNo3").focus();
			return false;
		}
		if($("#corporationNo1").val()==""){
			alertBox3("법인 등록번호를 입력하세요");
			$("#corporationNo1").focus();
			return false;
		}
		if($("#corporationNo2").val()==""){
			alertBox3("법인 등록번호를 입력하세요");
			$("#corporationNo2").focus();
			return false;
		}
		
		/* if($("#corporationNo3").val()==""){
			alertBox3("법인 등록번호를 입력하세요");
			$("#corporationNo3").focus();
			return false;
		} */
		if($("#companyRep").val()==""){
			alertBox3("대표자명를 입력하세요");
			$("#companyRep").focus();
			return false;
		}
/* 		if($("#vatRate > option:selected").val()==""){
			warningBox("부가가치세율을 입력하세요");
			$("#vatRate").focus();
			return false;
		} */
		confirmBox("등록하시겠습니까? ", reqcustomerInsert);
	}
	
	function reqcustomerInsert(){
		$.ajax({
			url : "${contextPath}/mng/cmm/customer/customerInsert",
			dataType : "JSON",
			type : "POST",
			data : {
					"customerId" : $("#customerId").val()
					, "customerName" : $("#customerName").val()
					, "refCompanyId" : $("#refCompanyId").val()
					//, "companyName" : $("#companyName").val()
					, "companyNo" : $("#companyNo1").val()+"-"+ $("#companyNo2").val()+"-"+ $("#companyNo3").val()
					, "corporationNo" : $("#corporationNo1").val()+"-"+ $("#corporationNo2").val()/* +"-"+ $("#corporationNo3").val() */
					, "companyRep" : $("#companyRep").val()
					, "bizCondition" : $("#bizCondition").val()
					, "bizType" : $("#bizType").val()	
//					, "vatRate" : $("#vatRate > option:selected").val()
					, "vatRate" : "0"
					, "regUserId":"${userId}"
					, "modUserId":"${userId}"
				},
			success : function(data) {
				var result = data;
				if(result==1){
					actFileUpload();
				}else if(result==2){
					alertBox3("기존에 등록된 사업자번호입니다.");
				}else{
					alertBox3("고객사 등록이 되지 않았습니다.");					
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
			
	function movePage(){
		location.href="${contextPath}/mng/cmm/customer/";
	}
	
	function delFile(fileId){
		$.ajax({
			url : "${contextPath}/mng/cmm/file/delete",
			dataType : "JSON",
			data : {
				"fileId" : fileId
				, "programName": $("#programName").val()
				, "programSeq" : $("#customerId").val()
			},
			success : function(data) {
				location.reload();			
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		})
		
	}
	
	// 팝업메시지 세팅	
	/* function alertModal(txt, fn){
		$("#confirmMsg").text(txt);
		$("#setBtn").html("");
		
		if(fn==""||fn=="undefined"){
			var vHtml = "";
			vHtml = '<a type="button" class="btn width-100 btn-grey" data-dismiss="modal">닫기</a>';
			$("#setBtn").html(vHtml);
		}else{
			var vHtml = "";
			vHtml = '<a type="button" class="btn width-100 btn-grey" data-dismiss="modal" onclick="'+fn+'">닫기</a>';
			$("#setBtn").html(vHtml);
		}
		
		$("#message-modal-dialog").modal();
	}
	function openModal(){
		$("#modal-dialog").modal();
		var customerId="${customerId}";		
		var keyword = $("#searchKeyword").val();
		$.ajax({
			url : "companyListModal",
			dataType : "JSON",
			data : {
				"customerId" : customerId	
				,"keyword" : keyword 
			},
			success : function(data) {
				
				var getCustomerMemberList = data.companyList;
				
				$("#popListTable > div").remove();
				$("#totalCnt").text("");
				if(getCustomerMemberList!=""){
					var Html="";
					Html = "<div class='listArea' id='popListTable'>";
					$.each(getCustomerMemberList,function(key,val){
						
						Html +=			"<div class='listBg'>";
						Html +=				"<span class='name2'>"+ val["upCompanyName"] +"</span>";
						Html +=				"<span class='idlabel2'>"+ val["companyName"] +"</span>";
						if( val['companyId'] == $('#refCompanyId').val()){
							Html +=				"<a class='applybtn active' onclick=''>적용</a>";
						}else{
							Html +=				"<a class='applybtn' onclick='changeCompany(\""+val['companyId']+"\",\""+val['upCompanyName']+"\",\""+val['companyName']+"\")'>적용</a>";
						}
						
						
						Html +=			"</div>";
					});
					Html += "</div>";
					
					$("#popListTable").append(Html);
					$("#totalCnt").text("총 "+getCustomerMemberList.length+" 건");
					
				}else{
					var Html="";
					Html = "<div class='noneList' style='display: none;'>";
					Html +=		"<span>검색된 사용자가 없습니다.</span>";
					Html += "</div>";
					
					$("#popListTable").append(Html);
					$("#totalCnt").text("총 0 건");
				}		 
				
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	} */
	
	/* function changeCompany(companyId,upCompanyName,downComapnyName){
		$('#upCompanyName').val(upCompanyName);
		$('#downCompanyName').val(downComapnyName);
		$('#refCompanyId').val(companyId);
		$('#popclose').click();
	} */
	
	function delSelectedFile(){
		$(".MultiFile-remove").trigger('click');
	} 
	
	function setFileName(){
		
// 		$("#fileTitleName").val(e.value.replace("C:\\fakepath\\",""));
		
		setTimeout (function(){
			$("#fileTitleName").val($(".MultiFile-title").text());
		},200);
	}
	
	$(document).ready(function() {		
		App.init();
		
		
		$('#files').MultiFile({
		     list: "#files-list"
			, max : 2
			, accept : 'jpg|jpeg|pdf'
			, max_file : 100 
			, max_size :  200
			, STRING : {
				//remove : "<input type='button' value='삭제' class='btn btn-danger' style='font:8px;padding-bottom:2px;'>"
				 duplicate : "$file 은 이미 선택된 파일입니다."
				, denied : "$ext 는(은) 업로드 할수 없는 파일 확장자 입니다."
				, toomuch : "업로드 할 수 있는 최대크기를 초과하였습니다.($size)"
				, toomany : "업로드 할 수 있는 최대 갯수는 $max개 입니다."
				, toobig : "$file 은 크기가 매우 큽니다.(max $size)"
			},
		});
		
		//고객사 ID 중복체크
		$("#customerId").blur(function(event){
			
			//특수문자 & 공백 입력 제한
	 		if(!(event.KeyCode>=37 && event.keyCode<=40)){
	 			var inputVal = $(this).val();
	 			$(this).val(inputVal.replace(/[^a-z0-9_-]/gi,''));
	 		}
			
			//alertBox3("키보드입력");
			if($("#customerId").val()!=""){
				$.post("<c:url value="/mbr/req/customer/customerIDajaxcheck"/>",
						{"customerId":$("#customerId").val()},
						function(data){
							if(data == "true"){
								//alertBox3(1);
// 								alertBox3("사용가능한 ID 입니다.");
// 								$("#customerIdchktxt").css("color", "blue");								
// 								$("#customerIdchktxt").text("사용 가능한 ID입니다.");
								$("#h_idChk").val("true");
							}else{
								//alertBox3(2);
// 								alertBox3("사용중인 ID 입니다.");
// 								$("#customerIdchktxt").css("color","red");
// 								$("#customerIdchktxt").text("이미 사용중인 ID입니다.");
								$("#h_idChk").val("false");
							}
						});
			}else{
				$("#h_idChk").val("");
// 				$("#customerIdchktxt").text("");
			}
		});
		
		//메뉴활성화
		$("#customerInfo").addClass("active");
	});
	
</script>

</body>
</html>