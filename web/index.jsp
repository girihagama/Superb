<%-- 
    Document   : index
    Created on : Jun 17, 2015, 10:26:45 AM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <jsp:include page="BootstrapHeader.jsp"></jsp:include>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="meta_tags.jsp"></jsp:include>

            <link rel="stylesheet" href="custom_styles_scripts/categoriesPanel.css"/>

            <style type="text/css">                
                .tile{
                    padding: 5px;
                    text-align: center;
                    color: white;
                    font-weight: bold;
                    text-shadow: 0 0 10px #000000;
                }

                .tile .tile-link{
                    text-decoration: none;
                    color : white;
                }

                .tile:hover{
                    transition: all .1s ease-in-out; 
                    transform: scale(1.1);
                    font-size: medium;
                    font-weight: normal;
                    position: relative;

                }

                .tile-blue{
                    padding: 6px 5px 6px 5px;
                    border-radius: 2px;
                    border: solid 1px #4D9ECF;


                    /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#a9e4f7+0,0fb4e7+100;Ble+3D+%235 */
                    /*background: rgb(169,228,247); /* Old browsers */
                    /* IE9 SVG, needs conditional override of 'filter' to 'none' */
                    /*background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2E5ZTRmNyIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiMwZmI0ZTciIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
                    background: -moz-linear-gradient(top,  rgba(169,228,247,1) 0%, rgba(15,180,231,1) 100%); /* FF3.6-15 */
                    /*background: -webkit-linear-gradient(top,  rgba(169,228,247,1) 0%,rgba(15,180,231,1) 100%); /* Chrome10-25,Safari5.1-6 */
                    /*background: linear-gradient(to bottom,  rgba(169,228,247,1) 0%,rgba(15,180,231,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
                    /*filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#a9e4f7', endColorstr='#0fb4e7',GradientType=0 ); /* IE6-8 */
                }

                .tile-yellow{
                    padding: 1px 5px 1px 5px;
                    border-radius: 2px;
                    border: solid 1px #DF0303;


                    /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#ffd65e+0,febf04+100;Yellow+3D+%232 */
                    //background: rgb(255,214,94); /* Old browsers */
                    /* IE9 SVG, needs conditional override of 'filter' to 'none' */
                    //background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2ZmZDY1ZSIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNmZWJmMDQiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
                    //background: -moz-linear-gradient(top,  rgba(255,214,94,1) 0%, rgba(254,191,4,1) 100%); /* FF3.6-15 */
                    //background: -webkit-linear-gradient(top,  rgba(255,214,94,1) 0%,rgba(254,191,4,1) 100%); /* Chrome10-25,Safari5.1-6 */
                    //background: linear-gradient(to bottom,  rgba(255,214,94,1) 0%,rgba(254,191,4,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
                    //filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffd65e', endColorstr='#febf04',GradientType=0 ); /* IE6-8 */
                }

                .tile-red{
                    padding: 1px 5px 1px 5px;
                    border-radius: 2px;
                    border: solid 1px #989BA0;

                    /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#febbbb+0,fe9090+45,ff5c5c+100;Red+3D+%231 */
                    //background: rgb(254,187,187); /* Old browsers */
                    /* IE9 SVG, needs conditional override of 'filter' to 'none' */
                    //background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2ZlYmJiYiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjQ1JSIgc3RvcC1jb2xvcj0iI2ZlOTA5MCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNmZjVjNWMiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
                    //background: -moz-linear-gradient(top,  rgba(254,187,187,1) 0%, rgba(254,144,144,1) 45%, rgba(255,92,92,1) 100%); /* FF3.6-15 */
                    //background: -webkit-linear-gradient(top,  rgba(254,187,187,1) 0%,rgba(254,144,144,1) 45%,rgba(255,92,92,1) 100%); /* Chrome10-25,Safari5.1-6 */
                    //background: linear-gradient(to bottom,  rgba(254,187,187,1) 0%,rgba(254,144,144,1) 45%,rgba(255,92,92,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
                    //filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#febbbb', endColorstr='#ff5c5c',GradientType=0 ); /* IE6-8 */
                }

                .tile-green{
                    padding: 1px 5px 1px 5px;
                    border-radius: 2px;
                    border: solid 1px black;

                    /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#d2ff52+0,91e842+100;Neon */
                    //background: rgb(210,255,82); /* Old browsers */
                    /* IE9 SVG, needs conditional override of 'filter' to 'none' */
                    //background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2QyZmY1MiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiM5MWU4NDIiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
                    //background: -moz-linear-gradient(top,  rgba(210,255,82,1) 0%, rgba(145,232,66,1) 100%); /* FF3.6-15 */
                    //background: -webkit-linear-gradient(top,  rgba(210,255,82,1) 0%,rgba(145,232,66,1) 100%); /* Chrome10-25,Safari5.1-6 */
                    //background: linear-gradient(to bottom,  rgba(210,255,82,1) 0%,rgba(145,232,66,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
                    //filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#d2ff52', endColorstr='#91e842',GradientType=0 ); /* IE6-8 */
                }

                .tile-gray{
                    padding: 1px 5px 1px 5px;
                    border-radius: 2px;
                    border: solid 1px #336799;

                    /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#cedce7+0,596a72+100;Grey+3D+%231 */
                    //background: rgb(206,220,231); /* Old browsers */
                    /* IE9 SVG, needs conditional override of 'filter' to 'none' */
                    //background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2NlZGNlNyIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiM1OTZhNzIiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
                    //background: -moz-linear-gradient(top,  rgba(206,220,231,1) 0%, rgba(89,106,114,1) 100%); /* FF3.6-15 */
                    //background: -webkit-linear-gradient(top,  rgba(206,220,231,1) 0%,rgba(89,106,114,1) 100%); /* Chrome10-25,Safari5.1-6 */
                    //background: linear-gradient(to bottom,  rgba(206,220,231,1) 0%,rgba(89,106,114,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
                    //filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#cedce7', endColorstr='#596a72',GradientType=0 ); /* IE6-8 */
                }

                .tile-hotPink{
                    padding: 1px 5px 1px 5px;
                    border-radius: 2px;
                    border :solid 1px #7C7F80;

                    /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#ff5db1+0,ef017c+100;Pink+3D+%231 */
                    //background: rgb(255,93,177); /* Old browsers */
                    /* IE9 SVG, needs conditional override of 'filter' to 'none' */
                    //background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2ZmNWRiMSIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNlZjAxN2MiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
                    //background: -moz-linear-gradient(top,  rgba(255,93,177,1) 0%, rgba(239,1,124,1) 100%); /* FF3.6-15 */
                    //background: -webkit-linear-gradient(top,  rgba(255,93,177,1) 0%,rgba(239,1,124,1) 100%); /* Chrome10-25,Safari5.1-6 */
                    //background: linear-gradient(to bottom,  rgba(255,93,177,1) 0%,rgba(239,1,124,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
                    //filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ff5db1', endColorstr='#ef017c',GradientType=0 ); /* IE6-8 */
                }

                .tile-orange{
                    padding: 1px 5px 1px 5px;
                    border-radius: 2px;
                    border: solid 1px #ED1D24;

                    /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#ffa84c+0,ff7b0d+100;Orange+3D */
                    //background: rgb(255,168,76); /* Old browsers */
                    /* IE9 SVG, needs conditional override of 'filter' to 'none' */
                    //background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2ZmYTg0YyIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNmZjdiMGQiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
                    //background: -moz-linear-gradient(top,  rgba(255,168,76,1) 0%, rgba(255,123,13,1) 100%); /* FF3.6-15 */
                    //background: -webkit-linear-gradient(top,  rgba(255,168,76,1) 0%,rgba(255,123,13,1) 100%); /* Chrome10-25,Safari5.1-6 */
                    //background: linear-gradient(to bottom,  rgba(255,168,76,1) 0%,rgba(255,123,13,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
                    //filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffa84c', endColorstr='#ff7b0d',GradientType=0 ); /* IE6-8 */
                }

                body:after{
                    //margin: 10%;
                }
            </style>

            <!--Slider plug-ins-->
            <link rel="stylesheet" type="text/css" href="media/images/Sliders/Slider/engine1/style.css" />
            <script type="text/javascript" src="media/images/Sliders/Slider/engine1/jquery.js"></script>
            <!--Slider plug-ins-->

        </head>

        <body class="container-fluid text-center">


        <jsp:include page="navbar.jsp"></jsp:include>

            <div class="row-fluid">
                <div class="col-lg-4" style="font-size: small; font-weight: bold;">
                <jsp:include page="indexCategories.jsp"></jsp:include>
                </div>

                <div class="col-lg-4 container">
                    <div class="col-lg-12">
                        <br class="hidden-lg"/>

                        <div id="wowslider-container1">
                            <div class="ws_images"><ul>
                                    <li><img src="media/images/Sliders/Slider/data1/images/1.jpg" alt="1" title="1" id="wows1_0"/></li>
                                    <li><img src="media/images/Sliders/Slider/data1/images/2.jpg" alt="2" title="2" id="wows1_1"/></li>
                                    <li><img src="media/images/Sliders/Slider/data1/images/3.jpg" alt="3" title="3" id="wows1_2"/></li>
                                    <li><img src="media/images/Sliders/Slider/data1/images/4.jpg" alt="4" title="4" id="wows1_3"/></li>
                                    <li><img src="media/images/Sliders/Slider/data1/images/5.jpg" alt="5" title="5" id="wows1_4"/></li>
                                    <li><img src="media/images/Sliders/Slider/data1/images/6.jpg" alt="6" title="6" id="wows1_5"/></li>
                                    <li><img src="media/images/Sliders/Slider/data1/images/7.jpg" alt="7" title="7" id="wows1_6"/></li>
                                    <li><img src="media/images/Sliders/Slider/data1/images/8.jpg" alt="8" title="8" id="wows1_7"/></li>
                                    <li><img src="media/images/Sliders/Slider/data1/images/9.jpg" alt="9" title="9" id="wows1_8"/></li>
                                    <li><img src="media/images/Sliders/Slider/data1/images/10.jpg" alt="10" title="10" id="wows1_9"/></li>
                                </ul></div>
                            <div class="ws_shadow"></div>
                            <br class="visible-xs visible-sm">
                        </div>	
                        <script type="text/javascript" src="media/images/Sliders/Slider/engine1/wowslider.js"></script>
                        <script type="text/javascript" src="media/images/Sliders/Slider/engine1/script.js"></script>

                        <!--Brand section-->
                        <div class="visible-lg" style="padding:0px 10px 0px 10px;">

                            <hr>
                            <div class="row">

                                <div class="col-lg-6 tile">
                                    <a class="tile-link" href="Search?searchTerm=Dell">
                                        <div class="tile-blue">
                                            <img src="media/images/Product_logo/dell.svg" alt="Dell" width="auto" height="42" />
                                        </div>
                                    </a>
                                </div>

                                <div class="col-lg-6 tile">
                                    <a class="tile-link" href="Search?searchTerm=Apple">
                                        <div class="tile-red">
                                            <img src="media/images/Product_logo/apple.png" alt="Apple" width="auto" height="52" />
                                        </div>
                                    </a>
                                </div>

                                <div class="col-lg-12 tile">
                                    <a class="tile-link" href="Search?searchTerm=Toyota">
                                        <div class="tile-yellow">
                                            <img src="media/images/Product_logo/toyota.svg" alt="Toyota" width="auto" height="52" />
                                        </div>
                                    </a>
                                </div>

                                <div class="col-lg-5 tile">
                                    <a class="tile-link" href="Search?searchTerm=Ray-ban">
                                        <div class="tile-orange">
                                            <img src="media/images/Product_logo/rayban1.png" alt="Rayban" width="auto" height="52" />
                                        </div>
                                    </a>
                                </div>

                                <div class="col-lg-7 tile">
                                    <a class="tile-link" href="Search?searchTerm=HP">
                                        <div class="tile-gray">
                                            <img src="media/images/Product_logo/hp.png" alt="HP" width="auto" height="52" />
                                        </div>
                                    </a>
                                </div>

                                <div class="col-lg-8 tile">
                                    <a class="tile-link" href="Search?searchTerm=Sony">
                                        <div class="tile-green">
                                            <img src="media/images/Product_logo/sony.png" alt="Sony" width="auto" height="52" />
                                        </div>
                                    </a>
                                </div>

                                <div class="col-lg-4 tile">
                                    <a class="tile-link" href="Search?searchTerm=Nissan">
                                        <div class="tile-hotPink">
                                            <img src="media/images/Product_logo/Nissan.png" alt="Nissan" width="auto" height="52" />
                                        </div>
                                    </a>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-lg-4" style="border: solid 1px rgba(0, 0, 0, 0.1); padding: 0px 0px 20px 0px; border-radius: 5px;">
                    <div class="col-lg-12">
                        <div class="caption text-center">
                            <h3>Ads By District(s)</h3>
                        </div>
                        <div class="col-lg-12">
                        <jsp:include page="map.jsp"></jsp:include>
                        </div>
                    </div>                 
                </div>

            </div>

            <div class="row-fluid hidden-xs">                             
                <div class="col-lg-12">
                <jsp:include page="top_ads.jsp"></jsp:include>
                </div>
            </div>   

            <div class="row-fluid">                             
            <jsp:include page="footer.jsp"></jsp:include> 
            <jsp:include page="model_newaccount.jsp"></jsp:include> 
            <jsp:include page="model_accountactivated.jsp"></jsp:include> 
        </div>
        <script>
            function isScrolledIntoView(elem)
            {
                var docViewTop = $(window).scrollTop();
                var docViewBottom = docViewTop + $(window).height();

                var elemTop = $(elem).offset().top;
                var elemBottom = elemTop + $(elem).height();

                return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
            }

            $(document).on("mouseover", "ul>li", function () {
                if ($(this).attr('id') == "Electronics" && !isScrolledIntoView($(this).children().eq(1)) && window.innerWidth > 1200) {
                    $(this).children().eq(1).css({"margin-top": "-150px"});
                    $(this).children().eq(1).css({"margin-right": "-235px"});

                } else if ($(this).attr('id') == "Fashion, Health And Beauty" && !isScrolledIntoView($(this).children().eq(1)) && window.innerWidth > 1200) {
                    $(this).children().eq(1).css({"margin-top": "-150px"});
                    $(this).children().eq(1).css({"margin-right": "-270px"});

                } else if ($(this).attr('id') == "Hobby, Sport And Kids" && !isScrolledIntoView($(this).children().eq(1)) && window.innerWidth > 1200) {
                    $(this).children().eq(1).css({"margin-top": "-150px"});
                    $(this).children().eq(1).css({"margin-right": "-231px"});

                } else if ($(this).attr('id') == "Home And Garden" && !isScrolledIntoView($(this).children().eq(1)) && window.innerWidth > 1200) {
                    $(this).children().eq(1).css({"margin-top": "-100px"});
                    $(this).children().eq(1).css({"margin-right": "-310px"});

                } else if ($(this).attr('id') == "Job Vacancies" && !isScrolledIntoView($(this).children().eq(1)) && window.innerWidth > 1200) {
                    $(this).children().eq(1).css({"margin-top": "-500px"});
                    $(this).children().eq(1).css({"margin-right": "-340px"});

                } else if ($(this).attr('id') == "Pets And Animals" && !isScrolledIntoView($(this).children().eq(1)) && window.innerWidth > 1200) {
                    $(this).children().eq(1).css({"margin-top": "-148px"});
                    $(this).children().eq(1).css({"margin-right": "-192px"});

                }

            });
            $(document).on("mouseout", "ul>li", function () {
                $(this).children().eq(1).css({"margin-top": ""});
                $(this).children().eq(1).css({"margin-right": ""});
            });

        </script>

    </body>
</html>