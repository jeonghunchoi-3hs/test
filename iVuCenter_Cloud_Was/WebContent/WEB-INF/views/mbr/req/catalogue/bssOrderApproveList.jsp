<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" 	property="principal.username" />
	<sec:authentication var="userName" 	property="principal.nickname"/>
	<sec:authentication var="roles" 	property="principal.roles"/>
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
			<div id="content" class="content">
				<p class="page_title">자원 승인 현황
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> <b>자원 승인 현황 </b>
			    </span>
			    </p>
				
				<!-- begin #content page-body -->
				<div class="row p20 bgwh br10">		

				
					<!-- 검색 박스 begin-->
					<!--  검색이 문서에 없음  style 로 display:none 해놓은 것임!!   -->
					<div class="col-md-12 br5 p10 mb45 bgee" style="display:none !important;">	
						<div class="search_date dpin">
							<div class="dateBox">
								<input type="text" value="" id="startDate" readonly="readonly">
								<button type="button" class="btn_calendar"><span></span></button>
							</div>
							<span class="fc99"> ─ </span>
							<div class="dateBox ml5">
								<input type="text" value="" id="endDate" readonly="readonly">
								<button type="button" class="btn_calendar"><span></span></button>
							</div>
						</div>
					
						<div class="searchBox_type2 mb10 dpin tac ml20">	
							<div class="selectBoxAr width-140">
								<label class="selectText" for="searchKind">전체</label>
									<select class="search-sel" id="searchKind">
										<option value="searchAll">전체</option>
										<option value="orderNo">신청번호</option>
										<option value="projectAlias">프로젝트 명</option>
									</select>
							</div>
							<div class="searchBoxAr">
								<input type="text" class="search-text width-450" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)dateChk();"/>
								<button type="button" class="btn_search2"  onclick="dateChk();" style="right:0;"><span></span></button>
							</div>
						</div>
						
					</div>	
					<!-- 검색박스 end -->	
				

					
					<!-- 자원신청 현황 데이터 카드 begin-->
					<!-- 클래스 정의 .st_ing : 승인대기중, .st_rej : 승인반려, .st_wating : 승인대기, .st_confirm : 승인완료 -->	
					<div class="card_contents_wrap board_pdApp" id="cardList"></div>
					<!-- 자원신청 현황 데이터 카드 end-->
					
					<!-- 기존파일 -->	
					<!-- 테이블시작 -->
					<div class="col-md-12">
						<input type="hidden" id="roles" value="${roles}">
						<div class="panel">
						    <div class="table-responsive">
						        <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="mbrProjectOkList">
									<%-- <colgroup>						 		
								 		<col width="30%">
								 		<col width="30%">
								 		<col width="20%">
								 		<col width="20%">
								 		<!-- <col width="10%"> --> 
								 	</colgroup>
									<thead>
										<tr class="primary">
											<th class="tac">고객사</th>									
										  	<th class="tac">프로젝트명</th>								  	
										  	<th class="tac">신청자</th>
										  	<th class="tac">신청일시</th>
										</tr>
									</thead> --%>
								</table>
							</div>
						</div>			
					</div>
					<!-- // 기존파일 -->
				</div>
				<!-- end #content page-body -->
				
				<!-- begin #content footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #content footer -->
			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->
		
		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
	
		<script type="text/javascript">
			
			function gridList() {
				
				
			 	$("#mbrProjectOkList").dataTable( { 
					"processing":true
					,"ordering" : true
					,"destroy" : true
					,"autoWidth":false
					,"serverSide":true
					,"ajax": {
						"url":"${wasPath}/mbr/req/catalogue/bssOrderApproveStatusList"
						,"type" : "GET"
						,"dateSrc" : ""
						,"data":function (d) {
						
							
							d.userId = "${userId}";
							d.searchKind = $("#searchKind > option:selected").val();
							d.keyword = $("#keyword").val();
							/*	d.startDt = $("#startDate").val()+" 00:00:00";*/
							/*  d.endDt = $("#endDate").val()+" 23:59:59"; */
						}
						,"complete" : function(obj, status){
							if(status == 'success'){
								setCardList(obj.responseJSON);
								getStatusCnt();
								
								/*  if($("#startDate").val()=="" && $("#endDate").val()==""){
									$("#searchPeriod").text("");
									$("#searchPeriod").text("전체 기간 데이터입니다.");
								}else if($("#startDate").val()!="" && $("#endDate").val()==""){
									$("#searchPeriod").text("");
									$("#searchPeriod").text($("#startDate").val() + " 이후 데이터입니다.");
								}else if($("#startDate").val()=="" && $("#endDate").val()!=""){
									$("#searchPeriod").text("");
									$("#searchPeriod").text($("#endDate").val() + " 이전 데이터입니다.");
								}else if($("#startDate").val()!="" && $("#endDate").val()!=""){
									$("#searchPeriod").text("");
									$("#searchPeriod").text($("#startDate").val() +" ~ "+ $("#endDate").val() +" 데이터입니다.");
								}*/
							}
						}
					}
				 	, "initComplete" : function(setting, json){
						$("#mbrProjectOkList > thead").remove();
						$("#mbrProjectOkList > tbody").remove();
					}
					,"columns":[
								{"data":"orderNo", "class":"tac", "width":"10%"}
								, {"data":"projectName","class":"tal"}
								, {"data":"apprvStateName","class":"tac", "width":"23%"}
								, {"data":"newCnt","class":"tac", "width":"5%"}
								, {"data":"changeCnt","class":"tac", "width":"5%"}
								, {"data":"exprCnt","class":"tac", "width":"5%"}
					        	, {"data":"amount", "class":"tar pl10 fcb", "width":"10%"}
					        	, {"data":"orderDatetime", "class":"tac", "width":"14%"}
					        	, {"data":"orderUserName", "class":"tac", "width":"6%"}
					        	//, {"defaultContent":"<button class='btn btn-grey_01' onclick='moveDetailPage()' ><i class='fa fa-search'></i></button>", "class":"ditailStyle tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
					]
					,"order": [[0,"desc"]]
					,"lengthMenu": [12]
					,"language": { 
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
							, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
					}
					,"sDom":'<"top"><"bottom"ip>'
				});
			 	
			 
			}
			
			function dateChk(){
				var startDt = removeSpeDel($("#startDate").val());
				var endDt = removeSpeDel($("#endDate").val());
				
				if(startDt > endDt){
					alertBox3("조회시작일은 조회종료일 <br>이전이어야 합니다.");
					return false;
				}
				gridList();
			}
			
			
			function moveDetailPage(orderNo){
				location.href = "${wasPath}/mbr/req/catalogue/bssOrderApproveView?orderNo="+orderNo;
			}
			
			function setCardList(jsonData) {
				var Html = "";
				$("#cardList > div").remove();
				var k = 1;
			
				for(var i=0; i<jsonData.data.length; i++){
					var projectName = jsonData.data[i]["projectName"];
					var customerName = jsonData.data[i]["customerName"];
					var orderUserDeptName = jsonData.data[i]["orderUserDeptName"];
					var projectId = jsonData.data[i]["projectId"];
					var stepLevel = jsonData.data[i]["stepLevel"];
					var apprvState = jsonData.data[i]["apprvState"];
					var apprvStateName = jsonData.data[i]["apprvStateName"];
					var newCnt = jsonData.data[i]["newCnt"];
					var changeCnt = jsonData.data[i]["changeCnt"];
					var exprCnt = jsonData.data[i]["exprCnt"];
					var orderNo = jsonData.data[i]["orderNo"];
					var amount = jsonData.data[i]["amount"];
					var orderUserName = jsonData.data[i]["orderUserName"];
					var orderDatetime = jsonData.data[i]["orderDatetime"];
					var levelStr = "";
					var colorSetting = "";
					/* 
					var exceptBr = projectName.split(" <br> ");
					
					
					var namelen = exceptBr.length;
					var namelen = exceptBr[1];
					var projectNameBr = "";
					 
					if(namelen > 10){
						projectNameBr = exceptBr[1].substring(0, 11) + "<br/>";
						projectNameBr += exceptBr[1].substring(11, namelen+1);
					}else{
						projectNameBr = exceptBr[1];
					}
					
					 */
					if(apprvStateName == "승인 완료") {
						colorSetting = " st_confirm";
					}else if(apprvStateName == "승인 반려") {
						colorSetting = " st_rej";
					}else if(apprvStateName == "승인 대기") {
						colorSetting = " st_waiting";
					}else if(apprvStateName == "승인 처리중") {
						colorSetting = " st_ing";
					}
					
					if(k%6==0){
						k = 1;
					}
					
					if(i%6==0){
	//					Html += "<div class='card_list_row'>";
						Html += 	"<div class='col-md-3 card_list_p color0"+k+colorSetting+"'>";
					}else{
						Html += 	"<div class='col-md-3 card_list_p color0"+k+colorSetting+"'>";
					}
					Html +=			"<a href='${wasPath}/mbr/req/catalogue/bssOrderApproveView?orderNo="+orderNo+"&projectId="+projectId+"'>";
					//Html +=				"<span class='p_code nanumR'>"+orderNo+"</span>";
					//Html +=				"<span class='basic_info'>";
				
					
					if(amount == undefined){ amount = "0"; }
					
/* 					if(apprvState =='APPRV_WAITING'){
		    			Html +=				"<li class='code_c'><i class='fa fa-pencil f30 fc_blue'></i></li>";    
		    			//Html +=				"<li class='db center f14 fb tac pt10'>작성중</li>";
		    			Html +=				"<li class='db center f14 fb tac pt10 mb20'>진행중</li";	    			
		    			
					}else if(apprvState =='APPRV_REJECTED'){
		    			Html +=				"<li class='code_c'><i class='fa fa-reply f30 fc_red'></i></li>";     
		    			Html +=				"<li class='db center f16 fb tac pt10 mb20'>반려</li>";
		            }else if(apprvState =='APPRV_COMPLETED'){
		    			Html +=				"<li class='code_c'><i class='fa fa-check-square-o f30 fc_violet'></i></li>";   
		    			Html +=				"<li class='db center f16 fb tac pt10 mb20'>처리완료</li>";
		            } else {
		    			Html +=				"<li class='code_c'><i class='fa fa-hourglass-2 f30 fc_green'></i></li>";  
		    			Html +=				"<li class='db center f16 fb tac pt10 mb20'>진행중</li>";
		            }    2023 이전 파일 */

		            
					if(apprvState =='APPRV_WAITING'){   
		    			Html +=				"<li><span class='process_ing mr10'>진행중</span></li>";
		    				
					}else if(apprvState =='APPRV_REJECTED'){    
		    			Html +=				"<li><span class='process_re mr10'>반려</span></li>";
		    			
		            }else if(apprvState =='APPRV_COMPLETED'){  
		    			Html +=				"<li><span class='process_fix mr10'>처리완료</span></li>";
		    			
		            } else {
		    			Html +=				"<li><span class='process_ing mr10'>진행중</span></li>";
		            }

		            
					Html +=					"<li class='project_name'>"+projectName+"</li>";
				//	Html +=				"</span>";
				 	//Html +=				"<span class='p_stage'><em></em>"+levelStr+" "+apprvStateName+"</span>";
				 	Html +=				"<div>";
				    Html +=				"<span class='fc11 f16 mr10'>신청 : <span class='fc_dblue fb'>"+ newCnt +"</span></span>" + "<span class='fc11 f16 mr10'>변경 : <span class='fc-green fb'>"+ changeCnt +"</span></span>" + "<span class='fc11 f16'>삭제 : <span class='fc-orange fb'>"+exprCnt+"</span></span>";
				    Html +=				"</div>";
			   //   Html +=				"<li class='name mt10'>"+customerName+" </li>";
			   //	Html +=				"<li class='name'>"+orderUserDeptName+" <span>("+orderUserName+")</span></li>";
					Html +=				"<li class='name mt20'>"+customerName+"/ "+orderUserDeptName+ " <span>("+orderUserName+")</span></li>";
					
					orderDatetime = orderDatetime.replace(/\//g, "-");
					
					Html +=				"<span class='date'><span class='date_text'>"+orderDatetime +"</span></span>";
					Html +=			"</a>";
				//	Html +=			"<span class='color_btm'></span>";
					Html += 	"</div>";
					
					if(i%6==0){
			//			Html += "</div>";
					}
					k++;
				}
				$("#cardList").append(Html);
			}
			
			function getStatusCnt() {
			
				
				$.ajax({
					url : "${wasPath}/mbr/req/catalogue/bssOrderApproveStatusCnt",
					dataType : "JSON",
					data : {
						"userId" : "${userId}"
						, "searchKind" : $("#searchKind > option:selected").val()
						, "keyword" : $("#keyword").val()
			// 			, "startDt" : "20170801"
			// 			, "endDt" : "20171030"		
			//			, "startDt" : $("#startDate").val()+" 00:00:00"
			//			, "endDt" : $("#endDate").val()+" 23:59:59"
					},
					success : function(data) {
						
						var newCnt = data.newCnt;
						var changeCnt = data.changeCnt;
						var exprCnt = data.exprCnt;
						
						$("#newProductCnt").text(newCnt);
						$("#changeProductCnt").text(changeCnt);
						$("#exprProductCnt").text(exprCnt);
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
			
			function calendar() {
				var dayName = ['일','월','화','수','목','금','토'];
				var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

				$("#startDate").datepicker({
					showOn:"both",
					//buttonImage:"${apachePath}/resources/assets/img/calen.png",
					buttonImageOnly:false,
					dateFormat : "yy-mm-dd",
					dayNamesMin:dayName,
					monthNamesShort:monthName,
					changeMonth:true
					, maxDate:0
				});
			
				$("#endDate").datepicker({
					showOn:"both",
					//buttonImage:"${apachePath}/resources/assets/img/calen.png",
					buttonImageOnly:false,
					dateFormat:"yy-mm-dd",
					dayNamesMin:dayName,
					monthNamesShort:monthName,
					changeMonth:true
					, maxDate:0
				});
				
				$(".ui-datepicker").css({"margin-left" : "80px"});
			}
			
			
			
			$(document).ready(function() {		
				App.init();
				calendar();
				
				/*  $("#startDate").val(nowYear.toString()+"-"+ nowMonth.toString()+"-01"); */
				/*  $("#endDate").val(nowYear.toString()+"-"+ nowMonth.toString()+"-"+nowDate.toString()); */
				 
				// select box text 설정
				$(".search-sel").change(function() {
					$(this).siblings(".selectText").text($(this).children('option:selected').text());
				});
				
				gridList();
				
				//메뉴활성화
				$("#reqStatus").addClass("active");
				$("#goodsReqStatusApprove").addClass("active");
			});	
		</script>
	</body>
</html>