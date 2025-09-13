package com.immoplus.app.immoplus.dao;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil {
    private static final String PERSISTENCE_UNIT_NAME = "JEE_EXAM";
    private static EntityManagerFactory factory;
    private JpaUtil() {}

    public static synchronized EntityManagerFactory getConnection() {
        try {
            if (factory == null || !factory.isOpen()) {
                factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

            }
        } catch (Exception e) {
            System.out.println("Erreur lors de la création de l'EntityManagerFactory: " + e.getMessage());
            e.printStackTrace();

        }
        return factory;
    }

    public static void shutdown() {
        if (factory != null) {
            factory.close();
        }
    }


}
