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
	<c:import url="../../mbr/include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body class="loginbg">

<div id="page-container" class="fade page-container mt100">
	    <!-- begin login -->
		<div class="login bgff width-600">
		    <!-- begin login-brand -->
            <div class="login-brand bg-inverse fw">
                <img src="/resources/assets/img/nh.png" height="36" class="pull-right logo" alt="로고" />ID/PW 찾기
				
            </div>
		    <!-- end login-brand -->
		    <!-- begin login-content -->
            <div class="login-content brno">
                <h4 class="pt20 m-b-20">ㆍ아이디 찾기 </h4>
				<h5 class="pl20 lh20">가입신청시 <span class="fc-orange">등록한 이름 </span>과 <span class="fc-orange">등록한 이메일 </span>로  아이디를 찾으실 수 있습니다.<br/>
					가입신청시 <span class="f_line">등록된 이메일 주소와 입력한 이메일 주소가 같아야</span> 아이디를 받을 수 있습니다.</h5>
                
<!-- 				    <div class="col-md-12 mb10 ml10"> <input type="radio" id="mbrinfoselect1" name="mbrinfoselect" value="Y" checked/> 사용자 <span class="ml20"></span> <input type="radio" id="mbrinfoselect2" name="mbrinfoselect" value="N"/> 회원사</div> -->
<!-- 				    <div class="col-md-12 mb10 ml10"> <input type="radio" id="mbrinfoselect1" name="mbrinfoselect" value="Y" checked/> 사용자</div> -->
                    <div name="userinfo" id="userinfo">
                    	<div class="form-group ml20">
	                      <span class="fb">사용자 이름</span>  
	                      <input type="text" class="form-control w60 dpin vm" placeholder="아이디를 입력하세요" name="userName" id="userName" value="" /> 
	                   	</div>
	                    <div class="form-group ml20 mb30">
	                      <span class="fb">이메일 주소</span>  
	                      <input type="text" class="form-control w60 dpin vm" placeholder="이메일주소를 입력하세요" name="userMail" id="userMail" value="" />  
	                      <button type="button" id="idsearch" name="idsearch" value="ID찾기" onclick="idsearch();" class="btn btn-grey">찾기</button>
	                    </div>
                    </div> 
                    <div name="customerinfo" id="customerinfo" style="display:none">
                    	<div class="form-group ml20">
	                      <span class="fb">담당자 이름</span>  
	                      <input type="text" class="form-control w60 dpin vm" placeholder="아이디를 입력하세요" name="contactName" id="contactName" value="" /> 
	                   	</div>
	                    <div class="form-group ml20 mb30">
	                      <span class="fb">이메일 주소</span>  
	                      <input type="text" class="form-control w60 dpin vm" placeholder="이메일주소를 입력하세요" name="contactMail" id="contactMail" value="" /> 
	                      <button type="button" id="customeridsearch" name="customeridsearch" value="ID찾기" onclick="customeridsearch();" class="btn btn-grey">찾기</button>
	                    </div>
                    </div>                  	
                 <hr class="bt1-dot"></hr>
			
            </div>
		    <!-- end login-content -->
			
			 <!-- begin pw-content -->
            <div class="login-content pt0">
                <h4 class="m-t-0">ㆍ비밀번호 찾기 </h4>
				<h5 class="pl20 lh20">가입신청시 <span class="fc-orange">등록한 이메일 </span>과 <span class="fc-orange">아이디</span>로 비밀번호 초기화를 하실수 있습니다.<br/>
					가입신청시 <span class="f_line">등록된 이메일 주소로 초기화된 비밀번호가 발송 </span> 됩니다.</h5>
                
