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
		<input type="hidden" id="productImageSeq" />
	
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
				<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 이미지 상세 <span class="root">관리자포털 > 정책관리 > 이미지 관리</span></h1>
				<!-- end header -->
				
				<!-- begin page-body -->
				<div class="row mb50">
				<table class="tableH">
					<colgroup>
						<col width="15%">
						<col width="35%">
						<col width="15%">
						<col width="35%">
					</colgroup>
					<tbody>
						<tr>
							<th>이미지 ID</th>
							<td colspan="3"><span id="imageId"></span></td>
						</tr>
						<tr>
							<th>이미지명</th>
							<td><span id="imageName"></span></td>
							<th>이미지 별칭</th>
							<td><span id="imageAlias"></span></td>
						</tr>
						<tr>
							<th>이미지 설명</th>
							<td colspan=3"><span id="imageContent"></span></td>
						</tr>
						<tr>
							<th>이미지 유형</th>
							<td colspan=3">
									<div class="selectBox width-200">
										<select id="imageType" >
											<option value="VMIMGLIN100" > 운영체제_리눅스 </option>
											<option value="VMIMGWIN200"> 운영체제_윈도우 </option>
											<option value="VMIMGWEB110"> 운영체재_웹 </option>
											<option value="VMIMGWAS120"> 운영체제_WAS </option>
											<option value="VMIMGDB130"> 운영체제_DB </option>
											<option value="VMIMGDEV140"> 운영체제_DEV </option>
										</select>
									</div>
								</td>
						</tr>
						<tr>
							<th>이미지 file 위치</th>
							<td colspan=3">
								<span id="imagePath"></span>
							</td>
						</tr>
						<tr>
							<th>Public</th>
							<td>
								<input type="radio" name="imageVisibility" id="imageVisibilityPublic" value="public" disabled /> 공용 <input type="radio" class="ml20" name="imageVisibility" id="imageVisibilityLocal" value="local" disabled/> 사설
							</td>
							<th>이미지 크기</th>
							<td>
								<span id="imageSize"></span>
							</td>
						</tr>
						<tr>
							<th>이미지 포맷</th>
							<td><span id="imageFormat"></span></td>
							<th>컨테이너 포맷</th>
							<td><span id="imageContainerFormat"></span></td>
						</tr>
					</tbody>
				</table>

				<div class="row tac m-t-60">
						<a type='button' class="rbton bton_orange" onclick="confirmDelete();"><i class="fa fa-trash"></i> 삭제</a>
					    <a type='button' class="rbton bton_blue" onclick="moveInsertPage();"><i class="fa fa-pencil"></i> 수정</a>
					    <a type='button' class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>
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
			$("#productImageSeq").val(result.productSeq);
			
			$("#productName").text(result.productName);
			$("#productCategoryName").text(result.productCategoryName);
			$("#productCategory").val(result.productCategory);
			
			if(result.itemName == null){
				
				var itemName = "";
				$("#itemName").text(itemName);
				
			}else if(result.itemName != null){
				
				$("#itemName").text(result.itemName);
				
			}
			
			$("#itemId").text(result.itemId);	
			
			$("#imageId").text(result.vmImageId);
			$("#imageName").text(result.vmImageName);
			$("#imageAlias").text(result.imageAlias);
			$("#imageContent").text(result.imageContent);
			$("#imageType option[value=" + result.itemId + "]").attr("selected", "true");
			$("#imageType").val(result.itemId);
			$("#imagePath").text(result.imagePath);
			$("#imageSize").text(result.imageSize);
			if(result.imageRange == 'public') {
				$("#imageVisibilityPublic").prop('checked', true);
				$("#imageVisibilityLocal").prop('checked', false);
			} else {
				$("#imageVisibilityPublic").prop('checked', false);
				$("#imageVisibilityLocal").prop('checked', true);
			}
			$("#imageFormat").text(result.imageFormat);
			$("#imageContainerFormat").text(result.containerFormat);
		}
		
		// 이미지 상세 정보 삭제 여부 확인
		function confirmDelete() {
			confirmBox("삭제하시겠습니까?", deleteProductImage); 
		}
		
		// 이미지 상세 정보 삭제
		function deleteProductImage() {
			
			var productSeq = $("#productImageSeq").val();
			
			$.ajax({
				url : "${contextPath}/mng/bss/productOs/delete",
				dataType : "JSON",
	 			type : "POST",
				data : {
					"productSeq" : productSeq
				},
				success : function(data) {
					var result = data;
					if(result == 1){
						alertBox("삭제되었습니다.", moveListPage);
					}else{
						alertBox3("삭제실패");
					}
					
				},
				error : function(request, status, error) {
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}
		
 		//자원 상제 수정하기
 		function moveProductUpdatePage(productSeq){
			location.href = "${contextPath}/mng/bss/productOs/update?productSeq="+productSeq;
		}			
		
		// 목록 페이지이동
		function moveListPage(){
			location.href = "${contextPath}/mng/bss/productOs/";
		}
		
		// 등록/수정 페이지이동
		function moveInsertPage(){
			var productSeq = $("#productImageSeq").val();
			location.href = "${contextPath}/mng/bss/productOs/write?productSeq=" + productSeq;
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