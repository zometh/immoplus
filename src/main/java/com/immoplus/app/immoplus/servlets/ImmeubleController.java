package com.immoplus.app.immoplus.servlets;

import com.immoplus.app.immoplus.entities.ContratLocation;
import com.immoplus.app.immoplus.entities.Immeuble;
import com.immoplus.app.immoplus.entities.ImmeubleDashboardEntity;
import com.immoplus.app.immoplus.entities.Utilisateur;
import com.immoplus.app.immoplus.services.ContratLocationService;
import com.immoplus.app.immoplus.services.ImmeubleService;
import com.immoplus.app.immoplus.services.UtilisateurService;


import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/immeubles")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 50 * 1024 * 1024
)

public class    ImmeubleController extends HttpServlet {
    private final ImmeubleService immeubleService = new ImmeubleService();
    private final UtilisateurService utilisateurService = new UtilisateurService();
    ContratLocationService contratLocationService = new ContratLocationService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        final String action = (req.getParameter("action") == null) ? "list" : req.getParameter("action");


        Long userId = ((Utilisateur) req.getSession().getAttribute("user")).getId();
        List<Immeuble> immeubleServiceAll = immeubleService.findByUserId(userId);
        long id;
        switch (action) {
            case "list":

                req.setAttribute("immeubles", immeubleServiceAll);
                req.getRequestDispatcher("/pages/proprietaire/immeubles.jsp").forward(req, resp);
                break;
            case "new":
                req.getRequestDispatcher("/pages/proprietaire/add_immeuble.jsp").forward(req, resp);
                break;
            case "delete":
                 id = Long.parseLong(req.getParameter("id"));
                immeubleService.delete(id);
                resp.sendRedirect("immeubles");
                break;
            case "contrats":
                //Récupérer la liste des contrats des immeubles de l'utilisateur
                List<ContratLocation> contrats = contratLocationService.findByImmeublesAll( immeubleServiceAll);
                req.setAttribute("contrats", contrats);
                req.getRequestDispatcher("/pages/proprietaire/contrats.jsp").forward(req, resp);
                break;
            case "profil":
                req.setAttribute("user", (Utilisateur) req.getSession().getAttribute("user"));
                req.getRequestDispatcher("/pages/proprietaire/profil.jsp").forward(req, resp);
                break;
            case "edit":
                System.out.println("Edit routes");
                 id = Long.parseLong(req.getParameter("id"));
                 Immeuble immeuble = immeubleService.findById(id);
                req.setAttribute("immeuble", immeuble);
                req.getRequestDispatcher("/pages/proprietaire/edit_immeuble.jsp").forward(req, resp);
                break;
            case "home":
                 ImmeubleDashboardEntity dashboardData = new ImmeubleDashboardEntity();
                dashboardData.setImmeubles(immeubleServiceAll);
                dashboardData.setNbUnites(immeubleService.countTotalUnits(immeubleServiceAll));
                dashboardData.setNbUnitesDisponibles(immeubleService.countAvailableUnits(immeubleServiceAll));
                dashboardData.setNbContrats(immeubleService.countContrats(immeubleServiceAll));
                dashboardData.setTotalLocation(immeubleService.countTotalLoyer(immeubleServiceAll));
                req.setAttribute("dashboardData", dashboardData);
                req.getRequestDispatcher("/pages/proprietaire/home.jsp").forward(req, resp);
                break;
            default:
                req.setAttribute("immeubles", immeubleServiceAll);
                req.getRequestDispatcher("/pages/admin/new_user.jsp").forward(req, resp);
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String action = (req.getParameter("action") == null) ? "save" : req.getParameter("action");
        String uploadPath;
        String nom;
        switch (action) {
            case "save":
                Part filePart = req.getPart("image");
                String uniqueName = UUID.randomUUID() + "_" + filePart.getSubmittedFileName();
                uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                filePart.write(uploadPath + File.separator + uniqueName);
                 nom = req.getParameter("nom");
                String adresse = req.getParameter("adresse");
                String description = req.getParameter("description");
                String equipements = req.getParameter("equipements");
                int nbPieces = Integer.parseInt(req.getParameter("nbPieces"));
                Immeuble immeuble = new Immeuble( );
                immeuble.setNom(nom);
                immeuble.setAdresse(adresse);
                immeuble.setDescription(description);
                immeuble.setEquipements(equipements);
                immeuble.setNbPieces(nbPieces);
                immeuble.setId(null);
                immeuble.setImagePath("uploads/" + uniqueName);
                immeuble.setUtilisateur( (Utilisateur) req.getSession().getAttribute("user"));
                immeubleService.save(immeuble);
                resp.sendRedirect("immeubles");

                break;
            case "delete":
                Long id = Long.parseLong(req.getParameter("id"));
                Immeuble immeuble1 = immeubleService.findById(id);
                if(immeuble1 != null){
                     uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                    System.out.println(uploadPath + File.separator + immeuble1.getImagePath());
                     File file = new File(uploadPath, immeuble1.getImagePath());
                    if (file.exists()) file.delete();
                }
                immeubleService.delete(id);
                resp.sendRedirect("immeubles");
                break;
            case "update-info":
                Utilisateur user = (Utilisateur) req.getSession().getAttribute("user");
                 nom = req.getParameter("nom");
                String password = req.getParameter("password");
                if(!password.isEmpty()){
                    user.setPassword(utilisateurService.hashPassword(password));
                }
                if(nom .equals(user.getNom())){
                    resp.sendRedirect("immeubles?action=profil");
                    return;
                }
                user.setNom(nom);
                utilisateurService.update(user);

                req.getSession().setAttribute("user", user);
                resp.sendRedirect("immeubles?action=profil");
                break;
            case "update":
                id = Long.parseLong(req.getParameter("id"));
                Immeuble existingImmeuble = immeubleService.findById(id);
                if (existingImmeuble != null) {
                    String nomUpdate = req.getParameter("nom");
                    String adresseUpdate = req.getParameter("adresse");
                    String descriptionUpdate = req.getParameter("description");
                    String equipementsUpdate = req.getParameter("equipements");
                    int nbPiecesUpdate = Integer.parseInt(req.getParameter("nbPieces"));

                    existingImmeuble.setNom(nomUpdate);
                    existingImmeuble.setAdresse(adresseUpdate);
                    existingImmeuble.setDescription(descriptionUpdate);
                    existingImmeuble.setEquipements(equipementsUpdate);
                    existingImmeuble.setNbPieces(nbPiecesUpdate);

                    Part filePartUpdate = req.getPart("image");
                    if (filePartUpdate != null && filePartUpdate.getSize() > 0) {

                        uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                        File oldFile = new File(uploadPath, existingImmeuble.getImagePath());
                        if (oldFile.exists()) oldFile.delete();


                        String uniqueNameUpdate = UUID.randomUUID() + "_" + filePartUpdate.getSubmittedFileName();
                        filePartUpdate.write(uploadPath + File.separator + uniqueNameUpdate);
                        existingImmeuble.setImagePath("uploads/" + uniqueNameUpdate);
                    }

                    immeubleService.update(existingImmeuble);
                    resp.sendRedirect("immeubles");
                }

        }

    }
}
