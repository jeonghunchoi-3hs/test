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
		
		<!-- begin page-header -->
			<h1 class="page-header"><img src="<%=request.getContextPath()%>/resources/images/title_icon/basket.png"/>  신청<span class="root"> <img src="/resources/assets/img/root_icon.png"/> 콘솔 > 자원신청 > 부가자원</span></h1>
			<!-- end page-header -->

			<!-- begin page-body -->
			 <div class="row mb50">			

			 <h4 class="mb0 ml10 mt40 fb"> 부가자원  </h4>
			 <!-- begin section-container -->	
			 <div class="p10">	  
			 <div class="section-container inbox101 p30">
				<h5 class="mb10 mt0"> 공인 IP</h5>
			<!-- begin normal input table---------->
			<div class="panel mb0">
				<div>
				<form name="orderform"  id="orderform" action="catalogueOrderNow.do" method="post" >
					<input type="hidden" name="type" id="type" value="noworderinsert" />
					<input type="hidden" name="publicipProductSeq" id="publicipProductSeq" value="${ordervo.productSeq}" />
					<input type="hidden" name="amount" id="amount" value="${ordervo.totalPrice}" />
					<c:choose>
							<c:when test="${ordervo.onDemandFlag eq 'Y'}">
								<input type="hidden" name="applyDatetime" id="applyDatetime" value="" />
							</c:when>
							<c:otherwise>
								<input type="hidden" name="applyDatetime" id="applyDatetime" value="${ordervo.applyDate} ${ordervo.applyTime}:00" />
							</c:otherwise>
					</c:choose>	
					
					<input type="hidden" name="onDemandFlag" id="onDemandFlag" value="${ordervo.onDemandFlag}" />
					<input type="hidden" name="projectId" id="projectId" value="${ordervo.projectId}" />
					<input type="hidden" name="projectName" id="projectName" value="${ordervo.projectName}" />	
					<input type="hidden" name="vmName" id="vmName" value="${ordervo.vmName}" />
					<input type="hidden" name="vmUuid" id="vmUuid" value="${ordervo.vmUuid}" />
					<input type="hidden" name="diskName" id="diskName" value="${ordervo.diskName}" />	
												
					<input type="hidden" name="diskGb" id="diskGb" value="${ordervo.diskcnt}" />					
					<input type="hidden" name="productCategory" id="productCategory" value="${ordervo.productCategory}" />
					<input type="hidden" name="hourlyFlag" id="hourlyFlag" value="${ordervo.hourlyFlag}" />					
					<input type="hidden" name="description" id="description" value="${ordervo.description}" />	
					<input type="hidden" id="publicipId" name="publicipId" value="${ordervo.publicipId}" />
					<input type="hidden" id="orderName" name="orderName" />	
					<input type="hidden" name="catalogSeq" id="catalogSeq" value="${ordervo.catalogSeq}" />
					<input type="hidden" name="requestType" id="requestType" value="${ordervo.requestType}" />
			
			</form>
			<!--------자원정보 table 시작---------->
					<table class="tableAC table-td-valign-middle">
						<colgroup>
						 <col width="100px">
						 <col width="100px">
						 <col width="150px">
						 <col width="*">
						 <col width="200px">						
						 <col width="100px">						
						 </colgroup>
						<thead>
							<tr>							   
								<th>요청유형</th>
								<th>과금단위</th>
								<th>서비스희망일시</th>
								<th>프로젝트</th>
								<th>HOSTNAME</th>							
								<th>신청금액(원)</th>								
						</thead>
						<tbody>						
							<tr>							    
								<td class="tac">
									<c:choose>
										<c:when test="${ordervo.requestType eq 'REQTYPE_EXPR'}">
											삭제
										</c:when>
										<c:when test="${ordervo.requestType eq 'REQTYPE_CHANGE'}">
											변경
										</c:when>
										<c:otherwise>
											신규
										</c:otherwise>
									</c:choose>
								</td>
								<td class="tac">								
									
									<c:choose>
										<c:when test="${ordervo.hourlyFlag eq 'N'}">
											월 단위
										</c:when>
										<c:otherwise>
											시간 단위
										</c:otherwise>
									</c:choose>
								</td>
								<td class="tac">
									<c:choose>
										<c:when test="${ordervo.onDemandFlag eq 'N'}">
											${ordervo.applyDate} ${ordervo.applyTime}:00
										</c:when>
										<c:otherwise>
											승인완료 후 생성
										</c:otherwise>
									</c:choose>
								</td>
								<td class="tac">
									${ordervo.projectAlias}
								</td>
								<td class="tac">
									${ordervo.vmName}
								</td>							
								<td class="tar fcr fb">									
									<fmt:formatNumber value="${ordervo.totalPrice}" pattern="#,###"/>
								</td>
								
							</tr>
							<tr>
							<td colspan="6" class="p20 bgf9">
							     <div>
						         <table class="tableD4">
								 <colgroup>
								 <col width="150px">
								 <col width="*">
								 </colgroup>
								 <thead>
								 <tr>
								 <th>자원이미지</th> 
								 <th>비고</th>
								 </tr>
								 </thead>
								 <tbody>
								 <tr>
								 <td> <img src="${contextPath}/mbr/cmm/file/download/${ordervo.imageName}" class="w80"/></td> 
								 <td class="tal">
									${ordervo.description}									
								</td>
								 </tr>
								 </tbody>
								 </table>
								 </div>
							</td>
							</tr>						
						</tbody>
					</table>
					 <!--------자원정보 table 끝---------->
					 
				    
				</div>
			</div>
			<!-- end normal input table---------->
			</div>
			</div>
			    <!-- end section-container -->	  

			<!-- 
			<div class="section-container inbox mt20 mb10">	
				<div class="panel bgwh mb0 p30">
					<div class="col-md-6 mt-15 f24">총합계(VAT 별도)</div>
					<div class="col-md-6 mt-15 f24 fc-red tar pr0">${ordervo.totalPrice} <span class="f12 fc66">원 </span></div>
				</div>
			</div>	
			 -->				
			
			<div class="col-md-12 tac p20 mt30">	
					  <!-- 
					  <a href="#modal-dialog" class="btn btn-primary width-80" data-toggle="modal">신청</a>
					   -->
