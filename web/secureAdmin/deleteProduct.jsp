<%-- 
    Document   : deleteProduct
    Created on : 1 May 2025, 3:42:41 pm
    Author     : Lucas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String[] productIds = request.getParameterValues("product_id");

    if (productIds == null) {
        // Maybe it's a single delete form — get it directly
        String singleId = request.getParameter("product_id");
        if (singleId != null) {
            productIds = new String[] { singleId };
        }
    }

    if (productIds != null && productIds.length > 0) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/asgm", "nbuser", "nbuser");

            String sql = "DELETE FROM products WHERE product_id = ?";
            stmt = conn.prepareStatement(sql);

            for (String productId : productIds) {
                stmt.setString(1, productId);
                stmt.addBatch();
            }

            stmt.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }

    response.sendRedirect("productList.jsp");
%>
