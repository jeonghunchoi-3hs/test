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
	<c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
	<title>KEPCO Cloud Service Platform</title>
</head>
<body>
	<iframe id='iframeBasket' name='iframeBasket' style='display:none; border:0px;'></iframe>

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
			<h1 class="page-header"><span class="root"> <span class="home"><img src="${apachePath}/resources/assets/img/ico_home.png"  alt="홈"/></span><span class="text"><a href="${wasPath}/mbr/main">콘솔</a></span><span class="text arrow"><a href="${wasPath}/mbr/req/catalogue/catalogueList.do">자원신청</a></span><span class="text arrow"><a href="${wasPath}/mbr/req/catalogue/catalogueSubList.do">부가자원</a></span><span class="text arrow mint"><a href="${wasPath}/mbr/req/catalogue/catalogueNasOrder.do?productSeq=${getCatalogueSelectView.productSeq}&hourlyFlag=N"><strong>신청</strong></a></span></span></h1>
			<!-- end header -->

			 <!-- begin page-body -->
			 <div class="row mb50"> 
			 	<p class="page_title">부가자원 신청</p> 
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
				<input type="hidden" name="imdiskcnt" id="imdiskcnt" value="100" />
				<div class="productTotalArea">
					<div class="productTitleArea">
						<img src="/resources/assets/img/catalogIcon03.png" class="pt10"/>
						<span class="productTitle">${getCatalogueSelectView.displayName}</span> 
						
						<p class="productsubTitle">
						<c:if test='${getCatalogueSelectView.descriptionTop eq null or getCatalogueSelectView.descriptionTop eq ""}'>	
							다수의 서버가 네트워크로 연결해 사용할 수 있는 스토리지입니다.
						</c:if>
						<c:if test='${getCatalogueSelectView.descriptionTop ne null or getCatalogueSelectView.descriptionTop ne ""}'>	
							${getCatalogueSelectView.descriptionTop}
						</c:if>
						</p>
						
					</div>
					<div class="productInfoArea">
						<div class="productAreaNoLine">
							<img src="/resources/assets/img/icon_disk.png"/>
							<span class="productInfo"> <fmt:formatNumber value="${getCatalogueSelectView.nasGb}" pattern="#,###"/> GB</span>
						</div>
											
						<div class="productSubInfo"> 
						<!-- <p class="f16 fc66">데이터공유<span class="fc99"> - NAS 볼륨을 마운트한 다수의 서버와 데이터를 공유하고 관리 할 수 있음</span></p>
						<p class="f16 fc66">보안성<span class="fc99"> - NFS, CIFS 프로토콜 설정에 따라 보안을 강화</span></p>
						<p class="f16 fc66">신청단위<span class="fc99"> - 5,000GB </span></p> -->
						<c:if test='${getCatalogueSelectView.description eq null or getCatalogueSelectView.description eq ""}'>	
							NAS 설명입니다.
						</c:if>
						<c:if test='${getCatalogueSelectView.description ne null or getCatalogueSelectView.description ne ""}'>	
							${getCatalogueSelectView.description}
						</c:if>
						</div> 
					</div>
				</div> 
				<!----첫번째 자원내용 끝------->
				<div class="clear"></div>
				<h4 class="orderTitle">신청정보</h4>		
				<div class="orderArea">
					<div class="tableF"> 
					<form name="catalogueform"  id="catalogueform" action="${wasPath}/mbr/req/catalogue/catalogueNasOrderNow.do" method="post" >
						<input type="hidden" name="imagePath" id="imagePath" value="${getCatalogueSelectView.imagePath}" />
						<input type="hidden" name="imageName" id="imageName" value="${getCatalogueSelectView.imageName}" />
						<input type="hidden" name="type" id="type" value="noworder" />
						<input type="hidden" name="productSeq" id="productSeq" value="${getCatalogueSelectView.productSeq}" />
						<input type="hidden" name="totalPrice" id="totalPrice" value="${totalPrice}" />
						<input type="hidden" name="productCategory" id="productCategory" value="${getCatalogueSelectView.productCategory}" />
						<!-- <input type="hidden" name="hourlyFlag" id="hourlyFlag" value="${getCatalogueSelectView.hourlyFlag}" /> -->
						<input type="hidden" name="networkChk" id="networkChk" value="" />
						<input type="hidden" name="catalogSeq" id="catalogSeq" value="${getCatalogueSelectView.catalogSeq}" />
						<table>
						<colgroup>
						<col width="190px">
						<col width="*">
						</colgroup>
						<tbody>
						<tr>
						<td class="left">이용요금</td>
						<td><label><input type="radio" id="hourlyFlag1" name="hourlyFlag" value="N" checked class="va-tb"/> <span class="mr50">월 </span></label> <label><input type="radio" id="hourlyFlag2" name="hourlyFlag" value="Y" class="va-tb"/> 시간</label></td>
						</tr>
						<tr>
						<td class="left-t">서비스희망일시</td>
						<td>
							<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="Y" checked /> 승인 완료 후 생성</label>	&nbsp;&nbsp;
							<label><input type="radio"  class="va-tb" id="onDemandFlag1" name="onDemandFlag" value="N" /> <span class="mr14">희망일시 생성 </span></label> <br/>
							<p class="fcsb f16 mt10"><img src="/resources/assets/img/icon_tpoint.png"/>승인 완료 후 생성 선택시 클라우드 관리자에 최종 승인 완료 후 NAS가 생성이 됩니다. </p>						
						</td>
						</tr>
						<tr id="sdate" name="sdate" style="display:none">
						<td class="left"></td>
						<td>
						<div>
							<input type="text" class="form-control dpin w138" id="applyDate" name="applyDate" />
							<div class="searchBoxArea w110 ml26">   
								<div class="">
									<label class="selectBoxDrop" for="applyTime">18</label>
									<select class="search-sel" name="applyTime" id="applyTime">
										<c:forEach var="time" begin="1" end="24">
											<c:if test="${time eq 18}">
												<option value="${time}" selected="selected">${time}</option>
											</c:if>
											<c:if test="${time ne 18}">
												<option value="${time}" >${time}</option>
											</c:if>
										</c:forEach>
									</select>
								</div> 
							</div>
							<span class="fc33 f16 lh34 ml5">시</span> 
							<!-- <img src="/resources/assets/img/icon_minus.png"  onclick="applyTimeMinus();" class="minus ml22"/> 
							<input type="text" class="snemo ml-4 " placeholder="18:00"  value="18" id="applyTime" name="applyTime"  readonly/>
							<img src="/resources/assets/img/icon_plus.png"  onclick="applyTimePlus();" class="plus"/>  -->
						</div>		
						</td>
						</tr>
						
						<tr>
						<td class="left">프로젝트명</td>
						<td>
							<input class="form-control w706" type="text" name="projectAlias" id="projectAlias" readonly="readonly"/> 
							<input class="form-control" type="hidden" name="projectName" id="projectName" /> 
							<input type="hidden" name="projectId" id="projectId" value="" />
							<img src="/resources/assets/img/icon_search.png" onclick="openModal();" class="input_search"/> 
						</td>
						</tr>	
																	
						<tr>
						<td class="left">NAS 이름</td>
						<td><input class="form-control" type="text" name="diskName" id="diskName"  /></td>
						</tr>
						<tr>
						<td class="left">NAS 용량</td>
						<td>
						<div class="col-md-8 pr0 pl0">
							<input class="form-control w138" type="text"  placeholder="1" value="${getCatalogueSelectView.nasGb}"  maxlength="5" name="diskcnt" id="diskcnt" onkeypress="number_only(this);" onfocusout="diskfocusout(this);" onkeyup="diskchange(this);" style="ime-mode:disabled;" /> <p class="inputUnit" style="padding:7px 0 0 0;"> GB </p>
							<input type="hidden" name="diskprice" id="diskprice" value='<fmt:formatNumber value="${diskPrice}" pattern="####"/>'>
							<input type="hidden" name="diskprice1" id="diskprice1" value='<fmt:formatNumber value="${diskPrice1}" pattern="####"/>'>
							
