<%-- 
    Document   : footer
    Created on : Jul 10, 2015, 8:29:55 PM
    Author     : Indunil
--%>

<html>
    <head>
        <script>
            //Superb.lk brand animation
            $(document).ready(function () {
                $("#brand").mouseenter(function () {
                    $("#brand").animate({
                        opacity: '1'
                    });
                    $("#brand").css({"color": "blue"});
                });
                $("#brand").mouseleave(function () {
                    $("#brand").animate({
                        opacity: '0.5'
                    });
                    $("#brand").css({"color": "black"});
                });
            });
        </script>

        <link rel="stylesheet" type="text/css" href="custom_styles_scripts/style_responsive_textarea.css">

    </head>

    <body style="font-family: Trebuchet MS, Helvetica, sans-serif; padding: 1px;">
        <nav class="navbar navbar-default navbar-fixed-bottom" style="border-top: solid 5px #34DDDD;">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand"><div id="brand"><b>Superb.lk</b></div></a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li><a class="text-center" href="">Resolution Center <span class="sr-only">(current)</span></a></li>
                        <li><a class="text-center" data-toggle="modal" data-target="#contact_support_model" href="">Contact Support</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a data-toggle="tooltip" data-placement="top" title="Facebook" href=""><img src="media/images/social-icons_pack1/128/facebook.png" width="20" height="20" alt="Facebook"/> Facebook</a></li>
                        <li><a data-toggle="tooltip" data-placement="top" title="Google +" href=""><img src="media/images/social-icons_pack1/128/google.png" width="20" height="20" alt="Google +"/> Google +</a></li>
                        <li><a data-toggle="tooltip" data-placement="top" title="Twitter" href=""><img src="media/images/social-icons_pack1/128/twitter.png" width="20" height="20" alt="Twitter"/> Twitter</a></li>
                        <li class="active"><a class="text-right" href="http://nextglow.com/" target="_blank" data-toggle="tooltip" data-placement="top" title="Go To Designer Web Site">&COPY; NextGlow Web Designers</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
    </body>

    <jsp:include page="model_contact_support.jsp"></jsp:include>
</html>