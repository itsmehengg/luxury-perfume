package controller;

import Model.Users;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SignUpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response, int id) throws ServletException, IOException {
        // Collect user inputs
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String role = "customer"; // Default role

        // Model object
        Users user = new Users(name, email, password, phone, gender, role);
        String dbURL = "jdbc:derby://localhost:1527/perfumedb";
        String dbUser = "nbuser";
        String dbPass = "nbuser";

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            String sql = "INSERT INTO Users (name, password, email, phone, gender, role) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getGender());
            stmt.setString(6, user.getRole());

            int result = stmt.executeUpdate();
            stmt.close();
            conn.close();

            if (result > 0) {
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("errorMessage", "Registration failed. Try again.");
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
        }
    }
}
