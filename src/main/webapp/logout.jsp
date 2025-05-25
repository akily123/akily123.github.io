<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>退出登录</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <%
        HttpSession _session = request.getSession();
        session.invalidate();
        response.sendRedirect("login.jsp");
    %>
</body>
</html>