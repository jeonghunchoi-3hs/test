<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xml:lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>퍼블리싱 스타일 가이드 - 레이아웃</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="expires" content="0" />
	<c:import url="../WEB-INF/views/mng/include/import.jsp" charEncoding="UTF-8"></c:import> 
	<style>
	 xmp {border:2px dashed #fff;background:#000;color:#fff;padding:20px;display:block;margin:20px 0 0 0;}
	 ul li a {display:block;width:100%;padding:20px 10px;background:#ecf1f7;font-size:18px;color:#666;border-bottom:1px solid #d5dae0;}
	ul li.on a {background:#fff;color:#0d96e9;font-weight:bold;}
	h1.title {display:block;font-size:25px;color:#000;font-weight:bold;margin-bottom:15px;}
	</style>
</head>
<body>
<div style="width:1200px;margin:0 auto;overflow:hidden;">
	<div style="width:200px;float:left;">
		<ul>
			<li><a href="layout.jsp">레이아웃/타이틀</a></li>
			<li><a href="button.jsp">버튼</a></li>
			<li class="on"><a href="form.jsp">폼</a></li>
			<li><a href="text.jsp">텍스트</a></li>
		</ul>
	</div>
	<div style="width:1000px;float:right;padding:20px;">
		
		<div class="row mb30">
			<h1 class="title">&middot; 셀렉트박스</h1>
			<div class="codeArea">
				<div class="selectBox" style="width:130px;">
					<label class="selectText">옵션</label>
					<select class="search-sel">
						<option value="">옵션</option>
						<option value="">옵션2</option>			
					</select>
				</div>
			</div>
			<div class="xmpArea">
				<xmp>
<div class="selectBox" style="width:130px;">
	<label class="selectText">옵션</label>
	<select class="search-sel">
		<option value="">옵션</option>
		<option value="">옵션2</option>			
	</select>
</div>
				</xmp>
			</div>
		</div>
		
		<div class="row mb30">
			<h1 class="title">&middot; 셀렉트박스2</h1>
			<div class="codeArea">
				<div class="selectBox" style="width:130px;">
					<label class="selectText">옵션</label>
					<select class="search-sel">
						<option value="">옵션</option>
						<option value="">옵션2</option>			
					</select>
				</div>
				<span class="selectTxt">월</span>
			</div>
			<div class="xmpArea">
				<xmp>
<div class="selectBox" style="width:130px;">
					<label class="selectText">옵션</label>
					<select class="search-sel">
						<option value="">옵션</option>
						<option value="">옵션2</option>			
					</select>
				</div>
				<span class="selectTxt">월</span>
				</xmp>
			</div>
		</div>
		
		<div class="row mb30">
			<h1 class="title">&middot; 검색박스</h1>
			<div class="codeArea">
				<div class="page_searchBox m-b-15">
					<div class="optionBox m-r-10">
						<label><input type="radio" name="opt_radio01" data-original-title="" title=""><span>내작업</span></label>
						<label><input type="radio" name="opt_radio01" data-original-title="" title=""><span>전체</span></label>
					</div>
					<div class="searchArea">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="customerName">고객사 이름</option>
								<option value="customerId">고객사 ID</option>
								<option value="companyRep">대표자명</option>
								<option value="managerName">담당자</option>
								<option value="regUserName">등록자</option>					
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();">
							<a href="javascript:void(0);" class="btn_search" onclick="gridList()">검색</a>
						</div>
					</div>
				</div>
			</div>
			<div class="xmpArea">
				<xmp>
<div class="page_searchBox m-b-15">
	<div class="optionBox m-r-10">
		<label><input type="radio" name="opt_radio01" data-original-title="" title=""><span>내작업</span></label>
		<label><input type="radio" name="opt_radio01" data-original-title="" title=""><span>전체</span></label>
	</div>
	<div class="searchArea">
		<div class="selectBox" style="width:130px;">
			<label class="selectText" for="searchKind">전체</label>
			<select class="search-sel" id="searchKind">
				<option value="searchAll">전체</option>
				<option value="customerName">고객사 이름</option>
				<option value="customerId">고객사 ID</option>
				<option value="companyRep">대표자명</option>
				<option value="managerName">담당자</option>
				<option value="regUserName">등록자</option>					
			</select>
		</div>
		<div class="inputArea m-l-5">
			<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();">
			<a href="javascript:void(0);" class="btn_search" onclick="gridList()">검색</a>
		</div>
	</div>
</div>
				</xmp>
			</div>
		</div>
		
		
	
		<div class="row mb30">
			<h1 class="title">&middot; Datepicker</h1>
			<div class="codeArea">
				<input type="text" class="applyDate" name="applyDate" style="width:120px;" />
			</div>
			<div class="xmpArea">
				<xmp>
<input type="text" class="applyDate" name="applyDate" style="width:120px;" />

function calendar(){
			
	var dayName = ['일','월','화','수','목','금','토'];
	var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

	$(".applyDate").datepicker({
		showOn:"both",
		buttonImage:"/resources/mng/assets/img/ico_datepicker_cal.png",
		buttonImageOnly:true,
		dateFormat : "yy-mm-dd",
		dayNamesMin:dayName,
		monthNamesShort:monthName,
		changeMonth:true,
		minDate:0
	});
	$("img.ui-datepicker-trigger").attr("style", "vertical-align:top;");
	$(".applyDate").val($.datepicker.formatDate('yy-mm-dd', new Date()));
}

				</xmp>
			</div>
		</div>
		
		
	</div>
</div>

</body>
</html>