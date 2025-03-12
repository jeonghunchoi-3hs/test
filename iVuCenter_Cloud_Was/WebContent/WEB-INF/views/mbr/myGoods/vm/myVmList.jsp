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
	<!-- begin #page-loader -->
	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading...</span></div>
	<!-- end #page-loader -->

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
			<h1 class="page-header fc66 fbold"> <i class="fa fa-dot-circle-o fcb"> </i> 나의자원 가상머신 <span class="root">콘솔 > 나의자원 > 가상머신</span></h1>
			<!-- end header -->
			 
			 
			 <!-- begin page-body -->
			 <div class="row mb50">

		
			
			 <!-- search begin -->
			<div class="col-md-12 bgee br10 mb10">
				<div class="col-md-2 p10"> 
	                <select class="form-control" id="searchKind">
		                <option value="searchAll">전체</option>
		                <option value="project">프로젝트</option>
		                <option value="host">호스트명</option>
	                </select>
				</div>
				<div class="col-md-4 p10"> <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="keyword"/></div>
				<div class="col-md-1 tar pr0 mt20">상태</div>
				<div class="col-md-1 p10"> 
	                <select class="form-control" id="statusFlag">
						<option value="statusAll">전체</option>
		                <option value="Y">사용</option>
		                <option value="N">중지</option>
	                </select>
				</div>
				<div class="col-md-1 tar pr0 mt20 pl0">서비스시작일</div>
				<div class="col-md-2 p10">
					<div class="input-group date">
						<input type="text" class="form-control dpin width-100" placeholder="날짜선택" id="startDate"/>
					</div>
				</div>
               <div class="col-md-1 p10"><button type="button" class="btn btn-grey w-100" onclick="gridList();">검색</button></div>
			</div>			
			<!-- search end -->
			
			 <!-- 테이블시작 -->
			 <div class="col-md-12">
                        <div class="panel">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-striped table-td-valign-middle" id="myVmList">
									 <colgroup>
										 <col width="5%">
										 <col width="40%">
										 <col width="15%">
										 <col width="15%">
										 <col width="15%">
										 <col width="10%">
									 </colgroup>
                                    <thead>
                                        <tr class="primary">
                                            <th class="tac"> </th>
                                            <th class="tac">프로젝트</th>
                                            <th class="tac">ZONE</th>
											<th class="tac">호스트명</th>
											<th class="tac">서비스시작일</th>
											<th class="tac">상태</th>
                                        </tr>
                                    </thead>
<!--                                     <tbody id="myVmList"> -->
<!--                                     	<tr> -->
<!-- 											<td><input type="checkbox"/> </td> -->
<!--                                             <td>앵무새앵무새</td> -->
<!--                                             <td>ZONE 의 이름이 들어감. </td> -->
<!-- 											<td>호스트호스트2</td> -->
<!-- 											<td class="tac">2017-04-04</td> -->
<!-- 											<td class="tac">중지</td> -->
<!--                                         </tr> -->
<!--                                     </tbody> -->
                                </table>
                            </div>
                        </div>
						<!-- begin pagination -->
						
						<div class="col-md-12">
							<div class="col-md-12 tar"> <a href="#modal-dialog" class="btn btn-danger width-80" data-toggle="modal">중지</a> &nbsp;<a href="#modal-dialog2" class="btn btn-primary width-80" data-toggle="modal">사용</a></div>
						</div>
							
						
						<!-- end pagination -->
						
						
			 </div>
              <!-- 테이블 끝 -->

			</div>
			<!---- end page body---->
			
			
						<!-- #modal-dialog -->
                            <div class="modal fade" id="modal-dialog">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title fw">가상머신 중지</h4>
                                        </div>
                                        <div class="modal-body">
                                            <h5>선택하신 가상머신을 중지 하시겠습니까? </h5>
                                          

                                        </div>
                                        <div class="modal-footer tac">
										    <a type='button' class="btn width-100 btn-danger">중지</a>
                                            <a type='button' class="btn width-100 btn-default" data-dismiss="modal">취소</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
							
							
							
							<!-- #modal-dialog  해지-->
                            <div class="modal fade" id="modal-dialog2">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title fw">가상머신 사용</h4>
                                        </div>
                                        <div class="modal-body">
                                            <h5>선택하신 가상머신을 사용 하시겠습니까? </h5>
                                          

                                        </div>
                                        <div class="modal-footer tac">
										    <a type='button' class="btn width-100 btn-primary">사용</a>
                                            <a type='button' class="btn width-100 btn-default" data-dismiss="modal">취소</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
			
			
			
			
			
		
             	<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->

		</div>
		<!-- end #content -->
	
	</div>
	<!-- end page container -->
	
</body>


<script type="text/javascript">
	var oTable;
	
	
	function gridList() {
		 
		 oTable = $("#myVmList").dataTable( {
				"processing":true
				,"ordering" : false
				,"destroy" : true
				,"autoWidth":false
				,"serverSide":true
			,"ajax": {
				"url":"myVmList"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.searchKind = $("#searchKind > option:selected").val();
					d.delFlag = $("#statusFlag > option:selected").val();
					d.keyword = $("#keyword").val();
					d.regDatetime = $("#startDate").val();
				}
			}
			,"columns":[ 
			        	 {"data":"projectName", "class":"tac"}
			        	, {"data":"projectName", "class":"tac"}
			        	, {"data":"hostName", "class":"tac"}
			        	, {"data":"regDatetime", "class":"tac"}
			        	, {"data":"delFlag", "class":"tac"}
			        	, {"defaultContent":"<button onclick='moveDetailPage()' >VM 상세보기</button>", "class":"ditailStyle tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all"}
			]
			,"order": [[0,"asc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
					, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>',"oTableTools": {
				"aButtons":[ {
					"sExtends":"text"
					,"sButtonText":"등록"
					,"fnClick":function(nButton,oConfig,oFlash) {
						
					}
				}]
			}
		});
	}

	// 달력
	function calendar(){
		
		var dayName = ['일','월','화','수','목','금','토'];
		var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

		$("#startDate").datepicker({
			showOn:"both",
			buttonImage:"${apachePath}/resources/assets/img/calen.png",
			buttonImageOnly:true,
			dateFormat : "yy-mm-dd",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});

	}	


	
	
	$(document).ready(function() {
	    App.init();
	    calendar();
	    gridList();
		
		$("a>button").live('click',function(){
		location.href = $(this).closest("a").attr("href");
		});
		
		//메뉴활성화
		$("#myGoods").addClass("active");
		$("#myVm").addClass("active");
	});
</script>

</html>
