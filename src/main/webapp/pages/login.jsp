<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gradient-to-r from-blue-100 to-blue-200 min-h-screen flex items-center justify-center">
<div class="container mx-auto px-4">
    <div class="max-w-md mx-auto bg-white rounded-lg shadow-xl overflow-hidden">
        <div class="bg-blue-600 px-6 py-4">
            <h1 class="text-3xl font-bold text-white text-center">Connexion</h1>
        </div>
        <form method="post" action="login" class="p-8 space-y-6">
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

            <button type="submit"
                    class="w-full px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors duration-200">
                Se connecter
            </button>
            <a href="${pageContext.request.contextPath}/register"
               class="block w-full px-4 py-2 text-center text-blue-600 border border-blue-600 rounded-md hover:bg-blue-50 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors duration-200">
                S'inscrire
            </a>
            <% if (request.getAttribute("error") != null) { %>
            <div class="p-4 text-red-600 bg-red-50 rounded-md text-center">${error}</div>
            <% } %>
            
        </form>
        
    </div>
</div>
<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        const email = this.email.value.trim();
        const password = this.password.value.trim();
        let errorMsg = '';
        if (!email) {
            errorMsg = "Veuillez entrer votre email.";
        } else if (!password) {
            errorMsg = "Veuillez entrer votre mot de passe.";
        }
        if (errorMsg) {
            e.preventDefault();
            let alertDiv = document.getElementById('form-error-alert');
            if (!alertDiv) {
                alertDiv = document.createElement('div');
                alertDiv.id = 'form-error-alert';
                alertDiv.className = 'p-4 text-red-600 bg-red-50 rounded-md text-center mb-4';
                this.prepend(alertDiv);
            }
            alertDiv.textContent = errorMsg;
        }
    });
</script>
</body>
</html>