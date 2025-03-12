<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
		
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			<p class="page_title">FAQ
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/bbs/notice/">사용문의 </a> <span class="arrow_ab"> &#8227; </span> <b><a href="${wasPath}/mbr/bbs/faq/">FAQ</a> </b>
			    </span>
			</p>
			
			<!-- begin page-body -->
			<div class="row p20 bgwh br10">
				
				<div class="cs_visual">
				  <div class="left_text"><i class="fa fa-book"></i></div>
			       <div class="right_text"><i class="fa fa-quote-right"></i></div>
					<strong>K-Cloud의 자주찾는 질문과 답변입니다.</strong>
					<p>클라우드 문의내용 중 가장 많이 할 수 있는 질문들을 모았습니다.</p>
				</div>
				
				<!-- Tab -->
				<div class="csCenterTabArea">
					<ul>
						<li class="btn_all on"><a href="javascript:void(0);">전체</a></li>
						<li class="btn_cloud"><a href="javascript:void(0);">클라우드</a></li>
						<li class="btn_join"><a href="javascript:void(0);">회원가입</a></li>
					</ul>
				</div>
				
				<div class="csCenterBoard">
					<div class="faqList">
						<ul class="lists">
							<c:forEach items="${faqList}" var="faqList" varStatus="status" >
							<li>
								<div class="titleArea">
									<span class="category">${faqList.typeName}</span>
									<span class="title">${faqList.title}</span>
									<i class="ico_faqArrow"></i>
								</div>
								<!-- 상세 -->
								<div class="viewArea">
									<div class="faqAnswer">
									   <%pageContext.setAttribute("newLineChar","\n"); pageContext.setAttribute("br","<br/>");%>
										<p>${fn:replace(faqList.content, newLineChar,br)} </p>
									</div>
								</div>
							</li>
								</c:forEach>
						</ul>
					</div>
				</div>
		</div>
			<!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		<!-- end #content -->
		
		</div>
		
		
	</div>
	<!-- end page container -->	

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

var faqFunc = function(){
	$('.faqList ul li').each(function(){
		var text = $(this).children('.titleArea').children('.category').text();
		if( text == '[클라우드]' ) {
			$(this).addClass('faq_cloud');
		} else if ( text == '[요금]' ) {
			$(this).addClass('faq_fee');
		} else if ( text == '[회원가입]' ) {
			$(this).addClass('faq_join');
		}
	});
	
	$('.csCenterTabArea ul > li a').click(function(){
		$('.csCenterTabArea ul li').removeClass('on');
		$(this).parent().addClass('on');
	});
	
	$('.csCenterTabArea ul li.btn_all a').click(function(e){
		e.preventDefault();
		$('.faqList li').fadeIn(50);
	});
	$('.csCenterTabArea ul li.btn_cloud a').click(function(e){
		e.preventDefault();
		$('.faqList li').fadeOut(50);
		$('.faqList li.faq_cloud').fadeIn(50);
	});
	$('.csCenterTabArea ul li.btn_fee a').click(function(e){
		e.preventDefault();
		$('.faqList li').fadeOut(50);
		$('.faqList li.faq_fee').fadeIn(50);
	});
	$('.csCenterTabArea ul li.btn_join a').click(function(e){
		e.preventDefault();
		$('.faqList li').fadeOut(50);
		$('.faqList li.faq_join').fadeIn(50);
	});
}

function bbsAccor() {
	$('.csCenterBoard .lists > li .titleArea').click(function(e){
		e.preventDefault();
		var checkEle = $(this).next();
		$('.csCenterBoard .lists li').removeClass('active');
		$(this).closest('li').addClass('active');
		
		if((checkEle.is('div')) && (checkEle.is(':visible'))) {
			$(this).closest('li').removeClass('active');
			checkEle.slideUp('fast');
		}
		
		if((checkEle.is('div')) && (!checkEle.is(':visible'))) {
			$('.csCenterBoard li div.viewArea:visible').slideUp('fast');
			checkEle.slideDown('fast');
		}
		
		if(checkEle.is('div')) {
			return false;
		} else {
			return true;
		}
	});
}

	$(document).ready(function() {
		App.init();
		bbsAccor();
		faqFunc();
		
		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsFaq").addClass("active");

	});
</script>

</body>
</html>