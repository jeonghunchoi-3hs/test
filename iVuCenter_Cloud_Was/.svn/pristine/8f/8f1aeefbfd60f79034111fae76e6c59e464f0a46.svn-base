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
	<meta http-equiv="X-UA-Compatible" >
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
				<h1>회원사 수정</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">회원사 수정</a>
				</div>
			</div>
			
			
			<!-- begin page-body -->
			<div class="row mb50 m-t-30">
			
				<div class="formType01">
					<p class="txt_guide">필수항목 입니다</p>
					<div class="tblWrap clearfix">
						<input type="hidden" id="programName" value="cmm_customer">
						<input type="hidden" id="filesCnt" value="${filesCnt}">
						<table>
							<colgroup>
								 <col width="15%">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th class="tal pl60"><strong class="require">회원사 코드</strong></th>
									<td class="fontVdn">
										${getCustomerVo.customerId}
										<input type="hidden" name="customerId" id="customerId" value="${getCustomerVo.customerId}"/>
										<input type="hidden" name="refCompanyId" id="refCompanyId" value="${getCustomerVo.refCompanyId}"/>
									</td>
								</tr>
							<!-- 	<tr>
									<th scope="row"><strong class="require">고객사</strong></th>
									<td>
										<div class="cmmeditArea">
											<span class="pull-left" id ="companyNameArea">${getCustomerVo.upCompanyName} / ${getCustomerVo.downCompanyName}</span>
											<input type="hidden" name="refCompanyId" id="refCompanyId" value="${getCustomerVo.refCompanyId}"/>
											<a type="button" class="bton-s bton_blue flr" onclick="openModal();"><span class="txt"><i class="fa fa-search"></i> 검색</span></a>
										</div>

									</td>
								</tr> -->
								<tr>
									<th class="tal pl60"><strong class="require">회원사명</strong></th>
									<td><input type="text" name="customerName" id="customerName" maxlength="40" value="${getCustomerVo.customerName}" style="width:100%;" /></td>
								</tr>
								<tr>
									<th class="tal pl60"><strong class="require">사업자 등록번호</strong></th>
									<td>
										<input type="text" name="companyNo1" id="companyNo1" value="${getCustomerVo.companyNo1}" maxlength="3" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" style="width:108px;"/>
							            <span class="txt_hyphen"></span>
							            <input type="text" name="companyNo2" id="companyNo2" value="${getCustomerVo.companyNo2}" maxlength="2" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" style="width:108px;"/>
							            <span class="txt_hyphen"></span>
							            <input type="text" name="companyNo3" id="companyNo3" value="${getCustomerVo.companyNo3}" maxlength="5" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" style="width:108px;"/>
									</td>
								</tr>
								<tr>
									<th class="tal pl60"><strong>법인 등록번호</strong></th>
									<td>
										<input type="text" value="${getCustomerVo.corporationNo1}" name="corporationNo1" id="corporationNo1" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"  maxlength="6" style="width:171px;"/> 
						                <span class="txt_hyphen"></span> 
						                <input type="text" value="${getCustomerVo.corporationNo2}" name="corporationNo2" id="corporationNo2" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"  maxlength="7" style="width:171px;"/> 
						                <input type="hidden" value="${getCustomerVo.corporationNo3}" name="corporationNo3" id="corporationNo3" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"  />
									</td> 
								</tr>
								<tr>
									<th class="tal pl60"><strong class="require">대표자명</strong></th>
									<td><input type="text" value="${getCustomerVo.companyRep}" style="width:100%" name="companyRep" id="companyRep" maxlength="20"></td>
								</tr>	
								<tr>
									<th class="tal pl60"><strong>업태</strong></th>
									<td><input type="text" value="${getCustomerVo.bizCondition}" style="width:100%" name="bizCondition" id="bizCondition" maxlength="40"></td>
								</tr>
								<tr>
									<th class="tal pl60"><strong>업종</strong></th>
									<td><input type="text" value="${getCustomerVo.bizType}" style="width:100%" name="bizType" id="bizType" maxlength="40"></td>
								</tr>
				
								<tr>
									<th class="tal pl60"><strong>사업자 등록증</strong></th>
									<td>
										<div class="row">
											<div class="fileArea">
												<input type='hidden' id ='fileUpFlag' value ='N'>
												<input type="text" style="width:584px;" id ='fileTitleName' readonly="readonly" value = <c:forEach items="${file}" var="filelist" varStatus="status" >${filelist.fileName}</c:forEach>>
												<input type="hidden" id='fileId' name = 'fileId' value =<c:forEach items="${file}" var="filelist" varStatus="status" >${filelist.fileId}</c:forEach>>
												<a href="#" class="bton-s bton_blue"><i class="fa fa-file-text-o"></i> <span class="txt"> 찾아보기</span></a>
												<form id="file-form" name="file-form" action="${contextPath}/mng/cmm/file/update" method="post" enctype="multipart/form-data">
													
												<input type="file" id ='files' name ='files' accept=".jpg,.jpeg,.JPG,.JPEG,.pdf,.PDF" onclick="delSelectedFile();" onchange="setFileName();" >
												<div id="files-list" ></div> 
												</form>
											</div>
											<c:if test ='${filesCnt ==0}'><div class="row m-t-10" id = 'fileNone'>
												<p class="txt_guide_type01">선택된 파일 없음</p>
											</div>
											</c:if>
											<c:if test ='${filesCnt ne 0}'><div class="row m-t-10" id = 'fileNone'>
												<p class="txt_guide_type01"><i class="fa fa-warning"></i> JPEG, JPG, PDF 파일만 선택 가능합니다.</p>
											</div>
											</c:if>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
	                	
						<!-- begin normal input table---
						<div class="tableC">												
							<input type="hidden" id="programName" value="cmm_customer">
							<input type="hidden" id="filesCnt" value="${filesCnt}">
								<table>
									<colgroup>
										 <col width="20%">
										 <col width="80%">
									</colgroup>
									<tbody>
										<tr>
											<td class="left-b height-40"><span class='ml-10' style="color:red;">*</span> 고객사아이디</td>
										  	<td class="f14 fb">
												<div class="col-sm-6 pl0">
											 		${getCustomerVo.customerId}
											 		<input type="hidden" name="customerId" id="customerId" value="${getCustomerVo.customerId}"/>
							                 	</div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b height-40"><span class='ml-10' style="color:red;">*</span> 고객사 이름</td>
										  	<td class="f14 fb">
												<div class="col-sm-6 pl0">
										      		<input type="text" name="customerName" id="customerName" maxlength="40" class="form-control" value="${getCustomerVo.customerName}" />			                  		
							                  	</div>
										  	</td>
										</tr>										
										<tr>
											<td class="left-b height-40"><span class='ml-10' style="color:red;">*</span> 사업자명</td>
										  	<td class="f14 fb">
												<div class="col-sm-6 pl0">
													<input type="text" name="companyName" id="companyName" maxlength="40" class="form-control" value="${getCustomerVo.companyName}" />										  			    	
							                  	</div>
										  	</td>
										</tr>
										<tr>
										 	<td class="left-b height-40"><span class='ml-10' style="color:red;">*</span> 사업자 등록번호</td>
										  	<td class="f14 fb">
										  		<div class="col-sm-6 pl0">
										  			<input type="text" name="companyNo1" id="companyNo1" class="form-control width-80 dpin" value="${getCustomerVo.companyNo1}" maxlength="3"/> - 
							                  		<input type="text" name="companyNo2" id="companyNo2" class="form-control width-80 dpin" value="${getCustomerVo.companyNo2}" maxlength="2"/> - 
							                  		<input type="text" name="companyNo3" id="companyNo3" class="form-control width-80 dpin" value="${getCustomerVo.companyNo3}" maxlength="5"/>
							                  	</div>
										  	</td>
										</tr>
										<tr>
										 	<td class="left-b height-40"><span class='ml-10' style="color:red;">*</span> 법인 등록번호</td>
										  	<td class="f14 fb">
										  		<div class="col-sm-6 pl0">
							                  		<input type="text" name="corporationNo1" id="corporationNo1" class="form-control width-100 dpin" value="${getCustomerVo.corporationNo1}" maxlength="6"/> - 
							                  		<input type="text" name="corporationNo2" id="corporationNo2" class="form-control width-100 dpin" value="${getCustomerVo.corporationNo2}" maxlength="7"/> 
