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
	<div id="page-loader" class="page-loader fade in"><span class="spinner"></span></div>
	<!-- end #page-loader -->

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			
			
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>보정 수정</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">요금 관리</a><a href="#" class="on">보정</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			 <div class="row pb50">
			 	
			 	<div class="formType01">
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="166px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>고객사</strong></th>
									<td><span id="upCompanyName"></span>/<span id="customerName"></span></td>
								</tr>
								<tr>
									<th scope="row"><strong>프로젝트명</strong></th>
									<td><div id="projectAlias"></div></td>
								</tr>
								<tr>
									<th scope="row"><strong>청구년월</strong></th>
									<td class="fontVdn"><div id="billYyyymm"></div></td>
								</tr>
								<tr>
									<th scope="row"><strong>보정내역</strong></th>
									<td><input type="text" style="width:100%;" id="adjustContents"></td>
								</tr>
								<tr>
									<th scope="row"><strong>보정금액</strong></th>
									<td>
										<div class="selectBox" style="width:220px;">
											<label class="selectText">+ (원)</label>
											<select class="search-sel" id="signtxt" name="signtxt" onchange="onchangeSigntxt(this)">
												<option value="1" class="txtBlue">+ (원)</option>
												<option value="2" class="txtRed">- (원)</option>	
												<option value="3" class="txtBlue">+ (%)</option>
												<option value="4" class="txtRed">- (%)</option>
											</select>
										</div>
										<input type="text" style="width:514px;" class="fontVdn tar pull-right" id="absamount">
									</td>
								</tr>
								<tr>
									<th scope="row" class="vaT p-t-15"><strong>비고</strong></th>
									<td>
										<textarea style="width:100%;height:100px;" id="description"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="row tac m-t-60">
					<a type="button" class="btnType03 btnType03_save" onClick="actUpdate();">저장</a>
		 			<a type="button" class="btnType03 btnType03_cancel m-l-15" onClick ="moveListPage();">취소</a>
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
	
	function bssAdjustmentlist(){
 		location.href = "${contextPath}/mng/bss/adjustment/bssAdjustmentList";
 	}
	
	function actUpdate(){
		if($("#adjustContents").val()==""){
			alertBox3("보정내역을 입력하세요");
			$("#adjustContents").focus();
			return false;
		}
		if($("#absamount").val()== "0" || $("#absamount").val()== ""){
			alertBox3("보정금액을 입력하세요");
			$("#absamount").focus();
			return false;
		}
		confirmBox("수정하시겠습니까?", ajaxUpdate)
	}
	
	function ajaxUpdate(){		
		$.ajax({
			url : "${contextPath}/mng/bss/adjustment/update",
			dataType : "JSON",
			data : {
				"adjustSeq" : '${req.adjustSeq}'
				, "modUserId"	: '${userId}'
				, "adjustContents": $("#adjustContents").val()
				, "signtxt": $("#signtxt").val()
				, "adjustAmount": $("#absamount").val()
				, "description": $("#description").val()
			},
			success : function(req) {
				if(req == "1"){ 
					alertBox("수정되었습니다.", moveListPage);
				}else{
					alertBox3("수정실패");
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}	
	
	function getDetail() {
		$.ajax({
			url : "${contextPath}/mng/bss/adjustment/detail",
			dataType : "JSON",
			data : {
				"adjustSeq" : '${req.adjustSeq}'
			},
			success : function(req) {
				delete req.length;
				$.each(req, function(i, val){					
					if(val != null){
						if(i=="upCompanyName" || i=="customerName" || i=="projectAlias" || i=="billYyyymm"){
							$("#"+i).text(val);
						}else if(i=="signtxt"){
							if(req.adjustAmount.indexOf("%")> -1){
								if(val == "+"){
									$("#"+i).val("3");
									$("#"+i).siblings(".selectText").addClass("txtBlue");
								}
								else if(val == "-"){
									$("#"+i).val("4");
									$("#"+i).siblings(".selectText").addClass("txtRed");
								}
							}else{
								if(val == "+"){
									$("#"+i).val("1");
									$("#"+i).siblings(".selectText").addClass("txtBlue");
								}
								else if(val == "-"){
									$("#"+i).val("2");
									$("#"+i).siblings(".selectText").addClass("txtRed");
								}
							}
							$("#signtxt").siblings(".selectText").text($("#signtxt > option:selected").text());
						}else{
							$("#"+i).val(val);	
						}
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	function moveListPage(){
		location.href = "${contextPath}/mng/bss/adjustment/";
	}
	
	function onchangeSigntxt(e){
		$(e).siblings(".selectText").removeClass("txtRed");
		$(e).siblings(".selectText").removeClass("txtBlue");
		
		if($(e).val() == "1" || $(e).val() == "3"){
			$(e).siblings(".selectText").addClass("txtBlue");
		}else{
			$(e).siblings(".selectText").addClass("txtRed");
		}
	}
	
	$(document).ready(function() {
		App.init();
		getDetail();
		
 		$("#absamount").keyup(function(){ 
 			if(isNaN($(this).val())){
 				$(this).val("0");
 				alertBox3("숫자만 입력이 가능합니다.")
 			}
 		});
		
		//메뉴활성화
		$("#chargeManagement").addClass("active");
		$("#adjustment").addClass("active");
	});
	
	
</script>
</body>
</html>