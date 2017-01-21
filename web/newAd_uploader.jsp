<%-- 
    Document   : newAd_uploader
    Created on : Jul 30, 2016, 11:03:11 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Uploader</title>

        <style>
            .mainImageShadow{
                box-shadow: inset 0px 0px 10px 1px gray;
                border: double 5px black;
            }
            .imager{
                padding: 10px;
                border-radius: 10px;
                background: #F1F1F1;
                width: auto;
                margin: 10px;
            }
            .imager>img{
                max-height: 300px;
                //max-width: 150px;
                margin-top: 10px; 
            }
            #newFileElement{
                -webkit-animation: neon1 1s ease-in-out infinite alternate;
                -moz-animation: neon1 1s ease-in-out infinite alternate;
                animation: neon1 1s ease-in-out infinite alternate;
            }

            @-moz-keyframes neon1 {
                from {
                    box-shadow: 0 0 0px #fff, 0 0 1px #fff, 0 0 3px #fff, 0 0 5px #228DFF, 0 0 5px #228DFF, 0 0 7px #228DFF, 0 0 9px #228DFF, 0 0 11px #228DFF;
                }
                to {
                    box-shadow: 0 0 5px #fff, 0 0 4px #fff, 0 0 3px #fff, 0 0 2px #228DFF, 0 0 1px #228DFF, 0 0 0px #228DFF, 0 0 0px #228DFF, 0 0 0px #228DFF;
                }
            }

            @keyframes neon1 {
                from {
                    box-shadow: 0 0 0px #fff, 0 0 1px #fff, 0 0 2px #fff, 0 0 3px #228DFF, 0 0 5px #228DFF, 0 0 8px #228DFF, 0 0 12px #228DFF, 0 0 17px #228DFF;
                }
                to {
                    box-shadow: 0 0 16px #fff, 0 0 14px #fff, 0 0 12px #fff, 0 0 10px #228DFF, 0 0 10px #228DFF, 0 0 8px #228DFF, 0 0 6px #228DFF, 0 0 4px #228DFF,, 0 0 2px #228DFF;
                }
            }
        </style>

        <script>
            $(document).ready(function () {
                //temp
                $("#plus").click(function () {
                    ++uploaded;
                });

                $("#min").click(function () {
                    --uploaded;
                });
                //temp

                var idcode = 0;
                var uploaded = 0;
                var currentImages = 0;
                var all = uploaded + currentImages;
                var maxImages = 5;

                setInterval(function () {
                    if (uploaded < 0) {
                        uploaded = 0;
                    } else if (uploaded > 5) {
                        uploaded = 5;
                    }

                    currentImages = $("input[type=file]").length;
                    all = uploaded + currentImages;

                    if (maxImages === all) {
                        $("#newFileElement").hide();
                    } else {
                        $("#newFileElement").show();
                    }

                    $('input[type=file]').each(function (index, value) {
                        $(this).attr('imgid', uploaded + (++index));

                        if ($(this).attr('imgid') === "1") {
                            $(this).parent().addClass('mainImageShadow');
                            $(this).parent().attr('title', 'Main Image');
                        } else {
                            $(this).parent().removeClass('mainImageShadow');
                            $(this).parent().attr('title', 'Image ' + (uploaded + index));
                        }
                    });

                    //console.log("all:" + all + "/current:" + currentImages + "/uploaded:" + uploaded);

                }, 1);

                $("#newFileElement").click(function () {
                    $('input[type=file]').each(function (index, value) {
                        if ($(this).val() === "" || $(this).val() === null) {
                            $(this).parent().remove();
                            currentImages--;
                        }
                    });

                    if (currentImages < (maxImages - uploaded)) {
                        currentImages++;
                        $(this).before(buildInputElement());

                        if (currentImages === (maxImages - uploaded)) {
                            $(this).hide();
                        }

                        $('input[type=file]:last').click();

                    } else {
                        alert('Maximum allowed number of images is 5, please remove some of images to add new..');
                    }
                });

                $(document).on('click', '.removeimg', function () {
                    $(this).parent().remove();
                    currentImages--;

                    if (currentImages !== (maxImages - uploaded)) {
                        $("#newFileElement").show();
                    }

                    renameImages();
                });

                function buildInputElement() {
                    idcode++;
                    var elem = "<div class='imager'><span data-toggle='tooltip' data-placement='right' title='Remove' class='glyphicon glyphicon-remove removeimg' style='background:red;border:solid 2px white;box-shadow:0px 0px 10px 1px red;border-radius:50px;color:white;padding: 5px; margin:5px; cursor: pointer;'></span> <input class='image-file-input' style='max-width: 95px; display:inline-block' type='file' name='image" + currentImages + "' id='image" + idcode + "' imgid='" + currentImages++ + "'/><br></div>";
                    currentImages--;
                    return elem;
                }

                function renameImages() {
                    $('input[type=file]').each(function (index, value) {
                        if ($(this).val() === "" || $(this).val() === null) {
                            $(this).parent().remove();
                            currentImages--;
                        }
                    });

                    var temp = currentImages;

                    $('input[type=file]').each(function (index, value) {
                        $(this).attr('imgid', currentImages);
                        currentImages++;
                    });

                    currentImages = temp;
                }

                $(document).on('change', 'input[type=file]', function (e) {
                    var id = $(this).attr('id');

                    if ($(this).val() !== "") {
                        readURL(this, id);
                        $(this).next().next().remove();
                        $(this).next().next().remove();
                        $(this).next().after("<img class='img-responsive img-thumbnail " + id + "' style='' src='#' alt='Selected Image'/><br>").show('slow');
                    } else {
                        $(this).parent().remove();
                        alert("No images selected!");
                        //remove other empty input file elements
                        $('input[type=file]').each(function (index, value) {
                            if ($(this).val() === "" || $(this).val() === null) {
                                $(this).parent().remove();
                                currentImages--;
                            }
                        });
                    }
                });

                function readURL(input, id) {
                    //alert(id);
                    var file = input.files[0];

                    var type = file.type.toString();
                    var size = ((file.size / 1024) / 1024).toFixed(2);
                    var name = file.name;
                    var info = size + "MB, " + name + ", " + file.type;

                    if (type !== 'image/jpeg' || size > 2) {
                        id = "#" + id;
                        $(id).parent().remove();
                        alert('Invalid File!');
                    } else {
                        addImage(id, file);
                    }
                }

                function addImage(imageId, file) {
                    imageId = "." + imageId;
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(imageId).attr('src', e.target.result);
                    };
                    reader.readAsDataURL(file);
                }

                function initUploader() {
                    renameImages();
                    all = uploaded + currentImages;
                    //alert(all + "," + uploaded + "," + currentImages);
                }
            });
        </script>

    </head>
    <body style="font-family: calibri;">
        <!--<div id="uploader">-->

        <!--<input id="plus" class="plus" type="button" value="+" />-->
        <!--<input id="min" class="min" type="button" value="-" />-->

        <!--<form name="photos" id="photos" method="POST" action="newAd_uploader" enctype="multipart/form-data">-->
    <center>                    
        <input id="newFileElement" style="padding: 5px;border-radius: 5px;background: #00cccc; margin: 10px;" type="button" value="Add New Image"/>
    </center>

    <!--<hr>-->
    <!--<input type="submit" value="Submit" />-->
    <!--</form>-->
</div>
</body>
</html>