<!-- 							<img src="/resources/assets/img/icon_minus.png"  onclick="diskplus();" class="minus"/><span class="snemo">100</span>  <img src="/resources/assets/img/icon_plus.png"  onclick="diskminus();"  class="plus"/> 							 -->
							<img src="/resources/assets/img/icon_minus.png"  onclick="diskminus();" class="minus"/><span class="snemo">100</span>  <img src="/resources/assets/img/icon_plus.png"  onclick="diskplus();"  class="plus"/> 							
							 
						</div>
						<div class="">
						<span class="flr f18 fc66">
								<span  id="diskpriceview" name="diskpriceview" class="listwon nanumR">
									<fmt:formatNumber value="${diskPrice1}" pattern="#,###"/>
								</span>&nbsp;원
							</span>	
						</div>   
						</td>
						</tr>
						<tr>
						<td class="left">가상서버 </td>
						<td> 
							<input class="form-control w100 dpin" type="text"  name="vmName" id="vmName" placeholder="연결할 가상서버명을 입력하세요(참조용)"/> 							
						</td>
						</tr>
					
						</tbody>
						</table>
						</form>
				</div>
				</div>
				
			
			
				
				<div class="appTotal3">	
					<span class="llabel nanumR">총합계<span class="txttotal">(VAT 별도)</span></span>
					<span class="totalwonUnit"><span id="totalpriceview" name="totalpriceview"  class="totalwon nanumR"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/></span>&nbsp;원</span>
					<input type="hidden" name="imamount" id="imamount" value='<fmt:formatNumber value="${totalPrice}" pattern="#,###"/>' />
					<input type="hidden" name="amount" id="amount" value='<fmt:formatNumber value="${totalPrice}" pattern="####"/>' />
				</div>  
				 
				<div class="btn_area">	
					<a type="button" class="bt_w168 bt_buy" onclick="noworder();">구매</a> 
					<a type="button" class="bt_w168 bt_basket ml14" onclick="basketorder();">일괄신청</a>
					<a type="button" class="bt_w168 bt_cancle ml14" onclick="moveListPage();">취소</a> 
				</div>

				</div>
			</div>
			<!---- end page body---->
			
			<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog width-720">
	                   <div class="modal-content width-720">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">프로젝트명</h4>
	                       </div>
	                       <div class="modal-body">
	                       		<div class="col-md-12 bgee modalpop mb20">	
									<div class="" style="text-align: center; display:inline-block;"> 
										<div class="col-md-8"> 
											<input type="text" class="search-text" placeholder="검색어를 입력하세요" id="searchKeyword" data-original-title="" title="">
										</div>
									  	<button type="button" class="btn_search2" onclick="projectPopList();"><span></span></button>
									</div>
								</div>
								<div >
									<table class="table table-bordered table-hover table-striped table-td-valign-middle mb0">
										<colgroup>
									 		<col width="80%">
									 		<col width="20%">
									 	</colgroup>
									 	<thead>
									 		<tr class="skyblue">
												<th class="tac">프로젝트명</th>
												<th class="tac">적용</th>
											</tr>
									 	</thead>
									</table>
									<div class="popListTable">
										<table class="table table-bordered table-hover table-striped table-td-valign-middle mb0">
											<colgroup>
										 		<col width="80%">
										 		<col width="20%">
										 	</colgroup>
											<tbody id="popListTable">
												
											</tbody>
										
										</table>
									</div>
								</div>	
								
	                      	</div>
	                       	<div class="clear"></div>
	                       	<div class="modal-footer tac">
	                   			<a type="button" class="lbtn" data-dismiss="modal" onclick="okProjectInsert();">확인</a>	 
	                   			<a type="button" class="rbtn" data-dismiss="modal">취소</a>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
				<!-- #modal-dialog -->
						
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
                                       <a type="button" class="btn btn-grey" data-dismiss="modal">닫기</a>
                                       
                                     </div>
                                 </div>
                             </div>
                         </div>
			<!-- #modal-dialog  가상서버 검색//-->
			
			<!-- #modal-dialog 구매 확인-->
             <div class="modal fade pdManage" id="modal-dialog3">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                           <h4 class="modal-title">신청확인</h4>
                           </div>
                           <div class="modal-body">
								<div class="modalManagePop">
									<strong class="title" id="pop_projectAlias"></strong>
									<div class="detailBox">
										<div class="boxType01">
											<ul>
												<li><span class="title">NAS 이름</span><span class="cnt nanumR" id="pop_diskName"></span></li>
											</ul>
										</div>
										<div class="boxType02">
											<ul>
												<li><span class="title">희망일시</span><span class="cnt" id="pop_onDemandFlag"></span></li>
												<li><span class="title">과금단위</span><span class="cnt" id="pop_hourlyFlag"></span></li>
												<li><span class="title">NAS 용량</span><span class="cnt" id="pop_diskcnt"></span></li>
												<li><span class="title">가상서버</span><span class="cnt" id="pop_vmName"></span></li>
											</ul>
										</div>
										<dl class="boxType03">
											<dt>금액<span class="fc-red">(VAT 별도)</span></dt>
											<dd><strong id="pop_totalPrice"></strong><span>&nbsp;원</span></dd>
										</dl>
									</div>
									<p class="commnet">위 내용으로 신청 하시겠습니까?</p>
								</div>
                           </div>
						   <div class="clear"></div>
                           <div class="modal-footer tac">
	                   			<a type="button" class="lbtn" data-dismiss="modal" onclick="request_noworder();">확인</a>	 
	                   			<a type="button" class="rbtn" data-dismiss="modal">취소</a>
	                       </div>
                       </div>
                </div>
            </div>
			<!-- #modal-dialog  구매 확인//-->
			
            <!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->
	
	</div>
	<!-- end page container -->
	

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

