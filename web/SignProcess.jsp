<%-- 
    Document   : SignProcess
    Created on : Feb 29, 2016, 6:34:26 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    boolean currentLogin = false;
    if (session.getAttribute("login") != null) {
        currentLogin = true;
    }
%>

<html>
    <head>
        <jsp:include page="meta_tags.jsp"></jsp:include>

        <jsp:include page="BootstrapHeader.jsp"></jsp:include>

            <style>

                body {
                    overflow-x: hidden;
                }
                .modal-title {
                        text-align: center;
                }
                .custom-alert{
                    font-size: medium;
                }

                .fancy-design{
                    padding: 10px;
                    text-align: center;
                    font-size: 30px;
                    //background-image: url('media/backgrounds/green-wallpapers.png');

                }

                .box-sign-up{
                    color: white;
                    border-radius: 20px;
                    padding: 20px;
                    background-image: linear-gradient(to bottom, #00aaff 0%, #0088cc 100%);


                }
                .box-sign-up:hover{
                    color: black;
                    cursor: pointer;
                }
                .box-sign-in{
                    color: white;
                    border-radius: 20px;
                    padding: 20px;
                    background-image: linear-gradient(to bottom, #00aaff 0%, #0088cc 100%);

                }
                .box-sign-in:hover{
                    color: black;
                    cursor: pointer;
                }
                @media only screen and (max-width: 350px){
                    .fancy-design {
                        font-size: 20px;
                    }
                }
            </style>
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


            <script>
                $(document).ready(function () {
                    $('#sign-in-button').click(function () {
                        $('#open-sign-in-model').click();
                    });
                    $('#sign-up-button').click(function () {
                        $('#open-sign-up-model').click();
                    });


                });
            </script>

            <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
            <link href='http://fonts.googleapis.com/css?family=Shadows+Into+Light' rel='stylesheet' type='text/css'>
        </head>
        <body id='body' class="">  
            <div style="font-family: Trebuchet MS, Helvetica, sans-serif; padding: 1px;" class="text-center container-fluid">
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

                        <form class="navbar-form navbar-left center-block" method="GET" action="Search" role="search">
                            <div class="form-group">
                                <input name="searchTerm" class="form-control" placeholder="I'm looking for" type="text" value="<%if (request.getParameter("searchTerm") != null) {%><%=request.getParameter("searchTerm")%><%}%>" required="">
                        </div>
                        <button type="submit" class="btn btn-info" style="border: solid 2px gray;">Search</button>
                    </form>                


                </div><!-- /.navbar-collapse -->
            </div>

        </div>
        <%
            if (currentLogin) {
                out.print("<div class='alert alert-success custom-alert'><strong>Success!</strong> You are now logged-in.</div>");
            } else {
                out.print("<div class='alert alert-danger custom-alert'><strong>Require Login!</strong> No user currently logged.</div>");
            }
        %>

        <div class="row fancy-design">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h2>
                    Welcome to Superb.lk 
                    <br>
                    <small>Superb Classifieds In Sri Lanka</small>
                </h2>
                <hr>                
            </div>



            <div id='sign-up-button' class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                <div class="box-sign-up">
                    Sign-up
                </div>
            </div>

            <div id='sign-in-button' class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                <div class="box-sign-in">
                    Log-in                    
                </div>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="font-size: 20px;text-align: left;">
                <hr>
                <small>Login is required to post an advertisement. This window will be closed automatically after login completed. If not close this, if you see the 'Success!' message at the top..</small>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include> 
        </body>    
    </html>

<jsp:include page="model_login.jsp"></jsp:include>
    <a id='open-sign-in-model' class="hidden" data-toggle="modal" data-target="#login_model" href=""></a>

<jsp:include page="model_signup.jsp"></jsp:include>
<a id='open-sign-up-model' class="hidden" data-toggle="modal" data-target="#signup_model" href=""></a>