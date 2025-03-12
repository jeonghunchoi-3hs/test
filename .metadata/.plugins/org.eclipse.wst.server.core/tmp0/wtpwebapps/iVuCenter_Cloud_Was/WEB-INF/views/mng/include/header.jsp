<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 기능 : 로딩바 div, img
만든이 : smhong( 홍승민) -->
<style type="text/css">
	.centerLockRap{
		width: 100%;
		height: 100%;
		background-color: rgba(0,0,0, 0.5);
		z-index: 999999999999999;
		position: fixed;
		vertical-align:middle;
		left: 0px;
		top : 0px;
		display: none;
	}
	.lockImg{
	    position : absolute;
       	height : 100px;
       	width : 350px;
       	left : 50%; 
       	top : calc( 50% - 30px);
       	transform:translateY(-50% );
       	transform:translateX(-50% );
   		text-align: center;
 	}
 	.top_fontSize{
 		color: #FFFFFF;
 		width: 100%;
 		margin-top: 10px;
 	}
 	/* .imgClassTop{
 		margin : 0 auto;
       	width : 90px;
       
 	} */     
</style>
<script type="text/javascript">
var setLodingFun = {
	lodingName : ".centerLockRap"
		
	,blocksFun : function(){ //block Return
		$( this.lodingName).show();
	
	}
	,nonesFun : function () { //none Return
		$( this.lodingName).hide();
		
	}
};

</script>

<div class="centerLockRap">
    <div class="lockImg">
	<!-- <img src="/resources/assets/img/lockLodingBar.gif" class="imgClassTop" /> -->
	<img src="/resources/mng/assets/img/loading.gif" class="imgClassTop" />
	
	
	
	
	
	
    <div class="top_fontSize">처리 중 입니다. 잠시만 기다려 주십시오...</div>
    </div>
</div>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>
   
<!-- begin #header -->
		<div id="header" class="header navbar-fixed-top">
			
			<div class="topLogo">
				<a href="${contextPath}/mng/mnghome/dashboard/"><img src="${apachePath}/resources/mng/assets/img/logo.png" alt="로고"/></a>
			</div>
			<div >
				<!--<div class="profileThumb">
					<span class="mask"></span>
					<img src="${apachePath}/resources/mng/assets/img/profile_sample.png" alt="Sample" id="headerUserPic">
				</div>-->
				
			</div>
			
			<ul class="btns">
			    <li class="greeting"><span class="hidden-xs"><b>${userName}(${userId})님</b> 반갑습니다.</span></li>
				<li class="btn_noti" id="divHeader1" style='display:none;'><a href="${contextPath}/mng/bbs/qna/" id="replyCnt">알림</a></li>
				<li class="btn_setting"><a href="${contextPath}/mng/cmm/user/userInfo">내정보</a></li>
				<li class="btn_logout"><a href="${contextPath}/mng/login/j_spring_security_logout">로그아웃</a></li>
			</ul> 
	
		</div>
		<!-- end #header -->
		<body class="boxed-layout">
		
		<script type="text/javascript">
		//헤더 이미지 출력
		function getUserPic(){
			$.ajax({
				url : "${wasPath}/mng/cmm/user/mngUserPic",
				dataType : "JSON",
				type : "POST",
				data : {
					
				},
				success : function(data) {
					var fileList = data.picFile;
					var fileId = "";
					if(fileList.length!=0){
						$.each(fileList,function(key,val){
							fileId = val["fileId"];
						});
						$("#headerUserPic").attr("src", "${wasPath}/mng/cmm/file/download/"+fileId+"");
					}else{
						$("#headerUserPic").attr("src", "${apachePath}/resources/mng/assets/img/profile_sample.png");
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
		
		
		$.ajax({
			url : "${contextPath}/mng/bbs/qna/noReplyCount",
			dataType : "JSON",
			type : "POST",
			data : {
			},
			success : function(data) {
				var noReplyCount = data.replyCnt;
				$("#replyCnt > span").remove();
				if(data.replyCnt > 0) {
					$("#replyCnt").append("<span>"+data.replyCnt+"</span>");
				} else if (data.replyCnt > 99) {
					$("#replyCnt").append("<span>99+</span>");
				}
			},
			error : function(request, status, error) {
				$("#replyCnt > span").remove();
			}
		});
		
		$(document).ready(function(){
			getUserPic();
		});
		
		</script>
		 