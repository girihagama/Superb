<%-- 
    Document   : Ad_Not_Found
    Created on : May 29, 2016, 11:32:01 AM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Advertisement Not Available!</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="BootstrapHeader.jsp"></jsp:include>
        <jsp:include page="meta_tags.jsp"></jsp:include>
        <link href='https://fonts.googleapis.com/css?family=Catamaran:100' rel='stylesheet' type='text/css'>

        <style>
            body{
                font-family: 'Catamaran', sans-serif;
                //background-color: white;
                padding: 10px;                
                color: black;
                border: solid 3px gray;
                border-radius: 10px;
               box-shadow: inset 0px 0px 10px 1px red;
            }
        </style>

    </head>
    <body class="container-fluid" style="margin: 20px;">
        <div class="row" style="">
            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                <center>
                    <img class="img-responsive" style="width: 100px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Not-available.svg/2000px-Not-available.svg.png"/>
                </center>
            </div>
            <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
                <h1>Sorry, Advertisement Not Available!</h1>
                <small>
                    May Be Access Is Denied Due To Wrong Item number Or Account Type.<br>
                    Or Advertisement Is Currently Not Active, Please Try Again Later!
                </small>
            </div>

        </div>
    </body>
</html>
