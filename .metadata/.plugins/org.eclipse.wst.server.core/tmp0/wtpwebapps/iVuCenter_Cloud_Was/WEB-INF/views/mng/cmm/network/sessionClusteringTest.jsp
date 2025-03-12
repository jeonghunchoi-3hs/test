<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.net.InetAddress"%>

<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<c:import url="/WEB-INF/views/mng/include/import.jsp" charEncoding="UTF-8"></c:import>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	
	<title>JSP Session Page</title>
</head>
<body>

	<!-- begin #page-container -->
	<div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer in">
		
		<!-- begin #header -->
		<c:import url="/WEB-INF/views/mng/include/header.jsp" charEncoding="UTF-8"></c:import>
		<!-- end #header -->
	
		<!-- begin #sidebar -->
<%-- 		<c:import url="/WEB-INF/views/mng/include/sidebar.jsp" charEncoding="UTF-8"></c:import>
 --%>		<!-- end #sidebar -->
		
		<!-- begin #content -->
	
	<div class="panel panel-default">

    <div class="panel-heading">Instance</div>  

  <div class="panel-body">

      <% InetAddress IP=InetAddress.getLocalHost(); %>  

      <%= IP.toString() %> : <%=request.getLocalPort()%>

  </div>

</div>

<div class="panel panel-default">

    <div class="panel-heading">Session Info</div>  

  <div class="panel-body">

    <ul "list-group">

    <li class="list-group-item">Session Id : <%=request.getSession().getId()%> </li>

    <li class="list-group-item">Is it New Session : <%=request.getSession().getSessionContext()%> </li>

    <li class="list-group-item">Session Creation Date : <%=new Date(request.getSession().getCreationTime())%> </li>

    <li class="list-group-item">Session Access Date : <%=new Date(request.getSession().getLastAccessedTime())%> </li>

    </ul>

  </div>

</div>



<div class="panel panel-default">

    <div class="panel-heading">Cart List </div>  

  <div class="panel-body">

    <ul class="list-group">

    <%

        String action = request.getParameter("action");



        if ("delete".equals(action)) {

            request.getSession().setAttribute("Books", null);

        }

        else {

            String bookName = request.getParameter("bookName");

            List<String> listOfBooks = (List<String>) request.getSession().getAttribute("Books");



            if (listOfBooks == null) {

                listOfBooks = new ArrayList<String>();

                request.getSession().setAttribute("Books", listOfBooks);

            }

            if (bookName != null) {

                listOfBooks.add(bookName);

                request.getSession().setAttribute("Books", listOfBooks);

            }

            for (String book : listOfBooks) {

                out.println("<li class=\"list-group-item\">"+book + "</li>");

            }

        }

    %>

    </ul>

  </div>

</div>



<!-- modify this URL -->

<form action="session_test.jsp" method="post">

  <div class="form-group">

    <label for="bookName">Book Name :</label>

    <input type="text" class="form-control" id="bookName" name="bookName">

  </div>

  <button type="submit" class="btn btn-default">Add to Cart</button>

</form>



<br/>

<form action="session_test.jsp" method="GET">

    <input type="hidden" name="action" value="delete" />

     <div class="form-group">

        <label for="bookName">Clear :</label>

     </div>

  <button type="submit" class="btn btn-default">Clear All data in the Cart</button>

</form>
	
	
	
	
	
	
	
	
	
	</div>
	<!-- end page container -->

<c:import url="/WEB-INF/views/mng/include/script.jsp" charEncoding="UTF-8"></c:import>

</body>
</html>