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
				<div class="page_header mb30">
					<h1>이미지 관리</h1>
					<div class="pageNav">
						<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책 관리</a><a href="#" class="on">이미지 관리 </a>
					</div>
				</div>
				<!-- end header -->
			
				<!-- begin page-body -->
				<div class="row mb50">
					<input type="hidden" id="productOsNo" value="${productSeq}">
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
								<td colspan="3">
									<input class="input_int" type="text" id="imageId" disabled />
									<a type="button" class="bton-s bton_blue" onclick="openImagesModal();"><i class="fa fa-search"></i> 검색</a> 
								</td>
							</tr>
							<tr>
								<th>이미지명</th>
								<td><input class="input_int" type="text" id="imageName" disabled /></td>
								<th>이미지 별칭</th>
								<td><input class="input_int" type="text" id="imageAlias" /></td>
							</tr>
							<tr>
								<th>이미지 설명</th>
								<td colspan=3"><textarea class="intput_int" row="5" id="imageContent"></textarea></td>
							</tr>
							<tr>
								<th>이미지 유형</th>
								<td colspan=3">
									<div class="selectBox width-200">
										<!-- <label class="selectText">-선택-</label> --> 
										<select id="imageType" disselected >
											<option value="null" > -선택- </option>
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
								<td colspan="3"><input class="input_int" id="imagePath" disabled /></td>
							</tr>
							<tr>
								<th>Public</th>
								<td>
									<input type="radio" name="imageVisibility" id="imageVisibilityPublic" value="public" disabled /> 공용 <input type="radio" class="ml20" name="imageVisibility" id="imageVisibilityLocal" value="local" disabled/> 사설
								</td>
								<th>이미지 크기</th>
								<td>
									<input class="input_int" type="text" id="imageSize" disabled/>
								</td>
							</tr>
							<tr>
								<th>이미지 포맷</th>
								<td>
									<input class="input_int" type="text" id="imageFormat" disabled />
								</td>
								<th>컨테이너 포맷</th>
								<td>
									<input class="input_int" type="text" id="imageContainerFormat" disabled />
								</td>
							</tr>
						</tbody>
					</table>
	
					<div class="row tac m-t-60">
						<c:if test="${productSeq eq 0}">
				 			<a type='button' id="noticeModify" class="rbton bton_blue" onclick="setImageProductInsert();"><i class="fa fa-pencil"></i> 등록</a> 
							<a type='button' id="noticeList" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 취소</a>
						</c:if>
						<c:if test="${productSeq ne 0}">
				 			<a type='button' id="noticeModify" class="rbton bton_blue" onclick="setImageProductInsert();"><i class="fa fa-pencil"></i> 저장</a> 
							<a type='button' id="noticeList" class="rbton bton_dgrey" onclick="moveDetailPage();"><i class="fa fa-list"></i> 취소</a>
		 				</c:if>
					</div>
				</div>
				<!---- end page body---->
				
				<!-- #modal-dialog(Openstack Image List) -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog width-720">
	                   <div class="modal-content width-720">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">이미지</h4>
	                       </div>
	                       <div class="modal-body">
								<!-- 검색기능 불필요 
	                       		<div class="col-md-12 bgee modalpop mb20">	
									<div class="" style="text-align: center; display:inline-block;"> 
										<div class="col-md-8"> 
											<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="searchKeyword" data-original-title="" title="">
										</div>
									  	<button type="button" class="btn_search2" onclick="projectPopList();"><span></span></button>
									</div>
								</div>
								 -->
								<div >
									<table class="table table-bordered table-hover table-striped table-td-valign-middle mb0">
										<colgroup>
									 		<col width="20%">
									 		<col width="20%">
									 		<col width="10%">
									 		<col width="10%">
									 		<col width="10%">
									 		<col width="10%">
									 		<col width="10%">
									 		<col width="10%">
									 	</colgroup>
									 	<thead>
									 		<tr class="skyblue">
												<th class="tac">이미지ID</th>
												<th class="tac">이미지명</th>
												<th class="tac">디스크 포멧</th>
												<th class="tac">컨테이너 포멧</th>
												<th class="tac">크기</th>
												<th class="tac">상태</th>
												<th class="tac">Public</th>
												<th class="tac"></th>
											</tr>
									 	</thead>
									</table>
									<div class="popListTable">
										<table class="table table-bordered table-hover table-striped table-td-valign-middle mb0">
											<colgroup>
									 		<col width="20%">
									 		<col width="20%">
									 		<col width="10%">
									 		<col width="10%">
									 		<col width="10%">
									 		<col width="10%">
									 		<col width="10%">
									 		<col width="10%">
										 	</colgroup>
											<tbody id="popListTable">
												
											</tbody>
										
										</table>
									</div>
								</div>	
								
	                      	</div>
	                       	<div class="clear"></div>
	                       	<div class="modal-footer tac">
	                   			<a type="button" class="lbtn" data-dismiss="modal" onclick="okImageInsert();" > 확인 </a>	 
	                   			<a type="button" class="rbtn" data-dismiss="modal" onclick="moveListPage();" > 취소 </a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- end #modal-dialog(Openstack Image List) -->
				
				<!-- begin #footer -->
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
			
			$("#imageId").val(result.vmImageId);
			$("#imageName").val(result.vmImageName);
			$("#imageAlias").val(result.imageAlias);
			$("#imageContent").val(result.imageContent);
			$("#imageType option[value=" + result.itemId + "]").attr("selected", "true");
			$("#imageType").val(result.itemId);
			$("#imagePath").val(result.imagePath);
			$("#imageSize").val(result.imageSize);
			if(result.imageRange == 'public') {
				$("#imageVisibilityPublic").prop('checked', true);
				$("#imageVisibilityLocal").prop('checked', false);
			} else {
				$("#imageVisibilityPublic").prop('checked', false);
				$("#imageVisibilityLocal").prop('checked', true);
			}
			$("#imageFormat").val(result.imageFormat);
			$("#imageContainerFormat").val(result.containerFormat);
		}
			
			//가상서버 상세 수정
			function setImageProductInsert() {
				var tmpFlag = validationCheck();
				
				if(tmpFlag) {
					confirmBox("등록 하시겠습니까?", saveImageProductInsert);					
				}
			}
				
			function saveImageProductInsert() {
				var jsonData = setJsonOsData();
				$.ajax({
					url : "${contextPath}/mng/bss/productOs/insert",
					dataType : "JSON",
					type : "POST",
					data : jsonData,
					success : function(data) {
						var result = data;
						
						if(data==1){
							if($("#productOsNo").val() != 0 ){
								alertBox("저장되었습니다.", moveListPage);
							} else {
								alertBox("등록되었습니다.", moveListPage);
							}
						}else{
							if($("#productOsNo").val() != 0 ){
								alertBox3("저장 실패");
							} else {
								alertBox3("등록 실패");
							}
						}
					},
					error : function(request, status, error) {
						alertBox3("code:" + request.status + "\n" + "error:" + error);
					}
				});
			}
			
			function validationCheck(){
				var imageId = $("#imageId").val();
				var imageAlias = $("#imageAlias").val();
				var imageContent = $("#imageContent").val();
				var imageType = $("#imageType option:selected").val();
				
				if(imageId==""){
					alertBox("이미지를 선택해 주세요");
					$("#imageId").focus();
					return false;
				}
				if(imageAlias==""){
					alertBox("이미지 별칭을 입력해 주세요");
					$("#imageAlias").focus();
					return false;
				}
				if(imageContent==""){
					alertBox("이미지 설명을 입력해 주세요");
					$("#imageContent").focus();
					return false;
				}
				if(imageType=="null"){
					alertBox("이미지 유형을 선택해 주세요");
					$("#imageType").focus();
					return false;
				}
				
				return true;
			}
			
			function setJsonOsData() {
				var jsonData = {
							"productSeq": $("#productOsNo").val()
							,"vmImageId": $("#imageId").val()
							, "vmImageName": $("#imageName").val()
							, "imageAlias": $("#imageAlias").val()
							, "imageContent": $("#imageContent").val()
							, "imageType": $("#imageType").val()
							, "imagePath": $("#imagePath").val()
							, "imageRange": $('input[name="imageVisibility"]:checked').val()
							, "imageSize": $("#imageSize").val()
							, "imageFormat": $("#imageFormat").val()
							, "containerFormat": $("#imageContainerFormat").val()
						}; 
				return jsonData;
			}
	
			// 목록 페이지이동
			function moveListPage(){
				location.href = "${contextPath}/mng/bss/productOs/";
			}
			
			//modal팝업 open
			function openImagesModal(){
				$("#modal-dialog").modal({backdrop:'static', keyboard:false});
				imagesPopList();
			}
			
			// 팝업리스트
			function imagesPopList(){
				
				var keyword = $("#searchKeyword").val();
				
				$.ajax({
					url : "${wasPath}/mng/bss/product/imagePopList",
					dataType : "JSON",
		 			type : "GET",
					data : {
						"searchValue" : keyword
					},
					success : function(data) {
						var imagePopList = data.imagePopList;
						
						if( imagePopList != "") {
							$("#popListTable > tr").remove();
							$.each(imagePopList, function(key,val){
								
								var Html="";
								
//		 						Html="<tr><td class='tac'>"+val["projectName"]+"</td>";
								Html="<tr>";
								Html = Html + "<td class='tal'>"+val["id"]+"</td>";
								Html = Html + "<td class='tal'>"+val["name"]+"</td>";
								Html = Html + "<td class='tal'>"+val["disk_format"]+"</td>";
								Html = Html + "<td class='tal'>"+val["container_format"]+"</td>";
								Html = Html + "<td class='tal'>"+val["size"]+"</td>";
								Html = Html + "<td class='tal'>"+val["status"]+"</td>";
								Html = Html + "<td class='tal'>"+val["visibility"]+"</td>";
								Html = Html + "<td class='tac'><input type='button' class='popCheckbtn' onclick='updateImage(this, \""+val["id"]+"\", \""+val["name"]+"\", \""+val["disk_format"]+"\", \""+val["container_format"]+"\", \""+val["size"]+"\", \""+val["status"]+"\", \""+val["visibility"]+"\", \""+val["file"]+"\")'></td>";
								Html = Html + "</tr>";
								
								$("#popListTable").append(Html);
								
							});
						}else{
							$("#popListTable > tr").remove();
								
							var Html="";
							
							Html="<tr><td class='tac' colspan='3'>검색된 이미지가 없습니다.</td>";
							Html = Html + "</tr>";
							
							$("#popListTable").append(Html);		
						}
						
						$('#popListTable tr:odd').addClass('even');
						$('#popListTable tr:even').addClass('odd'); 
						
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
			
			var tmpImageId, tmpImageName, tmpImageDiskFormat, tmpImageContainerFormat, tmpImageSize, tmpImageStatus, tmpImageVisibility, tmpiamgePath ;
			
			function updateImage(e, imageId, imageName, imageDiskFormat, imageContainerFormat, imageSize, imageStatus, imageVisibility, imagePath){
				$("#popListTable > tr").find("input").removeClass("active");
				$(e).toggleClass("active");
				tmpImageId = imageId;
				tmpImageName = imageName;
				tmpImageDiskFormat = imageDiskFormat;
				tmpImageContainerFormat = imageContainerFormat;
				tmpImageSize = imageSize;
				tmpImageStatus = imageStatus;
				tmpImageVisibility = imageVisibility;
				tmpiamgePath = imagePath;
			}
			
			function okImageInsert(){
				$("#imageId").val(tmpImageId);
				$("#imageName").val(tmpImageName);
				$("#imagePath").val(tmpiamgePath);
				$("#imageSize").val(tmpImageSize);
				$("#imageDiskFormat").val(tmpImageDiskFormat);
				$("#imageContainerFormat").val(tmpImageContainerFormat);
				if(tmpImageVisibility == 'public') {
					$("#imageVisibilityPublic").prop('checked', true);
					$("#imageVisibilityLocal").prop('checked', false);
				} else {
					$("#imageVisibilityPublic").prop('checked', false);
					$("#imageVisibilityLocal").prop('checked', true);
				}
				
			}
			
			function moveDetailPage(productSeq){
				location.href = "${contextPath}/mng/bss/productOs/view?productSeq="+ $("#productOsNo").val();
		 	}
			
			$(document).ready(function(){
				App.init();
				if($("#productOsNo").val() != 0 ){
					productView( $("#productOsNo").val() );
				}
				
				//메뉴활성화
				$("#operation").addClass("active");
				$("#bssProductOs").addClass("active");
			});
		</script>
	</body>
</html>