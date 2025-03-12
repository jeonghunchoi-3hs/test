<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

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
			
			<p class="page_title">Help Desk
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/bbs/notice/">사용문의 </a> <span class="arrow_ab"> &#8227; </span> <b><a href="${wasPath}/mbr/bbs/qna/">Help Desk</a> </b>
			    </span>
			</p>
			
			<!-- begin page-body -->
			<div class="row p20 bgwh br10">
				
			<div class="cs_visual">
				<div class="left_text"><i class="fa fa-question-circle-o"></i></div>
			    <div class="right_text"><i class="fa fa-commenting-o"></i></div>
				<strong>K-Cloud의 궁금한 점을 물어보세요.</strong>
				<p>문의사항에 대한 답변을 빠르게 해결해 드리도록 하겠습니다.</p>
			</div>
		
			<!-- search begin -->
<!-- 			<div class="col-md-12 br5 p30 mb20 bgee">	
					<div class="selectBoxAr">
						<label class="selectText" for="searchKind">전체</label>
						<select class="search-sel" id="searchKind" onchange="getQnaTypeKind();">
							<option value="searchAll">전체</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select>
					</div>

					<div class="searchBoxAr">
						<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
						<button type="button" class="btn_search2"  onclick="gridList()"><span></span></button>
					</div>
			</div>	 -->
			
		 	<div class="col-md-12 br5 p30 mb20 bgf5 tac">
			 <div class="new-search">
				           <div class="left">
					         <select class="form-control" id="searchKind" onchange="getQnaTypeKind();">
					       		    <option value="searchAll" >전체</option>
									<option value="title">제목</option>
									<option value="content">내용</option>
					         </select>
							</div>
							<div class="right">
	                          <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
	                          <button type="button" class="btn_ser"  onclick="gridList()"><span></span></button>
	                         </div>
             </div>
             </div> 
             
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
             
             
             
             
             
             
			<!-- search end -->	
 			<div class="col-md-12 pl0">
				<a href="javascript:void(0);" class="rbton bton_blue flr mb10" onclick="moveInsertPage('0');"><i class="fa fa-upload"></i> <span> 등록</span></a>
				<!-- Tab -->
				<div class="csCenterTabArea">
					<ul>
						<li class="btn_all on pl0"><a href="javascript:category=''; gridList();">전체</a></li>					
						<c:forEach items="${qnaType}" var="typeCodeList" varStatus="status" >
								<li class="btn_${typeCodeList.codeId }"><a href="javascript:category='${typeCodeList.codeId }'; gridList();">${typeCodeList.codeName }</a></li>
						</c:forEach>		
					</ul>
				</div>
				
				<div class="csCenterBoard qnaBoard" id="accodianList">
				
				</div>
								
			</div>
			
			<!-- 테이블시작 -->
			<div class="col-md-12">
				<div class="panel">
				    <div class="table-responsive">
				        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="qnaBbsList">
							 <colgroup>
								<col width="5%">
								<col width="10%">
								<col width="*">
								<col width="5%">
								<col width="20%">
								<col width="10%">
								<!-- <col width="10%"> --> 
							</colgroup>
							<thead>
							    <tr class="primary">
							        <th class="tac">순번</th>
									<th class="tac">분류</th>
									<th style="text-align:center !important;">제목</th>
									<th class="tac">공개</th>
									<th class="tac">작성일</th>
									<th class="tac">작성자</th>
									<!-- <th class="tac" style="border-right:none;">상세</th> --> 
							    </tr>
							</thead> 
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
	var qnaFunc = function(){
		
		$('.csCenterTabArea ul > li a').click(function(e){
			$(".csCenterTabArea ul > li").removeClass("on");
			
			$(this).parent().addClass('on');
			$('.qnaList li').fadeOut(50);
			
			$(this).parent().fadeIn(50);
		});
		
		$('.csCenterTabArea ul li.btn_all a').click(function(e){
			$('.faqList li').fadeIn(50);
		});
		
	};
	
	function bbsAccor() {
		
		$('.csCenterBoard .lists > li').each(function(){
			
			$(this).children('.titleArea').click(function(e){
				e.preventDefault();
				var checkEle = $(this).next();
				$('.csCenterBoard .lists li').removeClass('active');
				$(this).closest('li').addClass('active');
				
				if((checkEle.is('div')) && (checkEle.is(':visible'))) {
					$(this).closest('li').removeClass('active');
					checkEle.hide();
				}
				
				if((checkEle.is('div')) && (!checkEle.is(':visible'))) {
					$('.csCenterBoard li div.viewArea:visible').hide();
					checkEle.show();
				}
				
				if(checkEle.is('div')) {
					return false;
				} else {
					return true;
				}
			});
		});
		
		
		$('.csCenterBoard .viewArea .qnaContents').has('.btns').addClass('has-btns');
		
		
	}

	var category = "";
	function gridList() {
		 $("#qnaBbsList").dataTable( {
			"processing":true
			,"autoWidth":false
			,"ordering":false
			,"destroy" : true
			,"serverSide":true
			,"ajax": {
				"url":"${wasPath}/mbr/bbs/qna/list?category=" + category
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					/* d.typeCodeKind = $("#typeCodeKind option:selected").val(); */ 
					d.keyword = $("#keyword").val();
					d.userId = "${userId}";
				}
				,"complete" : function(obj, status){
					if(status == 'success'){
						var replayCnt = setAccodianList(obj.responseJSON);		//아코디언 목록 Html 그리는 함수
						/* 목록 하단 미답변 카운트 */
						var regex = /[^0-9]/g;
						var listTotCnt = $("#qnaBbsList_info").text();
						var noReplyCntTotal = obj.responseJSON.noReplyCntTotal;
						listTotCnt = listTotCnt.replace(regex, "");
						$("#qnaBbsList_info").text("총 " + listTotCnt + " 건 / 미답변 " + noReplyCntTotal + " 건");
						qnaFunc();
					}
				}

			}
		 	, "initComplete" : function(setting, json){
				$("#qnaBbsList > thead").remove();
				$("#qnaBbsList > tbody").remove();
			}
			,"columns":[ 
			        	{"data":"qnaNo","class":"tac"}
 			        	, {"data":"codeName", "class":"tac"}
 			        	, {"data":"title", "class":"tal"}
 			        	, {"data":"secretFlag", "class":"tac"}
 			        	, {"data":"regDatetime2", "class":"tac"}
 			        	, {"data":"userName", "class":"tac"}
	        	        , {"class":"ditailStyle tac"}
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
			,"sDom":'<"top"><"bottom"ip>'
		});
		
	}

	
	//아코디언 목록
	function setAccodianList(jsonData){
		var Html = "";
		
		$("#accodianList > ul").remove();
		
		Html = "<ul class='lists'>";
		
		for(var i=0; i<jsonData.data.length; i++){
			
			var qnaNo = jsonData.data[i]["qnaNo"];
			var codeName = jsonData.data[i]["codeName"];
			var title = jsonData.data[i]["title"];
			var secretFlag = jsonData.data[i]["secretFlag"];
			var regDatetime2 = jsonData.data[i]["regDatetime2"];
			var userName = jsonData.data[i]["userName"];
			var regUserId = jsonData.data[i]["regUserId"];
			var content1 = jsonData.data[i]["content"];
			
			var content = content1.replace(/(?:\r\n|\r|\n)/g,"<br />")

			var replyCnt = jsonData.data[i]["replyCnt"];
			var parentQnaNo = jsonData.data[i]["parentQnaNo"];
			
			var reQnaNo = jsonData.data[i]["reQnaNo"];
			var reRegDatetime2 = jsonData.data[i]["reRegDatetime2"];
			var reUserName = jsonData.data[i]["reUserName"];
			//var reUserName = "관리자";
			var reRegUserId = jsonData.data[i]["reRegUserId"];
			
	        var reContent1 = jsonData.data[i]["reContent"];
	        if(reContent1 != undefined){
				var reContent = reContent1.replace(/(?:\r\n|\r|\n)/g,"<br />");
	        }
			
			
			Html += "<li>";
			
			Html += "<div class='titleArea' id='qnaNo"+qnaNo+"'>";
			Html += "	<input type='hidden' value='"+qnaNo+"'>";
			Html += "	<span class='category'>["+codeName+"]</span>";
			Html += "	<span class='title'>"+title+"</span>";
			
			// 비밀글 여부
			if(secretFlag=="Y"){
				Html += "	<i class='ico_lock'></i>";
			}

			// 답변 여부
			if(replyCnt != "0"){
				Html += "	<span class='answerY'>답변완료</span>";
			}else{
				Html += "	<span class='answerN'>미답변</span>";
			}

			Html += "	<p class='bbs_info flr'>";
			Html += "<span class='name'>"+userName+"</span>";
			
			regDatetime2 = regDatetime2.replace(/\//g, "-");
			
			Html += "<i class='ico_bbs_clock'></i><span class='date'>"+regDatetime2+"</span>";
			Html += "	</p>";
			
			
			Html += "</div>";	//end titleArea
			
			Html += "<div class='viewArea'>";
			Html += "	<div class='qnaContents'>";
			Html += "		<div class='text'>";
			Html += "			<p>"+content+"</p>";
			Html += "		</div>";
			
			// 작성자 본인 여부
			//if(regUserId == "${userId}"){
			//관리자만 수정가능하도록 수정
			if("${userId}" == "admin"){
				Html += "		<div class='btns'>";
				Html += "			<a href='javascript:void(0);' class='bton-s bton_blue' onclick='moveInsertPage(\""+qnaNo+"\");'><i class='fa fa-pencil f14'></i> 수정</a>";
				Html += "			<a href='javascript:void(0);' class='bton-s bton_orange' onclick='delChk(\""+qnaNo+"\");'><i class='fa fa-trash f14'></i> 삭제</a>";
				Html += "		</div>";
			} 
			
			
			Html += "	</div>";	//end qnaContents 
			
			// 답변 여부
			if(replyCnt != "0"){
// 				Html += "	<span class='answerY'>답변완료</span>";
				Html += "	<div class='qnaAnswer'>";
				Html += "		<span class='label'>답변</span>";
				Html += "		<p class='answer_info'>";
				Html += "			<span class='name'>"+reUserName+"</span>";
				
				reRegDatetime2 = reRegDatetime2.replace(/\//g, "-");
				
				Html += "			<span class='date'>"+reRegDatetime2+"</span>";
				Html += "		</p>";
				Html += "		<div class='text'>"+reContent+"</div>";
				Html += "	</div>";
			}
			
			Html += "</div>";	//end viewArea
			
			Html += "</li>";
			
		}
		Html += "</ul>";
		
		$("#accodianList").append(Html);
		
		bbsAccor();
		
	/* 	if('${qnaNo}' != '' ){
			$('#qnaNo${qnaNo}').trigger("click");
		} */
		
		$('#qnaNo${qnaNo}').each(function(){
			if('${qnaNo}' != '' ){
				
				var eleHeight = $(this).offset().top;
				$('#qnaNo${qnaNo}').trigger("click");
				$('body, html').animate({
					scrollTop : eleHeight - 75
				},300);
				
			}
		});
		
			
		var eleBox = $('#qnaNo${qnaNo}').next().height();
	
	}
 
	/* 검색 옵션 변경시 목록 다시 불러오기 */
	function getQnaTypeKind(){
		gridList();
	} 
 
 	function moveDetailPage(qnaNo){
		location.href = "${wasPath}/mbr/bbs/qna/view?qnaNo="+qnaNo;
 	}
 	
 	function moveInsertPage(qnaNo){
 		location.href = "${wasPath}/mbr/bbs/qna/write?qnaNo="+qnaNo;
 	}
 	
 	function delChk(qnaNo){
 		confirmBox2("삭제하시겠습니까?", deleteBbsQna, qnaNo);
 	}
 	
 	function deleteBbsQna(qnaNo){
 		$.ajax({
			url : "${wasPath}/mbr/bbs/qna/delete",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"qnaNo" : qnaNo
			},
			success : function(data) {
				alertBox("삭제되었습니다.", gridList);
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
		$("#bbsQna").addClass("active");
		
	});

</script>

</body>
</html>