package com.immoplus.app.immoplus.servlets;

import com.immoplus.app.immoplus.entities.ContratLocation;
import com.immoplus.app.immoplus.entities.LocationStatut;
import com.immoplus.app.immoplus.entities.UniteLocation;
import com.immoplus.app.immoplus.entities.Utilisateur;
import com.immoplus.app.immoplus.services.ContratLocationService;
import com.immoplus.app.immoplus.services.MailerService;
import com.immoplus.app.immoplus.services.UniteLocationService;
import com.mailjet.client.errors.MailjetException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/contrats")
public class ContratLocationController extends HttpServlet {
    private ContratLocationService contratService = new ContratLocationService();
    private final UniteLocationService uniteLocationService = new UniteLocationService();
    private MailerService mailerService = new MailerService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action") == null ? "list" : req.getParameter("action");
        if (action.equals("list")) {
            Utilisateur user = (Utilisateur) req.getSession().getAttribute("user");
            List<ContratLocation> contrats = contratService.findByLocataireId(user.getId());
            req.setAttribute("contrats", contrats);
            req.getRequestDispatcher("/pages/locataires/contrats.jsp").forward(req, resp);
        } else if (action.equals("cancel")) {
            int id = Integer.parseInt(req.getParameter("id"));
            ContratLocation contrat = contratService.findById(id);
            contrat.setDateFin(LocalDate.now());
            contrat.setStatut(LocationStatut.TERMINATED);
            UniteLocation unite = contrat.getUnite();
            unite.setAvailable(true);
            uniteLocationService.update(unite);
            contratService.update(contrat);
            try {
                mailerService.sendCancelContractMail(contrat);
            } catch (MailjetException e) {
                throw new RuntimeException(e);
            }
            resp.sendRedirect( "contrats");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
