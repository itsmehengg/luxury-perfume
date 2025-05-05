/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Contoller;

import Model.Users;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.transaction.Transactional;

/**
 *
 * @author acer
 */
public class userDao {
    private EntityManagerFactory emf;
    private EntityManager em;
    
    public userDao() {
        emf = Persistence.createEntityManagerFactory("LuxuryPerfumePU");
        em = emf.createEntityManager();
    }
    
    // Create
    @Transactional
    public boolean createUser(Users user) {
        try {
            em.persist(user);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Read
    public Users getUserById(int userId) {
        return em.find(Users.class, userId);
    }
    
    public List<Users> getAllUsers() {
        Query query = em.createNamedQuery("Users.findAll");
        return query.getResultList();
    }
    
    public Users getUserByEmail(String email) {
        Query query = em.createNamedQuery("Users.findByEmail");
        query.setParameter("email", email);
        try {
            return (Users) query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
    
    // Update
    @Transactional
    public boolean updateUser(Users user) {
        try {
            em.merge(user);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete
    @Transactional
    public boolean deleteUser(int userId) {
        try {
            Users user = getUserById(userId);
            if (user != null) {
                em.remove(user);
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Close resources
    public void close() {
        if (em != null) {
            em.close();
        }
        if (emf != null) {
            emf.close();
        }
    }
}