<!-- 				    <div class="col-md-12 mb10 ml10"> <input type="radio" id="pwmbrinfoselect1" name="pwmbrinfoselect" value="Y" checked/> 사용자 <span class="ml20"></span> <input type="radio" id="pwmbrinfoselect2" name="pwmbrinfoselect" value="N" /> 회원사</div> -->
                   
                    <div name="pwuserinfo" id="pwuserinfo">
                    	<div class="form-group ml20">
	                      <span class="fb">아이디 입력</span>  
	                      <input type="text" name="userId" id="userId" value="" class="form-control w60 dpin vm" placeholder="아이디를 입력하세요" />                        
	                    </div>
	                    <div class="form-group ml20 mb30">
	                      <span class="fb">이메일 주소</span>  
	                      <input type="text" name="pwuserMail" id="pwuserMail" value="" class="form-control w60 dpin vm" placeholder="이메일주소를 입력하세요" />  
	                      <button type="button" id="pwsearch" name="pwsearch" value="PW찾기" onclick="pwsearch();" class="btn btn-grey">찾기</button>
	                    </div>
                    </div> 
                    <div name="pwcustomerinfo" id="pwcustomerinfo" style="display:none">
                    	<div class="form-group ml20">
	                      <span class="fb">아이디 입력</span>  
	                      <input type="text" name="customerId" id="customerId" value="" class="form-control w60 dpin vm" placeholder="아이디를 입력하세요" />                        
	                    </div>
	                    <div class="form-group ml20 mb30">
	                      <span class="fb">이메일 주소</span>  
	                      <input type="text" name="pwcontactMail" id="pwcontactMail" value="" class="form-control w60 dpin" placeholder="이메일주소를 입력하세요" />  
	                      <button type="button" id="customerpwsearch" name="customerpwsearch" value="비밀번호찾기" onclick="customerpwsearch();" class="btn btn-grey">찾기</button>
	                    </div>
                    </div>
					
					<div class="tac">
				    	<input type="button" class="btn btn-primary_05" value="로그인 페이지로 이동" onclick="moveLoginPage();"><br/><br/>
				    </div>
            </div>
		    <!-- end pw-content -->
		    
		</div>
		<!-- end login -->
	
	

	</div>
	<!-- end page container -->

</body>

  
	<!-- ================== BEGIN BASE JS ================== -->
	<script src="<%=request.getContextPath()%>/resources/assets/plugins/pace/pace.min.js"></script>
	<!-- ================== END BASE JS ================== -->
    
    <!-- ================== BEGIN BASE JS ================== -->
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/bootstrap.min.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/respond.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/metisMenu.min.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.dataTables.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/dataTables.bootstrap.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/dataTables.tableTools.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/bootstrapValidator.min.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.placeholder.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.MultiFile.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.form.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.modal.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/set/core.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/set/modal.js"></script>

	<script type='text/javascript' src="<%=request.getContextPath()%>/resources/highCharts/code/highcharts.js"></script>
     
	<script src="<%=request.getContextPath()%>/resources/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    
	<script src="<%=request.getContextPath()%>/resources/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/plugins/jquery-cookie/jquery.cookie.js"></script>

	<script src="<%=request.getContextPath()%>/resources/assets/plugins/bootstrap-calendar/js/bootstrap_calendar.min.js"></script>
<%-- 	<script src="<%=request.getContextPath()%>/resources/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script> --%>
	<!-- ================== END BASE JS ================== -->
	
	<!-- ================== BEGIN PAGE LEVEL JS ================== -->
    <script src="<%=request.getContextPath()%>/resources/assets/js/page-ui-modal-notification.demo.min.js"></script>
