<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfume List</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-4">
            <h2>Perfume List</h2>
            <a href="${pageContext.request.contextPath}/perfume/create" class="btn btn-primary mb-3">Add New Perfume</a>
            
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Brand</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="perfume" items="${perfumes}">
                        <tr>
                            <td>${perfume.id}</td>
                            <td>${perfume.name}</td>
                            <td>${perfume.brand}</td>
                            <td>$${perfume.price}</td>
                            <td>${perfume.stock}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/perfume/edit?id=${perfume.id}" class="btn btn-warning btn-sm">Edit</a>
                                <a href="${pageContext.request.contextPath}/perfume/delete?id=${perfume.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this perfume?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html> 