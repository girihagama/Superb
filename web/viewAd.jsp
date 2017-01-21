<%-- 
    Document   : viewAd
    Created on : Oct 3, 2015, 7:10:08 PM
    Author     : Indunil
--%>

<%@page import="classes.User_Class"%>
<%@page import="classes.ItemView_Class"%>
<%@page import="classes.ConvertTimeStamp"%>


<%
    ItemView_Class item = new ItemView_Class();
    ConvertTimeStamp tConvert = new ConvertTimeStamp();
%>
<%//if viewer have access
    if (request.getAttribute("ViewAd") != null) {
        item = (ItemView_Class) request.getAttribute("ViewAd");

        String images = "viewImages.jsp?item=" + item.getItem_number() + "&tstamp=" + item.getTime_stamp();
%>

<%
    if (session.getAttribute("adminName") != null && item.getItem_number() == Integer.parseInt(session.getAttribute("itemNumber").toString())) {
        out.print("<div class='alert alert-danger text-center'>Admin Preview - <small>Session removed, do not refresh!</small></div>");

        //sessions expire
        session.setAttribute("adminName", null);
        session.setAttribute("itemNumber", null);
    } else {
        if (!item.getStatus().toString().equalsIgnoreCase("Active")) {
            if (session.getAttribute("login") != null) {
                String advertiser = item.getUsername();

                User_Class usr = new User_Class();

                String user = session.getAttribute("login").toString();
                String userRole = usr.requestAccountType(user);

                if (!user.equalsIgnoreCase(advertiser)) {
                    if (!userRole.equalsIgnoreCase("Admin")) {
                        response.sendRedirect("Not_Found.jsp");
                    } else {
                        out.print("<div class='alert alert-danger text-center'>Admin Privilege Preview, <small>Ths advertisment currently not showing to others except advertiser!</small></div>");
                    }
                } else {
                    out.print("<div class='alert alert-danger text-center'>Advertiser Privilege Preview, <small>Ths advertisment currently not showing to others except admins!</small></div>");
                }
            } else {
                response.sendRedirect("Not_Found.jsp");
            }
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html prefix="og: http://ogp.me/ns#">

    <%        boolean owner = false;
        int number = 0;

        try {
            if (session.getAttribute("login") != null && request.getParameter("itemNumber") != null) {
                ItemView_Class view = new ItemView_Class();

                String login = session.getAttribute("login").toString();
                number = Integer.parseInt(request.getParameter("itemNumber"));

                owner = view.checkEditAuthentication(login, number);
            }
        } catch (Exception e) {
            // error handle codes
        }
    %>

    <%
//        if (!item.getStatus().toString().equalsIgnoreCase("Active")) {
//            if (session.getAttribute("login") != null) {
//                String advertiser = item.getUsername();
//
//                User_Class usr = new User_Class();
//
//                String user = session.getAttribute("login").toString();
//                String userRole = usr.requestAccountType(user);
//
//                if (!user.equalsIgnoreCase(advertiser)) {
//                    if (!userRole.equalsIgnoreCase("Admin")) {
//                        response.sendRedirect("Not_Found.jsp");
//                    } else {
//                        out.print("<div class='alert alert-danger text-center'>Admin Privilege Preview, <small>Ths advertisment currently not showing to others except advertiser!</small></div>");
//                    }
//                } else {
//                    out.print("<div class='alert alert-danger text-center'>Advertiser Privilege Preview, <small>Ths advertisment currently not showing to others except admins!</small></div>");
//                }
//            } else {
//                response.sendRedirect("Not_Found.jsp");
//            }
//        }
    %>

    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta property="og:site_name" content="Superb.lk"/>
            <meta property="og:title" content="<%= item.getTitle()%> | Superb.lk"/>
            <meta property="og:url" content="http://superb.lk/web/ViewAd?itemNumber=<%= item.getItem_number()%>"/>
            <meta property="og:description" content="<%=item.getContent()%>"/>
            <meta property="og:image" content="http://superb.lk/web/media/item_images/<%= item.getItem_number()%>/cover.jpg"/>
            <link rel="canonical" href=http://superb.lk/web/ViewAd?itemNumber=<%= item.getItem_number()%>">
            <jsp:include page="BootstrapHeader.jsp"></jsp:include>
            <title><%= item.getTitle()%></title>

            <style>
                @media only screen and (max-width: 460px){
                    .carousel img {
                        height: 300px;
                    }
                }
            </style>
            <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>

            <!-- Social Share Kit CSS -->
            <link rel="stylesheet" href="SOCIAL SHARE KIT/dist/css/social-share-kit.css" type="text/css">
            <!-- Social Share Kit JS -->
            <script type="text/javascript" src="SOCIAL SHARE KIT/dist/js/social-share-kit.js"></script>

            <script type="text/javascript">
                $(document).ready(function () {
                    var url = window.location.href;

                    var fb = "https://www.facebook.com/sharer/sharer.php?u=" + url;
                    var twitter = "https://twitter.com/intent/tweet?url=" + url;
                    var gplus = "https://plus.google.com/share?url=" + url;

                    $("#shareF").attr("href", fb);
                    $("#shareF").attr("target", "_blank");
                    $("#shareT").attr("href", twitter);
                    $("#shareT").attr("target", "_blank");
                    $("#shareG").attr("href", gplus);
                    $("#shareG").attr("target", "_blank");

                    var user_current_state = $("#user-current-state").val();
                    setInterval(function () {
                        $.ajax({
                            type: 'POST',
                            url: 'Ajax_getChatInfo',
                            dataType: 'json',
                            data: 'member=' + user_current_state,
                            success: function (data, textStatus, jqXHR) {
                                if (data.chat === "Offline") {
                                    //alert('offline');
                                    $('#user_current_chat_state').removeClass("user-online");
                                    $('#user_current_chat_state').addClass("user-offline");
                                } else if (data.chat === "Online" && data.current === "Passive") {
                                    //alert('offline');
                                    $('#user_current_chat_state').removeClass("user-online");
                                    $('#user_current_chat_state').addClass("user-offline");
                                } else if (data.chat === "Online" && data.current === "Active") {
                                    //alert('online');
                                    $('#user_current_chat_state').removeClass("user-offline");
                                    $('#user_current_chat_state').addClass("user-online");
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {

                            }
                        });
                    }, 3000);



                    checkIsFavorite();

                    //startup check of item is saved
                    function checkIsFavorite() {
                        $.ajax({
                            type: 'POST',
                            url: "Ajax_checkLoginSessions",
                            dataType: 'json',
                            success: function (data, textStatus, jqXHR) {

                                if (data.login !== null) {
                                    var dataString = "itemNumber=" + $('#adDetail-itemNumber').val();

                                    $.ajax({
                                        type: 'POST',
                                        url: "Ajax_checkFavoriteExist",
                                        dataType: 'json',
                                        data: dataString,
                                        success: function (data, textStatus, jqXHR) {
                                            if (data.favorite_exist) {
                                                $("#favorite-alert").html("<div class='alert alert-success'><span class='glyphicon glyphicon-heart'></span> This item is saved in your favorite list.</div>");
                                                $("#toggle-favorite-button").addClass('favorite');
                                                $("#toggle-favorite-button").addClass('btn-info');
                                                $("#toggle-favorite-button").removeClass('btn-default');
                                                $("#toggle-favorite-button").html("<span class='glyphicon glyphicon-star pull-left'></span>Saved");
                                            } else {
                                                $("#favorite-alert").hide();
                                                $("#favorite-alert").html("<div class='alert alert-success'><span class='glyphicon glyphicon-heart'></span> This item is saved in your favorite list.</div>");
                                            }
                                        }
                                    });
                                }
                            }
                        });
                    }

                    //contact number modal
                    $('#call-button').click(function () {
                        $("#modal-show-contact-number").modal('show');
                    });

                    //send email modal
                    $('#email-button').click(function () {
                        $('#modal-send-email').modal('show');
                    });

                    //report ad modal
                    $('#report-button').click(function () {
                        $('#modal-report-item').modal('show');
                        $('#report-reason').val("");
                    });

                    $("#send-message-button").click(function () {
                        $.ajax({
                            type: 'POST',
                            url: "Ajax_checkLoginSessions",
                            dataType: 'json',
                            success: function (data, textStatus, jqXHR) {
                                if (data.login !== null) {
                                    var username = data.login;

                                    $('#modal-send-message').modal('show');
                                } else {
                                    $('#modal-send-message').modal('hide');

                                    var resp = $('#response-modal-content');

                                    $('#modal-show-response').modal('show');
                                    resp.text("You Must Login To Send A Message!");

                                    setTimeout(function () {
                                        $('#modal-show-response').modal('hide');
                                    }, 2000);
                                }
                            }
                        });
                    });

                    $('#form_contact_via_email').submit(function (e) {
                        e.preventDefault();

                        var sent = false;

                        var advertiser = $('#adDetail-advertiser').val();
                        var emailContent = $('#contact-via-email-sender-message').val();
                        var senderAddress = $('#contact-via-email-sender-email').val();
                        var itemNumber = $('#adDetail-itemNumber').val();

                        var dataString = "advertiser=" + advertiser + "&content=" + emailContent + "&senderAddress=" + senderAddress + "&itemNumber=" + itemNumber;

                        $('#modal-send-email').modal('hide');

                        $('#modal-show-response').modal('show');
                        $('#response-modal-content').html("Sending Message...<br><small>This may take few seconds!<small>");

                        $.ajax({
                            type: 'POST',
                            url: 'Ajax_sendEmailToAdvertiser',
                            dataType: 'json',
                            data: dataString,
                            success: function (data, textStatus, jqXHR) {
                                if (data.Sent) {
                                    sent = true;
                                } else {
                                    sent = false;
                                }
                            },
                            complete: function (jqXHR, textStatus) {
                                var resp = $('#response-modal-content');

                                if (sent) {
                                    resp.text("Message Sent!");
                                    $("#contact-via-email-reset").click();
                                } else {
                                    resp.text("Cannot Send The Message At The Moment, Please Try Again!");
                                }

                                setTimeout(function () {
                                    $('#modal-show-response').modal('hide');
                                }, 2000);
                            }
                        });
                    });

                    $("#form-report-item").submit(function (e) {
                        e.preventDefault();
                        var reported = false;

                        var itemNo = $("#adDetail-itemNumber").val();
                        var reporter_mail = $("#reporter-email-address").val();
                        var report_reason = $("#report-reason").val();
                        var reporter_message = $("#reporter-message").val();

                        var dataString = "itemNo=" + itemNo + "&reporter_email=" + reporter_mail + "&report_reason=" + report_reason + "&reporter_message=" + reporter_message;

                        $('#modal-report-item').modal('hide');

                        $('#modal-show-response').modal('show');
                        $('#response-modal-content').html("Sending Report...<br><small>This may take few seconds!<small>");

                        $.ajax({
                            type: 'POST',
                            url: "Ajax_reportItem",
                            dataType: 'json',
                            data: dataString,
                            success: function (data, textStatus, jqXHR) {
                                if (data.reported) {
                                    reported = true;
                                } else {
                                    reported = false;
                                }
                            },
                            complete: function (jqXHR, textStatus) {
                                var resp = $('#response-modal-content');

                                if (reported) {
                                    resp.text("Report Sent!");
                                    $("#form-report-item-reset").click();
                                } else {
                                    resp.text("Cannot Send The Report At The Moment, Please Try Again!");
                                }

                                setTimeout(function () {
                                    $('#modal-show-response').modal('hide');
                                }, 2000);
                            }
                        });
                    });

                    $("#form-send-message").submit(function (e) {
                        e.preventDefault();
                        var sent = false;

                        var receiver = $("#adDetail-advertiser").val();
                        var itemNumber = $("#adDetail-itemNumber").val();
                        var message = $('#send-message-message').val();

                        message += "\n---\n<a href='ViewAd?itemNumber=" + itemNumber + "' target='_blank'>View Item</a>";

                        var dataString = "receiver=" + receiver + "&message=" + message;

                        $('#modal-send-message').modal('hide');

                        $('#modal-show-response').modal('show');
                        $('#response-modal-content').html("Sending Message...<br><small>This may take few seconds!<small>");

                        $.ajax({
                            type: 'POST',
                            url: "Ajax_sendMessageToAdvertiser",
                            dataType: 'json',
                            data: dataString,
                            success: function (data, textStatus, jqXHR) {
                                if (data.sent) {
                                    sent = true;
                                } else {
                                    sent = false;
                                }
                            },
                            complete: function (jqXHR, textStatus) {
                                var resp = $('#response-modal-content');

                                if (sent) {
                                    resp.text("Message Sent!");
                                    $("#form-send-message-reset").click();
                                } else {
                                    resp.text("Cannot Send The Message At The Moment, Please Try Again!");
                                }

                                setTimeout(function () {
                                    $('#modal-show-response').modal('hide');
                                }, 2000);
                            }
                        });
                    });

                    $('#send-message-message').change(function () {
                        var message = $(this).val();
                        //modify message
                        $('#msgCleaner').html(message);
                        message = $('#msgCleaner').text();
                        $('#send-message-message').val(message);
                    });

                    $("#toggle-favorite-button").click(function () {
                        $.ajax({
                            type: 'POST',
                            url: "Ajax_checkLoginSessions",
                            dataType: 'json',
                            success: function (data, textStatus, jqXHR) {
                                if (data.login !== null) {
                                    $("#toggle-favorite-button").toggleClass('favorite');
                                    detectFavorite();
                                } else {
                                    var resp = $('#response-modal-content');

                                    resp.text("You Must Login To Mark This As Favorite!");

                                    $("#modal-show-response").modal('show');

                                    setTimeout(function () {
                                        $('#modal-show-response').modal('hide');
                                    }, 2000);
                                }
                            }
                        });
                    });

                    function detectFavorite() {
                        if ($("#toggle-favorite-button").hasClass('favorite')) {//if not favorite
                            insertFavorite();
                            $("#favorite-alert").slideDown();
                            $("#toggle-favorite-button").addClass('btn-info');
                            $("#toggle-favorite-button").removeClass('btn-default');
                            $("#toggle-favorite-button").html("<span class='glyphicon glyphicon-star pull-left'></span>Saved");
                        } else {// if saved
                            removeFavorite();
                            $("#favorite-alert").slideUp();
                            $("#toggle-favorite-button").addClass('btn-default');
                            $("#toggle-favorite-button").removeClass('btn-info');
                            $("#toggle-favorite-button").html("<span class='glyphicon glyphicon-star pull-left'></span>Mark Favorite");
                        }
                    }

                    function insertFavorite() {
                        var itemNumber = $("#adDetail-itemNumber").val();
                        var dataString = "itemNumber=" + itemNumber;

                        $.ajax({
                            type: 'POST',
                            url: "Ajax_insertFavorite",
                            dataType: 'json',
                            data: dataString
                        });
                    }

                    function removeFavorite() {
                        var itemNumber = $("#adDetail-itemNumber").val();
                        var dataString = "itemNumber=" + itemNumber;

                        $.ajax({
                            type: 'POST',
                            url: "Ajax_removeFavorite",
                            dataType: 'json',
                            data: dataString
                        });
                    }
                });
            </script>

            <style>
                .rel-ad-image{
                    display: inline-block;
                    width: auto; //200px;
                    height: 150px !important;
                    margin: 0px;
                    background-position: center center;
                    background-size: cover;
                    border-radius: 10px;                    
                }
                .rel-ad-box{
                    padding: 3px;
                    margin: 1px;
                    //border: solid 1px gray;
                    border-radius: 10px;
                    display: inline-block;
                    max-height: 200px;
                }
                .rel-ad-title{
                    max-width: fit-content;
                    text-overflow: hidden;
                    overflow:hidden;
                }
                .rel-ad-override{
                    width: fit-content;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                /*                body{
                                    margin: 0px;
                                    padding: 0px;
                
                                     Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#000000+0,f6290c+25,62e50b+54,3f078e+77,f6290c+100&amp;0.31+0,0.2+100 
                                     IE9 SVG, needs conditional override of 'filter' to 'none' 
                                    background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iIzAwMDAwMCIgc3RvcC1vcGFjaXR5PSIwLjMxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjI1JSIgc3RvcC1jb2xvcj0iI2Y2MjkwYyIgc3RvcC1vcGFjaXR5PSIwLjI4Ii8+CiAgICA8c3RvcCBvZmZzZXQ9IjU0JSIgc3RvcC1jb2xvcj0iIzYyZTUwYiIgc3RvcC1vcGFjaXR5PSIwLjI1Ii8+CiAgICA8c3RvcCBvZmZzZXQ9Ijc3JSIgc3RvcC1jb2xvcj0iIzNmMDc4ZSIgc3RvcC1vcGFjaXR5PSIwLjIzIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNmNjI5MGMiIHN0b3Atb3BhY2l0eT0iMC4yIi8+CiAgPC9saW5lYXJHcmFkaWVudD4KICA8cmVjdCB4PSIwIiB5PSIwIiB3aWR0aD0iMSIgaGVpZ2h0PSIxIiBmaWxsPSJ1cmwoI2dyYWQtdWNnZy1nZW5lcmF0ZWQpIiAvPgo8L3N2Zz4=);
                                    background: -moz-linear-gradient(top,  rgba(0,0,0,0.31) 0%, rgba(246,41,12,0.28) 25%, rgba(98,229,11,0.25) 54%, rgba(63,7,142,0.23) 77%, rgba(246,41,12,0.2) 100%);  FF3.6+ 
                                    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(0,0,0,0.31)), color-stop(25%,rgba(246,41,12,0.28)), color-stop(54%,rgba(98,229,11,0.25)), color-stop(77%,rgba(63,7,142,0.23)), color-stop(100%,rgba(246,41,12,0.2)));  Chrome,Safari4+ 
                                    background: -webkit-linear-gradient(top,  rgba(0,0,0,0.31) 0%,rgba(246,41,12,0.28) 25%,rgba(98,229,11,0.25) 54%,rgba(63,7,142,0.23) 77%,rgba(246,41,12,0.2) 100%);  Chrome10+,Safari5.1+ 
                                    background: -o-linear-gradient(top,  rgba(0,0,0,0.31) 0%,rgba(246,41,12,0.28) 25%,rgba(98,229,11,0.25) 54%,rgba(63,7,142,0.23) 77%,rgba(246,41,12,0.2) 100%);  Opera 11.10+ 
                                    background: -ms-linear-gradient(top,  rgba(0,0,0,0.31) 0%,rgba(246,41,12,0.28) 25%,rgba(98,229,11,0.25) 54%,rgba(63,7,142,0.23) 77%,rgba(246,41,12,0.2) 100%);  IE10+ 
                                    background: linear-gradient(to bottom,  rgba(0,0,0,0.31) 0%,rgba(246,41,12,0.28) 25%,rgba(98,229,11,0.25) 54%,rgba(63,7,142,0.23) 77%,rgba(246,41,12,0.2) 100%);  W3C 
                                    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#4f000000', endColorstr='#33f6290c',GradientType=0 );  IE6-8 
                
                                }*/

                .fill-div-area{
                    width: 100%;
                    -webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
                    -moz-box-sizing: border-box;    /* Firefox, other Gecko */
                    box-sizing: border-box;         /* Opera/IE 8+ */
                    resize:vertical;
                }
            </style>
        </head>

        <body class="container-fluid">

            <div class="hidden" id="msgCleaner"></div>

            <p class="hidden" id="displayTitle">My Advertisement On Superb.lk</p>
            <jsp:include page="navbar.jsp"></jsp:include>

            <%
                if (owner) {
                    out.print("<div class='col-lg-12'>");
                    out.print("<div class='alert alert-danger'><form style='display:inline-block;' method='POST' action='EditAd?itemNumber=" + number + "'><button type='submit' class='btn btn-danger'>Edit</button></form> Click the edit button to modify.</div>");
                    out.print("</div>");
                }

            %>

            <div class="col-lg-12" id="favorite-alert">           
            </div>



            <form id='ad-details' class="hidden">
                <input type="hidden" id='adDetail-advertiser' readonly="" name='adDetail-advertiser' value='<%=item.getUsername()%>'>
                <input type="hidden" id='adDetail-itemNumber' readonly="" name='adDetail-advertiser' value='<%=item.getItem_number()%>'>
            </form>

            <!--//--------------------modals------------------------//-->

            <!-- Contact Number modal -->
            <div id="modal-show-contact-number" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                <div class="modal-dialog modal-sm">      
                    <div class="modal-content">
                        <div class="modal-header">
                            Contact Advertiser
                            <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <div class="text-center" style="padding: 5px; font-weight: bold;font-size: 35px;">
                            <%= item.getContact_number()%>                
                        </div>

                    </div>
                </div>
            </div>

            <!-- Send message modal -->
            <div id="modal-send-message" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                <div class="modal-dialog modal-md">      
                    <div class="modal-content text-left">
                        <div class="modal-header" style="font-weight: bold;">
                            Send Message 
                            <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <form id='form-send-message' name="form-send-message" class="form-horizontal">

                            <div style="padding: 10px;">
                                <fieldset>

                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="textinput">Receiver: </label> 
                                        <div class="col-md-10">                                
                                            <input id="send-message-receiver" name="textinput" value="<%= item.getUsername()%>" readonly="" type="text" required="" placeholder="Receiver" class="form-control input-md disabled"/>
                                        </div>
                                    </div>

                                    <!-- Textarea -->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="textinput">Your message: </label> 
                                        <div class="col-md-10">                     
                                            <textarea required class="form-control" style="resize: vertical; max-height: 200px;" id="send-message-message" name="textarea" placeholder="Message to advertiser"></textarea>
                                        </div>
                                    </div>
                                </fieldset>                            
                            </div>

                            <div class="modal-footer">
                                <div class="btn-group">
                                    <button type="submit" class="btn btn-success">Send</button>
                                    <button type="Reset" class="btn btn-info" id="form-send-message-reset">Reset</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">Cancel</button>
                                </div>
                            </div> 
                        </form>        
                    </div>
                </div>
            </div>

            <!--//----------------end modals------------------------//-->


            <script>
                //global variables 
                var geocoder;
                var map;
                var loc = "<%= item.getCity()%>,<%= item.getDistrict()%>";// it should be 'city,district ' !

                    function initialize()
                    {
                        geocoder = new google.maps.Geocoder();
                        var latlng = new google.maps.LatLng(7.395153, 80.650635);
                        var mapOptions =
                                {
                                    zoom: 10,
                                    center: latlng,
                                    scrollwheel: false
                                }
                        map = new google.maps.Map(document.getElementById('map-superb'), mapOptions);
                        codeAddress(loc);//call the function
                    }

                    function codeAddress(address)
                    {
                        geocoder.geocode({address: address}, function (results, status)
                        {
                            if (status == google.maps.GeocoderStatus.OK)
                            {
                                map.setCenter(results[0].geometry.location);//center the map over the result
                                //place a marker at the location
                                var marker = new google.maps.Marker(
                                        {
                                            map: map,
                                            position: results[0].geometry.location
                                        });
                            } else {
                                document.getElementById("map-superb").innerHTML = "<br>&nbsp;&nbsp;Location not available on map !"
                            }
                        });
                    }

                    google.maps.event.addDomListener(window, 'load', initialize);

            </script>

            <div class="row-fluid">

                <div class="col-lg-8">

                    <div class="col-lg-12" style="font-family: Rockwell, Calibri; border-radius: 5px; padding: 5px;">
                        <h3 id='itemTitle'>
                            <%=item.getTitle()%>
                        </h3>

                        <%= new String(item.getAd_form()).toUpperCase()%> by, <div id="user_current_chat_state" class="user-online"></div> <%= new String(item.getUsername()).toUpperCase()%>
                        <input type="hidden" id="user-current-state" value="<%=item.getUsername()%>">
                    </div>

                    <div class="col-lg-12" style="padding: 5px;">
                        <jsp:include page="<%= images%>"></jsp:include>
                        </div>
                    </div>

                    <div class="col-lg-4">

                        <div class="col-lg-12">
                            <br>

                            <div class="panel panel-primary" style="font-family: calibri;">
                                <div class="panel-heading" style="font-size: large;">
                                    Item # : <%=item.getItem_number()%>
                            </div>
                            <div class="panel-body text-center" style="font-size: xx-large; color: orangered;">
                                <%
                                    if (item.getNegotiable().equalsIgnoreCase("Yes")) {
                                        out.print("Price Negotiable");
                                    } else {
                                        out.print("Rs. " + item.getPrice() + "/=");
                                    }
                                %>

                                <div class="col-lg-12">


                                    <div class="btn-group-vertical btn-block" role="group">
                                        <button type="button" id="call-button" class="btn btn-success">
                                            <span class="glyphicon glyphicon-earphone pull-left"></span>
                                            Call
                                        </button>

                                        <button type="button" id="email-button" class="btn btn-warning">
                                            <span class="glyphicon glyphicon-envelope pull-left"></span>
                                            Email
                                        </button>

                                        <button type="button" id="report-button" class="btn btn-danger">
                                            <span class="glyphicon glyphicon-ban-circle pull-left"></span>
                                            Report
                                        </button>

                                    </div>
                                </div>

                            </div>
                            <div class="panel-footer" style="font-size: medium;">

                                <b>Category :</b>
                                <%=item.getCategory_main()%> > <%=item.getCategory_sub()%>

                                <br>

                                <b>Location :</b>
                                <%=item.getDistrict()%> > <%=item.getCity()%>

                            </div>
                        </div>

                    </div>

                    <!--                    <div class="col-lg-12">
                                            <br/>
                    
                                            <div class="btn-group-vertical btn-block" role="group">
                                                <button type="button" id="call-button" class="btn btn-success">
                                                    <span class="glyphicon glyphicon-earphone pull-left"></span>
                                                    Call
                                                </button>
                    
                                                <button type="button" id="email-button" class="btn btn-warning">
                                                    <span class="glyphicon glyphicon-envelope pull-left"></span>
                                                    Email
                                                </button>
                    
                                                <button type="button" id="report-button" class="btn btn-danger">
                                                    <span class="glyphicon glyphicon-ban-circle pull-left"></span>
                                                    Report
                                                </button>
                    
                                            </div>
                                        </div>-->

                    <div class="col-lg-12">
                        <br/>

                        <div class="btn-group-vertical btn-block" role="group">
                            <button id="send-message-button" type="button" class="btn btn-default">
                                <span class="glyphicon glyphicon-comment pull-left"></span>
                                Message
                            </button>

                            <button type="button" id="toggle-favorite-button" class="btn btn-default">
                                <span class="glyphicon glyphicon-star pull-left"></span>
                                Mark Favorite
                            </button>

                        </div>
                    </div>

                </div>             

            </div>

            <div class="row-fluid">

                <div class="col-lg-8">

                    <div class="col-lg-12">

                        <hr/> 

                        <textarea id="itemDescription" class="text-left fill-div-area" readonly="" style="border-radius: 10px; padding: 5px; border: 0px; min-height: 200px; color: black; font-size: medium; width: content-box;"><%= item.getContent()%></textarea>

                        <hr/>
                    </div>

                    <!--                    <div class="col-lg-12" id="map-superb" style="height: 250px; border-radius: 10px; border: solid 1px #cccccc;">
                                            Map                    
                                        </div>-->

                </div>

                <div class="col-lg-4">
                    <br>

                    <div class="col-lg-12 ssk-block">
                        <div class="ssk-group ssk-sm ssk-count">
                            <a href="" id="shareF" class="ssk ssk-text ssk-facebook">Share On Facebook</a>
                            <a href="" id="shareT" class="ssk ssk-text ssk-twitter">Share On Twitter</a>
                            <a href="" id="shareG" class="ssk ssk-text ssk-google-plus">Share On Google</a>
                        </div>
                    </div>

                </div>

            </div>

            <div class="row-fluid">
                <div class="col-lg-12" id="map-superb" style="height: 250px; border-radius: 10px; border: solid 1px #cccccc;">
                    <!--Map-->                    
                </div>
            </div>

            <div class="row-fluid">
                <div class=" col-lg-12">
                    <br>
                    <hr/>                
                    <!--Related ads-->

                    <script>
                        $(document).ready(function () {
                            var cur_item_no = <%= item.getItem_number()%>;

                            var dataString = "title=<%= item.getTitle()%>&main_cat=<%= item.getCategory_main()%>&district=<%= item.getDistrict()%>";
                            $.ajax({
                                type: 'POST',
                                url: "Ajax_getRelatedAds",
                                dataType: 'json',
                                data: dataString,
                                success: function (data, textStatus, jqXHR) {
                                    var relAds = data.relatedAds;
                                    var relAdsArea = $('#related_ads_area');
                                    relAdsArea.html("");

                                    if (relAds.length < 1) {
                                        relAdsArea.html("<center><h3>No related ads!</h3></center>");
                                    } else {
                                        relAdsArea.html("<center><h3>Related ads!</h3></center>");
                                    }

                                    var simAds = 6; //relAds.length;

                                    for (var x = 0; x < simAds; x++) {
                                        var itemNo = relAds[x][0];
                                        var title = relAds[x][1];
                                        var price = relAds[x][3];
                                        var adForm = relAds[x][2];
                                        var timeStamp = relAds[x][4];
                                        var col = "";

                                        if (itemNo != cur_item_no) {
                                            var adLink = "ViewAd?itemNumber=" + itemNo;
                                            var img = "media/item_images/" + itemNo + "/cover.jpg?tstamp=" + timeStamp;
                                            col += "<a href='" + adLink + "' title = 'Click to view the Ad'><div class='col text-left' style='display: inline-block;padding: 0px 5px 0px 5px; font-size:smaller;'>";
                                            col += "<img src='" + img + "' alt='Item Image' class='img-responsive img-thumbnail rel-ad-image' style='margin-bottom:5px;' width='225'/>";
                                            col += "<div class = 'caption topadCaption rel-ad-override' style='max-width: 150px;'>" + title + "</div>"
                                            //col+= "[Item #: " + itemNo + "]<br>";
                                            if (price > 0) { //if item is not negotiable
                                                col += "<b>" + "Rs." + price + "</b>";
                                                col += "<br>";
                                            }
                                            col += "<b>" + adForm + "</b>";
                                            col += "</div></a>";
                                            relAdsArea.append(col);
                                        }
                                    }

                                    if (relAds.length == 1 && relAds[0][0] == cur_item_no) {
                                        relAdsArea.html("<center><h3>No related ads!</h3></center>");
                                    }
                                }
                            });

                        });
                    </script>

                    <center>
                        <div id="related_ads_area" style="background-color:rgba(0, 0, 0, 0.1); border-radius: 10px;">

                            <!--<div class="col rel-ad-box">
                                <img src="" alt="rel-ad" class="img-responsive img-rounded" width="100" height="100">
                                <div class="rel-ad-title"></div>
                            </div>-->
                        </div>
                    </center>

                    <hr/>
                </div>            
            </div>

            <div class="row-fluid">
                <div class="col-lg-12">
                    <br class="hidden-md">
                    <br class="hidden-md">
                    <br class="hidden-md">
                </div>
            </div>

            <jsp:include page="footer.jsp"></jsp:include>

            <%//if viewer not have access
            } else {
                response.sendRedirect("Not_Found.jsp");
            %>
            <jsp:include page="footer_nav.jsp"></jsp:include>

            <%//if viewer not have access end
                }
            %>

            <!-- Contact via email modal -->
            <div id="modal-send-email" class="modal fade bs-example-modal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content text-left">
                        <div class="modal-header" style="font-weight: bold;">
                            Send an e-mail to advertiser  
                            <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <form id='form_contact_via_email' name="contact-via-email" class="form-horizontal">

                            <div style="padding: 10px;">
                                <fieldset>

                                    <!-- Email input-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="textinput">Your email: </label> 
                                        <div class="col-md-10">                                
                                            <input id="contact-via-email-sender-email" name="senderemail" type="email" required="" placeholder="Enter your email address here" class="form-control input-md">
                                        </div>
                                    </div>

                                    <!-- Textarea -->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="textinput">Your message to seller: </label> 
                                        <div class="col-md-10">                     
                                            <textarea required class="form-control" style="resize: vertical; max-height: 200px;" id="contact-via-email-sender-message" name="textarea" placeholder="Message to advertiser"></textarea>
                                        </div>
                                    </div>
                                </fieldset>

                                * We'll send this message (with provided email address) to the advertiser's email address. Advertiser may contact you via email.
                            </div>

                            <div class="modal-footer">
                                <div class="btn-group">
                                    <button type="submit" class="btn btn-warning">Send</button>
                                    <button type="Reset" id="contact-via-email-reset" class="btn btn-info">Reset</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">Cancel</button>
                                </div>
                            </div> 
                        </form>        
                    </div>
                </div>
            </div>

            <!-- Report item modal -->
            <div id="modal-report-item" class="modal fade bs-example-modal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content text-left">
                        <div class="modal-header" style="font-weight: bold;">
                            Report Item  
                            <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <form id='form-report-item' name="contact-via-email" class="form-horizontal" method="POST" action="">

                            <div style="padding: 10px;">
                                <fieldset>

                                    <!-- Email input-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="textinput">Your email: </label> 
                                        <div class="col-md-10">                                
                                            <input id="reporter-email-address" name="textinput" type="email" required="" placeholder="Enter your email address here" class="form-control input-md">
                                        </div>
                                    </div>

                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="textinput">Report Reason: </label> 
                                        <div class="col-md-10">                              
                                            <select id="report-reason" required="" name="report_reason" class="form-control">
                                                <option value="" selected>--Select Reason--</option>
                                                <option value="Item Sold / Unavailable" selected>Item Sold / Unavailable</option>
                                                <option value="Fraud">Fraud</option>
                                                <option value="Duplicate">Duplicate</option>
                                                <option value="Spam">Spam</option>
                                                <option value="Wrond Category">Wrong Category</option>
                                                <option value="Wrong Location">Wrong Location</option>
                                                <option value="Offensive">Offensive</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- Textarea -->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="textinput">Your message: </label> 
                                        <div class="col-md-10">                     
                                            <textarea id='reporter-message' required class="form-control" style="resize: vertical; max-height: 200px;" id="textarea" name="textarea" placeholder="Describe the reason to report"></textarea>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>

                            <div class="modal-footer">
                                <div class="btn-group">
                                    <button type="submit" class="btn btn-danger">Report</button>
                                    <!--<button type="Reset" id="form-report-item-reset" class="btn btn-info">Reset</button>-->
                                    <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">Cancel</button>
                                </div>
                            </div> 
                        </form>        
                    </div>
                </div>
            </div>

            <!-- Contact Response modal -->
            <div id="modal-show-response" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                <div class="modal-dialog modal-sm">      
                    <div class="modal-content">
                        <div class="modal-header">
                            Superb.lk
                            <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <div id='response-modal-content' class="text-center" style="padding: 5px; font-weight: bold;">

                        </div>
                    </div>
                </div>
            </div>

        </body>
        <jsp:include page="model_adsubmission.jsp"></jsp:include>
        <%if (session.getAttribute("submission") == "true") {
                session.setAttribute("submission", null);
        %>
        <script>
            $(window).load(function () {
                $('#adSubmission_model').modal('show');
            });
        </script>
        <%
            }
        %>
    </html>