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
	<div id="page-loader" class="page-loader fade in hide"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

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
				<h1>서비스 로드분산</h1>
				<div class="pageNav">
					<a href="#" class="home"><i></i></a><a href="#">자원사용현황</a><a href="#" class="on">서비스 로드분산</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
				
				<!-- search begin -->
				<div class="page_searchBox mb30">
					<div class="searchArea">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="searchKey0">구분</label>
							<select class="search-sel" id="searchKey0" onchange="onchangeSearchKey('0');">
								<option value="">구분</option>
							</select>
						</div>
						<div class="selectBox  m-l-5" style="width:235px;">
							<label class="selectText" for="searchKey1">고객사명</label>
							<select class="search-sel" id="searchKey1" onchange="onchangeSearchKey('1');">
								<option value="">고객사명</option>
							</select>
						</div>
						<div class="selectBox  m-l-5" style="width:359px;">
							<label class="selectText" for="searchKey2">프로젝트명</label>
							<select class="search-sel" id="searchKey2" onchange="onchangeSearchKey('2');">
								<option value="">프로젝트명</option>
							</select>
						</div>
						<div class="selectBox  m-l-5" style="width:110px;">
							<label class="selectText" for="searchKey3">과금단위</label>
							<select class="search-sel" id="searchKey3">
								<option value="">과금단위</option>
								<option value="N">월단위</option>
								<option value="Y">시간단위</option>
							</select>
						</div>
						<div class="mt10">
							<div class="selectBox" style="width:130px;">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel" id="searchKind">
									<option value="searchAll">전체</option>
									<option value="project_alias">프로젝트명</option>
								</select>
							</div>
							<div class="inputArea m-l-5">
								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList('onchange');" style="width: 450px">
								<a type='button' class="btn_search" onclick="gridList('onchange')">검색</a>
							</div>	
						</div>																		
					</div>
				</div>
				<!-- search end -->
				<!-- Usage Status -->
				<div class="usageStatusWrap">
					<strong class="titleLabel">조회 건수 합계</strong>
					<dl>
						<dt>총 합계</dt>
					</dl>
					<div class="total" id='title_length'><em>0</em>EA</div>
				</div>
				<!-- //Usage Status -->
				<!-- 테이블시작 -->
				<div class="gridTableWrap gridType03">
					<!-- 그리드 영역 -->
					<div class="tableWrap m-t-15">
						<!-- 상단 버튼  -->
						<div class="btnArea tar m-b-15">
							<a type='button' onclick="excelDown();" class="btnType01 m-r-5"><i class="ico_download"></i><span>다운로드</span></a>
						</div>
						<!-- //상단 버튼  -->
						<table id="table-list" summary="로드분산"> 
						<caption>게시판 목록 : 구분, 고객사명, 프로젝트명, 서비스 로드분산명, 과금단위, 삼품가입일시로 구성</caption> 
							<colgroup>
								<col width="127px">
								<col width="166px">
								<col width="206px">
								<col width="196px">
								<col width="109px">
								<col width="168px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">구분</th>
									<th scope="col">고객사명</th>
									<th scope="col">프로젝트명</th>
									<th scope="col">서비스 로드분산명</th>
									<th scope="col">과금단위</th>
									<th scope="col">자원가입일시</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			<!-- 테이블 끝 -->
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


	function gridList(act) {
		var searchKey0 = $("#searchKey0 option:selected").val();
		var searchKey1 = $("#searchKey1 option:selected").val();
		var searchKey2 = $("#searchKey2 option:selected").val();
		
		if(act== 'ready'){
			if('${req.companyName}' != ""){
				searchKey0 = '${req.companyName}';
			}
			if('${req.customerName}' != ""){
				searchKey1 = '${req.customerName}';
			}
			if('${req.projectAlias}' != ""){
				searchKey2 = '${req.projectAlias}';
			}
		}
		
		$("#table-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mng/productUsageStatus/lb/list"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = $("#searchKind option:selected").val();
					d.keyword = $("#keyword").val();
					d.searchKey0 = searchKey0;
					d.searchKey1 = searchKey1;
					d.searchKey2 = searchKey2;
					d.searchKey3 = $("#searchKey3 option:selected").val();
				}
			}
			,"initComplete" : function(setting, json){
				 $("#title_length em").text(json.recordsTotal);
			}		
			,"columns":[ 
				{"data":"companyName" , "class":"tal onwrap"}
				, {"data":"customerName" , "class":"tal onwrap"}
				, {"data":"projectAlias" , "class":"tal onwrap"}
				, {"data":"loadbalancerName" , "class":"tal onwrap"}
				, {"data":"hourlyFlag" , "class":"tac"}
				, {"data":"regDatetime" , "class":"tac onwrap fontVdn"}				
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"ip>' 
		});
		
		
		//팝업 테이블 odd, even 스타일 세팅
		$('#table-list tr:odd').addClass('odd');
		$('#table-list tr:even').addClass('even'); 
	} 

	function onchangeSearchKey(e){
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
			setSearchBox("1", 'onchange');
			setSearchBox("2", 'onchange');
		}else if( e == "1"){
			setSearchBox("2", 'onchange'); 
		}
	}
	
	function setSearchBox(gbn, act){
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
				
				if(act == "ready"){
					if(gbn=='0' && '${req.companyName}' != ""){
						$("#searchKey0").val('${req.companyName}');
						$("#searchKey0").siblings(".selectText").text('${req.companyName}');
					}
					if(gbn=='1' &&  '${req.customerName}' != ""){
						$("#searchKey1").val('${req.customerName}');
						$("#searchKey1").siblings(".selectText").text('${req.customerName}');
					}
					if(gbn=='2' &&  '${req.projectAlias}' != ""){
						$("#searchKey2").val('${req.projectAlias}');
						$("#searchKey2").siblings(".selectText").text('${req.projectAlias}');
					}
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
	} 
	
	function excelDown(){
		var params = "";
		params += "&searchKind="+$("#searchKind option:selected").val();
		params += "&keyword="+$("#keyword").val();
		params += "&searchKey0="+$("#searchKey0 option:selected").val();
		params += "&searchKey1="+$("#searchKey1 option:selected").val();
		params += "&searchKey2="+$("#searchKey2 option:selected").val();
		params += "&searchKey3="+$("#searchKey3 option:selected").val();
		
		location.href =  '${contextPath}/mng/productUsageStatus/lb/excel?'+params;
	}
	
	$(document).ready(function() {
		App.init();
 		setSearchBox("0", 'ready');
		setSearchBox("1", 'ready');
		setSearchBox("2", 'ready');
		gridList('ready');
		
		//메뉴활성화
		$("#productUsageStatus").addClass("active");
		$("#productUsageStatusLb").addClass("active");
	});
</script>
</body>
</html> 