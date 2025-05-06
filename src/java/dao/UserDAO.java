package dao;

import Model.Users;
import java.sql.*;
import java.util.*;
import java.util.logging.Logger;
import java.util.logging.Level;

public class UserDAO {
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());
    private final String jdbcURL = "jdbc:derby://localhost:1527/perfumedb";
    private final String jdbcUser = "nbuser";
    private final String jdbcPass = "nbuser";
    private Connection conn;

    public UserDAO() {
        try {
            LOGGER.log(Level.INFO, "Initializing UserDAO");
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
            LOGGER.log(Level.INFO, "Database connection established");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error initializing UserDAO", e);
            e.printStackTrace();
        }
    }

    public List<Users> findAll() {
        List<Users> list = new ArrayList<>();
        try {
            LOGGER.log(Level.INFO, "Executing findAll query");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users");
            while (rs.next()) {
                Users u = new Users(
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("phone"),
                    rs.getString("gender"),
                    rs.getString("role")
                );
                list.add(u);
            }
            LOGGER.log(Level.INFO, "Found {0} users", list.size());
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in findAll", e);
            e.printStackTrace();
        }
        return list;
    }

    public Users findById(int id) {
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM USERS WHERE user_id=?");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Users(
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("phone"),
                    rs.getString("gender"),
                    rs.getString("role")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void create(Users user) {
        try {
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO USERS (name, password, email, phone, gender, role) VALUES (?, ?, ?, ?, ?, ?)");
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getGender());
            stmt.setString(6, user.getRole());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(Users user) {
        try {
            PreparedStatement stmt = conn.prepareStatement(
                "UPDATE USERS SET name=?, password=?, email=?, phone=?, gender=?, role=? WHERE user_id=?");
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getGender());
            stmt.setString(6, user.getRole());
            stmt.setInt(7, user.getUserId());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        try {
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM USERS WHERE user_id=?");
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

public List<Users> findByRole(String role) {
    List<Users> list = new ArrayList<>();
    try {
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE role = ?");
        stmt.setString(1, role);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Users u = new Users(
                rs.getInt("user_id"),
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("phone"),
                rs.getString("gender"),
                rs.getString("role")
            );
            list.add(u);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


    public void close() {
        try {
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
