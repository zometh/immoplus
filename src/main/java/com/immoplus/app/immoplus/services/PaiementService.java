package com.immoplus.app.immoplus.services;


import com.immoplus.app.immoplus.dao.JpaUtil;
import com.immoplus.app.immoplus.entities.Paiement;
import jakarta.persistence.EntityManager;

import java.util.List;

public class PaiementService {
    private EntityManager em;

    public PaiementService() {
        this.em = JpaUtil.getConnection().createEntityManager();
    }

    public List<Paiement> findAll() {
        return em.createQuery("SELECT p FROM Paiement p", Paiement.class).getResultList();
    }

    public void save(Paiement paiement) {
        try {
            em.getTransaction().begin();
            em.persist(paiement);
            em.getTransaction().commit();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }
    public double getPaidAmountByUniteId(Long uniteId) {
        Double totalPaid = em.createQuery("SELECT SUM(p.montant) FROM Paiement p WHERE p.contrat.unite.id = :uniteId", Double.class)
                .setParameter("uniteId", uniteId)
                .getSingleResult();
        return totalPaid != null ? totalPaid : 0.0;
    }
}
