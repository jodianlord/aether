<%-- 
    Document   : index
    Created on : Jul 23, 2018, 4:14:39 PM
    Author     : Jordy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/Blockchain");
            requestDispatcher.forward(request, response); %>
    </body>
</html>
