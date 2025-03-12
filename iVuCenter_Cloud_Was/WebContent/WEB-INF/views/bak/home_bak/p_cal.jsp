<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />

<c:import url="${contextPath}/WEB-INF/views/home/include/home_import.jsp" charEncoding="UTF-8"></c:import>

<title>KEPCO Cloud Service Platform</title>
</head>
<body>
	<div id="container">
	
	<!-- top menu start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_top.jsp" charEncoding="UTF-8"></c:import>	
	<!-- top menu end -->
	
	 
	 <div class="pimg"></div>
	 <div class="sbody mb30 mt30">
		  <h4><i class="fa fa-calculator f18 nh_blue"></i> 요금계산기</h4>
	
		  	 <!-- begin page-body -->
				 <div class="row mb50">
					
					
					    
					   
						<div class="col-md-12"> 
						
						
						   <!-----//left------->
						   <div class="col-md-6"> 
						
							<!-----//가상서버 -------->
							<h4 class="mt20 f16">ㆍ가상서버 </h4>
							
								<div class="tableD">
												 <table>
												 <colgroup>
												 <col width="100px">
												 <col width="*">
												 </colgroup>
												<tbody>
												<tr>
												  <td class="left">과금유형</td>
												  <td><select class="form-control w50 pb6">
													<option value="">월단위</option>
													<option value="">시간단위</option>
													</select>
												   </td>
												</tr>
												<tr>
												  <td class="left">자원</td>
												  <td><select class="form-control w80 pb6">
													<option value="">T1.Std</option>
													<option value="">T2.Std</option>
													</select>
												   </td>
												</tr>
												<tr>
												  <td class="left" rowspan="4">사양</td>
												  <td><div class="col-md-12 pr0 pl0">
													   <p class="width-30 dpin"> CPU</p> <input class="form-control width-80 dpin" type="text"  placeholder="1"/>
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-plus"></i> </button> 
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-minus"></i> </button>
														<p class="width-30 dpin"> GB</p> 
													   </div>
												   </td>
												</tr>
												<tr>
												  
												  <td><div class="col-md-12 pr0 pl0">
													   <p class="width-30 dpin"> MEM</p> <input class="form-control width-80 dpin" type="text"  placeholder="1"/>
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-plus"></i> </button> 
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-minus"></i> </button>
														<p class="width-30 dpin"> GB</p> 
													   </div>
												   </td>
												</tr>
												<tr>
												  
												  <td><div class="col-md-12 pr0 pl0">
													   <p class="width-30 dpin"> DISK</p> <input class="form-control width-80 dpin" type="text"  placeholder="1"/>
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-plus"></i> </button> 
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-minus"></i> </button>
														<p class="width-30 dpin"> GB</p> 
													   </div>
												   </td>
												</tr>
												<tr>
												 
												  <td><div class="col-md-12 pr0 pl0">
													   <p class="width-30 dpin"> OS</p>
													   <select class="form-control w80 dpin pb6">
													   <option value="">T1.Std</option>
													   <option value="">T2.Std</option>
													   </select>
													   </div>
												   </td>
												</tr>
												<tr>
												<td class="left">예상금액</td>
												<td class="fcb f16 fb tar pr10"> 823,000 </td>
												</tr>
												</tbody>
												</table>
												<button type="submit" class="btn btn-primary flr mt10"><i class="fa fa-plus fw"></i> 추가</button>
								</div>
								<!-----가상서버 //-------->
								
								<!-----//블럭디스크 -------->
							<div class="clear"></div>
							<h4 class="mt20 f16">ㆍ블록디스크 </h4>
							
								<div class="tableD">
												 <table>
												 <colgroup>
												 <col width="100px">
												 <col width="*">
												 </colgroup>
												<tbody>
												<tr>
												  <td class="left">과금유형</td>
												  <td><select class="form-control w50 pb6">
													<option value="">월단위</option>
													<option value="">시간단위</option>
													</select>
												   </td>
												</tr>
												
												<tr>
											      <td class="left">DISK</td>
												  <td><div class="col-md-12 pr0 pl0">
													   <input class="form-control width-80 dpin" type="text"  placeholder="1"/>
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-plus"></i> </button> 
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-minus"></i> </button>
														<p class="width-30 dpin"> GB</p> 
													   </div>
												   </td>
												</tr>
	
												<tr>
												<td class="left">예상금액</td>
												<td class="fcb f16 fb tar pr10"> 3,000 </td>
												</tr>
												</tbody>
												</table>
												<button type="submit" class="btn btn-primary flr mt10"><i class="fa fa-plus fw"></i> 추가</button>
								</div>
								<!-----블럭디스크 //-------->
								
								
								
							<!-----//NAS디스크 -------->
							<div class="clear"></div>
							<h4 class="mt20 f16">ㆍNAS </h4>
							
								<div class="tableD">
												 <table>
												 <colgroup>
												 <col width="100px">
												 <col width="*">
												 </colgroup>
												<tbody>
												<tr>
												  <td class="left">과금유형</td>
												  <td><select class="form-control w50 pb6">
													<option value="">월단위</option>
													<option value="">시간단위</option>
													</select>
												   </td>
												</tr>
												
												<tr>
											      <td class="left">DISK</td>
												  <td><div class="col-md-12 pr0 pl0">
													    <input class="form-control width-80 dpin" type="text"  placeholder="100"/>
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-plus"></i> </button> 
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-minus"></i> </button>
														<p class="width-30 dpin"> GB</p> 
													   </div>
												   </td>
												</tr>
	
												<tr>
												<td class="left">예상금액</td>
												<td class="fcb f16 fb tar pr10"> 1,560 </td>
												</tr>
												</tbody>
												</table>
												<button type="submit" class="btn btn-primary flr mt10"><i class="fa fa-plus fw"></i> 추가</button>
								</div>
								<!-----NAS디스크 //-------->
								
							<!-----//공인IP -------->
							<div class="clear"></div>
							<h4 class="mt20 f16">ㆍ공인IP </h4>
							
								<div class="tableD">
												 <table>
												 <colgroup>
												 <col width="100px">
												 <col width="*">
												 </colgroup>
												<tbody>
												<tr>
												  <td class="left">과금유형</td>
												  <td><select class="form-control w50 pb6">
													<option value="">월단위</option>
													<option value="">시간단위</option>
													</select>
												   </td>
												</tr>
												
												<tr>
											      <td class="left">갯수</td>
												  <td><div class="col-md-12 pr0 pl0">
													   <input class="form-control width-80 dpin" type="text"  placeholder="1"/>
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-plus"></i> </button> 
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-minus"></i> </button>
														<p class="width-30 dpin"> EA</p> 
													   </div>
												   </td>
												</tr>
	
												<tr>
												<td class="left">예상금액</td>
												<td class="fcb f16 fb tar pr10"> 3,300</td>
												</tr>
												</tbody>
												</table>
												<button type="submit" class="btn btn-primary flr mt10"><i class="fa fa-plus fw"></i> 추가</button>
								</div>
								<!-----공인IP //-------->
								
								<!-----//로드밸런서IP -------->
							<div class="clear"></div>
							<h4 class="mt20 f16">ㆍ로드밸런서 </h4>
							
								<div class="tableD">
												 <table>
												 <colgroup>
												 <col width="100px">
												 <col width="*">
												 </colgroup>
												<tbody>
												<tr>
												  <td class="left">과금유형</td>
												  <td><select class="form-control w50 pb6">
													<option value="">월단위</option>
													<option value="">시간단위</option>
													</select>
												   </td>
												</tr>
												
												<tr>
											      <td class="left">갯수</td>
												  <td><div class="col-md-12 pr0 pl0">
													    <input class="form-control width-80 dpin" type="text"  placeholder="1"/>
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-plus"></i> </button> 
														<button type="submit" class="btn btn-grey mt-4 ml10"> <i class="fa fa-minus"></i> </button>
														<p class="width-30 dpin"> EA</p> 
													   </div>
												   </td>
												</tr>
	
												<tr>
												<td class="left">예상금액</td>
												<td class="fcb f16 fb tar pr10"> 6,510</td>
												</tr>
												</tbody>
												</table>
												<button type="submit" class="btn btn-primary flr mt10"><i class="fa fa-plus fw"></i> 추가</button>
								</div>
								<!-----로드밸런서 //-------->
								
						</div>	
						 <!-----left.//------->
						 
						 <!-----//right------->
						<div class="col-md-6"> 
							<h4 class="mt20 f16">ㆍ자원목록 및 예상금액</h4>
							
								<div class="tableD">
												 <table class="table mb0">
												 <colgroup>
												 <col width="50px">
												 <col width="*">
												 <col width="150px">
												 </colgroup>
												 <thead>
													<tr>
														<th class="tac thc_sb"></th>
														<th class="tac thc_sb">자원목록</th>
														<th class="tac thc_sb">가격</th>
													</tr>
												</thead>
												<tbody>
												
												<tr>
												  <td class="tac vm"><button type="submit" class="btn-s btn-grey"> <i class="fa fa-minus"></i> </button></td>
												  <td><li>T1.Std </li>
													  <li> 1 vCPU |  2 GB | 100 GB </li>
													  <li> RedHatEnterprise  Linux 7.3 </li>
												  </td>
												  <td class="tar pr10 vm"><span class="fcb f16 fb">78,610</span> (원) /월</td>
												</tr>
												<tr>
												  <td  class="tac"><button type="submit" class="btn-s btn-grey"> <i class="fa fa-minus"></i> </button></td>
												  <td>디스크 100 GB</td>
												  <td class="tar pr10"><span class="fcb f16 fb">3,500 </span>(원) /월</td>
												</tr>
												<tr>
												  <td  class="tac"><button type="submit" class="btn-s btn-grey"> <i class="fa fa-minus"></i> </button></td>
												  <td>NAS 100 GB</td>
												   <td class="tar pr10"><span class="fcb f16 fb">3,500 </span> (원) /월</td>
												</tr>
												</tbody>
												</table>
								</div>
								
								<p class="mt20 tar f12">추정요금으로 실제 사용요금과는 다를 수 있습니다. </p>
								<div class="col-md-12 disk p10 mt5">
								<div class="col-md-8 fc66 f20 pr0">총예상요금</div>
								<div class="col-md-4 f24 fc-red tar pr20">876,000 <span class="f12 fc66">원 </span></div>
							    </div>
								
								
						 </div>	
						 <!----- right .//------->		
								
	
				
				</div>
					
					
				</div>
				<!---- end page body---->
				
		  
	 </div>
	 
	  
	     
	  
	 
	 
	<div class="clear"></div>
	<hr class="bline mt30"></hr>
	
	<!-- footer start -->
	<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
	<!-- footer end -->
	
	
	
	</div>
	

	
</body>
	
</html>