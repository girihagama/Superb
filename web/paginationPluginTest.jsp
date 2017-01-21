<%-- 
    Document   : paginationPluginTest
    Created on : Oct 10, 2015, 11:24:41 PM
    Author     : Indunil
--%>

<%
    int total = 20;//Integer.parseInt(request.getParameter("total"));    
    int current;

    try {
        current = Integer.parseInt(request.getParameter("page"));
        //total = Integer.parseInt(session.getAttribute("Pages").toString());

        if (current > total) {
            current = total;
        }

        if (current <= 0) {
            current = 1;
        }
    } catch (Exception e) {
        current = 1;
        total = 20;//Integer.parseInt(session.getAttribute("myAdsPageCount").toString());
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="BootstrapHeader.jsp"></jsp:include>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>JSP Page</title>

            <script type="text/javascript">
                $(document).ready(function () {
                    var total =<%= total%>;

                    $("#pageChange").change(function () {
                        if ($("#pageChange").val() !== "") {
                            $("#pageChangeForm").submit();
                        }
                    });

                    $("#pageChangeForm").submit(function (e) {
                        if ($("#pageChange").val() === "" || $("#pageChange").val() === null) {
                            e.preventDefault();
                        } else if ($("#pageChange").val() > total || $("#pageChange").val() < 1) {
                            e.preventDefault();
                        }
                    });
                });
        </script>

    </head>
    <body class="container-fluid">

        <div class="row"><!--pagination-->

            <div class="col-md-12 text-center"><!--pagination-->
                <nav>
                    <ul class="pager">
                        <%  //pagination                                          
                            int totalPages = total;

                            if (current - 1 <= 0) {
                                out.print("<li class='disabled pull-left hidden-xs'><a>Previous</a></li>");
                                out.print("<li class='disabled hidden-lg hidden-md hidden-sm'><a>Previous</a></li>");
                            } else {
                                out.print("<li class='pull-left hidden-xs'><a href='?page=" + (current - 1) + "'>Previous</a></li>");
                                out.print("<li class='hidden-lg hidden-md hidden-sm'><a href='?page=" + (current - 1) + "'>Previous</a></li>");
                            }

                            out.print("<br class='hidden-lg hidden-md hidden-sm'>"
                                    + "<br class='hidden-lg hidden-md hidden-sm'>");

                            if (totalPages != 1) {
                                out.print("<li>"
                                        + "<a>"
                                        + "Page " + current + " / " + total + " "
                                        + "<form id='pageChangeForm' style='display:inline-block;'>"
                                        + "<input class='form-control' id='pageChange' name='page' value='" + current + "' type='number' min='1' max='" + total + "'/>"
                                        + "</form>"
                                        + "</a>"
                                        + "</li>");
                            }

                            out.print("<br class='hidden-lg hidden-md hidden-sm'>"
                                    + "<br class='hidden-lg hidden-md hidden-sm'>");

                            if (current + 1 > total) {
                                out.print("<li class='disabled pull-right hidden-xs'><a>Next</a></li>");
                                out.print("<li class='disabled hidden-lg hidden-md hidden-sm'><a>Next</a></li>");
                            } else {
                                out.print("<li class='pull-right hidden-xs'><a href='?page=" + (current + 1) + "'>Next</a></li>");
                                out.print("<li class='hidden-lg hidden-md hidden-sm'><a href='?page=" + (current + 1) + "'>Next</a></li>");
                            }
                        %>            
                    </ul>
                </nav>
            </div><!--pagination end-->

        </div><!--pagination end-->

    </body>
</html>
