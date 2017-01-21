<%-- 
    Document   : browse_categories
    Created on : Jul 20, 2015, 11:25:19 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <style type="text/css">
            .cus-box-shadow{
                -webkit-box-shadow: inset 0px 0px 175px -55px rgba(0,0,0,0.66);
                -moz-box-shadow: inset 0px 0px 175px -55px rgba(0,0,0,0.66);
                box-shadow: inset 0px 0px 175px -55px rgba(0,0,0,0.66);
            }
            .cus-border-radius-top-round{
                border-radius: 10px 10px 0px 0px;
                -moz-border-radius: 10px 10px 0px 0px;
                -webkit-border-radius: 10px 10px 0px 0px;
                border: 0px solid #000000;
            }
            .cus-border-radius-bottom-round{
                border-radius: 0px 0px 10px 10px;
                -moz-border-radius: 0px 0px 10px 10px;
                -webkit-border-radius: 0px 0px 10px 10px;
                border: 0px solid #000000;
            }
        </style>

        <script>
            var myArray = null;

            $(document).ready(function () {
                $.ajax({
                    type: "GET",
                    url: "Ajax_updateItemCount",
                    dataType: "xml",
                    success: function (xml) {
                        myArray = null;
                        myArray = new Array();

                        $(xml).find('detail').each(function () {
                            myArray.push($(this).find('items').text());
                        });

                        $("#Electronics").html("Total Ads: " + myArray[0].toString());
                        $("#Vehicles").html("Total Ads: " + myArray[1].toString());
                        $("#Property").html("Total Ads: " + myArray[2].toString());
                        $("#JobVacancies").html("Total Ads: " + myArray[3].toString());
                        $("#BusinessServicesIndustry").html("Total Ads: " + myArray[4].toString());
                        $("#Education").html("Total Ads: " + myArray[5].toString());
                        $("#HomeGarden").html("Total Ads: " + myArray[6].toString());
                        $("#PetsAnimals").html("Total Ads: " + myArray[7].toString());
                        $("#FoodAgriculture").html("Total Ads: " + myArray[8].toString());
                        $("#FashionHealthBeauty").html("Total Ads: " + myArray[9].toString());
                        $("#HobbySportKids").html("Total Ads: " + myArray[10].toString());

                        //window.alert('AJAX Request is succeded!');
                    },
                    error: function () {
                        //window.alert("An error occurred while updating total ads!");
                    }
                });

                setInterval(function () {
                    $.ajax({
                        type: "GET",
                        url: "Ajax_updateItemCount",
                        dataType: "xml",
                        success: function (xml) {
                            myArray = null;
                            myArray = new Array();

                            $(xml).find('detail').each(function () {
                                myArray.push($(this).find('items').text());
                            });

                            $("#Electronics").html("Total Ads: " + myArray[0].toString());
                            $("#Vehicles").html("Total Ads: " + myArray[1].toString());
                            $("#Property").html("Total Ads: " + myArray[2].toString());
                            $("#JobVacancies").html("Total Ads: " + myArray[3].toString());
                            $("#BusinessServicesIndustry").html("Total Ads: " + myArray[4].toString());
                            $("#Education").html("Total Ads: " + myArray[5].toString());
                            $("#HomeGarden").html("Total Ads: " + myArray[6].toString());
                            $("#PetsAnimals").html("Total Ads: " + myArray[7].toString());
                            $("#FoodAgriculture").html("Total Ads: " + myArray[8].toString());
                            $("#FashionHealthBeauty").html("Total Ads: " + myArray[9].toString());
                            $("#HobbySportKids").html("Total Ads: " + myArray[10].toString());


                            //window.alert('AJAX Request is succeded!');
                        },
                        error: function () {
                            //window.alert("An error occurred while updating total ads!");
                        }
                    });
                }, 5000);
            });
        </script>

    </head>
    <body class="container-fluid text-center" style="padding: 1px;">
        <div style="border-top: solid 4px purple; margin-top: 15px; width: auto;">   
        </div>

        <h2 class="header">
            All Advertisements By Category            
        </h2>

        <br>

        <div class="row cus-box-shadow cus-border-radius-top-round" id="row1">
            <br/>

            <div class="col-lg-3">
                <div class="caption text-center">
                    <hr>
                    <img class="img-rounded" src="media/images/Category Icons/Electronics.png" alt="Electronics" width="100" height="100"/>
                    <h3>Electronics</h3>
                    <p id="Electronics"></p>
                    <hr>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="caption text-center">
                    <hr>
                    <img class="img-rounded" src="media/images/Category Icons/Vehicles.png" alt="Vehicles" width="100" height="100"/>
                    <h3>Vehicles</h3>
                    <p id="Vehicles"></p>
                    <hr>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="caption text-center">
                    <hr>
                    <img class="img-rounded" src="media/images/Category Icons/Property.png" alt="Property" width="100" height="100"/>
                    <h3>Property</h3>
                    <p id="Property"></p>
                    <hr>
                </div>
            </div>
            <div class="col-lg-3">               
                <div class="caption text-center">
                    <hr>
                    <img class="img-rounded" src="media/images/Category Icons/Job Vacancies.png" alt="Job Vacancies" width="100" height="100"/>
                    <h3>Job Vacancies</h3>
                    <p id="JobVacancies"></p>
                    <hr>
                </div>
            </div>

            <br/>
        </div>

        <div class="row cus-box-shadow" id="row2">
            <br/>

            <div class="col-lg-3">
                <div class="caption text-center">
                    <hr>
                    <img class="img-rounded" src="media/images/Category Icons/Business, Services & Industry.png" alt="Business, Services & Industry" width="100" height="100"/>
                    <h3>Business, Services & Industry</h3>
                    <p id="BusinessServicesIndustry"></p>
                    <hr>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="caption text-center">
                    <hr>
                    <img class="img-rounded" src="media/images/Category Icons/Education.png" alt="Education" width="100" height="100"/>
                    <h3>Education</h3>
                    <p id="Education"></p>
                    <hr>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="caption text-center">
                    <hr>
                    <img class="img-rounded" src="media/images/Category Icons/Home & Garden.png" alt="Home & Garden" width="100" height="100"/>
                    <h3>Home & Garden</h3>
                    <p id="HomeGarden"></p>
                    <hr>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="caption text-center">
                    <hr>
                    <img class="img-rounded" src="media/images/Category Icons/Pets & Animals.png" alt="Pets & Animals" width="100" height="100"/>
                    <h3>Pets & Animals</h3>
                    <p id="PetsAnimals"></p>
                    <hr>
                </div>
            </div>

            <br/>
        </div>

        <div class="row cus-box-shadow cus-border-radius-bottom-round" id="row3">
            <br/>

            <div class="col-lg-4">
                <div class="caption text-center">
                    <hr>
                    <img class="img-rounded" src="media/images/Category Icons/Food & Agriculture.png" alt="Food & Agriculture" width="100" height="100"/>
                    <h3>Food & Agriculture</h3>
                    <p id="FoodAgriculture"></p>
                    <hr>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="caption text-center">
                    <hr>
                    <img class="img-rounded" src="media/images/Category Icons/Fashion, Health & Beauty.png" alt="Fashion, Health & Beauty" width="100" height="100"/>
                    <h3>Fashion, Health & Beauty</h3>
                    <p id="FashionHealthBeauty"></p>
                    <hr>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="caption text-center">
                    <hr>
                    <img class="img-rounded" src="media/images/Category Icons/Hobby, Sport & Kids.png" alt="Sports" width="100" height="100"/>
                    <h3>Sports</h3>
                    <p id="HobbySportKids"></p>
                    <hr>
                </div>
            </div>

            <br/>
        </div>
    </body>
</html>
