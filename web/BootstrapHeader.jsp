<%-- 
    Document   : BootstrapHeader
    Created on : Jun 15, 2015, 10:13:56 AM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--site icon-->
        <link rel="icon" type="image/png" href="favicon.png">

        <!----------------------------->  

        <!--aditional CSS imports-->

        <link rel="stylesheet" href="custom_styles_scripts/navigation.css">
        <link rel="stylesheet" href="custom_styles_scripts/tabs_panel.css"/>
        <link rel="stylesheet" href="custom_styles_scripts/offer_style.css"/>
        <link rel="stylesheet" href="custom_styles_scripts/ChatStatus.css"/>

        <!--aditional CSS imports end-->

        <!--aditional JS imports-->

        <!--aditional JS imports end-->

        <!----------------------------->

        <script src="jquery/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

        <!--
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
        -->

        <!--Internal Scripts-->

        <script type="text/javascript">

            //popover plugin
            $(function () {
                $('[data-toggle="popover"]').popover();
            })

        </script>

        <script type="text/javascript">

            //tooltip plugin
            $(function () {
                $('[data-toggle="tooltip"]').tooltip();
            })

        </script>

        <noscript>
    <div class="alert alert-danger text-center" role="alert">
        <h2>
            Your Browser Not Support / Allow Java Scripts!<br>
            <small>Please Enable Scripts In Your Web Browser Or Use Java Script Supported Web Browser</small>
        </h2>
    </div>
    </noscript>

    <jsp:include page="Ajax_CommonActivities.jsp"></jsp:include>

    <!--Internal Scripts end-->

</head>
</html>
