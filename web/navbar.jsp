<%-- 
    Document   : navbar
    Created on : Jul 30, 2015, 3:53:19 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%  //session.setAttribute("LoginStatus", ""); %>

<%
    if (session.getAttribute("login") != null) {
%>

<!--if user logged in-->

<jsp:include page="navbar_home.jsp"></jsp:include>

    <!--if user logged in-->

<%
} else {
%>

<!--if user not logged in-->

<jsp:include page="navbar_start.jsp"></jsp:include>

    <!--if user not logged in-->

<%
    }
%>
