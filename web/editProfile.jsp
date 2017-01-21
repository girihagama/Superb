<%-- 
    Document   : editProfile
    Created on : May 29, 2016, 10:55:54 PM
    Author     : Indunil
--%>

<%@page import="classes.ConvertTimeStamp"%>
<%@page import="java.util.List"%>
<%
    List profile = (List) request.getAttribute("editProfile");

    if (profile.get(3) == null) {
        profile.set(3, "N/A");
    }
    profile.set(4, new ConvertTimeStamp().timeStampIn12h(profile.get(4).toString()).substring(0, 10));
    profile.set(5, new ConvertTimeStamp().timeStampIn12h(profile.get(5).toString()));
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Profile</title>
        <meta name="description" content="Buy and sell everything from Superb.lk. Did you know that Superb.lk has the best mobile deals in Sri Lanka? Visit Superb.lk and Search all of Sri Lanka.">
        <meta property="og:url" content="http://superb.lk/web">
        <meta property="og:site_name" content="Superb.lk">
        <meta property="og:title" content="Superb.lk - Edit Profile">
        <meta property="og:description" content="Buy and sell everything from Superb.lk. Did you know that Superb.lk has the best mobile deals in Sri Lanka? Visit Superb.lk and Search all of Sri Lanka.">
        <meta property="og:image" content="http://superb.lk/ng-admin/images/facebook-opengraph.png"/>
        <jsp:include page="BootstrapHeader.jsp"></jsp:include>

            <style>
                body{
                    background-image:url(media/backgrounds/page_background_1.jpg);
                }
            </style>

            <script>
                $(document).ready(function () {
                    $("#change-un").click(function () {
                        $("#change-un-menu").click();
                    });
                    $("#change-em").click(function () {
                        $("#change-em-menu").click();
                    });
                    $("#change-cn").click(function () {
                        $("#change-cn-menu").click();
                    });

                    $("#form-update-contact-number").submit(function (e) {
                        var help = $("#update-contact-number-help");
                        help.text("");

                        var number = $("#form-update-contact-number-contact").val();
                        var number_val = $("#form-update-contact-number-contact").val().length;

                        if (number_val > 10) {
                            help.text('* Number Must Not Exceed 10 Digits! (eg: 07XXXXXXXX)');
                            e.preventDefault();
                        } else if (number_val < 10 && number_val > 0) {
                            help.text('* Number Must Be 10 Digits! (eg: 07XXXXXXXX)');
                            e.preventDefault();
                        } else {
                            if (!confirm("Confirm Action?")) {
                                e.preventDefault();
                            }
                        }
                    });

                    $("#form-update-password").submit(function (e) {
                        var p0 = $("#password-old").val().length;
                        var p0help = $("#password-old-help");

                        if (p0 < 8) {
                            e.preventDefault();
                            p0help.text("* 8 Alphanumeric Characters Required!");
                        } else {
                            p0help.text("");
                        }

                        var p1help = $("#password-new-1-help");
                        var p2help = $("#password-new-2-help");
                        p1help.text("");
                        p2help.text("");

                        var p1 = $("#password-new-1").val();
                        var p2 = $("#password-new-2").val();

                        if (p1.length < 8) {
                            e.preventDefault();
                            p1help.text("* 8 Alphanumeric Characters Required!");
                        } else if (p2.length < 8) {
                            e.preventDefault();
                            p2help.text("* 8 Alphanumeric Characters Required!");
                        } else if (p1 !== p2) {
                            e.preventDefault();
                            p1help.text("* Password Mismatch!");
                            p2help.text("* Password Mismatch!");
                        }

                        if (!confirm("Confirm Action?")) {
                            e.preventDefault();
                        }
                    });

                    $("#password-old").keyup(function () {
                        var p0 = $("#password-old").val().length;
                        var p0help = $("#password-old-help");

                        if (p0 < 8) {
                            p0help.text("* 8 Alphanumeric Characters Required!");
                        } else {
                            p0help.text("");
                        }
                    });

                    $("#password-new-1").keyup(function () {
                        var p1help = $("#password-new-1-help");
                        var p2help = $("#password-new-2-help");
                        p1help.text("");
                        p2help.text("");

                        var p1 = $("#password-new-1").val();
                        var p2 = $("#password-new-2").val();

                        if (p1.length === 0 || p2.length === 0) {
                            p1help.text("");
                            p2help.text("");
                        } else if (p1.length < 8) {
                            p1help.text("* 8 Alphanumeric Characters Required!");
                        } else {
                            if (p1 !== p2) {
                                p2help.text("* Password Mismatch!");
                            }
                        }
                    });

                    $("#password-new-2").keyup(function () {
                        var p1help = $("#password-new-1-help");
                        var p2help = $("#password-new-2-help");
                        p1help.text("");
                        p2help.text("");

                        var p1 = $("#password-new-1").val();
                        var p2 = $("#password-new-2").val();

                        if (p1.length === 0 || p2.length === 0) {
                            p1help.text("");
                            p2help.text("");
                        } else if (p2.length < 8) {
                            p2help.text("* 8 Alphanumeric Characters Required!");
                        } else {
                            if (p1 !== p2) {
                                p1help.text("* Password Mismatch!");
                            }
                        }
                    });

                    $("#form-update-contact-number-contact").keypress(function (e) {
                        //if the letter is not digit don't type anything
                        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                            return false;
                        }

                        var tval = $('#form-update-contact-number-contact').val(),
                                tlength = tval.length,
                                set = 10,
                                remain = parseInt(set - tlength);
                        if (remain <= 0 && e.which !== 0 && e.charCode !== 0) {
                            return false
                        }
                    });

                    $("#form-update-contact-number-contact").change(function () {
                        $("#form-update-contact-number-contact").trigger('keyup');
                    });
                });
            </script>
        </head>

        <body class="container-fluid">

        <jsp:include page="navbar.jsp"></jsp:include>

            <div class="row-fluid">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12">

                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <center><span class="glyphicon glyphicon-list-alt"></span> <span class="panel-title" style="font-weight: bold;color: navy;">Profile Overview</span></center>
                                </div>
                                <div class="panel-body">

                                    <fieldset>
                                        <!-- Text input-->
                                        <div class="form-group">
                                            <label class="col-md-2 control-label" for="">Username:</label>  
                                            <div class="col-md-10">
                                                <input type="text" value="<%= profile.get(0)%>" class="form-control input-md" readonly="" style="background: white; border: none; box-shadow: none; cursor: none;">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="">Account Type:</label>  
                                        <div class="col-md-10">
                                            <input type="text" value="<%= profile.get(1)%>" class="form-control input-md" readonly="" style="background: white; border: none; box-shadow: none; cursor: none;">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="">Email:</label>  
                                        <div class="col-md-10">
                                            <input type="text" value="<%= profile.get(2)%>" class="form-control input-md" readonly="" style="background: white; border: none; box-shadow: none; cursor: none;">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for=""><a id="change-cn" href="#panel-813020">Contact Number:</a></label>  
                                        <div class="col-md-10">
                                            <input type="text" value="<%= profile.get(3)%>" class="form-control input-md" readonly="" style="background: white; border: none; box-shadow: none; cursor: none;">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="">Member Since:</label>  
                                        <div class="col-md-10">
                                            <input type="text" value="<%= profile.get(4)%>" class="form-control input-md" readonly="" style="background: white; border: none; box-shadow: none; cursor: none;">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="">Last Login:</label>  
                                        <div class="col-md-10">
                                            <input type="text" value="<%= profile.get(5)%>" class="form-control input-md" readonly="" style="background: white; border: none; box-shadow: none; cursor: none;">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="">Current Ads:</label>  
                                        <div class="col-md-10">
                                            <input type="text" value="<%= profile.get(6)%>" class="form-control input-md" readonly="" style="background: white; border: none; box-shadow: none; cursor: none;">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-2 control-label" for="">Chat:</label>  
                                        <div class="col-md-10">
                                            <input type="text" value="<%= profile.get(7)%>" class="form-control input-md" readonly="" style="background: white; border: none; box-shadow: none; cursor: none;">
                                        </div>
                                    </div>
                                </fieldset>

                            </div>
                        </div>

                        <!--update contact number-->
                        <div class="panel-group" id="panel-813020">                               

                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <span class="glyphicon glyphicon-earphone"></span> 
                                    <a class="panel-title" id="change-cn-menu" data-toggle="collapse" data-parent="#panel-813020" href="#panel-element-155867">Change Contact Number</a>
                                </div>
                                <div id="panel-element-155867" class="panel-collapse collapse">
                                    <div class="panel-body">

                                        <form method="POST" class="form-horizontal" id="form-update-contact-number" action="Update_Contact_Number">
                                            <fieldset>
                                                <!-- Text input-->
                                                <div class="form-group">
                                                    <label class="col-md-4 control-label" for="textinput">Contact Number: </label>  
                                                    <div class="col-md-6">
                                                        <input id="form-update-contact-number-contact" name="contactNumber" type="number" placeholder="Enter 10 digit number" class="form-control input-md" value="<%if(!profile.get(3).equals("N/A")){%><%= profile.get(3)%><%}%>" min="0" data-toggle="tooltip" data-placement="top" title="LEAVE EMPTY and UPDATE to REMOVE NUMBER!">
                                                        <span class="help-block" id="update-contact-number-help" style="color: red;"></span>  
                                                    </div>
                                                    <div class="col-md-2">
                                                        <button type="submit" class="btn btn-primary btn-block">Update</button>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </form>

                                    </div>
                                </div>
                            </div>

                            <!--update password-->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <span class="glyphicon glyphicon-lock"></span> 
                                    <a class="panel-title collapsed" data-toggle="collapse" data-parent="#panel-813020" href="#panel-element-100868">Change Password</a>
                                </div>
                                <div id="panel-element-100868" class="panel-collapse collapse">
                                    <div class="panel-body">

                                        <form class="form-horizontal" method="POST" id="form-update-password" action="Change_Password">
                                            <fieldset>
                                                <!-- Password input-->
                                                <div class="form-group">
                                                    <label class="col-md-4 control-label" for="passwordinput">Current Password:</label>
                                                    <div class="col-md-4">
                                                        <input required="" maxlength="30" name="oldPass" id="password-old" type="password" placeholder="Enter Old Password!" class="form-control input-md">
                                                        <span class="help-block" id="password-old-help"></span>
                                                    </div>
                                                </div>

                                                <!-- Password input-->
                                                <div class="form-group">
                                                    <label class="col-md-4 control-label" for="passwordinput">New Password:</label>
                                                    <div class="col-md-4">
                                                        <input required="" maxlength="30" name="newPass" id="password-new-1" type="password" placeholder="Enter New Password!" class="form-control input-md">
                                                        <span class="help-block" id="password-new-1-help"></span>
                                                    </div>
                                                </div>

                                                <!-- Password input-->
                                                <div class="form-group">
                                                    <label class="col-md-4 control-label" for="passwordinput">Re-Type New Password:</label>
                                                    <div class="col-md-4">
                                                        <input required="" maxlength="30" id="password-new-2" type="password" placeholder="Enter New Password Again!" class="form-control input-md">
                                                        <span class="help-block" id="password-new-2-help"></span>
                                                    </div>
                                                </div>

                                                <!-- Button -->
                                                <div class="form-group">
                                                    <label class="col-md-4 control-label" for="singlebutton"></label>
                                                    <div class="col-md-4">
                                                        <button id="singlebutton" name="singlebutton" class="btn btn-primary btn-block">Change Password</button>
                                                    </div>
                                                </div>

                                            </fieldset>
                                        </form>

                                    </div>
                                </div>
                            </div>

                            <!--                            update email
                                                        <div class="panel panel-default">
                                                            <div class="panel-heading">
                                                                <span class="glyphicon glyphicon-envelope"></span> 
                                                                <a class="panel-title collapsed" id="change-em-menu" data-toggle="collapse" data-parent="#panel-813020" href="#panel-element-100869">Change Email</a>
                                                            </div>
                            
                                                            <div id="panel-element-100869" class="panel-collapse collapse">
                                                                <div class="panel-body">
                            
                                                                </div>
                                                            </div>
                                                        </div>
                            
                                                        update username
                                                        <div class="panel panel-default">
                                                            <div class="panel-heading">
                                                                <span class="glyphicon glyphicon-user"></span> 
                                                                <a class="panel-title collapsed" id="change-un-menu" data-toggle="collapse" data-parent="#panel-813020" href="#panel-element-100870">Change Username</a>
                                                            </div>
                                                            <div id="panel-element-100870" class="panel-collapse collapse">
                                                                <div class="panel-body">
                            
                                                                </div>
                                                            </div>
                                                        </div>-->

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
