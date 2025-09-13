package com.immoplus.app.immoplus.services;


import jakarta.persistence.EntityManager;

public class LocataireService {
    private EntityManager em;

    public LocataireService() {
        this.em = com.immoplus.app.immoplus.dao.JpaUtil.getConnection().createEntityManager();    }


  /*  public List<Locataire> findAll() {
        try {
            return em.createQuery("SELECT l FROM Locataire l", Locataire.class).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }*/

    /*public boolean save(Locataire locataire) {
        try {
            em.getTransaction().begin();
            em.persist(locataire);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        }
    }*/

    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }
}
