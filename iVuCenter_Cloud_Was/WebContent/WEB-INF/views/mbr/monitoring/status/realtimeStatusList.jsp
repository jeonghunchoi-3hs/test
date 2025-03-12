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

				 <p class="page_title">실시간 성능분석
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 모니터링  <span class="arrow_ab"> &#8227; </span> <b>실시간 성능분석 </b>
			    </span>
			    </p>


				<!-- begin #content page-body -->
				<div class="row p20 bgwh br10">

					<!-- search begin -->
			<!-- 		<div class="col-md-12 br5 p30 mb20 bgee">
							<div class="selectBoxAr">
								<label class="selectText" for="searchKind">전체</label>
								<select class="search-sel" id="searchKind">
									<option value="searchAll">전체</option>
									<option value="hostname_alias">서버명</option>
									<option value="hostname">호스트명</option>
								</select>
							</div>

							<div class="searchBoxAr">
								<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)searchData();"/>
								<button type="button" class="btn_search2"  onclick="searchData()"><span></span></button>
							</div>
					</div> -->
					<!-- search end -->


					 <!-- search begin 2023-->
					<div class="col-md-12 br5 p20 mb20 bgf5 tac">
				         <div class="new-search">
				           <div class="left">
					         <div class="choice-kepco">
							  <div class="select-kepco" id="searchKind">
							    <button class="kep-label" value="searchAll" for="searchKind">전체 </button>
							    <ul class="optionList">
							      <li class="optionItem" value="searchAll">전체</li>
							      <li class="optionItem" value="hostname_alias">서버명</li>
							      <li class="optionItem" value="hostname">호스트명</li>
							    </ul>
							  </div>
							</div>
							</div>

							<div class="right">
	                          <input type="text" class="input-kepco" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)searchData();"/>
	                          <button type="button" class="kepco-ser-icon"  onclick="searchData()"></button>
	                         </div>
                          </div>
				</div>
				<!-- search end -->



					<div class="col-lg-12 pl0 pr0">
							<table id="list">
							</table>
					</div>
				</div>
				<!---- end #content page-body ---->

	          	<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->
			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->

		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

		<script type="text/javascript" src="${apachePath}/resources/js/plugins/jquery.jqGrid.js"></script>
		<script type="text/javascript">
			var grid;
			var nodeTemp = '1';			// 노드값 default 1(전체)
			var autoInterval;

			function searchData() {
				//jqGrid는 조회된 이후 재조회시 해재작업이 필요함.
				$("#list").jqGrid("GridUnload");
				loadData();
			}

			// 초기 데이터 호출
			function loadData() {


				$("#list").jqGrid({
					url:'${pageContext.request.contextPath}/mbr/monitoring/status/list',
					mtype: "GET",
				    postData: { searchKind:$("#searchKind option:selected").val(), keyword:$("#keyword").val()},
					datatype: "json",
					//data: mydata,
					//datatype: "local",
					colNames:[
					          '서버명', '호스트명', 'IP주소', '이벤트<br/>발생 현황', 'CPU<br/>사용률(%)',
					          '메모리<br/>사용률(%)', '파일시스템명<br/>(최대)', '파일시스템<br/>사용률(%)', '상세'
					          ],
		            colModel:[
		            	{name:'hostnameAlias',index:'hostnameAlias', width:300, align:"center"},
			 	   		{name:'hostname',index:'hostname', width:250, align:"center"},
			 	   		{name:'fixedIps',index:'fixedIps', width:150, align:"center"},
			 	   		{name:'severity',index:'severity', width:150, align:"center", formatter:getSeverityImages},
			 	   		{name:'cpuUsedPct',index:'cpuUsedPct', width:150, align:"center", formatter:getLinearGauge},
			 	   		{name:'memUsedPct',index:'memUsedPct', width:150, align:"center", formatter:getLinearGauge},
			 	   		{name:'fsName',index:'fsName', width:250, align:"center"},
			 	   		{name:'spaceUsedPct',index:'spaceUsedPct', width:150, align:"center", formatter:getLinearGauge},
			 	   		{name:'process',index:'process', width:110, align:"center", formatter:getProcessImages}
			 	   		//{name:'process',index:'process', width:110, align:"center"}
			 	   	],
				   	jsonReader : {root: "data"},			//controller에서 가져오는 json명},
					gridview:true,					//gridview를 true해주면 jqgrid성능이 향상됨.
					viewrecords:true,
				   	rowNum: 1000,
				    height: '600px',
				    width : '100%',
				    autowidth:true,
				    shrinkToFit:false, // 가로스크롤
				    loadtext:"조회중입니다." ,
				    resizeable:true,
				    onCellSelect:function(rowid,iCol,cellcontent,e){
				    	var gridData =$("#list").jqGrid('getRowData', rowid);
				    	var hostname = gridData.hostname;
				    	setDetailView(iCol, hostname);
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

			function setDetailView(colname, hostname){
				//서버 상세 정보
				if(colname == 1 || colname == 2 || colname == 3){
					moveDetailView(hostname, "popup-detail", "");
				//이벤트
				/*
		    	}else if(colname == 4){
		    		moveDetailView(hostname, "popup-event", "");
		    	//차트
		    	}else if(colname == 5 || colname == 6 || colname == 7 || colname == 8 || colname == 9
		    			|| colname == 10 || colname == 11 || colname == 12){
		    		moveDetailView(hostname, "popup-chart", colname);
				*/
		    	//프로세스
		    	}else if(colname == 8){
		    		moveDetailView(hostname);
		    	}
			}

			function moveDetailView(hostname){
				location.href = "${contextPath}/mbr/monitoring/status/detail?hostname=" + hostname;
			}

			// 심각도 이미지
			function getSeverityImages(rowId, tv, rowObject) {
				var html = '<span class="event_level1"></span>';
				//var icon = 'icon_green';

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

			// 프로세스 이미지
			function getProcessImages(rowId, tv, rowObject){
				var html = '<button class="cbton bton_lblue"><i class="fa fa-search" style="cursor:pointer;"></i></button>';
				return html;
			}

			$(document).ready(function() {
				App.init();
				loadData();

				//메뉴활성화
				$("#monitoring").addClass("active");
				$("#statusList").addClass("active");
			});

			const label = document.querySelector('.kep-label');
			const options = document.querySelectorAll('.optionItem');
			const handleSelect = function(item) {
			  label.innerHTML = item.innerText;
			  label.parentNode.classList.remove('active');
			}
			for( let i = 0; i < options.length; i++ ){
			  options[i].addEventListener('click', function(){handleSelect(this)})
			}

			label.addEventListener('click', function(){
			  if(label.parentNode.classList.contains('active')) {
			    label.parentNode.classList.remove('active');
			  } else {
			    label.parentNode.classList.add('active');
			  }
			});
		</script>
	</body>
</html>
