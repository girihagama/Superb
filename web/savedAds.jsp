<%-- 
    Document   : savedAds
    Created on : Sep 17, 2015, 11:24:01 AM
    Author     : Indunil
--%>

<%@page import="java.util.List"%>
<%@page import="classes.ConvertTimeStamp"%>
<%@page import="classes.FavoriteView_Class"%>

<%
    if (session.getAttribute("login") == null) {
        response.sendRedirect("index.jsp");
    }

    int current;
    int total = 0;

    try {
        current = Integer.parseInt(request.getParameter("page"));
        total = Integer.parseInt(session.getAttribute("favoritePageCount").toString());

        if (current > total) {
            current = total;
        }

        if (current <= 0) {
            current = 1;
        }
    } catch (Exception e) {
        current = 1;
        total = Integer.parseInt(session.getAttribute("favoritePageCount").toString());

    }

    FavoriteView_Class items = new FavoriteView_Class();
    ConvertTimeStamp tConvert = new ConvertTimeStamp();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Saved Ads</title>
        <meta name="description" content="Buy and sell everything from Superb.lk. Did you know that Superb.lk has the best mobile deals in Sri Lanka? Visit Superb.lk and Search all of Sri Lanka.">
        <meta property="og:url" content="http://superb.lk/web">
        <meta property="og:site_name" content="Superb.lk">
        <meta property="og:title" content="Superb.lk - Saved Ads">
        <meta property="og:description" content="Buy and sell everything from Superb.lk. Did you know that Superb.lk has the best mobile deals in Sri Lanka? Visit Superb.lk and Search all of Sri Lanka.">
        <meta property="og:image" content="http://superb.lk/ng-admin/images/facebook-opengraph.png"/>

        <jsp:include page="BootstrapHeader.jsp"></jsp:include>

            <script src='custom_styles_scripts/zoom.min.js'></script>
            <link rel="stylesheet" href="custom_styles_scripts/zoom_style.css"/>

            <script>
                $(document).ready(function () {
                    updateNavigation();
                    updateUserCurrentStatus();

                    setInterval(function () {
                        updateNavigation();
                    }, 3000);

                    setInterval(function () {
                        updateUserCurrentStatus();
                    }, 2000);

                    $(".btnSendMessage").click(function () {
                        var advertiser = $(this).next().val();
                        var itemNumber = $(this).next().next().val();

                        $.ajax({
                            type: 'POST',
                            url: "Ajax_checkLoginSessions",
                            dataType: 'json',
                            success: function (data, textStatus, jqXHR) {
                                if (data.login !== null) {
                                    var username = data.login;
                                    $('#send-message-receiver').val(advertiser);

                                    $('#send-message-username').val(advertiser);
                                    $('#send-message-itemno').val(itemNumber);

                                    if (!(advertiser.toUpperCase() === username.toUpperCase())) {
                                        $('#modal-send-message').modal('show');
                                    } else {
                                        var resp = $('#response-modal-content');

                                        $('#modal-show-response').modal('show');
                                        resp.text("Oops! You cannot send message to your own item.");

                                        setTimeout(function () {
                                            $('#modal-show-response').modal('hide');
                                        }, 2000);
                                    }
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

                    $('#send-message-message').change(function () {
                        var message = $(this).val();
                        //modify message
                        $('#msgCleaner').html(message);
                        message = $('#msgCleaner').text();
                        $('#send-message-message').val(message);
                    });

                    $("#form-send-message").submit(function (e) {
                        e.preventDefault();
                        var sent = false;

                        var receiver = $('#send-message-username').val();
                        var message = $('#send-message-message').val();
                        var itemNumber = $('#send-message-itemno').val();

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
                                    $('#send-message-message').val("");
                                } else {
                                    resp.text("Cannot Send The Message At The Moment, Please Try Again!");
                                }

                                setTimeout(function () {
                                    $('#modal-show-response').modal('hide');
                                }, 2000);
                            }
                        });
                    });

                    $('.btnDeleteFavorite').click(function () {
                        var itemNumber = $(this).next().val();

                        if (confirm("Are You Sure?")) {
                            var dataString = "itemNumber=" + itemNumber;

                            $.ajax({
                                type: 'POST',
                                url: "Ajax_removeFavorite",
                                dataType: 'json',
                                data: dataString,
                                success: function (data, textStatus, jqXHR) {
                                    location.reload();
                                }
                            });
                        }
                    });
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
                        }
                    });
                }

                function updateUserCurrentStatus() {
                    var id = 0;

                    $(".itemMain").each(function (index, element) {
                        var name = $(".itemMain").find("#seller" + id).val();
                        var chat = $(".itemMain").find("#chat" + id).valueOf();
                        //alert(name);
                        var dataString = "member=" + name;

                        //alert(dataString);

                        $.ajax({
                            type: "POST",
                            url: "Ajax_getChatInfo",
                            data: dataString,
                            dataType: "json",
                            success: function (data) {
                                //alert("Ok");
                                var status = data.chat;
                                var idString = id.toString();

                                if (data.chat === "Online" && data.current === "Active") {
                                    //alert("Online");

                                    chat.removeClass("user-offline");
                                    chat.addClass("user-online");
                                    chat.attr("title", "Online");
                                } else {
                                    chat.removeClass("user-online");
                                    chat.addClass("user-offline");
                                    chat.attr("title", "Offline");
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                //alert("Failed");
                                chat.removeClass("user-offline");
                                chat.removeClass("user-online");
                                chat.attr("title", "");
                            }
                        });

                        id++;
                    });
                }
            </script>

        </head>

        <body class="container-fluid">

            <div class="hidden" id="msgCleaner"></div>

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
                                    <a class="active2" data-toggle="tooltip" data-placement="top" title="Saved Items">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        Saved Items
                                        <span id="savedadsCount" class='badge pull-right'></span>
                                    </a>
                                </li>
                                <!--<li>
                                    <a href="inquiries.jsp" data-toggle="tooltip" data-placement="bottom" title="Go To Inquiries">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        Inquiry
                                        <span id="inquiryCount" class='badge pull-right'></span>
                                    </a>
                                </li>-->
                            </ul>
                            <br>
                        </div>

                    </div><!--Navigation end-->

                    <div class="col-md-9"><!--Page content-->

                    <%
                        try {
                            if ((session.getAttribute("favorites").toString()).equalsIgnoreCase("yes")) {
                                List myList = (List) session.getAttribute("favorite" + Integer.toString(current));

                                //out.println("Current Page:" + current);
                                //out.println("<br>Total Pages:" + total);
                                //out.println("<br>Page Items:" + myList.size());
                                //items
                                for (int i = 0; i < myList.size(); i++) {
                                    //out.print("<br>"+i);

                                    items = (FavoriteView_Class) myList.get(i);

                    %>

                    <script type="text/javascript">
                        $(document).ready(function () {
                            //image zoom
                            $('#ex<%=i + 1%>').zoom();

                            var itemNumber = $("#itemNumber" +<%=i%>).val();
                            var recordId = $("#recordId" +<%=i%>).val();
                            var sellerName = $("#seller" +<%=i%>).val();

                            $("#formPart<%=i%>").click(function () {
                                //window.location = "ViewAd?itemNumber=" + itemNumber;
                            });

                            $("#view<%=i%>").click(function () {
                                //alert("view" + itemNumber);
                                window.location = "ViewAd?itemNumber=" + itemNumber;
                            });
                        });
                    </script>

                    <input type="hidden" id="send-message-username" value="" disabled="disabled" />
                    <input type="hidden" id="send-message-itemno" value="" disabled="disabled" />

                    <form method="POST" action="" id="item<%=items.getItem_number()%>">
                        <div class="col-md-12 offer offer-info itemMain"><!--Item-->

                            <input type="hidden" id="recordId<%=i%>" name="recordId" value="<%= items.getRecord_id()%>"/>
                            <input type="hidden" id="itemNumber<%=i%>" name="itemNumber" value="<%= items.getItem_number()%>"/>
                            <input type="hidden" id="seller<%=i%>" name="sellerName" value="<%= items.getSeller()%>"/>

                            <div id="formPart<%=i%>"><!--div for redirect to item view by jquery-->
                                <div class="col-md-3" style="border-radius: 5px;">
                                    <div class="caption text-center">
                                        <br>

                                        <span class='zoom' id='ex<%=i + 1%>'>
                                            <img src="media/item_images/<%= items.getItem_number()%>/cover.jpg" height="200" width="200" class="img-responsive img-thumbnail" alt="Item Image" />
                                        </span>

                                        <br>
                                    </div>
                                </div>

                                <div class="col-md-9 text-left" style="padding: 5px;">
                                    <h4>
                                        <b><%= items.getTitle()%></b>
                                    </h4>
                                    <small><b>Category : </b><%= items.getCategory_main()%> > <%=items.getCategory_sub()%></small>
                                    <br>
                                    <small><b>Location : </b><%= items.getDistrict()%> > <%=items.getCity()%></small>

                                    <br>
                                    <br>
                                    <b>Item No. : </b><%= items.getItem_number()%>

                                    <br>
                                    <%
                                        if (items.getAd_form().equalsIgnoreCase("for sale")) {
                                            out.print("<b>Item is : </b><span style='letter-spacing:1px;' class='label label-primary'>For Sale</span>");
                                        } else if (items.getAd_form().equalsIgnoreCase("for rent")) {
                                            out.print("<b>Item is : </b><span style='letter-spacing:1px;' class='label label-primary'>For Rent</span>");
                                        } else if (items.getAd_form().equalsIgnoreCase("wanted")) {
                                            out.print("<b>Item is : </b><span style='letter-spacing:1px;' class='label label-primary'>Wanted</span>");
                                        }
                                    %>
                                    <br>
                                    <br>

                                    Listed on : <%= tConvert.timeStampIn12h(items.getTime_stamp())%>
                                    <br>

                                    Seller :
                                    <div id="chat<%=i%>" data-toggle="tooltip" data-placement="top" title="" style="display: inline-block;"></div><%= items.getSeller()%>
                                    <br>

                                    Views : <%= items.getView_count()%>                                       
                                    <br>

                                    <%//if negotiable
                                        if (items.getNegotiable().equalsIgnoreCase("Yes")) {
                                    %>

                                    Price : Negotiable

                                    <%
                                    } else {
                                    %>

                                    Price : <%= items.getPrice()%>/=

                                    <%
                                        }
                                    %>
                                </div>
                            </div><!--div for redirect to item view by jquery end-->

                            <div class="col-md-12">
                                <hr>
                                <div class="btn-group btn-group-justified" role="group">
                                    <div class="btn-group btn-group-sm" role="group">
                                        <button type="button" id="view<%=i%>" class="btn btn-info">View</button>
                                    </div>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <button type="button" id="message<%=i%>" class="btn btn-success btnSendMessage">Message</button>
                                        <input type="hidden" value="<%=items.getSeller()%>"/>
                                        <input type="hidden" value="<%=items.getItem_number()%>"/>
                                    </div>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <button type="button" id="remove<%=i%>" class="btn btn-danger btnDeleteFavorite">Remove</button>
                                        <input type="hidden" value="<%=items.getItem_number()%>"/>
                                    </div>
                                </div>
                                <hr>
                            </div>

                        </div><!--Item end-->
                    </form>

                    <%//end of for loop
                        }
                    %>

                    <div class="col-md-12 text-center"><!--pagination-->
                        <nav>
                            <ul class="pager">
                                <%  //pagination                                          
                                    int totalPages = total;

                                    if (current - 1 <= 0) {
                                        //out.print("<li class='disabled'><a>Previous</a></li>");
                                    } else {
                                        out.print("<li><a class='pull-left' href='?page=" + (current - 1) + "'>Previous</a></li>");
                                    }

                                    if (totalPages != 1) {
                                        out.print("<li><a>Page " + current + "</a></li>");
                                    }

                                    if (current + 1 > total) {
                                        //out.print("<li class='disabled'><a>Next</a></li>");
                                    } else {
                                        out.print("<li><a class='pull-right' href='?page=" + (current + 1) + "'>Next</a></li>");
                                    }
                                %>            
                            </ul>
                        </nav>
                    </div><!--pagination end-->

                    <%//if no results
                            } else if ((session.getAttribute("favorites").toString()).equalsIgnoreCase("no")) {
                                out.print("<br>"
                                        + "<h1 style='text-align:center; margin-bottom:150px;'>"
                                        + "You Have No Saved Advertisements!"
                                        + "</h1>"
                                        + "<br>"
                                        + "<br>");
                            }
                        } catch (Exception ex) {
                            out.print(ex.getMessage());
                        }
                    %>

                    

                </div><!--Page content end--> 
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>

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
                                    <input id="send-message-receiver" name="textinput" value="" readonly="" type="text" required="" placeholder="Receiver" class="form-control input-md disabled"/>
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
</html>
