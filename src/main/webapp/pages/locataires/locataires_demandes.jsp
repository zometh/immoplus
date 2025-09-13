<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<jsp:include  page="../header.jsp">
    <jsp:param name="title" value="Mes demandes" />
</jsp:include>
<body class="bg-gray-100 min-h-screen flex">
<jsp:include  page="navbar.jsp">
    <jsp:param name="page" value="demandes"/>
</jsp:include>


    <div class="max-w-10xl py-10 mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="mt-8 bg-white rounded-lg shadow-md">
            <div class="p-6">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-semibold">Mes demandes</h2>

                </div>
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
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${u.statut eq 'EN_ATTENTE'}">
        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
            En attente
        </span>
                                        </c:when>
                                        <c:when test="${u.statut eq 'ACCEPTEE'}">
        <div class="flex items-center">
        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
            Acceptee

        </span>
            <c:if test="${u.unite.available == true}">
                <button data-modal-target="popup-modal${u.id}"
                        data-modal-toggle="popup-modal${u.id}"  href="${pageContext.request.contextPath}/unites?action=louer&id=${u.unite.id}"
                        class="text-blue-600 ml-2 text-xs px-2 leading-5 text-white hover:text-blue-900  rounded-full bg-blue-500">Louer</button>
                <div id="popup-modal${u.id}" tabindex="-1"
                     class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full flex">
                    <div class="relative p-4 w-full max-w-md max-h-full">
                        <div class="relative bg-white rounded-lg shadow-sm">
                            <button type="button"
                                    class="absolute top-3 end-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center"
                                    data-modal-hide="popup-modal${u.id}">
                                <svg class="w-3 h-3" aria-hidden="true"
                                     xmlns="http://www.w3.org/2000/svg" fill="none"
                                     viewBox="0 0 14 14">
                                    <path stroke="currentColor" stroke-linecap="round"
                                          stroke-linejoin="round" stroke-width="2"
                                          d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                                </svg>
                                <span class="sr-only">Close modal</span>
                            </button>
                            <div class="p-4 md:p-5 text-center">
                                <svg class="mx-auto mb-4 text-gray-400 w-12 h-12"
                                     aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                                     fill="none" viewBox="0 0 20 20">
                                    <path stroke="currentColor" stroke-linecap="round"
                                          stroke-linejoin="round" stroke-width="2"
                                          d="M10 11V6m0 8h.01M19 10a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/>
                                </svg>
                                <h3 class="mb-5 text-lg font-normal text-gray-500">
                                    Choisissez la durée de location en mois
                                </h3>
                                <form action="${pageContext.request.contextPath}/demandes" method="get" class="mb-5">
                                    <input type="hidden" name="action" value="louer">
                                    <input type="hidden" name="id" value="${u.unite.id}">
                                    <div class="mb-4">
                                        <input type="number" name="mois" min="3" max="120" required
                                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"
                                               placeholder="Nombre de mois">
                                    </div>
                                    <button type="submit"
                                            class="text-white bg-blue-600 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
                                        Confirmer
                                    </button>
                                </form>
                                <button data-modal-hide="popup-modal${u.id}" type="button"
                                        class="py-2.5 px-5 ms-3 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100">
                                    Non
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
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
    <!--</div>-->
</div>

</body>
</html>
