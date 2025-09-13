<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Paiements</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto py-8">
        <h1 class="text-3xl font-bold mb-6 text-center">Liste des Paiements</h1>
        <form method="post" class="mb-8 bg-white p-6 rounded shadow">
            <!-- À compléter selon la logique métier -->
            <span class="text-gray-500">Formulaire d'ajout à compléter</span>
        </form>
        <table class="min-w-full bg-white rounded shadow">
            <thead>
                <tr>
                    <th class="py-2 px-4 border-b">Date</th>
                    <th class="py-2 px-4 border-b">Montant</th>
                    <th class="py-2 px-4 border-b">Statut</th>
                </tr>
            </thead>
            <tbody>
                <%-- Boucle sur la liste des paiements --%>
                <c:forEach var="paiement" items="${paiements}">
                    <tr>
                        <td class="py-2 px-4 border-b">${paiement.date}</td>
                        <td class="py-2 px-4 border-b">${paiement.montant}</td>
                        <td class="py-2 px-4 border-b">${paiement.statut}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
