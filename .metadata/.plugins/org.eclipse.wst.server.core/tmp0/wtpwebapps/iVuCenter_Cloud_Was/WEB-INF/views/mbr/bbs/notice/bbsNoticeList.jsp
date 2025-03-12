<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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


			<p class="page_title">공지사항
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/bbs/notice/">사용문의 </a> <span class="arrow_ab"> &#8227; </span> <b><a href="${wasPath}/mbr/bbs/notice/">공지사항</a> </b>
			    </span>
				</p>


			<!-- begin page-body -->
			<div class="row p20 bgwh br10">

			<div class="cs_visual">
			   <div class="left_text"><i class="fa fa-file-text-o"></i></div>
			   <div class="right_text"><i class="fa fa-microphone"></i></div>
				<strong>K-Cloud의 소식을 알려드립니다.</strong>
				<p>공지사항에서 새로운 소식을 확인해보세요.</p>

			</div>


			<!-- begin page-body -->
				<div class="col-md-12 br5 p30 mb20 bgee">
					<div class="selectBoxAr">
						<label class="selectText" for="searchKind">전체</label>
						<select class="search-sel" id="searchKind">
							<option value="searchAll">전체</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select>
					</div>
					<div class="search-box">
						<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
						<button type="button" class="btn_search2"  onclick="gridList()"><span></span></button>
					</div>
				</div>
			<!-- search end -->



			<!-- search begin 2023-->
			<!-- <div class="col-md-12 br5 p20 mb20 bgf5 tac">
				         <div class="new-search">
				           <div class="left">
					         <div class="choice-kepco">
							  <div class="select-kepco" id="searchKind">
							    <button class="kep-label" value="searchAll" for="searchKind">전체 </button>
							    <ul class="optionList">
							      <li class="optionItem" value="searchAll">전체</li>
							      <li class="optionItem" value="title">제목</li>
							      <li class="optionItem" value="content">내용</li>
							    </ul>
							  </div>
							</div>
							</div>

							<div class="right">
	                          <input type="text" class="input-kepco" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
	                          <button type="button" class="kepco-ser-icon"  onclick="gridList()"></button>
	                         </div>
                          </div>
				</div> -->
				<!-- search end -->

			<!-- 테이블시작 -->

			<div class="csCenterBoard noticeBoard" id="accodianList">
			</div>

			<!-- 테이블시작 -->
			<div class="col-md-12">
				<div class="panel">
				    <div class="table-responsive">
				        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="noticeBbsList" summary="공지사항">
				        <caption>게시판 목록 : 프로젝트명, 프로젝트 별칭, 고객사명, 프로젝트, 등록일시, 상세로 구성</caption>
							 <colgroup>
						 		<col width="25%">
						 		<col width="25%">
						 		<col width="20%">
						 		<col width="15%">
						 		<col width="15%">
						 		<!-- <col width="10%"> -->
						 	</colgroup>
							<thead>
								<tr class="primary">
									<th class="tac" scope="col">프로젝트명</th>
								  	<th class="tac" scope="col">프로젝트 별칭</th>
								  	<th class="tac" scope="col">고객사명</th>
								  	<th class="tac" scope="col">프로젝트 PM</th>
								  	<th class="tac" scope="col">등록일시</th>
								 <th class="tac" style="border-right:none; " scope="col">상세보기</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<!-- 테이블 끝 -->


			<!-- end page-body -->





		</div>
		<!-- end #content -->
		<!-- begin #footer -->
		<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #footer -->

	</div>
	<!-- end page container -->

