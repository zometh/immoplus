<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Unités de Location</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto py-8">
        <h1 class="text-3xl font-bold mb-6 text-center">Liste des Unités de Location</h1>
        <form method="post" class="mb-8 bg-white p-6 rounded shadow">
            <div class="grid grid-cols-2 gap-4">
                <input name="numero" type="text" placeholder="Numéro" class="border p-2 rounded" required />
                <input name="nbPieces" type="number" placeholder="Nombre de pièces" class="border p-2 rounded" required />
                <input name="superficie" type="number" step="0.01" placeholder="Superficie" class="border p-2 rounded" required />
                <input name="loyer" type="number" step="0.01" placeholder="Loyer mensuel" class="border p-2 rounded" required />
            </div>
            <button type="submit" class="mt-4 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">Ajouter</button>
        </form>
        <table class="min-w-full bg-white rounded shadow">
            <thead>
                <tr>
                    <th class="py-2 px-4 border-b">Numéro</th>
                    <th class="py-2 px-4 border-b">Nombre de pièces</th>
                    <th class="py-2 px-4 border-b">Superficie</th>
                    <th class="py-2 px-4 border-b">Loyer mensuel</th>
                </tr>
            </thead>
            <tbody>
                <%-- Boucle sur la liste des unités --%>
                <c:forEach var="unite" items="${unites}">
                    <tr>
                        <td class="py-2 px-4 border-b">${unite.numero}</td>
                        <td class="py-2 px-4 border-b">${unite.nbPieces}</td>
                        <td class="py-2 px-4 border-b">${unite.superficie}</td>
                        <td class="py-2 px-4 border-b">${unite.loyer}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
