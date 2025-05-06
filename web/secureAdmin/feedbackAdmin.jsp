<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Feedback Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .feedback-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
        }
        .table-responsive {
            overflow-x: auto;
        }
    </style>
</head>
<body>

    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col">
                <h2><i class="fas fa-comments me-2"></i>Feedback Management</h2>
                <p class="text-muted">View and manage customer feedback</p>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-light">
                <div class="row align-items-center">
                    <div class="col">
                        <h5 class="mb-0">All Feedback</h5>
                    </div>
                    <div class="col-auto">
                        <div class="input-group">
                            <input type="text" class="form-control form-control-sm" id="searchInput" placeholder="Search feedback...">
                            <button class="btn btn-sm btn-outline-secondary" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Product</th>
                                <th>Image</th>
                                <th>User</th>
                                <th>Feedback</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                boolean hasResults = false;
                                
                                try {
                                    // Update these with your database connection details
                                    String dbURL = "jdbc:derby://localhost:1527/asgm";
                                    String dbUser = "nbuser";
                                    String dbPassword = "nbuser";
                                    
                                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                                    
                                    // SQL query to join feedback, products, and users tables
                                    String sql = "SELECT f.feedback_id, f.feedback_prod, f.user_id, f.feedback_desc, " +
                                                    "p.product_id, p.prod_name, p.product_image, u.name AS user_name " +
                                                    "FROM feedback f " +
                                                    "INNER JOIN products p ON f.feedback_prod = p.product_id " +
                                                    "INNER JOIN users u ON f.user_id = u.user_id " +
                                                    "ORDER BY f.feedback_id DESC";

                                    
                                    pstmt = conn.prepareStatement(sql);
                                    rs = pstmt.executeQuery();
                                    
                                    
                                    while (rs.next()) {
                                        hasResults = true;
                                        int feedbackId = rs.getInt("feedback_id");
                                        String productId = rs.getString("product_id");
                                        int userId = rs.getInt("user_id");
                                        String feedback = rs.getString("feedback_prod");
                                        String feedbackDesc = rs.getString("feedback_desc");
                                        String productName = rs.getString("prod_name");
                                        String productImage = rs.getString("product_image");
                                        String userName = rs.getString("user_name");
                                        
                                        // Display each feedback record
                            %>
                                <tr>
                                    <td><%= feedbackId %></td>
                                    <td>
                                        <strong><%= productName %></strong>
                                        <div class="small text-muted">ID: <%= productId %></div>
                                    </td>
                                    <td>
                                        <img src="../imgUpload/<%= productImage %>" alt="<%= productName %>" class="feedback-img border rounded">
                                    </td>
                                    <td>
                                        <%= userName %>
                                        <div class="small text-muted">ID: <%= userId %></div>
                                    </td>
                                    <td>
                                        <div style="max-width: 300px; overflow: hidden; text-overflow: ellipsis;">
                                            <%= feedbackDesc %>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#viewFeedbackModal<%= feedbackId %>">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button type="button" class="btn btn-outline-danger" onclick="deleteFeedback(<%= feedbackId %>)">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                
                                <!-- View Feedback Modal -->
                                <div class="modal fade" id="viewFeedbackModal<%= feedbackId %>" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Feedback Details</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="d-flex mb-3">
                                                    <div class="flex-shrink-0">
                                                        <img src="../imgUpload/<%= productImage %>" alt="<%= productName %>" class="img-thumbnail" style="width: 100px;">
                                                    </div>
                                                    <div class="flex-grow-1 ms-3">
                                                        <h5><%= productName %></h5>
                                                        <p class="text-muted mb-0">Product ID: <%= productId %></p>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <h6>User:</h6>
                                                    <p><%= userName %> (ID: <%= userId %>)</p>
                                                </div>
                                                <div class="mb-3">
                                                    <h6>Feedback:</h6>
                                                    <p><%= feedbackDesc %></p>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-danger" onclick="deleteFeedback(<%= feedbackId %>)" data-bs-dismiss="modal">Delete Feedback</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='6' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                                    e.printStackTrace();
                                } finally {
                                    // Close resources
                                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                
                <!-- No feedback message (shown if table is empty) -->
                <% if (!hasResults) { %>
                    <div class="text-center py-5">
                        <i class="fas fa-comment-slash fa-3x text-muted mb-3"></i>
                        <p class="lead text-muted">No feedback records found</p>
                    </div>
                <% } %>
            </div>
            <div class="card-footer bg-light">
                <nav aria-label="Feedback pagination">
                    <ul class="pagination pagination-sm justify-content-end mb-0">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <!-- Bootstrap JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- JavaScript for search functionality and feedback deletion -->
    <script>
        // Search functionality
        document.getElementById('searchInput').addEventListener('keyup', function() {
            let input = this.value.toLowerCase();
            let rows = document.querySelectorAll('tbody tr');
            
            rows.forEach(row => {
                let text = row.textContent.toLowerCase();
                row.style.display = text.includes(input) ? '' : 'none';
            });
        });
        
        // Delete feedback function
        function deleteFeedback(feedbackId) {
            if (confirm('Are you sure you want to delete this feedback?')) {
                fetch('deleteFeedback.jsp?id=' + feedbackId, {
                    method: 'GET'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        location.reload(); // Refresh to reflect the deleted feedback
                    } else {
                        alert('Failed to delete: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred.');
                });
            }
        }
    
    </script>
</body>
</html>