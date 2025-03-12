<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

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
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
		
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">

			<p class="page_title">내정보 수정
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/cmm/user/userInfo">내정보 </a> <span class="arrow_ab"> &#8227; </span> <b><a href="${wasPath}/mbr/cmm/user/userInfoWrite?userId=${userId}">내정보 수정</a> </b>
			    </span>
			</p>

			<!-- begin page-body -->
			<div class="row p20 bgwh br10">
	
				<div class="userInfoArea">
				<!-- 내 정보 수정하기 -->   
					<div class="tableI">
						<form name="mbrform"  id="mbrform" action="mbrInsert.do" method="post" >
						<input type="hidden" id="type" value="write" />
						<input type="hidden" id="idchk" value="F" />	
						<input type="hidden" id="customerId" value="" />
						<input type="hidden" id="deptCode" value="" />
						<table>
								<colgroup>
								<col width="180px">
								<col width="70%">
								</colgroup>
							<tbody>
							 <tr>
							  	<td class="left">회원사</td>
							    <td class="cmpName" id="customerName"></td>  
							</tr>
							<tr>
							  <td class="left">사용자</td>
							  <td class="myName" id="userName"></td>
							</tr>
							
							<tr>
							  <td class="left">소속조직(부서)</td>
							  <td><%-- <input type="text" id="deptName" value="" class="form-control w90 dpin" placeholder="부서를 선택하세요" style="ime-mode:active;" readonly="readonly"/> 
	                 				<img src="${apachePath}/resources/assets/img/icon_search.png" class="mt-4 ml-6" id="openDepartment"/> --%>
	                 				
	                 				<div class="search-660">
	                                <input type="text" class="input-kepco-l" placeholder="부서를 선택하세요." id="deptName" style="ime-mode:active;" readonly="readonly"/>
	                                <button type="button" class="kepco-ser-icon-l"  id="openDepartment"></button>
	                                </div>
	                 		  </td>
							</tr>
							<tr>
							  <td class="left">직급 </td>
							  <td>
							  		<div class="searchBoxArea w138"> 
							  			<label class="selectBoxDrop" for="userLevel">선택</label>	                  		
				                  		<select id="userLevel" class="search-sel">	
				                  			<c:forEach items="${getPositionCode}" var="getPositionCode" varStatus="status" >
										  		<option value="${getPositionCode.codeName}">${getPositionCode.codeName}</option>		
										  	</c:forEach>
				                  		</select>
				                  	</div> 
				                  	
				                  	
				                  				                    
							  </td>
							</tr>
							<!-- // new 
							<tr>
							<td class="left"> 새로운 직급 </td>
							<td> 
							    <div class="select-200">
							    <div class="select-kepco">
							    <button class="kep-label" value="searchAll">선택 </button>
							    <ul class="optionList">
							      <li class="optionItem">선택1</li>
							      <li class="optionItem">선택2</li>
							      <li class="optionItem">선택3</li>
							    </ul>
							    </div>
							    </div>
							</td>
							</tr>
							<!--  new// -->
							
							<tr>
							  <td class="left">기존 비밀번호</td>
							  <td colspan="3"><input type="password" placeholder="비밀번호 변경시에만 입력하세요" class="form-control w493" id="userPassword"></td>
							</tr>
							<tr>
							  <td class="left">새 비밀번호</td>
							  <td colspan="3">
							  	<span data-toggle="tooltip" data-html="true" title="<div class='tal'>8글자 이상 가능 <br/>3연속 연속된 영문 및 숫자(abc, cba, 123) 불가 <br/>동일한 숫자, 문자를 3번 이상 불가 <br/>영문, 숫자, 특수문자 1개 이상 포함</div>">
							  	<input type="password" placeholder="비밀번호 변경시에만 입력하세요" class="form-control w493" id="newuserPassword1">
							  	</span>
							  </td>
							</tr>
							<tr>
							  <td class="left">새 비밀번호 확인</td>
							  <td colspan="3"><input type="password" placeholder="비밀번호 변경시에만 입력하세요" class="form-control w493" id="newuserPassword2"></td>
							</tr>
							<tr>
							  <td class="left">전화번호(사선)</td>
							  <td>
							  	<div class="searchBoxArea w138">
							  		<div>
							  			<label class="selectBoxDrop" for="mbrTel1">선택</label>
				                  		<select id="mbrTelEx1" class="search-sel">
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
				                  <span class="dsline"></span><input type="text" class="form-control w158" name="numberOnly" id="mbrTelEx2" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>				                  
							  </td>
							</tr>
							<tr>
							<td class="left">전화번호(국선)</td>
							  <td>
							  	<div class="searchBoxArea w138">
							  		<div>
							  			<label class="selectBoxDrop" for="mbrTel1" >선택</label>
				                  		<select id="mbrTel1"  class="search-sel">
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
				                  <span class="dsline"></span><input type="text" class="form-control w158" name="numberOnly" id="mbrTel2" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
				                  <span class="dsline"></span><input type="text" class="form-control w158" name="numberOnly" id="mbrTel3" style="ime-mode:disabled;" maxlength="4" placeholder="번호 입력"/>
							  </td>
							</tr>
							<tr>
							  <td class="left">이메일</td>
							  <td>
								  <input type="text" id="userMail" class="form-control w158" style="ime-mode:disabled;" placeholder="이메일 입력"/>
								  <span class="golline">@</span>
								  <input type="text" class="form-control w138" disabled="disabled" placeholder="직접입력" id="customDomain">
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
							  </td> 
							</tr>
							<tr>
							  <td class="left">SMS 수신여부</td>
							  <td class="pt10 pb10">
								<div class="col-md-12 pl0">
									<div class="col-md-1 pl0">
										<label><input type="radio" name="smsRecvFlag" value="Y" /> 수신</label>
									</div>								
									<div class="col-md-1 pl0">
										<label><input type="radio" name="smsRecvFlag" value="N" /> 미수신</label>
									</div>
								</div>
							  </td>
							
							</tr>
							<tr>
							   <td class="left">메일 수신여부</td>
							  <td class="pt10 pb10">
							  	<div class="col-md-12 pl0">
									<div class="col-md-1 pl0">
										<label><input type="radio" name="mailRecvFlag" value="Y" /> 수신</label>
									</div>								
									<div class="col-md-1 pl0">
										<label><input type="radio" name="mailRecvFlag" value="N" /> 미수신</label>
									</div>
								</div>					
							  </td>
							</tr>
							</tbody>
						</table>
						</form>
					</div>
				
				<div class="btn_area">	
					<a type='button' id="jquerybuttonok" class="btn_navy">저장</a>
					<a type='button' class="btn_lgrey ml10" onclick="moveViewPage2()">취소</a>  
				</div>
			</div> 
				
				
		<!-- //내 정보 수정하기 -->   
		</div>
		<!-- begin #footer -->
		<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #footer -->
			
		</div>
		<!-- end page-body -->
			
		<!-- #modal-dialog -->
		<div class="modal fade" id="modal-dialog-profileImg">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title">프로필사진 수정</h4>
                    </div>
                    <div class="modal-body">
                       <div class="profileImgBox">
                       		<div class="thumbNailImg" id="image_preview">
                       		<c:if test="${file.size() eq 0}">
								<img src="${apachePath}/resources/assets/img/userInfo_mypic_noImage.png" alt="사진"/>
								<input type="hidden" id="h_fileId" value="">
							</c:if>
							<c:if test="${file.size() ne 0}">
								<img name="popPic" src="${wasPath}/mbr/cmm/file/download/${file.get(0).fileId}" alt="사진" style="width: 80px; heigth: 80px;"/>
								<input type="hidden" id="h_fileId" value="${file.get(0).fileId}">
							</c:if>
                       		</div>
                       		<div class="box">
                       			<strong>프로필 사진</strong>
                       			<a type="button"><i class="ico_search_green"></i><span>사진등록</span></a>
                       			<a type='button' onclick="fileRemove();"><i class="ico_del_orange"></i><span>사진삭제</span></a>
								<form id="file-form" name="file-form" action="${wasPath}/mbr/cmm/file/deleteInsert" method="post"  enctype="multipart/form-data" target="_iframeFile">
									<input class='btn_picSearch' type='file' id='files' name='files' onclick="delSelectedFile();"/>
							       	<input class='btn_picSearch' type='hidden' id='fileNm' name='fileNm'/>
							       	<input type='hidden' id='programName' name='programName' value='cmm_user'>
									<input type='hidden' id='programSeq' name='programSeq' value='${userId}'> 
								    <div id="files-list" style="display:none;"></div>
							    </form>
							    <div style='display:none;'><iframe id='_iframeFile' name='_iframeFile'></iframe></div>
                       		</div>
                       		<p class="noticeCmt"><span class="txtBlue">146px X 146px</span> 사이즈에 최적화 되어 있습니다.<br>등록할 이미지 사이즈가 다른 경우 다르게 보일 수 있습니다.<br><span class="txtRed">등록할 이미지는 10MB을 초과할 수 없습니다.</span></p>
                       </div>
                       
                    </div>
                   	<div class="modal-footer tac">
