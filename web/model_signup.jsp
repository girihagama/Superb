<%-- 
    Document   : model_signup
    Created on : Jul 24, 2015, 8:16:40 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script type="text/javascript" src="custom_styles_scripts/regex.js"></script>

<script type="text/javascript">
    var usernameValidation = false;
    var emailValidation = false;
    var passwordValidation = false;

    $(document).ready(function () {

        $("#signup_form").submit(function (e) {
            ///$("#register_button").attr('disabled', 'true');            
            if ($("#password1").val() !== $("#password2").val()) {
                $("#password2Help").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                        + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Password mismatch!'
                        + '</div>  ');
                passwordValidation = false;

            } else if (!valEmail($("#email").val())) {
                $("#emailHelp").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                        + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Please enter correct email!'
                        + '</div>  ');
                emailValidation = false;
            } else {
                if (emailValidation && usernameValidation && passwordValidation) {
                    var dataString = "validate=confirm&username=" + $("#username").val() + "&email=" + $("#email").val();
                    $.ajax({
                        type: "POST",
                        url: "Ajax_signupValidation",
                        dataType: "json",
                        data: dataString,
                        //if received a response from the server
                        success: function (data) {
                            if (data.check) {
                                if (data.unameexist) {
                                    $("#usernameHelp").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                            + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Please try Different Username!'
                                            + '</div>  ');
                                    usernameValidation = false;
                                } else if (data.emailexist) {
                                    $("#emailHelp").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                            + '<i class="glyphicon  glyphicon-exclamation-sign"></i> This email is already registered. Please log in!'
                                            + '</div>  ');
                                    emailValidation = false;
                                } else {
                                    $("#register_button").addClass('disabled');
                                    $("#signup_form")[0].submit();
                                }
                            } else {
                                $("#password2Help").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                        + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Error!'
                                        + '</div>  ');
                                emailValidation = false;
                                usernameValidation = false;
                            }
                        },
                        complete: function (jqXHR, textStatus) {
                            changeSubmitButton();
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            $("#password2Help").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                    + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Connection is too slow. Please wait or try after several minutes!'
                                    + '</div>  ');
                            emailValidation = false;
                            usernameValidation = false;
                        }
                    });
                }
            }
            $("#register_button").removeClass('disabled');
            e.preventDefault();
            return false;

        });



        $("#username").keyup(function () {
            $("#username").trigger('change');
        });

        $("#email").keyup(function () {
            $("#email").trigger('change');
        });

        $("#password1").keyup(function () {
            $("#password1Help").html("");
            $("#password2Help").html("");
            $("#password2").val('');

        });
        $("#password2").keyup(function () {
            if ($("#password2").val().length > 1) {
                $("#password2Help").html("");

            }
        });

        $("#username").change(function (e) {
            validateUsername();
        });

        $("#email").change(function (e) {
            //$("#register_button").addClass('disabled');
            validateEmail();
        });

        $("#password1").change(function (e) {
            validatePasswords();
        });

        $("#password2").change(function (e) {
            validatePasswords();
        });
    });

    function validateUsername() {
        //alert("username cahnged");
        $("#usernameHelp").html("");
        var dataString = "validate=username&username=" + $("#username").val();

        if ($("#username").val().length > 1) {
            $("#usernameHelp").html("");

            $.ajax({
                type: "POST",
                url: "Ajax_signupValidation",
                dataType: "json",
                data: dataString,
                //if received a response from the server
                success: function (data) {
                    if (data.check) {
                        if (data.exist) {
                            $("#usernameHelp").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                    + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Please try Different Username!'
                                    + '</div>  ');
                            usernameValidation = false;
                        } else {
                            $("#usernameHelp").html("");
                            usernameValidation = true;

                            if (!regexValidation($("#username").val())) {
                                usernameValidation = false;
                                $("#usernameHelp").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                        + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Please use A-Z a-z 0-9 and _ . @ to username!'
                                        + '</div>  ');

                            }
                        }
                    } else {
                        $("#usernameHelp").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Error!'
                                + '</div>  ');
                        usernameValidation = false;
                    }
                }, complete: function (jqXHR, textStatus) {
                    changeSubmitButton();
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    $("#usernameHelp").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                            + '<i class="glyphicon  glyphicon-exclamation-sign"></i>  Connection is too slow. Please wait or try after several minutes!'
                            + '</div>  ');
                    usernameValidation = false;
                }
            });
        }

    }

    function validateEmail() {

        $("#emailHelp").html("");
        var dataString = "validate=email&email=" + $("#email").val();
        if ($("#email").val().length > 1) {
            $("#emailHelp").html("");
            $.ajax({
                type: "POST",
                url: "Ajax_signupValidation",
                dataType: "json",
                data: dataString,
                //if received a response from the server
                success: function (data) {
                    if (data.check) {
                        if (data.exist) {
                            $("#emailHelp").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                    + '<i class="glyphicon  glyphicon-exclamation-sign"></i> This email is already registered. Please log in!'
                                    + '</div>  ');
                            emailValidation = false;
                        } else {
                            $("#emailHelp").html("");
                            emailValidation = true;

                            if (!regexValidation($("#email").val())) {
                                emailValidation = false;
                                $("#emailHelp").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                        + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Please use A-Z a-z 0-9 and _ . @ to email!'
                                        + '</div>  ');

                            }
                        }
                    } else {
                        $("#emailHelp").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                                + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Error!'
                                + '</div>  ');
                        emailValidation = false;
                    }
                },
                complete: function (jqXHR, textStatus) {
                    changeSubmitButton();
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    $("#emailHelp").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                            + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Connection is too slow. Please wait or try after several minutes!'
                            + '</div>  ');
                    emailValidation = false;
                }
            });


        }
    }

    function validatePasswords() {
        $("#password1Help").html("").show();
        $("#password2Help").html("").show();

        if ($("#password1").val().length < 8) {
            $("#password1Help").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                    + '<i class="glyphicon  glyphicon-exclamation-sign"></i> 8 Alphanumeric Characters Required!'
                    + '</div>  ');

            passwordValidation = false;
        } else {
            passwordValidation = true;
        }

        if ($("#password1").val().length < 1) {
            $("#password1Help").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                    + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Please enter password!'
                    + '</div>  ');
            $("#password2").val('');
        }

        if ($("#password2").val().length < 1 && $("#password1").val().length > 7) {
            $("#password2Help").html('<div class="alert alert-danger alert-white rounded" style="color:white; background-color:#B4352D">'
                    + '<i class="glyphicon  glyphicon-exclamation-sign"></i> Please confirm password!'
                    + '</div>  ');

        }
    }
    function valEmail(email) {
        var emailReg = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
        var valid = emailReg.test(email);

        if (!valid) {
            return false;
        } else {
            return true;
        }
    }

