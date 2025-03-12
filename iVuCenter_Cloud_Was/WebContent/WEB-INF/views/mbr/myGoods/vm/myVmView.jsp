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
	<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>
<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading..</span></div>
	<!-- end #page-loader -->

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
		
			<!-- begin page-header -->
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 프로젝트 정보<span class="root">콘솔 > 카달로그 > 가상머신</span></h1>
			<!-- end page-header -->

			<!-- begin page-body -->
			<div class="row mb50">
			
			<!-- begin section-container -->		  
			<div class="section-container inbox100">

			<!-- begin normal input table---------->
			<div class="tableC">
			<input type="hidden" id="vmUuid" value="">
				<table>
					<colgroup>
			 			<col width="20%">
			 			<col width="80%">
			 		</colgroup>
					<tbody>
						<tr>
				  			<td class="left-b th20">프로젝트</td>
				  			<td>
								<div class="col-sm-6">
					 				<p class="form-control-static f14 fb lh34 p0" id="projectAlias"> </p>
	                   			</div>
				  			</td>
				 		</tr>
				 		<tr>
				  			<td class="left-b th20">ZONE</td>
				  			<td>
								<div class="col-sm-6">
					 				<p class="form-control-static f14 fb lh34 p0" id=""> </p>
	                   			</div>
				  			</td>
				 		</tr>
				 		<tr>
				  			<td class="left-b th20">호스트명</td>
				  			<td>
								<div class="col-sm-6">
					 				<p class="form-control-static f14 fb lh34 p0" id="hostNmae"> </p>
	                   			</div>
				  			</td>
				 		</tr>
				 		<tr>
				  			<td class="left-b th20">IP</td>
				  			<td>
								<div class="col-sm-6">
					 				<p class="form-control-static f14 fb lh34 p0" id=""> </p>
	                   			</div>
				  			</td>
				 		</tr>
				 		<tr>
				  			<td class="left-b th20">CPU</td>
				  			<td>
								<div class="col-sm-6">
					 				<p class="form-control-static f14 fb lh34 p0" id="vcpus"> </p>
	                   			</div>
				  			</td>
				 		</tr>
				 		<tr>
				  			<td class="left-b th20">MEM</td>
				  			<td>
								<div class="col-sm-6">
					 				<p class="form-control-static f14 fb lh34 p0" id="memGb"> </p>
	                   			</div>
				  			</td>
				 		</tr>
				 		<tr>
				  			<td class="left-b th20">DISK</td>
				  			<td>
								<div class="col-sm-6">
					 				<p class="form-control-static f14 fb lh34 p0" id="diskGb"> </p>
	                   			</div>
				  			</td>
				 		</tr>
				 		<tr>
				  			<td class="left-b th20">Storage</td>
				  			<td>
								<div class="col-sm-6">
					 				<p class="form-control-static f14 fb lh34 p0" id=""> </p>
	                   			</div>
				  			</td>
				 		</tr>
				 		<tr>
				  			<td class="left-b th20">OS</td>
				  			<td>
								<div class="col-sm-6">
					 				<p class="form-control-static f14 fb lh34 p0" id=""> </p>
	                   			</div>
				  			</td>
				 		</tr>
				 		<tr>
				  			<td class="left-b th20">백업관리</td>
				  			<td>
								<div class="col-sm-6">
					 				<p class="form-control-static f14 fb lh34 p0" id=""> </p>
	                   			</div>
				  			</td>
				 		</tr>
				 		<tr>
				  			<td class="left-b th20">Auto Scaling</td>
				  			<td>
								<div class="col-sm-6">
					 				<p class="form-control-static f14 fb lh34 p0" id=""> </p>
	                   			</div>
				  			</td>
				 		</tr>
					</tbody>
				</table>
			</div>
			<!-- end normal input table---------->
			</div>
			    <!-- end section-container -->	   
				<!-- begin button----------->
				 <div class="col-sm-12 tar mt20">
					 
                     <button type="submit" class="btn btn-lime width-80">변경</button> 
					 <a href="#modal-dialog" class="btn btn-warning width-80" data-toggle="modal">중지</a>
					 <button type="submit" class="btn btn-danger width-80">해지</button>   					 
					 <button type="submit" class="btn btn-grey width-80">목록</button>       
                 </div>
				<!-- end button----------->
			
			</div>
			<!-- end page-body -->
			
					<!-- #modal-dialog -->
                            <div class="modal fade" id="modal-dialog">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title fw">가상머신 중지</h4>
                                        </div>
                                        <div class="modal-body">
                                            <h5>선택하신 가상머신을 중지 하시겠습니까? </h5>
                                          

                                        </div>
                                        <div class="modal-footer tac">
										    <a type='button' class="btn width-100 btn-danger">중지</a>
                                            <a type='button' class="btn width-100 btn-default" data-dismiss="modal">취소</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
			
            <!-- begin #footer -->
            <div id="footer" class="footer">
               <c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
            </div>
			<!-- end #footer -->

		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

</body>



<script type="text/javascript">

	function bbsDetail(noticeNo) {
		$.ajax({
			url : "detail",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"noticeNo" : noticeNo
			},
			success : function(data) {
				var result = data;
				setData(result);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}
	
	
	function deleteNoticeBbs(){
		
		confirm("삭제하시겠습니까?");
		
		var rowSeq = $("#noticeNo").val();
		
		$.ajax({
			url : "delete",
			dataType : "JSON",
			type : "POST",
			data : {
				"noticeNo" : rowSeq
			},
			success : function(data) {
				var result = data;
				if(result==1){
					//alert("Deleted!!");
					moveListPage();
				}else{
					//alert("failed!!");
					moveListPage();
				}
				
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
		
	}
	
	
	function setData(result){
		$("#title").text(result.title);
		$("#regDatetime").text(result.regDatetime);
		$("#regUserId").text(result.regUserId);
		$("#codeName").text(result.codeName);
		$("#_content").text(result.content);
	}
	
	// 목록 페이지이동
	function moveListPage(){
		//location.href = "${contextPath}/mbr/bbs/notice/";
		location.href = "../notice/";
		
	}
	// 등록/수정 페이지이동
	function moveInsertPage(){
		var noticeNo = $("#noticeNo").val();
		location.href = "${contextPath}/mbr/bbs/notice/write?noticeNo="+noticeNo;
	}
	
	$(document).ready(function() {
		bbsDetail("${noticeNo}");
		App.init();
		
		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsNotice").addClass("active");
		
// 		PageDemo.init();
	});
	
</script>


</html>