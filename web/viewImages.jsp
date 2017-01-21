<%-- 
    Document   : viewImages
    Created on : Mar 3, 2016, 3:42:04 AM
    Author     : Indunil
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.io.filefilter.FileFileFilter"%>
<%@page import="java.io.FileFilter"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Item Images</title>
            <script src='custom_styles_scripts/zoom.min.js'></script>
            <link rel="stylesheet" href="custom_styles_scripts/zoom_style.css"/>

            <style>
                .carousel-control.left, .carousel-control.right {
                    background-image: none
                }
                .carousel .carousel-control {
                    visibility: hidden;
                }
                .carousel:hover .carousel-control {
                    visibility: visible;
                    color: black;
                }
                .fixed-carousel{

                }
            </style>
            <script>
                $(document).ready(function () {
                    $('.carousel').carousel({
                        interval: 3000
                    });


                });
            </script>
        </head>

    <%
        List imageLinks = new ArrayList();
        int itemNumber = 0;

        try {
            if (null != request.getParameter("item")) {
                itemNumber = Integer.parseInt(request.getParameter("item"));

                String path = request.getServletContext().getRealPath("/") + ("media/item_images/" + itemNumber);
                File directory = new File(path);

                if (directory.isDirectory()) {
                    File[] files = directory.listFiles();

                    if (files.length > 0) {

                        for (int x = 0; x < files.length; x++) {
                            File file = new File(files[x].getAbsolutePath());
                            String fileType = FilenameUtils.getExtension(file.getAbsolutePath());

                            if (fileType.equalsIgnoreCase("jpg") || fileType.equalsIgnoreCase("jpeg")) {
                                //imageLinks.add(file.getAbsolutePath());
                                imageLinks.add(file.getName());
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            out.print(e.getMessage());
        }
    %>

    <body class="container" style="max-height: 400px;">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="max-height: 400px;">

                <div id="myCarousel" class="carousel slide" data-ride="carousel">
                    <%
                        if (!imageLinks.isEmpty()) {
                            Iterator images = imageLinks.iterator();
                    %>

                    <!-- Wrapper for slides -->
                    <div class="carousel-inner" role="listbox" style="max-height: 400px;">

                        <%//looping images
                            int count = 0;
                            String active = null;

                            for (int x = 0; x < imageLinks.size(); x++) {
                                String fileName = imageLinks.get(x).toString();

                                if (x == 0) {

                        %>

                        <div class="item active">
                            <center>
                                <img class="img-responsive img-thumbnail" src="media/item_images/<%= itemNumber%>/<%= fileName%>?tstamp=<%=request.getParameter("tstamp")%>" style="position: relative;max-height: 400px;"/>
                            </center>
                        </div>

                        <%//
                        } else {
                        %>

                        <div class="item">
                            <center>
                                <img class="img-responsive img-thumbnail" src="media/item_images/<%= itemNumber%>/<%= fileName%>?tstamp=<%=request.getParameter("tstamp")%>" style="position: relative;max-height: 400px;"/>
                            </center>
                        </div>

                        <%
                                }
                            }
                        %>

                    </div>

                    <!-- Left and right controls -->
                    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>

                    <%//end of if
                    } else {
                    %>

                    <center>
                        <h1>Sorry!</h1>
                        <h3>No images found for this item.</h3>
                        <hr>
                        <img src="https://www.raceentry.com/img/Race-Registration-Image-Not-Found.png" alt="Images not found" style="max-height: 200px;" class="img-responsive"/>
                    </center>

                    <%  //end of else          
                        }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>
