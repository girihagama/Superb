<%-- 
    Document   : inquiries
    Created on : Sep 17, 2015, 12:34:37 PM
    Author     : Indunil
--%>

<%
    if(session.getAttribute("login")== null){
        response.sendRedirect("index.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="meta_tags.jsp"></jsp:include>
        <jsp:include page="BootstrapHeader.jsp"></jsp:include>
        
                    <script>
                $(document).ready(function () {
                    updateNavigation();


                    setInterval(function () {
                        updateNavigation();
                    }, 3000);
                });

                function updateNavigation() {
                    //window.alert("update");

                    $.ajax({
                        type: "POST",
                        url: "Ajax_navbarCountsUpdate",
                        dataType: "json",
                        //if received a response from the server
                        success: function (data) {
                            if (data.updated) {
                                //window.alert("Updated");
                                if (data.savedAdsCount > 0) {
                                    $("#savedadsCount").html(data.savedAdsCount);
                                } else {
                                    $("#savedadsCount").html("");
                                }

                                if (data.inquriesCount > 0) {
                                    $("#inquiryCount").html(data.inquriesCount);
                                }
                                else {
                                    $("#inquiryCount").html("");
                                }

                                if (data.msgCount > 0) {
                                    $("#messagesCount").html(data.msgCount);
                                } else {
                                    $("#messagesCount").html("");
                                }
                            }
                        },
                    });
                }
            </script>
        
        </head>

        <body class="container-fluid">

        <jsp:include page="navbar.jsp"></jsp:include>

            <div class="container-fluid">
                <div class="row">

                    <div class="col-md-3"><!--Navigation-->

                        <div class="col-md-12 column text-left">
                            <ul class="nav nav-pills nav-stacked">
                                <li class="active">
                                    <a href="Home_myAds" data-toggle="tooltip" data-placement="top" title="Go To My Account">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        My Account
                                    </a>
                                </li>
                                <li>
                                    <a href="Home_messages" data-toggle="tooltip" data-placement="top" title="Go To Messages">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        Messages
                                        <span id="messagesCount" class='badge pull-right'></span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Home_savedAds" data-toggle="tooltip" data-placement="top" title="Go To Saved Items">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        Saved Items
                                        <span id="savedadsCount" class='badge pull-right'></span>
                                    </a>
                                </li>
                                <li>
                                    <a class="active2" data-toggle="tooltip" data-placement="top" title="Inquiries">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        Inquiry
                                        <span id="inquiryCount" class='badge pull-right'></span>
                                    </a>
                                </li>
                            </ul>
                            <br>
                        </div>

                    </div><!--Navigation end-->

                    <div class="col-md-9">

                        <div class="tabbable-panel">

                            <div class="tabbable-line">

                                <ul class="nav nav-tabs full-width">

                                    <li class="active">
                                        <a href="#tab_default_1" data-toggle="tab">
                                            Received</a>
                                    </li>

                                    <li>
                                        <a href="#tab_default_2" data-toggle="tab">
                                            Sent</a>
                                    </li>

                                </ul>

                                <div class="tab-content text-left">

                                    <div class="tab-pane active" id="tab_default_1">
                                        <blockquote class="offer offer-warning">

                                            <div class="offer-content col-md-7">
                                                First Inquiry Message
                                                <hr>

                                                <fieldset>
                                                    <!-- Text input-->
                                                    <div class="form-group">                                                        
                                                        <div class="col-md-10">
                                                            <input id="reply" name="reply" type="text" placeholder="Enter Reply" class="form-control input-md" required="">
                                                        </div>
                                                        <div class="col-md-2">
                                                            <br class="hidden-lg hidden-md">
                                                            <button class="btn btn-info btn-sm hidden-sm hidden-xs">Reply</button>
                                                            <button class="btn btn-info btn-sm btn-block hidden-lg hidden-md">Reply</button>
                                                        </div>
                                                    </div>
                                                </fieldset>

                                            </div>

                                            <div class="col-md-3 text-left">
                                                <small>From: <div class="user-online"></div> ADMIN</small>
                                                <small>Date: 2015/09/10</small>
                                                <small>Inquiry#: 3121323</small>
                                            </div>

                                            <div class="col-md-2">
                                                <br class="hidden-lg hidden-md">

                                                <div class="btn-group-vertical btn-block" role="group">
                                                    <button type="button" class="btn btn-warning">Report</button>
                                                    <button type="button" class="btn btn-danger">Delete</button>
                                                </div>
                                            </div>
                                        </blockquote>

                                    </div>

                                    <div class="tab-pane" id="tab_default_2">

                                        <blockquote class="offer offer-warning">
                                            <div class="offer-content">
                                                Machan meka full set da?                                             
                                            </div>

                                            <small class="text-right">From: Indunil</small>
                                            <small class="text-right">Date: 2015/09/10</small>
                                            <hr>

                                            <div class="btn-group btn-group-sm pull-right">
                                                <button type="button" class="btn btn-info">View</button>
                                                <button type="button" class="btn btn-danger">Delete</button>
                                            </div>
                                        </blockquote>

                                        <blockquote class="offer offer-warning">
                                            <div class="offer-content">
                                                Last Price kiyada?                                            
                                            </div>

                                            <small class="text-right">From: Dewmin</small>
                                            <small class="text-right">Date: 2015/09/10</small>
                                            <hr>

                                            <div class="btn-group btn-group-sm pull-right">
                                                <button type="button" class="btn btn-info">View</button>
                                                <button type="button" class="btn btn-danger">Delete</button>
                                            </div>
                                        </blockquote>

                                    </div>

                                </div>

                            </div>

                        </div>

                        <div class="row"><!--Footer correction-->
                            <div class="col-md-12">
                                <br>
                                <br>
                                <hr>
                            </div>
                        </div><!--Footer correction end-->

                    </div>

                </div>
            </div>

        <jsp:include page="footer_nav.jsp"></jsp:include>

    </body>

</html>
