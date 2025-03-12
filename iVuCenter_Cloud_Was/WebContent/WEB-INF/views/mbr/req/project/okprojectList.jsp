<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
</sec:authorize>
<sec:authorize var="isPM" access="hasRole('ROLE_CUSTOM_PM')" />

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


				<p class="page_title">프로젝트 현황(신청)
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 프로젝트  <span class="arrow_ab"> &#8227; </span> <b><a href="${wasPath}/mbr/req/project/okprojectList.do">프로젝트 현황(신청)</a> </b>
			    </span>
				</p>

				<!-- begin page-body -->
				<div class="row p20 bgwh br10">

				<!-- search begin -->
			<!-- <div class="col-md-12 br5 p30 mb20 bgee">
						<div class="selectBoxAr">
							<label class="selectText" for="searchKind">전체 </label>
							<select class="search-sel" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="projectAlias">프로젝트명</option>
								<option value="projectName">프로젝트 ID</option>
							</select>
						</div>
						<div class="searchBoxAr">
							<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
							<button type="button" class="btn_search2"  onclick="gridList()"><span></span></button>
						</div> -->

					<div class="col-md-12 br5 p30 mb20 bgee">
						<div class="selectBoxAr">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="project_ name">프로젝트ID</option>
								<option value="project_alias">프로젝트명</option>
							</select>
						</div>
						<div class="search-box">
							<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
							<button type="button" class="btn_search2"  onclick="gridList()"><span></span></button>
						</div>
					</div>
					<!-- search end -->




				<div class="explain_box">
					<!-- <p class="icon"><img src="/resources/assets/img/icon_mic.png" /></p> -->
					<p class="text"> &#183; 프로젝트는 업무 시스템을 의미하며, 프로젝트 신청 이후 시스템 자원(가상 서버, 블록 디스크)을 사용할 수 있습니다. <br/>&#183; 프로젝트별 설정된 쿼터(Quota)에서만 시스템 자원(가상 서버, 블록 디스크)을 생성할 수 있으며 생성된 시스템 자원(가상 서버, 블록 디스크)은 논리적으로 완벽히 분리되어 운영됩니다.</p>
					<div class="flr pt20">
						<button class="btn_navy"  onclick="moveInsertPage()"> 신청하기  </button>
					</div>
				</div>
				<div class="card_contents_wrap" id="cardList">

				</div>
				<!-- 기존파일 -->
				<!-- 테이블시작 -->
				<div class="col-md-12">
					<input type="hidden" id="roles" value="${roles}">
					<div class="panel">
					    <div class="table-responsive">
					        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="mbrProjectOkList" summary="프로젝트 목록">
								<caption>게시판 목록 : 프로젝트명, 프로젝트 별칭, 고객사명, 프로젝트, 등록일시로 구성</caption>
									<colgroup>
							 		<col width="25%" >
							 		<col width="25%">
						 		    <col width="20%">
							 		<col width="15%">
							 		<col width="15%">
							 	</colgroup>
								<thead>
									<tr>
										<th>프로젝트명</th>
									  	<th>프로젝트 별칭</th>
									  	<th>고객사명</th>
									  	<th>프로젝트 PM</th>
									  	<th>등록일시</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
				<!-- 테이블 끝 -->
				</div>

				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

			</div>
			<!-- end #content -->

		</div>
		<!-- end page container -->

	<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
	<script type="text/javascript">

	    function cloudSearchId(cloudId){
			$("#cloudSearchId").val(cloudId);
	    gridList();
	   }

	       function gridList() {
			$("#mbrProjectOkList").dataTable( {
					"processing":true
					,"ordering" : true
					,"destroy" : true
					,"autoWidth":false
					,"serverSide":true
				,"ajax": {
					"url":"${wasPath}/mbr/req/project/projectOkList"
					,"type" : "GET"
					,"dateSrc" : ""
					,"data":function (d) {
						//d.searchKind = $("#searchKind > option:selected").val();
						d.searchKind = $("#searchKind").val();
						d.keyword = $("#keyword").val();
					}
					,"complete" : function(obj, status){
						if(status == 'success'){
							setCardList(obj.responseJSON);
						}
					}

				}
				, "initComplete" : function(setting, json){
					$("#mbrProjectOkList > thead").remove();
					$("#mbrProjectOkList > tbody").remove();
				}
				,"columns":[
				        	{"data":"projectName", "class":"tac"}
							, {"data":"projectAlias", "class":"tac"}
				        	, {"data":"customerName","class":"tac"}
				        	, {"data":"projectManagerName","class":"tac"}
				        	, {"data":"regDatetime2","class":"tac"}
				        	, {"data":"cloudName","class":"tac"}
				]
				,"columnDefs":[
					{"defaultContent" : "", targets:"_all" }
	// 				, {"targets":[0], "render": function(data,type,full){
	// 					return "<a href='#' onclick='moveDetailPage(\""+full.projectId+"\")'>" + full.projectName + "</a>";
	// 					}
	// 				}
	// 				, {"targets":[1], "render": function(data,type,full){
	// 					return "<a href='#' onclick='moveDetailPage(\""+full.projectId+"\")'>" + full.projectAlias + "</a>";
	// 					}
	// 				}
					//, {"targets":[5], "render": function(data,type,full){
					//	return "<button type='button' class='btn btn-grey_01' onclick='moveDetailPage(\""+full.projectId+"\")' ><i class='fa fa-search'></i></button>";
					//	}
					//}
				]
				,"order": [[4,"desc"]]
				,"lengthMenu": [12]
				,"language": {
					"zeroRecords":""
					, "processing":""
				}
	//			,"sDom":'<"top"><"bottom"ip>'
				,"sDom":'<"bottom"p>'
				,"oTableTools": {
					"aButtons":[ {
						"sExtends":"text"
						,"sButtonText":"신청"
						,"fnClick":function(nButton,oConfig,oFlash) {
							//PM일 경우에만 프로젝트 생성
							//if("${isPM}" == "true"){
								location.href="${wasPath}/mbr/req/project/projectInsert.do";
							//}else{
							//	errorBox("프로젝트 신청권한이 없습니다.");
							//}
						}
					}]
				}
			});
		}

