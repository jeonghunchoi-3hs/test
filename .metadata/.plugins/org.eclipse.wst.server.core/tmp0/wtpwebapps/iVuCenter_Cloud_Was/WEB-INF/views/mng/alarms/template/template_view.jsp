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

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">

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
				<h1>템플릿 상세</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">알림/접속 관리</a><a href="#" class="on">템플릿 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
			<input type="hidden" id="h_templateId" value="${templateId}">
			<input type="hidden" id="h_tempGubun" value="${tempGubun}">

				<div class="tempDetailWrap" id="smsTempDiv" style="display: none;">
					<div class="detailWrap">
						<div class="infoArea">
							<span class="category fontVdn">SMS</span>
							<strong class="title" id="smsTitle"></strong>
							<ul class="flex align-center gapl10">
								<li class="flex align-center">등록자<span id="smsModUserName"></span></li>
								<li class="flex align-center">등록일시<span class="fontVdn" id="smsModDatetime"></span></li>
							</ul>
						</div>
						<div class="cntArea">
							<dl>
								<dt>메시지</dt>
								<dd id="smsMessage"></dd>
							</dl>
						</div>
					</div>
					<div class="smsByteArea">
						<p class="txt_guide_type01">실제 발송 byte와 다를 수 있습니다</p>
						<div class="byte">( <span id="divByte">0</span> / 80bytes ) </div>
					</div>
				</div>

				<div class="tempDetailWrap"  id="mailTempDiv" style="display: none;">
					<div class="detailWrap">
						<div class="infoArea">
							<span class="category">이메일</span>
							<strong class="title" id="mailTitle"></strong>
							<ul class="flex align-center gapl10">
								<li class="flex align-center">등록자<span id="mailModUserName"></span></li>
								<li class="flex align-center">등록일시<span class="fontVdn" id="mailModDatetime"></span></li>
							</ul>
						</div>
						<div class="cntArea">
							<dl>
								<dt>내용</dt>
								<dd id="mailMessage"></dd>
							</dl>
						</div>
					</div>
				</div>

				<div class="tempDetailWrap"  id="nhwithTempDiv" style="display: none;">
					<div class="detailWrap">
						<div class="infoArea">
							<span class="category fontVdn">NHwith</span>
							<strong class="title">비밀번호 찾기</strong>
							<ul class="flex align-center gapl10">
								<li class="flex align-center">등록자<span>관리자</span></li>
								<li class="flex align-center">등록일시<span class="fontVdn">2017-09-18 12:00</span></li>
							</ul>
						</div>
						<div class="cntArea">
							<dl>
								<dt>메시지</dt>
								<dd id="nhwithMessage"></dd>
							</dl>
						</div>
					</div>
				</div>

				<div class="row tac m-t-40">
					<a type='button' class="rbton bton_blue" onclick="moveInsertPage()"><i class="fa fa-pencil"></i> 수정</a>
					<a type='button' class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>
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
		var tempGubun = "${tempGubun}";
		var smsUrl = "${contextPath}/mng/sms/template/detail";
		var mailUrl = "${contextPath}/mng/mail/template/detail";
		var nhwithUrl = "${contextPath}/mng/nhwith/template/templateviewDetail";
		var url = "";
		var smsMessage = "";

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
					smsMessage = result.message;
					$("#smsTitle").text(result.title);

					var message1 = result.message;
					var message = message1.replace(/(?:\r\n|\r|\n)/g,"<br/>");

					$("#smsMessage").html(message);
					$("#smsModUserName").text(result.userName);
					$("#smsModDatetime").text(result.modDatetime2);
					setSMSByte(smsMessage);
				}else if(tempGubun=="mail"){
					$("#mailTitle").text(result.title);


					var content1 = result.content;
					//var content = content1.replace(/(?:\r\n|\r|\n)/g,"<br/>");
					var content = content1;
					$("#mailMessage").html(content);
					$("#mailModUserName").text(result.userName);
					$("#mailModDatetime").text(result.modDatetime2);
				}else if(tempGubun=="nhwith"){
					$("#nhwithTitle").text(result.title);
					$("#nhwithMessage").html(result.content);
					$("#nhwithModUserName").text(result.modUserName);
					$("#nhwithModDatetime").text(result.modDatetime2);
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});

	}


	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/alarms/template/?tempGubun=${tempGubun}";
	}

	// 수정 페이지이동
	function moveInsertPage(){
		var params = "?templateId="+$("#h_templateId").val()+"&tempGubun="+$("#h_tempGubun").val();
		location.href = "${contextPath}/mng/alarms/template/write"+params
	}

	// 템플릿 구분
	function setTempDiv(){
		var tempGubun = "${tempGubun}";

		if(tempGubun=="sms"){
			$("#smsTempDiv").show();
		}else if(tempGubun=="mail"){
			$("#mailTempDiv").show();
		}else if(tempGubun=="nhwith"){
			$("#nhwithTempDiv").show();
		}

	}

	function setSMSByte(smsText){
		var len = 0;
		for(var i=0; i<smsText.length; i++){
			if(escape(smsText.charAt(i)).length == 6){
				len++;
			}
			len++;
		}
		$("#divByte").text(len);
	}



	$(document).ready(function() {
		App.init();
		setTempDiv();
		getDetail();


		//메뉴활성화
		$("#alarms").addClass("active");
		$("#template").addClass("active");

	});

</script>
</body>
</html>