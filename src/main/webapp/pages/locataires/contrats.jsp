<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<jsp:include  page="../header.jsp">
    <jsp:param name="title" value="Mes contrats" />
</jsp:include>
<body class="bg-gray-100 min-h-screen flex">
<jsp:include  page="navbar.jsp">
    <jsp:param name="page" value="contrats"/>
</jsp:include>
<!--<div class="flex-1">-->

<div class="max-w-20xl py-10 mx-70 px-10">
    <div class="mt-8 bg-white rounded-lg shadow-md">
        <div class="p-10">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-xl font-semibold">Mes contrats</h2>

            </div>
            <div class="overflow-x-auto">
                <table class="max-w-full divide-y divide-gray-200">
                    <thead>
                    <tr class="bg-gray-50">
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            ID
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Date de debut
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Date de fin
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Appartement (immeuble)
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Statut de la location
                        </th>


                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date du prochain paiement</th>

                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Actions
                        </th>

                    </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
<c:forEach items="${contrats}" var="c">
    <tr>
    <td class="px-6 py-4 whitespace-nowrap">${c.id}</td>
    <td class="px-6 py-4 whitespace-nowrap">${c.dateDebut}</td>
        <td class="px-6 py-4 whitespace-nowrap">${c.dateFin}</td>

        <td class="px-6 py-4 whitespace-nowrap">${c.unite.titre} (${c.unite.immeuble.nom})</td>
    <td class="px-6 py-4 whitespace-nowrap">${c.statut}</td>
        <td class="px-6 py-4 whitespace-nowrap">${c.dateProchainPaiement}</td>
        <c:if test="${c.statut eq 'ACTIVE'}">
            <td class="px-6 py-4 whitespace-nowrap">
                <a href="${pageContext.request.contextPath}/contrats?action=cancel&id=${c.id}"
                   class="bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded-lg">Annuler le contrat</a>
            </td>
        </c:if>

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
