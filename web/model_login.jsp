<%-- 
    Document   : model_login
    Created on : Jul 12, 2015, 10:45:42 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="custom_styles_scripts/CSS_loading_animations.css"/>

<script type="text/javascript">
    $(document).ready(function () {
        $("#login_form").submit(function (e) {
            e.preventDefault();
            var login = $("#login").val();
            var password = $("#password").val();
            var dataString = "login=" + login + "&" + "password=" + password;
            $.ajax({
                type: "POST",
                url: "Ajax_login",
                data: dataString,
                dataType: "json",
                //if received a response from the server
                success: function (data) {

                    if (data.accountStatus === "Inactive" && data.combination) {
                        $(".login-form-enabled").addClass("hidden");
                        $(".activation-form-enabled").removeClass("hidden");


                    } else if (data.accountStatus === "Blocked") {
                        $("#login_form")[0].reset();
                        $("#loginHelp").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Your account is blocked. Please contact us through support@superb.lk for further information. Thank you !'
                                + '</div>  ');


                    } else if (data.accountStatus === "Activated") {
                        if (data.userLogin) {
                            location.reload();
                        }
                        else {
                            if (data.userExist) {
                                $("#loginHelp").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                        + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Invalid Password!'
                                        + '</div>  ');
                                $("#password").val("");
                            } else {
                                $("#loginHelp").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                        + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Invalid Login Credentials!'
                                        + '</div>  ');

                                $("#login_form")[0].reset();
                            }
                        }
                    } else {
                        $("#loginHelp").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Invalid Login Credentials!'
                                + '</div>  ');

                        $("#login_form")[0].reset();
                    }

                },
                //If there was no response from the server
                error: function (jqXHR, textStatus, errorThrown) {
                    $("#loginHelp").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                            + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Login Error! Try after few minutes.'
                            + '</div>  ');

                    $("#login_form")[0].reset();

                }
            });
        });

        $("#activate_account_form").submit(function (e) {
            e.preventDefault();

            var login = $("#login").val();
            var code = $("#activationCode").val();

            var dataString = "login=" + login + "&" + "activationCode=" + code;

            $.ajax({
                type: "POST",
                url: "Ajax_activateAccount",
                data: dataString,
                dataType: "json",
                success: function (data) {
                    if (data.activated) {
                        $("#ActivationHelp").html('<br><div class="alert alert-success alert-white rounded">'
                                + '<i class="glyphicon glyphicon-info-sign"></i> Your account is activated !'
                                + '</div>  ');
                        location.reload();
                    } else {
                        $("#ActivationHelp").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Account Activation Failed! Check your activation code and try again.'
                                + '</div>  ');

                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $("#ActivationHelp").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                            + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Account Activation Failed! Please try after few minutes.'
                            + '</div>  ');

                }
            });
        });

        $("#newCode").click(function () {
            $('#ActivationHelp').html('');
            $("#newCode").addClass("disabled");
            $("#newCode").html("<div class='spinner'><div class='bounce1'></div><div class='bounce2'></div><div class='bounce3'></div></div> Sending");


            var login = $("#login").val();
            var dataString = "login=" + login;

            $.ajax({
                type: "POST",
                url: "Ajax_requestActivationCode",
                data: dataString,
                dataType: "json",
                success: function (data) {
                    if (data.sent) {
                        $("#newCode").removeClass("disabled");
                        $("#newCode").html("Request Again");

                        $("#ActivationHelp").html('<br><div class="alert alert-success alert-white rounded">'
                                + '<i class="glyphicon glyphicon-info-sign"></i> New Activation Code Sent !'
                                + '</div>  ');

                    } else {
                        $("#newCode").removeClass("disabled");
                        $("#newCode").html("Retry");

                        $("#ActivationHelp").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Activation Code Cannot Send! Please Try Later.'
                                + '</div>  ');


                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $("#ActivationHelp").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                            + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Activation Code Cannot Send! Please Try Later.'
                            + '</div>  ');
                },
            });
        });

        $("#login").keyup(function () {
            $("#loginHelp").html('');
        });

        $("#password").keyup(function () {
            $("#loginHelp").html('');
        });

        $("#reset_password").click(function () {
            $('#login_model').modal('toggle');
            $('body').addClass('modal-open');
            $("#loginHelp").html('');
            document.getElementById("formResetPassword").reset();
            $('#modal-reset-password-login-help').html('');
        });
    });
</script>

<!-- Modal -->


