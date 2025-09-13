package com.immoplus.app.immoplus.servlets;


import com.immoplus.app.immoplus.entities.UniteLocation;
import com.immoplus.app.immoplus.entities.Utilisateur;
import com.immoplus.app.immoplus.services.DemandeService;
import com.immoplus.app.immoplus.services.LocataireService;
import com.immoplus.app.immoplus.services.UniteLocationService;
import com.immoplus.app.immoplus.services.UtilisateurService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Comparator;
import java.util.List;

@WebServlet("/locataires")
public class LocataireController extends HttpServlet {
    private final LocataireService locataireService = new LocataireService();
    private UniteLocationService uniteLocationService = new UniteLocationService();
    private final DemandeService service = new DemandeService();
    private final UtilisateurService utilisateurService = new UtilisateurService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String action = (req.getParameter("action") == null) ? "list" : req.getParameter("action");

        switch (action) {
            case "list":
                List<UniteLocation> unites = uniteLocationService.getAvailable();

                req.setAttribute("unites", unites);

                req.getRequestDispatcher("/pages/locataires/home.jsp").forward(req, resp);
                break;
            case "search":
                String query = req.getParameter("search") == null ? "" : req.getParameter("search");
                int prix = req.getParameter("prix") == null ? 0 : Integer.parseInt(req.getParameter("prix"));
                List<UniteLocation> results = query.isEmpty() ? uniteLocationService.getAvailable() :  uniteLocationService.searchByName(query);
                if(results.isEmpty()){
                    results = uniteLocationService.getAvailable();
                }
                int nbPieces;
                if(req.getParameter("nbPieces") != null && !req.getParameter("nbPieces").isEmpty()){
                    nbPieces = Integer.parseInt(req.getParameter("nbPieces"));
                } else {
                    nbPieces = 0;
                }
                if(nbPieces > 0){
                    results.removeIf(unite -> unite.getNbPieces() != nbPieces);
                }
                switch (prix){
                    case 1:

                        results.sort(Comparator.comparing(UniteLocation::getLoyer).reversed());
                        break;
                    case 2:

                        results.sort(Comparator.comparing(UniteLocation::getLoyer));
                        break;
                    default:
                        //no order
                        break;
                }
                req.setAttribute("unites", results);
                req.setAttribute("search", query);
                req.getRequestDispatcher("/pages/locataires/home.jsp").forward(req, resp);
                break;
            case "details":
                Long uniteId = Long.parseLong(req.getParameter("id"));
                UniteLocation unite = uniteLocationService.findById(uniteId);
                Utilisateur user = (Utilisateur) req.getSession().getAttribute("user");
                final boolean existingDemande = service.checkExistingDemande(user.getId(), uniteId);
                req.setAttribute("existingDemande", existingDemande);
                req.setAttribute("unite", unite);
                req.getRequestDispatcher("/pages/locataires/location_infos.jsp").forward(req, resp);
                return;
            case "delete":
                Long id = Long.parseLong(req.getParameter("id"));
               // locataireService.delete(id);
                resp.sendRedirect("locataires");
                return;
            case "profil":
                req.setAttribute("user", (Utilisateur) req.getSession().getAttribute("user"));
                req.getRequestDispatcher("/pages/locataires/profil.jsp").forward(req, resp);

                return;

            default:
                System.out.println("Action non reconnue: " + action);
                break;
        }
       /* List<UniteLocation> unites = uniteLocationService.getAvailable();

        req.setAttribute("unites", unites);

    req.getRequestDispatcher("/pages/locataires/home.jsp").forward(req, resp);*/
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String action = (req.getParameter("action") == null) ? "update" : req.getParameter("action");
        switch (action){
            case "update":
                Utilisateur user = (Utilisateur) req.getSession().getAttribute("user");
                String nom = req.getParameter("nom");
                String password = req.getParameter("password");
                if(!password.isEmpty()){
                    user.setPassword(utilisateurService.hashPassword(password));
                }
                if(nom .equals(user.getNom())){
                    resp.sendRedirect("locataires?action=profil");
                    return;
                }
                user.setNom(nom);
                utilisateurService.update(user);

                req.getSession().setAttribute("user", user);
                resp.sendRedirect("locataires?action=profil");
                break;
            default:
                System.out.println("Action non reconnue: " + action);
                break;
        }

    }
}
