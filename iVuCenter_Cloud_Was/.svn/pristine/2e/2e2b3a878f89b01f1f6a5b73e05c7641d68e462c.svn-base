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
<!-- 	<div id="page-loader" class="page-loader fade in"><span class="spinner">Loading...</span></div> -->
	<!-- end #page-loader -->

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		<!-- begin #header -->
		<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
		<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #sidebar -->
		
		<!-- begin #content (페이지 바디 컨텐츠 시작입니다)--> 
		<div id="content" class="content">
		
			<!-- begin page-header -->
			<h1 class="page-header fc66"> <i class="fa fa-dot-circle-o fcb"> </i> 프로젝트 내용수정<span class="root">콘솔 > 프로젝트 > 승인 프로젝트 목록</span></h1>
			<!-- end page-header -->

			<!-- begin page-body -->
			 <div class="row mb50">
			
			 <!-- begin section-container -->		  
			 <div class="section-container inbox">

			<!-- begin normal input table---------->			
			<div class="tableB">
				 <table>
				 	<colgroup>
				 		<col width="20%">
				 		<col width="80%">
				 	</colgroup>
					<tbody>
						<tr>
						  <td class="left-b th20">프로젝트코드</td>
						  <td>
							<div class="col-sm-6">
			                 ${getOkProjectView.projectName}
			                 </div>
						  </td>
						 </tr>
						<tr>
						  <td class="left-b">프로젝트명</td>
						  <td>
						      <div class="col-sm-10">
			                  ${getOkProjectView.projectAlias}
			                  </div>
						  </td>
						</tr>
					
						<tr>
						  <td class="left-b">회원사아이디</td>
						  <td>
						  ${getOkProjectView.customerId}
						  </td>
						</tr>
						
						<tr>
						  <td class="left-b">설명</td>
						  <td><div class="col-sm-12">
			                  <textarea class="form-control" rows="10" placeholder="설명을 입력하세요" name="projectDescription" id="projectDescription">${getOkProjectView.projectDescription}</textarea>
			                  </div>
						  </td>
						</tr>
						<tr>
						  <td class="left-b">해지사유</td>
						  <td><div class="col-sm-12">
			                  <textarea class="form-control" rows="10" placeholder="설명을 입력하세요" name="projectExpr" id="projectDescription">${getOkProjectView.projectDescription}</textarea>
			                  </div>
						  </td>
						</tr>
					</tbody>
				</table>
			
			</div>
			
			
			<!-- 
			

			
			 -->
			 <!-- begin button----------->
				 <div class="col-sm-12 tac mt20">
					 <a href="javascript:projectExpr();"><button type="button" class="btn btn-danger width-80">삭제 신청</button> </a>                     
					 <a href="okprojectList.do"><button type="button" class="btn btn-grey width-80">목록</button> </a>      
                 </div>
				<!-- end button----------->
     
                            
			<!-- end normal input table---------->
			</div>
			    <!-- end section-container -->	   
				<!-- begin button----------->
				 <div class="row tac mt20">
				 	<!-- 
				 	<input type="button" id="jquerybuttonok" name="jquerybuttonok" value="수정" onclick="projectInsert();" class="btn btn-primary width-80" />  
				 	<input type="button" id="jquerybuttonok" name="jquerybuttonok" value="승인" onclick="projectAppro();" class="btn btn-primary width-80" />
				 	 -->
				 	                         
                 </div>
				<!-- end button----------->
				
				

			</div>
			  
			<!-- end page-body -->
			
			
			<!-- #modal-dialog -->
				<div class="modal fade" id="modal-dialog">
	               <div class="modal-dialog">
	                   <div class="modal-content">
	                       <div class="modal-header">
	                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                           <h4 class="modal-title fw">PM 설정</h4>
	                       </div>
	                       <div class="modal-body">
	                           <p class="m-b-20">
	                              <input type="text"  id="searchKeyword" value="" />
	                              <input type="button" value="검색" onclick="projectPmPopList();"/> 
	                           </p>
								
								<div class="tableB">
									<table>
										<colgroup>
									 		<col width="40%">
									 		<col width="40%">
									 		<col width="20%">
									 	</colgroup>
									 	<thead>
									 		<tr>
												<td class="left th20 tac">사용자 아이디</td>
												<td class="left th20 tac">사용자 이름</td>
												<td class="left th20 tac">PM등록</td>
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
				<!-- #modal-dialog -->
			
			
			
			
            <!-- begin #footer -->
			<c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #footer -->

		</div>
		<!-- end #content -->
		
	
	</div>
	<!-- end page container -->
	
   
	
	<script type="text/javascript">
		$(document).ready(function() {
		    App.init();
		    
		  //메뉴활성화
		 $("#project").addClass("active");
		 $("#approveProjectList").addClass("active");
		    //Demo.init();
		  //  PageDemo.init();
			
			$("a>button").live('click',function(){
			location.href = $(this).closest("a").attr("href");
			});
		});
		
		
		function projectExpr() {							
			if(confirm("삭제신청 하시겠습니까?")){
				
				var userId = "${getOkProjectView.customerId}";
				var projectId = "${getOkProjectView.projectId}";				
				var projectName = "${getOkProjectView.projectName}";
				var projectAlias = "${getOkProjectView.projectAlias}"; 
				var projectDescription = "${getOkProjectView.projectDescription}";
				$.ajax({
					url : "projectExpr",
					dataType : "JSON",
					type : "POST",
					data : {
						"userId" : userId,
						"projectId" : projectId,
						"projectName" : projectName,
						"projectAlias" : projectAlias,
						"projectDescription" : projectDescription
					},					
					success : function(data) {
						//var result = data;						
						//alert(data);
						
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "error:" + error);
					}
				})
			}				
			
		}
		
		
		function valchk(){
			//$("#buttonok").click(function(){
				
				if($("#projectName").val()==""){
					alert(" 프로젝트코드을 입력하세요");
					$("#projectName").focus();
					return false;
				}				
				if($("#projectAlias").val()==""){
					alert("프로젝트명을 입력하세요");
					$("#projectAlias").focus();
					return false;
				}	
				
				//alert($("input:checkbox[name='network']").length);
				//alert($("input:checkbox[name='network']:checked").length);
				if($("input:checkbox[name='network']:checked").length==0){
					alert("네트워크망은 1개이상을 선택하셔야 합니다.");
					$("input:checkbox[name='network']").focus();
					return false;
				}				
				
				
				if($("#projectDescription").val()==""){
					alert("설명을 입력하세요");
					$("#projectDescription").focus();
					return false;
				}
				
				
				
				return true;
	
		}

	
// 	function updatePm(pmId, pmName){
// 		$("#pmName").val(pmName);
// 		$("#pmId").val(pmId);
// 		var projectId = "${getOkProjectView.projectId}";
// 		$.ajax({
// 			url : "projectPmInsert",
// 			dataType : "JSON",
// 			type : "POST",
// 			data : {
// 				"userId" : pmId,
// 				"projectId" : projectId
// 			},
// 			success : function(data) {
// 				alert("적용되었습니다.");
// 			},
// 			error : function(request, status, error) {
// 				alert("code:" + request.status + "\n" + "error:" + error);
// 			}
// 		});
// 	}
	
	
	//<--- Modal popup end
	
	</script>
	
</body>
</html>