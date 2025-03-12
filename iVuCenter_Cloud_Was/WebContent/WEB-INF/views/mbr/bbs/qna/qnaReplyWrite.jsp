<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			<!-- begin page-header -->
			<h1 class="page-header"><img src="${apachePath}/resources/images/title_icon/Q&A.png"/>  Q&A  <span class="root"> <img src="/resources/assets/img/root_icon.png"/> 콘솔 > 사용문의 > Q&A  </span></h1>
			<!-- end page-header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				<!-- begin col-12 -->
				<div class="col-md-12">
					<!-- begin panel -->
						<!-- begin normal input table---------->
						<div class="tableC2 mb20">
							<input type="hidden"  id="parentQnaNo" value="${parentQnaNo}">
							<input type="hidden"  id="qnaNo" value="${qnaNo}">
							<table>
								<colgroup>
									<col width="100px">
									<col width="*">
								</colgroup>
								
								<tbody>
									<tr>
										<td class="left-b">작성자</td>
										<td  id="regUserId">${userId}
										</td>
									</tr>
									<tr>
										<td class="left-b"><span style="color:red;">* </span>내용</td>
									  	<td>
										  		<textarea class="form-control" rows="15" placeholder="내용을 입력하세요"  id="_content"></textarea>

									  	</td>
									</tr>
						
								</tbody>
							</table>	
						</div>
						<!-- end normal input table---------->
					<!-- end panel -->
					
					<!-- begin button-->
					<div class="col-md-12 tac">
<!-- 						<input type="button" id="noticeModify" value="저장" class="btn btn-primary width-100" onclick="qnaReplyInsert()"> -->
						<button type="button" class="btn btn-primary"  id="noticeModify" onclick="qnaReplyInsert()"><i class="fa fa-floppy-o"></i> 저장</button>
<!-- 			        	<input type="button" id="noticeList" value="취소" class="btn btn-grey width-100" onclick="moveDetailPage()"> -->
			        	 <button type="button" class="btn btn-grey" id="noticeList" onclick="moveDetailPage()"><i class="fa fa-times"></i> 취소</button>
	       		</div>
					<!-- end button -->
				
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


<%-- 


	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		<!-- begin #content -->
		<div id="contentbody" class="content">
		
			<!-- begin page-header -->
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> Q&A <span class="root">콘솔 > 사용문의 > Q&A</span></h1>
			<!-- end page-header -->

			<!-- begin page-body -->
			 <div class="row">
                    <!-- begin col-12 -->
                    <div class="col-md-12">
                        <!-- begin panel -->
                        <form id="noticeBbsForm" method="post" class="form-horizontal" >
							<input type="hidden" id="parentQnaNo" value="${parentQnaNo}">
							
							<div class="form-group m-b-10">
                                <label class="col-md-1 control-label fb">내용</label>
                                <div class="col-md-11">
                                    <textarea class="form-control" rows="15" placeholder="내용을 입력하세요"  id="content"></textarea>
                                </div>
                            </div>
                            
                            <div class="form-group m-b-10">
			                    <label class="col-md-1 control-label fb">작성자</label>
			                    <div class="col-md-11">
			                         <input type="text" id="regUserId" value="${userId}"/>
			                    </div>
			                </div>
                            <!-- 
                            <div class="form-group m-b-10">
                                <label class="col-md-1 control-label fb">파일첨부</label>
                                <div class="col-md-11 mb-15">
                                 <input type="file" class="form-control"/><label for="ex_file"></label>
                                </div>
                            </div>
							<div class="form-group m-b-10">
                                <label class="col-md-1 control-label fb">비밀번호</label>
                                <div class="col-md-3">
                                     <input type="password" class="form-control"/>
                                </div>
                            </div> 
                             -->							
							 
						</form>
                        <!-- end panel -->
                    </div>
                    <!-- end col-12 -->
					
					
					<!-- begin button-->
					<div class="row tac">
						<input type="button" id="noticeModify" value="저장" class="btn btn-primary width-100" onclick="noticeBbsInsert()">
			        	<input type="button" id="noticeList" value="취소" class="btn btn-grey width-100" onclick="moveListPage()">
	       
					</div>
					<!-- end button -->

			</div>
			<!-- end page-body -->
			

		</div>
		<!-- end #content -->
		
	
	</div>
	<!-- end page container -->
	 --%>
		
<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	function bbsDetail(qnaNo) {
		$.ajax({
			url : "${wasPath}/mbr/bbs/qna/detailReply",
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
		var content = $("#_content").val();
		if(content==""){
			warningBox("내용을 입력해주세요.");
			$("#_content").focus();
			return false;
		}
		return true;
	}
	
	function qnaReplyInsert() {
		
		if(!validationCheck()){
			return;
		}		
		
		var jsonData = setJsonData();
		
		$.ajax({
			url : "${wasPath}/mbr/bbs/qna/insert",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(data==1){
					alertBox("저장되었습니다.",moveDetailPage);
				}else{
					errorBox("저장실패.");
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
				"parentQnaNo" : $("#parentQnaNo").val()
				, "qnaNo" : $("#qnaNo").val()
				, "content":$("#_content").val()
				};
		return jsonData;
	}
	
	
	function setData(result){
		$("#regUserId").text(result.regUserId);
		$("#parentQnaNo").val(result.parentQnaNo);
		$("#qnaNo").val(result.qnaNo);
		$("#_content").val(result.content);		
	}
	
	// 목록 페이지이동
	function moveListPage(){
		location.href = "${wasPath}/mbr/bbs/qna/";
	}
	
	// 상세 페이지이동
	function moveDetailPage(){
		if($("#qnaNo").val() != 0 ){
			location.href = "${wasPath}/mbr/bbs/qna/view?qnaNo="+$("#parentQnaNo").val();
		}else{
			location.href = "${wasPath}/mbr/bbs/qna/";
		}
		
 	}
	
	
	$(document).ready(function() {
		App.init();
		
		if($("#parentQnaNo").val() != 0 ){
			bbsDetail($("#parentQnaNo").val());
		}
		
		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsQna").addClass("active");
		
	});
	
</script>
</body>
</html>