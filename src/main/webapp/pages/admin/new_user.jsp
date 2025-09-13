<%--
  Created by IntelliJ IDEA.
  User: metzo
  Date: 03/09/2025
  Time: 14:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Nouveau utilisateur"/>
</jsp:include>
<body class="bg-gradient-to-r from-blue-100 to-blue-200 min-h-screen flex items-center justify-center">
<div class="container mx-auto px-4">
    <div class="max-w-md mx-auto bg-white rounded-lg shadow-xl overflow-hidden">
        <div class="bg-blue-600 px-6 py-4">
            <h1 class="text-3xl font-bold text-white text-center">Nouveau utilisateur</h1>
        </div>
        <form method="post" action="?action=save" class="p-8 space-y-6">
            <div class="space-y-2">
                <label class="text-sm font-medium text-gray-700">Nom complet</label>
                <input name="nom" type="text" placeholder="Entrez votre nom complet"
                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                       required/>
            </div>
            <div class="space-y-2">
                <label class="text-sm font-medium text-gray-700">Email</label>
                <input name="email" type="email" placeholder="Entrez votre email"
                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                       required/>
            </div>
            <div class="space-y-2">
                <label class="text-sm font-medium text-gray-700">Mot de passe</label>
                <input name="password" type="password" placeholder="Entrez votre mot de passe"
                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                       required/>
            </div>

            <div class="space-y-2">
                <label class="text-sm font-medium text-gray-700">Rôle</label>
                <select name="role"
                        class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                        required>
                    <option value="">Sélectionnez un rôle</option>
                    <option value="ADMINISTRATEUR">Administrateur</option>
                    <option value="LOCATAIRE">Locataire</option>
                    <option value="PROPRIETAIRE">Propriétaire</option>
                </select>
            </div>
            <button type="submit"
                    class="w-full px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors duration-200">
                Ajouter
            </button>
            <% if (request.getAttribute("error") != null) { %>
            <div class="p-4 text-red-600 bg-red-50 rounded-md text-center">${error}</div>
            <% } %>
        </form>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.querySelector('form');
        form.addEventListener('submit', function (e) {
            // Supprimer les alertes existantes
            const oldAlert = document.getElementById('form-alert');
            if (oldAlert) oldAlert.remove();

            const nom = form.querySelector('input[name="nom"]').value.trim();
            const email = form.querySelector('input[name="email"]').value.trim();
            const password = form.querySelector('input[name="password"]').value;
            const confirmPassword = form.querySelector('input[name="confirm_password"]').value;
            const role = form.querySelector('select[name="role"]').value;

            let message = '';
            if (!nom || !email || !password || !confirmPassword || !role) {
                message = 'Veuillez remplir tous les champs.';
            } else if (password !== confirmPassword) {
                message = 'Les mots de passe ne correspondent pas.';
            }

            if (message) {
                e.preventDefault();
                const alertDiv = document.createElement('div');
                alertDiv.id = 'form-alert';
                alertDiv.className = 'p-4 mb-4 text-red-700 bg-red-100 rounded-md text-center border border-red-300';
                alertDiv.textContent = message;
                form.parentNode.insertBefore(alertDiv, form);
            }
        });
    });
</script>
</body>
</html>

