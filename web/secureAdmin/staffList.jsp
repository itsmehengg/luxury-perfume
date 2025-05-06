<%@page import="dao.UserDAO"%>
<%@page import="controller.StaffServlet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Model.Users" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Staff Management</title>
  <link rel="stylesheet" href="../style.css">
  <script src="js/product.js"></script>
</head>
<body>

  <%@ include file="sidebar.jsp" %>

  <div class="container">
    <h1>Users Management</h1>
    
    <c:if test="${not empty error}">
      <div class="error-message">${error}</div>
    </c:if>
    
    <a href="addStaff.jsp" class="btn create">Add New Staff</a>
    
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Gender</th>
          <th>Role</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
<%
    UserDAO userDao = new UserDAO();
    List<Users> users = userDao.findAll();
    if (users != null && !users.isEmpty()) {
        for (Users u : users) {
%>
<tr>
    <td><%= u.getUserId() %></td>
    <td><%= u.getName() %></td>
    <td><%= u.getEmail() %></td>
    <td><%= u.getPhone() %></td>
    <td><%= u.getGender() %></td>
    <td><%= u.getRole() %></td>
    <td>
        <a href="StaffServlet?action=edit&id=<%= u.getUserId() %>" class="btn edit">Edit</a>
        <a href="javascript:void(0)" onclick="confirmDelete('<%= u.getUserId() %>')" class="btn delete">Delete</a>
    </td>

</tr>
<%
        }
    } else {
%>
<tr><td colspan="7" class="no-records">No users found.</td></tr>
<%
    }
%>
      </tbody>
    </table>
  </div>
  
  <script>
    function confirmDelete(userId) {
      if (confirm('Are you sure you want to delete this user?')) {
        window.location.href = 'StaffServlet?action=delete&id=' + userId;
      }
    }
  </script>

</body>

</html>