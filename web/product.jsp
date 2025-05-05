<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Products</title>
  <link rel="stylesheet" href="style.css">
  <script src="js/product.js"></script>
</head>
<body>

  <%@ include file="sidebar.jsp" %>

  <div class="container">
    <h1>Products</h1>
    <a href="addProduct.jsp" class="btn create">Create Product</a>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Brand</th>
          <th>Category</th>
          <th>Price</th>
          <th>Image</th>
          <th>Created At</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>31</td>
          <td>MacBook Pro</td>
          <td>Apple</td>
          <td>Computers</td>
          <td>$1099.00</td>
          <td><img src="https://via.placeholder.com/60" alt="MacBook"></td>
          <td>2024-01-14</td>
          <td>
            <button class="btn edit" onclick="editProduct(31)">Edit</button>
            <button class="btn delete" onclick="deleteProduct(31)">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>

</body>
</html>