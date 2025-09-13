<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Détails de l'Appartement"/>
</jsp:include>
<body class="bg-gray-100 min-h-screen">
<div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <a href="${pageContext.request.contextPath}/locataires"
       class="inline-flex items-center text-blue-600 hover:text-blue-700 mb-6">
        <span class="mr-2">←</span> Retour aux offres
    </a>

    <c:if test="${not empty unite}">
        <div class="bg-white rounded-xl shadow-md overflow-hidden">
            <div class="w-full">
                <img src="${pageContext.request.contextPath}/${unite.imagePath}" alt="Photo de l'appartement"
                     class="w-full h-72 object-cover">
            </div>
            <div class="p-6">
                <h1 class="text-2xl font-bold mb-4">
                    Appartement ${unite.nbPieces} pièce(s) - ${unite.superficie.intValue()} m²
                </h1>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                    <div class="space-y-3">
                        <div class="flex items-center">
                            <span class="font-medium w-40 text-gray-600">Loyer:</span>
                            <span class="text-xl font-semibold text-blue-600">${unite.loyer.intValue()} FCFA / mois</span>
                        </div>
                        <div class="flex items-center">
                            <span class="font-medium w-40 text-gray-600">Superficie:</span>
                            <span>${unite.superficie.intValue()} m²</span>
                        </div>
                        <div class="flex items-center">
                            <span class="font-medium w-40 text-gray-600">Nombre de pièces:</span>
                            <span>${unite.nbPieces}</span>
                        </div>
                        <div class="flex items-center">
                            <span class="font-medium w-40 text-gray-600">Titre:</span>
                            <span><c:out value="${unite.titre}" /></span>
                        </div>
                    </div>

                    <div class="space-y-3">
                        <div class="flex items-start">
                            <span class="font-medium w-40 text-gray-600">Immeuble:</span>
                            <span class="text-gray-800">
                                <c:out value="${unite.immeuble.nom}" />
                            </span>
                        </div>
                        <div class="flex items-start">
                            <span class="font-medium w-40 text-gray-600">Adresse:</span>
                            <span class="text-gray-800">
                                <c:out value="${unite.immeuble.adresse}" />
                            </span>
                        </div>
                        <div class="flex items-start">
                            <span class="font-medium w-40 text-gray-600">Description:</span>
                            <span class="text-gray-800">
                                <c:out value="${unite.immeuble.description}" />
                            </span>
                        </div>
                        <div class="flex items-start">
                            <span class="font-medium w-40 text-gray-600">Équipements:</span>
                            <span class="text-gray-800">
                                <c:out value="${unite.immeuble.equipements}" />
                            </span>
                        </div>
                        <div class="flex items-start">
                            <span class="font-medium w-40 text-gray-600">Publié par:</span>
                            <span class="text-gray-800 font-bold">
                                <c:out value="${unite.immeuble.utilisateur.nom}" />
                            </span>
                        </div>
                    </div>
                </div>

                <div class="mt-6 flex gap-4">
                    <a href="${pageContext.request.contextPath}/locataires"
                       class="px-5 py-2 rounded-md bg-gray-200 text-gray-800 hover:bg-gray-300">
                        Retour
                    </a>
                    <c:if test="${existingDemande}">
                        <a href="${pageContext.request.contextPath}/demandes?action=cancel&&id=${unite.id}"
                           class="px-5 py-2 rounded-md bg-red-600 text-white hover:bg-red-700">
                            Annuler la demande de location
                        </a>
                    </c:if>
                    <c:if test="${!existingDemande}">
                        <a href="${pageContext.request.contextPath}/demandes?action=save&&id=${unite.id}"
                           class="px-5 py-2 rounded-md bg-blue-600 text-white hover:bg-blue-700">
                            Envoyer une demande de location
                        </a>
                    </c:if>


                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${empty unite}">
        <div class="bg-white rounded-xl shadow p-6 text-center">
            <p class="text-gray-600">Appartement introuvable.</p>
            <a href="${pageContext.request.contextPath}/locataires" class="text-blue-600 hover:text-blue-700">
                Revenir aux offres
            </a>
        </div>
    </c:if>
</div>
</body>
</html>
