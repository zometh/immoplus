package com.immoplus.app.immoplus;

import com.immoplus.app.immoplus.dao.JpaUtil;
import com.immoplus.app.immoplus.entities.UserRole;
import com.immoplus.app.immoplus.entities.Utilisateur;
import jakarta.persistence.EntityManager;

public class Main {
    public static void main(String[] args) {
        try {
            EntityManager em = JpaUtil.getConnection().createEntityManager();
            em.getTransaction().begin();

            em.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
