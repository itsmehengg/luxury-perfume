<%-- 
    Document   : aboutUs
    Created on : 4 May 2025, 2:02:02 pm
    Author     : Lucas
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header2.html" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luxury Perfume - About Us</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('<c:url value="/resources/images/hero-background.jpg"/>' ) center/cover no-repeat;
            height: 400px;
            color: white;
        }
        
        .section-title {
            position: relative;
            margin-bottom: 40px;
            font-family: 'Playfair Display', serif;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background-color: #d4af37;
        }
        
        .timeline-item {
            position: relative;
            padding: 20px 30px;
            border-left: 2px solid #d4af37;
            margin-bottom: 20px;
        }
        
        .timeline-item:before {
            content: '';
            position: absolute;
            left: -10px;
            top: 20px;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: #d4af37;
        }
        
        .value-icon {
            font-size: 2.5rem;
            color: #d4af37;
            margin-bottom: 15px;
        }
        
        /* Updated team member styles for consistent image sizes */
        .team-member {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .team-member .image-wrapper {
            width: 220px;
            height: 220px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        
        .team-member .image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center top;
        }
        
        .team-member:hover .image-wrapper {
            transform: scale(1.05);
        }
        
        footer {
            background-color: #212529;
            color: white;
        }
        
        .gold-text {
            color: #d4af37;
        }
        
        .elegant-font {
            font-family: 'Playfair Display', serif;
        }
        
        .testimonial-card {
            border-left: 4px solid #d4af37;
        }
    </style>
</head>
<body>

    <!-- Hero Section -->
    <section class="hero-section d-flex align-items-center">
        <div class="container text-center">
            <h1 class="display-4 elegant-font mb-4">Our Story</h1>
            <p class="lead">Crafting exquisite scents that tell your unique story</p>
        </div>
    </section>

    <!-- About Us Introduction -->
    <section class="py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0">
                    <img src="../img/transLogo.png" alt="Luxury Perfume Artisans" class="img-fluid rounded shadow">
                </div>
                <div class="col-lg-6">
                    <h2 class="section-title text-center">Who We Are</h2>
                    <p>At Luxury Perfume, we are more than just a fragrance brand—we are artisans of emotion, creators of memories, and custodians of tradition. Founded in 2010, our atelier has been dedicated to the meticulous craft of perfumery, combining time-honored techniques with innovative approaches.</p>
                    <p>Every bottle that leaves our workshop carries with it our passion for excellence and our commitment to using only the finest ingredients sourced from around the world. We believe that a truly exceptional fragrance is an invisible accessory that completes your personal style and leaves an unforgettable impression.</p>
                    <p>Luxury Perfume stands at the intersection of artistry and science, where the delicate balance of notes creates symphonies for the senses. Our master perfumers bring decades of experience to each creation, ensuring that every scent tells a compelling story.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Our Journey -->
    <section class="py-5 bg-light">
        <div class="container">
            <h2 class="section-title text-center">Our Journey</h2>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <c:forEach var="milestone" items="${journeyMilestones}" varStatus="status">
                        <div class="timeline-item">
                            <h4>${milestone.year} - ${milestone.title}</h4>
                            <p>${milestone.description}</p>
                        </div>
                    </c:forEach>
                    
                    <%-- Fallback if no data is provided from the server --%>
                    <c:if test="${empty journeyMilestones}">
                        <div class="timeline-item">
                            <h4>2010 - The Beginning</h4>
                            <p>Luxury Perfume was founded by renowned perfumer Isabella Laurent in a small atelier in Paris. With a vision to create fragrances that transcend trends, Isabella assembled a team of dedicated artisans who shared her passion.</p>
                        </div>
                        <div class="timeline-item">
                            <h4>2013 - International Recognition</h4>
                            <p>Our signature collection "Éternel" received international acclaim, winning the prestigious Golden Nose Award and establishing Luxury Perfume as a formidable presence in the world of high-end fragrances.</p>
                        </div>
                        <div class="timeline-item">
                            <h4>2016 - Expansion</h4>
                            <p>We opened our flagship boutiques in New York, London, and Tokyo, bringing our artisanal approach to perfumery to discerning clients worldwide. Each location was designed to offer an immersive sensory experience.</p>
                        </div>
                        <div class="timeline-item">
                            <h4>2019 - Sustainable Initiatives</h4>
                            <p>Luxury Perfume launched its "Scents of Earth" initiative, committing to sustainable sourcing practices, eco-friendly packaging, and supporting communities that grow our precious botanical ingredients.</p>
                        </div>
                        <div class="timeline-item">
                            <h4>2022 - Innovation Center</h4>
                            <p>We established the Luxury Perfume Innovation Center, dedicated to researching new extraction techniques and exploring novel fragrance compositions while honoring traditional perfumery practices.</p>
                        </div>
                        <div class="timeline-item">
                            <h4>2025 - Present Day</h4>
                            <p>Today, Luxury Perfume continues to define olfactory excellence with our expanding collections, collaborations with renowned artists, and unwavering commitment to creating fragrances that inspire and delight.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>

    <!-- Our Values -->
    <section class="py-5">
        <div class="container">
            <h2 class="section-title text-center">Our Values</h2>
            <div class="row g-4">
                <c:forEach var="value" items="${companyValues}" varStatus="status">
                    <div class="col-md-4 text-center">
                        <div class="value-icon">
                            <i class="${value.icon}"></i>
                        </div>
                        <h4>${value.title}</h4>
                        <p>${value.description}</p>
                    </div>
                </c:forEach>
                
                <%-- Fallback if no data is provided from the server --%>
                <c:if test="${empty companyValues}">
                    <div class="col-md-4 text-center">
                        <div class="value-icon">
                            <i class="fas fa-gem"></i>
                        </div>
                        <h4>Uncompromising Quality</h4>
                        <p>We source only the finest ingredients and employ rigorous quality control at every stage of creation. Each fragrance undergoes extensive testing to ensure it meets our exacting standards before reaching our customers.</p>
                    </div>
                    <div class="col-md-4 text-center">
                        <div class="value-icon">
                            <i class="fas fa-leaf"></i>
                        </div>
                        <h4>Sustainability</h4>
                        <p>Our commitment to the planet is reflected in our responsible sourcing practices, minimal waste production processes, and eco-conscious packaging. We believe luxury and environmental responsibility can coexist beautifully.</p>
                    </div>
                    <div class="col-md-4 text-center">
                        <div class="value-icon">
                            <i class="fas fa-lightbulb"></i>
                        </div>
                        <h4>Innovation</h4>
                        <p>While respecting traditional perfumery, we continuously explore new frontiers in scent creation. Our perfumers are encouraged to experiment and push boundaries to create truly distinctive fragrances.</p>
                    </div>
                    <div class="col-md-4 text-center">
                        <div class="value-icon">
                            <i class="fas fa-hands-helping"></i>
                        </div>
                        <h4>Community</h4>
                        <p>We maintain close relationships with the communities that grow and harvest our botanical ingredients, ensuring fair compensation and supporting local development initiatives that improve quality of life.</p>
                    </div>
                    <div class="col-md-4 text-center">
                        <div class="value-icon">
                            <i class="fas fa-palette"></i>
                        </div>
                        <h4>Artistry</h4>
                        <p>We view perfumery as an art form. Each fragrance is a creative expression designed to evoke emotions, create memories, and enhance the wearer's personal style statement.</p>
                    </div>
                    <div class="col-md-4 text-center">
                        <div class="value-icon">
                            <i class="fas fa-heart"></i>
                        </div>
                        <h4>Passion</h4>
                        <p>Every member of our team is driven by a genuine passion for perfumery. This enthusiasm infuses every aspect of our work, from conception to the final product in your hands.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Meet the Team -->
    <section class="py-5 bg-light">
        <div class="container">
            <h2 class="section-title text-center">Meet Our Artisans</h2>
            <div class="row g-4">
                
                <%-- Fallback if no data is provided from the server --%>
                <c:if test="${empty teamMembers}">
                    <div class="col-lg-3 col-md-6">
                        <div class="team-member">
                            <div class="image-wrapper">
                                <img src="../img/chrisEvans.jpg" alt="Isabella Laurent">
                            </div>
                            <h4>Nathaniel Brooks</h4>
                            <p class="text-muted">Founder & Master Perfumer</p>
                            <p class="small">With over 25 years of experience, Isabella brings unparalleled expertise and vision to every creation.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="team-member">
                            <div class="image-wrapper">
                                <img src="../img/chrisHems.jpg" alt="Raphael Moreau">
                            </div>
                            <h4>Raphael Moreau</h4>
                            <p class="text-muted">Creative Director</p>
                            <p class="small">Raphael's artistic background brings a unique perspective to our fragrance compositions and brand aesthetic.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="team-member">
                            <div class="image-wrapper">
                                <img src="../img/chrisPratt.jpg" alt="Sophie Chen">
                            </div>
                            <h4>Lucas Harrison</h4>
                            <p class="text-muted">Master Perfumer</p>
                            <p class="small">Trained in Grasse, Sophie's innovative approach has earned her recognition worldwide.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="team-member">
                            <div class="image-wrapper">
                                <img src="../img/robertD.jpg" alt="Marcus Wilson">
                            </div>
                            <h4>Marcus Wilson</h4>
                            <p class="text-muted">Sustainability Director</p>
                            <p class="small">Marcus leads our environmental initiatives, ensuring responsible practices across our operations.</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Testimonials -->
    <section class="py-5">
        <div class="container">
            <h2 class="section-title text-center">What People Say</h2>
            <div class="row g-4">
                <c:forEach var="testimonial" items="${testimonials}" varStatus="status">
                    <div class="col-md-4">
                        <div class="card h-100 testimonial-card">
                            <div class="card-body">
                                <p class="card-text"><i class="fas fa-quote-left me-2 gold-text"></i>${testimonial.content}<i class="fas fa-quote-right ms-2 gold-text"></i></p>
                            </div>
                            <div class="card-footer bg-transparent border-0">
                                <p class="mb-0 fw-bold">${testimonial.name}</p>
                                <small class="text-muted">${testimonial.title}</small>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <%-- Fallback if no data is provided from the server --%>
                <c:if test="${empty testimonials}">
                    <div class="col-md-4">
                        <div class="card h-100 testimonial-card">
                            <div class="card-body">
                                <p class="card-text"><i class="fas fa-quote-left me-2 gold-text"></i>Luxury Perfume's attention to detail is unmatched. Each fragrance feels like it was crafted specifically for me, capturing moments and emotions that last throughout the day.<i class="fas fa-quote-right ms-2 gold-text"></i></p>
                            </div>
                            <div class="card-footer bg-transparent border-0">
                                <p class="mb-0 fw-bold">Emma S.</p>
                                <small class="text-muted">Loyal Customer Since 2015</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card h-100 testimonial-card">
                            <div class="card-body">
                                <p class="card-text"><i class="fas fa-quote-left me-2 gold-text"></i>As a fragrance connoisseur, I've experienced countless perfumes, but what Luxury Perfume creates transcends ordinary scents. Their compositions are like wearable art.<i class="fas fa-quote-right ms-2 gold-text"></i></p>
                            </div>
                            <div class="card-footer bg-transparent border-0">
                                <p class="mb-0 fw-bold">James L.</p>
                                <small class="text-muted">Fragrance Critic</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card h-100 testimonial-card">
                            <div class="card-body">
                                <p class="card-text"><i class="fas fa-quote-left me-2 gold-text"></i>Their commitment to sustainability alongside luxury is refreshing. I appreciate knowing that my favorite perfume is created with respect for the environment and communities involved.<i class="fas fa-quote-right ms-2 gold-text"></i></p>
                            </div>
                            <div class="card-footer bg-transparent border-0">
                                <p class="mb-0 fw-bold">Sophia T.</p>
                                <small class="text-muted">Environmental Advocate</small>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    
    <%@ include file="footer.html" %>
</body>
</html>