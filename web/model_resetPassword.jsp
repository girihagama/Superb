<%-- 
    Document   : model_resetPassword
    Created on : Apr 16, 2016, 5:39:25 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password Modal</title>
        <style>
            body.modal-open {
                overflow: hidden !important;
            }
        </style>
        <script>
            $(document).ready(function () {
                $("#modal-enter-reset-password-login").keyup(function () {
                    $('#modal-enter-reset-password-login-help').html('');
                });

                $("#modal-reset-password-pass1").keyup(function () {
                    $('#modal-reset-password-pass2').val('');
                    $("#modal-reset-password-pass2-help").html('');

                });

                $("#formEnterResetPassword").submit(function (e) {
                    e.preventDefault();                   
                    
                    var login = $("#modal-enter-reset-password-login").val();
                    var code = $("#modal-reset-password-code").val();
                    var pass1 = $("#modal-reset-password-pass1").val().toString();
                    var pass2 = $("#modal-reset-password-pass2").val().toString();                  

                    if (login.length < 1) {
                        $('#modal-enter-reset-password-login-help').html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Please enter username or email !'
                                + '</div>  ');

                    } else if ($("#modal-reset-password-pass1").val().length < 1 || $("#modal-reset-password-pass2").val().length < 1) {
                        $("#modal-reset-password-pass2-help").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Password required !'
                                + '</div>  ');


                    } else if ($("#modal-reset-password-pass1").val().length < 8) {
                        $("#modal-reset-password-pass2-help").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                + '<i class="glyphicon  glyphicon-exclamation-sign"></i> 8 Alphanumeric Characters Required!'
                                + '</div>  ');


                    } else if (pass1 !== pass2) {
                        $("#modal-reset-password-pass2-help").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Password mismatch!'
                                + '</div>  ');


                    } else {
                        $("#modal-reset-password-btn-reset-passsword").addClass('disabled');
                        $("#modal-reset-password-btn-reset-passsword").text('Resetting');

                        $.ajax({
                            type: 'POST',
                            url: "Ajax_resetPassword",
                            dataType: 'json',
                            data: jQuery.param({login: login, code: code, password: pass1}),
                            success: function (data, textStatus, jqXHR) {                                
                                if (data.Reset) {                                   
                                    $("#modal-reset-password-pass2-help").html('<br><div class="alert alert-success alert-white rounded">'
                                            + '<i class="glyphicon glyphicon-info-sign"></i> Password Reset Successful. Please login with new password. thank you!'
                                            + '</div>  ');
                                    $("#modal-reset-password-btn-reset-passsword").text('Done');
                                    setTimeout(function () {
                                        location.reload();
                                    }, 3500);


                                } else {
                                    $("#modal-reset-password-pass2-help").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                            + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Password Reset Unsuccessful Please try again with correct username or email. <br>If the code doesn\'t work, Request a new code. If you can\'t reset your password please do not hesitate to contact support!'
                                            + '</div>  ');
                                    setTimeout(function () {
                                        $("#modal-reset-password-pass2-help").html('');
                                    }, 8000);

                                    $("#modal-reset-password-btn-reset-passsword").removeClass('disabled');
                                    $("#modal-reset-password-btn-reset-passsword").text('Reset');
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {                                
                                $("#modal-reset-password-pass2-help").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                        + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Service Not Available!' + textStatus
                                        + '</div>  ');
                                setTimeout(function () {
                                    $("#modal-reset-password-pass2-help").html('');
                                }, 3500);

                                $("#modal-reset-password-btn-reset-passsword").removeClass('disabled');
                                $("#modal-reset-password-btn-reset-passsword").text('Reset');
                            }
                        });

                    }

                });

                $("#modal-reset-password-btn-request-new").click(function () {
                    $("#modal-reset-password-btn-request-new").addClass('disabled');
                    //$("#modal-reset-password-btn-request-new").html('<div id="modal-activate-account-btn-active-indicator"><i class="fa fa-spinner fa-spin fa fa-fw margin-bottom"></i> Sending</div>');

                    var login = $("#modal-reset-password-login").val();

                    if (!(login.length > 0)) {
                        $("#modal-reset-password-login-help").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Please enter username or email!'
                                + '</div>  ');
                        $("#modal-reset-password-btn-request-new").removeClass('disabled');

                    } else {
                        $("#modal-reset-password-login-help").html('<br><div class="alert alert-success alert-white rounded">'
                                + '<i class="glyphicon glyphicon-info-sign"></i> Please wait !'
                                + '</div>  ');
                        $.ajax({
                            type: 'POST',
                            url: "Ajax_newPasswordResetCode",
                            dataType: 'json',
                            data: jQuery.param({login: login}),
                            success: function (data, textStatus, jqXHR) {
                                if (data.Sent) {
                                    $("#modal-reset-password-login-help").html('<br><div class="alert alert-success alert-white rounded">'
                                            + '<i class="glyphicon glyphicon-ok-sign"></i> Reset Code Sent! Please check your email !'
                                            + '</div>  ');
                                    $("#modal-reset-password-btn-request-new").removeClass('disabled');
                                    $("#modal-reset-password-btn-request-new").html('Resend code');




                                } else {
                                    $("#modal-reset-password-login-help").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                            + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Reset code cannot be sent. Please check your entered details or try again later!'
                                            + '</div>  ');
                                    $("#modal-reset-password-btn-request-new").removeClass('disabled');
                                    $("#modal-reset-password-btn-request-new").html('Resend code');

                                    setTimeout(function () {
                                        $("#modal-reset-password-login-help").html('');
                                    }, 5000);


                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                $("#modal-reset-password-login-help").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                        + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Service Not Available!'
                                        + '</div>  ');
                                $("#modal-reset-password-btn-request-new").removeClass('disabled');
                                $("#modal-reset-password-btn-request-new").html('Resend code');

                                setTimeout(function () {
                                    $("#modal-reset-password-login-help").html('');
                                }, 3500);
                            }
                        });
                    }
                });
            });
        </script>

    </head>
    <body>

        <form id="formResetPassword"  method="POST">
            <!-- activate account modal -->
            <div class="modal fade bs-example-modal-md" id="modal-reset-password" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                <div class="modal-dialog modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <b>Reset Password</b>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <div class="modal-body">

                            <fieldset>

                                <!-- Text input-->
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <input id="modal-reset-password-login" name="modal-reset-password-login" type="text" placeholder="Enter email address / username" class="form-control input-md" required="">
                                        <span id="modal-reset-password-login-help" class="help-block"></span>  
                                    </div>
                                </div>



                            </fieldset>

                        </div>
                        <div class="modal-footer">
                            <div class="btn-group btn-group-sm" role="group" aria-label="...">
                                <div class="btn-group" role="group">
                                    <button type="button" id="modal-reset-password-btn-request-new" class="btn btn-sm btn-warning" >Get Reset Code</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </form>

        <form id="formEnterResetPassword"  method="POST">
            <!-- activate account modal -->
            <div class="modal fade bs-example-modal-md" id="modal-enter-reset-password" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                <div class="modal-dialog modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <b>Reset Password</b>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <div class="modal-body">

                            <fieldset>

                                <!-- Text input-->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="modal-reset-password-email">Login</label>  
                                    <div class="col-md-8">
                                        <input id="modal-enter-reset-password-login" name="modal-reset-password-login" type="text" placeholder="Enter email address / username" class="form-control input-md" required="">
                                        <span id="modal-enter-reset-password-login-help" class="help-block"></span>  
                                    </div>
                                </div>

                                <!-- Text input-->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="modal-reset-password-code">Reset Code</label>  
                                    <div class="col-md-8">
                                        <input id="modal-reset-password-code"  readonly="" name="modal-reset-password-code" type="number" min="100000000" max="999999999" placeholder="Enter reset code" class="form-control input-md"  required="">
                                        <span class="help-block"></span>  
                                    </div>
                                </div>

                                <!-- Password input-->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="modal-reset-password-pass1">New Password</label>
                                    <div class="col-md-8">
                                        <input id="modal-reset-password-pass1" name="modal-reset-password-pass1" type="password" placeholder="Enter new password" class="form-control input-md" required="">
                                        <span id="modal-reset-password-pass1-help" class="help-block"></span>
                                    </div>
                                </div>

                                <!-- Password input-->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="modal-reset-password-pass2">Re-Type Password</label>
                                    <div class="col-md-8">
                                        <input id="modal-reset-password-pass2" name="modal-reset-password-pass2" type="password" placeholder="Re-enter new password" class="form-control input-md" required="">
                                        <span id="modal-reset-password-pass2-help" class="help-block"></span>
                                    </div>
                                </div>

                            </fieldset>

                        </div>
                        <div class="modal-footer">
                            <div class="btn-group btn-group-sm" role="group" aria-label="...">
                                <div class="btn-group" role="group">
                                    <button type="submit" id="modal-reset-password-btn-reset-passsword" class="btn btn-sm btn-primary">Reset</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </form>

        <!-- Index message modal -->
        <div id="index-message-modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        Superb.lk
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body" id="index-message-modal-body">

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </body>
    <script>
        $('#modal-reset-password').on('shown.bs.modal', function () {
            $('body').addClass('modal-open');
            //$("html").css("overflow-y", "hidden");
            $('#login_model').modal('hide');
        })
        $('#modal-reset-password').on('hidden.bs.modal', function () {
            //$("html").css("overflow-y", "");
            $('.modal-backdrop').remove();
            $("#modal-reset-password-btn-request-new").html('Get Reset Code');
        })
        $('#login_model').on('hidden.bs.modal', function () {
            $("#login_form")[0].reset();
            $("#loginHelp").html('');
            $(".activation-form-enabled").addClass("hidden");
            $(".login-form-enabled").removeClass("hidden");
        })
        $("#modal-reset-password-login").keyup(function () {
            $("#modal-reset-password-login-help").html('');
        });

        $("#activationCode").keyup(function () {
            $('#ActivationHelp').html('');
        });


        var getUrlParameter = function getUrlParameter(sParam) {
            var sPageURL = decodeURIComponent(window.location.search.substring(1)),
                    sURLVariables = sPageURL.split('&'),
                    sParameterName,
                    i;

            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');

                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : sParameterName[1];
                }
            }
        };

        $(window).load(function () {
            var reset_code = getUrlParameter('uy1awqecd');
            var activation_code = getUrlParameter('uy1actecd');
            if (reset_code) {
                window.history.pushState("object or string", "Title", "/" + window.location.href.substring(window.location.href.lastIndexOf('/') - 3).split("?")[0]);
                $('#modal-reset-password-code').val(reset_code);
                
                //developer fold
                //window.history.pushState("object or string", "Title", "/" + window.location.href.substring(window.location.href.lastIndexOf('/') - 6).split("?")[0]);
                //$('#modal-reset-password-code').val(reset_code);
                //developer fold end
                
                $('#modal-enter-reset-password').modal('show');
            } else if (activation_code) {
                var login = getUrlParameter('usdsp');
                window.history.pushState("object or string", "Title", "/" + window.location.href.substring(window.location.href.lastIndexOf('/') - 3).split("?")[0]);
                var dataString = "login=" + login + "&" + "activationCode=" + activation_code;

                $.ajax({
                    type: "POST",
                    url: "Ajax_activateAccount",
                    data: dataString,
                    dataType: "json",
                    success: function (data) {
                        
                        if (data.activated) {
                            $('#accountActivated_model').modal('show');
                        } else {
                            $(".activation-form-enabled").addClass("hidden");
                            $(".login-form-enabled").removeClass("hidden");
                            $('#login_model').modal('show');
                            $("#loginHelp").html('<br><div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                    + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Account Activation Failed or Expired! Please login and try again.'
                                    + '</div>  ');

                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert('Connection is too slow. Please wait or try after several minutes!');
                    }
                });
            }
        });

    </script>
</html>