</body>

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	// 아코디언 효과
	function bbsAccor() {
		$('.csCenterBoard .lists li').each(function(){
			$(this).children('.titleArea').click(function(e){
				e.preventDefault();
				var checkEle = $(this).next();

				$(this).parent().removeClass('active');
				$(this).closest('li').addClass('active');

				if((checkEle.is('div')) && (checkEle.is(':visible'))) {
					$(this).closest('li').removeClass('active');
					checkEle.slideUp('fast');
				}

				if((checkEle.is('div')) && (!checkEle.is(':visible'))) {
					$('.csCenterBoard li div.viewArea').slideUp('fast');
					$(this).parent().addClass('active');
					checkEle.slideDown('fast');

					//조회수 업데이트
					var noticeNo = $(this).children('input').val();
					updateHitCount(noticeNo);
				}

				if(checkEle.is('div')) {
					return false;
				} else {
					return true;
				}
			});
		});

	}


	// 기존 dataTable에서 페이징기능 및 총건수기능만 살려둠
	// <table id="noticeBbsList">에 페이징과 총건수 출력
	function gridList() {

		$("#noticeBbsList").dataTable( {
			"processing":true
			,"ordering" : false
			,"destroy" : true
			,"autoWidth":false
			,"serverSide":true
			,"ajax": {
				"url":"${wasPath}/mbr/bbs/notice/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				}
				,"complete" : function(obj, status){
					if(status == 'success'){
						setAccodianList(obj.responseJSON);		//아코디언 목록 Html 그리는 함수
					}
				}
			}
			, "initComplete" : function(setting, json){
				$("#noticeBbsList > thead").remove();
				$("#noticeBbsList > tbody").remove();
			}
			,"columns":[
			        	{"data":"noticeNo", "class":"tac"}
// 			        	, {"data":"codeName", "class":"tac"}
// 			        	, {"data":"title", "class":"tal"}
// 			        	, {"data":"hitCount", "class":"tac"}
// 			        	, {"data":"regDatetime2", "class":"tac"}
// 			        	, {"data":"userName", "class":"tac"}
			        	//, {"class":"ditailStyle tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[5,15], [5, 15]]
			,"language": {
				"zeroRecords":""
				, "processing":""
			}
			,"sDom":'<"top"i><"bottom"p>'
		});
	}

	//아코디언 목록
	function setAccodianList(jsonData){
		var Html = "";

		$("#accodianList > ul").remove();

		Html = "<ul class='lists'>";

		for(var i=0; i<jsonData.data.length; i++){
			var noticeNo = 	jsonData.data[i]["noticeNo"];
			var codeName = jsonData.data[i]["codeName"];
			var title = jsonData.data[i]["title"];
			var hitCount = jsonData.data[i]["hitCount"];
			var regDatetime2 = jsonData.data[i]["regDatetime2"];
			//var userName = jsonData.data[i]["userName"];
			var userName = "관리자";

			var content = jsonData.data[i]["content"];


			Html += "<li class=''>";
			Html += "<div class='titleArea'  id='noticeNo"+noticeNo+"'>";
			Html += "	<input type='hidden' value='"+noticeNo+"'>";
			Html += "	<span class='category'>["+codeName+"]</span>";
			Html += "	<span class='title'>"+title+"</span>";
			Html += "	<p class='bbs_info'>";
			Html += "	<span class='name'>"+userName+"</span>";

			regDatetime2 = regDatetime2.replace(/\//g, "-");

			Html += "		<i class='ico_bbs_clock'></i><span class='date'>"+regDatetime2+"</span>";
			Html += "	</p>";
// 			Html += "	<span class='hit'><strong>조회수</strong><span>:<em>"+hitCount+"</em></span></span>";
			Html += "</div>";

			Html += "<div class='viewArea'>";
			Html += "	<p>"+content+"</p>";
			Html += "</div>";

			Html += "</li>";

		}
		$("#accodianList").append(Html);

		bbsAccor();


		/* if('${noticeNo}' != '' ){
			$('#noticeNo${noticeNo}').trigger("click");
		} */

		$('#noticeNo${noticeNo}').each(function(){
			if('${noticeNo}' != '' ){

				var eleHeight = $(this).offset().top;
				$('#noticeNo${noticeNo}').trigger("click");
				$('body, html').animate({
					scrollTop : eleHeight - 75
				},300);

			}
		});

	}


 	function moveDetailPage(noticeNo){
		location.href = "${wasPath}/mbr/bbs/notice/view?noticeNo="+noticeNo;
 	}

 	// 조회수 업데이트
 	function updateHitCount(noticeNo){
 		$.ajax({
			url : "${wasPath}/mbr/bbs/notice/updateHitCount",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"noticeNo" : noticeNo
			},
			success : function(data) {
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);
				}else{
					alertBox("code:" + request.status + "\n" + "error:" + error, logout);
				}
			}
		});
 	}


	$(document).ready(function() {

		gridList();
		App.init();

		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsNotice").addClass("active");

	});
</script>

</body>
</html>