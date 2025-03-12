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
				<h1>보정 상세</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">요금 관리</a><a href="#" class="on">보정</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			 <div class="row pb50">

			 	<div class="tempDetailWrap" id="" style="">
					<div class="detailWrap">
						<div class="infoArea">
							<input type="hidden" id="h_billYyyymm" value="">
							<span class="date fontVdn" id="billYyyymm"></span>
							<div class="row m-t-10">
								<strong class="title dpin vm m-t-0"><span id="projectAlias"></span></strong>
							</div>
							<ul>
								<li>구분<span id="upCompanyName"></span></li>
								<li>고객사<span id="customerName"></span></li>
								<li>정산반영<span id="billFlag"></span></li>
								<li style="width:400px;">확정여부<span id="confirnFlag"></span></li>
								<li class="lineChg m-t-15">보정내역<span id="adjustContents"></span></li>
								<li class="m-t-15">보정치<span><em id="adjustAmount" class="fontVdn"></em>  (사용금액 : <em class="txtBlack fontVdn" id='useAmount'></em>원 <!-- /보정 후 금액 : <em class="txtRed fontB fontVdn" id="totalAmount">888,888,888</em>원 -->) </span></li>
							</ul>
						</div>
						<div class="cntArea clearfix">
							<dl>
								<dt>비고</dt>
								<dd id="description"></dd>
							</dl>
						</div>
					</div>
				</div>

				<div class="row tac m-t-60">
					<a type="button" class="btnType03 btnType03_del" onClick="actDelete()" id="btnDelete" style='display:none;'>삭제</a>
					<a type="button" class="btnType03 btnType03_edit m-l-15" onClick="moveEditPage();" id="btnEdit" style='display:none;'>수정</a>
		 			<a type="button" class="btnType03 btnType03_list m-l-15" onClick="moveListPage();">목록</a>
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
						if(i=="billFlag" || i=="confirnFlag"){
							$("#"+i).text(val=="Y"?"반영":"미반영");
						}else if(i=="billYyyymm"){
							$("#h_"+i).val(val);
							$("#"+i).text(val);
						}else{
							$("#"+i).text(val);
						}
					}
				});

				if(req.signtxt == "+"){
					$("#adjustAmount").addClass("txtBlue");
				}else{
					$("#adjustAmount").addClass("txtRed");
				}

				if(req.confirnFlag == "N"){
					$("#btnDelete").show();
					$("#btnEdit").show();
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	function moveListPage(){
		location.href = "${contextPath}/mng/bss/adjustment/";
	}

	function moveEditPage(){
		location.href = "${contextPath}/mng/bss/adjustment/edit?adjustSeq=${req.adjustSeq}";
	}

	function actDelete(){
		confirmBox("보정내역 삭제 및 재정산을<br>진행합니다.<br>삭제하시겠습니까?", ajaxDelete)
	}

	function ajaxDelete(){
		$.ajax({
			url : "${contextPath}/mng/bss/adjustment/delete",
			dataType : "JSON",
			data : {
				"adjustSeq" : '${req.adjustSeq}'
				, "modUserId"	: '${userId}'
			},
			success : function(req) {
				if(req == "1"){
					alertBox("삭제되었습니다. <br>재정산을 진행합니다.", billing);
				}else{
					alertBox3("삭제실패");
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	// 재정산
	function billing(){
		var billYyyymm = $("#h_billYyyymm").val();
		billYyyymm = billYyyymm.replace("-", "");

		$.ajax({
			url : "${contextPath}/mng/charge/bill/billing",
			dataType : "JSON",

			data : {
				"billYyyymm" : billYyyymm
				, "userId" : "${userId}"
			},
			success : function(data) {
				alertBox("재정산되었습니다.", moveListPage);
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}


	$(document).ready(function() {
		App.init();
		getDetail();

		//메뉴활성화
		$("#chargeManagement").addClass("active");
		$("#adjustment").addClass("active");
	});

</script>
</body>
</html>