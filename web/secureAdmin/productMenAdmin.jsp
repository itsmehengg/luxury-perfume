<%-- 
    Document   : productMenAdmin
    Created on : 29 Apr 2025, 2:34:48 pm
    Author     : Lucas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luxury Perfume Products</title>
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
            height: auto; /* Allow the body height to adjust based on content */
            min-height: 100vh; /* Ensure the body takes at least the full viewport height */
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* Align content to the top */
            align-items: center;
            overflow-y: auto; /* Enable vertical scrolling */
            margin: 0;
        }

        /* Add padding to avoid overlap with header and footer */
        body {
            padding-top: 0; /* Space for the header */
        }

        main {
            flex-grow: 1; /* Push the footer to the bottom if content is short */
            width: 100%;
            padding: 0; /* Add padding for spacing */
            box-sizing: border-box; /* Include padding in width/height calculations */
            margin-bottom: 20px;
        }

        /* Header adjustments */
        header {
            width: 100%;
            height: 15vh;
            background-color: black;
            display: flex;
            align-items: center;
            padding-left: 10px;
            z-index: 1000; /* Ensure it stays above other content */
        }

        header img {
            height: 140%;
            cursor: pointer;
        }

        .header-links {
            display: flex;
            align-items: center;
            gap: 20px; /* Add spacing between links */
            margin-left: auto; 
            padding-right: 20px;
        }

        .header-links a {
            color: white;
            text-decoration: none;
            font-size: 16px;
        }

        .header-links a:hover {
            text-decoration: underline;
        }

        /* Footer adjustments */
        footer {
            width: 100%;
            background-color: black;
            color: white;
            display: flex;
            justify-content: flex-start; /* Align items to the left */
            gap: 20px; /* Add spacing between columns */
            text-align: left;
            font-size: 14px;
            padding: 20px; /* Add padding for spacing */
            height: auto; /* Allow height to adjust based on content */
            min-height: 10vh; /* Ensure a minimum height */
            box-sizing: border-box; /* Include padding in height calculations */
        }

        .footer-column {
            display: flex;
            flex-direction: column; /* Stack items vertically in each column */
            gap: 5px; /* Add spacing between items in each column */
        }

        .footer-column p {
            margin: 0; /* Remove default margins for tighter spacing */
        }

        .footer-column a {
            color: white; /* Ensure links are visible */
            text-decoration: none; /* Remove underline from links */
        }

        .footer-column a:hover {
            text-decoration: underline; /* Add underline on hover for better UX */
        }

        /* Media Queries for Responsiveness */
        @media (max-width: 768px) {
            footer {
                flex-direction: column; /* Stack footer columns vertically on smaller screens */
                align-items: center;
                text-align: center;
            }

            .footer-column {
                align-items: center; /* Center items in each column */
            }
        }

        /* Navbar adjustments */
        .navbar {
            margin: 0; /* Remove any default margin */
            width: 100%; /* Ensure the navbar spans the full width of the screen */
            border-radius: 0; /* Remove any rounded corners */
        }

        /* Highlight the active category with a yellow underline */
        .navbar-nav .nav-link.active {
            border-bottom: 3px solid yellow; /* Yellow underline for the active link */
        }

        /* Remove default underline for non-active links */
        .navbar-nav .nav-link {
            border-bottom: none;
        }

        /* Add hover effect for non-active links */
        .navbar-nav .nav-link:hover {
            border-bottom: 3px solid lightgray; /* Light gray underline on hover */
        }

        /* Style the search bar */
        .input-group .form-control {
            border-right: none; /* Remove right border of the input field */
        }

        .input-group .btn {
            border-left: none; /* Remove left border of the button */
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Sidebar Filters adjustments */
        .sidebar {
            border-right: 1px solid #ddd; /* Add a vertical line */
            padding-right: 20px; /* Add some padding to the right */
            margin-right: 20px; /* Add some margin to the right */
        }

        /* Vertical divider styling */
        .vertical-divider {
            width: 1px;
            background-color: #ddd;
            align-self: stretch;
            margin: 0 15px;
        }
        
        /* Flexbox layout for sidebar and product grid */
        .d-flex.flex-row {
            display: flex;
            flex-direction: row;
            margin-left: 20px;
            margin-right: 20px;
        }
        
        /* Product card styling */
        .card {
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: transform 0.3s;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .card-img-top {
            padding: 10px;
            margin: 0 auto;
            display: block;
        }
        
        .card-title {
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .text-muted {
            color: #6c757d;
        }
    </style>
</head>
<body>
    <!-- Main Content -->
    <main>
    <%
        String dbURL = "jdbc:derby://localhost:1527/asgm";
        String dbUser = "nbuser";
        String dbPass = "nbuser";

        int currentPage = 1;
        int recordsPerPage = 9;
        if (request.getParameter("currentPage") != null)
            currentPage = Integer.parseInt(request.getParameter("currentPage"));

        String searchTerm = request.getParameter("search") != null ? request.getParameter("search").trim() : "";
        String priceParam = request.getParameter("maxPrice");
        double maxProductPrice = 153.0;
        double selectedPrice = priceParam != null && !priceParam.isEmpty() ? Double.parseDouble(priceParam) : maxProductPrice;

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int totalRecords = 0;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Get max product price
            stmt = conn.prepareStatement("SELECT MAX(product_price) FROM products");
            rs = stmt.executeQuery();
            if (rs.next()) {
                maxProductPrice = rs.getDouble(1);
            }
            rs.close();
            stmt.close();

            // Count filtered records
            String countSQL = "SELECT COUNT(*) FROM products WHERE product_price <= ? AND LOWER(prod_name) LIKE ?";
            stmt = conn.prepareStatement(countSQL);
            stmt.setDouble(1, selectedPrice);
            stmt.setString(2, "%" + searchTerm.toLowerCase() + "%");
            rs = stmt.executeQuery();
            if (rs.next()) {
                totalRecords = rs.getInt(1);
            }
            rs.close();
            stmt.close();

            // Fetch products
            String productSQL = "SELECT * FROM products WHERE product_price <= ? AND LOWER(prod_name) LIKE ? OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            stmt = conn.prepareStatement(productSQL);
            stmt.setDouble(1, selectedPrice);
            stmt.setString(2, "%" + searchTerm.toLowerCase() + "%");
            stmt.setInt(3, (currentPage - 1) * recordsPerPage);
            stmt.setInt(4, recordsPerPage);
            rs = stmt.executeQuery();
    %>

    <div class="d-flex flex-row mt-4">
        <!-- Filter and Search Sidebar -->
        <div class="p-2" style="width: 200px; min-width: 200px;">
            <h5>Search Products</h5>
            <form method="get" action="productMenAdmin.jsp">
                <input type="text" name="search" class="form-control mb-2" placeholder="Search by name" value="<%= searchTerm %>">
                
                <hr class="mt-4">
                
                <label for="priceRange">Max Price: RM <span id="priceValue"><%= (int) selectedPrice %></span></label>
                <input 
                    type="range" 
                    name="maxPrice" 
                    class="form-range" 
                    min="0" 
                    max="<%= (int) maxProductPrice %>" 
                    id="priceRange" 
                    value="<%= (int) selectedPrice %>" 
                    oninput="document.getElementById('priceValue').textContent = this.value">
                <button type="submit" class="btn btn-primary btn-sm mt-2">Apply</button>
            </form>
                    
            <hr class="mt-4">
            
            <a href="../addProduct.jsp" class="btn btn-success btn-sm w-100">+ Add Product</a>
                <br/>
                <br/>
            <a href="productList.jsp" class="btn btn-danger btn-sm w-100">🗑️ Delete Product</a>
        </div>
                 
        
           

        <div class="vertical-divider"></div>

        <!-- Products Section -->
        <div class="p-2" style="flex-grow: 1;">
            <div class="d-flex flex-wrap">
                <% while(rs.next()) { %>
                <div class="p-2" style="width: 350px;">
                    <div class="card">
                        <div class="text-center mt-3">
                            <img src="../imgUpload/<%= rs.getString("product_image") %>" class="card-img-top" alt="Product Image" style="height: 180px; width: auto; max-width: 80%; object-fit: contain;">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title"><%= rs.getString("prod_name") %></h5>
                            <p class="card-text"><%= rs.getString("product_desc") %></p>
                            <p class="card-text"><strong>RM <%= String.format("%.2f", rs.getDouble("product_price")) %></strong></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                                    <button type="button" class="btn btn-sm btn-outline-secondary">Buy</button>
                                    <a href="editProduct.jsp?product_id=<%= rs.getString("product_id") %>" class="btn btn-sm btn-outline-primary">Edit</a>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Pagination -->
            <nav aria-label="Page navigation example" class="mt-3">
                <ul class="pagination justify-content-end">
                    <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                        <a class="page-link" href="productMen.jsp?currentPage=<%= currentPage - 1 %>&maxPrice=<%= (int) selectedPrice %>&search=<%= searchTerm %>">Previous</a>
                    </li>
                    <%
                        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
                        for (int i = 1; i <= totalPages; i++) {
                    %>
                    <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                        <a class="page-link" href="productMen.jsp?currentPage=<%= i %>&maxPrice=<%= (int) selectedPrice %>&search=<%= searchTerm %>"><%= i %></a>
                    </li>
                    <% } %>
                    <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
                        <a class="page-link" href="productMen.jsp?currentPage=<%= currentPage + 1 %>&maxPrice=<%= (int) selectedPrice %>&search=<%= searchTerm %>">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <%
        rs.close();
        stmt.close();
        conn.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
    %>
    </main>
    <!-- Main Content -->

    
    <script>
        // Optional: keep label updated on page load
        window.onload = function() {
            var slider = document.getElementById("priceRange");
            if (slider) {
                document.getElementById("priceValue").textContent = slider.value;
            }
        };
    </script>
</body>
</html>