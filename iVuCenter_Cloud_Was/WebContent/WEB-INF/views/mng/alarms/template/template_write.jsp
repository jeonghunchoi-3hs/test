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
			<div class="page_header mb30">
				<h1>템플릿 수정</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">알림/접속 관리</a><a href="#" class="on">템플릿 관리</a>
				</div>
			</div>
			<!-- end header -->


			<!-- begin page-body -->
			<div class="row pb50">
			<input type="hidden" id="h_templateId" value="${templateId}">
			<input type="hidden" id="h_tempGubun" value="${tempGubun}">

				<div class="formType01" id="smsTempDiv" style="display: none;">

						<table class="tableH">
							<colgroup>
								 <col width="140px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th>구분</th>
									<td>SMS</td>
								</tr>
								<tr>
									<th>제목</th>
									<td><input type="text" class="w100" id="smsTitle"></td>
								</tr>
								<tr>
									<th>메세지</th>
									<td>
										<textarea class="height-200" id="smsMessage"></textarea>
										<div class="smsByteArea">
											<p class="txt_guide_type01">실제 발송 byte와 다를 수 있습니다</p>
											<div class="byte">( <span id="divByte">0</span> / 80bytes ) </div>
										</div>
									</td>
								</tr>
								<tr>
									<th>예약어</th>
									<td id="smsDiv_reservedWord"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="formType01" id="mailTempDiv" style="display: none;">
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="140px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>구분</strong></th>
									<td>이메일</td>
								</tr>
								<tr>
									<th scope="row"><strong>제목</strong></th>
									<td><input type="text" style="width:100%" id="mailTitle"  maxlength=""></td>
								</tr>
								<tr>
									<th scope="row"><strong>내용</strong></th>
									<td>
										<textarea style="height:200px;" id="mailMessage"></textarea>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>예약어</strong></th>
									<td id="mailDiv_reservedWord"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="formType01" id="nhwithTempDiv" style="display: none;">
					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="140px">
								 <col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>구분</strong></th>
									<td class="fontVdn">NHwith</td>
								</tr>
								<tr>
									<th scope="row"><strong>제목</strong></th>
									<td><input type="text" style="width:100%" id="nhwithTitle"  maxlength=""></td>
								</tr>
								<tr>
									<th scope="row"><strong>메세지</strong></th>
									<td>
										<textarea style="height:200px;" id="nhwithMessage"></textarea>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>예약어</strong></th>
									<td id="nhwithDiv_reservedWord"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="row tac m-t-40">
					<a type='button' class="rbton bton_blue" onclick="actInsert()"><i class="fa fa-floppy-o"></i> 저장</a>
					<a type='button' class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-close"></i> 취소</a>
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
<script type='text/javascript' src="${contextPath}/resources/ckeditor/ckeditor.js"></script>
<script type='text/javascript' src="${contextPath}/resources/ckeditor/ckedtor_sample.js"></script>
<script type="text/javascript">

	function getDetail() {
		var tempGubun = "${tempGubun}";
		var smsUrl = "${contextPath}/mng/sms/template/detail";
		var mailUrl = "${contextPath}/mng/mail/template/detail";
		var nhwithUrl = "${contextPath}/mng/nhwith/template/templateviewDetail";
		var url = "";

		if(tempGubun=="sms"){
			url = smsUrl;
		}else if(tempGubun=="mail"){
			url = mailUrl;
		}else if(tempGubun=="nhwith"){
			url = nhwithUrl;
		}

		$.ajax({
			url : url,
			dataType : "JSON",
			data : {
				"templateId" : "${templateId}"
			},
			success : function(data) {
				var result = data;

				if(tempGubun=="sms"){
					$("#smsTitle").val(result.title);
					$("#smsMessage").val(result.message);
				}else if(tempGubun=="mail"){
					$("#mailTitle").val(result.title);
					//$("#mailMessage").html(result.content);

					CKEDITOR.instances.mailMessage.setData(result.content);

				}else if(tempGubun=="nhwith"){
					$("#nhwithTitle").val(result.title);
					$("#nhwithMessage").val(result.content);
				}


			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	function getDetailReservedWord() {
		var tempGubun = "${tempGubun}";

		$.ajax({
			url : "${contextPath}/mng/template/reserved/word/list",
			dataType : "JSON",
			data : {
				"templateId" : "${templateId}"
			},
			success : function(data) {
				delete data.length;
				for(var i=0;i<data.length;i++){
					delete data[i].length;
					$.each(data[i], function(key, val){
						if(val != null){
							if(key=="reservedWord"){
								if(tempGubun=="sms"){
									$("#smsDiv_"+key).append(val);
								}else if(tempGubun=="mail"){
									$("#mailDiv_"+key).append(val);
								}else if(tempGubun=="nhwith"){
									$("#nhwithDiv_"+key).append(val);
								}
							}
						}
					});
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	function setJsonData(){
		var tempGubun = $("#h_tempGubun").val();
		var jsonData = "";

		if(tempGubun=="sms"){
			jsonData = {
					"templateId" : $("#h_templateId").val()
					, "title" : $("#smsTitle").val()
					, "message" : $("#smsMessage").val()
					, "modUserId" : "${userId}"
					};
		}else if(tempGubun=="mail"){
			var content = CKEDITOR.instances.mailMessage.getData();
			jsonData = {
					"templateId" : $("#h_templateId").val()
					, "title" : $("#mailTitle").val()
					, "content" : content
					, "modUserId" : "${userId}"
					};
		}else if(tempGubun=="nhwith"){
			jsonData = {
					"templateId" : $("#h_templateId").val()
					, "title" : $("#nhwithTitle").val()
					, "content" : $("#nhwithMessage").val()
					, "modUserId" : "${userId}"
					};
		}

		return jsonData;

	}


	// 등록/수정
	function actInsert() {
		var tempGubun = $("#h_tempGubun").val();
		var smsUrl = "${contextPath}/mng/sms/template/update";
		var mailUrl = "${contextPath}/mng/mail/template/update";
		var nhwithUrl = "${contextPath}/mng/nhwith/template/templateUpdate";
		var url = "";

		if(tempGubun=="sms"){
			url = smsUrl;
		}else if(tempGubun=="mail"){
			url = mailUrl;
		}else if(tempGubun=="nhwith"){
			url = nhwithUrl;
		}

		var jsonData = setJsonData();
		$.ajax({
			url : url,
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
 				if(result==1){
 					moveListPage();
				}else{
					alertBox3("fail!!");
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		})
	}

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/alarms/template/";
	}

	// 템플릿 구분
	function setTempDiv(){
		var tempGubun = "${tempGubun}";

		if(tempGubun=="sms"){
			$("#smsTempDiv").show();
		}else if(tempGubun=="mail"){
			$("#mailTempDiv").show();
			ckEditorInit('mailMessage');
		}else if(tempGubun=="nhwith"){
			$("#nhwithTempDiv").show();
		}
	}

	$(document).ready(function() {
		App.init();

		setTempDiv();
		getDetail();
		getDetailReservedWord();

		$("#smsMessage").keyup(function(){
			var len = 0;
			for(var i=0; i<this.value.length; i++){
				if(escape(this.value.charAt(i)).length == 6){
					len++;
				}
				len++;
			}
			$("#divByte").text(len);
		});

		//메뉴활성화
		$("#alarms").addClass("active");
		$("#template").addClass("active");
	});

</script>
</body>
</html>