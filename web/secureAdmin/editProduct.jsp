<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .form-container {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        
        .preview-image {
            max-width: 200px;
            max-height: 200px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center mb-4">Edit Product</h2>
        
        <%
        String dbURL = "jdbc:derby://localhost:1527/asgm";
        String dbUser = "nbuser";
        String dbPass = "nbuser";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        String productId = request.getParameter("product_id");
        String status = request.getParameter("status");
        String errorMsg = null;
        
        if (status != null && status.equals("success")) {
        %>
            <div class="alert alert-success" role="alert">
                Product updated successfully!
            </div>
        <%
        } else if (status != null && status.equals("error")) {
        %>
            <div class="alert alert-danger" role="alert">
                Error updating product. Please try again.
            </div>
        <%
        }

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "SELECT * FROM products WHERE product_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, productId);
            rs = stmt.executeQuery();

            if (rs.next()) {
        %>
        <div class="form-container">
            <% if (errorMsg != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= errorMsg %>
                </div>
            <% } %>

            <!-- Changed form to post to the servlet instead of the JSP -->
            <form action="../secureAdmin/EditProductServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="product_id" value="<%= rs.getString("product_id") %>">
                
                <div class="mb-3">
                    <label for="prod_name" class="form-label">Product Name</label>
                    <input type="text" class="form-control" id="prod_name" name="prod_name" value="<%= rs.getString("prod_name") %>" required>
                </div>
                
                <div class="mb-3">
                    <label for="product_desc" class="form-label">Product Description</label>
                    <textarea class="form-control" id="product_desc" name="product_desc" rows="3" required><%= rs.getString("product_desc") %></textarea>
                </div>
                
                <div class="mb-3">
                    <label for="product_price" class="form-label">Price (RM)</label>
                    <input type="number" class="form-control" id="product_price" name="product_price" step="0.01" value="<%= rs.getDouble("product_price") %>" required>
                </div>
                
                <div class="mb-3">
                    <label for="product_quantity" class="form-label">Quantity</label>
                    <input type="number" class="form-control" id="product_quantity" name="product_quantity" value="<%= rs.getInt("product_quantity") %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Current Image</label>
                    <div>
                        <img src="../imgUpload/<%= rs.getString("product_image") %>" alt="Current Product Image" class="preview-image" id="currentImage">
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="product_image" class="form-label">Update Image</label>
                    <input type="file" class="form-control" id="product_image" name="product_image" accept="image/*">
                    <div class="form-text">Upload a new image to replace the current one (optional)</div>
                </div>
                
                <div class="d-flex justify-content-between mt-4">
                    <a href="productMenAdmin.jsp" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Update Product</button>
                </div>
            </form>
        </div>
        <%
            } else {
        %>
                <div class="alert alert-warning" role="alert">
                    Product not found.
                </div>
                <a href="productMenAdmin.jsp" class="btn btn-primary">Back to Products</a>
        <%
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        %>
            <div class="alert alert-danger" role="alert">
                Error retrieving product information: <%= e.getMessage() %>
            </div>
            <a href="productMenAdmin.jsp" class="btn btn-primary">Back to Products</a>
        <%
        }
        %>
    </div>

    <script src="js/bootstrap.bundle.min.js"></script>
    <script>
        // Preview image before upload
        document.getElementById('product_image').addEventListener('change', function(e) {
            if (e.target.files && e.target.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('currentImage').src = e.target.result;
                }
                reader.readAsDataURL(e.target.files[0]);
            }
        });
    </script>
</body>
</html>