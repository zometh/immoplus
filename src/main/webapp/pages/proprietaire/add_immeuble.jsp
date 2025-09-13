<%--
  Created by IntelliJ IDEA.
  User: metzo
  Date: 04/09/2025
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Ajout d'un immeuble"/>
</jsp:include>
<body class="bg-gray-100 min-h-screen flex">
<div class="flex-1">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="bg-white rounded-lg shadow-md">
            <div class="p-6">
                <h2 class="text-xl font-semibold mb-4">Ajouter un immeuble</h2>
                <form method="post" action="${pageContext.request.contextPath}/immeubles?action=save" class="space-y-6" enctype="multipart/form-data">
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Nom de l'immeuble</label>
                        <input name="nom" type="text" placeholder="Entrez le nom de l'immeuble"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Adresse</label>
                        <input name="adresse" type="text" placeholder="Entrez l'adresse"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Description</label>
                        <input name="description" type="text" placeholder="Entrez la description"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Equipements</label>
                        <input name="equipements" type="text" placeholder="Saisissez les équipements disponibles"
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
                        <a href="immeubles"
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