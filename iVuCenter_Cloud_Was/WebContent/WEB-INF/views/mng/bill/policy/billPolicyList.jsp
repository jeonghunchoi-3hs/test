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
				<h1>가격정책 목록</h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">자원관리</a><a href="#" class="on">가격정책 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row pb50">

				<!-- search begin -->
				<div class="page_searchBox m-b-15">
					<div class="searchArea">

						<%-- <div class="selectBox" style="width:130px;">
							<label class="selectText" for="cloudKind">전체</label>
							<select class="search-sel" id="cloudKind"  onchange="gridList()">
								<option value="ALL">전체</option>
								<c:forEach items="${cloudList}" var="cloudInfo" varStatus="status" >
									<option value="${cloudInfo.cloudId}">${cloudInfo.cloudName}</option>
								</c:forEach>
							</select>
						</div> --%>

						<div class="selectBox">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel width-150" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="policy_name">정책명</option>
								<option value="apply_date">적용일자</option>
							</select>
						</div>

							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
							<a type="button" class="bton-s bton_blue" onclick="gridList();"><i class="fa fa-search"></i> 검색</a>

					</div>
				</div>
				<!-- search end -->

					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a type="button" class="bton-s bton_blue" onclick="excelDown();"><i class="fa fa-file-excel-o"></i><span> 엑셀 다운로드</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->

						<table id="mngProjectList" class="tableWrap">
							<colgroup>
								<col width="*">
									<col width="120px">
									<col width="140px">
									<col width="140px">
									<col width="80px">
							</colgroup>
							<thead>
							 	<tr>
									<th>정책명</th>
									<th>적용일자</th>
									<th>수정자</th>
									<th>수정일시</th>
									<th>상세</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
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

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

	function cloudSearchId(cloudId){
		$("#cloudSearchId").val(cloudId);
	    gridList();
	}

	function gridList() {

		 $("#mngProjectList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"${contextPath}/mng/bill/policy/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.cloudKind = $("#cloudKind > option:selected").val();
					d.searchKind = $("#searchKind > option:selected").val();
					d.keyword = $("#keyword").val();
				}
			}
			,"columns":[
						{"data":"policyName", "class":"tal name"}
			        	, {"data":"applyDate"}
			        	//, {"data":"delFlag"}
			        	, {"data":"modUserName"}
			        	, {"data":"modDatetime2"}
			        	, {}
			]
			,"fnRowCallback": function(nRow,aData,index,full){
				//$('td:eq(1)',nRow).attr("class",'tal p-l-30 connectTd');
				if(aData.flag =='NOW'){
					//$('td:eq(0)',nRow).css('tal p-l-30 connectTd')
					$(nRow).addClass('active');
					//$(nRow).attr('active');
				}


			}
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }

				 , { "targets":[1], "render":function(data,type,full){
					 	if(full.applyDate == "9999-12-31"){
							return "";
						}else{
							return full.applyDate;
						}
					}
				}
				,{ "targets":[4], "render":function(data,type,full){
						return "<a type='button' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.policySeq+"\")'><i class='fa fa-search'></i></a>";
					}
				}

			]
			,"order": [[0,"desc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top">rt<"bottom"pi>',
			 "oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {
						//location.href = "${contextPath}/mng/bill/policy/billPolicyWrite";
					}
				}]
			}
		});
		 tblColorSet();
	}

	function tblColorSet() {
		$('.gridType01 .tableWrap table thead th').each(function(index, item){
			$(item).addClass('th' + index);
		});
	}

 	function moveDetailPage(policySeq){
		location.href = "${contextPath}/mng/bill/policy/billPolicyView?policySeq="+policySeq;
 	}

	function excelDown(){
	    var params = "";
	    params += "&searchKind=" + $("#searchKind option:selected").val();
	    params += "&keyword=" + $("#keyword").val();
	    params += "&cloudKind="+$("#cloudKind option:selected").val();
	    params += "&cloudName="+encodeURI($("#cloudKind option:selected").text());
	    location.href =  '${contextPath}/mng/bill/policy/excel?'+params;
	}

	$(document).ready(function() {
		gridList();
		App.init();

		//메뉴활성화
		$("#productAservice").addClass("active");
		$("#billPolicy").addClass("active");

		$(".nav-pills>li:first-child").addClass("active");


	});
</script>

</body>
</html>