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

	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading..</span></div>
	<!-- end #page-loader -->

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
				<h1>발송이력 상세</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">알림/접속 관리</a><a href="#" class="on">발송이력 조회</a>
				</div>

				<input type="hidden" id="h_gubun" value="${historyGubun}">
				<input type="hidden" id="h_seq" value="${historySeq}">

			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<div class="tempDetailWrap" id="smsDiv" style="display : none;">
					<div class="detailWrap">
						<div class="infoArea">
							<span class="category fontVdn">SMS</span>
							<span class="tempId" id="tempId">(템플릿 ID : <em id="smsTemplateId"></em>)</span>
							<div class="row m-t-10">
								<span class="txtLabel dpin vm m-r-5" id="smsResultFlag">성공</span>
								<strong class="title dpin vm m-t-0"><span id="smsReceiverName">관리자</span> (<span class="fontVdn fontN" id="smsReceiverNumber"></span>)</strong>
							</div>
							<ul>
								<li>수신자 ID<span class="fontVdn" id="smsReceiverId"></span></li>
								<li>재 전송 횟수<span class="fontVdn" id="smsRetryCount">0</span></li>
								<li>발송처리일시<span class="fontVdn" id="smsResultDatetime"></span></li>
							</ul>
						</div>
						<div class="cntArea type02 clearfix">
							<dl>
								<dt>메시지</dt>
								<dd id="smsMessage"></dd>
							</dl>
						</div>
					</div>
					<div class="senderArea">
						<strong class="txtLab">발신자정보</strong>
						<dl>
							<dt id="smsSenderName"></dt>
							<dd><i class="ico_mobile"></i><span class="fontVdn" id="smsSenderNumber"></span></dd>
						</dl>
					</div>
				</div>
				
				
				
				<div class="tempDetailWrap" id="mailDiv" style="display : none;">
					<div class="detailWrap">
						<div class="infoArea">
							<span class="category">이메일</span>
							<span class="tempId">(템플릿 ID : <em id="mailTemplateId"></em>)</span>
							<div class="row m-t-10">
								<span class="txtLabel dpin vm m-r-5" id="mailResultFlag"></span>
								<strong class="title dpin vm m-t-0"><span id="mailReceiverName"></span> (<span class="fontVdn fontN" id="mailReceiverMail"></span>)</strong>
							</div>
							<ul>
								<li>수신자 ID<span class="fontVdn" id="mailReceiverId"></span></li>
<!-- 								<li>수신자 번호<span class="fontVdn" id="mailReceiverId">010-1234-5678</span></li> -->
								<li>재 전송 횟수<span class="fontVdn" id="mailRetryCount">0</span></li>
								<li>발송처리일시<span class="fontVdn" id="mailResultDatetime"></span></li>
							</ul>
						</div>
						<div class="cntArea type02 clearfix">
							<dl>
								<dt>제목</dt>
								<dd id="mailTitle"></dd>
							</dl>
							<dl>
								<dt>내용</dt>
								<dd id="mailContent"></dd>
							</dl>
						</div>
					</div>
					<div class="senderArea">
						<strong class="txtLab">발신자정보</strong>
						<dl>
							<dt id="mailSenderName"></dt>
							<dd><i class="ico_mail"></i><span class="fontVdn" id="mailSenderMail"></span></dd>
						</dl>
					</div>
				</div>
				
				
				<div class="tempDetailWrap" id="nhwithDiv" style="display: none;">
					<div class="detailWrap">
						<div class="infoArea">
							<span class="category fontVdn">NHwith</span>
							<span class="tempId">(템플릿 ID : <em id="nhwithTemplateId"></em>)</span>
							<div class="row m-t-10">
								<span class="txtLabel dpin vm m-r-5" id="nhwithResultFlag"></span>
								<strong class="title dpin vm m-t-0"><span id="nhwithReceiverName"></span> (<span class="fontVdn fontN">ID : <span id="nhwithReceiverId"></span></span>)</strong>
							</div>
							<ul>
								<li>재 전송 횟수<span class="fontVdn" id="nhwithRetryCount">0</span></li>
								<li>발송처리일시<span class="fontVdn" id="nhwithResultDatetime"></span></li>
							</ul>
						</div>
						<div class="cntArea type02 clearfix">
							<dl>
								<dt>메시지</dt>
								<dd id="nhwithContent"></dd>
							</dl>
						</div>
					</div>
					<div class="senderArea">
						<strong class="txtLab">발신자정보</strong>
						<dl>
							<dt id="nhwithSenderName"></dt>
