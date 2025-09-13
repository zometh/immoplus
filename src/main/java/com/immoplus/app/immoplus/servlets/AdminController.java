package com.immoplus.app.immoplus.servlets;

import com.immoplus.app.immoplus.entities.AdminDashboardEntity;
import com.immoplus.app.immoplus.entities.Immeuble;
import com.immoplus.app.immoplus.services.ContratLocationService;
import com.immoplus.app.immoplus.services.DemandeService;
import com.immoplus.app.immoplus.services.ImmeubleService;
import com.immoplus.app.immoplus.services.UtilisateurService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.util.List;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    ImmeubleService immeubleService = new ImmeubleService();
    UtilisateurService utilisateurService = new UtilisateurService();
    DemandeService demandeService = new DemandeService();
    ContratLocationService contratLocationService = new ContratLocationService();

    @Override
    protected void doGet(javax.servlet.http.HttpServletRequest req, javax.servlet.http.HttpServletResponse resp) throws javax.servlet.ServletException, java.io.IOException {
        final String action = (req.getParameter("action") == null) ? "home" : req.getParameter("action");
        System.out.println(action);
        switch (action) {
            case "home":
                AdminDashboardEntity adminDashboard = new AdminDashboardEntity();
                adminDashboard.setTotalImmeubles(immeubleService.countImmeubles());
                adminDashboard.setTotalProprietaires(utilisateurService.countProprietaires());
                adminDashboard.setTotalDemandes(demandeService.countDemandes());
                adminDashboard.setTotalLocataires(utilisateurService.countLocataires());
                adminDashboard.setTotalContrats(contratLocationService.countContrats());
                adminDashboard.setTotalUnites(immeubleService.countTotalUnites());
                req.setAttribute("adminDashboard", adminDashboard);
                req.getRequestDispatcher("/pages/admin/admin.jsp").forward(req, resp);
                break;
            case "immeubles":
                List<Immeuble> immeubles = immeubleService.findAll();
                req.setAttribute("immeubles", immeubles);
                req.getRequestDispatcher("/pages/admin/immeubles.jsp").forward(req, resp);
                break;

            default:
                resp.sendRedirect("admin");
                return;
        }

    }
}