</script>
</head>

<body>

    <!-- Signup Modal -->
    <form id="signup_form" autocomplete="off" action="CreateAccount" method="POST" class="form-horizontal">
        <div class="modal fade" id="signup_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="close_button" type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Register<br/>
                            <small class="subsection-title">Create Your Superb.lk Account</small>
                        </h4>
                    </div>

                    <div class="modal-body container-fluid">

                        <fieldset>
                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="username">Username</label>  
                                <div class="col-md-8">
                                    <input id="username" name="username" type="text" maxlength="20"  placeholder="Enter A Username Here"  class="form-control input-md" required="">
                                    <span id="usernameHelp" class="help-block text-left" style="color: red;"></span>  
                                </div>
                            </div>

                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="email">E-Mail</label>  
                                <div class="col-md-8">
                                    <input id="email" name="email" type="email" placeholder="Enter E-Mail Address Here"  class="form-control input-md" required="">
                                    <span id="emailHelp" class="help-block text-left" style="color: red;"></span>  
                                </div>
                            </div>

                            <!-- Password input-->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="password1">Password</label>
                                <div class="col-md-8">
                                    <input id="password1" name="password1" maxlength="16" type="password" placeholder="Enter A Password"  class="form-control input-md" required="">
                                    <span id="password1Help" class="help-block text-left" style="color: red;"></span>
                                </div>
                            </div>

                            <!-- Password input-->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="password2">Confirm Password</label>
                                <div class="col-md-8">
                                    <input  id="password2" name="password2" maxlength="16" type="password" placeholder="Re-Enter Password"  class="form-control input-md" required="">
                                    <span id="password2Help" class="help-block text-left" style="color: red;"></span>
                                </div>
                            </div>

                            <!-- Multiple Checkboxes (inline) -->
                            <div class="form-group">
                                <label class="col-md-2 control-label" for="agreeTerms"></label>
                                <div class="col-md-10">
                                    <label class="checkbox-inline" for="agreeTerms-0">
                                        <input type="checkbox" name="agreeTerms" required="" id="agreeTerms-0" value="0">
                                        I agree to terms and conditions of Superb.lk, create my account.
                                    </label>
                                </div>
                            </div>

                        </fieldset>

                    </div>

                    <div class="modal-footer text-center">
                        <div class="pull-left img-responsive img-circle" id="loading_animation" style="padding: 2px;"></div>
                        <div class="btn-group">
                            <button type="submit" id="register_button" class="btn btn-primary">Sign Up</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>   
                        </div>                    
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!--Message Model-->

    <div class="modal fade bs-example-modal-sm" id="signup_message_model">
        <div class="modal-dialog modal-dialog modal-sm">
            <div class="modal-content" style="background-color: #00cccc;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Superb.lk</h4>
                </div>
                <div class="modal-body text-center" id="signup_message_model_content">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <script>
        $('#signup_model').on('hidden.bs.modal', function () {
            document.getElementById("signup_form").reset();
            $("#emailHelp").html("");
            $("#usernameHelp").html("");
            $("#password1Help").html("");
            $("#password2Help").html("");

        });

        $("#username").on("keydown", function (e) {
            return e.which !== 32;
        });
    </script>