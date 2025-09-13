<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<jsp:include  page="../header.jsp">
    <jsp:param name="title" value="Les contrats" />
</jsp:include>
<body class="bg-gray-100 min-h-screen flex">
<jsp:include  page="navbar.jsp">
    <jsp:param name="page" value="contrats"/>
</jsp:include>
<!--<div class="flex-1">-->

<div class="max-w-15xl py-10 mx-5 px-5">
    <div class="mt-8 bg-white rounded-lg shadow-md">
        <div class="p-10">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-xl font-semibold">Les contrats de mes appartements</h2>

            </div>
            <div class="overflow-x-auto">
                <table class="max-w-15xl divide-y divide-gray-200">
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
                            Locataire
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Statut de la location
                        </th>


                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date du prochain paiement</th>



                    </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
<c:forEach items="${contrats}" var="c">
    <tr>
    <td class="px-6 py-4 whitespace-nowrap">${c.id}</td>
    <td class="px-6 py-4 whitespace-nowrap">${c.dateDebut}</td>
        <td class="px-6 py-4 whitespace-nowrap">${c.dateFin}</td>

        <td class="px-6 py-4 whitespace-nowrap">${c.unite.titre} (${c.unite.immeuble.nom})</td>
        <td class="px-6 py-4 whitespace-nowrap">${c.locataire.nom}</td>
        <td class="px-6 py-4 whitespace-nowrap">${c.statut}</td>
        <td class="px-6 py-4 whitespace-nowrap">${c.dateProchainPaiement}</td>


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
