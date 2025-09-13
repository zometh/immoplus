<%--
  Created by IntelliJ IDEA.
  User: metzo
  Date: 02/09/2025
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String currentPage = request.getParameter("page");
%>
<div class="w-64 bg-blue-800 min-h-screen text-white">
    <div class="p-4">
        <h1 class="text-2xl font-bold mb-6">ImmoPLUS</h1>
        <nav>
            <a href="/admin" class="block py-2.5 px-4 rounded transition duration-200 hover:bg-blue-700<%= "admin".equals(currentPage) ? " bg-blue-900" : "" %>">
                <i class="fas fa-home mr-2"></i>Tableau de bord
            </a>
            <a href="/users" class="block py-2.5 px-4 rounded transition duration-200 hover:bg-blue-700<%= "users".equals(currentPage) ? " bg-blue-900" : "" %>">
                <i class="fas fa-users mr-2"></i>Utilisateurs
            </a>
            <a href="${pageContext.request.contextPath}/admin?action=immeubles"
               class="flex items-center py-3 px-6 rounded-lg transition duration-200 hover:bg-blue-700 hover:shadow-lg <%= "immeubles".equals(currentPage) ? "bg-blue-900" : "" %>">
                <i class="fas fa-building mr-3"></i>Les immeubles
            </a>

        </nav>
    </div>
</div>
