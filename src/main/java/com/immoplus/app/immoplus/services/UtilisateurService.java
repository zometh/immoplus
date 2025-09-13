package com.immoplus.app.immoplus.services;


import com.immoplus.app.immoplus.dao.JpaUtil;
import com.immoplus.app.immoplus.entities.UniteLocation;
import com.immoplus.app.immoplus.entities.Utilisateur;
import jakarta.persistence.EntityManager;

import java.util.List;

public class UtilisateurService {
    private final EntityManager em;

    public UtilisateurService() {
        this.em = JpaUtil.getConnection().createEntityManager();
    }

    public Utilisateur findByEmail(String email) {
        try {
            List<Utilisateur> users = em.createQuery("SELECT u FROM Utilisateur u WHERE u.email = :email", Utilisateur.class)
                .setParameter("email", email)
                .getResultList();
            return users.isEmpty() ? null : users.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public List<Utilisateur> findAll() {
        return em.createQuery("SELECT u FROM Utilisateur u", Utilisateur.class).getResultList();
    }
    public boolean checkPassword(Utilisateur user, String password) {
        if (user == null || password == null || user.getPassword() == null) return false;
        return org.mindrot.jbcrypt.BCrypt.checkpw(password, user.getPassword());
    }

    public String hashPassword(String plainPassword) {
        return org.mindrot.jbcrypt.BCrypt.hashpw(plainPassword, org.mindrot.jbcrypt.BCrypt.gensalt());
    }

    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }
    public void registerUser(Utilisateur user) {
        try {
            em.getTransaction().begin();
            user.setPassword(hashPassword(user.getPassword()));
            em.persist(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        }
    }
    public void update(Utilisateur user) {
        try {
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        }}

    public int countProprietaires() {
        Long count = em.createQuery("SELECT COUNT(u) FROM Utilisateur u WHERE u.role = 'PROPRIETAIRE'", Long.class)
                .getSingleResult();
        return count.intValue();
    }

    public int countLocataires() {
        Long count = em.createQuery("SELECT COUNT(u) FROM Utilisateur u WHERE u.role = 'LOCATAIRE'", Long.class)
                .getSingleResult();
        return count.intValue();
    }
}
