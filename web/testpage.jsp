<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
    <head>
        <title>Test Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>

        <c:url var="backUrl" value="">
            <c:forEach items="${param}" var="entry">
                <c:if test="${entry.key != 'page'}">
                    <c:param name="${entry.key}" value="${entry.value}" />
                </c:if>
            </c:forEach>
            <c:param name="page" value="${(param.page)-1}" />
        </c:url>

        <a href='${backUrl}'>Back</a> 
        
        <c:url var="nextUrl" value="">
            <c:forEach items="${param}" var="entry">
                <c:if test="${entry.key != 'page'}">
                    <c:param name="${entry.key}" value="${entry.value}" />
                </c:if>
            </c:forEach>
            <c:param name="page" value="${(param.page)+1}" />
        </c:url>

        <a href='${nextUrl}'>Next</a>

    </body>
</html>