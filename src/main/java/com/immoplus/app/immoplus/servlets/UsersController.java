package com.immoplus.app.immoplus.servlets;


import com.immoplus.app.immoplus.entities.UserRole;
import com.immoplus.app.immoplus.entities.Utilisateur;
import com.immoplus.app.immoplus.services.UtilisateurService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UsersController extends HttpServlet {
    private final UtilisateurService utilisateurService;

    public UsersController() {
        this.utilisateurService = new UtilisateurService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        final String action = (req.getParameter("action") == null) ? "list" : req.getParameter("action");
        int id;
        List<Utilisateur> users = utilisateurService.findAll();

        switch (action) {
            case "list":
                req.setAttribute("users", users);
                req.getRequestDispatcher("/pages/admin/users.jsp").forward(req, resp);
                break;
            case "new":
                req.getRequestDispatcher("/pages/admin/new_user.jsp").forward(req, resp);
                break;
            case "delete":
                id = Integer.parseInt(req.getParameter("id"));
               // utilisateurService.delete(id);
                resp.sendRedirect("users");
                break;
            default:
                req.setAttribute("users", users);
                req.getRequestDispatcher("/pages/admin/new_user.jsp").forward(req, resp);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        final String action = (req.getParameter("action") == null) ? "save" : req.getParameter("action");
        System.out.println(action);
        switch (action) {
            case "save":
                String email = req.getParameter("email");
                if(utilisateurService.findByEmail(email) != null){
                    req.setAttribute("error", "Un utilisateur avec cet email existe déjà.");
                    req.getRequestDispatcher("/pages/admin/new_user.jsp").forward(req, resp);
                    return;
                }
                Utilisateur user = new Utilisateur();
                user.setId(null);
                user.setNom(req.getParameter("nom"));
                user.setEmail(email);
                user.setPassword(req.getParameter("password"));
                user.setRole(getRole(req.getParameter("role")));

                    utilisateurService.registerUser(user);
                    resp.sendRedirect("users");

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
    private UserRole getRole(String roleParam) {
        return switch (roleParam) {
            case "LOCATAIRE" -> UserRole.LOCATAIRE;
            case "ADMINISTRATEUR" -> UserRole.ADMINISTRATEUR;
            default -> UserRole.PROPRIETAIRE;
        };
    }
}
