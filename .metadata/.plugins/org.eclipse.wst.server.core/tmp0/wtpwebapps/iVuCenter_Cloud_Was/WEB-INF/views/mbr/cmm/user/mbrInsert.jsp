<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		<div id="header" class="header navbar navbar-default navbar-fixed-top">
			<div class="info">  
			<span> <img src="${apachePath}/resources/assets/img/df_user_icon.png"/> <b class="userName">어서오세요.</b> 반갑습니다.</span>
			</div>
			<div class="container-fluid">
				<div class="navbar-header">
					<a href="${wasPath}/mbr/" class="navbar-brand"><img src="${apachePath}/resources/assets/img/logo_cloud.png" class="logo" alt="iVuCenter Cloud"/> </a>
				</div>
			</div> 
		</div>
		<body class="boxed-layout"> 
		<div id="sidebar" class="sidebar">
			<!-- begin sidebar scrollbar -->
			<div   id='divSidebar' style='display:none'>
			</div>
			<!-- end sidebar scrollbar -->
		</div>
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
			<!-- begin page-header -->
			<h1 class="page-header"><span class="root"> <span class="home"></span> <span class="text">콘솔</span><span class="text arrow mint"><strong>회원가입</strong></span> </span></h1>
			<!-- end page-header -->
			
			<!-- begin page-body -->
			<div class="row mb50">
			<div class="memJoinStep">
				<img src="${apachePath}/resources/assets/img/memStep02.png"/> 
			</div>
			<p class="page_title">회원가입</p> 
		
			<div class="orderArea">
				<div class="tableF">
				<form name="mbrform"  id="mbrform" action="mbrInsert.do" method="post" >
				<input type="hidden" name="type" id="type" value="write" />
				<input type="hidden" name="idchk" id="idchk" value="F" />	
				<input type="hidden" name="customerId" id="customerId" value="" />	
				<table>
						<colgroup>
						<col width="190px">
						<col width="*">
						</colgroup>
						<tbody>
						<tr>
						  <td class="left">사번</td>
						  	<td>
						  		<input type="hidden" id="confirmFlag" value="">
								<input type="text" name="mbrId" id="mbrId"  class="form-control w493" onkeypress="if(event.keyCode==13)userIdValCheck();" placeholder="사번을 입력하세요" style="ime-mode:disabled;"/>
						 		<img src="${apachePath}/resources/assets/img/icon_check.png" onclick="userIdValCheck();" class="check input_search2">
						 	</td>
						 </tr>
						 
						 <tr>
						  	<td class="left">고객사</td>
						    <td>
					      		<input type="text" name="customerName" id="customerName" value="" class="form-control w493" placeholder="고객사를 선택하세요" style="ime-mode:active;" readonly="readonly"/> 
		                 		<img src="${apachePath}/resources/assets/img/icon_search.png" onclick="openCustomerModal();" class="input_search2"/> 
			              	</td>
						</tr>
						<tr>
						  <td class="left">사용자</td>
						  <td>
						  		<input type="text" name="mbrName" id="mbrName" class="form-control w493" placeholder="사용자를 입력하세요" style="ime-mode:active;"/>           		
						  </td>
						</tr>
						<tr>
						  <td class="left">사용자 핸드폰</td>
						  <td>
						 	 <div class="searchBoxArea w138"> 
						  		<div>	
						  			<label class="selectBoxDrop" for="mbrPhone1">선택</label>	                  		
			                  		<select name="mbrPhone1" id="mbrPhone1" class="search-sel">
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
			                  <span class="dsline"></span><input type="text" class="form-control w158" name="mbrPhone2" id="mbrPhone2" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
			                  <span class="dsline"></span><input type="text" class="form-control w158" name="mbrPhone3" id="mbrPhone3" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;"  style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
						  </td>
						</tr>
						<tr>
						  <td class="left">사용자 전화번호</td>
						  <td>
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
			                  <span class="dsline"></span><input type="text" class="form-control w158" name="mbrTel2" id="mbrTel2" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
			                  <span class="dsline"></span><input type="text" class="form-control w158" name="mbrTel3" id="mbrTel3" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
						  </td>
						</tr>
						<tr>
						  <td class="left">사용자 이메일</td>
						  <td>
							  <input type="text" name="mbrMail" id="mbrMail" class="form-control w158" style="ime-mode:disabled;" placeholder="이메일 입력"/>
							  <span class="golline">@</span>
							  <input type="text" class="form-control w138" placeholder="직접입력" id="customAddr">
							  <div class="searchBoxArea w158 ml10"> 
						  		<div> 
						  			<label class="selectBoxDrop" for="mbrTel1">--직접입력--</label>
									  <select class="search-sel" id="mailDomain" onchange="setCustomAddr();">							  
									  	<option value="customAddr">--직접입력--</option>					  
									  	<c:forEach items="${getEmailCode}" var="getEmailCode" varStatus="status" >
									  	<option value="${getEmailCode.codeName}">${getEmailCode.codeName}</option>		
									  	</c:forEach>
									  </select>
								 </div>
							 </div>
						  </td> 
						</tr>
						<tr>
						  <td class="left-t">정보수신여부</td>
						  <td>
						  	<div class="col-md-12 pl0 pt5">
							  	<label><input type="radio"  class="va-tb" id="recvFlag" name="recvFlag" value="Y" checked /> 수신</label>
							  	
							  	<label><input type="radio"  class="va-tb ml100" id="recvFlag" name="recvFlag" value="N" /> 미수신</label>
						  	</div>  
							<div class="col-md-12 pl0 pt10" id='divRecvFlag'>
								<div class="col-md-2 pl0">
									<label><input type="checkbox" name="smsRecvFlag" value="Y" checked="checked"/> SMS수신</label>
								</div>								
								<div class="col-md-2 pl0">
									<label><input type="checkbox" name="nhwithRecvFlag" value="Y" checked="checked" /> NHwith수신</label>
								</div>
							</div>	
							<p class="fcsb f16 mt10"><img src="${apachePath}/resources/assets/img/icon_tpoint.png"> 클라우드 주요 서비스에 대한 알림 수신 동의입니다</p>						
						  </td>
						</tr>
						<tr>
						  <td class="left-t pt20">자동가입방지</td>
						  <td colspan='3'  class="pt20">
								<input type="text" class="form-control w228 mt10" id="autoStringtext" name="autoStringtext" style="ime-mode:disabled;"/>
								<img src="${apachePath}/resources/assets/img/icon_reload.png" onclick="catchaRefresh();" class="reload mt10"> 
						  </td>
						</tr>
					</tbody>
			</table>
			</form>
			</div>
				</div>
		    	</div>
			    <!-- end section-container -->	   
				<!-- begin button----------->
				<div class="btn_area">	
					<a type=button id="jquerybuttonok" name="jquerybuttonok"  class="bt_w168 bt_memjoin" onclick="valchk();">가입</a>
					<a type=button class="bt_w168 bt_cancle ml20" onclick="moveLoginPage()">취소</a>  
				</div> 
				<!-- end button-----------> 
				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->
			</div>
			<!-- end page-body -->
				<!-- #modal-dialog 가상서버검색-->
                <div class="modal fade" id="modal-dialog2">
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
												  	<button type="button" class="btn_search2" onclick="customerSearch();"><span></span></button>
												</div>
											</div>
										<!-- search end -->
	
										   
										   <div>
										   		<input type="hidden" value="" id="h_popCustomerId">
	                           					<input type="hidden" value="" id="h_popCustomerName">
										   	<table class="table table-bordered table-hover table-striped table-td-valign-middle">
											 <colgroup>
											 <col width="40%">
											 <col width="40%">
											 <col width="20%">
											 </colgroup>
											 <thead>
											 <tr class="skyblue">
												 <th class="tac">고객사 아이디</th>
												<th class="tac">고객사 이름</th>
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
                            </div>
						<!-- #modal-dialog  가상서버 검색//-->
	</div>
	<!-- end page container -->
	
  
	