<!-- 					  <button type="button" class="btn btn-grey width-80" onclick="orderok();">신청</button> -->
<!-- 					  <a href="#modal-dialog" class="btn btn-primary width-80" data-toggle="modal">신청</a> -->
<!-- 					  <input type="button" onclick="valChk();" value="신청" class="btn btn-primary width-80"> -->
<!--                       <input type="button" onclick="moveVmPage();" value="취소"  class="btn btn-grey width-80"> -->
          
                      <a type="button"><img src="/resources/assets/img/btn_order.png" onclick="valChk();"/></a><a type="button"><img src="/resources/assets/img/btn_cancel.png"  class="ml10" onclick="moveVmPage();"/></a>
			</div>	



			
			</div>
			<!-- end page-body -->

			<!-- #modal-dialog -->
               <div class="modal fade" id="modal-dialog">
                   <div class="modal-dialog">
                       <div class="modal-content">
                           <div class="modal-header">
                               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                               <h4 class="modal-title fw">자원신청</h4>
                           </div>
                           <div class="modal-body" id="confirmMsg">
                               <h5>해당 자원을 신청하시겠습니까? </h5>
                               <p class="m-b-20 tac mt20">   
                                 <input type="button" class="btn btn-primary width-80" data-dismiss="modal" onclick="catalogueOrderInsert();" value="확인">&nbsp;
								 <a type="button"  class="btn btn-grey width-80" data-dismiss="modal">취소</a>   
                               </p>
                           </div>
                       </div>
                   </div>
               </div>
               
               
               <!-- #modal-dialog -->
               <div class="modal fade" id="modal-dialog2">
                   <div class="modal-dialog">
                       <div class="modal-content">
                           <div class="modal-header">
                               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                               <h4 class="modal-title fw">자원신청</h4>
                           </div>
                           <div class="modal-body">
                               <h5>신청이 완료 되었습니다.</h5>
                               <p class="m-b-20 tac mt20"type="button"ref="javascript:;"  class="btn btn-grey width-80" data-dismiss="modal" onclick="movePage();">확인</a>   
                               </p>
                           </div>
                           
                       </div>
                   </div>
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
		$(document).ready(function() {
		    App.init();
		   
			$("a>button").on('click',function(){
			location.href = $(this).closest("a").attr("href");
			});
			
			//메뉴활성화
			$("#reqProduct").addClass("active");
			$("#sub").addClass("active");
			
			catalogueOrderInsert();
		});
		
		function orderok(){		
			
			/*
			if($("#orderName").val()==""){
				alert("신청명을 입력하세요");
				return false;
			}
			*/
			$("#amount").val(rtnnumber($("#amount").val()));
			$("#orderform").submit();
		}
		
		
		function rtnnumber(n){
			n=n.replace(/,/g,"");
			if(isNaN(n)){
				return 0;
			}else{
				return n;
			}
		}

		function addcomma(n){
			if(isNaN(n)){
				return 0;
			}else{
				var reg=/(^[+-]?\d+)(\d{3})/;
				n +='';			
				while(reg.test(n)){
					n=n.replace(reg,'$1'+','+'$2');
				}				
			return n;
			}
		}
		
		
		
		
		// 신청신청
		function catalogueOrderInsert(){
			var jsonData = setJsonData();
			$.ajax({
				url : "catalogueIpOrderNow",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					parent.moveLocation("${wasPath}/mbr/req/catalogue/bssOrderList");
				},
				error : function(request, status, error) {
				//	alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		

		// jsonData 세팅
		function setJsonData(){
			
			$("#amount").val(rtnnumber($("#amount").val()));
			
			var applyDatetime = $("#applyDatetime").val();
			var jsonData;
			
			if(applyDatetime == ""){
				jsonData={
						"type" : $("#type").val()
						, "publicipProductSeq" : $("#publicipProductSeq").val()
						, "amount" : $("#amount").val()
						, "onDemandFlag" : $("#onDemandFlag").val()
						, "projectName" : $("#projectName").val()
						, "diskGb" : $("#diskGb").val()
						, "projectId" : $("#projectId").val()
						, "productCategory" : $("#productCategory").val()			
						, "hourlyFlag" : $("#hourlyFlag").val()		
						, "orderName" : $("#orderName").val()		
						, "description" : $("#description").val()		
						, "vmName" : $("#vmName").val()
						, "vmUuid" : $("#vmUuid").val()
						, "diskName" : $("#diskName").val()
						, "catalogSeq" : $("#catalogSeq").val()
						, "publicipId" : $("#publicipId").val()
						, "requestType" : $("#requestType").val()
						
						
					}	
			}else{
				jsonData={
						"type" : $("#type").val()
						, "publicipProductSeq" : $("#publicipProductSeq").val()
						, "amount" : $("#amount").val()
						, "applyDatetime" : $("#applyDatetime").val()
						, "onDemandFlag" : $("#onDemandFlag").val()
						, "projectName" : $("#projectName").val()						
						, "diskGb" : $("#diskGb").val()						
						, "projectId" : $("#projectId").val()
						, "productCategory" : $("#productCategory").val()			
						, "hourlyFlag" : $("#hourlyFlag").val()		
						, "orderName" : $("#orderName").val()		
						, "description" : $("#description").val()	
						, "vmName" : $("#vmName").val()
						, "vmUuid" : $("#vmUuid").val()
						, "diskName" : $("#diskName").val()
						, "catalogSeq" : $("#catalogSeq").val()
						, "publicipId" : $("#publicipId").val()
						, "requestType" : $("#requestType").val()
					}
			}
			
			return jsonData;
		}
		
		function valChk(){
			/*
			if($("#orderName").val()==""){
				alert("신청명을 입력하세요");
				return false;
			}
			*/
			confirmBox("해당 자원을 신청하시겠습니까?", catalogueOrderInsert);
// 			openModal();
		}
		
		//modal팝업 open
// 		function openModal(){
// 			$("#modal-dialog").modal();
// 		}
		//modal팝업 open
// 		function openModal2(){
// 			$("#modal-dialog2").modal();
// 		}
		
		function movePage(){
			location.href="/mbr/req/catalogue/bssOrderList";
		}
		function moveVmPage(){
			location.href="${contextPath}/mbr/req/catalogue/catalogueSubList.do";
		}
		
		

	</script>
	
</body>
</html>