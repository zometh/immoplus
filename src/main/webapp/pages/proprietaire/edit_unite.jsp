<%@ page import="com.immoplus.app.immoplus.entities.Immeuble" %>
<%@ page import="java.util.List" %>
<%@ page import="com.immoplus.app.immoplus.entities.UniteLocation" %><%
    UniteLocation unite = (UniteLocation) request.getAttribute("unite");

%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Edit d'une unité de location"/>
</jsp:include>
<body class="bg-gray-100 min-h-screen flex">
<div class="flex-1">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="bg-white rounded-lg shadow-md">
            <div class="p-6">
                <h2 class="text-xl font-semibold mb-4">Modifier une unité de location</h2>

                <form method="post" action="${pageContext.request.contextPath}/unites?action=update&&id=<%=unite.getId()%>" class="space-y-6" enctype="multipart/form-data">
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Titre</label>
                        <input value="<%=unite.getTitre()%>" name="titre" type="text" placeholder="Saisissez le tire de l'unité"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Nombre de pièces</label>
                        <input value="<%=unite.getNbPieces()%>" name="nbPieces" type="number" placeholder="Saisissez le nombre de pièces"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>

                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Loyer</label>
                        <input value="<%=unite.getLoyer()%>"  name="loyer" type="number" placeholder="Saisissez le prix du loyer"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>

                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Superficie</label>
                        <input value="<%=unite.getSuperficie()%>"  name="superficie" type="number" placeholder="Saisissez la superficie en m²"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               required/>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-gray-700">Image</label>
                        <input  name="image" type="file" accept="image/*"
                               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                               />
                    </div>
                    <div class="flex justify-end space-x-4">
                        <button type="submit"
                                class="px-4 py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors duration-200">
                            Modifier
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
