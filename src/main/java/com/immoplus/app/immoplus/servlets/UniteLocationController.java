package com.immoplus.app.immoplus.servlets;

import com.immoplus.app.immoplus.entities.Immeuble;
import com.immoplus.app.immoplus.entities.UniteLocation;
import com.immoplus.app.immoplus.entities.Utilisateur;
import com.immoplus.app.immoplus.services.DemandeService;
import com.immoplus.app.immoplus.services.ImmeubleService;
import com.immoplus.app.immoplus.services.UniteLocationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

@WebServlet("/unites")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 50 * 1024 * 1024
)
public class UniteLocationController extends HttpServlet {
    private final UniteLocationService uniteService = new UniteLocationService();
    private final ImmeubleService immeubleService = new ImmeubleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String action = (req.getParameter("action") == null) ? "list" : req.getParameter("action");

        Utilisateur user = (Utilisateur) req.getSession().getAttribute("user");
        List<Immeuble> immeubles = immeubleService.findByUserId(user.getId());

        switch (action) {
            case "new": {
                Long selectedImmeubleId = parseLongOrNull(req.getParameter("immeubleId"));
                req.setAttribute("immeubles", immeubles);
                req.setAttribute("selectedImmeubleId", selectedImmeubleId);
                req.getRequestDispatcher("/pages/proprietaire/add_unite.jsp").forward(req, resp);
                break;
            }
            case "edit":
                Long id = parseLongOrNull(req.getParameter("id"));

                if (id != null) {
                    UniteLocation unite = uniteService.findAll().stream().filter(u -> u.getId().equals(id)).findFirst().orElse(null);
                    if (unite != null) {
                        req.setAttribute("unite", unite);

                        req.getRequestDispatcher("/pages/proprietaire/edit_unite.jsp").forward(req, resp);
                        return;
                    }
                }
                resp.sendRedirect("unites");
                break;
            case "list":
                Long immeubleId = parseLongOrNull(req.getParameter("immeubleId"));
                List<UniteLocation> unites;
                if (immeubleId == null && !immeubles.isEmpty()) {
                    immeubleId = immeubles.getFirst().getId();
                }
                unites = uniteService.findByImmeubleId(immeubleId);
                req.setAttribute("unites", unites);
                req.setAttribute("immeubles", immeubles);
                req.setAttribute("immeubleId", immeubleId);
                req.getRequestDispatcher("/pages/proprietaire/unites.jsp").forward(req, resp);
                break;
            case "delete":
                Long deleteId = parseLongOrNull(req.getParameter("id"));
                if (deleteId != null) {
                    UniteLocation unite = uniteService.findById(deleteId);
                    if (unite != null) {
                        Long parentImmeubleId = unite.getImmeuble().getId();
                        uniteService.delete(deleteId);
                        resp.sendRedirect("unites?action=list&immeubleId=" + parentImmeubleId);
                        return;
                    }
                }
                resp.sendRedirect("unites");
                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String action = (req.getParameter("action") == null) ? "save" : req.getParameter("action");
        switch (action) {
            case "save":
                Long immeubleId = parseLongOrNull(req.getParameter("immeubleId"));

                if (immeubleId != null) {
                    Immeuble im = immeubleService.findById(immeubleId);
                    if (im != null) {
                        UniteLocation unite = new UniteLocation();
                        unite.setImmeuble(im);
                        unite.setTitre( req.getParameter("titre"));
                        unite.setSuperficie(Double.parseDouble(req.getParameter("superficie")));
                        unite.setLoyer(Double.parseDouble(req.getParameter("loyer")));
                        unite.setNbPieces(Integer.parseInt(req.getParameter("nbPieces")));
                        unite.setAvailable(true);
                        Part filePart = req.getPart("image");
                        String uniqueName = UUID.randomUUID() + "_" + filePart.getSubmittedFileName();
                        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                        filePart.write(uploadPath + File.separator + uniqueName);
                        im.getUnites().add(unite);
                        unite.setImagePath("uploads/" + uniqueName);
                        immeubleService.update(im);
                        resp.sendRedirect("unites?action=list&immeubleId=" + immeubleId);
                        return;

                }
                resp.sendRedirect("unites");
                break;
            }
            case "update":
                Long id = parseLongOrNull(req.getParameter("id"));
                System.out.println(id);
                if (id != null) {
                    UniteLocation unite = uniteService.findById(id);
                    if (unite != null) {
                        unite.setAvailable(true);
                        unite.setTitre(req.getParameter("titre"));
                        unite.setSuperficie(Double.parseDouble(req.getParameter("superficie")));
                        unite.setLoyer(Double.parseDouble(req.getParameter("loyer")));
                        unite.setNbPieces(Integer.parseInt(req.getParameter("nbPieces")));
                        Part filePart = req.getPart("image");
                        if (filePart != null && filePart.getSize() > 0) {
                            String uniqueName = UUID.randomUUID() + "_" + filePart.getSubmittedFileName();
                            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                            filePart.write(uploadPath + File.separator + uniqueName);
                            unite.setImagePath("uploads/" + uniqueName);
                        }
                        uniteService.update(unite);
                        resp.sendRedirect("unites?action=list&immeubleId=" + unite.getImmeuble().getId());
                        return;
                    }
                }
                resp.sendRedirect("unites");
                break;
            default:
                resp.sendRedirect("unites");
        }
    }

    private Long parseLongOrNull(String value) {
        if (value == null || value.isEmpty()) return null;
        try {
            return Long.parseLong(value);
        } catch (NumberFormatException ex) {
            return null;
        }
    }
}