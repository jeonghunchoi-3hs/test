/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.56
 * Generated at: 2025-01-15 02:03:17 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.mbr.include;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class header_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(4);
    _jspx_dependants.put("/WEB-INF/lib/spring-security-taglibs-4.2.12.RELEASE.jar", Long.valueOf(1709100854305L));
    _jspx_dependants.put("jar:file:/D:/workspace/k-cloud-20250113-dev/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/iVuCenter_Cloud_Was/WEB-INF/lib/spring-security-taglibs-4.2.12.RELEASE.jar!/META-INF/security.tld", Long.valueOf(1554198614000L));
    _jspx_dependants.put("/WEB-INF/lib/jstl-1.2.jar", Long.valueOf(1709100854747L));
    _jspx_dependants.put("jar:file:/D:/workspace/k-cloud-20250113-dev/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/iVuCenter_Cloud_Was/WEB-INF/lib/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153352682000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fsec_005fauthorize_0026_005faccess;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fsec_005fauthentication_0026_005fvar_005fproperty_005fnobody;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fsec_005fauthorize_0026_005faccess = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fsec_005fauthentication_0026_005fvar_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fsec_005fauthorize_0026_005faccess.release();
    _005fjspx_005ftagPool_005fsec_005fauthentication_0026_005fvar_005fproperty_005fnobody.release();
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("	.centerLockRap{\r\n");
      out.write("		width: 100%;\r\n");
      out.write("		height: 100%;\r\n");
      out.write("		background-color: rgba(0,0,0, 0.5);\r\n");
      out.write("		z-index: 999999999999999;\r\n");
      out.write("		position: fixed;\r\n");
      out.write("		vertical-align:middle;\r\n");
      out.write("		left: 0px;\r\n");
      out.write("		top : 0px;\r\n");
      out.write("		display: none;\r\n");
      out.write("	}\r\n");
      out.write("	.lockImg{\r\n");
      out.write("	    position : absolute;\r\n");
      out.write("       	height : 100px;\r\n");
      out.write("       	width : 350px;\r\n");
      out.write("       	left : 50%;\r\n");
      out.write("       	top : calc( 50% - 30px);\r\n");
      out.write("       	transform:translateY(-50% );\r\n");
      out.write("       	transform:translateX(-50% );\r\n");
      out.write("   		text-align: center;\r\n");
      out.write(" 	}\r\n");
      out.write(" 	.top_fontSize{\r\n");
      out.write(" 		color: #FFFFFF;\r\n");
      out.write(" 		width: 100%;\r\n");
      out.write(" 		margin-top: 10px;\r\n");
      out.write(" 	}\r\n");
      out.write("/*  	.imgClassTop{\r\n");
      out.write(" 		margin : 0 auto;\r\n");
      out.write("       	width : 90px;\r\n");
      out.write("\r\n");
      out.write(" 	}      */\r\n");
      out.write("</style>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("var setLodingFun = {\r\n");
      out.write("	lodingName : \".centerLockRap\"\r\n");
      out.write("\r\n");
      out.write("	,blocksFun : function(){ //block Return\r\n");
      out.write("		$( this.lodingName).show();\r\n");
      out.write("\r\n");
      out.write("	}\r\n");
      out.write("	,nonesFun : function () { //none Return\r\n");
      out.write("		$( this.lodingName).hide();\r\n");
      out.write("\r\n");
      out.write("	}\r\n");
      out.write("};\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<div class=\"centerLockRap\">\r\n");
      out.write("    <div class=\"lockImg\">\r\n");
      out.write("	<!-- <img src=\"/resources/assets/img/lockLodingBar.gif\" class=\"imgClassTop\" /> -->\r\n");
      out.write("		<img src=\"/resources/mng/assets/img/loading.gif\" class=\"imgClassTop\" />\r\n");
      out.write("\r\n");
      out.write("    <div class=\"top_fontSize\">처리 중 입니다. 잠시만 기다려 주십시오...</div>\r\n");
      out.write("    </div>\r\n");
      out.write("</div>\r\n");
      out.write("<!-- 로딩바 관련 끝 -->\r\n");
      out.write("\r\n");
      out.write("<div class=\"back_lock\" id=\"back_lock\"></div>\r\n");
      if (_jspx_meth_sec_005fauthorize_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("		<!-- begin #header -->\r\n");
      out.write("		<div id=\"header\" class=\"header navbar navbar-default navbar-fixed-top\">\r\n");
      out.write("			<!-- begin container-fluid -->\r\n");
      out.write("			<div class=\"info tar\" style=\"padding-top:25px; padding-right:24px;\">\r\n");
      out.write("				<!-- 상단 변경요청 및 미사용 -->\r\n");
      out.write("\r\n");
      out.write("				<span class=\"mr20\"><b class=\"userName\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${userName}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write('(');
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${userId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write(") 님</b> </span>\r\n");
      out.write("				<a title=\"내정보\" href=\"javascript:;\" onclick=\"location.href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/cmm/user/userInfo'\" class=\"fcca mr20\"><i class=\"fa fa-user-o\"></i> 내정보</a>\r\n");
      out.write("				<a title=\"Logout\" href=\"javascript:;\" onclick=\"location.href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/j_spring_security_logout'\" class=\"fcca mr10\"> <i class=\"fa fa-sign-out\"></i> 로그아웃</a>\r\n");
      out.write("\r\n");
      out.write("			</div>\r\n");
      out.write("\r\n");
      out.write("			<div class=\"container-fluid\">\r\n");
      out.write("				<!-- begin mobile sidebar expand / collapse button -->\r\n");
      out.write("				<div class=\"navbar-header\">\r\n");
      out.write("					<a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/main\" class=\"navbar-brand\"><img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${apachePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/assets/img/logo.png\" class=\"logo\" alt=\"ECloud\"/> </a>\r\n");
      out.write("				</div>\r\n");
      out.write("				<!-- end mobile sidebar expand / collapse button -->\r\n");
      out.write("\r\n");
      out.write("					<li>\r\n");
      out.write("                        <!-- begin sidebar minify button -->\r\n");
      out.write("                        <a href=\"javascript:;\" class=\"main-minify-btn\" data-click=\"sidebar-minify\"><i class=\"fa fa-angle-left\"></i></a>\r\n");
      out.write("                        <!-- end sidebar minify button -->\r\n");
      out.write("					</li>\r\n");
      out.write("\r\n");
      out.write("				<!-- begin navbar-right -->\r\n");
      out.write("				<!--\r\n");
      out.write("				<ul class=\"nav navbar-nav navbar-right\">\r\n");
      out.write("					<li class=\"dropdown navbar-user\">\r\n");
      out.write("						<a type='button' >\r\n");
      out.write("							<span class=\"hidden-xs\"><b>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${userName}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write('(');
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${userId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write(")님</b> 반갑습니다.</span>\r\n");
      out.write("							<input type='hidden' id='loginId' value='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${userId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("'/>\r\n");
      out.write("						</a>\r\n");
      out.write("					</li>\r\n");
      out.write("					<li class=\"mt15\">\r\n");
      out.write("						<div style='float:left;padding-left:5px;'>\r\n");
      out.write("							<a class=\"btn btn-lime btn-s f11\" title=\"내정보\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/cmm/user/userInfo\"> <i class=\"fa fa-info-circle\"></i> 내정보</a>\r\n");
      out.write("						</div>\r\n");
      out.write("						<div style='float:left;padding-left:5px;'>\r\n");
      out.write("							<a class=\"btn btn-primary btn-s f11\" title=\"일괄신청\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/basketOrder.do\"><i class=\"fa fa-shopping-basket\"></i> 일괄신청</a>\r\n");
      out.write("						</div>\r\n");
      out.write("						<div style='float:left;padding-left:5px;'>\r\n");
      out.write("							<a class=\"btn btn-grey btn-s f11\" title=\"Logout\" href=\"j_spring_security_logout\"><i class=\"fa fa-sign-out\"></i> 로그아웃</a>\r\n");
      out.write("						</div>\r\n");
      out.write("					</li>\r\n");
      out.write("				</ul>\r\n");
      out.write("				-->\r\n");
      out.write("				<!-- end navbar-right -->\r\n");
      out.write("			</div>\r\n");
      out.write("			<!-- end container-fluid -->\r\n");
      out.write("		</div>\r\n");
      out.write("		<!-- end #header -->\r\n");
      out.write("		<!--\r\n");
      out.write("		<body class=\"boxed-layout\">\r\n");
      out.write("	 	-->\r\n");
      out.write("		<script type=\"text/javascript\">\r\n");
      out.write("			var tid;\r\n");
      out.write("			var time = 32382; // 시간-1초\r\n");
      out.write("			var cnt = parseInt(time, 10);\r\n");
      out.write("\r\n");
      out.write("			function time_run() {\r\n");
      out.write("				$(\"#divTimerCount\").text(time_format(cnt));\r\n");
      out.write("				cnt --;\r\n");
      out.write("				if(cnt<0){\r\n");
      out.write("					clearInterval(tid);\r\n");
      out.write("					alertBox(\"접속시간이 만료되었습니다.\", logout);\r\n");
      out.write("				}\r\n");
      out.write("			}\r\n");
      out.write("\r\n");
      out.write("			function time_format(n){\r\n");
      out.write("				var h = 0;\r\n");
      out.write("				var m = 0;\r\n");
      out.write("				var s = 0;\r\n");
      out.write("				if(n>0){\r\n");
      out.write("\r\n");
      out.write("					h =  Math.floor(n /3600);\r\n");
      out.write("					m =  Math.floor((n -(h * 3600)) / 60);\r\n");
      out.write("					s =   n - (h *3600) - (m*60);\r\n");
      out.write("				}\r\n");
      out.write("				if(h<10){ h = \"0\"+h; }\r\n");
      out.write("				if(m<10){ m = \"0\"+m; }\r\n");
      out.write("				if(s<10){ s = \"0\"+s; }\r\n");
      out.write("				return h+\":\"+m+\":\"+s;\r\n");
      out.write("			}\r\n");
      out.write("\r\n");
      out.write("			function timerExtension(){\r\n");
      out.write("				$.ajax({\r\n");
      out.write("					url : \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/mbrhome/timer\",\r\n");
      out.write("					type : \"POST\",\r\n");
      out.write("					success : function(data) {\r\n");
      out.write("						$(\"#divTimerCount\").text(\"09:00:00\");\r\n");
      out.write("						clearInterval(tid);\r\n");
      out.write("						cnt = parseInt(time, 10);\r\n");
      out.write("						tid = setInterval(\"time_run()\", 1000)\r\n");
      out.write("					}\r\n");
      out.write("				});\r\n");
      out.write("			}\r\n");
      out.write("\r\n");
      out.write("			//헤더 이미지 출력\r\n");
      out.write("			function getUserPic(){\r\n");
      out.write("				$.ajax({\r\n");
      out.write("					url : \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/cmm/user/userPic\",\r\n");
      out.write("					dataType : \"JSON\",\r\n");
      out.write("					type : \"POST\",\r\n");
      out.write("					data : {\r\n");
      out.write("\r\n");
      out.write("					},\r\n");
      out.write("					success : function(data) {\r\n");
      out.write("						var fileList = data.picFile;\r\n");
      out.write("						var fileId = \"\";\r\n");
      out.write("						if(fileList.length!=0){\r\n");
      out.write("							$.each(fileList,function(key,val){\r\n");
      out.write("								fileId = val[\"fileId\"];\r\n");
      out.write("							});\r\n");
      out.write("							$(\"#headerUserPic\").attr(\"src\", \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/cmm/file/download/\"+fileId+\"\");\r\n");
      out.write("						}else{\r\n");
      out.write("							$(\"#headerUserPic\").attr(\"src\", \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${apachePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/assets/img/df_user_icon.png\");\r\n");
      out.write("						}\r\n");
      out.write("					},\r\n");
      out.write("					error : function(request, status, error) {\r\n");
      out.write("						if(request.status == '200'){\r\n");
      out.write("							alertBox(\"접속이 만료되었습니다.\", logout);\r\n");
      out.write("						}else{\r\n");
      out.write("							alertBox3(\"code:\" + request.status + \"\\n\" + \"error:\" + error);\r\n");
      out.write("						}\r\n");
      out.write("					}\r\n");
      out.write("				});\r\n");
      out.write("			}\r\n");
      out.write("\r\n");
      out.write("			function getBasketCnt(){\r\n");
      out.write("				$.ajax({\r\n");
      out.write("					url : \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/getBasketCnt\",\r\n");
      out.write("					dataType : \"JSON\",\r\n");
      out.write("					type : \"POST\",\r\n");
      out.write("					data : {\r\n");
      out.write("\r\n");
      out.write("					},\r\n");
      out.write("					success : function(data) {\r\n");
      out.write("						var basketCnt = data;\r\n");
      out.write("						$(\"#basketCnt > strong\").remove();\r\n");
      out.write("						if(basketCnt > 0) {\r\n");
      out.write("							$(\"#basketCnt\").append(\"<strong>\"+basketCnt+\"</strong>\");\r\n");
      out.write("						} else if (basketCnt > 99) {\r\n");
      out.write("							$(\"#basketCnt\").append(\"<strong>99+</strong>\");\r\n");
      out.write("						}\r\n");
      out.write("					},\r\n");
      out.write("					error : function(request, status, error) {\r\n");
      out.write("						if(request.status == '200'){\r\n");
      out.write("							alertBox(\"접속이 만료되었습니다.\", logout);\r\n");
      out.write("						}else{\r\n");
      out.write("							alertBox3(\"code:\" + request.status + \"\\n\" + \"error:\" + error);\r\n");
      out.write("						}\r\n");
      out.write("					}\r\n");
      out.write("				});\r\n");
      out.write("			}\r\n");
      out.write("			Date.prototype.format = function (f) {\r\n");
      out.write("			    if (!this.valueOf()) return \" \";\r\n");
      out.write("			    var weekKorName = [\"일요일\", \"월요일\", \"화요일\", \"수요일\", \"목요일\", \"금요일\", \"토요일\"];\r\n");
      out.write("			    var weekKorShortName = [\"일\", \"월\", \"화\", \"수\", \"목\", \"금\", \"토\"];\r\n");
      out.write("			    var weekEngName = [\"Sunday\", \"Monday\", \"Tuesday\", \"Wednesday\", \"Thursday\", \"Friday\", \"Saturday\"];\r\n");
      out.write("			    var weekEngShortName = [\"Sun\", \"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\"];\r\n");
      out.write("			    var d = this;\r\n");
      out.write("			    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\\/p)/gi, function ($1) {\r\n");
      out.write("			        switch ($1) {\r\n");
      out.write("			            case \"yyyy\": return d.getFullYear(); // 년 (4자리)\r\n");
      out.write("			            case \"yy\": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)\r\n");
      out.write("			            case \"MM\": return (d.getMonth() + 1).zf(2); // 월 (2자리)\r\n");
      out.write("			            case \"dd\": return d.getDate().zf(2); // 일 (2자리)\r\n");
      out.write("			            case \"KS\": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)\r\n");
      out.write("			            case \"KL\": return weekKorName[d.getDay()]; // 요일 (긴 한글)\r\n");
      out.write("			            case \"ES\": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)\r\n");
      out.write("			            case \"EL\": return weekEngName[d.getDay()]; // 요일 (긴 영어)\r\n");
      out.write("			            case \"HH\": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)\r\n");
      out.write("			            case \"hh\": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)\r\n");
      out.write("			            case \"mm\": return d.getMinutes().zf(2); // 분 (2자리)\r\n");
      out.write("			            case \"ss\": return d.getSeconds().zf(2); // 초 (2자리\r\n");
      out.write("			            case \"a/p\": return d.getHours() < 12 ? \"오전\" : \"오후\"; // 오전/오후 구분\r\n");
      out.write("			            default: return $1;\r\n");
      out.write("			        }\r\n");
      out.write("			    });\r\n");
      out.write("			};\r\n");
      out.write("			String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };\r\n");
      out.write("			String.prototype.zf = function (len) { return \"0\".string(len - this.length) + this; };\r\n");
      out.write("			Number.prototype.zf = function (len) { return this.toString().zf(len); };\r\n");
      out.write("\r\n");
      out.write("			$(document).ready(function(){\r\n");
      out.write("				getUserPic();\r\n");
      out.write("				getBasketCnt();\r\n");
      out.write("				tid = setInterval(\"time_run()\", 1000);\r\n");
      out.write("			});\r\n");
      out.write("		</script>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_sec_005fauthorize_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  sec:authorize
    org.springframework.security.taglibs.authz.JspAuthorizeTag _jspx_th_sec_005fauthorize_005f0 = (org.springframework.security.taglibs.authz.JspAuthorizeTag) _005fjspx_005ftagPool_005fsec_005fauthorize_0026_005faccess.get(org.springframework.security.taglibs.authz.JspAuthorizeTag.class);
    boolean _jspx_th_sec_005fauthorize_005f0_reused = false;
    try {
      _jspx_th_sec_005fauthorize_005f0.setPageContext(_jspx_page_context);
      _jspx_th_sec_005fauthorize_005f0.setParent(null);
      // /WEB-INF/views/mbr/include/header.jsp(65,0) name = access type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_sec_005fauthorize_005f0.setAccess("isAuthenticated()");
      int _jspx_eval_sec_005fauthorize_005f0 = _jspx_th_sec_005fauthorize_005f0.doStartTag();
      if (_jspx_eval_sec_005fauthorize_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        out.write('\r');
        out.write('\n');
        out.write('	');
        if (_jspx_meth_sec_005fauthentication_005f0(_jspx_th_sec_005fauthorize_005f0, _jspx_page_context))
          return true;
        out.write('\r');
        out.write('\n');
        out.write('	');
        if (_jspx_meth_sec_005fauthentication_005f1(_jspx_th_sec_005fauthorize_005f0, _jspx_page_context))
          return true;
        out.write('\r');
        out.write('\n');
      }
      if (_jspx_th_sec_005fauthorize_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fsec_005fauthorize_0026_005faccess.reuse(_jspx_th_sec_005fauthorize_005f0);
      _jspx_th_sec_005fauthorize_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_sec_005fauthorize_005f0, _jsp_getInstanceManager(), _jspx_th_sec_005fauthorize_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_sec_005fauthentication_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_sec_005fauthorize_005f0, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  sec:authentication
    org.springframework.security.taglibs.authz.AuthenticationTag _jspx_th_sec_005fauthentication_005f0 = (org.springframework.security.taglibs.authz.AuthenticationTag) _005fjspx_005ftagPool_005fsec_005fauthentication_0026_005fvar_005fproperty_005fnobody.get(org.springframework.security.taglibs.authz.AuthenticationTag.class);
    boolean _jspx_th_sec_005fauthentication_005f0_reused = false;
    try {
      _jspx_th_sec_005fauthentication_005f0.setPageContext(_jspx_page_context);
      _jspx_th_sec_005fauthentication_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_sec_005fauthorize_005f0);
      // /WEB-INF/views/mbr/include/header.jsp(66,1) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_sec_005fauthentication_005f0.setVar("userId");
      // /WEB-INF/views/mbr/include/header.jsp(66,1) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_sec_005fauthentication_005f0.setProperty("principal.username");
      int _jspx_eval_sec_005fauthentication_005f0 = _jspx_th_sec_005fauthentication_005f0.doStartTag();
      if (_jspx_th_sec_005fauthentication_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fsec_005fauthentication_0026_005fvar_005fproperty_005fnobody.reuse(_jspx_th_sec_005fauthentication_005f0);
      _jspx_th_sec_005fauthentication_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_sec_005fauthentication_005f0, _jsp_getInstanceManager(), _jspx_th_sec_005fauthentication_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_sec_005fauthentication_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_sec_005fauthorize_005f0, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  sec:authentication
    org.springframework.security.taglibs.authz.AuthenticationTag _jspx_th_sec_005fauthentication_005f1 = (org.springframework.security.taglibs.authz.AuthenticationTag) _005fjspx_005ftagPool_005fsec_005fauthentication_0026_005fvar_005fproperty_005fnobody.get(org.springframework.security.taglibs.authz.AuthenticationTag.class);
    boolean _jspx_th_sec_005fauthentication_005f1_reused = false;
    try {
      _jspx_th_sec_005fauthentication_005f1.setPageContext(_jspx_page_context);
      _jspx_th_sec_005fauthentication_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_sec_005fauthorize_005f0);
      // /WEB-INF/views/mbr/include/header.jsp(67,1) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_sec_005fauthentication_005f1.setVar("userName");
      // /WEB-INF/views/mbr/include/header.jsp(67,1) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_sec_005fauthentication_005f1.setProperty("principal.nickname");
      int _jspx_eval_sec_005fauthentication_005f1 = _jspx_th_sec_005fauthentication_005f1.doStartTag();
      if (_jspx_th_sec_005fauthentication_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fsec_005fauthentication_0026_005fvar_005fproperty_005fnobody.reuse(_jspx_th_sec_005fauthentication_005f1);
      _jspx_th_sec_005fauthentication_005f1_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_sec_005fauthentication_005f1, _jsp_getInstanceManager(), _jspx_th_sec_005fauthentication_005f1_reused);
    }
    return false;
  }
}
