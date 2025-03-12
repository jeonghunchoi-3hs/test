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
<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer in">
	<!-- begin #header -->
	<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
	<!-- end #header -->
	<!-- begin #sidebar -->
	<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
	<!-- end #sidebar -->


		<!-- begin #content -->
		<div id="content" class="content">
			<p class="page_title">어플리케이션 신청
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span>
				<a href="${wasPath}/mbr/main"> 콘솔</a>
					<span class="arrow_ab"> &#8227; </span> 자원신청
					<span class="arrow_ab"> &#8227; </span>
				<b>어플리케이션 신청 </b>
				</span>
			</p>
			 <!-- begin #content > page-body -->
			 <div class="row p20 bgwh br10">

<!-- 			<div class="col-md-12 br5 p20 mb20 bgf5 tac"> -->
<!-- 				<div class="new-search"> -->
<!-- 					<div class="left"> -->
<!-- 						<div class="choice-kepco"> -->
<!-- 							<div class="select-kepco" id="searchKind"> -->
<!-- 								<button class="kep-label" value="searchAll" for="searchKind">전체 </button> -->
<!-- 								<ul class="optionList"> -->
<!-- 									<li class="optionItem" value="searchAll">전체</li> -->
<!-- 									<li class="optionItem" value="projectAlias">이미지</li> -->
<!-- 									<li class="optionItem" value="projectName">템플릿</li> -->
<!-- 								</ul> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->

<!-- 					<div class="right"> -->
<!-- 						<input type="text" class="input-kepco" placeholder="검색어를 입력하세요" id="keyword" onkeypress="if(event.keyCode==13)gridList();"/> -->
<!-- 						<button type="button" class="kepco-ser-icon"  onclick="gridList()"></button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
				<!-- search end -->

			  	<div class="col-lg-12">
<!--                      <div class="mt20 mb10 pull-right"> -->
<!-- 						<span class="f16 fb">유형 </span> -->
<!-- 	                    <select class="form-control width-150 dpin"> -->
<!-- 			                <option>이미지 </option> -->
<!-- 			                <option>템플릿 </option> -->
<!-- 	                    </select> -->
<!--                      </div> -->
                     <div class="clear"></div>
	                     <div class="loading-content">
	                         <i class="fas fa-spinner fa-spin"></i><span>목록을 가져오고 있습니다.</span>
	                     </div>
	                     <div class="row overflow-wrapper">
	                         <div class="col-md-12 pl0">
	                             <table class="productAppList productvmList table table-hover table-800">
	                                 <colgroup>
	                                     <col width="15%">
	                                     <col width="*">
	                                     <col width="15%">
	                                 </colgroup>
	                                 <tbody>
	                                 </tbody>
	                             </table>
	                         </div>
	                     </div>
                  	<!---Web server --->
				</div>
				<!---- end page body---->
	            </div>
				<!-- begin #footer -->
				<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
				<!-- end #footer -->
			</div>
			<!-- end #content -->
		<!-- end page container -->
</div>

<c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>

<script type="text/javascript">

    function gridItem() {
        $(".productAppList tbody").empty();
        var html = "";
        $.ajax({
            url : "${contextPath}/mbr/application/req/containerList",
            dataType : "JSON",
            type : "GET",
            success : function(req) {
                var appList = req;
                var idx = 0;

                $.each(appList,	function(key, val) {
//                         if (val["catalogCategory"] == "CATACATE_APP") {

                            var Html = "";
                            Html = "<tr>";
                            Html += "<td class='tac app vm'><img src='"+val["imagePath"]+"'  class=''></td>";
                            Html += "<td class='serverInfo'><p class='infoTitle'>"
                                    + val["displayName"]
                                    + "</p>";
                            if (val["descriptionList"] != null) {
                                Html += "<p class='infoContents'>"
                                        + val["descriptionList"].replace('\n', '<br/>')
                                        + "</p>";
                            } else {
                                Html += "<p class='infoContents'>'운영체제 설치를 위한 기본 DISK가 제공되며, <br>추가 DISK를 직접 생성 할 수 있습니다.'</p>";
                            }
							Html += "</td>";
//                             if(val["displayName"] == "Container Terminal 신청"){
//                             	Html += "<td class='productInfo'><h3 class='f14 fc-dblue mb0 fb'>Standard</h3><span class='pcpu nanumR'></td>";
//                             }else{
// 	                                Html += "<td class='productInfo'><h3 class='f14 fc-dblue mb0 fb'>Standard</h3><span class='pcpu nanumR'>"
//                                         + val["podCpu"]
//                                         + "Core</span><span class='addcion'></span>	<span class='pmem nanumR'>"
//                                         + val["podMem"]
//                                         + "GB</span>"
//                                         + "</td>";
//                             }
							if(val["productSeq"] === "20240912140000"){// 개발환경 신청
                                Html += "<td class='BasketArea'><a href='${wasPath}/mbr/application/req/catalogueDevEnv?productSeq=";
                            } else if(val["productSeq"] === "20240923143315" || val["productSeq"] === "20241017095900" || val["productSeq"] === "20241017095901" || val["productSeq"] === "20241017095902"){// 개발배포
                                Html += "<td class='BasketArea'><a href='${wasPath}/mbr/application/req/catalogueDevExport?productSeq=";
                            } else if(val["productSeq"] === "20240926110800"){// 운영배포
                                Html += "<td class='BasketArea'><a href='${wasPath}/mbr/application/req/cataloguePrdExport?productSeq=";
                            } else{
                                Html += "<td class='BasketArea'><a href='${wasPath}/mbr/application/req/write?productSeq=";
                            }
                            Html += val["productSeq"]
                            		+ "&cloudId="
                               		+ val["cloudId"]
                            		+ "&cloudType="
                               		+ val["cloudType"]
                            		+ "&imageType="
                               		+ val["imageType"]
                               		+ "&hourlyFlag=N' class='insertBasket btn btn-detail'></a></td>";
                            Html += "</tr>";

                            $(".pl0 .productAppList tbody").append(Html);
                            idx++;
//                         }
                }); //end forEach
                $(".loading-content").hide();
            },
            error : function(request, status, error) {
                alert("code:" + request.status + "\n" + "error:"
                        + error);
            }
        });
    }

	$(document).ready(function() {

		App.init();
		//메뉴활성화
		$("#reqProduct").addClass("active");
		$("#reqApp").addClass("active");

        gridItem();
	});
</script>

</body>
</html>
