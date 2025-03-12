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

				<p class="page_title">프로젝트 승인 현황
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/req/project/projectList.do"> 프로젝트 </a> <span class="arrow_ab"> &#8227; </span>  <b> 프로젝트 승인 현황 </b>
			    </span>
				</p>

				<!-- begin page-body -->
				<div class="row p20 bgwh br10">


				<div class="explain_box">
					<!-- <p class="icon"><img src="/resources/assets/img/icon_mic.png" /></p> -->
					<p class="text"> &#183; 프로젝트는 업무 시스템을 의미하며, 프로젝트 신청 이후 시스템 자원(가상 서버, 블록 디스크)을 사용할 수 있습니다. <br/>
					&#183; 프로젝트별 설정된 쿼터(Quota)에서만 시스템 자원(가상 서버, 블록 디스크)을 생성할 수 있으며 생성된 시스템 자원(가상 서버, 블록 디스크)은 논리적으로 완벽히 분리되어 운영됩니다.</p>
					
					<div class="searchBoxArea width-150 dpin flr mt30">
					     <label class="selectBoxDrop" for="">전체</label>
						  <select class="search-sel" name="projectAt"  id="projectAt" onchange="gridList();">         
							<option value="searchAll">전체</option>
						    <option value="02">진행중</option>	
						    <option value="03">반려</option>	
						    <option value="04">완료됨</option>	
						    
						  </select>
					</div>
				</div>


				<!-- color01, color02, color03, color04, color05 클래스 랜덤 적용 -->
				<div class="card_contents_wrap" id="cardList">
				</div>

				<!-- 기존파일 -->
				<!-- 테이블시작 -->
				<div class="col-md-12">
					<input type="hidden" id="roles" value="${roles}">
					<div class="panel">
					    <div class="table-responsive">
					        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="mbrProjectOkList">


							</table>
						</div>
					</div>
				</div>
				<!-- // 기존파일 -->

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

		function gridList() {

			$("#mbrProjectOkList").dataTable( {
	// 		$("#cardList").dataTable( {
					"processing":true
					,"ordering" : true
					,"destroy" : true
					,"autoWidth":false
					,"serverSide":true
				,"ajax": {
					"url":"${wasPath}/mbr/req/project/projectApproveList"
					,"type" : "GET"
					,"dateSrc" : ""
					,"data":function (d) {
						d.searchKind = $("#searchKind > option:selected").val();
						d.keyword = $("#keyword").val();
						d.projectAt = $("#projectAt > option:selected").val();

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
				        	//{"data":"projectName", "class":"tac"}
				        	 {"data":"customerName","class":"tac"}
							, {"data":"projectAlias", "class":"tac"}
				        	, {"data":"regUserName","class":"tac"}
				        	, {"data":"regDatetime2","class":"tac"}
				        	//, {"class":"ditailStyle tac"}
				]
				,"columnDefs":[
					{"defaultContent" : "", targets:"_all" }
					//, {"targets":[0], "render": function(data,type,full){
					//	return "<a href='#' onclick='moveDetailPage(\""+full.projectId+"\")'>" + full.projectName + "</a>";
					//	}
					//}
	// 				, {"targets":[1], "render": function(data,type,full){
	// 					return "<a href='#' onclick='moveDetailPage(\""+full.reqProjectSeq+"\")'>" + full.projectAlias + "</a>";
	// 					}
	// 				}
					//, {"targets":[4], "render": function(data,type,full){
					//	return "<button type='button' class='btn btn-grey_01' onclick='moveDetailPage(\""+full.projectId+"\")' ><i class='fa fa-search'></i></button>";
					//	}
					//}
				]
				,"order": [[3,"desc"]]
				,"lengthMenu": [12]
				,"language": {
					"zeroRecords":""
					, "processing":""
				}
				,"sDom":'<"top"><"bottom"ip>'
			});
		}

		function moveDetailPage(reqProjectSeq){
			location.href = "${wasPath}/mbr/req/project/projectApproveView.do?reqProjectSeq="+reqProjectSeq;
		}

		function setCardList(jsonData){
			var Html = "";

			$("#cardList > div").remove();

			var k = 1;

			for(var i=0; i<jsonData.data.length; i++){
				var projectAlias = 	jsonData.data[i]["projectAlias"];
				var customerName = jsonData.data[i]["customerName"];
				var deptName = jsonData.data[i]["deptName"];
				var regUserName = jsonData.data[i]["regUserName"];
				var regDatetime = jsonData.data[i]["regDatetime2"];
				var reqProjectSeq = jsonData.data[i]["reqProjectSeq"];
				var statusFlag = jsonData.data[i]["statusFlag"];
				var cloudName = jsonData.data[i]["cloudName"];
				var projectId = jsonData.data[i]["projectId"];
				var projectName = jsonData.data[i]["projectName"];


				if(k%5==0){
					k = 1;
				}

				if(i%4==0){
				//	Html += "<div class='card_list_row'>";
					Html += 	"<div class='col-md-3 card_list_p color0"+k+"'>";
				}else{
					Html += 	"<div class='col-md-3 card_list_p color0"+k+"'>";
				}

				Html +=			"<a href='${wasPath}/mbr/req/project/projectApproveView.do?reqProjectSeq="+reqProjectSeq+"'>";
			//	Html +=				"<span class='basic_info'>";

	            if(statusFlag =='01'){
	    			Html +=				"<li><span class='process_write mr10'>작성중</span></li>";


	            }else if(statusFlag =='02'){
	    			Html +=				"<li><span class='process_ing mr10'>진행중</span></li>";


	            }else if(statusFlag =='03'){
	    			Html +=				"<li><span class='process_re mr10'>반려</span></li>";


	            }else if(statusFlag =='04'){
	    			Html +=				"<li><span class='process_fix mr10'>처리완료</span></li>";


	            }
	            
	            Html +=					"<li class='project_name'>"+projectAlias+"</li>";

			//	Html +=				"</span>";
				Html +=				"<li class='name'>"+customerName +" <span>("+regUserName+")</span></li>";

				regDatetime = regDatetime.replace(/\//g, "-");

				Html +=				"<span class='date'><span class='date_text'>"+regDatetime +"</span></span>";
				Html +=			"</a>";
		//		Html +=			"<span class='color_btm'></span>";
				Html += 	"</div>";

				if(i%4==0){
			//		Html += "</div>";
				}

				k++;

			}
			$("#cardList").append(Html);

		}

			function moveInsertPage(){

				if("${isPM}" == "true"){
					location.href="${wasPath}/mbr/req/project/projectInsert.do";
				}else{
					alertBox3("프로젝트 신청권한이 없습니다.");
				}
			}

			$(document).ready(function(){
				//alert("키보드입력");
				 App.init();
				 gridList();

				// select box text 설정
				$(".search-sel").change(function() {
					$(this).siblings(".selectText").text($(this).children('option:selected').text());
				});

				//메뉴활성화
				$("#reqStatus").addClass("active");
			 	$("#projectApproveList").addClass("active");

			});
		</script>
	</body>
</html>
