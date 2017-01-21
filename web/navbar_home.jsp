<%-- 
    Document   : navbar
    Created on : Jul 8, 2015, 8:03:31 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    if (session.getAttribute("login") == null) {
        response.sendRedirect("index.jsp");
    }
%>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%--<jsp:include page="BootstrapHeader.jsp"></jsp:include>--%>
        <link rel="stylesheet" type="text/css" href="menubar/bootstrap.min.css">

        <!--jquery ajax to update user messages, ads, saved items, inquiries-->
        <script type="text/javascript">
            $(document).ready(function () {
                updateNavbar();

                setInterval(function () {
                    updateNavbar();
                }, 5000);

                $("#offlineButton").click(function () {
                    //alert("offline");
                    $.ajax({
                        type: "POST",
                        url: "Ajax_toggleChatState?setChat=offline",
                        dataType: "json",
                        //if received a response from the server
                        success: function (data) {
                            if (data.updated) {
                                updateNavbar();
                                //location.reload();
                            }
                        },
                    });

                });

                $("#onlineButton").click(function () {
                    //alert("online");
                    $.ajax({
                        type: "POST",
                        url: "Ajax_toggleChatState?setChat=online",
                        dataType: "json",
                        //if received a response from the server
                        success: function (data) {
                            if (data.updated) {
                                updateNavbar();
                                //location.reload();
                            }
                        },
                    });
                });
            });


            function updateNavbar() {
                //window.alert("Updated");
                $.ajax({
                    type: "POST",
                    url: "Ajax_navbarCountsUpdate",
                    dataType: "json",
                    //if received a response from the server
                    success: function (data) {
                        if (data.updated) {
                            //window.alert("Updated");

                            if (data.itemsCount > 0) {
                                $("#myAdsCount").html(data.itemsCount);
                            } else {
                                $("#myAdsCount").html("");
                            }

                            if (data.savedAdsCount > 0) {
                                $("#savedAdsCount").html(data.savedAdsCount);
                            } else {
                                $("#savedAdsCount").html("");
                            }

                            if (data.inquriesCount > 0) {
                                $("#inquiriesCount").html(data.inquriesCount);
                            }
                            else {
                                $("#inquiriesCount").html("");
                            }

                            if (data.msgCount > 0) {
                                $("#msgCount").html(data.msgCount);
                            } else {
                                $("#msgCount").html("");
                            }

                            if (data.chat === "Online") {
                                $("#offlineButton").removeClass("active");
                                $("#offline").removeClass("glyphicon");
                                $("#offline").removeClass("glyphicon-chevron-right");
                                $("#onlineButton").addClass("active");
                                $("#online").addClass("glyphicon");
                                $("#online").addClass("glyphicon-chevron-right");
                            } else if (data.chat === "Offline") {
                                $("#onlineButton").removeClass("active");
                                $("#online").removeClass("glyphicon");
                                $("#online").removeClass("glyphicon-chevron-right");
                                $("#offlineButton").addClass("active");
                                $("#offline").addClass("glyphicon");
                                $("#offline").addClass("glyphicon-chevron-right");
                            } else {

                            }
                        } else {
                            //window.alert("Not Updated");
                        }
                    }
                });
            }
        </script>
        
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
    <body style="font-family: Trebuchet MS, Helvetica, sans-serif; padding: 1px;" class="navbar-fixed-top container-fluid">

        <div class="navbar navbar-custom">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" style="font-weight: bold;" href="index.jsp">
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
                        <a href="Home_messages">
                            <span class="glyphicon glyphicon-comment"> </span>
                            Messages
                            <span id="msgCount" class="badge" style="color: black; background-color: gold; border: solid 2px gray;"></span>
                        </a>
                    </li>
                    <li class="dropdown text-center">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            <span class="glyphicon glyphicon-user"></span> My Account
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">                            
                            <li>
                                <a href="Home_myAds">
                                    <span id="myAdsCount" class="badge"></span>
                                    My Ads
                                </a>
                            </li>

                            <br>

                            <li>
                                <a href="Home_savedAds">
                                    <span id="savedAdsCount" class="badge"></span>
                                    Saved Ads
                                </a>
                            </li>

                            <br>

                            <!--<li>
                                <a href="#">                                    
                                    <span id="inquiriesCount" class="badge"></span>
                                    Inquiries
                                </a>
                            </li>-->

                            <li class="divider"></li>

                            <li>

                                <div class="btn-group btn-group-justified" role="group">
                                    <div class="btn-group" role="group">
                                        <button id="onlineButton" type="button" class=" btn btn-success btn-block" style="border-radius: 0px;" data-toggle="tooltip" data-placement="top" title="Show Me As Online!">
                                            <span id="online" class=""></span>
                                            Online
                                        </button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button id="offlineButton" type="button" class="btn btn-danger btn-block" style="border-radius: 0px;" data-toggle="tooltip" data-placement="top" title="Show Me As Offline!">
                                            <span id="offline" class=""></span>
                                            Offline
                                        </button>
                                    </div>
                                </div>                                
                            </li>

                            <br>

                            <li><a href="EditProfile">View & Edit Profile</a></li>
                            <br>
                            <li><a href="ClearAll"><b>Log Out</b></a></li>

                        </ul>
                    </li> 
                </ul>
            </div><!-- /.navbar-collapse -->
        </div>
    </body>    
</html>