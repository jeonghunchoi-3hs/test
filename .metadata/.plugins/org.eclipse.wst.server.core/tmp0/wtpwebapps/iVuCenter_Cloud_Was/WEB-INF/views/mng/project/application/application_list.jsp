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
				<h1> 어플리케이션 </h1>
				<div class="pageNav">
					<a href="${contextPath}/mng/login/main" class="home"><i></i></a><a href="#">프로젝트</a><a href="#" class="on">어플리케이션 관리</a>
				</div>
			</div>
			<!-- end header -->

			<!-- begin page-body -->
			<div class="row">

			<!-- search begin -->
			<div class="page_searchBox">
				<div class="searchArea">
					<div class="selectBox">
						<label class="selectText" for="searchKind">전체</label>
						<select class="search-sel width-150" id="searchKind">
							<option value="searchAll">전체</option>
							<option value="project_alias">프로젝트명</option>
							<option value="project_name">프로젝트ID</option>
						</select>
					</div>

						<input type="text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();" class="width-600 ml5">
						<button class="bton-s bton_blue" onclick="gridList()"><i class="fa fa-search"></i> 검색</button>

				</div>
			</div>



			<!-- begin body row -->
			 <div class="row mb50">

						<table id="table-list-app" class="tableV">
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="*">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="9%">
								<col width="8%">
							</colgroup>
							<thead>
								<tr>
									<th>본부  </th>
									<th>처(실)  </th>
									<th>부서 </th>
									<th>프로젝트ID  </th>
									<th>프로젝트명 </th>
									<th>담당자  </th>
									<th>전화번호(사선) </th>
									<th>핸드폰  </th>
									<th>어플리케이션(EA) </th>
									<th>상세</th>
								</tr>
							</thead>
							<tbody>
							<!-- <tr>
							<td>기술혁신본부 </td>
							<td>ICT기획처  </td>
							<td>클라우드구축부 </td>
							<td class="tal">admin </td>
							<td class="tal">admin_projectname  </td>
							<td>관리자 </td>
							<td>061-123-4567 </td>
							<td>010-1111-2222</td>
							<td class="tar">3</td>
							<td><a href='${wasPath}/mbr/application/management/status' class='cbton bton_lblue'><i class='fa fa-search'></i></a></td>
							</tr>-->
							</tbody>
						</table>

                  <div class="clear"></div>
                  <!--pagenation begin-->
                  <!-- <div class="col-lg-12 pl0 pr0 mt20">
                    <span> 총 20건</span>
                      <div class="flr">
                            <ul class="pagination mt0 pagination mb10">
                                <li class="disabled"><a href="javascript:;">«</a></li>
                                <li class="active"><a href="javascript:;">1</a></li>
                                <li><a href="javascript:;">2</a></li>
                                <li><a href="javascript:;">3</a></li>
                                <li><a href="javascript:;">4</a></li>
                                <li><a href="javascript:;">5</a></li>
                                <li><a href="javascript:;">»</a></li>
                            </ul>
                       </div>
                  </div>-->
                  <!--pagenation end-->

				</div>
            <!-- end body row -->

            <!-- begin #footer -->
            <c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
            <!-- end #footer -->
		</div>
		<!-- end #content -->

	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

$(document).ready(function() {
	App.init();
	gridList();

	//메뉴활성화
	$("#project").addClass("active");
	$("#projectApp").addClass("active");

	//tab 첫번째 메뉴 활성화
	$(".nav-pills>li:first-child").addClass("active");
});

function gridList(){
	$("#table-list-app").dataTable( {
		"processing": true
		,"autoWidth": false
		,"serverSide": true
		,"ordering": false
		,"destroy" : true
		,"ajax": {
			"url":"${contextPath}/mng/oss/project/list"
			,"type" : "GET"
			,"data":function (d) {
				d.searchKind = $("#searchKind option:selected").val();
				d.keyword = $("#keyword").val();
				d.customerId = "";
				d.listZeroKind = "app_cnt";
			}
		}
		,"columns":[
			{"data":"deptName2"}
			, {"data":"deptName2"}
			, {"data":"deptName2"}
			, {"data":"projectName"}
			, {"data":"projectAlias", "class":"tal"}
			, {"data":"managerName" }
			, {"data":"managerTelEx" }
			, {"data":"managerPhone" }
			, {"data":"appCnt" , "class":"tac","render":function (data,type,full,meta){
				debugger;
				console.log(full);
				return addcomma(data);
			}}
	        , {"class":"tac"}
		]
		,"columnDefs":[
			{"defaultContent" : "", targets:"_all" }
			, {"targets":[0], "render": function(data,type,full){
				return full.deptName2.split("/")[1];
				}
			}
			, {"targets":[1], "render": function(data,type,full){
				return full.deptName2.split("/")[2];
				}
			}
			, {"targets":[2], "render": function(data,type,full){
				return full.deptName2.split("/")[3];
				}
			}
			, {"targets":[9], "render": function(data,type,full){
				return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='movePageDetail(\""+full.projectBoxId+"\",\""+full.projectName+"\",\""+full.programSeq+"\",\""+full.cloudId+"\")'><i class='fa fa-search'></i></a>";
				}
			}
		]
		,"language": {
			"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
			, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
		}
		,"sDom":'<"top">rt<"bottom"ip>'
	});
}

function movePageDetail(projectBoxId, projectName,programSeq,cloudId){
	var params = "?projectBoxId="+projectBoxId;
	params += "&projectName="+projectName;
	params += "&programSeq="+programSeq;
	location.href = "${contextPath}/mng/project/application/status"+params;
}
</script>
</body>
</html>