<!-- 							<dd><i class="ico_mobile"></i><span class="fontVdn">010-1234-5678</span></dd> -->
						</dl>
					</div>
				</div>
				
				<div class="tempDetailWrap" id="kepcowithDiv" style="display: none;">
					<div class="detailWrap">
						<div class="infoArea">
							<span class="category fontVdn">kepcowith</span>
							<span class="tempId">(시스템 이름 : <em id="kepcoSystemName"></em>)</span>
							<ul>
								<li>타입<span class="fontVdn" id="kepcoSignType"></span></li>
								<li>상태<span class="fontVdn" id="kepcoStatus"></span></li>
								<li>수신결과<span class="fontVdn" id="kepcortnCode"></span></li>
								<li>결재자 사번<span class="fontVdn" id="kepcoPayerId"></span></li>
								<li>기안자 사번<span class="fontVdn" id="kepcoWriterId"></span></li>
								<li>기안자 이름<span class="fontVdn" id="kepcoWriterName"></span></li>
								<li>수신결과<span class="fontVdn" id="kepcoTitle"></span></li>
								<li>등록시간<span class="fontVdn" id="kepcoRegDateTime"></span></li>
							</ul>
						</div>
					</div>
					<div class="senderArea">
						<strong class="txtLab">발신자정보</strong>
						<dl>
							<dt id="nhwithSenderName"></dt>
