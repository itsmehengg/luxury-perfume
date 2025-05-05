<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Products</title>
  <link rel="stylesheet" href="style.css">
  <link rel="stylesheet" href="print.css">
  <script src="js/product.js"></script>
</head>
<body>

  <%@ include file="sidebar.jsp" %>

  <div class="container">
    <h1>History payment</h1>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Payment ID</th>
          <th>Image</th>
          <th>Price</th>
          <th>Quantity</th>
          <th>Date</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td>1</td>
          <td><img src="https://via.placeholder.com/60" alt="MacBook"></td>
          <td>$1099.00</td>
          <td>20</td>
          <td>2024-01-14</td>
          <td>
            <button class="btn edit" onclick="editProduct(31)">Edit</button>
            <button class="btn delete" onclick="deleteProduct(31)">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
    <button class="btn print" onclick="printReport()">Print Report</button>

  </div>

</body>
<script>
  function printReport() {
    window.print();
  }
</script>

</html>