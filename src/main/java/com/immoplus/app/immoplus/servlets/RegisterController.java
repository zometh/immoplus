package com.immoplus.app.immoplus.servlets;


import com.immoplus.app.immoplus.entities.UserRole;
import com.immoplus.app.immoplus.entities.Utilisateur;
import com.immoplus.app.immoplus.services.UtilisateurService;

import javax.management.relation.Role;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private final UtilisateurService utilisateurService;
    Utilisateur user;
    public RegisterController() {
        this.utilisateurService = new UtilisateurService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        final String action = (req.getParameter("action") == null) ? "list" : req.getParameter("action");
        int id;
        req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        final String action = (req.getParameter("action") == null) ? "save" : req.getParameter("action");
        System.out.println(action);
        switch (action) {
            case "save":
                String email = req.getParameter("email");
                if(utilisateurService.findByEmail(email) != null){
                    req.setAttribute("error", "Email déjà utilisé");
                    req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
                    return;
                }
                 user = new Utilisateur();
                user.setId(null);
                user.setNom(req.getParameter("nom"));
                user.setEmail(req.getParameter("email"));
                user.setPassword(req.getParameter("password"));
                user.setRole(getRole(req.getParameter("role")));
                try{
                    utilisateurService.registerUser(user);
                    req.getSession().setAttribute("user", user);
                    navigate(resp, req);

                }catch (Exception e){
                    req.setAttribute("error", String.format("Une erreur est survenue : %s", e));
                    req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
                }
                break;
            case "update":
                break;

        }

        /*String email = req.getParameter("email");
        String password = req.getParameter("password");
        String roleParam = req.getParameter("role");
        Utilisateur user = utilisateurService.findByEmail(email);
        boolean roleMatch = false;
        if (user != null && roleParam != null) {
            roleMatch = user.getRole() != null && user.getRole().name().equals(roleParam);
        }
        if (user != null && utilisateurService.checkPassword(user, password) && roleMatch) {
            req.getSession().setAttribute("user", user);
            resp.sendRedirect("index.jsp");
        } else {
            req.setAttribute("error", "Identifiants ou rôle invalides");
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
        }*/
    }
    private void navigate(HttpServletResponse resp, HttpServletRequest req) throws IOException {

        switch (user.getRole()) {
            case UserRole.ADMINISTRATEUR -> resp.sendRedirect("admin");
            // case AGENT -> resp.sendRedirect("pages/agent/agent.jsp");
            case UserRole.PROPRIETAIRE -> resp.sendRedirect("immeubles?action=home");
            case UserRole.LOCATAIRE -> resp.sendRedirect("locataires");
            default -> {
                req.setAttribute("error", "Rôle utilisateur inconnu");
                try {
                    req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
                } catch (ServletException e) {
                    e.printStackTrace();
                }
            }
        }


    }
    private UserRole getRole(String roleParam) {
        return switch (roleParam) {
            case "LOCATAIRE" -> UserRole.LOCATAIRE;
            case "ADMINISTRATEUR" -> UserRole.ADMINISTRATEUR;
            default -> UserRole.PROPRIETAIRE;
        };
    }
}