<!-- 							                  		<input type="text" name="corporationNo3" id="corporationNo3" class="form-control width-80 dpin" value="" />
							                  	</div>
										  	</td>
										</tr>										
										<tr>
											<td class="left-b height-40"><span class='ml-10' style="color:red;">*</span> 대표자명</td>
										  	<td class="f14 fb">
												<div class="col-sm-6 pl0">
										  			<input type="text" name="companyRep" id="companyRep" maxlength="20" class="form-control" value="${getCustomerVo.companyRep}" />			                  		
							                  	</div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b height-40">업태</td>
										  	<td class="f14 fb">
												<div class="col-sm-6 pl0">
										  			<input type="text" name="bizCondition" id="bizCondition" class="form-control" maxlength="40" value="${getCustomerVo.bizCondition}" />			                  		
							                  	</div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b height-40">업종</td>
										  	<td class="f14 fb">
												<div class="col-sm-6 pl0">
										  			<input type="text" name="bizType" id="bizType" class="form-control" maxlength="40" value="${getCustomerVo.bizType}"/>			                  		
							                  	</div>
										  	</td>
										</tr>
										<tr>
											<td style='display:none;' class="left-b height-40"><span class='ml-10' style="color:red;">*</span> 부가가치세율</td>
										  	<td style='display:none;' class="f14 fb">
												<div class="col-sm-6 pl0">
										  			<select class="form-control" name="vatRate" id="vatRate">
										  				<option value="">선택</option>
													<c:forEach items="${vatRateList}" var="vatRateList" varStatus="status" >
														<option value="${vatRateList.codeId}" <c:if test='${vatRateList.codeId eq getCustomerVo.vatRate}'> selected </c:if>>${vatRateList.codeName}%</option>
													</c:forEach>
													</select>		                  		
							                  	</div>
										  	</td>
										</tr>
										<tr>
											<td class="left-b height-40">사업자 등록증</td>
										  	<td class="f14 fb">
										  												
								                <!-- <div id="divFile1" style="display:none;"> 
								                 <div id="divFile1">
													<c:forEach items="${file}" var="filelist" varStatus="status" >
														<div>
															<input type="button" value="삭제" class="btn btn-danger f11" onclick="delFile('${filelist.fileId}')">
															${filelist.fileName}
														</div>
													</c:forEach>
												</div>
												<div id="divFile2" <c:if test='${filesCnt ne "0"}'> style="display:none;" </c:if>>
													<form id="file-form" name="file-form" action="${contextPath}/mng/cmm/file/insert" method="post" enctype="multipart/form-data">
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
							end normal input table---------->
						<!-- end panel -->
						
				<!-- begin button----------->
		 		<div class="row tac m-t-60">
		 			<a type="button" class="rbton bton_blue" id="jquerybuttonok" name="jquerybuttonok" onclick="customerEdit()"><i class="fa fa-floppy-o"></i> 저장</a>
		 			<a type="button" class="rbton bton_dgrey" onclick="movePage();"> <i class="fa fa-close"></i> 취소</a>
                </div>
				<!-- end button----------->
							

	
			</div>
			<!-- end page-body -->
			
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
									<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)openModal();" style="width: 362px">
									<a type="button" class="btn_search" onclick="openModal();">검색</a>
								</div>
							</div>
						</div>
						
						<div class="noneList" style="display: none;">
							 <span>검색된 계열사가 없습니다.</span>
						</div> 
						
						 <div class="listArea" id="popListTable">
						<!-- <div class="listArea">
							<div class="listBg">
								<span class="name2">쓰리에이치에스</span>
								<span class="idlabel2">솔루션사업부</span>
								<a class="applybtn" >적용</a>
							</div>
							<div class="listBg">
								<span class="name2">쓰리에이치에스</span>
								<span class="idlabel2">솔루션사업부</span>
								<a class="applybtn" >적용</a>
							</div>
							<div class="listBg">
								<span class="name2">쓰리에이치에스</span>
								<span class="idlabel2">솔루션사업부</span>
								<a class="applybtn" >적용</a>
							</div>
							<div class="listBg">
								<span class="name2">쓰리에이치에스</span> 
								<span class="idlabel2">솔루션사업부</span>
								<a class="applybtn" >적용</a>
							</div>-->
                     		</div>
                     		<div class="totalcnt" id="totalCnt">총 4 건</div>
                   	</div>
                   	<div class="modal-footer tac">
                      		<a type="button" class="whiteline" data-dismiss="modal" id ='popclose' >닫기</a>
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
		
		
            <!-- begin #footer -->
            <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

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
	}
	

	function actFileUpload(){
	/* 	var form = new FormData();
		form.append('fileId',$("#fileId").val());
		form.append('programName',$("#programName").val());
		form.append('programSeq',$("#customerId").val());
		
		form.append('files',$("#files")[0].files[0]);

		  $.ajax({
			 url :"${contextPath}/mng/cmm/file/update"
			 ,processData : false
			 ,contentType : false
			 ,data : form
			 ,type : "POST"
			 ,success : function(){
				 alertBox("저장되었습니다.", movePage);
 	           moveListPage();
			 }
		 })   */

		$('#file-form').ajaxForm({				
			cache:false
			, data : {				
				fileId : $("#fileId").val()
				,programName: $("#programName").val()
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
	           alertBox("저장되었습니다.", movePage);
// 	           moveListPage();
	       },
	       //ajax error
	       error: function(e){
	    	   alertBox3("파일 업로드 에러발생!!");
	       }                               
		});
		$('#file-form').submit();
		
	}
	
	// 등록/수정
	function customerEdit() {
		if($("#customerName").val()==""){
			alertBox3("회원사명을 입력하세요");
			$("#customerName").focus();
			return false;
		}
		/* if($("#companyName").val()==""){
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
		if($("#vatRate > option:selected").val()==""){
			alertBox3("부가가치세율을 입력하세요");
			$("#vatRate").focus();
			return false;
		}		
		$.ajax({
			url : "${contextPath}/mng/cmm/customer/customerEdit",
			dataType : "JSON",
			type : "POST",
			data : {
					"customerId" : $("#customerId").val()
					,"customerName" : $("#customerName").val()
					,"refCompanyId" : $('#refCompanyId').val()					
					, "companyName" : $("#companyName").val()
					, "companyNo" : $("#companyNo1").val()+"-"+ $("#companyNo2").val()+"-"+ $("#companyNo3").val()
					, "corporationNo" : $("#corporationNo1").val()+"-"+ $("#corporationNo2").val()
					, "companyRep" : $("#companyRep").val()
					, "bizCondition" : $("#bizCondition").val()
					, "bizType" : $("#bizType").val()	
					, "vatRate" : $("#vatRate > option:selected").val()
					, "regUserId":"${userId}"
					, "modUserId":"${userId}"
				},
			success : function(data) {
				var result = data;
		 		if(result==1){
		 			actFileUpload();
				}else{
					alertBox3("fail!!");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		})
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
		});
	}
	
	// 팝업메시지 세팅	
	function alertModal(txt, fn){
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

	
	function changeCompany(companyId,upCompanyName,downComapnyName){
		$('#companyNameArea').text(upCompanyName + " / " + downComapnyName);
		$('#refCompanyId').val(companyId);
		$('#popclose').click();
	}
	
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
		
		//고객사 ID 중복체크
		$("#customerId").keyup(function(event){
			
			//특수문자 & 공백 입력 제한
	 		if(!(event.KeyCode>=37 && event.keyCode<=40)){
	 			var inputVal = $(this).val();
	 			$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
	 		}
			
			//alertBox3("키보드입력");
			if($("#customerId").val()!=""){
				$.post("<c:url value="/mbr/req/customer/customerIDajaxcheck"/>",
						{"customerId":$("#customerId").val()},
						function(data){
							//alertBox3(data);
							if(data == "true"){
								//alertBox3(1);
								//alertBox3("사용 가능한 ID ID입니다.");
								$("#customerIdchktxt").text("사용 가능한 ID입니다.");								
							}else{
								//alertBox3(2);
								//alertBox3("사용중인 ID입니다.");
								$("#customerIdchktxt").text("이미 사용중인 ID입니다.");
							}
						});
			}else{
				$("#customerIdchktxt").text("");
			}
		});
		
		//메뉴활성화
		$("#customerInfo").addClass("active");
	});

</script>

</body>
</html>