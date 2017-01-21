<%-- 
    Document   : top_ads
    Created on : Nov 28, 2015, 11:35:01 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="description" content="Buy and sell everything from Superb.lk. Did you know that Superb.lk has the best mobile deals in Sri Lanka? Visit Superb.lk and Search all of Sri Lanka.">
        <meta property="og:url" content="http://superb.lk/web">
        <meta property="og:site_name" content="Superb.lk">
        <meta property="og:title" content="Superb.lk - Top Ads">
        <meta property="og:description" content="Buy and sell everything from Superb.lk. Did you know that Superb.lk has the best mobile deals in Sri Lanka? Visit Superb.lk and Search all of Sri Lanka.">
        <meta property="og:image" content="http://superb.lk/ng-admin/images/facebook-opengraph.png"/>

        <style>
            .top-seperator{
                border-top: solid 1px rgba(0, 0, 0, 0.1);//#ff3333;
                width: auto;
                margin-bottom: 10px;
                margin-top: 20px;
                padding: 10px;

                box-shadow: inset 0 5px 10px -6px;
            }
            body{
                margin: 0px;
                padding: 0px;
            }
            h5 {
                text-align: center; 
                border-bottom: 2px solid rgba(0, 0, 88, 0.2); 
                line-height: 0.1em;
                font-size: large;
                //margin: 10px 0 20px; 
            }
            h5 span { 
                background:#fff; 
                padding:0 10px; 
                border-radius: 10px;
            }
            .top-ad-image{
                display: inline-block;
                width: 225px;
                height: 175px;
                margin: 0px;
                background-position: center center;
                background-size: cover;
                border-radius: 10px;                    
            }
            .topadCaption{
                width: 220px;
                height: 17px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
        </style>

        <script>
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "Ajax_topAds",
                    dataType: "json",
                    success: function (data, textStatus, jqXHR) {
                        //main array list                
                        var allItems = data.topItems;

                        if (allItems.length > 0) {

                            //ad listing area variable
                            var area = $("#topAdsArea");
                            area.html("");
                            var content = "";

                            //loop trough main array list
                            for (var i = 0; i < allItems.length; i++) {
                                var adLine = allItems[i];
                                //alert("new ad line");

                                //DOM eliment                
                                var row = "<div class='row-fluid' style='min-height: 100px; font-size: small;'>";
                                row += "<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='background-color: rgba(0, 0, 0, 0.1); border-radius:10px; margin:1px; padding:2px;'>";

                                //loop trough ad line
                                for (var x = 0; x < adLine.length; x++) {
                                    //alert("Ad:-"+adLine[x]);
                                    //An advertistment

                                    var ad = adLine[x];
                                    //collect informations of curent advertistment
                                    var itemNo = ad[0];
                                    var username = ad[1];
                                    var catMain = ad[2];
                                    var catSub = ad[3];
                                    var district = ad[4];
                                    var city = ad[5];
                                    var title = ad[6];
                                    var adForm = ad[7];
                                    var price = ad[8];
                                    var views = ad[9];
                                    var tstamp = ad[10];
                                    var col = "";
                                    var head = "<h5><span>" + catMain + "</span></h5><br>"; //main Category

                                    //hyperlink of current advertistment
                                    var adLink = "ViewAd?itemNumber=" + itemNo;
                                    var img = "media/item_images/" + itemNo + "/cover.jpg?tstamp=" + tstamp;
                                    col += "<a href='" + adLink + "' title = 'Click to view the Ad'><div class='col text-left' style='display: inline-block;padding: 0px 5px 0px 5px; font-size:smaller;'>";
                                    col += "<img src='" + img + "' alt='Item Image' class='img-responsive img-thumbnail top-ad-image' style='margin-bottom:5px;' width='225'/>";
                                    col += "<div class = 'caption topadCaption' style='max-width: 150px;'>" + title + "</div>"
                                    //col+= "[Item #: " + itemNo + "]<br>";
                                    if (price > 0) { //if item is not negotiable
                                        col += "<b>" + "Rs." + price + "</b>";
                                        col += "<br>";
                                    }
                                    col += "<b>" + adForm + "</b>";
                                    col += "</div></a>";
                                    row += col;
                                }

                                row += '</div></div><hr>';

                                if (i + 1 === allItems.length) {
                                    content += head + row + "</div>";
                                } else {
                                    content += head + row + "<div style='height:140px;'></div>";
                                }
                            }

                            area.append(content);

                        } else {
                            var area = $("#topAdsArea");
                            area.addClass('alert');
                            area.addClass('alert-danger');
                            area.text("Advertisments Required To Show Top Ads!");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $("#topAdsArea").html("<div class='alert alert-danger'> Connection is too slow. Please wait or try after several minutes!</div>");
                    }
                });

            });
        </script>

    </head>
    <body class="container-fluid" style="padding-bottom: 5px;">

        <div class="row top-seperator">

            <!--<h2>Top Ads</h2><hr>-->

            <div id="topAdsArea">

                <!--                <div class="row" style="min-height: 100px;">
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="min-height: 100px;">
                                        <div class="col" style="display: inline-block;">
                                            
                                        </div>  
                                        <div class="col" style="display: inline-block;">
                                            
                                        </div> 
                                        <div class="col" style="display: inline-block;">
                                            
                                        </div> 
                                    </div>
                
                                </div>            -->

            </div>        
        </div>
    </body>
</html>
