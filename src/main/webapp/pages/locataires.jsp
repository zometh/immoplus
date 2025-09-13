<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Locataires</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto py-8">
        <h1 class="text-3xl font-bold mb-6 text-center">Liste des Locataires</h1>
        <form method="post" class="mb-8 bg-white p-6 rounded shadow">
            <div class="grid grid-cols-2 gap-4">
                <input name="nom" type="text" placeholder="Nom" class="border p-2 rounded" required />
                <input name="email" type="email" placeholder="Email" class="border p-2 rounded" required />
                <input name="infosPerso" type="text" placeholder="Infos personnelles" class="border p-2 rounded" />
            </div>
            <button type="submit" class="mt-4 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">Ajouter</button>
        </form>
        <table class="min-w-full bg-white rounded shadow">
            <thead>
                <tr>
                    <th class="py-2 px-4 border-b">Nom</th>
                    <th class="py-2 px-4 border-b">Email</th>
                    <th class="py-2 px-4 border-b">Infos personnelles</th>
                </tr>
            </thead>
            <tbody>
                <%-- Boucle sur la liste des locataires --%>
                <c:forEach var="locataire" items="${locataires}">
                    <tr>
                        <td class="py-2 px-4 border-b">${locataire.nom}</td>
                        <td class="py-2 px-4 border-b">${locataire.email}</td>
                        <td class="py-2 px-4 border-b">${locataire.infosPerso}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
