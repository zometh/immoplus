

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String currentPage = request.getParameter("page");
%>
<div class="w-64 bg-blue-800 min-h-screen text-white">
    <div class="p-4">
        <h1 class="text-2xl font-bold mb-6">ImmoPLUS</h1>
        <nav>
            <a href="${pageContext.request.contextPath}/immeubles?action=home" class="block py-2.5 px-4 rounded transition duration-200 hover:bg-blue-700<%= "home-props".equals(currentPage) ? " bg-blue-900" : "" %>">
                <i class="fas fa-home mr-2"></i>Tableau de bord
            </a>
            <a href="${pageContext.request.contextPath}/immeubles?action=list" class="block py-2.5 px-4 rounded transition duration-200 hover:bg-blue-700<%= "immeubles".equals(currentPage) ? " bg-blue-900" : "" %>">
                <i class="fas fa-users mr-2"></i>Immeubles
            </a>
            <a href="${pageContext.request.contextPath}/immeubles?action=profil"
               class="flex items-center py-3 px-6 rounded-lg transition duration-200 hover:bg-blue-700 hover:shadow-lg <%= "profil".equals(currentPage) ? "bg-blue-900" : "" %>">
                <i class="fas fa-user mr-3"></i>Mon Profil
            </a>
            <a href="${pageContext.request.contextPath}/unites" class="block py-2.5 px-4 rounded transition duration-200 hover:bg-blue-700<%= "unites".equals(currentPage) ? " bg-blue-900" : "" %>">
                <i class="fas fa-chart-line mr-2"></i>Unités de location
            </a>
            <a href="${pageContext.request.contextPath}/immeubles?action=contrats"
               class="flex items-center py-3 px-6 rounded-lg transition duration-200 hover:bg-blue-700 hover:shadow-lg <%= "contrats".equals(currentPage) ? "bg-blue-900" : "" %>">
                <i class="fas fa-building mr-3"></i>Les contrats
            </a>
            <a href="${pageContext.request.contextPath}/demandes?action=owner" class="block py-2.5 px-4 rounded transition duration-200 hover:bg-blue-700<%= "demandes".equals(currentPage) ? " bg-blue-900" : "" %>">
                <i class="fas fa-history mr-2"></i>Demandes de location
            </a>
        </nav>
    </div>
</div>
