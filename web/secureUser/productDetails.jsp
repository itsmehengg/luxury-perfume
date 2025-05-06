<%@ page language="java" %>
<%
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("../index.html");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header2.html" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body adjustments for scrollable content */
        body {
            height: auto;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            overflow-y: auto;
            margin: 0;
        }

        /* Add padding to avoid overlap with header and footer */
        body {
            padding-top: 0; 
        }

        main {
            flex-grow: 1;
            width: 100%;
            padding: 0 20px;
            box-sizing: border-box;
            margin-bottom: 20px;
            max-width: 1200px;
        }

        .product-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 30px;
        }

        .product-image {
            max-height: 400px;
            width: auto;
            max-width: 100%;
            object-fit: contain;
        }

        .product-name {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .product-price {
            font-size: 24px;
            color: #e63946;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .product-quantity {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
        }

        .product-description {
            font-size: 16px;
            line-height: 1.6;
            color: #333;
            margin-bottom: 30px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            padding: 10px 20px;
            font-size: 16px;
        }

        .btn-primary:hover {
            background-color: #0069d9;
            border-color: #0062cc;
        }

        .error-message {
            color: red;
            font-weight: bold;
            padding: 20px;
            background-color: #ffe6e6;
            border-radius: 5px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <main>
        <%
        String dbURL = "jdbc:derby://localhost:1527/asgm";
        String dbUser = "nbuser";
        String dbPass = "nbuser";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        // Get product ID from request parameter
        String productId = request.getParameter("product_id");
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            
            if (productId != null && !productId.isEmpty()) {
                String sql = "SELECT * FROM products WHERE product_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, productId); // Correct method for string ID
                rs = stmt.executeQuery();
                
                if (rs.next()) {
        %>
                <div class="product-container">
                    <div class="row">
                        <div class="col-md-5 text-center">
                            <img src="../imgUpload/<%= rs.getString("product_image") %>" class="product-image" alt="<%= rs.getString("prod_name") %>">
                        </div>
                        <div class="col-md-7">
                            <h1 class="product-name"><%= rs.getString("prod_name") %></h1>
                            <div class="product-price">RM <%= String.format("%.2f", rs.getDouble("product_price")) %></div>
                            <div class="product-quantity">In Stock: <%= rs.getInt("product_quantity") %></div>
                            <div class="product-description"><%= rs.getString("product_desc") %></div>
                            <div class="d-flex gap-2">
                                <a href="productMen.jsp" class="btn btn-secondary">Back to Products</a>
                                <button class="btn btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </div>
        <%
                } else {
        %>
                <div class="error-message">
                    Product not found. The product may have been removed or the ID is invalid.
                </div>
        <%
                }
            } else {
        %>
            <div class="error-message">
                No product ID specified. Please select a product from the product listing.
            </div>
        <%
            }
        } catch(Exception e) {
        %>
            <div class="error-message">
                Error: <%= e.getMessage() %>
            </div>
        <%
        } finally {
            // Close resources
            try {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(conn != null) conn.close();
            } catch(SQLException e) {
                e.printStackTrace();
            }
        }
        %>
    </main>

    <!-- Footer -->
    <%@ include file="footer.html" %>
    <!-- Footer -->
</body>
</html>