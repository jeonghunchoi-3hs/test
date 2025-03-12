<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
		<link href="${apachePath}/resources/assets/plugins/jqGrid/css/ui.jqgrid.css" rel="stylesheet" />
		<title>KEPCO Cloud Service Platform</title>
	</head>

	<body>
		<!-- begin #page-container -->
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
			<!-- begin #page-container > #hedaer -->
			<div id="header" class="header navbar navbar-default navbar-fixed-top">
				<div class="info width-300 pt10 pr20">
					<span class="f16 fw"> <img src="${apachePath}/resources/assets/img/df_user_icon.png"/> 어서오세요. 반갑습니다.</span>
				</div>
				<div class="container-fluid">
					<div class="navbar-header">
						<a href="${wasPath}/mbr/" class="navbar-brand"><img src="${apachePath}/resources/assets/img/logo.png" width="200px" class="logo" alt="ECloud"/> </a>
					</div>
				</div>
			</div>
			<!-- end #page-container > #hedaer -->

			<div id="sidebar" class="sidebar">
				<!-- begin sidebar scrollbar -->
				<div   id='divSidebar' style='display:none'></div>
				<!-- end sidebar scrollbar -->
			</div>

			<!-- begin begin #page-container > #content (페이지 바디 컨텐츠 시작입니다)-->
			<div id="content" class="content">
				<p class="page_title mb30">회원가입</p>


				<!-- begin page-body -->
				<div class="row mb50">
					<div class="memJoinStep">
						<img src="${apachePath}/resources/assets/img/memStep02.png"/>
					</div>

					<div class="orderArea">
						<div class="tableF">
							<form name="mbrform"  id="mbrform" action="mbrInsert.do" method="post" >
								<!-- <input type="hidden" name="customerId" id="customerId" value="" /> -->
								<input type="hidden" name="deptCode" id="deptCode" value="" />
								<table>
									<colgroup>
										<col width="140px">
										<col width="*">
										<col width="140px">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<td class="left">사번</td>
										  	<td>
										  		<div class="flex align-center gap10">
											  		<input type="hidden" id="confirmFlag" value=""  />
											  		<!--  <input type="text" id="userIdPattern" value="" readonly class="form-control width-100 dpin"/>-->

													<input type="text" id="mbrId"  class="form-control width-350 dpin" maxlength="8" onkeyup="if(event.keyCode==13){openUserSearchModal()};"  placeholder="사번 또는 이름을 검색하세요""/>
											 		<img style="cursor: pointer" id="openUserSearch" src="${apachePath}/resources/assets/img/icon_search.png" onclick="openUserSearchModal();"   />
											 		<img style="cursor: pointer" src="${apachePath}/resources/assets/img/icon_check.png" onclick="userIdValCheck();" />
										  		</div>
								 			</td>
										  	<td class="left">회원사</td>
										    <td>
										    	<div class="flex align-center gap10">
											    	<div class="searchBoxArea width-150 dpin">
											  			<label class="selectBoxDrop">한국전력공사</label>
								                  		<select class="search-sel" id="customerList">
								                  			<option value="kepco:KE" selected="selected">한국전력공사</option>
								                  			<!--
								                  			<c:forEach items="${getCustomerList}" var="getCustomerList" varStatus="status" >
														  	<option value="${getCustomerList.customerId}:${getCustomerList.userIdPattern}">${getCustomerList.customerName}</option>
														  	</c:forEach>
														  	-->
								                  		</select>
								                  	</div>
										      		<input type="text" id="deptName" value="" class="form-control width-300  dpin" placeholder="부서를 선택하세요"  readonly="readonly"/>
							                 		 <img src="${apachePath}/resources/assets/img/icon_search.png" id="openDepartment"  class="input_search"/>
							                 	</div>
											</td>
										</tr>
						 				<tr>
										    <td class="left">비밀번호</td>
										  	<td style="position:relative; overflow:initial;">
										  		<input type="password" id="newUserPassword1"  class="form-control" style="ime-mode:active;" placeholder="비밀번호는 문자, 숫자, 특수문자의 조합으로 8자 이상 가능 합니다. " />
										  		<p class="fc_red" style="position:absolute; top: calc(100% - 12px); font-size:13px;">· 사용 가능한 특수문자  ! , @ , # , $ , % , ^ , & , * , ? , _ , ~  </p>
									  		</td>
										 	<td class="left">비밀번호 확인</td>
										  	<td>
										  		<input type="password" id="newUserPassword2"  class="form-control" style="ime-mode:active;" placeholder="비밀번호를 한번 더 입력 해주세요." />

										  	</td>
									 	</tr>
										<tr>
						  					<td class="left">이름</td>
						  					<td> <input type="text" id="mbrName" class="form-control w493" placeholder="사용자를 입력하세요" style="ime-mode:active;"/> </td>
						   					<td class="left">직급</td>
						  					<td>
												<div class="searchBoxArea">
						  							<div>
						  								<label class="selectBoxDrop" for="userLevel">선택</label>
			                  							<select id="userLevel" class="search-sel">
			                  								<c:forEach items="${getPositionCode}" var="getPositionCode" varStatus="status" >
									  							<option value="${getPositionCode.codeName}">${fn:replace(getPositionCode.codeName, '직급', '')}</option>
									  						</c:forEach>
			                  							</select>
			                  						</div>
			                  					</div>
						  					</td>
										</tr>
										<tr>
						  					<td class="left">전화번호 (사선)</td>
						  					<td>
						  						<div class=" flex align-center">
							                  		<input type="text" class="form-control w158" id="mbrTelEx1" name="numberOnly" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
				                  					<span class="dsline">­ ― </span>
				                  					<input type="text" class="form-control w158" id="mbrTelEx2" name="numberOnly" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
				                  				</div>
						  					</td>
						   					<td class="left">전화번호 (국선)</td>
						  					<td>
						  						<div class=" flex align-center">
							  						<div class="searchBoxArea w138">
							  							<div>
							  								<label class="selectBoxDrop" for="mbrTel1">선택</label>
				                  							<select name="mbrTel1" id="mbrTel1" class="search-sel">
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
									                  			<option value="">------</option>
									                  			<option value="010">010</option>
									                  			<option value="011">011</option>
									                  			<option value="016">016</option>
									                  			<option value="017">017</option>
									                  			<option value="018">018</option>
									                  			<option value="019">019</option>
									                  		</select>
				                  						</div>
				                  					</div>
				                  					<span class="dsline"> ― </span><input type="text" class="form-control w158" name="numberOnly" id="mbrTel2" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
				                  					<span class="dsline"> ― </span><input type="text" class="form-control w158" name="numberOnly" id="mbrTel3" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
				                  				</div>
						  					</td>
										</tr>
										<tr>
						  					<td class="left">핸드폰</td>
						  					<td>
						  						<div class=" flex align-center">
							 	 					<div class="searchBoxArea w138">
							  							<div>
							  								<label class="selectBoxDrop" for="mbrPhone1">선택</label>
				                  							<select id="mbrPhone1" class="search-sel">
									                  			<option value="">선택</option>
									                  			<option value="010">010</option>
									                  			<option value="011">011</option>
									                  			<option value="016">016</option>
									                  			<option value="017">017</option>
									                  			<option value="018">018</option>
									                  			<option value="019">019</option>
									                  		</select>
				                  						</div>
				                  					</div>
				                  					<span class="dsline"> ― </span><input type="text" class="form-control w158" name="numberOnly" id="mbrPhone2" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
				                  					<span class="dsline"> ― </span><input type="text" class="form-control w158" name="numberOnly" id="mbrPhone3" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
				                  				</div>
						  					</td>
						    				<td class="left">이메일</td>
						  					<td>
						  						<div class=" flex align-center">
								  					<input type="text" id="mbrMail" class="form-control w158" style="ime-mode:disabled;" placeholder="이메일 입력"/>
								  					<span class="golline">@</span>
								  					<input type="text" class="form-control w138" placeholder="직접입력" id="customAddr">
								  					<div class="searchBoxArea w158 ml10">
														<div>
							  								<label class="selectBoxDrop" for="mailDomain">--직접입력--</label>
										  					<select class="search-sel" id="mailDomain">
										  						<option value="customAddr">--직접입력--</option>
										  						<c:forEach items="${getEmailCode}" var="getEmailCode" varStatus="status" >
										  							<option value="${getEmailCode.codeName}">${getEmailCode.codeName}</option>
										  						</c:forEach>
										  					</select>
									 					</div>
								 					</div>
								 				</div>
						  					</td>
										</tr>
										<tr>
						  					<td class="left-t">정보수신여부</td>
						  					<td class="vat">
						  						<div  class="flex align-center">
								  					<label class="flex align-center"><input type="radio"  class="va-tb" name="recvFlag" value="Y" style="margin-right:4px;" checked /> 수신(SMS, 메일)</label>
								  					<label class="flex align-center ml20"><input type="radio"  class="va-tb" name="recvFlag" value="N" style="margin-right:4px;" /> 미수신</label>
								  				</div>
												<div class="col-xs-12 mt10 pl0" id='divRecvFlag'>
													<label style="font-weight:400;"><input type="checkbox" name="smsRecvFlag" value="Y" checked="checked"/> SMS수신</label>
													<label class="ml20" style="font-weight:400;"><input type="checkbox" name="mailRecvFlag" value="Y" checked="checked" /> 메일수신</label>
												</div>
						  					</td>
						  					<td class="left-t pt20">자동가입방지</td>
						  					<td class="pt20">
												<input type="text" class="form-control w228 mt10" id="autoStringtext" name="autoStringtext" style="ime-mode:disabled;"/>
												<img src="${apachePath}/resources/assets/img/icon_reload.png" id="catchaRefresh" class="reload mt10">
						  					</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>
					<!-- end of div orderArea -->
	    		</div>
		    	<!-- end section-container -->

				<!-- begin button----------->
				<div class="btn_area">
					<a type=button id="jquerybuttonok" name="jquerybuttonok"  class="m_btn_navy" onclick="valchk();">가입</a>
					<a type=button class="m_btn_white ml10" onclick="moveLoginPage()">취소</a>
				</div>
				<!-- end button----------->
				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->
			</div>
			<!-- end of context -->
			<!-- end page-body -->


			<!-- #modal-dialog2 고객사 검색-->
	        <%-- <div class="modal fade" id="modal-dialog2">
	            <div class="modal-dialog width-720">
	                <div class="modal-content width-720">
	                    <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                        <h4 class="modal-title">고객사 검색</h4>
	                    </div>
	                    <div class="modal-body">
					 	<!-- search begin -->
					 	<div class="col-md-12 bgee modalpop mb20">
							<div class="" style="text-align: center; display:inline-block;">
								<div class="col-md-8">
									<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="searchKeyword" data-original-title="" title="">
								</div>
							  	<button type="button" class="btn_search2" onclick="searchCustomer();"><span></span></button>
							</div>
						</div>
					 	<!-- search end -->
					   <div>
				   		<input type="hidden" value="" id="h_popCustomerId">
	     				<input type="hidden" value="" id="h_popCustomerName">
	     				<input type="hidden" value="" id="h_popUserIdPattern">
					   	<table class="table table-bordered table-hover table-striped table-td-valign-middle">
							 <colgroup>
							 <col width="20%">
							 <col width="40%">
							 <col width="20%">
							 <col width="20%">
							 </colgroup>
							 <thead>
							 <tr class="skyblue">
								<th class="tac">회원사 아이디</th>
								<th class="tac">회원사 이름</th>
								<th class="tac">아이디 패턴</th~>
								<th class="tac">적용</th>
							 </tr>
							 </thead>
							 <tbody id="popListTable">
							 </tbody>
					 	</table>
						 </div>
	               	</div>
					<div class="clear"></div>
					<div class="modal-footer tac">
	             			<a type=button class="lbtn" data-dismiss="modal" onclick="updateCustomer();">확인</a>
	             			<a type=button class="rbtn" data-dismiss="modal">취소</a>
	                 	</div>
	              </div>
	           </div>
	        </div> --%>
			<!-- #modal-dialog2  고객사  검색//-->

			<!-- #modal-dialog3 부서 검색-->
	        <div class="modal fade" id="modal-dialog3">
	            <div class="modal-dialog width-720">
	                <div class="modal-content width-720">
	                <!-- <table class="tbl_type01" id="deptTreeGrid" summary="" cellpadding="0" cellspacing="0"></table> -->

	                    <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                        <h4 class="modal-title">부서 검색</h4>
	                    </div>
	                    <div class="modal-body">
					 	<!-- search begin -->
					 	<div class="col-md-12 bgee modalpop mb20">
								<div class="col-md-12">
								<input type="text" class="search-text-s" placeholder="검색어를 입력하세요" id="searchKeywordDept">
							  	<button type="button" class="btn_search2 vm" id="searchDepartment"><span></span></button>
							  	</div>

						</div>
					 	<!-- search end -->
					   <div class="col-md-12 mb20">
				   		<input type="hidden" value="" id="h_popDeptCode">
	     				<input type="hidden" value="" id="h_popDeptName">
	     				<div class="table_wrap ">
							<table class="tbl_type01" id="table-list" summary="" cellpadding="0" cellspacing="0">
							</table>
						</div>
					   </div>
	               	</div>
					<div class="clear"></div>
					<div class="modal-footer tac">
	             			<a type="button" class="lbtn" data-dismiss="modal" onclick="confirmDepartment();">확인</a>
	             			<a type="button" class="rbtn" data-dismiss="modal">취소</a>
	                 	</div>
	              </div>
	           </div>
	        </div>
			<!-- #modal-dialog 부서  검색//-->

			<!-- 사용자정보 검색 modal -->
			<div class="modal fade" id="user-modal-approve-dialog">
				<div class="modal-dialog">
					<div class="modal-content w560">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick='gridList();'> <span></span> </button>
							<h4 class="modal-title">사원검색</h4>
						</div>
						<div class="modal-body">
							<!-- 검색 시작 -->
							<div class="col-xs-12 bgee modalpop mb20">
								<div class="selectBoxBr col-xs-3">
									<label class="selectText" for="approveSearchKind">전체</label>
									<select class="search-sel" id="approveSearchKind">
										<option value="searchAll">전체</option>
										<option value="userId">사번</option>
										<option value="userName">이름</option>
									</select>
								</div>
								<div class="search-box">
									<input type="text" class="search-text-s" placeholder="사번 또는 이름을 입력하세요" id="approveUserId" onkeypress="if(event.keyCode==13)modalSearchUserList();" >
									<button type="button" class="btn_search2 vm" onclick="modalSearchUserList();"><span></span></button>
								</div>
							</div>
							<!-- 검색  끝 -->
							<table class="tableV">
						 		<colgroup>
						 			<col width="20%">
						 			<col width="20%">
						 			<col width="*">
						 			<col width="30%">
						 		</colgroup>
						 		<thead>
						 			<tr class="skyblue">
										<th class="tac">사번</th>
										<th class="tac">직급</th>
										<th class="tac">이름</th>
										<th class="tac">부서</th>
						 			</tr>
						 		</thead>
						 		<tbody id="popListApproveTable">
						 		</tbody>
				 	    	</table>

							<div class="noneList" id='popListApproveTable2'>
								<span>검색된 사용자가 없습니다.</span>
							</div>
							<div class="totalcnt" id="totalApproveCnt">총 0 건</div>
						</div>
						<div class="modal-footer tac">
							<a type="button" class="m_btn_navy" data-dismiss="modal">닫기</a>
						</div>
					</div>
				</div>
			</div>
			<!-- #modal-dialog 사용자검색 -->

			<!-- End of Modal-Box -->
		</div>
		<!-- end page container -->

		<c:import url="/WEB-INF/views/mbr/include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.realperson.js"></script>

		<script type='text/javascript' src="${apachePath}/resources/assets/plugins/jqGrid/i18n/grid.locale-kr.js"></script>
		<script type='text/javascript' src="${apachePath}/resources/assets/plugins/jqGrid/jquery.jqgrid.src.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("input,textarea").placeholder();
				App.init();
				$(":radio[name='recvFlag']").bind('change', function() {
					if($(":radio[name='recvFlag']:checked").val() == "Y"){
						$("#divRecvFlag").show();
						$(":checkbox[name='smsRecvFlag']").attr("checked", true);
						$(":checkbox[name='mailRecvFlag']").attr("checked", true);
					}else{
						$(":checkbox[name='smsRecvFlag']").attr("checked", false);
						$(":checkbox[name='mailRecvFlag']").attr("checked", false);
						$("#divRecvFlag").hide();
						alertBox3("진행사항에 대한 알림을 수신할 수 없습니다.");
					}
				});
				$(":checkbox[name='smsRecvFlag']").bind('change', function(){
					if($(":checkbox[name='smsRecvFlag']").is(":checked") == false
							&& $(":checkbox[name='mailRecvFlag']").is(":checked") == false){
						alertBox3("진행사항에 대한 알림을 수신할 수 없습니다.");
					}
				});
				$(":checkbox[name='mailRecvFlag']").bind('change', function(){
					if($(":checkbox[name='smsRecvFlag']").is(":checked") == false
							&& $(":checkbox[name='mailRecvFlag']").is(":checked") == false){
						alertBox3("진행사항에 대한 알림을 수신할 수 없습니다.");
					}
				});

				// 사번 중복 확인
			 	$("#mbrId").keypress(function(){
			 		$("#confirmFlag").val("N");
			 	});

				// 비밀번호 특수 문자 확인
				$("#newUserPassword1").blur(function() {
					if($("#newUserPassword1").val() != "") { // 무한 반복 방지 ()
						var vmath = (/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/);
						if( !$("#newUserPassword1").val().match(vmath)){
							alertBox2("비밀번호는 문자, 숫자, 특수문자의 <br>조합으로 가능합니다.", focusField, "#newUserPassword1");
							return;
						}
						if( $("#newUserPassword1").val().length < 8 ) {
							alertBox2("비밀번호는 8자리 이상만 <br>가능합니다.", focusField, "#newUserPassword1");
							return;
						}
					}
				});

				$("#newUserPassword2").blur(function() {
					var pwd1 = $("#newUserPassword1").val();
					var pwd2 = $("#newUserPassword2").val();
					if( pwd2 != "" && pwd1 != pwd2 ) {
						alertBox2("비밀번호가 일치하지 않습니다.", focusField, "#newUserPassword2");
					}
				});

				$("input:text[name='numberOnly']").bind('change keypress keydown keyup', function() {
					$(this).val( $(this).val().replace(/[^0-9]/gi,''));
				});

			 	// select box text 설정
				$(".search-sel").change(function() {
					$(this).siblings(".selectBoxDrop").text($(this).children('option:selected').text());
				});

			 	$("#customerList").change(function() {
			 		$("#customerName").val($(this).children('option:selected').text());
			 		var values = $(this).children('option:selected').val().split(":");
			 		$("#userIdPattern").val(values[1]);
			 	});

			 	// 이메일 도메인 직접입력
			 	$("#mailDomain").change(function() {
			 		var mailValue = $("#mailDomain > option:selected").val();
					if(mailValue=="customAddr"){
						$("#customAddr").attr("disabled", false);
					}else{
						$("#customAddr").attr("disabled", true);
						$("#customAddr").val("");
					}
			 	});

			 	;
			 	$("#catchaRefresh").click(function() {
			 		$(".realperson-text").trigger("click");
			 	});

			 	$("#autoStringtext").realperson({ // realperson 초기화
					length:6
					, chars: $.realperson.alphabetic
					, regenerate : ""
				}).on({ // 자동가입 문자 컨트롤
			 		"keypress" : function() {
			 			$("#autoStringtext").val($("#autoStringtext").val().toUpperCase());
			 		},
			 		"keyup blur" : function() {
			 			var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
						if(pattern.test(this.value)){
							$(this).val(this.value.replace(pattern, ''));
						}

						var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
						if(pattern2.test(this.value)){
							$(this).val(this.value.replace(pattern2, ''));
						}
						$(this).val(this.value.toUpperCase());
			 		}
			 	}); // end of #autoStringtext
			 	$("#openDepartment").click(function() {
					$("#modal-dialog3").modal();
					initialDepartment();
				});
				$("#searchKeywordDept").keypress(function(event) {
					if(event.keyCode==13) { searchDepartment(); }
				});
				$("#searchDepartment").click(function() {
					searchDepartment();
				});

				//회원정보 자동 채우기
				var autoId = "${getUserId}";
				if(autoId){
					modalSearchUserList(autoId);
				}
			}); // end of document.ready()

			function reload(){
				location.reload();
			}

			function reload2(){
				$(".realperson-regen").trigger('click');
			}

			//로그인페이지로 이동
			function moveLoginPage(){
				location.href="${wasPath}/mbr/";
			}
			//완료페이지 이동
			function moveCompPage() {
				location.href="${wasPath}/mbr/req/user/mbrCompPage";
			}

			// 알람 후 focus 이동 callback 함수
			function focusField(id) {
				$(id).focus();
			}

			function valchk(){
				if($("#mbrId").val()==""){
					alertBox2("사번를 입력하세요", focusField, "#mbrId");
					return false;
				}
				if($("#confirmFlag").val()=="N"){
					alertBox2("사번 중복확인을 하세요", focusField, "#mbrId");
					return false;
				}
				if($("#customerList").val()==""){
					alertBox2("고객사를 선택하세요", focusField, "#customerList");
					return false;
				}
				if($("#deptCode").val()=="") {
					alertBox2("부서를 선택하세요", focusField, "#deptCode");
					return false;
				}
				if($("#mbrName").val()==""){
					alertBox2("사용자 이름을 입력하세요", focusField, "#mbrName");
					return false;
				}
				if($("#userLevel").val()==""){
					alertBox2("직급을 선택하세요", focusField, "#userLevel");
					return false;
				}
				if($("#newUserPassword1").val()=="") {
					alertBox2("새 비밀번호를 입력하세요", focusField, "#newUserPassword1");
					return false;
				}
				if($("#newUserPassword2").val()=="") {
					alertBox2("새 비밀번호 확인을 입력하세요", focusField, "#newUserPassword2");
					return false;
				}
				if($("#newUserPassword1").val().length < 7) {
					alertBox2("비밀번호는 7자리 이상만 <br>가능합니다.", focusField, "#newUserPassword1");
					return false;
				}
				/*
				if($("#mbrTelEx1 > option:selected").val() != "") {
					if($("#mbrTelEx2").val()=="") {
						alertBox2("전화번호 (사선) 입력하세요", focusField, "#mbrTelEx2");
						return false;
					}
				}
				if($("#mbrTelEx2").val()!="") {
					if($("#mbrTelEx1 > option:selected").val()=="") {
						alertBox2("전화번호 (사선) 을 선택하세요", focusField, "#mbrTelEx2");
						return false;
					}
				}
				*/
				if($("#mbrTelEx1").val() == "") {
					alertBox2("전화번호 (사선) 앞자리 을 입력하세요", focusField, "#mbrTelEx1");
					return false;
				}
				if($("#mbrTelEx2").val()=="") {
					alertBox2("전화번호 (사선) 뒷자리를 입력하세요", focusField, "#mbrTelEx2");
					return false;
				}

				if($("#mbrTel1 > option:selected").val()!="") {
					if($("#mbrTel2").val()=="") {
						alertBox2("전화번호 (국선)을입력하세요", focusField, "#mbrTel2");
						return false;
					}
					if($("#mbrTel3").val()=="") {
						alertBox2("전화번호 (국선)을입력하세요", focusField, "#mbrTel3");
						return false;
					}
				}
				if($("#mbrPhone1 > option:selected").val()==""){
					alertBox2("핸드폰번호를 입력하세요", focusField, "#mbrPhone1");
					return false;
				}
				if($("#mbrPhone2").val()==""){
					alertBox2("핸드폰번호를 입력하세요", focusField, "#mbrPhone2");
					return false;
				}
				if($("#mbrPhone3").val()==""){
					alertBox2("핸드폰번호를 입력하세요", focusField, "#mbrPhone3");
					return false;
				}

				var mailValue = $("#mbrMail").val();
				var domain = $("#mailDomain > option:selected").val();
				var customDomain = $("#customAddr").val();
				if(mailValue == ""){
					alertBox2("이메일을 입력하세요", focusField, "#mbrMail");
					return false;
				}
				if(domain == ""){
					alertBox2("이메일 도메인을 선택하세요", focusField, "#mbrMail");
					return false;
				}
				if(domain == "customAddr" && customDomain == ""){
					alertBox2("이메일 도메인을 입력하세요", focusField, "#customAddr");
					return false;
				}
				if(domain == "customAddr" && customDomain != ""){
					var fullMail = mailValue +"@"+ customDomain;
				   	if( fullMail != "" && (fullMail.indexOf("@")== -1 || fullMail.indexOf(".")== -1)) {
				   		alertBox2("이메일 형식으로만 입력이 <br>가능합니다.", focusField, "#customAddr");
						return false;
				    }
				}
				if($("#autoStringtext").val()==""){
					alertBox2("자동가입방지문자를 입력하세요", focusField, "#autoStringtext");
					return false;
				}
				confirmBox("가입신청을 하시겠습니까?", mbrInsert);
			}
			// end of function valchk()

			// 사용자 ID 체크
			function userIdValCheck(){

				var mbrId = $("#mbrId").val();
				if(mbrId == ""){
						alertBox2("사번을 입력하세요.", focusField, "#mbrId");
						return false;
				}
				$.ajax({
					url : "mbrIdcheck",
					dataType : "JSON",
		 			type : "GET",
					data : {
						"userId" : mbrId
					},
					success : function(data) {
						var result = data;
						if(result.chkval==0){
							$("#confirmMsg").css("color","blue");
							$("#confirmFlag").val("Y");
						}else{
							$("#confirmMsg").css("color","#ff0000");
							$("#confirmFlag").val("N");
						}
						alertBox3(result.idchktext);
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			 } // end of function userIdValCheck()

			// 사용자 사번 검색
			function userIdSearch() {
				var mbrId = $("#mbrId").val();
				if(mbrId == ""){
						alertBox2("11사번을 입력하세요.", focusField, "#mbrId");
						return false;
				}

				$.ajax({
					url : "mbrIdSearch",
					dataType : "JSON",
		 			type : "GET",
					data : {
						"userId" : mbrId
					},
					success : function(data) {
						var result = data;
						if(result.chkval==0){
							$("#confirmMsg").css("color","blue");
							$("#confirmFlag").val("Y");
						}else{
							$("#confirmMsg").css("color","#ff0000");
							$("#confirmFlag").val("N");
						}
						alertBox3(result.idchktext);
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			 } // end of function userIdValCheck()

			// 사용자 가입 최종 신청
			function mbrInsert() {

				var jsonData = setJsonData();

				$.ajax({
					url : "mbrInsert",
					dataType : "JSON",
					type : "POST",
					data : jsonData,
					success : function(data) {
						var result = data;
						if(result==1){
							alertBox("가입신청이 완료되었습니다.", moveCompPage);

						}else if(result==2){
							warningBox("사번을 사용하실수 없습니다.");
						}else if(result==3){
							alertBox("자동가입방지 문자 입력이 <br>잘못되었습니다.", reload2);
						}else{
							warningBox("fail!");
							moveCompPage();
						}
					},
					error : function(request, status, error) {
						alertBox("code:" + request.status + "\n" + "error:" + error);
					}
				});
			} // end of function mbrInsert()

			// json 데이터 세팅
			function setJsonData(){

				var userPhone = $("#mbrPhone1 > option:selected").val() +"-"+ $("#mbrPhone2").val() +"-"+ $("#mbrPhone3").val();
				var userTel = $("#mbrTel1 > option:selected").val() +"-"+ $("#mbrTel2").val() +"-"+ $("#mbrTel3").val();
				//var userTelEx = $("#mbrTelEx1 > option:selected").val() +"-"+ $("#mbrTelEx2").val();
				var userTelEx = $("#mbrTelEx1").val() +"-"+ $("#mbrTelEx2").val();

				var userMail = $("#mbrMail").val() + "@";
				var domain = $("#mailDomain > option:selected").val();
				if(domain =="customAddr"){ userMail += $("#customAddr").val(); }
				else					 { userMail += domain; }
				var customerIds = $("#customerList > option:selected").val().split(":");
				var jsonData = {
						"userId" : $("#mbrId").val()
						, "userName"	:$("#mbrName").val()
						, "userPassword":$("#newUserPassword1").val()
						, "userPhone"	:userPhone
						, "userTel"		:userTel
						, "userTelEx"	:userTelEx
		 				, "userMail"	:userMail
						, "customerId"	:customerIds[0]
						, "deptCode"	:$("#deptCode").val()
						, "userLevel"	:$("#userLevel").val()
						, "smsRecvFlag"	:($(":checkbox[name='smsRecvFlag']").is(":checked")?"Y":"N")
						, "mailRecvFlag":($(":checkbox[name='mailRecvFlag']").is(":checked")?"Y":"N")
						, "autoStringtext":$("#autoStringtext").val()
		 				, "autoStringtextHash":$('#autoStringtext').realperson('getHash')
					};
				return jsonData;
			} // end of function setJsonData()

		//-> Modal2 회원사 다이얼로그
			//customer 검색 팝업
			/* function openCustomerModal(){
				$("#modal-dialog2").modal();
				searchCustomer();
			}
			// 회원사 목록 조회
			function searchCustomer(){
				$.ajax({
					url : "customerSelect",
					dataType : "JSON",
					type : "POST",
					data : {
						"keyword" : $("#searchKeyword").val()
					},
					success : function(data) {
						var popList = data
						$("#modal-dialog2").modal();
						if(popList != ""){
							$("#popListTable > tr").remove();
							$.each(data,function(key,val){
								var Html="";
								Html="<tr><td class='tac'>"+val["customerId"]+"</td>";
								Html = Html + "<td class='tac'>"+val["customerName"]+"</td>";
								Html = Html + "<td class='tac'>"+val["userIdPattern"]+"</td>";
								Html = Html + "<td class='tac'><input type='button' value='' class='popCheckbtn' ";
								Html = Html + "onclick='selectCustomer(this, \""+val["customerId"]+"\"";
								Html = Html + ", \""+val["customerName"]+"\"";
								Html = Html + ", \""+val["userIdPattern"]+"\")' ></td>";
								Html = Html + "</tr>";

								$("#popListTable").append(Html);
							});
						}else{
							$("#popListTable > tr").remove();
							var Html="";
							Html="<tr><td class='tac' colspan='3'><span style='color:#bbb;'>"+"검색된 목록이 없습니다."+"</span></td></tr>";


							$("#popListTable").append(Html);
						}
						$('#popListTable tr:odd').addClass('even');
						$('#popListTable tr:even').addClass('odd');
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "error:" + error + "\n" + "message:" + request.responseText);
					}
				});
			} // end of function searchCustomer()

			function selectCustomer(e, cstmId, cstmNm, cstmPattern){
				$("#popListTable > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
				$("#h_popCustomerId").val(cstmId);
				$("#h_popCustomerName").val(cstmNm);
				$("#h_popUserIdPattern").val(cstmPattern);
			}

			// 회원사 적용
			function updateCustomer(){
				var customerId = $("#h_popCustomerId").val();
				var customerName = $("#h_popCustomerName").val();
				var userIdPattern = $("#h_popUserIdPattern").val();
				$("#h_popCustomerName").val();
				$("#customerId").val(customerId);
				$("#customerName").val(customerName);
				$("#userIdPattern").val(userIdPattern);
			} */
		// --< end of modal2 회원사 다이얼로그

		// --> Modal3 부서 다이얼로그
			function initialDepartment() {

				$("#table-list").jqGrid('clearGridData', true);
				$("#table-list").jqGrid({
					url: '${contextPath}/mbr/req/user/TreeAll',
					mtype: "POST",
					datatype: "json",
					postData: {	},
					colNames:['부서코드','상위부서코드', '부서명','level', 'isLeaf', 'isExpanded'],
					colModel:[
						{name:'deptCode', 	index:'deptCode', 	hidden:false, 	width:140, align:"center", key: true}
						,{name:'upCode', 	index:'upCode', 	hidden:true, 	width:100, align:"left"}
			 	   		,{name:'deptName', 	index:'deptName', 	hidden:false, 	width:500, align:"left"}
			 	   		,{name:'treeLevel', index:'treeLevel', 	hidden:true, 	width:220, align:"left"}
			 	   		,{name:'isLeaf', 	index:'isLeaf', 	hidden:true, 	width:220, align:"left"}
			 	   		,{name:'isExpanded',index:'isExpanded',	hidden:true, 	width:220, align:"left"}
					],
		 			//rowNum:10,
		 			//rowList:[5,10,15],
					rownumbers:false,
					loadonce:false,
					scrollrows:true,
					loadtext : "조회중 잠시만 기다려주세요.",
					//shrinkToFit:false,
// 					height: '100%', // 300, //$(".tbl_type01").height()-40,
// 					width : '100%',
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
// 						var list = $('#table-list').getRowData(rowid);
// 		                var treeLevel = list.realTreeLevel;

// 						if(treeLevel != 1){
// 							var code = list.deptCode;
// 							var name = list.deptName.split('>');
// 							name = name[name.length -1];
// 							$("#h_popDeptCode").val(code);
// 							$("#h_popDeptName").val(name);
// 							confirmBox(name+"를 적용하시겠습니까?", updateDepartment);
// 						}else{
// 							var code = list.deptCode;
// 							var name = list.deptName.split('>');
// 							name = name[name.length -1];
// 						}
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

			function searchDepartment() {
				$("#table-list").jqGrid('setGridParam', {
					url: '${contextPath}/mbr/mbrinfo/TreeAll',
					mtype: "POST",
					datatype: "json",
					postData: {
						searchKind : "dept_name",
						keyword : $("#searchKeywordDept").val()
					}
				}).trigger('reloadGrid');
			}
			function confirmDepartment() {
				var deptName = $("#h_popDeptName").val();
				if(deptName == null || deptName == "") {
					alertBox("선택된 부서가 없습니다.");
					return ;
				}
				confirmBox(deptName+"를 적용하시겠습니까?", updateDepartment);
			}
			// 부서 적용
			function updateDepartment() {
				var deptCode = $("#h_popDeptCode").val();
				var deptName = $("#h_popDeptName").val();
				//$("#h_popDeptName").val();
				$("#deptCode").val(deptCode);
				$("#deptName").val(deptName);
				$("#searchKeywordDept").val("");
				$("#modal-dialog3").modal("hide");
			}

			function openUserSearchModal(){
				$("#user-modal-approve-dialog").modal();
				if( $("#mbrId").val() != null && $("#mbrId").val() != '' ) {
					var mbrId = $("#mbrId").val();
					$("#approveUserId").val(mbrId);
					modalSearchUserList();
				}

			}

			// 사용자조회
			function modalSearchUserList(UserId){
				var searchKind = $("#approveSearchKind option:selected").val();
				var keyword = $("#approveUserId").val();
				if(UserId){
					searchKind = "userId";
					keyword = UserId;
				}
				$.ajax({
					url : "${contextPath}/mbr/req/user/searchUserInfo",
					dataType : "JSON",
					data : {
						"searchKind": searchKind
						, "keyword"	: keyword
					},
					success : function(req) {

						if(!UserId){
							if(req.data.length == 0){
								$("#popListApproveTable").hide();
								$("#popListApproveTable2").show();
							}else{
								$("#popListApproveTable").empty();

								$.each(req.data, function(key,val){
									$("#popListApproveTable").append(
									'<tr onclick="updateUserInfo(this, \''+val.userName+'\', \''+val.userId+'\', \''+val.deptCode+'\', \''+val.deptName+'\', \''+val.userLevel+'\', \''+val.userPhone+'\', \''+val.userMail+'\', \''+val.userTel+'\', \''+val.userTelEx+'\');">'
									+'<td class="tac">'+val.userId+'</td>'
									+'<td class="tac">'+val.userLevel+'</td>'
									+'<td class="tac">'+val.userName+'</td>'
									+'<td class="tac">'+val.deptName+'</td>'
									+'<tr/>'
								    );

								});
								$("#popListApproveTable").show();
								$("#popListApproveTable2").hide();
							}
							totalCnt = req.data.length;
							$("#totalApproveCnt").text("총 "+totalCnt+" 건");
						} else {
							updateUserInfo(this,req.data[0].userName,req.data[0].userId,req.data[0].deptCode,req.data[0].deptName,req.data[0].userLevel,req.data[0].userPhone,req.data[0].userMail,req.data[0].userTel,req.data[0].userTelEx);
						}
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

			// 회원정보 업데이트
			function updateUserInfo(e, userName, userId, deptCode, deptName, userLevel, userPhone, userMail, userTel, userTelEx) {
				var arrPhone = userPhone.split('-');
				var arrTel = userTel.split('-');
				var arrTelEx = userTelEx.split('-');

				$("#deptCode").val(deptCode);
				$("#deptName").val(deptName);
				$("#mbrId").val(userId);
				$("#mbrName").val(userName);
				$("#userLevel").val(userLevel).prop("selected", true).trigger('change');
				$("#mbrMail").val(userMail);
				$("#mailDomain").val("kepco.co.kr").prop("selected", true).trigger('change');
				$("#mbrPhone1").val(arrPhone[0]).prop("selected", true).trigger('change');
				$("#mbrPhone2").val(arrPhone[1]);
				$("#mbrPhone3").val(arrPhone[2]);
				$("#mbrTelEx1").val(arrTelEx[0]);
				$("#mbrTelEx2").val(arrTelEx[1]);
				$("#mbrTel1").val(arrTel[0]).prop("selected", true).trigger('change');
				$("#mbrTel2").val(arrTel[1]);
				$("#mbrTel3").val(arrTel[2]);

				$("#user-modal-approve-dialog").modal("hide");
			}
		</script>
	</body>
</html>
