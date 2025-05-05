<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Users Management</title>
  <link rel="stylesheet" href="style.css">
  <script src="js/product.js"></script>
</head>
<body>

  <%@ include file="sidebar.jsp" %>

  <div class="container">
    <h1>Users Management</h1>
    
    <c:if test="${not empty error}">
      <div class="error-message">${error}</div>
    </c:if>
    
    <a href="addUser.jsp" class="btn create">Add New User</a>
    
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Gender</th>
          <th>Role</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="user" items="${users}">
          <tr>
            <td>${user.userId}</td>
            <td>${user.name}</td>
            <td>${user.email}</td>
            <td>${user.phone}</td>
            <td>${user.gender}</td>
            <td>${user.role}</td>
            <td>
              <a href="userServlet?action=edit&id=${user.userId}" class="btn edit">Edit</a>
              <a href="javascript:void(0)" onclick="confirmDelete(${user.userId})" class="btn delete">Delete</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
  
  <script>
    function confirmDelete(userId) {
      if (confirm('Are you sure you want to delete this user?')) {
        window.location.href = 'userServlet?action=delete&id=' + userId;
      }
    }
  </script>

</body>

</html>