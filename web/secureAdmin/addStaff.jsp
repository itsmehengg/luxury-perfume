<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Staff</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    
    <div class="container">
        <h1>Add Staff</h1>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <!-- Form for adding a staff member -->
        <form action="staffServlet" method="post">
            <input type="hidden" name="action" value="add"> <!-- Action is 'add' to indicate we're adding a new staff member -->
            
            <!-- Staff Name Field -->
            <label for="name">Name</label>
            <input type="text" id="name" name="name" required>
            
            <!-- Staff Password Field -->
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
            
            <!-- Staff Email Field -->
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
            
            <!-- Staff Phone Number Field -->
            <label for="phone">Phone Number</label>
            <input type="text" id="phone" name="phone" placeholder="e.g. 123-456-7890">
            
            <!-- Staff Gender Field -->
            <label for="gender">Gender</label>
            <select id="gender" name="gender">
                <option value="male">Male</option>
                <option value="female">Female</option>
                <option value="other">Other</option>
            </select>
            
            <!-- Staff Role Field (set to 'staff' by default) -->
            <label for="role">Role</label>
            <select id="role" name="role" disabled>
                <option value="staff" selected>Staff</option> <!-- Role is forced to 'staff' -->
            </select>
            
            <div class="form-buttons">
                <!-- Submit button to add the new staff -->
                <button type="submit" class="btn submit">Add Staff</button>
                <!-- Cancel button to go back to the staff list -->
                <a href="staffServlet?action=list" class="btn cancel">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
