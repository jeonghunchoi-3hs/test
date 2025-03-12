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
			<h1 class="page-header fc66 fbold"> <i class="fa fa-cubes fcb"> </i> 부가자원 <span class="root">콘솔 > 카달로그 > 목록</span></h1>
			<!-- end header -->

			 <!-- begin page-body -->
			 <div class="row mb50">
				<h4 class="pl20 f16">ㆍ자원정보 </h4>
				<!----첫번째 자원내용------->
				<c:set var="totalPrice" value="" />
				<c:set var="cpuPrice" value="" />
				<c:set var="memPrice" value="" />
				<c:set var="memPrice1" value="" />
				<c:set var="diskPrice" value="" />
				<c:set var="diskPrice1" value="" />
				<c:set var="osPrice" value="" />
				<c:set var="priceTypeTxt" value="" />
				<c:choose>
					<c:when test="${getCatalogueSelectView.hourlyFlag eq 'Y'}">
						<c:set var="cpuPrice" value="${getCatalogueSelectView.cpuHourlyPrice}" />
						<c:set var="memPrice" value="${getCatalogueSelectView.memGb * getCatalogueSelectView.memHourlyPrice}" />
						<c:set var="memPrice1" value="${getCatalogueSelectView.memHourlyPrice}" />						
						<c:set var="diskPrice" value="${getCatalogueSelectView.diskHourlyPrice * 10}" />
						<c:set var="diskPrice1" value="${getCatalogueSelectView.diskHourlyPrice * getCatalogueSelectView.diskGb / 10}" />
						<c:set var="totalPrice" value="${getCatalogueSelectView.vcpus * cpuPrice + memPrice + diskPrice1}" />
						
					</c:when>
					<c:otherwise>
						<c:set var="cpuPrice" value="${getCatalogueSelectView.cpuMonthlyPrice}" />
						<c:set var="memPrice" value="${getCatalogueSelectView.memGb * getCatalogueSelectView.memMonthlyPrice}" />
						<c:set var="memPrice1" value="${getCatalogueSelectView.memMonthlyPrice}" />
						<c:set var="diskPrice" value="${getCatalogueSelectView.diskMonthlyPrice * 10}" />
						<c:set var="diskPrice1" value="${getCatalogueSelectView.diskMonthlyPrice * getCatalogueSelectView.diskGb / 10}" />
						<c:set var="totalPrice" value="${getCatalogueSelectView.vcpus * cpuPrice +  memPrice + diskPrice1}" />						
					</c:otherwise>
				</c:choose>
				
				<div class="col-md-12">
				  <div class="col-md-12 bgf2 b1s">
					<div class="col-md-3 br5 bgwh tac mt10 mb10 vm p35"><img src="${getCatalogueSelectView.imagePath}" class="w100">
					</div>
					<div class="col-md-9 pr0">
						<h5 class="bgdb p10 fcdb f16">${getCatalogueSelectView.displayName} </h5>
						<li class="fcdb f14 pl20 fb"> 안정성</li>
						<li class="fc66 pl20 pb5 mb5">- 업계 최고의 데이터 지속성과 복구성을 제공 </li>
						<li class="fcdb f14 pl20 fb"> 효율성</li>
						<li class="fc66 pl20 pb5 mb5">- 운영체제를 통해 직접 스토리지에 엑세스하므로 대기시간이 줄어듬 </li>
						<li class="fcdb f14 pl20 fb"> 예측가능한 비용청구</li>
						<li class="fc66 pl20 mb5">- 정해진 비용만 청구. 추가비용이 없음.  </li>
						<li class="fcdb f14 pl20 fb"> 신청단위</li>
						<li class="fc66 pl20">- 10GB  </li>
						
					</div>
				  </div>
				</div>
				<!----첫번째 자원내용 끝------->
				<div class="clear"></div>
				<h4 class="pl20 mt20 f16">ㆍ신청정보 </h4>
				<div class="col-md-12">
					<div class="col-md-12 machine">
					<div class="tableF">
					<form name="catalogueform"  id="catalogueform" action="catalogueDiskOrderNow.do" method="post" >
						<input type="hidden" name="imagePath" id="imagePath" value="${getCatalogueSelectView.imagePath}" />
						<input type="hidden" name="type" id="type" value="noworder" />
						<input type="hidden" name="productSeq" id="productSeq" value="${getCatalogueSelectView.productSeq}" />
						<input type="hidden" name="totalPrice" id="totalPrice" value="${totalPrice}" />
						<input type="hidden" name="productCategory" id="productCategory" value="${getCatalogueSelectView.productCategory}" />
						<!-- <input type="hidden" name="hourlyFlag" id="hourlyFlag" value="${getCatalogueSelectView.hourlyFlag}" /> -->
						<input type="hidden" name="networkChk" id="networkChk" value="" />
					
						<table>
						<colgroup>
						<col width="150px">
						<col width="*">
						</colgroup>
						<tbody>
						<tr>
						<td class="left-b th20">이용요금</td>
							<td>
								<input type="radio" id="hourlyFlag1" name="hourlyFlag" value="N" checked class="va-tb"/> <span class="mr50">월 단위 </span> <input type="radio" id="hourlyFlag2" name="hourlyFlag" value="Y" class="va-tb"/> 시간 단위 </span>
							</td>
						</tr>
						<tr>
						<td class="left-b th20">서비스희망일시</td>
						<td>
							<input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> <span class="mr14">희망일시 생성 </span>
							<input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성	 <br/>						
							<p class="fc-red mb10">* 승인 완료 후 생성 선택시 클라우드 관리자에 최종 승인 완료 후 블록디스크가 생성이 됩니다. </p>
						</td>
						</tr>
						<tr id="sdate" name="sdate" style="display:none">
						<td class="left-b th20"></td>
						<td>
						<div>
							<input type="text" class="form-control dpin width-100" id="applyDate" name="applyDate"  placeholder="날짜선택"/>
							<input type="text" class="form-control dpin width-80 ml50" placeholder="18:00"  value="18" id="applyTime" name="applyTime"  readonly/> 시
							<button type="button" class="btn btn-grey ml20" onclick="applyTimePlus();"><i class="fa fa-plus"></i> </button>
							<button type="button" class="btn btn-grey ml10" onclick="applyTimeMinus();"><i class="fa fa-minus"></i> </button> 
						</div>			
						</td>
						</tr>
						
						<tr>
						<td class="left-b th20">프로젝트</td>
						<td>
							<input class="form-control w80 dpin" type="text" name="projectName" id="projectName" readonly /> 
							<input type="hidden" name="projectId" id="projectId" value="" />  	
							<input type="button" value="검색" onclick="openModal();" class="btn btn-grey mt-4"/> 
						</td>
						</tr>
						
						<tr>
						<td class="left-b th20">가상서버</td>
						<td> 
							<input class="form-control w80 dpin" type="text"  name="vmName" id="vmName" readonly /> 
							<input type="hidden"  name="vmUuid" id="vmUuid" />
							<input type="button" value="검색" onclick="openModal2();" class="btn btn-grey mt-4" name="vmBtn" id="vmBtn" style="display:none"/>
						</td>
						</tr>
						<tr>
						<td class="left-b th20">블록디스크 이름</td>
						<td><input class="form-control" type="text" name="diskName" id="diskName"  /></td>
						</tr>
						<tr>
						<td class="left-b">블록 디스크 용량</td>
						<td>
						<div class="col-md-8 pr0 pl0">
							<input class="form-control width-80 dpin" type="text"  placeholder="1" value="${getCatalogueSelectView.diskGb}" maxlength="5" name="diskcnt" id="diskcnt" onkeypress="number_only(this);" onkeyup="number_only(this);" onblur="number_only(this);" style="ime-mode:disabled;" onfocusout="diskfocusout(this);" onkeyup="diskchange(this);" /> <p class="width-50 dpin"> GB </p>
							
							<input type="hidden" name="diskprice" id="diskprice" value='<fmt:formatNumber value="${diskPrice}" pattern="####"/>'>
							<input type="hidden" name="diskprice1" id="diskprice1" value='<fmt:formatNumber value="${diskPrice1}" pattern="####"/>'>
														
							<button type="button" class="btn btn-grey mt-4 ml20" onclick="diskplus();"> <i class="fa fa-plus"></i> </button> 
							<button type="button" class="btn btn-grey mt-4 ml10" onclick="diskminus();"> <i class="fa fa-minus"></i> </button> 
							
						</div>
						<div class="col-md-4 f20 fcb tar pr10 dpin">
						<span id="diskpriceview" name="diskpriceview" >
							<fmt:formatNumber value="${diskPrice1}" pattern="#,###"/>														
						</span>	
						<input type="hidden" name="imdiskprice" id="imdiskprice" value="<fmt:formatNumber value="${diskPrice}" pattern="####"/>" />
						<input type="hidden" name="imdiskcnt" id="imdiskcnt" value="<fmt:formatNumber value="${getCatalogueSelectView.diskGb}" pattern="####"/>" />
						<span class="f12 fc66">원 </span>		
						</div>
						</td>
						</tr>
						<tr>
						<td class="left-b">설명</td>
						<td>						
						<textarea class="form-control" rows="5"  id="description"  name="description" placeholder="내용을 입력하세요"></textarea>
						</td>
						</tr>
					
						</tbody>
						</table>
						</form>
				</div>
				</div>
				
			
			
				
				<!--다섯번째 상자---->
				<div class="col-md-12 disk mt20">
					<div class="col-md-8"><h4 class="fc66">총합계 (월 청구금액 VAT 별도)</h4></div>
					<div class="col-md-4 f24 fc-red tar pr20">
					<span id="totalpriceview" name="totalpriceview"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/> </span>
					<span class="f12 fc66">원 </span>
						<input type="hidden" name="imamount" id="imamount" value='<fmt:formatNumber value="${totalPrice}" pattern="#,###"/>' />
						<input type="hidden" name="amount" id="amount" value='<fmt:formatNumber value="${totalPrice}" pattern="####"/>' />
					</div>
								
				</div>
				<!--다섯번째 상자//---->


			
			</div>
				
				
				<div class="col-md-12 tac p20 mt20">
                      <button type="button" class="btn btn-primary width-100" onclick="noworder();">바로신청</button>&nbsp;
					  <button type="submit" class="btn btn-lime width-100" onclick="basketorder();">일괄신청</button>&nbsp;
                      <button type="submit" class="btn btn-grey width-80" onclick="moveListPage()">취소</button>
				</div>	

				
			</div>
			<!---- end page body---->
			
			
			
				<!-- #modal-dialog 프로젝트검색-->				
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">프로젝트 검색</h4>
	                       </div>
	                       <div class="modal-body">
