<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
/*  	.imgClassTop{
 		margin : 0 auto;
       	width : 90px;

 	}      */
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
<!-- 로딩바 관련 끝 -->

<div class="back_lock" id="back_lock"></div>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

		<!-- begin #header -->
		<div id="header" class="header navbar navbar-default navbar-fixed-top">
			<!-- begin container-fluid -->
			<div class="info tar" style="padding-top:25px; padding-right:24px;">
				<!-- 상단 변경요청 및 미사용 -->

				<span class="mr20"><b class="userName">${userName}(${userId}) 님</b> </span>
				<a title="내정보" href="javascript:;" onclick="location.href='${wasPath}/mbr/cmm/user/userInfo'" class="fcca mr20"><i class="fa fa-user-o"></i> 내정보</a>
				<a title="Logout" href="javascript:;" onclick="location.href='${wasPath}/mbr/j_spring_security_logout'" class="fcca mr10"> <i class="fa fa-sign-out"></i> 로그아웃</a>

			</div>

			<div class="container-fluid">
				<!-- begin mobile sidebar expand / collapse button -->
				<div class="navbar-header">
					<a href="${wasPath}/mbr/main" class="navbar-brand"><img src="${apachePath}/resources/assets/img/logo.png" class="logo" alt="ECloud"/> </a>
				</div>
				<!-- end mobile sidebar expand / collapse button -->

					<li>
                        <!-- begin sidebar minify button -->
                        <a href="javascript:;" class="main-minify-btn" data-click="sidebar-minify"><i class="fa fa-angle-left"></i></a>
                        <!-- end sidebar minify button -->
					</li>

				<!-- begin navbar-right -->
				<!--
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown navbar-user">
						<a type='button' >
							<span class="hidden-xs"><b>${userName}(${userId})님</b> 반갑습니다.</span>
							<input type='hidden' id='loginId' value='${userId}'/>
						</a>
					</li>
					<li class="mt15">
						<div style='float:left;padding-left:5px;'>
							<a class="btn btn-lime btn-s f11" title="내정보" href="${wasPath}/mbr/cmm/user/userInfo"> <i class="fa fa-info-circle"></i> 내정보</a>
						</div>
						<div style='float:left;padding-left:5px;'>
							<a class="btn btn-primary btn-s f11" title="일괄신청" href="${wasPath}/mbr/req/catalogue/basketOrder.do"><i class="fa fa-shopping-basket"></i> 일괄신청</a>
						</div>
						<div style='float:left;padding-left:5px;'>
							<a class="btn btn-grey btn-s f11" title="Logout" href="j_spring_security_logout"><i class="fa fa-sign-out"></i> 로그아웃</a>
						</div>
					</li>
				</ul>
				-->
				<!-- end navbar-right -->
			</div>
			<!-- end container-fluid -->
		</div>
		<!-- end #header -->
		<!--
		<body class="boxed-layout">
	 	-->
		<script type="text/javascript">
			var tid;
			var time = 32382; // 시간-1초
			var cnt = parseInt(time, 10);

			function time_run() {
				$("#divTimerCount").text(time_format(cnt));
				cnt --;
				if(cnt<0){
					clearInterval(tid);
					alertBox("접속시간이 만료되었습니다.", logout);
				}
			}

			function time_format(n){
				var h = 0;
				var m = 0;
				var s = 0;
				if(n>0){

					h =  Math.floor(n /3600);
					m =  Math.floor((n -(h * 3600)) / 60);
					s =   n - (h *3600) - (m*60);
				}
				if(h<10){ h = "0"+h; }
				if(m<10){ m = "0"+m; }
				if(s<10){ s = "0"+s; }
				return h+":"+m+":"+s;
			}

			function timerExtension(){
				$.ajax({
					url : "${wasPath}/mbr/mbrhome/timer",
					type : "POST",
					success : function(data) {
						$("#divTimerCount").text("09:00:00");
						clearInterval(tid);
						cnt = parseInt(time, 10);
						tid = setInterval("time_run()", 1000)
					}
				});
			}

			//헤더 이미지 출력
			function getUserPic(){
				$.ajax({
					url : "${wasPath}/mbr/cmm/user/userPic",
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
							$("#headerUserPic").attr("src", "${wasPath}/mbr/cmm/file/download/"+fileId+"");
						}else{
							$("#headerUserPic").attr("src", "${apachePath}/resources/assets/img/df_user_icon.png");
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

			function getBasketCnt(){
				$.ajax({
					url : "${wasPath}/mbr/req/catalogue/getBasketCnt",
					dataType : "JSON",
					type : "POST",
					data : {

					},
					success : function(data) {
						var basketCnt = data;
						$("#basketCnt > strong").remove();
						if(basketCnt > 0) {
							$("#basketCnt").append("<strong>"+basketCnt+"</strong>");
						} else if (basketCnt > 99) {
							$("#basketCnt").append("<strong>99+</strong>");
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
			Date.prototype.format = function (f) {
			    if (!this.valueOf()) return " ";
			    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
			    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];
			    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
			    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
			    var d = this;
			    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {
			        switch ($1) {
			            case "yyyy": return d.getFullYear(); // 년 (4자리)
			            case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)
			            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)
			            case "dd": return d.getDate().zf(2); // 일 (2자리)
			            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)
			            case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)
			            case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)
			            case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)
			            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)
			            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)
			            case "mm": return d.getMinutes().zf(2); // 분 (2자리)
			            case "ss": return d.getSeconds().zf(2); // 초 (2자리
			            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분
			            default: return $1;
			        }
			    });
			};
			String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
			String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
			Number.prototype.zf = function (len) { return this.toString().zf(len); };

			$(document).ready(function(){
				getUserPic();
				getBasketCnt();
				tid = setInterval("time_run()", 1000);
			});
		</script>