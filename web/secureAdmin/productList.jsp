<%-- 
    Document   : productList
    Created on : 1 May 2025, 3:51:50 pm
    Author     : Lucas
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <style>
        .table td, .table th {
            vertical-align: middle;
        }
        .product-img {
            width: 80px;
            height: auto;
        }
        .quantity-box {
            width: 60px;
        }
    </style>
    <script>
        function confirmMultiDelete() {
            return confirm('Are you sure you want to delete the selected product(s)?');
        }

        function confirmSingleDelete() {
            return confirm('Are you sure you want to delete this product?');
        }

        function toggleSelectAll(source) {
            const checkboxes = document.getElementsByName('product_id');
            for (let i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = source.checked;
            }
        }
    </script>
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Product Cart</h2>

    <form action="deleteProduct.jsp" method="post" onsubmit="return confirmMultiDelete();">
        <table class="table table-bordered align-middle">
            <thead class="table-success">
                <tr>
                    <th><input type="checkbox" onclick="toggleSelectAll(this)"></th>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/perfumedb", "nbuser", "nbuser");
                    stmt = conn.createStatement();
                    String query = "SELECT * FROM product";
                    rs = stmt.executeQuery(query);
                    while (rs.next()) {
                        String id = rs.getString("product_id");
                        String name = rs.getString("prod_name");
                        String desc = rs.getString("product_desc");
                        String image = rs.getString("product_image");
                        double price = rs.getDouble("product_price");
                        int quantity = rs.getInt("product_quantity");
                        double total = price * quantity;
            %>
                <tr>
                    <td><input type="checkbox" name="product_id" value="<%= id %>"></td>
                    <td>
                        <div class="d-flex align-items-center">
                            <img src="imgUpload/<%= image %>" class="product-img me-3" alt="Product Image">
                            <div>
                                <strong><%= name %></strong><br/>
                                <small><%= desc %></small>
                            </div>
                        </div>
                    </td>
                    <td>$<%= String.format("%.2f", price) %></td>
                    <td><input type="number" class="form-control quantity-box" value="<%= quantity %>" readonly></td>
                    <td>$<%= String.format("%.2f", total) %></td>
                    <td>
                        <form action="deleteProduct.jsp" method="post" onsubmit="return confirmSingleDelete();">
                            <input type="hidden" name="product_id" value="<%= id %>">
                            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                        </form>
                    </td>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <tr><td colspan="6">Error fetching data. Error: <%= e.getMessage() %></td></tr>
            <%
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                    try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
                    try { if (conn != null) conn.close(); } catch (Exception ignored) {}
                }
            %>
            </tbody>
        </table>

        <button type="submit" class="btn btn-danger">Delete Selected</button>
    </form>
</div>
</body>
</html>
