	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
	<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	
	<sec:authorize var="isAnyAdmin" access="hasAnyRole('ROLE_CUSTOM_ADMIN', 'ROLE_CUSTOM_ACCT', 'ROLE_CUSTOM_PM')" />
	<sec:authorize var="isAdmin" 	access="hasRole('ROLE_CUSTOM_ADMIN')" />
	<sec:authorize var="isAccount" 	access="hasRole('ROLE_CUSTOM_ACCT')" />
	<sec:authorize var="isPM" 		access="hasRole('ROLE_CUSTOM')" />
	
	
	<%-- <script type='text/javascript' src="${apachePath}/resources/assets/plugins/jquery-cookie/jquery.cookie.js"></script> --%>
	<%-- <script type="text/javascript" src="${apachePath}/resources/assets/js/jquery.sliderPro.min.js"></script> --%>
	<%-- <script type='text/javascript' src="${apachePath}/resources/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script> --%>
    <script type='text/javascript' src="${apachePath}/resources/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
	<%-- <script type='text/javascript' src="${apachePath}/resources/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script> --%>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.placeholder.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.MultiFile.js"></script>
    <%-- <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.form.js"></script> --%>
	<script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.plugin.js"></script>
	<%-- <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.realperson.js"></script>     --%> <!-- íìê°ìì ì¬ì© -->

	<script type='text/javascript' src="${apachePath}/resources/js/plugins/respond.js"></script> <!-- íì -->
    <%-- <script type='text/javascript' src="${apachePath}/resources/js/plugins/metisMenu.min.js"></script> --%>

	<script type='text/javascript' src="${apachePath}/resources/highCharts/code/highcharts.js"></script>
    <script type="text/javascript" src="${apachePath}/resources/assets/js/topslider.js"></script>
    <%-- <script type='text/javascript' src="${apachePath}/resources/assets/js/page-ui-modal-notification.demo.min.js"></script> --%>
	<%-- <script type='text/javascript' src="${apachePath}/resources/assets/plugins/bootstrap-calendar/js/bootstrap_calendar.min.js"></script> --%>

    <%-- <script type='text/javascript' src="${apachePath}/resources/assets/plugins/bootstrap/js/bootstrap.js"></script> --%>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/bootstrap.js"></script> 
    <%-- <script type='text/javascript' src="${apachePath}/resources/js/plugins/bootstrapValidator.min.js"></script> --%>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.dataTables.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/dataTables.tableTools.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/dataTables.bootstrap.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.modal.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/plugins/jquery.mtz.monthpicker.js"></script>
	<%-- <script type="text/javascript" src="${apachePath}/resources/assets/plugins/pace/pace.min.js"></script> --%>    
    
    <script type='text/javascript' src="${apachePath}/resources/js/set/core.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/js/set/modal.js"></script>
    <script type='text/javascript' src="${apachePath}/resources/assets/js/apps.js"></script>
    
    <!-- 개발환경 신청의 개발자라인 엑셀 업로드용으로 사용 -->
    <script src="${apachePath}/resources/js/xlsx.full.min.js"></script>
	
	<!-- side menu ì ì´ -->
	<script type="text/javascript">
		;(function($){
			$.ajaxSetup({
				beforeSend: function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				cache:false, 
				error: function(xhr, status, err){
					if(xhr.status == 901){
						alertBox("동일한 ID로 접속정보가 확인되어 로그아웃되었습니다.\n계속 이용하시려면 재로그인을 해주십시오.", logout);
					}
					else if(xhr.status == 902){
						alertBox("동일한 ID로 접속정보가 확인되어 로그아웃되었습니다.\n계속 이용하시려면 재로그인을 해주십시오.", logout);
					}
				}
			});
		})(jQuery);
		
	
		$(document).ready(function() {
			$("#dashboard").show();
			$("#project").show();
			$("#reqStatus").show();
			$("#reqStatusApprove").show();
			$("#reqProduct").show();
			$("#changeOrder").show();
			$("#myGoods").show();
			$("#monitor").show();
			$("#bbs").show();
			$("#application").show();
			/* $("#divHeader1").show();
			$("#divHeader2").show();
			$("#divSidebar").show(); */
			
			/*$("#project").hide();
			$("#reqStatus").hide();
			$("#reqProduct").hide();
			$("#changeOrder").hide();
			$("#billMenu").hide();
			$("#bbs").hide();
			
			 if('${isAnyAdmin}' == 'true'){
				$("#divSidebar").show();
				$("#divHeader1").show();
				$("#divHeader2").hide();

				if('${isAdmin}' == 'true'){					
					$("#project").show();
					$("#reqStatus").show();
					$("#reqStatusApprove").show();
					$("#reqProduct").show();
					$("#changeOrder").show();
					$("#billMenu").show();
					$("#bbs").show();
				}
				
				if('${isPM}' == 'true'){
					$("#project").show();
					$("#reqStatus").show();
					$("#reqProduct").show();
					$("#changeOrder").show();
					$("#bbs").show();
				}
				
				if('${isAccount}' == 'true'){
					$("#billMenu").show();
					$("#bbs").show();
				}
				
			}else{
				$("#divHeader1").hide();
				$("#divHeader2").show();
				$("#divSidebar").hide();
			} */
		
			
			// select box text ì¤ì 
			$(".search-sel").change(function() {
				$(this).siblings(".selectText").text($(this).children('option:selected').text());
				$(this).siblings(".selectBoxDrop").text($(this).children('option:selected').text());				
			});
			
			
			//헤더 이미지 출력
// 			var url = location.href;
// 			url = url.substring(url.length-5, url.length+1);
// 			if(url != "/mbr/"){
// 							
// 			}
			
			/* 			
 			setTimeout(function(){
				$('button').append('<span></span>');
			},1000);
			*/
			
			$('input, textarea').placeholder();
			$('input').tooltip();
			 
			//window.history.forward();
			
			//팝업 테이블 odd, even 스타일 세팅
			$('#popListTable tr:odd').addClass('even');
			$('#popListTable tr:even').addClass('odd'); 
			
			$('#popListTable2 tr:odd').addClass('even');
			$('#popListTable2 tr:even').addClass('odd'); 
			   
		}); 
		
		function logout(){
			location.href = "${wasPath}/mbr/j_spring_security_logout";
		}
		
		function moveLocation(moveLocate) {
			location.href = moveLocate;
		}
		
	</script>
      