<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 620px;
            margin: 50px auto;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .form-header {
            background-color: #212529;
            color: white;
            padding: 15px;
            text-align: center;
        }
        .form-body {
            background-color: white;
            padding: 30px;
        }
        .form-label {
            color: #6c757d;
            font-weight: 500;
        }
        .register-btn {
            background-color: #ff5c5c;
            border: none;
            padding: 10px 0;
        }
        .register-btn:hover {
            background-color: #ff3c3c;
        }
        .image-preview {
            max-width: 100%;
            max-height: 200px;
            margin-top: 10px;
            display: none;
        }
        .custom-file-upload {
            border: 2px dashed #ccc;
            display: inline-block;
            width: 100%;
            padding: 30px 0;
            cursor: pointer;
            text-align: center;
            border-radius: 5px;
            transition: all 0.3s;
        }
        .custom-file-upload:hover {
            border-color: #aaa;
        }
        .custom-file-upload i {
            font-size: 24px;
            margin-bottom: 10px;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="form-header">
            <h2>ADD PRODUCT FORM</h2>
        </div>
        <div class="form-body">
            <% String message = (String) request.getAttribute("message"); %>
            <% if (message != null) { %>
                <div class="alert alert-info"><%= message %></div>
            <% } %>
            <!-- Updated form action to use the new servlet -->
            <form method="post" action="NewProductServlet" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="productName" class="form-label">Product Name</label>
                    <input type="text" class="form-control" id="productName" name="productName" required>
                </div>
                
                <div class="mb-3">
                    <label for="productDesc" class="form-label">Product Description</label>
                    <textarea class="form-control" id="productDesc" name="productDesc" rows="3" required></textarea>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Product Image</label>
                    <div class="custom-file-upload" id="imageUploadContainer">
                        <i class="bi bi-cloud-arrow-up"></i>
                        <p>Drag & drop an image or click to browse</p>
                        <input type="file" id="imageUpload" name="productImageUpload" style="display: none;" accept="image/*" onchange="previewImage(this)">
                    </div>
                    <img id="imagePreview" class="image-preview" alt="Image preview">
                    <small class="form-text text-muted">Selected file: <span id="selectedFileName">None</span></small>
                    <!-- Added hidden field to store the path -->
                    <input type="hidden" id="productImagePath" name="productImagePath" value="">
                </div>
                
                <div class="mb-3">
                    <label for="productPrice" class="form-label">Product Price</label>
                    <div class="input-group">
                        <span class="input-group-text">$</span>
                        <input type="number" class="form-control" id="productPrice" name="productPrice" step="0.01" min="0" required>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="productQuantity" class="form-label">Product Quantity</label>
                    <input type="number" class="form-control" id="productQuantity" name="productQuantity" min="0" required>
                </div>
                
                <div class="d-grid">
                    <button type="submit" class="btn btn-lg register-btn text-white">ADD PRODUCT</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    
    <script>
        // Add click event to the custom upload container
        document.getElementById('imageUploadContainer').addEventListener('click', function() {
            document.getElementById('imageUpload').click();
        });
        
        // Preview function for the selected image
        function previewImage(input) {
            var preview = document.getElementById('imagePreview');
            var fileNameDisplay = document.getElementById('selectedFileName');
            var file = input.files[0];
            var reader = new FileReader();
            
            reader.onloadend = function() {
                preview.src = reader.result;
                preview.style.display = 'block';
                fileNameDisplay.textContent = file.name;
                // For a production app, you would upload the file to server here
                // and set the productImagePath to the server path
                document.getElementById('productImagePath').value = file.name;
            }
            
            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.src = '';
                preview.style.display = 'none';
                fileNameDisplay.textContent = 'None';
            }
        }
        
        // Add drag and drop events
        var dropZone = document.getElementById('imageUploadContainer');
        
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            dropZone.addEventListener(eventName, preventDefaults, false);
        });
        
        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }
        
        ['dragenter', 'dragover'].forEach(eventName => {
            dropZone.addEventListener(eventName, highlight, false);
        });
        
        ['dragleave', 'drop'].forEach(eventName => {
            dropZone.addEventListener(eventName, unhighlight, false);
        });
        
        function highlight() {
            dropZone.style.borderColor = '#6c757d';
        }
        
        function unhighlight() {
            dropZone.style.borderColor = '#ccc';
        }
        
        dropZone.addEventListener('drop', handleDrop, false);
        
        function handleDrop(e) {
            var dt = e.dataTransfer;
            var files = dt.files;
            var input = document.getElementById('imageUpload');
            input.files = files;
            previewImage(input);
        }
    </script>
    
    <% Boolean showConfirmation = (Boolean) request.getAttribute("showConfirmation");
        if (showConfirmation != null && showConfirmation) {  %>
        
        <script>
            // Execute after page load
            window.onload = function() {
                // Show confirmation dialog
                var continueAdding = confirm("Product added successfully. Do you want to add another product?");

                // Redirect based on user's choice
                if (!continueAdding) {
                    // If user chooses not to continue, redirect to product management page
                    window.location.href = "secureAdmin/productMenAdmin.jsp";
                }
                // If user chooses to continue, stay on the current page (addProduct.jsp)
            };
        </script>
    <% } %>
</body>
</html>