function applyTimePlus(){			
	if($("#applyTime").val()=="23"){
		alertBox3("시간을 정확히 입력해 주세요.");
	}else{
		var applyTime;
		applyTime = Number(rtnnumber($("#applyTime").val())) + 1;
		$("#applyTime").val(applyTime);
	}
}

function applyTimeMinus(){
	if($("#applyDate").val() == $.datepicker.formatDate('yy-mm-dd', new Date())){
		if($("#applyTime").val() < ((new Date()).getHours())+2){
			alertBox3("현재일시보다 빠를수는 업습니다.");
			return false;
		}
	}
	if($("#applyTime").val()=="0"){
		alertBox3("시간을 정확히 입력해 주세요.");
	}else{
		var applyTime;
		applyTime = Number(rtnnumber($("#applyTime").val())) - 1;
		$("#applyTime").val(applyTime);
	}
}

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
			"url":"${wasPath}/mbr/oss/vm/catalogueVmlist"
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
				return '<div class="col-md-12 tar"><a href="#nav-pills-tab-3-view" data-toggle="tab"><button type="button" data-dismiss="modal" class="btn btn-primary" onclick="setVM(\''+full.vmUuid+'\',\''+full.hostnameAlias+'\')">적용</button></a></div>';
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
		url : "${wasPath}/mbr/req/catalogue/projectPopList",
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
					
