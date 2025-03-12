<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="roles" property="principal.roles" />
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
		<div id="content" class="content bbs-download-wrap">

			<p class="page_title">자료실
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/bbs/notice/">사용문의 </a> <span class="arrow_ab"> &#8227; </span> <b><a href="${wasPath}/mbr/bbs/download/">자료실</a> </b>
			    </span>
			</p>
			<!-- begin page-body -->
			<div class="row p20 bgwh br10">

			<div class="cs_visual">
				<div class="left_text"><i class="fa fa-cloud"></i></div>
			    <div class="right_text"><i class="fa fa-download"></i></div>
				<strong>K-Cloud의 자료를 활용해보세요.</strong>
				<p>클라우드의 매뉴얼과 약관, 일반자료들을 활용할 수 있습니다.</p>
			</div>


<!-- 			<div class="col-md-12 br5 p10 mb20 bgee">
				<div style="text-align: center; display:inline-block;">
					<div class="selectBoxAr" style="">
						<label class="selectText" for="searchKind">전체</label>
						<select class="search-sel" id="searchKind">
							<option value="searchAll">전체</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select>
					</div>
					<div class="searchBoxAr" style="">
						<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
						<button type="button" class="btn_search2"  onclick="gridList()"><span></span></button>
					</div>
				</div>
			</div> -->




			<!-- search begin -->
 			<div class="col-md-12 br5 p30 mb20 bgee">
				<div class="selectBoxAr">
					<label class="selectText" for="searchKind">전체</label>
					<select class="search-sel" id="searchKind" onchange="getQnaTypeKind();>
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
							  <div class="select-kepco" id="searchKind" onchange="getQnaTypeKind();">
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


			<!-- Tab -->
				<div class="csCenterTabArea">
					<ul>
						<li class="btn_all on"><a href="javascript:category='';gridList();">전체</a></li>
						<li class="btn_manual"><a href="javascript:category='manual';gridList();">매뉴얼</a></li>
						<li class="btn_policy"><a href="javascript:category='policy';gridList();">약관</a></li>
						<li class="btn_archive"><a href="javascript:category='archive';gridList();">일반자료</a></li>
					</ul>
				</div>


			<!-- 테이블시작 -->
			<div class="col-md-12">

				<div class="csCenterBoard archiveBoard" id="accodianList">

				</div>

			</div>

			<div class="col-md-12">
				<input type="hidden" id="roles" value="${roles}">
				<div class="panel">
				    <div class="table-responsive">
				        <table class="tableV" id="downloadBbsList" summary="자료실">
						 <caption>게시판 목록 : 프로젝트명, 프로젝트 별칭, 고객사명, 프로젝트, 등록일시, 상세로 구성</caption>
							<%-- <colgroup>
						 		<col width="25%">
						 		<col width="25%">
						 		<col width="20%">
						 		<col width="15%">
						 		<col width="15%">
						 		<!-- <col width="10%"> -->
						 	</colgroup>
							<thead>
								<tr class="primary">
									<th class="tac">프로젝트명</th>
								  	<th class="tac">프로젝트 별칭</th>
								  	<th class="tac">고객사명</th>
								  	<th class="tac">프로젝트 PM</th>
								  	<th class="tac">등록일시</th>
								    <!-- <th class="tac" style="border-right:none;">상세보기</th> -->
								</tr>
							</thead> --%>
						</table>
					</div>
				</div>
			</div>
			<!-- 테이블 끝 -->

			</div>
			<!-- end page-body -->

			<!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