<!-- 	                           <p class="m-b-20"> -->
	                              <div class="col-md-9 p10"> <input type="text" id="searchKeyword" value="" /></div>
	                              <div class="col-md-1 p10"><input type="button" value="검색" onclick="projectPopList();"/></div> 
<!-- 	                           </p> -->
								
								<div>
									<table class="table table-bordered table-hover table-striped table-td-valign-middle">
										<colgroup>
									 		<col width="40%">
									 		<col width="40%">
									 		<col width="20%">
									 	</colgroup>
									 	<thead>
									 		<tr class="primary">
												<th class="left th20 tac">프로젝트 영문명</th>
												<th class="left th20 tac">프로젝트명</th>
												<th class="left th20 tac">적용</th>
											</tr>
									 	</thead>
										<tbody id="popListTable">
											
										</tbody>
									
									</table>
								</div>	
								
	                      	</div>
	                       	<div class="modal-footer tac">
	                   			<a type="button" class="btn width-100 btn-default" data-dismiss="modal">닫기</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
			<!-- #modal-dialog  프로젝트 검색//-->
						
						
						
						<!-- #modal-dialog 가상서버검색-->
                            <div class="modal fade" id="modal-dialog2">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title fw">가상서버 검색</h4>
                                        </div>
                                        <div class="modal-body p1510">
											 <!-- search begin -->
												<div class="col-md-12 bgee br10 mb10">		
													
												   <div class="col-md-10 p10"><input type="text" class="form-control" placeholder="검색어를 입력하세요" /></div>
												   <div class="col-md-1 p10"><a href="#"><button type="button" class="btn btn-grey lh20">검색</button></a> </div>

												</div>			
											<!-- search end -->
	
										   
										   <div class="clear"></div>
											 <div class="tableD mt20">
											 
											 <table id="VM-list">
											 <colgroup>
											 <col width="20%">
											 <col width="20%">
											 <col width="20%">
											 <col width="20%">
											 <col width="20%">
											 </colgroup>
											 <thead>
											 <tr>
											 <th class="tac fw">자원이름</th>
											 <th class="tac fw">CPU</th>
											 <th class="tac fw">MEM</th>
											 <th class="tac fw">DISK</th>
											 <th class="tac fw">적용</th>
											 </tr>
											 </thead>
											 <tbody id="popListTable2">
											 
											 </tbody>
											 </table>
											 </div>
                                        </div>
										<div class="clear"></div>
                                        <div class="modal-footer tac">
                                          <a type="button" class="btn btn-default" data-dismiss="modal">닫기</a>
                                          
                                        </div>
                                    </div>
                                </div>
                            </div>
						<!-- #modal-dialog  가상서버 검색//-->
			
			
            <!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->
	
	</div>
	<!-- end page container -->
	
	<script type="text/javascript">
