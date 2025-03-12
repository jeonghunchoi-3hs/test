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
			<!-- begin #page-container > sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

			<!-- begin #page-container > content -->
			<div id="content" class="content">
			
				 <p class="page_title">로드밸런스
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a> <span class="arrow_ab"> &#8227; </span> 자원현황  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/project/lb/">로드밸런스</a><span class="arrow_ab"> &#8227; </span> <b>로드밸런스 상세</b>
			    </span>
				</p>

				<!-- begin content > page-body -->
				<div class="row p20 bgwh br10">
					<input type ="hidden" id ="hid_projectId"  value="${req.projectId}">
					<input type ="hidden" id ="hid_projectName"  value="${req.projectName}">
					<input type ="hidden" id ="reqProjectSeq"  value="${req.programSeq}">
					<input type ="hidden" id ="cloudId">
					<input type ="hidden" id ="targetUuid"  >
					<input type ="hidden" id ="targetAct"  >
					<input type ="hidden" id ="vmUuid"  >

					<!-- 프로젝트 정보 & 현재 사용용량 시작 -->
					<!-- <div class="viewbox mb20">
					    프로젝트 상세정보
					    <span class="pid" id='projectName'></span>
					 	<h3 class="pname dpin ml20" id="projectAlias"></h3><a type='button' class="bton-s bton_blue dpin ml40"><i class="fa fa-file-text-o"></i> <span> 프로젝트 정의서 </span></a>
					 	<div class="mt20">
					 		<span class="dpin fb fc-blue2">담당조직(부서) : </span> <span id="deptName"></span><span class="dpin fb ml40 fc-blue2">담당조직(부서) : </span> <span id="deptName2"></span><span class="dpin fb ml40 fc-blue2">담당조직(부서) : </span> <span id="deptName3"></span><span class="dpin fb ml40 fc-blue2">담당자  : </span> <span id="managerName"></span>(<span id="managerTel"></span>)
					 	</div>
					</div> -->
					<!-- 프로젝트 정보 & 현재 사용용량 끝 -->
					
					
				 <div class="col-md-12 pl0 pr0">
            	   <div class="col-md-12 pl0">
            	    <span class="pid" id='projectName'></span>
					<h3 class="pname dpin ml20" id="projectAlias"></h3>
            	   </div>
            	   
            	   <div class="clear"></div>
            	   <div class="col-md-12 pl0 pr0 mt20">
	            	    <div class="col-md-3 sub_li"  style="float:left;">
	            	       <label>본부 </label>
	            	       <span id="deptName"></span>
	            	    </div>
	            	    <div class="col-md-3 sub_li">
	            	       <label>처(실)</label>
	            	      <span  id="deptName2"></span>
            	  		</div>
            	  		<div class="col-md-3 sub_li">
	            	       <label>부서</label>
	            	      <span id="deptName3"></span>
            	  		</div>
            	  		<div class="col-md-3 sub_li" style="margin-right:0;float:right;">
	            	       <label>담당자</label>
	            	       <span id="managerName"></span> (<span id="managerTel"></span>)
            	  		</div>
            	     </div>
