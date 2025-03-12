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
			<!-- begin header -->
			<div class="page_header m-b-30">
				<h1>진열자원 수정</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">자원관리</a><a href="#" class="on">진열자원 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row mb50">
				<div class="formType01">
					<input type="hidden" id="h_catalogSeq" value="${catalogSeq}">
					<input type="hidden" id="h_productSeq" value="${productSeq}">
					<input type="hidden" id="h_catalogCategory" value="${catalogCategory}">

					<div class="tblWrap clearfix">
						<table>
							<colgroup>
								 <col width="12%">
								 <col width="22%">
								 <col width="22%">
								 <col width="22%">
								 <col width="22%">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong>카테고리</strong></th>
									<td colspan="4">
										<div class="selectBox" style="width:371px;">
											<label class="selectText" for="catalogCategory">카테고리를 선택하세요</label>
											<select class="search-sel" id="catalogCategory" disabled="disabled">
												<c:forEach items="${cateList}" var="cateList" varStatus="status" >
													<option value="${cateList.codeId}">${cateList.codeName}</option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>진열자원명</strong></th>
									<td colspan="4"><input type="text" style="width:100%" name="displayName" id="displayName" maxlength="40" value="${viewDetail.displayName}"></td>
								</tr>
								<tr>
									<th scope="row"><strong>자원명</strong></th>
									<td colspan="4">
										${viewDetail.productName}
									</td>
								</tr>
								<c:if test="${viewDetail.categoryType ne 10}">
								<tr>
										<th scope="row"><strong>자원정보</strong></th>
										<c:if test="${viewDetail.categoryType eq 1}">
											<td class="fontVdn">
												<span class="fontB">vCPU</span>
												<span class="flr">${viewDetail.vcpus}<sapn class="fc66 m-l-10">Core</sapn></span>
											</td>
											<td class="colline fontVdn">
												<span class="fontB">MEMORY</span>
												<span class="flr"><fmt:formatNumber value="${viewDetail.memGb}" pattern="#,###"/><sapn class="fc66 m-l-10">GB</sapn></span>
											</td>
											<td class="colline fontVdn">
												<span class="fontB">DISK</span>
												<span class="flr"><fmt:formatNumber value="${viewDetail.vmDiskGb}" pattern="#,###"/><sapn class="fc66 m-l-10">GB</sapn></span>
											</td>
											<td class="colline fontVdn">
											   <span class="fontB">이미지유형</span>
												<span class="flr">${viewDetail.vmOsName}</span>
											</td>
										</c:if>
										<c:if test="${viewDetail.categoryType eq 2}">
											<td colspan="4" class="colline fontVdn" style="padding-right: 565px;">
												<span class="fontB">DISK</span>
												<span class="flr"><fmt:formatNumber value="${viewDetail.diskGb}" pattern="#,###"/><sapn class="fc66 m-l-10">GB</sapn></span>
											</td>
										</c:if>
										<c:if test="${viewDetail.categoryType eq 3}">
											<td colspan="4" class="colline fontVdn" style="padding-right: 565px;">
												<span class="fontB">NAS</span>
												<span class="flr"><fmt:formatNumber value="${viewDetail.nasGb}" pattern="#,###"/><sapn class="fc66 m-l-10">GB</sapn></span>
											</td>
										</c:if>
										<c:if test="${viewDetail.categoryType eq 4}">
											<td colspan="4">
												<span class="fontVdn">${viewDetail.publicipEa}</span><sapn class="fc66 m-l-10">EA</sapn>
											</td>
										</c:if>
										<c:if test="${viewDetail.categoryType eq 5}">
											<td colspan="4">
												<span class="fontVdn">${viewDetail.loadbalancerEa}</span><sapn class="fc66 m-l-10">EA</sapn>
											</td>
										</c:if>
										<c:if test="${viewDetail.categoryType eq 6}">
											<td colspan="4">
												<span class="fontVdn"><fmt:formatNumber value="${viewDetail.backupGb}" pattern="#,###"/></span><sapn class="fc66 m-l-10">GB</sapn>
											</td>
										</c:if>
										<c:if test="${viewDetail.categoryType eq 7}">
											<td colspan="4">
												<span class="fontVdn">${viewDetail.scmEa}</span><sapn class="fc66 m-l-10">식</sapn>
											</td>
										</c:if>
										<c:if test="${viewDetail.categoryType eq 8}">
											<td colspan="4">
												<span class="fontVdn">${viewDetail.mcaEa}</span><sapn class="fc66 m-l-10">식</sapn>
											</td>
										</c:if>
										<c:if test="${viewDetail.categoryType eq 9}">
											<td colspan="4">
												<span class="fontVdn">${viewDetail.securityEa}</span><sapn class="fc66 m-l-10">식</sapn>
											</td>
										</c:if>
								</tr>
								</c:if>
								<c:if test="${cloudType eq 'vmware' and catalogCategory eq 'CATACATE_DISK'}">
									<tr>
										<th scope="row"><strong>VMDK FILE<span class="fontN"></span></strong></th>
										<td colspan="4" class="fontVdn">${viewDetail.vmdkFile}</td>
									</tr>
								</c:if>
								<tr>
									<th scope="row"><strong>월 금액<span class="fontN">(원)</span></strong></th>
									<td colspan="4" class="fontVdn"><fmt:formatNumber value="${viewDetail.monthlyPrice}" pattern="#,###"/></td>
								</tr>
						<!-- 	<tr>
									<th scope="row"><strong>시간 금액<span class="fontN">(원)</span></strong></th>
									<td colspan="4" class="fontVdn"><fmt:formatNumber value="${viewDetail.hourlyPrice}" pattern="#,###"/></td>
								</tr>  -->
								<tr>
									<th scope="row"><strong>추천자원 목록설명</strong></th>
									<td colspan="4"><textarea  style="width:100%; height: 100px" id="descriptionList" maxlength="200">${viewDetail.descriptionList}</textarea></td>
								</tr>
								<tr>
									<th scope="row"><strong>추천자원 상세소제목</strong></th>
									<td colspan="4"><textarea  style="width:100%; height: 100px" id="descriptionTop" maxlength="200	">${viewDetail.descriptionTop}</textarea></td>
								</tr>
								<tr>
									<th scope="row"><strong>추천자원 상세설명</strong></th>
									<td colspan="4"><textarea  style="width:100%; height: 100px" id="description" maxlength="300">${viewDetail.description}</textarea></td>
								</tr>
