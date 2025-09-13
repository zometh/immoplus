<%@ page import="com.immoplus.app.immoplus.entities.Utilisateur" %>
<%
    String currentPage = request.getParameter("page");
    Utilisateur user = (Utilisateur) session.getAttribute("user");
%>
<div class="w-64 bg-gradient-to-b from-blue-800 to-blue-600 min-h-screen text-white fixed">
    <div class="p-6">
        <h1 class="text-3xl font-bold mb-8">ImmoPLUS</h1>
        <div class="mb-8">
            <p class="text-lg">Bienvenue, <%=user.getNom()%>
            </p>
        </div>
        <nav class="space-y-4">
            <a href="${pageContext.request.contextPath}/locataires"
               class="flex items-center py-3 px-6 rounded-lg transition duration-200 hover:bg-blue-700 hover:shadow-lg <%= "home".equals(currentPage) ? "bg-blue-900" : "" %>">
                <i class="fas fa-home mr-3"></i>Accueil
            </a>
            <a href="${pageContext.request.contextPath}/locataires?action=profil"
               class="flex items-center py-3 px-6 rounded-lg transition duration-200 hover:bg-blue-700 hover:shadow-lg <%= "profil".equals(currentPage) ? "bg-blue-900" : "" %>">
                <i class="fas fa-user mr-3"></i>Mon Profil
            </a>
            <a href="${pageContext.request.contextPath}/demandes?action=list"
               class="flex items-center py-3 px-6 rounded-lg transition duration-200 hover:bg-blue-700 hover:shadow-lg <%= "demandes".equals(currentPage) ? "bg-blue-900" : "" %>">
                <i class="fas fa-code-pull-request mr-3"></i>Mes demandes
            </a>
            <a href="${pageContext.request.contextPath}/contrats"
               class="flex items-center py-3 px-6 rounded-lg transition duration-200 hover:bg-blue-700 hover:shadow-lg <%= "contrats".equals(currentPage) ? "bg-blue-900" : "" %>">
                <i class="fas fa-building mr-3"></i>Mes contrats
            </a>
            <a href="${pageContext.request.contextPath}/paiements"
               class="flex items-center py-3 px-6 rounded-lg transition duration-200 hover:bg-blue-700 hover:shadow-lg <%= "paiements".equals(currentPage) ? "bg-blue-900" : "" %>">
                <i class="fas fa-building mr-3"></i>Mes paiements
            </a>
            <a href="${pageContext.request.contextPath}/logout"
               class="flex items-center py-3 px-6 rounded-lg transition duration-200 hover:bg-red-500 hover:shadow-lg mt-auto">
                <i class="fas fa-sign-out-alt mr-3"></i>Se déconnecter
            </a>
        </nav>
    </div>
</div>