</body>
<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/bootstrap.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/respond.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/metisMenu.min.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.dataTables.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/dataTables.bootstrap.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/dataTables.tableTools.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/bootstrapValidator.min.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.placeholder.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.MultiFile.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.form.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.modal.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/set/core.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/set/modal.js"></script>
    
	<script src="${apachePath}/resources/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
    <script src="${apachePath}/resources/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
    
	<script src="${apachePath}/resources/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
	<script src="${apachePath}/resources/assets/plugins/jquery-cookie/jquery.cookie.js"></script>

	<script src="${apachePath}/resources/assets/plugins/bootstrap-calendar/js/bootstrap_calendar.min.js"></script>
<%-- 	<script src="${apachePath}/resources/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script> --%>
	<!-- ================== END BASE JS ================== -->
	
	<!-- ================== BEGIN PAGE LEVEL JS ================== -->
    <script src="${apachePath}/resources/assets/js/page-ui-modal-notification.demo.min.js"></script>
    <script src="${apachePath}/resources/assets/js/page-form-plugins.demo.js"></script>
    <script src="${apachePath}/resources/assets/js/demo.min.js"></script>
    <script src="${apachePath}/resources/assets/js/apps.js"></script>
	<!-- ================== END PAGE LEVEL JS ================== -->
    
 	<!-- captcha -->
	<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.plugin.js"></script>
	<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.realperson.js"></script>
	
	
	
	
	<script type="text/javascript">
	<c:if test="${not empty errortext}">//alert("회원사 아이디 또는 이름을 사용하실수 없습니다.");</c:if>
	$(document).ready(function(){		
		$("input,textarea").placeholder();
		App.init();
	 	
		
		$(":radio[name='recvFlag']").bind('change', function(){
			if($(":radio[name='recvFlag']:checked").val() == "Y"){
				$("#divRecvFlag").show();
				$(":checkbox[name='smsRecvFlag']").attr("checked", true);
				$(":checkbox[name='nhwithRecvFlag']").attr("checked", true);
			}else{
				$("#divRecvFlag").hide();
				alertBox3("진행사항에 대한 알림을 수신할 수 없습니다.");
			}
		});
		
		$(":checkbox[name='smsRecvFlag']").bind('change', function(){
			if($(":checkbox[name='smsRecvFlag']").is(":checked") == false
					&& $(":checkbox[name='nhwithRecvFlag']").is(":checked") == false){
				alertBox3("진행사항에 대한 알림을 수신할 수 없습니다.");
			}
		});

		$(":checkbox[name='nhwithRecvFlag']").bind('change', function(){
			if($(":checkbox[name='smsRecvFlag']").is(":checked") == false
					&& $(":checkbox[name='nhwithRecvFlag']").is(":checked") == false){
				alertBox3("진행사항에 대한 알림을 수신할 수 없습니다.");
			}
		});
		
	 	// 팝업 중복확인 후 추가입력 방지
	 	/* 
	 	$("#_mbrId").focus(function(){
		 	$("#enableId").css("display", "none");
			$("#unableId").css("display", "block");
	 	});
	 	
	 	$("#_mbrId").keypress(function(event){
	 		$("#checkMsg").text("");
	 		//특수문자 & 공백 입력 제한
	 		if(!(event.KeyCode>=37 && event.keyCode<=40)){
	 			var inputVal = $(this).val();
	 			$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
	 		}
	 	});
	 	 */
	 	 
	 	$("#mbrId").keypress(function(){
	 		$("#confirmFlag").val("N"); 
	 	});

	 	$("#autoStringtext").keypress(function(){
	 		$("#autoStringtext").val($("#autoStringtext").val().toUpperCase()); 
	 	});

	 	$("#autoStringtext").blur(function(){
	 		$("#autoStringtext").val($("#autoStringtext").val().toUpperCase()); 
	 	});
	 	 
	 	
		$('#autoStringtext').realperson({
			length:6
			, chars: $.realperson.alphabetic
			, regenerate : ""
		});
	 	
		// select box text 설정
		$(".search-sel").change(function() {
			$(this).siblings(".selectBoxDrop").text($(this).children('option:selected').text());
		});  
		 /*
			$("#mbrPhone1").keyup(function(){				
				$("#mbrPhone1").val( $("#mbrPhone1").val().replace(/[^0-9]/gi,''))
			});
			$("#mbrPhone2").keyup(function(){				
				$("#mbrPhone2").val( $("#mbrPhone2").val().replace(/[^0-9]/gi,''))
			});
			$("#mbrPhone3").keyup(function(){				
				$("#mbrPhone3").val( $("#mbrPhone3").val().replace(/[^0-9]/gi,''))
			});
			*/
			//회원사 ID 중복체크
			/*
			$("#customerId").keyup(function(){
				//alert("키보드입력");
				if($("#customerId").val()!=""){
					$.post("<c:url value="/customerIDajaxcheck"/>",
							{"customerId":$("#customerId").val()},
							function(data){
								//alert(data);
								if(data == "true"){
									//alert(1);
									//alert("사용 가능한 ID ID입니다.");
									$("#customerIdchktxt").text("사용 가능한 ID입니다.");								
								}else{
									//alert(2);
									//alert("사용중인 ID입니다.");
									$("#customerIdchktxt").text("이미 사용중인 ID입니다.");
								}
							});
				}else{
					$("#customerIdchktxt").text("");
				}
				
				
			});
			*/
			//회원사 이름 중복체크
			/*
			$("#customerName").keyup(function(){
				//alert("키보드입력");
				if($("#customerName").val()!=""){
					$.post("<c:url value="/customerNameajaxcheck"/>",
							{"customerName":$("#customerName").val()},
							function(data){
								//alert(data);
								if(data == "true"){
									//alert(1);
									//alert("사용 가능한 ID ID입니다.");
									$("#customerNamechktxt").text("사용 가능한 이름입니다.");								
								}else{
									//alert(2);
									//alert("사용중인 ID입니다.");
									$("#customerNamechktxt").text("이미 사용중인 이름입니다.");
								}
							});
				}else{
					$("#customerNamechktxt").text("");
				}
				
				
			});
			*/
	});
	
	
	function test(){
		var text = "테스트여";
		
// 		alertBox(text, k);
// 		confirmBox2(text, functionName, object);
		successBox(text);
// 		warningBox(text);
// 		infoBox(text);
	}
	
	function reload(){
		location.reload();
	}
	
	function reload2(){
		
		$(".realperson-regen").trigger('click');
	}
	
	
	// 팝업메시지 세팅	
	function alertModal1(txt){
		$("#confirmMsg").text(txt);
		$("#modal-dialog3").modal();
	}
	

	
	function valchk(){
		if($("#mbrId").val()==""){
			alertBox3("사번를 입력하세요");
			$("#mbrId").focus();
			return false;
		} 
		
		if($("#confirmFlag").val()=="N"){
			alertBox3("사번 중복확인을 하세요");
			$("#mbrId").focus();
			return false;
		}
		
		if($("#customerId").val()==""){
			alertBox3("회원사를 선택하세요");
			$("#customerName").focus();
			return false;
		}
		if($("#mbrName").val()==""){
			alertBox3("사용자 이름을 입력하세요");
			$("#mbrName").focus();
			return false;
		}			
		if($("#mbrPhone1").val()==""){
			alertBox3("핸드폰번호를 입력하세요");
			$("#mbrPhone1").focus();
			return false;
		}
		if($("#mbrPhone2").val()==""){
			alertBox3("핸드폰번호를 입력하세요");
			$("#mbrPhone2").focus();
			return false;
		}
		if($("#mbrPhone3").val()==""){
			alertBox3("핸드폰번호를 입력하세요");
			$("#mbrPhone3").focus();
			return false;
		}

		if($("#mbrMail").val()==""){
			alertBox3("이메일을 입력하세요");
			$("#mbrMail").focus();
			return false;
		}
		
		if($("#mailDomain > option:selected").val()==""){
			alertBox3("이메일 도메인을 선택하세요");
			return false;
		}
		
		if($("#mailDomain > option:selected").val()=="customAddr" && $("#customAddr").val()==""){
			alertBox3("이메일을 입력하세요");
			return false;
		}
		
		if($("#mbrMail").val()!="" && $("#mailDomain > option:selected").val()=="customAddr" && $("#customAddr").val()!=""){
			var mail = $("#mbrMail").val()+"@"+ $("#customAddr").val();
			
			var Ret = mail;
		   	if( Ret != "" && (Ret.indexOf("@")== -1 || Ret.indexOf(".")== -1)) {
		   		alertBox3("이메일 형식으로만 입력이 <br>가능합니다.");    
				return false;
		    }
		}
		
		if($("#mbrMail").val()!="" && $("#mailDomain > option:selected").val()!="customAddr" && $("#mailDomain > option:selected").val()!=""){
			var mail = $("#mbrMail").val()+"@"+ $("#mailDomain > option:selected").val();
			
			var Ret = mail;
		   	if( Ret != "" && (Ret.indexOf("@")== -1 || Ret.indexOf(".")== -1)) {
		   		alertBox3("이메일 형식으로만 입력이 <br>가능합니다.");    
				return false;
		    }
		}
		
		if($("#autoStringtext").val()==""){
			alertBox3("자동가입방지문자를 입력하세요");
			$("#autoStringtext").focus();
			return false;
		}

		
		confirmBox("가입신청을 하시겠습니까?", mbrInsert); 
		
// 		return true;
			
	}
		
		//숫자만 입력
		function number_only(id){
			//alert(id);
			$(id).val( $(id).val().replace(/[^0-9]/gi,''));
			if( !( event.keyCode>=48 && event.keyCode<=57 ) ){
				event.returnValue=false;
		    }
		}
		
		
		
		// 사용자 가입신청
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
						alertBox("가입신청이 완료되었습니다. <br>입력하신 이메일로 임시비밀번호가 <br>발송됩니다.", moveCompPage);
