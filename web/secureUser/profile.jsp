<%-- 
    Document   : profile
    Created on : 4 May 2025, 12:20:42 am
    Author     : Lucas
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header2.html" %>


<%
    // Handle logout
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("logout") != null) {
        session.invalidate(); // Clear session
        response.sendRedirect("../index.html"); // Redirect to homepage or login
        return;
    }
%>

<%
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("../index.html");
        return;
    }

    String name = "";
    String email = "";

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/asgm", "nbuser", "nbuser");
        PreparedStatement ps = conn.prepareStatement("SELECT name, email FROM users WHERE user_id = ?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f0f0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .profile-container {
            display: flex;
            padding-top: 20px;
            flex-direction: row;
            flex-wrap: nowrap;
            gap: 20px;
            max-width: 1000px;
            margin: 0 auto;
            height: 450px;
        }

        @media (max-width: 768px) {
            .profile-container {
                flex-direction: column;
            }
        }
        .profile-card {
            background-color: #333;
            color: white;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            width: 100%;
            max-width: 350px;
            align-content: center;
        }
        .profile-details {
            background-color: #333;
            color: white;
            border-radius: 10px;
            padding: 30px;
            padding-left: 10%;
            padding-right: 10%;
            width: 100%;
            flex-grow: 1;
            align-content: center;
        }
        .avatar {
            width: 120px;
            height: 120px;
            margin: 0 auto 20px;
            position: relative;
        }
        .avatar img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
        }
        .detail-row {
            padding: 15px 0;
            border-bottom: 1px solid #444;
            display: flex;
        }
        .detail-row:last-child {
            border-bottom: none;
        }
        .detail-label {
            font-weight: 500;
            width: 150px;
        }
        .detail-value {
            color: #a0a0a0;
        }
        .changeBtn {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .btnChange {
            font-size: 14px;
            padding: 6px 14px;
            border: none;
            background-color:rgb(0, 132, 255);
            color: white;
            border-radius: 15px;
            transition: all 0.3s ease-in-out;
            margin-right: 5px;
            text-decoration: none;
            display: inline-block;
        }

        .btnChange:hover {
            background-color:rgb(10, 86, 173);
            transform: scale(1.05);
        }
        .btnLogout {
            font-size: 14px;
            padding: 6px 14px;
            border: none;
            background-color:rgb(235, 0, 0);
            color: white;
            border-radius: 15px;
            transition: all 0.3s ease-in-out;
            margin-right: 5px;
            text-decoration: none;
            display: inline-block;
        }

        .btnLogout:hover {
            background-color:rgb(200, 0, 0);
            transform: scale(1.05);
        }
        input[type="button"][name="btnLogout"] {
            margin-top: 20px;
            margin-left: 20px;
            padding: 10px 20px ;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.2s ease-in-out;
        }

        input[type="button"][name="btnLogout"]:hover {
            background-color: #c82333;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
<form>
    <div class="profile-container">
        <!-- Left Profile Card -->
        <div class="profile-card">
            <div class="avatar">
                <img src="../img/profile.jpg" alt="User" id="img0" width="100;" class="rounded-circle">
            </div>
        </div>

        <!-- Right Details Card -->
        <div class="profile-details">
            <div class="detail-row">
                <div class="detail-label">Name</div>
                <div class="detail-value"><%= name %></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Email</div>
                <div class="detail-value"><%= email %></div>
            </div>
        </div>
    </div>
</form>

<br/>
<div class="logout" style="margin-bottom:20px">
    <form method='post'>
        <button type="submit" name="logout" class="btnLogout"
                style='display:block;margin-left: auto;margin-right: auto'
                onclick="alert('<%= email %>, you have successfully logged out. \nThanks for using Luxury Perfume website.\n We hope to hear from you soon.')">
            Log Out
        </button>
    </form>
</div>

<%@ include file="footer.html" %>

</body>
</html>