<!-- 						<a type='button' class="lbtn" data-dismiss="modal" onclick="actFileUpload();">확인</a>	  -->
						<a type='button' class="lbtn" data-dismiss="modal" onclick="closeModal();">확인</a>	 
                   		<a type='button' class="rbtn" data-dismiss="modal" onclick="">취소</a>
               		</div>
            	</div>
        	</div>
        </div>
		<!-- #modal-dialog -->
		
			
			<!-- #modal-dialog -->
				<div class="modal fade" id="message-modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">알림</h4>
	                       </div>
	                       <div class="modal-body">
	                           <h5 id="confirmMsg"></h5>
	                        </div>
	                       	<div class="modal-footer tac" id="setBtn">
<!-- 	                       		<a type='button' class="btn width-100 btn-default" data-dismiss="modal" onclick="">닫기</a> -->
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
			
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
						<div class="" style="text-align: center; display:inline-block;"> 
							<div class="col-md-8"> 
								<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="searchKeywordDept" data-original-title="" title="">
							</div>
						  	<button type="button" class="btn_search2" id="searchDepartment"><span></span></button>
						</div>
					</div>
				 	<!-- search end -->							   
				   <div class="col-md-12">
			   		<input type="hidden" value="" id="h_popDeptCode">
     				<input type="hidden" value="" id="h_popDeptName">
     				<div class="table_wrap ">
						<table class="tbl_type01" id="table-list" summary="" cellpadding="0" cellspacing="0"></table>
					</div>
				   	<%-- <table class="table table-bordered table-hover table-striped table-td-valign-middle">
						 <colgroup>
						 <col width="40%">
						 <col width="40%">
						 <col width="20%">
						 </colgroup>
						 <thead>
						 <tr class="skyblue">
							 <th class="tac">부서 아이디</th>
							<th class="tac">부서 이름</th>
							<th class="tac">적용</th>
						 </tr>
						 </thead>
						 <tbody id="popDeptListTable">
						 
						 </tbody>
				 	</table> --%>
				   </div>
               	</div>
				<div class="clear"></div>
				<div class="modal-footer tac">
             			<a type=button class="lbtn" data-dismiss="modal" onclick="confirmDepartment();">확인</a>
             			<a type=button class="rbtn" data-dismiss="modal">취소</a> 
                 	</div>
              </div>
           </div>
        </div>
		<!-- #modal-dialog 부서  검색//-->
			
			
			
			


	</div>
	<!-- end #content -->

