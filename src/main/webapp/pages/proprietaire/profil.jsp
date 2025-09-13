<%@ page import="com.immoplus.app.immoplus.entities.Utilisateur" %><%
    Utilisateur user = (Utilisateur) session.getAttribute("user");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Mon Profil"/>
</jsp:include>
<body class="flex min-h-screen flex bg-gray-100">
<jsp:include page="navbar.jsp">
    <jsp:param name="page" value="profil"/>
</jsp:include>
<div class="flex-1">


    <main class="flex-1 p-8 ml-64">
        <h1 class="text-3xl font-bold mb-8 text-gray-800">Mon Profil</h1>

        <!-- Section: Informations actuelles -->
        <section class="mb-10">
            <h2 class="text-2xl font-semibold mb-6 text-gray-700">Informations du locataire</h2>
            <div class="bg-white shadow-lg rounded-lg p-8 space-y-4 hover:shadow-xl transition duration-300">
                <p class="flex items-center text-gray-700"><span
                        class="font-semibold w-24">Nom:</span> <%= user.getNom() %>
                </p>
                <p class="flex items-center text-gray-700"><span
                        class="font-semibold w-24">Email:</span> <%= user.getEmail() %>
                </p>
                <p class="flex items-center text-gray-700"><span
                        class="font-semibold w-24">Role:</span> <%= user.getRole() == null ? "-" : user.getRole() %>
                </p>
            </div>
        </section>

        <!-- Section: Formulaire de modification -->
        <section>
            <h2 class="text-2xl font-semibold mb-6 text-gray-700">Modifier mes informations</h2>
            <form method="post" action="<%=request.getContextPath()%>/immeubles?action=update-info"
                  class="bg-white shadow-lg rounded-lg p-8 grid grid-cols-1 gap-6 max-w-2xl hover:shadow-xl transition duration-300">
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="nom">Nom complet</label>
                    <input id="nom" name="nom" type="text" value="<%= user.getNom() %>"
                           class="w-full border-2 border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition duration-200"/>
                </div>
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="nom">Nouveau mot de passe</label>
                    <input id="nom" name="password" type="password"
                           class="w-full border-2 border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition duration-200"/>
                </div>

                <div class="pt-4">
                    <button type="submit"
                            class="w-full bg-blue-600 text-white px-6 py-3 rounded-lg font-medium hover:bg-blue-700 transform hover:scale-105 transition duration-200">
                        Enregistrer
                    </button>
                </div>

                <!-- Conserve le surlignage du menu après PRG -->
                <input type="hidden" name="page" value="profil"/>
            </form>
        </section>
    </main>
</div>
</body>
</html>
