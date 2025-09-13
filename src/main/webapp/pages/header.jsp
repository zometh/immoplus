<%--
  Created by IntelliJ IDEA.
  User: metzo
  Date: 02/09/2025
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String title = request.getParameter("title");
%>
<head>
    <meta charset="UTF-8">
    <title><%= title %></title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindplus/elements@1" type="module"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://unpkg.com/flowbite@2.2.1/dist/flowbite.min.js"></script>
</head>