<%--     <script src="<%=request.getContextPath()%>/resources/assets/js/page-form-plugins.demo.js"></script> --%>
    <script src="<%=request.getContextPath()%>/resources/assets/js/demo.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/apps.min.js"></script>
	<!-- ================== END PAGE LEVEL JS ================== -->

	
	<script type="text/javascript">
		$(document).ready(function() {
		    App.init();
		 
		$("input[name='mbrinfoselect']").live('click',function(){	
			//alert($("input[name='hourlyFlag']:checked").val());
			if($("input[name='mbrinfoselect']:checked").val()=="N"){					
				$("#userinfo").hide();
				$("#customerinfo").show();					
			}else{
				$("#customerinfo").hide();
				$("#userinfo").show();
			}
				
		});
		
		$("input[name='pwmbrinfoselect']").live('click',function(){	
			//alert($("input[name='hourlyFlag']:checked").val());
			if($("input[name='pwmbrinfoselect']:checked").val()=="N"){					
				$("#pwuserinfo").hide();
				$("#pwcustomerinfo").show();					
			}else{
				$("#pwcustomerinfo").hide();
				$("#pwuserinfo").show();
			}
				
		});
		
		  //메뉴활성화
		 $("#project").addClass("active");
		 $("#approveProjectList").addClass("active");
		    //Demo.init();
		  //  PageDemo.init();
			
			$("a>button").live('click',function(){
			location.href = $(this).closest("a").attr("href");
			});
		});
		
		function idsearch(){
			//alert("사용자 아이디 검색");
			if($("#userName").val()==""){
				alertBox3(" 사용자 이름을 입력하세요");
				$("#userName").focus();
				return false;
			}
			if($("#userMail").val()==""){
				alertBox3(" 사용자 이메일주소을 입력하세요");
				$("#userMail").focus();
				return false;
			}
			var jsonData = setJsonData();
			$.ajax({
				url : "useridSearch",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					if(data==0){
						alertBox3("입력된 정보와 일치 하는 아이디가 <br>없습니다.");
					}else{
						alertBox3("아이디 찾기 성공 이메일 발송");
					}

				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
				
			})
		}
		
		function setJsonData(){	
			
			var jsonData = {
					"userName" : $("#userName").val()        
					, "userMail": $("#userMail").val() 
					};
			return jsonData;
		}
		
		function pwsearch(){
			//alert("사용자 패스워드 검색");
			if($("#userId").val()==""){
				alertBox3("사용자 아이디을 입력하세요");
				$("#userId").focus();
				return false;
			}
			if($("#pwuserMail").val()==""){
				alertBox3("사용자 이메일주소을 입력하세요");
				$("#pwuserMail").focus();
				return false;
			}
			var jsonData = setJsonDatapw();
			$.ajax({
				url : "userpwSearch",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					if(data==0){
						alertBox3("입력된 정보와 일치 하는 정보가 <br>없습니다.");
					}else{
						alertBox3("비밀번호 찾기 성공 이메일 발송,<br>비밀번호 초기화");
					}

				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
				
			})
		}
		
		function setJsonDatapw(){	
			
			var jsonData = {
					"userName" : $("#userName").val()        
					, "userMail": $("#pwuserMail").val() 
					, "userId": $("#userId").val()
					};
			return jsonData;
		}
		
		
		function customeridsearch(){
			//alert("회원사 아이디 검색");
			if($("#contactName").val()==""){
				alert("회원사 담당자  이름을 입력하세요");
				$("#contactName").focus();
				return false;
			}
			if($("#contactMail").val()==""){
				alert("회원사 담당지 이메일주소을 입력하세요");
				$("#contactMail").focus();
				return false;
			}
			var jsonData = customeridsearchJson();
			$.ajax({
				url : "customeridSearch",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					if(data==0){
						alert("입력된 정보와 일치 하는 아이디가 없습니다.");
					}else{
						alert("아이디 찾기 성공 이메일 발송");
					}

				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
				
			})
		}
		
		function customeridsearchJson(){	
			
			var jsonData = {
					"contactName" : $("#contactName").val()        
					, "contactMail": $("#contactMail").val() 
					};
			return jsonData;
		}
		
		function customerpwsearch(){
			alert("회원사 비밀번호 검색");
			if($("#customerId").val()==""){
				alert("회원사 아이디을 입력하세요");
				$("#customerId").focus();
				return false;
			}
			if($("#pwcontactMail").val()==""){
				alert("회원사 담당자 이메일주소을 입력하세요");
				$("#pwcontactMail").focus();
				return false;
			}
			var jsonData = customerpwsearchJson();
			$.ajax({
				url : "customerpwSearch",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					if(data==0){
						alert("입력된 정보와 일치 하는 아이디가 없습니다.");
					}else{
						alert("아이디 찾기 성공 이메일 발송");
					}

				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
				
			})
		}
		
		function customerpwsearchJson(){	
			
			var jsonData = {
					"customerId" : $("#customerId").val()        
					, "contactMail": $("#pwcontactMail").val() 
					};
			return jsonData;
		}

		function moveLoginPage(){

			location.href="${contextPath}/mbr/";
		}
		
	</script>
	

</html>