<!-- 								<tr> -->
<!-- 									<th scope="row"><strong>정렬순서</strong></th> -->
<!-- 									<td colspan="3"> -->
<!-- 										<div class="selectBox" style="width:371px;"> -->
<!-- 											<label class="selectText" for="displayOrder">정렬순서를 설정하세요</label> -->
<!-- 											<select class="search-sel" id="displayOrder"> -->
<%-- 												<c:forEach var="i" begin="0" end="${totalCnt}" step="1"> --%>
<%-- 													<option value="${i}">${i}</option> --%>
<%-- 												</c:forEach> --%>
<!-- 											</select> -->
<!-- 										</div>  -->
<!-- 									</td> -->
<!-- 								</tr> -->
								<tr>
									<th scope="row"><strong>표시여부</strong></th>
									<td colspan="4">
										<label class="checkbox-inline flex align-center gap10">
			                            	<input type="checkbox" data-original-title="" title="" value="Y" name="displayFlag" id="displayFlag"><span id="displayFlagTxt">표시</span>
			                            </label>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>추천여부</strong></th>
									<td colspan="4">
										<label class="checkbox-inline flex align-center gap10">
			                            	<input type="checkbox" data-original-title="" title="" value="Y" name="recommandFlag" id="recommandFlag"><span id="recommandFlagTxt">추천</span>
			                            </label>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong>기본여부</strong></th>
									<td colspan="4">
										<label class="checkbox-inline flex align-center gap10">
			                            	<input type="checkbox" data-original-title="" title="" value="Y" name="basicProductFlag" id="basicProductFlag"><span id="basicProductFlagTxt" readonly="readonly">기본자원</span>
			                            </label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<!-- begin button-->
			    <div class="row tac m-t-60">
		 			<a type="button" class="rbton bton_blue" onclick="setJsonData();"><i class="fa fa-floppy-o"></i>  저장</a>
		 			<a type="button" class="rbton bton_dgrey" onclick="moveViewPage();"><i class="fa fa-close"></i> 취소</a>
                 </div>
				<!-- end button -->
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

	// 자원 상세 수정
	function ajaxProductUpdate(jsonData){

		$.ajax({
			url : "${contextPath}/mng/bss/catalog/update",
			dataType : "JSON",
			type : "POST",
			data : jsonData,
			success : function(data) {
				var result = data;
				if(result == 1){
					alertBox("수정되었습니다.", moveViewPage);
				}else{
					alertBox("fail!!", moveViewPage);
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	// jsonData 세팅
	function setJsonData(){

		if($("#displayName").val()==""){
			alertBox3("표시이름을 입력하세요");
			$("#displayName").focus();
			return false;
		}
		/* if($("#description").val()==""){
			alertBox3("추천자원 상세설명을 입력하세요");
			$("#description").focus();
			return false;
		}
		if($("#descriptionTop").val()==""){
			alertBox3("추천자원 상세소제목을 입력하세요");
			$("#descriptionTop").focus();
			return false;
		}
		if($("#descriptionList").val()==""){
			alertBox3("추천자원 목록설명을 입력하세요");
			$("#descriptionList").focus();
			return false;
		} */


		var displayFlag = "";
		if($("input:checkbox[name='displayFlag']").is(":checked")==true){
			displayFlag = "Y";
		}else{
			displayFlag = "N";
		}

		var recommandFlag = "";
		if($("input:checkbox[name='recommandFlag']").is(":checked")==true){
			recommandFlag = "Y";
		}else{
			recommandFlag = "N";
		}

		var basicProductFlag = "";
		if($("input:checkbox[name='basicProductFlag']").is(":checked")==true){
			basicProductFlag = "Y";
		}else{
			basicProductFlag = "N";
		}


		var jsonData = {
				"catalogSeq" : $("#h_catalogSeq").val()
				,"productSeq" : $("#h_productSeq").val()
				,"catalogCategory" : $("#catalogCategory option:selected").val()
				, "displayName": $("#displayName").val()
				, "description": $("#description").val()
				, "descriptionTop": $("#descriptionTop").val()
				, "descriptionList": $("#descriptionList").val()
				, "displayOrder": $("#displayOrder option:selected").val()
				, "displayFlag": displayFlag
				, "recommandFlag": recommandFlag
				, "basicProductFlag": basicProductFlag
				};

		confirmBox2("저장 하시겠습니까?", ajaxProductUpdate, jsonData);
	}

	function moveViewPage(){
		var catalogSeq = $("#h_catalogSeq").val();
		var productSeq = $("#h_productSeq").val();
		var catalogCategory = $("#h_catalogCategory").val();
		var param = "?catalogSeq="+catalogSeq+"&productSeq="+productSeq+"&catalogCategory="+catalogCategory;
		location.href = "${contextPath}/mng/bss/catalog/productViewPage"+param;
	}

	$(document).ready(function() {
		App.init();
		//메뉴활성화

		var displayFlag = "${viewDetail.displayFlag}";
		var recommandFlag = "${viewDetail.recommandFlag}";
		var basicProductFlag = "${viewDetail.basicProductFlag}";

		if(displayFlag == "Y"){
			$("#displayFlag").attr("checked", "checked");
		}
		if(recommandFlag == "Y"){
			$("#recommandFlag").attr("checked", "checked");
		}
		if(basicProductFlag == "Y"){
			$("#basicProductFlag").attr("checked", "checked");
		}

		var catalogCategory = $("#h_catalogCategory").val();
		$("#catalogCategory").val(catalogCategory);
		$("#catalogCategory").siblings(".selectText").text($("#catalogCategory > option:selected").text());

		var displayOrder = "${viewDetail.displayOrder}";
		$("#displayOrder").val(displayOrder);
		$("#displayOrder").siblings(".selectText").text($("#displayOrder > option:selected").text());


		$("#productAservice").addClass("active");
		$("#catalog").addClass("active");
	});

</script>
</body>
</html>