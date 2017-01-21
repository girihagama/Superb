<%-- 
    Document   : adminView
    Created on : Jul 26, 2016, 11:00:02 PM
    Author     : Indunil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="BootstrapHeader.jsp"></jsp:include>

        <script>
            $(document).ready(function () {
                $('a').click(function (e) {
                    e.preventDefault();
                    var current = $(this).attr('href');
                    var link = current + "&admin=indunil";
                    window.open(link);
                });
            });
        </script>

    </head>
    <body>
        <a href="adminReview?itemNumber=2">Go</a>
    </body>
</html>
