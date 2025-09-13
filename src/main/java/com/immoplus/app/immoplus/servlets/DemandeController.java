package com.immoplus.app.immoplus.servlets;

import com.immoplus.app.immoplus.entities.*;
import com.immoplus.app.immoplus.services.*;
import com.mailjet.client.errors.MailjetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/demandes")
public class DemandeController extends HttpServlet {
    DemandeService demandeService = new DemandeService();
    UniteLocationService uniteLocationService = new UniteLocationService();
    PaiementService paiementService = new PaiementService();
    ContratLocationService contratLocationService = new ContratLocationService();
    MailerService mailerService = new MailerService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String action = (req.getParameter("action") == null) ? "add" : req.getParameter("action");

        Utilisateur user = (Utilisateur) req.getSession().getAttribute("user");
        long uniteId;
        long demandeId;
        DemandeLocation demande;
        UniteLocation unite;
        switch (action) {
            case "louer":
                uniteId = Long.parseLong(req.getParameter("id"));
                unite = uniteLocationService.findById(uniteId);
                int mois = Integer.parseInt(req.getParameter("mois"));
                boolean available = uniteLocationService.checkAvailability(uniteId);
                if (available) {
                    Paiement paiement = new Paiement();
                    paiement.setMontant(unite.getLoyer());
                    paiement.setStatut(PaiementStatut.PAID);
                    ContratLocation contrat = new ContratLocation();
                    contrat.setDateDebut(LocalDate.now());
                    contrat.setStatut(LocationStatut.ACTIVE);
                    contrat.setDateFin(LocalDate.now().plusMonths(mois));
                    contrat.setUnite(unite);
                    contrat.setLocataire(user);
                    contrat.getPaiements().add(paiement);
                    paiement.setContrat(contrat);

                    unite.setAvailable(false);
                    uniteLocationService.update(unite);
                    contratLocationService.save(contrat);
                   // paiementService.save(paiement);
                 uniteLocationService.save(unite);
                    try {
                        mailerService.sendMail(contrat, paiement);
                    } catch (MailjetException e) {
                        throw new RuntimeException(e);
                    }

                }

                resp.sendRedirect("/demandes?action=list");
                break;
            case "save":
                 uniteId = Long.parseLong(req.getParameter("id"));
                 unite = uniteLocationService.findById(uniteId);
                DemandeLocation demandeLocation = new DemandeLocation();
                demandeLocation.setUnite(unite);
                demandeLocation.setLocataire(user);
                demandeService.save(demandeLocation);
                req.getRequestDispatcher("/locataires?action=details&&id="+uniteId).forward(req, resp);
                break;
            case "contrats":
                List<ContratLocation> contrats = contratLocationService.findByLocataireId(user.getId());

                req.setAttribute("contrats", contrats);
                req.getRequestDispatcher("/pages/locataires/locataires_contrats.jsp").forward(req, resp);
                break;
            case "cancel":
                 uniteId = Long.parseLong(req.getParameter("id"));
                 demandeService.delete(user.getId(), uniteId);
                req.getRequestDispatcher("/locataires?action=details&&id="+uniteId).forward(req, resp);
                break;
            case "accept":
                 demandeId = Long.parseLong(req.getParameter("id"));
                 demande = demandeService.findById(demandeId);
                demande.setStatut(DemandeStatut.ACCEPTEE);
                demandeService.update(demande);
                req.getRequestDispatcher("/demandes?action=owner").forward(req, resp);
                break;
            case "reject":
                 demandeId = Long.parseLong(req.getParameter("id"));
                 demande = demandeService.findById(demandeId);
                demande.setStatut(DemandeStatut.REFUSEE);
                demandeService.update(demande);
                req.getRequestDispatcher("/demandes?action=owner").forward(req, resp);
                break;
            case "list":
                List<DemandeLocation> demandes = demandeService.findByLocataireId(user.getId());

                req.setAttribute("demandes", demandes);
                req.getRequestDispatcher("/pages/locataires/locataires_demandes.jsp").forward(req, resp);
                break;
            case "owner":
                List<DemandeLocation> demandesOwner = demandeService.findByOwnerId(user.getId());

                req.setAttribute("demandes", demandesOwner);
                req.getRequestDispatcher("/pages/proprietaire/demandes.jsp").forward(req, resp);
                break;
            default:
                System.out.println("Action non reconnue: " + action);

                break;
        }

    }
}