<%--     <div class="col-md-12 pl0 pr0 mt20">
            	     <h4 class="f16 mb10 f500 mb20">현재 사용량 <a type="button" onclick="useAvailabilityDetail('${req.projectId}');" class="btn_navy-ss flr"> 실시간 가용용량</a> </h4>  
            	     <div class="col-md-4 sub_use">가상서버<span class="flr"><em class="fc_orange_im f24 mr5" id="instances"></em> EA</span> </div> 
            	     <div class="col-md-4 sub_use">vCPU <span class="flr"><em class="fc_purple_im f24 mr5" id="cores"></em>Core</span></div>
            	     <div class="col-md-4 sub_use" style="margin-right:0;float:right;">MEMORY <span class="flr"><em class="fc_blue_im f24 mr5" id="ram"></em>GB</span></div>
            	     </div> --%>
            	   </div> 

					<div class="clear"></div>
					

					<!-- 프로젝트 하위 상세 VM 리스트 시작 -->
					<div class="gridTableWrap gridType02 mt20">
						<!-- 그리드 영역 -->
						
							<table id="VM-list" class="tableV">
								<colgroup>
									<col width="*">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="65px">
								</colgroup>
								<thead>
									<tr>
										<th>로드밸런스명</th>
										<th>가상서버(EA)</th>
										<th>VIP</th>
										<th>PORT</th>
										<th>method</th>
										<th>프로토콜</th>
										<th>상세</th>
									</tr>
								</thead>
							</table>
						
					</div>
					<!-- 프로젝트 하위 상세 VM 리스트 끝 -->

					<div class="flr mt-30">
						<a type="button" class="btn_dgrey" onclick="moveListPage();">목록</a>
					</div>
				</div>
				<!-- end content > page-body -->
			</div>
			<!-- end #page-container > content -->

			<!-- begin #page-container > footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #page-container > footer -->

			<!-- begin #page-container > modal -->
			</div>
		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript">


		
			// 프로젝트 하위 VM 리스트 조회
			function gridList() {
				$("#VM-list").dataTable({
					"processing": true
					,"autoWidth": false
					,"serverSide": true
					,"ordering": false
					,"destroy" : true
					,"ajax": {
						"url":"${contextPath}/mng/oss/loadbalancer/detail"
						,"type" : "GET"
						,"data":function (d) {
							d.searchKind = $("#vm_searchKind option:selected").val();
							d.keyword = $("#vm_keyword").val();
							d.projectId = $("#hid_projectId").val();
							d.projectName = $("#hid_projectName").val();
							d.cloudId = $("#cloudId").val();
						}
					}
					,"columns":[
						{"data":"loadbalancerName" , "class":"tac"}
						 ,{"data":"vmCnt" , "class":"tac"}
						 ,{"data":"ip" , "class":"tac"}
						 ,{"data":"port" , "class":"tac"}
						 ,{"data":"method" , "class":"tac"}
						 ,{"data":"protocol" , "class":"tac"}
					]
					,"columnDefs":[
						{"defaultContent" : "", targets:"_all" }
						,{"targets":[6], "render": function(data,type,full){
							return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='moveDetailPage(\""+full.projectId+"\",\""+full.loadbalancerId+"\")'><i class='fa fa-search'></i></a>";
						}}
					]
					,"language": {
						"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
						, "processing":"<div class='data_search'><i class='fa fa-spinner fa-spin'></i> 검색중입니다. </div>"
					}
					,"sDom":'<"top"i>rt<"bottom"p>'
				});
			}

			//프로젝트 상세정보 조회
			function getDetail() {
				$.ajax({
					url : "${contextPath}/mbr/oss/project/detail",
					dataType : "JSON",
					async : false,
					data : {
						"programSeq" : $("#reqProjectSeq").val()
						,"projectId" : $("#hid_projectId").val()
						,"cloudId" : $("#cloudId").val()
					},
					success : function(data) {
						delete data.length;
						$.each(data, function(i, val){
							if(i != "deptName"){
								if(i == "cloudType"){
				                    if(val == "vmware"){
					                    $("#status1").text("상태");
					                    $("#status3").text("상태 : ");
					                    $("#status4").remove();
					                    visible = 0;
					                }
				                }
								if(val != null){
									if(i=="customerId"){
										$("#hid_"+i).val(val);
									}else if(i == "keyword"){
										// skip
									}else{
										$("#"+i).text(val);
									}
								}
								if(i == "deptName2"){
									if(val){
										$("#deptName").html(val.split("/")[1]);
										$("#deptName2").html(val.split("/")[2]);
										$("#deptName3").html(val.split("/")[3]);
									}
								}
							}
						});
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
					}
				});
			}

				
			$(document).ready(function() {
				App.init();
				//프로젝트 상세정보 조회
				getDetail();
				gridList();
				//메뉴활성화
				$("#myGoods").addClass("active");
				$("#myLoadbalancer").addClass("active");
			});

			function moveDetailPage(projectId,loadbalancerId){
				var params = "?projectId="+projectId;
				params += "&loadbalancerId="+loadbalancerId;
				location.href = "${contextPath}/mbr/project/lb/detail"+params;
			}

		</script>
	</body>
</html>