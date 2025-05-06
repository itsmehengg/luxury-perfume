

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Luxury Perfume</title>
    <link rel="stylesheet" href="../style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .stat-card h3 {
            margin: 0;
            color: #666;
            font-size: 14px;
        }
        
        .stat-card .value {
            font-size: 24px;
            font-weight: bold;
            margin: 10px 0;
            color: #2c3e50;
        }
        
        .stat-card .trend {
            font-size: 12px;
            color: #27ae60;
        }
        
        .stat-card .trend.down {
            color: #e74c3c;
        }
        
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .action-card {
            background: white;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .action-card:hover {
            transform: translateY(-2px);
        }
        
        .action-card i {
            font-size: 24px;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        
        .recent-orders {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .recent-orders h2 {
            margin-top: 0;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    
    <div class="container">
        <h1>Dashboard</h1>
        
        <div class="stats-container">
            <div class="stat-card">
                <h3>Total Sales</h3>
                <div class="value">$24,500</div>
                <div class="trend">↑ 12% from last month</div>
            </div>
            
            <div class="stat-card">
                <h3>Orders Today</h3>
                <div class="value">15</div>
                <div class="trend">↑ 8% from yesterday</div>
            </div>
            
            <div class="stat-card">
                <h3>Products in Stock</h3>
                <div class="value">248</div>
                <div class="trend down">↓ 3% from last week</div>
            </div>
            
            <div class="stat-card">
                <h3>Active Users</h3>
                <div class="value">1,234</div>
                <div class="trend">↑ 5% from last month</div>
            </div>
        </div>
        
        <div class="quick-actions">
            <div class="action-card" onclick="window.location.href='addProduct.jsp'">
                <i class="fas fa-plus-circle"></i>
                <h3>View Product</h3>
            </div>
            
            <div class="action-card" onclick="window.location.href='users.jsp'">
                <i class="fas fa-users"></i>
                <h3>Manage Customer</h3>
            </div>
            <div class="action-card" onclick="window.location.href='staffList.jsp'">
                <i class="fas fa-users"></i>
                <h3>Manage Staff</h3>
            </div>
            
            <div class="action-card" onclick="window.location.href='history.jsp'">
                <i class="fas fa-history"></i>
                <h3>View History</h3>
            </div>
            
            <div class="action-card" onclick="window.print()">
                <i class="fas fa-print"></i>
                <h3>Print Report</h3>
            </div>
        </div>
        
        <div class="recent-orders">
            <h2>Recent Orders</h2>
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Product</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>#12345</td>
                        <td>John Doe</td>
                        <td>Chanel No. 5</td>
                        <td>$299.99</td>
                        <td>Completed</td>
                        <td>2024-05-05</td>
                    </tr>
                    <tr>
                        <td>#12344</td>
                        <td>Jane Smith</td>
                        <td>Dior Sauvage</td>
                        <td>$199.99</td>
                        <td>Processing</td>
                        <td>2024-05-05</td>
                    </tr>
                    <tr>
                        <td>#12343</td>
                        <td>Mike Johnson</td>
                        <td>Tom Ford Black Orchid</td>
                        <td>$399.99</td>
                        <td>Completed</td>
                        <td>2024-05-04</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