<!-- 							<dd><i class="ico_mobile"></i><span class="fontVdn">010-1234-5678</span></dd> -->
						</dl>
					</div>
				</div>
				
				<div class="row tac m-t-40">	
					<a type='button' class="rbton bton_dgrey" onclick="moveListPage()"><i class="fa fa-list"></i> 목록</a>         
				</div>
				 	
	
			</div>
			<!-- end page-body -->
		
		
            <!-- begin #footer -->
            <div id="footer" class="footer">
               <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
            </div>
			<!-- end #footer -->

		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

	function getDetail() {
		
		var historyGubun = "${historyGubun}";
		var smsUrl = "${contextPath}/mng/smsQueue/history/detail";
		var mailUrl = "${contextPath}/mng/mailQueue/history/detail";
		var nhwithUrl = "${contextPath}/mng/nhwith/template/nhwithTemplateHistoryDetail";
		var kepcoUrl = "${contextPath}/mng/kepco/template/detail";
		var url = "";	
		
		if(historyGubun=="sms"){
			url = smsUrl;
		}else if(historyGubun=="mail"){
			url = mailUrl;
		}else if(historyGubun=="nhwith"){
			url = nhwithUrl;
		}else if(historyGubun=="kepco"){
			url = kepcoUrl;
		}
		
		var jsonData = setJsonData();
		
		$.ajax({
			url : url,
			dataType : "JSON",
			data : jsonData,
			success : function(data) {
				var result = data;
				console.log(data);
				if(historyGubun=="sms"){
					if(result.templateId == null || result.templateId == ""){
						$("#tempId").text("(웹 발송)");
					}else{
						$("#smsTemplateId").text(result.templateId);
					}
					if(result.resultFlg == "Y"){
						$("#smsResultFlag").text("성공");
						$("#smsResultFlag").addClass("txtLabel_suc");
					}else{
						$("#smsResultFlag").text("실패");
						$("#smsResultFlag").addClass("txtLabel_fail");
					}
					$("#smsReceiverName").html(result.receiverName);
					$("#smsReceiverNumber").text(result.receiverNumber);
					$("#smsReceiverId").text(result.receiverId);
					$("#smsRetryCount").text(result.retryCount);
					$("#smsResultDatetime").text(result.resultDatetime2);
					$("#smsMessage").text(result.message);
					$("#smsSenderName").text(result.senderName);
					$("#smsSenderNumber").text(result.senderNumber);
				
				}else if(historyGubun=="mail"){
					$("#mailTemplateId").text(result.templateId);
					if(result.resultFlg == "Y"){
						$("#mailResultFlag").text("성공");
						$("#mailResultFlag").addClass("txtLabel_suc");
					}else{
						$("#mailResultFlag").text("실패");
						$("#mailResultFlag").addClass("txtLabel_fail");
					}
					$("#mailReceiverName").html(result.receiverName);
					$("#mailReceiverMail").text(result.receiverMail);
					$("#mailReceiverId").text(result.receiverId);
					$("#mailRetryCount").text(result.retryCount);
					$("#mailResultDatetime").text(result.resultDatetime2);
					$("#mailTitle").text(result.title);
					$("#mailContent").text(result.content);
					$("#mailSenderName").text(result.senderName);
					$("#mailSenderMail").text(result.senderMail);
				
				}else if(historyGubun=="nhwith"){
					$("#nhwithTemplateId").text(result.templateId);
					if(result.resultFlg == "Y"){
						$("#nhwithResultFlag").text("성공");
						$("#nhwithResultFlag").addClass("txtLabel_suc");
					}else{
						$("#nhwithResultFlag").text("실패");
						$("#nhwithResultFlag").addClass("txtLabel_fail");
					}
					$("#nhwithReceiverName").html(result.receiverName);
					$("#nhwithReceiverId").text(result.receiverId);
					$("#nhwithRetryCount").text(result.retryCount);
					$("#nhwithResultDatetime").text(result.resultDatetime2);
					$("#nhwithContent").text(result.content);
					$("#nhwithSenderName").text(result.senderName);
					
				}else if(historyGubun=="kepco"){
					$("#kepcoSystemName").text(result.systemName);
					if(result.rtnCode == "0000"){
						$("#kepcortnCode").text("성공");
					} else {
						$("#kepcortnCode").text("실패");
					}
					if(result.signType == "S"){
						$("#kepcoSignType").text("결재 시작/중간");
					} else if(result.signType=="E"){
						$("#kepcoSignType").text("결재 종료/반송");
					}
					if(result.status == "0"){
						$("#kepcoStatus").text("진행");
					} else if(result.status == "1"){
						$("#kepcoStatus").text("완료");
					} else if(result.status == "9"){
						$("#kepcoStatus").text("회수");
					}
					$("#kepcoPayerId").html(result.payerId);
					$("#kepcoWriterId").text(result.writerId);
					$("#kepcoWriterName").text(result.writerName);
					$("#kepcoTitle").text(result.title);
					$("#kepcoRegDateTime").text(result.regDatetime);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	
	function setJsonData(){
		var historyGubun = "${historyGubun}";
		var jsonData = "";
		if(historyGubun=="sms"){
			jsonData = {"smsSeq" : "${historySeq}"}
		}else if(historyGubun=="mail"){
			jsonData = {"mailSeq" : "${historySeq}"}
		}else if(historyGubun=="nhwith"){
			jsonData = {"nhwithSeq" : "${historySeq}"}
		}else if(historyGubun=="kepco"){
			jsonData = {"alarmSeq" : "${historySeq}"}
		}
		
		return jsonData;
	}
	
	function setHistoryDiv(){
		var historyGubun = "${historyGubun}";
		
		if(historyGubun=="sms"){
			$("#smsDiv").show();
		}else if(historyGubun=="mail"){
			$("#mailDiv").show();
		}else if(historyGubun=="nhwith"){
			$("#nhwithDiv").show();
		} else if(historyGubun=="kepco"){
			$("#kepcowithDiv").show();
		}
		
	}
	

	// 목록 페이지이동
	function moveListPage(){
		location.href = "${contextPath}/mng/alarms/history/?historyGubun=${historyGubun}";
	}
	
	$(document).ready(function() {
		App.init();
		setHistoryDiv();
		getDetail();
		
		
		//메뉴활성화
		$("#alarms").addClass("active");
		$("#smsHistory").addClass("active");
	});
	
</script>

</body>
</html>