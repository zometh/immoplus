package com.immoplus.app.immoplus.services;


import com.immoplus.app.immoplus.dao.JpaUtil;
import com.immoplus.app.immoplus.entities.ContratLocation;
import com.immoplus.app.immoplus.entities.Immeuble;
import com.immoplus.app.immoplus.servlets.ImmeubleController;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class ImmeubleService {
    private final EntityManager em;
    private ContratLocationService contratLocationService = new ContratLocationService();
    private PaiementService paiementService = new PaiementService();
    public ImmeubleService() {
        this.em = JpaUtil.getConnection().createEntityManager();
    }

    public List<Immeuble> findAll() {
        return em.createQuery("SELECT i FROM Immeuble i", Immeuble.class).getResultList();
    }

    public void save(Immeuble immeuble) {
        em.getTransaction().begin();
        em.persist(immeuble);
        em.getTransaction().commit();
    }

    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }

    public void update(Immeuble immeuble) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(immeuble);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        }
    }
    public List<Immeuble> findByUserId(Long userId) {
        return em.createQuery("SELECT i FROM Immeuble i WHERE i.utilisateur.id = :userId", Immeuble.class)
                 .setParameter("userId", userId)
                 .getResultList();
    }

    public void delete(Long id) {
        EntityManager em = JpaUtil.getConnection().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Immeuble p = em.find(Immeuble.class, id);
            if (p != null) {

                em.remove(p);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            if (em.isOpen()) em.close();
        }
    }
    public Immeuble findById(Long id) {
        return em.find(Immeuble.class, id);
    }

    public int countTotalUnits(List<Immeuble> immeubleServiceAll) {
        int totalUnits = 0;
        for (Immeuble immeuble : immeubleServiceAll) {
            totalUnits += immeuble.getUnites().size();
        }
        return totalUnits;
    }

    public int countAvailableUnits(List<Immeuble> immeubleServiceAll) {
        int availableUnits = 0;
        for (Immeuble immeuble : immeubleServiceAll) {
            for (var unite : immeuble.getUnites()) {
                if (unite.isAvailable()) {
                    availableUnits++;
                }
            }
        }
        return availableUnits;
    }


    public int countContrats(List<Immeuble> immeubleServiceAll) {
        int totalContrats = 0;
        for (Immeuble immeuble : immeubleServiceAll) {
            for (var unite : immeuble.getUnites()) {
                totalContrats += contratLocationService.getContratsByUnitsId(unite.getId());
            }
        }
        return totalContrats;
    }

    public double countTotalLoyer(List<Immeuble> immeubleServiceAll) {
        double totalLoyer = 0;
        for (Immeuble immeuble : immeubleServiceAll) {
            for (var unite : immeuble.getUnites()) {
                totalLoyer += paiementService.getPaidAmountByUniteId(unite.getId());
            }
        }
        return totalLoyer;
    }

    public int countImmeubles() {
        return em.createQuery("SELECT COUNT(i) FROM Immeuble i", Long.class).getSingleResult().intValue();
    }

    public int countTotalUnites() {
        return em.createQuery("SELECT SUM(size(i.unites)) FROM Immeuble i", Long.class).getSingleResult().intValue();
    }


}
