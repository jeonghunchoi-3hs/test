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
				<h1>네트워크 정책 등록</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책 관리</a><a href="#" class="on">네트워크 정책 관리</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<div class="formType01">
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col style="width:205px">
								 <col style="width:768px">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>계열사</strong></th>
									<td>
										<div class="cmmeditArea">
											<span class="dpin p-t-10" id="company"></span>
											<input type="hidden" id="companyId">
											<a type='button' class="btnType04 cmmeditBtn" style="width:70px;" onclick="moveSrchPage();"><span class="txt"><i class="ico_search"></i>검색</span></a>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>IP대역<span class="fontVdn fontN">(A class)</span></strong></th>
									<td><input type="text" style="width:100%;" id="aClass" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"/></td>
								</tr> 
								<tr>
									<th scope="row"><strong>IP대역<span class="fontVdn fontN">(B class)</span></strong></th>
									<td><input type="text" style="width:100%;" id="bClass" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"/></td>
								</tr> 
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="row tac m-t-60">
		 			<a type='button' class="btnType03 btnType03_save" onClick="actInsertChk()">저장</a>
		 			<a type='button' class="btnType03 btnType03_list m-l-15" onClick ="moveList()">목록</a>
                </div>
                
                <div class="modal fade" id="modal-srch-copy"> 
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
											<input type="text" placeholder="검색어를 입력하세요" id="searchKeyword" onkeypress="if(event.keyCode==13)actCompanyList();" style="width: 362px">
											<a type='button' class="btn_search" onclick="actCompanyList();">검색</a> 
										</div>
									</div>
								</div>
								
								<div class="noneList" style="display: none;">
									 <span>검색된 사용자가 없습니다.</span>
								</div> 
								
								<!-- <div class="listArea" id="popListTable"> -->
								<div class="listArea" id ="popBody">
	                      		</div>
	                      		<div class="totalcnt" id="totalCnt">총 0 건</div>
	                       		
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="whiteline" data-dismiss="modal" id ="popclose">닫기</a>
	                       </div>
		               	</div>
					</div>
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
	function moveSrchPage(){
		$("#modal-srch-copy").modal();
		actCompanyList();
	}
	
	function actCompanyList(){
		$.ajax({
			url : "${contextPath}/mng/cmm/company/list",
			dataType : "JSON",
			data : {
				"searchKind": "company_name"
				, "keyword"	: $("#searchKeyword").val()
				, "length"	: 0
			},
			success : function(req) {
				$("#totalCnt").text("총 "+req.recordsTotal+"건");
				$("#popBody").empty();
				
				var vCss = "";
				$.each(req.data, function(key,val){
					if($("#companyId").val() == val.companyId ){
						vCss = "applybtn active";
					}else{
						vCss = "applybtn";
					}
					
					$("#popBody").append('<div class="listBg">'
											+'<span class="name2">'+val.upCompanyName+'</span>' 
											+'<span class="idlabel2">'+val.companyName+'</span>'
											+'<a class="'+vCss+'" onclick="popSelect(this, \''+val.companyId+'\', \''+(val.upCompanyName+" / "+val.companyName)+'\')">적용</a>'
										+'</div>');
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	function popSelect(e, companyId, company){
		$(".applybtn").removeClass("active"); 
		$(e).addClass("active"); 
		$("#company").text(company);
		$("#companyId").val(companyId);
		$("#modal-srch-copy").modal('hide'); 
	}
	
	function actInsertChk() {
		if($("#companyId").val()==""){
			alertBox3("계열사를 선택하세요.");
			$("#companyId").focus();
			return false;
		} 
		if($("#aClass").val()==""){
			alertBox3("IP대역(A class)를 입력하세요");
			$("#aClass").focus();
			return false;
		}
		if($("#bClass").val()==""){
			alertBox3("IP대역(A class)를 입력하세요");
			$("#bClass").focus();
			return false;
		}
		confirmBox("등록하시겠습니까? ", actInsert);
	}
	
	function actInsert() {
		$.ajax({
			url : "${contextPath}/mng/cmm/network/insert",
			dataType : "JSON",
			data : {
				"networkId"			: ""
				, "companyId"		: $("#companyId").val()
				, "aClass"			: $("#aClass").val()
				, "bClass"			: $("#bClass").val()
				, "useFlag"			: "Y"
				, "regUserId" 		: "${userId}"
			},
			success : function(data) {
				if(data == "0"){
					alertBox3("등록 실패")
				}else{
					alertBox("등록되었습니다.", moveList);	
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}
	
	function moveList(){
 		location.href = "${contextPath}/mng/cmm/network/";
 	}
	
	
	$(document).ready(function() {
		App.init();
		
		//메뉴활성화
		$("#operation").addClass("active");
		$("#cmmNetwork").addClass("active");
	});
	
</script>
</body>
</html>