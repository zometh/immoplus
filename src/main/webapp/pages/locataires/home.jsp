<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Accueil Locataire"/>
</jsp:include>
<body class="bg-gray-100">
<div class="flex min-h-screen">
    <!-- Navigation -->
    <jsp:include page="navbar.jsp">
        <jsp:param name="page" value="home"/>
    </jsp:include>

    <!-- Main Content -->
    <div class="flex-1 p-4 md:p-8 ml-0 md:ml-64">
        <!-- Search and Filter -->
        <div class="mb-8">
            <div class="bg-white p-4 md:p-6 rounded-xl shadow-lg">
                <div class="flex flex-col md:flex-row gap-4 md:gap-6 items-start md:items-center">
                    <form action="${pageContext.request.contextPath}/locataires" method="get">
                        <input type="hidden" name="action" value="search"/>
                        <input type="text" name="search" placeholder="Rechercher par titre ou localisation"
                               class="w-full md:w-96 p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"/>
                        <input type="number" name="nbPieces" placeholder="Nombre de pièces"
                               class="w-full md:w-50 p-3 border border-gray-300 rounded-lg
                               focus:outline-none focus:ring-2 focus:ring-blue-500"/>
                        <select name="prix" class="w-full md:w-48 p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="0">Tous</option>
                            <option value="1">Plus cher</option>
                            <option value="2">Moins cher</option>
                        </select>
                        <button type="submit"
                                class="mt-2 md:mt-0 w-full md:w-auto bg-blue-600 text-white px-6 py-3 rounded-lg font-medium hover:bg-blue-700 transform hover:scale-105 transition duration-200">
                            Rechercher
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Rental Listings -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-8">
            <c:forEach items="${unites}" var="u">
            <div class="bg-white rounded-xl shadow-lg overflow-hidden transform hover:scale-105 transition duration-200">
                <img src="${pageContext.request.contextPath}/${u.imagePath}" alt="Appartement"
                     class="w-full h-48 md:h-56 object-cover"/>
                <div class="p-4 md:p-6">
                    <h3 class="text-lg md:text-xl font-bold mb-2">${u.titre}</h3>
                    <div class="flex items-center text-gray-600 mb-4">
                        <i class="fas fa-door-open mr-2"></i>${u.nbPieces} pièce (s)
                        <i class="fas fa-ruler-combined ml-4 mr-2"></i>${u.superficie.intValue()} m²
                    </div>
                    <p class="text-blue-600 text-xl md:text-2xl font-bold mb-4">${u.loyer.intValue()} FCFA/mois</p>
                    <a href="${pageContext.request.contextPath}/locataires?action=details&&id=${u.id}"
                       class="w-full inline-block text-center bg-blue-600 text-white py-3 rounded-lg font-medium hover:bg-blue-700 transform hover:scale-105 transition duration-200">
                        Voir le détail
                    </a>
                </div>
            </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>