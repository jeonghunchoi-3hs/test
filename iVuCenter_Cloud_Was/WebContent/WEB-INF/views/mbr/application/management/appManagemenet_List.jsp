<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="userId" property="principal.username" />
	<sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

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
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->

		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->

		<!-- begin #content -->
		<div id="content" class="content">

			 <p class="page_title">어플리케이션
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원현황  <span class="arrow_ab"> &#8227; </span> <b><a href="${wasPath}/mbr/application/req/">어플리케이션</a> </b>
			    </span>
			</p>

			<!-- begin body row -->
			 <div class="row p20 bgwh br10">

		<!-- 	 <div class="col-md-12 br5 p30 mb20 bgf5 tac">
			 		    <div class="new-search">
				            <div class="left">
					         <div class="choice-kepco">
					         <input type="hidden" name="searchKind" id="searchKind" />
							  <div class="select-kepco" id="__searchKind">
							    <button class="kep-label" value="searchAll">전체 </button>
							    <ul class="optionList">
							      <li class="optionItem" value="project_alias">프로젝트명</li>
							      <li class="optionItem" value="project_name">프로젝트ID</li>
							    </ul>
							  </div>
							</div>
							</div>
							<div class="right">
	                          <input type="text" class="input-kepco" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
	                          <button type="button" class="kepco-ser-icon"  onclick="gridList()"></button>
	                         </div>
                          </div> -->

					<!-- search begin -->
					<div class="col-md-12 br5 p30 mb20 bgee">
						<div class="selectBoxAr">
							<label class="selectText" for="searchKind">전체</label>
							<select class="search-sel" id="searchKind">
									<option value="searchAll">전체</option>
								<option value="project_ name">프로젝트ID</option>
								<option value="project_alias">프로젝트명</option>
							</select>
						</div>
						<div class="search-box">
							<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/>
							<button type="button" class="btn_search2"  onclick="gridList()"><span></span></button>
						</div>
					</div>
				<!-- search end -->

						<table id="table-list-app" class="tableV">
							<colgroup>
								<col width="160px">
								<col width="160px">
								<col width="140px">
								<col width="140px">
								<col width="*">
								<col width="100px">
								<col width="140px">
								<col width="120px">
								<col width="80px">
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
									<th>어플리케이션(EA) </th>
									<th>상세</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>

                  <div class="clear"></div>

				</div>
            <!-- end body row -->

            <!-- begin #footer -->
            <c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
            <!-- end #footer -->
		</div>
		<!-- end #content -->


	<!-- end #content -->
	</div>
<!-- end page container -->

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

	$(document).ready(function() {
		App.init();
		gridList();
		//메뉴활성화
		//메뉴활성화
		$("#myGoods").addClass("active");
		$("#managementApp").addClass("active");
	});

	function gridList(){

		$("#table-list-app").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"${contextPath}/mbr/oss/project/mbrAppList"
				,"type" : "GET"
				,"data":function (d) {
				//	d.searchKind = $("#searchKind option:selected").val();
					d.searchKind = $("#searchKind").val();
					d.keyword = $("#keyword").val();
					d.customerId = "";
				}
			}
			,"columns":[
				  {"data":"deptName2"}
				, {"data":"deptName2"}
				, {"data":"deptName2"}
				, {"data":"projectName"}
				, {"data":"projectAlias", "class":"tal" }
				, {"data":"managerName" }
				, {"data":"managerTelEx" }
				, {"data":"appCnt" , "class":"tac","render":function (data,type,full,meta){
// 					console.log(full);
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
				, {"targets":[8], "render": function(data,type,full){
					return "<a href='javascript:void(0);' class='cbton bton_lblue'  onclick='movePageDetail(\""+full.projectBoxId+"\",\""+full.projectName+"\",\""+full.programSeq+"\",\""+full.cloudId+"\")'><i class='fa fa-search'></i></a>";
					}
				}
			]
			,"language": {
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
				, "processing":"<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
			}
			,"sDom":'<"top"i>rt<"bottom"p>'
		});
	}

	function movePageDetail(projectBoxId, projectName,programSeq,cloudId){
		var params = "?projectBoxId="+projectBoxId;
		params += "&projectName="+projectName;
		params += "&programSeq="+programSeq;
		location.href = "${contextPath}/mbr/application/management/status"+params;
	}

</script>

</body>
</html>
