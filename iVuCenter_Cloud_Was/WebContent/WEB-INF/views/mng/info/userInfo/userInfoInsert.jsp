<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="adminId" 		property="principal.username" />
	<sec:authentication var="adminName" 	property="principal.nickname"/>
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
	<link href="${apachePath}/resources/assets/plugins/jqGrid/css/ui.jqgrid.css" rel="stylesheet" />
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
				<h1>내정보 수정</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#" class="on">내정보</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			<input type="hidden" id="_userId" value="${userId}">
				<input type="hidden" id="customerId" value="" />
				<input type="hidden" id="deptCode" value="" />
				<div class="row">
					<div>
						<div class="tblWrap clearfix">														
							<table class="tableH">
								<colgroup>
									 <col width="10%">
									 <col width="40%">
									 <col width="10%">
									 <col width="40%">
								</colgroup>
								<tbody>
									<tr>
									    <th>회원사</th>
									    <td id="customerName"></td>
									    <th>소속조직(부서)</th>    
									 <td> <input id="deptName" class="fontVdn input_int width-500" readonly> <a id="openDepartment" data-toggle="modal"><button class="bton-s bton_blue"><i class="fa fa-search"></i> 검색</button></a></td>  
  
									</tr>
									<tr>
										<th>사용자이름</th>
										<td id="userName"></td>
										<th>직급</th>
										<td>
											<div class="selectBox width-200">
												<label class="selectText fontVdn" for="userLevel">직급선택</label>
												<select class="search-sel" id="userLevel">
													<c:forEach items="${getPositionCode}" var="getPositionCode" varStatus="status" >
												  	<option value="${getPositionCode.codeName}">${getPositionCode.codeName}</option>		
												  	</c:forEach>						                  		
												</select>
											</div>
										</td>
									</tr>
									<tr>
										<th>프로필사진</th>
										<td colspan="3">
											<div class="fileArea">
											    <c:if test="${file.size() eq 0}">
											    	<input type="text" class="fontVdn input_int width-500" id="fileName" readonly> 
												</c:if>
												<c:if test="${file.size() ne 0}">
													<input type="text" class="fontVdn input_int width-500" id="fileName" value="${file.get(0).fileName}" readonly>
												</c:if>											
												<a type="button" class="bton-s bton_blue" onclick="openModal();"><span class="txt"><i class="fa fa-search"></i> 검색</span></a>
											</div>
										</td>
									</tr> 
									<tr>
										<th>기존 비밀번호</th>
										<td colspan="3">
											<input type="password" class="input_int width-500" id="userPassword" placeholder="비밀번호 변경시에만 입력하세요."> 
											<span class="fc-red">비밀번호는 영문자, 숫자, 특수문자 조합된 8자리 이상의 숫자로 기입해 주세요. 비밀번호는 3개월 주기로 꼭 변경해 주시기 바랍니다. </span>
											
										</td>
									</tr> 
									<tr>
										<th>새 비밀번호</th>
										<td>
										  	<input type="password" class="input_int" placeholder="비밀번호 변경시에만 입력하세요" id="newuserPassword1">
										</td>
										<th>새 비밀번호 확인</th>
										<td><input type="password"  class="input_int" id="newuserPassword2" placeholder="비밀번호 변경시에만 입력하세요."></td>
									</tr>
									<tr>
										<th>핸드폰</th>
										<td  colspan="3">
											<div class="selectBox width-80">
												<label class="selectText  fontVdn" for="mbrPhone1">선택</label>
												<select class="search-sel" id="mbrPhone1">
													<option value="">선택</option>
													<option value="010">010</option>
						                  			<option value="011">011</option>
						                  			<option value="016">016</option>
						                  			<option value="017">017</option>
						                  			<option value="018">018</option>
												</select>
											</div>
					                  		<span class="tac dpin width-20">-</span>
					                  		<input class=" fontVdn width-80 input_int" type="text" name="numberOnly" id="mbrPhone2" style="ime-mode:disabled;" maxlength="4"/>
					                  		<span class="tac dpin width-20"">-</span>
					                  		<input class=" fontVdn width-80 input_int" type="text" name="numberOnly" id="mbrPhone3" style="ime-mode:disabled;" maxlength="4"/>
										</td>
									</tr>
									<tr>
										<th>전화번호(사선)</th>
										<td>
											<div class="selectBox width-80">
												<label class="selectText fontVdn" for="mbrTelEx1">선택</label>
												<select class="search-sel" name="numberOnly" id="mbrTelEx1">
													<option value="">선택</option>
													<option value="02">02</option>
						                  			<option value="031">031</option>
						                  			<option value="032">032</option>
						                  			<option value="033">033</option>
						                  			<option value="041">041</option>
						                  			<option value="042">042</option>
						                  			<option value="043">043</option>
						                  			<option value="044">044</option>
						                  			<option value="051">051</option>
						                  			<option value="052">052</option>
						                  			<option value="053">053</option>
						                  			<option value="054">054</option>
						                  			<option value="055">055</option>
						                  			<option value="061">061</option>
						                  			<option value="062">062</option>
						                  			<option value="063">063</option>
						                  			<option value="000">------</option>
						                  			<option value="010">010</option>
						                  			<option value="011">011</option>
						                  			<option value="016">016</option>
						                  			<option value="017">017</option>
						                  			<option value="018">018</option>
						                  			<option value="019">019</option>
												</select>
											</div>
					                  		<span class="tac dpin width-20">-</span>
					                  		<input class=" fontVdn width-80 input_int" type="text" name="numberOnly" id="mbrTelEx2" style="ime-mode:disabled;"  maxlength="4"/>
					                  		
										</td>
										
										<th>전화번호(국선)</th>
										<td>
											<div class="selectBox width-80">
												<label class="selectText fontVdn" for="mbrTel1">선택</label>
												<select class="search-sel" id="mbrTel1">
													<option value="">선택</option>
													<option value="02">02</option>
						                  			<option value="031">031</option>
						                  			<option value="032">032</option>
						                  			<option value="033">033</option>
						                  			<option value="041">041</option>
						                  			<option value="042">042</option>
						                  			<option value="043">043</option>
						                  			<option value="044">044</option>
						                  			<option value="051">051</option>
						                  			<option value="052">052</option>
						                  			<option value="053">053</option>
						                  			<option value="054">054</option>
						                  			<option value="055">055</option>
						                  			<option value="061">061</option>
						                  			<option value="062">062</option>
						                  			<option value="063">063</option>
						                  			<option value="000">------</option>
						                  			<option value="010">010</option>
						                  			<option value="011">011</option>
						                  			<option value="016">016</option>
						                  			<option value="017">017</option>
						                  			<option value="018">018</option>
						                  			<option value="019">019</option>
												</select>
											</div>
					                  		<span class="tac dpin width-20">-</span>
					                  		<input class="fontVdn width-80 input_int" type="text" name="numberOnly" id="mbrTel2" style="ime-mode:disabled;" maxlength="4"/>
					                  		<span class="tac dpin width-20">-</span>
					                  		<input class="fontVdn width-80 input_int" type="text" name="numberOnly" id="mbrTel3" style="ime-mode:disabled;" maxlength="4"/>
										</td>
									</tr>
									<tr>
										<th>사용자 이메일</th>
										<td colspan="3"> 
											<input class="fontVdn width-150 input_int" type="text" id="userMail" style="ime-mode:disabled;" placeholder="이메일 입력"/>
											<span class="tac dpin width-20">@</span>
											<input class=" fontVdn width-150 input_int" type="text"  id="customDomain" placeholder="직접입력" disabled="disabled" />
											
											<div class="selectBox width-200 ml10" >
												<label class="selectText fontVdn" for="mailDomain">--직접입력--</label>
												<select class="search-sel" id="mailDomain">
													<option value="customAddr">--직접입력--</option>						  
												  	<c:forEach items="${getEmailCode}" var="getEmailCode" varStatus="status" >
												  	<option value="${getEmailCode.codeName}">${getEmailCode.codeName}</option>		
												  	</c:forEach>
												</select>
											</div>
										</td>
									</tr>
									<tr>
										<th>SMS 수신여부</th>
									  	<td>
									  		<!-- <span class="fl fontB dpin" style="width: 70px"  id="smsRecvFlag"></span> -->
										  	<div class="fl optionBox ">
												<label><input type="radio" name="smsradio" value="Y"><span>수신</span></label>
												<label><input type="radio" name="smsradio" value="N"><span>미수신</span></label>
											</div>		                  
										</td>
										<th>메일 수신여부</th>
									  	<td>
									  		<!-- <span class="fl fontB dpin" style="width: 70px"  id="mailRecvFlag"></span> -->
										  	<div class="fl optionBox "> 
												<label><input type="radio" name="mailradio" value="Y"><span>수신</span></label>
												<label><input type="radio" name="mailradio" value="N"><span>미수신</span></label>
											</div>		                  
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
		    	<!-- begin button-->
				<div class="row tac m-t-40">	
					<a type="button" class="rbton bton_blue" id="userInfoUpdate" ><i class="fa fa-floppy-o"></i> 저장</a>
					<a type="button" class="rbton bton_dgrey" onclick="moveViewPage2();"><i class="fa fa-close"></i> 취소</a>
				</div>
				<!-- end button -->
			
		</div> 
		<!-- end page-body -->
		
		<!-- #modal-dialog -->
                 <div class="modal fade" id="modal-dialog-profileImg">  
					<div class="modal-dialog">
	                   <div class="modal-content width-570">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                           <h4 class="modal-title">프로필사진 수정</h4>
	                       </div>
	                       <div class="modal-body">
								<div class="popPicChange m-b-20">
		                       		<c:if test="${file.size() eq 0}">
										<img class="userPic fl" alt="" src="${contextPath}/resources/mng/assets/img/defultPic.png"> 
										<input type="hidden" id="h_fileId" value="">
									</c:if>								
									<c:if test="${file.size() ne 0}">
										<img class="userPic fl" name="popPic" src="${wasPath}/mng/cmm/file/download/${file.get(0).fileId}" />
										<input type="hidden" id="h_fileId" value="${file.get(0).fileId}">
									</c:if>			
									<div class="m-t-20 fl tal m-l-30">
										<p class="f20 fc11 m-b-15">프로필사진</p>
										<a type="button" class="bton-s bton_blue"><span class="txt"><i class="fa fa-search"></i> 사진검색</span></a>
										<a type="button" class="bton-s bton_orange" onclick="fileRemove();"><span class="txt"><i class="fa fa-trash"></i> 사진삭제</span></a>
 
										<form id="file-form" name="file-form" action="${contextPath}/mng/cmm/file/deleteInsert" method="post"   enctype="multipart/form-data" target="_iframeFile">
											<input style="display:block;width:106px;height:36px;position:absolute;top:85px;left:160px;opacity:0;filter: alpha(opacity=0);cursor:pointer;" type='file' id='files' name='files' onclick="delSelectedFile();"/>
										       	<input type='hidden' id='fileNm' name='fileNm'/>
											    <div id="files-list" style="display:none;"></div>
									    </form>
									    <div style='display:none;'><iframe id='_iframeFile' name='_iframeFile'></iframe></div>
									</div>  
								</div>
								<div class="noticeCmt">
									<span class="txtBlue">100px X 100px</span> 사이즈에 최적화 되어 있습니다.<br>
									등록할 이미지 사이즈가 다른 경우 다르게 보일 수 있습니다.<br>
									<span class="txtRed">등록할 이미지는 10MB을 초과할 수 없습니다.</span>
								</div>
		                   	</div>
		                   	<div class="modal-footer tac">
	                       		<a type="button" class="bton-s bton_blue" data-dismiss="modal" onclick="closeModal();">확인</a>
	                       		<a type="button" class="bton-s bton_dgrey" data-dismiss="modal">취소</a>
	                       	</div>
		               	</div>
					</div>
                 </div>
                 
                 
                 
                 <!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog2">
	               <div class="modal-dialog width-720">
	                   <div class="modal-content  width-720">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">부서검색 </h4>
	                       </div>
	                       <div class="modal-body">
                       			<!-- search begin -->
								<div class="page_searchBox m-b-15">
									<div class="searchArea">
										<!-- <div class="selectBox width-150" > 
											<label class="selectText" >부서명</label> 
											<select class="search-sel" >
												<option>부서123</option>
												<option>부서456</option>
												<option>부서789</option>
											</select>
										</div> --> 
										<div class="inputArea m-l-5">
											<input type="text" placeholder="검색어를 입력하세요" id="searchKeywordDept">
											<a type="button" class="bton-s bton_blue" id="searchDepartment"><i class="fa fa-search"></i> 검색</a>
										</div>
									</div>
								</div>
								<!-- search end -->
								
								<div class="col-md-12 pl0 pr0">
									<input type="hidden" value="" id="h_popDeptCode">
     								<input type="hidden" value="" id="h_popDeptName">
									<table id="table-list"></table>									
								</div>
	                        </div>
	                       	<div class="modal-footer tac">
	                       		<a type='button' class="pbton bton_dgrey" data-dismiss="modal">닫기 </a>
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
<script type='text/javascript' src="${apachePath}/resources/assets/plugins/jqGrid/i18n/grid.locale-kr.js"></script>
<script type='text/javascript' src="${apachePath}/resources/assets/plugins/jqGrid/jquery.jqgrid.src.js"></script>
<script type="text/javascript">
	$(document).ready(function(){		
		App.init();
		userInfoDetail();
		 
		$("input:text[name='numberOnly']").bind('change keypress keydown keyup', function() {
			$(this).val( $(this).val().replace(/[^0-9]/gi,''));
		});
		
		// 이메일 도메인 직접입력
	 	$("#mailDomain").change(function() {
	 		var mailValue = $("#mailDomain > option:selected").val();
			if(mailValue=="customAddr"){
				$("#customDomain").attr("disabled", false);
			}else{
				$("#customDomain").attr("disabled", true);
				$("#customDomain").val("");
			}
	 	});	
		
		// 사용자 정보 저장
		$("#userInfoUpdate").click(function() {
			
			$.ajax({
				url : "${contextPath}/mng/cmm/user/passWordCheck",
				dataType : "JSON",
				data : {
					"passWord" : $("#userPassword").val()
				},
				success : function(data) {
	
					if(data == 1){
						confirmBox("저장하시겠습니까?", userInfoUpdate);	
					}else if(data == 2){
						alertBox("패스워드가 일치하지 않습니다.", userInfoDetail);
					}
					
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
				}				
			});
		});
			 	
 		$('#files').MultiFile({
 			list: "#files-list"
 			, max :2
 			, accept : 'gif|jpg|png'
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

		$("#openDepartment").click(function() {
			$("#modal-dialog2").modal();
			initialDepartment();
		});
		$("#searchKeywordDept").keypress(function(event) {
			if(event.keyCode==13) { searchDepartment(); }			
		});
		$("#searchDepartment").click(function() {
			searchDepartment();
		});
	});
	
	function userInfoDetail(){
		$.ajax({
			url : "${contextPath}/mng/cmm/user/userInfoDetail",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : $("#_userId").val()
			},
			success : function(data) {			
				setData(data);				
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	// ajax 데이터 화면에 출력
	function setData(data){
		
		$("#userName").text(data.userName);
		$("#customerId").val(data.customerId);
		$("#customerName").text(data.customerName);
		$("#deptCode").val(data.deptCode);
		$("#deptName").text(data.deptName);
		$("#deptName").val(data.deptName);

				
		$("#userLevel option[value='"+data.userLevel+"']").attr("selected","selected");
		if( $("#userLevel > option:selected").val() != "") {
			$("#userLevel").siblings(".selectText").text($("#userLevel").children('option:selected').text());
		} else {
			$("#userLevel").siblings(".selectText").text("직급선택");
		}

		var phoneArr = data.userPhone.split("-");
		$("#mbrPhone2").val(phoneArr[1]);
		$("#mbrPhone3").val(phoneArr[2]);
		$("#mbrPhone1 option[value='"+phoneArr[0]+"']").attr("selected", "selected");
		if( $("#mbrPhone1 > option:selected").val()!=""){
			$("#mbrPhone1").siblings(".selectText").text($("#mbrPhone1").children('option:selected').text());
		}else{
			$("#mbrPhone1").siblings(".selectText").text("선택");
		}
		
		// 전화번호 국선
		var telArr = data.userTel.split("-");
		$("#mbrTel2").val(telArr[1]);
		$("#mbrTel3").val(telArr[2]);
		$("#mbrTel1 option[value='"+telArr[0]+"']").attr("selected", "selected");		
		if($("#mbrTel1 > option:selected")!=""){
			$("#mbrTel1").siblings(".selectText").text($("#mbrTel1").children('option:selected').text());			
		}else{ 			
			$("#mbrTel1").siblings(".selectText").text("선택");
		}
		
		// 전화번호 (사선)
		var telExArr = data.userTelEx.split("-");
		$("#mbrTelEx2").val(telExArr[1]);
		
		$("#mbrTelEx1 option[value='"+telExArr[0]+"']").attr("selected", "selected");		
		if($("#mbrTelEx1 > option:selected")!=""){
			$("#mbrTelEx1").siblings(".selectText").text($("#mbrTelEx1").children('option:selected').text());			
		}else{ 			
			$("#mbrTelEx1").siblings(".selectText").text("선택");
		}
		
		if(data.smsRecvFlag == "N"){
			$("#smsRecvFlag").text("미수신")	
			$("input:radio[name=smsradio][value='N']").attr("checked",true);
		}else{
			$("#smsRecvFlag").text("수신")
			$("input:radio[name=smsradio][value='Y']").attr("checked",true);
		}
		
		if(data.mailRecvFlag == "N"){
			$("#mailRecvFlag").text("미수신")
			$("input:radio[name=mailradio][value='N']").attr("checked",true);
		}else{
			$("#mailRecvFlag").text("수신")
			$("input:radio[name=mailradio][value='Y']").attr("checked",true);
		} 
		
		var addrArr = data.userMail.split("@");
		var preAddr = addrArr[0]; 	
		var postAddr = addrArr[1];
		
		$("#userMail").val(preAddr);
		$("#mailDomain").val(postAddr);		
		$("#mailDomain option[value='"+postAddr+"']").attr("selected", "selected");		
		if($("#mailDomain > option:selected").text()!=""){
			$("#mailDomain").siblings(".selectText").text($("#mailDomain").children('option:selected').text());
		}else if($("#mailDomain > option:selected").text()==""){
			$("#mailDomain option[value='customDomain']").attr("selected", "selected");
			$("#mailDomain").siblings(".selectText").text($("#mailDomain").children('option:selected').text());
			$("#customDomain").attr("disabled", false);
			$("#customDomain").val(postAddr);
		} 
	}
	
	/// 저장 버튼  
	function userInfoUpdate(){
		var oldPwd  = $("#userPassword").val();
		var newPwd1 = $("#newuserPassword1").val();
		var newPwd2 = $("#newuserPassword2").val();
		if(oldPwd != "" || newPwd1 != "" || newPwd2 != "") {
			chkPassword(oldPwd, newPwd1, newPwd2);	
		} else {
			chkInputData();		
		}
	}
	
	function chkPassword(oldPwd, newPwd1, newPwd2) {
		if(oldPwd==""){
			alertBox2("기존 비밀번호를 입력하세요.", focusField, "#userPassword");
			return false;
		}
		if(newPwd1==""){
			alertBox2("새 비밀번호를 입력하세요.", focusField, "#newuserPassword1");
			return false;
		}
		if(newPwd2==""){
			alertBox2("새 비밀번호 확인를 입력하세요.", focusField, "#newuserPassword2");
			return false;
		}
		if(newPwd1 != newPwd2){
			alertBox2("새 비밀번호가 맞지않습니다", focusField, "#newuserPassword2");
			return false;
		}
		if( newPwd1.length < 8){
			alertBox2("비밀번호는 8자리 이상만 가능합니다.", focusField, "#newuserPassword1");
			return false;
		}
		
		var chkNum = newPwd1.search(/[0-9]/g);
		var chkEng = newPwd1.search(/[a-zA-Z]/g);
		var chkSpe = newPwd1.search(/[!,@,#,$,%,^,&,*,?,_,~]/g);
		//var vmath = (/([a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~].*[0-9])|([!,@,#,$,%,^,&,*,?,_,~].*[0-9].*[a-zA-Z])|([0-9].*[a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~])/);
		
		if( chkNum <0 || chkEng <0 || chkSpe <0){
			alertBox2("비밀번호는 문자, 숫자, 특수문자의 <br>조합으로 가능합니다.", focusField, "#newuserPassword1");
			return false;
		}		

		var SamePass_0 = 0;
		var SamePass_1 = 0;
		var SamePass_2 = 0;
		
		var chr_pass_0;
		var chr_pass_1;

		for(var i=0;i<newPwd1.length;i++){
			chr_pass_0 = newPwd1.charAt(i);
			chr_pass_1 = newPwd1.charAt(i+1);
			
			if(chr_pass_0==" "){
				alertBox2("공백은  사용할 수 없습니다.", focusField, "#newuserPassword1");
				return false;
			}
			
			// 다음 문자와 동일 문자 일 경우 1 증가, 연속이 아닐 경우 초기화 
			SamePass_0 = (chr_pass_0==chr_pass_1) ? SamePass_0 +1 : 0; 
						
			var code0 = chr_pass_0.charCodeAt(0);
			var code1 = chr_pass_1.charCodeAt(0);
			// 앞 뒤의 문자 코드값이 +1 차이날  경우 1 증가, 연속이 아닐 경우 초기화
			SamePass_1 = (code0 - code1 == 1) ? (SamePass_1+1) : 0;
			// 앞 뒤의 문자 코드값이 -1 차이날  경우 1 증가, 연속이 아닐 경우 초기화
			SamePass_2 = (code0 - code1 == -1) ? (SamePass_2+1) : 0;
			
			if(SamePass_0 >1){
				alertBox2("동일한 숫자, 문자를 3번이상 <br>사용할 수 없습니다.", focusField, "#newuserPassword1");
				return false;
			}
			if(SamePass_1 >1 || SamePass_2 >1){
				alertBox2("연속된 문자(123 또는 321, abc, cba 등)을 <br>3자 이상 사용할수 없습니다.", focusField, "#newuserPassword1");
				return false;
			}
		}
		userPasswordCheck(oldPwd);
	}
	
	function userPasswordCheck(oldPwd) {
		$.ajax({
			url : "${wasPath}/mng/cmm/user/userPasswordCheck",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : $("#_userId").val()
				,"userPassword" : oldPwd
			},
			success : function(data) {
				if(data==1){
					passwordUpdateAjax();					
				} else {
					alertBox2("기존 비밀번호가 맞지않습니다", focusField, "#userPassword");
				}				
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});		
	}
	
	function passwordUpdateAjax(){		
		$.ajax({
			url : "${wasPath}/mng/cmm/user/userInfoUpdatepw",
			dataType : "JSON",
			type : "POST",
			data : {
					"userId" : $("#_userId").val()
				    ,"userPassword": $("#newuserPassword1").val()			   
			},
			success : function(data) {
				chkInputData();
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});		
	}
	
	function chkInputData() {
		if($("#mbrPhone1").val()==""){
			alertBox2("사용자 핸드폰를 입력하세요", focusField, "#mbrPhone1");
			return false;
		}
		if($("#mbrPhone2").val()==""){
			alertBox2("사용자 핸드폰를 입력하세요", focusField, "#mbrPhone2");
			return false;
		}
		if($("#mbrPhone3").val()==""){
			alertBox2("사용자 핸드폰를 입력하세요", focusField, "#mbrPhone3");
			return false;
		}
		if($("#mbrTel1").val()!=""){
			if($("#mbrTel2").val()==""){
				alertBox2("전화번호(국선)를 입력하세요", focusField, "#mbrTel2");
				return false;
			}
			if($("#mbrTel3").val()==""){
				alertBox2("전화번호(국선)를 입력하세요", focusField, "#mbrTel3");				
				return false;
			}
		}
		if($("#mbrTel2").val()!=""){
			if($("#mbrTel1").val()==""){
				alertBox2("사용자 전화번호를 입력하세요", focusField, "#mbrTel1");				
				return false;
			}
			if($("#mbrTel3").val()==""){
				alertBox2("사용자 전화번호를 입력하세요", focusField, "#mbrTel3");
				return false;
			}
		}
		if($("#mbrTel3").val()!=""){
			if($("#mbrTel1").val()==""){
				alertBox2("사용자 전화번호를 입력하세요", focusField, "#mbrTel1");				
				return false;
			}
			if($("#mbrTel2").val()==""){
				alertBox2("사용자 전화번호를 입력하세요", focusField, "#mbrTel2");				
				return false;
			}
		}
		if($("#mbrTelEx1").val()!=""){
			if($("#mbrTelEx2").val()==""){
				alertBox2("전화번호(사선)를 입력하세요", focusField, "#mbrTelEx2");				
				return false;
			}			
		}
		if($("#mbrTelEx2").val()!=""){
			if($("#mbrTelEx1").val()==""){
				alertBox2("사용자 전화번호를 입력하세요", focusField, "#mbrTelEx1");
				return false;
			}			
		}
		if($("#deptName").text()==""){
			alertBox2("소속조직을 선택하세요", focusField, "#deptName");
			return false;
		}
		if($("#userLevel > option:selected").val()==""){
			alertBox2("직급을 선택하세요", focusField, "#userLevel");			
			return false;
		}
		if($("#userMail").val()=="") {
			alertBox2("사용자 이메일을 입력하세요", focusField, "#userMail");			
			return false;
		}			
		var Domain = $("#mailDomain > option:selected").val();
		if(Domain=="customAddr" && $("#customDomain").val() == "") {
			alertBox2("이메일 도메인을 직접 입력하세요", focusField, "#customDomain");			
			return false;
		}
		userInfoUpdateAjax();
	}
	
	function userInfoUpdateAjax(){
		
		var mailAddr = $("#userMail").val() + "@";	
		var Domain = $("#mailDomain > option:selected").val();		
		mailAddr += (Domain=="customAddr")? $("#customDomain").val() : Domain; 
		
		var mbrPhone = $("#mbrPhone1").val() + "-" +$("#mbrPhone2").val()+ "-" +$("#mbrPhone3").val();		
		var mbrTel   = $("#mbrTel1").val() + "-" +$("#mbrTel2").val()+ "-" +$("#mbrTel3").val();
		var mbrTelEx = $("#mbrTelEx1").val() + "-" +$("#mbrTelEx2").val();
		
		$.ajax({
			url : "${wasPath}/mng/cmm/user/userInfoUpdate",
			dataType : "JSON",
			type : "POST",
			data : {
					"userId" : $("#_userId").val()
					,"modUserId" : "${userId}"
					,"userPhone" : mbrPhone
					,"userTel" : mbrTel
					,"userTelEx" : mbrTelEx
					,"userMail" : mailAddr
					,"deptCode" : $("#deptCode").val()
					,"userLevel" : $("#userLevel > option:selected").val()
					,"smsRecvFlag" : $("input:radio[name='smsradio']:checked").val()
					,"mailRecvFlag" : $("input:radio[name='mailradio']:checked").val()					
			},
			success : function(data) {
				alertBox("저장되었습니다.", moveViewPage);
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});		
	}
	
	function moveViewPage(){
		if($('#files-list').children().length > 0 && $("#fileName").val() == $(".MultiFile-title").text()){ 
			$('#file-form').ajaxForm({
				cache : false
				, data : {
					"programName": "cmm_user"
					, "programSeq" : $("#_userId").val() 
				}
				, dataType:"json"
		       	//보내기전 validation check가 필요할경우
		       	, beforeSubmit: function (data, frm, opt) {
		       		var chk = true;
		       		
		       		$.each(data, function(i, val){
		       			if(val.value.size > 10485760){
		       				alertBox3("첨부파일 용량은 10MB를 초과할수 없습니다.");
		       				chk = false;
		       			}
		       		}); 
		       }
				,
		       //submit이후의 처리
		       success: function(result){	
	// 	 			location.href = "${wasPath}/mbr/cmm/user/userInfo?userId=${userId}";
		       },
		       complete : function(result){
		       },
		       //ajax error
		       error: function(e){
		       }                               
			});
			$('#file-form').submit(); 
		}
		
		setTimeout (function(){
			moveViewPage2();
		},500);
	}

	function moveViewPage2(){
		var userId=$("#_userId").val();
		 location.href = "${contextPath}/mng/cmm/user/userInfo?userId="+userId;
	}
	
	function focusField(id) {
		$(id).focus();
	}
	
	function openModal(){
		$("#modal-dialog-profileImg").modal();
	}	
	
	function closeModal(){
		$("#modal-dialog-profileImg").modal("hide");
		$("#fileName").val($(".MultiFile-title").text());
	}
	
// 	function getImgFile(){
			
// 		$.ajax({
// 			url : "${contextPath}/mng/cmm/file/list",
// 			dataType : "JSON",
// 			data : {
// 				"programName" : "cmm_user"
// 				, "programSeq" :  '${userId}'
// 			}, 
// 			success : function(data) {
// 				if(data.length !=0){
// 					$.each(data,function(key,val){
// 						var imgPath = "${wasPath}/mng/cmm/file/download/"+val["fileId"];
// 						$(".info > span > img[id='headerUserPic']").attr("src",imgPath);
// 						$("#fileName").val(val["fileName"]);
// 						$("#image_preview > img[name='popPic']").attr("src",imgPath);
// 						$("#h_fileId").val(val["fileId"]);
// 					});
// 				}else{
// 					var imgPath = "${apachePath}/resources/assets/img/userInfo_mypic_noImage.png";
// 					$(".info > span > img[id='headerUserPic']").attr("src",imgPath);
// 					$("#fileName").val("");
// 					$("#image_preview > img[name='popPic']").attr("src",imgPath);
// 					$("#h_fileId").val("");
// 				}
// 			},
// 			error : function(request, status, error) {
// 				alertBox("code : " + request.status + "\n" + "error : " + request.responseText, logout);
// 			}
// 		});
// 	}
	
// 	function fileUploadPreview(thisObj, preViewer){
// 		preViewer = (typeof(preViewer)=="object") ? preViewer : document.getElementById(preViewer);
// 		var ua = window.navigator.userAgent;
// 		if(ua.indexOf("MSIE") > -1){
// 			var img_path = "";
// 			if(thisObj.value.indexOf("\\fackepath\\")<0){
// 				img_path = thisObj.value;
// 			}else{
// 				thisObj.blur();
// 			}
// 		}else{
// 			 $("#image").on("change", function(){
					
// 				var file = $("#image").prop("files")[0];
// 				var blobURL = window.URL.createObjectURL(file);
// 				$("#image_preview img").attr("src",blobURL);
// 				$("#image_preview").slideDown();
// 				$(this).slideUp();
// 			 });
// 		}
// 	}	
	
	function delSelectedFile(){
		$(".MultiFile-remove").trigger('click');
	}
	
	//파일 삭제 및 썸네일 삭제
	function fileRemove(){
		if($("#h_fileId").val()==""){
			alertBox3("삭제할 사진이 없습니다.");
			return false;
		}else{
			var fileId = $("#h_fileId").val();
			
			$.ajax({
				url : "${wasPath}/mng/cmm/file/delete",
				dataType : "JSON",
				type : "POST",
				data : {
					"fileId" : fileId
					, "programName" : "cmm_user"
					, "programSeq" : $("#_userId").val()
				},
				success : function(data) {
					alertBox("삭제되었습니다.", closeModal);
				},
				error : function(request, status, error) {
					if(request.status == '200'){
						alertBox("접속이 만료되었습니다.", logout);				
					}else{
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				}
			});
		}
	}
	// 부서 modal 실행
	function initialDepartment() {
		$("#table-list").jqGrid('clearGridData', true);
		$("#table-list").jqGrid({
			url: '${contextPath}/mng/cmm/department/TreeAll',
			mtype: "POST",
			datatype: "json",
			postData: {	},
			colNames:['부서코드','상위부서코드', '부서명','level','isLeaf', 'isExpanded'],
			colModel:[				
				{name:'deptCode', 	index:'deptCode', 	hidden:false, 	width:140, align:"center", key: true}
				,{name:'upCode', 	index:'upCode', 	hidden:true, 	width:100, align:"left"}
	 	   		,{name:'deptName', 	index:'deptName', 	hidden:false, 	width:520, align:"left"}	 	   			 	   		
	 	   		,{name:'treeLevel', index:'treeLevel', 	hidden:true, 	width:220, align:"left"}
	 	   		,{name:'isLeaf', 	index:'isLeaf', 	hidden:true, 	width:220, align:"left"}
	 	   		,{name:'isExpanded',index:'isExpanded',	hidden:true, 	width:220, align:"left"}	 	   		
			],			
// 			rowNum:10,
// 			rowList:[5,10,15],
			rownumbers:false,
			loadonce:false,
			scrollrows:true,
			loadtext : "조회중 잠시만 기다려주세요.",
			//shrinkToFit:false,
// 			height: '100%', //300, //$(".tbl_type01").height()-40, $("#table-list").height()-100,
// 			width : '100%',
			gridview : true,
			treeGrid : true,
			treeGridModel: 'adjacency',
			ExpandColumn: 'deptName',
			ExpandColClick: true,
			tree_root_level: 1,
 			treeIcons: {
 				plus: 'ui-icon-triangle-1-e',
 				minus:'ui-icon-triangle-1-s',
 				leaf: 'ui-icon-radio-off'},
//  			leaf: 'ui-icon-document-b'}, 				
			jsonReader : {
				root: 'data'			//controller에서 가져오는 json명
				, id: 'deptCode'
				, repeatitems: true
			},
			treeReader: {
				level_field: 'treeLevel'
				, parent_id_field: 'upCode'
				, leaf_field: 'isLeaf'
				, expanded_field: 'isExpanded'
			},
			gridComplete: function() {				
			},
			loadError : function(xhr,status, error) {
				alert(error);
			},
			onSelectRow:function(rowid, status, e) {
				var list = $('#table-list').getRowData(rowid);				
 				var code = list.deptCode;
				var name = list.deptName.split('>');
				name = name[name.length -1];
				$("#h_popDeptCode").val(code); 
				$("#h_popDeptName").val(name);					
			},
			onCellSelect:function(rowid, iCol) {
// 				var list = $('#table-list').getRowData(rowid);				
// 				var treeLevel = list.treeLevel;
					
// 				if(treeLevel != 1){
// 					var code = list.deptCode;
// 					var name = list.deptName.split('>');
// 					name = name[name.length -1];				
// 					$("#h_popDeptCode").val(code); 
// 					$("#h_popDeptName").val(name);
// 					confirmBox(name+"를 적용하시겠습니까?", updateDepartment);
// 				}else{
// 					var code = list.deptCode;
// 					var name = list.deptName.split('>');
// 					name = name[name.length -1];				
// 				}
			},
			ondblClickRow:function(rowid, iRow, iCol) {
				var list = $('#table-list').getRowData(rowid);
				var code = list.deptCode;
				var name = list.deptName.split('>');
				name = name[name.length -1];
				$("#h_popDeptCode").val(code); 
				$("#h_popDeptName").val(name);
				confirmDepartment();
			}
		}).trigger('reloadGrid');
	}
	// 부서검색
	function searchDepartment() { 		
		$("#table-list").jqGrid('setGridParam', {
			url: '${contextPath}/mng/cmm/department/TreeAll',
			mtype: "POST",
			datatype: "json",			
			postData: {
				"searchKind": "dept_name",
				"keyword":$("#searchKeywordDept").val()
			}
		}).trigger('reloadGrid');
	}
	function confirmDepartment() {		 
		var deptName = $("#h_popDeptName").val();
		confirmBox(deptName+"를 적용하시겠습니까?", updateDepartment);
	}
	// 부서 적용
	function updateDepartment() {
		var deptCode = $("#h_popDeptCode").val(); 
		var deptName = $("#h_popDeptName").val();		 
		$("#deptCode").val(deptCode);
		$("#deptName").val(deptName);
// 		$("#deptName").text(deptName);
		
		$("#searchKeywordDept").val("");		
		$("#modal-dialog2").modal("hide");
	}
	
</script>
</body>
</html>
