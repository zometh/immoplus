package com.immoplus.app.immoplus.servlets;


import com.immoplus.app.immoplus.entities.UserRole;
import com.immoplus.app.immoplus.entities.Utilisateur;
import com.immoplus.app.immoplus.services.UtilisateurService;
import lombok.Getter;
import lombok.Setter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private final UtilisateurService utilisateurService = new UtilisateurService();
    @Getter
    @Setter
    private Utilisateur user;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        final String action = (req.getParameter("action") == null) ? "list" : req.getParameter("action");
        int id;
        req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Utilisateur user = utilisateurService.findByEmail(email);


        if (user != null && utilisateurService.checkPassword(user, password)) {
           this.user = user;
            req.getSession().setAttribute("user", user);
            navigate(resp, req);
        } else {
            req.setAttribute("error", "Identifiants invalides");
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
        }
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



}
