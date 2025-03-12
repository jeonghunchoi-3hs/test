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
			<h1 class="page-header fc66 fb"> <i class="fa fa-cubes fcb"> </i> 가상머신1234 <span class="root">콘솔 > 자원신청 > 추천자원 > 목록</span></h1>
			<!-- end header -->

			 <!-- begin page-body -->
			 <div class="row mb50">
				<div class="col-md-12 pl20">
					<input type="radio" id="hourlyFlag1" name="hourlyFlag" value="N" checked /> 월과금 &nbsp; &nbsp;  
					<input type="radio" id="hourlyFlag2" name="hourlyFlag" value="Y" /> 시간과금
				</div>
				
				<!-----자원 여러개 시작-------->
				<div class="col-md-12" id="monthlyPriceview" name="monthlyPriceview">				   
					<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
					 <!---자원한개 시작------>											
						<div class="col-md-3 mt20">
						    <div class="br5 bge4 pl0 pr0 pb10">
								<h3 class="bg81 f14 fb fw p10 tac btlr5 btrr5 mt0">${getCatalogueList.displayName} </h3>
								<p class="tac p20 br5 bgwh ml10 mr10"><img src="${wasPath}/resources/assets/img/server_sample.png"/></p>
						    	<li class="f14 fc66 mt10 pl20">CPU : ${getCatalogueList.vcpus} Core</li>
								<li class="f14 fc66 mt5 pl20">MEM : ${getCatalogueList.memGb} GB</li>
								<li class="f14 fc66 mt5 pl20">DISK : ${getCatalogueList.diskGb} GB</li>
								<hr class="dot2 mr10 ml10"></hr>
								<li class="f14 fb fc66 mt5 pl20" id="monthlyPrice" name="monthlyPrice">가격(월)  
									<span class="fcb2 f16 fb tar pr20 flr">
										<fmt:formatNumber value="${getCatalogueList.monthlyPrice}" pattern="#,###"/>
									</span>
								</li>								
								<li class="tac mt20 mb10">
									<a href="catalogueOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=N">
										<button type="button"  class="btn btn-lime" >신청하기</button>
									</a>
								</li>
							</div>
						</div>
					<!---자원한개 끝------>					
					</c:forEach>
				</div>
				<!----자원 여러개 끝----->
				
				<!-----자원 여러개 시작-------->
				<div class="col-md-12" id="hourlyPriceview" name="hourlyPriceview" style="display:none" >				   
					<c:forEach items="${getCatalogueList}" var="getCatalogueList" varStatus="status" >
					 <!---자원한개 시작------>											
						<div class="col-md-3 mt20">
						    <div class="br5 bge4 pl0 pr0 pb10">
								<h3 class="bg81 f14 fb fw p10 tac btlr5 btrr5 mt0">${getCatalogueList.displayName} </h3>
								<p class="tac p20 br5 bgwh ml10 mr10"><img src="${apachePath}/resources/assets/img/server_sample.png"/></p>
						    	<li class="f14 fc66 mt10 pl20">CPU : ${getCatalogueList.vcpus} Core</li>
								<li class="f14 fc66 mt5 pl20">MEM : ${getCatalogueList.memGb} GB</li>
								<li class="f14 fc66 mt5 pl20">DISK : ${getCatalogueList.diskGb} GB</li>
								<hr class="dot2 mr10 ml10"></hr>
								<li class="f14 fb fc66 mt5 pl20" id="monthlyPrice" name="monthlyPrice">가격(시간)  
									<span class="fcb2 f16 fb tar pr20 flr">
										<fmt:formatNumber value="${getCatalogueList.hourlyPrice}" pattern="#,###"/>
									</span>
								</li>
								<li class="tac mt20 mb10">
									<a href="catalogueOrder.do?productSeq=${getCatalogueList.productSeq}&hourlyFlag=Y">
										<button type="button"  class="btn btn-lime" >신청하기</button>
									</a>
								</li>
							</div>
						</div>
					<!---자원한개 끝------>					
					</c:forEach>
				</div>
				<!----자원 여러개 끝----->


			</div>
			<!---- end page body---->
			
			
          <!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->
		</div>
		<!-- end #content -->
		
	
	</div>
	<!-- end page container -->
	
   
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
		  
		$("a>button").live('click',function(){
			location.href = $(this).closest("a").attr("href");
		});
		
		$("input[name='hourlyFlag']").live('click',function(){	
			//alert($("input[name='hourlyFlag']:checked").val());
			if($("input[name='hourlyFlag']:checked").val()=="N"){					
				$("#hourlyPriceview").hide();
				$("#monthlyPriceview").show();					
			}else{
				$("#monthlyPriceview").hide();
				$("#hourlyPriceview").show();
			}			
		});
		
		//메뉴활성화
		$("#catalogueMain").addClass("active");
		$("#catalogueVm").addClass("active");
		
	});		
		
</script>
	
</body>
</html>