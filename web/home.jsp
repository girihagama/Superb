<%-- 
    Document   : home
    Created on : Aug 3, 2015, 11:19:07 PM
    Author     : Indunil
--%>

<%@page import="java.util.Iterator"%>
<%@page import="classes.ConvertTimeStamp"%>
<%@page import="classes.TimeStamp"%>
<%@page import="java.util.List"%>
<%@page import="classes.ItemView_Class"%>

<%
    if (session.getAttribute("login") == null) {
        response.sendRedirect("index.jsp");
    }

    int current;
    int total = 0;

    try {
        current = Integer.parseInt(request.getParameter("page"));
        total = Integer.parseInt(session.getAttribute("myAdsPageCount").toString());

        if (current > total) {
            current = total;
        }

        if (current <= 0) {
            current = 1;
        }
    } catch (Exception e) {
        current = 1;
        total = Integer.parseInt(session.getAttribute("myAdsPageCount").toString());
    }

    ItemView_Class items = new ItemView_Class();
    ConvertTimeStamp tConvert = new ConvertTimeStamp();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Account</title>
        <meta name="description" content="Buy and sell everything from Superb.lk. Did you know that Superb.lk has the best mobile deals in Sri Lanka? Visit Superb.lk and Search all of Sri Lanka.">
        <meta property="og:url" content="http://superb.lk/web">
        <meta property="og:site_name" content="Superb.lk">
        <meta property="og:title" content="Superb.lk - My Account">
        <meta property="og:description" content="Buy and sell everything from Superb.lk. Did you know that Superb.lk has the best mobile deals in Sri Lanka? Visit Superb.lk and Search all of Sri Lanka.">
        <meta property="og:image" content="http://superb.lk/ng-admin/images/facebook-opengraph.png"/>
        <jsp:include page="BootstrapHeader.jsp"></jsp:include>

            <script src='custom_styles_scripts/zoom.min.js'></script>
            <link rel="stylesheet" href="custom_styles_scripts/zoom_style.css"/>

            <link rel="stylesheet" href="custom_styles_scripts/3D_buttons.css"/>

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
                                    <a class="active2" data-toggle="tooltip" data-placement="top" title="My Account">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        My Account
                                    </a>
                                </li>
                                <li>
                                    <a href="Home_messages" data-toggle="tooltip" data-placement="bottom" title="Go To Messages">
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

                    <div class="col-md-9">

                        <div class="row">
                            <div class="col-md-12">
                                <!-- Indicates caution should be taken with this action -->
                                <a type="button" href="postAD.jsp" class="btn btn-warning btn-lg btn3d btn-block"><span class="glyphicon glyphicon-bullhorn"></span> Post Advertisement</a>
                            </div>
                        </div>

                        <br>

                        <div class="row"><!-- my ads container row-->
                            <div class="col-md-12"><!-- my ads container col-->

                            <%//check listings

                                try {
                                    if ((session.getAttribute("myads").toString()).equalsIgnoreCase("yes")) {
                                        List myList = (List) session.getAttribute("myads" + Integer.toString(current));

                                        //out.println("Current Page:" + current);
                                        //out.println("<br>Total Pages:" + total);
                                        //out.println("<br>Page Items:" + myList.size());
                                        //items
                                        for (int i = 0; i < myList.size(); i++) {
                                            //out.print("<br>"+i);

                                            items = (ItemView_Class) myList.get(i);

                            %>

                            <script type="text/javascript">
                                $(document).ready(function () {
                                    //image zoom
                                    $('#ex<%=i + 1%>').zoom();

                                    var itemNumber = $("#itemNumber<%=i%>").val();
                                    //alert(itemNumber);

                                    $("#view<%=i%>").click(function () {
                                        //alert("view" + itemNumber);

                                        window.location.href = "ViewAd?itemNumber=" + itemNumber;
                                    })

                                    $("#edit<%=i%>").click(function () {
                                        //alert("edit" + itemNumber);
                                    })

                                    $("#remove<%=i%>").click(function () {
                                        if (confirm("Are You Sure?")) {
                                            //alert("remove" + itemNumber);

                                            var dataString = "itemNumber=" + itemNumber;

                                            $.ajax({
                                                type: "POST",
                                                url: "Ajax_manageMyAds",
                                                dataType: "json",
                                                data: dataString,
                                                //if success
                                                success: function (data, textStatus, jqXHR) {
                                                    if (data.request) {
                                                        //alert("removed");
                                                        location.reload();
                                                    } else {
                                                        //alert("Cannot remove");
                                                    }
                                                },
                                                //if unsuccess
                                                error: function (jqXHR, textStatus, errorThrown) {
                                                    //alert("cannot delete");
                                                }
                                            });

                                        }
                                    })

                                });
                            </script>

                            <form method="POST" action="" id="item<%=items.getItem_number()%>">

                                <div class="col-md-12 offer offer-info"><!--Item-->

                                    <input type="hidden" id="itemNumber<%=i%>" name="itemNumber" value="<%=items.getItem_number()%>"/>

                                    <div class="col-md-3" style="border-radius: 5px;">
                                        <div class="caption text-center">
                                            <br>

                                            <span class='zoom' id='ex<%=i + 1%>'>
                                                <img src="media/item_images/<%= items.getItem_number()%>/cover.jpg?tstamp=<%=items.getTime_stamp()%>" height="200" width="200" class="img-responsive img-thumbnail" alt="Item Image" />
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

                                        <br/>

                                        <%
                                            if (items.getStatus().equalsIgnoreCase("Pending")) {
                                                out.print("<b>Status : </b><span style='letter-spacing:1px;' class='label label-default'>Pending</span>");
                                            } else if (items.getStatus().equalsIgnoreCase("Modifying")) {
                                                out.print("<b>Status : </b><span style='letter-spacing:1px;' class='label label-warning' data-toggle='tooltip' data-placement='top' title='" + items.getReason() + "'>Modification Required</span>");
                                            } else if (items.getStatus().equalsIgnoreCase("Active")) {
                                                out.print("<b>Status : </b><span style='letter-spacing:1px;' class='label label-success'>Active</span>");
                                            } else if (items.getStatus().equalsIgnoreCase("Sold")) {
                                                out.print("<b>Status : </b><span style='letter-spacing:1px;' class='label label-info'>Sold</span>");
                                            } else if (items.getStatus().equalsIgnoreCase("Disabled")) {
                                                out.print("<b>Status : </b><span style='letter-spacing:1px;' class='label label-danger'>Disabled</span>");
                                            }
                                        %>
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

                                    <div class="col-md-12"><!--item buttons-->
                                        <hr>
                                        <div class="btn-group btn-group-justified" role="group">
                                            <div class="btn-group btn-group-sm" role="group">
                                                <button type="button" id="view<%=i%>" name="view" value="<%= items.getItem_number()%>" class="btn btn-primary">View & Edit</button>
                                            </div>
                                            <div class="btn-group btn-group-sm hidden" role="group">
                                                <button type="button" id="edit<%=i%>" name="edit" value="<%= items.getItem_number()%>" class="btn btn-success">Edit</button>
                                            </div>
                                            <div class="btn-group btn-group-sm" role="group">
                                                <button type="button" id="remove<%=i%>" name="remove" value="<%= items.getItem_number()%>" class="btn btn-danger">Remove</button>
                                            </div>
                                        </div>
                                        <hr>
                                    </div><!--item buttons-->

                                </div><!--Item end-->
                            </form>

                            <%//end of for loop
                                }//for loop end
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

                            <%//if no reslts
                                    } else if ((session.getAttribute("myads").toString()).equalsIgnoreCase("no")) {
                                        out.print("<br>"
                                                + "<h1 style='text-align:center; margin-bottom:80px;'>"
                                                + "You Have No Advertisements!"
                                                + "</h1>");
                                    }
                                } catch (Exception ex) {
                                    out.print(ex.getMessage());
                                }

                            %>

                        </div><!-- my ads container col end-->
                    </div><!-- my ads container row end-->

                    <div class="row"><!--Footer correction-->
                        <div class="col-md-12">
                            <hr>
                        </div>
                    </div><!--Footer correction end-->

                </div>
            </div>


        </div>
    </body>
    <jsp:include page="footer.jsp"></jsp:include>
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
