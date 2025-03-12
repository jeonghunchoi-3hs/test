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
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 이미지 수정<span class="root">운영관리 > 이미지 수정</span></h1>
			<!-- end header -->
			
				<!-- begin page-body -->
			 	<div class="row mb50">
				
										 <!-- begin section-container -->		  
										 	<div class="section-container inbox100">
										 	
												<!-- begin normal input table---------->
												<div class="tableC">
													<input type="hidden" id="productSeq" value="${productSeq}">
													<input type="hidden" id="productCategory" value="${productCategory}">
														<table> 
															<colgroup>
															<col width="20%">
															<col width="80%"> 
															</colgroup>
																<tbody>
																	<tr>
																	<td class="left-b height-40">이미지이름</td>
																	<td>
																		<div id="itemName"></div>
																	</td>
																	</tr>
																	
																	<tr>
																	<td class="left-b height-40">이미지표시명</td>
																	<td> <input class="form-control" type="text"  id="itemId"/> 
																	</td>
																	</tr>
																	
																	<tr>
																	<td class="left-b height-40">이미지ID</td>
																	<td> <input class="form-control" type="text"  id="vmImageId"/> 
																	</tr>
																</tbody>
														</table>
													<!-- tab 끝 -->
												</div>
												<!-- 테이블 끝 -->
                           	 				</div>
												<!-- 테이블 끝 -->
										<div class="row tac mt20">
											<input type="button" class="btn btn-primary width-80" onclick="setProductUpdate('${productSeq}')"  value=" 저장"/>
											<input type="button" class="btn btn-default width-80" onclick="moveListPage()" value="목록"/> 
										</div>
                           	 </div>
                           	 
			<c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->
	</div>
	<!-- end page container -->
	
<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
		//자원 상세 정보 불러오기
		function productView(productSeq) {
			$.ajax({
				url : "${contextPath}/mng/bss/productOs/productView",
				dataType : "JSON",
	 			type : "POST",
				data : {
					"productSeq" : productSeq
				},
				success : function(data) {
					var result = data;
					productSetData(result);
					
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		function productSetData(result){
			$("#productSeq").val(result.productSeq);
			$("#productName").val(result.productName);
			$("#productCategoryName").text(result.productCategoryName);
			$("#productCategory").val(result.productCategory);
			
			if(result.itemName == null){
				
				var itemName = "";
				$("#itemName").text(itemName);
				
			}else if(result.itemName != null){
				
				$("#itemName").text(result.itemName);
				
			}
				$("#itemId").val(result.itemId);
				$("#vmImageId").val(result.vmImageId);
				
		}
		
		function updateOs(itemId,vmImageId){
			$("#itemName").val(itemName);
			$("#vmImageId").val(result.vmImageId);
		}			
		
/* 		//자원 update상세 불러오기
		function productUpdate(productSeq) {
			$.ajax({
				url : "${contextPath}/mng/bss/productOs/productView",
				dataType : "JSON",
	 			type : "POST",
				data : {
					"productSeq" : productSeq
				},
				success : function(data) {
					var result = data;
					productUpSetData(result);
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
	
		} */
		
		//가상서버 상세 수정
		function setProductUpdate() {
				if($("#itemId").val()==""){
					alertBox3("이미지표시명을 입력하세요");
					$("#itemId").focus();
					return false;
				}
				if($("#vmImageId").val()==""){
					alertBox3("이미지ID를 입력하세요");
					$("#vmImageId").focus();
					return false;
				}

			
			if(confirmBox("저장 하시겠습니까?",setProductOsUpdate)){
				
			}
		}
		function setProductOsUpdate(){
			
			var jsonData = setJsonOsData();
			$.ajax({
				url : "${contextPath}/mng/bss/productOs/productUpdate",
				dataType : "JSON",
				type : "POST",
				data : jsonData,
				success : function(data) {
					var result = data;
					if(result==1){
						alertBox("저장 되었습니다.",moveViewPage);
					}else{
						alertBox("저장에 실패하였습니다.",moveViewPage);
					}
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		function setJsonOsData(){
			var jsonData = {
					"productSeq" : $("#productSeq").val()
					, "itemId": $("#itemId").val()
					, "vmImageId": $("#vmImageId").val()
					}; 
			return jsonData;
		}		
		
		// 상세 목록 페이지이동
		function moveViewPage(){
//			location.reload();
			location.href = "${contextPath}/mng/bss/productOs/view?productSeq="+${productSeq};
		}
		// 목록 페이지이동
		function moveListPage(){
			location.href = "${contextPath}/mng/bss/productOs/";
		}
		
		$(document).ready(function() {
		    
			App.init();
			productView("${productSeq}");
			
			//메뉴활성화
			$("#operation").addClass("active");
			$("#bssProductOs").addClass("active");
		    
		});
	</script>
	
</body>
</html>