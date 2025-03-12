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
<!-- <body class="boxed-layout">  -->

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
		
			<p class="page_title">즉시 생성
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> <b>즉시생성 </b>
			    </span>
			</p>
			 <div class="row p20 bgwh br10">
			 	

			 	
			 	<div class="col-md-12 pt20 pb20">
			 		<table class="productvmList w100">
						<colgroup>
							<col width="10%">
							<col width="*">
							<col width="20%">
							<col width="10%">
						</colgroup>
						<tbody> 
						</tbody>
					</table>
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

	$(document).ready(function() {
		App.init();
	  	if($("input[name='hourlyFlag']:checked").val()=="N"){					
			$("#hourlyPriceview").hide();
			$("#monthlyPriceview").show();					
		}else{
			$("#monthlyPriceview").hide();
			$("#hourlyPriceview").show();
		}
		  
		$("a>button").on('click',function(){
			location.href = $(this).closest("a").attr("href");
		});
		
		$("input[name='hourlyFlag']").on('click',function(){	
			//alert($("input[name='hourlyFlag']:checked").val());
			if($("input[name='hourlyFlag']:checked").val()=="N"){					
				$("#hourlyPriceview").hide();
				$("#monthlyPriceview").show();					
			}else{
				$("#monthlyPriceview").hide();
				$("#hourlyPriceview").show();
			}
			
		});
		
		$(".panel-heading-btn a i").click(function(){
			$(this).toggleClass("fa-chevron-down fa-chevron-up");
		});
		
		//메뉴활성화
		$("#reqProduct").addClass("active");
		$("#direct").addClass("active");	
		gridItem("${getCloudList[0].cloudId}");	
		
		//첫번째 tab 활성화
		$(".nav-pills>li:first-child").addClass("active");
	});

	function gridItem(cloudId){
		$(".productList tbody").empty();
		var html = "";
		$.ajax({
			url : "${contextPath}/mbr/req/catalogue/vmList",
			dataType : "JSON",
 			type : "GET",
			success : function(req) {
				var vmList = req;
				var idx = 0;
				$.each(vmList,function(key,val){
				if(val["catalogCategory"] == "CATACATE_VM"){
						var Html="";
						Html="<tr>";
						Html+="<td class='tac vm'><img src='"+val["imagePath"]+"'  class='height-80'>";
						Html+="<td class='serverInfo'><p class='infoTitle'>"+val["displayName"]+"</p>";
						if(val["descriptionList"] != null){
							Html+="<p class='infoContents'>"+val["descriptionList"].replace('\n','<br/>')+"</p>";
						} else {
							Html+="<p class='infoContents'>'운영체제 설치를 위한 기본 DISK가 제공되며, <br>추가 DISK를 직접 생성 할 수 있습니다.'</p>";
						}
						Html+="</td>";
						Html+="<td class='productInfo'><h3 class='f14 fc-dblue mb0 mt10 fb'>★ Standard ★</h3><span class='pcpu nanumR'>"+val["vcpus"]+"Core</span><span class='addcion'></span>	<span class='pmem nanumR'>"+val["memGb"]+"GB</span><span class='addcion'></span><span class='pdisk nanumR'>"+val["vmDiskGb"]+"GB</span></td>";
						Html+="<td class='BasketArea'><a href='${wasPath}/mbr/req/catalogue/catalogueOrderDriect.do?productSeq="+val["productSeq"]+"&hourlyFlag=N&cloudId="+cloudId+"' class='insertBasket'></a></td>";
						Html+="</tr>";
						if(idx % 2 == 0){
							$(".productvmList tbody").append(Html);
						} else {
							$(".productvmList tbody").append(Html);
						}
						idx++;
					}
				})
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
</script>
</body>
</html>