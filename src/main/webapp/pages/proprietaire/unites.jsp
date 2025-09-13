<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.immoplus.app.immoplus.entities.Utilisateur" %>
<%@ page import="com.immoplus.app.immoplus.entities.Immeuble" %>
<%@ page import="com.immoplus.app.immoplus.services.ImmeubleService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Utilisateur user = (Utilisateur) session.getAttribute("user");
    String name = user.getNom();
    ImmeubleService immeubleService = new ImmeubleService();
    Long immeubleId = (Long) request.getAttribute("immeubleId");
    Immeuble i = null;
    if (immeubleId != null) {
        i = immeubleService.findById(immeubleId);
    }
%>
<!DOCTYPE html>
<html lang="fr">
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Unités de location"/>
</jsp:include>
<body class="bg-gray-100 min-h-screen flex">
<jsp:include page="navbar.jsp">
    <jsp:param name="page" value="unites"/>
</jsp:include>
<div class="flex-1">
    <jsp:include page="../admin/admin-header.jsp">
        <jsp:param name="name" value="<%= name  %>"/>
    </jsp:include>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="mt-8 bg-white rounded-lg shadow-md">
            <div class="p-6">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-semibold">Liste des appartements de l'immeuble
                        : <%= i != null ? i.getNom() : "" %>
                    </h2>
                    <c:if test="${not empty immeubleId}">
                        <a href="${pageContext.request.contextPath}/unites?action=list"
                           class="bg-gray-500 hover:bg-gray-600 text-white font-semibold py-2 px-4 rounded-lg">
                            <a href="${pageContext.request.contextPath}/unites?action=new"
                               class="bg-green-500 hover:bg-green-600 text-white font-semibold py-2 px-4 rounded-lg">
                                Ajouter une unité de location
                            </a>
                        </a>
                    </c:if>

                </div>
                <div class="mb-6">
                    <label for="immeuble-filter" class="block text-sm font-semibold text-gray-800 mb-2">Filtrer par
                        immeuble</label>
                    <div class="relative">
                        <select id="immeuble-filter" name="immeuble"
                                class="w-full appearance-none bg-white border border-gray-300 rounded-lg px-4 py-2.5 pr-8 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200"
                                onchange="window.location.href='${pageContext.request.contextPath}/unites?immeubleId=' + this.value;">
                            <c:forEach items="${immeubles}" var="immeuble">
                                <option value="${immeuble.id}"
                                        <c:if test="${immeubleId == immeuble.id}">selected</c:if>>${immeuble.nom}</option>
                            </c:forEach>
                        </select>
                        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead>
                        <tr class="bg-gray-50">
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                ID
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Titre
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Nombre de pieces
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Superficie (m²)
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Prix du loyer (FCFA)
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Immeuble lié
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Image
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Actions
                            </th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${unites}" var="u">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">${u.id}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.titre}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.nbPieces}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.superficie}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.loyer}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.immeuble.nom}</td>

                                <td class="px-6 py-4 whitespace-nowrap">
                                    <img src="${pageContext.request.contextPath}/${u.imagePath}
" alt="image" width="100" height="100">
                                </td>

                                <td class="px-6 py-4 whitespace-nowrap">

                                    <a href="${pageContext.request.contextPath}/unites?action=edit&id=${u.id}"
                                       class="text-white font-semibold bg-blue-500 text-xs rounded-full px-2 py-1 hover:text-indigo-900 mr-4">Modifier</a>
                                    <button data-modal-target="popup-modal${u.id}"
                                            data-modal-toggle="popup-modal${u.id}"
                                            class="text-white font-semibold bg-red-500 text-xs rounded-full px-2 py-1 hover:text-indigo-900 mr-4"
                                            type="button">
                                        Supprimer
                                    </button>
                                    <div id="popup-modal${u.id}" tabindex="-1"
                                         class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full flex">
                                        <div class="relative p-4 w-full max-w-md max-h-full">
                                            <div class="relative bg-white rounded-lg shadow-sm dark:bg-gray-700">
                                                <button type="button"
                                                        class="absolute top-3 end-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
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
                                                    <svg class="mx-auto mb-4 text-gray-400 w-12 h-12 dark:text-gray-200"
                                                         aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                                                         fill="none" viewBox="0 0 20 20">
                                                        <path stroke="currentColor" stroke-linecap="round"
                                                              stroke-linejoin="round" stroke-width="2"
                                                              d="M10 11V6m0 8h.01M19 10a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/>
                                                    </svg>
                                                    <h3 class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">
                                                        Etes vous sur de vouloir supprimer l'appartement' ?</h3>
                                                    <a href="${pageContext.request.contextPath}/unites?action=delete&&id=${u.id}"
                                                       data-modal-hide="popup-modal${u.id}" type="button"
                                                       class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center">
                                                        Oui
                                                    </a>
                                                    <button data-modal-hide="popup-modal${u.id}" type="button"
                                                            class="py-2.5 px-5 ms-3 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700">
                                                        Non
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>