<div class="modal fade" id="login_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="login-form-enabled ">
                <form id="login_form" method="POST" autocomplete="off" class="form-horizontal">
                    <div class="modal-header">
                        <button id="close_button" type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Log In<br/>
                            <small class="subsection-title">Sign Into Your Superb.lk Account</small>
                        </h4>
                    </div>
                    <div class="modal-body container-fluid">
                        <fieldset>
                            <!-- Text input-->
                            <div class="control-group">
                                <label class="control-label" for="text">Username / E-Mail</label>
                                <div class="controls">
                                    <input class="form-control" id="login" name="login" type="text" placeholder="Registerd Username / E-Mail" class="input-xlarge" required="">  
                                </div>
                            </div>

                            <br/>

                            <!-- Text input-->
                            <div class="control-group">
                                <label class="control-label" for="email">Password</label>
                                <div class="controls">
                                    <input class="form-control" id="password" name="pass" maxlength="16" type="password" placeholder="Account Password" class="input-xlarge" required="">
                                </div>
                            </div>
                            <span id="loginHelp" class="help-block text-left" style="color: red;"></span>  
                            <br>
                            <a id='reset_password' data-toggle="modal" data-target="#modal-reset-password" href="">I don't remember my password.</a>
                        </fieldset>

                    </div>
                    <div class="modal-footer text-center">
                        <div class="pull-left img-responsive img-circle" id="loading_animation" style="padding: 2px;"></div>
                        <div class="btn-group">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <button type="reset" class="btn btn-info hidden">Reset</button>
                            <button type="submit" id="login_button" class="btn btn-primary">Log In</button>
                        </div>                    
                    </div>
                </form>
            </div>
            <div class="activation-form-enabled hidden">
                <form id="activate_account_form" method="POST" class="form-horizontal">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Activate Account</h4>
                    </div>
                    <div class="modal-body">
                        <p style="text-align: left;">
                            Sorry, Your account is not yet activated.                    
                            Please enter <b>Activation Code</b> that we sent to your registered E-Mail address.
                        </p>
                        <br>

                        <fieldset>
                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-md-3 control-label" for="activationCode">
                                    Activation Code
                                </label>  
                                <div class="col-md-9">
                                    <input id="activationCode" name="activationCode" type="number" max="999999999" min="100000000" placeholder="Enter Activation Code Here" class="form-control input-md" required="">
                                </div>
                                <div class="col-md-12">
                                    <span id="ActivationHelp" class="help-block text-left" style="color: red;"></span>  
                                </div>
                            </div>
                        </fieldset>

                        <hr>
                        <p style="text-align: left; color: red; font-size: small;">    
                            If the activation code is not received to your E-Mail address,
                            please request a new code by clicking <b>"REQUEST NEW"</b> button OR please check the mails in <b>SPAM Folder</b>.
                        </p>

                    </div>

                    <div class="modal-footer">

                        <div class="btn-group btn-group-sm pull-right" role="group">
                            <button type="button" id="newCode" class="btn btn-warning">Request New</button>
                            <button type="submit" class="btn btn-success">Activate</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>                  
                    </div>
                </form>
            </div>


        </div>
    </div>
</div>

<!--Message Model-->

<div class="modal fade bs-example-modal-sm" id="message_model">
    <div class="modal-dialog modal-dialog modal-sm">
        <div class="modal-content" style="background-color: #00cccc;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Superb.lk</h4>
            </div>
            <div class="modal-body text-center" id="message_model_content">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- /.modal -->


<!-- 
<form id="activate_account_form" method="POST" class="form-horizontal">
    <div class="modal fade" id="activate_account">
        <div class="modal-dialog modal-dialog">
            <div class="modal-content" style="background-color: #cccccc;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Activate Account</h4>
                </div>
                <div class="modal-body">
                    <p style="text-align: left;">
                        Sorry, Your account is not yet activated.                    
                        Please enter <b>Activation Code</b> that we sent to your registered E-Mail address.
                    </p>
                    <p style="text-align: left; color: red; font-size: medium;">    
                        If the activation code is not received to your E-Mail address,
                        please request a new code by clicking <b>"REQUEST NEW"</b> button OR please check the mails in <b>SPAM Folder</b>.
                    </p>

                    <hr>
                    <br>

                    <fieldset>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="activationCode">
                                Activation Code
                            </label>  
                            <div class="col-md-9">
                                <input value="584896685" id="activationCode" name="activationCode" type="number" max="999999999" min="100000000" placeholder="Enter Activation Code Here" class="form-control input-md" required="">
                            </div>
                        </div>
                    </fieldset>
                </div>

                <div class="modal-footer">

                    <div class="btn-group btn-group-sm pull-right" role="group">
                        <button type="button" id="newCode" class="btn btn-warning">Request New</button>
                        <button type="submit" class="btn btn-success">Activate</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>                  
                </div>

            </div>           

        </div>
    </div>

</form>-->

<jsp:include page="model_resetPassword.jsp"></jsp:include>