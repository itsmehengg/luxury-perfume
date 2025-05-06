<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Payment History</title>
  <link rel="stylesheet" href="style.css">
  <link rel="stylesheet" href="print.css">
</head>
<body>

  <%@ include file="sidebar.jsp" %>

  <div class="container">
    <h1>Payment History</h1>
    
    <c:if test="${not empty error}">
      <div class="error-message">${error}</div>
    </c:if>
    
    <div class="action-buttons">
      <a href="historyServlet?action=insertDummy" class="btn create">Insert Dummy Data</a>
      <button class="btn print" onclick="printReport()">Print Report</button>
    </div>
    
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Payment ID</th>
          <th>User</th>
          <th>Image</th>
          <th>Price</th>
          <th>Quantity</th>
          <th>Date</th>
          <th>Total</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="receipt" items="${receipts}">
          <tr>
            <td>${receipt.historyId}</td>
            <td>${receipt.paymentId.paymentId}</td>
            <td>${receipt.userId.name}</td>
            <td>
              <img src="${receipt.productImage}" alt="Product" style="width: 60px; height: 60px; object-fit: cover;">
            </td>
            <td>
              <fmt:formatNumber value="${receipt.productPrice}" type="currency" currencySymbol="$"/>
            </td>
            <td>${receipt.productQuantity}</td>
            <td>
              <fmt:formatDate value="${receipt.paymentDate}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
              <fmt:formatNumber value="${receipt.productPrice * receipt.productQuantity}" type="currency" currencySymbol="$"/>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

</body>
<script>
  function printReport() {
    window.print();
  }
</script>

</html>