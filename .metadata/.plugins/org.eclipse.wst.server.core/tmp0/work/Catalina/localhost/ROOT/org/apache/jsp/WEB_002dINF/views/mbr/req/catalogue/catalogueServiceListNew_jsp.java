/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.56
 * Generated at: 2025-01-16 23:12:40 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.mbr.req.catalogue;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class catalogueServiceListNew_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(4);
    _jspx_dependants.put("jar:file:/D:/workspace/k-cloud-20250113-dev/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/iVuCenter_Cloud_Was/WEB-INF/lib/jstl-1.2.jar!/META-INF/fn.tld", Long.valueOf(1153352682000L));
    _jspx_dependants.put("/WEB-INF/lib/jstl-1.2.jar", Long.valueOf(1709100854747L));
    _jspx_dependants.put("jar:file:/D:/workspace/k-cloud-20250113-dev/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/iVuCenter_Cloud_Was/WEB-INF/lib/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153352682000L));
    _jspx_dependants.put("jar:file:/D:/workspace/k-cloud-20250113-dev/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/iVuCenter_Cloud_Was/WEB-INF/lib/jstl-1.2.jar!/META-INF/fmt.tld", Long.valueOf(1153352682000L));
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

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody;

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
    _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody.release();
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
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html lang=\"ko\">\r\n");
      out.write("<head>\r\n");
      out.write("	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("	<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\">\r\n");
      out.write("	<meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\" name=\"viewport\" />\r\n");
      out.write("	<meta content=\"\" name=\"description\" />\r\n");
      out.write("	<meta content=\"\" name=\"author\" />\r\n");
      out.write("	");
      if (_jspx_meth_c_005fimport_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("	<title>KEPCO Cloud Service Platform</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<!-- <body class=\"boxed-layout\">  -->\r\n");
      out.write("\r\n");
      out.write("	<!-- begin #page-container -->\r\n");
      out.write("	<div id=\"page-container\" class=\"fade page-container page-header-fixed page-sidebar-fixed page-with-footer\">\r\n");
      out.write("		<!-- begin #header -->\r\n");
      out.write("		");
      if (_jspx_meth_c_005fimport_005f1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("		<!-- end #header -->\r\n");
      out.write("\r\n");
      out.write("		<!-- begin #sidebar -->\r\n");
      out.write("		");
      if (_jspx_meth_c_005fimport_005f2(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("		<!-- end #sidebar -->\r\n");
      out.write("\r\n");
      out.write("		<!-- begin #content -->\r\n");
      out.write("		<div id=\"content\" class=\"content\">\r\n");
      out.write("\r\n");
      out.write("			<p class=\"page_title\">서비스 신청\r\n");
      out.write("				<span class=\"root f14\">Home <span class=\"arrow_ab\"> &#8227; </span><a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/main\"> 콘솔</a>  <span class=\"arrow_ab\"> &#8227; </span> 자원신청  <span class=\"arrow_ab\"> &#8227; </span> <b>서비스 신청 </b>\r\n");
      out.write("			    </span>\r\n");
      out.write("			</p>\r\n");
      out.write("			 <!-- begin page-body -->\r\n");
      out.write("			 <div class=\"row p20 bgwh br10\">\r\n");
      out.write("			      <div id=\"btnContainer\" style=\"text-align:right; \">\r\n");
      out.write("				  <button class=\"btnns active\" onclick=\"listView()\"><i class=\"fa fa-bars\"></i> List</button>\r\n");
      out.write("				  <button class=\"btnns ml10\" onclick=\"gridView()\"><i class=\"fa fa-th-large\"></i> Grid</button>\r\n");
      out.write("				  </div>\r\n");
      out.write("\r\n");
      out.write("					<div class=\"service-row productvmList\" style=\"border-top:none; \">\r\n");
      out.write("\r\n");
      out.write("					</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("			<!---- end page body---->\r\n");
      out.write("            </div>\r\n");
      out.write("\r\n");
      out.write("			<!-- begin #footer -->\r\n");
      out.write("			");
      if (_jspx_meth_c_005fimport_005f3(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("			<!-- end #footer -->\r\n");
      out.write("\r\n");
      out.write("		</div>\r\n");
      out.write("		<!-- end #content -->\r\n");
      out.write("\r\n");
      out.write("	<!-- end page container -->\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      if (_jspx_meth_c_005fimport_005f4(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\r\n");
      out.write("		$(document).ready(function() {\r\n");
      out.write("\r\n");
      out.write("			App.init();\r\n");
      out.write("\r\n");
      out.write("		  	if($(\"input[name='hourlyFlag']:checked\").val()==\"N\"){\r\n");
      out.write("				$(\"#hourlyPriceview\").hide();\r\n");
      out.write("				$(\"#monthlyPriceview\").show();\r\n");
      out.write("			}else{\r\n");
      out.write("				$(\"#monthlyPriceview\").hide();\r\n");
      out.write("				$(\"#hourlyPriceview\").show();\r\n");
      out.write("			}\r\n");
      out.write("\r\n");
      out.write("			$(\"a>button\").on('click',function(){\r\n");
      out.write("				location.href = $(this).closest(\"a\").attr(\"href\");\r\n");
      out.write("			});\r\n");
      out.write("\r\n");
      out.write("			$(\"input[name='hourlyFlag']\").on('click',function(){\r\n");
      out.write("				//alert($(\"input[name='hourlyFlag']:checked\").val());\r\n");
      out.write("				if($(\"input[name='hourlyFlag']:checked\").val()==\"N\"){\r\n");
      out.write("					$(\"#hourlyPriceview\").hide();\r\n");
      out.write("					$(\"#monthlyPriceview\").show();\r\n");
      out.write("				}else{\r\n");
      out.write("					$(\"#monthlyPriceview\").hide();\r\n");
      out.write("					$(\"#hourlyPriceview\").show();\r\n");
      out.write("				}\r\n");
      out.write("			});\r\n");
      out.write("\r\n");
      out.write("			$(\".panel-heading-btn a i\").click(function(){\r\n");
      out.write("				$(this).toggleClass(\"fa-chevron-down fa-chevron-up\");\r\n");
      out.write("			});\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("		/*	$(\".catalogTapArea ul li\").click(function(){\r\n");
      out.write("				var tapPage= \"#page-\"+ $(this).attr('id');\r\n");
      out.write("\r\n");
      out.write("				$(\".catalogTapArea ul li\").removeClass(\"active\");\r\n");
      out.write("				$(this).toggleClass(\"active\");\r\n");
      out.write("\r\n");
      out.write("				$(\".tabPageArea\").removeClass(\"active\");\r\n");
      out.write("				$(tapPage).addClass(\"active\");\r\n");
      out.write("			}); */\r\n");
      out.write("\r\n");
      out.write("			// sidebar 메뉴 활성화\r\n");
      out.write("			$(\"#reqProduct\").addClass(\"active\");\r\n");
      out.write("			$(\"#service\").addClass(\"active\");\r\n");
      out.write("\r\n");
      out.write("			gridItem();\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("		});\r\n");
      out.write("\r\n");
      out.write("		function gridItem(){\r\n");
      out.write("			//$(\".productList tbody\").empty();\r\n");
      out.write("			$(\".productList\").empty();\r\n");
      out.write("			var category = ['CATACATE_MCA', 'CATACATE_BACKUP','CATACATE_SCM', 'CATACATE_SECURITY', 'CATACATE_SERVICE'];\r\n");
      out.write("			var html = \"\";\r\n");
      out.write("			$.ajax({\r\n");
      out.write("				url : \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/serviceList\",\r\n");
      out.write("				dataType : \"JSON\",\r\n");
      out.write("	 			type : \"GET\",\r\n");
      out.write("				success : function(req) {\r\n");
      out.write("					var vmList = req;\r\n");
      out.write("					$.each(vmList,function(key,val){\r\n");
      out.write("					if(jQuery.inArray(val[\"catalogCategory\"],category)){\r\n");
      out.write("						/* 	var Html=\"\";\r\n");
      out.write("							Html=\"<tr>\";\r\n");
      out.write("							Html+=\"<td class='tac vm'><img src='\"+val[\"imagePath\"]+\"'  class='height-80'>\";\r\n");
      out.write("							Html+=\"<td class='serverInfo'><p class='infoTitle'>\"+val[\"displayName\"]+\"</p>\";\r\n");
      out.write("							if(val[\"descriptionList\"] != null || val[\"descriptionList\"] != \"\"){\r\n");
      out.write("								Html+=\"<p class='infoContents'>\"+val[\"descriptionList\"].replace('\\n','<br/>')+\"</p>\";\r\n");
      out.write("							} else {\r\n");
      out.write("								Html+=\"<p class='infoContents'>'서비스 로드분산입니다.'</p>\";\r\n");
      out.write("							}\r\n");
      out.write("							Html+=\"</td>\";\r\n");
      out.write("							if(val[\"serviceType\"] == \"loadbalancer\"){\r\n");
      out.write("								Html+=\"<td class='BasketArea'><a href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/catalogueLoadBalancerOrder.do?productSeq=\"+val[\"productSeq\"]+\"&hourlyFlag=N&serviceType=\"+val[\"serviceType\"]+\"' class='insertBasket'></a></td>\";\r\n");
      out.write("							} else if (val[\"serviceType\"] == \"snapshot\") {\r\n");
      out.write("								Html+=\"<td class='BasketArea'><a href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/catalogueSnapShotOrder.do?productSeq=\"+val[\"productSeq\"]+\"&hourlyFlag=N&serviceType=\"+val[\"serviceType\"]+\"' class='insertBasket'></a></td>\";\r\n");
      out.write("							} else if (val[\"serviceType\"] == \"10\") {\r\n");
      out.write("								Html+=\"<td class='BasketArea'><a href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/cataloguePaasServiceOrder.do?productSeq=\"+val[\"productSeq\"]+\"&hourlyFlag=N&serviceType=\"+val[\"serviceType\"]+\"' class='insertBasket'></a></td>\";\r\n");
      out.write("							} else if (val[\"serviceType\"] == \"11\") {\r\n");
      out.write("								Html+=\"<td class='BasketArea'><a href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/cataloguePaasServiceOrder.do?productSeq=\"+val[\"productSeq\"]+\"&hourlyFlag=N&serviceType=\"+val[\"serviceType\"]+\"' class='insertBasket'></a></td>\";\r\n");
      out.write("							} else {\r\n");
      out.write("								Html+=\"<td class='BasketArea'><a href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/catalogueServiceOrder.do?productSeq=\"+val[\"productSeq\"]+\"&hourlyFlag=N&serviceType=\"+val[\"serviceType\"]+\"' class='insertBasket'></a></td>\";\r\n");
      out.write("							}\r\n");
      out.write("							Html+=\"</tr>\";\r\n");
      out.write("							$(\".productvmList tbody\").append(Html); */\r\n");
      out.write("\r\n");
      out.write("							var Html=\"\";\r\n");
      out.write("							Html=\"<div class='column'>\";\r\n");
      out.write("							Html+=\"<li><img src='\"+val[\"imagePath\"]+\"'class='height-80'></li>\";\r\n");
      out.write("							Html+=\"<li><h4 class='infoTitle'>\"+val[\"displayName\"]+\"</h4>\";\r\n");
      out.write("							if(val[\"descriptionList\"] != null || val[\"descriptionList\"] != \"\"){\r\n");
      out.write("								Html+=\"<p class='infoContents'>\"+val[\"descriptionList\"].replace('\\n','<br/>')+\"</p>\";\r\n");
      out.write("							} else {\r\n");
      out.write("								Html+=\"<p class='infoContents'>'서비스 로드분산입니다.'</p>\";\r\n");
      out.write("							}\r\n");
      out.write("							Html+=\"</li>\";\r\n");
      out.write("							if(val[\"serviceType\"] == \"loadbalancer\"){\r\n");
      out.write("								Html+=\"<li><a href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/catalogueLoadBalancerOrder.do?productSeq=\"+val[\"productSeq\"]+\"&hourlyFlag=N&serviceType=\"+val[\"serviceType\"]+\"' class='serBasket'></a></li>\";\r\n");
      out.write("							} else if (val[\"serviceType\"] == \"snapshot\") {\r\n");
      out.write("								Html+=\"<li><a href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/catalogueSnapShotOrder.do?productSeq=\"+val[\"productSeq\"]+\"&hourlyFlag=N&serviceType=\"+val[\"serviceType\"]+\"' class='serBasket'></a></li>\";\r\n");
      out.write("							} else if (val[\"serviceType\"] == \"10\") {\r\n");
      out.write("								Html+=\"<li><a href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/cataloguePaasServiceOrder.do?productSeq=\"+val[\"productSeq\"]+\"&hourlyFlag=N&serviceType=\"+val[\"serviceType\"]+\"' class='serBasket'></a></li>\";\r\n");
      out.write("							} else if (val[\"serviceType\"] == \"11\") {\r\n");
      out.write("								Html+=\"<li><a href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/cataloguePaasServiceOrder.do?productSeq=\"+val[\"productSeq\"]+\"&hourlyFlag=N&serviceType=\"+val[\"serviceType\"]+\"' class='serBasket'></a></li>\";\r\n");
      out.write("							} else {\r\n");
      out.write("								Html+=\"<li><a href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wasPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/mbr/req/catalogue/catalogueServiceOrder.do?productSeq=\"+val[\"productSeq\"]+\"&hourlyFlag=N&serviceType=\"+val[\"serviceType\"]+\"' class='serBasket'></a></li>\";\r\n");
      out.write("							}\r\n");
      out.write("							Html+=\"</div>\";\r\n");
      out.write("							$(\".productvmList\").append(Html);\r\n");
      out.write("\r\n");
      out.write("						}\r\n");
      out.write("					})\r\n");
      out.write("				},\r\n");
      out.write("				error : function(request, status, error) {\r\n");
      out.write("					alert(\"code:\" + request.status + \"\\n\" + \"error:\" + error);\r\n");
      out.write("				}\r\n");
      out.write("			});\r\n");
      out.write("		}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("		var elements = document.getElementsByClassName(\"column\");\r\n");
      out.write("		var i;\r\n");
      out.write("		function listView() {\r\n");
      out.write("		  for (i = 0; i < elements.length; i++) {\r\n");
      out.write("		    elements[i].style.width = \"100%\";\r\n");
      out.write("		    elements[i].style.display = \"flex\";\r\n");
      out.write("		    elements[i].style.alignItems = \"center\";\r\n");
      out.write("		    elements[i].querySelector(\"li:nth-child(1)\").style.width = \"17%\";\r\n");
      out.write("		    elements[i].querySelector(\"li:nth-child(2)\").style.width = \"65%\";\r\n");
      out.write("		    elements[i].querySelector(\"li:nth-child(2)\").style.height = \"auto\";\r\n");
      out.write("		    elements[i].querySelector(\"li:nth-child(2) h4.infoTitle\").style.width = \"100%\"\r\n");
      out.write("	    	elements[i].querySelector(\"li:nth-child(2) h4.infoTitle\").style.textAlign = \"left\"\r\n");
      out.write("		    elements[i].querySelector(\"li:nth-child(3)\").style.width = \"17%\";\r\n");
      out.write("		  }\r\n");
      out.write("		}\r\n");
      out.write("		function gridView() {\r\n");
      out.write("		  for (i = 0; i < elements.length; i++) {\r\n");
      out.write("			  let marginRight = \"1%\";\r\n");
      out.write("			  if ( (i+1) % 4 === 0 ) {\r\n");
      out.write("				marginRight =\"0\";\r\n");
      out.write("				  }\r\n");
      out.write("		    elements[i].style.display = \"block\";\r\n");
      out.write("		    elements[i].style.width = \"24.25%\";\r\n");
      out.write("		    elements[i].style.marginRight = marginRight;\r\n");
      out.write("		    elements[i].querySelector(\"li:nth-child(1)\").style.width = \"100%\";\r\n");
      out.write("		    elements[i].querySelector(\"li:nth-child(2)\").style.width = \"100%\";\r\n");
      out.write("		    elements[i].querySelector(\"li:nth-child(2)\").style.height = \"104px\";\r\n");
      out.write("		    elements[i].querySelector(\"li:nth-child(2) h4.infoTitle\").style.width = \"100%\"\r\n");
      out.write("	    	elements[i].querySelector(\"li:nth-child(2) h4.infoTitle\").style.textAlign = \"center\"\r\n");
      out.write("		    elements[i].querySelector(\"li:nth-child(3)\").style.width = \"100%\";\r\n");
      out.write("		  }\r\n");
      out.write("		}\r\n");
      out.write("		var container = document.getElementById(\"btnContainer\");\r\n");
      out.write("		var btns = container.getElementsByClassName(\"btnns\");\r\n");
      out.write("		for (var i = 0; i < btns.length; i++) {\r\n");
      out.write("		  btns[i].addEventListener(\"click\", function(){\r\n");
      out.write("			  toggleActiveViewButton(this);\r\n");
      out.write("		  });\r\n");
      out.write("		}\r\n");
      out.write("\r\n");
      out.write("		function toggleActiveViewButton( button ){\r\n");
      out.write("			let toggleClassName = 'active';\r\n");
      out.write("			for( let i = 0; i < btns.length; i++ ){\r\n");
      out.write("				btns[i].classList.remove(toggleClassName);\r\n");
      out.write("			}\r\n");
      out.write("			button.classList.add(toggleClassName);\r\n");
      out.write("		}\r\n");
      out.write("\r\n");
      out.write("		listView();\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("	</script>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
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

  private boolean _jspx_meth_c_005fimport_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f0 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    boolean _jspx_th_c_005fimport_005f0_reused = false;
    try {
      _jspx_th_c_005fimport_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fimport_005f0.setParent(null);
      // /WEB-INF/views/mbr/req/catalogue/catalogueServiceListNew.jsp(13,1) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fimport_005f0.setUrl("../../include/import.jsp");
      // /WEB-INF/views/mbr/req/catalogue/catalogueServiceListNew.jsp(13,1) name = charEncoding type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fimport_005f0.setCharEncoding("UTF-8");
      int[] _jspx_push_body_count_c_005fimport_005f0 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fimport_005f0 = _jspx_th_c_005fimport_005f0.doStartTag();
        if (_jspx_th_c_005fimport_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return true;
        }
      } catch (java.lang.Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fimport_005f0[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fimport_005f0.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fimport_005f0.doFinally();
      }
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody.reuse(_jspx_th_c_005fimport_005f0);
      _jspx_th_c_005fimport_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fimport_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fimport_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fimport_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f1 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    boolean _jspx_th_c_005fimport_005f1_reused = false;
    try {
      _jspx_th_c_005fimport_005f1.setPageContext(_jspx_page_context);
      _jspx_th_c_005fimport_005f1.setParent(null);
      // /WEB-INF/views/mbr/req/catalogue/catalogueServiceListNew.jsp(22,2) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fimport_005f1.setUrl("../../include/header.jsp");
      // /WEB-INF/views/mbr/req/catalogue/catalogueServiceListNew.jsp(22,2) name = charEncoding type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fimport_005f1.setCharEncoding("UTF-8");
      int[] _jspx_push_body_count_c_005fimport_005f1 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fimport_005f1 = _jspx_th_c_005fimport_005f1.doStartTag();
        if (_jspx_th_c_005fimport_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return true;
        }
      } catch (java.lang.Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fimport_005f1[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fimport_005f1.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fimport_005f1.doFinally();
      }
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody.reuse(_jspx_th_c_005fimport_005f1);
      _jspx_th_c_005fimport_005f1_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fimport_005f1, _jsp_getInstanceManager(), _jspx_th_c_005fimport_005f1_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fimport_005f2(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f2 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    boolean _jspx_th_c_005fimport_005f2_reused = false;
    try {
      _jspx_th_c_005fimport_005f2.setPageContext(_jspx_page_context);
      _jspx_th_c_005fimport_005f2.setParent(null);
      // /WEB-INF/views/mbr/req/catalogue/catalogueServiceListNew.jsp(26,2) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fimport_005f2.setUrl("../../include/sidebar.jsp");
      // /WEB-INF/views/mbr/req/catalogue/catalogueServiceListNew.jsp(26,2) name = charEncoding type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fimport_005f2.setCharEncoding("UTF-8");
      int[] _jspx_push_body_count_c_005fimport_005f2 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fimport_005f2 = _jspx_th_c_005fimport_005f2.doStartTag();
        if (_jspx_th_c_005fimport_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return true;
        }
      } catch (java.lang.Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fimport_005f2[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fimport_005f2.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fimport_005f2.doFinally();
      }
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody.reuse(_jspx_th_c_005fimport_005f2);
      _jspx_th_c_005fimport_005f2_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fimport_005f2, _jsp_getInstanceManager(), _jspx_th_c_005fimport_005f2_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fimport_005f3(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f3 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    boolean _jspx_th_c_005fimport_005f3_reused = false;
    try {
      _jspx_th_c_005fimport_005f3.setPageContext(_jspx_page_context);
      _jspx_th_c_005fimport_005f3.setParent(null);
      // /WEB-INF/views/mbr/req/catalogue/catalogueServiceListNew.jsp(52,3) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fimport_005f3.setUrl("../../include/footer.jsp");
      // /WEB-INF/views/mbr/req/catalogue/catalogueServiceListNew.jsp(52,3) name = charEncoding type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fimport_005f3.setCharEncoding("UTF-8");
      int[] _jspx_push_body_count_c_005fimport_005f3 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fimport_005f3 = _jspx_th_c_005fimport_005f3.doStartTag();
        if (_jspx_th_c_005fimport_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return true;
        }
      } catch (java.lang.Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fimport_005f3[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fimport_005f3.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fimport_005f3.doFinally();
      }
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody.reuse(_jspx_th_c_005fimport_005f3);
      _jspx_th_c_005fimport_005f3_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fimport_005f3, _jsp_getInstanceManager(), _jspx_th_c_005fimport_005f3_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fimport_005f4(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f4 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    boolean _jspx_th_c_005fimport_005f4_reused = false;
    try {
      _jspx_th_c_005fimport_005f4.setPageContext(_jspx_page_context);
      _jspx_th_c_005fimport_005f4.setParent(null);
      // /WEB-INF/views/mbr/req/catalogue/catalogueServiceListNew.jsp(61,0) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fimport_005f4.setUrl("../../include/script.jsp");
      // /WEB-INF/views/mbr/req/catalogue/catalogueServiceListNew.jsp(61,0) name = charEncoding type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fimport_005f4.setCharEncoding("UTF-8");
      int[] _jspx_push_body_count_c_005fimport_005f4 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fimport_005f4 = _jspx_th_c_005fimport_005f4.doStartTag();
        if (_jspx_th_c_005fimport_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return true;
        }
      } catch (java.lang.Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fimport_005f4[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fimport_005f4.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fimport_005f4.doFinally();
      }
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fcharEncoding_005fnobody.reuse(_jspx_th_c_005fimport_005f4);
      _jspx_th_c_005fimport_005f4_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fimport_005f4, _jsp_getInstanceManager(), _jspx_th_c_005fimport_005f4_reused);
    }
    return false;
  }
}
