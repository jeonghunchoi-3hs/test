<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin header -->
			<h1 class="page-header"><span class="root"> <span class="home"></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow"><a href="${wasPath}/mbr/bbs/notice/">사용문의</a></span><span class="text arrow mint"><a href="${wasPath}/mbr/bbs/qna/"><strong>Q&amp;A</strong></a></span></span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<p class="page_title">Q&amp;A</p>
					
				<div class="cs_visual">
				<div class="left_text"><i class="fa fa-question-circle-o"></i></div>
			    <div class="right_text"><i class="fa fa-commenting-o"></i></div>
				<strong>K-Cloud의 궁금한 점을 물어보세요.</strong>
				<p>문의사항에 대한 답변을 빠르게 해결해 드리도록 하겠습니다.</p>
			    </div>
				
				<!-- begin col-12 -->
				<div class="col-md-12">
				
					<div class="form_qnaWrite">
						<div class="formTitle">등록하기</div>
						<input type="hidden" id="qnaNo" value="${qnaNo}">
						<div class="formBoxWrap">
							<table>
								<colgroup>
									<col width="8%">
									<col width="92%">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" class="vm">유형</th>
										<td>
											<div class="searchBoxArea dpin width-750"> 
										  		<div>	
										  			<label class="selectBoxDrop" for="qnaType">유형을 선택하세요</label>	                  		
							                  		<select name="qnaType" id="qnaType" class="search-sel">
							                  			<option value="">유형을 선택하세요</option>
														<c:forEach items="${code}" var="codelist" varStatus="status" >
															<option value="${codelist.codeId}">${codelist.codeName}</option> 
														</c:forEach>
							                  		</select>
							                  	</div>
							                  </div>
											<label class="check_lock"><input type="checkbox" name='secretFlag' id="secretFlag" value="Y"> <span>비공개</span></label>
										</td>
									</tr>
									<tr>
										<th scope="row" class="vm">제목</th>
										<td><input maxlength="30" class="form-control" type="text" placeholder="제목을 입력하세요" style="width:100%;" id="title"></td>
									</tr>
									<tr>
										<th scope="row" class="vat p-t-20">내용</th>
										<td><textarea placeholder="내용을 입력하세요" style="width:100%;" id="_content"></textarea></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="btn_area">	
							<c:if test="${qnaNo eq ''}">
								<a href="javascript:void(0);" class="bbton bton_blue" onclick="qnaBbsInsert();"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-upload"></i></span><span class="dpin ml16">등록</span></a>
							</c:if>
							<c:if test="${qnaNo ne ''}">
								<a type="button" class="bbton bton_blue" onclick="qnaBbsInsert();"><span class="dpin dd bton_dblue ml-1"><i class="fa fa-floppy-o"></i></span><span class="dpin ml16">저장</span></a>
							</c:if>
							<a type="button" class="bbton bton_dgrey ml10" onclick="moveListPage()"><span class="dpin dd bton_ddgrey ml-1"><i class="fa fa-close"></i></span><span class="dpin ml16">취소</span></a>  
						</div>
					</div>
				</div>
                <!-- end col-12 -->	

			</div>
			<!-- end page-body -->				
							
			
			<!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
		
	</div>
	<!-- end page container -->

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	function bbsDetail(qnaNo) {
		$.ajax({
			url : "${wasPath}/mbr/bbs/qna/detail",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"qnaNo" : qnaNo
			},
			success : function(data) {
				var result = data;
				setData(result);
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox("code:" + request.status + "\n" + "error:" + error, logout);
				}		
			}
		})
	}
	
	
	function validationCheck(){
		var title = $("#title").val();
		var content = $("#_content").val();
		var qnaType = $("#qnaType > option:selected").val();
		
		if(qnaType==""){
			alertBox3("유형을 선택해주세요");
			$("#qnaType").focus();
			return false;
		}
		if(title==""){
			alertBox3("제목을 입력해주세요");
			$("#title").focus();
			return false;
		}
		if(content==""){
			alertBox3("내용을 입력해주세요.");
			$("#_content").focus();
			return false;
		}
		return true;
	}
	
	
	function qnaBbsInsert() {
		
		if(!validationCheck()){
			return;
		}
		
		$.ajax({
			url : "${wasPath}/mbr/bbs/qna/insert",
			dataType : "JSON",
			type : "POST",
			data : setJsonData(),
			success : function(data) {
				var result = data;
				if(result==1){
					alertBox("저장되었습니다.", moveListPage);
				}else{
					errorBox("등록실패");
				}
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox("code:" + request.status + "\n" + "error:" + error, logout);
				}		
			}
		})

	}
	
	function setJsonData(){
		
		var jsonData = {
				"qnaNo" : $("#qnaNo").val()
				, "qnaType": $("#qnaType > option:selected").val()             
				, "title": $("#title").val()                
				, "content":$("#_content").val()
				, "secretFlag":$("input:checkbox[name='secretFlag']:checked").val()
				, "regUserId":"${userId}"
				, "modUserId":"${userId}"
				, "delFlag":"N"
				};
		return jsonData;
	}
	
	
	function setData(result){
		
		$("#title").val(result.title);
// 		$("#regDatetime").val(result.regDatetime);
		$("#regUserId").text(result.regUserId);
		
		$("#qnaType > option[value='"+result.qnaType+"']").attr("selected", "selected");
		$("#qnaType").siblings(".selectText").text($("#qnaType").children('option:selected').text());
		
		$("#_content").val(result.content);
		if(result.secretFlag=="Y"){
			//alert(result.secretFlag);
			$("input:checkbox[name='secretFlag']").attr("checked",true);
		}
		//$("#secretFlag").val(result.secretFlag);
		//$("#dispSdate").val(result.dispSdate);
		//$("#dispEdate").val(result.dispEdate);
	}
	
	// 목록 페이지이동
	function moveListPage(){
		
// 		if($("#qnaNo").val() != 0 ){
// 			location.href = "${wasPath}/mbr/bbs/qna/view?qnaNo="+$("#qnaNo").val();
// 		}else{
// 			location.href = "${wasPath}/mbr/bbs/qna/";
// 		}
			location.href = "${wasPath}/mbr/bbs/qna/";
	}
	
	// 상세 페이지이동
	function moveDetailPage(){
		if($("#qnaNo").val() != 0 ){
			location.href = "${wasPath}/mbr/bbs/qna/view?qnaNo="+$("#qnaNo").val();
		}else{
			location.href = "${wasPath}/mbr/bbs/qna/";
		}
		
 	}
	
	
	$(document).ready(function() {
		App.init();
		
		if($("#qnaNo").val() != "0" ){
			bbsDetail($("#qnaNo").val());
		}
		
		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsQna").addClass("active");

	});
	
</script>

</body>
</html>