// 		function moveDetailPage(projectId){
// 			location.href = "${wasPath}/mbr/req/project/okprojectView.do?projectId="+projectId;
// 		}


		function moveInsertPage(){

			//if("${isPM}" == "true"){
				location.href="${wasPath}/mbr/req/project/projectInsert.do";
			//}else{
			//	alertBox3("프로젝트 신청권한이 없습니다.");
			//}
		}

		function setCardList(jsonData){
			var Html = "";

			$("#cardList > div").remove();

			var k = 1;

			for(var i=0; i<jsonData.data.length; i++){
				var projectAlias = 	jsonData.data[i]["projectAlias"];
				var customerName = jsonData.data[i]["customerName"];
				var regUserName = jsonData.data[i]["projectAdminiStratorName"];
				var regDatetime = jsonData.data[i]["regDatetime2"];
				var reqProjectSeq = jsonData.data[i]["reqProjectSeq"];
				var projectBoxId = jsonData.data[i]["projectBoxId"];
				var projectName = jsonData.data[i]["projectName"];
				var projectManagerDeptName = jsonData.data[i]["projectAdminiStratorDeptName"];

				var strlen = projectAlias.length;
				var maxlen = 17;
				var byteCnt = 0;
				var oneChar = "";
				var n = 0;
				var lenSubstr = "";
				var resStr1 = "";
				var resStr2 = "";

				for(n=0; n < strlen; n++){
					oneChar = projectAlias.charAt(n);

					if(escape(oneChar).length > 4){
						byteCnt +=2;
					}else{
						byteCnt++;
					}

					if(byteCnt <= maxlen){
						lenSubstr = n + 1;
					}
				}
				if(byteCnt > maxlen){
					resStr1 = projectAlias.substr(0, lenSubstr);
					resStr2 = projectAlias.substr(lenSubstr, strlen+1);
				}


				if(k%6==0){
					k = 1;
				}

				if(i%4==0){
					Html += 	"<div class='col-md-3 card_list_p color0"+k+"'>";
				}else{
					Html += 	"<div class='col-md-3 card_list_p color0"+k+"'>";
				}

				Html +=			"<a href='${wasPath}/mbr/req/project/okprojectView.do?projectBoxId="+projectBoxId+"' class='code'>";
				Html +=					"<li class='code'>"+projectName+"</li>";
				if(byteCnt > maxlen){
					Html +=					"<li class='project_name'>"+resStr1+resStr2+"</li>";
				}else{
					Html +=					"<li class='project_name'>"+projectAlias+"</li>";
				}


/* 				Html +=				"<li class='name'>"+projectManagerDeptName+"</li>";
				Html +=				"<li class='name'>"+customerName +" <span>("+regUserName+")</span></li>"; */

				Html +=				"<li class='name'>"+projectManagerDeptName+" / "+customerName +" <span>("+regUserName+")</span></li>";


				regDatetime = regDatetime.replace(/\//g, "-");

				Html +=				"<span class='date'><span class='date_text'>"+regDatetime +"</span></span>";
				Html +=			"</a>";
//				Html +=			"<span class='color_btm'></span>";
				Html += 	"</div>";

				if(i%4==0){
				}

				k++;

			}
			$("#cardList").append(Html);

		}

		$(document).ready(function(){
			 App.init();
			 gridList();

			//메뉴활성화
			$("#project").addClass("active");
		 	$("#projectList").addClass("active");

		 	$("#searchKind").val("searchAll");

		});




		const label = document.querySelector('.kep-label');
		const options = document.querySelectorAll('.optionItem');
		const handleSelect = function(item) {
		  label.innerHTML = item.innerText;
		  label.parentNode.classList.remove('active');
		  document.querySelector("#searchKind").value = item.getAttribute("value");
		}
		for( let i = 0; i < options.length; i++ ){
		  options[i].addEventListener('click', function(){handleSelect(this)})
		}

		label.addEventListener('click', function(){
		  if(label.parentNode.classList.contains('active')) {
		    label.parentNode.classList.remove('active');
		  } else {
		    label.parentNode.classList.add('active');
		  }
		});





		</script>
	</body>
</html>
