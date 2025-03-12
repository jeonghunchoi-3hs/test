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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
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
				<h1>회원사 관리</h1>
				<div class="pageNav">
						<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="${contextPath}/mng/cmm/customer/">회원사 관리</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- search Box -->
			<div class="page_searchBox m-b-15">
				<!-- <div class="selectBox" style="width:130px;">
					<label class="selectText" for="searchKey0">구분</label>
					<select class="search-sel" id="searchKey0" onchange="onchangeSearchKey('0');">
						<option value="">구분</option>
					</select>					
					
				</div>
				<div class="selectBox m-l-5" style="width:235px;">
					<label class="selectText" for="searchKey1">고객사명</label>
					<select class="search-sel" id="searchKey1" onchange="onchangeSearchKey('1');">
						<option value="">고객사명</option>
					</select>					
				</div> -->
				<div class="searchArea">
					<div class="selectBox width-150" >
						<label class="selectText" for="searchKind">전체</label>
						<select class="search-sel" id="searchKind">
							<option value="searchAll">전체</option>
							<option value="customerName">회원사명</option>
							<option value="customerId">회원사코드</option>
							<!-- <option value="companyRep">대표자명</option>
							<option value="managerName">담당자</option>
							<option value="regUserName">등록자</option> -->					
						</select>
					</div>
					<div class="inputArea m-l-5">
						<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-300">
						<a type="button" class="bton-s bton_blue" onclick="gridList()"> <i class="fa fa-search"></i> 검색</a>
					</div>
				</div>
			</div> 
			<!-- //search Box -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<div class="gridTableWrap gridType01">
					<!-- 상단 버튼  -->
					<div class="tar mb5">
						<a onclick="excelDown();" type='button' class="bton-s bton_blue"><i class="fa fa-file-excel-o"></i><span> 엑셀다운로드</span></a>
						<a type="button" class="bton-s bton_blue" onclick="moveWritePage();"><i class="fa fa-upload"></i><span> 등록</span></a>
					</div>
					<!-- //상단 버튼  -->
					<!-- 그리드 영역 -->
					<div class="tableWrap">
						<table id="table-list" summary="고객사">
						<caption>게시판 목록 : 회원사 코드, 회원사명, 소속조직(부서), 관리자, 전화번호(사선), 핸드폰, 등록자, 등록일시, 상세로 구성</caption> 
						
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="8%">
								<col width="*">
								<col width="10%">								
								<col width="10%">
								<col width="8%">
								<col width="15%">
								<col width="8%">
							</colgroup>
							<thead>
								<tr>
									<th>회원사코드</th>
									<th>회원사명</th>	
									<th>관리자</th>
									<th>소속조직(부서)</th>								
									<th>전화번호(사선)</th>									
									<th>핸드폰</th>
									<th>등록자</th>
									<th>등록일시</th>
									<th>상세</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			
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
	

	function gridList() {
		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/cmm/customer/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
				 /* d.searchKey0 = $("#searchKey0 option:selected").val();
					d.searchKey1 = $("#searchKey1 option:selected").val(); */
				}
			}
			,"columns":[ 
				{"data":"customerId" , "class":"fontVdn tal onwrap" ,"render":function (data,type,full,meta){
					return '<span class ="onwrap" title ="'+data+'">'+data+'</span>';
				} }
				, {"data":"customerName" , "class":"tal" ,"render":function (data,type,full,meta){
					return '<span data-toggle ="tooltip" title ="'+undefinedCheck(data)+'">'+undefinedCheck(data)+'</span>';
				} }		
				,  {"data":"managerName" , "class":"tac","render":function (data,type,full,meta){
					return '<span data-toggle ="tooltip" title ="'+undefinedCheck(data)+'">'+undefinedCheck(data)+'</span>';
				} }
				, {"data":"managerDeptName" , "class":"tal name","render":function (data,type,full,meta){
					return '<span data-toggle ="tooltip" title ="'+undefinedCheck(data)+'">'+undefinedCheck(data)+'</span>';
				} }
				, {"data":"managerTel" , "class":"tac","render":function (data,type,full,meta){
					return '<span data-toggle ="tooltip" title ="'+undefinedCheck(data)+'">'+undefinedCheck(data)+'</span>';
				} }
				, {"data":"managerPhone" , "class":"tac","render":function (data,type,full,meta){
					return '<span data-toggle ="tooltip" title ="'+undefinedCheck(data)+'">'+undefinedCheck(data)+'</span>';
				} }				
				, {"data":"regUserName" , "class":"tac","render":function (data,type,full,meta){
					return '<span data-toggle ="tooltip" title ="'+data+'">'+data+'</span>';
				} }
				, {"data":"regDatetime" , "class":"fontVdn txtDate tac","render":function (data,type,full,meta){
					return '<span data-toggle ="tooltip" title ="'+data+'">'+data+'</span>';
				} }
		        , {"class":"tac", "width":"7%"} 
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[8], "render": function(data,type,full){
					return "<button type='button' class='cbton bton_lblue' onclick='moveDetailPage(\""+full.customerId+"\")' ><i class='fa fa-search'></i></button>";
					//return "<a href='javascript:void(0);' class='btn_viewDetail'  onclick='moveDetailPage(\""+full.customerId+"\")'></a>";
					} 
				}				
			]
			,"order": [[0,"desc"]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
		tblColorSet();
	}
	
	function moveWritePage() {
		location.href = "${contextPath}/mng/cmm/customer/write";
	}
	
	function moveDetailPage(customerId){
		var params = "?customerId="+customerId;

		location.href = "${contextPath}/mng/cmm/customer/view"+params;
	}
	
	function tblColorSet() {
		$('.gridType01 .tableWrap table thead th').each(function(index, item){
			$(item).addClass('th' + index);
		});
	}
	
	function excelDown(){
		var params = "searchKind="+$("#searchKind option:selected").val();
		params += "&keyword="+$("#keyword").val();
		params += "&refCompanyId="+($("#affiliateName").val()!=null?$("#affiliateName").val():"");
		params += "&upCompanyId="+$("#customerHeard").val();
		location.href = "${contextPath}/mng/cmm/customer/excel?"+params;
	}
	
	function undefinedCheck(str){
		if (str == undefined){
			return "";
		}else{
			return str;
		}
	}
	
	/* function onchangeSearchKey(e){
		if($("#searchKey"+e).val() != ""){
			if( e == "1"){
				var companyName = $("#searchKey"+e+" > option:selected").attr("companyName");
				$("#searchKey0").siblings(".selectText").text(companyName!=""?companyName:"구분");
				$("#searchKey0").val(companyName);
			}else if( e == "2"){
				var companyName = $("#searchKey"+e+" > option:selected").attr("companyName");
				$("#searchKey0").siblings(".selectText").text(companyName!=""?companyName:"구분");
				$("#searchKey0").val(companyName);

				var customerName = $("#searchKey"+e+" > option:selected").attr("customerName");
				$("#searchKey1").siblings(".selectText").text(customerName!=""?customerName:"고객사명");
				$("#searchKey1").val(customerName);
			}			
		}
		
		if( e == "0"){
			setSearchBox("1");
			setSearchBox("2");
		}else if( e == "1"){
			setSearchBox("2"); 
		}
	} */
	
	/* function setSearchBox(gbn){
		$.ajax({
			url : "${contextPath}/mng/productUsageStatus/total/searchBox",
			dataType : "JSON",
			data : {
				searchKind : gbn
				, searchKey0 : $("#searchKey0 option:selected").val()
				, searchKey1 : $("#searchKey1 option:selected").val()
			},
			success : function(data) {
				var vText = "";
				if(gbn == "0"){
					vText = "구분";
				}else if(gbn == "1"){
					vText = "고객사명";
				}else if(gbn == "2"){
					vText = "프로젝트명";
				}  
				
				if( vText != ""){
					$("#searchKey"+gbn).html('<option value="">'+vText+'</option>');
					$("#searchKey"+gbn).siblings(".selectText").text(vText);
				}
				
				if(data.searchBox != ""){
					$.each(data.searchBox, function(key,val){
						$("#searchKey"+gbn).append('<option value="'+val.searchKind+'" companyName="'+val.companyName+'" customerName="'+val.customerName+'">'+val.searchKind+'</option>');
					});
				}
			},
			error : function(request, status, error) {
				if(request.status == '200'){
					alertBox("접속이 만료되었습니다.", logout);				
				}else{
					alertBox3("code:" + request.status + "\n" + "error:" + error);
				}
			} 
		});
	}  */
	
	$(document).ready(function() {
		
		//setSearchBox("0");
		//setSearchBox("1");
		//setSearchBox("2");
		
		App.init();
		gridList();
		
		//메뉴활성화
		$("#customerInfo").addClass("active");
	});
</script>
</body>
</html>