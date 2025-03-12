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

	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

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
			<h1 class="page-header fc66 fb"> <i class="fa fa-dot-circle-o fcb"> </i> 가격 정책 관리 <span class="root">관리자포털 > 요금  > 가격 정책 관리</span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row mb50">
			
			<h5 class="ml10 mt20">ㆍ과금항목명 정보</h5>
			
			<!-- begin section-container -->		  
			<div class="col-md-12">
				<!-- begin panel ---->
						
				<!-- begin normal input table---------->
				<div class="tableB mb20">
					<table>
						<colgroup>
							<col width="20%">								
							<col width="80%">														
						</colgroup>
							<tbody>
								<tr>
									<td class="left-b height-40">
										과금항목명명
									</td>
									<td>
										<input class="form-control w80 dpin" type="text" name="itemName" id="itemName" />											
<!-- 											<button type="button" class="btn btn-grey width-80" onclick="itemNamesearch();">검색</button> -->
										<input type="button" value="검색" onclick="openModal();" class="btn btn-grey dp-in" />
										<input  type="hidden" name="itemId" id="itemId" />
										<input  type="hidden" name="policySeq" id="policySeq" value="${policySeq}"/>
									</td>
								</tr>
								<tr>
									<td class="left-b height-40">
										수량
									</td>
									<td>
										<input class="form-control dpin width-200" type="text" name="quantity" id="quantity" readonly/>
									</td>
								</tr>
								<tr>
									<td class="left-b height-40">
										단위
									</td>
									<td>
										<input class="form-control dpin width-200" type="text" name="unit" id="unit" readonly/>
									</td>
								</tr>
								<tr>
									<td class="left-b height-40">
										시간단위 가격
									</td>
									<td>
										<input class="form-control width-200 dpin tar" type="text" name="hourlyPrice" id="hourlyPrice" maxlength="9" /> 원
									</td>
								</tr>
								<tr>
									<td class="left-b height-40">
										월단위 가격
									</td>
									<td>
										<input class="form-control width-200 dpin tar" type="text" name="monthlyPrice" id="monthlyPrice" maxlength="9" /> 원
									</td>
								</tr>
							</tbody>
						</table>	        
					</div>
				</div>
				<div class="row tac mt20">
					<button type="button" class="btn btn-primary width-80" onclick="billitemwrite();">등록</button>
					<button type="button" class="btn btn-grey width-80" onclick="movePage();">취소</button>
				</div>			
			</div>
			<!-- 테이블 끝 -->
			
			
			<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">과금항목명 검색</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="col-md-12 bgee br10 mb10">	
<!-- 	                           <p class="m-b-20"> -->
	                              <input type="text" class="form-control dpin w60" id="searchKeyword" value="" />
	                              <input type="button" class="btn width-80 btn-default" value="검색" onclick="itemPopupList();"/> 
<!-- 	                           </p> -->
								</div>	
								<div>
									<table class="table table-bordered table-hover table-striped table-td-valign-middle">
										<colgroup>
									 		<col width="40%">
									 		<col width="20%">
									 		<col width="20%">
									 		<col width="20%">
									 	</colgroup>
									 	<thead>
									 		<tr class="primary">
												<th class="left height-40 tac">과금항목명</th>
												<th class="left height-40 tac">수량</th>
												<th class="left height-40 tac">단위</th>
												<th class="left height-40 tac">적용</th>
											</tr>
									 	</thead>
										<tbody id="popListTable">
											
										</tbody>
									
									</table>
								</div>	
								
	                      	</div>
	                       	<div class="modal-footer tac">
<!-- 	                   			<a type='button' class="btn width-100 btn-default" data-dismiss="modal">닫기</a> -->
	                   			<input type="button" value="닫기" class="btn width-100 btn-grey" data-dismiss="modal" onclick="initPopup();">
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
			
			
			<!-- begin #footer -->
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
	
<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
	
	function billitemwrite(){
		
		if($("#itemName").val()==""){
			alertBox3("아이템명를 입력하세요");
			$("#itemName").focus();
			return false;
		}
		if($("#hourlyPrice").val()==""){
			alertBox3("시간단위 가격을 입력하세요");
			$("#hourlyPrice").focus();
			return false;
		}		
		if($("#monthlyPrice").val()==""){
			alertBox3("월단위 가격을 입력하세요");
			$("#monthlyPrice").focus();
			return false;
		}
		
		var jsonData = policyjsonData();
		$.ajax({
			url : "${contextPath}/mng/bill/policy/billitemwriteok",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {			
				alertBox3(data);
				if(data==1){
					alertBox2("등록되었습니다.", moveLocation, "${contextPath}/mng/bill/policy/billPolicyList");
				}else{
					alertBox2("등록이 실패하였습니다.", moveLocation, "${contextPath}/mng/bill/policy/billItemWrite");
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
			
		})
	}
	
	function policyjsonData(){	
		
		var jsonData = {
				"itemName" : $("#itemName").val()     
				, "itemId": $("#itemId").val()
				, "quantity": $("#quantity").val() 
				, "unit": $("#unit").val() 
				, "hourlyPrice": $("#hourlyPrice").val() 
				, "monthlyPrice": $("#monthlyPrice").val() 
				, "policySeq": "${policySeq}" 				
				};
		return jsonData;
	}
	
	
	//modal팝업 open
	function openModal(){
		$("#modal-dialog").modal();
		itemPopupList();
	}
	
	//modal팝업 초기화
	function initPopup(){
		$("#searchKeyword").val("");
	}
	
	// 팝업 아이템 리스트 조회
	function itemPopupList(){
		$.ajax({
			url : "${contextPath}/mng/bill/policy/billItemSearchPopup",
			dataType : "JSON",
// 			type : "POST",
			data : {
				"itemName" : $("#searchKeyword").val()
				, "policySeq" : $("#policySeq").val()
			},
			success : function(data) {
				var itemList = data;

				if(itemList != ""){
					$("#popListTable > tr").remove();
					$.each(itemList,function(key,val){
						var Html="";
						Html="<tr><td class='tac'>"+val["itemName"]+"</td>";
						Html = Html + "<td class='tac'>"+val["quantity"]+"</td>";
						Html = Html + "<td class='tac'>"+val["unit"]+"</td>";
						Html = Html + "<td class='tac'><input type='button' value='적용' data-dismiss='modal' class='btn btn-default width-80' onclick='billItemSearchresult(\""+val["itemName"]+"\", \""+val["itemId"]+"\", \""+val["quantity"]+"\", \""+ val["unit"]+"\")'></td>";
						Html = Html + "</tr>";
						
						$("#popListTable").append(Html);	
					});
				}else{
					$("#popListTable > tr").remove();
					var Html="";
					Html="<tr><td class='tac' colspan='4'>검색된 아이템이 없습니다.</td>";
					Html = Html + "</tr>";
					
					$("#popListTable").append(Html);		
				}
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	// 선택한 아이템 정보 적용
	function billItemSearchresult(itemName,itemId,quantity,unit){
		$("#itemName").val(itemName);
		$("#itemId").val(itemId);
		$("#quantity").val(quantity);
		$("#unit").val(unit);
	}
	
	function movePage(){
		var policySeq = $("#policySeq").val();
		location.href="${contextPath}/mng/bill/policy/billPolicyView?policySeq="+policySeq;
	}
	
	$(document).ready(function() {
		
		//gridList();		
		App.init();
		//메뉴활성화
		$("#productAservice").addClass("active");
		$("#billPolicy").addClass("active");
	});
</script>
</body>
</html>