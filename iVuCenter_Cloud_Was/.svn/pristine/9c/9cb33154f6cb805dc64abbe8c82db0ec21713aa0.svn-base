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
	<link href="${apachePath}/resources/assets/plugins/jqGrid/css/ui.jqgrid.css" rel="stylesheet" />	
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
				<h1>계열사 관리</h1>
				<div class="pageNav">
					<a href="/mng/mnghome/dashboard?loginFlag=Y" class="home"><i></i></a><a href="#">정책 관리</a><a href="#" class="on">계열사 관리</a>
				</div>
			</div>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row pb50">
			
				<!-- search begin -->
				<div class="page_searchBox m-b-15">
					<div class="searchArea">
						<div class="selectBox" style="width:130px;">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel" id="searchKind">
								<option value="searchAll">전체</option>
								<option value="company_name">구분</option>				
								<option value="customer_name">계열사명</option>				
							</select>
						</div>
						<div class="inputArea m-l-5">
							<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" style="width: 450px">
							<a type='button' class="btn_search" onclick="gridList()">검색</a>
						</div>
					</div>
				</div>
				<!-- search end -->
				
				
				<!-- 테이블시작 -->
				<div class="section2">
					<div class="table_wrap h685">
					<table class="tbl_type01" id="table-list" summary="" cellpadding="0" cellspacing="0">
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
<script type='text/javascript' src="${apachePath}/resources/assets/plugins/jqGrid/i18n/grid.locale-kr.js"></script>
<script type='text/javascript' src="${apachePath}/resources/assets/plugins/jqGrid/jquery.jqgrid.src.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		App.init();
		
		setGrid();
		//getList();
		
	});
	
	function setGrid() {
		$("#table-list").jqGrid('clearGridData', true);
		$("#table-list").jqGrid({
			url: '${contextPath}/mng/cmm/department/TreeAll',
			mtype: "POST",
			datatype:"json",
			postData: {		    	
		    },
			colNames:['부서코드','상위부서코드', '부서명','level','isLeaf', 'isExpanded'],
			colModel:[				
				{name:'deptCode', 	index:'deptCode', 	hidden:false, 	width:100, align:"center", key: true}
				,{name:'upCode', 	index:'upCode', 	hidden:false, 	width:100, align:"left"}
	 	   		,{name:'deptName', 	index:'deptName', 	hidden:false, 	width:300, align:"left"}	 	   			 	   		
	 	   		,{name:'treeLevel', index:'treeLevel', 	hidden:true, 	width:220, align:"left"}
	 	   		,{name:'isLeaf', 	index:'isLeaf', 	hidden:true, 	width:220, align:"left"}
	 	   		,{name:'isExpanded',index:'isExpanded',	hidden:true, 	width:220, align:"left"}	 	   		
			],			
			
// 			rowNum:10,
// 			rowList:[5,10,15],
			rownumbers:false,
			loadonce:false,
			scrollrows:true,
			loadtext : "조회중 잠시만 기다려주세요.",
			//shrinkToFit:false,
// 			height: '100%', //$(".tbl_type01").height()-40,
// 			width : '100%',
			gridview : true,
			treeGrid : true,
			treeGridModel: 'adjacency',
			ExpandColumn: 'deptName',
			ExpandColClick: true,
			tree_root_level: 1,
 			treeIcons: {
 				plus: 'ui-icon-triangle-1-e',
 				minus:'ui-icon-triangle-1-s',
 				leaf: 'ui-icon-radio-off'},
//  			leaf: 'ui-icon-document-b'},
			jsonReader : {
				root: 'data'			//controller에서 가져오는 json명
				, id: 'deptCode'
				, repeatitems: true
			},
			treeReader: {
				level_field: 'treeLevel'
				, parent_id_field: 'upCode'
				, leaf_field: 'isLeaf'
				, expanded_field: 'isExpanded'
			},
			gridComplete: function() {				
			},
			loadError : function(xhr,status, error) {
				alert(error);
			},
			onSelectRow:function(rowid, status, e) {
// 				var list = $('#table-list').getRowData(rowid);				
// 				var code = list.deptCode;				
			},
			onCellSelect:function(rowid, iCol) {
//  				var list = $('#table-list').getRowData(rowid);				
//  				var code = list.deptCode;
//  				var name = list.deptName.split('>');
//  				name = name[name.length -1];
//  				confirmBox(name+"를 적용하시겠습니까?", getList);
			},
			ondblClickRow:function(rowid, iRow, iCol) {
				var list = $('#table-list').getRowData(rowid);				
 				var code = list.deptCode;
 				var name = list.deptName.split('>');
 				name = name[name.length -1];
 				confirmBox(name+"를 적용하시겠습니까?", getList);
			}
		}).trigger('reloadGrid');
	}
	
	function getList() {
		$("#table-list").jqGrid('setGridParam',{
			url: '${contextPath}/mng/cmm/department/TreeAll',
			mtype: "POST",
			datatype:"json",						
			jsonReader : {
				root: "data",			//controller에서 가져오는 json명
				id : "deptCode"			
			}			
		}).trigger("reloadGrid");
	}	
	
</script>
</body>
</html>