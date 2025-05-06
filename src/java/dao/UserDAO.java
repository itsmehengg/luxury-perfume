package dao;

import database.DatabaseConnection;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import Model.Users;

public class UserDAO {
    private EntityManager em;

    public UserDAO() {
        em = DatabaseConnection.getEntityManager();
    }

    public void create(Users user) {
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }

    public Users findById(Integer userId) {
        return em.find(Users.class, userId);
    }

    public Users findByEmail(String email) {
        Query query = em.createQuery("SELECT u FROM Users u WHERE u.email = :email");
        query.setParameter("email", email);
        try {
            return (Users) query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    public List<Users> findAll() {
        Query query = em.createQuery("SELECT u FROM Users u");
        return query.getResultList();
    }

    public void update(Users user) {
        try {
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }

    public void delete(Integer userId) {
        try {
            em.getTransaction().begin();
            Users user = em.find(Users.class, userId);
            if (user != null) {
                em.remove(user);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }

    public Users authenticate(String email, String password) {
        Query query = em.createQuery("SELECT u FROM Users u WHERE u.email = :email AND u.password = :password");
        query.setParameter("email", email);
        query.setParameter("password", password);
        try {
            return (Users) query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
} 