// 					Html="<tr><td class='tac'>"+val["projectName"]+"</td>";
					Html="<tr>";
					Html = Html + "<td class='tal'>"+val["projectAlias"]+"</td>";
					Html = Html + "<td class='tac'><input type='button' class='popCheckbtn' onclick='updateProject(this, \""+val["projectId"]+"\", \""+val["projectName"]+"\", \""+val["projectAlias"]+"\")'></td>";
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
			if(request.status == '200'){
				alertBox("접속이 만료되었습니다.", logout);				
			}else{
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}	
		}
	});
}

var hprojectName, hprojectId, hprojectAlias;

function updateProject(e, projectId, projectName,projectAlias){
	$("#popListTable > tr").find("input").removeClass("active");
	$(e).toggleClass("active");
	hprojectName = projectName;
	hprojectId = projectId;
	hprojectAlias = projectAlias;
}

function okProjectInsert(){
	$("#projectName").val(hprojectName);
	$("#projectId").val(hprojectId);
	$("#projectAlias").val(hprojectAlias);
}

function setVM(vmUuid, hostnameAlias){
	$("#vmUuid").val(vmUuid);
	$("#vmName").val(hostnameAlias);	
}

// 디스크 가격
function diskplus(){			
	//alert($("#diskcnt").val());
	if(Number($("#diskcnt").val())>=10000){
		alertBox3("NAS는 10,000GB 이상<br/>신청하실수 없습니다.");
		$("#diskcnt").val($("#imdiskcnt").val());	
		$("#diskpriceview").empty();
		$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
		$("#totalpriceview").html(addcomma($("#totalPrice").val()));
	}else{
		var diskcnt;
		var diskprice;
		var imamount;
		//alert($("#diskprice").val());
		diskcnt = Number(rtnnumber($("#diskcnt").val())) + 100;
		diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/10000;
		//alert(Number(rtnnumber($("#diskprice").val()))/10);
		//imamount = Number(rtnnumber($("#imamount").val()))+Number(rtnnumber($("#diskprice").val()))/10;
		imamount = diskprice;
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
		if(Number($("#diskcnt").val())<=100){
			alertBox3("NAS는 최소 100GB 이상<br/>신청하셔야 합니다.");
			$("#diskcnt").val($("#imdiskcnt").val());	
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").html(addcomma($("#totalPrice").val()));
		}else{
			var diskcnt;
			var diskprice;
			var imamount;
			//alert($("#diskprice").val());
			diskcnt = Number(rtnnumber($("#diskcnt").val())) - 100;
			diskprice = Number(rtnnumber($("#diskprice").val()))*Number(diskcnt)/10000;
			//alert(Number(rtnnumber($("#diskprice").val()))/10);
			//imamount = Number(rtnnumber($("#imamount").val()))-Number(rtnnumber($("#diskprice").val()))/10;
			imamount = diskprice;
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
	if(diskcnt<100){
		alertBox3("NAS는 최소 100GB 이상<br/>신청하셔야 합니다.");
		$(id).val($("#imdiskcnt").val());
		$("#diskpriceview").empty();
		$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
		$("#totalpriceview").empty();
		$("#totalpriceview").html(addcomma($("#totalPrice").val()));
	}else if(diskcnt>10000){
		alertBox3("NAS는 10,000GB 이상<br/>신청하실수 없습니다.");
		$(id).val($("#imdiskcnt").val());
		$("#diskpriceview").empty();
		$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
		$("#totalpriceview").empty();
		$("#totalpriceview").html(addcomma($("#totalPrice").val()));
	}else{
		var imdiskcnt = diskcnt % 100;
		if(imdiskcnt==0){
			var diskprice;
			var imamount;
			diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/10000; // 디스크가격
			//alert(diskprice);
			//alert($("#imdiskprice").val());
			//imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
			//imamount =  imamount + diskprice ; //총가격에 디스크 가격 추가
			imamount = diskprice;
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
			alertBox3("NAS는 100GB 단위로<br/>신청하실수 있습니다.");
			$(id).val($("#imdiskcnt").val());	
			$("#diskpriceview").empty();
			$("#diskpriceview").append(addcomma($("#imdiskprice").val()));
			$("#totalpriceview").html(addcomma($("#totalPrice").val()));
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
		diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/10000;
		//imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
		//imamount =  imamount + diskprice ;
		imamount =  diskprice ;
		$("#diskpriceview").empty();
		$("#diskpriceview").append(addcomma(diskprice));
		$("#totalpriceview").empty();
		$("#totalpriceview").append(addcomma(imamount));
	}else{
		var imdiskcnt = Number(diskval) % 100;
		if(imdiskcnt==0){
			var diskprice;
			var imamount;
			diskprice = Number(rtnnumber($("#diskprice").val()))*Number($(id).val())/10000;
			//imamount = Number(rtnnumber($("#imamount").val())) - Number(rtnnumber($("#imdiskprice").val())); // 총 가격에서 기존 디스크 가격 빼기
			//imamount =  imamount + diskprice ;
			imamount =  diskprice ;
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
		url : "${wasPath}/mbr/req/catalogue/getcatalogueDiskOrderView",
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
				var totalPrice = data.nasMonthlyPrice * diskcnt / data.nasQuantity;
				var diskprice = data.nasMonthlyPrice * data.nasQuantity;
				var diskprice1 = data.nasMonthlyPrice * diskcnt / data.nasQuantity;
				
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
				var totalPrice = data.nasHourlyPrice * diskcnt / data.nasQuantity;
				var diskprice = data.nasHourlyPrice * data.nasQuantity;
				var diskprice1 = data.nasHourlyPrice * diskcnt / data.nasQuantity;
				
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
			if(request.status == '200'){
				alertBox("접속이 만료되었습니다.", logout);				
			}else{
				alertBox3("code:" + request.status + "\n" + "error:" + error);
			}	
		}
	});
}

// 구매전 확인 팝업
function setOrder() {
	$("#pop_projectAlias").text($("#projectAlias").val());
	
	if ($("input[name='onDemandFlag']:checked").val() == 'N') {
		$("#pop_onDemandFlag").text($("#applyDate").val()+' '+$("#applyTime").val()+':00');
	} else if ($("input[name='onDemandFlag']:checked").val() == 'Y') {
		$("#pop_onDemandFlag").text('승인 완료 후 생성');
	} 
	
	$("#pop_diskName").text($("#diskName").val());
	$("#pop_diskcnt").text(addcomma($("#diskcnt").val()));
	$("#pop_vmName").text($("#vmName").val());
	if ($("input[name='hourlyFlag']:checked").val() == 'N') {
		$("#pop_hourlyFlag").text('월');
	} else if ($("input[name='hourlyFlag']:checked").val() == 'Y') {
		$("#pop_hourlyFlag").text('시간');
	} 
	$("#pop_totalPrice").text(addcomma(rtnnumber($("#totalPrice").val())));
	
}

// 바로신청
function noworder(){	
			
	if($("input[name='onDemandFlag']:checked").val()=="N"){				
		if($("#applyDate").val()==""){
			alertBox3("서비스희망일시를 입력하세요");
			return false;
		}	
		if($("#applyTime > option:selected").val()==""){
			alertBox3("서비스희망일시 시간을 입력하세요");
			return false;
		}
	}
	
	if($("#projectName").val()==""){
		alertBox3("프로젝트를 입력하세요");
		return false;
	}
	/*
	if($("#vmName").val()==""){
		alertBox3("가상서버를 입력하세요");
		return false;
	}
	*/
	if($("#diskName").val()==""){
		alertBox3("NAS 이름를 입력하세요");
		return false;
	}
	
	//$("#catalogueform").submit();
	setOrder();
	$("#modal-dialog3").modal();
}


function request_noworder(){	
	
	$("#catalogueform").submit();
}

// 일괄신청
function basketorder(){	
	if($("input[name='onDemandFlag']:checked").val()=="N"){				
		if($("#applyDate").val()==""){
			alertBox3("서비스희망일시를 입력하세요");
			return false;
		}	
		if($("#applyTime > option:selected").val()==""){
			alertBox3("서비스희망일시 시간을 입력하세요");
			return false;
		}
	}
	if($("#projectName").val()==""){
		alertBox3("프로젝트를 입력하세요");
		return false;
	}
	/*
	if($("#vmName").val()==""){
		alertBox3("가상서버를 입력하세요");
		return false;
	}
	*/
	if($("#diskName").val()==""){
		alertBox3("NAS 이름를 입력하세요");
		return false;
	}
	
	$("#totalPrice").val(rtnnumber($("#totalPrice").val()));
	$("#catalogueform").attr('action','basketOrder.do');
	//$("#catalogueform").submit();

	var params = $('#catalogueform').serialize();
	
	$.ajax({
		url : "${wasPath}/mbr/req/catalogue/basketOrder2.do",
		dataType : "JSON",
		type : "POST",
		data : params,
		success : function(data) {	
			confirmBoxBasket("일괄신청로 이동하시겠습니까?", actCatalogueformSubmit);
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

function actCatalogueformSubmit(){
	//$("#catalogueform").attr('action','basketOrder.do');
	//$("#catalogueform").submit();
	location.href = "${wasPath}/mbr/req/catalogue/basketOrder.do";
}

// 목록 페이지이동
function moveListPage(){
	location.href = "${wasPath}/mbr/req/catalogue/catalogueSubList.do";
}

$(document).ready(function(){
    App.init();
   	diskOrderView();
	
	$("a>button").on('click',function(){
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
	
	$("#applyDate").val($.datepicker.formatDate('yy-mm-dd', new Date()));

	$.datepicker.gotoToday=function(id){
		$(id).datepicker('setDate',newDate()).datepicker('hide').blur();
	};
	
	if($("input[name='onDemandFlag']:checked").val()=="N"){					
    	$("#sdate").show();				
	}else{
		$("#sdate").hide();
	}
	
	$("input[name='hourlyFlag']").on('click',function(){	
		diskOrderView();	
		//alert($("input[name='hourlyFlag']:checked").val());
	});
	
	$("input[name='onDemandFlag']").on('click',function(){	
		//alert($("input[name='onDemandFlag']:checked").val());
		if($("input[name='onDemandFlag']:checked").val()=="N"){				
			$("#sdate").show();					
		}else{
			$("#sdate").hide();
		}
		
	});
	
	//메뉴활성화
	$("#reqProduct").addClass("active");
	$("#sub").addClass("active");
		
});
</script>

</body>
</html>