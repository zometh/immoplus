<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<jsp:include  page="../header.jsp">
    <jsp:param name="title" value="Demandes de location" />
</jsp:include>
<body class="bg-gray-100 min-h-screen flex">
<jsp:include  page="navbar.jsp">
    <jsp:param name="page" value="demandes"/>
</jsp:include>
<div class="flex-1">
    <jsp:include page="../admin/admin-header.jsp">
        <jsp:param name="name" value=""/>
    </jsp:include>
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <h2 class="text-xl font-semibold">Liste des demandes</h2>

            <div class="mt-8 bg-white rounded-lg shadow-md">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead>
                        <tr class="bg-gray-50">
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                ID
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Date
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Appartement (immeuble)
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Locataire
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Statut de la demande
                            </th>
                            <!--<th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Actions
                            </th>-->
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${demandes}" var="u">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">${u.id}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.dateDemande}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.unite.titre} (${u.unite.immeuble.nom})</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.locataire.nom}</td>

                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${u.statut eq 'EN_ATTENTE'}">
        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
            En attente
            <div class="ml-2">
                <a href="${pageContext.request.contextPath}/demandes?action=accept&id=${u.id}" class="text-green-600 hover:text-green-900">✓</a>
                <a href="${pageContext.request.contextPath}/demandes?action=reject&id=${u.id}" class="text-red-600 hover:text-red-900 ml-1">✗</a>
            </div>
        </span>
                                        </c:when>
                                        <c:when test="${u.statut eq 'ACCEPTEE'}">
        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
            Acceptée
        </span>
                                        </c:when>
                                        <c:when test="${u.statut eq 'REFUSEE'}">
        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
            Refusée
        </span>
                                        </c:when>
                                        <c:otherwise>
        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">
                ${u.statut}
        </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>


                                

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
</div>
</body>