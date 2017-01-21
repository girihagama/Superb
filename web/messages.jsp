<%-- 
    Document   : messages
    Created on : Sep 16, 2015, 11:11:09 PM
    Author     : Indunil
--%>

<%
    if (session.getAttribute("login") == null) {
        response.sendRedirect("index.jsp");
    }

    String mailbox = "inbox";

    int inCurrent = 0;
    int inTotal = 0;

    int outCurrent = 0;
    int outTotal = 0;

    try {
        if (request.getParameter("inboxPage") != null) {
            mailbox = "inbox";
        } else if (request.getParameter("outboxPage") != null) {
            mailbox = "outbox";
        } else {
            mailbox = "inbox";
        }
    } catch (Exception e) {
        mailbox = "inbox";
    }

    try {

        if (mailbox.equalsIgnoreCase("inbox")) {
            inCurrent = Integer.parseInt(request.getParameter("inboxPage"));
            inTotal = Integer.parseInt(session.getAttribute("inboxPageCount").toString());

            if (inCurrent > inTotal) {
                inCurrent = inTotal;
            }

            if (inCurrent <= 0) {
                inCurrent = 1;
            }

        } else if (mailbox.equalsIgnoreCase("outbox")) {
            inCurrent = Integer.parseInt(request.getParameter("outboxPage"));
            inTotal = Integer.parseInt(session.getAttribute("outboxPageCount").toString());

            if (outCurrent > outTotal) {
                outCurrent = outTotal;
            }

            if (outCurrent <= 0) {
                outCurrent = 1;
            }

        }

    } catch (Exception e) {
        inCurrent = 1;
        //inTotal = Integer.parseInt(session.getAttribute("inboxPageCount").toString());

        outCurrent = 1;
        //inTotal = Integer.parseInt(session.getAttribute("inboxPageCount").toString());
    }


%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Messages</title>
        <jsp:include page="BootstrapHeader.jsp"></jsp:include>
            <link rel="stylesheet" href="custom_styles_scripts/chatSpeechBubbles.css"/>

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
                <div class="row-fluid">

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
                                    <a class="active2" data-toggle="tooltip" data-placement="top" title="Messages">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        Messages
                                        <span id="messagesCount" class='badge pull-right'></span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Home_savedAds" data-toggle="tooltip" data-placement="bottom" title="Go To Saved Items">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        Saved Items
                                        <span id="savedadsCount" class='badge pull-right'></span>
                                    </a>
                                </li>
                                <!--<li>
                                    <a href="inquiries.jsp" data-toggle="tooltip" data-placement="bottom" title="Go To Inquries">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        Inquiry
                                        <span id="inquiryCount" class='badge pull-right'></span>
                                    </a>
                                </li>-->
                            </ul>
                            <br>
                        </div>

                    </div><!--Navigation end-->

                    <div class="col-md-9">

                        <jsp:include page="messengerPage.jsp"></jsp:include>

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

        <jsp:include page="footer.jsp"></jsp:include> 
    </body>
</html>
