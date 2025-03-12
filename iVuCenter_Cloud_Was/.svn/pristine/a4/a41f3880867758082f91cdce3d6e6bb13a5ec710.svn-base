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
		<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
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
					<h1>물리서버 현황</h1>
					<div class="pageNav">
						<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">모니터링</a><a href="#" class="on">물리서버 현황</a>
					</div>
				</div>
				<!-- end header -->
				
				<!-- begin page-body -->
				<div class="row pb50">
				
					<!-- search begin -->
					<div class="page_searchBox m-b-15">
						<div class="searchArea">
							<div class="selectBox">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel width-150" id="searchKind">
									<option value="searchAll">전체</option>
									<option value="host_name">호스트명</option>		
								</select>
							</div>
								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
								<a type="button" class="bton-s bton_blue" onclick="gridList()"><i class='fa fa-search'></i> 검색</a>
						</div>
					</div>
					<!-- search end -->
					
					<!-- 테이블시작 -->

						<!-- 상단 버튼  -->
						<!--
						<div class="tar mb5">
							<a type="button" class="bton-s bton_blue" onclick="excelDown();"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
						</div>
						-->
						<div class="tar mb5">
							<a type="button" class="bton-s bton_blue" onclick="mailModalOpen()"> 메일발송</a>
							<a type="button" class="bton-s bton_green" onclick="gridList()"> 새로고침</a>
						</div>
						<!-- //상단 버튼  -->
						<!-- 그리드 영역 -->

							<table id="user-list"  class="tableWrap">
							
								<colgroup>
									<col width="20%">
									<col width="*">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
										<th>호스트명</th>
										<th>노드명</th>
										<th>IP ADDRESS</th>
										<th>CPU 사용률(%)</th>
										<th>메모리 사용률(%)</th>
									</tr>
								</thead>
							</table>					
				</div>
				<!-- end page-body -->
				
				<!-- begin #footer -->
				<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->
				
			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->
		<div class="modal fade" id="modal-mail-insert"> 
			<div class="modal-dialog">
				<div class="modal-content width-570">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span></span></button>
                       	<h4 class="modal-title">운영보고 메일 전송</h4>
                      	</div>
                      	<div class="modal-body">
                      		<div class="formType01">
							<div class="tblWrap clearfix">
								<table>
									<colgroup>
										 <col width="145px">
										 <col width="*">
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><strong>사번 입력</strong></th>
											<td>
												<input type="text" style="width:100%;" name="" id="userId" maxlength="40">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					 	<p class="f18 f11 m-t-30">메일을 전송하시겠습니까?</p>
                   </div>
                   <div class="modal-footer tac">
                       <a type="button" class="pbton bton_blue" data-dismiss="modal" onclick="mailInsert();">확인</a>
                       <a type="button" class="pbton bton_dgrey" data-dismiss="modal">취소</a>
                      </div>
               	</div>
			</div>
           </div>
	<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
	
	<script type="text/javascript">
	
		function gridList() {
			$("#user-list").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
				,"ajax": {
					"url":"${contextPath}/mng/kvm/status/list"
					,"type" : "GET"
					,"dateSrc" : ""
					,"data":function (d) {
						console.log(d);
						d.searchKind = $("#searchKind option:selected").val();
						d.keyword = $("#keyword").val();
					}
				}
				,"columns":[ 
					{"data":"hostName"}
					, {"data":"hostAlias"}
					, {"data":"ipAddress"}
					, {"data":"usedCpuPct"}
					, {"data":"MemUsedPct"}

		        ]
				,"columnDefs":[
					{"defaultContent" : "", targets:"_all" }
				]
				,"order": [[0,"desc"]]
				,"lengthMenu": [[10,15], [10, 15]]
				,"language": { 
					"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
					, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
				}
				,"sDom":'<"top">rt<"bottom"pi>'
			}); 
		}
	
		function moveDetailPage(userId){
			var params = "?userId="+userId;
			location.href = "${contextPath}/mng/cmm/user/viewPage"+params;
		}
		
		function excelDown(){
		    var params = "";
		    params += "&searchKind=" + $("#searchKind option:selected").val();
		    params += "&keyword=" + $("#keyword").val();
		    location.href =  '${contextPath}/mng/cmm/user/excel?'+params;
		}
		
		$(document).ready(function() {
			App.init();
			gridList();
			
			//메뉴활성화
			$("#monitoring").addClass("active");
			$("#kvmStatusList").addClass("active");
		});
		
		function mailModalOpen(){
			$("#modal-mail-insert").modal();
		}
		
		function mailInsert(){
			if($("#userId").val()==""){
				alertBox3("이메일을 입력하세요");
				$("#userId").focus();
				return false;
			}
			$.ajax({
				url : "${contextPath}/mng/kvm/status/sendMail",
				dataType : "JSON",
				type : "GET",
				data : {
					"userId": $("#userId").val()
				},
				success : function(data) {
					var result = data;
					if(result==1){
						alertBox("발송요청 되었습니다.");
					} else if(result == 2){
						alertBox("조회된 정보가 없습니다.");
					}
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
	</script>
	</body>
</html>