package com.immoplus.app.immoplus.services;

import com.immoplus.app.immoplus.dao.JpaUtil;
import com.immoplus.app.immoplus.entities.DemandeLocation;
import jakarta.persistence.EntityManager;

import java.util.List;

public class DemandeService {
    private final EntityManager em;
    public DemandeService() {
        this.em = JpaUtil.getConnection().createEntityManager();
    }

    public void save(DemandeLocation demande) {
        em.getTransaction().begin();
        em.persist(demande);
        em.getTransaction().commit();
    }
    public boolean checkExistingDemande(Long locataireId, Long uniteId) {
        Long count = em.createQuery("SELECT COUNT(d) FROM DemandeLocation d WHERE d.locataire.id = :locataireId AND d.unite.id = :uniteId", Long.class)
                .setParameter("locataireId", locataireId)
                .setParameter("uniteId", uniteId)
                .getSingleResult();
        return count > 0;
    }
    public void delete(Long locataireId, Long uniteId) {
        em.getTransaction().begin();
        em.createQuery("DELETE FROM DemandeLocation d WHERE d.locataire.id = :locataireId AND d.unite.id = :uniteId")
                .setParameter("locataireId", locataireId)
                .setParameter("uniteId", uniteId)
                .executeUpdate();
        em.getTransaction().commit();
    }

    public List<DemandeLocation> findByLocataireId(Long id) {
        return em.createQuery("SELECT d FROM DemandeLocation d WHERE d.locataire.id = :locataireId", DemandeLocation.class)
                .setParameter("locataireId", id)
                .getResultList();
    }

    public List<DemandeLocation> findByOwnerId(Long id) {
        return em.createQuery("SELECT d FROM DemandeLocation d WHERE d.unite.immeuble.utilisateur.id = :ownerId", DemandeLocation.class)
                .setParameter("ownerId", id)
                .getResultList();
    }

    public DemandeLocation findById(Long demandeId) {
        return em.find(DemandeLocation.class, demandeId);
    }

    public void update(DemandeLocation demande) {
        try {
            em.getTransaction().begin();
            em.merge(demande);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }

    public int countDemandes() {
        Long count = em.createQuery("SELECT COUNT(d) FROM DemandeLocation d", Long.class)
                .getSingleResult();
        return count.intValue();
    }
}
