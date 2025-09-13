<%@ page import="com.immoplus.app.immoplus.entities.Utilisateur" %>
<%@ page import="com.immoplus.app.immoplus.entities.AdminDashboardEntity" %><%--
  Created by IntelliJ IDEA.
  User: metzo
  Date: 01/09/2025
  Time: 23:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Utilisateur user = (Utilisateur) session.getAttribute("user");
    String name = user.getNom();
    AdminDashboardEntity dashboardData = (AdminDashboardEntity) request.getAttribute("adminDashboard");
%>
<!DOCTYPE html>
<html lang="fr">
<jsp:include  page="../header.jsp">
    <jsp:param name="title" value="Dashboard" />
</jsp:include>
<body class="bg-gray-100 min-h-screen flex">
<jsp:include  page="../navbar.jsp">
    <jsp:param name="page" value="admin"/>
</jsp:include>


<div class="flex-1">
    <jsp:include page="admin-header.jsp">
        <jsp:param name="name" value="<%= name %>" />
    </jsp:include>
    <% assert dashboardData != null; %>
    <script>
        console.log("DASHBOARD DATA:", <%= dashboardData%>);
    </script>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-3xl font-extrabold mb-10 text-center text-indigo-700 drop-shadow">Tableau de bord Administrateur</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-3 gap-8 mb-8">
            <div class="bg-gradient-to-br from-indigo-500 to-indigo-300 rounded-xl shadow-lg p-8 flex flex-col items-center">
                <div class="text-white text-lg font-medium mb-2">Locataires</div>
                <div class="text-4xl font-extrabold text-white"><%=dashboardData.getTotalLocataires()%></div>
            </div>
            <div class="bg-gradient-to-br from-green-500 to-green-300 rounded-xl shadow-lg p-8 flex flex-col items-center">
                <div class="text-white text-lg font-medium mb-2">Propriétaires</div>
                <div class="text-4xl font-extrabold text-white"><%=dashboardData.getTotalProprietaires()%></div>
            </div>
            <div class="bg-gradient-to-br from-yellow-500 to-yellow-300 rounded-xl shadow-lg p-8 flex flex-col items-center">
                <div class="text-white text-lg font-medium mb-2">Immeubles</div>
                <div class="text-4xl font-extrabold text-white"><%=dashboardData.getTotalImmeubles()%></div>
            </div>
            <div class="bg-gradient-to-br from-pink-500 to-pink-300 rounded-xl shadow-lg p-8 flex flex-col items-center">
                <div class="text-white text-lg font-medium mb-2">Unités</div>
                <div class="text-4xl font-extrabold text-white"><%=dashboardData.getTotalUnites()%></div>
            </div>
            <div class="bg-gradient-to-br from-blue-500 to-blue-300 rounded-xl shadow-lg p-8 flex flex-col items-center">
                <div class="text-white text-lg font-medium mb-2">Contrats</div>
                <div class="text-4xl font-extrabold text-white"><%=dashboardData.getTotalContrats()%></div>
            </div>
            <div class="bg-gradient-to-br from-red-500 to-red-300 rounded-xl shadow-lg p-8 flex flex-col items-center">
                <div class="text-white text-lg font-medium mb-2">Demandes</div>
                <div class="text-4xl font-extrabold text-white"><%=dashboardData.getTotalDemandes()%></div>
            </div>
        </div>
    </div>
</div>
</body>
</html>