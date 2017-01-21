<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
    Document   : testpage
    Created on : Oct 11, 2015, 11:02:16 AM
    Author     : Indunil
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="classes.ConvertTimeStamp"%>
<%@page import="classes.ItemView_Class"%>
<%
    int total = Integer.parseInt(session.getAttribute("searchPageCount").toString());
    int current;

    try {
        current = Integer.parseInt(request.getParameter("page"));

        if (current > total) {
            //current = total;
            response.sendRedirect("Search");
        }

        if (current <= 0) {
            //current = 1;
            response.sendRedirect("Search");
        }
    } catch (Exception e) {
        current = 1;
        total = Integer.parseInt(session.getAttribute("searchPageCount").toString());
    }

    ItemView_Class items = new ItemView_Class();
    ConvertTimeStamp tConvert = new ConvertTimeStamp();
%>

<%
    String str = ""; //request.getRequestURL() + "?";
    Enumeration<String> paramNames = request.getParameterNames();
    while (paramNames.hasMoreElements()) {
        String paramName = paramNames.nextElement();
        String[] paramValues = request.getParameterValues(paramName);

        for (int i = 0; i < paramValues.length; i++) {
            String paramValue = paramValues[i];
            str = str + paramName + "=" + paramValue;
        }
    }

    if (request.getParameter("page") != null) {
        str = str.substring(0, str.indexOf("page="));
    }

    if (str.length() > 0) {
        str = str + "&";
    }

    String currentParams = null;

    try {
        currentParams = (str.substring(0, str.length() - 1)); //remove the last character from String
    } catch (Exception e) {
        currentParams = str;
    }

    if ((str.substring(0, str.length())).length() > 0) {
        currentParams = currentParams + "&";
    }

    if (current > 0 && !(current < total)) {
        int next = current + 1;
        int back = current - 1;
    } else {
        int next = 0;
        int back = 0;
    }

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All In One Classifieds!</title>
        <jsp:include page="BootstrapHeader.jsp"></jsp:include>

            <script src='custom_styles_scripts/zoom.min.js'></script>
            <link rel="stylesheet" href="custom_styles_scripts/zoom_style.css"/> 

            <style>
                body{
                    margin: 0px;
                    padding: 1px;
                }

                .box{
                    padding: 15px 10px 0px 10px;
                    background: rgba(0, 100, 255, 0.1);
                    border-radius: 10px;
                    -webkit-box-shadow:inset 0 0 10px 1px #FFFFFF;
                    box-shadow:inset 0 0 10px 1px #FFFFFF;
                }
            </style>

            <script>
                $(document).ready(function () {
                    updateUserCurrentStatus();

                    setInterval(function () {
                        updateUserCurrentStatus();
                    }, 2000);

                    function getParameterByName(name, url) {
                        if (!url)
                            url = window.location.href;
                        url = url.toLowerCase(); // This is just to avoid case sensitiveness  
                        name = name.replace(/[\[\]]/g, "\\$&").toLowerCase();// This is just to avoid case sensitiveness for query parameter name
                        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                                results = regex.exec(url);
                        if (!results)
                            return null;
                        if (!results[2])
                            return '';
                        return decodeURIComponent(results[2].replace(/\+/g, " "));
                    }

                    if (getParameterByName('adType') === "for sale") {
                        $('#type option:eq(1)').prop('selected', true);
                    } else if (getParameterByName('adType') === "for rent") {
                        $('#type option:eq(2)').prop('selected', true);
                    } else if (getParameterByName('adType') === "wanted") {
                        $('#type option:eq(3)').prop('selected', true);
                    } else {
                        $('#type option:eq(4)').prop('selected', true);
                    }

                    if (getParameterByName('sort') === "newest") {
                        $('#sort option:eq(1)').prop('selected', true);
                    } else if (getParameterByName('sort') === "oldest") {
                        $('#sort option:eq(2)').prop('selected', true);
                    } else if (getParameterByName('sort') === "highest price") {
                        $('#sort option:eq(3)').prop('selected', true);
                    } else if (getParameterByName('sort') === "lowest price") {
                        $('#sort option:eq(4)').prop('selected', true);
                    } else if (getParameterByName('sort') === "highest views") {
                        $('#sort option:eq(5)').prop('selected', true);
                    } else if (getParameterByName('sort') === "lowest views") {
                        $('#sort option:eq(6)').prop('selected', true);
                    } else {
                        $('#sort option:eq(0)').prop('selected', true);
                    }

                    //hide at load
                    $('#districtSlider').hide().show("slow");

                    //toggle codes
                    $('#districtSliderHeader').click(function () {
                        $('#districtSlider').slideToggle('fast');
                    });

                    //hide at load
                    $('#secondaryDistricts').hide();

                    //toggle codes
                    $('#showMoreDis').click(function () {
                        $('#secondaryDistricts').slideToggle('fast');
                        if ($('.dis-show').html() == "Show more") {
                            $('.dis-show').html("Show less");
                        } else {
                            $('.dis-show').html("Show more");
                        }
                    });

                    //hide at load
                    $('#citySlider').hide().show("slow");

                    //toggle codes
                    $('#citySliderHeader').click(function () {
                        $('#citySlider').slideToggle('fast');
                    });

                    //hide at load
                    $('#mainCatSlider').hide().show("slow");

                    //toggle codes
                    $('#mainCatSliderHeader').click(function () {
                        $('#mainCatSlider').slideToggle('fast');
                    });

                    //hide at load
                    $('#subCatSlider').hide().show("slow");

                    //toggle codes
                    $('#subCatSliderHeader').click(function () {
                        $('#subCatSlider').slideToggle('fast');
                    });

                    //button click management
                    $('.btnSendMessage').click(function (e) {
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
                                        resp.text("This is your advertistment!");

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
                        var itemNumber = $('#send-message-itemno').val();
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

                    $('.btnSaveItem').click(function (e) {
                        var itemNumber = $(this).next().val();
                    });

                });

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


        <body class="container-fluid text-center">

            <div class="hidden" id="msgCleaner"></div>

        <jsp:include page="navbar.jsp"></jsp:include>

            <div class="row-fluid">

                <div class="col-md-3 text-left"><!--filter-->

                    <form name="advancedSearch"> 
                    </form>

                    <h4 class="header text-center">Refine Results</h4>

                    <hr/>

                    <!--Type filter-->
                    <fieldset>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Ads</label>
                            <div class="col-md-9">
                                <select name="type" id="type" onchange="location = this.options[this.selectedIndex].value;">

                                <c:url var="anyUrl" value="${myURL}">                                    
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'adType'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="adType" value="All Ads" />
                                </c:url>

                                <c:url var="saleUrl" value="">
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'adType'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="adType" value="For Sale" />
                                </c:url>                                                  

                                <c:url var="rentUrl" value="">
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'adType'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="adType" value="For Rent" />
                                </c:url>

                                <c:url var="wantedUrl" value="">
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'adType'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="adType" value="Wanted" />
                                </c:url>

                                <option value=${anyUrl}>All</option>
                                <option value=${saleUrl}>For Sale</option>
                                <option value=${rentUrl}>For Rent</option>
                                <option value=${wantedUrl}>Wanted</option>
                            </select>
                        </div>
                </fieldset>

                <hr/>

                <!--Sort filter-->
                <fieldset>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Sort</label>
                        <div class="col-md-9">
                            <select name="sort" id="sort" onchange="location = this.options[this.selectedIndex].value;">

                                <c:url var="relevanceUrl" value="${myURL}">                                    
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'sort'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="sort" value="relevance" />
                                </c:url>

                                <c:url var="newestUrl" value="${myURL}">                                    
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'sort'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="sort" value="newest" />
                                </c:url>                                                 

                                <c:url var="oldestUrl" value="${myURL}">                                    
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'sort'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="sort" value="oldest" />
                                </c:url>   

                                <c:url var="priceHighUrl" value="${myURL}">                                    
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'sort'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="sort" value="highest price" />
                                </c:url>  

                                <c:url var="priceLowUrl" value="${myURL}">                                    
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'sort'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="sort" value="lowest price" />
                                </c:url> 

                                <c:url var="viewsHighUrl" value="${myURL}">                                    
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'sort'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="sort" value="highest views" />
                                </c:url> 

                                <c:url var="viewsLowUrl" value="${myURL}">                                    
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'sort'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="sort" value="lowest views" />
                                </c:url>  

                                <option value=${relevanceUrl}>Relevance</option>
                                <option value=${newestUrl}>Newest Ads</option>
                                <option value=${oldestUrl}>Oldest Ads</option>
                                <option value=${priceHighUrl}>Price Highest</option>
                                <option value=${priceLowUrl}>Price Lowest</option>
                                <option value=${viewsHighUrl}>Views Highest</option>
                                <option value=${viewsLowUrl}>Views Lowest</option>
                            </select>
                        </div>
                </fieldset>

                <hr/>                

                <%//districts
                    if (session.getAttribute("resultDistricts") != null) {
                        if (((List) session.getAttribute("resultDistricts")).size() > 0) {
                            List locations = (List) session.getAttribute("resultDistricts");
                            out.print("<h4 id='districtSliderHeader' class='header text-center'>Districts <span class='glyphicon glyphicon-chevron-down small'></span></h4>");

                %>

                <div id='districtSlider'>
                    <hr>
                    <a href="Search"><span class="badge" style="background-color: #B143E7"><span class="glyphicon glyphicon-chevron-right" ></span></span>&nbsp;&nbsp;All Districts</a>
                    <br>
                    <div id="mainDistricts">
                        <%//
                            for (int x = 0; x < locations.size(); x++) {
                                String disName = locations.get(x).toString();

                        %>               

                        <c:url var="disUrl" value="">
                            <c:forEach items="${param}" var="entry">
                                <c:if test="${entry.key != 'district'}">
                                    <c:param name="${entry.key}" value="${entry.value}" />
                                </c:if>
                            </c:forEach>
                            <c:param name="district" value="<%=disName%>" />
                        </c:url>
                        <%
                            if (x < 6) {
                        %>
                        <a href="${disUrl}"><span class="badge" style="background-color: #B143E7"><%=String.valueOf(disName.charAt(0))%></span>&nbsp;&nbsp;<%=disName%></a>
                        <br>

                        <%}}%>
                    </div>
                    <div id="secondaryDistricts">
                        <%//
                            for (int x = 6; x < locations.size(); x++) {
                                String disName = locations.get(x).toString();

                        %>               

                        <c:url var="disUrl" value="">
                            <c:forEach items="${param}" var="entry">
                                <c:if test="${entry.key != 'district'}">
                                    <c:param name="${entry.key}" value="${entry.value}" />
                                </c:if>
                            </c:forEach>
                            <c:param name="district" value="<%=disName%>" />
                        </c:url>
                        <%
                            if (x > 6) {
                        %>
                        <a href="${disUrl}"><span class="badge" style="background-color: #B143E7"><%=String.valueOf(disName.charAt(0))%></span>&nbsp;&nbsp;<%=disName%></a>
                        <br>

                        <%//
                                }
                            }
                        %>
                    </div>
                    <%if (locations.size() > 6) {%>
                    <h5 id="showMoreDis" class="">&nbsp;<span class="glyphicon glyphicon-th-large"></span>&nbsp;<span class="dis-show">Show more</span></h5>
                    <%}%>

                    <hr>
                </div>

                <%//
                        }
                    }
                %>

                <%// cities
                    if (session.getAttribute("resultCities") != null) {
                        if (((List) session.getAttribute("resultCities")).size() > 0) {
                            List locations = (List) session.getAttribute("resultCities");
                            out.print("<h4 id='citySliderHeader' class='header text-center'>Cities <span class='glyphicon glyphicon-chevron-down small'></span></h4>");

                %>

                <div id='citySlider'>
                    <hr>

                    <a href="Search"><span class="badge" style="background-color: #B143E7"><span class="glyphicon glyphicon-chevron-right" ></span></span>&nbsp;&nbsp;All Districts</a><br>
                    <% if (request.getParameter("district") != null) {%>
                    <span class="badge" style="background-color: #B143E7"><%=String.valueOf(request.getParameter("district").charAt(0))%></span>&nbsp;&nbsp;&nbsp;<%=request.getParameter("district")%><br>
                    <%}%>    

                    <%//
                        for (int x = 0; x < locations.size(); x++) {
                            String citName = locations.get(x).toString();

                    %>               

                    <c:url var="citUrl" value="">
                        <c:forEach items="${param}" var="entry">
                            <c:if test="${entry.key != 'city'}">
                                <c:param name="${entry.key}" value="${entry.value}" />
                            </c:if>
                        </c:forEach>
                        <c:param name="city" value="<%=citName%>" />
                    </c:url>

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="${citUrl}"><%=citName%></a>
                    <br>

                    <%//
                        }
                    %>
                    <hr>
                </div>

                <%}} else if (session.getAttribute("resultCities") == null && session.getAttribute("resultDistricts") == null) {
                    out.print("<h4 id='districtSliderHeader' class='header text-center'>Districts <span class='glyphicon glyphicon-chevron-down small'></span></h4>");
                %>
                <div id='districtSlider'>
                    <hr>
                    <a href="Search"><span class="badge" style="background-color: #B143E7"><span class="glyphicon glyphicon-chevron-right" ></span></span>&nbsp;&nbsp;All Districts</a>
                </div>
                <%}%>

                <%// main cats
                    if (session.getAttribute("resultMainCats") != null) {
                        if (((List) session.getAttribute("resultMainCats")).size() > 0) {
                            List categories = (List) session.getAttribute("resultMainCats");
                            out.print("<h4 id='mainCatSliderHeader' class='header text-center'>Main Category <span class='glyphicon glyphicon-chevron-down small'></span></h4>");

                %>

                <div id='mainCatSlider'>
                    <hr>
                    <a href="Search"><span class="glyphicon glyphicon-chevron-right" style="font-size: 1.5em"></span>&nbsp;&nbsp;All Categories</a><br>
                    <%//
                        for (int x = 0; x < categories.size(); x++) {
                            String mcName = categories.get(x).toString();

                    %>               

                    <c:url var="mcUrl" value="">
                        <c:forEach items="${param}" var="entry">
                            <c:if test="${entry.key != 'categoryMain'}">
                                <c:param name="${entry.key}" value="${entry.value}" />
                            </c:if>
                        </c:forEach>
                        <c:param name="categoryMain" value="<%=mcName%>" />
                    </c:url>

                    <a href="${mcUrl}"><img src="media/images/Category Icons/<%=mcName%>.png" width='20' height='20'/>&nbsp;&nbsp;<%=mcName%></a>
                    <br>

                    <%}%>
                    <hr>
                </div>

                <%}}%>

                <%// sub cats
                    if (session.getAttribute("resultSubCats") != null) {
                        if (((List) session.getAttribute("resultSubCats")).size() > 0) {
                            List category = (List) session.getAttribute("resultSubCats");
                            out.print("<h4 id='subCatSliderHeader' class='header text-center'>Sub Category <span class='glyphicon glyphicon-chevron-down small'></span></h4>");

                %>

                <div id='subCatSlider'>
                    <hr>
                    <a href="Search"><span class="glyphicon glyphicon-chevron-right" style="font-size: 1.5em"></span>&nbsp;&nbsp;All Categories</a><br>
                    <% if (request.getParameter("categoryMain") != null) {%>
                    <img src="media/images/Category Icons/<%=request.getParameter("categoryMain")%>.png" width='20' height='20'/>&nbsp;&nbsp;<%=request.getParameter("categoryMain")%><br>
                    <%}%> 
                    <%//
                        for (int x = 0; x < category.size(); x++) {
                            String scName = category.get(x).toString();

                    %>               

                    <c:url var="scUrl" value="">
                        <c:forEach items="${param}" var="entry">
                            <c:if test="${entry.key != 'categorySub'}">
                                <c:param name="${entry.key}" value="${entry.value}" />
                            </c:if>
                        </c:forEach>
                        <c:param name="categorySub" value="<%=scName%>" />
                    </c:url>

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="${scUrl}"><%=scName%></a>
                    <br>

                    <%//
                        }
                    %>
                    <hr>
                </div>

                <%}} else if (session.getAttribute("resultSubCats") == null && session.getAttribute("resultMainCats") == null) {
                        out.print("<h4 id='subCatSliderHeader' class='header text-center'>Sub Category <span class='glyphicon glyphicon-chevron-down small'></span></h4>");
                %>
                <div id='subCatSlider'>
                    <hr>
                    <a href="Search"><span class="glyphicon glyphicon-chevron-right" style="font-size: 1.5em"></span>&nbsp;&nbsp;All Categories</a><br>
                    <% if (request.getParameter("categoryMain") != null) {%>
                    <img src="media/images/Category Icons/<%=request.getParameter("categoryMain")%>.png" width='20' height='20'/>&nbsp;&nbsp;<%=request.getParameter("categoryMain")%><br>
                    <%}%> 
                </div>
                <%}%>

            </div><!--filter end-->

            <div class="col-md-9">

                <%  //
                    if (session.getAttribute("selectedDistricts") != null) {
                        //out.print("Districts");

                        String[] districts = (String[]) session.getAttribute("selectedDistricts");
                %>

                <hr>
                <div class="row" style="font-size: smaller;"><!--selected districts-->

                    <div class="col-md-12 text-left">
                        <b>Districts : </b>
                        <br class="hidden-lg hidden-md hidden-sm">
                        <br class="hidden-lg hidden-md hidden-sm">

                        <%//districts loop
                            for (int i = 0; i < districts.length; i++) {
                                out.print("<span style='letter-spacing:1px; padding: 10px; margin-bottom:5px; margin-right: 10px; display: inline-block; background-color:orangered; border-radius:20px;box-shadow: 0px 0px 10px 1px rgba(61,0,61,1);' class='label label-default'> " + (new String(districts[i])).toUpperCase() + " </span>");
                            }
                        %>                        
                    </div>

                </div><!--selected districts end-->
                <hr>

                <%//end of selected districts
                    }
                %>               

                <div class="row"><!--search results-->

                    <div class="col-md-12">


                        <%
                            try {

                                //out.print(currentParams);
                                if ((session.getAttribute("searchResults").toString()).equalsIgnoreCase("yes")) {
                                    //out.print("Results");

                                    List myList = (List) session.getAttribute("search" + Integer.toString(current));

                                    for (int i = 0; i < myList.size(); i++) {
                                        items = (ItemView_Class) myList.get(i);

                        %>

                        <script type="text/javascript">
                            $(document).ready(function () {
                                //image zoom
                                $('#ex<%=i + 1%>').zoom();
                            });
                        </script>

                        <%--<form method="POST" action="" id="item<%=items.getItem_number()%>">--%>
                        <div class="col-md-12 offer offer-info itemMain" id="item<%=items.getItem_number()%>"><!--Item-->

                            <input type="hidden" id="itemNumber<%=i%>" name="itemNumber" value="<%= items.getItem_number()%>"/>
                            <input type="hidden" id="seller<%=i%>" name="sellerName" value="<%= items.getUsername()%>"/>

                            <div class="col-md-3" style="border-radius: 5px;">
                                <div class="caption text-center">
                                    <br>

                                    <span class='zoom' id='ex<%=i + 1%>'>
                                        <img src="media/item_images/<%= items.getItem_number()%>/cover.jpg" height="200" width="200" class="img-responsive img-thumbnail" alt="Item Image" />
                                    </span>

                                    <br>
                                </div>
                            </div>

                            <div class="col-md-4 text-left" style="padding: 5px;">
                                <h4>
                                    <b><%= items.getTitle()%></b>
                                </h4>

                                <div class="hidden-xs hidden-sm hidden-md">
                                    <small><b>Category : </b><%= items.getCategory_main()%> > <%=items.getCategory_sub()%></small>
                                    <br>
                                </div>


                                <small><b>Location : </b><%= items.getDistrict()%> > <%=items.getCity()%></small>

                                <div class="hidden-xs hidden-sm hidden-md">
                                    <br>
                                    <%--<br>
                                    <b>Item No. : </b><%= items.getItem_number()%>
                                    <br>
                                    --%>


                                    <%
                                        if (items.getAd_form().equalsIgnoreCase("for sale")) {
                                            out.print("<b>Item is : </b><span style='letter-spacing:1px;' class='label label-primary'>For Sale</span>");
                                        } else if (items.getAd_form().equalsIgnoreCase("for rent")) {
                                            out.print("<b>Item is : </b><span style='letter-spacing:1px;' class='label label-primary'>For Rent</span>");
                                        } else if (items.getAd_form().equalsIgnoreCase("wanted")) {
                                            out.print("<b>Item is : </b><span style='letter-spacing:1px;' class='label label-primary'>Wanted</span>");
                                        }
                                    %>
                                </div>
                            </div>

                            <div class="col-md-3 text-left">
                                <div class="hidden-xs hidden-sm hidden-md">
                                    <br>
                                    Listed on : <%= tConvert.timeStampIn12h(items.getTime_stamp())%>
                                    <br>

                                    Seller :
                                    <div id="chat<%=i%>" data-toggle="tooltip" data-placement="top" title="" style="display: inline-block;"></div><%= items.getUsername()%>
                                    <br>

                                    Views : <%= items.getView_count()%>                                     
                                </div>
                            </div>    

                            <div class="col-md-2">
                                <br><b>
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
                                </b>
                                <hr>
                                <div class="btn-group btn-group-justified" role="group">
                                    <div class="btn-group btn-group-sm" role="group">
                                        <a class="btn btn-info btnViewAd" href="ViewAd?itemNumber=<%=items.getItem_number()%>">View</a>
                                    </div>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <button class="btn btn-success btnSendMessage">Message</button>
                                        <input type="hidden" value="<%= items.getUsername()%>"/>
                                        <input type="hidden" value="<%=items.getItem_number()%>"/>
                                    </div>
                                    <%--<div class="btn-group btn-group-sm" role="group">
                                        <button class="btn btn-warning btnSaveItem">Save</button>
                                        <input type="hidden" value="<%=items.getItem_number()%>"/>
                                    </div>--%>
                                </div>
                                <hr>
                            </div>

                        </div><!--Item end-->
                        <%--</form>--%>

                        <%//for loop end
                            }
                        %>

                        <%
                            if (total > 1) {
                        %>

                        <hr>

                        <div class="row-fluid"><!--pagination-->

                            <div class="col-md-12">
                                <center>
                                    <nav>
                                        <ul class="pager">                                          

                                            <c:url var="backUrl" value="">
                                                <c:forEach items="${param}" var="entry">
                                                    <c:if test="${entry.key != 'page'}">
                                                        <c:param name="${entry.key}" value="${entry.value}" />
                                                    </c:if>
                                                </c:forEach>

                                                <c:param name="page" value="${(param.page)-1}" />
                                            </c:url>

                                            <c:url var="nextUrl" value="">
                                                <c:forEach items="${param}" var="entry">
                                                    <c:if test="${entry.key != 'page'}">
                                                        <c:param name="${entry.key}" value="${entry.value}" />
                                                    </c:if>
                                                </c:forEach>  

                                                <c:choose>
                                                    <c:when test="${not empty param.page}">                                                        
                                                        <c:param name="page" value="${(param.page)+1}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:param name="page" value="${(param.page)+2}" />
                                                    </c:otherwise>
                                                </c:choose>

                                            </c:url>

                                            <%  //pagination

                                                int totalPages = total;

                                                if (current - 1 <= 0) {
                                                    //out.print("<li class='disabled pull-left hidden-xs'><a>Previous</a></li>");
                                                    //out.print("<li class='disabled hidden-lg hidden-md hidden-sm'><a>Previous</a></li>");
                                                } else {
                                            %>

                                            <li class='pull-left hidden-xs'><a href="${backUrl}">Previous</a></li>
                                            <li class='hidden-lg hidden-md hidden-sm'><a href="${backUrl}">Previous</a></li>

                                            <%//
                                                    //out.print("<li class='disabled pull-left hidden-xs'><a href='${backUrl}'>Previous</a></li>");
                                                    //out.print("<li class='disabled hidden-lg hidden-md hidden-sm'><a href='${backUrl}'>Previous</a></li>");
                                                }

                                                out.print("<br class='hidden-lg hidden-md hidden-sm'>"
                                                        + "<br class='hidden-lg hidden-md hidden-sm'>");

                                                if (totalPages != 1) {
                                                    /*
                                                     out.print("<li>"
                                                     + "<a>"
                                                     + "Page " + current + " / " + total + " "
                                                     + "<form id='pageChangeForm' style='display:inline-block;'>"
                                                     + "<input class='form-control' id='pageChange' name='page' value='" + current + "' type='number' min='1' max='" + total + "'/>"
                                                     + "</form>"
                                                     + "</a>"
                                                     + "</li>");
                                                     */

                                            %>                                            

                                            <li>
                                                <a>
                                                    Page <%= current%> / <%= total%>

                                                    <form id='pageChangeForm' style='display:inline-block;' class="hidden">
                                                        <input class='form-control' id='pageChange' name='page' value='<%= current%>' type='number' min='1' max='<%= total%>'/>
                                                    </form>
                                                </a>                                                
                                            </li>

                                            <%//                                                  
                                                }

                                                out.print("<br class='hidden-lg hidden-md hidden-sm'>"
                                                        + "<br class='hidden-lg hidden-md hidden-sm'>");

                                                if (current + 1 > total) {
                                                    //out.print("<li class='disabled pull-right hidden-xs'><a>Next</a></li>");
                                                    //out.print("<li class='disabled hidden-lg hidden-md hidden-sm'><a>Next</a></li>");
                                                } else {

                                            %>

                                            <li class='pull-right hidden-xs'><a href='${nextUrl}'>Next</a></li>
                                            <li class='hidden-lg hidden-md hidden-sm'><a href='${nextUrl}'>Next</a></li>

                                            <%//
                                                    //out.print("<li class='pull-right hidden-xs'><a href='?page=" + (current + 1) + "'>Next</a></li>");
                                                    //out.print("<li class='hidden-lg hidden-md hidden-sm'><a href='?page=" + (current + 1) + "'>Next</a></li>");
                                                }

                                            %>



                                        </ul>
                                    </nav>
                                </center>
                            </div>

                        </div><!--pagination end-->

                        <%                            }
                        %>                       

                        <%
                                } else {
                                    out.print("<br>"
                                            + "<center><img class='img-responsive' src='media/images/noresult.png' alt='No Results Found!'></center>"
                                            + "</h1>");
                                }

                            } catch (Exception ex) {
                                out.println(ex.getMessage());
                            }
                        %> 

                    </div>

                </div><!--search results end-->

            </div>
        </div>

        <div class="row-fluid">
            <div class="col-md-12">
                <br>
                <br>
                <br>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>

    <input type="hidden" id="send-message-username" value="" disabled="disabled" />
    <input type="hidden" id="send-message-itemno" value="" disabled="disabled" />

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