<!-- end page container -->

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
<script type='text/javascript' src="${apachePath}\resources\assets\plugins\jqGrid\i18n\grid.locale-kr.js"></script>
<script type='text/javascript' src="${apachePath}\resources\assets\plugins\jqGrid\jquery.jqgrid.min.js"></script>
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
			 
		$("#jquerybuttonok").click(function() {
			confirmBox("저장하시겠습니까?", userInfoUpdate);			
		});
		
		/* $('#files').MultiFile({
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
		$("#image").on("change", function(){
			var file = $("#image").prop("files")[0];
			var blobURL = window.URL.createObjectURL(file);
			$("#image_preview img").attr("src",blobURL);
			$("#image_preview").slideDown();
			$(this).slideUp();
		}); */
		
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
	}); // end of document
	
	function focusField(id) {
		$(id).focus();
	}
	
	// 상세조회
	function userInfoDetail(){
		
		$.ajax({
			url : "${wasPath}/mbr/cmm/user/userInfoDetail",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : "${userId}"
			},
			success : function(data) {
				setData(data);
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
	
	// 데이터 출력
	function setData(data){
		
		$("#userId").text(data.userId);
		$("#userName").text(data.userName);
		$("#customerId").val(data.customerId);
		$("#customerName").text(data.customerName);		
		$("#deptCode").val(data.deptCode);
		$("#deptName").val(data.deptName);
		
		$("#userLevel option[value='"+data.userLevel+"']").attr("selected", "selected");		
		if( $("#userLevel > option:selected").val() != "") {
			$("#userLevel").siblings(".selectBoxDrop").text($("#userLevel").children('option:selected').text());	
		} else {
			$("#userLevel").siblings(".selectBoxDrop").text("선택");
		}
		
		var userPhone = data.userPhone.split('-');
		$("#mbrPhone1 option[value='"+userPhone[0]+"']").attr("selected", "selected");
		if( $("#mbrPhone1 > option:selected").val()!=""){
			$("#mbrPhone1").siblings(".selectBoxDrop").text($("#mbrPhone1").children('option:selected').text());
		}else{
			$("#mbrPhone1").siblings(".selectBoxDrop").text("선택");
		}
		$("#mbrPhone2").val(userPhone[1]);
		$("#mbrPhone3").val(userPhone[2]);
				
		var userTel = data.userTel.split('-');
		$("#mbrTel1 option[value='"+userTel[0]+"']").attr("selected", "selected");
		if($("#mbrTel1 > option:selected")!=""){
			$("#mbrTel1").siblings(".selectBoxDrop").text($("#mbrTel1").children('option:selected').text());
		}else{
			$("#mbrTel1").siblings(".selectBoxDrop").text("선택");
		}
		$("#mbrTel2").val(userTel[1]);
		$("#mbrTel3").val(userTel[2]);
		
		var userTelEx = data.userTelEx.split('-');
		$("#mbrTelEx1 option[value='"+userTelEx[0]+"']").attr("selected", "selected");
		if($("#mbrTelEx1 > option:selected")!=""){
			$("#mbrTelEx1").siblings(".selectBoxDrop").text($("#mbrTelEx1").children('option:selected').text());
		}else{
			$("#mbrTelEx1").siblings(".selectBoxDrop").text("선택");
		}
		$("#mbrTelEx2").val(userTelEx[1]);		
		
		$("input[name='smsRecvFlag']:input[value='"+data.smsRecvFlag+"']").attr("checked", true)
		$("input[name='mailRecvFlag']:input[value='"+data.mailRecvFlag+"']").attr("checked", true)
				
		var addrArr = data.userMail.split("@");
		var preAddr = addrArr[0]; 	
		var postAddr = addrArr[1];
		
		$("#userMail").val(preAddr);
		$("#mailDomain").val(postAddr);
		
		$("#mailDomain option[value='"+postAddr+"']").attr("selected", "selected");
		
		if($("#mailDomain > option:selected").text()!=""){
			$("#mailDomain").siblings(".selectBoxDrop").text($("#mailDomain").children('option:selected').text());
		}else if($("#mailDomain > option:selected").text()==""){
			$("#mailDomain option[value='customAddr']").attr("selected", "selected");
			$("#mailDomain").siblings(".selectBoxDrop").text($("#mailDomain").children('option:selected').text());
			$("#customDomain").attr("disabled", false);
			$("#customDomain").val(postAddr);
		}
	}
	
	//저장 버튼
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
		if( newPwd1.length < 8){
			alertBox2("비밀번호는 8자리 이상만 가능합니다.", focusField, "#newuserPassword1");
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
			SamePass_0 = (chr_pass_0==chr_pass_1) ? (SamePass_0 + 1) : 0; 
						
			var code0 = chr_pass_0.charCodeAt(0);
			var code1 = chr_pass_1.charCodeAt(0);
			// 앞 뒤의 문자 코드값이 +1 차이날  경우 1 증가, 연속이 아닐 경우 초기화
			SamePass_1 = (code0 - code1 == 1) ? (SamePass_1 + 1) : 0;
			// 앞 뒤의 문자 코드값이 -1 차이날  경우 1 증가, 연속이 아닐 경우 초기화
			SamePass_2 = (code0 - code1 == -1) ? (SamePass_2 + 1) : 0;
			
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
			url : "${wasPath}/mbr/cmm/user/userPasswordCheck",
			dataType : "JSON",
			type : "POST",
			data : {
				"userId" : "${userId}"
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
	
	function passwordUpdateAjax() {
		$.ajax({
			url : "${wasPath}/mbr/cmm/user/userInfoUpdatepw",
			dataType : "JSON",
			type : "POST",
			data : {
					"userId" : "${userId}"
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
				alertBox2("사용자 전화번호를 입력하세요", focusField, "#mbrTel2");
				return false;
			}
			if($("#mbrTel3").val()==""){
				alertBox2("사용자 전화번호를 입력하세요", focusField, "#mbrTel3");
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
				alertBox2("사용자 전화번호를 입력하세요", focusField, "#mbrTelEx2");
				return false;
			}
		}
		if($("#mbrTelEx2").val()!=""){
			if($("#mbrTelEx1").val()==""){
				alertBox2("사용자 전화번호를 입력하세요", focusField, "#mbrTelEx1");
				return false;
			}			
		}
		if($("#deptName").val()==""){
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
		userInfoUpdateAjax()
	}
	
	function userInfoUpdateAjax() {
		
		var mailAddr = $("#userMail").val() + "@";	
		var Domain = $("#mailDomain > option:selected").val();		
		mailAddr += (Domain=="customAddr")? $("#customDomain").val() : Domain;  
				
		var mbrPhone = $("#mbrPhone1").val() + "-" +$("#mbrPhone2").val()+ "-" +$("#mbrPhone3").val();		
		var mbrTel = $("#mbrTel1").val() + "-" +$("#mbrTel2").val()+ "-" +$("#mbrTel3").val()
		var mbrTelEx = $("#mbrTelEx1").val() + "-" +$("#mbrTelEx2").val()
				
		$.ajax({
			url : "${wasPath}/mbr/cmm/user/userInfoUpdate",
			dataType : "JSON",
			type : "POST",
			data : {
					"userId" : "${userId}"
					,"modUserId" : "${userId}"
					,"userPhone" : mbrPhone
					,"userTel" : mbrTel
					,"userTelEx" : mbrTelEx
					,"userMail" : mailAddr					
					,"deptCode" : $("#deptCode").val()
					,"userLevel" : $("#userLevel > option:selected").val()
					,"smsRecvFlag" : $(":radio[name='smsRecvFlag']:checked").val()
					,"mailRecvFlag": $(":radio[name='mailRecvFlag']:checked").val()
					
			},
			success : function(data) {
				alertBox("저장되었습니다.", moveViewPage);
			},
			error : function(request, status, error) {
				errorBox("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	// 프로필 사진 저장
	function moveViewPage(){
		
		if( ($('#files-list').children().length > 0) && 
			($("#fileName").val() == $(".MultiFile-title").text()) ) {
			$('#file-form').ajaxForm({
				cache : false
				, data : {
					"programName" : "cmm_user"
					, "programSeq": "${userId}"
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
		       		return chk;
		       }
				,
		       //submit이후의 처리
		       success: function(result){
	// 	    	    var userId = "${userId}"
	// 	 			location.href = "${wasPath}/mbr/cmm/user/userInfo?userId="+userId;
		       },
		       complete : function(result){
		       },
		       //ajax error
		       error: function(e){
		       }                               
			});
			$('#file-form').submit();
		}else{
			setTimeout (function(){
				moveViewPage2();
			},500);
		}
		
		setTimeout (function(){
			moveViewPage2();
		},500);
	}
	
	function moveViewPage2(){		
		location.href = "${wasPath}/mbr/cmm/user/userInfo?userId=${userId}";
	}
	
	// 이미지파일 업로드
	/* function picUpdate(){
		$('#file-form').submit();
	}
	
	function actFileUpload(){		
		$('#file-form').submit(); 
		closeModal();
	} */	
		
	function openModal(){
		$("#modal-dialog-profileImg").modal();
	}

	function closeModal(){
		$("#modal-dialog-profileImg").modal("hide");
		$("#fileName").val($(".MultiFile-title").text());
//  		setTimeout (function(){
//  			getImgFile();
//  		},500);
	}
	
// 	function getImgFile(){
			
// 		$.ajax({
// 			url : "${contextPath}/mbr/cmm/file/list",
// 			dataType : "JSON",
// 			data : {
// 				"programName" : "cmm_user"
// 				, "programSeq": "${userId}"
// 			},
// 			success : function(data) {
// 				if(data.length !=0){
// 					$.each(data,function(key,val){
// 						var imgPath = "${wasPath}/mbr/cmm/file/download/"+val["fileId"];
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
// // 			$("#"+preViewer).append("<img src='"+img_path+"'>");
// // 			alertBox(img_path);
// // 			preViewer.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(src='file://"+img_path+"',sizingMethod='scale')";
// 		}else{
// 			 $("#image").on("change", function(){
					
// 				var file = $("#image").prop("files")[0];
// 				var blobURL = window.URL.createObjectURL(file);
// 				$("#image_preview img").attr("src",blobURL);
// 				$("#image_preview").slideDown();
// 				$(this).slideUp();
				
				
// 			 });
			
			
// 			/* 
// 			preViewer.innerHTML = "";
// 			var W = preViewer.offsetWidth;
// 			var H = preViewer.offsetHeigth;
// 			var tmpImage = document.createElement("img");
// 			preViewer.appendChild(tmpImage);
			
// 			tmpImage.onerror = function(){
// 				return preViewer.innerHTML="";
// 			}
			
// 			tmpImage.onload = function(){
// 				if(this.width > W){
// 					this.height = this.height / (this.width / W);
// 					this.width = W;
// 				}
// 				if(this.height > H){
// 					this.width = this.width / (this.height / H);
// 					this.width = H;
// 				}
// 			}
			
// 			if(ua.indexOf("Firefox/3") > -1){
// 				var picData = thisObj.files.item(0).getAsDataURL();
// 				tmpImage.src = picData;
// 			}else{
// 				tmpImage.src = "file://"+thisObj.value;
// 			}
// 			 */
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
				url : "${wasPath}/mbr/cmm/file/delete",
				dataType : "JSON",
				type : "POST",
				data : {
					"fileId" : fileId
					, "programName" : "cmm_user"
					, "programSeq" : "${userId}"
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
		
// 		$(".MultiFile-remove").trigger('click');
// 		$("#image_preview > img").attr("src", "/resources/assets/img/myInfo_profileImgPicto.png");
// 		location.reload(); 
	}	
	
	// 부서 modal 실행
	function initialDepartment() {
				
		$("#table-list").jqGrid('clearGridData', true);
		$("#table-list").jqGrid({
			url: '${contextPath}/mbr/mbrinfo/TreeAll',
			mtype: "POST",
			datatype: "json",
			postData: {	},
			colNames:['부서코드','상위부서코드', '부서명','level','isLeaf', 'isExpanded'],
			colModel:[				
				{name:'deptCode', 	index:'deptCode', 	hidden:false, 	width:140, align:"center", key: true}
				,{name:'upCode', 	index:'upCode', 	hidden:true, 	width:100, align:"left"}
	 	   		,{name:'deptName', 	index:'deptName', 	hidden:false, 	width:500, align:"left"}	 	   			 	   		
	 	   		,{name:'treeLevel', index:'treeLevel', 	hidden:true, 	width:220, align:"left"}
	 	   		,{name:'isLeaf', 	index:'isLeaf', 	hidden:true, 	width:220, align:"left"}
	 	   		,{name:'isExpanded',index:'isExpanded',	hidden:true, 	width:220, align:"left"}	 	   		
			],			
// 			rowNum:10,
// 			rowList:[5,10,15],
			rownumbers : false,
			loadonce : false,
			scrollrows:true,
			loadtext : "조회중 잠시만 기다려주세요.",
// 			height: '100%', //300, //$(".tbl_type01").height()-40,
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
	//부서 검색
	function searchDepartment() {		
		$("#table-list").jqGrid('setGridParam', {
			url: '${contextPath}/mbr/mbrinfo/TreeAll'
			, mtype: "POST"
			, datatype: "json"			
			, postData: {
				"searchKind": "dept_name",
				"keyword":$("#searchKeywordDept").val()
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
		if(deptCode != null && deptCode != "") {
			$("#deptCode").val(deptCode);
			$("#deptName").val(deptName);			
			$("#searchKeywordDept").val("");
			$("#modal-dialog3").modal("hide");
		}				
	}

				

</script>
</body>
</html>