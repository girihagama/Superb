<%-- 
    Document   : postAD
    Created on : Sep 8, 2015, 11:00:21 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create An Advertisement</title>
        <meta name="description" content="Buy and sell everything from Superb.lk. Did you know that Superb.lk has the best mobile deals in Sri Lanka? Visit Superb.lk and Search all of Sri Lanka.">
        <meta property="og:url" content="http://superb.lk/web">
        <meta property="og:site_name" content="Superb.lk">
        <meta property="og:title" content="Superb.lk - Post An Advertisement">
        <meta property="og:description" content="Buy and sell everything from Superb.lk. Did you know that Superb.lk has the best mobile deals in Sri Lanka? Visit Superb.lk and Search all of Sri Lanka.">
        <meta property="og:image" content="http://superb.lk/ng-admin/images/facebook-opengraph.png"/>
        <jsp:include page="BootstrapHeader.jsp"></jsp:include>

            <style type="text/css">
                .img{
                    max-width: 200px;
                    max-height: 300px;
                    margin: 3px;
                }

                .custom-design{
                    padding: 5px;
                    margin: 15px 0px 15px 0px;
                    border-radius: 5px;                    

                    //-moz-box-shadow:    inset 0 0 5px #000000;
                    //-webkit-box-shadow: inset 0 0 5px #000000;
                    //box-shadow:         inset 0 0 5px #000000;

                    background-color: #e1ffe1;
                }
                .custom-padding{
                    padding: 5px;
                }

                // File button

                .custom-file-input {
                    display: inline-block;
                    position: relative;
                    color: #533e00;               

                }
                .custom-file-input input {
                    visibility: hidden;
                    width: 100px
                }
                .custom-file-input:before {
                    content: 'Select Image(s)';
                    display: block;
                    background: -webkit-linear-gradient( -180deg, #ffdc73, #febf01);
                    background: -o-linear-gradient( -180deg, #ffdc73, #febf01);
                    background: -moz-linear-gradient( -180deg, #ffdc73, #febf01);
                    background: linear-gradient( -180deg, #ffdc73, #febf01);
                    border: 1px solid #dca602;
                    border-radius: 1px;
                    padding: 5px 0px;
                    outline: none;
                    white-space: nowrap;
                    cursor: pointer;
                    text-shadow: 1px 1px rgba(255,255,255,0.7);
                    font-weight: bold;
                    text-align: center;
                    font-size: 10pt;
                    //position: absolute;
                    left: 0;
                    right: 0;
                }
                .custom-file-input:hover:before {
                    border-color: #febf01;
                }
                .custom-file-input:active:before {
                    background: #febf01;
                }
                .file-blue:before {
                    content: 'Select File(s)';
                    background: -webkit-linear-gradient( -180deg, #99dff5, #02b0e6);
                    background: -o-linear-gradient( -180deg, #99dff5, #02b0e6);
                    background: -moz-linear-gradient( -180deg, #99dff5, #02b0e6);
                    background: linear-gradient( -180deg, #99dff5, #02b0e6);
                    border-color: #57cff4;
                    color: #FFF;
                    text-shadow: 1px 1px rgba(000,000,000,0.5);
                }
                .file-blue:hover:before {
                    border-color: #02b0e6;
                }
                .file-blue:active:before {
                    background: #02b0e6;
                }

            </style>

            <script type="text/javascript"> //popover auto hide
                $(document).ready(function () {
                    $('body').on('click', function (e) {
                        //did not click a popover toggle or popover
                        if ($(e.target).data('toggle') !== 'popover'
                                && $(e.target).parents('.popover.in').length === 0) {
                            $('[data-toggle="popover"]').popover('hide');
                        }
                    });
                });
            </script>

            <script>
                $(document).ready(function () {
                    //$('#expandableArea').hide();
                    //showDetailsArea();

                    //prevent submit on enter keypress
                    $(window).keydown(function (event) {
                        if (!$("#description").is(":focus")) {
                            if (event.keyCode == 13) {
                                event.preventDefault();
                                return false;
                            }
                        }
                    });

                    loadMainCategories();
                    loadDistricts();

                    var username;

                    var files;

                    var adForm;

                    var cat_main;
                    var cat_sub;

                    var district;
                    var city;

                    var priceVal;
                    var voiceVal;

                    function loadDistricts() {
                        var dis = $('#locationDistrict');

                        $.ajax({
                            type: "POST",
                            url: "Ajax_getAllLocations",
                            dataType: "json",
                            success: function (data, textStatus, jqXHR) {
                                var locations = data.allLocations;
                                var items = null;

                                for (var x = 0; x < locations.length; x++) {
                                    var location = locations[x];

                                    items += "<option value='" + location[0] + "'>" + location[0] + "</option>";

                                    if (x === 0) {
                                        district = location[0];
                                    }
                                }

                                dis.html(items);
                            },
                            error: function (jqXHR, textStatus, errorThrown) {

                            },
                            complete: function (jqXHR, textStatus) {
                                loadCities();
                            }
                        });
                    }

                    function loadCities() {
                        var cit = $('#locationCity');

                        $.ajax({
                            type: "POST",
                            url: "Ajax_getAllLocations",
                            dataType: "json",
                            success: function (data, textStatus, jqXHR) {
                                var locations = data.allLocations;
                                var items = null;

                                for (var x = 0; x < locations.length; x++) {
                                    if (locations[x][0] === district) {
                                        var cities = locations[x][1];

                                        for (var y = 0; y < cities.length; y++) {
                                            items += "<option value='" + cities[y] + "'>" + cities[y] + "</option>";
                                        }
                                    }
                                }

                                cit.html(items);
                            },
                            error: function (jqXHR, textStatus, errorThrown) {

                            },
                            complete: function (jqXHR, textStatus) {

                            }
                        });
                    }

                    function loadMainCategories() {
                        var m_cat = $('#categoryMain');

                        $.ajax({
                            type: "POST",
                            url: "Ajax_getAllCategories",
                            dataType: "json",
                            success: function (data, textStatus, jqXHR) {
                                var categories = data.allCategories;
                                var items = null;

                                for (var x = 0; x < categories.length; x++) {
                                    var category = categories[x];

                                    items += "<option value='" + category[0] + "'>" + category[0] + "</option>";

                                    if (x === 0) {
                                        cat_main = category[0];
                                    }
                                }

                                m_cat.html(items);
                            },
                            error: function (jqXHR, textStatus, errorThrown) {

                            },
                            complete: function (jqXHR, textStatus) {
                                loadSubCategories();
                            }
                        });
                    }

                    function loadSubCategories() {
                        var s_cat = $('#categorySub');

                        $.ajax({
                            type: "POST",
                            url: "Ajax_getAllCategories",
                            dataType: "json",
                            success: function (data, textStatus, jqXHR) {
                                var categories = data.allCategories;
                                var items = null;

                                for (var x = 0; x < categories.length; x++) {
                                    if (categories[x][0] === cat_main) {
                                        var sub_cats = categories[x][1];

                                        for (var y = 0; y < sub_cats.length; y++) {
                                            items += "<option value='" + sub_cats[y] + "'>" + sub_cats[y] + "</option>";
                                        }
                                    }
                                }

                                s_cat.html(items);
                            },
                            error: function (jqXHR, textStatus, errorThrown) {

                            },
                            complete: function (jqXHR, textStatus) {

                            }
                        });
                    }

                    //detects the changes of radio buttons
                    $("input[type=radio]").on("click", function () {
                        adForm = $('input[name="adType"]:checked', '#createAd').val();
                    });
                    //wirites selection of adType radio button on load
                    if ($("input:radio[name='adType']").is(":checked")) {
                        adForm = $('input[name="adType"]:checked', '#createAd').val();
                    }
                    //loads sub categories on main categoriy change
                    $('#categoryMain').change(function () {
                        cat_main = $('#categoryMain').val();
                        loadSubCategories();
                    });
                    // writes global variable when sub category changes
                    $('#categorySub').change(function () {
                        cat_sub = $('#categorySub').val();
                    });
                    //loads cities on district change
                    $('#locationDistrict').change(function () {
                        district = $('#locationDistrict').val();
                        loadCities();
                    });
                    //
                    $('#locationCity').change(function () {
                        city = $('#locationCity').val();
                    });
                    //voice validation
                    $("#voice").change(function () {
                        var voice = $("#voice");
                        var voiceMsg = $("#voice").next();

                        if (voice.val().length < 10 && voice.val().length > 0) {
                            //note the error                            
                            voiceMsg.text("Invalid Phone Number, Please enter 10 digit Number.");
                            voiceMsg.css("color", "red");
                            voiceVal = false;
                        } else if (voice.val().length < 1) {
                            voiceMsg.text("You must enter a phone number, Please enter 10 digit Number.");
                            voiceMsg.css("color", "red");
                            voiceVal = false;
                        } else {
                            voiceMsg.text("");
                            voiceVal = true;
                        }

                        this.value = this.value.replace(/[^0-9]/g, '');
                        $("#voice").change();
                    });

                    $("#voice").keypress(function (e) {
                        if (isNaN(this.value + "" + String.fromCharCode(e.charCode))) {
                            return false;
                        }
                    });
                    //prevents pasting number
                    $("#voice").on('paste', function (e) {
                        e.preventDefault();
                    });

                    $("#price").change(function () {
                        var price = $("#price");
                        var priceMsg = $("#price").next();

                        if (price.val().length > 10) {
                            priceMsg.text("Invalid Price, Please enter price between 0 and 100000000 (in Rs./LKR)");
                            priceMsg.css("color", "red");
                            priceVal = false;
                        } else if (price.val().length < 1) {
                            priceMsg.text("Please enter price between 0 and 100000000 (in Rs./LKR), you must enter an approximate price even if your item is negotiable.");
                            priceMsg.css("color", "red");
                            priceVal = false;
                        } else {
                            priceMsg.text("");
                            priceVal = true;
                        }
                    });

//                    window.onbeforeunload = function () {
//                        return 'Are you sure you want to leave?';
//                    };

                    //image management
                    $("#images").bind('change', function () {
                        readURL(this);
                    });

                    function readURL(input) {
                        var fileItems = input.files.length;
                        var mismatches = 0;

                        var preview = $("#previewbar");

                        //preview.slideToggle();
                        preview.hide();

                        preview.html("");
                        preview.append("<hr>");

                        if (fileItems > 0 && fileItems < 6) {
                            if (fileItems > 5) {
                                fileItems = 5;
                            }

                            for (var y = 0; y < fileItems; y++) {
                                var type = input.files[y].type.toString();
                                var size = ((input.files[y].size / 1024) / 1024).toFixed(2);
                                var name = input.files[y].name;
                                var info = size + "MB, " + name + ", " + input.files[y].type;

                                //alert(info);
                                if (type !== 'image/jpeg' || size > 2) {
                                    mismatches++;
                                } else {

                                    var imageName = "image" + y; //html id
                                    var imageId = "#" + imageName; //jquery id

                                    var number = imageName.substring(5, 6);

                                    if (number < 1) {
                                        number = "Main Image";
                                    } else {
                                        number = "Image " + (++number);
                                    }

                                    var imgObj = "<img id=" + imageName + " class='img img-responsive img-thumbnail' alt='" + number + "' data-toggle='tooltip' data-placement='top' title='This will be " + number + "'/><p style='color:red;font-weight:bold;'>" + number + "</p>";
                                    $(imgObj).appendTo(preview);

                                    addImage(imageId, input.files[y]);
                                }
                            }

                            preview.append("<hr><div style='border:solid 2px black;' class='alert alert-success' role='alert'><span class='glyphicon glyphicon-exclamation-sign'></span> Done, Image(s) Selected!</div>");
                            files = true;

                            preview.append("<hr>");

                            if (mismatches > 0) {
                                preview.html("<div class='alert alert-danger' role='alert'><span class='glyphicon glyphicon-exclamation-sign'></span> Selected image(s) didn't meet following standards, PLEASE RE-SELECT IMAGES!</div>");

                                files = false;
                                $('#images').val(null);
                            } else {
                                files = true;
                            }
                        } else if (fileItems > 5) {
                            preview.html("<div class='alert alert-danger' role='alert'><span class='glyphicon glyphicon-exclamation-sign'></span> You selected more than 5 images, PLEASE READ THE NOTE!</div>");
                            files = false;
                        } else {
                            preview.html("<div class='alert alert-danger' role='alert'><span class='glyphicon glyphicon-exclamation-sign'></span> You must select at least 1 image, PLEASE READ THE NOTE!</div>");
                            files = false;
                        }

                        preview.slideToggle();
                        //preview.show();
                    }

                    function addImage(imageId, file) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            $(imageId).attr('src', e.target.result);
                        };
                        reader.readAsDataURL(file);
                    }

//                    $('#createAd').submit(function (e) {
//
//                    });

//                    $('#createAd input').on('change', function () {
//                       alert($('input[name="adType"]:checked', '#createAd').val());
//                    });


                    //form submit
                    $('#check').click(function () {
                        //$("#submit").click();
                        $('#createAdConfirm').modal('toggle');
                        var checksum = 0;
                        var list = $('#model-checklist');
                        var submit = $('#submit');

                        list.html("");

                        //examples
                        //$(alertComplete("Images")).appendTo(list).hide().slideDown("slow");
                        //$(alertIncomplete("Price")).appendTo(list).hide().slideDown("slow");

                        //checking user
                        $.ajax({
                            type: "POST",
                            url: "Ajax_checkLoginSessions",
                            dataType: "json",
                            success: function (data, textStatus, jqXHR) {
                                if (data.login !== null) {
                                    username = true;
                                } else {
                                    username = false;
                                }
                            },
                            complete: function (jqXHR, textStatus) {

                                if (username) {
                                    //$(alertComplete("Login Success!")).appendTo(list).hide().slideDown("slow");
                                } else {
                                    var link = "<a href='SignProcess.jsp' id='loginRequested' target='_blank' class='pull-right'>Login</a>";
                                    $(alertIncomplete("Login Required!" + link)).appendTo(list).hide().slideDown("slow");
                                    checksum++;

                                    $("#loginRequested").click(function () {
                                        $('#createAdConfirm').modal('toggle');
                                    });
                                }
                                //checking adForm
                                if (adForm !== null) {
                                    //$(alertComplete("Ad Type Selected!")).appendTo(list).hide().slideDown("slow");
                                } else {
                                    $(alertIncomplete("Select Ad Type!")).appendTo(list).hide().slideDown("slow");
                                    checksum++;
                                }
                                //checking category
                                if (cat_main !== null && cat_sub !== null) {
                                    //$(alertComplete("Category Selected!")).appendTo(list).hide().slideDown("slow");
                                } else {
                                    $(alertIncomplete("Select Category!")).appendTo(list).hide().slideDown("slow");
                                    checksum++;
                                }
                                //checking location
                                if (district !== null && city !== null) {
                                    //$(alertComplete("Location Selected!")).appendTo(list).hide().slideDown("slow");
                                } else {
                                    $(alertIncomplete("Select Location!")).appendTo(list).hide().slideDown("slow");
                                    checksum++;
                                }
                                //checking images
                                checkImg();

                                if (files) {
                                    //$(alertComplete("Images Selected!")).appendTo(list).hide().slideDown("slow");
                                } else {
                                    $(alertIncomplete("Select Images!")).appendTo(list).hide().slideDown("slow");
                                    checksum++;
                                }
                                //checking title
                                if ($('#title').val().length > 0) {
                                    //$(alertComplete("Title Added!")).appendTo(list).hide().slideDown("slow");
                                } else {
                                    $(alertIncomplete("Add Title!")).appendTo(list).hide().slideDown("slow");
                                    checksum++;
                                }
                                //checking description
                                if ($('#description').val().length > 0) {
                                    //$(alertComplete("Description Added!")).appendTo(list).hide().slideDown("slow");
                                } else {
                                    $(alertIncomplete("Add Description!")).appendTo(list).hide().slideDown("slow");
                                    checksum++;
                                }
                                //checking price
                                if ($('#price').val().length > 0 && $('#price').val().length < 10) {
                                    //$(alertComplete("Price Added!")).appendTo(list).hide().slideDown("slow");
                                } else {
                                    $(alertIncomplete("Add Price!")).appendTo(list).hide().slideDown("slow");
                                    checksum++;
                                }
                                //checking voice
                                if ($('#voice').val().length === 10 && $('#voice').val().length > 0) {
                                    //$(alertComplete("Contact Number Added!")).appendTo(list).hide().slideDown("slow");
                                } else {
                                    $(alertIncomplete("Add Contact Number!")).appendTo(list).hide().slideDown("slow");
                                    checksum++;
                                }
                                if (username && adForm !== null && cat_main !== null && cat_sub !== null && district !== null && city !== null && files && $('#title').val().length > 0 && $('#description').val().length > 0 && $('#price').val().length > 0 && $('#price').val().length < 10 && $('#voice').val().length === 10 && $('#voice').val().length > 0) {
                                    $(alertComplete("All fields completed!")).appendTo(list).hide().slideDown("slow");
                                }

                                if (checksum === 0) {
                                    submit.removeClass('disabled');
                                } else {
                                    submit.addClass('disabled');
                                }
                            }
                        });
                    });

                    function checkImg() {
                        $('input[type=file]').each(function (index, value) {
                            if ($(this).val() === "" || $(this).val() === null) {
                                $(this).parent().remove();
                            }
                        });

                        if ($("input[type=file]").length > 0) {
                            files = true;
                        } else {
                            files = false;
                        }
                    }

                    function alertIncomplete(msg) {
                        var obj = "<div class='alert alert-danger alert-no-margin small'><span class='glyphicon glyphicon-remove'></span> " + msg + "</div>";
                        return obj;
                    }
                    function alertComplete(msg) {
                        var obj = "<div class='alert alert-success alert-no-margin small'><span class='glyphicon glyphicon-ok'></span> " + msg + "</div>";
                        return obj;
                    }

                    $(".checklist").click(function () {
                        $(this).addClass('disabled');
                    });

                    //remove HTML content
                    $('input,textarea').change(function () {
                        //check title
                        $("#html-fix").html("");

                        $("#html-fix").html($("#title").val());
                        var o_title = $("#html-fix").text();
                        o_title = o_title.replace(/">/igm, '');
                        $("#title").val(o_title);

                        //check decription
                        $("#html-fix").html("");

                        $("#html-fix").html($("#description").val());
                        var o_desc = $("#html-fix").text();
                        o_desc = o_desc.replace(/">/igm, '');
                        $("#description").val(o_desc);
                    });
                });
            </script>

        </head>

        <body class="container-fluid">

        <jsp:include page="navbar.jsp"></jsp:include>       

            <form id="createAd" name="createAdForm" action="PostAd" method="POST" enctype="multipart/form-data">

                <!-- test -->
                <div class="row-fluid text-left" style="margin: 15px;"><!-- first section -->

                    <div class="col-lg-4 custom-padding custom-design">

                        <!-- Advertisement Type -->
                        <div>                        
                            Advertisement Type Selector
                            <img style="display: inline-block;" class="img-circle img-responsive" width="15" height="15" src="media/images/Other Icons/Help Documentation.png" data-toggle="popover" data-placement="bottom" title="Advertisement Type Selector" data-content="Specify the type of your advertisment."/>
                            <hr>
                        </div>
                        <div class="col"><!--custom-design--><!-- Advertisement Type: Content -->
                            <fieldset>

                                <!-- Multiple Radios -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="adType">Item is, </label>
                                    <div class="col-md-4">
                                        <div class="radio">
                                            <label for="adType-0">
                                                <input type="radio" name="adType" id="adType-0" value="For Sale" required="" checked="checked">
                                                For Sale
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label for="adType-1">
                                                <input type="radio" name="adType" id="adType-1" value="For Rent" required="">
                                                For Rent
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label for="adType-2">
                                                <input type="radio" name="adType" id="adType-2" value="Wanted" required="">
                                                Wanted
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>

                        </div><!-- end of Advertisement Type: Content -->

                    </div>
                    <div class="col-lg-4 custom-padding custom-design">

                        <!-- Category -->
                        <div>                        
                            Category Selector
                            <img style="display: inline-block;" class="img-circle img-responsive" width="15" height="15" src="media/images/Other Icons/Help Documentation.png" data-toggle="popover" data-placement="bottom" title="Category Selector" data-content="Specify the Main and Sub categories of the item."/>
                            <hr>
                        </div>

                        <div class="col"><!--custom-design-->

                            <fieldset>

                                <!-- Select Basic -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="categoryMain">Main Category</label>
                                    <div class="col-md-8">
                                        <select required="" id="categoryMain" name="categoryMain" class="form-control">
                                            <!--<option value="Not Selected">-- Select --</option>-->
                                        </select>
                                    </div>
                                </div>

                                <div><br><br></div>

                                <!-- Select Basic -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="categorySub">Sub Category</label>
                                    <div class="col-md-8">
                                        <select id="categorySub" name="categorySub" class="form-control">
                                            <!--<option value="Not Selected">-- Select --</option>-->
                                        </select>
                                    </div>
                                </div>

                            </fieldset>

                        </div>

                    </div>
                    <div class="col-lg-4 custom-padding custom-design">

                        <!-- Location -->
                        <div>                        
                            Location Selector
                            <img style="display: inline-block;" class="img-circle img-responsive" width="15" height="15" src="media/images/Other Icons/Help Documentation.png" data-toggle="popover" data-placement="bottom" title="Location Selector" data-content="Specify the District and City."/>
                            <hr>
                        </div>

                        <div class="col"><!--custom-design-->

                            <fieldset>

                                <!-- Select Basic -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="locationDistrict">District</label>
                                    <div class="col-md-8">
                                        <select id="locationDistrict" name="locationDistrict" class="form-control">
                                            <!--<option value="Not Selected">-- Select --</option>-->
                                        </select>
                                    </div>
                                </div>

                                <div><br><br></div>

                                <!-- Select Basic -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="locationCity">City</label>
                                    <div class="col-md-8">
                                        <select id="locationCity" name="locationCity" class="form-control">
                                            <!--<option value="Not Selected">-- Select --</option>-->
                                        </select>
                                    </div>
                                </div>

                            </fieldset>

                        </div>

                    </div>
                </div> <!-- end of first section -->

                <br>

                <div id="expandableArea">

                    <div class="row-fluid text-left" style="margin: 15px;"> <!-- second section -->                 

                        <div class="col-lg-12 custom-padding">
                            <!-- Images -->
                            <div>                        
                                Image Upload
                                <!--<img style="display: inline-block;" class="img-circle img-responsive" width="15" height="15" src="media/images/Other Icons/Help Documentation.png"/>-->
                                <hr>
                            </div>

                            <div class="col custom-design">

                                <div class="row">
                                    <center>
                                        <div class="container">

                                            <div id="guide">                                                    
                                                <blockquote style='text-align: left; font-size: small; border-left: solid 5px red; background-color: #cccccc; border-radius: 10px; opacity: 0.95;'>
                                                    <b>Note:</b>
                                                    <ul>
                                                        <!--<li>Select multiple files once</li>-->
                                                        <li>Maximum images you can add is 5.</li>
                                                        <li>First image will be the cover image, it will shown with a black border.</li>                                                        
                                                    </ul>

                                                    <b>Standards:</b>
                                                    <ul>                                                            
                                                        <li>Select image file(s) in JPG/JPEG format</li>
                                                        <li>Maximum recommended size of an image is 2.00MB, Higher sizes are not eligible to upload</li>
                                                    </ul>
                                                </blockquote>                                                    
                                            </div>

                                            <div id="fileInputArea" style="background-color: rgba(0, 0, 0, 0.05);border-radius: 10px; padding: 10px 10px 5px 10px;">
                                                <!--                                                <div>
                                                                                                    <label class="custom-file-input btn btn-block" style="height: 50px;">
                                                                                                        <input id="images" type="file" accept=".jpg,.jpeg,.png"  name="files" class="" multiple="" required=""/>                                                        
                                                                                                    </label>
                                                                                                </div>
                                                
                                                                                                <div id="previewbar" class="row text-center" style="display: inline-block;padding-bottom: 5px;">
                                                                                                    <hr>
                                                                                                    <img class="img img-responsive img-thumbnail" src="" data-toggle="tooltip" data-placement="top" title="Cover Image" alt="cover image"/>
                                                                                                    <hr>
                                                                                                </div>-->

                                            <jsp:include page="newAd_uploader.jsp"></jsp:include>

                                            </div>



                                        </div>
                                    </center>
                                </div>

                            </div>
                        </div>

                    </div> <!-- end of second section --> 

                    <br>

                    <div class="row-fluid text-left" style="margin: 15px;"> <!-- third section -->                 

                        <div class="col-lg-12 custom-padding">
                            <!-- Main Information -->
                            <div>                        
                                Main Information
                                <img style="display: inline-block;" class="img-circle img-responsive" width="15" height="15" src="media/images/Other Icons/Help Documentation.png" data-toggle="popover" data-placement="bottom" title="Main information" data-content="Specify main information of the advertistment."/>
                                <hr>
                            </div>

                            <div class="col custom-design">

                                <fieldset>

                                    <!-- Title-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="title">Title</label>  
                                        <div class="col-md-10">
                                            <input id="title" name="title" type="text" maxlength="255" placeholder="Title of the advertisement " class="form-control input-md" required="">
                                            <span class="help-block"> </span>
                                        </div>
                                    </div>

                                    <br>

                                    <!-- Description -->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="description">Description</label>
                                        <div class="col-md-10">                     
                                            <textarea class="form-control" required="" id="description" name="description" placeholder="Item Description" style="resize: vertical; max-height: 250px;min-height: 100px;"></textarea>
                                            <span class="help-block"> </span>
                                        </div>
                                    </div>

                                    <br>

                                    <!-- Item Price-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="price">Price</label>  
                                        <div class="col-md-10">
                                            <input id="price" name="price" type="number" placeholder="Price of the item" class="form-control input-md" required="" min="0" max="100000000" maxlength="10">
                                            <span class="help-block"> </span>  
                                        </div>                                  
                                    </div>

                                    <br>

                                    <!-- Select Basic -->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="negotiable">Negotiable</label>
                                        <div class="col-md-10">
                                            <select id="negotiable" name="negotiable" class="form-control">
                                                <option selected="" value="No">No - Not Negotiable</option>
                                                <option value="Yes">Yes - Negotiable</option>
                                            </select>
                                        </div>
                                    </div>

                                    <br>

                                    <!-- Mobile Number-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="voice">Mobile Number</label>  
                                        <div class="col-md-10">
                                            <input id="voice" name="voice" type="text" maxlength="10" placeholder="Enter 10 Digit Mobile Number" class="form-control input-md" required="" >
                                            <span class="help-block"></span>  
                                        </div>
                                    </div>

                                </fieldset>

                            </div>
                        </div>

                    </div> <!-- end of third section --> 

                </div>

                <div class="row-fluid" style="margin: 15px;"> <!-- fourth section -->


                    <div class="col-lg-12"><!--custom-design-->
                        <!-- Reset Button -->
                        <div class="btn-group btn-group-justified" role="group">
                            <div class="btn-group btn-group-lg" role="group">
                                <button type="reset" class="btn btn-danger">Reset Fields</button>
                            </div>
                            <div class="btn-group btn-group-lg" role="group">
                                <button type="button" id='check' class="btn btn-primary">Post AD</button>
                                <!--<button type="submit" id="submit" class="btn btn-primary hidden disabled">Submit</button>-->
                            </div>
                        </div>
                    </div>

                </div> <!-- end of fourth section -->

                <div class="row-fluid">
                    <div class="col-lg-12">
                        <br>
                        <br>
                        <br>
                    </div>
                </div>

                <!-- Small modal -->  
                <div id="createAdConfirm" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content" style="padding: 3px;border:solid 2px black;">
                            <div id="modelHead" class="modal-header">
                                Complete Requirements
                                <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            </div>

                            <div id="model-checklist" style="padding: 5px;">
                                <!--<div class="alert alert-danger alert-no-margin small"><span class="glyphicon glyphicon-remove"></span> Category</div>
                                <div class="alert alert-success alert-no-margin small"><span class="glyphicon glyphicon-ok"></span> Images</div>-->
                            </div>

                            <div class="modal-footer">
                                <button type="submit" id="submit" class="btn btn-info btn-block disabled checklist">Submit</button>
                            </div>                          

                        </div>

                    </div>
                </div>

            </form>

            <div id="html-fix" class="hidden">
            </div>

        <jsp:include page="footer.jsp"></jsp:include>
        </body>

        <a id="popupLogin" data-toggle="modal" class="hidden" data-target="#login_model" href="">
            <b>Log In</b>
        </a>

    </html>

<jsp:include page="model_login.jsp"></jsp:include>