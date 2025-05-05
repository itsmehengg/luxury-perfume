<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>New Product</title>
  <link rel="stylesheet" href="inculde/style.css">
  <script src="js/product.js"></script>
</head>
<body>
  <%@ include file="sidebar.jsp" %>
  
  <div class="container">
    <h1>New Product</h1>
    <form id="productForm" onsubmit="submitProduct(event)">
      <label for="productName">Name</label>
      <input type="text" id="productName" name="productName" required>

     
      <label for="productDescription">Description</label>
      <textarea id="productDescription" name="productDescription"></textarea>

       <label for="productImage">Image</label>
      <input type="file" id="productImage" name="productImage">
      
      <label for="productPrice">Price</label>
      <input type="number" id="productPrice" name="productPrice" value="0.0" step="0.01">

      <label for="productPrice">Quantity</label>
      <input type="number" id="productQuantity" name="productQuantity" value="0.0" step="0.01">
 
     

      <div class="form-buttons">
        <button type="submit" class="btn submit">Submit</button>
        <a href="product.jsp" class="btn cancel">Cancel</a>
      </div>
    </form>
  </div>
</body>
</html>