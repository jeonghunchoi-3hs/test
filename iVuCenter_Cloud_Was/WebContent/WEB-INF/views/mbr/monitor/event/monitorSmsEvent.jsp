<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="ko" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="ko">
<!--<![endif]-->
<head>
	<meta charset="utf-8" />
	<title>NH(user) Cloudportal System</title>
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
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
			<!-- begin header -->
			<h1 class="page-header"><img src="<%=request.getContextPath()%>/resources/images/title_icon/monitor.png"/>  모니터링  <span class="root"> <img src="/resources/assets/img/root_icon.png"/> 콘솔 > 모니터링 </span></h1>
			<!-- end header -->
			
			<!-- begin page-body -->
			<div class="row mb50">
			
				<!-- search begin -->
				<div class="col-md-12 bgee br10 mb10">
					<div class="col-md-1 p10 mt5 text-right"><b>프로젝트</b></div> 
					<div class="col-md-6 p10">
						<select class="form-control pb6" id="projectId" onchange="gridList();">
						</select>
					</div>
					<div class="col-md-4 p10"></div>
				</div>	
				<!-- search end -->		
					
				<!-- 테이블시작 -->
				<div class="col-md-12">
					<div id="zenius01">
						<iframe class="w100" style="height: 650px;" src="http://10.220.211.200/zenius61/common/login.action?_m=loginLink&userid=testuser&pageUrl=/sms/smsError.action?&pageParam=_m_eq_getMain_am_infraId_eq_10_am_infraName_eq_sms_am_zMenuGroup_eq_0_am_zMenuSub_eq_1"></iframe>					
					</div>
					
				</div>
				<!-- 테이블 끝 -->
				
			</div>
			
			<!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
			
		</div>
		<!-- end #content -->
		
	</div>
	<!-- end page container -->
	<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

	<script type="text/javascript">
	
	function moveDetailPage(hostname, hostnameAlias, vmId){
		location.href = "<%=request.getContextPath()%>/mbr/monitor/event/view?hostname="+hostname+"&hostnameAlias="+hostnameAlias+"&vmId="+vmId;
	}
	
	function gridVMList(){
		$("#VM-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"<%=request.getContextPath()%>/mbr/oss/vm/catalogueVmlist"
				,"type" : "GET"
				,"data":function (d) {
					d.searchKind = "";
					d.keyword = "";
					d.projectId = $("#projectId > option:selected").val();
				}
			}
			,"columns":[
				{"class":"tac"}
				, {"class":"tac"}
				, {"class":"tac"}
				, {"class":"tac"}
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[0], "render": function(data,type,full){
 					return "<a href='#' onclick='moveDetailPage(\""+full.hostname+"\",\""+full.hostnameAlias+"\",\""+full.vmUuid+"\")'>" + full.hostname + "</a>";
					}	
				}
 				, {"targets":[1], "render": function(data,type,full){
 					return "<a href='#' onclick='moveDetailPage(\""+full.hostname+"\",\""+full.hostnameAlias+"\",\""+full.vmUuid+"\")'>" + full.hostname + "</a>"; 
					}	
				}
 				, {"targets":[2], "render": function(data,type,full){
					return full.vcpus+" Core";
					}	
				}
 				, {"targets":[3], "render": function(data,type,full){
					return full.memGb+" GB";
					}	
				}
 				, {"targets":[4], "render": function(data,type,full){
					return full.diskGb+" GB";
					}	
				} 
			]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
					, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});		
	}
	
	function gridEventList() {
		$("#event-list").dataTable( { 
			"processing":true
			,"ordering" : false
			,"destroy" : true
			,"autoWidth":false
			,"serverSide":true
			,"ajax": {
				"url":"<%=request.getContextPath()%>/mbr/monitor/event/list"
				,"type" : "GET"
				,"dateSrc" : ""
				,"data":function (d) {
					d.projectId = $("#projectId > option:selected").val();
					d.state = 'OPEN';
					d.keyword = '';
				}
			}
			,"columns":[
			        	{"data":"hostname", "class":"tac"}
						, {"data":"hostnameAlias", "class":"tac"}
			        	, {"data":"itemType","class":"tac"}
			        	, {"data":"regDatetime2","class":"tac"}
			        	, {"data":"threadhold", "class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
			]
			,"order": [[0,"asc"]]
			,"lengthMenu": [[10,15], [10, 15]]
			,"language": { 
				"zeroRecords":"<p align='center'>검색결과가 없습니다.</p>" 
					, "processing":"<div style='background-color:#fff;padding-top:15px;padding-bottom:15px;'><p align='center' style='color:#bbb; font-weight:bold;'>검색중입니다.</p></div>"  
			}
			,"sDom":'<"top">rt<"bottom"pi>'
		});
	}
	
	function getProjectList(){
		$.ajax({
			url : "<%=request.getContextPath()%>/mbr/req/catalogue/projectPopList",
			dataType : "JSON",
			data : {
				searchValue 		: ""
			},
			success : function(data) {
				$.each(data.getProjectList,function(key,val){
					$("#projectId").append('<option value="'+val.projectId+'">'+(val.projectAlias==""?val.projectName:val.projectAlias)+'</option>');
				});
				$("#projectId option:eq(0)").attr("selected","selected");
				
				if($("#projectId > option:selected").val() != ""){
					gridList();
				}
			},
			error : function(request, status, error) {
				errorBox("code : " + request.status + "\n" + "error : " + request.responseText);
			}
		});
	}

	function gridList(){
		gridEventList();
		gridVMList();
	}
	
	$(document).ready(function(){		
		 App.init();
		 getProjectList();
		 
		//메뉴활성화
		$("#monitor").addClass("active");
		$("#smsEvent").addClass("active");
	});	
		
		
	
		</script>
</body>
</html>