$(document).ready(function(){
    App.init();
    //Demo.init();
   // PageDemo.init();
   diskOrderView();
	
	$("a>button").live('click',function(){
	location.href = $(this).closest("a").attr("href");
	});
	
	var dayName = ['일','월','화','수','목','금','토'];
	var monthName = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

		$("#applyDate").datepicker({
			showOn:"both",
			buttonImage:"/resources/assets/img/calen.png",
			buttonImageOnly:true,
			dateFormat : "yy-mm-dd",
			dayNamesMin:dayName,
			monthNamesShort:monthName,
			changeMonth:true,
			minDate:0
		});
	
		$("img.ui-datepicker-trigger").attr("style", "vertical-align:bottom;");

	$.datepicker.gotoToday=function(id){
		$(id).datepicker('setDate',newDate()).datepicker('hide').blur();
	};
	
	if($("input[name='onDemandFlag']:checked").val()=="N"){					
    	$("#sdate").show();				
	}else{
		$("#sdate").hide();
	}
	
	$("input[name='hourlyFlag']").live('click',function(){	
		diskOrderView();	
		//alert($("input[name='hourlyFlag']:checked").val());
	});
	
});

$("input[name='onDemandFlag']").live('click',function(){	
	//alert($("input[name='onDemandFlag']:checked").val());
	if($("input[name='onDemandFlag']:checked").val()=="N"){				
		$("#sdate").show();					
	}else{
		$("#sdate").hide();
	}
	
});

