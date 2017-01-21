<%-- 
    Document   : model_welcome
    Created on : Jan 22, 2016, 10:23:40 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to Superb.lk</title>
        
        <style>
            .close.pull-right:hover{
                opacity: 1;
            }
        </style>

        <script>
            $(document).ready(function () {
                $("#welcome_model").modal('toggle');

                /*
                 $("#welcome_model_close_btn").hide();
                 
                 $("#welcome_model_body").hover(function () {
                 $("#welcome_model_close_btn").show(100);
                 }, function () {
                 $("#welcome_model_close_btn").hide(100);
                 });
                 */
            })
        </script>


    </head>
    <body>

        <!-- Button trigger modal
        <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#welcome_model">
            Launch modal
        </button>
        -->

        <div class="modal fade" id="welcome_model" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!--
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Welcome!</h4>
                    </div>
                    -->

                    <div class="modal-body" id="welcome_model_body" style="background-image:url('media/backgrounds/green-wallpapers.png'); color: white;">

                        <button id="welcome_model_close_btn" style="color: white;" type="button" class="close pull-right" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>

                        <div>
                            <center>
                                <img class="img-responsive" src="media/images/welcome.png" alt="Welcome Image!"/>

                                <h2>Thank You For Visiting Superb.lk!</h2>

                                <small>
                                    You Are Warmly Welcome,
                                    It's Your First Visit To Our Web Site..
                                </small>
                            </center>   
                        </div>
                    </div>

                    <div class="clearfix">
                        <button type="button" style="border-radius: 0px; color: black; font-weight: bold;" class="btn btn-sm btn-warning btn-block" data-dismiss="modal">Dismiss!</button>
                    </div>

                    <!--
                    <div class="modal-footer">
                        <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
                    </div>
                    -->

                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

    </body>
</html>
