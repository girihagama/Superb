<%-- 
    Document   : Ajax_CommonActivities
    Created on : Sep 21, 2015, 5:53:47 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script type="text/javascript">
            $(document).ready(function () {
                updateChat();
                siteVisits();
            });

//            function welcomeCookie() {
//                $.ajax({
//                    type: "POST",
//                    url: "Ajax_welcomeCookieCheck",
//                    dataType: "json",
//                    success: function (data, textStatus, jqXHR) {
//                        console.log("Welcome Cookie Success!");
//                    },
//                    error: function (jqXHR, textStatus, errorThrown) {
//                        console.log("Welcome Cookie Failed!");
//                    }
//                });
//            }

            function updateChat() {
                setInterval(function () {
                    //window.alert("Chat is updating!");

                    $.ajax({
                        type: "POST",
                        url: "Ajax_checkLoginSessions",
                        dataType: "json",
                        //if received a response from the server
                        success: function (data) {
                            if (data.login !== null) {
                                //window.alert("Online");

                                $.ajax({
                                    type: "POST",
                                    url: "Ajax_updateChat",
                                    dataType: "json",
                                    //if received a response from the server
                                    success: function (data) {
                                        if (data.update) {
                                            //window.alert("Chat Update: " + data.update);

                                            /*
                                             * code is currently working
                                             */
                                        } else {
                                            //window.alert("Chat Update: " + data.update);

                                            /*
                                             * code is currently working
                                             */
                                        }
                                    },
                                });
                            }
                        },
                    });

                }, 2500);
            }

            function siteVisits() {
                //window.alert("Site visits checked!");

                $.ajax({
                    type: "POST",
                    url: "Ajax_updateSiteVisits",
                    dataType: "json",
                    //if received a response from the server
                    success: function (data) {
                        if (data.siteVisit) {
                            //window.alert("site visit OK");
                        }
                    }
                });
            }

            $.getJSON("http://jsonip.com?callback=?", function (data) {
                var userip = data.ip;
                //alert(userip);                
            });

        </script>
    </head>    
</html>
