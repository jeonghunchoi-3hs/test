<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<link rel="stylesheet" type="text/css" href="${apachePath}/resources/css/ui.jqgrid.css" />
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
				<!-- begin #content -> header -->
				<div class="page_header mb30">
					<h1>실시간 성능 분석</h1>
					<div class="pageNav">
						<a href="#" class="home"><i></i></a><a href="#">모니터링</a><a href="#" class="on">실시간 성능 분석</a>
					</div>
				</div>
				<!-- end #content -> header -->



				<!-- begin #content -> page-body -->
				<div class="mb50">
					<!-- search begin -->
					<div class="page_searchBox">
						<div class="searchArea">
							<div class="selectBox">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel width-150" id="searchKind">
									<option value="searchAll">전체</option>
									<option value="hostname_alias">서버명</option>
									<option value="hostname">호스트명</option>
								</select>
							</div>
								<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)searchData();" class="width-600 ml5">
								<a type="button" class="bton-s bton_blue" onclick="searchData()"> <i class="fa fa-search"></i>  검색</a>
						</div>
					</div>
					<!-- search end -->

					<div class="col-xs-12 pl0 pr0">
						<div id="gridDiv" width=100%>
							<table id="list">
							</table>
						</div>
					</div>
				</div>
			 	<!-- end #content -> page-body -->

			 	<div class="clear"></div>

			  	<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			 	<!-- end #footer -->
			</div>
	        <!-- end #content -->
		</div>
		<!---- end #page-container---->

		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
		<script type="text/javascript" src="${apachePath}/resources/js/plugins/jquery.jqGrid.js"></script>
		<script type="text/javascript">
			var grid;
			var nodeTemp = '1';			// 노드값 default 1(전체)
			var autoInterval;

			function searchData(cloudId) {
				//jqGrid는 조회된 이후 재조회시 해재작업이 필요함.
				$("#list").jqGrid("GridUnload");
				loadData(cloudId);
			}

			// 초기 데이터 호출
			function loadData(cloudId){
				$("#list").jqGrid({
					url:'${pageContext.request.contextPath}/mng/monitoring/status/list',
					mtype: "GET",
					postData: { searchKind:$("#searchKind option:selected").val(), keyword:$("#keyword").val(),"cloudId":cloudId},
					datatype: "json",
					//data: mydata,
					//datatype: "local",
					colNames:['서버명', '호스트명', 'IP주소', '이벤트<br/>발생 현황', 'CPU<br/>사용률(%)', '메모리<br/>사용률(%)', '파일시스템명<br/>(최대)', '파일시스템<br/>사용률(%)'],
		            colModel:[
		            	{name:'hostnameAlias',index:'hostnameAlias', align:"center"},
			 	   		{name:'hostname',index:'hostname',align:"center"},
			 	   		{name:'fixedIps',index:'fixedIps', align:"center"},
		 	   			{name:'severity',index:'severity', align:"center", formatter:getSeverityImages},
			 	   		{name:'cpuUsedPct',index:'cpuUsedPct', align:"center", formatter:getLinearGauge},
			 	   		{name:'memUsedPct',index:'memUsedPct', align:"center", formatter:getLinearGauge},
			 	   		{name:'fsName',index:'fsName', align:"center"},
			 	   		{name:'spaceUsedPct',index:'spaceUsedPct', align:"center", formatter:getLinearGauge}
			 	   	],
				   	jsonReader : {root: "data"},			//controller에서 가져오는 json명},
					gridview:true,					//gridview를 true해주면 jqgrid성능이 향상됨.
					viewrecords:true,
				   	rowNum: 1000,
				    height: '600px',
				    width : '100%',
				    autowidth:false,
				    shrinkToFit:false, // 가로스크롤
				    loadtext:"조회중입니다." ,
				    resizeable:true,
				    onCellSelect:function(rowid,iCol,cellcontent,e){
				    	var gridData =$("#list").jqGrid('getRowData', rowid);
				    	var hostname = gridData.hostname;
				    	getPopup(iCol, hostname);
				    },
				   /*  ondblClickRow:function(rowId){
				         var selected = $('#list');.jqGrid('getGridParam', 'selrow');
				         console.log()
				         var myCellData = $('#list');.jqGrid('getCell', sel_id, 'bookref');
				    }, */
				    loadComplete : function(data){

				    }

				});


				//$("#list").jqGrid("setFrozenColumns");
				//jQuery("#grid").jqGrid('destroyFrozenColumns');
				//$('#list').setGridWidth($('.h685').width() -3 , true);
			}

			// 심각도 이미지
			function getSeverityImages(rowId, tv, rowObject){
				var html = '<span class="event_level1"></span>';
		//		var icon = 'icon_green';

				if(typeof rowId != 'undefined'){
					if(rowId == 5){
						html = '<span class="event_level5"></span>';
					}else if(rowId == 4){
						html = '<span class="event_level4"></span>';
					}else if(rowId == 3){
						html = '<span class="event_level3"></span>';
					}else if(rowId == 2){
						html = '<span class="event_level2"></span>';
					}
				}

				//var html = '<img src="${pageContext.request.contextPath}/images/w/'+icon+'.gif" style="cursor:pointer;" onclick="" />';

				return html;
			}

			// 게이지 이미지
			function getLinearGauge(rowId, tv, rowObject){

				var green = "";
				var yellow = "";
				var red = "";

				if(typeof rowId == 'undefined'){
					rowId = 0;
				} else {
					if(rowId != "" && rowId > 0) {
						if(rowId > 66) {
							green = "#999 10%, "
							yellow = "#999 45%, "
							if(rowId != 100){
								red = "#999 "+(rowId-10)+"%, #dbdbdb "+rowId+"%";
							}else{
								red = "#999 100%";
							}
						} else if(rowId > 33) {
							green = "#999 10%, ";
							yellow = "#999 "+(rowId-10)+"%, #dbdbdb "+rowId+"%";
						} else {
							green = "#999	 "+(rowId/3)+"%, #dbdbdb "+rowId+"%";
						}
					}
				}

				var html = '<center><li style=" background: linear-gradient(to right, '+green+' '+yellow+' '+red+');width:100%;height:100%">'+rowId+'%</li></center>';

				return html;
			}


			$(document).ready(function() {
				App.init();
				loadData("${getCloudList[0].cloudId}");

				//메뉴활성화
				$("#monitoring").addClass("active");
				$("#statusList").addClass("active");
			});
		</script>
	</body>
</html>