// 						alertBox("가입신청이 완료되었습니다.", showPw);
					}else if(result==2){
						warningBox("사번을 사용하실수 없습니다.");
						//moveDetailPage();
					}else if(result==3){
						alertBox("자동가입방지 문자 입력이 <br>잘못되었습니다.", reload2);
						//moveDetailPage();
					}else{
						warningBox("fail!");								
						moveCompPage();
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error, logout);
				}
			});
		}
		// json 데이터 세팅
		function setJsonData(){	
			var userPhone = $("#mbrPhone1 > option:selected").val() +"-"+ $("#mbrPhone2").val() +"-"+ $("#mbrPhone3").val();
			var userTel = $("#mbrTel1").val() +"-"+ $("#mbrTel2").val() +"-"+ $("#mbrTel3").val();
			
			var mailValue = $("#mailDomain > option:selected").val();
			var mailDomain="";
			
			// 메일 도메인 
			if(mailValue=="customAddr"){
				mailDomain = $("#customAddr").val();
			}else{
				mailDomain = $("#mailDomain > option:selected").val();
			}
			
			var jsonData = {
					"userId" : $("#mbrId").val()
					, "userName":$("#mbrName").val()
					, "userPhone":userPhone
					, "userTel":userTel
	 				, "userMail":$("#mbrMail").val()
	 				, "mailDomain": mailDomain
	 				, "autoStringtext":$("#autoStringtext").val()
	 				, "autoStringtextHash":$('#autoStringtext').realperson('getHash')
					, "customerId":$("#customerId").val()
					, "smsRecvFlag": ($(":checkbox[name='smsRecvFlag']").is(":checked")?"Y":"N")					
					, "nhwithRecvFlag": ($(":checkbox[name='nhwithRecvFlag']").is(":checked")?"Y":"N")
					};
			return jsonData;
		}
		
		// 이메일 도메인 직접입력
		function setCustomAddr(){
			var mailValue = $("#mailDomain > option:selected").val();
			if(mailValue=="customAddr"){
				$("#customAddr").attr("disabled", false);
			}else{
				$("#customAddr").attr("disabled", true);
				$("#customAddr").val("");
			}
		}
		
		
		 // 회원사 목록 조회
		function customerSearch(){
// 			if($("#customerName").val()==""){
// 				alertBox("회원사이름을 입력하세요.");
// 				$("#customerName").focus();
// 				return false;
// 			}
			
			$.ajax({
				url : "customerSelect",
				dataType : "JSON",
				type : "POST",
				data : {
//					"keyword" : $("#customerName").val()
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
// 							Html = Html + "<td class='tac'><input type='button' value='' class='popCheckbtn' onclick='updateCustomer(\""+val["customerId"]+"\", \""+val["customerName"]+"\")'></td>";
							Html = Html + "<td class='tac'><input type='button' value='' class='popCheckbtn' onclick='selectCustomer(this, \""+val["customerId"]+"\", \""+val["customerName"]+"\")' ></td>";
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
		}
		
		 function selectCustomer(e, cstmId, cstmNm){
			$("#popListTable > tr").find("input").removeClass("active");
			$(e).toggleClass("active");
			$("#h_popCustomerId").val(cstmId); 
			$("#h_popCustomerName").val(cstmNm); 	
		 }
		 
		 
		 // 회원사 적용
		function updateCustomer(){
			var customerId = $("#h_popCustomerId").val(); 
			var customerName = $("#h_popCustomerName").val();
			$("#h_popCustomerName").val(); 
			$("#customerId").val(customerId);
			$("#customerName").val(customerName);
		}
		
//---> Modal popup start
		
		//modal팝업 open
// 		function openModal(){
// 			$("#modal-dialog").modal();
// 		}
		
		//customer 검색 팝업
		 
		function openCustomerModal(){
			$("#modal-dialog2").modal();
			customerSearch();
		}
		
		 
		//사용자 아이디 중복체크
		/* 
		function userIdCheck(){
			
			if($("#_mbrId").val()=="" || $("#_mbrId").val()==null){
				alert("신청할 아이디를 입력하세요.");
				return;
			}
			
			var mbrId = $("#_mbrId").val();

			$.ajax({
				url : "mbrIdcheck",
				dataType : "JSON",
	 			type : "GET",
				data : {
					"userId" : mbrId
				},
				success : function(data) {
					var result = data;
					
						$("#checkMsg").text(result.idchktext);
					if(result.chkval==0){
						$("#checkMsg").css("color","blue");
						$("#enableId").css("display", "block");
						$("#unableId").css("display", "none");
					}else{
						$("#checkMsg").css("color","#ff0000");
						$("#enableId").css("display", "none");
						$("#unableId").css("display", "block");
					}
					
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
			
		}
		 */
		 
		 //입력값체크
		 function userIdValCheck(){
			 
			 if($("#mbrId").val()==""){
					alertBox3("사번을 입력하세요.");
					$("#mbrId").focus();
					return false;
			}else{
				userIdCheck();
			} 
		 }
		 //사용자 아이디 중복 체크
		 function userIdCheck(){
				
				var mbrId = $("#mbrId").val();

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
						
// 						alertModal(result.idchktext);
						alertBox3(result.idchktext);
						
// 						$("#modal-dialog3").modal();
// 						$("#confirmMsg").text(result.idchktext);
						
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
				
			}
		 
		// 중복체크완료 아이디 적용
		function setId(){
			var mbrId = $("#_mbrId").val();
			$("#mbrId").val(mbrId);	
			
			initModal();
			$("#modal-dialog").modal("hide");
		}	
		
		// 팝업 초기화
		function initModal(){
			$("#_mbrId").val("");
			$("#checkMsg").text("");
			$("#enableId").css("display", "none");
			$("#unableId").css("display", "block");
		}
		//<--- Modal popup end
		
		//로그인페이지로 이동
		function moveLoginPage(){
			location.href="${wasPath}/mbr/";
		}
		//완료페이지 이동
		function moveCompPage() {
			location.href="${wasPath}/mbr/cmm/user/mbrCompPage";
		}
		
		function showPw(){
			var userId = $("#mbrId").val();
			$.ajax({
				url : "getTempPw",
// 				dataType : "JSON",
	 			type : "POST",
				data : {
					"userId" : $("#mbrId").val()
				},
				success : function(data) {
					var tempPw = data;
					window.open("${contextPath}/getTempPw.jsp?userId="+userId+"&tempPw="+tempPw,"_blank","");
					moveLoginPage();
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error + "\n" + "message:" + request.responseText);
				}
			});
		}

		
		// 팝업메시지 세팅	
		function alertModal(txt, fn){
			$("#confirmMsg").text(txt);
			$("#setBtn").html("");
			
			if(fn==""||fn=="undefined"){
				var vHtml = "";
				vHtml = '<a type="button" class="btn width-100 btn-grey" data-dismiss="modal">닫기</a>';
				$("#setBtn").html(vHtml);
			}else{
				var vHtml = "";
				vHtml = '<a type="button" class="btn width-100 btn-grey" data-dismiss="modal" onclick="'+fn+'">닫기</a>';
				$("#setBtn").html(vHtml);
			}
			
			$("#message-modal-dialog").modal({backdrop:'static', keyboard:false});
		}		
		
		
		function catchaRefresh(){
			$(".realperson-text").trigger("click");
		}
		
		$("#autoStringtext").on('keyup',function(e){
			var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
			if(pattern.test(this.value)){
				$(this).val(this.value.replace(pattern, ''));
			}
			
 			var pattern2 = /[\{\}\[\]\/?.,;:|\)*~`!^+<>@\#$%&=\\\(\'\"]/gi;
			if(pattern2.test(this.value)){
				$(this).val(this.value.replace(pattern2, ''));
			}
			 
			
			$(this).val(this.value.toUpperCase()); 
		});
		
		</script>
</html>
