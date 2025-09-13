package com.immoplus.app.immoplus.services;


import com.immoplus.app.immoplus.dao.JpaUtil;
import com.immoplus.app.immoplus.entities.UniteLocation;
import jakarta.persistence.EntityManager;

import java.util.List;

public class UniteLocationService {
    private EntityManager em;

    public UniteLocationService() {
        this.em = JpaUtil.getConnection().createEntityManager();
    }

    public List<UniteLocation> findAll() {
        return em.createQuery("SELECT u FROM UniteLocation u", UniteLocation.class).getResultList();
    }

    public void save(UniteLocation unite) {
        em.getTransaction().begin();
        em.persist(unite);
        em.getTransaction().commit();
    }
    public List<UniteLocation> findByImmeubleId(Long immeubleId) {
        return em.createQuery("SELECT u FROM UniteLocation u WHERE u.immeuble.id = :immeubleId", UniteLocation.class)
                .setParameter("immeubleId", immeubleId)
                .getResultList();
    }

    public UniteLocation findById(Long id) {
        return em.find(UniteLocation.class, id);
    }

    public List<UniteLocation> getAvailable() {
        return em.createQuery("SELECT u FROM UniteLocation u WHERE u.available = true", UniteLocation.class)
                .getResultList();
    }
    public List<UniteLocation> searchByName(String name) {
        return em.createQuery("SELECT u FROM UniteLocation u WHERE LOWER(u.titre) LIKE :name or lower(u.immeuble.adresse) " +
                        "LIKE :name ", UniteLocation.class)
                .setParameter("name", "%" + name.toLowerCase() + "%")
                .getResultList();
    }
    public boolean checkAvailability(Long id) {
        Long count = em.createQuery("SELECT COUNT(u) FROM UniteLocation u WHERE u.id = :id AND u.available = true", Long.class)
                .setParameter("id", id)
                .getSingleResult();
        return count > 0;
    }
    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }

    public void delete(Long id) {
        try {
            em.getTransaction().begin();
            UniteLocation unite = em.find(UniteLocation.class, id);
            if (unite != null) {
                em.remove(unite);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }
    public void update(UniteLocation unite) {
        try {
            em.getTransaction().begin();
            em.merge(unite);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }
}
