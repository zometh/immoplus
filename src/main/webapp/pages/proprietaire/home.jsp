<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="com.immoplus.app.immoplus.entities.Utilisateur" %>
<%@ page import="com.immoplus.app.immoplus.entities.ImmeubleDashboardEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Utilisateur user = (Utilisateur) session.getAttribute("user");
    String name = user.getNom();
    ImmeubleDashboardEntity dashboardData = (ImmeubleDashboardEntity) request.getAttribute("dashboardData");

%>
<!DOCTYPE html>
<html lang="fr">
<jsp:include  page="../header.jsp">
    <jsp:param name="title" value="Dashboard" />
</jsp:include>
<body class="bg-gray-100 min-h-screen flex">
<jsp:include  page="navbar.jsp">
    <jsp:param name="page" value="home-props"/>
</jsp:include>


<div class="flex-1">
    <jsp:include page="../admin/admin-header.jsp">
        <jsp:param name="name" value="<%= name %>" />
    </jsp:include>


    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold mb-6 text-gray-800">Tableau de bord</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <div class="bg-white rounded-lg shadow p-6 flex flex-col items-center">
                <span class="text-4xl font-extrabold text-blue-600"><%=dashboardData.getImmeubles().size()%></span>
                <span class="mt-2 text-gray-600">Immeubles</span>
            </div>
            <div class="bg-white rounded-lg shadow p-6 flex flex-col items-center">
                <span class="text-4xl font-extrabold text-green-600"><%=dashboardData.getNbUnites()%></span>
                <span class="mt-2 text-gray-600">Appartements totaux</span>
            </div>
            <div class="bg-white rounded-lg shadow p-6 flex flex-col items-center">
                <span class="text-4xl font-extrabold text-yellow-500"><%=dashboardData.getNbUnitesDisponibles()%></span>
                <span class="mt-2 text-gray-600">Appartements disponibles</span>
            </div>
            <div class="bg-white rounded-lg shadow p-6 flex flex-col items-center">
                <span class="text-4xl font-extrabold text-purple-600"><%=dashboardData.getNbContrats()%></span>
                <span class="mt-2 text-gray-600">Contrats</span>
            </div>
        </div>
        <!-- Section chiffre d'affaires -->
        <div class="bg-white rounded-lg shadow p-6 mb-8 flex flex-col items-center">
        <span class="text-4xl font-extrabold text-emerald-600">
           <%=dashboardData.getTotalLocation()%> FCFA
        </span>
            <span class="mt-2 text-gray-600">Chiffre d'affaires</span>
        </div>
        <div class="bg-white rounded-lg shadow p-6">
            <h3 class="text-xl font-semibold mb-4 text-gray-700">Détail par immeuble</h3>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Immeuble</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Appartements totaux</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Disponibles</th>
                    </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">

                    <c:forEach items="${dashboardData.getImmeubles()}" var="immeuble">
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap"><c:out value="${immeuble.nom}"/></td>
                            <td class="px-6 py-4"><c:out value="${immeuble.nbPieces}"/></td>
                            <td class="px-6 py-4">
                                <c:set var="nbDisponibles" value="0" />
                                <c:forEach items="${immeuble.unites}" var="unite">
                                    <c:if test="${unite.available}">
                                        <c:set var="nbDisponibles" value="${nbDisponibles + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:out value="${nbDisponibles}" />
                            </td>

                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!--<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold mb-6 text-gray-800">Tableau de bord</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <div class="bg-white rounded-lg shadow p-6 flex flex-col items-center">
                <span class="text-4xl font-extrabold text-blue-600"><%=dashboardData.getImmeubles().size()%></span>
                <span class="mt-2 text-gray-600">Immeubles</span>
            </div>
            <div class="bg-white rounded-lg shadow p-6 flex flex-col items-center">
                <span class="text-4xl font-extrabold text-green-600"><%=dashboardData.getNbUnites()%></span>
                <span class="mt-2 text-gray-600">Appartements totaux</span>
            </div>
            <div class="bg-white rounded-lg shadow p-6 flex flex-col items-center">
                <span class="text-4xl font-extrabold text-yellow-500"><%=dashboardData.getNbUnitesDisponibles()%></span>
                <span class="mt-2 text-gray-600">Appartements disponibles</span>
            </div>
            <div class="bg-white rounded-lg shadow p-6 flex flex-col items-center">
                <span class="text-4xl font-extrabold text-purple-600"><%=dashboardData.getNbContrats()%></span>
                <span class="mt-2 text-gray-600">Contrats</span>
            </div>
        </div>
        <div class="bg-white rounded-lg shadow p-6">
            <h3 class="text-xl font-semibold mb-4 text-gray-700">Détail par immeuble</h3>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Immeuble</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Appartements totaux</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Disponibles</th>
                    </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">

                    <c:forEach items="${dashboardData.getImmeubles()}" var="immeuble">
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap"><c:out value="${immeuble.nom}"/></td>
                            <td class="px-6 py-4"><c:out value="${immeuble.nbPieces}"/></td>
                            <td class="px-6 py-4">
                                <c:set var="nbDisponibles" value="0" />
                                <c:forEach items="${immeuble.unites}" var="unite">
                                    <c:if test="${unite.available}">
                                        <c:set var="nbDisponibles" value="${nbDisponibles + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:out value="${nbDisponibles}" />
                            </td>

                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
    </div>-->
</div>
</body>
</html>