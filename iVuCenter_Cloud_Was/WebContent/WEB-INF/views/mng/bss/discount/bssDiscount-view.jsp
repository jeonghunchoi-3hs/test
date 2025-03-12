<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<c:import url="/WEB-INF/views/mng/include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content -->
		<div id="content" class="content">
			
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>할인율상세</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">요금 관리</a><a href="#" class="on">할인율</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<div class="client_DetailBg m-b-40">
					<div class="client_DetailArea">
						<h2 class="blueBoxTitle">프로젝트정보</h2>
						<p class="company_Name2" id="projectAlias"></p>
						<p class="company_Info m-b-25"> 
							<span class="company_labelf">구분 :</span><span class="company_cont" id="upCompanyName"></span>
							<span class="company_label">고객사 :</span><span class="company_cont" id="customerName"></span>
						</p>
					</div> 
				</div>
				
				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType02">
					
					<!-- 상단 버튼  -->
					<div class="btnArea tar">
						<a type="button" class="btnType01" onclick="moveInsertPage();"><i class="ico_write"></i><span>등록</span></a>
					</div>
					<!-- //상단 버튼  -->
					
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-15">
						<table id="table-list" style="border-bottom: 0px none">
							<colgroup>
								<col width="124px">
								<col width="140px">
								<col width="175px">
								<col width="287px">
								<col width="123px">
								<col width="123px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">적용년월</th>
									<th scope="col">할인율(%)</th>
									<th scope="col">등록자</th>
									<th scope="col">등록일시</th>
									<th scope="col" colspan="2">변경</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				<!-- 테이블 끝 -->
				 
				<div class="row tac m-t-40">	
					<a type="button" class="btnType03 btnType03_list" onclick="moveListPage();">목록</a>         
				</div>
				
				<div class="modal fade" id="modal-dialog-dsRate"> 
					<div class="modal-dialog">
						<div class="modal-content width-570">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
	                        	<h4 class="modal-title">할인율 수정</h4>
	                       	</div>
	                       	<div class="modal-body">
								<h4 class="tal f20 fc11 m-b-20">할인율 정보</h4>
	                       		<div class="formType01">
									<div class="tblWrap clearfix">
										<input type="hidden" id="pop_discountSeq"/>
										<table>
											<colgroup>
												 <col width="145px">
												 <col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><strong>적용일자</strong></th>
													<td class="tal">
														<input type="text" class="applyDate fontVdn" name="applyDate" id="pop_applyDate" style="width:120px;" />
													</td> 
												</tr>
												<tr>
													<th scope="row"><strong>할인율</strong></th>
													<td class="tal">
														<input type="text" style="width:160px" name="pop_discountRate" id="pop_discountRate" class="tar fontVdn">
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<p class="f18 f11 m-t-30">할인율을 수정하시겠습니까?</p>
		                   </div>
		                   <div class="modal-footer tac">
		                       <a type="button" class="lbtn" onclick="actPopUpdate();">확인</a>
		                       <a type="button" class="rbtn" data-dismiss="modal">취소</a>
	                       </div>
		               	</div>
					</div>
	            </div>	
						
			</div>
			<!-- end page-body -->
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
	
	function gridList() {
		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false 
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/bss/discount/detail"
				,"type" : "GET"
				,"data":function (d) {
					d.projectId = '${req.projectId}';
					d.applyDate = '';
					d.discountSeq = '';
				}
			}
		 	, "initComplete" : function(setting, json){
				if(json.prjectData != null){ 
					$("#projectAlias").text(json.prjectData.projectAlias);
					$("#upCompanyName").text(json.prjectData.upCompanyName);
					$("#customerName").text(json.prjectData.customerName); 
				}
			}		
			,"columns":[ 
				{"data":"applyDate" , "class":"fontVdn"}
				, {"data":"discountRate" , "class":"tar txtBlack p-r-30 fontVdn"}
				, {"data":"regUserName" , "class":""}
				, {"data":"regDatetime2" , "class":"fontVdn"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[4], "render": function(data,type,full){
						if(full.gbn == "Y"){
							return '<a type="button" class="btnType02_gray" onclick="moveDsratePage(\''+full.discountSeq+'\',\''+full.applyDate+'\', \''+full.discountRate+'\');"><span class="txt"><i class="ico_edit"></i>수정</span></a>';
						}else{
							return '';
						}
					}	
				}
				, {"targets":[5], "render": function(data,type,full){
						if(full.gbn == "Y"){
							return '<a type="button" class="btnType02_gray" onclick="actDelete(\''+full.discountSeq+'\',\''+full.applyDate+'\', \''+full.discountRate+'\');"><span class="txt"><i class="ico_del"></i>삭제</span></a>';
						}else{
							return '';
						}
					}	
				}				
			]
			,"order": [[0,"desc"]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
		tblColorSet();
	}
	
	function moveListPage(){
		location.href = "${contextPath}/mng/bss/discount/";
	}

	function moveInsertPage(){
		location.href = "${contextPath}/mng/bss/discount/write?projectId=${req.projectId}";
	} 
	
	function actDeleteAjax(data){
		$.ajax({
			url : "${contextPath}/mng/bss/discount/delete",
			dataType : "JSON",
			type : "POST",
			data : data,
			success : function(req) {
				if(req == "1"){
					alertBox("삭제되었습니다.", gridList);
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function actDelete(discountSeq, applyDate, discountRate){
		confirmBox2($("#customerName").text()+" "+$("#projectAlias").text()+" 프로젝트의 "+applyDate.split("-")[0]+"년 "+applyDate.split("-")[1]+"월부터 적용되는 "+discountRate+"% 할인율을 삭제하시겠습니까?"
				, actDeleteAjax
				, {"discountSeq" : discountSeq});
	}
	
	function calendar(){
		
		var dayName = ['일','월','화','수','목','금','토'];
		var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

		$(".applyDate").datepicker({
			showOn:"both",
			buttonImage:"${contextPath}/resources/mng/assets/img/ico_datepicker_cal.png",
			buttonImageOnly:true,
			dateFormat : "yy-mm",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});
		$("img.ui-datepicker-trigger").attr("style", "vertical-align:top;");
		$(".applyDate").val($.datepicker.formatDate('yy-mm', new Date()));
	}
	
	function moveDsratePage(discountSeq, applyDate, discountRate){
		$("#pop_discountSeq").val(discountSeq);
		$("#pop_applyDate").val(applyDate.substring(0, 7));
		$("#pop_discountRate").val(discountRate);
		$("#modal-dialog-dsRate").modal();
	}
	
	function actPopUpdate(){
		if($("#pop_discountRate").val() <= 0 || $("#pop_discountRate").val() >= 100){
			alertBox3("할인율을 확인하세요.");
			return false;
		}
		
		$.ajax({
			url : "${contextPath}/mng/bss/discount/update",
			dataType : "JSON",
			type : "POST",
			data : {
				"discountSeq" : $("#pop_discountSeq").val()
				, "applyDate"	: $("#pop_applyDate").val()
				, "discountRate" : $("#pop_discountRate").val()
				, "modUserId":	'${userId}' 
			},
			success : function(req) {
				if(req.errorMsg != 1){
					alertBox3(req.errorMsg);
				}else{
					alertBox("수정되었습니다.", gridList);
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}
	
	$(document).ready(function() {
		App.init();
		gridList();
		calendar();
		
		//메뉴활성화
		$("#chargeManagement").addClass("active");
		$("#dcRateMenu").addClass("active");
	});
</script>
</body>
</html>