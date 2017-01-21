<%-- 
    Document   : model_contact_support
    Created on : Jul 12, 2015, 9:23:06 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Modal -->

<html>
    <head>
        <script>
            $(document).ready(function () {
                $("#contact_support_model_form").submit(function (e) {
                    e.preventDefault();
                    $("#contact_support_model_form_submit").addClass("disabled");
                    $("#contact_support_model_form_submit").text("Sending");

                    var email = $("#contact_support_model_email").val();
                    var message = $("#contact_support_model_message").val();
                    var dataUrl = "email=" + email + "&message=" + message;

                    $.ajax({
                        url: "Ajax_contactSupport",
                        type: 'POST',
                        dataType: 'json',
                        data: dataUrl,
                        success: function (data, textStatus, jqXHR) {
                            if (data.sent) {
                                alert("Your message sent to the support team!");
                                $("#contact_support_model_form_submit").text("SENT!");
                            } else {
                                $("#contact_support_model_form_submit").text("Send");
                                $("#contact_support_model_form_submit").removeClass("disabled");
                                alert("Sorry, Service Not Available! Please again try later..")
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $("#contact_support_model_form_submit").text("Send");
                            $("#contact_support_model_form_submit").removeClass("disabled");
                            alert("Service Not Available!");
                        },
                        complete: function (jqXHR, textStatus) {
                            location.reload();
                        }
                    });

                });
            });
        </script>
    </head>

    <body>    

        <form method="POST" id="contact_support_model_form" class="form-horizontal">
            <div class="modal fade" id="contact_support_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Contact Support<br/>
                                <small class="subsection-title">Send Email To Customer Support</small>
                            </h4>
                        </div>
                        <div class="modal-body container-fluid">
                            <fieldset>
                                <!-- Text input-->
                                <div class="control-group">
                                    <label class="control-label" for="email">E-Mail</label>
                                    <div class="controls">
                                        <input class="form-control" id="contact_support_model_email" name="email" type="email" placeholder="Type Your E-Mail Address" class="input-xlarge" required="">  
                                    </div>
                                </div>

                                <br/>

                                <!-- Textarea -->
                                <div class="control-group">
                                    <label class="control-label" for="message">Message/Problem</label>
                                    <div class="controls">                     
                                        <textarea required="" class="form-control" id="contact_support_model_message" name="message" data-widearea="enable" style="border-radius: 5px; resize: vertical; max-height: 200px;" placeholder="Type Your Message/Problem Here.."></textarea>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <div class="modal-footer text-center">
                            <div class="btn-group">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                <!--<button type="reset" class="btn btn-info">Reset</button>-->
                                <button type="submit" id="contact_support_model_form_submit" class="btn btn-primary">Send</button>
                            </div>                    
                        </div>
                    </div>
                </div>
            </div>
        </form>

    </body>
</html>
