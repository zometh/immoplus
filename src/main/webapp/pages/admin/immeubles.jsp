<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.immoplus.app.immoplus.entities.Utilisateur" %>
<%@ page import="com.immoplus.app.immoplus.services.UtilisateurService" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: metzo
  Date: 02/09/2025
  Time: 12:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Utilisateur user = (Utilisateur) session.getAttribute("user");
    String name = user.getNom();
    UtilisateurService utilisateurService = new UtilisateurService();

%>
<html>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Immeubles"/>
</jsp:include>

<body class="bg-gray-100 min-h-screen flex">
<jsp:include page="../navbar.jsp">
    <jsp:param name="page" value="immeubles"/>
</jsp:include>
<div class="flex-1">
    <jsp:include page="admin-header.jsp">
        <jsp:param name="name" value="<%= name  %>"/>
    </jsp:include>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="mt-8 bg-white rounded-lg shadow-md">
            <div class="p-6">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-semibold">Liste des Immeubles</h2>

                </div>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead>
                        <tr class="bg-gray-50">
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                ID
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Nom
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Adresse
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Description
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Equipements
                            </th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Nombre de pieces
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
                        <c:forEach items="${immeubles}" var="u">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">${u.id}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.nom}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.adresse}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.description}</td>

                                <td class="px-6 py-4 whitespace-nowrap">${u.equipements}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${u.nbPieces}</td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <img src="${pageContext.request.contextPath}/${u.imagePath}
" alt="image" width="100" height="100">
                                </td>

                                <td class="px-6 py-4 whitespace-nowrap">

                                    <a href="${pageContext.request.contextPath}/immeubles?action=edit&id=${u.id}"
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
                                                        Etes vous sur de vouloir supprimer l'immeuble ?</h3>
                                                    <a href="/immeubles?action=delete&&id=${u.id}" data-modal-hide="popup-modal${u.id}" type="button"
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