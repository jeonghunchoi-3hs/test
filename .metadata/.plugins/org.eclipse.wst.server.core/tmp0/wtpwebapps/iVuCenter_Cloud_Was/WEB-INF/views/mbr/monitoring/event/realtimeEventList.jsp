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

				 <p class="page_title">이벤트 발생 현황
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 모니터링  <span class="arrow_ab"> &#8227; </span> <b>이벤트 발생 현황 </b>
			    </span>
			    </p>

                    <input type="hidden" id="h_source"/>
                    <input type="hidden" id="h_firstoccurtime"/>
                    <input type="hidden" id="h_identifier"/>
                    <input type="hidden" id="h_tally"/>
                    <input type="hidden" id="h_severityName"/>
                    <input type="hidden" id="h_alertgroup"/>
                    <input type="hidden" id="h_agent"/>
                    <input type="hidden" id="h_alertkey"/>
                    <input type="hidden" id="h_eventAt"/>

				<!-- begin #content page-body -->
			<div class="row p20 bgwh br10">
				<div >
					<div class="col-md-12 br5 p30 mb20 bgee">
						<div class="selectBoxAr" style="border:0;">
							<select id="searchKind" class="form-control">
								<option value="searchAll">전체</option>
									<option value="hostname_alias">서버명</option>
									<option value="hostname">호스트명</option>
									<option value="summary">메세지</option>
									<option value="severityName">등급</option>
							</select>
						</div>
						<div class="search-box">
							<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)loadData();"/>
							<button type="button" class="btn_search2"  onclick="loadData()"><span></span></button>
						</div>
					</div>
				</div>
				<!-- search end -->

                    <div class="wrap">
                        <div class="mb30">
                            <div class="mt-3 col-md-12">
                                <ul class="event-status-list-wrap mt20" id="eventAt">
                                    <li class="event-status-05"><a onclick="eventAtSet('critical')"><span>심각(${eventCnt.criticalCnt})</span></a></li>
                                    <li class="event-status-02"><a onclick="eventAtSet('warning')"><span>경고(${eventCnt.warningCnt})</span></a></li>
                                    <li class="event-status-03"><a onclick="eventAtSet('info')"><span>주의(${eventCnt.infoCnt})</span></a></li>
                                </ul>
                                <div class="overflow-wrapper mt10">
                                    <table id="list" class="tableV">
                                        <colgroup>
                                            <col width="*" />
                                            <col width="*" />
                                            <col width="*" />
                                            <col width="*" />
                                            <col width="*" />
                                            <col width="*" />
                                            <col width="*" />
                                            <col width="15%" />
                                            <col width="80px" />
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th>망구분</th>
                                                <th>프로젝트</th>
                                                <th>서버명</th>
                                                <th>발생일시</th>
                                                <th>소스</th>
                                                <th>호스트명</th>
                                                <th>등급</th>
                                                <th>이벤트내용</th>
                                                <th>확인</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
				<!---- end page body---->
                <!-- 모달 시작 -->
				<div class="modal fade" id="eventDetailView" tabindex="-1" role="dialog" aria-hidden="true">
				    <div class="modal-dialog modal-dialog-centered" role="document">
				        <div class="modal-content width-700">
				            <div class="modal-header">
				                <h5 class="modal-title">상세</h5>
				                <button type="button" class="btn btn-close btn-close-black" data-dismiss="modal" aria-label="Close"></button>
				            </div>
				            <div class="modal-body ">
				                <div class="tab">
				                    <ul class="nav nav-tabs" role="tablist">
				                        <li class="nav-item"><a class="nav-link active" href="#tab-1" data-toggle="tab" role="tab">자원정보</a></li>
				                        <li class="nav-item"><a class="nav-link" href="#tab-2" data-toggle="tab" role="tab">이벤트</a></li>
				                    </ul>
				                    <div class="tab-content active">
				                        <div class="tab-pane active" id="tab-1" role="tabpanel">
				                            <table>
											<colgroup>
												<col width="140px"/>
												<col width="*"/>
												<col width="140px"/>
												<col width="*"/>
											</colgroup>
				                                <tbody>
				                                    <tr>
				                                        <th>망구분</th>
				                                        <td><input type="text" class="form-control" id="zoneDisplayName" readonly></td>
				                                        <th>프로젝트</th>
				                                        <td><input type="text" class="form-control" id="projectName" readonly></td>
				                                    </tr>
				                                    <tr>
				                                        <th>소스</th>
				                                        <td><input type="text" class="form-control" id="source" readonly></td>
				                                        <th>IP 주소</th>
				                                        <td><input type="text" class="form-control" id="ip" readonly></td>
				                                    </tr>
				                                    <tr>
				                                        <th>호스트명</th>
				                                        <td colspan="3"><input type="text" class="form-control" id="hostname" readonly></td>
				                                    </tr>
				                                    <tr>
				                                        <th>모델명</th>
				                                        <td><input type="text" class="form-control" id="model" readonly></td>
				                                        <th>OS</th>
				                                        <td><input type="text" class="form-control" id="osname" readonly></td>
				                                    </tr>
				                                    <tr>
				                                        <th>OS 버전</th>
				                                        <td><input type="text" class="form-control" id="ostype" readonly></td>
				                                        <th>CPU Core 수</th>
				                                        <td><input type="text" class="form-control" id="corecnt" readonly></td>
				                                    </tr>
				                                    <tr>
				                                        <th>메모리 총량</th>
				                                        <td><input type="text" class="form-control" id="pmemgb" readonly></td>
				                                        <th>내장 Disk 총량</th>
				                                        <td><input type="text" class="form-control" id="disktotalgb" readonly></td>
				                                    </tr>
				                                </tbody>
				                            </table>
				                        </div>
				                        <div class="tab-pane" id="tab-2" role="tabpanel">
				                            <table>
											<colgroup>
												<col width="140px"/>
												<col width="*"/>
												<col width="140px"/>
												<col width="*"/>
											</colgroup>
				                                <tbody>
				                                    <tr>
				                                        <th>발생일시</th>
				                                        <td><input type="text" class="form-control" id="firstoccurtime" readonly></td>
				                                        <th>심각도</th>
				                                        <td><input type="text" class="form-control" id="severityName" readonly></td>
				                                    </tr>
				                                    <tr>
				                                        <th>메세지</th>
				                                        <td colspan="3"><input type="text" class="form-control" id="message" readonly></td>
				                                    </tr>
				                                    <tr>
				                                        <th>경고그룹</th>
				                                        <td><input type="text" class="form-control" id="alertgroup" readonly></td>
				                                        <th>경고키</th>
				                                        <td><input type="text" class="form-control" id="alertkey" readonly></td>
				                                    </tr>
				                                    <tr>
				                                        <th>관리 장비수</th>
				                                        <td><input type="text" class="form-control" id="tally" readonly></td>
				                                        <th>에이전트</th>
				                                        <td><input type="text" class="form-control" id="agent" readonly></td>
				                                    </tr>
				                                    <tr>
				                                        <th>이벤트 내용</th>
				                                        <td colspan="3"><input type="text" class="form-control" id="identifier" readonly></td>
				                                    </tr>
				                                </tbody>
				                            </table>
				                        </div>
				                    </div>
				                </div>
				            </div>
				            <div class="modal-footer btn-wrap">
				                <button class="btn btn-del wid-75" onclick="loadDelete()">삭제</button>
				                <!-- <button class="btn btn-primary wid-75">장애등록</button> -->
				                <button class="btn btn-outline-primary wid-75" data-dismiss="modal" aria-label="close">닫기</button>
				            </div>
				        </div>
				    </div>
				</div>
                <!-- 모달 끝 -->
	          	<!-- begin #content footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->
			</div>
			<!-- end #content -->
		</div>
		<!-- end page container -->

		<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

		<script type="text/javascript" src="${apachePath}/resources/js/plugins/jquery.jqGrid.js"></script>
		<script type="text/javascript">

		function eventAtSet(at){
		    $("#h_eventAt").val(at);
		    loadData();
		}

	    function loadData(){
	        $("#list").DataTable({
	            "processing": true,
	            "autoWidth": true,
	            "serverSide": true,
	            "ordering": false,
	            "destroy": true,
	            "searching": false,
	            "lengthChange": false,
	            "responsive": true,
	            "ajax": {
	                "url": "${contextPath}/mbr/monitoring/event/mbrList",
	                "type": "GET",
	                "data": function (d) {
	                    d.searchKind = $("#searchKind option:selected").val();
	                    d.keyword = $("#keyword").val();
	                    d.eventAt = $("#h_eventAt").val();
	                },
	                "complete": function(obj, status){
	                    if(status === 'success'){
	                        afterLoad(obj.responseJSON);
	                    }
	                }
	            },
	            "columns": [
	                {"data": "zoneDisplayName"},
	                {"data": "projectName"},
	                {"data": "hostnameAlias"},
	                {"data": "firstoccurtime"},
	                {"data": "source"},
	                {"data": "hostname"},
	                {"data": "severityName"},
	                {"data": "identifier"},
	                {}
	            ],
	            "createdRow": function(row, data, dataIndex) {
	                $(row).attr("id", "id_" + dataIndex);
	            },
	            "columnDefs":[
	                {"defaultContent" : "", targets:"_all" },
	                {"targets":[0], "render": function(data,type,full){
	                    return full.zoneDisplayName;
	                }},
	                {"targets":[1], "render": function(data,type,full){
	                    return full.projectName;
	                }},
	                {"targets":[2], "render": function(data,type,full){
	                    return full.hostnameAlias;
	                }},
	                {"targets":[3], "render": function(data,type,full){
	                    return full.firstoccurtime;
	                }},
	                {"targets":[4], "render": function(data,type,full){
	                    return full.source;
	                }},
	                {"targets":[5], "render": function(data,type,full){
	                    return full.hostname;
	                }},
	                {"targets":[6], "render": function(data,type,full){
	                    return full.severityName;
	                }},
	                {"targets":[7], "render": function(data,type,full){
	                    return "<div style='white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px;' title='" + full.identifier + "'>" + full.identifier + "</div>";
	                }},
	                {"targets":[8], "orderable" : false, "render" : function(data,type,full){
	                    return "<a class='cbton bton_lblue' onclick='popupDetail(\""+full.zoneDisplayName+"\",\""+full.projectName+"\",\""+full.source+"\",\""+full.hostname+"\",\""+full.ip+"\",\""+full.model+"\",\""+full.osname+"\",\""+full.ostype+"\",\""+full.corecnt+"\",\""+full.pmemgb+"\",\""+full.disktotalgb+"\",\""+full.firstoccurtime+"\",\""+full.identifier+"\",\""+full.tally+"\",\""+full.severityName+"\",\""+full.alertgroup+"\",\""+full.agent+"\",\""+full.alertkey+"\")' ><i class='fa fa-search'></i></a>";
	                }}
	            ],
	            "order": [[3, "desc"]],
	            "lengthMenu": [[10, 15], [10, 15]],
	            "language": {
	                "zeroRecords": "<p align='center'>검색결과가 없습니다.</p>",
	                "processing": "<div style='background-color:#fff;padding-top:50px;padding-bottom:50px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"
	            },
	            "sDom": '<"top">rt<"bottom"pi>'
	        });
	    }

		function popupDetail(zoneDisplayName, projectName, source, hostname, ip, model, osname, ostype, corecnt, pmemgb, disktotalgb, firstoccurtime, identifier, tally, severityName, alertgroup, agent, alertkey){
			$("#h_zoneDisplayName").val(zoneDisplayName);
			$("#h_projectName").val(projectName);
			$("#h_source").val(source);
			$("#h_hostname").val(hostname);
			$("#h_ip").val(ip);
			$("#h_model").val(model);
			$("#h_osname").val(osname);
			$("#h_ostype").val(ostype);
			$("#h_corecnt").val(corecnt);
			$("#h_pmemgb").val(pmemgb);
			$("#h_disktotalgb").val(disktotalgb);
			$("#h_firstoccurtime").val(firstoccurtime);
			$("#h_identifier").val(identifier);
			$("#h_tally").val(tally);
			$("#h_severityName").val(severityName);
			$("#h_alertgroup").val(alertgroup);
			$("#h_agent").val(agent);
			$("#h_alertkey").val(alertkey);
			$("#eventDetailView").modal('show');
			deviceDetail();
		}

		function deviceDetail(){
			$.ajax({
				url : "${contextPath}/mbr/monitoring/event/resource-info/hostname2",
				dataType : "JSON",
				type : "POST",
				data : {
					"identifier" : $("#h_identifier").val()
				},
				success : function(data) {
					setData(data);
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

		function setData(data) {
		    delete data.length;
		    $.each(data, function(key, val) {
		        if ($("#" + key).is("select")) {
		            $("#" + key + " option").each(function() {
		                if ($(this).val() == val) {
		                    $(this).prop("selected", true);
		                }
		            });
		        } else {
		            $("#" + key).val(val);
		        }
		    });
		}

		function loadDelete(){
			$.ajax({
				url : "${contextPath}/mbr/monitoring/event/delete",
				dataType : "JSON",
				type : "POST",
				data : {
					  "identifier" : $("#identifier").val()
				},
				success : function(data) {
					if(data==1){
						alertBox("삭제되었습니다.", function() {
						location.reload();
						});
					} else {
						alertBox3("삭제 실패");
					}
				},
				error : function(request, status, error) {
					errorBox("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}

		function afterLoad(obj) {
		    var listData = $("#list").DataTable();
		    var rowData = listData.rows().data();
		    for (var i = 0; i < rowData.length; i++) {
		        var severity = listData.row(i).data().severity;
		        var rowid = listData.row(i).index();
		        switch (severity) {
		            case 'critical':
		                $("#id_" + rowid).addClass('event-status-05');
		                break;
		            case 'info':
		                $("#id_" + rowid).addClass('event-status-03');
		                break;
		            case 'warning':
		                $("#id_" + rowid).addClass('event-status-02');
		                break;
		            default:
		                break;
		        }
		    }
		}

	$(document).ready(function() {
		App.init();
		loadData();

		//메뉴활성화
		$("#monitoring").addClass("active");
		$("#eventList").addClass("active");

// 		$("#searchKind").val("searchAll");
	});

		</script>

	</body>
</html>
