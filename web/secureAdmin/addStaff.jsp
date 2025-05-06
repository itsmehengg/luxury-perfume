<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New User</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    
    <div class="container">
        <h1>Add New Staff</h1>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <form action="userServlet" method="post">
            <input type="hidden" name="action" value="create">
            
            <label for="name">Name</label>
            <input type="text" id="name" name="name" required>
            
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
            
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
            
            <label for="phone">Phone Number</label>
            <input type="text" id="phone" name="phone" placeholder="e.g. 123-456-7890">
            
            <label for="gender">Gender</label>
            <select id="gender" name="gender">
                <option value="male">Male</option>
                <option value="female">Female</option>
                <option value="other">Other</option>
            </select>
            
            <label for="role">Role</label>
            <select id="role" name="role">
                <option value="staff">Staff</option>
                <option value="manager">Customer</option>
            </select>
            
            <div class="form-buttons">
                <button type="submit" class="btn submit">Create User</button>
                <a href="userServlet?action=list" class="btn cancel">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>