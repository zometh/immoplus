<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<jsp:include  page="../header.jsp">
    <jsp:param name="title" value="Mes paiements" />
</jsp:include>
<body class="bg-gray-100 min-h-screen flex">
<jsp:include  page="navbar.jsp">
    <jsp:param name="page" value="paiements"/>
</jsp:include>
<!--<div class="flex-1">-->

<div class="max-w-20xl py-10 mx-auto px-4">
    <div class="mt-8 bg-white rounded-lg shadow-md">
        <div class="p-6">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-xl font-semibold">Mes paiements</h2>

            </div>
            <div class="overflow-x-auto">
                <table class="max-w-full divide-y divide-gray-200">
                    <thead>
                    <tr class="bg-gray-50">
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            ID
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Date
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Montant
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Appartement (immeuble)
                        </th>



                        <!--<th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Actions
                        </th>-->
                    </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach items="${paiements}" var="p">
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">${p.id}</td>
                            <td class="px-6 py-4 whitespace-nowrap">${p.date}</td>
                            <td class="px-6 py-4 whitespace-nowrap">${p.montant} FCFA</td>

                            <td class="px-6 py-4 whitespace-nowrap">${p.contrat.unite.titre} (${p.contrat.unite.immeuble.nom})</td>

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
