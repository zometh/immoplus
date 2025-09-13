<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.immoplus.app.immoplus.entities.Utilisateur" %>
<%@ page import="com.immoplus.app.immoplus.services.UtilisateurService" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: metzo
  Date: 02/09/2025
  Time: 12:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Utilisateur user = (Utilisateur) session.getAttribute("user");
    String name = user.getNom();
    UtilisateurService utilisateurService = new UtilisateurService();

%>
<html>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Utilisateurs"/>
</jsp:include>

<body class="bg-gray-100 min-h-screen flex">
<jsp:include page="../navbar.jsp">
    <jsp:param name="page" value="users"/>
</jsp:include>
<div class="flex-1">
    <jsp:include page="admin-header.jsp">
        <jsp:param name="name" value="<%= name  %>"/>
    </jsp:include>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="mt-8 bg-white rounded-lg shadow-md">
            <div class="p-6">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-semibold">Liste des utilisateurs</h2>
                    <a href="?action=new"
                       class="bg-green-500 hover:bg-green-600 text-white font-semibold py-2 px-4 rounded-lg">
                        Ajouter un utilisateur
                    </a>
                </div>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead>
                        <tr class="bg-gray-50">
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                ID
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Nom complet
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Adresse email
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Role
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Actions
                            </th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${users}" var="u">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">${u.id}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.nom}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.email}</td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 py-1 text-xs font-semibold text-green-800 bg-green-100 rounded-full">
                                            ${u.role}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:if test="${u.email ne user.getEmail()}">
                                        <a href="?action=edit&id=${u.id}"
                                           class="text-white font-semibold bg-blue-500 text-xs rounded-full px-2 py-1 hover:text-indigo-900 mr-4">Modifier</a>
                                        <a href="?action=delete&id=${u.id}"
                                           class="text-white font-semibold bg-red-500 text-xs rounded-full px-2 py-1 hover:text-red-900">Supprimer</a>
                                    </c:if>
                                </td>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>