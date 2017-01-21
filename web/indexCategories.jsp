<%-- 
    Document   : indexCategories
    Created on : Nov 1, 2015, 6:30:40 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <style>
            .dropdown:hover > ul.dropdown-menu {
                display: block;    
            }
            @media (min-width: 320px) and (max-width: 380px){
                .dropdown-toggle{
                    font-size: 11px !important;
                }
                .dropdown-menu a, .dropdown-menu{
                    font-size: 10px !important;
                }
            }
        </style>

        <script>

            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "Ajax_getAllCategories",
                    dataType: "json",
                    //if received a response from the server
                    success: function (data) {
                        var objectList = data.allCategories;
                        //alert(objectList.length);

                        for (var x = 0; x < objectList.length; x++) {
                            var catObject = objectList[x];
                            var mainCat = catObject[0];
                            var subCats = catObject[1];

                            var custom_obj = null;
                            var obj = null;
                            if (mainCat == "Property" || mainCat == "Vehicles") {
                                custom_obj = "<li id='" + mainCat + "' role='presentation' class='dropdown Category'>";
                                custom_obj += "<a href='' class='dropdown-toggle' data-toggle='dropdown' role='button' aria-haspopup='true' aria-expanded='false'>";
                                custom_obj += "<img src='media/images/Category Icons/" + mainCat + ".png' width='20' height='20'/> ";
                                custom_obj += mainCat;
                                custom_obj += "<span class='glyphicon glyphicon-chevron-right pull-right'></span>";
                                custom_obj += "</a>";
                                custom_obj += "<ul class='dropdown-menu dropdown-menu-right'>";

                                for (var y = 0; y < subCats.length; y++) {
                                    custom_obj += "<li class='text-right' style='margin: 2px; padding: 3px;'>";
                                    custom_obj += "<a style='border-radius: 5px; display:inline-block;' href='Search?category=" + mainCat + ">" + subCats[y] + "&categoryMain=" + mainCat + "&categorySub=" + subCats[y] + "'>" + subCats[y] + "</a> <span class='glyphicon glyphicon-search' style='display:inline-block;'></span>";
                                    custom_obj += "</li>";
                                }

                                custom_obj += "</ul>";
                                custom_obj += "</li>";


                            } else {
                                obj = "<li id='" + mainCat + "' role='presentation' class='dropdown Category'>";
                                obj += "<a href='' class='dropdown-toggle' data-toggle='dropdown' role='button' aria-haspopup='true' aria-expanded='false'>";
                                obj += "<img src='media/images/Category Icons/" + mainCat + ".png' width='20' height='20'/> ";
                                obj += mainCat;
                                obj += "<span class='glyphicon glyphicon-chevron-right pull-right'></span>";
                                obj += "</a>";
                                obj += "<ul class='dropdown-menu dropdown-menu-right'>";

                                for (var y = 0; y < subCats.length; y++) {
                                    obj += "<li class='text-right' style='margin: 2px; padding: 3px;'>";
                                    obj += "<a style='border-radius: 5px; display:inline-block;' href='Search?category=" + mainCat + ">" + subCats[y] + "&categoryMain=" + mainCat + "&categorySub=" + subCats[y] + "'>" + subCats[y] + "</a> <span class='glyphicon glyphicon-search' style='display:inline-block;'></span>";
                                    obj += "</li>";
                                }

                                obj += "</ul>";
                                obj += "</li>";
                            }

                            //alert(obj);
                            var area = $("#categoryArea");
                            $(".cat-topic").after(custom_obj);
                            area.append(obj);
                        }
                    }
                });
            });

        </script>

    </head>

    <body class="container-fluid" style="padding: 5px;">
        <div class="col-lg-12">

            <ul id="categoryArea" class="nav nav-pills nav-stacked text-left">
                <li role="presentation" class="active cat-topic"><a class="cat text-center" style="font-size: medium;">All Categories</a></li>
            </ul>

        </div>
    </body>
    <script>
        function isScrolledIntoView(elem)
        {
            var docViewTop = $(window).scrollTop();
            var docViewBottom = docViewTop + $(window).height();

            var elemTop = $(elem).offset().top;
            var elemBottom = elemTop + $(elem).height();

            return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
        }

        $('#myDropdown').on('show.bs.dropdown', function () {
            console.log('It works!');
        })

        $("li").hover(function () {
            console.log('It works!');
        });



    </script>
</html>