function applyTimePlus(){			
//		alert($("#applyTime").val());
	
	if($("#applyTime").val()=="23"){
		alert("시간을 정확히 입력해 주세요.");
	}else{
		var applyTime;
		applyTime = Number(rtnnumber($("#applyTime").val())) + 1;
		$("#applyTime").val(applyTime);
	}
}
function applyTimeMinus(){
	//alert($("#memcnt").val());
	if($("#applyTime").val()=="0"){
		alert("시간을 정확히 입력해 주세요.");
	}else{
		var applyTime;
		applyTime = Number(rtnnumber($("#applyTime").val())) - 1;
		$("#applyTime").val(applyTime);
	}
}

function rtnnumber(n){
	n=n.replace(/,/g,"");
	if(isNaN(n)){
		return 0;
	}else{
		return n;
	}
}

function addcomma(n){
	if(isNaN(n)){
		return 0;
	}else{
		var reg=/(^[+-]?\d+)(\d{3})/;
		n +='';			
		while(reg.test(n)){
			n=n.replace(reg,'$1'+','+'$2');
		}				
	return n;
	}
}

//---> Modal popup start

//modal팝업 open
function openModal(){
	$("#modal-dialog").modal();
	projectPopList();
}


function openModal2(){
	$("#modal-dialog2").modal();
	gridVMList();
}

