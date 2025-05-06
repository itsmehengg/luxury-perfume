<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header2.html" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .feedback-container {
            max-width: 650px;
            margin: 0 auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 5px;
            margin-top: 50px;
        }
        .form-label {
            font-weight: 500;
        }
        .success-message {
            color: green;
            margin-bottom: 15px;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <%
    // Check if user is logged in
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("../index.html");
        return;
    }
    
    // Variables to store user information
    String userName = "";
    
    // Database connection to fetch user name and products
    Connection userConn = null;
    PreparedStatement userStmt = null;
    ResultSet userRs = null;
    
    // For products list
    PreparedStatement prodStmt = null;
    ResultSet prodRs = null;
    
    try {
        // Register Derby JDBC client driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        
        // Connect to the existing database
        String url = "jdbc:derby://localhost:1527/asgm";
        String dbUser = "nbuser";
        String dbPassword = "nbuser";
        userConn = DriverManager.getConnection(url, dbUser, dbPassword);
        
        // Query to get user name from users table
        String userQuery = "SELECT * FROM users WHERE user_id = ?";
        userStmt = userConn.prepareStatement(userQuery);
        userStmt.setInt(1, userId);
        userRs = userStmt.executeQuery();
        
        // Get user name if found
        if (userRs.next()) {
            userName = userRs.getString("name"); // Change "name" to match your actual column name if different
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
    <div class="container">
        <div class="feedback-container">
            <h2 class="mb-4 text-center">Submit Your Feedback</h2>
            
            <%
            // Initialize variables for message display
            String successMessage = "";
            String errorMessage = "";
            
            // Process the form submission
            if (request.getMethod().equalsIgnoreCase("post")) {
                // Get form data
                String feedbackDesc = request.getParameter("feedbackDesc");
                String userIdStr = userId.toString();
                String productId = request.getParameter("product");
                
                // Validate input
                if (feedbackDesc != null && !feedbackDesc.trim().isEmpty() && 
                    productId != null && !productId.trim().isEmpty()) {
                    
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    
                    try {
                        // Register Derby JDBC client driver
                        Class.forName("org.apache.derby.jdbc.ClientDriver");
                        
                        // Connect to the existing database
                        String url = "jdbc:derby://localhost:1527/asgm";
                        String dbUser = "nbuser";
                        String dbPassword = "nbuser";
                        conn = DriverManager.getConnection(url, dbUser, dbPassword);
                        
                        // Prepare SQL statement
                        String sql = "INSERT INTO feedback (feedback_desc, user_id, feedback_prod) VALUES (?, ?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, feedbackDesc);
                        pstmt.setString(2, userIdStr);
                        pstmt.setString(3, productId);
                        
                        // Execute SQL statement
                        int result = pstmt.executeUpdate();
                        
                        if (result > 0) {
                            successMessage = "Thank you! Your feedback has been submitted successfully.";
                        } else {
                            errorMessage = "Failed to submit feedback. Please try again.";
                        }
                        
                    } catch (Exception e) {
                        errorMessage = "Database error: " + e.getMessage();
                        e.printStackTrace();
                    } finally {
                        // Close resources
                        try {
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException se) {
                            se.printStackTrace();
                        }
                    }
                } else {
                    errorMessage = "Please fill in all required fields.";
                }
            }
            %>
            
            <!-- Success/Error Messages -->
            <% if (!successMessage.isEmpty()) { %>
                <div class="alert alert-success" role="alert">
                    <%= successMessage %>
                </div>
            <% } %>
            
            <% if (!errorMessage.isEmpty()) { %>
                <div class="alert alert-danger" role="alert">
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <!-- Feedback Form -->
            <form method="post" action="feedback.jsp">
                <div class="mb-3">
                    <label for="userName" class="form-label">Username</label>
                    <input type="text" class="form-control" id="userName" name="userName" value="<%= userName %>" disabled>
                </div>
                
                <!-- Product dropdown -->
                <div class="mb-3">
                    <label for="product" class="form-label">Select Product</label>
                    <select class="form-select" id="product" name="product" required>
                        <option value="" selected disabled>-- Select a product --</option>
                        <%
                        try {
                            // Query to get products
                            String prodQuery = "SELECT product_id, prod_name FROM products";
                            prodStmt = userConn.prepareStatement(prodQuery);
                            prodRs = prodStmt.executeQuery();
                            
                            // List all products in dropdown
                            while (prodRs.next()) {
                                String prodId = prodRs.getString("product_id");
                                String prodName = prodRs.getString("prod_name");
                                %>
                                <option value="<%= prodId %>"><%= prodName %></option>
                                <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        %>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label for="feedbackDesc" class="form-label">Your Feedback</label>
                    <textarea class="form-control" id="feedbackDesc" name="feedbackDesc" rows="5" required></textarea>
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Submit Feedback</button>
                </div>
            </form>
        </div>
    </div>
    <br/>
    <br/>
    
    <%
    // Close resources for user and product queries
    try {
        if (prodRs != null) prodRs.close();
        if (prodStmt != null) prodStmt.close();
        if (userRs != null) userRs.close();
        if (userStmt != null) userStmt.close();
        if (userConn != null) userConn.close();
    } catch (SQLException se) {
        se.printStackTrace();
    }
    %>
    
    <%@ include file="footer.html" %>
</body>
</html>