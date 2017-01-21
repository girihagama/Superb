<%-- 
    Document   : navbar_start
    Created on : Jul 10, 2015, 11:33:43 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:include page="model_signup.jsp"></jsp:include>
<jsp:include page="model_login.jsp"></jsp:include>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="menubar/bootstrap.min.css">

        <style>
            .amazonBtn{
                /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#fefcea+0,ead6a8+7,eac160+38,edc050+71 */
                background: #fefcea; /* Old browsers */
                background: -moz-linear-gradient(top,  #fefcea 0%, #ead6a8 7%, #eac160 38%, #edc050 71%); /* FF3.6-15 */
                background: -webkit-linear-gradient(top,  #fefcea 0%,#ead6a8 7%,#eac160 38%,#edc050 71%); /* Chrome10-25,Safari5.1-6 */
                background: linear-gradient(to bottom,  #fefcea 0%,#ead6a8 7%,#eac160 38%,#edc050 71%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
                filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fefcea', endColorstr='#edc050',GradientType=0 ); /* IE6-9 */
            }
        </style>

    </head>

    <!--remove class="navbar-fixed-top" attribute in case of error-->
    <body style="font-family: Trebuchet MS, Helvetica, sans-serif; padding: 1px;" class="text-center container-fluid">
        <div class="navbar navbar-custom">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="index.jsp" class="navbar-brand" style="font-weight: bold;">
                    <span class="glyphicon glyphicon-shopping-cart"></span>
                    Superb.lk
                </a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav">
                    <li class="text-center">                        

                        <a href="postAD.jsp" style="color: white; border-radius: 0px; border: solid yellow 1px;font-weight: 100; position: relative;" class="amazonBtn">
                            <span class="glyphicon glyphicon-send"></span>
                            POST AD
                        </a>

                    </li>                  
                </ul>
                <form class="navbar-form navbar-left center-block" method="GET" action="Search" role="search">
                    <div class="form-group">
                        <input name="searchTerm" class="form-control" placeholder="I'm looking for" type="text" value="<%if(request.getParameter("searchTerm")!=null){%><%=request.getParameter("searchTerm")%><%}%>" required="">
                    </div>
                    <button type="submit" class="btn btn-info" style="border: solid 2px gray;">Search</button>
                </form>                

                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a data-toggle="modal" data-target="#signup_model" href="">
                            Sign Up
                        </a>
                    </li>
                    <li>
                        <a data-toggle="modal" data-target="#login_model" href="">
                            <b>Log In</b>
                        </a>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div>



