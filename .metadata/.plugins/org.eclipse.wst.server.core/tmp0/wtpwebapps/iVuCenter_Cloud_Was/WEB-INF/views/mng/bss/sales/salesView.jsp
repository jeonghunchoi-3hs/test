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

		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)-->
		<div id="content" class="content">
			<!-- begin header -->
			<div class="page_header mb30">
				<h1>매출현황 상세</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">요금조회</a><a href="#" class="on">매출현황</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">
				<div class="client_DetailBg m-b-20">
					<input type="hidden" id="h_projectId" value="${projectId}">
					<input type="hidden" id="h_billYyyymm" value="${billYyyymm}">
					<div class="client_DetailArea">
						<h2 class="blueBoxTitle">프로젝트정보</h2>
						<p class="company_Name2" id="projectAlias">아이뷰몰 프로젝트</p>
						<p class="company_Name2" id="clondName"></p>
						<p class="company_Info m-b-25">
							<span class="company_labelf">회원사 : </span> <span class="company_cont" id="customerName"></span>
							<span class="company_label">담당조직(부서) : </span> <span class="company_cont" id="managerDeptName"></span>
							<span class="company_label">담당자 : </span> <span class="company_cont" id="managerName"></span><span class="company_cont" id="managerTel"></span>

						</p>
					</div>
				</div>
				 <div class="mt15">
					 <!-- 상단 버튼  -->
					<div class="tar mb5">
					<span class="f14 fc33">(단위:원, VAT별도)</span>	<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i> 엑셀 다운로드</a>
					</div>

					<!-- //상단 버튼  -->
			        <table class="sumtableV">
			        	<colgroup>
					 		<col width="8%">
					 		<col width="11%">
					 		<col width="11%">
					 		<col width="11%">
					 		<col width="11%">
					 		<col width="11%">
					 		<col width="11%">
					 		<col width="11%">
					 		<col width="*">
					 	</colgroup>
						<thead>
						    <tr>
								<th rowspan="2">청구년월</th>
								<th>기본자원</th>
								<th>부가자원</th>
								<th colspan="5">서비스</th>
								<th rowspan="2">매출금액 </th>
							</tr>
							<tr>
								<th>가상서버</th>
								<th>블록디스크</th>
								<th>계정관리</th>
								<th>보안관제</th>
								<th>백업관리</th>
								<th>SW설치</th>
								<th>디스크관리 </th>
							</tr>
						</thead>
						<tbody id="detailView">
						</tbody>
						<tfoot>
						 <tr>
						    <td>매출합계 </td>
						    <td colspan="7"></td>
						    <td class="tar"><span class="" id="totalAmount">999,999,999</span></td>
						 </tr>
						</tfoot>
					</table>
				</div>
				<!--<div class="salesDetailTotalBg">
					<span class="f20 fc11">매출 합계</span>
					<span class="flr"><span class="salesDetailTotal fontVdn" >999,999,999</span><span class="f14 fc66">원</span></span>
			    </div>   -->
				<!-- search end -->
				<div class="row tac m-t-40">
					<a type="button" class="rbton bton_dgrey" onclick="moveListPage();"><i class="fa fa-list"></i> 목록</a>
				</div>


			</div>
            <!-- begin #footer -->
            <c:import url="/WEB-INF/views/mng/include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	function detailView(){
		$.ajax({
			url : "${contextPath}/mng/charge/bill/salesView",
			dataType : "JSON",
			data : {
				billYyyymm : $("#h_billYyyymm").val()
				, projectId : $("#h_projectId").val()
			},
			success : function(data) {
				var usedAmount = Number(data.aa00Amount) + Number(data.ae00Amount) + Number(data.ai00Amount) + Number(data.e000Amount) + Number(data.i000Amount);
                                                 //	         기본자원                             부가자원                                                  서비스                                        요금할인                             보정할인
				$("#customerName").text(data.customerName);

				$("#managerDeptName").text(data.managerDeptName);
				$("#managerName").text(data.managerName);
				$("#managerTel").text(data.managerTel);


				$("#projectAlias").text(data.projectAlias);
				$("#billYyyymm").text(data.billYyyymm);
				$("#clondName").text(data.cloudName);
				$("#detailView > tr").remove();
				var Html = "";


				Html += "<tr>";
				Html += "<td class='tac'>"+data.billYyyymm.substr(0, 4) + "-" + data.billYyyymm.substr(4, 2)+"</td>";
				Html += "<td class='tar'>"+addcomma(data.aa00Amount)+"</td>";
				Html += "<td class='tar'>"+addcomma(data.ae00Amount)+"</td>"; // 부가자원
				Html += "<td class='tar'>"+addcomma(data.serviceAccountAmount)+"</td>";
				Html += "<td class='tar'>"+addcomma(data.serviceSecurityAmount)+"</td>";
				Html += "<td class='tar'>"+addcomma(data.serviceBackupAmount)+"</td>";
				Html += "<td class='tar'>"+addcomma(data.serviceSwAmount)+"</td>";
				Html += "<td class='tar'>"+addcomma(data.serviceDiskAmount)+"</td>";
				Html += "<td class='tar'>"+addcomma(usedAmount)+"</td>";
				Html += "</tr>";

				$("#detailView").html(Html);

				$("#totalAmount").text(addcomma(usedAmount));

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

	function excelDown(){


		var projectId = $("#h_projectId").val();
		var billYyyymm = $("#h_billYyyymm").val();

		var param = "?projectId="+projectId+"&billYyyymm="+billYyyymm;


		location.href = "${contextPath}/mng/charge/bill/salesViewExcel"+param;

	}

	function moveListPage(){
		location.href = "${contextPath}/mng/charge/bill/salesListPage";
	}

	$(document).ready(function() {
		App.init();
		detailView();
		//메뉴활성화
		$("#priceInquiry").addClass("active");
		$("#sales").addClass("active");
	});

</script>
</body>
</html>