// 팝업리스트
	function gridVMList(){
		$("#VM-list").dataTable( {
			"processing": true
			,"autoWidth": false
			,"serverSide": true
			,"ordering": false
			,"destroy" : true
			,"ajax": {
				"url":"<%=request.getContextPath()%>/mbr/oss/vm/list"
				,"type" : "GET"
				,"data":function (d) {
					//d.searchKind = $("#vm_searchKind option:selected").val();
					//d.keyword = $("#vm_keyword").val();
					d.searchKind = "";
					d.keyword = "";
					d.projectName = $("#projectName").val();
					d.projectId = $("#projectId").val();
				}
			}
			,"columns":[
				{"data":"hostnameAlias" , "class":"tac"}
				, {"data":"vcpus" , "class":"tac"}
				, {"data":"memGb" , "class":"tac"}
				, {"data":"diskGb" , "class":"tac"}	
				, {"class":"tac"}
			]
			,"columnDefs":[
				{"defaultContent" : "", targets:"_all" }
 				, {"targets":[1], "render": function(data,type,full){
					return full.vcpus+" Core";
					}	
				}
 				, {"targets":[2], "render": function(data,type,full){
					return full.memGb+" GB";
					}	
				}
 				, {"targets":[3], "render": function(data,type,full){
					return full.diskGb+" GB";
					}	
				}
 				, {"targets":[4], "render": function(data,type,full){
					return '<div class="col-md-12 tar"><a href="#nav-pills-tab-3-view" data-toggle="tab"><button type="button" data-dismiss="modal" class="btn btn-primary width-60" onclick="setVM(\''+full.vmUuid+'\',\''+full.hostnameAlias+'\')">적용</button></a></div>';
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
	
function projectPopList(){
	
	var keyword = $("#searchKeyword").val();
	
	$.ajax({
		url : "projectPopList",
		dataType : "JSON",
//			type : "POST",
		data : {
			"searchValue" : keyword
		},
		success : function(data) {
			var projectList = data.getProjectList;
			
			if(projectList!=""){
				
				$("#popListTable > tr").remove();
				$.each(projectList,function(key,val){
					
					var Html="";
					
					Html="<tr><td class='tac'>"+val["projectName"]+"</td>";
					Html = Html + "<td class='tac'>"+val["projectAlias"]+"</td>";
					Html = Html + "<td class='tac'><input type='button' value='적용' data-dismiss='modal' class='btn btn-primary width-60' onclick='updateProject(\""+val["projectId"]+"\", \""+val["projectName"]+"\")'></td>";
					Html = Html + "</tr>";
					
					$("#popListTable").append(Html);	
					
				});
			}else{
				$("#popListTable > tr").remove();
					
				var Html="";
				
				Html="<tr><td class='tac' colspan='3'>검색된 프로젝트가 없습니다.</td>";
				Html = Html + "</tr>";
				
				
				$("#popListTable").append(Html);		
					
				
			}
			
			$('#popListTable tr:odd').addClass('even');
			$('#popListTable tr:even').addClass('odd'); 
			
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
}

function updateProject(projectId, projectName){
	$("#projectName").val(projectName);
	$("#projectId").val(projectId);
	$("#vmBtn").show();
}

function setVM(vmUuid, hostnameAlias){
	$("#vmUuid").val(vmUuid);
	$("#vmName").val(hostnameAlias);	
}

/**
 *  숫자만 입력 가능 
 */
function number_only(id){
	//alert(id);
	$(id).val( $(id).val().replace(/[^0-9]/gi,''));
	if( !( event.keyCode>=48 && event.keyCode<=57 )){
		event.returnValue=false;
    }
}

// 디스크 가격
	function diskplus(){			
		//alert($("#diskcnt").val());
		if(Number($("#diskcnt").val())>=10000){
			alert("디스크는 10,000GB 이상<br/>신청하실수 없습니다.");
			$("#diskcnt").val($("#imdiskcnt").val());	
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").empty();
			$("#totalpriceview").append($("#totalPrice").val());
		}else{
			var diskcnt;
			var diskprice;
			var imamount;
			//alert($("#diskprice").val());
			diskcnt = Number(rtnnumber($("#diskcnt").val())) + 10;
			diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
			//alert(Number(rtnnumber($("#diskprice").val()))/10);
			imamount = Number(rtnnumber($("#imamount").val()))+Number(rtnnumber($("#diskprice").val()))/10;
			//alert(addcomma(diskprice));
			$("#diskcnt").val(diskcnt);
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma(diskprice));	
			$("#imamount").val(addcomma(imamount));
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(imamount));
			$("#totalPrice").val(addcomma(imamount));
			$("#imdiskprice").val(diskprice);
			$("#imdiskcnt").val($("#diskcnt").val());
			
		}
		
	}
		
	function diskminus(){
			//alert($("#diskcnt").val());
			if(Number($("#diskcnt").val())<=10){
				alert("디스크는 최소 10GB 이상<br/>신청하셔야 합니다.");
				$("#diskcnt").val($("#imdiskcnt").val());	
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").empty();
				$("#totalpriceview").append($("#totalPrice").val());
			}else{
				var diskcnt;
				var diskprice;
				var imamount;
				//alert($("#diskprice").val());
				diskcnt = Number(rtnnumber($("#diskcnt").val())) - 10;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/100;
				//alert(Number(rtnnumber($("#diskprice").val()))/10);
				imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#diskprice").val()))/10;
				//alert(addcomma(diskprice));
				$("#diskcnt").val(diskcnt);		
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice));
				$("#imamount").val(addcomma(imamount));	
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
				$("#imdiskprice").val(diskprice);
				$("#imdiskcnt").val($("#diskcnt").val());
			}
			
	}
	
	function diskfocusout(id){
		//alert(id);
		var diskcnt;
		diskcnt = Number($(id).val());
		//alert(diskcnt);
		if(diskcnt<10){
			alert("디스크는 최소 10GB 이상<br/>신청하셔야 합니다.");
			$(id).val($("#imdiskcnt").val());
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").empty();
			$("#totalpriceview").append($("#totalPrice").val());
		}else if(diskcnt>10000){
			alert("디스크는 10,000GB 이상<br/>신청하실수 없습니다.");
			$(id).val($("#imdiskcnt").val());
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").empty();
			$("#totalpriceview").append($("#totalPrice").val());
		}else{
			var imdiskcnt = diskcnt % 10;
			if(imdiskcnt==0){
				var diskprice;
				var imamount;
				diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100; // 디스크가격
				//alert(diskprice);
				//alert($("#imdiskprice").val());
				imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
				imamount =  imamount + diskprice ; //총가격에 디스크 가격 추가
				
				//alert(imamount);
				
				$("#imdiskcnt").val($(id).val());
				$("#imdiskprice").val(diskprice);
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice));
				$("#imamount").val(addcomma(imamount));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(imamount));
				$("#totalPrice").val(addcomma(imamount));
			}else{
				alert("디스크는 10GB 단위로<br/>신청하실수 있습니다.");
				$(id).val($("#imdiskcnt").val());	
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
				$("#totalpriceview").empty();
				$("#totalpriceview").append($("#totalPrice").val());
			}
			
		}
		
		
	}
function diskchange(id){
	//alert($(id).val());
	var diskval = $(id).val();
	//alert(diskval.length);
	if(diskval.length>2){
		var diskprice;
		var imamount;
		diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100;
		imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
		imamount =  imamount + diskprice ;
		$("#diskpriceview").empty();
		$("#diskpriceview").append(addcomma(diskprice));
		$("#totalpriceview").empty();
		$("#totalpriceview").append(addcomma(imamount));
	}else{
		var imdiskcnt = Number(diskval) % 10;
		if(imdiskcnt==0){
			var diskprice;
			var imamount;
			diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/100;
			imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
			imamount =  imamount + diskprice ;
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma(diskprice));
			$("#totalpriceview").empty();
			$("#totalpriceview").append(addcomma(imamount));
		}
	}
	
}



function diskOrderView(){
	
	//alert($("input[name='hourlyFlag']:checked").val());
	var productSeq = "${getCatalogueSelectView.productSeq}";
	var hourlyFlag = $("input[name='hourlyFlag']:checked").val();
	var diskcnt = $("#diskcnt").val();
	
	$.ajax({
		url : "getcatalogueDiskOrderView",
		dataType : "JSON",
//			type : "POST",
		data : {
			"productSeq" : productSeq
			,"hourlyFlag" : hourlyFlag
			,"diskcnt" : diskcnt
		},
		success : function(data) {
			//alert(data.productSeq);
			//alert(diskcnt);
			
			if(hourlyFlag=="N"){
				//월 금액
				//var totalPrice = data.diskMonthlyPrice * data.diskGb / 10;
				var totalPrice = data.diskMonthlyPrice * diskcnt / 10;
				var diskprice = data.diskMonthlyPrice * 10;
				var diskprice1 = data.diskMonthlyPrice * diskcnt / 10;
				
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice1));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(totalPrice));
				
				$("#totalPrice").val(totalPrice);
				$("#diskprice").val(diskprice);
				$("#diskprice1").val(diskprice1);
				$("#imdiskprice").val(diskprice1);
				$("#imdiskcnt").val(diskcnt);
				$("#imamount").val(totalPrice);
				$("#amount").val(totalPrice);
				//$("#diskpriceview").empty();
				//$("#diskpriceview").append(addcomma(diskprice));
				//$("#totalpriceview").empty();
				//$("#totalpriceview").append(addcomma(imamount));
				//$("#totalPrice").val();
			}else{
				//시간 금액
				var totalPrice = data.diskHourlyPrice * diskcnt / 10;
				var diskprice = data.diskHourlyPrice * 10;
				var diskprice1 = data.diskHourlyPrice * diskcnt / 10;
				
				$("#diskpriceview").empty();
				$("#diskpriceview").append(addcomma(diskprice1));
				$("#totalpriceview").empty();
				$("#totalpriceview").append(addcomma(totalPrice));
				
				$("#totalPrice").val(totalPrice);
				$("#diskprice").val(diskprice);
				$("#diskprice1").val(diskprice1);
				$("#imdiskprice").val(diskprice1);
				$("#imdiskcnt").val(diskcnt);
				$("#imamount").val(totalPrice);
				$("#amount").val(totalPrice);
				
				
			}
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
}

// 바로신청
function noworder(){	
			
	if($("input[name='onDemandFlag']:checked").val()=="N"){				
		if($("#applyDate").val()==""){
			alert("서비스희망일시를 입력하세요");
			return false;
		}	
		if($("#applyTime > option:selected").val()==""){
			alert("서비스희망일시 시간을 입력하세요");
			return false;
		}
	}
	
	if($("#projectName").val()==""){
		alert("프로젝트를 입력하세요");
		return false;
	}
	if($("#vmName").val()==""){
		alert("가상서버를 입력하세요");
		return false;
	}
	if($("#diskName").val()==""){
		alert("블록디스크 이름를 입력하세요");
		return false;
	}
				
	
	$("#catalogueform").submit();
}

// 일괄신청
function basketorder(){	
	if($("input[name='onDemandFlag']:checked").val()=="N"){				
		if($("#applyDate").val()==""){
			alert("서비스희망일시를 입력하세요");
			return false;
		}	
		if($("#applyTime > option:selected").val()==""){
			alert("서비스희망일시 시간을 입력하세요");
			return false;
		}
	}
	if($("#projectName").val()==""){
		alert("프로젝트를 입력하세요");
		return false;
	}
	if($("#vmName").val()==""){
		alert("가상서버를 입력하세요");
		return false;
	}
	if($("#diskName").val()==""){
		alert("블록디스크 이름를 입력하세요");
		return false;
	}
	
	$("#totalPrice").val(rtnnumber($("#totalPrice").val()));
	$("#catalogueform").attr('action','basketOrder.do');
	$("#catalogueform").submit();
}

// 목록 페이지이동
function moveListPage(){
	location.href = "${contextPath}/mbr/req/catalogue/catalogueList.do";
}
</script>

</body>
</html>