<%@ page import="com.immoplus.app.immoplus.entities.Utilisateur" %><%--
  Created by IntelliJ IDEA.
  User: metzo
  Date: 02/09/2025
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Utilisateur user = (Utilisateur) session.getAttribute("user");

%>

<nav class="bg-white shadow-lg">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-end h-16 items-center">
            <div class="flex items-center">
                <span class="text-sm mr-4">Bienvenue, <%= !user.getNom().isEmpty() ? user.getNom() : "Invité" %></span>
                <a href="/login"
                   class="bg-red-500 hover:bg-red-700 px-4 py-2 rounded-md text-sm font-medium text-white">
                    Déconnexion
                </a>
            </div>
        </div>
    </div>
</nav>
