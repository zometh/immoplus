package com.immoplus.app.immoplus.servlets;


import com.immoplus.app.immoplus.entities.Paiement;
import com.immoplus.app.immoplus.services.PaiementService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/paiements")
public class PaiementController extends HttpServlet {
    private final PaiementService paiementService = new PaiementService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    List<Paiement> paiements = paiementService.findAll();
    req.setAttribute("paiements", paiements);
    req.getRequestDispatcher("pages/locataires/paiements.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.sendRedirect("paiements");
    }
}
