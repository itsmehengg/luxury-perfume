package dao;

import database.DatabaseConnection;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import model.Perfume;

public class PerfumeDAO {
    private EntityManager em;

    public PerfumeDAO() {
        em = DatabaseConnection.getEntityManager();
    }

    public void create(Perfume perfume) {
        try {
            em.getTransaction().begin();
            em.persist(perfume);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }

    public Perfume findById(Long id) {
        return em.find(Perfume.class, id);
    }

    public List<Perfume> findAll() {
        Query query = em.createQuery("SELECT p FROM Perfume p");
        return query.getResultList();
    }

    public void update(Perfume perfume) {
        try {
            em.getTransaction().begin();
            em.merge(perfume);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }

    public void delete(Long id) {
        try {
            em.getTransaction().begin();
            Perfume perfume = em.find(Perfume.class, id);
            if (perfume != null) {
                em.remove(perfume);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }
} 