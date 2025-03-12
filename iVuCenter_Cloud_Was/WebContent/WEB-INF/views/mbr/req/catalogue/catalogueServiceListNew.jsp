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

			<p class="page_title">서비스 신청
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> 자원신청  <span class="arrow_ab"> &#8227; </span> <b>서비스 신청 </b>
			    </span>
			</p>
			 <!-- begin page-body -->
			 <div class="row p20 bgwh br10">
			      <div id="btnContainer" style="text-align:right; ">
				  <button class="btnns active" onclick="listView()"><i class="fa fa-bars"></i> List</button>
				  <button class="btnns ml10" onclick="gridView()"><i class="fa fa-th-large"></i> Grid</button>
				  </div>

					<div class="service-row productvmList" style="border-top:none; ">

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


		/*	$(".catalogTapArea ul li").click(function(){
				var tapPage= "#page-"+ $(this).attr('id');

				$(".catalogTapArea ul li").removeClass("active");
				$(this).toggleClass("active");

				$(".tabPageArea").removeClass("active");
				$(tapPage).addClass("active");
			}); */

			// sidebar 메뉴 활성화
			$("#reqProduct").addClass("active");
			$("#service").addClass("active");

			gridItem();


		});

		function gridItem(){
			//$(".productList tbody").empty();
			$(".productList").empty();
			var category = ['CATACATE_MCA', 'CATACATE_BACKUP','CATACATE_SCM', 'CATACATE_SECURITY', 'CATACATE_SERVICE'];
			var html = "";
			$.ajax({
				url : "${contextPath}/mbr/req/catalogue/serviceList",
				dataType : "JSON",
	 			type : "GET",
				success : function(req) {
					var vmList = req;
					$.each(vmList,function(key,val){
					if(jQuery.inArray(val["catalogCategory"],category)){
						/* 	var Html="";
							Html="<tr>";
							Html+="<td class='tac vm'><img src='"+val["imagePath"]+"'  class='height-80'>";
							Html+="<td class='serverInfo'><p class='infoTitle'>"+val["displayName"]+"</p>";
							if(val["descriptionList"] != null || val["descriptionList"] != ""){
								Html+="<p class='infoContents'>"+val["descriptionList"].replace('\n','<br/>')+"</p>";
							} else {
								Html+="<p class='infoContents'>'서비스 로드분산입니다.'</p>";
							}
							Html+="</td>";
							if(val["serviceType"] == "loadbalancer"){
								Html+="<td class='BasketArea'><a href='${wasPath}/mbr/req/catalogue/catalogueLoadBalancerOrder.do?productSeq="+val["productSeq"]+"&hourlyFlag=N&serviceType="+val["serviceType"]+"' class='insertBasket'></a></td>";
							} else if (val["serviceType"] == "snapshot") {
								Html+="<td class='BasketArea'><a href='${wasPath}/mbr/req/catalogue/catalogueSnapShotOrder.do?productSeq="+val["productSeq"]+"&hourlyFlag=N&serviceType="+val["serviceType"]+"' class='insertBasket'></a></td>";
							} else if (val["serviceType"] == "10") {
								Html+="<td class='BasketArea'><a href='${wasPath}/mbr/req/catalogue/cataloguePaasServiceOrder.do?productSeq="+val["productSeq"]+"&hourlyFlag=N&serviceType="+val["serviceType"]+"' class='insertBasket'></a></td>";
							} else if (val["serviceType"] == "11") {
								Html+="<td class='BasketArea'><a href='${wasPath}/mbr/req/catalogue/cataloguePaasServiceOrder.do?productSeq="+val["productSeq"]+"&hourlyFlag=N&serviceType="+val["serviceType"]+"' class='insertBasket'></a></td>";
							} else {
								Html+="<td class='BasketArea'><a href='${wasPath}/mbr/req/catalogue/catalogueServiceOrder.do?productSeq="+val["productSeq"]+"&hourlyFlag=N&serviceType="+val["serviceType"]+"' class='insertBasket'></a></td>";
							}
							Html+="</tr>";
							$(".productvmList tbody").append(Html); */

							var Html="";
							Html="<div class='column'>";
							Html+="<li><img src='"+val["imagePath"]+"'class='height-80'></li>";
							Html+="<li><h4 class='infoTitle'>"+val["displayName"]+"</h4>";
							if(val["descriptionList"] != null || val["descriptionList"] != ""){
								Html+="<p class='infoContents'>"+val["descriptionList"].replace('\n','<br/>')+"</p>";
							} else {
								Html+="<p class='infoContents'>'서비스 로드분산입니다.'</p>";
							}
							Html+="</li>";
							if(val["serviceType"] == "loadbalancer"){
								Html+="<li><a href='${wasPath}/mbr/req/catalogue/catalogueLoadBalancerOrder.do?productSeq="+val["productSeq"]+"&hourlyFlag=N&serviceType="+val["serviceType"]+"' class='serBasket'></a></li>";
							} else if (val["serviceType"] == "snapshot") {
								Html+="<li><a href='${wasPath}/mbr/req/catalogue/catalogueSnapShotOrder.do?productSeq="+val["productSeq"]+"&hourlyFlag=N&serviceType="+val["serviceType"]+"' class='serBasket'></a></li>";
							} else if (val["serviceType"] == "10") {
								Html+="<li><a href='${wasPath}/mbr/req/catalogue/cataloguePaasServiceOrder.do?productSeq="+val["productSeq"]+"&hourlyFlag=N&serviceType="+val["serviceType"]+"' class='serBasket'></a></li>";
							} else if (val["serviceType"] == "11") {
								Html+="<li><a href='${wasPath}/mbr/req/catalogue/cataloguePaasServiceOrder.do?productSeq="+val["productSeq"]+"&hourlyFlag=N&serviceType="+val["serviceType"]+"' class='serBasket'></a></li>";
							} else {
								Html+="<li><a href='${wasPath}/mbr/req/catalogue/catalogueServiceOrder.do?productSeq="+val["productSeq"]+"&hourlyFlag=N&serviceType="+val["serviceType"]+"' class='serBasket'></a></li>";
							}
							Html+="</div>";
							$(".productvmList").append(Html);

						}
					})
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "error:" + error);
				}
			});
		}



		var elements = document.getElementsByClassName("column");
		var i;
		function listView() {
		  for (i = 0; i < elements.length; i++) {
		    elements[i].style.width = "100%";
		    elements[i].style.display = "flex";
		    elements[i].style.alignItems = "center";
		    elements[i].querySelector("li:nth-child(1)").style.width = "17%";
		    elements[i].querySelector("li:nth-child(2)").style.width = "65%";
		    elements[i].querySelector("li:nth-child(2)").style.height = "auto";
		    elements[i].querySelector("li:nth-child(2) h4.infoTitle").style.width = "100%"
	    	elements[i].querySelector("li:nth-child(2) h4.infoTitle").style.textAlign = "left"
		    elements[i].querySelector("li:nth-child(3)").style.width = "17%";
		  }
		}
		function gridView() {
		  for (i = 0; i < elements.length; i++) {
			  let marginRight = "1%";
			  if ( (i+1) % 4 === 0 ) {
				marginRight ="0";
				  }
		    elements[i].style.display = "block";
		    elements[i].style.width = "24.25%";
		    elements[i].style.marginRight = marginRight;
		    elements[i].querySelector("li:nth-child(1)").style.width = "100%";
		    elements[i].querySelector("li:nth-child(2)").style.width = "100%";
		    elements[i].querySelector("li:nth-child(2)").style.height = "104px";
		    elements[i].querySelector("li:nth-child(2) h4.infoTitle").style.width = "100%"
	    	elements[i].querySelector("li:nth-child(2) h4.infoTitle").style.textAlign = "center"
		    elements[i].querySelector("li:nth-child(3)").style.width = "100%";
		  }
		}
		var container = document.getElementById("btnContainer");
		var btns = container.getElementsByClassName("btnns");
		for (var i = 0; i < btns.length; i++) {
		  btns[i].addEventListener("click", function(){
			  toggleActiveViewButton(this);
		  });
		}

		function toggleActiveViewButton( button ){
			let toggleClassName = 'active';
			for( let i = 0; i < btns.length; i++ ){
				btns[i].classList.remove(toggleClassName);
			}
			button.classList.add(toggleClassName);
		}

		listView();






	</script>

</body>
</html>