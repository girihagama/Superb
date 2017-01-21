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
    <div class="modal fade" id="accountActivated_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"">
        <div class="modal-dialog" role="document">
            <div class="modal-content" id="accountActivated_model_content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Welcome<br/>
                        <small class="subsection-title">Your Superb.lk Account</small>
                    </h4>
                </div>
                <div class="modal-body text-center" id="">
                    <center>
                        <h2>Your Account Is Activated!</h2>       
                        <br>

                    </center>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!--Message Model-->

    <div class="modal fade bs-example-modal-sm" id="">
        <div class="modal-dialog modal-dialog modal-sm">
            <div class="modal-content" style="background-color: #00cccc;">

                <div class="modal-header">
                    Superb.lk
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body" id="index-message-modal-body">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <script>
        $('#accountActivated_model').on('hidden.bs.modal', function () {
            location.reload();
        })
    </script>


