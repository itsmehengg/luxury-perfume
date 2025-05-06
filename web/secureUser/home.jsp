<%-- 
    Document   : home
    Created on : 3 May 2025, 9:47:53 pm
    Author     : Lucas
--%>

<%@ page language="java" %>
<%
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("../index.html");
        return;
    }
%>

<%@page import="java.sql.*, java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header2.html" %>
<!DOCTYPE html>
<html>
<head>
    <title>Luxury Perfume Products</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

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
            overflow-y: auto;
        }

        main {
            flex-grow: 1;
            width: 100%;
        }

        .card-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }

        .card {
            width: 200px;
            height: 300px;
            border-radius: 15px;
            background-color: #d3d3d3;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .product-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 30px;
            padding: 20px;
            text-align: center;
        }

        .product {
            font-family: Arial, sans-serif;
        }

        .product img {
            width: 100px;
            height: 140px;
        }
    </style>
</head>

<body>
    <main>
        <br/>
        <section class="top-banner">
            <img src="../img/store.png" alt="Banner" style="width: 60%; height: auto; margin-left: 20%; margin-right: 20%"><br/>
        </section>

        <hr style="width: 60%; margin: 20px auto;">

        <section class="features">
            <div style="display: flex; justify-content: space-around; align-items: flex-start; padding: 40px 20px; gap: 20px; text-align: left;">
                <div style="max-width: 300px;">
                    <i class="bi bi-lock-fill" style="font-size: 24px; color: black;"></i>
                    <h5><strong>100% Authentic Guaranteed</strong></h5>
                    <p style="font-size: 14px; color: #555;">
                        Only Authentic & Genuine Perfumes will be deliver to your door. 100% Authentic Guaranteed.
                    </p>
                </div>
                <div style="max-width: 300px;">
                    <i class="bi bi-shield-lock-fill" style="font-size: 24px; color: black;"></i>
                    <h5><strong>Secure Online Payment</strong></h5>
                    <p style="font-size: 14px; color: #555;">
                        All online transaction will be handled securely in highly encrypted payment gateway for FPX, Credit Cards and eWallet.
                    </p>
                </div>
                <div style="max-width: 300px;">
                    <i class="bi bi-star-fill" style="font-size: 24px; color: black;"></i>
                    <h5><strong>5/5 Stars Shopee Rating</strong></h5>
                    <p style="font-size: 14px; color: #555;">
                        500+ Verified Reviews from our Subscribers on Google, Facebook, and Official Website.
                    </p>
                </div>
            </div>

            <br/>

            <!-- Card Carousel (Dynamic) -->
            <div id="cardCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <%
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("org.apache.derby.jdbc.ClientDriver");
                            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/asgm", "nbuser", "nbuser");
                            ps = conn.prepareStatement("SELECT * FROM products");
                            rs = ps.executeQuery();

                            int count = 0;
                            boolean isFirst = true;

                            while (rs.next()) {
                                if (count % 5 == 0) {
                    %>
                    <div class="carousel-item <%= isFirst ? "active" : "" %>">
                        <div class="card-container">
                    <%
                                }
                    %>
                            <div class="card">
                                <img src="../imgUpload/<%= rs.getString("product_image") %>" alt="Product" style="width: 100px; height: 140px;">
                                <p style="margin-top: 10px;"><%= rs.getString("prod_name") %></p>
                                <p style="font-size: 12px; color: #333; padding: 0 10px;"><%= rs.getString("product_desc") %></p>
                                <p style="font-weight: bold; color: green;">RM <%= String.format("%.2f", rs.getDouble("product_price")) %></p>
            
                            </div>
                    <%
                                count++;
                                if (count % 5 == 0) {
                    %>
                        </div>
                    </div>
                    <%
                                    isFirst = false;
                                }
                            }

                            if (count % 5 != 0) {
                    %>
                        </div>
                    </div>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("Error: " + e.getMessage());
                        } finally {
                            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
                            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
                        }
                    %>
                </div>

                <button class="carousel-control-prev" type="button" data-bs-target="#cardCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#cardCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </section>

        <br/><br/>

        <!-- Hero Section -->
        <section style="position: relative; background: url('../img/store2.png') center center / cover no-repeat; height: 400px; display: flex; justify-content: center; align-items: center; text-align: center;">
            <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); z-index: 1;"></div>
            <div style="position: relative; z-index: 2; color: white; padding: 20px;">
                <img src="../img/transLogo.png" alt="Luxury Perfume Icon" style="width: 35%;">
                <h2 style="margin-top: 10px;">Why Buy Perfume With Us?</h2>
                <p style="max-width: 700px; margin: 10px auto;">
                    We believe in easy access to things that are good for our mind, body and spirit. 
                    With a clever offering, superb support and a secure checkout you’re in good hands.
                </p>
            </div>
        </section>

        <br/><br/>

        <!-- New Arrival -->
        <section style="position: relative; background-color: black; height: 400px; display: flex; justify-content: center; align-items: center; text-align: center;">
            <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); z-index: 1;"></div>
            <div style="position: relative; z-index: 2; color: white; padding: 20px;">
                <h2 style="margin-top: 10px;">About Us</h2>
                <p style="max-width: 700px; margin: 10px auto;">
                    Luxury Perfume was established in 2006 and continually grows its network of business 
                    across the Malaysia. The company was built primarily from trust and honesty, an altogether 
                    key ingredient in keeping the business successful in every turn. Today, Luxury Perfume lives 
                    out in fulfilling a mantra of excellence in leading the industry with very efficient services 
                    in shipping and selling one of the widest range of branded perfumes in Malaysia.
                </p>
            </div>
        </section>    
        <br/><br/>    
    </main>

    <!-- Footer -->
    <%@ include file="footer.html" %>
</body>
</html>
