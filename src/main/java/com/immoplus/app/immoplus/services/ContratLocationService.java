package com.immoplus.app.immoplus.services;


import com.immoplus.app.immoplus.dao.JpaUtil;
import com.immoplus.app.immoplus.entities.ContratLocation;
import com.immoplus.app.immoplus.entities.Immeuble;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ContratLocationService {
    public List<ContratLocation> findAll() {
        EntityManager em = JpaUtil.getConnection().createEntityManager();
        try {
            return em.createQuery("SELECT c FROM ContratLocation c", ContratLocation.class).getResultList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public void save(ContratLocation contrat) {
        EntityManager em = com.immoplus.app.immoplus.dao.JpaUtil.getConnection().createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(contrat);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public List<ContratLocation> findByLocataireId(Long id) {
        EntityManager em = JpaUtil.getConnection().createEntityManager();
        try {
            return em.createQuery("SELECT c FROM ContratLocation c WHERE c.locataire.id = :id", ContratLocation.class)
                    .setParameter("id", id)
                    .getResultList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public ContratLocation findById(int id) {
        EntityManager em = JpaUtil.getConnection().createEntityManager();
        try {
            return em.find(ContratLocation.class, id);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public void update(ContratLocation contrat) {
        EntityManager em = JpaUtil.getConnection().createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(contrat);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    public int getContratsByUnitsId(Long unitId) {
        EntityManager em = JpaUtil.getConnection().createEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(c) FROM ContratLocation c WHERE c.unite.id = :unitId", Long.class)
                    .setParameter("unitId", unitId)
                    .getSingleResult();
            return count.intValue();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public int countContrats() {
        EntityManager em = JpaUtil.getConnection().createEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(c) FROM ContratLocation c", Long.class)
                    .getSingleResult();
            return count.intValue();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public List<ContratLocation> findByImmeublesAll(List<Immeuble> immeubleServiceAll) {
        EntityManager em = JpaUtil.getConnection().createEntityManager();
        try {
            return em.createQuery("SELECT c FROM ContratLocation c WHERE c.unite.immeuble IN :immeubles", ContratLocation.class)
                    .setParameter("immeubles", immeubleServiceAll)
                    .getResultList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
