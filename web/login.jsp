<%-- 
    Document   : login
    Created on : 3 May 2025, 9:42:55 pm
    Author     : Lucas
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username"); // could be username or email
    String password = request.getParameter("password");

    if (username != null && password != null) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/asgm;create=true", "nbuser", "nbuser");

            String query = "SELECT * FROM users WHERE (name=? OR email=?) AND password=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, username); // match as username
            ps.setString(2, username); // match as email
            ps.setString(3, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Set session attributes
                session.setAttribute("user_id", rs.getInt("user_id"));
                session.setAttribute("user_name", rs.getString("name"));
                String role = rs.getString("role");
                session.setAttribute("user_role", role);

                // Redirect based on role
                if ("user".equalsIgnoreCase(role)) {
                    response.sendRedirect("secureUser/home.jsp");
                } else if ("staff".equalsIgnoreCase(role) || "manager".equalsIgnoreCase(role)) {
                    response.sendRedirect("secureAdmin/productMenAdmin.jsp");
                } else {
                    // Unknown role, redirect to login with error
                    response.sendRedirect("login.jsp?error=role");
                }
            } else {
                // No match
                response.sendRedirect("login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luxury Perfume Login</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
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
            background-image: url('img/Background.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* Align content to the top */
            align-items: center;
            overflow-y: auto; /* Enable vertical scrolling */
            margin: 0;
        }

        /* Add padding to avoid overlap with header and footer */
        body {
            padding-top: 15vh; /* Space for the header */
        }

        /* Header and Footer adjustments */
        header {
            position: fixed; /* Stick to the top */
            top: 0;
            width: 100%;
            height: 15vh;
            background-color: black;
            display: flex;
            align-items: center;
            padding-left: 10px;
            z-index: 1000; /* Ensure it stays above other content */
        }

        footer {
            width: 100%;
            background-color: black;
            color: white;
            display: flex;
            align-items: flex-start; /* Center items horizontally */
            text-align: left;
            font-size: 14px;
            padding: 20px; /* Add padding for spacing */
            height: auto; /* Allow height to adjust based on content */
            min-height: 10vh; /* Ensure a minimum height */
            box-sizing: border-box; /* Include padding in height calculations */
        }

        .footer-container {
            display: flex;
            justify-content: flex-start; /* Align items to the left */
            gap: 20px; /* Add spacing between columns */
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

        header img {
            height: 140%;
            cursor: pointer;
        }

        /* Login Form adjustments */
        .login-form {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-grow: 1; /* Allow the form to take up remaining space */
            width: 100%;
            padding: 20px; /* Add padding to prevent content from touching edges */
            box-sizing: border-box; /* Include padding in width/height calculations */
        }
        
        .login-container {
            display: flex;
            flex-wrap: wrap; /* Allow wrapping for smaller screens */
            width: 80%; /* Adjust width as needed */
            justify-content: center; /* Center content on smaller screens */
            align-items: center;
            gap: 20px; /* Add spacing between elements */
        }

        .login-container img {
            width: 50%; /* Set the width */
            height: 50%; /* Set the height */
            object-fit: cover; /* Ensures the image scales properly */
            flex-shrink: 0;
        }

        .login-box {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%; /* Full width on smaller screens */
            max-width: 400px; /* Limit width on larger screens */
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .login-box h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: black;
            text-align: center; /* Center text for better responsiveness */
        }

        .login-box form {
            display: flex;
            flex-direction: column;
            gap: 15px; /* Space between form elements */
            width: 100%;
        }

        .login-box form input,
        .login-box form button {
            padding: 10px;
            font-size: 16px;
            width: 100%;
        }

        .login-box form button {
            color: white;
            border: none;
            cursor: pointer;
        }

        .login-box form button:hover {
            background-color: gray;
        }

        /* Media Queries for Responsiveness */
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column; /* Stack elements vertically on smaller screens */
            }

            .login-container img {
                max-width: 70%; /* Reduce image size on smaller screens */
            }

            .login-box {
                width: 90%; /* Take most of the screen width on smaller devices */
            }
        }

        @media (max-width: 576px) {a
            .login-container img {
                max-width: 100%; /* Full width for very small screens */
            }

            .login-box {
                width: 100%; /* Full width for very small screens */
            }
        }
    </style>
</head>

<body>
    <!-- Header -->
    <header>
        <img src="img/transLogo.png" alt="Luxury Perfume" onclick="window.location.href='index.jsp'">
    </header>
    <!-- Header -->
    
    
    <%
        String error = request.getParameter("error");
        if ("invalid".equals(error)) {
    %>
        <p style="color: red; text-align: center;">Invalid username or password.</p>
    <%
        }
    %>
    

    <!-- Login Form -->
    <div class="login-form">
        <div class="login-container">
            <img src="img/transLogo.png" alt="Luxury Perfume">
            <div class="login-box">
                <form action="login.jsp" method="POST">
                    <h2>Login</h2>
                    <!-- Username Field -->
                    <div class="form-floating mb-3">
                        <input type="text" id="username" name="username" class="form-control" placeholder="Username" required>
                        <label for="username">Username or Email</label>
                    </div>
                    <!-- Password Field -->
                    <div class="form-floating mb-3">
                        <input type="password" id="inputPassword5" name="password" class="form-control" placeholder="Password" required>
                        <label for="inputPassword5">Password</label>
                    </div>
                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-warning">Login</button>
                    <hr class="mt-4">
                    <p style="text-align: center;">New to Luxury Perfume? <a href="signUp.jsp">Sign Up</a></p>
                </form>
            </div>
        </div>
    </div>
    <!-- Login Form -->

    <!-- Footer -->
    <%@ include file="/secureUser/footer.html" %>
    <!-- Footer -->
</body>
</html>

