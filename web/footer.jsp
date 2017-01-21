<%-- 
    Document   : footer
    Created on : Nov 26, 2015, 2:09:53 AM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="SOCIAL SHARE KIT/dist/css/social-share-kit.css" type="text/css">

        <style>
            .gradiant{
                box-shadow: inset 0 1px 20px -6px;
            }

            .upperLine{
                border-top: solid 4px navy;
                margin-top: 65px;
                margin-bottom: 5px;
            }

            br{
                margin-bottom: 3px;
            }          

        </style>
        

    </head>

    <body class="container-fluid " style="font-family: calibri; text-align: left;">
        <div class="row-fluid footer-anchor">
            <div class="col-lg-12 upperLine gradiant">

                <div class="container" style="padding: 0% 10% 0% 10%;">

                    <div class="row" style="margin-top: 20px;">

                        <div class="col-sm-4 col-sm-4 col-xs-12" style="margin-bottom: 10px;">
                            <hr>
                            <b><u>Superb.lk</u></b>
                            <br>
                            <img src="media/images/LogoCurved.png" class="img-thumbnail" alt="site logo" width="120px"/>
                            <br>
                            © Copyright 2015-2016 superb.lk, All rights reserved.
                        </div>

                        <div class="col-sm-4 col-sm-4 col-xs-12" style="margin-bottom: 10px;">
                            <hr>
                            <b><u>Help & Support</u></b>
                            <br>
                            <a data-toggle="modal" data-target="#contact_support_model" href="">Contact Us</a>
<!--                            <br>
                            <a href="">FAQ</a>-->
                            <br>
                            <a href="">About Us</a>                            
                        </div>

                        <div class="col-sm-4 col-sm-4 col-xs-12" style="margin-bottom: 1px;">
                            <hr>
                            <b><u>Find Us On</u></b>
                            <br>
                            <div class="ssk-group">
                                <a href="" class="ssk ssk-facebook"></a>
                                <a href="" class="ssk ssk-twitter"></a>
                                <a href="" class="ssk ssk-google-plus"></a>
                            </div>
                        </div>

                        <!--                        <div class="col-sm-3 col-sm-3 col-xs-12" style="margin-bottom: 1px;">
                                                    <hr>
                                                    <b><u>Developers</u></b>
                                                    <br>
                                                    <img src="media/images/nextglow-transparent.png" class="img-thumbnail" alt="site logo" width="120px"/>
                                                    <br>
                                                    <a href="http://nextglow.com/">NextGlow Web Solutions</a>                            
                                                </div>-->

                    </div>


                    <hr/>
                    <a class="pull-left hidden" href="http://nextglow.com/"><span style="color: gray;">&nbsp;&nbsp;Designed and Developed by </span>Nextglow</a> 
                </div>

                <!--                <div class="pull-left" style="display: inline-block; padding-top: 5px;">
                                    <a href="http://nextglow.com/">NextGlow Designers</a>
                                </div>
                
                                <div class="pull-right" style="display: inline-block;">
                                    <a href="http://nextglow.com/"><img class="img-thumbnail" alt="NextGlow Image" src="media/images/nextglow-transparent.png" width="75px"/></a>
                                </div>-->
            </div>
        </div>
    </body>
    <script>

       

    </script>
    
    <jsp:include page="model_contact_support.jsp"></jsp:include>
</html>
