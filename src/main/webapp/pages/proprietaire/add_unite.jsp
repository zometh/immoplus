<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Ajouter d'une unité de location"/>
</jsp:include>
<body class="bg-gray-100 min-h-screen flex">
<div class="flex-1">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="bg-white rounded-lg shadow-md">
            <div class="p-6">
                <h2 class="text-xl font-semibold mb-4">Ajouter une unité de location</h2>
                <form method="post" action="${pageContext.request.contextPath}/unites?action=save" class="space-y-6" enctype="multipart/form-data">
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Titre</label>
                        <input  name="titre" type="text" placeholder="Saisissez le tire de l'unité"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Nombre de pièces</label>
                        <input name="nbPieces" type="number" placeholder="Saisissez le nombre de pièces"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Immeuble</label>
                        <select name="immeubleId"
                                class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                required>
                            <c:forEach items="${immeubles}" var="immeuble">
                                <option value="${immeuble.id}">${immeuble.nom}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Loyer</label>
                        <input name="loyer" type="number" placeholder="Saisissez le prix du loyer"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>

                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Superficie</label>
                        <input name="superficie" type="number" placeholder="Saisissez la superficie en m²"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Image</label>
                        <input name="image" type="file" accept="image/*"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>
                    <div class="flex justify-end space-x-4">
                        <button type="submit"
                                class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors duration-200">
                            Ajouter
                        </button>
                        <a href="unites?action=list"
                           class="px-4 py-2 text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-colors duration-200">
                            Annuler
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<!--<body class="bg-gray-100">
<div class="flex">
    <div class="flex-1 p-8">
        <h1 class="text-2xl font-bold mb-6">Ajouter une unité de location</h1>

        <form action="/unites" method="post" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 max-w-2xl">
            <input type="hidden" name="action" value="save">

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="immeubleId">
                    Immeuble
                </label>
                <select name="immeubleId" id="immeubleId"
                        class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                    <c:forEach items="${immeubles}" var="immeuble">
                        <option value="${immeuble.id}" ${immeuble.id == selectedImmeubleId ? 'selected' : ''}>
                                ${immeuble.nom}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="numero">
                    Numéro
                </label>
                <input type="text" name="numero" id="numero"
                       class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="description">
                    Description
                </label>
                <textarea name="description" id="description" rows="3"
                          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></textarea>
            </div>

            <div class="flex items-center justify-between">
                <button type="submit"
                        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                    Enregistrer
                </button>
                <a href="/unites"
                   class="inline-block align-baseline font-bold text-sm text-blue-500 hover:text-blue-800">
                    Annuler
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
-->