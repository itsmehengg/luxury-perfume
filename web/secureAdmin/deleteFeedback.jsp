<%-- 
    Document   : deleteFeedback
    Created on : 5 May 2025, 3:42:12?pm
    Author     : Lucas
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="application/json" %>
<%
    String idParam = request.getParameter("id");
    boolean success = false;
    String message = "";

    if (idParam != null) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/asgm", "nbuser", "nbuser");

            String sql = "DELETE FROM feedback WHERE feedback_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(idParam));

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
            message = success ? "Feedback deleted successfully." : "No feedback found with that ID.";
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    } else {
        message = "Missing feedback ID.";
    }

    out.print("{\"success\":" + success + ", \"message\":\"" + message + "\"}");
%>