var faqFunc = function(){
	$('.csCenterTabArea ul > li a').click(function(){
		$('.csCenterTabArea ul li').removeClass('on');
		$(this).parent().addClass('on');
	});

	$('.csCenterTabArea ul li.btn_all a').click(function(e){
		//e.preventDefault();
		$('.faqList li').fadeOut(50);
		$('.faqList li.btn_all').fadeIn(50);
	});
	$('.csCenterTabArea ul li.btn_manual a').click(function(e){
		//e.preventDefault();
		$('.faqList li').fadeOut(50);
		$('.faqList li.btn_manual').fadeIn(50);
	});
	$('.csCenterTabArea ul li.btn_policy a').click(function(e){
		//e.preventDefault();
		$('.faqList li').fadeOut(50);
		$('.faqList li.btn_policy').fadeIn(50);
	});
	$('.csCenterTabArea ul li.btn_archive a').click(function(e){
		//e.preventDefault();
		$('.faqList li').fadeOut(50);
		$('.faqList li.btn_archive').fadeIn(50);
	});
}
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
				}

				if(checkEle.is('div')) {
					return false;
				} else {
					return true;
				}
			});
		});

	}

	var category = '';
	function gridList() {
		$("#downloadBbsList").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"/mbr/bbs/download/list?category="+category
				,"type" : "GET"
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
			,"initComplete" : function(setting, json){
				$("#downloadBbsList > thead").remove();
				$("#downloadBbsList > tbody").remove();
			}
			,"columns":[
				{"data":"downloadNo" , "class":"tac"}
				//, {"data":"codeName" , "class":"tac"}
				//, {"data":"title" , "class":"tal"}
				//, {"data":"regDatetime2" , "class":"tac"}
				//, {"data":"userName" , "class":"tac", "width":"5%"}
		        //, {"class":"tac", "width":"5%"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
// 				, {"targets":[2], "render": function(data,type,full){
// 					return "<a href='#' onclick='movePageDetail(\""+full.downloadNo+"\")'>" + full.title + "</a>";
// 					}
// 				}
				//, {"targets":[5], "render": function(data,type,full){
				//	return '<button type="button" class="btn btn-grey_01 t-in-3"  onclick="movePageDetail(\''+full.downloadNo+'\')"/><i class="fa fa-search"></i></button>';
				//	}
				//}
			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[5,15], [5, 15]]
			,"language": {
				"zeroRecords":""
				, "processing":""
			}
			,"sDom":'<"top"><"bottom"ip>'
		});

	}

	function movePageDetail(downloadNo){
		var params = "?downloadNo="+downloadNo;

		location.href = "${wasPath}/mbr/bbs/download/view"+params;
	}

	function setAccodianList(jsonData){
		var Html = "";

		$("#accodianList > ul").remove();

		Html = "<ul class='lists'>";

		for(var i=0; i<jsonData.data.length; i++){
			var codeKeyId = jsonData.data[i]["codeKeyId"];
			var codeName = jsonData.data[i]["codeName"];
			var title = jsonData.data[i]["title"];
			var filesCnt = jsonData.data[i]["filesCnt"];
			var regDatetime2 = jsonData.data[i]["regDatetime2"];
			var userName = "관리자";
			//var userName = jsonData.data[i]["userName"];
			var content1 = jsonData.data[i]["content"];

			var content = content1.replace(/(?:\r\n|\r|\n)/g,"<br />");


// 			var fileName = jsonData.data[i]["fileName"];
// 			var filePath = jsonData.data[i]["filePath"];
// 			var fileSize = jsonData.data[i]["fileSize"];
// 			var fileId = jsonData.data[i]["fileId"];
			var fileList = jsonData.data[i]["fileList"];
			var downloadNo = jsonData.data[i]["downloadNo"];


			Html += "<li>";
			Html += 	"<div class='titleArea'>";
			Html += 		"<span class='category'>["+codeName+"]</span>";
			Html +=			"<div class='flex align-center gap10>'"
			Html += 			"<span class='title'>"+title+"</span>";
			if(filesCnt > 0) {
				Html += 		"<i class='ico_file'></i>";
			}
			Html +=			"</div>"
			Html += 		"<p class='bbs_info'>";
			Html += 			"<span class='name'>조회수 : "+downloadNo+"</span>";
			Html += 			"<span class='name'>"+userName+"</span>";

			regDatetime2 = regDatetime2.replace(/\//g, "-");
			Html += 			"<i class='ico_bbs_clock'></i><span class='date'>"+regDatetime2+"</span>";
			Html += 		"</p>";
			Html += 	"</div>";
			Html += 	"<div class='viewArea'>";
			Html += 		"<p style='font-size:18px;color:#666;'>"+content+"</p>";
			if(filesCnt > 0) {
			Html += 		"<div class='fileListBox'>";
			Html += 			"<dl>";
			Html += 				"<dt>첨부파일</dt>";
			Html += 				"<dd>";
			Html += 					"<ul>";
			for(var j=0; j< fileList.length;j++){
				Html += "<li><a href='${wasPath}/mbr/cmm/file/download/"+fileList[j].fileId+"'><span class='filename'>"+fileList[j].fileName+"</span><span class='filesize'>("+fileList[j].fileTranSize+")</span><i class='ico_filedown'></i></a></li>";
			}
			Html += 					"</ul>";
			Html += 				"</dd>";
			Html += 			"</dl>";
			Html += 		"</div>";
			}
			Html += 	"</div>";
			Html += "</li>";
		}

		$("#accodianList").append(Html);

		bbsAccor();
	}

	$(document).ready(function() {
		App.init();
		gridList('ALL');
		faqFunc();
//		bbsAccor();

		//메뉴활성화
		$("#bbs").addClass("active");
		$("#bbsDownload").addClass("active");
	});


</script>

</body>
</html>