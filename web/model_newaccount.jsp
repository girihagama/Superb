<%-- 
    Document   : model_signup
    Created on : Jul 24, 2015, 8:16:40 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
</head>

<body>

    <!-- Signup Modal -->
    <div class="modal fade" id="newAccount_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"">
        <div class="modal-dialog" role="document">
            <div class="modal-content" id="newAccount_model_content">

            </div>
        </div>
    </div>

    <!--Message Model-->

    <div class="modal fade bs-example-modal-sm" id="">
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
    <%
        if (session.getAttribute("newAccount") != null) {
            if (session.getAttribute("newAccount") == "success") {
                session.setAttribute("newAccount", null);
    %>
    <script>
        $('#newAccount_model_content').html("<div class='modal-header'>"
                + "<button id='close_button' type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>"
                + "<h4 class='modal-title' id='myModalLabel'>Welcome<br/>"
                + "<small class='subsection-title'>final step of creating Your Superb.lk Account</small>"
                + "</h4>"
                + "</div>"
                + "<div class='modal-body container-fluid'>"
                + "<center>"
                + "<h2>Your Account Is Created!</h2>       "
                + "<br>"
                + "<h4>Activation code is sent to your <br>e-mail address.</h4>"
                + "</center>"
                + "</div>"
                + "<div class='modal-footer text-center'>"
                + "<div class='pull-left img-responsive img-circle' id='loading_animation' style='padding: 2px;'></div>"
                + "<div class='btn-group'>"
                + "<button type='button' class='btn btn-default' data-dismiss='modal'>Cancel</button>   "
                + "</div>"
                + "</div>");
        $("#newAccount_model").modal();
    </script>
    <%
    } else {
        session.setAttribute("newAccount", null);
    %>
    <script>
        $('#newAccount_model_content').html("<div class='modal-header'>"
                + "<button id='close_button' type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>"
                + "<h4 class='modal-title' id='myModalLabel'>Sorry<br/>"
                + "<small class='subsection-title'>creating Your Superb.lk Account is failed</small>"
                + "</h4>"
                + "</div>"
                + "<div class='modal-body container-fluid'>"
                + "<center>"
                + "<h2>Your Account Is not Created!</h2>       "
                + "<br>"
                + "<h4>Your account could not be created at the moment. <br>please try again.</h4>"
                + "</center>"
                + "</div>"
                + "<div class='modal-footer text-center'>"
                + "<div class='pull-left img-responsive img-circle' id='loading_animation' style='padding: 2px;'></div>"
                + "<div class='btn-group'>"
                + "<button type='button' class='btn btn-default' data-dismiss='modal'>Cancel</button>   "
                + "</div>"
                + "</div>");
        $("#newAccount_model").modal();
    </script>
    <%
            }
        }
    %>

