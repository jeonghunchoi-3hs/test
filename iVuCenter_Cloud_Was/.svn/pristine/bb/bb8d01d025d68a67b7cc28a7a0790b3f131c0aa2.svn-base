<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>	

<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	
	<sec:authorize var="isAnyAdmin" access="hasAnyRole('ROLE_CLOUD_ADMIN', 'ROLE_CLOUD_OPERATION', 'ROLE_CLOUD_CONFIRM_ACTION', 'ROLE_CLOUD_ACCT')" />
	<sec:authorize var="isAdmin" access="hasAnyRole('ROLE_CLOUD_ADMIN')" />
	
	<input type='hidden' id='contextPath' name='contextPath' value='<%=request.getContextPath()%>'/>
	
	<script type='text/javascript' src="<%=request.getContextPath()%>/resources/assets/plugins/jquery-cookie/jquery.cookie.js"></script>
	<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/js/jquery.sliderPro.min.js"></script> --%>
	<%-- <script type='text/javascript' src="<%=request.getContextPath()%>/resources/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script> --%>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
	<%-- <script type='text/javascript' src="<%=request.getContextPath()%>/resources/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script> --%>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.placeholder.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.MultiFile.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.form.js"></script>
	<script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.plugin.js"></script>
	<%-- <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.realperson.js"></script>     --%> <!-- íìê°ìì ì¬ì© -->

	<script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/respond.js"></script> <!-- íì -->
    <%-- <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/metisMenu.min.js"></script> --%>

	<script type='text/javascript' src="<%=request.getContextPath()%>/resources/highCharts/code/highcharts.js"></script>
	<script type='text/javascript' src="<%=request.getContextPath()%>/resources/highCharts/code/highcharts-more.js"></script>
	<script type='text/javascript' src="<%=request.getContextPath()%>/resources/highCharts/code/modules/solid-gauge.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/js/topslider.js"></script>
    <%-- <script type='text/javascript' src="<%=request.getContextPath()%>/resources/assets/js/page-ui-modal-notification.demo.min.js"></script> --%>
	<%-- <script type='text/javascript' src="<%=request.getContextPath()%>/resources/assets/plugins/bootstrap-calendar/js/bootstrap_calendar.min.js"></script> --%>

    <%-- <script type='text/javascript' src="<%=request.getContextPath()%>/resources/assets/plugins/bootstrap/js/bootstrap.js"></script> --%>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/bootstrap.js"></script> 
    <%-- <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/bootstrapValidator.min.js"></script> --%>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.dataTables.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/dataTables.tableTools.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/dataTables.bootstrap.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.modal.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/plugins/jquery.mtz.monthpicker.js"></script>
	<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/plugins/pace/pace.min.js"></script> --%>    
    
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/set/core.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/js/set/modal.js"></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/resources/assets/js/apps.js"></script>
	
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
						alertBox("동일한 ID로 접속정보가 확인되어 <br>로그아웃되었습니다.<br>계속 이용하시려면 재로그인을 해주십시오.", logout);
					}
					else if(xhr.status == 902){
						alertBox("동일한 ID로 접속정보가 확인되어 <br>로그아웃되었습니다.<br>계속 이용하시려면 재로그인을 해주십시오.", logout);
					}
				}
			});
		})(jQuery);
		
	
		$(document).ready(function() {
			$("#customerInfo").hide();
			$("#project").hide();
			$("#productUsageStatus").hide();
			$("#req").hide();
			$("#productAservice").hide();
			$("#alarms").hide();
			$("#operation").hide();
			$("#chargeManagement").hide();
			$("#priceInquiry").hide();
			$("#bbs").hide();
			
			if('${isAnyAdmin}' == 'true'){
				$("#divHeader1").show();
				$("#divSidebar").show();
				$("#customerInfo").show();
				$("#project").show();
				$("#productUsageStatus").show();
				$("#req").show();
				
				$("#operation").show();
				$("#chargeManagement").show();
				$("#priceInquiry").show();
				 
			}else{
				$("#divSidebar").hide();
			}
			if('${isAdmin}' == 'true'){
				$("#productAservice").show();
				$("#bbs").show();
				$("#alarms").show();
			}
			
			$('input, textarea').placeholder();
			$('input').tooltip();
			
			// select box text ì¤ì 
			$(".search-sel").change(function() {
				$(this).siblings(".selectText").text($(this).children('option:selected').text());
				$(this).siblings(".selectBoxDrop").text($(this).children('option:selected').text());				
			});
			//grid head line color setting
			tblColorSet(); 
		}); 
		
		function logout(){
			location.href = "${wasPath}/mng/login/j_spring_security_logout";
		}
		
		function moveLocation(moveLocate) {
			location.href = moveLocate;
		}
		
		function tblColorSet() {
			$('.gridType01 .tableWrap table thead th').each(function(index, item){
				$(item).addClass('th' + index);
			});
		} 
		
		function reload(){
			location.reload();
		}
		

		
	</script>
      